Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43041274650;
	Wed, 29 Apr 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504914; cv=fail; b=JY/KShoKHlK8okF31BQgntCxfu8oDFr8aUkovSePLChur8XlY44KXcrI0er1KDstYrKYndPUh5i8TABY3XD3Vwow6QoxjBC4bWQbBcH0Hr8xmybO9CORq77LXEyPoRIgZchd6N1F2/Q2/ZAMeu0MFYiYKygFZ/YVv11z0LTeldQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504914; c=relaxed/simple;
	bh=99ICPqXq/R5Fi/m2yUf4KfnBn550XbNLHeO8G4TBhAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jxsSq8ccaYfIJt2N3Bs9+UkWgsjXpOVxdNRkzDPIRYgRyQAtVYtLir8dxUL6wytmPx+G3EAg+Qpm+EiZCT5dqaLe9o2vyYERxOaCNm7qid0ts0VQSGstHBeOwpQVX1hKHZNFNDrbJNiIimEbp96uGofnEXdeOb1OlVP0hIObfzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGkpjIrrKvQiHBHQRT4DwpQdi5Elrcs5TODawx6DdF8k9IM89NPzwFXResvV2P2nKnCS+pQo7dtbScV+QN+pPogLFWq4yib1CpclKZpaTKNk5iJ15hYvJHaN+gdlzriSiMWJ6MJgdMUK7qVvjY7tzcfP+sIraAbUok+ni7u1N7I/ylzvNRU7HeGbhjhPUgUMYeAiYa4RyRn0tT2DgW7CMDcdez53I4646kOTgnOna19cQws4RGy5FTyVBjljz2onBQ4/115Q1clY7Mkrd2UPJBeb0JkhzNuWraudPQ8c/GY+Oj/PkVG33tRpg7ZWJrTNHhV/iN0vGmaZ/62QXmPmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp6/Lpac2YSTjvfoiX8fJ7lZbLX3D7fI7C9nZUmdWno=;
 b=N9ZuYNgqXrIuOANyX+y7pufF0Lq6Eqpld1s4rhBwuSeu7P02Xumk+hmIiiG2VUhHhzekvavJmTSltzD+UhclAV9xDYULSEvzqeO3x8qHlGOYgTBDzQBRTbvs10fMZ7RAalzvnGM7K30LIhH4UszzlqUzqa0OsjbxI0GLCEPLvnpWdze65BWsCjyAdZykZf+VrF2yriHV1/EH4eGR6YyWjcaRS/Z4iGQGxKaOxbLYAAhPLddsrQLbGRY2DQfZahtzOxY5fGpAQI9vDt8ysIEfZ20HxbWLi4oURK+C6DitdC/POpcx6sgg5MjPTmXkLi8bEAI1KbB7gzlxC21SdrCuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB3218.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 23:21:49 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 23:21:48 +0000
Date: Wed, 29 Apr 2026 19:21:43 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer
 warning
