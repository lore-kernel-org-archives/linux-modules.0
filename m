Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1B13DBA0
	for <linux-modules@vger.kernel.org>; Fri, 28 Mar 2025 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135246; cv=fail; b=XQXVMUPwfVQmioIDqA51+oQwdlkvjzsLsPoU5P3RZ2DnAiVQEvRBk9KabKL2gD0SCjcFRPX8BCbfLVxXpYrLk+Cj2NQuqSah400HPLwMLGZkVMhCdw5W8uIeMGc9RQT9Bqrk8HZsIBdZhf3+t3uXaYQ3gF0uSCMt3eJkEMkviqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135246; c=relaxed/simple;
	bh=Fpot/8c0VLg2TCSMnNHu2HZcskoHBPODaEEs16CDXTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Li03Dkm1V8Cc2rMMQZxwRMlIcR8fNKDeDEpPrjKG2zzIgh/Jl+H9aPZGU/l6HPnd6KHT2IBXabTjM8hGhQ93TkvPO9z/2EQ5JGqd7E0/IFhNxWsBgkn6nTAOzYmZAUcW/DNmweRZI3z8QeZ4wqprOIZid9NgkjO1a/vZQpv5RiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7owVX+F; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7owVX+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743135244; x=1774671244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fpot/8c0VLg2TCSMnNHu2HZcskoHBPODaEEs16CDXTc=;
  b=E7owVX+FHZ6hceLmrVGCnBW9jWgNZdBmzIQXRweGhMgX6K9RBGrWsxSd
   yH/PxMTmQLgupI85RBpbSZeO4YORBBsJXqG1Cnclc4M8VjKsHeTmBe+ZQ
   KIK5txDHoZVds0ewAa3zM2ef3HdKaw9RCi/o/S14tmuW6DLBvYb6mOsIO
   lrcp1/SpVYR/uancoUg6MqXx3kFkwQw6BBT0RVxedjQ0jnlIXoBGf2R8p
   cbWT1oYI45ujzJXZRM2iSkYTt9/em4T0Hsb8ngNyGduIwF0l9Tdj3iN1M
   21iEH6tM2GFPCYlcg1XZLoXNXK3Ww4fFnfRgGhems6Izw9jo+EeoHZMvR
   g==;
X-CSE-ConnectionGUID: E+OoIoDISoaFpw0Ib2FT2w==
X-CSE-MsgGUID: PBs7SetHT/yKpKcEtr5AMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54693059"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="54693059"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 21:14:04 -0700
X-CSE-ConnectionGUID: WGTw1uKaRVmQCHg9DCy46Q==
X-CSE-MsgGUID: kndmVTgXQeGFqa0foCRNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="125139519"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 21:14:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 21:14:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 21:14:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 21:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYpubBL2p06Wailo2gm1Xfa9WlUlIdPTUkSw2G4GkYiLjBU66kUJOwx8xjzDmvMGfGSN5TPlpTcwG81cqGgNBho6xwZ55z4T3yITIIm+admUAC3aqYfytcPDOmAwec7wgv7yY6fXywEfQG9iTzGF2mE2mXcFKXX0gsMsUPJLxIEJT9/Kk9eMSyRDHB337M/Rg5zBPhQ+cfj5lP5PF+iPAQXT31AEXlWx07xANAgcrc8dVMgs4FNi13KqsCPM8jGkiUjP0C8i5CmJXwl/5D+JfbHWZ7qVrwQcXyqaFYI1FzkeTq7Ifo2TqeR0KrUe4aUIO4bQuyKGIuzsZuc+fQZSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYwMhZupyTWGQ33curZ4NdCrDugmR42fLXOgdQ5F21E=;
 b=l6jrmXDxdhzRnrj0/AW99dvb5dNC8e41KSmS/agvE3S/qh9NeCFOvuMji1VIgNy2PChVAtS67Vl4MADMNxGmGk1ppMERSdUWEZlsx8K9HrsWSoPuuRGcNEnytU5tKMBuDWmB/9ZYVomVkv4sTApNa12DMw+BBuMT0NRkR3tRZSfm8nECwtoSSTCIiJJqXflrjbv3S+dP7g6+TMmRF8bBWs/GurNZpwtxqJ9UKVwGvs9zU/U93SyWDjY5UBP4GMYCZs299Uis1gvxdxtNoOfxcfnlV4V1ryYU0z1/ybmTJD3lwXHz/MOqSqSuMt/YqYs8ntKrv0O4+tCn5spuSZwnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:13:45 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 04:13:45 +0000
