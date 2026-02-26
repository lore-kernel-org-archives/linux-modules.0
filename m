Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27B3161A4
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149661; cv=none; b=SrLLTwTkd+gUZh5aLNtCnQ1HXoS8VWTpMe2huM/UhiPLOjYoaGExdGNvl2Q13Vt62+gLT6PhwTZs41k3uhk8ba4YHrl8ytg9cGC1bWMYTpTJc3Z9+YLDTUNWVNvweT9mQtE0/jVrvwaUKVYfJDHNb08HqYOX+9/2y1dJdwxivt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149661; c=relaxed/simple;
	bh=2JZ14oqyop+OfbJKe2VgqDVfV2Lq3g8h2Qdja2yt5Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WgIHKh/H+mws1C+xmO28doC4DPlxBCaxqsC2EZ9dp5pyQ+K7mKxRxsZ4Oblurqbgl0MHh+Xc+LNrh9y9+j8C7Ta3spxO0TocwdNQKcWOwURRUn86EMv7Opjz06N6ks2tQOi7ZRE2lnMt2gPBsWCoA2efm7ht4cEcvw/TxJE0sks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENCSd3cU; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENCSd3cU"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1275750cfc7so2116659c88.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149658; x=1772754458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/k9W3puS9VlvVSvbP2i2HOOhKsYSW79uIt5oIhUdqFY=;
        b=ENCSd3cUnMGC1ERlOrIePmspmhoZmbfuT66oU4+H3HFMbQ7Zrv5Mi711Y3YzsB2sNn
         DYJBxyL18UrykZbkVR10gESg6yOhLa0m2itDCSv7rDMyEbQcm5exnfXI6gugOZkFRL+W
         O4aoALh4Fl303a7aqKCGjyCjtMcfuqvVROO5PGmgXu4UYnb77myZ1Qf5KLVwruvD64Z8
         AClqDPXoeIvsA2GAyWstZKGKYyr6dJFaevuWhW2omHdzPgcJ7NJ2JLUxWa5Ot0uvzHI5
         ZlUYbeQh6UpwckSfLe0sAKyAHEVsQ36S4BFXERPnsuDXcXJRerPszYJsV/fWWOjU4TK/
         rupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149658; x=1772754458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k9W3puS9VlvVSvbP2i2HOOhKsYSW79uIt5oIhUdqFY=;
        b=dW1ckgLhrk757gPzWmjqZtPRq3wLvgRw8fR+Fo/wF7Y5LhKP5P9j8efq305UTvKjbV
         cl3ZZea+TbLnpLFlkBsXlaQ2xhYipnqcNHZYhv4voVYb6YyaNtWXAft2zrL7+w810ULz
         3jVMJZhoLIcCKj8UOV9i4VI7Y0DAadT1Y9YEZupWsqtawOb4L1MHq2LWWOk4IT2ga5qb
         ki0ITM1T/8MjC0CkNqq3iS0MFlC4d2EX7s/rAuT0wM2iyGHwoD+dzfSp6Obsye/sBvIw
         UEd5ozVwEXbbQ3dcnd/1XESQRCL3AhNrcEhhdYoqnmhFzD4+IzJBD4+qbJSP8/JdWuNj
         BO4A==
X-Forwarded-Encrypted: i=1; AJvYcCWzniuut4jhdVGnFQUxe1LazSU+VLi/Js7zzj4Ah51vXDpG2lOQIu+SlE9Vaf3AvByYDeMBE3suJgqtA8zM@vger.kernel.org
X-Gm-Message-State: AOJu0YykZr7XmvcwjqSs6US/0CJl6SYQn9z8UBt5UlaWN2mEzB7VaXR6
	f19L6wxaCuGX/67UjhxEvamrWksRFBLf5vxp261GRgq8pM/Kurt1z1m3
