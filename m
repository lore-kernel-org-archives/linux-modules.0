Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77562374F6
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615348; cv=fail; b=j21voavtZVUXzOW7fU+sUqKw6vQPgn3MCOH7Grzu/iLSAlBW5Ir/7NPuW1yPXxf+7mtuGNDZhmHXP3mCjYXIhNvA1iyajcobVhnMOwDp0poD12op2Gy0w3h5yTHzrKAnugFG5ikK/FbvGbt+j5nOI0NXDGA05/30jCRooJVIPI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615348; c=relaxed/simple;
	bh=Q43QVEwp/JqaamCr+cZURciXhJwJyubddNR0aKmrK5o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TdiMWZhBHsRXqFSs+MhfZtGJhDJfclFfIJ1gYvef5HOGHoW1mgh3uMdT7NOc0EEC4HP/K76QVIxjCxZtcjfJVbjH85cMnKsQ8kwoiEZ351qeKkp48h7DZqodLMbCzse3CxN+kf3jVd4JYCM1wSJB8l+zLZFQlMqHAULErcaIC3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8NsPUvE; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8NsPUvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719615347; x=1751151347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q43QVEwp/JqaamCr+cZURciXhJwJyubddNR0aKmrK5o=;
  b=d8NsPUvEJmJpurFNDQfnMaLcM4MPe8aX83RMCcDK/H6m0pJ0gyJ6rU10
   u+Me+t+SdoT3f3EPpj1/c9A1tpT9v+ubQnCKojW9XzT4AsJQ/xsfkl4Xk
   vsKpRhV7yjeVBqreOhWqRG7OVCF1FpZepvh8otfgMIK9lQ3zJWE39ze1y
   QOInDaJ2VKihEymMuN+zrqLLXQAFt2iO4G9XyI+KsyQ0COcENzd85ls3z
   MOXef3PIwtBb+u/XqIxeq/z2hEQ9J6CSbPslHH3bpijLVoiRMDZ5KaS4T
   hod0jzqEOcOdqIu7NSJXTsKVWWlU8+/0kNMgJaFqifzheBBawAHkhkEvl
   A==;
X-CSE-ConnectionGUID: Fnb5fJxsThKI4fu540dsRQ==
X-CSE-MsgGUID: iKeTLSxzSCSCs6Ql0fG0XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16692859"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16692859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:55:46 -0700
X-CSE-ConnectionGUID: ctoZXRZdQy+7LJUp6ABUPg==
X-CSE-MsgGUID: WfKS+jEwTBmiu2r+V8Z0NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="75601254"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 15:55:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:55:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 15:55:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMQbZJc+40QqKGTPntmxpWJTY2JAjQI1EcmMnOpbaxMsLWXqY+wTr6e1AGOGkr3TgLlqWJ9sU+KRP4g7QNr/KDYkTQCxz11D2ZGhc3Ir6bZxQHO8AuJNqR2JuUK3e3oGM2tntrIYzMvGt3p/jx4VBcH+3BW8I1By5NiW3KHapLjF4abK9e70AQq2p06XwnLUzn2ryXIJpJDW9tumTftfsAd+Gbm+KMNj9OVi9ROWw5SHGq7pNJoCYyRbYyZJ7d68ysVAVn7gKHmKZ6XSBEXRcrRtY5spPiHD5DeYBNsNK/8lHKGc5EnNm4IRc4NvM5YIYUfvvzfOOhSggUIjYd63Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQTf0VpCLsKe5nn709Kt/yp7P84d3ppJB8SVOjPS+2Q=;
 b=mbqtySm1oO19WxOn/PKq7aIzNjt0Az3b4HYvP2R3Hyk8s4Q3j2yQXIY/zg6wf7tFalUkz2EGAVyRTt9cE7+cdpHucA7GUOOImoU6Y2bptojN7+EPR1Rpwn9pQBynXtV5B2u3i5Epk4QnT+ImTJ66hJb9d3GBT686clwRFx8D+O0Bg0hQT7xEVTpnsSYevUbRFEAIXjfXsMLcXAGaTuY6PIZUnzVDL6GuuyUT4XAlKMtTLJYB4PvhuyL/uuANuFwqJyLV5mmFKrRX0KeXFSQBW8ZhL5K2DU+1wSp2rk4BRYfiMjmQYNg6cJy1seUZBlSrvaeYPEHMoOlzGeI1DZ5F+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 22:55:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 22:55:42 +0000
