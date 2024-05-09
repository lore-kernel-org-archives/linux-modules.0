Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CBD26D
	for <linux-modules@vger.kernel.org>; Thu,  9 May 2024 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228568; cv=fail; b=WlVFpORLpWCMCUwHLK1RLbIkbNVL89s7hXlfTzlYA5JZEBos4zefS5/SLNZC7ujp0UE0vJfbeRXQ2QO8geF9RECA3X+b62/M3eHSmqthp2bppvmLLin/BIPEDNOE6LICsUvraNmViRbtjh8zIEEx4dH/azVpNK3rGEXA7yTWqCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228568; c=relaxed/simple;
	bh=DncUFiGEzfN7ZdnZLzm6At1L4K+xUdS7YfMrFkqPYUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srobTzYsPkNlrwB+zwtLyOqpUUK/R0gEQSadDR+gJM6J6NX+BMDpR4H83jkEaB75OD6Q1Suo2dO8IGB8o0JUX3IIB30tR6KAfLU+Z8+IY0JXxwYDpmfd4iyEucFdGTgfemw3VmIRJh2bGk1x6xd2Li8mvo8wySzBy3LYHsTL9ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVi6myTP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVi6myTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715228567; x=1746764567;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DncUFiGEzfN7ZdnZLzm6At1L4K+xUdS7YfMrFkqPYUg=;
  b=UVi6myTPBbvQRIQ1xz6fTQxTqkCrveyQ/fxbIdYuQRqn8iM0G+c6XU52
   nUetFCEzS5QkE+di8EQi6TKVprwzChzhv92Jn23l5q/kh1CcAWQk8KARo
   tre9+X4jhD3c4+jyETURYbRDtqFNDPnJLDq2qGuVVH4DJaChSvYG0j9Yb
   LBleh9TB1S6WHcZ8ZrrZtYpTGcW8Uykeq2HKbbnictx0dend1oVsgXqOc
   o/2JfbLYI9uMeEqVCzw388CLPX/VeZEkL8c7mvSZkBykbmE+vzkMEl7Fk
   lmNqhHLpEiOOEjq5g1DkJ5uhtugpi9NipC7JiVs85zuSS2nS6eNLF3MWN
   Q==;
X-CSE-ConnectionGUID: FPLudJELRrueZS0QI+st2A==
X-CSE-MsgGUID: uz+vwFCeStGJwdyhuk9YjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14933575"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="14933575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 21:22:46 -0700
X-CSE-ConnectionGUID: x9PEqY8YQW2S5ov7KID8IQ==
X-CSE-MsgGUID: oLAJMXL1RNiBnE+WqENcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="33640462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 21:22:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 21:22:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 21:22:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 21:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkBvqbvPQWt2itMOYgOMR7jXxYE4/wqYgQA31eSu8fVX/M+YwDc7azwThnWKuyfhdfrESLwnJCk1CsovtF5MMzq72oOGsloPpg4jsBNhrz/TTPMzzAbjm/p9Fn3DPjQnpL15mneaMYBQYwKWEU6uoMh2cgGUfF4fgRgeB4XY0Qlf1fNxW1EO/l3FejkOG+QzfdznHYvqbWekzEYFWeL7YS2tE6lc4bDsWKwUdsH4ABpYqeE3P0k5P46dnfyu5WM3ZwFYDJiPD8aSwgzEJxkQzFxyChGqQELmLpx3nzIJ6QwUJe4OyxH54drHlsOTaJ/mG58S6lstB9jCQCBvWV1H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXGlCBBa3fQ2MuTCDmRkT7lxeMYY6DVP+98UNnoZOH8=;
 b=DnarYOl0Kof+fBPVuT7bo3GRnEUuxyOTr1B78wDUBpEAfuGEW1E6p2kBsbAAI3+sC9J8WbyJKDD4KsrrH24YW4LFHw2oNcm45PvmMc4eo+RqEx3FFJx4aCaDK/YyF7B69q/WAXwoO061imMUFemCUrbqW45oJVuYocsA/VWsc9AUgYxAAhpkfKI+cBj3jFq+/Ey71fkQAvLB5LxAd74hpNFvzlmapapJab2I91EOHfud7lsl0cRLtcQhRo+guKVlOLnGMYb9vzyyeeCN/CSlzn68aG0g023P+3qOldZ4GbBTSUi9UneiSyXyb0EhTNBonqTMJP6P1RIz7PKZpQZapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 04:22:44 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 04:22:44 +0000
Date: Wed, 8 May 2024 23:22:43 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <emil.l.velikov@gmail.com>, <gustavo.sousa@intel.com>,
	<linux-modules@vger.kernel.org>, <mcgrof@kernel.org>, <md@linux.it>
