Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C7C05027
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBFNUZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 08:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBFNUM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 08:20:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB48241DB
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 05:18:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so10343407wrj.3
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSV2S/sunY/xl2ftfrMg4JjcfjasrRb3y8SIX6juouU=;
        b=LKrT2/88ub8vPuFvDCMxkX4gCVC0rgoCzHV8QihrnLZMhxdADOkGXwbJmva/A5xjXi
         GokbkctxgaJTgoVcfS+xt2S30Kv+mSwAK/nIOnzOVzXM4U/cKV6Ynpu09txmh8AOJy5N
         8fclvEWwLOscpfPuuyQtpbxDtZ8DlQwOnEeQsLat0NF4nCLqkH/lLBoqN/Ov/cn4jMwq
         yz0ZEzl3lBFezem/Y6+/Puj+nAEDv9HK7EPCsUOdezRBfTDFxAjs+1lB7c+cq3FntWH9
         jb/VE3IU4qdWfaiT5WIm48AXfiUZS8nVgSkJ9MJjINBQpQX6uXWqwhlQDMu/GQW6hwDj
         ZT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSV2S/sunY/xl2ftfrMg4JjcfjasrRb3y8SIX6juouU=;
        b=B4tSbw26Up3GCMV9zDpaAiFzThD4xZaxjXYfxqnZ1x/A5a4dmN32LJDfXbBdYrbbWD
         SAd5mx8nXonu1nAA/IfGtsDK256PrrDHX1VSYV6LO7gvxTqnQYsMYNQosFrrxXX+pyGX
         hrQc5Fk1qTkVwd/2fHLcKBIuPax2hfoR/xD7AuFEVpBE1l8FsCheBW9WceLJ4Smb5CFX
         hwTWy2nxPzZIT9j2S6t8gBiD6PmWSW84qReC+BGqUoP0olB7JSwU4F/9xMRHSUmZDGHn
         jtesHuJu2iaygbxNJiLJpxCHPzH+sDPIzR7GI1IDKDo0YkAlyfe+JYLLMPXpmWTHJX2+
         /20A==
X-Gm-Message-State: AO0yUKUi8p7szgmnhAnxyUcQzfgyZe7I+F6AVI/PcmFVNKoT89PpBsqM
        t3AECbvB6AxDHRHrtvoZQdQqy4yk8qY=
X-Google-Smtp-Source: AK7set/kDgja57792zB8q8chYqNhIP32A3hNSjrZyf8kSihcUShF21+L7mW/A6/6rnA0M4yEFS/DIw==
X-Received: by 2002:a5d:6d8e:0:b0:2bf:b872:cf29 with SMTP id l14-20020a5d6d8e000000b002bfb872cf29mr22770375wrs.2.1675689516169;
        Mon, 06 Feb 2023 05:18:36 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id bw17-20020a0560001f9100b002be25db0b7bsm8933967wrb.10.2023.02.06.05.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:18:35 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2] depmod: Introduce outdir option
Date:   Mon,  6 Feb 2023 13:18:34 +0000
Message-Id: <20230206131834.559229-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

This option is equivalent to basedir, with the small difference being
that's where the meta-data files are generated. In other words, this
allows us to have read-only input modules and modules.dep, while still
being able to generate the meta-data files.

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Here's a handy feature behind the request at
https://github.com/kmod-project/kmod/issues/13

v2:
 - alternative wording for manpage and help screen (thanks Lucas)
 - add test case

NOTE: skipping the test (as well as some surrounding ones) seems
dubious, but it's added for consistency. Will send another series with
papercuts shortly, to drop that... if applicable that is :-)
---
 man/depmod.xml                                | 20 ++++++++++
 testsuite/populate-modules.sh                 |  3 ++
 .../lib/modules/4.4.4/modules.alias           | 37 +++++++++++++++++++
 .../lib/modules/4.4.4/modules.builtin         |  0
 .../lib/modules/4.4.4/modules.order           |  7 ++++
 testsuite/test-depmod.c                       | 34 +++++++++++++++++
 tools/depmod.c                                | 25 +++++++++++--
 7 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
 create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order

diff --git a/man/depmod.xml b/man/depmod.xml
index ea0be27..3b00971 100644
--- a/man/depmod.xml
+++ b/man/depmod.xml
@@ -45,6 +45,7 @@
     <cmdsynopsis>
       <command>depmod</command>
       <arg><option>-b <replaceable>basedir</replaceable></option></arg>
