Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8511885A4
	for <linux-modules@vger.kernel.org>; Fri,  8 Nov 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082933; cv=none; b=PVcSuSuzQvsWSK0t+fDa1fRHm0SvVoa6iRKJBclSLLo1HO9rr1kehKI6aSP8y8Qz81dPo1qpIIdnXBqaMzhmlmOvyMDaXn0OcFWJZ1HqfervU4LEuV/G5PmQwG3JLj3JsJt523CniqYh5J3R64f1+akGWVTfkLF3egNT11tJHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082933; c=relaxed/simple;
	bh=X3Bu14m0mjtybmOg+NXfDHnfykk0Geg6qmB1khN/pR8=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=DzXj14/HbXBIsH68g6huJX+2lc0HJnvqNN05DoaD/EV9FfuXgBwogDyJ9fFq+30uA/RmOUFwuLqzauSwKAausAzavQr5AljD49cZ07DvlHECjH4FIu23Oxezoxxh2OchgWGYKwPXRYDMTkOF8icHObgX0tQataGp2zSTd49A8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SwjYiAEI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SwjYiAEI"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241108162209euoutp01cfd5653532c81df31415300cebf82e8d~GCsCakqNX1760017600euoutp01r
	for <linux-modules@vger.kernel.org>; Fri,  8 Nov 2024 16:22:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241108162209euoutp01cfd5653532c81df31415300cebf82e8d~GCsCakqNX1760017600euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731082929;
	bh=3Lperh0AwiJdCdZ057laB85yTaUwLOwIDG6MZrtqKRA=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=SwjYiAEI9SkDWA3A5a1CIOCfYXIVeVDRFktEnCWx1hpSxvfsbUbffYe0/6UwCTIsS
	 u1Q128MECh5D4dsT0mRY0B+mEqr3DXpdNDx3JrrRRJvmBfjP01EthI+mrX3drEEuOk
	 cxws6l5WBIDp5oLDxPe6v2UgAVPXOlGVnx/9jflc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241108162208eucas1p19b20b3aaebaff2a70a38224be4d73a7d~GCsBuntD51943319433eucas1p1L;
	Fri,  8 Nov 2024 16:22:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5B.1A.20397.0BA3E276; Fri,  8
	Nov 2024 16:22:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241108162208eucas1p2eb9cc8b76b0797ba1c5d720d7e7fcf05~GCsBZFOqM2819828198eucas1p2k;
	Fri,  8 Nov 2024 16:22:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241108162208eusmtrp2dafddf99f306ac5b70d657742347206e~GCsBYbhww2644626446eusmtrp2P;
	Fri,  8 Nov 2024 16:22:08 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-20-672e3ab03b7f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.29.19920.FAA3E276; Fri,  8
	Nov 2024 16:22:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241108162207eusmtip2c559ef632ae055ca4692837b9b562487~GCsBOO4Cr2587525875eusmtip2r;
	Fri,  8 Nov 2024 16:22:07 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 8 Nov 2024 16:22:06 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 8 Nov 2024 17:22:06 +0100
