Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CD21364
	for <linux-modules@vger.kernel.org>; Sat, 29 Jun 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684301; cv=fail; b=sUGTlyQhWUg5wMq2DaZAqmTYXhfzDY53zRthjnrUtjWGRwGd9GYE51XoMHnr7nyxoA1EF7jmHQJUBTrbIpor3DB95rKc/D+3hfNWTXmbIqph5THsD5NPZWnkWgYSXahyvjmlmy5m/sJ0M5pqOPCqD6os+h3kavI2DD9A9nMaRAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684301; c=relaxed/simple;
	bh=0vKOXLtR7PuOmlI6ZqjWXbeAVvHcqEERWDQvELP/jrs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llLn3uadaaOf2wPK43heHS/J96pRHSjNo47aUx3MeikqsMBp6k95w710wv9OrdzfhbVqZB3QvL0d2Hw4AquTd/eUxihMC8AOyHOHhm+XIG0Yt7fxhq8uFOB4e40u7c/MzSm+sSA03RKzvZW1XwsksqD9CMKA56wcJVhr1pO3my0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8YTeFgQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8YTeFgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719684300; x=1751220300;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0vKOXLtR7PuOmlI6ZqjWXbeAVvHcqEERWDQvELP/jrs=;
  b=D8YTeFgQ7BtC4tZKl/XzVg0RW0yu9FvzHE73HfDuClZSVYFspmvgdILI
   jtC6PavGBwrtRqbjz7YJz0ygCGKo1+7a2lFd3UUa7u3j4yKKuzvhqsxdq
   Dsf9IWGvJjBIu2eso3jIqAErh/iFOJXxhHrZwBoH252CK4icHTzpsyZyu
   JRvcijHMV385q7rtFBk2o49fpC7sigHEZKgTHmD+0At3DtO9b/0FRYzke
   RmsoTLuB4QRHIHvwniY+SLJb/I7Nvf0jsG5Uk2rOsxVSZyERAd3hgTLBJ
   2ZZVvrlwvaHve3LZSheQOybxQJE/pQ6MRvbGiRRxtlpJsnL9APTi/AUQb
   A==;
