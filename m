Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191291A2C08
	for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569965; cv=fail; b=LR01d7LHZ8H2CC1CgAR5NcGqzo8cPacZH5IBlthcvNCG80fti0mxQXHCPvFrE+VTQGyEQoM/gmZbAcD/U+EFfiOF61WmEgz0pgzS1YUhM4nxQM3kr/0Md9oqKuz/FrsBuxJH9BN9cZLqHHkdgiflHrNVAQ64j1D+W6JTQ13xl58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569965; c=relaxed/simple;
	bh=F6VUGIz6vjISYTpAt9Y8mmJrobBPiP0FSX4Zly5zjEM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hGjYp6hynW5Ggaoe1hJQGxyyJBPjf8Lyz/HB110PPXUMBdQ2KqMsiQCesF+YrhRl4mzkQNcyde7suWUqw1ojzIrCM7KdiAZV/WlDDt5myNerIpSPEgCwuWqX+z9rQ1aESEHZ1+O4UCPGr+R2uehqABDUEwGmcDQaGbLo7x66vj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuAXZzgf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuAXZzgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723569964; x=1755105964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F6VUGIz6vjISYTpAt9Y8mmJrobBPiP0FSX4Zly5zjEM=;
  b=DuAXZzgfcDsCy6HjpMqT09Z/flqq/YRnNsuHx5V4BI9zkYF0DVp3kIcX
   WnfMMZR6uW8D0ghaObqYvmLyVmImBNJ2eUiZf1vdfV2BnsrPusQfIBPB/
   SRLqLAh8l4LmnhCH9PRb4Uvw4MNAq1oNuS/b1WOXgt5ryh9uZU0tNDXHt
   wj1Qt8g02F1pZbwb5rLx/XYgXxEWtYvDXUr30IaYwChMR+4tyr06O1a8C
   gzplsYTOBjBrYwbECjvHRxCY+qdr6kdcZdCIeEGv+Vam0TS+R/wicM3Bx
   O9wC+kpm1cTPwE+3H84TF0Kb77C2E4t0KD6B0kPap6/fY/TAvOSoAoYFf
   g==;
X-CSE-ConnectionGUID: fMW2EHzEQUia/PKeidwGeA==
X-CSE-MsgGUID: W8P//GNIQ9OhfTVryoX15g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32322310"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="32322310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:26:03 -0700
X-CSE-ConnectionGUID: n7VvDes1Spiarj0r3g1Clw==
X-CSE-MsgGUID: nRQw7Cp4R5e9NFM3imedeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58681468"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 10:26:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:26:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:26:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 10:26:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 10:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ9hzb09UgPFMtIEHj/P4bxb1PzqbtiYXLu2Tol+RGFYYOST+YmQg5/YgT3VxmB4iBPTWKI7HvaCqtJXDq4pjCbmxd/+KLh7ZA89alCpcn/0menPFbiCX6L3f6GRNKeKXLTq0Jzt56iGe9YjLaFyuP+HLmK3IhvRTuV+RJe0olm7k2IZBjbzvevfuRq3q2xUoZghABuDqnGJ6GNhTXc9XvxMmCNzea8pr6at005jjlJ7eGveabrcnuCqkLh0ZbYAvTMQr58hWhuSUAfYql1IQDhfUpJRS73IgyH8F/MC/mn7ta9cPDitR6495b1DJT1Pk+8Nom8Eh0lsIOrY1Su0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQ9uMHPWQbqT4xhC1wlKX6K4P7+hmnrAu1+myw0hJt0=;
 b=OWlimmtXLeMcPuwKD96/vym0Ow1sY9nQAbdZIEELmUar6HzhCLQXGryi5EEPAYowwShR6VrGJ09wgDFnFnmneQsJC+B2BASlo6Cy7z/klGcFY2b8m9QABXw1uAda6P+MHuuCTwUWxMg96RAWZwJcalD/GZLzjznXK6Bqliutmob12s9g6lr0Nd4mv47A+1G/2nhuIJLI14m8hfzHyuuap3LTx0NZeX+RRYrE3TIIj+0mIRQjm3EAeWtAIrarMJI2sfwuGYQVp9R310B0soAvkiZgMBMGdBLpzkYOYR9PD1iu5aPHIxO82t5X3WVECVCnNUb/W5K4HcpmK9FSfRr4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 17:25:57 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 17:25:57 +0000
