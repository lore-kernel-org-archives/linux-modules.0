Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A6C001DF
	for <linux-modules@archiver.kernel.org>; Wed,  2 Aug 2023 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHBRAr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHBRAq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 2 Aug 2023 13:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01601981
        for <linux-modules@vger.kernel.org>; Wed,  2 Aug 2023 10:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2769E61479
        for <linux-modules@vger.kernel.org>; Wed,  2 Aug 2023 17:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C1EC433C8;
        Wed,  2 Aug 2023 17:00:42 +0000 (UTC)
Date:   Wed, 2 Aug 2023 18:00:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Adam Johnston <adam.johnston@arm.com>
Subject: Re: [PATCH 2/3] arm64: module: Use module_init_layout_section() to
 spot init sections
Message-ID: <ZMqLuE9jSPi+RbGd@arm.com>
References: <20230801145409.8935-1-james.morse@arm.com>
 <20230801145409.8935-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801145409.8935-3-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 01, 2023 at 02:54:08PM +0000, James Morse wrote:
> Today module_frob_arch_sections() spots init sections from their
> 'init' prefix, and uses this to keep the init PLTs separate from the rest.
> 
> module_emit_plt_entry() uses within_module_init() to determine if a
> location is in the init text or not, but this depends on whether
> core code thought this was an init section.
> 
> Naturally the logic is different.
> 
> module_init_layout_section() groups the init and exit text together if
> module unloading is disabled, as the exit code will never run. The result
> is kernels with this configuration can't load all their modules because
> there are not enough PLTs for the combined init+exit section.
> 
> This results in the following:
> | WARNING: CPU: 2 PID: 51 at arch/arm64/kernel/module-plts.c:99 module_emit_plt_entry+0x184/0x1cc
> | Modules linked in: crct10dif_common
> | CPU: 2 PID: 51 Comm: modprobe Not tainted 6.5.0-rc4-yocto-standard-dirty #15208
> | Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> | pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : module_emit_plt_entry+0x184/0x1cc
> | lr : module_emit_plt_entry+0x94/0x1cc
> | sp : ffffffc0803bba60
> [...]
> | Call trace:
> |  module_emit_plt_entry+0x184/0x1cc
> |  apply_relocate_add+0x2bc/0x8e4
> |  load_module+0xe34/0x1bd4
> |  init_module_from_file+0x84/0xc0
> |  __arm64_sys_finit_module+0x1b8/0x27c
> |  invoke_syscall.constprop.0+0x5c/0x104
> |  do_el0_svc+0x58/0x160
> |  el0_svc+0x38/0x110
> |  el0t_64_sync_handler+0xc0/0xc4
> |  el0t_64_sync+0x190/0x194
> 
> A previous patch exposed module_init_layout_section(), use that so the
> logic is the same.
> 
> Reported-by: Adam Johnston <adam.johnston@arm.com>
> Tested-by: Adam Johnston <adam.johnston@arm.com>
> Fixes: 055f23b74b20 ("module: check for exit sections in layout_sections() instead of module_init_section()")
> Cc: <stable@vger.kernel.org> # 5.15.x: 60a0aab7463ee69 arm64: module-plts: inline linux/moduleloader.h
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
