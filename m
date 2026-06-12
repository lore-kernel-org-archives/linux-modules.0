Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E0388E48
	for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271109; cv=none; b=Th4RhDbDujb05nVZJZe+R0nOtfDrLqeY0B0eOm94InpuIxBrfR2yIO4/rd2wgJwBQVQ86AD55vIzG64G8d2CXN0hyN/Hw7i82aO6ywkytZVxT/oRCfA8i5es5v/hrhkxlwcfHhcYIQcFMmB0SXXFj/Omt1TAWouCZtCsjPWAInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271109; c=relaxed/simple;
	bh=85pGD/SUlttaKHV1Ui3Gm8EMYN7jMIzcuxHQpAxTR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcET62BPGl1n3V7Ue3AEEnAej9uaPH0AW8QOBhTMxPH9Kc/PC3VKfNtWBTQCrhVmiwK7gUZOQnlDcMbnfvDlPoCsx4T4CZr/h46RqqaNd+MuNUPVtNmEkBdJp+pFTvX8HcwuRMWC57aMQtOXDOdeBbQTFsBSbNoRvqT6BZ1Pgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XenTTzJv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XenTTzJv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6780335e9.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781271106; x=1781875906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHq2uwDGJgB0qiB9weh1rH/HnAsP1NxbR0PVnQr+Mc8=;
        b=XenTTzJvrbv0A8NSiN3IKlIo0GHEzz2ebH+qcUzljTa9G7MUA2u8/bvhNEQ8E41/Na
         YnDN4XtxKZ445kXED7gveNXF+y66zF3vjKEwYHsX/Chx3chWqwGLgMagD3St4k9KwOpF
         juar1HuXeb4bAI/0vPHxpnsREbkI6hMnAFwYiRoyNJpuGj72e3h8ZRwlaThoMfAg7EPm
         APjDq7zZ3y/UgsG3ZZ05+WO65dIcr6E4xU4hsD2TERtcuUHwAUlyEx4zfq6H8WKaI+J+
         aEWivj6bccDvRyQdxVjuOEKdbQaMna4/PbGO7IiujIdEjL8SIb9GJJN/3+fS5qsonCeB
         094A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271106; x=1781875906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHq2uwDGJgB0qiB9weh1rH/HnAsP1NxbR0PVnQr+Mc8=;
        b=iwzW7g0xLmNp5ylglc5cQ1N8GUUYUdr0yP3LPhthClDpwUklEP/qAuzuZxuS83w/yl
         876ber5gonRzZ/5yZtnDYI6R1IHbqNjUJpl35LrqCTsebsFpN80h5CRTlBHFZZFOZA83
         hza8muZvzExkaanoNfW54BtVmRxw98gVc0ndKwGhIsBwQLrHVU43l7MMjYINAVtHwnSc
         E5kTKV59/zX+wwWUoAT3jE6G2uHOfrrxptHRc/nwoeBxQNQxwmlJ5diRL53lROKm+LWu
         SnYcLL3GPpcMhIP4rFa66yb5fD8S3vm/8gllAOj+ce+Y+D9QU1CFPtvthMzwGmS+Kav1
         f1dA==
X-Forwarded-Encrypted: i=1; AFNElJ91FGCibOKSE0Mzpu+3z+wcq1enzeuSCdmisZCC2bmtrqQrAENkpZpg7Rxu2OsIvIaABUwoOctG10TEKJgN@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPiC7y2u+HascDv4rcWpwqEYgNVO1DvU6dGw1d6+hb2vZJTNd
	b8cVzE/il9SMUybS13SsWE9tt2EoSxATHSkt5cCAGhdprNrgT2BuroSnkZfAV+r3TN4=
