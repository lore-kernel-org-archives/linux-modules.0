Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCA1FA859;
	Fri, 21 Feb 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172106; cv=fail; b=Vi7rEBJUWyEDRgQ+NVYNNUdeHuYj105cYEYst3VECR/JmdnRNGt9rhvXS1ooa0oL1GgRNdIT5ByERz2BN7olFeykAqBa+0kyTwzvwUjzpIy2tvMqN1u8PYM55LsnZtPEbPhnadlSb45OC+bj1gCNpoNYTHGpz3glx6lxgM2/4nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172106; c=relaxed/simple;
	bh=gOHYZoHxPES8napTvciYWpCe2OoL5XxKVRd4BP4pVmE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=V7+lbfJkyoMVTChW7TbcBoyuZiY9i7tP22x8CcYpaJeeq1vdj+ZHR9EO9DWojxvjTUrdDYcgcccqWe3y+eNnQbirPnEwPnqC31lughTyIg0+10/mR167zDdVleJVnMUIyknFTJHWJO9XbBTNzFaxHTwO+o+h2JKrZBTTMzdMaKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiCMlJSl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiCMlJSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740172104; x=1771708104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gOHYZoHxPES8napTvciYWpCe2OoL5XxKVRd4BP4pVmE=;
  b=kiCMlJSlEQt7zSmHXnSdQ4wn0pekDXVXCLqNyvXHgjl8R5xByQpe2XWC
   tNG2KCDW0et2kJbiep23gjkWWCe90En9Pw5QvA5uneDTvNpg9ryFqlodS
   UZ3rb/yxu2L6BK0l/CxCvx9kxUVgiAaT1YKqsVUC/SUUfW99ksflQ+IId
   CiR3p2dpMJGtXGQlYczWARp6Y8jQf8nGqOibv3be33EUGSA7zhlppInys
   7PQrRtwfyCUaanCuxSlTq7Wh/H0Lvc128kIvdb0ljpdNV+bRK8grSSQS6
   1y6l7AgoyR7gJt/Qa5KDQT4VJ2KEECVsduqD2Jqp3yqRTlmKG1KUX2H81
   A==;
X-CSE-ConnectionGUID: hjbIpHcpR2C/1IVkhvpw+g==
X-CSE-MsgGUID: KLLWg8GkR7uWrPKTuDfdYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44652806"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44652806"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 13:08:23 -0800
X-CSE-ConnectionGUID: m6bEXxbfSM+93UhJ2a40WA==
X-CSE-MsgGUID: VmF+ur6DTHaHUNy65F72Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115674303"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 13:08:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 13:08:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 13:08:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 13:08:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7S4uvb5Soiagp8PNBo9/DsqxQiotmZuqpfIQjK9o5Azdfyk0xk1Uy0/Lg6Lkyt8tu7+atAsNrIBjCuVqf8Y5EYVM4958LlcZHQom48wuZA9yfO3CgVYvWDbauLykb1ClKAXAC8Mh1DiNqw9kztZizvcOwug9Eos85sl7c/SEA0EjDP7g7vNkUsvn1pMfjxtX1Nv3OXRKfweVNJc1Oioc7z09Iv7NEQ27tIXGQeD8yzkO3P+sccJVuJ7eW0GThNbeXRequBvhM3nbNc/FCjX2eyKGHCzqGy/Bj1vqYvX8PP0GkJSnobxdIs11K0R5T4o5G5+bFyyIwMfeXPeY2dD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbTWAtavOrRWvknEw1Ev3HhIvjtYpyF8v7g5RkygzpY=;
 b=S/tIjQJBrSlMoJcWEdNx3uxvKgMyQAwlhRH/Yq8gtlZiNHY0kLfg4fDfXCLp8X5a27vXPDnmiKxDuSa2MRpOk2rqSGyXs5/I2guBMnjxc3LDaCsiXKutHKBHbE97bv+2I+E+xbNSByAldghh+9ONI1ZCviorM2VOxcXPuOnH+nvzQ0iFtjEJDqXfBWQh18RChaRi792omVnYdLkRY2E1vmkvXicWi7d027scmWgHxsiqcH6I4YDfngycex/gg05/MqyfgvWKlnk/I8fqqnBxwSWvW9pelAOccHm7ctgNtzk4Y2hAY+b/9jC6k5zmKJv4hKGo9GIrYoSe0NAWHlo/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 21:08:06 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 21:08:06 +0000
