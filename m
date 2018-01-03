Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbeACW3e (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:34 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 1/6] build: add mkosi hooks
Date: Wed,  3 Jan 2018 14:29:19 -0800
Message-Id: <20180103222924.26347-2-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Right now there's support for building on Archlinux only.
---
 Makefile.am                   |  8 ++++++++
 testsuite/mkosi/.gitignore    |  4 ++++
 testsuite/mkosi/mkosi.arch    | 22 ++++++++++++++++++++++
 testsuite/mkosi/mkosi.build   | 23 +++++++++++++++++++++++
 testsuite/mkosi/mkosi.default |  1 +
 5 files changed, 58 insertions(+)
 create mode 100644 testsuite/mkosi/.gitignore
 create mode 100644 testsuite/mkosi/mkosi.arch
 create mode 100755 testsuite/mkosi/mkosi.build
 create mode 120000 testsuite/mkosi/mkosi.default

diff --git a/Makefile.am b/Makefile.am
index 2a1eb50..b7ee6b1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -498,3 +498,11 @@ tar: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 
 tar-sync: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 	kup put kmod-$(VERSION).tar.xz  kmod-$(VERSION).tar.sign /pub/linux/utils/kernel/kmod/
+
+# ------------------------------------------------------------------------------
+# mkosi
+# ------------------------------------------------------------------------------
+
+mkosi:
+	-mkdir $(top_srcdir)/testsuite/mkosi/mkosi.cache
+	mkosi -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ -fi
diff --git a/testsuite/mkosi/.gitignore b/testsuite/mkosi/.gitignore
new file mode 100644
index 0000000..024d05b
--- /dev/null
+++ b/testsuite/mkosi/.gitignore
@@ -0,0 +1,4 @@
+/image.raw*
+/.mkosi-*
+/mkosi.cache
+/rootfs
diff --git a/testsuite/mkosi/mkosi.arch b/testsuite/mkosi/mkosi.arch
new file mode 100644
index 0000000..308dcdb
--- /dev/null
+++ b/testsuite/mkosi/mkosi.arch
@@ -0,0 +1,22 @@
+[Distribution]
+Distribution=arch
+Release=(rolling)
+
+[Packages]
+Packages = valgrind
+BuildPackages =
+	automake
+	gcc
+	git
+	make
+	pkg-config
+	python2
+	python2-future
+	autoconf
+	gtk-doc
+	docbook-xml
+	docbook-xsl
+	linux-headers
+
+[Partitions]
+RootSize = 4G
diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
new file mode 100755
index 0000000..a6b325f
--- /dev/null
+++ b/testsuite/mkosi/mkosi.build
@@ -0,0 +1,23 @@
+#!/bin/bash -ex
+
+if [ -f configure ]; then
+    make distclean
+fi
+
+rm -rf build
+mkdir build
+cd build
+
+kdirs=(/usr/lib/modules/*/build/Makefile)
+if [[ ! -f ${kdirs[0]} ]]; then
+  printf '==> Unable to find kernel headers to build modules for tests\n' >&2
+  return 1
+fi
+
+kdir=${kdirs[0]%/Makefile}
+IFS=/ read _ _ _ kver _ <<<"$kdir"
+
+../autogen.sh c
+make -j
+make check KDIR="$kdir" KVER="$kver"
+make install
diff --git a/testsuite/mkosi/mkosi.default b/testsuite/mkosi/mkosi.default
new file mode 120000
index 0000000..695b71a
--- /dev/null
+++ b/testsuite/mkosi/mkosi.default
@@ -0,0 +1 @@
+mkosi.arch
\ No newline at end of file
-- 
2.14.3

