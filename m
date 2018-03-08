Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Ferry van Steen <Ferry.van.Steen@citrus.nl>,
	David Howells <dhowells@redhat.com>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC PKCS7 asn1c 1/2] libkmod-signature: implement pkcs7 parsing with asn1c compiler
Date: Thu,  8 Mar 2018 15:58:09 +0200
Message-Id: <20180308135810.4309-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20180308135810.4309-1-yauheni.kaliuta@redhat.com>
References: <20180308135810.4309-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The patch adds pkcs7.asn1 description, taken from the linux kernel
and modified to be suitable for the asn1c compiler and a wrapper on
the asn1c's parser to make it more suitable for kmod.

Since kmod (modinfo) supports only one signature at the moment, the
wrapper ignores others and it also analyzes object IDs only for
hashing algorithms.

To compile the stuff you need to have asn1c installed, finish
./configure and invoke

make -C libkmod/pkcs7/asn1c-gen regen

to generate the parser.

The next patch will bring the generated files for the case of
absense of the asn1c compiler.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 Makefile.am                         |  22 ++-
 configure.ac                        |   1 +
 libkmod/libkmod-internal.h          |   3 +
 libkmod/libkmod-module.c            |   3 +
 libkmod/libkmod-signature.c         | 105 ++++++++++---
 libkmod/pkcs7/asn1c-gen/Makefile.am | 131 ++++++++++++++++
 libkmod/pkcs7/pkcs7.asn1            | 135 ++++++++++++++++
 libkmod/pkcs7/pkcs7_parser.c        | 297 ++++++++++++++++++++++++++++++++++++
 libkmod/pkcs7/pkcs7_parser.h        |  42 +++++
 9 files changed, 719 insertions(+), 20 deletions(-)
 create mode 100644 libkmod/pkcs7/asn1c-gen/Makefile.am
 create mode 100644 libkmod/pkcs7/pkcs7.asn1
 create mode 100644 libkmod/pkcs7/pkcs7_parser.c
 create mode 100644 libkmod/pkcs7/pkcs7_parser.h

diff --git a/Makefile.am b/Makefile.am
index 194e1115ae70..26384ccd6de1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = . libkmod/docs
+SUBDIRS = . libkmod/docs libkmod/pkcs7/asn1c-gen
 
 if BUILD_MANPAGES
 SUBDIRS += man
@@ -62,6 +62,13 @@ shared_libshared_la_SOURCES = \
 include_HEADERS = libkmod/libkmod.h
 lib_LTLIBRARIES = libkmod/libkmod.la
 
+
+PKCS7_SRCS = \
+	libkmod/pkcs7/pkcs7_parser.c \
+	libkmod/pkcs7/pkcs7_parser.h
+
+AM_CPPFLAGS += -Ilibkmod/pkcs7/asn1c-gen -D_DEFAULT_SOURCE
+
 libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod.h \
 	libkmod/libkmod-internal.h \
@@ -73,7 +80,14 @@ libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod-module.c \
 	libkmod/libkmod-file.c \
 	libkmod/libkmod-elf.c \
-	libkmod/libkmod-signature.c
+	libkmod/libkmod-signature.c \
+	$(PKCS7_SRCS)
+
+libpkcs7asn1c = libkmod/pkcs7/asn1c-gen/libpkcs7asn1c.la
+libpkcs7asn1c_LIBS = ${libpkcs7asn1c}
+
+${libpkcs7asn1c}:
+	${MAKE} -C libkmod/pkcs7/asn1c-gen
 
 EXTRA_DIST += libkmod/libkmod.sym
 EXTRA_DIST += libkmod/README \
@@ -84,10 +98,12 @@ libkmod_libkmod_la_LDFLAGS = $(AM_LDFLAGS) \
 	-Wl,--version-script=$(top_srcdir)/libkmod/libkmod.sym
 libkmod_libkmod_la_DEPENDENCIES = \
 	shared/libshared.la \
+	${libpkcs7asn1c} \
 	${top_srcdir}/libkmod/libkmod.sym
 libkmod_libkmod_la_LIBADD = \
 	shared/libshared.la \
