Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314E128829
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432800; cv=fail; b=X8Y95+9/khg/uUgm3uzby8HjldATjMX9LUn8AQZdsOkHV0/jc/pngGB4oQBdm9EKJrUNkLz1uQP2tdJS0W0M8QV/NY4fjP9L8V+PpkKDpiQBpkhikdTT7dV6/55ZHBwDGfd77Hyi935DE/jXAOu6SpaMfT2hjk9T2As+IzkGZaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432800; c=relaxed/simple;
	bh=vdR8HhIXuxYyYUy21OhDGes/AzOEZXTjPF8wivcRR2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbXL8wr9I7GMO9Ytro/ISl4LJGYyBdOnLrNsWdmwtU94io9G0nIpUexTzPmynf3MecdRqXn2JPC7t9IErkrq02u5aKNvqjRzrMPMkweUkzjytf0kwbaADW87ZoPtAO51JzkUe1R/WkLDg3A5NjwGTWpMOmDwzIFdIF/+Nnw8O4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9oQuiX8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9oQuiX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432799; x=1745968799;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vdR8HhIXuxYyYUy21OhDGes/AzOEZXTjPF8wivcRR2M=;
  b=i9oQuiX8kyRzH5IiSqz9vybZcgTQed6syi7GOtMre4PZUPBXiS4ASPDW
   6TbZmsWcGSUBYgOD3g3TnhmmvYx49Punanv1Fc+P8gl7e5NLTnGAPcBfk
   EFx7QRGPw4T54PI1V8t7MZKn1cwPVPyxgBOS16emSqB51YZlv1pu6G7NL
   HxkLjM9r69V9A5FrAh65np268DihB6cg8I4ABQoU8EIHMRNzlDs+UsEuc
   qnc+LuqO8ykI4oUR9f15v9DgPLPRtr9lOHSYjstNmis4dY4WYQ6HYpclh
   KdyPI4MKdC+zzcxS1zJ/UsAEDivznRFWy8mCTiRK3/3YaSldvok9o+1WM
   A==;
X-CSE-ConnectionGUID: 4u5pkfeZSjmFQFDgxmHdOg==
X-CSE-MsgGUID: C3UpxGUIT0KDdNnKrL2NYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13046398"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13046398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:19:58 -0700
X-CSE-ConnectionGUID: ItrLynjJT2SJbDfBwZotJw==
X-CSE-MsgGUID: iuTs5uuzSmOuORQhzMDcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30955348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:19:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:19:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:19:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:19:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esYc7BmOnNYyr8m102OyRE7aGiC+sYUmnUlnNqBT1fqUIdOCBPdVDE+9uGhSX104MYCWJXLgPTNY3qppU32OdckO3NGlLkRbXx3VphXd7ZxHsoqRb5CJsA+ARdC19qrZNGHUd2WV5vfvEB1pRCvy3Zk/yPooO0qAxCvzxujqWX2nvnK+eyOAcMXuPrYdy4KJR2DEp34qVvvC+VxOS2ni4uIpTFa5X9IxaqlctodskAhszZZYwbh4fXImNNjysxJ24+c9fQo0wQiUzzuoCH21HsUggXa0mzZT2moVDhdHfrOhx1fiyq40E0Pk+w89mzZEKRUq5aCyGGkp6TUzkkHkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdR8HhIXuxYyYUy21OhDGes/AzOEZXTjPF8wivcRR2M=;
 b=BkR2KjcaE/CvgbQ7h/ZNu4XInfgOAmCozhju0TGzmzdvTWKMyesDD5uCu15bgU5kgjSNx/K2lNCKvUv6FbaSh0Z5loji3BZ7XKXKY8lWFgKL/yv3qKpt3jUagqcsUOveSwpxiJCk9w9eagEYjXo1v9ZNpBJTTw/OiLvK2g3pobVVpyc2OmWlU1Khy8vDokjSrH/gz6h7o3UqZKuDujAURwauSKBS3Eck/m/xdLsAO/j/yyvv/cyYL0qKkv9dhUVGStvLOW13CKStwrWFxpoYShL8hGaUw+iUE3pf/55sbAe9vnjkWDSbhoOkrG40MIiU7E2mTS745af2HQFKQIvidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.19; Mon, 29 Apr
 2024 23:19:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:19:55 +0000
