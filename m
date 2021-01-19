Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C780C433E0
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B11207C4
	for <linux-modules@archiver.kernel.org>; Tue, 19 Jan 2021 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbhASPFO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:05:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:39972 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391709AbhASOzX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Jan 2021 09:55:23 -0500
IronPort-SDR: i9kCwhN0zenE5DbnjvweKdm2+hNtqd1SDKm+SD2VK/j+nemmJoXC4Ni8snqLe19Jlzalmc8qm9
 DJ8+mqe4T4iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179023532"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="179023532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:24 -0800
IronPort-SDR: 4Dk6ziHeO+IFmpd30IgqkjBmInIf/zK9Jm1c5bDaZhJ10DCpXtNwEPwdNf9EYYV08RXQh4X1UE
 R7E3iqUHE2NA==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365772532"
Received: from caophong-mobl.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.213.166.105])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:54:22 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Jan Tojnar <jtojnar@gmail.com>
Subject: [PATCH 3/3] Support /usr/local for configuration files
Date:   Tue, 19 Jan 2021 06:52:38 -0800
Message-Id: <20210119145238.12774-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119145238.12774-1-lucas.demarchi@intel.com>
References: <20210119145238.12774-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add /usr/local to the search path for configuration files. These are
intended for local installs, provided /usr/local is given as prefix.
---
 libkmod/libkmod.c  | 10 ++++++----
 man/depmod.d.xml   |  1 +
 man/modprobe.d.xml |  1 +
 tools/depmod.c     |  1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 25655b9..7c2b889 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -64,6 +64,7 @@ static struct _index_files {
 static const char *default_config_paths[] = {
 	SYSCONFDIR "/modprobe.d",
 	"/run/modprobe.d",
+	"/usr/local/lib/modprobe.d",
 	"/lib/modprobe.d",
 	NULL
 };
@@ -234,10 +235,11 @@ static char *get_kernel_release(const char *dirname)
  *           Otherwise, give an absolute dirname.
  * @config_paths: ordered array of paths (directories or files) where
  *                to load from user-defined configuration parameters such as
- *                alias, blacklists, commands (install, remove). If
- *                NULL defaults to /etc/modprobe.d, /run/modprobe.d and
- *                /lib/modprobe.d. Give an empty vector if configuration should
- *                not be read. This array must be null terminated.
+ *                alias, blacklists, commands (install, remove). If NULL
+ *                defaults to /etc/modprobe.d, /run/modprobe.d,
+ *                /usr/local/lib/modprobe.d and /lib/modprobe.d. Give an empty
+ *                vector if configuration should not be read. This array must
+ *                be null terminated.
  *
  * Create kmod library context. This reads the kmod configuration
  * and fills in the default values.
diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 6472bda..b315e93 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -40,6 +40,7 @@
 
   <refsynopsisdiv>
     <para><filename>/usr/lib/depmod.d/*.conf</filename></para>
+    <para><filename>/usr/local/lib/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
   </refsynopsisdiv>
diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index a674d69..0ab3e91 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -41,6 +41,7 @@
 
   <refsynopsisdiv>
     <para><filename>/lib/modprobe.d/*.conf</filename></para>
+    <para><filename>/usr/local/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/run/modprobe.d/*.conf</filename></para>
     <para><filename>/etc/modprobe.d/*.conf</filename></para>
   </refsynopsisdiv>
diff --git a/tools/depmod.c b/tools/depmod.c
index 8e1d9ec..170a1d8 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -53,6 +53,7 @@ static const char CFG_EXTERNAL_KEY[] = "external";
 static const char *default_cfg_paths[] = {
 	SYSCONFDIR "/depmod.d",
 	"/run/depmod.d",
+	"/usr/local/lib/depmod.d",
 	"/lib/depmod.d",
 	NULL
 };
-- 
2.30.0

