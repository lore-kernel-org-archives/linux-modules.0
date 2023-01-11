Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735CBC46467
	for <linux-modules@archiver.kernel.org>; Wed, 11 Jan 2023 15:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjAKPgM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjAKPgL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 11 Jan 2023 10:36:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03D193F1
        for <linux-modules@vger.kernel.org>; Wed, 11 Jan 2023 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673451366; x=1704987366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fo1GUPZ8tQm1zSd5gyjRYfIuAWxMevzzLdrbnkmSinw=;
  b=TDl9XXp7FEPpIPfW1DHmcSzEsJjXpPTKIS8g/BvRgL36pEx9HvqPVvD/
   4FDyRMa0UpY95vuSY9IB3AlHdG7+TYADgATSGZkPkUvjn818BeNSUfi4T
   zO1L2odqW6HYggYN8Zo3v5m4txdmbY4vI7N0aSP2DtWeWGInj78K9cgnM
   2XTah06p2ti8hgmg3597RvR6XR0kYodD8/8y2mlcN2xkdKMJ2zjIWltI5
   V/M5iWsjURg+4AkatEa5jyRv/dGM33R8tvIeLI5Z/kpAjlOYD5Ox2zA1i
   HYG5rqD4X8xwylw5QePnt7lR3wxXNqycLqwgUokAQjZ0ViVP5Y5v0ErTz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409687669"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="409687669"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720760945"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720760945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2023 07:33:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 07:33:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 07:33:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 07:33:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJFNNckDBARvRomi6wwMU9MWCekDvOV3P8rLZKUHbCAP9u1zW4Xfo5HNVyY8ejbWnKcgvuERQhjNCXn12kHvRRZvZVxGsLjwx2R72seH0LOJXUP0qwbI0M4MKT9oEAp8Iez2+jHjYYqYKob+NmdkoGcy8F6a4N/qifC1CwuVCS7P6nCzq3LSo5SWScwXn5Lqtp9uYkf5GkTqXOn/5z00GxjJarUCoLUbM2pQtx5QU0VbA/uONGw6cJLZB5orqmEINEWKygPe021QejbGCx2d++4tsD3tthOlphtiSPySc0Ozir81lV3eUa6vy8CLZhOKncDE1CC4BHeN8TekEPB+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0shnJ03muyOU4sf6mwc814l7z5BBwDypYKt+Cj2cuNY=;
 b=S6oDvFtDlkgVydVyUAPdGSOOVMGm3s3dHTGQ6V2kuLF0gKQ5O0RoFwoVxZ+9b0OKXrU/8iCAOSpiFyjI8zQ8AoON89+nFGTXO311cSPYUf1vpWbgjzcFULVLwoZY0+7TOJ2U9pDCTYo+PTJlSjZnzo6pxS02VyXa1zO3Ds/jeIEB7bu9lkO29K8d0PAGZfOWudKUIYY1JsFQDPoxpI+5M79GTRoZfvUZsWOBlYxffg9bXCvKfh4RhL2RVX5BGVCJt7ikrajRit/DsAZut//sm+Nfv+LDHP/uZiAb4R7EW30jsFc0xUBmFMxmkbR6u/+5mtenLiOsvkbatTyuFF9tWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN8PR11MB3556.namprd11.prod.outlook.com (2603:10b6:408:8d::31)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 15:33:16 +0000
