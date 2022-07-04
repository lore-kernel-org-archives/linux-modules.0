Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443DBC43334
	for <linux-modules@archiver.kernel.org>; Mon,  4 Jul 2022 16:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGDQTV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Jul 2022 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiGDQTG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Jul 2022 12:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B3C0120A8
        for <linux-modules@vger.kernel.org>; Mon,  4 Jul 2022 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656951482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fFo1Gztfi7kgv8mceCsQUHgfH8ojypad3OlaiOUxnPI=;
        b=h60RHDEDDQeRcGALQ4BuKawBSmNvheVzODNvUmpdKnyLi7OMgwreP8gWaiwPmCw/kEMMMv
        1pnh5AR2w/6zz8umLyrfg29QdwZnftTlvZZluCK26qPh+VVkn0oMY19hOGtbyGEV9eGLL5
        Js0IfBfH8C3ivJHaWsqrJcHZEFYrIYU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-CTF45lxRPC-lx3Z1uWhksQ-1; Mon, 04 Jul 2022 12:17:55 -0400
X-MC-Unique: CTF45lxRPC-lx3Z1uWhksQ-1
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so4275901wme.3
        for <linux-modules@vger.kernel.org>; Mon, 04 Jul 2022 09:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFo1Gztfi7kgv8mceCsQUHgfH8ojypad3OlaiOUxnPI=;
        b=4nT4Qh7sJZSlj8ZuHiHkC1JTyTFVKPId8vxe+2kHKp9hrKP7S/tzsWZmQYNIsY/fJf
         fqVpKwxJy1GY0nHhncBxmgXGWhMtgTUsTODcX1xQpbe/4OhmF0Qhh62eVba9KPkwuoSm
         dN7KqzbN1OCo2Id487Fa3gGJQkQV5t0WVjm3zVPh9UPU86Q8eez8zUVao/covYWFQbWT
         zy9m33Ke356/PAjPNbzClnSzJmbIMvNrI8NlkgXjQhGyEDAV8s45kGYBYVMOGoPxZpAU
         N8kWzIfSRXUe2HOsuwKt5OziPHeeuS1ZELpVaDWsMqCELt8LJmjU83+mQ2069iwF/3mr
         0ijw==
X-Gm-Message-State: AJIora+c/bxg+RTiNCUjK+nmx0Q8FoRAUB05aAlA7JAmlOkdbwk2LsQd
        icazmxhcen+djfsHpphyOc2tMBtMT/R8iP+f2EsUdRWDNQdXWJB1FEg7h/uk4jpoyMZ9tIxMfmZ
        OusO4id/6dAzFJgXXlx8zRtmP
X-Received: by 2002:adf:f24c:0:b0:21d:31c5:ecdc with SMTP id b12-20020adff24c000000b0021d31c5ecdcmr24675496wrp.117.1656951474444;
        Mon, 04 Jul 2022 09:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyOteUULtuiy9WslLyjcSRKCS+ZDX9Lyu3zOkbMt/1zDWdYRgY+4fWxBLH6oXO9ryG6ChKLA==
X-Received: by 2002:adf:f24c:0:b0:21d:31c5:ecdc with SMTP id b12-20020adff24c000000b0021d31c5ecdcmr24675458wrp.117.1656951474166;
        Mon, 04 Jul 2022 09:17:54 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0039c4e2ff7cfsm17019931wmq.43.2022.07.04.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:17:53 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com, daniel.thompson@linaro.org, hch@infradead.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
Date:   Mon,  4 Jul 2022 17:17:53 +0100
Message-Id: <20220704161753.4033684-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

To disable preemption in the context of add_kallsyms() is incorrect.

Before kallsyms-specific data is prepared/or set-up, we ensure that
the unformed module is known to be unique i.e. does not already exist
(see load_module()). Therefore, we can fix this by using the common RCU
primitive as this section of code can be safely preempted.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..0b6fd82d5898 100644
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
-			s += strscpy(s,
-				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+			s += strlcpy(s,
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

