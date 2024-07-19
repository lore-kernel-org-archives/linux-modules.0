Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817E224CF
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407875; cv=fail; b=tZwCbdjcUFSEOqJEcw+zeVXBR2fs8anhypYCiPN9j182szFJ3AuNU71Sn34Smgmj+ZKLu8OYJhqt5kzKKZJjdJ9fhtF4FLHMGSdcqLsA2FhOzGUIqX00BDKatjFGL5zI2boBVOSOv3oIb+Ph63DK7vTHJCB2l25xcIG5y2rdhOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407875; c=relaxed/simple;
	bh=qdVS9S0h1WevnNaOgUusEZzvUpGp81MDvtcD9NNfN3Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n7+YFTkTpeGKyhnOmnNocva11qA2pz1ydrqCxvrBaLZfH2jkqHvibPcDm5IfQn7OaB6brw98Fl7aj3QRL8AhxgOGM2Ray4tEIBztXnco28t241cTJ8mVl6q4+SyNKKk8CrnpeZHYDw2u98038HJuBR+4i9UN7XeV+90dwrLmHOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4dMD5fT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4dMD5fT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721407873; x=1752943873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qdVS9S0h1WevnNaOgUusEZzvUpGp81MDvtcD9NNfN3Q=;
  b=N4dMD5fTWiT6PL8efj+Kkx1uLmoUVBqX06qvguc51sBQiiy9zkE9gcZS
   NUdVU2BLm9QARtwq/lCUEiBkOOzc1cJrE0yuagCkSo3umY9QpRZXtJCmj
   KAmn+nm+CjsBENGMHcLayPYPRSllBl+P9FUtdgI6CNTdzs6OhG7I05WQ5
   cSzZ59eUCmLZnjl+Mq2Y8dGjd0LbPUqqWZxNE0FuW+mnuixVtUcEKHscS
   f2tYLV/h0XviruSA9T0PrNynLuoJkoxVEvycEc/ps34BwkfzcCHBh3Pri
   X08tSqwmq4LqlYCKfgYzjTy3oKj9gybMQwjrgE/HRWY9/7SblPwiaNp0G
   g==;
X-CSE-ConnectionGUID: 4RDMdP9JSfKZvR8GHVVlSQ==
X-CSE-MsgGUID: IflPbw6gR1ee8BRgW+uTzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="41556758"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="41556758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:51:13 -0700
X-CSE-ConnectionGUID: hQCw9Zw7Tiq+zRiUepiCuw==
X-CSE-MsgGUID: KXv5iRh5R3en7yup4aRf+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="88652557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 09:51:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:51:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:51:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 09:51:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 09:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMbL82lJ92zpa0Pop/g5fft1OQNWK/bA3xrRUhvczpUa2/uEv4itejUNvUkIf1UJL4FrvsnFUyQGvHwW+QiK8KPzWz2rhvzvhUvSm81S/jXNIfGdks1o6crxD9XWX9mlNE2FlMNJrgopN3xO5Hfzf4qqbWLmqMhd+yLDcWv7p29An8dNt7Z6BIVwDmHtApwH+Ui2QLf8BnAmFFUC5yyakVLiajo4BIYPK8koTrAGpVRMyyv9MOURhzjG7NI0O2DyKINDthe70jZHYctqpCigZs7TyFKXGCK5kZE4Gp/6kv1ZwvI2j7rVYFQ+WroO/+5vRHFON5eLPTyNO9JAoVCXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/F/p7XchgqfqkLQKHuA+sPy8BVOdST7A85PFJ+bV94=;
 b=vmTJvSu8sN746ee5ci/CeoF4K6O5KCLxOZltcR9tbQ8tSc1zRkQ+31nrmxQi2M12FpBQtkglKNpdU39Cs0iioabA3qBJ5QcDFPthqEw32bDdrlnw+mOFxjAj1jcQhF03B0VOiwbApkdT7Pmvq4ZNkQsmpaOyWUC2vGSHr0PMrba0DLX2cr9AuF7/W8ybY6IeVTZnaf+qs3ddJgnVgQCFlrTV5uirBMb/im2qNaU1k4OvepCnNxLMZElh4BQJhbUCoxcrLXGBFtCaPXFECmoXgqvoE+zvAqbUh3djT48LZxgcepJPRSexZnzUJ55jKhWcBCnIAo6U1z3qnZxz5GpKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 16:50:51 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:50:51 +0000
