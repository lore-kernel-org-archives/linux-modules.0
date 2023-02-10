Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F5BC636D4
	for <linux-modules@archiver.kernel.org>; Fri, 10 Feb 2023 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjBJWbL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjBJWbK (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 10 Feb 2023 17:31:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3A7FECE
        for <linux-modules@vger.kernel.org>; Fri, 10 Feb 2023 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676068268; x=1707604268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eU++6mVCnBUWbzGqZQvxqIpEkphP1+5+0YXnSqE/g6c=;
  b=SDltNw4ekUKcS3x+cJzqWmpoPGk6k881f9+j71aZUv90us2T3m0klrtz
   N5BO1ZJL670bpa5T3hqX/XK5cyq9kyZO7kbuiE5/duXjpnA5fECXVrxL6
   k27mQO9dhIve/9U/nH3X1dgDfiwZYUScSjLMnEyDkVz77lSjUwLdqjCJD
   eguNeNhp8IkBH6Y6cFz+wqlHiV95fFtCRXIrXA1j6hUjegoNTA35fsLEh
   eSGY15zicNap8NIoBHG5T8WecgRJ1LFlmtHvHxCO8z/LCCKh54iT3rR/H
   fJmF/cFEL4trZkwR/7oENlnKwhtav7aBVzc2abarc3RUqSeBPySVmdunu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331846841"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331846841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="618037304"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="618037304"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2023 14:31:01 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 14:30:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 14:30:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 14:30:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGGY+4lQ4LDbcve9SIbPI9RUH4bE4psCYfoYw/Q24hXgTFpXjlyXkaXgt3TxaxN4tKGKzt3Q9YPcT5ZfhLVMxziBzZ/3ViN0DRMX+65ZdSMWJe9dSUSjPMv/QMubOxpD0eJDIStqAWtic6plOyA6TgXWm3t5JBhwjk/EIuiHe8d98GnQtFQrKcjm0bCLRH20puK0uI6Lxjw4+NtYvqFXb91tdXIBqsoJGm7yqwd4znTuEJJXWSB/19mP5YvBwnOhXyJjcfKbqCfRXMDeQ1fD+UxVUhDt0qJ/q1ajMYrlCjmfDOFHpIiOxx90xt83NRzRQUqrdlDMDXcL97hvRzYZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU++6mVCnBUWbzGqZQvxqIpEkphP1+5+0YXnSqE/g6c=;
 b=GAkMQuE2qEd+tRqTmANnofz4kwMpSF0uJSoHjt1R1j6IfOUbzclnPY6Cx2DpihX0lz5VhqvaQeKslH0f8Yy1z6LWELrZ/G/uyM9vrw3duTArE9Be1xMc0wGSdu+RX1s4+wFX60+b+kih3heqH6ajYKtiSMEyxHIlf7fm0v079LJa7D+QHrJeLtupI3bzYnHq7SV05Z/BtcyEiYdapqLZHvAaIT7BUChMn0HPZwUJNs+p0B3oYQ99/T7Jgnpl4HBQ5UMR14CNUP9uC85MJquPT5kFGhGbHK89WRtjWrzZGlKVfL2TDYXt6M3dV73U3+i0/lVNKX+oYOgkF8v9Tg0L5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 22:30:43 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 22:30:43 +0000
Date:   Fri, 10 Feb 2023 14:30:41 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 2/2] testsuite: Handle different sysconfdir
Message-ID: <20230210223041.bl4peddyigbwqnll@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230209191946.243317-1-lucas.de.marchi@gmail.com>
 <20230209191946.243317-2-lucas.de.marchi@gmail.com>
 <CACvgo53f36vk_AwZ+VR-aK_xSrps2TodYPp9aP5r13qM9hvrqQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo53f36vk_AwZ+VR-aK_xSrps2TodYPp9aP5r13qM9hvrqQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 092668d7-445f-4112-4a36-08db0bb6723a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYLSCoR9kMV2OMZ/mDHmw2yLk6ZAuWthmFVObSpQBj8Nf5BpwIRT3mepT1/rqkGVnsiinzTawmVMaJS5PemPwb1w2kHClfVZaFPeAx1kRGP2kqFUMV88KIqe2Dqf82sUdhxHHU9L0eTf6Ns+YB6mmpeDghjTAagrXkgVfvaSwr231Qjo4OgeH8xQgQxoGkETcvejEmVZZs30tOlcP8r5nU3mK9lKKAXRtgyKh7ehuK6b4EJQMKbbKX5DGTY++eb/8+lzvzy545uJPY9AxSgzTxoVdGxz/+25zZEdUbP3IaOTQpQlnZof2F+N4urmyxjeLXoMoOSgKy4EgScB1NkxatQidPgoFmbstfnbTQQcxzhJoqFy1uZgeJB2xNdZew68xrKObFJa0ssbvndX4SxIDrRfyi2UN95zWbuPqY9aMvBF7f6MU3WDiJFyTE80Jz8pdYGz00ITQZDSxj1cOfeACxH/pJeq2eIVAw+qc/sLKtxb5AxMNzM2NTtdjlHBzxlEktmFW0QWZPzf6VMdTTh+bLBW3O7MnMDq6RVELPUgDjbFZtRBObbepE/2RduZlxifjelmfEO8dymItqmlJFrnVEe+3+5rrTP9C6lgDV7PV3qAAnN5cKSod35isZZWfXSUBxhc9vXtCNQsXU1g2KaoCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199018)(8936002)(2906002)(316002)(4744005)(66476007)(41300700001)(36756003)(66946007)(66556008)(5660300002)(6916009)(4326008)(8676002)(38100700002)(82960400001)(6512007)(86362001)(6506007)(9686003)(186003)(1076003)(6486002)(478600001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7YI8lpmcCk6SOFIwuBZROsGeND160oi8btSgTMOdCbBEcPV0XmH3oslqX7ON?=
 =?us-ascii?Q?qntt5SsjQV5AfcpfSrdUljQFulDdk/7s0BryG0g0WkU9Goz61BY600MvJzG1?=
 =?us-ascii?Q?2eLjreI4kZ7feZX9nBi/kWsDEo2IjFDos3WmrJ21m8Pq4CZRQBlT9uNepGwk?=
 =?us-ascii?Q?h5VHqvMwPgcO+nb4wJJdOS3IFaghatKlh0XwB1ancg189AOSx7vVMCdI8r21?=
 =?us-ascii?Q?K4NATpUROHy/8PFPq/M2bzSQxrdKo766+xNTFdS87weGTtXMXMOYV04A+sNq?=
 =?us-ascii?Q?utAh53ecsWDVLV1nK5THBlhS4DjDgzJXy9xDO/vmCrJ4lt1TfUYVOMXPdcEz?=
 =?us-ascii?Q?UCrsBOMWyfbbARgiZZ+SeVsnYy2hALn6uEcWXWuyJvmVarF28IYj80/Z7nFo?=
 =?us-ascii?Q?y5qWiCETpdcst23Qv6W0KKz0TrcQiIErwzvYKsydm7r9kVzeILQTCIw4Af2w?=
 =?us-ascii?Q?/420wRYGFttQ/c4GrTN2NqL2EXC5roMTA55Fdps8803BmQer7Lm8cuYxEKM4?=
 =?us-ascii?Q?ndbpLa+y9l0Q85psMz9ZAa9imVHp03m9PMoqsqqnRV3LPMH/r++lLcVs4qLC?=
 =?us-ascii?Q?c2cl3avXeeXSxemVQEIBjBAH/egk4usYcODZJ0LHEiEGKXJVkQmeQ5V9Dcav?=
 =?us-ascii?Q?6jnyiThVlVn/M2L2jz8iZl7Or5864w8jZdmkCzd7Hs0S0L5EZgbtj1KGJIsW?=
 =?us-ascii?Q?8xgNlj9XkjU/dWtdQU57vYOodbI+gcMc0S3TezuiYq0O/avW6XdQPrmF0WgO?=
 =?us-ascii?Q?QQFy98ACKnLIZQ2X5yiD8AK6ZHzM8d9k9pGf3CeOKsEvsMAuXuveDoecfDdi?=
 =?us-ascii?Q?+jSQWvoIsPd42su69LvNw0WLMDzKTO9Pg2HCSA9f8wIYhwCgmCEPyirDWZV1?=
 =?us-ascii?Q?GGDsVnftGEIDUV1N74Bwy6tjwEH8PTX3GzwMskToGfYFEJG13Ia1xEz5CAvE?=
 =?us-ascii?Q?iRJD07DYxEFGcwbJbDFTcVIqYobpMw+MAUuPD2STDu8VjA1zXUj2GApFny0g?=
 =?us-ascii?Q?q/fBRqMEtES9nGlH27EAHgc2XPk6/wmK3FwpvnF3kC53O97tz6gA/WjKgA7P?=
 =?us-ascii?Q?2xMXX931h+NHZgQNMPRIgA71lMrGryBCZA6g6wPdTPgC5MJkVjFzQmxqPH4E?=
 =?us-ascii?Q?RoYMoQ7MppWlRBc3+KiheFcwi1JQG+AtJGZhJR+SayFVfAFhq2Zpl6hRGQbe?=
 =?us-ascii?Q?P456jPcD7McEqIaJcUZEza57FTta/0JmWhpalebFf669N91dXnoYq/BeBNW1?=
 =?us-ascii?Q?BNz348EqakNIzp7EQReoTVM/sXUkB7z3LRi9TW+CfEMw0K1kb/urjgNk7wq9?=
 =?us-ascii?Q?K/wupa9XKGTxdYzYdmpPpzuJVZd5CdAJBIeAn7499u8K/lzuRYSSPhpf3HuA?=
 =?us-ascii?Q?wtUqS6G2YzTXPInDFwdps5fMHjZNKjJ1jFaRFmjHZjtvQgKTDhqkuY3pvR7N?=
 =?us-ascii?Q?vm0Dpcl3tYd7Y5IReiJD0b6dyT6mJUMhMeqWAIlhCxJ9hXqz87xnOopODZwk?=
 =?us-ascii?Q?Vq70ymakTLC318Dg5eQay4sApildXHRkdA5ecmERVNJYwJpuhWK8UXWlUX81?=
 =?us-ascii?Q?ZBoQQvIZqyjUpSPi+vFNxu0IcKx6bevi/eJaFMnzkK86ysqa2lD4GLKThGPf?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 092668d7-445f-4112-4a36-08db0bb6723a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 22:30:43.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxDzj0KYjn+qr616rRgg8iuPMfjmiPAVOeNO2ixqwi513/GHIZbMUbMRRRxq2d5hpRz/fIBCOK2IEVWYfMwAais3qGwiZPpd92qJB9mkj/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 10, 2023 at 11:16:02AM +0000, Emil Velikov wrote:
>On Thu, 9 Feb 2023 at 19:20, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>>
>> Instead of skipping tests if sysconfdir isn't /etc, just handle it
>> during the rootfs setup logic.
>>
>
>Nice. I'm far from an expert in the kmod codebase but the series looks
>good IMHO. For the two:
>Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>
>SIde note: while looking through the Makefile.am I've noticed we're
>doig manual SED substitution. Didn't look too closely but it should be
>possible to:
> - add respective files to the AC_CONFIG_FILES section (barring .in suffix)
> - drop the explicit makefile rules, sed command and extra_dist/cleanfiles
>
>Don't think I'll have the time to submit a patch, I'm literally on the
>train right now heading out for a while.

no rush, we can improve it later.

Applied both patches, thanks.

Lucas De Marchi

>
>HTH
>Emil
