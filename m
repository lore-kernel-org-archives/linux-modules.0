Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372082D90
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432449; cv=fail; b=fnl8+axSLrqjqp2nYoKLiPK7usM3PGdUeC+mdHwo8FJpis15LwDyveToMI0D1wk7zeItP1akI5ap/WXSCUCYqKA88pPPx3ZdEqyYTUcp5Vl4+bVVeMv0tspFv5eURNXEWiRtedBtwwGcqq8uSgnc4AG2CTusbwyNoYNdg3HFYpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432449; c=relaxed/simple;
	bh=LiaiymcliRCsF6BxImGg6jPxVB0ZcNaCnYi2vI6DY3c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YuK7T2NTZjWU5DnBUg2yTiBCfXMbxnJeCgzZJi1g4k0j5wudJAbCQHHLSw6/Y9MH/pNa6eRSLfI2vVqgOzBwxazoS0QD0bSZC3wbR0FIgVuBJJ6XLnA2I23/kGTie4tYemnUIr0IQMJmA04kRrMDQiOqY1uH56qnqhg10E+A+uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4tTP9Nc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4tTP9Nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432448; x=1745968448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LiaiymcliRCsF6BxImGg6jPxVB0ZcNaCnYi2vI6DY3c=;
  b=W4tTP9NcZVm7fnLsLmdOfMHAiTygR4GQorWUaaHQjfdVZGOKkr8w9qks
   xZl5jrCskR5gbtv9GO6yOYi2KM7uHitsB1DSuWA12Zf1K63nLCFkS4cLf
   gsM0h9eozNXGCd+kJ6Ro4hM5vXlKSnm2PY372iybPZnZtMw8HqJq+S+I9
   REmkReJyBWehEyAE2YbixsFt2ZQSp2gr2IF470w1Y7qnevYgi8t+sC5N+
   O04dma2og343bBDXUvnCvPRJYxAqWgCs0K026Cttgju2uQso66jKCWJgh
   xIpbCT4pdO6aOi0IATOTVCZBKyHxAtODO3Ky/YH7UxSv/dXc2MsxwgWYa
   g==;
X-CSE-ConnectionGUID: rk6ka7MPTVqLgknb80RHZw==
X-CSE-MsgGUID: TtuPm8PJRSqCAzT+flh3gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20668394"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20668394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:13:51 -0700
X-CSE-ConnectionGUID: 7ZYbd4FcTvOmk5oefUZDYg==
X-CSE-MsgGUID: ppzgfYgLS8qBUkalqneLTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57461305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:13:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:13:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2jsaGXR3tPL8AqJgB7Su1bySt9RxRdGrzuLL44S8R0uO7jPk6qF4oAxMcxsJflNO/5Z7HnZj0kO47Vdvsotd8epx8DkUwSCZog5WLksnvguv68a1uNh1UtqwLCisGQIMlHEPNyVLeHEBSBO+CaCnSgzB2NKLX48hnegGewLgOjHXXPgUlyBwxFmOGRVn5oDStc2kCN5YdexTwbESME1oLjXya6i/vIwQuAcYjdJrnz33vx3vNaAZwgzoPI8KyGEzEky0AQ7KPNmzZBC+PELbbc0/30AeUaVrEWMDcc0oMLzJnttCV7NqIfTA67kRAGB0coEuMjinimUPKxnKcjx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ifSe1g1QcIVU+F4w31ug2ZRo/Fs/ye/jK6oRqsBL8s=;
 b=GuR/tgTyY2qC8bDm+o8/+sPan6UrfboZQGhqSEQNSwAVvdquHKHOlDmnNAj2u8HXEf4e532rHKlnPCrvspvwGCMAJSTRMTq5pDwfKk7eSev/1LvoP9ypiEB1/DfEVquV0AgqsfU1xxI4FfwJCE4jGK4gmtuudNbIpwq7cmcxnu1fbWgb4mQIYGa1TYIfLqguhjdPEYSDpYD0jp3um3Tuh+dShQVuYorG2HLwX8UK4GLSYVpjbrQU8/+hY4EnrKITwYOw166HWRktMvenlAraEBdBjMEihGhEKAo6Ttg9za22+dTF4uWNts7vFxgdXMkaItfJDxefXevbDarqZr2uHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:13:48 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:13:48 +0000
