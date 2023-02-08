Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D466C05027
	for <linux-modules@archiver.kernel.org>; Wed,  8 Feb 2023 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjBHWMB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjBHWL7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Feb 2023 17:11:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2893A12874
        for <linux-modules@vger.kernel.org>; Wed,  8 Feb 2023 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675894316; x=1707430316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CqrbrFZSBcqoKuF68YIh9zT0F/Fyy8yEe14keSgS0JI=;
  b=mCjcJIN5VKT/8jVSivELk7HZ27lr4Kp9bMNnCIkKwR/b5CoZnWuyIR2H
   BDsVMbr7j5bsThWDGQ274pKOFNLsiQt3faRZkWUmdDSFfWYhGumSkldxe
   UmH7MsL9qlmI1s7dec0A35TIJa68KEiflkII1GdrMyEkaLEoPeliBtqWC
   BZ0LybBivvUqT/t9ysZ8Vc8wEX393gPj5Qyy2k/FbNn0NvrMylw6DuOqz
   5U+WDarnoIIMcT7PdBOrQbhtNCfRQogrRxNEz3fpk6wMUmSofYTDkjlOx
   xS1ZbSllFfWhxL/OrgnNfN9kOz/hhjkTAJb10lPffjtzicXxqBQcWNUp+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394532770"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394532770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841344651"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="841344651"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 14:11:55 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 14:11:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 14:11:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 14:11:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3RSv9ls8RkTgQC/E2t7NwNQH1GiILmJR64qpz9HY/Z0FQwhAEguAFlzzqzBcW3NNh9u+Y2Gy58+O0m4WCCGzmMa0fnbsvbyIQo7OKFz3BR6EZa8FrnPaPykE/wxNsAsfZ2RaG5n7CugplRvl3svX0qWVyhtgm0dkgXijs22n5uTp9UQrcvVCX2HA63ALYDgckdLc7FShHzRIHFOZSABrY8t+bh5ALMlb6JEhV12LRai2azX7twrr1TnyK1CxZkGC632k+liwyDE0YYL5KHS9gLbfck0HTBYQuovjHxvHcka4aSvJWPJd66HIfyvDuml32+gSnusDhlLoLYqfgw4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzAOakzqQ/sQoYYd1rcOxG6bNn2ZgpN/srCSlMOTe9Q=;
 b=NJum+Q7TKi7ddCG98RQpJ7ddb+D5rgRbKfFKuSTorSJpvvZrF19bBgK7hlh4Zh4B5tZcTH0GJxROWrQDkBUmtxYwr2/hLX6rEETXjbw+ojlQD0g+vtjG6weqBKqlWRv9aWjtJ+tVHudrQLdWgGpfGLgESHANmncfqJMdErvW3k/FCJxVr9VPZXsbJAY76i2ujhEmyK9zDx94AhqsYBpFiVeDatGPm+etiBfJeklK3Z68TxfNtHqPMKkq/3h94GAUzQULwRfDzMKje3p96RDuWtMpJEUNM9+gbnjNpJhwMGVZWxk+A9CwXbSHNzthEACB5nY3Lvu0CoYUqhC7eHHztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 22:11:53 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 22:11:53 +0000
Date:   Wed, 8 Feb 2023 14:11:50 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 2/4] testsuite: add function declarations for __xstat
 family
