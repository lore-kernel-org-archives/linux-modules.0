Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793280798;
	b=PJsI40r2dq4QZ0orUo1aOxkK6h2TMIWrlSvgg/UacNH/7lSVcItO763d2obfCqHgpIIW
	 pndA4X6vG11Ksd6i/C7TbU7kjZ23OPuYkwohGjE9ME3mqdo9+mFKTJkpu76urvJKRmNxE
	 92srZ8EdLzzw/MdiySBHZ9ATmyljPrZ2cQBrgpnaFbdBtgTZYPk+Nnk44YQlhqkKuO9Ho
	 xwjVvd4puzD9T/JbfcZ+J6Qa0xLQhT8nVI49GtmrNi6CMv+cspHfEfNfk8fRA5NFOJZdI
	 69fJ+tgBFNiVhVLeCILinrVU9OwJ4ZtldGZcV0RivtDhibWulHIl0YB/+0CXlDihqyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2i3HYlB+GbvhTKq0vS61Mj8mgAms2UmILds9Leq0HNQ=;
	b=LYwn2Ma+4cc1cYJU8GxInp/alq4q+0RlhULc5BDnvZ9L83TRYXvWhkREiaFdFThNJyvk
	 E2RMRy28AD/44lOKMncyU6QhI3eqstBa3SQd3dsHjHN4kJC6Vlf+MCM1rvSnPt5ruIBjw
	 Ur4lSq5pfCkX/mFL0w1BYzEKf5VwxYWb9Y8InkZ+gE0GzXk0rigaLcUkZGKe3KfETkPKi
	 g2fLykp0N7W78ciJBfEyYKQlDRbMZ4cWLAlzykv3Vik0XM8B/BYnNPDKqKgHZlG60HKTp
	 pRc26/nczYNosNIKQUplRx+zdeMdiD3URIFNWU6clWozM0KdqHaiKzQzH7hhESIdWcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBk1Rza3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E682606A320
	for <linux-modules@vger.kernel.org>; Thu, 29 Oct 2026 13:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E682606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBk1Rza3
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f1cf92c9eso209792485a.0
        for <linux-modules@vger.kernel.org>; Thu, 29 Oct 2026 06:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793280797; cv=none;
        d=google.com; s=arc-20260327;
        b=F35xgUkmcTz6KdxViptN9AOuRREgEefbyAfqh4J06Gm9V3Z710YvQ+IrIjFwIJY+ss
         TMGeOyB7DUvSwUbu9Y8LRb0shX7H+awZS1WeEFyorGLcIGdceesfcAoftQSIQ/ucEcHu
         DjfetVgOvNzKc4bRLrtFIiXuG1KLZyRNZ31nDje5hrwuUm6rfYQg4UTUOMEpKkAQ54mq
         RHeGe+Csgm5k7vvv736lmz6RJcGg/VmvWduUVO/5obS9yuRrTNE3DLkTPN3ZOUaPbilH
         H5gFPbgdCpSCFh/N/Y5s52VQHBPMfi8IoKSUB8KZwXnTGTCyfzp844boTDptN5exg3fe
         SWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2i3HYlB+GbvhTKq0vS61Mj8mgAms2UmILds9Leq0HNQ=;
        fh=L0o5eSQKvqQX5za5Zdk3KssQVWEkcySGpnLy2j+bJFY=;
        b=WiUIQ9NDB8kwKC+FMXPLklEiM2ZDro0xTQwxcFXF3qmU3ctAhVIwJvsu5zg17y75Lp
         7mygO4gp58PrHjoEhUOF87MzIC1zhgNOkBb1xM/26Kld7LmgPtgaA5Yr/tk1mRDQLMpt
         Z7tZOnXVcsC9P/mvAypJzSlcjhogBqosp1Kwsc96XiJHsS0EhJ6w/IYMhs8xrdxAooZB
         tWdanRbvhLewlZy9Uf3HZk+7zdJzoRirVUtbcolidosWAM30QUP+J3VslYIqsqozBdAw
         1d6QiJFhShN+jCErwOuL4O1TlOtByDiHFLm/YhcRP9up4nzlRjFHZrsZV/Nol690Cunr
         DeeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793280797; x=1793885597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2i3HYlB+GbvhTKq0vS61Mj8mgAms2UmILds9Leq0HNQ=;
        b=rBk1Rza3nDUnh651/Pwns2HNDnuy/0lby1QjU9+b3t9q5BL07PwHCmGSDtDQ4PIZug
         Kx42Hs6ZrSeflD/Dq7B3pRfWwQ/ZEc8oMkPyGE8kwCz9NqTt3KtSHDgR0eNz3xdzFpTv
         B02ZVtutkAoPAQ70c0A4NLpq0i6Jp4e1Kf3f90oAPLWsCrr5XpX2TjxqLXoTVkwWRBe/
         fDxnPtQLgDBGvnYCOP/LRKhA8EmyIxEbQ7+9RGZ+nZmsE2FF7HEgK9DFNIm6XvCs/Ph1
         DqFipXqM3CYZ6xkNqoTWAZZ9klLdvKP2ch05kyi4hmVOTNeMQrqc2/4eKXOLfrKdGevR
         fxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280797; x=1793885597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2i3HYlB+GbvhTKq0vS61Mj8mgAms2UmILds9Leq0HNQ=;
        b=JFElrCEVcTXuY89c+3sHF0djmzSiGAXjj/rfVDMcDMrdRp6CoKqNkBicPazd0f1eks
         2bSNNShw90HDbdNkjoAgId2JAfSwD31WLNUhayy8AdRV5sZaSkFXFrOp+2wYxQezqQeS
         b+rXKIa+sKwKIcrik2h6304AwvMAoEZg7gXx6xUVtwpikGVCwPdY6AFTH9DJ8WEJoG+6
         0bqQakwUJmq/ygZGE9HNf7OmlTIQMDJAUmC8DcutEVFQW32W/dOeRmJiRqkDYlTUChoa
         A4z2hcKen6No/GcwlUx+L0YUWKd2ReOHJHP+SfmulXxDfpUzzidjDc2ZFu1TVBIPtFpr
         SSbg==
