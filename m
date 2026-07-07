Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684A3033D6
	for <linux-modules@vger.kernel.org>; Tue,  7 Jul 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438736; cv=none; b=N0mQ4kqU3FJHuQjfA/gnrJkNu1njQDWMmmmsXC8U+14nO7EeP5n1Up6+ZbG7Vx93q3lLtoSTvoI9Fr9AsugL76fGaj7BA5jxVUD1lryYpJDkLcmF6mKHs2CKECloluh1tI1F/NWu2SXhuCxBick/SaQIC1lt3HEdyeIkELCJwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438736; c=relaxed/simple;
	bh=WlxI6D6l0R5RgwB+XCAILtOwfVKifVrQwkT3eMDmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y59Uvu85aeRCtOAOcVM82usHg2d4PAVYtuI0TTaMjo4RIrX7iAvPNLX9AX9tkFR/SMui3J0VSXj2ynQ27Hxm68Ef2oJasO7Z7vPE/YzrC3aMWjodu5olmRdUwM93TGL9G/Lk19SMnGoiUITzKGmaO+q8LrQygltCoudciQLJRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MmjH9P0K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MmjH9P0K"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c1950518so5570995e9.1
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438732; x=1784043532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=MmjH9P0K3E2AunaKnGG94wC0VVYj8cpOvWmGsRK/OKaVA9NvRb8DIQZ1pmpY6aKx6+
         Mh9SJbU353ZwUt61sFItSAOcbmwbbRcb8V7bn6T5XJCdCnf4nJah1QbXV3gmOqEpv5y0
         BlqfDR3ymtTkdEh8Q/z4Fs/WKPvP4MkRntZ/KmtPkUychE6pHwJZ7O1JKLo8e576aHaC
         w1RFtzhg3T6zSmOIKZDJLL7VltpO1rbdlO3n2ToP3bmg1ELTdbqpiZkeTC3GHI4yyeBA
         hKDp9n1qiLLDN/JExEDVBKhvkcBoVsnzpwf70Lh5krwZCPoQIqGtBQJY3nRCju3+migS
         eOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438732; x=1784043532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=JQY/rymKB9qRDHsUnlQahcMUUy/egM0z0Ymi8z70Cwi/hzrTvnFOmKfedqDG/lYPAo
         Bh3LhWepnyAMCrx9IpgVoV7kYHw97y1QIXMeASQDUVHHd/u33FChFQXNXpaHwitzH/PZ
         YNxn8f1UmaIRdJEd+9aC11uIOiVcpVPAWbXiDDfjBs2K0fluMFbqtx6pp4l/Fbc8h6FC
         45Z4M+gLeLFR/9tDFoQ7faf455K0Ua9a5YK9gVVN5st4trzxlS+w7RIRhnL12YgV98J5
         opVY3s9z8MeyKkgDoU98yIdOgzHCE5+F7UDkHQgxebJt/vYq6UH14QFu6hJbgWsqzuD6
         BzEA==
X-Forwarded-Encrypted: i=1; AHgh+RpgZwxwEqQuqggUkDCRiMoMilF0ZSzFNTZEJK4d1o+HB3n0c5e7cPkkieXQp7I8JILGMSviA9c85Ci8nLkg@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDIRYbDhm6c/KNS65dcwxShVborEDIH8/GHWQw5pmmqxUuDrt
	u/qOTYf00/GaBXf4atMyxnEy5+oiwDNdlIaswHNLh10GSTLGyv1Mlx6mVEXXcl6Y55g=
X-Gm-Gg: AfdE7cnUXzZxGVMxaRKwKUeKDg2sbKdTPTYCkeWycITVeAgcAtAIjgU3OzFFNMEo+Bh
	fgo9JYeFztn7qc8jJKQSQS3U5Oy469qRWHS6+6MYQ9g4MjShFxu/TLGTQDlfmUit1NmFQEVGbyz
	qZ/CdFTsmXzUO5v53uEwVmFXVjByCn03/CCV18SCuvsRHS1euF7MvhJbb8DmCTKWoaNt9iLdcQk
	neQUpf8qauwdFmJCq8fokt59kkff/MR1T0opBJ8GKZyiBy882OuVYeCL75d1fCAR1mrzGFPEIQm
	R+kyLaHW2UWZL++K9IvDX6jsBMcB8v85qXkee9tBC/vI3g3CAIDu7Uq2VhYxtjeBPqRshX644/3
	eNL5MI/pEEkjieeXmXg/WcSJM9DJT6IJub4Onx35IKUPBAxUOg+rmd97qRw7+rktqNxvxoWv7wy
	aToENAJIsKOdVFESAX91pY0SeJap2li2o/wem5loMFbPyguQ2rhUCbIQoJhKtZG8rYwcEIax6sg
	jjhIN+LWrFwpg==
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493e1011e8bmr32534765e9.9.1783438731805;
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
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
Subject: [PATCH 4/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:07 +0200
Message-ID: <20260707153819.4172541-5-petr.pavlu@suse.com>
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

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7661faadbedd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -17,7 +17,6 @@
 #include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
-#include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
@@ -29,8 +28,9 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
-
 #include <linux/percpu.h>
+
+#include <uapi/linux/elf.h>
 #include <asm/module.h>
 
 #define MODULE_NAME_LEN __MODULE_NAME_LEN
-- 
2.54.0

