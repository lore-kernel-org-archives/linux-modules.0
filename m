Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949A152DFE
	for <linux-modules@vger.kernel.org>; Tue, 20 Feb 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467111; cv=fail; b=n+5uZA3Xb/XxBDd5fHW8h+ipTHNdOyx47uclltmzBeYvuIekT9upziGNp76MS1KaALRTm4PKdcFTYBgtZIXidf1/ixld+eBWoqrUl7AonCfUssydTyF88BRmNMuNbCGSFYLtbawIouxm8ef4C50AfZDanuuQ+FlkiuGX6/uZhyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467111; c=relaxed/simple;
	bh=nHhY/78CDoia0gwmpl4j0SZlt/QXW9msdeuzXd+oXHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UJyf9X8YPwj/RgBCWIyI+bUIy5vWYCElAoBwc6DKcNBbWbqUdTSvBzv+lGByrs44GG4C7iyzJP9QvoCJg7fKcH91B3lZS2Txt7RCK6nk3mtvR7//Bt8mPjsTTFtknCOrI4bl7Njly0/G5wr6XjAL8Q2qdnmkDkXox/MCmItwyAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmrxhCG5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmrxhCG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708467109; x=1740003109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nHhY/78CDoia0gwmpl4j0SZlt/QXW9msdeuzXd+oXHY=;
  b=kmrxhCG5ZDlITCPabZuVjagxj7t3Ty4yui7bOx404mj+PWdzBfjXbBLf
   kuYi6gyk0LlozL/2EqoSdgawzSB8q+l1kJbZyQKqr0Ptj4D4HyuzW4Flg
   KVTc4gkpLQl8TIpF2DhScjT3tnpu+IM6MhVE1oHTHaYAtUBgrTAWoEJQR
   y7syt4ZXOc1UIqMoITXhkBgb0PBO7lPWoYtVXhVnX61E4+JH5CFAv7CBf
   TZgJqozpqzyuPSCWJdDdFs0iz1tdLLxNH2yvQqimjjvyWDi6Kot6sMkq/
   gDiTyY7mjqAs4gIyuK3mjxMKiI3ZiVIPpZQOxU1IKFfinjAIZULyHYH05
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2740440"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2740440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 14:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5143302"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 14:11:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 14:11:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 14:11:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 14:11:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 14:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nggRHyq/+kvswq8pUJeluwV9Dns1GrMLZP3buJ5V10boKB37UqW3t3crER7DrnWo9FX9h9gyKwV9bNj16+j9XpYEktv3UrlfJUqzfHpyF3hsDuFzStlhBetEH8O5fp19yT7hlQ1qpwZihvWS0/Vy5FeYof7XEpB/hpfpew49UEWWYa1roNOu4NQSxAP5bltrdatY/lenNKKXL14JRfi2cyiOElPaQ5mRrZGnmGoaUEQ2kEjbINvs8N5J4PA1MF1rPxB1LZvbpEZ9YAtVf+7CTaqq7BIK3VQNr1AFCgQgjmei2OMoqxcYPqsg88f3fdMIoNQMkr0q70hJEgFUTqFKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4h0KWEkfgKLPg2pzaajkgLXAxxexdZ2QuSge42jzgE=;
 b=gBJfL3BWO3pa0CA9j1mwBbDKCbv6IwZ3qhaE0mN5u7P/aiPeGF0KomfOf2IljpMg4crarTQr74CkbsF5Uns9DxrTFnURRwlwZ5X49nK5QNm8LEjvtx/i2l7n7cp2kahguxL07d8iK7h9YsqM0rSlLfeON1KhHq1fpdt3zjGTx6gQDzv3C2kJgEcMRLkvfQ6iN4VPZoFXHhDL0qf7KIr46pREHPJx7WZlu5l5u1Qli5mZdbEcvYqVdI5t0I3SPP8hVloUyUjo7WmgvjZe0VB+FIpSLP745IP7h0JehcdvpIHnD1OVjfD0wwplDKqe2NsDRXPrCBx4jDWhrL4DiG9tFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM8PR11MB5621.namprd11.prod.outlook.com (2603:10b6:8:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 22:11:39 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 22:11:39 +0000
Date: Tue, 20 Feb 2024 16:11:37 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] Remove unmaintained experimental tools
Message-ID: <atgsidczvtqibln2fcupk6j2elwdiwouewmcaltfj36etxdudb@unbhhawe72yx>
References: <20240212-rm-experimental-v1-1-b97ab3004ae3@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-rm-experimental-v1-1-b97ab3004ae3@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM8PR11MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 2504c585-2615-44da-50f0-08dc3260e965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuCE3kKDqdj37knZjqClLMxdLiTwJJNFZsQ9BnRCFKmvpc2wA57Gb0uM17mYZROBkHl2kXNTFMOSzqy8DroO9odqCXT4DTg5EWu/QGZ1gc5hCwA90A4DWu1MIil0Zi3hPYOc3JGidz4Ivrzf5z/0wBpEWqgloVxHmyVdV/hNNNqyy+RP8nTgkP49fxdRoxe0ONMUQdI3u0CvvAdAPbIAgGiKmNKgo2cNVDiWjjr2xPwoWpLujRQMUTBddu8D3ZNg606IdnDNlUgE66odaPb5IYJ//BiUNFH0QSEPY47gJLZgcJaowTGecXetoVhYkvEyFapKQM6eqjC3HRzMK6FSH76ACwOnNWcLoy/7v8O3epaPdxxB8A/DbTeyrinhWn+X/RaRpb6biLRZQA8dbSa1hcZnmKJ1kWjKukW3GGyx5HvR6p3/cwf34oYDbczRxVebib4qUqx4KT32alYBwyv0p80pf+hCvsupAucWmYrUEyGIPk+YpBbGCZizSun8/usnnBMQdA9dY6gOVRPmd2YfCa3aBuLOGd2DuYrdspxdG7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/vy5qeQMMpI70EXex04Z/KvY0gk+4nWGyvs4VRZLSCTqy1+vkndSb7yVyqA?=
 =?us-ascii?Q?HL53EgnTnwBiHM/miZeL38Dzi4l0MkttIqerz3BWuvMqj4ykZnmiPgddATMK?=
 =?us-ascii?Q?wPXniMGplszS1hvm2+z08RJeFmjKmIBn059cDdHt+MOCMPYha+ASCpbl9qcz?=
 =?us-ascii?Q?8DKY/6yXePPmwG91pZy1Vmu8/b1OmFVoU3oY5NX40zn5mo93i+6/7+ZxyeJX?=
 =?us-ascii?Q?P1l5qnBSujqcZL25vHh2IwROHXqLGia2js5S9Dh+PoYlobDuklaLsRvr48Ts?=
 =?us-ascii?Q?SO6wAOXbQ43A9HmEjYhD3FfMtvJR/6gb21cChBaz8Vq1NEWcHUl9fuiewALC?=
 =?us-ascii?Q?02DbyaVEVRh3YsMFUnFinZIKaBPYn4ARuI29Oew6RnHpWA4lmUNwTTQEoSN7?=
 =?us-ascii?Q?aBAqpV1QpTjl6JnfRv1ejmW5vp3MdqIJc+nE3hJtq7h5wah8N3ihSpYKszKO?=
 =?us-ascii?Q?su/X9QZvxi3Ygl5QExX7rkLAbVtLEOUbcjCED+6nc236X7CdEbggMnXYSaqE?=
 =?us-ascii?Q?ZFkzS3pqjsa8kcJfyu+BnS0idoWXYSuTBks2LUjEhJfqjVm4gqkgHmFTPQdz?=
 =?us-ascii?Q?c8T6ys6f9c7mR25+e1q2E4TGuBTTkIVmhuSJ+3RJgri3Su3qnIIbniMQROE/?=
 =?us-ascii?Q?YZ6bgvb7V4P97QUGlI6tbRCZUWV9N5yygrq2K2n2GFbr0YLvUV85L+MF3HF6?=
 =?us-ascii?Q?2MUesiO+oT6A4PWcuxtqxKgmgyh7HhQ1w/ExIUmIo0+Vspl3Iwzy4tK7P9Gg?=
 =?us-ascii?Q?GvKEH4hE3KRuMOYEzvZcSuHRMt9L/JEo6F3UPL75yBFBGI47yppVKBHCBQoH?=
 =?us-ascii?Q?hESx8pAZZkpBl9Ntjx6X/dKePPKm24fpdKdPgFvk1Gt33Bcs6xol8tmDqbEt?=
 =?us-ascii?Q?Xp/RuhiCWcHWJZMwNpAhWDnb89A7a2J0snArlbQPQ23FyIR0NlGAqsqfsLO6?=
 =?us-ascii?Q?CyPh3bTmjfOvXDufZ0hi5Q5a09pC5JPc2CFCjqTMx8jrdB3iDMB3hPpJjK38?=
 =?us-ascii?Q?t+8sjSsrvLwRlVek7kXoF+I3vZnmjjy2xRFrvEskDtXVNZ3m3prQMyhhVqIr?=
 =?us-ascii?Q?cgs4ST3r5BmHCaG/g/xXoSt5yDfn/GRXAnlns+up4J9T0cN5JD6oE4P6jTd5?=
 =?us-ascii?Q?YEdUxZpDR0BhilVWI5vmE9YwS26oq6QPLzcFKsSAJRjbEBN476eyUOQe2xdY?=
 =?us-ascii?Q?aTzGgHqy7/N6eeptcND1a5JNYYpBuF1W1oHIkyv+VjvU4t2iX+Ufp/9lHyLn?=
 =?us-ascii?Q?RpeYFW0qZ2HX0NE+w+NzuB+xQGzpckn8oX5gUT5QIBnH/YiJEdRZho7Wo2hV?=
 =?us-ascii?Q?/xloVCmQNEpk69afqAl1HGfSCueWLQVP99Xk/ZoXzg9mOxuax0VRq5MTxXdy?=
 =?us-ascii?Q?M0lBroWZQ7y6iTWDZuKEO0+CdAwr2O22Ky09b37l990RkauX6zkETrkvY1K5?=
 =?us-ascii?Q?BBHvpT9w7faIjm3Z5wAHSmYg+aZPAgWxaE4PFAqOurgrrnH507lS0BVPUgqE?=
 =?us-ascii?Q?A3ylc8vXfIlduLaJxl7P0pVO7lI9IzLS0MQf9+EvJG3HtTLQrMTV7r1kj+sv?=
 =?us-ascii?Q?l+MJ1FPAI85fGUAP2VzM4MYA5ljT2BsjUCDnpfqEzKSugLlpNxzSdm3ngpYR?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2504c585-2615-44da-50f0-08dc3260e965
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:11:39.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d6LlcZRcVAVWQ1K1IFPbiOS3egGXp2mUn+1/z/bMcOfY0jqmV6li/3vijfglJGPJOe5NgLWm6BoA1RlB+POTX8DNfmeyKwdSNoJY2KS/aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5621
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:07:57PM +0000, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The kmod insert/remove tools were introduced back in 2015. Since then
>they have recieved zero attention, unlike the insmod/rmmod variants.
>
>Glancing around - neither of the following distributions (Arch, Fedora,
>Gentoo, Debian) build them, so we're safe to say they have no users.
>
>Remove them and alongside it the --enable-experimental toggle, which no
>longer controls anything.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>With the recent removal of the experimental and unmaintained python
>bindings, I've noticed that we still have the insert/remove tools.
>---
> Makefile.am                                        |  16 ---
> configure.ac                                       |  10 --
> testsuite/.gitignore                               |   3 -
> .../insert/lib/modules/4.4.4/modules.alias         |   1 -
> .../insert/lib/modules/4.4.4/modules.alias.bin     | Bin 12 -> 0 bytes
> .../insert/lib/modules/4.4.4/modules.builtin       |   0
> .../insert/lib/modules/4.4.4/modules.builtin.bin   | Bin 12 -> 0 bytes
> .../insert/lib/modules/4.4.4/modules.dep           |   1 -
> .../insert/lib/modules/4.4.4/modules.dep.bin       | Bin 58 -> 0 bytes
> .../insert/lib/modules/4.4.4/modules.devname       |   1 -
> .../insert/lib/modules/4.4.4/modules.order         |   0
> .../insert/lib/modules/4.4.4/modules.softdep       |   1 -
> .../insert/lib/modules/4.4.4/modules.symbols       |   1 -
> .../insert/lib/modules/4.4.4/modules.symbols.bin   | Bin 12 -> 0 bytes
> .../remove/lib/modules/4.4.4/modules.alias         |   1 -
> .../remove/lib/modules/4.4.4/modules.alias.bin     | Bin 12 -> 0 bytes
> .../remove/lib/modules/4.4.4/modules.builtin       |   0
> .../remove/lib/modules/4.4.4/modules.builtin.bin   | Bin 12 -> 0 bytes
> .../remove/lib/modules/4.4.4/modules.dep           |   1 -
> .../remove/lib/modules/4.4.4/modules.dep.bin       | Bin 58 -> 0 bytes
> .../remove/lib/modules/4.4.4/modules.devname       |   1 -
> .../remove/lib/modules/4.4.4/modules.order         |   0
> .../remove/lib/modules/4.4.4/modules.softdep       |   1 -
> .../remove/lib/modules/4.4.4/modules.symbols       |   1 -
> .../remove/lib/modules/4.4.4/modules.symbols.bin   | Bin 12 -> 0 bytes
> .../sys/module/mod_simple/holders/.gitignore       |   0
> .../remove/sys/module/mod_simple/initstate         |   1 -
> .../test-tools/remove/sys/module/mod_simple/refcnt |   1 -
> testsuite/setup-rootfs.sh                          |   2 -
> testsuite/test-tools.c                             |  71 ----------
> tools/insert.c                                     | 128 -----------------
> tools/kmod.c                                       |   5 -
> tools/remove.c                                     | 153 ---------------------
> 33 files changed, 400 deletions(-)

