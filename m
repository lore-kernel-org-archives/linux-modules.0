Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B283A05
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899993; cv=fail; b=QdXvySYrA4m3zCFAaIED+Ylbc2A/tImtJGOp1v5LTj21pzEQQ4LnBAxZs7KqpZo9KAzvg6qMd9ukyghzIQzTMM72qiS0aJAU9g0AGVnipHRpQsafUT2bEzlTp2Cq7pcHU4jgQ45daZ9KuffTk5jTER6NuFl3BsDlHFKEe/qFL4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899993; c=relaxed/simple;
	bh=Pf5IxY3MPFX5TsG4lrYrQgogiP51RuZKvsntlT/zl1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkS0Tm9J65IICKK3jwLXX2pILZKipAypcTF/Py577VCA2Zv7NwTZ6an5xaL/nEsRAogaB2XYuJfVINSCXtYqzGaxF90lUTHBGoouoYq2ytYD3dJMnNvWnq4SQ9ZEefxobt1PweGSjzXb9y1dG6dZ1hp2C+e0lyBIkM6/3rQVZjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmaj89lC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmaj89lC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706899991; x=1738435991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pf5IxY3MPFX5TsG4lrYrQgogiP51RuZKvsntlT/zl1Q=;
  b=Rmaj89lCpmWNlR8XFK2a27Z+NlE5iVO/yp8epsGASCidZP1HzOopoW+d
   kFwxiicLlHIk7wud3mwQif7h24aG7BKMSM6vCcFj9onlRTjmOLN7eSDKz
   nMrIc4zm3UO1VdQjycLOKV1L6s/t8FVjUKVh+8qmPVmHRVY+AMg2lM3en
   e/S031rZII/VJN+T08HQeFiIBAQhtHlxsWyPaCCJFRhLdbIopNi+KUJ9A
   HtNa3xVESINLomzOFKiDWB5noxXm0GkgJrRy+FtrV1tXURQ5fsPUcUVRD
   uyVfl21elA8GYJiawFuHAge0g+R3oweU4eqAcVrXPKnvN2oDVeRlk4NPQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="134046"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="134046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908653703"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="908653703"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 10:53:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 10:53:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 10:53:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 10:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYrNoNlb/IX85buQJI6sPUIFDxAB612yydl+A0XykCLyNkb6wJucsMAuvksmOZFQAsU1LSJIZSHrzNS03kVd4snSkrvyIkddObdX8IeDZ1mqP1+OAFZxLnnMfgNKo4Z5qgjwlLmjYQexIL2KDnv1skzIVJ96nN1qNABpya7a42B27PtA6XEEZPgvveWH6nHC27XCEPMW/TGGnnlAcCqSf4gMCYJQ+Piv+FUsddaGSVRJ0DjpiiCQMZysvCUJgFOcSRAPaPwpllLM6SnOuRBBtaMR/NDnUoc86eTRGYNv0CmK18bwjQ1t5Nmm7+VUs/woZwBK+0oLeNlcD19uQgH13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k4HfcCf0qjYgn86yjpp928/SNiHkNCJNwbB2MKobw8=;
 b=oU/umHTZWGJ5G5nCRbsBMkcWYwSmL3e+Y7QRTbCx0Lx+kUGyGpZ1/9yhTwGYOYlOKcR0IBpq9X0skMjUUqkl47m8PUWlXLIPJ60BtK1oGmx79+ZCNw+KVWfLr492kRrNYcD82vRDcH6mUF9VzMB6JQR3FC1Ykvx+iBkCkkLifh2bTZSQyYNYLXhHEWeiGTI0mhwCUShpZl8ARLzjLRPb3lv/fp9iVOnA4qUYmryyi3HlU41X2FH8d+aCcLUaJsPtvt+6AqmjT70dOqCwgLFZx0XIognZv6yQNU22iq3bfvjSOzeR5RBQBwecUtB+GGkVXK3azglxzSBnYuzsCxNAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 18:53:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 18:53:07 +0000
