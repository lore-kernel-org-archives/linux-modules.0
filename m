Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from shell.v3.sk ([92.60.52.57]:51896 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbcCBPZ5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 2 Mar 2016 10:25:57 -0500
From: Lubomir Rintel <lkundrak@v3.sk>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] modprobe: install default configuration
Date: Wed,  2 Mar 2016 16:18:13 +0100
Message-Id: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Some network devices have an awful habit of creating interfaces when loaded,
despite not asked for. Worse even, they do so while being autoloaded due to an
attempt to create a device via netlink:

  # rmmod dummy
  # ip link add dummy0 type dummy
  RTNETLINK answers: File exists

The kernel maintainers seem opposed to fixing this in kernel (despite a similar
thing has been done with loop block devices) [1]. Let's fix this my overriding the
defaults from userspace.

[1] http://comments.gmane.org/gmane.linux.kernel/2124714
---
 Makefile.am                |  4 ++++
 modprobe.d/50-default.conf | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 modprobe.d/50-default.conf

diff --git a/Makefile.am b/Makefile.am
index 2d9f2cf..9f89485 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -103,6 +103,10 @@ bashcompletiondir=@bashcompletiondir@
 dist_bashcompletion_DATA = \
 	shell-completion/bash/kmod
 
+modprobeddir=$(prefix)/lib/modprobe.d
+dist_modprobed_DATA = \
+	modprobe.d/50-default.conf
+
 install-exec-hook:
 	if test "$(libdir)" != "$(rootlibdir)"; then \
 		$(MKDIR_P) $(DESTDIR)$(rootlibdir) && \
diff --git a/modprobe.d/50-default.conf b/modprobe.d/50-default.conf
new file mode 100644
index 0000000..70d21f2
--- /dev/null
+++ b/modprobe.d/50-default.conf
@@ -0,0 +1,24 @@
+# default module parameters
+#
+# This file is part of kmod.
+#
+# Copyright 2016 Lubomir Rintel
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU Lesser General Public License as published by
+# the Free Software Foundation; either version 2.1 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+# See modprobe.d(5) for the description of the files in this directory,
+
+options bonding max_bonds=0
+options dummy numdummies=0
+options ifb numifbs=0
-- 
2.5.0

