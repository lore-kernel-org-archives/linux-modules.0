Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Mark van Dijk <linux-modules@z.dvxs.net>
Subject: [PATCH 1/4] libkmod: modinfo: fix sig_id output
Date: Tue, 11 Apr 2017 15:15:00 +0300
Message-Id: <20170411121503.26181-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
References: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

For some reason the key for sig_id was set to "signature". The
length was calculated against the proper string, as the result in
the output it was truncated to "signat".

Pass the proper key to the kmod_module_info_append() call.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 57da0a2d1147..34c7f76e4db5 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2257,7 +2257,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 		struct kmod_list *n;
 		char *key_hex;
 
-		n = kmod_module_info_append(list, "signature", strlen("sig_id"),
+		n = kmod_module_info_append(list, "sig_id", strlen("sig_id"),
 				sig_info.id_type, strlen(sig_info.id_type));
 		if (n == NULL)
 			goto list_error;
-- 
2.9.2.368.g08bb350
