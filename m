Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571683909BF
	for <linux-modules@vger.kernel.org>; Wed, 29 Jul 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346971; cv=none; b=S3rOuzfodyPMCBVF3jdfhqVe+hOl3rNSdh7Gnhep1ejdeMUb9+BN/Gyz8cHtD9pU+ZhtjHIRin22bXT0mfjlZMBbo4oSRZXdSasq+SfJCe8fCVydNYZEVSe7nbICk0MkMM3obyfiDmRZpfcRPX3p2lHSOzm+mTn0aBklYvFDjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346971; c=relaxed/simple;
	bh=/d7YZesbgIhTfsBT0OxeHqZOSsValIyxaDC9X7ELh9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT5K3w3sOQGVFTWtD+mFrSodEa7VWmEmmbBdHt+OunPIy1WH4TH9CoRpJpHOVAAJzgezkOlkXMg4yBZDRETFfYIJxxzz9AqNledCHEZINI8xWS53sadGM1yyaPFiBFfpK2WTRUhshMW/iqw4qHeI8JjfQkIe1J1Cz7QUuQnTVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOpIKzYF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOpIKzYF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf41bab353so22207905ad.0
        for <linux-modules@vger.kernel.org>; Wed, 29 Jul 2026 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785346964; x=1785951764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUHRuCCMeHTWfkl2PV/NItIGRfvsS3lSuL6WFFN9DwM=;
        b=XOpIKzYF4BoV327aT9HOcwZ8wpiFv/JFyjL1U0tiYMY3zGIWjkQWdaT6eqO/jWcByH
         atdMD/id4sCf62p5OufSSzDwvDX5/oOpW0OwkUqakul/Kvh+GQHT3uBWNYq7VIjZssMT
         pdCjuqm4y2HL03UOFaMrxuRVLHQQzMwYOAzGP1udq3qGDr4UM2wy+npbN8wo2Gfqbr1n
         UpbORKO8xdcVbEJa3irwdpTMmxWM3SC+2hJUDdepLQQfAplXZvJQk0P71OcB5fOSS9sm
         W4UmNoNzAEKaeWvoANDTpY222dvwgjUsWfds3XzaWBREoFI2/tPKqkFlxKY1p3zDmTo2
         odAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346964; x=1785951764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUHRuCCMeHTWfkl2PV/NItIGRfvsS3lSuL6WFFN9DwM=;
        b=B3s484JyoMUVNNF2T+1WaHts/wv3anG96sPslQt0xu7uU6z85zWlH7c5pSMcmTPleC
         LpXfehwlBd6d1bPCKtRELYSzs3R86ozwsiGYsbyjkSe8Rp7bBo3rCEWnkBOjCFemeOFz
         KOCLQyn86juSUR6YYgX6O8BN22ShlWM1Kpulsx1Uy1S3voISmHo3C2rkV9by28yuztNR
         sXP5lVMk8asVs+wlQVmtoCxLY4jX+vDzRbz+7RaJ07BKOrtN12IRcRb1XGbKtDRAzeuv
         ncoBmBclklbs5/8Il5UCGTTBMqQYuZE/JVHRSZUKcGjyp/p5CB4tnmU/FSBJydXPLX0h
         /I1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+4aG4jzvS75XrFUCziICLF473Z/B1KPHXGMjEG/Yv3vH33enJlIRkJS0lw1a2kDnuuu1d2ADTq8EZPgCu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZ4zgRc+xCbFI9byYWEJBy0Vr9S4lBgUwfGliD5dxyRIgOgrD
	FJeRGlDgirXMEThZqRZQvxgKsoA4qJpvFNhlwTDwaUAIHhnD7n7bO944
X-Gm-Gg: AR+sD11c0Cw0S/ohvShpS+n1ZaegsTjjMwlKpB7YuEtwBIbiWGiypGeeVPWMtuaBk0L
	WK4nSavLmN6uxLCKDLZScHEsXbguts5zCf2cb7kYm8qVJ4Ntl6uX0WzQchM7bDH/x7CazUYZMhM
	4wWZJm4rw5huI2dGqT2gWGTH//9QvzyGSbjq+5lPHTZ7xYBIHXezBAFkjkxTaXyr6QrQsoBscFW
	nGjFoLTrsASaef8UkCF5fhcoqYwfHAvQOHwzgtjb8TOTQiqlr2oDn3NLJ+o+5GLfmcjiPLT2TXH
	LR3B9x1qGwMGdaPAWmKyKugAJsNeRlpQTsZtsci8XioMVz1fQ1PonPY9cp86QFbCGeJHkew2w77
	R/IdVc1JQOGS5pkyxk4I4jh0GA9XGVmP0uzaZeQj41RrTAbDEFhzCc73Rr2yopshsq93XgZZuqg
	JW+USOFbsZMtv6L5pYANU9/Rq0VDKVHcfPF91mAYi50/PsMs1P6hzzURhGMcPR1Gd8oRBraMgJu
	bkEr8M29TnNl/4F45tItZ+wfuIly9fFL38GErSdBhYyKofl2vFXa4s5NZ27t2rqKo7PODFiyUuN
	JyQIkrQ=
X-Received: by 2002:a05:6a21:7106:b0:3c3:a4f4:c5c1 with SMTP id adf61e73a8af0-3c8ba60b296mr8362835637.60.1785346963929;
        Wed, 29 Jul 2026 10:42:43 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc64c2sm12446128eec.19.2026.07.29.10.42.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 10:42:43 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bug: ignore non-allocated module bug tables
Date: Wed, 29 Jul 2026 23:27:34 +0545
Message-ID: <20260729174234.86242-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rewrite_section_headers() initially sets sh_addr for every section to its
address in the temporary module image. Only SHF_ALLOC sections are later
copied to module memory and have sh_addr updated.

module_bug_finalize() accepts any section named __bug_table. A malformed
module can therefore leave mod->bug_table pointing into the temporary
image, which is freed after loading. A later BUG/WARN lookup would then
scan freed memory.

Require the bug table section to be allocated before retaining its
address. Valid modules are unchanged because __bug_table is allocated.

Fixes: 7664c5a1da47 ("[PATCH] Generic BUG implementation")
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 lib/bug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bug.c b/lib/bug.c
index 7c1c2c27f..44966ead1 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -94,7 +94,8 @@ void module_bug_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	/* Find the __bug_table section, if present */
 	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings+sechdrs[i].sh_name, "__bug_table"))
+		if (strcmp(secstrings + sechdrs[i].sh_name, "__bug_table") ||
+		    !(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 		mod->bug_table = (void *) sechdrs[i].sh_addr;
 		mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
-- 
2.51.2

