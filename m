Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4A1448EE
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408095; cv=fail; b=hVUY06VzJsLA2Kc33bHOd983RsCIad+Ra18BdCSEFz6MH3C1oFKEJo+6Qy60iQ+Z7Go4nNmbn/NF969QQl+F7knahSaed2lJ18qo8NdyLiFCAg1CBv6IkjhB3fySW/Ecd/HDMxN0bGgYLdxMo8L/Hm6z3wfs3glq4V1DpTpKN4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408095; c=relaxed/simple;
	bh=+WMgddwCJmXdeMqbtZYGd9ObzCt9WcFteZgI7YF6juo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q54JYW1OnAfghA8OOAdpn4qBNehSC3v/wIxOvMLd9V5SIG04SD2nbk3fjLm3b3Frp6rd7dh61oSiqGOpJZERYdcbvg5C821I9WTLaMQGYPX/cqqWCgUF7NJByI3j2YhI1tPQo4eWbtaxTc3n7tyWPex1MaGymAIpl29dNkZ5UUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KchLfNBH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KchLfNBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721408093; x=1752944093;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+WMgddwCJmXdeMqbtZYGd9ObzCt9WcFteZgI7YF6juo=;
  b=KchLfNBHrimkAupnogAkn6P4dFWnNlhKXWzSQDF0pj++CeAfIAO+tWnJ
   gO2BeyqyqxACic2XVHknza5GAp1YF0IoCVXAF+DvfKlLGSzkEkVfmMUXI
   E40sBFlcuXkjqNoVh1kUXOp0cT5VF22VlO5oiuKP7TUWdRLeIcKxMagCh
   wUhPaWhDP2dlt0Ra9CR9f1bB9AtOda9+yPkgRsQCAJHVF62K0/CvkquZ0
   ii7vqqqDn2+6mQLUCKM61/UTGkNIDEYbEEhPbjafm3bWYRL888m48cWEd
   31VO0XWYyneKvntrbM+kymOnV6sRTAIoVwRVZ8SZIuJff3+PP/JVwVWa5
   A==;
X-CSE-ConnectionGUID: yKhGk4LQRUyKQDix//kR8w==
X-CSE-MsgGUID: qCDh4L60Q0KiXPCBm7SUdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="29611839"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="29611839"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:54:52 -0700
X-CSE-ConnectionGUID: os3AmrLJQSujhhWzzcbyzg==
X-CSE-MsgGUID: 8Y8T+QhgQ36vvwhkQQvHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="81806965"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 09:54:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:54:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 09:54:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 09:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzs7ms9exLxIn0tglkkbyWMvWpLtkcQ9a1V/+U0nUKlE95+Oavx/6bl9g75boyTLhzWDwoUlCRjeQ8YK4BdifY7gDtYq+SXBk/69RlRdS2R+DhoUeeckB6e14ngvUk0cMoTe0atOAze5lhflSann1fpPmBjxlnXZbZcXYflsKPprDQKLnthFAX6x+Eg1F5HUVhxyp7yjAgqaKqq1AP5m1Wkvvt/S9tqaOMxz2gKD9S/fAzxUIUVPZFRf1Iv5jAIOohE01OkjgxEjjCVImG5+eCg0cegncPteqpg4ipk4nB86vwFwlTDTEA8Bgh5NzPNpeOeZkzDAAuwhnw+bT5Co7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9rpbKedn4FsSWp0Tr3AR91N0X9b5ro3xUN/baYkHvs=;
 b=eYFEVFkiA0DraqrT4BR8OrVeX/OUYXPGINAnLf7Pj8x2To7tbu5qfGmRVKA0OKp+TweeApCK2TZMZP/h0gwRtHBqpKWDjWD3YkAsOfr2jMwFQ83y+/t+mB4Zzdr+q59GaUshMONrii/2hyJtHy/VfZTstFSwXzulODUxq+1G96rBmw7aqBhMuRtTPOh+H6qV4Aeee+HNkE89s0gZGh3KbKr+SYLWDvQpODl54Y8XfrcvITkvgBWgfY++K9AMMKYCD6h9X4YzXmiwFvwd5O6iV52dLEju5Xi6AgYbSpZAXZfT4nMAth6rNuvGR/As9GklOdZZ7+KcNSN8eYdC9bmlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 16:54:49 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:54:49 +0000
