Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7917B503
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433430; cv=fail; b=ufvrgJBxq/3CaiuaB32mzCmYnFPXBmCL9SrCNwr6iLgbkIMz+YvRGer68AZEHgzEYL5LFrpfJDW7xdT85DaflbZJh0OCntH3ASedeaVZ3VC/ILoJT2XACCKt1GDmSVZ2iaQOpKjnGuzQbw4rJ6/Mlahsj5ZiHzZpmrcs88KnfuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433430; c=relaxed/simple;
	bh=V6POo6RWASiVSojxzs/4HCG78yn2W0n33ll0FoA/GJo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JhOhv39rBus/W2q/5u3am7dv9GnaAUsY9SIyFefplQvSl5sOCCc5RDfg4vMxYN8o1A1nIh0hVCGXxpL8zfyiQ5nF/O0538CZf0D7rCQxL3tnT6Q/Mt9nUJt2B3bhHO1tYzULosIlOmRm7jgt1o+714tbatJOzEQgldct/pXLeck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJDcZN7W; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJDcZN7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433429; x=1745969429;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V6POo6RWASiVSojxzs/4HCG78yn2W0n33ll0FoA/GJo=;
  b=BJDcZN7WBRc8ZVch7SbVrIFdUiQNkjHvG8ou3iMy+MRujR6G7enFcU9x
   5vgDgGx9e8ENuyzFFJCDjlDx5IRR6o68PIiROCLuMzhrLDEFSy/vziJub
   YEpW0JtNH1e3W90ovPetn8hPmVufTgbsG3y1dYtsrPVF4cbGij9iTojsZ
   LQrS0Reve2yf5gLh1p/3t16ZIJEcfKph1GHZMaDtGJO3/0mda1Py+8TG6
   qaCLBwCWq7AcyWsTiIMsMt1gTeMHD8RK2LkVeYTi2Tt/UpTCvFh8qd0H1
   hw4Cq0hNKsHGYqNSaNrej42Zr4da+WR7Iv1m3kMNrJCVNUYeQr7z7N4f6
   w==;
X-CSE-ConnectionGUID: KOyu5oTfQpiBnPM0PLAPkg==
X-CSE-MsgGUID: oegTImmmTI+AX4pNmnP0dQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13909137"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13909137"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:30:28 -0700
X-CSE-ConnectionGUID: 3fqPwAIKRpmT+x+O4TrEoQ==
X-CSE-MsgGUID: utKmdFv6Tv2iQuVfW6qiEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30715691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:30:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:30:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:30:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXGSQi1Fvvtkvk08qAqVfqbU21G+5oZWjV+wwbkOEB0xbDKf26aCFQBaNzsuQTxsZdDD9rvWY3RnYZtdAigDBP4UVlCmO6rcvqBC4H5nMQ4W6V5i6FMGuAGqrhB4LW8g9EnOgVKXKUcdxqZSjFEVSaplwoGnwFF0vYf39CWS67rFzoUAfLg/ryb9JzOvurUHUpP/JRrHN0XProhyS5uEfO9l2k8fPdI1EnesDlyvdgH7bTp+YAg4L1NyZ9h0ql2ZJuoO2VE/OzrCrrSJQtxtZRZi5TzapemfPtD6LX5wfJ1BlMDEGxZOu3snhbYwcnhoMtOr408MVo4iqhEs5Q97Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5/X6cKiuNkxmrb3kp96a+8PTa+Hk2o3KEUGIWwcff0=;
 b=iyXxyDfJ9+MirTfhTKrq2TGisVXQGzNKmfVDAf9HY/2SAKProeb6AUqDF6EsEL08SiePxB1vpCYATi+bqyDdC64E2LNP+txGUWhG8WU+eyShuDn46/oeewZTV7spvyDTlFXGqkulZciatjEk19KuNG5Bfc3rg+YETQN55SBgJpvFcvXtfS9/RF1E1HCAvdwRAiG2eMK/cqv6T1zPk+Z3EApd+Nz5TUmw2Cr1an2FR69IYqLrmDybar4ziNCQ5LlxP1ULr7iesnhjx84RZvELLEjGwUi4K0qxoi/k+SF9AptkSCH4srttlX/cR5qWTYggxzbmKf1f4vmnp87MH9fahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:30:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:30:25 +0000
