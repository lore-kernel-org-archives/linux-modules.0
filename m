Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Mark van Dijk <linux-modules@z.dvxs.net>
Subject: [PATCH 2/4] libkmod: modinfo: use own function for sig_key hex output
Date: Tue, 11 Apr 2017 15:15:01 +0300
Message-Id: <20170411121503.26181-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
References: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Refactor the code a bit to make it easier to extend for signature
output.

kmod_module_get_info() creats a hex string for the sig_key data
inplace. Separate it into own kmod_module_hex_to_string function
and handle the branch in the new kmod_module_info_append_hex,
keeping the same signature as the non-hex version.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 79 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 34c7f76e4db5..22c8f4c852a2 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2193,6 +2193,53 @@ static struct kmod_list *kmod_module_info_append(struct kmod_list **list, const
 	return n;
 }
 
+static char *kmod_module_hex_to_str(const char *hex, size_t len)
+{
+	char *str;
+	int i;
+
+	str = malloc(len * 3);
+	if (str == NULL)
+		return NULL;
+
+	for (i = 0; i < (int)len; i++) {
+		sprintf(str + i * 3, "%02X", (unsigned char)hex[i]);
+		if (i < (int)len - 1)
+			str[i * 3 + 2] = ':';
+	}
+	return str;
+}
+
+static struct kmod_list *kmod_module_info_append_hex(struct kmod_list **list,
+						     const char *key,
+						     size_t keylen,
+						     const char *value,
+						     size_t valuelen)
+{
+	char *hex;
+	struct kmod_list *n;
+
+	if (valuelen > 0) {
+		/* Display as 01:12:DE:AD:BE:EF:... */
+		hex = kmod_module_hex_to_str(value, valuelen);
+		if (hex == NULL)
+			goto list_error;
+		n = kmod_module_info_append(list, key, keylen, hex, strlen(hex));
+		free(hex);
+		if (n == NULL)
+			goto list_error;
+	} else {
+		n = kmod_module_info_append(list, key, keylen, NULL, 0);
+		if (n == NULL)
+			goto list_error;
+	}
+
+	return n;
+
+list_error:
+	return NULL;
+}
+
 /**
  * kmod_module_get_info:
  * @mod: kmod module
@@ -2255,7 +2302,6 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 
 	if (kmod_module_signature_info(mod->file, &sig_info)) {
 		struct kmod_list *n;
-		char *key_hex;
 
 		n = kmod_module_info_append(list, "sig_id", strlen("sig_id"),
 				sig_info.id_type, strlen(sig_info.id_type));
@@ -2269,30 +2315,13 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 			goto list_error;
 		count++;
 
-		if (sig_info.key_id_len) {
-			/* Display the key id as 01:12:DE:AD:BE:EF:... */
-			key_hex = malloc(sig_info.key_id_len * 3);
-			if (key_hex == NULL)
-				goto list_error;
-			for (i = 0; i < (int)sig_info.key_id_len; i++) {
-				sprintf(key_hex + i * 3, "%02X",
-						(unsigned char)sig_info.key_id[i]);
-				if (i < (int)sig_info.key_id_len - 1)
-					key_hex[i * 3 + 2] = ':';
-			}
-			n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
-					key_hex, sig_info.key_id_len * 3 - 1);
-			free(key_hex);
-			if (n == NULL)
-				goto list_error;
-			count++;
-		} else {
-			n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
-					NULL, 0);
-			if (n == NULL)
-				goto list_error;
-			count++;
-		}
+
+		n = kmod_module_info_append_hex(list, "sig_key", strlen("sig_key"),
+						sig_info.key_id,
+						sig_info.key_id_len);
+		if (n == NULL)
+			goto list_error;
+		count++;
 
 		n = kmod_module_info_append(list,
 				"sig_hashalgo", strlen("sig_hashalgo"),
-- 
2.9.2.368.g08bb350
