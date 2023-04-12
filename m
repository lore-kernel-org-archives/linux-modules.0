Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FFC7619A
	for <linux-modules@archiver.kernel.org>; Wed, 12 Apr 2023 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDLUUt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDLUUr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 12 Apr 2023 16:20:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52559D3
        for <linux-modules@vger.kernel.org>; Wed, 12 Apr 2023 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681330841; x=1712866841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=li4CGWQL2GQh7fE9MDJyIzaSauFHf2sWdBGpzMP3dFI=;
  b=A+Y3iGc0wJAKKHwFsfhhfjLuDvOZqH0CHAE1AU0LBvMsW0bu/Y4RIRMZ
   2H8mOjlImbL5Mym6fK7gRW0Y0QA3Lh+gQ/2FJws5sdqhz2meakHGZtA1B
   vfEOOPPjTVv0RIcym0DSsY7NBYwdDDeyR+vtDAC26EYE6/6a+2Tosa+WP
   VycJlp6MCVcsMFbe1zdN/xYfBd+1IqniBlUCW/ar8yOs3eFQv9IOe5rHd
   qWKyiQUjG8tUxB5iNYldcaeJVGCMwmbWNLgNMUJX1HWtVsv+S9IAPTJXN
   q4pgbbfV4hSxKZlYX0+YMHFJ+1JgWG3+xJ/8oF4tHFpUqJK4LTGdNIk1n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346692750"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346692750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 13:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="832803807"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="832803807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2023 13:20:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 13:20:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 13:20:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 13:20:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 13:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idj8EnMQjTnPHTTUaUN1V9X8BGmyz7TSlvcnR9tnkfdmw9RBcZ3oskPEw6hxq+T3dwE6oyIoswqTcpMryu8608vem2pNOG5XycCy7YJRDQV333YNizmaW+ptRMLYXzwT3sobpKpOi+nHBJ292QsUDKKVMYQlj7WmlWC82PAsXtLQ5bjQGI6EZz9MF4rZw3O/ymA20J0IazyM4IeyMSy82lhkNk3hBNM+QvbV83vxLhP/HVDGfFy80wW+eZtea479XyhCTzGlicOuxuuRig/WwC/TdygHnEfJbW1VzF/Ljk60OHgMu1GEMTJEZRZKGwSn1pKSmUHFg6GmyFQ8Zb1T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaTYbG7gzFwqZe4FNxoLeYm2BC86ftce+I0gZDjHHo0=;
 b=WbIuBZV4hgNIK/DGv6p6hpLdja0eHjzQDkU3veiarl3CTzAeXh7PH099TU9WuIsVZgq1IMtC+99ptUZ+J3gDbKS2RALY8j6g4+EkEj1NLsG5PHWBgCGtx5n00u0aluN01b++QhzYQz/V8EZbvcWe75ZTUvr3f03WnMZFPmpsJHpA+U0efkzjM4l+heTg5kfZe36vMKxvHHcw2wOnhSm0JXnYZe03EiVl32jJux4ABX8r7O9RmT2dZFX9u58rdnzKI+3CGAEXWtlVjim7Lw61IwI9nObhgrhbQoE7dga7Fh3/4ULURDHClYB0ra2gdkuYg180H4xrwypL1LAuqq/eKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5101.namprd11.prod.outlook.com (2603:10b6:a03:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 20:20:36 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 20:20:35 +0000
Date:   Wed, 12 Apr 2023 13:20:32 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Nicolas Schier <n.schier@avm.de>
CC:     <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 3/3] testsuite: modprobe: Add test for --remove-holders
Message-ID: <20230412202032.4tm47l4mwxa3x3iq@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
 <20230309-remove-holders-recursively-v2-3-8a8120269cc1@avm.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230309-remove-holders-recursively-v2-3-8a8120269cc1@avm.de>
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: be1ff441-3178-42b9-781a-08db3b935fb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5MNic62/jvfs3godsj18donquAx7qQtLCdTQkOfGu6XLCYMiatgd8NDYEksBWEiA4vK/hk3qDcDUsHhHkB2r+VEfgLP2UGkueN5lg5tMH/QclyuBc0FkT+9Hzw53U4ZWOk6r8+yjoEmpbw35Eb1P6cPibywUrzVOm9IWhbhTeLyWeJbeT3pxrs9WRjdEA5UP7TYTgQLr7fInxdqY5i4cBbzvHD1hQzpo4jujqfKCtUsZbvaCfNnInadWzfROn2Ldz9p7uTzJspa8LX1aB8ZeuH1joIX3+mSh5K44vghjh7/JcIVZJq/WVMzuYLkzwrAuCPs2MCFZP3oV1o9LBRz+CDHnMR3RnI5DhyTx8L393EakC87PPcZlCg+UUOkvxjRX1Me2YyMZN5hru/rYYCmYx05v/WKgQVG3sz6Q+eSzvra/BPmFg7TarIRHzjO+MFvEmoAGtm6IeG2il17PreEtyN6bSSYHLvJ+KsD0xPyqaZp8hA7MQf+zb05cspRkBp9+Wv9oV32NfS3M6NBk7Jt1QHPY3dRp7SzgCu9UD1CqvG85H743yYO2mZm6Pbh8s8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(478600001)(36756003)(82960400001)(38100700002)(86362001)(2906002)(316002)(26005)(5660300002)(6512007)(1076003)(9686003)(6506007)(186003)(66556008)(6486002)(66476007)(41300700001)(6916009)(8676002)(8936002)(6666004)(4326008)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePpxHQx+fhkhv0svKNV6acMhYgC+sWvOm/tQXy5NYSkaxrJjWZQ0FQC5Zr/+?=
 =?us-ascii?Q?SnxBSMPZMNKUTKSHJa2Gk4DF4gWA+BRUIZn897cPZ2RGknsBVGneWfNyAbLX?=
 =?us-ascii?Q?+6jqYEC5R467NiJcjvMD/kp0GcCA9qDqWoZZf4t6iWKtqcy33TaE/pRk8Dit?=
 =?us-ascii?Q?mfgY6cxEfPY7SdEGD13r6MvXCR26u05Bba3TVsMPObextX6LpyrWI3MDLfA0?=
 =?us-ascii?Q?T/7MVkosY06HzxOZKsDc4MKeS3SjkfPlx334IPejV5x7lbYcPQlA21jCS45V?=
 =?us-ascii?Q?ncl2P8DfGLhYT0Y9Il6428pa3kDYaIut492YFGqj4Sg51CTRva7D/jAaRCWP?=
 =?us-ascii?Q?B2zNNi6xqqW6eeREWgxmkqMD0mt/zAE7vkhrO5JRU4DYaq6e7iNU9BXb304z?=
 =?us-ascii?Q?/u2/Qbq94zngk9D+zAzQqC+M09j4TclNLCrcyRbrkOqN/oI29IQgOCkJo0fl?=
 =?us-ascii?Q?EoFORLXhsNv5af/QlDnPraV5T3vhFJv8k5dh48JSEpglB64eErwkzH6lmQot?=
 =?us-ascii?Q?trCmQqSJVTVyRzXPDaK0G1nGqfabj11GuYYxRZHFbh1zydH6OFW5xTiYeM6Q?=
 =?us-ascii?Q?9obzIBremDOr+q7M5QcxOqbtv4y0oq6H0z1tIPaXyIXolftY+/nAj6m90E1U?=
 =?us-ascii?Q?6H25yU5bnw7FDW3Ri1kwm7fmGLuBzcejC8uHBujt59NKk4+U3Zm4lkRCD8wJ?=
 =?us-ascii?Q?9uM1EHMOgtLFQFGQToR6YH7U4puK+r6EZ7bwZt9JkcqPumGwNrsJbEwYgKn8?=
 =?us-ascii?Q?0ukDd8h6htPdMsic+B9r8wVvAahL8Zl6coxVOOq2qq+stOBC6VYn5aZIczQ5?=
 =?us-ascii?Q?H5DKEuGsSYGn/cKSewYqK12XqaOaA0XB+rUu9N8MZaKR1jRC3QQEUINum8nf?=
 =?us-ascii?Q?Rl1+WYATf2WRr7V2OZJ5TdkswawUp3GAU0IVaPA9Jym0IFoJU9F6kgKk1EkB?=
 =?us-ascii?Q?fr7Rw3TwKB+ZB18pFgOZkIS8pi4jxOvpSYJ7gNT/OKHmk0RmINSwcG6mfEdx?=
 =?us-ascii?Q?zm8nqsYx34wR6TsM6ES8mrGBynRoDs794gE1WZyglpd/+R3ftHyVhyOsEZAu?=
 =?us-ascii?Q?Th04QUzDvFybnV6e0SHb9BlMwXeA3FND58gNS2ZTXjaMXrPM6cLRn2d+OzoO?=
 =?us-ascii?Q?ujbqkGPcEeeCsqsBzQvGm2DxX07M7vCRpYm8kuMQb0LWMaOSsSZKe3U6vFLV?=
 =?us-ascii?Q?yy7KgWVylk9mmS1heJeZIrRM9e+VmdO8uhMr28fakrQwzFCbyQGUbV1oOfDt?=
 =?us-ascii?Q?750WK6Qtlz7d1+34/tmyj08aJ+3nfs0N7WFayLnK2x8ddqktzWMsAUXyGBrE?=
 =?us-ascii?Q?1xxk7fc+8l31s931DYzBcycSrdWRqSlL0/Uoq8B6XxwgZVkGVzrotGXHwksd?=
 =?us-ascii?Q?oTD2Z4PZ6y6jyZFO6ns7cbE0U9/TB/nLLRinkLdmj54k3mIWS+/r1PBgZTs8?=
 =?us-ascii?Q?RIsW1nA8SzYTdm82Wwoh6eWavTdP3LTCkzhbK5LQouBQWhEqOrxuVPy+dLxQ?=
 =?us-ascii?Q?rNH64XLOuoWpXrpuwJ2xqvZBybKdoQZFEYyULinomyLway5u3XIFWT7fE/jE?=
 =?us-ascii?Q?aOx7KIQzQCi063hLPncltssuPSsdy8akb7w4P1f0xUMp2MIOOv2vOfa9shyx?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be1ff441-3178-42b9-781a-08db3b935fb1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 20:20:35.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr31EHL3QrXTxkvCxqPkijgbMaO4Jm4TJ80xHa+5NbAigeOA6+QE734h4yaouKn/gVQVbscKkcq/J75EWUHxuydpdRABG8cJin90nIfN+kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5101
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 29, 2023 at 03:51:37PM +0200, Nicolas Schier wrote:
>Add a test for 'modprobe --remove --remove-holders' and a simple
>dependency module chain of three modules.
>
>Signed-off-by: Nicolas Schier <n.schier@avm.de>
>---
>Changes in v2:
>  * new patch
>---
> testsuite/module-playground/Makefile               |   6 +++
> testsuite/module-playground/mod-dep-chain-a.c      |  21 ++++++++
> testsuite/module-playground/mod-dep-chain-b.c      |  22 +++++++++
> testsuite/module-playground/mod-dep-chain-c.c      |  22 +++++++++
> testsuite/module-playground/mod-dep-chain.h        |   8 +++
> .../remove-holders/lib/modules/6.2/modules.alias   |   1 +
> .../lib/modules/6.2/modules.alias.bin              | Bin 0 -> 12 bytes
> .../lib/modules/6.2/modules.builtin.alias.bin      |   0
> .../lib/modules/6.2/modules.builtin.bin            |   0
> .../remove-holders/lib/modules/6.2/modules.dep     |   3 ++
> .../remove-holders/lib/modules/6.2/modules.dep.bin | Bin 0 -> 229 bytes
> .../remove-holders/lib/modules/6.2/modules.devname |   0
> .../remove-holders/lib/modules/6.2/modules.softdep |   1 +
> .../remove-holders/lib/modules/6.2/modules.symbols |   4 ++
> .../lib/modules/6.2/modules.symbols.bin            | Bin 0 -> 143 bytes
> .../test-modprobe/remove-holders/proc/modules      |   3 ++
> .../sys/module/mod_dep_chain_a/coresize            |   1 +
> .../module/mod_dep_chain_a/holders/mod_dep_chain_b |   1 +
> .../sys/module/mod_dep_chain_a/initsize            |   1 +
> .../sys/module/mod_dep_chain_a/initstate           |   1 +
> .../sys/module/mod_dep_chain_a/notes/.note.Linux   | Bin 0 -> 60 bytes
> .../mod_dep_chain_a/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
> .../sys/module/mod_dep_chain_a/refcnt              |   1 +
> .../sections/.gnu.linkonce.this_module             |   1 +
> .../sys/module/mod_dep_chain_a/sections/.init.data |   1 +
> .../module/mod_dep_chain_a/sections/.note.Linux    |   1 +
> .../mod_dep_chain_a/sections/.note.gnu.build-id    |   1 +
> .../module/mod_dep_chain_a/sections/.orc_unwind    |   1 +
> .../module/mod_dep_chain_a/sections/.orc_unwind_ip |   1 +
> .../module/mod_dep_chain_a/sections/.return_sites  |   1 +
> .../module/mod_dep_chain_a/sections/.rodata.str1.1 |   1 +
> .../sys/module/mod_dep_chain_a/sections/.strtab    |   1 +
> .../sys/module/mod_dep_chain_a/sections/.symtab    |   1 +
> .../module/mod_dep_chain_a/sections/.text.unlikely |   1 +
> .../sys/module/mod_dep_chain_a/sections/__kcrctab  |   1 +
> .../sys/module/mod_dep_chain_a/sections/__ksymtab  |   1 +
> .../mod_dep_chain_a/sections/__ksymtab_strings     |   1 +
> .../module/mod_dep_chain_a/sections/__mcount_loc   |   1 +
> .../sys/module/mod_dep_chain_a/taint               |   1 +
> .../sys/module/mod_dep_chain_b/coresize            |   1 +
> .../module/mod_dep_chain_b/holders/mod_dep_chain_c |   1 +
> .../sys/module/mod_dep_chain_b/initsize            |   1 +
> .../sys/module/mod_dep_chain_b/initstate           |   1 +
> .../sys/module/mod_dep_chain_b/notes/.note.Linux   | Bin 0 -> 60 bytes
> .../mod_dep_chain_b/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
> .../sys/module/mod_dep_chain_b/refcnt              |   1 +
> .../sections/.gnu.linkonce.this_module             |   1 +
> .../sys/module/mod_dep_chain_b/sections/.init.data |   1 +
> .../module/mod_dep_chain_b/sections/.note.Linux    |   1 +
> .../mod_dep_chain_b/sections/.note.gnu.build-id    |   1 +
> .../module/mod_dep_chain_b/sections/.orc_unwind    |   1 +
> .../module/mod_dep_chain_b/sections/.orc_unwind_ip |   1 +
> .../module/mod_dep_chain_b/sections/.return_sites  |   1 +
> .../module/mod_dep_chain_b/sections/.rodata.str1.8 |   1 +
> .../sys/module/mod_dep_chain_b/sections/.strtab    |   1 +
> .../sys/module/mod_dep_chain_b/sections/.symtab    |   1 +
> .../module/mod_dep_chain_b/sections/.text.unlikely |   1 +
> .../sys/module/mod_dep_chain_b/sections/__kcrctab  |   1 +
> .../sys/module/mod_dep_chain_b/sections/__ksymtab  |   1 +


I think it would be ok to drop */sections and */notes/
since libkmod doesn't care about them. Otherwise looks good to me:


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


thanks
Lucas De Marchi
