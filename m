Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E718C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 10 Mar 2022 10:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiCJK0F (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiCJKZy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DA8813FAD0
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=Ol+dx7PX/Y5UP36sbIGIy64bGW4Cmc92MVFxbItJJqZHwCNWXlsSVxzmsm4jYqvDrrMIuZ
        6oZQ1zNwLCdt3gp3saD2Z/ED6sKRyThMO3eETPyTY9bNPQtHJf67GkiEqNi5g9LWwQvHh1
        Nd6MEOP1bKaPW7BXSKdtbxlPffpmHhM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-7_6m_TsWMfWvMSC7Mqtlmg-1; Thu, 10 Mar 2022 05:24:38 -0500
X-MC-Unique: 7_6m_TsWMfWvMSC7Mqtlmg-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so1520297wrg.20
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=ZZtGS6uGuWb5ne7Uo4vvrdsK2w8UBH+TdB672dYvXU1zCUFt9NaZbImC0blT/5Ch1C
         uZqxZVMMtN3qvMOwl2LOtuYt89iW+jPsPxUbpIVQeKg8gd56dh37kflhlDUtWGLLYH6s
         lzP09a8EFOCW9l6FGBRguq+XUZluu4xITTaP4LVnA29m1u1+fmbCYtVxqzKAhWxf53a5
         VqY77dlfjEYHlw5Drd8ABiUzCATug5LQBX+sokbImAdvvfFhxcEttNnyaBxzxjS7FBua
         WnB2CGTwKMHrmcZcBv57/ok+ptRkp1m0F7ssgDFHkan0Q896mQeHQbS/vTPzPtmJQ6El
         v+SA==
X-Gm-Message-State: AOAM533X6nPdzN8Gu7jlNu9FfCx9Pwk5n/beynlPSmk+pgCH9jiwdG8M
        FMjSl5V0VuVNTLgMtHR8n0dz9MsVYWKszPWQMTCTGQvZi1dWEhQgLinq0e4ODZnz2m76J+8aKTe
        AsJo/0nWpkPDimgG5On2LCV+I
X-Received: by 2002:a7b:c042:0:b0:389:7336:158b with SMTP id u2-20020a7bc042000000b003897336158bmr3045324wmc.15.1646907877387;
        Thu, 10 Mar 2022 02:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx01aIrs4KFuIC/5aueOsdBG7PjrtS7tvpyYmay+Iosl72wx4vqlYpsXiaj3n029JTvSNP8Yw==
X-Received: by 2002:a7b:c042:0:b0:389:7336:158b with SMTP id u2-20020a7bc042000000b003897336158bmr3045306wmc.15.1646907877206;
        Thu, 10 Mar 2022 02:24:37 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm4850329wmq.48.2022.03.10.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:24:36 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 10/14] module: kallsyms: Fix suspicious rcu usage
Date:   Thu, 10 Mar 2022 10:24:09 +0000
Message-Id: <20220310102413.3438665-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102413.3438665-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
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

