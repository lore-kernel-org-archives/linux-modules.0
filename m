Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B717B503
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433541; cv=fail; b=hqfD4gICvV0vQ6O0xhARyaT8ErdDXJKxLrUp1blg8LZq/hk+DB8ysxXAnyypW7QbayDNE1VoftlzBvwTvgpP+4pZt9DhFaY1ZWJtyzfMpCGZ425w1woms8BGThdMHqN3//K6ZwbdBjDzE6+jfgeQk2t6b33SlqQFDbj7l9mz5OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433541; c=relaxed/simple;
	bh=/M5k5tnevCgU3V+O+b1jctMPhYlMft20xMPvHeaZ/9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pG7SmQygRqmsCvPbZYikownXG+ul02fJvE4MNKkY6ij++8P2lOoKMCX7jg9gYkwr/D7t/j0CYjtNNMdTOhIVoYUNNKzXDyMfHgrJlZPkIx51beNy5V86edt+EcweQlVglmkqPpCY/0EpuTY/vMICVA+wJEjVEOTeY3LI/AradPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/bkJ5HJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/bkJ5HJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433539; x=1745969539;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/M5k5tnevCgU3V+O+b1jctMPhYlMft20xMPvHeaZ/9c=;
  b=L/bkJ5HJhj7Vk5DxJPmbw9HTqcWcxHeGEBd5/vf1CjR+0K0M52kFMZ7J
   wrX+E4qoP5wZ5OtOw8f2PIFfZ438F1pFlCQzJd/YWoso2PsxGxLNyk2QO
   f4fJDo3GvtAIJsxXFYqHM55CjPHmsBiADVvK3rZXer9DMdTLlFuKL+XF+
   Q5tZweja69R+E9vpf4+VkknYk6wWqbEDnZ0wIAOgaV5bbKS69VG1CVsQh
   f5LK9I2snZzBaYtIwYaZlT4+mDhdZLVrPzTI+88ix0LXEZrb9ca0+f2OT
   JZqkTTK46sKrYXrtc34hGlR0wNhZXw1vNHM3b+briSA0WegV3/uQz45ZI
   g==;
X-CSE-ConnectionGUID: LPf5UWuWQbOgCDIndiup2g==
X-CSE-MsgGUID: EWF5zhYeQOmxMrzG9vUa4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9964320"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9964320"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:32:12 -0700
X-CSE-ConnectionGUID: XSYciBdvS6OOiJPKP41SUQ==
X-CSE-MsgGUID: V58LCTptQGeyTlU7ppSnRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26344464"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:32:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:32:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:32:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:32:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkOavYL05QwLAK8FlpUO2VNQ044u/gyRaX6bgO0fibD9xJdG6gULcAuBMmrPVgTWKOGyH3iWcILr9miISNrod2FT35iScpA9YKca51s+o9HyHZs27QHDNE/ngIcUXW/TPS7azMID7QrontdVJGe9fCbzZm7xn2Db9tgKwCNTv4i3kaWJuilANalFz4AxEiNEyffp3wjVTq7Gxl9IVaRnrtUk7oHWHhsmi3v2BbW5qYF8c5jo7DpMmDykqQD4zdv1MMvBnxY6TO9/tbrC0PiteH42jbr/m9Toh9k3pVytBz/VBmyTrvNLZhr28CzGL4MSQ3K2S/7bNCknQ2bojKaHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3aFzi0ANYFKYDzHJsGbtwUZsecim0XFJpNN7BYIy0g=;
 b=iJlhK5FUKbJZSfaa3XZmljf0Q3F7tc2Fd4sg4myqT9/Tj7VurbAVa7vmh0nzOXRS4aMuOGyYqVw8CX7lbtTSCTX6afmpNNildtdjNJCdorFpqduABZ1QGiQUR+3wW4NyEiS25iCUNNbSwy9LNk4qTOknzX7fXQF1H4zMDcsaPanhKkFSKPZ3TcZ5DzWOIgSKh9RLKAOgyEz53k7VnrW1cIduGX7Jyohy0vdLo25WSkmY/VIQ9H09oqX3qHo3WHizX+7iFTOj2IeeEouGINVnchQCxZ7/uLmhCQlf1W3zKmjUvwlSHFNKN9x7tqep4JgnQxv5ZmCXCoT+VFwBKkFycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:32:09 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:32:09 +0000
Date: Mon, 29 Apr 2024 18:32:04 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 12/13] libkmod: keep
 KMOD_FILE_COMPRESSION_NONE/load_reg in comp_types
