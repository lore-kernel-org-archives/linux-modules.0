Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022118.outbound.protection.outlook.com [52.101.101.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A4466B09;
	Thu, 17 Sep 2026 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629664; cv=fail; b=kF6DUnrWIvTXwrTou3S9VSIzFhLHO0anRL7MgwD/H/h30X0lU4qfNGl5a510xTiGebxNMgDvDz9rYjAfNWerQbjsAKvbQ/bcgoNzrWEdQFMSoSsMueijVM9XTlrzcUrLbDC7TjWEdczCssvDp1fucEoHbYbwU8foSmrNDC9a3vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629664; c=relaxed/simple;
	bh=Nfd62zPMTgIm/eeaUTFBaOsrOih7zdXjal14KMJeKOw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=KGR/DTFe/SqJTrl3/Snd/B82SbM+B+R3vKzXwRYWuZMB1Fb8aZ2R2TO2tBJROyAScWRsfmWljHTv2n7q6WUt9C2kuUmCAfC89CnQ67miQl3kWiNG5PhH3uaZbTWV1JxC7XyEcSZiLwQ3Hd6YUAScTb+6m4BTRVWvXEBdgIHoQRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=v6Pi2MM0; arc=fail smtp.client-ip=52.101.101.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="v6Pi2MM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmzMZJ6hR8A9vgtz39E0P3vwTcCYTFj3aLCgd9139Sj9khb3UsIoby/G11uw5ti7SQKRkWWEsriJEF+5h3J8czjsi6ZKdPee2oef6MjOZcnpbxd8eScP3XwtEMN0JL9EfiWxPLNgjafard1GPYQqyi2qgMXiAEEBtQr+FdLjmKohIU+xJaUsxRIvOzoePBvtH/pzdhXykt2cGx7iaqoLuFkM6a4Blm33mTY6T7nVhpMxofnuS91QMCIiRCc9dcp7dhMgV/e+HaCwT/nkFdb3TdXtdEYqbmxhr8edEd8S3fhhnAVGyJRrYTQubGT4SB78ZLjoTyrwu0S2wAsUqiJFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpmm2dIRi+WsTTwuSzpkXgXDsAXWbDiF6ZzTZpIqbPM=;
 b=Pxsa2C4XYp+l8C3w/tZ64oB5C2LxH1c8tnfEZyU3zXPPUrf0/6m59aA8rlnwD/EwwSrxuxR8ZeCIC2XAeTL5uHWqQ/KHr4uxc22iP0lF8fMAUab25by5H8e7E+89cSvGaQWX0EUlp4cehIMmlfH8PA2cbTLbjCGXVsDNTKV44TQmq6v2L54u/GnaAe6LGfR4B7sjyReyVecc0Di+jqVJMq4dgog5cTqhG2//SBQ8zD1kjA3SCRwe5wweROtArOr8UiEoHPuJyWe9UjC3yJ8Yyl+8qSTfGiVego7/NGH6Pg3c66Jva/7HnDz3lJwulU2eYe+DLZMbl13O4DHzlvvwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpmm2dIRi+WsTTwuSzpkXgXDsAXWbDiF6ZzTZpIqbPM=;
 b=v6Pi2MM0Y4lOV3OkesUVP7ElrpGCwnzw9MNChGUiAwg8m+jfJ8k8GAuTeK8mqlgIp4+7GIBsDKvmVnUehZELovHdSyGYvYA0lMJKe7rSwUr9hP6hICw6QqkP00ccL4+qWuZdWySrtK6xmmj/9ZM1ilmcQDdu4KuVqbtFvqCqrvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB3117.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 07:20:59 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:20:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:20:57 +0100
Message-Id: <DLHERMQ9DOIC.1TRR4M82WNLIZ@garyguo.net>
To: =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260917051147.98775-1-tweek@google.com>
In-Reply-To: <20260917051147.98775-1-tweek@google.com>
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a974f2-1c52-42bf-fad5-08df148c38f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Uy9akqNlD06F7mxjJ00oOsxJXmRJ970E4UMBaikaVrb90wU0AVk79xIx3GZbhgWhK9l9mWiveO2bvO/ST0zWRtImbyQyWfFrvQyUBI5B1ySVz/2scwkREL7HdRNe5UBa5dCVlbx4psu6Dg357Q5JBWuLnGUk75eJPrBYGrlDqhRHPU2rJnmhIwT2kumk+jC1QjtUZ10Wb7kEHVHf+7hmZpNhTW5R/urk/mqbKozzHKsxifyIPx1G96/oVDUn2qFGf+oIu75ilIcMZZhq97qRIXC8Fxr5e7ShRXNXUA7PrxHtDOR0d1eDKvux7QAU7wPnT6wR8Q2HzAcWZzzmpDtblzJWSBxcOj5Aot6HSCEHKCAnRlfA8L58m0UfuAiUkjo0Md0fYNHKqy/WCZfTrmPXD+lJAXkb7TFnv1PP0UUEbfiMii5zoZKmUF0FstfpeQ70nT3sQIPxBPWjTHApX2UGDDlC62sPE8A2V5KBZn9IydQqIJB5wFVsRr0DsjPh3Qghp7DJXfMewwlyNh1uEZ6cbvD5XPwNDQTS+gMG3AyyHAtIv80zKDvJuT10jirL3ioxwU++cWoYAxcYoVy62BKNruOkIClt6hoz3+5Y+9u/mhJtkywG5CIPZCqLDglmzSiTiKfXkTw6pj5VAODFYztjR5UXSTHEMuLuPJITWQ1CeZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzFIbTQyMlV5dlFVR2kvdE1SWkVjYktMU0dIUXlSb2o3MU5sUnQzSXNMbWlv?=
 =?utf-8?B?VENnakpFa09hcHpBQ2NRNWpxSWZrTjhsMXJyMjFxNlpidVBzZHBTYmJzamc5?=
 =?utf-8?B?K2lRZTdOU2lHVnRZNkRPRkpMNTRkaldqdExQYm94QUNwd3JIS3k5WTdQUFQ1?=
 =?utf-8?B?dVVkdkIwbnBORUdCVXhJbUpyaXhhdmVTV3NHVE5qd0NRZm5QdkEvQlpuSkxJ?=
 =?utf-8?B?ajkzOElTVUpaU0gzS0piOUJ6N21yc3RaL2oxRWlxZmx2R2xXV09kTmQ5SGFM?=
 =?utf-8?B?Vk5EOHdCTTJGcHlxeDlEYW43QlgzNXZIdVZBQXJsSWdJeTkyOFAyQ2Z4eWZN?=
 =?utf-8?B?dnh0UTN5U21la2h5V2ptQTJSY29WU05ZQnBiZU5jNGVuSUlSbUp2OEdncGhI?=
 =?utf-8?B?Q1V1QUk3ZjNla0NwTSt1N0V3Nm42Z3lBWTVVN2xBSzcrWVQySkJ4STZBQjZu?=
 =?utf-8?B?c21ETE1HTDhVb2Zkbmx6ZG1YK256ZVJhZ0x1RzhhZk53WE10aGlNRWdvelh6?=
 =?utf-8?B?L1F5eU9ySFRsaUhpdytLT3FURHpiazdSWE1YNzFBZkVvOW5TK0hyRUhVK21K?=
 =?utf-8?B?VDhCN3EzQ0p5c293U3ZXR3FhRnBra05kdWk1ZmJXOURYQjhoczB0WGF2TjBm?=
 =?utf-8?B?Slo2b1RITHFVU2dnaVFXQmFxZWdHOU9TS2N4MmtiSFo5eWd3N0todFVzMlhp?=
 =?utf-8?B?dmF2Umd1RUYrT25ER29XZHJjTm1JWGw3eXRXTG03ckFjYjNkVXREODBLK0E0?=
 =?utf-8?B?ZktYZFd6Z3UwSTFsdzdWdy9vZWgxUWxoWCtTTGtUQUgzeCt1RzQ1NG44TjRy?=
 =?utf-8?B?Q0hoSHYrckFkZU1nd1FpOUIyQzZmK3JwQkhia2tLanJTVGtFZktrUWxSK1F2?=
 =?utf-8?B?bFd2b0xwRXM2SVd5UFd2dXB5bStTVDJpMmpvNUFsTHlKVnpwZUNleFBoVkFZ?=
 =?utf-8?B?VEpkNUpjeWJteXZJa3pOanFOQXA3SnhKZndjRWV3YmVQSHJabnFHaitnS0FY?=
 =?utf-8?B?eVlwb0d5dnczSE9MQ2VWZi9LTTc4bVRkL25uVHJ4eEkySWNDQlViQkJZaDVC?=
 =?utf-8?B?SGZWQUJGdlJZVkU5WEVJVWNNQkl1Qis4clpQUWJTbHlndXFULzU0TVNsQzli?=
 =?utf-8?B?c0xtUEkzZHRhWnFOS093UzdhZERtWXF3TlZxbWtMalZLbkg2NWdUQkpuSFZS?=
 =?utf-8?B?b0ltMVdtMWN0SlRpc2ppMVdlL1lvcGJGSk45NG1UR3RIWVVUU3dBd1BuYW1r?=
 =?utf-8?B?U3EySTBPWXREZEcxa1FUbEZkNkRtL1dHenBWc3hBTHo1QXMxRURyV2RpUXht?=
 =?utf-8?B?b2phNy9GeWFZcjk2cHJkcjVNcVFCem9jbk1KdDVBODlrRnBHbVdCdldON1ow?=
 =?utf-8?B?ZnpmRUhQVTdQdlcySEtzRDhtc3U1ZTR3L0VzNFFGVUxaVnRmQWNIOGM3M2t2?=
 =?utf-8?B?YVN4TkM4WjVseXBKQ1lZcDd0cEQ3bWNLTlJPVmJ6MkI1NlZoOEs4Q3poYUdL?=
 =?utf-8?B?NHljVDVKNURwNEZrRnNuSWRWSWRPNEwvRmR6S1VSYlVrSXRDVWkxZUttdkNj?=
 =?utf-8?B?YmVZbDRJVEJ2SitvczI4Vjg5VUEwR3hPOHpmeXNwYnQ5UlZHWnA0Qkp3WlBu?=
 =?utf-8?B?bGQ2UW52NjI4S2NyYmtka29RdHNNZko3cWFHaGJ3SHpscGRxUDVPUEdxNnRQ?=
 =?utf-8?B?aHBsWUs4WjI3WG5xNmpxNi9QVHNCUGNVV2xCbzlnQTBFYUpEZDBkbHM2M0Zr?=
 =?utf-8?B?RlFEZ2ZwSmdDYUdGS1ZtbXVvaFRhT0hEYzlTRkd6R0UwVnAwVGxUUXlQbEtQ?=
 =?utf-8?B?UTVkL2NQWExtMGdIMnROR1pGTkgxWStaS2Y2b1p6aUlnTzFjcURwL0hsOHlm?=
 =?utf-8?B?bUV2UjVDZXBNdzBITk1nM1hnYlN4SGVzbFdnd0ZzRlQ5SXhvcVNNanIzL21w?=
 =?utf-8?B?endIMXBJWXoveGFOOFhVVVJjRFVPMjZmazFHYTlVSGF0WmVORlMxbC9aeWFW?=
 =?utf-8?B?YXVReGxjemNsWldFTk82RHFrajRRRFpRKzNCRTIvQmMyYnJKSjdzbUVTdEhV?=
 =?utf-8?B?Vm05VC9aR2VEaVlQbDZHNjJ4N3lsaDgyZ0VYQ3I1cVc1bXgxcVlHQXR0bHdx?=
 =?utf-8?B?ajE4anlJNlRiNDR1TUxZZE1FbEVoTStHL3MzdjZKMjdMd2NXVFZ5ZG4wdmhu?=
 =?utf-8?B?MFZSVEtOQ1lzU2pVU0JvTytmTWl6cXNNYjhmN2RmTXowU2hBNUh3Zi9TdHRQ?=
 =?utf-8?B?SFZUTGthUmlldjhnQVU3TFowVEZiQzFjUHp5bEszRzZIWWR3Sit3aHRGMUpt?=
 =?utf-8?Q?MqkYqbI5RO3KPK+qa8?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a974f2-1c52-42bf-fad5-08df148c38f9
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:20:59.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tQRN2aiweKL1XDU1aeJb6JloHvPpn/cRRHlRkSL1PGeWn8azUihxc2gU81NCu+cS8uCk4iRd8oP7qRcGI3C2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3117

On Thu Sep 17, 2026 at 6:11 AM BST, =3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Wekst=
een?=3D wrote:
> Module authors may have non-ASCII characters in their names. In C,
> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
> modules use non-ASCII author names.
>
> Originally, the single `author` field permitted arbitrary string literals
> including non-ASCII characters. When support for multiple authors was
> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
> key"), it reused the `expect_string_array` helper that had originally bee=
n
> added for module aliases. Because that helper enforced an ASCII check,
> `authors` inadvertently became restricted to ASCII-only string literals.
> Later, when the macro parsing was rewritten to use `syn` in commit
> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
> restriction was carried over by using AsciiLitStr in `authors` type.
>
> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
> to `LitStr` so that UTF-8 author names are permitted.
>
> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Off topic, but I have a question for modules maintainers...

Does the `authors` field still serve this purpose today?

Almost always it is just the initial submitter, while the code has been sub=
ject
to many changes (many of them tree wide too), and the maintainers could hav=
e
changed as well.

We have copyright comments on top of files, and git for checking the file
history. What's the point of keeping his inside module metadata?

Best,
Gary

> ---
>  rust/macros/lib.rs    | 2 +-
>  rust/macros/module.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 24f96feaeb34..ea2e232b61b1 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -129,7 +129,7 @@
>  /// # Supported argument types
>  ///   - `type`: type which implements the [`Module`] trait (required).
>  ///   - `name`: ASCII string literal of the name of the kernel module (r=
equired).
> -///   - `authors`: array of ASCII string literals of the authors of the =
kernel module.
> +///   - `authors`: array of string literals of the authors of the kernel=
 module.
>  ///   - `description`: string literal of the description of the kernel m=
odule.
>  ///   - `license`: ASCII string literal of the license of the kernel mod=
ule (required).
>  ///   - `alias`: array of ASCII string literals of the alias names of th=
e kernel module.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index bc7027f8dbb2..0a7b9e24c960 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -369,7 +369,7 @@ pub(crate) struct ModuleInfo {
>      type_: Type,
>      license: AsciiLitStr,
>      name: AsciiLitStr,
> -    authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
> +    authors: Option<Punctuated<LitStr, Token![,]>>,
>      description: Option<LitStr>,
>      alias: Option<Punctuated<AsciiLitStr, Token![,]>>,
>      firmware: Option<Punctuated<AsciiLitStr, Token![,]>>,
