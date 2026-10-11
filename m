Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F3374E42;
	Sun, 11 Oct 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723713; cv=fail; b=SBxSU7NPuWvO6HOn9QIj6J4e6RjsZNC1C45SPcaT0Udj/lPRvszQV/Zf70exxVFvRD+3P2m4A2Vw31Sa1V6S1IkBnb/uzkJM6k5/aimZA/KdQx9FDhbLaGW51S/ArZMWgYnp3tXGPV0VO6dmU+Qw9M9E3FrM+SeSeEl/vXjJnFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723713; c=relaxed/simple;
	bh=qi107rWYQgJ4NL8bWqNBYpVxaSCFqMnv2nYO6WGyujA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=hy+W5vfspCcz5Q6KtIEe85xBO21Mk3Y7/mZCMZJ7vXCHtM+Isa5N3yZ532q+BxnQdaO+avneZjkc3/fCi08R47tecWuc1MGABX5XBNrS9jb9WrCVHf8NFSk/dNgOZKX835hkyg61wxWqXoBlL9zmyhAWcVtJRqQ/8JGjF/jPkuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nO4y+duW; arc=fail smtp.client-ip=52.101.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nO4y+duW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCXt5PNekrUg4uF9opUdQkzpV31wJTQDFPl2JBWmPwfXla8Wc6zZLn0F3JoS9io+X2xSi23B0rpmDMaBAZqy6+1fgcCijDU3VDcnJkrk3BXFbuRxrLjXXsQAO7W5SZkICa2plJysMbsNEhB609EvgAsX3k7xjqY82mvavACbStuZeTO7sEVy7MzCkyh/rBW4MmFpOnVAifTyohmSbB1a0YKym+16yWyMtPhNFuKPCl0yI4t11R6O7MhlIOljD2zF69C9nFXIWKhc6wehH0Ktukv/LEx8/NT573TMrFTOhx3p7DzQiXogi2eobyiiQkfiipIhI7EUewEG7TAGjdGUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/08mz5yAdGBi7aDlg4ANYjrgTbuo0ff5K2fUpHffURI=;
 b=LqZY2B0THOZ85Xzl5dQ0bVpCLEsPlaGQJD+IwTM1H/Fy1mTeCgy6mTtbi6YLvyEq6wQ7eL4ZDG+YHL0s7Dwj0a/fJ7tCSFSQj05pOxJQGtSPckK509cjQHOjtd1O3gri7YfhIWGdzNF2Sfx+sIgKYLPfmkAimePVmVt7B9D/pldClKvWTPVuw8Rov8vpCa/Bt0GKkxPe3iEqIOek7gtG437o8IPzbkfbE5+V6JokFa/MVQVB3grRWz+tTivsftaqH6OPRSRdxnWIklloYAkl/58xljJWGriZxuCCzQSUhL0Xs6jL34xl7r3mKH+j1qeFOpP8HIdJYGohI+t93OwH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/08mz5yAdGBi7aDlg4ANYjrgTbuo0ff5K2fUpHffURI=;
 b=nO4y+duWJoOorcdv3QaBkfjiwfpq0zCa3XdkegGZ0VEWF0DrosOT8fkDOnE0xW5lX+cZs3Y7x8FLmp4cRvsiWLvlls3/CbhlQ3BlGM14vwpGgieL67MKB+u7h2SrpkqUKCfejcH/JXbfCFJP/Z7S4Ym7EA6MxMBZaMcU4vNIaoQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7621.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 13:01:46 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 13:01:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:01:45 +0100
Message-Id: <DM211N6KK6LP.2KC9V4ATVEAP6@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Jason Baron"
 <jbaron@akamai.com>, "Jim Cromie" <jim.cromie@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Lyude Paul" <lyude@redhat.com>, "Yury Norov" <yury.norov@gmail.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "David Gow" <david@davidgow.net>,
 "Rae Moar" <raemoar63@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 01/11] rust: print: use CStr for __LOG_PREFIX
