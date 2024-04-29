Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09177F10
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432479; cv=fail; b=TxKgltnHbjMyfgxSlo6ecJW+c+vcuTyQYcb46r0ZlPJSeXekilAgR8JGONh5Sk2+mV4zdOzc2lksVGMiAN29VXk6symLucMGD35Nww8XIE3aQjIgvbf/m8fWybcF26GZ6bAIgV4cPnJBuPykJYkpYUtxjWjLOdSqaujHjMtRgb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432479; c=relaxed/simple;
	bh=CUGGS0iuriosl/izYMX6iu0HZDr/ec31IJPSZyF7LQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dwpGdSD0dVFgmEmqcEzzCSDdJQaEVQgwZ24CFmbqZTi9D+IQaIBd1panBB+l915BChRDbWV734qJGRO7Ztar99ttL0WaZL6giUaUqQRDyAhepyI37QuEE+//a3A789RFxXZdhOkzKF2lz0TnSzhLEJfYF7g0ZK/b1fNbR6zM7S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUGvo68b; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUGvo68b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432478; x=1745968478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CUGGS0iuriosl/izYMX6iu0HZDr/ec31IJPSZyF7LQs=;
  b=JUGvo68bwSYITZkUlOMF6/6qRxSIUkFce+b2sLfWLyDTuwfDluIACPcg
   q9P8N3QKBiGlYMEmTlK3PiHCBZ2i9hlTI/z4QV2u2b8OwbMC6T+Vwo/Kb
   u2IDx4AXjzvlVISRvPSnZBB17Qo7vZBOQvHME09BGCMTE2B6qpjTlE4HV
   6brFiKhbaOGppRuiQEK+0FvronUSCDMWOI84dl+NPrncnNeQO/fBVs6Ku
   jYAJumqjutAJLAKWqLLDOk+eIsFVcKkDs/8knXt4vq+yyyLKiHcAJt7+3
   1bYcIJnNPOaJPtNhcqvSLTVwXPKLSq83hI+VWgWqQb3sI7/okETwv/fAU
   Q==;
X-CSE-ConnectionGUID: oGk7NSkNTtWKlb3HF2PJKQ==
X-CSE-MsgGUID: 8l/0knRkRA2jPCu6jmrsBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10333442"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10333442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:14:37 -0700
X-CSE-ConnectionGUID: qoJwal+UTLuMsjsQJyLdGg==
X-CSE-MsgGUID: WV/3wftgQd2+YMFKby5KBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26244935"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:14:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:14:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwXKWVG3qBZUAPVcOVss03PmR3cqOa1DnphbTFUNbDASJ1hF4iTVwhz5EzzTIUM2dbTP7WbHyU2AqZe6KzFolhEWlCu5J4QicYL8rpcZ8laawFFPejpTrbjDBbkBr0UeSRIguKGGVrtvwx26H3YfVAWOzfqoUewfRrxgZWG1mu5R6aA0ASG9to1CeHlKCFq/EpZL3lmuIjBERuGoo6Lk7xavOf4A3XFHy71fFFwkPk5vbn1xMKIAS9KlyngTogNM6jZ232Z/RNCA+xXuIRc+GoWuE2jtV0EKbu3j2cvKklbvaOAEZ6m/fcuckaqqD2ppp5TySJPqKESq/ZVA7skXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB9noFBvzihXGNf8W+M9UHVbifgOzJqTMNldz8O4ZuY=;
 b=CJCeYHiGPENONdLp6R6KWAJtWVraKInKF5nUwiTr+KBNYRKx4kRiMmmFnyrWSuiKp+0lJK7soRijPP7yovfhV5FlcfxABHuyVuy9Uy6YMYDuALg6LbW4xlU+KzAof8a75PzCsmWMhYqhZGInD2kDwB0WpBLJvg1U0KAG/x5YRQWlKXeLgm/fpS8uNvsyESqIIs06W4ACBzASqeXjzdBri7NGGlmh8VVoSiL6rz5mGQ7g+P21X6hh2tZv2d90feFD2g4bvjuDgDsTgyftbpCVz68zQcta5+0P4VH/2GYnyPSnjc/nFYfkV/BNk0fECirTPeeplQUyubaQMyq8PBo06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:14:33 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:14:33 +0000
Date: Mon, 29 Apr 2024 18:14:29 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 07/13] libkmod: move kmod_file_load_contents as
 applicable
