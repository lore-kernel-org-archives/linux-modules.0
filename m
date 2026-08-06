Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020135.outbound.protection.outlook.com [52.101.196.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6C353A6B;
	Thu,  6 Aug 2026 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017261; cv=fail; b=EIeA6NpKZaElYQY48B2tweFMmpPCZ/9a1jnnoYvdiOeoYsHg+sP0bcVNlOsJ54LMivFIhnjo0lpOu9rhGCqLgAZ08L68uBzsnJqnJvwvwiC5ZPxrz07EoPUY2Y2BObQCF3uMfEXfa3sIlCtfPdR+KQEKDnB7Im+rY7Ui/gnervM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017261; c=relaxed/simple;
	bh=KM/kp7BdCxLLrTsq6A7jj1X6tc/RswTI7+Va9rfSTLw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kT6N/nDokAWbqKldPi28lIfHni6CM1+ms8OzUqkCHvMcGZd2A0sLEyq47QmR1OOBgVOZ8MKP0WtypoWpkP9OgtiQMKUfMxhCG9NPoKcE+/fHFwyvt2FkjEzVYe4NeCleS+lYvWNeZkQjVOHZRN5t4d3AN8MuauEVZOFqVM1x5ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=F8HknbVa; arc=fail smtp.client-ip=52.101.196.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="F8HknbVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWPK5w/wScvQspaoN+G6M5hW3E9y/EX9CPrB2KSvGiT3J4f1SDe7xrIWwCUVJMZyy0fcEHItWgOAlM4QMS/nJGvwRenibkm5k0AcDA1JkcvYt7EUAv0HaFdZVggogyv7flb1yGbhhyW5GM/sOpektevJvJps8pH8zMWMCtJp1JBWU5uYReWyIu0RpHqREAHBoKbN8FPwGgHl6TfcQZbl0zlQ3x/E33t5zyD/qihHHgnpOEd+jD4NPvnm3fSIKX3D3+UNTSnYZ0JpR6YZSklJ3ZF85DmsZg7Ld8Cxc5PytnUb3NLCtnTzXq+Yb/8bN4By0fBW8O9zFPpEdDxPYyPTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56ZQ+fQ8+4i64hUZaGHVTXnFrGTcwNnSaCF6CoNa0V0=;
 b=cbW60nTjViXIGKndQ1s7++Eb+EPUciic+gu9Q0WTsaobYS2TB++gWYDr0/d/nEbsAIq6sHUlFzq9x2vOYRrvjNBpu1fYFqIfh2JGRHbKES+P1+7IJEifOfWE1AbALqr7usJ8GH9pmls9VWho4q/3SaexskQBzlJMxaBDmvh0N6zvO4+18XQbCBpktBOqh74JV8bP+4uWOl+bPlVzh/C4gTOEcWfuLftiDvOudJYWTcqHXtwX4tSMVTN6nAlTlrDZKfdxlbkQkUEkHsKLDmHzPWNwnTiA5G8hAug2aPRl8TKKNsa4+vwFyirlyYTRwf5JW7CrmCphg2rLtvEPV8IFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56ZQ+fQ8+4i64hUZaGHVTXnFrGTcwNnSaCF6CoNa0V0=;
 b=F8HknbVajGC1JA42juD8fWYpPGOU66qAvtp2p/HVj8w3VTsWLLh0aJH7JOflpAEqXp9nUYWn2paau1464w3NEsLs0PdRYs82HTKTtFtzuPfvaO0x1fQtOWoHvJaJagSE1IaBuBIMX7a3F+XXgjf5Sg8mWUjVH2gt2oJBDQLiyKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB3018.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 11:54:16 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:54:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 12:54:15 +0100
Message-Id: <DKHUA0DRQXYP.1WH8F0FP7N39L@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] rust: macros: Allow omitting trailing commas in module!
From: "Gary Guo" <gary@garyguo.net>
To: "Ethan Plant" <plant.ethan@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>
X-Mailer: aerc 0.21.0
References: <20260806-module-optional-trailing-comma-v1-1-d04811335e59@gmail.com>
In-Reply-To: <20260806-module-optional-trailing-comma-v1-1-d04811335e59@gmail.com>
X-ClientProxiedBy: LO4P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::12) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB3018:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d1c3ef-ca3d-4cbc-c09b-08def3b1710b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|10070799003|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	tdRxF/1cnp7AoIkrZir6cFOpnt2sbN/PIyIKBmk7HbWYtYcxmR5KG9W99RqKY27fBOIUf4b3KPganPzsXBvy9c25CDjIzFtXzGcZ9Pi9sBSDDaSW5RFndpROoM+pPro3y3wprlzFsx90X4ntIuW0aRV19vp5wbYUwmkwg32UhDtfYFHAyS+PuPPvCq1Vjx4PCWM8oj4Ab1VfW4ACwm3NswU+uOBVHPk9U8GaWAML6HiwDhm0ghEC7B6y28ufB74NKq4VhXZg7AoL51dOioaBIcrDZx4czpIxmSbcANk63f1WRPYMIkd7UWxXob0U/q4LZArlYDup5/FXygxNZM8LCJijDCGu+p0yfrsCFd2D0Ynx8b5QQ7e0N4roVlWWI+09DNgAg6nD1sYELDrjcWQg9MyxKTz7YBc+r/Sip6m0lBk8NiAsIApqf8TCjkt9nhz+QtivCMnVLEFcxljHwwpzU5F6EdBxuvtESnmbJ8r9Jfnatk6pxtf6jafcg0NMtb5LbM/Ysa33lUwazaPS1Bu4AGHgdBL/FMmx3qvXTcKpNmR4xLgVvERGa+5mbGek/MhVtcnmybB5jXH0WjtkrkOF9gVMsYOsBluYG8R6yNkn9de8beQQy7KRHzYQWdftrz/OSKX+TDb8Jy4jpO7CzAG5Pe23a9dPzlgPp3cIG0cEP+c6fG9OHDLg9xwK7xvEtDqt3MLDuInGPts9J59cxwOnrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(10070799003)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEtsQ29LM2FoSmJXR1Avc0d0Rnl1SFkxQktjS29YbVpoV09vMW5aZEJhYXhL?=
 =?utf-8?B?SSt5K3lpU2prMVVuTXpsbHdJdmVxNE1iK2VsR0l6d1kzQUxUUi9mV3pYczB0?=
 =?utf-8?B?cmdaU3M4ekZmOTRUVTAwU0xkaEtoTUVqcVRUcXR0UTNIb2RzTEtGR3lwend2?=
 =?utf-8?B?Z1ZWU3I3d3pqRE52ZCtuSHd4aG5YeXR0ZG40K2hoMUNLTDZScmE0cjhvWEVa?=
 =?utf-8?B?WS9BRU1LUEs5S1REY0FnU0dqbXphR3krUFRaUTIvTFN3SVJUQnJPNThLTW5W?=
 =?utf-8?B?dVgyTlVxZEFlOWVUdzk2R3dvZXA0eit4dkxmODFycmpUT3ZBQzUyVXp3aUI2?=
 =?utf-8?B?Rm5EL0l6NTBQNTkycVJURjVUbmJZaXB0bUk5d1lUQ3hGbGFQd3MrSjk5V3Bh?=
 =?utf-8?B?b2xoSlF1SkpIU3h3a29EZjlxTm5Hdyt1UUp4WGU2ZWZWSUhiZDh4OW9NckRO?=
 =?utf-8?B?MGovOHV5a3F2ajZJUkdkUnYxYkFtUEZCbGZqT0xBTHdtME5NWllFNHArU0NJ?=
 =?utf-8?B?Z1lOV1FxQjFib2pMbjRzdW5VTXRFQTFJd3ZSQUl5Sk1HVEJWRW1jMm1hTk1F?=
 =?utf-8?B?VlJkdEdyODVvN0FMTUtDbDArY2xEd3U1UVI5dXk1RWF3SEd4d2ZUNWxDV250?=
 =?utf-8?B?Y2kvYlJNcDZkdHl6MHBmYVZMcENETnM3RUs0ZTYxMWR4S0FGODJNZ0VDTTZO?=
 =?utf-8?B?WWlXVUZORUdETWpueDdRNUlreVlBTWUzWlp4Y3IvVlo2MUd6ZkRLRG5GNzNw?=
 =?utf-8?B?d0tnVE9tL0lzTTRkeFJwQ3R5eFplMlVZUHFLMTUxcS9DQWx5dWxWeE9IejY5?=
 =?utf-8?B?SEdXV2VnMGVMamwxbVdxdXUxWmhFUkFuSXlKbi93cEdKcjRtaWtxNzJFdXdK?=
 =?utf-8?B?YTlnWUtQNGtObi90aFNBN1RzcE9TQ3cyTC9MRTVIRFowN2xxclM1Y1Q2MFNw?=
 =?utf-8?B?VFN6RDlaVDZ2S2ROakhySmJldUFLWnQyTU8xOHRrODRUOWRtOWQ0aUloMmU2?=
 =?utf-8?B?R3NjSk1KeXBkUVNjVnhaRkF3OTUvRHhsOHdjK1NEYVdqMnVYL2dVRHRuZ2lH?=
 =?utf-8?B?WCtTQUhsdi9pTENvUHljeFU3R3gvOWdGSkRkaFR2QjNsNFd6V3UydWxOZ0xl?=
 =?utf-8?B?K04wOXhCb0ljSHZDYVlneE9NUExsWDErWG45NytqTkQ3TEg0bE8vd2x5S29Z?=
 =?utf-8?B?SXVXdDVubjJWTUxwM3dhT2VnOEcyY2gvWCtlZnZheS9GcS9WK0U2OWRpQjJM?=
 =?utf-8?B?V011VTlsZHpvTnNNK3gzc0ZXdENVZVV0b3p3YzRLVStjcmRyczBQbENsSEJX?=
 =?utf-8?B?S2JpY25yUndVU0Z5NGtpZUpyU2toNGxOdW94NlhtdWF0THFaNnk0T2paK2N5?=
 =?utf-8?B?UmNYTzdtY2RUYjNYQTA3bkl6L2U0VGVVelJrcmNYUExnR1lTREh4ZFEvT1JK?=
 =?utf-8?B?UU1Gc3hNOXY0Tm1OY0ZWeHJDUGF0c3hUekN1eGZ3YnpvcHN4dXJsS1Yzd01Q?=
 =?utf-8?B?aThRRSs3bm9RbnQ4Vnd2K3FvZ0dFWnYrRkJpaWVHd29rTEh6VFlYTjI4WG5n?=
 =?utf-8?B?YngwVkF6dmxIdmRrblhQdEJpdG1uRFV0bGF6R0pvb0xORzB6S0w0RzhGLzdW?=
 =?utf-8?B?RzlxY3FQdTVkT2JrV2w5UUJnYnBIVGpFUFd4azdwcW9kd1RXMkdaOGVkU0Q3?=
 =?utf-8?B?TU5zbnBuRlJ1Z2FrcWFQUW1nZ1VYNUxNUWVDZFR0RjFsaTBQakNUQTR1Zm1y?=
 =?utf-8?B?d1Y1QXZpVWk0ankwc25sdVFBSHpYTUdXRHNSU1psTjBjb2RuNE5FaHpjNzcv?=
 =?utf-8?B?MUVhOVlKL05mT2xPdlJRS0JoNnJlZDhJSUtrWlBldlJHd29KOXFtT3ZZYTdj?=
 =?utf-8?B?TE9Wc3pEeUxKbWprSkwxQUtWNThmSktUcUVFRU5rZUgwZ09EZGc1VmNFOVU0?=
 =?utf-8?B?MWZsaXBuNnpCNEFTVHVpZGlqelRpSHY2Wm5rWm95R3JEMVRGY2pQaDZySEtr?=
 =?utf-8?B?ZmQvQVpxaSszNFg0ZHlxQ21RTmREOXoxa3VrejJlQVNPZjB6VGdzNmlVc0x0?=
 =?utf-8?B?a2F1WTNBVlp3c3VTd2VJVy8zQjRYSTVoUjZ0dUxrcDV6a0hnZ1dxVVZUOFJQ?=
 =?utf-8?B?Q0RIU3B5TXJHbGsyL0t6OUhsdzFQbWpTRUg3Uy90QXY4T0x1UUJBbnFpejhv?=
 =?utf-8?B?V0RwWFhFVzY2Ty9XTFpqVG8vNzJDY1I5b25raVNUaEgzTEVpTVNWVUN6Y0dV?=
 =?utf-8?B?RG40RXluT1hKWkw2SnR6OGUvQ1dsVStJY3Ryc3pPM3ZubDJXOHAvUzRDSlcx?=
 =?utf-8?B?N0xnMkhPWGFaQjU5NWNwSkZLd0NlYUxEZzZMMExXYXNIa0ttdmYwUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1c3ef-ca3d-4cbc-c09b-08def3b1710b
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:54:16.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21rA1EVwN48tyr+LSdHWJJ9OtpSbxmRdGa1y9hc0+ebOC9+cS4g75SBJopGPEz/Tjen7ahv9xmCNunWAtYnKGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3018

