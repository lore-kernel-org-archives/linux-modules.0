Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14165C001E0
	for <linux-modules@archiver.kernel.org>; Tue,  1 Aug 2023 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjHAOy2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHAOy1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Aug 2023 10:54:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BAD9120
        for <linux-modules@vger.kernel.org>; Tue,  1 Aug 2023 07:54:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93BC01063;
        Tue,  1 Aug 2023 07:55:09 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE21C3F5A1;
        Tue,  1 Aug 2023 07:54:24 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>, james.morse@arm.com,
        Adam Johnston <adam.johnston@arm.com>
Subject: [PATCH 1/3] module: Expose module_init_layout_section()
Date:   Tue,  1 Aug 2023 14:54:07 +0000
Message-Id: <20230801145409.8935-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230801145409.8935-1-james.morse@arm.com>
References: <20230801145409.8935-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

module_init_layout_section() choses whether the core module loader
considers a section as init or not. This affects the placement of the
exit section when module unloading is disabled. This code will never run,
so it can be free()d once the module has been initialised.

arm and arm64 need to count the number of PLTs they need before applying
relocations based on the section name. The init PLTs are stored separately
so they can be free()d. arm and arm64 both use within_module_init() to
decide which list of PLTs to use when applying the relocation.

Because within_module_init()'s behaviour changes when module unloading
is disabled, both architecture would need to take this into account when
counting the PLTs.

Today neither architecture does this, meaning when module unloading is
disabled there are insufficient PLTs in the init section to load some
modules, resulting in warnings:
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

Instead of duplicating module_init_layout_section()s logic, expose it.

Reported-by: Adam Johnston <adam.johnston@arm.com>
Fixes: 055f23b74b20 ("module: check for exit sections in layout_sections() instead of module_init_section()")
Cc: stable@vger.kernel.org
Signed-off-by: James Morse <james.morse@arm.com>
---
Adam has seen this in Yocto using the v6.1 stable kernel
---
 include/linux/moduleloader.h | 5 +++++
 kernel/module/main.c         | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 03be088fb439..001b2ce83832 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -42,6 +42,11 @@ bool module_init_section(const char *name);
  */
 bool module_exit_section(const char *name);
 
+/* Describes whether within_module_init() will consider this an init section
+ * or not. This behaviour changes with CONFIG_MODULE_UNLOAD.
+ */
+bool module_init_layout_section(const char *sname);
+
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
  * or 0.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 59b1d067e528..ff7cc4e29299 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1484,7 +1484,7 @@ long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
 	return offset | mask;
 }
 
-static bool module_init_layout_section(const char *sname)
+bool module_init_layout_section(const char *sname)
 {
 #ifndef CONFIG_MODULE_UNLOAD
 	if (module_exit_section(sname))
-- 
2.39.2

