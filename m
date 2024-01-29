Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C74156972
	for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546411; cv=fail; b=U/1XBQD54oRlhbgi1s4QI3J3Qol16YA92XlOftdwlr92P55B1MtMsGYyBMoTV+jam6K/Tqav+ULrdPYKAc5bL84g6ss5CN4CmOBZnfCvjjiPSPAeFeMOUIDTeKBzX1cKixY5IVvVL0IHs4TwzhLYcxt+LbG04NWPdyEseX3YslA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546411; c=relaxed/simple;
	bh=JPJT4mG/NPcaGUKavKvMto+vPln1SBv36co2tBKADU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pQ+3+CSRwykRxF7gEJQiNdhl4+HRBB1IWda+6k2jnGiwcm2Dph4+Q8UUyPPQrvxRNMvQ8aF0/Jji3fijxhQ3hmiEqPgV4rrbKjq5QpVyoLvE2CGk+KNeUC9Y6X2noxkjUs0yyPNVy813kdGkB7EAJA9we0D5g5bm3t7vUamQAl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApVVUwvK; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApVVUwvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706546409; x=1738082409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JPJT4mG/NPcaGUKavKvMto+vPln1SBv36co2tBKADU8=;
  b=ApVVUwvKn095VmhB/RLlUtiDdrAB9S5OaFshYL0Z4/06ieDV2IT5Vd8M
   /P5zn87ZKI2RWpbjThlDtOTY/vp8Ilaxenz28cgLvR3cga+WDKDuw42H7
   3jw4pVp3VREvLoDDFrYrsLknBocD5yddrz3em/Qq6G4DI4TTd2s6rDBxU
   D6K5gRMLKBOGnpOs+dZ523k9kZIjVitN/nijxIRrlJmdQXDMEMmubdQrn
   0xm5ceZXwkFaaZ3IOue4YTPYPMBbPGLXQurb6VACvrOnGBT/Ft7yaN66M
   l5/v8do/dk7BJ/YQVBIQT/b4mCf2GXz4bVvvgWGcNexN/Nrr/C6TsEpJ7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434177443"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="434177443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="911119254"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="911119254"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 08:40:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 08:40:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 08:40:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 08:40:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 08:40:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZP2dXNl6JVEwaLFu8gjcqVErObXqIGpvuUdUA3ghDyEAkmp05rO9vj+aDKa1ClKRxAPrTJECYWT4i0q9LEC9mblYRz6Lt+tNgUa8hAh8hDxdxFFYXmsS9d1ZUwFSqUkXslFy6LiBNZGEbSrgeYQL0M0QekX6jZQK9crtV58qJiO5K7FnZPj/8uPWwKJEG0s96VpZxWu6AiDnn4xt3xxdd+YLIsldVjZMbjRoGIQlUh4UiVwKr1jatG5VYxrbxQGLGMBoaZ/n46t0bGztAxlDstpAHhkQ3Teqs6ufSx0jx+oeBa0OqpL9808V9EbCpXtPHOUn48DNZBaa1a/XTEbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPJT4mG/NPcaGUKavKvMto+vPln1SBv36co2tBKADU8=;
 b=cYkd42nxhT8wrn581DzwnJaNREsbfGNW1L3e/a0NQzyI3kT/BD9SsAmql+BHoxtERBUpvQ6VbGrjnZVRXeJNHhWVlCBQBk9J2/xjgtfw585lrYc4ZBcpMqtDo2YOQBT7+CcQEtUA7wbBP50L9/fjnAKLRplJeLHLnnnQEAqn8FpnehPpKDuYci+7HU4k18DzcPK5HZ/Ot9BfsnO8KlJwaI3yv3y5A2G2pdsru0oslVHu0FzWk5NYB45EfefwAdmXoU+vdqs570t04mVoKlucURsoPH+JjqLC5DvjhSlfQFADgPndNr9pHLWuVMbq80VK3M3R5SF3vGcoVvw47n/VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 16:40:04 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:40:04 +0000
