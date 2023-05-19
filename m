Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335DC77B7F
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 07:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjESHvF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 03:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjESHtr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 03:49:47 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3EE173B
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 00:48:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3487:0:640:5432:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id AEDFF46CD4;
        Fri, 19 May 2023 10:46:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id dkYEL2aDbqM0-GZ4TWHY5;
        Fri, 19 May 2023 10:46:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684482405;
        bh=sv5sz4k/0Yx2Lju/0SPn04AZdWP4aizLP37LjeN99L8=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ADP8+JKAZkgm4606bdO2v/5ClhqgnvhNfBlFIf6FmKRUilhXYkSv+cIg/zTICQ7j2
         N5TepnXUZkFcEDLJqC24+LBqED24V2hmcXI5lufEhl3Y9sMw9Gpf1TgG0odbz0IZf4
         O/GKiYMyyYYbFL8fUGg7QA9I9EpFDaGTZhQMPVkE=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] libkmod: fix possible out-of-bounds memory access
Date:   Fri, 19 May 2023 10:46:38 +0300
Message-Id: <20230519074638.402045-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f95eccca-3eac-5213-6a33-c9ebf1121a7d@csgroup.eu>
References: <f95eccca-3eac-5213-6a33-c9ebf1121a7d@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

An attempt to pass too long module name to, say, rmmod, may
cause an out-of-bounds memory access (as repoted by UBSan):

$ rmmod $(for i in $(seq 0 4200); do echo -ne x; done)
libkmod/libkmod-module.c:1828:8: runtime error: index 4107 out of bounds for type 'char [4096]'

This is because 'snprintf(path, sizeof(path), ...)' may return the
value which exceeds 'sizeof(path)' (which happens when an output
gets truncated). To play it safe, such a suspicious output is
better to be rejected explicitly.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 libkmod/libkmod-module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1da64b3..7736b7e 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1810,6 +1810,10 @@ KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
 
 	pathlen = snprintf(path, sizeof(path),
 				"/sys/module/%s/initstate", mod->name);
+	if (pathlen >= (int)sizeof(path)) {
+		/* Too long path was truncated */
+		return -ENAMETOOLONG;
+	}
 	fd = open(path, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
 		err = -errno;
-- 
2.40.1

