Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDAC77B7A
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 20:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjE3UVN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjE3UVL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 16:21:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C65F7
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685478070; x=1717014070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hJmJ8oPNe7Z8Yuq024KY/8csitoLqBC+XSMQ65sUhpo=;
  b=HXYNY4llSLLlUD418Kkm1UxFx1g6Di4EMfu3nRv3sQzulgnS4kVm6Ldl
   fF2N0boN6ixPsupixrXBR1BVaaYVAu8FK1iTrAtur84N/jWJnRc6LIRcz
   yMa/ngBtVymhdIxrcTvnacyDp/xSCmCEfD3hMc1oyrLT5MMtvqYKN5Skk
   IpxD4zQ5F3/NfAUJBE/WpUgQOJLdqn0rXpFuie7OcVLUJa51ROoe16USd
   W0RmpnhS+5nfvx0RGTXxp6rgBuKaYVNkYdEfOSjxwtlS3VeRcKMmHx+jV
   SkL2rV37VGXxtxatJ661euX+GZtZLDe5V1tnLLA3tJFD+Z86wTY9vDRfk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="355048022"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="355048022"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 13:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="700778860"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="700778860"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 13:21:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 13:21:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 13:21:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 13:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIypyg5sij8ODjNBtBYM+Ln5JFvzU3LZ1bwL/6I5kf9xStyeQ0rOwN94w+zgte17a1gcDHl2hHFtf7Z7MlKeKPm9ZLjE8OoJ/ROOp1ad/eg9J0kF5P1v4ZyUzOv91ZyBrTEI7GgeZ87SZiY8cYU2mMrmzLIXIUygvgkpMboA3D68zzfWg8H8Q/pdWz9SvUbhSLF+abp4scVIbNgUwRqqoelRWj1o68u0DSk5LEX+rQ119rEhtYlkkOUwmeSSysN1Me705HqyXfYeKVH4XYs3wyjgV7+JGKLkxVwrHrV+F1y7o4xTNAcsBfETtx2OpN2B/pkUhiTxOKEE2NuMCqRSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg4Vz0U1AlBchQ1MWJBP2efhhOeBMoxkovOavD7o2y4=;
 b=ccCbUWFj6Go/pnkhCecFXjED1zPIWDh4ubCuP70DSdd8/nYdqyHP4c526HvfsRX/Evb4+tlePKHSZkxTkZvEBdNc/W1rUJtqmW9ReZoSVcaoDALM5pVszJR9ZIEqubwNGp2hHe7tvgAUgye5F5zWQhvWNe18yWhI9abX2tlmloobmVtSPCynpG9MPFwnfZcD185EFSEzsc9KGhySANwx5vjy79DamOgftwFGTi+64rbf6gfTwHVwzwZvjbaB7/+gRyx5TxB1mTvseUXbiLOpderf14NPWGa6t9toTJTTxnxF/D0tGz9KitejYyJF3OzKU3isXTwBSd61IrKCFdEwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:21:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 20:21:07 +0000
