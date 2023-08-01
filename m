Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0251C001DF
	for <linux-modules@archiver.kernel.org>; Tue,  1 Aug 2023 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHAOyZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjHAOyZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 1 Aug 2023 10:54:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E81E5120
        for <linux-modules@vger.kernel.org>; Tue,  1 Aug 2023 07:54:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A1A3D75;
        Tue,  1 Aug 2023 07:55:06 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 633EF3F5A1;
        Tue,  1 Aug 2023 07:54:21 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jessica Yu <jeyu@kernel.org>, james.morse@arm.com,
        Adam Johnston <adam.johnston@arm.com>
Subject: [PATCH 0/3] ARM/arm64: Fix loading of modules with an exit section
Date:   Tue,  1 Aug 2023 14:54:06 +0000
Message-Id: <20230801145409.8935-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Adam reports that Yocto can't load modules on arm64. This turns out to be due
to the arch code disagreeing with the core code when it comes to the layout
of the modules exit text, resulting in a shortage of PLTs and a bunch of
warnings.

arm and arm64 are unusual here as they are counting the PLTs based on the
section name. This series exposes the helper that core code uses to decide
the layout.

I've been unable to reproduce the behaviour on 32bit - but it looks like
its possible to reach the BUG_ON() in get_module_plt(). To test this, disable
CONFIG_MODULE_UNLOAD, and try to load modules with relocations in their exit
text.

This series is based on v6.5-rc4, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git arm64/modules/exit_sections/v1

Thanks,

James Morse (3):
  module: Expose module_init_layout_section()
  arm64: module: Use module_init_layout_section() to spot init sections
  ARM: module: Use module_init_layout_section() to spot init sections

 arch/arm/kernel/module-plts.c   | 2 +-
 arch/arm64/kernel/module-plts.c | 2 +-
 include/linux/moduleloader.h    | 5 +++++
 kernel/module/main.c            | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.39.2

