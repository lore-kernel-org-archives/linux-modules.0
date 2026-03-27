Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E663C871A
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598466; cv=none; b=mPz4BohNd4LpAlshP7FLjMx+oVxUayk24LTWDkA803F3cNTxR4JlPrQofmuNrxXF0zYymgnHo1UoZSgbf/zMZaXGMjZvJ/N0YyIVWlcKPSxnvlv4QCcXegEBhpItB2udbfK4X9H0GtlkRwTZ2l4ioy0z5riJ5OqaAYE7GfVaYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598466; c=relaxed/simple;
	bh=VuK/A2SKkIB8gq+5+JMkruh64JklcZWA+VF4xG65caU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCRMzzf09vYzGoacr7S1B7H1NXhf9Wzb8+ntXEOnTj7WTbShbZdXL5qxDUOwjy5DPCmQq4YbEuEkrZR68NtSPpcq32whBzlFTDjjUuXkHBaSbHLNnYk2pJ0C5F5XOlstQ1yRRbyHJEHb9g42ozZeXKv0O6k7qkkAW0GahZ9VnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PxZ/FGS1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PxZ/FGS1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd27754bso16832275e9.3
        for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598457; x=1775203257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/maIRRXWsco2YLlNLQIg+54XR4CJ2LAx0k8sLQQpIyQ=;
        b=PxZ/FGS1/Sq0/D0Dz/6gs05dbL2ERBXFYpjj9uyX39yEEB2PRCoKjvS4pGqYJXzPsD
         n4cDhvpGAcjJ1Oaly2VG2crQUE/ToXUQW1SFkcnK7aCuJRyEP/fjNYIB3JmxZLRcEY9S
         Q/w3pMZ1bAe0XfZ+O5vMhXV40/nthHFq7WYcSDOt16oHglBQDQcHL2KaA4sxdzY9zeOA
         6uQP9f8OUTNQUeCwWouzER6OWakeWO12OymkchDkXFS8HN+QxvdC/hcoluCdgawDFueM
         ge4Z1AjoJSeqM0rdPH6pS1Koycr1tZqpJWoU5+A7TGENcIdUVI1aD95BcFEWzaZ3Vcek
         kFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598457; x=1775203257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/maIRRXWsco2YLlNLQIg+54XR4CJ2LAx0k8sLQQpIyQ=;
        b=oD9gmZmdTA5OfC8ODA8sSCY+h1DHyX1Z/wntyUKaB3jfewKJODp2wV6RLxv9Bndt26
         nCOPqjhutPqApEmmTPnyo5l7xaVdBcI5qL2ZqYqX3OtpLUaQJ7MNl7XQ2DuBmKIWxzqy
         cgN2uwI+DR42mOQn4cLicw6YxwnWFTaov5CsPOddis2Ej+eimuNmALFdOOOesDdZ5ZjG
         xFZwffN62aqYFdyfvs6gsJnVAudpKjIdg44Hn3lPVXuukQRb+/KIUdqZYiS4z2CHe+LU
         THeCP8aI44pTsCZjz+21XlPLqTxv+BreWK6MpeehSDVDJQ6Lx9kj75k5DdpQNHpLLAXl
         uEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXZBEGM19hLr5HCGUzAsCXmK2MOxXdHkomNInh7gTHiJimk14TrZeEmsIMyObfbsk9oL3Ob9bAX/SooFsWS@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF/V3GjXOw2uUVMd2HSo75TDk8RSHF2eC1OO8ECnUA0nR6Bfr
	qqjDXj7Z5Z3nTU8ALUjq6VG3zaA+4ovutV9QZXZn+FFe+AiIjvM36UM6lR7XyzQKt4s=
X-Gm-Gg: ATEYQzxepC6dfVymRfyyI/a1FlEopEIO1HSyh7XsAqM8Sz0QNrn5NZtvWlpGO+uBMMn
	w2GHH011AhBoYGB/MX05YiSrCJ7jsAYiIcekmCumwthmx0/8SK+EDC4/1/gRE7MagT0XLw11moJ
	cZrqB77I/9rAnEbC+HrSs0QofGndoE740N+ED2JsCj/23Cj95uSa+PW6v42COO3dBeXP7/ZVw+2
	xOFKWqsMX/o+W327ReBDo2iuI6ncb3TPvDdyuQ39qP3S6C2KWlQZX1KerlESJ6hCVJNxPOCW7RH
	5AhzNf+KDlsyqRHAIBlN602bBzmHYbLHGK4N1x27iBkFWU5L6luQQLJ28sZAM2Mnfzsruq8v7is
	y5fjZcn4yRZgWGSZZpIhJRJfKUm53AYS8eT/Rn0iBwP/D0oQZlAdfCZAcrRlQNpNS7WLYEskkX6
	rXpe91wOn8+Dam4ZlTI2NfN6y0vvtdbfMDTlCyu5HX
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr22261095e9.15.1774598457203;
        Fri, 27 Mar 2026 01:00:57 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fc4827sm12089735e9.11.2026.03.27.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:00:56 -0700 (PDT)
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
Subject: [PATCH 2/4] module, arm64: force sh_addr=0 for arch-specific sections
Date: Fri, 27 Mar 2026 08:59:01 +0100
Message-ID: <20260327080023.861105-3-petr.pavlu@suse.com>
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

Force sh_addr=0 for all arm64-specific module sections.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
Note that the definition of .text.hot hasn't matched any input sections
since commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
related macros"), and even before that with CONFIG_LTO_CLANG=y.

The preceding comment also explains that the directive is necessary to
merge section groups. However, this approach seems suboptimal. A better
method would be to link modules using --force-group-allocation to retain
only one copy of each group.

I plan to look at this separately.
---
 arch/arm64/include/asm/module.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
index fb944b46846d..0b3aacd22c59 100644
--- a/arch/arm64/include/asm/module.lds.h
+++ b/arch/arm64/include/asm/module.lds.h
@@ -14,7 +14,7 @@ SECTIONS {
 	 * directive to force them into a single section and silence the
 	 * warning.
 	 */
-	.text.hot : { *(.text.hot) }
+	.text.hot 0 : { *(.text.hot) }
 #endif
 
 #ifdef CONFIG_UNWIND_TABLES
@@ -22,6 +22,6 @@ SECTIONS {
 	 * Currently, we only use unwind info at module load time, so we can
 	 * put it into the .init allocation.
 	 */
-	.init.eh_frame : { *(.eh_frame) }
+	.init.eh_frame 0 : { *(.eh_frame) }
 #endif
 }
-- 
2.53.0

