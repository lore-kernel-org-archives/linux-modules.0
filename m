Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844C20DD6A
	for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404629; cv=none; b=d+uX/OpOSYaoBWflEQ/Hsvjt0CSZ4/s5MVWMMXCQLlq9RWSZ5aIDyHNJCzvQ0aYBaJ1vzCmtMe9faRghaztnSyWIX3UgJANGl6Z5aDfGq2VoIoP7I2fLu9s2QMur8T7O/mgeJmx2pn2870uF5gGrXRwa5iXFmQGz4JUbgUYBTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404629; c=relaxed/simple;
	bh=sUIQT532RhR40EjxR/38gjCJrf9gHS8YseWwi553YVg=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=Y74WtBxzXlWDojdlG5oZMJtgbQ8e+xA5+Lm0pNzAllK9XR1zmvQ6xEt8zxgCL/JLQ/1Cd+fX4FcbGchVH9gqY1LmPE3q7vA5wV3VrXlTASakDeZ5Hj5a46E6TGrHLrL9H6TivuJlTlAs7DdCarKh5C8ABtNamOQcmPXGglZljY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OrZomr7F; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OrZomr7F"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241112094338euoutp013c63efae3375a58b86021123200301ad~HL1POoYew1882018820euoutp01C
	for <linux-modules@vger.kernel.org>; Tue, 12 Nov 2024 09:43:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241112094338euoutp013c63efae3375a58b86021123200301ad~HL1POoYew1882018820euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731404618;
	bh=CHpQFp6geT8jvKwGScMS3SxC2spTizcApYVBR0oB4Wc=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=OrZomr7Fb6/fpjxgMQE1+89lLCZYyY/GAgtftctOMKoecA/nAGdH6dCk6Ca82NA0H
	 +lRk/SaCets5LNso/h6yROsGhIaQtqSt9kpnAeqfAcN/R/FFf71cJ9DNp1R3aHErP4
	 WU6XZFdoDb99vc5zAZovLkNMnV0X4kyBBzss2ybg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241112094338eucas1p12de819a8f119ec462e89f1d9e9a244d6~HL1O_hxHt0688706887eucas1p1h;
	Tue, 12 Nov 2024 09:43:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 44.41.20397.94323376; Tue, 12
	Nov 2024 09:43:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241112094337eucas1p19af6df9473286175ec5d232bfed373c8~HL1N6koXE1113411134eucas1p1p;
	Tue, 12 Nov 2024 09:43:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241112094337eusmtrp18cb5b26cf6f350fac2116d8e68d97871~HL1N6C3jn2384923849eusmtrp14;
	Tue, 12 Nov 2024 09:43:37 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-27-67332349f761
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.B3.19920.94323376; Tue, 12
	Nov 2024 09:43:37 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241112094337eusmtip11d4aaadbc5503537cac09a0328a70d1a~HL1NsWXh63148531485eusmtip19;
	Tue, 12 Nov 2024 09:43:37 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 12 Nov 2024 09:43:36 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Nov 2024 10:43:35 +0100
