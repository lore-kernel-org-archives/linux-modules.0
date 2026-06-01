Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C463A784E
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315564; cv=none; b=DHVwCNB4ZlbYyEoTOLcLR/HCBVq/9upC8YnMnLqPR0xt6jKYR1xtQv2YPf0OYPspd3FwYB0D0Emu1tUM0TdVo8Kcaa9mU2RnPjHK9adW+8h17Fz7Q7V+IWeH5IbrNGxHFeM454vZ5VWi75bc+jvYiIQb3RhBDG3DD48ot3WJcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315564; c=relaxed/simple;
	bh=sEO7u0MUmNyTUFNIPBYBwtZCCgzYuBjfxfoGHbMv0oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTXXXoZOklwVq8428TpSZDaq8G7gc69A/fq3UJ0v18Mkzap4Mwi+r/ihwdtRJ7Sz3HXuMLqpoCL50eJeh0gZYpFI7RBnpFvE/fh62t0yuswJm/c0whoa8u41YSw+4H/jMj/I2KxO7bMrbhQbOgs5Lytj12uRI9ZwKRWouQsG9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emQ0ufQA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emQ0ufQA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49068493267so55514685e9.1
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315561; x=1780920361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU7EFGuwqCZWgkJhEpDIGpXxPiY17lJwErVDlJ76auc=;
        b=emQ0ufQAvvX5Yq7G0xvsXQqdAXdECmMQL0fgULqP7x4AbHzbn9FID0sgTxPP1cN+5N
         phgMCYmxdtEKj9trh4ESlCb4GWV9WlSZPOjg+sWb1vQ150Q2AyPeXlWt4/xNorJnguc4
         6tIJkXixN7F4N34K/RgU5fzc7Ycek1XnTTd/5A2TEwmHNrXWHIcDLtHcbCuofQtmqUch
         31a1z8RtBnBX9tWT+BhFT9Rq3n0dcKsme71BAIpP4xl9dpZIzskOfS+xLuRtI4js7Pjp
         3s5+RVImHEGbVPmvOEXTP+cXj/EMbwqxgbC0wgi0P9ZgwxtYAGVmWQqFIu0rM9hyraEh
         JaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315561; x=1780920361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vU7EFGuwqCZWgkJhEpDIGpXxPiY17lJwErVDlJ76auc=;
        b=j89GF9N4mhbys5cOvuVnqjTbuvRwReeSd7KylyFYWH9MwAZkLj46C3v74da317BhVQ
         zi5s5GDJeZ+gtWofvMuE96QeGOoXpQOe7JFnVn1HpskeZFKkhpjxq2BvmgG9TE+0mDdQ
         tyqRlzY8cfDeNi8HUtl2RQrke4GS0WWeYU+EsWdVDpe6teezz6Gv3Gzaz5bglvXpvA6U
         mTkzQQa9Q31VCfqoZ1SEO2WosmPIghYQGeGle3s505mHRTa4EBDeSZLWyDvvRV2XyzOE
         Y7to/XWC39FGq1lPpGTw1EcuK+xPunhE3PCwH5ILpooTm2fU6PfXPO9edOvXYlf8Uq5T
         Mn2A==
X-Forwarded-Encrypted: i=1; AFNElJ+ioAp+7aW57QlxafNIkjVaRkZW0pR6z79QMPHANiNxOyChwuVulozK9x1dhrZA5FBSr3QfmjZX+glVdcai@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHbb2eJdwsLV+ZEofugynW8Ey7O24AzhWN2KBjLCHJaAnarXH
	Y7Bg9wCo1JtoZAztB8eHqFL/27Rqxjh7bhFcLSTbdUVe4Q74da+55KRJ
X-Gm-Gg: Acq92OGHubJe4h2zusFmOYlUTB4YRzFIQnYQ7NGYb2KArZNGQkL6j2LiMs2NRR6mHlj
	bD1emRt9wVGbIusiOByQ43PEx9Dbv3PZtFyG+tOvj/IZlMeqextqqVSUZD5UUOxe9wmVwuUhdh3
	0Cg4LSfqatBfY7/Q+hcBUafKNuoikMakfzkcHJVAzxMBu8SoXpdAXhOhfIIYW6jo+OHs8DAbx/B
	ayuuC0jByAIr7sT28FuHSkKYoAqTBJkDzIJVIEX44+L/8lIFtnLvpDrSsR/XbhYif36KjG4AoOO
	NT2Qma3yTdclwOees4W7k2AS0aKb3mxyTUqNFSTskL750q9ZD+z1ONwdhjhiez2L3uTXQE6T6NR
	DFlBq1K39vgY5gYeGKy/qFyBnbP2qeBosp8tEAIO2lfXg4m0v4nkFtLn/ZS7Vm2Qs2daCDJXD0S
	E0yk7FTRkrKHfFSwcZtSlVxD7TO5Jh4JJfpQjTdiaw4A==
