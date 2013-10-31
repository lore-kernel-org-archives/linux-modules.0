Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dmitry Kasatkin <d.kasatkin@samsung.com>
To: dhowells@redhat.com, rusty@rustcorp.com.au,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	dmitry.kasatkin@gmail.com, Dmitry Kasatkin <d.kasatkin@samsung.com>
Subject: [PATCH 1/1] KEYS: store keys in the dedicated directory
Date: Thu, 31 Oct 2013 18:26:30 +0200
Message-id: <1c88669c38d627ca2f5ccc9ffc2e24e2d04c05ea.1383236790.git.d.kasatkin@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Recent patch "KEYS: Load *.x509 files into kernel keyring" allows to bultin
multiple X509 certificates. It is easier to manage keys and certificates
when they are stored in the dedicated directory.

This patch proposes to store keys in the 'keys' directory.

Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
---
 Makefile        |  4 ++--
 kernel/Makefile | 55 +++++++++++++++++++++++++++++++------------------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 8d0668f..329684a 100644
--- a/Makefile
+++ b/Makefile
@@ -722,8 +722,8 @@ export mod_strip_cmd
 
 
 ifdef CONFIG_MODULE_SIG_ALL
-MODSECKEY = ./signing_key.priv
-MODPUBKEY = ./signing_key.x509
+MODSECKEY = ./keys/signing_key.priv
+MODPUBKEY = ./keys/signing_key.x509
 export MODPUBKEY
 mod_sign_cmd = perl $(srctree)/scripts/sign-file $(CONFIG_MODULE_SIG_HASH) $(MODSECKEY) $(MODPUBKEY)
 else
diff --git a/kernel/Makefile b/kernel/Makefile
index 6313698..3e7799a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -154,9 +154,15 @@ $(obj)/timeconst.h: $(obj)/hz.bc $(src)/timeconst.bc FORCE
 # duplicates.
 #
 ###############################################################################
+
+KEYDIR = keys
+MODGENKEY = $(KEYDIR)/x509.genkey
+MODSECKEY = $(KEYDIR)/signing_key.priv
+MODPUBKEY = $(KEYDIR)/signing_key.x509
+
 ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
-X509_CERTIFICATES-y := $(wildcard *.x509) $(wildcard $(srctree)/*.x509)
-X509_CERTIFICATES-$(CONFIG_MODULE_SIG) += signing_key.x509
+X509_CERTIFICATES-y := $(wildcard $(srctree)/keys/*.x509)
+X509_CERTIFICATES-$(CONFIG_MODULE_SIG) += $(MODPUBKEY)
 X509_CERTIFICATES := $(sort $(foreach CERT,$(X509_CERTIFICATES-y), \
 				$(or $(realpath $(CERT)),$(CERT))))
 
@@ -199,7 +205,7 @@ ifndef CONFIG_MODULE_SIG_HASH
 $(error Could not determine digest type to use from kernel config)
 endif
 
-signing_key.priv signing_key.x509: x509.genkey
+$(MODSECKEY) $(MODPUBKEY): $(MODGENKEY)
 	@echo "###"
 	@echo "### Now generating an X.509 key pair to be used for signing modules."
 	@echo "###"
@@ -209,30 +215,31 @@ signing_key.priv signing_key.x509: x509.genkey
 	@echo "### number generator if one is available."
 	@echo "###"
 	openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
-		-batch -x509 -config x509.genkey \
-		-outform DER -out signing_key.x509 \
-		-keyout signing_key.priv 2>&1
+		-batch -x509 -config $(MODGENKEY) \
+		-outform DER -out $(MODPUBKEY) \
+		-keyout $(MODSECKEY) 2>&1
 	@echo "###"
 	@echo "### Key pair generated."
 	@echo "###"
 
-x509.genkey:
+$(MODGENKEY):
 	@echo Generating X.509 key generation config
-	@echo  >x509.genkey "[ req ]"
-	@echo >>x509.genkey "default_bits = 4096"
-	@echo >>x509.genkey "distinguished_name = req_distinguished_name"
-	@echo >>x509.genkey "prompt = no"
-	@echo >>x509.genkey "string_mask = utf8only"
-	@echo >>x509.genkey "x509_extensions = myexts"
-	@echo >>x509.genkey
-	@echo >>x509.genkey "[ req_distinguished_name ]"
-	@echo >>x509.genkey "O = Magrathea"
-	@echo >>x509.genkey "CN = Glacier signing key"
-	@echo >>x509.genkey "emailAddress = slartibartfast@magrathea.h2g2"
-	@echo >>x509.genkey
-	@echo >>x509.genkey "[ myexts ]"
-	@echo >>x509.genkey "basicConstraints=critical,CA:FALSE"
-	@echo >>x509.genkey "keyUsage=digitalSignature"
-	@echo >>x509.genkey "subjectKeyIdentifier=hash"
-	@echo >>x509.genkey "authorityKeyIdentifier=keyid"
+	@mkdir -p $(KEYDIR)
+	@echo  >$(MODGENKEY) "[ req ]"
+	@echo >>$(MODGENKEY) "default_bits = 4096"
+	@echo >>$(MODGENKEY) "distinguished_name = req_distinguished_name"
+	@echo >>$(MODGENKEY) "prompt = no"
+	@echo >>$(MODGENKEY) "string_mask = utf8only"
+	@echo >>$(MODGENKEY) "x509_extensions = myexts"
+	@echo >>$(MODGENKEY)
+	@echo >>$(MODGENKEY) "[ req_distinguished_name ]"
+	@echo >>$(MODGENKEY) "O = Magrathea"
+	@echo >>$(MODGENKEY) "CN = Glacier signing key"
+	@echo >>$(MODGENKEY) "emailAddress = slartibartfast@magrathea.h2g2"
+	@echo >>$(MODGENKEY)
+	@echo >>$(MODGENKEY) "[ myexts ]"
+	@echo >>$(MODGENKEY) "basicConstraints=critical,CA:FALSE"
+	@echo >>$(MODGENKEY) "keyUsage=digitalSignature"
+	@echo >>$(MODGENKEY) "subjectKeyIdentifier=hash"
+	@echo >>$(MODGENKEY) "authorityKeyIdentifier=keyid"
 endif
-- 
1.8.1.2

