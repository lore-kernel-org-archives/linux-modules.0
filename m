Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC21C20
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613860; cv=fail; b=I7KWsh0iaFd04lGhxt1elpvszoc7niCTC4owy/4A+t9QKsFJRoC2tKlTwDRqDy0JobGkWLzGGFArOyuE0aNLdhMmgi6WAUS38EjCcROGaiakIJShOAhgJj8p6o8zzwSybcKv1LL0007zutokezM5VXJdrrTQAbFv7pYum6H9Gx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613860; c=relaxed/simple;
	bh=fvOdJNgIUCgq7dh9NFStuS6o28EhOirF8zKLa0xy30Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kb5X7+B5hWd53r4a8xlHXtP3zguYI3EnUR7hihW3bF5Ae/+J6MJRWD8UhMaSNvWSjFCUjqRqyyMboC6UkjPLWfDEXmFVLwpTjThCdsGLP6SmZjC2AYyUZ1ZrgXT77G/fDFw3VJc0aIaAWVsb4hQViWfuQ2w/9tm5h5acsVe9OGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkCVYdKf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkCVYdKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719613858; x=1751149858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fvOdJNgIUCgq7dh9NFStuS6o28EhOirF8zKLa0xy30Y=;
  b=gkCVYdKfCElrtJeOT/fTxXlPiVELGZMZzJrQrwzrCKUABZYDQgXbgh3S
   RQPunqrd9amn414R8ZPw3I0/KJ3txPm4I8N89H2GOMZ5ngRjHvSm/Ynht
   UCd048k2y9HTXKqgFMG7jS7qjZYnWFRRrNWDvX2vr3o5SmiZNOVaDxUoI
   6euWoM/s0D1k0eA6ulJG9SSTZCtcBtKvcx4Vo+fUL55XoWFKB3+9Yd5WD
   xHrVI1Krbd7CZLpmGvOaj5QUuUlRWvvAq0KF0ddersg9Jtjckrn5bGaAD
   vUJM7Jxa6mZ7l2drKQ24m3aPU5jqPSmxaS/pcP6NFDC4VKJHDW1kHPfY9
   Q==;
X-CSE-ConnectionGUID: 7xVdCR0MTmSI3x5cOUZWwQ==
X-CSE-MsgGUID: Tzm+a1UMRmSOUGuK5KPRrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16548284"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16548284"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:30:58 -0700
X-CSE-ConnectionGUID: m2f7SVRWROeC6/OUZfZYpQ==
X-CSE-MsgGUID: ixJNIwjFRWiqbU6k0kKTFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44911724"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 15:30:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:30:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 15:30:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT/B/KTu2Uu66Zr8cs+vTWl+VnW6BQzp5RFVcccCsb1v0lQui71bUnHpFCACYQNCTwPZQnov+vwWVnTITCVe7xBFIeHkg8B6y1T3t3s08VQzaWqfF1JK5Ynltf6s2W/HjGotD6TKyguK2O81KZvU0lL2al2VaFL8wUFeSajsiZsUYvZ4pZ1Vm+USfR5lCb7oIangzLm5FXuwwfrRxkqKe4B1J8U2TJkTaOCGuh9C0ffHD/iDp4jYVy3YBleJLOpdBOIvdwJhe2W0eK+Uoa4O5l5+irj1L2fzr8cZ0AD1cAa/31PDl6m5D+6iPf/SihZahEI1O4ngtJoRh3XAp6uNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZywXGQ+PVnKrAQU/+fGGZW/TZvNdZi0gYLQPmO1CYw0=;
 b=KgJ072TdQYfPoRbZCFTiqndclhW6rijQRBUEgWQQx9xqwHEQ6FCYjVI+eS0YBEnAS/Nli57sFuDBkGu91bv7ac6YyE5NtiAaNlOXRPBooKl3J7PD6qmb2O7lOfy4qxfZPGFKIEtENTVmzjgPyBsEh64Z6Df5b/4EirL3LwT3zbSmmzOMvnCbM0PSGac1+ampvx/w1/s5M6XB00GEA2G+9iCEJRrskhuzE8FvzGAFPAS65u6aTkbbBznDF2Zebv8zoFbUneQiBJ39pZR/gSOt6kSYxF4eBnDNsvBKn6HT5qtkm0ejsjzmwIDp/B0+UovO2YTAG61sdwCaTfQ2uQ3S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 22:30:53 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 22:30:53 +0000
