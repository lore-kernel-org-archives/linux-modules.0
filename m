Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B627456
	for <linux-modules@vger.kernel.org>; Sat, 29 Jun 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684511; cv=fail; b=pc8LK8DOENkVPma9wlJkoO8TkerLDYXPosqujpECa+Ya0yf9ljEZ6WbNZbfb0OrK6UbmOwADYsNNe92PBr1H3hJkhN4VgB7HW18oLG42SN/uBKrK3tAxKzZEa+e2mdJyU/1HKXIJPGTBYi/cITdhINMh8uHWz/5nL1QzrUlUucw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684511; c=relaxed/simple;
	bh=Ul+XXiS06YOWAVF3v4pTxmhNXVUZJPqC2NVi8Mk6/XI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oxQrZLS2LKmoWCdqiLBkXFDbzmDEcUd9HanXHlgoFfrXdof/Y3gpdu6yhOXpgLfL61F0IXhEI0SMz0Ti62M7yre4SyyzjD0iqU8/fuDlLvvMoX9fuA1BLaDnjzj2WmjUW+AKDgRr1fjogu6rurjBlSNCo0Gfnh6RKTUNdl91pfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZmf5xDE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZmf5xDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719684509; x=1751220509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ul+XXiS06YOWAVF3v4pTxmhNXVUZJPqC2NVi8Mk6/XI=;
  b=WZmf5xDEMh1gUzssvX9Qu8sfk1MkDuQCPuAZ9cBYIAQlxQMJcbyDetWn
   oEmatvPve2mnQaJx5/fzy+c0et+/bKH4duafdBdArSf7kFCz3lcUHlsUE
   wl1tVrKC2ucnCwgV9oR+MDJ5MozqNw22s7qy+AOQq5RL4Y+kQaQAc0Cxv
   UWg4oHPaieNGqxGMWQou34q/xobVl/rUquf+sP6lL8ctK5dzDQyhU1IqH
   gynBxsOhxfODOBioVUObZmx8nQ5O1MXw0RpoFhMekiybGfh80UECiTrkL
   THZ6ULMVSZG2FeZbwamhOlfwe0QNryg5ujgoJp87v5sydY2ZDBavRyXzw
   g==;
X-CSE-ConnectionGUID: W0ZCJwl7SSaUK/47lZVfWg==
X-CSE-MsgGUID: Abp4wOgNTgaaaeMLYnslMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="16988085"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="16988085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 11:08:29 -0700
X-CSE-ConnectionGUID: cu2A7JXeSDW8Nivfc4DtKQ==
X-CSE-MsgGUID: 07LuXNXPQSaW1cAErWeQBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="50021080"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 11:08:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 11:08:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 11:08:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 11:08:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 11:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTvXNE0kfWnBtZk5AVhRaLcOL2oNJsZcX2xnFPBiwvSLqXf9Masy3neEcjn7bQXmuSmM0wtQgeV8F33zclsoOVNG7uTq/9XGQ8NyWCNTKXicSzQDrnwQlTDxS6x0gP8cC3DsK6GFV2YwabXEc5jIJjO0PoSyHHNfdQA4RoNDorQ13rXQYKPbDg/szP9JchX7a9aH3E7ThvYqxpJ5ncjNDk3X0jvMCHHeTtMKRajcSqPT60Qz7sPJKRxfvb0hKoyxwpER+GL0ILTsmiRv7lv+XxbSeNAa8meIzpkbcg9V/K78wwbq2rqXD6kE/3mCPhFmkEIGSQBvCKwMu85YuwwTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjPo/uEcoph30IAhmhs8ilROUn6dTXs2eMFGjTD2XwM=;
 b=Cnbulu88apTGrYFgAkhBNB8X/gR41hcx8eTTsAnavZJz3KEGqs/ecCjIEX8Yl6ePotiVQFk0bXLA8LBWB4bmSLa+TlVGC0MckatTE5pYQGvS8fI8PHKg9Ck7MHq589yYOkmKix8MzJ103u2DLOa7mxsnruJ0HVp/B/cn0n0xevlgSEadi23i94Ki0G8mlmEyKLZ8Zu5azL8Gr8WNmMlOhWY6i5od+iD0jS6UDlEx5N0lnQOiOM5YXngKcZmMKVR9LTV7F6ptpe71Gm7jhqRsX6xftcXPUWjnd9X8N8p5EK58q2ADQki3hOl90cS3goZdGBHWVeaYUrOalEYqVWk5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Sat, 29 Jun
 2024 18:08:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Sat, 29 Jun 2024
 18:08:25 +0000