Date:   Tue, 30 May 2023 13:21:05 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     <linux-modules@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] shared: avoid passing {NULL, 0} array to bsearch()
Message-ID: <ry5ekq7cvyugnvo2ykhuktmngqoq5zomtc2zvjwtevtd5s4ueo@7wwzksbprtzu>
References: <926001fd-34bb-83ee-be77-ccbded164615@csgroup.eu>
 <20230519074108.401180-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230519074108.401180-1-dmantipov@yandex.ru>
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BL3PR11MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: a14bdc05-b7b4-43ff-fbda-08db614b6697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImUrae2qkq60jDDpJbeNVuTwL8YxB0i0Qq973N7MjiKDP6/rg7AfGvO/kyZn9uwF95OdDYs7yeX/KBcj+GobFB6cUt3ec/DMu7EsaLg3PDTm6aNP1IRyTWTAVSkznvCAoPI7DXRhkg6gbTikoX9zdlbrlmOjtLmrl6f8j4OR+SsY0jY6JC+ajlPw3LN7z9V2PigjN1lFei7APXbNBPbXHPYOvREQoHECqM0JdmFj2T/6MTPOEHjFipIPjd9Fcvbytg1UX1S7eHyalSZlLBPp+M7ri+QbZyNDKYdsfmcTqR2IF1V82IrFHF+lJh3ojcieh/seymv9q6pmEVn4qbkTafyjGPJJTdS22g86MDM0HxwmLfkGWxxNrQuS3qZCXz0iuOo+f5xSoqZNTQL6SROIgVlkhf8JBkarIF7n+3C3/BHWpvrytIlBPdpTPIuEpGgDR7hNbx1w1ei4hAjT1zI8LxQ0G7xIBDhV6gXd60pgCdQfYymbMP9rsjXzdwT7dCicwKmvr1gTEjHhHwzheSh8ZYK5JgEqQURd2XIHoDGM373oPjCwCcm/Gu8atsk6n8xwCz9YhCYe+gtGAoOZzf6MmKpMfmwdv81CJ/Yk0w2I4HTlf+5FEWVVa/IkD73mJOsS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(86362001)(478600001)(4326008)(316002)(66556008)(6916009)(66946007)(66476007)(83380400001)(5660300002)(6486002)(33716001)(8676002)(8936002)(41300700001)(2906002)(38100700002)(82960400001)(186003)(6512007)(26005)(6506007)(9686003)(23180200003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+skMqiK7/5YA6DAcPYIbguHijgSol9HeRraQdBJTak5I3I/t+qKvcA2HbC2?=
 =?us-ascii?Q?oCc+rxqW2lLQSZG+kjD46TJ/2gWd5tCl9AHQlzFzCZ/JM+DEZVJjhIP3jiJ8?=
 =?us-ascii?Q?/ovN4nH7Uzw47jbZ3MS7tviL2XMtfQK0xlyisAFvCkptIwnspQzOVTknuBxe?=
 =?us-ascii?Q?mbcEbFTo19VSBJfBAEkbH/AZ02QbiSkemHmNDS6wrXEJhyvc8y5fYuUhVubQ?=
 =?us-ascii?Q?dUnOchMVlJzJE7FAsIZlgYyEF3SQMA55s9zkCUv0JRPCk38voFbpSrfjRTac?=
 =?us-ascii?Q?JUT8ms8PxKiWjRP5AYzZijA563cAaM78buhQ6/d+w/RwuHOaTZ18vJ6L/1ZW?=
 =?us-ascii?Q?iAkmYEPQR10UXZ2WkUZiRoaGOq2hlDcDGFh8TEmus+a1AbaTUu1U/NdA/iKP?=
 =?us-ascii?Q?CxaAVxNfFoQcnIbWZ2i5Hkl14R5ZXHL4h6TOLJH9/qLMyIkUZhKa5NRLJyny?=
 =?us-ascii?Q?sOa95nQuKBDhnodJ/TbYaecYeo9P8EUznraCU3m09wPepZKV/aqfR65eLqCB?=
 =?us-ascii?Q?CrWdo7FVZfSJTONOMjc0iRSnieu9ZQSkHA/cQFcb+CeE6iTfBrV9bhBFEDSu?=
 =?us-ascii?Q?s1Dw3t7ICfDnKqmVB/xI+8k2TSFUMcJmhT8ckQ0+W2fLW53o5Ga1POtGunq5?=
 =?us-ascii?Q?mTQmSNJYy5Wv82j5qmYXPwQwrZv0Sq9SW8AeHhSLzqGcQGKKmOIHZ+UoNyig?=
 =?us-ascii?Q?dmktldmqkoXQaQdht0RWxMU7eNhoe8/Tiq5QIUi5eAnLlHgixYWBkhsbA/eb?=
 =?us-ascii?Q?KYPvZKaIF7XWuyjGoq3BRwJBr8YQwrGrjcZi9o1aEIx2Xvc0OZGDgQJDheZQ?=
 =?us-ascii?Q?vIdhEyY5Lv0KTiC7XzJ7HjHsispjpjV30CY36T7DqbYmvkARGc/FJMUk2ytG?=
 =?us-ascii?Q?fxklHqEdUXCsZBlmEjBbSMq9P52Xhnh7Z6S/AmqI96udAbyyOeIJM2kYvK6Y?=
 =?us-ascii?Q?BMcjfTp6l9VfYUOA6A0GMEhs0MQBW5+ueO7DwbROYO3fz5z/rQVuqAQPBfR3?=
 =?us-ascii?Q?lDN12ZJafwZMNHtcsGQ1QYbpA819+lAHIscLfUiMEx+Vrdj7jmOI2bVEANRo?=
 =?us-ascii?Q?nlmvO9T5BOcv86X2e6b6fFuFl6bPQoQUBdUWjaQoFICQfZwUeaQCOXDdE+j8?=
 =?us-ascii?Q?CHAmpvR924KIrdeFJ9P/jM0+8mVmoY5wD8n+1YPxBQdkBtjxa9TILkQvDyZo?=
 =?us-ascii?Q?oW06s5hrRH08ac6PqcBgAi6JYo/mVU6AsaQN92Q8YHtTxnHWkoTxNOyyrj0c?=
 =?us-ascii?Q?NnZFnzWeUo2z3JGYMfFUPoocHj06USYOOEFa7FGa29Hr/y/XCOtVlhK+w/4W?=
 =?us-ascii?Q?CVQl0oAvb+gW11iq7lUPstJ2eLVBVr7uVe/7HTa1kVWidwZXkUXLhlkaCUMr?=
 =?us-ascii?Q?XhHJny15Xs6s8zf78S/hwdauweLHlsqLpp/6mJIRNOR+rlOhg/UXYi30wcjH?=
 =?us-ascii?Q?L/hH+5852XZzAi8EAg+FkeZM6eXGMSCVxyZhHihuB3DWuKdbDSD16ht6eHIP?=
 =?us-ascii?Q?jviGTE1YgdgIvTWBgVCKrTkyCdUD98eE9+alxwjaCmBr2tjVxa2Bdy/Mha1F?=
 =?us-ascii?Q?IfVTScmV0mupR2r2Q7L8QjBS6JUGCtcqYTEAcLuNdzP9sDhMHdw+tiQa8D6N?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a14bdc05-b7b4-43ff-fbda-08db614b6697
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:21:07.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI1ZGxxovI/uJAl+MXAE2yxpqTx6ZlkvbeAuwE671H+R6OLIsXTrSCea+s3jeYt/E3OuylM27UxuusCp/uL1xt54/QyawxNfHC0JJZHumLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, May 19, 2023 at 10:41:08AM +0300, Dmitry Antipov wrote:
>Fix the following warning reported by UBSan (as of gcc-13.1.1):
>
>shared/hash.c:244:35: runtime error: null pointer passed as
>argument 2, which is declared to never be null
>
>Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
> shared/hash.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/shared/hash.c b/shared/hash.c
>index 7fe3f80..f90e22d 100644
>--- a/shared/hash.c
>+++ b/shared/hash.c
>@@ -241,12 +241,13 @@ void *hash_find(const struct hash *hash, const char *key)
> 		.key = key,
> 		.value = NULL
> 	};
>-	const struct hash_entry *entry = bsearch(
>-		&se, bucket->entries, bucket->used,
>-		sizeof(struct hash_entry), hash_entry_cmp);
>-	if (entry == NULL)
>+	if (bucket->entries) {
>+		const struct hash_entry *entry =
>+			bsearch(&se, bucket->entries, bucket->used,
>+				sizeof(struct hash_entry), hash_entry_cmp);
>+		return entry ? (void *)entry->value : NULL;
>+	} else

