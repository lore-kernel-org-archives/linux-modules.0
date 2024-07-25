Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8519D096;
	Thu, 25 Jul 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917802; cv=fail; b=pT2p61UL7+CDsiu4RcgaFiqymAh16h7/2C8BcGx/rZqX4p3V4birlzGdBHjiEDQrC/26bJQy2PKuuyw82g5cwFE06oTwwWN3qFd+982+YEd1Y0wJVK4rBVzyfgPPN3clZuuQgiWFyfyjo61gzIBnkn6bS8+ZlSGAxrkB9rbnFUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917802; c=relaxed/simple;
	bh=1/iPpvdwmXk2r9QAwnJBVmXkRPeTTWzyb2YtCrSYzMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nlvi/V4GkwMyPBB5+8ak+A0NR6OgEyLXsr0AJsBLYt+a6zBdEAs/Bm6i8op1dpTi5dFDGjsBsW+S/uEiBpQpvyGKcjaMTbpBRwCf+chl/Acw0M62T3ogJKaDJkKftKeUM74dGGxGHdQfQyMg4JzObWv8ilFb/LtDfSIrKIbLgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev6vBO8s; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev6vBO8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721917800; x=1753453800;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1/iPpvdwmXk2r9QAwnJBVmXkRPeTTWzyb2YtCrSYzMw=;
  b=Ev6vBO8s7JEaumbyoAa6eHO5Z+K8cAYHfarq9+sHLaSNzSAopmUtUq1+
   1psig8ejNnfGR/HnUAISKrGC7cINp2DfX0hB8NVBwzAjhF49NAIvDLu6k
   270G3JPOliJpvSqJgf0vO2heqSQ1EBHvgXMJb/XXesU1hNHb9+hiOa8kc
   6U2TCJWlsrgDW0X5cxz9VSvmxqTSXkRXa4Gr1mKTHRf2AJkWmFjWbQFw+
   m/IkSTyR8FkUT5JIWmhb+A1W2Vm8b3QOaGZ5GFpy+bO5ny+hieOjL0HTn
   le/30ojkzJdiQ7kZl++/B3/q+uoc5+vy4KS2BN8u0chfHl6XS9mKZaDuC
   A==;
X-CSE-ConnectionGUID: CyQYZiWrS52YPmyG3wpCbw==
X-CSE-MsgGUID: X45/Qgp8QHi4ihPQdGzj4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="23465530"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="23465530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 07:29:59 -0700
X-CSE-ConnectionGUID: GMya9JDQTO+T6ErTkRrqPQ==
X-CSE-MsgGUID: qbWvjFinTIaZhXdNysI3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52636540"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 07:29:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 07:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 07:29:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 07:29:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 07:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK2idMLiNvscUWtVcbkAv2BDO9y+/Yha/99fisFLrmiwJsIUebfyAXBRZ/Rj370bXfPph2SAnGNqPEaqj0CJVUZBVnA9e8o4ZfKoxKjnhFFMW0ylHcZO+cCcJ+cla1LNBHCqkTMVbzuM9Pl2m+NAOpJ+R9vASWYi0iXgcAkE+oJ17mHCfIiKLdHs386WnnRtbOtfV4riPYMowdfUHLNA/cjuW/W7fpF91exefN2xzCgL5rTdEv9XxYE42AbG+jD5r7qJCP+GgcfTtMEiJPhaofS0IqobhbWZl3KoegkppQbQe/WVXZox2U2pgcj27s2YIY+o7t2M+6J9Ncub078plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPtol+riWRlXOsfskWuGiutpY/UB/a+tPPLZKiEYDdE=;
 b=urjSjf1Fp/hXHvF2TzXVs8+IfwAGyPvw6VIRvKYe6wVe9TC5w2hHK0YsqX01HBhkNRLSNmvWHLN+k1IiT+mzAsA49HvTTGEx+NUalkEP0xM2pDDyi7C4jlCipIwaV1Ddc2vRyz2pYzhEF3VNQ2PkRlUD4cbXvauNDb++FD5o2OWKl4xVR6jNgeFqWVsdhbWxh2PNRbymzO06bl00e4y5X6buKnQqgccDe0+5G8aeOmS2tIl+1jYWPzBLX9+yz6g1oM+yAbXsMZpL0blOeSz9wWfbZG0BsCgVpHrbY8hy++Z/frt19OL50MedIRRE6LC1As4vGPjn7eCWAsjl6Bdaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 25 Jul
 2024 14:29:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 14:29:54 +0000
Date: Thu, 25 Jul 2024 09:29:51 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Dragan Simic <dsimic@manjaro.org>
CC: <linux-modules@vger.kernel.org>, <mcgrof@kernel.org>,
	<linux-kernel@vger.kernel.org>, <didi.debian@cknow.org>, Steven Price
	<steven.price@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>,
	Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
