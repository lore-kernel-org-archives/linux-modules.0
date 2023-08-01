Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC001DF
	for <linux-modules@archiver.kernel.org>; Tue,  1 Aug 2023 14:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHAOyc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjHAOyb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Aug 2023 10:54:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BCB120
        for <linux-modules@vger.kernel.org>; Tue,  1 Aug 2023 07:54:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C4313D5;
        Tue,  1 Aug 2023 07:55:14 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC313F5A1;
        Tue,  1 Aug 2023 07:54:29 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>, james.morse@arm.com,
        Adam Johnston <adam.johnston@arm.com>
Subject: [PATCH 3/3] ARM: module: Use module_init_layout_section() to spot init sections
Date:   Tue,  1 Aug 2023 14:54:09 +0000
Message-Id: <20230801145409.8935-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230801145409.8935-1-james.morse@arm.com>
References: <20230801145409.8935-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Today module_frob_arch_sections() spots init sections from their
'init' prefix, and uses this to keep the init PLTs separate from the rest.

get_module_plt() uses within_module_init() to determine if a
location is in the init text or not, but this depends on whether
core code thought this was an init section.

Naturally the logic is different.

module_init_layout_section() groups the init and exit text together if
module unloading is disabled, as the exit code will never run. The result
is kernels with this configuration can't load all their modules because
there are not enough PLTs for the combined init+exit section.

A previous patch exposed module_init_layout_section(), use that so the
logic is the same.

Fixes: 055f23b74b20 ("module: check for exit sections in layout_sections() instead of module_init_section()")
Cc: stable@vger.kernel.org
Signed-off-by: James Morse <james.morse@arm.com>
---
I've not managed to get 32bit to call get_module_plt(), but it looks
possible to hit the BUG_ON() because of this.
---
 arch/arm/kernel/module-plts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index f5a43fd8c163..da2ee8d6ef1a 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -251,7 +251,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type and symbol index */
 		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
 
-		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, dstsec->sh_addr, rels,
 						numrels, s->sh_info);
 		else
-- 
2.39.2

