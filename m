Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E98C77B7D
	for <linux-modules@archiver.kernel.org>; Thu, 18 May 2023 05:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERFxC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 18 May 2023 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERFxB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 18 May 2023 01:53:01 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 22:52:59 PDT
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066510CE
        for <linux-modules@vger.kernel.org>; Wed, 17 May 2023 22:52:59 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward206c.mail.yandex.net (Yandex) with ESMTP id 8937F6954D
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 08:47:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:779c:0:640:7d74:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id C91106005B
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 08:47:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id blVtTnKWu8c0-3FAYXLuL;
        Thu, 18 May 2023 08:47:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684388866;
        bh=ynUfNCxxSoct2DId3riTnuYJQWakG8msv6wWITNg6Sc=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=PVIvP85+QoU3tQ5YYv8s5E6gnCkAZDTUqfkpo/p98nd7ceS7QR+uHurxdRd4NHXit
         eN+Nx7lAZBd59lLq4v78hC/3oEjbikE6Oh1olee0b0r7XJEx6ZVzA0iHhB0WfoVRlj
         52uZ7YglDxzYg1gf+A1c0cdJOKVQ1Mohd5UCPVQM=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section found
Date:   Thu, 18 May 2023 08:47:30 +0300
Message-Id: <20230518054730.11237-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When the module is definitely present but CONFIG_MODVERSIONS is
disabled, the following error message may be somewhat confusing:

modprobe --dump-modversions /path/to/module.ko.xz
modprobe: FATAL: could not get modversions of /path/to/module/ko.xz: No such file or directory

Choosing among the convenient errno values, I would suggest to use ENODATA
when the module lacks a particular ELF section (and vermagic as well).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 libkmod/libkmod-elf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index ef4a8a3..fb2e3d9 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -392,7 +392,7 @@ static int elf_find_section(const struct kmod_elf *elf, const char *section)
 		return i;
 	}
 
-	return -ENOENT;
+	return -ENODATA;
 }
 
 int kmod_elf_get_section(const struct kmod_elf *elf, const char *section, const void **buf, uint64_t *buf_size)
@@ -422,7 +422,7 @@ int kmod_elf_get_section(const struct kmod_elf *elf, const char *section, const
 		return 0;
 	}
 
-	return -ENOENT;
+	return -ENODATA;
 }
 
 /* array will be allocated with strings in a single malloc, just free *array */
@@ -653,7 +653,7 @@ int kmod_elf_strip_vermagic(struct kmod_elf *elf)
 	}
 
 	ELFDBG(elf, "no vermagic found in .modinfo\n");
-	return -ENOENT;
+	return -ENODATA;
 }
 
 
-- 
2.40.1

