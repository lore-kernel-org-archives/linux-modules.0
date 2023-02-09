Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C46C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 19:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBITUv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBITUo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B06ADE2
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675970432; x=1707506432;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ONkZlFvu8lGQ3U5k3aCT2FPNRmiTx0K8itXjeBg6lNo=;
  b=hNscjU+Jh3J9+kqaSologxMYzyzS2Zd0T+yJUeKMe6epVXOflOtXDodZ
   RZ1n+dCQGSoktTZw795Rz9driOdxOwJy33RXUkRgPUqpIRvD5Ma0EL6JI
   LTsdp77GTVSgsebVvnPReG/flfwjmJnaaLrNJDfpb33pDOWzwaoeV50C+
   APo84ka5zIiLFPm0wn61mAlJewr8UWgi5wyulAQkcny61+aCCToDxG4d+
   TE+Z9wg9csppUiQSIoD+Rqx0f7S8aSKjO0YCNpYndYcWEtb8+DvRujea7
   Ud0lez3UY52cRzqfcruwYC9ZNxcjROFVDCEAO3qF+NJZ/qCJCn83ITiuj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310579612"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="310579612"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 11:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667792772"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="667792772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 11:20:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 11:20:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 11:20:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 11:20:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeh3IFz+I+NLnQdsECB2qNSjiNGZjFnUBdTXhm3Ip+2QgfrVcQ/zvwBSqD5yQXRSz5qcBhVAxMh1hTAlGbR39EyFj5C2m7Bnk3uhC4gozV/0oSGq6zUz2QBPl7CJ33NQRtbzumg8ctXaaX6MRHDfDg1ntBoZsyXU4ccy5qZ8GN4HJo//tEk+8GWAPIkAusZaXr83AWwELOHv80HBCgg0YWy8T5Asp70rVKuft0CWrIRZE+6nIw2BU++6/ORvxnBfM7uPOucdGXEHuVoERy+/CHx8aiuo+qQ9pPZVn3wh73RFPYs4d6yo1DBy1NUAZtgyLHfhnydPZO+GHdEHi0LxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofr1CDhiOekO6W/8KMHQ4ArSu1mOtBug2QttVwSENA=;
 b=WrRN8ysoCh6DlXPSzRgmO+VJxBFgsx+ZRdViy6rLZT+AfmSPtVct2ajm5LsFCY9hKP4gc9OL1kFtizu1j/ViwgvFh/RQ8nhotXzqPrX59OY5UyLlbhjpB6vg3DlmW7BzifRKF2bgqDskDLCchtBtf2AObSvTL4W7dl0ldFDQcaf2RI7YxqAZ+lVk1fI+WKP5ZBopLvo9+IZjFJ71ZdlYH4izcPOpTcRrp5uTGwkxuFC1nk6Q6XkbyNrPLC+RmG2SMabnZr++pWQYmvcFG/Fx4X3ZgRfa4ktH+9A64QdYndNUyc1VJP1gYuDtOAOMYRWWXPIfaZNBB/2HQn2e3HmoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 19:20:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 19:20:16 +0000