Date: Fri, 21 Feb 2025 15:08:01 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Emil Velikov <emil.l.velikov@gmail.com>, Tobias Stoeckmann
	<tobias@stoeckmann.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, "Martin
 Wilck" <martin_wilck@gmx.de>, Martin Wilck <mwilck@suse.com>, Michal Suchanek
	<msuchanek@suse.de>, Christian Hesse <mail@eworm.de>, Enrico Joerns
	<ejo@pengutronix.de>, Grayson Nocera <gnocera@purdue.edu>, Max Kunzelmann
	<maxdev@posteo.de>, Sedat Dilek <sedat.dilek@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Subject: [ANNOUNCE] kmod 34
Message-ID: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM6PR11MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: 937335de-5dfa-41f3-b928-08dd52bbd666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vuTFDQ6I7/zmnGmjMNOopqiRofsgPffFKzrHmPc8xjDmShEKckBC9hz3ioI2?=
 =?us-ascii?Q?V+GwbQw47iBF/nPwQI7y28twJEi1QKLCfd50ePRTZeek4ABpboJXMhj4hgs6?=
 =?us-ascii?Q?PqjlUMDFAYT8QsYAhYfytxT6yWAugqlmB9h8hdnTICMb1Pm8OjAOvHq/vAhU?=
 =?us-ascii?Q?StIE4n+zOy5NkbkkfrRw+u2ts1hTPWs1zspYVOoQ2lkC79sLyF5rRrWzw7zl?=
 =?us-ascii?Q?9wpLWdA+tqu53rqOJq/67HgxVxBrXSpaBtIy2o2HSqJlInwZK2KFtjA894VC?=
 =?us-ascii?Q?mLMACQjTE3jkLUtcgLJc3wJ+O02EUBNpafHzpYADcyyLVw0+HnnQOvrPhhsc?=
 =?us-ascii?Q?FI/CCq5DOgKSTvphdIaiFrxDDbFHGtozXlpQPi+Eb4W9glp1HQWSnolrXRxu?=
 =?us-ascii?Q?W9di5kWBM4wWnpEe/+9MUmFSo8CNrupnSb8OAiU3Rk6wqNeQFm0nHDRSGWRZ?=
 =?us-ascii?Q?xY44v4Ar7/b0BLrHw5RJ3pInlwbSDEjLBIHj1OxEkqhMJI+AS8mtu63dFtNN?=
 =?us-ascii?Q?HEQVtj44ogsmWieqmmC54YEHsUcv+PglhEmOaz7pazMoRwsGvEv41/aQR+T3?=
 =?us-ascii?Q?sMKWNgNu+ujEzuqPBEwYqLk0LR7V/8GWg/Z61zlag4pQb7vhoeyc4zwkNhmn?=
 =?us-ascii?Q?P1TB9V1AlssAF7EExxtxxt4c5HyEg36Rihlge8IQqh6N3Iw1nyWsT2TaviSe?=
 =?us-ascii?Q?dCWY49JccivUT9cD3PMlrkP2KVpcJWfvjjNyTG3Y6aYSv8dlaVNwSW64DpH5?=
 =?us-ascii?Q?8IiYZIlyxHQ2WfcocCJ/WHTJ3HXXzVt3/+MAobiLYS9H5f+Frp53i7quWDPM?=
 =?us-ascii?Q?4GHHlPVZf157uQw9WXJxI+ZBRORZjBnCfb8neyNwH7itZ5a/J/F5hZpMQcKu?=
 =?us-ascii?Q?RiHwJvskk1ssYtdcvHkdpJZQ/3OK0kGtIRVQb3LyiXtBhj+trXIc+iU0stM+?=
 =?us-ascii?Q?rjnSOmnM2Baob+eljjeVabC07rGeaIgXnCuaXSVpIsQrAHuaGULgeR1vdSXE?=
 =?us-ascii?Q?WE8hW0SZJu2v+mvwRIwdJ004rMzioaGan2CIgQLWV6qvWQlH5IJCIrQPWxsT?=
 =?us-ascii?Q?1H6iuSqDbgT3nI53pUrirW/PwFB6bm0v0DSNYjz041rYndttXnVN64BtrlJN?=
 =?us-ascii?Q?1udYNkHSalPLEs1qywZnI8ATqv/B4uI5g/fo6xekekpPoQXsFRWl4CNQinG3?=
 =?us-ascii?Q?BiAjK7zASfOzcQ6s2odkv4vF07t8spHacK7ENqe6NbYPxSQwIvo8tHZ92aKO?=
 =?us-ascii?Q?s/uVE2YrbtNceZtwvvQDNktLTsk+Ui8S6I58tkwShsRq4T7x8UuTWr6y5Pl8?=
 =?us-ascii?Q?cBhA1t+OJUy6pUd5TqYcVa9y+ihjd7UOI2tAIeFqWIwf8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LXi4MVdevlgNaXB1RNoH7fVyln5MU6iuDp5k/TB9jzfV/0oM7DXLTpd3lF13?=
 =?us-ascii?Q?WxAxt/xBfQa3gpZzX2IXCoaRZtgf+fhFxObEQNhPD7f2ifw0F3WNVvwZLC2w?=
 =?us-ascii?Q?lx5ufCj4Qlif/TGnwy5LcFgjyO45IBCcbdKAfIDk9GOycQc5RY2bgQ3vTfoV?=
 =?us-ascii?Q?apZtfCs7oarsOWEIOpDVssoPEl9yYCAiGANyTdCLDeMjaLSJ914F+7WZbcwz?=
 =?us-ascii?Q?Y0CFio2HMGk5wujVBFiamWnSBkO1RK0viGaL/Uuibx8qRR0YZ7/xwUER3sAx?=
 =?us-ascii?Q?7u6y4h3mR7nzMCs2AzZJv3myTJu5FUFozCHPCN+429rEenHjJzqQ3ZF423gv?=
 =?us-ascii?Q?AWOZPG2d2wI0fVkn4LvQ1m3TAAwtxLrHCKsrvGmFUj2ARdHEvxzeUsibaO4y?=
 =?us-ascii?Q?HV3dCzrkBHSlWdgz0AtQeXHpymOrsss5vcGyaDiB0nMHmNvMZclFknji6rXw?=
 =?us-ascii?Q?YsmwqOevVsc6/Z0m7qukS2rwr0Tl/RizNh6qvA3aJ+tUfYqUGlA/dl/dX1W5?=
 =?us-ascii?Q?VBgB7zuEuC4ehS/1ZaCpKWUb1Km35BiwfHbEja+iKtLfZ34vQl200L6BCGWy?=
 =?us-ascii?Q?fqyTALloWxqfeOq85jBR1aoDyFiQzuDot0IrcdTnFk2pu4QWxK9qZp2RqLlY?=
 =?us-ascii?Q?e70zv1uOr6UOWHD/Kb30PpGIBkuji3VH1hM6M3fWRKYnHBwsTLcCzH8UAFCl?=
 =?us-ascii?Q?jr8XqCv9NMM+wqpz5pVEWtbh4jYt/X2Z7t4FKQmSUaHAHHgyBoTCtD1TCyGd?=
 =?us-ascii?Q?dAtWSO+ZyXa3B+ZAHvXG0RrnmoRuVAoSF6G5TkXscfvu1HSuKTR+sLl8ViEg?=
 =?us-ascii?Q?LPPurnEWjzYak/yNils6Z64nK0pT4ksAjn2u8gfI9nlvBElFGV7CMKRZgMlY?=
 =?us-ascii?Q?XtJ72e6tL8TOBBrgPhn1K85W66Owikgcuxh/Io/5FV71tg+fT0i84zJ/cLT0?=
 =?us-ascii?Q?Ob9dBUUFlPtzBAbz6H38EdHdV2FsQ00AjIlpJn5azbfzznhTFrlYiHf2Sjom?=
 =?us-ascii?Q?mXsE6BJ4nBK8LM92ck0d1C3oHudAEYq+/47SsIV/KaDhMNeqxG9YyUB2B8Qy?=
 =?us-ascii?Q?cL/6DEDpkqdqqOvKdRYVctZS89ApLRkxOBDs2bnrKkiGPfHgroeaYDUxEjp8?=
 =?us-ascii?Q?B0sqU+mr/fc3Uz0v2rtmT04G1RUV2C96VWPcRA2ARpHhtaPjRkwQP88atML9?=
 =?us-ascii?Q?Y1v75b5UuS+lV8d2iJjcN2ZnpSiyxVHAuMX5iDNSFSF/wtWzuZtdUKPsj/dN?=
 =?us-ascii?Q?Swt3E9fGDlQdSeHtJIzN9OZF6QKwM/TQ6fRupX7C5H+9FQsq04kNpNi8dTsH?=
 =?us-ascii?Q?TEEr4YF8KhShO4RtvsM1yPv06v4f4OdSPbetW3RyBKzI7fY/dSCACTOZlSND?=
 =?us-ascii?Q?zX6bYT8WMUWQnUUcK16So6j34v2VRIDmQLX3aXlP4hS+pRLwdMYvsLcZy1Jn?=
 =?us-ascii?Q?RtQfHbTml+VDBFdmahMuMkpllsgdreF0EcuAcQhRw9ivvzF7vpeBLRQ7Yvee?=
 =?us-ascii?Q?Frlw4XvyzmJuALG8iXAd7gMTFv1JKx8w9jWjDnmd3Y4yMqij4t7u9g40+tc2?=
 =?us-ascii?Q?E2DKAW/nyXcfsgDN6Y9KacnkkcWW1PlaIKcfnvoA8qk+6Mck3rfwdYH4SEgi?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 937335de-5dfa-41f3-b928-08dd52bbd666
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:08:06.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBulKi/7OQo7pptIQaC/zULT5Y8TpDNpQimjdsJWzjVJXywvN7jmxmQxBNmWNgTa4Oxh5e5gx7F08HknX0RGsdcn6BVnz8bZZaDxuSMqQ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
X-OriginatorOrg: intel.com

