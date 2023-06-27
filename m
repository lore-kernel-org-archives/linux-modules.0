Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAA8EB64D9
	for <linux-modules@archiver.kernel.org>; Tue, 27 Jun 2023 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF0OGg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0OGf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 27 Jun 2023 10:06:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC6296A
        for <linux-modules@vger.kernel.org>; Tue, 27 Jun 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687874794; x=1719410794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AKPXJvWG5m9HID2UIDWlznHAaYds797CyPdXd8f3kOY=;
  b=KjxabNvKa3FT7JzP3aLDgBFrA06wGgriFKOQkZkjMJesG2xPymavDn42
   52cIoHuxN3ufR0QGXDpOkookgKA+bU2Scq+N9Y8W6ajoKfYYmJ5U6ws7y
   i5RdduxuxQG2bcpKWnsuwkYa4u0t3LJIcm631D9X1RhgGTgzxMNw3iycR
   3+gjZ3bFQtN6oaKLUvoOVkhapazDrne0gnJN23+CbaoqCHM53dk5yPhKF
   mIv0x9Lzniw9lDbTrATSCpzX0TcEjmJX0vpq1QR6k9VruLzkFC0HxwVha
   dvv8xnI3nFEsRQ349MhuVICpiqc5Ir+kGmXRNevL9lq3TX97KIM08Tul7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425249286"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="425249286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 07:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="693877381"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="693877381"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 07:05:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 07:05:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 07:05:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 07:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chGGtQoyMIprRfLA98VoX6W7UHkV3qTcGoVyauXT+gO7je8CNUF/8j+RevOYngRnLnPOgr+IneNC9380B4weuv8SNkqF5Xp9O3CAs2hnPjI2cH6EcutwFVcFknyESRibPQL3FCHHKJa2yOh6Z3XhLade60+U91KIeWXER2LcbGDWUFnI5YiHczQVTc+HcDT8QdSHOsIn03g+Ct3nfxU03g/pQlNCcaINQ2LPraaUEhqg2HOjP4YyVh6nqb60LVAu4jd6oZ0hP680A37A7Mr932eW1dscXnjmZxl8xdbjJ0A6eatr6wiEzk4bfrP3tCOsaIIhudd0teiNYb0/97p0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um/IIMKDE7OzqayyLS5ZMs9+cPRqjP4h/G5pSAO9sqc=;
 b=OgVN7ywb0khdVF/1igkGwBibNRKgUsBR0J9YoNVcFed/ADEU4krWJWQEUbkjDgo3V4lo75vggSL7TDCWUJ0EZaKxLiHQewvUqGPzGn3K4drkmBO6peDSvioX4TaQ1clyEUV2VTOnp7fJf5IQODko+wF4w4bjt+jm9PuroCzZRiyoz3nUEvXAxRUEliueCYkat0pXlb4ST19GzvhWJS9hruwNyT9ixHbol/4ID5vxBnqpUk0spX2TgiNi70b4CfnMo9DnfMahTTsz7XZ3N2/ADj29Ip1OGZo/JXPp4BLwbaccomOJTtHcZKcMZA2MT0tP6yLO2DtzcphuqgNo38OGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 14:05:49 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%7]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 14:05:48 +0000