Message-ID: <20230208221150.wr4755cgen2ol4we@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
 <20230206140449.574631-3-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230206140449.574631-3-emil.l.velikov@gmail.com>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: b27e409e-d831-4260-973c-08db0a217bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUaoNh08RjmYw26dPpz9IRjIcomPpvDwKx4Jss5Q9bAOt3m+R48WbQ2MwAsxQX+8BR+Nb+sLySU57CWHNppaTC0NViB7g1Mzed5xw61jGsmGP3Xufz7fKfkmigcuYVYaJvTwErdEoa6SRw8alR9ONgwX0I0kFER/wngKflOtA3ijOVh+tTB1KP5kIcF2o4msL5XKSQcIfYmXanee74wxhNEp1xgF2EEB/+Ol30IWtfJCufbhXz4QIQr5jPZCjyYju1I//oBg6XoM1hlCaJnPuIGdzzOnHvaDQpwz6mWQPtdoFI89j2DKRPd35xEIuP7zpkIYu2wvPkJKX3cTTppNsh4boOGby9UOylaNZYH3xnwGVSmswN7M34IxpHDRVg77nHL5fSDjfU6lFuxCasCS/Tg0QPf7aGvI94Uu7sezGU0S0lJ+FZ8H0EkEMw6awxVbQwH4C8Llc+jXLn7eS3RF7HY/jdf/OPYQu9nFY4Q0Zvh6LQ3kddzagTTCnkuQ+j7wh+w+l9lDOFAJeSabFATAiQOIgZPTA0/kRjerx3itPgGCy04CgNJhgMjX9qQhoVltDuC1ZbPrs0synTE6mlvwLkkewbBySETVtEFUBHAMVuQFUXRmOcOFSK2TKHa8/syNWy2fk1ijp5TJ3G4Vgm25eo7DOjGd/vN2HnAeJZrCkHPT1vUX4bn7fNBSYeCdkB4VHPtRnO8vTbPcypVjeVBgWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199018)(6486002)(8936002)(966005)(9686003)(6512007)(186003)(5660300002)(26005)(66946007)(66556008)(6916009)(8676002)(4326008)(316002)(41300700001)(6506007)(2906002)(1076003)(83380400001)(86362001)(478600001)(66476007)(36756003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbiEdn6jBqVaZG6+gTZH09IlftuEXQaBajMEkP1rQlwJXKxTxBU7+Jf6lI9w?=
 =?us-ascii?Q?d6sc2IXKU+e65ntXSgOoJSia8qA4JzLWW5f8E9VV2R5ISXIYNofbCj1QC4RW?=
 =?us-ascii?Q?cXfUY2UJre33XKb7yJE7ohizB9YwRCzYeVboF9G6P/WxcTE/PaC0F/WbdKW0?=
 =?us-ascii?Q?tMIQ/RQ7MZiJLiIvuStEm6qi4+XKnfyZLqEqUfC1t4sG0rr2spya4Fea6KYU?=
 =?us-ascii?Q?NzcDucJGOaoo5JkI10lKeCxnz9yClVI8dfbmCKxlsC7GhuLD8SslTvq9kDMI?=
 =?us-ascii?Q?Sl8vLd975KeldwK/K6Mnhn3oUUfME/YMxWf8IF6Cl/K32SL9QtPs04tY6G5l?=
 =?us-ascii?Q?5wzvojJZ3MvN5TaTOIeCjQnjaImnyxzl+B6sq6xb1HcsCFUmq55j/syLU5tg?=
 =?us-ascii?Q?BOREmj9YhY0bESgxbt+JdgfJENPAQhK46SZT+skfeEpG+uSy6cZCPldK6JhH?=
 =?us-ascii?Q?4vcUQMVEFURxXOwOfP8kSAsDFqZZIWXIVdJCLYTyDnJszcw7Weu+ej1ddWIU?=
 =?us-ascii?Q?8Yqt8CGotKi7b9f92N5aFLykaxvIINW6WXjbio1FDCExmGS3+cZdU7k3QQeo?=
 =?us-ascii?Q?sbWwijl4dvAFlliquU0dmZhRk8fxEqt0h+DrGG+O9AlKDiyZxzD6WA+xwFr+?=
 =?us-ascii?Q?b00cPLJpwUUjpwo95Yvntj6TuUMez8lSUQqsmDnyQzJtgYJ7PdxB+T3n1LOM?=
 =?us-ascii?Q?WYCPaGodn2qdMIO9lPaRQwYJNy28uqfKa73TRGx9/HOwa55uWElwQlJHfSaK?=
 =?us-ascii?Q?raSyqgpbScWAXR7ftzUBJLeUZCbvL1uyB6qX/MK+fnP+VG048h3AYe5zf2ii?=
 =?us-ascii?Q?rp+KjX8i0+lvuIGhG1hq/WngkGLjtgRx04qX8aohQvrIG7R5Bye2eeHMCMZK?=
 =?us-ascii?Q?KVDNkzfGe7cv+VU5gIN1MG3/u/edhC5ptIRmfrJzm1npftOiclmg91C327yW?=
 =?us-ascii?Q?7yjaubIBSzEanPAidspQqqkuMS644YpfPNHDXaKdSsDONrXPwexlV8rw220f?=
 =?us-ascii?Q?k5D7UopBek8dh8dBJc4OrL4Q2T3pdwfq01zZnnA22YjkxRemz17Tia2VQHI6?=
 =?us-ascii?Q?ULxD/DL/Vw08mGw/UGlzzjSLPBtztMu6QL/0j3tYDDx6zEHcQ1DInOm/fOxj?=
 =?us-ascii?Q?52cYzNzvQ5Zq6v0JGu8Zis2EME9Z+BV2mENmhICD5jVOR3dupoDWx+LGTVXn?=
 =?us-ascii?Q?t8gANysIHx4zKhXDm1JteTfF1eKWsPeD2erS5/p92owQiZjrYSOVYHMekgiM?=
 =?us-ascii?Q?I06uPGILtHL5fX07NmWdwYryPHCE0uckwqc3fS/tF+Q+igW7CEdOz3p3PAzn?=
 =?us-ascii?Q?hT7TXgjt+/QW8ziXSpkRiTaXbp/RVqg1zpAX9PqSXEGLLtUkl/Nd4UaU2GXv?=
 =?us-ascii?Q?f6FRC5h2172j18TAAS1wxtHTCuXUiOa1vYNuCHJKDv5TUgmvCm/gIkq7GmVQ?=
 =?us-ascii?Q?A99kIHcw/Lky+q3FQ2LNcplfNM7lyaQyXBqwLCVi6jC8mZSqw9SoUvFYPBJC?=
 =?us-ascii?Q?tQlt0QhBfH6pi3pWquBrXBAmIRA1t7WaQZf4ZgGz/mXhrt4fqMfresQWSB6x?=
 =?us-ascii?Q?yEVaZPal4WyLicqPBvk8gox2Hx99iLahZE2HRAQn5opOQFnOXUUolzUxyKsy?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e409e-d831-4260-973c-08db0a217bcb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 22:11:53.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0+wRRCEdqOjuD7KaxtMlvLEKzOnv8+RyRvv+R7Xg5U4bO2MWYeCMenFblvK11ibgaeHEy1TVu50Aro25Cc+irP/mV+KRmbndpIQe/Xb3Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 06, 2023 at 02:04:47PM +0000, Emil Velikov wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>As the inline comment says - the declarations have been dropped with
