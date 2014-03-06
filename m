Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21955 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbaCFOF4 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 09:05:56 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Michal Marek <mmarek@suse.cz>
Subject: [PATCH 5/8] build-sys: add small redirecting Makefiles
Date: Thu, 6 Mar 2014 11:06:46 -0300
Message-ID: <1394114809-2737-5-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

These redirecting makefiles simplifies compiling from some editors and
when CWD is not the root of the source tree. This is similar to what was
introduced in systemd in 340d89e ("build-sys: add small redirecting
Makefiles to simplify compilation from within emacs")
---
 .gitignore              |  4 ++--
 libkmod/Makefile        | 13 +++++++++++++
 libkmod/docs/.gitignore |  2 ++
 man/.gitignore          |  2 ++
 testsuite/Makefile      | 15 +++++++++++++++
 tools/Makefile          | 13 +++++++++++++
 6 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 libkmod/Makefile
 create mode 100644 testsuite/Makefile
 create mode 100644 tools/Makefile

diff --git a/.gitignore b/.gitignore
index 5bfab9a..88c8149 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,8 +3,8 @@
 /*.md5sum
 .deps/
 .libs/
-Makefile
-Makefile.in
+/Makefile
+/Makefile.in
 
 /aclocal.m4
 /autom4te.cache/
diff --git a/libkmod/Makefile b/libkmod/Makefile
new file mode 100644
index 0000000..223bec2
--- /dev/null
+++ b/libkmod/Makefile
@@ -0,0 +1,13 @@
+#  Copyright 2010 Lennart Poettering
+#
+# This file has been copied from systemd. It is a dirty trick to simplify
+# compilation when CWD is not the root of the source tree. This file is not
+# intended to be distributed.  So, don't touch it, even better ignore it!
+
+all:
+	$(MAKE) -C ..
+
+clean:
+	$(MAKE) -C .. clean
+
+.PHONY: all clean
diff --git a/libkmod/docs/.gitignore b/libkmod/docs/.gitignore
index 21e2279..7514b08 100644
--- a/libkmod/docs/.gitignore
+++ b/libkmod/docs/.gitignore
@@ -10,3 +10,5 @@ version.xml
 xml
 html
 gtk-doc.make
+Makefile
+Makefile.in
diff --git a/man/.gitignore b/man/.gitignore
index bc0cce8..a229b2f 100644
--- a/man/.gitignore
+++ b/man/.gitignore
@@ -1,2 +1,4 @@
 *.5
 *.8
+Makefile
+Makefile.in
diff --git a/testsuite/Makefile b/testsuite/Makefile
new file mode 100644
index 0000000..38ba552
--- /dev/null
+++ b/testsuite/Makefile
@@ -0,0 +1,15 @@
+#  Copyright 2010 Lennart Poettering
+#
+# This file has been copied from systemd. It is a dirty trick to simplify
+# compilation when CWD is not the root of the source tree. This file is not
+# intended to be distributed.  So, don't touch it, even better ignore it!
+
+all:
+	$(MAKE) -C .. check
+check:
+	$(MAKE) -C .. check
+
+clean:
+	$(MAKE) -C .. clean
+
+.PHONY: all clean check
diff --git a/tools/Makefile b/tools/Makefile
new file mode 100644
index 0000000..223bec2
--- /dev/null
+++ b/tools/Makefile
@@ -0,0 +1,13 @@
+#  Copyright 2010 Lennart Poettering
+#
+# This file has been copied from systemd. It is a dirty trick to simplify
+# compilation when CWD is not the root of the source tree. This file is not
+# intended to be distributed.  So, don't touch it, even better ignore it!
+
+all:
+	$(MAKE) -C ..
+
+clean:
+	$(MAKE) -C .. clean
+
+.PHONY: all clean
-- 
1.9.0