Date:   Thu, 9 Feb 2023 11:20:13 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 3/4] testsuite: fixup KMOD_SYSCONFDIR_NOT_ETC tests
Message-ID: <20230209192013.gp43gprura7agfen@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
 <20230206140449.574631-4-emil.l.velikov@gmail.com>
 <20230209152521.ppntkfsyxsfdxcg4@ldmartin-desk2.lan>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230209152521.ppntkfsyxsfdxcg4@ldmartin-desk2.lan>
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f59c4c-ef83-4dd0-f066-08db0ad2ac98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMQFl1J64ZBCdtxQHwtCqTsRrAVmoqB+ZiXhqpeGPWtyZF4d/a2hgKIOTuFm86PluZuK9lUEIKpsRiqKd3kb0KqiFXqYYVvPsq1GNWbPd4UWFvzFSeY8j34aLRx+Cl2uXTYY8XcriC8lHRINwrwwf/XgIVrDJaswfhjWr9bjEQ3IbhxO2kfOGyJ5z3POBwzmBkP1yzrNF6+ifJOFJI/umkJyFObTFA+xkDYFWppvubHTzMpw6ijo2THsKVy6eqvyxudYh/rEYcylNOYF7EzhbZ8VRAQh7Kg2/lsfZhgWDf14Kg75hlFFsLJMfCH5casZKc+cvHc24A+6gyaAhMCjiEnDaCJJKlH+o3QGgqbr9qRfZ4QptN5PSj5Jh1gMs5/3fRDpRcweQSr76bhYhQOTBmmyrGYpZGTDGC0H14R34q9q+XpykE/CpKgWz01FLchQBXMSDkAuSMMJZln8HoaqYs36fhmNRf8WiHJKR2dm0DuNmwus8S85/8BB+b7NT9OsyBmuRsiF40mpCVQdrAMsN8n+MkAx50nzL1wYVdy/c4D2v7TdeILQ/ONfMWV82F+8B5m+77AvRusCZoYPus5yTS3Y/QLZaAgluXzhknpU1ZgU3I32jwFvy5kboc9mQu8xlvgnQxlI6sHrHa2ftJv3dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199018)(1076003)(2906002)(66556008)(4326008)(66476007)(86362001)(6486002)(36756003)(478600001)(82960400001)(186003)(316002)(38100700002)(9686003)(6512007)(26005)(66946007)(6506007)(6916009)(8676002)(8936002)(83380400001)(5660300002)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/PiAepWVlmIx9vrsAGTgfWHBr3bqKxesgKgkXppTI+RhMGrvfKuWQvSGKcJi?=
 =?us-ascii?Q?UaqQ2mXmHrQq0F5LkvNFy6RSJS8hcuMIclqyyXXH6ewl30ttCebtccPQYTjU?=
 =?us-ascii?Q?1f6PP0jN7kcJL1AcTouwKNusHx15eTsoSKRH77zuxsV9UcCDmZTwd/27R9Zx?=
 =?us-ascii?Q?b0S7IbLnKko83IteUJTD4p7UggpBp3XF/NTmMl6sLId5AqhVLj8WdmulFbL5?=
 =?us-ascii?Q?7gF7FHGvfZf2nD/tXG2CBVjIaxJUB8liJ+985un5i4AmBXJsSUgRFX+R65UI?=
 =?us-ascii?Q?WakOXMsAFQM67YVzUGAft1+hUskyMdJ47E+VMizmKlhTB1R++oHCynZ0eOfm?=
 =?us-ascii?Q?B8eHj0ciwyGeFQoMqSmTcj6KIkEB8VOpGI0JGqfYDd6+dekEkPSVAfX43wz8?=
 =?us-ascii?Q?MVJNwmZfGLvk8U9m6z48Bl0MvDvfUYOPC88aQaGZIKDIsBuGq3k+4OMPE8bK?=
 =?us-ascii?Q?DF4NMkDLwl2PVVVvYdUQBSMmDRR8Mg8ByGJMSmHSmMXeuWdyEHjKAncsMID7?=
 =?us-ascii?Q?550f3KWz7Elr0nupspQ6l0OR3jPnrwQAH6YDdgC344a1Lx67FFKe2jskhV5b?=
 =?us-ascii?Q?A0VGsWa5F8RpZ4xSAbUFVZc8m9uyR/4musG7mFKn1xx88vUGB5PCr+96AjlJ?=
 =?us-ascii?Q?efAyhjf1IHk8HkM5gIVC12v51uSXlOsodkzcyzHgLoEreG35SxJEyoN/dhZP?=
 =?us-ascii?Q?tN44t9VT0Uzt096N+5n1oRtahvh5e6TMxlxgz8PfKeXDsJtyILNyOVWTurea?=
 =?us-ascii?Q?ZZ2YUe+efP2Cx2TVJjA1r+ZoZ2p0l+Wd6VqGKu3jCSyjUSZQWhryZ8+Tmble?=
 =?us-ascii?Q?rr0ZzeumqFRo/GqgbsXqs9zoptLEVscvls50Gq7nHANu/iBMHXe1oFhJCWKr?=
 =?us-ascii?Q?8bdpY/pf8K6627nwzS+/Hvcvi16k0JNkXQGIYd31/mkmTj5BPUUtPTPvJyb4?=
 =?us-ascii?Q?1P/NqCdudYUuKlwTpkfXoaJl4AlrfbosuCgkLVFqNik1wnxUUNYX2NtRLemx?=
 =?us-ascii?Q?1Xg2j35I0T3IaG+pYQbiL6m+xOragzneoF6Rd0FjBCAz7ItYWNCKINPaftYB?=
 =?us-ascii?Q?SKLaAtDTiJC4iQ0ZtoYh1MJoD23ENMcweedH4FVCiFdCBUCOKhfOGttLkwY2?=
 =?us-ascii?Q?GESTKNgmxZ7cO1e1KxWWnDFNqFjaoUhAIB27UQkagpz3vH1Rin6TiW79lSf3?=
 =?us-ascii?Q?uyIfHKKaTpw/6O29RkaHCd7kYgRDK2KAEYsEeAt8cyo/JbK7Yj1cMK0ZTNs1?=
 =?us-ascii?Q?qGxl2ScxmqdXeSpBhByyXET8pUbBqMdpb22VD3oWq6hTYnCg50fbdl7EvLp1?=
 =?us-ascii?Q?ovWWNpmAI03Z7mBgQAInrAtCbz148/ltM/LmzYVECF+8fhE/R/t7e0Rce+qq?=
 =?us-ascii?Q?fXHiweIs4jN4bb9wsOHuVlqzCrLLgs0vbQUQ9LWoAswGZDmD21k2WCnW+Ehc?=
 =?us-ascii?Q?tOzuPC4Geqs5oIQsXM85cRhC1tdMWRhcUhDRhnmbvy2kBVoBwn0MTuG4pKDa?=
 =?us-ascii?Q?R1dua8IzSASaOsSNo/enHgJyJXoruOlijTf05iqsXQ4VQFnwQtyJP9mPalui?=
 =?us-ascii?Q?1ydsWwRSmjtfiTUxFX4BCkEgq2ryjOvVvEQBw3prphPCP1ppUcLfswj3pnJh?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f59c4c-ef83-4dd0-f066-08db0ad2ac98
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 19:20:16.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XAGdZcyQwUE+68xa3tGIVqgzGw1EU7+xNKwLJm1OZGOlifIKISBKnLfqVqkcYxMrjCoIs18jbLAYkey1FG+z11BXEMEpLOXCoR9po6NZIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 09, 2023 at 07:25:21AM -0800, Lucas De Marchi wrote:
>On Mon, Feb 06, 2023 at 02:04:48PM +0000, Emil Velikov wrote:
>>From: Emil Velikov <emil.velikov@collabora.com>
>>
>>Currently some tests lack a config segment in `.../etc`, yet they're
>>skipped when KMOD_SYSCONFDIR_NOT_ETC is set. Inversely - some tests have
>>a config snippet, yet are not skipped.
>>
>>Go through the lot and fix them all. While there make sure we use tab
>>for code indentation, as per the style guide.
>>
>>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>
>$ cat testsuite/test-depmod.log
>depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
>TESTSUITE: running depmod_search_order_override, in forked context
>TESTSUITE: SKIPPED: depmod_search_order_override
>TESTSUITE: ------
>TESTSUITE: running depmod_search_order_external_last, in forked context
>TESTSUITE: SKIPPED: depmod_search_order_external_last
>TESTSUITE: ------
>TESTSUITE: running depmod_search_order_external_first, in forked context
>TESTSUITE: SKIPPED: depmod_search_order_external_first
>TESTSUITE: ------
>TESTSUITE: running depmod_detect_loop, in forked context
>TESTSUITE: 'depmod_detect_loop' [127296] exited with return code 0
>TESTSUITE: ERR: UNEXPECTED PASS: exit with 0: depmod_detect_loop
>TESTSUITE: ------
>depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
>depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
>FAIL testsuite/test-depmod (exit status: 1)
>
>I needed this:
>----8<-----
>diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
>index 2bc2e90..2d55b5d 100644
>--- a/testsuite/test-depmod.c
>+++ b/testsuite/test-depmod.c
>@@ -159,6 +159,9 @@ static noreturn int depmod_detect_loop(const struct test *t)
> 	exit(EXIT_FAILURE);
> }
> DEFINE_TEST(depmod_detect_loop,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+	.skip = true,
>+#endif
> 	.description = "check if depmod detects module loops correctly",
> 	.config = {
> 		[TC_UNAME_R] = MODULES_UNAME,
>----8<-----


ok, I'm going to skip this patch and take the other 3. I solved this
differently, by just making the testsuite compatible with
sysconfdir != /etc. I will send that patch to the mailing list, I'd
appreciate if you could review it.


Applied patches 1, 2 and 4.

thanks
Lucas De Marchi

>
>
>
>Lucas De Marchi
>
>>---
>>NOTE: this is based off my earlier patch adding outdir. If this patch is
>>applied prior the depmod_modules_outdir hunk should be dropped.
>>---
>>testsuite/test-blacklist.c  |  2 +-
>>testsuite/test-depmod.c     | 22 +++++++++++-----------
>>testsuite/test-modprobe.c   |  7 +++++--
>>testsuite/test-new-module.c |  3 +++
>>4 files changed, 20 insertions(+), 14 deletions(-)
>>
>>diff --git a/testsuite/test-blacklist.c b/testsuite/test-blacklist.c
>>index d03eedb..6531fa2 100644
>>--- a/testsuite/test-blacklist.c
>>+++ b/testsuite/test-blacklist.c
>>@@ -96,7 +96,7 @@ fail_lookup:
>>
>>DEFINE_TEST(blacklist_1,
>>#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>+	.skip = true,
>>#endif
>>	.description = "check if modules are correctly blacklisted",
>>	.config = {
>>diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
>>index 6465230..010f259 100644
>>--- a/testsuite/test-depmod.c
>>+++ b/testsuite/test-depmod.c
>>@@ -41,9 +41,6 @@ static noreturn int depmod_modules_order_for_compressed(const struct test *t)
>>}
>>
>>DEFINE_TEST(depmod_modules_order_for_compressed,
>>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>-#endif
>>	.description = "check if depmod let aliases in right order when using compressed modules",
>>	.config = {
>>		[TC_UNAME_R] = MODULES_ORDER_UNAME,
>>@@ -75,9 +72,6 @@ static noreturn int depmod_modules_outdir(const struct test *t)
>>}
>>
>>DEFINE_TEST(depmod_modules_outdir,
>>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>-#endif
>>	.description = "check if depmod honours the outdir option",
>>	.config = {
>>		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
>>@@ -104,6 +98,9 @@ static noreturn int depmod_search_order_simple(const struct test *t)
>>	exit(EXIT_FAILURE);
>>}
>>DEFINE_TEST(depmod_search_order_simple,
>>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>+	.skip = true,
>>+#endif
>>	.description = "check if depmod honor search order in config",
>>	.config = {
>>		[TC_UNAME_R] = "4.4.4",
>>@@ -130,6 +127,9 @@ static noreturn int depmod_search_order_same_prefix(const struct test *t)
>>	exit(EXIT_FAILURE);
>>}
>>DEFINE_TEST(depmod_search_order_same_prefix,
>>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>+	.skip = true,
>>+#endif
>>	.description = "check if depmod honor search order in config with same prefix",
>>	.config = {
>>		[TC_UNAME_R] = "4.4.4",
>>@@ -156,9 +156,6 @@ static noreturn int depmod_detect_loop(const struct test *t)
>>	exit(EXIT_FAILURE);
>>}
>>DEFINE_TEST(depmod_detect_loop,
>>-#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>-#endif
>>	.description = "check if depmod detects module loops correctly",
>>	.config = {
>>		[TC_UNAME_R] = "4.4.4",
>>@@ -183,7 +180,7 @@ static noreturn int depmod_search_order_external_first(const struct test *t)
>>}
>>DEFINE_TEST(depmod_search_order_external_first,
>>#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>+	.skip = true,
>>#endif
>>	.description = "check if depmod honor external keyword with higher priority",
>>	.config = {
>>@@ -211,6 +208,9 @@ static noreturn int depmod_search_order_external_last(const struct test *t)
>>	exit(EXIT_FAILURE);
>>}
>>DEFINE_TEST(depmod_search_order_external_last,
>>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>+	.skip = true,
>>+#endif
>>	.description = "check if depmod honor external keyword with lower priority",
>>	.config = {
>>		[TC_UNAME_R] = "4.4.4",
>>@@ -238,7 +238,7 @@ static noreturn int depmod_search_order_override(const struct test *t)
>>}
>>DEFINE_TEST(depmod_search_order_override,
>>#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>+	.skip = true,
>>#endif
>>	.description = "check if depmod honor override keyword",
>>	.config = {
>>diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
>>index 3ddb976..6b763d8 100644
>>--- a/testsuite/test-modprobe.c
>>+++ b/testsuite/test-modprobe.c
>>@@ -84,7 +84,7 @@ static noreturn int modprobe_show_alias_to_none(const struct test *t)
>>}
>>DEFINE_TEST(modprobe_show_alias_to_none,
>>#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>+	.skip = true,
>>#endif
>>	.description = "check if modprobe --show-depends doesn't explode with an alias to nothing",
>>	.config = {
>>@@ -176,7 +176,7 @@ static noreturn int modprobe_softdep_loop(const struct test *t)
>>}
>>DEFINE_TEST(modprobe_softdep_loop,
>>#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>-        .skip = true,
>>+	.skip = true,
>>#endif
>>	.description = "check if modprobe breaks softdep loop",
>>	.config = {
>>@@ -200,6 +200,9 @@ static noreturn int modprobe_install_cmd_loop(const struct test *t)
>>	exit(EXIT_FAILURE);
>>}
>>DEFINE_TEST(modprobe_install_cmd_loop,
>>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>+	.skip = true,
>>+#endif
>>	.description = "check if modprobe breaks install-commands loop",
>>	.config = {
>>		[TC_UNAME_R] = "4.4.4",
>>diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
>>index 9872b78..dcb9934 100644
>>--- a/testsuite/test-new-module.c
>>+++ b/testsuite/test-new-module.c
>>@@ -106,6 +106,9 @@ static int from_alias(const struct test *t)
>>	return EXIT_SUCCESS;
>>}
>>DEFINE_TEST(from_alias,
>>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>>+	.skip = true,
>>+#endif
>>	.description = "check if aliases are parsed correctly",
>>	.config = {
>>		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-new-module/from_alias/",
>>-- 
>>2.39.1
>>