Date: Tue, 13 Aug 2024 12:25:54 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>
CC: Emil Velikov <emil.l.velikov@gmail.com>, Lucas De Marchi
	<lucas.de.marchi@gmail.com>, Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>, Eugene Syromiatnikov <esyr@redhat.com>, Khem Raj
	<raj.khem@gmail.com>, Mike Gilbert <floppym@gentoo.org>, Shengjing Zhu
	<shengjing.zhu@canonical.com>, q66 <q66@chimera-linux.org>, Luis Chamberlain
	<mcgrof@kernel.org>
Subject: [ANNOUNCE] kmod 33
Message-ID: <vi25zbzu3pteuevfnbfldyt23euinlrjqsfju5jdkgdbnluz7j@yyr3qmladzpj>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:303:b8::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33a937-6243-464f-3627-08dcbbbcfe5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wg2rdWLBIIOYsiDsTzTb+B8AaLy8uIYoZ4PpXMZUwemUKxKdS3wHrJ49Ruin?=
 =?us-ascii?Q?ZvGhncmxFbz63dmEQVXDUYQzt9ccMBHyi7ehp5BgFN480ilCANCBRuGS8q24?=
 =?us-ascii?Q?pwKvDAgK9bfHrqoWDDYMvvsvWVTtePc4l+dh4JdfYMkbSqQTXsOSGZ6QjBXa?=
 =?us-ascii?Q?q+l6xcoPhFK/nrpGPaTeA2ufhbdPg2EksOPyTs/BJvWox4+nSLS4jn8S/4AS?=
 =?us-ascii?Q?enV+1qeNWaOoBp6JZ/4x+5BG+8l+DwFU0ct4BHB1w4gAmQ8LuCgTKbC5kIOZ?=
 =?us-ascii?Q?f4TtsO2W3aQHq9gXVb982ux0ZwXqJr1FIqkcgJInSyLPAmHD3BXuuD3nfjfJ?=
 =?us-ascii?Q?nw7IhKLnOHKERi34jTR5a1/B2NmeYoRBn+Ei9rkr/a/yRIqNDYnB/3MZg4uv?=
 =?us-ascii?Q?1dVymdXKcALNMbmtkQqi4idWi6UhpFBZ3prH4Vq03wZuwTKkYQipIJ+7auSi?=
 =?us-ascii?Q?5RH/G11UeOwf4fPZ4eBxPzrHVFJTNpWzlkRJazHgo/RMqq0bviukVrvYEpgs?=
 =?us-ascii?Q?g6YCtrAzuDJ9UXBzymW86wpFd0Ggfy6mtclk2gyn23ikRHrztyKvadtBZnAl?=
 =?us-ascii?Q?nnMj3fmdnIvU97aI1cPA3wRVKWbydSxibll+aBlwUt7rOuaplIR8TAQi+XXs?=
 =?us-ascii?Q?AOTW6UUhAJRfAvcmKMGzyT8JYK1J3bH9jH4HhbJyFYWrLFgDDhmoKdHSDaE7?=
 =?us-ascii?Q?IQf3M0wYQNSqfkS+7Zbkqyw44ewUrFK5/EPK6potdP/1t0fbhp1z8V2s8ds6?=
 =?us-ascii?Q?uWs04GnDGEq+1zXVCC1ZWabMXEw4Twdo3Nn32qEZgh6CdOpDy+OBlHtHpOcb?=
 =?us-ascii?Q?Nw/ro2+moiE8AqpUSHoQoCNR6pIuryhJheY42zcP96+EmJLL+TgKYRAiOknr?=
 =?us-ascii?Q?indFC/x/7rjjjRnzDMlUC895JgYSCdBncRItwmSCgbPHsxhTg5rvvTkgViW+?=
 =?us-ascii?Q?yKntODuTf5aKukkowNnV5fbvXZMY/wOPCy/GsNsfmAOshzTFaVpaWnzYWBrd?=
 =?us-ascii?Q?LPCKt1IUy4j9LHXgcKymeYtEaqtwfmquvNlOdo+d1QEtWTzdAvRDEJGjZ0rf?=
 =?us-ascii?Q?V5Cppp4uJypNx7Nfe7CK+4iKg6xdNmDzsfKfNz3kl7GLAGci9tAxRcKinu3B?=
 =?us-ascii?Q?eV7C7xDazlrCspLEHjAw4X2DS/kY5eBc4Qa/7kBuBpBT+ASRWKu6snM6QTqm?=
 =?us-ascii?Q?PEe92bKp1F9qSn7+EanB2jo6YZs7ZUiMOmVOaiJ5+ZYDD98B+PMhNE0ajMVf?=
 =?us-ascii?Q?5CW7PuJujSaHx6RU1Pau5+JMqgayCwEUspzWjePXDL1BrFiHBxixSviWuND6?=
 =?us-ascii?Q?HUqyH6IpXiKzUcwlZODrTjZC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zERP5KtQK9cX0xfiMdwBlf/F1Zef/492VlDYZqH5Q0Hbc1dPnIpG+ToHLC48?=
 =?us-ascii?Q?KTsV1z9gRYqucKwHaiaQitg5cSELFAow/zro2DCEwHf/KQT6EYFs6VKUbacu?=
 =?us-ascii?Q?PQTqkaBOKfSWqILKwj14iiBk9osO5wfQQxbEk1dDmOet6xWRvaWFrEfLJUJe?=
 =?us-ascii?Q?OhfaOkPFsZdzyE5gKihQHg7g5lVU+47brLMEdqcLqx9khncrOPJzHsdhE6/C?=
 =?us-ascii?Q?Bs4vMTdopoyzh+qCTG+2zCZAkPMvRfsKe4Dq7Em58N8NKTp9Ih/Y6OKlQxL1?=
 =?us-ascii?Q?Exc9pI0fZYpzqwgbddmG1vPv3PkpKc6pO8hC9WLNVj7hl18p3s7yqriF8hs5?=
 =?us-ascii?Q?zxoe+dnGeSeMIwfYvmZ4SgH8obQ9D4QqLwk7Ia6WnTNU61redSVrZV8nI8fw?=
 =?us-ascii?Q?zozXU1hNYdqVafSyzkIFTBaXP4lfzkuTD01O8+gG9YJ3pkHdgKuNpTccqgvD?=
 =?us-ascii?Q?1BUrtyHHPfDCD1C0W7H191dMU6rNaGQCtdAfJjOMcKfbKOrB+7lkPsXQ9S+A?=
 =?us-ascii?Q?JElrDiYg9/1GMnwIT6t8MHCafqh5wLPDMCECuv7otwMZdbV6yFu3sdYfyiPj?=
 =?us-ascii?Q?F+nnuRZLXOYAKqLWO3f5DE1HxnlAKuexpAznWmkTMKR4M33fMkwRM27jTKCv?=
 =?us-ascii?Q?TdZAqdazeKMaZKnSJ4sM5pY8NTMwhYR8bmN81PqEGujJlb2+j/4EZ38r5Y2j?=
 =?us-ascii?Q?tDmRlar0pgwAWv+AER3pxn8dAgV6z3mZyDvrKtE3GSl3OzfvTFd0RiTBydZb?=
 =?us-ascii?Q?82obVOP6Q+/n/ppSvlgA6vX0xJ/6Fat9Rp8Fw4r2PlYKigU8kn8P0oyq5sDD?=
 =?us-ascii?Q?JUTNKaQob+IHSfcuaSKRSo5Dqvbmuxq/8x8KgPTxFVNcmSX/8wZQU3eC32g8?=
 =?us-ascii?Q?B2qBMBy617UY7beGzePiOogBa8mTDKKKVtjTzLaVBBoOjIIN6r5dOPXa+Rzf?=
 =?us-ascii?Q?UBsmTK3+RcHmAdH7B7gJe79Qa/lH0LxNaXHWdC45cqbFkbW9izFrqD1ti0Gy?=
 =?us-ascii?Q?JpUxyjmmk8xE3dn50k6LNDKggRTvGt/BTbMK/dOAtPgEcdlBiRgqv/1GjTtA?=
 =?us-ascii?Q?yDsy8kn91oh7IihhlU0C0JzRy9/ZlZp6vc1uLwfh1yTn6IfU7+ubgxvJGhrE?=
 =?us-ascii?Q?WBoKBiwFT6JlI4zZz4yrXuVGTTW2YliWfdxHs/ySiRLgmlqtoT8maEs6/U1G?=
 =?us-ascii?Q?i7gFmRGJbG+W4rjGeJOkVj+iDTlrQwqRhxTEeIko7ojqEjKYZTls/jpP/hzx?=
 =?us-ascii?Q?74YuzMvsBVVv/qgPURFvBWWCN61ew/hCFZXZff21ffY19TXrPCsvgGZmCba/?=
 =?us-ascii?Q?eEOsTa+hnDrMWwzZbSYZkZ2X/xDLRKSvw2kNVldvijyjKKs1VrtmAo2/mhVS?=
 =?us-ascii?Q?m3zkz5+Mji8HOIldCVMzX4HahKkSSIgcPJDxPlqQha+7JstvVS2JY1Sja4gt?=
 =?us-ascii?Q?5XPgKTw5rkKFuLCN8gY29aO2ZDVUsbrAlXxmculMRSiakvmspqQ5vhL8Fd1S?=
 =?us-ascii?Q?+Ki8aIG1IWyT4OzrQlN3waBuiCw7MjStnc/nEaDr2HelbG5/eRvr3/v3rUp/?=
 =?us-ascii?Q?dSMeJf0OBuJ5yQXMg9ydo46SsqZG/oNzG66W52I0/j/cU06KVJka77ylG1v3?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33a937-6243-464f-3627-08dcbbbcfe5c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:25:57.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG/7hqnUidRM2S/jhWoEoW1FU3/kl8pmpX/H63M2kqZVcLPtZ7QNwbOLN24BZDAElGecvFXlmznXl/9ae1Zq5TBBoy/bqqFa5pnMQdJtOWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com

