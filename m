Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ye0-f182.google.com ([209.85.213.182]:65022 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549Ab3G3GsK (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 30 Jul 2013 02:48:10 -0400
Received: by mail-ye0-f182.google.com with SMTP id q7so1232871yen.27
        for <linux-modules@vger.kernel.org>; Mon, 29 Jul 2013 23:48:09 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id b50sm89541063yhl.1.2013.07.29.23.48.08
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 23:48:09 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/3] shell-completion: Add kmod static-nodes
Date: Tue, 30 Jul 2013 03:48:14 -0300
Message-Id: <1375166895-20350-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 shell-completion/bash/kmod | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
index 81dbf46..2409eda 100644
--- a/shell-completion/bash/kmod
+++ b/shell-completion/bash/kmod
@@ -24,6 +24,28 @@ __contains_word () {
     return 1
 }
 
+_kmod_static_nodes () {
+    local cur=${COMP_WORDS[COMP_CWORD]} prev=${COMP_WORDS[COMP_CWORD-1]}
+    local opts='-o --output -f --format -h --help'
+
+    echo "cur='$cur' prev='$prev'" >> /tmp/a.txt
+    case $prev in
+	'-o' | '--output')
+	    compopt -o filenames
+	    COMPREPLY=( $(compgen -f -- "$cur") )
+	    ;;
+	'-f' | '--format')
+	    COMPREPLY=( $(compgen -W 'human tmpfiles devname' -- "$cur") )
+	    ;;
+	'-'*)
+	    COMPREPLY=()
+	    ;;
+	*)
+	    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
+	    ;;
+    esac
+}
+
 _kmod() {
     local cur=${COMP_WORDS[COMP_CWORD]} prev=${COMP_WORDS[COMP_CWORD-1]}
     local verb comps
@@ -44,6 +66,11 @@ _kmod() {
 
     if [[ -z $verb ]]; then
 	comps=${VERBS[*]}
+    elif __contains_word "$verb" ${VERBS[STATIC-NODES]}; then
+	_kmod_static_nodes
+	return 0
+    else
+	comps=''
     fi
 
     COMPREPLY=( $(compgen -W '$comps' -- "$cur" ) )
-- 
1.8.3.4