Date: Thu, 27 Mar 2025 23:13:41 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yannick Le Pennec <yannick.lepennec@live.fr>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] tools/rmmod: fix garbled error message
Message-ID: <igg6ghsjjn7ciboakccpavw3vbjssk23mhab5nbe7qpaqap7kk@6btizzrn26y3>
References: <VI1PR02MB48291E3BDB7E764ED67154949BA42@VI1PR02MB4829.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <VI1PR02MB48291E3BDB7E764ED67154949BA42@VI1PR02MB4829.eurprd02.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 161549a6-6fb1-4ecd-4d01-08dd6daeeea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T/kh4EkFzsS1CkIUW50CZw3DBx4B/EbHwH2iF/gjCn9/Gi34VWV+djhvV+7n?=
 =?us-ascii?Q?7bYuibVeEHlzZikM7Yd58JwoWWQhRDfp//ETbpTVbsz3V8SABbCN+ib9bgk8?=
 =?us-ascii?Q?qNyaek9OlqMhb9aOBOeGoBCIT9dT5murrz2SGaxX2gnDEg91Ec2Y6O9JZbbe?=
 =?us-ascii?Q?/etiyMaMUGxYbKTUyP6QO3jz8vg8kXNxJn16z6uAdcpX4Yzw/+B3zxHPgzks?=
 =?us-ascii?Q?bk5nhtkzcmdUdFBd7JDrKHSV9eICoVqivU9aY6J8LhaTq3YJtL3jPFhvZ7mK?=
 =?us-ascii?Q?5J+gh4BwO6DRizdzazfpgM31VgxMRg9v+js9157u+dSXQdhz0/CtVk7gTolJ?=
 =?us-ascii?Q?682zZ5RulJpDfbLPlxgKzKs+NQ+Hhj/DVYOQAoFrF5ltYPZyLys2nNSymsnP?=
 =?us-ascii?Q?XNHLVLoBZoEVfLTFBJDqP0UpNIjJrF2n473VkFPNxD4kfApnXZOsd06gw1GE?=
 =?us-ascii?Q?MLe7C/j++NNheHIG7ii8Gk2AIrycFh4Y3aO728s5uI0fEU37KQ7YkoCmaS/t?=
 =?us-ascii?Q?zvivOer3Iwjjo+GDL723Ab7Wn4og/QVy+alXWKIfTRDFNxPfDmCyQkFBUdaJ?=
 =?us-ascii?Q?Vg8HD4mbBOogeeEstIXVlMlMeQdeJXL7HThBQO55p+9hjC43C+iQIev9JXrv?=
 =?us-ascii?Q?zju3nCOIC2uvFtdN/4GW1rcrcF+sYQQcCnUSYdFKsa/ZarDiK7OOQskXTNl4?=
 =?us-ascii?Q?G9N611ChxRgFaoK0eVP59IeHRmgW2D7c7VLiKs+K3xyqa3mOyxe4rO6rlli6?=
 =?us-ascii?Q?0F37u2wRcWgIviI/vlkeEZ61uXGRJT++CZs+vixEyG13GPsdNjeVGIz0Xteg?=
 =?us-ascii?Q?kNqbcT20wc0AbC7WYKirRn1/XLl9vL8TEPTZPnC/GX1jBIfJMf37nNkDU1iC?=
 =?us-ascii?Q?55dVqKn0+Krh1KwWH5rpBzz5JZmiBvS/JFqOZNmbFlvhqmXtrdt0CbTYgePY?=
 =?us-ascii?Q?rQAkSSYIfLIQm+BairdlHienkmyVV//xknonX/gPjNXZaDKi69l9ro898KPI?=
 =?us-ascii?Q?5yOkRF5vh18w20dC0EWiL/vuyFzu+E4p5XaNhbvqZNUF/ZN4uclnioBx4gea?=
 =?us-ascii?Q?b2z9HP5lqRyPi+dU7581gPIDOPulrlHF9Ls/2gVbuFv9ZCNOIgYIQqXcYUlR?=
 =?us-ascii?Q?P6a6HmXHZlCfHOye+yNgya+cltPaoy8ZOK451Z+lmenNdju8WWm8cHY8nROW?=
 =?us-ascii?Q?DLQ7gzZTAJvSHgiYqxNlr/oZwhOotqK8iVxF1a2TAqWHWUyI6Uzm0j0JY1Oy?=
 =?us-ascii?Q?OsAysikqqanZmzkJmwWjIw7eWgpsSRzhhsE557KyBYcCKn+VJgczyaKF5ReW?=
 =?us-ascii?Q?+yDYlUdTD8ftNF/LuIzXQCDjhSn1WWGivvrOiWy+72/RfMCcmJavW/0STKZ5?=
 =?us-ascii?Q?N5QNUmCYJGUTU0O9Wm82j7LJupOJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWbamnnq2dLA7T8lrjgmiVjr0WOEb4Cvg3SRew46ZD5upvYDFtZgC4Fnz8qt?=
 =?us-ascii?Q?VzEQY7JYOL2sXIBOhQO0VGrXkVOMAMavQ4Jt2yJOs7sIa4hvSVv8RfT8do2H?=
 =?us-ascii?Q?iKQXrwpJzjIk3FDITRwHIloEgEYqLdt9ZlHjnjnOrt5b8MbCA+SBCyhdWUkd?=
 =?us-ascii?Q?7JKdgMgwh2bCAY3OoFUS7f/W+N/8Ah/zHKguk30Se2rkFfiZDc6OTlucUOAJ?=
 =?us-ascii?Q?lNtKC3ZNaLTUwbheQ6EnskWz8Qk140Clfm59bS5OVtq9GvAJ/wrS6sKBM+ze?=
 =?us-ascii?Q?TOXrqWYABRcgj6hsxcP4rObAjz8SNCnp1oxFPwsqpwm4dspeH/knt4K3g0vx?=
 =?us-ascii?Q?L4ZCj2cgD97VsA3bSTfiEW0QSxClzAaAhLsTqtsPUGA8iUHgVibB6WOguTYx?=
 =?us-ascii?Q?qr0s5kW43kvmmlqzJJdiV3uop0oa9qQf7mwa6IP7ETkprfqXzdClTj8D8tJI?=
 =?us-ascii?Q?u1SIv+QfZJg5VMa0gWDoY78zkRkRo5Pv6mfcpiPvlRGbTyHDHmU20J2mhluz?=
 =?us-ascii?Q?n0xTegG6piy8OrPJHvs7PRZ45nOcPHufsE1l4YHj/aGotZNkzkw8+T2rUQnM?=
 =?us-ascii?Q?NcdktMm1THhRcexFbGl3TSTMw/x7tkrXPimLP8M+e37UJYDIIlyZfdI+xkfH?=
 =?us-ascii?Q?1UuoomtCv6AlXVp4+4eMiCCkeuus/pqvVri8/J0bwrjwTrR2bs711uZqLnfa?=
 =?us-ascii?Q?zD7okZkLIIyydUODvHQg49mOQJi9KmKfobUwsWhIYnUY4HKG0dzHxkFe1dhN?=
 =?us-ascii?Q?Jn82OhMRAmDyICV6ItuzrXdA9PpgZbrdTXjeSRzb0OmbU4ephkLYN3h6Jsmy?=
 =?us-ascii?Q?pLyQq9Fx8FExBo+FEI2Ijiizp41IuHeVcfR3M2gpYp4HdWQi7nDc8/1zjq2m?=
 =?us-ascii?Q?bBXanbv7xkjHplDor0BvPbbc4Cs0BolkzTzYghJGTd8St/Q/jffW6QPCvfjj?=
 =?us-ascii?Q?BEMbCbh/P5WvCIwOzfLPoC1zudBNZMqBb7XeB0TlIuADWLTw1DaUFNcinb/s?=
 =?us-ascii?Q?HGGbI0Ot0YHSUe0fmmM7yHASyQPGRzv6dy159tD+qqezNovy2ZCsuBx1U2F+?=
 =?us-ascii?Q?uiPFf5CTl4ugqIYpgvcpAdBH90Vn7Fl9CqGMDDml/0F5pLdOw1LQ5xLtRAn9?=
 =?us-ascii?Q?ty/eWrh4vQXXMDo2jVILPNvE3UrWsYKijc1xM3ZD1v84fLtUZ4CfvAXwnMK6?=
 =?us-ascii?Q?4mEFpFMwT+Xob9YgPrxYep13EDO7YMvu42gWR9NwHYkxU0b9FMNAE33ArHbu?=
 =?us-ascii?Q?wFAPZ49t2LqkKwJGsketJ8EqLRCNEr5q9C9lDIIzPeXdYn4it0+FBWHFSkcE?=
 =?us-ascii?Q?c58m7QdoBGIXLiETM64TJICeRS8y1WHEFCEUx8Q4c2h60uNOEU0fAfYLmExN?=
 =?us-ascii?Q?/NnXkY2iejIYOQyIDNyXws1zJYyKjiggZV9jr64lm6vtsUlaOb7GnnLtEhC9?=
 =?us-ascii?Q?OKbL/uhp2lzvnaAN7QuqrVG3mZrKhKndZlkh30bOize0zN66nvd45TjoKUZj?=
 =?us-ascii?Q?+5QXdQclxdqp3U9ac5RbeJHdqod2BgKdunG1ByOGc2AROe5nWLiKPRu7SeS3?=
 =?us-ascii?Q?ernQIr3G/D52vxi9iYPK1l0hN0Vui2v7VPtpNeZ91peduO+Vc02MKVYQ3Bfp?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 161549a6-6fb1-4ecd-4d01-08dd6daeeea9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 04:13:45.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8jx0J3CvYJrJK8OUoAzKi9Q7QxZsoALjwI4GltKlsQ1RRxU3LfSdUlV16jkopaTLU4XfosUgrYh5w+w2jGCXKkBPFO//w0AT5ENH6+rUeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