kmod 33 is out:

           https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-33.tar.xz
           https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-33.tar.sign

- Improvements

         - Allow to handle compressed modules even without decompression
           libraries linked in. Previously we would detect if the kernel
           supported the decompression algorithm and pass the module directly
           through finit_module(). However it wouldn't consider the file if
           the respective decompression library was compiled out. Now it's
           possible to completely disable all libraries and still have module
           load working with libkmod.

           Tools that inspect module content themselves like modinfo and depmod
           won't work if the decompression library is not enabled.

         - Add weak dependencies - these are similar to pre softdep, but they
           don't cause the dependency to be loaded by libkmod: when a module has
           a weak dependency, it is expected that module may or may not be used,
           with decision happening in runtime by the kernel. It's purpose is to
           be informational for other tools like ones used to create initramfs,
           so the module is made available before switch_root(), but doesn't
           imply it to be loaded when not needed.

         - Improve compatibility with non-gnu libc like musl and uClibc. Now it's
           possible to build and use libkmod and tools without any additional compat
           patches.

         - Move manpages from xsltproc to scdoc, which is now needed during build.

         - Improve documentation in manpages, fixing typos, rewording sentences,
           detailing how configuration files are handled with precedence order
           and making all the manpages more consistent on how to reference options,
           environment variables, configuration, authors, etc.

         - Speed up zstd decompression, particularly when not using glibc.

         - Stop parsing .alias files from modprobe.d directories. Configuration files
           were always documented as needing the .conf extension. For compatibility
           reason with module-init-tools, kmod also parsed .alias files. However that
           was also done in module-init-tools for compatibility reasons and not
           documented anywhere. From inspection on what distros are using, none use
           .alias files in practice, so stop parsing those files and follow what's
           documented.

         - Adopt SPDX for license and cleanup comments on individual files.

         - Since kmod 29 there's a github mirror for the repository. Now it's
           also used for issues and improvement tracking. With that, the old
           TODO file has been removed and distros/users are encouraged to file
           issues in github.