Date:   Tue, 27 Jun 2023 11:05:43 -0300
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
Message-ID: <izhskgxptbfjsjcqb3pfi5qlsqt3moczfgljycrbzey2oavnuw@mfsybe3h36es>
References: <CACvgo53yHOd964PoQkM_oX3LGcr+qCagz64T+sxcP-eAveS85g@mail.gmail.com>
 <CACvgo51chK2SU0an2dD5uYaUdm8sQd6DmRWdUf5bY=2sZnBoNQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo51chK2SU0an2dD5uYaUdm8sQd6DmRWdUf5bY=2sZnBoNQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f9e8f3-3136-4459-0cda-08db77179b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUz/B+AZ129Bku/TPnzRst9L0t6XO+IzpvSJv2dnqqxGTW9XADk6A9Vaexe4uQncwR5iWZqAi6l1x3nAdLkbiwG6lTEy2vTdpjdVcgRp41x7Es0OWCdgu/9an0J2YsZlKCa/Iuz2Rl/jC4+ai+V266njrNcBRZGOsx1fW9skGTIiadfRBiA5AG/Ve9a9Po8h4YBjf86vPXlks+EcMWZhSnInkASXZShIwMBvJuucTBrXyw6bV74EMLG1lS6g0yYw9sWdumBuMndWedWOdcQdUsgeMonYFWsacjTqxVz4ZRp9Y+BOTkERXUqern47Axy5Huqq15wmc9SXqIl18sQjZvZeg9PziL9ynissHbMjL8JWtmWSeH7HfXc8d85rmBODmwaPw8uImXpTwYUhIa4a6wHSyiTFlA1+cf8ToRwh7Z5djUMCFETX2awIMWNRmuaK+S4p7emPx98tRv9EWoVLV/Qlw/e7EvpLKYVfBWRVRKHNCEyTYQDBZyvhqSdNhCZgTVkzDXfFA1QXs6tZ8ReHHm889MrEtNkYovik1m3oQNGJKr6YH/jJlPDPY/ENt26d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(6916009)(316002)(41300700001)(6512007)(6506007)(186003)(9686003)(478600001)(54906003)(6666004)(6486002)(33716001)(5660300002)(2906002)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvU1sUcws+TH1mcdVMXxzs60c+1IjUGuiGDSyhojjO+beuXQmI6AedEttl8p?=
 =?us-ascii?Q?M5KmqT8/kUv4KLS+ekkDF7YqkXZ02LGXQzTP+xlkBIchacCoJ18zirAD2Uoe?=
 =?us-ascii?Q?iBJlAChD6QYi99Xgx2EmVEfxHsJrQqKr6/00MZbdtb5ANuISWF1lRro8L/UD?=
 =?us-ascii?Q?OzMmwHn1i2q0+0Im0dq5Bwv+v0TdOUhVrMdZ+upPjlpiFrnPqpBq6cyTJyia?=
 =?us-ascii?Q?s9xGCcsPhevcBMdNMpi9R55/YkmEBTgfJ+nd+kjHPyGUyCE+aOzNGy5ooH+z?=
 =?us-ascii?Q?gaVHqRrGpNjbaEFZcNxHsBMdBPWK7kMLYsFoLg+7QLY8/Hu4VkyH+fBUObJ7?=
 =?us-ascii?Q?qC5eY7LmlWjPROSQJBCkJYDVZq31eX0rVFFx0PBIyP5IoYbau5P8WRqsUbdP?=
 =?us-ascii?Q?ZaFiOMqOKiqoJiAPHv0ncgjL0DpTr10BE+sFXoyeY0JvF+1nq22SdDfcF7ub?=
 =?us-ascii?Q?6fgtDvcwdBJIgE0RbN1Op6SxfCcpX+77bqxLCKolZ37Yq0dbI4HGtKWkH/iD?=
 =?us-ascii?Q?KmX02tbuDO6RSDEYhvjV/Tyf2pQ+1ViQCFJwjmV7jx/wxBMfTsQIh1fvnss8?=
 =?us-ascii?Q?mKu+yQkBPe/1+oEVO48QsNVpoOQiH56td5NtDptvUHPKr+r3xSBbPQFYha9f?=
 =?us-ascii?Q?2ClSj4KrTDyIr+9JS62wtwvTgzMiQd+khzL1qwEYh1F/dAqBvP/+PtluLRTt?=
 =?us-ascii?Q?5h+B7pe0m7yfKoQIDeIti9Zx8qqd3XOa65w3+r0lb5u42oWh/HIJ883GszsZ?=
 =?us-ascii?Q?pT8U1anwf+MT7SmG5R2wYMbM/bOC8CYOUO1GaYNpmPKWGKk6XiMVqOx1eU/d?=
 =?us-ascii?Q?gzU2VCBIP7ldlqZ9zNmWQ5xYRwMmf746TNhioQikMLcKpTfqiU+rqGxL1k8+?=
 =?us-ascii?Q?tAP71FEDv8VCFQ4rBvarIPM8ShIx1WHiosRsNuvITc5c08R2PAN4J2TfxjNM?=
 =?us-ascii?Q?sCCSvArIYRlgLjjzhC6bkMhFhV3uNKPeBbBoHHOQBl1spj5ZdUdrWx9xjQFQ?=
 =?us-ascii?Q?jVsIRd6cwtdQClQuOEyXL7ufw623AbAb/yIDdc6zvVM8go/nAtmF34UUCjXM?=
 =?us-ascii?Q?K6Z4O74btVW+08UeenHPcEFp1xlsxIwCiaueMPnEMe/qQP2VmOyzfDZR7gGS?=
 =?us-ascii?Q?5GgFCGsIzaq7oBocMXWK9hFh4ZXghyBkNF/Zlc2FwMcOYWFL6CfOrHyyPvbu?=
 =?us-ascii?Q?eL+27FbW1LMu8wU9QvDP2hUsggv4rXKVRtej6RXPOAQEu3KKvei0MHWeWQAB?=
 =?us-ascii?Q?SJhJHn+5G6cFlAMfnv3R7n3h/BHuuclztuDgk+fJ8zSEufNBMbq+UPXaLcN0?=
 =?us-ascii?Q?UsYc1VbCgpkJQZa399B6vJKDxp1+H2pJHWoBK4uDm3Xhm6liyl5CkRUPN/kb?=
 =?us-ascii?Q?TKruzfz9cZO7tZuiLArdyJrimqUxbs1vCbO8uEtE0jG3LjxpfjYdfcYCL+jh?=
 =?us-ascii?Q?IwYD6hn7EPsrnYsWE4yGzGxxaNhojuE3wQ17hg7o3EOO76FzFQmsymoUVA/y?=
 =?us-ascii?Q?N6uZ9TcEUjOccxul5GuHt9kBRyvm8DkLQ7BtD2/f0ZrW6oUdAgCkzQmcaRMi?=
 =?us-ascii?Q?lpJ352G0xPwyLEypFyVBAvwZsdk6fDdfA2zTgYJbNJaTaDt3bEHC6zDJIIL9?=
 =?us-ascii?Q?SaHo7Vyi0I4WB2T4VJ2p38nzf7fwPL9jXKao9eDb4puXuDlJdaKmgPSGHAKA?=
 =?us-ascii?Q?/Zy4OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f9e8f3-3136-4459-0cda-08db77179b83
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:05:48.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2gt/Q0GEnpYGIcj+8ByvHXXfZbkNeQ9QOHYt8L6rCNoWgIx31xhzBaslki2vFLR3t626a9HVxIMrnguyCE5sRjw2Q30IMSKsNbJzLxzNHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 15, 2023 at 11:09:59AM +0100, Emil Velikov wrote:
>On Thu, 15 Jun 2023 at 10:36, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>>
>> Greetings Lucas, list,
>>
>> I've pulled the email off lore.kernel.org manually (haven't played
>> with lei yet), so chances are the following will be "slightly"
>> malformed.
>>
>> Above all - hell yeah, thank you for wiring this neat functionality.
>>
>> Out of curiosity: have you done any measurements - CPU cycles, memory
>> or other - how well the kernel decompression performs vs the userspace
>> one?
>>
>> That said, I may have spotted a small bug, namely:
>>
>> > --- a/libkmod/libkmod-module.c
>> > +++ b/libkmod/libkmod-module.c
>> > @@ -864,15 +864,24 @@ extern long init_module(const void *mem, unsigned long len, const char *args);
>> >  static int do_finit_module(struct kmod_module *mod, unsigned int flags,
>> >     const char *args)
>> >  {
>> > + enum kmod_file_compression_type compression, kernel_compression;
>> >  unsigned int kernel_flags = 0;
>> >  int err;
>> >
>> >  /*
>> > - * Re-use ENOSYS, returned when there is no such syscall, so the
>> > - * fallback to init_module applies
>> > + * When module is not compressed or its compression type matches the
>> > + * one in use by the kernel, there is no need to read the file
>> > + * in userspace. Otherwise, re-use ENOSYS to trigger the same fallback
>> > + * as when finit_module() is not supported.
>> >  */
>> > - if (!kmod_file_get_direct(mod->file))
>> > - return -ENOSYS;
>> > + compression = kmod_file_get_compression(mod->file);
>> > + kernel_compression = kmod_get_kernel_compression(mod->ctx);
>> > + if (!(compression == KMOD_FILE_COMPRESSION_NONE ||
>> > +       compression == kernel_compression))
>> > + return ENOSYS;
>> > +
>>
>> Old code returns negative -ENOSYS (negative), the new one a positive
>> ENOSYS. Where the fallback, mentioned in the comment just above,
>> triggers on the former negative ENOSYS.
>>
>> Mind you I'm still sipping coffee, so chances are I'm missing something here.
>>
>> Thanks again and HTH o/
>> Emil
>
>Somewhat related:
>
>Would it make sense to read /sys/module/compression if it contained
>multiple lines - one for each supported compression. This way, kmod
>will just work when the kernel is updated to advertise them all.

I think it makes sense to report all the decompressions supported by the
kernel. Looking to the commit messages where this was added, it seems
it was decided to add just 1 for simplicity.

>
>There is about 0.000001% chance that changing the format of the sysfs
>file might cause regression, which can be looked into if an issue.
>After all the sysfs entry is just 1 year old and is undocumented
>(cough) so nobody should be using it, right :-P

However I don't think userspace should go ahead and assume the kernel
interface will be updated in a certain way. Particularly because if the
kernel decides it'd be better to do it in different way and is not
compatible with what userspace assumed, then there would be a
regression.  +Luis on if there is intention to update the decompression
list.

>
>I'm really tempted to send a patch tweaking the sysfs file and adding
>documentation. Please let me know if you think that's a bad idea, or
>you have one already queued.

at least the documentation, yes... would be good to have it.

Lucas De Marchi

>
>Thanks
>Emil
