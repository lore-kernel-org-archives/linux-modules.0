Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30907C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  2 Feb 2023 07:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBBHOm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Feb 2023 02:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBHOl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Feb 2023 02:14:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123EA5B5BC
        for <linux-modules@vger.kernel.org>; Wed,  1 Feb 2023 23:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675322080; x=1706858080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XSbTwBdNiPMj1CeCJiaiFSh021RQmEJdfbW8cpZ/46o=;
  b=hBsKjS8MkxmoBaZYOxTFZWqSWwUvzQZKOV7g2c/il10SrsehrTg9SYNi
   D7PKH4WrhwWgs0hlQChVzpm20r5PtXvnoO/YIq2V4ofPZ2bNZ33j+b4GC
   l2gRvGBLSkm88ktCNjNnXmKvMCnxSRQ5ab/IUEwe2E3Brt/hUOm1ZkDtK
   TVhNDiudNReLOInfJAId2lqLsISh4pduaYRWqf7QWwQyE/dX5ikm8R/62
   J67uVT6GNSfq3rYLDOgnI96yeyhDldKF+PVpfDuKkhEC26T6Pcgfk9LfA
   HOi83qTrqt4WYV9KAIdWnN4YkiDBGg/vWDEbCV44Nct2C+1NjGTQ9IGPZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355712251"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355712251"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 23:14:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="789179757"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="789179757"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 23:14:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 23:14:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 23:14:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 23:14:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 23:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhxhxDowNG6cvn1Xcd1nM9L+yUto2gGBJwUrEpF5c5OcimA3WihdnRkyp7NzeZwvROqgzRuTpcx2VjuWLVYE9XmbijLHViDdm4D98OXxTGmNvTM5BCkADl9bAsrJKNgOrdESzJR95R/eWvs+iGbZWcGj9C/21Pj/i7Na42ys862JWytW9YhC5s6Ra3mRlBKd2SMUxuvmu3I42ygEyr3t34JDU0Wt/4rdufGooe1PxoiDHTPk99guLD39aXrPvQYsU3zlX22298dBg+cpONMm7BzYBrnXgvoJVjSNrsFnvbs9BfeIKF9geYaiUrAQWPgpQXP50lTsJekpx+iyawCHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX82pqPaiIpU3vDL0IoFjRCd3eFHoMsLkowVHg/oSD0=;
 b=GEUdk2uC6OKaA75Uhq0Pz7tTxYyKsnsRmE2qR6bdC0qfn6QShS9cq5pRgmIFcdtVqtYsv7bP4Q7+Xd2T4+ZGlIGhrFa94pgRmMne/1+hWaCqksdjgyfdunzj0OrCPn9KOvD1GonUiU0eb3Vb9aTfM+9G3a2i6BBdc8NDbhBcGryXcMaJfHB92GaMwvDPSU1DuDGEbhw+QW/8pa/uoCCdIRATh5JCYNaTHKmeAucAAXcff4ZlosY/tt9hmdDzX4ecwy1DjoYp6tTpEpXn/HFb8BH8+hp6ApdYnEHThXeweJ1GjQEUe98s4VjlhsNo/DYrGKH/WN+LyVccDwXv4Jay5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 07:14:36 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%6]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 07:14:36 +0000
