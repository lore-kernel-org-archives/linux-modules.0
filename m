Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF148481DD
	for <linux-modules@vger.kernel.org>; Fri,  8 Nov 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082164; cv=none; b=dX23zWIwROwZ1KGmLtbiKrLymEEBK/LN8QO8voGP50UKakUPNjxGYheBJchfAERSOQnrJr06B6QzswmsNs01NtNWAm0Y7fTvEbgFLKhG2ONf8YP4fkz1UoAId9z43dHcXktS9NUWqny4bp6ugDSUU3j616FewCMpffhNRZ2XvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082164; c=relaxed/simple;
	bh=bwyyBb6cQcABG3qHpZhTMb2+uaFDkXajaX2M/iZ1IlI=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:To:From:Subject:
	 In-Reply-To:References; b=d+GJ8t/p/M7fIX4s8Pz8JTzMbyy/hvF0chYN1t94WVSN67Jg1DByJ9rEkiXOLD8GdKD45/aWYw2f01uCK0DQF+PqE0sptOKPZuSkga6TFVyY7OxC2XMmzU7kvA1uGalO1YVbgLdLZ8gvKnMTyO7OBiiKov6RkY/5APXqcCWFkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jscTzGCh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jscTzGCh"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241108160919euoutp0146cd694d733ca20580ec5a05c3a64d0b~GCg2Br2zx0703307033euoutp01B
	for <linux-modules@vger.kernel.org>; Fri,  8 Nov 2024 16:09:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241108160919euoutp0146cd694d733ca20580ec5a05c3a64d0b~GCg2Br2zx0703307033euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731082159;
	bh=ANmnHXMtaKXCSo2oUGmVN0pbhWQCf5qqCNlDHcoI9aQ=;
	h=Date:CC:To:From:Subject:In-Reply-To:References:From;
	b=jscTzGCh1jLc6ue2QklsyffkfGnvlhVww+km7j4qO45z3qcQY0Y9JUi1h7TIm3xzs
	 yWWRcGzA3ImRegV6K9YbIMmqyvn2drI8xA3GRZRx+MWKdvxBH8ZZj3sygHS1V/5e9Q
	 RIuTs7+jnJIzqMLwCzB1sDFpkOIMx+aJLqnSUM+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241108160919eucas1p107f78be746e710fca63e9966da50e0bf~GCg1r9ty52878228782eucas1p1W;
	Fri,  8 Nov 2024 16:09:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.8C.20409.FA73E276; Fri,  8
	Nov 2024 16:09:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241108160919eucas1p2f4ab6c7c87334172235d870b90ce46ce~GCg1Wrhgu1728217282eucas1p25;
	Fri,  8 Nov 2024 16:09:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241108160919eusmtrp2c442b825bcf2d3d20e038526f7ccd5ff~GCg1WCtHY1941219412eusmtrp2V;
	Fri,  8 Nov 2024 16:09:19 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-95-672e37af1c88
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.D7.19920.FA73E276; Fri,  8
	Nov 2024 16:09:19 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241108160918eusmtip1b97e47265b320d1414339b242ae87e42~GCg1LTcyQ0257302573eusmtip1L;
	Fri,  8 Nov 2024 16:09:18 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 8 Nov 2024 16:09:17 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 8 Nov 2024 17:09:17 +0100