Message-ID: <n3fscuqvadolqum3hd42hzf7gd3kozhz6ezkaajs5olcsf25oh@dpmqa6pqmao7>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-12-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-12-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0b2bac-66eb-4abe-8ecb-08dc68a49664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JSoyKWLOJB+LCVJ33XjycTH6kghj/kKJI0DrrGRcbEs4VoqXeLN2dZ0303/k?=
 =?us-ascii?Q?y61A6Ez0Jgvy5vS0SFmh2l/YcUm7jQnoiOfmBlWSOvMvG1IAK/lGAuyS4cKV?=
 =?us-ascii?Q?Vknz4nr8eTWo2PFhFyx5Gq1GB2X+1/OQCN6TNlu78RXO4HTtDfzgufSPmLVf?=
 =?us-ascii?Q?A9l6WIyQ0d/kUhbMa0GAU0APKtKp69OgKTMjidwCGIhx1l9PWsGplhTHD7IW?=
 =?us-ascii?Q?mtOEY+lt6AHx/hMMaMKZVRoOsLAkO9BpgnRksYixdj0ERqUr9NIxdxLVgso2?=
 =?us-ascii?Q?Vmq5u8ibad83cg+GjzrVVF/8nonB/gUJmjoHLF/4/s7hKXIx/4pAZVULnCGy?=
 =?us-ascii?Q?X3Q4ms5ZMywcdqiV1IXDybRGQPvnYHL71apt9RaT136nieKxdfqKZFZe/ywk?=
 =?us-ascii?Q?pGytI2nxNbdZc03cMsIesyZ1L3uxDK8lidwuzEz7OkSgs8NaYqmVdGi2m5j+?=
 =?us-ascii?Q?7aALDBNraMTLWfpLQVIBKComplp8UEM5gNXj9c7t6wGYHMc7KPDTOYi0WRJF?=
 =?us-ascii?Q?lXHHtkM/jKSxzzRuEglg44/r/80DhqogNbTf5qQilh2WtmQr9jns8FtlFKlh?=
 =?us-ascii?Q?msiUPaCgXFoeOE1xkraX8Y3PbCxyXPvzLo4QgppwB039zd4xNCYc2OxRiz28?=
 =?us-ascii?Q?Y98r+I2KVVJXnrTv1ljyuMO8hJNgW1MCLc42hUB0TwWxqKdNef+H8cmwxDP6?=
 =?us-ascii?Q?y6vLVyC6QX246wDjwY+IPsflR0SBrvuakr0lw743EUjQ7v5zsXi2ToWInek0?=
 =?us-ascii?Q?3V8cbt3KmTD8kov6RjLVXX665XNKCyAYV6KEppOjLg3N8Jutj+kYktT/mf0P?=
 =?us-ascii?Q?+4wd5XtOajDPgRMDmU7YJKUu1PXd2rRqnlFvlYPWd3LBoHnI2qonlSrEZj1U?=
 =?us-ascii?Q?8YNOsXF9uPMbWvDiWkKVzeSn91VcJJflQLVEKj+FCRfPJw8fNp4elBaMWEZz?=
 =?us-ascii?Q?KhdaWiv7ueEZCAXKuegQbjfF0Bwpsu7Is7bN6LCpsEWKUjOmdYvlVxW9NX6x?=
 =?us-ascii?Q?2ro30BtEWjO72CxAPjMWTfuEin876NXk3PntPryjWYvNZDFlr3uoU4DG3bZ9?=
 =?us-ascii?Q?R2Wqjj5KB5rJiSt6xO+WfXzliuXHnDfQu8k4MnMtFyFtnklhX6zn2rgJZJ2G?=
 =?us-ascii?Q?q43WS5rHDvFsB43AIbQ0dGJ/H3Q3dTc4kTNR4jXtaHDT5PFpor0OoiMM2TWJ?=
 =?us-ascii?Q?XDGN3pzUE3qePtP4drIeEX+u6WApWiIPVIPI6x5x2HxhstIm0/wnIC/nj4wg?=
 =?us-ascii?Q?YeI2WqLoGHnRXnvR4s7n7pP/1akHEszVVtyISqh4qQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QbvNs1mgZeXEitEZ7mEH+2+9/gWzmAxqROUcQnXD1px4nTayik774TZBw8b?=
 =?us-ascii?Q?pIxsksWhtVOkpBwM6pxveGPgWUhdzZw2560D1qcGx45CnFBurRvW1zZYA1Hd?=
 =?us-ascii?Q?2b4cZS3X6yqPbvpruJlNwzaRVQXU9BDN62BHUuui/1eaGN/6AyHVy91KFuPs?=
 =?us-ascii?Q?uuTE3TonjVzYgZzKZnON4Tmp68MGlMEK1fwwT+ngkl8AIh2gLd/rniJPZq3g?=
 =?us-ascii?Q?IiGjjz4ZfiFCkjGNF7eroj9qxqznNSwY+c7eHLfGlWzVs+HwrGx8o9N57yxq?=
 =?us-ascii?Q?lkSNSXtCVSBn0tDGdwM4eSF4pzTNIRbxjgDkB18qzIECVCTJ99NEhxUiPPpH?=
 =?us-ascii?Q?R8tfjbxmvngQ2bWasNlyYkOiRwRSzsY25a9rfdnNRpsLXwXHbBAHmhQChInD?=
 =?us-ascii?Q?f5dkICQ/nC4C7y4+05DfR3tDXYSdLuL09DYKSIyjho0P6sc4helTZTd9RhkM?=
 =?us-ascii?Q?D/Zl0euYR9Q2iZS4KTGkyNja7Xpuj4zEQTgrOGMaZKpRJp/F7WOVLiehBDtw?=
 =?us-ascii?Q?8PyLva0ZLl54vwTzamSHrHvobaVeKcWLVOp/+ghVDHYPDmMzGb/leG5+gGf6?=
 =?us-ascii?Q?TnISZGghnsp1njdvsLn1HDlHe2oTq+OIBPkRkMg+PmS46hgBGGz8eo1/+50u?=
 =?us-ascii?Q?Y+ZjYbLerYRoe1512zv2x1eGGJAFyLgr9Fqjg6v1VsPyzFlK6ihbjGK1W7fK?=
 =?us-ascii?Q?Z9TQ+ZakfTEE5pnknbUcCzHmC5pqRJL1D0ns+yEqfDVqb71OZ4ChSLagZoXT?=
 =?us-ascii?Q?53peG3MfUUIVRlHKm4RBP8HwAksx8D2ulpkRz1Qfqa6BcstK2O/4DBwfLLlF?=
 =?us-ascii?Q?1AIIgFIsWqgmVnzFrCk1h24r0BRBaKFbG9fSP8BCchWWDsQOL8fCUMYNvBNy?=
 =?us-ascii?Q?7ZcHVuR1H+QGNhifNOxMi99cL+7MPmpFlXbrB20dbe+0Jk7J4b8NZCw9F/rG?=
 =?us-ascii?Q?Lq4JzdgkTSCyttY+huEMhwo/MX2I2KC2yhmoSi3ZBJPFeXiViboKGy+zIcV0?=
 =?us-ascii?Q?/xkRczEy+z3jKi7b0LRbO3UIpYKKjGYosd6hh6FERwTfNgAHGe8uwlOSpZsR?=
 =?us-ascii?Q?rikrH7CgEmb9qwWh3k/LV8g/bnzXunjVXVYeBGLR4wX/OWIV8KlSOPmCLROf?=
 =?us-ascii?Q?9qSEAhSIr1BIl83YlqjRiK70i4TTcu3tIO8wrvdk5ioqxf7hXoTZQlZpqMTS?=
 =?us-ascii?Q?xilcsuqOjU7qgIXvG97VvHQ4WOScPBikXggxCrhNERUYSV7mqdaKL9dYdmqm?=
 =?us-ascii?Q?nlqrLVYghJldIGeciq8L2fFexHLaVohasDcCxi9RdzUGLXngF/NXseWQr3rc?=
 =?us-ascii?Q?CA5qcDo+9QwRVwKSYBCzG6KRMFiGhgGu05L7CxxgW4cwlwa5uWPsP7nvHZ79?=
 =?us-ascii?Q?1N5nfytiqCVYFWDvmpqtEmt7de6NFHm98wp5fgWF8AnRiHTs6frQ5GaGmSBS?=
 =?us-ascii?Q?qcABEu17bWBqtMGNWgfUpmss1rYE0v6sNEhH4WsHwshW0JqDChCaQYUsmqmp?=
 =?us-ascii?Q?2tieulpc6aD9hM6UaoBuJzpWD396NLwJ+2aWlZla/p/Gf1SLJGDraDZ1M+W4?=
 =?us-ascii?Q?wa+eOEpnKpU6GHFjjyNcFEDgB6gtnQ9YbUS0nV3ozy14QvhvwwleIUBOTAvj?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0b2bac-66eb-4abe-8ecb-08dc68a49664
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:32:09.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqSb++6lEnFF1YYYki2tdwOPx0PKarq9hAqo4mqbEBHVm7fB67a8QcNhN/IYBKGiRI500MCvs5yX/yD6ZKAeQ0gspmlEsM8KiyMItQR/x7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:13PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>It's cleaner to handle all compression types and load functions in the
>same style.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-file.c | 19 ++++++++-----------
> 1 file changed, 8 insertions(+), 11 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index db775a6..f162a10 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -385,7 +385,7 @@ static const struct comp_type {
> 	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
> 	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
> 	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
>-	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
>+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, load_reg}
> };
>
> struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
>@@ -409,7 +409,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> 						const char *filename)
> {
> 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
>-	const struct comp_type *itr;
> 	char buf[7];
> 	ssize_t sz;
>
>@@ -439,19 +438,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> 		return NULL;
> 	}
>
>-	for (itr = comp_types; itr->load != NULL; itr++) {
>-		if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
>-			file->load = itr->load;
>-			file->compression = itr->compression;
>+	for (unsigned int i = 0; i < ARRAY_SIZE(comp_types); i++) {
>+		const struct comp_type *itr = &comp_types[i];
>+
>+		file->load = itr->load;
>+		file->compression = itr->compression;
>+		if (itr->magic_size &&
>+		    memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
> 			break;
> 		}
> 	}
>
>-	if (file->load == NULL) {
>-		file->load = load_reg;
>-		file->compression = KMOD_FILE_COMPRESSION_NONE;
>-	}
>-
> 	file->ctx = ctx;
>
> 	return file;
>
>-- 
>2.43.0
>