Date: Mon, 29 Apr 2024 18:13:43 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 05/13] libkmod: nuke struct file_ops
Message-ID: <u5ec6iz5xhqwzhbnq2dlbwj6xkqbbgpe5vlptkaa6lag5m5p6q@pfwzvhhd3hcd>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-5-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-5-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d8531f-0f99-479e-b00d-08dc68a2063c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XisiJRcdedqsI4v480m2110u2xSjw2btYm/VLqTpstUZTqXp0vwJvbhcEjm3?=
 =?us-ascii?Q?ozb3b58qTuCWispK6ZzZam9QWahf4E2pMsl7AoOVZuTWRLSK+EZwn1/EB80/?=
 =?us-ascii?Q?i+9xKtsDo6yt6+kbP8lGqELR0eNZ5FeCPp5XdkG5j555KF54fpQcO+MdVjac?=
 =?us-ascii?Q?vyqFgTcdwOnN2juO4T/lpsiOghIXpHs/mYAPJSyd9MglyacgaI8XHoWcOSuj?=
 =?us-ascii?Q?UGHvqijKj1f1H6GmZQEMxOR8xlWOYRh6hMZyS2aCMcQRxzCFc6d2tK+woTEV?=
 =?us-ascii?Q?gPT9s16RcipgA0WnNKhSLeKlxr0DmIjS4es2PtKFTAFkxebo8WC6qCMSFv4R?=
 =?us-ascii?Q?8uMgQyjnk4/c734njRihcpa4GQaXFe1CMNtE8oYeD3lTNFSpWYflcsnYoiBU?=
 =?us-ascii?Q?Czk/LW9Nr5YNItE6SapDgrWhlwsuzYUQh7wbx/mi72XLiKIKoCYH7M2+oNhm?=
 =?us-ascii?Q?/w0XAK9QBp8jjgfmhUMRFx+HfW+16q0+wK/t73B2n4XaXilhFLa6yBBwWOtu?=
 =?us-ascii?Q?qvAw7pBKT0lygDLdsWRjexEQd7hbWVv3nz+cJXgzc8LAXasb+eeGdQFp8oMR?=
 =?us-ascii?Q?4Le5k2U0w4dISD2x790IyqvGY86/IFjiv5OhW0a9FqwYCBYGbLNGCFBbqQ9U?=
 =?us-ascii?Q?Ijh2wShlRh06/fLGyhgFzdf3uozBFivUKthxsrHPu63OYuqtZtDA9K2n27Ws?=
 =?us-ascii?Q?lud9+AfVCUN3zqPkETKRMEawZFBnEIOt9XAq32V6pmHn90Z7+JgTglHVgbwS?=
 =?us-ascii?Q?JPI40ZO43nS1k5Ig+BJo2WeVeOep26qO69Qb5oZu7/uFwwTCfYDNOOgeG0Fh?=
 =?us-ascii?Q?h78Q6QqqlRFKpiTaxv2XybtixiHKmt8nz6n3o2+Of2G+yVRSt2HBZmmAAu0E?=
 =?us-ascii?Q?0LfGC/5EQszRZ0qwWZ7h0Im9Fu1RtT7kfVVWD0XDJJF1RRA8HTwmbAL1QzQ8?=
 =?us-ascii?Q?fcwL1/kc0R26iW8wEhMPPwiou9L2cseUbslQEIDSEY4v/IzkFsUgSnqNB9yV?=
 =?us-ascii?Q?VlSpRZV0wolXGYAp94Nt1ADFl/pM7IDPx0jlM8NBIj0Z2/CqnaCHdsmlBW0l?=
 =?us-ascii?Q?TUSvtk7DlnerdVUs6uua791AsfcdG34Dgg+Ee18vEZnZHeuequvigzyyKt4u?=
 =?us-ascii?Q?c9qNzM8JmLH4joM66w/+w83iXafOkjvGO+SZlmkEOSVarYnYK54nyVX9Dj1W?=
 =?us-ascii?Q?d2TzbvhKctT4fH8pOk7fgSagJL6v9nJv18K1fp4MvMIA9N1KDzKkC49wAGH6?=
 =?us-ascii?Q?JmT+gjLeQ78bXEx92TyQH3jUePzf+ZYLIayZK/DyYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?deNd1JnRtpcsa0cKmMAfa/+maAwz1P3lDdwMZDtCauHfItZbieXWR8pa6IeL?=
 =?us-ascii?Q?2o3Iv/lyZTfEsRZ831I9snV53QhxeCadEcQxjwm1L2Ffank16Ls3vZg83r8p?=
 =?us-ascii?Q?T2wcxDg7MI/4uXDUMFAXyRZJ1IWj9DJeopxvvbXtAZccB2Vjl6D3p4a5FNVq?=
 =?us-ascii?Q?c9CRW6rh2wdUBbIP6EMzo5HCqhwOkNByaxbFHikMJyGS297uypIQy0DQvkNW?=
 =?us-ascii?Q?vLI6tJLky2QuM9KJR9iegXzVdRtPm0d7vbO0AdxMOMFCY54LMQQdGhcZeNrZ?=
 =?us-ascii?Q?x0xwA2Pm4AZJ0OvwJ+aKBn2BifvXFK83+GuP0d3eJhiVKNtfW2rFXLIruKc4?=
 =?us-ascii?Q?nXyftVF66SLD8xQ3xTHLe26wqClEmyIihGj9ZU5yXvNKwgzJre/bpDgKFSuF?=
 =?us-ascii?Q?wPiPZjXW/T0E+vKbCMPXlf2ywCQRNSMEqIDwlxCSXY6mzH2/CxyIIpQJIoHw?=
 =?us-ascii?Q?9M/ZpJX8yO+//T6Z08us3WsUpj7Yv7fWtC7hYIWzEKrJm+AynR0CXLH5qIjY?=
 =?us-ascii?Q?YO0zcGeedTy5inEevGfxuiclwrX65lng4mFHddpnicaKstfRyq4y59i8euSd?=
 =?us-ascii?Q?VOLyarrlCQWLyliHvs79y9IP1jfNFTxsJ3B9Pj++lwcmAMghKKzw2fq0eWES?=
 =?us-ascii?Q?KHav8ia/LyJ9fjKDuAb2dEZmJCPwpW1GYJmzsO1JBgHoWXxN2DyyFTX/hXG9?=
 =?us-ascii?Q?MR1wsZnbR79DHM94dQaiARNQgCn44Idy64g2ebHHbC3FzXt+kf0RSW5UwJJH?=
 =?us-ascii?Q?zMjvQ3bUIX/1rt9Q6NitCoSZ9fwy6VRmgDMgY5VfVUfgMoho6DP8oI+1Ou8d?=
 =?us-ascii?Q?9DTkh/9Td3ouGbmFEdqhQhtXSAbC/ePVbLtm8CugfOrBXRoEZYb2UjKooqug?=
 =?us-ascii?Q?VFmDhO1yKxAbyQqyw8LSSj8cmXj01XSCy9hi6G6DH5U4PvGvIxFRZfCEkOOA?=
 =?us-ascii?Q?lVXrYtuZ3izFMv/9+f0bYWPWePPpNmfMdpmdhDIV6zJdDWoyzdxGCj1NbqKu?=
 =?us-ascii?Q?txfXaJ3zNYZ6KnzEPCR7EOXTT8IJnTymsyG0rciCw3pQ6brHV9aLNeCiNVAo?=
 =?us-ascii?Q?HaYbYNOCv2xr3bKxWWKApGlKsoMfl85MZ+Kjs7JRBiQtG5fHOQTkiHHHa8Pq?=
 =?us-ascii?Q?eQGeiEbaq+8BBQJFf3zEhk4IeYu962QNNzwlWG7CtvxcI5TbGxWZQiXUUh98?=
 =?us-ascii?Q?Acwo23V1+Ht88IoALn4UuySif53+3W6CaBuvqUjz5fZcyyS71RobXw2nw48G?=
 =?us-ascii?Q?Ca88qDxZkhq85qQr1mlToOl51zmil84o22T2oPEiRymfZh2E2+qyJjH12xWe?=
 =?us-ascii?Q?wnTCAblgLZx24LPZtWN+1rvOlX5z8sJuktCJtLsjDUF1Ao8zBRUM5Q9vf1Sl?=
 =?us-ascii?Q?8SGIPaR0dSFtVY6ewHQEbeMwfvC3CIPHjAG5hGiMdbQtf2ejo8qgrAmN/4SL?=
 =?us-ascii?Q?KNyo/zDV65fajbdq8fA1ZV2wcwPQimibJ5tra7Q6DpQyLd92IcuI4kBspl0a?=
 =?us-ascii?Q?C0UcxgohakEAEmcqyPV3+tGfaPHoTLXI86mrNB50QwOxCRgRWMLBYrIa/WFb?=
 =?us-ascii?Q?71MmJU6ocGM5LdFXJgmNG1qXTtSM/LXfxK34ukSJ6bXAR8cDn8Q8dN3vSROH?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d8531f-0f99-479e-b00d-08dc68a2063c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:13:48.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fY5hdf2SovYUy2NX/BWMX5xTFm6SnPAW1FWiknBpc1fV346zWHMIUz7bXzS+QEIWex4GqYZd1kgJ6BxX4oKdYvrmrY5ACcRYKE2iSDIZzgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:06PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>With the previous commits, we removed the need for a distinct unload
