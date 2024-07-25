Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA4A19CD0E;
	Thu, 25 Jul 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927915; cv=fail; b=MNtQf0GGpcVk+Jya8Z6E2NsVYA27skzquIZRlmnSfb1vSjgUrZhtAYeLsHXXPbA5xvWQhLcK5KqPFSHXWWrJbwm9RqeZz2qXo8RLRUtFY1nCmB7asYjXegozBjgPiMv6ZQ4XXlo+E75seLK7U13wlhwlClLz6Jh7ssGhqbuFpfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927915; c=relaxed/simple;
	bh=TmFkB4K3DdDy3i8GRSas2K/QhBLHTM/v7zmrszNjSng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uiARkUZr3u7PDYdWdkwxKOXBpKcqBXfjftPRp1dLIiGRBaoy1AEwTVgH8+GMciaddqvULYNxz+qJKaGc+SqR3ktE4seC9rkfFOF5OvuMcW/7/hAtVJOQ8uQSFRCn7NIITU4lliMvHEEykvONAY2DZjkQXcYpj3hpnqB87HBJURo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvE5YmU+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvE5YmU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721927913; x=1753463913;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TmFkB4K3DdDy3i8GRSas2K/QhBLHTM/v7zmrszNjSng=;
  b=kvE5YmU+XWog2jUrqSCCNkPc5PV1hPVvzWf+jvphjrIkiCs7n2w3Bwiv
   59Pu4k8v1058cDVhltNMLY6m73ft0DGbUNvTDoHei/ksNcAzedfSN7sY/
   GnD+3kRU/eAi/dzmbxG2YMSq8sppOuRSGd+qbuDYGXGAnyynrLefnsRYb
   XmEl5DPF2xbYuyHieVl2hg4U4Olv40iLrqGc/CRH7gmi8HFk0WRcTj5ru
   ef9Nfh6A1qnhH3bThfKm+CSL7onTBCON5lWFgVqZdnyWr5hTQvmN8Jkj3
   1xO+WUIGHp+sIeY5NwfKs141Hyyyk3B7P4W0aDgo5fwvCI6LZ7S6r+nJi
   g==;
X-CSE-ConnectionGUID: 18LGgDXHTGmtNPqCOH2P4A==
X-CSE-MsgGUID: Nl8WFj7RS8GQ+4OBZBM8SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19825001"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19825001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 10:18:32 -0700
X-CSE-ConnectionGUID: l8Zo3j3fRnaA1j745GlG6Q==
X-CSE-MsgGUID: v+Iqn4DlTB2MONeX/w1ZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52882618"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 10:18:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 10:18:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 10:18:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 10:18:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 10:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8Pz3POJyZ3QIaq+JHU4K/CKyMD2lGTZGHdFqWpwOTpbUhVUK20Uiqr9nMTFsUFtzsUQXNeC9n/g8wHoq3Re3vgCHO6L1k/aLcO061iwMNAyStXeAOQVtBpdoYL/5+Kx/48PCRY3eCyYpLKu3F+8EBmxf6R9yPA+JfeSWMjMBrHeiLScAsMZPFEylDB91OlN+1IjYdEoCFhj2DTbkOGZYTq3AagjAMtKsz6Tast8zBRKhTfxALcsIkk2SUFl7P4RD7/F53xaKGKbMNiysT3NRcng3XVVp1+v989irN1easfwHOUdt7P9geso/boNihpj9e+Tfg+tAbNJr/nMIJ63pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJYKxNaLGywHVKs+kTQ8eok+oGb1k8jP0T9TUPlVy1Y=;
 b=yVDL4jgwwVSypK3rTYQlr6GpiuiczwKg6ZcZ33AyPRQ9c2ZNM77GjxJB5LhWhdK7afs+59zpH9GPe4aDIwyBn4SBsUeIou41voa2YNVA+JuBGIj8TpwZyh6OqV3G6NwzgnTC+HPhDXe3FeHivXXrWi5jGBUGNm3vdivOarT5PNmtyStiZZQo8AErzBfp+W2jSZigItbDx3CBGmQ2GjCdE9jN3nFEXdtR9Mnjo+iZ0vSR2EqeUa2NYf1+nIBT0SEYmdVoumPUVev/4uS5SHe81tpITLLfHjGs4dwXDOdoQ2sVZsmouiyjHGbAozBBxwrFOY5ds9XkmeFNVCdjHc8v8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 17:18:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 17:18:25 +0000
