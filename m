Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793218452;
	b=vMPX7/mYwdnO+QlnkOsHFG06ftWD49znfDp7B88FhKtLyMPc4hH77eXGqnTFt4sb/lnB
	 CzUte34aj4/77o6lGvB7oVpx9XALJ6s0LOLTPIjGKV7lgHA2sEmQKxIh3PjVSHezkRBap
	 8AA4LlcckyVAcNQPuZSWprty7J1KTCtmgWcjcbtV60ZzgFliEBBL0scO4Me4RY18BkrAG
	 LTrPKXYcrY0pseSU2iOP9szYwz1qtL+7qjLUJ0kXmRfjIZG5FEMvyJg6O81Qgj2TTFhEQ
	 bXROipd516TXTWkbRL0O3mF9+GxnHoWceMUcU/teztjwOQCmdfc2zzbTgU/xNbtaGqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=csQ/box973kWuUGXHjUHnb+JSV/cr2As/2S3bZoGtKw=;
	b=cWF+cFBy68vNUTnrPiO9XJkxU3iRzfX69w8O07+BEynjKx5x56Ww1LkFPvzYBFSRuLvr
	 sja0Yd9Q8pWXSK7QZW22PE6Kkw2i6c0pa9pNaqlOTVsGuXThsKFwZt9w8o2D68xXPnIzy
	 5tYVALPCFvVNYsSNfJyLy91tXNf4/SWaApw1NM1ayZk6R3iZZNkWBXnAwyFzt5902UvWk
	 CWnysHLjsK8JMwPbhUceDwQm5tESaBT9lI5oySk5qLzOcnkRTRqqXhwh5mw2C3EHHMdSS
	 rQ5eUTeidRA8DNtvfYY/pXPWfTuj83+JR7seHICPP15I5Qwm3sbbbIYiHXj/VaeILDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrkbgZj8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B6606A31F
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 20:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334B6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrkbgZj8
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5361e313e63so16293001cf.3
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 13:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793218451; cv=none;
        d=google.com; s=arc-20260327;
        b=GtoznA4I52VBf8O3G+pQvBnqUIlkJu95qfazozvrgRBJjCjPrDUl+drUEID3jzLJXG
         298dbBB0KD1nJ+vTsukPkAZf9jRdR62t/DjisK94GnV1q1hFzUx+RlNPARS5HTmX0wyZ
         gewD/xDuPzv6tZd7/xqiNYaw4z4dBvPSgxbnUZFWgu+KLU/JVnJ6V5nOMTwgIHB1xWoX
         aDmWNxlDUOzX+LRCuqAOARhpv5AWpZkMOi7KVUZq7yQi4FEQGqhaP4c8+ypxWd1seBcU
         mS5fzuXmOJxdkR8uA89lw7gVYZs85F7VcLvVnGC+ftBzwbJluccdB+8Ce2InNeGgSiTa
         tPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=csQ/box973kWuUGXHjUHnb+JSV/cr2As/2S3bZoGtKw=;
        fh=b4JgTPrblJm8jihi3mkqd6rhaKGZ3A0bkEjMsTKJMC8=;
        b=kG6WA96Kyt/Nh5IWptHzq05D/lyx1tUu2C+5/Nj+GX/Z4M/I2X6tni3YwCJDfAAwnR
         c4JFsRDOiCHjO0tXZJP0xr2Th/O7/R4tE+SIdTzPadrdVxu4ifcj4jEjtequEuh9Adxi
         KFe2LIas6a0HYlV2IXFaU4szPCLKf4mU5xt19xYYL2rjovXlbZ3hHJXFZCy1+Aox7QuM
         EV3YTY4YgtipYQ+GrxJu9lnZw1m3brVlz+xcIkgvuLD5VtjuJ7mNT9GykiLEHBLIf3j4
         ryGTNJkiV7zlnq6u/LwpJmIVl9t3se2pHPfKySnru5UEFy+W8VR9N/FJbdDME+01AUqF
         u7jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218451; x=1793823251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csQ/box973kWuUGXHjUHnb+JSV/cr2As/2S3bZoGtKw=;
        b=GrkbgZj8YBEsBwIO1OQTS2rh7snbAH21CTecRXJlz60RQzoxkzBiqwCplXDuMntJnY
         OMyClbsk/Ai2Qx2glN4KJTcPlWQWqCw1v113QTDp/ioJ6hLLy19gDuqDMpdf6ZXHElVf
         4AHWl2McaG4h5wW4WJrovav4XFIbirEZw8urzto5qjM6OZ+5C7PvMXScrXF2PBgsRMcT
         SyyN+8XNSgEq1bSxuIMeOyUPHTGlqhxBPG+XsATLbHaDEi7lMr7YJc5xb/XKGH7lR/Sg
         tEoFudP/e1M2GvReYGX3jNqb8ou+i28WftcaHDKMd46o+kg7m3WVtndlX+ZYIsHtBZwc
         khfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218451; x=1793823251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csQ/box973kWuUGXHjUHnb+JSV/cr2As/2S3bZoGtKw=;
        b=WQrDakiPI1wmkCbe7tVP7/5NNn+sbXQWS9GQN9Jn/jNlUrZf7lWbrFRLwZndFDiayw
         cis+y9MMU6GyHx76luJE03qrACwAfsNdRLML1dMVfpYWNg/MeWmAD1vLJKYMAOge8BJh
         zP9jK+0eyww4yKVVRWrlvxGGfWyj213DyB08lKin0MNidLvykCNtIoDdNzSfwa4j1HNZ
         SZrtXkxehFQeLP8d7h1E+byfj8E74MJyJbjkQvHnIPU9pTI9b+sUuSk8BgNKDKwfyELD
         u8VWd9HlAMDlGV6g7M8ZzV1tU/b6f2q2v1x5zdnbOI/LwIwsK9qrGJNHhtodULufxeFO
         I85w==