X-CSE-ConnectionGUID: +uB1DTdeRIGO4amDfDSoKQ==
X-CSE-MsgGUID: NpH884fqSGedKk8pERPZVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="16976400"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="16976400"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 11:05:00 -0700
X-CSE-ConnectionGUID: tbUu/7ORSJKjfJS0AtZoOA==
X-CSE-MsgGUID: +J1FHZ8mR+S0pUrxfBvy4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45810230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 11:05:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 11:04:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 11:04:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 11:04:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 11:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oej5BHca/UjCM9NxpH+duu18y6kfAZMpe6lmhEaEV8SCGe44J4ATWdjGmQRAY6DM5+7kzFzxnsO7OQHdT6xVpPrYQRbgw4HPjtyBF0HtYI3yohF7vDzOsbgz0wmB8DosJRu7eYx3Bpyvbf5reV4Ft0gshxUeJErQdjwuXILo+HFx06FClw8fF95Qm0OCYuxBh+jyyh03Mda7x6H4sy6FLfZl4JE38YPtJ9qi+40fcTnDa57cLpgXSKh7wd9mrlzT8CLpcUGw5kMbzh7G91KM0yudAzjyjDB7JUfVvO0EfTodTpKK+O7wWcB6gEfgeR+jUvEZvdnuFXmWs20q6Sc6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrX0sflvNIvJKFG4cY9RrC/J/crWqIhzVpwQX6pYoc0=;
 b=OD/FC4gIlwNOUN4ZoR9rZZli8wWhQcst9vECz0A43v1JFbUxNbqzybaaHYP+6h7d5FxcjXpow8Lv/pcYIFS3r9t/P4wPQLV6jehvRfX0S4Ca5wcYKKcCj2Av6iP2uA5LC2NIZne9vCRTWNaWLN34c+9kvhv73GmQTYcpAylX0sJJz+WWaOXXeQ7TG4JY6kLcoFT2J06y7LRUIvhSwTovriXIvDptvQPcc/5MTh8upnG6hv7nv+64o1E0r123aG+yFIsahwV56AEt7a+3WcS3ew8TELJ73AOUEBGT480OB4heS7Ov7/50yW8x4pSoE6ZoWNxsBvr8RSRxJa7IlumTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB7587.namprd11.prod.outlook.com (2603:10b6:510:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sat, 29 Jun
 2024 18:04:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Sat, 29 Jun 2024
 18:04:55 +0000
Date: Sat, 29 Jun 2024 13:04:52 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 03/20] man: build the scdoc based man pages
Message-ID: <zttjd2hjwkbtdy7zkuixypqbo3t2l2brsaf3tx3jkdjfctxjj5@v22knirawsfe>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-3-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-3-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:303:86::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a128b06-ef45-4513-9c40-08dc9865fb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBjMgO/Jpzn80nq3vcoW2miSu2Id0UNJLuVTLnbbVPKAmg471wt9SzdCRYbP?=
 =?us-ascii?Q?LL621UrJRW94Dn2ptIQlRtoj1ug6hRdAg9p8EOgG32IIkNzjKxHqRA4ZXQHY?=
 =?us-ascii?Q?hbfWRIJ1OMwoyja/cPYLm0mwFrUxVNvTu3LgAee9SjUORLaG1Ls6WA7JuohV?=
 =?us-ascii?Q?sMN9utkvP57Ka4+9AK0PmDQ8wkgk712p7WJDGQHxAF4UqX84TVhRV0BogJ4G?=
 =?us-ascii?Q?hnI26xhZIhbYJlNGXLWVXMZng2Hi9GJEojy1PZvjNFl2DE6st55Zxctfp0xW?=
 =?us-ascii?Q?Nw4n3OZVxQPFu0K0EWDhwsKiHKzBj1TujUY6Y99f0Yg/9e9PBFOFVIETDOyQ?=
 =?us-ascii?Q?ldC8YzSFTkTQ1PAskKJui3aU2tDDr6nZaDWe62Af7wTK1Eq+RwFwIcE7gIDR?=
 =?us-ascii?Q?0i47/X4+w3E4sn8bimwCY6l0xuKEZnHvbY+LraYENHkCbDQUE0nfOPMe/Jxo?=
 =?us-ascii?Q?E+gub2zNs0AQ51g5iEwF0LOcocroe+AUgSTum4I11kBQLt98YjNRKBIg/oPg?=
 =?us-ascii?Q?VJ0tZpDzf5IfheXiXEIeqLpNXJyZMDF5PM/+v/hIw+8Mj0to9cfh5tlR7MUz?=
 =?us-ascii?Q?cunGx3S0cnAZWLsU6FTQPf840sdxEBO4zJNIqLbXXs6XCcbg56UtNIAYzMld?=
 =?us-ascii?Q?wmRBiTlsAaW8DOyJRee/NWaxPCJpS1lZPsMUM9/Tco62Qt1LJR6mExKiyj1E?=
 =?us-ascii?Q?LXS6S2lx7aFdVk7iV95QyPPFK4wgagBH5m+gOTNFPDrW1p3MNqRWGjbdVs1b?=
 =?us-ascii?Q?lEKldXoYjnDd/dGDmRLu8CswDoqI2i9U7N8ojX6t0d3QRaQZVppw8zlhjOO8?=
 =?us-ascii?Q?PdGP/d9+mtGoFsbqO56f+RqVtMAseXtIcccu9iHpJjhbUMAh+kDByuFUcZuG?=
 =?us-ascii?Q?R3k3vEuAKjILvbLb/GLgfJrTK8XalvURv1WAkGY6K9bT59ike+7HCf9jxq4y?=
 =?us-ascii?Q?BHMPe3Xv28jhaVm3JThtPGsjbAZGMD3Eikp0KsPx/pG9HZyIk0XX5pMQaQZQ?=
 =?us-ascii?Q?S9kgj1f8XgWhGGn6JhDAIURIVa2xKJtckyD/B3hvB+dXYj+SuqCj8bZXr1Ht?=
 =?us-ascii?Q?nRfuhOgArlOwc/6ffFhvg+LmrsGVZXLtlgiSZLArljdQhlBHjTEo2ZtCjPkm?=
 =?us-ascii?Q?bjqvrWKth7a2pTvclvr6A4lOsDjTcUqmq1t7jJ9v/Z+Dz6jrMO1nq5qG2aU8?=
 =?us-ascii?Q?HGtiYkaboEfgVcBmXFs00b7YsMEpGz6zNUavu2mbwRyOuxwi91iN4kO8i0iZ?=
 =?us-ascii?Q?o5AY9CLx4LoGrqy145T7gdqCoowLFM3apeCbMReZcamY6XLEDo8vSLjymJrw?=
 =?us-ascii?Q?GoU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5Q9KRcZeVuvEOoBLDUDk4Qlw2O2R4uJBhVgPt80XC39fAr58+v7nCevjY6A?=
 =?us-ascii?Q?mm//Y2CpOhumZbWxHN/6QZ9+EjErbUXtLnas8s6xqw8k5gqNFfXdFujTtUys?=
 =?us-ascii?Q?VZ0AqV5O1f3IKT0mcDCqOyVyPxkVVBBVOP7A45i3QyxheMIHmBQKoSmzMJ/2?=
 =?us-ascii?Q?W83zQLFoZNiTgAu8fZITwHoOU+f4ACuyJ1PXMskWsLS+/1QxwtXyQ7SDeTGG?=
 =?us-ascii?Q?SibnKpk0N2Kmr3kwEJ4/z2ENwfCjNcLq2GdCIDgDqHmQ4WbPdlbyHlBfStXM?=
 =?us-ascii?Q?OsyCGCb0rJ4iumRvkrCsen/klo4xOZiG5O9WgeH7Z5KVZJflk9drf6ajNtYa?=
 =?us-ascii?Q?uk+RNTjcVJeRGLRVtBr7LIeDI0ny7PcNFB/KIzdKDjWipA0ou4jBEGQnQEU2?=
 =?us-ascii?Q?4B4nh0+gHxZCQNEXky6lYOlP8h4wdPF9jsqmOueTwbNM/JOJ9H0hde7p61zJ?=
 =?us-ascii?Q?Cz2nlXeJWp+7CQVnVTEdt1BV6VYTzLkb7L+0EhW5KUkse/l4YljpRQaHKkWc?=
 =?us-ascii?Q?lKKHrNr4dE/xiLLKwhg7BvkNA5CNfrrN4JZfii8w4q1v+P8eq+CswBX624i9?=
 =?us-ascii?Q?oY61GegYJ8pycoHtdDccz8gCO2w+V6hzYsGZkIUp6U6tgn12Fu1jQvOLyQn4?=
 =?us-ascii?Q?faVS5M92IIvmp+J3uM2Yl4khwfqoG+8SKNjUnFhfCtns2JhxBdf3EmkwAP43?=
 =?us-ascii?Q?yXqCmMkAGPlzUpFGy6Yrifce3GGk6vl5t7OehE9kEFPOYs6RBx27ycKt8g6m?=
 =?us-ascii?Q?v5C+vMt9rKhAaa32lNeopMtleKVqpHwcUqqXpTI/fQ17dzJYxk3W13wDBWSm?=
 =?us-ascii?Q?GOXTJk2cp+8JDL/gHY+Gv4DP0rKzRB+aMndpb/HjFZvNQ7D6v9SpcVmNkALv?=
 =?us-ascii?Q?/bP85O8G4CryKxLEL1y60q/a/50Otg9eP/X09lIxI6q1p6Oc/bsBZ9ZOPB9e?=
 =?us-ascii?Q?vOwqBBs3+35wsu1wbFcH5uX4GzptCeKSNbm98m0TtD2NC7z8yZb64aKLxqhB?=
 =?us-ascii?Q?7pxRANEDwti2GrrM7CSaVHHYO3HC+S+i4WCTDVgo35vXZUFUyhqSLBufIDRP?=
 =?us-ascii?Q?LzcekxD9IYm/vMiyx8+T3pqDHmMqWPlhhaAU2n9U0U7SZOoOm/L16c02ffAc?=
 =?us-ascii?Q?DL98/ih3aDMbG0TadLjYyesElv9dce4Wpa3vcqnpfFHMhTvIAp20GQf75k3Z?=
 =?us-ascii?Q?0hJhroVvhDg5A1w/+/GIJ3Gup7+QfmVydKUltDVdJWRaR0Z2xg9FlXaU5x4+?=
 =?us-ascii?Q?Md+jJRb90sZmxO7pKQM6e0xlTr8omLXBmLmnQtwze7Jb2D8SPgBfS+9c8XOF?=
 =?us-ascii?Q?nSe5izt14wUAEvrjxnnQ9NoaCi1dX3g9NddpNadXizqmaXT0rX7LNg10p35k?=
 =?us-ascii?Q?7XcHOrKnl6FX2AkGnMDwv0/qCo5VVIdvqqhOPCu7+TPh9JuqJwJLLruxGpm9?=
 =?us-ascii?Q?6UScgh5fQKPIRCpI1a9A3TuUX+avFhnEmSaXUWcbk69+AyDPwCv8sfkKZdB6?=
 =?us-ascii?Q?u6VPVO6Qlt2I9A19Qozy4e3FHVRIdeaNeiO6A9pBZQ0JAi0Bz1W4MoPEzHSV?=
 =?us-ascii?Q?nuAfw7O36/7kr4vn9bahs8QIJI9bNyhFWN0+qX2Z6C9wsqHfBF21I6GyU0c8?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a128b06-ef45-4513-9c40-08dc9865fb5d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 18:04:55.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HbjVtSD8ACqct7rXbqDaBZCJuSj/l1OpfPzBgryg1fdzORJfkqXkAu1fhAa8Lif5AZj2gfCm4ZYmALvzRvGKjYUyW78Ao0I23quOuuqtjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7587
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:03PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Note that scdoc does not handle natively handle the dummy
>modules.dep.bin.5 entry, so we need to create one manually.
>
>Not a big deal, since it's single static line anyway.
>
>Also: pkg-config --variable=scdoc scdoc, produces the full executable
>and path, although for now we stick with the AC_PATH_PROG approach.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
> configure.ac          |  2 +-
> man/Makefile.am       | 24 ++++++++----------------
> man/modules.dep.bin.5 |  1 +
> 3 files changed, 10 insertions(+), 17 deletions(-)
>
>diff --git a/configure.ac b/configure.ac
>index 9527aa2..dcf7479 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -32,7 +32,7 @@ AC_PROG_SED
> AC_PROG_MKDIR_P
> AC_PROG_LN_S
> PKG_PROG_PKG_CONFIG
>-AC_PATH_PROG([XSLTPROC], [xsltproc])
>+AC_PATH_PROG([SCDOC], [scdoc])

