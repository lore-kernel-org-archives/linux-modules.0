Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C5CC433F5
	for <linux-modules@archiver.kernel.org>; Mon, 28 Feb 2022 23:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiB1Xoq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiB1Xol (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B26A8FBA4A
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=jMXBTMyBieodkQ8Q4xoeABhYVDgpcxjrEWfYRVnvumd5ZIz4BmzhrBPRb0Nvj0GA5rKggD
        F72R6WVdbVPSQWhZAtzvNNfF31Fbt6x082t5ZBRyIeArOhVid3bv/RfFVZgJPUIVo4e/Si
        E0UdAaWYfNqfsBPG69SS15w72ufrRCs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-MCdYU7BFPp2vXudET0mJSw-1; Mon, 28 Feb 2022 18:43:47 -0500
X-MC-Unique: MCdYU7BFPp2vXudET0mJSw-1
Received: by mail-wr1-f69.google.com with SMTP id ay18-20020a5d6f12000000b001efe36eb038so1135664wrb.17
        for <linux-modules@vger.kernel.org>; Mon, 28 Feb 2022 15:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=Bv1aDYk7Y8zBzHRTcfL/hwK6FDeo7pW22fb/sBk69joGFoREh6Cy2zgCFzpDdqJnWf
         hnW3IvgJsfLMuTg0SSmfoRQERa+JKJZhOMSSww3VWPEdQWEeXsC2aRtcFTjqd4k84FOL
         4KE7l0Mi4zlnVkzPkS6V0MsypGAb6YHqZXsQb/BvJSH1hhfOmcfJbGkHea+ttxQZWp+C
         SPIMZ/zLqdTLRjbUVdusv7Pw23iji/z4MFDr3LULmxrpaXrYLA140G+XoNswJzGU0tRS
         P0w1A1dBUDVH+6qOnbc/zA4lNGyB+/L9DFKA3KmLaeFUQNrS3y6IGsapoMsBe1VHhwiH
         Safw==
X-Gm-Message-State: AOAM532tL5JO95eqZ1oWOSdL7OYR5MS7czsTkTsFo4fnJDmYcpbRerxE
        L6J8jtjjP2MBVKylf8vEcFJRVFQFlUFaNCJtfHK8feuEVgbE6PvDa/4wJWlIehYncZ6Lgy+HNSi
        LzXhMjE82ek9gjEA9wp35hp4R
X-Received: by 2002:adf:e5c1:0:b0:1ed:bf25:b924 with SMTP id a1-20020adfe5c1000000b001edbf25b924mr16853876wrn.136.1646091826497;
        Mon, 28 Feb 2022 15:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8G0j/K/4wCVW0BgGU1xWfpER4AoHHKdVwVoErwge2rAdB5beHRqvNp7GEiuUT3guLZKqvPw==
X-Received: by 2002:adf:e5c1:0:b0:1ed:bf25:b924 with SMTP id a1-20020adfe5c1000000b001edbf25b924mr16853862wrn.136.1646091826312;
        Mon, 28 Feb 2022 15:43:46 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c15c500b003810188b6basm708451wmf.28.2022.02.28.15.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:45 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Date:   Mon, 28 Feb 2022 23:43:18 +0000
Message-Id: <20220228234322.2073104-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

The purpose of this patch is to address the various Sparse warnings
due to the incorrect dereference/or access of an __rcu pointer.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1b0780e20aab..a3da0686a2a6 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -171,14 +171,17 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
 
 	/* Set up to point into init section. */
-	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
+	mod->kallsyms = (void __rcu *)mod->init_layout.base +
+		info->mod_kallsyms_init_off;
 
+	preempt_disable();
 	/* The following is safe since this pointer cannot change */
-	mod->kallsyms->symtab = (void *)symsec->sh_addr;
-	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
+	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
-	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
+	rcu_dereference_sched(mod->kallsyms)->strtab =
+		(void *)info->sechdrs[info->index.str].sh_addr;
+	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -187,20 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
-	src = mod->kallsyms->symtab;
-	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
-		mod->kallsyms->typetab[i] = elf_type(src + i, info);
+	src = rcu_dereference_sched(mod->kallsyms)->symtab;
+	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
+		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			mod->core_kallsyms.typetab[ndst] =
-			    mod->kallsyms->typetab[i];
+			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
+			s += strscpy(s,
+				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
 				     KSYM_NAME_LEN) + 1;
 		}
 	}
+	preempt_enable();
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
@@ -478,11 +483,16 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 
 	mutex_lock(&module_mutex);
 	list_for_each_entry(mod, &modules, list) {
-		/* We hold module_mutex: no need for rcu_dereference_sched */
-		struct mod_kallsyms *kallsyms = mod->kallsyms;
+		struct mod_kallsyms *kallsyms;
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
+
+		/* Use rcu_dereference_sched() to remain compliant with the sparse tool */
+		preempt_disable();
+		kallsyms = rcu_dereference_sched(mod->kallsyms);
+		preempt_enable();
+
 		for (i = 0; i < kallsyms->num_symtab; i++) {
 			const Elf_Sym *sym = &kallsyms->symtab[i];
 
-- 
2.34.1

