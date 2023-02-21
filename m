Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC67C61DA3
	for <linux-modules@archiver.kernel.org>; Tue, 21 Feb 2023 13:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBUNTk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjBUNTj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 08:19:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D70D1C313
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l6so3194655wms.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+p/Ow+d6DG7aJa2PdxbCzb6KsbOEOmJVCwwyvTASPU=;
        b=feSvGV0LKdd3WoGhoiZwynCuxNpEw1qllhJjKsFw3hkb/x5U5tRC8DN4HhoBbve85u
         0vpkp/6hOOFrME/wZKR824dQdrc9lxT5ncBuWc9LDDgd1vMVpggoJMokNLuvgg/BpNHe
         Sij3kWsuy9gBrPAxyirZGV4izHOV/vzJAMzOwHEXC/a5XNF+mccIDFwZHsfauhdgLRQi
         gANpPz/+Y6W5+dowBnsBQcu49pGvsxbCU/mbXZroFZvkTmQexSGhLCetq6C5SWEoqQ9c
         QOWvsfrVtG7TyJg1te4n0177YUWTj2p0qJ8oKIhXRIMU40uCj+mBQgpD4HKH3QZTow6o
         5oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+p/Ow+d6DG7aJa2PdxbCzb6KsbOEOmJVCwwyvTASPU=;
        b=K0XJMstECjCVQjZQCB66L8nT6CafnfjE8XIo0hwtZqwoHC/h5mxZcAVtmNLvr1vlAJ
         3/hwpPqgnNNhXlinCdCZmNDxKsD4QcjWAlYZ0WVayhFWFdVKYsEPKid1M30tu2BbrXUq
         6mMWVVEQTGnmWjN6yXKrSUx19DOCj34/HhkoE/jBa3w12EDIG9QmqQJpTQJSuwGIH8ey
         25pqbi+pjclY/YswgzKA5ak+aKju3dCr06/5O2zcElPZSsCsJBBhKMoogIypyL+GihUE
         J5VJif6cce+b4jPJeU3u32zPcMgMyDiFAx7busMXCG054yY3eglf/asdAOtq8qqnt7K9
         idnw==
X-Gm-Message-State: AO0yUKXHSLf/MUvrv/8cGJtojITomM2jNBz8J5NcaKuQHrI4QVp4/ut7
        YdbnLfsMgK1aEABOfsKiD6dCxUTcge0=
X-Google-Smtp-Source: AK7set96VYpsxsN2KbuRLFpQ80sp/EdiJ68356W6yn0mHwu1/oHtAgJuw2+P2lK1poZkYcxlBex/UA==
X-Received: by 2002:a05:600c:1887:b0:3e2:918:ecd4 with SMTP id x7-20020a05600c188700b003e20918ecd4mr3367366wmp.37.1676985576605;
        Tue, 21 Feb 2023 05:19:36 -0800 (PST)
Received: from localhost (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net. [82.24.248.100])
        by smtp.gmail.com with UTF8SMTPSA id y14-20020a7bcd8e000000b003e118684d56sm3610422wmj.45.2023.02.21.05.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:19:36 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 4/4] configure: manage libkmod.pc.in and version.py.in via AC_CONFIG_FILES
Date:   Tue, 21 Feb 2023 13:19:29 +0000
Message-Id: <20230221131929.106951-5-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221131929.106951-1-emil.l.velikov@gmail.com>
References: <20230221131929.106951-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Replace the manual sed command, build rules and dist/clean for using
AC_CONFIG_FILES. It does the exact same thing, with an added bonus...

Currently we're missing version.py.in in the EXTRA_DIST. Thus a simple
"touch Makefile" should retrigger the regeneration of version.py. Which
would presumably fail, since the input file isn't in the distribution
tarball.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Feel free to compare the diff between the old/new "make distcheck".
Cannot realistically add that here as it seemingly confuses the hell out
of git am.
---
 Makefile.am  | 25 -------------------------
 configure.ac |  2 ++
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 61dbdf0..8ba85c9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,26 +24,6 @@ AM_CPPFLAGS = \
 AM_CFLAGS = $(OUR_CFLAGS)
 AM_LDFLAGS = $(OUR_LDFLAGS)
 
-SED_PROCESS = \
-	$(AM_V_GEN)$(MKDIR_P) $(dir $@) && $(SED) \
-	-e 's,@VERSION\@,$(VERSION),g' \
-	-e 's,@prefix\@,$(prefix),g' \
-	-e 's,@exec_prefix\@,$(exec_prefix),g' \
-	-e 's,@libdir\@,$(libdir),g' \
-	-e 's,@includedir\@,$(includedir),g' \
-	-e 's,@libzstd_CFLAGS\@,${libzstd_CFLAGS},g' \
-	-e 's,@libzstd_LIBS\@,${libzstd_LIBS},g' \
-	-e 's,@liblzma_CFLAGS\@,${liblzma_CFLAGS},g' \
-	-e 's,@liblzma_LIBS\@,${liblzma_LIBS},g' \
-	-e 's,@zlib_CFLAGS\@,${zlib_CFLAGS},g' \
-	-e 's,@zlib_LIBS\@,${zlib_LIBS},g' \
-	-e 's,@libcrypto_CFLAGS\@,${libcrypto_CFLAGS},g' \
-	-e 's,@libcrypto_LIBS\@,${libcrypto_LIBS},g' \
-	< $< > $@ || rm $@
-
-%.pc: %.pc.in Makefile
-	$(SED_PROCESS)
-
 # Rules for libtool versioning (from https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html)
 # 1. Start with version information of ‘0:0:0’ for each libtool library.
 # 2. Update the version information only immediately before a public release of
@@ -116,8 +96,6 @@ libkmod_libkmod_internal_la_LIBADD = $(libkmod_libkmod_la_LIBADD)
 
 pkgconfigdir = $(libdir)/pkgconfig
 pkgconfig_DATA = libkmod/libkmod.pc
-EXTRA_DIST += libkmod/libkmod.pc.in
-CLEANFILES += libkmod/libkmod.pc
 
 bashcompletiondir=@bashcompletiondir@
 dist_bashcompletion_DATA = \
@@ -179,9 +157,6 @@ am__v_CYTHON_0 = @echo "  CYTHON " $@;
 .pyx.c:
 	$(AM_V_CYTHON)$(CYTHON) -o $@ $<
 
-%.py: %.py.in Makefile
-	$(SED_PROCESS)
-
 # Remove some warnings for generated code
 PYTHON_NOWARN = -Wno-redundant-decls -Wno-shadow -Wno-strict-aliasing
 
diff --git a/configure.ac b/configure.ac
index 892f5d9..65902d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -292,6 +292,8 @@ AC_CONFIG_FILES([
 	man/Makefile
 	libkmod/docs/Makefile
 	libkmod/docs/version.xml
+	libkmod/libkmod.pc
+	libkmod/python/kmod/version.py
 ])
 
 
-- 
2.39.2

