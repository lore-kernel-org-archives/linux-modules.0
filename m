Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDA18133F
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501082; cv=fail; b=kaM3oIkraUiqTHd4S2POdvFYLxmibp8bLdiTg1zSal8YOyYb4HCQvGR/Ej4mXeC8QQgvyXUrgXM0iLHmhCW4XDL4BxU8uYE2L3jBe4DeOvR4tIVrj8JG7ZqLVq3hteIMcP8krROHlcrbcebxYWi119r7zI0R+/hIVYwsPP4g/XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501082; c=relaxed/simple;
	bh=wE1ATaOdaX7hp7BQUTX+O9uKqg/mXLwlaaqmWvYNX5M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+JhOcnbXDB5jhUKG1De04iSphlxUbixq5cZHcvIXOJVvfGn9ZOm/9h8v2L+USCk4a5A28RH2Md+6hx0FqCjCsPr9zSTcuL/0zXLvbpTJB4amUiDuQR4Ii3rUOBBro5TLNFcrSNXojUjxvx82gkAaZtUhT4HlYV01FppQRfBaJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdlqhP3B; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdlqhP3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714501080; x=1746037080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wE1ATaOdaX7hp7BQUTX+O9uKqg/mXLwlaaqmWvYNX5M=;
  b=cdlqhP3BzGpedWpTjWLe62TmiNHpq1OB764Q95E14RG1ZEX1FunIHdZT
   zrEz3L3nOU3RiJApuhEiA6W4F3vaEJ+b8LMvc3FV5OjEaxi1Awon++o4X
   6pRLGqDqapMrSNCefHp/X3PV/V1S9HLhHj6g3OrfGUo6mXHUvdNat4qrm
   +gyZjZ8SlfgRtOFz6XRi7S6EfGvWF9y4hQaz4Uql2Dc1kmDY085/P4lS4
   WaHD9NWCdQ9NWuFw/rERyqONUdH4GFc8xF+iceLv+LGlFCyf+allZlrdM
   M1qzalQ8NU0f5cUPWLV0QAifi0D1X/LlWf6IXAgcYEqvMNH3xZ3IEqwca
   w==;
X-CSE-ConnectionGUID: ZKVRXwFhQ5Kf8+f57MAdnA==
X-CSE-MsgGUID: +NrwcG51RGSw4qaR3B9zKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10096185"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10096185"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:18:00 -0700
X-CSE-ConnectionGUID: rGjD1HW0QaKggNvQQZyBYw==
X-CSE-MsgGUID: w7J+Mr8bQc2+BWlJ9NN+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57433934"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 11:17:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 11:17:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 11:17:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 11:17:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 11:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhdQFPzvu8KKS6qrFkSx9hRNWfUR3d4yO2cOk6FF41n+wIuVaKvopYnArHPJa16ydwXlQywr0l+Basm9/NH95HtS7v1J0Zb3FvpSvvExNtHOIsnB+sptbQujRYPuUBuC+VVvQkEa0HjFhzs2p7D7hChgH7N0LOUJ+guAFvscLdefHpb5S4oaITCeIEAJLcFRmsPY5DLhenp1nxsvN/9LvNm3gunrUESS9hSeNMwKmI6JkMEu0JwnXG7wdcuaVxojIleTIB2wzGqS9XJZBl7RwzT0Vo+PZNPQBPy5aKtzxSIXqznmp8opn6FFP+GJ9hx96TuLMcBhSlWJxlpqO53SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nECGmUROtWtmhJub4nU/a7/iz1XvqsTbmFA5tUvOnU=;
 b=g4tRXbdPYS6cPp74M0G+zAS5UVlvhtltTaoTZBeXGOIUEM+8+JhyEmDQcLdID7yaeAcYk37Tqj+rV/hm1SEruDrxBFxfGNmPBRj6lvaVpq2YUt85vOU2iRzcoV+Hta3yUQW82QVtTN2t/9TlqaPfM1ysbQW/tXqeYpSNrqrM5fetrrRbMOYB4q6k/df0mFikeD8s/7rTYb3p7sHpXr09K4trOaDTO0xcY9QQMJZyXuFirYQayZxS0fYZT/3AfvKlfUYDCO+QhyAQMlOvH00+/VWDyNXIoeOjALYk2VAt/FwkTclt9Py87GiEMKvoKkoJcs7cy2A9rHxyQA3ir3mV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:17:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:17:55 +0000
