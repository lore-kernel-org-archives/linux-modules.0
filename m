Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020095.outbound.protection.outlook.com [52.101.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FC363C5F;
	Sun, 11 Oct 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724591; cv=fail; b=WZCHryAi1YS/BULm+tj4OvoTHPrSiMxFEiD01bbPOMtm1IGFGbnTMs/12b/A9AkZLHsSAqkAgAvDK2KFw5Rh7MJompvI72BE/bB3f9Ir7b9oYK7bezUO1jTLl1itva9ot8b4bC/Q52dzZtKo4flSHsIMSXhukjTlh68cYqf6mec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724591; c=relaxed/simple;
	bh=JoMDxDp3WvzTgVMaFx9FJNXNXxr4UBVeqQ4On5meBoc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ShRNMbI/SUCgykGAujJbBKtH3+sgNn78T71BN80XdXt9EdMVK4jFGuFukgrkAjKIF+yyXsjmZTGPfXjxHduRTbnTMAia0EM1sRK8sM53UWyMsgBRJpr3kXG0K/1GEOUxzuK1ji+qCy4+GORDx7pDGfSGOrK4LBj3LCmht9jWsBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aUCX6CC7; arc=fail smtp.client-ip=52.101.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aUCX6CC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg+3GLFAjmc+PGlJI5GnAnO/qhjwihNBTDMfPGSQUEOc+peqruqfGfUe1QDmkiZpSlzRoXDqGR3+PP8A045wI8W174LS5ToJfflNZIRL1xw7VQi4ORoUYQf60ufuAsFRUk4OpQOyT764TMrqmY1axx/cwqwrVvALd7hEh/xV5+wk8wy507WZ0rXgxlNGdaQvha6ODLWciefMmy1rQBHivcauHqZnYTmja5awddAKwSWSx38HdEQKSBbGzl6Cp/8/AxGfnIg6iU/08FrbYxnTykjg6nGgWo78mkWLAH8gpQzB8FPds2m6+cSKET1trL7881v7oauedBg/R23urae2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAf1XhbKzHZHJS6bbwhQifCu5fhoHg4LfeXHWbsbxNQ=;
 b=vvCGELX76jbfBSBASr2MqaJvfk/x4WEicfd2XoBi/pjH6oKm2kLmMDwusipERuONmTp8GjsMzI2Cv0heo2ISfS4fxfBLWclWJ9VtyjEcJeBT2hOilTCg8BsmqNanfybDxRFhbo/lVCHwnyxjAy89qGi8Jrr/ZsA3IaXIYqJC5HKTnH59zbleJvE5f6/vOXjo8SLFLD2uRKqhJPui82UGnO4lrcl2Rq5vNmnbyD7hvgP9ImfA59zVn5JEvR/KTsOsCs/YYAdPcuq9EN6AnvjbqXjLuoZcKiqgZjgvvihXgD79LGH/SrVZ9mm23CAfdg/ZaEKxWwUGjaMKQS/Lv+wvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAf1XhbKzHZHJS6bbwhQifCu5fhoHg4LfeXHWbsbxNQ=;
 b=aUCX6CC7eyoP+BwY23HiWauZWnDKsAdeZvTH89/X+0OysT1p7PxRmuCX5oZTAH8xOllEVbYp4ZC5m6tzuMpI+kQtqELWPjkAfKMpbx2cQmL5RHK6qqYmKodPgnEdvwneBdbYnWXn6RaumV1tofVMZ18tZIDG+wgipQlXJiOBgxk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2289.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 13:16:26 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 13:16:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:16:25 +0100
Message-Id: <DM21CVIBHTW9.3OHGQ2ME5G89V@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 07/11] dyndbg: use READ_ONCE()/WRITE_ONCE() to
 access descriptor flags
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
X-Mailer: aerc 0.22.0
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-7-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-7-832e4039b71f@weissschuh.net>
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2289:EE_
X-MS-Office365-Filtering-Correlation-Id: 251497b4-8271-493e-e36e-08df2799daae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|10067099003|18002099003|22082099003|921020|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	V2UUZtwlOK37PXr1Gxjj+rmDLVWTJKb53Qt4TZQTcx6XYgd9EhcHV1Gn81AO3kRHBu10Hyxm4cUok8MFRkqTyUsnAg9pzqFaIKIYRLx/bvYrk6J7To0MXDUjiyXbHfB9iCPogq6+KEwnShGq9Xv0FXKH853JbO6QQVh0N9vLcyMnQc3smW/SHaltQUKDTXWBY9wYN2V2ip9NTwFn4GA+fyGZXoqp/L7eZmkPVynzX9NCUw/ZzPzOH7jiX1N3UzQPKD9pobyIWllbZI8uyftuwcmXxFA1SzocWgo5Rt2JKr7Pfte4wE8rME2rLooMgTLoeK0InLi5R01YbOXdn3qD7Gt4cYXRm3H9KjC65XKNN/JA92MQeIiA+MyMDaiFKN5Z1GPh5gwwsz/oTgocfszJX+9v700UOcjKzgrdwD6POjqdjAcjb/n0GujZaBowCZuc4acLnnUIooQawjmCHAotTj8IWV175vpOw/Vhimd1k/qG2yYM0YK4ElInJ1beN7mVnhxiwwE458C+Akp78VVe7raIVy6/ffc9y89zz/dGxAYlB6heJ4TCfyzjzWuu24G4/MgcTP1Y3wgXVyJ7RvJ2x1+wByZNUMb0Hu60c7Roz26omkTr7EaOcltJ/KLn+olLvtUpky1KESR7elYw8rd1lLRAJ5qJp5d+vj/qD+88UF784Ht+ZB0MxMo07vUkeFxp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(10067099003)(18002099003)(22082099003)(921020)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFE1TW8vU2luTFVkNVQxZGJDNkhyTkpzZTIvbm1EWDh3bDMrS0QzS2dQOFZi?=
 =?utf-8?B?YTFPV0hHdmlnanpqS0xGcGRMK2JwR1RUMTZ6ZUJJRjV0bERQYzN4UTkrbnBO?=
 =?utf-8?B?Q3ltYmRaRjJpSzhYR2tEWnJmSzRmNGZuSUNOcDVjUWhSd3I0c2FvS2NxcXFY?=
 =?utf-8?B?RTJuWFkxeTBOSjlOaTIya01qZXNVUFp4czFqTjdKcVVWVENkVDZmTS8ySUJW?=
 =?utf-8?B?empLWG5nZHNsc0xIeHJDdFBwRmNFbzY0YjJadGJ1VVpHL2N4eGxrQUZUcXBF?=
 =?utf-8?B?S3dhU04vUU5LTXM0VVRnSXdiRlNxWVF1bDkrKzRacnJOQTdmT09HNWxxb0tV?=
 =?utf-8?B?K1NxTzBKcUkzeTZ1YTY0TVB5ejZLNmZkTHZBSUVkaDZpQ0d6Znp3eFhzRlNV?=
 =?utf-8?B?VURVczh0WWgwOWJPblRtYWowT1N6Nis1VHRVZEVwOGkwS3F5WVRVdG1zOXJP?=
 =?utf-8?B?Q1JtVmZDcUVGMnE2QWl3STU2d0tlbVJpaG5IMEtPaWRrWm9UQmxDc1kwemI1?=
 =?utf-8?B?aVVza0xUbFcwUzBCU1RKeUgrR08vM3pWa29iQ2dJbVlJd0l6VTUvcXJsV3hl?=
 =?utf-8?B?SUlFSFVDbDlSSW9QdFEybDJDVGtyaXdmbTVvZ3loaElCajAyK1BzTk12bEc4?=
 =?utf-8?B?SDVyL3JUOUhuemE1N0oyTlRUaWNETG02RW1ZQ2gvSHVZSC9zcVhERzRjaDNh?=
 =?utf-8?B?dGxnSU0xWXBpUEdKWGZ6alBhMlpqY1ZiZ2pOMFd2TkRnV0hXNEphODBCWS9U?=
 =?utf-8?B?L0VuR2VNWVNyZFcra2dQWkZmeUJhSnZYbnlMOXRRd3l1N1N6QWJLdG1lZ1E2?=
 =?utf-8?B?a3pxU0QxUGJDZ216aUMrUEFKaDlFekJRQWZObmUxdVF4NEhjMWE3WVYvRFh5?=
 =?utf-8?B?L2V4ZWhndU9ERkc2aGlPRWUyc0JoQi9MTWhydkluWnN5cjJDMFpEVnVrU21i?=
 =?utf-8?B?aDZOa2JkSndVVnVJcnZKUjJlMUZ6VmZhdkdRMmpaUmRGYWZTVWVDb20yUHlr?=
 =?utf-8?B?MWY1KzNMVVJCVDVNODVKUUIxWWZCZE14VHBNYnlzWTdXRlZXYUticXV0VEM4?=
 =?utf-8?B?VlJXRElTai9sRUJjc2RZOUpCUHYxU1YzOFlVeFZZQUlsSGZkOTAvWXc5L2hK?=
 =?utf-8?B?QmNzaGdLQXlxVWhoN0ZyYVFNeExVL1FyeE01NUdpZk0vQXhIOFQ0aVBQZ01E?=
 =?utf-8?B?dUl3Uk0rdno5YzM4TlVIZmk1L3dhVkdnZE9IeEVGQyswTGFVNWRFTlJ2ZU1q?=
 =?utf-8?B?T1ZYNXV3dmRFbVJUaVRCYzUyZjBXZTZTaC9oVVZLTktKOVhuVjNLejdiNnlq?=
 =?utf-8?B?ZUd6clc2Y1ZDeTRJSXB2S1Z4Uzl1c1RGYjBiTnN2M3lNWG5SQjAvMWRLdFdl?=
 =?utf-8?B?bDM2UE5IQ1BPSEsvSnNqQzQrZUx4eWZuNDJxdytkZ2taTWd3VHJJM2RXMzBC?=
 =?utf-8?B?akdITmlOVEN5V3V0SklGcXQzaUl2VGRnOWVKb0JyVCt3L1Z0Rkt3RDN0OTNi?=
 =?utf-8?B?K2JMWFd3d0FIcUVHbi9qS1AzS0swUi9ndldJSURLdEkxM3NkQkt5UnJrN3B2?=
 =?utf-8?B?c3E5ZW1iZzg2MllLQWpaV3dtRTdSclRSV2loaVhaSGwxVVd4bW5LT1g2VU16?=
 =?utf-8?B?YlMxSzdnZzFNdklDZU9QOGVEdWY4eWxOdnlaVWdad2lzUWxIUnZiUjdlSUxj?=
 =?utf-8?B?SHdBeVFaVG1HZlBqVC84ZGpoeUhpYkxSRzBZVkRjSXZJVWdxRmRkVTl6Q3Rw?=
 =?utf-8?B?S09WSm9va21SU2RJaTR5WUJlZCtsS2djQmtSUlljaXdIUUVCTmNsVmVOMmx5?=
 =?utf-8?B?VXNtTkQ4dHdYTjljOERHcytmNlpkK3poZ1FqcnQ5WXhrUjJFZ0w3RjhYUHA1?=
 =?utf-8?B?c0dMRmtMMkxtcENiL1ArWUFwWkpOQU9KT2FxekhsaEp1NkNKMUk5dTNuQ3Y1?=
 =?utf-8?B?OWxza3NFRmxKNlNCK2ZFQnNzN2djbGtkTUxCeHROWDZMNWwyY1huNnRVZnFI?=
 =?utf-8?B?UUYwWlFyNlQ1RWNYS3pQTlczSTlkSUtteHREejdvRmxvTXNhQk84MmtZN3Z3?=
 =?utf-8?B?ZC9kMUx3TGNEQlNrZnVKOGx4L1JLcE0rN3MwMFM2dUVQMEgyMm54L1UrUWwy?=
 =?utf-8?B?dWlxWkNkcW5tSk5iYTQ5Sm5ST2cxb01wNUc2RnVSaDlVeUdwY3E4UkNYMnZ2?=
 =?utf-8?B?YzdBcWs1MzA2TnVTVVhYNlF6cW93MHNtQjFEakQzbDBOck5CTlpDVC9RTTZm?=
 =?utf-8?B?UElaSnBrdmVvb1JNOVlTYlZ2aWNoSWdBR1hqSDhtY0NvSlFsZWIvdks0R3Ra?=
 =?utf-8?B?T1M5VStLc3EvaHByMTltWHUzWDNJY05nWVYvSkN1UU9zaG5Eb2Q3QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 251497b4-8271-493e-e36e-08df2799daae
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 13:16:26.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWiRLSEGJWz7YRfnjcfMIybV8AqitAy6CIHBqPG8SfeCIZr+83Z4lBA70j0nNG+1V2K6POEf+cFq6sF5jeORYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2289

On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Wei=C3=9Fschuh wrote:
> The descriptor flags are accessed concurrently. Use
> READ_ONCE()/WRITE_ONCE() to keep their contents consistent.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> ---
> I am not entirely sure about this. We are only using single bits, so
> torn reads/writes should not matter. But LKMM has no guidance on this as
> far as I can see. Also for Rust this seems to be necessary.

Code should assume plain writes to be atomic. Concurrently accessed data sh=
ould
use READ_ONCE/WRITE_ONCE so you're right on this one.

I think this patch should be merged with the bitfield definition change, th=
ough.

Best,
Gary

> ---
>  include/linux/dynamic_debug.h |  6 +++---
>  lib/dynamic_debug.c           | 24 +++++++++++++-----------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>