Message-ID: <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
	<linux-modules@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7peysbpBu/9LO5Mes5use7teVaL
	y7vmsFk0zP7OanFjwlNGi6Vf3jFbLF3xltVi86apzA4cHl9vnmPyWLCp1GPTqk42j3fnzrF7
	rN9ylcXj8ya5ALYoLpuU1JzMstQifbsEroxd/TcZC05pVBzsb2FrYJwm38XIySEhYCLxf9pX
	pi5GLg4hgRWMErveb2SDcL4wSizc18oC4XxmlPh37zEbTEvnkU3sILaQwHJGiU0dcXBFt9c3
	s0I4OxklZh+6wwxSxSsgKHFy5hMWEJtZQFti2cLXzBC2pkTr9t9gk1gEVCUe37rHDlFvIjG5
	fy8TiC0skCvRdu0ZVK+HxKIDj8BOEhF4ziixem8X2ElsQIP2nYQ4SUJATeJ//0SwBk4BO4nj
	B6ezQMQVJWZMXAll10qc2nIL7GsJgR8cEt3PmxkhEi4Sc3ofQRUJS7w6vgVqqIzE6ck9UPF0
	iSXrZkHZBRJ7bs8CepkDyLaW6DuTAxF2lLj7eTNUmE/ixltBiPv5JCZtm84MEeaV6GgTmsCo
	MgsphGYhhdAspBBawMi8ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzD9nP53/OsOxhWv
	PuodYmTiYDzEKMHBrCTCq+Gvny7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7
	NbUgtQgmy8TBKdXAtN0k+Pe9izsvSrH+CN8rs1U8SSWFZ/XTCZOXB0ps2eSQob8j/MUsw2u3
	NybwLA3V/PntpcetrxpXdq3h+D1dJaDouo7Jf+4PXLu1ppqGs0vPEaqXC9J72qH7lkmsX9jT
	xGr9s65FG93Odjk4Ld/ELxKywFFkBzebp01Mqr1v5AHv2CVXhExYV977JnxdWi9QJrjGevm+
	xy/1r+e2aQpH191lEGu86XLzsfq9vEt1R7Im5mdMEEnM/P+pqaavdvusq2qLHvZwPSwsiUzb
	2Bj38NytNu8jN30+rp2qrryisLc9b/qbxrZ7571PPEspe3h+vWVd3Wcmjf8imU9KN1y82u95
	gDEtpFrrm+G7f/yLlFiKMxINtZiLihMBX2u+J64DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7qeysbpBod6eS3uTHrObrHu7XlW
	i8u75rBZNMz+zmpxY8JTRoulX94xWyxd8ZbVYvOmqcwOHB5fb55j8liwqdRj06pONo93586x
	e6zfcpXF4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
	zLLUIn27BL2MXf03GQtOaVQc7G9ha2CcJt/FyMkhIWAi0XlkE3sXIxeHkMBSRom+T7sYIRIy
	Ehu/XGWFsIUl/lzrYoMo+sgo8WfGAaiOnYwSrTN2MINU8QoISpyc+YQFxGYW0JZYtvA1M4St
	KdG6/Tc7iM0ioCrx+NY9doh6E4nJ/XuZQGxhgVyJtmvPoHo9JBYdeMQCskBE4DmjxOq9IKs5
	OdiABu07uYkd4iQ1if/9E1kgrnjCJLG+cTLYJE4BO4njB6ezQBQpSsyYuBLKrpX4/PcZ4wRG
	kVlIjp2F5NhZSI5dwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBKtx37uXkH47xXH/UO
	MTJxMB5ilOBgVhLh1fDXTxfiTUmsrEotyo8vKs1JLT7EaAr09URmKdHkfGCayCuJNzQzMDU0
	MbM0MLU0M1YS53W7fD5NSCA9sSQ1OzW1ILUIpo+Jg1OqgSn09M5LHvJt+gtf7Hz/S+DZr1X3
	xHZGJEWq+n2+eNfk4N+Xi7LrVxb+uhbdasFXOOWsdduvbzvDA4vdEgwaQu0NnZ9ohpm4FVrw
	T1XYOX9P5tLa2NQQe0n+rqXaFo6bsyR7sv8lhPY9f7hqjpBq3Ylq+aVWs/Tm5E822RbVtu75
	DaGWFX5+P3durNl163/HYX1//hjJaVpMx7bEb1ZtyF4u8V/n87zd3zzWxC/M7fZJ3XFgwfGi
	ZxMs4gyvbQ2+N2tV/euYBMsr3M5/bSXeHjf46eZ1ZP+kVi1JxxDTyD1srL7rZ1xgF55wUjK9
	iyP2qm3pQ60mpfacelX7A0tbeh3Ly6PYni3zYHxQV2h4RImlOCPRUIu5qDgRAL+oDqRbAwAA
X-CMS-MailID: 20241112094337eucas1p19af6df9473286175ec5d232bfed373c8
X-Msg-Generator: CA
X-RootMTR: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
	<CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
	<164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
	<D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
	<b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>

