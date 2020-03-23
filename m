Return-Path: <SRS0=Fs8F=5I=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06250C10DCE
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00D2073C
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCWTlh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:41:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:64875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCWTlh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Mar 2020 15:41:37 -0400
IronPort-SDR: xjxzVe93ikLEIXcZE1LiS9ADQPMGZ6Fb6OFxBqfK111GlmeHu1nnJhFd/t03IvNfdRKAph7Xgm
 HdPw79/AKfGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:41:34 -0700
IronPort-SDR: clZcuc2wIc/l/fy79YtuyE7E57W7O2HWkNLIvKvC4jmnhNnDjPfUPGCxqnN8cn+6dU7MGiDdKU
 lLAlObAuLXxQ==
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="235319579"
Received: from sganes3-mobl1.amr.corp.intel.com (HELO ldmartin-desk1) ([10.134.73.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:41:34 -0700
Date:   Mon, 23 Mar 2020 12:41:32 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com
Subject: Re: [PATCH 0/6] Fix modules.builtin.alias handling
Message-ID: <20200323194132.tlcbkyvfb7k3vgnm@ldmartin-desk1>
X-Patchwork-Hint: ignore
References: <20200310050029.27678-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200310050029.27678-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

All patches here applied.

Lucas De Marchi

On Mon, Mar 09, 2020 at 10:00:23PM -0700, Lucas De Marchi wrote:
>This should fix 2 bugs reported last week:
>
>- `depmod -n` failing. Like for other binary indexes we just
>  skip now
>
>- programs like lspci failing since they don't ignore errors from
>  kmod_load_resources() - the new modules.builtin.alias.bin may not
>  exist if depmod from kmod 27 wasn't executed for that kernel version.
>  Also modules.builtin.modinfo (from where the former is extracted) is
>  only available on recent kernel versions. So make this index optional
>  for kmod_load_resources() - other parts of the code already assume
>  it's optional
>
>Lucas De Marchi (6):
>  gitignore: ignore .cache.mk when building modules
>  depmod: do not output .bin to stdout
>  libkmod: simplify lookup when builtin.modinfo.bin file is missing
>  libkmod: fix return error when opening index
>  libkmod: allow modules.alias.builtin to be optional
>  testsuite: add check for kmod_load_resources
>
> libkmod/libkmod-index.c                       |  31 ++++++-----
> libkmod/libkmod-index.h                       |   4 +-
> libkmod/libkmod-module.c                      |   8 +--
> libkmod/libkmod.c                             |  50 ++++++++++--------
> testsuite/module-playground/.gitignore        |   1 +
> .../lib/modules/5.6.0/modules.alias           |   1 +
> .../lib/modules/5.6.0/modules.alias.bin       | Bin 0 -> 12 bytes
> .../lib/modules/5.6.0/modules.builtin         |   1 +
> .../lib/modules/5.6.0/modules.builtin.bin     | Bin 0 -> 39 bytes
> .../lib/modules/5.6.0/modules.dep             |   0
> .../lib/modules/5.6.0/modules.dep.bin         | Bin 0 -> 12 bytes
> .../lib/modules/5.6.0/modules.devname         |   1 +
> .../lib/modules/5.6.0/modules.softdep         |   1 +
> .../lib/modules/5.6.0/modules.symbols         |   1 +
> .../lib/modules/5.6.0/modules.symbols.bin     | Bin 0 -> 12 bytes
> testsuite/test-init.c                         |  31 +++++++++++
> tools/depmod.c                                |   6 ++-
> 17 files changed, 95 insertions(+), 41 deletions(-)
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.alias.bin
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.builtin.bin
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.dep.bin
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.devname
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.softdep
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols
> create mode 100644 testsuite/rootfs-pristine/test-init-load-resources/lib/modules/5.6.0/modules.symbols.bin
>
>-- 
>2.25.1
>