+      <arg><option>-o <replaceable>outdir</replaceable></option></arg>
       <arg><option>-e</option></arg>
       <arg><option>-E <replaceable>Module.symvers</replaceable></option></arg>
       <arg><option>-F <replaceable>System.map</replaceable></option></arg>
@@ -151,6 +152,25 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>
+          <option>-o <replaceable>outdir</replaceable></option>
+        </term>
+        <term>
+          <option>--outdir <replaceable>outdir</replaceable></option>
+        </term>
+        <listitem>
+          <para>
+            Set the output directory where depmod will store any generated file.
+            <replaceable>outdir</replaceable> serves as a root to that location,
+            similar to how <replaceable>basedir</replaceable> is used. Also this
+            setting takes precedence and if used together with
+            <replaceable>basedir</replaceable> it will result in the input being
+            that directory, but the output being the one set by
+            <replaceable>outdir</replaceable>.
+          </para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term>
           <option>-C</option>
diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index aa6d5c2..5009cac 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -61,6 +61,9 @@ map=(
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
     ["test-modinfo/mod-simple-i386.ko"]="mod-simple-i386.ko"
     ["test-modinfo/mod-simple-x86_64.ko"]="mod-simple-x86_64.ko"
     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
new file mode 100644
index 0000000..5675329
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
@@ -0,0 +1,37 @@
+# Aliases extracted from modules themselves.
+alias pci:v0000103Cd00003230sv0000103Csd0000323Dbc*sc*i* cciss
+alias pci:v0000103Cd00003230sv0000103Csd00003237bc*sc*i* cciss
+alias pci:v0000103Cd00003238sv0000103Csd00003215bc*sc*i* cciss
+alias pci:v0000103Cd00003238sv0000103Csd00003214bc*sc*i* cciss
+alias pci:v0000103Cd00003238sv0000103Csd00003213bc*sc*i* cciss
+alias pci:v0000103Cd00003238sv0000103Csd00003212bc*sc*i* cciss
+alias pci:v0000103Cd00003238sv0000103Csd00003211bc*sc*i* cciss
+alias pci:v0000103Cd00003230sv0000103Csd00003235bc*sc*i* cciss
+alias pci:v0000103Cd00003230sv0000103Csd00003234bc*sc*i* cciss
+alias pci:v0000103Cd00003230sv0000103Csd00003223bc*sc*i* cciss
+alias pci:v0000103Cd00003220sv0000103Csd00003225bc*sc*i* cciss
+alias pci:v00000E11d00000046sv00000E11sd0000409Dbc*sc*i* cciss
+alias pci:v00000E11d00000046sv00000E11sd0000409Cbc*sc*i* cciss
+alias pci:v00000E11d00000046sv00000E11sd0000409Bbc*sc*i* cciss
+alias pci:v00000E11d00000046sv00000E11sd0000409Abc*sc*i* cciss
+alias pci:v00000E11d00000046sv00000E11sd00004091bc*sc*i* cciss
+alias pci:v00000E11d0000B178sv00000E11sd00004083bc*sc*i* cciss
+alias pci:v00000E11d0000B178sv00000E11sd00004082bc*sc*i* cciss
+alias pci:v00000E11d0000B178sv00000E11sd00004080bc*sc*i* cciss
+alias pci:v00000E11d0000B060sv00000E11sd00004070bc*sc*i* cciss
+alias pci:v0000103Cd*sv*sd*bc01sc04i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003356bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003355bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003354bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003353bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003352bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003351bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Bsv0000103Csd00003350bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003233bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd0000324Bbc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd0000324Abc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003249bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003247bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003245bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003243bc*sc*i* hpsa
+alias pci:v0000103Cd0000323Asv0000103Csd00003241bc*sc*i* hpsa
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
new file mode 100644
index 0000000..4b64309
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
@@ -0,0 +1,7 @@
+#336
+kernel/drivers/block/cciss.ko
+#2094
+kernel/drivers/scsi/scsi_mod.ko
+#2137
+kernel/drivers/scsi/hpsa.ko
+
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index d7802d7..6465230 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -57,6 +57,40 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
 		},
 	});
 
