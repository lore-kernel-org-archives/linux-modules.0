Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986485941
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900919; cv=none; b=BYE7gk/OHW70CkXaq9nc4RAPv7wIU2RA1q2jiw+pmyaFvBZNt5w+QHe+3YIbDScTMCuYMnou5HNtBJZihW0BnpBtb78FCoURerPZC23t+mQf/3R5zRVjcQVav4XuF+2ZQdxQDu7XsQ1BSmEDwWsrBkdvMagt6PC10IdAMW2zkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900919; c=relaxed/simple;
	bh=KnJbf/iI8EMnYLnoF62fzId1BlXQxIkq/YltspWi/zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLsklZaKZdJdnHDewVS3yACecOLY8ytuvMdyWxhN0tomGJcQX9x5JCsLCIW8BNVz+tTWp1yH7QdYXVzJ8DDY44LJE4WZUllCEFEp4CWBfZKJcincsiMYBVf2W8bqP35fFiPhX+0umR51BQg1Wo1SiGvuXfEj/99V/6dHsBqX8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHRxpYUm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHRxpYUm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d8dff637so159620285a.3
        for <linux-modules@vger.kernel.org>; Fri, 02 Feb 2024 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900916; x=1707505716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9MRfHUiYixbayt2DrOyL1PkCO9x1bPKSHjIqNqP84E=;
        b=cHRxpYUmMkuokID2CdoU20A3Pf4E6oUlnwbAGC7bNnP6TvBuan5IyAXmy7S+9XuVZA
         X3ZaAylEnJdk69gi5Ib2/kAhSNe9v85fdvzOgZkgfLFO+xC8oLAES2b9E/Kb6dGzxp/q
         Q99jqpTkmEGNJj52nTMYinV2w2yl7VqAdR9PKJsmpgJXTUWpYahhiI6JSf73CAGv/WON
         Wf8wshDo/GJjn1zrHGAiY7A9A33rJKj7/2lpwCyQZ20u/dr+Kk90nsYsBPZPtVtJtW9M
         PJTh/+ThxkmTVLOFuGTEhSMHXgmY+Ai0t5GFy72phtXzi0pxX0uYmKHtG+Rs0xH2sfpa
         5xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900916; x=1707505716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9MRfHUiYixbayt2DrOyL1PkCO9x1bPKSHjIqNqP84E=;
        b=lJeH/eaCqZRNhaB3I+3CTYUYgVhbVZrC6FjNkyqTMpaGHTqZiNxq3xtj4MH+j50UTd
         FYQ7IgZoqpArq1IuRAwpwZ+fM8E9ZOxxb6XAmxJYE2xazLOs+C3k+XC5J/6UkrWCB9TQ
         WVc2Qa9HBjdZICqajcR/GUKx6drdL5kJVKLfAPV3aE7jYjZIT1R55yKBXCtcyX6tntk0
         RImw5OZeeZjH9Xzvyk2AixeO3mCxOQwke18R4H0TB4unT2vEj4p/ve5hgwnf2yMv2GN/
         lPTP4SPyDtbrKxbzq7gRY+wAEIJ3W11o7g3OCJhhIlo6agMGdqdHI2E2tNMwB447+N5h
         XCHA==
X-Gm-Message-State: AOJu0YxqpRXXdoTKvEpncoqT5oXE1ul8/WfuB7ES/TJOaVFZCwTSzRez
	+f8Z9NKFxKL1MbSlcJz9L+eKeBp1j6ckjbtbvXmuFP8xAmqipR5PN8aMhqTs
X-Google-Smtp-Source: AGHT+IEJZydpigrwIfIxtZrg0ijZV9Y0wg6ZwzFdvQzyFmAfEQ+UeRCQshKaN+vUfNCqaHrYTqo/VA==
X-Received: by 2002:a05:620a:4512:b0:784:aade:7d6a with SMTP id t18-20020a05620a451200b00784aade7d6amr3659025qkp.50.1706900915898;
        Fri, 02 Feb 2024 11:08:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAppAjHqDcKkBkPFpJxpA6kH3SqayweTCREk+oYH/Azz+az99ck+vbHYyJNK4FvqlreXjL2v7uu2SYCX/OONWNmJ6jUm6e1+E=
Received: from ldmartin-desk2.lan ([192.55.54.51])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a15a400b0078408de98e6sm903011qkk.72.2024.02.02.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:35 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 3/4] testsuite: drop mkosi
Date: Fri,  2 Feb 2024 13:08:22 -0600
Message-ID: <20240202190823.418148-4-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not being actively used, so drop it.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 Makefile.am                  | 10 ----------
 configure.ac                 |  1 -
 testsuite/mkosi/.gitignore   |  3 ---
 testsuite/mkosi/mkosi.arch   | 26 ------------------------
 testsuite/mkosi/mkosi.build  | 38 ------------------------------------
 testsuite/mkosi/mkosi.clear  | 20 -------------------
 testsuite/mkosi/mkosi.fedora | 28 --------------------------
 7 files changed, 126 deletions(-)
 delete mode 100644 testsuite/mkosi/.gitignore
 delete mode 100644 testsuite/mkosi/mkosi.arch
 delete mode 100755 testsuite/mkosi/mkosi.build
 delete mode 100644 testsuite/mkosi/mkosi.clear
 delete mode 100644 testsuite/mkosi/mkosi.fedora