-	${liblzma_LIBS} ${zlib_LIBS}
+	${liblzma_LIBS} ${zlib_LIBS} \
+	${libpkcs7asn1c_LIBS}
 
 noinst_LTLIBRARIES += libkmod/libkmod-internal.la
 libkmod_libkmod_internal_la_SOURCES = $(libkmod_libkmod_la_SOURCES)
diff --git a/configure.ac b/configure.ac
index fbc7391b2d1b..0d5f83a45778 100644
--- a/configure.ac
+++ b/configure.ac
@@ -271,6 +271,7 @@ AC_CONFIG_FILES([
 	man/Makefile
 	libkmod/docs/Makefile
 	libkmod/docs/version.xml
+	libkmod/pkcs7/asn1c-gen/Makefile
 ])
 
 
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 346579c71aab..a65ddd156f18 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -188,5 +188,8 @@ struct kmod_signature_info {
 	const char *algo, *hash_algo, *id_type;
 	const char *sig;
 	size_t sig_len;
+	void (*free)(void *);
+	void *private;
 };
 bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
+void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 0a3ef11c860f..b5cee437ae0e 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2357,6 +2357,9 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 	ret = count;
 
 list_error:
+	/* aux structures freed in normal case also */
+	kmod_module_signature_info_free(&sig_info);
+
 	if (ret < 0) {
 		kmod_module_info_free_list(*list);
 		*list = NULL;
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 1f3e26dea203..bdf84cb14718 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -26,6 +26,7 @@
 #include <shared/missing.h>
 #include <shared/util.h>
 
+#include "pkcs7/pkcs7_parser.h"
 #include "libkmod-internal.h"
 
 /* These types and tables were copied from the 3.7 kernel sources.
@@ -92,6 +93,78 @@ struct module_signature {
 	uint32_t sig_len;    /* Length of signature data (big endian) */
 };
 
+static bool
+kmod_module_signature_info_default(const char *mem,
+				   off_t size,
+				   const struct module_signature *modsig,
+				   size_t sig_len,
+				   struct kmod_signature_info *sig_info)
+{
+	size -= sig_len;
+	sig_info->sig = mem + size;
+	sig_info->sig_len = sig_len;
+
+	size -= modsig->key_id_len;
+	sig_info->key_id = mem + size;
+	sig_info->key_id_len = modsig->key_id_len;
+
+	size -= modsig->signer_len;
+	sig_info->signer = mem + size;
+	sig_info->signer_len = modsig->signer_len;
+
+	sig_info->algo = pkey_algo[modsig->algo];
+	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
+	sig_info->id_type = pkey_id_type[modsig->id_type];
+
+	sig_info->free = NULL;
+	sig_info->private = NULL;
+
+	return true;
+}
+
+static void kmod_module_signature_info_pkcs7_free(void *s)
+{
+	struct kmod_signature_info *si = s;
+
+	pkcs7_free_cert(si->private);
+}
+
+static bool
+kmod_module_signature_info_pkcs7(const char *mem,
+				 off_t size,
+				 const struct module_signature *modsig,
+				 size_t sig_len,
+				 struct kmod_signature_info *sig_info)
+{
+	const char *pkcs7_raw;
+	struct pkcs7_cert *cert;
+
+	size -= sig_len;
+	pkcs7_raw = mem + size;
+
+	cert = pkcs7_parse_cert(pkcs7_raw, sig_len);
+	if (cert == NULL)
+		return false;
+
+	sig_info->private = cert;
+	sig_info->free = kmod_module_signature_info_pkcs7_free;
+
+	sig_info->sig = (const char *)cert->signature;
+	sig_info->sig_len = cert->signature_size;
+
+	sig_info->key_id = (const char *)cert->key_id;
+	sig_info->key_id_len = cert->key_id_size;
+
+	sig_info->signer = cert->signer;
+	sig_info->signer_len = strlen(cert->signer);
+
+	sig_info->algo = NULL;
+	sig_info->hash_algo = cert->hash_algo;
+	sig_info->id_type = pkey_id_type[modsig->id_type];
+
+	return true;
+}
+
 #define SIG_MAGIC "~Module signature appended~\n"
 
 /*
@@ -111,7 +184,7 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 	off_t size;
 	const struct module_signature *modsig;
 	size_t sig_len;
-
+	bool ret;
 
 	size = kmod_file_get_size(file);
 	mem = kmod_file_get_contents(file);
@@ -134,21 +207,19 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 	    size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
 		return false;
 
-	size -= sig_len;
-	sig_info->sig = mem + size;
-	sig_info->sig_len = sig_len;
-
-	size -= modsig->key_id_len;
-	sig_info->key_id = mem + size;
-	sig_info->key_id_len = modsig->key_id_len;
-
-	size -= modsig->signer_len;
-	sig_info->signer = mem + size;
-	sig_info->signer_len = modsig->signer_len;
-
-	sig_info->algo = pkey_algo[modsig->algo];
-	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
-	sig_info->id_type = pkey_id_type[modsig->id_type];
+	if (modsig->id_type == PKEY_ID_PKCS7)
+		ret = kmod_module_signature_info_pkcs7(mem, size,
+						       modsig, sig_len,
+						       sig_info);
+	else
+		ret = kmod_module_signature_info_default(mem, size,
+							 modsig, sig_len,
+							 sig_info);
+	return ret;
+}
 
-	return true;
+void kmod_module_signature_info_free(struct kmod_signature_info *sig_info)
+{
+	if (sig_info->free)
+		sig_info->free(sig_info);
 }
diff --git a/libkmod/pkcs7/asn1c-gen/Makefile.am b/libkmod/pkcs7/asn1c-gen/Makefile.am
new file mode 100644
index 000000000000..b9b613003039
--- /dev/null
+++ b/libkmod/pkcs7/asn1c-gen/Makefile.am
@@ -0,0 +1,131 @@
+ASN_MODULE_SOURCES=	\
+	PKCS7ContentInfo.c	\
+	ContentType.c	\
+	SignedData.c	\
+	ContentInfo.c	\
+	Data.c	\
+	DigestAlgorithmIdentifiers.c	\
+	DigestAlgorithmIdentifier.c	\
+	ExtendedCertificatesAndCertificates.c	\
+	Certificates.c	\
+	CertificateRevocationLists.c	\
+	CertificateList.c	\
+	CRLSequence.c	\
+	Certificate.c	\
+	SignerInfos.c	\
+	SignerInfo.c	\
+	SignerIdentifier.c	\
+	IssuerAndSerialNumber.c	\
+	CertificateSerialNumber.c	\
+	SubjectKeyIdentifier.c	\
+	SetOfAuthenticatedAttribute.c	\
+	Values.c	\
+	AuthenticatedAttribute.c	\
+	UnauthenticatedAttribute.c	\
+	DigestEncryptionAlgorithmIdentifier.c	\
+	EncryptedDigest.c	\
+	Name.c	\
+	RelativeDistinguishedName.c	\
+	AttributeValueAssertion.c
+
+ASN_MODULE_HEADERS=	\
+	PKCS7ContentInfo.h	\
+	ContentType.h	\
+	SignedData.h	\
+	ContentInfo.h	\
+	Data.h	\
+	DigestAlgorithmIdentifiers.h	\
+	DigestAlgorithmIdentifier.h	\
+	ExtendedCertificatesAndCertificates.h	\
+	Certificates.h	\
+	CertificateRevocationLists.h	\
+	CertificateList.h	\
+	CRLSequence.h	\
+	Certificate.h	\
+	SignerInfos.h	\
+	SignerInfo.h	\
+	SignerIdentifier.h	\
+	IssuerAndSerialNumber.h	\
+	CertificateSerialNumber.h	\
+	SubjectKeyIdentifier.h	\
+	SetOfAuthenticatedAttribute.h	\
+	Values.h	\
+	AuthenticatedAttribute.h	\
+	UnauthenticatedAttribute.h	\
+	DigestEncryptionAlgorithmIdentifier.h	\
+	EncryptedDigest.h	\
+	Name.h	\
+	RelativeDistinguishedName.h	\
+	AttributeValueAssertion.h
+
+ASN_MODULE_HEADERS+=ANY.h
+ASN_MODULE_SOURCES+=ANY.c
+ASN_MODULE_HEADERS+=INTEGER.h
+ASN_MODULE_HEADERS+=NativeEnumerated.h
+ASN_MODULE_SOURCES+=INTEGER.c
+ASN_MODULE_SOURCES+=NativeEnumerated.c
+ASN_MODULE_HEADERS+=NativeInteger.h
+ASN_MODULE_SOURCES+=NativeInteger.c
+ASN_MODULE_HEADERS+=OBJECT_IDENTIFIER.h
+ASN_MODULE_SOURCES+=OBJECT_IDENTIFIER.c
+ASN_MODULE_HEADERS+=asn_SEQUENCE_OF.h
+ASN_MODULE_SOURCES+=asn_SEQUENCE_OF.c
+ASN_MODULE_HEADERS+=asn_SET_OF.h
+ASN_MODULE_SOURCES+=asn_SET_OF.c
+ASN_MODULE_HEADERS+=constr_CHOICE.h
+ASN_MODULE_SOURCES+=constr_CHOICE.c
+ASN_MODULE_HEADERS+=constr_SEQUENCE.h
+ASN_MODULE_SOURCES+=constr_SEQUENCE.c
+ASN_MODULE_HEADERS+=constr_SEQUENCE_OF.h
+ASN_MODULE_SOURCES+=constr_SEQUENCE_OF.c
+ASN_MODULE_HEADERS+=constr_SET_OF.h
+ASN_MODULE_SOURCES+=constr_SET_OF.c
+ASN_MODULE_HEADERS+=asn_application.h
+ASN_MODULE_HEADERS+=asn_system.h
+ASN_MODULE_HEADERS+=asn_codecs.h
+ASN_MODULE_HEADERS+=asn_internal.h
+ASN_MODULE_HEADERS+=OCTET_STRING.h
+ASN_MODULE_SOURCES+=OCTET_STRING.c
+ASN_MODULE_HEADERS+=BIT_STRING.h
+ASN_MODULE_SOURCES+=BIT_STRING.c
+ASN_MODULE_SOURCES+=asn_codecs_prim.c
+ASN_MODULE_HEADERS+=asn_codecs_prim.h
+ASN_MODULE_HEADERS+=ber_tlv_length.h
+ASN_MODULE_SOURCES+=ber_tlv_length.c
+ASN_MODULE_HEADERS+=ber_tlv_tag.h
+ASN_MODULE_SOURCES+=ber_tlv_tag.c
+ASN_MODULE_HEADERS+=ber_decoder.h
+ASN_MODULE_SOURCES+=ber_decoder.c
+ASN_MODULE_HEADERS+=der_encoder.h
+ASN_MODULE_SOURCES+=der_encoder.c
+ASN_MODULE_HEADERS+=constr_TYPE.h
+ASN_MODULE_SOURCES+=constr_TYPE.c
+ASN_MODULE_HEADERS+=constraints.h
+ASN_MODULE_SOURCES+=constraints.c
+ASN_MODULE_HEADERS+=xer_support.h
+ASN_MODULE_SOURCES+=xer_support.c
+ASN_MODULE_HEADERS+=xer_decoder.h
+ASN_MODULE_SOURCES+=xer_decoder.c
+ASN_MODULE_HEADERS+=xer_encoder.h
+ASN_MODULE_SOURCES+=xer_encoder.c
+ASN_MODULE_HEADERS+=per_support.h
+ASN_MODULE_SOURCES+=per_support.c
+ASN_MODULE_HEADERS+=per_decoder.h
+ASN_MODULE_SOURCES+=per_decoder.c
+ASN_MODULE_HEADERS+=per_encoder.h
+ASN_MODULE_SOURCES+=per_encoder.c
+ASN_MODULE_HEADERS+=per_opentype.h
+ASN_MODULE_SOURCES+=per_opentype.c
+
+ASN_MODULEdir = .
+
+noinst_LTLIBRARIES=libpkcs7asn1c.la
+libpkcs7asn1c_la_SOURCES=$(ASN_MODULE_SOURCES) $(ASN_MODULE_HEADERS)
+
+AM_CPPFLAGS = -DEMIT_ASN_DEBUG=0 -D_DEFAULT_SOURCE
+
+regen: regenerate-from-asn1-source
+
+regenerate-from-asn1-source:
+	asn1c -fwide-types ../pkcs7.asn1
+
diff --git a/libkmod/pkcs7/pkcs7.asn1 b/libkmod/pkcs7/pkcs7.asn1
new file mode 100644
index 000000000000..c7d59c2bb4ab
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7.asn1
@@ -0,0 +1,135 @@
+PKCS7 DEFINITIONS ::=
+BEGIN
+
+PKCS7ContentInfo ::= SEQUENCE {
+	contentType	ContentType,
+	content		[0] EXPLICIT SignedData OPTIONAL
+}
+
+ContentType ::= OBJECT IDENTIFIER
+
+SignedData ::= SEQUENCE {
+	version			INTEGER,
+	digestAlgorithms	DigestAlgorithmIdentifiers,
+	contentInfo		ContentInfo,
+	certificates		CHOICE {
+		certSet		[0] IMPLICIT ExtendedCertificatesAndCertificates,
+		certSequence	[2] IMPLICIT Certificates
+	} OPTIONAL,
+	crls CHOICE {
+		crlSet		[1] IMPLICIT CertificateRevocationLists,
+		crlSequence	[3] IMPLICIT CRLSequence
+	} OPTIONAL,
+	signerInfos		SignerInfos
+}
+
+ContentInfo ::= SEQUENCE {
+	contentType	ContentType,
+	content		[0] EXPLICIT Data OPTIONAL
+}
+
+Data ::= ANY
+
+DigestAlgorithmIdentifiers ::= CHOICE {
+	daSet			SET OF DigestAlgorithmIdentifier,
+	daSequence		SEQUENCE OF DigestAlgorithmIdentifier
+}
+
+DigestAlgorithmIdentifier ::= SEQUENCE {
+	algorithm   OBJECT IDENTIFIER,
+	parameters  ANY OPTIONAL
+}
+
+--
+-- Certificates and certificate lists
+--
+ExtendedCertificatesAndCertificates ::= SET OF Certificate
+
+Certificates ::= SEQUENCE OF Certificate
+
+CertificateRevocationLists ::= SET OF CertificateList
+
+CertificateList ::= SEQUENCE OF Certificate -- This may be defined incorrectly
+
+CRLSequence ::= SEQUENCE OF CertificateList
+
+Certificate ::= ANY -- X.509, Skip
+
+--
+-- Signer information
+--
+SignerInfos ::= CHOICE {
+	siSet		SET OF SignerInfo,
+	siSequence	SEQUENCE OF SignerInfo
+}
+
+SignerInfo ::= SEQUENCE {
+	version			INTEGER,
+	sid			SignerIdentifier, -- CMS variant, not PKCS#7
+	digestAlgorithm		DigestAlgorithmIdentifier,
+	authenticatedAttributes	CHOICE {
+		aaSet		[0] IMPLICIT SetOfAuthenticatedAttribute,
+		aaSequence	[2] EXPLICIT SEQUENCE OF AuthenticatedAttribute
+			-- Explicit because easier to compute digest on
+			-- sequence of attributes and then reuse encoded
+			-- sequence in aaSequence.
+	} OPTIONAL,
+	digestEncryptionAlgorithm
+				DigestEncryptionAlgorithmIdentifier,
+	encryptedDigest		EncryptedDigest,
+	unauthenticatedAttributes CHOICE {
+		uaSet		[1] IMPLICIT SET OF UnauthenticatedAttribute,
+		uaSequence	[3] IMPLICIT SEQUENCE OF UnauthenticatedAttribute
+	} OPTIONAL
+}
+
+SignerIdentifier ::= CHOICE {
+	-- RFC5652 sec 5.3
+	issuerAndSerialNumber IssuerAndSerialNumber,
+        subjectKeyIdentifier [0] IMPLICIT SubjectKeyIdentifier
+}
+
+IssuerAndSerialNumber ::= SEQUENCE {
+	issuer			ANY,
+	serialNumber		ANY
+}
+
+CertificateSerialNumber ::= INTEGER
+
+SubjectKeyIdentifier ::= OCTET STRING
+
+SetOfAuthenticatedAttribute ::= SET OF AuthenticatedAttribute
+
+Values ::= SET OF ANY
+
+AuthenticatedAttribute ::= SEQUENCE {
+	type			OBJECT IDENTIFIER,
+	values			Values
+}
+
+UnauthenticatedAttribute ::= SEQUENCE {
+	type			OBJECT IDENTIFIER,
+	values			Values
+}
+
+DigestEncryptionAlgorithmIdentifier ::= SEQUENCE {
+	algorithm		OBJECT IDENTIFIER,
+	parameters		ANY OPTIONAL
+}
+
+EncryptedDigest ::= OCTET STRING
+
+---
+--- X.500 Name
+---
+Name ::= SEQUENCE OF RelativeDistinguishedName
+
+RelativeDistinguishedName ::= SET OF AttributeValueAssertion
+
+AttributeValueAssertion ::= SEQUENCE {
+	attributeType		OBJECT IDENTIFIER,
+	attributeValue		ANY
+}
+
+END
+
diff --git a/libkmod/pkcs7/pkcs7_parser.c b/libkmod/pkcs7/pkcs7_parser.c
new file mode 100644
index 000000000000..d1da9a6b4ac8
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7_parser.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright (C) 2018 Red Hat, Inc., Yauheni Kaliuta
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "pkcs7_parser.h"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+
+enum pkey_hash_algo {
+	PKEY_HASH_MD4,
+	PKEY_HASH_MD5,
+	PKEY_HASH_SHA1,
+	PKEY_HASH_SHA256,
+	PKEY_HASH_SHA384,
+	PKEY_HASH_SHA512,
+	PKEY_HASH_SHA224,
+	PKEY_HASH__LAST
+};
+
+static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
+	[PKEY_HASH_MD4]		= "md4",
+	[PKEY_HASH_MD5]		= "md5",
+	[PKEY_HASH_SHA1]	= "sha1",
+	[PKEY_HASH_SHA256]	= "sha256",
+	[PKEY_HASH_SHA384]	= "sha384",
+	[PKEY_HASH_SHA512]	= "sha512",
+	[PKEY_HASH_SHA224]	= "sha224",
+};
+
+/* 2.5.4.3 */
+static uint8_t OID_cn[] = { '\x55', '\x04', '\x03' };
+/* 1.3.14.3.2.26 */
+static uint8_t OID_SHA1[] = { '\x2b', '\x0e', '\x03', '\x02', '\x1a' };
+/* 2.16.840.1.101.3.4.2.1 */
+static uint8_t OID_SHA256[] = { '\x60', '\x86', '\x48', '\x01',
+				'\x65', '\x03', '\x04', '\x02', '\x01' };
+/* 2.16.840.1.101.3.4.2.2 */
+static uint8_t OID_SHA384[] = { '\x60', '\x86', '\x48', '\x01',
+				'\x65', '\x03', '\x04', '\x02', '\x02' };
+/* 2.16.840.1.101.3.4.2.3 */
+static uint8_t OID_SHA512[] = { '\x60', '\x86', '\x48', '\x01',
+				'\x65', '\x03', '\x04', '\x02', '\x03' };
+/* 2.16.840.1.101.3.4.2.4 */
+static uint8_t OID_SHA224[] = { '\x60', '\x86', '\x48', '\x01',
+				'\x65', '\x03', '\x04', '\x02', '\x04' };
+
+static uint8_t OID_MD4[] = { '\x2a', '\x86', '\x48', '\x86', '\xf7',
+			     '\x0d', '\x02', '\x04' };
+static uint8_t OID_MD5[] = { '\x2a', '\x86', '\x48', '\x86', '\xf7',
+			     '\x0d', '\x02', '\x05' };
+
+
+#define OID_TO_ID(oid) { OID_ ## oid, sizeof(OID_ ## oid), PKEY_HASH_ ## oid }
+static struct oid_to_id {
+	uint8_t *oid;
+	int oid_size;
+	int id;
+} oid_to_id[] = {
+	OID_TO_ID(SHA256),
+	OID_TO_ID(MD5),
+	OID_TO_ID(SHA1),
+	OID_TO_ID(SHA384),
+	OID_TO_ID(SHA512),
+	OID_TO_ID(SHA224),
+	OID_TO_ID(MD4),
+};
+
+
+static const char *pkey_hash_algo_to_str(unsigned id)
+{
+	if (id >= PKEY_HASH__LAST)
+		return "unknown";
+
+	return pkey_hash_algo[id];
+}
+
+void pkcs7_free_cert(struct pkcs7_cert *cert)
+{
+
+	asn_DEF_Name.free_struct(&asn_DEF_Name, cert->issuer, 0);
+
+	asn_DEF_PKCS7ContentInfo.free_struct
+		(&asn_DEF_PKCS7ContentInfo, cert->ci, 0);
+
+	free(cert->key_id);
+	free(cert->signer);
+	free(cert->signature);
+	free(cert);
+}
+
+static char *pkcs7_parse_utf8(uint8_t *buf, int size)
+{
+	char *p;
+	int len;
+	int llen = 1; /* length of length field */
+
+	if (buf[0] != 0x0C) /* utf8 string tag */
+		return NULL;
+
+	if (buf[1] & 0x80)
+		llen = (buf[1] & ~0x80) + 1;
+	len = size - 1 - llen; /* 1 is tag */
+
+	p = malloc(len + 1);
+	if (p == NULL)
+		return NULL;
+
+	memcpy(p, buf + 1 + llen, len);
+	p[len] = '\0';
+
+	return p;
+}
+
+static int pkcs7_parse_issuer(struct pkcs7_cert *cert, ANY_t *data)
+{
+	asn_dec_rval_t rval;
+	struct RelativeDistinguishedName **dnames;
+	int count;
+	int i;
+
+	rval = ber_decode(0, &asn_DEF_Name, (void **)&cert->issuer,
+			  data->buf, data->size);
+
+	if(rval.code != RC_OK)
+		return -1;
+
+	dnames = cert->issuer->list.array;
+	count = cert->issuer->list.count;
+
+	for (i = 0; i < count; i++) {
+		int j;
+		int n = dnames[i]->list.count;
+		struct AttributeValueAssertion **ava = dnames[i]->list.array;
+
+		for (j = 0; j < n; j++) {
+			OBJECT_IDENTIFIER_t *oid = &ava[j]->attributeType;
+			ANY_t *d = &ava[j]->attributeValue;
+
+			if (oid->size != sizeof(OID_cn))
+				continue;
+
+			if (memcmp(oid->buf, OID_cn, sizeof(OID_cn)) == 0) {
+				cert->signer = pkcs7_parse_utf8(d->buf, d->size);
+				break;
+			}
+		}
+		if (cert->signer != NULL)
+			break;
+	}
+
+	return 0;
+}
+
+static int pkcs7_gen_keyid_from_skid(OCTET_STRING_t *skid,
+				     uint8_t **buf, size_t *size)
+{
+	uint8_t *p;
+
+	p = malloc(skid->size);
+	if (p == NULL)
+		return -1;
+
+	memcpy(p, skid->buf, skid->size);
+
+	*buf = p;
+	*size = skid->size;
+
+	return 0;
+}
+
+static int pkcs7_gen_keyid_from_issuer(IssuerAndSerialNumber_t *issuer,
+				       uint8_t **buf, size_t *size)
+{
+	size_t s;
+	uint8_t *p;
+
+	/*
+	 * see asymmetric_key_generate_id(),
+	 * crypto/asymmetric_keys/assymmetric_type.c in the linux kernel
+	 */
+
+	s = issuer->issuer.size + issuer->serialNumber.size;
+
+	p = malloc(s);
+	if (p == NULL)
+		return -1;
+
+	memcpy(p, issuer->issuer.buf, issuer->issuer.size);
+	memcpy(p + issuer->issuer.size,
+	       issuer->serialNumber.buf,
+	       issuer->serialNumber.size);
+
+	*buf = p;
+	*size = s;
+
+	return 0;
+}
+
+static uint8_t pkcs7_hashalgo_oid_to_id(OBJECT_IDENTIFIER_t *oid)
+{
+	unsigned i;
+	struct oid_to_id *item;
+
+	for (i = 0; i < ARRAY_SIZE(oid_to_id); i++) {
+		item = &oid_to_id[i];
+		if (oid->size != item->oid_size)
+			continue;
+		if (memcmp(oid->buf, item->oid, oid->size) != 0)
+			continue;
+		return item->id;
+	}
+	return ~0;
+}
+
+static int pkcs7_parse_si(struct pkcs7_cert *cert)
+{
+	struct SignerInfo **infos;
+	struct SignerInfo *si;
+	int count;
+	OBJECT_IDENTIFIER_t *oid;
+	uint8_t *buf;
+
+	infos = cert->ci->content->signerInfos.choice.siSequence.list.array;
+	count = cert->ci->content->signerInfos.choice.siSequence.list.count;
+
+	if (count < 1)
+		return -1;
+
+	si = infos[0];
+
+	if (si->sid.present == SignerIdentifier_PR_subjectKeyIdentifier) {
+		if (pkcs7_gen_keyid_from_skid(&si->sid.choice.subjectKeyIdentifier, &cert->key_id, &cert->key_id_size) < 0)
+			return -1;
+		return 1;
+	}
+
+	if (pkcs7_parse_issuer(cert,
+			       &si->sid.choice.issuerAndSerialNumber.issuer) < 0)
+		return -1;
+	if (pkcs7_gen_keyid_from_issuer(&si->sid.choice.issuerAndSerialNumber,
+					&cert->key_id, &cert->key_id_size) < 0)
+		return -1;
+
+	buf = malloc(si->encryptedDigest.size);
+	if (buf == NULL)
+		return -1;
+	memcpy(buf, si->encryptedDigest.buf, si->encryptedDigest.size);
+
+	cert->signature = buf;
+	cert->signature_size = si->encryptedDigest.size;
+
+	oid = &si->digestAlgorithm.algorithm;
+	cert->hash_algo = pkey_hash_algo_to_str(pkcs7_hashalgo_oid_to_id(oid));
+
+	return 0;
+}
+
+struct pkcs7_cert *pkcs7_parse_cert(const void *raw, size_t len)
+{
+	struct pkcs7_cert *cert;
+	asn_dec_rval_t rval;
+
+	cert = malloc(sizeof(*cert));
+	if (cert == NULL)
+		return NULL;
+	memset(cert, 0, sizeof(*cert));
+
+	rval = ber_decode(0, &asn_DEF_PKCS7ContentInfo, (void **)&cert->ci,
+			  raw, len);
+
+	if(rval.code != RC_OK)
+		goto err;
+
+	if (cert->ci->content->signerInfos.present == SignerInfos_PR_NOTHING)
+		goto err;
+
+	if (pkcs7_parse_si(cert) < 0)
+		goto err;
+
+	return cert;
+err:
+	pkcs7_free_cert(cert);
+	return NULL;
+}
diff --git a/libkmod/pkcs7/pkcs7_parser.h b/libkmod/pkcs7/pkcs7_parser.h
new file mode 100644
index 000000000000..3a03a34ec240
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7_parser.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2018 Red Hat, Inc., Yauheni Kaliuta
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef KMOD_PKCS7_PARSER_H_
+#define KMOD_PKCS7_PARSER_H_
+
+#define EMIT_ASN_DEBUG 0
+
+#include <PKCS7ContentInfo.h>
+#include <Name.h>
+
+struct pkcs7_cert {
+	PKCS7ContentInfo_t *ci;
+	/* issuer RAW data are needed as well, so parsed separately */
+	Name_t *issuer;
+
+	const char *hash_algo;
+	uint8_t *key_id;
+	size_t key_id_size;
+	char *signer; /* copy cn there, name like in module_signature */
+	uint8_t *signature;
+	size_t signature_size;
+};
+
+struct pkcs7_cert *pkcs7_parse_cert(const void *raw, size_t len);
+void pkcs7_free_cert(struct pkcs7_cert *cert);
+
+#endif
-- 
2.16.2