Date:   Wed, 1 Feb 2023 23:14:33 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: Introduce a outdir option
Message-ID: <20230202071433.fbcha2nwr3tiqqvf@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20230130183324.283162-1-emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230130183324.283162-1-emil.l.velikov@gmail.com>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: a787f50c-6178-4441-2f1f-08db04ed2391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYr8EiwQcDGQE1bZf0MLv/YV5l4FQZY2k4C4Lmrv7YVGiwkihE/1jHrvzeyRuSX0oi6vAcmCrc6bmC3+Ni6Ke4LI93dy42FLlvkm3Blgqc8oKsqQzklFlhqQ3QgmrcYEwJUBhu1SyFwEjTlL5+Kuyy6GokPFK2yESBRfAw5JLKfELTsgn9TP+t3h5Qy5jpTVuMrBg5Km1IpHEZgK8BwMH6Y9LAfCacfwnFRtcy4SkIYOjEZl6B/rVCXhb4mG2Ja+ztx5ANnDeQekCkWJUYir4ihLxATrOCdacM+ZPt0k+EiNepV3b6udgYWDjgc2hvT3QuhTs81620DmmJ3ULhJmXxk+sqa2+5Azh64j3czsTX5VOALgtjN9QWyXJukObCpjrvWmfyWcvQRfl1sEyLFm//n8wcMPkq9QJAqNJoWZlAWuOaHIqPlxhwFL4Awpq7qcWoAivm1ggKCp4jf1OLjXOtm0Wz75w0Bkl592V9Zm2wQ92Vrmf+nxh2XKdvczUHPi5eddkAFZwKEIIW7WSVEzzyga1r26BnjFPGXAzfO9s+gq5eHFl4gCAGqxV6VTOcij/pNjc9uY30GvXK3jwbR1AU+SUR0gTBHGqieb4Gf3AlCNiZUKQ7fPFpqnaYjXveKVc2IdTWyGwKahKh28DAkb7QCeZdUTleahS5vtEG/2h9WTo8gipwMgSJ0ag5OIma3R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(83380400001)(26005)(86362001)(82960400001)(38100700002)(186003)(33716001)(6512007)(9686003)(6486002)(6506007)(478600001)(1076003)(316002)(6666004)(66946007)(41300700001)(5660300002)(66476007)(4326008)(8676002)(2906002)(6916009)(8936002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ltKLm59EFKUxjvRTW0RUs4PRcqu1NopxMVG4FN+gzGLXxWyRz29idzpzRaO?=
 =?us-ascii?Q?IXASKJ+yCT7BvmDMYzTcjbWdirsRRrT6YAR2ANDgpp+/8G3U1h81fbJ56Ptg?=
 =?us-ascii?Q?bL2tJ99cmCe8fmCeD/RksBcVjwa79/eW/Qnl7QjX3dqmwI4fjYoFqmju0u4l?=
 =?us-ascii?Q?T+XXcnjNJpDwEhNWarUDVHd83+5IRNJoYp9VrPgoLo0assrEWaswz/16uO4J?=
 =?us-ascii?Q?vOaCnToxNkb2wZNIbt0CtN4jups94k2jM2A08m9rLyJM3Jdt0bYpj1HBTCiI?=
 =?us-ascii?Q?lMW3yV0iKZ5R8oJWIhLI2MKqtl4AorHj/U+eZaNygig0l+yDbOnkniJJzuvD?=
 =?us-ascii?Q?FBQAAsuv5kLzqTuUaKZ2Sy7iA/yMfS+YfJutjXR7fuaIHDnRnJTizfZu4Kep?=
 =?us-ascii?Q?01zk5lGDVH2O2k/aRhV8aRPWuPFJfaGkF4cnl+7yuZot0mIUtX+3kpe2mj/h?=
 =?us-ascii?Q?EGbD6i+nrjO2zrEoAdC+uKYXIBH98pZi7M8aGUi8zKUk8/6PhNsYUk5vQhGj?=
 =?us-ascii?Q?M94u/raWIhNfInTb5R6tdF5xH5/tAd806uGLnjqNjJxqcicFBphRUOWjqR7L?=
 =?us-ascii?Q?38QXzl3MFhXagfDv0FFe8LXa6s0hyKA99bPgoP35uMrgMSFWNwfPZfl+WJ1K?=
 =?us-ascii?Q?2fb//sCGW20WpV+HWol1GvvERBtrB07jbrPWwga7d9FvKEmWp4yjtdSf+4qW?=
 =?us-ascii?Q?Raih22481QmLZ0GJby2NT5l0ASfBcGgrdIPYyGxHxf2reOmrC+I0+f/VCibH?=
 =?us-ascii?Q?XcMvucMkjV7g159mITR/nSVHSOvBOSOYcBHFyThc60azGqy9EtGpZHYs1CQl?=
 =?us-ascii?Q?3dwqOWuqbn3SC1zi8s1utE0+zBimK2DGpAhfhGBA84XLmuoT5/OdfHZWLGD7?=
 =?us-ascii?Q?MOPuTg2WakUdjPYIqWLtvG+85RyOSQnu+wo2dtzZvF2vP1vCzHlizUtsvB07?=
 =?us-ascii?Q?rLN/1i7tmRGegu19vRI2hzVwPupV8XYL6C8YvWWu0tVVaEsDTDL7a4n2jt/k?=
 =?us-ascii?Q?BLivmeXn2hmiczz64ywQ9PPwdBpzBM2lsj9ds7swFeZfpAmrA3trP/diW/EF?=
 =?us-ascii?Q?qn80kp8vHLouBcgjLVvKLxB02kEvecZVVeavcmPcEWZE/DkL/hZH5w7pYlL/?=
 =?us-ascii?Q?SK/AiMC7IfRbZP55k1+xZ2snUa/at1YkxKwuDU6Nz2BxqE5mHPG6Dx6NZkKJ?=
 =?us-ascii?Q?ZrZZdurnfbDdmY5SLD8NfAKEdqHETHFDY2q4WbtXqNBlsU112JjnAueOo4LQ?=
 =?us-ascii?Q?jCc3HF6Qfxc1ZnfRzs+Nru+JrOUvzaBo4HKOwfgmYdBUu5I2450UD6Re1qP0?=
 =?us-ascii?Q?G8lvCPBI9yH8ufUfQo6FSVSt3NrMRnbL25nLMKfza2DMF5RqYY7sCQ/fepU9?=
 =?us-ascii?Q?CF9iCrVZC8976Mb+D7HZjByPvlYq2HS1WDXtFeOauynCCoDmekbBIG1TueD4?=
 =?us-ascii?Q?X8ASaErLDKz73U6LhvrFqgVAh3vLlPcnY9oxTFIsH82S2ZkMlx6XSChELzyF?=
 =?us-ascii?Q?KxbqFr5FMTluisnvv4x7xRM5XBazX/7plzUc99Xcuez2rLOFbVWnLXJAp4JT?=
 =?us-ascii?Q?1arOeV3OTl2nfyQtfrR0hPUDZBCLP8V3GJBL4nE+zP1D8IdySrwLkazLYfXT?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a787f50c-6178-4441-2f1f-08db04ed2391
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:14:35.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QT0zfw44TpVJR1tUq4NVS83d7ZPBHjFRneo97PCx9XZetQbi4rm0oQo9+jKiMaJ3TZacV69wdL6X+QGAARHVTd8a3WDO/We1bU8dBHZtCsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 30, 2023 at 06:33:24PM +0000, Emil Velikov wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>This option is equivalent to basedir, with the small difference being
>that's where the meta-data files are generated. In other words, this
>allows us to have read-only input modules and modules.dep, while still
>being able to generate the meta-data files.
>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>---
>
>Hello team,
>
>Here's a handy feature behind the request at
>https://github.com/kmod-project/kmod/issues/13
>
>This is my first time hacking on kmod, so hope I didn't make too many
>mistakes :-) There are a few TODO notes below where your input is
>greatly appreciated.
>
>TODO:
> - Add tests - team, any pointers or requests?

