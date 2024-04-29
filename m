Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE3176FDB
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427555; cv=fail; b=lAhCJxY/9/UsitmiYkhBobU53V8QaZycg6w1l5NyfIaZxf6q1Q2XrXtqvXJE2PY26ZxTpznrHIwSlm9+mgTmi0DGUKw7uztWd7+37x6QC1gWCcg6AgpzttaxDgNrc2SG9W10eaWkybh28AbjTlD8HtN8dIbkZ1JCh600K2Ob6iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427555; c=relaxed/simple;
	bh=ZNVx6kxKxy4Gw9wgNJl91UGIz9v+yfwKAodqH1DZsaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y35IqCik0nRQk/1OgM22dMEiJO1YNWD6M3nhun7LlWSBfN4Gfphe/BH5zJlC5M7Sm3BoqxdO1cj/6pT+z/MmB73Z2B175srHb6yYtSOTIpKinpDSVI2aD7H0i0Ms5WyUrTg+osEq2CpcQ3x7/Ga06Vfz4UZ5Q2ilRLdAkEIhscQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vf7p6bXe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vf7p6bXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714427554; x=1745963554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZNVx6kxKxy4Gw9wgNJl91UGIz9v+yfwKAodqH1DZsaw=;
  b=Vf7p6bXeJ4YtUQ35gUck5XixdF9uuEvFLHJ9lv84BsiP0FPdW52T8gTQ
   znG5jCdJUFZ+OtxmYbwNsb73wvPaQu/eptPfK9ZHRmwAVrvS+ee0WfRmX
   u4HNws1vmsxCC0jX+yk1fPUSQK0O8/NSTwqRtJ0TxOPv08ujEclosDVer
   lOOI/feJllvRmEwMRBFsx8gHLI+gYzUk+N+5XVFIzZlz8P9dinnTpWrc5
   7y4YAAj8kPRIt5fMAY1iGbbh3OKH18niWDznme2vVpElSvA1APtTOrIZB
   pe13izQj8cfbZmyk64BpThgSrGGPMI6DBoPPVSHKa+g2mszPuWnbaixfi
   Q==;
X-CSE-ConnectionGUID: gwQaROuASQmz4Azy8I9pQQ==
X-CSE-MsgGUID: 4QcYqWTlQpGCOhlnVM64HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13039894"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13039894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 14:52:06 -0700
X-CSE-ConnectionGUID: QPV2odXgQPClYL+23YLdZg==
X-CSE-MsgGUID: hIiAdA8UTxKkNGKjrKPamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57440671"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 14:52:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 14:52:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 14:52:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 14:52:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 14:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIMS/UgFT0fAVh+qCeh2m4Es/fQkUJR8VvdAQ97P2E9K+vr+V1Jfngvf4pdJpNypYZXDF0nqlmPHoZsjjpG+U3n4cvUKEkw1zHBlLB09JGHoZC0vcFtKWomirRLHnEpZbf46sB0PLR0slDTmZFYkaB5Q1om7XH6blO+soh+0CgE1k80KeMPZKeCd8a6KzlU9T0LXh3QFKfMvR5NP7J+zOiMrUfPGZBWbvgaYMU1KflPdYL5n9SA+2Jw2ikpWgEWxoZsY2HQB/EzkQwp/e0VLognZ3osGmA80VaR2MhEp8/wPWjG9NeM0+e3vGU3wHKFEy0isrkaebTdefIY9u6ZVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYEktabG4a/ZYSPS6kTrbYuGrHVZKaYA+pY9QmKBI/s=;
 b=JHamkvCSdi2Dfh95Tg1p/BUA9brSJmKmaCs/n+kT/Fx4jz0mzQchde/OlR/KyJFHg2y2UUxqw8I7rU6L8Q5+kRmUEPn4qx5sxhICjHCZpqdjxkVbP+5rZ2+sWr6yrtPdYpxGrrZdZdw5MjtzeeN3tKJ3zxodfQep6/aGMNrw6+JerqY0YqDcFaMcDsdV2Iat5VAPhIHdG5Y7vR36MIWxp8eJNLPuXlgnNIxpncITR9mDAEY5vQbO5OtMupTNivG7hlKIBypujWjJ6+YtYj2pUdNHcHGtdX8mFnCBnXe9dwKMloRkvInHXJ7z4zNpX249NdzO/LqHSYCWsfNYvaoKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 21:52:04 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 21:52:04 +0000