Date: Mon, 29 Jan 2024 10:40:02 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Message-ID: <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240126-master-v1-2-6257d039a30a@gmail.com>
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BL1PR11MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4d9833-6803-4341-7234-08dc20e8f1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbJIZabyJd7FxSVYG6uiK6p2iHeJxPcTwM4rc+ijko0kxCJu0JHyBQqc8gyZONHSaycZJ8GLkXX+74dSHkVEIF2UIdRdE9ki7dMnQQI9b6EL0jU1o5mBI6ChPkzEJsUobcmv6j3ZGN9IqwMCtaXvAewqWkgW9+ENWo3YFbjTavyQ3iSxYAIuX13MGLRYoFLMKyTZI84rOrjVM9l2uWkirvCZlPlnguTmWFgXXO5GIM1MqDyLnaXuNtl7yU2KKpFqH/ar0fqZgCSmjXPoI9nx0Bc1ADvf3bjF1eX8hVVOKJCo9/5DLQ47ttbDKC03HSUvW0gMl/Iiv/TKAWbvOOZwgsKE9My0B60CAj1OVKxpYAy8B4WWEDp1GmBnbXPGuSNr+QSBS6r/IR46rxoxGPFnpUHAnxPHJiJ/xyuEPBr04BzPXuJkfOm1jG5K4u0LSQ1VBbyKQzlzYa9l7MFqS8Avvd8EcF9IqBrN1KEbJzmF/499NY/X3c3es1b3Nr1xCX7EUB78w0GcHoJ164uN3QNfwUa0EnZm752KtJXjqB0zL1H2FBdCxEoFFPyjImAz7c88
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(6506007)(38100700002)(4326008)(5660300002)(33716001)(8676002)(8936002)(41300700001)(478600001)(2906002)(316002)(6486002)(66556008)(6916009)(66946007)(66476007)(86362001)(82960400001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SAK4Y8vk3UXQ60sUr/kXNL6xx1PL5eV0anjf7heDp9RuaeSNZOcGtqvZ5wEI?=
 =?us-ascii?Q?o44YolTeS+Gzbl08d06zYi6hh9RnUNtNUI4JEvz07ZcyJGVust3IspLI0Hyx?=
 =?us-ascii?Q?L1kQjJJDsjTbo+E1bIhC7H90v24iyqPV3djpnROOentll6cifjkFFXGcalya?=
 =?us-ascii?Q?q4QH8bADoBFGZvuHGlgktxcWeR2EP2m+zEP6CgXbuDBPVhHCwsntzabWOHpX?=
 =?us-ascii?Q?9clT6UMQ8QBb0xuNIxiR/P8YeCwxEDEVBsye9rl8YSlarI4FA5NF1xZzcpyu?=
 =?us-ascii?Q?+ltVkzu+PvuTerNqmZty4grpp3ouZBy3xu9TqBZC313yl84GwLhjGdWhx6Vv?=
 =?us-ascii?Q?KKNiAQpAHQZCNZwP39IYSLr/m0COKOVUgpbuNGn+n57sh5vCkSpTYbCR/AZk?=
 =?us-ascii?Q?GdPfpB4UQB9UCywRW9R6cjn9WWaXOaVAAnPprbzV+RfYQBDnhiN8vxZx+XGE?=
 =?us-ascii?Q?0HlsQMoebagRWM6PscqCAKEcQ35w0EIqnivtFMajhsUt7TSx01m3r8evurlx?=
 =?us-ascii?Q?GqAnw3WfBIoGqqqat4m7adj/xRKprvArXJBeUTiH1bfr9cZK/dxG5DKC7pVz?=
 =?us-ascii?Q?QUHcHxCPJdhbKX9WBn16di/WFYbSlVgIdSYK+EwuMU1EaZa9K1dy/W2GW52U?=
 =?us-ascii?Q?TJ9PvFInSZYxJOcy70xekrbBx+TTc6SuaWfXeJFF23324CKhgg3cC46AYwau?=
 =?us-ascii?Q?AeFlbSW+QiUpWJQSzRlpyQ7ORsUKESzJL9em7PLfydU/qPp3MiZZxcGvx8sg?=
 =?us-ascii?Q?bbBBOTtT8mQSXwsCHYteP7xKciVsmFsCYKjD9JyEVbnqBXL6Ws8kP3KmMaNY?=
 =?us-ascii?Q?uAS2FEw5PEbZqxH/bulQZmOd8Yqyhqmy5lYWEXfsLFy52xuMfu5VUloT34Hl?=
 =?us-ascii?Q?M+k7I2x2dC6jP6h6BhbmsM+CdOidmur+D8Pzxazy78AK/OFbTV6V0SQhPf4A?=
 =?us-ascii?Q?CDMJfBGGfCPmV3Rwkb86kaEcispSxneX3tdVBHZeveUpuIY+EH7EwacMMG+t?=
 =?us-ascii?Q?pIVpM3j9utnvWT4Y3EBIqoprp55kXBFmPe+SufOjpgg8WaaKgYrB7hO0PjGc?=
 =?us-ascii?Q?7L/QxhTEhnvYiKYCFnhbEddIHM8NasC+DwzVg5G98yJelnA1StWd5dco/IZK?=
 =?us-ascii?Q?IqlGq3F167RqOtvQGwU2L5aj0zrC5fUFMaiVNnUNnfjvIIdZ+HFJHYrJEtcf?=
 =?us-ascii?Q?ifkGffBuhW69QtJ/TnCypB4FLDC+GoPX2kgB+wPoOOkZfrUkKTd7EWs1fa2Y?=
 =?us-ascii?Q?aOeWTvamFisJ2BMjMEkB4PgkiQGQnJh0wd5mdoND3YOjB4uf1Dx4q//6SWQA?=
 =?us-ascii?Q?k2b+eFlWwSLTdLCVPVwgdU6xlLAFIbIoUvP37WLCXLcCqtBzy+XRY34cyxML?=
 =?us-ascii?Q?nhgHLPcnYdzYVzhcb4C20jNdIFcbZh2k1XwzZO1IMbYHZfm+OevcGChGFjDA?=
 =?us-ascii?Q?OATg0QF81IqYdshuQytYrW+R1TyE1DXRq5cdUbmCccmwXPSaraGCzfi6Evzl?=
 =?us-ascii?Q?GpMlY2/LQOoPh7DsKMM/QtR9L2IEE+E4mIFA0Zf1iOxNh8BWT5EJDXjJDkMH?=
 =?us-ascii?Q?jqHoSCTdNvPyWj+vD9GYwS9WuxVwd4LuSVpX/zT6+kiw2+mj1NNlRTAU0Ax2?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4d9833-6803-4341-7234-08dc20e8f1df
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:40:04.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxJz5Zwxoagz7uj81OqIz8zJSDhKlqCcz5gXvrn/7qLYHCIjPQur0Iz8lBfOH22RuQ+ss3e+83nx/iOju51tLHriEYtE37yvqj0V67Qj4Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-OriginatorOrg: intel.com

On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>Currently we create symlinks like modprobe (pointing to kmod), during
>the normal `make` build. Although those were never installed.
>
>Add a few lines in the install-exec-hook, to ensure they're present at
>`make install` time. Thus one can actually use those without additional
>changes. As an added bonus, distributions can drop the similar hunk from
>their packaging.

It was a long time ago and my memory may be fading, but afair the fact
that distros were doing it was what prevented us from adding the
symlinks ourselves.... and then we never re-visited this.

I'll dig some history before applying to make sure I'm not forgetting
something.

>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>---
>Out of curiosity: are there any plans about releasing v32? I'm
>interested in the recent /usr/lib/modules (module_directory) patches.


yes, I should be releasing that soon, probably this week or the next.

thanks
Lucas De Marchi
