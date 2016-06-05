Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>,
	Wouter van Kesteren <woutershep@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/3] libkmod-module: do not crash modinfo on 0 key id len
Date: Sun,  5 Jun 2016 00:13:47 -0300
Message-Id: <1465096429-14024-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 libkmod/libkmod-module.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1460c67..a19e8bc 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2253,22 +2253,30 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 			goto list_error;
 		count++;
 
-		/* Display the key id as 01:12:DE:AD:BE:EF:... */
-		key_hex = malloc(sig_info.key_id_len * 3);
-		if (key_hex == NULL)
-			goto list_error;
-		for (i = 0; i < (int)sig_info.key_id_len; i++) {
-			sprintf(key_hex + i * 3, "%02X",
-					(unsigned char)sig_info.key_id[i]);
-			if (i < (int)sig_info.key_id_len - 1)
-				key_hex[i * 3 + 2] = ':';
+		if (sig_info.key_id_len) {
+			/* Display the key id as 01:12:DE:AD:BE:EF:... */
+			key_hex = malloc(sig_info.key_id_len * 3);
+			if (key_hex == NULL)
+				goto list_error;
+			for (i = 0; i < (int)sig_info.key_id_len; i++) {
+				sprintf(key_hex + i * 3, "%02X",
+						(unsigned char)sig_info.key_id[i]);
+				if (i < (int)sig_info.key_id_len - 1)
+					key_hex[i * 3 + 2] = ':';
+			}
+			n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
+					key_hex, sig_info.key_id_len * 3 - 1);
+			free(key_hex);
+			if (n == NULL)
+				goto list_error;
+			count++;
+		} else {
+			n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
+					NULL, 0);
+			if (n == NULL)
+				goto list_error;
+			count++;
 		}
-		n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
-				key_hex, sig_info.key_id_len * 3 - 1);
-		free(key_hex);
-		if (n == NULL)
-			goto list_error;
-		count++;
 
 		n = kmod_module_info_append(list,
 				"sig_hashalgo", strlen("sig_hashalgo"),
-- 
2.5.5