Message-ID: <rwmbdsmmn2a4643xavesddv2mpkrb4oor3itfxdfjqpz4m3q7z@qzsrxf3t4dcw>
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="are6ys5jq5j2ls6o"
Content-Disposition: inline
In-Reply-To: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
X-ClientProxiedBy: BN0PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:408:143::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB3218:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ffb51c-3573-4d45-1fad-08dea64615a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b5czcS04kO/7Z6TaStADlqyxXVCfxsPny05hMw+CkxVnjf9cgArSXZxnFibo0N7OAdCIO5w0SgqGMKU52pAiCtk/JB/VVKYd52yC5NkwZWLmHUw1OTw/VvwC4pRKKHQyNAlE7x7l+qI6z3hb79D12OIrwKaOww7Ug32mm9ulvjhSlhxYKCiAnjvy8PqCHD73AtjsxgvFgWK/bHOqqMzdYY7/aFmKtqODonYPspGEJARPMBb8N96V4LY8R+ywgsfvLEchaMjX7+2o6yxnOB78EIoVo/0mjU6Yz2gckhsHsiNEsFEVFDfShLB+7QJ12FQfDIWR+YNScyF1J6dTr7knDuwIqmCCBWFpEkD1urQGIReW/ubFwM8JUoY8ZObbb9oFNse0W1FGDuzrZizr1+t9kL4Yn59EvBPbFgK+xmyXAD2I1zK7C8vGesr9xT+5ILfmVZeNKA/8kEJtMKLmypdbbeltM5UxqIc/jWPQAbqkC73KeamekoxyGledbOAiHVkKt2YhxUskN3oAnmOg/5PNugT88ugebiBa0GE9kgdyAOTlPBP64WRzxW6/vdWMVqkmS8vLMu7G3ePux1stc/eq8Jngv1HXUYMPSfLEXkR/+dzgFdD3ZPvLwySrZV9iPzuU+AS9cuoBGv7/bwf8PyjlL4jk9aKuUPfkDoIzWVzQ2qad1r6VL4uy9aQGdQ0DXjXkO4F/XfBPd5UNffsmySVYpTXcsAO1AqnR6UGjEVCLUCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzYwWXFHbzVqY0ljUTZnZndGeCtsTW1pVE1NdWRJUW9rWkhCeEt3RFV2a3Vn?=
 =?utf-8?B?RnNOZXJWZVZlUWVJWW9CRlhCMHBhd1M0ZHRZUkZHTWxSMmtzTVZCTjRlSzRv?=
 =?utf-8?B?TWM4SWhQNldmdHhGRjVwbzJ4VzRLTkpHQnlOVGZwd2RxcEZhRGRlSDBrc1Bi?=
 =?utf-8?B?cTBPeGIvemhnMm9ySkJRd1l6OUtHSEcyLzlqVU9GT0VzcDhFVzZHRUs2UDh5?=
 =?utf-8?B?SDB6K0VaM09TeW1vYlovQmh0UDNpVTZrRGpnT1d1Q2lSbTNwdXViTkNjSjhk?=
 =?utf-8?B?OVNhSU5WZ0lVcGdkbVRDR1FtWlhOZVBzMnBZNFF0a1Y1b1hUM1lQb0VEQXNE?=
 =?utf-8?B?a3k2NVRjemdBcmttQy9SQk9xRDh0emRONk5WUDdkS1BnL05iczFjL1g2Yi9E?=
 =?utf-8?B?MzRScnRURnNndkNXSEVWcVdydTBoNXYwdDFOSHpDNjVLUGtPSEV5TGJNSUt4?=
 =?utf-8?B?SUdUZTY3Zm1SQ3lzQWk1MkpsTlFhMEkrazlSQ1E3d0pQSlpNZTArSnhoTmlX?=
 =?utf-8?B?VkF0elJrV0Q1NnBoMld2WGRKQXAyOFY3amIwZUU2dE4rYU1uRldBckwwZGcy?=
 =?utf-8?B?UUQ0cDQxU09zK1R2VHdDbGpyeUdhdlJldFltUlRLeWxjTHdXb2NCTTNEUkdv?=
 =?utf-8?B?Q2FmZkRib3Jtbi9vQ3ZaRzNjMnNub0UwcURuc3dqVE9LeTloakhrYzk4MGNS?=
 =?utf-8?B?TGVwaW5IbnRKUlVjRVRENEI4Rk13UDlSU2h3NEdoRzRQL2hNdVNvYTZHeDZ5?=
 =?utf-8?B?bW1wLzJEaThlSUJBc2V5VjhJdm90Vlk1di9hT3NDdlVic0ZmZkF5ek1neFd2?=
 =?utf-8?B?NVYyaTR4WlVzTXh1WCtuU0pFQmNpZUl3VkV0SktwcVB2NlJpNU1VRHhlOWVi?=
 =?utf-8?B?bkkrdVJ3RW82ZDVFRUhBcnFUQ0wwL1JHdGVWemlpM1o5N0FXQXlMZG9RYjdt?=
 =?utf-8?B?Z05JZ2c1WXJFMnd6Z0tBeUZKRVIxWDNpbGIvekZGaFJ4eUJxZUFsTkVHd3hZ?=
 =?utf-8?B?dW8yS1BlUk9NdFhzZHdEc3YyOG0rZWRUcTdzcEZyNUFsMWp1SFE2bW9XdTAz?=
 =?utf-8?B?aWQ3NmhQOUtzMjd3VmpTNFZocFRJbzQ1azE0b0JOMlVYanVFbEFDeEV4MzBs?=
 =?utf-8?B?a1NzZGcxOHVXZ2JBU1pKUDJHU045aDU1UmxHZG43Wno4SUx6TVFOQ3d1SjFN?=
 =?utf-8?B?Wk44aVJpS3Q0RHRnRlQzWG0xSU03dnZPbDNaK0g5c1ZtaFJGdCtObWI0S0h2?=
 =?utf-8?B?ekZwUHRFbHRjQk9PUUl1S3FiTU5DMlF4YW93SEJpQ3dTNFNQc3U2R1lPanVz?=
 =?utf-8?B?S21mYjdsajgyK2l3S3FYZEU1SG5WWmZBcUZUVGQwcmtkS1FBMy8zQUFGOUhn?=
 =?utf-8?B?QmRNdDl6aUJ6SjJVWW9EOW01YmsremoxV3lJVW9UcnNFdUdFMithVG9LZnVn?=
 =?utf-8?B?czdJclFlZ2tzdGlUNm50SVBQZC9MVnVJcjE3M2h5dkppOWdNTlRLMkZGWUtT?=
 =?utf-8?B?TXQ5bmIzUXVWYlhNOVhMQ2xSVWRZVGVWekFjdnJvWnp0NUNnVVVNRVZzVkhL?=
 =?utf-8?B?U3VwWXkrSjhCWWE2S0REekl6M2l0L1p6MGZvRzJVWUs3djJKWHUrWDdDTU5j?=
 =?utf-8?B?RUF1ZDQ3SkhTVHp1alVvN29BcGdEL0NGRVpuSHJ1Q2Rxb2pOT01qSlhNWDJ6?=
 =?utf-8?B?b1ZWTWtMUy9lc25iOXFrRkIzWDE1RldsZ0IybW5UL1hMa2NYbTRodzl1amg4?=
 =?utf-8?B?VGsxVjNhVFZtaVZ2NTk0Q0ppMHpRZFE5cWE5K0dGS1pOQnVFeWlad2Z3YUE0?=
 =?utf-8?B?aTBnSGw2MEpFeGxUSHUvTkFsM2xzM1hsSk9FVlJGaGZWNlJ5U05jbEZtRDJZ?=
 =?utf-8?B?TC9pbFZhM1FUYVR0RHlwM20xNW1OY1NYS2VDd3M2UWhiU0VwbWRvelV5azlZ?=
 =?utf-8?B?M3BCZDdEcnpDZEV3VHZJM0xoeWtHdzZyTXUrK1paM3VBVk5LYnVkbll0c0xu?=
 =?utf-8?B?aXFaVXZtcUtWRWYvZWxUYTAvdXNLMStGSTVuTW1JZWtEdnZWM2p2TVNIbTNo?=
 =?utf-8?B?WmlEdWpDU2FFbXFueDcxbXRmaWltSnBzZzhJU0NCcDFxRDJJc3hVWktzcWNZ?=
 =?utf-8?B?TDdvcU80b0U3bE1HQ2JTZUtaSTZUZTQ2emtJRklWYlR6elpKd2tENW1iaW1q?=
 =?utf-8?B?eEdtTXQrc2lIWm1KZFV4aVJnZEtmSDN3Y2N4eUxrcHFYb3plS281Y2cwSVBj?=
 =?utf-8?B?SHgxVGdCcDVZZUlOd3YxNys0RWNrQWlRRWJUcFFkSHIrZnlncG5wSjVJMHBD?=
 =?utf-8?B?RFdaZWgrTkpLeGxqUmpad1RIckNXK3ptQXI3MHVPNEJ0czlReTJSUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ffb51c-3573-4d45-1fad-08dea64615a7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 23:21:48.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxYqmUrRX7mymHmsvmTf+LC3cCz46Nmf2fAaEzxLcRbadP1qXRc/iuSgUTJIt8ZyWlgQvds5yCGzX/Xp5CCQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3218

