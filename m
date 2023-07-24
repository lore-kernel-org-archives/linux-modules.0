Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59328C0015E
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGXN2s (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGXN2n (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 09:28:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA81B1
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690205322; x=1721741322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IMKao5N5Necr+RCVWC7fFLHOcy7yGG+TAs747VGXjn4=;
  b=DoXq21478g4E0AwL6uVkGiHNeNvXx+Ypa8FLwTUa173zSX9T+vXE2DOC
   IX4+vQkPJVuc43cazX0rHYcbgWaDX/Qm6Wb/WzWYdc2zaHRVWwzsOay+s
   /bNv7xLtCz028KcdcAdoM5EzsHUL9+KzNPUOEgV7UCG0+RmCf4eXzDC2n
   GVS6wyo8RDct0CO8l+t/kiHjd5IqJlNFSLs4+ZTOKZIgcAqQbtzhQUgwK
   IPHB57QmNodAMLV07pcQpH8pz7T7Z5qHKd2jDyONxaxXxkhxjGmHqH7J1
   wtDloCu6TL8WYdoSlIVklH0z6X+jPHvma9hLyU7BZ3MfQibSrIlNTcyDY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366331057"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366331057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815828781"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815828781"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 06:28:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 06:28:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 06:28:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 06:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO5ePlSv2gY17PlC/3qXXYs7de/3/0JuPt1G7/jFza8ha2i6XPV86kxCYG35a5f5XUHZxDtJjmj50Bdfdeslac5xNRJSLwXcaa03D1+x4Qvxp9FN3xJLwZY6eI/zdK3UpltsCLR/d5HRMjTzP4jw19DkFamuP9FTt9Zrd/c01hZFjuDVs4TCTtb8dWO5IU9946qOLaZdru1N6cwrWZ2GJdmCF00gnkhIr1xkkrqzZrAqYMr5qAJPNEAU96WwZBGJv2JSIuWPb0HCFa+IY3f0ZsbQHHomag+qbk8FmmkmfBEDB2mm5xil+a/1ycFIma8clX3bbWQ/ZtmVNx4qA3rhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzT1yg4Jpe5Wz956XOHCW9EAPJK+bQWWixZfMe3sNwM=;
 b=gzVpG4uCsxMjdQRqANEsJrBjL4AqQBktrbXO00ROV5wGOfRRGTqjd2aIddzjHx508lPBLZWphjT5R1dUug/Wz0nI2ei2xScuKngiOmgzeChR5EfCxj6yPwG1Zvufa2SlYBRYFFdcDLGrQtCoXFqiRyr/nKv1oSMrlgzX201npPamE71w1eucNIN8RLzsKlJo7yUhxhDbPg+TXH/Rkp4T1rPvI5KNmhVTAizxl6cQLe7djbRB8Ql1DlhmVxfc0jDCFbh+hMi1uDypVytek0Okf70TOEXjvLLKS7+e7DklxwVbXjPWqrStyiaKtd5P17rhbEYG5qsVqkInZ6ESnkQNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 13:28:38 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::3294:2cf2:e022:7164]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::3294:2cf2:e022:7164%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:28:38 +0000
Date:   Mon, 24 Jul 2023 10:28:33 -0300
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/5] libkmod: Use kernel decompression support
Message-ID: <jud4da4s5jaqjidtiyog7vjruqhguaxum6n6pmlhcmqllazcu7@qmsex3rljiv3>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: afaecbf7-4ed3-4bcb-a302-08db8c49e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3C2fHTrHd+khp0eMS0e/PYvVmsgWandiwkLnLH68QTEAZR3kN8YXTrU7O6MJPxP9eP7ecYpUjPxSZ0RRGm/b5ukmda2hwxRM4V47RzClqgRiTaCb8XBMuqv3m7aI0RNG3CtN6pMOxN7L+epFhMtEu4phSGFUdGviSJDYxYQn7PcQNON2sfQWOYH0zBHlXfL9gCq1PvJWQ6mxZUnT8zpwJFFcXX47+4EBrV5qt2WnK/9wj1RNIyn0pUcAxgbcBNk2Zg3X/74TqzPtnzXeTYAXP1YzYPNNlOiOg5XqN7IV1tMZnkoJcwNACy/g3uYy4v6c2kqh4sQA6rtUcyVkjXw+Xs8QV87SQUtBdTSZ7kUpEaKR2Ra+yRXD34SmKaFLw1iBJsCOBBFgYSRTaPR8sp5vv3oReh6eY4LkXOTI0sdi6XyxzsPcfPyD+5FkUYX2NR3f2u8Pdzhwqybm3NLkyCShZj2PNJBCaVBIf1kbDv6WVcMkzUgdw4LWVPioSmrjHM18y9b1CblHn5GdVHozNr4btl4CeytpoQ7DNYVq7offdS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(33716001)(9686003)(6512007)(6666004)(6916009)(66946007)(66556008)(66476007)(4326008)(6486002)(2906002)(478600001)(86362001)(316002)(186003)(83380400001)(38100700002)(82960400001)(5660300002)(6506007)(8676002)(41300700001)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XnNlX1xmOGL/re0d7DZG84ofznfimhdO5hvxHxcSpFkTm342TigbYAZaGaXi?=
 =?us-ascii?Q?2Qmm5xrMZxTrXhaSJTCXSUDCcAFsYGCNTqlsVD6/QFLBCO6T8gTTg8OYt44W?=
 =?us-ascii?Q?35kckvjy43Om+51bsrNnNWq3gnD9R1pJo/FpUb9S8X5TSzn/sYoXzymq86No?=
 =?us-ascii?Q?W0smtFMpMjYoVNb+NOcDhqoLzrT7s6nDShiIbg/HVWUz3XZ43KtQFIOVwvag?=
 =?us-ascii?Q?PEB6ADNRf16jGkBrZrUW1A7kRtio9EYWQOwXCAX6LZqcdUvztWisQf2uSwwI?=
 =?us-ascii?Q?tHUuqgnY00WG2AekEvZH0ZxJHuiDm4roKbX/ALuQ94aIG7WxEdJaEB4VUBYc?=
 =?us-ascii?Q?qAZBNAP/sTM86TcWBld8IL8kWbwM7IfhL3LpnSqC8nm68s7SxAEZv+swmz1e?=
 =?us-ascii?Q?WZjsvJEJeKrGcc55iUibxGPbqbOw6YjDyVgTFKdNxmlJaBYPSUeaNI2vBMLG?=
 =?us-ascii?Q?EBZlCPvZm0wZUy22RH5jSD6bMhvh0bYgmgH0z/YrbMPTHus/QdfMDi1A+WGR?=
 =?us-ascii?Q?JTtkGXCXSnaKh98utwvqN8js2VRyulu3WaEyw/MpaOsHTTl/XkXqXNZrn6nD?=
 =?us-ascii?Q?HepMUzUYm1gi5gLLZuEJzgrHd/gNvRfu7D6G2jBhNU9z+UEbDiUi/NgoOr3U?=
 =?us-ascii?Q?UpPgGF2YPj/7O5b0U353eLiypKYHgg/IXzqcyDt3mccNYT8VPVXV6LfvwxoI?=
 =?us-ascii?Q?t6EQ7QkAHvYlf2HPvaQb4jCg431TlJCP5VZXfCIvd6i2/AAG0nbFQHR9OrN4?=
 =?us-ascii?Q?FQr4XoxuyaRryc1x/RHJuGXYt9xnNbAXY8ScVqMt0/mqzrD78IeNrNSIaxET?=
 =?us-ascii?Q?Nl9MiybNSBWZYGKOtePxhcuORtzOJYDeTv+oOnRhVpjuZRNRwpghFUMz0G3/?=
 =?us-ascii?Q?J5My1ZzfqAB1P7g4a6za6xZM8ifleepyGdq+lBJYCBAI3DIOnmB5EhC5LJC+?=
 =?us-ascii?Q?E6W/lWv42nSu9Myai7wUeDWbtbGLaunnRhuDreao7SqHGU66hWfcbJ0X07Tj?=
 =?us-ascii?Q?ZQYgBxOzSMMbU/wKDPFZnbgJSKds7oq6cgH9Dz/hFfIJEi7te2x/37Q4af/F?=
 =?us-ascii?Q?ZrPLm7IE9eRx0HvN+dcgbrpWawSFZfWF/nHWBx7hhcNqTzuyxrmSuXm6Kd5t?=
 =?us-ascii?Q?iCixnVjKzCXFKmR+3vurnUFpBsF0Ls3dMydtHL3cfP8mt0V8mvqTgbaBa58H?=
 =?us-ascii?Q?KaZknmX4VmlBIAb4HkDxpigI0ln+peY13kl+P48QMOo12gi5ytvaF8rkcFd6?=
 =?us-ascii?Q?Ha9foC0wjp0BDuRMky9YJZmMytjNNnT0Jy/Gmbi0hx3p4jUpH6Jz1IqXtn4C?=
 =?us-ascii?Q?aJFjt2pz4sBXHb1iIRuEFTXAl9Urqk9vO7h21+AEMFZAqwyb59F39EW5eo1Q?=
 =?us-ascii?Q?aH1Z0ePU7o6jwyh8GvBprtSWXberm+3N+oTH5syLPNjH2qxlLhZQR4PBaZD9?=
 =?us-ascii?Q?p1exkYzdBUt2Zg6dy3m0IrICS7psMeyRVY6J1/XHm4LY+ZBickpxPrkus8Fu?=
 =?us-ascii?Q?z8RHxlSzF+71Px1xVg27FVOKxQoy+Ydu4gywyzImu9L5mnc/hICJkW5e5llj?=
 =?us-ascii?Q?eCr178i+P2bGlx3m7vRq5P+ym1fdSF5E2MEa5a1og33CqGH6rkNQWUccG/CD?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afaecbf7-4ed3-4bcb-a302-08db8c49e3a8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:28:38.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLjMV2w7UQ9ADiOe7PQ5j4iBoaH0HgSIw0ufyi2snxU5BBC48vHOiPgtu+I2mHYywKPms/1ObKag0CMY8y/CsZdyUOiPbCuOXAC4krvVn0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 01, 2023 at 03:39:56PM -0700, Lucas De Marchi wrote:
>When kernel is built with CONFIG_MODULE_DECOMPRESS=y, it can handle 1
>algorithm for module decompression with finit_module(). When that
>algorithm matches the one used in the module we are trying to load,
>prefer using the in-kernel decompression.  This way the kernel can also
>apply any additional security measures based on where the module is
>coming from.
>
>In future, if the kernel supports more algorithms at a time, libkmod
>could even be compiled without them and just let the kernel handle it.
>Since it's likely a distro kernel supports all of them, that would
>seem a good thing to do (on the other hand, tools like modinfo and
>depmod wouldn't be able read the module information).
>
>For zstd, this needs the following fix on the kernel side:
>https://lore.kernel.org/linux-modules/ZHkQNQK5zrzo4Cq2@bombadil.infradead.org/
>
>Lucas De Marchi (5):
>  libkmod: Do not inititialize file->memory on open
>  libkmod: Extract finit_module vs init_module paths
>  libkmod: Keep track of compression type
>  libkmod: Keep track of in-kernel compression support
>  libkmod: Use kernel decompression when available

thank you all for the reviews. I just pushed all the patches here.

Lucas De Marchi

>
> libkmod/libkmod-elf.c      |   5 ++
> libkmod/libkmod-file.c     |  46 +++++++++-----
> libkmod/libkmod-internal.h |  13 +++-
> libkmod/libkmod-module.c   | 127 ++++++++++++++++++++++++-------------
> libkmod/libkmod.c          |  42 ++++++++++++
> 5 files changed, 170 insertions(+), 63 deletions(-)
>
>-- 
>2.40.1
>
