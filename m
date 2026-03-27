Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC5382379
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598464; cv=none; b=HHlBEFNMQzypLzkzl+wx2ElRIKQlupPX1r3BI90x6Gq5YlYxEyN6lZFmkZXkwVKxh2OUCP4s192kGSKDGyqA9HLsAbBJOJat7HmVc+hK0wmqo0uFLPh3ISXon2gsTeT6cF7DgWQzDMSusDQs3hdft9ecFVH87KdwLRi470oZMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598464; c=relaxed/simple;
	bh=R5/wNfEI166VxEYxX5DKzfd4I8QXDSJZsCGNJsyOgQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzBIxzPRvQjVlF9Xw7LemlR0BaWH/ctofsdPT34o3zF/qob+7kLnnG4+UvcydNE1nlPuz8Fh6ehLcipUt/N8ReEG+puGZqjRbYEixZ9NhdvNbTIlw4VMgoh0gd+jplVlllo0kwU7/CqzMHDljR2sxuEy0wOvLeDaacBmKWcEBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DAY2h5TO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DAY2h5TO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so16886275e9.1
        for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598456; x=1775203256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HryrWoWtiuMl3LNqbcdlk98yeRL5cKfDbuBDTCXl6o=;
        b=DAY2h5TOMKov2CabcY/xMzl5MjApL7TEya7MtwI2A827RoEvHaJc1Fux9/Y3fkb/DG
         VmRKazIkTATzc+PD0cwklr9SxZGlYWa9H855RRXrNRFem2f7knlaiwXKqFr5M7Ay/Uq2
         vZwxnjW5xL95MvpUtxAclndmsi7EM5WDAS9EhPwPeZi9X2M1s/28tkEABAGd/qvex6Iq
         D0ppovJJoHdCPXD0isVSO7JobhfcYh85q/y5AxEnO7HUNCvmsRKtJexy1vMmlPY0ONPT
         0/bvyaR3m062Cn4R4hxpezPIE00vUH3qUQvynjjxSXTUgpxdQMdOi9BGv6FpLKxkAnFo
         EdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598456; x=1775203256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HryrWoWtiuMl3LNqbcdlk98yeRL5cKfDbuBDTCXl6o=;
        b=Q36BRPhOGZQHonAVxPBU2cyuq+b2t24nqJGGIuwPlqEXiwykq8/NKuWv79EwwwYSM3
         th0C52NNdx0P6A+4TGdlJO2hL8NZyrbiaDXpra2OGjbkJsyrpwWUkmVtCQyVxfPBo5w9
         7bIq3WEvvUWdBJvc5smfbEJH4s41adz+zvy1fj+f7ADZQPKsBBYTcLm8eFEjFo2qq92A
         GSbQPuegAUDqgiEL/bPEw43DM8eysrptvnjegPi8Wcd1/B11dlG/UGGJjhyfjh5DKCHx
         9UEnsUXOF7QIgtmPP1HSup/64ILLxS8xcI/tCcgwYYepez1SK+ebIjABWMaY4855JnKt
         wLeA==
X-Forwarded-Encrypted: i=1; AJvYcCUvunsCyRDWvDeewJoEzPaCBS1qKlpLv8N88ZnDkIl3YqRdR64ybcshCdLvgHao1bWc7Y5BoCqs7qQbCuH5@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZeFzVUXW2PSnl6IptpfC7cL6FKoDboinBdww88y2EF5tVWZr
	HkbY86aTCumO+zxPy3i92rDRCc/gmKDZHdutxfDvF+MfmNxGDHwKRS9oprMP0ZAhgqw=
X-Gm-Gg: ATEYQzyd/JXeV1mLd0a+/SD6ahhiUsDDx7AFz5+BLfX77kJRflFrprxL6V38jL3DvGY
	Z6J+Qp/v1oV6+/TXZHe3AeDb4HkZQrBqXponOZndDifK6qbk8gwdh5a9h2teakLJRPba6yPz7Km
	Ep0A94r/C87Fna9hc/8bbNBFzlaV1P4vlTVd/x3nKXotk119GTZ4ppG4Q4OEIipUKul/XkBvz+6
	UjnUuGtRpQ1ntbS1uY+WtU387Baxd6b3yL59/8sRPjN9eiiDETqJPHKi8Kh39w5rrT72XIxSu0W
	Iln5WMP4fkexcaYtx6MiC18K7524DQYucW9a7CW7RAGfftzKge8oElijIUAuQPACuXxumjYxYXQ
	reiiJr3vBLMJTzotho9iDwpYgPQ/2LnbUnBrMx4VjIuqlbGG5YHXxnoP3vA8PgiCOqAme4HzAxq
	1Djnu5m9v+upP/qKsdsMtK2GwMXfFVGWPhpGLCoXpQ
X-Received: by 2002:a05:600c:5249:b0:487:386:3714 with SMTP id 5b1f17b1804b1-48727f7bb08mr24460995e9.17.1774598456054;
        Fri, 27 Mar 2026 01:00:56 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fc4827sm12089735e9.11.2026.03.27.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:00:55 -0700 (PDT)
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
Subject: [PATCH 1/4] module, arm: force sh_addr=0 for arch-specific sections
Date: Fri, 27 Mar 2026 08:59:00 +0100
Message-ID: <20260327080023.861105-2-petr.pavlu@suse.com>
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

Force sh_addr=0 for all arm-specific module sections.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/arm/include/asm/module.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/module.lds.h
index 0e7cb4e314b4..f9ad774b2889 100644
--- a/arch/arm/include/asm/module.lds.h
+++ b/arch/arm/include/asm/module.lds.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifdef CONFIG_ARM_MODULE_PLTS
 SECTIONS {
-	.plt : { BYTE(0) }
-	.init.plt : { BYTE(0) }
+	.plt 0 : { BYTE(0) }
+	.init.plt 0 : { BYTE(0) }
 }
 #endif
-- 
2.53.0

