Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021072.outbound.protection.outlook.com [52.101.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05D3955EE
	for <linux-modules@vger.kernel.org>; Sun,  6 Sep 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701958; cv=fail; b=az6ZCrlL2p3GqX4Py5xA7RWfiqYFeyQtABZFLnYpIhgsb1cis7DJMjcK0oxwnQ9ZMKXhsgmtHByRznlQG0osrBCAnvY/Xy0ib7kYqsRIzMcIJOCRXsQ+5oOJRSHEiUsMPI17MEuduZUab+KMF//fgQnDGZQZZswKTu5I/PZaqAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701958; c=relaxed/simple;
	bh=VpRpnKmG+RMiFkJd2z3xTziqJHZEO7fUffIY7NorveE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=jFNXDWF6ZDxBcc3eKI1O7Qln46MEshifNy29ApWlvJjzA/3X7kmlqRb7BZET/b1M5vKnB7+s+eC85Ywcev9enhBPqu9yA03JpbpmuZ+c5Z26wGxoJYuf4/BQUIZV+rj2tY/mg/n/N+5/md/R4iAixGvLTpybiehnn4ndQAaNZsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=R87BcL2n; arc=fail smtp.client-ip=52.101.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="R87BcL2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSmPT1PtZHenSBYZwqmVRfjt6xct/Zgy6rIaIKbdljNTSLCDCj5PuU8QDBESbhAzpNPvaCpKD39e24Cg3QfXBWN6gj3sUCotsNydzkk7yWHMWUiCIIs4ATjjs+RGBkbvuSJZBwtcaJ3X86R17MPHeok3wffKD4cy/3drIoUtZ12RdAT6DDdFS4IdnFI7RxCVeBeAmnXqbyy3DhQYKe5OzgqpZLMXkjyFa5jIA6BBIIMZAYnJSsVGtJbDs7cnOCS0OGpXXkZ8WuLCobau8yfgEQE3LKVbSpX6pQedmVnYsJFGy33b1SeZ9qnTtl9N0AmvLmOnLwLe9QF/T5aflx8xBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLT8vshiNuH+RTJYWZjcm8pO78iza4vk4N/KMvXeGSE=;
 b=NN00mgBw/7MqHgBpPi+mpd3Da0/8PAAAyH3q3fZBWPRDS+OyPR416TR3Pa6KgJr+RcNL9R4iD5IXUsQ6yCwMbi40QdEHkxFikQOs7SxU0JH0tovlA7lZvu0xdFvBGstUebTIvTEbTvOb+Myd/lXSvt9SLfkGoGx4scRZkmiYgqK+8QkGgpAQODMu9PxK2I/TWaZ3B3rXtp8YtnQ+H/MkXiw+/OHTePfgKeHfKISsKA9fYRwvMJude+Zhn7g6zXkpV70XoSRLYvu3+dGWz6UZXXwca8hIqfXRXbKuQs+Nz/RD4N/wjshnG1u3pYka5/T15ZZyX64Bl6RKvu2VVIKdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLT8vshiNuH+RTJYWZjcm8pO78iza4vk4N/KMvXeGSE=;
 b=R87BcL2n0kpYJtfY3qTQJi0fc46/FqcFNX2HNgVt/+J7x4WMkF2Sr1LaW5y99is/08mK5C7uATiWoxzAwDKqkS1wcu/07pwvopqTbTMN3LEzZ8T4GwUyTSD/aAVyXIHBc1l2H57WkaP/6JzjwGW3f4w+DQ/nEP+6n+Zv5xpz1NU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWYP265MB9421.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 13:39:13 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 13:39:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 14:39:12 +0100
Message-Id: <DL89X93TI07G.18X8GZUFIIM6@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Aaron Tomlin" <atomlin@atomlin.com>, <sashiko-reviews@lists.linux.dev>,
 <petr.pavlu@suse.com>, <gary@garyguo.net>
Cc: <ojeda@kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] module: Extend module_blacklist parameter to
 built-in modules
X-Mailer: aerc 0.22.0
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-2-atomlin@atomlin.com>
 <20260903191303.5A14B1F000E9@smtp.kernel.org>
 <xuj6okhlofl4cboopwjzqe3jyfmaxgvdpf5a3ek7bubew4vcbk@nkfqgoe53533>
