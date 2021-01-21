Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD35C433DB
	for <linux-modules@archiver.kernel.org>; Thu, 21 Jan 2021 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C56F238E8
	for <linux-modules@archiver.kernel.org>; Thu, 21 Jan 2021 04:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbhAUDyw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:54:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:53467 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393401AbhAUCyn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 20 Jan 2021 21:54:43 -0500
IronPort-SDR: Kvb1gwCBQ2TwuUinYaGDmNc5mRaNaJ3x4fKpLKtnGyfe56joX3jydPYbV00JD0iqvU2GQ+mx6O
 LPSX2XYQtA5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="264023102"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="264023102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 18:54:00 -0800
IronPort-SDR: ZOGNQ2v4xfaYt0YrTCB0uD22dVTCuelBkzY8CRTJqquzClP9KD8T8Cb7Ri9sLgY3e/bpIur4NH
 diBr+DOLE7uQ==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="467297345"
Received: from mrmehta1-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.212.37.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 18:53:59 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Subject: [PATCH] README: make github mirror official
Date:   Wed, 20 Jan 2021 18:53:42 -0800
Message-Id: <20210121025342.16405-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

For some time I've been maintaining a read-only mirror on github.
I think it's time to allow patches flowing from there besides the
mailing list: I created a new org to host the project:

	https://github.com/kmod-project/kmod
---
 README    |   4 +-
 README.md | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/README b/README
index b541db9..59eb301 100644
--- a/README
+++ b/README
@@ -7,9 +7,6 @@ Mailing list:
 	linux-modules@vger.kernel.org (no subscription needed)
 	https://lore.kernel.org/linux-modules/
 
-Patchwork:
-	https://patchwork.kernel.org/project/linux-modules/
-
 Signed packages:
 	http://www.kernel.org/pub/linux/utils/kernel/kmod/
 
@@ -20,6 +17,7 @@ Git:
 
 Gitweb:
 	http://git.kernel.org/?p=utils/kernel/kmod/kmod.git
+	https://github.com/kmod-project/kmod
 
 Irc:
 	#kmod on irc.freenode.org
diff --git a/README.md b/README.md
index d3b84bd..a83b4ac 100644
--- a/README.md
+++ b/README.md
@@ -2,4 +2,128 @@
 
 [![Coverity Scan Status](https://scan.coverity.com/projects/2096/badge.svg)](https://scan.coverity.com/projects/2096)
 
-This is a ***mirror only***. Please see [README](../master/README) file for more information.
+
+Information
+===========
+
+Mailing list:
+	linux-modules@vger.kernel.org (no subscription needed)
+	https://lore.kernel.org/linux-modules/
+
+Signed packages:
+	http://www.kernel.org/pub/linux/utils/kernel/kmod/
+
+Git:
+	git://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
+	http://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
+	https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
+
+Gitweb:
+	http://git.kernel.org/?p=utils/kernel/kmod/kmod.git
+	https://github.com/kmod-project/kmod
+
+Irc:
+	#kmod on irc.freenode.org
+
+License:
+	LGPLv2.1+ for libkmod, testsuite and helper libraries
+	GPLv2+ for tools/*
+
+
+OVERVIEW
+========
+
+kmod is a set of tools to handle common tasks with Linux kernel modules like
+insert, remove, list, check properties, resolve dependencies and aliases.
+
+These tools are designed on top of libkmod, a library that is shipped with
+kmod. See libkmod/README for more details on this library and how to use it.
+The aim is to be compatible with tools, configurations and indexes from
+module-init-tools project.
+
+Compilation and installation
+============================
+
+In order to compiler the source code you need following software packages:
+	- GCC compiler
+	- GNU C library
+
+Optional dependencies:
+	- ZLIB library
+	- LZMA library
+
+Typical configuration:
+	./configure CFLAGS="-g -O2" --prefix=/usr \
+			--sysconfdir=/etc --libdir=/usr/lib
+
+Configure automatically searches for all required components and packages.
+
+To compile and install run:
+	make && make install
+
+Hacking
+=======
+
+Run 'autogen.sh' script before configure. If you want to accept the recommended
+flags, you just need to run 'autogen.sh c'. Note that the recommended
+flags require cython be installed to compile successfully.
+
+Make sure to read the CODING-STYLE file and the other READMEs: libkmod/README
+and testsuite/README.
+
+Compatibility with module-init-tools
+====================================
+
+kmod replaces module-init-tools, which is end-of-life. Most of its tools are
+rewritten on top of libkmod so it can be used as a drop in replacements.
+Somethings however were changed. Reasons vary from "the feature was already
+long deprecated on module-init-tools" to "it would be too much trouble to
+support it".
+
+There are several features that are being added in kmod, but we don't
+keep track of them here.
+
+modprobe
+--------
+
+* 'modprobe -l' was marked as deprecated and does not exist anymore
+
+* 'modprobe -t' is gone, together with 'modprobe -l'
+
+* modprobe doesn't parse configuration files with names not ending in
+  '.alias' or '.conf'. modprobe used to warn about these files.
+
+* modprobe doesn't parse 'config' and 'include' commands in configuration
+  files.
+
+* modprobe from m-i-t does not honour softdeps for install commands. E.g.:
+  config:
+
+        install bli "echo bli"
+	install bla "echo bla"
+	softdep bla pre: bli
+
+  With m-i-t, the output of 'modprobe --show-depends bla' will be:
+        install "echo bla"
+
+  While with kmod:
+        install "echo bli"
+        install "echo bla"
+
+* kmod doesn't dump the configuration as is in the config files. Instead it
+  dumps the configuration as it was parsed. Therefore, comments and file names
+  are not dumped, but on the good side we know what the exact configuration
+  kmod is using. We did this because if we only want to know the entire content
+  of configuration files, it's enough to use find(1) in modprobe.d directories
+
+depmod
+------
+
+* there's no 'depmod -m' option: legacy modules.*map files are gone
+
+lsmod
+-----
+
+* module-init-tools used /proc/modules to parse module info. kmod uses
+  /sys/module/*, but there's a fallback to /proc/modules if the latter isn't
+  available
-- 
2.30.0

