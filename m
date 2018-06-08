Return-Path: <msuchanek@suse.de>
From: Michal Suchanek <msuchanek@suse.de>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>,
	Ferry van Steen <Ferry.van.Steen@citrus.nl>,
	David Howells <dhowells@redhat.com>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] libkmod-signature: pkcs#7: fix crash when signer info is not present.
Date: Fri,  8 Jun 2018 19:10:15 +0200
Message-Id: <20180608171015.2211-1-msuchanek@suse.de>
In-Reply-To: <xunyy3iw47ih.fsf@redhat.com>
References: <xunyy3iw47ih.fsf@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Reported-by: Kazuya Saito <saito.kazuya@jp.fujitsu.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 libkmod/libkmod-signature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index fae074e6dd1d..782e96f69fef 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -166,7 +166,7 @@ kmod_module_signature_info_pkcs7(const char *mem,
 	sig_info->key_id_len = cert->key_id_size;
 
 	sig_info->signer = cert->signer;
-	sig_info->signer_len = strlen(cert->signer);
+	sig_info->signer_len = cert->signer ? strlen(cert->signer) : 0;
 
 	sig_info->algo = NULL;
 	sig_info->hash_algo = cert->hash_algo;
-- 
2.13.6