>glibc 2.32.9000, as a result the build throws a set of lovely warnings.
>
>Inspired by umockdev, which bears the same license as this project.
>https://github.com/martinpitt/umockdev/commit/f1b416400479d861deffb4c5a40422dcdf190e85

nice. I was thinking "how come the names are so similar to what I
*think* I coded 10+ years ago? It turns out kmod's implementation was
used as inspiration for the umockdev :)

https://github.com/martinpitt/umockdev/commit/30e9d689181ee1cdea30933eef537b5b805d678f


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


thanks
Lucas De Marchi

>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>---
> testsuite/path.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/testsuite/path.c b/testsuite/path.c
>index c1ae498..5a291b1 100644
>--- a/testsuite/path.c
>+++ b/testsuite/path.c
>@@ -163,8 +163,15 @@ TS_EXPORT int open ## suffix (const char *path, int flags, ...)	\
> 	return _fn(p, flags);					\
> }
>
>-/* wrapper template for __xstat family */
>+/*
>+ * wrapper template for __xstat family
>+ * This family got deprecated/dropped in glibc 2.32.9000, but we still need
>+ * to keep it for a while for programs that were built against previous versions
>+ */
> #define WRAP_VERSTAT(prefix, suffix)			    \
>+TS_EXPORT int prefix ## stat ## suffix (int ver,	    \
>+			      const char *path,		    \
>+	                      struct stat ## suffix *st);   \
> TS_EXPORT int prefix ## stat ## suffix (int ver,	    \
> 			      const char *path,		    \
> 	                      struct stat ## suffix *st)    \
>-- 
>2.39.1
>
