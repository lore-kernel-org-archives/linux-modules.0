Return-Path: <SRS0=tNH6=B7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C3C433E1
	for <linux-modules@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5975207C3
	for <linux-modules@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZVvBsV0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUWpv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHUWpu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 21 Aug 2020 18:45:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E0C061573
        for <linux-modules@vger.kernel.org>; Fri, 21 Aug 2020 15:45:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so4332309ejb.11
        for <linux-modules@vger.kernel.org>; Fri, 21 Aug 2020 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghl0gsXQzbKLmGGtg4rE1qBO+G1EWfWwbH1/AY8MEjM=;
        b=ZVvBsV0U6ss1lIpsOBxoW9bRoQk7IKYl+y3UIXvGvceNTdATI2XQ46L+w5EVVCGZFK
         OGuQpvu9y1OHitCnRgExnG5Z/q5e/svurnhrPqW7DWvMTwisz3xJjf0l8Fxq/iZB/+p6
         cc7f8W8lE31nk3af51K9Rc78etPm5jNZYegtGX5JnXFwksJrBU8ZHOGzZnNFYxcxB9Kb
         7hs2mst3+colpZDePdF0KMY2S8247h8BeVpCLWA+/vQnpOZjPHkkQbuRP3UEBbvtfSVO
         jQyrxJatj2TaYHVkPvPPIXV9vph1y0fSdC1lt8SOKRwsiyP9uRn1nrLogrtfDdslkNTK
         sS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghl0gsXQzbKLmGGtg4rE1qBO+G1EWfWwbH1/AY8MEjM=;
        b=GkpmAyq9hKamzC5EJzV9vxH6yHwSW70fdHsUj4UMrIoIj4XUMrmuloyoqpYylyn09X
         Jl+PR48rKjJgEDDFbUOOYIX+QYMA6Y9sqfGn2J4+rbkodMIogGDpCo8cj9aIgZpbcg0S
         lKhpwK6tgejhWmQxy5PV/JHTIAMSXeaP1kqbtAxbOw5mmN88SAtE+wHQvyiV8uEI5Qxw
         UOw2QYlxL71nwMJ+29mp8n2g9ZAeAbfQdkn3WNIooWRgG0BZl8MGnEZNVzhVCn4x1735
         B5A3bPYrcC/QIEDZ/ESIJf/Zeg6IijvclCGl0N7qdsPa/mXfJQrAllsyivH1JlSJNAHN
         pW2Q==
X-Gm-Message-State: AOAM531Mk9MpJf3UgZ3O8l3TMFpdP6Nr38CpKMmTvuEyKSTo7GG0enIJ
        nlzv8mBzWWOEzO5kC5bq8mZkPTCmnQHx5w==
X-Google-Smtp-Source: ABdhPJxDW1NhvSfgMnbhbbqpmb+bouwfcIoHwxHjNCy0nS5nDv2GvHsaQbdcydwkhSs5dq/n9JKMeA==
X-Received: by 2002:a17:907:2082:: with SMTP id pv2mr4985753ejb.188.1598049947249;
        Fri, 21 Aug 2020 15:45:47 -0700 (PDT)
Received: from PC3496-ARCH.AUSBILDUNG.TSBW.DE ([217.9.45.93])
        by smtp.gmail.com with ESMTPSA id v23sm2067268ejh.84.2020.08.21.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:45:46 -0700 (PDT)
From:   Torge Matthies <openglfreak@googlemail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Torge Matthies <openglfreak@googlemail.com>
Subject: [PATCH] Add Zstandard support
Date:   Sat, 22 Aug 2020 00:45:01 +0200
Message-Id: <20200821224501.196413-1-openglfreak@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I was not able to find any existing zstd patch for kmod, so I wrote my own.

I was struggling to get the C code below the 80 character line length limit,
that's why I used gotos. I used descriptive label names, and it still looks
clean enough in my opinion.

I changed the style of the hackargs variable in autogen.sh to multiline
because said line was becoming a bit long with the new --with-zstd arg
added.

