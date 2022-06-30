Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C94C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 30 Jun 2022 15:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiF3PIS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiF3PIR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Jun 2022 11:08:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856A1EAE5
        for <linux-modules@vger.kernel.org>; Thu, 30 Jun 2022 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656601695; x=1688137695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q9T1bQrLmh+sbpxKEuKGKx8BKSlNBzPucOj7Z0zo/Dc=;
  b=GxN29axmJ76pqwZXWqgZ1AUB6PpDe6hcBntz3oPlC6sjDmuYKWu6FfSi
   Oc4a0a09BvNPekOZIEu6PQB80SpeB4aEB9Rjjd7JgT1eWUfhhjFjMzB1b
   txHGITzpA655O/KUvpJccRlNH7HmOheNpE6NDhABAX1pe0qW+r8G5m4c5
   oQoYwgaBWYciXjts4QXvYCxjx3zgaq/o5YAJMm/48FOr5IUV3tt7rInMy
   oQIwBCyknqBrucNjMPYjXdMXJYbNr62UQ3axI2zONkSQ7WYxB5U366SnR
   RvSLgRSdSA1xydJ4Jy1HmjnJtvqt9+BC0mD0QZX2iwdaH4Aip4WMlT3Hr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262776391"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262776391"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="733663772"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2022 08:08:15 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:08:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:08:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:08:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKUBEv/IFmP55pmovjPYUPpR0ij+GiuaqGLFXKrHrAfMWuXrfTcgRJS+Pd061gBCZuttuFja1UHbB7Snv5wqcdFRUOQksdSmCosrOD40ShFIbqK60ZSV96Le6dOGMkAkzc1MTrOziy5ej/GCasnum/7msxDyAMzfCKDnixeI5jYi1vk9YU1gsd5eg3R2pe60SQcgxlde6a7R+UqbNX0BzYhWJ15jF4twEbL1bpgb6PGNoBXhU/EWFkqE+SLE+Iv3322sAdcevXA5ZO9tw/jNZj8dM5zhVc+xpApn7ioxp+TZzrM5/ZPQIohPVLurd8m7TpdGlQsLF/ZPcItFtseoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/KnU5bJ83zWN9KKKNolR1RPWrAgMqM4d1630VC4Cb8=;
 b=jdMMrCFagzsQAPj3hSlFbZ9sHWtec55QlQCyGIwDp4hjiHKH9NTTNDEbHHh5vL+asfgQI89WUR3kVduYOG8TnWMsWgHQrPHls9z0XHkEyXsh6Ds4dABcfhW+nv9ZMEDzRKGYKO/ZrXYovtTa9tjq10bHJQsdNlyzdS9hsGAYUAXg77V0l8ZHlsHWTaUtcw4lHMMrzZ6F8+gkyMAFeStfAzH3gFMMX5JgicVElDqz8+cQxnhh6fjwM/3bAZatgo/nUb0L+VfYJry9K3YNR6j5tE3l2KaTXyw9MCj/gITrHinEIyXPxY7fwVgx1K+jQ0GwLj6TUiarnXqLZ1ye6kTB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 15:08:12 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 15:08:12 +0000
