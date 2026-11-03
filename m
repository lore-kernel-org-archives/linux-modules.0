Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710774;
	b=l+4v0Zwq6kaddSdChJ0JiIIYZvCBx1uSgSchyhdPPGz2uThByEpaMb4v69fwR0Ac4ZhO
	 QowSmWyicgwxSFonI2w9+iXuPF+G7AfoyUJb84NcQJ0eBDkkZkAQ1D3/d5LyVmozNYhr0
	 X3onN7ny+KFT1/dBfNzhkXoYWfoea6zXDb40m2r43mgNxW1GXWaG0AgyOSu6gKLXYoCwf
	 jYxdNgbCPPXlsTHXxZ/rg1oDytNHTYXyxix58iWx4D1f0QAOhJwJ1VnBfBcTwUwjo1fl/
	 0RyRaY2vyvsc2yXNEcbjTBE+0m04rFMP/qZBWO24ESTmkcqoyhNR4BKabNBgKyjXi5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0yLyfS9yRL+bXyI3H11u0VIFJtx+041ioKdNuiUeDKA=;
	b=s3GwCzK+DNjuGZBun7F8VvjPN//FxTqiuTHNUK1zJ137Ceva2702W7yS8OQfNjv2kTG7
	 VYFSlqXr6TZi3XwcWAclme02tP4Gn1Icb7ewDYrO9hED74Q+18kY7ts6FY3EeUaUnkYHA
	 VkUzuyEI84mGCx4wwyP0dC84hmi6iDGzAXUF5IJ8EUP57cf/bdXPgeoFgdyl4t8qTUEmB
	 RcinrzRSGOsLmgUEcPTFJOaCTJSgGWwhYSReu56+JUUp7OzbJOXO8g+NTFzXRzcUbVH+P
	 h2Y6X7OlEn7X8Siwj4fVX+mndiAVF7vezmQhjSuCMIsnQ7fZ0mpdRBh81NA15Bo4nmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NMgND+/f";
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F1606A324
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 12:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD3F1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NMgND+/f
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df730c035so2903314f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793710772; x=1794315572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0yLyfS9yRL+bXyI3H11u0VIFJtx+041ioKdNuiUeDKA=;
        b=NMgND+/fJIWYFiTSWTWqhUoWYOD0pJ7ie4Z1bxIOg4cljZWjU87cB3mqyB9pjUKUTm
         GNp+B2oa1gUDfwXmWaDBxj4w1VCHFwq/3e5f8MofcQuCQfELjKY8ND9AlHDgi3mwK2QQ
         9QOZZn/y7gDTV8woze/w3vhOIZRdw+O3CEcPwqOD09ZLacdas92Kz5TeCyNkGEXoHi3I
         4XuwVv2Bd1PcDesEUWymq62K6fIgKKDKTAPRwKap5bpyao+PskcPWW/eDDCMKGlYz7On
         S4gyd77cYTImXqRzxPxn8+HISERFKqgoZyEMFgXURWYxPS6zsd+XMA1OvFnq4Flv9Y9R
         GXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710772; x=1794315572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yLyfS9yRL+bXyI3H11u0VIFJtx+041ioKdNuiUeDKA=;
        b=gHVrLT6jIqH07ZAd8SpJRqmP8SLqQGV6Ww43zZHoilZR/hlBy5kZx2BcjrXs53SHin
         1c7SBMRLKfpjo4GXklnZfAJY8hzhL74thiAhu8PxIWzASAnuyCfDm9XzG+CbmdQPi1TK
         0CL61r9O4CyzdfzCIwhfgDmFo1/dZA5YHU9nme11T3uW2Me5gsoOPfePII0tGj7JhNsV
         7orghOQBQbAkMlKzqa4qFsAdyx82IScsh9Twu5Rx0oFaAZxpxGd5bV+ttQM3hvEyLo9j
         OHcr6v8UdEizIbAgaAM3MYSJQnSzEJGYHwNDCf/5OOU6XDxZLUL7REbYg8+pbJITDglt
         lOow==
X-Forwarded-Encrypted: i=1; AKwUvBzO1H5wvbMBZdgS+SHeEUNU9EygqsMMB5emHgoS3kMkJwBp1zfAfEkzLw3oY4Y7AI90cynPayQ/KZwjcJ1d@vger.kernel.org
X-Gm-Message-State: APuU4Z8mvg6iXxFatCTnCqozpDmTRWAfviVwdjs83h6vrjt8z1hEpj2Y
	fVb4vtyCNdGKBcm0ruy/C1JqqX9sCiLPLhW++M2L4SQGXR6Or6DXP6tv5hi5aCBEGiMccmV9veu
	PY4ndJcmVZQVIaA==
X-Received: from wrbgl13-n2.prod.google.com ([2002:a05:6000:298d:20b0:48e:1312:61f9])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2886:b0:48b:1119:5756 with SMTP id ffacd0b85a97d-48e6e2f6739mr29434190f8f.17.1793710771862;
 Tue, 03 Nov 2026 04:59:31 -0800 (PST)
Date: Tue,  3 Nov 2026 12:58:12 +0000
In-Reply-To: <20261022134617.228229-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022134617.228229-1-gprocida@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103125814.258105-1-gprocida@google.com>
Subject: [PATCH v3 0/2] clean up EXPORT_SYMBOL_RUST_GPL
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

Addressing Sashiko review comments, the first commit now ensures the
moves do not trigger warnings from scripts/misc-check about missing
symbol exports.

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