This patch has been running on my two Arch Linux installations (with an
accompanying mkinitcpio patch) for several months over many kernel updates
without any issues.
Any additional testing and/or patch review would of course be appreciated.

Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
---
 .semaphore/semaphore.yml     |   4 +-
 .travis.yml                  |   1 +
 Makefile.am                  |   4 +-
 autogen.sh                   |   9 ++-
 configure.ac                 |  13 +++-
 libkmod/libkmod-file.c       | 119 +++++++++++++++++++++++++++++++++++
 libkmod/libkmod.pc.in        |   2 +-
 shared/util.c                |   3 +
 testsuite/mkosi/mkosi.fedora |   1 +
 testsuite/test-util.c        |   3 +
 10 files changed, 153 insertions(+), 6 deletions(-)

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
index 5eeba6a..1a2e753 100644
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
@@ -60,6 +66,116 @@ struct kmod_file {
 	struct kmod_elf *elf;
 };
 
+#ifdef ENABLE_ZSTD
+static int load_zstd(struct kmod_file *file)
+{
+	ZSTD_DStream *dstr = NULL;
+	size_t in_buf_size, out_buf_min_size, out_buf_size;
+	uint8_t *in_buf = NULL, *out_buf = NULL;
+	ZSTD_inBuffer zst_input;
+	ZSTD_outBuffer zst_output;
+	int ret = -EINVAL;
+
+	dstr = ZSTD_createDStream();
+	if (dstr == NULL) {
+		ERR(file->ctx, "zstd: Failed to create decompression stream\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	in_buf_size = ZSTD_initDStream(dstr);
+	in_buf = malloc(in_buf_size);
+	if (in_buf == NULL) {
+		ERR(file->ctx, "zstd: %s\n", strerror(ENOMEM));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	out_buf_size = out_buf_min_size = ZSTD_DStreamOutSize();
+	out_buf = malloc(out_buf_size);
+	if (out_buf == NULL) {
+		ERR(file->ctx, "zstd: %s\n", strerror(ENOMEM));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zst_input.src = in_buf;
+	zst_output.dst = out_buf;
+	zst_output.size = out_buf_size;
+	zst_output.pos = 0;
+	while (true) {
+		ssize_t rdret;
+		size_t dsret;
+		uint8_t *tmp;
+
+		rdret = read(file->fd, in_buf, in_buf_size);
+		if (rdret < 0) {
+			ret = -errno;
+			goto out;
+		}
+		if (rdret == 0)
+			break;
+
+		zst_input.size = rdret;
+		zst_input.pos = 0;
+
+		if (zst_output.size - zst_output.pos < out_buf_min_size)
+			goto realloc_buffer;
+
+try_decompress:
+		dsret = ZSTD_decompressStream(dstr, &zst_output, &zst_input);
+		if (ZSTD_isError(dsret)) {
+			ERR(file->ctx, "zstd: %s\n", ZSTD_getErrorName(dsret));
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (zst_output.pos < zst_output.size
+			&& zst_output.size - zst_output.pos
+			>= out_buf_min_size) {
+			if (zst_input.pos < zst_input.size)
+				goto try_decompress;
+			else
+				continue;
+		}
+
+realloc_buffer:
+		tmp = realloc(out_buf, out_buf_size + out_buf_min_size);
+		if (tmp == NULL) {
+			ret = -errno;
+			goto out;
+		}
+		out_buf_size += out_buf_min_size;
+		out_buf = tmp;
+		zst_output.dst = out_buf;
+		zst_output.size = out_buf_size;
+		goto try_decompress;
+	}
+
+	ZSTD_freeDStream(dstr);
+	free(in_buf);
+	file->zstd_used = true;
+	file->memory = out_buf;
+	file->size = zst_output.pos;
+	return 0;
+out:
+	if (dstr != NULL)
+		ZSTD_freeDStream(dstr);
+	free(out_buf);
+	free(in_buf);
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
@@ -238,6 +354,9 @@ static const struct comp_type {
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