On Thu Aug 6, 2026 at 11:14 AM BST, Ethan Plant wrote:
> The module! macro currently requires a trailing comma after the final
> argument, despite using syntax modeled on Rust struct initializers,
> where trailing commas are optional.
>
> Allow parsing to finish after the final field when the input stream is
> empty. If more input remains, continue requiring a comma, so missing
> separators between fields are still rejected.
>
> Document that the final trailing comma is optional and update an existing
> module! doctest to exercise the syntax without one.

Hmm, I am not sure if we really want this.

`module!` invocation usually spans multiple lines so the formatting rules w=
ould
always prefer adding trailing comma for this case.

Allowing omitting sounds like encouraging bad practice.

Best,
Gary

>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1172
> Signed-off-by: Ethan Plant <plant.ethan@gmail.com>
> ---
>  rust/macros/lib.rs    | 4 +++-
>  rust/macros/module.rs | 7 ++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 4a48fabbc2682..f6474b194687f 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -61,6 +61,8 @@
>  ///
>  /// [`Module`]: ../kernel/trait.Module.html
>  ///
> +/// The trailing comma after the final field is optional.
> +///
>  /// # Examples
>  ///
>  /// ```ignore
> @@ -112,7 +114,7 @@
>  ///     authors: ["Rust for Linux Contributors"],
>  ///     description: "My device driver requires firmware",
>  ///     license: "GPL",
> -///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"]=
,
> +///     firmware: ["my_device_firmware1.bin", "my_device_firmware2.bin"]
>  /// }
>  ///
>  /// struct MyDeviceDriverModule;
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..57ee79b49a7ec 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -261,8 +261,13 @@ macro_rules! parse_ordered_fields {
>                  }
>              }
> =20
> -            $input.parse::<Token![,]>()?;
>              seen_keys.push(key);
> +
> +            if $input.is_empty() {
> +                break;
> +            }
> +
> +            $input.parse::<Token![,]>()?;
>          }
> =20
>          for key in REQUIRED_KEYS {
>
> ---
> base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
> change-id: 20260806-module-optional-trailing-comma-44a336ddf649
>
> Best regards,
> -- =20
> Ethan Plant <plant.ethan@gmail.com>