Message-ID: <D5GXOLX14TL7.3QXEU9ZLHBFKR@samsung.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
CC: Mike Rapoport <rppt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, "Liu Shixin" <liushixin2@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Petr Pavlu <petr.pavlu@suse.com>, "Sami
 Tolvanen" <samitolvanen@google.com>, <linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <D5GXESPXRVH3.1M4T003I1F7BU@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7obrPTSDbatELK4M+k5u8Wx1UDi
	8q45bBYNs7+zWsxcWWhxY8JTRovjvQeYLJZ+ecdscWT9diaLa7OAxNIVb1ktNm+ayuzA4/H1
	5jkmjwWbSj1ajrxl9di8Qstj06pONo93586xe6zfcpXF4/MmuQCOKC6blNSczLLUIn27BK6M
	O/PPsBb8la94eO8FUwPjZ4kuRg4OCQETiflTlLoYuTiEBFYwShxoXsrSxcgJ5HxhlNi4JgIi
	8ZlRomfbJWaQBEjDtllnWCASyxkl3vxZwgJXdfLjCTYIZxOjxL0925lAWngFBCVOznwCNpdZ
	QFti2cLXzBC2pkTr9t/sIDaLgIrE9r/NUPUmEvvXrwSrERZIkTi+5wQjyFBmgYlMElfu/WcF
	cUQETjFKfNi8AqybDWjSvpOb2CEOVJP43z8RbBungKnElG0fmSDiihIzJq5kgbBrJU5tucUE
	MkhCYDGnxKq9s6CaXSQubn/DBmELS7w6vgUqLiPxf+d8qEHpEkvWzYIaVCCx5/YsVkhQWkv0
	ncmBCDtKbOw5DBXmk7jxVhDiYT6JSdumM0OEeSU62oQmMKrMQgqiWUhBNAspiBYwMq9iFE8t
	Lc5NTy02zkst1ytOzC0uzUvXS87P3cQITFyn/x3/uoNxxauPeocYmTgYDzFKcDArifD6R2mn
	C/GmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTC5Bm9o9OY9
	vzw6+t0NL2kB7fMaEYHnvbTU2K4kMgbva38tWXdzK3vfRqX87AXutg0r1jzQXMjjb+/2al7i
	lKeOZUfiDgStMQzIFgpYdOdSwOV7hy+nRvz/+vjoBrkl1tnvO5b931A+4xW/6Ra2GFPz+4+y
	vscKr9uSk+408eO542bVdidK5FUvXNu4eu2azofKGZpcpWt3vf/XI5id8O3aPotaMVblnKPC
	J1/8uK70V/GD+A3/qEk16lt/sAetDDWIY3+w14clUttb/uj6mhqjOaGr3Q47ll0///Mzo578
	nLPl2i4O9x8vYU/kPLPwyN6fnRaviwNFqxgvFTQLS02XCppgx9K4b13WyVsxTMFKLMUZiYZa
	zEXFiQB93JjpywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7rrrfTSDWa9srS4M+k5u8Wx1UDi
	8q45bBYNs7+zWsxcWWhxY8JTRovjvQeYLJZ+ecdscWT9diaLa7OAxNIVb1ktNm+ayuzA4/H1
	5jkmjwWbSj1ajrxl9di8Qstj06pONo93586xe6zfcpXF4/MmuQCOKD2bovzSklSFjPziElul
	aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MO/PPsBb8la94eO8FUwPjZ4ku
	Rk4OCQETiW2zzrB0MXJxCAksZZS4NGkDI0RCRmLjl6usELawxJ9rXWwQRR8ZJZ49fgnlbGKU
	uH7tCRNIFa+AoMTJmU9YQGxmAW2JZQtfM0PYmhKt23+zg9gsAioS2/82Q9WbSOxfvxKsRlgg
	ReL4nhOMIEOZBSYySVy5958VxBEROMUo8WHzCrBuNqBJ+05uYoe4SU3if/9EqMPbWCS2LLwL
	luAUMJWYsu0jE0SRosSMiStZIOxaic9/nzFOYBSZheTaWUiunYXk2gWMzKsYRVJLi3PTc4sN
	9YoTc4tL89L1kvNzNzEC43vbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7/KO10Id6UxMqq1KL8
	+KLSnNTiQ4ymQG9PZJYSTc4HJpi8knhDMwNTQxMzSwNTSzNjJXFet8vn04QE0hNLUrNTUwtS
	i2D6mDg4pRqYNMu1J4Xz76jSK+sv5Vc6dGrial+BVdnrty031rtcIxU+pX4K1wYho8p9tZMf
	nvJr6Z7dv/vRRfX27uKV08/MswrfxXs6M2ofp0edwHyxdJH6BcefLfdiDs68e11zzuNN/ut9
	zxiFhdS9NFF6sOgA8yT2q4yLLTa/2Ozz7tfRsBkyXRO2L/r13iZK/UfhzXaXNPWUkkIWx0Oe
	e5s4A7L4U8OndQSfa5myON0+TKOgPvp1x43gmS4qVSZXH6bKbjoyoazk5WGzhR5abx+6rTy7
	QbBGSFp3vrxbRdBiic0T0mJmv+grdxLvM/j1z4H/+62Xq6Qn9ifun/csS9/nrEThCumNFx8m
	iG10n11uXRGqxFKckWioxVxUnAgAM2V6LXgDAAA=
X-CMS-MailID: 20241108162208eucas1p2eb9cc8b76b0797ba1c5d720d7e7fcf05
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
	<D5GXESPXRVH3.1M4T003I1F7BU@samsung.com>

