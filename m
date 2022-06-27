Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0BDCCA473
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jun 2022 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiF0QrE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiF0QrD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Jun 2022 12:47:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E6DFCD
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656348420; x=1687884420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m/UagNeaLwrZBA9ncY8BlKRELwgOOtpQ/tVSz+f55pQ=;
  b=X2MFn+K3QzPJMAtJ3yGIlsGMQIjeR8oPcPpQdthpq7mdN6DH9Pj3jwIz
   LELya8dq2FDsm3hYMS7lSwsf9bMtER/d7nYpwoyI5nql1Q7LpKEGTKwhz
   IbBweVo7WoCUCNBsQcaSoHkMfPRFMrmlg39LmkUR1mYef9SqG3dK559LG
   +w+JdbWlHEYrKS9nao7n/FMjZLNCaYSC1qZ4vpT3BtKhDwtzYYYETkxeK
   hAny3KFC5wCNG9e94Xnf9N+WUp/hHN/fhB47IjcUYR8k2GFts/b4+6R0n
   6/NlhADZ+k+QgFE6b+aJIYtTK72Exalw01PmEMqRMUNsJbenUjd9DAqmR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282588371"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282588371"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="732386153"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2022 09:46:59 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 09:46:59 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 09:46:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 09:46:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 09:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X12wWeSrwqPIxPVKfDji2eoWY2DbtKuW5asut8p20JeKz/2X+Izedw5WqdWeQAfpMvQ+5SGwiguaxki9DFlHMpLKsf82T5iSZztEvSsrdptDS++Xd9/cRmhStKbbHMKGalTynQSPRDDbmZ9P2LzMHGPdCjJnlCS+WJDvIRGfljjm61Gg8I4JoDn8TSQX5flSEXWXAMdi8jD/l4xppCytQhXOJrlZy7FViNSsWJt9aCnlg2p/ExLOtYFri1AezuV7iiCOIDv5U4RtQ7/CmGLwsuwS6x/VYWod17X600scF2d3jt6KNK6PJaDnbmbJRYLj0+KUuYaQ8ZA2Uo86L4fOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/UagNeaLwrZBA9ncY8BlKRELwgOOtpQ/tVSz+f55pQ=;
 b=I2B2xKyOgZ8ZbL8t4hdJGnd37tI8oJDVsz+k/Yfet4AfpLQjiJxDzxICoX/QU+VUfwLZ1mnMVStzFeFWATAQjmDaX8jE4lO1ABoxKwpA+cu3SBTvESUW1zX1LsmIVAL8kaOL4HJN3Li0R9CI7i4pkLbRn2/zZhF2la4GokRylIX2n5Xw/g3dPOaykXvLxa6mVqqzOSVprKDF5RO+Q9DrqPiPHIandK6b9/Jw9trPwnoVajKZQGUOQjScEtFBTYKuknZT8gWoY3ng49GbokDapdg/JVWm+RhCNvZzFPuqukx70rLWqt+mP080hzsqBHN7zK2pT92NYk62qsXPyWBWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SN6PR11MB3151.namprd11.prod.outlook.com (2603:10b6:805:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 16:46:56 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fc50:22fd:6bdb:5769]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fc50:22fd:6bdb:5769%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 16:46:56 +0000
Date:   Mon, 27 Jun 2022 09:46:54 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     <linux-modules@vger.kernel.org>, <mcgrof@kernel.org>
Subject: Re: [PATCH 0/8] Add --wait to modprobe -r
Message-ID: <20220627164654.zjidio2vowwhbeoz@ldmartin-desk2>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
 <20220615163129.sy23yezwsx7xyhyj@ldmartin-desk2>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220615163129.sy23yezwsx7xyhyj@ldmartin-desk2>
