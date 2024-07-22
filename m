Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEE16A947
	for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639232; cv=none; b=ZI3Nmel5iVqVPUd9kipjI4FX1Jh/UpBxvLzZFOd6epyTU2htG5fVTQ6lx0j53pNzUsrYjZPKdz+QDSTNM4ThRWp77Oc4KbyaRz+bAmHtIpzk2QwKgSEHU5kFxSo69SUU2KA6st3ULAiOZwGVU94HWL8LDX2k6Ug7KuV10hBXtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639232; c=relaxed/simple;
	bh=UoQGzTDhvnmlCuBp8exgdrBKvRdVrxvPS1GGpCFUA+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fL3VZg/YpxJZqbGk2PUyNl2RUO+SAq/DtPlSWwP5JAAaG0rTHRYQPd/EwCww2iAHsOyrrjPCYNnXTDRwCRh8G76zzA7ejFNkd/a88qbqXkBftBDKVQ5RKVbV8aK1oirky0LZe5DRhakGH0BMKxrTt11mNSrWDR/r9yzEOX7GJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HOli7q4Z; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HOli7q4Z"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so10806091fa.0
        for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721639228; x=1722244028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3nTgko0OeNbyL3RvXdj8me3TnANxTs551sWuyc3xyM=;
        b=HOli7q4Z3PksLpp5b/aEfCaBqWUlV6qYQkHMnJdsZB/v+JuK/6swsijUAdRhlkqDQH
         3NDYUM5AC1Pgog6qcZegUxYIm0Bpd3uHC2i0RDMBauENEyrsZJ0QVMFcfHnh1B5uxEwJ
         0QOxf8uGrBoUdmfWE/tNYcyzgjlkFUxqcZ2/IG775XPdjJbIKGn4AmGzr2pK0o9yFvXQ
         dmCGVjbx131yaygboc9azAfLTzrrS+GPxOBLyE//P7pVT/v+8ZgtN2kDYw28okya+4uU
         x0OZnoHqQyvP24Pd89oqrut0Dn6LuNtxfqJftxyaOs0KmlwqBGRuHQSHs2NAy0RmrUXL
         OKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639228; x=1722244028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3nTgko0OeNbyL3RvXdj8me3TnANxTs551sWuyc3xyM=;
        b=gpE5P6CUOVHxGvO4fgLo+FSJASXH7wTGjoUkTdMGy0GJWQEkyXn2pCLV7flk8icR86
         QbeHG6xZERYTam3pbuxs37HQ60xmt6HxM0wx4onCsbuCdRdp80CFLTawZDqCyBohvR2D
         /470aYi2JWej+m4zeRfzgvyxdHweEK1mRbBMcF0YBHUCfUxVLREMgpnUhjj5Sq+UOa/j
         IQKM4De6L4zJAZ7J3yeXL8V/W0C5Eb2LTZHhOGtfrDih0ajipD5KKXcjlrPvLDnSUmYQ
         BEn8UncZ+sFiaKejXnw//jZYXXTrEKiDRYFxRGlIhFgNOplEU9cbjWBAGQBIh6KGFCkG
         BhVw==
X-Forwarded-Encrypted: i=1; AJvYcCVcg3kOCCwQsKDx3ZR7/AzgUsXmErZySR9VLc3pIEeNaW6oMh+EnfUIvlvL8/jf33pDJOl7z+KznzMCRkMGhF4XxxVEtwARtk8e8HDQzA==
X-Gm-Message-State: AOJu0YxVR2cYAge327VeK19jD1Qq+KU2bNoG2xbWDrPg6Tb+g1T9nkUd
	xk26GkKqd6KC0SyYfhZS6SaB2pqr8xIP3YUwYtOBGOgCjhrazHjh+VJfPVfnDdM=
X-Google-Smtp-Source: AGHT+IF2nh9a11k/95sobv4TRJjIrZcCKKH/wp6Qt14Noc3fFQtewHrx2UgLqDovP7C8C/7P+xgGCw==
X-Received: by 2002:a2e:978d:0:b0:2ee:4dc6:fe28 with SMTP id 38308e7fff4ca-2ef16856deemr42974531fa.40.1721639228449;
        Mon, 22 Jul 2024 02:07:08 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7753abeasm7534290a91.48.2024.07.22.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:07:07 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/2] module: Split modules_install compression and in-kernel decompression
Date: Mon, 22 Jul 2024 11:06:21 +0200
Message-Id: <20240722090622.16524-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722090622.16524-1-petr.pavlu@suse.com>
References: <20240722090622.16524-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel configuration allows specifying a module compression mode. If
one is selected then each module gets compressed during
'make modules_install' and additionally one can also enable support for
a respective direct in-kernel decompression support. This means that the
decompression support cannot be enabled without the automatic compression.

Some distributions, such as the (open)SUSE family, use a signer service for
modules. A build runs on a worker machine but signing is done by a separate
locked-down server that is in possession of the signing key. The build
invokes 'make modules_install' to create a modules tree, collects
information about the modules, asks the signer service for their signature,
appends each signature to the respective module and compresses all modules.

