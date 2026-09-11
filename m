Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B375364940
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137768; cv=none; b=sM1U8qZPaeD8HV0VqFOmJgx5ckxLwAmhfLe1lNhHWDst1oXl/qeYVO9yYVrkf5AnyZFjNwa8dnn57RMe4JVXqMwyZc30XOXWLSkB/LBhJ2089sVm6xJQKL4/tKaSkcpn/Z8Dlswy0mT35NJpora9g6uqIwkr/nuCCuEho9kl0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137768; c=relaxed/simple;
	bh=q72VP5n2ZqcEGQgXeUc2xgK/v4cYAsj+QPvCunTuwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IdyJeV7uX2TqHEAycs7+rRIV8U9FFb5e+lSPQCAc/FXjzccITJV1hyiJz/KzF7hFHackM3/8iTiI4ZJN3ASl4/tK1LtDdJWZNjmb48WnphrvUlVMYDbLu7lyPo/9tdJZPoZb3xlVLyQAgkcOXr4cKMAHKN2S4nPd8tCHcRi/E0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oa3P+L8h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oa3P+L8h"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso12235045e9.1
        for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137762; x=1789742562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtpnUSLeT4ed4dWoaotfN7ey6FZzLAllCqnmIx1g6CU=;
        b=Oa3P+L8hS5uNkz4niILTnDU6g1KqJOSl07IepB97cothgdPCtzuCqnHr/Ris3t2ZR8
         sGkTWTi39H/kGliiNFSxa0pUXav5NACiZBUbIZqFUI13DgVISvAq88kOck1kbYFi11tk
         s4sImAXrp0+0BrBPFV/bgoXbfYPSQ2U9tgUBOoKcPrjPzdYEpkQ8wEGQ4piPm1CBnpGW
         R2CENzSyKArysWyQJOek25TAS9jAHzB1dD5oxZNEiOsAc6HGliIqUVV7lpvk0PnnfgQR
         HmYYuiyKuLCBKsQJkovTAhy31kk/CGgXmHzLt5NI98yDOS9OC9W6h6M8cThDQ67eYvP3
         dvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137762; x=1789742562;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtpnUSLeT4ed4dWoaotfN7ey6FZzLAllCqnmIx1g6CU=;
        b=fHCxvk+QdMNxPxE2UHaAEAGzT3NIq4OGlW3O0mp3scIt4nISt85wTxCmW5YrSdWqWc
         QTb3iq9n+mltMFX4WSn1piZ5v07J88CoPo2v58dQtUPvaO8EiOJjCbVithGvTPFMAIlg
         vFlsS6th8lYPWw0xWPvtDAbMRg7howHWsn2JuLgGisWVJCdjX6IMmWhkV9ZurLIduKD9
         7CT2bYp2fmlkbFt4PcEyh/AVpmXDCd0Ei8jUbqhXiW9QakLbXoorbQ2A9bD3JeC6F0+m
         El79j03eAz9MK7jy2PD/KomlExEELwR+QDjTRIHVNTNO/kmA49fbkHyTSZzg55oQKcMW
         u0bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbxg019TfM4xCelKdKKKoCAm8E4Mc0F/QfC9sU+aMIV/y8g4KiHr5rEtoVWNBs1RHqCgdqyoOjj7S3bY6n@vger.kernel.org
X-Gm-Message-State: AFuF++kY0amc6+RxqhWcQew+f44Le4Z7v+t24QF4KEQ0pNZRbUHr/9nr
	a2T3DfuuDY7niWQvUbExeXL+FVcVo9b2MMG0dg5l3FmUkFDrYl/E4ajlDIh+ElYsyHA=
