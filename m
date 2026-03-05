Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063703E1226
	for <linux-modules@vger.kernel.org>; Thu,  5 Mar 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729681; cv=none; b=p5mBgMiQn5UQau51IW9RxnwexhmP/hbMHQ9tNDqADot0MLMsaAKm4PZuOV8AKR8+mzKk5Ce/DIXSsSoVCxmTvtfXEzFdQrV8w8PoAjwqcfRi5bMvnRG2/80rjNaV7Yis1IDd3ydgVB+AHElwmEzFG64bBIwsw90id89NHuEOjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729681; c=relaxed/simple;
	bh=kyfTe0G2VwV3QkAhN1GPs2mavv4U3uviJwI2JjtwqUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpVdONMuuJCEUbqUmDgTwIRCu9KF212YCp/XOdOGpBIxqTtZNOP1V+NiJbpp5SXMuEV8O2KsvxPg4JjlH5Ib4QJoU/bv8bwSpN2SgFM/QG3Fn9SwJ4x5a7TKMfOALlJDOFNiSG2/nlioE4irw0A63tQd+ZhUisGvx2y8ogEG55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEMn0oXe; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEMn0oXe"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so84841935e9.2
        for <linux-modules@vger.kernel.org>; Thu, 05 Mar 2026 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729676; x=1773334476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccvxigw2nS1gLrg2HufkX6BPzMKDvSVZXWPtcb4rQK0=;
        b=fEMn0oXeALXszMX28BgO0W+VojAMuYJpiNcN//H9MdPHUEIPNIy/NjiYbjq54PqWvk
         +J1PrBFdGSsyyVKRJpu4tdN/40GC+7I0bq7vh7VDCfaB4wBNa08893G9vIUV6ps7UmfI
         LvJfvRg4May4r++G5LDpJgfN+F9xsl498OPOnDuW4LJYNwW7Wi7RQLltmTQst5XUs0sq
         u9lMGaBYP64Me5qOb7s0ErqVhflKkn1r2/MOii0KR6U+WCuI7xlk6+Tsdtg4CgGQz0ix
         4XAv8hrjqlBlFTdybdY6xK9VqjeCJ2oL4zLwvL5rebdhBMADhWVca29qHlbmb42OOC9Z
         L3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729676; x=1773334476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccvxigw2nS1gLrg2HufkX6BPzMKDvSVZXWPtcb4rQK0=;
        b=iVnRFe36ZTR8PTqLSlRbsMz/rRzw/F711w7m4n6lNI75tgTXIIFLOcKeDDlY7x51ku
         sMocT6l8EXj+G+ShmedAYFFgqTr/salibK1Tb5nn5i4iCqblUcThjnXgCf7lT1cl62BZ
         fPVLydUzlLhfbGL8WChqMhTeUFGVO1+UCgMqStcrRjHX7uiPdFm19hQDVlxrp6ENqjMZ
         6uLV7X0uYW6HyMA/12qfBnLREc4wfqRGMALWD2bSyXHT55hRuuDJ3/Uf+OtYDuCyf7Jf
         cf3uZuAZaYa5AvtiPasaBOiX9mRgx3fpTnpzbnDHHRiIsJU4qccx38Dnmjt9zm3378XR
         74KQ==
X-Gm-Message-State: AOJu0YyduFmBxQRvL6UsZVtaR5DYHBJUmFYMXaR1mrfbJvO8U382x+fL
	vx4p5CvvXT+kggHptHacf00+cIr3cruURNqC8JOusVhiWCxAXJiIp1VpjO+ht6hG7HVFMRemVcB
	h6yxISZwF8It78nfZfA==
X-Received: from wmxb5-n2.prod.google.com ([2002:a05:600d:8445:20b0:47d:5bef:a379])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b99:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4851983121emr109133495e9.6.1772729676375;
 Thu, 05 Mar 2026 08:54:36 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:27 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-7-4fe6eea27e30@google.com>
Subject: [PATCH v4 7/8] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

These sections are not used anymore and can be removed from vmlinux and
modules.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8f825dcbfae4..d2e4fa997316 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -508,34 +508,20 @@
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
index d7a8ba278dfc..23fa452eb16d 100644
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
2.53.0.473.g4a7958ca14-goog

