Return-Path: <lucas.de.marchi@gmail.com>
From: lucas.de.marchi@gmail.com
To: linux-modules@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>,
	Marco d'Itri <md@linux.it>,
	lkml <linux-kernel@vger.kernel.org>,
	Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod 2/3] build: add relevant features to KMOD_FEATURES in config.h
Date: Sun,  7 Jun 2015 03:27:28 -0300
Message-Id: <1433658449-3931-3-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Not all the features (i.e. those available in --enable-* or --with-*)
are really relevant to the final user. Create a KMOD_FEATURES definition
in config.h containing these features.
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index f83eed5..4dc59ec 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,6 +92,7 @@ AS_IF([test "x$with_xz" != "xno"], [
 ], [
 	AC_MSG_NOTICE([Xz support not requested])
 ])
+CC_FEATURE_APPEND([with_features], [with_xz], [XZ])
 
 AC_ARG_WITH([zlib],
 	AS_HELP_STRING([--with-zlib], [handle gzipped modules @<:@default=disabled@:>@]),
@@ -102,6 +103,7 @@ AS_IF([test "x$with_zlib" != "xno"], [
 ], [
 	AC_MSG_NOTICE([zlib support not requested])
 ])
+CC_FEATURE_APPEND([with_features], [with_zlib], [ZLIB])
 
 AC_ARG_WITH([bashcompletiondir],
 	AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
@@ -124,6 +126,7 @@ AM_CONDITIONAL([BUILD_EXPERIMENTAL], [test "x$enable_experimental" = "xyes"])
 AS_IF([test "x$enable_experimental" = "xyes"], [
 	AC_DEFINE(ENABLE_EXPERIMENTAL, [1], [Experimental features.])
 ])
+CC_FEATURE_APPEND([with_features], [enable_experimental], [EXPERIMENTAL])
 
 AC_ARG_ENABLE([tools],
         AS_HELP_STRING([--disable-tools], [disable building tools that provide same functionality as module-init-tools @<:@default=enabled@:>@]),
@@ -256,6 +259,8 @@ CC_CHECK_FLAGS_APPEND([with_ldflags], [LDFLAGS], [ \
 		       -Wl,--gc-sections])
 AC_SUBST([OUR_LDFLAGS], $with_ldflags)
 
+AC_DEFINE_UNQUOTED(KMOD_FEATURES, ["$with_features"], [Features in this build])
+
 #####################################################################
 # Generate files from *.in
 #####################################################################
@@ -297,4 +302,6 @@ AC_MSG_RESULT([
 	doc:			${enable_gtk_doc}
 	man:			${enable_manpages}
 	test-modules:           ${enable_test_modules}
+
+	features:               ${with_features}
 ])
-- 
2.4.2
