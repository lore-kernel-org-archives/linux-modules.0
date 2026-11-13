Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601581;
	b=1PhLYSRIrDeU1krLZKiZwbpqUNRcj7HzzDpt7FDktvopLdNubKb7eDGGbVJrytpDl0ua
	 FBqwVePVHUNBugA4Gg5U2YEoWSCeJT+29yAJG4k0smBDg8Sn+gYj1we32CO0Snual1zJ9
	 cXPhu1I3vqzqg0ShvdS++EWaFVKAsnspKnYsWKwbrxECSeMwWKtjxG9MF2e362QRalmQb
	 le9WQYOdZoQSlEDGQh3uvZpyD2HFOkvpTknr+3X3ghNGibHQ/Mw9rf+k6/ySbzBKPQFLE
	 XooDTQFIBfpfQ1/gYnF/b1BCdCbmyQETtcsfNU2YYfzh6HrdnrHqB/k+Nsao1b23xpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BmaNayS+Wbe5Uay0lJ3vEuq20YAhkZy/1G9M7ssRoVg=;
	b=Ec+urLr022R1rsmA8VGFQyD7MZuOpH/FIYojqkae+FqMDwZBllCb/9z/S8UWRx4+8Jiy
	 iUrosoHV7yhUUUteXXzKgFXNSslYil2q3Lm2tHM7mpvQqgejouMww5+wgWaV+cIKBJAXK
	 JWg9Kc3S+wdp+FVdJpERKJnjOn5GqJa8xo+jZt0ksUBB/lFM7gBilir1aZWdLXSY6rCcM
	 molyHXHorqwGdo5GBuNyHknBhUk411Kj3sECz0kR7Xtcm23rf9n6AsCnS/qTgEMsAj5pJ
	 9rSVmuIyz4YoS/phKVGGfgRgP3XRjSifj7uEAX7WXwxsrXKFTEH3i8SmfcgxzLXuVKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAWZhUlj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B248606A331
	for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 20:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B248606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAWZhUlj
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-943e8d35f74so209187985a.0
        for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 12:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601580; cv=none;
        d=google.com; s=arc-20260327;
        b=JMDK+O3Kko7qSF8O5MoJsKzjIWqCaZ2PpvNdzCk53EWwpasIdBgCeA4Uygsw4hBlS2
         taYS90KsovDElZJxkPMidCbeeYzLP2gMk78e2U93oBWnyjkPI9K7mdU4gwA7dw6k03cy
         aTAQONZmvGIDwVzaFBCuiChdOSrKgfI4P34RqaiVdh2qgknUeAGVdNAoukiEuxaZnSCY
         qWIzhtq5dLgVH+tW5lJ3cOeHYSyQLjVoc8pkcH3Zcgc+hXMapc59iCvl9ep2XFDL/7zp
         /E9YmVuEd3IXT11xGYJRXKfx8r8lkPkk+NM1eBUySI8+TPjUyN3kNJ/NTINDlLQyMpPj
         QYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BmaNayS+Wbe5Uay0lJ3vEuq20YAhkZy/1G9M7ssRoVg=;
        fh=vn0dE4mP/Eb7Ih4CtTG32FuItCOqflvFi1XZP72lXuY=;
        b=XRFset5hLNuMNERhEbKsacYJoq0FntUTZBACduVKCfjlsDVrUEqUQSYIdzD/VAF+as
         0KUNeAJFFXe78MZy3VS7aFqrtZ76PfqkVRL2OrBpF9zeDQ4Y9fXRWNvfkejpvVx8VobC
         AH3U6Ipvz64BLc7F8l9KFw4KzcrbNEHQOm0GGr5KCB1SZq32gCox7EkYJ0ijToEXAxm8
         Vi/TDQe6gpOoCevuC3Vhworz0oHrNgrqd2NnD+qEpVrf1C2bmH6YG0k6sbZKl9VRRnjc
         o3CZ5JL613NEpHovGV0rerG75hmCj4XQX3bgnbCBIGxZ9q5kuLydlI1k90Xjewbw2lWz
         n5Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601580; x=1795206380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BmaNayS+Wbe5Uay0lJ3vEuq20YAhkZy/1G9M7ssRoVg=;
        b=xAWZhUljpSj4GwEG5edXxo6lINEjsx85vjIUzWJhw/LQW+vjQFg+VQZpnvBlLnAT0K
         7t3cmzjH5jUHNzUfWx4PDsIwPZpYxYCA5w1os/pb5TNthu8XeIB0xjgf3B7ZhI5ReVH2
         bOPigVWTzSjcjbnh/6w2cBFJIdF+tp64QXr9nPDhy/rhIAYlpzNo7oc0HRCGEzg86v3/
         qxB+Te0DMVATtMQzWt/dJ71BmmiA0GOF072vtHmRm6ujw/2T9eyf8mKPT9EZt4wDhW82
         /61/dguUNKOHnb5rEdnRfzzyumKudLkEaH90yzaKusaIQYnQzBQC7awjusAsdK9kcM3z
         7nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601580; x=1795206380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmaNayS+Wbe5Uay0lJ3vEuq20YAhkZy/1G9M7ssRoVg=;
        b=FkLfMLJyTvxYrIqGFab3wDKx3hhqBHn+F1mMHgHphITdM0xYh6weG6Athf5XFDfJoN
         n2JYeXKnrQlsf18iMb5+mqBk3vDWfXYvwvFwIyRhJAE+pkM9cbYT9frGNQ0yMgC3HD6c
         pcwUNX8zps9JzqTB5/qrTPVLFgM8H+Ju+FNSWTgC/zeX6glf3MfhwlmPIOIJ9WX6FLRv
         ylnegKfX0jjYS5dOrFUYRN9pMpF8EMp6y25S9/GeIwsTDIBzugDcQuv3zjQk9sp6tfTf
         WnMNLIuIVOxtHDNxcAYT6TCDb3Pna0HhaC4raLpc4EzfnVGGPorpCgRMfJRSIxKVQrMV
         MsHw==