>callback.
>
>So nuke the struct all together and only use/keep the load one around.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

> libkmod/libkmod-file.c | 62 +++++++++++++++-----------------------------------
> 1 file changed, 18 insertions(+), 44 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index b408aed..8a0336f 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -41,18 +41,12 @@
> #include "libkmod.h"
> #include "libkmod-internal.h"
>
>-struct kmod_file;
>-struct file_ops {
>-	int (*load)(struct kmod_file *file);
>-	void (*unload)(struct kmod_file *file);
>-};
>-
> struct kmod_file {
> 	int fd;
> 	enum kmod_file_compression_type compression;
> 	off_t size;
> 	void *memory;
>-	const struct file_ops *ops;
>+	int (*load)(struct kmod_file *file);
> 	const struct kmod_ctx *ctx;
> 	struct kmod_elf *elf;
> };
>@@ -181,11 +175,6 @@ out:
> 	return ret;
> }
>
>-static void unload_zstd(struct kmod_file *file)
>-{
>-	free(file->memory);
>-}
>-
> static const char magic_zstd[] = {0x28, 0xB5, 0x2F, 0xFD};
> #endif
>
>@@ -287,11 +276,6 @@ static int load_xz(struct kmod_file *file)
> 	return ret;
> }
>
>-static void unload_xz(struct kmod_file *file)
>-{
>-	free(file->memory);
>-}
>-
> static const char magic_xz[] = {0xfd, '7', 'z', 'X', 'Z', 0};
> #endif
>
>@@ -356,11 +340,6 @@ error:
> 	return err;
> }
>
>-static void unload_zlib(struct kmod_file *file)
>-{
>-	free(file->memory);
>-}
>-
> static const char magic_zlib[] = {0x1f, 0x8b};
> #endif
>
>@@ -368,18 +347,18 @@ static const struct comp_type {
> 	size_t magic_size;
> 	enum kmod_file_compression_type compression;
> 	const char *magic_bytes;
>-	const struct file_ops ops;
>+	int (*load)(struct kmod_file *file);
> } comp_types[] = {
> #ifdef ENABLE_ZSTD
>-	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, {load_zstd, unload_zstd}},
>+	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
> #endif
> #ifdef ENABLE_XZ
>-	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, {load_xz, unload_xz}},
>+	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
> #endif
> #ifdef ENABLE_ZLIB
>-	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, {load_zlib, unload_zlib}},
>+	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
> #endif
>-	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, {NULL, NULL}}
>+	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
> };
>
> static int load_reg(struct kmod_file *file)
>@@ -400,15 +379,6 @@ static int load_reg(struct kmod_file *file)
> 	return 0;
> }
>
>-static void unload_reg(struct kmod_file *file)
>-{
>-	munmap(file->memory, file->size);
>-}
>-
>-static const struct file_ops reg_ops = {
>-	load_reg, unload_reg
>-};
>-
> struct kmod_elf *kmod_file_get_elf(struct kmod_file *file)
> {
> 	if (file->elf)
>@@ -436,7 +406,7 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> 		goto error;
> 	}
>
>-	for (itr = comp_types; itr->ops.load != NULL; itr++) {
>+	for (itr = comp_types; itr->load != NULL; itr++) {
> 		if (magic_size_max < itr->magic_size)
> 			magic_size_max = itr->magic_size;
> 	}
>@@ -459,17 +429,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> 			goto error;
> 		}
>
>-		for (itr = comp_types; itr->ops.load != NULL; itr++) {
>+		for (itr = comp_types; itr->load != NULL; itr++) {
> 			if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
>-				file->ops = &itr->ops;
>+				file->load = itr->load;
> 				file->compression = itr->compression;
> 				break;
> 			}
> 		}
> 	}
>
>-	if (file->ops == NULL) {
>-		file->ops = &reg_ops;
>+	if (file->load == NULL) {
>+		file->load = load_reg;
> 		file->compression = KMOD_FILE_COMPRESSION_NONE;
> 	}
>
>@@ -496,7 +466,7 @@ void kmod_file_load_contents(struct kmod_file *file)
> 		return;
>
> 	/*  The load functions already log possible errors. */
>-	file->ops->load(file);
>+	file->load(file);
> }
>
> void *kmod_file_get_contents(const struct kmod_file *file)
>@@ -524,8 +494,12 @@ void kmod_file_unref(struct kmod_file *file)
> 	if (file->elf)
> 		kmod_elf_unref(file->elf);
>
>-	if (file->memory)
>-		file->ops->unload(file);
>+	if (file->compression == KMOD_FILE_COMPRESSION_NONE) {
>+		if (file->memory)
>+			munmap(file->memory, file->size);
>+	} else {
>+		free(file->memory);
>+	}
>
> 	close(file->fd);
> 	free(file);
>
>-- 
>2.43.0
>
