Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55325C77B6E
	for <linux-modules@archiver.kernel.org>; Wed, 12 Apr 2023 19:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDLTWI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLTWH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 12 Apr 2023 15:22:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8375210A
        for <linux-modules@vger.kernel.org>; Wed, 12 Apr 2023 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681327325; x=1712863325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DYKZJjM7xwqIzkZPfolSMGGo+3iDmR2sToSOXkLXrgY=;
  b=VhpM31xNd1E/uGD2ZiEjatBDmZ+zNup8mvED7kUoMCYRY2g1HUjdmEb9
   8BX8QpNczzDQt0KZpuW0k/mjBRRmoCRSlrtNapUcF03u+XivLWbzb5FbH
   l1cQDAAP75xS2nsbHosGoNWTCcL+VWIe9eqGB8F3UoYxLnkFYWw6UYWGC
   hBFU8hcQ92kNqYmJUyZqFXCmjvcnQH08oBbXrM52yG/LxF7OvJEYojMlX
   fI6jAdMIi2UUoJqFvrsUBg3HWODv/s+RwaVpnMLqnuXFs4DtChMmDYlBM
   xNqcPz6AO5QUYMhataYqhzEubUqncWJjGbHxajTDf3eUhWKkGoSaKxCLp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332700018"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332700018"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 12:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758358820"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758358820"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2023 12:21:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 12:21:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 12:21:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 12:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmnHF4myIo8peGvkTwrZPbKlUHYhY5f8y0P4dIaYWLfxOre+WKiHBblW1raGsRrK/TjB2YQVvLuGwa3CzfONNdgU+PQ+z7gfqOqtIDBOfOgFOc/GDDZVLacH/UyKMWhoOPInNTPS4RqXZvAWJT/Cw9ppyB5GhIAxcU8yHvAPtcBFM8/KIu8Q49qQ9uXLBA3qUcdt8Cb3atezI8EpWpoN3mCKZ7s4SmtKHiiA2cy3FZUCvsx9WtWy2fvzVnCYMYfiQHefACSIAuS/KHen8I6KmRAMocBZ47fXsmock6HTT/9dEueCMrCf80PcF6IZ77jo1WPURMn9oHDEvf4s8jV5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLlJUDLk05hpI1S7/AuIXHN7Y54/zOZQqTHrwW4+lAo=;
 b=aQKxSW/mysQu0J8/nKx02H0mzjECiTf9buw2/x7Ok8h+hIYrW+/EtQ0wMU+wzuKeuJfP5rQyz9Xlu6mct6E5tj3UiqwjG1lt3/I0OA1/5C1l7g87cvSpihqg5Xuxd1iL8zsawKqG/Fb1DLzvdcJT7x16NngPWYgjEPs/MoTKF0hm2ufFBouc+YqE9tGVK+QwnhJjZDXxg4yq+mvX4NFoiw7hB4FTc5TzpaziXxDUMkieIzE6c3n/FMpUavd+wVHHsAtF93/6LnhLH+e++Hrqq9+c0mr0P0eFsZIcI3dXb10F6AIYJn8nenMO5lW1cpmLV2S8qBS7dOAQC4iEbzZ0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 19:21:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 19:21:54 +0000
