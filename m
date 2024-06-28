Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBF6BFA3
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611134; cv=fail; b=GwJJ4OcNPsUiAIr/YKFQ+IReHus7elYFDyGoknptdbdU8Vt0vlewY0InUcScfkOxQB0wH9quW8kNlfoJfE5evsEU479s+1v3/4e9pYqz2K+b3HoJe7wltJ8L2up+BSHq77aMvCZxu+ugb9lpX0EG1dox4O0VANgot8rlOuwCEQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611134; c=relaxed/simple;
	bh=HN7+flTr9ukwXYqHNJL9/bbmuJVQJjqRtmku2tIyig4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ja6h1mFCXrRU7SuzU8ll3ZwdR2wy1dQv4DQrs5YD/E6jqY1GxmBjoTqRZISPenHaV0d0XqMy+FW7ja592W2t99S6RlIUS/yaODy5OSwxwFnTGnahE7JUNHvCi9ioMb2dknr0VTeRueiXNdhQoiYOUrbN73R6XpVRvKZeUQhNSxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8e/gVRM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8e/gVRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611132; x=1751147132;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HN7+flTr9ukwXYqHNJL9/bbmuJVQJjqRtmku2tIyig4=;
  b=K8e/gVRMxvWtSbBnj38uP8WZe2WijTal2nFbXLnLm/TOTz69c2q8jFn/
   OUmCoiHmchqWXUzkiyPdDtUpo17+RjLbBH4dU546Ai5NWiYJ+CoQ2SV1b
   28bk50lIuaRCk0ZuSjuKm/cVEtA/S+gt8qmVv3TJH7WzeQ2Nksb3bFyrt
   laOCCDK839+yGdci7g0GRtavZyXrlvijamZyJ2Px7RCWFOq0i8K9qpMZX
   84NLNY6pPb6dQUDeYuN5yv+EKWyl6weZAhl6YjctHjnCkSMbOscafMhj5
   YjBk+AaBSuaS7JqiwEkXukA5j/GyQ9YbYie5kqScHtU8VshzfjFAD4KXT
   w==;
X-CSE-ConnectionGUID: iqTur+H1STOGrflg/VCURA==
X-CSE-MsgGUID: IMSnlUHdRzuKolZuywwXMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16761903"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16761903"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:45:32 -0700
X-CSE-ConnectionGUID: I3WWz3zzTIW8DDRIyV3+LA==
X-CSE-MsgGUID: sXmB3NsESkq0ZMLs6DwWhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68064133"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 14:45:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 14:45:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 14:45:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 14:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS7Fmr0+4KiBIWAIchZeRcgKQRUfxrIGm3GzKfhqae1ncSHkHRj9xxph1L4FgRGrlcgAUcjxLm4TzIDbBDpkKAf+/TaNdKOgGj51220kDYi7AQXpT2CgKSPhRSTBylknhBxpfKRVx0gBcp4iPEQDwKbbHf5ctAX9VGK1k54QC0og4vTfvxOvIbf5E7gZDnr+6Csu6qeq/gDuxgCln+2vhU3GOW8aGg68PEpdPn1ikeV/hYF0Wnu57y/ofElvwrIHISp0rfIce1F/DQfZlvt3Y63q2r3j72SgbcoYP+U0Pj492lNKM+/9xQurCx4evnSTRsHDNTuz048gPifaynl3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PWV/S+A7Mv2d4dnalHPtOBhHEvTEaRdAnWmmAPOXDI=;
 b=CPcZvq9ak3QmrCG216+mpCqi7kCYyJaRb07NeEL0Sw4i6w6hQkOGcf//i+LYLsxsyx1zEJ8MT5FeORzz6XgRCglA1yqbbXNrp5GCcTmcYLYlLpcqX8ssjsVyQ9TRItxhMlKZ/6P/fC8CXaEU3rl8KNy6an8GJJGvrvm9MPHP8vasUmB4Sybq53vg/Yp8oTcRd1O6oiLot+9TQzOerPjwLH9g6CirhRXV0FL4rRf+rykPiq4r8Hf5fxEsdgeWBmAoXZtdFHAgmaGM49KdBP7LmHCpN3tWR9zwSUPx9jaTZE9WPc75goF5V69Wb86AU9rnYNb5GQueqIZoVZscl8k6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:45:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 21:45:27 +0000