--are6ys5jq5j2ls6o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer
 warning
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 10:11:35AM +0200, Andreas Hindborg wrote:
> Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now th=
at
> the macro is available.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/module_param.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 6a8a7a875643..dd6d663a0a3c 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -62,8 +62,7 @@ pub trait ModuleParam: Sized + Copy {
>      // NOTE: If we start supporting arguments without values, val _is_ a=
llowed
>      // to be null here.
>      if val.is_null() {
> -        // TODO: Use pr_warn_once available.
> -        crate::pr_warn!("Null pointer passed to `module_param::set_param=
`");
> +        crate::pr_warn_once!("Null pointer passed to `module_param::set_=
param`");
>          return EINVAL.to_errno();
>      }
> =20
>=20
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260427-params-pr-once-481c03df3e2a
>=20
> Best regards,
> --=20
> Andreas Hindborg <a.hindborg@kernel.org>

LGTM.

The rust macro was available since v6.19-rc6-60-g46c40f938f5f.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--are6ys5jq5j2ls6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmnykn8ACgkQ4t6WWBnM
d9ZUfg/+LN20NX2Q+pUzv96UDHX8HxjQTHuRcbTqiVePZeq4H6DHVbO3AZT7KkV9
bLRT5A1udcX5XhdMiPdkEQtkc/3CsZc+hF0HsY3i0FSOStfUIzJxuoXRWpdQhf3H
3bIqV830dzQD3INc2ZIedzYgFLGVfXucK9o7dc1fOSvCL2QVfEYIkKcNwvxYdLJr
3c+dgYta5Uu6nlNahkpSTM7wLIpI7qoUfT79V15h64XDCVuAeXiH62Zh2W+5rNRp
mBlJNG1hbfSqrQYGG/IeJ2g7NMccN5Ahpo/2pKPeYrw9aUxEWWA3Rd8SUiXOOwSL
wGfQ2e48VmmspH9bctY68i9cVTzRPrb6ecoHw43wBklYfeashEIuNEHvinkzOEMD
Yymbkk/b9oXvtQziWL25T9wkViGpaPdz0RS++/Uy5srgFylu4zuNl4BO4nBQVcEo
S9ycdlCj8YEadk38T/3fycT8nY3lhpJOiAR2HnO65P4dSVVfRYwQOVvo6elmWbYM
lliKKzDk6jeGxuzrzK32uhUV2AxtKzOhl7k4E4agb823rvmaBiB/vwObtDNVUbF3
yn/aSJi2ijsMOZCG3kIUiIFO0rYKAE+WLG6O65viaqdYIzhcsbpnj2pwhAkTP0+P
YbvarxCAqbA1DQB55HSEBLP0D4sV3XdafNUB1zHpz78qpnwEdbM=
=PARI
-----END PGP SIGNATURE-----

--are6ys5jq5j2ls6o--
