Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753031C56A
	for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369998; cv=none; b=VihOowIksRCFJdVqNl/xfOdhAq2vSndBOaDaKyFXwZrTkii3GcP1BEzIxesWy+xL0Z8sCam6Q6y2beDsRaSZxjA3xVWja/Ns9fYKsfqzl2l8t0/aLNxlKZJqcBsvoXeG9ZG2YXhV+iv/YgE8nrc4i4cyMGXpcqOBhVLmVz2nsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369998; c=relaxed/simple;
	bh=lFWAd47m9WYWwYOwfmcdqTMftDRqoXt8LOsJmWA7WTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DunQTWKaVGWZ+rPc0oc+dTd80rPc0/YiIQ4q1OgaYP+4gRlUNB3DBZfK6aE+SI3HbXQ2V61fL5FlNByo//IZL8bwEbLvI94FP9XY65t7CShGLRhJ+lyo/C++2kfHLLqWYEMGnSjONGYjH/SnYlaBLxyCIe1uyA6wkxmvTxfyYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/vvyxhD; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/vvyxhD"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-639f0a38c43so6274736a12.1
        for <linux-modules@vger.kernel.org>; Mon, 13 Oct 2025 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760369994; x=1760974794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eG/97FcPJjq5NmEgRW4PArfa7yqTL2l/aJZCar+bosQ=;
        b=g/vvyxhDWnZku3wjYliqv0l8G9npqfzcF2S6oS2yQXUlDgFHAm+aQIhFRdE81DobVe
         82bridSCQqMFxhTArZ7ov59YaC6gs7uaBF7ZpbaHY92fGzYK+6ErQD2/MCO3/KLyxEcw
         tI9OAIjFSBtiRIDaKfCsHj41lE3N9ZMUJimdl/RSH+pfoP2WYZMFw41AuXhMQwF4jLyU
         NV+78TGIv7ZtlLhksz+nHFdnPuhVYy3BOcFLRqXBFxRGJoGV8NCGVbEwR6qK2+SUn2rn
         8/XVBVSXR9wDdcKu7MDHseR6at+mn9UtJOeoCts29dXPTtcJM/9WHuOZFIUPMcKLKqHD
         oaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369994; x=1760974794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG/97FcPJjq5NmEgRW4PArfa7yqTL2l/aJZCar+bosQ=;
        b=UIwcKBlzx/u6Z/cZ3szWWC/NRRsYgMNAqbbWEQOqGunvsy0uWs4di+ECVJ+2LDpi+l
         TlyIUUjUGKRQAh00BsUiFtBqL8XKZc1vPNFO6DyLLmv2XcEW8+FDRZTZ/INhp6Zg4JiB
         Fhz64lqoiQfYAZQepFcrrOC1lKHYdyYIi35ATxSVHJu4B9AdSl3f7ugLwj4NVqTFRTi6
         D0COjAmrtqHPDi1v4k9OKFnHXgstUvA0uwsX3RllB/CiyxvtlcNePbjrhbnbw9L2Ckcu
         zHmXvW9DzAlMFT4KiZteaxVRBQCAxBG54RIdB8v5bo0CWFtWx7FXrQVhN/4jUma6c2Vr
         fNlA==
X-Forwarded-Encrypted: i=1; AJvYcCWotEcCcdWJx8Zuy+eqDiDhM15bRU2XHOgh66E2LBRWGtlk4KlVFGEhOZZ91IF3S2pLCM5iaWQut5469vQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmAiL3x9aUMGgk66KP3KXKu54hMoMEl7UzPAE+rx9xqFUMhKH
	N2gz2J/K1YXgS4w6ldWyyoomTwh0Vx4cxh4XuLAH3rgzZcXoBM21rBWjjgb/CwP/Sjy2WkjH4tm
	8VOkD+Ks4oxbajKep0g==
X-Google-Smtp-Source: AGHT+IHM78g7/9ceK5BgemHYhfAGssyyk28SSEXehcoYdtwkhhg6hYVEul09QjzOoJajkOTlNWCkbmyfjJw/coM=
X-Received: from edbm27.prod.google.com ([2002:a50:999b:0:b0:634:9afe:3dc1])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id 4fb4d7f45d1cf-639d5c76f3amr14705335a12.36.1760369993704;
 Mon, 13 Oct 2025 08:39:53 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:39:15 +0000
In-Reply-To: <20251013153918.2206045-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013153918.2206045-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013153918.2206045-8-sidnayyar@google.com>
Subject: [PATCH v2 07/10] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com
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
2.51.0.740.g6adb054d12-goog

