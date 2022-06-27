Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04AC433EF
	for <linux-modules@archiver.kernel.org>; Mon, 27 Jun 2022 16:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiF0QnF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiF0QnE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 27 Jun 2022 12:43:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF0C63E2
        for <linux-modules@vger.kernel.org>; Mon, 27 Jun 2022 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656348183; x=1687884183;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=37U0Ohm/gOR7oC4mIneVed43q4FZB5dOBhgZygfS904=;
  b=l0U3H+WbM/WjTNesu7R4+7uBKP+PdZaJbyTnc2g7qVVYmEH9iE2RwPrK
   jCOmIvdDmyQkdtZQVSKBAKkvZP1WtsEy7s3m33QBthi8H5OfD5YpnNTh8
   ciJ9Vk4cuZU5U1uUMLENY3zWniKiN01Og+uUgrQYHXJ0TeLILr8kk2G4S
   Xk/duULqvHLbF3CXc+R+dueCwb2kKtaBdGiEhp29GiWvqwN4I84TkNPWL
   6GmCIxltRWOXFbrmyW6MUWYfViPrEuptUqmB79nJrSn1l6MVWs6KAgZCx
   vizyNhab9d+ck3zgsTi8DaqgFmlcqg3XbcQBGN/zjckyLI/OXo01cqYOn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281532720"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="281532720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="836266419"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 09:43:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 09:43:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 09:43:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 09:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHD3s58fhOufZh0ZuzgO1jRy9F8tmm6wHvZihVOJDGAtlXeGZBs72NqxTrmwyKWC6Ac2zesVxzrIbqYkAvosDN+wgpHHNbDyZqQ4PpN0lGeMi54pcV+9Jlgn65NGJS+OLeZBbql2e5uESlm5O8OPbWAzD0k5c/Q6NnuTYx1Cwv8hunWLmuvUFPCY6ZXytJ+3lZ2Fb83cjM4YVl3gONhSId2N70LXHX92QeXvzc2FuV1h1Nj2BGyCrOaRl/SIs4D6Eve7eAd+AJ9Tb7b4jhXB/TWduGEAWdHAEcuvSj6vZFPuVKjDjQga2oDnFNpX4MPW02SVGqxkurFWE9Z9YGOBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHVwzLbBarmnPl8WCidpOgrKgiRqdaLiQfFXDTWp7bk=;
 b=JpHhK86423Xbtc04uP7yHUanA4/yQB8i6OO2qB/GQvgzhDQrCyzW4g0G5XiM51zDfI2QqWjimcdqfSVwKR9lwMj3jj3Teu6ToDv26T9yiUgFFqfPtdsAEt/G98TBTQqbqS609fhuSHkk6mq9x39592bhhJHOsNwqPl1BlYENS3L249rIHLYPp5VxnwvskQQ1eXO+4xXtMPaq0MiJvonpCJzTLPsOdK/l4sPM3H73mntI2fEfT8QRT1woOLVmqnqPM5zFif6AG922ah9CHxQ3JvBSsrfqsC8unjhxOQQgtXfJzKKoymDFi5tr5+HjRd+WwZARv7BTNQPLCMdOY45KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM6PR11MB2810.namprd11.prod.outlook.com (2603:10b6:5:ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 16:43:00 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fc50:22fd:6bdb:5769]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fc50:22fd:6bdb:5769%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 16:43:00 +0000
