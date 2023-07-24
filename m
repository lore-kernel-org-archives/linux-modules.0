Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C70C0015E
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 13:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGXN3w (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjGXN32 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 09:29:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDB1B1
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690205367; x=1721741367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IJEZ5TewBO/AKRsTBW7WYCgelRLi+VwZviDvdbhBT5M=;
  b=iSyax2kNQUK3b85JGW2A+tFzqv2Z2Urru+mOeH2Q0ZKbWqUgVBhWqGmS
   qrFuLaHBYORS3cqpkLu5/2e6dO7+2BlwG96Xi3oPe9rn7V3/74P3YK8J2
   G+8YWMNkb3f/8p3BWYKZ6Iqm1xytpDF7vMvTXLI64XMu7Nulc+IpHO3VW
   JfcV7/FCCM5QyGvZi4+UKaPLQFCjGh0xrGvwTHK15jTE2LXSk84j66I8u
   YdZ+g9Nj0sWl6MJP231a8rTNrdzONUnC2ReYRA7qWjKC4WGvelCRIbC3r
   QHH8jTqTc93KQacTiFnfUaD3ZqzjCcyrSW0lYvBlhRkeF2x0uuSSi6uqI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366331312"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366331312"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815829363"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815829363"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 06:29:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 06:29:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 06:29:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 06:29:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 06:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHGLxbb9zfKK60cT20oVZVgFe2hB2m2vFTVF8b/+w2LiVk6E9VWNkN2eL9j5SOUNPeU4GtTdSqH8W6DpuoZaTqo/NNva37Nd+q/p58ie3AiRAQwC5coBniCQR7Ju5LQuSUFy+Udzc5Ob1FQZdtZWAwA1G3P+ATCexlBOG7MNbBsmCTwgOPFU2Q9DkztPfmviA6fgIKM6l3nV1Ld3IgEyjjUF3p0CbzoGI/vL88raWg5agHKoSyKFwGTPZ7qyq7TikSgiC2a2clEuYLAlj1sEsjvtZDjwJuY3KLJdSGSmQs3n+2K6eerj5vyZNl31CgTjTJVgYngk2NBGe/YMK08XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYJ7iqPz/FZYnAjNeHB+vIr25V8HcgS3YRvs3+oiBRc=;
 b=AN1bL+mCpznZ8wScxkwn2q0E95Igm+/5GJzthCpwkhaU4lv+nuSVvHRTHjtGQvK0PVH54kLEjouI4uX4u59Ygh1yOC/yT+51KbNpUgJ2hT2q+Rr1039xQesoho35V+KxKXw1t6y3OYskD5GO5zwPXf1WhJLoMEOl2eayh4eUKGQSVkBPLwl0tL8NpQ/YFDkgSIxsABfIYZsBDm5OQU/M9cJ5/kSLWueSlGHrf7Z2RzWfkTomZiVXb5UmO9XPK8UakagfP4ipIF9xjgmW+lpdqiF1Ek9Q0lc9W9nNvu86OtwjKcoDHsiAtLtAqmH2iq5rv9c9Uxze497vvleOa7eNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 13:29:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::3294:2cf2:e022:7164]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::3294:2cf2:e022:7164%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:29:23 +0000
