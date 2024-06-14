Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01D8C07;
	Fri, 14 Jun 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391181; cv=fail; b=AFwwdQiLrNfAP8r0UbdGYYdSz70c8CDNcdZwjRl8cE55299XbK9aS2SGN0caEine9aZ8S5wW6ZFJm6zuF2Pgo4jmUFvSj/z5wpskO/yhMbWOo7eRuArdpN0ZRaBj6KBUUNY/GiJE+HSo6S4KnD73KB7zwjwqW0INCpi0KQAEkAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391181; c=relaxed/simple;
	bh=CbGeJQs5DoVkFujk5S2K+6mJu7VZiHV1t7M+moXTH9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2tzzNrxe2pbxDf5MYKo2qQQaoDdlC1hirJPHGcwnMc2BhQqjkjXn6H9OcNqTlhF/5lXvPp3FBAJ0P6IS6bnbfwLfvBqPpYc05DSI/+2IVIkFgDPqOf1URIDg2tj7pDTtk0Z6Vli2OhuZZiM+w1KyGUZgVeGcL6IuGx5Ph1Ybl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh5Yldww; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh5Yldww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718391180; x=1749927180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CbGeJQs5DoVkFujk5S2K+6mJu7VZiHV1t7M+moXTH9E=;
  b=lh5Yldww12PKkzflxAJsqS0JubF58G9UgwRO45VdoeJ+L4MxWB08BXVB
   owFDOuNmfwYgMdm73CYQ7YdH1QWGv4OHc8W2l218rarDYsmYy6uPJCp1v
   AQhyUK7VpA8Lvttexy1mazos+ewpVBWjWR1sfp81rtaqJn5ROH1UTYv5z
   q7wmTdXpPaC4e1hWjICEX985v9o3HkQ5n9a2byLorymiF8J8EthpOaUfp
   uB47g62Le/QXoQswv+1o1lI6Xd6vR/CZieJHD+Tu5V1m2RxxlVGg1pybT
   LokmVUby/1H1cUqVLRH4lx6cD03wLNBjuOqneHCJmLybVUaSOuY5eX3B4
   w==;
X-CSE-ConnectionGUID: mAElaIQnSCuIj1DLKtoXWg==
X-CSE-MsgGUID: 17QDTVJnT8arqse27RO1Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="25972966"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="25972966"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:52:59 -0700
X-CSE-ConnectionGUID: XywDuiWKRluyYWAQui4M8g==
X-CSE-MsgGUID: CLrimKafSzKJtA4ZYNUf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="78068671"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:53:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:52:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:52:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:52:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbTo8hj79VaZ/l32uRv8zwv2i5z5AtUvvmgku9D2I9rtDQjb8eRviqcDMraS/6iHW3CVtD71LnE7pl09SZie5oA3tzM/Y3X/sbSZlb8ZxeN75ADLTJLqukAmLG7agQKgwtQCfl6ZqCp7qUTYLPsA6Wz2y4yZ03lZcBi5opVLsK/L8wdXzkzLzJuAn3o9GaurfZcmDVtTRwH9ckMiWElbQ201uJ6ZKQYQxuLyoofGCSCNwrLCLIK723kmJdb1Kd9frDcQIyXJvAPLZriLpYdxinlOlpS2RmnqLs2Buvxa/Ct8AiYlljuXVvvD5owXls1qCb1uwp5bOOU0H6f4djk8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbGeJQs5DoVkFujk5S2K+6mJu7VZiHV1t7M+moXTH9E=;
 b=PTTy4lAJBWsRcI/YsL/H/ZRfDpWDCemSgF1dKKHF9F2c8z9qD6WnhaM4GBoDAVzdg/ayjzFU6EVupeC+jiSm/Djx13zkexXugFfQX89gACBcii0nSx7yPT22q0lL66w9MYvqdutw+40yJk1h4pGoPEL/VifvLygt3IO0Ch8koTUD1bnAk0YrOiM6MH5eDk4WLPsd09z826bym0NAsGn6YiXGENGKmVPNrXljqu27ZXWzBfSCVyZlqahPW1cHI0g/27U1+oKmoJe1+SHqgX9MViPawvgMJXJeT8eN4OmjkvuZ9u67+nmMBzqBiznegVYBEO7qMKx9Ght1qnwvoITz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:52:56 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 18:52:56 +0000
