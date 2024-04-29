Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75D77F10
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432489; cv=fail; b=ZbDl86IALeKb1n/RRoooVhEUdefrTFSpS+TqslCL0b6ScRLmVFWm8SBKYcIj0DW1VgWUqoh57666UvnnoNcqjqowl8l9YPbLYGcD21QbhswRGjGHZTbb8A5IydctNZxsSukoXSZ7loT5/spn11RqXRTpGSduuBK92FqIxFqzZX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432489; c=relaxed/simple;
	bh=bBpR0DK+eUcCzifrt88Qgwv5Wp/5xwMR7+cAqS4b/D0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8lHorzqk5YMB/smM9hCwSFpms0Z6rN1S0W+kih2R5wbVte+FUI5yIvZx4TrNWQACLpHExgVq9X2+pKCJzpcHGyxx7KkIj+nuU9FpHSIDpVhuroKJx+UUuTcPDysZwrZs2o/sLlSfwYQqwPbmYL6UlnK+e9ddRkaS/g9d+FYbkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6iKAqnO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6iKAqnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432489; x=1745968489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bBpR0DK+eUcCzifrt88Qgwv5Wp/5xwMR7+cAqS4b/D0=;
  b=J6iKAqnO4X2sHVfUXfRfNcV3t01EgNQ0Qc90+dbhfeBWZU7t9zCHRbAa
   X6UGTEJA0qngVjmeEYHPDC4LoD28s5UeTHWkg98GQZeQ+2yD2jxLauKXf
   rFBeeBNZVw04x9cbF/81E+6BT5GZIeL3tqqD9RhI0vTh1LmFykBZZ4Kx7
   mAGXZQnlBs97zyKde2TZBIm3s2LTbUKoGV6UtFtBTQkZed0J3mf6ms6MK
   pZOgXoEsXkdmEvqb4A1D7y8U3J33rH+t40dbnAT2R8xcR9vXKLdITAmsE
   y4ze+3e+YbwOvmX1J3gkzYG+EzCC5NNVBWqxcFHm2qvohNVqmxEYGE5/U
   Q==;
X-CSE-ConnectionGUID: u9IDdujcQY2smUUqfzBHgQ==
X-CSE-MsgGUID: iMG2ewFeT0u6FW+yt2Pzgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20668511"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20668511"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:14:46 -0700
X-CSE-ConnectionGUID: SwQ40T6qQmSCFuqWDPlnCw==
X-CSE-MsgGUID: puG7NgVaQwmMVYBdM+EOPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57461389"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:14:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:14:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmRPXG7EGWa8Ay6GhLXNyThn5ZV32zJsziwmzP8zHAEDfn90I8Omk8Iun9nB3xqlBBLw2hVR7fx+ravcTarTpU3TbJuN+ovsZ2DAOSB9Vi0/NwvvaK3+Qpj2Fa+2aqm0T8wVm6xfjO+E2qp9t1B+jmTipkOjjiPoeHXGY8KwMPVEJ1D/5o/6/4BHyKmF/m6HntOfXicaOVWcfT7lA3qJjAOig1qAwG+Snvi+VdIjSLDpqqKa1/nGVPvEMpXJXDH6fTHqDK0gCpIGDCA+6fgeKpIb/S61U8p8lFCMTkwKfmOvRr4OY/i0DhGnYC2IihQ9fciw4DaKa7KqecYCfiT/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+WgqO/sWoIfIa5UXyT9Wehd09tsew6LqvJtsGcaDAk=;
 b=U4BEZOYMHCYt11t4tTSUtAlr+uLOAs3SV2+xuwfqH1x9d37c1OYkZr8YDf+f12ji8SVQJN/Zij3t2AtMnER5mR5wk7IeDMgl2a6MOWvUKrCjfWoLTTvZomWioiWWwzbA6EbfeYKJUGMPR5m3Qj6Ktf/mJikDn0XLtNOLMiJjWX4I3WSfiwI2B/Ehh94NDNUCtdHoEww5zMsgTmz3xz3RPC19QSm2HWxd5/C+X9NJmOf2Q7Dm2Nd05RV6obNX4xOWqjs763cfWqHns9Q0L4ZnfYQAw30uOe/x5QAlcynzMs27jiNb2i8EqaSj+Feo+1WYl0rsOrNnx2R6l8sqI379Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:14:43 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:14:43 +0000
