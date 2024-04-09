Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC2130AF1
	for <linux-modules@vger.kernel.org>; Tue,  9 Apr 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675036; cv=fail; b=s6Cm8EZLsudwnlbh8Jjp2XBEpQ9zna6jnVU6asPmvQnlPSCs9S/du6z0vUM9UKChx1FsXvJCdoCcA/9Rcasr4o2+G6bqSX3tlkDT6uv+fgxF0nmFzXKGlj3pXpf/1uaEC6WeLba2FAUNXjHPLMWNueHWcGckrabe9wjm+L3LEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675036; c=relaxed/simple;
	bh=G9H9zOZKYK/+CzZons1CWzfuY9tqxSGowC7Ut4wDLC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oqByG9hh4Pav38GkKIvOxgA8t26foxDszwz6EmwRtPe8lRH+CE51FN6259+YdIRPCwhYJCCE0N/bHAf3C+oS3zqwGcq1oI1LQJy7pc3hxvkmCgpG2N0yFXgO92sUHN9wbJ1CnCsDgkUoSHj6RzSf7ORph5BFjWF6FRVMtJR3+kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4hC0D/W; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4hC0D/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712675035; x=1744211035;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G9H9zOZKYK/+CzZons1CWzfuY9tqxSGowC7Ut4wDLC0=;
  b=E4hC0D/W2ltXvNh+dOu/cotrrlLFb0sicetoF9UAnIUJR2xUE8YUIKLm
   PSaLxk2dx+BotprXRsuIbyHjHuI6fTMPt3Gp9rOlyeKoJ9JSGB49ruZ31
   akq0rpa26vkZ1Po1q94e3oLs3wV/QHdv6f8QBGVQWVnw4IRYaq0QjPNOb
   lgaPwwfHJvR0cUVMvTFusQecW71B3HTj98mju7BfsV72HCD+MEV6sao1E
   Q6ziPXZIISQI+QqSfG4PUybo7MdPTnYX7uhbW5Venzjeycj4BsjCaEMlN
   XmjUuIo95YupMB+7CA1lp++QaReyOdhLGaZUFRwW7c9SRNbAaS4bWtyU2
   Q==;
X-CSE-ConnectionGUID: ENd36+WiQESRXshydlNqPQ==
X-CSE-MsgGUID: 2W4k+CzeQAi9H6OLvX54+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18708533"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="18708533"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:03:54 -0700
X-CSE-ConnectionGUID: 5nDq2gF4TP6XWq/SNj4OKg==
X-CSE-MsgGUID: OeloUF9uQymxVpnZCFLm5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20696087"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 08:03:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 08:03:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 08:03:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 08:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejLfmNgKUb/0XhhxVu1ueuCm4ofGqZyTCqM82q0wvmQvAtXtgT44wCDyUzQzsLUFS096a98paH5QrmWHeOj/jaATK+UJKMnpbwkR14sxqlp2O3yQGITD/Sm2c+1VwyJnP3m/Zh2Tw0oT+A3AHeD5ziRBzAPkRr+MJYVRyVn1BR+pOYa0YchKaVMnZm++LazL6gahtvzGAD5NDoBlfnyq+e6eMIS3G+Pu4Uv0nwoSqkQGzlYIOK0lb6lZTKUPTtcvE+9ngBe3ZImzyQmXFlR1enWTCeLujnSTxWFLg/lqVZ51Gk46jmNrjDWh6jPpKdZpyPnbxpYvAW4V8r10SqhJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODVZ7u2ClRI6PGY34THKi+tGGxLPciabkq/+cyVEZdE=;
 b=COdNRzgW8Yh1IbdmA70YOASdRnOhm5LWFKvujxvZddEksPy5MCzFV0XZqRWjXKS5zpys5p5tBRpwzqJuxkrnX7+bPpLR4LEj+Gve/ntbEKJR6imQB4OWbcW/SV68wLBSidi6Jcg95WP952A1U1XWH5jg/T8MdLfKb5MHF7xgFHga/BeiwwTZr26P4b1QiPqeXrDzswPAD2i27T9ovAtSueqltpoWJHX4jnTCrqNCvDpHvGXLGremfM6GB5GnC0+agCMesNVlBilYOiuqx8oWgR4+k86lHeTWW9WQBDoGvXSGx62AGgsUqRXbaeVw/eG0xCaMcxUteBuGL9S8JT1xDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 15:03:50 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 15:03:49 +0000
