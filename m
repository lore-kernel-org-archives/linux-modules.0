Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B3C10F12
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1049123121
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbhASPFQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:05:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:39971 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391697AbhASOzX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Jan 2021 09:55:23 -0500
IronPort-SDR: 0YUn7F61nsEQaJoh29Es5yjl3e2Ib339lGQHJ6OFUKVaGRd5GvTkllKpFB95BVnjL9s2MQUyX8
 3QIlQaKwGL0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179023520"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208,217";a="179023520"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:20 -0800
IronPort-SDR: 4Ika1PSKCAtE4RxATFNUHrhnx6BQfG3g9gnjLNZJ/n/cKDTXhe61jAUBspzcAp4ewhns3kznvn
 w2tgDLZTJVRA==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208,217";a="365772519"
Received: from caophong-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.166.105])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:18 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jan Tojnar <jtojnar@gmail.com>
Subject: [PATCH 1/3] libkmod: Fix documentation on config precedence order
Date:   Tue, 19 Jan 2021 06:52:36 -0800
Message-Id: <20210119145238.12774-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

/etc is has higher priority than /run.
---
 libkmod/libkmod.c  | 2 +-
 man/depmod.d.xml   | 2 +-
 man/modprobe.d.xml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 43423d6..25655b9 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -235,7 +235,7 @@ static char *get_kernel_release(const char *dirname)
  * @config_paths: ordered array of paths (directories or files) where
  *                to load from user-defined configuration parameters such as
  *                alias, blacklists, commands (install, remove). If
- *                NULL defaults to /run/modprobe.d, /etc/modprobe.d and
+ *                NULL defaults to /etc/modprobe.d, /run/modprobe.d and
  *                /lib/modprobe.d. Give an empty vector if configuration should
  *                not be read. This array must be null terminated.
  *
diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 4341a56..6472bda 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -40,8 +40,8 @@
 
   <refsynopsisdiv>
     <para><filename>/usr/lib/depmod.d/*.conf</filename></para>
-    <para><filename>/etc/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
+    <para><filename>/etc/depmod.d/*.conf</filename></para>
   </refsynopsisdiv>
 
   <refsect1><title>DESCRIPTION</title>
diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 211af84..a674d69 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -41,8 +41,8 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/modprobe.d/*.conf</filename></para>
-    <para><filename>/etc/modprobe.d/*.conf</filename></para>
     <para><filename>/run/modprobe.d/*.conf</filename></para>
+    <para><filename>/etc/modprobe.d/*.conf</filename></para>
   </refsynopsisdiv>
 
   <refsect1><title>DESCRIPTION</title>
-- 
2.30.0

