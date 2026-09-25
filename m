Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BD481255;
	Fri, 25 Sep 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340585; cv=fail; b=FCm21roR0fFpWgGaMQJRzXW7jD45aVFwbed3NcC0LzYb0CMNPbZMY1lnh6U55r8yDhHVGlLEOY1llkMgNbxt56wZB34XlOdiCJ2peqaCkoy0ASMMFnU8P5/Oe7uw3ZW7Va8BSOhQ97dVo9pswFs99aeog13A21zRfRnl+Jpv6aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340585; c=relaxed/simple;
	bh=mK4rMTsxuFPSiAQV1UQfOLbTHMlJVriPgUbMKXycS4U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DHPO++9/6ih2VzPH4f0JX5etccwe2AGdxO6B9H9rGk7rx47aKDvuFVFRUKvdRX09tRuviO/4C5jSaIdRODorY5cjyrb9VOD7fV5ilUE9FBewKVLoXk1N7NAdhZQnZtyOJXvFZN/IwRwGMP7CQS6TINryeXhrggpv18mGriTudaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bbXXto9i; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bbXXto9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo1aaSDdYTrroMSHTKf7CdFEaj13vRmtXQW9SNsjExjDrZ9N8ZZe4FJg+8xqAGBcVIDTxNdfmVEBUo5bcVg88d3iW3Y51fwwWDo/MRYChPkjaX2NxbdPksXcmO3Gf2E+XKQGpJGUXvewzY3LgYSMr8TuFQPwA9uMeJe++rb27pzhq5Fd4YkQgAwlwOGQsyigP0josdtFpC8FLHhQQFueCEcu7k2f60RD34mH3NsZF32b+a6vH/eiPgR33XZzqAxw+gCj31Wecjdnlj3hwG87FgHyBP1pBdIAabdaeN4Qtyrvu93od83puV4Cung+ALhqhqN29PbWNSBf7iv84L1UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK4rMTsxuFPSiAQV1UQfOLbTHMlJVriPgUbMKXycS4U=;
 b=wpq6koerMeWMEOqIUK6oeoTXfvasIlEAM14jf4BIQvpyAMUo7A789wj3Q0ygSRxBars+9XP6+OYvMwy4waNX037zcLTgYozRJjhwPCTPQaQUCpOQZdJFL9Fkn3gD0TG7abWI6dmmsqTx/CGTpVgG8eWkQQ+PGneHHkcLG7lcEz3LnnxXSHs7qXNQgQrA9RWUCt3BM3Y07VxKBcmf6Bw94WNlaCqd4TjSwZG1qzgtH64K7R/7ZUVE4QDui0fIHb7pWoTARXaEE33iEEiO2xc+cj9EtvY/Ugiwv+h5OthKXGA8so85gJ84Il/q3IHGAWAeY2q0Q2IkkH15tgjD1euuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK4rMTsxuFPSiAQV1UQfOLbTHMlJVriPgUbMKXycS4U=;
 b=bbXXto9igu2oI605Kiv7zOd4JGmGNaX9RsL26k83EGTil9uWkj1sOb61DaPnKk9LCy+jp4NsQMFVn+X2jdB9gu216A2Q47n2CsSTimkSWhdzLLfYe6ml8TfLX5pnxKtch1/iuhzi78SG02N1+aeUKlzaczX/vPVEnlMK3aS5YpY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOCP265MB8568.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:49:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:49:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 13:49:38 +0100
Message-Id: <DLOERNFT9KH0.E6BYORP7OCZM@garyguo.net>
Cc: =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
From: "Gary Guo" <gary@garyguo.net>
To: "Petr Pavlu" <ppavlu@suse.cz>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260917051147.98775-1-tweek@google.com>
 <DLHERMQ9DOIC.1TRR4M82WNLIZ@garyguo.net>
 <0ecdcba9-a0a5-456f-8d30-e2201828cd07@suse.cz>
