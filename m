Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78CC43334
	for <linux-modules@archiver.kernel.org>; Sat,  2 Jul 2022 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiGBSl5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 2 Jul 2022 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBSlz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 2 Jul 2022 14:41:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADECDF26
        for <linux-modules@vger.kernel.org>; Sat,  2 Jul 2022 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656787314; x=1688323314;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=h+oW25rGFR4z7MpZf6nCl1vYgw0JAVoaxPw6TMHMakE=;
  b=gI/YwCpf9IdJj/22nUkJim3lgS2XvBAitQ1uwr3S4vZ49KFLCQk0zuii
   sfmzebUFBULYo3Uz6wthIlm6n87txvrRAeu7lTYqb6ZvB3Z7RySX7ibLf
   /jKJTI+TRuNtJfPPEqOt43t+r4i5eMJua3zdp+vwyWTd43iRBWteMSA+P
   zfT+irkWjOKIw1pxecRXu5By/PgiEFvGQte37Ol1AFVNVDjXXOiQ58lck
   1Jjk7xmri1fYEZ3TMERH3F3zfsGPAG7Fn1SNlIkuR/CoQwz+c1aeF6Kq0
   xz1CdPWJRoM3RGT9tsueWjkgA2DEjzqCvp1So2g6APnhRPmpNGBUSaeeZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283971055"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="283971055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 11:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="624617520"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 02 Jul 2022 11:41:54 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 2 Jul 2022 11:41:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 2 Jul 2022 11:41:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 2 Jul 2022 11:41:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvKchieuLjgyQjR4DMbsyqv8nVQjGIz4xus/OV4DCdP+Be4wqhMss+elEFsKGw2zf2BlnaH2caDsteGofDA3QVbsTtIGt4V5tO3SUt3ELkRFq/6yGPRnQb/f88ZadF3agXrcFsVp+WFNkh+KSw9dfOnE0eyjxCip8S8n7Q8E6hKEK/kTcm0Our9JMiGCh1mtXmDwCkRPOUu5YcnVVu0E75/QkoIDkJORWxhtQzSHHhlRYW75b/TB/aOICJNLmQAuwKm8ZNtiGeBGXM+NejzM8Hnuj1Vkbxzj9+UYVkyvPv5omydAB+zPtaNjQI47ly98gMGZ3lvhiX3jyAp67B3hDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ5/RwYr7tm1xF1cYz87BtWsSeJltc+QlYymbBMx6PA=;
 b=IO9L8l3KEpcMltK9sOTNyVeNlpW5XWnpUuSnFYlPQIl0au1V7KjtcjpKfsc/5Zrmc/EOpN01SbNsm1/WfRFsLbBVMwcAGlRKQBaWQPNHEzvTFwsgOLxMmpkKT8CPuD0RhsV3L7KAosv7snhHW6yXFPRHZxuRnfJurW+I+bKsUwhlFHVS1GGxBWsaaNefiA1w/ZhQZjg6cX9EmfCTLkpEoW1H9tS6ezML+/IJ0sw5BUzjPyU+Fovio3vYxM7P/Od24bnyNk5vThEvXiSrH1IVQ6euTItZjlr1/IYbhfDfc6ownBYgKdvEO5P5WpHwkzPXqWSL5yE+0W185bxPT2GYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM6PR11MB4425.namprd11.prod.outlook.com (2603:10b6:5:1d9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sat, 2 Jul
 2022 18:41:51 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%8]) with mapi id 15.20.5395.018; Sat, 2 Jul 2022
 18:41:51 +0000
