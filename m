Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301D367;
	Thu,  6 Mar 2025 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239734; cv=fail; b=Pn70Lufob6UpUVDwClJWpZveIWtIhjJ8wXsKs9c/nG7vBnuA2ak/5Hnv0uNHOsvjwQJaHseZh+mwgLXatyA7NPC++w4bTBy9ogkpxGZODCduWxLEUrV9+hEisN4k1GkBnIEzWg9CDSS87Ic0p5wLhazGGenLwEWCQ+vQ1TJZUbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239734; c=relaxed/simple;
	bh=VYz/4z5xmQHxLbZYRPuXeJex3MbtNd6L8h3AkwrXPRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0jCW7oDSXxeAwwuxr1CV4UKJpOQ74ZL92lmZDLFAmLQpN1qa63C4IOWOoikYFA1ttt+BtAyVoS18Qvx/w6c6uyR3NngWU3Tqc3clEKkcvSfrcEmTXZMfkqhwF7iQh8bGEYkvSm79QLLCToBVISBCsbsewh4PLkljvTEJImE0f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVe9lMMR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVe9lMMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741239733; x=1772775733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VYz/4z5xmQHxLbZYRPuXeJex3MbtNd6L8h3AkwrXPRk=;
  b=aVe9lMMRJZL/RCvewFRfCKYDAzbNnEKI73YQ+BrFMIHapZJsYHZbt79H
   xQoeK0FM7Xvn9HmLMAxdFx0wRiP9rQmMXu507O0hJJMthDQlhBydJ6D6r
   v04bCMqFWXpEL6UOaAXoYsNgpJDIM5UbdIr4bLYyhC6+8aJIHNAnSOInM
   o0pSgwhsQK2jNbZEMCkQ70XdZ65nukJBrjwepoo6ZthoozyXqTgJVXUoc
   0vv+9G8DTPyjzlZ/xQmGS/9CeCv0GTPEt/cEx38DxZ5WEItf4Zci/9VZN
   OuVKCs/mZDz0ycuOPjwhHip/FGw6MJfu2u+6tBNgXVpDd5sLtwM0FP5jO
   A==;
X-CSE-ConnectionGUID: Hky7ukxgT1S8qFTCGW36KA==
X-CSE-MsgGUID: dnPPTZYrS6yqJrHHg2IfzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59644075"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="59644075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 21:42:12 -0800
X-CSE-ConnectionGUID: gNh4fU+dS1aiMGPhPWe0tQ==
X-CSE-MsgGUID: zxP7lfmyQrSLM5OCY4XI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123060737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 21:42:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 21:42:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 21:42:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 21:42:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr6f9SOQikzFuUHx6rDvDJ3coKNzeaHppqEnDrlohVsHcKIKp/3OiAL5tB1enYVZ9KmHHwVOLCJNNNd4zr9HGutSXHriFYYFGlR+voeFK1hLh5YoJu9hcGfQGlEMIvY+Ko1R94ZXPX4pDJp8K0yzbL9Vx5/7aW3kX+9kXy5gRhKpILvSvpy8Zye+SU5G1oEHgjScxlIDViOlS58HBAk6f6DVk5YYpf/bmhTgtaxXDmOI8vyVrFhKNBQLdQmJUBqsspmJbewhh6WEj3qtuoCxd2ACUW8csl63Z0DDhILGF2x6/Z/FcchdVlWcgiULugbg/s9/5ACVKRciLinFhiERnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+k0I+4l5lwswWVE8M+QAMcHqMP8lOy0PEQxEJPA3iA=;
 b=f4pH8h5dsdk8hOx3GEDWuxI69K7m4yxntj2JSzD33QHEmgL8FtcK3SBtT1QRHjsjJ1FL9yaMgvLtgaldgFMDXdLmbWooM+8JvDMQznl6iuyeXj/x/qFc8+aqlgbE6Ms2dfAM39cPeSplZ3TOfMtzXsSje4kKud0eclUOIBJIaDgyOCQBBcsIhLUGTxlqEiYgFQIfq33I2SI8rKRrSTs+fsIbhwnPPriuVoZZBanh09z545td+HauD1YZ93K3MyUpfe0NWPyEL2DcSW72MDdowQsOHYIsQN8u3jDla15wNw3kLhGDPC+21Ut23qE7Vo9GLlNcy2DjMnFpvj5QVPLAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 05:41:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:41:24 +0000
