Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B6472F8A
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667460; cv=none; b=o53fmOlzXQZJdQoFYav4vF95Zche1lbcUDns2+vMCHjkF/C0RVOTpgfkqioduSdfvc467h1lwE303GRArQRx68ZnEKqawkBHrYmVDHjaJQwU4QOSqVqmv6aszft/wNMd1RCxONlrucuc2oLSjzQMviJGpUtefhk/ljMU9Eun028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667460; c=relaxed/simple;
	bh=1n7IC7PfpYM+hXbsq1NGjwG5cBrYKrktPRR4zxI7gDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/uTa0ytKJWkH6ag3pZQA1cuIl0oLhx/ECpm0lbLi8g/eF5+x1ntQq1hjrMCl4R2lwOvhYBbz5tIUIpVQ2N5rtMC96HDbio5/bq6RGjY9t+44gs41bbHR8xiCYxJBt5AGQLwAEefBQko0XkXK++NIwxcpSx150trPhKILXQQDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLJ4Zncy; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLJ4Zncy"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec49608332so2723601a34.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667454; x=1785272254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4B8vyMZCU8HLuUIRma2ONfzr2g/7Ttdly2c8udYdyM=;
        b=CLJ4ZncyLLFJvmt3HqaqZLEbZTYkLt7Y4qHfRSMuOvsAUPVICHzZkQj/jAfjC+c7hz
         Sm1TZAJX473NM9l9AYh+Td+Hu3akZ4XNTVqPj6mSq9lkJBVudk6GzWEasWHhAlvqLw7+
         gAMh0K/AGUdtuEUBGOfXzzV8K8UZLVnN2lJE93OwuBmxL6LUwJ1R8Aay9GhmpczKrqLi
         P5GWy4peOoIASnnyrvOBAi1RFQO3hHNHq8dzTJYEBFdy4HhVeX/VQQ/U0ODQo9jeJi22
         b7UnFqhIJBdDIMkhg2MD1P/Z8igOCGcQ1DhEK/lopkV445Q5SQxZs8UL78SJ+huJxKiQ
         gIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667454; x=1785272254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4B8vyMZCU8HLuUIRma2ONfzr2g/7Ttdly2c8udYdyM=;
        b=aRBb8BouxQNNXsO+YHr5vYvFTlBtsOrAoFLSC8PItqHbxiEN3N6eO1k/jQiDCGCiPH
         dClzyOMCtjYCgrYL4tkic8k3m7HwH6Aj7MsyXXo8Q0iVcGyDeUq/mLiomdKh6ea+Zbzh
         /B40XababjnUbKNEA+pkQkJ2UaZPxrIlPg+BohMEMJnEkA4KXJKzl5tCy2IO0LRuqZAw
         h2kt7e/MB/OkV1XkX3yktGUoGHEQt+YHfOK0/OXr4ML0o4fLh8D+bSyt3x2nAj6YLECN
         g59FmmBU1BvBwvfUGNU7h2SnlqxLTvxVfNQ9XTuhutmVtoTjvpC5s7zLuSRQ6fUnIdYu
         AURw==
X-Forwarded-Encrypted: i=1; AHgh+RrI8OZCjo4LTfH6ELm14MmcEqORuHRXlQTGhop5CvJR6xKJuF4h+fl9UJwQ6We02waIlbf9HF6LniiR9Rw6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vmyPT9dfjPN1LFX0DBQUR84tjgc3Qtc6n4NQVktVJ/dTgwaL
	jXLS+kvQEzBW5malPVFqr2DA3k6C6e7bNIgwXaSLA0KO8KVJEHj17WYHAXDZJg==
