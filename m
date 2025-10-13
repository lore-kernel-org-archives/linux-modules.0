Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F2311957
	for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369992; cv=none; b=hCPtTj0yZvvqu9ptuzuPyFUdSFRVJIoa94V5ONvS5rEE02muhtV7+0ZUDa0cxTpdHtqaml62a5gQw35HHJmtEwpazxzotuB0zbb9rYo5uMRhaSVQINWBN/R6WrKmiqtJfrKNIj+NK8ND4sQBGyHbCiGNUXgBcbrTytbzTvODbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369992; c=relaxed/simple;
	bh=Yif0tpvEVYMz/HHDWBkZZeP1JAtd0/nIT+vjnx/3i0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBnY6RL2CMDCmvlsckTRNToizednIgVIxhQXsPU7/DQUJs8FJhhBXGtn1env42eCQGvGWx3IROiL4X0Bsa87nUTIwgJ06rYngBss9StU/khm2TOs+EO/NLRXm2LEUZOruqkLGK87ajcCxcKzC5EyNQWo/tI4YAmJGEYN1TqIkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpKq9IXz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpKq9IXz"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so682101066b.2
        for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369989; x=1760974789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjM8d244naCxzVfKtaINlZql2XGUpipFpM5gsitgK2A=;
        b=JpKq9IXzk38cNBC/fA7lYEgDxwtPgLsT0lLDax9AVeIl5xbvB7S1zLd6x3KMWwRDGe
         IVvbSZPchTG9ZvltWJCynYwRAIMbsXSnjy/+daHa+R1et3JyCm9TsB6B81SP7KgDo0dD
         99HYeBA5Pm7jO3m4atQx1DraZlNXzOdaAqwTkmqw2QlBnCaiJNBM4BxYat2O+29Yt4LR
         4xk08xBUksMPlctojrnE1FxVah7nM/VT3n9AaEbLfb9xgm78aHm3zoGiK85+PcU3zKJn
         6N5Ckr3K3wl5jUszdD5dwia3ZQuV/ZEfJ6OIeqW4qtlRNLe9qm3GnMpA04MNZPCCZOJK
         /P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369989; x=1760974789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjM8d244naCxzVfKtaINlZql2XGUpipFpM5gsitgK2A=;
        b=XsPr0cS+ckx5ClxaIR0ba2N5ZEyd0qUwrokdegnl55FWAa8joyN6x+sCLDzy4QzyjW
         1xk6A+qDW4P2Tg6izqHE5r1UxYfMFfVnDKmAmjNlM0dIsGJ1ohkkG+kmhzrYpT0m1n/P
         FJHnoaGSe6fSpWwTtoRIMPPE3nlSAMMF51AGYf+3CLRRBkOCXtpKoTCyYsJCBHIAnj4I
         dLgfPhMIFbofDPZfhlQZqJVDlijWrcDAVMLX/cbPX72pci2MABzt4qf8Crb8GiFM0Le9
         EpdNp+f6QYwOIoEr8eksTa0UmERuRIyG9ce6Z6RRStTNK+PG+Mrwu2jeKyRWNHIbqcTn
         0w2w==
X-Forwarded-Encrypted: i=1; AJvYcCWN0RF+Q2lOHlYDAVGxg5laA8oczcgTIw4T3pfLrZ95g9Utx/hWk7FLYzN3a+MarAMrox1S4l6FMotnpAke@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9nQL5QvwRO386M8e0ANTln3g2MMMMaJ25SsJKztRfzoGFiPL
	rVyaMvAZbLD9c2Q4IDg2uMcQ/aBo1J0U4d0t7lPHNTAgzwNe/8b1lgms9byQXrPX4iuFDHiCHTU
	/Iey/8v/1V/kygrk53w==
X-Google-Smtp-Source: AGHT+IGiQtyP/1ptL42LsvljMNhOg+y+bM7AeQigA9x43JIE9KmSCt7yX9mzDsBi3XU7e8y5ilB7RsBmmAFdHxQ=
X-Received: from ejrp11.prod.google.com ([2002:a17:906:6a8b:b0:b2b:e1ea:68ee])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e8c:b0:b46:cc3b:65fd with SMTP id a640c23a62f3a-b50aa99e1ddmr2177629766b.29.1760369988766;
 Mon, 13 Oct 2025 08:39:48 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:10 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-3-sidnayyar@google.com>
Subject: [PATCH v2 02/10] linker: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This section will contain read-only kernel symbol flag values in the
form of a 8-bit bitset.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..310e2de56211 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -518,6 +518,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
+	/* Kernel symbol flags table */					\
+	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
+		__start___kflagstab = .;				\
+		KEEP(*(SORT(___kflagstab+*)))				\
+		__stop___kflagstab = .;					\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index ee79c41059f3..9a8a3b6d1569 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,7 @@ SECTIONS {
 	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
+	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.51.0.740.g6adb054d12-goog