error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin: patch does not apply
error: cannot apply binary patch to 'testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin' without full index line
error: testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch


something is wrong with either b4 when there are binary patches or in
your git config. I applied the other hunks and removed
testsuite/rootfs-pristine/test-tools/{insert,remove} manually.


Applied, thanks.

Lucas De Marchi

>
>diff --git a/Makefile.am b/Makefile.am
>index 6d21ad2..9c35014 100644
>--- a/Makefile.am
>+++ b/Makefile.am
>@@ -129,12 +129,6 @@ tools_kmod_SOURCES = \
> 	tools/depmod.c tools/log.h tools/log.c \
> 	tools/static-nodes.c
>
>-if BUILD_EXPERIMENTAL
>-tools_kmod_SOURCES += \
>-	tools/insert.c \
>-	tools/remove.c
>-endif
>-
> tools_kmod_LDADD = \
> 	shared/libshared.la \
> 	libkmod/libkmod-internal.la
>@@ -260,11 +254,6 @@ TESTSUITE = \
> 	testsuite/test-dependencies testsuite/test-depmod \
> 	testsuite/test-list
>
>-if BUILD_EXPERIMENTAL
>-TESTSUITE += \
>-	testsuite/test-tools
>-endif
>-
> check_PROGRAMS = $(TESTSUITE)
> TESTS = $(TESTSUITE)
>
>@@ -307,11 +296,6 @@ testsuite_test_depmod_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
> testsuite_test_list_LDADD = $(TESTSUITE_LDADD)
> testsuite_test_list_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
>
>-if BUILD_EXPERIMENTAL
>-testsuite_test_tools_LDADD = $(TESTSUITE_LDADD)
>-testsuite_test_tools_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
>-endif
>-
> testsuite-distclean:
> 	$(RM) -r $(ROOTFS)
> 	$(RM) testsuite/stamp-rootfs
>diff --git a/configure.ac b/configure.ac
>index bfabbaa..8410ea1 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -175,15 +175,6 @@ AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
> # --enable-
> #####################################################################
>
>-AC_ARG_ENABLE([experimental],
>-        AS_HELP_STRING([--enable-experimental], [enable experimental tools and features. Do not enable it unless you know what you are doing. @<:@default=disabled@:>@]),
>-        [], enable_experimental=no)
>-AM_CONDITIONAL([BUILD_EXPERIMENTAL], [test "x$enable_experimental" = "xyes"])
>-AS_IF([test "x$enable_experimental" = "xyes"], [
>-	AC_DEFINE(ENABLE_EXPERIMENTAL, [1], [Experimental features.])
>-])
>-CC_FEATURE_APPEND([with_features], [enable_experimental], [EXPERIMENTAL])
>-
> AC_ARG_ENABLE([tools],
>         AS_HELP_STRING([--disable-tools], [disable building tools that provide same functionality as module-init-tools @<:@default=enabled@:>@]),
> 	[], enable_tools=yes)
>@@ -336,7 +327,6 @@ AC_MSG_RESULT([
> 	cflags:			${with_cflags} ${CFLAGS}
> 	ldflags:		${with_ldflags} ${LDFLAGS}
>
>-	experimental features:  ${enable_experimental}
> 	tools:			${enable_tools}
> 	logging:		${enable_logging}
> 	compression:		zstd=${with_zstd}  xz=${with_xz}  zlib=${with_zlib}
>diff --git a/testsuite/.gitignore b/testsuite/.gitignore
>index 9d26b88..5465b1a 100644
>--- a/testsuite/.gitignore
>+++ b/testsuite/.gitignore
>@@ -18,7 +18,6 @@
> /test-modprobe
> /test-hash
> /test-list
>-/test-tools
> /rootfs
> /stamp-rootfs
> /test-scratchbuf.log
>@@ -53,5 +52,3 @@
> /test-testsuite.trs
> /test-list.log
> /test-list.trs
>-/test-tools.log
>-/test-tools.trs
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias
>deleted file mode 100644
>index ba76e18..0000000
>--- a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Aliases extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.alias.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin
>deleted file mode 100644
>index e69de29..0000000
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.builtin.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep
>deleted file mode 100644
>index 5476653..0000000
>--- a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep
>+++ /dev/null
>@@ -1 +0,0 @@
>-kernel/mod-simple.ko:
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin
>deleted file mode 100644
>index b09a854..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.dep.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname
>deleted file mode 100644
>index 58f6d6d..0000000
>--- a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.devname
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Device nodes to trigger on-demand module loading.
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.order
>deleted file mode 100644
>index e69de29..0000000
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep
>deleted file mode 100644
>index 5554ccc..0000000
>--- a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.softdep
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Soft dependencies extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols
>deleted file mode 100644
>index 618c345..0000000
>--- a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Aliases for symbols, used by symbol_request().
>diff --git a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/insert/lib/modules/4.4.4/modules.symbols.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias
>deleted file mode 100644
>index ba76e18..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Aliases extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.alias.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin
>deleted file mode 100644
>index e69de29..0000000
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.builtin.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep
>deleted file mode 100644
>index 5476653..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep
>+++ /dev/null
>@@ -1 +0,0 @@
>-kernel/mod-simple.ko:
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin
>deleted file mode 100644
>index b09a854..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.dep.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname
>deleted file mode 100644
>index 58f6d6d..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.devname
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Device nodes to trigger on-demand module loading.
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.order
>deleted file mode 100644
>index e69de29..0000000
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep
>deleted file mode 100644
>index 5554ccc..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.softdep
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Soft dependencies extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols
>deleted file mode 100644
>index 618c345..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols
>+++ /dev/null
>@@ -1 +0,0 @@
>-# Aliases for symbols, used by symbol_request().
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin
>deleted file mode 100644
>index 7075435..0000000
>Binary files a/testsuite/rootfs-pristine/test-tools/remove/lib/modules/4.4.4/modules.symbols.bin and /dev/null differ
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/holders/.gitignore b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/holders/.gitignore
>deleted file mode 100644
>index e69de29..0000000
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate
>deleted file mode 100644
>index e23fe64..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/initstate
>+++ /dev/null
>@@ -1 +0,0 @@
>-live
>diff --git a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt b/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt
>deleted file mode 100644
>index 573541a..0000000
>--- a/testsuite/rootfs-pristine/test-tools/remove/sys/module/mod_simple/refcnt
>+++ /dev/null
>@@ -1 +0,0 @@
>-0
>diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
>index a780f93..5477c69 100755
>--- a/testsuite/setup-rootfs.sh
>+++ b/testsuite/setup-rootfs.sh
>@@ -103,8 +103,6 @@ map=(
>     ["test-modinfo/mod-simple-sha256.ko"]="mod-simple.ko"
>     ["test-modinfo/mod-simple-pkcs7.ko"]="mod-simple.ko"
>     ["test-modinfo/external/lib/modules/external/mod-simple.ko"]="mod-simple.ko"
>-    ["test-tools/insert$MODULE_DIRECTORY/4.4.4/kernel/"]="mod-simple.ko"
>-    ["test-tools/remove$MODULE_DIRECTORY/4.4.4/kernel/"]="mod-simple.ko"
> )
>
> gzip_array=(
>diff --git a/testsuite/test-tools.c b/testsuite/test-tools.c
>deleted file mode 100644
>index 4a9ee9b..0000000
>--- a/testsuite/test-tools.c
>+++ /dev/null
>@@ -1,71 +0,0 @@
>-/*
>- * Copyright (C) 2015 Intel Corporation. All rights reserved.
>- *
>- * This program is free software; you can redistribute it and/or
>- * modify it under the terms of the GNU Lesser General Public
>- * License as published by the Free Software Foundation; either
>- * version 2.1 of the License, or (at your option) any later version.
>- *
>- * This program is distributed in the hope that it will be useful,
>- * but WITHOUT ANY WARRANTY; without even the implied warranty of
>- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>- * Lesser General Public License for more details.
>- *
>- * You should have received a copy of the GNU Lesser General Public
>- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>- */
>-
>-#include <errno.h>
>-#include <inttypes.h>
>-#include <stddef.h>
>-#include <stdio.h>
>-#include <stdlib.h>
>-#include <string.h>
>-#include <unistd.h>
>-
>-#include "testsuite.h"
>-
>-static noreturn int kmod_tool_insert(const struct test *t)
>-{
>-	const char *progname = ABS_TOP_BUILDDIR "/tools/kmod";
>-	const char *const args[] = {
>-		progname,
>-		"insert", "mod-simple",
>-		NULL,
>-	};
>-
>-	test_spawn_prog(progname, args);
>-	exit(EXIT_FAILURE);
>-}
>-DEFINE_TEST(kmod_tool_insert,
>-	.description = "check kmod insert",
>-	.config = {
>-		[TC_UNAME_R] = "4.4.4",
>-		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/insert",
>-		[TC_INIT_MODULE_RETCODES] = "",
>-	},
>-	.modules_loaded = "mod-simple",
>-	);
>-
>-static noreturn int kmod_tool_remove(const struct test *t)
>-{
>-	const char *progname = ABS_TOP_BUILDDIR "/tools/kmod";
>-	const char *const args[] = {
>-		progname,
>-		"remove", "mod-simple",
>-		NULL,
>-	};
>-
>-	test_spawn_prog(progname, args);
>-	exit(EXIT_FAILURE);
>-}
>-DEFINE_TEST(kmod_tool_remove,
>-	.description = "check kmod remove",
>-	.config = {
>-		[TC_UNAME_R] = "4.4.4",
>-		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/remove",
>-		[TC_DELETE_MODULE_RETCODES] = "",
>-	},
>-	);
>-
>-TESTSUITE_MAIN();
>diff --git a/tools/insert.c b/tools/insert.c
>deleted file mode 100644
>index 0ebcef9..0000000
>--- a/tools/insert.c
>+++ /dev/null
>@@ -1,128 +0,0 @@
>-/*
>- * kmod-insert - insert a module into the kernel.
>- *
>- * Copyright (C) 2015 Intel Corporation. All rights reserved.
>- * Copyright (C) 2011-2013  ProFUSION embedded systems
>- *
>- * This program is free software: you can redistribute it and/or modify
>- * it under the terms of the GNU General Public License as published by
>- * the Free Software Foundation, either version 2 of the License, or
>- * (at your option) any later version.
>- *
>- * This program is distributed in the hope that it will be useful,
>- * but WITHOUT ANY WARRANTY; without even the implied warranty of
>- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>- * GNU General Public License for more details.
>- *
>- * You should have received a copy of the GNU General Public License
>- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>- */
>-
>-#include <errno.h>
>-#include <getopt.h>
>-#include <stdlib.h>
>-#include <string.h>
>-
>-#include <libkmod/libkmod.h>
>-
>-#include "kmod.h"
>-
>-static const char cmdopts_s[] = "h";
>-static const struct option cmdopts[] = {
>-	{"help", no_argument, 0, 'h'},
>-	{ }
>-};
>-
>-static void help(void)
>-{
>-	printf("Usage:\n"
>-	       "\t%s insert [options] module\n"
>-	       "Options:\n"
>-	       "\t-h, --help        show this help\n",
>-	       program_invocation_short_name);
>-}
>-
>-static const char *mod_strerror(int err)
>-{
>-	switch (err) {
>-	case KMOD_PROBE_APPLY_BLACKLIST:
>-		return "Module is blacklisted";
>-	case -EEXIST:
>-		return "Module already in kernel";
>-	case -ENOENT:
>-		return "Unknown symbol in module or unknown parameter (see dmesg)";
>-	default:
>-		return strerror(-err);
>-	}
>-}
>-
>-static int do_insert(int argc, char *argv[])
>-{
>-	struct kmod_ctx *ctx;
>-	struct kmod_list *list = NULL, *l;
>-	const char *name;
>-	int err, r = EXIT_SUCCESS;
>-
>-	for (;;) {
>-		int c, idx = 0;
>-		c = getopt_long(argc, argv, cmdopts_s, cmdopts, &idx);
>-		if (c == -1)
>-			break;
>-		switch (c) {
>-		case 'h':
>-			help();
>-			return EXIT_SUCCESS;
>-		default:
>-			ERR("Unexpected getopt_long() value '%c'.\n", c);
>-			return EXIT_FAILURE;
>-		}
>-	}
>-
>-	if (optind >= argc) {
>-		ERR("Missing module name\n");
>-		return EXIT_FAILURE;
>-	}
>-
>-	ctx = kmod_new(NULL, NULL);
>-	if (!ctx) {
>-		ERR("kmod_new() failed!\n");
>-		return EXIT_FAILURE;
>-	}
>-
>-	name = argv[optind];
>-	err = kmod_module_new_from_lookup(ctx, name, &list);
>-	if (err < 0) {
>-		ERR("Could not lookup module matching '%s': %s\n", name, strerror(-err));
>-		r = EXIT_FAILURE;
>-		goto end;
>-	}
>-
>-	if (list == NULL) {
>-		ERR("No module matches '%s'\n", name);
>-		r = EXIT_FAILURE;
>-		goto end;
>-	}
>-
>-	kmod_list_foreach(l, list) {
>-		struct kmod_module *mod = kmod_module_get_module(l);
>-
>-		err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL, NULL);
>-		if (err != 0) {
>-			r = EXIT_FAILURE;
>-			ERR("Could not insert '%s': %s\n", kmod_module_get_name(mod), mod_strerror(err));
>-		}
>-
>-		kmod_module_unref(mod);
>-	}
>-
>-	kmod_module_unref_list(list);
>-end:
>-	kmod_unref(ctx);
>-	return r;
>-}
>-
>-const struct kmod_cmd kmod_cmd_insert = {
>-	.name = "insert",
>-	.cmd = do_insert,
>-	.help = "insert a module into the kernel",
>-};
>diff --git a/tools/kmod.c b/tools/kmod.c
>index 55689c0..1015575 100644
>--- a/tools/kmod.c
>+++ b/tools/kmod.c
>@@ -42,11 +42,6 @@ static const struct kmod_cmd *kmod_cmds[] = {
> 	&kmod_cmd_help,
> 	&kmod_cmd_list,
> 	&kmod_cmd_static_nodes,
>-
>-#ifdef ENABLE_EXPERIMENTAL
>-	&kmod_cmd_insert,
>-	&kmod_cmd_remove,
>-#endif
> };
>
> static const struct kmod_cmd *kmod_compat_cmds[] = {
>diff --git a/tools/remove.c b/tools/remove.c
>deleted file mode 100644
>index 387ef0e..0000000
>--- a/tools/remove.c
>+++ /dev/null
>@@ -1,153 +0,0 @@
>-/*
>- * kmod-remove - remove modules from the kernel.
>- *
>- * Copyright (C) 2015 Intel Corporation. All rights reserved.
>- * Copyright (C) 2011-2013  ProFUSION embedded systems
>- *
>- * This program is free software: you can redistribute it and/or modify
>- * it under the terms of the GNU General Public License as published by
>- * the Free Software Foundation, either version 2 of the License, or
>- * (at your option) any later version.
>- *
>- * This program is distributed in the hope that it will be useful,
>- * but WITHOUT ANY WARRANTY; without even the implied warranty of
>- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>- * GNU General Public License for more details.
>- *
>- * You should have received a copy of the GNU General Public License
>- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>- */
>-
>-#include <errno.h>
>-#include <getopt.h>
>-#include <stdlib.h>
>-#include <string.h>
>-
>-#include <libkmod/libkmod.h>
>-
>-#include "kmod.h"
>-
>-static const char cmdopts_s[] = "h";
>-static const struct option cmdopts[] = {
>-	{"help", no_argument, 0, 'h'},
>-	{ }
>-};
>-
>-static void help(void)
>-{
>-	printf("Usage:\n"
>-	       "\t%s remove [options] module\n"
>-	       "Options:\n"
>-	       "\t-h, --help        show this help\n",
>-	       program_invocation_short_name);
>-}
>-
>-static int check_module_inuse(struct kmod_module *mod) {
>-	struct kmod_list *holders;
>-	int state, ret;
>-
>-	state = kmod_module_get_initstate(mod);
>-
>-	if (state == KMOD_MODULE_BUILTIN) {
>-		ERR("Module %s is builtin.\n", kmod_module_get_name(mod));
>-		return -ENOENT;
>-	} else if (state < 0) {
>-		ERR("Module %s is not currently loaded\n",
>-				kmod_module_get_name(mod));
>-		return -ENOENT;
>-	}
>-
>-	holders = kmod_module_get_holders(mod);
>-	if (holders != NULL) {
>-		struct kmod_list *itr;
>-
>-		ERR("Module %s is in use by:", kmod_module_get_name(mod));
>-
>-		kmod_list_foreach(itr, holders) {
>-			struct kmod_module *hm = kmod_module_get_module(itr);
>-			fprintf(stderr, " %s", kmod_module_get_name(hm));
>-			kmod_module_unref(hm);
>-		}
>-		fputc('\n', stderr);
>-
>-		kmod_module_unref_list(holders);
>-		return -EBUSY;
>-	}
>-
>-	ret = kmod_module_get_refcnt(mod);
>-	if (ret > 0) {
>-		ERR("Module %s is in use\n", kmod_module_get_name(mod));
>-		return -EBUSY;
>-	} else if (ret == -ENOENT) {
>-		ERR("Module unloading is not supported\n");
>-	}
>-
>-	return ret;
>-}
>-
>-static int do_remove(int argc, char *argv[])
>-{
>-	struct kmod_ctx *ctx;
>-	struct kmod_module *mod;
>-	const char *name;
>-	int err, r = EXIT_SUCCESS;
>-
>-	for (;;) {
>-		int c, idx =0;
>-		c = getopt_long(argc, argv, cmdopts_s, cmdopts, &idx);
>-		if (c == -1)
>-			break;
>-		switch (c) {
>-		case 'h':
>-			help();
>-			return EXIT_SUCCESS;
>-
>-		default:
>-			ERR("Unexpected getopt_long() value '%c'.\n", c);
>-			return EXIT_FAILURE;
>-		}
>-	}
>-
>-	if (optind >= argc) {
>-		ERR("Missing module name\n");
>-		return EXIT_FAILURE;
>-	}
>-
>-	ctx = kmod_new(NULL, NULL);
>-	if (!ctx) {
>-		ERR("kmod_new() failed!\n");
>-		return EXIT_FAILURE;
>-	}
>-
>-	name = argv[optind];
>-	err = kmod_module_new_from_name(ctx, name, &mod);
>-	if (err < 0) {
>-		ERR("Could not remove module %s: %s\n", name, strerror(-err));
>-		goto end;
>-	}
>-
>-	err = check_module_inuse(mod);
>-	if (err < 0)
>-		goto unref;
>-
>-	err = kmod_module_remove_module(mod, 0);
>-	if (err < 0)
>-		goto unref;
>-
>-unref:
>-	kmod_module_unref(mod);
>-
>-end:
>-	kmod_unref(ctx);
>-	if (err < 0) {
>-		r = EXIT_FAILURE;
>-		ERR("Could not remove module %s: %s\n", name, strerror(-err));
>-	}
>-	return r;
>-}
>-
>-const struct kmod_cmd kmod_cmd_remove = {
>-	.name = "remove",
>-	.cmd = do_remove,
>-	.help = "remove module from kernel",
>-};
>
>---
>base-commit: b29704cd448aaa455dba4e656fc0f0d3c686df3f
>change-id: 20240212-rm-experimental-211fe77ebf15
>
>Best regards,
>-- 
>Emil Velikov <emil.l.velikov@gmail.com>
>
