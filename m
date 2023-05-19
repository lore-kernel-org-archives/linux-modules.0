Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E89C77B7A
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 09:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjESJjX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjESJjA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 05:39:00 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2402D2139
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 02:37:45 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3598:0:640:51a7:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 3095C60068;
        Fri, 19 May 2023 12:36:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YaaMCf5W00U0-v9Lm8BrZ;
        Fri, 19 May 2023 12:36:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684489005;
        bh=IRDlm1ruoQ7hcWrP+FCnlS3Ckr8zG7XP7ntANAm50kg=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=a8bmIw+6HBPAD8aczlVA2CqblPeeYcIJ5R9HGLARRThFVni7zv28ku7C1ZC73Ur9d
         9d+84f0/0ZtkWMSQscC0lQFKW/O+hMUagNGRBFUIygkQUtnhpxqohnlzlVoc/7ECn+
         FuTbUnJwVYDXPr9MQfIh/vCYAE3QvJOXqsDmLkGQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] libkmod, depmod: prefer -ENODATA over -ENOENT if no section found
Date:   Fri, 19 May 2023 12:36:30 +0300
Message-Id: <20230519093630.474185-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519072812.400131-1-dmantipov@yandex.ru>
References: <20230519072812.400131-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When the module is definitely present but CONFIG_MODVERSIONS is
disabled, the following error message may be somewhat confusing:

modprobe --dump-modversions /path/to/module.ko.xz
modprobe: FATAL: could not get modversions of /path/to/module.ko.xz: No such file or directory

Choosing among the convenient errno values, I would suggest to use
ENODATA when the module lacks a particular ELF section (and vermagic
as well). So now it is expected to be:

modprobe: FATAL: could not get modversions of /path/to/module.ko.xz: No data available

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 libkmod/libkmod-elf.c | 6 +++---
 tools/depmod.c        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

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
 
 
diff --git a/tools/depmod.c b/tools/depmod.c
index a2c39b3..1d1d41d 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1586,7 +1586,7 @@ static int depmod_load_modules(struct depmod *depmod)
 		struct kmod_list *l, *list = NULL;
 		int err = kmod_module_get_symbols(mod->kmod, &list);
 		if (err < 0) {
-			if (err == -ENOENT)
+			if (err == -ENODATA)
 				DBG("ignoring %s: no symbols\n", mod->path);
 			else
 				ERR("failed to load symbols from %s: %s\n",
-- 
2.40.1