we should fail it if scdoc is not found and --disable-manpages
is not passed. Right now, it just proceeds without failing,
and create bogus manpages:

$ scdoc
bash: scdoc: command not found
$ make
...
Making all in man
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/depmod.d.5.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/depmod.d.5.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > depmod.d.5
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/modprobe.d.5.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/modprobe.d.5.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > modprobe.d.5
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/modules.dep.5.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/modules.dep.5.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > modules.dep.5
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/kmod.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/kmod.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > kmod.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/depmod.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/depmod.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > depmod.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/insmod.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/insmod.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > insmod.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/lsmod.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/lsmod.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > lsmod.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/rmmod.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/rmmod.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > rmmod.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/modprobe.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/modprobe.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > modprobe.8
if [ '/usr/lib' != '/lib' ] ; then sed -e 's|@DISTCONFDIR@|/usr/lib|g' ../../man/modinfo.8.scd ; else sed -e '/@DISTCONFDIR@/d' ../../man/modinfo.8.scd ; fi | sed -e 's|@MODULE_DIRECTORY@|/lib/modules|g' |  > modinfo.8
$ cat man/modprobe.8
$


>
> AC_PROG_CC_C99
>
>diff --git a/man/Makefile.am b/man/Makefile.am
>index d62ff21..0285fdd 100644
>--- a/man/Makefile.am
>+++ b/man/Makefile.am
>@@ -2,37 +2,29 @@ MAN5 = depmod.d.5 modprobe.d.5 modules.dep.5
> MAN8 = kmod.8 depmod.8 insmod.8 lsmod.8 rmmod.8 modprobe.8 modinfo.8
> MAN_STUB = modules.dep.bin.5
>
>-AM_V_XSLT = $(AM_V_XSLT_$(V))
>-AM_V_XSLT_ = $(AM_V_XSLT_$(AM_DEFAULT_VERBOSITY))
>-AM_V_XSLT_0 = @echo "  XSLT    " $@;
>-
>-XSLT = $(if $(XSLTPROC), $(XSLTPROC), xsltproc)
>+AM_V_SCDOC = $(AM_V_SCDOC_$(V))
>+AM_V_SCDOC_ = $(AM_V_SCDOR_$(AM_DEFAULT_VERBOSITY))

			   ^ typo here,

