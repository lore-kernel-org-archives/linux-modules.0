Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B71C1F20
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937172; cv=none; b=ORVYg0bQimQ+2Q259WUDZoGp/4eT3GehFfAHbt0n/es9l5f7OYc9GBsiiJhYL4vLbNwPVFdHkgk5aAIW8OikORhG5R83T5t7uWUec6lip0DREkoYKH6TAqRuJKY9me+3czJ7XIX/WBhf+8Txmpsq3lAZJsSSJ5pZvckn4QTNLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937172; c=relaxed/simple;
	bh=p7WWEhhYSoB9EsyiZb7zkPmioP1Ghg8VnlGqhauZXHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJvh/7QlRogSJan0e9ATsI9TFNLaBjIViTn50fl6eYx9igO6VpoDkks7v1y9yeFGysI2iQUJ7JBkKIgRA1wE64dvR/fhDr4iLa7VoPjIfBHt3LqjgAS4V6RRSLBpMwV/uIW8K8hWu9J8ideFZA8oTzYOzse7/MkdiOoP1O9Vvy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wahCOztK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wahCOztK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so26104658a91.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 12:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735937160; x=1736541960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9QWQProj0DRDekjJKvkceMs2crMPK7X9JqHuvPddMI=;
        b=wahCOztK+/anGG7toJ0I7pSc/RNIPUZLDWWGsiZ9uAf8wCrCQGi6YwwpZbqfVp3L9i
         qTR/SacX15it2JyvtxJ1UL5DWIZSChuaBNIKB1q+8IaeoJfXEiBN+C0yZuOJ4aYamqZO
         fIINvoW9uzYqBKVkGTzcCKUlrUQqZKNR3USxbpOX/ayXrHxqSk9LouGklJLw9nLWkCzF
         OzTMLikCVRV/GBC9cttRAiRDaN5Nh9hCZC79iPZ8xg2fKgvwllj7a1eeoqozK5dDGGPC
         2umhbOiJ+GpWQytz2hutkaBE2UJR6iKR5vyohN/t2sVCCXRtT2febFPKNoBrNqf1wycu
         2vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937160; x=1736541960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9QWQProj0DRDekjJKvkceMs2crMPK7X9JqHuvPddMI=;
        b=Jz8LT2rFO9TXkxM0NLbEBKPGMEfHX3tVV7pbFf0M5enmPHy4QU7ItcHz6/ufrDVw7i
         vFPh7nwZKj5ASMLF50gNAdNb17Z59B9gR+XvdnLFKxx+cWxeolVzr3Tu6FP9jhUAr+Vg
         3bdENkCCQrNWQyElKC69b3aneUYj7zc45Tyj8OkzdNNdccI+Y3d6X6qkqJ4s09Q6nCfB
         KyO39k101DK0ENapN4LXkllS/9GCk9VQjUoQNmafUUAAm5JckPjpWgpsde61BrvHAfaB
         QJKODknUjxvzBA8d4dEfDFH/y8aUKyXejsl+/2jsG9hYYDDOMcOI11J2G2+udh48b4xh
         BLng==
X-Forwarded-Encrypted: i=1; AJvYcCWq6l6AgD8DjCzums+qPF8CspbjxXE+UG5STkJqa4BBlh66VJ/m9mwW7FCxDLjg2WgZ64rpZf5aZBVRO8n7@vger.kernel.org
X-Gm-Message-State: AOJu0YybLwhjN9of9jsn5syi1n1U1M3KQcha3NckNdWrWFP/WtPbEwqx
	8VQjcr7tpFFufdG5wo2kRSfhfKbFLc305nuZYnR6vk0Dt0fGckYDxRxEp1CR1v8wz++UzhIzQyS
	0lUnSc7IqGT0b9NGlcct3f+UOfA==
X-Google-Smtp-Source: AGHT+IFEm8J+gsElnrGpl5/AfgJpxNbFJkyqHTQwSLP5FrL6G8Q/PWRkkGpoYWof6TTcLrgCKS59Y0YKNt96tu+LRgo=
X-Received: from pfwz5.prod.google.com ([2002:a05:6a00:1d85:b0:725:3321:1f0c])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72abdeb6e80mr73707162b3a.21.1735937160342;
 Fri, 03 Jan 2025 12:46:00 -0800 (PST)
