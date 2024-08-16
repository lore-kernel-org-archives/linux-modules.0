Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345CC1B9B2A
	for <linux-modules@vger.kernel.org>; Fri, 16 Aug 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815528; cv=fail; b=YYXvXFJknrwgdra3LzBrzfMjI7YgvTd9zKgYBc9I5IWkCAbzJU+9ku5uFEir6yr8KwpYNXnJOXtAzed9ut3X7z0/Bi15YY7p04tI3wwFq94huENcp4jQ24ATB0rrihxc7Y3lyhnNzwb1rr7jVkQpuxFzT/z7+GSi/L6dIO0+UMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815528; c=relaxed/simple;
	bh=qAhtvc9vCWUPEqB5+UHVYSSx/dMwxGgJ3KOjwVnLbcg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B16ImA45JLD3OA/jGszqO2HDOmA67mD/xrrOabIpupIcb80mjLacD9XKnl3IqsE/kVQOVWfxeDjbmoQIDRGWPxudFf0MERLAYWTy91TnYMJ1vrZL5b1sFS6IuZXrlLQbpabDD/xNHKl3ESaJVpKI1Mkl/X54LoSXTjs9ZRC+UJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwUwIMVh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwUwIMVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723815527; x=1755351527;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qAhtvc9vCWUPEqB5+UHVYSSx/dMwxGgJ3KOjwVnLbcg=;
  b=BwUwIMVh72Gqebsh2RSFBQfY1yQca9xF1xGweRcNQngSQAG1xdEDe7JE
   4IUYf7aj0zBzry5h0zLIXylBacbhyySzCr1sYddR1VqaGGZljuP6gCj8W
   SkPpvNNIM10p+6xkxIt1vgvL4czDg0jHY14zw2PEOG8qYL7ySgX8WQf8r
   5mSlTyW/xtLPl4fTwzmiEHt1o278qTK73QIK7/NffCYM/SMDWKud55FEg
   JjBgAOWEvueM//wa7DkoI0hC19xWHlBoRId1R88lptHWgTZoRKuflSMIM
   0UyagD13DuMgMxjAT19c1rEyw2r3NNWUAGz0EhpXzxgj4/uYT2uvSsjrY
   g==;
