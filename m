Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Mark van Dijk <linux-modules@z.dvxs.net>
Subject: [PATCH 4/4] libkmod: modinfo: implement signature output
Date: Tue, 11 Apr 2017 15:15:03 +0300
Message-Id: <20170411121503.26181-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
References: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Signature was ignored from the modinfo. Implement its parsing
from the module data and add its output to the modinfo utility.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-internal.h  | 2 ++
 libkmod/libkmod-module.c    | 9 +++++++++
 libkmod/libkmod-signature.c | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 4d9db6bc7845..346579c71aab 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -186,5 +186,7 @@ struct kmod_signature_info {
 	const char *key_id;
 	size_t key_id_len;
 	const char *algo, *hash_algo, *id_type;
+	const char *sig;
+	size_t sig_len;
 };
 bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 9e155f080277..0a3ef11c860f 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2344,6 +2344,15 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 		 * Omit sig_info.algo for now, as these
 		 * are currently constant.
 		 */
+		n = kmod_module_info_append_hex(list, "signature",
+						strlen("signature"),
+						sig_info.sig,
+						sig_info.sig_len);
+
+		if (n == NULL)
+			goto list_error;
+		count++;
+
 	}
 	ret = count;
 
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index ef5fe6e7bb7f..1f3e26dea203 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -134,7 +134,11 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 	    size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
 		return false;
 
-	size -= modsig->key_id_len + sig_len;
+	size -= sig_len;
+	sig_info->sig = mem + size;
+	sig_info->sig_len = sig_len;
+
+	size -= modsig->key_id_len;
 	sig_info->key_id = mem + size;
 	sig_info->key_id_len = modsig->key_id_len;
 
-- 
2.9.2.368.g08bb350
