Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE71CFA9
	for <linux-modules@vger.kernel.org>; Sat, 23 Nov 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732321167; cv=none; b=Qn8beVX6v1U6DlOgAkd+ftq35LMFOwFp/HXCdSjYxIYrQIC4DZv6O+ZkSJOC4bAvbustnXy8e0ZPEpsChVddIKqGWh1B8FeR4YKbffTN8fTWNpxr4iGh9+iyu70XoSelOz7gD7bNvX3k+c1RFNbJxFqMGfZ9tT94hmnuAqS1e5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732321167; c=relaxed/simple;
	bh=C2iRNRCBIbNngHVZfY3T3X2W51MTV200R2LoLraROFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EByD0pN3brdmewZPlZh0pLMIepY1TKUTlnELh6LTbt32cBiDFpe9/VKrAH7hsKN1KsbLf45yT9PHnwffPY9YMWpu7rd4W8KSMplu2yoEKzvcaSEuq/Hg9vNSnHVMFtY/kkLuPC2fDMlOe4xluTCOEGwA/ZQD/jhRCBzcU2GF85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVO+oQIu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVO+oQIu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee86f21b2cso49045947b3.0
        for <linux-modules@vger.kernel.org>; Fri, 22 Nov 2024 16:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732321164; x=1732925964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kii4UoP5f1YtphOdoxMErS859kUztR72G7iPiVSrt7I=;
        b=HVO+oQIuEg70NgAhfz35zo6fPF8Dv/pBcVnmZI6XNb7vuN7S7Vywc0gqUMbCTDjtFp
         yVkTUjKNY0XAVnxDc9wVfzaiT460iNQeftt8Dsp2KkCy3njT4A7gCfv3/BkYlP+L8XxF
         h88KEmAoHo7QXCfE3AnJlMwXASVBTovO9b3FysdhNRY6xvVgrHaNm05L49/LShTTw8nL
         k/tWCHbM+ocF+5Yioya2Ag0UUSV313uL8hdAQ5WO2S3VbDHAX5heS07EBlpDDEaMB7NT
         KaHP/j08Sd1sshp9ZP+6fgEIspX3A0psayemCq5H1XBte+Z6Ohy5imSy8eqhljyXE3Ql
         0nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732321164; x=1732925964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kii4UoP5f1YtphOdoxMErS859kUztR72G7iPiVSrt7I=;
        b=AsZI82fup5wsoJ4VGpqQESxsb/4h8S111WQMIU/JEMgVteMhO8U8MZGbBjasNHFxYZ
         lcK5w/Wqy/RMrvELBbaGfl63aRznDbAtdZWlTEhraiEsvV0jtzpkI6qXfJaqFanJNIGt
         rkNPl8ugzo3ekRB0tYiZEvE5aaDCCaNl7MQIZwwjGfXGc5bGlhb/x3yccJPsGX0LXvA6
         V2uEw+Dfwz6MVBDYtEnH9TWkZMYo2KnnVCSKlatYt7z5IyxzHAFMX3jLrv52BUQ2AfDv
         8NiMNFXuo2UPetwuDapwh28Uatc6wqnElZRIaOoQurE6H3TpoB2i72hL/gq5jHk0lAEu
         3khA==
X-Forwarded-Encrypted: i=1; AJvYcCVtjTPnegSp5NeF6j/FPHtgs3r7LwV2smwQo3mBLRpvnoyr4LBecFyX8EoHXy+Q3YrXlFjkQtJ8q0l0//+C@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHtGIzp2GdGdBoWZC9mI1EtoPDvYDEMbhU89E+/us5C9R3N9+
	D4/KCLwWrLFhQ2Sj0OirKQjAmmCFiME/ni4AaLL4np1Np0fvuD5ARjLzCAeLkBnym72sffjdDQg
	QtkJfWA==
X-Google-Smtp-Source: AGHT+IGb1VGXLdwbi1WBz8V7ppcCesD4JE4rdrLccFX+ao0B2BRxHgYqoB65ydiX9EwBAmycjRCA8My2MJ53
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:408a:b0:6ee:93e6:caac with SMTP
 id 00721157ae682-6eee0b7a491mr26577b3.7.1732321164359; Fri, 22 Nov 2024
 16:19:24 -0800 (PST)
Date: Sat, 23 Nov 2024 00:19:01 +0000
In-Reply-To: <20241123-extended-modversions-v9-0-bc0403f054bf@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241123-extended-modversions-v9-0-bc0403f054bf@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241123-extended-modversions-v9-4-bc0403f054bf@google.com>
Subject: [PATCH v9 4/5] Documentation/kbuild: Document storage of symbol information
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
index 101de236cd0c9abe1f5684d80063ff3f9a7fc673..c32e3ed67cd26070f6929f6ad98c4308a1ab71f8 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -423,6 +423,26 @@ Symbols From the Kernel (vmlinux + modules)
 	1) It lists all exported symbols from vmlinux and all modules.
 	2) It lists the CRC if CONFIG_MODVERSIONS is enabled.
 
+Version Information Formats
+---------------------------
+
+	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
+	sections. Symbol names and namespaces are stored in __kstrtab and
+	__kstrtabns respectively, using a format similar to the string table
+	used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs corresponding
+	to exported symbols will be added to the __kcrctab or __kcrctab_gpl.
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
2.47.0.371.ga323438b13-goog

