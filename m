Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB4C43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiGCMbS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiGCMbR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 08:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7A3F38A8
        for <linux-modules@vger.kernel.org>; Sun,  3 Jul 2022 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656851474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nK4ahcYY0WO5KebMw8df2u7hNaBerN6cj/QjBF2fJk4=;
        b=hBbvjlGD2q4CYPLB5CJyCUU9YKxAfStjwkQykNtDWyhBj42ZVCOcnP5TY9bLv3oBy3bDrE
        BXDK3AOsbY4QKEH85d2BJl4pwAwZC7XJW7pw1V8AxNm4z/Xv3kITmk4q/RA8Wh5QMuIACJ
        gzqWLBI4f303KLVGIR5aPxzAi6YtyKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-R3192b2kNH-8ig2B25gj6g-1; Sun, 03 Jul 2022 08:31:12 -0400
X-MC-Unique: R3192b2kNH-8ig2B25gj6g-1
Received: by mail-wm1-f71.google.com with SMTP id v8-20020a05600c214800b003a1819451b1so3977431wml.7
        for <linux-modules@vger.kernel.org>; Sun, 03 Jul 2022 05:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nK4ahcYY0WO5KebMw8df2u7hNaBerN6cj/QjBF2fJk4=;
        b=8MoqVHtVeS0/fJIyFuGpq7zE0z8eTxz2shq1DELgTil6kuM6tIsb0LMXAShb9kwsJ6
         9IzorL802MD7HxtZr84/TGOmU3mTtikIEJUt7XlCoIB0HNn5YP2SpmE0Y09CDwY7ldO2
         55bG/3DH2IGgrwZwjB5g45RLOKvEnrNFr8inOjusqJCzKGIYceu6mJiwN1GLVus4Cmh2
         B0fmvppnOheuQ61Sl/ghHNnTC0m+7ditVS10JqDCkfc3BBAxtKfSsgraYQG965/M6MHu
         DqSI0VrNLARLG616/ia1E4vrH+lzKkSuH5yMze9iYpDmQFarSPkDpOYWH3Y35L0TFjSn
         ZEnw==
X-Gm-Message-State: AJIora+i5t9JmhsNGpa5xiFHY4qP7ftnuuFT0dO+tJQN2BefwAQ1A55Q
        ZClk3fe+8sCPMK37cWU2LS8ZSprhwvw4au2/4nkRyGXsA97n8lR++1/nDcseSpNPavKNnzFwL4+
        6a6xG9GJXnOkp/xlpvwx2fm6e
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr22092830wrs.567.1656851471635;
        Sun, 03 Jul 2022 05:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swJauhVcRZc5PEe1i4cxgg4inMrv54zzjG82+59GDRFdfcac/oAFteoiFhrNgo5aPGUMZ6nA==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr22092817wrs.567.1656851471447;
        Sun, 03 Jul 2022 05:31:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c47c500b0039c693a54ecsm19314211wmo.23.2022.07.03.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 05:31:10 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com, daniel.thompson@linaro.org, hch@infradead.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: [PATCH] module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
Date:   Sun,  3 Jul 2022 13:31:09 +0100
Message-Id: <20220703123109.3770204-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Looking at add_kallsyms(), there is absolutely no need to explicitly
disable preemption. Before kallsyms-specific data is prepared/or set-up, we
ensure that the unformed module is known to be unique i.e. does not already
exist (see load_module()). Therefore, we can use the common RCU primitive
as this section of code can be pre-empted. In other words, it is safe to be
re-scheduled, in this context.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..b16ff36b4b71 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -174,14 +174,14 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->kallsyms = (void __rcu *)mod->init_layout.base +
 		info->mod_kallsyms_init_off;
 
-	preempt_disable();
+	rcu_read_lock();
 	/* The following is safe since this pointer cannot change */
-	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
-	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	rcu_dereference(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
+	rcu_dereference(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	rcu_dereference_sched(mod->kallsyms)->strtab =
+	rcu_dereference(mod->kallsyms)->strtab =
 		(void *)info->sechdrs[info->index.str].sh_addr;
-	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
+	rcu_dereference(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -190,22 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
-	src = rcu_dereference_sched(mod->kallsyms)->symtab;
-	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
-		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
+	src = rcu_dereference(mod->kallsyms)->symtab;
+	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
+		rcu_dereference(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			mod->core_kallsyms.typetab[ndst] =
-			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
+			    rcu_dereference(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
 			s += strscpy(s,
-				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+				     &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
 				     KSYM_NAME_LEN) + 1;
 		}
 	}
-	preempt_enable();
+	rcu_read_unlock();
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
-- 
2.34.3

