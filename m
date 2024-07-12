Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0861607B2
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790705; cv=none; b=X2VTh/qPyPqYRW4J/c0oOG+636ASnl3zUinAan8gJ8pbBNWXWdohd5xGm2tB+EuWNYXmsLP3uJWe95hxj1n91zMZaJc5QTl8k+LTqhoqX5SkkYS1PB76033GuiGO5fgNOxBxhidunrzkBlTt1fhPjjJM+Q3YS+yMIOYJXpSLecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790705; c=relaxed/simple;
	bh=/itcZ1/Vwc0HQV0q4k0XRFqHiSp75yNqSmc9JC+3atM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5fPWbgfjK5aKYqDGc6uLapEK4wLyvZAZr8Xbu4hbww/mPZcSz0/QcqmJDrbxVR0wiDUGQc4fCBNVnPCC9UESb13+m4uBJkTj3yJGKFCXNu+uEUBO03tvrkyQcCtnllk0zBx5Gv2aboPV/8hR5PtlITZKIOB+tpP7G57HKtjgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTbKA12p; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTbKA12p"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9e233873aso1184167b6e.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720790702; x=1721395502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUIv2EAM42wxWycJidVY/6XfeHtCyUkNaIuXsI0K9/U=;
        b=aTbKA12pOc8Mpv/EOoHbM7q4faE0VfSdh5BCBqvaMVt9pTNbLXmDWydRWTLNiQIPgg
         klPKAmYSojREafYhcg02nLJSqcpnImJcKo2Z0zXfg3TlZ92K82PuKGM4I2v7ARiGvGR3
         OVT3PWLVs8qYR7JnwbPJfsUV12c/V1CbmQuISKd1KC8k7qYDD+oDQd7O+NgGOsscaz0A
         cxGCA0BLg/wIe1A3tDW3JeXwxWy8X9m/NcuBHYXyi29S3IsYefFmITPQXhazXUDKBMG/
         8PpA+T3JD7gSIViVIWB/SHqU5NrBML6zlcYYoDYrz+VH4MjvJSdiobroXQ8ABksGhkGt
         b/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720790702; x=1721395502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUIv2EAM42wxWycJidVY/6XfeHtCyUkNaIuXsI0K9/U=;
        b=uB+DltUJ1ST7KaFTxAqua/n5n1RliILk/QJH2GmiyduYgH7IOf458c//wp1KDmMgsK
         24w9nEUfXN3X2YIC6qesBwQfozS9PLp+WP/vZVkFmtAO2iu+II0ybnot/s2vjHuOk+tx
         jfs9rnECOIvsNM32l3J/tHWYEEJmDdrW+KYKq9cu3yp9+8lfZ6gRW3LDF/0J/GqvEOWz
         EbDT2GQSKqXZCi87YdAnBXS3p3APOdHFj5NpLIAXE//+S8R/VehP0rH6s89C/oqLOZFt
         hXaHlLawmJO2Bv9jge5rHnvuOPwQ6rufgwdmp7r+UDNC9QFH5CnCM2DuM+AET3BUtqdu
         2AZw==
X-Gm-Message-State: AOJu0Yw4/ktXLb/7wozmxS98x9RMGMSLCw/PzsMFo814Bf709EB6Gxw7
	XtWMMS+oS6y9rF2fWIgwo0K+NnuOd6K6mUxEOr0LGcht2mp4i32zqILx8A==
X-Google-Smtp-Source: AGHT+IFvASybKXQPz16jq9dqN1fIw3uX4VXibaP/NaxA36X8WSc/mYfKTuTDzm4P9OuxgbrDf2Fd8w==
X-Received: by 2002:a05:6808:18a9:b0:3d2:4697:6b1a with SMTP id 5614622812f47-3d93bee513dmr12860854b6e.8.1720790701487;
        Fri, 12 Jul 2024 06:25:01 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190128fdsm402801185a.35.2024.07.12.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:25:00 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: emil.l.velikov@gmail.com,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH] README: update to a decade+ later
Date: Fri, 12 Jul 2024 08:24:49 -0500
Message-ID: <20240712132449.780421-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- State support for clang and other libc's
- Fix typos
- Reword the compatibility with module-init-tools section,
  removing most of the specific examples as we didn't keep
  track of all of them, and they are not important anymore
  in year 2024

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 README.md | 65 +++++++------------------------------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/README.md b/README.md
index 9b22bd7..1aa023d 100644
--- a/README.md
+++ b/README.md
@@ -44,9 +44,9 @@ module-init-tools project.
 Compilation and installation
 ============================
 
-In order to compiler the source code you need following software packages:
-	- GCC compiler
-	- GNU C library
+In order to compile the source code you need following software packages:
+	- GCC/CLANG compiler
+	- GNU C library / musl / uClibc
 
 Optional dependencies:
 	- ZLIB library
@@ -67,7 +67,7 @@ Hacking
 =======
 
 Run 'autogen.sh' script before configure. If you want to accept the recommended
-flags, you just need to run 'autogen.sh c'.
+flags, you just need to run `autogen.sh c`.
 
 Make sure to read the CODING-STYLE file and the other READMEs: libkmod/README
 and testsuite/README.
@@ -75,56 +75,7 @@ and testsuite/README.
 Compatibility with module-init-tools
 ====================================
 
-kmod replaces module-init-tools, which is end-of-life. Most of its tools are
-rewritten on top of libkmod so it can be used as a drop in replacements.
-Somethings however were changed. Reasons vary from "the feature was already
-long deprecated on module-init-tools" to "it would be too much trouble to
-support it".
-
-There are several features that are being added in kmod, but we don't
-keep track of them here.
-
-modprobe
---------
-
-* 'modprobe -l' was marked as deprecated and does not exist anymore
-
-* 'modprobe -t' is gone, together with 'modprobe -l'
-
-* modprobe doesn't parse configuration files with names not ending in
-  '.alias' or '.conf'. modprobe used to warn about these files.
-
-* modprobe doesn't parse 'config' and 'include' commands in configuration
-  files.
-
-* modprobe from m-i-t does not honour softdeps for install commands. E.g.:
-  config:
-
-        install bli "echo bli"
-	install bla "echo bla"
-	softdep bla pre: bli
-
-  With m-i-t, the output of 'modprobe --show-depends bla' will be:
-        install "echo bla"
-
-  While with kmod:
-        install "echo bli"
-        install "echo bla"
-
-* kmod doesn't dump the configuration as is in the config files. Instead it
-  dumps the configuration as it was parsed. Therefore, comments and file names
-  are not dumped, but on the good side we know what the exact configuration
-  kmod is using. We did this because if we only want to know the entire content
-  of configuration files, it's enough to use find(1) in modprobe.d directories
-
-depmod
-------
-
-* there's no 'depmod -m' option: legacy modules.*map files are gone
-
-lsmod
------
-
-* module-init-tools used /proc/modules to parse module info. kmod uses
-  /sys/module/*, but there's a fallback to /proc/modules if the latter isn't
-  available
+kmod replaced module-init-tools, which was EOL'ed in 2011. All the tools were
+rewritten on top of libkmod and they can be used as drop in replacements.
+Along the years there were a few behavior changes and new features implemented,
+following feedback from Linux kernel community and distros.
-- 
2.45.2