Date: Tue, 30 Apr 2024 13:17:52 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Message-ID: <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
 <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
 <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dd6913-9ac2-4ec1-ce90-08dc6941db01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zIxC2Ki3qZIjQxLRyNNPWrLaneTmLBfK0/RNJPsZYT1DAsqW/b9Kb7r/Tmv7?=
 =?us-ascii?Q?MLKf94w0BwKdvJatLrLLJWYOe99f9F3te7PWHMhoKRNc3SIjZ8cr7G2HHTRZ?=
 =?us-ascii?Q?SWsR0Ecyc2xzhlILgqvZGJBX8GUygvNm6+Ej44w0a7VDqt0vrj98nxqpuG+F?=
 =?us-ascii?Q?MLRUYMOtFNzFvAm2ZR2+ytKl5lcgQLkmzkT3ZoJUT1290rcfKD3pOdSpyDHc?=
 =?us-ascii?Q?kkRtg/rVewRdrjmzOIb+W24F7k0X463vXse9GZ8g4MjWBivW3HS3aAfmn4ji?=
 =?us-ascii?Q?fsVrInyjyzHf1nIH8bI2jqLLLq/tvPXsYt4xlZZ5sIShcfTe6Y5azfTWeIJD?=
 =?us-ascii?Q?znaw7uUKLSrfJwLNM5VAEsZ1s+xpod7Bql6fgTqxKPP4NB17nJxhWmFmLNLH?=
 =?us-ascii?Q?IKlcDZchE68wEgsUb8dJ++TYlO6nb8wxkoOqe7PXyFWLoI8BOBqFfHoA8sq2?=
 =?us-ascii?Q?oGmTDZvpCivI3ytgN5aqRFeqMzwPANEG5Zk67fIukPgFhK6kNwidSwJPnWSO?=
 =?us-ascii?Q?l/v8w9g6d/fYBTDKF2rHBj422isGR/NPUvvYjwWilJl3CQAPYoWWO+OTcgjE?=
 =?us-ascii?Q?pgAGWfJzOqoTB80MYdFWoPv/YnGKq9DErlEzSXKABnnP818X60dT0YkVPozW?=
 =?us-ascii?Q?zS6Wd8dRJvL+sBfSYcSiDPnFt9rAAFQCEsoxVN8BgpVCwebctvM5gYYuNmnb?=
 =?us-ascii?Q?XgEz4MJ0rfjtE1d+p1sOjsYG6DawAili8UFIlxYfees3JuGpTWo6tMVbMy/7?=
 =?us-ascii?Q?U+eZxTETXPCUxL9x3gxyZQDgusLc2LHkDY6JLEsh/Hokj6cQ9aw4P9CiPtzE?=
 =?us-ascii?Q?a7pavgf4uvwePqVZpjIVO7NnyQGyIwTEHCF6af4ikoDpfyZOUaA2F+E96rE+?=
 =?us-ascii?Q?RhVuy7zjn8oi2Ba13mhlxDIJmwpcu0+NqII3HEvQXSUkB17m5Qi3SPaIHT7O?=
 =?us-ascii?Q?dw3WN67eDGjcTZkNoXFtyjfJnSU0nEF8X7ooU3PIoVYd3vYLwELv8nJyo6Zx?=
 =?us-ascii?Q?CDzdxFLY7kDRW61/TSosok0Yj+Mx02wKQ7ZgD9fj54yGhK+OroEnIcOT+DDm?=
 =?us-ascii?Q?eoZs6/H+buvdQ2B3XrBiXRRSBJIqQ0WbzNqj9tRv6K0DDUtk08i8ycrBB+/D?=
 =?us-ascii?Q?JjnMp4WcRcAk91mXwk0Qd9U0QgkmYaUSUk8hztx4Ac10Fi3hMlnZHPLUQtFd?=
 =?us-ascii?Q?8zO3/N7yVtbA4iHoW6NwMaTedjl8QK+FAi86Tk1G/TZoq9EdoI4UpLX0piwO?=
 =?us-ascii?Q?Bvl6DMatsrFWu3EkaUdBFMCAukzAMNznbidBjXSXHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jIOgF7P3NzIlovPA8E4o9ZbU/NXasRg35zBLUy5f21At4w6XY8d3pqSpSnJv?=
 =?us-ascii?Q?mAuyt66Q/1aEKN5+KWMXOBS3UMK7Uy3D9GjJQNcxRFKnAUup/7dzIt9lBY+9?=
 =?us-ascii?Q?oi6sJdGsM+1qVm2MCxIqXPsIRfGp+bKb/jVGkM/88bBHASQsDDgOwy4caVQr?=
 =?us-ascii?Q?96yCk3mwDoxJNVxnXPHJaF//UhEe3cWOvOJSwCM0bWjX0Mg9cBbt2AfocH19?=
 =?us-ascii?Q?NevGn5DzFq6u/+i7ZM84JYarVDQUWIrH0K1962P+SDp3ov+Ep+AXbRGlNHDV?=
 =?us-ascii?Q?yV9n2x0gdLvSoxBToxl/kwz7wZVNfOrR8V+LRm3en5ibA60JNqjw+PRqc22m?=
 =?us-ascii?Q?aozxW875wd8/Azmarka2t0X28D5J0s0LNW2ZIXs9puMbvVvGo0doYkOERAoS?=
 =?us-ascii?Q?KA+J4309lXfbV826vd2ngEb5zVNgy42iuvBBw7pOIZoHpZWH6pd32ZphGmUc?=
 =?us-ascii?Q?bnmXM/FCzVHoNFhuQjlKrzfHXuicGQOTEpiuGh0bnUhr+jsgWc09FdfD/IQ2?=
 =?us-ascii?Q?k7pcwq1YEvWNXwxub7Dm8p2ZMJqRpvcqTrM99I+Vfr3ekRpVN2/L2Ag1ZLYl?=
 =?us-ascii?Q?PpezCC8419UwmGWP7cRLDda+tYJwSCwz0ADioVcnoz1CqIQuQshs3lvypEz/?=
 =?us-ascii?Q?TyTSHu1Wp/+AW8hGY2zLFfmQZZelsayHYCQTksdqsVXYqzvOjHcLFypS84BI?=
 =?us-ascii?Q?E+5+ir9U0+wPrwqiB8v9aRzGtXahve/yjI4fZQbyCg8DN3cHtiwD82sm1Ayd?=
 =?us-ascii?Q?4Mr+64mcVq/jExizPqvZ5+RPNbPUQ6ozTaGx6f6gFSLaxVOtSj3mMSXa/z2G?=
 =?us-ascii?Q?VgNwQ3H3KIJU3u8aC6pf6/whLc8Wddx5Th07pCILYu6IvvvchPaRX6mDaAHX?=
 =?us-ascii?Q?bmQpzW5tpcVBvXMqX0z8DFHW/SoY+WiwunOINwSVieTVpnGVdoj+PriwKpQx?=
 =?us-ascii?Q?yqq+zp+kVX2Ip4rqWEhAUXkaNq/x/+Nrxl2oyWXrfKdxdqFxAkUuAIM1uYQI?=
 =?us-ascii?Q?glAlmKINLekdtpMApaOsllMk55c3ERH1SodzeOgOzlH4DkD94Ox7ODaaiJz0?=
 =?us-ascii?Q?TsNPqrjikNXX/c4//WWyG/g1yThPab5YqlFyxNzStHZKo6cbM2m25yoAu3cc?=
 =?us-ascii?Q?f52/WK9aWd9T19u+rUm3zG0JqVUp8DwJSGoPAVP67CAsj1gZL7N1mhOKbBTS?=
 =?us-ascii?Q?636UyF1+99FQNPz31UuL52Fi7GnWZ6L1LKwNGxjcvo/MhSCQl7Efv/naCRTk?=
 =?us-ascii?Q?uqVzA/SQY8TUX7T6e54KZHl8p1GTqdsTBCpiAzqT4y6yBULkn+ZdcXsONQUg?=
 =?us-ascii?Q?P9UPqTZPCxs1G0NkzlQkaFaEZUqKm9Drgt5min/7XiayxVqBN3QLxXtzEhuS?=
 =?us-ascii?Q?pJxpaa7lMrBTXQsAyF2L7pNQPTfAGU20kek9yOkR2jOyXWObbP1ZFuOMHd1f?=
 =?us-ascii?Q?htZOLQs/zy2n61RDupBVBpBP9ePudWmxE/MlOfb0AYKt0XkoHPc70/4v8ADX?=
 =?us-ascii?Q?TFpmbVTlujKW4M44UfOQ3Im10/8zyGuxkTU6TKDjAuloDEYzYqgBWIl/CF9O?=
 =?us-ascii?Q?MREqxkJu+Etgu2DKzXZzaz2ujPlB47uDghAn/d5oouWKZto+47PW8xSMzuVG?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd6913-9ac2-4ec1-ce90-08dc6941db01
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:17:55.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2nE6QXKRH08tkdzxa/4uXtTol9VktxY1JfXRRXbDfKK8/FwDVmgamsewN0XMgltEX1PUMKx1TYDSR1apemFPgW6YNfOoZgqmdZ2dQQ7spc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 06:54:00PM GMT, Emil Velikov wrote:
>On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
>> >From: Emil Velikov <emil.l.velikov@gmail.com>
>> >
>> >Since all the compression magic is always available now, we don't need
>> >to loop at runtime nor use alloca - latter of which comes with a handful
>> >of caveats.
>> >
>> >Simply throw in a few assert_cc(), which will trigger at build-time.
>> >
>> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>> >---
>> > libkmod/libkmod-file.c | 22 ++++++++--------------
>> > 1 file changed, 8 insertions(+), 14 deletions(-)
>> >
>> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>> >index b69f1ef..5b88d6c 100644
>> >--- a/libkmod/libkmod-file.c
>> >+++ b/libkmod/libkmod-file.c
>> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> > {
>> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
>> >       const struct comp_type *itr;
>> >-      size_t magic_size_max = 0;
>> >       int err = 0;
>> >
>> >       if (file == NULL)
>> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> >               goto error;
>> >       }
>> >
>> >-      for (itr = comp_types; itr->load != NULL; itr++) {
>> >-              if (magic_size_max < itr->magic_size)
>> >-                      magic_size_max = itr->magic_size;
>> >-      }
>> >-
>> >-      if (magic_size_max > 0) {
>> >-              char *buf = alloca(magic_size_max + 1);
>> >+      {
>> >+              char buf[7];
>> >               ssize_t sz;
>> >
>> >-              if (buf == NULL) {
>> >-                      err = -errno;
>> >-                      goto error;
>> >-              }
>> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
>> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
>> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
>> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
>>
>> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
>> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>
>Is there a particular use-case for explicitly forcing C90?

not forcing C90, but forcing -Wdeclaration-after-statement as per
flag passed in configure.ac. I think the message given by gcc is
misleading here.

Lucas De Marchi

>
>The configure.ac contains `AC_PROG_CC_C99`, which seems reasonable
>IMHO. Plus the autogen.sh goes a step further with `-std=gnu11`
>
>Thanks
>Emil