Subject: Re: [PATCH v2 patch] libkmod: add weak dependecies
Message-ID: <rjk4q6tcs7cqpshh53stbkhyoimfhwx4rqzdkdanluqb6xscdw@yxyag3ppi55f>
References: <20240409155035.524993-1-jtornosm@redhat.com>
 <20240506123634.14246-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506123634.14246-1-jtornosm@redhat.com>
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ2PR11MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 578a1ff6-5333-4aa1-be36-08dc6fdfac7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tq6aoO75gHDYunA3BkNUGqASX6PrKRSsyX8hAC76o95u3rDxS/qPIRrQp+?=
 =?iso-8859-1?Q?DKHjGA0xwacL3MUz4rwSyAGsD1iQmrvWdBfI5egB0WFzjmeQ7EpF3O6FrT?=
 =?iso-8859-1?Q?ERlsHb3pFOjGFVK/03mCpHUmIkH/7ELOkYfCJt0z1SfBfgVM6ziReGcpR8?=
 =?iso-8859-1?Q?mGUSOz049/wJkNM0s78eC+9pklHUeDbfGDQqBOu7a6l2dKmP13RWOoE2v7?=
 =?iso-8859-1?Q?HUTJM/KpHtO2XaRpgpI0ORZMUJ1iCbYRnv+J0FS+jqHSknmchqWxSHyKx1?=
 =?iso-8859-1?Q?T2uoZRtUd0/Ggz2Enkq9bnPswED2qsHNvHXdRx8MrSFUjzHxBZg6m6yChA?=
 =?iso-8859-1?Q?fnekU2QVorcNBEJ1tlnagRh9l9/cZqYJSn2fJS41sk4JTr4d25SwbFQm3k?=
 =?iso-8859-1?Q?eDcKY4iidzOzj45QGchqhoz+ZLINNDOjBzQnsvWTdnWMel8BkLgi3pTVSN?=
 =?iso-8859-1?Q?kDlQqtOSxXe120NuHs6EQnAs2eFbOFT22IhfSoYq9gQiwC7cFgYIGZVo4k?=
 =?iso-8859-1?Q?rQfiRaHWbBRKSZF0pQcfurJ27UHzZZ1aQr01pyqNpEQ91KavrAxBUuLjGB?=
 =?iso-8859-1?Q?u0XaUL/V9xk/82wtxehl87WvUllHnyXEglM+kXDWCXTf7QwAyJYVBioTSR?=
 =?iso-8859-1?Q?8TKp4Aflr/szf/S783rn+Oz8M67tIsL6nauGdt4B5UxJ9BD5xOgiMtVMrw?=
 =?iso-8859-1?Q?LzpGuee7HLkpJwclv5jJWjhFM4YJH6alw1PPpE+ld6UFohaZC3l2L3x8O0?=
 =?iso-8859-1?Q?6OC+xu1eEPc/dpQ/UHhyX0ip0z//kmAc1cZ55RQONovmltaEEjKKoK9AEW?=
 =?iso-8859-1?Q?/V6t47TLOhyA2XxhfbJnSCgNC+AbNlCsK1Ygyb2UIoszEilhISBL4mTuj9?=
 =?iso-8859-1?Q?NpESsERZDX3jjhcPBpkoFkyAvNfbXILjVEfrNTpJylUJfKEUehlIqH++zg?=
 =?iso-8859-1?Q?fvxlFUG6nGfS3ILVeWF31onMMCGXGoWPumdjLfD6L0pqdKifSeCTJjzLB6?=
 =?iso-8859-1?Q?N3F+t4PZI7wD1wVXsBZ1GOjMi+Pv06vv2Qdk/9PL4/qF1d3s/IRV1FWovU?=
 =?iso-8859-1?Q?mYOmA5rwqxrrEVZWfSnRxBuOwxpbAFPPd6pGScwq1cCYUZMDaDCV7Pr6pE?=
 =?iso-8859-1?Q?yWycAiNOQ7mA8KAKJI2jHw8tFMIxvAM6qXuOksylzDRPMIAFouz0r24RsU?=
 =?iso-8859-1?Q?kJw/kaGidQ2D4CojZ0SViquEi4c1cK9MKqNTXW6/tYv+y7JEDeu8OCGNzy?=
 =?iso-8859-1?Q?QBMxG0dVBcZ9Te354zkViMlM4WOW0/PXlMoFCifDWhm/4bxV3b+rT62msP?=
 =?iso-8859-1?Q?NxeA8mz96DOrFsYM3hu/Yub5vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Gt2lpl17L8VmEm19/AUIfiPSMOyzcWCsOedjmAvCSchIz0951RxRs3Seu3?=
 =?iso-8859-1?Q?LtAEUc4ufM6cqrIXwjgz8I0e2E4UOns1Scjni/cFNVWTqh3LgTFyR+DZkc?=
 =?iso-8859-1?Q?GF9EVU7Pa8rHAfrqJucjXjUPB5Beoj8sa9Z2jHuePuiql/iZy7LF7/SMBj?=
 =?iso-8859-1?Q?wfjM61YPFmLRP/S3/nhcDGPhcFwDHxHUV0MWVAquf9UL3+OzJQgFmNZ0HI?=
 =?iso-8859-1?Q?mfekAd7b04/P3jxIU9aL5o2yC6GMCBaY8NT8pGOkxNQGtilp3sp/DVs1Oh?=
 =?iso-8859-1?Q?rKwf0Q0ViZ4m9dx6yy4qZrQZuji+kbtlQlK5J1ybduYacdgiSg+7Yk0bkb?=
 =?iso-8859-1?Q?8q8yHrt/yxTfsut2zcMr/AHp94q+bXm287n4gncGLv0OFReanxVbaLlqDo?=
 =?iso-8859-1?Q?yZf7B1MSC2UgCYWeIBIiqgdsK+HbPSmKu1so1JApf70x2IF6h/hRwsqpKT?=
 =?iso-8859-1?Q?oTdAPO/8YbGdb3kkZF7a5Dq6WYSqdoV3G6NUwS37zpNmZs43MEw4y/eaxu?=
 =?iso-8859-1?Q?iCes709VOFnb+q1ECaiOAz652gA583k6dj48QyT1XpSmesE2dLhecXyBqs?=
 =?iso-8859-1?Q?5cQfe+1c5aXx+exHta90lxEAz71pJLeoosRO+UbbHojorGNoa6gmPsQGFV?=
 =?iso-8859-1?Q?APG75cDdLPY8D0uGr0xy28+4QO2LA1Th/nT5h/MTRG84sBYSIWv3lkd0aM?=
 =?iso-8859-1?Q?pAM3Q/jmjhlDnjlI5hlRUAZC1L/24mvF1Z1z04pSNtOM9I0vY7bM1jkFGi?=
 =?iso-8859-1?Q?NCYzusROyNmVGLzUnvxF1HG3Bsh6zKOELtzzmyBF31R5NcvtBHO1BFTshu?=
 =?iso-8859-1?Q?1hD7umPnGRLjEtBXOBQJ1zxseQQ5xfmrDPdftAXPMopkx+mxP4I2/mOAEt?=
 =?iso-8859-1?Q?Q2wAtR+k85ep0yirj7D0QqhZ9q2lknfWb7b02wdhHC0GJ7zuXEaHxQkdUy?=
 =?iso-8859-1?Q?Uqe+Rwwr6Q4r9/WiDalH/+G8z7i8AXC9FKGhmX0CO4arWcTXjAe1wgwp6e?=
 =?iso-8859-1?Q?gEZd9IZl5Icshvwgbib1RNaDyvEE7mCHbaps/UYbJ2JFguJqmH+g7ihsWG?=
 =?iso-8859-1?Q?83pdQlh1oP/5X+Cj1KjRu7n5+xGlsHLUAhkEf3cbk13ek2J8umLML4WU73?=
 =?iso-8859-1?Q?fVOei4fYdUwCxlInMXLU5mtZBYWrIOzvjEOr59R3/D3Lege9WVat7PqBkm?=
 =?iso-8859-1?Q?uMUlh6nk301/0hbj3kvo7v/U2ReTTXfXsXi/2fMoZQa+sFqVB1HHciPF1M?=
 =?iso-8859-1?Q?tf6BbdUo0dmdfmC1OEgTC71WBvMfu3W33A6qqZ7jgOSmfImRAl+i+r7Zs5?=
 =?iso-8859-1?Q?B6OTMDLhQvIJ+0RY8OpnAUmVahiZgjCK4777o7X7HQPHEzbEe+b0XjQ9fg?=
 =?iso-8859-1?Q?DqZ+KwyKf8ivWT6qzsanbFK/3ub2nNItiPbiKxVjc4IyoSlTWX5wzTGpxr?=
 =?iso-8859-1?Q?3rymtfRNvs8WN9MCyPw2Ki7nB8v5Kho6PJmU5NXoa1aoy+67NfI82U5Bs1?=
 =?iso-8859-1?Q?laY83inZpM/bLA17GEP5ti6cMSXeVYMy+oiNRTPYKDM275QtCF39g4kE7M?=
 =?iso-8859-1?Q?h98UVTtDInzOolO+S1Y4UdcXBAqj/acFqRuwlNuqNfphlNQ3DC7ipbuZy/?=
 =?iso-8859-1?Q?XpAi+1K4OWIs6wtSF0yhCe3wKOdAdUTfg3x5IongAsYcs/jCumYkZrUA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 578a1ff6-5333-4aa1-be36-08dc6fdfac7b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 04:22:44.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R3sWAmSxp7NF5XVuRKbaTqUJP9AVNsw3luaqKRkcamBvLOp1lbl28PVIlcC1UOW+YtK4c7v1ankztY2p9VZNLzCkoO3v2F7ICsUScRe23Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

On Mon, May 06, 2024 at 02:36:02PM GMT, Jose Ignacio Tornos Martinez wrote:
>Hello Lucas,
>
>If you have time, let me ask you about the status of the weak dependency feature.
>Do you have any feedback/review for me?
>Should I do something to improve it and/or progress?

that's totally on me, sorry. I was busy with other tasks and started
cleaning up the backlog in kmod with the older things that were also
pending. I will review your shortly.

Lucas De Marchi

>
>Thanks in advance
>
>Best regards
>José Ignacio
>
>
