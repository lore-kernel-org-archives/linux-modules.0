Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95421ABBB
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694529; cv=pass; b=rjcQWZ2E5HzBtAMO5CMULweMvuWwTHKvtqyInzV+nYP5tfO7gj75NJy5OAq4mV03v6gwZzwwU3wNQluNadxoAuyKBQZaZ4MTJf5r45rmDLBTLstNY6pEcwSA228eyc2zC0WcKijL7sxV3LksjJB/T7JdswvnwS8FdFrSXAMPCAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694529; c=relaxed/simple;
	bh=fZnRJYjliLTSIR68GfBioenoxA13Fxczmz9EFPFDm10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9YAtN0WT57COZ+0f8zomq+sQVEbwFU9MKnrypI1i9N7Rd0oaU9RBXSRyVriYsWIw0E8c+ScY6eblO0DD73j8s1jrVt1U5sZW50q+ZNThjfF+J0Igz8oSH+e9VdnkmD/ngiLytJwsk21Lynmk2miS2hr2AT2tNOFEHFapT2Vm3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnMKl6aE; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnMKl6aE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384c94c9423so147911a91.2
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 07:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783694528; cv=none;
        d=google.com; s=arc-20260327;
        b=jqFOJi745/OPWHDKJaf1Flf1cYwEH+My6IlczMHxLEiV5YDuMlpcwvbJDEW8yrw5GN
         c9naiBb8FFnxcGdCIOCcRfBHxGORKDp09sWwicWBX6WE3gps8djWH5nx3IgfnuzXQGos
         8Cdpp2uEiqaO8Aoh/1g1XCSlJ0pIImzzNhtBRDNYEwLhprUSMZk58dI3d2yMuT4E3rY8
         lJXw5mXt5MIUOgzAQwjcVjBEpKiJCHaaYHfaUSnQxwPdxuRW5NWmuakBJziu6vB/7k1p
         RtxHN9tvQUFZ5QM94SZsmLJl9IPbyWr9+8qvh5mwvJiszKqC0WDeQ3cFZOacyHqJjuMn
         VgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fZnRJYjliLTSIR68GfBioenoxA13Fxczmz9EFPFDm10=;
        fh=L01Mk7GewVcNwBRf/6HHjxB0inCiBDI38SXbRK3pFVc=;
        b=iK3ih4i5+3HvHzTp9JuYPfHh20crDR+tiOxk+fgnk5sHkTMrsSCqyoTJ7KLRrslVmc
         h2mqBkEV9WL274ewRW6lHOGatLnB3gcYANNlaoWhdu5jp3Vfb9Dvm7MheoVT4/C40CxB
         ULqleca4PhpGuF5714Qxz0rKBlyi5pvXAMPWeLxAkrIebPKUMRC+P7zIPN5OXEF1eARs
         tCKSS7yaeYtrMRtzyov50xtdk5aBRwFd32973FEQL7YGahCYQWh7WkSb8IMIs0lnKC3n
         a3/8EiGqJN2pRrwX2aQq+/CZQPsNdLz23weVKAZRvhrIZHKt1kJHsmgmWEaKe99fCf9f
         vnHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783694528; x=1784299328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fZnRJYjliLTSIR68GfBioenoxA13Fxczmz9EFPFDm10=;
        b=hnMKl6aEpTf/fCX+Eg+VEcD2EZfXBOh3maQET7xNf97/q5wz95sC1ujgcxGYpbFsG4
         +r27gvAkD0ewsfXtgEtcDPura/pzyqCzPGXuJMOokTOk2ZUbVoKZHdkF+nll/JqaWtaI
         oFgFtmId3dmTgce7XotjaoYz1kEXVR6PKCIr4Ap9o0vIWitvW/S7dVIjkJYgc0dcK7iq
         qR8pKngS4UmH1zxynAGVP8s0If/PPFYzU63fXD5ThcenJbkm5NGUCapzYa/uoTrBTkJd
         Mvd2N+QSr7QZFGMgfF+ImLc/SnecUZIt78FvrZAKXdEQaPyvpE7gvEby3tE+qmcRMkor
         eOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783694528; x=1784299328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZnRJYjliLTSIR68GfBioenoxA13Fxczmz9EFPFDm10=;
        b=Tf4WvqrGvH96wVlFJg8E1XpMRu5EULEU22X8KV2ixodTH14PExU5Ase7eBjTH+R97C
         BkOrnmU8YoM/xQAQYD2FEJBRIiLbzy/8rWefb2Xnkuuhto8QMwLLENSJslWjWmhPFs9Q
         utXLR0dVRBkcC6dwVTTo9Okv5DfE2cYdYCEMRM5LdfYSrsqPiaB+aLLclGtVRD9LF8bP
         kWEIhat/x93jvX/UFGqgVaZugCpF7/a9WvggXBrjJhUhnT7sGh9BtUad20raqb8ibdvV
         TXKZzSWPXY9LonSAbuMEGPly2O+t3S9gOkTKIm38ocYdS14rvYkvbKtp4q7cF6HXuRRo
         Phpw==
