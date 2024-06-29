Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF11E4AF
	for <linux-modules@vger.kernel.org>; Sat, 29 Jun 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682000; cv=fail; b=ikscXwU/vmG4zUo/QXVRY0aBZNbhIAsczCsJdBA5nOXu/v87pJeO5zhs1lmuX2nAmGglpGsMvf2PutUeocW1DUcJ2VXYBnfuLcW06kgpe3BIGYqtgWDdxoIKmlaC10SgKrue1ZARJQ/17UuWokErJ3BWEXWWNQuX5MTKGPWEljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682000; c=relaxed/simple;
	bh=IFftHGNg2ureirGFJKZgzrV7A+sAfxgIX5U8gg8wNcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DjjBBPp83m4yp1AaO1gH06ONyoIQu2R53SA8/EP8yqqL0G0NaZB3XcgOQ3BKPUZSFkbo5drzQnHsPbKdlzTum/GmnJO9ehP29uRbZNlP7jGleSa8KOiQLXAVAilrUQaAcjkT6RYxgV4PLl+ZgjfKw4XY6sYtEap4+hlWlsZkYeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ0xbvw8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ0xbvw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719681998; x=1751217998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IFftHGNg2ureirGFJKZgzrV7A+sAfxgIX5U8gg8wNcA=;
  b=kZ0xbvw8a+rYsujNaFL/2Z183n7ylW5Kz/aX+8nKoDWnY+HPR+TmleV0
   kAx0TIAKl069JEIFy3gg+l0zw1Qwo1f3Z3wPiHr5R0SzDod3xcoW4+IPY
   eNJST1MkrpIcF8VRWfbbL2tArJKSWYAeKHaQCEoU99qtgoa6aYFbOu2hq
   fRU8DjbbCCpgCyz9LLWeDyunPQDFSR80VuiD7bILs4HH8M9yNgJgnp8m0
   O+Fahu5VAPnXYTK+9xRDObkcEvIbXuQlXtVJbg8nQhxo2cYdPjJ1hhVEQ
   c1Zbu/hkqtQWdl82JrsMsRbL2xNJ3Vpd213GX6yGfjVAooevFNXhZuuBE
   Q==;
X-CSE-ConnectionGUID: X8kKehIrSt2N8dDUyZsXpQ==
X-CSE-MsgGUID: ZpKKWEVMQyiHUxFP5hg/jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="20719954"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="20719954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 10:26:38 -0700
X-CSE-ConnectionGUID: 1IJxl4/3TIW1h65lmyiYMQ==
X-CSE-MsgGUID: KMxQpNR2TayAohO26kbHrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="44958172"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 10:26:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:26:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:26:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 10:26:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 10:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+8NSkg+xn9TzT5oFWg/7AYLV8JECLUXJ9ztipXWTZKIUsV+RyMVOvO+GClkk97S5q/AYy+njvJdz+GBCgB9MJvffk6H0jZiNqBhn+4WFzvjStZVDftRb8uYwUdN5QVbiV9aAH/XCOmZ1CTwwUDSrZRaJjEf+nSjV3sZIpDyFdSDn4ZlM3zsWzy5mA2DiOnxYhlj0bpsDrk/if22TjcV0fF9fzZdO20z48g5xwziSkoRY49AgrHctSze0whEFP5sZhSiljDmBp9Jot9xUi/VbirOtnc8Sc8Gr1SMBSVc3/rUr+w5S8KasqYF8GJFa1o530d6325F4I4sjqntLto2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWKXcEXkiOY8B/+ig0Rhgflz+z3142Z2E9C7sLHijIQ=;
 b=U9eKPLADzAGAr89jRzlJlKhTvDvw1bpiLWGwtwusToFH2VahHskktdSTc5VRj/7XlNJz8t0AdDR/iVnRCcby0VdkQUqKpTahRE7uq8nZiPRHKUn7g42VRZ9UTq19xPFyBnWFABCDEJqt0aCkI8iMqRJtPf6FhgY/0bLOXv/tsSfH57ZUDs9NPIrAl2zUFySmPUYAGYmn8MlWs2avc1oc9TWI9YqTHWD7Cg8vG6dEDYr+BQrrznOAVS5Xo6Bscit3e8GpJdHbf3/adgG+smIZNnOhJDIm0ql6MCDsaPlpLdiv06ZPueBjLvN5xbfQAbrFs41X8Q65+Fz0FNTklDfRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 17:26:29 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Sat, 29 Jun 2024
 17:26:29 +0000