so quieting the command doesn't work. Once fixed I get:

Making all in man
   SCDOC     modprobe.d.5
   SCDOC     depmod.d.5
   SCDOC     modules.dep.5
   SCDOC     kmod.8
   SCDOC     depmod.8
   SCDOC     insmod.8
   SCDOC     lsmod.8
   SCDOC     rmmod.8
   SCDOC     modprobe.8
   SCDOC     modinfo.8


thanks
Lucas De Marchi

>+AM_V_SCDOC_0 = @echo "  SCDOC    " $@;
>
> if BUILD_TOOLS
> dist_man_MANS = $(MAN5) $(MAN8) $(MAN_STUB)
>-modules.dep.bin.5: modules.dep.5
> endif
>
>-EXTRA_DIST = $(MAN5:%.5=%.5.xml) $(MAN8:%.8=%.8.xml)
>+EXTRA_DIST = $(MAN5:%.5=%.5.scd) $(MAN8:%.8=%.8.scd)
> CLEANFILES = $(dist_man_MANS)
>
> define generate_manpage
>-	$(AM_V_XSLT)if [ '$(distconfdir)' != '/lib' ] ; then \
>+	$(AM_V_SCDOC)if [ '$(distconfdir)' != '/lib' ] ; then \
> 		sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' $< ; \
> 	else \
> 		sed -e '/@DISTCONFDIR@/d' $< ; \
> 	fi | \
> 	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
>-	$(XSLT) \
>-		-o $@ \
>-		--nonet \
>-		--stringparam man.output.quietly 1 \
>-		--param funcsynopsis.style "'ansi'" \
>-		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
>+	$(SCDOC) > $@
> endef
>
>-%.5: %.5.xml
>+%.5: %.5.scd
> 	$(generate_manpage)
>
>-%.8: %.8.xml
>+%.8: %.8.scd
> 	$(generate_manpage)
>diff --git a/man/modules.dep.bin.5 b/man/modules.dep.bin.5
>new file mode 100644
>index 0000000..795636b
>--- /dev/null
>+++ b/man/modules.dep.bin.5
>@@ -0,0 +1 @@
>+.so modules.dep.5
>
>-- 
>2.45.0
>
>