X-OriginatorOrg: intel.com

On Mon, Mar 24, 2025 at 06:35:53PM +0100, Yannick Le Pennec wrote:
>a6f9cd0 ("tools/rmmod: consistently use ERR logging facility") fixed
>the split between syslog and stderr of various error message substrings
>by calling the ERR macro instead of writing directly to stderr, but in
>doing so also completely mangled the output because the ERR macro
>decorates its arguments:
>
>    $ rmmod iwlwifi
>    rmmod: ERROR: Module iwlwifi is in use by:rmmod: ERROR:  iwlmvmrmmod: ERROR:
>
>And in syslog:
>
>    $ rmmod -s iwlwifi
>    2025-03-24T17:22:34.878318+01:00 mangolassi rmmod: ERROR: Module iwlwifi is in use by:
>    2025-03-24T17:22:34.889145+01:00 mangolassi rmmod: ERROR:  iwlmvm
>    2025-03-24T17:22:34.889224+01:00 mangolassi rmmod: ERROR:
>
>This commit fixes that by building the holder names list with a strbuf
>and then passes the whole thing at once to ERR.

doesn't that mean the syslog version will only have 1 ERROR now?

anyway, queued for CI at https://github.com/kmod-project/kmod/pull/328

thanks
Lucas De Marchi