When using this arrangment, the 'make modules_install' step produces
unsigned+uncompressed modules and the distribution's own build recipe takes
care of signing and compression later.

The signing support can be currently enabled without automatically signing
modules during 'make modules_install'. However, the in-kernel decompression
support can be selected only after first enabling automatic compression
during this step.

To allow only enabling the in-kernel decompression support without the
automatic compression during 'make modules_install', separate the
compression options similarly to the signing options, as follows:

> Enable loadable module support
[*] Module compression
      Module compression type (GZIP)  --->
[*]   Automatically compress all modules
[ ]   Support in-kernel module decompression

* "Module compression" (MODULE_COMPRESS) is a new main switch for the
  compression/decompression support. It replaces MODULE_COMPRESS_NONE.
* "Module compression type" (MODULE_COMPRESS_<type>) chooses the
  compression type, one of GZ, XZ, ZSTD.
* "Automatically compress all modules" (MODULE_COMPRESS_ALL) is a new
  option to enable module compression during 'make modules_install'. It
  defaults to Y.
* "Support in-kernel module decompression" (MODULE_DECOMPRESS) enables
  in-kernel decompression.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig    | 61 ++++++++++++++++++++--------------------
 scripts/Makefile.modinst |  2 ++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 4047b6d48255..bb7f7930fef6 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -278,64 +278,65 @@ config MODULE_SIG_HASH
 	default "sha3-384" if MODULE_SIG_SHA3_384
 	default "sha3-512" if MODULE_SIG_SHA3_512
 
-choice
-	prompt "Module compression mode"
+config MODULE_COMPRESS
+	bool "Module compression"
 	help
-	  This option allows you to choose the algorithm which will be used to
-	  compress modules when 'make modules_install' is run. (or, you can
-	  choose to not compress modules at all.)
-
-	  External modules will also be compressed in the same way during the
-	  installation.
-
-	  For modules inside an initrd or initramfs, it's more efficient to
-	  compress the whole initrd or initramfs instead.
-
+	  Enable module compression to reduce on-disk size of module binaries.
 	  This is fully compatible with signed modules.
 
-	  Please note that the tool used to load modules needs to support the
-	  corresponding algorithm. module-init-tools MAY support gzip, and kmod
-	  MAY support gzip, xz and zstd.
+	  The tool used to work with modules needs to support the selected
+	  compression type. kmod MAY support gzip, xz and zstd. Other tools
+	  might have a limited selection of the supported types.
 
-	  Your build system needs to provide the appropriate compression tool
-	  to compress the modules.
+	  Note that for modules inside an initrd or initramfs, it's more
+	  efficient to compress the whole ramdisk instead.
 
-	  If in doubt, select 'None'.
+	  If unsure, say N.
 
-config MODULE_COMPRESS_NONE
-	bool "None"
+choice
+	prompt "Module compression type"
+	depends on MODULE_COMPRESS
 	help
-	  Do not compress modules. The installed modules are suffixed
-	  with .ko.
+	  Choose the supported algorithm for module compression.
 
 config MODULE_COMPRESS_GZIP
 	bool "GZIP"
 	help
-	  Compress modules with GZIP. The installed modules are suffixed
-	  with .ko.gz.
+	  Support modules compressed with GZIP. The installed modules are
+	  suffixed with .ko.gz.
 
 config MODULE_COMPRESS_XZ
 	bool "XZ"
 	help
-	  Compress modules with XZ. The installed modules are suffixed
-	  with .ko.xz.
+	  Support modules compressed with XZ. The installed modules are
+	  suffixed with .ko.xz.
 
 config MODULE_COMPRESS_ZSTD
 	bool "ZSTD"
 	help
-	  Compress modules with ZSTD. The installed modules are suffixed
-	  with .ko.zst.
+	  Support modules compressed with ZSTD. The installed modules are
+	  suffixed with .ko.zst.
 
 endchoice
 
+config MODULE_COMPRESS_ALL
+	bool "Automatically compress all modules"
+	default y
+	depends on MODULE_COMPRESS
+	help
+	  Compress all modules during 'make modules_install'.
+
+	  Your build system needs to provide the appropriate compression tool
+	  for the selected compression type. External modules will also be
+	  compressed in the same way during the installation.
+
 config MODULE_DECOMPRESS
 	bool "Support in-kernel module decompression"
-	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ || MODULE_COMPRESS_ZSTD
+	depends on MODULE_COMPRESS
 	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
 	select XZ_DEC if MODULE_COMPRESS_XZ
 	select ZSTD_DECOMPRESS if MODULE_COMPRESS_ZSTD
 	help
-
 	  Support for decompressing kernel modules by the kernel itself
 	  instead of relying on userspace to perform this task. Useful when
 	  load pinning security policy is enabled.
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 0afd75472679..bce4a9adb893 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -51,9 +51,11 @@ $(foreach x, % :, $(if $(findstring $x, $(dst)), \
 	$(error module installation path cannot contain '$x')))
 
 suffix-y				:=
+ifdef CONFIG_MODULE_COMPRESS_ALL
 suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
 suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
+endif
 
 modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
 install-$(CONFIG_MODULES) += $(modules)
-- 
2.35.3

