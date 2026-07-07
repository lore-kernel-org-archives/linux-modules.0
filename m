Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896C3EF650
	for <linux-modules@vger.kernel.org>; Tue,  7 Jul 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438730; cv=none; b=odT58MvSjIBO4heu163l9TO2oB8kLPeb1WO2ZH7KrSnHWT3wIonJ7MLRBQCgbabNxFM3oQ5q3C9DKhtrDuJdFCCvjV86zAd9LUJl6SgYw6MB22C2a9XFgoRRKEyfbFLIrUQ5p7KjJjwjA+2+B9O1qEM8yJIljGoQ2UX9n0T5CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438730; c=relaxed/simple;
	bh=SO5eeYPZCjDEPtTUp5vp0e259QcOYfs80Q/ywveYhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKgCwSTV9M4UMZIAlduy9IPehhzGsmm1bsOOrTUywat31M2loE27mA73q8xjGcIq86fiUqLxQpGVgluF+slWz9xuSrv54b7438jB/G8L0fNP64eNkPcMpGjPQJap6OZMuMGHHxIVu8dVlG1VMbpmbU0VUae5tgR1W6UHIVMNwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sp9zBXEN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sp9zBXEN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b966dd74so15256555e9.3
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438727; x=1784043527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=Sp9zBXENbXVuk4pLgRwA07DY1fA0U6i0d3KsNaU72qPMjeU2lUQT22MYYNGI4URgSm
         nY81jVo81RLZKV+DKwjmqbLwJmsvYBVbeVme/Y8/1KVyMcWs6C/v4AaybK5TZTnTs8N3
         gjFrmikadN4ppXMuG830cLNTF4XyPPjyWCqWfKWAo5+YfRtnPzn+aySjEZX4ue4xHIoP
         nl2EXqQRhZvTM0XgjwtH2TwRTkJOPMlz5XyoV0gTsK4SPgIEFlLvRvQ72bttphGenVmN
         YLjEDYih/ME9p7n04hcodUY9XKoptFyC7Y8iiVvkZlS0WZlJSxJIzrNaQZXcHr4X7ke+
         m+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438727; x=1784043527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=DHnKMy8qRJds3V/0mOawnICGwTwiBFqQwXDqmwz9XCxXMnkFU2sxKTGRMVsgqcTlr4
         d9D7LfyBPQDgqzdTgA8B5ABV0Avk8+MqIWqzAGd8psMWV0I0Uy5WTAtorM6gqs+DF7gj
         u6olpVkzCPekjRBYc9n/w1Tq9W16Sze0zmShSjS7RRDdQmBBQiZUomtEdk4UALjpHhUh
         hiWFMoGYRe70oL0J9bUZPgi0Ar7h9LSrkzcLxw7Zq7g6vAfvWqG3UumGlp0j+h0MXnhl
         YMr+vT8ehwVgNUxvJkzY0r75GjQKK+diNmFALmBY/1gcQACAKyA6FHIamF3Kme+fHCkh
         yb6A==
X-Forwarded-Encrypted: i=1; AHgh+RpSsVIWi6mtdSaxkfzOjaAGyLGLAydHJBefOws6V7mPfV5KC1Cczb1l+kz7tkEfEGgXIjHkrK97FtJ1tAYu@vger.kernel.org
X-Gm-Message-State: AOJu0YzwM0srU3UAD0ssFuoezNMkXLyTWUbfBdcDKKhhTQxN8xO+glyO
	I1pqxYigdXU4WYP3X+4eOlYt/kFJI9eM/MP1Ry8QueMa9R/m4nh+Vx4t+FerRtbRdDA=
X-Gm-Gg: AfdE7cnDBhKtrxCbO/Qd6YUuOBwBZSvFxs4WpTJThO97gEwo6Jl5Vp+OLQFbvU5l3Qn
	DeIDd53NVxW5VcH/NoCI7de4IgMNtfQF3BGQpsak2uIwunSaBkz+/v6YSsN3TuAO9SZQ7iD8dMl
	pGMPMAkwFKUizEjRar9TtKWP8SEFNSKTDhKWzBG4ioBxIp6tHsKLi0svQ4f4qAyE5mpG+rbiRr1
	+nuzUu1NPy9X0WR4yIvjOsTpei/e9dyUE/1szSaFXcRmyk51aPRHkvg6f7CvK1Quo6Ch7HobV/l
	H+IcoZlci5IT4+x6TbAstiEcK8rUJNEb68Pc9eYXOKkWnuwBzUaDk0C+iNB07/6RglW/1bSEyAU
	Jawq1evZMbLmSFIC1mttWuSy1EPyy+FkvVy83Ka85PFMpTmxrmKB7OGgfs4WPhBLC8i3cHsfUV5
	nVESqiB6vV7PDPWPLXmoBJlEotyZFbjeJ9MXnuRZpSUriL3HTzGTlTW8H3sY/jJFkpMKjkqmcX2
	Vr63wdsNjlsVw==
X-Received: by 2002:a05:600c:810b:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493df080788mr55474505e9.34.1783438726830;
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:04 +0200
Message-ID: <20260707153819.4172541-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several x86 files use ELF-related declarations and currently rely on them
being provided indirectly through linux/module.h -> linux/elf.h:

* arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
* arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
* arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
* arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
  elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
  linux/elf.h,
* arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
* arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/entry/entry_fred.c  | 1 +
 arch/x86/entry/syscall_32.c  | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/process.c    | 1 +
 arch/x86/kernel/signal.c     | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index fb3594ddf731..ea3bb4298065 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -9,6 +9,7 @@
 
 #include <asm/desc.h>
 #include <asm/fred.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 #include <asm/syscall.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 31b9492fe851..12fceffc99ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -12,6 +12,7 @@
 #include <asm/traps.h>
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index abb3984336eb..18cf40f08557 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -17,6 +17,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
 #include <asm/cpuid/api.h>
+#include <asm/elf.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea..8b90bf86a742 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/elf.h>
 #include <linux/mman.h>
 #include <linux/kvm_types.h>
 #include <linux/nospec.h>
@@ -26,7 +27,6 @@
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
-#include <asm/elf.h>
 
 #include <uapi/asm/elf.h>
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 85435044e33c..e40f7f3d3489 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/mmu_context.h>
 #include <asm/msr.h>
 #include <asm/shstk.h>
+#include <asm/elf.h>
 
 #include "process.h"
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..0fe2d7a6b1af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 
+#include <asm/elf.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
-- 
2.54.0

