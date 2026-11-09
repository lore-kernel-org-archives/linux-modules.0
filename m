Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255043;
	b=GhhnLMjE6GzbqTeHRFpB0ERK+niTVvBtgQ8a4CfExQV7ZbCCGGTIr/pG/7CeX0sJ2v3q
	 vW4VafutbVn1MVcYJlGrYcA/coxFx/iK85U2z8EYAoPpFYW7YM8bMY4annIoZcUeoCOY1
	 ZyjjPy1I27ySTaXbT+ftmTrC5FZgCEskoDUJyaly6ZsbwCqPGavnBshP3kWf61/E91Uax
	 pRymQQ0z8lD7wpjNYQjlCHS3z5YrdO7rod5UXPqKs2vpybHtJxDItfrLU/XHw1peXIteQ
	 CfLKIpIpgbWOwtTdzYFSQXZ/009Ml98SkAEFXtzcaohn9MvlpsFKuMS3POZyuzvwCVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255043;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=shRigheOkhVzTnH6VFU20bWLWOBU+elQGcy8L+H2zAw=;
	b=NTS0fcwCKF5OLme3wlkN9EdBXNfs7q1Ejs22SxMeHEYsJmrb4tmZq1vYjN0CGWjvuwlP
	 J+tSlEelfqbbvRYTwuw0ClKAjrJ5Kk2mDpdzcPNCt60rjUiWE3tEUebgAA82TQUtm1iK2
	 Eohx7ZJLes6CW//KNRAZseOu1IFNny9wH02IRpWL+dMDhknRzqj6/LWfAPsyek0GbwGSS
	 gd6k356dySC++mcN6gyUVnG53u4RBT02WFaW9v2arijZmjmR3rgSa+0Pq6cEBpuiIOhxQ
	 UtoCbAHpSC1oW0ThUazgIxUMG7QukHoKAOv1kLS6bCl0rOVRJTMDPOoMsjHtFTMxQdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.108
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022108.outbound.protection.outlook.com [52.101.96.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AB606A31C;
	Mon,  9 Nov 2026 20:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA0AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndTLeDEllL+fLvfji4TzXlxa/hMwWfb5wNkNG/Jpl0FcakXecT4jtEmJFaLYkckoql+0UTjcT3VzTLgitlLYnM3P5UBmJde+KDU1ai3Fb8dbpAKQk34CuKILDfuZk8DAbvmH/RHfvNnte/LN4LGavbkjlmz782+ntHk5iWzwlesdASHBQrDW2SpTPRuq64iLjcgJDggd5IB3YPA1heh+TlpaTi0jiafBpqYrlvgaRnO3Ti/0nJnHWacTVcgEIuVgYAonyGk2okYJIZ4MURMWKPRKss2OQH77+e/r3tkE7Rizh8wgZLSQTzdfMrWFezTarF1Wwrhus7Jqdi71pIH3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=shRigheOkhVzTnH6VFU20bWLWOBU+elQGcy8L+H2zAw=;
 b=tfvtMfFdD/NV/hwtuZ9YtQdMipLV7WrclGDHJjTDsU+BTXPIa8NogiN9vXnLm54nUcTWbDmtqSIvyhwbVjAlfYhNyS4rc3+uAU2fkWDY0suoXsom2d8R0eyIwuqAkQh4EMxCaqAJS/q6/FBmSI/weKDkqhxlL9YYlazHh6HDg0EVKFMeTsQ1gEyMLKKLDEQUqcQYvksOmmOMyhEXNjeH6PBY9WpDkn1z0PjtDjF5awPiK2/C4893TxczW7xq3RrbarvEoc+Mh8i9XKY8LqiMXnBNfhiaChff5pZwj0n1yt/B5nERzZiKvHz6LmrD0tMaeebIf9R3XhkxYibJQzOdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6846.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:308::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 20:10:38 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 20:10:38 +0000
Date: Mon, 9 Nov 2026 15:10:34 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	da.anzani@gmail.com, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
Message-ID: <wpz2ue47m4ikpnb5kgpegxt5ifpdqrzjmi5por7crvxcmsfyw4@olqe6bj3xcub>
References: <20261022184517.66438-1-atomlin@atomlin.com>
 <2fd1031c-7a86-45cc-a595-bbd13e102d43@suse.com>
 <zjuuet74suq7dujrlt4pfeoajtksegfrslsmokgvfjg6o6pghk@dbifrqvwrnaw>
 <97331297-3f78-4f6d-ab24-61cf329647af@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97331297-3f78-4f6d-ab24-61cf329647af@suse.com>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cdea90-db02-4203-70f7-08df3e9d8593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|261028144727099003|261009223027099003|4143699003|261026140227099003|261026121527099003|56012099006|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fd+WUyRA0np4e+L7UQ0cI2wtT++eGXNlh5ZJyrbRJNnK0kDxwPfDsaTsI+JmHy0XU1hTP16xW3hMjeUmF+Ava7IfaGPihAph7IOhLVXGSAt1Ym7D0Pqpz4HVTkuX0MKHY1EotliXcMypNfi2G8H1StdjptIx/+SCxkikKlcf5qvS0P/Z/WzOTnSGxRi8dwynehC9zFEbQlOszfQc2Q+jJsDOhZ/oyZVWZJXGrcXaoebOAn6/fl948ho/T60BVhIpA7QhQEXcUPqT/Y4kHa67u0IwnRudXNwGOwyYBQA/0qEQ/Vp6iWL/YkGh6tPNu8E92FR2VKzAejNhvnTsybD8q01soPrMJnPvTR6h6jCOqRMlCZH5Hvka0ZOXiaM/aGqxT1Tdnbf4mlwRYhoodquBjKxBeqJoG7mbJni5hhm+ivNaKhaItROZfMFwbDvNzFagk8YMYtyPjOh2B54tT/KeX8HGu+KbtNZ0UsHWj/24ILNtWhyTKt1WI6VQ8WkI+6fIROoDJ65EFtZzryv52i9VGQkO7R0EHKh+PNpBb5SDh69m904oSVpxvf16jepQKxW6fURsIOXn0UoaTm6j+V1ErM8zVjRZK0GGKaeozVOiXwle3RElj8SHiux7PD/e7vQH+vW/5B5EOmoMsiwZph7bEpwMj5X5/KEF7y/PIUWyCEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261028144727099003)(261009223027099003)(4143699003)(261026140227099003)(261026121527099003)(56012099006)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0t5V3N0YTVZQVpibHgvOU1ZM2V0UEhXZytZckI5cVVhUlZ3NHh5QU8zNEVV?=
 =?utf-8?B?aTM0WE02RWZSM0FZbE5tV3BBNU14SUF1bkp1elR5VXdlcng1L250WmlqdlZ6?=
 =?utf-8?B?bG1XcEdjaWVxY1J3djVsZm5qZm9EZWM1c1ZYYTFsZnpOa2RQd1dRLzAxdW9x?=
 =?utf-8?B?N3hVNGt1dzV5Y2VsMEFLWGtxTkFPcVNNNlZhT09iMkhIL0JRK0ltdVZLQ3lJ?=
 =?utf-8?B?UUdPKy9TMjEwVlE5MTJZQTdtaWluaEh3RGdsQy80YUE1VDhtVGFZckN4MkFH?=
 =?utf-8?B?WlcyZ3lXeDBXbDFOZGR5RXRlN3pzdFk4cjNBaW95VUxuMEdWNGhQQUJ2a2ow?=
 =?utf-8?B?bVZrU2JKUU0vQ0ZkYVV5b0ZEc2lXcUdFMzJJVVBldERDMHI2SnEwTmhydDNk?=
 =?utf-8?B?MW8yVGc2QWFCdEhXeGhtdEdKcFFzRDFONUQ1RlZOZ1J4RHpoOUhaUzk0L0hj?=
 =?utf-8?B?MTNmZEpaYWs3d2JETWJmMmhjZEgyWkcvTFB2SUhWSnhaNjNPWENJSzNUalNz?=
 =?utf-8?B?Um9yd2Z0bFVjMnJRYTN0amtHYkxWekt0MjFDMW1yUHpKNWhBOEZlYmUxd0Nq?=
 =?utf-8?B?aWIxelEyZ1pEQ29FTk9GdXFCRUV4a1EvWUZ3VFBJUmdUa1BYdmNFTDEwVmt2?=
 =?utf-8?B?bzZ3VHp5Wmtaa2lXYld5VVdaQmJ4NHNKNDJzU1RqclUwNVNLMzVua3FjQUd3?=
 =?utf-8?B?dGd5a29kaEs1dTVUYlpLcTdtcURLTzBKcXpjVWpKSFJLVXBxU0xvMlR5LzFk?=
 =?utf-8?B?bk1YNjlwaE40NUg1ZUhyNTJub0NVck9NZDlSYjREZ1pDbFFpSW9CYWh1Z1p3?=
 =?utf-8?B?NGgxUHpvMDlLR0duSm1WRk1TTStNYzVGaHdBTU5UZXFVd0svTjN2aWZaRkVo?=
 =?utf-8?B?Qlk2TDRGQmhKbjB2akhuWUk2WUZTUUFmYkc1YU1yS1pJYXdMU2NPZEp0Uk1i?=
 =?utf-8?B?cEZ1RytoTElycVJJak5WOGVWOThYWGppdC81dit2NTk1VzFCSlpsK0MxSlQ2?=
 =?utf-8?B?Z2gxekQzdlRXZEdwRmtEb3hVT0hhSm1CaGptbU1PcGdJdUZMZHUxc3p0LzFO?=
 =?utf-8?B?YjA2M1FJaWVEb000V3lodjVxWVJMTml1Vzh2Szk4YWNNdTlBNFVUY01paWpi?=
 =?utf-8?B?clJMdVljV3BhUlVUUkV1R29IZUVjVitIdmhPL0phS0xyZThuN0dPWGQzdzZF?=
 =?utf-8?B?clFNQVZCRDdYYWZ4blltQnZVZE5JK3ZTM0hYRU9PNm1LNkxlUmFLS1c3RmJ3?=
 =?utf-8?B?d2o4d2RuNkxVNlAyMXhzNmhrUGp5YkVoZVJHTy9lRlROamg1amdUd1JUUU9L?=
 =?utf-8?B?VElCNzZydmNTSnlCV2ZuWkxKV0o0ZnZrWnFTN0NTTkZzbE1jeW5iMWVlQU1J?=
 =?utf-8?B?SmhiZXBvMkoxS0g4M0R6VmRuSHdXay9vL3h6ZGk0aWxyQlRVcU9uYkM5aUU2?=
 =?utf-8?B?N1hXb25oaVh0TlU3dzRxMitrNHR2bWEzQ0xCVkVEN0FLMkplemVMeS96MjhH?=
 =?utf-8?B?MHBBOVhpNmMwOFRaSERQZTVORzV4ZVp3b2JsdUFPbkI1eEhrSmRqZ0l0eXgr?=
 =?utf-8?B?VGd4eVdLekZ3VDNPaGkvRXdQQzNSd25kS09pVUxQMGV1TWN3VmpIdXlEbjdW?=
 =?utf-8?B?V0FYV0NnQnRhbDRtU21lUWsvdHNVVzdCUndoeU1VU2tFcUhHbXoxZWZ1OUJW?=
 =?utf-8?B?N2daQng4SVZTeXpqMS9UWG1lRVVYejk5cjZ2Z2VsOEZwRGhMbitzWkxDL0sv?=
 =?utf-8?B?RGwyOS9IbzVyWHl5SlNpSUNHODlTS1JVOG5JUnpycmViKzVDUWRacE5CQ0Vx?=
 =?utf-8?B?eGdjTU9sQk5wU2x1RFdLbm52REVpd3FCb3hUbFMvVk9rREdmdXRTS1lPNE9a?=
 =?utf-8?B?THdLbGJaYVlNWVl3Ry8rWmVEeS9HU0hxVDZsMDVnVHdlNVZGQjRRY29oTTJN?=
 =?utf-8?B?a2gxazZacU5URzNuZ3pDaWowV0MzNXdxRnAwTFpKSXhUb2JoNTl1TXFFdENT?=
 =?utf-8?B?bHV2ZUZXVndESzlwK3Brc2dySFFZeU53UlRKY2tJWDQ5TkdJNFVPWVdCRkFy?=
 =?utf-8?B?eGJ1djhGd1FyRnVZcDF4c3BrZnh1cGVDK0NQcTQvM0oyTzkydXcvaXB1eWs1?=
 =?utf-8?B?aGhtUXpCeVZRYmNBZFdrd21XRXVxam8vTFliRjN2SlVwcy8xaGlONkNLR1d6?=
 =?utf-8?B?YU9ZallFV0R1QTV5T0VSM0M3NFlWVjZINkpUNUs0ZGxzL2JMZlhlYVZLWlUx?=
 =?utf-8?B?YVJwQi9IMHd1cXZ6VzE3L3VRZkJWcHpIOVJiN3VHN3Bxa0YwUVVzWWtzclBN?=
 =?utf-8?B?OFRtTHVHdElCUjJDSy83THVaNm44KzZ6Y3h6S1ZpUGUyUEs2M1hVZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cdea90-db02-4203-70f7-08df3e9d8593
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:10:38.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRvbgjpoMQLRL/mRn8K3KSljUzd1BWxa1UPyFQtvGfJBKOeQ6CiEf4VPigKj1pFCJQxUU5H6HNiEqNy57Cd9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6846