Date:   Mon, 27 Jun 2022 09:42:58 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/2] depmod: Fix writing over array length
Message-ID: <20220627164258.5hi53js77znemrwb@ldmartin-desk2>
References: <20220603204902.4295-1-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603204902.4295-1-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: MWHPR1601CA0010.namprd16.prod.outlook.com
 (2603:10b6:300:da::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 497725ca-4c5a-4f12-b5d0-08da585c188c
X-MS-TrafficTypeDiagnostic: DM6PR11MB2810:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcJFi/Klozq3AaqXccjZX0yf7iAcUp+7ZNJ2JY9AVMgqwQptMmvXFgSYIJJAuovOvyfiXd1Oyvaepu34CfHxCEutZAULtF/tUdx6aktxwPTG6csoTaquDVaJVMzJXe8MuRw7jwWTsHNQbaP2WtWpWVhQb9lFA6TFw6VGqanDcLUFkrScv/1p286UHVpeeLUBlglmMptwf+YFujj2rGfzELeachlK+kekLWVv140aWP51qlpjh2a46vV3XJLqUt6DGSD7AbO3rB/o3LNfyYDorBMTR2NlDyQWzNxmvdjHB6379jefxvglsgoGI7qubbYr1Q8ufJNV2XdIk117a+vDK+dD/LHzvOS/UZ+l2//5g09o03ZTGv9Y6bl7F1jCrO6+bAmBTlRRTkrOHUlq2Tcl8qBvQYI44mg39v8I6/A+D4QtzdLsl67lAvuqhEF+9dnCjjWrIWBAjgkzt0KxLIKnYD7nLyzef9+LGUAay64OWRJ2lQijl4+qOQkDAyL8dFrDHsydxFJdLUNUB1sb6+ZNuEjUye46sd8mevB+Wh/KCZuQltO2YC7kb3BOf+0WW8Sxw1QZEenoVQ3bzsg71s7M90ahupvIJFGFF9nz0HW/DFPbH7NFmGjzDJ5ZKncTKMHmwWU6Trdt/lhpf+XatCwfHzUhZoKEh9T9g4cLy7Ga6OAbW8Cqp0C3d2vF7k/Xw6OHGPT5QybGyPGdPUX8LCURJOXgX72/JTlt3F+CSqWncy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(33716001)(2906002)(6506007)(41300700001)(86362001)(1076003)(6486002)(478600001)(38100700002)(6512007)(26005)(9686003)(66476007)(66556008)(8936002)(4326008)(8676002)(186003)(5660300002)(316002)(6916009)(66946007)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5KVitJdHl4VHhvVDkzU1AwbzhjOWtHS0c1ZmREZ2hVUnJ4Y00zL2FNenFM?=
 =?utf-8?B?cW9Dc1JHenJMOHE3ODBRRzNrcEdUUEUzUEswM2U2RVNrRG9qMzU0OHlvOW9z?=
 =?utf-8?B?bGNnMVZSVHdWM2ttUkhlUWRjUTE0TXZjc2ZDN3pwNnhESkFPOWZyVFErTHl0?=
 =?utf-8?B?R1ltVHRuWlI1K0haNVZaS3N6S0N5R2FmcENBV1dyTTVkVFRwd01ObFVlN2dM?=
 =?utf-8?B?VjBvNUZJVFRocERnUUw5b1lGQWcxRzBQa1M3SFBlM0hVS1g0cDJHT0FVaUM1?=
 =?utf-8?B?ckVPRmxqbGJYaW1vL0Z0UU9jd0syUTUzZ25tRG1OZk5oWUhjeDNGa00zT0hi?=
 =?utf-8?B?akpwUVlka2VlWFNMTXdCRUtZMVdDeHduSkI5eThvKzI2Qjgzb3Q1RDQ0ZUxO?=
 =?utf-8?B?L3UxYlpQM2RiVDRURzVEc2ZWQm1kbWh4Zmt0a01HU25wcTY3bTRKU3hhNTJ6?=
 =?utf-8?B?NW9jRUxXOXRVMFdqTi83Vzk4VkZDemtwQ2RVR3pFN2x1bC82U0hjQTFFdjNI?=
 =?utf-8?B?cWg0dXNHU0hEMFk5bGVXQ0dCZ2NQUUJPV2t1S3N3L2FsQmpxRzdJZFVKMTRv?=
 =?utf-8?B?aVIzN092UHdqT3BObWMxYll1aG9WMGpqQUc1N2NLMWl4Q3JLdXIrSUx5bndF?=
 =?utf-8?B?czVXSTJzYmtXNjBiRDJUR1BVY3dHYWNkNisrQUV3QldMWXBvTlhDcTlZVTlv?=
 =?utf-8?B?a2VPak8wSnJVc1pNN3UrL0NmU0c5Z2cyZUVPMDNVMUY1TzJKNmljdjlwNnVh?=
 =?utf-8?B?R2dubXEvZkljQlpIOGFVZUhaZmc1eXpSNitJZTVTa0Y1a0laczNjNDE3eUVX?=
 =?utf-8?B?VmNYL2FJOGV0cHV6ektmTWpja01GSlVId0lmMk9XRWY4Q3hvWnE5UnhxRmFH?=
 =?utf-8?B?YTVEUEowQmVvellsbTF0dUdCdXBoMWxnRzJqMG5tMzhSRi9MWnRHYVJjNWtC?=
 =?utf-8?B?VDlMQjVpNjdDZVV3R2NyMVNmSURKMjNnSkdSbjE3VzhjMzJ2a0R0eGxVeGJX?=
 =?utf-8?B?d3RDZFlUM0F0VDAwc1Fsd2lmWmNIYXVyWDh6KytSTEx4SUpzNFlnQWRHK3Rl?=
 =?utf-8?B?aWF2TFBRSzhocHhPaHhwamVSbUVwMmsxTlo4clhLU1U1RHd6TmlDc3J2ZGdv?=
 =?utf-8?B?WlY4SDJ2NE9xOC9rZHdyY3dreVUvYVh2d0k5ZlRkM284RUpYelN0RzRuSFhx?=
 =?utf-8?B?d2RhampiZDdSSkRxNURJMWg4Ym5YVytiWXJ6L0tNMmtOU0c3M1ROOFJPUzJv?=
 =?utf-8?B?UzdaQXBYK25WYWM1a1dtaE9Jbk9xT1gyS2JrUjNkbmtkOEMvdDNxWnNqMTVF?=
 =?utf-8?B?VG9pYU9mbXR0Mnh3VGhpYzFsSnNOdVdUb2k1ME9CRXlxemV3S3dHWkprVTBp?=
 =?utf-8?B?RUFGVk53azdTbDJvMGU4TXZSbDA1YnlRS3djTkFEL0YwUUNjaHo2U2k3M2Ra?=
 =?utf-8?B?L1YxazMyUXpsTW1zRW1naU10UGpEcVpHTmc2ZkVQVXhCYklSSjN6SXVqcHFk?=
 =?utf-8?B?enQ4WjBidE9FdzVxd1pLY1hBZVBkTDBvSU40cXlSUWp6Yk5JL1Vvd2FXNlc3?=
 =?utf-8?B?MXVubGVNSUh5NGdzZVFpeWUzekl4QXBXN3puUWZpQkI0Rno5SlFkNmowMFEx?=
 =?utf-8?B?NzBaQ1VNTGFOSEpWNk5vdVA2eEVHWUFrdlNJcVk2V2hGYVYvYzZzNGtBNnJ0?=
 =?utf-8?B?SjlwQU9LUmY2aXJIT2g2QnhHSGM3QWNKUDlCRzZNa2NtaDM0N3RoUTBTRzRW?=
 =?utf-8?B?ZkkrcnR4ZStCR2xxRENFYzM3ZDhCbDVmVHpZS1I4S2lVUjVneWdFTDRNSll6?=
 =?utf-8?B?YXQyVzVuanl5VWthMUdJc0JnMkhCWDVnbEc0ZjJ2L2RUOW5UVFFJM3A5SnpH?=
 =?utf-8?B?L0VCeURXUHhrV2hJRHlzVjF1ZWwzSW1odUtWbndWd3JPcUE1dDJpYWg5K1hH?=
 =?utf-8?B?VGk0TXNLWitrVUFxY044WTRhaUYzZTczaERrZEdHb1dJcmZMa2c4cUlPbE5C?=
 =?utf-8?B?Q0pSTzh0cDZNajFJYUJKeUNOcWxPbU1rTFFubTFpMFNVdy9QbUcya3Z3ZVR4?=
 =?utf-8?B?dmlhRHFVVGt4TzY0d1diaUp2WXk3YnNDYWxtREN1UXhyZ3R4V3dRZlJsUFV6?=
 =?utf-8?B?VnJmM2ZkMnF2TUd4VWtYKzFRZCtDdHdkVEhYeUVOUjIwcGk0c2dtUzJzRWlN?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 497725ca-4c5a-4f12-b5d0-08da585c188c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 16:43:00.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9ZLQ2cRBOmqgnrGEnfPMXDcNRlok8Y9ccspfee7E0q5US02O3BbRUGVvyHB9jLoHMIiJLu9wohVxo1aP0l63s2bPfOBhceqFPROWMaGSFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2810
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

These 2 patches are now applied.

Lucas De Marchi

On Fri, Jun 03, 2022 at 01:49:01PM -0700, Lucas De Marchi wrote:
>Make sure return value in flush_stream_to() is the length written
>if the value didn't the size. Fix warning on gcc 12.1:
>
>	tools/depmod.c: In function ‘output_builtin_alias_bin’:
>	tools/depmod.c:2465:24: warning: array subscript 4096 is above array bounds of ‘char[4096]’ [-Warray-bounds]
>	 2465 |                 modname[len] = '\0';
>	      |                 ~~~~~~~^~~~~
>	tools/depmod.c:2460:22: note: while referencing ‘modname’
>	 2460 |                 char modname[PATH_MAX];
>	      |                      ^~~~~~~
>	tools/depmod.c:2477:22: warning: array subscript 4096 is above array bounds of ‘char[4096]’ [-Warray-bounds]
>	 2477 |                 value[len] = '\0';
>	      |                 ~~~~~^~~~~
>	tools/depmod.c:2461:22: note: while referencing ‘value’
>	 2461 |                 char value[PATH_MAX];
>	      |                      ^~~~~
>
>Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>---
> tools/depmod.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/depmod.c b/tools/depmod.c
>index 4117dd1..364b7d4 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -2430,6 +2430,7 @@ static int flush_stream_to(FILE *in, int endchar, char *dst, size_t dst_sz)
> 	if (i == dst_sz) {
> 		WRN("Could not flush stream: %d. Partial content: %.*s\n",
> 		    ENOSPC, (int) dst_sz, dst);
>+		i--;
> 	}
>
> 	return c == endchar ? i : 0;
>-- 
>2.36.1
>
