Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311E3806AD;
	Tue,  6 Oct 2026 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325113; cv=none; b=CTeyKeOAKHYs7BgQ2l74AeGo5uaVfs87qP7vpE4+AbND31sP32NBbpfx1Me++MwjiKWTRqqkVQKBNCvqHD2NGsfzsOwltIHsiVqBPsR16zSfOZ6F5LqfcYW7l/IWFgDeqeJ57+IZdXbCAWhHcDGQfl/YvcjxP0HAY1fwb4krVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325113; c=relaxed/simple;
	bh=fYd+ZgGcjjbOpEQfH2CwcKiMTrSZUa4AV4L2gsdp5PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEUCWf7yNMpJCNlDVNd4Tq8vFFyEk91kMTOJ50Bgu0vpLNnUlnWqqFkL7xgf6tr0Jx+MM94dnfJKr8Jn9O82TzJeBgAhU1egvW/N6i5tm5bW2wbu2YHWRBMVT7hRyaUAXiyo1EWP3joVSmU8N+plkcJFFxsklZKJHJfzVn5S8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pRraBkPs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pRraBkPs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D059C15A1;
	Tue,  6 Oct 2026 15:18:26 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB9453F66F;
	Tue,  6 Oct 2026 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791325110; bh=fYd+ZgGcjjbOpEQfH2CwcKiMTrSZUa4AV4L2gsdp5PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRraBkPsnTOuIN8dTICkVAToowKbzgFM5SndvHM5LGFaa5F76muC/rmV04iUz+V5/
	 O5wwD9njsMO6ZhisOZeOBibFeUooWAwovDpdewRDfbstNKumfIBBP/1qviiAbkXMsU
	 DAYo8yb54Cg/2VuDFlGOwkGa7daDIBwMmV/EZM+w=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org,
	broonie@kernel.org,
	jpoimboe@kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ndesaulniers@google.com,
	mark.rutland@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	ardb@kernel.org,
	Emanuele.Rocca@arm.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 2/3] kbuild: modules: Build and trigger BTI scanner for arm64
Date: Tue,  6 Oct 2026 17:18:14 -0500
Message-ID: <20261006221815.2823252-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261006221815.2823252-1-jeremy.linton@arm.com>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Now that we have a utility which can detect and correct missing
landing pads, build it and hook it up to scan during module
finalization.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 scripts/Makefile          |  3 +++
 scripts/Makefile.modfinal | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 3434a82a119f..10042d5d1251 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -8,6 +8,7 @@ hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
+hostprogs-always-$(CONFIG_ARM64_BTI_KERNEL)		+= module-bti-check
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
@@ -32,6 +33,8 @@ rustdoc_test_gen-rust := y
 HOSTCFLAGS_tracepoint-update.o = -I$(srctree)/tools/include
 HOSTCFLAGS_elf-parse.o = -I$(srctree)/tools/include
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
+HOSTCFLAGS_module-bti-check.o = -I$(srctree)/tools/include
+HOSTLDLIBS_module-bti-check = -lelf
 HOSTLDLIBS_sorttable = -lpthread
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 01a37ec872b9..973adfa72a7d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -32,6 +32,12 @@ ifneq ($(WARN_ON_UNUSED_TRACEPOINTS),)
 cmd_check_tracepoint = $(objtree)/scripts/tracepoint-update --module $<;
 endif
 
+ifdef CONFIG_ARM64_BTI_KERNEL
+quiet_cmd_bti_check = BTICHECK [M] $@
+      cmd_bti_check = $(objtree)/scripts/module-bti-check --fix $(KBUILD_MODULE_BTI_CHECK_FLAGS) $@
+bti_check_dep = $(objtree)/scripts/module-bti-check
+endif
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
@@ -47,8 +53,12 @@ quiet_cmd_btf_ko = BTF [M] $@
 	fi;
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(bti_check_dep) $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
 	+$(call if_changed,ld_ko_o)
+ifdef CONFIG_ARM64_BTI_KERNEL
+	+$(call cmd,bti_check)
+endif
+
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
-- 
2.55.0

