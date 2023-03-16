Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72777C6FD19
	for <linux-modules@archiver.kernel.org>; Thu, 16 Mar 2023 08:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCPIjG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 16 Mar 2023 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCPIjD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Mar 2023 04:39:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8C6FFF2
        for <linux-modules@vger.kernel.org>; Thu, 16 Mar 2023 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678955937; x=1710491937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RHykVyhTzKspQjIvBQiR5AOnaVsiIAtayMrFoYv4UgE=;
  b=nHnXK6B+udIm7Sqs8MdIwc6MCI+kQWlZft1Oq8onlKOCfu8VIksoDzok
   oYBCGqDRcaYdTKWfx+0GDnYl1244s9h2O8uii0HHEIE6rbr5O68W9vgNX
   zMCwWAEDpJ3+afO8bZDnJ9fBSqadR43ROxj+lnAyldAb8A/mrPda7EPel
   3QRzMy5V0AS4VHH2t3heO1W6WtFtrnswKmjZxnKs+JKq2F9iUfEcp7bP8
   8FRPXVsdplphxyyV4W0vRjJI6gxeqxuxjGzJj7JNWF3t3GxGo2o7O0y4X
   jj65QJyMdK4AQhXOx8aD/6GTrQlTplnhgIdNjx7f8xq0oJ0+kJiTsJjSK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="317577776"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317577776"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712264735"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712264735"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 01:38:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 01:38:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 01:38:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 01:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBMvxTdjtxtopdemoSj/g3wgedqjcDhW+n0+9Pq2rGrG1PYF5jmudnqzq+gL4dv/4cuHsO1bH5AQbNATKSVIxYTczP+2/sG9s0sW1Kh5MxcsRSNDA+LNrqXaAG47cHjvcKq++A49k2MLksa2IC8ZcDVdkju1B526erYOcqr3hXTWCWwPjmh8cXvC2xmIMZt4L2SP/KwkTVawc3JO4a7TGRPSC92pu57Hdkikqxx4aoVK+Jni6Xt7GS1J3Ed/6uu5un/eL6+UfXdSlMcKHmQnu8WsNJn3t+/4N2pbesIikBzmgxV7VA5cmmY/Meys9zVQaHs3RL/uiAkLkEXZ28vH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4PSofG88WvH1Dt6n+VL1mF4ZUisEZx6W60eMtJIqsI=;
 b=aN2/j9c79htWrd5BAjqxUkJ8c3ucQGrBA0JRXgr7y7rtgpuIvHf/+E4aDXsIOTDyLgY5cqBShzjF07HALoOkBkERgTdT88ZNd+XPq/50VtZE5bOaKjkeMtqjmSR6fnKEJMeFldbtMfuqvjoQJoquG/v/oYzyhvUAf8CemnUBtD3Ytbdat7d9XaMca3LVsVInBETILD1hAdYTND8uTEKLSXnjKCiREf6A38rQwQTRXhVp96UcfQZ/HUg61jEPjazy4PCTOtgB2HOK35WwoMFNhf1KYNys6vN935pAz0uw85BybO2M1Jy5lbcHD+bUygahNucTM+Q5RmRsjTUdkVmW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 08:38:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::2629:fb12:6221:3745]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::2629:fb12:6221:3745%4]) with mapi id 15.20.6178.017; Thu, 16 Mar 2023
 08:38:23 +0000