Date: Sat, 29 Jun 2024 13:08:22 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 00/20] man: convert to scdoc and minor improvements
Message-ID: <q6dutb2b5ztkuwjkq7a7ddnsbfneoq66bafaaxwppelepflcc5@us5n2ll5syja>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: d156734e-71be-4a58-14d8-08dc98667834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yRo7CFWhjvvkIjAO0QFaycMIn8T9tq5+PavjnCeq6vwK3wjTDf4LT7KGhfu2?=
 =?us-ascii?Q?MzK695IzcPhqTdVDjlsvonyPMEJd5lq/SNDQ23OkcKSY56pB8M4E5I6sd7OM?=
 =?us-ascii?Q?wrlWUtMeAhWB7VNV2fQKqoC/76LqgmA8mX61dM6uea7aM2/p7hTEOcJWUR4j?=
 =?us-ascii?Q?RXoWpHaj7UOos0Ve4wcgcbbADN6ObIevvyfT+7b+UrFSFBDOsy/AgDqvADIX?=
 =?us-ascii?Q?xRXulbYBqUTdfm+wV+iBS+Sk6U6ytTq2kiV3jgmXQyub+RMY1m+qHSYKzUWx?=
 =?us-ascii?Q?V1FNxtIDfIct0bE5P1TPr3lfPmbeu8IwcjE/j/M0iz/KcvNEDcsIDbCTjLD2?=
 =?us-ascii?Q?H9AMVaAWEn/JtKjEQgDInzxlfdcTVzVvikr0gT8LToZ37ePywAW3vM2b89VE?=
 =?us-ascii?Q?MOqewGKXo2WsRJOiN+5cASVxLXtYnuHqz3gxNLilpHIKdTrGDiyWWML+j0qU?=
 =?us-ascii?Q?BUT4/XSgZRspz8fpJin85Jw74KbGq7S0Ls6ZuXJPalAIzTPG8TSBuz8NWMw1?=
 =?us-ascii?Q?576Z7UR7x/tyEYPsOTRs3nF7u/l2KKCADI4EzmE63K1eFtUKzgnUkHZx4wpm?=
 =?us-ascii?Q?qZPfZ4cQ0DcP1rcA11NK4vQqupVA3oIqyOspVhK160LG+OjVntA1ABIgVDPk?=
 =?us-ascii?Q?5132oZ+4ySSfEwOKRoin7VOKTmQ0QrW6/sYIOJvo33USzF/pKTvEUTuWPyi4?=
 =?us-ascii?Q?rvreToicFOwW8iZbKpwPI6qAp5Jp55IbWpUFA8vnJR7cRanGAfZMCRXoCHr/?=
 =?us-ascii?Q?5NDmT0n41Yp6sTpBDJ6kD//EJWS5szEIkk/ABIlrH9V2tD0tNYb6R4V/LWTj?=
 =?us-ascii?Q?b9i8fVMDJdc8C4GjpFN9bt66VsPZxW2JcXMMIXdIfcylOdmrXNG3/dfqcJdt?=
 =?us-ascii?Q?x4rxGj90IJLGP+0EvhmhCUkAg6UUWD5bptUG2vC03PNIMgKjAm3eDuYjdCXU?=
 =?us-ascii?Q?yZICDxtLmlvLuZNBP4SUuYqug+pWwN97crgsCUPzibmfUrFC9Iey04ordA7F?=
 =?us-ascii?Q?jLE1FiGZZzuUSpl8LLBkVIl9vGwFlP9tz2vyLYoHSkbXcQudpIvN/j45Li9Y?=
 =?us-ascii?Q?zo4kMnN22jwZ+EI+c8V57GMMze6T+REI/F+hVc1TR6ospsOKAKxw6L4M/6+b?=
 =?us-ascii?Q?hels8Il6tCgRLnyI/cV/YqU6WwDpBQImcHQzF4hY3XwkdnHyrFuoxjABpsVT?=
 =?us-ascii?Q?kbK2IyNRyM8g1jHbRAiAp8+ovYzTOKH246CE7V1Wic++CJ0Ets8zcmk8fWhR?=
 =?us-ascii?Q?chBDz0L70/eB/OLZmc69J/zfgvX0wSJyzGFS8LjiGNLGncNSxEzc/mlsVc1m?=
 =?us-ascii?Q?PrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2DMlsbMrbi7d/tU68NqKlChRpou/4bG/GN4F5sZ+Xu8coD8uQ4dyZasN3qW?=
 =?us-ascii?Q?Xr/SQ+morMrNoQ5hqwSUiRquvpyx3OH8acnNLXZp/BygH544t4Gq5wH2+40t?=
 =?us-ascii?Q?UPwXSQTJ83tRqLEsK9bq7BNJc2tJaTjLf5cfOdOsHoLY669EtnDO2p9f7utE?=
 =?us-ascii?Q?VqFiLiLdB/wAM7Dkdh0N948+Sl39eqkcAV3Qckqm82UlCFd9f3k813/hcV5B?=
 =?us-ascii?Q?qp9yp74g6CARxwsuSS/XMBnwE113LYAth0nN+q1/P/js//orRi0W1eIW6WDl?=
 =?us-ascii?Q?xoVH6VIJ6xeL2oW/o4xckfnLPPhNSsFGmKo8dxNtwFNNZwH2KGAXt3pb3mXY?=
 =?us-ascii?Q?lXpFv+7BlXxcFiY/HRH3SOaHIAc+TRc7jVLV68qpN2dgoC9hXAE1quaA7WDI?=
 =?us-ascii?Q?wZ0faMciwC4LxA5Di5YPAqyP6zbORI4OIjN0DUXC3F2CDcvVXBZZWWu4tgo2?=
 =?us-ascii?Q?CmmYVIidJX75rvBWZLN+8fHJ8SzFwVoMMsLbedE+P2UtaqMYYxVcx+OnP7I7?=
 =?us-ascii?Q?v3nvCG7mzAsCyX7MAw6ZhS8WXSwo+1fqhQBy5+EI8mCG/lkih+kiYOssqQyy?=
 =?us-ascii?Q?n5Jj0wtVfJEHdN0bZeG56yiH1pB2ahDpMZn3JitcMES0LXuj6eELjtFaTEmc?=
 =?us-ascii?Q?lsR/LLR89qdpQ8MUAtg4llydHDBjMtz83eW2HPS2Z0S3ligKcGAdCBw9tryb?=
 =?us-ascii?Q?apvPy7FbogzotLNnthVe5+CzDbivaWOTtYNZxJ50oYC9dhXhHX9Sb1C7GNA4?=
 =?us-ascii?Q?4ITmD34wm8JF+6pnbg2j+KlAojJ++xIlIhXKVzX8Dx3w3iaI30OEP9lUg/I1?=
 =?us-ascii?Q?dPqdxfGyWjrlRweII4g9eu8myCsk7YPpYt+kIRpdMlPQiNZroEnTLc4XePYA?=
 =?us-ascii?Q?I4PCfRT7YzlNwe4JJ1Q898G8Wb57WNaIy7GUkQsR+eea6N/PypRS5B0BecPY?=
 =?us-ascii?Q?81qINmwWOEYGNAoYamp/4ReBB9jyOil10kGEOCHq1nl9nCTVN5SzPnMmpaJ3?=
 =?us-ascii?Q?+l+4miLXP0mcZj6kbbky8gKThe6KTP/eSYzLlSoXghQ5N1mxGd2498ziBDaK?=
 =?us-ascii?Q?gdPwURwCfVVD4ckqt1sqY+Dc+Y9HMo9Hv8E7BVolXsCTpW147dESEV/4iZBL?=
 =?us-ascii?Q?zfXZ0sDMRuI9s4GLcLYB3ycmujDkGLSL8U9ueMrqsVN5pSRiM4souVuRo/y+?=
 =?us-ascii?Q?woZ+LcgNSI5rb5XrdKepBbvzkMTmS218ku5EJXixjKXMnKwQN5QffVr7+VKC?=
 =?us-ascii?Q?2QK4Bfx5wfdt+CKH+AebN0EjqKLdMyxD68w1RRACQXC0oAP8xHPjGu5+Sqhx?=
 =?us-ascii?Q?p6jE+5WQAYT5K0Z4+X9OggGGlLUrv7vJyTR9J2qzW2i+hryG0jmHlwOEHQJU?=
 =?us-ascii?Q?5YzYjDHtfFGHmzqENlB40PQ+2QjRhFEeYN+dxTuaCqoUW1eLIh2m6c8OsDUn?=
 =?us-ascii?Q?JrhV0eUEobIpehCqBO+5hmmwE6Tqf5GmEVN0wFhEGgXhRWRVfLdSXOnnJGLD?=
 =?us-ascii?Q?6eeX143EPwFKzSFJBVTqAykXWp/L9HDDqUCuAaI4x4fXe+1pm+fgbjzEfalO?=
 =?us-ascii?Q?6zGD8j6aaCfq5cEvD+An1JcJgCHmlHKLtXsIVKcPFvLdxytYu29jOQNqq9bM?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d156734e-71be-4a58-14d8-08dc98667834
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 18:08:25.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2mcnkg8N4pOL0CAd1qhSm4iL9HlLqq4oSz7dnP9ha+z4yDnpItFjcX5tUEWT0xACusrBXX34Jub9xC053HkqgEBhoU1eColq36vDWNVX9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:00PM GMT, Emil Velikov via B4 Relay wrote:
>Hello all,
>
>As mentioned previously, here is a series converting the existing xml
>based documentation to scdoc.
>
>Despite the size of this series, one should be able to review nearly all
>of it during their first morning coffee ;-)

