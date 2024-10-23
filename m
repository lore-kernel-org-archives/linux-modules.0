Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4D19DF4B
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718866; cv=fail; b=gnSSuv9JAR6LarIokm93E2BbewBF+hQYO6dKQAY+Zf/9275hFwW+tp3KF8mvlChFrySBL0iBLxpGqjpndQnlGmxeGF4U9VlSo1Y3z7z9fJ5q+20kBYeK5YGeRiz5NXCVlgA2MQHVTm26pZG7zQJ0EWY6fRbCdwO4tdcwlDT2w/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718866; c=relaxed/simple;
	bh=PikKYgh7Se72be+8R/PjPyDovft2Tf+ZwXrRDbOZlyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5gQSsArmrQ8a7WG23PvFIVCVDYhsz+BWGRoL33JcYVOqV3Oyyquaz7MHI7w76kwUMYyPxuMKbRjMgfVQk5OZn8Jutsq5HwrzOwQsTIy5xPfzaBpMWeyliZtYGRByrUkDBEwlK7JRZolh+Ky35iMY3JwxCYNMIwv1j/M0e/qLPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Au5Xakqq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Au5Xakqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718864; x=1761254864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PikKYgh7Se72be+8R/PjPyDovft2Tf+ZwXrRDbOZlyo=;
  b=Au5XakqqfuyNkM06DT+fxcFq3C4zi/w/TDu41VDOo6y99XY7KWadug/M
   KfADK6jYmxIup6NBUOSA6HJC4EiqK2uF0ExdwctSLG+fVI6RyT3/KsHXT
   P0f5rgKSJFbxgE6MIJGyVYRYGhAakc5+1fEr0sCBiUYZQKZZ+xHMV+YM2
   C3Ni9hfJEcYDuji2AyAwGOufAxIiyA0/Za1poIITJkQKRi8aLMVL2d/Xo
   XJWM3GPNBQnl7Ay7tTjAcmovbWIH8Ji9tQ9HhVXa//KyW6i+hnguh9Pvh
   Zlv3cdHKBHTKsbxdVmwNCUK3EF/4WcHDKon5YfMWaFuMfK52pB7yPklUF
   Q==;
X-CSE-ConnectionGUID: IfelnPrDQdW1QJ6GbI6I9w==
X-CSE-MsgGUID: yM52a7HmTCCM/HqyegBepw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29262158"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29262158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:27:44 -0700
X-CSE-ConnectionGUID: I1awog0iTaK4BT0nYx0y3g==
X-CSE-MsgGUID: 52FIipEgRK6KGeUfO5KoRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="79956609"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:27:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:27:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:27:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihI2n6DcaYs9YP5nd3yVD9FjX5KZuzWqGJ3khgusRDaPbBxsXTfpXDoVbJEOG/y5KnV1hWMnwY+8A9aIVqoltMnhvbu3FdHk4OMwQpiB189GVV9JXKck98rp/BX2IKrXshUDgtNkp6vE3fG3iON5qJywjfd9BTHvb7f77XY7M0zga/jRzqqzSzQQUSQKZJuFj4A0e6C0tbWPMtL6xjm2+of5M9ee7rtTU2aB39rULq52evFoGd2w5EOm+z9qqTOXae9TrdKM7axkO0/AljO06Uts+ZiqSEnMHj6B52D5wzBRvgM+F0k3QpU52cLRiMMtFVvDPZCatvRT5jdHI2S+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0khYl4TENrNwzaqoQytP1O34zFhI9BX/E7V2xEB8b30=;
 b=eeE0EnG1NZqFTzONqZh0lmkerqd60An72KQFb4G1r2pAJ+7P4SVd1AIYmnc67Rg3Qb2hWEu72jprkWm70k6CS1DhOHM6QYBd266fa8og6v71UtMpTk9xCi5tIvlo01V9Ef5xRwITuQ60GtTjynF0XTStB5XDCtbbt1OzqN3roFpttx9NE0s5KaHVRtOkBePfCbsIV5a6TVwiAMJYGIoHXDzSZh3+yqSCJuNgS1+6U1qCqJFxfVo6atJ0nTWQKaYpxO1bKXbU2W+3VvLFJyAv5hDReo5uiiojHU63hapi6TtqGHjMf1PSuAsm0CalzqqvOL9wb9Z1bLPHAnMgxNgDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 21:27:35 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8069.031; Wed, 23 Oct 2024
 21:27:35 +0000