On Fri Nov 8, 2024 at 5:09 PM CET, Daniel Gomez wrote:
> On Fri Nov 8, 2024 at 4:49 PM CET, Luis Chamberlain wrote:
>> + Other new module maintainers
>>
>> On Fri, Nov 08, 2024 at 09:12:03AM +0100, Christophe Leroy wrote:
>>> Hi Luis,
>>>=20
>>> Le 24/09/2024 =C3=A0 09:22, Mike Rapoport a =C3=A9crit=C2=A0:
>>> > On Thu, Sep 19, 2024 at 02:53:34AM -0700, Luis Chamberlain wrote:
>>> > > On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
>>> > > > On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
>>> > > > > Now you at least provided the information that the missing clea=
nup in
>>> > > > > the init() function is not the problem. So the obvious place to=
 look is
>>> > > > > in the module core code whether there is a failure path _after_
>>> > > > > module->init() returned success.
>>> > > > >=20
>>> > > > > do_init_module()
>>> > > > >          ret =3D do_one_initcall(mod->init);
>>> > > > >          ...
>>> > > > > 	ret =3D module_enable_rodata_ro(mod, true);
>>> > > > > 	if (ret)
>>> > > > > 		goto fail_mutex_unlock;
>>> > > > >=20
>>> > > > > and that error path does _not_ invoke module->exit(), which is =
obviously
>>> > > > > not correct. Luis?
>>> > > >=20
>>> > > > You're spot on this needs fixing.
>>> > >=20
>>> > > Christophe, this is a regression caused by the second hunk of your =
commit
>>> > > d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") =
on v6.9.
>>> > > Sadly there are a few issues with trying to get to call mod->exit()=
:
>>> > >=20
>>> > > - We should try try_stop_module()  and that can fail
>>> > > - source_list may not be empty and that would block removal
>>> > > - mod->exit may not exist
>>> > >=20
>>> > > I'm wondering if instead we should try to do the module_enable_roda=
ta_ro()
>>> > > before the init, but that requires a bit more careful evaluation...
>>> >=20
>>> > There is ro_after_init section, we can't really make it RO before ->i=
nit()
>>>=20
>>> Surprisingly I never received Luis's email
>>
>> So odd..
>>
>>> allthough I got this answer from Mike that I overlooked.
>>>=20
>>> So coming back here from
>>> https://lore.kernel.org/all/ZyQhbHxDTRXTJgIx@bombadil.infradead.org/
>>>=20
>>> As far as I understand, indeed once init is called it is too late to fa=
il,
>>
>> Partly yes, party no. Party yes in that its a can of worms we have not
>> had to deal with before, and also I worry about deadlocks, and the code
>> to address this seems complex. right ?
>
> I have a RFC ready with this, I'll send this now so we can discuss on
> with a proposal.
>
>>
>>
>>> Especially when the module has no exit() path or when
>>> CONFIG_MODULE_UNLOAD is not built in.
>>
>> That's exactly the other extreme case I fear for.
>>
>>> So the only thing we can do then is a big fat warning telling
>>> set_memory_ro() on ro_after_init memory has failed ?
>>
>> I suspect this is more sensible to do.
>
> I came to the same conclusion while trying to fix this path. + I added
> an alternative for discussion.
>
>>
>>> Maybe we should try and change it to RO then back to RW before calling =
init,
>>> to be on a safer side hopping that if change to RO works once it will w=
ork
>>> twice ?
>>
>> That's another approach wich could work, if we proove that this does
>> work, it's a nice best effort and I think less or a mess to the codebase
>> then special-casing the error handling of trying to deal with the
>> driver's exit.
>>
>> Daniel Gomez has been looking at this, so his feedback here would be
>> valuable.
>
> What if we detect ro_after_init first, and block any module
> initialization depending on this ro_after_init to actually start loading
> it? That way we can stop and unload the module successfully.

In case I'm missing someone, I've just sent the RFC here:

https://lore.kernel.org/linux-modules/20241108-modules-ro_after_init-v3-0-6=
dd041b588a5@samsung.com/T/#t

Please ignore "v3" prefix. That was a mistake. Not sure why b4 added
that.

>
>>
>>   Luis