X-Gm-Gg: ATEYQzwqc1hx6lTWk8P9loepvusSdKiAc0685gh1GRZVRqI/cJIFw6LPPasXgHj/nrW
	oM0/1OLuxVgzCNWp6QQ7pG4X/1ghxf2Ct5kDGDaH2hJ72cfjSactpokh3tG3CSixonhomQqO31H
	qqhqgGHWIxFWkFmsk+Snfn36fNMf9G5LNxbxl7GLV/3zD+lcHLHy25L9wAsdAyYr0LV/M52msrc
	MnBC/hLvl1hFZronEywMw7K2htnoh3v4IMnvdxmlytOOVyVMnVe73o9+Tuk7UpEjEeXFv8LGMSR
	ilN1J1jkMGQV9biGoFrEFBpoxJLkrkZUkGVDsqq61oDbQ+lify1K/NKqklwWQl9xEIpBrAsQGYq
	OOHBmD5KUvmWaP8Nn1HF2hQArbaRdtHDygIlMvFruX8ZdZr2+K4Db0CL/Avmink6U2N7jC0V4i7
	TWwQ2brlaSampmae/w+16p0E29+PapMk/0gB1YCb1EbY8BqWuPLhMVr4R4p2YKff0y6Tl3h59NN
	Q==
X-Received: by 2002:a05:7022:4583:b0:127:5cda:fb7d with SMTP id a92af1059eb24-1278fc2c5fbmr491113c88.6.1772149657533;
        Thu, 26 Feb 2026 15:47:37 -0800 (PST)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm3990909c88.5.2026.02.26.15.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:47:37 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] rust: module parameter extensions
Date: Thu, 26 Feb 2026 15:47:26 -0800
Message-ID: <20260226234736.428341-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series extends the Rust module! macro with three capabilities that
are available to C modules but currently missing from the Rust
abstractions: string parameters, early boot command-line parameters, and
configurable initcall levels.

The existing Rust module parameter infrastructure supports integer types
(i8..u64, isize, usize) but has no way to accept string values.
Additionally, built-in Rust modules cannot register parameters for early
boot command-line parsing (__setup / early_param), and all Rust modules
are hard-coded to initcall level 6 (device_initcall) with no way to
control initialization ordering.

String parameter support (patches 1-3):

  Introduce StringParam, a Copy wrapper around *const c_char whose
  memory is managed by the kernel parameter subsystem.  Wire it into
  the module! macro as the `string` parameter type with a dedicated
  kernel_param_ops (PARAM_OPS_STRING) that stores the pointer directly
  into a SetOnce<StringParam> container.  The rust_minimal sample is
  updated to demonstrate usage.

  An earlier implementation of string parameter support was proposed in:

      https://github.com/Rust-for-Linux/linux/pull/110/

  This series takes a different approach for StringParam by storing the
  raw C string pointer directly rather than copying the string data,
  since the kernel guarantees the backing memory remains valid for the
  module's lifetime.  This avoids allocation in the parameter setter and
  keeps StringParam as a simple Copy type consistent with the existing
  integer parameter design.

Early boot parameter support (patches 4-7):

  Add ObsKernelParam (mirroring the C obs_kernel_param), extend the
  ModuleParam trait with from_setup_arg() for constructing parameter
  values from raw __setup callback arguments, and integrate an optional
  `early_param` field into the module! macro.  When specified, the macro
  emits a __setup entry in the .init.setup ELF section, gated behind
  #[cfg(not(MODULE))] since this mechanism is only meaningful for
  built-in modules.

Configurable initcall levels (patch 8):

  Add an optional `initcall` field to the module! macro that accepts
  any of the eight standard levels (pure through late).  The default
  remains level 6 (device) so existing modules are unaffected.

Matthew Wood (8):
  rust: module_param: add StringParam type for C string parameters
  rust: module_param: wire StringParam into the module! macro
  samples: rust_minimal: demonstrate string module parameter
  rust: module_param: add ObsKernelParam type
  rust: module_param: add from_setup_arg() to ModuleParam trait
  rust: macros: add early_param support to module! macro
  samples: rust_minimal: demonstrate early_param usage
  rust: macros: add configurable initcall levels to module! macro

 rust/kernel/module_param.rs  | 160 +++++++++++++++++++++++++++++++
 rust/macros/lib.rs           |   9 ++
 rust/macros/module.rs        | 179 +++++++++++++++++++++++++++++++++--
 samples/rust/rust_minimal.rs |  33 ++++++-
 4 files changed, 368 insertions(+), 13 deletions(-)

-- 
2.52.0