I'd avoid the unbalanced brackets and replace the bucket->entries
check with a return-early style. Would you be ok with me squashing this
into your patch?

diff --git a/shared/hash.c b/shared/hash.c
index f90e22d..a87bc50 100644
--- a/shared/hash.c
+++ b/shared/hash.c
@@ -241,13 +241,15 @@ void *hash_find(const struct hash *hash, const char *key)
  		.key = key,
  		.value = NULL
  	};
-	if (bucket->entries) {
-		const struct hash_entry *entry =
-			bsearch(&se, bucket->entries, bucket->used,
-				sizeof(struct hash_entry), hash_entry_cmp);
-		return entry ? (void *)entry->value : NULL;
-	} else
+	const struct hash_entry *entry;
+
+	if (!bucket->entries)
  		return NULL;
+
+	entry = bsearch(&se, bucket->entries, bucket->used,
+			sizeof(struct hash_entry), hash_entry_cmp);
+
+	return entry ? (void *)entry->value : NULL;
  }
  
  int hash_del(struct hash *hash, const char *key)


However I'm curious about this *runtime* error you went through. Does it
have a backtrace? There are other places we call bsearch() passing
bucket->entries, but that should be an imposibble runtime situation
since we bail out on context creation if we can't create the hash table.

thanks
Lucas De Marchi