In-Reply-To: <xuj6okhlofl4cboopwjzqe3jyfmaxgvdpf5a3ek7bubew4vcbk@nkfqgoe53533>
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWYP265MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3826ef02-5f32-40e6-6ddb-08df0c1c3cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|23010399003|366016|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	145C/FwJGbWhUVnhGq3uCRpP9UErSpYgqHOumPCpY0GngDivMIxTNCnpQdxqTmXUVxO9IFyfZdjTc4jmul0yLsQvibxV6f6AqLxWK/Oe1UVOzUrOR+PQye4TlB44GBs1jNPzDoVvgT1CqjgWIdwkH1F2t9WQifZShxE7rbPRBnCjjmMA4MN3gTh+RHOKqhelzhvGhO5gXzbcLNTAj3IcbyKzYuEmCCiV8xd2DWf6oXMKqaLw2QQzRmTHttFKyqAj038bbHjqh5W9Sk7nSeeuBlGum8rd9eLU2ou2fXNLsI5f/jKsRMOV6MMVVCL20AOo+u4EBAqJ25+ioGYy/lsA5dbYgQJKaKHCMbByHHY99L87neyPrPnjAXB7E6hOuc5y0JwJXz4QomYZ5jHD4wYmyhtoLOa0Lm+pQVS7ikSAKEURVXA26wN+uTd2pWmDHEAHMlPmGBwXGp2pfVEISzd7/nIYilNyQApXCuP8jYGkxTWO1NKx3qYBDWzvnrw+/4xixWi8yqVRsTns8rcniZFmyoJ5CZIR2wSet+dOaQVlQ/+8C2HUl7oC5ek1+BYz33+h+NcL3y+fxt/AlBPNH9SG87TKOWPlsQtRzULMMM4RcuUY5rNY4V59qu5YxQpbjvdPius7jcXKf4LeeNBlD+aVEjKYOPuQd3uDyE5ugvY1mwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTdkUkhCUUdxcFh4dVdHOW1jSTJOa3BNQ09PWjBydUlSbHlRRlBSMUpSQ21M?=
 =?utf-8?B?M1gxSDRrV3pXcEprMFUxNW9wb2hsQjhtV1lVUTQ2cUlycEhDVUhMdlZLK1g3?=
 =?utf-8?B?SjZoM3lTTVJUM0FQUVl4MllEK3N6NWdlei9hbkNKd0pVOGkvTnpES3M1d0h4?=
 =?utf-8?B?bWZWYkZGOGRvME40U3JaK29IOUYzNWVQS0FVVENFUUxrNlk1NUxOMVFYcWlN?=
 =?utf-8?B?RFk2Z2pDd3YwemZEaGE2YWllaWI5QzdVK0JzTUpibUtweERzZFF5dUJqK0M5?=
 =?utf-8?B?SUhzeHhCOWVLTHRmZ3dnWW1ydFRwRWNEdTgzR1FEVSs5cUFzOGptUXhORllD?=
 =?utf-8?B?MTUxaERCdE1KcEVhTnBUNzE2VWJNODVwTkJwU090QXFDL21MRllkRjRLd1Ex?=
 =?utf-8?B?MlhWb3hWb1Z0aFk1andDTENNWGltVDArUWtiNVNFeUc5djQ3WjJ2cFJML3Vx?=
 =?utf-8?B?aWtvN1ZqVHRkSjJ5QTJJTkZveEE4UUJjdzRzNjBHUEFtRnN1WXJzcG9KTXJm?=
 =?utf-8?B?UFN2QXpiYndGMmRNQXRwOTFIL1h3M0lUWkp5THg0c3ZOQk8xcytPd0QwQ1E3?=
 =?utf-8?B?MEZodkxmN2lGS1JBNVgwdktldnZ5YXIvWUl4WEhXSEQxeVRqWFJDdGNJQjV6?=
 =?utf-8?B?dG95QnFYOXVaOVEyRDE3Y2FLbHl0K3FYQUxJdEdnc3Y3NTZ1cndPRndHcHNJ?=
 =?utf-8?B?QkVmN2ZGZngxNzVCeXpEQzFYUFlWM01HYm9zSEpydUFjSVZDSjJqRzcxbzJP?=
 =?utf-8?B?eWZKNWRTNTBQUWlXYzdiVlFIeTJJWXh2cHh1cFloVHFZbnQ4Q2RZNWNybG5M?=
 =?utf-8?B?cWVDOC9RNzZiQm1iSHZRbHFlMWI2dSsya3gzN3hvYkp4cVZ2MUZNVVZ6TzFL?=
 =?utf-8?B?Q2xtNnl5M3pPUkFGRkNzdUREMVBMMk1zYWRkMlRlVm9mT3BVQXVjRnlPRm1x?=
 =?utf-8?B?Qk56S2J5VGhRZDBVY3Y3ejl1bUtiZERXWkZ0ZnppWWNHNnYyaXd3NXZYSDZj?=
 =?utf-8?B?N0hGc09YdHZldnBZVE5kZFBWb3VKL2tqWEVlcG1xZGhTTmdaVFZtZ1VUakJH?=
 =?utf-8?B?NWpWWHFCbkhsRm1JZXFSSFoydHNDa0MrN3dWNVBpQmJvekdaVFl5NW1WOWw0?=
 =?utf-8?B?WnRPdndGbWsrZnR4S2JVamI1TmtyRDB3SE1XaUlYV0xpdmM3cWh3YVBmQjFC?=
 =?utf-8?B?dEw2d3RUU2VSbEhOYTFWYXc0L3dYNzZyVnZ0VFRSaGhrUnFuYmNrY0w1d1Zj?=
 =?utf-8?B?Q1NRUXRIZ0pCUjJwYnlXOGU0T2lLV2JxZHJiSnVaRmU0bFZQTU5iU1ByQ2Nh?=
 =?utf-8?B?N1VZelFYbWMxTkxtSjkva0IyU3RLTXRYMVhSenh0TU5jOUsyZVdtVVVDeXoz?=
 =?utf-8?B?VFhTTjJoNU9NTHFWaGJhSVpEMGVQTmtleWRvcEJNbUMrdjFyblB3WGlvR21J?=
 =?utf-8?B?L0RGQXFTY2Z0eXppNmpIRXdpbDU5Ymd1Y2hHM2FwMXZvT1dKaXFzbG9aVnhp?=
 =?utf-8?B?bWt2bVA4ZWtvemtaVzBXMUIyUlJKTnlpaEJvc1MwZk41cUtwR3FISmhWK1V4?=
 =?utf-8?B?bXFybmlvZHV4bXNxMDVGb29YYnduNmNSQ2c0VWtIb2xQS2xMeEVERXVuRTNY?=
 =?utf-8?B?YnQ1TlB5L0dBdk4yemxtVHg5emNuRGtNa2Y5MFc0TVNDYTRERG14c0w2M1Rl?=
 =?utf-8?B?bEhsV0FYd1pObzlKbnluUTF6OUZRWHlsSWRoMlEvREQvM295aGlSUkhyMFIz?=
 =?utf-8?B?ZEsrVEs5d1JoS0xYUG5WazEvcE5zbG5nZm5SRm44THZ4VHl1amVMOExyREFI?=
 =?utf-8?B?blJlc1hSeVd2aENsSUJ2MUx6K3FCMDE0TjFCRmhGbEtwR3pVZ01Vb0NsQ21R?=
 =?utf-8?B?RFlwOEZ3cCtET1RuOHU4WVFwQ013UXBlVGhzV09BVlVJOTFYaUxvbEZXUVJD?=
 =?utf-8?B?WG0vb2V6ckx5R2NlOVhMdWlwS1BkbU1iT3JZdVNqYkZNbUZvbFpXeEJNL2t3?=
 =?utf-8?B?K0RvcFp3VUpxL1JQaFFzdmlQcFRwNmlkeFZzVUZtT3JqWWxUWDhDdktsQnpJ?=
 =?utf-8?B?cFBLTWc2RVJyRVFnTmQzMVVqZXR3UE8vRytiVTdvUDFkMFJ0MGtkRS92NTB4?=
 =?utf-8?B?YVRXamJmQXBFcmw4cFk1TG5DMEhMUStSTDN4YU1GUWdtRnJLU1FMMjRpS214?=
 =?utf-8?B?a3ZQZHRuSnZrQjZVcU1FMWR6am1FRzJQQ3hGdmZldi93SjB4TTBuY1kxZEpI?=
 =?utf-8?B?WnlSWFZSMW0yR1g3dWRkQ2ZVTHF4T3JEWHNBSDJLN29BUGNsRUZrTVkrdjdQ?=
 =?utf-8?B?bXVoTFBqN0JWWENCL1BHR05raTYycXlvRmhhb3dUNDZ5U29yeXNrQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3826ef02-5f32-40e6-6ddb-08df0c1c3cf1
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 13:39:13.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHKnKcszttkfdO3hu5/SpZlwY7DLCnY+xcKgGf5I7wLT9zWwY/hE5eRIA7n2Ogsl9sCKNYsIw5+QPgHX3GG0BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP265MB9421

