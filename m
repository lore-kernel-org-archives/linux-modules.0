Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeACW3f (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:35 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 4/6] testsuite: add Fedora's mkosi configuration
Date: Wed,  3 Jan 2018 14:29:22 -0800
Message-Id: <20180103222924.26347-5-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

To use the Fedora configuration rather than the default, one should
use:

	# make DISTRO=fedora mkosi

While at it also reduce the root partition size for Arch, since it
doesn't need that much.
---
 testsuite/mkosi/mkosi.arch   |  2 +-
 testsuite/mkosi/mkosi.fedora | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/mkosi/mkosi.fedora

diff --git a/testsuite/mkosi/mkosi.arch b/testsuite/mkosi/mkosi.arch
index 5ac0a45..324dfb0 100644
--- a/testsuite/mkosi/mkosi.arch
+++ b/testsuite/mkosi/mkosi.arch
@@ -22,4 +22,4 @@ BuildPackages =
 	linux-headers
 
 [Partitions]
-RootSize = 4G
+RootSize = 2G
diff --git a/testsuite/mkosi/mkosi.fedora b/testsuite/mkosi/mkosi.fedora
new file mode 100644
index 0000000..7be7dd9
--- /dev/null
+++ b/testsuite/mkosi/mkosi.fedora
@@ -0,0 +1,26 @@
+[Distribution]
+Distribution=fedora
+Release=27
+
+[Output]
+Output = fedora-image.raw
+
+[Packages]
+Packages = valgrind
+BuildPackages =
+	autoconf
+	automake
+	gcc
+	git
+	gtk-doc
+	kernel-devel
+	libtool
+	libxslt
+	make
+	pkgconf-pkg-config
+	xml-common
+	xz-devel
+	zlib-devel
+
+[Partitions]
+RootSize = 2G
-- 
2.14.3