X-CSE-ConnectionGUID: EDucP22cSLuYhjuhDF/JEw==
X-CSE-MsgGUID: QKBeDdKrRbeQRqbKBLdXiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25012551"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="25012551"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:38:47 -0700
X-CSE-ConnectionGUID: TpdcKMPHTTyPnXtbyWNWng==
X-CSE-MsgGUID: A+Dx4UqiSLCeGybpqnAYqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90451804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 06:38:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 06:38:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 06:38:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 06:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgiRYVW3fnkPt0PHfjg39G2jUxHoz0CBKOmSSCDGTicEGZ7yYLh6D/OWiS9SHQxV/NuNXb3eMjz8VwX1t/TPaHOHEYfynDkZV7lLL0d3HBvTbG/A817ntvhYJpu3HpktvJn18e2gRMG9U9boMnJUhTkzJDO0nZPXG+F/PKeidnbloZ6VaMqWC12rDgQ/K+prTnQd5MsUSN6prorOU5s5XAE7Hmg/tbUZ1klRYNeaI6dZsRXqK78juouG4lAe5nzNshosmnhiZI36AuItTgb6/Kev/DS+mvomyqImdvb4KbNIXYHRDTf7J7tY//s4PW0pNaIj3VOlTMCoBhir7W4Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6AAq9kohNH/yrF3F2CxQARXR+xUtxBJrCFvJhGLmvI=;
 b=lJ6+WA2xsgz+fPyXzshP76Gi+rSFnMUb/i8iyDIK0fpxk7G7duGj3cmyDTe5yL0sMJ7Fo6IbMw3q5K8rd39oqffi21sV3Vu9T7Y/YbMQR0u4SB2vNTu0fJJ7rsLa91mn5gkzFtUUOHuZD5nEp/uCk1/os+vehZ7woEIzCsyczVS3Hssc0K9nLovCph5fRYozggvzDnxzWAbxUb/kUUN5VJPxkyUnyPbyr6y3jf23tyWqVE35O+nyz2wxnr9vTv2zna6uVniOgzWLKAeXyLpWRhjLrNpsX8Bp/ys0G2OxMsEk/jjVDVNIJNtq71ruDsnYH1sleQlVXJbzRvwN3FJSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN0PR11MB6278.namprd11.prod.outlook.com (2603:10b6:208:3c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 13:38:43 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:38:43 +0000
Date: Fri, 16 Aug 2024 08:38:40 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <linux-modules@vger.kernel.org>, Lucas De Marchi
	<lucas.de.marchi@gmail.com>, Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>
Subject: Re: the prebuilt mod-weakdep.o is missing
Message-ID: <mngwezxuvjt5pj5lcayhipooxxk2zyailatrhgysyqa3xye4at@ylujurf3ytjw>
References: <Zr3A96SfR21UjdL1@bongo.bofh.it>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <Zr3A96SfR21UjdL1@bongo.bofh.it>
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN0PR11MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe7df3c-abae-46e1-dd33-08dcbdf8beec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yXOnSyx2OxyOS7HovDf/qvrErdlmgMxPTtbMKIDivPcrfwdrxnCiY2Xk24WM?=
 =?us-ascii?Q?noTuNsnD06rU4eEguOzg0SEdjChSxA4vJkWk09r21H8zEyVxQHGLVQiLiyWb?=
 =?us-ascii?Q?aVqgyb5QIJY+yJfK42aFYkBUKBc7B5eo0nzcj2U3jFseV2SKXNz7VcJwyjJJ?=
 =?us-ascii?Q?xJfFFRSl/KDGN1FloAgCAGKj0ZMESF2a+mLhbdK0X+Y6B7dEd24YfAJ7sEs3?=
 =?us-ascii?Q?wwFVOzSTQqo7Sx96TWcswXx3Z+hpjMTdDJuFHsRtrSOCkZxpzrbBv3Y+VTgy?=
 =?us-ascii?Q?uxQCBybNx1cLeKXckI4wDUu01S+aQHzqyowbO8X+sxycnk3z3dA8ZVMN2f8i?=
 =?us-ascii?Q?PERacbwLgLFpTi0h263HPoiXr0s9UkPaSRpoXKPp95e6KVRhhic5n+4cQUYl?=
 =?us-ascii?Q?4c7RE+CinOJEYOnExDJnqPqTTjCAdy/5XbeqF48o+p5rvpVt+Rpc8z+U2EjL?=
 =?us-ascii?Q?GsMDs9pMnO5JGQJN58RQRvcDLkG16H0e7GKhfrHh9rlGGrccZmVFo4aI7FuT?=
 =?us-ascii?Q?dj05x0DvxaYyaa2d0CIlLsX6qTCt7i85gRNwhkb1+fLW8uUkyuiZqfccwTiE?=
 =?us-ascii?Q?4h8VIkG+xa8OfA/IslBcgRF9YjCkQ4HyGFqaNUYEBig2sMXF0GwtaOvXsrrv?=
 =?us-ascii?Q?V76cpcaj+rxkTWOdhIGlA8O2RywJ6vTk0RKPYSnQYPfPafyaWBeTbmyjPecQ?=
 =?us-ascii?Q?rVLi1Lh/TgREimgwkBcnlIZFsI/tGky5ucUjEXYewB+9v/zA1J2D3ciuLLBC?=
 =?us-ascii?Q?upnwxYjye9ERF2q7aklSXV5aOOBWoO56eQLBZtA/a8FZQM4/OdGSlkQzv0yY?=
 =?us-ascii?Q?r2KksOThU6+Eae1Y4gt5RkTtCYQFifvVqIHZxgpUDgapEiiT3j8CN16A11ar?=
 =?us-ascii?Q?lUhy7Va3JfQAhAWs6LLgKKJnWEpyXQjpzm84T3zbx48Qa6c4eomQ7dqUp6MM?=
 =?us-ascii?Q?8onyWZGVX9zteBYfnv8FcZ0qerU2RXzVuf/sdAnplCm9YVEUOtn4EQtMXJxt?=
 =?us-ascii?Q?yxzJstjzSzaMZ6Frkn2OjvTILBvonsqCpfYI4oEnlAuCOVi4X3/D7DunszoX?=
 =?us-ascii?Q?z6J2T7tl6d1xOpIHs/FTv38xjzOWCXYgouR6dxX+bamu82XHrAE9RaSEaNCo?=
 =?us-ascii?Q?uzxBtSWGU33yw7cpGnkIdrQuCmuYNNr5L2eH4E0NNDJiOlbkaBqYFhO7LaTR?=
 =?us-ascii?Q?tJzn8QyB1waYD91qTUhBO8gs2hs604mOfdkrXUDAyXFOAW0jhblIghNjFAm0?=
 =?us-ascii?Q?ah4wWgOaLCsS8lBNhs/ba1Iq0pcKJYX0sVI2/NFhazGeRbXzRNlkJFmUXAK8?=
 =?us-ascii?Q?U/73OKW0Uw4aEtDf6Sq7/idF9C4aCkFHSSggC89jvkZIeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oR9pV2h427fr7PWkWZstoLEhwuFfqzv778mnXU5U92OFnOYzOWS7z4Evk1wP?=
 =?us-ascii?Q?FRLvnmzA50UL38QY+ksESECs3TYmMlo/FCsYRfkpCjb/Q+SwjsuwvsDWoH9V?=
 =?us-ascii?Q?io8iiiuPO75QsK3XEFi7bIXw/ee6CnYeVZE7ZSdBfVvau6gIYxGzgO7lIDkO?=
 =?us-ascii?Q?8flXMdS2ZpMP7JvdYdMRkMnKZ8T6YkiGZmG9EB1hGlMy7RE/PbRgb44bUazY?=
 =?us-ascii?Q?MDA0yIWxpzSQeXltsj9f9XCdBjmmGXJnQJn27TRRuXpUdDiuI09dTqtuPbOQ?=
 =?us-ascii?Q?omgDDIuEyWc6JPL5sJUL/lPT6fka+lGBcB7uck5UTOvKk8qxAHdVwwR8fsLO?=
 =?us-ascii?Q?XTeSi5caUeEEJ8oDfJ4fsnlz/2CV4fWzxB70dZXjTuWkoZaNccBHmUiAsIg3?=
 =?us-ascii?Q?YTywtnbubi5L18nn/gGD/aGClidWRT1PfvE/IqFZ3G2i+vJlh/wD8NrIwnHL?=
 =?us-ascii?Q?JHXBZ0ZR+dSrGy6ME2BfJVpZBG2ct4QPNXdvTHLx5r9o0V0vdjcNNHSR2bP0?=
 =?us-ascii?Q?6Y+GLLKm3QMdbdX628RAIPouqq9WR2uGyn+m4xmnF4gdYi0M7XODbV6GUwyH?=
 =?us-ascii?Q?kMkwfoVRwNbXyVSRrgESBtDZ8/c/kmC8Q20e491qoY6B2DwRf6v+5zuCx5bG?=
 =?us-ascii?Q?g60CivxjqNu6he1Nszpsum0oofVS5beGmsyLLkA4272JZuzOzRdNizpNWp7p?=
 =?us-ascii?Q?DzbDGz5BWHw8FcTaH/tgT8ChsYMIghPbQF/t4aAmJ/hObMSR0IPivqFZ8K6C?=
 =?us-ascii?Q?MCw8UO7zKWgghTKTFrS+BfagWVl9FTbMXF8nv1tgeCHscI0F6IpPGicWFvG8?=
 =?us-ascii?Q?sZEgw2Z6VBy6SNgndlnvTCso1A89DOmMx1uslJmn1G+3hx+anRV0oEADbY21?=
 =?us-ascii?Q?H6hFtRLNvw4lNtWAsOs2GpAY4YW1704NyERX+g9pBobceZNgsjxDCufS/s/6?=
 =?us-ascii?Q?lyuQAg+t02vXB76a2crPQOJKsDL4i9mcXxYu0AXQmf/8VbGA4F01xmtRuRGA?=
 =?us-ascii?Q?c9h1LmkmiQ5vd897xKwjt+gFFObQRNureF8KuFvme5cygz7pf42a7WIHGbRQ?=
 =?us-ascii?Q?7KSPNMD5T7Qq/bEtA+aKtVe03//Ddk17q6pZlfGttMyeUTwS5UZsUSQiF/f2?=
 =?us-ascii?Q?eDsf1o82Xb46K9/wHLWLrTDB6mmqKK5oK+5jh1lCsh9DW/fiQ/wUj4s7reXU?=
 =?us-ascii?Q?Vylev2fcYUb8wP4YgmmLZw4XPaR9FuaZTn/YiTYC6THkw+iH8uc02K0CFyUD?=
 =?us-ascii?Q?xltorIkKGp348+2rFkjNBz4+RzQ/m41rLXkEt59XeXRuLjTuROVSK3t0o2jK?=
 =?us-ascii?Q?+9uvzl4s3/CRh4d86IdUZpQJa2GCHlWlIsZcRR6m7oqwSLChss1y+ISS3L8J?=
 =?us-ascii?Q?alZvhgj7j6wdpWzZvmsHwqS5CY32bF2xJnPMFQ0eaUFHret1IMMlOTZsGw/W?=
 =?us-ascii?Q?UVQfW8BErY1EoVUYsl04dRjJYgn3VisfCkriFZ4LDOB8WUgMGPepJ79N1dos?=
 =?us-ascii?Q?8HiGMH77xO1V3lMbClYO6wvzRKBNfHIRmUUquQevOrqYWp1SQt/BvKqI5jAH?=
 =?us-ascii?Q?/eJu+lVv0ZTorHLprvuilkShOHFke8/1Qs6nVFy7c+yxvFOFtFXN6nPIIfM9?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe7df3c-abae-46e1-dd33-08dcbdf8beec
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:38:43.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or7pv0V6QihaFhBfm2PKpk604/s45OnCo41ZIbgVPPgkYpQJDaGUAn4Tpqv7pvIhaD5m7Zr9AfaBar4NNTn6RXTJ7m7KxCUdHRnTRNfSop8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
X-OriginatorOrg: intel.com

On Thu, Aug 15, 2024 at 10:48:55AM GMT, Marco d'Itri wrote:
>So building kmod 33 with --disable-test-modules fails.
>
>I build the Debian package with --disable-test-modules because the
>kernel source tree is not installed by default on the build daemons.

I will fix it for this one, but long term we should probably find an
alternative. I don't like caching built files anymore.

Lucas De Marchi

>
>-- 
>ciao,
>Marco


