Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612B1FC7EF
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925833; cv=none; b=r/tm8rShcEufpDzdTtHuN2+Gkl1EM+dMlySXbz18jmivMfWeJ0+hxy1PP0HoXVpKk91BrjObynezkLr9B2IzN45tzfuD4mFl3FuF+4UBUFH0/CLIFjvo0CCu3kEKY1/TuUHnPOyldBY2Gu9ul1Gr3uOmzMDh034GYOpeBkNXR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925833; c=relaxed/simple;
	bh=XKLtg6hasoIGAI7uNbbTgs8kYTxARwPlbSF6Jrbr4s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQ5HVowWom0Is2QaHesXq3rQsUCiCZEYI+ouR45mFtceStUWrpb0msu0w39N0V7+UomeGIeAyAUEuieGZQL8/KremnfoGWNO6aVdSPSUmB5lxSYahqznJHC6+T37Ao9wYTCnMM4yMWZXWpXo2BGQPADyjQY/Zmp5s6fykwsirTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o86r0I4D; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o86r0I4D"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166464e236so297379365ad.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735925831; x=1736530631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj7WTgvEC5PveVDeiSHDuXxxtWMFpPRYSD2aMV1KZG0=;
        b=o86r0I4DHZ7ar67MRrAbJ1t7K+8JV18Rykqz+2j5AR8dC2S2O7KPHhCHT8EfCalw5c
         eG/kiYkQ1bqYMtZPT+izJVTKJYO6mR4lQLGjlv6WmBkIO+90xBNLR9aIR2BPuOg6bbtH
         MEJS5DL2ZnFf8xJWmjTGi9eZeuyCmP0+x6TECR2PhfkGA4UgPwBwR57apqFvMS6PzETS
         JWVBD0jTTzeFMu2hPjkDo7UuKwJ4REQDoKfoYmPjx5z4XxEY158FvjSxGxGI8GbcKW2M
         rV5lOivQYVIppnm3JCiBJUunfAD849H4qJAEfUU1M7Wj9jSvplJojh2r5Or23i8ZF7bO
         yfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735925831; x=1736530631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj7WTgvEC5PveVDeiSHDuXxxtWMFpPRYSD2aMV1KZG0=;
        b=WdbFcCd/krfis2u6Rfkl0IUFumUkJYtkJSTqhWQLzyvsiPu3TyxUHJ6Xmrsu2lXmFb
         ZsDrM1G6lwFQ/a+wqpxfdnluFEzfTzYN/Uts+kDb1FXX0oVZ7COcBW9DUWYekLK2fx+8
         tB/rOMliCJpmnbJHZllvSIZY/10Xl5a7Y8bYcDjvNX0DuIdWnSRjIRy6a79dg55o83wW
         2U6G+LlzDOI+rGFskTfPKdU+4KPcgX1m1NAsk6OKVWkdQEK+Xdh/FLya9+ooieShOCnk
         WPBuGUmX4ZcmZHoDsm0j5gypKq8vNAq8Gp0FH4v5d0TuTvNHgbJ7MKVp95Qws727YrXQ
         W/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUUXWTl5mpOzUUniyBwkSCCrNcuVKMemXST+FyeWBpq+v4sXSw+QG5NMHa3O851cUBIR2zCZAKPoZb3qf02@vger.kernel.org
X-Gm-Message-State: AOJu0YxPphCB+oS8rxLxKRr1Vox3/xS4Ikv88AvzFJsfSrQmaP/lby7u
	OSaSiwzQlnQlUJdYlhNz31SMDGqZK8PTOPa/GMC084sih8pmKjH85rwzherb/CUsPcXNHQTW1cE
	6maLrfQ==
X-Google-Smtp-Source: AGHT+IHZ0twC4s/yHrcsEsKNA74OoGtTi2fcBYqyj1/Wzm1McUmOCRGVGCQFvoFNk5F/mHcfXJF/k0Zi/OaA
X-Received: from pgbda10.prod.google.com ([2002:a05:6a02:238a:b0:7fd:558c:c660])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dace:b0:216:3732:ade3
 with SMTP id d9443c01a7336-219e6f25fd1mr698436625ad.35.1735925831330; Fri, 03
 Jan 2025 09:37:11 -0800 (PST)
Date: Fri, 03 Jan 2025 17:37:04 +0000
In-Reply-To: <20250103-extended-modversions-v13-0-35d87c65ee04@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250103-extended-modversions-v13-0-35d87c65ee04@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250103-extended-modversions-v13-4-35d87c65ee04@google.com>
Subject: [PATCH v13 4/5] Documentation/kbuild: Document storage of symbol information
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Document where exported and imported symbols are kept, format options,
and limitations.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 Documentation/kbuild/modules.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index 101de236cd0c9abe1f5684d80063ff3f9a7fc673..a42f00d8cb90ff6ee44677c1278287ef25a84c89 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -423,6 +423,26 @@ Symbols From the Kernel (vmlinux + modules)
 	1) It lists all exported symbols from vmlinux and all modules.
 	2) It lists the CRC if CONFIG_MODVERSIONS is enabled.
 
+Version Information Formats
+---------------------------
+
+	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
+	sections. Symbol names and namespaces are stored in __ksymtab_strings,
+	using a format similar to the string table used for ELF. If
+	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
+	symbols will be added to the __kcrctab or __kcrctab_gpl.
+
+	If CONFIG_BASIC_MODVERSIONS is enabled (default with
+	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
+	CRC stored in the __versions section of the importing module. This
+	mode only supports symbols of length up to 64 bytes.
+
+	If CONFIG_EXTENDED_MODVERSIONS is enabled (required to enable both
+	CONFIG_MODVERSIONS and CONFIG_RUST at the same time), imported symbols
+	will have their symbol name recorded in the __version_ext_names
+	section as a series of concatenated, null-terminated strings. CRCs for
+	these symbols will be recorded in the __version_ext_crcs section.
+
 Symbols and External Modules
 ----------------------------
 

-- 
2.47.1.613.gc27f4b7a9f-goog

