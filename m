Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8817CA1A
	for <linux-modules@vger.kernel.org>; Tue, 10 Sep 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953490; cv=none; b=BThTMcX1ValLhyhlfgOm9EMS3iYF5Nj+Q4YkMJvsyD+X1sVHBzs8hfdhetYraEaCzJNvBasqQpSPhKLj97JAHQTIq4S7IfX0tYjkWmplYkD51OGHDH6v76ozsbCXUWrv8VFHF0wTaTOEQgmAq6zljJ/Vw8/C+BuxKC5+zEsM4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953490; c=relaxed/simple;
	bh=90iErQjUuxlZuLvLxHWwZTKsBLvAE0hLjm8Girdgx/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GPWcgucJcJbmavvv6bPV5cIz5vw24zV4cqzqukaabvR11FEgwVKq025JmMSVpkRV2sQ8kM0JkkxZJSneSJDKyTk+GKVmu2Ig9RFApsKI/q+BgimQ3MlwVB94+AjeVv6bRaN5Eu9FrwANOHyVCWEGNCL+4UoB8o9DCufPS39yw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMzpcFD5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMzpcFD5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4f52a4069so167457647b3.3
        for <linux-modules@vger.kernel.org>; Tue, 10 Sep 2024 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725953487; x=1726558287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJF/m32H/gSTOtDci0bGeFjM2c8K5gpqBOSZEpRycYk=;
        b=oMzpcFD5v6K9M71PPwB4CYtolR2F1HOgh8iyc1YbLWf4pvfTXC0BqDLjSbEmVDXQbR
         gtzeiI+gX0BhP9uSid3aCd3ygox1AoXu0Qj+xVLOOXT/2O6HTqPM1jsrseXvjN8HdOYy
         RxCYS8nF3/sII2UqvTk3sEgxtpk1Rmk30Z4sxSdU15rypxR20s3F+02mKihKbm2SzwyC
         jfH2Nxei+e1MqsbTrG/vqVgJvwvLBsI4F3PzN4mGXq7wB1Y7m91U53xR8GECLiDM4Mju
         xOzh0nPOMTM54HAmZsmml609Omon5VB1bbRlR15pNBwd03w5aUj+gDOSfr2XNJqv04Dd
         K3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953487; x=1726558287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJF/m32H/gSTOtDci0bGeFjM2c8K5gpqBOSZEpRycYk=;
        b=bSSaHk/9L8lCut+8i5IowKaflbxDq1IlB2pisPBF5JwEPKp0RX/S07stY+8+Cph6GJ
         ktQkwk3JTXqoUjJjSz6HD2TST6mreee0CzZhArR1ZGUbwH7LkqL2K2gC8aX6p2TGDxpO
         h1IGdvTqwsgMnjcNTQivB/QByL1FTC9jYCqJCw0whWQcAwWKSYDKAJDzzOfTFEgIFIoT
         5DK5FazgooHEOO0ohJLO6XppqEXxMbXcGWr2pjXI4+O6Lr1Lcg6YiBlIyAFq4ka5GCFl
         pyzwK3StXO3d60x2mFfNjoXE/Z9az2TK9TawMl8r9oFF40Rdn9jHP8Lugg2LPm3F3Iic
         fC+g==
X-Gm-Message-State: AOJu0YwqwviGpQnCiTT9sa4Q87WsIt1dcWhqguo66ge5RZhdtqnVsB28
	+LlQTYw4PVTww3LMgA65EoFW8gNBGMmhG5OWbVJqBKXbzzjpZLFhX5QPq7NhoN1/BwD2g7rrDvo
	HGNSoUxVV35HZRcAFiQ==
X-Google-Smtp-Source: AGHT+IEhwdMjndZFC3i4poKbvtH8lAHK/uqKnN/s5k3PNYjKW74EYSM43oKDyzJ/vCyOoq4uBwnRAOwSYQUOSV3+
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:3746:b0:690:d536:27e1 with
 SMTP id 00721157ae682-6db44d4dc82mr11184727b3.2.1725953487457; Tue, 10 Sep
 2024 00:31:27 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:31:23 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910073123.2362028-1-vdonnefort@google.com>
Subject: [PATCH v2] module: Refine kmemleak scanned areas
From: Vincent Donnefort <vdonnefort@google.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

commit ac3b43283923 ("module: replace module_layout with module_memory")
introduced a set of memory regions for the module layout sharing the
same attributes. However, it didn't update the kmemleak scanned areas
which intended to limit kmemleak scan to sections containing writable
data. This means sections such as .text and .rodata are scanned by
kmemleak.

Refine the scanned areas for modules by limiting it to MOD_TEXT and
MOD_INIT_TEXT mod_mem regions.

CC: Song Liu <song@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

v1 -> v2:
  - Collect Reviewed-by tag

diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
index 12a569d361e8..b4cc03842d70 100644
--- a/kernel/module/debug_kmemleak.c
+++ b/kernel/module/debug_kmemleak.c
@@ -12,19 +12,9 @@
 void kmemleak_load_module(const struct module *mod,
 			  const struct load_info *info)
 {
-	unsigned int i;
-
-	/* only scan the sections containing data */
-	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
-
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		/* Scan all writable sections that's not executable */
-		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
-		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
-		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
-				   info->sechdrs[i].sh_size, GFP_KERNEL);
+	/* only scan writable, non-executable sections */
+	for_each_mod_mem_type(type) {
+		if (type != MOD_DATA && type != MOD_INIT_DATA)
+			kmemleak_no_scan(mod->mem[type].base);
 	}
 }

base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.46.0.598.g6f2099f65c-goog

