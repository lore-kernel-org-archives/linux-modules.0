Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.02
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:05 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 3/9] config: Use _cleanup_free_
Date: Mon, 18 Nov 2013 12:04:21 -0200
Message-Id: <1384783467-23476-4-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-config.c | 62 +++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index c5f4803..32adb8b 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -2,6 +2,7 @@
  * libkmod - interface to kernel module operations
  *
  * Copyright (C) 2011-2013  ProFUSION embedded systems
+ * Copyright (C) 2013  Intel Corporation. All rights reserved.
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -145,7 +146,7 @@ static int kmod_config_add_command(struct kmod_config *config,
 						const char *command_name,
 						struct kmod_list **list)
 {
-	struct kmod_command *cmd;
+	_cleanup_free_ struct kmod_command *cmd;
 	struct kmod_list *l;
 	size_t modnamelen = strlen(modname) + 1;
 	size_t commandlen = strlen(command) + 1;
@@ -154,25 +155,20 @@ static int kmod_config_add_command(struct kmod_config *config,
 								command);
 
 	cmd = malloc(sizeof(*cmd) + modnamelen + commandlen);
-	if (cmd == NULL)
-		goto oom_error_init;
+	if (!cmd)
+		return -ENOMEM;
 
 	cmd->command = sizeof(*cmd) + modnamelen + (char *)cmd;
 	memcpy(cmd->modname, modname, modnamelen);
 	memcpy(cmd->command, command, commandlen);
 
 	l = kmod_list_append(*list, cmd);
-	if (l == NULL)
-		goto oom_error;
+	if (!l)
+		return -ENOMEM;
 
 	*list = l;
+	cmd = NULL;
 	return 0;
-
-oom_error:
-	free(cmd);
-oom_error_init:
-	ERR(config->ctx, "out-of-memory\n");
-	return -ENOMEM;
 }
 
 static void kmod_config_free_command(struct kmod_config *config,
@@ -188,7 +184,7 @@ static void kmod_config_free_command(struct kmod_config *config,
 static int kmod_config_add_options(struct kmod_config *config,
 				const char *modname, const char *options)
 {
-	struct kmod_options *opt;
+	_cleanup_free_ struct kmod_options *opt;
 	struct kmod_list *list;
 	size_t modnamelen = strlen(modname) + 1;
 	size_t optionslen = strlen(options) + 1;
@@ -196,8 +192,8 @@ static int kmod_config_add_options(struct kmod_config *config,
 	DBG(config->ctx, "modname='%s' options='%s'\n", modname, options);
 
 	opt = malloc(sizeof(*opt) + modnamelen + optionslen);
-	if (opt == NULL)
-		goto oom_error_init;
+	if (!opt)
+		return -ENOMEM;
 
 	opt->options = sizeof(*opt) + modnamelen + (char *)opt;
 
@@ -206,17 +202,12 @@ static int kmod_config_add_options(struct kmod_config *config,
 	strchr_replace(opt->options, '\t', ' ');
 
 	list = kmod_list_append(config->options, opt);
-	if (list == NULL)
-		goto oom_error;
+	if (!list)
+		return -ENOMEM;
 
+	opt = NULL;
 	config->options = list;
 	return 0;
-
-oom_error:
-	free(opt);
-oom_error_init:
-	ERR(config->ctx, "out-of-memory\n");
-	return -ENOMEM;
 }
 
 static void kmod_config_free_options(struct kmod_config *config,
@@ -232,7 +223,7 @@ static void kmod_config_free_options(struct kmod_config *config,
 static int kmod_config_add_alias(struct kmod_config *config,
 					const char *name, const char *modname)
 {
-	struct kmod_alias *alias;
+	_cleanup_free_ struct kmod_alias *alias;
 	struct kmod_list *list;
 	size_t namelen = strlen(name) + 1, modnamelen = strlen(modname) + 1;
 
@@ -240,7 +231,7 @@ static int kmod_config_add_alias(struct kmod_config *config,
 
 	alias = malloc(sizeof(*alias) + namelen + modnamelen);
 	if (!alias)
-		goto oom_error_init;
+		return -ENOMEM;
 
 	alias->name = sizeof(*alias) + modnamelen + (char *)alias;
 
@@ -249,16 +240,11 @@ static int kmod_config_add_alias(struct kmod_config *config,
 
 	list = kmod_list_append(config->aliases, alias);
 	if (!list)
-		goto oom_error;
+		return -ENOMEM;
 
+	alias = NULL;
 	config->aliases = list;
 	return 0;
-
-oom_error:
-	free(alias);
-oom_error_init:
-	ERR(config->ctx, "out-of-memory name=%s modname=%s\n", name, modname);
-	return -ENOMEM;
 }
 
 static void kmod_config_free_alias(struct kmod_config *config,
@@ -274,26 +260,22 @@ static void kmod_config_free_alias(struct kmod_config *config,
 static int kmod_config_add_blacklist(struct kmod_config *config,
 							const char *modname)
 {
-	char *p;
+	_cleanup_free_ char *p;
 	struct kmod_list *list;
 
 	DBG(config->ctx, "modname=%s\n", modname);
 
 	p = strdup(modname);
 	if (!p)
-		goto oom_error_init;
+		return -ENOMEM;
 
 	list = kmod_list_append(config->blacklists, p);
 	if (!list)
-		goto oom_error;
+		return -ENOMEM;
+
+	p = NULL;
 	config->blacklists = list;
 	return 0;
-
-oom_error:
-	free(p);
-oom_error_init:
-	ERR(config->ctx, "out-of-memory modname=%s\n", modname);
-	return -ENOMEM;
 }
 
 static void kmod_config_free_blacklist(struct kmod_config *config,
-- 
1.8.4.2