X-Received: by 2002:a05:600c:4e92:b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490a2900dacmr202132615e9.3.1780315560582;
        Mon, 01 Jun 2026 05:06:00 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:06:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:10 +0000
Subject: [PATCH v3 24/24] dynamic_debug: use KBUILD_MODFILE for unique
 builtin module names
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-24-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=11525;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=sEO7u0MUmNyTUFNIPBYBwtZCCgzYuBjfxfoGHbMv0oE=;
 b=DPwcRKWEUYRhXRmC55DFt4XbR2ofmt1arOnS2i/wN8YubW92I1k8pJhvFDor9/LqQslDrC/N3
 VZ62XvXMhV/CsYupwAafT1pAtBZ/E9i8lMFkaVFl/5C4jYDJWbI3ouy
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Historically dynamic-debug gets its module names from KBUILD_MODNAME.
This works well for loadable modules, as the module loader has always
required them to have unique names, but for builtins it is basically
kbasename(srcfile), which sadly gives us many modules named "main".

This makes the following ambiguous:
  bash-5.3# echo module main +m > /proc/dynamic_debug/control

since it would affect 4 independent modules named main:
  bash-5.3# ddgrep =m
  init/main.c:1265 [main]initcall_blacklist =m "blacklisting initcall %s\n"
  kernel/power/main.c:49 [main]pm_restore_gfp_mask =m "GFP mask restored\n"
  kernel/module/main.c:2862 [main]move_module =m "\t0x%lx 0x%.8lx %s\n"
  drivers/base/power/main.c:149 [main]device_pm_add =m "Adding info for %s:%s\n"

We can improve this by using KBUILD_MODFILE for dyndbg's modname in
builtins, and KBUILD_MODNAME for loadables.

The above control-file entries then become:
  init/main.c:1265 [init/main]initcall_blacklist ...
  kernel/power/main.c:49 [kernel/power/main]pm_restore_gfp_mask ...
  kernel/module/main.c:2862 [kernel/module/main]move_module ...
  drivers/base/power/main.c:149 [drivers/base/power/main]device_pm_add ...

While this is a user visible change; [params] becomes [kernel/params],
it is not a behavior change; we now match the query-module against the
subsystem/module name or its kbasename (the simple-modname), which as
before, matches all 4 modules.

This allows queries to be specific when desired: "module init/main",
while preserving the existing meaning of "module main"

The deeper reason for this change is not obvious.  If any builtin
"main" module were to add a classmap, it would attach to all "main"
modules.  If 2 "main" modules defined separate classmaps, both modules
would inadvertently share both classmaps.  Since classmaps map
classnames to 0..62, and independently defined classmaps are most
likely to start at 0 (unless author is planning to share the 0..62
range with other classmaps), we have a setup for later reserved range
conflicts.  Having unique names prevents future conflicts.

This solution isn't perfect:
1. it changes displayed [params] to [kernel/params] etc
2. its mostly redundant with "filename */main.*"
3. "module power", "module module", "module base/power" might be better
   but would break old queries.

Adapt dynamic-debug selftest:
1- Add 'test_subsystem_module_queries' to verify path-based module matching.
2- Use dynamic counting with precise regexes to determine expectations.
3- Reorder tests to run slash-query verification immediately after
   basic tests.
4- Update basic_tests and comma_terminator_tests to use 'kernel/params'
   instead of 'params' to match new path-based names for built-ins.

And adjust Documentation

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3: new patch in rev-3
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst  | 40 ++++++++++----------
 include/linux/dynamic_debug.h                      | 17 +++++++--
 lib/dynamic_debug.c                                |  3 +-
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 44 ++++++++++++++++++++--
 4 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..8befb69575b7 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
