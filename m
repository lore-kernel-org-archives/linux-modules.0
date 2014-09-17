Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:53068 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081AbaIQDWh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 16 Sep 2014 23:22:37 -0400
Message-Id: <20140917031328.003016619@bongo.bofh.it>
Date: Wed, 17 Sep 2014 05:12:26 +0200
To: linux-modules@vger.kernel.org
Subject: [patch 1/2] Document depmod --show in depmod(8)
References: <20140917031225.559902121@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
From: md@Linux.IT (Marco d'Itri)
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

--- a/man/depmod.xml
+++ b/man/depmod.xml
@@ -236,6 +236,9 @@
           <option>-n</option>
         </term>
         <term>
+          <option>--show</option>
+        </term>
+        <term>
           <option>--dry-run</option>
         </term>
         <listitem>