X-Forwarded-Encrypted: i=1; AKwUvBxdsmKMaRM4huhisdx/qrbzjVYVV0uxNUildzYOTNxowWZalcF1DFtDe3/OL2kytxY0QRC++hrGW+ryWGIX@vger.kernel.org
X-Gm-Message-State: AFq9FYKr2yhQ7MmZhLbbihLqAORScHUXV65oHPM4fqFOpP7QulgIogSy
	nSFuW+f7g5W4zT8Ae9YMYBXUF0aa3Mr9rk3Ccg7HiFrgJb4JmjqHvC+EueBIOUGJWqiM+m78Se8
	fd6/WA++qglM4kxon5VMCuWnDEt7gHds=
X-Gm-Gg: AYBFou2R3KuqiwQBBfiCVX8w+FZbSvXY1ihVSUXV2ut8tIDns7KDQ6ArzX2kOjXmbEU
	2SsrqlumTiGLmi+6NwjjR1lBgbReCKhb60mOMjJEXId4jyRxEyrWXJozvkLBrYezFT1jjRrfFOM
	C7fxXoql1141e+z4dN4oDNJifqz7nWqtXs7fHfF37kmccl0fDzAZ3o47xtm3MpjmAypwYb8SF4j
	uzVD3U0nWr//bMaqiWWzn8LHFv19rlRJGpQlQ+/lJ26281ns0GXMCAKE95UhfiQw9j8S6ztPK34
	3eJ67cX5XezuZ91THoeErwMd6eJH7uiUkPzjmDPSmtXre8SWSULRquPnMgU+VslvUJgHG+HD8bj
	9VB0cU0VeCNmEx7q+S0SjMhPOTSQzt1W3VHqY
X-Received: by 2002:a05:620a:4628:b0:93f:1cd7:734b with SMTP id
 af79cd13be357-94408cf970amr830248485a.34.1793280796965; Thu, 29 Oct 2026
 06:33:16 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028155005.174417-1-mbkchelofficialdev@gmail.com>
In-Reply-To: <20261028155005.174417-1-mbkchelofficialdev@gmail.com>
From: MBKCHEL <mbkchelofficialdev@gmail.com>
Date: Thu, 29 Oct 2026 15:33:05 +0200
X-Gm-Features: AclHuK9wwROn4TU15KaNzEXIRId3eBxRzEJjMKpQJVL7IKBQ3GuCcnxcaYqj24A
Message-ID: <CA+YDrKBAPZ9MHB46wVSsD4Vd-R8L1Kkz=Vp-F32+WyfJ5FDaoQ@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: document emit_base in ModInfoBuilder
To: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Please note that I made a typo in my last name in the "From" and
"Signed-off-by" lines. My correct name is "Ivan Tverdokhleb".

If the patch is accepted, could you please apply it with the corrected name=
?

Thanks,
Ivan

=D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:50, Iva=
n Tverdohleb <mbkchelofficialdev@gmail.com>:
>
> Add documentation for the emit_base method within the ModInfoBuilder
> struct. Explain its role in formatting metadata strings, handling the
> differentiation between built-in and loadable modules, and managing
> linker sections and conditional compilation.
>
> Signed-off-by: Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
> ---
>  rust/macros/module.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 0a7b9e24c..6f361013f 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -49,6 +49,16 @@ fn new(module: &'a str) -> Self {
>          }
>      }
>
> +    /// Emits a single metadata entry into the module information table.
> +    ///
> +    /// This method formats a `field=3Dcontent\0` byte string and places=
 it into the
> +    /// `.modinfo` linker section. For built-in modules (`builtin =3D=3D=
 true`), the string
> +    /// is prefixed with the module name (`module.field=3Dcontent\0`) to=
 avoid naming
> +    /// collisions in the final monolithic kernel binary.
> +    ///
> +    /// It automatically generates a unique static identifier using an i=
nternal counter
> +    /// and applies appropriate conditional compilation attributes (`#[c=
fg(MODULE)]` or
> +    /// `#[cfg(not(MODULE))]`) based on the target type.
>      fn emit_base(&mut self, field: &str, content: &str, builtin: bool, p=
aram: bool) {
>          let string =3D if builtin {
>              // Built-in modules prefix their modinfo strings by `module.=
`.
> --
> 2.56.0
>