In-Reply-To: <0ecdcba9-a0a5-456f-8d30-e2201828cd07@suse.cz>
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOCP265MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 25226d41-5fff-4abe-32cd-08df1b03762e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|6133799003|10067099003|22082099003|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tZjv6h2jTGeXUGNBS/XRakPNKUn/ShrMwKEQWmZQ1effstBIs+zIW39LqtNIGMJJnkJTKDYZx9cm+iiG9P2LUQ1rV7u6Zl8QvwqTa2gDh+NlrEZuyN5JrC0MPX7a+ih1kkIA8GlLbjpcgrd22K3eMxEX2JBOxnAJvf9OYFnEICqFnc48x+2V1um6hI1LUz9VvYICA7Br1PLExOBF89tEVtWO9YjgNG89fTPV9dbEZuUFIPTojIF4NyuzBvNKpAr5G3k+2VCGF4AR/nx3Qhh6E9Er7ETHzlvRrL3SrYEb7IP9qG/z6kxMQlXnXy0/USieLoObjewH24WqKs00ns+27MNWADi/MzbSX/PyL+N5oVH6VFQCSN2MPLWmGuRPddRsJUZrXCCOIIt3rdv4gISRx2PJj9aA7zjodKO39oIuB00wovYviXwCUQUQCvy55+MAzSny780zm3WsoA3ZmNhKQ1cmveClkgR3xTFAo1RPyTzQoOeEKLnab6t/B0Aq2t0lISX0eclumjAf7T5NrW+GMsFTGbuFw9slywACyBULDnBYTXXfzjhXxF2yvjuIl9Byqp/tQ7JehdxHiUNGh6mE98xFdixiR3zSS1RZrnH8KIiyrsgWI9Yus7KM7jzdrNZddND7/qfr0DHdXkgVJvvIuMwtDYbfUzzJ5tQgm5Vux+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm5BQTdXcmdWNVBnUTBkUzZSTXczNDF6M092NjBmV2VLWURLbmlER0E0Y3Fx?=
 =?utf-8?B?RXRpVFduMHZ1TDZWQ0Y4bXUvYWRxTE0rS0E5Ri9Ccjc2Z25JajlZRGVaRndz?=
 =?utf-8?B?QjhaL0xNOVVVMUJkb095RXl0TlhtK3R4ZllHWW1DWFJoU2FleHpJcE9xZGJ5?=
 =?utf-8?B?M0p0U1Vkd05jQUtDaFRPb2FRSVRNWDlyZUthWWNWTnZWMUh1NU1tRk9TUlhR?=
 =?utf-8?B?UXJ5VlNScmNSdlpTUDNJUDZtaTN1MjVFWndqaTFNTGh0T0h0amJXYk9JMnVm?=
 =?utf-8?B?UEM0WU51dk14Yk92UTBBZlJHMjRENDBkTDVWZFZ5N21YWGswSm95QWtkTEZQ?=
 =?utf-8?B?anM3YVVqbWNzbk9oaUpiSzdsU0txYkdEaGxGN29FRXFrN0x6YXhLc0x2dEJP?=
 =?utf-8?B?VlRVTHVwcFFRbmlyQzZ2ZFlVZm9MalcwMkxTTFZEUnBJZDhiZG0yM3Q0Qmta?=
 =?utf-8?B?bUNVakllNkxWR1hJTXBybTdFUUMwU2FyYUw5MWJ1Q296aVdCUHdyanJXMCs4?=
 =?utf-8?B?ZFRtWlN4UVBZUncrcTVUZTBDV1Q3Yk9mM2ErMUw4OTdjcmgvY2JjNC9veGlz?=
 =?utf-8?B?cmN4aUFObjNEc1FSWnF3SkJBSEdhcFEyVEZ1Q1dINjJENUxnWTJ2bVhxRGor?=
 =?utf-8?B?NUVldkdtUUg0OUVIUGFFZlcyN0dYT09aVGJ3MjhTU043ZncrdnhDSnY1QTNs?=
 =?utf-8?B?UXBTUE5PV3NLbUdzK1VWbmtsZ1JuV3doRDdPaDBSWUdUdWFlT25VNXZVcTNn?=
 =?utf-8?B?Y0FXT3JiUWlYSTRmZnliNTdjQXBUL01QMVN6RjNMOGtrZnpQZEtncHEzdUd5?=
 =?utf-8?B?NUYxTDloRzh2YzhHKzNubTExMlorZXQ2VGxrdlkxSWk4cEJNM203eE1kVTB0?=
 =?utf-8?B?cXJxMkV4Uk14cGZEK291bVU0QWZrcDlOeWhUZGl1OXpjK3BiWmtSQUVwS2lW?=
 =?utf-8?B?UjVaMG15TUd1cUo3QkxoVE5JUzBjaWxmY0MwZEJ0SFVOelJMUEtZYXBET0c5?=
 =?utf-8?B?VnZFcUFvYktSWXFLbWFiRVpTRzNHVlJpQUJMZ1F2aU1LcE12UUhXVE81aHRm?=
 =?utf-8?B?OGVXTzVyT3ZhWkxlWkpxczhOeGtDSURGVkpKT3NxOWZmNmRhWnpiM0YxSy9E?=
 =?utf-8?B?aENzRWNxS1FCRU16S3FPTzVvemkwNlNoTEtVSjFXc1hUQ3hBbVZFZ1h6V0E0?=
 =?utf-8?B?ZGE1NHZ3OFd4dnhZWDhOMXZZdUwyZlpBRDFJd3lLcmlPTlFwbmwxb255cmdE?=
 =?utf-8?B?dmozeUlwc1k5QllNYSszR0VhTVhiVkN1S2FLb3hjeElzbmtkK3czOTc3TGs1?=
 =?utf-8?B?MG53azZ1QmkzbERZVlFPNTRzTHdKWkRTejBVTGlPZGtYUE5jUENXbnNuQ1Ra?=
 =?utf-8?B?WG9KMi9Hdno0dnFLQmEvc1pSa1FIM1p0blNRQm9XZ1RTZzRTVE9CUmNnTjJj?=
 =?utf-8?B?MG1GWkFJREEzb0ZpMXAxRTNEZHNTQ2RFY1BJTlVWVnI5MHpJNndFUlBaRCtB?=
 =?utf-8?B?WXdnTUxHWnRPVHU4V1N3U3lPY3ZSOWExL05wVTFZc0VXaVdrTVdVeEtIVnZt?=
 =?utf-8?B?WjczeS9seTEzYncrSUhTUEV6WEM0M2dkTHVSUVFGUEhpVmljamd1WU93OGt6?=
 =?utf-8?B?eG1NcWlRUHBnbWV3MW5jVXE5SWo5WXJlYnJyb3ZNOWhFUERwb21Gek16RStB?=
 =?utf-8?B?VmxaeiswQkwzRThUNS93aCs4TWd2bzJLSGZQRXVQbUg5UURSSGRNSnFtVC9r?=
 =?utf-8?B?NkJJU1BvNUhJV2pCQmV4dVBaS3lyYlVYOHNrdTVwWVVXbVdMQi9zbitUVjda?=
 =?utf-8?B?K2tNdDlFN0t5T0NWRHB5aWFqVWt3VHdlVlNaSnNUZUtpZkxFZHFUNDFGK1FZ?=
 =?utf-8?B?eVE2QWlNUEFPcWNXYmFTN0VlVUxpeDA5ZUpReHRKcGUvMDVVRzR6T2FXem96?=
 =?utf-8?B?RnJOOUJ3RUQ1QVVhQjBLRE5qQU56Y2lYYnY2SnBEdFRyR3F3MkFhZFRYa3dK?=
 =?utf-8?B?KzB0VmtoRmc3blJnUXZ1cEtFOEtlVXRoOEczS2RteGhrZElPSkdESVdtK2FP?=
 =?utf-8?B?TDc2bXVZcGdJUWFuL1czeUJJd2ExSEl4RmwwMWVTYTJOMmxEdFRZMmQrYndN?=
 =?utf-8?B?b1BUR3J3U2lrUDRGQ2VPMWV2V25CRVliTDZ5T3U3bnlFY0x2U0lUZjh2N3Zh?=
 =?utf-8?B?M3dPUU5DUkhYaHhwV0ROUE5keVlET0dFRkszU05hMEs1T2NibkFLZmM3R0xY?=
 =?utf-8?B?Szhmd09TckJTZUZ1bnZpcWNPazEvdzYxYjFSRGNzZTZNdnNJUExMWmZrZXZn?=
 =?utf-8?B?QkJ2NWpTa0cwVEkxR0FLVHJQNktBcEI4aUkrdGg1RXFTWmtmakVKdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 25226d41-5fff-4abe-32cd-08df1b03762e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:49:39.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkBaH74rh9PP3Hnxa7dugA0VEKJ76FL2bZt5y8ttFyLPHw9SAFbiE7399eMREpJCwTjGiRDh6r9HaDW/tgipEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOCP265MB8568

