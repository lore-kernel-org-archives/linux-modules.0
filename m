Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36756 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHXId (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Feb 2018 18:08:33 -0500
Received: by mail-it0-f66.google.com with SMTP id n206so8471078itg.1
        for <linux-modules@vger.kernel.org>; Thu, 08 Feb 2018 15:08:33 -0800 (PST)
From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Subject: [PATCH] testsuite: add Clear's mkosi configuration
Date: Thu,  8 Feb 2018 15:08:22 -0800
Message-Id: <20180208230822.10475-1-caio.oliveira@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Adapted the mkosi.build script to account for not building
test-modules in Clear. It doesn't have the headers available yet.
---
 testsuite/mkosi/mkosi.build |  9 +++++++--
 testsuite/mkosi/mkosi.clear | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/mkosi/mkosi.clear

diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
index 53fc797..8ed54bb 100755
--- a/testsuite/mkosi/mkosi.build
+++ b/testsuite/mkosi/mkosi.build
@@ -29,8 +29,13 @@ rm -rf build
 mkdir build
 cd build
 
-kdir=$(find_kdir)
-IFS=/ read _ _ _ kver _ <<<"$kdir"
+if grep clear-linux-os /usr/lib/os-release; then
+    # Clear Linux doesn't have the dependencies for those yet.
+    echo "--disable-test-modules" > ../../.config.args
+else
+    kdir=$(find_kdir)
+    IFS=/ read _ _ _ kver _ <<<"$kdir"
+fi
 
 ../autogen.sh c
 make -j
diff --git a/testsuite/mkosi/mkosi.clear b/testsuite/mkosi/mkosi.clear
new file mode 100644
index 0000000..6d87514
--- /dev/null
+++ b/testsuite/mkosi/mkosi.clear
@@ -0,0 +1,19 @@
+[Distribution]
+Distribution=clear
+Release=latest
+
+[Output]
+Output = clear-image.raw
+
+[Packages]
+Packages=
+	os-core-update
+BuildPackages=
+	os-core-dev
+
+[Partitions]
+RootSize = 5G
+
+[Host]
+# This is where swupd-extract is usually installed.
+ExtraSearchPaths=$SUDO_HOME/go/bin
\ No newline at end of file
-- 
2.16.1

