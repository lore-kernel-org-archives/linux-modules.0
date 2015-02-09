Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42124 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761506AbbBIXPd (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 9 Feb 2015 18:15:33 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 2/2] tools: add kmod info
Date: Mon, 9 Feb 2015 21:15:13 -0200
Message-ID: <1423523713-3595-2-git-send-email-caio.oliveira@intel.com>
In-Reply-To: <1423523713-3595-1-git-send-email-caio.oliveira@intel.com>
References: <1423523713-3595-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>

---
 man/kmod.xml    |  6 ++++++
 tools/kmod.c    |  1 +
 tools/kmod.h    |  1 +
 tools/modinfo.c | 11 +++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/man/kmod.xml b/man/kmod.xml
index 0706ad5..caa07a4 100644
--- a/man/kmod.xml
+++ b/man/kmod.xml
@@ -72,6 +72,12 @@
         </listitem>
       </varlistentry>
       <varlistentry>
+        <term><command>info</command></term>
+        <listitem>
+          <para>Show information about a module.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
         <term><command>list</command></term>
         <listitem>
           <para>List the currently loaded modules.</para>
diff --git a/tools/kmod.c b/tools/kmod.c
index 521c2b9..1b5c346 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -40,6 +40,7 @@ static const struct kmod_cmd kmod_cmd_help;
 
 static const struct kmod_cmd *kmod_cmds[] = {
 	&kmod_cmd_help,
+	&kmod_cmd_info,
 	&kmod_cmd_list,
 	&kmod_cmd_static_nodes,
 };
diff --git a/tools/kmod.h b/tools/kmod.h
index 71bc0c1..f57a92e 100644
--- a/tools/kmod.h
+++ b/tools/kmod.h
@@ -36,6 +36,7 @@ extern const struct kmod_cmd kmod_cmd_compat_modinfo;
 extern const struct kmod_cmd kmod_cmd_compat_modprobe;
 extern const struct kmod_cmd kmod_cmd_compat_depmod;
 
+extern const struct kmod_cmd kmod_cmd_info;
 extern const struct kmod_cmd kmod_cmd_list;
 extern const struct kmod_cmd kmod_cmd_static_nodes;
 
diff --git a/tools/modinfo.c b/tools/modinfo.c
index 94d55c9..9a32143 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -330,7 +330,7 @@ static const struct option cmdopts[] = {
 static void help(void)
 {
 	printf("Usage:\n"
-		"\t%s [options] filename [args]\n"
+		"\t%s%s [options] filename [args]\n"
 		"Options:\n"
 		"\t-a, --author                Print only 'author'\n"
 		"\t-d, --description           Print only 'description'\n"
@@ -343,7 +343,8 @@ static void help(void)
 		"\t-b, --basedir=DIR           Use DIR as filesystem root for /lib/modules\n"
 		"\t-V, --version               Show version\n"
 		"\t-h, --help                  Show this help\n",
-		program_invocation_short_name);
+		program_invocation_short_name,
+		is_kmod_cmd() ? " info" : "");
 }
 
 static bool is_module_filename(const char *name)
@@ -464,3 +465,9 @@ const struct kmod_cmd kmod_cmd_compat_modinfo = {
 	.cmd = do_modinfo,
 	.help = "compat modinfo command",
 };
+
+const struct kmod_cmd kmod_cmd_info = {
+	.name = "info",
+	.cmd = do_modinfo,
+	.help = "show information about a module",
+};
-- 
2.2.2

