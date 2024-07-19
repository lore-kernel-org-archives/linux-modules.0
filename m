Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC4C8C7
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408461; cv=fail; b=GT7GylXN2wheZiPqQQnnycs6K74o8Hw4f5noMu8arl2Y6ofThhN7de1XOv8aPQH9TOkGi8720i3f1+ERtAtmyxlpA0jbf8RfW+C6JIEjrZJT/eekfdAWXYfOnUCIFaSuti5XyQz2skTUE/wv7WJbmBMFcsKvLBufdTxgx+hTqfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408461; c=relaxed/simple;
	bh=HG0mo3395mVE5oDsmp5WYqKDMxgew26uuBy07XXT7lA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2CHU/gawMZgrIZQrNCWIIDvq16mXFy/Ub6q9Q2aMdMHYzxoPR5SorBHO9JlQ3nhjTExZCfnrvXL9HFOdM7TSevIB6kK6ZgQJV90VF6o3E2M5SAustdhTHm44XGeWN8YunSM2hepHQZkMw6GHxKYBBbL8JVFnHN/qP2r3zVH2AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJgx22qX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJgx22qX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721408461; x=1752944461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HG0mo3395mVE5oDsmp5WYqKDMxgew26uuBy07XXT7lA=;
  b=UJgx22qXgPJUdYsfjnKlKmyolcT5bB7QiGsThMJZRu2AUXirIqvzNZfK
   1WY87nZ4zpZYpMA+uRbRSsxfM3z/4Fr4HibF7fVtjnhIW8Vd8XsotYmRZ
   SaQnWZ3NlPwMMl/ImCnGAF5JVO8Um265G19zooDl/SZt86HTI6ABrjvRc
   ZpETeU69wAC5Kv/wK8IYLFHxisiA57gV5zrriOo6Bv7bmKbMlOkHcXHfH
   lKYYGA3M4y0PBw0yc1ulsWMouFnjECE/heGp/xHFdJtUAyaUHXbbvkZf+
   UlMrBH1z3uvuDbpxxMqcMEmpnLxI1ArXy6PnJu79HqyzPkCYeDnydxf1V
   A==;