-  init/main.c:1426 [main]run_init_process =_ "    %s\n"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
-  init/main.c:1429 [main]run_init_process =_ "    %s\n"
+  init/main.c:1179 [init/main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [init/main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [init/main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [init/main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [init/main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [init/main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
-  init/main.c:1426 [main]run_init_process =p "    %s\n"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
-  init/main.c:1429 [main]run_init_process =p "    %s\n"
+  init/main.c:1424 [init/main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [init/main]run_init_process =p "    %s\n"
+  init/main.c:1427 [init/main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [init/main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
@@ -161,17 +161,19 @@ file
 	file kernel/freezer.c	# ie column 1 of control file
 	file drivers/usb/*	# all callsites under it
 	file inode.c:start_*	# parse :tail as a func (above)
-	file inode.c:1-100	# parse :tail as a line-range (above)
+	file inode.c:1-100	# parse :tail as a line-range (below)
 
 module
-    The given string is compared against the module name
-    of each callsite.  The module name is the string as
-    seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
-
-	module sunrpc
-	module nfsd
-	module drm*	# both drm, drm_kms_helper
+    The query string is compared against the subsystem module name of
+    each callsite, as shown in the control file.  The simple module
+    name is the string as seen in ``lsmod``, i.e. without the
+    directory or the ``.ko`` suffix and with ``-`` changed to ``_``.
+
+    Examples::
+
+	module nfsd        # simple modname (as from lsmod)
+	module init/main   # subsystem modname (as in control file)
+	module drm*	   # both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2d6983186f37..aee6f3d0916f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,17 @@
 
 #include <linux/build_bug.h>
 
+/*
+ * Pick the best name for the module:
+ * KBUILD_MODFILE includes the path (e.g., drivers/usb/core/usbcore) for built-ins.
+ * Fall back to KBUILD_MODNAME for modules (loader requires unique names).
+ */
+#ifdef KBUILD_MODFILE
+# define DDEBUG_MODNAME KBUILD_MODFILE
+#else
+# define DDEBUG_MODNAME KBUILD_MODNAME
+#endif
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -128,9 +139,9 @@ struct _ddebug_class_param {
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct _ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_class_maps") _var = {			\
+	__section("__dyndbg_class_maps") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.length = ARRAY_SIZE(_var##_classnames),		\
@@ -169,7 +180,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg_descs") name = {			\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fdb730db385e..7f78c6b3eeaf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -248,7 +248,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, di->mod_name))
+		    !match_wildcard(query->module, di->mod_name) &&
+		    !match_wildcard(query->module, kbasename(di->mod_name)))
 			continue;
 
 		if (query->class_string) {
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 8b2b7388678e..541a2ea7bcb3 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -76,9 +76,9 @@ function handle_exit_code() {
 # $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
 # $2 - number of times the pattern passed in $1 is expected to match
 # $3 - optional can be set either to "-r" or "-v"
-#       "-r" means relaxed matching in this case pattern provided in $1 is passed
-#       as is without enclosing it with spaces
-#       "-v" prints matching lines
+#       "-r" means relaxed matching in this case pattern provided in
+#       $1 is passed as is without enclosing it with spaces "-v"
+#       prints matching lines
 # $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
 function check_match_ct {
     pattern="\s$1\s"
@@ -223,7 +223,7 @@ function basic_tests {
     check_match_ct =p 0
 
     # module params are builtin to handle boot args
-    check_match_ct '\[params\]' 4 -r
+    check_match_ct '\[kernel/params\]' 4 -r
     ddcmd module params +mpf
     check_match_ct =pmf 4
 
@@ -238,8 +238,44 @@ EOF
     ddcmd =_
 }
 
+function test_subsystem_module_queries {
+    echo -e "${GREEN}# TEST_SUBSYTEM_MODULE_QUERIES ${NC}"
+    ddcmd =_
+
+    # Find how many 'main' modules we have in total (by basename)
+    # Use a more precise regex to avoid false positives like [irqdomain]
+    local total_main=$(grep -c "\[\([^]]*/\)\?main\]" /proc/dynamic_debug/control)
+    echo "# found $total_main total 'main' modules"
+
+    if [ $total_main -eq 0 ]; then
+        echo "SKIP - no 'main' modules found to test slashes"
+        return
+    fi
+
+    echo "# testing 'module */main'"
+    ddcmd module "*/main" +p
+    # This should match modules that HAVE a slash and end in /main
+    local slash_main=$(grep -c "\[[^]]*/main\]" /proc/dynamic_debug/control)
+    check_match_ct =p $slash_main -r
+
+    echo "# testing 'module init/main' (specific path)"
+    ddcmd =_
+    ddcmd module "init/main" +p
+    local init_main=$(grep -c "\[init/main\]" /proc/dynamic_debug/control)
+    check_match_ct =p $init_main
+
+    echo "# testing 'module main' (basename match)"
+    ddcmd =_
+    ddcmd module main +p
+    # This should match ALL $total_main entries due to kbasename matching
+    check_match_ct =p $total_main
+
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
+    test_subsystem_module_queries
 )
 
 # Run tests

-- 
2.54.0