Date: Fri, 28 Jun 2024 17:55:44 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 15/20] man: modprobe.d: document the config file
 order handling
Message-ID: <shaurahxpxijbjjdpgijgazcoez4fvycibxidrrltat466ebes@awtazf4yfir6>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-15-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-15-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 170ae20f-aebe-44ff-9e8e-08dc97c57017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LG3yP5f+fMdfpim2OjUMPWIZ8bDtklolo9MEv3ydXiE2UylMKLdu/2wiWlVF?=
 =?us-ascii?Q?BYQOQuzl5j1jh9dj0NJP68tMilFIEWkkvBCnJHlj6gKirflB1ODhC8wTxMEK?=
 =?us-ascii?Q?PPQUOHXl911NklHUGBtzf3MRhjudfytZQyalugA6vxZmW7o00zvKiAwpEuF2?=
 =?us-ascii?Q?iR5CxumP2W/FgJH7eVdgBUZaB9gho/YwI/byWsMcCJimyWtB315GzU1RKsZQ?=
 =?us-ascii?Q?AHCeC4AIjL7ezwrieCXHkMtW70Ls0Qb7o4JL8L4igXLTrgs35kFlHPha7Ay+?=
 =?us-ascii?Q?bUdZ4zgmBzXH9OHGNiZeXZHvIe5eMsstvZkiZqHb67PG4PZCF9cPP6cBmSSN?=
 =?us-ascii?Q?4emKYIER5ahFHtVbP0kt/Hz8kVkdkoISnLuJbxiOicmG5HBkBMNpmgQL4GBh?=
 =?us-ascii?Q?lobx+5fcRsx2QwrnIMHSwWqKJlF58sO3nSMGfmIxpN4aY6v7VTf712Ut5avV?=
 =?us-ascii?Q?FWFOgJFgdauS292f1i4n5jQPRS3rZ/Xd0RvcnaXQEWHU+C5sbxshLZzxjxM5?=
 =?us-ascii?Q?KHUZ5ikB0H1t9t7DTXlm54eC9xkqbD0YCsmUfE+tukrDfoLp4hMUrkwzrLb8?=
 =?us-ascii?Q?5IlIPsY22pUxKv1A5kjtDbAguTIjJtJUQYnCy3CDl/mIjjNUaOXRSEVqs+kI?=
 =?us-ascii?Q?x5Exh+B5Kfdltxzp5NOE0B6Pc//tx8xCVbjH2S+tlIfP3S45F/rl0sLy7HxY?=
 =?us-ascii?Q?HzyR5RcJRR+vXC+GYFSudfxsrwIkhQw/W+WFOcxIaVqB2Dq7joT86gnNbxbA?=
 =?us-ascii?Q?DsYe5gL4ZYAgx1H7WIQy9AxPfn4Cu1/h3C9vuz9hlB43IvQ3ONfapc+rTt8C?=
 =?us-ascii?Q?e7M45rrDu3gj5za1JwbH/NiAtSCOBuCAhX4ko6TUYZuPefLnUGQkFJDJVrGI?=
 =?us-ascii?Q?7F7yDVhSOzvrRxnvtUtpQ/GQZz1Nih5AFB5OYthoKn+LGweT8nVlyM6HeKaI?=
 =?us-ascii?Q?o3PZO3wmhQzfxeGjme/HmzGCgt8biAQrBQmk1GOXvN6C2RYLikqiN790oKUO?=
 =?us-ascii?Q?Ln33WE1Wp/figb4KdDHBQF9GVBRa31F6ZrEtvU17Qk6XnPLbNANRuThnd0s+?=
 =?us-ascii?Q?cdfKZipozvhCSoITl2hW0oE7X9ST8qOD1uN+8/Gv87vEEq1q5Zd1ju36hZMy?=
 =?us-ascii?Q?upvS9KKsUWTmt0puoeLWNjAAQHYUb+ihYNgNLOo9Y710jlvTjX5u6VcTHLop?=
 =?us-ascii?Q?JY0RJ34H/63N+anr5jB6Ekz3RVuC1nkE3XOXUpIPL0Pid+EQPaA/V257XN7c?=
 =?us-ascii?Q?Ay0QlYeMaq9wltR4uGiH5ym2+QBNsut9BYwb/vqUaHVYIvBCKSdv2tJhbTjK?=
 =?us-ascii?Q?K1C7SU7CdOR7O+Tu+6j4HJPL9RZPxzBDojlYwJhWJOp3/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T530rNCXEIYcz9JRyi2Ukp9+n9lenvwb0hSH0frONkP+VABHunRQI/AVgJn2?=
 =?us-ascii?Q?2XuP+Wt+vmd1AOgOR1EehUSHkMfvW7QPz/QAKmf+FUDdL+mE11EAkwW+PY7f?=
 =?us-ascii?Q?Vi+OrWWKTKu8D0iMeTUPNDUJquKb+Kj20Yy2JsBvOGDfKjasoGnEnGFHBYXq?=
 =?us-ascii?Q?gXHBAHdCj6SWEYZg5sMa1dEujNyum22l7l6NNRN32aPuAiVMBIbFFulMjiEs?=
 =?us-ascii?Q?1IROkgCRUfHdQqV+awBt+2pW0a+G9GM1E0IPAAnJ7sl4mlj5oo/fNHkfutqp?=
 =?us-ascii?Q?LvHuL7j/IqRNOettGuKJ7VMS8LyjPEMm5xM27TBqGnfoQmV13HDxR9jvrJPX?=
 =?us-ascii?Q?T6wsR7fq7gCaSXKE0R6yjy43PPQexw9KK7f3bX46mbifqjNbAsygbk9ywBW4?=
 =?us-ascii?Q?BWHgWH4EpdQiQZQf7n/JHLYNqVpJkJfQz5vM7hTnlyCMziYnSRROzXTg5RDM?=
 =?us-ascii?Q?8qYcF2xHBxVTnNjEYqe7QzefpLU60Pg+mK6fnwxuDrjiJpjXSwW+Qc/O0A0b?=
 =?us-ascii?Q?b2id5BAsW2WNbTSQ1yo6oMJXhlkR5/VD55z2CYTI+cuCYYpQjdp5+j+miiI6?=
 =?us-ascii?Q?7115pQcoiwvVYBf2wSd6iPlsjmFfd3n00KXKKNfQx6T20xQiQSYybvORj51i?=
 =?us-ascii?Q?S3GnOPGJUBVHU83B+22KCteKrFWB7/edgBnwOFiJIdmSl4Hs+/PxFvJJBYLb?=
 =?us-ascii?Q?tr506PkeHmxswhyaLb/Ys5FGSz8mDF5/DDw4y470TDsk5eId6rFgWXFDrwsD?=
 =?us-ascii?Q?W8GVGkXv8jpAltunDJExtr5o72b1eun2VmKLyloRrr/5lB2j+E4gOMuciZLW?=
 =?us-ascii?Q?Ltm8eJEbd0DmvT+GcgdPzKj2z+1mesEGYOHCaBW3WYuX3c7DaeTHdCXrnpWB?=
 =?us-ascii?Q?4vE9t0OXXfDsiH61fYnf1vb7p9VVzZ5Su6bDOLLhITg5W4A4sX8Fham+NRJT?=
 =?us-ascii?Q?9NoEQYYuLrS/tDSWjoQTKMgsbj1MlYaFfzpGt8McqjHtgum4xrqpgRqj3mjg?=
 =?us-ascii?Q?ym5cJcnEpiqR20TrS6k+2/8+XmROcfWd44/dGZBkjezMpO7Gu714Z0QUSayM?=
 =?us-ascii?Q?ln9vCKZNS5nRL4OEX5xWblpAZEpvQj6+mhcvP/nGBdjQE33/gcs+qbMB+Zck?=
 =?us-ascii?Q?+nRrZfuCd7hO5ORzY93RRvskkI6C5RVHRfWfa9IIca9Bb1FVNKfSrVnAC5ys?=
 =?us-ascii?Q?PQ6RCtClUlANAg6jHmhJu171j/AevCy4R0kNB04M/RLNvHxkp6qW/RjF0GU0?=
 =?us-ascii?Q?aDvPKptoPMjtE6rG9cWZpgUagRaw4N9PzUla/DF8lIiX/vTz42iD9jUg/lHf?=
 =?us-ascii?Q?D57QR7f1Zj6dLPn8twY3FvVuayEZUXnsEvP5jEOFI1hNtv329nTk9fnJsVyG?=
 =?us-ascii?Q?HnDZuW4VMMy00rYkQeDfnrqQNrk01DOoFfnSCeKhidqArH2qSSdd2EAS78k7?=
 =?us-ascii?Q?b82aKZ0IBi1o4ix7vz/cso5uUfdCnvyzh41zOR8xa6NGJGmKzeOZv1wodUK9?=
 =?us-ascii?Q?54H8lEi+qH9gzG9EeYdj66Z8cuxy4Ge8bbQrHht9zEVvaP2UN8iHbFbKksJH?=
 =?us-ascii?Q?cKzRwNt8HxdCXUobfuTM6diCJ6xHl1mpiAE15j7e80eu3cG73YbWpxmAtHop?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 170ae20f-aebe-44ff-9e8e-08dc97c57017
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 22:55:42.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zOM3aKnRoE707SAsdWES59y2S93jQtGOF9H+kg+mu9oxKia0onNvRX61xE0AIAtPOSvQiSN3Vu4xGRbZ0i/33o4rdw8AP4H3En6+s+GetI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:15PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The modprobe.d configuration order/handling aligns with existing tools
>such as sysctl.d, even though there is no mention in the manual.
>
>Reorder the list in SYNOPSIS and add a bit of verbiage describing things.
>
>Section is copied^Winspired by sysctl.d(5) ;-)
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>The documentation says ".conf", yet the code in libkmod-config.c also
>permits for .alias files. I haven't dug through history - is that
>intentional? Should we document why - in-code or manual page?

to retain compatibility with the previous project used for loading
modules in Linux, module-init-tools:

                                 if (len < 6 ||
                                     (strcmp(&i->d_name[len-5], ".conf") != 0 &&
                                      strcmp(&i->d_name[len-6], ".alias") != 0))
                                         warn("All config files need .conf: %s/%s, "
                                              "it will be ignored in a future release.\n"
                                              filename, i->d_name);

And by "All config files need .conf" I imagine module-init-tools was
doing that to retain compatibility with distros using .alias or because
it was also using the same logic to parse modules.alias from the kernel.
Not sure.

The oldest commit I found referencing this in module-init-tools is:

	commit 50f21358cf9937906f42be1352ba2b588375a344
	Author: Kay Sievers <kay.sievers@vrfy.org>
	Date:   Mon Mar 2 13:59:29 2009 +0100

Before that, module-init-tools wouldn't enforce any suffix, but filtered
out the known-bad ones.

I think we can leave that undocumented and maybe 15 years is more than
enough to finally do what the warning said :)

Lucas De Marchi
