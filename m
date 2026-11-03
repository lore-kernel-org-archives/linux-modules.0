Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725118;
	b=zi33NPeotyltsJP/bvOjgThH4tm2C1s7oHNxcMjTO5zY2OCQgqeCn2XPuBP6nuzMnS4P
	 9fUCL25gxqYCT2HmHBNq/ROFtFsZMxRomheVsGnrFe8xnuKE9f6V94YOMU9XVU9nMfvLX
	 3h0sCZtEEDNIi2lLhZ0VlVtU73zIETy2BYwW+nqH1wXo5GY/FELjSz+dy5mzb4FiPrWpP
	 E2p475PDSqzJWZZuHTqZBvHDkPnqkUkz/i40M5SFOEYGzTgJEUTRcjlA+Ut8ETJzqWitC
	 N+v/r5tOzkiosKVKr3+9Og8PBzgNCf8ZZzim0zjyVuuYABNfvcho63VLwsfb4PnkeIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=k0umCR55BSt9OK4xfEBoldGppWLpZx+D4qipWGdBea4=;
	b=Ex0tLZbFRX2mv8qO9YHDT+St+rkeAgag93lVjMRAMn9HZ4IUXJxgYGR9furq1YqJRtHV
	 ZHnLUp+yR90/AdgN7uVTRkGlbod+2ojFoZIUZXfEiP8Ax8D/OrqXnfZYxSoYCG+0M+Q07
	 WKpVKnuwniWVnC9FexssDxPqUA7xzVUf4CaECVERk3o8MG73KBTF2djuv1K/xvzc0Z+uC
	 +ld2R7J4ZUDdHFYNKyRbhHx3kh6RZ04YIEHu9aBrj56UBuhdvtX/kppLEBpchbsfb54P9
	 R8ZT4Lx+1KkmhydvklcoyLeAfOOUl8tmnOEJj+DCvsqspH5MdJEHPF+JGHWnMWzjqWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWbowDIw;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1C606A327
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 16:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD1C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jWbowDIw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b0a307487aso12593175e9.1
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793725116; x=1794329916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0umCR55BSt9OK4xfEBoldGppWLpZx+D4qipWGdBea4=;
        b=jWbowDIwzPSLEcLC9iXx44y6KCkRAmRJu1XlOpG9l5kp8tpfyintBdhLmjp0pNGCBb
         ncqgHKugspx/WB+pRsZJFKHd6kGXUJfavEM3DLQl7D9Y8TjBwxbVb/rItL5LyG0XGMeN
         agHa9197uFtDvnGMRPg247ctBTZpuortWCW2ZkzO82wsIIUdmlqI7/vhD/ZZYQ/c4a5M
         lSC4KBOwiucAMyvuoppWHyzwLecIGhx4BtjyU5/tlOQCEUeMDr1ytd2Uf+8vDkpfk01b
         bkWJAD+FikHuPJUu9BFTzeKo+gqf91BaL5Bg9vH7VxzWkCAJJ4aP9mvnLceSSETP0tMa
         wN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725116; x=1794329916;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k0umCR55BSt9OK4xfEBoldGppWLpZx+D4qipWGdBea4=;
        b=sArYH5yTvFDJv9ShiAK4IAS5wW3hRaDQYCbkvrKzZoJnFBgVHFqSmqgNAPca9NP/Nb
         bWIzp4yS/CC08HNHWlAM+qGXgIEp6bfm96DInck8yD1WQ94CAl7hsu2A9O/TM1GP/GDT
         /iFjTD05dL33/Ko4CWkURCfWfgdbgSzQER0DSzTbqncc9zxmkSGjWvKCBVem+8dcwo2i
         TVMwhvMv918K6v22UTHcVO7H+70LP5QryV3+S2f2Iag8casYEKJaGBtHIc/hJTIlqNj5
         DWhGCf+eTCMTjPcGbotb4sbqu7iMCNaTlg4FA7YHwUAviTxc7SyHl3cpp9W2v0s9JxUG
         VjWw==
X-Forwarded-Encrypted: i=1; AKwUvBwxUCGg+aRTDFzuSoObfBsD1XYxIwDwnXfKvOFSLGgdukFLNGCUAGZjp8M57S20mal9N+NBhFoTJbIbTYG2@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZJHq4tyGvdbCxau277NG7+b8ey7tiK/dTxvzMGUbfRvsudsgb
	7k8XPqQJ/PQ9EiXDdmi5GdxmzzbbAxUk0r1sFFcwIIilD2FeTste3kRgmm4WtrXn3ycZSaJaMhr
	wFoUvB948pX3ejw==
X-Received: from wmbh21.prod.google.com ([2002:a05:600c:a115:b0:4a1:fd11:6e58])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3484:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4b36def42b9mr44046845e9.19.1793725116279;
 Tue, 03 Nov 2026 08:58:36 -0800 (PST)
Date: Tue,  3 Nov 2026 16:58:31 +0000
In-Reply-To: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103165833.418845-1-gprocida@google.com>
Subject: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
From: Giuliano Procida <gprocida@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

Move EXPORT_SYMBOL_RUST_GPL definitions into linux/export.h and
prevent the emission of bogus type information for Rust symbols.

Addressing review comments, the first commit now ensures the moves do
not trigger warnings from scripts/misc-check about missing symbol
exports by extending regexes to match EXPORT_SYMBOL_RUST_GPL as well.

Giuliano Procida (2):
  rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
  rust: exports: emit ___EXPORT_SYMBOL without C declarations

 drivers/gpu/Makefile                      |  4 ++--
 drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
 include/linux/export.h                    | 14 ++++++++++++++
 rust/exports.c                            | 12 +-----------
 scripts/misc-check                        |  4 ++--
 5 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