X-Mailer: aerc 0.22.0
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-1-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-1-832e4039b71f@weissschuh.net>
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 8446c10a-747f-44e0-1cb0-08df2797ce16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|23010399003|921020|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ItUZGuUM+DAd3RKoJuaE/9PSg3/Kkk/dwOjs24lZhlOIzzLJ3hk2hlDvlOytsqCMh/bqPLfQkS1Dze1mCxAdQ1/eocxoPmmrP0XK4L1HdAePHSm1kwh4EA6wp1FCRl3vEilYXbTAPSXvtHjhlDOAU02Q7AAP+jHwrdHlLQBpPmlHl8kLHkdF33cEwv8EtmaXLpEQYZsDy8bjdgpZmrNqDrNuheqvX02THamzP7deQetXAiaO3Wf70oCRyiGL1nwE2A87MF1QHxKfLPHnlCv7BJCxnq4tXLOPZ/7VULrGiICvamWd/uqQJ6Q4Ci+26iB8zeUtRdyFPcA6MMoq7fvWg1fcS7U/fscBi7yrN2ghoWh0cfCUFUbDkgo7IcyCDfvUPOoFqA47Pyw7nsrxxnRhtP83TsUnMCylUYAzhQwTw44e4ZLbgqVKF5gDoZ76HHxfDIQaB5e/CX63oEA4QDxedG0heRplY+F3H4FhD94M8x25F5Rey4tv1XkMo+FETaVQlzLhawEJH0r46aeyta6IgCzVeerJCWqRuTGQ2NUKh+BfMjxNsQBRb8oXY8MvUqavHGesC0P94bbS9cuQLJQceOU9exOV84s2BXXLdZDU8eP5Voco/JVmr0dnkW0sWp1CsIQi1QW7O0+gSdqqwqyBha3BtnTOw/VQjRfpEJqFRw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(23010399003)(921020)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejVQUEhSSzA3ZG80MGNBT0hzQVFJK1BCMllLM3hHMmYzYmVRQUVJU1p0eFlk?=
 =?utf-8?B?djkxOFhRZUt5QTZPY2E4V2E4T3M4MkF1RGdVOFdPZjhaNGxlWTA3aVhjZmE5?=
 =?utf-8?B?SDR1dFE1K1lqN1BVQnZ1RnhubGN5RkRrMHQxaEt5dGRPdFVRWDBCbHh0OTF1?=
 =?utf-8?B?ZjNnMzBEaHZXTDV3cFVVSmR0WEhsM1BERmk1bkhzTVlaMk9aN2tYUlVxQWV1?=
 =?utf-8?B?UG9xOWxpOTJRMFRvZlBvNEhXUDZVZXMwVExnRVVRV1ZmTlp6eUo2c2t5SGMw?=
 =?utf-8?B?dkxSbzdOV21DcExUbm1vdUlzVFQ3SnhITGl4UTJOTjJTTkdETlZkcjM0VVRr?=
 =?utf-8?B?RzhoVnQwZElGeWpMYWpEamVHSmt1bjVXVWNSeHpFY25JZnJDN3VkWWZ4TTdp?=
 =?utf-8?B?elArb2FaU25IaTB3T2hYK04zUmVFaTdpT1pxOXBSNklEY2tTeXRkSnlKWTRY?=
 =?utf-8?B?NjloZW9FZ25CVVRydGlscUQ0Y256T1FVNlJyS0RCSXR4eEdTYk9wNjhtbnBp?=
 =?utf-8?B?eFA0eVh5NVBUM2lVdzZ2c1BMQXB1Y3lMdmVFWHJpQzEwMkZkUGt6emI0Vzds?=
 =?utf-8?B?SjBxYVliVSthSzlCMVRneko2ME1kZXYxKzRnR0VSY3JnQlQ3dld5Slo1aDNs?=
 =?utf-8?B?VFZabE1jd1E3SkRNSTlZM1RsaVBpbDlJWEtzeS9jTzVsNjFxWS9NQjZzelNj?=
 =?utf-8?B?a0N6U0tkZzJkaEJpbGFOdnVhZ1FoV0JFamFMdXJobFQyZ2djR1IrY0lRblVC?=
 =?utf-8?B?WVVFTUZJYkd6OWpuNHRLYUxzMktNeVk4VlVpdzJSS1htZkpTZXFKaUVjem9X?=
 =?utf-8?B?cEFUVGxEbmxyMnZKQk4xL1VNQ2ZMSFcycFlqTkg2cVMyWkRDQi9qa2hRUExo?=
 =?utf-8?B?TWhtNjUzbVBrRncvV2g5MDVYNXV2RCt1NEUxOE1ZMStJRll0UVZ1a2lqNWVI?=
 =?utf-8?B?dkpITEVpekprbDFnR2tnTmluN2dFMHlSa3d2bVZ2VzdPakg0V092MXBGalkv?=
 =?utf-8?B?VGJUUzlHemU3amJCMngrWjdPNEdqcnN5NFZHZDdNWFNzeGRZK0U3ZVQ1OW1y?=
 =?utf-8?B?V29hZlFHclEyb3llK1RHN1BsTDdJUkh0QmRaeVZabUJXNGk4MXBRV3FnSFJX?=
 =?utf-8?B?c2pNR2Y5K3pUdkdnRmd1Y2crTlhzMXRGb29zUkZWVDhpeldGN0E2STJVb2xM?=
 =?utf-8?B?Z3Nzclc2SGQ2dXBvalFscnpMV2xkelZXdjJwa3RPd3NQU0EybURmUDZsU21D?=
 =?utf-8?B?MVluMTdoZE5IS2ZSSWRNeWhTUUdBZENtaEJxaldFTXV3NjM3YTlvRVBReFpV?=
 =?utf-8?B?ZDhFL0dvNm83c2hSNC9OQXhkSGRUZFNtK3NWMkdMRldiUkFMWU5CSEhiSmM2?=
 =?utf-8?B?NUxYdWxUeXptam1nM0ZaaHhpS1MrK1l4WEVaVEhtQ2U5ZElGdWgvdE5XdTU3?=
 =?utf-8?B?V1FwR1BuOGdtb1hOY096Sy9HUUtkZzF5bUs1SCtoY3NNMU1RbmMweXgzY1lO?=
 =?utf-8?B?UmxINjl5OHhqRUUxL1llWlc2T0ZwaUhOWFFtdGFuaG9OR2tzT1RhTWpIaDZt?=
 =?utf-8?B?VWY4UFB1MFY5WGhzM2ExOW5mWUFyVU5YQzBoU2VCdDE4NlJVRVJ2TG9QL0py?=
 =?utf-8?B?SkZoOW53QnIza1NIQnVSNnRpdkxuTE5QZTFuQmF4RmxIVytJN1ppa2tGdkJM?=
 =?utf-8?B?Y2F2SHRBOW5JRlBzbE52bjVDNWFOanJITE11SkQrT3VLcjcybmxvOE1Nek1a?=
 =?utf-8?B?NkdENVdlcmkyaTloZlRFZ1dGY0xCVVhwVllWMXA1TWp0VzBYRGhxL2sxcVdy?=
 =?utf-8?B?TTBpVTZSSVF4MnJuUW51a1o3TGEzNzg4b0RHVXNlUHBENWRHODZZb28zN0pm?=
 =?utf-8?B?MmxNZUJmaVZFb3grV09VTzFpaU5JN056bEhEVHFHNVFsRUd6VUJIT0ZidElN?=
 =?utf-8?B?SXFzSGdpNXFseXRLc1JaY2hqMkpTMmVocWtUZWp2N1lYYkc4YVBxeWNKRDll?=
 =?utf-8?B?dTZKcmxGSC9yT2pJRnI3cC9KejZoRlUxTHY3blZRUTgrTjQxRm5BNlYram12?=
 =?utf-8?B?WmQzcEpuM2JuT2gvNW42VzMrdFM2cm4zZVFSaHdtcCtlaHpyUUtVVlN5RGd1?=
 =?utf-8?B?WUszKzRoZTFXVWpsWklYc1UyZXJmelFZZE4vbmduSmpITm1Kb2VLU0tOYVFm?=
 =?utf-8?B?VXA2QU5BMFNNVnJiaUlVZzNQMjQyNWJsSHk5dng5T2NwU3RoMEFMNWRMZGtx?=
 =?utf-8?B?ZUJCaWtJVW1kRFZmMStuRzZ3Y3UyUUNKd3BWZWhxV3A0dE1uTk1NWUlGQnIx?=
 =?utf-8?B?TThZVXRGblFSQjVFMjMzZEQyUDJYbTVIVURkVXB6L2VFdVc4bFQwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8446c10a-747f-44e0-1cb0-08df2797ce16
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 13:01:46.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8FY7rCEs0+etTxEyfyG0lXqUdZM/cDrTlgnKVP25zze9LCVPiIFLpJ2lJUnf2xQEaoLa42JCIu3EjWOZODXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7621

On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Wei=C3=9Fschuh wrote:
> The users of __LOG_PREFIX require that it is 0-terminated.
> Currently this requirement is only encoded in safety comments.
>
> Switch to CStr which can guarantee this invariant through the type
> system.
>
> As __LOG_PREFIX and Module::NAME are now identical, reuse the former to
> implement the latter.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

See
https://lore.kernel.org/rust-for-linux/20260728-printk-v1-2-855606634d70@ga=
ryguo.net/.

Best,
Gary

> ---
>  rust/kernel/lib.rs          |  4 ++--
>  rust/kernel/print.rs        | 11 ++++-------
>  rust/macros/module.rs       |  4 ++--
>  scripts/rustdoc_test_gen.rs |  4 ++--
>  4 files changed, 10 insertions(+), 13 deletions(-)

