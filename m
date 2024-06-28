Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855757F7FD
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611320; cv=fail; b=P+us1xXboN2rHqF17Z7T7GiyGmHZ2Q7Dr0n73cfk44ha0eru8L4XiSqgGjryJ4KAMCjVlgcYKZfNgD5OREbwQkAeZ2+/sTGDHNirbKf+Hgha87C/zOCS7FsQsySsTcuvdLPIUPn+YFarmTL68JtOFQQJ4II5IhEtB48P501nLEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611320; c=relaxed/simple;
	bh=L2JpE5yrsELh5a9YKOKrNgAobQY6vtKSOcSjrTtuc2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJVKXfeRUEkHgT3vmIps0E/GnwLr02wGIHgbiRxN9OgprFX078ro53uqWMDaQIJDlowMMY08tV/KjecelnFuSjGgGsTvdMRi9xensimC2/VjbGHXGhBm48vNepyAdCaeBD+5dx3/9iLL2hWsUXI03TE1F31ML2PlQa0F6CW4rBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S25Kuadw; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S25Kuadw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611317; x=1751147317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L2JpE5yrsELh5a9YKOKrNgAobQY6vtKSOcSjrTtuc2U=;
  b=S25KuadwEAXhoqFSlWeRJGUz2KcMdVEDS4f3naB/X3gfGo6aLYPWefnz
   e+5JmGBCsrq/csgFo6AnJYtay6ZyisVgSxjcg1GCcODcC8f3clS8ujEn2
   ZG5gZAHHjG3sf0EUBxiAXzEHLDDhvV5yVmxatiemL3r50K2SPvQdXs8rB
   xeozlw+RUVDYEt5UkhRaGCyvTVZhZ16KODB5zCqVTBVP0RO/7Wt2w1fDS
   viL3Kfj5pB2yzSUjClLaXnL5VX37h907bvgumqdgZbNb8f6B6PcRTruGK
   oxdacPxCKStjA6Jy1CH0FFWt1ahlke7dBvx842ZeoeV/JW8eYODBQzsuk
   w==;
X-CSE-ConnectionGUID: nO83CVQrQ0ux1cj7/sLkwg==
X-CSE-MsgGUID: cCC9BITtQi6i+z6HBIFNVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27940739"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="27940739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:48:37 -0700
X-CSE-ConnectionGUID: LYEaXHcYRUqXZKC2OM7qOA==
X-CSE-MsgGUID: dz/U/H9WTSSr1OshdK/X1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="82413552"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 14:48:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 14:48:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 14:48:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 14:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey96/8YbrrUmhMyoOLKJI9CQ1USXT2zkVkDgjXQjGYSK6ClPJUhpYZRn9faAYsI3FLg9ZlbSnkDYEfT3+EsGUWVRk1GLdow7+HMQzQK1pU7C+jmuyp/uSZtjHgkAlVhpWbpxXIRzp3pGZai06hQMvDyPhxHA9SuDIewB11f3DT91Vj1FOCuxvV64xnZa5MaBeBGQh+WATRdFusVsQDgaOgoF2pgLrRr6lIDnMorrKtWgQXMmhBLQn4MW/MIiuvh988ptxYYYVE40OKQ773kNZt7rt1ESMoxm+GScu+7XzlhBTPu3VFwU0d0XSUG+BiWXvT5NL6IXIhdUdQy2Oo61eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5uPPbDKvaVvkA/adm6eTXgpI49AAxns/WNt2JZDKKE=;
 b=V6SmLO3YMxDmsdmfFGCdnzODA13FQWlBzxI4rqT+ORQZ2RPeiKiJsFUSADs8hsy25M+/iQsv84u2pm2T52TRROKdUr1VsTOHNm7UhKyGZZy4REqWcAAxQu2bvmPqMw4PMXnmSXMVRfWTAMORlr2zesNUi5UK8OS4r5JEn7xze2VY8eKkEpIc9H590wl6qE7i9NG1SpDEetuOFmd+7pbRJ6rYCScICJxWWWErIRxBU60aSUnyA8PxJC024zctM0PAqt5JXrZxswVLsrHR3QpeOXVuVtT3B8jeqYGMXUioWgUSxGFz1X32RLK60CzWcgHo0Wx2clSvPNnFkRDJDs5Bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 21:48:33 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 21:48:33 +0000