X-Gm-Gg: Acq92OH9g4USsk5eFC1S0q0L0JzU0e8qFXj6wkRT/2bxgBaU4hyXTc5xtB5FbvPwPt+
	AcI+O5N6+TBjLgH/83hpgBLnAGddSeH5Sb4R27kDPcrWcwjTeyyL860LpmA8xJjF3tTet73nxGA
	P1YUkwDh0TSRb7/jTxN/6ejuceRYfoGjadLAFZwC/aa930oR8RZra6qHEAMsOuPpmRRGR6bOyFw
	YjMj0SgMZg6R8gBcnrlJgrt6SJOOfOhoVoZ/uIZsQDmq1fVC+osYk71SfGXuU0oXeXNpu+QvqgU
	JLcoEwy2W+EgiGge8/NS7jV4QyTrJ0V9cBThq1CYHSijN+bEdSAhweQaMGPh+Hm0t1dkn93dqvg
	MhwuDxVByD1YH3G4STGyPAEI4eMMQbA3+hzAzluK2davBuuYawnSH2PVivGRXALbxC3E4W4XY+z
	muMdHhT2JpfFt3PLLpXUjOXSQWPJUS7xMi
X-Received: by 2002:a05:600c:c1d7:20b0:490:6237:521d with SMTP id 5b1f17b1804b1-490ec4b186cmr28517655e9.13.1781271105722;
        Fri, 12 Jun 2026 06:31:45 -0700 (PDT)
Received: from zovi (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm6222674f8f.1.2026.06.12.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:31:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Peter Collingbourne <pcc@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Use --force-group-allocation when linking modules
Date: Fri, 12 Jun 2026 15:31:37 +0200
Message-ID: <20260612133139.1919042-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specific code, such as outlined KASAN checks, may be placed in
COMDAT-deduplicated sections. When linking modules as relocatable files,
the linker by default preserves such groups, potentially leaving multiple
copies in the resulting modules and unnecessary group metadata.

Use --force-group-allocation to have the linker resolve the COMDAT groups
and place their members as regular sections. The option is available from
ld.bfd 2.29 and ld.lld 19.1.0.

Remove the workaround in arch/arm64/include/asm/module.lds.h that was added
for the same problem but limited to CONFIG_KASAN_SW_TAGS and .text.hot.
Note that this code currently has no effect anyway because all .text.hot
sections are placed in the .text output section by scripts/module.lds.S,
since commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
related macros").

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 Makefile                            |  6 ++++++
 arch/arm64/include/asm/module.lds.h | 13 -------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index e156e2696efe..1729af0690b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1189,6 +1189,12 @@ KBUILD_RUSTFLAGS += $(KRUSTFLAGS)
 KBUILD_LDFLAGS_MODULE += --build-id=sha1
 LDFLAGS_vmlinux += --build-id=sha1
 
+# Specific code, such as outlined KASAN checks, may be placed in
+# COMDAT-deduplicated sections. Use --force-group-allocation to resolve these
+# groups when linking modules. The option is available from ld.bfd 2.29 and
+# ld.lld 19.1.0.
+KBUILD_LDFLAGS_MODULE += $(call ld-option,--force-group-allocation)
+
 KBUILD_LDFLAGS	+= -z noexecstack
 ifeq ($(CONFIG_LD_IS_BFD),y)
 KBUILD_LDFLAGS	+= $(call ld-option,--no-warn-rwx-segments)
diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index fb944b46846d..792a0820757a 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -4,19 +4,6 @@ SECTIONS {
 	.text.ftrace_trampoline 0 : { BYTE(0) }
 	.init.text.ftrace_trampoline 0 : { BYTE(0) }
 
-#ifdef CONFIG_KASAN_SW_TAGS
-	/*
-	 * Outlined checks go into comdat-deduplicated sections named .text.hot.
-	 * Because they are in comdats they are not combined by the linker and
-	 * we otherwise end up with multiple sections with the same .text.hot
-	 * name in the .ko file. The kernel module loader warns if it sees
-	 * multiple sections with the same name so we use this sections
-	 * directive to force them into a single section and silence the
-	 * warning.
-	 */
-	.text.hot : { *(.text.hot) }
-#endif
-
 #ifdef CONFIG_UNWIND_TABLES
 	/*
 	 * Currently, we only use unwind info at module load time, so we can

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.54.0