X-Forwarded-Encrypted: i=1; AHgh+RpZ3e5dQEM4NswZHT1REV2cXScumVE5X9YDBs78or/GtAqHkVy/JeGrwrwMiHkfNDeyLLgDz4VTFM+JoOE7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbel2WdafKopaH51FH1yHY/W/GDzFT7Lc6qtHIsdp+/aPsOKPY
	6vcTtx1vmlAO+zwCY3bEuTYIpvzCKjMLrGs2+gXnokQedZ+TMYwNsWbF/HlTgvufqEkNWc8DwAf
	rPVtjgKE6Tgqe9ZSDwwRs+9FIUyvnRCc=
X-Gm-Gg: AfdE7ckNwD3Ps97GXQfCufRSXBz5+G57NcKJUk0GW8dzKjYWjvo2ir/X2o8i6fZQ8FM
	0C7mZHdLPgLYLLP4jEXXs9RIG3ykF2DgZRMKXZMBMaeOxcSvTvoWfYJfql/I3yXhZNfMYMmMKPA
	N5MoG1W0QFrYJHHoQAwP+xoDOzuC7c/PL/tB2HADJIAl7Y78WbaAr+VJyExqOamp21C7BxdkNwt
	DFF6ETSr3HtkwRfYyrUAkhvSD6QVmnwIGZTQPujaw3v+JIRpqW3wk4e4YP+owXfSi/mtpCJIGDh
	8ayQewq7QUpG45675Ipb1m0dPRiBGwQj5mgsO/jIAAbNHU7K5joGPOSMdekwVw6YdDke6s92Ci5
	QdciL8/FbW7OSQIKJeJ/LOK4=
X-Received: by 2002:a17:90b:3881:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-38a1c1b0a81mr6904214a91.0.1783694527589; Fri, 10 Jul 2026
 07:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
 <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com> <CANiq72m3w7L5CmAsFvOpSh_jNk4jL8+A4vz8GEp+E8FY=TJcRA@mail.gmail.com>
 <30e500ce-e9e6-43cc-bbdf-ded7c0ae56cd@suse.com> <alEBInX9gD1M5NAr@google.com>
In-Reply-To: <alEBInX9gD1M5NAr@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Jul 2026 16:41:55 +0200
X-Gm-Features: AUfX_mwgK6QohPOXWRFfZuE1sgrPdYMmuLLdDx_yM4D0tdqeJa0YzC1RtoqfzLA
Message-ID: <CANiq72=J=5KGq_+nurjBk7nGPeP5iB6sTmZFBdRd_QbPSMZm7w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 4:26=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I understand this is probably due to a new function in Rust stdlib that
> is no_return, so probably not caused by this patch even if this is
> triggering it.

I can take a look and perhaps push a patch via `rust-fixes`, which
would make it fixed by the time this one lands in the merge window.

Cheers,
Miguel
