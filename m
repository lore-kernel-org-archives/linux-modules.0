Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723142;
	b=xnwrBDrEQ86uMTXhuI/fIn9w9RO2LNajlLcVLKTWF53H/lW+mW23oWzzNv2L8VRYYYT8
	 CF64GD7N1Nvdw/BTW84CodTxF32PnbRN5mHQ+kvM7I0VKubgUY4buHnyuDlWIL59yK4Sh
	 azvDu+BDLyv7tUOAExu36kw5SOBUqEAj7bByOoG36EQsXIbH8/RJhVBHoY9eMVoS7OD6g
	 bQbm5ghMAsxjmwv3wVpvyjevxYokvNFUYMTsLEst1ZOwJ2G+Y5DEVOAqVKQ0U42+2L4iU
	 ZyXMDr96hrh4vFuWeOZDJ5piTzVhTVqOkU+A0QbjDoQZMkMPfADStPgrvUD+sV3UtHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ucTwJsfrEI4hG4ToLcJXFo+0eiVcR5dBAvRyAcGuUSQ=;
	b=R6B5pnxBqwJdYJEixuUTMSNfpAKpt2838fggsiuyKkUa6kIGrJbS8urOIDJPgeSg22Zm
	 WbPzsPcFK0dg8VSLKtfDJZ6PenKBcsAWc9HKNkjeUhq4broeBD5061zPlWWAjPyZLxPps
	 8PM4v7QD35ouCKHf81mjXsxAxcDFwkPRE+3jqJH/UVBsh9uLrYO0S+ZWOy9e6ObDnPEiN
	 U/fIjLpMwgQZ3Ggy3jaZ1CIyIh6SQxY46mBNY3IlmDBRF00eqFxkuMZwTVCBU+jEPRggM
	 hKfyoBVXP805MhbIu9CXR1ZhihGvGpPC6xCManBe+9AvyaLSAY76LUB5YMPyd3+z1gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cUIIDOwS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B9606A32C
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cUIIDOwS
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so288101cf.1
        for <linux-modules@vger.kernel.org>; Tue, 03 Nov 2026 08:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793723141; cv=none;
        d=google.com; s=arc-20260327;
        b=NcFdevV5LzsXoZlSqCZNFvRSsG/sSuZlDD6UF9OFhUP0gyMOPQQNM4to+sI6kPI825
         CwQDwsO6cSWVdBO1kRo6NBT35om6SabQBTNISr4RN57wi7oKvauQ3ZgCqOKl9w34vHUr
         o+TFvuwYtdv9ZgZexEX6xk0IqSwaptu2uIsgtunMRH/1N91icqhFkAPYBU7is1r/XbV4
         5aFV4SGoTKwhz4UhUHnVakC+bTEoR3p4Oj4CpUp6PNP/wkeAeI3e4J3YfeUq6YC+XZpt
         uaSTcVIv4wPSdoTcC4aHPMudnvSlMr2NHggoq5IdNxcBl0dg0fUfy+GKbQacfbTQJZ0U
         XaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ucTwJsfrEI4hG4ToLcJXFo+0eiVcR5dBAvRyAcGuUSQ=;
        fh=k5DkINjLkt6Pa1i+ZwlVdf/KlWxbQqgKZQ8qfzsKfiI=;
        b=fPW3CfIWxT4/HCm5jaEHmbR6fe6z96PjTkR7QY/wl0l1DaMJxceR4ZfMqJ6sPmVNPx
         DlwVAW5qwQ7Q7jwqxBupLSPN3jgb/8jfZh1o7ZY6NSLn0CCElRFuloAiex6vjq3hcH3B
         iPQBKcoyHwYsmFrcG7ZV5JMBJtEjuVYFKRrB1FIPxG1+HJ6PYMpWISxC7fjcTYZ7/+dZ
         4QwyiO2gVYSB4/XKJTMnb3M8cY6rB+OJX9r46ms8bYajR7gm3KchQXXBtg27uHjLur/T
         51cPZemKzs1YwFg6HNqQZSTUDgiN3GD3V6H26CA8zcwOAuZBiD1W1H162w4NKfp8qz4c
         t3Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793723141; x=1794327941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucTwJsfrEI4hG4ToLcJXFo+0eiVcR5dBAvRyAcGuUSQ=;
        b=cUIIDOwSgEY4sB/0Tg2p1iGB8ZqP+oT+zRWYbpJ5HDp4fFkm+00ZhLSRbuR1w60LEW
         v/5VgDjhNdTrk7C+It+m9RQlpHOPBKKJ8MIFzOSFtB8x1OyuG4X2s3u4rRoZu/ZfFV5H
         Kazq+csKerHRwdWninAXLvUt+3O5h/nVEi5AXCOF9iT+3xZCeU/uPt7XR77RdCWH5NRW
         TLTC2oJxRgwsHEhfTzkjustTzb6f8S34Z27msGHq4tfZ24CS8qYD+kcafFVm7P7Bd23S
         at6fseXnLSYGGN2I2uY6DnwYEb7hDJvQTMUDsN2LGq54ItEStcbdIx6aQJO2F6al54hU
         E0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723141; x=1794327941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ucTwJsfrEI4hG4ToLcJXFo+0eiVcR5dBAvRyAcGuUSQ=;
        b=OT7WtPbtJ7nxE+8urS0k7i8s1T33oaU4q6s5mEe0LS3emRpSjYVFxWvprMa7QfgQoi
         hINXnliliqPwbYxRS7Ls8GAK8bJrS6OQ2s2F/LR90okBKVYSYH4dskYoHtzNv328mxIe
         BNvlP4h9Jh5B8A2wD5cedn7nLmzHb4O7+RlZlni38NB+lQ7+C3AlchIHf9q+Cdn/yfp9
         2GKSHUNnoyC+ncs/PZi2DvaVUSPbf4qAnjHJCjYEAf/40+H8RvPMe4gcMSOGjycyahKZ
         abUMC9Wri7iOili2g8lJlFBr+C2JzjY0WsgMIx3/SJO4eU+XUeACyThis2+jMP8o2lFk
         EFXA==
