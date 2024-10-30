Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47D2296EC
	for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307716; cv=none; b=lpsjGZWQ4SFA4a4K6NSgaTrmVoadzIpauARsI+aH+VtLXatUF6rJemZQwKg0STQg2uYWDdrHIwMFb7iWawWDwR1XUrtd73iP8v0dTzelfTib3PNfOmbaqMpc8tW6NmdZNL/Do1gG/xMZUou5lqifU1E7CLywAwV0paEtx79i1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307716; c=relaxed/simple;
	bh=rksEvC6HZ/MrrqljgbD4UQU0K86C0fyQIL1Xtq9Es3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ncq2sszkevEF6pTV8sPoSl44Ovxwm0SwOapNc+mZgWtH0iYkBcFABAseR6JPiijvh9Mb8Bn/cWdN4uSQ7WzeUPWjh405W4Bl1qpHqQIvnvjydvPYJ+Dfu438L6UOBuj1C9YuaSkCP88+QSG1ES3DCS9JMiAmjCUbzO0783nBoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9ggQVr4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9ggQVr4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-210d5ea3cf5so468575ad.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730307712; x=1730912512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7eFA8HtUgZFV05J7QoEMTMnbx6tYPL9kZjt/pwvBV0=;
        b=H9ggQVr40WHUySbWGhCGULrEDKClOEiHXoCas9FRu6KjmY2U2NBKOrsvtepincrCB6
         wYFE7C+NZlG3c7jlundUVcS5nnexchQ5uSX58McROSCTp73uv+enbcVwuhEV0Z7TkdG4
         gvIeSlGWv9WDvPEnAxqRtVp4lHdRIczIIrxwJL9z1SknJD1jHn8XmrAHWYC2hhc/KaLD
         jNcSpPFee03hqHeQLXqrotFBZjmL8jiQ85g6Dp1jRH9Xw2uuWp1983sWaZDAxHaxTmxh
         V4aK+bAz1wLRBL1H0lRxjY/In/t3W5sGKrodcv07mLNDzzcUcxDjV7hA3yEKk3WcP5eP
         BCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307712; x=1730912512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7eFA8HtUgZFV05J7QoEMTMnbx6tYPL9kZjt/pwvBV0=;
        b=viIeoNQlWlNSRi51pkBvklKHb+lfJAOtYHDgNP/sIQ0pqUzqoMn5Cdqf86jmeNq9yG
         w2LYNgYs+5WilJbK+svdAUzP2p0hBZqpJfBFRk03Ei1/7Zv/wzozw75lwjczYeUjKS4H
         TUTb+OROatgY7B/NHFpI2ZMcJ3UMx/8/4q14rErlFjrXOnIZ0KO43bL3IexnmK8s393P
         iDmQ8ADotyiEA9dI7+wyOcdd+kl1uEp4RR9w4vT/smdjMYscOxRlZg6ms1CQVNx8cUjK
         lxAOYqa3RNSSpW0CKALm8+D9azoHoVPAyNv/50U0B/U1VyDL8bA+Fsk2jcsScvt2DABy
         CgRg==
X-Forwarded-Encrypted: i=1; AJvYcCVeMx4Z93zDN2iUVGt2jbqKk/7wl2qk9DZKpaB+cy6PnMJc9dAleo4BMSm0taXKfBkfxBNMwVo3hFBXBZiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrDGUxRfM0vgLDjo9ha82fnZmSR67qAtPDFu1bltNb70fkKG+
	oFGhw9ib7r7C86pOMsulMxijqfChHLiCObrlvnVl4e6XBkEyiC1bqZl5W7E5VJNigifK1csVqTi
	kDRvipY2a3HXXT7KifDbw0ipBDQ==
X-Google-Smtp-Source: AGHT+IFeuji1GvoYInueYeA2WpLljEcP1b95Twypfv+fPllRTgDVEPi5y36JJdk4mGTm6hE159syArTxkGm4qK6S4mY=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:903:32d0:b0:209:dc6d:769e with
 SMTP id d9443c01a7336-210ed3e47afmr348575ad.0.1730307712375; Wed, 30 Oct 2024
 10:01:52 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:01:24 +0000
In-Reply-To: <20241030170106.1501763-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=samitolvanen@google.com;
 h=from:subject; bh=rksEvC6HZ/MrrqljgbD4UQU0K86C0fyQIL1Xtq9Es3w=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOlKadESFw9Lm7oed/RRtkqsu5E/5f5WozXTDVWmHDAqW
 iFQ8+RURykLgxgHg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjIVAlGhs37+tc8uJK4WkvL
 z7N+VlXd3DmaWw4IPPWsz7uRlDvJ6hDDL+YpDQonlhzcKr4mp6rr80JBw9w/zK+cC3ufa17P2VT nwA0A
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030170106.1501763-38-samitolvanen@google.com>
Subject: [PATCH v5 17/19] export: Add __gendwarfksyms_ptr_ references to
 exported symbols
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With gendwarfksyms, we need each TU where the EXPORT_SYMBOL() macro
is used to also contain DWARF type information for the symbols it
exports.  However, as a TU can also export external symbols and
compilers may choose not to emit debugging information for symbols not
defined in the current TU, the missing types will result in missing
symbol versions. Stand-alone assembly code also doesn't contain type
information for exported symbols, so we need to compile a temporary
object file with asm-prototypes.h instead, and similarly need to
ensure the DWARF in the temporary object file contains the necessary
types.

To always emit type information for external exports, add explicit
__gendwarfksyms_ptr_<symbol> references to them in EXPORT_SYMBOL().
gendwarfksyms will use the type information for __gendwarfksyms_ptr_*
if needed. Discard the pointers from the final binary to avoid further
bloat.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Neal Gompa <neal@gompa.dev>
---
 include/linux/export.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/export.h b/include/linux/export.h
index 0bbd02fd351d..cf71d3202e5b 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -52,9 +52,24 @@
 
 #else
 
+#ifdef CONFIG_GENDWARFKSYMS
+/*
+ * With CONFIG_GENDWARFKSYMS, ensure the compiler emits debugging
+ * information for all exported symbols, including those defined in
+ * different TUs, by adding a __gendwarfksyms_ptr_<symbol> pointer
+ * that's discarded during the final link.
+ */
+#define __GENDWARFKSYMS_EXPORT(sym)				\
+	static typeof(sym) *__gendwarfksyms_ptr_##sym __used	\
+		__section(".discard.gendwarfksyms") = &sym;
+#else
+#define __GENDWARFKSYMS_EXPORT(sym)
+#endif
+
 #define __EXPORT_SYMBOL(sym, license, ns)			\
 	extern typeof(sym) sym;					\
 	__ADDRESSABLE(sym)					\
+	__GENDWARFKSYMS_EXPORT(sym)				\
 	asm(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
 
 #endif
-- 
2.47.0.163.g1226f6d8fa-goog

