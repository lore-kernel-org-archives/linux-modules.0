Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39006 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930AbbI1WjR (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 28 Sep 2015 18:39:17 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCHv2 1/5] README: Indicate cython requirements
Date: Mon, 28 Sep 2015 15:39:10 -0700
Message-Id: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


The recommended flags require cython be installed to compile
successfully. Note this in the documentation.
---
 README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index b977e1f..4933268 100644
--- a/README
+++ b/README
@@ -63,7 +63,8 @@ Hacking
 =======
 
 Run 'bootstrap' script before configure. If you want to accept the recommended
-flags, you just need to run 'bootstrap-configure'.
+flags, you just need to run 'bootstrap-configure'. Note that the recommended
+flags require cython be installed to compile successfully.
 
 Make sure to read the CODING-STYLE file and the other READMEs: libkmod/README
 and testsuite/README.
-- 
2.4.3

