Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793218047;
	b=Aa1hxhxH77tt59vJMfqw9c5D2A37tEybps4iAFg6J2y126yXKkSiRWPFfOTiIEPgiIB2
	 cLBMgdKv0602DQFkAXHYGDegc+PsrpYqgYi8fpTUPf0uLVPWJ/UO2lGhZ2MNgbAYKCzMU
	 LLOK1a3rLbDkAXoVUfWAyjTkmbJ6syBgT5+2XcXL5+IrwF4MTg8nPNXLkr6sUfdZaxnO+
	 W0X1GxXUGH9DLafa2JbQD7RN9Gchoj5OcmhQCp8qLu+6DUaDVYwWqHU7b2S7d48W8DQqN
	 qnnMRigL/tRrVDOBdcpQBZn7HlGsxbe3M6maCP3zzsfzopnCISWipKFqohQ9g6iH8YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Lrhbbx4CO+oq5MwiDvH/mUB5MVwGHTj6HOvSaL36hvg=;
	b=dVWP/lWCa8P4CqvoUzzFV8lHfoT3wV+hNteRfibzyOMNrsSVyuxOcn+4uu0puh4lx9yu
	 GUdP1JDI8/Hkc+Bi+3x3LcKOGRkRIThm1tkSqCknwuRF4vZKTw/3j9sLQLNHch5Wzsg1n
	 B4SOcTbUl6gdvA8JpxkCmHXnS3voUBgHKWIltqgrI/YAJd0XxGNBQHotzx6FybtiAVD5G
	 8tDpjG/7hka2yEPeuCcpKdsfo5iWLYDm9949j+5r3qLfSMyP0l7lBTKg2IlF4NbHSCOU9
	 mrF+NnkvwD3Bw9bHxtxrXIY2ylQ6/6++r9N1lPoeuWGJ02WgbOWmQlXDEQaBOKS/r2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3taxh6+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA0606A31C
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 20:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7FA0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3taxh6+
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b55859245so18779746d6.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 13:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793218046; cv=none;
        d=google.com; s=arc-20260327;
        b=nM3RVQb4jssvKbpQadVoHGYLAbz56vPjw1egS2zyRR5ZR0itc1afuHbY/XN/fUwSBe
         r94e84/0q65ouuuETUThRwZx8aQYPbhnVH6Y2jgjqRBOufAmNuQksoAK5o4QlcWXFITt
         Xj1TnbD7K4Zi6pZZnxeL9ySEkbYdGI59Ii6LZXremRNOF8jeRObZSvlbO7opn+ThKEEl
         z2b2mgGJvni0bOcD0dDIr/5LS/sQKb/fuEJT9ymKes6hMsdt+opiDgFDogCtk4HNUFR9
         KP663nXIuGM0ooUhSHS9IYGZElIUegwmhD4f04eLMifdD4y60Hq+tgFDTFycjm94xjh6
         Btuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lrhbbx4CO+oq5MwiDvH/mUB5MVwGHTj6HOvSaL36hvg=;
        fh=uKOsMLDriolmdhHR/vOdtY9v5dUkS/yi52mRssQmUfs=;
        b=JC8SwQRP/oo4ygGs/TN//K5xzoE5uaRqLPP0xQqtEh5/tFup+MNLsXtu1k9WBHT7OC
         sFxXUxx5o4e3Cjj2d5yD33w01H6r/j2wXKWulVztBsxTdC1dqy3V96Kr3rV6OVR+ZruP
         CqG8Pz1KtRuHstY8X6sruusGo+6e4QcyCAk+kbVbo4OqsgJpRENkV64JwpLfCMZXOHUm
         LjyBRDVhfzFRZLyNBDLBVIvpBUdWdTjdkrhIPry5371NoOxa7MkCpwuwcbrH2Pv1lfar
         Iev7q/37tDc5LzcK6Ii0Jd0iwh5oyUP1yUe+p8Re1QJ2fE8OtKbTrOUDrmCL+porqMdy
         I++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218046; x=1793822846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lrhbbx4CO+oq5MwiDvH/mUB5MVwGHTj6HOvSaL36hvg=;
        b=p3taxh6+1zzWVc9EmShmzG9CuyuWlEjpboYJHc6W45sCKXGXjeJH5Li0UcdBireTcG
         Wh4Odk8rQQuaqHs73ra+lucr5mlVAKxrGMu8R9MTBKFA0Tkq2f7uGh4xRuo88zuAGvPi
         Onhs72B24PAxZon9uswO0flA8MVCF5HJz0E9d+FhKfBpMZ0qelyQRghtdcFrh6VjZU8m
         WESIHnfjOMZCg01pxaPgugzZMI30+F6//HFuuHFjACpjDW8IYdDPglwvJTazJQ3T/YdZ
         K9OLhk1aHNfgE8OH6D7Tq6tYwdLGNTWDP9QhFVrbhJriI/QhRT7kbA/9lARQKF/hJJxH
         dSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218046; x=1793822846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lrhbbx4CO+oq5MwiDvH/mUB5MVwGHTj6HOvSaL36hvg=;
        b=HdTTbtjHBxkiNjAxtypVOBbIBa/o4VvtDLebMQktTxGR6TdUhiRaC7Wikkhs8bNlf3
         quRokYVRzB6EPNIquAuHiyMdNAWAJXhH3IRrG9Ut+LhAOfvcvQP3rH+Ve8xfqWtPzYJ8
         VJdq7pld0zHzaxO79WB4FVTcFgRw0EOi//i21LDcL96MuP1g1BBY/bYvmYDAmqbfSqzH
         WfsOz7/z62lunGrpoj0Tg3Lg/bIqXDU1TVQ4cpCwXlHOCUqFpDHAJr7s/6Sqa9qpghrL
         t6FjJMYGTR2yO+UJW3cL04KXPZXKDijD/jEuYGtphmY8Tinj4YWKmXEedJPNsYiVK8Hq
         a+zg==
