Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DC1C232A
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743590; cv=none; b=Oce8Dyd6Bp1rFOHFdUbyZ54dwIzMyuG6E9YBVFdTGgWzLi1fwmmZUc0VU+8ZPob3YU+gpOsvQ0BurQ2uza16ypBJo7Uex5y7YX4RVggheZhxce6N0AFT1gKBmvVXRLjW7WAfC29OZl1L3XGyQVY1mZh8m90Y1jsHIKgNOUM76LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743590; c=relaxed/simple;
	bh=mz7nffxN7wId2ePyNyx2gbUj67IvJCbAVk8B4r6F3JI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0NavwamnOdU3/54ys1Rax638Fn07k0TBkq0UB4/2TO4eI3LjcgEZ0yzgWvLT/PYXstGlzRQGjv9pkz6FfMc0XXWnXk2F3O95zT2zzySEJuR3C1TtgAJLQ9k54Z5xxclYKun6zyKoYqr8AZVPZPYcdo9gjmpKzEL8AxcdpI55k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnEwPMPV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnEwPMPV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a2787eb33dso965685a12.1
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743588; x=1724348388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHfKDENnTQm8ek88L2arGqWCp64m5+2eabNApwrdQWY=;
        b=LnEwPMPVbeoeSua6GvHxSbd3y5TvC2a1MGWzskd+CAB2jSmEQa8CFFFLIy6KQf+stt
         KPs5p0wata407FkfAeh+TrsfxbWSMeVI47oY0UtRDCZqEkGG6Q8vomsxLgPcEhS+jubq
         DP3IXpU2WOeva7q8t6nABbuE9Gfz9CnfTizVomTQxZeCV3kG8+C1O8BOP7R0PQgsNas8
         Cgf1NePbfo6Gdc46iUvnj0rLIXoed2aQPAlwNYtSONobR4kxE/8lkvpbQqwJ9jvpguA8
         LpNKXd25NKk0vS11OS8q5sM4XNjMrpkOtuRfyBXjVvcRctbXRpJREZ4butLsRUR1ktIY
         3ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743588; x=1724348388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHfKDENnTQm8ek88L2arGqWCp64m5+2eabNApwrdQWY=;
        b=uQ3dUk9/2LyaB9FTGq7yRXiTuAz/MxyRpnnUzAPVsTYpdLgBDqILxelaJqHnL7yebn
         VYUYYdtZjoDfo/F27Lxmn8/WUU9Jl6mnb0Oo0BT44Pm8qzxdj9ZDWtXZKDViAti+Ub6T
         uuHam6QSXURCnDCeOriyVYcbzQadca3+e0gIXXLlR3itb/bxGE36uTTbT4VuhVwCJ2DT
         7rhKruZFdC0evuKovsqC9dkJK9SC0+w19NffMHiKVl7lYysdcV+O3aYjsvbDT++T8SoY
         4ZGyp4Mzll4goLbeaJ0oJI2QNtk/nrM37p+m9fzi6Kx2n1BUAfDr7xideP9v7rQRcDbs
         qIeg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Eo7g4XcUs0rthlGNox7bGt5QwAqKW/lJK/6cpkayT3y/WGVgpNv/eYBVZMqWv6FUjg+6qCtL26oMY/VCaTudO3yq/qt080bQEWfRBw==
X-Gm-Message-State: AOJu0YxLKPhLRAVgu3TpuE/46tZyHbS0WXfW0I0SYijMRf/PXYeN8PnR
	cmABVz8zwce7iEnCd/BWZCGrx6XuAfzvijmFe+52XCCVXF4/BKD32y1KFZbKp+Is6WZnJ/VU2Td
	6Rh2RLcALw3dSkXBg+EeElc5zpw==
X-Google-Smtp-Source: AGHT+IFTAkXFaRwAV/SQwqCeTGEycib4FiTINhjKTaFPZbrPJmJ+KMbkdPWYs8+NjnMSf4VPl8XwcMRzylf5jVza6Gs=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:af1c:0:b0:75e:cf19:8f83 with SMTP
 id 41be03b00d2f7-7c9796d8a56mr125a12.3.1723743587293; Thu, 15 Aug 2024
 10:39:47 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:23 +0000
