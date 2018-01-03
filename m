Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeACW3e (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:34 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 3/6] testsuite: generalize mkosi support for other distros
Date: Wed,  3 Jan 2018 14:29:21 -0800
Message-Id: <20180103222924.26347-4-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Instead of using the mkosi.default symlink, use an env var passed from
the build system. We would need to pass the --default switch nonetheless
or change the symlink, making the git tree dirty.

Also, search for installed kernel headers in a way that's compatible
with more distros. On Fedora, for example, the
/usr/lib/modules/<kver>/build symlink is only available if there's a
kernel installed. We don't care about a kernel installed since we don't
need to boot it on a real machine: the only thing we need is the
kernel-devel package.
---
 Makefile.am                   |  4 +++-
 testsuite/mkosi/.gitignore    |  3 +--
 testsuite/mkosi/mkosi.arch    |  3 +++
 testsuite/mkosi/mkosi.build   | 29 ++++++++++++++++++++++-------
 testsuite/mkosi/mkosi.default |  1 -
 5 files changed, 29 insertions(+), 11 deletions(-)
 delete mode 120000 testsuite/mkosi/mkosi.default

diff --git a/Makefile.am b/Makefile.am
index 3ea4274..7b01201 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -503,6 +503,8 @@ tar-sync: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 # mkosi
 # ------------------------------------------------------------------------------
 
+DISTRO ?= "arch"
+
 mkosi:
 	-$(MKDIR_P) $(top_srcdir)/testsuite/mkosi/mkosi.cache
-	$(MKOSI) -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ -fi
+	$(MKOSI) -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ --default mkosi.${DISTRO} -fi
diff --git a/testsuite/mkosi/.gitignore b/testsuite/mkosi/.gitignore
index 024d05b..0e0981a 100644
--- a/testsuite/mkosi/.gitignore
+++ b/testsuite/mkosi/.gitignore
@@ -1,4 +1,3 @@
-/image.raw*
+/*-image.raw*
 /.mkosi-*
 /mkosi.cache
-/rootfs
diff --git a/testsuite/mkosi/mkosi.arch b/testsuite/mkosi/mkosi.arch
index 308dcdb..5ac0a45 100644
--- a/testsuite/mkosi/mkosi.arch
+++ b/testsuite/mkosi/mkosi.arch
@@ -2,6 +2,9 @@
 Distribution=arch
 Release=(rolling)
 
+[Output]
+Output = arch-image.raw
+
 [Packages]
 Packages = valgrind
 BuildPackages =
diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
index a6b325f..53fc797 100755
--- a/testsuite/mkosi/mkosi.build
+++ b/testsuite/mkosi/mkosi.build
@@ -1,5 +1,26 @@
 #!/bin/bash -ex
 
+function find_kdir() {
+    local kdirs=(/usr/lib/modules/*/build/Makefile /usr/src/kernels/*/Makefile)
+    local kdir=""
+
+    for f in "${kdirs[@]}"; do
+        if [ -f "$f" ]; then
+            kdir=$f
+            break
+        fi
+    done
+
+    if [ -z "$kdir" ]; then
+        printf '==> Unable to find kernel headers to build modules for tests\n' >&2
+        exit 1
+    fi
+
+    kdir=${kdir%/Makefile}
+
+    echo $kdir
+}
+
 if [ -f configure ]; then
     make distclean
 fi
@@ -8,13 +29,7 @@ rm -rf build
 mkdir build
 cd build
 
-kdirs=(/usr/lib/modules/*/build/Makefile)
-if [[ ! -f ${kdirs[0]} ]]; then
-  printf '==> Unable to find kernel headers to build modules for tests\n' >&2
-  return 1
-fi
-
-kdir=${kdirs[0]%/Makefile}
+kdir=$(find_kdir)
 IFS=/ read _ _ _ kver _ <<<"$kdir"
 
 ../autogen.sh c
diff --git a/testsuite/mkosi/mkosi.default b/testsuite/mkosi/mkosi.default
deleted file mode 120000
index 695b71a..0000000
--- a/testsuite/mkosi/mkosi.default
+++ /dev/null
@@ -1 +0,0 @@
-mkosi.arch
\ No newline at end of file
-- 
2.14.3