Date: Wed, 23 Oct 2024 16:27:29 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Sedat Dilek <sedat.dilek@gmail.com>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>, Emil Velikov
	<emil.l.velikov@gmail.com>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] meson: Collect all prefix get_option at one place
Message-ID: <5vrrcw2esqfirvywkriphh7ravfkga4cikmwwinh4e7wi3mrrc@4wzbb5fewgxe>
References: <20241023205352.45271-1-sedat.dilek@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241023205352.45271-1-sedat.dilek@gmail.com>
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4634baa8-a5e1-4c40-2e64-08dcf3a982e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KqIxqGNSWbElAkYD+aCwBxP7rAYAt1NOGQIOezEfYm4m1qV5tWTD0vJ5ivxk?=
 =?us-ascii?Q?FFkbdVfRcqAUDNlGSlFnwiK2ZFPkzm4417ZuFY+zyOpepH4gc+ZPVwVz6cxd?=
 =?us-ascii?Q?XH+qMv11TvBR6wyVQj4G9GJFT9jPQtg3nNv9K1QoSwN8i+P/zZgIY6B1+MQN?=
 =?us-ascii?Q?Ma6MicqSj9sFOMHrdV4K1WeSlkRHtML2NZ8PHG2yoajrZQJ4txOwayYEk+Qw?=
 =?us-ascii?Q?y2fEdsusSqrRj4Pnvb3o59VxbgsQv8J7OkLdJNAm/0qsbDAa6LWFriIFRXXO?=
 =?us-ascii?Q?+lZSbeqelVxf8BjCQWYOIdGX1E1oE4Sqf+1bFt5DUSarKkR5v4VH5T/MbKNl?=
 =?us-ascii?Q?DawCYsrVukNotl+YWtEdyMRrSZOadtZxmCWRpW5p5P676ibLwu+7NBZi0sBX?=
 =?us-ascii?Q?ANuoIfkS17wg9QsgHOEjpkZxgrzB020XjHqPvW0C0W76ONq+hytrwOs1kvDh?=
 =?us-ascii?Q?lABT5Le7u8RToabpj0xzy8Lr1EfBJHJ1xOKSldnqCM3OANF3AVUWkwoj5HVe?=
 =?us-ascii?Q?8buWmI3ENPwt1TolUOjoqE9xas3UssP8YeI4tRqJdWHlCjB3DXSqwxXdxGTF?=
 =?us-ascii?Q?YGENcNFdMIoBMPn1pCwOryVCVWnrmCUMJwnh25jOB9ogAQHiUHwK5nCE4xFx?=
 =?us-ascii?Q?112TBP8K3Qe/hi5tCwbMDbKNvSkseFHP5pTUXm2MhyTm9NUxrpzHjxVOexWJ?=
 =?us-ascii?Q?5ykrgryMZVSf2K4JjUyokZs0XDUnwzpCup/rwsf7/4CbJn6n+6stHovco88c?=
 =?us-ascii?Q?YR412PXGRsELiJpnStBgPcOXIQ14+xkEYaq1pQ1byuluEeel/DhSQJZMBzQ5?=
 =?us-ascii?Q?14AGRBntOBSNcOslu+ioCmxtDx6BYjGPCxdJ4hk3kEyQjrV3eSzriFCESP3t?=
 =?us-ascii?Q?w75b/19DX8/a/Q7dopeN+CYkOXOsJOG9GtVMre6qqj/Hk+pXWJUlzLWVRZNq?=
 =?us-ascii?Q?RIwOtutcyztNOfxugezAxYdgJpCYzAyd8CeEOmaxJLL8RiAvtx1mTCd9LWgA?=
 =?us-ascii?Q?CzTdSHFWhDsfyeHn7vJAZ57BVl8uqG6zBlGqvv7eNFCU2+f7CxINI2JsvGnh?=
 =?us-ascii?Q?jnkmlB/ZEKcBIJoPJMrqI4YLpzHkzTILLy86pkDBNltW6h2+/eZ2CCA8sq8u?=
 =?us-ascii?Q?0txqQphckWWvdIb1FDvXhbSjPI/DutzrbObRCfVQ2q5l8lTBTEM+nxik3bnY?=
 =?us-ascii?Q?s9Dc+GFKVHIF9lCsBVQ77ZIKEFgtGxWKgH3VERmEtepyVhkfoFRyWjfTblvZ?=
 =?us-ascii?Q?SgBqmOCeSmzBiNYf6UrucEcdzj0rN1Q9qVNAIoVHW7nKx/Gd5QGOQ/209erY?=
 =?us-ascii?Q?gV+wyr4iFC8BPcx8YoFvE6Pz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5BKpytuFT8SkIG19s8bjBR0vc+UEL+hApSwwSyh00ZBqJF9ZrCP2ObL/T40?=
 =?us-ascii?Q?TW7/7ykr7mdZzAocEtSyLifmzEVL69XlXopqjIHXRS9/NTPq6C+z0BLiWnT9?=
 =?us-ascii?Q?ZU4zrpse8x3M01PdfgUmJ/gMPGsJR790S1iUt8YxYtA1lwkNeqzKA8gY2tiH?=
 =?us-ascii?Q?BaXDQZgAgqauytbATCOKwpemWU4UTJFJsedUWRF2wBBVMrsiZOjM2MWz37AP?=
 =?us-ascii?Q?khCcs6scBtgGV8SlGziHUv5ryHD/hnnwTLMtORdcnWLxmHBPk2kfLHT2Gioc?=
 =?us-ascii?Q?U83guWEXzT/gjXvb1XiFlJ8c4Ty9J4LbqpXMgZaGmXjfxxLZGXKPT4C4BT5B?=
 =?us-ascii?Q?fOkQXigw62AUkWFjjRAm7In3cOE42gCBeqrd/2BV4YDdNAD3CsBDS4xJLtTN?=
 =?us-ascii?Q?Xb6ZhvhEaIcWt7CsND0MQHpIwa5058zJNyac9n7kgm5P9TTRLogDm3lJrwjq?=
 =?us-ascii?Q?UCVgqRSx68xym0YUxt3Fk6ZBaGzTRlxVqyxs4OtbyLQTsPbI9Hk18Ry8VeA9?=
 =?us-ascii?Q?hJl5U1JR6qdkBgWpejjWFH3sJkOpnyamZHKK5WT0FnYDEHNgBiHoGFYl5nE+?=
 =?us-ascii?Q?oY1zxrnMlA+1+ozl/va8BGSAzIXRlaTkDaZ/aFNYAH4vL32yzjwhRZUBAWoI?=
 =?us-ascii?Q?VFTLm6nnNuMRAVOoAc2+3dCVP7ncgNG5WS+NPbPdpmXwzHkrgDxT+2WMMODU?=
 =?us-ascii?Q?JcKrg/OgNqBFnJk1zqP+DeXPFbBydMkjDZPGghSs02iW4iRJ6a3dERzfNMXn?=
 =?us-ascii?Q?YK0wk2Jn9SDXsHQcbMwWNmXba+2VPedVGYmxFKVhXEguwvxJpCTJVAW/OHFv?=
 =?us-ascii?Q?ic6HYVa9txuaH6ybL2zDrF6IIoZc2ozgjTXRS8rVpeV9Po6RIv8dsRUWM1p7?=
 =?us-ascii?Q?Oc8eF5XBzyShY+UlOIi975rZtaahlpwU4w+NJ8SQwndcPNm1OGpuaNFD4MZ0?=
 =?us-ascii?Q?lEmQ4d/ysSsHo8QfgezM/gdRl1TKtqI6upmD2QvJlDzP/u9Zsj69QrRgWrzv?=
 =?us-ascii?Q?6sonk8UBJyym7anz6JbT5TTQAAdy8p5RSTivBacgXhbxXbDwtVXAeP7h5Jmt?=
 =?us-ascii?Q?n0VRB/nJFdIzWo06CkzcwQkcF4bTbVxb1k9qTR2s71dTlkqLSPjSxV/xWLZQ?=
 =?us-ascii?Q?rVGvq8EKPuy5WqWMKGONI/kjxDfTSnOk28Hs9nQ+7aM+juYpEdlHkJ+DDXhH?=
 =?us-ascii?Q?iOT0a91gNvYGSPFfWJgiVUeIvEemuZr8qfhaPX3Oct2YI9mqRXYvTesyIU1i?=
 =?us-ascii?Q?1XDE5gCtQge17PGZaXy9kR7IDho5kqP2/x/scuEsb54MBaaP2hEvAtmX60ol?=
 =?us-ascii?Q?odJNJW7d/fQBVE+njEpzqWa0RW+9/XNUmR+KeHD+X6gfD22Yx0poJ6J3R1/B?=
 =?us-ascii?Q?e51hv8uM2sMkL7Z2dtz87YvNzwuCkicQGZR4VXqX9T1iFOaqnPm6/wurj9Bh?=
 =?us-ascii?Q?h1ExQz6w8c1vQioDdupxDusPvsjzuzd4sU3S9uNlCafj/PeIbDkMnpXHwihi?=
 =?us-ascii?Q?hH5IB4DP2d84oXtn06IcEL9hO/igJCwcohqCjYEcTkAnwFhS48eE37eLEr2o?=
 =?us-ascii?Q?OIdaK2laZQpa4ENS9ZO+AGzSCfIYM1bOw66LlUTKI8GaqD4drQLAtA4ERK1i?=
 =?us-ascii?Q?1IhZOZLXz5/maitSd63gGwrBG+BOQpDAbw4gWxkhcwsdUR9JFlRs/ngYmY6/?=
 =?us-ascii?Q?ZUlz6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4634baa8-a5e1-4c40-2e64-08dcf3a982e4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:27:35.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCtBo8fegNgwayuKQpDg780weUSW4ACnCvFiIZkiVGQ/Qn4cto5DlxSBmGSEBzakF6I7nINPDG6bU5WoCk6eu91Hb+rDQbmtthryY+dYWlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com

On Wed, Oct 23, 2024 at 10:52:49PM +0200, Sedat Dilek wrote:
>Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
>---


applied, thanks
Lucas De Marchi

> meson.build | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/meson.build b/meson.build
>index 58acf2eac8e9..2ed33c28471f 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -187,6 +187,7 @@ sysconfdir = get_option('sysconfdir')
> cdata.set_quoted('SYSCONFDIR', sysconfdir)
>
> bindir = join_paths(get_option('prefix'), get_option('bindir'))
>+includedir = join_paths(get_option('prefix'), get_option('includedir'))
> libdir = join_paths(get_option('prefix'), get_option('libdir'))
>
> distconfdir = get_option('distconfdir')
>@@ -493,7 +494,7 @@ summary({
>   'sysconfdir'  : sysconfdir,
>   'distconfdir' : distconfdir,
>   'libdir'      : libdir,
>-  'includedir'  : join_paths(get_option('prefix'), get_option('includedir')),
>+  'includedir'  : includedir,
>   'bindir'      : bindir
> }, section : 'Directories')
>
>-- 
>2.45.2
>