X-Forwarded-Encrypted: i=1; AKwUvBx/14412aDChq7bP+Fcp1Q+xXAxU2GfllEbSPbFLTkD/squ4Bkk98XxKB8eLpP6XqRM+ybYiLLdsi1dr9qe@vger.kernel.org
X-Gm-Message-State: AFq9FYLPkigISIZS2SNqHL+LZpCr3a4jfZqHxOnT9yVojsqVnXda6I1Y
	3UVOC3/xN7MJ/z/sL54N7FfAp8Nlh3KwrdPdMIlB2QsdsNOiFf4qe7sxBIqsPkBV33J757QgnR4
	KKqTjmcyKZrrrLvqBJjKgx2rGmjMr40A=
X-Gm-Gg: AYBFou33aoWACXIRe3FBVRuXORyij5BgWnWHg4mO/XwPgQlJrGHHe1EzpmIFj0xYIbk
	el4iAeiZEdyjibqYA9eILaD211zsMr5+sMZdzdPEl86gb5slfr1euQmPTenpmsXxJiYyU6iYM9M
	jdtUQiFpxnRwgzWuRmCBZu4MSDb1woJxyJZhgKp2SpCXpr0sUBUPdOas7vFVSB46GR8D/C2k1Kl
	k4s38hqV3giWSvzSCwzfla2hjLbe0kjZmhdfoNSf/s2xzL267KcqUScF7OpKMvirvbbh/JKXqOY
	wYDBykPVDsxN61YyqRmS9FNu9lBOfngSqGO5eIlqC6Z9GGpCt5JtddHYCyrXokUhROCTssjKWYW
	UGtkiCaBQi4exC+vasTYEhQOV7GP0HHIqn/cY
X-Received: by 2002:a05:6214:440a:b0:91c:7a28:ac2c with SMTP id
 6a1803df08f44-91c7d1c8ea8mr57159156d6.45.1793218045636; Wed, 28 Oct 2026
 13:07:25 -0700 (PDT)
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
Date: Wed, 28 Oct 2026 22:07:14 +0200
X-Gm-Features: AclHuK8ADXWg0BZmsFa3zyD6jUTA8KjkgEaCcTELUDSN5BqekvV-5qZiXzunHtI
Message-ID: <CA+YDrKCkQ=xzsawRUdk7FUXuO+JvKgEjFuvFAGZwMtOR2Aw1BQ@mail.gmail.com>
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