X-Forwarded-Encrypted: i=1; AKwUvBx4ZOPeJpsXHzrSGDIy9DONYBtXDQ1SJQe1tUECUUDXB/cjkq5a3lyl35CTYVMiWPbtAsFDUwOPTLJujnAG@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lwa+dAZMX3+cldNj3NytAaPXxhZLhXkJA8WVszi/mv4K2/4q8
	Zos7TSZXJFAYWfxm75Die5xclgGdth5ucHwGbyqK815xSun0UJflA6V6PGmdeA07oDT6aao3Ww8
	oBJHe8byE6WvMVEGkce9tv6um1MfvWUT8XPIvqIrN
X-Gm-Gg: AYBFou3qgLfu9OtHRKdQNFKgUXJRD38ItqUHwmjlEGIClGl6f/P5Za8/4trvbUs4E55
	lt0w/hAvKN5P2orJso/92OMPgQnNN9YWX74EiP37Ri+09peXA+Vp8bhIpLv664abeg04MPIS1zc
	WS6lbQnvdwwjy60SERhVhxJq9buTIn8icZOIE+Xq57RH+0p1POI5kNKQS6HMSvhcucTDQw+plbu
	6QM2GT4FKnz9N56I1ZtpTXpAAhS8wtXA8mN8Y0pRsno5JDrVKi1qwemsaqIBmQihuOC3w6AL3hK
	bpQFHgTMQPox+dtoQulowq77SqRat3Vi5ZoyNM5eEliHb7gTSDy55z7aRYc52GEOH2eIxkZjUey
	4VrjpjDth1jNnQ9GS/1lmaG88/qgbjMoes517hrzy9CvHvd7b4x0R/0srnZz3dLJckgE=
X-Received: by 2002:ac8:5cca:0:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-549ba517bd1mr23041891cf.2.1793723140630; Tue, 03 Nov 2026
 08:25:40 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022134617.228229-1-gprocida@google.com> <20261103125814.258105-2-gprocida@google.com>
 <0ddac462-b4b3-4844-8a00-fbe5f043885c@suse.com>
In-Reply-To: <0ddac462-b4b3-4844-8a00-fbe5f043885c@suse.com>
From: Giuliano Procida <gprocida@google.com>
Date: Tue, 3 Nov 2026 16:25:02 +0000
X-Gm-Features: AclHuK-6CCPIkFp5_oqua3MDBxS7jekauX_rpV7FSKbhPTEfW6LwwMQZwtaQ9bA
Message-ID: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 15:57, Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> On 11/3/26 1:58 PM, Giuliano Procida wrote:
> > diff --git a/scripts/misc-check b/scripts/misc-check
> > index 40e5a4b01ff4..b39d731cb413 100755
> > --- a/scripts/misc-check
> > +++ b/scripts/misc-check
> > @@ -45,7 +45,7 @@ check_tracked_ignored_files () {
> >  # does not automatically fix it.
> >  check_missing_include_linux_export_h () {
> >
> > -     git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
> > +     git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
> >           -- '*.[ch]' :^tools/ :^include/linux/export.h |
> >       xargs -r git -C "${srctree:-.}" grep --files-without-match '#include[[:space:]]*<linux/export\.h>' |
> >       xargs -r printf "%s: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing\n" >&2
> > @@ -58,7 +58,7 @@ check_unnecessary_include_linux_export_h () {
> >
> >       git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<linux/export\.h>' \
> >           -- '*.[c]' :^tools/ |
> > -     xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
> > +     xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_RUST)?(_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
> >       xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present\n" >&2
> >  }
> >
>
> This is minor, but the updated pattern matches non-existent
> EXPORT_SYMBOL() variants. To preserve the current strict matching, it
> should instead be changed to:
>
> EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES|_RUST_GPL)\(.*\)

I'll take this suggestion which was also my initial thought.

My second thought was that if Linux were ever going to allow non-GPL
or namespaced
Rust symbols, the syntax I came up with would be the best future-proofing.

> Alternatively, I think the pattern could be made more permissive in
> general, something like:
>
> EXPORT_SYMBOL(_[A-Z_]+)?\(.*\)
>
> This has the advantage of not requiring changes when a variant of
> EXPORT_SYMBOL() is added/removed and shouldn't sacrifice any of the
> desired functionality.

AI analysis: Using a permissive regex in check_missing_include_linux_export_h
introduces 81 to 84 false-positive warnings across the kernel.

Things like: EXPORT_SYMBOL_IF_KUNIT, EXPORT_SYMBOL_ACPI_LIB.

> -- Petr