Date:   Thu, 16 Mar 2023 01:38:20 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Nicolas Schier <n.schier@avm.de>
CC:     <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        <mcgrof@kernel.org>
Subject: Re: [PATCH] kmod: modprobe: Remove holders recursively
Message-ID: <20230316083820.zonejqpbt7adpi3l@ldmartin-desk2.lan>
References: <20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de>
 <20230315181608.oqjqzgm6mxi4jhqf@ldmartin-desk2.lan>
 <ZBLSTBejsoZQGcNs@buildd.core.avm.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZBLSTBejsoZQGcNs@buildd.core.avm.de>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: df6b7fa8-bec0-4526-9c4d-08db25f9cd95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15/S1d6jxlT+VGT5JDRktipTGFnzV82U2xsHalTFzj5iekX1WWU4WEeHoC0hPkWCC1rSX2uTCsMeVdQ0IJnHH15K6qF9Bfig72jOR1uVeYxvT8VdClmMqZtkqrLotUvS/ZDXB3/EBZoLnpSj8R31iEpjSCj3macok2bbq5ifgH7hWdMIfAOzNM3+rFaeMQaqtWVWdJ6hXsDdyLYKTb/KXOI13wPtV+cGHWA2gUc5XqHIJt5fa1KO59/DQzricKJS93y92JCnvPhDjdvbOBZqTY3Xl+zjaBzOopQ8DnSekcoXMmnI9A3MS/qVNaj4S7rtRA0d4Otw7x+GfFoeiSR4r3X0kxDM/ySOfhceq0SpEVOCBMnc1J/dS3z7rzReaQsm06h2O2q3f+TVpoLN9NzMk1jhh/J6deQo0MDV9vAfCycwGCPCfBT23SrS7Jr+qQw6ZouSOdHOn0uteNQyGknHHNDhQiF6ZvAz4rPS3el5taOhW7t0wtWPk/M9ERzbncPhkp/M5F4/tabkfY6J8elzUJ7entNDT1kmr/wc8Hpmq9JBMiMcPPrvdzr+IxpPwRgiJm1f/hMoA9pqV1elDtO2rSEokIrwoh81hPvLQ9b/EjSP/RzKjMO8qGR03sj3FP4Pvv55q+qTl9q+JtB3FJ+3Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(38100700002)(82960400001)(36756003)(66946007)(4326008)(86362001)(41300700001)(66556008)(8676002)(8936002)(66476007)(6916009)(478600001)(316002)(2906002)(6512007)(83380400001)(5660300002)(6486002)(186003)(1076003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjCCTUjbxgbGxbLLXN2w1FZm4tvD9aDjNNUcRFsaI/IR0x+PXPwQNkRg3lf7?=
 =?us-ascii?Q?GDYpZ3kFi4u+07LQCAtJ4J+LyL0iCA4vfqzk4MlGf+GP0ogO89nr1a3gCkYL?=
 =?us-ascii?Q?HhKjzF1Hxe67g17CmwSAkl873Tn4rR2Lvgpd7bPqx52zdWrZj10NhIkhB70e?=
 =?us-ascii?Q?cw/uNxkVQ8kJbeTfyrXlHHqXW0csN5TLDGAS8cHUj0duddpl2sbfd4H3cBJw?=
 =?us-ascii?Q?XKuvAp90+euvEU9vYZ9lajoqZwWVWdrcAJEs031E2/2oK15SgLg78eaNJcDX?=
 =?us-ascii?Q?cYHqb5uLOI/85ul/YgEQD8ct0r19jcQ/0o31KeYHKVXilgNhHZL8gADFCBD5?=
 =?us-ascii?Q?xoIdbC4Sl5SVfDp+dBKcxxu2+GEOHuQU7zWjVD4R4DEdXktMuTC20pe6MLnH?=
 =?us-ascii?Q?z/2trO2qpDcy8YXnUbKUnAChec2Evjl4EBX59M0xNRo5AiZErCmKSrhoH/XP?=
 =?us-ascii?Q?BSYXtbe4wRgEul6PzBcroCKWcz18Z/bZ5P1pKmCbis/Ize2gqUkjb2RFDzNQ?=
 =?us-ascii?Q?74J77m6aMQqY+2OF4DlslsLWd4bWpQvrs3wuA52VW8YMITXyC8GDk5RBJv74?=
 =?us-ascii?Q?lY+BloiEb8M46g2aZwGHnk6ebz0l03DYYWCx2eMc4ugACXg0iOf9206hnN7b?=
 =?us-ascii?Q?XTZBZIxuP2YWADEACpQ/V00Pwzkv6TVNVp9JXfyJu6A5bGmwd5VFvCuDZY1n?=
 =?us-ascii?Q?6Eyzn99EkxkOdNsBpCwKPVMt5BP3kb178uCJCGxjp0rHrJa0CYbgwuDN5sDZ?=
 =?us-ascii?Q?bWKWyv7fHCIxJe28xADSydy8DCUsJezN9n0Z8b3D+silcBmfes82Q5ykgi6v?=
 =?us-ascii?Q?o7BhOXqPGU+yXmwHQ22572vd1W9U7yaf8/k5Wlgq1+fykmOmMSO7jP7X6iYc?=
 =?us-ascii?Q?j8nf3eQHV3zcmWn2D5sp1OGWjLwv/2+e76x2dFjyt3q9kUQEKOaT7Ji8SBOK?=
 =?us-ascii?Q?tKxoer5k0w6JtOtmkE0ctQ63bBPDDfVyGKMi2N0FMXd+wCJyJNK7ee7fapi9?=
 =?us-ascii?Q?7tJ8EiWj1e8yz8yFl21DuEPiE3QPG+vDbaWfX4TAqd+O5sgHNr88lsgXrXMt?=
 =?us-ascii?Q?SxVYImuzQQ2NURtkLwt2hkM3vvC8y46IZ2e2l7MBR6VBINWbvVT3qmlzrtUO?=
 =?us-ascii?Q?8l6fF+OWPUsxUhcnPfrnIz4GQ/fDF7p23k8ORyvGBSqDUd909CFxj27kPy26?=
 =?us-ascii?Q?tZyq3czhBvI1yHfyeHnP3rNZIlvCAdLBx44iq42n7biKOm6PG3NAy4vA6kMl?=
 =?us-ascii?Q?pK3YEnY8WZwUsQNClqKBE5mA72CZn07EZWgM1U1hORIWoA7Hb4dCEiXdRNAT?=
 =?us-ascii?Q?fb4cKewKWbJYzZVQQhEYhR5JnHJB9W/bmS7TaX1d4hJICQUvyVK133jUNz7M?=
 =?us-ascii?Q?DN5/4Afw2ATlxmtyoT+GHlvo/wIYAiWsEfch//yK0CLpai/raqXBHEAstIRp?=
 =?us-ascii?Q?kZqvg9qjcdlaGYi+nJ4qo5FUQ4rGaZFPs65qwXypSTUYAoBUw2qP8RPujgjz?=
 =?us-ascii?Q?aqLVQlWRCNhNhRnOLN4sC4yQ7bbtdIci+hZBCiF8nplVZ/0jBIHkn6AoI8L/?=
 =?us-ascii?Q?wfqFEX6uYnWZVaD+OnGBUFCFqAlZhq4wTTMdynlvRQ42sfRJJzFlzLFQPVGp?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df6b7fa8-bec0-4526-9c4d-08db25f9cd95
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 08:38:23.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1O2SQ2l1AcysVQweQjiY4gCpATgwCaYCAsB8/7JeZVZp1MSZPy7s5n6TANaBGqHHOfVdmjVz2XtaoBRM0777ydDShXSTGXSHkXM8zyjOpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 16, 2023 at 09:24:40AM +0100, Nicolas Schier wrote:
>On Wed, Mar 15, 2023 at 11:16:08AM -0700, Lucas De Marchi wrote:
>> On Wed, Mar 15, 2023 at 02:48:16PM +0100, Nicolas Schier wrote:
>> > From: Nicolas Schier <n.schier@avm.de>
>> >
>> > Remove holders recursively when removal of module holders is requested.
>> >
>> > Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
>> > also indirect holders if --remove-holders is set.  For a simple module
>> > dependency chain like
>> >
>> >  module3 depends on module2
>> >  module2 depends on module1
>> >
>> > 'modprobe -r --remove-holders module1' will remove module3, module2 and
>> > module1 in correct order:
>> >
>> >  $ modprobe -r --remove-holders module1 --verbose
>> >  rmmod module3
>> >  rmmod module2
>> >  rmmod module1
>> >
>> > (Actually, it will do the same when specifying module2 or module3 for
>> > removal instead of module1.)
>> >
>> > As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
>> > remove all three modules, as after removal of module3, module2 does not
>> > have any holders and the same holds for module1 after removal of
>> > module2:
>> >
>> >  $ modprobe -r module3 --verbose
>> >  rmmod module3
>> >  rmmod module2
>> >  rmmod module1
>> >
>> > Without recursive evaluation of holders, modprobe leaves module1 loaded.
>> >
>> > Unfortunately, '--dry-run --remove-holders' breaks with indirect
>> > dependencies.
>> >
>> > Signed-off-by: Nicolas Schier <n.schier@avm.de>
>> > ---
>> > While commit 42b32d30c38e ("modprobe: Fix holders removal", 2022-03-29) already
>> > implements removing first-level holders, indirect holders were not evaluated.
>> > In a simple module dependency chain like
>> >
>> >      module3 depends on module2
>> >      module2 depends on module1
>> >
>> > 'modprobe -r --remove-holders module1' was only considering module2 and module1
>> > and thus had to fail as module3 was still loaded and blocking removal of
>> > module2.
>> >
>> > By doing recursive depth-first removal this can be fixed for such simple
>> > dependency.
>>
>>
>> the dep exported by the kernel didn't require it to be
>> recursive AFAIR because they were always expanded.
>> For your case modules.dep should have:
>>
>> 	module3.ko: module2.ko module1.ko
>> 	module2.ko: module1.ko
>> 	modules1.ko:
>>
>> Is that not the case anymore? Was it due to a change in the kernel build
>> system or something we missed? What kernel are you testing this with?
>
>For modules.dep that is exactly what I see during my tests on v6.1.8 and
>v4.9.276 (except the /modules1.ko:/module1.ko:/ typo).  But with both
>kernel versions, holders exported via sysfs are only direct users:
>
>    $ sudo modprobe module3
>    $ lsmod | grep module
>    module3                16384  0
>    module2                16384  1 module3
>    module1                16384  1 module2
>    $ find /sys/module/module{1,2,3}/holders/ -ls
>      [...]   0 Mar 16 08:45 /sys/module/module1/holders/
>      [...]   0 Mar 16 08:48 /sys/module/module1/holders/module2 -> ../../module2
>      [...]   0 Mar 16 08:47 /sys/module/module2/holders/
>      [...]   0 Mar 16 08:48 /sys/module/module2/holders/module3 -> ../../module3
>      [...]   0 Mar 16 08:47 /sys/module/module3/holders/
>
>As far as I remember, that has always been this way; it is definitely
>not introduced by recent kernel changes.
>
>Current 'modprobe -r --remove-holders' does only analyse the reported
>holders, and does not consider anything from modules.dep.

oh.. ok. It seems I mixed things up.  If a module is holding another one
due to a symbol dependency, then we would have the entry in modules.dep
and when going through the module removal, it would work.

considering just the holders, we have to go through then recursively
indeed.

>
>> We will need a test in the testsuite for that and if it's a change in
>> the kernel rather than a bug in kmod, probably revert that change until
>> we have things figured out.
>
>I am going to prepare a test for the testsuite and send a v2 within a
>few days.

thanks
Lucas De Marchi

>
>Kind regards,
>Nicolas