On Fri Sep 4, 2026 at 3:34 PM BST, Aaron Tomlin wrote:
> On Thu, Sep 03, 2026 at 07:13:02PM +0000, sashiko-bot@kernel.org wrote:
>> commit 828a4fa4f29a0a3c5aba9065f4ba35eb845dddef
>> Author: Aaron Tomlin <atomlin@atomlin.com>
>>=20
>> module: Extend module_blacklist parameter to built-in modules
>>=20
>> This commit extends the module_blacklist command-line parameter to apply=
 to
>> built-in modules. It achieves this by creating a new .initcall.modnames
>> section to map initcalls to module names, intercepting blacklisted built=
in
>> initcalls during early boot.
>>=20
>> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/v=
mlinux.lds.h
>> > index b2988aa12f664..7490278b7a2df 100644
>> > --- a/include/asm-generic/vmlinux.lds.h
>> > +++ b/include/asm-generic/vmlinux.lds.h
>> > @@ -734,7 +734,8 @@
>> >  	EARLYCON_TABLE()						\
>> >  	LSM_TABLE()							\
>> >  	EARLY_LSM_TABLE()						\
>> > -	KUNIT_INIT_TABLE()
>> > +	KUNIT_INIT_TABLE()						\
>> > +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>>=20
>> [Severity: High]
>> Does this section declaration need an alignment constraint? Without a pr=
eceding
>> . =3D ALIGN(8); or similar, the __start_initcall_modnames label might ca=
pture
>> the unaligned location counter before padding is inserted by the linker.
>>=20
>> When iterating over this section during early boot in do_initcall_level(=
),
>> could the kernel read padding bytes as garbage pointers, breaking the
>> builtin module blacklist feature or causing an unaligned memory access p=
anic?
>
> Hi Petr,
>
> I forgot to restore ". =3D ALIGN(8)" in this iteration.
>
> The following ensures the location counter . within .init.data is aligned
> to an 8-byte boundary before __start_initcall_modnames =3D . is captured,
> preventing any linker padding from preceding the first element of the
> table.