Date: Wed, 5 Mar 2025 23:41:19 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Emil Velikov <emil.l.velikov@gmail.com>, Tobias Stoeckmann
	<tobias@stoeckmann.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, "Martin
 Wilck" <martin_wilck@gmx.de>, Martin Wilck <mwilck@suse.com>, Michal Suchanek
	<msuchanek@suse.de>, Christian Hesse <mail@eworm.de>, Enrico Joerns
	<ejo@pengutronix.de>, Grayson Nocera <gnocera@purdue.edu>, Max Kunzelmann
	<maxdev@posteo.de>, Sedat Dilek <sedat.dilek@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, "Hendrik
 Donner" <hd@os-cillation.de>, Jan Engelhardt <jengelh@inai.de>
Subject: [ANNOUNCE] kmod 34.1
Message-ID: <un4amoqszsfdngir4skk3rpztouptrxfxrd5riiwof4ba6gt63@hrzi233bjuyh>
References: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 40371974-f3a3-419e-2d48-08dd5c718871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BlFhfhPRLlrcEL7xNYzp41tPTfL5jrOJJQajE7XgpUmLd3pg7C18t21oWghW?=
 =?us-ascii?Q?0por5nj1qe0ca+f8733UUzFTkX5JqqrrViXTx0+jdvmhaUlTc3Vk+nWxAPPG?=
 =?us-ascii?Q?JTNoGHXZSBZ/Mnky9uc9Vhkbht9a3kiYoZb3tq39RglXeTSsvX/HiOq/vD77?=
 =?us-ascii?Q?tm27LwtvNfh7ZjQ8q7VvjVHLG5f/OplnRjWeeBy8hp6zZjOLx+b/6HAGi39H?=
 =?us-ascii?Q?v0Jjga3ok1dbciqemNozQagF95LTs76/1cl72YYqGGR9ddsI3dVyX/8k4Uo3?=
 =?us-ascii?Q?/Hz7Kz1AsgeeCzw/EONqvoC3sOCrdczwOruGZVrFJ/sCyHiAY4IMi/xHFMcB?=
 =?us-ascii?Q?68RcSKIs2VGNVFmlBVCs7BwTWnKlgzWAJnhVVmrJ6frrcXcW6cdgwnN93nRA?=
 =?us-ascii?Q?Q1XVq1MFFd46OqV7W3F/Ed39iaIvgiJCcQRNpLvxFPyip7BC5uQubX/sa/pI?=
 =?us-ascii?Q?tPSt9EVSqXPY3U6BC6Z69Vou2//HGD9bhPSFiebzmNdI7/aifSL3HyhC7wMa?=
 =?us-ascii?Q?pmfBJdz3UzyTUlOoiKHfdr9FmKA8fmsTlL0vdK9yXbycjGhy4Galb8wk/CJ/?=
 =?us-ascii?Q?JD7C77iYdF9c/IEO5B6k3AIYyx9EZyCPChK566RshiEMI0Pmp9qAA92dsNnY?=
 =?us-ascii?Q?BYlRC2t9viuVkuEYVHuhnoU7bZYw2hOuJHFq4tiMD4L0+JifvQ59Onkec2vg?=
 =?us-ascii?Q?1YHmRBonAUhxVu3KtyZOW1bJsxxzISU3zMzC1Pwd9UOwE8m/+b40zlnBO1Li?=
 =?us-ascii?Q?YUNl768lcKUokcowoqwrenHr3zx7dby0mSx5Df6UOpCZ/95YTW1tpAXGBOVe?=
 =?us-ascii?Q?ZopnAskwxg3SEU+WSeDvmZ97S4+dsNiwOkzzLHlSUWHQY//qeoorAItWqFqG?=
 =?us-ascii?Q?zlo59kMXt/8x/KtuKecUzNqjbFjl0QYVR78jfW4RS1oy/qson0XVISylN0cA?=
 =?us-ascii?Q?aRsXPUiCvDl7XUP1EgAGaXFyCjlqktu2Np6p8RkUkoak5+4M8ae6d+TFLd0b?=
 =?us-ascii?Q?QhFtrpBzwlYxiuB+zoAdSO7NzUHdWEGp/i8BRLqxQ9k4ht5HnU1iwuI5uttg?=
 =?us-ascii?Q?Zkbig7K0omjVgExTdxlJhoSUp/LxF182puFz2x8wTicCtTEJn1SJezRbssQI?=
 =?us-ascii?Q?9A5yIFLCt7UZrCLx7yTxlKvHpBVzxI245Dup42im06Ioe8vym+TAUCcAw+Ow?=
 =?us-ascii?Q?LTydhAG7wT51/Q1y6AvHKY/iA6Qu5IJGFEbhACxeYVPa709nEDq94W1LWCIv?=
 =?us-ascii?Q?52HgnCPNeV0qcNa1b4Xmn3BgB9+a0aUmqxGfmh/HBtVRDLnH//SQBHN7O9sU?=
 =?us-ascii?Q?b2Sw9Wqc/N2MQ6sj6qQtTXVG8z/biQM8FzPKLgfpf8ac78j+rwOWzFIrSg3q?=
 =?us-ascii?Q?eV5YFfLOzp4sxyyAfqTm0+oH2TEzA1+0h3s9UviqPCXgFN5Jyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1venUHyoJLNa5bRYPPZBlZ934Qeg8FIBf4dwgvZB5zcg+64wXkAEUWlx9Zu?=
 =?us-ascii?Q?Ghfxr5kUkIKTzn4yP8kyD8v9BYV2XVRdH9q7TtqvL2bY8Sg/KH4whnWNbSN2?=
 =?us-ascii?Q?DkWwEnATbrt84hunhSMqQ9bH32I5X/YGoVyPcjMeMRy5mdb++GgMXZjNB0uT?=
 =?us-ascii?Q?zRoaQLwnXM9DpgkeoXV4kTlPXWJgs67LPMbfW0Y7nSi/NM2GU2GECg7BzIn2?=
 =?us-ascii?Q?0o5oF6WGTESUhKfRUpLE7WaZevKNMtFkITlg4OO0b1xE1sze7UKSc2XEgx+n?=
 =?us-ascii?Q?PIu7Yy8OI6+vz98abqt+sd1t53C7zUJDG/8maHtdGPV7Kij2LxQQLGHGSQ7q?=
 =?us-ascii?Q?925RhV/7c60djqqyazr3OtZEhKRG+aVnfYusBdOhqhdOtQpvZHepADVqHPIo?=
 =?us-ascii?Q?Ua8886QDh4aWB3UR48bBAnfkd6Xd9LydpsC8MFA/Pgl2rLMyUgfDZm0vdKgO?=
 =?us-ascii?Q?ZxqboLuM/zHFXTUgRktnv/HfPQiXQIPQrX4Oc3iKo4buLlhdSzvVjejGm63T?=
 =?us-ascii?Q?z8iUUlUqWsVTgIl+7EYrUZBUJx0OkCnuZ99ppj8ow9O+V4dC4zos4AQe1a0k?=
 =?us-ascii?Q?7F/mQ/1E0E/vY43uEdYskBowqoTkYbIre1usa+h1ekhuGoBxQGEXxHE4j6Df?=
 =?us-ascii?Q?ey7LYsZ89Get50VYsiWMjSLoksA8oTTw07Mu7b26aKaIsBMDh731RMkW1JUa?=
 =?us-ascii?Q?cHIYptN9n1iDT0bHXGPaCwMyFy8dmrLK+E83h9K7oNNUncnD+ikFfMyMMBZC?=
 =?us-ascii?Q?xn+LWrxUqXVUETEMQSZ9MEZZXb1nLuhER09HayFyYexpfv2mlj2oPnOi+BJF?=
 =?us-ascii?Q?dhDQ4N0tPTf7FSzpfHql2CqkJtlAZ2thI++qE+g0cksxpkdwD2+MlsP6k2zz?=
 =?us-ascii?Q?oCC5b2isUJj0odJyLLVDnv2HJ0nbWMSpm8VT5gI8hyNqOIpwJH6Sq1/bIEK6?=
 =?us-ascii?Q?fStztVg/nGb4V68bZYSNqgdjKpRrXvz2LBMerVn08EosGnk+v1XKNE1pXKvG?=
 =?us-ascii?Q?sFyO1HOAQSY+YpJqL0Qp6MTN/GFqKvT36jqoJ9WLmMBisEjEdPQC0VJxXDmX?=
 =?us-ascii?Q?yoetCkiINEAMERbW9tXCyrLseUl9jAmiLgEyFNyl52+ywM219lD7NQgOkUJA?=
 =?us-ascii?Q?bC98NIqR4AqYqxZUq2ORDg5yQ3/RvZczvL5m5tvihAgMoCkWrfghPdtugBEY?=
 =?us-ascii?Q?O4F4Q/ZMgrv/BhpnL9a660FE7cAsi3Nyi/cb3mGo9ygcs8s7IPfy8zHRm5EB?=
 =?us-ascii?Q?97Il1PaA9Kc6iEq03Uao6GyVlxlC1rSNKd9L53sFI1w86vPr6aNKOgia3Ggb?=
 =?us-ascii?Q?oXGJPYiCERsZLehhW0s3AZzTzHymdeotJE1dzUkin90lwjmSFD3gY0EVx+J/?=
 =?us-ascii?Q?09OSOArJPmWO4BOh5wLLVxv+0l79+MvvhhCUZJD7fW693zD6DtaULBWZp+rT?=
 =?us-ascii?Q?JGfGO+0II2F0XB7PGeSdXSVma9hvt++Rk2rx+3v517dQZaPpvMYRzcxvczUb?=
 =?us-ascii?Q?3nhV9odQdhh8Hdc9wi/uHBsHTeKzzX2ZDfYP1bNVravzX12RuwpyGW4Tw4xk?=
 =?us-ascii?Q?WXwi6LCv6oXt6ypaQZIEYApCBD5DZhzurFUaEO5PCghP2CVh2qo3vJR2DDk4?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40371974-f3a3-419e-2d48-08dd5c718871
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:41:24.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 099G1HpLYeYnlisxondpqyvgH/XvT1kvNxmUaCuZGCEKBmfJUiBXL6j6ybU4ty2v5tUphcAif24xXuA5a286YKF/sQwWHXH6sAKnu/jXzy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com

kmod 34.1 is out:

	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.1.tar.xz
	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.1.tar.sign

It's mostly a build system fix release, the first .1 we are releasing.
My goal is to mimic what is done in the kernel and propagate the
critical fixes to a stable release, which should help distros to get the
fixes ahead of a new release, without having to patch it themselves.

I will probably keep the In-Reply-To going for minor releases, unless
people find this distracting.

Shortlog is below:

Hendrik Donner (2):
       meson: Use short options for ln everywhere
       meson: Fix setting an absolute customdir

Jan Engelhardt (1):
       NEWS: ditch mention of libxz.so

Lucas De Marchi (2):
       meson: Fix build with glibc 2.31
       kmod 34.1

Tobias Stoeckmann (1):
       build: support missing gtkdocize in releases

thanks
Lucas De Marchi
