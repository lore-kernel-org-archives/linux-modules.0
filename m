Return-Path: <SRS0=iAAw=QU=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BB2C282C2
	for <linux-modules@archiver.kernel.org>; Wed, 13 Feb 2019 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C968206C0
	for <linux-modules@archiver.kernel.org>; Wed, 13 Feb 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="tkB5Asox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfBMPeF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:34:05 -0500
Received: from orion.archlinux.org ([88.198.91.70]:56382 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfBMPeF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 13 Feb 2019 10:34:05 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 10:34:04 EST
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id E81A0109B62AC3;
        Wed, 13 Feb 2019 15:27:55 +0000 (UTC)
Received: from localhost (unknown [IPv6:2604:2000:1406:11:3d8d:9595:3c9:59b1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dreisner)
        by orion.archlinux.org (Postfix) with ESMTPSA id 7A9DE109B62AC2;
        Wed, 13 Feb 2019 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archlinux.org;
        s=orion; t=1550071675;
        bh=/+pb1o9hvx7dqAaCOEvvg/fkc1qphfFjNv6ppH8tXdM=;
        h=From:To:Cc:Subject:Date;
        b=tkB5AsoxR72EOwW+nGzT6cRyNcf3DZYco23yK18IUZp5FjTHVCMl+NpRXodPdOomn
         /DDez1yov9UsLAhyAbYRwvpbusiH1bIN9mOzKxMvlsjgXdE63QJN7ZRKZWwFtvFMEu
         t9xNOsk62aTh9e36raIbJdXeGA7LY/7wemw50fnTo/wWAsAPaN4ITJd6nGYwc6jBUD
         jOcHwp/B21NN2SxRT+kKguwsRCo3KlrKQgCZXRnXR7j/Fvq1o/zkry4rBnGUq5HErc
         IV7AYIVKbNn92x4gdBMhZPkzm7M74jzjhIfU/HEjuCP2hRXrPROsv0gPzTxxTzSk/x
         F9AJFPihA47VsqzC8tVL1gi8bu0GfmqGU95MKI3PT7Eqitxw0O/wsfW5I0EZv4+0If
         9mAvwvXSTjdmSJizlwzO3btwLkUhj3lO60YE88W8Sf24MgtgnV66IosjFn+apML+3l
         PDai01KHbHHywCVcnnp5uMYt5atjiyiASSDMQEGzuVFhqLu86o2gSBqxPofw/AR66+
         ZGBZkksaTRN7LqsbEfAD5JAVhoar36OkdyYez5IUyn9R/hv3VY3D6egBJNCtWBr36P
         RWqZzKoGdGlSPySy1LmQxxXcWi/B6acrLdLkbS8chugiyuMrrojaVW+HrQEtFqK5rO
         zlLwBu9kZANznjbnlN4XEY8U=
From:   Dave Reisner <dreisner@archlinux.org>
To:     linux-modules@vger.kernel.org
Cc:     Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] Link against libcrypto, not all of openssl
Date:   Wed, 13 Feb 2019 10:27:51 -0500
Message-Id: <20190213152751.9138-1-dreisner@archlinux.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

In the previous build setup, libkmod.so would link to not just
libcrypto.so, but also libssl.so:

$ readelf -d /lib/libkmod.so | grep NEEDED
 0x0000000000000001 (NEEDED)             Shared library: [liblzma.so.5]
 0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libssl.so.1.1]
 0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.1.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

We don't need any symbols from libssl, though. This patch ensures that
we pass 'libcrypto' to pkgconfig rather than 'openssl', getting only the
library that we need:

$ readelf -d tools/kmod | grep NEEDED
 0x0000000000000001 (NEEDED)             Shared library: [liblzma.so.5]
 0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libcrypto.so.1.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
---
 Makefile.am  | 6 +++---
 configure.ac | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ddb25f0..758f4f0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -35,8 +35,8 @@ SED_PROCESS = \
 	-e 's,@liblzma_LIBS\@,${liblzma_LIBS},g' \
 	-e 's,@zlib_CFLAGS\@,${zlib_CFLAGS},g' \
 	-e 's,@zlib_LIBS\@,${zlib_LIBS},g' \
-	-e 's,@openssl_CFLAGS\@,${openssl_CFLAGS},g' \
-	-e 's,@openssl_LIBS\@,${openssl_LIBS},g' \
+	-e 's,@libcrypto_CFLAGS\@,${libcrypto_CFLAGS},g' \
+	-e 's,@libcrypto_LIBS\@,${libcrypto_LIBS},g' \
 	< $< > $@ || rm $@
 
 %.pc: %.pc.in Makefile
@@ -89,7 +89,7 @@ libkmod_libkmod_la_DEPENDENCIES = \
 	${top_srcdir}/libkmod/libkmod.sym
 libkmod_libkmod_la_LIBADD = \
 	shared/libshared.la \
-	${liblzma_LIBS} ${zlib_LIBS} ${openssl_LIBS}
+	${liblzma_LIBS} ${zlib_LIBS} ${libcrypto_LIBS}
 
 noinst_LTLIBRARIES += libkmod/libkmod-internal.la
 libkmod_libkmod_internal_la_SOURCES = $(libkmod_libkmod_la_SOURCES)
diff --git a/configure.ac b/configure.ac
index ee72283..dffe278 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,12 +110,12 @@ AC_ARG_WITH([openssl],
 	AS_HELP_STRING([--with-openssl], [handle PKCS7 signatures @<:@default=disabled@:>@]),
 	[], [with_openssl=no])
 AS_IF([test "x$with_openssl" != "xno"], [
-	PKG_CHECK_MODULES([openssl], [openssl >= 1.1.0])
+	PKG_CHECK_MODULES([libcrypto], [libcrypto >= 1.1.0])
 	AC_DEFINE([ENABLE_OPENSSL], [1], [Enable openssl for modinfo.])
 ], [
 	AC_MSG_NOTICE([openssl support not requested])
 ])
-CC_FEATURE_APPEND([with_features], [with_openssl], [OPENSSL])
+CC_FEATURE_APPEND([with_features], [with_openssl], [LIBCRYPTO])
 
 AC_ARG_WITH([bashcompletiondir],
 	AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
-- 
2.20.1