Message-ID: <yvjfcfe3hs47xslh56eca25ypo4sf6rmfnxwwwp5sw5ahqqd4n@rnv3g6ia3pbl>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-7-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-7-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR04CA0305.namprd04.prod.outlook.com
 (2603:10b6:303:82::10) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 055b71dd-e2ca-4ae6-1dd3-08dc68a2215a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XGOlyg9NcRwJcei47WH406+FXkpTiXr1Gq7V+pzAmAB8KxaF23ctkfGJWEfu?=
 =?us-ascii?Q?CLKm+3OqaNWQD9+pbVsvgb78nW5Zwv6vXmk+0qXWsOVXpHDD2sE1ZizGECj5?=
 =?us-ascii?Q?Ypf2WhjblcFpfTNCgsZ0V+/vD2FAlT4Hc70Bu6Z533rN/GAYMm0cWMyxUpxu?=
 =?us-ascii?Q?63eJqg2ZRe0ZCvz/tQiMhFLxhtiFUQ8EKl6vBN7U06b4zX5Z76wAJoFpX+qX?=
 =?us-ascii?Q?OfXr9Rixy04vKXtxjGqLnFo2veA3NCD+iPi0HyuoqA5wEICt98dn2RSq5xAK?=
 =?us-ascii?Q?MwRTEKbZNFEiRco63A4AunUCitOSjYW7kv4mwHu017PM8XKSiphzECCbAtgF?=
 =?us-ascii?Q?g0GqJ8xsi8HPB0YrW4kw0rhu3NbhAmOu4j3iEdUmKuvrwtI+AUZIHRXK1ekN?=
 =?us-ascii?Q?ghljxL7684MN5wQy1GeLoyrmP0nCMKCYJ4ducdzrjaSyFf0d1uUwiu7O6fdl?=
 =?us-ascii?Q?dQcI3q/ydjDP+Lc4mvgFo9zTakMGnrLg90EZdMngTvor20VyCdEA6k8LZpA9?=
 =?us-ascii?Q?G9w/JeXWT7jUJF3LfiJpYLQ+NKWaX41CYjLXupKRjOAeTIMIaVqc9Q1VYPLT?=
 =?us-ascii?Q?xI6+aMmLWd07UjKIWDo+uHUCcFClp44lTCxDNPdSuUR0EfB10sIeGbEwidoX?=
 =?us-ascii?Q?u3p1O1GW6cdhtimVaURvOXeh1sowt/AiRmnHW9Qy9HXLQ/DvXLhB47iI8rja?=
 =?us-ascii?Q?oSCQouzZCAY3QgBBcstBvqfkAZ2NoH4+btMDzCTUhJ54WfcmR1YzafJ5+KtE?=
 =?us-ascii?Q?VXIJAgGb3qw68/7fMta4sVW2S9LKhjzfUrz4oFko1Y2553vgI9uBRsumtKK0?=
 =?us-ascii?Q?W+9JS++jgZLMOxPUCQI1F6b5KrrdyCVuBEYFj00E8hLHVkN7luFmSApDoT4f?=
 =?us-ascii?Q?GB8aGshd9T9IZ21HGTjOvTLn6TeBXJ+aW8Dz7IpibxJcLdJsRt9ssKHCG1gh?=
 =?us-ascii?Q?HG5+GgwKkw8OBrOTQT9vYg6VTEuDH1TBBFOz9TuqJqAxVUlLQnMS5TCAcL+p?=
 =?us-ascii?Q?j9hYSZtxmLbhcr3YUdri5nl2LWPbFI1htZXLJ4iQITGq65c/Ree9JSiIYbZx?=
 =?us-ascii?Q?HYDy5hKz0OVfxL2nZ+9Cgr+baERsI1T/w5IdTJIlHYHbqn2Tc5DwVlgDDoQr?=
 =?us-ascii?Q?P4Pv8sGSM+CKD0XhEf2NolQNg1OIrLnNcHRBWJ95fQzeR0UPzXEBFnGqma2P?=
 =?us-ascii?Q?xsWy9fKbC+4Z3sUBhFnXJ5WTkYyRCqn9fIdiBRR59GJVc1mlaLwumBRMb1ow?=
 =?us-ascii?Q?SfGe/GS5/lOyldDHAJq+vECSCpmxMmQtbpTHflGnAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETOi1WSA9gRZMq0DrxKvgO7tmVX/+xg8iejAtS+TQDYVhbXeaplijotl3Gfd?=
 =?us-ascii?Q?vcbDNdm2M4Qsz+iRFs8hhtdYtltMvCQvWiVdKebX8+ttuGCDq7oFYwsOGjlY?=
 =?us-ascii?Q?12CpOooOFDvmtmynzCw5uE9OW6CO/HTT8M/ocWfUeYZazVfBZatoOlNMM3NZ?=
 =?us-ascii?Q?R3df8H3KRbz6eXKahBYrZF/8Vr2fDs/o5coSMV8gBh7IBgnm0AvHnQzn3x+u?=
 =?us-ascii?Q?AFKLvUnRMGU0EJaUVJtIkWh//OjAzBdd9d2xKRL4yHRht+pzguWBCmuFENyv?=
 =?us-ascii?Q?ify2937n7yc2mzCggC9k2iTVSe5fRSYhNy5YPn2496iPMQeE6hg6xYpuV8MA?=
 =?us-ascii?Q?BRpxlpgfwtfGX9mr2SzCM6w4mpkzXg50qA9L9R+IueTB6LKsDHeUs9k1+DQi?=
 =?us-ascii?Q?i2xw5Ejiwke1lsQ+QswLA3yHKCuKxhmJ8RejAtV/mH4xQ2T4PCu/HfHrsAVd?=
 =?us-ascii?Q?cjZeEFwo/ZLeOWvopMajqQliJHe6gdtKdB4RvPNyK2zF8dzWT1cjPo6FfU4x?=
 =?us-ascii?Q?VZsV7wEI9z4bC4G/nNuoqaqNR2m9wA7GttkkuE0tNcSPHW5rzfczRUfnwQl/?=
 =?us-ascii?Q?PmnBYU3ffZa6WK097dRkT5wPYjP8LcunRORetaDe62IFfK/ORkmuHh/uonf+?=
 =?us-ascii?Q?CZ1aYYWoOZxCbYWQMT4gg5IPeHERSIZjILuMgixZJ1ckpkFOdlodB1JBcB8f?=
 =?us-ascii?Q?xMXSCqRLscfQnDPk2fcWTMxyAZPzWYbTQbwu1CiePU0Q7pRfV68Tg8NcIU+O?=
 =?us-ascii?Q?0b2ltvVmKvmvfIqXRQQTTy3DzQaS5fb9LhRkMCH9GVwP33RujXdVZ8zfWuUt?=
 =?us-ascii?Q?JZ19mZ8PKchBPBMcj6VNHAG4++8faDeXVy4eCP8as5QOxkhS1DoGfuwlI+5g?=
 =?us-ascii?Q?c3Ql5u7ri1H1rcUStLKcJ/XsuSlRpEf7UmM7SJOdj2ts+MUxz0/B0X2Ba6ou?=
 =?us-ascii?Q?9v7E8hUUYD0Maqw2P5gkGnGtM4zuN8EJD1908gh4BTmB1++I0xk3oVzuKdTz?=
 =?us-ascii?Q?xOhTs13fxkW+t2mm+vpZTMCzgVFDEd7meVqeC5ZRWkLbE4LcYZnh9Vz/j+5v?=
 =?us-ascii?Q?a+FlDRMUqRBZuROaA6VPXkgnmxKUdaCrotsKPXsEZvO3KZqKQjSmPlQ55m4p?=
 =?us-ascii?Q?yO9a2YWDqBqCD6k2P7LUIaXVCWofa8OXM1yS/J8/qNoYx8RGizX9CuuebXZg?=
 =?us-ascii?Q?EilUpulid2vO076Fxas+FdXXxqR4hJ82Zba6gQrDiyPqdEaFtLcfxsVvrLXb?=
 =?us-ascii?Q?i+zikYzibctdN3/pK6ZsNFEWOYyhpU1ByLEb+0pFjtdkuzrR30wdejdUQjLG?=
 =?us-ascii?Q?Hgo8Xd2+0vV1/3yHVVvOknitBN0C2VsW6E+d4PfwV3WbzxTN3rf3TdZNM7N3?=
 =?us-ascii?Q?Enkxk3opm2+Q+71u5tztmOgAdoplX5D4XQFU3Cb5OcTfgM9QdU+fzBWvG9mj?=
 =?us-ascii?Q?e5vepo6xWeWzgmLlGzUJRrooRN9rL50APuhsomxXV390oIoN6mKRANc6K4qA?=
 =?us-ascii?Q?LCV16a++nKiSmWxWYQfpRebYbmyopQEGABPKYsz+n3rnMLYQioFX9qap0bBM?=
 =?us-ascii?Q?lPzPwOcRe7aQqZvqFfmpwuLMLmWx3CsCigTqL86l44as5O2iQybThwMiBS7z?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b71dd-e2ca-4ae6-1dd3-08dc68a2215a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:14:33.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewOlbftCjZkC7RZdeBRY1UDK2SIlzdzNBCsn76iT8VUGjPEXb/GJ6c1VIVMp6Dh1i9GqxUvwMbA/Nxr3im5PiXraXeEuJ6F4a3sb8725C9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:08PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>When dealing with an elf, we don't know or care about loading the file.
>The kmod_elf subsystem/API will deal with the required parts itself.
>
>Which in this case, already calls kmod_file_load_contents() as
>applicable.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-module.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index 1e43482..d309948 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -903,10 +903,6 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
> 	off_t size;
> 	int err;
>
>-	err = kmod_file_load_contents(mod->file);
>-	if (err)
>-		return err;
>-
> 	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
> 		elf = kmod_file_get_elf(mod->file);
> 		if (elf == NULL) {
>@@ -928,6 +924,10 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
>
> 		mem = kmod_elf_get_memory(elf);
> 	} else {
>+		err = kmod_file_load_contents(mod->file);
>+		if (err)
>+			return err;
>+
> 		mem = kmod_file_get_contents(mod->file);
> 	}
> 	size = kmod_file_get_size(mod->file);
>
>-- 
>2.43.0
>
