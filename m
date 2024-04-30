Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD337180A85
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498751; cv=fail; b=KN1Y6fm4c0OvXeo+fdOAjCqCNIUf/KJo1o3/ehykhMvMB4dI9z5nI0R7hj6q8qX72iKs9SZwxXLoDd2bsWPUvNs5Tv0qSnHVkyTUKsJ+Ihu77Rqy0gADDNMbeHxw20jtilNagfqmbXCrASx18DB5P0iXSxicTkIVmXx+6OUTtgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498751; c=relaxed/simple;
	bh=GXVXPWIsMNHJpdf6tshkj8uN9CSawaWHw8QsQBc4+Do=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8Q8OP2aj+UXhxlvOOQroyVJDuFwLWtrI/Sod93lScZddQbF06l8NNd2TwOdZ8cGO5CF56mKnHTThJFW6j5pS/8OMtAvV3iwxug8KX8lAXzMhJfvsPkPdXugVF1/yEbUbFaCOR4RS2Xg0kUA7ue+ILpQHdXr3BwSqEG7yTBA0qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBrUd2G6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBrUd2G6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714498750; x=1746034750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GXVXPWIsMNHJpdf6tshkj8uN9CSawaWHw8QsQBc4+Do=;
  b=VBrUd2G6fbpJACsQOl9P5PfdKizSfqA0q1ECzsRiIraVLYQ0QxvHjupz
   SbwQGqA/3TCot35K5MDjhvuDMQLS/lNDymhQFVsVTUYFM4g38J2TTF/Wm
   tC8Vc4k9DEiEGEK7G2GOwwCTsyu3jm4SO+xlreW1nHY4PQ3QUlnQgBwnO
   njqKj8K8Wr39qwRnwPQ0XSufpNE9Jn0ulZYi5YtXIYOVpXN/xpZ2qhuj4
   E7zbFit/N+z5STyoQZzXGID4W5yUrPnhFmfGhyckwaac6xsw5U+s1DRjb
   Em8Bpb0iZmaJZIOTgVYUApKzQ9UeaSRHXnEn+7/fnEDwO5Xl92X9zTrUW
   A==;
X-CSE-ConnectionGUID: BPHvOu9JSiKu2oj6fMaHlw==
X-CSE-MsgGUID: asTs0KM7SnuHgKeswaWAsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10149394"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10149394"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:39:09 -0700
X-CSE-ConnectionGUID: FU+4xyWjTl6yva/SaaOB5g==
X-CSE-MsgGUID: 0gWoHdw/SSyOdYnEIu6HiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="30984784"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 10:39:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 10:39:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 10:39:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 10:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp95ccXxOscn/1yCBUvQ0ebTGYeTovAo1OpV1vZ6bQtD/ZjU+gxtaSkrWKHMJpW6BA671xe5fBcpKesabtR5rx4qbdlozdlqsr0rYDXv8GTdHtN2csUzkaaDqzPdNS7Mp7Vg0nihaUaQCyKnsuLxXMZZ+4CiEBFcGvCpPVLfl3pQ1Rw2/5Gh6ma6G/ZzzAJ7skR4X+okNZ7HBUetsma8gN2nFWZqUCdHJL5fp/sacyMgsJMd68u3HWEd5pLPHpfUWAwqa9jn2199r8uYfEW4Ybxwryo0wllBy340kQMdxv37mcBhwecNddxifa4lw4Sd/UbyPtaZbwBU7aE4PjLF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrYYxZVV5YRW2rYy5drOQGcwg7V5oaPeqMoW7jyB7Lg=;
 b=J83NKZBWMzX3/nCqQ5kiXEWYQbvQKEvtKn7sUpn3WCO45mGgxg1EPfa6A+18jBq7eIEfFanOUV+kwxy9cvAg6yTP7r/D7QEFYT2bY05zRUK49f3AtlFJFE0zoyvcQS940bfm5IEQoKXr/bdxayUIOYflozhjo7Sz5cnY969+/LpntfmB9NB6/Ih+nC+TTYOqeZHCiUVyFKwnQdLBP5jPqHrdAF8UMxPBdWr+dlTOgKkoO3BQhI2N+h7CL0MdYFGXYgC43yNDE5hEK7kq0BFnbnKbfGd1WkoQXKy5lE9hsR+IWpXifR8T2KFm5NKtPxrgQdJMuOcYuTh09OaiFeTnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 17:39:06 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:39:06 +0000
