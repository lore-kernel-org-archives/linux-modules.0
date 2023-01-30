Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD5C54EED
	for <linux-modules@archiver.kernel.org>; Mon, 30 Jan 2023 18:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjA3Sdz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjA3Sdt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 30 Jan 2023 13:33:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B445F7E
        for <linux-modules@vger.kernel.org>; Mon, 30 Jan 2023 10:33:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10715308wma.1
        for <linux-modules@vger.kernel.org>; Mon, 30 Jan 2023 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zug2rlvwyAWKoa+kNjU88mCb5iXx0M+VsNfcrzFekc=;
        b=kJgbRb3J78urA7aRfFmdp8zA08RXf+5x7YjSTWNGkoKqB//UVJIpfUJurqAeiUAtbW
         yxHe0K+eOGSG8ZYd42+ZTrZ6muW0TlRVbZml00xAgmmlnJ55gb0jlLT+kwdQpdxlkT8D
         kL+8I3zDQ9E++nO1sUyd3y0xTQfCDNWpWzPLL1lvSuJI4+LdIrDFkx4o9SZE2NXPR8sA
         Ml/flIWRsvtK2YLNldrYvmcUsoxF2KuU2N4/tPQj4qYQnswaXeptEId1/vuZGPjvHWno
         9Zt4VEDOQhwM2ZPPny2OGXxOYKAfml1knhzRcX+xQ/ncU89bAXvBoWzzrwwi9HNt8bL6
         CTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zug2rlvwyAWKoa+kNjU88mCb5iXx0M+VsNfcrzFekc=;
        b=radZOkotbQ3rAzaY+jFb2X7ZHAsiGcvzkx9XX+pj3IV9287jgCRLUMiyLYYOcaW9WU
         piwMYC1KoFo+CXnUbSDJLQTvs0OtNQzRpOoSUzLhDGDCUeK6OGXmSAihoOVpBTl93nAd
         7m2mcNPDqNMUrUF5C86tvGvXgfkQSIpvC5jZl8RLDH2FgRu62RQGeTckGwGYouN3yNWx
         JOupT2NdRoLLELuP83Xx/1ZobtUR6zd7xX7VxmiFuZgh6UfpF/PRreXROuGBqndGRtxV
         ZSJYcFn8cGCtxTARX2KIrUuikTkccqLXjwjqDVDNvMgs6nQo6DryHEHCIXGdciOujNKw
         n0mQ==
X-Gm-Message-State: AO0yUKVE2lCNCgVcnab3Z3hdrNf/mOS+iZ9oomfw4/92E6j3aYDkZRNw
        uOOKJQPtiTXm8ROPPNBfUzH0d0d9a/k=
X-Google-Smtp-Source: AK7set+x6oDKsW4TdwnasNcL8qaX4GLuLSmB/K+bvqk8InBuqc7c6Z8SJe1T9tMXLxicYu9igVSBmg==
X-Received: by 2002:a7b:cbc5:0:b0:3dc:59c3:9020 with SMTP id n5-20020a7bcbc5000000b003dc59c39020mr4444824wmi.8.1675103605804;
        Mon, 30 Jan 2023 10:33:25 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:fd59:3fa:6684:66b])
        by smtp.gmail.com with UTF8SMTPSA id p7-20020a1c5447000000b003dc433355aasm9975741wmi.18.2023.01.30.10.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:33:25 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH] depmod: Introduce a outdir option
Date:   Mon, 30 Jan 2023 18:33:24 +0000
Message-Id: <20230130183324.283162-1-emil.l.velikov@gmail.com>
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

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---

Hello team,

Here's a handy feature behind the request at
https://github.com/kmod-project/kmod/issues/13

This is my first time hacking on kmod, so hope I didn't make too many
mistakes :-) There are a few TODO notes below where your input is
greatly appreciated.

TODO:
 - Add tests - team, any pointers or requests?
 - Split the dirnamelen shorthand tenary operator change - is it worth
   it?
---
 man/depmod.xml | 19 +++++++++++++++++++
 tools/depmod.c | 25 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/man/depmod.xml b/man/depmod.xml
index ea0be27..c53624d 100644
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
@@ -151,6 +152,24 @@
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
+            If your modules are stored in a read-only location, you may want to
+            create the output meta-data files in another location. Setting
+            <replaceable>outdir</replaceable> serves as a root to that location
+            similar to how we use <replaceable>basedir</replaceable>. Use this
+            option if you are a distribution vendor who needs to pre-generate
+            the meta-data files rather than running depmod again later.
+          </para>
+        </listitem>
+      </varlistentry>
       <varlistentry>
         <term>
           <option>-C</option>
diff --git a/tools/depmod.c b/tools/depmod.c
index 364b7d4..aaf2327 100644
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
+		"\t-o, --outdir=DIR     The output equivalent of basedir.\n"
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