Date: Fri, 2 Feb 2024 12:53:04 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Message-ID: <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240126-master-v1-2-6257d039a30a@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1c1b0b-78cb-4cf6-e7a8-08dc24203185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/d+fNNdmEt9OHXAGFrXLbpN9wbuJGFu1Yf49teU1Qe6ZT2MZC8894/zfln/gY/LSioGpcl3lbIWzmNkY+gEimqQ+AMaxMz5XTOWN8cNBr9LUzfTKw9yvork9ykmBMaWdzoI8Gg0oE2wiJjZpd/F6gw16GhkpioK1aPSxfV37q7DDunVpNczlMJ9W8F0/i/U6Fpy+HAHrJxAfheSaIT7Qs+jCKQCv0KRoFC1uEs+v8DoidiwpwO74pmACIu2yQ8eeL16rccei3n2ENvgkmWef/rgj4MVZ6ZmKy5lAtkjqxObWvGkBwe7uGH/USOjbJbdRbVsAqjK0cXBOAl2Pe2g+9tS0R6kcn/pM5pjK1SOfnEJ2T50oeWb1aMo7qfxMUGVMh+5F6c6WCw6FAnq+CaW3rgnbLjJk0QQTqj74uLWI0CWssKnqkI1sudmHpcZzGQBsG+RPf2IPJgkJCujbsTAv8fo3KJ7uI6A/DFJEn0eggxHT7epdXiPZVMhifyi07YFGESXwaoxAmP1waz48M/Gj5fMcvYN6ip5sU7RZ59N2pMxgrIgkPucLio4iAO0J5iC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(4326008)(6512007)(9686003)(2906002)(41300700001)(26005)(5660300002)(66946007)(66556008)(66476007)(478600001)(6486002)(33716001)(8676002)(6666004)(8936002)(316002)(6506007)(6916009)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZQj5UYK66fZ3d58JtdYtmNUfFVnwFIdGt1qVd1kqdZ1VgmoGDN0m6XVCuO5?=
 =?us-ascii?Q?aAWQ9fShR142Pjr0WyL+nQKQFVNLOUY8LLyBOAb5qLItJX5mk5jUcVx0LiG4?=
 =?us-ascii?Q?J9FWzi4HWORarTlvkEkBEb7VhBQ/3+92kSKtkJm3pdNzxaj/+zvZY/iTQjxP?=
 =?us-ascii?Q?0E0/Ab3NdHkCb/Ugb3iVZOUU2xO4t1u7ZeKAhoVx3t6VHvoFxUpzPxp6ECfR?=
 =?us-ascii?Q?m/E1290UEJ7kWl7yBeU5vxuDxrDhTmz28iNmu+LkOcVT7qNUrtURAynFF4fx?=
 =?us-ascii?Q?V85nwIEm3zLF5GAt0r3I3hIQZjZfdgfmbunjNwNmZnffWaRTDz1vy2Uq8s2X?=
 =?us-ascii?Q?8HkK+XQ1AHwUap6rsSQUllMeSmGsVOCGpTxqeNVJAFjpw5J+NEmOD1JF/pMu?=
 =?us-ascii?Q?X6eeqbbYpnmJWU2F9BOqgykiRN15fRpPi2N5biYm2BzIxKWOkZz+oRRafjrv?=
 =?us-ascii?Q?ZtPTJwLEqjr8UObr/g7hA0b5qGtsOTRTuDb7Q5NsCXv1jo7GtSro7csNG+93?=
 =?us-ascii?Q?kDBrPTkdFAXZ6deCfwdRh29BH0L+F9tD3ouqhbUawDCkprI+O4AJWcBKb/yX?=
 =?us-ascii?Q?rN877LXH6e2kakwRz694tb+vCWwasEPPvf+KBiSaMvqemCtrgLQyJ/GGfX0w?=
 =?us-ascii?Q?2Ny3RGHMIbAU/ae08uxKfV7/HbT4hhWd1IgkOuXlgIw4ZylzrHGplKqHUhJ2?=
 =?us-ascii?Q?JGmua35Vj6ot8JxDSgfuJLjle5FI5tIJacbw/evwKzBC6MsoizyGvO6cro1I?=
 =?us-ascii?Q?2car0FfSwARrvi+1ImY+r67PpWD+wkaCG1a4U47MZDxWcWqKVfXMpm8WLwgE?=
 =?us-ascii?Q?TUzIjI4BxVqQa4Hp+nXUzud/lG6I/egijGquy7IBTMeqkXAESceDEj5noPsX?=
 =?us-ascii?Q?EaBFOBzwEyE5UVbqoER4geWaDvDYFe5lF61zMj+2kX8wuygjhN/stXLbTpmz?=
 =?us-ascii?Q?jrrm2LihEvoRTQ7zgMV4SWuDQlKsP4v1Hwc13PdUGENsOZEyCj4cqgglMov7?=
 =?us-ascii?Q?E75+h9teBRrrVf/DWVFVkWjnYsD/7kmxTXfhy2A2Gh9ZAydOAZKhq/jYbCGU?=
 =?us-ascii?Q?oN6QTRVWY9pDuP2NgMFpXn1SGT17YI48wQlok44w/ffVVWvvjZ4F2RtbaJNM?=
 =?us-ascii?Q?m5lDIaogYtfTzgWbbkGGhJ2lezebr/ACsE1rrlrA318BS+Aeo+cULUlG1Jlb?=
 =?us-ascii?Q?kk2r0tEL9HpCP88RBWhRucOTRrkrErsTR2bl4yM9MIJCSTSbKdymmEQyCIUm?=
 =?us-ascii?Q?LInvbNUxgA08uxBlsM3l2hRcgphWiTfJVa69DXdpZBUb8r6ry2KQ2QwK4mlZ?=
 =?us-ascii?Q?EJ37Gtk3EAm7h010vZ3SBNI9JmkMBaY6/B2c+5ZNLYV81/j2iGr2nhqVyXfs?=
 =?us-ascii?Q?yKLlyftJ4zb/zajjQkzP1ZGZaGKwpNbhV+iPm1wV7qaUe0V0YY9oR82MvhYr?=
 =?us-ascii?Q?JMLiA1fZHMRJiXst9EKAJ5SUfB2f80fHGdrEhEKbdSihrjsjuXHh1BEOshF9?=
 =?us-ascii?Q?1S5prBIgjxM6ovUURM1DZDcnZ4fQYr7qPizaYXpZP0HZ8BfXe6r9PQQghYcD?=
 =?us-ascii?Q?SeFqad/EbnOgu3lCjB7I+B/gWb0cFgrkXUybRTraqBGVna4AroE00lc0wTmv?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1c1b0b-78cb-4cf6-e7a8-08dc24203185
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 18:53:06.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO3BXs6+xy041Nqgxl9KSrJDJXo4EU2huwyZHdyomJb4qzkfEzOz8enT4aawof2Ka6EvIaVzSYP0fngEPwnpDuuKV5h7B2GyRsyNnWp4Ybg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5919
X-OriginatorOrg: intel.com