+#define MODULES_OUTDIR_UNAME "4.4.4"
+#define MODULES_OUTDIR_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-outdir"
+#define MODULES_OUTDIR_LIB_MODULES_OUTPUT MODULES_OUTDIR_ROOTFS "/outdir/lib/modules/" MODULES_OUTDIR_UNAME
+#define MODULES_OUTDIR_LIB_MODULES_INPUT MODULES_OUTDIR_ROOTFS "/lib/modules/" MODULES_OUTDIR_UNAME
+static noreturn int depmod_modules_outdir(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		"--outdir", MODULES_OUTDIR_ROOTFS "/outdir/",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+
+DEFINE_TEST(depmod_modules_outdir,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+        .skip = true,
+#endif
+	.description = "check if depmod honours the outdir option",
+	.config = {
+		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
+		[TC_ROOTFS] = MODULES_OUTDIR_ROOTFS,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ MODULES_OUTDIR_LIB_MODULES_OUTPUT "/modules.alias",
+			  MODULES_OUTDIR_LIB_MODULES_INPUT "/modules.alias" },
+			{ }
+		},
+	});
+
 #define SEARCH_ORDER_SIMPLE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-simple"
 static noreturn int depmod_search_order_simple(const struct test *t)
 {
diff --git a/tools/depmod.c b/tools/depmod.c
index 364b7d4..5536597 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -58,11 +58,12 @@ static const char *default_cfg_paths[] = {
 	NULL
 };
 
-static const char cmdopts_s[] = "aAb:C:E:F:euqrvnP:wmVh";
+static const char cmdopts_s[] = "aAb:o:C:E:F:euqrvnP:wmVh";
 static const struct option cmdopts[] = {
 	{ "all", no_argument, 0, 'a' },
 	{ "quick", no_argument, 0, 'A' },
 	{ "basedir", required_argument, 0, 'b' },
+	{ "outdir", required_argument, 0, 'o' },
 	{ "config", required_argument, 0, 'C' },
 	{ "symvers", required_argument, 0, 'E' },
 	{ "filesyms", required_argument, 0, 'F' },
@@ -104,6 +105,7 @@ static void help(void)
 		"\n"
 		"The following options are useful for people managing distributions:\n"
 		"\t-b, --basedir=DIR    Use an image of a module tree.\n"
+		"\t-o, --outdir=DIR     Output directory for generated files.\n"
 		"\t-F, --filesyms=FILE  Use the file instead of the\n"
 		"\t                     current kernel symbols.\n"
 		"\t-E, --symvers=FILE   Use Module.symvers file to check\n"
@@ -467,6 +469,8 @@ struct cfg {
 	const char *kversion;
 	char dirname[PATH_MAX];
 	size_t dirnamelen;
+	char outdirname[PATH_MAX];
+	size_t outdirnamelen;
 	char sym_prefix;
 	uint8_t check_symvers;
 	uint8_t print_unknown;
@@ -2576,7 +2580,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 		{ "modules.devname", output_devname },
 		{ }
 	};
-	const char *dname = depmod->cfg->dirname;
+	const char *dname = depmod->cfg->outdirname;
 	int dfd, err = 0;
 	struct timeval tv;
 
@@ -2585,6 +2589,11 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 	if (out != NULL)
 		dfd = -1;
 	else {
+		err = mkdir_p(dname, strlen(dname), 0755);
+		if (err < 0) {
+			CRIT("could not create directory %s: %m\n", dname);
+			return err;
+		}
 		dfd = open(dname, O_RDONLY);
 		if (dfd < 0) {
 			err = -errno;
@@ -2898,6 +2907,7 @@ static int do_depmod(int argc, char *argv[])
 	FILE *out = NULL;
 	int err = 0, all = 0, maybe_all = 0, n_config_paths = 0;
 	_cleanup_free_ char *root = NULL;
+	_cleanup_free_ char *out_root = NULL;
 	_cleanup_free_ const char **config_paths = NULL;
 	const char *system_map = NULL;
 	const char *module_symvers = NULL;
@@ -2927,6 +2937,11 @@ static int do_depmod(int argc, char *argv[])
 				free(root);
 			root = path_make_absolute_cwd(optarg);
 			break;
+		case 'o':
+			if (out_root)
+				free(out_root);
+			out_root = path_make_absolute_cwd(optarg);
+			break;
 		case 'C': {
 			size_t bytes = sizeof(char *) * (n_config_paths + 2);
 			void *tmp = realloc(config_paths, bytes);
@@ -3009,7 +3024,11 @@ static int do_depmod(int argc, char *argv[])
 
 	cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
 				  "%s/lib/modules/%s",
-				  root == NULL ? "" : root, cfg.kversion);
+				  root ?: "", cfg.kversion);
+
+	cfg.outdirnamelen = snprintf(cfg.outdirname, PATH_MAX,
+				     "%s/lib/modules/%s",
+				     out_root ?: (root ?: ""), cfg.kversion);
 
 	if (optind == argc)
 		all = 1;
-- 
2.39.1

