Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DEDC433E0
	for <linux-modules@archiver.kernel.org>; Thu,  7 Jan 2021 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536CD2343E
	for <linux-modules@archiver.kernel.org>; Thu,  7 Jan 2021 19:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbhAGTOY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Jan 2021 14:14:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:27200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGTOX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Jan 2021 14:14:23 -0500
IronPort-SDR: wrLd4Yj5sSc8+IhRhyM3LsIsY6D8RvG04FQokXVXcyO8pyuGkLfElPxKIc2sTx4nuxjmsWAqjA
 /tr/03F+VdEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="177629730"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="177629730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:13:43 -0800
IronPort-SDR: sI0Jz1gA4ZqfvIujgScgjB2F1JedPYA2u78iDokR8Go984wlBacjd8O7nSyHCI12Om+4bIJHAm
 AQ1RqefVSTfg==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="403128977"
Received: from arunasun-mobl.amr.corp.intel.com (HELO ldmartin-desk1) ([10.209.67.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 11:13:39 -0800
Date:   Thu, 7 Jan 2021 11:13:35 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kmod 28
Message-ID: <20210107191335.722q7im4lvporq3n@ldmartin-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

kmod 28 is out:

         https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-28.tar.xz
         https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-28.tar.sign

- Improvements
	- Add Zstandard to the supported compression formats using libzstd
	  (pass --with-zstd to configure)

- Bug fixes
	- Ignore ill-formed kernel command line, e.g. with "ivrs_acpihid[00:14.5]=AMD0020:0"
	  option in it
	- Fix some memory leaks
	- Fix 0-length builtin.alias.bin: it needs at least the index header

Shortlog is below:

Lucas De Marchi (17):
       gitignore: ignore release files
       gitignore: ignore .cache.mk when building modules
       libkmod: ignore kcmdline option if we fail to parse modname
       testsuite: check for ill-formed kcmdline
       depmod: do not output .bin to stdout
       libkmod: simplify lookup when builtin.modinfo.bin file is missing
       libkmod: fix return error when opening index
       libkmod: allow modules.alias.builtin to be optional
       testsuite: add check for kmod_load_resources
       ci: update travis distro
       ci: remove semaphoreci
       depmod: unconditionally write builtin.alias.bin
       shared: fix UNIQ definition
       testsuite: add test for empty modules.builtin.aliases.bin
       build: fix distcheck due to missing zstd
       build: add comment with rules for libtool version update
       kmod 28

Samanta Navarro (1):
       man: fix typo

Shuo Wang (1):
       NEWS: fix typo

Torge Matthies (2):
       add Zstandard compression support
       testsuite: add test for zstd-compressed module

Yauheni Kaliuta (3):
       libkmod: kmod_builtin_get_modinfo: free modinfo on error
       depmod: output_builtin_alias_bin: free idx on error path
       libkmod: kmod_log_null: qualify ctx argument as const


Thank you all for the contributions.


Lucas De Marchi