- Bug fixes

         - Move kmod.pc to the right dir, ${datadir}/pkgconfig, as it's related
           to kmod, not libkmod.

         - Fix error handling while loading a file and mmap fails.

         - Fix error handling while handling errors from the decompression
           libraries.

         - Add missing documentation for KMOD_INDEX_MODULES_BUILTIN that was
           added in v27 breaking the ABI. A wide search has found one external
           tool using it, which hasn't been updated in the past 12 years. It
           was deemed safe to simply update the documentation to include the
           missing enum.

         - Move kmod_module_new_from_name_lookup() to the correct symbol
           version. It was added by mistake to @LIBKMOD_5 when v30 got released.
           No external user of this API was found, so it was considered safe
           to just move it.

	- Fix undefined behavior while parsing builtins

- Others

         - Overwrite symlinks when installing tools.

         - General cleanup of how (de)compression libraries are integrated.

         - Add CI infrastructure to automatically test in several distros
           before applying commit series. Currently the latest versions of
           Alpine, Archlinux, Fedora and Ubuntu are covered. More distros are
           easy to add as they are all containerized.


Shortlog is below:

Emil Velikov (39):
       libkmod: use a dup()'d fd for zlib
       libkmod: keep gzFile gzf local to load_zlib()
       libkmod: remove kmod_file::{zstd,xz}_used flags
       libkmod: clear file->memory if map fails
       libkmod: nuke struct file_ops
       libkmod: propagate {zstd,xz,zlib}_load errors
       libkmod: move kmod_file_load_contents as applicable
       libkmod: always detect the module compression
       libkmod: swap alloca usage for a few assert_cc
       libkmod: tidy-up kmod_file_open()
       libkmod: move load_reg() further up
       libkmod: keep KMOD_FILE_COMPRESSION_NONE/load_reg in comp_types
       .mailmap: Forward to my personal email
       man: add scdoc based man pages
       man: build the scdoc based man pages
       man: remove no longer used XML files
       man: add some extra bold/italic annotations
       man: white space fixes
       man: misc punctuation fixes
       man: some options take an argument, mention that
       man: couple of grammar/language fixes
       man: stop removing DISTCONFDIR lines
       man: depmod.d: document the config file order handling
       man: depmod.d: factor out a CONFIGURATION FORMAT section
       man: depmod.d: rework the opening description sentence
       man: depmod: remove hard-coded /etc/depmod.d references
       man: modprobe.d: document the config file order handling
       man: modprobe.d: factor out a CONFIGURATION FORMAT section
       man: add few mentions about MODPROBE_OPTIONS
       man: modprobe: remove hard-coded /etc/modprobe.d references
       man: remove the "Maintained by" references
       man: rework AUTHORS section
       man: list options one per line
       kmod: remove .alias config files for modprobe.d
       libkmod: document KMOD_INDEX_MODULES_BUILTIN_ALIAS in kmod_dump_index()
       libkmod: correctly tag kmod_module_new_from_name_lookup
       libkmod: move new weak API to separate section
       m4: reinstate CC_CHECK_FLAG_APPEND summary
       m4: remove verbose license exception clause