X-CSE-ConnectionGUID: n8saEwkQTvm40jaNGA3SzA==
X-CSE-MsgGUID: s4fZRtmITfKXbgs5B5tT0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="19150737"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="19150737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 10:00:44 -0700
X-CSE-ConnectionGUID: qNHfStqTSsCZMAJSz/J76Q==
X-CSE-MsgGUID: Yq41ixeJSDiRc54e7cotyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="55366568"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 10:00:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 10:00:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 10:00:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 10:00:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 10:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNrM2U0enkoLou7cRZs8RNyJwey0DvSwD1TWLP7IDf6ZE+/OKEzkm/FptSdkufWFmqBbkOCly4uFrthu2aYpQI3GmzKKLUreMha7SbahrnqeK+MVZGn6ypMHShwtqfTxEvtnwbr9SXwia8dOjXANFwLdt+pGjailj00AUoLTuLrM6IN06MSJSlhsohcllho7jKHfkdTHh6k+dBH0uYOWKghl7orsg8CbhvOpBe6jZPwZSyhO7keMRi2BDWpzJBK9i6ZdHTKDAsYa4fpfP+NhH2ZzxjJMHkPSiwjHLGs4WDHw1rPiUAHrIUkENJ+h+HzGP3rkpmlP9Iuj0yrUHGyO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj87xpy5gA3c2hp97lQi+sfgbVbe4x9gfHMI5m/tWJY=;
 b=hPWWWOTjdLMCKcBO4BVlzZzZiQ28CY+Awu8APJwoeubnZ0MNjEuh6TgvsUe3nZoBbRme6KQiB1yFzZcx+Fwn5C4piaR0vI7qrvIJpU6Ovka61ttQ/6jkzy6Md9Ob+41EDjiGsyL8KO/NFK4FHpONubeTgz93ea10l9NVaRpFQzGdSlM5zzA2VN7axZwr+7ZDnWAsSNVIPbj4v3uIPouBIaJz6j3WGR818RKiyRx/fXS4UqtyITbB94pEliXCkjUz2kHatAKvYuTACvmhExiz48oehx8Tyy6Fq3Pr7PCxcFFC98z/39UOT5sgq05yTZgovyqBxLeuwcM101dKa+m/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4995.namprd11.prod.outlook.com (2603:10b6:303:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 17:00:11 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 17:00:11 +0000
Date: Fri, 19 Jul 2024 12:00:06 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add distros to github CI
Message-ID: <fq3chgzdrscwpiuthmueqonzho3rnwroznltd2rn3b5saavitk@hgprzm5rgymv>
References: <20240712202011.906033-1-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240712202011.906033-1-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c27633-17bb-4910-8703-08dca8144052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P+ciObYuICwO1p0AS0uP7eJNef3MfT35s5WS7bvwOnTpw/DReBExuLh3+sFU?=
 =?us-ascii?Q?oLWbK+LGS1vKKQu2pOISwnPFlacYFQpOm6wSJ1JZo2nBWTZKQntrGuCiwqWC?=
 =?us-ascii?Q?i2gYnbJSQMpFShN/rtSNcqz9+GLt1PJGJZnzJrAoJfAHD0wj+JfaNfDE3g3U?=
 =?us-ascii?Q?U0SSP/cMrmUfaQdnfZVdDKIYNivcn82YQUP4X4EwY0GA8LkugNRv/PMza7MU?=
 =?us-ascii?Q?x0lZhBZzJ7G9Y8pNw0343lO3PaFpushcx76ZG6dvXmQsAQpA0fWDC5ziuNjX?=
 =?us-ascii?Q?wJiCrO0iYGLkt3ruvm+wpGvPzlwWxXElteFcWD/ebYdTy7kddI6VjBb/kobw?=
 =?us-ascii?Q?t6/iQ7Dm+3TgS+bsAOnmMIzSKQgNjgznQlbOwbmlzO5cWYP+sGhPe/Li/xkw?=
 =?us-ascii?Q?osnqAexjbmBmDV9gqPHJ/n02GVpObX4Q2n4lmka9naGLN2pxsIDX6XDs98Zw?=
 =?us-ascii?Q?vmiYHUWxJvGNfURPPeW4Ym56AkVHWFqN0SUUJaX0G91QzjFE6rCcZ+O0FQ7W?=
 =?us-ascii?Q?+r91bAsTNlUA9AlsogYG0Z93gspfKx4KD0SXrUy6seT6ZZM8jxF32h+eObcH?=
 =?us-ascii?Q?b89QV4slvfcwF36qtjK4nraOeGxx7XeJl/0Gk/gymQsEt3emZdh/IZkmU7x+?=
 =?us-ascii?Q?u7LZ1IaZA6fgcafkSyzbyHjZ0zmIfxDGcWVtMA1bzYQ4OgDQkzPUcixkFDuw?=
 =?us-ascii?Q?z762dAdrSQZvUIrHmzlqEXKWNy1UdgOONMJ+Wpx28VOiHAjxdIkSQTTE5Vga?=
 =?us-ascii?Q?3c9Dfa1KHKYVBCWZzqVDVor26UgZ4Z+Ly428dKeQRTtHdRsH2DbxMZJdzOL0?=
 =?us-ascii?Q?wkAL4IWqNBGt6XESk6cKUaqy0/df37E07lBaJHJlvZ0yAYsmSNq/pmilSmxl?=
 =?us-ascii?Q?3Z2wrhKj/iZnlBsbB6hTcfLHHga28Uc6vWUDg1aMSTiyu34Ow2zUb+BU4Zc/?=
 =?us-ascii?Q?GFH95xbbn+eBdpidKqXx3PtUxAwxULBbgZ2PM8txdfzm29gMXXN59ZlyGi8/?=
 =?us-ascii?Q?SHgKFG7/cZ5RMHfdywBwgPTM9P629soZPSJEkDPY29QT5TJoEa5BDUv8S+vo?=
 =?us-ascii?Q?mFeSAdau9gqaM/JdIEWPPpMMW/+hyWYNc739U7bdtyhDoVlM2sTUt+3wgRbd?=
 =?us-ascii?Q?Ro6Y2WLnhK4osiv7QkpZfBF/0x/k07uvFrGdlkeuA4jPEtNDal0XwQD08JMt?=
 =?us-ascii?Q?ZFp3C2y8f4If+3eTjx806HRRsNQVwXoCCPhmA1mibg++9PHxbwpQQgPBfwcX?=
 =?us-ascii?Q?+bUCSWCkD2D41UkTf6LgmEd5x1WRpDcIAC8PEY+a76MShMLxZQQ/bIFDgJ8d?=
 =?us-ascii?Q?nJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETqDkMdfahGLTiyh4lR44TFp0Va5C4nCSB2SbX7wJNWtaHbZaLtu1TpPDpVu?=
 =?us-ascii?Q?eFAzOeLs1NKapjUD33RyAUfEvUy8brqRpMDMObOZLayabRM0etZGyWrKNnLd?=
 =?us-ascii?Q?GvkEuaqZZQnDTpukiwiPLATigO+XpEb15PCztvDurpcQMPEelMbGxQXKCWnh?=
 =?us-ascii?Q?tEsXp3a3c/jMH9jx5/ow8xGV/cR0SLfTy7p29vWbDz5hsSw0fUdPa0ExcnRU?=
 =?us-ascii?Q?4jlwW3286DKQAuXqDg6FejiffqUME7UWA5zqguNIh4NIWgDEfVY6uFqj3xVS?=
 =?us-ascii?Q?fkuYw+dgfONnuGcwwKS06bsjHLfJmlbW5T9RWOAdhI3A8e4BWdCaVEWCO6K5?=
 =?us-ascii?Q?6YuRnw1t70thbqf7f3Ztxb4S9nKdLDH7iAug+7xF1IzykA9hMs57CEWhZETi?=
 =?us-ascii?Q?rHszOKntRxMWoXP1vz01/+RrtOq11PBrsg3Hf2ubQ6+1O3CoFGXvZpZTHKnh?=
 =?us-ascii?Q?uxP1omEIqgK0c+ZU5B2pd35oBWE8VkdHLmi75fBe8o1If6dNHJttj81Am6/+?=
 =?us-ascii?Q?6vGj7f9JkrRh6L0ihc2K5yaGLcNVpBiqY+1FYZv9Jvrn/Yez63iFMOP15ReX?=
 =?us-ascii?Q?8WA+930q8pfzicfpnPIt04FLP8pzy7UTo2QopkWa2+oA1MGL+KTdKwqFsBZ5?=
 =?us-ascii?Q?AAGODw7ZgIKM405ztR3WvyMo6l1oBQ9IdywJ3hbG5t11psHa4z+a06DpJMdF?=
 =?us-ascii?Q?8m5BDhl6ZVPe13tgepAsaX/UvBcOCEEOOLMSiv/rkwHBtP8SOVyskGHNpu02?=
 =?us-ascii?Q?Nw/AlOUCRG2vju6DacCG4gULAaGwRgw13PKD7l0gkpayjnWYP1KD5TbrZ5AO?=
 =?us-ascii?Q?a+/043g2qFoHEfgSzlTBoNcC8wCBD3soundABuUKkQQmGSstvMlednwUn2n9?=
 =?us-ascii?Q?J9ieYWypuHZmnvlf6zRLvZBXU4LJ4lkuQ0b3J53G0QbwxyyQHoYqA2wAYPUx?=
 =?us-ascii?Q?8T/f/iNL+bz/7HURFVbDdOZ2qpoR8KmdNjH8BO5QduQNe3UqpmFb+a3w9FyO?=
 =?us-ascii?Q?k6rfqngcwegmKwEaIXV3ftFVTUMAXI8pk2TcOOGj9xwZqw4O7egfij/sAL8k?=
 =?us-ascii?Q?gAHgP1huGZ/NZ8VpH4/i0/CcwiYAmJji1CjTWlKrELkyEGgdkGbL17Ahod3P?=
 =?us-ascii?Q?mCcxLSIab4t4ToSUZbQkDw+zRgR2p2PFAwbaCJaCteUXoImJthEMeyltYRF1?=
 =?us-ascii?Q?Sgw4SQ3W1yVO4gxQOgPUmtM67fFpTCk5hBC+B2Rdt2wnDarJq81wDVLiEOIV?=
 =?us-ascii?Q?dIgTRTZ+5abltl4YLGw7omKvsSb3lSWU78mhftW/aZ/AqOegRKfnKRC6qLtX?=
 =?us-ascii?Q?jJxZ0hjx4xF9pQNuCIFYFI3sHZr0baxgY1nAijpN8KoSTDAzG4AbH26/aQmi?=
 =?us-ascii?Q?3VZraz04Fpf08Klhkw2S7LSG+6bsmpZBah1c/f+Xov10lobeK1tzT2Sof1/k?=
 =?us-ascii?Q?Y+MrY2PbPl07MjgLNeGgFdXuRlGkOB6n0ChnPpGOuD5poQgG7vaEsshYD2/+?=
 =?us-ascii?Q?y3MeZVhsfXLhgoj1esRPuN9UikAHPW+gLs9QZmO7rq1depTUvGR2G8NWiIHr?=
 =?us-ascii?Q?v+2DEjmz6U3n0EBaOvOTm73ynkzdztdwfC0Iv8dgXDST6ZDHHReDBe/0gs2B?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c27633-17bb-4910-8703-08dca8144052
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 17:00:11.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr9PnF6OMHCXDeEc4vshVrzEZ4OormrZKryZC0dxIDpDCJXKMe4bVCUsZl/cHkWmx+lYcV2R+Kdj+Fk9uGTSFnHRsMQ2Sdh0ic40B+jgKTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4995
X-OriginatorOrg: intel.com

On Fri, Jul 12, 2024 at 03:20:06PM GMT, Lucas De Marchi wrote:
>Add a few distros to CI to improve coverage. This is now executed
>on Ubuntu 24.04, Ubuntu 22.04, Fedora (latest), Archlinux
>and Alpine (latest).
>
>For Alpine, the testsuite is disabled as it's currently not working. It
>can be enabled once fixed.
>
>Results:
>https://github.com/kmod-project/kmod/actions/runs/9913631414
>
>Also available as a Github PR:
>https://github.com/kmod-project/kmod/pull/44
>
>Lucas De Marchi (5):
>  ci: Replace package installation with local action
>  ci: Use a container and expand versions
>  ci: Add Archlinux
>  ci: Add Fedora
>  ci: Add Alpine

This is now applied. CI results can be seen at
https://github.com/kmod-project/kmod/actions

In future we may work on import patch series submitted via mailing list
to make sure all of them go through CI:
https://github.com/kmod-project/kmod/issues/52

I also added a bunch of issues in
https://github.com/kmod-project/kmod/issues, particularly for
improvements. Thanks to Emil who also added some. If anyone looking to
collaborate, feel free to grab one and submit patches either via mailing
list or github.

With this I'm going to remove the TODO file that has been stale for a
long time.

Lucas De Marchi


>
> .github/actions/setup-alpine/action.yml    | 22 ++++++++++
> .github/actions/setup-archlinux/action.yml | 16 ++++++++
> .github/actions/setup-fedora/action.yml    | 27 +++++++++++++
> .github/actions/setup-ubuntu/action.yml    | 23 +++++++++++
> .github/workflows/main.yml                 | 47 +++++++++++++---------
> 5 files changed, 117 insertions(+), 18 deletions(-)
> create mode 100644 .github/actions/setup-alpine/action.yml
> create mode 100644 .github/actions/setup-archlinux/action.yml
> create mode 100644 .github/actions/setup-fedora/action.yml
> create mode 100644 .github/actions/setup-ubuntu/action.yml
>
>-- 
>2.45.2
>
