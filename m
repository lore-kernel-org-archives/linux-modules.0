Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7118D
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711717; cv=fail; b=odRit6QI3/ofEUYu0kxeu3BOa5Vkk4MoPTKOyjSE2KKyqRuBfkusTQkOEAQ7/LJHl52mD0JecqSXByJh8KU/EVhK0lXhlfyvdkpiRSdTkQmM2RmUFRR72Aq+TzJG81T83T0uSpRntWe8+1S5Unf/TH58S92OK90+e2WDYRLhRuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711717; c=relaxed/simple;
	bh=QOh1lRspn1oghVkkCl3nU/3/ZPyLNtGlWWa5Dj4Jn+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+O8WxzL5UFK/lQJNzxzL34LJlI9p4a+njEc3hdjJ4WUbBIZIHnZb/kUXHiFJgLL6EMwr6Z+em2WZLZciJgxObDI7oN+It/j/qYbUjsO0LRWDRS4E5hE+V09EWRTaaI3pCFR9+nhgO0JGXdvYwGALz34wS1iICdqfoApp9ZcQUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN/tl65u; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN/tl65u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721711715; x=1753247715;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QOh1lRspn1oghVkkCl3nU/3/ZPyLNtGlWWa5Dj4Jn+E=;
  b=TN/tl65uoaLDR9mdl/8oEWCA59QBM42X9Ciy4AaBAeTwhhoUkqusemeO
   FdUUOj7mqj00sewDQnsTElGysVveaUGOCC2nNhgx8nj9/FRYduPlWkHC8
   wr9BmY375dTLcWrWG151BTbybV+nfQWxyYUDJAESkUaumRT+S4TlGZCTp
   5xWCnDGL/4fPfXrvlvJ0eiZ6FKRaKytNFIB+bZyEEweGs7OnZwkZWHy9V
   WX0BeDdu0Jn9qNzGAFyr1W2NSRAJNvLjTIQcJpH7WWJEFJPnILuOPu/qO
   QSVhaGK3uw2jCpDFIla7BrcRwOYBTgp+a8GfXJCNl7Z08xiiTZ7ZnbyUc
   A==;
X-CSE-ConnectionGUID: A5bs3SBPS9GFNCOd9mAoFQ==
X-CSE-MsgGUID: 80LblFN/TOmDFOh3Ck7xKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="44736478"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="44736478"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 22:15:14 -0700
X-CSE-ConnectionGUID: vatCZPlyT+6hGFQ5tacZOQ==
X-CSE-MsgGUID: REnaVanoS9ixghDaaYdwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51996783"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 22:15:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:15:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 22:15:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 22:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYT5YSvm5xJmpfFZB8Id/GouC4KuAyH2+9gpkVxNFWAx3YWhF/0uunR3lPdMMdjex+NjeFZGdHehrGEBM29UqmhW3Ver/Xm2CmtsnjRNOpk9AY3mlQcEKkcu12nTEpejU9cLDhGcUxVDRCqAwfYlqf/LF9UXomXhvaDwarpPI3ykLw/syMwyBccnfYhF9j3bf7txhnVCRHlzHrsxByQVKdQywwLpADzvkd4U4l1unRVEefqSfdV74AbteYXBe2VkaY93wlVfyUaEaFrWdhszmiDUuKRKHeb9zgj33Vwp1GXdYpyP3rpeJEE5e1zpK1zUmyh53wUeJKdK4BWl1yHIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svxw/RW7xbmbqJ93SnUve2TYdw2YamXaBO/fKC0WPxU=;
 b=ZULUzBQRgkWZw43PdWsUsOvk5Vkk5wS+Xy3SDJVyvgB9CyqNH/EWOpjMKs9hwJkYz0zF6uG0p4Lc4AVQHJZsfpKViMJI2u1uVk1Q2iT9+Zxd8h5GaHMEbA4yHSrHy7P/Ketex9oAD4Xi849rU2adAZ3otEivv+uQitwoj6qjg9lqft9AvJ3pxrJjOcckEn7WIfxPJR/akL4KbXAEaV5QXqVEARZS7hoRzvOP/6SHSAtRV5LpZzVWmW8NxhI7bIXEDlkxtPazVjIf7/mCw54wjazfNMGi/0wKcWU4IzOFCNhVNE3FOEk+32xDbO+LB0d+AC5llvVRcb2pMG4j84at/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 05:15:11 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 05:15:11 +0000
