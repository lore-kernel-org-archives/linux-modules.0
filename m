Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>,
	Wouter van Kesteren <woutershep@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/3] libkmod-signature: handle PKCS#7
Date: Sun,  5 Jun 2016 00:13:48 -0300
Message-Id: <1465096429-14024-2-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1465096429-14024-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1465096429-14024-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 libkmod/libkmod-signature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 6fc06fc..ef5fe6e 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -69,12 +69,14 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 enum pkey_id_type {
 	PKEY_ID_PGP,		/* OpenPGP generated key ID */
 	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
 	PKEY_ID_TYPE__LAST
 };
 
 const char *const pkey_id_type[PKEY_ID_TYPE__LAST] = {
 	[PKEY_ID_PGP]		= "PGP",
 	[PKEY_ID_X509]		= "X509",
+	[PKEY_ID_PKCS7]		= "PKCS#7",
 };
 
 /*
-- 
2.5.5
