Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57431A7F7
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186814; cv=none; b=PmUAGwZNBbMSx4OsnB8my3VjYAyKIkdl/+5B2k7gP8xmLb4FBGKToZthflLT1d9AQtVZDymfp/mhgekPcnhr12R7cwk1fTxeNfbUxA/XzqlhwGkvUJnYLbtU9nlpT+v5a0Vrnxd3Llyj4RILz36FFlDsWH6wD7wh6kgJr8nPsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186814; c=relaxed/simple;
	bh=90zgfRi03LUPC/zqKQIwgs11pM+miVnc5O/8fUC1p4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrHOlihlP+ZGfGKrcQ/VVrahCttI6zr9umDQCfXSU8DSzL2VHFFT4e+0g7b1zuLcGrT7GK+qwPNElRAdZui5IktEQOjXbRmE+mD4PdCNZwpxOOJY4htZKBEvXuJ3A2fdrLw/o2bR4v4d4R/JBFVwaXVnK7sJS8x/wv47IaoFwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEd2Vqwy; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEd2Vqwy"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4298da9fc21so2527808f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186809; x=1762791609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=olCu7FTS9PcLYXD/iow1F/tBLcCLSX9gN8Zi1GrdvXs=;
        b=OEd2VqwyKjLVxi3c+TEVNkTSh9+vhMjXybRGbzI7I0glzxpfS8SBRHnBSi6Xa6U91+
         /qPNXCXg/F90N5a8KV+mn5fCvuHy1Tm3PsBVKyF2LfYza575371qrIOewx4cYpvzZdX9
         uvBlm3xC6KJmLgYIqv1kOp7c0NOH4Rp7vt1NrLyATC8jwYzDZUiwYWgpOCw8VxQxydXp
         miykrXrrqbqENIdKi5HVPNbhJews4HqvlQjTOOLG0te+VfcbuokYaozF6F0Q85UOQLmg
         RCnsTFkrFS3HVWLU+NAV66M0qqX+tqWMfq2mFAYfhRjvBj8EikKCYVULGRH4UtOa0mYi
         UeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186809; x=1762791609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olCu7FTS9PcLYXD/iow1F/tBLcCLSX9gN8Zi1GrdvXs=;
        b=ZpLsGqT3Cz+UsGLRTDMcUVB7mlffbiZNytXAkbw1iNz6gyxXXcvwwB4eS7hsiPhl52
         Dqn5fGCSZXY6ABq/SqRod6J5EkGkYo5NNF2L4KADT1Sy9yuXtB2zkWm28itzcmbafVka
         EV7He3/39D4jqPbsNTbLlyA2rkGh1srBaiNTUPUpqNhdzl6QpB4EQ7/3MRAyiWEUdTpE
         cH6kc1shb2pWnQMsjpP94VuEOVadRspbm8HWCnD0OhTE8d6TY4NrG8xeMrAVIyT4QS1C
         SBi/omDi5WiLzLKIaGSFGJ+goitPcuxykIVywyJH+w1r8tAoMyIxDKRTadTeOCtRqSTI
         DncA==
X-Forwarded-Encrypted: i=1; AJvYcCVi/7sFuH5Req/QgPvbZZWfiNiRgP+mJ7qHml/cSZzeOqwmTT9vfDFeVUi0s+srpGpx/4ZoQiruEIOZIVpU@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAYmfSjGcX4STGwNHv5dIqmUJliaGfGE5wkZ8gITKv2iGl2C3
	Rr11CP63hH6oiXWghmfMUxcbv6kGtNaXUZOq/AU/gci8ip9wGXAx1wYN6Jcb2+J6cAKGKCbLlcT
	vWehxtSNreZ7qmb0z4g==
X-Google-Smtp-Source: AGHT+IE9IPcvmbIvQwAMqkVKiUmE8DZiY829fkrxxcHOeyR7WshNvHPAvPnZKpl9Eu6FnQkKKw9nU3nVrpj/Nr0=
X-Received: from wmcu9.prod.google.com ([2002:a7b:c049:0:b0:477:f0c:b354])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c2:b0:429:b751:7916 with SMTP id ffacd0b85a97d-429bd6ad961mr11484402f8f.45.1762186809292;
 Mon, 03 Nov 2025 08:20:09 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:53 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-8-sidnayyar@google.com>
Subject: [PATCH v3 7/8] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

These sections are not used anymore and can be removed from vmlinux and
modules.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 310e2de56211..6490b93d23b1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -490,34 +490,20 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 									\
 	PRINTK_INDEX							\
 									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
 		__stop___ksymtab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
-	}								\
-									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol CRC table */					\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
 		__stop___kcrctab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol flags table */					\
 	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
 		__start___kflagstab = .;				\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 9a8a3b6d1569..1841a43d8771 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,9 +20,7 @@ SECTIONS {
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
-- 
2.51.1.930.gacf6e81ea2-goog