Date: Tue, 23 Jul 2024 00:15:08 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] Use SPDX header for license
Message-ID: <kfrqz3q6ecu3i7e6hz3cugsm2hf3nsum4jm3gmaji453irhlhq@ks4546ponk47>
References: <20240719221249.376162-1-lucas.de.marchi@gmail.com>
 <CACvgo52Gh269GHA29Mu7Sq2TWhLNqNJj5weBF8k_ZANfD3=4ug@mail.gmail.com>
 <yo6aq7kqlmwdkg2ls2gqpj4fpipgisbvd55cgn2fbkreru2rok@qjvn4oceb77u>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yo6aq7kqlmwdkg2ls2gqpj4fpipgisbvd55cgn2fbkreru2rok@qjvn4oceb77u>
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 50992143-63cf-497c-d874-08dcaad66d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cAStA3JUPe2VgsIyxxxX9WUhkcnnkoS6fl/nksYlAATPwdCNTcOR0Y3rG7?=
 =?iso-8859-1?Q?PsJIc2drneLunt0bDTcw1ULli6/Knjcz2ixOQ8hfmEBK2wJ+IdndApI900?=
 =?iso-8859-1?Q?bm6igiYEi+cWxZfM0i1xZx1PryVnJc++j14AClXEUgs3beBw/zSpnr4Oqy?=
 =?iso-8859-1?Q?2vDE1fPFvmOGBTInuXjyS3duHSw29yqowdJWoF58BAOKmSuQ4ovxHlpEoo?=
 =?iso-8859-1?Q?+pN9x/euyfPdugnZ2SDv2oMmZ874DyIAOA5QMiRJK7CCuilpNV9Ik8IAyY?=
 =?iso-8859-1?Q?zb+cyVvOj3TlCJ+A4BNwX1SYn08buNADYuL2dmEvJugPSbdjeouAF7C7rH?=
 =?iso-8859-1?Q?lRBuud/6MDYwozQsTQ2bBnOq/f6yhIArk2yRmJvXyd3FCJMz0G/CoSysPY?=
 =?iso-8859-1?Q?x7lUvc1bY5T2f++UBysY28lXm0u7eMnbTDVnLzPJaBnxR5SCuwqxQy/IBL?=
 =?iso-8859-1?Q?+e1peI2OQjNTnzn2B3RAhcw4JNJ3neY/5XmLmfQpfGqG3kOJ/XXH3/IRQh?=
 =?iso-8859-1?Q?OvCQsc+vlPpPqlYjc0UX0zS8FJDQOKgZs+YFSJnrV4NtgwXCRo4N8m15qJ?=
 =?iso-8859-1?Q?TpcX170oG09n/J6zuECVfVLnBD6DXLd3fw82s2ku4HMZewOoklvKlBgcZ4?=
 =?iso-8859-1?Q?8mvt6CPL7PwFiR3w29zLYWvzQgq//g/q5/Yyb3UHQ4yS8Wv19gI+VInhdd?=
 =?iso-8859-1?Q?PUzbGlFHWoe+dRE2w301SOPOHt3Krr2mhO5nEtifCSaAKXJYg6r8UESSC3?=
 =?iso-8859-1?Q?dye84sMLihmSyH7flwijdMa37YznMsi3woFp4kTfEBnoZQc9NaLj45EUlO?=
 =?iso-8859-1?Q?bIbo2gWgUdUCwUEr0CLyWG2pWs10YsWXo4/KT1+hGbk18Ha598MQ6d8TJf?=
 =?iso-8859-1?Q?Hklhcrz9jBXVZ+n9BZ9GntGU3PZdGA2ENhpbOFN9u20Jj6uhyd2mTQGbq4?=
 =?iso-8859-1?Q?SvwqMILmRfAOzDCFNWPN+mAMFDGMd6s9I63uqMG8bRC890WHjCUhi8PhEY?=
 =?iso-8859-1?Q?5twvRe/1XQ7YB4EwrE91pNy8LIAVZVUieDXd/W8/lRYcyye7XLh6IAUhLQ?=
 =?iso-8859-1?Q?yIIOpSKjRDpBb56a/3JS5zX+rwLSJQhv3mRJrs5j5WSx5fJyHPj1XKrNzr?=
 =?iso-8859-1?Q?YL6LoXYCCNQRUVcIxbdFMDek7XtkKT65HmL7IeXfEi5ZIOnpUfS7j36Q/z?=
 =?iso-8859-1?Q?xK7S1NXkNckCvPnXszpwUFCPcTdLYX6Pafh+xi8ESSh4Ucwj8A+mSHQAQL?=
 =?iso-8859-1?Q?Bdb3uIi6+5m6r5uSb24VE8gUZZKHSEfNO5DipbFzrAMmiY0Udbp178qPeg?=
 =?iso-8859-1?Q?OECNjJRrObGf4ncXmiMdaBV7rA0e4MORX0Mvy0Hz4Fh95gc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?i1FY5BB8LRE2Ei77DhHh/baGNLwCEXKve6DiGsXBCmUWeaIxPq/tQj536V?=
 =?iso-8859-1?Q?0SJS5DwdCEJrGQVXZ7UqOGl8watOwTXZcx+UKJb09SZbRxP27Woif5D+Bo?=
 =?iso-8859-1?Q?+5zbRC+PIZu3kgtdFwVKdde0BpWHl98S/kugD+xgQPiYL7m69NKq3+/3X2?=
 =?iso-8859-1?Q?0vpPtN3uumIYDjB+eEFcpjDLGT8Ykuhtkkbln5r4le/WpTvZahQTS2j0pL?=
 =?iso-8859-1?Q?tgZfh52YZb+luSWn8rZ3JQ5ceITV5RwHfNZdOrPKViu+Itzhy4iN4wMzVa?=
 =?iso-8859-1?Q?7dEkr69g2KlXUDNBLwA5Q7LEVT1um4UsfD4WIPUA//SsKret+/zOL60fDL?=
 =?iso-8859-1?Q?zpX76m6jy7tzX3hPzHHuMwF7zIPZlO931Ipz4Lcj6KJdPVzOA35D7uCgXf?=
 =?iso-8859-1?Q?DZUQqE2VZjvKJpfSOo+E+jc7gnBm5ogOwvFQmJLZR/wVKTeO1XCXGFjWeP?=
 =?iso-8859-1?Q?gshjqUry780e/P3ZNLZ75I6y7Sw6Hu/Vii0CgCFARbpBEOVvKFPVXZhKDw?=
 =?iso-8859-1?Q?GnL9Ril9UwQfamCv5X8MJMXPuWBUaelOfnknlmjC29kYfEpaW7QAZlPSpa?=
 =?iso-8859-1?Q?waqeTGoir01zZReBz3Q1wp8V/ly1XMaz7stAqYQvfomB1M2hmWPu9FTQo9?=
 =?iso-8859-1?Q?bLxcxdy7hcq5I1apt909615AZbwoHPx2683M4I27qpE+/LT0z8Q6CfVX26?=
 =?iso-8859-1?Q?YhjwQLE7j/peaa2ibSsjYzb09E/CY4YNwT1okVHsvK8KXLvEAWa8xcRvxj?=
 =?iso-8859-1?Q?UVTkW6SMmDM1s/jl2b0PBMq1g4mmB1zOJYPZbsQkf4k2VZV8PTBsAV0aXa?=
 =?iso-8859-1?Q?roL8iqh7vfaSY8PwGtg+93SI3vVEtLGMU/08Us+anwoNBkPT8uiPiZLmpI?=
 =?iso-8859-1?Q?7K73WW543WFGnL2Qjdijsoxk7BenYAixOQZR6yRtnyDNRnhvz1sK+CBgvE?=
 =?iso-8859-1?Q?BLHsNoFojtdh/Q1Q5+nZko87qQg1a4huT3jcgCG4ujAj8z/K/ZRHtKJYpy?=
 =?iso-8859-1?Q?fl1mvD6oF1Pb/lhdqzgpAxfVhk9f1jHBdn70tKiHG9jfiq1feA3DzSdaPb?=
 =?iso-8859-1?Q?O3pYdTuiXZpurcHVNCA4zI/PM1B6vggpTzMVd2Ga5RDUhgUx92VYg96Yn1?=
 =?iso-8859-1?Q?MVePqLNcundf2NbGERJXeRoF6bSobvjQrO7EfaKAXgyAjltdDSKNrBoJ24?=
 =?iso-8859-1?Q?6LssLOfDxYWQ7gq+fOhk0xXY/20N48M6eUGrddljQt6SWGLm9RNtSFw4hE?=
 =?iso-8859-1?Q?pe4LMorufU4yPwo+A5P+Hb8d1JydJwvTvbeBAkLCoabOcHyeKZgdlE3KoP?=
 =?iso-8859-1?Q?ftlj+JSTacwKVCEd/HXBQURuYDYYnWT+lJ/vhkvfk4khg63oSOZfX1EQBu?=
 =?iso-8859-1?Q?mFfzm38gUcA6mC3oyDBXDzWoYS1lmgE83HDGDZ0ll2+AcwixhS1ZxjjKy8?=
 =?iso-8859-1?Q?PCvD5OASVPdj5fmQ7wS14O756vKmcIkes5iSD02axByw5iLVCD7cACVf1+?=
 =?iso-8859-1?Q?Qsb3VPja3gH8Xsu3QaaU09nxiAPnQj5IJInmDqGuPrMOo729SBMa27hU+F?=
 =?iso-8859-1?Q?im8lB7BBHo2r3FOdaRSVmt3lAqGwxlI6NTp6Mt/+Qpwg1T1eam3Su+ncpS?=
 =?iso-8859-1?Q?jVtmozN3rBDt0IPsfgoXCTonFo13Wb0nJ6wfudwoLkCUjrvCqefqFgdA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50992143-63cf-497c-d874-08dcaad66d3e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 05:15:11.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPDXURfaGJ0r+a1uwB4gBhQxgAFFYNAS1bydsjBgkHL3yunAkzM/r7YQWGBpWl8J+q6dRkXmkIpgMNUOIHamJVt1LbuAzJ9A4a+geR6h3nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com

