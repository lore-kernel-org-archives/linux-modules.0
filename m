Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E443C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 18:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjCOSQb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjCOSQ3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 14:16:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8169B73892
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678904180; x=1710440180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jW4rdrosu/HrLfm745aU2QlGZFdW6DPpeRHnIMHI98A=;
  b=OOO8mIf4fxTXk+Or6CcKRJxJK6AxQi1vIj0AHppKta8+v+Jd3ec2AToF
   8Ax6W//9Tce/0rXW3R0l/ZC7daGKz9cVj61u4/plBKeEKXbDEJVHp6sDY
   XJ2YrmpPqOxZ6oZmhQgRHcv/L/E/JQWcU5yIsnRysXnpLMy3MkjvfkjJx
   t/1eWh5hL/ve8980OVQyBVIsISb94lDwpv1HhheUsUG/NbOoC2Gf6DUQz
   RzND7kP2HAGyiJ6lqETh1n9hgEcWFeS+cpKzTTp73URFkYrUO5L+ie7fa
   m2pgpT8b6OPy5NFiuCH7iRjTajXhl4jgJ8dxpVaae7OzpoyBvjlt0QiUt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340150745"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340150745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925431712"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925431712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:16:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:16:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:16:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhRZdWejq3DiHBXa28lWeVvZDzmGOHNPY5/sI+WWwqxUJoLOmy3+3qLvJAYhoWo+y2hv8I+W+SXGT1lTdDF+579RqiTk3ZGlYVBZM0cRc7LL31ygMXECKCZH36vfHK9URvyomBVCp3viIOAMHSXwYyL5NlT1iMc2iAwKsetoDNuCc5IgwWIqw4W6t8gVVEbrS7VFghooPnvnyINMEeEWHEanyP3LxILmvFpJkw85GuDpoSG7+wE4FWrC+ftUlfRU865hSj+RylBKfceBFzMkDjtmNH37WilLKB5tPAe8gfBgUCaNqID5a7hOD1AblG7LeofxCOTkldTMvYevbUaKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHPZaC2eHBrjKNl11+73fgEunxAMLY5QqNHsFnx5OOc=;
 b=hSOcSGDHT3jZpjuCdqDC9WD4n/miSOBKSyGApiJ+NHH+IX5MPwRxsW6a5fXRmmKEyBHoq8V2dXBmRCMQhVT0DoDoLuYQ29Hp8TOtnW4E+wzTWR8TGJtw2zP04jVKm2mH9BWJbL/fM7G8SQZ6ud8piZLTDrTJ5q4xQauXJtSjQbYfJuekJ9IASowZvbIxMz4garqGKCfdbjPqahgynvJBWvl4ux4zgNJP8DlOsy4qkYi3vgjcvCMESjQUlcy6URCIW6BPx17xTu+Z0OZA2G+oE8GppnYfCHSkiWCfPFd8VRSRGjqrdaCr9Y+9+FBQTaaER/a+MTRdQh9xyQjlXnoQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 18:16:11 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::2629:fb12:6221:3745]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::2629:fb12:6221:3745%4]) with mapi id 15.20.6178.017; Wed, 15 Mar 2023
 18:16:10 +0000
Date:   Wed, 15 Mar 2023 11:16:08 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Nicolas Schier <nschier-oss@avm.de>
CC:     <linux-modules@vger.kernel.org>, Nicolas Schier <n.schier@avm.de>,
        "Lucas De Marchi" <lucas.de.marchi@gmail.com>, <mcgrof@kernel.org>