Message-ID: <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 17acbaf1-c8a1-4cc8-1edd-08dcacb64093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nJBD9i1Ij1G5IW0Hu2M1EZkmy66K7zPzD20ZWFFCrnNk4ep1FHi+YwojHUVb?=
 =?us-ascii?Q?tQpRUIN1nv7at2L+fcn+a1eavL4T/UeLnmvP4jAfUSp4HZKpVczSbEylY1pJ?=
 =?us-ascii?Q?FkNsgy+FmU5AeVVM5OVx271afVsKr3cTRx8ReQLv3mGci5V3FbiwFiUHh13b?=
 =?us-ascii?Q?mcQyEJRCizXGx1t0DwK1Zt7ZjchAmFayfYM7Dn7YIphSpp9pCOyhsO5bd/cG?=
 =?us-ascii?Q?eVyGmBw8ffvvMM/7FRIRhUvRd5Qy8NRA3xGedNeYozpEGfgpBaUiTkMndd0I?=
 =?us-ascii?Q?/if46uKZNx7vbc1kcVk5Az0BhLjH0Ef+Ec4RUSjiHhfJaEXjLx/Ihq12vygv?=
 =?us-ascii?Q?p7e5N+tcIXrR4lgPJKTWxwEGUsPY7v6ovd+b2IToLakW/DdCpEm60+6h4HBE?=
 =?us-ascii?Q?UKWcdJWtWpsyOfWWszbpVB+/qJOhDGkVZFdwROq3zluRnCMYwXu3LpNSpH62?=
 =?us-ascii?Q?5w7+cgxGAEGAVOZCb4tJ5A3QLGDqBOm+mEIS8JuhCmblyqWaxOIW98dqmotM?=
 =?us-ascii?Q?Wsw2nwIum49kq5gDxb7Apagnmx8ypqeu7oWsxWDB5Qr2OvJoS6//d1Bv6R4V?=
 =?us-ascii?Q?73UDwGCaMloJxAUIavGEuWMbM5R4IFIfbWus/gS091vXZ/ZCk5tyAimg3dwQ?=
 =?us-ascii?Q?p8Xcx19dv//kziZPPbDMrudHTo8RwIWFgN5jVRIOyg0jJ+Aw44o1/gVAL7XC?=
 =?us-ascii?Q?/M7bjj+ykzV+EIOlU23ygOT/ffOAp+MsBNJpOfAnYkze+d1OV2kC87gF3tYF?=
 =?us-ascii?Q?We47hdrHtgJLLgt5cDdwt6IgBa26Sz7UybADxFJBTuLQJDCUJIkFFBM5kAS5?=
 =?us-ascii?Q?shFISWGUU+/4jJsCg745925ryEEllE0O+H8AGJKFSi4ulk1FOgiDVLZPyGW1?=
 =?us-ascii?Q?xKnGaSYxb7iPpmxpuQsBaS3oagB0nYkw5aHrSDlEOtoGmpVRau80GjYMvQYH?=
 =?us-ascii?Q?4DyahZVm9tq5l4la4PXVxSQ9ea+q1oT8SVZNFCMMdznhjinMGJP9M9NDCF+r?=
 =?us-ascii?Q?f2GBeU3o6ORLZqwtoy7GDWVgHi08gN1p2cvMKtCXPw9DnrfmIKQhTPkS81b0?=
 =?us-ascii?Q?CxVQr0UUoyXWxJu8zirFvsKlIeHk8Tg1SU62vvykFaOCrn4WaAl4Uvqj+fky?=
 =?us-ascii?Q?G6+H4Kutjo37r9GQlp2fDehCr42v/S7qrLMM8s3ULK3Jx8VtaIInIGZrj9xZ?=
 =?us-ascii?Q?+Ro+1YupoSFKSDUgidMJYudIVkuSXB0ZylWWtovEwavMx22KsQ2ELejkKHh2?=
 =?us-ascii?Q?oW84vDspRhrn9a92wCHLwNWsq1f7UpcfsleUsSxvrwZcWAvi7laDuaNSrExB?=
 =?us-ascii?Q?mFeigfQdob4MrfY7Zn4A4pTI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EeMv3uWgZD/hxp+cAwnxdktlpW5W8yjYDR7VPvg5TrdMlOjwlh74dPVJjPmM?=
 =?us-ascii?Q?CrYvzNBV4oWbyRDm3wCkvpc1KJMd26lgSSYtoaEOktZF0WhCLZCoHuUsQGdZ?=
 =?us-ascii?Q?Y1aGRV4u4YnIzon/JtjTHX8H/BH6TVN3e79qxMs8Cu/TYRVgDWhjGqYiKiz5?=
 =?us-ascii?Q?imd2y6quCq1Db62vIf6m4azqpNVNu67EpEU+rIPYv4ew7HTz5x05rZw3haeU?=
 =?us-ascii?Q?vG8c1HOhmk9QvM5ly/pokrENJVSTRdUEW2fNDo149N4/e9Iiz2S93KxirHFt?=
 =?us-ascii?Q?KxYkJNI62dByuC8s6Ixe3kbmkgVKxaaUCwBIRcS5dGaZSr5nKiaUvI+uaDtU?=
 =?us-ascii?Q?LybcXZE7+aHuUAKzWwiG7X3zUH8A/Xm+qDGocW/WA/jyOpiLWxyyLf3nY6jK?=
 =?us-ascii?Q?NV2SKP9Sxk3qn4fGQ8OczWtO2eQzOb6y6lxMfwq6j1tPApTs4uilalFb/iMq?=
 =?us-ascii?Q?Id7JhSGvwbCVozXwXChVbAptMY8C03aCKS2I2TTDQnKBj6YDzSM7jNoYWQ3y?=
 =?us-ascii?Q?7WGooJzQDU8K1jSRttBcAuu0PYy3cmqVhwYuRu4tVW4ZX7OEBgdR64PD1mwf?=
 =?us-ascii?Q?aor3QsHhz0WkPGdQFJYRNCfgjConP3wG3JrzJYMlxHuqW7Mk4vn1U85eperv?=
 =?us-ascii?Q?BMMyQeo3cLNcjT5v3ZvR6mxacN7iaHekC12WUZEX7nT7OElBLFbP11GvubXQ?=
 =?us-ascii?Q?nds7lr06t4E5FPoYA2j8tr7naeJgoCZuvW2Izwv4+MTk/1LbLul0Sh/FvnwQ?=
 =?us-ascii?Q?n64MvjhQM1YSS5pnQjYdpt8Lxy6/fj1dt4Z+GcTqSukG3ymqGcAPesngiyUj?=
 =?us-ascii?Q?1B6aDsguhoXs+jseHuFuzWl68rfmYhabaj+Qd9iVbe+kSmpMM8ECx+ZhbNvR?=
 =?us-ascii?Q?KQ0Y8XLhwSr7alPzFYcxGHdGQRwmlvjyNvRT0BLf2JlVQg+nMRG5rHQBmxk6?=
 =?us-ascii?Q?WEYNwBxFj9HLbq4l8sgXi0X5Dytk6EMwqPmbpU43ntevQsphA8lsz7dE5RuM?=
 =?us-ascii?Q?FojQeUZZRpOfx8cYwkhxIl1gJjcj0joHrLVloQ7eMwCjsvNIDZ7szjw3dgdk?=
 =?us-ascii?Q?H9tbTOVwwjMZ+mcX6JznWcfePpmcLOINhfNMmmJvIQnrzzzbbmr/6GRNvY6k?=
 =?us-ascii?Q?ND6DNMVI0AUCDyJ92N9xFeA98Gh8DnbviaqpSxvpnjP6Si9Vp8kpK8glV3jy?=
 =?us-ascii?Q?jZvOLi1eUSa/y+1GF+uOq496u9lgb4+eev0/U270vppuhIlW7C4OKnZa/KOx?=
 =?us-ascii?Q?lXL+XWRuU61DEsAHUQx786oo0Ymvumoi5b6RAEsWHpkbBmaEokqNw29DC4Km?=
 =?us-ascii?Q?WaiaqixdSLR2qb5c4uwMkIfVWgnZZkkCGi3O90tCCKRW8XeThc4dw9s42u3M?=
 =?us-ascii?Q?/2EwSVQW2Lz4P81SFdcroWOUT/vmSRQoGQX2W1lWz/cIeiiRPv8G7IQgapic?=
 =?us-ascii?Q?MB2M9D1Vx4FDCEOEjR2PvC/Vo+/L0OKZgXtiEos6c5jvAXjbL7KbW7z43D+T?=
 =?us-ascii?Q?bXQkgyEuHJfHzZct7AZhV6/uw9R/98girzc2QZ9ZrPfEvbn2FVVRALJ1+VyB?=
 =?us-ascii?Q?1Ao4rJJa6xcP/3oitd3yj1Ljg/OthCJEogvlO3rdTtmDbSalMKPK90x48Pp4?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17acbaf1-c8a1-4cc8-1edd-08dcacb64093
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 14:29:54.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejA95dGYXmzID6+T1dddk3SMZ4xdgUrT7JVagjP/C7Si/Iko4EkeBqW7tFx4p58Ju9WxYdip14M4rQXpZ0aksq3/0v6iSP0w4No29gkiU1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7779
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 01:37:46PM GMT, Dragan Simic wrote:
>Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is supported
>on the associated platforms, while using simple_ondemand devfreq governor by
>default.  This makes the simple_ondemand module a hard dependency for both
>Panfrost and Lima, because the presence of the simple_ondemand module in an
>initial ramdisk allows the initialization of Panfrost or Lima to succeed.
>This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see commits
>80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as softdep") and
>0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") for
>additional background information.
>
>With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module: create
>weak dependecies"), the dependency between Panfrost/Lima and simple_ondemand
>can be expressed in a much better way as a weakdep, because that provides
>the required dependency information to the utilities that generate initial
>ramdisks, but leaves the actual loading of the required kernel module(s) to
>the kernel.  However, being able to actually express this as a hard module
>dependency would still be beneficial.
>
>With all this in mind, let's add MODULE_HARDDEP as some kind of syntactic