kmod 34 is out:

	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.tar.xz
	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.tar.sign

By number of commits this is the biggest release ever, although we
managed to do it without libkmod additions/removals. There were lots of
changes on improving tools, tests, CI, docs, bug fixes and changing the
build system.

The recommended build system for distros is now meson. Autotools is
still supported, but for this release only.

The shortlog is way too big, so I'm only adding the summary below:

    283  Emil Velikov <emil.l.velikov@gmail.com>
    135  Tobias Stoeckmann <tobias@stoeckmann.org>
     84  Lucas De Marchi <lucas.de.marchi@gmail.com>
      4  Martin Wilck <martin_wilck@gmx.de>
      4  Martin Wilck <mwilck@suse.com>
      2  Michal Suchanek <msuchanek@suse.de>
      2  dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
      1  Christian Hesse <mail@eworm.de>
      1  Enrico Joerns <ejo@pengutronix.de>
      1  Grayson Nocera <gnocera@purdue.edu>
      1  Max Kunzelmann <maxdev@posteo.de>
      1  Sedat Dilek <sedat.dilek@gmail.com>

Thanks a lot for everybody involved in this release. The complete NEWS
is below.

- Improvements

	- Drop pre-built .ko modules from git - distros/packages will need the
	  linux-headers to be able to run the testsuite. There was limited use
	  of the feature, while linters complained about "source-not-included"
	  or "source-contains-prebuilt-binary".

	- Switch build system to meson: autotools is still supported but slated
	  for removal on next release. This is the transition release to help
	  distros and integrators to move to the new build system. Default options
	  target distros while developers can use the build-dev.ini configuration
	  file.

	- Allow to load decompression libraries ondemand: liblzma.so, libz.so,
	  libxz.so and libzstd.so can now be loaded ondemand, only when there is
	  such a need. For use during early boot for loading modules, if
	  configured well it means none of these libraries are loaded: the
	  module loading logic via finit_module() will just hand over to kernel
	  the open file descriptor and kernel will use its own decompress routine.

	  If kernel doesn't handle decompression or if the module is compressed
	  with a different algorithm than the one configured in the kernel,
	  libkmod can still open the module by dynamically loading the
	  correspondent library.

	  Tools inspecting the module contents, like modinfo, will load that
	  single decompression library instead all of them.

	  For distros building with meson it's possible to choose the behavior
	  per library. Examples: a) -Ddlopen=all uses dlopen behavior for all
	  the libraries; b) -Ddlopen=xz, will make only xz to be dlopen'ed
	  while other enabled libraries will be linked in at build time.

	  The use of dlopen is annotated in the ELF file by using the ELF
	  Package Metadata spec as documented in
	  https://systemd.io/ELF_PACKAGE_METADATA/. Example:

	  $ dlopen-notes.py libkmod.so
	  # build/libkmod.so
	  [
	    {
	      "feature": "xz",
	      "description": "Support for uncompressing xz-compressed modules",
	      "priority": "recommended",
	      "soname": [
	        "liblzma.so.5"
	      ]
	    }
	  ]

	- Add -m / --moduledir to depmod to override in runtime the module
	  directory that was already possible to set on build time. Document
	  the interaction between the dir options: base, module and output.

	- Better error propagation in libkmod for its internal APIs and libc
	  functions up to the callers.

	- Improve libkmod API documentation by adding new sections, documenting
	  functions previously missing, rewording existing ones, adding version
	  information, cross-referencing, etc.

	- Remove deprecated arguments for depmod: --unresolved-error, --quiet,
	  --root and --map.

	- Remove deprecated arguments for rmmod: -w.

	- Remove deprecated arguments for insmod: -p and -s.

	- Add --syslog and --force for insmod to normalize it with other tools.

	- Add bash, fish and zsh shell-completion for insmod, rmmod and lsmod.

	- Remove depmod_module_directory_override from .pc as the kernel side
	  is not making use of it and will likely not need it.

	- Improve builtin module listing and retrieving information from its
	  modinfo index which reduces the amount of needed syscalls by 90%.

	- Improve zstd decompression by using streaming bufferless mode which
	  reduces the amount of syscalls by 65%.

	- Increase use of pread while parsing ELF and indexes in order to reduce
	  syscalls and improve performance.

	- Improve module sorting in depmod to speedup the use of the
	  modules.order index and support duplicate lines in it.

	- Avoid misaligned memory access while reading module signature in
	  libkmod.

	- Add more documentation for contributing to kmod. New developers are
	  welcome to look at the new README.md and CONTRIBUTING.md files for
	  information on process, coding style, build/installation, etc.

	- Overhaul man pages with multiple clarifications, section rewrites and
	  additional documentation.

	- Drop --with-rootlibdir as it's seldom used and was partially broken.

	- Drop strndupa() and alloca() for increased libc compatibility.

	- Better handling of LFS for increased compatibility with libc.

	- Protect kmod_get_dirname() and kmod_new() against NULL argument.

	- Normalize --version / --help output across all tools.

	- Always include log priority in messages, even when building with debug.

	- Optimize index reading by lazily reading nodes on demand, reducing
	  FILE overhead and reducing code duplication wrt FILE vs mmap
	  implementations, etc.

	- Switch index to pre-order to improve performance in both read and
	  write, meaning faster lookup and faster depmod. Some examples:
	  a) traversing all indexes via configuration dump shows a 9%
	  improvement on Raspberry Pi 2. b) writing the indexes takes 90% less
	  lseek() calls, leading to a performance gain of 13%.

	- Make symlink install locations more similar to what distros are
	  using: by default it installs the kmod binary as bin/kmod and the
	  symlinks are located in e.g. `sbin/depmod -> ../bin/kmod`. Changing
	  the sbin location is sufficient to move the symlinks to the
	  appropriate place, so distros using `--sbin /usr/bin` will have them
	  installed in that directory. This avoids distros having to remove the
	  symlink and add the symlinks by themselves. (meson only)

	- Install configuration directories,
	  /{etc,usr/lib}/{depmod,modprobe}.d/ as part of installation, matching
	  what several distros do during packaging. (mson only)