X-Gm-Gg: AYBFou33XDkof4mwlo+N4dNZfIpvAdFMRYDd4xi4jiIUWlihaPLMw22b9j1kS+rn1dZ
	30uuqEnUNupfOQufpbLxpcKAQKE7Cpntjdne8kCtv2j1ITMm8DeMG1y3onyz3Ty9l7johfy8PHP
	qpqHgozW36/9LnKFB4omXjgwv1Dwc8leGRPBUzXlip+CPm0qZ4NTmCu+57PC0Fs/hH6dlwSstcO
	8F4mEKtLl0T4hfep0yQOPIpwTaxWTr/3jRE9TX2epJXBMg7Ia1qyld6txJO3eBd+L893iC+Eds4
	eqOuoCNKh2nXTssC7ThYhsJNJtCvkPMCv4lXQ57XwpHdcGNelELYAroqF/FVFMJH7kKt5qBE74+
	X8x0V2kY9Qb/wgl0viUroUtVzvqHwupbndgMZNKq9s1AZZbegWoF+1HSXWghaYB1UNgV2EuOxVd
	fQhceE3CsMLn6iAorVxKv4yJ81kZ/tlhlmaDTljGeqEnZZtntjLMzqfk3AFdVkxebE2QeqBR2d+
	h8ssA==
X-Received: by 2002:a05:600c:1f8d:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49e6198933cmr55970145e9.9.1789137762240;
        Fri, 11 Sep 2026 07:42:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:41 -0700 (PDT)
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
Subject: [PATCH v2 0/6] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Fri, 11 Sep 2026 16:40:30 +0200
Message-ID: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260816-module-include-elf-a9c10c041867
Content-Transfer-Encoding: 8bit

linux/module.h appears in roughly 15k #include directives across the
kernel. This makes it a "hot" header, so it should avoid pulling in
unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

The first five patches are cleanups to avoid relying on declarations being
indirectly provided through linux/module.h -> linux/elf.h. These patches
are mostly independent and can go through their respective trees if
preferred, except for the cpufeature patch, which depends on the preceding
s390 cleanup. The final module patch depends on all of these changes.

It is hard to identify all files that indirectly reference something only
through linux/module.h -> linux/elf.h. The changes were build-tested with
allmodconfig on arm, arm64, m68k, mips, powerpc64, riscv, s390, x86_64.

---
Changes in v2:
- Rebase on top of v7.3-rc2.
- Add the missing include of linux/slab.h in
  drivers/virt/coco/arm-cca-guest/arm-cca-guest.c.
- Remove the asm/mmu_context.h include from asm/elf.h on s390.
- Add the missing include of linux/elf.h in linux/cpufeature.h, reported by
  the kernel test robot.
- Clean up commit descriptions.
- Link to v1: https://patch.msgid.link/20260707153819.4172541-1-petr.pavlu@suse.com

---
Petr Pavlu (6):
      x86: Avoid indirect includes through linux/module.h -> linux/elf.h
      s390: Avoid indirect includes through linux/module.h -> linux/elf.h
      drivers: Include linux/slab.h for kmalloc() functions
      s390: Remove the asm/mmu_context.h include from asm/elf.h
      cpufeature: Include asm/elf.h for ELF_PLATFORM
      module: Limit ELF includes in linux/module.h to uapi/linux/elf.h

 arch/s390/include/asm/elf.h                     | 1 -
 arch/s390/kernel/nospec-branch.c                | 1 +
 arch/s390/kernel/processor.c                    | 1 +
 arch/s390/mm/mmap.c                             | 1 +
 arch/x86/entry/entry_fred.c                     | 1 +
 arch/x86/entry/syscall_32.c                     | 1 +
 arch/x86/kernel/cpu/intel.c                     | 1 +
 arch/x86/kernel/fpu/xstate.c                    | 2 +-
 arch/x86/kernel/process.c                       | 1 +
 arch/x86/kernel/signal.c                        | 1 +
 drivers/char/tpm/tpm_crb_ffa.c                  | 1 +
 drivers/s390/char/uvdevice.c                    | 2 ++
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c | 1 +
 include/linux/cpufeature.h                      | 1 +
 include/linux/module.h                          | 4 ++--
 15 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260816-module-include-elf-a9c10c041867
