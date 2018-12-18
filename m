Return-Path: <SRS0=Oby8=O3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB2C43387
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCFD21871
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLRWMG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:12:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:38253 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeLRWMG (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Dec 2018 17:12:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="119907169"
Received: from ldmartin-desk.jf.intel.com ([10.7.200.65])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2018 14:12:06 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Subject: [PATCH] Add semaphoreci 2.0 configuration
Date:   Tue, 18 Dec 2018 14:11:58 -0800
Message-Id: <20181218221158.1454-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add another CI as alternative to travis-ci. Test on gcc 6, 7 and 8 on
Ubuntu 18.04. Not sure if this is the best way to define the yml file,
but it works.

The old badge doesn't work. It will be added back later.
---
 .semaphore/semaphore.yml | 44 ++++++++++++++++++++++++++++++++++++++++
 README                   |  4 ++--
 README.md                |  1 -
 3 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 .semaphore/semaphore.yml

diff --git a/.semaphore/semaphore.yml b/.semaphore/semaphore.yml
new file mode 100644
index 0000000..62f52b5
--- /dev/null
+++ b/.semaphore/semaphore.yml
@@ -0,0 +1,44 @@
+version: v1.0
+name: Build and Check
+agent:
+  machine:
+    type: e1-standard-2
+    os_image: ubuntu1804
+
+blocks:
+  - name: "Build"
+    task:
+      jobs:
+        - name: Build gcc-8
+          commands:
+            - sem-version c 8
+        - name: Build gcc-7
+          commands:
+            - sem-version c 7
+        - name: Build gcc-6
+          commands:
+            - sem-version c 6
+
+      prologue:
+        commands:
+          - sudo apt --yes install docbook-xsl liblzma-dev zlib1g-dev cython linux-headers-generic
+          - checkout
+
+      epilogue:
+        commands:
+          - ./autogen.sh c
+          - make
+
+  - name: "Unit tests"
+    task:
+      jobs:
+        - name: check
+          commands:
+            - sem-version c 8
+            - ./autogen.sh c
+            - make check
+
+      prologue:
+        commands:
+          - sudo apt --yes install docbook-xsl liblzma-dev zlib1g-dev cython linux-headers-generic
+          - checkout
diff --git a/README b/README
index 414076a..a0226e3 100644
--- a/README
+++ b/README
@@ -3,8 +3,8 @@ kmod - Linux kernel module handling
 Information
 ===========
 
-Build status:
-	[![Build Status](https://semaphoreci.com/api/v1/projects/29d989ba-0f70-4006-be21-550f6692b73b/449920/shields_badge.svg)](https://semaphoreci.com/lucasdemarchi/kmod)
+Build Status:
+	https://lucasdemarchi.semaphoreci.com/projects/kmod
 
 Mailing list:
 	linux-modules@vger.kernel.org (no subscription needed)
diff --git a/README.md b/README.md
index cd4cdc8..d3b84bd 100644
--- a/README.md
+++ b/README.md
@@ -1,6 +1,5 @@
 ## kmod - Linux kernel module handling
 
-[![Build Status](https://semaphoreci.com/api/v1/projects/29d989ba-0f70-4006-be21-550f6692b73b/449920/shields_badge.svg)](https://semaphoreci.com/lucasdemarchi/kmod)<br/>
 [![Coverity Scan Status](https://scan.coverity.com/projects/2096/badge.svg)](https://scan.coverity.com/projects/2096)
 
 This is a ***mirror only***. Please see [README](../master/README) file for more information.
-- 
2.20.0

