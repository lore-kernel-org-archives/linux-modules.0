Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795055068;
	b=aqKg/p2j8XMcOLdxMK2UWF+Wt//rPrsKBfjJ+Ad/jzaPdLjH+m+cXIH80jVPFjfyT6B9
	 ox0wzp6ErsUdDVFxUbCDaBorh74U/TE8SUgW5SVgpE7TMJDM7Vqy3MP5CcxLOfkIr8vB7
	 1NTuUpfmxxzcwwPBm1W6lQtTvN3Z5/b2rkmAy3fi8JirGxh3VPVuPiEInBzyHalqJFNBQ
	 6TPa4H0GAI/msQOiFLe5SaFsOZ6SoUjGul7bPpkE/sgJCUVN565oFZb8K2VKsW0SeIJ3m
	 KZ8N5OkRyHrTZtgM5i02W+fJKwxl3jlNFw3BiFoGQAGwBT5krHHj/lSbbgZf3aA0SCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055068;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H9fgQqWOZyfBfGRi+eefXpLJzE9E5xBJoYGsVCHEGik=;
	b=p/kwwO1r+POYOFEDLbIhPPKsjlzGAZ3iP+14ZeQ8rePMNo8cm0ama9cfyPMwORTEeL5C
	 uSXxq3dN5IYFTbH813EJUCoYtg7YphczG2ZUWqRha98FZA+BpQKwIj3PYIAM6sbLi26zn
	 APIs+97Zu4e3aI8IqqXaw6XadHIoopIlC2rIpp1L6Seb7Fg1S2O7ysmlWQ9AV+8HwUrlJ
	 Txkqqz2kyktunZjyv8bjeBRKueNBAanwOusYt5KidSA4SrIKaVoGLaPiW75Hc+Fs8sCr2
	 mwzAI0SFxluyLmZ/vThHM5JqgZp1EHBqI9buebg1ABOMry/lSNYvz7Uiry6xeCPNYEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="X/xZ8DAn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.87
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022087.outbound.protection.outlook.com [52.101.101.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C1606A32F;
	Thu, 19 Nov 2026 02:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267C1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=X/xZ8DAn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krEImJoznTpB9BA1Y7dl+/iZCU1yopE76vua78qk2K4FrssMPw43uR94cxb6DJKN/Fy2y+U3TOj/KBE6I22uv9bbVlljV6/fpa0hFxCD5lW4HxGWaU2L6j7SVpJ5rgOBcr6RRXv3e+0CQF3ek/AVOf12PrzKyV/zsaujEXs0suuxZ4is0W9A2qPiYIJLcDx3T364FjH7gZVQSUblahe4mLalazVzgUpjoEa8WGtKu/32FiU8htwlJy1ZZYc7EwE4W4Cr0j7axorsP+4F/hCHF8mfVLY/j0XFEAAZXl2SZO6bsWiiBmdlqfP7mN+eH0JHaesUnFOLC3Rygkjag2OinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9fgQqWOZyfBfGRi+eefXpLJzE9E5xBJoYGsVCHEGik=;
 b=efcTry0mxyj5aW7DGwEFYdNhN4niCJezKgDeBdY7AIJLWhc0T58imoxmiYN1KhfYhBa7k3QzxCtAiT+gvsRO9pnkGON2M6LA4DhLM835hZw6ti4cMuKhgUw6lz8eII0MwCFgQIPLS9NgEP5WkU+9kJjNBzs6avcxk9RYnt7H+cYN94u3TfY0pbkYEGDgbttiOztU6XATfChYcTOcGyWWOrHmKRVivHUhQ88gUTYOTUrVuG3U2ZnMt6Q8mn5Kij+zdVQMM/SYDsUaROt3RhA8b9Ru4pVo/vr+9XlcxlRk7YXjpzhbWe4jhuXnvWZLuWBGnM7W4jSFzQaQGASlAPDhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9fgQqWOZyfBfGRi+eefXpLJzE9E5xBJoYGsVCHEGik=;
 b=X/xZ8DAn/Hw0aFC+tT6Irnht69XhOgAGPm4QnB7fjatWckzkiee6ReD6/mCVp52O4AZ8MqYVjKOxWjo9MHYo89GTRr5CfVW1mps3Dc2RhajC2iL7VigOT+QMGJhbxQzlYAGsjyJNonUhzEJ5OgOHBiel7IbeKH6MApxVkTRaN+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6751.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 02:24:25 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 02:24:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 02:24:24 +0000
Message-Id: <DMYTWWH01CKA.3G8XQOEQQNVJT@garyguo.net>
To: <peder.bergan@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>,
 "Matthew Maurer" <mmaurer@google.com>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] rust: kbuild: generate a symbol version for
 rust_build_error
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
In-Reply-To: <20261118-fix-rust-build-error-modversions-v1-1-7c1023764f30@gmail.com>
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e83f3-3a4d-43ae-f0aa-08df45e43af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261009223027099003|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261102130727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BDeKQs6wSgzq0gwU4jara/42r96CAWcYVHFnu3Pq4BLVtSFZOVLim99zJ6sRDbCMkODWUuit2j7rmayUPJqmBuZS/99Ymdr+rc7+r+K9B3gP/xAaKQuxqCdQGgBv0+ys9zMJ1FvtPWPh5BLhoL7amWd9SQGEck1TFb+J0UPBdaNah5oWJJRiaCrgLsiDDzL0q0Oi4MUPFRH9LFuesHJb35NhxhtIc3NCOfH1+0Hol3n39SvoXO+CETVj5XO05WKX0HLmzKssps0mbHBV6uwO9pkh0a7sO/452/qj6SkUjNIf6J5m9bNnowBGzlJB53L/di5ny1zcTj236cbm1je47iA30m9ON4Bvm/97cvd4mZgqc3j7/jhZ79BoktpxY/D0mlWLT2lfoB7xpC11KGdfCci7pL6OMsJHMU+4hNOBpOwIoXOS6MLVfct2qZEIV3h6an64mAQd06Kb20wOn+FpFTqU3c5sFkzCzyC/tPpC+7cohu4ImpKMqvRNgnAwWbiDvA0jYyWZS3q8Wj7pfHjR5LfVwMdc3+yj4OZcrxQ9NJHs3moJv6shH8BeEGLoCa0PcGL920bEXZjbShVr3e4/dHXaT4bIHGjRI/uP4KnHpjpCmJkypjy83EHvJDZSxQ54GCyJoLdDyitDxvzXBsZo1JVUeDqfCV0ayqLFOyNkph8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102130727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citiTXlSL21yQUxJV2pQb0JwTjRISTBrVnpIaXIwSUhqcUNsYTJ5RHJJWHox?=
 =?utf-8?B?MUxJQmtUa2RjcWJlaHhXczAwbDJEMXlEZDF2L1o5VzdKdDljejFuRWFOckJx?=
 =?utf-8?B?Wjh4MzIrTXdzbCtwWjdwQ0FUNDhRMGh6YVZVUFFIQzZzWEp5Y3Byak40U2hl?=
 =?utf-8?B?ZFBDZG1jaE15eUdVTGQ5SHArT1pCa2w0amZlR1B5NGErNkJBa2pDR0JFOXQx?=
 =?utf-8?B?Q3BnNjB0OUFOWm93a1FxbnRid0lxWHJXMThYT1h1UGd6OExPTXgzTHBXYk5C?=
 =?utf-8?B?bGVlQlBqbVhXb0pvT3B0RnFGUEp3RzB2SW1nZzYvSVNobTc0Qmg3a0g1TURs?=
 =?utf-8?B?bmVMYXZuTnM4bDJHdStZTjdaVlBTdkVTZGNpM3VvVDVCaVBEL2E4WGtxVWJj?=
 =?utf-8?B?ekFZNFBaVlVIdmI1YVpDSm1UeFZHU25jMFVaZ3AzVDdPM3J6VlRwVENNVnNN?=
 =?utf-8?B?UU1MakI0MTBCTEU3NVVjTHY2akFncDFvcjUySEtnc29tYmJCTVRuSm4ySU90?=
 =?utf-8?B?V28xU1Q0c21MeExyQVJhNmxkZnZ0b3FMaU5vVUwyZG92OUlVWDNTZFd0Zkli?=
 =?utf-8?B?QjR3Y2VUc1pnS3NJOGtoMWVpbkl0UC9iVTBTUG5KMzYvZkdpNkxLVDR5a3N5?=
 =?utf-8?B?T1F4QXlRdFppaHdxang0dzN6V1lYMXUzV3BHdWxTdGRxZTVVL3JtdGYrZHFP?=
 =?utf-8?B?N2tMdDI2dnRQK0xGTEJlQjErZXFTdkZGWEU1a2ZIRUpUMFAybEpSM0VGTGpJ?=
 =?utf-8?B?Y2tIVTJhUWF4NDIrWDRGd3lSTnQxczB2dXBacjhsaVBDdVJwNkpwbllsRU9w?=
 =?utf-8?B?UEFIZTNvd0REbUN1NVVWaUw2d1JkVUVmaE5iUHVFcmRkYVRMMUhWWjhOT1Ur?=
 =?utf-8?B?anhMRlYrMUFPUzdXd3JHS3N1dzlGWkVkWTJZdnoyTTErS2M4UmIvaGQrK2J2?=
 =?utf-8?B?TzNBU1A4bzlIYlM3QTVyZW84WFJGdzg4L2kwMjV1UGNSZkN3Ump5cHJXU0xR?=
 =?utf-8?B?K2MrMUl0eXRNRXNMWm9LNFNnT29adkszRFViYngrQTBkbWtVT0lQRTNjWk5X?=
 =?utf-8?B?cGlkN0hMN3lnRjRlbm5pU3VXeWh5aTJOcWhFeU5lcmZ4Nk1wZ0Y3VVlzajRk?=
 =?utf-8?B?OVArK2tkRmlNTFNYbEFGbkl2OTRlMVIwdGRRc0JEd2tGTW5DTU1xL0JiQjl5?=
 =?utf-8?B?dUY1N3pFVkFVN04ySXUzWEZ0aUhwOEE5ajNCdDZtVko2TSs2Y1J4YmtQcll1?=
 =?utf-8?B?c2c2SjJiZ3VHNzd1TDZxTGJDZmFVOS9EVDFvdDRCeTRLS2ZZMDIxU2xSWjI0?=
 =?utf-8?B?WVA4ZmxFYS91a3NGNHQ4QkNmaExiZjY4WVZzQVA4eFZGdXljbzZ4bS9BejI1?=
 =?utf-8?B?bEtHVEtkMFBObHJtbmZ6QmtnSmhPcHJScjBQNjhPaHREaHMrWHEvL3M0KzZB?=
 =?utf-8?B?UkR4Ukp6WG9nSXZKK3hNZUoveGdnb3YvVVMxaDcrU0xJeUFpWTFIK3ErNnVI?=
 =?utf-8?B?WEF1a1dZWWFYSEFrbStWbjJhaVBGTWNjODdkaERTWTRhV2hCVldjYUtpc29T?=
 =?utf-8?B?Ry9BRkpVNGZEaWdJeC9qR25ySmtQdGxzb3Q5K3pjY0laNlVBTFVXcHNmUUNy?=
 =?utf-8?B?M2JENzZSYWltSGNFZ0tERjUweUkwL0lnV0xmcXg1N0lCR0wvbGN2elppMjVM?=
 =?utf-8?B?MU5VWFd0RGdiNWFGdHR3MnV5RDVnZlg3SFBpdGRGTmFwV1ovdXlRaUM3UDVF?=
 =?utf-8?B?RFFWTWVFRjR6RmRVaUM1YWVOS1REVDJaU21DLzB0dlVhcm8wNkZhRlRTVGVj?=
 =?utf-8?B?cWhDTFRacGsrY3o3ZXA0ZDVDQlA5OVdXbnZmVTBLSFpPMGJYTG5IdFNIeldi?=
 =?utf-8?B?VGxPRlZ1dHViZG9ETWcxSnNUYkh5NkVoK3p5TDZxSXIyUHhnbTNzSGRzQnhM?=
 =?utf-8?B?bnR4K1d4ellWNDJPRk1maHZ1cGVtdkpNRU5ET3o5YzJhdFEwNXpPcmR3dGlM?=
 =?utf-8?B?UHlBZzdncjFiMDFNdlJCZklLQ0xJc3VvcUpRVmV4eXUwSmlTbHZKajFnQkIw?=
 =?utf-8?B?em1jVUFjakVYc3hwV0RLcFFadVdjS1hWNkZuUGZiU3pzNmRZZFlMNGx6VGZD?=
 =?utf-8?B?bXBLRHYzVmF2dnhTSmI1UUZQQ0VMcCtoWmVWKy9SMCtsUnVKMnNUdWdsRzhx?=
 =?utf-8?B?VmlPb1p4cWtJdUhoQjg5c1o2dXR5Yy9TZ3hNR2dyVDhPQmk3Yndpd3RVMVFV?=
 =?utf-8?B?NUdoVGZlKzJSTUlzWGN6aGlrSW9lc3lUeWdXbXhjbTc0KzlzOEZMVG85TXc3?=
 =?utf-8?B?NzNjbGlkbkFLcDRpZGt1QktheFBnUGVJdGhLVi9VZURkSUNZeXBSUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e83f3-3a4d-43ae-f0aa-08df45e43af5
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 02:24:25.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agnTajbBLNYyfQui3pZTCFOYSVx0Tpdyc15Bq5qeLirOVEKkzMqKxmChYgfUVxdLp431e2kq1Jhnr61MPeIXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6751

