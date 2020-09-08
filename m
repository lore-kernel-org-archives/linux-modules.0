Return-Path: <SRS0=CO/U=CR=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C568C433E2
	for <linux-modules@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52FE20658
	for <linux-modules@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a8io2ZRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgIHT7o (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbgIHT7d (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Sep 2020 15:59:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B45C061573
        for <linux-modules@vger.kernel.org>; Tue,  8 Sep 2020 12:59:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so487825wrs.5
        for <linux-modules@vger.kernel.org>; Tue, 08 Sep 2020 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Rd25DzKIeYqQZroewZ+35tsB0jYsoz8VBTZYuDw5Fc=;
        b=a8io2ZRHhr5/PIbfdW0O26TP2ndQKEG5biMIpF/OgLLMHFDJ6mqHCziqrmdUfkdCje
         GAqdPioyH0d8Swkv244YG0hXczckTo23U9kL4LsuNNqEAkMZd0m5up3JmFdrxKJh+CuT
         73Kbm98M+YMrEVTc5B9Nk4Bk1zb/agrPbDe2i5BQHKoYbrXY7CWrOEs3Y2sRyXLrDyO7
         tBjYN51uKEGnmX0oE0Cc7vPZoVQe04Au1lLp7CRezpdnByNX0joRK9QtiaQnaftUEVJN
         nm9kRJ77Mk8uCU9AR/TyNKp4r/lA1a3XzbtFB1umiMh8sr+Z4iSidnuBjdYskYCVEQcy
         LwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Rd25DzKIeYqQZroewZ+35tsB0jYsoz8VBTZYuDw5Fc=;
        b=FQ6GWRHJyhDf3e47ysiZeqNDqFYJn3/t2xkEIcV3AE2kLEKGM9papUUvxi3n79TrWJ
         6ZvUCAmhhGOwwXp9xXRO/DotUqnkxYfOQ6gJ6QItZM1TRMpTbm7ZBrK/78xP0GzngqgA
         okoXF2y0JqZzaW6z3aAIlEhyS+rl6hTR3cJnUeQ4p8kBt+i9B9bUl/GRMg/LmF6RH4xu
         kPEG0IfBKoXw3p7gln5Bq1LevhcRTt8yuK5VXMT8UAowuMgT9rTTXV11f6nR1DUks1zk
         5poswhBe/PHByg9doY0irjFJj0H7VqnYXzQtKCuTDikvuWwyJss8RfvukyDup8Ee3DlE
         3TrQ==
X-Gm-Message-State: AOAM53155xua0+zyAtBUnmUghD7V/bVgCBLetaghmztcav+NLHjomYCl
        Gwe74aEd0FgLGlLx3ZKViv/EmY4xT6U=
X-Google-Smtp-Source: ABdhPJzN3phnskftYUi976LQj0aHFPkRPDGziW7WOEOAC9goTUClAenM8qrAobQKWrFeRA7Ciz+DSw==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr164754wrx.350.1599595171128;
        Tue, 08 Sep 2020 12:59:31 -0700 (PDT)
Received: from localhost.localdomain (ip1f11fff1.dynamic.kabel-deutschland.de. [31.17.255.241])
        by smtp.gmail.com with ESMTPSA id m3sm680855wme.31.2020.09.08.12.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:59:30 -0700 (PDT)
From:   Torge Matthies <openglfreak@googlemail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Torge Matthies <openglfreak@googlemail.com>
Subject: [PATCH v2 1/2] add Zstandard compression support
Date:   Tue,  8 Sep 2020 21:59:20 +0200
Message-Id: <20200908195921.869779-1-openglfreak@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I changed the style of the hackargs variable in autogen.sh to multiline
because said line was becoming a bit long with the new --with-zstd arg
added.

A previous version of this patch has been running on my two Arch Linux
installations (with an accompanying mkinitcpio patch) for several months
over many kernel updates without any issues.
Any additional testing and/or patch review would of course be appreciated.

Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
---
v1 -> v2:
* Made it so that the next input block size is determined from the return
  value of ZSTD_decompressStream.
  Previously a block size of just a few bytes was used for the entire file.
* Split out parts of load_zstd into their own functions.

 .semaphore/semaphore.yml     |   4 +-
 .travis.yml                  |   1 +
 Makefile.am                  |   4 +-
 autogen.sh                   |   9 ++-
 configure.ac                 |  13 +++-
 libkmod/libkmod-file.c       | 144 +++++++++++++++++++++++++++++++++++
 libkmod/libkmod.pc.in        |   2 +-
 shared/util.c                |   3 +
 testsuite/mkosi/mkosi.fedora |   1 +
 testsuite/test-util.c        |   3 +
 10 files changed, 178 insertions(+), 6 deletions(-)

diff --git a/.semaphore/semaphore.yml b/.semaphore/semaphore.yml
index db47ca1..fe1d78a 100644
--- a/.semaphore/semaphore.yml
+++ b/.semaphore/semaphore.yml
@@ -22,7 +22,7 @@ blocks:
       prologue:
         commands:
           - sudo apt update
-          - sudo apt --yes install docbook-xsl liblzma-dev zlib1g-dev cython linux-headers-generic libssl-dev
+          - sudo apt --yes install docbook-xsl libzstd-dev liblzma-dev zlib1g-dev cython linux-headers-generic libssl-dev
           - checkout
 
       epilogue:
@@ -42,5 +42,5 @@ blocks:
       prologue:
         commands:
           - sudo apt update
-          - sudo apt --yes install docbook-xsl liblzma-dev zlib1g-dev cython linux-headers-generic libssl-dev
+          - sudo apt --yes install docbook-xsl libzstd-dev liblzma-dev zlib1g-dev cython linux-headers-generic libssl-dev
           - checkout
diff --git a/.travis.yml b/.travis.yml
index 02c753e..0fcce14 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -14,6 +14,7 @@ matrix:
 before_install:
   - sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
   - sudo apt-get update -qq
+  - sudo apt-get install -qq libzstd-dev
   - sudo apt-get install -qq liblzma-dev
   - sudo apt-get install -qq zlib1g-dev
   - sudo apt-get install -qq xsltproc docbook-xsl
diff --git a/Makefile.am b/Makefile.am
index 8eadb99..37d840b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -31,6 +31,8 @@ SED_PROCESS = \
 	-e 's,@exec_prefix\@,$(exec_prefix),g' \
 	-e 's,@libdir\@,$(libdir),g' \
 	-e 's,@includedir\@,$(includedir),g' \
+	-e 's,@libzstd_CFLAGS\@,${libzstd_CFLAGS},g' \
+	-e 's,@libzstd_LIBS\@,${libzstd_LIBS},g' \
 	-e 's,@liblzma_CFLAGS\@,${liblzma_CFLAGS},g' \
 	-e 's,@liblzma_LIBS\@,${liblzma_LIBS},g' \
 	-e 's,@zlib_CFLAGS\@,${zlib_CFLAGS},g' \
@@ -90,7 +92,7 @@ libkmod_libkmod_la_DEPENDENCIES = \
 	${top_srcdir}/libkmod/libkmod.sym
 libkmod_libkmod_la_LIBADD = \
 	shared/libshared.la \
-	${liblzma_LIBS} ${zlib_LIBS} ${libcrypto_LIBS}
+	${libzstd_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libcrypto_LIBS}
 
 noinst_LTLIBRARIES += libkmod/libkmod-internal.la
 libkmod_libkmod_internal_la_SOURCES = $(libkmod_libkmod_la_SOURCES)
diff --git a/autogen.sh b/autogen.sh
index 67b119f..e4997c4 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -32,7 +32,14 @@ fi
 
 cd $oldpwd
 
-hackargs="--enable-debug --enable-python --with-xz --with-zlib --with-openssl"
+hackargs="\
+--enable-debug \
+--enable-python \
+--with-zstd \
+--with-xz \
+--with-zlib \
+--with-openssl \
+"
 
 if [ "x$1" = "xc" ]; then
         shift
diff --git a/configure.ac b/configure.ac
index 4a65d6b..a49f6b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,6 +83,17 @@ AC_ARG_WITH([rootlibdir],
         [], [with_rootlibdir=$libdir])
 AC_SUBST([rootlibdir], [$with_rootlibdir])
 
+AC_ARG_WITH([zstd],
+	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
+	[], [with_zstd=no])
+AS_IF([test "x$with_zstd" != "xno"], [
+	PKG_CHECK_MODULES([libzstd], [libzstd >= 1.4.4])
+	AC_DEFINE([ENABLE_ZSTD], [1], [Enable Zstandard for modules.])
+], [
+	AC_MSG_NOTICE([Zstandard support not requested])
+])
+CC_FEATURE_APPEND([with_features], [with_zstd], [ZSTD])
+
 AC_ARG_WITH([xz],
 	AS_HELP_STRING([--with-xz], [handle Xz-compressed modules @<:@default=disabled@:>@]),
 	[], [with_xz=no])
@@ -307,7 +318,7 @@ AC_MSG_RESULT([
 	tools:			${enable_tools}
 	python bindings:	${enable_python}
 	logging:		${enable_logging}
-	compression:		xz=${with_xz}  zlib=${with_zlib}
+	compression:		zstd=${with_zstd}  xz=${with_xz}  zlib=${with_zlib}
 	debug:			${enable_debug}
 	coverage:		${enable_coverage}
 	doc:			${enable_gtk_doc}
diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 5eeba6a..b6a8cc9 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -26,6 +26,9 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#ifdef ENABLE_ZSTD
+#include <zstd.h>
+#endif
 #ifdef ENABLE_XZ
 #include <lzma.h>
 #endif
@@ -45,6 +48,9 @@ struct file_ops {
 };
 
 struct kmod_file {
+#ifdef ENABLE_ZSTD
+	bool zstd_used;
+#endif
 #ifdef ENABLE_XZ
 	bool xz_used;
 #endif
@@ -60,6 +66,141 @@ struct kmod_file {
 	struct kmod_elf *elf;
 };
 
+#ifdef ENABLE_ZSTD
+static int zstd_read_block(struct kmod_file *file, size_t block_size,
+			   ZSTD_inBuffer *input, size_t *input_capacity)
+{
+	ssize_t rdret;
+	int ret;
+
+	if (*input_capacity < block_size) {
+		free((void *)input->src);
+		input->src = malloc(block_size);
+		if (input->src == NULL) {
+			ret = -errno;
+			ERR(file->ctx, "zstd: %m\n");
+			return ret;
+		}
+		*input_capacity = block_size;
+	}
+
+	rdret = read(file->fd, (void *)input->src, block_size);
+	if (rdret < 0) {
+		ret = -errno;
+		ERR(file->ctx, "zstd: %m\n");
+		return ret;
+	}
+
+	input->pos = 0;
+	input->size = rdret;
+	return 0;
+}
+
+static int zstd_ensure_outbuffer_space(ZSTD_outBuffer *buffer, size_t min_free)
+{
+	uint8_t *old_buffer = buffer->dst;
+	int ret = 0;
+
+	if (buffer->size - buffer->pos >= min_free)
+		return 0;
+
+	buffer->size += min_free;
+	buffer->dst = realloc(buffer->dst, buffer->size);
+	if (buffer->dst == NULL) {
+		ret = -errno;
+		free(old_buffer);
+	}
+
+	return ret;
+}
+
+static int zstd_decompress_block(struct kmod_file *file, ZSTD_DStream *dstr,
+				 ZSTD_inBuffer *input, ZSTD_outBuffer *output,
+				 size_t *next_block_size)
+{
+	size_t out_buf_min_size = ZSTD_DStreamOutSize();
+	int ret = 0;
+
+	do {
+		ssize_t dsret;
+
+		ret = zstd_ensure_outbuffer_space(output, out_buf_min_size);
+		if (ret) {
+			ERR(file->ctx, "zstd: %s\n", strerror(-ret));
+			break;
+		}
+
+		dsret = ZSTD_decompressStream(dstr, output, input);
+		if (ZSTD_isError(dsret)) {
+			ret = -EINVAL;
+			ERR(file->ctx, "zstd: %s\n", ZSTD_getErrorName(dsret));
+			break;
+		}
+		if (dsret > 0)
+			*next_block_size = (size_t)dsret;
+	} while (input->pos < input->size
+		 || output->pos > output->size
+		 || output->size - output->pos < out_buf_min_size);
+
+	return ret;
+}
+
+static int load_zstd(struct kmod_file *file)
+{
+	ZSTD_DStream *dstr;
+	size_t next_block_size;
+	size_t zst_inb_capacity = 0;
+	ZSTD_inBuffer zst_inb = { 0 };
+	ZSTD_outBuffer zst_outb = { 0 };
+	int ret;
+
+	dstr = ZSTD_createDStream();
+	if (dstr == NULL) {
+		ret = -EINVAL;
+		ERR(file->ctx, "zstd: Failed to create decompression stream\n");
+		goto out;
+	}
+
+	next_block_size = ZSTD_initDStream(dstr);
+
+	while (true) {
+		ret = zstd_read_block(file, next_block_size, &zst_inb,
+				      &zst_inb_capacity);
+		if (ret != 0)
+			goto out;
+		if (zst_inb.size == 0) /* EOF */
+			break;
+
+		ret = zstd_decompress_block(file, dstr, &zst_inb, &zst_outb,
+					    &next_block_size);
+		if (ret != 0)
+			goto out;
+	}
+
+	ZSTD_freeDStream(dstr);
+	free((void *)zst_inb.src);
+	file->zstd_used = true;
+	file->memory = zst_outb.dst;
+	file->size = zst_outb.pos;
+	return 0;
+out:
+	if (dstr != NULL)
+		ZSTD_freeDStream(dstr);
+	free((void *)zst_inb.src);
+	free((void *)zst_outb.dst);
+	return ret;
+}
+
+static void unload_zstd(struct kmod_file *file)
+{
+	if (!file->zstd_used)
+		return;
+	free(file->memory);
+}
+
+static const char magic_zstd[] = {0x28, 0xB5, 0x2F, 0xFD};
+#endif
+
 #ifdef ENABLE_XZ
 static void xz_uncompress_belch(struct kmod_file *file, lzma_ret ret)
 {
@@ -238,6 +379,9 @@ static const struct comp_type {
 	const char *magic_bytes;
 	const struct file_ops ops;
 } comp_types[] = {
+#ifdef ENABLE_ZSTD
+	{sizeof(magic_zstd), magic_zstd, {load_zstd, unload_zstd}},
+#endif
 #ifdef ENABLE_XZ
 	{sizeof(magic_xz), magic_xz, {load_xz, unload_xz}},
 #endif
diff --git a/libkmod/libkmod.pc.in b/libkmod/libkmod.pc.in
index e4fdf21..3acca6a 100644
--- a/libkmod/libkmod.pc.in
+++ b/libkmod/libkmod.pc.in
@@ -7,5 +7,5 @@ Name: libkmod
 Description: Library to deal with kernel modules
 Version: @VERSION@
 Libs: -L${libdir} -lkmod
-Libs.private: @liblzma_LIBS@ @zlib_LIBS@
+Libs.private: @libzstd_LIBS@ @liblzma_LIBS@ @zlib_LIBS@
 Cflags: -I${includedir}
diff --git a/shared/util.c b/shared/util.c
index fd2028d..b487b5f 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -45,6 +45,9 @@ static const struct kmod_ext {
 #endif
 #ifdef ENABLE_XZ
 	{".ko.xz", sizeof(".ko.xz") - 1},
+#endif
+#ifdef ENABLE_ZSTD
+	{".ko.zst", sizeof(".ko.zst") - 1},
 #endif
 	{ }
 };
diff --git a/testsuite/mkosi/mkosi.fedora b/testsuite/mkosi/mkosi.fedora
index 5252f87..7a2ee5e 100644
--- a/testsuite/mkosi/mkosi.fedora
+++ b/testsuite/mkosi/mkosi.fedora
@@ -19,6 +19,7 @@ BuildPackages =
 	make
 	pkgconf-pkg-config
 	xml-common
+	libzstd-devel
 	xz-devel
 	zlib-devel
 	openssl-devel
diff --git a/testsuite/test-util.c b/testsuite/test-util.c
index 5e25e58..621446b 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -156,6 +156,9 @@ static int test_path_ends_with_kmod_ext(const struct test *t)
 #endif
 #ifdef ENABLE_XZ
 		{ "/bla.ko.xz", true },
+#endif
+#ifdef ENABLE_ZSTD
+		{ "/bla.ko.zst", true },
 #endif
 		{ "/bla.ko.x", false },
 		{ "/bla.ko.", false },
-- 
2.28.0