X-Gm-Gg: AfdE7clgUPxXjZtFPyO9Dw4v9prkSSdg1lQymX7yLL8pY500SLkwe9GpvJN6t7utYMi
	QNwiicAc2MgPFc7cIadT9xx5MZgtPR7rgiwcERT6/tPJxUHffiGAI5CGbpiVT7a9ErjKXKv60yy
	+5Nymz//Fw6o9el/l8sARJeQxkvqr5vxxGcB/Y3POn/lqtLZMw/mJs+dHKbi7EpvqKhyXyhL0Qq
	qqINk6zj0u3IAsunfL3RS5WP58IKc9zD4FA8OLOi5VSfKpIOqSY+1zgpOSq+B6FJdsHdkQcbWJs
	wK9XabJ6C+bcseEObJMwB8JguUKquGdcsyeG+9NXsABL5KE7vJTWJ9n2Y9Xut43pp+iXLjpuO1x
	2w+rRcKhjHKIazK08EGD3gRdCzJg4PMJQtyDM3ufbtoN02SvyBH5c/dP1ppUGuj6Y0qOeUM2uDG
	4zvCEELbzb0VlkL9heLxuyDL3vVdUkQuX5hMhIdciPayr7oPu7REouTFSe7uMipSyOdD6/aKFsK
	QPDIhs8OhP4Q6Nq8H24YbX1ug==
X-Received: by 2002:a05:6830:4491:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7eda0944570mr12093837a34.15.1784667454496;
        Tue, 21 Jul 2026 13:57:34 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:08 -0600
Subject: [PATCH v7 19/29] dyndbg: use KBUILD_MODFILE for unique builtin
 module names
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-19-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=12279;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=1n7IC7PfpYM+hXbsq1NGjwG5cBrYKrktPRR4zxI7gDg=;
 b=Zs+NHEL6ij1S7xroZy7bsh0wjbihnSSw8Bc5AtbMEMYPuXEl7tn4ojD91n/FPhtMqDejKLXR9
 J9PV4VXxiZHAwP/g9zGvf9XkPlDD0GTcy4BcrAfWnyKlp4nC7VOdoFU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Historically dynamic-debug gets its module names from KBUILD_MODNAME.
This works well for loadable modules, as the module loader has always
required them to have unique names, but for builtins it is basically
kbasename(srcfile), which sadly gives us many modules named "main".

IOW, it makes this ambiguous:
  bash-5.3# echo module main +m > /proc/dynamic_debug/control

since it would affect all 4 independent modules named main:
  bash-5.3# ddgrep =m
  init/main.c:1265 [main]initcall_blacklist =m "blacklisting initcall %s\n"
  kernel/power/main.c:49 [main]pm_restore_gfp_mask =m "GFP mask restored\n"
  kernel/module/main.c:2862 [main]move_module =m "\t0x%lx 0x%.8lx %s\n"
  drivers/base/power/main.c:149 [main]device_pm_add =m "Adding info for %s:%s\n"

We can improve this by adding DDEBUG_MODNAME, which is KBUILD_MODFILE
for dyndbg's builtins (which is unique), and KBUILD_MODNAME for
loadables (which is already required/guaranteed to be unique by
module-loader):

The above control-file entries then become:
  init/main.c:1265 [init/main]initcall_blacklist ...
  kernel/power/main.c:49 [kernel/power/main]pm_restore_gfp_mask ...
  kernel/module/main.c:2862 [kernel/module/main]move_module ...
  drivers/base/power/main.c:149 [drivers/base/power/main]device_pm_add ...

While this is a user visible change; [params] becomes [kernel/params]
etc, it is not a behavior change; we now match the query-module
against the subsystem/module name or its kbasename (the
simple-modname), which as before, matches all 4 modules.

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
3. Ideally, queries like "module power", "module module", "module
   base/power" might be better but would break old queries.

Adding classmaps to any of the builtins named "[main]" is unlikely, so
this change isn't absolutely necessary, but it seemed proper to at
least address the latent problem.

Summary:

1. DDEBUG_MODNAME is either KBUILD_MODFILE or KBUILD_MODNAME.

2. Update basic-tests working against init/main.c pr_debugs to
validate changes to "[init/main]" as the state-of-interest (where the
relevant state is in the control file).

3. update GOLDEN_RECORDS to for changed state-of-interest in
dynamic_debug/control, where [main] became [*/main]

4. Adjust Documentation with "simple modname" and "subsystem modname".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v7: checksum updates - needed due to [module] display changes
v5: move ahead of array-slice patch to silence sashiko complaint about it
v4: call match_wildcard_hyphen() to allow dash vs underscore modname equivalence
v3: use KBUILD_MODFILE to give unique modnames for builtins

Note: Updated expected FT_basic_queries hashes to reflect the new unique 'kernel/params' module name format introduced by KBUILD_MODFILE.
---
 Documentation/admin-guide/dynamic-debug-howto.rst  | 42 ++++++++++++----------
 include/linux/dynamic_debug.h                      | 15 ++++++--
 lib/dynamic_debug.c                                |  3 +-
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 26 ++++++--------
 4 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..99bbae37d34e 100644
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
 
