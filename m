Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA475C77B73
	for <linux-modules@archiver.kernel.org>; Tue,  6 Jun 2023 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjFFTBV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbjFFTBT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Jun 2023 15:01:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E795
        for <linux-modules@vger.kernel.org>; Tue,  6 Jun 2023 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686078078; x=1717614078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EpD+I5/wZnOAKi0Z+BvHw05WDY05Gt9dk9dEc03ognA=;
  b=acPJvtTGunILgzbgPzh75KH5z6fOC96zE6RZTpaeebUL6qCA7N3q1Cs3
   LzCLpdHqC5xVdzmjGWJ2oZ0bZsj9QfppY0+rRCRKJFhb1rLWtRNFycgfu
   oIwPnH5wMRt+WTwlzd8jGjHTBv3eemQnPrWg+VBDsyBUiYBr/ufyVnd01
   bT63b9eFmyTh2lNBMVVUFpSDbgqyV0H4VMNxEGYDjvpOAcuFOGGMFW2Ad
   jcwU6vtBRaDizNKnsHb3WGNpAcz/PTk6DRkpRyOauw4xqe0GkenVQMCy4
   1z54fgV1glfFwGI1qqmgfYdZVCO1BKQvyPUUAWFn43H3//bXBVtsVDmT1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337133781"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337133781"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 12:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712320965"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="712320965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2023 12:01:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 12:01:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 12:01:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 12:01:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 12:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtpNM3CQK1gp1SGCfK59yk8Nin+xi/gtAsg9j5Tjv9dtY/cHLKTYAeaXTX0PYRJjK7RlhSkSsWBqtaiEowSTZiJa9KFqliFjxwtJ9QtJs43cb0StTm0Nom2tv29/7wrDIjzvrh6Prlr5+fpfWXfhqkZ2Q7ofi0Cny5R7DDZwn54cGBMVz8Uc7H1V0jrQQ6f4JI3B+JpT1F4BCO5SSlm7FSBJ9HGKzw52KuOYocLkEfqwo3WZLRFzSLZ+6GvtBugRitUJQGxrIjYxDLISZey/ZdgnMAvWWe1fZNBtc4bleLUNuUluuJ0dgY5iOGUW0yJYoFRcM3Rsb0OdMjikOPRwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsQLE+pzmNO3ZDJ/GXjrBcryFO54OxaQcahXj7sjrUU=;
 b=SUqu5hCnwAntDO8dpa2vqPyQPcs7dn4xIcuYnkhbR9kv/P6fNQCQfgIfpwOhvsDwgh6SQeDns64SAPJ4nNjnmzOn1kKSXAhDB6ZphDbwmCDT9jTCuBZAun0vSYPyUaeiSNNzldiKRJ8B63wrQvPLAqv7RIxTCU/+RF/5GNLnM3TWuL7e5L7PXy9QocYFLKb74HitO0F1EVHdD7UIVvtHQPbpKWGHTtkaAgx5bPZlGNVdUj1wKU2DJseAF6k6oGXB+2cBWawmKShLzkCHnA6mNepPPIoKzlhzPlMW6ip6znCv4dSz7qbNiQ6KwdwYqT1RcxV5Cl4QUS5dbdy/miAauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Tue, 6 Jun
 2023 19:01:15 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:01:15 +0000
