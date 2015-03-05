Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20797 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964784AbbCEQIn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 5 Mar 2015 11:08:43 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 2/3] testsuite: update README
Date: Thu, 5 Mar 2015 13:06:38 -0300
Message-ID: <1425571599-26032-2-git-send-email-caio.oliveira@intel.com>
In-Reply-To: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
References: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/README | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testsuite/README b/testsuite/README
index d5843bf..6efc61e 100644
--- a/testsuite/README
+++ b/testsuite/README
@@ -33,7 +33,7 @@ pay attention when writing a test:
 
 3 - If you want testsuite to compare the stdout/stderr of your tests in order
     to check if it worked or not, fill in output.{stderr,stdout} the file with
-    the expected output. Bare in mind the same file is used for all
+    the expected output. Bear in mind the same file is used for all
     architectures, so don't print arch-dependent content if you are comparing
     the output.
 
@@ -49,8 +49,10 @@ pay attention when writing a test:
 6 - expected_fail: if that test is expected to fail, i.e. the return code is
     expected not to be 0.
 
-7 - If you added files to the rootfs, be sure to compact it back to
-    rootfs.tar.xz before sending patches: use 'make testsuite-pack-rootfs'
+7 - The rootfs is populated by copying the entire contents of rootfs-pristine
+    then running populate-modules.sh to copy generated modules from
+    module-playground. Update the latter script to include any modules your
+    test need.
 
 8 - Tests can be run individually, outside of 'make check'. strace and gdb work
     too, as long as you tell them to operate on child process.
-- 
2.3.0