Sorry, but NACK from me. This only adds to the confusion.

hard/normal dependency:
	It's a symbol dependency. If you want it in your module, you
	have to use a symbol. Example:

	$ modinfo ksmbd | grep depends
	depends:        ib_core,rdma_cm,nls_ucs2_utils,cifs_arc4


soft dependency:
	A dependency you declare in configuration or in the module
	info added by the kernel. A "pre" softdep means libkmod/modprobe
	will try to load that dep before the actual module. Example:

	$ modinfo ksmbd | grep softdep
	softdep:        pre: crc32
	softdep:        pre: gcm
	softdep:        pre: ccm
	softdep:        pre: aead2
	softdep:        pre: sha512
	softdep:        pre: sha256
	softdep:        pre: cmac
	softdep:        pre: aes
	softdep:        pre: nls
	softdep:        pre: md5
	softdep:        pre: hmac
	softdep:        pre: ecb

weak dependency:
	A dependency you declare in configuration or in the module
	info added by the kernel. libkmod/modprobe will not change the
	way it loads the module and it will only used by tools that need
	to make sure the module is there when the kernel does a
	request_module() or somehow tries to load that module.

So if you want a hard dependency, just use a symbol from the module. If
you want to emulate a hard dependency without calling a symbol, you use
a pre softdep, not a weakdep.  You use a weakdep if the kernel itself,
somehow may load module in runtime.

