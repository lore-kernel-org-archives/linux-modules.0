Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021086.outbound.protection.outlook.com [52.101.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE135C69F;
	Fri, 24 Jul 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861604; cv=fail; b=M+44yo/cel2rRQeCKXuwz/F27e6WKjg6cNIOHnR6qoeqs5RuV5fyhBDINN+/q6g5VFdl9kJHIT+f7jyJVJEOo1VJECnM1HFfsOCbNfbN3OynLcpYw3kbWEaqntSRKyIb8EbMO01ryFoHy/pw69Y/tQ7++c1Po7wYehCNbrBKluM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861604; c=relaxed/simple;
	bh=9W4cd9QF0oQ69CHzWxPPbZ6IEvEhXHJO32APrZiz14w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYxAmigWGVkVF7JRPNHkcHGe5YWUYDrrtEkMApoEw7sn93zlBQkfzQ/3dAtkC7Ah90p5t7D/I1c3KGydwaapSBR+LQvEMfHdtndbwrVZHi7+xfi6TQlkmmjYQ7vrbLaLmd2visnGMzvmkW77jWP3wdoQN7fCwBjUUeNHCpYIlnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUzDHSLZnkNAMWDgf0aLC6dcY1ukLHCPbQvIpUSj3QObCfeOI+Igqy3VZBXDVOIm3QquJ4qsI+ZcqLExUMBl8+eLS1/9XiQKkfqTupIyckiZCno1GeAz2pdfgU/22GAv6FWaln+xIVD5NAOAL6Xvn/DGj7GquKrxq4wSMqnD4tp6/S5wH5BKEQLO1j9uiZ0NcVARAjr3Ez4shs4yVlkvibkJ2COBhvgX9hybBLiKlAB/95hzTS582e0dPTlIb5SFgwxte5NTAYbJYQoru8k3ZfxeN9k9/XLYfi734QIiQnzDwQ03cQ7s4UiF/0MrvVVXhAxnLXzhjBdAzvOOwcNAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GhGHcDwa0f4XB2M0C0QVoPsa4+BzQi1rEyO2GQq7Qtc=;
 b=XDnS1vx2xajcB5YpD7iQ1lrxgH1Vf7pdi3etZs4el08KL9iJXb3To5b9FSkRtfh4Q3qi9e+gSG7OC5Sos8EkKjRF8vhRZYfpKgdqplmuL84ofYFHf4bG7z6gaTaBbqd7ftVqTcmJeugW2+Ee+Q+Z4jr4iWYMKaKVsjN8xWDvS+PZcDWGZ+o1R9hcuxsttzsEBJc4AY9SRHQCKHv/YMUOihw0ExQUlIvMwBEYgIfxYKf0inL74qxbSE77At3DqAjfAsktLGgO4uKpJ/CHaSTQKbIkrte+hfj4NZFrwuQiMHZ8ITS022LMLXmYWTfnw+e51xM0wMDvweQOC/sL477GSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8488.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:53:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:53:16 +0000
Date: Thu, 23 Jul 2026 22:53:13 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] module/dups: Avoid unnecessary kmod_dup_req
 allocations
Message-ID: <wci5eeu4cchnpf37ohadhcemwmvoeyvaux35kzb2ucp2hz25hp@svqybphsnxoi>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
 <20260723-module-stats-rcu-v2-3-bd582261fae3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-module-stats-rcu-v2-3-bd582261fae3@suse.com>
