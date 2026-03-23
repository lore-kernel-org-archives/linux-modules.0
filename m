Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020128.outbound.protection.outlook.com [52.101.196.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916F3A961E;
	Mon, 23 Mar 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270367; cv=fail; b=E4AzmVihfv2qAal7vDdwpoEplujWq1fVJj2BJ80at9pilZKLHhgOTRg/sioyqd/kEpJJIKRm1+dMkk7grffUAnLsZ8o6Hz7Wh5f/OVPOFsrYqmNEQThIJdr6HxHyfqqZkPRjelVjDN+v1twW36IiNDNHyPE3B3oLCtCbVc4K2j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270367; c=relaxed/simple;
	bh=fW16JjoP7MuVqwwPO26CyCEh52ly9xAbV6v9haNp4Xs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Cel5P1j8xE7tVW28NK9QToS9jMf/YxYTSaIQ6oK63E0NOOlfCrDPZb7jZVubJP7im2pNr/i0k5xjalij8BlafQPsqjhQ0/tbgvpV1q58BFSeM/ee1whY/zQV5FBtY+gtQpkxx0QMBaSyfoJAZsgLOEY1UhIas9rTRfmypNNNxyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Qc9UCqCm; arc=fail smtp.client-ip=52.101.196.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Qc9UCqCm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAGLmie8n5MdwUYdGSwn83H+Pwco9TU/mA9NitT53okcW+UbgivXbrxWC0d9Hz3oen75lh3MSVTBF3R/+kiHzAAhEVmgAIsVbB6xWFJNHeb0WMyto19bConDMHdiF/ZwwLSesud+7I5ijl4TpQCzygzSIbZKYOIee9eBtWzJSJJ1bUM1C1tm5MSqQ3/sr94MkaJFvL1YP1R4ZfEnlZJzHCfvDUHRj+N+f5nCc1pZ5vVfUi5TR8WJHaYx+kYH60nNLB9Fr/ueubPzQWUr5VdQj5Yh6lPZo547eJQbkaZ4DYcLOAa5fVPZBIwzA+Q595+HeTwCkti/+YuZ1Oh+EVW7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfda9k7l5uLA2eUiNSp0X/6VCU8jG7NPR2Ea3qxsbOo=;
 b=G1GtO9Hoep0n3hJol6LMLFX4gRPi1brKqOr41qa4glDVoR4DFGt6tsGdDUGXrcHyfMW3w+KZOwMM3L2UzMDKiR5iiqIEodcBFJxzl7I55zr2zpQ8jmRFS9o5TfvgV25MTID4JckYsALOW9cRgheHL6tvNXv/WADctp1MUR0KEW96RZzZrn850tjDJnV2lhHaEHmALjyB8NjIRD3PX7hdy4Xy8rQGhJmXsyjjVHjqtUmtT66Jl3bIFMCtwRNvF6QMq4z8SCS49h78t+z6e8ajsMBaUQctqm8Gw+za4t65Pi+AENHJ3JOqS1eD+su2ZUwj5pGQe5BPBwa1wEaBSaOYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfda9k7l5uLA2eUiNSp0X/6VCU8jG7NPR2Ea3qxsbOo=;
 b=Qc9UCqCmuFJAgIM4HkNPFgZfPB8HqlrZYO2QJTJwrR72GUHSdTJJqewnV/WhGbyDkxtpF2G0/CmOCRqCXNJLVIT+Ivy/npKvrhuPJ8M8Kb7AameKQwlgqkx3BJE1Tv3t9tXnSuQRpZFBclgN2ML07ieTbvoaQhWKoKZsTB8GAes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6235.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 12:52:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:52:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 12:52:42 +0000
Message-Id: <DHA6CNZ4W0DH.388Y1VMS61C7T@garyguo.net>
Cc: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module_param: return copy from value() for Copy
 types
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260323-module-value-ref-v1-1-32507e1085f1@kernel.org>
In-Reply-To: <20260323-module-value-ref-v1-1-32507e1085f1@kernel.org>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b69bd10-d1fe-47db-eaa7-08de88db12b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KpjGLxjqneP0oneEsuuXMmAHLrpl14QZT09kKm43a3TOp9NnIPFdVwtDA37F0hbsqhBG502XQ+O58eFYS7pAmtwqYwKvWz2tPlpwILRnI4XeLU7qRiRKMsECfMaOPCBrOJ61xc0gRkohUE/a2IzxCMnS7G/waoPjIS8x5NgAVhVtbDSsDRfUrqcdlrbyaY8Bru1PGcmyPsUkNfJCet3f8b/vs4f3ScJMs4vKnq3989ssg/iUTaQKisDRNe00wNo3l4I/uGmrW3iu/WjcbQsAGS+J5fqw+QbQMlYbLn2tv2E7krlYccRoOeApyhsK706PoDF8oWW84oa3ANeGiTnePeYN5e8mFaJZGSMUXsWjpnGii1XX9am7Esed0QSX3gMyjS32aAZSL2envkolICQXZWva7tcrkN0aet4VZ4gUxQpOIff+d9TvsSmIfb42JzifQBOgLi9x7IBo73pxmSHifMmokPU3TlyLAKE7aetJV6yTkFyxKlqMuUhYdA+rb2//JZxSDcy3rHpAzgpNBAE5yS8w+m7W3itxH60coFv7A/qJmm4tD0DcwrSxtq8vbFWBvZgWq+ODN6xLpLXkEngawZYztr2AW7JhU3l1dmVuVYh5AL+UY4o9ab+a9i0BVbFoiWKrpzOWdM6aB5NZokUg6ICpJSiueRI5vn4Uf8yQF+4neTNC/2UyWpekFluB+KIWLOpkvfc7vmZPymBRlLUgq90BLD/I62u56ZgSZhv0ySUbl8W4aGUnXcfGcXICAiOMlfiyMwL+bT3fUf48kvEqYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hpQmJ4S3QwZUp4RXNqYkV6WmRQaTdIdDRYVGx2ZjF0cHVpdlgyOXFoQ1k0?=
 =?utf-8?B?OUgvazhkNzFCbS8vSlRnNm9DSWxwQXJLSUhpV1RoYi9qUFhFNUg0SldURTJh?=
 =?utf-8?B?WEFwMEtaYmdCbjlLL2swRjAzTTdJc0lqWUV3VGRtbkpDNFpMRE9DZ0hEdlFR?=
 =?utf-8?B?NXc5N0Q0ZFQ2elpSQmt3dkNRZlpIb2xFaCtxblJ5WE93ayt0RHV5ck9QTWVo?=
 =?utf-8?B?RUhoVldhM1VBdHVnZS9KRk1HYU1IKzZwWktYVkxaR1hSejNucHkrRUllUUoz?=
 =?utf-8?B?dXRmNGVTYUd0OWs4ZjRNKzJmTy9PWjV0cTExOXNaNnJadmV5TXlFZ2gzQXMy?=
 =?utf-8?B?NlpQTFJvOExWaUNlV1M4ZUVmYU5yN21GNjAzeW5WbzdHTG42dDZNb2x5VDNO?=
 =?utf-8?B?Z2FWc08rY1RVZnVXZ1NMVDdvSFZnZHFTVTVDY2U2STV1aEpIbWI5c2wrdlYw?=
 =?utf-8?B?UEFtSWFhd2h2SzVpQ2JXUWpNRjRtY2RRa2UzNVdzdXMyRUpWRnBpcUFvSGJh?=
 =?utf-8?B?enBzd1BFdXpyRlNRaS8wWGlQYk5naDByaE5ybHVqeVZKTWlYUU54R2FySTRD?=
 =?utf-8?B?OUQ4RTRtTUVNeVZkVXZZQ1RhSUpFU3JybTdYYzVlbXcvWGhoa1JHbDNGVERz?=
 =?utf-8?B?TVp0eGxwZ2o5WmtnZENHMm9PR0htNEgzSkNPRVcrYitiQVNxR2p5eWdVdDJB?=
 =?utf-8?B?RVkxYWliWFhxVTNzVlA0WVoxdVNPbURiRUE4YzlKTWl5b2xTdlZYbHd4bWtX?=
 =?utf-8?B?RjNab3Q3anBNUldMcjM1TE56cEM0Ri9KZTB2ZDliVU5EVkNXdkJ1SG9MS3kw?=
 =?utf-8?B?Yi94ZE9sQVQ0TElmK05ucXZsZUpSZThPdEhGak5CUTd5U0JnMXQ5SDBBNXFh?=
 =?utf-8?B?elJpWVlmaG5nOUhXc2pKZFZDaVhGRDA1VmpCRFN2RU1XMGJ2emJBMDZvVWZT?=
 =?utf-8?B?b3JrYSszVXZwOG1mVUIwUkpqa3JSLzZKaVFMZGd6Zk00VWd2UERkRHp6WEJq?=
 =?utf-8?B?aExOWS9nUHZ6UUNodysvUG91TDJZc3hPbksxNG5uR00zek9DMERnSVlnaFE1?=
 =?utf-8?B?L3lvZS92aXU5OXQ1ZGZ5ME9oQmQ4czFYNzZaMGRkN3JmWVRJVkRua1AxOFli?=
 =?utf-8?B?eU9BSVAxelJleUhSYnYwVkUzbmJhdmZYS3RwcER6TExFSjJ3ZjVyK2diRm1m?=
 =?utf-8?B?UlNDZThNWWJZbVJVRW11WHBqWGw4YTlJYTFpREZtSzFhTWlmRnBjMXRNSWR0?=
 =?utf-8?B?aDI2dVNrRmRqeUIzaitZRTBMT2NLOE9IRTV0SFJQOEo2WU95TURIT1kvRjMz?=
 =?utf-8?B?MHFqQjd3bzAwek5tQnhzUzFwei9Ba0RUN29aVmFPWkhYTTNVTUxWc3VPbjdl?=
 =?utf-8?B?RnNUc3c5a0orQzlabW5yZklCR0xxYURiS3BTclVLdmFBdThPai9KUjdMM1NX?=
 =?utf-8?B?K2VxbU45bk1ubWdIekhzY203azQyVEhaN2JlcXNVaVQ1bDBiMEpSRXE2WlFJ?=
 =?utf-8?B?blEwd2Y5U2thZlZZYnh0cFBKQ3Bad2ZSSjBjM1VWTjNQSjBIL1BHRW9HNDlu?=
 =?utf-8?B?Vkl3WElhVTZ1bHN0S0x5L0tETXk1L1F2RGQwbWhEN1F6cHFZOVo1U3VKQ1BI?=
 =?utf-8?B?RmJ4aG04aEVQYUVwSTQvN0o0bUM1OUl3UXZPQ3pPZXpEVU5PV0VnOUdNNjJw?=
 =?utf-8?B?bEp3MkM1d1ZJZjQvSXZ0c1dTbE9BMG9WOC9HYUZRclgvOFJlS3FhWi9NR2Jq?=
 =?utf-8?B?NnZ4ZjYzVnk3YUlPRTdiTkZQSDdhS094VmFJSGo0UEs1YUxNZTdPdGI4Q1JO?=
 =?utf-8?B?dUtQNThQa1RRaW5YTVJsVmt6RjlFMjhocmxVOFppc0Z1UTJxZTgzcytHTzlu?=
 =?utf-8?B?c2NXbXF3a1FSZklRenhwaTZxWWFWMEtZZGFSRnBKRVlCV3ZvTGJkdW0vQk5L?=
 =?utf-8?B?bmVpdURxdlNoQk1Hc3lqUC9ybm1mckYvU2lzd0xzUGxKbHdiWGlvWGMxY2x2?=
 =?utf-8?B?OTFtMGsydkRidUdvOC9FSWhkRHAwUHZWMnhEdEZ2SFcrMXltRUt1WW5wOVlu?=
 =?utf-8?B?WGdvWmNuSnpmTENBcXV4YVVjQzRDZ0paZUtyTmE0czRFam0wdWZHMnFBNXVP?=
 =?utf-8?B?bktyTGxGK29vN1NhdDFONGUyZk40c2QyRWIvY2cyM21BWHJCM0hTTWViWWZO?=
 =?utf-8?B?cFk2Qmdycnp4QzJxNCtHOExPVEtpZG0xMHVMdVJBdXgxSUdGVjZ5ODNsaW5q?=
 =?utf-8?B?U3M1TUFXM2NadjR0ZjRrcjBubVRUb2ZlbS85UlNodHFPenpTeWVpUWpDS2xh?=
 =?utf-8?B?S1dDUFVYVzVhYjFhTFRGbEtyTUd5N1V0NURISlNmMDB2YkpDR2JPQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b69bd10-d1fe-47db-eaa7-08de88db12b8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:52:42.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni0y3v2se6P5aYYwZr9vJoH8TToEK1PkFOc5wavhegXvILTcL94NRwoeYlBx2hjZDNGic//0grTRge9eY5401g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6235

On Mon Mar 23, 2026 at 12:47 PM GMT, Andreas Hindborg wrote:
> Rename the existing `value()` method to `value_ref()` which returns a
> shared reference to the parameter value, and add a new `value()`
> method on `ModuleParamAccess<T>` where `T: Copy` that returns the
> value by copy.
>
> This provides a more ergonomic API for the common case where the
> parameter type implements `Copy`, avoiding the need to explicitly
> dereference the return value at call sites.
>
> Currently `value_ref()` has no in-tree callers, but it will be needed
> when support for non-`Copy` parameter types such as arrays and
> strings is added.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> This change was suggested at [1].
>
> Link: https://lore.kernel.org/r/87cy13swpw.fsf@t14s.mail-host-address-is-=
not-set [1]
> ---
>  rust/kernel/module_param.rs  | 11 ++++++++++-
>  samples/rust/rust_minimal.rs |  2 +-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 6a8a7a875643..5dcfe2ba87a1 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -134,7 +134,7 @@ pub const fn new(default: T) -> Self {
>      /// Get a shared reference to the parameter value.
>      // Note: When sysfs access to parameters are enabled, we have to pas=
s in a
>      // held lock guard here.
> -    pub fn value(&self) -> &T {
> +    pub fn value_ref(&self) -> &T {
>          self.value.as_ref().unwrap_or(&self.default)
>      }
> =20
> @@ -146,6 +146,15 @@ pub const fn as_void_ptr(&self) -> *mut c_void {
>      }
>  }
> =20
> +impl<T: Copy> ModuleParamAccess<T> {
> +    /// Get a copy of the parameter value.
> +    // Note: When sysfs access to parameters are enabled, we have to pas=
s in a
> +    // held lock guard here.
> +    pub fn value(&self) -> T {

It's better to keep this close to `value_ref` in the same impl block. The `=
T:
Copy` bound doesn't need to be on the impl block, it can be on the item its=
elf
with

    pub fn value(&self) -> T where T: Copy

Best,
Gary

> +        self.value.copy().unwrap_or(self.default)
> +    }
> +}
> +
>  #[doc(hidden)]
>  /// Generate a static [`kernel_param_ops`](srctree/include/linux/modulep=
aram.h) struct.
>  ///
> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index 8eb9583571d7..60d03df6cd80 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -28,7 +28,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
>          pr_info!(
>              "test_parameter: {}\n",
> -            *module_parameters::test_parameter.value()
> +            module_parameters::test_parameter.value()
>          );
> =20
>          let mut numbers =3D KVec::new();
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260323-module-value-ref-5884b5ae6b2a
>
> Best regards,

