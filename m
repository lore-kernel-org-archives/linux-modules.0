Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795347516;
	b=ZVXS7QY0DSyP3RGKPZGhqOtCDtgfXBtjaFquzrXdFwzOOn+kwcDTg21dlICsa57MatOs
	 1ym7La2Bkv5nwKinas+iV0g4NsaVFaIyfYFrUfCM1DhrfyrdRHsWgEVmAgadfX2jMxuxP
	 BWbpta6F4Z2mz6yhovIwhtm3d3RrXvtcWLh0+T3fUiEYCVcUzFcLAq6lF1J4ZK5wkIGfe
	 YmEI96hF0kiywDxKVYkzWjDHOTZHVZAoyu9HCDQfSF5LktYUpD1bLWpxFKhc+Ezu1+YrB
	 PprKgRs1kQU799RyqKNiZXaQrcI66bTDYoKC2P672BE3iaMPl4zVq0lpUUndbMpME8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YVm0atOhjR9nDOLlJ4gPFa6rcD+/4hLxU/xQnQlbIes=;
	b=YvQxshiQfqBQkC9a2ZcoYqr0HeMmaIY8pvD9iVmMBeAyxECm1zXSdAyHiFGxml6nCJQ0
	 bYjf2ajDcnI1Cs/hUY33lexsPbf1KrjbDWrrlWkqnrtPs27ar5i2OfzW17b23pzH+8toS
	 Ku40pevUVguiM1dt813XS8DKWdQRBOvpCmkRtjj0ietw1hjgBIGq20j3v3GlqGScWQdU2
	 aVrN4cVDHoU1fo/ZlitrwUfV1H5uMAcEXF5UKpz0kT/i3G6AaDX2KgyHo5C4nNqstI1Fc
	 YW2GQXLJTEScchVwxUc1AvUK0PzGr2osnDnidyAXoPjS3OfmLnknVyyIp5LTJoh2wZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHLwRXTv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974C606A32C
	for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 11:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6974C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHLwRXTv
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adfe7a31dfso1674301fa.3
        for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 03:38:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795347514; cv=none;
        d=google.com; s=arc-20260327;
        b=tAAUfjMIRpKQ6zccAACWEndHqFFkrzX3lNsScthArOTusufxQTciZ6xFeEMCIKmqW4
         0+6JaEi3JJ3615GvDqAsftQS7Gvrws04D5C3Q4Qnmj6pbpxIahrqzLuJJPUs5fSqVkKg
         XLZkoI4kqMjuhH4rG38A1E3eObOc2G8WVSSM6W8H9++TkPj1ak4Q7dIZDGqZNszPDBJI
         QQT5KfOrfk2X6DmKMAZhl6NpoHt2UZztewCilzvhw6B+8T4cTImfspduJ3h0qzmFPtdZ
         dGzvZD33RfL3lpUU24m7OublD7ZESSv5JJpp7kW7sgeuJ1C67ttWyYYPLKWHfiOgcVZ/
         Z40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVm0atOhjR9nDOLlJ4gPFa6rcD+/4hLxU/xQnQlbIes=;
        fh=6YuLpIQGX7sDCBFrasjBpJjxRc3jAPC2BmRr31K+hl4=;
        b=R4DrVTB6rQoHImlxsT+NkNV5/0g2KbtbZ2D928p0PS34VPbj5V5/sowa9jQxhdmdz+
         LVPMBpaCTV9d5M+OO9q02/k4RFFgmYTr5NqPyaeYlgHP93TJaQeesGuxxlcRV6HO7hHq
         ExEcFi6QaU7Kn72BdIB3xpFPDVVXi0QGb2lNltSYPr1bfnw9LEoSAnyVdj6+RCT++Zz2
         nHuJ8ITxt9zuM0F58nGCD66DT0tw9nc1SVulH1fmluI7d3GdtgVZuPkya9j4Eqep+Dzl
         NB3aRFX1LnSKWUvEBPOShSEZpT9WlFFRQPzz4NJlte8YeoACH+PtiliulD9sVz9QImUt
         ybuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795347514; x=1795952314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YVm0atOhjR9nDOLlJ4gPFa6rcD+/4hLxU/xQnQlbIes=;
        b=xHLwRXTvIHOPiGdyOWAJZFVHXZ2zx9COFpOESqj/4DrI4UR32A5Zd1mLYswGv75WZ4
         nsZ4hYcHsCj4EfnxB3iaxLBSBkZ1VZBYmwH5S7Cq73q8HtBoCDQc1jiQvkYzTX+AGfRg
         NnlAYleyKH3HGWTnph7hRYGbt5khCdOYTPo0kq+QI9jzCS1ACJlhjphZBlhukDCnVoRC
         cWUTw77cC5R/+S9cvmguAITuS6HRxDofpAYoWWWoMr98EvtAAVSpiElztF5iOBmPdUGy
         XpoQweGZXljH0GjAwvN4cg+iFcqOPrLJIKwcSUqSOUvci9zXjj562KDDIrdqwEQtrPKg
         37Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347514; x=1795952314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVm0atOhjR9nDOLlJ4gPFa6rcD+/4hLxU/xQnQlbIes=;
        b=ciaRx5oxsj1xC6IveIdEsRRsG/wZ0OdJlEtIIZEZ/fL59d7uZQeIRt/yNKRObrxvXE
         IwntowqTmThMldsTvDEbQnmCHl85ZlqHnfUttd8D+gT4NfEG+7elc6ZLBQcONlTaJ8Xk
         Fq4opKzgHh3IIxejgI3395Xnl9mlkcKVjdnEm3p1/ox/fIRC5SDlVwaWYthdN4mFMyuS
         xz+4DnoZWRbv9KX1moMT59FyinVmlgbVEX87leEj4wyQwzgLcIkk3uV4TUUybGPU09lN
         QhagSOY9HA5ejz70BnZ4ZqDy2sdfCzVUPVY77BDaBftsQmPm/JpqFZIRn8/jQvazhee7
         87mA==