Date: Mon, 29 Apr 2024 16:52:01 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 02/13] libkmod: keep gzFile gzf local to load_zlib()
Message-ID: <jmwbr6swr5w6que2jbkywp23ho234epaide5kbw3f5wmbme4ma@4ssqttgsu2dc>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-2-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-2-06f92ad07985@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d9d0ba-b374-43b1-5ce4-08dc68969b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IQ/qgcTDLUfca7hMf8IhKY79SEI1f+U/iZYjGe/NPMjkJPyaAUbtIxGibQJa?=
 =?us-ascii?Q?tOPJuS7a0MG+o/Um0T//y2BR7U9vScO+4vXFZCB21mwPu7rj8pXw4MA68tPF?=
 =?us-ascii?Q?I5dAFqJRKFysgbQYdWNW54QpnTU+3IkRjSW/iDss8CcIAetskczwxP44mp4d?=
 =?us-ascii?Q?j+oWFmK1kCn7ySEgmrMvcz5xY6LqGK/8zy9ORhru7tYkMbxwKUnhIjXhU6ly?=
 =?us-ascii?Q?3Ylj8G2g7Rtp267kYkQ/Bp8QduzG5DPkQI94y7nIZPs7IwIUl5O9yXLiOJy+?=
 =?us-ascii?Q?mopHLze0EE4ljwjICgmkV1lK05vgGVdkgIa3jFZv6mnTlsY9M0fafySl3jYs?=
 =?us-ascii?Q?mW6dSb8oIG4Z6K36c3P0hikdUZhY1QAGMCxdyPhz3YZerzgqj7e9bE+pTWea?=
 =?us-ascii?Q?VwNQA507Vy40XFdgss+CgRtTuSNIWzkLpCN25l/nHoD3T7At/et8H7xyDVvq?=
 =?us-ascii?Q?oYUv6QTd6UZdGxP6myxd+smwaKHQtlengvmAD5nTkP+KrYI4D0sDn8vyw3WR?=
 =?us-ascii?Q?DSpE2JrPDnJ76Hb8ipFvYdODTZIfyHCs0edSBGuKFM38J2t3Bz3XGvW3kFWc?=
 =?us-ascii?Q?f3nYc+kKfaHEXlBEJyE2vq5+9vEIizFeAP6WvHa3lRI1wNW0etEY8dV263nq?=
 =?us-ascii?Q?myXkhfyFIXN697jlCFbisd0KOckSfMDMAFxGOYvkp8Qravev8nEG4uoJOe7Z?=
 =?us-ascii?Q?U1v/ZuSzbbV+C8PDC05fefHfv0K54ISTV8LZjeb0a8KzvRUI8b7BmgRSLKqR?=
 =?us-ascii?Q?vEXFi29nIeVykG2BvPh4ycXI9PM/xMdgdQejqV0J5RT8nZbQ+tA+VooKksiq?=
 =?us-ascii?Q?8qPpTAP9fTXSjNXjrQn6jqGXioyCfSbztRQz1PckLiLf3OwcZyVh/CCTMsXq?=
 =?us-ascii?Q?WPEDwbM1wR+7S5fg/JhqQU+7YtwxqRUY3TASXFCvgIMIBJKs81+ESUPG5rLO?=
 =?us-ascii?Q?6G2DprWk7ilUrVMr8cPw6qnzyLiyd4jHWG8nsPD37pVUYbmEMXWxP99flcFQ?=
 =?us-ascii?Q?+vv0etuGK/fU3rJTCNPtdQ3o9IyH2oP5BnfBmtFHO5Wvgt811vOW+5Jb17fA?=
 =?us-ascii?Q?mIrRu3SKkxopWpcyCEg8wv8p6qSurLVdv9yedq9ulB6WQyzl7dT0j2RNAv9c?=
 =?us-ascii?Q?8Gtczh0GGOrQMZYr35wKe2x8Qun3eH7yq1msHeqebbfPUGp6Fs4X4l1/GcDb?=
 =?us-ascii?Q?uKRWscDixKLlhZ2a+UK0in96pz4bVG7hY9nad2c0ijFCYaS47INi7BtOHjtu?=
 =?us-ascii?Q?oXL0kBh3I2vIgjkcz42stZW1ug6NcokdAepcGaehTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o52Ok+Aerctu7D3gq2AQIjFZEzKn0YPGEV5QHPM3xgAvtHk20PrPiKUm+buv?=
 =?us-ascii?Q?9R7blOTWZYvcPDPLAZsU6euw02Yizgh30GWJjLXTfQzrbui58qPIniwY18p4?=
 =?us-ascii?Q?0MBZ1xEOT7RmHz7IHVnKUK9b6yBETAvjc66U2OH1RUfokxhOSVN/PDuqW5+M?=
 =?us-ascii?Q?AQY/OLkSPcf9A2WPB0zYb/0AROGmD7QGHqVurNo7FgKCx2xmdN+m6aWeGepz?=
 =?us-ascii?Q?Ic4BopMLt1iVvDO7u7wAqmsIbtA1SpRovwx8G2/Xi/uUIZcBNicKRcTzSR91?=
 =?us-ascii?Q?2g43bvdB36MeNDSZjRKm27/BeKnS1dfVZv6hBP/azx3ByCOjjQih0uXyvJHT?=
 =?us-ascii?Q?W4MhZCDhthWzyAMhxg0DtavBBchLWaRMTv/Ozd2B1LMCfarIq0zRqNn+oUrl?=
 =?us-ascii?Q?rEWRhSiUzr6xMl8k6+4sjLoGrBIeMHseFtPP/HXojdH3hSHS6bls+d8K1vhV?=
 =?us-ascii?Q?tuvflM1c1YvWDPljjxGGFivHyQFjqc1oK0JfgR4f3iabEcgd+h4ctth936kZ?=
 =?us-ascii?Q?c5vtUrftBjO0iVaIohuvafbO/lLLKJiZKpwMMehwXfPYgVLDmPv59yA5OPhf?=
 =?us-ascii?Q?NjTM9vQcdNauggNIpS/Ck0hlm3WPFiEjTAvDD0gtoESVZ1LWiUf0qMVjuWeX?=
 =?us-ascii?Q?aTXoDRO8nPp3ixAMe8oTD7WuX4t711O6mnBqHaUP2OgsZ4DpSxvjnmx7vLlp?=
 =?us-ascii?Q?03TbhlKdDl87fwxm5Rg2AfNJmPiqdlOla3zdHNTpbr4PE5cRLL5NIlpz1fzl?=
 =?us-ascii?Q?3F2StpJ42gA6UJkkkofgCvVXYs0EC9ECnAWxFSgh34xJw0Z6UIrjtRAChUhL?=
 =?us-ascii?Q?Lzp+b6qwTFKMVDXxxCgXrzVI7oHcj9Gs4sA8mUJiLIJjdhr3rkck/sUsqQxK?=
 =?us-ascii?Q?RIP1s2CoQ2I0WdLfLJCuX/KZq8RAvv/XlkJ2DMkkgFmBwx68IInso2RgPLUb?=
 =?us-ascii?Q?bx6IaxjDcdQA4Ug2XWT0zOqa1t0eZh83mvt5u1DZfd6j01PXtROA2zl+3ojH?=
 =?us-ascii?Q?JCtusyt1yaIt9vwEc9X1nXFPgGL4t68cIpTpR+o7QvYJ2+qU20sAS0RAufP0?=
 =?us-ascii?Q?No5GlFnjw2SIcQIoL0YnYqZbi28u/LRA8fqzwtDMNpf7Vj4g1IuCMKzBhuSt?=
 =?us-ascii?Q?yINr5DlinTdvsi3WBgBLASeIfKcA5nvqfF8WwKOU8+e6fla4ydzfOU4j9iea?=
 =?us-ascii?Q?gxiB7ZO+ktuFJtrybrnDLR6FKdBjxxnuHxN1gJbgXFvXconLXDWmDXnuP18K?=
 =?us-ascii?Q?PyWqXYdjSHmimq4CcH66eU4PmjRUeCLOd+SyH9hOaJLY+z53SSu64xMCM3sz?=
 =?us-ascii?Q?SF7Bjh8ph07L9NwKZPYSlsMl0IPrF7vkeI8Ir/3hEjZJapNE4u0qAiAJUmYo?=
 =?us-ascii?Q?K7H5CrdRcMOGOs9DEvAEHB3iGbPf42UhdpNhJCcgu/miVCbRVj9+LuLuyAzF?=
 =?us-ascii?Q?6fv4Qjtj2ng3si/lR/SNNok+A6gan3Zzz16jrH1XWIlapj7zMPU+3sP29+pH?=
 =?us-ascii?Q?TCuQ0ArEwMNtB6isv2xDH/A9Ne+dIkVmJ9nPfcPPYc4Nbd2PLwHHkJtrdhR1?=
 =?us-ascii?Q?K3lH3eTRH7XeGrGC9L0+zwzR7bKHJ8/y6G+TlvJDJK2L+DT/52NxJQmYeie7?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d9d0ba-b374-43b1-5ce4-08dc68969b5c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:52:04.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy77EDy7Bw5T8dnL9aU4DStdIWwVP/TiTBIit6q+A0Nxo5dqh4KflSclXMlGKcnLvjoOjVhj2z3IZJJUBMWS522gX2n4VVnkr7jw1ajwBEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:03PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>There is no need to keep the root gzFile context open for the whole