Date: Fri, 19 Jul 2024 11:54:44 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] kmod: remove .alias config files for modprobe.d
Message-ID: <jwb2o4bqhqswli2ury4zddvgp6axmudethopjcowz7yp47c4dv@5gyn4245jnym>
References: <20240717-rm-alias-v1-1-58874caf343a@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240717-rm-alias-v1-1-58874caf343a@gmail.com>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f63a6f-ed9c-4968-5aef-08dca8138046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FqArGyY9nomVv/H8fSAYI8UWgodPHkifcceCP5nuhl9EnQeYjvqL2g6/ngbm?=
 =?us-ascii?Q?Mwow5SLbid0gfNanoomWcn+tVkEM9yO3K2pk18nHuskuA73jxnWNslf3mthO?=
 =?us-ascii?Q?pOlTdg12qP0Cz3gsOoRxYZe1Y6FvKtLEBJK9rKvbws1txOixClaDwtSnVPX+?=
 =?us-ascii?Q?56+8MLIIjmVa/Mt/NxAYFwhvn0SvZdwok0mWStqqoZveVOkD1iRdAXhk4ppC?=
 =?us-ascii?Q?ZXk2c4ERtvLxnW2mQP4yvYTJ7YAYvq8zUOC6OZuBjf/c1Duz3ZRsQJoM/35n?=
 =?us-ascii?Q?LwZT8g8fdFG50vW1CuwEmQEtOIdfhTI1gsIvLUcF6Ws2rwwN7fdp/vVVxWH4?=
 =?us-ascii?Q?28VuCqr24iWOLsbdTkVOlqo4vZ2Mu3PaQV7CbhN0TJ6II7tjfZCCPm0LxVPQ?=
 =?us-ascii?Q?0eB5RjhJK0/3AnvJA0c4Fm+HpV7iZT78CjCI87rZkxj22mJ1vznZmiR6++1f?=
 =?us-ascii?Q?xffQ02ZZVv2Q5WarB/1EYCA5tqUDvbwgux5m51pvp9hhSIzWxzS0TwGec+YQ?=
 =?us-ascii?Q?4yJNokXzUlPxKmGHFjmFtda54muszvdLPGYYxZerCPyPE+fPcKrFjKomO/qS?=
 =?us-ascii?Q?rC3OhBXWxpWnjT2/LP8sBEiiI7TXB4XYGfPrMyLghT6E+hkFTPbSqWZ27l4t?=
 =?us-ascii?Q?hk9c4HRRZJcp2l7CP6gPWhlXWEwgQmhTdsv3RnKfkPRTVYh/7VbCmFqV4FQP?=
 =?us-ascii?Q?YnBsRyX28joi2PO5ukBQp7gx+ZA1IY8g1BAdPNNP8qzkDXa6vrMf3R0liC/S?=
 =?us-ascii?Q?CyYBD8gFgsmksE7tN0zgkN2ZJLR815C6Kwp5TCm6jHtjKveTGL5OhFuD3arG?=
 =?us-ascii?Q?oN7647hKCsFRPxDvkyMJgVfa3jrntsgqJ6aCwsgdF9NwUEf5SlI8tBh2ZbvA?=
 =?us-ascii?Q?qo1A/EK7CocrYBG0eAybWCFQXdlVn7J8lJW107808uT9Czrp4oP93+ckMI40?=
 =?us-ascii?Q?To2+esfEAay18kt2aC/jpaIx0jI+ipkLPtabMhE4SY4VEEPENIXdqeWDC7qB?=
 =?us-ascii?Q?JdoUhlM2Vzd1dxexEksNIBVqdLfM4fjfU+bflrHzvNeJDEeoPHzVasTfqdhO?=
 =?us-ascii?Q?zVaEK5rskcdoZizrZq9BGG2wC1HC0VpKZK0CFGpnZotDEXqlZpT/qiTN9vef?=
 =?us-ascii?Q?HjdnO9MvnyDPSbHmHAiyhtkaQ4UoikS7U9tkyYNfQnmnOPovxXHpP2G+1NER?=
 =?us-ascii?Q?V941sC1NwIKlg46JjE3mR4T5tlxxWZ94lKzpsAgv5sVNF4CkAIXjsUfAy3Rr?=
 =?us-ascii?Q?cynIUwW89stOm30hFq9x5AYkFAPrXeS4+z52h5bWJUj6hxz2uxIde1zCDLKi?=
 =?us-ascii?Q?eM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYNFHh4tt+CV7a8KoVH4ZBiWkSN0cqI7DnRNK26Yt8mWqB02yL7CVf3xVs8w?=
 =?us-ascii?Q?5QNrMxP2eTtqITKWd7TDFNXi61Fit4eEJ7MFpxTovd5Xqt/xoAZXW6QEEwU2?=
 =?us-ascii?Q?xeEs7I8cUg8TiNvp4l/j7Dg3s0Ly2/ai9V83cA8ZOU56gEJb+pmID25N/az9?=
 =?us-ascii?Q?vpocOzuosiRREsSRX7+YuxfxWYMLA/OSiCmJKt0UPShMOUg/r2JK0EiegQZ5?=
 =?us-ascii?Q?TAzbT5ruhNG3Zx5jz//uTzXl6NrZd8HChh8t36qKQN9OqVNzqCstCxRKugDP?=
 =?us-ascii?Q?uOg5FOkFZz/wgcXOa9ZFsXvCsierdIlprJ+U6k87klcC0SA8ru0/zdUtnVzw?=
 =?us-ascii?Q?KYqNPk9lV41r8oBrUFKoQgS60npTYk6W2f5aCI+yxNgABczg/nmeNjLHR1Vo?=
 =?us-ascii?Q?Czacg8ejpLc6cW5lu7sVmPHi8Zr5EST9s4JZ8YGi2erFhXBG+z2+Cpb56Wn4?=
 =?us-ascii?Q?CiQa0pk3Bs6xW6J08jZ3Kf8LjOy6jy7zbEk2i8KcYv68ybYF9kSvJ3hr5cKB?=
 =?us-ascii?Q?I8aC0pvL/jqKv2dPlSpag3TVZlPqJc/P6jHmPOi+neElubYHHV59brTxUh0u?=
 =?us-ascii?Q?iChwiA/9TVPRTWSew1EUmjujy1Fej4IP8NR3vPn/ukVd61Dx7sv3jW2ZXagD?=
 =?us-ascii?Q?VZ6R4s/Tk8ji1wQabMqrQ9wS/WZu7Yk0x2A2Zm+hbB8GP/p6qpGPwybNhq1f?=
 =?us-ascii?Q?3nOfwc5kqK5vwMVmfKG8iI4AAlylpsg9asUkTjtkEPh6ji814zsVMfp2ldWa?=
 =?us-ascii?Q?rSJpiPS6CMp9ahqfR514/M5jYYQ2+S9KvFQvX+rQ58xsxK3ZbYBVkLqJWy16?=
 =?us-ascii?Q?YYPp4gwg8HPSFhxhNrVnd/xUDDrr0JQBDWgwcrbi/VxHmn5BASw9Qjn6w5Ku?=
 =?us-ascii?Q?5V+NPV/bAoUXEhFHRgcwfLOzTwU2BlbBU1vyPMzxwd8BHiCQ68+QZHAtfgIT?=
 =?us-ascii?Q?9vIrY6yWEY6Ak5kwK7Zncav7u1O89OmvG6zJ5xsPmCo2N3A2SND7uHqxSvuY?=
 =?us-ascii?Q?dm8nFtmA0y3Cxq/UrgglzfTFzCygf7muQCsiztOn0UksvfhKlwsTAtgyefkw?=
 =?us-ascii?Q?Lyqc3+TcGSuREd9gxV+Qhqm8128Z8v7RD42v+PmJS/J9OikW7aaiseI1Pfmp?=
 =?us-ascii?Q?Oxorl7DT+Q0P3RTRiA798rD7qHz5crqR7od7u17FQHnGhi0uACLC2BRMKNky?=
 =?us-ascii?Q?GwseC28rmu51DGAkak/03nF/A0/R9vI6OhJ/eJdH7Lsxx/i750Z+Jlh5AByN?=
 =?us-ascii?Q?kcutOB/ua9aG0vMXtiWNkSPI7YGtd9P1hOAHtJC6b108mtM6fFhbOKu/Ug/A?=
 =?us-ascii?Q?gFBtpS9P6JOd7gJEsBUWvK9nclO5ILAodazB/BuH+ejhSUNNSHLgrwjkwJvL?=
 =?us-ascii?Q?q2EbHokgTxg2WbPeUoLOLtewfnXobIG8R2FlUDwAYnO6+9XmRRof+05gGdx/?=
 =?us-ascii?Q?mYNeNKGDF09PEDZ0ceE2w2cinGbK/5Veligq7dUdi3v3e9z4ipdpFqg65N88?=
 =?us-ascii?Q?SJ/rqINd8/S+gO8jYQZj6cy5ZGQmzONtHL6YoxIxBiov1iOj3XkyOGTvH2xE?=
 =?us-ascii?Q?ta+dchioquyz1jQlI/Eca5x9oAtEli08TB8Ck043qVozLPJ8SIoWXSGvoB7A?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f63a6f-ed9c-4968-5aef-08dca8138046
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:54:49.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgQVZmKNLilbk4f56dA5g22EpTluhUZEDqARXa17S08n+5MlV2sA4cWKz5ZherS9AkqIIWqWb0pmW+JlhTdW0Fle5eUxRvNbAtdSztaxeZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

