Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F8C00528
	for <linux-modules@archiver.kernel.org>; Tue,  1 Aug 2023 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHAOya (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjHAOy3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Aug 2023 10:54:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0141120
        for <linux-modules@vger.kernel.org>; Tue,  1 Aug 2023 07:54:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BED12FC;
        Tue,  1 Aug 2023 07:55:11 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 170113F5A1;
        Tue,  1 Aug 2023 07:54:26 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>, james.morse@arm.com,
        Adam Johnston <adam.johnston@arm.com>
Subject: [PATCH 2/3] arm64: module: Use module_init_layout_section() to spot init sections
Date:   Tue,  1 Aug 2023 14:54:08 +0000
Message-Id: <20230801145409.8935-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230801145409.8935-1-james.morse@arm.com>
References: <20230801145409.8935-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Today module_frob_arch_sections() spots init sections from their
'init' prefix, and uses this to keep the init PLTs separate from the rest.

module_emit_plt_entry() uses within_module_init() to determine if a
location is in the init text or not, but this depends on whether
core code thought this was an init section.

Naturally the logic is different.

module_init_layout_section() groups the init and exit text together if
module unloading is disabled, as the exit code will never run. The result
is kernels with this configuration can't load all their modules because
there are not enough PLTs for the combined init+exit section.

This results in the following:
| WARNING: CPU: 2 PID: 51 at arch/arm64/kernel/module-plts.c:99 module_emit_plt_entry+0x184/0x1cc
| Modules linked in: crct10dif_common
| CPU: 2 PID: 51 Comm: modprobe Not tainted 6.5.0-rc4-yocto-standard-dirty #15208
| Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
| pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : module_emit_plt_entry+0x184/0x1cc
| lr : module_emit_plt_entry+0x94/0x1cc
| sp : ffffffc0803bba60
[...]
| Call trace:
|  module_emit_plt_entry+0x184/0x1cc
|  apply_relocate_add+0x2bc/0x8e4
|  load_module+0xe34/0x1bd4
|  init_module_from_file+0x84/0xc0
|  __arm64_sys_finit_module+0x1b8/0x27c
|  invoke_syscall.constprop.0+0x5c/0x104
|  do_el0_svc+0x58/0x160
|  el0_svc+0x38/0x110
|  el0t_64_sync_handler+0xc0/0xc4
|  el0t_64_sync+0x190/0x194

A previous patch exposed module_init_layout_section(), use that so the
logic is the same.

Reported-by: Adam Johnston <adam.johnston@arm.com>
Tested-by: Adam Johnston <adam.johnston@arm.com>
Fixes: 055f23b74b20 ("module: check for exit sections in layout_sections() instead of module_init_section()")
Cc: <stable@vger.kernel.org> # 5.15.x: 60a0aab7463ee69 arm64: module-plts: inline linux/moduleloader.h
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: James Morse <james.morse@arm.com>
---
---
 arch/arm64/kernel/module-plts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index ad02058756b5..bd69a4e7cd60 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -339,7 +339,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (nents)
 			sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, rels, numrels,
 						sechdrs[i].sh_info, dstsec);
 		else
-- 
2.39.2