X-ClientProxiedBy: MWHPR14CA0058.namprd14.prod.outlook.com
 (2603:10b6:300:81::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df39c967-fe14-43cc-1725-08da585ca55e
X-MS-TrafficTypeDiagnostic: SN6PR11MB3151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3J7GTUArIjPBECxmapE5qeGtZwzvkxqnwiFhT7o3M8GDnNeDGLgHN8xkcLOohYNOVKCjC+utOsPvLSyL1PnRsutvtcN53s/jf4al8DCr2+PHXzgd4MhZntuskz4e8WjJngTgMQdvgq5u4jvSjjirJ70muGh+zy4kz43u2Bo/4LkOVWGqOzzc/qSXkO0BOLsQW6aaT0tNEXdFFVv7Y6unjDtPgkGLMPDTidw+jarkmQACUUBg2ixbC0Gxa4DPzeTvMCF66613UudpqwScFZC1+PFNMm1Ps60SVFLAse9QS7FVp+5IfxdLHMniUFOaKNu785HzLA73N1vZOnUoWrjPl1bBWPskciU1MiEB0nSicIc9EYm7HE6eHh+rZArG882m6ZFF+OpJIJwBP/DoswzIz7a1GwbuzRai2pB60HlH4DAnJllq6UyeOVRUatpaVJcnO3YFkqICBqpKzkPZAnoDJswH/ru95smf3YEEq2gjT/nrQm1DJLK56TP6baiEILKB1KnzTig1meFSWJsKRcTq3DI6xI7IDkhJdgz+6dTVKMDoHZUKxqrJD6ErhGarJHtQpE1TtR809MqUu+SQthtpiutFCYv92XHgMBEePe2mfNXHM4UGrH7yIVO8w6AWT+IK18tp8fa0dF6h7m4iCpk4hApVE2bN17ExaAaIBQ9dc3QMekohy6fqf2X9Ppzq3qmpJTlRJ68REEIzONb0jPUkOHGWE3pAlmr9pL28Wj5yZ9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(66946007)(66476007)(316002)(82960400001)(6506007)(4326008)(41300700001)(66556008)(2906002)(8676002)(8936002)(5660300002)(38100700002)(33716001)(478600001)(1076003)(6486002)(4744005)(26005)(9686003)(6916009)(6512007)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vdVLUS+HzhPzXARgw0Jjeccny2EM1aJBlFlc17jVhQ1PRv5kZdISvJTFZhrG?=
 =?us-ascii?Q?00p6Ymu1JCDcppHTVCvtEedYt3d00Do76tBgMo74eclJKhhO6qnSxfNF+yi5?=
 =?us-ascii?Q?mmjJrg74bJPqLjoAZ0fa48dX34AOXZ8pY84N4uqfE0Lzt8hMitmHd8IgbYGr?=
 =?us-ascii?Q?GGU/rejmRW78lCFSVqsY5Dm6zST/Ic3VtfblYsadfkpzP3xKwbXMqdWBGsaO?=
 =?us-ascii?Q?ZAQHZ1pnu5Bzj+ibEvCPEE2Cc3cek97HJUxl33A9LtNIDdgFqdg8tGjMdTeV?=
 =?us-ascii?Q?ZKMNjhSUiKM4TCPGO+RoQn3S6C23WbL7/WbgB5eCBZ2IWThvJfBSClLlOtkw?=
 =?us-ascii?Q?lwUR9gyNTgXspbhv8MCnreC1uNIo4k0hB9V/e9mFoZfjAJxKtzuc+0L/geJN?=
 =?us-ascii?Q?T9OKbU2IADlINUinQjEg5XTlKYJvGWj+kMsjtLu7uGKELSG2ElJQnwV3zAHC?=
 =?us-ascii?Q?+qbPJ3Xhpw4t/WDKPVwPfbk918X+kE0z/2WmLuAZ4YGJFzNRWuCYKy7dZFj1?=
 =?us-ascii?Q?hT6ngU59f/GcNIY0DxaJMXsJC6ghK+1vrShhWuTYSnVWhZ05+x8xbmS//u43?=
 =?us-ascii?Q?dqPedbHhzxMt2VXpI/j/Tzs0/veXlIPvHAmNuzJOw+3W60AMYTpMfupB17h1?=
 =?us-ascii?Q?HXL5oqLaKrb2xvhReG9t+p+V04qStSDfmOU3mVTrCodCLHnkNmdjMjxzxzt5?=
 =?us-ascii?Q?6CuOrYPdx4nImIOFtaay+ax73piU+NVgz6y1yq9l4MrMBHTKmHcylAIilUXH?=
 =?us-ascii?Q?4ZVTOuCWxAzkTIlrQkpy4uCisKXxDo1JuG3kJEjCVZS3oxQdYvYPxKmtoERQ?=
 =?us-ascii?Q?PwH1r5GRyy2zG5lIvMJJy3m/COwVV7Rmm0une8JCqAo8+07gdX+wpkYgYhA+?=
 =?us-ascii?Q?PjbLWPyVPyYi3I+mEOdSXZxtVbProgZ6DMC+M2ZdAwd75SUOAxJvnG6OtRgr?=
 =?us-ascii?Q?hkgTFdDHVhWsIZcdB4KcuyrtXhQ7ro3jJzVjU6+my3vCUQndoKkA0fUq9vO3?=
 =?us-ascii?Q?gj89ZwgVepXNTNqVhxAh1o08OUp2aRJ7XT5nBkRKzbr+/Dw/jJuCJ+v0AmGd?=
 =?us-ascii?Q?QeG+7bKZPypA3dyiV49C/uWg1xXAo/xm9fo3nZD1Lb+x8jUZZucF0O0dpZz4?=
 =?us-ascii?Q?MSdnK44a72panZ0A0YINPnukeqc6Ct58QI+1FaQj2Mfb5gyXF4LZyda84jYI?=
 =?us-ascii?Q?x+gakcYli3IpCE7IAHQJ8QzhvHfzHjAsqPyLeDMW5Vvwf4Eb8eXp9FFYT9B+?=
 =?us-ascii?Q?/jzoTpnGkj8876RPJ/TCedT1JpY++pL3OctK6yseDaAIaZIZ6c5Q8PrujhTY?=
 =?us-ascii?Q?cRZbM676W0m+Pf0gcMAez15zg7yubIuaWWvS5QIAn+svUi2/c53GKwvFiwMc?=
 =?us-ascii?Q?w8rILMOiy2XLN5wsTUYZViFTR/uInnvupLbkS503GasM+Q02LuJanEe8bLbs?=
 =?us-ascii?Q?CdmxecPtLzl+c7VeSLcM/kRPRwuWR5cCnsvtJuHGs9dZE03WOoG82Iadcjd6?=
 =?us-ascii?Q?/i1HA/F3cbHqdo8k0rPxZG1R8dwCJ/ZD10m0JsTVjlBGAbmuWV/vwkts2blb?=
 =?us-ascii?Q?E5vTxEMY6K44eL1MzQuUHWpbSsQ/qTGR3k2SX0oIQxhRoYlJaZc4ewhOYGtG?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df39c967-fe14-43cc-1725-08da585ca55e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 16:46:56.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQ4o9tsXVQoyA5pSErEsPG4GePOecvTFJY/ZGqh2njCK986FhDZiRiIa093fdjjG0vniMJld7zaz086LOLrwsLcFeUA5mTJplqbUvZ+8WQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3151
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 15, 2022 at 09:31:29AM -0700, Lucas De Marchi wrote:
>Luis, are you still interested in the --wait to modprobe? If so, could
>you take a look in this series?
>
>If there is still interest for the fs tests, I want to bring this in and
>then do release. Otherwise I may just leave it for the next release when
>I plan to move stuff from modprobe to the library, particularly related
>to the module removal.

I did some additional tests and pushed this as I plan to release a new
version of kmod this week. Next version we can improve and move things
to libkmod.

Lucas De Marchi
