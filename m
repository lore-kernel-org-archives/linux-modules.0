Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571CC43334
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jun 2022 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiF0QlA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbiF0Qk7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Jun 2022 12:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BA771AF0F
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656348057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bm5BerUfoiEl1O2ScGBnKJYM7RB96X0ZH7CHdfoohVQ=;
        b=Lzm9MzpiWcvCrRGqQMid24Y9TvF6yJI0cuCCCPCVgQNirSHgFODvoPkJb7Wb2yKOVVeSpB
        6ixbpbvM3BZajAIfttj9jO/AsEQMaM/wN9hS66R0EmgBvlG99FX5Jasd8rjXYXTYDXGYaB
        VnyWddjToRYlcjElGqgwgX3DPij9xxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-BCwBpkGOOMaqSge5LAZz_w-1; Mon, 27 Jun 2022 12:40:56 -0400
X-MC-Unique: BCwBpkGOOMaqSge5LAZz_w-1
Received: by mail-wm1-f69.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so7537227wme.4
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bm5BerUfoiEl1O2ScGBnKJYM7RB96X0ZH7CHdfoohVQ=;
        b=6sIzT5dImNAgwJ1zyIEJWSeRX/Gj2gt0v3LQuMkpBSudL2sdluyLIQ5JZi+ZpQ8XOg
         G9tCFvopdEQng4qAmi0dqiTzetfIzH6KiSyO9F3zx42YlRIe4DyXEobBzOe0XZuPT7ZZ
         8Tb0ezKNWBEGAUrBE7lKyWEohFHBO59wp81p/z8/+KR43M1+dLjxRwVVbFzVp3N4cutm
         8swnlDzlzOBYNEjovHJ9ioZdyn8UF41FFuatfE0YX55+jsRLHnq/VUNYbTwp0HEF4ugd
         WF2MzBm5zKE1a0uw8OSPMyzrQ/knDZAGTZ7b0aqxz+pbShX86SyAIOT62thmof7L4Z8j
         TAcw==
X-Gm-Message-State: AJIora9jnqnjH8m2NDVx3KLsAPJEOBYuI9hQ71m1TlLULjozHP69409K
        HRdjie1HmfoTlBZgPsc+NxjlTyn2T0Jfpj1z+GX7H/3KRrv+LuD4PVSPwpnv4hQU/te88xOGYNn
        ZKG6qeQ5TjgpDEeHvGpvvuZMu
X-Received: by 2002:a5d:5984:0:b0:21b:a858:3678 with SMTP id n4-20020a5d5984000000b0021ba8583678mr13362668wri.293.1656348053951;
        Mon, 27 Jun 2022 09:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3azoGZV/tlx2HjM3dU2g6lQctAIxCoVHFIC+LzB4udh0lEsxN0LceVyKpCXQH0D43iOqNAA==
X-Received: by 2002:a5d:5984:0:b0:21b:a858:3678 with SMTP id n4-20020a5d5984000000b0021ba8583678mr13362652wri.293.1656348053763;
        Mon, 27 Jun 2022 09:40:53 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v24-20020a5d5918000000b0021b9870049dsm10762236wrd.82.2022.06.27.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:40:52 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: Modify module_flags() to accept show_state argument
Date:   Mon, 27 Jun 2022 17:40:51 +0100
Message-Id: <20220627164052.2416485-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
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
 kernel/module/internal.h | 2 +-
 kernel/module/main.c     | 8 ++++----
 kernel/module/procfs.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index fed58d30725d..dcb83cf18d84 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2970,7 +2970,7 @@ static void cfi_cleanup(struct module *mod)
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-char *module_flags(struct module *mod, char *buf)
+char *module_flags(struct module *mod, char *buf, bool show_state)
 {
 	int bx = 0;
 
@@ -2981,10 +2981,10 @@ char *module_flags(struct module *mod, char *buf)
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
@@ -3120,7 +3120,7 @@ void print_modules(void)
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