Date: Fri, 28 Jun 2024 17:30:55 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 06/20] man: white space fixes
Message-ID: <oh6yesj3hxx2vep6ivys4nvjl3uavcugoaenwtpgy47dcg5b3u@chd3tcfplm3u>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-6-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-6-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e7a418-0664-4495-2b7d-08dc97c1f892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Snv4fxfa5G2NXAXl37EV0NWUIDoi5s875qTytj9GWzYbHfjyO7XqvSbXRc/P?=
 =?us-ascii?Q?YCbGxuBAmKVVenlhvSRu3yIgSFYf8sKZI3WIDXGk4gQ+xcyU9eQN/JzsEJwJ?=
 =?us-ascii?Q?k62+dz1/V9BQxKvaaw4GJSRXtoCgtPHp0mbvp81LUP3EwduYdUdA5FPAz3m9?=
 =?us-ascii?Q?hkusppC161fvlpgbRy/QMtPN9R7X02YxdTkIi7qGAQADpbqxVOQ8KPyF48Y2?=
 =?us-ascii?Q?HLufr1PrDrq2KVnTa/n+VHIJ0RldnpuWqFPmCshFSBZdVIug4nE158giObJl?=
 =?us-ascii?Q?jqGfO6fZyS41eFNWZc4PM9ZSYcLbLL9mbz32ahhz54uNBicn510t7e4+xW8L?=
 =?us-ascii?Q?TOnjQulbdznj2mfDJVYtbnwwfe4L1nBVIvs9iWx8erpr59jtz5xN66aEBs7G?=
 =?us-ascii?Q?TDxlrmsmFoMvUvgQk3aHuid0wb8TQ52f44DJ0HvEoTgjyFJt9nA8LmlwFuIr?=
 =?us-ascii?Q?jz+NNftEK0mxJXpC4XkO5Ufu0LQmKoTu+Ogrd72yo9KkpCqftFxEGysM/0KN?=
 =?us-ascii?Q?i73NcTud1THSpAxyFDgc2ZLB+OJV9tJ/EZxzFPGOy9X3U5dRcix4rGKp2UfH?=
 =?us-ascii?Q?Pbc9sNvMe99CdokTkC9ScxgDklfrfeJh1V1fWoh5yN8pXv0L0Tjahf+0fOep?=
 =?us-ascii?Q?/Cj/dDZPLJ9gO3XKAYxv3evYlquuwUbOFS2X2hohWIum1rxYfmRKz4mjNaOD?=
 =?us-ascii?Q?qGQg8FQjZCVvWS+435mEboqSsY+syMx1B5pyTSlWr4HBIqwFAJAo9Dq5G7fq?=
 =?us-ascii?Q?oZv/zJnx3P7AZ1DInOKvhJBW/iHqZgAhl112vqqAf83ksNmg7EQWe81LJ5Zq?=
 =?us-ascii?Q?O3JcIspLiXou54JTUOofBo8FV+aYJYlVKfg4RmklDioA1axCccN+mNo8rY0l?=
 =?us-ascii?Q?Kgzg2iJG22T3uuH7Fd7NQusZ7fxz09otR4Cky34KFcBGZqZk4garrMUn7b8P?=
 =?us-ascii?Q?qCTWyMEwbv+e5P+IfPFjRY/f7DgijR+CGcKf3EhDAxgBJtiJHnWGrLEEw2eH?=
 =?us-ascii?Q?VwIP1bDjqw3/tFhWPblQ+laEbpA/7cI2WC3IXw+LVZzQvYo7DwZ+PXIC3USK?=
 =?us-ascii?Q?yy2cwhpw9oRip2M3CkL8YhBODLaDS+nI3j9XkOF1V4qbGCIKkuW2cXehIZu/?=
 =?us-ascii?Q?MtsM0VXnNddPjU2YCETPSQIWx54uucLjeZeEbrRG7zflBunWErPXqIV0LBNj?=
 =?us-ascii?Q?3dB8tDnKT91io3zJkAnmeBd5NdszvUeKCpAiMgJbShEovHNcEqb18Am8k3x8?=
 =?us-ascii?Q?cqcrvI38ZvydeHzkTGZvkM6KMpeJfP9zzm0JhJGsJIzz/GvuvvfbJwPu9/uf?=
 =?us-ascii?Q?q80NZpntIXVN03YGko6C5ikcR9YhySzzA16RgYX+TVunig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0ow2PpBj4X+ZryKYYJxrU4eOmUNIGT+BO+qgbVuJLnldLgH3wD/Q5Qo95Ig?=
 =?us-ascii?Q?dwVhoik5XawC4EmN0cuWgiMKfsvSNeCPwWicDjFQA2sKjrC0Js/UTctVWZLN?=
 =?us-ascii?Q?4yOK78hLl9cmDxuwjUsvLg79jC2YYbLI8zBcyOPhCYndHRcaK6r3efKmqnre?=
 =?us-ascii?Q?MMT6Ja/JZYNfrPDrExkr9d1p8OaRf9hiDZQf6ylw9JbRFMGP30NLNUX1ExqC?=
 =?us-ascii?Q?WzvhSnxP5PZklM+yWSa6HcXHXSRPuyhWvV+mii54RPC5sSafHwQjnJidWPAV?=
 =?us-ascii?Q?g9cgMnhOx+5zSuOyD0XF0+m8iaNdAWCWVCJE4aGPyp/bqF+3rVgSalkOJB4K?=
 =?us-ascii?Q?gZTsnMuE4XQPLmBfgp5CyB4L9p6VuPnIyCIa7Ai6o7UvBE5aei+Xm8W2BRiv?=
 =?us-ascii?Q?y9feKhW/tJ/XWeimBDTo7fnjW0hxwJPeWHC/Olb1RiwfGjTeQPcx/d+4EBJp?=
 =?us-ascii?Q?HMp5zyO3jhFfeF4+YANA4XGY64GyrwxiILehY8Jm/FX9uXsiMqUM5gY/6981?=
 =?us-ascii?Q?oSWqmCxkR0ENMqP6nHmjugDT1PFmSU/pPN+ipd3yUnRwkADUh2BTC+LGsT0n?=
 =?us-ascii?Q?mVElDIPtbAt9nOOP2uxqo4Qjsrdl7oeR6kQfvKaH+NQObOmrlLkxRiMc/ci1?=
 =?us-ascii?Q?Z9krsm8Gog+vKF/OmaIcUtAUUnXtT/5TiSWb+2udeAT9wLeYfzK8he6vMCc/?=
 =?us-ascii?Q?k2PF5s4y0PWgR8SWt9DtfFWTdg/dS31c2v8nEbiOV1NGr6GKcWUf7dGld1Qa?=
 =?us-ascii?Q?fEgsm5Sf41/Yq5ySQV99e1UQxQdi6bq4sy2VcAa0eait9WZRY5G8n92FkKqs?=
 =?us-ascii?Q?OphE3vxkRWpAOnGlbnvdFmC86v+6AxgJaqKVI76DrkI9pPhe3fhc9xEjOsqa?=
 =?us-ascii?Q?UVu5/n2aDWlKsgk0T0Wxhp+rgoXhhPqc5N2nT1yjk4nXeoW3LAhCPwpJ+wgD?=
 =?us-ascii?Q?m7l5VtVaV/mHaRtD3xIoU4gkEDxkivBBzRBtiWrBR8L8+XWijBKsUCroygW2?=
 =?us-ascii?Q?nOexbfU+l1NJNeQME5C+3psgl4YPo/yyWwtIXYNOQ1sOQTXTyS0m7hm1tjN9?=
 =?us-ascii?Q?YQfad3HSIYE++Hyde5CHPPiEh8ojd2OMo6NNhhzAT8BMdetEh+dXmD/QLm1F?=
 =?us-ascii?Q?CUpl30I0kOHvTpq8vcuHpAoLBv4j6YBLwuQoufpwsB/aM2zBX2gRoBpb5sAX?=
 =?us-ascii?Q?fjIPRXdA3qxVF3a2Gf6gwutNe0Vxf1d++WrXSMF/zFKfhYNCFhputH3xs1oG?=
 =?us-ascii?Q?uIptqlPUi93jEipicfXTwcnCchGDSUgsKOAtkzwSyIKUas+d+gmuOyzaxt3S?=
 =?us-ascii?Q?tEC2gj/FljS+m2KRLPBWm+xp06vWhExBH8H99kdBCWfFYiZMVWxP3eahipNt?=
 =?us-ascii?Q?JwITMCdy/YwT1pny2cVpvk1pPcEiBzAYDd+uEL7u2FEImWA+kQWc0Dsc4hHW?=
 =?us-ascii?Q?XxazqizM+Sx94h/4p0Z7JkshhUpKL1jL81C3EmiAVPC8wrHmNUcUGImprjct?=
 =?us-ascii?Q?yckPqCuJk8XPvR6HFhtrhi9x8rmy2VIVgSJXvB2X9fpVDwhxP0i/jduFDjnd?=
 =?us-ascii?Q?nWTY4tUs+mvwJozNCIjqa4Ib+FrbtxY+D3BreL7Lj2dkNJ3ctl97PKLz80PG?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e7a418-0664-4495-2b7d-08dc97c1f892
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 22:30:53.6421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj/AIVxSRqIswyMp8oGmtoTTi9vW+Te59sDZVzHFzGK6oY8dTDzzD1YetOBa8o+mHJ/y2f1JeuEddHRprqVuEpqlYpO8Dkxn0IzMMIr5Qtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:06PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>These were present in the original xml files and I opted to keep them
>separate fix to make the transition/comparison easier.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
> man/depmod.8.scd     | 4 ++--
> man/depmod.d.5.scd   | 2 +-
> man/modprobe.8.scd   | 8 ++++----
> man/modprobe.d.5.scd | 4 ++--
> 4 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/man/depmod.8.scd b/man/depmod.8.scd
>index 8cb6449..80cc48d 100644
>--- a/man/depmod.8.scd
>+++ b/man/depmod.8.scd
>@@ -54,8 +54,8 @@ rather than the current kernel version (as returned by *uname -r*).
> 	than running *depmod* again later.
>
> *-o* _outdir_, *--outdir* _outdir_
>-	Set the output directory where depmod will store any generated file.
>-	_ outdir_ serves as a root to that location, similar to how _basedir_ is
>+	Set the output directory where *depmod* will store any generated file.

this one belongs to the previous patch.

Lucas De Marchi