Date:   Sat, 2 Jul 2022 11:41:47 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     <linux-modules@vger.kernel.org>
Subject: Re: test suite failure for get_backoff_delta_msec()
Message-ID: <20220702184147.57cvsbhhmufb6rpt@ldmartin-desk2>
References: <YsB80cliBmGcnPTD@bongo.bofh.it>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <YsB80cliBmGcnPTD@bongo.bofh.it>
X-ClientProxiedBy: MWHPR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:301:4c::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f599fdc-1a96-4565-bcc5-08da5c5a8646
X-MS-TrafficTypeDiagnostic: DM6PR11MB4425:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLzL+BJvMaZMBjBozwAvuYF+96zaN8tfyjdOKpiA5kCSHz64KMe00BigCUKemmudZTPOu7CeYwXSjmKGqTzWzD4iRtLanksiF7K1IDpshpXwPmgiPJ/AHnT4ZQUj53feJoUQ8Ui4MRnXCBryy1XfxORu0/d5AVMOPQAcZ0JWdX1UFzeTFvRv1yCaKn8ncpu5HeLQE4s9saxtLsTwj4QhBAe5pv9jRFniKdbmmSpg5N0m7ZWRk3Srdel+nVqBIKGJd/KORV4S3spkO9BBtTy4RJ3L6SO/ECURvhf0+rJtP7aaNuAiZVuiojgDJlFzJWxD1K7NApoQxVpup9daLgHVjl/63AOr0UNhDWSAIzzi0Tm8YHpmcJ0KgRv853kWE5l/ne6TheAT8HkKe6EM02m4G3Mqojj+ZMjZtN+TnaXsrfPVFAJGDPuQhVGwCaJKE8XwwPmXS3IPk6RBKqur/UebXB4QBlZVWOHHJacFlCNDWazsvsDUrdqbcLnAkk+7mkgTJUu+SdUsXeUzyDH3K8BIC6nFtjBZFYSIa1t77Ip1Rtuiaie9e/5JSp8fi3KoJIYor3T2Fg69LTf7EN+W6VqucuFAn00uxGk10XlkWtUGlE0wo2Fdk+l+m3+73LXR54cXHGm1zeKR+OulTlI7a6brFDtVWjn95HZCgMcxtMWExokhXR/n7B6rs5iqfLifdG7HQVPSZEmekFOdpUSZLMMyuOUm93ZiMC+daYh2dZpaSXIje2+8OVmF7qqMXWVe/cm9DLw6yun7wSJX9P/tRzMGoZ01me4kzZqTL+utPIQ6L0cVXFVsZHTJ859fBpudv1d27oiKCpY3mMvDzJuLMAaszw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(66946007)(66556008)(66476007)(6916009)(33716001)(5660300002)(8936002)(316002)(86362001)(38100700002)(82960400001)(8676002)(83380400001)(26005)(9686003)(6512007)(2906002)(6666004)(1076003)(186003)(6506007)(478600001)(6486002)(966005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUqkVEVvoxKYjEB//18/aoL7SVLFDQ3XR+4KyKhqMfy2Sj82mm5ta8lhRqs1?=
 =?us-ascii?Q?s4npDAbWm8qug4trYN56xZd3EWYaDkOYs5lOedy0R79F84mukavALdnMoXVL?=
 =?us-ascii?Q?rEycPtqq26lAuEgoFsfJ6bs/oOBX3PN6iKSeCXMdDnAcn+R3/kpBFurXl3TU?=
 =?us-ascii?Q?XMVEd6UWyrtYaCMHnH3a43onNhiHCLtHs8iTZStTX9cd94nYfvnv3FjTAqs3?=
 =?us-ascii?Q?BQn/juQibmkVKKZWIoYa+LIEazPEVl3lqlrVCxRqrAUaoXji6Kc+XcOH7Pnx?=
 =?us-ascii?Q?MpXuMpdVMCtQyE23yvtD5joElQmmprvHH1sdnXr1GEpMWA3vEFy0J434t13N?=
 =?us-ascii?Q?uqohJq/phy6MXw1HpY8B47CXv5cUF7sEBiFvMu800O5TSG60IX9h4NXHF5ui?=
 =?us-ascii?Q?c0re1Q5QbvhylKm7r8OipnvgIpDhDK4oNhnUsFaJFJjAk5Tu/CUEykjrPlv0?=
 =?us-ascii?Q?//XDuis/pv4G/tEhX7U3PMyQyXiT4uy9eFQG/67C0wf31yM8YwsKmym27lTb?=
 =?us-ascii?Q?FK5rSdppMclT+077H5QyGOMH7GAnmFa8ATmniSC93ctWrXkCQxqJaHahuVWN?=
 =?us-ascii?Q?yvd2BjYDUtHDgwK72UMbO0Ny3UoT8siH6ee7M/GcLH69solvFtuZai6EebeO?=
 =?us-ascii?Q?tgDg8DQ1LzO8ZDGHkyWa8HHSbtd8DD1Z8dxoprUbNczv39Q5KixTkG61s5Y0?=
 =?us-ascii?Q?2Eqrbghumup+x6TrrzpxhEemoWyiN5Jh80gJ1HvxJ3FKRzJsae4FLYnt5mSZ?=
 =?us-ascii?Q?8b2yEI9yj7uimugFj+xR6yAmWgEaA8BOkjq26C2SjBdCFxbtpT+WhQw1eea5?=
 =?us-ascii?Q?1Qij//BKHNlqyQgQvXHMLE+L1T0nlxCzC/hJRn5tS60D1rQUFsxpvNjqAevI?=
 =?us-ascii?Q?1HvZJbuZO+ICjuorsKwtSrO+rLQ9z8HjogTga0PTcCKHVsdJb0kT7/RbSQ6a?=
 =?us-ascii?Q?uWQMycKRpPQNujX/xWQq6WkaKnngOhcEIBKWf2O/NpbbAV/pzHbO6jy+WaWd?=
 =?us-ascii?Q?07J5SfQvHauPiY/37a1K7pFs7npvTF6Te3gW5hSVifa6ZzbiDk7+qd7GPdJw?=
 =?us-ascii?Q?ZoyZx8jai1xbGrD7XZQqKlnFviGuSfXpCa8/3F0j9PgcMeirVOzPHyFQW1cX?=
 =?us-ascii?Q?bqxHa6kQCwj/EX005+DTsLPMUCIewZyy5uYmB0TNPht8tFntKnRSfyG9cbHn?=
 =?us-ascii?Q?1ZiH0RPOcnazWoTqGI12O2BCO1NJE8QVTVr96WYOAyKQ0e21fEP39tC/gcAV?=
 =?us-ascii?Q?VZ2AkVA5/zNiUGpKXYmbfwMS7vLxo5TulxEohJEEa7JZI6xex45fefRVB3jJ?=
 =?us-ascii?Q?jB0C2V0gA6n5F0HJZDw7pEh+RO5gSgWQTJMoWPKRf11QBD5nZy0TwxS0/c39?=
 =?us-ascii?Q?KEEGpuIjS94Ev+wfx8MT0Z0+CkO9PhCMPSOa07wiZHz2doEMmBs2eUTk79Uw?=
 =?us-ascii?Q?w9KXpRNQ66InLKRV8BjdVXt242qz/fzPrYTMXSO1jxHssphT7GXYgnCq+jcT?=
 =?us-ascii?Q?Ieb9oBGaq6jiIdT0/zoAPS/N7KTX2goccFHPEiuOB/JMfk655vju641MK1vV?=
 =?us-ascii?Q?GkASdueZgfMZ+Z+MQbFqOxrvUVwFG+PLxqOgaVnyM3EJ+UbnFMl/kfBg9spb?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f599fdc-1a96-4565-bcc5-08da5c5a8646
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 18:41:51.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqNuGORvbXn2m5/6zwapmopYwpQxlPqg3K9En0uzyiQClXFzTpKDc5txepPlBBXZ+3hy/YP+YKH5a4F3CQAiTTCKTc3wC65BihVzhggTpgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4425
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Jul 02, 2022 at 07:13:53PM +0200, Marco d'Itri wrote:
>v30:
>
>$ ./test-util
>TESTSUITE: running test_backoff_time, in forked context
>TESTSUITE: ERR: Failed assertion: delta == 1 ../testsuite/test-util.c:238 test_backoff_time


https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=16c086f48c2270ad6412ad7226df53079f825270

thanks
Lucas De Marchi

>TESTSUITE: ERR: 'test_backoff_time' [3118348] exited with return code 1
>TESTSUITE: ERR: FAILED: test_backoff_time
>TESTSUITE: ------
>$
>
>
>write(1, "TESTSUITE: running test_backoff_time, in forked context\n", 56TESTSUITE: running test_backoff_time, in forked context
>) = 56
>clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 3118835 attached
>, child_tidptr=0x7fc93eb33a10) = 3118835
>[pid 3118834] close(4 <unfinished ...>
>[pid 3118835] prctl(PR_SET_PDEATHSIG, SIGTERM <unfinished ...>
>[pid 3118834] <... close resumed>)      = 0
>[pid 3118835] <... prctl resumed>)      = 0
>[pid 3118834] epoll_create1(EPOLL_CLOEXEC) = 4
>[pid 3118835] close(3)                  = 0
>[pid 3118834] epoll_ctl(4, EPOLL_CTL_ADD, 3, {EPOLLHUP, {u32=2034464432, u64=94873567065776}}) = 0
>[pid 3118835] write(1, "TESTSUITE: ERR: Failed assertion: delta == 1 ../testsuite/test-util.c:238 test_backoff_time\n", 92TESTSUITE: ERR: Failed assertion: delta == 1 ../testsuite/test-util.c:238 test_backoff_time
> <unfinished ...>
>[pid 3118834] epoll_wait(4,  <unfinished ...>
>[pid 3118835] <... write resumed>)      = 92
>[pid 3118835] exit_group(1)             = ?
>[pid 3118834] <... epoll_wait resumed>[{EPOLLHUP, {u32=2034464432, u64=94873567065776}}], 4, 2000) = 1
>[pid 3118835] +++ exited with 1 +++
>
>-- 
>ciao,
>Marco


