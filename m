Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:59452 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaERRAf (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 18 May 2014 13:00:35 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so4489722wes.4
        for <linux-modules@vger.kernel.org>; Sun, 18 May 2014 10:00:34 -0700 (PDT)
MIME-Version: 1.0
From: Lukas Anzinger <l.anzinger@gmail.com>
Date: Sun, 18 May 2014 18:59:53 +0200
Message-ID: <CACB1Aes6O1+Obj3Kp5cesoLbUN3uNKNvmQc1Q=8yQTFqkbtf8g@mail.gmail.com>
Subject: [PATCH] Fix use-after-free in libkmod / depmod fails to deal with symlinks
To: linux-modules@vger.kernel.org
Cc: Lukas Anzinger <l.anzinger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

I found a bug in the hash implementation that is part of libkmod. As a
result depmod fails to deal with modules if they are the *target* of a
symlink. (The symlink must be also part of the directory hierarchy
that depmod parses.)

I.e. the following scenario causes depmod to not handle symbols of
module rtai_sched.ko:

$ cd /lib/modules/$(uname -r)/rtai
$ ls -l rtai_*sched.ko
lrwxrwxrwx 1 root root     13 Apr 30 12:12 rtai_ksched.ko -> rtai_sched.ko
-rw-r--r-- 1 root root 100925 Apr 30 12:12 rtai_sched.ko

The following patch fixes that problem:

>From 4363adddbdd0ac121f9a8ce0082b0f7fa132a1b0 Mon Sep 17 00:00:00 2001
From: Lukas Anzinger <lukas@lukasanzinger.at>
Date: Sun, 18 May 2014 18:40:19 +0200
Subject: [PATCH] Fix use-after-free in hash implementation.

If a value is added to the hash under a key that already exists the new value
replaces the old value for that key. Since key can be a pointer to data that
is part of value and freed by hash->free_value(), the key must be also
replaced and not only the value. Otherwise key potentially points to freed data.
---
 libkmod/libkmod-hash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libkmod/libkmod-hash.c b/libkmod/libkmod-hash.c
index c751d2d..eb7afb7 100644
--- a/libkmod/libkmod-hash.c
+++ b/libkmod/libkmod-hash.c
@@ -169,6 +169,7 @@ int hash_add(struct hash *hash, const char *key,
const void *value)
         if (c == 0) {
             if (hash->free_value)
                 hash->free_value((void *)entry->value);
+            entry->key = key;
             entry->value = value;
             return 0;
         } else if (c < 0) {
-- 
1.9.1

I've also written a blog post that describes the problem in great
detail. If you're interested how I found that bug you might want to
read this article:
https://www.notinventedhere.org/articles/linux/why-implementing-your-own-data-structures-in-c-is-a-bad-idea.html

Regards,

Lukas
