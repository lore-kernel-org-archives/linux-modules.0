Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14898C43334
	for <linux-modules@archiver.kernel.org>; Thu, 14 Jul 2022 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiGNPjo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiGNPjm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 14 Jul 2022 11:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E86E31903D
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdTH44nst3sD0nXnKIJ6b64daWYUB1e/UFpgOGWaKDE=;
        b=MmA4vD9Ul1BxlU7OBFix6jO7AnjT8Oop8Q+yvIQBBxxegDpvv2cw2uQPCAq68R9D5tWpHv
        lmICIOfyfLg4E7XWrjlUuky4PWa3CzTjkwtpzqfI0UhUvGVmGWxGCX4+Y82WuOjL1wHPwp
        d9LKAFKWHZPw/a2ZlXyCG5OHDOlt2dY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-0SWA6JJgNE-JQyNHJzPVeA-1; Thu, 14 Jul 2022 11:39:38 -0400
X-MC-Unique: 0SWA6JJgNE-JQyNHJzPVeA-1
Received: by mail-wm1-f69.google.com with SMTP id m20-20020a05600c4f5400b003a03aad6bdfso796747wmq.6
        for <linux-modules@vger.kernel.org>; Thu, 14 Jul 2022 08:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdTH44nst3sD0nXnKIJ6b64daWYUB1e/UFpgOGWaKDE=;
        b=VmNec8PvTmcsUJDmggOD/V5q4dIZdzlia9xYUYqMkOxNTMVqksEFdhxYEm3wc1wq2Z
         jP7lB5nxkFY0+5TjRyeUPFdUggxw7iMzlytxLx70ZAwSiTsrN2L2PB8Rj0oAryaHRJiB
         VUzgE8ganmpK+4o9cQFJZzF1yv0zg2jYXp1kQyCU0Uf/VaQ4H0CYpo+vZeizUiTM2yXr
         lh1Aw9tCs/bjFdjC3NAnxrZ16YE4cISWTq3P0X+Wn497UJG+zVI+hOoPR67cP+77Em85
         HfI+ggfO58uzFGw4nrvo2YYND583wtiDiAQDwro3pYMJ1NXfJq0KHEhb3Bm/FgvaeFt+
         kazw==
X-Gm-Message-State: AJIora+vc6qDjwC7QLdbaL5NUY4/Ra03fXPBuUCbzcip/IDZBfolmpCn
        XGbjg2J/XLFlvBjDH6PWM+8nxABoruXalWrE5coGwqv8dceSZscygimoIqDOdTOY0bAfmnwVj/9
        HcHlSeBaLp2wNDDmIDiXCRE41
X-Received: by 2002:a7b:c3d8:0:b0:3a2:fcc8:323 with SMTP id t24-20020a7bc3d8000000b003a2fcc80323mr8807232wmj.132.1657813177400;
        Thu, 14 Jul 2022 08:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v++nxe/HILzUPTol9MJsOq7z9uFWwle2BGD1WmbDuxwTakpTSviO6mtFLYqYSEKeUfbmFKiw==
X-Received: by 2002:a7b:c3d8:0:b0:3a2:fcc8:323 with SMTP id t24-20020a7bc3d8000000b003a2fcc80323mr8807216wmj.132.1657813177237;
        Thu, 14 Jul 2022 08:39:37 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0039c5ab7167dsm5870301wmq.48.2022.07.14.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:39:36 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: [PATCH v2 1/3] module: Modify module_flags() to accept show_state argument
Date:   Thu, 14 Jul 2022 16:39:31 +0100
Message-Id: <20220714153933.2095776-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

With this patch a given module's state information (i.e. 'mod->state')
can be omitted from the specified buffer. Please note that this is in
preparation to include the last unloaded module's taint flag(s),
if available.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h |  2 +-
 kernel/module/main.c     | 11 +++++++----
 kernel/module/procfs.c   |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index bc5507ab8450..60312f23c7d0 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -100,7 +100,7 @@ struct module *find_module_all(const char *name, size_t len, bool even_unformed)
 int cmp_name(const void *name, const void *sym);
 long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
 		       unsigned int section);
-char *module_flags(struct module *mod, char *buf);
+char *module_flags(struct module *mod, char *buf, bool show_state);
 size_t module_flags_taint(unsigned long taints, char *buf);
 
 static inline void module_assert_mutex_or_preempt(void)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..a4d23b0ebbc0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2970,24 +2970,27 @@ static void cfi_cleanup(struct module *mod)
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-char *module_flags(struct module *mod, char *buf)
+char *module_flags(struct module *mod, char *buf, bool show_state)
 {
 	int bx = 0;
 
 	BUG_ON(mod->state == MODULE_STATE_UNFORMED);
+	if (!mod->taints && !show_state)
+		goto out;
 	if (mod->taints ||
 	    mod->state == MODULE_STATE_GOING ||
 	    mod->state == MODULE_STATE_COMING) {
 		buf[bx++] = '(';
 		bx += module_flags_taint(mod->taints, buf + bx);
 		/* Show a - for module-is-being-unloaded */
-		if (mod->state == MODULE_STATE_GOING)
+		if (mod->state == MODULE_STATE_GOING && show_state)
 			buf[bx++] = '-';
 		/* Show a + for module-is-being-loaded */
-		if (mod->state == MODULE_STATE_COMING)
+		if (mod->state == MODULE_STATE_COMING && show_state)
 			buf[bx++] = '+';
 		buf[bx++] = ')';
 	}
+out:
 	buf[bx] = '\0';
 
 	return buf;
@@ -3120,7 +3123,7 @@ void print_modules(void)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
+		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
 	}
 
 	print_unloaded_tainted_modules();
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 9a8f4f0f6329..cf5b9f1e6ec4 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -91,7 +91,7 @@ static int m_show(struct seq_file *m, void *p)
 
 	/* Taints info */
 	if (mod->taints)
-		seq_printf(m, " %s", module_flags(mod, buf));
+		seq_printf(m, " %s", module_flags(mod, buf, true));
 
 	seq_puts(m, "\n");
 	return 0;
-- 
2.34.3