Message-ID: <D5GXESPXRVH3.1M4T003I1F7BU@samsung.com>
CC: Mike Rapoport <rppt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, "Liu Shixin" <liushixin2@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Petr Pavlu <petr.pavlu@suse.com>, "Sami
 Tolvanen" <samitolvanen@google.com>, <linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <Zy4zGy9aoQ1-Qokg@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7rrzfXSDa6slrW4M+k5u8Wx1UDi
	8q45bBYNs7+zWsxcWWhxY8JTRovjvQeYLJZ+ecdscWT9diaLa7OAxNIVb1ktNm+ayuzA4/H1
	5jkmjwWbSj1ajrxl9di8Qstj06pONo93586xe6zfcpXF4/MmuQCOKC6blNSczLLUIn27BK6M
	E/2GBY9kKv5u/cvWwDhdrIuRk0NCwETiUsN9xi5GLg4hgRWMEofar7BDOF8YJV5sPc4CUiUk
	8JlR4u5Me5iOOyfOsEEULWeUaNjRAdUOVLSmYTsLhLODUeL0+/esIC28AoISJ2c+ARvFLKAt
	sWzha2YIW1OidftvoH0cHCwCKhJvJ0uBmLxAG36/EgIZwywwkUniyr3/rCCOiMApRokPm1ew
	g/SyAfXuO7kJzBYWSJE4vucEI8R5ahL/+yeC7eIUMJN4d66DBSKuKDFj4koou1bi1JZbTCBD
	JQQWc0oc+baeBWSzhICLxKXmWIgaYYlXx7ewQ9gyEv93zmeCsNMllqybBTWnQGLP7VmsEK3W
	En1nciDCjhIbew5DhfkkbrwVhPiWT2LStunMEGFeiY42oQmMKrOQwmcWUvjMQgqfBYzMqxjF
	U0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJT1ul/x7/sYFz+6qPeIUYmDsZDjBIczEoivP5R
	2ulCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTMZN2nYe
	q2Y+7llS0cr1QCfn0dcvvL5fONdKrz3iubZiWXyUk+bhieJ6x21+qYXeO8A4S3fmGfutkrlr
	r08V2RdlGZT9pkhcOvyKl33mRuV1S5tTZlXudt1dI3JVplmqWW7GlTmf39ZKOFrFqz0yubnn
	fI5WsvtvvQy2uXszrcSX6TJr1L3VCrcL5ilkUHSPFeL+PemsWci22cxiO06ZfC2+MpvdT+hk
	9vGTf/5EfM5/dcBoUpP0ZJZFAmx5O9880F+/sLg1zfXZoUL2bM/+D375qzzWOqyZIbwpt8Uj
	saXB5SKfXsUh5TPfq5bLHGxumcWuJxMtaPhFP+DD+4A3vOmbBX5HHb0556/69i4NJZbijERD
	Leai4kQAYGB91sgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7rrzfXSDVasYLO4M+k5u8Wx1UDi
	8q45bBYNs7+zWsxcWWhxY8JTRovjvQeYLJZ+ecdscWT9diaLa7OAxNIVb1ktNm+ayuzA4/H1
	5jkmjwWbSj1ajrxl9di8Qstj06pONo93586xe6zfcpXF4/MmuQCOKD2bovzSklSFjPziElul
	aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2ME/2GBY9kKv5u/cvWwDhdrIuR
	k0NCwETizokzbF2MXBxCAksZJT7s+sEMkZCR2PjlKiuELSzx51oXVNFHRokNK9eyQDg7GCUO
	HrnNCFLFKyAocXLmExYQm1lAW2LZwtfMELamROv23+xdjBwcLAIqEm8nS4GYvECbf78SAhnD
	LDCRSeLKvf+sII6IwCmgKzavYAfpZQPq3XdyE5gtLJAicXzPCUaIi9Qk/vdPhDriLrPEjTsv
	wU7lFDCTeHeugwWiSFFixsSVUHatxOe/zxgnMIrMQnLrLCS3zkJy6wJG5lWMIqmlxbnpucWG
	esWJucWleel6yfm5mxiBkb3t2M/NOxjnvfqod4iRiYPxEKMEB7OSCK9/lHa6EG9KYmVValF+
	fFFpTmrxIUZToKcnMkuJJucDU0teSbyhmYGpoYmZpYGppZmxkjiv2+XzaUIC6YklqdmpqQWp
	RTB9TBycUg1MoYcmLVVjnrzyxO3tytJr02/WiRv90G3NMzgoyPD+m/WaNzsdusuFX3//kep5
	R/58zYm3m2Q6mkxaN6/cxDj5QMGLTezPV4Rx7i6IWrc/y8iuYfp/FXef1QufuzjXhJw6tj37
	pkTadN1wyavv79e6flMyK5opIl/wufLIobCZDHuSBfff1puluoFb4Ymey8EjzjUXGopMwqL3
	vFw4tbDCPSxtKYuQmunEmtV3dyxfptTELBfKOzWxf7nKb49tB4tLFyxWr511n2/GhvcCJUcS
	XjButyi9MencWzkr7U6l75X2Vvv2dMjenf6duZEnfp/2Bvv5R9xT3C6t+8HJ6fdiaXt6wsRf
	2qe7i7MvHOP/psRSnJFoqMVcVJwIAKQyc6B1AwAA