Date: Tue, 9 Apr 2024 10:03:47 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Laurent Bercot <ska-devel@skarnet.org>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] kmod/depmod: explicitly include the header for basename()
Message-ID: <kqveepedg22645bfy77qkx6kd5peticn2qptbnewr2cx4uwi2r@vz5jui7rjysx>
References: <embe01a23a-c839-406f-b9f0-9b9dbd4bc5c2@e0f6f3eb.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <embe01a23a-c839-406f-b9f0-9b9dbd4bc5c2@e0f6f3eb.com>
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB4818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJYaCWtHCqLCVJe31lXhHXdfjmxzK7qUHWzu6JY7nlsRBqa4MAJ8tKGEBPZszuK1Pg1T9uBtkdQUdyNj8wJ7dYsZQvitX2Tf7C0S4lzZUf2cdZG75fvIy5I8aEyNDBQV19gVEoChG8h2ccTYK9ljnj82pSI2QJGIpNEzf2bbJOQD3qH+EY2ttNT+D78vqY+WGNfiBhbJCUvnp6raHFB7Sdi7EfS0BUD1ToqrZmuQCZB+hqjYXknQbYlFqRC96nDQEsY6SH63b/n80ds5Y1xz+rHWVuU+k8TjGUk8h8Z5QRPhIkibXQZJqS9G+nHFwEVnH0ij0T9iIsP0LE8R5Bhq2890mhvyrcaQGsys4//415uvhe/5UlOa+EL7icn6g0tb8v1YMojv2IP3y2EyEBbWIZsdfkLbyvPOl6ABiKqTDeuFidaVoVlfCdAitjiz/FdWZXV8fPltLzOnuvrwlmIdet1kf+4R5tHLjPiNnWsj8UPBhb6C1ZqYD6yqx6Y4/aKsO7iQcJ5lTs+qm4yOzY4LEPqPdM40j/jppiBfdyzzRC+jiIddrPwTICFFl9R2T+MrsIdUo4w/PcGeOdLeYK6O/d5Tv/9fqpa+lwzQwtD2+I6Actt63pzktw/g3YKfTzuG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4TPWgJAU4akpzaF1lk3GoedSMNeehEz+2hsEShxeIsLfHee+X1gofEcf7Tp?=
 =?us-ascii?Q?qw3QgWqgco6wur5l+V/xVk9HPJQOYPMpg4xru4/IBxzaABgPyBCyvM97tADm?=
 =?us-ascii?Q?s/TSXn4lPHtdMPM5PWvDzWESCPIrBgFzrDLh89QiYlb5K6E1aGDGSNctKp9x?=
 =?us-ascii?Q?gF94GftpGGcHaWPLjeWn2W3Vdz/SbsfU7gT6vIq4oL6M8R4Ee5hEgmHH4nuu?=
 =?us-ascii?Q?cT8/+rDkSeDZxL+6De4Z8D7ApjXEw6+fXeQVW5hYu7sr83hK1jEwTyEBCgls?=
 =?us-ascii?Q?dkXxOtL4aFiSo73GbNH5nlHMGn9ZFXyRrXlxYaxxzLNRg0DRpTtROiGN17IA?=
 =?us-ascii?Q?nC6WlbkylWSI48Df8qdo4wMAgF4/9lsdsyfMez9FITpEvmUGdLC0L6Gco6wU?=
 =?us-ascii?Q?HDEWQEJdVrKg6OpFLZGteuHB/evs+CKxdvBNfnPuADvdC9VEgllXUfrlvFVK?=
 =?us-ascii?Q?X1OYjsig5fBAXTqFpGjkPdKUa6cmPb9nNXvzxPhbDCu5WeBPqXFDhxF20+//?=
 =?us-ascii?Q?JhfjGJrfNSk4aZv8wdmbcF3jjY6TIEdXoUWsQOjMkR9+CgK4y9GG/WvV0lPC?=
 =?us-ascii?Q?W1vPe4t9RrZsAIKxz+464RE4PE0bVlypYt4unCTm5bmyLsl9mKxmdalawjJq?=
 =?us-ascii?Q?SaIaf3NjJzcS+YBzRGBu0W/wop3ZHxjK7MvH4/jxFqLpXzVEMlb9M7ys9cPA?=
 =?us-ascii?Q?qNG+4+Gul2i9YM6z54x5O7TVLfypSQw8DeYeJptRQHee1zs27sGAY4jWeayB?=
 =?us-ascii?Q?5l/4bcjowiE8mRgSfii11xbN6DvG2qqDWojlV8b255mUoSB/OtIxD3gUC2bd?=
 =?us-ascii?Q?O0QuANVNWTvcSlsikpoREi+OSXEXeVXhUrt+G5JqLhqFpqh7lCJ8JNqbQYDv?=
 =?us-ascii?Q?yoV6NE36+BP65mulyo8dXqDpw3D/CnmymQeO4zrYELMUpaNTGGISGzwfvYXu?=
 =?us-ascii?Q?cJy2YtVLVpk2SBeNuoDOKcQq2cQV7A6/iDMQuE8BpD+nq8VwpQysF5ne1n8Y?=
 =?us-ascii?Q?JF38Dm0YcrSnt2kW4Cws0wyqvqQEcRloCN5WkAWdWEoWRbxAmzDWuPjOP6qR?=
 =?us-ascii?Q?W9q1XoWbVqsB60ZnSKyiGqF/28UQMcmh1krHpG8F/mXaDAtwtLPeScTvjB/k?=
 =?us-ascii?Q?xa1lRiadcStVIEsO0jpMmyXXnkP6fmAYgfrO31LJvFqbAFjKVlWQTzRlhbsC?=
 =?us-ascii?Q?5KeL5vOJ4ikrr2JsZ7q7eRNiMhRZKtDp5/r7PyIkffKXZLPREomQ5aF9adKp?=
 =?us-ascii?Q?kNNxgKHC9ETea6CRFP8tt7bqk8hi7sI814y0STxTxWCWqqsuShu6HKGrslgJ?=
 =?us-ascii?Q?5JNVlvF4gisHmncu5qv2Yg68bewPnFfUXTxOdhtvke3/uaBdSxd1vaRcn+/f?=
 =?us-ascii?Q?XSOu6jNZTpsUtFA3kSiYe9GH7DMvetPk2VJ7FXN06oS9GLkh3c2odgYKGh5i?=
 =?us-ascii?Q?GcfyVE8+5P21EkMz90V52q9zUyLcZLA7tn7NN49ZraALcRBs9lwJOuiGfyU9?=
 =?us-ascii?Q?4uY3ACoESGJF4/jvmLvqW9BgE/ki5ljFhvfJI/yWNr9rTlxZ10fT7/qWzg97?=
 =?us-ascii?Q?d77N1vPpmTAfp2b6whBPA7tfUDa3bgveH+1BFyQOg30cjwzQVaEWeYVxdg0e?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88979d47-cff4-4a3e-619e-08dc58a64316
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:03:49.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDaua+h2t6HKTuShrvrwMgOT3rwh37Oc+UZQ3Ydbd8jPKMjaLoY7v6i6V31XL3VgH3BCGofF4abM6GJOAHwc1z9wLcRElHZN+CBHNZey0rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com

