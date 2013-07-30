Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47960 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab3G3GsJ (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 30 Jul 2013 02:48:09 -0400
Received: by mail-gg0-f174.google.com with SMTP id j5so32043ggn.33
        for <linux-modules@vger.kernel.org>; Mon, 29 Jul 2013 23:48:08 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id b50sm89541063yhl.1.2013.07.29.23.48.07
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 23:48:07 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 1/3] shell-completion: Add initial completion for kmod
Date: Tue, 30 Jul 2013 03:48:13 -0300
Message-Id: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Skeleton pulled from udevadm in systemd and adapted to kmod needs.
---
 NEWS                       |  2 +-
 shell-completion/bash/kmod | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 shell-completion/bash/kmod

diff --git a/NEWS b/NEWS
index 1dff366..491146d 100644
--- a/NEWS
+++ b/NEWS
@@ -6,7 +6,7 @@ kmod 15
 
 - New features:
 	- kmod static-nodes creates parent directories if given a -o option
-	- kmod binary doesn't statically link to libkmod
+	- kmod binary statically link to libkmod
 
 kmod 14
 =======
diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
new file mode 100644
index 0000000..81dbf46
--- /dev/null
+++ b/shell-completion/bash/kmod
@@ -0,0 +1,53 @@
+# kmod completion                                          -*- shell-script -*-
+#
+# This file is part of systemd.
+#
+# Copyright 2010 Ran Benita
+# Copyright (C) 2013  Intel Corporation. All rights reserved.
+#
+# systemd is free software; you can redistribute it and/or modify it
+# under the terms of the GNU Lesser General Public License as published by
+# the Free Software Foundation; either version 2.1 of the License, or
+# (at your option) any later version.
+#
+# systemd is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public License
+# along with systemd; If not, see <http://www.gnu.org/licenses/>.
+
+__contains_word () {
+    local word=$1; shift
+    for w in $*; do [[ $w = $word ]] && return 0; done
+    return 1
+}
+
+_kmod() {
+    local cur=${COMP_WORDS[COMP_CWORD]} prev=${COMP_WORDS[COMP_CWORD-1]}
+    local verb comps
+
+    local -A VERBS=(
+	[HELP]='help'
+	[LIST]='list'
+	[STATIC-NODES]='static-nodes'
+    )
+
+    for ((i=0; $i <= $COMP_CWORD; i++)); do
+        if __contains_word "${COMP_WORDS[i]}" ${VERBS[*]} &&
+            ! __contains_word "${COMP_WORDS[i-1]}" ${OPTS[ARG]}; then
+            verb=${COMP_WORDS[i]}
+            break
+        fi
+    done
+
+    if [[ -z $verb ]]; then
+	comps=${VERBS[*]}
+    fi
+
+    COMPREPLY=( $(compgen -W '$comps' -- "$cur" ) )
+    return 0
+}
+
+complete -F _kmod kmod
-- 
1.8.3.4

