Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.12
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:14 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 6/9] util: Be OOM-safe and use _cleanup_free_
Date: Mon, 18 Nov 2013 12:04:24 -0200
Message-Id: <1384783467-23476-7-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-util.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
index 837f417..df12433 100644
--- a/libkmod/libkmod-util.c
+++ b/libkmod/libkmod-util.c
@@ -46,8 +46,8 @@
 char *getline_wrapped(FILE *fp, unsigned int *linenum)
 {
 	int size = 256;
-	int i = 0;
-	char *buf = malloc(size);
+	int i = 0, n = 0;
+	_cleanup_free_ char *buf = malloc(size);
 
 	if (buf == NULL)
 		return NULL;
@@ -57,26 +57,33 @@ char *getline_wrapped(FILE *fp, unsigned int *linenum)
 
 		switch(ch) {
 		case EOF:
-			if (i == 0) {
-				free(buf);
+			if (i == 0)
 				return NULL;
-			}
 			/* else fall through */
 
 		case '\n':
-			if (linenum)
-				(*linenum)++;
-			if (i == size)
-				buf = realloc(buf, size + 1);
-			buf[i] = '\0';
-			return buf;
+			n++;
+
+			{
+				char *ret;
+				if (i == size) {
+					ret = realloc(buf, size + 1);
+					if (!ret)
+						return NULL;
+				} else
+					ret = buf;
+				ret[i] = '\0';
+				buf = NULL;
+				if (linenum)
+					*linenum += n;
+				return ret;
+			}
 
 		case '\\':
 			ch = getc_unlocked(fp);
 
 			if (ch == '\n') {
-				if (linenum)
-					(*linenum)++;
+				n++;
 				continue;
 			}
 			/* else fall through */
@@ -85,8 +92,12 @@ char *getline_wrapped(FILE *fp, unsigned int *linenum)
 			buf[i++] = ch;
 
 			if (i == size) {
+				char *tmp;
 				size *= 2;
-				buf = realloc(buf, size);
+				tmp = realloc(buf, size);
+				if (!tmp)
+					return NULL;
+				buf = tmp;
 			}
 		}
 	}
-- 
1.8.4.2