Date: Thu, 25 Jul 2024 12:18:21 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Steven Price <steven.price@arm.com>
CC: Dragan Simic <dsimic@manjaro.org>, <linux-modules@vger.kernel.org>,
	<mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>, <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>, Qiang Yu <yuq825@gmail.com>
Subject: Re: [PATCH] module: Add hard dependencies as syntactic sugar
Message-ID: <azedppfy2e5vjycn4zpzkj4ek5mjgjmdjsxf63fm347pningpc@uuhkyeiu35yg>
References: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
 <gcykzencr7rmeiy3rmclxrbbvuryo2uyb6plqqovee3bsme42b@g6pwzbgitgka>
 <1393cce9-bd64-469d-aa2b-0fb768bf9e87@arm.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1393cce9-bd64-469d-aa2b-0fb768bf9e87@arm.com>
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: d84e2fcd-3bda-447f-6580-08dcaccdcab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?c9ZpVY3P7Pn4lYE/JSAuEWAS3AcF0rXPo8UAIMTSQW7AK2ixEr2HMboGOX?=
 =?iso-8859-1?Q?zw3ehmjsnIfH/8LOK/ufbf8KO/Y18UlSCxBn/OsRJWjJENblQCFla19mJx?=
 =?iso-8859-1?Q?hbdZSWu93vQtNKjrbVCnjMKtEgEU1kcSuFI+Lrfu9okr4VmLbClkSBbnNO?=
 =?iso-8859-1?Q?qnZPmkcg2EwBMgFlDru6vdJ0MDkgmWgdhf9mvkG17Hxjh/kdzSMKMze0zm?=
 =?iso-8859-1?Q?9KPc/2n+0nB1ItUN4Npgo3j/nKswW4IENTfwRPkuWhHHZeXjiwqIUHffZa?=
 =?iso-8859-1?Q?49eZzPhPIMNr/qCAkKlZj21IeJ86T2WW8k8P8IGeeHFJYCPj14hnRbe9zo?=
 =?iso-8859-1?Q?xy67sVl+XL56HX4iZCin4U6QGa7W3eMv9xVmXgpKUAfVUB1w6HmBSXo/e0?=
 =?iso-8859-1?Q?2UJh8uuNEydrO6cqZOnvZ19OIx8bNWUpbE7ELxV8IVUGkos7NirqatjiOe?=
 =?iso-8859-1?Q?ZB310Ru2R+Z/3LtMVGNjSnYex6CVwVevaQNaCTj0Y315vx3PGbkZeiRBxB?=
 =?iso-8859-1?Q?ERIkUVAq3m8azoom6m7JAQBMkRf5jntk0+RYLVP7nZN6SoP3NDwgOTejbl?=
 =?iso-8859-1?Q?+80iN3KUkrRO3I0Cio6yhXzbdzlLWkM2E9P2SSOjmt7WtYgdnnSmBxLQcU?=
 =?iso-8859-1?Q?Rtm1fSkepph6DPSoCT348LnZDg4ujZ9+hRID45WMe2jhg9e0Ml0Ljf1mUy?=
 =?iso-8859-1?Q?GkbWZpPAmFLX6kohzuAcgdG78JteJZY7KM5AqOzjA8dL8Q0t3yOEpnnavM?=
 =?iso-8859-1?Q?injFmay9KG7gH23GBCuQo7OEVYq1aPuVqjvZ0/jBq6fgTHzITZTPxKO6mO?=
 =?iso-8859-1?Q?aQ89Ia9EUuMgUX9QmrWSKEsaRPMkzYaqn3sxx2ljch07aHHqgeSjr5nNiV?=
 =?iso-8859-1?Q?ch/KhNJQhSxcIJmNHj9hPNv7F06jg0/yrzyMTqk8St3XBbjK/xRVBTQCxj?=
 =?iso-8859-1?Q?KdJz4UGFxElJ/k+ROkJllkc4QyWDM619lkVOAIrXghE4OKQIJQ/FRam0Kg?=
 =?iso-8859-1?Q?qR6urtlymOb/4e6xNP03XBDaYsHnpMDa04lWPV2JwDhOftP1Sg/600voO0?=
 =?iso-8859-1?Q?HM2cWrufV6xZ8TGQYkcEpjwmQ/P3AaZ9kHrxu6B5ONNO3Nfh9MqFOpDdo7?=
 =?iso-8859-1?Q?4G+5nnTvP6W7eK4Y+HkjEOPA+I+gf89y2Z3ehHtyEuYArmQJEzAHgYKEpz?=
 =?iso-8859-1?Q?1AZGT8DYMmeV8zOCB16aJNgdPjbjZh/HLtSyutGTmj16a7n7cHq7SDGvMn?=
 =?iso-8859-1?Q?GK11L3JfK1W6GcglRMJ2G7V5L3CIp2M4vVin+cvxYWJMPtY9olbkI9y67M?=
 =?iso-8859-1?Q?tinnfkC+AxWg0VraCz3WtMHEKWNorG0uHnNIh1xddUCdq3oxfyCF3rcfjd?=
 =?iso-8859-1?Q?SVf0Lpllxz2ibfvVjoNOiSKByRa8YA+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7JsjrMGyZPWckt/yPBswFQuC/doCCIttpWIYHDnBrjj/ZxEfuHdJQ6eQaJ?=
 =?iso-8859-1?Q?fQV3QYHuY6kn0BsCTyhAjX+sK6oScglma9o9RPvvkdmp3bFxZzqYjNEPq6?=
 =?iso-8859-1?Q?TZLJY5cP5p5eb7Rt8HqC8iSta8l1yRuefnNoDVEX49Gv+UrOPGmhw1SbvL?=
 =?iso-8859-1?Q?LK+xVI/3ooCWwWZAecG+8Kwlc/ZYpV8g2E16rIgaNFbVjE9/XIYiPXNoCJ?=
 =?iso-8859-1?Q?63ekDEErvRJqaZRxatb8L+4HOnW8VWYcKoGc4YxROh07OfnTlwDcYnBQ7Q?=
 =?iso-8859-1?Q?W9Zp3rLT6PBTbS7pknG4Fnu58vGmsVcjf9DcTqDjFITCY7emXrhKa9mzFG?=
 =?iso-8859-1?Q?dCGTbGph15ue2fByDodQoyhrb9xlJTsD0ZZMQfPbg0nGoguwA4YqqYVdk9?=
 =?iso-8859-1?Q?2Ues9JELlszMti+pXdoBckKDHV22SHR75lpQxaQndVDaBlShykQyYbLKAU?=
 =?iso-8859-1?Q?PY2tgUje7EUuBvji2qjLvfVL5eqHc+PYdlS6WH7qVY76cdoMbd2qFLngzj?=
 =?iso-8859-1?Q?9GhhW2PS0G4RGxqKchBSFyt6BAAZ4LeKhyGzAEHr1VU6IxNk/3jOYZnMk8?=
 =?iso-8859-1?Q?/+o6DUNfut2MOs3emMnlqFyYbF/Rf1WDp0ZRx56jOWX1zBxBywM1pbsn97?=
 =?iso-8859-1?Q?h9hR+GbmWPXlU0POKRGU6QPKrAEf0heLd95gSRMqNNASekWakX8X1Xmv1N?=
 =?iso-8859-1?Q?Lzs3vAHGUjnhTccKiH6WPdGuJ4lMH5YbIxBi7AsONtstzm103y9RFu8+ZX?=
 =?iso-8859-1?Q?NDeHmLXhFFGeJe4BqewQk+zjdxJIjRDIFLGMPB0MuoNVlw2U85e1m4nsk4?=
 =?iso-8859-1?Q?XxiJzaYVKAaxpnfEfDmgj6tbjjldsrh0Zvne3oOjsX4+oWm0ceFBlS9zbk?=
 =?iso-8859-1?Q?st6JrbwZNrTL1/BxMMXphF1ZAoU8yKvEyMjrVjYoji4wD+YR5IkMFkAzj8?=
 =?iso-8859-1?Q?TNpvR8F15vk2RDjGZdoOLdXsgNFKFPNECKF62Y3nvSA03O8O8NlcH6Cc58?=
 =?iso-8859-1?Q?QfUsro4EDj2KNym4liJDv0U8k6Vk0Vj0d4dcjrthXOMo49+T2KWSaOvZas?=
 =?iso-8859-1?Q?DVu6VXeNRdwsikAgcLvLRofRcNI5ZgChe9EHkNv17JJ3euPrqGIAX4HSVs?=
 =?iso-8859-1?Q?uZRFacwRzZhECJf08sTY29p48z+5+ZdCqwgC4VYyTMj3shmUuG0/WgWr5F?=
 =?iso-8859-1?Q?9Wdlr9mUBopC6K0OMGOijO2Wazwu6MIrcBJcc3utbrmic+F86Ou2YN/T3E?=
 =?iso-8859-1?Q?pFSeeeuTRrxaJiZcZQLqOMzI1aHjIM+NBg3uuOmDljsfehTE6OGXYPdPkB?=
 =?iso-8859-1?Q?Ijhw7zkZaOMmnuBUmovwe6KLRobA5jO5FRoz5DI9W9ZvXT96SIIcJOdJdN?=
 =?iso-8859-1?Q?JMiNbfdBNHDJNBJLTm0uQREX7xCua/o1Qg4hJrX4S/52tcPvLMkCE5YCrP?=
 =?iso-8859-1?Q?z2JI82I3BRXd0ZO06zFelKbBBqr9W9bSOnbarETwt+4/K9oMuG80ZEgSbc?=
 =?iso-8859-1?Q?6IUzK1VTXYgBk9ydYY35o5MkKWKGY02FNrZH6ELY8jrsylfBNDckeUgr6R?=
 =?iso-8859-1?Q?mp7eyuck43IdZD1p8w73yHM5zz9WXyXBMZMMhpehTIRjehF96r3lsvBvHe?=
 =?iso-8859-1?Q?AjVE7Ef7CU4ibGoEC+96lbnWgSLXpAJyc1ZWWBTBg9H0HxlFZDYtgeug?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e2fcd-3bda-447f-6580-08dcaccdcab1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 17:18:25.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wl+aSQAYd12/a9KaJsZRj/RpvRTWOYb6Z0z8iWesO4uRiilL33QP7Qw33Sdg/ywc3oMVkY6nOVUaQ8tpFLS1DvIthFn4AttXkp+XpGmGco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 04:39:40PM GMT, Steven Price wrote:
