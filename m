Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>,
	Wouter van Kesteren <woutershep@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/3] libkmod-module: modinfo: print signature id
Date: Sun,  5 Jun 2016 00:13:49 -0300
Message-Id: <1465096429-14024-3-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1465096429-14024-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1465096429-14024-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

This way it's possible to give at least the signature type for PKCS#7.
---
 libkmod/libkmod-module.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index a19e8bc..39a081d 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2247,6 +2247,12 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 		struct kmod_list *n;
 		char *key_hex;
 
+		n = kmod_module_info_append(list, "signature", strlen("sig_id"),
+				sig_info.id_type, strlen(sig_info.id_type));
+		if (n == NULL)
+			goto list_error;
+		count++;
+
 		n = kmod_module_info_append(list, "signer", strlen("signer"),
 				sig_info.signer, sig_info.signer_len);
 		if (n == NULL)
@@ -2286,7 +2292,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 		count++;
 
 		/*
-		 * Omit sig_info.id_type and sig_info.algo for now, as these
+		 * Omit sig_info.algo for now, as these
 		 * are currently constant.
 		 */
 	}
-- 
2.5.5
