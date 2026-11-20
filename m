Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795171758;
	b=nqlDZes+Da+1JV+dgqYQ6JHmyw9Ut1B6OHHedwh/Z2Ho/Ue1+/GPF71Ga/q4+IDZypXG
	 vXf68oDmeS6Y8rE39/69sB50hHjipIBLhHqADj3J2N8/l+tzuwpJ4y7teZEI01KWi8FTk
	 cmgDE8Qm5btvRPiIswiAxup1TvBhfJFwxpclrQpjlJMKUWEh5DlSq6q/lGm3RocrDAGBa
	 B4dtxQeOXy7En26szC4FMAZ4bO0J1O86AqABdWEaun+dF12h8Q0QlfHSZUW4eQW2Hikho
	 9bcX+Hnl8NE3+P/O44/wvF/wfRdU+ZS9T27gW//lMUu5Xd3ibCuQ3Y7JgSjizn4EQlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dWYxYowsGCBLSnSh6cLqulqT3GbnJrbr+1e6JgGH388=;
	b=lPpdxtqjSPiVZ9hTXU5cP24xoDNLKu+Q413jEzObXUlUZvdbbhGAvsOoKNgGQTJNqtgW
	 WpSH6mbrQxGyAxDAxWFGuW/4yJYmOYHnx3w6qH1w/rleTQjLinQxRTBJgBS+3hVfojnAn
	 Nj3sCArz4Pn8Pk/dE5Ejngxd/E/4NNlaZh65R5aOwXbOGf6mwuJSfzha+XFv5IAMjHn9F
	 Hv9wyAnTZFmmqyEB54QgMo/WG1+C73pluDPOtMgUFtWL55OLGnyBfDy9JznF4le3Bc6IC
	 NCn4IaiGmlnUbI7tKD3ku6dp+72JaAF8C4v01W0nIFwiIfn//Ojs9WT0+NCcAcmcTbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PEsZh/YA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380F606A333
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 10:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2380F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEsZh/YA
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c0ea47f5b8so80459e87.3
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 02:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795171756; cv=none;
        d=google.com; s=arc-20260327;
        b=FBo0sdfp7eHbyX3wMoA9UR63/DM4GlEC5FvVdQLLcUUmncwev7Q3LHdWulpLjBrote
         mgeeTr2ng/z1mBKWkEj3WByG74hTjkUrch7z4yOzbXMcuSM7Zy98LUOqsDk2mmAao88W
         pZCIjW52o3DgG0fosjY7f8xtBomo1rHkErJ8tP5lOwk3L5VSSIvxZVKDwsw2L9RC+iH7
         KY5DooJKPqPB2w/ZzTJ64IJdC5GkDyJMtg/aZSj6k9GnL8RZUHTzMud0/tjIJWDieMT5
         nOizvrfz92NtZK6dIZy7ZJiLFJ4G0FkVkQizEDy4ReFHjwHq40n8DxPFxLirflaiWgR7
         A6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dWYxYowsGCBLSnSh6cLqulqT3GbnJrbr+1e6JgGH388=;
        fh=4VrWvpQQjL2HetRkjEGQ6IW2bFbdBa3b+7M29b6pkqg=;
        b=Ps6hH1rrz9pa+7idSFz1kFO0v3HRsvQuc+wEW8hllX0SfjtCACE0bkWexj6CSqhmIy
         Hkubd91Fy5egB6lP3M5TsGAhl5+6VLjqSxEyUlNuNy9kYw1gqxgrQKj322cieuvOsryE
         tFfs8teLFNG+6omeaTcCh4gK8790dLUAHU1vREBRDZ87XepB2yxL0lzbVE8NlSpif6sW
         O9Qzl3i7/A4HSA4723boKRAoxZszi50zda7fBqT0DCgTgcbqHtbegYr01M4/WM5z5Wim
         AUco7WnrotZcKuoadX9wJhpzvGpfPk8Yeekzdud2wq25VZWRdynqLjwqu7N7COTpc3GE
         O2yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171756; x=1795776556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dWYxYowsGCBLSnSh6cLqulqT3GbnJrbr+1e6JgGH388=;
        b=PEsZh/YAAYQUmMsoLTE0P4DoaYxjX0K0WOe3frsYoTr8l3r+nSK7sMDRX+LpT5WITu
         p5da11rIxNERXMD5GQ7vP5rHjtNAiDvJJ1IP3EaCgCiy+uIEDqg/M3B2qWZu33gr9z2H
         0Ntd3BKnx5dLbi8bNJnC6C/w2cTuMVdfAufG4YrMW6gJs5fkUtJkyKGZOAOEfSGC3URw
         mPL2nagnait/4H97dChQkWFc9nriIUt48kJnZskAOVjsNDXahY1zXAfCtf4wIzRSv1E2
         cn8ohWhoG0vQTsgDCFFyQQQuVWTfYzneroC/a9LhzXB34Z6ONgKLPfSMXLK8FB3frR1y
         T3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171756; x=1795776556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWYxYowsGCBLSnSh6cLqulqT3GbnJrbr+1e6JgGH388=;
        b=IBhJDiNxjhSFKTg5Z8UIhMPsEOVHHXuwkjqksF4n/InS4kqtLhT3Q48NCNiDdzM9lI
         0nvzVPqGcl87PXP7rwHzBimAT0ScVRB2dQEHGIBpOSzpWnlST3GoNpAFKgcBIWKO9fx+
         lBi/XoKF5EEt+5hmEw4Ha2lKRXdK+U981YALR3+cIVbCfe4S/xXqvu/Smh5/sbeuJKWP
         tSo+ZwQLVuQUBu52VMoIgl39EPas2iAuurviESe2TxKZeMQ3Eu2UKHrHIlaPM05El3Rd
         MNzLlZQOCqDxN2oRutEeE8UnD3+eZ0VgjyMua9WQr6BRomYPEGG80fFDpOvZKiQy/m/e
         6w0w==