The problem described in 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as softdep")
could indeed be solved with a weakdep, so I'm not sure why you'd want to
alias it as a "hard dep".

Lucas De Marchi

>sugar, currently implemented as an alias for MODULE_WEAKDEP, so the actual
>hard module dependencies can be expressed properly, and possibly handled
>differently in the future, avoiding the need to go back, track and churn
>all such instances of hard module dependencies.  The first consumers of
>MODULE_HARDDEP will be the Panfrost and Lima DRM drivers, but the list of
>consumers may also grow a bit in the future.
>
>For example, allowing reduction of the initial ramdisk size is a possible
>future difference between handling the MODULE_WEAKDEP and MODULE_HARDDEP
>dependencies.  When the size of the initial ramdisk is limited, the utilities
>that generate initial ramdisks can use the distinction between the weakdeps
>and the harddeps to safely omit some of the weakdep modules from the created
>initial ramdisks, and to keep all harddep modules.
>
>Due to the nature of MODULE_WEAKDEP, the above-described example will also
>require some additional device-specific information to be made available to
>the utilities that create initial ramdisks, so they can actually know which
>weakdep modules can be safely pruned for a particular device, but the
>distinction between the harddeps and the weakdeps opens up a path towards
>using such additional "pruning information" in a more robust way, by ensuring
>that the absolutely required harddep modules aren't pruned away.
>
>[1] https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/T/#u
>[2] https://lore.kernel.org/dri-devel/fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org/T/#u
>
>Cc: Steven Price <steven.price@arm.com>
>Cc: Boris Brezillon <boris.brezillon@collabora.com>
>Cc: Qiang Yu <yuq825@gmail.com>
>Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>---
> include/linux/module.h | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 88ecc5e9f523..40e5762847a9 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -179,6 +179,14 @@ extern void cleanup_module(void);
>  */
> #define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
>
>+/*
>+ * Hard module dependencies. Currently handled the same as weak
>+ * module dependencies, but intended to mark hard dependencies
>+ * as such for possible different handling in the future.
>+ * Example: MODULE_HARDDEP("module-foo")
>+ */
>+#define MODULE_HARDDEP(_harddep) MODULE_WEAKDEP(_harddep)
>+
> /*
>  * MODULE_FILE is used for generating modules.builtin
>  * So, make it no-op when this is being built as a module