Date: Mon, 29 Apr 2024 18:19:16 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Message-ID: <aispkwr7b24nyaguyxfvnc5fktutwlmovfin4gegmg3aj5h247@rsa7vocx34mt>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe905a6-7110-4f39-dcba-08dc68a2e16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DfVa1NNVC9XoScU1Fs7qjJxmqB/5XOMeRgp1afV9dYeLh58xiCJTXZsI0QCm?=
 =?us-ascii?Q?vwy+HDa7JX6Pz+QfL2xKCkXgyKOhqXU+USYsdPSLDYLDFDYAaIueXNop/9hy?=
 =?us-ascii?Q?AxAeaZ9MnyB8go5IV90YtNVcFvu2MWThyvBMt2BYa/cqFHvayCsFXJvvftdn?=
 =?us-ascii?Q?VeAo4hDz15cOnSGmprk7POQP14hEWTCHhJj296GQqpD5U4KN6QcLW9p+2Gel?=
 =?us-ascii?Q?M1Eg9lPuUM6D+wrEYSONBmjrJbvC8Bh36rfeM8MnTcSG9Grn5PWqo+sHnp9W?=
 =?us-ascii?Q?rD+3Vjd6RUiIUHSfiMhGYuEdGnmEKqYvyXwsE9/+JGY88gKM4OMT+hvNo4WN?=
 =?us-ascii?Q?2SAcgMTjkBymTyjE4avaatHD3skPIHzVPIZ9JH4VXXCyR/Z35ldolE4zXtBU?=
 =?us-ascii?Q?A00+/vDK7FJRSK2xHo4RTREBr/6xhiv+BXv0215NquhhBLl8tnS2QVz4tTzD?=
 =?us-ascii?Q?v1sffIN2AgmPWhi3cS9wvK1X93e58GQTwTtNTDcBTEgqvE7UIJnKPOtXk0qe?=
 =?us-ascii?Q?IsRob7Z4tG8QlCS/yIR/v9Vut4ePqJUQBtu0/rlA9uDMyj/iq0AGSsCQPOw9?=
 =?us-ascii?Q?y/u2Jp7bfibjj6il1qP9Ed6QB2mSLtD7tfCoTbVMSWPXDikfDi3U4LihgM2U?=
 =?us-ascii?Q?XjAvSttaCUH3Fzbl7A+wFl0o4pST9iW6ajw5OZ+hWLcl90v7eCBa5J0acq19?=
 =?us-ascii?Q?e2DKtBthNLMEqdKjKGaT3/3L5BwVq1gxpDLSnFzPDBWKpIUZc4C3H0BEygy7?=
 =?us-ascii?Q?cF4Or59y14ucVBAav+V4lbI+YMAPwJG/zHwPRro2nlkGIFlD3XQ10b2czNxi?=
 =?us-ascii?Q?UFwZ69MBtDFz8y6IiQSXnF3bQJDkCrKHCIsrx8hKrcSa+Ue03H4zzneyrj0S?=
 =?us-ascii?Q?UJDuuykZcyDtyAXQCA+Q6Yxbkkzkll380QHfHPoREJA3aIqs3dLfu+/NVsR0?=
 =?us-ascii?Q?Cg8NCr3lyi+xH54lFaVLcvBmRg6TPqF/9lgcLRyACyv90MECL4sJ4vTjeutM?=
 =?us-ascii?Q?OKi4qO8VZEqj94MfxZTbUmPI9sukhfHYklCW8mNKDyoLooS2sx3I/vKNRcYY?=
 =?us-ascii?Q?GW9xO1v8XOLPJ5E9HhZN8lt3pEU91qSCEZAetfehCNvE0tnlKe4lYmDZdMYQ?=
 =?us-ascii?Q?qsPSnb3yMUMK1agE85ldq6MbFD1443VeYOPqxhVr62n+kll1Ixt6jupuVJbV?=
 =?us-ascii?Q?dnF+6WxD0dqgeon8mTkUX6ew8nkwsIZ5X/DAHpT/sKoA8FcAw45pClqPO5rA?=
 =?us-ascii?Q?1sP1wv1EDb2ALVMjFWFGzJkplVu9yqUIhg60wMy+zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1k+3A63SeFM5yXBWB8tylve1VrDAv0JIfZY46RJAF79xVDltg46ygkmFVJmv?=
 =?us-ascii?Q?nPyy4nsZzPaNl3j18OfCz/wjKWgxQrK5ArM7/GR/6UHJ+eW6kzzFzj4ijbxW?=
 =?us-ascii?Q?cfnVPoRF+38hfFlAlczeXaW3bQnIi2b60+x9LIz9anzm3pua3H6G85l2YA14?=
 =?us-ascii?Q?IgrDO4dMtkcVv8pSKpTqPMRL47xsJmxyFs3FID2DUCJEZils4Mmu+wJMqGkH?=
 =?us-ascii?Q?cDm8CsQiLDl2ZHGPpcxtN1ycQBuaIt44bLRwmlAY83IMBP5iNvwgX1sZsUdn?=
 =?us-ascii?Q?rGc6DmGgYF1ZBQvbqfzcAOt16pT9704bb8uVqT/N+z/Up+PJ4SyJwvuXVA+b?=
 =?us-ascii?Q?o3pwZbPZsBKdSKvE9ZKECRSTm7c3Jjb9mmAgZPVe5GkF9tiuWfnSr/uiOy0U?=
 =?us-ascii?Q?vsSQ2g5KWEpt8MSAlAKcBkKNc06ZYvyuIXhOJDzjy3+dYIU9uOMoZYgq3Buu?=
 =?us-ascii?Q?dQzxCRBU9yXmlswNyPjSSuX1NxmjkEM+233jiMmGpgbhYoURbhmoxM9+B/AF?=
 =?us-ascii?Q?NpPj17wDSH78yt+eqnNI188iGiYXVgeiLA5G7Nc4s3hm4Q+xdRdAGa+3JbzV?=
 =?us-ascii?Q?VAAlinkeEcrRU0nmoHYE/vWiUJc+oXUQ2PcuHbZPyHQ5d8lmOfArzJ5M6Wxy?=
 =?us-ascii?Q?xrtRfJwqLMdTqH5yVVpcKuweWSUjtKwpXKUt5o0Mdq5ic6ytQ3tEdxCiVJW+?=
 =?us-ascii?Q?SylLzL0fTo1sQANz8/GgsfOI1+pRVzoO7IR6x3Krz5WFjArQm4jf+CNerRsQ?=
 =?us-ascii?Q?NKQYBCWgv8Wcn6AUDU2GMPmTdQ0nd6yyfERST9mn7yJuFbcSdQ4AuI7nLUto?=
 =?us-ascii?Q?lEs4jPKF73qcVqX3xRl2O/icYFZtMaXQu3AT+OGtT17guF9MuXFkKwDLY6PK?=
 =?us-ascii?Q?aUkHefOAkzhhVF0Z2H7cXFQhiPDu2NO+eI5HRTh8mNp4rxs8Dj4qzlBeEyRL?=
 =?us-ascii?Q?Gpr1pK3A0j0ePGbE8Fx/O8i8Ka1ancgehiGGzTCDOLhm+N1cVVPyjkz3WrfA?=
 =?us-ascii?Q?e+xrQ8zRZUaLxT1AZ/RXi6x91Q5j+uNnMbJotGuDC5lVh7h8GZeshBqvmalY?=
 =?us-ascii?Q?yxPc84Nz+RQJmI3FJ6lVMXXAxmF/3HhLVtHYM9XhwnWBWj8A/jk01qOYwRW+?=
 =?us-ascii?Q?spTALPmu2LnIhJ51bve44wo5wmiw8sRgJ+q5y+B9q5cUC5v63C4cNFhchoXY?=
 =?us-ascii?Q?9OhXSuvWEZ1mfUK1Kf9HVmY9QYO+U+6Ow9cpCtk0loRjiPXyTMeMOEztpz4r?=
 =?us-ascii?Q?C2eWqqlg6zL9Q4HJP4zcv8szfJVbD+rYjzIdcLDKAO+OYb8bjB+v/EbkYXt6?=
 =?us-ascii?Q?FE/+gBNWImD+uuEdy6klPdYa3oR122XxfC+x0+1fY37H/AAzQOoHvw+KPWqu?=
 =?us-ascii?Q?hQdMQQKMWUunMjMU8396fyEYVSOJqFQKM47sgo+anFZ/xjEjsopCbNB4fYwj?=
 =?us-ascii?Q?XqYy5am3yB2zGZavQz4VO9TWMNA/FJv9HyDB6NhiQwwVs6Usn6f8vbYR5fTX?=
 =?us-ascii?Q?ZbuJioDLgZFD0mTzwbGs6Lhqn5S6xBxxntZ/DJ0H7sIQ+H1jHvucUDBHijZq?=
 =?us-ascii?Q?UrUbDnsHji9lf/wR580W/rFnnDwQueBcgGPm89UErmb96kX9YTEMvm6f+/nd?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe905a6-7110-4f39-dcba-08dc68a2e16c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:19:55.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA23zsLmXjYv+J7lx6uSmoDQbPYmNDcchVYm7Hp2YrTJAx5bwjmS066sWE9nCPIXGC+t6s1R5btGSlFDwHcMr56KthL1qBdqN37F629/dCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Since all the compression magic is always available now, we don't need
>to loop at runtime nor use alloca - latter of which comes with a handful
>of caveats.
>
>Simply throw in a few assert_cc(), which will trigger at build-time.

given the small size, we actually never needed it and could have added
the asserts.

But this gets rid of more, with the loop going away, and I'm happy with
it.


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi
