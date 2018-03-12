Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Ferry van Steen <Ferry.van.Steen@citrus.nl>,
	David Howells <dhowells@redhat.com>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC PKCS7 kernel vm 1/1] libkmod-signature: implement pkcs7 parsing with kernel asn1 compiler
Date: Mon, 12 Mar 2018 22:46:33 +0200
Message-Id: <20180312204633.16826-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20180312204633.16826-1-yauheni.kaliuta@redhat.com>
References: <20180312204633.16826-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The patch adds pkcs7.asn1 description and asn1 compiler, taken from
the linux kernel and slightly modified to be suitable for userspace
and pkcs7_parser, which modifed a bit more for the limited kmod
needs.

Since kmod (modinfo) supports only one signature at the moment, the
wrapper ignores others.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 Makefile.am                                     |   33 +-
 libkmod/libkmod-internal.h                      |    3 +
 libkmod/libkmod-module.c                        |    5 +-
 libkmod/libkmod-signature.c                     |  105 +-
 libkmod/pkcs7/asn1_compiler.c                   | 1615 +++++++++++++++++++++++
 libkmod/pkcs7/asn1_decoder.c                    |  514 ++++++++
 libkmod/pkcs7/include/linux/asn1.h              |   69 +
 libkmod/pkcs7/include/linux/asn1_ber_bytecode.h |   94 ++
 libkmod/pkcs7/include/linux/asn1_decoder.h      |   25 +
 libkmod/pkcs7/include/linux/oid_registry.h      |  103 ++
 libkmod/pkcs7/oid_registry.c                    |  168 +++
 libkmod/pkcs7/oid_registry_data.c               |  190 +++
 libkmod/pkcs7/pkcs7.asn1                        |  135 ++
 libkmod/pkcs7/pkcs7_parser.c                    |  382 ++++++
 libkmod/pkcs7/pkcs7_parser.h                    |   19 +
 15 files changed, 3441 insertions(+), 19 deletions(-)
 create mode 100644 libkmod/pkcs7/asn1_compiler.c
 create mode 100644 libkmod/pkcs7/asn1_decoder.c
 create mode 100644 libkmod/pkcs7/include/linux/asn1.h
 create mode 100644 libkmod/pkcs7/include/linux/asn1_ber_bytecode.h
 create mode 100644 libkmod/pkcs7/include/linux/asn1_decoder.h
 create mode 100644 libkmod/pkcs7/include/linux/oid_registry.h
 create mode 100644 libkmod/pkcs7/oid_registry.c
 create mode 100644 libkmod/pkcs7/oid_registry_data.c
 create mode 100644 libkmod/pkcs7/pkcs7.asn1
 create mode 100644 libkmod/pkcs7/pkcs7_parser.c
 create mode 100644 libkmod/pkcs7/pkcs7_parser.h

diff --git a/Makefile.am b/Makefile.am
index 194e1115ae70..ffba5bddc069 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -62,6 +62,23 @@ shared_libshared_la_SOURCES = \
 include_HEADERS = libkmod/libkmod.h
 lib_LTLIBRARIES = libkmod/libkmod.la
 
+PKCS7_SRC = \
+	libkmod/pkcs7/asn1_decoder.c \
+	libkmod/pkcs7/oid_registry.c \
+	libkmod/pkcs7/pkcs7_parser.c \
+	libkmod/pkcs7/pkcs7_parser.h \
+	libkmod/pkcs7/include/linux/asn1_decoder.h \
+	libkmod/pkcs7/include/linux/oid_registry.h \
+	libkmod/pkcs7/include/linux/asn1_ber_bytecode.h \
+	libkmod/pkcs7/include/linux/asn1.h \
+	libkmod/pkcs7/pkcs7-asn1.h \
+	libkmod/pkcs7/pkcs7-asn1.c
+
+AM_CPPFLAGS += -Ilibkmod/pkcs7/include
+libkmod_pkcs7_asn1_compiler_la_CFLAGS = -Wno-shadow \
+					-Wno-discarded-qualifiers \
+					-Wno-implicit-fallthrough
+
 libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod.h \
 	libkmod/libkmod-internal.h \
@@ -73,7 +90,21 @@ libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod-module.c \
 	libkmod/libkmod-file.c \
 	libkmod/libkmod-elf.c \
-	libkmod/libkmod-signature.c
+	libkmod/libkmod-signature.c \
+	$(PKCS7_SRC)
+
+noinst_PROGRAMS = libkmod/pkcs7/asn1_compiler
+
+libkmod_pkcs7_asn1_compiler_SOURCES = libkmod/pkcs7/asn1_compiler.c
+
+libkmod/pkcs7/pkcs7_parser.c: libkmod/pkcs7/pkcs7-asn1.h
+
+libkmod/pkcs7/pkcs7-asn1.c libkmod/pkcs7/pkcs7-asn1.h: libkmod/pkcs7/pkcs7.asn1 libkmod/pkcs7/asn1_compiler
+	libkmod/pkcs7/asn1_compiler $< $(subst .h,.c,$@) $(subst .c,.h,$@)
+
+CLEANFILES +=   libkmod/pkcs7/pkcs7-asn1.h \
+		libkmod/pkcs7/pkcs7-asn1.c
+
 
 EXTRA_DIST += libkmod/libkmod.sym
 EXTRA_DIST += libkmod/README \
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
index 0a3ef11c860f..9ebfb0263600 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2273,7 +2273,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 	struct kmod_elf *elf;
 	char **strings;
 	int i, count, ret = -ENOMEM;
-	struct kmod_signature_info sig_info;
+	struct kmod_signature_info sig_info = {};
 
 	if (mod == NULL || list == NULL)
 		return -ENOENT;
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
diff --git a/libkmod/pkcs7/asn1_compiler.c b/libkmod/pkcs7/asn1_compiler.c
new file mode 100644
index 000000000000..c1b7ef3e24c1
--- /dev/null
+++ b/libkmod/pkcs7/asn1_compiler.c
@@ -0,0 +1,1615 @@
+/* Simplified ASN.1 notation parser
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <linux/asn1_ber_bytecode.h>
+
+enum token_type {
+	DIRECTIVE_ABSENT,
+	DIRECTIVE_ALL,
+	DIRECTIVE_ANY,
+	DIRECTIVE_APPLICATION,
+	DIRECTIVE_AUTOMATIC,
+	DIRECTIVE_BEGIN,
+	DIRECTIVE_BIT,
+	DIRECTIVE_BMPString,
+	DIRECTIVE_BOOLEAN,
+	DIRECTIVE_BY,
+	DIRECTIVE_CHARACTER,
+	DIRECTIVE_CHOICE,
+	DIRECTIVE_CLASS,
+	DIRECTIVE_COMPONENT,
+	DIRECTIVE_COMPONENTS,
+	DIRECTIVE_CONSTRAINED,
+	DIRECTIVE_CONTAINING,
+	DIRECTIVE_DEFAULT,
+	DIRECTIVE_DEFINED,
+	DIRECTIVE_DEFINITIONS,
+	DIRECTIVE_EMBEDDED,
+	DIRECTIVE_ENCODED,
+	DIRECTIVE_ENCODING_CONTROL,
+	DIRECTIVE_END,
+	DIRECTIVE_ENUMERATED,
+	DIRECTIVE_EXCEPT,
+	DIRECTIVE_EXPLICIT,
+	DIRECTIVE_EXPORTS,
+	DIRECTIVE_EXTENSIBILITY,
+	DIRECTIVE_EXTERNAL,
+	DIRECTIVE_FALSE,
+	DIRECTIVE_FROM,
+	DIRECTIVE_GeneralString,
+	DIRECTIVE_GeneralizedTime,
+	DIRECTIVE_GraphicString,
+	DIRECTIVE_IA5String,
+	DIRECTIVE_IDENTIFIER,
+	DIRECTIVE_IMPLICIT,
+	DIRECTIVE_IMPLIED,
+	DIRECTIVE_IMPORTS,
+	DIRECTIVE_INCLUDES,
+	DIRECTIVE_INSTANCE,
+	DIRECTIVE_INSTRUCTIONS,
+	DIRECTIVE_INTEGER,
+	DIRECTIVE_INTERSECTION,
+	DIRECTIVE_ISO646String,
+	DIRECTIVE_MAX,
+	DIRECTIVE_MIN,
+	DIRECTIVE_MINUS_INFINITY,
+	DIRECTIVE_NULL,
+	DIRECTIVE_NumericString,
+	DIRECTIVE_OBJECT,
+	DIRECTIVE_OCTET,
+	DIRECTIVE_OF,
+	DIRECTIVE_OPTIONAL,
+	DIRECTIVE_ObjectDescriptor,
+	DIRECTIVE_PATTERN,
+	DIRECTIVE_PDV,
+	DIRECTIVE_PLUS_INFINITY,
+	DIRECTIVE_PRESENT,
+	DIRECTIVE_PRIVATE,
+	DIRECTIVE_PrintableString,
+	DIRECTIVE_REAL,
+	DIRECTIVE_RELATIVE_OID,
+	DIRECTIVE_SEQUENCE,
+	DIRECTIVE_SET,
+	DIRECTIVE_SIZE,
+	DIRECTIVE_STRING,
+	DIRECTIVE_SYNTAX,
+	DIRECTIVE_T61String,
+	DIRECTIVE_TAGS,
+	DIRECTIVE_TRUE,
+	DIRECTIVE_TeletexString,
+	DIRECTIVE_UNION,
+	DIRECTIVE_UNIQUE,
+	DIRECTIVE_UNIVERSAL,
+	DIRECTIVE_UTCTime,
+	DIRECTIVE_UTF8String,
+	DIRECTIVE_UniversalString,
+	DIRECTIVE_VideotexString,
+	DIRECTIVE_VisibleString,
+	DIRECTIVE_WITH,
+	NR__DIRECTIVES,
+	TOKEN_ASSIGNMENT = NR__DIRECTIVES,
+	TOKEN_OPEN_CURLY,
+	TOKEN_CLOSE_CURLY,
+	TOKEN_OPEN_SQUARE,
+	TOKEN_CLOSE_SQUARE,
+	TOKEN_OPEN_ACTION,
+	TOKEN_CLOSE_ACTION,
+	TOKEN_COMMA,
+	TOKEN_NUMBER,
+	TOKEN_TYPE_NAME,
+	TOKEN_ELEMENT_NAME,
+	NR__TOKENS
+};
+
+static const unsigned char token_to_tag[NR__TOKENS] = {
+	/* EOC goes first */
+	[DIRECTIVE_BOOLEAN]		= ASN1_BOOL,
+	[DIRECTIVE_INTEGER]		= ASN1_INT,
+	[DIRECTIVE_BIT]			= ASN1_BTS,
+	[DIRECTIVE_OCTET]		= ASN1_OTS,
+	[DIRECTIVE_NULL]		= ASN1_NULL,
+	[DIRECTIVE_OBJECT]		= ASN1_OID,
+	[DIRECTIVE_ObjectDescriptor]	= ASN1_ODE,
+	[DIRECTIVE_EXTERNAL]		= ASN1_EXT,
+	[DIRECTIVE_REAL]		= ASN1_REAL,
+	[DIRECTIVE_ENUMERATED]		= ASN1_ENUM,
+	[DIRECTIVE_EMBEDDED]		= 0,
+	[DIRECTIVE_UTF8String]		= ASN1_UTF8STR,
+	[DIRECTIVE_RELATIVE_OID]	= ASN1_RELOID,
+	/* 14 */
+	/* 15 */
+	[DIRECTIVE_SEQUENCE]		= ASN1_SEQ,
+	[DIRECTIVE_SET]			= ASN1_SET,
+	[DIRECTIVE_NumericString]	= ASN1_NUMSTR,
+	[DIRECTIVE_PrintableString]	= ASN1_PRNSTR,
+	[DIRECTIVE_T61String]		= ASN1_TEXSTR,
+	[DIRECTIVE_TeletexString]	= ASN1_TEXSTR,
+	[DIRECTIVE_VideotexString]	= ASN1_VIDSTR,
+	[DIRECTIVE_IA5String]		= ASN1_IA5STR,
+	[DIRECTIVE_UTCTime]		= ASN1_UNITIM,
+	[DIRECTIVE_GeneralizedTime]	= ASN1_GENTIM,
+	[DIRECTIVE_GraphicString]	= ASN1_GRASTR,
+	[DIRECTIVE_VisibleString]	= ASN1_VISSTR,
+	[DIRECTIVE_GeneralString]	= ASN1_GENSTR,
+	[DIRECTIVE_UniversalString]	= ASN1_UNITIM,
+	[DIRECTIVE_CHARACTER]		= ASN1_CHRSTR,
+	[DIRECTIVE_BMPString]		= ASN1_BMPSTR,
+};
+
+static const char asn1_classes[4][5] = {
+	[ASN1_UNIV]	= "UNIV",
+	[ASN1_APPL]	= "APPL",
+	[ASN1_CONT]	= "CONT",
+	[ASN1_PRIV]	= "PRIV"
+};
+
+static const char asn1_methods[2][5] = {
+	[ASN1_UNIV]	= "PRIM",
+	[ASN1_APPL]	= "CONS"
+};
+
+static const char *const asn1_universal_tags[32] = {
+	"EOC",
+	"BOOL",
+	"INT",
+	"BTS",
+	"OTS",
+	"NULL",
+	"OID",
+	"ODE",
+	"EXT",
+	"REAL",
+	"ENUM",
+	"EPDV",
+	"UTF8STR",
+	"RELOID",
+	NULL,		/* 14 */
+	NULL,		/* 15 */
+	"SEQ",
+	"SET",
+	"NUMSTR",
+	"PRNSTR",
+	"TEXSTR",
+	"VIDSTR",
+	"IA5STR",
+	"UNITIM",
+	"GENTIM",
+	"GRASTR",
+	"VISSTR",
+	"GENSTR",
+	"UNISTR",
+	"CHRSTR",
+	"BMPSTR",
+	NULL		/* 31 */
+};
+
+static const char *filename;
+static const char *grammar_name;
+static const char *outputname;
+static const char *headername;
+
+static const char *const directives[NR__DIRECTIVES] = {
+#define _(X) [DIRECTIVE_##X] = #X
+	_(ABSENT),
+	_(ALL),
+	_(ANY),
+	_(APPLICATION),
+	_(AUTOMATIC),
+	_(BEGIN),
+	_(BIT),
+	_(BMPString),
+	_(BOOLEAN),
+	_(BY),
+	_(CHARACTER),
+	_(CHOICE),
+	_(CLASS),
+	_(COMPONENT),
+	_(COMPONENTS),
+	_(CONSTRAINED),
+	_(CONTAINING),
+	_(DEFAULT),
+	_(DEFINED),
+	_(DEFINITIONS),
+	_(EMBEDDED),
+	_(ENCODED),
+	[DIRECTIVE_ENCODING_CONTROL] = "ENCODING-CONTROL",
+	_(END),
+	_(ENUMERATED),
+	_(EXCEPT),
+	_(EXPLICIT),
+	_(EXPORTS),
+	_(EXTENSIBILITY),
+	_(EXTERNAL),
+	_(FALSE),
+	_(FROM),
+	_(GeneralString),
+	_(GeneralizedTime),
+	_(GraphicString),
+	_(IA5String),
+	_(IDENTIFIER),
+	_(IMPLICIT),
+	_(IMPLIED),
+	_(IMPORTS),
+	_(INCLUDES),
+	_(INSTANCE),
+	_(INSTRUCTIONS),
+	_(INTEGER),
+	_(INTERSECTION),
+	_(ISO646String),
+	_(MAX),
+	_(MIN),
+	[DIRECTIVE_MINUS_INFINITY] = "MINUS-INFINITY",
+	[DIRECTIVE_NULL] = "NULL",
+	_(NumericString),
+	_(OBJECT),
+	_(OCTET),
+	_(OF),
+	_(OPTIONAL),
+	_(ObjectDescriptor),
+	_(PATTERN),
+	_(PDV),
+	[DIRECTIVE_PLUS_INFINITY] = "PLUS-INFINITY",
+	_(PRESENT),
+	_(PRIVATE),
+	_(PrintableString),
+	_(REAL),
+	[DIRECTIVE_RELATIVE_OID] = "RELATIVE-OID",
+	_(SEQUENCE),
+	_(SET),
+	_(SIZE),
+	_(STRING),
+	_(SYNTAX),
+	_(T61String),
+	_(TAGS),
+	_(TRUE),
+	_(TeletexString),
+	_(UNION),
+	_(UNIQUE),
+	_(UNIVERSAL),
+	_(UTCTime),
+	_(UTF8String),
+	_(UniversalString),
+	_(VideotexString),
+	_(VisibleString),
+	_(WITH)
+};
+
+struct action {
+	struct action	*next;
+	char		*name;
+	unsigned char	index;
+};
+
+static struct action *action_list;
+static unsigned nr_actions;
+
+struct token {
+	unsigned short	line;
+	enum token_type	token_type : 8;
+	unsigned char	size;
+	struct action	*action;
+	char		*content;
+	struct type	*type;
+};
+
+static struct token *token_list;
+static unsigned nr_tokens;
+static bool verbose_opt;
+static bool debug_opt;
+
+#define verbose(fmt, ...) do { if (verbose_opt) printf(fmt, ## __VA_ARGS__); } while (0)
+#define debug(fmt, ...) do { if (debug_opt) printf(fmt, ## __VA_ARGS__); } while (0)
+
+static int directive_compare(const void *_key, const void *_pdir)
+{
+	const struct token *token = _key;
+	const char *const *pdir = _pdir, *dir = *pdir;
+	size_t dlen, clen;
+	int val;
+
+	dlen = strlen(dir);
+	clen = (dlen < token->size) ? dlen : token->size;
+
+	//debug("cmp(%s,%s) = ", token->content, dir);
+
+	val = memcmp(token->content, dir, clen);
+	if (val != 0) {
+		//debug("%d [cmp]\n", val);
+		return val;
+	}
+
+	if (dlen == token->size) {
+		//debug("0\n");
+		return 0;
+	}
+	//debug("%d\n", (int)dlen - (int)token->size);
+	return dlen - token->size; /* shorter -> negative */
+}
+
+/*
+ * Tokenise an ASN.1 grammar
+ */
+static void tokenise(char *buffer, char *end)
+{
+	struct token *tokens;
+	char *line, *nl, *start, *p, *q;
+	unsigned tix, lineno;
+
+	/* Assume we're going to have half as many tokens as we have
+	 * characters
+	 */
+	token_list = tokens = calloc((end - buffer) / 2, sizeof(struct token));
+	if (!tokens) {
+		perror(NULL);
+		exit(1);
+	}
+	tix = 0;
+
+	lineno = 0;
+	while (buffer < end) {
+		/* First of all, break out a line */
+		lineno++;
+		line = buffer;
+		nl = memchr(line, '\n', end - buffer);
+		if (!nl) {
+			buffer = nl = end;
+		} else {
+			buffer = nl + 1;
+			*nl = '\0';
+		}
+
+		/* Remove "--" comments */
+		p = line;
+	next_comment:
+		while ((p = memchr(p, '-', nl - p))) {
+			if (p[1] == '-') {
+				/* Found a comment; see if there's a terminator */
+				q = p + 2;
+				while ((q = memchr(q, '-', nl - q))) {
+					if (q[1] == '-') {
+						/* There is - excise the comment */
+						q += 2;
+						memmove(p, q, nl - q);
+						goto next_comment;
+					}
+					q++;
+				}
+				*p = '\0';
+				nl = p;
+				break;
+			} else {
+				p++;
+			}
+		}
+
+		p = line;
+		while (p < nl) {
+			/* Skip white space */
+			while (p < nl && isspace(*p))
+				*(p++) = 0;
+			if (p >= nl)
+				break;
+
+			tokens[tix].line = lineno;
+			start = p;
+
+			/* Handle string tokens */
+			if (isalpha(*p)) {
+				const char **dir, *start = p;
+
+				/* Can be a directive, type name or element
+				 * name.  Find the end of the name.
+				 */
+				q = p + 1;
+				while (q < nl && (isalnum(*q) || *q == '-' || *q == '_'))
+					q++;
+				tokens[tix].size = q - p;
+				p = q;
+
+				tokens[tix].content = malloc(tokens[tix].size + 1);
+				if (!tokens[tix].content) {
+					perror(NULL);
+					exit(1);
+				}
+				memcpy(tokens[tix].content, start, tokens[tix].size);
+				tokens[tix].content[tokens[tix].size] = 0;
+				
+				/* If it begins with a lowercase letter then
+				 * it's an element name
+				 */
+				if (islower(tokens[tix].content[0])) {
+					tokens[tix++].token_type = TOKEN_ELEMENT_NAME;
+					continue;
+				}
+
+				/* Otherwise we need to search the directive
+				 * table
+				 */
+				dir = bsearch(&tokens[tix], directives,
+					      sizeof(directives) / sizeof(directives[1]),
+					      sizeof(directives[1]),
+					      directive_compare);
+				if (dir) {
+					tokens[tix++].token_type = dir - directives;
+					continue;
+				}
+
+				tokens[tix++].token_type = TOKEN_TYPE_NAME;
+				continue;
+			}
+
+			/* Handle numbers */
+			if (isdigit(*p)) {
+				/* Find the end of the number */
+				q = p + 1;
+				while (q < nl && (isdigit(*q)))
+					q++;
+				tokens[tix].size = q - p;
+				p = q;
+				tokens[tix].content = malloc(tokens[tix].size + 1);
+				if (!tokens[tix].content) {
+					perror(NULL);
+					exit(1);
+				}
+				memcpy(tokens[tix].content, start, tokens[tix].size);
+				tokens[tix].content[tokens[tix].size] = 0;
+				tokens[tix++].token_type = TOKEN_NUMBER;
+				continue;
+			}
+
+			if (nl - p >= 3) {
+				if (memcmp(p, "::=", 3) == 0) {
+					p += 3;
+					tokens[tix].size = 3;
+					tokens[tix].content = "::=";
+					tokens[tix++].token_type = TOKEN_ASSIGNMENT;
+					continue;
+				}
+			}
+
+			if (nl - p >= 2) {
+				if (memcmp(p, "({", 2) == 0) {
+					p += 2;
+					tokens[tix].size = 2;
+					tokens[tix].content = "({";
+					tokens[tix++].token_type = TOKEN_OPEN_ACTION;
+					continue;
+				}
+				if (memcmp(p, "})", 2) == 0) {
+					p += 2;
+					tokens[tix].size = 2;
+					tokens[tix].content = "})";
+					tokens[tix++].token_type = TOKEN_CLOSE_ACTION;
+					continue;
+				}
+			}
+
+			if (nl - p >= 1) {
+				tokens[tix].size = 1;
+				switch (*p) {
+				case '{':
+					p += 1;
+					tokens[tix].content = "{";
+					tokens[tix++].token_type = TOKEN_OPEN_CURLY;
+					continue;
+				case '}':
+					p += 1;
+					tokens[tix].content = "}";
+					tokens[tix++].token_type = TOKEN_CLOSE_CURLY;
+					continue;
+				case '[':
+					p += 1;
+					tokens[tix].content = "[";
+					tokens[tix++].token_type = TOKEN_OPEN_SQUARE;
+					continue;
+				case ']':
+					p += 1;
+					tokens[tix].content = "]";
+					tokens[tix++].token_type = TOKEN_CLOSE_SQUARE;
+					continue;
+				case ',':
+					p += 1;
+					tokens[tix].content = ",";
+					tokens[tix++].token_type = TOKEN_COMMA;
+					continue;
+				default:
+					break;
+				}
+			}
+
+			fprintf(stderr, "%s:%u: Unknown character in grammar: '%c'\n",
+				filename, lineno, *p);
+			exit(1);
+		}
+	}
+
+	nr_tokens = tix;
+	verbose("Extracted %u tokens\n", nr_tokens);
+
+#if 0
+	{
+		int n;
+		for (n = 0; n < nr_tokens; n++)
+			debug("Token %3u: '%s'\n", n, token_list[n].content);
+	}
+#endif
+}
+
+static void build_type_list(void);
+static void parse(void);
+static void dump_elements(void);
+static void render(FILE *out, FILE *hdr);
+
+/*
+ *
+ */
+int main(int argc, char **argv)
+{
+	struct stat st;
+	ssize_t readlen;
+	FILE *out, *hdr;
+	char *buffer, *p;
+	char *kbuild_verbose;
+	int fd;
+
+	kbuild_verbose = getenv("KBUILD_VERBOSE");
+	if (kbuild_verbose)
+		verbose_opt = atoi(kbuild_verbose);
+
+	while (argc > 4) {
+		if (strcmp(argv[1], "-v") == 0)
+			verbose_opt = true;
+		else if (strcmp(argv[1], "-d") == 0)
+			debug_opt = true;
+		else
+			break;
+		memmove(&argv[1], &argv[2], (argc - 2) * sizeof(char *));
+		argc--;
+	}
+
+	if (argc != 4) {
+		fprintf(stderr, "Format: %s [-v] [-d] <grammar-file> <c-file> <hdr-file>\n",
+			argv[0]);
+		exit(2);
+	}
+
+	filename = argv[1];
+	outputname = argv[2];
+	headername = argv[3];
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		exit(1);
+	}
+
+	if (fstat(fd, &st) < 0) {
+		perror(filename);
+		exit(1);
+	}
+
+	if (!(buffer = malloc(st.st_size + 1))) {
+		perror(NULL);
+		exit(1);
+	}
+
+	if ((readlen = read(fd, buffer, st.st_size)) < 0) {
+		perror(filename);
+		exit(1);
+	}
+
+	if (close(fd) < 0) {
+		perror(filename);
+		exit(1);
+	}
+
+	if (readlen != st.st_size) {
+		fprintf(stderr, "%s: Short read\n", filename);
+		exit(1);
+	}
+
+	p = strrchr(argv[1], '/');
+	p = p ? p + 1 : argv[1];
+	grammar_name = strdup(p);
+	if (!p) {
+		perror(NULL);
+		exit(1);
+	}
+	p = strchr(grammar_name, '.');
+	if (p)
+		*p = '\0';
+
+	buffer[readlen] = 0;
+	tokenise(buffer, buffer + readlen);
+	build_type_list();
+	parse();
+	dump_elements();
+
+	out = fopen(outputname, "w");
+	if (!out) {
+		perror(outputname);
+		exit(1);
+	}
+
+	hdr = fopen(headername, "w");
+	if (!hdr) {
+		perror(headername);
+		exit(1);
+	}
+
+	render(out, hdr);
+
+	if (fclose(out) < 0) {
+		perror(outputname);
+		exit(1);
+	}
+
+	if (fclose(hdr) < 0) {
+		perror(headername);
+		exit(1);
+	}
+
+	return 0;
+}
+
+enum compound {
+	NOT_COMPOUND,
+	SET,
+	SET_OF,
+	SEQUENCE,
+	SEQUENCE_OF,
+	CHOICE,
+	ANY,
+	TYPE_REF,
+	TAG_OVERRIDE
+};
+
+struct element {
+	struct type	*type_def;
+	struct token	*name;
+	struct token	*type;
+	struct action	*action;
+	struct element	*children;
+	struct element	*next;
+	struct element	*render_next;
+	struct element	*list_next;
+	uint8_t		n_elements;
+	enum compound	compound : 8;
+	enum asn1_class	class : 8;
+	enum asn1_method method : 8;
+	uint8_t		tag;
+	unsigned	entry_index;
+	unsigned	flags;
+#define ELEMENT_IMPLICIT	0x0001
+#define ELEMENT_EXPLICIT	0x0002
+#define ELEMENT_TAG_SPECIFIED	0x0004
+#define ELEMENT_RENDERED	0x0008
+#define ELEMENT_SKIPPABLE	0x0010
+#define ELEMENT_CONDITIONAL	0x0020
+};
+
+struct type {
+	struct token	*name;
+	struct token	*def;
+	struct element	*element;
+	unsigned	ref_count;
+	unsigned	flags;
+#define TYPE_STOP_MARKER	0x0001
+#define TYPE_BEGIN		0x0002
+};
+
+static struct type *type_list;
+static struct type **type_index;
+static unsigned nr_types;
+
+static int type_index_compare(const void *_a, const void *_b)
+{
+	const struct type *const *a = _a, *const *b = _b;
+
+	if ((*a)->name->size != (*b)->name->size)
+		return (*a)->name->size - (*b)->name->size;
+	else
+		return memcmp((*a)->name->content, (*b)->name->content,
+			      (*a)->name->size);
+}
+
+static int type_finder(const void *_key, const void *_ti)
+{
+	const struct token *token = _key;
+	const struct type *const *ti = _ti;
+	const struct type *type = *ti;
+
+	if (token->size != type->name->size)
+		return token->size - type->name->size;
+	else
+		return memcmp(token->content, type->name->content,
+			      token->size);
+}
+
+/*
+ * Build up a list of types and a sorted index to that list.
+ */
+static void build_type_list(void)
+{
+	struct type *types;
+	unsigned nr, t, n;
+
+	nr = 0;
+	for (n = 0; n < nr_tokens - 1; n++)
+		if (token_list[n + 0].token_type == TOKEN_TYPE_NAME &&
+		    token_list[n + 1].token_type == TOKEN_ASSIGNMENT)
+			nr++;
+
+	if (nr == 0) {
+		fprintf(stderr, "%s: No defined types\n", filename);
+		exit(1);
+	}
+
+	nr_types = nr;
+	types = type_list = calloc(nr + 1, sizeof(type_list[0]));
+	if (!type_list) {
+		perror(NULL);
+		exit(1);
+	}
+	type_index = calloc(nr, sizeof(type_index[0]));
+	if (!type_index) {
+		perror(NULL);
+		exit(1);
+	}
+
+	t = 0;
+	types[t].flags |= TYPE_BEGIN;
+	for (n = 0; n < nr_tokens - 1; n++) {
+		if (token_list[n + 0].token_type == TOKEN_TYPE_NAME &&
+		    token_list[n + 1].token_type == TOKEN_ASSIGNMENT) {
+			types[t].name = &token_list[n];
+			type_index[t] = &types[t];
+			t++;
+		}
+	}
+	types[t].name = &token_list[n + 1];
+	types[t].flags |= TYPE_STOP_MARKER;
+
+	qsort(type_index, nr, sizeof(type_index[0]), type_index_compare);
+
+	verbose("Extracted %u types\n", nr_types);
+#if 0
+	for (n = 0; n < nr_types; n++) {
+		struct type *type = type_index[n];
+		debug("- %*.*s\n", type->name->content);
+	}
+#endif
+}
+
+static struct element *parse_type(struct token **_cursor, struct token *stop,
+				  struct token *name);
+
+/*
+ * Parse the token stream
+ */
+static void parse(void)
+{
+	struct token *cursor;
+	struct type *type;
+
+	/* Parse one type definition statement at a time */
+	type = type_list;
+	do {
+		cursor = type->name;
+
+		if (cursor[0].token_type != TOKEN_TYPE_NAME ||
+		    cursor[1].token_type != TOKEN_ASSIGNMENT)
+			abort();
+		cursor += 2;
+
+		type->element = parse_type(&cursor, type[1].name, NULL);
+		type->element->type_def = type;
+
+		if (cursor != type[1].name) {
+			fprintf(stderr, "%s:%d: Parse error at token '%s'\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+
+	} while (type++, !(type->flags & TYPE_STOP_MARKER));
+
+	verbose("Extracted %u actions\n", nr_actions);
+}
+
+static struct element *element_list;
+
+static struct element *alloc_elem(struct token *type)
+{
+	struct element *e = calloc(1, sizeof(*e));
+	if (!e) {
+		perror(NULL);
+		exit(1);
+	}
+	e->list_next = element_list;
+	element_list = e;
+	return e;
+}
+
+static struct element *parse_compound(struct token **_cursor, struct token *end,
+				      int alternates);
+
+/*
+ * Parse one type definition statement
+ */
+static struct element *parse_type(struct token **_cursor, struct token *end,
+				  struct token *name)
+{
+	struct element *top, *element;
+	struct action *action, **ppaction;
+	struct token *cursor = *_cursor;
+	struct type **ref;
+	char *p;
+	int labelled = 0, implicit = 0;
+
+	top = element = alloc_elem(cursor);
+	element->class = ASN1_UNIV;
+	element->method = ASN1_PRIM;
+	element->tag = token_to_tag[cursor->token_type];
+	element->name = name;
+
+	/* Extract the tag value if one given */
+	if (cursor->token_type == TOKEN_OPEN_SQUARE) {
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		switch (cursor->token_type) {
+		case DIRECTIVE_UNIVERSAL:
+			element->class = ASN1_UNIV;
+			cursor++;
+			break;
+		case DIRECTIVE_APPLICATION:
+			element->class = ASN1_APPL;
+			cursor++;
+			break;
+		case TOKEN_NUMBER:
+			element->class = ASN1_CONT;
+			break;
+		case DIRECTIVE_PRIVATE:
+			element->class = ASN1_PRIV;
+			cursor++;
+			break;
+		default:
+			fprintf(stderr, "%s:%d: Unrecognised tag class token '%s'\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != TOKEN_NUMBER) {
+			fprintf(stderr, "%s:%d: Missing tag number '%s'\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+
+		element->tag &= ~0x1f;
+		element->tag |= strtoul(cursor->content, &p, 10);
+		element->flags |= ELEMENT_TAG_SPECIFIED;
+		if (p - cursor->content != cursor->size)
+			abort();
+		cursor++;
+
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != TOKEN_CLOSE_SQUARE) {
+			fprintf(stderr, "%s:%d: Missing closing square bracket '%s'\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		labelled = 1;
+	}
+
+	/* Handle implicit and explicit markers */
+	if (cursor->token_type == DIRECTIVE_IMPLICIT) {
+		element->flags |= ELEMENT_IMPLICIT;
+		implicit = 1;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+	} else if (cursor->token_type == DIRECTIVE_EXPLICIT) {
+		element->flags |= ELEMENT_EXPLICIT;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+	}
+
+	if (labelled) {
+		if (!implicit)
+			element->method |= ASN1_CONS;
+		element->compound = implicit ? TAG_OVERRIDE : SEQUENCE;
+		element->children = alloc_elem(cursor);
+		element = element->children;
+		element->class = ASN1_UNIV;
+		element->method = ASN1_PRIM;
+		element->tag = token_to_tag[cursor->token_type];
+		element->name = name;
+	}
+
+	/* Extract the type we're expecting here */
+	element->type = cursor;
+	switch (cursor->token_type) {
+	case DIRECTIVE_ANY:
+		element->compound = ANY;
+		cursor++;
+		break;
+
+	case DIRECTIVE_NULL:
+	case DIRECTIVE_BOOLEAN:
+	case DIRECTIVE_ENUMERATED:
+	case DIRECTIVE_INTEGER:
+		element->compound = NOT_COMPOUND;
+		cursor++;
+		break;
+
+	case DIRECTIVE_EXTERNAL:
+		element->method = ASN1_CONS;
+
+	case DIRECTIVE_BMPString:
+	case DIRECTIVE_GeneralString:
+	case DIRECTIVE_GraphicString:
+	case DIRECTIVE_IA5String:
+	case DIRECTIVE_ISO646String:
+	case DIRECTIVE_NumericString:
+	case DIRECTIVE_PrintableString:
+	case DIRECTIVE_T61String:
+	case DIRECTIVE_TeletexString:
+	case DIRECTIVE_UniversalString:
+	case DIRECTIVE_UTF8String:
+	case DIRECTIVE_VideotexString:
+	case DIRECTIVE_VisibleString:
+	case DIRECTIVE_ObjectDescriptor:
+	case DIRECTIVE_GeneralizedTime:
+	case DIRECTIVE_UTCTime:
+		element->compound = NOT_COMPOUND;
+		cursor++;
+		break;
+
+	case DIRECTIVE_BIT:
+	case DIRECTIVE_OCTET:
+		element->compound = NOT_COMPOUND;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != DIRECTIVE_STRING)
+			goto parse_error;
+		cursor++;
+		break;
+
+	case DIRECTIVE_OBJECT:
+		element->compound = NOT_COMPOUND;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != DIRECTIVE_IDENTIFIER)
+			goto parse_error;
+		cursor++;
+		break;
+
+	case TOKEN_TYPE_NAME:
+		element->compound = TYPE_REF;
+		ref = bsearch(cursor, type_index, nr_types, sizeof(type_index[0]),
+			      type_finder);
+		if (!ref) {
+			fprintf(stderr, "%s:%d: Type '%s' undefined\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+		cursor->type = *ref;
+		(*ref)->ref_count++;
+		cursor++;
+		break;
+
+	case DIRECTIVE_CHOICE:
+		element->compound = CHOICE;
+		cursor++;
+		element->children = parse_compound(&cursor, end, 1);
+		break;
+
+	case DIRECTIVE_SEQUENCE:
+		element->compound = SEQUENCE;
+		element->method = ASN1_CONS;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type == DIRECTIVE_OF) {
+			element->compound = SEQUENCE_OF;
+			cursor++;
+			if (cursor >= end)
+				goto overrun_error;
+			element->children = parse_type(&cursor, end, NULL);
+		} else {
+			element->children = parse_compound(&cursor, end, 0);
+		}
+		break;
+
+	case DIRECTIVE_SET:
+		element->compound = SET;
+		element->method = ASN1_CONS;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type == DIRECTIVE_OF) {
+			element->compound = SET_OF;
+			cursor++;
+			if (cursor >= end)
+				goto parse_error;
+			element->children = parse_type(&cursor, end, NULL);
+		} else {
+			element->children = parse_compound(&cursor, end, 1);
+		}
+		break;
+
+	default:
+		fprintf(stderr, "%s:%d: Token '%s' does not introduce a type\n",
+			filename, cursor->line, cursor->content);
+		exit(1);
+	}
+
+	/* Handle elements that are optional */
+	if (cursor < end && (cursor->token_type == DIRECTIVE_OPTIONAL ||
+			     cursor->token_type == DIRECTIVE_DEFAULT)
+	    ) {
+		cursor++;
+		top->flags |= ELEMENT_SKIPPABLE;
+	}
+
+	if (cursor < end && cursor->token_type == TOKEN_OPEN_ACTION) {
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != TOKEN_ELEMENT_NAME) {
+			fprintf(stderr, "%s:%d: Token '%s' is not an action function name\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+
+		action = malloc(sizeof(struct action));
+		if (!action) {
+			perror(NULL);
+			exit(1);
+		}
+		action->index = 0;
+		action->name = cursor->content;
+
+		for (ppaction = &action_list;
+		     *ppaction;
+		     ppaction = &(*ppaction)->next
+		     ) {
+			int cmp = strcmp(action->name, (*ppaction)->name);
+			if (cmp == 0) {
+				free(action);
+				action = *ppaction;
+				goto found;
+			}
+			if (cmp < 0) {
+				action->next = *ppaction;
+				*ppaction = action;
+				nr_actions++;
+				goto found;
+			}
+		}
+		action->next = NULL;
+		*ppaction = action;
+		nr_actions++;
+	found:
+
+		element->action = action;
+		cursor->action = action;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != TOKEN_CLOSE_ACTION) {
+			fprintf(stderr, "%s:%d: Missing close action, got '%s'\n",
+				filename, cursor->line, cursor->content);
+			exit(1);
+		}
+		cursor++;
+	}
+
+	*_cursor = cursor;
+	return top;
+
+parse_error:
+	fprintf(stderr, "%s:%d: Unexpected token '%s'\n",
+		filename, cursor->line, cursor->content);
+	exit(1);
+
+overrun_error:
+	fprintf(stderr, "%s: Unexpectedly hit EOF\n", filename);
+	exit(1);
+}
+
+/*
+ * Parse a compound type list
+ */
+static struct element *parse_compound(struct token **_cursor, struct token *end,
+				      int alternates)
+{
+	struct element *children, **child_p = &children, *element;
+	struct token *cursor = *_cursor, *name;
+
+	if (cursor->token_type != TOKEN_OPEN_CURLY) {
+		fprintf(stderr, "%s:%d: Expected compound to start with brace not '%s'\n",
+			filename, cursor->line, cursor->content);
+		exit(1);
+	}
+	cursor++;
+	if (cursor >= end)
+		goto overrun_error;
+
+	if (cursor->token_type == TOKEN_OPEN_CURLY) {
+		fprintf(stderr, "%s:%d: Empty compound\n",
+			filename, cursor->line);
+		exit(1);
+	}
+
+	for (;;) {
+		name = NULL;
+		if (cursor->token_type == TOKEN_ELEMENT_NAME) {
+			name = cursor;
+			cursor++;
+			if (cursor >= end)
+				goto overrun_error;
+		}
+
+		element = parse_type(&cursor, end, name);
+		if (alternates)
+			element->flags |= ELEMENT_SKIPPABLE | ELEMENT_CONDITIONAL;
+
+		*child_p = element;
+		child_p = &element->next;
+
+		if (cursor >= end)
+			goto overrun_error;
+		if (cursor->token_type != TOKEN_COMMA)
+			break;
+		cursor++;
+		if (cursor >= end)
+			goto overrun_error;
+	}
+
+	children->flags &= ~ELEMENT_CONDITIONAL;
+
+	if (cursor->token_type != TOKEN_CLOSE_CURLY) {
+		fprintf(stderr, "%s:%d: Expected compound closure, got '%s'\n",
+			filename, cursor->line, cursor->content);
+		exit(1);
+	}
+	cursor++;
+
+	*_cursor = cursor;
+	return children;
+
+overrun_error:
+	fprintf(stderr, "%s: Unexpectedly hit EOF\n", filename);
+	exit(1);
+}
+
+static void dump_element(const struct element *e, int level)
+{
+	const struct element *c;
+	const struct type *t = e->type_def;
+	const char *name = e->name ? e->name->content : ".";
+	const char *tname = t && t->name ? t->name->content : ".";
+	char tag[32];
+
+	if (e->class == 0 && e->method == 0 && e->tag == 0)
+		strcpy(tag, "<...>");
+	else if (e->class == ASN1_UNIV)
+		sprintf(tag, "%s %s %s",
+			asn1_classes[e->class],
+			asn1_methods[e->method],
+			asn1_universal_tags[e->tag]);
+	else
+		sprintf(tag, "%s %s %u",
+			asn1_classes[e->class],
+			asn1_methods[e->method],
+			e->tag);
+
+	printf("%c%c%c%c%c %c %*s[*] \e[33m%s\e[m %s %s \e[35m%s\e[m\n",
+	       e->flags & ELEMENT_IMPLICIT ? 'I' : '-',
+	       e->flags & ELEMENT_EXPLICIT ? 'E' : '-',
+	       e->flags & ELEMENT_TAG_SPECIFIED ? 'T' : '-',
+	       e->flags & ELEMENT_SKIPPABLE ? 'S' : '-',
+	       e->flags & ELEMENT_CONDITIONAL ? 'C' : '-',
+	       "-tTqQcaro"[e->compound],
+	       level, "",
+	       tag,
+	       tname,
+	       name,
+	       e->action ? e->action->name : "");
+	if (e->compound == TYPE_REF)
+		dump_element(e->type->type->element, level + 3);
+	else
+		for (c = e->children; c; c = c->next)
+			dump_element(c, level + 3);
+}
+
+static void dump_elements(void)
+{
+	if (debug_opt)
+		dump_element(type_list[0].element, 0);
+}
+
+static void render_element(FILE *out, struct element *e, struct element *tag);
+static void render_out_of_line_list(FILE *out);
+
+static int nr_entries;
+static int render_depth = 1;
+static struct element *render_list, **render_list_p = &render_list;
+
+__attribute__((format(printf, 2, 3)))
+static void render_opcode(FILE *out, const char *fmt, ...)
+{
+	va_list va;
+
+	if (out) {
+		fprintf(out, "\t[%4d] =%*s", nr_entries, render_depth, "");
+		va_start(va, fmt);
+		vfprintf(out, fmt, va);
+		va_end(va);
+	}
+	nr_entries++;
+}
+
+__attribute__((format(printf, 2, 3)))
+static void render_more(FILE *out, const char *fmt, ...)
+{
+	va_list va;
+
+	if (out) {
+		va_start(va, fmt);
+		vfprintf(out, fmt, va);
+		va_end(va);
+	}
+}
+
+/*
+ * Render the grammar into a state machine definition.
+ */
+static void render(FILE *out, FILE *hdr)
+{
+	struct element *e;
+	struct action *action;
+	struct type *root;
+	int index;
+
+	fprintf(hdr, "/*\n");
+	fprintf(hdr, " * Automatically generated by asn1_compiler.  Do not edit\n");
+	fprintf(hdr, " *\n");
+	fprintf(hdr, " * ASN.1 parser for %s\n", grammar_name);
+	fprintf(hdr, " */\n");
+	fprintf(hdr, "#include <linux/asn1_decoder.h>\n");
+	fprintf(hdr, "\n");
+	fprintf(hdr, "extern const struct asn1_decoder %s_decoder;\n", grammar_name);
+	if (ferror(hdr)) {
+		perror(headername);
+		exit(1);
+	}
+
+	fprintf(out, "/*\n");
+	fprintf(out, " * Automatically generated by asn1_compiler.  Do not edit\n");
+	fprintf(out, " *\n");
+	fprintf(out, " * ASN.1 parser for %s\n", grammar_name);
+	fprintf(out, " */\n");
+	fprintf(out, "#include <linux/asn1_ber_bytecode.h>\n");
+	fprintf(out, "#include \"%s-asn1.h\"\n", grammar_name);
+	fprintf(out, "\n");
+	if (ferror(out)) {
+		perror(outputname);
+		exit(1);
+	}
+
+	/* Tabulate the action functions we might have to call */
+	fprintf(hdr, "\n");
+	index = 0;
+	for (action = action_list; action; action = action->next) {
+		action->index = index++;
+		fprintf(hdr,
+			"extern int %s(void *, size_t, unsigned char,"
+			" const void *, size_t);\n",
+			action->name);
+	}
+	fprintf(hdr, "\n");
+
+	fprintf(out, "enum %s_actions {\n", grammar_name);
+	for (action = action_list; action; action = action->next)
+		fprintf(out, "\tACT_%s = %u,\n",
+			action->name, action->index);
+	fprintf(out, "\tNR__%s_actions = %u\n", grammar_name, nr_actions);
+	fprintf(out, "};\n");
+
+	fprintf(out, "\n");
+	fprintf(out, "static const asn1_action_t %s_action_table[NR__%s_actions] = {\n",
+		grammar_name, grammar_name);
+	for (action = action_list; action; action = action->next)
+		fprintf(out, "\t[%4u] = %s,\n", action->index, action->name);
+	fprintf(out, "};\n");
+
+	if (ferror(out)) {
+		perror(outputname);
+		exit(1);
+	}
+
+	/* We do two passes - the first one calculates all the offsets */
+	verbose("Pass 1\n");
+	nr_entries = 0;
+	root = &type_list[0];
+	render_element(NULL, root->element, NULL);
+	render_opcode(NULL, "ASN1_OP_COMPLETE,\n");
+	render_out_of_line_list(NULL);
+
+	for (e = element_list; e; e = e->list_next)
+		e->flags &= ~ELEMENT_RENDERED;
+
+	/* And then we actually render */
+	verbose("Pass 2\n");
+	fprintf(out, "\n");
+	fprintf(out, "static const unsigned char %s_machine[] = {\n",
+		grammar_name);
+
+	nr_entries = 0;
+	root = &type_list[0];
+	render_element(out, root->element, NULL);
+	render_opcode(out, "ASN1_OP_COMPLETE,\n");
+	render_out_of_line_list(out);
+
+	fprintf(out, "};\n");
+
+	fprintf(out, "\n");
+	fprintf(out, "const struct asn1_decoder %s_decoder = {\n", grammar_name);
+	fprintf(out, "\t.machine = %s_machine,\n", grammar_name);
+	fprintf(out, "\t.machlen = sizeof(%s_machine),\n", grammar_name);
+	fprintf(out, "\t.actions = %s_action_table,\n", grammar_name);
+	fprintf(out, "};\n");
+}
+
+/*
+ * Render the out-of-line elements
+ */
+static void render_out_of_line_list(FILE *out)
+{
+	struct element *e, *ce;
+	const char *act;
+	int entry;
+
+	while ((e = render_list)) {
+		render_list = e->render_next;
+		if (!render_list)
+			render_list_p = &render_list;
+
+		render_more(out, "\n");
+		e->entry_index = entry = nr_entries;
+		render_depth++;
+		for (ce = e->children; ce; ce = ce->next)
+			render_element(out, ce, NULL);
+		render_depth--;
+
+		act = e->action ? "_ACT" : "";
+		switch (e->compound) {
+		case SEQUENCE:
+			render_opcode(out, "ASN1_OP_END_SEQ%s,\n", act);
+			break;
+		case SEQUENCE_OF:
+			render_opcode(out, "ASN1_OP_END_SEQ_OF%s,\n", act);
+			render_opcode(out, "_jump_target(%u),\n", entry);
+			break;
+		case SET:
+			render_opcode(out, "ASN1_OP_END_SET%s,\n", act);
+			break;
+		case SET_OF:
+			render_opcode(out, "ASN1_OP_END_SET_OF%s,\n", act);
+			render_opcode(out, "_jump_target(%u),\n", entry);
+			break;
+		default:
+			break;
+		}
+		if (e->action)
+			render_opcode(out, "_action(ACT_%s),\n",
+				      e->action->name);
+		render_opcode(out, "ASN1_OP_RETURN,\n");
+	}
+}
+
+/*
+ * Render an element.
+ */
+static void render_element(FILE *out, struct element *e, struct element *tag)
+{
+	struct element *ec, *x;
+	const char *cond, *act;
+	int entry, skippable = 0, outofline = 0;
+
+	if (e->flags & ELEMENT_SKIPPABLE ||
+	    (tag && tag->flags & ELEMENT_SKIPPABLE))
+		skippable = 1;
+
+	if ((e->type_def && e->type_def->ref_count > 1) ||
+	    skippable)
+		outofline = 1;
+
+	if (e->type_def && out) {
+		render_more(out, "\t// %s\n", e->type_def->name->content);
+	}
+
+	/* Render the operation */
+	cond = (e->flags & ELEMENT_CONDITIONAL ||
+		(tag && tag->flags & ELEMENT_CONDITIONAL)) ? "COND_" : "";
+	act = e->action ? "_ACT" : "";
+	switch (e->compound) {
+	case ANY:
+		render_opcode(out, "ASN1_OP_%sMATCH_ANY%s%s,",
+			      cond, act, skippable ? "_OR_SKIP" : "");
+		if (e->name)
+			render_more(out, "\t\t// %s", e->name->content);
+		render_more(out, "\n");
+		goto dont_render_tag;
+
+	case TAG_OVERRIDE:
+		render_element(out, e->children, e);
+		return;
+
+	case SEQUENCE:
+	case SEQUENCE_OF:
+	case SET:
+	case SET_OF:
+		render_opcode(out, "ASN1_OP_%sMATCH%s%s,",
+			      cond,
+			      outofline ? "_JUMP" : "",
+			      skippable ? "_OR_SKIP" : "");
+		break;
+
+	case CHOICE:
+		goto dont_render_tag;
+
+	case TYPE_REF:
+		if (e->class == ASN1_UNIV && e->method == ASN1_PRIM && e->tag == 0)
+			goto dont_render_tag;
+	default:
+		render_opcode(out, "ASN1_OP_%sMATCH%s%s,",
+			      cond, act,
+			      skippable ? "_OR_SKIP" : "");
+		break;
+	}
+
+	x = tag ?: e;
+	if (x->name)
+		render_more(out, "\t\t// %s", x->name->content);
+	render_more(out, "\n");
+
+	/* Render the tag */
+	if (!tag || !(tag->flags & ELEMENT_TAG_SPECIFIED))
+		tag = e;
+
+	if (tag->class == ASN1_UNIV &&
+	    tag->tag != 14 &&
+	    tag->tag != 15 &&
+	    tag->tag != 31)
+		render_opcode(out, "_tag(%s, %s, %s),\n",
+			      asn1_classes[tag->class],
+			      asn1_methods[tag->method | e->method],
+			      asn1_universal_tags[tag->tag]);
+	else
+		render_opcode(out, "_tagn(%s, %s, %2u),\n",
+			      asn1_classes[tag->class],
+			      asn1_methods[tag->method | e->method],
+			      tag->tag);
+	tag = NULL;
+dont_render_tag:
+
+	/* Deal with compound types */
+	switch (e->compound) {
+	case TYPE_REF:
+		render_element(out, e->type->type->element, tag);
+		if (e->action)
+			render_opcode(out, "ASN1_OP_%sACT,\n",
+				      skippable ? "MAYBE_" : "");
+		break;
+
+	case SEQUENCE:
+		if (outofline) {
+			/* Render out-of-line for multiple use or
+			 * skipability */
+			render_opcode(out, "_jump_target(%u),", e->entry_index);
+			if (e->type_def && e->type_def->name)
+				render_more(out, "\t\t// --> %s",
+					    e->type_def->name->content);
+			render_more(out, "\n");
+			if (!(e->flags & ELEMENT_RENDERED)) {
+				e->flags |= ELEMENT_RENDERED;
+				*render_list_p = e;
+				render_list_p = &e->render_next;
+			}
+			return;
+		} else {
+			/* Render inline for single use */
+			render_depth++;
+			for (ec = e->children; ec; ec = ec->next)
+				render_element(out, ec, NULL);
+			render_depth--;
+			render_opcode(out, "ASN1_OP_END_SEQ%s,\n", act);
+		}
+		break;
+
+	case SEQUENCE_OF:
+	case SET_OF:
+		if (outofline) {
+			/* Render out-of-line for multiple use or
+			 * skipability */
+			render_opcode(out, "_jump_target(%u),", e->entry_index);
+			if (e->type_def && e->type_def->name)
+				render_more(out, "\t\t// --> %s",
+					    e->type_def->name->content);
+			render_more(out, "\n");
+			if (!(e->flags & ELEMENT_RENDERED)) {
+				e->flags |= ELEMENT_RENDERED;
+				*render_list_p = e;
+				render_list_p = &e->render_next;
+			}
+			return;
+		} else {
+			/* Render inline for single use */
+			entry = nr_entries;
+			render_depth++;
+			render_element(out, e->children, NULL);
+			render_depth--;
+			if (e->compound == SEQUENCE_OF)
+				render_opcode(out, "ASN1_OP_END_SEQ_OF%s,\n", act);
+			else
+				render_opcode(out, "ASN1_OP_END_SET_OF%s,\n", act);
+			render_opcode(out, "_jump_target(%u),\n", entry);
+		}
+		break;
+
+	case SET:
+		/* I can't think of a nice way to do SET support without having
+		 * a stack of bitmasks to make sure no element is repeated.
+		 * The bitmask has also to be checked that no non-optional
+		 * elements are left out whilst not preventing optional
+		 * elements from being left out.
+		 */
+		fprintf(stderr, "The ASN.1 SET type is not currently supported.\n");
+		exit(1);
+
+	case CHOICE:
+		for (ec = e->children; ec; ec = ec->next)
+			render_element(out, ec, ec);
+		if (!skippable)
+			render_opcode(out, "ASN1_OP_COND_FAIL,\n");
+		if (e->action)
+			render_opcode(out, "ASN1_OP_ACT,\n");
+		break;
+
+	default:
+		break;
+	}
+
+	if (e->action)
+		render_opcode(out, "_action(ACT_%s),\n", e->action->name);
+}
diff --git a/libkmod/pkcs7/asn1_decoder.c b/libkmod/pkcs7/asn1_decoder.c
new file mode 100644
index 000000000000..d31f95b5315c
--- /dev/null
+++ b/libkmod/pkcs7/asn1_decoder.c
@@ -0,0 +1,514 @@
+/* Decoder for ASN.1 BER/DER/CER encoded bytestream
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/asn1_decoder.h>
+#include <linux/asn1_ber_bytecode.h>
+#include <errno.h>
+
+#include <stdio.h>
+#define pr_debug(...)
+#define pr_info(...) printf(__VA_ARGS__)
+#define pr_err(...) printf(__VA_ARGS__)
+#define pr_warn(...) printf(__VA_ARGS__)
+#define pr_devel(...)
+#define likely(...) __VA_ARGS__
+#define unlikely(...) __VA_ARGS__
+
+static const unsigned char asn1_op_lengths[ASN1_OP__NR] = {
+	/*					OPC TAG JMP ACT */
+	[ASN1_OP_MATCH]				= 1 + 1,
+	[ASN1_OP_MATCH_OR_SKIP]			= 1 + 1,
+	[ASN1_OP_MATCH_ACT]			= 1 + 1     + 1,
+	[ASN1_OP_MATCH_ACT_OR_SKIP]		= 1 + 1     + 1,
+	[ASN1_OP_MATCH_JUMP]			= 1 + 1 + 1,
+	[ASN1_OP_MATCH_JUMP_OR_SKIP]		= 1 + 1 + 1,
+	[ASN1_OP_MATCH_ANY]			= 1,
+	[ASN1_OP_MATCH_ANY_OR_SKIP]		= 1,
+	[ASN1_OP_MATCH_ANY_ACT]			= 1         + 1,
+	[ASN1_OP_MATCH_ANY_ACT_OR_SKIP]		= 1         + 1,
+	[ASN1_OP_COND_MATCH_OR_SKIP]		= 1 + 1,
+	[ASN1_OP_COND_MATCH_ACT_OR_SKIP]	= 1 + 1     + 1,
+	[ASN1_OP_COND_MATCH_JUMP_OR_SKIP]	= 1 + 1 + 1,
+	[ASN1_OP_COND_MATCH_ANY]		= 1,
+	[ASN1_OP_COND_MATCH_ANY_OR_SKIP]	= 1,
+	[ASN1_OP_COND_MATCH_ANY_ACT]		= 1         + 1,
+	[ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP]	= 1         + 1,
+	[ASN1_OP_COND_FAIL]			= 1,
+	[ASN1_OP_COMPLETE]			= 1,
+	[ASN1_OP_ACT]				= 1         + 1,
+	[ASN1_OP_MAYBE_ACT]			= 1         + 1,
+	[ASN1_OP_RETURN]			= 1,
+	[ASN1_OP_END_SEQ]			= 1,
+	[ASN1_OP_END_SEQ_OF]			= 1     + 1,
+	[ASN1_OP_END_SET]			= 1,
+	[ASN1_OP_END_SET_OF]			= 1     + 1,
+	[ASN1_OP_END_SEQ_ACT]			= 1         + 1,
+	[ASN1_OP_END_SEQ_OF_ACT]		= 1     + 1 + 1,
+	[ASN1_OP_END_SET_ACT]			= 1         + 1,
+	[ASN1_OP_END_SET_OF_ACT]		= 1     + 1 + 1,
+};
+
+/*
+ * Find the length of an indefinite length object
+ * @data: The data buffer
+ * @datalen: The end of the innermost containing element in the buffer
+ * @_dp: The data parse cursor (updated before returning)
+ * @_len: Where to return the size of the element.
+ * @_errmsg: Where to return a pointer to an error message on error
+ */
+static int asn1_find_indefinite_length(const unsigned char *data, size_t datalen,
+				       size_t *_dp, size_t *_len,
+				       const char **_errmsg)
+{
+	unsigned char tag, tmp;
+	size_t dp = *_dp, len, n;
+	int indef_level = 1;
+
+next_tag:
+	if (unlikely(datalen - dp < 2)) {
+		if (datalen == dp)
+			goto missing_eoc;
+		goto data_overrun_error;
+	}
+
+	/* Extract a tag from the data */
+	tag = data[dp++];
+	if (tag == ASN1_EOC) {
+		/* It appears to be an EOC. */
+		if (data[dp++] != 0)
+			goto invalid_eoc;
+		if (--indef_level <= 0) {
+			*_len = dp - *_dp;
+			*_dp = dp;
+			return 0;
+		}
+		goto next_tag;
+	}
+
+	if (unlikely((tag & 0x1f) == ASN1_LONG_TAG)) {
+		do {
+			if (unlikely(datalen - dp < 2))
+				goto data_overrun_error;
+			tmp = data[dp++];
+		} while (tmp & 0x80);
+	}
+
+	/* Extract the length */
+	len = data[dp++];
+	if (len <= 0x7f)
+		goto check_length;
+
+	if (unlikely(len == ASN1_INDEFINITE_LENGTH)) {
+		/* Indefinite length */
+		if (unlikely((tag & ASN1_CONS_BIT) == ASN1_PRIM << 5))
+			goto indefinite_len_primitive;
+		indef_level++;
+		goto next_tag;
+	}
+
+	n = len - 0x80;
+	if (unlikely(n > sizeof(len) - 1))
+		goto length_too_long;
+	if (unlikely(n > datalen - dp))
+		goto data_overrun_error;
+	len = 0;
+	for (; n > 0; n--) {
+		len <<= 8;
+		len |= data[dp++];
+	}
+check_length:
+	if (len > datalen - dp)
+		goto data_overrun_error;
+	dp += len;
+	goto next_tag;
+
+length_too_long:
+	*_errmsg = "Unsupported length";
+	goto error;
+indefinite_len_primitive:
+	*_errmsg = "Indefinite len primitive not permitted";
+	goto error;
+invalid_eoc:
+	*_errmsg = "Invalid length EOC";
+	goto error;
+data_overrun_error:
+	*_errmsg = "Data overrun error";
+	goto error;
+missing_eoc:
+	*_errmsg = "Missing EOC in indefinite len cons";
+error:
+	*_dp = dp;
+	return -1;
+}
+
+/**
+ * asn1_ber_decoder - Decoder BER/DER/CER ASN.1 according to pattern
+ * @decoder: The decoder definition (produced by asn1_compiler)
+ * @context: The caller's context (to be passed to the action functions)
+ * @data: The encoded data
+ * @datalen: The size of the encoded data
+ *
+ * Decode BER/DER/CER encoded ASN.1 data according to a bytecode pattern
+ * produced by asn1_compiler.  Action functions are called on marked tags to
+ * allow the caller to retrieve significant data.
+ *
+ * LIMITATIONS:
+ *
+ * To keep down the amount of stack used by this function, the following limits
+ * have been imposed:
+ *
+ *  (1) This won't handle datalen > 65535 without increasing the size of the
+ *	cons stack elements and length_too_long checking.
+ *
+ *  (2) The stack of constructed types is 10 deep.  If the depth of non-leaf
+ *	constructed types exceeds this, the decode will fail.
+ *
+ *  (3) The SET type (not the SET OF type) isn't really supported as tracking
+ *	what members of the set have been seen is a pain.
+ */
+int asn1_ber_decoder(const struct asn1_decoder *decoder,
+		     void *context,
+		     const unsigned char *data,
+		     size_t datalen)
+{
+	const unsigned char *machine = decoder->machine;
+	const asn1_action_t *actions = decoder->actions;
+	size_t machlen = decoder->machlen;
+	enum asn1_opcode op;
+	unsigned char tag = 0, csp = 0, jsp = 0, optag = 0, hdr = 0;
+	const char *errmsg;
+	size_t pc = 0, dp = 0, tdp = 0, len = 0;
+	int ret;
+
+	unsigned char flags = 0;
+#define FLAG_INDEFINITE_LENGTH	0x01
+#define FLAG_MATCHED		0x02
+#define FLAG_LAST_MATCHED	0x04 /* Last tag matched */
+#define FLAG_CONS		0x20 /* Corresponds to CONS bit in the opcode tag
+				      * - ie. whether or not we are going to parse
+				      *   a compound type.
+				      */
+
+#define NR_CONS_STACK 10
+	unsigned short cons_dp_stack[NR_CONS_STACK];
+	unsigned short cons_datalen_stack[NR_CONS_STACK];
+	unsigned char cons_hdrlen_stack[NR_CONS_STACK];
+#define NR_JUMP_STACK 10
+	unsigned char jump_stack[NR_JUMP_STACK];
+
+	if (datalen > 65535)
+		return -EMSGSIZE;
+
+next_op:
+	pr_debug("next_op: pc=\e[32m%zu\e[m/%zu dp=\e[33m%zu\e[m/%zu C=%d J=%d\n",
+		 pc, machlen, dp, datalen, csp, jsp);
+	if (unlikely(pc >= machlen))
+		goto machine_overrun_error;
+	op = machine[pc];
+	if (unlikely(pc + asn1_op_lengths[op] > machlen))
+		goto machine_overrun_error;
+
+	/* If this command is meant to match a tag, then do that before
+	 * evaluating the command.
+	 */
+	if (op <= ASN1_OP__MATCHES_TAG) {
+		unsigned char tmp;
+
+		/* Skip conditional matches if possible */
+		if ((op & ASN1_OP_MATCH__COND && flags & FLAG_MATCHED) ||
+		    (op & ASN1_OP_MATCH__SKIP && dp == datalen)) {
+			flags &= ~FLAG_LAST_MATCHED;
+			pc += asn1_op_lengths[op];
+			goto next_op;
+		}
+
+		flags = 0;
+		hdr = 2;
+
+		/* Extract a tag from the data */
+		if (unlikely(dp >= datalen - 1))
+			goto data_overrun_error;
+		tag = data[dp++];
+		if (unlikely((tag & 0x1f) == ASN1_LONG_TAG))
+			goto long_tag_not_supported;
+
+		if (op & ASN1_OP_MATCH__ANY) {
+			pr_debug("- any %02x\n", tag);
+		} else {
+			/* Extract the tag from the machine
+			 * - Either CONS or PRIM are permitted in the data if
+			 *   CONS is not set in the op stream, otherwise CONS
+			 *   is mandatory.
+			 */
+			optag = machine[pc + 1];
+			flags |= optag & FLAG_CONS;
+
+			/* Determine whether the tag matched */
+			tmp = optag ^ tag;
+			tmp &= ~(optag & ASN1_CONS_BIT);
+			pr_debug("- match? %02x %02x %02x\n", tag, optag, tmp);
+			if (tmp != 0) {
+				/* All odd-numbered tags are MATCH_OR_SKIP. */
+				if (op & ASN1_OP_MATCH__SKIP) {
+					pc += asn1_op_lengths[op];
+					dp--;
+					goto next_op;
+				}
+				goto tag_mismatch;
+			}
+		}
+		flags |= FLAG_MATCHED;
+
+		len = data[dp++];
+		if (len > 0x7f) {
+			if (unlikely(len == ASN1_INDEFINITE_LENGTH)) {
+				/* Indefinite length */
+				if (unlikely(!(tag & ASN1_CONS_BIT)))
+					goto indefinite_len_primitive;
+				flags |= FLAG_INDEFINITE_LENGTH;
+				if (unlikely(2 > datalen - dp))
+					goto data_overrun_error;
+			} else {
+				int n = len - 0x80;
+				if (unlikely(n > 2))
+					goto length_too_long;
+				if (unlikely(dp >= datalen - n))
+					goto data_overrun_error;
+				hdr += n;
+				for (len = 0; n > 0; n--) {
+					len <<= 8;
+					len |= data[dp++];
+				}
+				if (unlikely(len > datalen - dp))
+					goto data_overrun_error;
+			}
+		}
+
+		if (flags & FLAG_CONS) {
+			/* For expected compound forms, we stack the positions
+			 * of the start and end of the data.
+			 */
+			if (unlikely(csp >= NR_CONS_STACK))
+				goto cons_stack_overflow;
+			cons_dp_stack[csp] = dp;
+			cons_hdrlen_stack[csp] = hdr;
+			if (!(flags & FLAG_INDEFINITE_LENGTH)) {
+				cons_datalen_stack[csp] = datalen;
+				datalen = dp + len;
+			} else {
+				cons_datalen_stack[csp] = 0;
+			}
+			csp++;
+		}
+
+		pr_debug("- TAG: %02x %zu%s\n",
+			 tag, len, flags & FLAG_CONS ? " CONS" : "");
+		tdp = dp;
+	}
+
+	/* Decide how to handle the operation */
+	switch (op) {
+	case ASN1_OP_MATCH_ANY_ACT:
+	case ASN1_OP_MATCH_ANY_ACT_OR_SKIP:
+	case ASN1_OP_COND_MATCH_ANY_ACT:
+	case ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP:
+		ret = actions[machine[pc + 1]](context, hdr, tag, data + dp, len);
+		if (ret < 0)
+			return ret;
+		goto skip_data;
+
+	case ASN1_OP_MATCH_ACT:
+	case ASN1_OP_MATCH_ACT_OR_SKIP:
+	case ASN1_OP_COND_MATCH_ACT_OR_SKIP:
+		ret = actions[machine[pc + 2]](context, hdr, tag, data + dp, len);
+		if (ret < 0)
+			return ret;
+		goto skip_data;
+
+	case ASN1_OP_MATCH:
+	case ASN1_OP_MATCH_OR_SKIP:
+	case ASN1_OP_MATCH_ANY:
+	case ASN1_OP_MATCH_ANY_OR_SKIP:
+	case ASN1_OP_COND_MATCH_OR_SKIP:
+	case ASN1_OP_COND_MATCH_ANY:
+	case ASN1_OP_COND_MATCH_ANY_OR_SKIP:
+	skip_data:
+		if (!(flags & FLAG_CONS)) {
+			if (flags & FLAG_INDEFINITE_LENGTH) {
+				ret = asn1_find_indefinite_length(
+					data, datalen, &dp, &len, &errmsg);
+				if (ret < 0)
+					goto error;
+			} else {
+				dp += len;
+			}
+			pr_debug("- LEAF: %zu\n", len);
+		}
+		pc += asn1_op_lengths[op];
+		goto next_op;
+
+	case ASN1_OP_MATCH_JUMP:
+	case ASN1_OP_MATCH_JUMP_OR_SKIP:
+	case ASN1_OP_COND_MATCH_JUMP_OR_SKIP:
+		pr_debug("- MATCH_JUMP\n");
+		if (unlikely(jsp == NR_JUMP_STACK))
+			goto jump_stack_overflow;
+		jump_stack[jsp++] = pc + asn1_op_lengths[op];
+		pc = machine[pc + 2];
+		goto next_op;
+
+	case ASN1_OP_COND_FAIL:
+		if (unlikely(!(flags & FLAG_MATCHED)))
+			goto tag_mismatch;
+		pc += asn1_op_lengths[op];
+		goto next_op;
+
+	case ASN1_OP_COMPLETE:
+		if (unlikely(jsp != 0 || csp != 0)) {
+			pr_err("ASN.1 decoder error: Stacks not empty at completion (%u, %u)\n",
+			       jsp, csp);
+			return -EBADMSG;
+		}
+		return 0;
+
+	case ASN1_OP_END_SET:
+	case ASN1_OP_END_SET_ACT:
+		if (unlikely(!(flags & FLAG_MATCHED)))
+			goto tag_mismatch;
+	case ASN1_OP_END_SEQ:
+	case ASN1_OP_END_SET_OF:
+	case ASN1_OP_END_SEQ_OF:
+	case ASN1_OP_END_SEQ_ACT:
+	case ASN1_OP_END_SET_OF_ACT:
+	case ASN1_OP_END_SEQ_OF_ACT:
+		if (unlikely(csp <= 0))
+			goto cons_stack_underflow;
+		csp--;
+		tdp = cons_dp_stack[csp];
+		hdr = cons_hdrlen_stack[csp];
+		len = datalen;
+		datalen = cons_datalen_stack[csp];
+		pr_debug("- end cons t=%zu dp=%zu l=%zu/%zu\n",
+			 tdp, dp, len, datalen);
+		if (datalen == 0) {
+			/* Indefinite length - check for the EOC. */
+			datalen = len;
+			if (unlikely(datalen - dp < 2))
+				goto data_overrun_error;
+			if (data[dp++] != 0) {
+				if (op & ASN1_OP_END__OF) {
+					dp--;
+					csp++;
+					pc = machine[pc + 1];
+					pr_debug("- continue\n");
+					goto next_op;
+				}
+				goto missing_eoc;
+			}
+			if (data[dp++] != 0)
+				goto invalid_eoc;
+			len = dp - tdp - 2;
+		} else {
+			if (dp < len && (op & ASN1_OP_END__OF)) {
+				datalen = len;
+				csp++;
+				pc = machine[pc + 1];
+				pr_debug("- continue\n");
+				goto next_op;
+			}
+			if (dp != len)
+				goto cons_length_error;
+			len -= tdp;
+			pr_debug("- cons len l=%zu d=%zu\n", len, dp - tdp);
+		}
+
+		if (op & ASN1_OP_END__ACT) {
+			unsigned char act;
+			if (op & ASN1_OP_END__OF)
+				act = machine[pc + 2];
+			else
+				act = machine[pc + 1];
+			ret = actions[act](context, hdr, 0, data + tdp, len);
+		}
+		pc += asn1_op_lengths[op];
+		goto next_op;
+
+	case ASN1_OP_MAYBE_ACT:
+		if (!(flags & FLAG_LAST_MATCHED)) {
+			pc += asn1_op_lengths[op];
+			goto next_op;
+		}
+	case ASN1_OP_ACT:
+		ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
+		if (ret < 0)
+			return ret;
+		pc += asn1_op_lengths[op];
+		goto next_op;
+
+	case ASN1_OP_RETURN:
+		if (unlikely(jsp <= 0))
+			goto jump_stack_underflow;
+		pc = jump_stack[--jsp];
+		flags |= FLAG_MATCHED | FLAG_LAST_MATCHED;
+		goto next_op;
+
+	default:
+		break;
+	}
+
+	/* Shouldn't reach here */
+	pr_err("ASN.1 decoder error: Found reserved opcode (%u) pc=%zu\n",
+	       op, pc);
+	return -EBADMSG;
+
+data_overrun_error:
+	errmsg = "Data overrun error";
+	goto error;
+machine_overrun_error:
+	errmsg = "Machine overrun error";
+	goto error;
+jump_stack_underflow:
+	errmsg = "Jump stack underflow";
+	goto error;
+jump_stack_overflow:
+	errmsg = "Jump stack overflow";
+	goto error;
+cons_stack_underflow:
+	errmsg = "Cons stack underflow";
+	goto error;
+cons_stack_overflow:
+	errmsg = "Cons stack overflow";
+	goto error;
+cons_length_error:
+	errmsg = "Cons length error";
+	goto error;
+missing_eoc:
+	errmsg = "Missing EOC in indefinite len cons";
+	goto error;
+invalid_eoc:
+	errmsg = "Invalid length EOC";
+	goto error;
+length_too_long:
+	errmsg = "Unsupported length";
+	goto error;
+indefinite_len_primitive:
+	errmsg = "Indefinite len primitive not permitted";
+	goto error;
+tag_mismatch:
+	errmsg = "Unexpected tag";
+	goto error;
+long_tag_not_supported:
+	errmsg = "Long tag not supported";
+error:
+	pr_debug("\nASN1: %s [m=%zu d=%zu ot=%02x t=%02x l=%zu]\n",
+		 errmsg, pc, dp, optag, tag, len);
+	return -EBADMSG;
+}
diff --git a/libkmod/pkcs7/include/linux/asn1.h b/libkmod/pkcs7/include/linux/asn1.h
new file mode 100644
index 000000000000..eed6982860ba
--- /dev/null
+++ b/libkmod/pkcs7/include/linux/asn1.h
@@ -0,0 +1,69 @@
+/* ASN.1 BER/DER/CER encoding definitions
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_ASN1_H
+#define _LINUX_ASN1_H
+
+/* Class */
+enum asn1_class {
+	ASN1_UNIV	= 0,	/* Universal */
+	ASN1_APPL	= 1,	/* Application */
+	ASN1_CONT	= 2,	/* Context */
+	ASN1_PRIV	= 3	/* Private */
+};
+#define ASN1_CLASS_BITS	0xc0
+
+
+enum asn1_method {
+	ASN1_PRIM	= 0,	/* Primitive */
+	ASN1_CONS	= 1	/* Constructed */
+};
+#define ASN1_CONS_BIT	0x20
+
+/* Tag */
+enum asn1_tag {
+	ASN1_EOC	= 0,	/* End Of Contents or N/A */
+	ASN1_BOOL	= 1,	/* Boolean */
+	ASN1_INT	= 2,	/* Integer */
+	ASN1_BTS	= 3,	/* Bit String */
+	ASN1_OTS	= 4,	/* Octet String */
+	ASN1_NULL	= 5,	/* Null */
+	ASN1_OID	= 6,	/* Object Identifier  */
+	ASN1_ODE	= 7,	/* Object Description */
+	ASN1_EXT	= 8,	/* External */
+	ASN1_REAL	= 9,	/* Real float */
+	ASN1_ENUM	= 10,	/* Enumerated */
+	ASN1_EPDV	= 11,	/* Embedded PDV */
+	ASN1_UTF8STR	= 12,	/* UTF8 String */
+	ASN1_RELOID	= 13,	/* Relative OID */
+	/* 14 - Reserved */
+	/* 15 - Reserved */
+	ASN1_SEQ	= 16,	/* Sequence and Sequence of */
+	ASN1_SET	= 17,	/* Set and Set of */
+	ASN1_NUMSTR	= 18,	/* Numerical String */
+	ASN1_PRNSTR	= 19,	/* Printable String */
+	ASN1_TEXSTR	= 20,	/* T61 String / Teletext String */
+	ASN1_VIDSTR	= 21,	/* Videotex String */
+	ASN1_IA5STR	= 22,	/* IA5 String */
+	ASN1_UNITIM	= 23,	/* Universal Time */
+	ASN1_GENTIM	= 24,	/* General Time */
+	ASN1_GRASTR	= 25,	/* Graphic String */
+	ASN1_VISSTR	= 26,	/* Visible String */
+	ASN1_GENSTR	= 27,	/* General String */
+	ASN1_UNISTR	= 28,	/* Universal String */
+	ASN1_CHRSTR	= 29,	/* Character String */
+	ASN1_BMPSTR	= 30,	/* BMP String */
+	ASN1_LONG_TAG	= 31	/* Long form tag */
+};
+
+#define ASN1_INDEFINITE_LENGTH 0x80
+
+#endif /* _LINUX_ASN1_H */
diff --git a/libkmod/pkcs7/include/linux/asn1_ber_bytecode.h b/libkmod/pkcs7/include/linux/asn1_ber_bytecode.h
new file mode 100644
index 000000000000..b89870b056f4
--- /dev/null
+++ b/libkmod/pkcs7/include/linux/asn1_ber_bytecode.h
@@ -0,0 +1,94 @@
+/* ASN.1 BER/DER/CER parsing state machine internal definitions
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_ASN1_BER_BYTECODE_H
+#define _LINUX_ASN1_BER_BYTECODE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#endif
+#include <linux/asn1.h>
+#include <sys/types.h>
+
+typedef int (*asn1_action_t)(void *context,
+			     size_t hdrlen, /* In case of ANY type */
+			     unsigned char tag, /* In case of ANY type */
+			     const void *value, size_t vlen);
+
+struct asn1_decoder {
+	const unsigned char *machine;
+	size_t machlen;
+	const asn1_action_t *actions;
+};
+
+enum asn1_opcode {
+	/* The tag-matching ops come first and the odd-numbered slots
+	 * are for OR_SKIP ops.
+	 */
+#define ASN1_OP_MATCH__SKIP		  0x01
+#define ASN1_OP_MATCH__ACT		  0x02
+#define ASN1_OP_MATCH__JUMP		  0x04
+#define ASN1_OP_MATCH__ANY		  0x08
+#define ASN1_OP_MATCH__COND		  0x10
+
+	ASN1_OP_MATCH			= 0x00,
+	ASN1_OP_MATCH_OR_SKIP		= 0x01,
+	ASN1_OP_MATCH_ACT		= 0x02,
+	ASN1_OP_MATCH_ACT_OR_SKIP	= 0x03,
+	ASN1_OP_MATCH_JUMP		= 0x04,
+	ASN1_OP_MATCH_JUMP_OR_SKIP	= 0x05,
+	ASN1_OP_MATCH_ANY		= 0x08,
+	ASN1_OP_MATCH_ANY_OR_SKIP	= 0x09,
+	ASN1_OP_MATCH_ANY_ACT		= 0x0a,
+	ASN1_OP_MATCH_ANY_ACT_OR_SKIP	= 0x0b,
+	/* Everything before here matches unconditionally */
+
+	ASN1_OP_COND_MATCH_OR_SKIP	= 0x11,
+	ASN1_OP_COND_MATCH_ACT_OR_SKIP	= 0x13,
+	ASN1_OP_COND_MATCH_JUMP_OR_SKIP	= 0x15,
+	ASN1_OP_COND_MATCH_ANY		= 0x18,
+	ASN1_OP_COND_MATCH_ANY_OR_SKIP	= 0x19,
+	ASN1_OP_COND_MATCH_ANY_ACT	= 0x1a,
+	ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP = 0x1b,
+
+	/* Everything before here will want a tag from the data */
+#define ASN1_OP__MATCHES_TAG ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP
+
+	/* These are here to help fill up space */
+	ASN1_OP_COND_FAIL		= 0x1c,
+	ASN1_OP_COMPLETE		= 0x1d,
+	ASN1_OP_ACT			= 0x1e,
+	ASN1_OP_MAYBE_ACT		= 0x1f,
+
+	/* The following eight have bit 0 -> SET, 1 -> OF, 2 -> ACT */
+	ASN1_OP_END_SEQ			= 0x20,
+	ASN1_OP_END_SET			= 0x21,
+	ASN1_OP_END_SEQ_OF		= 0x22,
+	ASN1_OP_END_SET_OF		= 0x23,
+	ASN1_OP_END_SEQ_ACT		= 0x24,
+	ASN1_OP_END_SET_ACT		= 0x25,
+	ASN1_OP_END_SEQ_OF_ACT		= 0x26,
+	ASN1_OP_END_SET_OF_ACT		= 0x27,
+#define ASN1_OP_END__SET		  0x01
+#define ASN1_OP_END__OF			  0x02
+#define ASN1_OP_END__ACT		  0x04
+
+	ASN1_OP_RETURN			= 0x28,
+
+	ASN1_OP__NR
+};
+
+#define _tag(CLASS, CP, TAG) ((ASN1_##CLASS << 6) | (ASN1_##CP << 5) | ASN1_##TAG)
+#define _tagn(CLASS, CP, TAG) ((ASN1_##CLASS << 6) | (ASN1_##CP << 5) | TAG)
+#define _jump_target(N) (N)
+#define _action(N) (N)
+
+#endif /* _LINUX_ASN1_BER_BYTECODE_H */
diff --git a/libkmod/pkcs7/include/linux/asn1_decoder.h b/libkmod/pkcs7/include/linux/asn1_decoder.h
new file mode 100644
index 000000000000..3a073037d27f
--- /dev/null
+++ b/libkmod/pkcs7/include/linux/asn1_decoder.h
@@ -0,0 +1,25 @@
+/* ASN.1 decoder
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_ASN1_DECODER_H
+#define _LINUX_ASN1_DECODER_H
+
+#include <linux/asn1.h>
+#include <stddef.h>
+
+struct asn1_decoder;
+
+extern int asn1_ber_decoder(const struct asn1_decoder *decoder,
+			    void *context,
+			    const unsigned char *data,
+			    size_t datalen);
+
+#endif /* _LINUX_ASN1_DECODER_H */
diff --git a/libkmod/pkcs7/include/linux/oid_registry.h b/libkmod/pkcs7/include/linux/oid_registry.h
new file mode 100644
index 000000000000..d2fa9ca42e9a
--- /dev/null
+++ b/libkmod/pkcs7/include/linux/oid_registry.h
@@ -0,0 +1,103 @@
+/* ASN.1 Object identifier (OID) registry
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_OID_REGISTRY_H
+#define _LINUX_OID_REGISTRY_H
+
+#include <linux/types.h>
+
+/*
+ * OIDs are turned into these values if possible, or OID__NR if not held here.
+ *
+ * NOTE!  Do not mess with the format of each line as this is read by
+ *	  build_OID_registry.pl to generate the data for look_up_OID().
+ */
+enum OID {
+	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
+	OID_id_dsa,			/* 1.2.840.10040.4.1 */
+	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
+	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
+
+	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
+	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
+	OID_md2WithRSAEncryption,	/* 1.2.840.113549.1.1.2 */
+	OID_md3WithRSAEncryption,	/* 1.2.840.113549.1.1.3 */
+	OID_md4WithRSAEncryption,	/* 1.2.840.113549.1.1.4 */
+	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
+	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
+	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
+	OID_sha512WithRSAEncryption,	/* 1.2.840.113549.1.1.13 */
+	OID_sha224WithRSAEncryption,	/* 1.2.840.113549.1.1.14 */
+	/* PKCS#7 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-7(7)} */
+	OID_data,			/* 1.2.840.113549.1.7.1 */
+	OID_signed_data,		/* 1.2.840.113549.1.7.2 */
+	/* PKCS#9 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-9(9)} */
+	OID_email_address,		/* 1.2.840.113549.1.9.1 */
+	OID_contentType,		/* 1.2.840.113549.1.9.3 */
+	OID_messageDigest,		/* 1.2.840.113549.1.9.4 */
+	OID_signingTime,		/* 1.2.840.113549.1.9.5 */
+	OID_smimeCapabilites,		/* 1.2.840.113549.1.9.15 */
+	OID_smimeAuthenticatedAttrs,	/* 1.2.840.113549.1.9.16.2.11 */
+
+	/* {iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2)} */
+	OID_md2,			/* 1.2.840.113549.2.2 */
+	OID_md4,			/* 1.2.840.113549.2.4 */
+	OID_md5,			/* 1.2.840.113549.2.5 */
+
+	/* Microsoft Authenticode & Software Publishing */
+	OID_msIndirectData,		/* 1.3.6.1.4.1.311.2.1.4 */
+	OID_msStatementType,		/* 1.3.6.1.4.1.311.2.1.11 */
+	OID_msSpOpusInfo,		/* 1.3.6.1.4.1.311.2.1.12 */
+	OID_msPeImageDataObjId,		/* 1.3.6.1.4.1.311.2.1.15 */
+	OID_msIndividualSPKeyPurpose,	/* 1.3.6.1.4.1.311.2.1.21 */
+	OID_msOutlookExpress,		/* 1.3.6.1.4.1.311.16.4 */
+
+	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
+	OID_sha1,			/* 1.3.14.3.2.26 */
+	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
+	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
+	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
+	OID_sha224,			/* 2.16.840.1.101.3.4.2.4 */
+
+	/* Distinguished Name attribute IDs [RFC 2256] */
+	OID_commonName,			/* 2.5.4.3 */
+	OID_surname,			/* 2.5.4.4 */
+	OID_countryName,		/* 2.5.4.6 */
+	OID_locality,			/* 2.5.4.7 */
+	OID_stateOrProvinceName,	/* 2.5.4.8 */
+	OID_organizationName,		/* 2.5.4.10 */
+	OID_organizationUnitName,	/* 2.5.4.11 */
+	OID_title,			/* 2.5.4.12 */
+	OID_description,		/* 2.5.4.13 */
+	OID_name,			/* 2.5.4.41 */
+	OID_givenName,			/* 2.5.4.42 */
+	OID_initials,			/* 2.5.4.43 */
+	OID_generationalQualifier,	/* 2.5.4.44 */
+
+	/* Certificate extension IDs */
+	OID_subjectKeyIdentifier,	/* 2.5.29.14 */
+	OID_keyUsage,			/* 2.5.29.15 */
+	OID_subjectAltName,		/* 2.5.29.17 */
+	OID_issuerAltName,		/* 2.5.29.18 */
+	OID_basicConstraints,		/* 2.5.29.19 */
+	OID_crlDistributionPoints,	/* 2.5.29.31 */
+	OID_certPolicies,		/* 2.5.29.32 */
+	OID_authorityKeyIdentifier,	/* 2.5.29.35 */
+	OID_extKeyUsage,		/* 2.5.29.37 */
+
+	OID__NR
+};
+
+extern enum OID look_up_OID(const void *data, size_t datasize);
+extern int sprint_oid(const void *, size_t, char *, size_t);
+extern int sprint_OID(enum OID, char *, size_t);
+
+#endif /* _LINUX_OID_REGISTRY_H */
diff --git a/libkmod/pkcs7/oid_registry.c b/libkmod/pkcs7/oid_registry.c
new file mode 100644
index 000000000000..2ac2ea21fe89
--- /dev/null
+++ b/libkmod/pkcs7/oid_registry.c
@@ -0,0 +1,168 @@
+/* ASN.1 Object identifier (OID) registry
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <assert.h>
+#include <linux/oid_registry.h>
+#include "oid_registry_data.c"
+
+#define BUG_ON(cond) assert(!(cond))
+
+/**
+ * look_up_OID - Find an OID registration for the specified data
+ * @data: Binary representation of the OID
+ * @datasize: Size of the binary representation
+ */
+enum OID look_up_OID(const void *data, size_t datasize)
+{
+	const unsigned char *octets = data;
+	enum OID oid;
+	unsigned char xhash;
+	unsigned i, j, k, hash;
+	size_t len;
+
+	/* Hash the OID data */
+	hash = datasize - 1;
+
+	for (i = 0; i < datasize; i++)
+		hash += octets[i] * 33;
+	hash = (hash >> 24) ^ (hash >> 16) ^ (hash >> 8) ^ hash;
+	hash &= 0xff;
+
+	/* Binary search the OID registry.  OIDs are stored in ascending order
+	 * of hash value then ascending order of size and then in ascending
+	 * order of reverse value.
+	 */
+	i = 0;
+	k = OID__NR;
+	while (i < k) {
+		j = (i + k) / 2;
+
+		xhash = oid_search_table[j].hash;
+		if (xhash > hash) {
+			k = j;
+			continue;
+		}
+		if (xhash < hash) {
+			i = j + 1;
+			continue;
+		}
+
+		oid = oid_search_table[j].oid;
+		len = oid_index[oid + 1] - oid_index[oid];
+		if (len > datasize) {
+			k = j;
+			continue;
+		}
+		if (len < datasize) {
+			i = j + 1;
+			continue;
+		}
+
+		/* Variation is most likely to be at the tail end of the
+		 * OID, so do the comparison in reverse.
+		 */
+		while (len > 0) {
+			unsigned char a = oid_data[oid_index[oid] + --len];
+			unsigned char b = octets[len];
+			if (a > b) {
+				k = j;
+				goto next;
+			}
+			if (a < b) {
+				i = j + 1;
+				goto next;
+			}
+		}
+		return oid;
+	next:
+		;
+	}
+
+	return OID__NR;
+}
+
+/*
+ * sprint_OID - Print an Object Identifier into a buffer
+ * @data: The encoded OID to print
+ * @datasize: The size of the encoded OID
+ * @buffer: The buffer to render into
+ * @bufsize: The size of the buffer
+ *
+ * The OID is rendered into the buffer in "a.b.c.d" format and the number of
+ * bytes is returned.  -EBADMSG is returned if the data could not be intepreted
+ * and -ENOBUFS if the buffer was too small.
+ */
+int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
+{
+	const unsigned char *v = data, *end = v + datasize;
+	unsigned long num;
+	unsigned char n;
+	size_t ret;
+	int count;
+
+	if (v >= end)
+		return -EBADMSG;
+
+	n = *v++;
+	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
+	buffer += count;
+	bufsize -= count;
+	if (bufsize == 0)
+		return -ENOBUFS;
+
+	while (v < end) {
+		num = 0;
+		n = *v++;
+		if (!(n & 0x80)) {
+			num = n;
+		} else {
+			num = n & 0x7f;
+			do {
+				if (v >= end)
+					return -EBADMSG;
+				n = *v++;
+				num <<= 7;
+				num |= n & 0x7f;
+			} while (n & 0x80);
+		}
+		ret += count = snprintf(buffer, bufsize, ".%lu", num);
+		buffer += count;
+		if (bufsize <= count)
+			return -ENOBUFS;
+		bufsize -= count;
+	}
+
+	return ret;
+}
+
+/**
+ * sprint_OID - Print an Object Identifier into a buffer
+ * @oid: The OID to print
+ * @buffer: The buffer to render into
+ * @bufsize: The size of the buffer
+ *
+ * The OID is rendered into the buffer in "a.b.c.d" format and the number of
+ * bytes is returned.
+ */
+int sprint_OID(enum OID oid, char *buffer, size_t bufsize)
+{
+	int ret;
+
+	BUG_ON(oid >= OID__NR);
+
+	ret = sprint_oid(oid_data + oid_index[oid],
+			 oid_index[oid + 1] - oid_index[oid],
+			 buffer, bufsize);
+	BUG_ON(ret == -EBADMSG);
+	return ret;
+}
diff --git a/libkmod/pkcs7/oid_registry_data.c b/libkmod/pkcs7/oid_registry_data.c
new file mode 100644
index 000000000000..6a9add08bfd5
--- /dev/null
+++ b/libkmod/pkcs7/oid_registry_data.c
@@ -0,0 +1,190 @@
+/*
+ * Automatically generated by /home/ykaliuta/sw/linux-linus/lib/build_OID_registry.  Do not edit
+ */
+
+static const unsigned short oid_index[OID__NR + 1] = {
+	[OID_id_dsa_with_sha1] = 0,
+	[OID_id_dsa] = 7,
+	[OID_id_ecdsa_with_sha1] = 14,
+	[OID_id_ecPublicKey] = 21,
+	[OID_rsaEncryption] = 28,
+	[OID_md2WithRSAEncryption] = 37,
+	[OID_md3WithRSAEncryption] = 46,
+	[OID_md4WithRSAEncryption] = 55,
+	[OID_sha1WithRSAEncryption] = 64,
+	[OID_sha256WithRSAEncryption] = 73,
+	[OID_sha384WithRSAEncryption] = 82,
+	[OID_sha512WithRSAEncryption] = 91,
+	[OID_sha224WithRSAEncryption] = 100,
+	[OID_data] = 109,
+	[OID_signed_data] = 118,
+	[OID_email_address] = 127,
+	[OID_contentType] = 136,
+	[OID_messageDigest] = 145,
+	[OID_signingTime] = 154,
+	[OID_smimeCapabilites] = 163,
+	[OID_smimeAuthenticatedAttrs] = 172,
+	[OID_md2] = 183,
+	[OID_md4] = 191,
+	[OID_md5] = 199,
+	[OID_msIndirectData] = 207,
+	[OID_msStatementType] = 217,
+	[OID_msSpOpusInfo] = 227,
+	[OID_msPeImageDataObjId] = 237,
+	[OID_msIndividualSPKeyPurpose] = 247,
+	[OID_msOutlookExpress] = 257,
+	[OID_certAuthInfoAccess] = 266,
+	[OID_sha1] = 274,
+	[OID_sha256] = 279,
+	[OID_sha384] = 288,
+	[OID_sha512] = 297,
+	[OID_sha224] = 306,
+	[OID_commonName] = 315,
+	[OID_surname] = 318,
+	[OID_countryName] = 321,
+	[OID_locality] = 324,
+	[OID_stateOrProvinceName] = 327,
+	[OID_organizationName] = 330,
+	[OID_organizationUnitName] = 333,
+	[OID_title] = 336,
+	[OID_description] = 339,
+	[OID_name] = 342,
+	[OID_givenName] = 345,
+	[OID_initials] = 348,
+	[OID_generationalQualifier] = 351,
+	[OID_subjectKeyIdentifier] = 354,
+	[OID_keyUsage] = 357,
+	[OID_subjectAltName] = 360,
+	[OID_issuerAltName] = 363,
+	[OID_basicConstraints] = 366,
+	[OID_crlDistributionPoints] = 369,
+	[OID_certPolicies] = 372,
+	[OID_authorityKeyIdentifier] = 375,
+	[OID_extKeyUsage] = 378,
+	[OID__NR] = 381
+};
+
+static const unsigned char oid_data[381] = {
+	42, 134, 72, 206, 46, 4, 3, 	// id_dsa_with_sha1
+	42, 134, 72, 206, 56, 4, 1, 	// id_dsa
+	42, 134, 72, 206, 61, 4, 1, 	// id_ecdsa_with_sha1
+	42, 134, 72, 206, 61, 2, 1, 	// id_ecPublicKey
+	42, 134, 72, 134, 247, 13, 1, 1, 1, 	// rsaEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 2, 	// md2WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 3, 	// md3WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 4, 	// md4WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 5, 	// sha1WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 11, 	// sha256WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 12, 	// sha384WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 13, 	// sha512WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 1, 14, 	// sha224WithRSAEncryption
+	42, 134, 72, 134, 247, 13, 1, 7, 1, 	// data
+	42, 134, 72, 134, 247, 13, 1, 7, 2, 	// signed_data
+	42, 134, 72, 134, 247, 13, 1, 9, 1, 	// email_address
+	42, 134, 72, 134, 247, 13, 1, 9, 3, 	// contentType
+	42, 134, 72, 134, 247, 13, 1, 9, 4, 	// messageDigest
+	42, 134, 72, 134, 247, 13, 1, 9, 5, 	// signingTime
+	42, 134, 72, 134, 247, 13, 1, 9, 15, 	// smimeCapabilites
+	42, 134, 72, 134, 247, 13, 1, 9, 16, 2, 11, 	// smimeAuthenticatedAttrs
+	42, 134, 72, 134, 247, 13, 2, 2, 	// md2
+	42, 134, 72, 134, 247, 13, 2, 4, 	// md4
+	42, 134, 72, 134, 247, 13, 2, 5, 	// md5
+	43, 6, 1, 4, 1, 130, 55, 2, 1, 4, 	// msIndirectData
+	43, 6, 1, 4, 1, 130, 55, 2, 1, 11, 	// msStatementType
+	43, 6, 1, 4, 1, 130, 55, 2, 1, 12, 	// msSpOpusInfo
+	43, 6, 1, 4, 1, 130, 55, 2, 1, 15, 	// msPeImageDataObjId
+	43, 6, 1, 4, 1, 130, 55, 2, 1, 21, 	// msIndividualSPKeyPurpose
+	43, 6, 1, 4, 1, 130, 55, 16, 4, 	// msOutlookExpress
+	43, 6, 1, 5, 5, 7, 1, 1, 	// certAuthInfoAccess
+	43, 14, 3, 2, 26, 	// sha1
+	96, 134, 72, 1, 101, 3, 4, 2, 1, 	// sha256
+	96, 134, 72, 1, 101, 3, 4, 2, 2, 	// sha384
+	96, 134, 72, 1, 101, 3, 4, 2, 3, 	// sha512
+	96, 134, 72, 1, 101, 3, 4, 2, 4, 	// sha224
+	85, 4, 3, 	// commonName
+	85, 4, 4, 	// surname
+	85, 4, 6, 	// countryName
+	85, 4, 7, 	// locality
+	85, 4, 8, 	// stateOrProvinceName
+	85, 4, 10, 	// organizationName
+	85, 4, 11, 	// organizationUnitName
+	85, 4, 12, 	// title
+	85, 4, 13, 	// description
+	85, 4, 41, 	// name
+	85, 4, 42, 	// givenName
+	85, 4, 43, 	// initials
+	85, 4, 44, 	// generationalQualifier
+	85, 29, 14, 	// subjectKeyIdentifier
+	85, 29, 15, 	// keyUsage
+	85, 29, 17, 	// subjectAltName
+	85, 29, 18, 	// issuerAltName
+	85, 29, 19, 	// basicConstraints
+	85, 29, 31, 	// crlDistributionPoints
+	85, 29, 32, 	// certPolicies
+	85, 29, 35, 	// authorityKeyIdentifier
+	85, 29, 37, 	// extKeyUsage
+};
+
+static const struct {
+	unsigned char hash;
+	enum OID oid : 8;
+} oid_search_table[OID__NR] = {
+	[  0] = {  10, OID_title                               }, // 55040c
+	[  1] = {  23, OID_issuerAltName                       }, // 551d12
+	[  2] = {  23, OID_initials                            }, // 55042b
+	[  3] = {  29, OID_md2WithRSAEncryption                }, // 2a864886f70d010102
+	[  4] = {  30, OID_md2                                 }, // 2a864886f70d0202
+	[  5] = {  32, OID_id_dsa_with_sha1                    }, // 2a8648ce2e0403
+	[  6] = {  35, OID_contentType                         }, // 2a864886f70d010903
+	[  7] = {  35, OID_sha256WithRSAEncryption             }, // 2a864886f70d01010b
+	[  8] = {  36, OID_authorityKeyIdentifier              }, // 551d23
+	[  9] = {  37, OID_description                         }, // 55040d
+	[ 10] = {  43, OID_id_dsa                              }, // 2a8648ce380401
+	[ 11] = {  51, OID_msIndividualSPKeyPurpose            }, // 2b060104018237020115
+	[ 12] = {  54, OID_basicConstraints                    }, // 551d13
+	[ 13] = {  54, OID_generationalQualifier               }, // 55042c
+	[ 14] = {  60, OID_md3WithRSAEncryption                }, // 2a864886f70d010103
+	[ 15] = {  64, OID_signed_data                         }, // 2a864886f70d010702
+	[ 16] = {  77, OID_countryName                         }, // 550406
+	[ 17] = {  77, OID_id_ecdsa_with_sha1                  }, // 2a8648ce3d0401
+	[ 18] = {  83, OID_sha256                              }, // 608648016503040201
+	[ 19] = {  85, OID_smimeCapabilites                    }, // 2a864886f70d01090f
+	[ 20] = {  87, OID_sha1                                }, // 2b0e03021a
+	[ 21] = {  97, OID_email_address                       }, // 2a864886f70d010901
+	[ 22] = { 106, OID_extKeyUsage                         }, // 551d25
+	[ 23] = { 106, OID_msPeImageDataObjId                  }, // 2b06010401823702010f
+	[ 24] = { 110, OID_locality                            }, // 550407
+	[ 25] = { 126, OID_rsaEncryption                       }, // 2a864886f70d010101
+	[ 26] = { 132, OID_smimeAuthenticatedAttrs             }, // 2a864886f70d010910020b
+	[ 27] = { 142, OID_id_ecPublicKey                      }, // 2a8648ce3d0201
+	[ 28] = { 142, OID_sha224WithRSAEncryption             }, // 2a864886f70d01010e
+	[ 29] = { 143, OID_stateOrProvinceName                 }, // 550408
+	[ 30] = { 146, OID_subjectKeyIdentifier                }, // 551d0e
+	[ 31] = { 157, OID_sha512                              }, // 608648016503040203
+	[ 32] = { 160, OID_data                                }, // 2a864886f70d010701
+	[ 33] = { 161, OID_crlDistributionPoints               }, // 551d1f
+	[ 34] = { 173, OID_msOutlookExpress                    }, // 2b0601040182371004
+	[ 35] = { 178, OID_sha384                              }, // 608648016503040202
+	[ 36] = { 179, OID_keyUsage                            }, // 551d0f
+	[ 37] = { 195, OID_md4WithRSAEncryption                }, // 2a864886f70d010104
+	[ 38] = { 198, OID_certPolicies                        }, // 551d20
+	[ 39] = { 200, OID_msSpOpusInfo                        }, // 2b06010401823702010c
+	[ 40] = { 201, OID_organizationName                    }, // 55040a
+	[ 41] = { 204, OID_messageDigest                       }, // 2a864886f70d010904
+	[ 42] = { 204, OID_sha384WithRSAEncryption             }, // 2a864886f70d01010c
+	[ 43] = { 212, OID_name                                }, // 550429
+	[ 44] = { 213, OID_commonName                          }, // 550403
+	[ 45] = { 220, OID_md4                                 }, // 2a864886f70d0204
+	[ 46] = { 226, OID_sha1WithRSAEncryption               }, // 2a864886f70d010105
+	[ 47] = { 227, OID_md5                                 }, // 2a864886f70d0205
+	[ 48] = { 228, OID_certAuthInfoAccess                  }, // 2b06010505070101
+	[ 49] = { 231, OID_msStatementType                     }, // 2b06010401823702010b
+	[ 50] = { 234, OID_organizationUnitName                }, // 55040b
+	[ 51] = { 237, OID_signingTime                         }, // 2a864886f70d010905
+	[ 52] = { 237, OID_sha512WithRSAEncryption             }, // 2a864886f70d01010d
+	[ 53] = { 244, OID_surname                             }, // 550404
+	[ 54] = { 245, OID_subjectAltName                      }, // 551d11
+	[ 55] = { 245, OID_givenName                           }, // 55042a
+	[ 56] = { 252, OID_sha224                              }, // 608648016503040204
+	[ 57] = { 255, OID_msIndirectData                      }, // 2b060104018237020104
+};
diff --git a/libkmod/pkcs7/pkcs7.asn1 b/libkmod/pkcs7/pkcs7.asn1
new file mode 100644
index 000000000000..a5e02a9e74c3
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7.asn1
@@ -0,0 +1,135 @@
+PKCS7ContentInfo ::= SEQUENCE {
+	contentType	ContentType ({ pkcs7_check_content_type }),
+	content		[0] EXPLICIT SignedData OPTIONAL
+}
+
+ContentType ::= OBJECT IDENTIFIER ({ pkcs7_note_OID })
+
+SignedData ::= SEQUENCE {
+	version			INTEGER ({ pkcs7_note_signeddata_version }),
+	digestAlgorithms	DigestAlgorithmIdentifiers,
+	contentInfo		ContentInfo ({ pkcs7_note_content }),
+	certificates		CHOICE {
+		certSet		[0] IMPLICIT ExtendedCertificatesAndCertificates,
+		certSequence	[2] IMPLICIT Certificates
+	} OPTIONAL ({ pkcs7_note_certificate_list }),
+	crls CHOICE {
+		crlSet		[1] IMPLICIT CertificateRevocationLists,
+		crlSequence	[3] IMPLICIT CRLSequence
+	} OPTIONAL,
+	signerInfos		SignerInfos
+}
+
+ContentInfo ::= SEQUENCE {
+	contentType	ContentType ({ pkcs7_note_OID }),
+	content		[0] EXPLICIT Data OPTIONAL
+}
+
+Data ::= ANY ({ pkcs7_note_data })
+
+DigestAlgorithmIdentifiers ::= CHOICE {
+	daSet			SET OF DigestAlgorithmIdentifier,
+	daSequence		SEQUENCE OF DigestAlgorithmIdentifier
+}
+
+DigestAlgorithmIdentifier ::= SEQUENCE {
+	algorithm   OBJECT IDENTIFIER ({ pkcs7_note_OID }),
+	parameters  ANY OPTIONAL
+}
+
+--
+-- Certificates and certificate lists
+--
+ExtendedCertificatesAndCertificates ::= SET OF ExtendedCertificateOrCertificate
+
+ExtendedCertificateOrCertificate ::= CHOICE {
+  certificate		Certificate,				-- X.509
+  extendedCertificate	[0] IMPLICIT ExtendedCertificate	-- PKCS#6
+}
+
+ExtendedCertificate ::= Certificate -- cheating
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
+	version			INTEGER ({ pkcs7_note_signerinfo_version }),
+	sid			SignerIdentifier, -- CMS variant, not PKCS#7
+	digestAlgorithm		DigestAlgorithmIdentifier ({ pkcs7_sig_note_digest_algo }),
+	authenticatedAttributes	CHOICE {
+		aaSet		[0] IMPLICIT SetOfAuthenticatedAttribute
+					({ pkcs7_sig_note_set_of_authattrs }),
+		aaSequence	[2] EXPLICIT SEQUENCE OF AuthenticatedAttribute
+			-- Explicit because easier to compute digest on
+			-- sequence of attributes and then reuse encoded
+			-- sequence in aaSequence.
+	} OPTIONAL,
+	digestEncryptionAlgorithm
+				DigestEncryptionAlgorithmIdentifier ({ pkcs7_sig_note_pkey_algo }),
+	encryptedDigest		EncryptedDigest,
+	unauthenticatedAttributes CHOICE {
+		uaSet		[1] IMPLICIT SET OF UnauthenticatedAttribute,
+		uaSequence	[3] IMPLICIT SEQUENCE OF UnauthenticatedAttribute
+	} OPTIONAL
+} ({ pkcs7_note_signed_info })
+
+SignerIdentifier ::= CHOICE {
+	-- RFC5652 sec 5.3
+	issuerAndSerialNumber IssuerAndSerialNumber,
+        subjectKeyIdentifier [0] IMPLICIT SubjectKeyIdentifier
+}
+
+IssuerAndSerialNumber ::= SEQUENCE {
+	issuer			Name ({ pkcs7_sig_note_issuer }),
+	serialNumber		CertificateSerialNumber ({ pkcs7_sig_note_serial })
+}
+
+CertificateSerialNumber ::= INTEGER
+
+SubjectKeyIdentifier ::= OCTET STRING ({ pkcs7_sig_note_skid })
+
+SetOfAuthenticatedAttribute ::= SET OF AuthenticatedAttribute
+
+AuthenticatedAttribute ::= SEQUENCE {
+	type			OBJECT IDENTIFIER ({ pkcs7_note_OID }),
+	values			SET OF ANY ({ pkcs7_sig_note_authenticated_attr })
+}
+
+UnauthenticatedAttribute ::= SEQUENCE {
+	type			OBJECT IDENTIFIER,
+	values			SET OF ANY
+}
+
+DigestEncryptionAlgorithmIdentifier ::= SEQUENCE {
+	algorithm		OBJECT IDENTIFIER ({ pkcs7_note_OID }),
+	parameters		ANY OPTIONAL
+}
+
+EncryptedDigest ::= OCTET STRING ({ pkcs7_sig_note_signature })
+
+---
+--- X.500 Name
+---
+Name ::= SEQUENCE OF RelativeDistinguishedName
+
+RelativeDistinguishedName ::= SET OF AttributeValueAssertion
+
+AttributeValueAssertion ::= SEQUENCE {
+	attributeType		OBJECT IDENTIFIER ({ pkcs7_note_OID }),
+	attributeValue		ANY ({ pkcs7_extract_name_segment })
+}
diff --git a/libkmod/pkcs7/pkcs7_parser.c b/libkmod/pkcs7/pkcs7_parser.c
new file mode 100644
index 000000000000..1c1cf29214f9
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7_parser.c
@@ -0,0 +1,382 @@
+/* PKCS#7 parser
+ *
+ * Copyright (C) 2018 Red Hat, Inc., Yauheni Kaliuta
+ *
+ * This is a very modified version of the linux kernel's
+ * crypto/asymmetric_keys/pkcs7_parser.c, which is:
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include "pkcs7_parser.h"
+#include "include/linux/oid_registry.h"
+#include "pkcs7-asn1.h"
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+struct pkcs7_parse_context {
+	struct pkcs7_cert *cert;
+
+	enum OID last_oid;
+
+	bool signer_info_done;
+
+	const uint8_t *raw_issuer;
+	size_t raw_issuer_size;
+	const uint8_t *raw_serial;
+	size_t raw_serial_size;
+
+	const uint8_t *raw_skid;
+	size_t raw_skid_size;
+};
+
+/*
+ * We only support signed data [RFC2315 sec 9].
+ */
+int pkcs7_check_content_type(void *context, size_t hdrlen,
+			     unsigned char tag,
+			     const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->last_oid != OID_signed_data)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Note an OID when we find one for later processing when we know how
+ * to interpret it.
+ */
+int pkcs7_note_OID(void *context, size_t hdrlen,
+		   unsigned char tag,
+		   const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	ctx->last_oid = look_up_OID(value, vlen);
+	return 0;
+}
+
+/*
+ * Note the SignedData version
+ */
+int pkcs7_note_signeddata_version(void *context, size_t hdrlen,
+				  unsigned char tag,
+				  const void *value, size_t vlen)
+{
+	return 0;
+}
+
+/*
+ * Note the content type.
+ */
+int pkcs7_note_content(void *context, size_t hdrlen,
+		       unsigned char tag,
+		       const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->last_oid != OID_data &&
+	    ctx->last_oid != OID_msIndirectData) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int pkcs7_note_certificate_list(void *context, size_t hdrlen,
+				unsigned char tag,
+				const void *value, size_t vlen)
+{
+	return 0;
+}
+
+int pkcs7_note_data(void *context, size_t hdrlen,
+		    unsigned char tag,
+		    const void *value, size_t vlen)
+{
+	return 0;
+}
+
+static int pkcs7_gen_keyid(const uint8_t *val_1, size_t len_1,
+			   const uint8_t *val_2, size_t len_2,
+			   uint8_t **buf, size_t *size)
+
+{
+	size_t s;
+	uint8_t *p;
+
+	/*
+	 * see asymmetric_key_generate_id(),
+	 * crypto/asymmetric_keys/assymmetric_type.c in the linux kernel
+	 */
+
+	s = len_1 + len_2;
+
+	p = malloc(s);
+	if (p == NULL)
+		return -1;
+
+	memcpy(p, val_1, len_1);
+	memcpy(p + len_1, val_2, len_2);
+
+	*buf = p;
+	*size = s;
+
+	return 0;
+}
+
+/*
+ * Note a signature information block
+ */
+int pkcs7_note_signed_info(void *context, size_t hdrlen,
+			   unsigned char tag,
+			   const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+	struct pkcs7_cert *cert = ctx->cert;
+	int rc = -1;
+
+	ctx->signer_info_done = true;
+
+	if (ctx->raw_skid) {
+		rc = pkcs7_gen_keyid(ctx->raw_skid, ctx->raw_skid_size,
+				     (const unsigned char *)"", 0,
+				     &cert->key_id, &cert->key_id_size);
+	}
+
+	if (ctx->raw_issuer == NULL || ctx->raw_serial == NULL)
+		goto out;
+
+	rc = pkcs7_gen_keyid(ctx->raw_serial, ctx->raw_serial_size,
+			     ctx->raw_issuer, ctx->raw_issuer_size,
+			     &cert->key_id, &cert->key_id_size);
+out:
+	return rc;
+}
+
+/*
+ * Note the SignerInfo version
+ */
+int pkcs7_note_signerinfo_version(void *context, size_t hdrlen,
+				  unsigned char tag,
+				  const void *value, size_t vlen)
+{
+	/* do not care */
+	return 0;
+}
+
+/*
+ * Note the digest algorithm for the signature.
+ */
+int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
+			       unsigned char tag,
+			       const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	switch (ctx->last_oid) {
+	case OID_md4:
+		ctx->cert->hash_algo = "md4";
+		break;
+	case OID_md5:
+		ctx->cert->hash_algo = "md5";
+		break;
+	case OID_sha1:
+		ctx->cert->hash_algo = "sha1";
+		break;
+	case OID_sha256:
+		ctx->cert->hash_algo = "sha256";
+		break;
+	case OID_sha384:
+		ctx->cert->hash_algo = "sha384";
+		break;
+	case OID_sha512:
+		ctx->cert->hash_algo = "sha512";
+		break;
+	case OID_sha224:
+		ctx->cert->hash_algo = "sha224";
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+int pkcs7_sig_note_set_of_authattrs(void *context, size_t hdrlen,
+				    unsigned char tag,
+				    const void *value, size_t vlen)
+{
+	return 0;
+}
+
+/*
+ * Note the public key algorithm for the signature.
+ */
+int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
+			     unsigned char tag,
+			     const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	if (ctx->last_oid != OID_rsaEncryption)
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Note the issuer's name
+ */
+int pkcs7_sig_note_issuer(void *context, size_t hdrlen,
+			  unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	ctx->raw_issuer = value;
+	ctx->raw_issuer_size = vlen;
+	return 0;
+}
+
+/*
+ * Note the issuing certificate serial number
+ */
+int pkcs7_sig_note_serial(void *context, size_t hdrlen,
+			  unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	ctx->raw_serial = value;
+	ctx->raw_serial_size = vlen;
+	return 0;
+}
+
+/*
+ * Note the issuing cert's subjectKeyIdentifier
+ */
+int pkcs7_sig_note_skid(void *context, size_t hdrlen,
+			unsigned char tag,
+			const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	ctx->raw_skid = value;
+	ctx->raw_skid_size = vlen;
+	return 0;
+}
+
+int pkcs7_sig_note_authenticated_attr(void *context, size_t hdrlen,
+				      unsigned char tag,
+				      const void *value, size_t vlen)
+{
+	return 0;
+}
+
+/*
+ * Note the signature data
+ */
+int pkcs7_sig_note_signature(void *context, size_t hdrlen,
+			     unsigned char tag,
+			     const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+	struct pkcs7_cert *cert = ctx->cert;
+	uint8_t *p;
+
+	if (ctx->signer_info_done)
+		return 0;
+
+	p = malloc(vlen);
+	if (p == NULL)
+		return -1;
+
+	memcpy(p, value, vlen);
+
+	cert->signature = p;
+	cert->signature_size = vlen;
+
+	return 0;
+}
+
+/*
+ * Note some of the name segments from which we'll fabricate a name.
+ */
+int pkcs7_extract_name_segment(void *context, size_t hdrlen,
+			       unsigned char tag,
+			       const void *value, size_t vlen)
+{
+	struct pkcs7_parse_context *ctx = context;
+	char *p = NULL;
+
+	if (ctx->last_oid != OID_commonName)
+		return 0;
+
+	p = malloc(vlen + 1);
+	if (p == NULL)
+		return -1;
+
+	snprintf(p, vlen + 1, "%s", (const char *)value);
+
+	ctx->cert->signer = p;
+
+	return 0;
+}
+
+void pkcs7_free_cert(struct pkcs7_cert *cert)
+{
+	free(cert->key_id);
+	free(cert->signer);
+	free(cert->signature);
+	free(cert);
+}
+
+struct pkcs7_cert *pkcs7_parse_cert(const uint8_t *raw, size_t len)
+{
+	struct pkcs7_cert *cert;
+	struct pkcs7_parse_context ctx = {};
+
+	cert = malloc(sizeof(*cert));
+	if (cert == NULL)
+		return NULL;
+	memset(cert, 0, sizeof(*cert));
+
+	ctx.cert = cert;
+
+	/* Attempt to decode the signature */
+	if (asn1_ber_decoder(&pkcs7_decoder, &ctx, raw, len) < 0)
+		goto err;
+
+	return cert;
+err:
+	pkcs7_free_cert(cert);
+	return NULL;
+}
diff --git a/libkmod/pkcs7/pkcs7_parser.h b/libkmod/pkcs7/pkcs7_parser.h
new file mode 100644
index 000000000000..5da4abe5a3e9
--- /dev/null
+++ b/libkmod/pkcs7/pkcs7_parser.h
@@ -0,0 +1,19 @@
+#ifndef KMOD_PKCS7_PARSER_H_
+#define KMOD_PKCS7_PARSER_H_
+
+#include <stdint.h>
+#include <stdlib.h>
+
+struct pkcs7_cert {
+	const char *hash_algo;
+	uint8_t *key_id;
+	size_t key_id_size;
+	char *signer; /* copy cn there, name like in module_signature */
+	uint8_t *signature;
+	size_t signature_size;
+};
+
+struct pkcs7_cert *pkcs7_parse_cert(const uint8_t *raw, size_t len);
+void pkcs7_free_cert(struct pkcs7_cert *cert);
+
+#endif
-- 
2.16.2