Date: Tue, 30 Apr 2024 12:39:03 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Message-ID: <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:303:b7::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: aee11472-cd41-4bda-1c36-08dc693c6ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K22Yq0Qsg0HdYCZDzi4XcOI9BLuxUdqcr4lQtNO97f1KUCcET18v4ljqs2EC?=
 =?us-ascii?Q?Oe7fHSguq3wfAssiAggk2QaIPrK/hDsnqY/8p+WH8/gQ0FLGaIduqxcYLl4p?=
 =?us-ascii?Q?fZ6U1Bs3tX8RtSY8R9i1gUYsjFr7lUp53CpLeB/CCvexw6Hlz1IQLYLFIahh?=
 =?us-ascii?Q?1l7mxF7X4++flhNb+6w0FOxHoqPtpj/Uxbsctcc35l4A7nxz5+yhrfM8tc6/?=
 =?us-ascii?Q?IwAq0af+dn9E5GypK5Vud6sEZg2jwTULBPWEVspyB6H/eZLePRz7Kiko0GES?=
 =?us-ascii?Q?n67vGqHuc+PyyPgIB6q4pGLdC35ckKRQ+b9AWS8+pzhaTSCH1KnBoYGNezAu?=
 =?us-ascii?Q?8wFEW19lGwpidth8gPoFrMVRn+UdVqes6CGYzYfZUwukyvKvMMFYI2VboXvN?=
 =?us-ascii?Q?wyN/5ibsZ/PNjqkHMpKeTGZGolgRV+r9qhHqXbwY8c6dfzbZkeu5G0KK3JM1?=
 =?us-ascii?Q?YLM0GLMOZaQi0cN6tONdVEUmZVNyhVK+ZowVP94dWbjRbdO6Q1L71NTcqhBr?=
 =?us-ascii?Q?PxGzHnfl8JOiuZnF6IyQv9JjVSjJj1reJP1H6h5DPnxjNlUZNPlin/6Wvwco?=
 =?us-ascii?Q?OjAHYk53a4//cgshL8/n+1PeI0oJzExlNAQJz5sUNJ/1Gu641sto5pkgthW6?=
 =?us-ascii?Q?Er0NXuf+BsaR+4r6luKyW6SIOXd6KG0/uFWhpW/sOsA67MQokVHi2pqYbIgW?=
 =?us-ascii?Q?1t27wFmyLZiLRD2G/XDSDInUmwSvOkvRG96gKIEFYSYQunMWwTtTdO5t3Q0b?=
 =?us-ascii?Q?4CQtMrBqfwEPfv2itsz307QEmKv+0OsXsh888mLZBHurNTNxCk2icMKf+uEj?=
 =?us-ascii?Q?hlWWM2g6BrVPUvBgRRMspl0IN7Sn4I/Rp6suLu10ppm9WRzyhagn/+7N02Ce?=
 =?us-ascii?Q?hZY0m14RBI7PV4rnYQQymD3FDuP+AQ+M0x3av8xfH6rxn0oUJzg8Ce6WwNzV?=
 =?us-ascii?Q?JxWuwC9JGXPmAWTiNiD4dx1jzzv74KCw18fj6vV/UcAZCdq6LARPehLNoXqf?=
 =?us-ascii?Q?/kArJtGedI7gvt+BWb0LUeqhLx5iva9dtcIO2UAd8BTpOBfYWkugXmafc/kp?=
 =?us-ascii?Q?DWyCDmFw02ecFTTmhMOm40PIy8MVIZv4zNFzv+HNyz2r4VB1isCuOMM7hyEL?=
 =?us-ascii?Q?GNcEpLdfe6YdGqNVeJviSbPA0OlV7oG8pUeqiq9Qv3Bs5238aCNp4Kfa9tNR?=
 =?us-ascii?Q?jBw5nbuFZrZsiKHGxPezIUxcwmhR6cXRLt4tMhH+JrEnfcKkgSp927JCVgTV?=
 =?us-ascii?Q?AJVoLAtfNvtdeAWQaEniWntZF59ErBNNRQzGRa2mRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?js88NG4oQTlqS5DPu5zcA4SIRxz5DSPZZEtOs0snF+a5sbs2aw/jrHNEBmqO?=
 =?us-ascii?Q?/42oZF+63bC5ZdtIu8j/QjfqZ+mcqXmIlT5ofaEFA3mjyS5UAKFRTi3J4GHk?=
 =?us-ascii?Q?aJG/9F/isDw7rB7rb87rGURm+/k6fQzbp8FXQkAaT9sDm1Lrkgs1Radx+AL1?=
 =?us-ascii?Q?AgabR0SNByOcAzFJuNx+5W/anc4kP+8fFh0wKDW3YXWQXVOYwfePEWuHP38n?=
 =?us-ascii?Q?DmzeYCXMSBRy27FOry/r80zwy/zmlHuWjQHPc8YWAdQ62g2Zbr3m5deig10E?=
 =?us-ascii?Q?PwCOOOK6NCJ9HDUxkwWf0y9rZbPzgTNjJBBj4/3xAcP9G+UE4uq1ztX+NuDs?=
 =?us-ascii?Q?88RK6D5gCBt2BqY7HCAf1v0NcGvR/fq/lAUTxngTdWZ98jnDUCZuL6uK/4K9?=
 =?us-ascii?Q?oLgII4wldax8lFVQLhUXU7+s393NNnM6RbJEIXm5clbTPnEUy9F5B3es2aDF?=
 =?us-ascii?Q?WSTeLGt/YJVR2XVeFXkXFWcE810lUVsxuMUOX7YXVlndUXAVhUpzwfbLqYXg?=
 =?us-ascii?Q?vtpER3yUgvOQp7dHq38vD+WFd9moRs0TLO5WT8KXR74O+nxCApRq99PmGli3?=
 =?us-ascii?Q?R8gC7Z0DJ0k7FQHNIQmX7L8RkBYOmAHSzReEy7yjGkTtwMmsS+DnU0YjnThT?=
 =?us-ascii?Q?BWXEN8y4fStTWIYYuXzcVQ7Sc7ZJIlXy/oYDijNubqCRZhv0co0Vn9PhMfyE?=
 =?us-ascii?Q?5nKRKy8qJu18H1ZFaJsCpaoTCORsxCnNnN5nRmQCOsN7j+fC/ogxZEPxvRwq?=
 =?us-ascii?Q?vPzHoaKzzeFMJ1Kjj5EIO5CVAfKIj7QEjchw2SSVFBZfTjGPPWlgFdvIN2rx?=
 =?us-ascii?Q?7k/qLx79uqSIuPCfy9eAKVgN3bvtR5Xj+dbZSD6QG+JOke97iY2hW39bqjDS?=
 =?us-ascii?Q?9okPS6z9oJ24TDonAoHUG11C2wbcVCpaBGAqLmqRBfmjt+b8F5boroC5mtaa?=
 =?us-ascii?Q?4i0NRfKhsJ+aDChZZMYYBTI5GdxlXIdWwf7mj4OA1PldVWcf0l9IB8c63sdK?=
 =?us-ascii?Q?CWVuptlWUHfvX58NvWGACYWAfKyMqa1qdn7KeXk7iqcQlZWP0FFqWPt/YUsO?=
 =?us-ascii?Q?HIKeKsZTGGD5xAaOehn0AbZh2QgfPGxvT3TCI5NZY46KVDf7uuxet2/mYgz5?=
 =?us-ascii?Q?hS0UDj6Pn0CQ9V3TNUiQnmk5wCysUxdWBTVFDlrnV3OPaQTtzhKL0fAoEztq?=
 =?us-ascii?Q?qsG5d6gvhAthzuY7bcUGBWLYUqwBwT2PE+rfKrrTtYCHSEsYTOvFLEeghDIi?=
 =?us-ascii?Q?4TJS4IE/iUJs+FutsHFI96KDvK4SC0FCWoO66axMlD4MPvhsgZftAhcTCzT+?=
 =?us-ascii?Q?Xa78QrdluqMFDBAwZpkqV/EAcOUY/GwkusRTtSn5mBY0Gop+Hm/NAduPp5G+?=
 =?us-ascii?Q?r0J0Pr4Dc9V2UhfnpHR36UO329HTnuoQ8o3Gq74mtKo8AKM7JTbeqevius0G?=
 =?us-ascii?Q?Eyua/GLxasf7uH9oOtJw8xQHSdlgdxUScS+fE1T6tzfjJT7gF/xYqrsdqFAv?=
 =?us-ascii?Q?qkOpdX+gz2BL5I1Oo4HAV5zHmPMqsObxQX6pF1MweIm+BvWt85RLozej68fQ?=
 =?us-ascii?Q?nzWgZ6rNWBAYvUZ/YCFIqfDJSivkImBrfnV6Cl+nSZN1nBah3AeDpsUYQStI?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee11472-cd41-4bda-1c36-08dc693c6ef9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:39:06.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8I4OaVs6mHGVsr6DfsjVUTlov7zoyei0mxc5ypCxTPOlClakeED21WKYI8xrfgR8I5ZcXcmW0nVno7VGQm65fjQLJJP2B/V5J6miEhzdCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Since all the compression magic is always available now, we don't need
