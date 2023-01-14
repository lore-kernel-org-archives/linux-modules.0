Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A491C54EBE
	for <linux-modules@archiver.kernel.org>; Sat, 14 Jan 2023 00:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjANAuV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 13 Jan 2023 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjANAuU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 13 Jan 2023 19:50:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC5088DFA
        for <linux-modules@vger.kernel.org>; Fri, 13 Jan 2023 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673657419; x=1705193419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+VAxW/Zk8TR0rZPkgDxNPSEnxiMFGsl6nIf+Z76xNR0=;
  b=Swu9wSoWetJ44f1NvhJS9YegEyogz3WOezd7uMwvoexANcSQeQKwgjLA
   p4v2ukQ1UUsjE9nJV3wufXKkgoLAPOdsvL7Ew83y5sBSiPSjPk5hPRPzE
   dIVnwYi+P3iNBJP85QcatuNG7i6TUW6+Ya0xROgzzMMYW53qft8Hx1xtO
   oyHlCRqAlk4TsGV1alpp8QDu4ZN4mNFWuZ+c1HqHA5fGQxcaxv0HeRfmO
   aPzs/8ZaIKq+949h7v0OuWVuo6JJhMB497C2oDa+EaO82OfrGYHqaoV/B
   siDBhQjHQYpmzmvFoprXLZTyyNfUC4Abc4cbdOKM+1nhyl+ispoR5d1U9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386484502"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="386484502"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 16:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="721713146"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="721713146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2023 16:50:19 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 16:50:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 16:50:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 16:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBWpEo3J8BLcfOgIt6YcpteG1KxZSC+wt2IGppBKK6OGTQA5C95n9F0CxTK2V5S1DCnhkSeqKgx3TCXZguMa0uszLvWVPHDwLiXWXy0r8nOtw+mRLM2fZ4H8jDmiDTFNtORBlOVEx4iL4YJ0LaWqO9Qy4+1r2yfDWX6UZIFqTXbBy19z8sOtEy0jbhohrxDfIjhmPmQJzuyhnBRb7WHfyQGw2hZpviXC/dwWcZP7Y4SBK1mNwaXdjVxeDFOsYbVC/gRshAP3muoDjB2kI2d15wei6Zd+7lOnT3c04AzYzJzG/IWaEZo7b9JsalOWqnVQ7DRdJJOuvBPfWUlcW40sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYBAN1fFkE6dEYCbGcladZUC5WZaq8vjhd/V8QQWMHA=;
 b=kKHTHeZvwhMEvIXQQlEah3m7fHgMEFDohn05WJSXRArBFcH3kpVAZ/adYmVNCS430HhSLqOEPYR4vahxYtky6D4Zvu5lZkA5a+4kDv7mz/VlETDx9Qyv9IQ5doYAJ85CQS0H876Wu1JnTR0qhVkCPnsPshOFJcktQ5v4Z4Tc4u9eXiy6hlbi51eA1v4ifWRDcX2TwHNXVBlUDNMNfjlhKsmKNzpv4TEQB/Tz6hFoRtoOH94eEPUz0cZD6uTPztuYT6j8+zeVeuMbhVXOUi6YrHbKx9muWDM0ZeHlBJMZ4deuzul2CuYrj1UZI8kUpZrTMyUXdnnZZrOC+39ORfBjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 14 Jan
 2023 00:50:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%5]) with mapi id 15.20.5986.018; Sat, 14 Jan 2023
 00:50:16 +0000
