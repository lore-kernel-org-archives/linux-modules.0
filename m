Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676784;
	b=vJhw7wj+JkBNpGGmIc2rhQBSYubXIIWRip17WdvYh3Sw0izjTHz5PqkDy10M6kzjTmG4
	 CCPwsNwA6QbKyywGRWjgF6kQZgCZ6zxU9HwGW0mRSY3QRXH9/JXMzvBHN8KppJgMBFAlZ
	 HRFl2+rBxJej9mj1dNSyDcKqjdlXs2vAigj1DqPLHdXG5iDGuo7MGJnWjNwT3d5aID9fS
	 tgL6zWfr11egifMR8wyNzFGeO4lQvKbTWNFNSxngEypA/DMJpkxUg2BOM1HAAdzADflG4
	 2JAlvy5BqM15nExMVF8oFu9b+n7uxxige/syjCuaO4OKV4zrJvwxdsUjqIwrxf9dRxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=blxhEUIfGLP2KtavzgC8b8uBHeJsrYpy4EDXOcxW8OI=;
	b=AHNb0iFrvaTdAbQysZVXcZLmN8cGqyna3RQnLgM0gN7IYArvGYMaOIxeMMzFP4fUYmGw
	 lNzfDYJelSEOlSKuNIJXRqQjCvHPdLmAqLrmxHegxcLGw6f8hvtBRur/he2aPNu529Pi7
	 /t4qmlwre2Q1pvd3n8M90pr+XCmnvmJab5yVGbVGmSmnRAiIv3pcI7uHWbQ2lozMA+2/a
	 CKtqZnwXr4YJNhAJLgox+qykaIBIEmYnWCGASJ4HP86SShLtEl9Dg9+XptQC5GaVurU6k
	 W/v3CVGsNbBnZQiUD5NrYcq3I0vMkvS9SE0vlo1w0cRk8/vd2xmBSRy8YeNtqSrNFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jww261xB;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8E60A6F6C
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D8E60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jww261xB
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a2063be141so6980945e9.1
        for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676781; x=1793281581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blxhEUIfGLP2KtavzgC8b8uBHeJsrYpy4EDXOcxW8OI=;
        b=Jww261xBpSru1+0lRUM4SBF0V6fwOoSie6kmrl++BTi4hF385U5NGD8IevSuTcVuWo
         l88X9Tv9J4AosP7/V0zYZK+qfzCwHdbXiWsV1ALh2YXoIE5ynddg6iVJtiZjEC0v4GDr
         6EP+mUbKhXKAGNu/esbIhvKaOhs0dpFhBEOWwzMy7vZROOXVsXGON/Ykk7JOSe+lZmIw
         1Bye56bZwcN8yK5SwjmHIdGjpWlDw3a3egR9wdnNKaW40F4FhOwtkvwHaMSKPnDusMVp
         nl+UxQ7cDtIkY95eFv9HV0pgIPSIofhYJJMUcpIbe/8Ntfkb1n1h8S6Jl2xsaQxhFyb6
         XcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676781; x=1793281581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blxhEUIfGLP2KtavzgC8b8uBHeJsrYpy4EDXOcxW8OI=;
        b=s4uOOHV39seoidhe4bgCBpxxaqgCzfqD4Pl3luMv7Nxal2UZ6SrDRvRhGdO3fh8Of3
         x+FHRDZuDeBtLOmwhevfWRpI4tYgERWI18Rjw12oKTyzrg3WF7flgbEPf5P983Pd40SD
         2H9vlWR8Y27gFI1yx/dG9nViCZXa8CTFPpdT1cIHaK1WE9RdDT+Fzmds3CIvl+9Vp3fi
         ZoRTrmPVlYm0ekfp3fD+2lFYKxf2xwIj/Lc4L5ST3yfmTXi8H084PxFxqy4O4X6cauhQ
         OmBedyRCFyl9fWu6yUsctb89kdQwOSMfSv0t5eOsC1OMcsUODXvD+Y7aoeliR420VGqw
         MVDA==
X-Forwarded-Encrypted: i=1; AKwUvByKublvGug6kE8HAUDzoQTaAUCL6h9ELkJCln4Ak+BZquS07CCUb+sirx0eFxqwXIBEDRzy8OSPBTpzkYA0@vger.kernel.org
X-Gm-Message-State: AFq9FYImLTcDDUXzurtmSLHCCZ63sGtHSBnW1iIP5aNio6xRFIJnqrc6
	yh8Ye037N/ZAjCxkAkfomRSr7vp3Do//dxBejV3n/4Em09XnHFJl9ohy8/F0inmQtWL9Ys1CB3H
	+ccmmNYugmSfR1Q==
X-Received: from wmpj21.prod.google.com ([2002:a05:600c:4895:b0:4a2:677:24c])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f95:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a1fdd109camr111705995e9.28.1792676781351;
 Thu, 22 Oct 2026 06:46:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:46:15 +0100
In-Reply-To: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <CANiq72mN9JYVitqgsZ2GkdmPVWqHZpJ-WNMNviiHV6C7gQMUwA@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022134617.228229-1-gprocida@google.com>
Subject: [PATCH v2 0/2] clean up EXPORT_SYMBOL_RUST_GPL
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

The two separate patches now move EXPORT_SYMBOL_RUST_GPL definitions
into linux/export.h and prevent the emission of bogus type information
for Rust symbols.

Giuliano Procida (2):
  rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
  rust: exports: emit ___EXPORT_SYMBOL without C declarations

 drivers/gpu/Makefile                      |  4 ++--
 drivers/gpu/nova-core/nova_core_exports.c |  2 --
 include/linux/export.h                    | 14 ++++++++++++++
 rust/exports.c                            | 12 +-----------
 4 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.56.0.218.g1ec904b173-goog