Date:   Tue, 6 Jun 2023 12:01:13 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 5/5] libkmod: Use kernel decompression when available
Message-ID: <ihstw3fqbsltj6kunixnbpeiyk6dmht2t4j3dg5mprp2cp2uff@5ldgkgahqkqz>
References: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
 <20230601224001.23397-6-lucas.de.marchi@gmail.com>
 <ZH99K7CwPQrykkIf@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZH99K7CwPQrykkIf@bombadil.infradead.org>
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: acaa5c0c-62bb-4472-80b1-08db66c0670c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSeNajy3HOlfemn8CYqnOl6x55yap3qay5tpRoHoEOkNZtznevuAzeEOyVixgkZ6bNxEy18LzC0rIsEKbVOY0HeXjXI5qVAgIVJKTegUAlQnJujDDZBeuyqGe2Fb4FVLGGQhIT5jsMWENuoI40PZ1x5l5yWVV1nEyKuMh6g4VAM+ju6BpXgLvp5sGFV042v6ICuKPD3D1nons9k+oYabGGRyhZqbnnnLV72Sy6k8iMwbc2c7yzNiK/8nQKidA9rxv8mTlQAOkBQOzSLj16E0UsUgaY3npGANsKF0h+AzD1b1825Lv6cR+DTtL3okzS7R3GFVbxl6Ktp1YvG8VHySO66f0zz9Yx1Py0PsSiPuli8dwETINpDDxwGcF/Dlay7VaTIRKAeAot3jSxdMx67k5D+8e4BM62IScQ6LOhsJIykRAfEQ/7JiKI+ayzdQ3jYMrZ/sKgvirF1yNvG3PX0b2+xbitvhWx4pdW/Lsw3iHVp0id9bmVvZxUKicnbssku6aTUgsMVTDGN6w7i5jVQPijCSuDT2VYpGF1gMUemUIwmDCiNeuXpmdCcetH17o+sV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(186003)(478600001)(9686003)(26005)(6506007)(6512007)(83380400001)(6486002)(316002)(8676002)(33716001)(8936002)(86362001)(41300700001)(38100700002)(66476007)(66556008)(66946007)(82960400001)(6916009)(2906002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/4nISeaOwG3tnF67HGt0nOZyUl4yhMYIMD+kz052bdB8FHBh0B6AvnY41b3?=
 =?us-ascii?Q?YQ8yp9Aw3Wnb+QxmeBN6YLggM3wcRvLzRpSiMXZ3JM6FiAcS93DVC2AjFixY?=
 =?us-ascii?Q?tNMr/Ze4OcvNk8BYrJirdbBywStiDgLTPIjiZPng+GGs9Jkvg27Xxi373o0W?=
 =?us-ascii?Q?EPk2y5UnTescKsXugedXJcCcojJg5v2WSCyhQ8gNGj09sTRCtkApyd5vf6ON?=
 =?us-ascii?Q?z4ZeIc4ZDj9bxd2FoXPZ2LV5IeCcJU6hwqPwKEdh/SS8IFlDMTgN6NbTRY2R?=
 =?us-ascii?Q?SPgO/ukdi9nMJveZDXObjURjT530LNvtfjx7DQohFaG3cW5cSXEHYiptsqwu?=
 =?us-ascii?Q?rQ+oAQxLcypbNpNFXpH9VNbe3vt5GOJ5qYxrGXQdq3BgB1hJNY87Y5VfXdal?=
 =?us-ascii?Q?KK7MQfya1bsQ9zAISHccwfVLds98lKzzJnTE5OEjmGIpLyb1CsuTFWMTRmZG?=
 =?us-ascii?Q?wYM+K8kg0DjIBndxbBtjvoHSAj7FrIe081g0gRtTqEjcYvwyHuRP9r/Cn7aq?=
 =?us-ascii?Q?soQPewQLRjOTEZli3AjAa6Jo4g9eWJirOdEAvp3SxvbYqapVCUtyinPeo4jE?=
 =?us-ascii?Q?MWklBRX1/9Nj1A/g67ybDwGjjL5Oc210PI4CMMQC7Vr1ConLzJL7gbDkjSnD?=
 =?us-ascii?Q?Qozk9Vl2f4JxH2MD2Tce/ARXm2MiLpFR+Ag1XyORrEy4u+WW0R3Hrd1RpPjv?=
 =?us-ascii?Q?BWLVrhYGNp+yhkY7GLJj0GYaymi3Sb6tZUkyEJA4UR73957rTPBPTbDe2snI?=
 =?us-ascii?Q?CY7uHsrlROV/86t9L7SD1+f/ik1GZACFa0EJj5Bb4IE7RBkWoi5N5uO8M9EF?=
 =?us-ascii?Q?fOK0rR7wEekt+qodidWBxg6UYO8O9LcXWIhkrYj1BUrX9G4wqcmOuI9NoxXN?=
 =?us-ascii?Q?1EO/146YzY1kqTnVkuBlkecOCNnF6kx3RTN0/kwFJ6r8cQblT+nKYdH7fHeS?=
 =?us-ascii?Q?XzVT9/HNfeQ8yX5gR4nPzyNuT67A7GaLtCDPWMCyB9NqliOm99ufN4baqLMs?=
 =?us-ascii?Q?evBMbOPFWBoLzdOBAu9J9mPD+bj66YEd0awRHxAZ4duuOjkXTAl6JtwhkfJZ?=
 =?us-ascii?Q?3Na2GildtZGj+1RG8RKwNDm7cvDvzID95wOyBSomqW0CIh/dkYt/mAL0qs6J?=
 =?us-ascii?Q?SYYj+uzaQRvcUWx/QZBM4RwCrRgASVPyMGt/wQ9iXrrAiL9P8KW9A5kpa7UU?=
 =?us-ascii?Q?oWv8eikZi/F5MCYwwH+k/ot5s6+EBOO52qNAQ9VeIIrj5gyhK5S1UvSoHN04?=
 =?us-ascii?Q?6rQqzSHXW+AWLpNtyPkGT0kMCD+FVlcHatrLgZ967SDl2fqTGwE1jqiGIWgM?=
 =?us-ascii?Q?At6JCwDSnSUnQ5dnF10Dkl90u2O9ddvFjMAHv53WhBSWYCjkAzH5+pQeyAJf?=
 =?us-ascii?Q?6ofjjK5ejI7d4GZvjxA1SF/3Q9HlY7HX4LX5syFhIQNk4z3wlCi4pUAF4d6U?=
 =?us-ascii?Q?QIcXF6fbgVJMHq2edgGhMz3P3apH/rBNH3JMtcoreQuNlbghU6/Sr9c83qdo?=
 =?us-ascii?Q?wW76gMzoW3OxlKtiSKL4xtU/HEVsFMrQ2pFLG9lORouDvClZm8Avsw7dp04o?=
 =?us-ascii?Q?bKA4HT41BsR0q7dYpuWVQfXxkyslxr/uGJrQrnhnw16lDcJXx3im2yUpJIAW?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acaa5c0c-62bb-4472-80b1-08db66c0670c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:01:15.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6J7Za6MlB4ZQvESdclOsfsMohWppQpfF7yzzbOEd48DDORmVbKi2YHIZIFlGuOMJe1lK15xJfdOwX3oY6xxzw/zTthPl3cOoHBlUnEqpRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jun 06, 2023 at 11:38:35AM -0700, Luis Chamberlain wrote:
>On Thu, Jun 01, 2023 at 03:40:01PM -0700, Lucas De Marchi wrote:
>> With the recent changes to bypass loading the file it's possible to
>> reduce the work in userspace and delegating it to the kernel. Without
>> any compression to illustrate:
>>
>> Before:
>> 	read(3, "\177ELF\2\1", 6)               = 6
>> 	lseek(3, 0, SEEK_SET)                   = 0
>> 	newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=238592, ...}, AT_EMPTY_PATH) = 0
>> 	mmap(NULL, 238592, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd85cbd1000
>> 	finit_module(3, "", 0)                  = 0
>> 	munmap(0x7fd85cbd1000, 238592)          = 0
>> 	close(3)                                = 0
>>
>> After:
>> 	read(3, "\177ELF\2\1", 6)               = 6
>> 	lseek(3, 0, SEEK_SET)                   = 0
>> 	finit_module(3, "", 0)                  = 0
>> 	close(3)                                = 0
>
>It's not clear to me how the patches did the above, in particular
>avoiding the newfstatat() for the non-decompression use case.

because now we are not taking the path to mmap the file anymore.
 From load_reg():

	if (fstat(file->fd, &st) < 0)
		return -errno;

	file->size = st.st_size;
	file->memory = mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
			    file->fd, 0);

from STAT(2):

	The  underlying  system  call  employed  by the glibc fstatat() wrapper
	function is actually called  fstatat64()  or,  on  some  architectures,
	newfstatat().

With load_reg() not being called anymore, these 2 syscalls are gone.

We still read the header (first 6 bytes as per above), to make sure we select
the right handler for the compression method. In the case above it was uncompressed
("\177ELF\2\1"), so we lseek() and give it to the kernel. If it was
a compression algo matching the one in use by the kernel, we would just add
the compression flag and do the same thing.
If it was a different compression type, then we'd fallback to the
previous handling with mmap() + decompression in usersapce +
init_module().


Lucas De Marchi

>
>  Luis