On Sat, Jul 20, 2024 at 09:48:51PM GMT, Lucas De Marchi wrote:
>On Sat, Jul 20, 2024 at 04:39:05PM GMT, Emil Velikov wrote:
>>On Fri, 19 Jul 2024 at 23:13, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>>>
>>>Drop the lengthy license from each file and just use SPDX like most
>>>projects nowadays.
>>>
>>
>>Massive +1 for the idea, I should go and update some of my other projects.
>>
>>>Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>>>---
>>
>><snip>
>>
>>>--- a/libkmod/libkmod-config.c
>>>+++ b/libkmod/libkmod-config.c
>>>@@ -1,21 +1,7 @@
>>>+// SPDX-License-Identifier: LGPL-2.1-or-later
>>> /*
>>>- * libkmod - interface to kernel module operations
>>>- *
>>>- * Copyright (C) 2011-2013  ProFUSION embedded systems
>>>- * Copyright (C) 2013  Intel Corporation. All rights reserved.
>>>- *
>>>- * This library is free software; you can redistribute it and/or
>>>- * modify it under the terms of the GNU Lesser General Public
>>>- * License as published by the Free Software Foundation; either
>>>- * version 2.1 of the License, or (at your option) any later version.
>>>- *
>>>- * This library is distributed in the hope that it will be useful,
>>>- * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>- * Lesser General Puc License for more details.
>>>- *
>>>- * You should have received a copy of the GNU Lesser General Public
>>>- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>>+ * Copyright © 2011-2013 ProFUSION embedded systems
>>>+ * Copyright © 2013-2024 Intel Corporation
>>>  */
>>>
>>
>>The commit is few somewhat unrelated things. Since dealing with
>>legalese is rarely fun, perhaps we can err on the verbose side and
>>split things?
>>Namely:
>>- replaces license verbiage with SPDX one-liner
>>- updates Intel copyright statement - would it make sense to your
>>@intel email as author here?
>
>I hate to have author in these lines and recommend people to look at git
>blame
>
>as for the updated statement, see below
>
>>- (C) -> © update the ProFUSION copyright statement - LF's LFC191 [1]
>>and SPDX [2] lists these as analogous to "Copyright" alone
>
>using both the symbol (or (C) ascii-only variant) plus the spelled out
>"Copyright" is what is commonly used in the kernel. AFAICS the reference
>you gave is only about parsing the line and handling all of them being
>the same thing.
>
>>- drops the libkmod description one-liners
>>
>>Four commits might be an overkill - license vs rest should be good IMHO.
>>
>>Btw you can also use SPDX-FileCopyrightText [3].
>
>I like to follow what kernel is doing since the project is very tied to
>the kernel... this thread is relevant:
>https://lore.kernel.org/lkml/YyBl%2FFUVndtEFkW9@kroah.com/
>
>For the Intel one, I just got the one that I know it's approved since
>it's being constantly added to the kernel. So I just paste it everywhere
>updating the year.


thinking again, maybe the sanest approach would be to just do your 1st
item... kind of what the kernel did. And then maybe a second patch with
the last item you mentioned. With that, we just leave the copyright
notices alone :)

Lucas De Marchi

>
>Lucas De Marchi
>
>>
>>HTH
>>-Emil
>>
>>[1] https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/
>>[2] https://spdx.github.io/spdx-spec/v2.3/license-matching-guidelines-and-templates/#b102-guideline
>>[3] https://spdx.github.io/spdx-spec/v2.3/file-tags/