Subject: Re: [PATCH] kmod: modprobe: Remove holders recursively
Message-ID: <20230315181608.oqjqzgm6mxi4jhqf@ldmartin-desk2.lan>
References: <20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de>
X-ClientProxiedBy: MW4PR04CA0338.namprd04.prod.outlook.com
 (2603:10b6:303:8a::13) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f49cb78-29bb-4fb0-7c36-08db25815aa7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5ANymTBBNEREOAwFEA85lbCHd1Xidrkc2mysesp9TwVWWghmoxaHpX1iEhmHTs4wscsqEtiOE0IMrC6h6t1I3qmpB20NRCYV1llroI5tooef+xhOuqDPfwD1PctgnqWryKxfpHwo/9qK63/ATSX5M1WRvzhcUYaVz26iZNBw5sgfiKzN18o/oWMiFzg+c497lyic+ph9MlbIr2v+5LsBUF+pqsyozRRcJcOI4RQkfzuH5W172nfON1T8wpjfG84w5h3Rgz3YGEuJaGVW4sA1H8yICLEsMK1Ti4VkVEEh+cdvOzshHipHx+MJLg+bVvIShccrWU5lRHUtUUkR62686xg7ggUeb7S/MBm8IBiE6GMjv7J49TCuvG+TcGieYzrqDcPz+8Cw3EFQShL1eEnpx7fSIVr8RJLS3Yu9s8d/c6MqCmG5csHYKz8idmbBfBP022KmIy9LcknXuF5j2fRblkOx0xyxGmE2lRANLPUDQoSDA6C1tOa6oEDVYOT+IGjoFyFphl5BS5HF7MY6Yw5o2GQ1VJnwgSARvDoH+1wQY3GX0OyNHc9C1YqJTI4SAvrLTftHwPpptUZ3ZN3uzGMryGofHwvtgiHT29lkGfzDRXgI6GvfuKfNkZnjy8Df58o08DPLr8pdxRhsMLsk/e1Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(66946007)(54906003)(36756003)(66556008)(66476007)(478600001)(4326008)(41300700001)(8936002)(6916009)(2906002)(6486002)(5660300002)(316002)(86362001)(8676002)(26005)(186003)(6512007)(1076003)(6506007)(9686003)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmZYQ8s9/eSTtwpn238HCeQaGqsmsVG0pkCtJ+m04fZ3lr1GftdXRfUtuqyw?=
 =?us-ascii?Q?E/inxccavJvuuGJqRZmsmjM0kzcMMUeiJLP9HXymsUASZ7WD1NBzQX8Pu3DG?=
 =?us-ascii?Q?gl2/oO+8dSH40sIFguUu4B/qI55l02isJfqjc5+/x0rn7IbRwcgmNOigK0lP?=
 =?us-ascii?Q?WQZmrXpy/e5cKzBYQmoH53ojXGlczqcJnr9kWf1J7GpWo4eMalk9kSORIy+d?=
 =?us-ascii?Q?gT/b1P2D+kgnxeeSeyyNIMwHZBwog3txByAeCpjg52teidAbDwO1Tj2fJUPg?=
 =?us-ascii?Q?wypoaTtQQvYpZUPgNPgQUoLxcHtnNLCvBFnllaGoTsbzw3x4rEnJGJmKe5Md?=
 =?us-ascii?Q?SlPQpF2moEKIx2A7pbyiOk/hhgyTboNUTtoVMhWc8rOAZXxVt9O1mQIHgd+k?=
 =?us-ascii?Q?nfDNxsaXbrS4xAzPcjUaE7gX828nghTq437VejeUaVhj2FWiuLi60UPdFKVv?=
 =?us-ascii?Q?osf1XJz9fGjOxH4CNOFMx1V9gR2UIfaW9cvjev4z12qMSGYNIVgHpKM2ycNW?=
 =?us-ascii?Q?5QGYZgz/pMYp91kLUyfrTfndQ3TBFG+dEEQBl3YOoXPiQPNslg/yBR/CHFpG?=
 =?us-ascii?Q?fMLE7Q1FafFCHhNA9viroDZseCx4r8iVxqE3zXjg0JyRsiR+ZNJedT8wK8Y7?=
 =?us-ascii?Q?0QthY2SVryb4KohYqDpKPtBCQZrGeWLB2ADtJpGvXywuDrNsYWVQoRpWt1xi?=
 =?us-ascii?Q?NDY36NzAg1xPjRBpGPkwjdJ+FLHDyMB2Gf9aDibfyqq3KG3ecxDxS06Pr2TI?=
 =?us-ascii?Q?XEJYpwls5fe9iQ0WrxfTuzTtjh3UY02KIh9Z1D4Tglgdsp7efYv/wz2kJfB7?=
 =?us-ascii?Q?8RhvRmhixOdKmpZbX8oX8gRffMwAE28y/16OTMJiD+NwWVnZzudSajOdkh81?=
 =?us-ascii?Q?Nrl8L2WA8mY6uzJffqyIsM8rGxGg8szp86JUEP8jM2hRXCLFOzzPyPmrOhJT?=
 =?us-ascii?Q?3h5kgRt0+RsTjiDhD1R0rZ6FpszRPzFfjy2KtiJXRfEY6bgiPG1gM9dPMifQ?=
 =?us-ascii?Q?u6bLXuTra/CDpfB/b7d9GnYG84WPm8elqug22Ed2aD6Axh9kDm8q+B6OYU7j?=
 =?us-ascii?Q?2Anywg5zoRjCltsTIC35HNFNAxXkFS7sTP5Ir9zZMtOxEspcOJGDQSjagFGu?=
 =?us-ascii?Q?D1CLL0WhumSGpZrB7QytdBEhCbjFyv7sE7Xm9Ck617gqDIg3gi/Z/mM6PCig?=
 =?us-ascii?Q?3yyx1MFequ4sS6QzDfc9qgRlTBqZayD44A/BoCd6wQ3jq7Kd8xjkPe3Km7Ve?=
 =?us-ascii?Q?h6XeWwX0jQDO5cvbA7N9pYIES0+JAA5Tpv1pd3bcaIWRytCkm8BuKysFcpmY?=
 =?us-ascii?Q?tkSoFOe2KGYbG9AVGXqbK6Y1bqCAUBYMwCWcwuk4F+rz7MjIlDkB62I6r66T?=
 =?us-ascii?Q?HD0WyjkLS1aYIGCP7QE0osKYtp0qL265yZWpFSxXPXFgEPwqTHlGwh1Z0Qu8?=
 =?us-ascii?Q?DQ5AlNx1WDIlVjUiDrLsmjDWfiHrGowWDLJdSuCpY73WyXXHZYOYdQpkVPFP?=
 =?us-ascii?Q?JHZJpf+mmOuEyLfgKfJF8loAUmM+r40uP1lYj77nbExkf4faPNWe3iqzn2AU?=
 =?us-ascii?Q?KtgYpCCvJIf099ombluwnZsWNAbdxyWxKJEjXPje0jhHYC9N3hhMWuRjrM3e?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f49cb78-29bb-4fb0-7c36-08db25815aa7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:16:10.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nos6Ze2xckc6C5L2Ey4ai8X9kEZpFQrW6PC1ch+0cxOgaHoxSErQTmITVOdsyomRAxzZBsq2MW4naQCM+Qb8ww7/w6gOrEVkjMviYr4+3+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 15, 2023 at 02:48:16PM +0100, Nicolas Schier wrote:
>From: Nicolas Schier <n.schier@avm.de>
>
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
>remove all three modules, as after removal of module3, module2 does not
>have any holders and the same holds for module1 after removal of
>module2:
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
>While commit 42b32d30c38e ("modprobe: Fix holders removal", 2022-03-29) already
>implements removing first-level holders, indirect holders were not evaluated.
>In a simple module dependency chain like
>
>      module3 depends on module2
>      module2 depends on module1
>
>'modprobe -r --remove-holders module1' was only considering module2 and module1
>and thus had to fail as module3 was still loaded and blocking removal of
>module2.
>
>By doing recursive depth-first removal this can be fixed for such simple
>dependency.


the dep exported by the kernel didn't require it to be
recursive AFAIR because they were always expanded.
For your case modules.dep should have:

	module3.ko: module2.ko module1.ko
	module2.ko: module1.ko
	modules1.ko:

Is that not the case anymore? Was it due to a change in the kernel build
system or something we missed? What kernel are you testing this with?

We will need a test in the testsuite for that and if it's a change in
the kernel rather than a bug in kmod, probably revert that change until
we have things figured out.

+Luis

thanks
Lucas De Marchi

>---
>To: linux-modules@vger.kernel.org
>Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>---
>I am a bit unhappy about the introduction of the 'recursive' parameter
>to rmmod_do_modlist() as it always holds the same value as
>stop_on_errors; is re-using (and renaming) possibly a better option?
>---
> tools/modprobe.c | 37 ++++++++++++++++++++++++++++---------
> 1 file changed, 28 insertions(+), 9 deletions(-)
>
>diff --git a/tools/modprobe.c b/tools/modprobe.c
>index 3b7897c..9cbb236 100644
>--- a/tools/modprobe.c
>+++ b/tools/modprobe.c
>@@ -390,13 +390,25 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
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
>+		if (recursive) {
>+			struct kmod_list *holders = kmod_module_get_holders(m);
>+
>+			r = rmmod_do_modlist(holders, stop_on_errors,
>+					     recursive);
>+		}
>+
>+		if (!r)
>+			r = rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
>+
> 		kmod_module_unref(m);
>
> 		if (r < 0 && stop_on_errors)
>@@ -448,13 +460,13 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
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
> 	}
>@@ -472,9 +484,16 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
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
>+		} else {
>+			err = rmmod_do_remove_module(mod);
>+		}
>+	} else
> 		err = command_do(mod, "remove", cmd, NULL);
>
> 	if (err < 0)
>@@ -488,14 +507,14 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
> 		kmod_list_foreach(itr, deps) {
> 			struct kmod_module *dep = kmod_module_get_module(itr);
> 			if (kmod_module_get_refcnt(dep) == 0)
>-				rmmod_do_remove_module(dep);
>+				rmmod_do_module(dep, flags);
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
>
>---
>base-commit: 3d1bd339ab942ea47e60f053f4b11b0c47ff082b
>change-id: 20230309-remove-holders-recursively-f667f32e2a7d
>
>Best regards,
>-- 
>Nicolas Schier
>
