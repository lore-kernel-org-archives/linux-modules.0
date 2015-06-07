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
Subject: [PATCH kmod 3/3] tools: display features together with version information
Date: Sun,  7 Jun 2015 03:27:29 -0300
Message-Id: <1433658449-3931-4-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 tools/depmod.c   | 1 +
 tools/insmod.c   | 1 +
 tools/kmod.c     | 1 +
 tools/modinfo.c  | 1 +
 tools/modprobe.c | 1 +
 tools/rmmod.c    | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/depmod.c b/tools/depmod.c
index 231b9ab..2a08b6e 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2466,6 +2466,7 @@ static int do_depmod(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'V':
 			puts(PACKAGE " version " VERSION);
+			puts(KMOD_FEATURES);
 			return EXIT_SUCCESS;
 		case '?':
 			goto cmdline_failed;
diff --git a/tools/insmod.c b/tools/insmod.c
index 2a0accb..8e72e11 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -88,6 +88,7 @@ static int do_insmod(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'V':
 			puts(PACKAGE " version " VERSION);
+			puts(KMOD_FEATURES);
 			return EXIT_SUCCESS;
 		case '?':
 			return EXIT_FAILURE;
diff --git a/tools/kmod.c b/tools/kmod.c
index c9d2cc8..28217df 100644
--- a/tools/kmod.c
+++ b/tools/kmod.c
@@ -114,6 +114,7 @@ static int handle_kmod_commands(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'V':
 			puts("kmod version " VERSION);
+			puts(KMOD_FEATURES);
 			return EXIT_SUCCESS;
 		case '?':
 			return EXIT_FAILURE;
diff --git a/tools/modinfo.c b/tools/modinfo.c
index 94d55c9..86ac04b 100644
--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -405,6 +405,7 @@ static int do_modinfo(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'V':
 			puts(PACKAGE " version " VERSION);
+			puts(KMOD_FEATURES);
 			return EXIT_SUCCESS;
 		case '?':
 			return EXIT_FAILURE;
diff --git a/tools/modprobe.c b/tools/modprobe.c
index 8af4922..3ba8f52 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -824,6 +824,7 @@ static int do_modprobe(int argc, char **orig_argv)
 			break;
 		case 'V':
 			puts(PACKAGE " version " VERSION);
+			puts(KMOD_FEATURES);
 			err = 0;
 			goto done;
 		case 'h':
diff --git a/tools/rmmod.c b/tools/rmmod.c
index 75fc7b5..bcdea4c 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -128,6 +128,7 @@ static int do_rmmod(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'V':
 			puts(PACKAGE " version " VERSION);
+			puts(KMOD_FEATURES);
 			return EXIT_SUCCESS;
 		case '?':
 			return EXIT_FAILURE;
-- 
2.4.2