Date: Fri, 28 Jun 2024 16:45:28 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Valerii Chernous <vchernou@cisco.com>
CC: <linux-modules@vger.kernel.org>, <xe-linux-external@cisco.com>, "Nicolas
 Schier" <n.schier@avm.de>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 1/4] tools/depmod.c: use symbol alternatives for
 modules.dep
Message-ID: <vm25ywuqj7or6tlqturl4fql5s66lhhluisnbei5qzfhs67ah5@4s7dsxwcvg5w>
References: <20240510112128.2417494-1-vchernou@cisco.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510112128.2417494-1-vchernou@cisco.com>
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a94704-6265-41b2-9a2d-08dc97bb9f8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hQdKzxDNY8it/9+YoD6dk5NdYr+l3vmrRUH7X0f9bbiPwd9cQT5WLJGUZaFS?=
 =?us-ascii?Q?habQ2HtZKN5ACaBpHYE7VVBygzxvxbhkO57YeXVDvdjds+of9OOnCR91ryyw?=
 =?us-ascii?Q?t6DQ3LOfJ0Lwl19v8zR6Y6WLlhc95HXVbCh211pHH1pnejHEBamUuxEkHzRh?=
 =?us-ascii?Q?9bVn85WCaXuqOrvKQOsJnJ29TJ4xb1qEAYBxqwBNPNg/zPFsC+Nyl4hKGsqw?=
 =?us-ascii?Q?RlXZov/mhJ/vnagxExJ68ZRs6xR9iHQ/oxOU8rQdZZjO9+9hTgu9Y1ZKzswu?=
 =?us-ascii?Q?6btJvTpkVMXsRW+uuDCrexQTM8cp8qKG8rwpRHHGPfcZC2y6iiGUSr3PzxvY?=
 =?us-ascii?Q?2UKaZLyx4MJBFSiFe004GdRGMsyDMseiqpKm9HfVgC52N/lyWOArw9Dvncex?=
 =?us-ascii?Q?mNHbHgQEikHO09Z5SHiD85bA/Sys2w6tzUVjPRHrGYh2AN/KwyJ5LORwUttd?=
 =?us-ascii?Q?oQNAbjcTIZCLpH4ztJSerdwXefdjmu0FvErvIFrCZ8bwKqoKE9il2RM7Cw8F?=
 =?us-ascii?Q?sY3XYiA3mtWeRKQcov4608d3GkPHuZA/h3N4YWjjsANWifO3hBNaH/DH0c+u?=
 =?us-ascii?Q?YJUtHxsbdFCWY77lXdrJKTVduzFRuwUYQ+tifpMSBBRrKnodpqYXUybjVGZk?=
 =?us-ascii?Q?eQAm6UxAapYmBogC5dZgmakMVejKDhRdRs53pb1Ba5y2qBNkZnFVlpBIjGkm?=
 =?us-ascii?Q?+UAOLPYOIXWg/kjxEf7Cku3IfgRqIsi77YwYs8kKTuC7ovQPfE8ZWAA3yrW8?=
 =?us-ascii?Q?MwRpowGV57QVvr2MnRtYAaqUQkZqbG87IUnE4wYCDSOiLpvrDFEnCReA9vxg?=
 =?us-ascii?Q?5BGj8ZpM94/Cyk987Ppr1/GU/rZgPnmo2kpYBNyBGrGUeG0RNQCF4rwWlC1d?=
 =?us-ascii?Q?mxkP66Sm6mhWjtpj3IVs4Uf9s+mPYTt+ThaVxIlY0SqmGpU98Sd4rUsIazvd?=
 =?us-ascii?Q?cbJ3Yo9g+n5B1P3lnAnWUzdDQSm3/b3TyJuUz0HRMLY62lpusPNuys04Wc+Q?=
 =?us-ascii?Q?MYYLnVTUthxkLgrhLogNydiSHhQJqx+M9WE7VKGq/47ibgfeJtHTtbnWASti?=
 =?us-ascii?Q?i1Mvl/OVh00V1+EcFL3psP52AOiyeKhFSSWN9JHmLKX9geQl/coIUZ1DaPVd?=
 =?us-ascii?Q?8QmHinoB9U6ulcF5yKNUvfPBxm8OqT3tqiNRjSKe+tqRpLLuUTislpdxA4lV?=
 =?us-ascii?Q?O4mU8Jg42tP+804V/PKlErw6MO0t2afcdzrgxJTWQk9VkTcu0MowZJhGeQR6?=
 =?us-ascii?Q?SpMfJAu3xSPfuMY7EV7oA3lB3viKspUHqMpQxq5g5DHuQtk4dCLFb3GB2XxI?=
 =?us-ascii?Q?nnCD4gFD5W0eZ0zqrPISgajJLBoRDrmtot7SmqUQFseW2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYSu6JYn6BOQAySev7K8p2rj967FsQWKQvycJEBRLAEHbrL1umKI7CyH2XQU?=
 =?us-ascii?Q?+lplsNcd56gaT+qGFraSds0mcTKJC49Je5QOEgLoGDSDCm/edssVDDkHMujC?=
 =?us-ascii?Q?YH1Qgwor7kKUMHtsrG6SEyrpDnXfMhYpBz9o7TtCzyNedFuDYjdkpEVLIPNs?=
 =?us-ascii?Q?SLAWUF4JIzVnRiw22Qh1cT2n/VxAyn1Y0+ekA0sbnNOwWJYO1uXI1aLvvEHS?=
 =?us-ascii?Q?rkeWxjvaqTJu4cEqRBpakvZ9AlXL6fTKfGHWljki3AZO0s2oZn94Pr+5tKp3?=
 =?us-ascii?Q?h2EC8XJR6IIabeAXvCdViyMk+KGX6RtjTj4JLBmYvLulHGTj+qM0cVckmWjf?=
 =?us-ascii?Q?DKIFh0Slw7iqmNr7/8QkmtvagSAyA4/NeP+tJH0GXYCZV85upYKwHqvLQknN?=
 =?us-ascii?Q?BFSVy2U+RNnz+aj6rocdqvlEc6XxadvENlc1A/Ek6ot4788ihmjtLlUJEsIJ?=
 =?us-ascii?Q?+cALdB6UwLGtsWaTAZbIP44HSkf55+Q4SVYSOriS3MdAokOxrTbrJcPIsqHF?=
 =?us-ascii?Q?/xuoRDZ1DhVni/urym882JbmiZ6A+UJYyCC1ulOCBWI9Fl4EDDc9dKMWyy1p?=
 =?us-ascii?Q?aiOaDILaYAL009cek/sb97G4LbxTKkbVm+AMd6smlAM6155I/R/ZbBaKt4tt?=
 =?us-ascii?Q?OeMiqhNHdSVbIJYrKeicA+/CGQ+hxLkth673+VTeYRKrG1wLufhrTLQoHfZA?=
 =?us-ascii?Q?3rgkbpk53/ochQ2YTMj6gkWVro8iozh6MX0BlpIaKZvqVVIIO2X8926A2lQB?=
 =?us-ascii?Q?dhVbB5qpFJXin23PudzL/OTCrVpS1Sf8SH54f9TNWJy3zmDLOQjQCLENPz+j?=
 =?us-ascii?Q?0qqee5xcLUUS6uenRefDtFVtTOPNUdStojFk8RTSbaAmX+FhujMqge8OI/eH?=
 =?us-ascii?Q?vTEhqLLZT20wtkKf1oaz+RQAoT1E9A/4wjcuGQGQyFHMDWq3XXdOXgd2ycW3?=
 =?us-ascii?Q?tHJOR1UG3A9PWZOB2ONJ8FGnHiOYTuDu/7JXGf7WWAfAmmI/PxywJNvbo92C?=
 =?us-ascii?Q?G+H4sz0QQK4RnrAF2kmOAnxbluuxna+viKzdrbBWgU5xEZrZO4Zg08f4sbf0?=
 =?us-ascii?Q?8vI+HobRSGIHmf4uKhwyMAEWdDd299EaJZ3oVwVElPbdH72a26ZOaP4FSUpw?=
 =?us-ascii?Q?wbAi27HZR3Z8bdkqpKInSdaiUEo8E/Aawdc1DObHBr64VnR7FAB6IF/0Nwr9?=
 =?us-ascii?Q?fF28EB45494Ak/OqTrOB1p5stRy9X4zg48HqvofaZkK/nnGv4lYSU6Dvqqam?=
 =?us-ascii?Q?uYkzG1IFHNZpogyMFlhhnpd2pNpKMe+WyausfBZDkuuv3rtXNSLu/OkYHhCv?=
 =?us-ascii?Q?8tskI4yx3ETkKh4c1RiMas/8OLxvt6eAq7YjSnRCCpiD5rL5RsAOmAaI6vBX?=
 =?us-ascii?Q?aXq9xgGNd2ycaLJ0DX1Rkq9VycBoIBKV8qKueyjsRGnyBzjOm/bEPd/J8aho?=
 =?us-ascii?Q?kpsyqWbMuAgsfVrNXQphhGzbWirLjxX9enJkaP7Prz0zh1w79aMqflejGLJY?=
 =?us-ascii?Q?7svYU5KSySCmXP47tmjYUS3WXmmB3t58xDbpHOXLvuzU6OmZtIU5HdY1Pe7n?=
 =?us-ascii?Q?oCaOm/VrCj9IPghlwfSHfxo6wzErr3BEKM7bo7QwOWPsci0P3u9GbalJURW4?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a94704-6265-41b2-9a2d-08dc97bb9f8c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:45:27.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTXEsRkqhol7V2Fki1f6fgbLJzS80FpnlJINl6qYA/CPopTd7fvw6ja72ATGeToZhY0slxF0Uf0bwQsvKqSGnc9ERrF1WNwe2dcNTMUSd34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com

