Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E03C433ED
	for <linux-modules@archiver.kernel.org>; Thu, 20 May 2021 23:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805D361363
	for <linux-modules@archiver.kernel.org>; Thu, 20 May 2021 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhETXh1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 20 May 2021 19:37:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:28660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhETXh1 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 20 May 2021 19:37:27 -0400
IronPort-SDR: B15HPJ2YnXvNjsMociBbmj4TyBqebZRjM920M9V0nGZVPF0+j1OK/Cyvet5sQCga9CWWCzdv3P
 o4qEqrea2QkQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="199418108"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="199418108"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:36:05 -0700
IronPort-SDR: PlEz2DB1msu9RjRVEekW6T1was9st6YbLk2OphTDXmwQKxsPoRROe8If3LypwwGaBPobuMyQ6i
 sGSa5nNpz/uw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543814442"
Received: from mkwong-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.254.1.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:36:04 -0700
Date:   Thu, 20 May 2021 16:36:56 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kmod 29
Message-ID: <20210520233656.6begw57aglgfbwri@ldmartin-desk2>
X-Patchwork-Hint: comment
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

kmod 29 is out:

          https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-29.tar.xz
          https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-29.tar.sign

- Improvements
         - Add support to use /usr/local as a place for configuration files. This makes it easier
           to install locally without overriding distro files.

- Bug fixes
         - Fix `modinfo -F` when module is builtin: when we asked by a specific field from modinfo,
           it was not working correctly if the module was builtin

         - Documentation fixes on precedence order of /etc and /run: the correct order is
           /etc/modprobe.d, /run/modprobe.d, /lib/modprobe.d

         - Fix the priority order that we use for searching configuration files. The
           correct one is /etc, /run, /usr/local/lib, /lib, for both modprobe.d
           and depmo.d

         - Fix kernel command line parsing when there are quotes present. Grub
           mangles the command line and changes it from 'module.option="val with
           spaces"' to '"module.option=val with spaces"'. Although this is weird
           behavior and grub could have been fixed, the kernel understands it
           correctly for builtin modules. So change libkmod to also parse it
           correctly. This also brings another hidden behavior from the kernel:
           newline in the kernel command line is also allowed and can be used to
           separate options.

         - Fix a memory leak, overflow and double free on error path

         - Fix documentation for return value from kmod_module_get_info(): we
           return the number of entries we added to the list

         - Fix output of modules.builtin.alias.bin index: we were writing an empty file due to
           the misuse of kmod_module_get_info()

- Infra/internal
         - Retire integration with semaphoreci

         - Declare the github mirror also as an official upstream source: now besides accepting
           patches via mailing list, PRs on github are also acceptable

         - Misc improvements to testsuite, so we can use it reliably regardless
           of the configuration used: now tests will skip if we don't have the
           build dependencies)


Shortlog is below:

Lucas De Marchi (17):
       README: remove leftover from semaphoreci
       libkmod: Fix documentation on config precedence order
       depmod: fix precedence order
       Support /usr/local for configuration files
       README: make github mirror official
       testsuite: compress modules if feature is enabled
       testsuite: also test xz compression
       libkmod-config: revamp kcmdline parsing into a state machine
       libkmod-config: re-quote option from kernel cmdline
       testsuite: allow to re-use single function for tests
       test-modprobe: share single function for kcmdline tests
       libkmod-config: more chars allowed as space
       gitignore: ignore .mbx and .cover for b4 integration
       Fix return value doc for kmod_module_get_info()
       depmod: fix modules.builtin.alias.bin output
       testsuite: update gitignore
       kmod 29

Seung-Woo Kim (3):
       libkmod-config: fix a memory leak when kmod_list_append() fails
       libkmod: fix an overflow with wrong modules.builtin.modinfo
       libkmod: fix possible double free with wrong modules.builtin.modinfo

Marius Bakke (2):
       testsuite: Add facility to skip tests.
       testsuite: Automatically skip tests that fail when sysconfdir != /etc.

Dave Reisner (1):
       populate-modules: Use more bash, more quotes

Marco d'Itri (1):
       Fix "modinfo -F always shows name for built-ins"


Thank you all for the contributions.


Lucas De Marchi