Have you observed cases where this as an actual problem?

I suppose this could be fixed in the BOUNDED_SECTION_BY instead by doing

    . =3D ALIGN(ALIGNOF(NEXT_SECTION));

>
> Are you okay with the following?
>
>     --- a/include/asm-generic/vmlinux.lds.h
>     +++ b/include/asm-generic/vmlinux.lds.h
>     @@ -735,6 +735,7 @@
>          LSM_TABLE()                            \
>          EARLY_LSM_TABLE()                        \
>          KUNIT_INIT_TABLE()                        \
>     +    . =3D ALIGN(8);                            \
>          BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>
>      #define INIT_TEXT                            \
>
>
>> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
>> > index bc7027f8dbb2c..a96157598197f 100644
>> > --- a/rust/macros/module.rs
>> > +++ b/rust/macros/module.rs
>> [ ... ]
>> > @@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
>> >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>> >                  ::core::arch::global_asm!(#global_asm);
>> > =20
>> > +                #[cfg(not(MODULE))]
>> > +                #[used(compiler)]
>> > +                #[link_section =3D ".init.rodata"]
>> > +                static #ident_modname_str: [u8; #name_len] =3D *#name=
_cstr.to_bytes_with_nul();
>>=20
>> [Severity: Low]
>> Will this cause a compilation failure for built-in Rust modules?
>>=20
>> It attempts to initialize a fixed-size array by dereferencing a dynamica=
lly
>> sized slice returned by to_bytes_with_nul(). This could break the build =
when
>> CONFIG_MODULES=3Dn or when a Rust module is configured as built-in.
>
> Hi Gary,
>
> Calling .to_bytes_with_nul() on &CStr returns a slice reference (&[u8]), =
so
> dereferencing it yields an unsized slice ([u8]).
>
> To resolve this, we can follow the pattern already used in
> rust/macros/module.rs for emitting '.modinfo' entries construct a byte
> string literal at macro-expansion time using Literal::byte_string(). In
> Rust, a byte string literal (b"...\0") has type &'static [u8; N], which c=
an
> be cleanly dereferenced with '*' into a fixed-size array [u8; N].
>
> Would the following be appropriate?

Looks reasonable.

Best,
Gary

>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a96157598197..67e3df8d4389 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -493,7 +493,9 @@ pub(crate) fn module(info: ModuleInfo) -> Result<Toke=
nStream> {
>      );
>
>      let name_cstr =3D CString::new(name.value()).expect("name contains N=
UL-terminator");
> -    let name_len =3D name_cstr.to_bytes_with_nul().len();
> +    let name_bytes =3D name_cstr.to_bytes_with_nul();
> +    let name_len =3D name_bytes.len();
> +    let name_byte_literal =3D Literal::byte_string(name_bytes);
>
>      Ok(quote! {
>          /// The module name.
> @@ -596,7 +598,7 @@ pub extern "C" fn cleanup_module() {
>                  #[cfg(not(MODULE))]
>                  #[used(compiler)]
>                  #[link_section =3D ".init.rodata"]
> -                static #ident_modname_str: [u8; #name_len] =3D *#name_cs=
tr.to_bytes_with_nul();
> +                static #ident_modname_str: [u8; #name_len] =3D *#name_by=
te_literal;
>
>                  #[cfg(not(MODULE))]
>                  #[used(compiler)]
>
>
> Kind regards,


