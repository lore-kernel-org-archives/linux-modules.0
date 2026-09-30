Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020106.outbound.protection.outlook.com [52.101.195.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456042E1F0E;
	Wed, 30 Sep 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774219; cv=fail; b=m+/s4FthF7B/llhBfKnCtG5OiiPD44Cer502CfgNNZ+gFF/QyLtytBkbQOWQb1pwK9KguS50L6bVmU59D31/OPbEmlohfekwUA7hFYGX1KBzrmAdgb4lmFxF66YyiDm4ysTb2Ad4t10BuKwTLkX841Wea1A8heCy3dg7lTm6Pq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774219; c=relaxed/simple;
	bh=HD5j2ZMFmDajpkLHmCO1F78N95z2t4xc9NmuPKKKcuA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=NhA8V6zXVgj65uU+DBiAyJZ+iDitYIn5LVwb6xvLA3zoVlJ8vae28HcPtpkmMT+PHcl1g4M82tTDxssYqa3ftKCHpz54H74qMVujLMdCNbi3LjQntvleemMatcdP5q/gnM28hqSMOY26GeUOeouVwbOF9J33ARvbY3w1Su+o9sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rvpFuw+m; arc=fail smtp.client-ip=52.101.195.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rvpFuw+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVjGhoBZFugjdsegm8W3cHq4UQh9PUN2pYik57pYwiRdrSbyQRglDvVXOGpk2tYrW1zdACxdTAKaWBdIWHWyJxD6ErKhhZfUIiq2m8KuP0AC6XoKuScS4C63E8pKCNNzWiox6PeKqIbJwZlT0fA0Vn6XF3XbPmYwJs0PJlX9Y2XQUrIVV67jt6aZcLvkdegRXvC7m8j3QM5uZIEwDKMC9vnhHQjlKjecgbpxm2rPLtqsFdEnLc1OCDinhOToGBZts6wH2wTYd9Qg+GAFdkcQxajLNXnkW7JsmnCrb/xq/zpJI6aRBidLGbaUFIbu+u1JLKXLmjtaes+NeXf22MZQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD5j2ZMFmDajpkLHmCO1F78N95z2t4xc9NmuPKKKcuA=;
 b=xIVMXT/N2nDCeD6LziaoADZQk8eo9elwbjWJPPoZn31DWRJ8259XB+X1f/dZOj7ngdLuwljKFm/mOX64wwq3hiQRi9PB9ZFChFzWL2M7dHHSRnjpJo4dtFPbi+Ea7eWH9koCchgCqeASy0vb3wq1KNbVrBJNHlbV3ozHzqp+qIUqjI6ZH3cIyz6pEVDgNeFZsUAuE3Hyh44nwlceeYtl6M6i55T0Z5ke4/JwWn6W6xGGN1Pa2GdbGBgU9wKXAxbqx+MxDn2vuNOZXgIxNWRgiSqdO1kKVaWbT1UcT509odm8zJsznmYa+Qb8PPXTmsjzFR5l/s9rCWy5ZRU/h5f8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD5j2ZMFmDajpkLHmCO1F78N95z2t4xc9NmuPKKKcuA=;
 b=rvpFuw+mDyi6AqwaUofiyQOKYFrxVR3rM3YS9U2nHV3RVKKpZ+AJ/jgJ6u5pm5igNc7xcEFoSv3TtLYoi0+8DXZ81wEtaFXN1lBbGKGzv6RCwviVzhG966xm6kopBk+R3PxKQ743DD3axQznwoSJWYzT8Tp74jg2EVtM5JfPw0o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB1996.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 13:16:38 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 13:16:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 14:16:37 +0100
Message-Id: <DLSOH1EVCWKD.XEIME3CYEYYJ@garyguo.net>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260917051147.98775-1-tweek@google.com>
 <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
In-Reply-To: <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB1996:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a4557e-ebcb-4f15-17c2-08df1ef50f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|10070799003|366016|1800799024|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7Bzp/+5Yg/e/Xn2ZipIYF58qJLtyqI8nzPH+ms+hASxOvn4b5Uz7UutorBoz3eAVzWxrJbsT5MVx10joSdrVzlCuHWJ/5bjirrpMYa8zgIqUTFXfJQxeyw4VUMeg6WoRPAhXup1Jpa1pRvkhU1QIYrTQthSKUl2h6r49AL17SuGdRTvJIOdZfe8hEkbXyKVAtj9/nzCsIPBvZZvUtY7EezSKItDB7j/06HoDKVOux3nuLmHyF7Tsx8mGC2qhIYVuu9KrukF3OjYlj1TwOvrviTHfVe9KGybjLz8h/dARnFD8k0ApfL/b5ia8lcagncsDPyNDKdw0DjR4Lf/q/fGzuhF4AEhDr16QcdFPX9zsXdYjaLTbgxc+FcVWHA6DoxyB55L7nohQZtdFFS4W9FWeFON5lT8/viycg13jDcf2aCRbKws8Nk5VfoF+6783Qv6idxSD6T+Rst8WDb03pwBumVH9cmu7UglwFzxU/ODs2oSNRUJAw82PaOxya2FiTfg+ePA80UmW/zi8iO1re5nviD9RHMDGnCcMxpLd7P3sqK/OHiZzrkDhmpdceqbPLvivbvZ2QVyDnNA3WCFnX9dChyEHt4sMpc4aL4DYQEVlH9ZAeyHYjQXy9ztQ1+LsqEJQfI6bdK+etdQvrxe0i42sS4Um1ja6c1+fRcOP5mCpSiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(366016)(1800799024)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2N3MFYxL3dMQ1ErTFV2ZTk2SktGQ2tYZFU3Z2M2TlVCQjkzUzRCRWJ6dDhM?=
 =?utf-8?B?Y1lzZnVnSnMweTFPZnZmck5rUkxlRk1OZXlLUTZGTkd6ck5PNjc0UUVVTU50?=
 =?utf-8?B?b3VSRVd2bC9CbnVlQ2hnTk1SVTM0VGQ3bTV0aWl2RWVLZExsMWNScUhpWmNZ?=
 =?utf-8?B?bWNyM2R4c1lTQlpTNERGNDVwS2xyRkViQVNFTmNhcHFQQ2ZTeGRxcmhWR2g0?=
 =?utf-8?B?S1l5SWhxcFhyaGFyQnJrS2RQejQyK01IZGQ4SGpiNUZnR3BxREZUcG82c0FW?=
 =?utf-8?B?dmt2RllsUzFFOWV1alRJRjR3Y2JsTnFYV2dscGVJd2NSVVNBeUUwVytHOXBs?=
 =?utf-8?B?cjFMZEplQ3lvRGRaNFJaenVXODhTTzN2Zm1JYVVnaWdFeGtLZlYwcHNKNG5w?=
 =?utf-8?B?c1hlQmdvdlovZHRKTVJnL2ZGZ3hrVDJqcGpDelYzdUFUMksvNE5IaEhWNWhG?=
 =?utf-8?B?d1Q0OUt5MFA4U3hVbnJQQmQvUytKTElNTFBZSGhaQ0dQRExpbHBERUN2VUR6?=
 =?utf-8?B?eldoajYyRHkyaUdLSEhwdDJoSG9VejZpc0lKZDBLSVAwdThLZGt1WHMxWjMx?=
 =?utf-8?B?b3d4QS9DVSsxWkE1MGkvc3NZcno5dkNTR25lV2xNaU5SMWJ6SUFsQVFneS9l?=
 =?utf-8?B?dGxRK3RncGpRamlWSGc5Tyt0ZzVzV3RyVWVrRmZjUGRQMVdXTnhKZEd4Tlhw?=
 =?utf-8?B?eE8wSGRWNjMyT256T0FHZnlKM3FOMWNWaUNEbXhUYWVIVEl4S0h1ZGtiSWZs?=
 =?utf-8?B?bjVKWHZDcHA4RjJDTUtFVnZnWVZ5V2dXalNiS09nZk5VcDNueHBnOEorTFVa?=
 =?utf-8?B?T0ljdWlUd2x5bTRrdTgzMnRNVk50VVBQL0FRZ01kWTVhMVR2UnpUaXdiYWQ0?=
 =?utf-8?B?SkFzTmRDWUZuR0NZNVFqYTJwaU1tTkFndWNLVWM1Mm9QNEU2cVl0MWp2ZzJu?=
 =?utf-8?B?aW5HMEZXem5tSE5mdUQyalcyUi9iUS8vWTlHck5OakQwaWQ1YkVJem4xWEtJ?=
 =?utf-8?B?SmpEM2I2cWpLTzIzaDh6dWNQaXVReWpPcE94S0MyWjVIUFEwaURaOVgxNksv?=
 =?utf-8?B?UWJBZHUydzF6ZWhsRjg1bWE0WXJuYlJFN09oU2l0SUpjalF1a08zb2ZzeXJu?=
 =?utf-8?B?cXJPN1RWVWhhd1lpVEFzUEF5d1FpK3F5SXBWNGYzekdoV3FSVTZKUGRGY1Fs?=
 =?utf-8?B?SVI5L1VzSjBsWXJYYnVSTHdBeE1tNGZMMDU5akhKNllaMkh4MWUyelV0V3k0?=
 =?utf-8?B?RU1yUGQyME1RSDZkWkh3OXlDODMrb1FCTmpYV3laNklYcTExbjgxN1dqaHQy?=
 =?utf-8?B?UzJyZXRySWh0UHVhVlN3N1c5SFFXcm5DdDEySGtNUUNLbmc0QldlbmJFOTZI?=
 =?utf-8?B?S3hVYlZwdXViZzl3Zmk1Sm1CZTRFUXlTdkZlL0hDZkxzQURsQys3QWkwbXhS?=
 =?utf-8?B?Q1grZFkzbW1hU0d3eGdTRWF3ZXpVbUx1VXVBY0J4d0hnSUVKNU9oUXRPNFNH?=
 =?utf-8?B?MXpEbzZ0bitXOGVtZ3p2aGtYS29IMktSaW5Yay8vZUZ2cTMwUGd2dUdoMFk0?=
 =?utf-8?B?TDkxbHhEd2NZYk8zZ2hJTDdZdFc4UHFZOTNtR2JVV09jd2dvZ0pDdjhJZ2pU?=
 =?utf-8?B?SzJUMDJwVDczNm9TS1hnS2FCREp2dGJUVmZENnZ5ZTMrQ1lleDlJaTFsaThL?=
 =?utf-8?B?OVg0Q0pOaFREcWFTU2hsYXJiRkczZi9yOXpudHljUmZxVUJyV0xWRERrMm1o?=
 =?utf-8?B?Qk1SU2NCQkgvNDZsK0JlNVA3TmVVRVlqQ204RHk4QUY3TXhPcDRNRlpmY2Yy?=
 =?utf-8?B?S05wU3J2MTRucERRallPYjE3SDhjK0RITHdwTzdteWt5VktKWWN0TnY3Wk83?=
 =?utf-8?B?Q0J3S1o0OEJwYndQZVZVVU1yQmJ6Y3JPajl1SkQram4vaXF3ZUpXUDNoYlNo?=
 =?utf-8?B?a0g0WW16QVdRdEkyaWJZY0ZtNkgrSS9qZ091dEZVUmFxdEZBS1JwbWFUbmFN?=
 =?utf-8?B?WEVud21FeVJRdkx2dVZFSUk5QVhScm93Si9jMk9OenMxaTFEcDBPaThSRmFN?=
 =?utf-8?B?MmdTOGc1cjV5Z1AxZVZxbzFhSGNFK3FxZTFwRXpVV3RDOUhhTzFTc2h6OXRl?=
 =?utf-8?B?ay82ejE2NHNGNjEwN1NUOXdJZW02QTRwNmwvOEJoUHBRRWZHYW9BMFI0cTl1?=
 =?utf-8?B?NmU2TC9wZjhLLzBnS2E1L0lpMDNKSlNzQkU5aDBlSGpLVzBFUmpOc2F3cEFy?=
 =?utf-8?B?QU1lSTZxbGFxRDBFU1BTbEZCWWJEUGtEL2VIUytoL2pNaVBXTm5VMGVsR1Bw?=
 =?utf-8?B?TGNOVDZGNldSQU9uZTBQdW4vUVJzRUlrdmVjSC93aU5kdXN2Zmx0UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a4557e-ebcb-4f15-17c2-08df1ef50f4b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:16:38.3364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d063TGLE1XYXXYcOX8sZLci70BokDmtRR9yFlWQgnzUiNO2s0qcQ+lDERNdKdreh5NYvUxxu9TaF9KcOfwBnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1996

On Wed Sep 30, 2026 at 1:13 PM BST, Miguel Ojeda wrote:
> On Thu, Sep 17, 2026 at 7:11=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
>>
>> Module authors may have non-ASCII characters in their names. In C,
>> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
>> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
>> modules use non-ASCII author names.
>>
>> Originally, the single `author` field permitted arbitrary string literal=
s
>> including non-ASCII characters. When support for multiple authors was
>> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
>> key"), it reused the `expect_string_array` helper that had originally be=
en
>> added for module aliases. Because that helper enforced an ASCII check,
>> `authors` inadvertently became restricted to ASCII-only string literals.
>> Later, when the macro parsing was rewritten to use `syn` in commit
>> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
>> restriction was carried over by using AsciiLitStr in `authors` type.
>>
>> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
>> to `LitStr` so that UTF-8 author names are permitted.
>>
>> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
>> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> This looks good, thanks! We did discuss allowing non-ASCII long ago,
> so this wasn't intentional.
>
> Petr & modules: I can pick this on up (an Acked-by would be nice!),
> unless you want to pick it.
>
> By the way:
>
> Cc: stable@vger.kernel.org

I'm not sure that this should be considered a fix. More like a feature.

Best,
Gary

