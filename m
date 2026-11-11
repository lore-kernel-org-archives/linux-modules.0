Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409632;
	b=FgqFDREarCo8achfyIRrcIYjlm7U+WB7z3qsEEIhhfpQpMX2T5ETvTxBi70u9myJFZrX
	 UmW6dkGbfB/z63z39l/J+kNEG9IhGhqPBFqYzya0xX+k6rAZA5uEgTLVZsmafQDDToz+8
	 UknqDJ0pfyT+bS4DWZ1uJ4OqxrnNTuhVynLINKIS/hVEccf5CFvdjr+pRBE8ns5ybbY0n
	 0pTzkJ0Ox4YvZRtByLwXy++ncXDQRkSbnyrFRlPovtDgsl0/Lh6BNRkr+DEnE9f+aWw5x
	 xKYmQRpX9VtNVKDw0sIHg30Rpz4+AiIZEJ2FQ7/MFGx0N/eLd2T0EjO213Fx0HJ+ICw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409632;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=KeBHNStp4eSi8VoOxD676GIlM2l7uNH+XfsNiI6ycQ4=;
	b=hPQG8BNKWX1OH+80R/IuD46fFN+/+Hz2K9y6ba5kYGtfreON7myDJjK5nf2+Kgry6mhx
	 /ZBBmihQ29Zz1X6+HkmRD+tNQ2Adfte+uplHBGVTGgYB/j1QQsyyXtMePv/IVUSUIJ9FW
	 PYk+6tgnnqIXAucLmZUMUIr1rvi/YvO3n13bU+StifYUlB94unYVLQjOs0XO0UQbi5cXE
	 zR9R1ARoNAUUAGOsjtweB65ehlY6ws29yFzXM6VsMF133I2MhgThiDpBcmwFvSdI3DNiu
	 OayrgHkIFTtS+yF3LarlkNhST9AFtCYEWPTzt3Uymu4hMc1SVRxLQO1bN6cbgSnU7Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YD8CiAgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.82
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020082.outbound.protection.outlook.com [52.101.195.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DF606A8B3;
	Wed, 11 Nov 2026 15:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1DF606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YD8CiAgl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nii7Ov+3R1Ae5TvZC5Ba5jJ+EX+wHLdWOORNmdySMQjnzqqdACsRw0LC+HyxnaTA/LueaORjRqlXeixtLHEfYnIbYVusH5UqBugD9jBwtfatUp5cP8KKHwYuBRkKq3e8t5p2J/Fe38zSeI/tJz6DJKmGzhgcu4DZ36VfCdz5H1sWzBZV9OAaPg6pTA4foMIG/t3X6Vj4PyciM3ZRPCsN81W2oVTaDE45NMY4f7iWpMXuhswf1TkwzTiWYDqR53f4Vscx1vbC1hlRrAIQiz6R2C482KmTQNYnOSYQ/8ZAHnWoGkrxCEapbPSimndT2iIqhM/PcacWRVoY95UQaWbmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeBHNStp4eSi8VoOxD676GIlM2l7uNH+XfsNiI6ycQ4=;
 b=RYJuyR6tlakO0b3U5tm0pbcQPuKKpmVhuNhWwm+VaVjkvK5uJPecWv93sGSpEBBOyA2Nh09WMpjkq+fJMnIrXDy1+RkPu1PQoHNWySXgp0DfY52UMk7+UKV+jl0KjUBgBu11FC85QaozWh+CS2B6T71s8OdGtXGN8QGs+HQVQ+vNq9RXBJmtFoaknV5lfm9WqM86fH9Wcg0ZirNKmzxrJRL2vJTnjRRIGHaLPZBE3fvNNKVBZ7sYDDwPQvfRnu3gVdTW6sbIA8OMjwoRAJ+13M4ISBMdZ5Z1Q5wwFVTfySYNAP+4gFXlarYluJLlGkXUV9ZMnzd73enZ2t2D0s+8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeBHNStp4eSi8VoOxD676GIlM2l7uNH+XfsNiI6ycQ4=;
 b=YD8CiAgl5urmHfM+CkJG3MJGHamuH5UcKZngmLhEdPk4ezDeuOX7Dx7ZjDGq+ZQ6k8zctqdwHgyGHiM9hB/DZb8bnKDa7pvAAwA+XfopaQ0o36e+tC4bLIksmRqUsGkCREHEc5QapYWw/fUhxze+1OUNgdfEoB24Noi9cKpd6EE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO7P265MB8621.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:07:08 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 15:07:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 15:07:07 +0000
Message-Id: <DMSH4IP35P3I.2VRCDRRQ5O6SV@garyguo.net>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-modules@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin"
 <atomlin@atomlin.com>
Subject: Re: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
From: "Gary Guo" <gary@garyguo.net>
To: "Giuliano Procida" <gprocida@google.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com> <20261103165833.418845-1-gprocida@google.com> <DMQS0SH6975Y.23Z4V64W0HWN5@garyguo.net> <CAGvU0Hn00iMkAEMLBZmaJ+ub+Q2aJTtvJXgdqWfbjDyFUus2mQ@mail.gmail.com>
In-Reply-To: <CAGvU0Hn00iMkAEMLBZmaJ+ub+Q2aJTtvJXgdqWfbjDyFUus2mQ@mail.gmail.com>
X-ClientProxiedBy: LO6P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::15) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO7P265MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb6993b-44c5-4937-a6e9-08df40057468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|7416014|1800799024|22082099003|18002099003|6133799003|261009223027099003|56012099006|4143699003|261102130727099003|261102123227099003|261021121427099003|261022075727099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1otLkXDquxYCfeNlcFXtO/FPtviUuLUmb15LxeMI/a+Uu4B8p8A/iqQV1UgZKjf1kEnhuN3+tkkNXw5v2DZ9QGh609QM+Ak5G0YIBczYm0GoHY6fJHdszgz+hDIEx4Fmbwi16lZ7VudJ7GvXHL1L+tiOSttWLy19ZOKj2/xzNGl6NJD6KFRUccMpIafjNcbypkV0QU2bHN+nSPB1pwnHnX2FmaQUof9KJNqA1wKYS+naP1eHaG2pb+1ZXiQUWXrWpKI0R70MwO4UEkKuru1btqM7vwwDqSH07rFp/xlblLagkqwdRJd3Y10K5Zau1vywV5b4MrrByGnkTe30xl/MXbA/ROj+dR5Y9TaCSf/eXYF5aT6/qP3i5mmbykCxx8aGQJCEzIyule7hJQXwG1TU39KhrxzCNkberEXdn62I0BdrXfPEH/+6YXpdJ6qadII77pr2R+39bQF5cvNr7ggeqv0CL8pGIM81RO+30tvm+r5C3UNWtY0+NeIxDDQCjTW2LXfbZHQAnmKk+QrYagaJXi8fR0mq0lhmQ0ARBYSH2JXscrHEcWMZoz3j+y9JxExzvpZJQBlJ1/xJHAxas12b+WQss/gV/wqM1NqODscUKD55/0FIPmIvRed87+TBGjcXXLJ26SwAUFpFx9il+K4Hx+JPGaJ74oH9krV85YrhiYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(261102130727099003)(261102123227099003)(261021121427099003)(261022075727099003)(261026121527099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YndVVUFLWHc2VjY1QXE1SXlGQVJ5M01EaTFSUlFZYUVtSXV2cEwzUzh4dGo1?=
 =?utf-8?B?K09xdW5oMmdhYU43VDhoYXd6VmVFQ2YxSjl1c3Y3WmhOU0l4SzdFRGZJU2R3?=
 =?utf-8?B?eEtIZnVIR3hkRzFhTERodU1zOVQyNnZJVDBDYWw3bTRKVUZFSE8zdGUyVXpH?=
 =?utf-8?B?Y1V0UUU5OVB3U0dWOXI4YjZ6aDVsL2ZTQnhLam91bDU2cUxlcUVlUXBDdngx?=
 =?utf-8?B?aksrUGFYK2lqRWljMzlNUGhXa1lyenB3NysrRm5ZaGxZOFR6UVhlK3pkam9z?=
 =?utf-8?B?NFpRTWVGYXVEMVNidWIwWVdsWVgxK2F1djZMcDhaT09Yako0MzU4c0lrRERE?=
 =?utf-8?B?cnlJZGFJVkFoc1RuaEhRN0EwaDhtajB5YTNBaFpaQjVjM3QvSTZ5Q1hkT1Fu?=
 =?utf-8?B?eW1ON2g1aFJOR1lxOWExOW5zNkJiNExUVGlQQzU0UTl5YzNlcGlNL3ZkVU1k?=
 =?utf-8?B?WUVpem9uYnV6dm1LTkQyR0dWemJJdTdqNDdYQkZ0T1ZiYnpQcWpQSEg4bTIr?=
 =?utf-8?B?SEhnak1kVW9qTHRkb01OWnFuMGFrWjZRdkI3aDFIaHZJNzFtRDNqTkN1dW5H?=
 =?utf-8?B?b1NiWisxYVNXeDRENVhxQ1BiYkRnNHVBa2Z0ek1vaW80OVRBQ2c1U3pLdTlW?=
 =?utf-8?B?eTBwbnQ4UU1GbnpYb0Y1a2dMcXR6T0hJUnQyZC9WSXVaOTBYNjAyNzhTQ1I1?=
 =?utf-8?B?aEQwNTdFb3VaMkc1ZDRVNllwbEp2aHoxeTU2eUpUUkFHM2pDWi9UN2xVMUtN?=
 =?utf-8?B?dWxVMGZrZ3dDUEErWkFjNUFoU09SRm9Ga2c1QitjZWhEaCt4S0k4ZW5tcGtU?=
 =?utf-8?B?SGZ4bFh0QzNGTnhab3hYdVNZamtRSWVBcjVuOHlRb09Lak1pTHI5T25WZGFK?=
 =?utf-8?B?OFBFVHZBaUlrTGE1QkxKd0dURlZNd2IyaWhDUUNBejRoaU1sZEJUZElDUDNG?=
 =?utf-8?B?RmlPQnh2Q1A0Y1FiMWdzSlVxVTdoZTdJV2lTTzd6ZUhFWTRNOVl5V2M2UitJ?=
 =?utf-8?B?eWtsZE1neGNDZW40UXQvVGVCK1hSSTl0SXlNdHJwbUdHcWVQc2U2SlBkcytx?=
 =?utf-8?B?djZ4QVdDMEhqeUFCdXFFR1VnTGZlODY0K2o0Tll0b1U2clI2Zm04ZGZRWjRL?=
 =?utf-8?B?YkV1SnZMZlE4cTFsYjZqRzA3bm9XZW1QNm1KUm5uTGV5Zk1mZzlDMXFKOVBl?=
 =?utf-8?B?eG5qYndvQnd1blJYaW5jTlhHWEtZZUw5TXQwRDZYVE5GU3hka3FHZzhxVDYw?=
 =?utf-8?B?RzJsMTZ1OXRqNHk0bExTUko0eVJncWVnU1Vqa1RYLy9xdnlQQ2QyNjJxRGJD?=
 =?utf-8?B?ZEs2VkFWVytYOGp2MlZnN0txcUFpRFYyeWp2dit4eHZZeUtkVWZiN2dIOVJP?=
 =?utf-8?B?dXV2bzJCcU84aUI2c1FaVjBwMWZoTjdMWXlZaDdaUXo2OWMyYUs4VmxrN0ZU?=
 =?utf-8?B?Q3EwZm1ISzUza2NPSnROOW5NOHUwRmxsdDRpSmtBY20vWVcrUDJEVXBRQzhS?=
 =?utf-8?B?SnFUSXhmejlHdW1JSjdkc0hYWUFudkV5bThGazZidTdqREozdm1ZWEUvYWV1?=
 =?utf-8?B?aWJ1OUV6R2UrSEFwNStITGJrTmR2ZHJsczVmdzNJb2dSb3hkcVFJdFdGd1dy?=
 =?utf-8?B?Zkd4aHZzRHVJMmFldVdnV3ZxVE5pOFE5eXdZUEFIcjkwQWttZDAxUzZUSHA5?=
 =?utf-8?B?ZVFJYlhldWdXMkZ1a2dzSGwzcXJnR2Q4WHgvYUhlWks3NHlVd1Rid2xhQ3Bx?=
 =?utf-8?B?czNvcFNLNlVFWW5xOWhHWXNhbG5Ic1N2L3JxWUlkRXY2bDFQY0hsY0pha0c2?=
 =?utf-8?B?YTNaL3Y0ZitnbHFxRjB5eVNZWEpUSkVuaThpc01uZDZxZzZkZXBKTU1sdENx?=
 =?utf-8?B?M2RXQ1REWi9MS3IwU3ZXejBoeGVnMW1Hb3drZDIvQjl5MS9mTVNybjRYOWZI?=
 =?utf-8?B?OUwvRG9ET1owcWtoSjRNQ1FrRW1MelRsUHV4SzdDUW45R2RsaDFMUlBCTFdT?=
 =?utf-8?B?OVQzYmEzZ3BTa0FoOXNFWDRIRDBtQnBSTHBQeFczdThxdFVLd0h2SlhVNEc2?=
 =?utf-8?B?UldtcmQvS1BLR2RLbmZGTzlvTlA1a2xnK3lENmlZWTJPd2xFYUcycTFVaEdQ?=
 =?utf-8?B?aWgvditmNXpGN21qLzM0QVNoSFVISUY5bCtVYlN3WDdoSXIyK0ZFVGU5eHlC?=
 =?utf-8?B?RXUzdHZRbGNsMHY5dVlZeUhZOUliRG1aYkIyV0UrcExPRS9nSDJEc2UwRVA5?=
 =?utf-8?B?MGZTMlpHcWUvbk5OcjNjQkwxOFYwdkk4WEpUOVkvMFVlZ2tEQWlaa1I3Wmp4?=
 =?utf-8?B?b2oxRHdERzl5enlvUjlvOEZVZFN4aEFqYmFVR01GaEwvMVUwUVVudz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb6993b-44c5-4937-a6e9-08df40057468
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:07:08.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Hts8fWHbFr4V2RxigJ8aJ+KypN9H/2VIR/7QLU5oRWkr4oP52glnSmmLn2dum6pJ/DOT/dxWniJSlMDrvkrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8621

On Wed Nov 11, 2026 at 3:01 PM GMT, Giuliano Procida wrote:
> On Mon, 9 Nov 2026 at 15:14, Gary Guo <gary@garyguo.net> wrote:
>>
>> On Tue Nov 3, 2026 at 4:58 PM GMT, Giuliano Procida wrote:
>> > Move EXPORT_SYMBOL_RUST_GPL definitions into linux/export.h and
>> > prevent the emission of bogus type information for Rust symbols.
>> >
>> > Addressing review comments, the first commit now ensures the moves do
>> > not trigger warnings from scripts/misc-check about missing symbol
>> > exports by extending regexes to match EXPORT_SYMBOL_RUST_GPL as well.
>> >
>> > Giuliano Procida (2):
>> >   rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
>> >   rust: exports: emit ___EXPORT_SYMBOL without C declarations
>> >
>> >  drivers/gpu/Makefile                      |  4 ++--
>> >  drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
>> >  include/linux/export.h                    | 14 ++++++++++++++
>> >  rust/exports.c                            | 12 +-----------
>> >  scripts/misc-check                        |  4 ++--
>> >  5 files changed, 21 insertions(+), 18 deletions(-)
>>
>> How about just getting rid of EXPORT_SYMBOL_RUST_GPL completely? The onl=
y reason
>> that it exists is because EXPORT_SYMBOL_GPL in C expects the symbol to e=
xist.
>
> At some point there may a desire to limit which Rust symbols get exported
> on a granular level like for C. But that's out of scope here.
>
>> We can simply change change rust/exports.c to rust/exports.S and get rid=
 of
>> EXPORT_SYMBOL_RUST_GPL completely (plus saving a C compiler invoocation)=
:
>>
>> Something like this:
>>
>> diff --git a/rust/Makefile b/rust/Makefile
>> index 0165626decbe..75de47028b60 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -571,7 +571,7 @@ rust_exports =3D $(NM) -p --defined-only $(1) | awk =
'$$2~/(T|R|D|B)/ && $$3!~/__(p
>>
>>  quiet_cmd_exports =3D EXPORTS $@
>>        cmd_exports =3D \
>> -       $(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
>> +       $(call rust_exports,$<,"EXPORT_SYMBOL_GPL(%s);\n") > $@
>>
>>  $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
>>         $(call if_changed,exports)
>> diff --git a/rust/exports.c b/rust/exports.S
>> similarity index 86%
>> rename from rust/exports.c
>> rename to rust/exports.S
>> index 1b52460b0f4e..efe6bff0f983 100644
>> --- a/rust/exports.c
>> +++ b/rust/exports.S
>> @@ -13,8 +13,6 @@
>>
>>  #include <linux/export.h>
>>
>> -#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(s=
ym)
>> -
>>  #include "exports_core_generated.h"
>>  #include "exports_bindings_generated.h"
>>  #include "exports_kernel_generated.h"
>> @@ -25,5 +23,5 @@
>>
>>  // For modules using `rust/build_error.rs`.
>>  #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
>> -EXPORT_SYMBOL_RUST_GPL(rust_build_error);
>> +EXPORT_SYMBOL_GPL(rust_build_error);
>>  #endif
>>
>
> This doesn't cover drivers/gpu/nova-core/nova_core_exports.c though.

The same can be done to that file.

Best,
Gary
