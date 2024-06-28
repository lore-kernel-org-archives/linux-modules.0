Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B734DA08
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613633; cv=fail; b=BK9153qZ/dAk9vdBpRGxDJ0CoLGhyaVVOsmntVgW3Hto4gwzkYHqns+ZImrntTgftstw0P4KogKEIzDrwmi3iGgg6429nQ0xkjDiBPJPHHjYlVk/M/W0hfWT0KmXHjCl5Y4dMCuKlmf0ftQdLNWt+VOZ1J3F+TgtBVkLAmGo1Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613633; c=relaxed/simple;
	bh=Y5dQvdlTtBg2RuiMosJi8Tp+/cVDMGu1SHmWOJ3z0zo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhPBYCgjWfIp32RnzX+Btff4/HplqVhxyeBOBWLH0/n1i8H19iTFHDuqPilOf7+6RVqN0/tp6PphBgBTbqgpA/GrEqif+9JZCmJ27z8C4GFMn1QwSc01QuJYHNeFLpGo6wo4+xrwBlhrwG//hpkpbb0plB9BZCmx4DAyDzrHNV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgfAcM6t; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgfAcM6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719613632; x=1751149632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y5dQvdlTtBg2RuiMosJi8Tp+/cVDMGu1SHmWOJ3z0zo=;
  b=JgfAcM6tkMfB/VECyFquuD4i26gfOKOxL+TuhF1RwYbrO/EVi2VakKVY
   nQ9z+Q1w7yjMBXm1wAUOeQFgPiQL0PHke1QNygLCnalmhuXZtHtW73Ai2
   oSNGK+sLwdtm0Sv4ghy5BGh8dPLklZp7YQvWmzuNFqM7kPpLb4E1LLsOa
   omHRd3gJUiN3OsPErl5gegIc7xvv3oziKwqS3sWccvjITVCAmBHYYn5u+
   gXi14jEB4Z9Xouu5pqDOXvM8Gk6Mwh3N9dQvHMCq8h6DaY88RDXW3nZ1k
   uNL0RB4nOMVmxB3THDPMfISWDovNw/jPlTMHRJbzZk2F4baW1wdwK4u7W
   A==;
X-CSE-ConnectionGUID: 1PYCHDQBTTe8z5DX1BUKQw==
X-CSE-MsgGUID: zuaF5YJNTaq7XJy8W9mnuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="34252258"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="34252258"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:27:12 -0700
X-CSE-ConnectionGUID: jua5d9J/SAyRWxFgKsFmlQ==
X-CSE-MsgGUID: DAhYEig4Q7mIQ5i0j2Y33g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44990573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 15:27:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:27:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:27:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 15:27:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiAJ0mcOER+TlqpX6m4/0BmFojTyd/XiTHFL6DALja46MxxiDeewz9He/sQSQbXSmowUGVHPDitHURnP+a1Bg/13VMYP7THbzBr/4uqPnoL9hZatpx8MUDInz9JwcrcaI1Udi9QzEi2c+WUvsHk3C4L1bek4qzl/fERlIi8NKEgYII46zmLivpga5doKIvvZc9bgBUQE5uRzouhgxgnm4tjqH5HDM9N+EYyhCL0/lM95PQA6omAcz9DDIbJj/n+mtCZhAGfmMziZN9jPSPTufXYrc1X+qEB+IC6Y/e1U8xgMyerxy3FDkp3voaQKf7d9JHypQ//yDpkoIQBaaQ7T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GanJ2E8N85WHsJHqj1LL+H7/ZDK0EGSuIi5GIiHb/Es=;
 b=mJPzeQ0NA+RmWDodmhLg7k+ZHWhVbLhVof4bAc6FLcb5/KM1IWyVCsgHYwo3PH3HzsNuP0nQt2aAVk2Ld+w+lRZkQ1XyQgoiBdqbSt67cyCMzY+TpUw+w+OXYH63YDy7ns1KjWBih5HZH3Zr+wOdkAEphfvjtDJPhVwPNBN0Ge2pLeGuchh2m2YeXjFN3zko2CG4V9rC6L/wueAPhqTuDjmsMnWtDKskvXkGnx1K+F4hpgEQyYhJbEfjQDO2r20AR5rRWry9b2+4KwBJwlhcUsN9A/GvYfa8NZEmiVwXMvfU2I+WOhHofgPApC0iQYY5wIqGuka2H5+ZwUnotKxHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 22:27:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 22:27:07 +0000