>On 25/07/2024 15:29, Lucas De Marchi wrote:
>> On Thu, Jul 25, 2024 at 01:37:46PM GMT, Dragan Simic wrote:
>>> Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is
>>> supported
>>> on the associated platforms, while using simple_ondemand devfreq
>>> governor by
>>> default.  This makes the simple_ondemand module a hard dependency for
>>> both
>>> Panfrost and Lima, because the presence of the simple_ondemand module
>>> in an
>>> initial ramdisk allows the initialization of Panfrost or Lima to succeed.
>>> This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see
>>> commits
>>> 80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as
>>> softdep") and
>>> 0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") for
>>> additional background information.
>>>
>>> With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module:
>>> create
>>> weak dependecies"), the dependency between Panfrost/Lima and
>>> simple_ondemand
>>> can be expressed in a much better way as a weakdep, because that provides
>>> the required dependency information to the utilities that generate
>>> initial
>>> ramdisks, but leaves the actual loading of the required kernel
>>> module(s) to
>>> the kernel.  However, being able to actually express this as a hard
>>> module
>>> dependency would still be beneficial.
>>>
>>> With all this in mind, let's add MODULE_HARDDEP as some kind of syntactic
>>
>> Sorry, but NACK from me. This only adds to the confusion.
>>
>> hard/normal dependency:
>>     It's a symbol dependency. If you want it in your module, you
>>     have to use a symbol. Example:
>>
>>     $ modinfo ksmbd | grep depends
>>     depends:        ib_core,rdma_cm,nls_ucs2_utils,cifs_arc4
>>
>>
>> soft dependency:
>>     A dependency you declare in configuration or in the module
>>     info added by the kernel. A "pre" softdep means libkmod/modprobe
>>     will try to load that dep before the actual module. Example:
>>
>>     $ modinfo ksmbd | grep softdep
>>     softdep:        pre: crc32
>>     softdep:        pre: gcm
>>     softdep:        pre: ccm
>>     softdep:        pre: aead2
>>     softdep:        pre: sha512
>>     softdep:        pre: sha256
>>     softdep:        pre: cmac
>>     softdep:        pre: aes
>>     softdep:        pre: nls
>>     softdep:        pre: md5
>>     softdep:        pre: hmac
>>     softdep:        pre: ecb
>>
>> weak dependency:
>>     A dependency you declare in configuration or in the module
>>     info added by the kernel. libkmod/modprobe will not change the
>>     way it loads the module and it will only used by tools that need
>>     to make sure the module is there when the kernel does a
>>     request_module() or somehow tries to load that module.
>>
>> So if you want a hard dependency, just use a symbol from the module. If
>> you want to emulate a hard dependency without calling a symbol, you use
>> a pre softdep, not a weakdep.  You use a weakdep if the kernel itself,
>> somehow may load module in runtime.
>>
>> The problem described in 80f4e62730a9 ("drm/panfrost: Mark
>> simple_ondemand governor as softdep")
>> could indeed be solved with a weakdep, so I'm not sure why you'd want to
>> alias it as a "hard dep".
>
>The simple_ondemand dependency sadly isn't visible as a symbol. It's
>currently 'fixed' by using a softdep, but that has drawbacks and doesn't
>actually express the requirement. A "weakdep" works, but has the
>drawback that it implies that the dependency is optional. This patch at
>least means that the driver can express the dependency, even if
>currently that just gets output as the same weakdep.
>
>I'm not sure what the logic was behind the name "weak" - what we

borrowed terminology from linker and weak symbols

>(currently at least) have in panfrost is not a weak dependency by the
>normal definition of the term - the driver will fail to load if the
>ondemand governor is unavailable.

there are 2 options:

1) use a softdep and let the module loading logic always load the
simple_ondemand module before panfrost
2) use a weakdep and if/when needed, do a request_module()

In both cases the tools creating the initramfs should add all
dependencies to initramfs: weakdep, softdep and dep.

>This patch doesn't solve the confusion, but at least means panfrost
>doesn't need another round of churn in the future. The alternative
>presumably is don't merge this and panfrost will have to wait until a
>proper "hard dependency" mechanism is available.

hard dependency == symbol dependency. I think the mix of terms isn't
helping. soft doesn't necessarily means "optional". AFAICT this hard dep
thing is trying to introduce a "mandatory softdep", with a name that is
already used to denote symbol dependency. And it currently does anything
other than turning it into a weakdep.

Lucas De Marchi
