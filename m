Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401CC47088
	for <linux-modules@archiver.kernel.org>; Thu,  1 Dec 2022 06:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLAGDu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Dec 2022 01:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLAGDs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Dec 2022 01:03:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677E9AE38
        for <linux-modules@vger.kernel.org>; Wed, 30 Nov 2022 22:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669874627; x=1701410627;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9reQqeOx5CnBXNnke7bIYtCmdX3e32zmnPbTY+bf6FM=;
  b=Q09m8naoovaWHfLSj3l/mCyA8zejKYwcwwWSaJlSMkcLExgXr3vkqxfF
   gkngeSB7GYCh0JYK/v1HszMD0ahBinwOddfLmD3uv2dh39mJwNC9kcuEE
   8xJvTfcXESNBXeNvMKOgH/gMCWCmagdw++wFmDMIvuByfX2oeyX1iZ+aE
   rszFOa/reoSqKIzvc3hzXpbHoVsfSZsrhZB3o94urEcAqITe5trEjtrST
   aOseyPCIQsr0JLrZjNzziKaRSu6vZtWBF2if93jACoSex7XhMd8ZQ5MdL
   Jm/7jT0Adx+NWtuwVP6lf+i6oMz9YGRw5iXSO/Xu0VYinFmE4xP5a3TpR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342521945"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342521945"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 22:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="644513027"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="644513027"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2022 22:03:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 22:03:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 22:03:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 22:03:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 22:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCQzOjX7SEL9x2r/7n0HEadi6TjX22TD5YrhTlnPTp13UgErEL1tsoDq+wxs2ZjpF1JMrVEzkepBYPKMBiCpK0JJirONathNpJgZecjwKwcrtpf3FjpQbXxLZ4KMW/mhy38p809BZJHyqd92u29b0yiW5/puxxsmvuXm7sqng8cDAQkir9/52SAtovJrKSWjla6Q5w+XgLl7dLxIJ3rWJmAlH2uIUfxzREzIf555FLW11Qy8AL+EWmDSQwRkcNuTG/8bYH/HTjE4vz3n8Eh+7HFJvOmba500uSUYlcjqJR/GhHjJ1KydOm3VqXmzelJQIq8Hbuj9EzqJVxj0pivvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdtSjPqddgzWi+BnYEgGVkQlqAVc8XZ8LjU4y3XeZEs=;
 b=C1BcakrV0ORz8fBUWZbh9KZOlnaxTR1c6B1M+B1E0OeaQmy7Le9AjsSYTGvCu3weXAWnfXxcty/Rn1g1oJH7tN1CwBw7rTHaMZc+fow8M2ksL+IRPnZLYtn03BrNoD23N8CnmuML47WUhIi2pQb3N9n5wxqXcnH+nt/040DITURvaRwbz+AKLqhGszrFDBrCzelEtlCXC7ilj9VsZg4+wxNuLZAMVbiYPRnVln3vnOfTO1xzhoBaBG4IqHnyl4y72r0sNa9y5U+u7guqFFpaA1qZQRRB4ZYFqcMCL8YFjuZDRY88SqN88xJjMLMcdt4+mXtSgL9zsUIbwkfWITpzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 06:03:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 06:03:26 +0000
Date:   Wed, 30 Nov 2022 22:03:24 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Adam =?utf-8?B?R2/FgsSZYmlvd3NraQ==?= <adamg@pld-linux.org>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] autogen.sh: remove --with-rootprefix, it is gone since
 kmod-11