Date: Fri,  3 Jan 2025 20:45:39 +0000
In-Reply-To: <20250103204521.1885406-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250103204521.1885406-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4688; i=samitolvanen@google.com;
 h=from:subject; bh=p7WWEhhYSoB9EsyiZb7zkPmioP1Ghg8VnlGqhauZXHQ=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkVPlnpVpoOXc0C/cZ2+8v1jIQnyB/b0b27ZNIizpV2c
 8q4BUI6SlkYxDgYZMUUWVq+rt66+7tT6qvPRRIwc1iZQIYwcHEKwEQqvBj+5y+O2LRUL8JY+r/t
 xMVdZVz762/Fz5ZabbyIUy1upvTvS4wMSzkbOCsj0t9dYRBYoVylenrSmt8Ghvtv/WitDmsMcM5 mBgA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103204521.1885406-37-samitolvanen@google.com>
Subject: [PATCH v8 17/18] kbuild: Add gendwarfksyms as an alternative to genksyms
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

When MODVERSIONS is enabled, allow selecting gendwarfksyms as the
implementation, but default to genksyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/Kconfig  | 22 ++++++++++++++++++++++
 scripts/Makefile       |  2 +-
 scripts/Makefile.build | 35 +++++++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 4637f063d0fc..d443fc504ffc 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -169,6 +169,22 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+choice
+	prompt "Module versioning implementation"
+	depends on MODVERSIONS
+	help
+	  Select the tool used to calculate symbol versions for modules.
+
+	  If unsure, select GENKSYMS.
+
+config GENKSYMS
+	bool "genksyms (from source code)"
+	help
+	  Calculate symbol versions from pre-processed source code using
+	  genksyms.
+
+	  If unsure, say Y.
+
 config GENDWARFKSYMS
 	bool "gendwarfksyms (from debugging information)"
 	depends on DEBUG_INFO
@@ -176,6 +192,12 @@ config GENDWARFKSYMS
 	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
 	# Requires ELF object files.
 	depends on !LTO
+	help
+	  Calculate symbol versions from DWARF debugging information using
+	  gendwarfksyms. Requires DEBUG_INFO to be enabled.
+
+	  If unsure, say N.
+endchoice
 
 config ASM_MODVERSIONS
 	bool
diff --git a/scripts/Makefile b/scripts/Makefile
index d7fec46d38c0..8533f4498885 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -53,7 +53,7 @@ hostprogs += unifdef
 targets += module.lds
 
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
-subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_GENKSYMS) += genksyms
 subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_SECURITY_IPE) += ipe
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c16e4cf54d77..81d9dacad03c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -107,13 +107,24 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(obj)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
+getexportsymbols = $(NM) $@ | sed -n 's/.* __export_symbol_\(.*\)/$(1)/p'
+
+gendwarfksyms = $(objtree)/scripts/gendwarfksyms/gendwarfksyms	\
+	$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes))	\
+	$(if $(KBUILD_GENDWARFKSYMS_STABLE), --stable)
+
 genksyms = $(objtree)/scripts/genksyms/genksyms		\
 	$(if $(KBUILD_SYMTYPES), -T $(@:.o=.symtypes))	\
 	$(if $(KBUILD_PRESERVE), -p)			\
 	$(addprefix -r , $(wildcard $(@:.o=.symref)))
 
 # These mirror gensymtypes_S and co below, keep them in synch.
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_c = $(if $(skip_gendwarfksyms),,	\
+	$(call getexportsymbols,\1) | $(gendwarfksyms) $@)
+else
 cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 # LLVM assembly
 # Generate .ll files from .c
@@ -286,14 +297,26 @@ $(obj)/%.rs: $(obj)/%.rs.S FORCE
 # This is convoluted. The .S file must first be preprocessed to run guards and
 # expand names, then the resulting exports must be constructed into plain
 # EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
-# to make the genksyms input.
+# to make the genksyms input or compiled into an object for gendwarfksyms.
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
-cmd_gensymtypes_S =                                                         \
-   { echo "\#include <linux/kernel.h>" ;                                    \
-     echo "\#include <asm/asm-prototypes.h>" ;                              \
-     $(NM) $@ | sed -n 's/.* __export_symbol_\(.*\)/EXPORT_SYMBOL(\1);/p' ; } | \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
+getasmexports =								\
+   { echo "\#include <linux/kernel.h>" ;				\
+     echo "\#include <linux/string.h>" ;				\
+     echo "\#include <asm/asm-prototypes.h>" ;				\
+     $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
+
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_S =							\
+	$(getasmexports) |						\
+	$(CC) $(c_flags) -c -o $(@:.o=.gendwarfksyms.o) -xc -;		\
+	$(call getexportsymbols,\1) |					\
+	$(gendwarfksyms) $(@:.o=.gendwarfksyms.o)
+else
+cmd_gensymtypes_S =							\
+	$(getasmexports) |						\
+	$(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
 cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
-- 
2.47.1.613.gc27f4b7a9f-goog