X-Forwarded-Encrypted: i=1; AL+hErEJVy/fWdGWIkxWCGdfDBEec047+pW7vmz302f9EPZ6JRzdgsEBQ/L3It0zyCvUO8QodLtedm7zM/xeQCGE@vger.kernel.org
X-Gm-Message-State: APuU4Z8g1wsodunRJr3BSdoFnAS1JuHZda9ltTfC8Fj7f/2lhdEWAJEK
	txWue8DwoQ8luZCcFvcrPYaby7WEIoP+9zGXGrGwH6EYQb7DN4i0Ke7Tc17jedsyB9oPHKgHLfB
	GBaMyl7Cx5TqKEiOVa2ILYHBkZHtK2IY9PE27zm4=
X-Gm-Gg: AYBFou29NArtl2kjt/Da65ExrH8IrbGVJHsVrTf/Jdb4m0hycDXzodLYtozW7NlOYDu
	q/q3GLSKnUp9mCCqC+Q30h4kIlrxVWoUlUuqVQwQlS1CCCs09wACI6qoPNyyY+N14RTJQwR1/Tw
	9b3Pi7KxlM/AURKz0wwCBBlqCZZJKK4JDViFsKh3WfEhzqypkqtH2ULg4RFihMDmWFtdj2MmUCM
	dn8wsi7hYSrlQdVszXhVLrz+qQnEVxjHVMzjaAECofr3r/tgnkD6dA+lBGhYIE8ysMCO/pzDfEV
	742EDzkGQeNjpXWO0GN59KaH3yP7dnlnxgvTuzJCW2PyVoDSxRnWUYkUZnvnkWktC69vASCJf+g
	DiRfgeA+urCiY7ZTDw8xkuSxxLjPrtCIQWGcZ
X-Received: by 2002:a05:620a:450b:b0:93c:5f3c:f485 with SMTP id
 af79cd13be357-9494bc63eabmr628029685a.53.1794601580206; Fri, 13 Nov 2026
 12:26:20 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028155005.174417-1-mbkchelofficialdev@gmail.com> <CA+YDrKBAPZ9MHB46wVSsD4Vd-R8L1Kkz=Vp-F32+WyfJ5FDaoQ@mail.gmail.com>
In-Reply-To: <CA+YDrKBAPZ9MHB46wVSsD4Vd-R8L1Kkz=Vp-F32+WyfJ5FDaoQ@mail.gmail.com>
From: MBKCHEL <mbkchelofficialdev@gmail.com>
Date: Fri, 13 Nov 2026 22:26:08 +0200
X-Gm-Features: AclHuK-nt_pkf71fgXmv9aasF6EhY7Hz67dSrcbsHeSkY4RsXRic0A5k2swbL1c
Message-ID: <CA+YDrKDyME4fAYMCRvz2Nau78nKJp1H8W4C0yLFp550GwRjvSw@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: document emit_base in ModInfoBuilder
To: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Friendly ping on this patch.

Thanks,
Ivan

=D1=87=D1=82, 29 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 15:33, MBK=
CHEL <mbkchelofficialdev@gmail.com>:
>
> Hi,
>
> Please note that I made a typo in my last name in the "From" and
> "Signed-off-by" lines. My correct name is "Ivan Tverdokhleb".
>
> If the patch is accepted, could you please apply it with the corrected na=
me?
>
> Thanks,
> Ivan
>
> =D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:50, I=
van Tverdohleb <mbkchelofficialdev@gmail.com>:
> >
> > Add documentation for the emit_base method within the ModInfoBuilder
> > struct. Explain its role in formatting metadata strings, handling the
> > differentiation between built-in and loadable modules, and managing
> > linker sections and conditional compilation.
> >
> > Signed-off-by: Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
> > ---
> >  rust/macros/module.rs | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index 0a7b9e24c..6f361013f 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> > @@ -49,6 +49,16 @@ fn new(module: &'a str) -> Self {
> >          }
> >      }
> >
> > +    /// Emits a single metadata entry into the module information tabl=
e.
> > +    ///
> > +    /// This method formats a `field=3Dcontent\0` byte string and plac=
es it into the
> > +    /// `.modinfo` linker section. For built-in modules (`builtin =3D=
=3D true`), the string
> > +    /// is prefixed with the module name (`module.field=3Dcontent\0`) =
to avoid naming
> > +    /// collisions in the final monolithic kernel binary.
> > +    ///
> > +    /// It automatically generates a unique static identifier using an=
 internal counter
> > +    /// and applies appropriate conditional compilation attributes (`#=
[cfg(MODULE)]` or
> > +    /// `#[cfg(not(MODULE))]`) based on the target type.
> >      fn emit_base(&mut self, field: &str, content: &str, builtin: bool,=
 param: bool) {
> >          let string =3D if builtin {
> >              // Built-in modules prefix their modinfo strings by `modul=
e.`.
> > --
> > 2.56.0
> >