Message-ID: <20221201060324.ihhza7oqpcieoyvq@ldmartin-desk2.lan>
References: <Y4R52zzp1gKls8+x@adamg.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4R52zzp1gKls8+x@adamg.eu>
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a2ead-ad1f-4996-6ecb-08dad361c2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRfzvPVHSeWFZCGg+g4m5PDm+jpLyf1fBTcHj0PzVkLIgyPjRVhvfqoynTymPuFS2/ivGNEpxUqQRxcdcAohnCCkY0TNlrQLKYRM7IsE0sk83wuuVbBWDLsl3IiZaspw3g3KF9ReAQ4ZljgKIdiuEPM6BTKNRjDoqEEubZ+Bi4xb6vBbof69uiH7yCILq2s6UUTW4WuT3LlkNQFJdnh1cJt593InS7sGbXA1LTrQNPcduGg8Kzhn0vH1ee/2xlg/rexIqNbxsE7mvoOwihIv5xzYqO0TMmhupzIrdvmeyAKIXuDD/vZWzJN9vIj7iBysQ3XFR3dWm9vJ+lTf6vRC0vDhHgesQcHPoUbzEFCYbAweOmhJ3JK9tz3Qj6MosWFWlyWF2CRqWuq0dc5hRgs6Q11raVfOvTZwYQHkqrHQ9HOaLR/bAaxPjWh5kn70x5ZqdSo/OMiEiTGINuZsQ6WzmGDmfovhKHwNUVFtzJQ0LOS//Heg9DXnz0ocJz5VIoXZFpfPT/DpUE9L4Y0Lxx6HmSbV/ximOL7BgnWPcpm0eDplIM+POJ0MZk/7E3D/e3FBUjZpnQCZBmLImMFZl/mbzGOyH+QLzkhNNQF88g2RYGSnYPMY20+++l/pebYx7AEjvK0SdfG1EPJ0ZmONXO/4iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(4744005)(8936002)(2906002)(38100700002)(6916009)(86362001)(6486002)(41300700001)(36756003)(186003)(478600001)(82960400001)(1076003)(66476007)(5660300002)(8676002)(316002)(83380400001)(26005)(66946007)(6512007)(9686003)(66556008)(6506007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpTS1FNR2U5YWxDbHlxdlBMT2VjNkNGYVVIMTlSWlhScGdJUXp5T1BiRlFC?=
 =?utf-8?B?MTJ4WVFUbnBWVjJueGdqTEl0WnJYTzNyYU9nR1dzZkpkOXBhcTgzakljdWU5?=
 =?utf-8?B?YkViM1JITWFLK1ZLN2hmQjVTejVGUng3bWlNZDNRVHZscEczSEQvTmhRS3Rp?=
 =?utf-8?B?QWtTUkEwWTVIWlJKOHJvOHhDU3pkRThmc3BHSFgyYmdKakoxcVVJMWpNWUI1?=
 =?utf-8?B?UEZUd2N5aUxFL2YxWlE0ak12VHB3SThERWRzYlhHbGNkdlI5NkNuSnc5RVox?=
 =?utf-8?B?bXYya2NoeDNnR3JEQ1Y2SW5pWmpjSGZvNWJpWGVtQVhpcmdMaTNqQ2xDVzUz?=
 =?utf-8?B?SjMxdnJDaXFnTmhkVVhmUmFQdG9qMkNrcWlEcUpsSXJTN3N0OW1hVkxiMFox?=
 =?utf-8?B?cGU1SW5tMnREQThndXoydzlPa0tTd3FtYzdFZnA3TFBJL0xka2NuT3V3cEVt?=
 =?utf-8?B?cWhsb0pLRGppSWMwM2Jrem04Nm9CMERxYjQreTBxN2IvYk8wZE0wYitRc005?=
 =?utf-8?B?bXhRd1RUWHlZSTZTendUTlBzU0FaWTNxY01Od1E2SHRUTGxjWkdJM2FQS0lz?=
 =?utf-8?B?TWRGaGJVcWhZRXNhay96YWY3dUdLaGxoL1BrS2F6dHdNci9ja2VaNnpPZllQ?=
 =?utf-8?B?ZmQwdGVJWXZYU1JMRk4xQWF6Ky9jbHY5QVFDOURYaFhaa0QzZjd3YjEvUGFU?=
 =?utf-8?B?dGRpSXVMUmdCYmJnT2R2UXJOWkU5NThZbnRJUEV1bytJeVprYktTRjRUQW1t?=
 =?utf-8?B?RjdVRjlHU3B3NkpreW5ITnR2Q1oyMjhjcm9CQVhlQ2NhUDgxSlB6WkxibWRC?=
 =?utf-8?B?c1ZzWW5JZnNwc2pLaXN3ZkNtbkgzY3F4R0VyYm5WUlVmNXNNREkvbWtVcVVJ?=
 =?utf-8?B?NVhTUlZQaDljbzl2L3FGNEszS3RMK2RjS0o0Zy9lVm9XVWdBY0tCaERWdlhU?=
 =?utf-8?B?ZnZDRTMrazk1VEZVWmRtb0FGTDZoNHprT05MRVJqVVdJQWFoSDdoQ1BIMDgx?=
 =?utf-8?B?SDg0eDh3RHAxdW5Ya3RMOGVnT2g1QU1CUUlQRTFIbTFSYkpQOTQwTWZQZlJX?=
 =?utf-8?B?ejByeFhQT2NMQnZKRCt4bjU5WVJiU0NSWHdicUgrQ3ZzcU9VOXRsVEpNekNO?=
 =?utf-8?B?R2RvWkNCSW5CVVVjdW4wLzdwOStFME0zN3MweVY5SUhtZnNHeFNscXFzdUJj?=
 =?utf-8?B?QzF1eURkcmFaWVBuVlBPbEZBT3UwRmdydmdjVmw2YlJHZVNoRTRnazdQcjNH?=
 =?utf-8?B?VFgwbEprUjEraFRlbEdYazZEUVQ0U3FKbklXanVRaHpoUzFwcXpiVkVQWlFx?=
 =?utf-8?B?TDN5WGhKbkY2d1RHM2FpK3Uyc2VzcjVJN1hiOUhpZHhyazNHV21XMHcwU3Zq?=
 =?utf-8?B?ek9FVVJ0YTdGU1A3VFY3eW96N3BXeXE0cjREUm80VHRIWW4vV21qaTQ4VEhF?=
 =?utf-8?B?dTBZSVVYdGZVbEJDZi9RWkVJODlNSVdGdm9qQm5pYlREUVB1dU1qdldrdGpj?=
 =?utf-8?B?UFk5VkU3NW1xRncxRnNTSm9EMTFMeW84bmdtcXZTRmd0ZTZERHJOS1FEMzlO?=
 =?utf-8?B?N2dzTWp6YjhrdGJPbEtiRG8xNFBSQTdBVS9leEt1bHNBWFRGeUEvcmw5MlZC?=
 =?utf-8?B?VWlEVkFROUFjRy9ZVG96elpwSDFobG02MVhaKzd4OWt5akdnR2dxcU1JMnJF?=
 =?utf-8?B?a3ZGYkpqT0RlK25sNW5NZG5FMlV0eDl4bzVlZEc0ZUI3K2FxeTM1MVNXVkhI?=
 =?utf-8?B?YndwQ29SSGhqaHpqRlRmSVpveXpzb011SS8wemZVdlhmZFBhdjRLdzQ1WERM?=
 =?utf-8?B?M25xWFp2ZkNaQjVtUmxvNWl2dnpUemNuRHRUVlg5bXZJUlNhVHBxWHlqU2ZL?=
 =?utf-8?B?NHk2UWFqUlhPRmU5ZkJrRUdwUzZFOHUvNVl4S2tIRTdjSUFTVk1qQmNYQ3NT?=
 =?utf-8?B?UE9IS0ZhNEpRZ252N2tqUG1sb1hZQy9Kd3Btd0JVL2VOSjNjREtLVTBnV1V5?=
 =?utf-8?B?TENOMFh0Sk1VaEMyaEFMdURFRGw4N1ZpeEdadGVDaytTSStNU1RuL2JRbTBP?=
 =?utf-8?B?elE4YzZKdlBzcTlTVnc1ZmREVlRwSVBQSnNmbUYxVmNRNU5wU3Rkb0tXWSs2?=
 =?utf-8?B?azFjT0NhL0pjVTlUcENZNmZQRGtLREZDYmF3ZXJiK00wQ3ZHQ2tBMnFyRWZU?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a2ead-ad1f-4996-6ecb-08dad361c2fb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 06:03:26.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NnAvfGdSj5r8LmrLamr9/prwWCl8hOYsEzJehGcnz4K0UaKN+x/Cy96iCJZu2rsLRevhrcF15lHRI5KOXxgQIFtX5qat3qfpP/Gk9QYrVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 28, 2022 at 10:05:31AM +0100, Adam Gołębiowski wrote:
>Signed-off-by: Adam Gołębiowski <adamg@pld-linux.org>

Applied, thanks.

Lucas De Marchi

>---
> autogen.sh | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/autogen.sh b/autogen.sh
>index e4997c4..2616247 100755
>--- a/autogen.sh
>+++ b/autogen.sh
>@@ -25,7 +25,6 @@ fi
>
> if [ ! -L /bin ]; then
>     args="$args \
>-        --with-rootprefix= \
>         --with-rootlibdir=$(libdir /lib) \
>         "
> fi
>-- 
>2.37.2
>
>