diff --git a/Makefile.am b/Makefile.am
index 59dcaaf..6d21ad2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -416,13 +416,3 @@ tar: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 
 tar-sync: kmod-$(VERSION).tar.xz kmod-$(VERSION).tar.sign
 	kup put kmod-$(VERSION).tar.xz  kmod-$(VERSION).tar.sign /pub/linux/utils/kernel/kmod/
-
-# ------------------------------------------------------------------------------
-# mkosi
-# ------------------------------------------------------------------------------
-
-DISTRO ?= "arch"
-
-mkosi:
-	-$(MKDIR_P) $(top_srcdir)/testsuite/mkosi/mkosi.cache
-	$(MKOSI) -C $(top_srcdir)/testsuite/mkosi --build-sources ../../ --default mkosi.${DISTRO} -fi
diff --git a/configure.ac b/configure.ac
index 372819d..bfabbaa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,7 +33,6 @@ AC_PROG_MKDIR_P
 AC_PROG_LN_S
 PKG_PROG_PKG_CONFIG
 AC_PATH_PROG([XSLTPROC], [xsltproc])
-AC_PATH_PROG([MKOSI], [mkosi])
 
 AC_PROG_CC_C99
 
diff --git a/testsuite/mkosi/.gitignore b/testsuite/mkosi/.gitignore
deleted file mode 100644
index 0e0981a..0000000
--- a/testsuite/mkosi/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-/*-image.raw*
-/.mkosi-*
-/mkosi.cache
diff --git a/testsuite/mkosi/mkosi.arch b/testsuite/mkosi/mkosi.arch
deleted file mode 100644
index ace5d95..0000000
--- a/testsuite/mkosi/mkosi.arch
+++ /dev/null
@@ -1,26 +0,0 @@
-[Distribution]
-Distribution=arch
-Release=(rolling)
-
-[Output]
-Output = arch-image.raw
-
-[Packages]
-Packages = valgrind
-BuildPackages =
-	automake
-	gcc
-	git
-	make
-	pkg-config
-	python2
-	python2-future
-	autoconf
-	gtk-doc
-	docbook-xml
-	docbook-xsl
-	linux-headers
-	openssl
-
-[Partitions]
-RootSize = 3G
diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
deleted file mode 100755
index 53fc797..0000000
--- a/testsuite/mkosi/mkosi.build
+++ /dev/null
@@ -1,38 +0,0 @@
-#!/bin/bash -ex
-
-function find_kdir() {
-    local kdirs=(/usr/lib/modules/*/build/Makefile /usr/src/kernels/*/Makefile)
-    local kdir=""
-
-    for f in "${kdirs[@]}"; do
-        if [ -f "$f" ]; then
-            kdir=$f
-            break
-        fi
-    done
-
-    if [ -z "$kdir" ]; then
-        printf '==> Unable to find kernel headers to build modules for tests\n' >&2
-        exit 1
-    fi
-
-    kdir=${kdir%/Makefile}
-
-    echo $kdir
-}
-
-if [ -f configure ]; then
-    make distclean
-fi
-
-rm -rf build
-mkdir build
-cd build
-
-kdir=$(find_kdir)
-IFS=/ read _ _ _ kver _ <<<"$kdir"
-
-../autogen.sh c
-make -j
-make check KDIR="$kdir" KVER="$kver"
-make install
diff --git a/testsuite/mkosi/mkosi.clear b/testsuite/mkosi/mkosi.clear
deleted file mode 100644
index 03ba2f0..0000000
--- a/testsuite/mkosi/mkosi.clear
+++ /dev/null
@@ -1,20 +0,0 @@
-[Distribution]
-Distribution=clear
-Release=latest
-
-[Output]
-Output = clear-image.raw
-
-[Packages]
-Packages=
-	os-core-update
-BuildPackages=
-	os-core-dev
-	linux-dev
-
-[Partitions]
-RootSize = 5G
-
-[Host]
-# This is where swupd-extract is usually installed.
-ExtraSearchPaths=$SUDO_HOME/go/bin
\ No newline at end of file
diff --git a/testsuite/mkosi/mkosi.fedora b/testsuite/mkosi/mkosi.fedora
deleted file mode 100644
index 7a2ee5e..0000000
--- a/testsuite/mkosi/mkosi.fedora
+++ /dev/null
@@ -1,28 +0,0 @@
-[Distribution]
-Distribution=fedora
-Release=29
-
-[Output]
-Output = fedora-image.raw
-
-[Packages]
-Packages = valgrind
-BuildPackages =
-	autoconf
-	automake
-	gcc
-	git
-	gtk-doc
-	kernel-devel
-	libtool
-	libxslt
-	make
-	pkgconf-pkg-config
-	xml-common
-	libzstd-devel
-	xz-devel
-	zlib-devel
-	openssl-devel
-
-[Partitions]
-RootSize = 2G
-- 
2.43.0