On Wed, Jul 17, 2024 at 06:26:45PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The use of .alias (alongside .conf) was added for compatibility with the
>original module-init-tools project and has been living in kmod ever
>since.
>
>In practise, all the linux distributions that I can see are using .conf
>files alone, as instructed by modprobe.d(5) and the only instance of an
>.alias file is the modules.alias as shipped in the kernel.
>
>The latter is already handled by other parts of the kmod project, so
>let's enforce what our documentation says.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
>As suggested in https://lore.kernel.org/linux-modules/q6dutb2b5ztkuwjkq7a7ddnsbfneoq66bafaaxwppelepflcc5@us5n2ll5syja/T/#m84a542f8d4e2f4d31b2a7ee82aaf3d0bcf211aec
>
>I have tested this on my Arch box, alongside a normal make
>check/distcheck and it's working as expected. Other distributions have
>not been tested, although I don't anticipate any to be using .alias
>configuration files.
>
>The section in the README will be removed shortly via unrelated patch.
>---
> libkmod/libkmod-config.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
>index a571b6b..fb28ed9 100644
>--- a/libkmod/libkmod-config.c
>+++ b/libkmod/libkmod-config.c
>@@ -940,8 +940,7 @@ static bool conf_files_filter_out(struct kmod_ctx *ctx, DIR *d,
> 	if (fn[0] == '.')
> 		return true;
>
>-	if (len < 6 || (!streq(&fn[len - 5], ".conf")
>-				&& !streq(&fn[len - 6], ".alias")))
>+	if (len < 6 || !streq(&fn[len - 5], ".conf"))
> 		return true;
>
> 	fstatat(dirfd(d), fn, &st, 0);
>
>---
>base-commit: fa715f8c8b78a09f47701ce1cf46e9b67a49b8d0
>change-id: 20240708-rm-alias-288013f86456
>
>Best regards,
>-- 
>Emil Velikov <emil.l.velikov@gmail.com>
>
>
