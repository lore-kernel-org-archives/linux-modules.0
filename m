Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022123.outbound.protection.outlook.com [52.101.101.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1833EF647;
	Mon,  1 Jun 2026 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344942; cv=fail; b=d4vJJyhJP6Sq2WR0l+2iTUWfAjR17dIyIlevBimmzZSv7ptEx2i+tX4sBEGup4t3VUqygdsmQNaEJi+gB9c/ehr7jatf68kgu7Mw2egVhf5pUQwfG7dR74HFk9PjeQ/Io7tZ2h7aI/iKFEYsUmzooaI00xwj1o1E9vqf8uoEgHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344942; c=relaxed/simple;
	bh=BqIApI5MCzN9O7P4XCDypMiep+yxeNHMU1WOJxCBNrQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=UvaDFD3kAswZtyJuKtXX0625D/m4cAndIDa5NaE37AvITCIdFxsSgNXwDaiGFKnnKfNKw5oIyVQD1lNRzNGwq8zmGsNjLxJuKGufTDEPHunWD/JUpvbctoi+66Wbjczl21q0MhfUK4PWuPuwDh202AeaWl++Q4SSSdEYRiFVTow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LDBdRCZO; arc=fail smtp.client-ip=52.101.101.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LDBdRCZO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsC+FsQTR+lSFXboC0pyrYXMNVeFa/7ISFVEDsSYQQKOPuifIWrQvHt0c+Vufevw6tJFLmnX5CJyDt41xPMUuV3316TYyr82j3H/g/6Bwh+aFMAcXl4mEjo6WGgveEWB4TvwfK8jGxOZMrrL8YYgLMzyg4ntpCTMjvjtN0OTYRwyGwXmQmzJ6KkpNar53IRzbDxWGUcuRLG4vQ3qY8i9eAePE5iOmelG+B4mza/vwfnEa8TSc11q4G4VsImz8/rdC7PGtGDKnzHWWtxYkzkfs1yMpsG5JKiIRrMHz5RgwzBBD4XVVOo7XHLRxfmQxOv9uDJsUE1nv081BupELos+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgyMwZhkKrd9PltD6kMNzMh/aS2ArTq1pSuCXPEJVVw=;
 b=cHRktp4+FRIMPzGSXGmSdjGUygnqVWfzbI9/elU0Nji9HdtC2r4OJOVJws8yH46wkLtHIuSovTsCr7NI3Xru51hithoGgU8lBJyAwnUclXAcLJHwTvB3C4j8PdGtp0NmdK4IKnr5QB3mW/5+9R+J6pVqZseuRItHBoG+/9oYbuhXjmxWPI79JRm95ycVj/ZA1ps673hQNvdDjm53vMhW7Of30gRzDk8ILMvgsmST+OYZGgoMQXdioyW6zZ/grQmvfsSAfKFo5azTm9FKeqImAX4zjUh20RJg83y9Xi15+02CqjL6wkv7bN9FHyZvAiUjbAvnn5eHUQ0GMX6gcra3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgyMwZhkKrd9PltD6kMNzMh/aS2ArTq1pSuCXPEJVVw=;
 b=LDBdRCZOLktIW8VXI6gKIlKceeJ+hXAv+HPwkcH8BkY5M6xITHJRyrsT3uH+kRYD5HPCu6DuSMTgC/wsp+EWfVje96IxYc5cPaPcFRniFaxOy9ZX81cNkNPQEfEq3JtyBzOS9jo61kR+Ju4zBOEDPkpjyZWI5K8OdGxGJmv/vYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO5P265MB9339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:15:37 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 20:15:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 21:15:36 +0100
Message-Id: <DIXZLWVAVAND.3DTPV93OR4P6U@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from
 `value`
X-Mailer: aerc 0.21.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
In-Reply-To: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO5P265MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d282d9-105c-497c-84d5-08dec01a8b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	0ipaIt1Jpl7VWgO39ORBUDMdZNYSl+dy5m6gzxE5UnrpZGPYNlZD0+iwn4X29mhuXzzQxmz7viAkZ1KslLpwLyzRmktruoHPxeWenkwDwkPHfjzZnBtKxzUo0L6JRUwl6e9Egafm8wbrxk4e2YsGNBgIuyqtaaydN6MsGSxItRHUIhtySvRFoMN8RDWYKFUH1jdGR0tR3z2KVRwI7vKUbEukyY89lxCirrFvPCtAXfHIhwiJ66EFpVLik0oshu5TG5vSC/3InldKZOBlIZz0Vc6xt9ohYGhzbD5IWDLp8gh0jPL0PWJEgwfg3Y6B0Aap1SClniiSMo345G8XWItXIPkGo7yu460ZNocPKSXbkNw7PWtZ8JCz8qO6BTiOurHo/DP707Kesu10Ay7vDQkcKrRb+kxp59fw50Kdkbmzqce0hQ6X+ZgUJqSWhT5mmr/ZtI1FnBWw3eOVKPMAZPg+FB1ndhHZ+egENfrK5Krv74AIx7xikgEe4KF3LL2hP6XM1ltelbMUr3SUN3JilGX1qLdPvszw8FI2P3wpneNaIQD4he56OQXeus2hPaTSRfevjzeYVOGK70ktGgb/UjaIxyUPXHNe6jdpMYXmI2Qc1aJVk67TvA2Up6EgiusgEEN/C5EuaLh7b6ZwrFIog20z+I6TTSv9OPTw3W2+H5rVKuATMnl01tUgEa9NVGh6TXei
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENRSjFUR3lRQ1FFcTN2VkIvakU3N3RzRzhXb3d1L1ZOYWZhYlVtcHhuTExy?=
 =?utf-8?B?d1NTNzc3QVRyZ0lENGRzdWptOVBGblQ5bDRWVjF1SnhTaHZscjR5R1hwNjVj?=
 =?utf-8?B?TVZJVVNTcUhXRWJoZmtpS1JnOUw3dzA5TzBCZy9GbVNFSmtRV2hyTkI1Q1Nt?=
 =?utf-8?B?NmR2L3ZscTlDRmJXYjdDL2JQOUcrRHZHL2JwUUE4MkR0SktlU3lMd2h5RXV2?=
 =?utf-8?B?QmFGQ25xQ1hRUHY5RXZERFk4ekNHTUdqb3Q3R25XVVltY0l2M0phdEJMNHVT?=
 =?utf-8?B?MU1mU0RTWTU0UEhSTXhnd3VMeldJRTdlaEdsVlRXSWgvTW9HNWJxaHZQWFZw?=
 =?utf-8?B?UnpZbGtuckRtaVhwK09OZGlXVzVSMU5FOU5NQ1MvNmQ5SVBYa2pUTXhIM1Np?=
 =?utf-8?B?ZW84ekN2dkhmeTRTZzZJd0d1UmcrZHhhZDFpMTZDd0RYWFNiS05aMTFsTDJ6?=
 =?utf-8?B?d1VZWktZZllOZzY2SXZmUXB4UndIRjdNN01wU0h3TklSYmlDaW5VMVQ2ODN2?=
 =?utf-8?B?YlhPL3hxb01VTjRhekhQNlIvc2dHWVlwZ1lhV3NSSEVKS2NBVmlPbmdZcGxx?=
 =?utf-8?B?TUdZUkZkcTV6azRKdmdENS9yZjY0YzVpdUFtdmp4Yzh4eElmbUEzZWl4SEQ5?=
 =?utf-8?B?Qm15TFkyekdYZm9FQWlvSWlsb0ZIRVJJdXFlRUk5Z3ArK0N4a2lHQ2lrdURX?=
 =?utf-8?B?OGZEWUFnb3o1M0tmcDhMaFhsWnRzNTNEMVczb2o1dDhaWnZyb2tib1o1SlF2?=
 =?utf-8?B?NzRhT0w5a0FXL3ZuSk85SVpycUkxa0xjVWdzdHVSYURMYmZDZkQ3dXp5QnZJ?=
 =?utf-8?B?SHVQR1hhYk9mNHdCZHB3OU5Ncjd1VUZpOGE2Y0tTdGlmN0toUUtGbmVHU3BN?=
 =?utf-8?B?YkxKYU1jejNOYWZTTHpJYlBIVE92bFMvOUc3SWlSQkMvSWlQbStDemlRQUtF?=
 =?utf-8?B?cExxRDg3ZHZ1eFE5V2Q0LzNoeFF6V0M1WmZYeEJHK0FheVVtN3FpMy9sRll1?=
 =?utf-8?B?MnozQXExeTY5aU93ZktiN044Tmtob2poM3NvU1o1UmlKdll3a2pNYkpuSFhI?=
 =?utf-8?B?UjdHVWV3ZXpKUVdvNW5YZ3p1bmJiNkhCUVJpakhpbjA0L3VJbDdDUWlocS9V?=
 =?utf-8?B?VUxXU0hSZzZWcUNuSEZlc25VbXhFdWVTS0dzTE9oSzAvem9uam9oNVBZempy?=
 =?utf-8?B?VGxqV0pqanhSU2dlZnZDY0hKQ3RFSHlyS1IxQUsrd3FER2NDRzRaRGlSMXNs?=
 =?utf-8?B?RDAvRGROZWVyUE4veUhNa2tTZ09BZWpLSFp0eXBVUC82MWQ4VzRaRUdONFNi?=
 =?utf-8?B?ZlQxSi81dWdleUN6c2RpODlGWG5KVjBGSFd1NzFmT0RTM3h6QUEyNEF0bk9R?=
 =?utf-8?B?dXdtUk12VW1lR2JqY1FFYUU4dzQvT1FLT01RREtxbnBBY2hLanQxbXgrWmJx?=
 =?utf-8?B?ejNvSTBFRExZbzJWRlZmcTk2cVdOT2lwSnpzaXlSV0FsbXNNaFM4bEh6NXBW?=
 =?utf-8?B?bU5wRXhVendDRzlsRXltMnpVS0FpaTRjV2QyWklhcVJkV1JQK2RaeU9DNWpC?=
 =?utf-8?B?Y210Q3NSa2RqSlRVZStrZ3MrdGYwcENldHZjZlFycXJJek1EbkxWZk1WMXdS?=
 =?utf-8?B?ZFN6bjA4ZjVOeFloUHpJTmlScHJLVCtsVFZJcFNmZzZTYU5xQWh5c2V5TkI4?=
 =?utf-8?B?bVZlNzcrWUYrSEdYOGlkdW9ZcmlQR2Z2V0xja0t5UVJiUWNyRW5KTlBiVzB6?=
 =?utf-8?B?WVZUSHFKS3JjTWdyRWsycDI2S0laZ0NLTFhKVTJMQS9oVEFCbUtiVStxWits?=
 =?utf-8?B?ejk2RndKRGRwMUJaWW9FYTBEMGhXSm9QL1pkVkVlay9saFZsR2dtQnRiOWxo?=
 =?utf-8?B?WmM1STM5STIwQ0Y4a3V1SG85eU9EYzluTmoxTFkyVTJUWlZMQk1MQmEyUldF?=
 =?utf-8?B?NVRBd21OV3pHYWl3Q0wrNExwV1RyNWRDNmtjQTBKVUNIdFVtd29ocDBwU2dp?=
 =?utf-8?B?enZ2S3plSVV2Y3BqWUZoNGhZZnR5SUpJdFdyYkZ3Uy9NQXFQVFdTblA2MHVo?=
 =?utf-8?B?MlFZVzMxUVJRNTk0bE5obXVTYU9IZHVzNzFxNytWK2FmdmEzVlA5dkt4UE0v?=
 =?utf-8?B?dTZvbkJpd0YxRjdnOE5vT1gxQ3FQcHA2T3RHcWFUTEMxOU01R3hzY1JVMHRC?=
 =?utf-8?B?eHJianRIcEF0Szh3TU40Q2FzZTB5RXF3ZThod3hvcW92Yzh0TEZwSWVMRGgx?=
 =?utf-8?B?NGc2KzRBcTlaRlQ2Kzl5bit2MTFVQjl1d0pBT1UvQ1FQKzR6ZUc4S2NWL3Er?=
 =?utf-8?B?dzFhWGh0Tk0zdktIQVNzVVF5bEdvMkV0OWdtODJwWnVnVVdwZXZqUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d282d9-105c-497c-84d5-08dec01a8b3e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:15:37.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYTHN8+r6f7XjUoK316mz8rFYXVHN05EmeHuKFp1lOv8fST4aR8dJc/kACV8eVCV2BZBuoW8gwtOEdZJe62Vsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P265MB9339

On Mon Jun 1, 2026 at 11:17 AM BST, Andreas Hindborg wrote:
> For `Copy` parameter types it is more ergonomic to retrieve the
> parameter value by copy than through a shared reference. Change
> `ModuleParamAccess::value` to return `T` by copy when `T: Copy`,
> and rename the previous reference-returning accessor to
> `value_ref`. Update the in-tree caller in `rust_minimal`.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> This change was suggested during review of the rust null block series [1]=
.
>=20
> [1] https://lore.kernel.org/r/abfe2LbhLzXiGCkA@google.com
> ---
> Changes in v2:
> - Move `value` into existing impl block (Gary).
> - Add inline attributes (Sashiko).
> - Link to v1: https://msgid.link/20260529-modules-value-ref-v1-1-a0df7e9e=
6f2d@kernel.org
> ---
>  rust/kernel/module_param.rs  | 18 +++++++++++++++++-
>  samples/rust/rust_minimal.rs |  2 +-
>  2 files changed, 18 insertions(+), 2 deletions(-)