On Mon, Apr 08, 2024 at 08:22:01PM +0000, Laurent Bercot wrote:
> Hello list,
>
>(Please Cc: me on the replies.)
>
> Recent versions of the musl libc declare basename() (and dirname())
>exclusively in <libgen.h>, as specified by POSIX. If this header is
>not properly included, when building kmod with musl, basename() is an
>unknown symbol and will be assumed as returning int, which causes
>problems as soon as kmod performs a printf("%s", basename(argv[0])),
>e.g. in kmod_help(). (On x86_64, int is 32 bit, so the pointer address
>is truncated, which causes a segfault on access.)
>
> Simply including libgen.h wherever basename() is used, i.e. depmod.c

that is the wrong basename though.
https://man7.org/linux/man-pages/man3/basename.3.html

        There are two different versions of basename() - the POSIX
        version described above, and the GNU version, which one gets
        after

                #define _GNU_SOURCE         /* See feature_test_macros(7) */
                #include <string.h>

        The GNU version never modifies its argument, and returns the
        empty string when path has a trailing slash, and in particular
        also when it is "/".  There is no GNU version of dirname().

We only ever use and want the gnu behavior, that doesn't modify the
argument. Which is the proper thing to do for a basename()
implementation.

There's a pending patch I need to review:
https://github.com/kmod-project/kmod/pull/32

does that fix it for you?

thanks
Lucas De Marchi

>and kmod.c, fixes the issue. It will print warnings because you store
>the result in a const char *, but these are harmless and can be fixed
>later.
>
> None of the kmod files seems to use dirname(), but several of them use
>dirname as a symbol, including depmod.c, where it will shadow the libc's
>dirname symbol. This does not cause a problem right now, but it might be
>a good idea to rename the dirname variables at some point.
>
>
>diff -rNU3 kmod-32.old/tools/depmod.c kmod-32/tools/depmod.c
>--- kmod-32.old/tools/depmod.c  2023-12-06 16:34:31.000000000 +0100
>+++ kmod-32/tools/depmod.c      2024-04-08 20:55:03.998592078 +0200
>@@ -22,6 +22,7 @@
> #include <dirent.h>
> #include <errno.h>
> #include <getopt.h>
>+#include <libgen.h>
> #include <limits.h>
> #include <regex.h>
> #include <stdio.h>
>diff -rNU3 kmod-32.old/tools/kmod.c kmod-32/tools/kmod.c
>--- kmod-32.old/tools/kmod.c    2024-02-20 23:10:55.000000000 +0100
>+++ kmod-32/tools/kmod.c        2024-04-08 21:55:03.888577992 +0200
>@@ -19,6 +19,7 @@
>
> #include <errno.h>
> #include <getopt.h>
>+#include <libgen.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>
