Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387FC54EBE
	for <linux-modules@archiver.kernel.org>; Thu, 12 Jan 2023 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjALVs5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 12 Jan 2023 16:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjALVri (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 12 Jan 2023 16:47:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F335918
        for <linux-modules@vger.kernel.org>; Thu, 12 Jan 2023 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673559630; x=1705095630;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5fU0OMwhTecf8CIXzUnRkDQsxgABBrKaV8lQH9pGh40=;
  b=OuqrokphDGrsjsy5yd+jeB39wiSEXx7SpYumKt8uZEQXcuNSvPlwFLPl
   HC+Mw2kVSwauRQRAID1H5nwZ6q7JqAoIYb84Wz1/MUNEGc8D+M9s+Fm6P
   taiOZrtP71B2ahMkpmcgn7zbgLMbUU1LUDWdbuZtlBlW+ZlweZCQdUj7F
   g8iUicy2yiEnyKnmnndwsW5LCmDO6j0I3dAaU5OpT8P+y9lFzJnJKujo9
   sLBHYbM+JuyhXfCd4eWrlflKL1Y2SMn7xt8A2FRz8fSOci5afwUoE7znU
   bmrFBYoR16ltPnetzAGGQX6EulAhtfqdlz3vykg6mFa/iosFSELpw1xQI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388330907"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="388330907"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 13:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="831854825"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="831854825"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2023 13:40:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 13:40:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 13:40:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 13:40:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 13:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4W4rd8xU4CC/4NMVVuHsZcnN7X7inNBjzg80uYxEEegskWP/S9rZItRU0at6GisZSB0NsWUcypXKnw8t5vs+2Il9Wvegha/HsLxHIZ8rS55Kep5naY8/WLqJgDvJf99bTiZQOlwG/DXFLqDbtxYOdwiBs/vmprFa45eBct43qGuJNmg6Z2eFollZAd2VPx5lYgmR4I8S0/xJz5pUHucu2k+gpC24lBkN2PyHltGAidJ0aiKr7qvqloVTAbhO1LFB4XpqfJdjqRnSOCfajDhagUoD41ooX2Sr51T+4kzxTgkGb+Aww96bId213TtGgHqynZcvPhqV8qK+ipdcuqTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWPew8g1N/CpdtNcLD6fbR9c1XBq60wYV/vjHc5/Oww=;
 b=PzlTvjACynAv+k1vgwfiEjLfrH46zeHOlLRUrAU8ueGt8r0Qty566/eE4wpAVp6b0xRMejPN6Kero6TlzwMd+QJYfSz+tDMXNm0JsoJJ3X4yepPByYGIl/bKQFDrY3Fgelmagj7CIYmgZGPUqAeVRAERtujTcCY/ZORlCOymMGJ/BfR9sogfYFyxfm5TYNDvtfkpnJfsH2VV/qvAlSCUF83RTXoZdPq8UgPJNHiC2cKxQmCg0pJYUkSN3OkImCwaSNUANuzCu4VOc69SazmVp6rI9QNs2ozapDq8czLaOwzvas9woezDvqHwnKEfW/ScY9dJD23jblB0M5qVGZaGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 21:40:20 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 21:40:20 +0000
Date:   Thu, 12 Jan 2023 14:40:15 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Gustavo Sousa <gustavo.sousa@intel.com>
CC:     <linux-modules@vger.kernel.org>,
        Gustavo Sverzut Barbieri <barbieri@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH 2/2] modprobe: Allow passing path to module
