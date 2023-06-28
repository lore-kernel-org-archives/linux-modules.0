Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE166EB64D7
	for <linux-modules@archiver.kernel.org>; Wed, 28 Jun 2023 18:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjF1Spu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 28 Jun 2023 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjF1Spn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 28 Jun 2023 14:45:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EA1FE7
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xaLcQEqMH01VmOUWHUkUETJhqPWldXfRX2UjvvkvAF0=; b=AkDc/0BRmjFXlbcx0XoUfSU60M
        kzOvJBbCXozwulCljLs1EIRxlroRDywesUgqeEdBcl5fEPlCZ73s96yhbsW424yF9rJadGBAKziv0
        LFe7wfcozqGZTJD9aBd430gXWIu8rZZ+2LKWxz6lokTZcujgwuirkUlb3xhg8vF2nXBAKsF8kSTXa
        pWWLDU6Mqi9lMYYGr97HdMQJVV74QE62KTdMpTDfAb5O0xXHs1XJFgQYQrRt7HZv7ouaaaRlGsFFX
        G0kEfKXCfaqYBm5T9OCVOP7Ag8FClDCiPZGr0UT716HRnC+pNJbrpcYDxdJ9or7irg6/pzIJcnSah
        56u+I9RA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEaAa-00GQT4-0F;
        Wed, 28 Jun 2023 18:45:36 +0000
Date:   Wed, 28 Jun 2023 11:45:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-modules@vger.kernel.org, maninder1.s@samsung.com,
        thunder.leizhen@huawei.com, onkarnath.1@samsung.com,
        keescook@chromium.org, arnd@arndb.de, bigeasy@linutronix.de,
        mcgrof@kernel.org
Subject: [GIT PULL] Modules for v6.5-rc1
Message-ID: <ZJx/0HbObiC9kMAH@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The following changes since commit d36f6efbe0cb422fe1e4475717d75f3737088832:

  module: Fix use-after-free bug in read_file_mod_stats() (2023-05-22 14:13:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/v6.5-rc1-modules-next

for you to fetch changes up to 0eeaf1eb40a34fddd1d568a9b32c3d6669238743:

  kallsyms: make kallsyms_show_value() as generic function (2023-06-08 12:27:20 -0700)

----------------------------------------------------------------
v6.5-rc1-modules-next

The changes queued up for v6.5-rc1 for modules are pretty tame, mostly
code removal of moving of code. Only two minor functional changes are
made, the only one which stands out is Sebastian Andrzej Siewior's
simplification of module reference counting by removing preempt_disable()
and that has been tested on linux-next for well over a month without
no regressions. I'm now, I guess, also a kitchen sink for some kallsyms
changes.

----------------------------------------------------------------
Arnd Bergmann (1):
      kallsyms: remove unused arch_get_kallsym() helper

Maninder Singh (3):
      kallsyms: remove unsed API lookup_symbol_attrs
      kallsyms: move kallsyms_show_value() out of kallsyms.c
      kallsyms: make kallsyms_show_value() as generic function

Sebastian Andrzej Siewior (1):
      module: Remove preempt_disable() from module reference counting.

 include/linux/kallsyms.h                          | 17 +----
 include/linux/module.h                            |  9 ---
 kernel/Makefile                                   |  2 +-
 kernel/kallsyms.c                                 | 91 +----------------------
 kernel/ksyms_common.c                             | 43 +++++++++++
 kernel/module/kallsyms.c                          | 28 -------
 kernel/module/main.c                              |  7 --
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c |  4 +-
 8 files changed, 49 insertions(+), 152 deletions(-)
 create mode 100644 kernel/ksyms_common.c