X-CMS-MailID: 20241108160919eucas1p2f4ab6c7c87334172235d870b90ce46ce
X-Msg-Generator: CA
X-RootMTR: 20241108154954eucas1p1225526ff7f7d97ae7078f112300f080f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241108154954eucas1p1225526ff7f7d97ae7078f112300f080f
References: <87cylj7v6x.ffs@tglx>
	<3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <877cbr7qed.ffs@tglx>
	<50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com> <87a5gm5tb3.ffs@tglx>
	<ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
	<Zuv0nmFblHUwuT8v@bombadil.infradead.org> <ZvJomuNWjtHYDcsW@kernel.org>
	<8bd5e396-7583-435e-bafc-7d092a31f4ff@csgroup.eu>
	<CGME20241108154954eucas1p1225526ff7f7d97ae7078f112300f080f@eucas1p1.samsung.com>
	<Zy4zGy9aoQ1-Qokg@bombadil.infradead.org>

On Fri Nov 8, 2024 at 4:49 PM CET, Luis Chamberlain wrote:
> + Other new module maintainers
>
> On Fri, Nov 08, 2024 at 09:12:03AM +0100, Christophe Leroy wrote:
>> Hi Luis,
>>=20
>> Le 24/09/2024 =C3=A0 09:22, Mike Rapoport a =C3=A9crit=C2=A0:
>> > On Thu, Sep 19, 2024 at 02:53:34AM -0700, Luis Chamberlain wrote:
>> > > On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
>> > > > On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
>> > > > > Now you at least provided the information that the missing clean=
up in
>> > > > > the init() function is not the problem. So the obvious place to =
look is
>> > > > > in the module core code whether there is a failure path _after_
>> > > > > module->init() returned success.
>> > > > >=20
>> > > > > do_init_module()
>> > > > >          ret =3D do_one_initcall(mod->init);
>> > > > >          ...
>> > > > > 	ret =3D module_enable_rodata_ro(mod, true);
>> > > > > 	if (ret)
>> > > > > 		goto fail_mutex_unlock;
>> > > > >=20
>> > > > > and that error path does _not_ invoke module->exit(), which is o=
bviously
>> > > > > not correct. Luis?
>> > > >=20
>> > > > You're spot on this needs fixing.
>> > >=20
>> > > Christophe, this is a regression caused by the second hunk of your c=
ommit
>> > > d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") o=
n v6.9.
>> > > Sadly there are a few issues with trying to get to call mod->exit():
>> > >=20
>> > > - We should try try_stop_module()  and that can fail
>> > > - source_list may not be empty and that would block removal
>> > > - mod->exit may not exist
>> > >=20
>> > > I'm wondering if instead we should try to do the module_enable_rodat=
a_ro()
>> > > before the init, but that requires a bit more careful evaluation...
>> >=20
>> > There is ro_after_init section, we can't really make it RO before ->in=
it()
>>=20
>> Surprisingly I never received Luis's email
>
> So odd..
>
>> allthough I got this answer from Mike that I overlooked.
>>=20
>> So coming back here from
>> https://lore.kernel.org/all/ZyQhbHxDTRXTJgIx@bombadil.infradead.org/
>>=20
>> As far as I understand, indeed once init is called it is too late to fai=
l,
>
> Partly yes, party no. Party yes in that its a can of worms we have not
> had to deal with before, and also I worry about deadlocks, and the code
> to address this seems complex. right ?

I have a RFC ready with this, I'll send this now so we can discuss on
with a proposal.

>
>
>> Especially when the module has no exit() path or when
>> CONFIG_MODULE_UNLOAD is not built in.
>
> That's exactly the other extreme case I fear for.
>
>> So the only thing we can do then is a big fat warning telling
>> set_memory_ro() on ro_after_init memory has failed ?
>
> I suspect this is more sensible to do.

I came to the same conclusion while trying to fix this path. + I added
an alternative for discussion.

>
>> Maybe we should try and change it to RO then back to RW before calling i=
nit,
>> to be on a safer side hopping that if change to RO works once it will wo=
rk
>> twice ?
>
> That's another approach wich could work, if we proove that this does
> work, it's a nice best effort and I think less or a mess to the codebase
> then special-casing the error handling of trying to deal with the
> driver's exit.
>
> Daniel Gomez has been looking at this, so his feedback here would be
> valuable.

What if we detect ro_after_init first, and block any module
initialization depending on this ro_after_init to actually start loading
it? That way we can stop and unload the module successfully.

>
>   Luis

