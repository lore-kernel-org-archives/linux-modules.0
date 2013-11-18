Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.21
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:24 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 9/9] module: use _cleanup_free and remove useless call to free()
Date: Mon, 18 Nov 2013 12:04:27 -0200
Message-Id: <1384783467-23476-10-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-module.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 3adbb69..2f92e16 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -252,10 +252,8 @@ static int kmod_module_new(struct kmod_ctx *ctx, const char *key,
 		keylen = namelen + aliaslen + 1;
 
 	m = malloc(sizeof(*m) + (alias == NULL ? 1 : 2) * (keylen + 1));
-	if (m == NULL) {
-		free(m);
+	if (m == NULL)
 		return -ENOMEM;
-	}
 
 	memset(m, 0, sizeof(*m));
 
@@ -971,7 +969,8 @@ static int module_do_install_commands(struct kmod_module *mod,
 					struct probe_insert_cb *cb)
 {
 	const char *command = kmod_module_get_install_commands(mod);
-	char *p, *cmd;
+	char *p;
+	_cleanup_free_ char *cmd;
 	int err;
 	size_t cmdlen, options_len, varlen;
 
@@ -994,10 +993,9 @@ static int module_do_install_commands(struct kmod_module *mod,
 		size_t slen = cmdlen - varlen + options_len;
 		char *suffix = p + varlen;
 		char *s = malloc(slen + 1);
-		if (s == NULL) {
-			free(cmd);
+		if (!s)
 			return -ENOMEM;
-		}
+
 		memcpy(s, cmd, p - cmd);
 		memcpy(s + prefixlen, options, options_len);
 		memcpy(s + prefixlen + options_len, suffix, suffixlen);
@@ -1013,8 +1011,6 @@ static int module_do_install_commands(struct kmod_module *mod,
 	else
 		err = command_do(mod, "install", cmd);
 
-	free(cmd);
-
 	return err;
 }
 
-- 
1.8.4.2