>
>Fixes: a6f9cd0 ("tools/rmmod: consistently use ERR logging facility")
>Signed-off-by: Yannick Le Pennec <yannick.lepennec@live.fr>
>---
> tools/rmmod.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/tools/rmmod.c b/tools/rmmod.c
>index 962d850..61f2e00 100644
>--- a/tools/rmmod.c
>+++ b/tools/rmmod.c
>@@ -15,6 +15,7 @@
> #include <sys/types.h>
>
> #include <shared/macro.h>
>+#include <shared/strbuf.h>
>
> #include <libkmod/libkmod.h>
>
>@@ -63,16 +64,18 @@ static int check_module_inuse(struct kmod_module *mod)
>
> 	holders = kmod_module_get_holders(mod);
> 	if (holders != NULL) {
>+		DECLARE_STRBUF_WITH_STACK(buf, 128);
> 		struct kmod_list *itr;
>
>-		ERR("Module %s is in use by:", kmod_module_get_name(mod));
>-
> 		kmod_list_foreach(itr, holders) {
> 			struct kmod_module *hm = kmod_module_get_module(itr);
>-			ERR(" %s", kmod_module_get_name(hm));
>+			strbuf_pushchar(&buf, ' ');
>+			strbuf_pushchars(&buf, kmod_module_get_name(hm));
> 			kmod_module_unref(hm);
> 		}
>-		ERR("\n");
>+
>+		ERR("Module %s is in use by:%s\n", kmod_module_get_name(mod),
>+		    strbuf_str(&buf));
>
> 		kmod_module_unref_list(holders);
> 		return -EBUSY;
>-- 
>2.49.0
