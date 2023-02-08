Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E556C636D3
	for <linux-modules@archiver.kernel.org>; Wed,  8 Feb 2023 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBHSTD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHSTC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Feb 2023 13:19:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF2113C7
        for <linux-modules@vger.kernel.org>; Wed,  8 Feb 2023 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675880341; x=1707416341;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XQzRgakXv9aNixuSbUE4issMagF1z135F8wHnMy8zSA=;
  b=Sxd80QrtXtYULZvxgNN5sbWRz/s9MeOPW4TD0Dy3rmRQIYxSzwG0MDvt
   UKqdhgwcoCLcp3qoSYOtfZvIvmhY+4xNGptYQfx48e8Y2wDQZibhfnxyO
   E5JYFLJ6up/+RCYr2Q5m1nCIy6L18maUBTc9CSV63Bsx0hqUJIUHVRNWB
   07m58KXHaqj+IsbnG9xnbx7tpGbh2AlaHvuxTSRv3IPkWEDs+E/VoEqzN
   eMMruvmSt8IRxiEVKv+SkoAmlXsSSmReTNZwFKbEnOdl2UmLWWWuM9TLS
   bn/eOq8ftbkhYsv3p0t9YpA8Yjy2gvhsWQehgNtP4ow0xVutaXm3eSa19
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317887808"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317887808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 10:19:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="996232699"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="996232699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2023 10:19:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 10:18:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 10:18:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 10:18:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 10:18:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAZnwn9ObjFjkJw8tCKn6qNt9IpllGGIJrP/ZaTGPLG+0yphi2Q3A2fitsjtqTFne7BnPGC0VXKWqzVLdJ9A1n3xYnq80amZV+Ub8ohxqbEtWbm6rIcBzAkuncHGpe/TmO0eSqdtiXAUotNsPEXE40pwnNSpKui5otxaJ/OHYEvIs7LUgHyp+iSOnKz+LEbIIrWALuJb9wIEOAyc0ZQKEGis2JRelNirNlI7jRgyA+1kaPI5xs3R/SOKC8Nx0/gq5uSEdj9fyQ65GLjuUumfu60kDZ26Olk6Nr4tKr8v0X2mGjGf/Z0WucvNOaij6/y0VBbgAztenOc7HRI+LpKetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaJWyexuCH6gtd7K+ZmIe8EOPMzVFZ1P1q2QQGb2JpQ=;
 b=Ne9JBVyGuzyhWBeItxdsuJlW3Ag0QtsRPZkfqQmDVX/O3y8rdvByGP/uHF+vfTPqI1LCOZ5Wb9D7lC4gKTHsayzzceR62WaPHQqU2uvbdBHvGg2wyq8oFzgUSNeCsECB4cog5XcZoFjMb5WRTKj/WFD19fbkwF4IoxrXQ+vTPZfuDLb5//N7gNkhW6C3STlAS3rJp1P0wLPI7G9ZGDT3UVrS/ONJYTo8NHZjBq1j3lK22wR+Ek8/YwMCmL2no1TqK5g5AM8BimBORHQE6n562B1Au3aktzDFJxBwPU5cS0Kch2X68Od+jcs/QPS6FHpFDbpJUkkZMNKv/8yKTC14gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:388::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 18:18:57 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 18:18:57 +0000