Date: Mon, 29 Apr 2024 18:30:21 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 11/13] libkmod: move load_reg() further up
Message-ID: <s3cvuqnysebdicus5qhvikamgye73hsiqru2kz2ysbipdg4tsz@lgbknfbuye7d>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-11-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-11-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fa8fa4-2e71-4a87-bf54-08dc68a45892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6zp+Bw4X00/FM59cMyvSwTAbEE5BOC1nmuAvWKGJF1sEfeTmKwznBORRRxgG?=
 =?us-ascii?Q?cQvaIg/jNCB9x/DjYEkD243H/JOH+ks6uRKpXoY2HNjnb1DPzQvA18/uAXxG?=
 =?us-ascii?Q?MMJyKfKmnPOUGJZzmRvsKYDd4AFc58mhirtOZLH4Pj3l/v4ugMNuDcqkhzC8?=
 =?us-ascii?Q?tlkeoiB3BAWRnUShnh7xWt8SKpcM3wDGaA99tkheEdvdUa4Kp1+Y/9u5XkDh?=
 =?us-ascii?Q?CGdb98Isbq9tJY3Q+quWvntNiET699O11b+Za5MUG787cHw0f3Vir+wGB8P8?=
 =?us-ascii?Q?84oBjbdDGwhLozyXL3E2yUt9306X0R9dvIJ0xWcb68GfQi9WT6uaPcyLz1BJ?=
 =?us-ascii?Q?DqGTSJeX/qzJTgZhRKpa3aQNL3xx1E1a5fbWK4nZj7Xj0X8GvP/J+aAy2MeX?=
 =?us-ascii?Q?2h5vBcwnElFzGjEI4oHr8iGncOn1oniiZJQdbn5qEuMjX0DU9BshhzyKBrgt?=
 =?us-ascii?Q?PSkusvqDYICfa62KgpFiKamMtlkIyoVYKmqnQHvsZsKTqmeFj1O/y37IDdGB?=
 =?us-ascii?Q?bM7mflStIumZT8nZnvuUDPGVceT77VXmflJ/SoFEy7yd8VUKwj2YsNsiaE4J?=
 =?us-ascii?Q?LqnL9fPnnKriV/+GmL/HHjq516nZwf3avKFWgFhnj61mJfTdcgksJrluchjr?=
 =?us-ascii?Q?eP8JHXJ7FmaCOLofBoPiybrRZHGDBrFJaqdl26OH1EGZg8YEltyiamo6HUat?=
 =?us-ascii?Q?+XpOWXtRkHUjE1638SH+8ji7C9W2dZ5ZQt5spt3NOXuca+K5I/Wd1gm9UBpc?=
 =?us-ascii?Q?YmQsjbR/0+3Ia/gnb/y4oDXqPf7ErABPxTX4PYf0sGkb7yO/PFmyvOfVsoj1?=
 =?us-ascii?Q?4tLKgRc/xecVQGMxrbWGG0eVC+RG2yJcjqA+qRnBF91PbqVUKYcofdPgyAmZ?=
 =?us-ascii?Q?JsEmEhMT/xRHPEoZOMEGTGqajA0UXm+1ufAB0NXn6ghvM5OchkzqgyjJ8jML?=
 =?us-ascii?Q?kqbX0MAKFWXpzcDINmQAaX2GrN1zkvoPOohY4olR/2cZaZzeEgkQ0zniDnXG?=
 =?us-ascii?Q?OOtzb0KfFg3v3WY4cnxA8a7twYazIyXO8fL+IHazspiczHYRdnT6qF08akj5?=
 =?us-ascii?Q?RYGo7mEUJKSikaVGAZNkm7HpFNc/qQeGGqAXoG2UU3Fps32f6kcqpTfN+WFd?=
 =?us-ascii?Q?Lgti6nMsEtVb/OYNgTkHf0aeJTJSqQo8hsdc5PgVMR+Rzid1Hd4ufZlDu064?=
 =?us-ascii?Q?q0xsdSkOov2SJCyynHGblgfF4nwnlX+aZuw+sHsZDb3P9x0WhAU3IsoOgqks?=
 =?us-ascii?Q?gQBYB1VbGjXOfJgL8HjUWGqgSq5YRp7b3q55ugN4ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uALeV7tQAicu/edEjz4ULw0pLe91gWSm53G1Y5+vwPexNKnVHW2exqCXlx4S?=
 =?us-ascii?Q?61eN/i7m9+3LqpEO6yJ7qx68V8E3oOsR1Odnw4xWOt7t2xo61OjKBeq8Nvwf?=
 =?us-ascii?Q?dQ42Xdep3esR3tCSvT+aYXpnqkle+gDN8M84qyOZEy/A3zzlE20iLMCU8qxc?=
 =?us-ascii?Q?nF3+qRH92330NAUQgbUL+vgq/cCzEzZFWL0pOY01a12PGfdwcdQf8E6YPJo5?=
 =?us-ascii?Q?lhuZerUNFSGjbXgtVDn/cSHltcEK5NOg6dUmApqOPYJDiB9tsunGTPsW/K80?=
 =?us-ascii?Q?XFMY4TWR69grHeMrKE/5SlDGaprTUSTh3q413cL52yQBj18Zv+FI+s4igLYs?=
 =?us-ascii?Q?ELSJB6lXEbKhZNxNnt9Df3Yj/sr6NY0WZ5R+qhSJE/RdVIEm4V13DOLEUN0z?=
 =?us-ascii?Q?o0ypgOA9u8yFnvO8Bu9nwJReG9lF0o3s5XBkpZg4qg5MT0fnQMLiHVsbONfu?=
 =?us-ascii?Q?bcYo9IxkxlOw2uTsfApf0MAO3/l2vxSWyiLJMxCOEdtST3w86Re+RzYvaxm6?=
 =?us-ascii?Q?HlBcTneMWqMyMuGjqnggyLjKpx7vApm3dchFN0/EZZyc6+phGNtxMWxbdfac?=
 =?us-ascii?Q?+7EWRYFL90dzG127CRcurGeZfUcLXfsyDvzOf+CEAEHtXh5XWrG5S0LlMLj6?=
 =?us-ascii?Q?INeUhb3YPEcR8rfvC0Jrg73D5D32joKuA1kNzajqV7UfLvzFAV+q34YiTkCd?=
 =?us-ascii?Q?ss9WRijvIKFbJT0FgyrjJXfcV4ya/PP7oMLNxjTaKCvfyMhicOpi3+ywm1PG?=
 =?us-ascii?Q?YK6Qfki5LqZSyY/YpFIJjmtVaWumQCI4hqX5O+xTGDqPETX1Iq6Cf6qN9hKP?=
 =?us-ascii?Q?IaBsd4YYZSaaQNH+0/JLtn5/4UwOFOIERzMOZfLkaBuDTwh2MWplyRdVqLCS?=
 =?us-ascii?Q?0ccfcAslE9nl7r3TtmBchS2iY1P8SMaWhFWXt7ZOFVej2N5JciytQlzfNCdg?=
 =?us-ascii?Q?vWpJwjgxJvyC4fzkS/W0vCutxU4cCjUsrJz1cmOfiUYsC/k8Gd1IE0Xwz5Pm?=
 =?us-ascii?Q?4ZRVUk3MfNzcw8FIduP/jC3Kon2X5iX27dTDVNfsscuWe2MQuVwQyvud0pa3?=
 =?us-ascii?Q?RgrYOt29ofnYmUAWp+WqPHGaHgcMML3FEwZEhRY2IL5VmiVj1njuWBrHCoBG?=
 =?us-ascii?Q?gHGnomiXE/uSVc3Nbb+YSS36L/Gii1kWqVqFEaKss8XFKtHYdM49ba6Hzt/t?=
 =?us-ascii?Q?vVIL2+5Di/E+47MKmrP7EBHflpHv1OfpERnE5zEe0cIUn4DlQtdgRQFgk34I?=
 =?us-ascii?Q?LZ/v3xC6nKmuVWWQDIIUBAN5Rtrk+wo7nLQHv8wXZPuIXEvT+QT2Jpd74+eP?=
 =?us-ascii?Q?UHHaAm4YwEd3ubGDK2NaQGT6ICYt9nks58nUANxl0Ln/5/eZOu+CdFCgGLca?=
 =?us-ascii?Q?SyN++ZWWSNxtAfbgEMQscvqvTOtni8migI1pqhW2MeprwvH81pDFCfRFwF7t?=
 =?us-ascii?Q?exjxJiYvlLKv1Qh4/t2by1NTHHmfKBOSWcBPDbeQk8CTpJtqgOAf4DpgFGz9?=
 =?us-ascii?Q?dNjJEgJniSpaEFdNXX0dSMIHN55lUl890f00Fe5AgchnZqDh4woGkRx73EE0?=
 =?us-ascii?Q?hhPBo0SdHoaBzlDwUIu+1nk/VmpBp1qsLZUMB440EDpDLHX13x57Q5LCfXVg?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fa8fa4-2e71-4a87-bf54-08dc68a45892
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:30:25.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NgYyUSUEz4rP99v7NJRznEEr5MIJ1o0VFjiuwIU/BK2bF3hg+c3JVTLzGEFKsdq2V54wAPUteNIr1KUnAK7wQJkGyw6TvlcfREZJMg1Kxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:12PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>We're about to reference it in comp_types with next commit.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi


>---
> libkmod/libkmod-file.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index c4893fd..db775a6 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -358,18 +358,6 @@ static int load_zlib(struct kmod_file *file)
>
> static const char magic_zlib[] = {0x1f, 0x8b};
>
>-static const struct comp_type {
>-	size_t magic_size;
>-	enum kmod_file_compression_type compression;
>-	const char *magic_bytes;
>-	int (*load)(struct kmod_file *file);
>-} comp_types[] = {
>-	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
>-	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
>-	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
>-	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
>-};
>-
> static int load_reg(struct kmod_file *file)
> {
> 	struct stat st;
>@@ -388,6 +376,18 @@ static int load_reg(struct kmod_file *file)
> 	return 0;
> }
>
>+static const struct comp_type {
>+	size_t magic_size;
>+	enum kmod_file_compression_type compression;
>+	const char *magic_bytes;
>+	int (*load)(struct kmod_file *file);
>+} comp_types[] = {
>+	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
>+	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
>+	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
>+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
>+};
>+
> struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
> {
> 	int err;
>
>-- 
>2.43.0
>