>duration. Once we've copied the decompressed module to file->memory we
>can close the handle.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-file.c | 18 +++++++-----------
> 1 file changed, 7 insertions(+), 11 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index b97062b..9a014ea 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -53,9 +53,6 @@ struct kmod_file {
> #endif
> #ifdef ENABLE_XZ
> 	bool xz_used;
>-#endif
>-#ifdef ENABLE_ZLIB
>-	gzFile gzf;
> #endif
> 	int fd;
> 	enum kmod_file_compression_type compression;
>@@ -317,6 +314,7 @@ static int load_zlib(struct kmod_file *file)
> 	int err = 0;
> 	off_t did = 0, total = 0;
> 	_cleanup_free_ unsigned char *p = NULL;
>+	gzFile gzf;
> 	int gzfd;
>
> 	errno = 0;
>@@ -324,8 +322,8 @@ static int load_zlib(struct kmod_file *file)
> 	if (gzfd < 0)
> 		return -errno;
>
>-	file->gzf = gzdopen(gzfd, "rb"); /* takes ownership of the fd */
>-	if (file->gzf == NULL) {
>+	gzf = gzdopen(gzfd, "rb"); /* takes ownership of the fd */
>+	if (gzf == NULL) {
> 		close(gzfd);
> 		return -errno;
> 	}
>@@ -343,12 +341,12 @@ static int load_zlib(struct kmod_file *file)
> 			p = tmp;
> 		}
>
>-		r = gzread(file->gzf, p + did, total - did);
>+		r = gzread(gzf, p + did, total - did);
> 		if (r == 0)
> 			break;
> 		else if (r < 0) {
> 			int gzerr;
>-			const char *gz_errmsg = gzerror(file->gzf, &gzerr);
>+			const char *gz_errmsg = gzerror(gzf, &gzerr);
>
> 			ERR(file->ctx, "gzip: %s\n", gz_errmsg);
>
>@@ -362,19 +360,17 @@ static int load_zlib(struct kmod_file *file)
> 	file->memory = p;
> 	file->size = did;
> 	p = NULL;
>+	gzclose(gzf);
> 	return 0;
>
> error:
>-	gzclose(file->gzf); /* closes the gzfd */
>+	gzclose(gzf); /* closes the gzfd */
> 	return err;
> }
>
> static void unload_zlib(struct kmod_file *file)
> {
>-	if (file->gzf == NULL)
>-		return;
> 	free(file->memory);
>-	gzclose(file->gzf);
> }
>
> static const char magic_zlib[] = {0x1f, 0x8b};
>
>-- 
>2.43.0
>