Date: Mon, 29 Apr 2024 18:14:39 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 06/13] libkmod: propagate {zstd,xz,zlib}_load errors
Message-ID: <qhghzwotzcjmzlxfgbpyfgq7tk2mw3bfe3bzgfauk4n4gjyyg5@3s5oiwhcqym5>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-6-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-6-06f92ad07985@gmail.com>
X-ClientProxiedBy: QR0P297CA0018.MEXP297.PROD.OUTLOOK.COM
 (2603:10b6:3d0:16::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9816e120-a13f-4bd5-a259-08dc68a2272d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F6IeZBEc1FW00PtP1yo5YFQbvbAtqjFRMyvIKu/0DbthH9miJ0sImhl6uFRr?=
 =?us-ascii?Q?BTDS7LSWmAW9gnfxD9HuPM82E5BrZxV+XRRQEVsDAMWlgXVCa5Y/tMtY9+X4?=
 =?us-ascii?Q?sqnFIKuhRF3MMQ4YAFrobQzLeDn0A5XhyHcG1xy5sk+8p2aCT8MH2ADL+Pk2?=
 =?us-ascii?Q?AN84JSDmWkCMD0cxM7gChMzCxVquK18LebvkMCJ2JRGt7SzpYoTQh0x7aMpv?=
 =?us-ascii?Q?+2So0RCOqO4dpqKhkQjqa8bAddSG/2dW+UecLs/c0mssFPTYmsn9pBvr52AG?=
 =?us-ascii?Q?4+DwJ4fkqBIYdesyhhI2ip1VbREutqSE1iVwgSD5SNLetUKyL0wH1O1qw2Ta?=
 =?us-ascii?Q?t/5J6slklY0PtlSlhBvilZbdr+Pwe/WlzERE0bKgjlpn+SgpyW77bVanclRj?=
 =?us-ascii?Q?TvLp0LEjQozd4/P/1UJEKW4MnM5d04O8QZJmpQ1c0dZfd48vvp/yG7Rg3GVB?=
 =?us-ascii?Q?CGSvHj+smS8BGbRFrmzUDXicuJ92h8+zsVam624uig14wItCJaawQLB2ceNL?=
 =?us-ascii?Q?7B3Zz3bqcnrDnIJEDsgVzRAOZo/AA855ktf2xAJJRt79BRzLRMzCScOku57x?=
 =?us-ascii?Q?tDHbSrhfUDkPaIOAn6I/n8vtWe6Db+6YodvyIqoZkK2CGVkmxW1HFxc+Rf4R?=
 =?us-ascii?Q?ctMd5SGGdNosZOtOgIHVyJ+OgQhaypk46vSyn7Llx/Fu+We2JmOVO+LPr6ot?=
 =?us-ascii?Q?oFXgaz/nwq4stjaMDg1K2OgbbHWsMvQiBdw9Ii1NCvhS+EeFeyGGJuEh2Nv5?=
 =?us-ascii?Q?ZriC9Imw3yKIOyi1eg1RmTQ6179hysBbOCXOjSCgR4vfS2D948gUZY3gL+Z1?=
 =?us-ascii?Q?hQxiWiMBW+ZaQDBLXB1DroyrHNFD8HhmLadkuqmtudXpZ14JKzwi4y31yR5f?=
 =?us-ascii?Q?ztoMCb2DWlw78xhcLZP00FMfGAoExgGJPmFGcQa4FdRSsZIvfgIJBokD9Ozq?=
 =?us-ascii?Q?VymZ0PUBcBOP8PVCjM8HiUEOsN6MwGazesfmWHLfoGKhshKBCWAB19ka11vB?=
 =?us-ascii?Q?U4nDtD1XzWfDlr/zpCBmnd1xUOmnnmDZHlTaZfIXvkkFVDtTKlZf9yIkb+ik?=
 =?us-ascii?Q?Z1SW2LkoSmoBuxBv9elsbcJD3Ibwdpfg3ox4vGPEubkK2ka8jyi8yFB6n+gL?=
 =?us-ascii?Q?ypMFbHID5OQ85Cf0ky1o06yYXAuLGlH3S3xednf31+hvMxkiYbVcnB7sF/HS?=
 =?us-ascii?Q?5GFshwOu/mjUMW1mj2wreJpPZbh7szXVpNFNa8Ejw/vOyhu6+0m7kdo/feFc?=
 =?us-ascii?Q?VOj+ou2dGn7uN0cQAHzsJILMpLegoCahOJVAED77rg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlVmY/nTW+ErOrk8Jxcmu2fBUGGmFfKdrr2dIpokWLqarlREJwFNXRj7EiwF?=
 =?us-ascii?Q?MzqDfapuhRdv+RjDZlM40a68UACKS5VtJLQc8pH/2o74syMhe3xAy1IRiPhn?=
 =?us-ascii?Q?gG7wqIAhK7KF4JPWV/tfavEXcjpgPXX1jQPXl1C2k5XbAtX89OMQialiqX3o?=
 =?us-ascii?Q?yaaa2LpWXqDwTwhpgTlLJYZDjeWnv6P3Bt1cp3kdlSTGzfpXFRB0HPVzTFvk?=
 =?us-ascii?Q?cTNx9kDi1IlAtPr0QZBqOQvPJzq++dDWGKWdyvd9GRb6ceYer+aehVI9wjfc?=
 =?us-ascii?Q?h4AvpKefHlv0AE01BXgUiLIUt38DzvO0oOhVxUz1llL/NTZDNliA6qCVeuRu?=
 =?us-ascii?Q?C4JlvHeg7kmi4/MMt1v5qNob7MHN/gtXcFgCjzuDSpDEt4wpORcxiqSwA/vp?=
 =?us-ascii?Q?aUqxagLGULLogBR5Ex5UiRBWtQV6J7txzmNy+nMS0eCpqaO5GcmR81Hl8it+?=
 =?us-ascii?Q?r8m/yXsazKFPcK/AL0S0dL8RKEaXBAw7IYyEPkF0/HPyBa7IMfPJlu6H6VjM?=
 =?us-ascii?Q?QzMzWYJT+vmrWIHZGVlmymZnGxrynczCQZiCuj0qkAeONDw4OS9ts9JWIfGZ?=
 =?us-ascii?Q?S3c3+PNDuGnxYaNPjVKs5prEGEHeUzGhokzFhbfVrZwyOBhcueGCE2BBK8Sx?=
 =?us-ascii?Q?kalLNCbcnVVUXkEey+fScBLLiMTeXdIn6IV9YIlr8FVY4AuMJ1jS1ElABs47?=
 =?us-ascii?Q?BtVO/R9N3dLPX1yz+8WGI643X8eph4lSP3XZAIaI78mTP1HX/4Dfw3hjZCg1?=
 =?us-ascii?Q?5grLQcdrUojdsLjfxAiIjyUhuxAyUme8L8ORVl3bw34i9moyy1OVlYXhgLRw?=
 =?us-ascii?Q?D+fVm4sJlupoeE/K3QLRyY4tNxsAFF0PLFl0ETQHNQCaiv3cxCAANraXohb+?=
 =?us-ascii?Q?pGBBIeXWeHkSJiPeSNjMOl0SB0aFkgh3kSpURX5ptMnkA9OQKKreXsKOLgY5?=
 =?us-ascii?Q?EO4rqBY87StcFJx0Xy7j3bCB5QxsuJf6TTP22m0uHE9LcB+d0YBa/p5DGb1C?=
 =?us-ascii?Q?DOSqgF2QXufA01R93mgBe2x7LcsIvtAAVmoBU6Z9e+i8q67paZWiqGVhCFuz?=
 =?us-ascii?Q?t7PNIREfWDYJEcp5Py9dhSjFz+dDaXn87LVmrx4o4XO5KETc9Bh53mz6RN9R?=
 =?us-ascii?Q?228xu1rNmS6MjZmyue5QcREAN8niuTgrMKPrOAbg/Vsut+OUdjuOJgmIdr1y?=
 =?us-ascii?Q?SOVRpSsWK/awLYvinhI0Q/RWuxIhiC/Bc5CEdZo7g8oW+7HhUmLXHK0wB+lS?=
 =?us-ascii?Q?rYYgIrR6U0tvLRDPCZShjYnWOJybW2bD46YxslgWFYE+UQ3zVoTj20r+6yQ3?=
 =?us-ascii?Q?gpxwNgjtn1t7tfHoYCGApeVrntDAWxd65ZtJ5tE5oh0kJ7LbTs/d7XTf7xSg?=
 =?us-ascii?Q?ZP5VwNrtwD2ciYkChgPF0lPDpspLPa59Am0rvBwXf78s3BuxwtEPE72YcaCi?=
 =?us-ascii?Q?MAJ/mMnQsRJVKfmiiyi73w4jXtZkizkVl39BfmXGlmwXNhE/OsH8/pFGDShl?=
 =?us-ascii?Q?y2GgPxh2EQ13a8HhcW3vOUYK0Njc9qnBD+u/N4O4p1y8QGJJeDgdZYCLxMau?=
 =?us-ascii?Q?wwjPfTio1iZEQq4oCDaus0EOAp9Cpt4jxArEDB4CfxGWXZeaRbdK7YE+Kcik?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9816e120-a13f-4bd5-a259-08dc68a2272d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:14:43.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiPUre7uh4nEWHmI3Pl9U+rffBsUoLaFojbaUuQW1OD3XNVGEYYSRxY0kPFbCbkQTt2+j9AVLFXZi9k3UMJSripbVb2IVkgtcW3Y9dT1Xd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:07PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Propagate any errors during decompression further up the call stack.
>Without this we could easily pass NULL as mem to init_module(2).
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-file.c     | 15 +++++++++++----
> libkmod/libkmod-internal.h |  2 +-
> libkmod/libkmod-module.c   |  4 +++-
> 3 files changed, 15 insertions(+), 6 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index 8a0336f..3a79464 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -381,10 +381,17 @@ static int load_reg(struct kmod_file *file)
>
> struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
> {
>+	int err;
>+
> 	if (file->elf)
> 		return file->elf;
>
>-	kmod_file_load_contents(file);
>+	err = kmod_file_load_contents(file);
>+	if (err) {
>+		errno = err;
>+		return NULL;
>+	}
>+
> 	file->elf = kmod_elf_new(file->memory, file->size);
> 	return file->elf;
> }
>@@ -460,13 +467,13 @@ error:
> /*
>  *  Callers should just check file->memory got updated
>  */
>-void kmod_file_load_contents(struct kmod_file *file)
>+int kmod_file_load_contents(struct kmod_file *file)
> {
> 	if (file->memory)
>-		return;
>+		return 0;
>
> 	/*  The load functions already log possible errors. */
>-	file->load(file);
>+	return file->load(file);
> }
>
> void *kmod_file_get_contents(const struct kmod_file *file)
>diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
>index 26a7e28..3bc6e11 100644
>--- a/libkmod/libkmod-internal.h
>+++ b/libkmod/libkmod-internal.h
>@@ -160,7 +160,7 @@ bool kmod_module_is_builtin(struct kmod_module *mod) __attribute__((nonnull(1)))
> /* libkmod-file.c */
> struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filename) _must_check_ __attribute__((nonnull(1,2)));
> struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
>-void kmod_file_load_contents(struct kmod_file *file) __attribute__((nonnull(1)));
>+int kmod_file_load_contents(struct kmod_file *file) __attribute__((nonnull(1)));
> void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
> off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
> enum kmod_file_compression_type kmod_file_get_compression(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index 585da41..1e43482 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -903,7 +903,9 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
> 	off_t size;
> 	int err;
>
>-	kmod_file_load_contents(mod->file);
>+	err = kmod_file_load_contents(mod->file);
>+	if (err)
>+		return err;
>
> 	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
> 		elf = kmod_file_get_elf(mod->file);
>
>-- 
>2.43.0
>