Date: Fri, 19 Jul 2024 11:50:46 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Marco d'Itri <md@linux.it>, "Eugene
 Syromiatnikov" <esyr@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>,
	Yauheni Kaliuta <ykaliuta@fedoraproject.org>
Subject: Re: [PATCH kmod 2/3] libkmod: correctly tag
 kmod_module_new_from_name_lookup
Message-ID: <4zpdbutualipeaikw7yg6jpcumtby42thae6jwvqo6lcxh6htp@ahcivptikezq>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
 <20240719-abi-fixes-v1-2-1e6d99a2846b@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240719-abi-fixes-v1-2-1e6d99a2846b@gmail.com>
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eb19f5-b210-4810-4669-08dca812f282
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lmQzG115R9BaEzbQXeWX+HhBXBxUlUJ6AdFy2F8NyNpJrEkwwzxwSH5m2cG5?=
 =?us-ascii?Q?ZbVH4Rpirl8DSLOXSx1I9gwxBM5A3k7BAWVJbaJ6yF/RevPVMuLGvP8O7I4A?=
 =?us-ascii?Q?tA7I+qzy9OpKaM6Eri/sEn1oXveOu1P59loZ3Fe/tkk7fnzO8owhTWvVOEkp?=
 =?us-ascii?Q?hsTJU9b+ftsRLeL3O5VUGcnZbI9dFBbUR0z3RVeCJK9R7RV4Ks1LPytLgbbG?=
 =?us-ascii?Q?vhb5/N97aYyQ9KIcnRzd1cCr3hzGDhsoLBuYYi7jdJPkilq1cONRiw0beg97?=
 =?us-ascii?Q?7mbbPGimoGklDrfzqzgmxz+3Eo3Vsl7/IDQvdUdfrGsG85MNrdpSuzdJbccE?=
 =?us-ascii?Q?U2pug9t8zjCOvQS58EtutA1LpJ3kDRpsB63ySVL85AWX7oi92cbzv4HGPmrz?=
 =?us-ascii?Q?9ACeL0ARurS+5WEGkRrxwGSsSFQfi2TlTCpWW2IhA5wSBPI0F7TBGHGSoKPJ?=
 =?us-ascii?Q?cx0gNO3Ckcucyj6Rk4gbLFz8gYG+w8SxrqGjICG8cMDLodFFuDRkfUhk4nEj?=
 =?us-ascii?Q?w0SphiSeVLy7+svhJtiAiaX8njp8vm/m+r1ZjGDmbODNOeq8O+fRiY2l6dBf?=
 =?us-ascii?Q?T58z+T3NQpKt5P44KIWqNLyWvjZiW8gMJ6lbZsaU+TtEWqnmVmEHqn8Zsg/4?=
 =?us-ascii?Q?kOb271rJ/9/gND4DKITQ0eoEuRxttUJuJcmVp0nvP2bBUuFXnNMAW4vBjE7F?=
 =?us-ascii?Q?PKiPq0yvc15joEWU46ZLIMn3y6U5+3AZmhrBXxbSg0F1b3DZGq52ONsNtI+f?=
 =?us-ascii?Q?oC7Zzg8/YLj2AWQ+arm16Rd24lfcQSyW/rYYmzxTV3EOz2AUzxBdmH9ZxQEP?=
 =?us-ascii?Q?hwj4XpwPX0xNsm+AjKB6PusfknvS0WCxLotNaqKveWy5DoyGpiHqfxkZqrTo?=
 =?us-ascii?Q?X96LLqS3JDbolHj6TIj6Jbc8yj1tSgzj7z4lZupEJxeSkRdcCkHqqbewLT4/?=
 =?us-ascii?Q?k+/FIwdkQFCZrfGL1PWdcrs0WVTwjt726yXK6o42nmh6WqRShVs7Nd+kaE4b?=
 =?us-ascii?Q?GEcafFUe4KUXVQof5kKoXB/MADjL/YTW/M78iQcvGitWuZds/YV6BlZAfkjY?=
 =?us-ascii?Q?/Dt2AkEwb4BDnQW3+iXMy4UW1FBEbJ/GwE9+/9RQkyFqcQaieEmKvsrMWt53?=
 =?us-ascii?Q?n9Wt8iFvtnPHPq3ztPHnzH/nS0JJCixfMSe8kAN3WUnTYEqh3+1K1uwB0fIV?=
 =?us-ascii?Q?pQZ0Gg9bsSjTZwtl2KknM6FmLTLnVQqPedEUAXHrGeuZcakR74cpUbvEX9U4?=
 =?us-ascii?Q?k3wxmZgQKKgHzMl6alMMtMhsC4K3J8TtfE1hHyWcS2BMkoDigUTOeZuQRj3z?=
 =?us-ascii?Q?+XAQTKvh7f8+qbNRjlUKB8LTESJ7xg776i5iGGZie/GF2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T437jUamqnOOMjWzdjKnZZPk4oNAuzJm+OtEfwkRhbfe/9jll3PD2Q2oQoMe?=
 =?us-ascii?Q?LhWgH9BGExpcM01ZGIR7tyKmWJAaTDzy8tdwGwI3x0T6XW0oZXnSaoA43BPt?=
 =?us-ascii?Q?UGAXho0aScaEdtAbmy0T53TGhxcpVutHHyX0yBH2D5FyAcO2HKZbEf1B3U9Z?=
 =?us-ascii?Q?OLZSLWLkaYTCERoveUZg2jwywKBAhc2eNHI/t0DkcFKIWwECIc8RvjeAyXJm?=
 =?us-ascii?Q?nS8aBpnIu8lShdKHE6pvoHFwMzRnHAKDRRR/GaeM6fTjHE+AUpf5a3r9SJKq?=
 =?us-ascii?Q?x5Hbrg9KC/iv5fp34gLlKhM2819VZqj0vamymMmoycZKiWOjRowOsyzGFleA?=
 =?us-ascii?Q?36hX33JGZkiasGW1p2bXhoIfdlQafwoQR5HOPjf/2yOKAGaw1sRgEmC4OpRI?=
 =?us-ascii?Q?Ko2el4SF5bXFwykK+3XyMbOvBYv72Bn3R+LFH24ZQAssxFVK69wFnGZcqW04?=
 =?us-ascii?Q?RemtM9p5HTU4N+o2Ka3t056ABUXFnum5nvtvhTPPXFP/DUskVDZKRIHvmZ8c?=
 =?us-ascii?Q?mO6K3jhRwQNfnrm9gZ+TXOnC50Zufx3c4OSMHkLOtPoOf8KbDZjqgXcmOBWY?=
 =?us-ascii?Q?dYo9m210n+k4lB5iWNSAkq31yr2JfnBTBUfnIqlr7+/+BljWrLtstdNh4M6K?=
 =?us-ascii?Q?AFiN6Iv67IlFeTcLtuDGvKEoCaJs+Q9K1T4evr4FJZ2sMnOrdMztVeZlLs8j?=
 =?us-ascii?Q?zSxGcdFfYONTOtBlggmIpKtfzQbVAu9ndMTuZ5zYyhVdyFzqMGgLwSq1Z4+r?=
 =?us-ascii?Q?Z6erCWJzzHBykzduQl3om5ndHFC9ggYkCsWVjHCtOXuX8mO6F6WzHaWtksCc?=
 =?us-ascii?Q?wZJMHgNR/Tc/p95OHLFZ1U/rA03/9/shdd35NdXAn7DaTfdFBJ2J7dTBbI+0?=
 =?us-ascii?Q?YqXz71PCMu4Aj2/cLY2aeW4thRHpxS+hBtQbzLGS2z9ZpM4YZVXcFZ7FB69r?=
 =?us-ascii?Q?RqH2arehkb654xiNjslsRpF1B1UDAavSSbjp7YHT/YtXvuR7zee9FYu+ofOR?=
 =?us-ascii?Q?86aKTRJ9dpFXggBTry++4eGhbVEVZIwkuGiPUauPkCbjng1hDc8sfBii0QCy?=
 =?us-ascii?Q?R/FjnfhAe7FHYvQhPDj+RXGwyaGiWS3PGaXq2GRw41iYIKafyIh9N9jpLe61?=
 =?us-ascii?Q?KHMwbbOJJfd//5zQXb+ujg2D29p7QBzHb/fhjtYiSoAkQrPpvVkfzFursMRd?=
 =?us-ascii?Q?H+j9BKnw+r184AVPgzXYrd36TVfCjV9e+mdU23r/6dEhmsqugPI8q2yj5RiA?=
 =?us-ascii?Q?vOpimEnPffhsj9IOy3R8L2/Lu2DZEOo6jjXjGCCvrerCNNlrYoh3c+n8Fydq?=
 =?us-ascii?Q?ceV0OykBbYjUdxUMCs3Qy1RocFunqUp69e4zyS7lhK146+V/msCsuE6Isj+q?=
 =?us-ascii?Q?YxhM0Fris5hz76Vi3Seo9dickb0yeEBcFmx4U89xc9KURdmMGgZXg1d8U5yi?=
 =?us-ascii?Q?apnd3t9RrtB9YchM4KL0w4GS5EydHEtBqL5FvGU7SJ0rh7JSxjrrImRwA2e2?=
 =?us-ascii?Q?ir6qF6rpGdktzf7tvoAGf+u8mpyH2so3t6gh5IU4EiAY8f3tgmLqf9ehQTUL?=
 =?us-ascii?Q?XD/4CyQl3fGQG1+uBa0ih2fs6hM0J+i5T/aznBg8qM+/OWNf75UHr05s1qAr?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eb19f5-b210-4810-4669-08dca812f282
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:50:51.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riIl5h/r5YmtI7IqhLmeC4YzR+k1MQc4l8Vt8QYezxNx5EB7ELATQSCk52cZ7GyPI/NjzdYQNfkHfcgTm7yE1yJnWQ3NcFQsVMdVvui0T9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 05:12:42PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The symbol was introduced with v30, yet was erroneously added in the v5
>section. Move it to the correct place.
>
>In theory this might cause an issue - severity depends on how the
>runtime linker is setup. From a harmless warning (on stderr/stdout) to
>failure to load the library.
>
>In practise this shouldn't be a problem, since there are seemingly no
>external users of the API.
>
>Fixes: 9becaae ("libkmod: Add lookup from module name")
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>I'm fairly confident this commit won't cause an issue, although auditing
>the whole internet is not possible in practise. In my search I checked
>through Google, Github and all Arch packages using libkmod, namely:
>
> - dracut
> - igt-gpu-tools
> - libblockdev
> - ndctl
> - open-scsi
> - pciutils
> - stress-ng
> - systemd
>
>Another option is to make the symbol as internal, since it's used solely
>by modinfo which static links libkmod.
>
>...we could also leave things as-is.

I think it's better to handle this as an issue and let it propagate
through distros.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks,
Lucas De Marchi

>---
> libkmod/libkmod.sym | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
>index 0d6d338..e71f488 100644
>--- a/libkmod/libkmod.sym
>+++ b/libkmod/libkmod.sym
>@@ -31,7 +31,6 @@ global:
> 	kmod_module_new_from_name;
> 	kmod_module_new_from_path;
> 	kmod_module_new_from_lookup;
>-	kmod_module_new_from_name_lookup;
> 	kmod_module_new_from_loaded;
> 	kmod_module_ref;
> 	kmod_module_unref;
>@@ -94,3 +93,8 @@ LIBKMOD_22 {
> global:
> 	kmod_get_dirname;
> } LIBKMOD_6;
>+
>+LIBKMOD_30 {
>+global:
>+	kmod_module_new_from_name_lookup;
>+} LIBKMOD_22;
>
>-- 
>2.45.2
>
>