Date: Fri, 28 Jun 2024 17:27:09 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 05/20] man: add some extra bold/italic annotations
Message-ID: <zfgska4tdkbpi5ml2fgg3k4bs3gxledfek5jgoetnk24srqd3d@o5grujvkszsn>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-5-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-5-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:303:86::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN2PR11MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb6a60b-2c44-4c23-8ccd-08dc97c171a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ndn3r1v18F+fJZCvMXBW0lRQoK5lbhAQ3o9Jm8tXeFXy6wg8uXml3StdPAj?=
 =?us-ascii?Q?p2SvzNOkKxNO0QQAJFb2ilV1XYDz+frHW/JtqJpmixM6X9e57J89A6r556Cd?=
 =?us-ascii?Q?fYPGTsAfIpsA5XZYJb80SpIi0IUsgtu1U0DHMIRujqsVdf43XiN+vH1QWIcU?=
 =?us-ascii?Q?Ny91e6QVOReiSNZr+G4gq1epP+uvyoTXB5fI8KijjyTUYp/eMn/+e02MxO4Y?=
 =?us-ascii?Q?tPSbsva399Y2oiavuvCwkwnzyja6+CTVVksC1Uj1FAt+bAxlB4bcMNP0/iKR?=
 =?us-ascii?Q?ZmGHLojlA6vGs0RA0rhRN6vZAJu7cWBxALZSY4XQ0Gbcg+j8D/s40+fS0mk5?=
 =?us-ascii?Q?79xt2PpgizbAAg3X50+l+N7RVw9P4deryKxIz6WG6AEsDecXmtB7TgzQm05q?=
 =?us-ascii?Q?+nT7GaQmTNEeAO7VHzjc6UC94saXzrB80vaFaKEdVhHF8VNv8nkX3Hs309hu?=
 =?us-ascii?Q?rYdh/45Ve4cnrAistc+ljINgN+Ve5XPowXXBZ1EZrG9EWZxqjcJHknNnMveI?=
 =?us-ascii?Q?8kgfyhpoKE+KkzgcQGh87nj2BezToC6So1AveyLL2mNJdZBtY0E3ipEkDKT3?=
 =?us-ascii?Q?oqRTLdczrXvBNKcXcQEF5gQq962+pkpUWTaqkZiC6yGfpanFFslTfGuLDGSi?=
 =?us-ascii?Q?9y76T9V93J/LMA6x2Eq0/hexIW4wmSqyBCkgnNeMpSAFs1nH6uTdqHpVIOkb?=
 =?us-ascii?Q?AreEFkI337pXiCWZ8mOjDnEgNd0boAuXYhtP9LibaacsxsxLojipQkL6W45r?=
 =?us-ascii?Q?bMoqhiHQkzz8WaKJ4zCq2aAKd+AHVeiSSK0ovQKWp319sUhFOIMs9RvODmZO?=
 =?us-ascii?Q?kGQUhClOwu3TPaLvvh79MKhtx2iI2Vtl2Y0TgSSwswsI6ErbsP5Ivh/jUtfU?=
 =?us-ascii?Q?fNeqhbNXfHZlZQCzDviZkSs8vQfDdqXiWSrOiAIkU4ptrcM90rHiwgXdvXdW?=
 =?us-ascii?Q?xJ7pHN8hGVGKB4iMvLvnKb67eilstaCWsX3AFPGEnsrg2DIBv3naBhTsHFpF?=
 =?us-ascii?Q?1ln1aNXuug2pQmLpNns55ZBXsvZmEcia3EezCb4mVW7f6sDK/z+/OtHno5JW?=
 =?us-ascii?Q?knzp+SyinsOpUEYpvDDGEmaJh7bQfMKKjhbgg6uqE+aALqoqm+UJGVe4s/B1?=
 =?us-ascii?Q?1B2uEbMLsgLlZ0jOAfWZyGp27T7+uKWiJorTJohqKI6HVEoGuNNsHGyKrz11?=
 =?us-ascii?Q?0ArP09wCvLcjhYMmKJnK7/7tABWAZDw0ugrzGm0fvDfz7eGXzjY3233tEBEv?=
 =?us-ascii?Q?Ffu7oqYNYGz1fKUlEKGwShRBwwQek4prZhDQwiQTwkCoUwalvQigbjmJPu+i?=
 =?us-ascii?Q?GQUk0wCQUODYBvRHfgWh8UK+P+uDv10MoLh3z81oS0Uv9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44xKPaI4sg0/9MU/eDbsUcAFzHRoGpb9I52mFEjYgrs+qqg3kVvC0H8XJE5r?=
 =?us-ascii?Q?ez8Nzz0HM56t6q4NaySm/N8sTva7Uves1uLUCsJKgD3R2LPJhgZHpe3meT3g?=
 =?us-ascii?Q?8TkVZQyYiv2fRztEVwDiqWzi+BZlzyUMbvSpnIUNLgfZSZQUqoBf0xd3Ysmx?=
 =?us-ascii?Q?3Zb4DhlJ9UGfgGbNsH0eefaQT7W8aX6CIxbESHg8Cul7GDTV1MMWHGfUqHkL?=
 =?us-ascii?Q?6kBvY6UGrHvkcF8Wvf+s5TUCQ2wiB/kI1fgcT3juFGTpzrRu1J1HbmCgjnuo?=
 =?us-ascii?Q?BEYUndT196aWUZQ/nnOPa5zJF2gSNudGK4077qCuRTYtQCIb2naVRazSpB32?=
 =?us-ascii?Q?wJrU3lSDPHORxF4b6G7Kiia39ws1IZT4PMUKeRaOgc7kbLr7aOCuFuKzE+OE?=
 =?us-ascii?Q?UFHuTqaThKja7J+IpeD07prSxM8EkV7ImHShj4MbQ1GSjHcVLcLj4SV4OTHW?=
 =?us-ascii?Q?nY6sB6iqHoHU5QlpFJUH7InTxL+vHlsQDecGxkj3VGJkEgbysR0qmZOqnuMZ?=
 =?us-ascii?Q?FL6wmYhyosYUxjVxorfbbakEhkpcTHaOkUcXh9T8SVTWtVdU41xFYHJy65fD?=
 =?us-ascii?Q?3Pkj39ISA6o3lqomflIcg9PRMf8AcxrwkBoy/S1K0tWuzIjjTHdBhMtY7vQU?=
 =?us-ascii?Q?l4WFrk/cccFZJnrFt6acvHn/8OsJ+o+LAqTgWK2jpqu04jPBMSajdwQmktP7?=
 =?us-ascii?Q?L6I8po0DwOkjrRpElf1xeHZFCy5j0bQRobNTriZV/j5mo/Z4Jn9bI/3HaxoD?=
 =?us-ascii?Q?U69rgq2g/Vntgg+aLGLGNoK4GTDkHRI9ut027JQsG2e88mOb7RYK8otYzju1?=
 =?us-ascii?Q?QgySa99IC12npzSEXp9gjW5jQUVnaLXmaJT1TeSbgUdU5ZnTxeeFi2zkx4y+?=
 =?us-ascii?Q?W1Fvy6jEtL57pHHAL3f7B1IQutcsCtWaKM98Zt7GE2iXZoSSsKBx0qdSmvpl?=
 =?us-ascii?Q?ubOihVhySuUo8Fae3T7k4l1W2+1sJXzXPJKHPqWSVBEGBJa+PLKgfOtAJiWo?=
 =?us-ascii?Q?qHGrpQ6I0Gam4JlhXYRj0IyVcoz1Mprw0Pab7pOSIlUvXW+QffKc3sWgMvEj?=
 =?us-ascii?Q?JHXvx9Jmsf5/SBHHXbMoADn2jx+SCpGgbmoU0UCzDYQuy8wXBe2pqdmzUwj8?=
 =?us-ascii?Q?UjHX8rMZtb2yBsWkDAw4JFPtU0Ml+obqnSvCKjxARtVYa27EQNHdwRD2rUIH?=
 =?us-ascii?Q?EGCAnl+bnaFmg+xGt727P2QmgZSizh/KBqm/nR91vCkG1GUm9tlpNZNvqxES?=
 =?us-ascii?Q?XlLzwtFKR7dk20+8uwIpm1ARofqCzTODU29itKsydmgGFzLjPjdrh0jw8bIA?=
 =?us-ascii?Q?0KE6wcambIGDbgvJBz9/U10cAlLcKzGfSksDEO6qFsH5pvIL+sOizAnpl3wu?=
 =?us-ascii?Q?4Yk5nepIEiWCwWoAjWzG5Hf4k099gdEnxsdwaufMCmEKuYwwMDGc5sUkp1in?=
 =?us-ascii?Q?9KkiiOI2ZWvyTl6/GyrPlVAbVr+Q7nJvMhbX3eF1u3oXs8LACIsILV5UAx6e?=
 =?us-ascii?Q?jf8iAokW8NoyOSfC8YmCscfJg3BnXZdLG9ds8JeuagbEvR+Z9Z5F6MdeFLn9?=
 =?us-ascii?Q?l8BOuqodJGwqpi9dmlzKIzv8r3OEESRHPo0HWH1fVWlTBoqp1561q+Ed6VTq?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb6a60b-2c44-4c23-8ccd-08dc97c171a1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 22:27:07.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9oIBmQELJzbo5iIV0Pvl53L1yrg3szYZRJxP8/qYQsv5McfkyBAqsKhMNXY/JZSCl5RxFU6onNKUHoT9jtpnRB03QJp02vAsfLRsM4O6Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:05PM GMT, Emil Velikov via B4 Relay wrote:
>--- a/man/modinfo.8.scd
>+++ b/man/modinfo.8.scd
>@@ -29,14 +29,14 @@ architecture.
> # OPTIONS
>
> *-V*, *--version*
>-	Print the modinfo version.
>+	Print the *modinfo* version.
>
> *-F*, *--field*
missing
		  ^ _field_

so it's consistent with the rest?

Lucas De Marchi