On Mon Nov 11, 2024 at 7:53 PM CET, Christophe Leroy wrote:
>
>
> Le 09/11/2024 =C3=A0 23:17, Daniel Gomez a =C3=A9crit=C2=A0:
>> On Sat Nov 9, 2024 at 11:35 AM CET, Christophe Leroy wrote:
>>> Once module init has succeded it is too late to cancel loading.
>>> If setting ro_after_init data section to read-only fails, all we
>>> can do is to inform the user through a warning.
>>>
>>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>>> Closes: https://protect2.fireeye.com/v1/url?k=3Dd3deb284-b2a35ac3-d3df3=
9cb-74fe485fff30-288375d7d91e4ad9&q=3D1&e=3D701066ca-634d-4525-a77d-1a44451=
f897a&u=3Dhttps%3A%2F%2Feur01.safelinks.protection.outlook.com%2F%3Furl%3Dh=
ttps%253A%252F%252Flore.kernel.org%252Fall%252F20230915082126.4187913-1-rua=
njinjie%2540huawei.com%252F%26data%3D05%257C02%257Cchristophe.leroy%2540csg=
roup.eu%257C26b5ca7363e54210439b08dd010c4865%257C8b87af7d86474dc78df45f69a2=
011bb5%257C0%257C0%257C638667874457200373%257CUnknown%257CTWFpbGZsb3d8eyJFb=
XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldU=
IjoyfQ%253D%253D%257C0%257C%257C%257C%26sdata%3DZeJ%252F3%252B2Nx%252FBf%25=
2FWLFEkhxKlDhZk8LNkz0fs%252Fg2xMcOjY%253D%26reserved%3D0
>>> Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()"=
)
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   kernel/module/main.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>> index 2de4ad7af335..1bf4b0db291b 100644
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module =
*mod)
>>>   #endif
>>>   	ret =3D module_enable_rodata_ro_after_init(mod);
>>>   	if (ret)
>>> -		goto fail_mutex_unlock;
>>> +		pr_warn("%s: %s() returned %d, ro_after_init data might still be wri=
table\n",
>>> +			mod->name, __func__, ret);
>>> +
>>>   	mod_tree_remove_init(mod);
>>>   	module_arch_freeing_init(mod);
>>>   	for_class_mod_mem_type(type, init) {
>>> @@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module =
*mod)
>>>  =20
>>>   	return 0;
>>=20
>> I think it would make sense to propagate the error. But that would
>> require changing modprobe.c. What kind of error can we expect when this
>> happens?
>
> AFAIK, on powerpc it fails with EINVAL when
> - The area is a vmalloc or module area and is a hugepage area
> - The area is not vmalloc or io register and MMU is not powerpc radix MMU
>
> Otherwise it propagates the error from apply_to_existing_page_range().=20
> IIUC it will return EINVAL when it hits a leaf PTE in upper directories.

Looking at that path I see we can also fail at __apply_to_page_range()
-> apply_to_p4d_range() and return with -ENOMEM.

My proposal was to do something like the change below in modprobe:

diff --git a/tools/modprobe.c b/tools/modprobe.c
index ec66e6f..8876e27 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -572,6 +572,11 @@ static int insmod_insert(struct kmod_module *mod, int =
flags, const char *extra_o
                err =3D 0;
        else {
                switch (err) {
+               case -EINVAL:
+                       ERR("module '%s'inserted: ro_after_init data might"
+                           "still be writable (see dmesg)\n",
+                           kmod_module_get_name(mod));
+                       break;
                case -EEXIST:
                        ERR("could not insert '%s': Module already in kerne=
l\n",
                            kmod_module_get_name(mod));

But I think these error codes may be also be reported in other parts
such as simplify_symbols() so may not be a good idea after all.

Maybe we just need to change the default/catch all error message in
modprobe.c and to indicate/include this case:

diff --git a/tools/modprobe.c b/tools/modprobe.c
index ec66e6f..3647d37 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -582,7 +582,8 @@ static int insmod_insert(struct kmod_module *mod, int f=
lags, const char *extra_o
                            kmod_module_get_name(mod));
                        break;
                default:
-                       ERR("could not insert '%s': %s\n", kmod_module_get_=
name(mod),
+                       ERR("could not insert '%s' or inserted with error %=
s, "
+                           "(see dmesg)\n", kmod_module_get_name(mod),
                            strerror(-err));
                        break;
                }


>
> On other architectures it can be different, I know some architecture try=
=20
> to split the pages when they hit hugepages and that can fail.

Is it worth it adding an error code for this case in case we want to
report it back?

>
>
> But I believe if it works the first time it should work next time as well=
.

Okay. It would be good to know if this is a common behaviour among
different architectures.

>
>>=20
>>>  =20
>>> -fail_mutex_unlock:
>>> -	mutex_unlock(&module_mutex);
>>>   fail_free_freeinit:
>>>   	kfree(freeinit);
>>>   fail:
>>=20

