Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793217966;
	b=Yte4q3WE//BcGTgsyNV4F59ObntxOPgR7hnz03saJYFqf0Od5Bt6rXMHnYH1UEJca7G1
	 L2mTNHhx0auw9qn5hnJJv7FhSpEIuQG6a7/1b6+XmSmotft2l1wd1qntX9EOw3oy3FbQ8
	 akoc6YxSJMCs0s3DWXiKf8zzRU/MV/w04pbEBdMtuPmQkWjQcv9K2JQPyVaVzvv01nU0O
	 6ALKoUzo/nUE2WEgIjqyu3KVGgtk+jfh/lQ77mhQPCMXU4cimm0hgD2E0P5WbQTnFMvJ2
	 ym3JpYtlCJqhwvK5nyqF0eL0ueAsuS1oaYWUuqr5DsIEhZa8AVII2HTYAW6kb1Lzo/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E7ixOB69ERI62LQAi2qp7f/jJpNcrGT6jByhhOIKXrg=;
	b=KX3JY4iRFGL/C4Qawly45Yli5PG4x1t5ieafM62B5Kxt9mUYs/4niiAgHddwAJXz/I9+
	 sKDyno1QKTvt1icsBzcLF+5B31AWzLHSYI4gPl6LgcE7c5lk5fsDLG9rPuGT3QA7BBfiP
	 L7c/lvlMunq5Oc1URy4IZYRPfepYktGTd7rHcwxsbv86BxKF+Ts8/VHTdK8Vwj8g2Q0gu
	 Z+zgzVd+J1tV5gcAdZjzII+HH/TQmdEBFWlrJVriAvCVlJAJSyIHnYiD2HqxBoE+WQ7Yh
	 x9zjs4GvyJOkJbtO7OcMTpaDyJXfIA5GoWyF2lm0QL0icodrKf22s0MI3kSXOzwocHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXlutysd;
	arc=fail smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE1606A31D
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 20:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43EE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXlutysd
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53512cd2f85so18571691cf.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 13:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217965; cv=none;
        d=google.com; s=arc-20260327;
        b=r56iL/qQRF5M3rEulGbhjmSw7rcUTzOC5Cc0UIw85mJAjzPfpzBvHEk+piBVcAreJn
         GKkxTUuMhoooUUJdKuXJg186afXCCnLIGidkRsNGKAm60GGoIEpSX1OPx2yOl0Fkd3da
         WTFWB13WTify68FqM6pyasgm5jNu4o5BDZ3+GrEot+zbsjUaoyqRvrSUWVMdFuyf9G2m
         hqkkq2JnGDHhVhswpidSX//9O0q4kyL2nav11GzsHduO2F1JgLzZ8/5VzIuZfGMOzz/4
         hjHuiLIf0hdMFRiaOV4MMCzE0Y52beSWHP8UxlyDVG+hoIMfCMjvLjNpQlp6nAUloFDR
         1weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7ixOB69ERI62LQAi2qp7f/jJpNcrGT6jByhhOIKXrg=;
        fh=ut+9FlpVQDV3L+NC1y+xRDsEj0WGIz80O213VdYe3xQ=;
        b=nHtYUIabcbQlMHO8wYy1C7ON7lVR4GP0WQP9/7Ffcav4Vn6Nxul6ZXrxAsPYmLGo9F
         pdFJ3SHSLxQlKhK0HBw8qmj594aCmMtrpzdU+MT+XX6ZRAlauJDOPmJY9FEWzhlr30CU
         CVkhPZXT6ne8SPugDrqY3HaXo3zAg7FlI3ADgdQekM7muCO1QGFGHz/dJmyHvR5bFiHU
         thjwtylzTWgJskTKBLjC1nIn7g54xpWjOTtGJXMUN9m3CDL3CcVllidOV83Ohy3OwXAu
         FfWyDwXlnyhfpHSX83u3+18kve9XAtr+5fXkFvXV/FE/Kv2fjD1UNucq8d99B+tVxuVZ
         nQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217965; x=1793822765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7ixOB69ERI62LQAi2qp7f/jJpNcrGT6jByhhOIKXrg=;
        b=dXlutysdDhscdJmeRbPa7EM1sLb4yD199vkD1Ud5wNXNla2GnfyQapJff2WzczuP0y
         ZoScjWnXZShxVmWz9NPieu6mPwchuubNN4y7UAizgNwTD5dSTLPO7oagVoLQhXgFwI7R
         0ax81qAMbxaGvmxEDaZrIPclJ3y8sA4VvsKl/tdlP8Xza6OaZoMCzoeQ6mJK7dbuP0Dh
         n6EEY8267H2Ahnai+uaOOBePk7JCxf7O1jC7P83jtze93Mn/OFhfTe77V/idFSexTZVg
         PjpmHlYWxCb/SMBZbZRok6C4ExF/hzy3pfjJ2pGP1SCnuqw86uG5L8xj2e4geQGqcLCP
         v20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217965; x=1793822765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7ixOB69ERI62LQAi2qp7f/jJpNcrGT6jByhhOIKXrg=;
        b=NcK3lnY3YM1gJFGYRLBko0c5VfYIJ3lYMV/w65mglVydfmghFUZ9/OEk+XArYPZ5Ds
         A+63MM3+PV8QxE6FURTI4QbJFommWkg0JgBdYIbav8J2VsCZemQ4zC25fxbaX6Bi8mel
         FrcyscLxD8O7P+MRRLlJkgULAQQwznG3Ph78YcERRIpQFSg7FcysivqEwS+sOAjZ/6hf
         w5lNiijxEL146yn1wnWTUnqXrS56xw0ugiGSiU/d7FjKuBeMGdLy5m5e4VptMSs9l+p6
         TyWahJDp6+c8VLvaz7OlNFu//nX+CYcU9tIUDw9acKiBUpwME0jhDkA3KZCFk1aK+bSr
         tjKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrzExL13usonKHy9YGyn8CefLSX9PnL4wvEhmjtyIKpgJxxIpykU1sENR37uvNCvKe+fIrIDgf0idvv5ov@vger.kernel.org
