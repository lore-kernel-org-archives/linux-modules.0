Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21470 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbaCFOF4 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:56 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 8/8] man: use systemd as example instead of udev
Date: Thu, 6 Mar 2014 11:06:49 -0300
Message-ID: <1394114809-2737-8-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Nowadays udev doesn't create nodes in /dev anymore. This role is rather
taken by systemd-tmpfiles on early boot so reference it generically as
systemd.
---
 man/depmod.xml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/man/depmod.xml b/man/depmod.xml
index a9b61d9..380ee7d 100644
--- a/man/depmod.xml
+++ b/man/depmod.xml
@@ -93,9 +93,11 @@
       <command>depmod</command> will output a file named
       <filename>modules.devname</filename> if modules supply special device
       names (devname) that should be populated in /dev on boot (by a utility
-      such as udev).  </para> <para> If a <replaceable>version</replaceable> is
-      provided, then that kernel version's module directory is used rather than
-      the current kernel version (as returned by <command>uname -r</command>).
+      such as systemd-tmpfiles).
+    </para>
+    <para> If a <replaceable>version</replaceable> is provided, then that kernel
+      version's module directory is used rather than the current kernel version
+      (as returned by <command>uname -r</command>).
     </para>
   </refsect1>
   <refsect1><title>OPTIONS</title>
-- 
1.9.0