yep, please add one that calls depmod with this new option.
Copy and extend one of the tests in testsuite/test-depmod.c

You will have to prepare a "rootfs" under
testsuite/rootfs-pristine/test-depmod/<name-of-the-test>. Make sure to
add the normal files coming from kernel and checking for the output in
the other directory you passed as argument.

> - Split the dirnamelen shorthand tenary operator change - is it worth
>   it?
>---
> man/depmod.xml | 19 +++++++++++++++++++
> tools/depmod.c | 25 ++++++++++++++++++++++---
> 2 files changed, 41 insertions(+), 3 deletions(-)
>
>diff --git a/man/depmod.xml b/man/depmod.xml
>index ea0be27..c53624d 100644
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
>@@ -151,6 +152,24 @@
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
>+            If your modules are stored in a read-only location, you may want to
>+            create the output meta-data files in another location. Setting

that is probably not the only use case, I'd rephrase with something
like:

Set the output directory where depmod will store any generated file.
<replaceable>outdir</replaceable> serves as a root to that location,
similar to how <replaceable>basedir</replaceable> is used. Also this
setting takes precedence and if used together with
<replaceable>basedir</replaceable> it will result in the input being
that directory, but the output being the one set by
<replaceable>outdir</replaceable>.

>+            <replaceable>outdir</replaceable> serves as a root to that location
>+            similar to how we use <replaceable>basedir</replaceable>. Use this
>+            option if you are a distribution vendor who needs to pre-generate
>+            the meta-data files rather than running depmod again later.
>+          </para>
>+        </listitem>
>+      </varlistentry>
>       <varlistentry>
>         <term>
>           <option>-C</option>
>diff --git a/tools/depmod.c b/tools/depmod.c
>index 364b7d4..aaf2327 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -58,11 +58,12 @@ static const char *default_cfg_paths[] = {
> 	NULL
> };
>
>-static const char cmdopts_s[] = "aAb:C:E:F:euqrvnP:wmVh";
>+static const char cmdopts_s[] = "aAb:o:C:E:F:euqrvnP:wmVh";
> static const struct option cmdopts[] = {
> 	{ "all", no_argument, 0, 'a' },
> 	{ "quick", no_argument, 0, 'A' },
> 	{ "basedir", required_argument, 0, 'b' },
>+	{ "outdir", required_argument, 0, 'o' },
> 	{ "config", required_argument, 0, 'C' },
> 	{ "symvers", required_argument, 0, 'E' },
> 	{ "filesyms", required_argument, 0, 'F' },
>@@ -104,6 +105,7 @@ static void help(void)
> 		"\n"
> 		"The following options are useful for people managing distributions:\n"
> 		"\t-b, --basedir=DIR    Use an image of a module tree.\n"
>+		"\t-o, --outdir=DIR     The output equivalent of basedir.\n"

Output directory for generated files

<basedir>  is both input and output, so I don't think the comparison is
good enough.


I think making sure this is working as desired with at least one test
would be good, but overall looks goot to me.

thanks
Lucas De Marchi

> 		"\t-F, --filesyms=FILE  Use the file instead of the\n"
> 		"\t                     current kernel symbols.\n"
> 		"\t-E, --symvers=FILE   Use Module.symvers file to check\n"
>@@ -467,6 +469,8 @@ struct cfg {
> 	const char *kversion;
> 	char dirname[PATH_MAX];
> 	size_t dirnamelen;
>+	char outdirname[PATH_MAX];
>+	size_t outdirnamelen;
> 	char sym_prefix;
> 	uint8_t check_symvers;
> 	uint8_t print_unknown;
>@@ -2576,7 +2580,7 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> 		{ "modules.devname", output_devname },
> 		{ }
> 	};
>-	const char *dname = depmod->cfg->dirname;
>+	const char *dname = depmod->cfg->outdirname;
> 	int dfd, err = 0;
> 	struct timeval tv;
>
>@@ -2585,6 +2589,11 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> 	if (out != NULL)
> 		dfd = -1;
> 	else {
>+		err = mkdir_p(dname, strlen(dname), 0755);
>+		if (err < 0) {
>+			CRIT("could not create directory %s: %m\n", dname);
>+			return err;
>+		}
> 		dfd = open(dname, O_RDONLY);
> 		if (dfd < 0) {
> 			err = -errno;
>@@ -2898,6 +2907,7 @@ static int do_depmod(int argc, char *argv[])
> 	FILE *out = NULL;
> 	int err = 0, all = 0, maybe_all = 0, n_config_paths = 0;
> 	_cleanup_free_ char *root = NULL;
>+	_cleanup_free_ char *out_root = NULL;
> 	_cleanup_free_ const char **config_paths = NULL;
> 	const char *system_map = NULL;
> 	const char *module_symvers = NULL;
>@@ -2927,6 +2937,11 @@ static int do_depmod(int argc, char *argv[])
> 				free(root);
> 			root = path_make_absolute_cwd(optarg);
> 			break;
>+		case 'o':
>+			if (out_root)
>+				free(out_root);
>+			out_root = path_make_absolute_cwd(optarg);
>+			break;
> 		case 'C': {
> 			size_t bytes = sizeof(char *) * (n_config_paths + 2);
> 			void *tmp = realloc(config_paths, bytes);
>@@ -3009,7 +3024,11 @@ static int do_depmod(int argc, char *argv[])
>
> 	cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
> 				  "%s/lib/modules/%s",
>-				  root == NULL ? "" : root, cfg.kversion);
>+				  root ?: "", cfg.kversion);
>+
>+	cfg.outdirnamelen = snprintf(cfg.outdirname, PATH_MAX,
>+				     "%s/lib/modules/%s",
>+				     out_root ?: (root ?: ""), cfg.kversion);
>
> 	if (optind == argc)
> 		all = 1;
>-- 
>2.39.1
>