On Fri Sep 25, 2026 at 1:36 PM BST, Petr Pavlu wrote:
> On 9/17/26 9:20 AM, Gary Guo wrote:
>> On Thu Sep 17, 2026 at 6:11 AM BST, =3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20We=
ksteen?=3D wrote:
>>> Module authors may have non-ASCII characters in their names. In C,
>>> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
>>> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
>>> modules use non-ASCII author names.
>>>
>>> Originally, the single `author` field permitted arbitrary string litera=
ls
>>> including non-ASCII characters. When support for multiple authors was
>>> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
>>> key"), it reused the `expect_string_array` helper that had originally b=
een
>>> added for module aliases. Because that helper enforced an ASCII check,
>>> `authors` inadvertently became restricted to ASCII-only string literals=
.
>>> Later, when the macro parsing was rewritten to use `syn` in commit
>>> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
>>> restriction was carried over by using AsciiLitStr in `authors` type.
>>>
>>> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
>>> to `LitStr` so that UTF-8 author names are permitted.
>>>
>>> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
>>> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>>=20
>> Off topic, but I have a question for modules maintainers...
>>=20
>> Does the `authors` field still serve this purpose today?
>>=20
>> Almost always it is just the initial submitter, while the code has been =
subject
>> to many changes (many of them tree wide too), and the maintainers could =
have
>> changed as well.
>>=20
>> We have copyright comments on top of files, and git for checking the fil=
e
>> history. What's the point of keeping his inside module metadata?
>
> MODULE_AUTHOR() was apparently added in 2.1.18 back in 1996 [1], with
> a comment that it is for documentation purposes.

I am pretty sure the kernel changed a lot since then :)

>
> I don't have a full picture of how this modinfo field is currently used
> by module authors, maintainers and users. I think it can be useful as
> a record of all past and present primary authors of a specific module,

Well, if they're actually updated... But as pointed out that this was usual=
ly
not the case.

> and it has also value for external modules.

The version field has value for external modules too, but that was recently
removed. I don't think we should care about external modules too much.

> Unlike copyright statements
> and Git history, the information is directly visible to users through
> the modinfo utility.

Hmm, why does the user want to know who is the primary author of a module?
Users shouldn't try to contact the authors anyway, they should find the cur=
rent
maintainers...

Even if the field is perfectly up-to-date, a user running an older kernel s=
hould
still not use this field as they need to contact the current mainline maint=
ainer
if they have issues.

I just find this info to be hardly useful at all.

Best,
Gary

>
> It is up to individual module maintainers whether they want to use this
> field and maintain its information. The module loader doesn't enforce
> its setting in any way.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory=
.git/commit/?id=3De69db0c2dafd9206cdc859b0361c6d4f07d77676