Eugene Syromiatnikov (1):
       libkmod: avoid undefined behaviour in libkmod-builtin.c:get_string

Jose Ignacio Tornos Martinez (2):
       libkmod: add weak dependecies
       testsuite: add tests for weak dependencies

Khem Raj (1):
       Use portable implementation for basename API

Lucas De Marchi (25):
       build: Allow to install over dirty dir
       testsuite: Fix warnings due to -Wmissing-prototypes
       build: Ignore directories commonly used for out-of-tree build
       depmod: Fix warning with -D_TIME_BITS=64
       testsuite: Add missing.h include
       gitignore: ignore gtk-doc.m4
       build: Require scdoc if building man pages
       build: Add mod-weakdep.c to EXTRA_DIST
       ci: Add github workflow
       README: update to a decade+ later
       ci: Replace package installation with local action
       ci: Use a container and expand versions
       ci: Add Archlinux
       ci: Add Fedora
       ci: Add Alpine
       build: Always run distcheck with all compression libraries
       libkmod: Move xz-related functions to separate file
       libkmod: Move zlib-related functions to separate file
       libkmod: Move zstd-related functions to separate file
       Use SPDX header for license
       Drop the one line short description on sources
       depmod: Remove license/copyright from the middle
       build: Add s-o-b to release commit
       Remove outdated TODO file
       kmod 33

Mike Gilbert (1):
       Install kmod.pc in ${datadir}/pkgconfig

Shengjing Zhu (1):
       testsuite: wrap _{l,}stat64_time64 in test

q66 (1):
       libkmod: improve realloc behavior for zstd outbuffer


Thank y'all for the contributions,

Lucas De Marchi