In-Reply-To: <20240815173903.4172139-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4761; i=samitolvanen@google.com;
 h=from:subject; bh=mz7nffxN7wId2ePyNyx2gbUj67IvJCbAVk8B4r6F3JI=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj06CUaKOoKTE/x4zhmMUl5+xK4VKhS9egsRZ
 EV60/RxPFeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49OgAKCRBMtfaEi7xW
 7rzZDACSD3JRn+H/NSXRZE7PImLTyCeLXiFaUKPrqH9OX1i0VZRE+Ujk3Fwuv1EQvYxnkTXOGSQ
 4pzHAXhRMgHLUw9Pj6WaFvL15HccicXnzBlDKBCRbchKw1xRa1hgd5BD1dOVLal2i2yGJ5wjWj0
 w7hogl6gH6uVQcLpDQAhAGHCzMprB+Joyc/Yp+xwhcPTqCWeElf4fcBwKR8i+IpLf9hRgmG6p6y
 AqDez4vPKDD85j4xvlyhkuasvReQEsWWB3j/2swrrMVBprrGZnIIje8us1UinjDhg521N+mtV5X
 WWIOKRhrhCyv8kmHEKUOgoBp2zNSJEGIimSkz/3s7lrkIrlCdwmFsd3vgNEMbaS5mR/AkgDcqyv
 5XaOmdjdfTVLCvqAPWx3Px2kXJ2M1bx1VAZNuzXWuQPsCaMOWd9yEpuyXnor1R7Aoaw9hG6nYHy l/aa9uwh9DOgnzHvAaeyx1TKhEx+sIF5Gh3O3D2TvLFWr5TNOv0agadESGCu/jUR5jhUs=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-40-samitolvanen@google.com>
Subject: [PATCH v2 19/19] kbuild: Add gendwarfksyms as an alternative to genksyms
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

When MODVERSIONS is enabled, allow selecting gendwarfksyms as the
implementation, but default to genksyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/Kconfig  | 25 ++++++++++++++++++++++++-
 scripts/Makefile       |  2 +-
 scripts/Makefile.build | 34 ++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index a506d4ac660f..80b2e9b0596b 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -168,13 +168,36 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+choice
+	prompt "Module versioning implementation"
+	depends on MODVERSIONS
+	default GENKSYMS
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
-	bool
+	bool "gendwarfksyms (from debugging information)"
 	depends on DEBUG_INFO
 	# Requires full debugging information, split DWARF not supported.
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
index 2fd0199662e9..52db4f1f37c4 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -53,7 +53,7 @@ hostprogs += unifdef
 targets += module.lds
 
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
-subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_GENKSYMS) += genksyms
 subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index efacca63c897..985e4ba7b813 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -122,13 +122,22 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(obj)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
+gendwarfksyms := scripts/gendwarfksyms/gendwarfksyms
+getexportsymbols = $(NM) $(1) | sed -n 's/.* __export_symbol_\(.*\)/$(2)/p'
+
 genksyms = scripts/genksyms/genksyms		\
 	$(if $(1), -T $(2))			\
 	$(if $(KBUILD_PRESERVE), -p)		\
 	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
 
 # These mirror gensymtypes_S and co below, keep them in synch.
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_c = $(if $(skip_gendwarfksyms),,			\
+	$(call getexportsymbols,$(2:.symtypes=.o),\1) |			\
+	$(gendwarfksyms) $(2:.symtypes=.o) $(if $(1), --symtypes $(2)))
+else
 cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
       cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@) >/dev/null
@@ -324,14 +333,27 @@ $(obj)/%.ll: $(obj)/%.rs FORCE
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
+getasmexports =							\
+   { echo "\#include <linux/kernel.h>" ;			\
+     echo "\#include <linux/string.h>" ;			\
+     echo "\#include <asm/asm-prototypes.h>" ;			\
+     $(call getexportsymbols,$@,EXPORT_SYMBOL(\1);) ; }
+
+ifdef CONFIG_GENDWARFKSYMS
+cmd_gensymtypes_S =						\
+	$(getasmexports) |					\
+	$(CC) $(c_flags) -c -o $(@:.o=.gendwarfksyms.o) -xc -;	\
+	$(call getexportsymbols,$@,\1) |			\
+	$(gendwarfksyms) $(@:.o=.gendwarfksyms.o)		\
+		$(if $(1), --symtypes $(2))
+else
+cmd_gensymtypes_S =						\
+	$(getasmexports) |					\
+	$(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
+endif # CONFIG_GENDWARFKSYMS
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
       cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null
-- 
2.46.0.184.g6999bdac58-goog