>to loop at runtime nor use alloca - latter of which comes with a handful
>of caveats.
>
>Simply throw in a few assert_cc(), which will trigger at build-time.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
> libkmod/libkmod-file.c | 22 ++++++++--------------
> 1 file changed, 8 insertions(+), 14 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index b69f1ef..5b88d6c 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> {
> 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
> 	const struct comp_type *itr;
>-	size_t magic_size_max = 0;
> 	int err = 0;
>
> 	if (file == NULL)
>@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> 		goto error;
> 	}
>
>-	for (itr = comp_types; itr->load != NULL; itr++) {
>-		if (magic_size_max < itr->magic_size)
>-			magic_size_max = itr->magic_size;
>-	}
>-
>-	if (magic_size_max > 0) {
>-		char *buf = alloca(magic_size_max + 1);
>+	{
>+		char buf[7];
> 		ssize_t sz;
>
>-		if (buf == NULL) {
>-			err = -errno;
>-			goto error;
>-		}
>-		sz = read_str_safe(file->fd, buf, magic_size_max + 1);
>+		assert_cc(sizeof(magic_zstd) < sizeof(buf));
>+		assert_cc(sizeof(magic_xz) < sizeof(buf));
>+		assert_cc(sizeof(magic_zlib) < sizeof(buf));

../libkmod/libkmod-file.c: In function 'kmod_file_open':
../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    25 |         _Static_assert((expr), #expr)
       |         ^~~~~~~~~~~~~~
../libkmod/libkmod-file.c:424:9: note: in expansion of macro 'assert_cc'
   424 |         assert_cc(sizeof(magic_zstd) < sizeof(buf));
       |         ^~~~~~~~~


So I'd go with this on top of this patch...  I can squash it as needed
when applying:


|diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
|index f162a10..8baf12d 100644
|--- a/libkmod/libkmod-file.c
|+++ b/libkmod/libkmod-file.c
|@@ -408,10 +408,15 @@ struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
| struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
| 						const char *filename)
| {
|-	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
|+	struct kmod_file *file;
| 	char buf[7];
| 	ssize_t sz;
| 
|+	assert_cc(sizeof(magic_zstd) < sizeof(buf));
|+	assert_cc(sizeof(magic_xz) < sizeof(buf));
|+	assert_cc(sizeof(magic_zlib) < sizeof(buf));
|+
|+	file = calloc(1, sizeof(struct kmod_file));
| 	if (file == NULL)
| 		return NULL;
| 
|@@ -421,10 +426,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
| 		return NULL;
| 	}
| 
|-	assert_cc(sizeof(magic_zstd) < sizeof(buf));
|-	assert_cc(sizeof(magic_xz) < sizeof(buf));
|-	assert_cc(sizeof(magic_zlib) < sizeof(buf));
|-
| 	sz = read_str_safe(file->fd, buf, sizeof(buf));
| 	lseek(file->fd, 0, SEEK_SET);
| 	if (sz != (sizeof(buf) - 1)) {

Lucas De Marchi