Date: Fri, 28 Jun 2024 16:48:33 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Valerii Chernous <vchernou@cisco.com>
CC: <linux-modules@vger.kernel.org>, <xe-linux-external@cisco.com>, "Nicolas
 Schier" <n.schier@avm.de>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 2/4] kmod: add generation of modules.alternatives
 to depmod
Message-ID: <gpulsd6kxa3xh5q2vf635az4jp6rtukhwqr2jkb7uorqckv2f7@o7wzk6fdae7s>
References: <20240510112128.2417494-2-vchernou@cisco.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510112128.2417494-2-vchernou@cisco.com>
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de1996b-5cc8-4f87-07fd-08dc97bc0e77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uv1hMMw1oGvmtX71CUcUhoXyZSdjcvqRKcyJnU7HlBrf9nHXsQoPlXmEGiZ6?=
 =?us-ascii?Q?howUbxE+lbucXse6Sw0nTwsp/rxdG4fHwJrgsUfAXtNiJR2pVayFsIwYiESn?=
 =?us-ascii?Q?Jo8DDAZGfTSsqi/ETw/PQY2J72D1JjigKN01m6Zv555ZV2jmPXE91/iXGwci?=
 =?us-ascii?Q?XQjUYiLo8WzWEB8Vyn0gMg4DDAgH5G39QajdDkayt5cT6B8DlzxT8G31v3sb?=
 =?us-ascii?Q?BWYcdK7KfKyJTlPNv+OQbi53JRL5Yv07ETbEGbDTPP7AvZ+LSCZ4qFaKe3EB?=
 =?us-ascii?Q?Nrx48PvrDKNehEi1uwQ+XGBvbTikCQ1335slOvCAPKRIPo1tkV9j6VE/rKNX?=
 =?us-ascii?Q?mTpJvCURLAPmPqs/d1E8q5wUoHATVea0bpvlIXGIOLszs0HBpZRogNm3cyJ3?=
 =?us-ascii?Q?BhHKXsUTP0mCzj5qPPIyOE4QyXXqptlCjuVZNXghsTMHXMkXnhs6qY9JWd+K?=
 =?us-ascii?Q?gDjAHalyua0jBNNNlazXDiIsFq0Zvt0BhX1zz8Kk+z4GKLYDvgBy4NoYIMbd?=
 =?us-ascii?Q?0rijSWS4PSpKROM/o7HSlk2FtQpl0nN2OyhRq6w1+PFDBgF/qevyYNamMs9M?=
 =?us-ascii?Q?y8d59WzJfZkeg4ifPzfCMyNZKgy2vCjReNi2Dc/V32jQZr5hl2Qv8byuiCqU?=
 =?us-ascii?Q?EfB8B/ru4Kq6h3ChJ7LfXDqhYreZlzm/3pyYMHQWTUxWbW1wGJmr8YuVDODT?=
 =?us-ascii?Q?F/9QrJGP5d3Ir6XGFRPPEb7SM71VyIMKxmnFKd/638IVyBwOQVVb7a7rOfuK?=
 =?us-ascii?Q?uMA3Clht3jmSNCUKn/Ku+q2q2gENbHzA/ymI9qo/AuX1qkaZiETl/1klfG8V?=
 =?us-ascii?Q?ByEnBq08ciGdN2LHpFyb0nDb4Ce6G83hm54y2qBeRnNekneVP3NUFzXEzIT1?=
 =?us-ascii?Q?gG7bEi78eeuQvKM7eo1A9/BgctScP6i0OHuZ6EBxP+t/3hY+pvWEeCA+LuNB?=
 =?us-ascii?Q?lnz/35ia4dF5ZQLD/9aApMWA5QEC5YdGOh6DiDDDa5q1MZorBTEqzZHxz98p?=
 =?us-ascii?Q?h0inImuWi0JWcpvOPq5ZbXRbtC0cPEedpJ6Dt62mnAsFDsksIBhUhu8QRQ5J?=
 =?us-ascii?Q?UPKHOEcOD2LRS7P/RDnOIxJ0nQkB3fk9mEqsImACV4oC/Tx52oVc5D/UFJMa?=
 =?us-ascii?Q?ibbvj3v/MfVfAg269/eG2CWdiFdui4g/CtIQw4jg6k1aSLzkFd8fVADe12+A?=
 =?us-ascii?Q?znPEfimU8x5syo4tfdbuw4upZyB80gPTSUpvmHbStGEbreBKHSpLSpOLzc9m?=
 =?us-ascii?Q?hwkelJ4IQPKEzfdGFKsHSWHIzvsDpQJKdMVpFMYgjlzd9/v228fWoQnwoRKB?=
 =?us-ascii?Q?YU/LDA+P85Zniz2MT+JBJZ06oIOH65+AnDYnBj/fPGZnmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Gjy2SuCfflV8jC7dc8C9CsLs+1XUkQnhCnhjGM/RKVqN6oLPkDwNjBv9z5z?=
 =?us-ascii?Q?Q4d0ZlwL1OZbHsUUWH4nrEzsZrCRGbGAHI0lkl27vHu+7VXUT2Zcf8VhbTZW?=
 =?us-ascii?Q?Ulv9ZwpymgQob0CbdBMEU+UotKKk7lYHlLRhv+0/RVSBcrbiK5FGQksKX5VN?=
 =?us-ascii?Q?ylsuBYrZxv9V8DXGZEfoex8ff7hf/GPCsQ2NoPn4ZcNHigknmHfL6EJxSHYH?=
 =?us-ascii?Q?VpHy5VtvABIt3kpzFuHB16hwYAbfRXoAvH5F7YY9M7njI65Pk1Pc0zBfGGAr?=
 =?us-ascii?Q?+AlyJL32j+Ql9p+7x6i0oGulElpUD7s+2O0w6944xo+UeTMgbD+m7OGv7Qh3?=
 =?us-ascii?Q?ur0/u34NaeULBf6kHd2ah3cotN2PtfzQhRq0dyew+XUzQUQ1MgHALXo7aeGb?=
 =?us-ascii?Q?GfGGkiRjl6qMvWIMV5FjFMGRpC+28rcc0rJmtUsHm/Irxb5vRhkLQ6gOYYFy?=
 =?us-ascii?Q?rOlDpptv0K9ZJXWhcqIln/nSATsbObEeG+YlyVkQALy4r3SnzY2UWCeU61zh?=
 =?us-ascii?Q?8rJDE0CYJ09N0GyMLmIHi5RREHndYfsZXWSP2nrsc7ej7gKntz+RNB/FjfEk?=
 =?us-ascii?Q?AXfi+zGibj0RWbFLMZzl27D+QyPfaBRANGxK41OucnGyk0XhgQNb/mpFNzkA?=
 =?us-ascii?Q?85PCCv5DdAde3q5iucT4O/+toTP2rVoq0Vim89KClwOXIArWzGMYMVhmUrCk?=
 =?us-ascii?Q?N+xa+EKQoq06O0oEg227TeXeHcZs9Kkey8V5ejhmI3Y8QwtqmQm2F5vBGn4e?=
 =?us-ascii?Q?oQjkOwIEKD49O9E7UCXRideLsB4FesZZAJlZc6vpXQLMzONN/OwF3BTI5zHS?=
 =?us-ascii?Q?hgQkUEIZUu8WQGkJR16pBgnwk2Z9Caym9Zf02J91I2+S1K1X8oZzhNL7M1Ng?=
 =?us-ascii?Q?Yjys90Cnm572meMATYE8vFObpxFnPzede0YXooSFtQhNDGmabNLCem0+huNY?=
 =?us-ascii?Q?DhCIhMKT2iCCLJ+3Riy62hryTPpWh934Rn7gKhdD94JR1p0SGmoHfH3vQDzv?=
 =?us-ascii?Q?GSDjuRkbqHhKJvKuA1F/HtG8F1uOMznweH7rffTe9b/h3A+HjY34C5zOOKsY?=
 =?us-ascii?Q?nOt8op0J1eiDjLEMBOG1ykseaTnVOsjySHjco/39XhPH/wejhJGr3Tjo+DI8?=
 =?us-ascii?Q?eWVUqXl4W2DmUtJW2eu4oM+eF9ZxgZ/DeLJNbwFRxDUyDVFA89/9a7wRVxwQ?=
 =?us-ascii?Q?uT6/z5T5jJqnDB/YWtnZc2BfB+HUX6fYOwjVY1oFqHGrVD9dZ1fbDwxxbgjw?=
 =?us-ascii?Q?LUUjKh+KYEDIJSGURPpzZyrazn/p6qyfeqjrWDOzr0jx/NPCM17qc0fdfdq3?=
 =?us-ascii?Q?Et09QuS5Iytk6Y4xeqoypSwKk9Iz0MwGm9wrl1wtSU/51Aau6Dq4WqX9yQS8?=
 =?us-ascii?Q?U8jz8OTT7F5Bpl+TP+PkIomwtu9gZfkFJP/Xr89RPtuQFD3lzyxUlac2prbQ?=
 =?us-ascii?Q?eC3JhWvHUFxiOFtlzwR6RTFx/H8Q+DuMB3P+z8amoQQcpNghLrCMOmPdNOv9?=
 =?us-ascii?Q?fD2Km43U3VtGjWgdRTfGGI7z6Zrs+MeNxYFTFENmG29mXMklMO3+auckgxqH?=
 =?us-ascii?Q?FXlunKTSHxPl5iQG7fYQTG9vXus3ZddftLW2E18GTNArjNugIICJzd+4S5GH?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de1996b-5cc8-4f87-07fd-08dc97bc0e77
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:48:33.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqjDo0kHJY8gWrdxC96xEqS0G0YCYYZzqI3vPKnUl+EhbsRJeVXFcV6c5LNtoiWr7tAxxnUX2Iy0j2cVNfr/pkEVONrFK97cbvKEZHD4XOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 04:21:26AM GMT, Valerii Chernous wrote:
>algorithm of creating deps alternatives
>
>1. for each module(m) creating hash map(mp) of module providers for required symbols(s)
>
>2. for each required(primary) symbol(s) into module(m) create temp array of providers(p)
>from list of symbol(s) alternatives with first elem into array as symbol(s)
>
>3. get array of providers(pc) for owner(o) of symbol(s) from
>hash map(mp) of module providers
>
>4. if array of providers(pc) already presented
>4.1 check is pc equal or subset of p, if yes leave pc into map(mp) and ignore p,
>4.2 no - remove from temp array p all symbols providers that is not presenetd into pc
>(create new set of providers p less or equal to pc(providers should cover all
>required symbols, not only current symbol) and update hash map(mp) for owner(o)
>to new(cutted) p
>
>4.3 if array of providers(pc) is not presented for owner(o), create it
>
>At the end of algorithm, for each primary dependency hash map(mp) contain modules
>alternatives that provided all required symbols
>
>Note:
>Alternatives than not provide some required symbol(s) didn't trap to final list and
>variant where this symbol provided by some other module ignored(not implemented)
>Note:
>modules.dep index different for standard/basic and modules alternatives algorithms
>modules.dep for modules alternatives algorithm contain only direct dependencies
>and full dependency list will be calculated into runtime correspond to
>preferred alternative.
>modules.dep for standard/basic algorithm contain full dependency list for
>module and can't be changed during runtime without rebuild database via depmod

I'm still trying to wrap my head around the *what* and maybe find out the *why*.
It seems you are trying to move the resolution to runtime rather than depmod-time...
Is that the case? Why?

Lucas De Marchi

>
>Cc: xe-linux-external@cisco.com
>Cc: Valerii Chernous <vchernou@cisco.com>
>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>---
> tools/depmod.c | 293 ++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 290 insertions(+), 3 deletions(-)
>
>diff --git a/tools/depmod.c b/tools/depmod.c
>index 24f79c4..7bea8e9 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -919,6 +919,7 @@ struct mod {
> 	struct kmod_list *info_list;
> 	struct kmod_list *dep_sym_list;
> 	struct array deps; /* struct symbol */
>+	struct hash *deps_alts; /* array struct symbol */
> 	size_t baselen; /* points to start of basename/filename */
> 	size_t modnamesz;
> 	int sort_idx; /* sort index using modules.order */
>@@ -950,6 +951,7 @@ struct depmod {
> static void mod_free(struct mod *mod)
> {
> 	DBG("free %p kmod=%p, path=%s\n", mod, mod->kmod, mod->path);
>+	hash_free(mod->deps_alts);
> 	array_free_array(&mod->deps);
> 	kmod_module_unref(mod->kmod);
> 	kmod_module_info_free_list(mod->info_list);
>@@ -980,6 +982,76 @@ static int mod_add_dependency(struct mod *mod, struct symbol *sym)
> 	return 0;
> }
>
>+static struct symbol *depmod_symbol_find(const struct depmod *depmod,
>+							const char *name);
>+
>+struct array *symbol_get_owners(struct depmod *depmod, struct symbol *sym, int *err)
>+{
>+	struct array *sym_arr;
>+	struct symbol *sym_l, *li;
>+	sym_arr = malloc(sizeof(struct array));
>+	if (sym_arr == NULL) {
>+	    *err = -ENOMEM;
>+	    return NULL;
>+	}
>+	array_init(sym_arr, 4);
>+	// first owner into alternatives should be primary owner so add it at 0 position //
>+	*err = array_append(sym_arr, sym);
>+	if ( *err < 0)
>+		goto fail;
>+	sym_l = (struct symbol*)depmod_symbol_find(depmod, sym->name);
>+	for (li = sym_l; li != NULL; li = li->next)
>+		if (li != sym) {
>+			*err = array_append(sym_arr, li);
>+			if ( *err < 0)
>+				goto fail;
>+		}
>+	*err = 0;
>+	return sym_arr;
>+fail:
>+	array_free_array(sym_arr);
>+	free(sym_arr);
>+	return NULL;
>+}
>+
>+static int mod_update_dep_alternatives_groups(const struct depmod *depmod, struct mod *mod, struct symbol *sym)
>+{
>+	struct array *alt_arr;
>+	int err;
>+
>+	DBG("Preparing alternatives for module %s dependency %s %s\n", mod->path, sym->name,
>+	    sym->owner != NULL ? sym->owner->path : "(unknown)");
>+
>+	if (sym->owner == NULL)
>+		return 0;
>+	err = 0;
>+	alt_arr = (struct array*)hash_find(mod->deps_alts, sym->owner->path);
>+	if (!alt_arr) {
>+		// Create the initial alternative modules array if not presented
>+		alt_arr = symbol_get_owners(depmod, sym, &err);
>+		if (!alt_arr)
>+			goto alt_ex;
>+		err = hash_add(mod->deps_alts, sym->owner->path, alt_arr);
>+	} else {
>+		// Remove alternatives that don't provide the necessary symbol
>+		struct symbol *sym_l, *li;
>+		size_t si = 0;
>+		sym_l = (struct symbol*)depmod_symbol_find(depmod, sym->name);
>+		while (si < alt_arr->count) {
>+			for (li = sym_l; li != NULL; li = li->next)
>+				if (li->owner == ((struct symbol*)alt_arr->array[si])->owner)
>+					break;
>+			// primary owner can't be removed from alternatives
>+			if (!li && si != 0)
>+				array_remove_at(alt_arr, si);
>+			else
>+				si += 1;
>+		}
>+	}
>+alt_ex:
>+	return err;
>+}
>+
> static void symbol_free_sub(struct symbol *sym)
> {
> 	DBG("free %p sym=%s, owner=%p %s\n", sym, sym->name, sym->owner,
>@@ -1014,6 +1086,13 @@ static struct kmod_module_info *depmod_get_mod_info(struct mod *mod, const char
> 	return rval;
> }
>
>+static void symbol_alternatives_free(struct array *arr)
>+{
>+	array_free_array(arr);
>+	free(arr);
>+}
>+
>+
> static int depmod_init(struct depmod *depmod, struct cfg *cfg,
> 							struct kmod_ctx *ctx)
> {
>@@ -1089,6 +1168,11 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
> 	memcpy(mod->modname, modname, modnamesz);
> 	mod->modnamesz = modnamesz;
>
>+	mod->deps_alts = hash_new(64, (void (*)(void *))symbol_alternatives_free);
>+	if (mod->deps_alts == NULL) {
>+		free(mod);
>+		return -ENOMEM;
>+	}
> 	array_init(&mod->deps, 4);
>
> 	mod->path = strdup(kmod_module_get_path(kmod));
>@@ -1127,6 +1211,7 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
>
> fail:
> 	free(mod->uncrelpath);
>+	hash_free(mod->deps_alts);
> 	free(mod);
> 	return err;
> }
>@@ -1742,6 +1827,8 @@ static int depmod_load_module_dependencies(struct depmod *depmod, struct mod *mo
> 		}
>
> 		mod_add_dependency(mod, sym);
>+		if (depmod->cfg->use_deps_alternatives == 1)
>+			mod_update_dep_alternatives_groups(depmod, mod, sym);
> 	}
>
> 	return 0;
>@@ -2164,11 +2251,24 @@ static int mod_fill_all_unique_dependencies(const struct mod *mod, const struct
> 	return err;
> }
>
>-static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps)
>+static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps, int is_direct_deps_only)
> {
> 	const struct mod **deps;
> 	size_t last = 0;
>
>+	if (is_direct_deps_only == 1) {
>+	// in case of dirrect deps it's already unique so make an deps array copy//
>+		*n_deps = mod->deps.count;
>+		if (*n_deps == 0)
>+			return NULL;
>+		last = mod->deps.count;
>+		deps = malloc(sizeof(struct mod *) * last);
>+		if (deps == NULL)
>+			return NULL;
>+		for (size_t i = 0; i < last; i++)
>+			deps[i] = mod->deps.array[i];
>+		goto sort_dep;
>+	}
> 	*n_deps = mod_count_all_dependencies(mod);
> 	if (*n_deps == 0)
> 		return NULL;
>@@ -2182,6 +2282,7 @@ static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod,
> 		return NULL;
> 	}
>
>+sort_dep:
> 	qsort(deps, last, sizeof(struct mod *), dep_cmp);
> 	*n_deps = last;
> 	return deps;
>@@ -2208,7 +2309,7 @@ static int output_deps(struct depmod *depmod, FILE *out)
> 		if (mod->deps.count == 0)
> 			goto end;
>
>-		deps = mod_get_all_sorted_dependencies(mod, &n_deps);
>+		deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->cfg->use_deps_alternatives);
> 		if (deps == NULL) {
> 			ERR("could not get all sorted dependencies of %s\n", p);
> 			goto end;
>@@ -2245,7 +2346,7 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
> 		size_t j, n_deps, linepos, linelen, slen;
> 		int duplicate;
>
>-		deps = mod_get_all_sorted_dependencies(mod, &n_deps);
>+		deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->cfg->use_deps_alternatives);
> 		if (deps == NULL && n_deps > 0) {
> 			ERR("could not get all sorted dependencies of %s\n", p);
> 			continue;
>@@ -2368,6 +2469,171 @@ static int output_aliases_bin(struct depmod *depmod, FILE *out)
> 	return 0;
> }
>
>+static int sym_mod_cmp(const void *pa, const void *pb)
>+{
>+	int rsl;
>+	const struct symbol *a = *(const struct symbol**)pa;
>+	const struct symbol *b = *(const struct symbol**)pb;
>+	rsl = strcmp(a->owner->modname, b->owner->modname);
>+	if (rsl == 0)
>+		rsl = strcmp(a->owner->path, b->owner->path);
>+	return rsl;
>+}
>+
>+static int sym_name_cmp(const void *pa, const void *pb)
>+{
>+	const struct symbol *sa, *sb;
>+	const struct array *a = *(const struct array**)pa;
>+	const struct array *b = *(const struct array**)pb;
>+	sa = (const struct symbol*)a->array[0];
>+	sb = (const struct symbol*)b->array[0];
>+	return strcmp(sa->name, sb->name);
>+}
>+
>+static void sort_sym_alternatives(struct array *sym_arr)
>+{
>+	if (sym_arr->count <= 2)
>+		return;
>+	// first element into array should remain it position //
>+	qsort( &sym_arr->array[1], sym_arr->count - 1, sizeof(void*), sym_mod_cmp);
>+}
>+
>+static int sort_mod_alternatives(const struct mod *mod, struct array *sorted)
>+{
>+	struct hash_iter it;
>+	const void *v;
>+	int rval;
>+
>+	array_init(sorted, 4);
>+	hash_iter_init(mod->deps_alts, &it);
>+	while (hash_iter_next(&it, NULL, &v)) {
>+		struct array *sym_arr = (struct array *)v;
>+		struct symbol *sym = (struct symbol *)sym_arr->array[0];
>+		sort_sym_alternatives(sym_arr);
>+		rval = array_append(sorted, sym_arr);
>+		if (rval < 0) {
>+			array_free_array(sorted);
>+			return rval;
>+		}
>+	}
>+	array_sort(sorted, sym_name_cmp);
>+	return 0;
>+}
>+
>+static int output_alternatives(struct depmod *depmod, FILE *out)
>+{
>+	size_t i, i2, i3;
>+	fputs("# Modules dependencies alternatives extracted from modules themselves.\n", out);
>+	for (i = 0; i < depmod->modules.count; i++) {
>+		const struct mod *mod = depmod->modules.array[i];
>+		struct array sorted_alts;
>+		int rval;
>+		rval = sort_mod_alternatives(mod, &sorted_alts);
>+		if ( rval < 0) {
>+		    ERR("Sorting deps alternatives for %s failed\n", mod->modname);
>+		    return rval;
>+		}
>+		for (i2 = 0; i2 < sorted_alts.count; i2++) {
>+			struct array *sym_arr = (struct array *)sorted_alts.array[i2];
>+			struct symbol *alternative = (struct symbol *)sym_arr->array[0];
>+			// avoid printing deps with single alternative to reduce index size//
>+			if (sym_arr->count <= 1)
>+				continue;
>+			fprintf(out, "%s#_#%s:", mod->modname, alternative->owner->modname);
>+			for (i3 = 0; i3 < sym_arr->count; i3++) {
>+				alternative = (struct symbol *)sym_arr->array[i3];
>+				fprintf(out, " %s", mod_get_compressed_path(alternative->owner));
>+			}
>+			fprintf(out, "\n");
>+		}
>+		array_free_array(&sorted_alts);
>+	}
>+	return 0;
>+}
>+
>+static int output_alternatives_bin(struct depmod *depmod, FILE *out)
>+{
>+	struct index_node *idx;
>+	size_t i, i2, i3;
>+	int err = 0;
>+
>+	if (out == stdout)
>+		return 0;
>+
>+	idx = index_create();
>+	if (idx == NULL)
>+		return -ENOMEM;
>+
>+	for (i = 0; i < depmod->modules.count; i++) {
>+		const struct mod *mod = depmod->modules.array[i];
>+		struct array sorted_alts;
>+		int rval;
>+		rval = sort_mod_alternatives(mod, &sorted_alts);
>+		if ( rval < 0) {
>+		    ERR("Sorting deps alternatives for %s failed\n", mod->modname);
>+		    return rval;
>+		}
>+
>+		for (i2 = 0; i2 < sorted_alts.count; i2++) {
>+			int duplicate;
>+			char alt_key[PATH_MAX*2];
>+			char *alt_value, *tmp_value;
>+			size_t alt_vsize = PATH_MAX*2;
>+			size_t alt_vlen = 0;
>+			struct array *sym_arr = (struct array *)sorted_alts.array[i2];
>+			struct symbol *alternative = (struct symbol *)sym_arr->array[0];
>+			// avoid storing deps with single alternative to reduce index size //
>+			if (sym_arr->count <= 1)
>+				continue;
>+			// construct index key //
>+			snprintf(alt_key, sizeof(alt_key) - 1, "%s#_#%s", mod->modname, alternative->owner->modname);
>+			alt_value = malloc(alt_vsize);
>+			if (alt_value == NULL) {
>+				err = -ENOMEM;
>+				goto fail;
>+			}
>+			alt_vlen = snprintf(alt_value, alt_vsize, "%s:", alt_key);
>+			// construct index value //
>+			for ( i3 = 0; i3 < sym_arr->count; i3++) {
>+				size_t l;
>+				const char *mpath;
>+				alternative = (struct symbol *)sym_arr->array[i3];
>+				mpath = mod_get_compressed_path(alternative->owner);
>+				l = strlen(mpath) + strlen(" ");
>+				if (alt_vlen + l >= alt_vsize) {
>+					alt_vsize += PATH_MAX > l ? PATH_MAX : l + 1;
>+					tmp_value = realloc(alt_value, alt_vsize);
>+					if (tmp_value == NULL) {
>+						free(alt_value);
>+						err = -ENOMEM;
>+						goto fail;
>+					}
>+					alt_value = tmp_value;
>+				}
>+				strncat(alt_value, " ", alt_vsize);
>+				strncat(alt_value, mpath, alt_vsize);
>+				alt_vlen += l;
>+			}
>+			DBG("Adding to index mod: %s, key: %s, value: %s\n", mod->modname, alt_key, alt_value);
>+			duplicate = index_insert(idx, alt_key, alt_value, mod->idx);
>+			if (duplicate && depmod->cfg->warn_dups)
>+				WRN("duplicate module alternative:\n%s %s\n",
>+				    alt_key, mod->modname);
>+			free(alt_value);
>+		}
>+		array_free_array(&sorted_alts);
>+	}
>+
>+	index_write(idx, out);
>+	index_destroy(idx);
>+
>+	return 0;
>+fail:
>+	index_destroy(idx);
>+	return err;
>+
>+}
>+
> static int output_softdeps(struct depmod *depmod, FILE *out)
> {
> 	size_t i;
>@@ -2684,6 +2950,8 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> 		{ "modules.dep.bin", output_deps_bin },
> 		{ "modules.alias", output_aliases },
> 		{ "modules.alias.bin", output_aliases_bin },
>+		{ "modules.alternatives", output_alternatives },
>+		{ "modules.alternatives.bin", output_alternatives_bin },
> 		{ "modules.softdep", output_softdeps },
> 		{ "modules.symbols", output_symbols },
> 		{ "modules.symbols.bin", output_symbols_bin },
>@@ -2719,6 +2987,25 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> 		char tmp[NAME_MAX] = "";
> 		int r, ferr;
>
>+		// modules.alternatives and modules.alternatives.bin should be processed only into dependency alternatives mode(with -D flag) //
>+		if (depmod->cfg->use_deps_alternatives == 0 && (itr->cb == output_alternatives || itr->cb == output_alternatives_bin)) {
>+			if (fp == NULL) {
>+			// if not output to stdout //
>+				int fd;
>+				fd = openat(dfd, itr->name, O_RDONLY|O_CLOEXEC);
>+				if (fd >=0) {
>+					// if alternatives index file exists //
>+					close(fd);
>+					if (unlinkat(dfd, itr->name, 0) != 0) {
>+						err = -errno;
>+						ERR("unlinkat(%s, %s)\n", dname, itr->name);
>+						break;
>+					}
>+				}
>+			}
>+			continue;
>+		}
>+
> 		if (fp == NULL) {
> 			int flags = O_CREAT | O_EXCL | O_WRONLY;
> 			int mode = 0644;
>-- 
>2.35.6
>
