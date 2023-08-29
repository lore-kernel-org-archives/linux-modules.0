Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CCCC6FA8F
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjH2Ort (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjH2Orn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 10:47:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A8CCE
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320455; x=1724856455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WVDATU7twa4hct/CDhqhqP76c5i8b6WPLrIStB3IHs0=;
  b=TUN0aJTOh7TwGsKB+44+L9l2U9blQ1cNq7Qn/fZlkSSIwJm7NryZOBtj
   OsZfMl0YcbhDzgMptX6vph0RXwCrffMP4LpUXT34wXTyKtP3c2OzAf/AT
   1W5I+p+C/OtcEVqlGLZaP4nhQjqghWG/zvqR7jnt7xqCNZerJuRCYY6mG
   cat5/4AlkToNeN7AACFwLb+ZTL1OQ0DwhgMwCRQc0RbTP4rHn9HvCzsXZ
   V0VCUnS5pTBli+TTYsctwLsz2Gz15YOvzmqgu7C4WIs2LbXsd7AUbvqfO
   MLsPKUe8vuquLtBl5OCzNhpOAalKXy+cStvygB52PoqiYI4wgJZOtopge
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441744263"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="441744263"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="804132876"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="804132876"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2023 07:47:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 07:47:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 07:47:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 07:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXs0PEyH/uKzKl6Q0Pabg0AC300ODWHgAgyPP5KIP86aDjk17gEYjEmXf3VC7vhx8vXegwOVixOc+1bpoINhtJrh55AnfFiqFp6Ud5IYdV1YJGL8O/oLkKRSXEd0qli1eONt3BHOGV1RPZoGXCPO0FtbjRLU4W/SrEe+CgzWur4aodHDd0Yc6goL22I1PnLqfq8XOnZs1TAQQOESE33MzpwUwzxlx/ulOfuhVgO72bKfPhVCJ69MOdtpTTh42hBhHNVjCU6frs7wbs9jX3Urskc1UJMFEmM2lg1s07jgugYY1KDxam1UhKeBK6V0rA6vneeM4jIPFTB3jsxdrxI34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwTJywaI9mKwZzu0ExwuC5O5N8IBuQKWru45xJRMmhU=;
 b=dkPl8cqR1G6KWGaVqcZvP41zOUbKKtDJhh9QRZLiuU0SEvKhecBGzWFYYxlSerXf+KyZcoeosCxnNmKWuh2pcVcRCMuGgAx/3+PEVyou9AqS/WFfPtVWbgIhKqwCgHPcCeKzwd/50ZXtC0bnb9AWVlnvX86/TU7O/p95T34w2gvZQDsc+6rLtVTS30/wi5FclJ3tOMdCcpPDNvNJt3VEX1EB7AvHzkc5o3ptwCZ+wGIcqCT8LQm6wkboopqKgsnVnmRBk2wn1/ds6OrV9UZwwwqCBzR4/hXhsfOJILC1p3THt9SffvW9Egm5PsMlc2yCSMiMi3VhOwxbACgDdAPSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:47:08 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 14:47:08 +0000
Date:   Tue, 29 Aug 2023 07:47:05 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod: allow to fallback to user-space decompression
Message-ID: <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
X-Patchwork-Hint: comment
References: <20230829123808.325202-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230829123808.325202-1-andrea.righi@canonical.com>
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5665d255-81de-4856-68b6-08dba89ed18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpFrW8p2FwHUI1Z3QvkM9uOIrURX+TohC2Hc1AujC3wjuMGMFeEA8C4SHO0iELNx57Hav1i1XClm6dVi+fbB9YkLU6U6oF47RjW++QW95Lxs59dlRXtws2u9wAfg3CiIDXzeDLbMVQ7YLrD8NuvYnUfvmtaqCCV5AP261s98JfPycSutbjLUgda8W9diw7IKXMGRRd6BvZT71yZ01ZSjsKCiBvj1BaGXlFy9H+7nz2Q9Ep5YlQjooaXnn8pRYiw+8kyTCrHOJdymaRNwqpD3BBiYF6CbLKDA3UzvLJYx1DjvMMDo2ZJOvOVYoa+JjJjrAvEQkDDsSCaSwi+nEN7S/cQADftzIXv4ly4LszNDcamE7Udp7Awy+GXACnNFSyJIOfo6YSQFm1HW2MWin2C4xL3UKc9OzEdcx9BhYUajY7hSDT3kV/0A9U/RkFthh4WJSaHxJj8FRsg9/cwQFTObB5akWSP8qvpLYaeV1jLt8NlQG2MVHbNlej9hdreDl3OQ9Et4IP+D5gbv/yVAXMLILSaEjZrCfF2oCsAKRrD+aPE4YIwpxf64fl/5l+CIL0sC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(9686003)(6512007)(6486002)(6506007)(6666004)(478600001)(83380400001)(26005)(2906002)(33716001)(6916009)(316002)(54906003)(66476007)(66556008)(66946007)(8936002)(41300700001)(5660300002)(8676002)(4326008)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUDTMDwqUmX4ZS96kI6t7zdD/Il231GS7ohW5ezNIYkLcfaXXKCC27agsKaO?=
 =?us-ascii?Q?ia1S4fBoZP3Mp300JzOCAASDsXxxXON9ZVaXviFEsp7h8RBfflhRwmmbZoBF?=
 =?us-ascii?Q?M61WdAdZt3m2u1euJfHHcD2jIuQoVi/eRYXGCEbccn0sFQ3T/G6YfcIr168V?=
 =?us-ascii?Q?jmUhkqa9/G5ulAlJPXd+lV/nkP28cqiN1IrxwD3IMdXJylMeYreqSFPfEF2h?=
 =?us-ascii?Q?qsBQMA2Wtse4dtXOaNS6mbFcuCQt5rRczYJ8f2d5QOIx2lbP+5XspaK0Os/Z?=
 =?us-ascii?Q?Q8j405dXVTid7Je6uGrffpLJe3newjzzfolhOHs8SqOcaXazZJFszrybsT6m?=
 =?us-ascii?Q?O5cPuIrkt/DEfMA5UCpWZv47oVFWmJzAFPvS+AcxKjiph7yH2fCKctdydHrw?=
 =?us-ascii?Q?ehOcrUk3OQjNx+H7m4FLr9aMwasioGw8b1IoSmxzgQLeOZbLY/SrQlTJKyk1?=
 =?us-ascii?Q?6KCOQuaywJjTdNxYinbumkxelvNXuZqhmigVhPUm5roploHsaDhUq8DlCisK?=
 =?us-ascii?Q?g/iGJNyqL0U0yohYB4RIBfHtYamGh5sYTf+0ReU5J+1f+W1kbOvhPQpPYJ8Z?=
 =?us-ascii?Q?w63p/4VJjeYMScJK9/SpU1jQF9HcsY0Lv3S//kByN2O+mKgxBeRJUTYIUSla?=
 =?us-ascii?Q?fw4zgqDk3WRC8fecdG9FBcfDdygTa9Y+rhQExzl3GNvASSzOn/GV3EFQBXFY?=
 =?us-ascii?Q?OBZOhniyJS34PKm0PfOVIV1u5oohOWlIOOlZYyUt9WaIl7I/A8cKoVHZ0BAR?=
 =?us-ascii?Q?3EBfAVwVnudUUydA5KXoTzSeiVvOxsS1brjiAG1NbuRxhI5My31J7+nySV9o?=
 =?us-ascii?Q?9Wim0GZOU0cf7AFd37ODQqDqGbIblY7gUvFjPRltvi7hxWT5LMuyxIhubC8u?=
 =?us-ascii?Q?E53D4LPy/Ws2VGTnXV49Jb7U625fN7PcYvAIqrJUV+l6e04CVhpcNJ6rzSNJ?=
 =?us-ascii?Q?uTc1I+i890E14y1ea8Hgic/mpo31BfIAIj4zu3eC8V14DWPm207paSj5KoV+?=
 =?us-ascii?Q?OJomrUaE6lA72luUdKqF89lT0aA7+4wDhJ4oEDFIIWvX3rUFAtc7es3GeYeQ?=
 =?us-ascii?Q?uyfcjchwVABtboEzRGLrS0rKSePwjdiLCQ34NVyvmzmt6y8t/pNtbATtxxec?=
 =?us-ascii?Q?S9tBvYhYh/C8kusBo5TcDrFFtVGBVpk+KRDW3Sx+l3cTlUpeO71VDfeAujwl?=
 =?us-ascii?Q?/fvWV1SiKHOKXzzBlDy58S495+Mb+G50SiVK5XGJ0aIOSGtkSvu6jF8D5UhM?=
 =?us-ascii?Q?2Io+CM8C7ENT5P9hHz5KDsrIXXWb/yCLQamI4cN2b6h3bm6TlWgz8RwpyxLI?=
 =?us-ascii?Q?Tm2WkHb/MEGwdFvDysAdyr5rzUneTiQz6adhRxOwdSWqlhweWdnA3YqGdfR/?=
 =?us-ascii?Q?2YzqpzNQGvJADJENUqyYHh22+qTLq1db71yHMqG+0zPYcf1is8vDK589ylWd?=
 =?us-ascii?Q?tV/x1ZQ0UgUWioPEnlXGV2F2UnDV5RV9qdgLHzgVkLDeACjez1io9Ci1pS1q?=
 =?us-ascii?Q?ppiQTc7S/XVJRiWvSBMowPCDVh0dbOye2r0Mqbq6fy8NfHJWnUJX+tXkq707?=
 =?us-ascii?Q?grYA9jxcGzFytRcqGcdHuDCEIarsGe80kijjEH7rlLkQ7JBh4xJLzVKIJMko?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5665d255-81de-4856-68b6-08dba89ed18b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:47:07.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BqGcB7DQdPJRjVBxbeYqR8Hb/TSrX9cQbKG77Kn9C5U5vkR/OWD4g2mvCzudLbl8lOkzBBKjjCt99GZ4/j63EbuE5tysK70P9SGsD+5LwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 29, 2023 at 02:38:08PM +0200, Andrea Righi wrote:
>Fallback to user-space decompression when the kernel cannot allocate
>enough memory to perform the decompression.
>
>This can happen with large modules, such as xfs on linux 6.5 for
>example, an ENOMEM would be returned and the module fails to load.
>
>It seems more reliable to try again with user-space decompression
>rather than reporting an error and failing to load the module.
>
>Fixes: 09c9f8c ("libkmod: Use kernel decompression when available")
>Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
>---
> libkmod/libkmod-module.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index 585da41..d2d4815 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -978,7 +978,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
> 	}
>
> 	err = do_finit_module(mod, flags, args);
>-	if (err == -ENOSYS)
>+	if (err == -ENOSYS || err == -ENOMEM)

oh... ENOMEM can be returned in several places. I don't think it's a great
interface to just retry in userspace.

Luis, can we do better on the kernel side?

Andrea, did you track the exact location triggering the ENOMEM? Is it
the return of kvmalloc_array() or alloc_page() from
module_get_next_page()?  Or one of the previous kmalloc we use for the
different deflate methods?


thanks
Lucas De Marchi

> 		err = do_init_module(mod, flags, args);
>
> 	if (err < 0)
>-- 
>2.40.1
>
