Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6641D14FA
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984823; cv=none; b=H2g6DH3nEugCsdczn4HljnjTrhC9iAZJlaGrrf9kPAm/o4OMnSZOGJQKiFZ18ViNcnm11KzVrKDJNaEz41BPX7vSUfyFRyCXWjTE99uf3Brq+tp6TjFTnnqrCmZjZXHImMsQZwFb8eRmfyHHQPV88zJLnzPM6vtOZPXPrWoi6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984823; c=relaxed/simple;
	bh=XKLtg6hasoIGAI7uNbbTgs8kYTxARwPlbSF6Jrbr4s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jE+gjlG4aquv/ertebJ24KvIkGDm9Bqfl2YNmxRoOhHaOLxTcyMXGWb7nRj4BGvu86POYEPW7U14j9+Ql7MAzZeZtGCc+V1l0wcjABZADkdvvWjTuZoxvDmvGL0iDq+LLishhiFLA2obd0A2s2n5nGo3jxp+kchYKPqyKyZg6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhwVq9dJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhwVq9dJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166d99341eso43490515ad.0
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734984821; x=1735589621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj7WTgvEC5PveVDeiSHDuXxxtWMFpPRYSD2aMV1KZG0=;
        b=AhwVq9dJ0uBoioMFQhYuQSehHM5yZZ4AL9rV6gAR+Hfhe4Ippm69S9/GOh+Hfl/crF
         A7EFZzWb7ayMdua6DkxOIa9R8lK7/4sRWwXsBuNPjGxOADt/HUtYug5hJSmBBEDCx7iU
         ZBYgEQ0lqSI1aNDhn1X7n0VG4y9FPPVmpM8L6hsSQCOnn/OEOSZLinsRiklYIYiQExz7
         KThuQr54iAGOGZJtUIjpz0bmARG1WeVn6jaYxG+LOYezX2m1+cFNMp494nLxsIasEjJ8
         q0IY5fThwQJmllcNO7iOo7K2izhasNbcYovQz9d7sGNhNr1/AMbdlyyOpBGp1IcTPCvz
         cSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734984821; x=1735589621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj7WTgvEC5PveVDeiSHDuXxxtWMFpPRYSD2aMV1KZG0=;
        b=aAwdOxy3h6EEicXs/+rrvKX07w5tuQjM/HmZRny7qYp1MF11mlDfBKObuI2INwHhWi
         IiPbScihQep4x99DN5tMXfed/MVCBb/WaYYKT17TrLPzuNK0cnOTFez6ae+kvOkqvcyR
         0NQWfWnBItmsIFVxECIg9hXv94FQ48rKce0yLIXQVMXr0W75c4NQ1dapEZ1T5YtT5fo/
         gEYdGyTTDal1ikkOsS7NSnXBwFHZxCWLMN6dKhdUNvlY7XkbdM6FBnwbKHJcTdiTU8uM
         GngLLh5b2/NZOeAsK3cTnljO3F0eOeHRmGOQ/WyrJ44U+xfwy3L2twSWwRjNHcXKEbPN
         GO0w==
X-Forwarded-Encrypted: i=1; AJvYcCU6y/r0rIugpb5rC4kiq1Om22lJ0KQ40X8+bPqeJeEfZpbErylqaPJcq6VNY0bR1tQZpdqp8UMF2L3IZmx0@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrgokFypfbWFZEwzFUJd/89+Ni9U9h+76bC2e68SwB9a+rIOX
	vPGHgCjCadHJ+HfUaNtOC3MeluIdpf+zWLcHA+2eUAeoAJVkXkSILDmvUdxwd7GRB9/6Eukp17O
	WiiGj6g==
X-Google-Smtp-Source: AGHT+IGkxGexGuNywu/k0KXqccYrQixwE39uyONt1ZNVUe9UCqKHxNa+Ck9RutuRSHwTduJeB9GIxlgPxMZP
X-Received: from pgcl19.prod.google.com ([2002:a63:7013:0:b0:7fd:53c0:aac])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:670b:b0:1e0:d32f:24e2
 with SMTP id adf61e73a8af0-1e5e081edf3mr24885139637.38.1734984820770; Mon, 23
 Dec 2024 12:13:40 -0800 (PST)
Date: Mon, 23 Dec 2024 20:13:33 +0000
In-Reply-To: <20241223-extended-modversions-v11-0-221d184ee9a7@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241223-extended-modversions-v11-0-221d184ee9a7@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241223-extended-modversions-v11-4-221d184ee9a7@google.com>
Subject: [PATCH v11 4/5] Documentation/kbuild: Document storage of symbol information
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