Message-ID: <20230112214015.pijuvoknq4c4gtsl@ldmartin-desk2>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
 <20230111152936.101040-3-gustavo.sousa@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230111152936.101040-3-gustavo.sousa@intel.com>
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY5PR11MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbcf2ee-0fc6-4c61-df75-08daf4e59a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsC0u1Z1IRp/xA10HImWNrXxyM3HHr3QRQqetDbo6jotQ+bld/X11HmiIVzDQCJ0ItgC2CA6dcqIFb931R7Uill4ZSpUBdLd3oiGrN+boSPRaWyLZbqcsLSVtc1vYv8Np5uZhz++itmduresuCQTovB0IXeanYo3ckvb6aPFNHv+HJGI1OFwmT/Cjb3qfGxH8d9DDTqt95ZJt+avXdPmOiz+U5QDGauO+ORXc4V+q7LVKpXcwkraTFccD+CYxWW95IJ5pSW3z7ZOjrZkY4O0QrMMR/nsH1xLu8RrncI049nhjpsA0uOdDNPPfmLl52oIo+MN42+wDs8R0eRQLK7UUayO5bY2QpC9Mi5v4dQ1qsMF1Cyps9xRAQuXES8D1miUaF2L2XDgQJZt6IL9D5Fr2/BGRFBAdAMs9Q+dRcLvjwBI2kaPfwiT9f6vMVG8Y5dzAJAJqr2Ny5uPNhRQpiQZ+WnfKyJR3A0+6aNt7NQx0lXz2mm/ozsAi+EvLvK9cR0bZBQIz+BlRCQiFfEVYTMTczZUD4+RnhzYe9dDk5R6bPwest6/M90RRNfVGwp8YQBS7c0Tdr+CaZ/fxC94vuN1d2MZh0SguJ1QHxRal9ycRzlS5BFnw+uDiHSq15DGHgyIz31dCp/hhoZX8bLWy3qHhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(8676002)(82960400001)(66946007)(66556008)(38100700002)(66476007)(4326008)(186003)(86362001)(6512007)(26005)(9686003)(1076003)(33716001)(316002)(6636002)(6486002)(54906003)(478600001)(5660300002)(2906002)(6666004)(6862004)(41300700001)(30864003)(6506007)(8936002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0H3Okc3UDktDDLcOZqHjwd6/+7Alo/+MilCZdTRAcqkPFpfSIfzU0k4+ozS?=
 =?us-ascii?Q?+jDzrvfcQ2ZBy06w6PcE5tqQw8PJeV5YKftNx2AXVCvjz/WML3v2i7MuygJt?=
 =?us-ascii?Q?9Kky7bRiaGce7129BHRF0bEFWO4WBRQi2qs6f9WDkJN0XdJS420DBOiqLyJn?=
 =?us-ascii?Q?zbKCTSOA6GG3kQIvsw/4PRWhE9FNUdjxKwt5aVkFB4ZDaZf0kGIrou3Wd797?=
 =?us-ascii?Q?uEaiXJ8DOMRjazn3qKaYsnDLz35mSDElyGTvfzau0u82PlKU3RDa0Jp/hRkZ?=
 =?us-ascii?Q?i42QwcRUQNnz7kTeizx8QlwgLTDG/j9YrBlVQFJi6ROwbYeuZUnmyxYpiuRW?=
 =?us-ascii?Q?xGY2mnmlJIfXmWp3vZpj6zNltOs/wg+XXsyMN4D3VsEJK/A0BVa2DyGgc25L?=
 =?us-ascii?Q?oPHIBG2QcV2Hma6wemZ8rUx+0K03UpqgqIYRlzExxgH1L4MHmpYzW9H0EK1j?=
 =?us-ascii?Q?YdyBeYda+jCaF26S5rH+B6AWodVl6aUKmQfWuD3v+0K/wTWYgzpE1sgjQuEs?=
 =?us-ascii?Q?ULMENo78AuPxLAcOb6CVswySstklHi4RSxWw1jnnE6Pc1ZiiO4/3rGWJ1l5R?=
 =?us-ascii?Q?p07KMXNPZ/y1T/QY6+4EGaKyllNNHW0UmjuAEzxb+X5ay5uCM3uB6WT4X36V?=
 =?us-ascii?Q?VWlSYenPacciYI2OJO3fW6TG1J0Su16TFiH4prbC82QIrcASWMfFgQ2I4kNM?=
 =?us-ascii?Q?B3ouBvXz8LzRxxFjC/CXArpAcoqc/3V2sr06lPfo7i34VhEExvhXoJNiTqyx?=
 =?us-ascii?Q?UgyU/FrwTjUvKS3PqiRIkzClufNvRt7DVg50VBQLmx1pjokuOt2Z9NPzPKE6?=
 =?us-ascii?Q?PCP/Y6r72KY2JHw4VM62WvUtCyhArMZP8RODpmJK8J3uAqVdFIflGg3mNf4k?=
 =?us-ascii?Q?xrR+ksLrEnakd9Yfnr++ZBvM5NxRDdiFsT1srCBn6kIFxFB69ozza1lOdDSJ?=
 =?us-ascii?Q?dq2VtRa9NIhfVcPLnCK/cEZTZmSjD0Dq9ZEifmo2Cqvv9dgCPC5P5BFAwTJ1?=
 =?us-ascii?Q?XDUF5djo4AZJ1GGu7sBR2NLxYoAISeQAuVpMP671DaZStBqjJNUgJr8zquw7?=
 =?us-ascii?Q?ymMLFY674aPi964yk7jHoZxYel/FwuAvHYbh2zSqRvHChL1owyRmKbtgPlfC?=
 =?us-ascii?Q?Sibo+KjGrHFk3h5h4PJV7oPTL8IKdfZROA8EG475yGYTuQjHaXvEk7Z4ArpM?=
 =?us-ascii?Q?gZid31cXrAxXwANLkfjqDfyYh1esSYnzhZRE82+xhSnCC2WWZMKRPGVrFE4I?=
 =?us-ascii?Q?lWVvf88aUIPXUJj+M6tEG481f7mwzovBCl6V9gSV+lpwGdesIszkc5kypQ6c?=
 =?us-ascii?Q?jdhtg+3r5jgpU/NZqJEsDtxePITfdbpd9KXqT+kHG1aPdqcGLPrVIv5Su+6V?=
 =?us-ascii?Q?VhCSmzQIWFVSStvhR4gPQSqSf7D3ImR3cTrPRiTj1WcyjQPZu1rysf54DO7r?=
 =?us-ascii?Q?yjpmPNdcslGPF8RvKfJxxbK2G9Np1Ow/wYwHpM1QjA/iwv+w30kPSKJr34lD?=
 =?us-ascii?Q?uIx5D6XgwB7fwZ/mQKpSyS6StWQQPmcUo76uuJs3Oziy18qhZXTg/M5WvlJv?=
 =?us-ascii?Q?8vocCGuuxXff0ue24eG4QQZIvBX4vhsGDD2WFjtvWSPqXNIwWhZUIeVA4Dxy?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbcf2ee-0fc6-4c61-df75-08daf4e59a66
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 21:40:20.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjcdfZAcBrHJmIqNGLeezQ19Rs3LCfmByqlHBXuLvoap+g3Zdm6IVlNOogfJUhLF1pm+dGmXMXpSub5B6XQF7ZFS7Ut8P/IU2+zzUnlPkec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 11, 2023 at 12:29:36PM -0300, Gustavo Sousa wrote:
>This is useful to kernel module developers for testing a just compiled
>module: instead of using insmod, they can load the module from the path
>while getting all the benefits of modprobe (e.g. module dependency
>resolution).
>
>Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
>---
> man/modprobe.xml                              |   5 +++
> testsuite/populate-modules.sh                 |   1 +
> .../lib/modules/4.4.4/modules.alias           |   1 +
> .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
> .../lib/modules/4.4.4/modules.builtin.bin     |   0
> .../lib/modules/4.4.4/modules.dep             |   1 +
> .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 73 bytes
> .../lib/modules/4.4.4/modules.devname         |   0
> .../lib/modules/4.4.4/modules.softdep         |   1 +
> .../lib/modules/4.4.4/modules.symbols         |   1 +
> .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 12 bytes
> .../module-from-path/proc/modules             |   0
> testsuite/test-modprobe.c                     |  22 ++++++++++++
> tools/modprobe.c                              |  34 ++++++++++++------
> 14 files changed, 56 insertions(+), 10 deletions(-)
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
> create mode 100644 testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules
>
>diff --git a/man/modprobe.xml b/man/modprobe.xml
>index db39c7a18bb7..615466977f6a 100644
>--- a/man/modprobe.xml
>+++ b/man/modprobe.xml
>@@ -115,6 +115,11 @@
>       kernel (in addition to any options listed in the configuration
>       file).
>     </para>
>+    <para>
>+      When loading modules, <replaceable>modulename</replaceable> can also
>+      be a path to the module. If the path is relative, it must
>+      explicitly start with "./".

we may extend this to mention that loading from a random location may fail
when the depmod database is not updated.  The depmod database is usually
updated with kernel (or module) installation - the dependencies there may not be
up-to-date if a random path is used.


>+    </para>
>   </refsect1>
>
>   <refsect1><title>OPTIONS</title>
>diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
>index 099f02669156..652279eda728 100755
>--- a/testsuite/populate-modules.sh
>+++ b/testsuite/populate-modules.sh
>@@ -56,6 +56,7 @@ map=(
>     ["test-modprobe/alias-to-none/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
>     ["test-modprobe/module-param-kcmdline/lib/modules/4.4.4/kernel/"]="mod-simple.ko"
>     ["test-modprobe/external/lib/modules/external/"]="mod-simple.ko"
>+    ["test-modprobe/module-from-path/home/foo/"]="mod-simple.ko"
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
>new file mode 100644
>index 000000000000..ba76e1815af0
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias
>@@ -0,0 +1 @@
>+# Aliases extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.alias.bin
>new file mode 100644
>index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
>GIT binary patch
>literal 12
>TcmdnM{w17&iGh)Ufq@4A6;A>Z
>
>literal 0
>HcmV?d00001
>
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.builtin.bin
>new file mode 100644
>index 000000000000..e69de29bb2d1
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
>new file mode 100644
>index 000000000000..e612900c5de7
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep
>@@ -0,0 +1 @@
>+/lib/modules/external/mod-simple.ko:
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.dep.bin
>new file mode 100644
>index 0000000000000000000000000000000000000000..556e3c8142d5d85dba5b557474907f9f9dd99dcb
>GIT binary patch
>literal 73
>zcmdnM{w17&iGfjpfx$UHCB8T_w;(5#0SFjDgnmwDl74P}N@-4Nv3_brNorAEVh%_^
>S7ot!vJKu^SH}?Po0}lY-ZWUAj
>
>literal 0
>HcmV?d00001
>
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.devname
>new file mode 100644
>index 000000000000..e69de29bb2d1
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
>new file mode 100644
>index 000000000000..5554ccca7f9e
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.softdep
>@@ -0,0 +1 @@
>+# Soft dependencies extracted from modules themselves.
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
>new file mode 100644
>index 000000000000..618c345f7e93
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols
>@@ -0,0 +1 @@
>+# Aliases for symbols, used by symbol_request().
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/module-from-path/lib/modules/4.4.4/modules.symbols.bin
>new file mode 100644
>index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
>GIT binary patch
>literal 12
>TcmdnM{w17&iGh)Ufq@4A6;A>Z
>
>literal 0
>HcmV?d00001
>
>diff --git a/testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules b/testsuite/rootfs-pristine/test-modprobe/module-from-path/proc/modules
>new file mode 100644
>index 000000000000..e69de29bb2d1
>diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
>index 0255f1aaccb5..3f8a430c09e4 100644
>--- a/testsuite/test-modprobe.c
>+++ b/testsuite/test-modprobe.c
>@@ -422,4 +422,26 @@ DEFINE_TEST(modprobe_external,
> 	.modules_loaded = "mod-simple",
> 	);
>
>+static noreturn int modprobe_module_from_path(const struct test *t)
>+{
>+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
>+	const char *const args[] = {
>+		progname,
>+		"/home/foo/mod-simple.ko",
>+		NULL,
>+	};
>+
>+	test_spawn_prog(progname, args);
>+	exit(EXIT_FAILURE);
>+}

missing a test for relative path?

>+DEFINE_TEST(modprobe_module_from_path,
>+	.description = "check modprobe able to load module given as a direct path",
>+	.config = {
>+		[TC_UNAME_R] = "4.4.4",
>+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-from-path",
>+		[TC_INIT_MODULE_RETCODES] = "",
>+	},
>+	.modules_loaded = "mod-simple",
>+	);
>+
> TESTSUITE_MAIN();
>diff --git a/tools/modprobe.c b/tools/modprobe.c
>index d4012fab39f8..3b7897c1b8e4 100644
>--- a/tools/modprobe.c
>+++ b/tools/modprobe.c
>@@ -614,14 +614,23 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
> 						const char *extra_options)
> {
> 	struct kmod_list *l, *list = NULL;
>+	struct kmod_module *mod = NULL;
> 	int err, flags = 0;
>
>-	err = kmod_module_new_from_lookup(ctx, alias, &list);
>-
>-	if (list == NULL || err < 0) {
>-		LOG("Module %s not found in directory %s\n", alias,
>-			ctx ? kmod_get_dirname(ctx) : "(missing)");
>-		return -ENOENT;
>+	if (strncmp(alias, "/", 1) == 0 || strncmp(alias, "./", 2) == 0) {

an alias may start with / or ./, so in theory there could be
regressions. At least in the kernel we have none:

$ cat /lib/modules/$(uname -r)/modules.alias | grep /
alias devname:net/tun tun
alias dmi:bvnIBM:*:pnIBM3850M2/x3950M2-* ibmaem
alias devname:mapper/control dm_mod
alias dmi:*:svnMICRO-STARINTERNATIONAL*:pnU90/U100:* msi_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*300V3Z/300V4Z/300V5Z*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*730U3E/740U3E*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*NC210/NC110*:rn*NC210/NC110*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*NF110/NF210/NF310*:rn*NF110/NF210/NF310*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*N150/N210/N220*:rn*N150/N210/N220*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*N145P/N250P/N260P*:rn*N145P/N250P/N260P*: samsung_laptop
alias dmi*:svn*SAMSUNGELECTRONICSCO.,LTD.*:pn*R40/R41*:rn*R40/R41*: samsung_laptop
alias devname:vfio/vfio vfio
alias devname:snd/timer snd_timer
alias devname:snd/seq snd_seq

But it could come from user configuration in /etc. Realistically
speaking I've never seen a "user alias" with /, so I guess we can keep
it like this. If we see regressions, we may try to use a fallback
approach to kmod_module_new_from_lookup() if kmod_module_new_from_path()
fails with ENOENT.

>+		err = kmod_module_new_from_path(ctx, alias, &mod);
>+		if (err < 0) {
>+			LOG("Failed to get module from path %s: %s\n", alias,
>+				strerror(-err));
>+			return -ENOENT;
>+		}
>+	} else {
>+		err = kmod_module_new_from_lookup(ctx, alias, &list);
>+		if (list == NULL || err < 0) {
>+			LOG("Module %s not found in directory %s\n", alias,
>+				ctx ? kmod_get_dirname(ctx) : "(missing)");
>+			return -ENOENT;
>+		}
> 	}
>
> 	if (strip_modversion || force)
>@@ -642,13 +651,18 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
> 	if (first_time)
> 		flags |= KMOD_PROBE_FAIL_ON_LOADED;
>
>-	kmod_list_foreach(l, list) {
>-		struct kmod_module *mod = kmod_module_get_module(l);
>+	/* If module is loaded from path */
>+	if (mod != NULL) {
> 		err = insmod_insert(mod, flags, extra_options);
> 		kmod_module_unref(mod);
>+	} else {
>+		kmod_list_foreach(l, list) {
>+			mod = kmod_module_get_module(l);
>+			err = insmod_insert(mod, flags, extra_options);
>+			kmod_module_unref(mod);
>+		}
>+		kmod_module_unref_list(list);
> 	}
>-
>-	kmod_module_unref_list(list);

feel free to add a Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
with the changes mentioned above.

thanks
Lucas De Marchi

> 	return err;
> }
>
>-- 
>2.39.0
>