Received: from BN8PR11MB3556.namprd11.prod.outlook.com
 ([fe80::993c:13fc:ebc9:7168]) by BN8PR11MB3556.namprd11.prod.outlook.com
 ([fe80::993c:13fc:ebc9:7168%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 15:33:16 +0000
Date:   Wed, 11 Jan 2023 12:33:14 -0300
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     <linux-modules@vger.kernel.org>
CC:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sverzut Barbieri <barbieri@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH 0/2] Allow passing module files to modprobe
Message-ID: <20230111153314.bf5pf26svu4xga4k@gjsousa-mobl2>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230111152936.101040-1-gustavo.sousa@intel.com>
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To BN8PR11MB3556.namprd11.prod.outlook.com
 (2603:10b6:408:8d::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR11MB3556:EE_|CO1PR11MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b19783-739f-4007-f46b-08daf3e9286e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ44JsuJzqRc0mIihnWNKrJiOVDGF/efZxoGFcy6NHiFg2hzfXBmO6wuLVOAEhEIbXaT7ieO7msm/p5AXLyzTkCFY2QFJvgNTRXVMDL3YC8TTQBJihGlJ/0B1b5tHhTdktadSyJfX1FZZgTUYFB94Q3HyE1Y+WaC6TKv0Sw3Z9Yim07ZH3MPVjD2yyK4uNyTim28l9+d8HW7QnLrZtJq0hMpzW8BHqCII1UNYBIjVpz7tHFMkv7nTVOdGOfaOEbwxpfv4wpJjQlkMIc6k8E8DOGeUZFMFtxN0C64KpjthjXXhnTwGXDkZkgH8cXXdHdMbHDaG5olNdHFeabHhO6De0hMcemrgNpSHLYaSZNyxcoaeGsz3FJ12yPl9S3cK4FyavMapHynZX2woYN93Hw1WXBYOQqT30Or7/q8ZpDIs7XeMgHXJNpcnFFCzEBoJ/4cC3JZX7rkziO38Seosspjq45eSC9aYes8UCiddQlREamJ4YEsrSqApiYI6W5/F48DAdkcc7qZGl2bO5v8o5VuNTi5Euv3GoidMLESa12Y+1fXPvBd6N7riOzPYZ7DY2YZNLtsZn9IfqHk86jGuKl8xiK5o0KTLpW8RKrKGSlVLa2pLopZmZVUh4FvaP2Bpuw7DwuzAQGkENIN3ISr0M948g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(8676002)(66946007)(41300700001)(2906002)(44832011)(8936002)(5660300002)(6916009)(66476007)(316002)(6512007)(66556008)(54906003)(478600001)(6486002)(6506007)(9686003)(186003)(26005)(1076003)(4326008)(83380400001)(86362001)(82960400001)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FcAiya5wPRlrAQN2ltNgBEQ+/A2fB9z5LM9N10h7sL2UgM0t12nKeOKcVUW2?=
 =?us-ascii?Q?X1MrjDz5EmBTFphszx9a+RN41fUxyYQ/x1DjC/JWtgVku0Ej52Y47BpDq5FK?=
 =?us-ascii?Q?CuEymUiFt3qRZtNPf/a9DrnCAjthtRHSMFmx3JMx0+vpcCJZyEmBiuMXAPf3?=
 =?us-ascii?Q?SMAKQTYlERCJD1JZ1F4um+BD1vbtdZmE4XHB82/cCKJQyugEHTtr5gKtgbe2?=
 =?us-ascii?Q?o0egaxRywN0DXUc/cFtv4ka3909QgmwOqdR53WGl3gF/spX62L5K/wPu4dth?=
 =?us-ascii?Q?YLa8OU+Ulyh1q03QFH6OaepJnE5l/f49oQ35TfuZmLuLLmDVcZkNWjMRyzDa?=
 =?us-ascii?Q?qpRBBfKG6+ubWxU5FEJXGrOYZfhIHG5M9HvS7AdC9yOJhjfA/WqZTvmSms9N?=
 =?us-ascii?Q?fEVSxKUv1MUkEqOI1FklbMzmUWIN/sDflzuhlt7nkb3jCtYEtkfIhvkToUx3?=
 =?us-ascii?Q?Qqgdgb5ICzRLgcCo7irZoj1XVbI084ooJq6R5MY+rYZEYXN7skGxpuuTUGvv?=
 =?us-ascii?Q?7RdhUR+YfA+vEtEfBgDiKy4WGv8pHiIz1bICEBd5gTwdGYifWne9wlSgHcU4?=
 =?us-ascii?Q?6GIUNXGvH3bvzLBGRlxIGirgj0uMmtaqExbfeDCslbOwdOboiRpO/2+TWfSK?=
 =?us-ascii?Q?Yz0VFNlNmdspn5iE8ZYYL3iKR78nGaqWkTKU9N6RLORRn7IBMXhrz9XBmH9P?=
 =?us-ascii?Q?1YxJ3BYOid56k9GeaLnEzF23yyBIsNZ25NZhZcxwyrzQSCfgGBfquKw5WE3y?=
 =?us-ascii?Q?JZNoVt5d9VsIFrMSNjFTc1ImkFnnwwX02PNqf3Qq0rs7eVhba/1z0JW51z/t?=
 =?us-ascii?Q?h6lYTkjfAzR9sg4wsjbJcI5a58yXI4m+cneDYeCY4cOhT15VksmjMVlOJABc?=
 =?us-ascii?Q?KgRL9Sv5k9PmzzzDN8Vm0xdDgEDfsVqzQjH0xx6tV78S12+JrYTDzKb4A1l8?=
 =?us-ascii?Q?iH3NDaiL01r3RnO6dV7FhvffRS5fW308KK2/R3hp60YqJgfnRFXVebaObFP4?=
 =?us-ascii?Q?gOU1SCpSY9FE4xlooZzpT1/ZlEw3Jf1SgI7LAXjRIgNDCPGq2GUiLxT78wVl?=
 =?us-ascii?Q?KV4m18LTVzcuSKe3EFQoRKx+jAylQO0a5PBlL1gEAR6ADJYJm8u/MqlASwYL?=
 =?us-ascii?Q?4fI/KiFsBgvFAJofp1Y5wGX62hdq02jFgelO6cfEd4NJ6mIhsfdDlyR33R1t?=
 =?us-ascii?Q?FyQUwBwOUFtPrqumtLuQ+d7s9Ulh17OiE6eQqfpUnWlzk5xuw5Kd+AfYOdE2?=
 =?us-ascii?Q?lmV72iJnRL4vU9pqnr3HUeBS1nInol+PjNcblbL4nBGFU69pvIo51icW7I/b?=
 =?us-ascii?Q?hrQF7j3bsk2KFcj2X1oaOMhWRQQ08WFDycP1kMEO2Ye9Nju6BCHDbubP9z0V?=
 =?us-ascii?Q?rZspEX24dYV2c/YRiiyjx7HuCRcekUWj8dW1H0/Ysn4/YZDvh/CTSQKCCoEk?=
 =?us-ascii?Q?RZVSddLSEaDXJCx4fS20DVGRj5mcXrZ5LRVjRR3ZxMCXLMwLgskK+5yyBHHC?=
 =?us-ascii?Q?ns+RS+zMx2kABxMpldpbegtp9IHyrM/djcT/driCq1/qO7BmokdmU0fnsupf?=
 =?us-ascii?Q?in78T4Ac1a/WcAG2PjRE342QIapDyidXw3o4CuLcYlghoJfwvFrwWcRyYJXB?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b19783-739f-4007-f46b-08daf3e9286e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 15:33:15.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2zmasmESz7No+ETB7EqB6nO0rBIE9CQDI29XSCynwWP2HDvZJGSSCMUbtDdyJJCBVisKIXvANdOLf8t95XaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 11, 2023 at 12:29:34PM -0300, Gustavo Sousa wrote:
> This patch series allows modprobe to be called with a direct path to a
> module object. This is specially useful for testing just compiled modules when
> they have dependencies, which are loaded with insmod.

Oops, s/which are loaded/which are not loaded/

> 
> Gustavo Sousa (2):
>   modprobe: Move insertion block into separate function
>   modprobe: Allow passing path to module
> 
>  man/modprobe.xml                              |   5 +
>  testsuite/populate-modules.sh                 |   1 +
>  .../lib/modules/4.4.4/modules.alias           |   1 +
>  .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
>  .../lib/modules/4.4.4/modules.builtin.bin     |   0
>  .../lib/modules/4.4.4/modules.dep             |   1 +
>  .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
>  .../lib/modules/4.4.4/modules.devname         |   0
>  .../lib/modules/4.4.4/modules.softdep         |   1 +
>  .../lib/modules/4.4.4/modules.symbols         |   1 +
>  .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
>  .../module-from-path/proc/modules             |   0
>  testsuite/test-modprobe.c                     |  22 ++++
>  tools/modprobe.c                              | 111 +++++++++++-------
>  14 files changed, 98 insertions(+), 45 deletions(-)
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
>  create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules
> 
> -- 
> 2.39.0
> 