Hi, sorry for the huge delay on getting to this.

On Fri, May 10, 2024 at 04:21:25AM GMT, Valerii Chernous wrote:
>Add depmod cmd line switch -D to extend symbol search dependencies algorithm
>Currently, depmod use only one symbol provider into symbols hash table
>So if some symbol exported by different modules only one symbol provider
>will be presented into symbols hash table(the latest found during modules parsing)
>All other alternatives will be deleted from hash table
>As result depmod can point dependency to module different correspond to build time dependencies
>and create invalid dependency
>To avoid this issue "-D" flag extend items of symbols hash table to symbol list,
>check build time depencies and choissing proper symbol alternative if found
>corresponding module name into available modules list
>In case if no corresponding found it use latest found symbol alternative as previous alorithm


I'm trying to understand what exactly you are trying to do.
Can you provide an example? Is this required for something new in the
kernel or external modules, or what?

There can only ever be one symbol provider for calculating module
dependencies because there can only ever be one such symbol in runtime.
depmod will use the priority from the locations as detailed in
depmod.d(5)

What I'm really missing is a cover letter to this patch series
so we can understand the use case before trying to dive into how it was
implemented.

Lucas De Marchi

>
>Cc: xe-linux-external@cisco.com
>Cc: Valerii Chernous <vchernou@cisco.com>
>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>---
> libkmod/libkmod-internal.h |   5 ++
> libkmod/libkmod-module.c   |   5 --
> shared/util.c              |  20 ++++++
> shared/util.h              |   1 +
> tools/depmod.c             | 144 +++++++++++++++++++++++++++++++++----
> 5 files changed, 155 insertions(+), 20 deletions(-)
>
>diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
>index 3bc6e11..0a274e7 100644
>--- a/libkmod/libkmod-internal.h
>+++ b/libkmod/libkmod-internal.h
>@@ -68,6 +68,11 @@ enum kmod_file_compression_type {
> 	KMOD_FILE_COMPRESSION_ZLIB,
> };
>
>+struct kmod_module_info {
>+        char *key;
>+        char value[];
>+};
>+
> struct kmod_list *kmod_list_append(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
> struct kmod_list *kmod_list_prepend(struct kmod_list *list, const void *data) _must_check_ __attribute__((nonnull(2)));
> struct kmod_list *kmod_list_remove(struct kmod_list *list) _must_check_;
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index d309948..2cdec34 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -2261,11 +2261,6 @@ static struct kmod_elf *kmod_module_get_elf(const struct kmod_module *mod)
> 	return kmod_file_get_elf(mod->file);
> }
>
>-struct kmod_module_info {
>-	char *key;
>-	char value[];
>-};
>-
> static struct kmod_module_info *kmod_module_info_new(const char *key, size_t keylen, const char *value, size_t valuelen)
> {
> 	struct kmod_module_info *info;
>diff --git a/shared/util.c b/shared/util.c
>index e2bab83..ea4b9c0 100644
>--- a/shared/util.c
>+++ b/shared/util.c
>@@ -546,3 +546,23 @@ unsigned long long stat_mstamp(const struct stat *st)
> 	return (unsigned long long) st->st_mtime;
> #endif
> }
>+
>+int str_in_coma_separated_str_list(const char *where, const char *what)
>+{
>+	char *p = strstr(where, what);
>+	if (p) {
>+		int is_head_ok, is_tail_ok;
>+		size_t l = strlen(what);
>+		if (p == where || (p > where && *(p-1) == ','))
>+			is_head_ok = 1;
>+		else
>+			is_head_ok = 0;
>+		if (*(p+l) == 0 || *(p+l) == ',')
>+			is_tail_ok = 1;
>+		else
>+			is_tail_ok = 0;
>+		if (is_head_ok == 1 && is_tail_ok == 1)
>+			return p - where;
>+	}
>+	return -1;
>+}
>diff --git a/shared/util.h b/shared/util.h
>index c4a3916..4337bd6 100644
>--- a/shared/util.h
>+++ b/shared/util.h
>@@ -17,6 +17,7 @@
> #define strstartswith(a, b) (strncmp(a, b, strlen(b)) == 0)
> char *strchr_replace(char *s, char c, char r);
> void *memdup(const void *p, size_t n) __attribute__((nonnull(1)));
>+int str_in_coma_separated_str_list(const char *where, const char *what);
>
> /* module-related functions                                                 */
> /* ************************************************************************ */
>diff --git a/tools/depmod.c b/tools/depmod.c
>index 43fc354..24f79c4 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -59,7 +59,7 @@ static const char *const default_cfg_paths[] = {
> 	NULL
> };
>
>-static const char cmdopts_s[] = "aAb:o:C:E:F:euqrvnP:wmVh";
>+static const char cmdopts_s[] = "aAb:o:C:E:F:DeuqrvnP:wmVh";
> static const struct option cmdopts[] = {
> 	{ "all", no_argument, 0, 'a' },
> 	{ "quick", no_argument, 0, 'A' },
>@@ -68,6 +68,7 @@ static const struct option cmdopts[] = {
> 	{ "config", required_argument, 0, 'C' },
> 	{ "symvers", required_argument, 0, 'E' },
> 	{ "filesyms", required_argument, 0, 'F' },
>+	{ "deps-alternatives", no_argument, 0, 'D' },
> 	{ "errsyms", no_argument, 0, 'e' },
> 	{ "unresolved-error", no_argument, 0, 'u' }, /* deprecated */
> 	{ "quiet", no_argument, 0, 'q' }, /* deprecated */
>@@ -95,6 +96,7 @@ static void help(void)
> 		"Options:\n"
> 		"\t-a, --all            Probe all modules\n"
> 		"\t-A, --quick          Only does the work if there's a new module\n"
>+		"\t-D, --deps-alternatives	using symbols alternatives for generating modules deps\n"
> 		"\t-e, --errsyms        Report not supplied symbols\n"
> 		"\t-n, --show           Write the dependency file on stdout only\n"
> 		"\t-P, --symbol-prefix  Architecture symbol prefix\n"
>@@ -476,6 +478,7 @@ struct cfg {
> 	uint8_t check_symvers;
> 	uint8_t print_unknown;
> 	uint8_t warn_dups;
>+	uint8_t use_deps_alternatives;
> 	struct cfg_override *overrides;
> 	struct cfg_search *searches;
> 	struct cfg_external *externals;
>@@ -924,10 +927,12 @@ struct mod {
> 	uint16_t users; /* how many modules depend on this one */
> 	bool visited; /* helper field to report cycles */
> 	struct vertex *vertex; /* helper field to report cycles */
>+	struct kmod_module_info *deps_from_mod_info;
> 	char modname[];
> };
>
> struct symbol {
>+	struct symbol *next;
> 	struct mod *owner;
> 	uint64_t crc;
> 	char name[];
>@@ -975,13 +980,40 @@ static int mod_add_dependency(struct mod *mod, struct symbol *sym)
> 	return 0;
> }
>
>-static void symbol_free(struct symbol *sym)
>+static void symbol_free_sub(struct symbol *sym)
> {
> 	DBG("free %p sym=%s, owner=%p %s\n", sym, sym->name, sym->owner,
> 	    sym->owner != NULL ? sym->owner->path : "");
> 	free(sym);
> }
>
>+static void symbol_free(struct symbol *sym)
>+{
>+	struct symbol *sym_i, *sym_i_tmp;
>+	sym_i = sym;
>+	while (sym_i != NULL) {
>+		sym_i_tmp = sym_i;
>+		sym_i = sym_i->next;
>+		symbol_free_sub(sym_i_tmp);
>+	}
>+}
>+
>+static struct kmod_module_info *depmod_get_mod_info(struct mod *mod, const char *key)
>+{
>+	struct kmod_list *l;
>+	struct kmod_module_info *rval = NULL;
>+
>+	kmod_list_foreach(l, mod->info_list) {
>+		struct kmod_module_info *info;
>+		info = (struct kmod_module_info *)l->data;
>+		if (strcmp(info->key, key) == 0 ) {
>+			rval = info;
>+			break;
>+		}
>+	}
>+	return rval;
>+}
>+
> static int depmod_init(struct depmod *depmod, struct cfg *cfg,
> 							struct kmod_ctx *ctx)
> {
>@@ -1537,8 +1569,9 @@ static int depmod_symbol_add(struct depmod *depmod, const char *name,
> 					const struct mod *owner)
> {
> 	size_t namelen;
>-	int err;
> 	struct symbol *sym;
>+	int err = 0;
>+	struct symbol *sym_l = NULL, *sym_li = NULL;
>
> 	if (!prefix_skipped && (name[0] == depmod->cfg->sym_prefix))
> 		name++;
>@@ -1548,20 +1581,49 @@ static int depmod_symbol_add(struct depmod *depmod, const char *name,
> 	if (sym == NULL)
> 		return -ENOMEM;
>
>+	sym->next = NULL;
> 	sym->owner = (struct mod *)owner;
> 	sym->crc = crc;
> 	memcpy(sym->name, name, namelen);
>
>-	err = hash_add(depmod->symbols, sym->name, sym);
>-	if (err < 0) {
>-		free(sym);
>-		return err;
>+	if (depmod->cfg->use_deps_alternatives == 0) {
>+	    err = hash_add(depmod->symbols, sym->name, sym);
>+	    if (err < 0)
>+		goto err_ext;
>+	} else {
>+	    sym_l = hash_find(depmod->symbols, sym->name);
>+	    for (sym_li = sym_l; sym_li != NULL; sym_li = sym_li->next)
>+		if (sym_li->crc == sym->crc && sym_li->owner == sym->owner)
>+		    break;
>+	    if (sym_li != NULL)
>+		// symbol already in the list
>+		goto clr_ext;
>+	    else {
>+		if (sym_l != NULL) {
>+		    // insert new sym at second pos to left start list pointer from
>+		    // hash without changes
>+		    sym->next = sym_l->next;
>+		    sym_l->next = sym;
>+		} else {
>+		    // new symbol
>+		    err = hash_add(depmod->symbols, sym->name, sym);
>+		    if (err < 0)
>+			goto err_ext;
>+		}
>+	    }
> 	}
>
>-	DBG("add %p sym=%s, owner=%p %s\n", sym, sym->name, owner,
>+	DBG("add %p sym=%s,crc(%#"PRIx64"), owner=%p %s\n", sym, name, crc, owner,
> 	    owner != NULL ? owner->path : "");
>
> 	return 0;
>+
>+err_ext:
>+	ERR("Failed to add %p sym=%s,crc(%#"PRIx64"), owner=%p %s\n", sym, name, crc, owner,
>+	        owner != NULL ? owner->path : "");
>+clr_ext:
>+	symbol_free(sym);
>+	return err;
> }
>
> static struct symbol *depmod_symbol_find(const struct depmod *depmod,
>@@ -1571,7 +1633,7 @@ static struct symbol *depmod_symbol_find(const struct depmod *depmod,
> 		name++;
> 	if (name[0] == depmod->cfg->sym_prefix)
> 		name++;
>-	return hash_find(depmod->symbols, name);
>+	return (struct symbol *)hash_find(depmod->symbols, name);
> }
>
> static int depmod_load_modules(struct depmod *depmod)
>@@ -1615,6 +1677,40 @@ load_info:
> 	return 0;
> }
>
>+static struct symbol *depmod_symbol_get_primary(const struct depmod *depmod,
>+							const char *name,
>+							struct mod *mod)
>+{
>+	struct symbol *sym, *sym_l;
>+	sym_l = depmod_symbol_find(depmod, name);
>+	if (sym_l == NULL)
>+		sym = NULL;
>+	else if (sym_l->next == NULL)
>+		sym = sym_l;
>+	else {
>+		struct symbol *sym_li;
>+		if (mod->deps_from_mod_info == NULL && mod->info_list != NULL)
>+			mod->deps_from_mod_info = depmod_get_mod_info(mod, "depends");
>+		if (mod->deps_from_mod_info == NULL)
>+			sym = sym_l;
>+		else {
>+			sym = NULL;
>+			for (sym_li = sym_l; sym_li != NULL; sym_li = sym_li->next) {
>+				if (sym_li->owner->modname != NULL &&
>+				    str_in_coma_separated_str_list(mod->deps_from_mod_info->value, sym_li->owner->modname) >= 0) {
>+					sym = sym_li;
>+					break;
>+				}
>+			}
>+			if (sym == NULL) {
>+				DBG("Can't find proper owner for symbol: %s use first from list\n", name);
>+				sym = sym_l;
>+			}
>+		}
>+	}
>+	return sym;
>+}
>+
> static int depmod_load_module_dependencies(struct depmod *depmod, struct mod *mod)
> {
> 	const struct cfg *cfg = depmod->cfg;
>@@ -1625,7 +1721,7 @@ static int depmod_load_module_dependencies(struct depmod *depmod, struct mod *mo
> 		const char *name = kmod_module_dependency_symbol_get_symbol(l);
> 		uint64_t crc = kmod_module_dependency_symbol_get_crc(l);
> 		int bindtype = kmod_module_dependency_symbol_get_bind(l);
>-		struct symbol *sym = depmod_symbol_find(depmod, name);
>+		struct symbol *sym = depmod_symbol_get_primary(depmod, name, mod);
> 		uint8_t is_weak = bindtype == KMOD_SYMBOL_WEAK;
>
> 		if (sym == NULL) {
>@@ -2306,12 +2402,27 @@ static int output_symbols(struct depmod *depmod, FILE *out)
> 	hash_iter_init(depmod->symbols, &iter);
>
> 	while (hash_iter_next(&iter, NULL, &v)) {
>-		const struct symbol *sym = v;
>-		if (sym->owner == NULL)
>-			continue;
>-
>-		fprintf(out, "alias symbol:%s %s\n",
>+		if (depmod->cfg->use_deps_alternatives == 0) {
>+			const struct symbol *sym = v;
>+			if (sym->owner == NULL)
>+				continue;
>+			fprintf(out, "alias symbol:%s %s\n",
> 					sym->name, sym->owner->modname);
>+		} else {
>+			struct symbol *sym_li;
>+			int is_printed = 0;
>+			for ( sym_li = (struct symbol*)v; sym_li != NULL; sym_li = sym_li->next) {
>+				if (sym_li->owner == NULL)
>+					continue;
>+				if ( is_printed == 0 ) {
>+					fprintf(out, "alias symbol:%s", sym_li->name);
>+					is_printed = 1;
>+				}
>+				fprintf(out, " %s", sym_li->owner->modname);
>+			}
>+			if ( is_printed == 1 )
>+				fprintf(out,"\n");
>+		}
> 	}
>
> 	return 0;
>@@ -2956,6 +3067,9 @@ static int do_depmod(int argc, char *argv[])
> 			config_paths[n_config_paths] = NULL;
> 			break;
> 		}
>+		case 'D':
>+			cfg.use_deps_alternatives = 1;
>+			break;
> 		case 'E':
> 			module_symvers = optarg;
> 			cfg.check_symvers = 1;
>-- 
>2.35.6
>