X-Forwarded-Encrypted: i=1; AL+hErE414DCmrgAAJLLmpwN+ZU38QUSUJPxWbTa9F6M8LsXdc30+m5GNbs4/6XGOpGBUzIBvP5UtQ8VDwgErssq@vger.kernel.org
X-Gm-Message-State: APuU4Z/uMa9y5oyN9Anw5fmoziHcaVF0xqKgyerwW0FDkkO48odfv+rY
	l8pgJWYV4MlKjZuMUhWcr4jyLPZxQq2vYPynJ+7O6n/NWp8BIBUceyolzFPDkeMUvwZT6Z9Ti6R
	IlZvXOZ4ueIks3TSSksu8havDkc6rjjs=
X-Gm-Gg: AZFdTZfeUFHVixLhua+mTu2B0GSGJdYLdDVrqbTEAsrCP3RnTHH/jGxn80wZOAi7107
	iaCJ8omlWm+JtlpjfNJnDF3TkWpYlt30TkFB7F3YFNyX0/AG2emXKmV7ol2tQzV9+XQAlBr8M8S
	FQg3lPVcohqaPLmCXiXK+RtdZOSHwNdnQMtsls57gPQL8XTp8eVJEC9iuthBZ10punHiMy9spvZ
	WdGr/k2XY1MjU6Qnqurhy8KVyGI84O0vh1Ypzb/mSOEPFuN9KES+CcXvrl/98HtCc00Glyb0oaw
	VobBe3YAxyW95/n4XwZFOt7rL+mifmtTaZJABDOncTpeYqFyysHF4CSr6MDCCYs9Q1ZB906yzgP
	nuyFlzzUCoEDNd2PcViWHFR0ri2bIL88xfJl4lu4f+IWRKYmr9Xc9FgTdFOaOO6fR0WWYb9LlX2
	oGG/2L3s7gRKpPSiXBIMZhgC8yBHrs1zhpnfbLnA3Kh3iKKwhz07gqinii+/mpKGxf/GBRyhzxQ
	t9rGgxAkwNyAAHrEF3PNuyVY5ZFhMihWPCwfg+GN28cARNH58+kSYlUOIH05Vo8GfdXtqGd
X-Received: by 2002:a05:6512:31c3:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c1bc76a33fmr1167983e87.2.1795171756051; Fri, 20 Nov 2026
 02:49:16 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-fix-rust-build-error-modversions-v2-1-1c2271cbcab5@gmail.com>
In-Reply-To: <20261119-fix-rust-build-error-modversions-v2-1-1c2271cbcab5@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 11:49:04 +0100
X-Gm-Features: Aa3M54qW6il0gb-hxlX-Nj8ioiKgQABk89cMHbmkyFDNFAXmsl_FtiHnKL79t1w
Message-ID: <CANiq72=vz2D7XYNEHmAnbh5iTJ6T_qtSV3bosQrB8HOYsBXtzA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kbuild: generate a symbol version for rust_build_error
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Matthew Maurer <mmaurer@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:19=E2=80=AFAM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> - Omit Sami's v1 Reviewed-by because v2 changes incremental rebuild behav=
ior.

I guess Sami is still OK with it, given it is a subset of the previous
patch and the core part of it.

But I will wait for his confirmation -- this one is not urgent.

Thanks for the patch!

Cheers,
Miguel