On Wed Nov 18, 2026 at 9:08 AM GMT, Peder Bergan via B4 Relay wrote:
> From: Peder Bergan <peder.bergan@gmail.com>
>
> CONFIG_RUST_BUILD_ASSERT_ALLOW exports rust_build_error to modules.
> When CONFIG_MODVERSIONS is also enabled, modpost warns that the export
> has no symbol version and records a zero CRC because the build_error.o
> rule skips gendwarfksyms.
>
> Generate the checksum from build_error.o with the existing Rust library
> rule. Make build_error.o depend on rust/Makefile when module versioning
> is enabled so incremental builds pick up the change. Kbuild's saved
> rustc command does not include the gendwarfksyms step.
>
> Fixes: ac61506bf2d1 ("rust: Use gendwarfksyms + extended modversions for =
CONFIG_MODVERSIONS")
> Reported-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1201
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
> An incremental x86-64 build with LLVM=3D1 CLIPPY=3D1 clears the modpost
> warning. The kernel export and a Rust module that references it both
> record the same nonzero CRC.
>
> OpenAI Codex assisted with coding and testing.
> ---
>  rust/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 0165626decbe..dd5b0a958d0c 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -773,8 +773,9 @@ $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/=
compiler_builtins.o \
>  # treated as such so that we pass the same flags. Otherwise, for instanc=
e,
>  # `rustc` will complain about missing sanitizer flags causing an ABI mis=
match.
>  $(obj)/build_error.o: private is-kernel-object :=3D y
> -$(obj)/build_error.o: private skip_gendwarfksyms =3D 1
> -$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o F=
ORCE
> +# Rebuild when the symbol version generation rule changes.
> +$(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o \
> +    $(if $(CONFIG_MODVERSIONS),$(src)/Makefile) FORCE

Dependency on Makefile is just wrong in so many ways.

Best,
Gary

>  	+$(call if_changed_rule,rustc_library)
> =20
>  $(obj)/ffi.o: private skip_gendwarfksyms =3D 1
>
> ---
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> change-id: 20261118-fix-rust-build-error-modversions-4af535edc9b2
>
> Best regards,
> -- =20
> Peder Bergan <peder.bergan@gmail.com>


