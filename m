Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43802C77B7C
	for <linux-modules@archiver.kernel.org>; Wed, 31 May 2023 05:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEaFjb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 31 May 2023 01:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaFja (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 31 May 2023 01:39:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3ED139
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685511554; x=1717047554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Eldj88cuydGf3jWoRDSxx+QplAIjS6v3SDpCg7c81tE=;
  b=bx7b8bAI4uJNKe+X8QpEnYU6MOeeMLXxSqrksAXbx4cNKbORmfHgwY9i
   QfM9RxrFomkOqcRhJtdn5A1I4TZO601/VlAKHY5RaSsIVEdGR1rr2CBsS
   MSTZuq8kIHgLvtPjXVFDtnPE5NjP8PEVAn3BK2e9/qXzueJWTOMU4qL3g
   1B253BxWH/AJWlQuXZ5VmxttL0DX1tS532/9tKsEngyGsao6zQ2OZPgbj
   7e96c7zwXC8I6dSz7Bahpn50t7qZ8QZyjFieL/sIx6FlIPAiruAmUpEQ0
   N9XGUdGJ0ZRI3FKpApgiVVH7SruuypUOxiXlr6JWjlwPCAjj8erPCqCnz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383402758"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383402758"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 22:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881038929"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881038929"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 22:39:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 22:39:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 22:39:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 22:39:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 22:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqvgV+y0JRxC6E4s4TNxkriUDSq3eU8sdCiy4S2hrwyQpd0k5t8T1uW/nP7OeS87YD3ALDLbCMmwjGwxTcJSf0YXatv6P+Co+Kj8onzMMOOmFAjLc9ttSvj8fHOkhMrBF5ldtrv+xT8k1OqL1TU5zetNXC8Aj8YeWP1XiL/GMnVvKAJMUaUiB8SIEIixi0J0rBZ4f4PDlNB9EI40rylYOUGPvGknxwOxFm92MOUZVQDhgpmi9l8+Ozxliu20ad+4BSyqrljE8K/wr49cmZuxhVcJZgv2hkEbT+s9jdXRNnqET0+RiVP8qr4Xmpf0TCjc1A+4J2qe1ATQJ5/1lXiNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6Pwpg4xlxlfvzrVLEaS09aaFmHBeFKQHkfMWpti8Sw=;
 b=AWsLizgTdXPtcEiwXhBnG8s89IGIizxZDdkt73RbKuKh+XhjrHQ5LqoCyjO6Srki44oe0cyFxdVj0/GCz1tskmh0fVAYBMmUolhq0ABfojn7hh1Stci2t36CIx/Bet80BXD1v9AQoFbCw2iMf0ppJjBmjv2eW2DFEzpK0XtneAG1KKvmtfcOXlWvvxtPdPvJzsv5zckCsQpmbdeXlfKxalHCVZE+jfXLW5n5pD8YT0ZNPYAYefAJlFlUf+em3bT6BG+zTGkQ94V1rDJo95iFJ7iSjcwJJbb8Hx7r/1EzlcO4ZcwMo5Wp/NvRZoZZ3j6zHHputvcE1h+6p5B6qEeZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SN7PR11MB6874.namprd11.prod.outlook.com (2603:10b6:806:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 05:39:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:39:10 +0000
Date:   Tue, 30 May 2023 22:39:06 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     <linux-modules@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] shared: avoid passing {NULL, 0} array to bsearch()
Message-ID: <arn75dwqro43j5cs7a5vmz2tzf2ijzjec5ghnarvtjckeaj4mm@apbrk6dvzdpo>
X-Patchwork-Hint: comment
References: <926001fd-34bb-83ee-be77-ccbded164615@csgroup.eu>
 <20230519074108.401180-1-dmantipov@yandex.ru>
 <ry5ekq7cvyugnvo2ykhuktmngqoq5zomtc2zvjwtevtd5s4ueo@7wwzksbprtzu>
 <3720aa5a-e6bc-9829-7d46-17ac65d69877@yandex.ru>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <3720aa5a-e6bc-9829-7d46-17ac65d69877@yandex.ru>
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SN7PR11MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: f37805af-7d78-4f8d-7453-08db61995bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HFMI/wABhebVfCs31juH4S4q6+SGfly3DB+gZ2WTR0GHufSxcaJ9HaS73KGg26B2SBN1LGmKGTeWbrZV5YWq1/ZT+f772DNL8Efgw7kz+2nfGBauBJoYq8tO1WOF6mcrJECDxuEaKDJis15TumV1I915XM9kq/N7I0qOyk5XJxhCtGQer4WG7BxmMBwYcVVm60hf44/XLMQ0VIEjFiSY7AYoMVekudJPsWerm8WQMR4gOhVa9N+KqNrsCVtjWr9DmcR6TpT/1q4HDCMA7AX5IyC08ioVjb8ItIlfNDVrY0t1ikCDXVvAxYirxABUsQiEH2a3rx9L1hnwzTc4VBZiQH96Z3S1hPWdfo3sX7QF+WdL4rkhYvsm0ehWz3DhKM549FoeizgjCUWt3CEC5aWeXfFcrkLAAFhINgMm/cHkJTGXG9fZjaI0xhcHBNtcGdz94tb73fqwkjR5l0oGoFS5NKVcxTi5x9p+o4Sr13LKHNf8tbJXQCWQpF5rsmpUUB5SfOL5DCz2GPgH/8O5W53Ri8bcMkmBRG+J/vS5mm82GIinYIMiOHpxGhLXfYp/vma
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(41300700001)(478600001)(82960400001)(38100700002)(6916009)(4326008)(66476007)(66556008)(66946007)(33716001)(86362001)(316002)(6666004)(6486002)(6506007)(6512007)(9686003)(26005)(2906002)(186003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvC+aIVLQmycpKqZlJn6B1k6Pysd4wASKwEIAh7vqzzKVOW+8eUP8JvfnTlY?=
 =?us-ascii?Q?fSySkvj7oIjbiz90vPu9UO3rt4AsQteAEQ8L+Ist60xP4CiZ4OC7H+2q4EC6?=
 =?us-ascii?Q?Qw1LOd+a8wJijvW/0azRsWDdxrUHJZxn5bcvmt79d0dqOvSYKPvuLNPLxcBe?=
 =?us-ascii?Q?Fb3i1qcnwiOEOmkn8hFNOoTOgpubtj5ivkfVUQl+iLuZdFVH1CdVmZvY7+2o?=
 =?us-ascii?Q?B6CfIH56DLM0T/6fJYKQ7GYI1VDSTnYoUWl2ujO4VO+IZ5Nbx68gH5f+vCZY?=
 =?us-ascii?Q?SL/wO7YsEbQoJyDmOmf1iaNHXOUiFUPGT1cAO+JilEm5qv/bgH9JVNf6Old5?=
 =?us-ascii?Q?wdg7i4pFEyuBUVTE5jHWTP5XwN95j0aTq2aD9qGFEPKG/J5hj5/9tQ/YhjZ4?=
 =?us-ascii?Q?DMwa0host/pXbS6hWg9eMQ9w4vJlfPAoxvSxKxIM08mloEf3R1dqry6TmRq5?=
 =?us-ascii?Q?jqSqgOah961D69Y/P8B7wms1BShHl1sW+VpUqQF3MVaiWSaHVETzs0wzluIF?=
 =?us-ascii?Q?zf3dKsLOwAAHz4ChPn/zDIgMmot00cQ6mpL+uUvaKlZDjYrZpvUP2AccKUXH?=
 =?us-ascii?Q?i41og2m6FM0PIW7RpH3JWkWDTur1gryBSbLuV44vVt+9hRxHRdSadYijMW6f?=
 =?us-ascii?Q?BOTogpUBen8UbI/QivcR3qOvn7Qkc8dSF9O4XZlWuXFpuRmM9DQgUWxNY3jb?=
 =?us-ascii?Q?nSZcRd4+0ZqC51EELbolVMderob9TQoXxf/HJh8UmIdBN9z+yubSQgIHEEcx?=
 =?us-ascii?Q?EPKG1M5WHBgfuacg4YuBc7VGGFGyzcYKE4fk7hSS4RYCs4yk+YIjwk/PcQY4?=
 =?us-ascii?Q?3K+dZJ2Kh82iEmjajKlTVVjT4QsFBDABzp8e9G7kmyzNl0+SnDptD6TjJiBr?=
 =?us-ascii?Q?kggOsMP7JVJYvGZfZ3xsL21Db+FBtO8SejoSJqen0awh/fwRjJJ+anGIoyc4?=
 =?us-ascii?Q?31gXs+ydwe+6cytZkaO8swGDPZlBTiPCZsgjbuvr5bu5C/Ew381IvhyQAdFd?=
 =?us-ascii?Q?yQVZo4PPkUj+UFD/IpvzzJN/AHQeEXejWlr92MjQxaQxugPork0gul6Eydr2?=
 =?us-ascii?Q?vrSnGy/D5Fi8P2uDvgQHn6olfimagfJHqPULBuhDW6NYdBv15ILqMDYc8CzW?=
 =?us-ascii?Q?JxyuHl+wL29yIPRNN7YjpnMoJ2fLXIFp4u4E9uP96gXGUeo2COsgMfCyBVSJ?=
 =?us-ascii?Q?Ot28gUfzzwd3JEv0bcDf34D4+uezdNSjmaCaEpIfXkQQh1WtrxF/K2gIkaSV?=
 =?us-ascii?Q?t0nL/qeePDDBlv/qWMsuI3rLf71Rr99cFUSJ4Q49eoW7uC2sXOGB9gH47jbS?=
 =?us-ascii?Q?hU6Nlc28SfMbPOU2tUMwk2sklEjElxARdk+V6yzym/v9zKwaEkthe9JBx+1f?=
 =?us-ascii?Q?bBN/KI62jnQFIYjkshIHsnXdmkk8kZLZW3S5VPPF1ORYtrO+obv5WmoTYcts?=
 =?us-ascii?Q?1hIbHW7TaTpGkVu/Mvc9DrQRA6KiVSrgYgaPPb7XgMXIqCmYFKl1CUep3NRQ?=
 =?us-ascii?Q?Q1O67ZHtVrzUM9oz9kytDz/ojicJeOyHDmWe4iJ8BXXyDKbY1tqgF5eHAzmp?=
 =?us-ascii?Q?9DWg6jKEwITQzHJNtxxHhGJSxZlbvZd8T2nNJ6kTSy8sBW7j9w3LfK8sEf8t?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f37805af-7d78-4f8d-7453-08db61995bbe
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:39:10.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxTqVynEWKCALHn3az8LTrbpq0wub9lGskFpKp1DXhd4XW6eKqn2kF8U0/DRDHrZwloiT/ymssjsbaZa82pUaeqvyXZ8jdc9ftG8BnBfVEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, May 31, 2023 at 08:01:37AM +0300, Dmitry Antipov wrote:
>On 5/30/23 23:21, Lucas De Marchi wrote:
>
>>I'd avoid the unbalanced brackets and replace the bucket->entries
>>check with a return-early style. Would you be ok with me squashing this
>>into your patch?
>
>Sure as you wish.
>
>>However I'm curious about this *runtime* error you went through. Does it
>>have a backtrace? There are other places we call bsearch() passing
>>bucket->entries, but that should be an imposibble runtime situation
>>since we bail out on context creation if we can't create the hash table.
>
>This one is from something running under 'make check' (note I've added sleep()
>calls to have a time frame to attach gdb, so actual line numbers are shifted):
>
>(gdb) bt
>#0  0x000000000040924a in hash_find (hash=0x1034400, key=0x7fff71657d50 "btusb") at shared/hash.c:246
>#1  0x0000000000405661 in kmod_pool_get_module (ctx=0x10342a0, key=0x7fff71657d50 "btusb")
>    at libkmod/libkmod.c:403
>#2  0x0000000000407cfe in kmod_module_new (ctx=0x10342a0, key=0x7fff71657d50 "btusb",
>    name=0x7fff71657d50 "btusb", namelen=5, alias=0x0, aliaslen=0, mod=0x7fff71658d88)
>    at libkmod/libkmod-module.c:270
>#3  0x0000000000407f3f in kmod_module_new_from_name (ctx=0x10342a0, name=0x7fff71658d90 "btusb",
>    mod=0x7fff71658d88) at libkmod/libkmod-module.c:341
>#4  0x000000000040824b in kmod_module_new_from_loaded (ctx=0x10342a0, list=0x7fff71659df8)
>    at libkmod/libkmod-module.c:1736
>#5  0x000000000040262a in loaded_1 (t=0x40c0b8 <sloaded_10>) at testsuite/test-loaded.c:41
>#6  0x0000000000402be9 in test_run_spawned (t=0x40c0b8 <sloaded_10>) at testsuite/testsuite.c:151
>#7  0x0000000000404d3e in test_run (t=0x40c0b8 <sloaded_10>) at testsuite/testsuite.c:1080
>#8  0x00000000004028ac in main (argc=3, argv=0x7fff7165a038) at testsuite/test-loaded.c:91

ok, that makes sense. I had missed that code path.

applied, thanks

Lucas De Marchi

>
>(gdb) bt full
>#0  0x000000000040924a in hash_find (hash=0x1034400, key=0x7fff71657d50 "btusb") at shared/hash.c:246
>        keylen = 5
>        hashval = 2921571348
>        pos = 20
>        bucket = 0x1034558
>        se = {key = 0x7fff71657d50 "btusb", value = 0x0}
>        entry = 0x0
>(More stack frames follow...)
>
>(gdb) p *((struct hash_bucket *)0x1034558)
>$1 = {entries = 0x0, used = 0, total = 0}
>
>That is, the bucket is non-NULL but empty, so bsearch() is called
>as bsearch([whatever], NULL, 0, [some more stuff]). On my system
>(Fedora 38 with glibc 2.37), bsearch() is declared as:
>
>extern void *bsearch (const void *__key, const void *__base,
>                      size_t __nmemb, size_t __size, __compar_fn_t __compar)
>     __nonnull ((1, 2, 5));
>
>So NULL '__base' causes the sanitizer to complain.
>
>Dmitry
