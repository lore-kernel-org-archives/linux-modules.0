Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.06
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:08 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 4/9] util: use _cleanup_free_ on path_make_absolute_cwd()
Date: Mon, 18 Nov 2013 12:04:22 -0200
Message-Id: <1384783467-23476-5-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-util.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index d686250..837f417 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -283,15 +283,15 @@ bool path_is_absolute(const char *p)
 
 char *path_make_absolute_cwd(const char *p)
 {
-	char *cwd, *r;
-	size_t plen;
-	size_t cwdlen;
+	_cleanup_free_ char *cwd = NULL;
+	size_t plen, cwdlen;
+	char *r;
 
 	if (path_is_absolute(p))
 		return strdup(p);
 
 	cwd = get_current_dir_name();
-	if (cwd == NULL)
+	if (!cwd)
 		return NULL;
 
 	plen = strlen(p);
@@ -299,11 +299,10 @@ char *path_make_absolute_cwd(const char *p)
 
 	/* cwd + '/' + p + '\0' */
 	r = realloc(cwd, cwdlen + 1 + plen + 1);
-	if (r == NULL) {
-		free(cwd);
+	if (r == NULL)
 		return NULL;
-	}
 
+	cwd = NULL;
 	r[cwdlen] = '/';
 	memcpy(&r[cwdlen + 1], p, plen + 1);
 
-- 
1.8.4.2
