Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBA1C4A09
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735937169; cv=none; b=EDHQO88x9ATK0S5eKp2YXow1Klb1trVYYjyWXf0o1yuOFqjJAG7hVaRsEl4cfCc4/3MO9qa6xKQU4He2UPIRXBbxPjy+8vmucjt5e0hcixmSaQBYBxlC8yfaU19abReLv85J32x8oWGArjmDuCgieF3KWTmjXbrP51+kUDuOBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735937169; c=relaxed/simple;
	bh=G8T+NnXPkjDtKGjHLSfjrDpCNmmPfEyUeqSk1ZhBztg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cz2rqrHIC2NnXKp2hQOFjsk8EjtEDS0MKL2n76nxVaCL4woV83e2nlBOpFbAuegZX93DvcsbzAh+b2AeLIB5HFMVoxTcVvCpiZXJJa4BmLlFuvxDF3fUMg0ZI+JQ60PT0I3AmP1VZQia8yDINEN5YHU5xousnTjXLzrLiBCf0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOOqG7pe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOOqG7pe"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163dc0f689so3638745ad.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 12:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735937159; x=1736541959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhebaHvwRpIK3ajuqUsaMJY6c1H8vjbSZoFxdXzqCTY=;
        b=ZOOqG7pe+H+7IYfiK6CccQY4KLNPb0IU74OwzhzyON7wH2QBJSxudgNaGpmTlOJHre
         V/7fzCeUEYUl52x+mcJQQVt6Y4nQQOHdPnxgauPenzy2pYB1EFtnYyS3g9KrGRIRnGmb
         XaqO5HiSeiD8gI1mIJMDdINJWdwysQspvO0AepMGTWNOAhm9pCET5z2c/15TlMmibgDJ
         Boq2FhKrwPYJ98ElQ0xv1Cir6GGPBifx15cHH4DrH6zEfErXHHjqUsxYJW71O3x/c5eA
         PfnTnA7MYZtXVAK5AEL7cTOiuDd070u/6GLNyQCOY/DeY1FS2U7MMbCxvz3hpVzdmfGu
         Jsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735937159; x=1736541959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhebaHvwRpIK3ajuqUsaMJY6c1H8vjbSZoFxdXzqCTY=;
        b=QQ0TMyBNUzjIooyA7RxpX5Kgt2qWbNCui8vBUcJHmsdxaBK6CX/CNma3ONLrgozaPU
         k4/E4vUjbf870X3FiCW+FL4ngJc96/xpX/X5qPHTk/rgmfZGOB+2Ly2i69xb3am/cgB6
         p3CK7kTno27twmYDjYNH5bD4LYzT2IkijGW5blchskWdzegkO4RJ1dvE6LiSW1dfhDXL
         +Af9qpb4kSPEVr+okIfeK2Wc7It/2dntbgahO5nW/x1JYpBm9DJBeDPFqf/lIqA62nlX
         y8Vt4RgqetT2tZnixywphwa7C/DR6W0f2QqIRE9PLZhALPwy7RBD7mCHOz5UBvo3+9Bl
         8L2w==
X-Forwarded-Encrypted: i=1; AJvYcCWFz81R8hGNaEmJMIdI6IMQfkEZYsFkZV6DgQkDgKwoWg5u7BzcTPl28qvyYhjpooBtjIl2L5UBdYuGcgJs@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRAVYloEJ6MKeg99YZCFfX5vOJSAyMFUWIkQXTR2jN60Je0rR
	ybyhWQw9nVWBEVg12uEfUcvJU3nuXZf7uEMy1A9rm83W/37CiiuCbjBwZknWAE2qQG2GGpf++/o
	98NqFvOdQo1e64g+grKd96ATCDQ==
X-Google-Smtp-Source: AGHT+IGhZCDaaYksOIbpNVPs2wy3kSc00OhYl5hw2lZvHS4sfDgLT2MlJ4U3veWoFkNQC2kYCfhaseTGKmrUILPler0=
X-Received: from pfwy41.prod.google.com ([2002:a05:6a00:1ca9:b0:724:f17d:ebd7])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d05:b0:1e1:a647:8a54 with SMTP id adf61e73a8af0-1e5e05ac4cbmr77933560637.20.1735937159097;
 Fri, 03 Jan 2025 12:45:59 -0800 (PST)
Date: Fri,  3 Jan 2025 20:45:38 +0000
In-Reply-To: <20250103204521.1885406-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250103204521.1885406-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=samitolvanen@google.com;
 h=from:subject; bh=G8T+NnXPkjDtKGjHLSfjrDpCNmmPfEyUeqSk1ZhBztg=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkVPpndtVHhySouOkF7m0o/qbT80J9sEuBUNadufYapv
 7naryUdpSwMYhwMsmKKLC1fV2/d/d0p9dXnIgmYOaxMIEMYuDgFYCL9Sgz/NJRfG36M5fp0JiQ3
 umHOV6/4eYc7K2atPJj5nyHMgYkjjZHhzZSv0i/nXvCaozlV7qXcjZuvTv19WFYWseDklISGE2I lnAA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103204521.1885406-36-samitolvanen@google.com>
Subject: [PATCH v8 16/18] export: Add __gendwarfksyms_ptr_ references to
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
---
 include/linux/export.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/export.h b/include/linux/export.h
index 2633df4d31e6..a8c23d945634 100644
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
2.47.1.613.gc27f4b7a9f-goog

