Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17780348445
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598466; cv=none; b=XipNYAxjJPz40zkq6gBY5diRt5XAZPw1od4nzhB7tYcrtGN/VM4BkEMum4nOZu5eap9C1dn0d6YGsVgZ1W3BPAXHZCy9NdE28JnHUPpS7mSMOxUv98+3L9lTM/MmJLDnEaoJiGOi1uT6rlEs+vrd2r97DyS+MASj1wBZsErzAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598466; c=relaxed/simple;
	bh=b4EA7Cjd+Rmu3jUMpgHSoP8C+KLtgyFkpMfPCKIjeuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di4FXL1Sl9XXfhaFVGTT3RjSER+nW84V0mf/GtbBGMVx59ZYzJTaLuJ0v1KiaxrI2c4GnMElMrpzyKySN0ntI3qyc9klznnD2BZpMUrLXx2Wb+PoopvgQ7YLebhEh96030+i4d2/iXePe2olhl2QM4CdlglKYrf7s2wpu4lP6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ewH5Dvse; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ewH5Dvse"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so21191145e9.3
        for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598459; x=1775203259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlVyZgwbk35jZ7E4LjSb7Hh9QtkNRjrn39+Y58oA5YM=;
        b=ewH5DvseIaoVSCMuGNSBL70uEaf+vTd9BfwRKhpU78uNzlqgMgq7ptq3qBBAykXwYS
         ehEuD1jyyTWevMn6c+idZk3Ky+Lni+gSeGzLu7st436n/Bjoy1QcPWRROinVHq0+GnWJ
         ZrKaXQIUcntWpu5UONhhyqNGNKFsNmB3TYdGLi7PqoVaANJ68Wdt2hfWgdhKgsEBNiYZ
         NrnpcQGTyW4qZ03xzZNIurigH8fbRP2Ir7NZwHyh8azGdyuft++Dt1L9qVnS3D6i0DrY
         X4hFW9+yhwMy3z+GdpTSc0ihXB/cSRQT/tsrdAxzUbRFkwdFuZZT4LRwiqj1qHZ06vUQ
         t0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598459; x=1775203259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlVyZgwbk35jZ7E4LjSb7Hh9QtkNRjrn39+Y58oA5YM=;
        b=ile5yeGzJHNE9pFlbrzDoKSAhKz32USFncDAC1lRAEdhNJlcf5gbDLriXNezCEBMTx
         l21f7MdD3eTpOPH7z+9Qhc2l+y9udg5BBlmuOV8c5JGx18yHIGNqAvq7VIUavIwt6CP0
         gQGSjNZa1yk5GxdiQU7x5zFSHodK4diglLhGbpjF4NbNfNwi5Hn/0TKrVFHOODkyejf1
         I5llw9pUnEbBijO58bGDxHdlEHVidqQfu7Kzea26C/pKnOAiEXgerSrsOqPaCmUZsFYJ
         18zUT96SBYB6X0PKmu8mx5v4aG2OMmijthDsINj3E7D+NYlHOw6yHyV5hN/L4dp1BNlq
         pgVg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ESglgtgsT+igJ6WgoeBPqRBZbTxWGStylO5pA0EPYgPjWhSKeAp9GMPdcZTJj6eVuqOqUhyI4WVAoFFL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyml6OzQ7EotafoIP1CedKd9HUwDZ8O41n0lr3eWn6eC5CyfT8Y
	TaupbNzmHSm0TdegqEnwvHXJhfSiYtieoWnNEdPIh7RnfrhZNab4nHfErwR74Q8wNPQ=
X-Gm-Gg: ATEYQzxf/1FLpYTLj82shnLbvPmj/aNlp53I0H2qUpUnyPtqU8deHRIJObWtIyVhIs6
	xdL3XYdzIyexcwVMeTv9f8gpiiBX6MzDEm0UjWn4kdLzHsVV+t/G+xSTUY1rH2ixZ3Yoeu9SXt8
	5u9uEtr9ZTejqj7zi1BieiSkCioQri6eSX/OT+GnVXIkd8z1SmvUWKqLAamjB455jO5jagBnHd/
	2dqUDDrd9QmQnMzGk4osrDwu0JDduEO5lmeLc4EpWfsLZYaosE3q74uZW2PGVE7h9H6b4c+lZwA
	nY8nZl1NlVSC0Gb1PXL3F+YeljW2ufC7hh4bLJahyta5fRmQiPcpnF/RFvDAqbHsGGbsqVTI7+a
	IzG9cno9ldG1F0InGRBtzPdurRVT+ekREuj0kGPZ82nrQ7WgAPQL4H2Lf5JbJTcQ2RsaGvuJpv2
	35BAwE2DHD81J4FX1Js1Ia0T3KEKzaNn62HUU5AR9i
X-Received: by 2002:a05:600c:5304:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-48727d67a43mr23844745e9.6.1774598458837;
        Fri, 27 Mar 2026 01:00:58 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fc4827sm12089735e9.11.2026.03.27.01.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:00:58 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-riscv@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] module, riscv: force sh_addr=0 for arch-specific sections
Date: Fri, 27 Mar 2026 08:59:03 +0100
Message-ID: <20260327080023.861105-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327080023.861105-1-petr.pavlu@suse.com>
References: <20260327080023.861105-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When linking modules with 'ld.bfd -r', sections defined without an address
inherit the location counter, resulting in non-zero sh_addr values in the
resulting .ko files. Relocatable objects are expected to have sh_addr=0 for
all sections. Non-zero addresses are confusing in this context, typically
worse compressible, and may cause tools to misbehave [1].

Force sh_addr=0 for all riscv-specific module sections.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/riscv/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/module.lds.h b/arch/riscv/include/asm/module.lds.h
index 1075beae1ac6..9ced27c8ccb6 100644
--- a/arch/riscv/include/asm/module.lds.h
+++ b/arch/riscv/include/asm/module.lds.h
@@ -2,8 +2,8 @@
 /* Copyright (C) 2017 Andes Technology Corporation */
 #ifdef CONFIG_MODULE_SECTIONS
 SECTIONS {
-	.plt : { BYTE(0) }
-	.got : { BYTE(0) }
-	.got.plt : { BYTE(0) }
+	.plt 0 : { BYTE(0) }
+	.got 0 : { BYTE(0) }
+	.got.plt 0 : { BYTE(0) }
 }
 #endif
-- 
2.53.0