a serious review with git history fossology takes much more than that ;)

>
>I've went ahead with scdoc instead of other solutions since it's a
>simple 1K LoC, C99 program with trivial markdown-like syntax. Which is
>practically available for any distro [1].
>
>A quick search in Arch shows that over 50 packages/projects use scdoc.
>
>This series:
> - patch 1 - simple comparison script of man page _output_ (the roff
>   files themselves vary significantly) - DO NOT MERGE
> - patch 2 - the scdoc files themselves, including typos to make diff vs
>   original smaller
> - patch 3 - wires scdoc to the build and removes the old xml files
>
> - patch 4-9 - trivial fixes as white space, punctuation, etc
> - patch 10-18 - expand documentation around {depmod,modprobe}.d handling
>
> - patch 19 - remove "maintained by" references
> - patch 20 - list short and long options on separate lines
>
>The last two might be little controversial, so feel free to drop them.
>
>NOTE: Some patches have respective question or two within.
>
>As always - comments and suggestions are greatly appreciated.

I went through the entire series and unless I left comments, I agree
with the changes. Thanks a lot for cleaning this up.  Can you submit a
v2 with those comments handled?

Lucas De Marchi

>
>[1] https://repology.org/project/scdoc/versions
>[2] https://archlinux.org/packages/extra/x86_64/scdoc/
>
>---
>Emil Velikov (20):
>      man: add script to generate/compare the xslt vs upcoming scdoc
>      man: add scdoc based man pages
>      man: build the scdoc based man pages
>      man: remove no longer used XML files
>      man: add some extra bold/italic annotations
>      man: white space fixes
>      man: misc punctuation fixes
>      man: some options take an argument, mention that
>      man: couple of grammar/language fixes
>      man: stop removing DISTCONFDIR lines
>      man: depmod.d: document the config file order handling
>      man: depmod.d: factor out a CONFIGURATION FORMAT section
>      man: depmod.d: rework the opening description sentence
>      man: depmod: remove hard-coded /etc/depmod.d references
>      man: modprobe.d: document the config file order handling
>      man: modprobe.d: factor out a CONFIGURATION FORMAT section
>      man: modprobe.d: mention about MODPROBE_OPTIONS
>      man: modprobe: remove hard-coded /etc/modprobe.d references
>      man: remove the "Maintained by" references
>      man: list options one per line
>
> configure.ac          |   2 +-
> man/Makefile.am       |  30 +--
> man/compare.sh        |  63 ++++++
> man/depmod.8.scd      | 139 +++++++++++++
> man/depmod.8.xml      | 343 -------------------------------
> man/depmod.d.5.scd    | 115 +++++++++++
> man/depmod.d.5.xml    | 164 ---------------
> man/insmod.8.scd      |  35 ++++
> man/insmod.8.xml      |  87 --------
> man/kmod.8.scd        |  49 +++++
> man/kmod.8.xml        | 120 -----------
> man/lsmod.8.scd       |  29 +++
> man/lsmod.8.xml       |  73 -------
> man/modinfo.8.scd     |  84 ++++++++
> man/modinfo.8.xml     | 201 -------------------
> man/modprobe.8.scd    | 232 +++++++++++++++++++++
> man/modprobe.8.xml    | 544 --------------------------------------------------
> man/modprobe.d.5.scd  | 187 +++++++++++++++++
> man/modprobe.d.5.xml  | 265 ------------------------
> man/modules.dep.5.scd |  43 ++++
> man/modules.dep.5.xml |  80 --------
> man/modules.dep.bin.5 |   1 +
> man/rmmod.8.scd       |  53 +++++
> man/rmmod.8.xml       | 148 --------------
> 24 files changed, 1041 insertions(+), 2046 deletions(-)
>---
>base-commit: 8837461494761d58be579641f20cc043274adddf
>change-id: 20240523-man-743d6e51eb6f
>
>Best regards,
>-- 
>Emil Velikov <emil.l.velikov@gmail.com>
>
>