Date:   Fri, 13 Jan 2023 17:50:13 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Gustavo Sousa <gustavo.sousa@intel.com>
CC:     <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Allow passing module files to modprobe
Message-ID: <20230114005013.des4qjuxogucuwje@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
 <20230113213745.227703-1-gustavo.sousa@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230113213745.227703-1-gustavo.sousa@intel.com>
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BL1PR11MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d31ea86-7daf-44f7-e2f1-08daf5c94d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0X3jQ2Eo2cSrP9hhEsgdgaPajOpb6L92DKPBQlZEitXVJHMF07PXkr0AIH9WI/au0bTcB+pOrcin+npw8wTlqjZL82LW4FDZlyU4iuYknR+rhtGN2R73EOtjCaHF8l9tilFcKwRJGN+NCSD4YoOkPEIdFgwY5FD2PIBYtzInZvhqZ17yPpLIsT0GQXiVHb32EhZ8THFdZm+fLkRCl7rVOjuuSHyVq0U6+3k5JD0pR8WJXjLFK56rd37lhxYOWB6SoMoDmA4KNqj8O8NXQGGaPexkXdcwz0CLQFVDgK8XkKJ0fye2IpHFborbpbWmNn3LxwqyEacdT4GjTqUs1RQHbME9b/8ojgD6/nFywIMj0+5DtHwj30o+Uo6DX3Wc9qQKiP1K6MeZN6FVhUwFrmJ5DrhRHO3jj2UxrOnUL+Swt/m+MdY3nmIqXxjEUYpg5fXq+7ogKofeEjUjQxqXFnu7Z3JIHa7VcDZkDTgOLR8h7H2zDAmZ7v8hB2WZbS12FNWo0PWw7Cjk6oW/vt8Brz56tEPbDu0LkeilGSrbL5YRQBXM+DwNyJHZqEAAqQG07sRuornaDCFnzx7+RpIrMzTb1tYswOCIn1LUStUW7ieLv/I5M3UBwhjsfBveBdpt060gblFXR2RwotFnmzO5CamZnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(66556008)(66476007)(6862004)(66946007)(8936002)(41300700001)(4326008)(6666004)(1076003)(2906002)(6636002)(8676002)(5660300002)(316002)(4744005)(86362001)(38100700002)(82960400001)(478600001)(6486002)(9686003)(6512007)(6506007)(26005)(186003)(33716001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6P5QMiUHVli7du7ond7UOmfa2jvdXn5+o1UBR77l0pPLvPId9rWaxibv0S7x?=
 =?us-ascii?Q?t/J9S06Qsi/qS5gqCQq3jAgcR1Tm0Os3/RIADbH2Y1+8u02y6TirHnDmVduQ?=
 =?us-ascii?Q?IOd5hf6apxX3b6+1tP799StgmBVuR6UWYqihZgB3xwnZdpFh6owU9OWoKMQC?=
 =?us-ascii?Q?U4iCkaZtEIdEmHfG4yMn5eL1s1zD3VpA/GA/oAcAZSkH71p4m1H5Cspa2ti0?=
 =?us-ascii?Q?kdHfOEcBscWVG3q6W5BEAYage/1KJEZtguaPLVVpNEF0BxnkTnO+zI3b8FNq?=
 =?us-ascii?Q?7jgCM1GW03owbdTPaGrbuIIRZSbZ5vJNC5jjzVuEz6rDp0YlBVKLGOb33onH?=
 =?us-ascii?Q?ncxkHT/dKy1975VkDScTbhtG2b9ublSHOg0HrZyQYpryifHI1MO64ui/l0Pg?=
 =?us-ascii?Q?UiqyGMw7eF16M8a5ZXrmdJUQlVHCap0+P821sbiGzsZlZEUc0MKkrL3Br/m0?=
 =?us-ascii?Q?eSv5JGRWcE5G/+LgLccxyWdy9zF841YUz2776cgD6yuUA4/l3v2z1sojTBeh?=
 =?us-ascii?Q?8zvmzvsGc/QWSY2TEIE8m9j3RJ5/GrTurDsUWPT6ak7YcT2Szf+FxD3RJrrI?=
 =?us-ascii?Q?dkQ07zKT1vBs55TcHZ0Cj9RP6vHopF2oheoyxoyTGOVX6DBtfonYqdHW+BQl?=
 =?us-ascii?Q?x07/Wy0zcncTzNYRwzyzey9OtS4AgmBkUzUjN8MXYP0J76G2xCWi2wYdDf5A?=
 =?us-ascii?Q?YQr7AuV3CMkMyz4BH1SgOR10HCfnVk7iAeRXYKtP/Yv5QC0oKls+sQZeAEa9?=
 =?us-ascii?Q?tWxX9Gqprh7BvermihGOM7T1p4f3u9tSR7xLk4u7gSO3w9VRiingWIDAPWD6?=
 =?us-ascii?Q?azJvvABWNBdZ4cqnrtvYUQ1amiCSnG1AMQD0r6IcFzN2Nxcy5Ba+x3Vx/bQr?=
 =?us-ascii?Q?yhkkYmzZHRtvB3k2jy/BRoIZZTAxhezG8XP0qO6+cKVdQlPJYoP2XX77jFBJ?=
 =?us-ascii?Q?4m3tfzyYU+EHDZO04w3F6Fq1TpNFNMIQNBaHSbBi05hgyK7dScxy7rEi7zNF?=
 =?us-ascii?Q?m26Cu2pB44EeYR2ptvo8U7F9b0p7D4hIQWXqJj6ZA8t47Ghrzxr92zWJUFGF?=
 =?us-ascii?Q?bDeYF01Wtz1nE2ds9qyi8p6KkQjB5bstf/Q+CDk03L8MkmigjupV2JTQNSHN?=
 =?us-ascii?Q?FYtcWHvA+D0gvitXRPnmKRSFWIJCvbGiNDXgWpMdxpDhJAn7GsTMZWwSynPa?=
 =?us-ascii?Q?HiX8o6f9SVUmmds0h7DlRdDEE6z6aQlgTNpbA784Gc25klVrowFNZszyGFeA?=
 =?us-ascii?Q?fsZaPmX8/y5LVFheGiZMhUiUew/wjVzPb/xzNNF7c38knSwTbzL1Ugs3L6Gk?=
 =?us-ascii?Q?ZHozleSKidKX2rEwlzf7KJE/4YO0yq7aq9EsfO7WxeDk+ydSZG0MTixNqIpi?=
 =?us-ascii?Q?bj3SpEtVKvQ/BJks3enYVbpbIjR21ovCr5BQQIGerreNft/nVEgKXdOyVHUy?=
 =?us-ascii?Q?feluVP/wPOCFuUbJORMTsXaS8nE8IC4Rkrmb+c1E3ps7Do6En0CE/OepUWo8?=
 =?us-ascii?Q?0qRVcV2Np9BoIpVn4qIj7BzYYBtgnXJhefRcz3sSkIOAOj49ALkg3YVU+/sS?=
 =?us-ascii?Q?a+ZGJ6NfJlf4ADY2bVn5WFDlectYwIK35O72ggbCEdFAipn1XTZy/chwYPv7?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d31ea86-7daf-44f7-e2f1-08daf5c94d48
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 00:50:16.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YtRL8Vxg4YZBB4EKgvMETF8TebXbJZdQlqGB/KP3RcfZ22DVoDcnZDrBAWm00Co8yD2eIGwy6FTwLsdZ7OllXd76Icy61eELNpv6aNpsec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 13, 2023 at 06:37:42PM -0300, Gustavo Sousa wrote:
>This patch series allows modprobe to be called with a direct path to a
>module object.
>
>v2:
>  - Add a patch to wrap chdir().
>  - Add test for relative path as well. (Lucas)
>  - Add note warning about modules with dependencies not matching the
>    installed depmod database. (Lucas)

All patches applied, thanks

Lucas De Marchi
