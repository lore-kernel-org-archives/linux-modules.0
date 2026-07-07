Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653233ADA3
	for <linux-modules@vger.kernel.org>; Tue,  7 Jul 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438730; cv=none; b=IKx9rhqDy4iIZL8/Uz6xcW0vSpAN2RsVUgPDU7IBxC2jNOfgd9OQ3WpvioWEIejcc2uDgTKK8VRhpjTKSIKWAUB0wnJepCv5CA1toaBZETJGeQh8FuLWGhk2G4zOWuwU5yzody/izdezh5guncXZ2HlIX/CwyqbbVCbcf5Vh1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438730; c=relaxed/simple;
	bh=iDSVx05XJpQ187yLL+vngdmnzjWQdJOINiVqfnmbIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaw2dQ9KrolfhrWeyDEu3yLcpPLv4OYCw9gVMCJOsoN0ouzvMbVP/dLJ2uQkAibb4QwX9RAMo/TZtDnkrVnYX8IAfg55cp5+1UL56ZjnOJrkG0EW1b1M4zC02jSk9Mkvto9drEMJhB6ApXdECzy3v8asYvfX74OUg3xrxT7iPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OQRAcW6u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OQRAcW6u"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b779003fso21945405e9.3
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438725; x=1784043525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEQ8hvtSLcTmZmrsjKtJkrVXdZFggd5Aezo0pgyYhCk=;
        b=OQRAcW6u4w3eHo1rKEUxi9C900X9L2rF9xzjyZszsY7iad0v5BNxcOALCOu9RG60YK
         zIpoMbUOUpcuo2unP4EU1ljS1cteHo5NmgIa/Lxodlw8sbK94HXm5KnBocHprHa3reTh
         wKyEs8iOUIkEITzDgeBCQI5VOfW6hct1UHDtkI6KjfdyZZ9KhzdykJBRtruYd7LVHHFr
         yu3vwcn0crbkn7lGVO1D45mbgQVvuVr1IqHHOhenvDjPXHEKtIi+V2DGg3Sg8RNUl8+x
         X7a61e2K5QIbcn7Z7XO8QDe7AkdYKuvCrPt/9koT7Vcv73MloNCs8eLuP/0k2rD0fBvy
         CBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438725; x=1784043525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEQ8hvtSLcTmZmrsjKtJkrVXdZFggd5Aezo0pgyYhCk=;
        b=fOajxqel+k7B2Z8pzy8Uu6NcRqX4jkb9SIP2vbT0LP9PjzpJ9LydhERLNLQe45Abrh
         k4l3b2RPNWoo6wUKiERT098sxZP21ND0Wb2wqqKiOuF7hrMuzc0Ig+LPulWLbdMsPtFW
         EIvfkXkuyS1cHDThGfyA7zTSZvx0LrEg08VMon/t02eidOPpg+PqR1SjYEu2PlWkR8GQ
         EJMGLoAnetgCM8inlACAQZ2HEAW5Lc+rgQYh1ZToL070Vu2tIWGA/Jr2aB11C6JcPdAu
         Yw/FDRoho0k9Fci5m0+h5guXEBX4IsnJVMAT57qpAw1MpTrCEzIa8BGAXXjhcBVBcRrD
         PgDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnhWL30KIIJBEOpb2pcmChLS2DKosaP3Z+jtIdp8s4q+cehXMKyyg0NV0C6FNgRAdzud7XuEk1QDad9gBW@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFBDy3bZwURkKLILx7htnBYTmArv75L2LbtAqvU9NPoLqZJCe
	rDLKBLDf+5ZRPLENz52s1r062rvCe6u8TGKC1kiuoohvuWCjaCy+Gs476RkGam6cWQY=
X-Gm-Gg: AfdE7cmecYbl/BmWNgy9d34S+xvXJLi6CVBi4gdxofnZCPiRI/uEiyBDmtFmvNiSahO
	5Tqi/CpPO/U9dKRY/kvLu/s1a0ZQ/yhCtd+aLGod3OXTGrj0Yp/82VbaN4DaulCMGsuLDtNtmg8
	P6xTKXe/GDFre89WId0RCa2SAFkFJ7wdg3o16kR+cLSfjMvWamjNTSddxackPHGuvEWW/KOm2g/
	uzIBPvFthFOwaZ/FRzuFtxR4qRclSq3f9EMb4EMlhmOnhURVPIdyhX6phjAdyl+/ZZEd+JSDyuq
	hcDXsVqLITFuHLeHwJoSzYTNUQj/ycouaq5wcJzogM0i2AanAswa9thlVWSEEGndUoU3SH0rY8l
	6xyzCp+nIM0QHVpdZx1BF8R1es/hO3cOpWOVWHINCFLSYRjTdQrGCOA+KQYxm/RHQ4rG9/BqeYX
	3zo1++rEEvBYlpyECUftqQU/2keSViCUmI3Pzk8isR0qEplQ5JrlsPXEY5DNi/ziWavj64H8OQ1
	cR9KEiyMSbNjz8wiz1dvQ5R
X-Received: by 2002:a05:600c:3b08:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-493df0410d7mr67190395e9.14.1783438725537;
        Tue, 07 Jul 2026 08:38:45 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:45 -0700 (PDT)
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
Subject: [PATCH 0/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:03 +0200
Message-ID: <20260707153819.4172541-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

The first three patches are cleanups to avoid relying on declarations being
indirectly provided through linux/module.h -> linux/elf.h. These patches
are all independent and can go through their respective trees. The final
patch depends on these changes.

It is hard to identify all files that indirectly reference something only
through linux/module.h -> linux/elf.h. The changes were build-tested with
allmodconfig on arm, arm64, m68k, mips, powerpc64, riscv, s390, x86_64.

Petr Pavlu (4):
  x86: Avoid indirect includes through linux/module.h -> linux/elf.h
  s390: Avoid indirect includes through linux/module.h -> linux/elf.h
  tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
  module: Limit ELF includes in linux/module.h to uapi/linux/elf.h

 arch/s390/kernel/nospec-branch.c | 1 +
 arch/x86/entry/entry_fred.c      | 1 +
 arch/x86/entry/syscall_32.c      | 1 +
 arch/x86/kernel/cpu/intel.c      | 1 +
 arch/x86/kernel/fpu/xstate.c     | 2 +-
 arch/x86/kernel/process.c        | 1 +
 arch/x86/kernel/signal.c         | 1 +
 drivers/char/tpm/tpm_crb_ffa.c   | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 include/linux/module.h           | 4 ++--
 10 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.54.0