X-ClientProxiedBy: BN9PR03CA0666.namprd03.prod.outlook.com
 (2603:10b6:408:10e::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: eecc03f5-853b-460b-90c2-08dee92eb5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|4143699003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	jiIDh0df5UlLUd0ClOD+Gcyhfhw1sHKZe2qDrKOG8GGsf1YBj5AnZmj5Sx5OZwWb36QditPVu95y0ASmfttTGZ+ETM7drLRaCrfIdx8a8sjlFkknuID6lEzh1OwwXI/mHHqwX8Ix6rn40wY5RiZQlFkkQIaUI61zDZT8Yz0QpDtIyWOffagXUy8n8Uxsut4bOjZWlIXB/LVIKYUQRFgUfKPtqgm2DSKYx2fkLxFx6N59MNlVuajTTeNEOIOC5evfLvLmz8q2/c4/ERwgj8+XP9ov7B2xXMpavQEGpgm2csfmsJQgDXbcFAGql0XYnVApRyK2AQsRmXrVLOwp9FddLGgDWfppjwyYDejXN1Pyol6AjJ8AjQCgUtbNC0yTP9AqLpN7KTP5Ea4YqbkLZs8DU6bd+C8i/65l9fRhNrbcfnUCvjp/0LNPROsnYAc2tfIVZRZb1dx1GpwAcIx3CdfXn9M7dxw7iPQf/YFIgr7GYFrYfOHumAMzITmBqk80VyPwOYRBLlT8AtNPaTANxbP7WHjD3oVXhnPu6FvcrJcCvq+ueb9RhZ+68UUUMzFhbrhcTvFi8KbNfb6yWkbTIlY7e1z1mheijlqeLSiWjLkXzdEJvduvTmlIBHNYsGeCY4z1JzmtB2Z6l7O9/RIMShBRBta1mGNLmId7SyWx2PEfWYrXFu8w3n/Wrb/vpemkZ8zTAztBxCphHDgp+V+psnfuRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVLOEZnSTZQcGlzUWpPc04rR3dXNXdjOEhzOWswRWQ4YURhdERCZGtaYnph?=
 =?utf-8?B?Vi9tcUhEcVhaTFA4cWFwY1lzUU5EejRJVURUQWtkV1hCL0h2dXp0THdYQWZq?=
 =?utf-8?B?Q1RwYlFzbW5TNzVBQUM0SGxOaW1JR25OcGdoL052ZFdSVG01aWZVSFRRajNw?=
 =?utf-8?B?cDV1TVlaWXp4bGtXT1FuTHlXYkhHMW0wYS9PQ09ueFJzZTJRU2tqbUw5S2Mr?=
 =?utf-8?B?Y09qNXN1a0wwMGRSVmN4cDJoMEJHOVpBblBWWDZ4VzIxOE5DZitTbTdjTDBV?=
 =?utf-8?B?MSszc2JQZklnYWsvU05NUFJ0ak9ZZ04vbkJLRy9Pby80dU04TVZncFFaazNy?=
 =?utf-8?B?aGM5VXpzK3l4OHVNUmhPbWtBSGQ4cjRCQnZGR2tQVk9rWVFtNDhhN003RDJr?=
 =?utf-8?B?NmtuckhvTUdCaXpFaHBFSHB6bzRoNnowbGFGalBaNXVlZ2RYcy9nK3hvRFlm?=
 =?utf-8?B?VExZNXVQbVBMMytWNVY0K3VORUVRZlRFR2xIRWdnOHoxdXBNSmFZRUZDR2NI?=
 =?utf-8?B?WHpiemRKRGlrZ1hFRFo5Q3pGZG5tZ245ajdJL05MRndFWGovN2Jmc045Z3Ns?=
 =?utf-8?B?aDJwMzkzZUo1UnFaV3hjT3ZZTXJCNkpaZ1dqWHBuNmowYnJSVkM1VjJ4dEZN?=
 =?utf-8?B?QjVUaHoyN1dmSFBHcG1aVmI2NlJJa2JJSTFUYWVhd1VHRFJmWGhrZzdhVmxw?=
 =?utf-8?B?azhoMFoyS0ZIZW9FZ1I4Y2lNVTR3ZnB4MFY2UkNIMmdpOUVHTFYxdzN6b1hN?=
 =?utf-8?B?VzRLNlg0Z0tTT2x0T1k4R1ZjQkhjN0NkUkNCTkJ0ZW5XM014ZzBCYmdqT2lz?=
 =?utf-8?B?Y1BzV1RWQys5S01VMnJ1NUNBamp3ZGlTWXZsZEl3QmdJbGFqVHA4cVE2c3Fu?=
 =?utf-8?B?dVUzcFhBL0dGbzMvaFdWcC9NbW1qdkVUOWRKZGEwT0pFc3Z3dzBhQ2I4T001?=
 =?utf-8?B?ZEMrbHpDclhoK21OeDZpUFpmZ0E2OTQrNUZaZzU5NzJvczRuSDhiU1c2YXhL?=
 =?utf-8?B?TGQ4aFhHdGZtRDdhWjRpRGtLbC8ybTIrbHRTRnBpUVE3V0dqbnZ4MmlLUmIr?=
 =?utf-8?B?Y0NtQWxaSWhjWi9JZzRibWFFVFEzcHBRNm5QMDBnc29nWU5nd1QwZkcxRFpT?=
 =?utf-8?B?bUlLNzgxWTBuWThBL0gxZGNlL2ZrMlY2NnAwbDc3eFNmc1hHTmJEbUJSMCtx?=
 =?utf-8?B?aTNFaGttQlFPODdOVUpvWE9KWkt3OGNUT2pGZERwNEZQS3ZMS1Y5cFJYWkVU?=
 =?utf-8?B?ckFHSHkrRkl6K2pWQjNHeVhXSFg3ajZPY0s1YmxjOEY4dTZTSDFoSVU1bnYr?=
 =?utf-8?B?YlBMbmJaMkVQS3RkZS93L2U1SEdUV09weVlZT0l5dVFJenkzRnptcFBla1pO?=
 =?utf-8?B?SWhEQWM5OTBzOE5Cd2dPcHlJM2FQMUd2MGlrZzExTlF2M0I4VVlOQlc1WVRt?=
 =?utf-8?B?RjBSREMxY1RsOWFnVXZiRU9Wbjh5eExzSGNaS1FUWHhsQW5mMzVQRDFBQUVv?=
 =?utf-8?B?alB2Y1RoaExBK0NRclUrcm1BcEZPTVBuTU93SExQaVJYQTRzblp3RSt5aG9y?=
 =?utf-8?B?djRuY1FvQkdiSGJ2Q0lSQ0dqWGRWTDJnUE14bWF6V3VGMGF1RWI1WFI4dmxt?=
 =?utf-8?B?bzcyYVp4SVk0RkgxMExzVVBFZHV6dVhTY1I3cTNKcUxpYURnRlU2a1gzSTRs?=
 =?utf-8?B?T1RZMG5pcTRUVE5weGpuUURRdUI4N3lpNERMWTZ5VVI5UjJRdlpqb0hoSVpr?=
 =?utf-8?B?NlZtZ3BxSVUzMUJnOURYdlRqbU5tUER1VU4zelk2RHRTV2VLelBIaWM5b2sr?=
 =?utf-8?B?S3JSbGt4aGtnYVVDSkphNTdVYXpvTzhDcTY4VzJscGFNQXU0MWVTYUlzWk1C?=
 =?utf-8?B?TFFVbjJoMEZ1N2g5K1dLb25QOW9JTU9hSk9kUzRqN1B4Ty83T2pnbk53SEJx?=
 =?utf-8?B?TXZ0bW5DMlc5NURFcm1nQ3FTSXA0TnFuRFEzTk1EVi9mQW1McEdPcWY3MmJo?=
 =?utf-8?B?V2hEWktyOXk3OUdmb0VNSWM5NlJPOUZGQ0EzZDRVYUNFbW1tbm5Jb3hWN2Fp?=
 =?utf-8?B?VEVWZ0toYTRjSjZ0eGpHbzJZTkRqZC9YTmVBQjdhZFVJY21Ia2hnWjl5OWdy?=
 =?utf-8?B?ZTRkM1VkcW9EajBoTkdYczNXMVBWQ2FXSjYzeHFUOHlMZXpCdlJXYi9zY1Zw?=
 =?utf-8?B?cTFURzNkejZ1YU1NQzJiWmd0WlJ2Y2htODBNNHFoZVhpNFMxajNNSGtWeklr?=
 =?utf-8?B?UzZ5S2dla0VMakFzazRoNEVoTDFLNDcwaGNzR1ZPL3pVM1MzcWFjUmlHVmg1?=
 =?utf-8?B?TU41Zy8xeFdickEzajhmYWM1RzY0Tk1xT3hJdHN3R3plNlZGZ0YwQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecc03f5-853b-460b-90c2-08dee92eb5f6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:53:16.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppGZcMzTS6H/SBZcjIgbTMmQ+xLwsuH+j2v856P9Vb88wch+u1tafwiXLj/CxlevLqG01aMKTFd0TMLPtnEKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8488

On Thu, Jul 23, 2026 at 10:25:53AM +0200, Petr Pavlu wrote:
> The kmod dups code preallocates kmod_dup_req before taking kmod_dup_mutex
> to avoid allocating memory while holding the lock. This provides little
> benefit, since the allocation is fast and can safely be done under the
> lock. On the other hand, it leads to unnecessary allocations when the
> request turns out to be a duplicate and slightly complicates the code.
> 
> Allocate kmod_dup_req only when needed and introduce a helper function
> alloc_kmod_req() to initialize the structure.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/dups.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