- Bug fixes

	- Fix testsuite using when using configurable module dir.

	- Fix typos on documentation and source code.

	- Fix out of bound access in multiple places when using long paths,
	  synthetic huge files, or handling memory allocation errors, or
	  inconsistent variable types, particularly on 32b builds.

	- Fix internal array APIs, with better error checking: improve execution on
	  very memory-constrained scenarios or very long paths.

	- Fix absolute path handling in depmod.

	- Fix libkmod memory leaks on error handling when getting builtin
	  module list.

	- Do not crash on invalid modules.builtin.modinfo file.

	- Fix link with lld resulting in empty testsuite.

	- Fix testsuite build/execution with musl.

- Others

	- Adopt clang-format and editorconfig for coding style and setup CI
	  action to keep the codebase consistent.

	- Adopt codespell in CI.

	- Adopt CodeQL integration in CI.

	- Adopt Codecov in CI.

	- Adopt SPDX copyright and license identifiers throughout the project.

	- Add more distros to CI, 32b builds, clang as compiler and lld as
	  linker.

	- Add support for clang sanitizers and squelch warnings.

	- Add tests for builtin modules from modinfo index file.

	- Multiple testsuite refactors and fixes to make it simpler to write tests.

	- Add CI coverage for docs

	- Improve strbuf implementation with more error checks and generalize
	  it to cover the role of scratchbuf. This allows to remove the
	  scratchbuf implementation.

	- Use common array and strbuf code in depmod to remove duplication.

	- Add abstraction and use more compiler builtins for addition and
	  multiplication with overflow checking.

	- Normalize use of C attributes throughout the project.


cheers,
Lucas De Marchi
