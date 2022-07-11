Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B93C433EF
	for <linux-modules@archiver.kernel.org>; Mon, 11 Jul 2022 17:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiGKRR3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 11 Jul 2022 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiGKRR2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 11 Jul 2022 13:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60F3752446
        for <linux-modules@vger.kernel.org>; Mon, 11 Jul 2022 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657559846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5CZMjCHrznhAlDAvMwZi4LrvvAMrjysFI7tqvoFjPg=;
        b=QHuEVeJ3E2HsKTgsIrfib4yRWtfauiey4FK2pibXbpv9qd1/oAel0nZNnYRSiLgiDqaViM
        806eH4N1k5jSKI7yoiGdm96AHabuVk/W0woXoxGRSAH60QtGCk8zVjURirQRUwZwdsBao8
        lw37MSG0EcUQGcm6dFz/BiCXqldTrKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-WGBADxvcPCS5HUJr0pZuUQ-1; Mon, 11 Jul 2022 13:17:25 -0400
X-MC-Unique: WGBADxvcPCS5HUJr0pZuUQ-1
Received: by mail-wm1-f72.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso2977265wmb.0
        for <linux-modules@vger.kernel.org>; Mon, 11 Jul 2022 10:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5CZMjCHrznhAlDAvMwZi4LrvvAMrjysFI7tqvoFjPg=;
        b=SRpBiD4h+KjGR6Pi1Kusn7CC0olsW1OC2A9S0F0IPHRsaSoesLVMMOtAX1VdAp01tL
         iAxH86uH7czzJ3myOYtVNQ2aPfohTje4L0/19oa85n8hZXPurIKMuFfPvPwX/ef8rFA1
         OdPqh7Vk2gT2NOlJW3R3oG8Du8Z0fN3Im2VwwPICVbLvqy0N4p92xhOOMIodmbBHwAIz
         FIz+lYPJQahJc0HqTSTG4y3qMPvjG6CXH8JI/OjThoog4q+moJsA+u5ikgeSJ1kd4VLm
         syX3zlvTmv3MbWkyEwY0RCNDWNpJ3LEXoa/wEw+Yb2wvM8lYbJG/KYTRKhfaSnSk2BUp
         l/VA==
X-Gm-Message-State: AJIora9Hx+tcKLtdhvu76iEdiaodFjyd3d7xICvINtI6XxU7qWM4GOYu
        cIAUDpqNt+wGRT1LLdpllvnnybkasC0ksCwDz6JYSAHaA9KgQ/4lOKYmMyFSI8xAaOT9omecbn0
        1SBMjgObLWLrIv4ktDcJV7Ul7
X-Received: by 2002:a05:600c:4f95:b0:3a1:7310:62d8 with SMTP id n21-20020a05600c4f9500b003a1731062d8mr16840457wmq.16.1657559844282;
        Mon, 11 Jul 2022 10:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0iG5UhoXyDbYSBqO1pe6N4iA2WYxaZ6drqDo17YFm0K4RwhjlO/+3C4clOQZfwzUOTD1sGA==
X-Received: by 2002:a05:600c:4f95:b0:3a1:7310:62d8 with SMTP id n21-20020a05600c4f9500b003a1731062d8mr16840422wmq.16.1657559844102;
        Mon, 11 Jul 2022 10:17:24 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b003a04d19dab3sm26356809wmg.3.2022.07.11.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:17:22 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com, daniel.thompson@linaro.org, hch@infradead.org,
        tglx@linutronix.de, adrian.hunter@intel.com,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v3 -next 1/1] module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
Date:   Mon, 11 Jul 2022 18:17:19 +0100
Message-Id: <20220711171719.1244255-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711171719.1244255-1-atomlin@redhat.com>
References: <20220711171719.1244255-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The commit 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
under PREEMPT_RT=y, disabling preemption introduced an unbounded
latency since the loop is not fixed. This change caused a regression
since previously preemption was not disabled and we would dereference
RCU-protected pointers explicitly. That being said, these pointers
cannot change.

Before kallsyms-specific data is prepared/or set-up, we ensure that
the unformed module is known to be unique i.e. does not already exist
(see load_module()). Therefore, we can fix this by using the common and
more appropriate RCU flavour as this section of code can be safely
preempted.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 18c23545b984..77e75bead569 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -176,14 +176,14 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
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
@@ -193,20 +193,20 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
 	strtab_size = info->core_typeoffs - info->stroffs;
-	src = rcu_dereference_sched(mod->kallsyms)->symtab;
-	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
-		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
+	src = rcu_dereference(mod->kallsyms)->symtab;
+	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
+		rcu_dereference(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			ssize_t ret;
 
 			mod->core_kallsyms.typetab[ndst] =
-			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
+			    rcu_dereference(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
 			ret = strscpy(s,
-				      &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+				      &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
 				      strtab_size);
 			if (ret < 0)
 				break;
@@ -214,7 +214,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 			strtab_size -= ret + 1;
 		}
 	}
-	preempt_enable();
+	rcu_read_unlock();
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
-- 
2.34.3