On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.velikov@collabora.com>
>
>Currently we create symlinks like modprobe (pointing to kmod), during
>the normal `make` build. Although those were never installed.
>
>Add a few lines in the install-exec-hook, to ensure they're present at
>`make install` time. Thus one can actually use those without additional
>changes. As an added bonus, distributions can drop the similar hunk from
>their packaging.
>
>Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>---
>Out of curiosity: are there any plans about releasing v32? I'm
>interested in the recent /usr/lib/modules (module_directory) patches.
>
>Thanks o/
>---
> Makefile.am | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/Makefile.am b/Makefile.am
>index 4062d81..a22d1b1 100644
>--- a/Makefile.am
>+++ b/Makefile.am
>@@ -111,9 +111,19 @@ install-exec-hook:
> 		ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
> 		mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
> 	fi
>+if BUILD_TOOLS
>+	for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
>+		$(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \

I was about to apply this, but then noticed a problem: I think we should
use a relative symlink here.

$ DESTDIR=/tmp/inst make install
$ ls -l /tmp/inst/usr/bin
total 700
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 depmod -> /usr/bin/kmod
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 insmod -> /usr/bin/kmod
-rwxr-xr-x 1 ldmartin ldmartin 715432 Feb  2 12:44 kmod
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 lsmod -> /usr/bin/kmod
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modinfo -> /usr/bin/kmod
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modprobe -> /usr/bin/kmod
lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 rmmod -> /usr/bin/kmod

should had been e.g. depmod -> ./kmod

Simplest fix without resorting to calculating the shortest symlink is to
assume: the symlinks should be in the same dir as kmod, just like if
they were not symlinks.

diff --git a/Makefile.am b/Makefile.am
index 39a46f4..6df2f60 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -113,7 +113,7 @@ install-exec-hook:
         fi
  if BUILD_TOOLS
         for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
-               $(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
+               $(LN_S) ./kmod $(DESTDIR)$(bindir)/$$tool; \
         done
  endif

does that seem ok squashed on your patch?

thanks
Lucas De Marchi