Date: Fri, 14 Jun 2024 13:52:43 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] lib/test_kmod: add missing MODULE_DESCRIPTION() macro
Message-ID: <sucdcnemshoiwu7ybjpwnurnylm2zzayx22ez3xkiudv62gezz@5j7t7hl5fdhm>
References: <20240531-md-lib-test_kmod-v1-1-fdf11bc6095e@quicinc.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240531-md-lib-test_kmod-v1-1-fdf11bc6095e@quicinc.com>
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddbec24-c263-44b3-d0a2-08dc8ca333ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VO8JUvUgo/Pm0bLZYiRHo6Bpgkwzl0jpcYpgQ+spgZV0I45LXezchRnuadcL?=
 =?us-ascii?Q?m8OdKDahzL1N+1xozpG3X+kDa23JtUOYoKDiS4vZ3T9AYtD7LFRWIsf17tzF?=
 =?us-ascii?Q?DGAIgx5RUxD4+6mlT309OITKbn/+oeFgQWel/U7/K+xtOjngII+UoBZgb9WK?=
 =?us-ascii?Q?g8AxStZXp/kTuJkyP05Hri5RxOyQ7+Wu98V9xjWBZQTtuD+LV7kzYyaztvY2?=
 =?us-ascii?Q?7QCPc9j/Kbf+GYz/RxlMflJqn2+Br/EsnwEW3ZiBDfNv+Kd2vImCKKqL2DeO?=
 =?us-ascii?Q?7cGUJE9o4fDA90f/N5ZqECHblRraLi3LoOoCAey+5BW0AreN2pMSBCi5ekiy?=
 =?us-ascii?Q?s4B+yAwqaexwJR+GGWVtnui+pKa3r3yq2V3eqirNkm4R+v7umiNi1+6QfOxY?=
 =?us-ascii?Q?0kCJcDxQ7PaAWf9IxqXj3GnB5F2Fs7HDnrIAzldyE5ugsQ+qPh5z4XU22BQz?=
 =?us-ascii?Q?W3uIjrOh9Fzkd/904hUdFiTDYOoic6nAovPm13Qjg8R53VziCxalVqTsn9d8?=
 =?us-ascii?Q?I43AvA33YjpF3ekV1Jl635pUB3iFWUd9a327t5BLooz45L/bjWdKRk9FBrDv?=
 =?us-ascii?Q?LVEnBn5Pm+ovehjVoXJ0zQwRLR7xrpxTbW5s1h1UhppS5+KoVPpnu44ic4PC?=
 =?us-ascii?Q?jpEpnwr9yENLX/0nlrC3hvbcrSlPALLoRRWET9GPyGrfsmR55vEXXkc0eO40?=
 =?us-ascii?Q?OSwBVGfyw7l3NVwT4I/UKmDa1zJomrsTjLMF/I5gtDv/mb+eYr+0P2ApYhXd?=
 =?us-ascii?Q?FdW5xXqV4Yr5qaAvJIM93R6qhKgbJw3mxNUTwkmVfPvvCOMDblfTJ3dIpEOp?=
 =?us-ascii?Q?dvhZ4kENAdHZP2IOwP9KoV5pordW4vkk5LwEj1UeUZ8WY06k41fx4i7Q45BL?=
 =?us-ascii?Q?Rb+G/UEPPhzPZ+/reI1jrUo1Qfe26aSYjaIN+VYla2mbaEpQf0ilfPzX+e0L?=
 =?us-ascii?Q?8fyWC7ziX7cCnkZht7lklrzO7aGqAXmJeK1Wu9Xue3mxJc9AjIYyC0IU5peE?=
 =?us-ascii?Q?Olk+8sebuDpsNvJmF3gZpY7cZ7mWon/86YXSVzhhs53AkpjQvFcqCcknCI+T?=
 =?us-ascii?Q?ARCj3NVNe8GmMYCKJEvw0zE1+eNCoGASB80m3gLQSIDNgnfuq1oUFrAXiYo2?=
 =?us-ascii?Q?dr7R3SUUv52GQxsCjgErN3LTog/1y5H/HZ6HK8I9hm0SomWHXy1TOTqPXt2U?=
 =?us-ascii?Q?4gPm/B6jByLByVSTS9VyEJ6ovWtjKmXxV0LxvWKb1PrUqKK0K7eLD/zkc1N2?=
 =?us-ascii?Q?61bc+1ROcM587MYBGQO/qgjOIiov/FjK+TqUPi6goS26oiG2FUm4al6tc4tb?=
 =?us-ascii?Q?KyaHuygAQ6qDXQJB4V0F9Tlw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oQuHPTlX4CGyGCw7nP/KIxbxPB2AU30cuKzDUNdJJy4avwpdpgOv/H8NEF72?=
 =?us-ascii?Q?SPcQJXVRRLVEJ1TDi08meR9ML9v2T+6SO6RMCgasnXE9kg/2kV4rujLUbsVT?=
 =?us-ascii?Q?utyk1zx8zOgxzoKLx70XTVUxM7rL+vgyx+1XwWLXyleSAPNr1keoZ4XUkpc0?=
 =?us-ascii?Q?AcDhipGM6moFywkUa/vbewrVC2LMPeVoa10M1QDkxHGqlpeovtIOz2QtZagG?=
 =?us-ascii?Q?UpEsMQsxV0ds1cpV8fi5zxThwuyU03eznt0bGuk2whE96sL3wd3be7jgfXU4?=
 =?us-ascii?Q?ilTsKgAF5yF3/iArxORJDJl+8dx7kSr3ThbWfBx65mQT6NcHecTozMCACeqL?=
 =?us-ascii?Q?RbrhopDQ5PmV2c3XfC8PS5kpFjOmR25ZpQR789ddJyLMTgACrYUMSSu7Zf1d?=
 =?us-ascii?Q?MAIwgY7FHfkW/20UfXj6O4lnStjaUfInV7ZHYLwUmkf5xz7ESNzKsb6VInJ2?=
 =?us-ascii?Q?OtXQacwgAus1+8SI6t73T3w8qX0LCgvjLQCYjY4B48iwx9PnqWTicBnm43wf?=
 =?us-ascii?Q?ltuCrYNHxvA5hnRZgj4FALqwW9KEFV7Aw7YbFBGP8QQ4yks2QEU0JsMtuW0D?=
 =?us-ascii?Q?rp2vVIGAFwOd7umWAWj20avJ3+reuLvc4Q2hr13MAEvrb7/0g8953H8AA0Z5?=
 =?us-ascii?Q?ScNmtHRTVkHi4qWW65mhG/ovbsKAORht+9G6EKH/MRkuWieNOjwZPVoZn6Wp?=
 =?us-ascii?Q?K1arodBvVBqOQLB1YoVG8GwtujXCVZgoSJ1v46X5AGbJA4Dghkpene211FbR?=
 =?us-ascii?Q?BPCKC2vXWrd1ZOjgoQqGN11KGal1wEhGTh5ZhfkF4Y0qrgcUiNkkON8tTZp8?=
 =?us-ascii?Q?wmyThDcZYN+xB3ZX2+0r5kZ1C5zPeQuDW8GkZdNw6hvnsCBb080ktofDPep4?=
 =?us-ascii?Q?OAFqCq8yVf5GAMV4wFB1Thw9xA0Ec6+wZjg0LZatR0Z7JRMOnCDq+fqgVP+m?=
 =?us-ascii?Q?8F/aukdy+PjNOhyWcSzgVLlEkvMrbmU79zYql9lhiX18xhx9oyZSjdo+v0lO?=
 =?us-ascii?Q?7ZIQBGxwmLkdzNUl8kxmicIxKeuYvpzYqsCbjhDwiG/NV9zGRQQo1lC2629q?=
 =?us-ascii?Q?OJOENw3VA0m6pWAnpVOdCIMGQgwYHcTwoWmTkAoPVvChZG7JXCH+EJj+fhdo?=
 =?us-ascii?Q?/aYNutYaM+rhsMSu9cQQQKLiWGnWkRwoOQ9gb7C12fnn7Vloydbngrpf7XQ0?=
 =?us-ascii?Q?j124dcfVlKqz+mYntcRaxJjiv5/nDOhe5y4BRubqBgguOd9T9NHvutLyFObH?=
 =?us-ascii?Q?5yh4OjNYcjLewUU73d+3zmULTCWV4Qs6aTe75lsvsT9VkK3i5RDl17ev+t+T?=
 =?us-ascii?Q?rLLwGVvWqLEF4N2aVGkOcAcHtFmreVbG28MzOOiSTe1XPnxPKBi+I2TOJhhx?=
 =?us-ascii?Q?cFNGkr+zqaoKiKQHEiwV6Dw/a7oTh/jfWAgATfYbbVj1JEQra7QCglIcmlYP?=
 =?us-ascii?Q?EGGQ33L/r8wJeftMfXXIe5745++Yew9HLDsBQGkaXZ4ZjQr/nMQkStyMrIi8?=
 =?us-ascii?Q?+3EOwazGB5g6b1z2WrSoU+hb/ZR1CohmPtUGxyRJNuVpSXOQtC8xij0KCQCw?=
 =?us-ascii?Q?GjSfR4vjdRdYd7Ca0kwS/JIsNYF+SZXNFeBnBxl9+3gXObHXERGg1dRC+y0i?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddbec24-c263-44b3-d0a2-08dc8ca333ef
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:52:56.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGvkpjylvu0PaZWbF0MiGHuPmUfCpjsIdR+TU7FwDNxhXMQ4X6HtcSH61LX9+pvTsyAipv5d1lCVJQIrvemxI5tUokufu8t4pBbPUmC4xmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

On Fri, May 31, 2024 at 05:23:09PM GMT, Jeff Johnson wrote:
>make allmodconfig && make W=1 C=1 reports:
>WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kmod.o
>
>Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
>Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi

>---
> lib/test_kmod.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/lib/test_kmod.c b/lib/test_kmod.c
>index 1eec3b7ac67c..064ed0fce75a 100644
>--- a/lib/test_kmod.c
>+++ b/lib/test_kmod.c
>@@ -1223,4 +1223,5 @@ static void __exit test_kmod_exit(void)
> module_exit(test_kmod_exit);
>
> MODULE_AUTHOR("Luis R. Rodriguez <mcgrof@kernel.org>");
>+MODULE_DESCRIPTION("kmod stress test driver");
> MODULE_LICENSE("GPL");
>
>---
>base-commit: b050496579632f86ee1ef7e7501906db579f3457
>change-id: 20240531-md-lib-test_kmod-83bf2ee7e725
>
