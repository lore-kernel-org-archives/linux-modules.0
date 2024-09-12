Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEED8C06
	for <linux-modules@vger.kernel.org>; Thu, 12 Sep 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164513; cv=none; b=gk+i3FZoTshjr7Xz7Mv35ix77LY0qcClfgrtMg4UG7GFNyPtqCxVOH/owmFeyFAa+eIF3xTTGcuJmwB2GxhAC50f4dLBgPVvi777uz3rm2+cBNj+5vwqipIeRUkspxmtgt2jwuc15uIow8KR6ilGsRpVFYuIbtCP4n6RUOJuV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164513; c=relaxed/simple;
	bh=AoIdjj6zpptaAlhlU+g9Fp4Ex6muZH8LCrdY2D7hK7o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClJXq4SR590E23RkDH2PZYZSvOTZwU1v781GuRUq35Pm0XNwpGNECiN3NA6E4FP9QB7tx1QxVZ+fANYZXyDge5UNj6epBmeKnD+MuArPhG5F548dNpVbBGRQxr0NaoG5ojBYf4x8kgQirwpJ1/YIE72erd+qdsoGeJFOCrDJ7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RMotb6Er; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RMotb6Er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qn5mlk3n65ffzfmu73xwsrc4dm.protonmail; t=1726164504; x=1726423704;
	bh=czv56j46ECCfPHacsF1oUT01BM5k2Dpn9Yxl0H8Ck50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RMotb6ErOtyQgupE/aH5RkihYJyiixo9Hh/pkDLG8YXVsPoydymRoBzuyPqTeFqhk
	 9z5IOSuboSudlxKbp6w6mz5UPAReyWesvzz+L6yVtrZXkH1qXl4JvCL8eJzUmYOgeI
	 UnYesS6qn16Spvj2O3EmlJUN+EnKjHLb/5+dqOrAws1sK5/5wyegUAeV9WJ7z/Zlmh
	 VPcYgps4EXLwlBB97k1/3Sk8vp3W9JdjklGNPm5nGEEHwAAP2na9uxpQJ1uBn9uLKb
	 /Xf8L6Fru+7pj/0Bj4xmNdjtd+RrFgt4/yAV5f8XQtg0SUGV4Vb5oaJ1EoODlhoHzE
	 IBTEkp/DudueA==
Date: Thu, 12 Sep 2024 18:08:21 +0000
To: Sami Tolvanen <samitolvanen@google.com>, Petr Pavlu <petr.pavlu@suse.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miroslav Benes <mbenes@suse.cz>, Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved structure fields
Message-ID: <2b2d4953-d2a3-4ea2-98a4-078901cfbda3@proton.me>
In-Reply-To: <CABCJKuer=O3FnLJNGMg2+-HxFJFUrccTuuHt5OiMpRsAJBvBsg@mail.gmail.com>
References: <20240815173903.4172139-21-samitolvanen@google.com> <20240815173903.4172139-37-samitolvanen@google.com> <alpine.LSU.2.21.2408301114000.1124@pobox.suse.cz> <CABCJKucCWfeC0yL6Q2ZcBfef0tMd9L_gmHRJt-cUYkg_4PDtnA@mail.gmail.com> <599892ec-3cf5-4349-984b-7c94f2ba5687@suse.com> <CABCJKuer=O3FnLJNGMg2+-HxFJFUrccTuuHt5OiMpRsAJBvBsg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5ef72b980dc5774a5cc8ca83cf590ddcb687fb9b
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 18:06, Sami Tolvanen wrote:
> On Wed, Sep 11, 2024 at 4:43=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> =
wrote:
>>
>> On 8/31/24 02:05, Sami Tolvanen wrote:
>>> On Fri, Aug 30, 2024 at 9:34=E2=80=AFAM Miroslav Benes <mbenes@suse.cz>=
 wrote:
>>>>
>>>> yes, this is one of the approaches we use in SLES. We add kabi padding=
s
>>>> to some structures in advance (see [1] as a random example) and then u=
se
>>>> it later if needed.
>>>>
>>>> It is not the only approach. Much more often we do not have a padding =
and
>>>> use alignment holes ([5]), addition of a new member to the end of a
>>>> structure ([2] or [3]) and such "tricks" ([4] for a newly fully define=
d
>>>> structure).
>>>
>>> Thanks for bringing this up! Sounds like we're also going to need a
>>> way to completely exclude specific fields from the output then. I
>>> think we can use a similar union approach, but instead of instructing
>>> the tool to use another type, we can just indicate that the field
>>> should be skipped. I'll come up with a solution for v3.
>>
>> It might have been mentioned previously, not sure, but one more case to
>> consider is handling of enum declarations. New enumerators can be
>> typically added without breaking ABI, e.g. 'enum E { OLD1, OLD2, NEW }'.
>> It would be then great to have some ability to hide them from
>> gendwarfksyms.
>>
>> I think neither of the __kabi_reserved or __gendwarfksyms_declonly
>> mechanism can currently help with that.
>=20
> I thought about this a bit and I wonder if we need a separate
> mechanism for that, or is it sufficient to just #define any additional
> hidden values you want to add instead of including them in the enum?
>=20
>   enum e {
>       A,
>       B,
>   #define C (B + 1)
>   #define D (C + 1)
>   };
>
>=20
> Do you see any issues with this approach? I think Clang would complain
> about this with -Wassign-enum, but I'm not sure if we even enable that
> in the kernel, and as long as you don't overflow the underlying type,
> which is a requirement for not breaking the ABI anyway, it should be
> fine.

Rust has problems with `#define`-style enums, because bindgen (the tool
that generates definitions for Rust to be able to call C code) isn't
able to convert them to Rust enums.

So if you can come up with an approach that allows you to continue to
use C enums instead of `#define`, we would appreciate that, since it
would make our lives a lot easier.

---
Cheers,
Benno