Date:   Thu, 30 Jun 2022 08:08:10 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     <luhuaxin1@huawei.com>
CC:     <linux-modules@vger.kernel.org>, <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] libkmod: Support SM3 hash algorithm
Message-ID: <20220630150810.frgjtc3a4sxtmnsi@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220630063605.9192-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220630063605.9192-1-luhuaxin1@huawei.com>
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ca2789-8e67-4eb5-eca4-08da5aaa595d
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZ4mHBxT6jvOmYIeeqy8MsmD10MuQUD8p0CBoqbRO5He3ottNgBtx9IAyY/fx1fTQ49w72pj+DHOlZN/cr/Xu+rJUVLuePMCqhxY9nK4Epb0H0SLD6Iz1MPT2FGvTpJJYs2LNflzAx5BzwKO1CL7Ih01fu0naM7ItzFGXEahG4A9tdBuwcvj0i7sOmOgfEnRdsQU62dVdMVv9RlS+/x8jhtNnDVGJ4PUaCN5arWvijkVhH+hJIyww5wbqtENGZZ13x+Ql8Obut7XibVDoNRQEOh4SRua1qSqGet4HWQFq5EI/ULBu+spjceU7QjgWCuB/TCmNphLdUEe/OoKEfz5GgZ9MyFjP5dizqodXZ/uJdGcS2cPt3fSCiGiW0b4k5F3iHPz4ZWW3GYh3Pl1xN90AbNGSjPWcrI9MsirrdA3Yd39WWUux1f8lKPYLVfGGHw7IrqmEr1TKByiKEWzG4HXFs0Yv/lBl61wfxD3Fb08vbapyN7OHIUrfK7mBAgwwTylAUxmDfE2Yus11jWjvUe5bnDiy0kbCue95GJFLxtsJimgQuubDMF+mXUbLlGkyr1iOe19fwgw+3MsVj9ZID3i2cOHbhTkOZMZfD3TX4jYHHgid7c7++f5/g1fp5sKfekK+rlOinBHYpJLTrBd3jaEZFY63zpia8wNc8B9TTTI8mJNmUOkU/zBPLAUSpTj1aUvJ9Z19HGkhXUXiL3EJreFwiPAqRm2gbNlL4P74wpY7nQoRYTFw1gvd5F6d4H/Uc/aOtNMh2z65HqASb4S5S/lQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(5660300002)(6916009)(82960400001)(4326008)(1076003)(38100700002)(2906002)(316002)(9686003)(26005)(33716001)(86362001)(66946007)(66556008)(186003)(8936002)(66476007)(8676002)(41300700001)(478600001)(6506007)(6512007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6MYiNl2cmqaEN8jjfQULe5GJtRW9WfFH4hr/ehxvBih+B6I+H5PYyzX225g?=
 =?us-ascii?Q?SxXRy0vn9A6szm9nWLSSQaFIPxPI8sx7PpLVaA9ZXznLpOmIFOtla7i7xZOX?=
 =?us-ascii?Q?TpstwCREK47RsR8wmjUzzQPpFzTsKQubKYYn8ineohFz3x148VK8ubu4tdK0?=
 =?us-ascii?Q?veYitudI9C98RdkPUv7Ky+K+msYPBt7xBkj1kYPXRwbSTHAZK6AdcWI2HMiR?=
 =?us-ascii?Q?NibVGs0HFJ6igqNePCKuarvcqVFo1y8LuRPludb12Uuf/9znHYcTXQiCQZxs?=
 =?us-ascii?Q?40g2aUZw/NEA/9eP6y8+TZkcHXKzv0p7cmL7BRL/8Hg4MlwXibxFlwwlAVG1?=
 =?us-ascii?Q?Cl4ydrZ4/YbkSDYQlxtCceGGsWpEWIHxyZ0KfbzBmxfnEJpe1YasczTB9IrV?=
 =?us-ascii?Q?sl0LtKIRbSe5H9okglQgYXCvrEt/2KtV4K+lU9TiX2u+nE9DNTtW4R/VKQvo?=
 =?us-ascii?Q?QEGnPECzeJ3QFtqZG7LHIKz37CETmcoMPBwfiaUoykWrygXHpb+cJGrvbDvU?=
 =?us-ascii?Q?5WAGANY5PX6eLiedTG/6uGxQZI0NZkgcR48hozolAxUblbKdoGFP/W7dHHeZ?=
 =?us-ascii?Q?qQXrfljERDUd3s7PhoUk8ZXVQfTBYsphkUZ9fFHyG6BbWwOKgPbOmD2gzpkA?=
 =?us-ascii?Q?pR8Nv40urilaE1/zkDiC5K+w27lUEDJLhn4KVRCv3EfCd+TTiq6m2MDVV0Zt?=
 =?us-ascii?Q?PIEKcrcuyG0RKBGa45wpATK3OzqXGlHmXuZQmBCYxwn94Ka+uY3+HVvEAV5Q?=
 =?us-ascii?Q?xCoZRzVlnWhDi3Zg2/GmOYAzBBURjblYngi1/cfBof1ffSLCra1GJ+W2f6WH?=
 =?us-ascii?Q?kq7jZ6LI1yM7K8uAhN2rkp1KZY5h0O5VC0ufjFEOVFaiNu0oIR42ZK5VtrfL?=
 =?us-ascii?Q?HZo1Wl7zJys7vZGcquIAXw6EVif9drkcpg5VTjv6jyz1TJyj37Xq50FtJkb9?=
 =?us-ascii?Q?Nk1N2Rc3+DnmN6GbBNnUcxGzdl5grjthyy81BofYFLqEE7YWjlcc/OMIl5ef?=
 =?us-ascii?Q?cVtdyqEyInqsY6/BZuCBInxBBPygohvu75f8O5neAGQPhUksLXsgpbuWta4j?=
 =?us-ascii?Q?0V2I1uqeEzdbkT7ZBNRFnaGU76bu2kw823kERkDOu96+NeJ3bqfemV+3msfO?=
 =?us-ascii?Q?8JhwSMJ54Ey6qKvt4yy4Kd3kH/J3ThAeAaLD+zBRfk1HtCBgPghpkwR2PEWn?=
 =?us-ascii?Q?5Pysv4UDv+F2I7R1kZgQnz3Ssv8t9o4ozKNVC6PRlWapmQXaY0/NcF5nHmSs?=
 =?us-ascii?Q?XYBUO49R1bdv2c/291ukCWTMe1c+hcul0/2XRLFFmaN0m0NYspGGmCTMiWqO?=
 =?us-ascii?Q?QQzfKbNnxPb3xM31JKug74cCuzRE5W6Z5zWcJO1JfSeiizHlJX+VDe/MFRSj?=
 =?us-ascii?Q?0x2GSpD/hmDaHd6sSpwRvsO4mpKl2A2T2RH9BysaoeGJtZAq8rFLLcD/OIaD?=
 =?us-ascii?Q?eNoPmdKcML6fN2okMM55XhqJY8RqkedJVNpHHEFjeNetS4ArUi7rnZ2xP8tE?=
 =?us-ascii?Q?VNVCBx7XA5LmT1AeZ8QMN+6mLzJXlCifkMPCIez7eQJ6zKTKrkIogDDKL3Rg?=
 =?us-ascii?Q?IlHlFoXT/KUi3TqcwhnPkL4uYdQbelCBvkWKb4blZ3suTn9YmXKm793A2S6/?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca2789-8e67-4eb5-eca4-08da5aaa595d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:08:11.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvV3144p9HHhTuRd2z6ZM0ZMh2z8NB++htvyOHcteVLxzs3pe28Xt1+W4HAKP0Ywv4hv/C2DZ5mQaPiYXRdN1LjGETxvm7plhVgR4qLE3N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3672
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 30, 2022 at 02:36:05PM +0800, luhuaxin1@huawei.com wrote:
>From: HuaxinLu <luhuaxin1@huawei.com>
>
>SM3 has been supported in kernel and cryptographic libraries like openssl.
>This patch adds support for the SM3 algorithm of kmod.
>
>Signed-off-by: HuaxinLu <luhuaxin1@huawei.com>

applied, thanks.

Lucas De Marchi

>---
> libkmod/libkmod-signature.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
>index 4e8748c..4ae5af6 100644
>--- a/libkmod/libkmod-signature.c
>+++ b/libkmod/libkmod-signature.c
>@@ -56,6 +56,7 @@ enum pkey_hash_algo {
> 	PKEY_HASH_SHA384,
> 	PKEY_HASH_SHA512,
> 	PKEY_HASH_SHA224,
>+	PKEY_HASH_SM3,
> 	PKEY_HASH__LAST
> };
>
>@@ -68,6 +69,7 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> 	[PKEY_HASH_SHA384]	= "sha384",
> 	[PKEY_HASH_SHA512]	= "sha512",
> 	[PKEY_HASH_SHA224]	= "sha224",
>+	[PKEY_HASH_SM3]		= "sm3",
> };
>
> enum pkey_id_type {
>@@ -161,6 +163,10 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
> 		return PKEY_HASH_SHA512;
> 	case NID_sha224:
> 		return PKEY_HASH_SHA224;
>+# ifndef OPENSSL_NO_SM3
>+	case NID_sm3:
>+		return PKEY_HASH_SM3;
>+# endif
> 	default:
> 		return -1;
> 	}
>-- 
>2.33.0
>