X-Gm-Message-State: AFq9FYLoEDyfHXvS5yL0uvgdi9/92p61l4L40JI+NUOy1gRthu3DSbRX
	gCD4xK6SVV0cLyrSkXG/osHj1Ls0N74YX7wINvkn9+E1qpKolUmKXCpk5eboY4qaGseYVEitWqB
	NVDR/ULX9SuGdNizLeKkHdrHbdDboynE=
X-Gm-Gg: AYBFou0X+V383Cr+17JxKH+77Qa+tm1+NPvI4Zirucnz6v10bGCQfxdKILj5R5FksV8
	gQDdh0TNKGfSuPaHUe+KD9JO13eOxS/Zv2/IYPt21GT2v+YSHIcsb9mZK9sYFxo5T9QO+x6DmYh
	nCchWZlyIhzcJfZYMIdEp7/LjnmXeKasvNZ8g0hNZODeemGrLM1DhQ3FAEGABjkX6960KIHjmuY
	51Ue5vesrZopCBdgcrdkWsRGhZE5xnamWiPsocQVGJX5GSLSfTdxMPnLFUMkBX0xJFo4A2LVZcE
	UALAqMsK0HclN1yfEFcSf1ZzVPqyjMRtMhEd7gxWhT+UJePGhFZOTegNOacppoLL33LdQ5Xvqz2
	ujzOlCmAmdORvsiVxMdEOKe0aeFX4LDpFYFKM
X-Received: by 2002:a05:622a:1b06:b0:535:11e7:fdb3 with SMTP id
 d75a77b69052e-53fcc4cc979mr53158021cf.34.1793217964993; Wed, 28 Oct 2026
 13:06:04 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028155005.174417-1-mbkchelofficialdev@gmail.com> <CA+YDrKA1hTM-Yh+qsCz7Q_O9f4m_JWqyxkm4izaz4uAao_Jz5Q@mail.gmail.com>
In-Reply-To: <CA+YDrKA1hTM-Yh+qsCz7Q_O9f4m_JWqyxkm4izaz4uAao_Jz5Q@mail.gmail.com>
From: MBKCHEL <mbkchelofficialdev@gmail.com>
Date: Wed, 28 Oct 2026 22:05:52 +0200
X-Gm-Features: AclHuK-gwnM5a3gchHzfHJ4Fbkh10NoTzJM4qf8pmkxYyLfJG-2YoMNVzSxHgK8
Message-ID: <CA+YDrKAjSO7SVOE+odJ4zYEphfJtytjteSvQgGwmz_rD4tsx5g@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: document emit_base in ModInfoBuilder
To: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 21:57, MBK=
CHEL <mbkchelofficialdev@gmail.com>:
>
> Hi,
> Please note that I made a typo in my last name in the "From" and "Signed-=
off-by" lines. My correct name is "Ivan Tverdokhleb".
> If the patch is accepted, could you please apply it with the corrected na=
me?
> Thanks,
> Ivan
>
>
> =D1=81=D1=80, 28 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:50, I=
van Tverdohleb <mbkchelofficialdev@gmail.com>:
>>
>> Add documentation for the emit_base method within the ModInfoBuilder
>> struct. Explain its role in formatting metadata strings, handling the
>> differentiation between built-in and loadable modules, and managing
>> linker sections and conditional compilation.
>>
>> Signed-off-by: Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
>> ---
>>  rust/macros/module.rs | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> index 0a7b9e24c..6f361013f 100644
>> --- a/rust/macros/module.rs
>> +++ b/rust/macros/module.rs
>> @@ -49,6 +49,16 @@ fn new(module: &'a str) -> Self {
>>          }
>>      }
>>
>> +    /// Emits a single metadata entry into the module information table=
.
>> +    ///
>> +    /// This method formats a `field=3Dcontent\0` byte string and place=
s it into the
>> +    /// `.modinfo` linker section. For built-in modules (`builtin =3D=
=3D true`), the string
>> +    /// is prefixed with the module name (`module.field=3Dcontent\0`) t=
o avoid naming
>> +    /// collisions in the final monolithic kernel binary.
>> +    ///
>> +    /// It automatically generates a unique static identifier using an =
internal counter
>> +    /// and applies appropriate conditional compilation attributes (`#[=
cfg(MODULE)]` or
>> +    /// `#[cfg(not(MODULE))]`) based on the target type.
>>      fn emit_base(&mut self, field: &str, content: &str, builtin: bool, =
param: bool) {
>>          let string =3D if builtin {
>>              // Built-in modules prefix their modinfo strings by `module=
.`.
>> --
>> 2.56.0
>>