On Mon, Nov 09, 2026 at 04:16:30PM +0100, Petr Pavlu wrote:
> > However, I do prefer the next iteration [1], since the use-after-free is
> > resolved without altering existing tracepoint semantics or introducing an
> > off-by-one discrepancy in the recorded reference count. Finally, the fast
> > code path is fully preserved when the tracepoint is disabled.
> Why is it important to preserve what this tracepoint reports? The value
> isn't off by one, rather the tracepoint would now report the value
> before the decrement.
> 
> I'm trying to understand why this case matters enough to justify the
> additional complexity in version #3.

Fair enough.

The main reason is consistency with trace_module_get().
It shares the module_refcnt event class and records the post-operation
reference count after atomic_inc()/atomic_inc_not_zero().

Moving trace_module_put() before atomic_dec_if_positive() means
module_get() logs the post-operation count while module_put logs the
pre-operation count. So, a paired get and put (1 -> 2 -> 1) reports
"refcnt=2" for both events and never shows the count returning to
MODULE_REF_BASE (refcnt=1).

Fortunately, gating guard(rcu)() behind trace_module_put_enabled() (i.e.
similar to dma_fence_wait_timeout()) preserves the existing post-decrement
reporting with no fast-path cost when tracing is disabled.

Kind regards,
-- 
Aaron Tomlin
