Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4CC71153
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjH2QuC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjH2Qtc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 12:49:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B0CD6
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693327752; x=1724863752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HqsiCOy08l5gNOpy3IAe4/m5IerjeKUlRnxLNkb89yc=;
  b=DwWWWibStPGD4zV+bXtpXWU5b1gt5pc5X7y1kzEHhzcLg/lwbSK0gQf4
   sMS+zd0DC8MDgpM2hY02zf4WhMuDMfr26hhZLNBqD7GxhuBW4Xsc/R8Ch
   8noalvA7IVx9+sXpY1dRdcr9I3J3rIkQViXmlkya4GmkzdLTb1kswXasC
   yicnN1OViTReQUlBJoZe6lzG0detRffHnA1hQzYwlG4lGImvipoDyxbWE
   Qpbj+dcF+cuS2Ele2RH7xitJcSf3LCtsYTFx1CFLAJwceQQ7Ppa606hyt
   iry+RK5BUN5dYzSnscA8/kGdZqrVmFsy3K1On9L3gzGNcvrlyzCvwbALi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441785983"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="441785983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688574410"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="688574410"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2023 09:49:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 09:49:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 09:49:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 09:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9YcaSfktQjBJaFS9ZTk4Q7QAwNFA0AFsq6xdg0fhUrh2/lU+ZU8CnuoWVXJBDWCrwcWv+ndye7rj+L75EcbP8tq/3d89IOZD5iM6jRflv7Tpl6DUPk136XH1ra6A5MbSQY7r2C7SctvAwxTA/lPakKQTUEvicTv8L4c3rrgG754ul5d9RTNn+cneXLnBUZihgC+pNV90lG25CE9ge8iXHaoICM7mkXNfoBEk6+WS24cn71m0edfcq4qBXb1SD1wJfwvlQrH3kQBErNPeI2HJoVmzru+l1fwBU4+IhDrDAEoY0umFAu6qVNUU3yaQIKiIBwQf/lsRj5bNnScF3yS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNDUI7TXgr9x6DpkLmlsbKFx0S2u2FKw+7WajKCJTt8=;
 b=GUIX57J3Dzd4iBco/N4T1uzd9v9ws9qpvjD6uE5U5Nw/DaAMgl5Kyyqgen+I2WU7Zyx+u5x9+OWzIdlPmHv+nYVSMaH8Lj6dBN2Ls4NPdXt+SnQxjN+3j9AibwXQ+r3xFhx5lN+MxmWghfIHME3krdbQG/1iz/YmR59QE5xumpXG/0pWrlZYNjP1p3cChOpy4z/qc0fnv6tvoPznxv5aCIVgp/AnoJCPgiMJs66droaTT9YhRv8ZWi+gjK8e+RhUGaXpJyIwXOTaT0YbmCG5k2H97y5Q21AeIbRWL9nMoIMQaGMzsDtP/aFmnN5+1RQpuIulPvRjoyROEmmJJzIsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:49:08 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:49:08 +0000