Date:   Wed, 12 Apr 2023 12:21:51 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Nicolas Schier <n.schier@avm.de>
CC:     <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 1/3] kmod: modprobe: Remove holders recursively
Message-ID: <20230412192151.jbbcltmcwwamhlm6@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
 <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e56d66b-da61-4528-b47a-08db3b8b2ce7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLFYE1UDpFPP597wjGtttzMXJiGURmAv4S87DHZ9GjmbDV8lz9DDqHQ/j6o+KLhaokNh3dt26eo/0DNGZqtmE7L212jwM44KOXb5whSBnR/t3rWMQto2+KHmIWyhDvHqhzDqBTm/iV0FpcuZzfD9nIgyNt7oZA7HlREqNc5m+xQoBKliEILTLjXvkhL6TTOy7wd4QCSagfN+hOAw9MlKvRCPjOhLLGpzb0A52APa0CvZw7cSEss5GpmHm5aRo7uDrDTJwsnkLNaqpw+Yp63WbMv6xPD01eu7LSLVGnuAFllK4NjEOP+1/HI9LG2UZCuQuDvsH7+pcPgT9EIahP9J+i7pcz2mRwx08x72lKyzUcmU/L4dFHyNH5jK+aIk+BvHqf7RbI8i/0OPzXm/djJEDRsfMlzmFxyF7GhXwg9XcM33EV7HfXOStSvr5/3EJfNxvt+2igTaur6V83LpHyHxajKsYJf6lhcyda4KG0rQWOzh5/zpTbV5Vt93TcQq4ghRE7svZpniCG1BsX6SWyv3fz8NUmP+WcCy/cyKxL3rWa+eZuV2hTxY9SUA4QI1fuOX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(316002)(83380400001)(54906003)(6486002)(478600001)(6666004)(26005)(186003)(6512007)(9686003)(1076003)(6506007)(2906002)(36756003)(38100700002)(5660300002)(66556008)(4326008)(82960400001)(66476007)(41300700001)(66946007)(6916009)(8676002)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfT/2nAXEiX4sEZBbsp+IGt7UvM6Sozs+1gLSAH0Q1c9ZgF3KBQCIatac1SV?=
 =?us-ascii?Q?tbqj8AB75bdv4j8x7hRuIN6yLl8CWma+CjGdfGtWfq1H2HuZqfnKef3ozt9V?=
 =?us-ascii?Q?7GOPCdKHTAIVUarDuD9MuIR9JWHidfA67DkNQKzM8U/0hioIfwvf4ww2eK0m?=
 =?us-ascii?Q?KQR9P+0NDP5yjlU2u1Y+QDozzxfc6TyPdQVhxQYQ1hj0VMy7h5lBGrzOSZTz?=
 =?us-ascii?Q?05sy1A3kZl8nfjE3JuEzaPsSlL1Fr1KclvyBY/eety/Yd0Epy7VZ9YuDLGUC?=
 =?us-ascii?Q?6goQUo53nFI5QNFsaYrszkxlu9lKAHA/iUXhm71MdHgXSuWVlO8GFbpJ27tm?=
 =?us-ascii?Q?amhpBEN/o5wbClbQtvhtbtQ5UoUEZm1XzHVvRwJOC/2FSnL/IO80ccEls8Pr?=
 =?us-ascii?Q?4PdzG4M6UTTGhROjcefQJ14V5sDd5urpULz6U3x5SuUGjTchFw6/zjywp6d1?=
 =?us-ascii?Q?0ZAgWlgF8ehIcFtxF77sG3WNoh5gbKUZ48Px/FtVyIGB0IKB+/ZCr62o7QRf?=
 =?us-ascii?Q?avcfB7BgG5TQ1ciKtcZ+q0RztUQoXeMjTP0ybFImzGk4ACTRkFoA4XaQXrER?=
 =?us-ascii?Q?BIZ8zPXY5CJjSb7hAuml+CN9QgGrfNW0M8mKWP1oxYndlNNl4Nr7LhpRB/Yb?=
 =?us-ascii?Q?57WZO9eBunsP0j6EDoKH4u2/yBN2TmTOxTymjPLVdiFd8YfTWYdiDvwOuNhN?=
 =?us-ascii?Q?/LzqR55pcxTyquPLA3a09vvRAwy8Evw4hbntxrrAEClxNVx0VtRWGBZiFNK4?=
 =?us-ascii?Q?DFoX8Nxf/0qMoSPm30a04O04VdV645e/sTMF/WZyiSmTmgSY0hNOLKrY8BQm?=
 =?us-ascii?Q?+gyZaiwYBaGbWVsZn00uwSztAV8ghUAO+Zz6ym/zrDmy/uF5c7Km/r1kPaA8?=
 =?us-ascii?Q?f/HDnUBoy4/NB4oUrUehvXe4qWBwv/TmGYLkz6+z9o++faDcZz4G2jyRVEgF?=
 =?us-ascii?Q?s51Z+9NmZq9C0qV5/KOStlYzGdN8h7hM1MUULAbLFoWZtCOppY/T0xZjle1u?=
 =?us-ascii?Q?iF9Yh7gv6rA8MIOV5gC6zYqwsMEYEq4a9OCbK4PqI+le1H21g+gov3yf3wwz?=
 =?us-ascii?Q?Nq+W6e7pIJL0s+1u9HgUvtIUblkJ+tCKHFz0im0d6YzqQwOiNeZFBLN2lHJO?=
 =?us-ascii?Q?MStxf3+kbNSmCHSIRx8r9ewRJmrLtq2xSNcO0VNm/LsS/kRmDwLXaxQNZ0NV?=
 =?us-ascii?Q?4YIJbreNPl7VYVHpHbC3uw463wQFDbqZXQKmhhFTy38bP2SbL2ngCswwvrVy?=
 =?us-ascii?Q?kghKUc/RupChiDENKaGLu5zyatoLUTJoDBlSwpTsByBcNJH2JczyMxjzgROf?=
 =?us-ascii?Q?wH94D3imzxmTQeauXbcZlPn8u9zhyxu3905v+DKVeFQMWi5q71yAd9saZTDY?=
 =?us-ascii?Q?q+CI9lENpp+MbxN/4nvyFKLR3cKhwKhP76VQAjODRBp0DC5AijPxpSI3jld/?=
 =?us-ascii?Q?9RDLNjriXc015fZPSmPzzr5xNG+W1xY9rkPl8UCxdTxxp39k4vbX2YImVySI?=
 =?us-ascii?Q?zUciCLtQFSPum9XB0Kl3I6E3pksuQnvv3x8F/1ntwqTpkygc+9SpwJrMsT5z?=
 =?us-ascii?Q?AIEtgMw6B1jFbsPN78LsMf4awZRDh4Da+8wO2lqRovsZOaqLZigJOZf9Gkp/?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e56d66b-da61-4528-b47a-08db3b8b2ce7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:21:54.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VDXFeIs6el4LNlrS6/EeOC4UYVf1E03iz7YAql7Ko7q89lWVqLS/OSe9qvl8463+oXlrdlcEAS5cO03NRJzjd5/NbJ/JAd4atm1dytfKwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 29, 2023 at 03:51:35PM +0200, Nicolas Schier wrote:
>Remove holders recursively when removal of module holders is requested.
>
>Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
>also indirect holders if --remove-holders is set.  For a simple module
>dependency chain like
>
>  module3 depends on module2
>  module2 depends on module1
>
>'modprobe -r --remove-holders module1' will remove module3, module2 and
>module1 in correct order:
>
>  $ modprobe -r --remove-holders module1 --verbose
>  rmmod module3
>  rmmod module2
>  rmmod module1
>
>(Actually, it will do the same when specifying module2 or module3 for
>removal instead of module1.)
>
>As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
>remove all three modules from the example above, as after removal of
>module3, module2 does not have any holders and the same holds for
>module1 after removal of module2:
>
>  $ modprobe -r module3 --verbose
>  rmmod module3
>  rmmod module2
>  rmmod module1
>
>Without recursive evaluation of holders, modprobe leaves module1 loaded.
>
>Unfortunately, '--dry-run --remove-holders' breaks with indirect
>dependencies.
>
>Signed-off-by: Nicolas Schier <n.schier@avm.de>
>---
>I am a bit unhappy about the introduction of the 'recursive' parameter

yeah... it makes it slightly harder to read.

>to rmmod_do_modlist() as it always holds the same value as
>stop_on_errors; is re-using (and renaming) possibly a better option?
>
>modprobe --remove --remove-holders --dry-run now ignores current
>refcounts of loaded modules when simulating removal of holders.
>
>Changes in v2:
>  * Handle modules that have just been removed, gently
>  * Fix --dry-run by ignoring module refcounts (_only_ for --dry-run)
>  * Add missing kmod_module_unref_list() calls
>---
> tools/modprobe.c | 44 +++++++++++++++++++++++++++++++++++---------
> 1 file changed, 35 insertions(+), 9 deletions(-)
>
>diff --git a/tools/modprobe.c b/tools/modprobe.c
>index 3b7897c..a705f88 100644
>--- a/tools/modprobe.c
>+++ b/tools/modprobe.c
>@@ -390,13 +390,27 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
> static int rmmod_do_module(struct kmod_module *mod, int flags);
>
> /* Remove modules in reverse order */
>-static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors)
>+static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_errors,
>+			    bool recursive)
> {
> 	struct kmod_list *l;
>
> 	kmod_list_foreach_reverse(l, list) {
> 		struct kmod_module *m = kmod_module_get_module(l);
>-		int r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
>+		int r = 0;
>+
>+		if (recursive && kmod_module_get_initstate(m) >= 0) {
>+			struct kmod_list *holders = kmod_module_get_holders(m);
>+
>+			r = rmmod_do_modlist(holders, stop_on_errors,
>+					     recursive);
>+
>+			kmod_module_unref_list(holders);
>+		}
>+
>+		if (!r)
>+			r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
>+
> 		kmod_module_unref(m);
>
> 		if (r < 0 && stop_on_errors)
>@@ -448,15 +462,17 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
> 	}
>
> 	/* 1. @mod's post-softdeps in reverse order */
>-	rmmod_do_modlist(post, false);
>+	rmmod_do_modlist(post, false, false);
>
> 	/* 2. Other modules holding @mod */
> 	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
> 		struct kmod_list *holders = kmod_module_get_holders(mod);
>
>-		err = rmmod_do_modlist(holders, true);
>+		err = rmmod_do_modlist(holders, true, true);
> 		if (err < 0)
> 			goto error;
>+
>+		kmod_module_unref_list(holders);

this is a separate fix. We also need to unref it on error, so probably
best to do:

	err = rmmod_do_modlist(holders, true, true);
	kmod_module_unref_list(holders);
	if (err < 0)
		goto error;

I think the alternative to the recursive approach would be to make only
the kmod_module_get_holders() be recursive:

	struct kmod_list *holders = recursive_holders(mod);

And let recursive holders do recurse on modules passing the list as
argument to be augmented. Then the rest remains the same.



> 	}
>
> 	/* 3. @mod itself, but check for refcnt first */
>@@ -472,9 +488,16 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
> 		}
> 	}
>
>-	if (!cmd)
>-		err = rmmod_do_remove_module(mod);
>-	else
>+	if (!cmd) {
>+		int state = kmod_module_get_initstate(mod);
>+
>+		if (state < 0) {
>+			/* Module was removed during recursive holder removal */
>+			err = 0;

wouldn't this fall in this case inside rmmod_do_remove_module()?

	err = kmod_module_remove_module(mod, flags);
	if (err == -EEXIST) {
		if (!first_time)
			err = 0;


>+		} else {
>+			err = rmmod_do_remove_module(mod);
>+		}
>+	} else
> 		err = command_do(mod, "remove", cmd, NULL);
>
> 	if (err < 0)
>@@ -488,14 +511,14 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
> 		kmod_list_foreach(itr, deps) {
> 			struct kmod_module *dep = kmod_module_get_module(itr);
> 			if (kmod_module_get_refcnt(dep) == 0)
>-				rmmod_do_remove_module(dep);
>+				rmmod_do_module(dep, flags);

not sure also recursing the holders of the modules left is what we want.
If there are holders, then the module's refcnt should not be 0 anyway.

Lucas De Marchi

> 			kmod_module_unref(dep);
> 		}
> 		kmod_module_unref_list(deps);
> 	}
>
> 	/* 5. @mod's pre-softdeps in reverse order: errors are non-fatal */
>-	rmmod_do_modlist(pre, false);
>+	rmmod_do_modlist(pre, false, false);
>
> error:
> 	kmod_module_unref_list(pre);
>@@ -975,6 +998,9 @@ static int do_modprobe(int argc, char **orig_argv)
> 	     fstat(fileno(stderr), &stat_buf)))
> 		use_syslog = 1;
>
>+	if (remove_holders && dry_run)
>+		ignore_loaded = 1;
>+
> 	log_open(use_syslog);
>
> 	if (!do_show_config) {
>
>-- 
>2.40.0
>
