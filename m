Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284AFC433F5
	for <linux-modules@archiver.kernel.org>; Mon,  7 Mar 2022 17:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiCGRqi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244498AbiCGRqg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 7 Mar 2022 12:46:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F25D939FE
        for <linux-modules@vger.kernel.org>; Mon,  7 Mar 2022 09:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=WqHsWzqMSAeOi9cPPZrlRCquRMUyvjUwG5nuegtmHh5IRSjj3+II+fLf4W+x+1hwScqP9Z
        JnT1qHCYYS+V0QsA6t/rJdZWfgAfQVOJKRR6cOTMtNMVZL1EvliIZjSzvRu0Vl39B1qRXq
        yxv9im+dZeLjIEF+AcvqWPyP05rZyNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-6XFBqeXPOWmIbmgTwVqqcw-1; Mon, 07 Mar 2022 12:45:33 -0500
X-MC-Unique: 6XFBqeXPOWmIbmgTwVqqcw-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so4805120wri.2
        for <linux-modules@vger.kernel.org>; Mon, 07 Mar 2022 09:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=lOUmASoumI/LaaR6BqqmRdlon7Timu1pzEisBv6pYmvtBESXYyF6jvoJPfkS++wvwL
         hqAi3IuTekjb7pghk+KfWtpRTYLM3tQ+oOmkwWGV+YonhU6ZtliDbvEEFVg0NuLruWH2
         ZFklIIcSQmQZC196PHmCUVUN6QtH6wEn3PVfdpbwIj3X0VeqKTrG5OECVaz4f68q0X87
         jQAF/2O+D784vRijgTIefzVilq40VKkHiVnVKiUGjPEkDLh9XiGJfPHpYPU1kjC9tbqd
         VyFze/F4SZxwExLfCoReuIeBaY1o8dojPL4KJ78CvJO6/ZAaWyApDHqzC2Ugds39svxD
         qS3Q==
X-Gm-Message-State: AOAM531JCqRlYxRmh1TGHmAWWSDexeuPOQxR/HOapAaCMIMzeos1L7fU
        TC/9OKhobOhQodXTo696PPqFmAAowPKVHCrz/Gr01NyfI0K2CzwmVwq3LrZSniuorkd1jIBKfUz
        hCRpBAsFnIhs5LqxNFmkzhjaF
X-Received: by 2002:adf:e50a:0:b0:1f0:224e:fd6f with SMTP id j10-20020adfe50a000000b001f0224efd6fmr9147913wrm.209.1646675131943;
        Mon, 07 Mar 2022 09:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqt7/tblgvqyApiOFuIbVv/e/Pm1i0tYOXmpyi0jdNPGvBzFGoQ+HCrkVXFT+QeBgBJaAlcg==
X-Received: by 2002:adf:e50a:0:b0:1f0:224e:fd6f with SMTP id j10-20020adfe50a000000b001f0224efd6fmr9147883wrm.209.1646675131749;
        Mon, 07 Mar 2022 09:45:31 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f8-20020adfb608000000b0020229d72a4esm567342wre.38.2022.03.07.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:45:31 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 10/14] module: kallsyms: Fix suspicious rcu usage
Date:   Mon,  7 Mar 2022 17:45:05 +0000
Message-Id: <20220307174509.2887714-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
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

