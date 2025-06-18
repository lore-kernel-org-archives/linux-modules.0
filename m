Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138D2E54AC
	for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251059; cv=none; b=Qrr58FT4Qv6JcuzyAQjdmiQZUj/FOH7f1xKgjXAUBoDcWgGfYA7dKWe/HrBO0jZnVZOhNZXzTHDcs6I9vb3u6e37RMKYnbRXkEwnP+cIcwUQMDVLf5wE+5pI1PWqWqOCTZFUSIaSHCv76Heoc8mtMIkDw7d91CwV3etVjFCIU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251059; c=relaxed/simple;
	bh=tYOMqDbBl4oLeXidO5nb93lks+dyLJ+aBvItgw9rtgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuUW5z9/Wn3zzL92/BQoYuKx6eTTwgtTU8UywME6eCRpBoCG3GOVWXR8rYdPT0RzIYC4/0ArPaFWyJvmeDIAOBPJ9sTEmso0t2Y093q8sBPNT8DX2fdEHJyJKpeeBB2YESRP9HaNJOZRt9PqNq23lmWIRNON04IFuK4CEnEh9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPe9HjW+; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPe9HjW+"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-451d7b50815so58001445e9.2
        for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750251054; x=1750855854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NbQn0+rtk9R9UQB3ZjUl1RmfRkgy76SQGVXPRmwvTI=;
        b=UPe9HjW+MI5cyVjjpsICuwdZ2B5jBGdvbqYjo4twPlv6+X6SoV2cBale59/gdLYETv
         FnVxCS2nBlDCPMPcZGRkVhfScnQ2yynWP5pSEyOLWVQbz4Kj/Dtb2IHmswwSa+X+7ZYz
         5ImjUD0lWFXU16l/co3EqkpoDwrJDdLwEOiJ/8dVCkS2gpgQureiVNGls/WqfaNIbVHF
         Q8KblZ+uIIDKwZs0LtG1sDgnk2BzTtA6V4GF7s8vVFXqRyLEHm8+goArXxuEiSRBsxS2
         cil4qfKe+Z5kYcq2+jrhRbZotmdf/tIRUE/iYjaKfswyRUIfZ9LxNN6q1+j9cKDQB69P
         bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251054; x=1750855854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NbQn0+rtk9R9UQB3ZjUl1RmfRkgy76SQGVXPRmwvTI=;
        b=olH/GH1PmGe+OKGZYxYiaG24kmRl9ybB5P01tVEKIvnDz+q8QUcpjUXldA2aHrhEp8
         dPq94xK/AQcvhxvIs1tMuqzrarRTJMACRAEC/oqWOfFHeyE/QhpNCvjn/b3Gs4eWVZyN
         e2LJVSZd331YSPgLjAjVnVnwLUbRD8Wvxn6WEBUcvxJg0xMXXiV4kO+ZOZaaFV4+VQGX
         Oiita6wBtznZ2F0m9BXr88gxZ3/8pxnwYzu6hnxyAIJ5HyPzSVISCCzR+azMmOHIFjZS
         wjc7cYsw6gqfpb8eg1OKd5PVODbSeddsVwWiVjcKCMud+x93xGunc8IwUfU79C3pBlc/
         nfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJbQUerH2wGP7+2GomPqTpVMrwv1PlgHE0CpFePEvZvpNqbkuodWreB1P0RA35O+lS5JqWhriBqtkD2ia@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FbxCzWERaI0oRnaKBQCsLaBwrqMNfktFMPG6AkR4RSE+TmJp
	mIcevlenvLGQmHS/rKXe2mfGM4jxEd3NrRBrzIGpHC+qnnLtSB/SKmPEYVZYa2CO7VQ=
X-Gm-Gg: ASbGnctiIdaxT33470bRD3ozbTRveK6HUjYO2nNo1oqfNwrChpVQHcqMyfOQX1BpyRq
	xueUupDJI8C9frJuU5O6RYA6Nd8V+ZR8hkkpBA9NwmtTTv3O0pkEJOe6corQrceDxKRYVmIOsnH
	wMl6sMauev1qZYSJp/FJWQE9S6owKQGM3U1/+O/ZaL72tbV6gE8zpGhjU3eZ1K8aCgdAFBY14oy
	7qqpLPpQ+WXsOJaLNcr8vD9081OSyH2seWwLpUohxxlquyMm8fWJbP9D5ovITCtC6SKpvIJ0AEh
	cBNZP2vhHeZW6RWfNabR4eDMr30EjI3YfYAkFpUPzPz4k+wC+cdLlF9RgYvnAA==
X-Google-Smtp-Source: AGHT+IFEWHAu8VwBRrGTbvGEGcd39Os4PAnx0WLvaMN2iQm+8pQRf6KkKity1k65/583ahjCju2ddw==
X-Received: by 2002:a05:6000:1a88:b0:3a5:2182:bce2 with SMTP id ffacd0b85a97d-3a5723a2928mr14371409f8f.17.1750251054051;
        Wed, 18 Jun 2025 05:50:54 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453599c9854sm13143435e9.1.2025.06.18.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:50:53 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Chen <cachen@purestorage.com>,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2] codetag: Avoid unused alloc_tags sections/symbols
Date: Wed, 18 Jun 2025 14:50:35 +0200
Message-ID: <20250618125037.53182-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_MEM_ALLOC_PROFILING=n, vmlinux and all modules unnecessarily
contain the symbols __start_alloc_tags and __stop_alloc_tags, which define
an empty range. In the case of modules, the presence of these symbols also
forces the linker to create an empty .codetag.alloc_tags section.

Update codetag.lds.h to make the data conditional on
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---

Changes since v1 [1]:
- Trivially rebased the patch on top of "alloc_tag: remove empty module tag
  section" [2].

[1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/all/20250610162258.324645-1-cachen@purestorage.com/

 include/asm-generic/codetag.lds.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index a45fe3d141a1..a14f4bdafdda 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_GENERIC_CODETAG_LDS_H
 #define __ASM_GENERIC_CODETAG_LDS_H
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
+#else
+#define IF_MEM_ALLOC_PROFILING(...)
+#endif
+
 #define SECTION_WITH_BOUNDARIES(_name)	\
 	. = ALIGN(8);			\
 	__start_##_name = .;		\
@@ -9,7 +15,7 @@
 	__stop_##_name = .;
 
 #define CODETAG_SECTIONS()		\
-	SECTION_WITH_BOUNDARIES(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
 
 #define MOD_SEPARATE_CODETAG_SECTION(_name)	\
 	.codetag.##_name : {			\
@@ -22,6 +28,6 @@
  * unload them individually once unused.
  */
 #define MOD_SEPARATE_CODETAG_SECTIONS()		\
-	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
 
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */

base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
prerequisite-patch-id: acb6e2f6708cd75488806308bfecf682b2367dc9
-- 
2.49.0