Date: Sat, 29 Jun 2024 12:26:26 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 11/20] man: depmod.d: document the config file order
 handling
Message-ID: <uojaxpxptkc4t2y4iy2kpmcti6xhwa3hcwyztdijku66w6ac6z@vfpomcikmevt>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-11-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-11-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: a780f291-1f41-4ebd-079c-08dc98609c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|27256017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tm+KgDgChT/B3fK9TOrLJ2C3dHQD4iPbT2ADLug24pxL7OdsKIi5xATBrZl1?=
 =?us-ascii?Q?NWFLP3eW8Ak5WTDFK3Bm2SAMKOKpBVmHT1AtWtHidqeu3TTq9jTaQaUf7POJ?=
 =?us-ascii?Q?Xx8SOU5o7AnW4cPNWXgFreKQXZsKHCf42dpQc5CDtQ8BHZzYZCmoNFJJ8HiU?=
 =?us-ascii?Q?Hz9pI6yvhXuxXnm8LRy2N2brqJnLJhTE+ICOeMxHrVmV0ZS6t4TtYJ1lXYMt?=
 =?us-ascii?Q?Qw5WkQ0hQ3+/DRGTbKnymah18/Qz/rJbVf5XUYF73CNKilv1zmlAi5FA51k2?=
 =?us-ascii?Q?yy+AfpTevAmkH0EWu8Jhkq6ctZAlOPrceDG03m7DAwuz+EPIDvZqAyxcVnO7?=
 =?us-ascii?Q?2GtUi5K+gpl96euTdgOcQHK3wwK9Ftna8AXA9VPZrladUP6EAPqPHfdFHWwX?=
 =?us-ascii?Q?LAxC996BPM5tY9OSPaz4Orekt+EGeSptYZ2EiqRE/g/jC7wJd5qHIgWmsXht?=
 =?us-ascii?Q?SlB9/PgIEVTNcl6ErLlYQT1E2KT1mCexI7HAcOTwPi097z3XmJi7L+nteYfQ?=
 =?us-ascii?Q?YSBXDDbyzUWoQGlqkZ89rc+GRkZHc13y2ApbRJTumMnKYkWTItZHGa3cZdUe?=
 =?us-ascii?Q?/0aEF3C17Xr6ioJGf+15hxN/AD2U0K6XKUVYF5TL0pCTe4GEZo1W6CjDsN61?=
 =?us-ascii?Q?+7ceI7bjk5w72UYJ0xqKinjR8ooSkyL+zHWTT+sAzamPBajcOZ1G18h9Zgsk?=
 =?us-ascii?Q?63Wgpk+j3B7mKoqoTJIOeE9sppqa3Mwwrn65Pwvxjy2HNXxf2nGdJ5Zthtw3?=
 =?us-ascii?Q?sTOoqxZt1yvgtqVx5cC1T5SSpYl2qs2ZrhTKTfWe6XlmHcVlQmZ6PsWbPrFw?=
 =?us-ascii?Q?TzBkEKLsRPuc+HK6cQBonybEvBrF6W7us4QzUAduVo2eExPolHvoJf+esMi/?=
 =?us-ascii?Q?RdU5Q7C+i1rHMn3Q4AZ+GN/+RVWiQP66+xM6rr3tZR+TmqvjQn7w5jegFnCG?=
 =?us-ascii?Q?i0hQjChYOKPZfRf6mT2NV8i7p+J+MT9iXMJ16Qt225RNYzc9uQlDphksSoTY?=
 =?us-ascii?Q?gKZCGnIXXVG8jky1ugP1SpQ0lo9JYXQg6lww8HgdmyHqxk8pDHrhKGtXTYU+?=
 =?us-ascii?Q?QKvhrAVHlWcEq3DNEeuX74YqF8wzbbgSTw4XO8oc9ttVjEFYfCG/lCAtpbQT?=
 =?us-ascii?Q?2TjdyNtrlJQUq7PVNy3vLERVCYVZjIIE8C4KrZ7RjF9/5m2KK0AEJxSgs6wV?=
 =?us-ascii?Q?Nrm86+IcYGLFqHeE743rkuUmX0uL4MYBA60WPizM8olRSBej2V2yH5JW8k41?=
 =?us-ascii?Q?EMt8gxUQjupXDfdXtldauBKMfRLeY4AqOFd0K5cr5u+ZTpxjk7DLynbddSxh?=
 =?us-ascii?Q?7jtno2dtmohNRAAED9WEx3HVT8/1/cQ8XgPRKUkMgo+pJy4mFygsy2uzJCMK?=
 =?us-ascii?Q?Wizca9U7J0OQa4tJQgo0dG3PlmXEZuC0HALHRv8jW0u3ZkmxvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJDj3/BN84Lf/JypQbLQStfa6TNjqDzyuyQyILtqOst3JxVzpZ5/yzpz5uDv?=
 =?us-ascii?Q?dPuM9zh8d8thYiTiZXDTWBzrrs6Y6OJiN4CZifcgoSesMWFJFkc8ebVQXkP0?=
 =?us-ascii?Q?YRXSvCeDlo0z3wf4141hSfgprJOHBBh4GjsCPcdG4tqBkvURpFgp+PoCVpmz?=
 =?us-ascii?Q?fruNEqPDR2TKD9Eq8F2kqbRTozC2uxlvIV3KuvKpIe3aJkCQedkx6EBU0A5r?=
 =?us-ascii?Q?Dr/naet1Ul7SnJ5jEPP8yNBRpUWP4BWrqrhRZZhU0gvhl2Kta6R/0xTqaQzR?=
 =?us-ascii?Q?FYZGfwnx6AQa4h9I4WtD5YqO/gLMCaf6weSBIHqRYoa3hrWR2xTq0LyO7URL?=
 =?us-ascii?Q?540BE/ZAAWnx0PnTjF6YSoktBVD+sAvjr7kPkwEby57gbSRpT+2pGzpCDUAP?=
 =?us-ascii?Q?HCFPV54BEnFC+u2WRmi8WUXGgUUiLK/zV3hfQpLsmD4228tqquIvF2nJ/8lM?=
 =?us-ascii?Q?4I6ezZop/KegEK9AlMmaMNiULD9aXfMg02Y2VgRdhR8lWGHtKbwfOE6VvIJV?=
 =?us-ascii?Q?UY7PNej8IuN4ca+3NuNBqAyPT2Duk/meAmeodDK9MBFiGU6dcpaauPo7RgR1?=
 =?us-ascii?Q?jXyJOCu728eZmEpzezW/fhJzL3kT8DDhlgRmg76oYReMzeFaUaTL76Vitt9Q?=
 =?us-ascii?Q?nI2H9mGmW8av/NZmnGDiGQ5kblyS9he0npcySXVkXbZGke4vny5ry/G4A3mJ?=
 =?us-ascii?Q?03qfYBehOibx7ydmdS8Lf30HfbreyXmu+fOKU7RKphD704sq1hqe5yTQD5fr?=
 =?us-ascii?Q?0qwXzJ8cmpAdvqLnMvudFdmiPfJexKOpd6p0wi8aApemp64CIlSe+NJVKk/6?=
 =?us-ascii?Q?c9SWTwzAf1lYNZOoeyNgVkqz3k5H6p7W9qaxczX99+rm3xF42OPNc9Y9bsMS?=
 =?us-ascii?Q?jsDN2b+rgT9wockpxA+6oZlK3mjhXbs2y0GQCl/coMwBgeGBDr5M5iL6fNBW?=
 =?us-ascii?Q?EQl6zX5y6fdsgzDoOeQv3Ilq7+O5Raj99W8MXaFfHf55cXdSgOMNL5w8Bk2O?=
 =?us-ascii?Q?1Q4/wCPynAqFbhOlt2G90Q08Eqmua0eAcCP4k94Vrcf8fpBtEpmpOBsvT05I?=
 =?us-ascii?Q?ez66on89FMsLJEDTJPOxvnA/ieg1IJYhlkJ3D3LuIDl29+hpjeusO9EMJHl7?=
 =?us-ascii?Q?OsaKpJtO74ej5hZ9LkiH+7+v/8Eo/+ies46nlUEyDJay99YkWJNzRT26HxZn?=
 =?us-ascii?Q?ZEnTED+stdYEgBrdjpDhfKfjVdAYKjiHwqWPRwsUUMLp3/oon2rbwk3tcLo9?=
 =?us-ascii?Q?gu22/Y9KBv2BeOXbYfjQNvL6xsQ4kiM0gID1yGNXvM7+H9PWwoVZT0oHaySO?=
 =?us-ascii?Q?hcidEoL/Zq097rG9Y+HthciREGnL+Q5xYue/2dv9LLKAd8B/kBiF4i0Vo0qA?=
 =?us-ascii?Q?0XcqGV9smEKLqwBNSCUGp6+0SmZjT3ddjOIRbb2Q9FAIkX8xhWL93J0uELU0?=
 =?us-ascii?Q?DeaTIqzLnpVznpS4NcDPiopZmeEWgZW5aYOyfQ79CCmcON1HbeKk4txNMR6/?=
 =?us-ascii?Q?pv3mptwMRjsGOR/50jlrMl7MxQ8ZNCC6Np3cKheHXHu+0/1873gvcWZXEe/2?=
 =?us-ascii?Q?W4wB5xuVYX5KGl8yK4SgE3LR1a/6nhkDZL3vDRxzfs97umSweWutSTcBOR7H?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a780f291-1f41-4ebd-079c-08dc98609c90
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 17:26:29.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+Yo7RNDLkgdLCyZMhIYh1lRaT+bZX/waTyrZ9Gg8Ne8dUfLk8Xe3MH3aKkclFzZVPlIKe4+txxRn//Tag4ZeszFJEhS2ID2WbfuM4KL6J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:11PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The depmod.d configuration order/handling aligns with existing tools
>such as sysctl.d, even though there is no mention in the manual.
>
>Reorder the list in SYNOPSIS and add a bit of verbiage describing things.
>
>Section is copied^Winspired by sysctl.d(5) ;-)
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
> man/Makefile.am    |  1 +
> man/depmod.d.5.scd | 22 ++++++++++++++++++----
> 2 files changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/man/Makefile.am b/man/Makefile.am
>index 25135e9..181f619 100644
>--- a/man/Makefile.am
>+++ b/man/Makefile.am
>@@ -15,6 +15,7 @@ CLEANFILES = $(dist_man_MANS)
>
> define generate_manpage
> 	$(AM_V_SCDOC)cat $< | \
>+	sed -e 's|@SYSCONFDIR@|$(sysconfdir)|g' | \
> 	sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' | \
> 	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
> 	$(SCDOC) > $@
>diff --git a/man/depmod.d.5.scd b/man/depmod.d.5.scd
>index 9cf99d5..9ee35e8 100644
>--- a/man/depmod.d.5.scd
>+++ b/man/depmod.d.5.scd
>@@ -6,15 +6,15 @@ depmod.d - Configuration directory for depmod
>
> # SYNOPSIS
>
>-/lib/depmod.d/\*.conf
>+@SYSCONFDIR@/depmod.d/\*.conf
>
>-@DISTCONFDIR@/depmod.d/\*.conf
>+/run/depmod.d/\*.conf
>
> /usr/local/lib/depmod.d/\*.conf
>
>-/run/depmod.d/\*.conf
>+@DISTCONFDIR@/depmod.d/\*.conf
>
>-/etc/depmod.d/\*.conf
>+/lib/depmod.d/\*.conf
>
> # DESCRIPTION
>
>@@ -29,6 +29,20 @@ lines and lines starting with '#' ignored (useful for adding comments). A '\\'
> at the end of a line causes it to continue on the next line, which makes the
> files a bit neater.
>
>+# CONFIGURATION DIRECTORIES AND PRECEDENCE
>+
>+Configuration files are read from directories in @SYSCONFDIR@/, /run/,
>+/usr/local/lib/, @DISTCONFDIR@/, and /lib/ in order of precedence, as listed in
>+the SYNOPSIS section above. Files must have the ".conf" extension. Files in
>+@SYSCONFDIR@/ override files with the same name in /run/, /usr/local/lib/,

ok until here.

>+@DISTCONFDIR@/, and /lib/. Files in /run/ override files with the same name
>+under /usr/, @DISTCONFDIR@/ and /lib/.

I actually find this odd. Why mention /run overriding /usr/ (that
was not mentioneed before), and not mention the other overrides?

>+
>+All configuration files are sorted by their filename in lexicographic order,
>+regardless of which of the directories they reside in. If multiple files specify
>+the same option, the entry in the file with the lexicographically latest name
>+will take precedence.

Looking at sysctl(8) and systemd-system.conf for inspiration, I'd write
something like:

	# CONFIGURATION DIRECTORIES AND PRECEDENCE

	Configuration files are read from directories in listed in SYNOPSYS in
	that order of precedence. Once a file of a given filename is loaded, any
	file of the same name in subsequent directories is ignored.

	All configuration files are sorted in lexicographic order, regardless of
	the directory they reside in. Configuration files can either be
	completely replaced (by having a new configuration file with the same
	name in a directory of higher priority) or partially replaced (by having
	a configuration file that is ordered later).

... or maybe also repeat the list of files like sysctl does to have it
all in one place.


thanks
Lucas De Marchi

>+
> # COMMANDS
>
> search _subdirectory..._
>
>-- 
>2.45.0
>
>