@@ -161,17 +161,21 @@ file
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
+    each callsite, as shown in the control file, or its simple name.
+    The simple module name is the string as seen in ``lsmod``,
+    i.e. without the directory or the ``.ko`` suffix and with ``-``
+    changed to ``_``.
+    Examples::
+
+        module nfsd        # simple modname (as from lsmod)
+	module init/main   # subsystem modname (as in control file)
+	module */main	   # any subsystem ending in main
+        module main	   # simple modname, selects same as above
+	module drm*	   # both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index baf5c0853f45..17cc1ae7baef 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -10,6 +10,17 @@
 
 #define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
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
@@ -121,7 +132,7 @@ struct ddebug_class_param {
 	static struct ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.class_names = _var##_classnames,			\
@@ -160,7 +171,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 251df88cb04e..f66e5373e61e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -239,7 +239,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard_hyphen(query->module, dt->mod_name) &&
+		    !match_wildcard_hyphen(query->module, kbasename(dt->mod_name)))
 			continue;
 
 		if (query->class_string) {
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 6e977486ea90..947f23dcb4ce 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -461,7 +461,8 @@ function FT_hyphen_underscore {
     ddcmd =_
 }
 
-# test parsing on spaces, commas. testing agains builtin [kernel/params]
+# test parsing on spaces, commas. testing against builtin [kernel/params]
+# disabled pending feature patch
 function FT_comma_terminators {
     v_echo "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
@@ -470,15 +471,9 @@ function FT_comma_terminators {
     fi
     ddcmd "module params =_"
 
-    # 1. Verify transition after commas-as-spaces query and splitting on @
-    # Use non-printing decorator flags (+mf) to avoid print-enabling (+p) and
-    # prevent syslog pollution
-    #ddcmd "module,params,=_ @ module,params,+mf" 'kernel/params.c'
-
-    # 2. Verify transition after ignored-commas query
+    ddcmd "module,params,=_ @ module,params,+mf" 'kernel/params.c'
+    # ignore empty tokens
     ddcmd ",module ,, ,  params, -p" 'kernel/params.c'
-
-    # 3. Verify transition after quoted-commas query
     ddcmd " , module ,,, ,  params, -m" 'kernel/params.c'
 
     ddcmd =_
@@ -688,13 +683,12 @@ function GOLDEN_RECORDS {
 #K= 781995971d28f732a792522f3c56cdd3 FT_grammar_errs.40       dmesg
 #K= 6614a677d9f9ac09d9825b4e989d2c42 FT_grammar_errs.41       dmesg
 #K= 70de9afed457a6be9f9c3c81cbd6d4d5 FT_grammar_errs.42       dmesg
-#K= 9a7aaed40738f1c5203af2e421a20bc2 FT_basic_queries.1       "kernel/params.c"
-#K= 2a57a9e283a3912de3fa5e006fb330cc FT_basic_queries.2       "kernel/params.c"
-#K= fed3186684428b2f05bcf5df960c639c FT_basic_queries.3       "kernel/params.c"
-#K= 551f9801b6008553661453021ae6dfd3 FT_basic_queries.4       "kernel/params.c"
-#K= 33f7162ac85020894fab9752ef07b89c FT_basic_queries.5       "kernel/params.c"
-#K= 544d955c3bb9d3c78704f780d91396e0 FT_basic_queries.6       "kernel/params.c"
-# ------------------------------
+#K= 24d85e3b86f3d5f7640995922d91e08c FT_basic_queries.1       "kernel/params.c"
+#K= 958898bcd9736a94e1f8b293b230a96a FT_basic_queries.2       "kernel/params.c"
+#K= 130118da5a296e4039865d167e06cacd FT_basic_queries.3       "kernel/params.c"
+#K= da6bd1c6a299290150668186f8263b82 FT_basic_queries.4       "kernel/params.c"
+#K= 82572e8d20c4b567afac783006d1a935 FT_basic_queries.5       "kernel/params.c"
+#K= baea1247680e8151c121539f4b90a6d8 FT_basic_queries.6       "kernel/params.c"
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