X-Forwarded-Encrypted: i=1; AL+hErHkXxwXT/v1wS4DeFlFE/ZsIAPrMLWAEK4Y4pPzq/+ZZGIEzPocqTp2YZuS2wtWe6Y5scdiflTPdUkueTLD@vger.kernel.org
X-Gm-Message-State: APuU4Z+3frJW0OUHSfY8XwboCl1sjz1Sv3bxNcJT0ZBI+HP27mBmZI/A
	ox5vs7ZdD+0r/VfbCOsxbue5D9oVTSXnwMF12MzGl3b35e714Tl69zuaS1iHP74//SgCnfMLulp
	MGTPFEhmgsPUFCegxkt3gQlMQ8UAvKq8=
X-Gm-Gg: AZFdTZdSmKzpD+Y+5vu/mu68iF0HTTWASeZ74WMYtjnG7bV688dCbpXQVBVhae32/9c
	z+VAbacCBMBMh88R2iorTbCJrcpKwbXSbRjeoSSgKvK0CWesZFCD1+rS69qeFUvhJjykJNDeM3R
	L5fzaTTLWoZ+rD4i6txwWaP0lXpFOZdAQM/yM46itM75GFHvqSLDzOp8PvanxoYXymuQY01+vPE
	6YMhx/+RsnO5+YFdvUEi9ic6xsSyVIHIpf60bcBPrx8RQQwvVT4paqhI7voKyv1rB4dhS4Kq5uf
	ktpc9at4Pn2BiuPhufstdkEkoy94cu6P07qzUVHfcuP3SCdF904Ylk0OLI3tsdhF++bXTPWf8Dv
	p2Z7jkVQ0JWaGNoJZuSy6e/pke1kHqynT4QdGxqu/P8q3b1XS7wvSpa0YDwdsvavqzXTS3zCzE/
	Pryv7YfSv5jZ4r0RNvS/8LipT/6cN37rIF4Z39cKpo3DtbVPxn6UuqwQQjNvZvcAvCQki3wZ3wU
	L4SLL5Q0SFQe0cEmNWPz3rYu9DiJ4+jQnNpt8U7BQsvKHAUlf/va2hZFoHPxN6zAojJN5+W
X-Received: by 2002:a05:6512:31c3:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c1bc76a33fmr3371052e87.2.1795347514504; Sun, 22 Nov 2026
 03:38:34 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
 <CANiq72kWXzP1SWUvhOT2k-rNjopnySXeBkjwrx63V2QUaLpnGQ@mail.gmail.com> <nh-eaa5d67e-6d05-468f-9f19-273bc5b23ad0@google.com>
In-Reply-To: <nh-eaa5d67e-6d05-468f-9f19-273bc5b23ad0@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 22 Nov 2026 12:38:22 +0100
X-Gm-Features: Aa3M54ofQVSiRzi-fgoVKnLP0jYbT_Rm3zSkFfSi2xtBRiBz58W07aP7BMXi-VY
Message-ID: <CANiq72mTs=_4wSHAjCJNdOcmODHzPf0ELY6t6vqCNt2E--XYaw@mail.gmail.com>
Subject: Re: [PATCH] rust: put C helper exports in a dedicated namespace
To: peder.bergan@gmail.com
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, wedsonaf@gmail.com, gprocida@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 6:50=E2=80=AFPM <peder.bergan@gmail.com> wrote:
>
> 1. Would you prefer I wait for Giuliano's series to land or send v3
>    with it listed as a prerequisite?

Either way is fine, i.e. in general you can send patches that are
conditional to other patches (within reason, of course).

> 2. Should I keep the KASAN import for v3 or move automatic imports
>    into modpost in this series?
> 3. If you prefer modpost, should it add the import only when a module
>    contains a Rust object and references a RUST_HELPERS export?

If the `modpost` approach (or similar) works, then I was thinking it
may not need the manual imports, i.e. the idea is to avoid having to
write those manual annotations if the automatic way can figure it out
when to add it. But I didn't actually try it -- maybe I am missing
something.

Thanks!

Cheers,
Miguel