X-Forwarded-Encrypted: i=1; AKwUvByKod8IezXXiPcdhAwwOuM/aF/GB+kDMh4/eysXlt62MdWaZfK+gwjDnRVr3EUGtXMNGSi049umQePN4QPg@vger.kernel.org
X-Gm-Message-State: AFq9FYKk6KlYOhaYtYrq46JOTEVnzfVFGw4QS3zfkurLZ1GcrUwwSqW/
	XaUXHEqfOs6MoioKJHwQ0zf/dgM5DncPEC+1YdxmJdAQZsdxQl6owUBDIOr617nWl5FFOx6YQu9
	hYEgHdnz2/SNL6TkJHeodXYiAGZvvcqs=
X-Gm-Gg: AYBFou2wZ21ANJQMEhIZnQSVU2aByt5X3w8yq2T6lSP/ri34jjmMPT4m03dGgsBEpx2
	jTxiq6z3OROCwC518wy6GoyOzga7bpw0rXqmo2qi0zK2pbmjChXeOw5z5VJeDAxlwsCxhZ3/ZhV
	kJ2Dwa04FB7P+P/A4hplAXxsnLQ7FJZGgJBze/Kbc3dyNo6aD4bSnZz/T4ztd89CCrGaqxI4r/h
	zrm/o69+6YthneOXgRgCX5MEo8b29pJP9XZz9+/1IAdiggY/UqTodHHbk5mV5IpvoA/jrW18XmX
	5KYszpJOWHu1R12hKPDFJYm3HGaszM2S8Fwh0xjs+Y8JgLp92jIsjfg1WvKecWPWBig2OePrJIg
	KERtOoWERHeqlCJMJwXiShnoSo+bEUYxt3Ott
X-Received: by 2002:ac8:5d8b:0:b0:536:64a3:aaca with SMTP id
 d75a77b69052e-53fcc6caf38mr60121161cf.62.1793218451089; Wed, 28 Oct 2026
 13:14:11 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 22:13:59 +0200
X-Gm-Features: AclHuK9QKQWnwAVDv7GI9zgwHXTw8N_TI4_-PW1Dq0nQhME1r2ltFbMpbGG5jvQ
Message-ID: <CA+YDrKBeYvS99gpg+3knSXRuNj1a3_YQjX84xfQzQgNyrSpUAw@mail.gmail.com>
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