Date:   Tue, 29 Aug 2023 09:49:05 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod: allow to fallback to user-space decompression
Message-ID: <swwc4oahvjlpwnsv4qq4jgdkjrxghtjd5ooozh56yx5yuz6s3l@ci7royty354n>
X-Patchwork-Hint: comment
References: <20230829123808.325202-1-andrea.righi@canonical.com>
 <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
 <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c051d01-7be8-48da-9fb9-08dba8afdcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4z5ezWUNFFMKEskoUlYzUjF20JPpmsitosvXi4wlxUtrhUHUpxc2Hyzodef5szR8gsBEN550bsu27WAFqgbCevks23gDZ9DPZB7CA2/q9cXHZeIy0P/6YdKHxNf6lPoaTRxXDYFxtImYsgiu+w5PIli/GQVhe7dLviRnyeNORyTQtzCTpsuF+80A0Nsq9keFuIiq61p8yHffxIbz9FYLFuCehq7kY9S9cuu/ZSzKP4Nto2pn1iceDeC4J1Y4saLSqdgL5AOLb4diMGhCRyM53VH/uBTeeUVfGllc5iRDYyxBYf6JfvdpSsh2Ym4FhWGvy34PnBVoQuTBGiktQ38Ttwp+RFIaANc16Q+2y5uF+pIqjimYDAACeDjRn7Uts3GSk9foLq52ElkJ1UEfEDInRTa0d0eNiz3QJ6N3AejzslwVthRGzNa7ILMA3uNfzl/WonaIyP8XbBGqSSZvDCmbpG5u5zIo+Yvn8qbN9Xp7HgtyR6+sDmZoEtYVDK//EzPFBvghIyXY/BG03d6mVn7Lz+02d6S1kCIIjs+8dsCJyyQfh6UCwAIXgmkaiGQKq6IvFITuAmGzcLOi1vUsAW+1hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(6512007)(6666004)(9686003)(6506007)(6486002)(86362001)(82960400001)(38100700002)(83380400001)(26005)(2906002)(478600001)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(41300700001)(5660300002)(33716001)(6916009)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Id4WANHa8MjiLd/nD7uL+uO804moGCBGuaY6Ey0CR2GpVs6WGZqdX+1eDaYe?=
 =?us-ascii?Q?IeJn6OYeQp2K4mcvC+9J1wqqVsszoCiq/c1fVhavJjFf0A+hxfncTDpsVlFG?=
 =?us-ascii?Q?/IZjIio0iCLZOoql9qu8alyrowUxiCymoJEthQrbSuzoR3nnVqosG23+Pzg9?=
 =?us-ascii?Q?03RWZ25gbQjy6OAdHn3N7yC4vj3x4ngHesYrV55vvuvtibMJDNQMMfOhYW1a?=
 =?us-ascii?Q?8lr8qrZ4QRmjALqxus/1Fs46uS01+n2xRh1gDyRe6jf2aS/86J2yf1vhoNr1?=
 =?us-ascii?Q?fAs2d9wa7aunfCP/22thUsSvd1Zzbs1O+BGoDJsJ/jRanNqv4cHB7LXYBXSu?=
 =?us-ascii?Q?XMZWTAzRT50wevD4wPDfk9qreFc2k0y/fRddOKF+KwjYVziD0WGyvTYRr+wu?=
 =?us-ascii?Q?NrZy4zvK5ACewGPPNylY+T+Sy4Vw2AzTciNY74v1BAPyuaia+Nwy80TVh26y?=
 =?us-ascii?Q?PR7hNg8XqynKaJQpz35OqW0b+vKmfxdefoMwTI0eswrqO0Yuu3CH4QxZkIYw?=
 =?us-ascii?Q?yGNNDJk3T73/rS4Re9yXZmftEfvu66j1j9XVzUE3uVGKkc+ajOXqtzdMHT5K?=
 =?us-ascii?Q?MAIkMMZSw6v4Hogyx87GhwszjjnwlRkHbGXrvK5tV6eu6OwQks+S//eOpVrQ?=
 =?us-ascii?Q?M2yI+TMsVBJmG6kDzy99EIpOEQf99nl7Wh51HjqF6YEMy8VCl3xTozxIyl2D?=
 =?us-ascii?Q?t0jHhvJz+lGFIMYqnSnFolXgQBlYb/yKIyhimK6qGdH0vlRehk+qUjSd69cQ?=
 =?us-ascii?Q?VIFZO0ynsDdRBpRd4GWi0sbSvbAQ/PgenGC6HSRVqsw5FjIVvfY7V1MNE1a+?=
 =?us-ascii?Q?4GyDQlbP/szLPLhNeJf+MHkYdqf2AKVCe7N+y1hM4cgb53xIqThfmQD3YCJg?=
 =?us-ascii?Q?zHInCB0z3TaYYhqKsOyKlMJCY8iiLW18GgBv9gpzBZVkcsDpZqgPH/kTQvvS?=
 =?us-ascii?Q?TjjHXO+aFK9cnA3zWAu486hrTxNrgGXqsjSj7rirb+bL/2eGh0DNIN6L7DXD?=
 =?us-ascii?Q?37deYO8xj+Qzd3OAosZ1WJszqMYA8t6zQdOCngt5uNsZCGHz+x5l/lx+6Rt6?=
 =?us-ascii?Q?qmS2N3uFl5u9mOjU0M/yM5EiFWX0rz6NLE4GEK2s7liNDZ182HM/7hNWbRP1?=
 =?us-ascii?Q?MOnK+zd4dHqwdNPqDQSP/pB7u8P9Doi2ZWSgQCWIHn2JvP99VJOrT9UpnHwP?=
 =?us-ascii?Q?pMNn4WaikZM8cQI2cSW1FNBAboxzT3P0UCZylV7SF6vbJaWYXyVe7mHfTCYB?=
 =?us-ascii?Q?FtNktkEDQSvsWSl+NxMuMXf6pY7n0Czo4hkT729oxge6a0SOeeCM7gzNOT9n?=
 =?us-ascii?Q?KKPQQSBbF4cVSO+hchL/dt0upZpZsk2GUA32jsepydKXa9FglodNOFqAysVP?=
 =?us-ascii?Q?E2hs5391mb2r3Pn7wyJcx10et32bgiOaefS0SchiNdGICPBtsvSoXAxl1lhH?=
 =?us-ascii?Q?r5d1c2M6D+SPulIzpkGBHzPKEARL5PERWwJZ6MlXHEE3ocF/KPvkFG6CayUw?=
 =?us-ascii?Q?c+Pn32ayrabwwFf7JuT7AJpA9lp5uzHONSP/M1wDCc2OIXI6UZsW8VXpDRcI?=
 =?us-ascii?Q?lSthTT2zwTRRejxHctMzYv4XKMo7VRI8SzX078cF0QljIMyKNtJGgIGIIgyF?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c051d01-7be8-48da-9fb9-08dba8afdcb5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:49:08.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38tZ1irTixp7u5ornfMgke+ZBbpnIR8seOkgnTbaYKcBU4hVWamVwEZSyGs8aaPsLihDRTwdZuXezl1IWU/+pU9xl5WF5kkAqr7G6t3uHU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 29, 2023 at 05:23:25PM +0200, Andrea Righi wrote:
>On Tue, Aug 29, 2023 at 07:47:05AM -0700, Lucas De Marchi wrote:
>> On Tue, Aug 29, 2023 at 02:38:08PM +0200, Andrea Righi wrote:
>> > Fallback to user-space decompression when the kernel cannot allocate
>> > enough memory to perform the decompression.
>> >
>> > This can happen with large modules, such as xfs on linux 6.5 for
>> > example, an ENOMEM would be returned and the module fails to load.
>> >
>> > It seems more reliable to try again with user-space decompression
>> > rather than reporting an error and failing to load the module.
>> >
>> > Fixes: 09c9f8c ("libkmod: Use kernel decompression when available")
>> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
>> > ---
>> > libkmod/libkmod-module.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> > index 585da41..d2d4815 100644
>> > --- a/libkmod/libkmod-module.c
>> > +++ b/libkmod/libkmod-module.c
>> > @@ -978,7 +978,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
>> > 	}
>> >
>> > 	err = do_finit_module(mod, flags, args);
>> > -	if (err == -ENOSYS)
>> > +	if (err == -ENOSYS || err == -ENOMEM)
>>
>> oh... ENOMEM can be returned in several places. I don't think it's a great
>> interface to just retry in userspace.
>>
>> Luis, can we do better on the kernel side?
>>
>> Andrea, did you track the exact location triggering the ENOMEM? Is it
>> the return of kvmalloc_array() or alloc_page() from
>> module_get_next_page()?  Or one of the previous kmalloc we use for the
>> different deflate methods?
>
>It was this kmalloc() right here:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/module/decompress.c?h=v6.5#n244
>
>For the records, I've also sent this patch to address the issue from a
>kernel perspective:
>https://lore.kernel.org/lkml/20230829120508.317611-1-andrea.righi@canonical.com/T/#u

That patch seems better. We will probably have to move other decompress
algorithms to vmalloc too.

thanks
Lucas De Marchi

>
>That seems to solve the issue in my particular case, but I'm not sure if
>that's a valid solution across all architectures.
>
>Thanks,
>-Andrea