Date:   Wed, 8 Feb 2023 10:18:54 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] depmod: Introduce outdir option
Message-ID: <20230208181854.djyo2oncelbnlakh@ldmartin-desk2.lan>
References: <20230206131834.559229-1-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230206131834.559229-1-emil.l.velikov@gmail.com>
X-ClientProxiedBy: MW4PR04CA0383.namprd04.prod.outlook.com
 (2603:10b6:303:81::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 848439f4-b3ee-48cd-272d-08db0a00f145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmSIlUxxBqpQhm0ddUSYt+RI5pHnllXWBn09r/Ji1qRN99NUd+dvqbR6i98sNbHCY48kXt9OIFLVUYeEHns0a6xAjbGKliKSRGmlcpCdYMG8VzPYEaT92dq6lZDsrVWoPz22dn6PNdEztW3u1AOkBtGwvrfTCGwBO1y9M2CfZoTW+jSdDbO2mKSPDrAQwiBsGlzmhcRWGof66t82b83eIBnD5K1hPRmROH9oqykR8GIyk88X4aAgu90XX3+awCyozU4RWEUh2zGt44r8duewfV1mmkQjRjhgtxGABI9neCTkc8I5gFr6ipq9c1RU4BIiXXIgxkh0dv4550vdBhyQAGQ9gb07CZfCzAq6zPPkMAPhqrYV9M0i7SpFU7Z/cg3eJ6z2kaON/QytXZqNpOO+0NSJntUdYAC5JaQz9pdVz+UjZBQz4oNlOtlXhc6QPAsUofhd0t13TU5n7smvbkLmlPzSl/byu3tK0eDamwwrG/yBMeW6TafzdPcgLK+MG5zA4VJyActVoY3U6CvmxtdFJuOE6rbwqRAJT3nFwXoZAfuO7PG1raZymuG29rB6R9NHhiGlDp6Kdhl5FE+OAdgueu67RMR3ZHrSt+RNdbE8/MEH2N6sQbPGS74Xp63nId3R4ql24V0FnC3lYcoBjqEvBurdKAd6Le0B/anllk7YZQsCHHor2fUSrDZYJO3B5JTw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(26005)(6512007)(9686003)(6506007)(1076003)(186003)(2906002)(30864003)(82960400001)(6666004)(36756003)(478600001)(6486002)(41300700001)(8936002)(5660300002)(8676002)(66946007)(66476007)(6916009)(4326008)(83380400001)(66556008)(86362001)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RgBs8/r9D+GIF6rT+9Y/JWaVa+3k4Kcc9UD6z8kcV632GbrxxhcHOdZ6bFHv?=
 =?us-ascii?Q?xrbOQKABXhHAW+lpD5Ara9ZYaKWepuod8kLp5suqTPuvl5uidsbZjKJ/pwNT?=
 =?us-ascii?Q?F+dN0UzA/Txxe9+ZKl+allE9Os+6I2NgmBY5H4UUbM3MjxIa04XJaae3kUfJ?=
 =?us-ascii?Q?iZwd9e6dY2eXmvihO1+0B8J09w85fIap/1vLdYF+Pi+ZuTwvblUjcKu6uIDf?=
 =?us-ascii?Q?obNT0jqdPRKWWxYejW2qQEZghIvzls7Y2zRbhkdlMnZte48shePl+NLmbg2n?=
 =?us-ascii?Q?uBKej2SU1/C1p3sbCa7mytExmUyYaVSejAS5yOAuAtjstWwgw5Kzg+T9rrel?=
 =?us-ascii?Q?2Cz4kSfOOyYwZoj7Z242o/xD4igi4ptdI1kv0PmW87SqwXHwQy5OP/ohq0Lo?=
 =?us-ascii?Q?8QxfbYASy2Y0CZHJQbebIXg4p6Ge435ZrFFAWDPPpJT6jQ318vP9VP9pfnro?=
 =?us-ascii?Q?6YxqjYdKaUy5PiJNl3k0C8P7GLnhFPtQsa0Ub6Hg81645CtIkOkygQm5ZrC1?=
 =?us-ascii?Q?BGQ/IVrnek0746GFsIheUb9ceJGqu2t/adEYEAQ/6TbTArGrhsiiP3HWbICs?=
 =?us-ascii?Q?tzXs+B8Fi8n6WwtpM9g0hPAWhAg8gGovaOK32zOV8RlhvgZUpYKbZRm0F/f1?=
 =?us-ascii?Q?sVIBYOhWfGyU+WR42M5kpjmvdkD+TV+frViAKCFvSUhWdTI6Ie87R7ZVbIE8?=
 =?us-ascii?Q?27FzPQ29/tvbAWjPiSyyVE1qhBaN9166dDB8Dvpukc79e24V0NvCinBffgxn?=
 =?us-ascii?Q?fuDrV6bR0Emyj5JU1GiqPf6N13Iu/C1OBZmPogpHrBaZiZUDvgefyrti9YYd?=
 =?us-ascii?Q?C52Eb7l3UVmcZ2DJ8iXGgS+Vo70I8GiPkQbfUd6JIt3E54Jm9imOvQWSiWU+?=
 =?us-ascii?Q?zyv2Bo1ilHSQhqWt6QLzqnIUiOKI8W1NcR1HotsEs8d9r8DWiGduA611Hz3T?=
 =?us-ascii?Q?chjzNatOH0M4XANVs58ZloGpCSvVMYo6Oksp1ipHaD6GktkvnMzsHLKWOKrz?=
 =?us-ascii?Q?ELKu5TKL0cneg7v7ll8MIayDgFnejhb7fE+W0R+X7IwysVcmRBJ99EpBAfOp?=
 =?us-ascii?Q?C1T2BMBayRQAv19tbuedelaDr7U35F7Kot6waDPQlShoyqdo8V5JvNO1PQEc?=
 =?us-ascii?Q?jkgcuw1LA7ets9vJMGFq7Hb60/iP/iIofqIFYH3oqPSHObqLc72NJnoaUHuF?=
 =?us-ascii?Q?RUtrlWCSKQVp7XtHKi5ds1YfHlvCZPri0NcpXXew6vBHFWq+bq/ArNFGrNNN?=
 =?us-ascii?Q?Mhk68KIM+mhIWksMQnrhcCgJJVsVXZIeVFK8bDI5fubjJRpHsARIcC33OLCj?=
 =?us-ascii?Q?usXbvmDWpucNX/L3EygG3sUJ9idbUY1bynEVXjVbFKB/fAYqpsGTwhTSHSz8?=
 =?us-ascii?Q?JfMIKhUL8jQb2HsU9ugo5zmJPJp/G0CYjKScGm2BPfWtEoT1OYMQN/nimLPy?=
 =?us-ascii?Q?A2bsJeKWsXfIldifF8XXmewvDh8YiqlJF7YJ4NtQrx/J2y9kiVh9WqUHii24?=
 =?us-ascii?Q?hWkzctCcHdwCsWLD60b4EQ5ByL3bn3zs2QzQG135KG/lIVTsJt0q6qH9yl3Z?=
 =?us-ascii?Q?HkmfZj0wvIRIUXAqzUYNdcAO3WFGJy2tJ40MfwdCz4b5ShtFQc5nJJpdVwnJ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848439f4-b3ee-48cd-272d-08db0a00f145
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 18:18:56.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8Ww9jlF8ex/T4g9aG2Z4i/6kV3hvcbnmEBN4kbAF3tb49pfBB45hhRmj6bOMG1GncVDCOCdDUqQ65t7WTMl/xoz5Z13CFXPLWRBY9A3f+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 06, 2023 at 01:18:34PM +0000, Emil Velikov wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>This option is equivalent to basedir, with the small difference being
>that's where the meta-data files are generated. In other words, this
>allows us to have read-only input modules and modules.dep, while still
>being able to generate the meta-data files.
>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>---
>Here's a handy feature behind the request at
>https://github.com/kmod-project/kmod/issues/13
>
>v2:
> - alternative wording for manpage and help screen (thanks Lucas)
> - add test case
>
>NOTE: skipping the test (as well as some surrounding ones) seems
>dubious, but it's added for consistency. Will send another series with
>papercuts shortly, to drop that... if applicable that is :-)
>---
> man/depmod.xml                                | 20 ++++++++++
> testsuite/populate-modules.sh                 |  3 ++
> .../lib/modules/4.4.4/modules.alias           | 37 +++++++++++++++++++
> .../lib/modules/4.4.4/modules.builtin         |  0
> .../lib/modules/4.4.4/modules.order           |  7 ++++
> testsuite/test-depmod.c                       | 34 +++++++++++++++++
> tools/depmod.c                                | 25 +++++++++++--
> 7 files changed, 123 insertions(+), 3 deletions(-)
> create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
> create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
> create mode 100644 testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
>
>diff --git a/man/depmod.xml b/man/depmod.xml
>index ea0be27..3b00971 100644
>--- a/man/depmod.xml
>+++ b/man/depmod.xml
>@@ -45,6 +45,7 @@
>     <cmdsynopsis>
>       <command>depmod</command>
>       <arg><option>-b <replaceable>basedir</replaceable></option></arg>
>+      <arg><option>-o <replaceable>outdir</replaceable></option></arg>
>       <arg><option>-e</option></arg>
>       <arg><option>-E <replaceable>Module.symvers</replaceable></option></arg>
>       <arg><option>-F <replaceable>System.map</replaceable></option></arg>
>@@ -151,6 +152,25 @@
>           </para>
>         </listitem>
>       </varlistentry>
>+      <varlistentry>
>+        <term>
>+          <option>-o <replaceable>outdir</replaceable></option>
>+        </term>
>+        <term>
>+          <option>--outdir <replaceable>outdir</replaceable></option>
>+        </term>
>+        <listitem>
>+          <para>
>+            Set the output directory where depmod will store any generated file.
>+            <replaceable>outdir</replaceable> serves as a root to that location,
>+            similar to how <replaceable>basedir</replaceable> is used. Also this
>+            setting takes precedence and if used together with
>+            <replaceable>basedir</replaceable> it will result in the input being
>+            that directory, but the output being the one set by
>+            <replaceable>outdir</replaceable>.
>+          </para>
>+        </listitem>
>+      </varlistentry>
>       <varlistentry>
>         <term>
>           <option>-C</option>
>diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
>index aa6d5c2..5009cac 100755
>--- a/testsuite/populate-modules.sh
>+++ b/testsuite/populate-modules.sh
>@@ -61,6 +61,9 @@ map=(
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
>     ["test-depmod/modules-order-compressed/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
>+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/block/cciss.ko"]="mod-fake-cciss.ko"
>+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/hpsa.ko"]="mod-fake-hpsa.ko"
>+    ["test-depmod/modules-outdir/lib/modules/4.4.4/kernel/drivers/scsi/scsi_mod.ko"]="mod-fake-scsi-mod.ko"
>     ["test-modinfo/mod-simple-i386.ko"]="mod-simple-i386.ko"
>     ["test-modinfo/mod-simple-x86_64.ko"]="mod-simple-x86_64.ko"
>     ["test-modinfo/mod-simple-sparc64.ko"]="mod-simple-sparc64.ko"
>diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
>new file mode 100644
>index 0000000..5675329
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
>@@ -0,0 +1,37 @@
>+# Aliases extracted from modules themselves.
>+alias pci:v0000103Cd00003230sv0000103Csd0000323Dbc*sc*i* cciss
>+alias pci:v0000103Cd00003230sv0000103Csd00003237bc*sc*i* cciss
>+alias pci:v0000103Cd00003238sv0000103Csd00003215bc*sc*i* cciss
>+alias pci:v0000103Cd00003238sv0000103Csd00003214bc*sc*i* cciss
>+alias pci:v0000103Cd00003238sv0000103Csd00003213bc*sc*i* cciss
>+alias pci:v0000103Cd00003238sv0000103Csd00003212bc*sc*i* cciss
>+alias pci:v0000103Cd00003238sv0000103Csd00003211bc*sc*i* cciss
>+alias pci:v0000103Cd00003230sv0000103Csd00003235bc*sc*i* cciss
>+alias pci:v0000103Cd00003230sv0000103Csd00003234bc*sc*i* cciss
>+alias pci:v0000103Cd00003230sv0000103Csd00003223bc*sc*i* cciss
>+alias pci:v0000103Cd00003220sv0000103Csd00003225bc*sc*i* cciss
>+alias pci:v00000E11d00000046sv00000E11sd0000409Dbc*sc*i* cciss
>+alias pci:v00000E11d00000046sv00000E11sd0000409Cbc*sc*i* cciss
>+alias pci:v00000E11d00000046sv00000E11sd0000409Bbc*sc*i* cciss
>+alias pci:v00000E11d00000046sv00000E11sd0000409Abc*sc*i* cciss
>+alias pci:v00000E11d00000046sv00000E11sd00004091bc*sc*i* cciss
>+alias pci:v00000E11d0000B178sv00000E11sd00004083bc*sc*i* cciss
>+alias pci:v00000E11d0000B178sv00000E11sd00004082bc*sc*i* cciss
>+alias pci:v00000E11d0000B178sv00000E11sd00004080bc*sc*i* cciss
>+alias pci:v00000E11d0000B060sv00000E11sd00004070bc*sc*i* cciss
>+alias pci:v0000103Cd*sv*sd*bc01sc04i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003356bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003355bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003354bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003353bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003352bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003351bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Bsv0000103Csd00003350bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003233bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd0000324Bbc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd0000324Abc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003249bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003247bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003245bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003243bc*sc*i* hpsa
>+alias pci:v0000103Cd0000323Asv0000103Csd00003241bc*sc*i* hpsa
>diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.builtin
>new file mode 100644
>index 0000000..e69de29
>diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
>new file mode 100644
>index 0000000..4b64309
>--- /dev/null
>+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.order
>@@ -0,0 +1,7 @@
>+#336
>+kernel/drivers/block/cciss.ko
>+#2094
>+kernel/drivers/scsi/scsi_mod.ko
>+#2137
>+kernel/drivers/scsi/hpsa.ko
>+
>diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
>index d7802d7..6465230 100644
>--- a/testsuite/test-depmod.c
>+++ b/testsuite/test-depmod.c
>@@ -57,6 +57,40 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
> 		},
> 	});
>
>+#define MODULES_OUTDIR_UNAME "4.4.4"
>+#define MODULES_OUTDIR_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-outdir"
>+#define MODULES_OUTDIR_LIB_MODULES_OUTPUT MODULES_OUTDIR_ROOTFS "/outdir/lib/modules/" MODULES_OUTDIR_UNAME
>+#define MODULES_OUTDIR_LIB_MODULES_INPUT MODULES_OUTDIR_ROOTFS "/lib/modules/" MODULES_OUTDIR_UNAME
>+static noreturn int depmod_modules_outdir(const struct test *t)
>+{
>+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
>+	const char *const args[] = {
>+		progname,
>+		"--outdir", MODULES_OUTDIR_ROOTFS "/outdir/",
>+		NULL,
>+	};
>+
>+	test_spawn_prog(progname, args);
>+	exit(EXIT_FAILURE);
>+}
>+
>+DEFINE_TEST(depmod_modules_outdir,
>+#if defined(KMOD_SYSCONFDIR_NOT_ETC)
>+        .skip = true,
>+#endif
>+	.description = "check if depmod honours the outdir option",
>+	.config = {
>+		[TC_UNAME_R] = MODULES_OUTDIR_UNAME,
>+		[TC_ROOTFS] = MODULES_OUTDIR_ROOTFS,
>+	},
>+	.output = {
>+		.files = (const struct keyval[]) {
>+			{ MODULES_OUTDIR_LIB_MODULES_OUTPUT "/modules.alias",
>+			  MODULES_OUTDIR_LIB_MODULES_INPUT "/modules.alias" },

I think this is a little bit weird because modules.alias is not really
used as input. It's always produced by depmod, i.e. an output I propose we do 2 things:

1) move the correct files we are using to compare to MODULES_OUTDIR_ROOTFS
2) also compare modules.dep, because we then ensure the outdirname is
being correctly stripped off the output.

I just gave this a try with the additional diff on top. If you agree, I
can squash in your commit before pushing.

	$ ./testsuite/test-depmod depmod_modules_outdir
	TESTSUITE: running depmod_modules_outdir, in forked context
	depmod: WARNING: could not open modules.builtin.modinfo at /lib/modules/4.4.4: No such file or directory
	TESTSUITE: 'depmod_modules_outdir' [56832] exited with return code 0
	TESTSUITE: PASSED: depmod_modules_outdir
	TESTSUITE: ------

--------8<-------
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-depmod/modules-outdir/correct-modules.alias
similarity index 100%
rename from testsuite/rootfs-pristine/test-depmod/modules-outdir/lib/modules/4.4.4/modules.alias
rename to testsuite/rootfs-pristine/test-depmod/modules-outdir/correct-modules.alias
diff --git a/testsuite/rootfs-pristine/test-depmod/modules-outdir/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/modules-outdir/correct-modules.dep
new file mode 100644
index 0000000..ec50ac3
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/modules-outdir/correct-modules.dep
@@ -0,0 +1,3 @@
+kernel/drivers/block/cciss.ko:
+kernel/drivers/scsi/scsi_mod.ko:
+kernel/drivers/scsi/hpsa.ko: kernel/drivers/scsi/scsi_mod.ko
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index 6465230..6e3ae56 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -85,8 +85,10 @@ DEFINE_TEST(depmod_modules_outdir,
  	},
  	.output = {
  		.files = (const struct keyval[]) {
+			{ MODULES_OUTDIR_LIB_MODULES_OUTPUT "/modules.dep",
+			  MODULES_OUTDIR_ROOTFS "/correct-modules.dep" },
  			{ MODULES_OUTDIR_LIB_MODULES_OUTPUT "/modules.alias",
-			  MODULES_OUTDIR_LIB_MODULES_INPUT "/modules.alias" },
+			  MODULES_OUTDIR_ROOTFS "/correct-modules.alias" },
  			{ }
  		},
  	});
--------8<-------


thanks
Lucas De Marchi