Date:   Mon, 24 Jul 2023 10:29:17 -0300
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] libkmod: Do not inititialize file->memory on open
Message-ID: <ofy46ykvhcc6an5xtkjpp3adx7ms6anlc7xhesifh3o3wwwswg@pq3cfzwe54dy>
References: <20230616050041.99712-1-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230616050041.99712-1-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e8ef96-1b82-4f55-0b97-08db8c49fe37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIWoqprJw8pHllsQPSjqORs+R4M6uTRHwRV1EcklqO2QhTS6sFjBkqKqOuOH3A6tOPW758k9yvSIHHhs3wkny+kGyaBRZq0e+GhrjE/HdVsscAiV66gB0PsCYoYprdVOcFConq+h6CZJ3/5QfSl8PLotLIFBYs5yjBZVUePx54xDaoKJD4uyMtJGdWDIhBuYk+/5iqvzFhpQiMPNUDQ5SjoV4jlobXd4mFc8A0rwjJPWbzwSuyW4nwQXTmsU/8ANCIP/IXSuYHc27sgaFjcsvoTmdUMhFCBs0Lh1JQ3IK6N1ehSrjyOPYQ3y+ghQlJAseLrCyEoCyy8fu1TLHVt7SEQT29OhY2c0YTNDKonVXH7g5W4HHEyEfRAydoT+eGtJdHFgeWfw+61IHXoE8Ck6dlFtWGM2m+Stf28JgkXSoHarS/nnEKmDM1lRBAL4GHVlQW3Iyfz7x6F5x1JSksH8G9bkxAqsWOa/tRdFDRnxFGkY/vyCtZ6UUYFAqazlK6OQ1Z1vM1tdme2UJL83qCsSiri9kMCXo514OHbPNFCi6iz9rA6Eo0/lOWIA+oGVEZj/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(33716001)(9686003)(6512007)(6666004)(6916009)(66946007)(66556008)(66476007)(4326008)(6486002)(2906002)(478600001)(86362001)(316002)(186003)(83380400001)(38100700002)(82960400001)(5660300002)(6506007)(8676002)(41300700001)(8936002)(4744005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRkKNI2huRu2mir56IUlRdTIiPdkIiCY8vf84VZ4Lo6DdQMER7C8nu5HJov8?=
 =?us-ascii?Q?cBHXdIXtExr4D1I0mvpQ++66JuEp9wkYoeo2ImV2SaUYdHE4B0o/qLGsKvBN?=
 =?us-ascii?Q?LQD2y3OzmOQC2WMHHEnsfoCmQIX/0sgLYa2r9lDC8/uaYh++9pGJwb7krrH7?=
 =?us-ascii?Q?cTYN1GysgNQN3oWw3LXStY4A/UiDYvsXGlXeZAqk++9mskNDWyOcsg8WxMKn?=
 =?us-ascii?Q?p26XXJ81iCFSj/7UttVx1dEG48uxyEjhK8Wq/HAqEn4ePVq6VSt4Ig8gd/5f?=
 =?us-ascii?Q?hgTWXUpOW1REgbzYoPbAJ/wK/8SsXJX32wBQBDl4scSJ+UgcSwnu/T9kS2EZ?=
 =?us-ascii?Q?oL2evrW30mTzhz0/Iwnp7fnvu9aZM0Xaeqk6ugWotLnMZWZc84Vf9pzhEJFE?=
 =?us-ascii?Q?Bstli2dF6Ozki7RSbXDrKWI3GbVjn8tF5yctBYnw1BiipecARZyN1q67qv7/?=
 =?us-ascii?Q?qsYzUXYBKqcAN4Aenfr1KWbAR9KA7QlKzxvddlXHK7qji21Vn70jS1IIWj7D?=
 =?us-ascii?Q?ZNY7LxuwZ/CSPUGPcKaCuvnT0eYACTgtw1FuN6AxtAsNR8+StIxy8TN2ktCx?=
 =?us-ascii?Q?m/6g+vLoYxaH461ISDfLT7x13+ppe867/k8zoSkMdSn/itCa49vhgrDYHIJ8?=
 =?us-ascii?Q?TZVyVFOwGwGtbBG11HqjyAb/+T8lY93cpdYhqIkVB8jiWjQ8hpyEm+1unr9r?=
 =?us-ascii?Q?vaYFK7gEi9oegu2tDQAH1dB+XTi9zkaezyCF1v7zDlYhdOerLGLb7UYKfq0F?=
 =?us-ascii?Q?NXibxSSks98oK+CHxM4iwggcG00L2Ofz+afv0h9t8uLUjxOYqaH/w8iqvEd6?=
 =?us-ascii?Q?PYZY/Whk8Sc0+ViNkDtw36jPJOqZiQo4FYjwAjVPVKsENOO/71Puz0sU2LOA?=
 =?us-ascii?Q?B1+FW+ajxlfzZOZVkWuY1VYmmRUYVvue6qLU8zR5hWs79keU+uaO+izvfT52?=
 =?us-ascii?Q?pIxnb1zOhWYO7Ppl0S4bCy6uu95045Ve7TZT7zljmREyyGgzXulAAWBHxS0N?=
 =?us-ascii?Q?60vpvRhyvrn43iL68QGYy70+1rFQTa1x1s3HzpQ3iOLJjKZz2U9KyhseSfir?=
 =?us-ascii?Q?Ao+Zb/8VLkc9AGt1xsoV7WOiHhE8HGzNJD8k0aoobypnLIfJaPohuRVHIyBs?=
 =?us-ascii?Q?PJaI9Y6U7/V1OQjqrhNZ+3ij2lcHCj+ysTNpQJdoui0BOH/1GU0dcI3wqUpB?=
 =?us-ascii?Q?JgT/xd8mLCXIsFpH4zvvQalL108TEIBdNnPYMCQBrGE5r5Y/Dj+Fc9ajoPKA?=
 =?us-ascii?Q?8eA8HpiLggS6Y961AGPphnkcAzi1jk9ULp2PBdPV2sZpF4G3MDJuJ7vxBckS?=
 =?us-ascii?Q?BLqA8y9NQS/0WtoL9rEGA9FD2nAS8HI1rx5N+JfXM0FqvS3Xl63D34fQQy+M?=
 =?us-ascii?Q?roTxZxxXYNfD90lZamdpxJUigYgYaTsFcX9mDTlIrpCMsZ7E3j9Ajk9ccBVK?=
 =?us-ascii?Q?jhyYVbfIL17U5y/kukhuZ475rRWpP9+nX099y1jotZjp6+UaafnkINvH3zGv?=
 =?us-ascii?Q?zkiCeMBN0KtSVv0Xj0BkyupcoPdEaOmRgTRK2EgDIStQChr55vSnMrVJhKEL?=
 =?us-ascii?Q?aa2yIw432eMqn5isydR+txn78BCahpKPvIvfi4NVlBkhM0buxkgIVlqhxhXs?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e8ef96-1b82-4f55-0b97-08db8c49fe37
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:29:23.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/xiWVUycKF7pMwwctGcbQ1Wv/vIPLqqOOMmn8qzOji2CNAgUfnvJHqBwvgFa/+Fle8UNf6Ioub/VNlLNiPbEEwRMcw2zaDGYYemw/DgrJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 15, 2023 at 10:00:41PM -0700, Lucas De Marchi wrote:
>Add a separate function to load the file contents when it's needed.
>When it's not needed on the path of loading modules via finit_module(),
>there is no need to mmap the file. This will help support loading
>modules with the in-kernel compression support.
>
>This is done differently than the lazy initialization for
>kmod_file_get_elf() because on the contents case there is also the
>file->size to be updated. It would be a weird API to return the pointer
>and have the size changed as a side-effect.
>
>Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>---
>
>v2: change kmod_file_load_contents() to void since the return is
>    actually checked on the file struct

pushed with this change.

Lucas De Marchi
