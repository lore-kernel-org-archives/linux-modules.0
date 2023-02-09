Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9176EC61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBIP3p (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjBIP3o (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 10:29:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261238B55
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956583; x=1707492583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H95pCwfPxDY2E6DR+gjzEmpI3ak2E5ZZZ7e9oIC49SI=;
  b=CW/cVHgiRtN80FZBxtdm5L7xdh0mehxeWL7DRkH7Z7QDzM46jvlv2GfB
   H90noPr69m5qItnc3ONyybyeH/OTdYyg6mui958/DerTOA1Jmw9KMtABm
   JNmzjLAJRqTcB/0VorVLljZ8eyNtaZjysDDahiffYOKZ0EPTwRKTvWTnY
   Ta6wuzAxn7JTjZBq4ZnvXel2EFEu9lQXRioZ4U9ibjzHVaOQrsqe5kOx0
   l7V/ScZyID/jbukRexb/qnz9d7QedsP5hSm5Gmx3/aF8BmODQPzuLhSmg
   tmjhUDjFFi/1spP9BqdhJF1fGR/F2z37wqs4N3yjSXVuAr0h36K3pIn9d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328774584"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="328774584"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:25:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="913161925"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="913161925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2023 07:25:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 07:25:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 07:25:26 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 07:25:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhVJRxzDajZGfo3+mpLjUjTluAeYhJH4G1A5JaGCQWBx25Wg9ylL2ZyO2/3/oD9O3wDKDevjJQ/Txtiaku9IthoPRNvlaB8tzzPkv5K+I0IIBYhJOmg6FMaljiouoLr5n9b5OADM+RxDa3aDiHn8ezolyn/rdM2J/ML6t82Xw+kwP75sf/UV+yw+E4FEG8AJXCV/dz8DZVmkEl+S2MpgPR7B1Xin1o+ae1J5bO4fWUpZM26rR9YDlL1JU91j9h/3kjSYT8r2TjQT7rShlhhohQHA2bjlUpvsX3ldiwOlgYic4a+t25HaA+a7WvnI9MrOe9Np/W2YW6wO6cut/DZ2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4NERjphqedWChirnueLUQOx3UF7wqaC7hHfz5NGnLs=;
 b=djokjYFLCcYOWoU4ae2RzRjESYE9FrlrXt4DSB004OydxYrLZBgBWx4TV9MZjdKhQiXJNyWN1EH80A6/zkZmqzBR4aHAZMdK07BSAN9TGVbQluho6Xd4BS9YkQEc4WZayI/UUvsQ8Nu6qSD1c3Q0G9iKx7ITxY12A1ZGtI9FRM55gnkALzuCksqIJmuUfEHtPnQD3rUiCbaYeoQFdkrX82Xv3UXxBCPpW2Skq5OmpYYEx0Dh8bRu7arWvkQ47LWGmZ7daKZlrsT85wqu1NhKa920YHM3UtsdbLCaDBSxcmTo+ubW84OxKBX09b3F+PI3DZ9NO966a+DPfLe4hO/YdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SN7PR11MB7139.namprd11.prod.outlook.com (2603:10b6:806:2a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 9 Feb
 2023 15:25:24 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 15:25:24 +0000
Date:   Thu, 9 Feb 2023 07:25:21 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 3/4] testsuite: fixup KMOD_SYSCONFDIR_NOT_ETC tests
Message-ID: <20230209152521.ppntkfsyxsfdxcg4@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
 <20230206140449.574631-4-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230206140449.574631-4-emil.l.velikov@gmail.com>
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SN7PR11MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e1c4e1-2f93-4085-687e-08db0ab1dd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mW9ALbSbst7lbiPlOvJLc76+Yvti0lwqZ0fOsHXWe4/J8aHyU6vGOdDVwUsvENiqXYvQVwWnUFABjSVacew/TwdjOfIKxYfOHDx35nq0NKv6DBNHFJ58f9jnlVxwejIkVap4/OHskizbBPHW5roUOCpve3d6OlKFg3dhxldF8it6mPfMIHGYb/fmd7iviDypWc2nRyjrog3JPTBqzuqU4y5zyzyv3hLJ03TPCCwsPH8z5edQOF3Pk3dIZErshIae1oZ9GW5uq/S6rvEsYQTWcrsyB5riCY1SoIrvjL2iCBJcme/Vx/TTY6M25plsjWPu7lYSL0QQk32wa3U0c39T8GwRvsco3L0l7vUjQY+ikNF8Ja9bDWAfKdVrxjqI9Wp0ca31OVbuXY+GKpFNx11NngpviTMSs5o/mzq8a+OmDxtmqExvCLRGeZJVEpIsN8HTjgRlJ5ZWsxRugohFJ6eJCSf+OqZjXm3nYaSn84s0CgHG27M8/5jBy4JB3axxOTqb6TBbafK+CMXY3wpV0Q5QErqLimp41ZxX7vaVjWUIKqkY1Qbs3yjbx5luft/6Vw7MkWBYh23Obs8srNU3El+l6KaA6oNLYfsWidgXeJzMLUrhvez7WnCtEJHuA2dZ5VFeK4cnBM4JR0u2Ej38QsK9ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(38100700002)(82960400001)(4326008)(41300700001)(26005)(186003)(6916009)(8936002)(8676002)(66476007)(6506007)(66946007)(66556008)(1076003)(5660300002)(36756003)(9686003)(316002)(86362001)(6666004)(6512007)(478600001)(6486002)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nnSxCT589gi4sNbbXL3M5zCpH5BhwbPZyFueHgoZqO6a7b44OJhjpln6srsr?=
 =?us-ascii?Q?8uUJTNRH+TN0Jwd2wQ4QxGrMUConvH6namwOjEb6xGrvB5ant62QHUWpy2hP?=
 =?us-ascii?Q?a9VAPKuKWfFdJfQQYdcAf1fsZzUtsUN5Ipp6KnlO+5Jl4AzX/jyKvzLkujxU?=
 =?us-ascii?Q?QERGUcWzvXelzfMCHM+fC3LYknZydNpDtM3ABpFIu79NuYT6Gu1CJ5+UnWDD?=
 =?us-ascii?Q?gnYSCT/ZIEWZyv+Vs+DwLq/JIiiDRUMrynrKCU1P+MMxTidOiCypm/n7Dbtu?=
 =?us-ascii?Q?s1DBRLrZsvFhHZjNab9NzRwmQwZF9GiOgxGMCaufNuWMEkbs+ajobR8dL9gF?=
 =?us-ascii?Q?TQTA82+2cnxA1ebmu5Se+0XzAm7ijcyYtxoktoxI2W0JFJyVafZ16NhwMVw1?=
 =?us-ascii?Q?AJCkub6VPgwkz7WOm3bN06GpwU1qqk3/OxdDZd17inDWFgTGkGYzMemAyc/q?=
 =?us-ascii?Q?YQZHFNNk0mYfuQ8tcignVCPqZtw4TkX2PnHZjuvpntYXkAjj//P78982kzUz?=
 =?us-ascii?Q?osMWzFgQRhQbkHi9yciXHRaq3ImQRqimOxksOhVeSccDoLiwszBsV8hKxfME?=
 =?us-ascii?Q?jfqCQRCi1F6NlCU4/0BwahM4hlflg/QZncRTZkDHuyc+LUdWWE+XfHAQneEz?=
 =?us-ascii?Q?JqChvvPYFdRVbovXCiQIi3A7XJnjZV+kuKEMjPd7FcwbLnjbptT3+bX0Ag9r?=
 =?us-ascii?Q?Ry+8Z9xDStpC9dTbtujwGh722gwwgGplyXzYaj73lzli13htBc6Lrx77Bmf2?=
 =?us-ascii?Q?aPnSZmGMZyt30qvBLA34ueVrItczHQVO4Jg8XDwrKCFuCIxTSVJ7dynrxduS?=
 =?us-ascii?Q?gAV2c4hgGHrf4k5oxjPmG5WCvZPEz/IJAoghzGy7rtpastj2r2HzvPfq0BXA?=
 =?us-ascii?Q?+QjB//BgLEVDm51SbAG4Zy53VsOu0MVfjHS2s2Te+zU1VYIxTUTvKSic1UPO?=
 =?us-ascii?Q?jQA3/CgRwpyaXbyniA8M6l98GG/65AGs2K1HJr4SP6n4tY5bFk7YZNb85t87?=
 =?us-ascii?Q?aC8Ije84AndWHK5TikCgqKbf39i+2ww9uO21gvEMvt9iKwIGgxuraAF0yNVx?=
 =?us-ascii?Q?GNIPlMTfuToe/5JVv31UgF+9qvIqqCTPLjfMO5HarhpWY6mWmZScE3w/+DDz?=
 =?us-ascii?Q?KVZcn3Z7Qizq7gLRYBcqZ8JH+XKAl/q0wCmXCUhy5ZnAIFgELkPbdkAMyoWr?=
 =?us-ascii?Q?wwknXEjAi4SLTWWfZNN8WT561P+xePxhal1TUthVwP7QAWqiaafDOCgJr1PC?=
 =?us-ascii?Q?G9PwmwQFnau62IB1zej1yoz75POYlUhgyIpT+xz9o8g79iPm4MQmouuVfRUj?=
 =?us-ascii?Q?LWjD5ongkdvpLVIdB62OyZ3ud4SJrQxlYeWEHsZAMhwvjLwzI3rDxzRi/XV2?=
 =?us-ascii?Q?/cKshNEzSgQNmCPLzdOXkc17Qv0wZnFeYLL9hJ3wAvFIXhz3x+prwmGHSrZe?=
 =?us-ascii?Q?GwPcnlwpbOtwzo9IfYRfylpooIu99u/9FlxxabIANxpEgPm0SF6h1MnprDU9?=
 =?us-ascii?Q?a6uAI38C2a4hYReVd6q/QCIDJP2dO8tLKFm2mh3BipslUmlh5vy9VlC1mWkR?=
 =?us-ascii?Q?DU+uL7oIssRWMeZebFkpHSKvjruiEGb22IPzYI30ocotXVnwzY2vRkRdJDSd?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e1c4e1-2f93-4085-687e-08db0ab1dd04
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 15:25:23.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4MQ7t2MSs0O+L1O2I4voro9AfpRt90sV4lhK4sQeMPcsikzX7GfiCco3+DU+9YNuQaAA2t50A75Xm+rFjvE+koAmqo9qv+KF1Z/AzRi6ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7139
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 06, 2023 at 02:04:48PM +0000, Emil Velikov wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>Currently some tests lack a config segment in `.../etc`, yet they're
>skipped when KMOD_SYSCONFDIR_NOT_ETC is set. Inversely - some tests have
>a config snippet, yet are not skipped.
>
>Go through the lot and fix them all. While there make sure we use tab
>for code indentation, as per the style guide.
>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>

$ cat testsuite/test-depmod.log
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
TESTSUITE: running depmod_search_order_override, in forked context
TESTSUITE: SKIPPED: depmod_search_order_override
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_last, in forked context
TESTSUITE: SKIPPED: depmod_search_order_external_last
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_first, in forked context
TESTSUITE: SKIPPED: depmod_search_order_external_first
TESTSUITE: ------
TESTSUITE: running depmod_detect_loop, in forked context
TESTSUITE: 'depmod_detect_loop' [127296] exited with return code 0
TESTSUITE: ERR: UNEXPECTED PASS: exit with 0: depmod_detect_loop
TESTSUITE: ------
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
FAIL testsuite/test-depmod (exit status: 1)

I needed this:
----8<-----
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 2bc2e90..2d55b5d 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -159,6 +159,9 @@ static noreturn int depmod_detect_loop(const struct test *t)
  	exit(EXIT_FAILURE);
  }
  DEFINE_TEST(depmod_detect_loop,
+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
+	.skip = true,
+#endif
  	.description = "check if depmod detects module loops correctly",
  	.config = {
  		[TC_UNAME_R] = MODULES_UNAME,
----8<-----



Lucas De Marchi

>---
>NOTE: this is based off my earlier patch adding outdir. If this patch is
>applied prior the depmod_modules_outdir hunk should be dropped.
>---
> testsuite/test-blacklist.c  |  2 +-
> testsuite/test-depmod.c     | 22 +++++++++++-----------
> testsuite/test-modprobe.c   |  7 +++++--
> testsuite/test-new-module.c |  3 +++
> 4 files changed, 20 insertions(+), 14 deletions(-)
>
>diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
>index d03eedb..6531fa2 100644
>--- a/testsuite/test-blacklist.c
>+++ b/testsuite/test-blacklist.c
>@@ -96,7 +96,7 @@ fail_lookup:
>
> DEFINE_TEST(blacklist_1,
> #if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>+	.skip = true,
> #endif
> 	.description = "check if modules are correctly blacklisted",
> 	.config = {
>diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
>index 6465230..010f259 100644
>--- a/testsuite/test-depmod.c
>+++ b/testsuite/test-depmod.c
>@@ -41,9 +41,6 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
> }
>
> DEFINE_TEST(depmod_modules_order_for_compressed,
>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>-#endif
> 	.description = "check if depmod let aliases in right order when using compressed modules",
> 	.config = {
> 		[TC_UNAME_R] = MODULES_ORDER_UNAME,
>@@ -75,9 +72,6 @@ static noreturn int depmod_modules_outdir(const struct test *t)
> }
>
> DEFINE_TEST(depmod_modules_outdir,
>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>-#endif
> 	.description = "check if depmod honours the outdir option",
> 	.config = {
> 		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
>@@ -104,6 +98,9 @@ static noreturn int depmod_search_order_simple(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(depmod_search_order_simple,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if depmod honor search order in config",
> 	.config = {
> 		[TC_UNAME_R] = "4.4.4",
>@@ -130,6 +127,9 @@ static noreturn int depmod_search_order_same_prefix(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(depmod_search_order_same_prefix,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if depmod honor search order in config with same prefix",
> 	.config = {
> 		[TC_UNAME_R] = "4.4.4",
>@@ -156,9 +156,6 @@ static noreturn int depmod_detect_loop(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(depmod_detect_loop,
>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>-#endif
> 	.description = "check if depmod detects module loops correctly",
> 	.config = {
> 		[TC_UNAME_R] = "4.4.4",
>@@ -183,7 +180,7 @@ static noreturn int depmod_search_order_external_first(const struct test *t)
> }
> DEFINE_TEST(depmod_search_order_external_first,
> #if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>+	.skip = true,
> #endif
> 	.description = "check if depmod honor external keyword with higher priority",
> 	.config = {
>@@ -211,6 +208,9 @@ static noreturn int depmod_search_order_external_last(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(depmod_search_order_external_last,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if depmod honor external keyword with lower priority",
> 	.config = {
> 		[TC_UNAME_R] = "4.4.4",
>@@ -238,7 +238,7 @@ static noreturn int depmod_search_order_override(const struct test *t)
> }
> DEFINE_TEST(depmod_search_order_override,
> #if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>+	.skip = true,
> #endif
> 	.description = "check if depmod honor override keyword",
> 	.config = {
>diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
>index 3ddb976..6b763d8 100644
>--- a/testsuite/test-modprobe.c
>+++ b/testsuite/test-modprobe.c
>@@ -84,7 +84,7 @@ static noreturn int modprobe_show_alias_to_none(const struct test *t)
> }
> DEFINE_TEST(modprobe_show_alias_to_none,
> #if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>+	.skip = true,
> #endif
> 	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
> 	.config = {
>@@ -176,7 +176,7 @@ static noreturn int modprobe_softdep_loop(const struct test *t)
> }
> DEFINE_TEST(modprobe_softdep_loop,
> #if defined(KMOD_SYSCONFDIR_NOT_ETC)
>-        .skip = true,
>+	.skip = true,
> #endif
> 	.description = "check if modprobe breaks softdep loop",
> 	.config = {
>@@ -200,6 +200,9 @@ static noreturn int modprobe_install_cmd_loop(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(modprobe_install_cmd_loop,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if modprobe breaks install-commands loop",
> 	.config = {
> 		[TC_UNAME_R] = "4.4.4",
>diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
>index 9872b78..dcb9934 100644
>--- a/testsuite/test-new-module.c
>+++ b/testsuite/test-new-module.c
>@@ -106,6 +106,9 @@ static int from_alias(const struct test *t)
> 	return EXIT_SUCCESS;
> }
> DEFINE_TEST(from_alias,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if aliases are parsed correctly",
> 	.config = {
> 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-new-module/from_alias/",
>-- 
>2.39.1
>
