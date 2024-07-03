Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E11DFD1
	for <linux-modules@vger.kernel.org>; Wed,  3 Jul 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016905; cv=fail; b=tIpSWxyrYJSs3lW/FMcS7esmcBCoVRh/RJ1aOidOhTLAZy0zCFqxrYMqYa2qto8zNO6PXjQRRX+hxPVTXkUJ9j2ZcaUOd1m/5eHt/R3wrOt+TSr91FC4UkXjk/Tnj7uZKwJU5JYmSe0CVni5WYOq1hgor+JdLZcpHe+9B0IuQtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016905; c=relaxed/simple;
	bh=2bKbeQP1amMCvAdB55V86NUZQAEEnIwBL4+ckdyZlGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbHVm0HtK/2pxwpvyNCRFDVyMcEYqb6TtN9fxr+2yfz036LEBfrfsvu7jpcTLidK8uhqfSQNYdlv7U4n7dIWPRWTnqqmkib/ayVPS0+83tI+dghUPTMKClZbVdMhYWztgL9kv1cQ4ynglwpyvtHeJKmzb6bDFp1hoOtIAKXhX44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ny/k7k4F; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ny/k7k4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720016904; x=1751552904;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2bKbeQP1amMCvAdB55V86NUZQAEEnIwBL4+ckdyZlGI=;
  b=ny/k7k4FFjmudRgMJZEoKbjqNa4Uu467puF7ejmEFJaMLAYy+RIH/0JB
   PiPTlJL3g4+aSTIo/Lv1+UOGk1ZZT7kKFOOoawtuErnnF+mVZqcilNc2N
   C6TDNq+80hmCgZN+xljZ+xHzF89o/kW25rVvCAMg9JnqpLKkemFujfxP0
   AWJLz8+GUBI/aBwOCsLEdm8WJU73kptp4ZlPwbMjxChNt8fLJb/jSM/xV
   uspkM55vWdmiU8CaoceomY0k5W1Jh7CDgm35xX8p/odZ9uu5Ct7kJLaTd
   DoTYVPMCiiz4gWgfR7EqcExmyuQFS8U5Wt/KcvUZ31c6tQZhbpBJsji4b
   g==;
X-CSE-ConnectionGUID: DB8YAVeKQOivo7km99wsGQ==
X-CSE-MsgGUID: RPIKzkfuQ4uKsEPZ3vv4xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27855879"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27855879"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:28:24 -0700
X-CSE-ConnectionGUID: UMaMGYOoR3untGVLJptOrg==
X-CSE-MsgGUID: OVoihgoGSmC0WhUNFnRgVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50722612"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:27:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:27:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:27:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:27:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpd5o3SiWHvAqPgIqX0VxzKR+xJhERjpNaFea58N6QiIZ1SbN4OQ8difu/MxPGPbjeAbBOF3UJKRUYa+RmMzsDfPyIsZsety4CecejVju2km/qZgdNlTP07YopBCa+PWP3s0ZpCwT9HwlVil6++TFJNHyG5iBvfadfSTN2SW1mVijJc46pbXai3lhzSUdXcrrLoFz9uezQ+3LYbzEoka8ks/PaKCEphpn1g72jfhzxolDgdMVJABV+jyumZVFCHWHMD+JRTCAyN97yUQDYqgCX81w2dc4k4SJm82A8c/NW67QRO5kx4+X+uf4vZ08lQGdTea1p5AX4wNOjBFYxLsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AA++dFdcU2/678jGGVfEE1+r5Qy1bpjPHy6G5G4hcI=;
 b=iwVzQGZnTLGvQbFk+xkq2cCGn/EboJi+kbTcofxAiwvwAgjDmWKcqVKugwEJ78UcLx2LbVw+vE1zDCVo9BKbPZhh4rX+NQE3twxrxkyh+/2Scs3N1SR2c+zpcDS0dWuV7wLyEDTzR8c9MtyyX/5H6wepQyocYnIqQqlvDw7mFTRO//AxEVuHJVGYzA8Jh2nWZFM+hF3a5aAukpqLBdNW6WGEARZMlfJvQ64Wds5JYsCon1BIz3N/+/chjD+t/nCSSRnf+tks0V95C5PaH0bH/NZsDm7WC6kPkIZuavPe7pkggH2neVJ/TglQELIJaoiwBEpwHHh9mpGJZn1AYe1RUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 14:27:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 14:27:27 +0000
Date: Wed, 3 Jul 2024 09:27:23 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
CC: Nicolas Schier <n.schier@avm.de>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Message-ID: <4onv4473cxas74vt3xjclrjuaagyf6q4wnmfzdbyna5fjah23m@a55vj2kwbiit>
References: <20240510112128.2417494-4-vchernou@cisco.com>
 <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
 <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
 <20240701-grinning-sapphire-labrador-eaa91e@buildd>
 <DS0PR11MB77651EE7F968FA7D2E0FAB0EDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <DS0PR11MB77651EE7F968FA7D2E0FAB0EDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaccaee-163c-43ee-3aca-08dc9b6c42fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LnVSOQsyEDjcCeIYnUmqESx60lAaZzyGh2pniDL9tReLKUssxjUh3sMxb0oF?=
 =?us-ascii?Q?16qH7UdLIZJosgHkV8x6bt0HtjvAsbMSqy9dbQoYMhpcaCu5Cx1yi4X/qnuE?=
 =?us-ascii?Q?d9naIsI++p9b97FdeU7HIHDdzUW4vuW6KMGf+CTGU93WESqQekEoNlSewbYx?=
 =?us-ascii?Q?pug3HCLj1zkbJhV7Ol2LYb1ZIoITrI+ppGZMooUYx5z/NYO/gxIjVexPY6tX?=
 =?us-ascii?Q?vN/5TbHpGTJ2Zyy7OcRP9Ph1qvTnStO4KL8sURi/6FI8t8eWQ3bbpKrxH7VS?=
 =?us-ascii?Q?b/0q1DxNjG8SB3zR/w+xsjUZWV9gV8n2ztFqo10fGEz63/MqXPJ/mOwutaDP?=
 =?us-ascii?Q?5ubvgQmGZcnhoA7ZDk2qXaBjlBnrfubfZyHrgas4zRtarhgf+0uPOgpFjejI?=
 =?us-ascii?Q?ZfkbS3YdOstwe8xvqQLjOCQomZCg42Ix9rpdIOLhbml2vbPVDeFrWG9QjFYp?=
 =?us-ascii?Q?rlzsdD35UKKWwy1mu+lryfy68C+o/cFkuTXtxiSJNBE02ES0eQzg/CgSfir1?=
 =?us-ascii?Q?CGjwciuZ/d6twEIZIPO76Q89HlyMa9VMeGunIOkCd37i6LVTmgOeZGYVsoDG?=
 =?us-ascii?Q?XfupTwVP9C1oo9HsOK5NoPs81GXcO8O6d5y+Uzj1VKBTktpLUXcCW+6USbBe?=
 =?us-ascii?Q?8zbNRrfUbtr5suOL5ed0zkg9/3QLwtrzxjh0Va/escbYHY6CnrJcyscc1pGv?=
 =?us-ascii?Q?oitO958r+AcLmCcV71QUQ3s01/0TpQOPyQZW1aeke2shmA0bbe/91UfAIB4X?=
 =?us-ascii?Q?2TGkh9pzo6GGwpWhAZbTuzf37EoDLYTf1Ca7O8Fn8YQNyk2wtB/RxHn1yZWL?=
 =?us-ascii?Q?qTCAgiVOzWsTa6Rivmu3Tb5QhCQNJbIluf7YTodf3GJL/+XypmoNxicT6KI8?=
 =?us-ascii?Q?/QMYsBtPpzAJ7uqb4yZevoKXXeaA2BxThrRBHf7WrYyqDJmwwKwkFVbNGZRa?=
 =?us-ascii?Q?3+kcb9Rmn62qbR6eBAMnD663pPLEBbBhUDGfB7HZ4HxESLgIzpmFuzZYwX4l?=
 =?us-ascii?Q?7nPc8GJ95Lnai6v+ImP+7N4jWPZ/Ao1ME84tAB/9cP5Nk4EdUeGSIFcr1IGI?=
 =?us-ascii?Q?NkhvbUUsj8AtK2Dro55BVcAeneXKdoFOom4C/lrNAl30Nx2Y+Z6TEgOIhWO3?=
 =?us-ascii?Q?xo3J+2UphUL1APwgdXUqCrlmFp9r0W4V3Lw9mD2rVlNzT4OnS7cg0bmlYsVH?=
 =?us-ascii?Q?7rt9Fwa6oGlnME7zVZAQ/WpkuhoHq2R3A8lMad0tkCD8o3mzU9XcL/KMmztZ?=
 =?us-ascii?Q?xCrTE/wIdj6w2rJg9GPtysEONxYhboOaC17l4Pn0ZyuQFbnToIR0yeTKHhx8?=
 =?us-ascii?Q?+pPqc4hl7qjUitoNk+4FrXcbLHfSsGljcx/lvSj3AVppTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXmJNew8YXZY7mTynMlpZoBV+OhpYSCeOKe7mZ3t4zBonU2oYa0Ptq+FWrsg?=
 =?us-ascii?Q?uE/PniOOmQ5zfibbxi5ZIk6jz9Y4GUt0h5cereCyay1JhhO8G0z4uehtSUTb?=
 =?us-ascii?Q?UcrQ8u3SQI3uKeyT+Ip7l8GHdyhy1Z6j7d/ZnqeBif4+9PDnRT/hZjgG/QgY?=
 =?us-ascii?Q?gFanyL086DsGfBcsQYa80oaVey+ROfmTZlei739kQjXxBFMC6w3ktnSqmJg5?=
 =?us-ascii?Q?WAM6JIf5LcVapzErseTumdZFMJl6Cpg8+dy2invq/wIWXMCQRFN10rep97K9?=
 =?us-ascii?Q?BZMz/8+L6lLdhEesJsHeJIfSqC/bHyWMDU/oH/A+z21ia9llvmVYGvdcJIGE?=
 =?us-ascii?Q?Iq2LbAFBcjCaBC3Ss9IKDDq2JisjqYWZbQkly5T1DAPRfLCCEUrtD2c3NcO7?=
 =?us-ascii?Q?VOOUZaZbCyKNRmRWjBDXwm/iTKQWYIoRSNvgcdximsOzhHD0d8fha1cRYPvi?=
 =?us-ascii?Q?AbCtGB+dgMEh5oaHuZf72T/3ZlXPnGeoO6yhgRoMQQXsbJzIYs7HCbzu/RKu?=
 =?us-ascii?Q?Nf3ttcBOeVozbxL+fI1lDpCt7aivg+2lE1fFR/bxI1Wo2AtcJGF/bDTNEQ6p?=
 =?us-ascii?Q?JtPP9Q8xtesx5qTV2otTZ0xyzJl7KNaXel3O9OUzYxcxHrBHb7myQCkzzBzG?=
 =?us-ascii?Q?xgAkwS+YCYATpevqpCJDSUW/oXyc3hEf7l1ZrUasUDBvoMJ6tjbRifpRvBMm?=
 =?us-ascii?Q?/dynDGJmxtIRfmjnYTfmmZQYCHlYe+wGZE/uKB7I97knMe067mW39K7PfVWn?=
 =?us-ascii?Q?C/wCCqlAKYTE2r21GYcWc58j2GOP3mIrydfFwXkNdVnsrxMWB3BSCZ6AknAI?=
 =?us-ascii?Q?SOo0TqRwQMlWXu819Ye819BaFnqR1ueIBiTI5tYm0ZGhUAtGSv/5SeZAZ5mm?=
 =?us-ascii?Q?2DuJ3Yf67hS9WosfsoMhaas/1cs1vrDjkStH6fltDRknvEwmwuhUn4pLJ6VG?=
 =?us-ascii?Q?1UaDfbf7ASvqkPmDegaNSU4MYlRMWugN6rCUkDpEhkq1225Spa9gQbDGdtos?=
 =?us-ascii?Q?jFCGGz9XBAHTb89580mPl83S7YqWml2iwKCZoZBEoBM3ZRjMtK9e08lXU1GP?=
 =?us-ascii?Q?AQpOgzH0ZRg/ZMXPKkwcXM3NQ+uwr2BOpBXhz7UDX6v3TyhPfnP87BeqzRqT?=
 =?us-ascii?Q?EILOQq6D780PSNFoeEAb5qDYUgPvXAPV9tcFspChRW9HOoZ3F9EDQDcOjuI8?=
 =?us-ascii?Q?H/pLpELow8yN2KO81s9+L5ZiK9I9ItDJv79wWnRbDWGV5UvW7Ebsejq245tJ?=
 =?us-ascii?Q?xABoEDrnkFR1sNpeAuhyFvDQl4AHNCHr1d/mxX5oItFwokIeTq1cOPCUas6n?=
 =?us-ascii?Q?jWHWWUF6ianyr6qrCf029VFen34Q/j0J9Y0aQiJvLjF+LUZophz30i6pJsTQ?=
 =?us-ascii?Q?p8XAcjeGo2x+t3Dfem3oPPhDvtbuiVgtYI2VOx/h0nhZxsDeHYCIfyqBiOuI?=
 =?us-ascii?Q?vOAx8A0L4fvvq6OUOzoGtfTN64uFzWkfe+fpbst1m3d6HeR3q3pvdY4RP/E1?=
 =?us-ascii?Q?1COjoybhKqb2oF7GliDAAvUjfVOGMzET199Sgk/QQAj0vP9zghZy7wyEW40a?=
 =?us-ascii?Q?LwRDw1Ee6ok+TIQNSicjh5poS54Df+HBc/asmd3L8jNHfkeZ1svSgKRtKG54?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaccaee-163c-43ee-3aca-08dc9b6c42fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:27:26.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx92yd7MIPJtFwhpNCZYDK5OqX6pA08yzPDUVYhetRTTf+5btbpBnPxcsTD9hgGxFcrAoAFi2seFlPkhsgEQAP+0mCMwgqQWhlDhn+o/77U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 12:51:50PM GMT, Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco) wrote:
>Hi Nicolas,
>
>> It sounds to me, as if you would like to auto-generate modprobe.d/ files
>> for your platforms at boot time and implement the pre-loading of some
>> modules before some others with common modprobe.d syntax (e.g.
>> 'install', cp. modprobe.d(5)).  But you probably evaluated that before
>> implementing your patches?
>
>Some kind but not exactly. I try to provide method to avoid regenerating
>modules deps db during runtime
>
>> If your module load order is just platform dependent, I do not yet
>> understand, why (possibly boot-time dynamic) depmod.d configuration is
>> not sufficiently flexible enough.  I probably have missing some
>> important point.
>
>Device filesystem mounted as readonly to reduce security riscs so using
>depmod during boot time is restricted

depmod is never ever used during boot time... we should be able to boot
without even have depmod and even without modprobe (since libkmod used
by systemd should already have everything needed).

It looks like you have several modules exporting kind of duplicated
symbols and want something in runtime to disambiguate which module
should be loaded. I need an example to understand this... it's sounding
more like the chosen abstraction to have duplicated symbols (rather than a
xxx-common.ko module) is the main thing that could be changed without
adding complexity to module dep resolution.

Lucas De Marchi

>
>> I strongly support Lucas' request for a cover-letter.
>Probably, it will be a good idea to prepare test repo with couple of simple
>modules to demonstrate what patchset do
>
>> Kind regards,
>> Nicolas
>
>Thank you Nicolas for review :)
>Best regards,
>Valerii
>
>________________________________________
>From: Nicolas Schier <n.schier@avm.de>
>Sent: Monday, July 1, 2024 1:33 PM
>To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
>Cc: Lucas De Marchi; linux-modules@vger.kernel.org; xe-linux-external(mailer list); Lucas De Marchi
>Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
>
>On Mon, Jul 01, 2024 at 09:23:03AM +0000, Valerii Chernous wrote:
>> >On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
>> >>Cc: xe-linux-external@cisco.com
>> >>Cc: Valerii Chernous <vchernou@cisco.com>
>> >>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>> >>---
>> >> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
>> >> 1 file changed, 40 insertions(+)
>> >> create mode 100644 README.deps.alternatives.txt
>> >>
>> >>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
>> >>new file mode 100644
>> >>index 0000000..9ad3ce5
>> >>--- /dev/null
>> >>+++ b/README.deps.alternatives.txt
>> >>@@ -0,0 +1,40 @@
>> >>+Modules alternatives feature allow to calculate dependency alternatives
>> >>+during build time and aviod to regenerate modules db into runtime
>> >>+
>> >>+To enable deps alternatives calculation use "-D" flag with depmod,
>> >>+it will create indexes modules.alternatives and modules.alternatives.bin
>> >>+This indexes will be used by modprobe in runtime
>> >>+By default modprobe will load first(primary/major) dependency from list
>> >>+If it required to load alternative module, it should be done manually before
>> >>+loading main modules set.
>> >>+For example systemd service that detect platform type can load required platform
>> >>+modules and after it run main device initialization
>> >>+In case when alternative module loaded, modprobe detect this and skip to load primary
>> >>+dependency
>> >>+
>> >>+modules deps alternatives generation basic algorithm description
>> >>+1. Load modules information(imported/exported symbols)
>> >>+2. Find depended symbol alternatives(create list available symbols
>> >>+   alternatives instead of storing last one)
>> >>+3. Choise primary/major alternative per depended symbol correspond to
>> >>+   build time dependency(build time deps getting from module info section)
>> >>+4. Create a list of dependency modules alternatives correspond to next rule:
>> >>+4.1 All modules alternatives for module dependency should provide all symbols
>> >>+5 Store modules alternatives index(modules.alternatives) as key:value where
>> >>+key is a pair depended#_#primary_depency,
>> >>+value is list of all modules that provide all symbols from primary_depency
>> >>+for depended module
>> >>+
>> >>+Note:
>> >>+Current implementation/algorithm doesn't cover variant where requred symbols
>> >>+from primary deps provided by more that one modules. Exporting all symbols in
>> >>+alternative depency that used by depended module from primary_depency is
>> >>+mandatory!
>> >>+
>> >>+Note:
>> >>+modules.dep index different for standard/basic and modules alternatives algorithms
>> >>+modules.dep for modules alternatives algorithm contain only direct dependencies and
>> >>+full dependency list will be calculated into runtime correspond to preferred alternative.
>> >>+modules.dep for standard/basic algorithm contain full dependency list for module and
>> >>+can't be changed during runtime without rebuild database via depmod
>>
>>
>> >well... this kind of explains the what, but still no clue on why.
>> >If multiple different modules are providing the same symbol, then they
>> >are doing things wrong.
>>
>> >If there are multiple variants of the same module (again, is this about
>> >external modules?), then I see no advantage to delay the decisions from
>> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>>
>> >Also end users have not visibility on a README.deps.alternatives.txt
>> >file. Documentation in kmod is kept on man pages.
>>
>>
>> >Lucas De Marchi
>>
>> First at all, thank you for review, Lucas.
>> Let me try to explain feature more:
>> 1. You are correct, feature tested on external modules
>>
>> 2.
>> >If multiple different modules are providing the same symbol, then they
>> >are doing things wrong.
>>
>> Modules exported the same api(the same functions) and on my opinion it's ok
>> and kernel process normally different modules with the same exports. One major
>> restriction is only one module with the same symbols can be loaded on the same
>> time but it's ok in my case(as I described, in my case, it's per platform
>> modules and devices with different hardware using the same software image).
>>
>> 3.
>> >If there are multiple variants of the same module (again, is this about
>> >external modules?), then I see no advantage to delay the decisions from
>> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>>
>> It can be different variant of the same module but maybe not. For example it
>> can be cryptography modules. Modules provide the same api but implementation
>> of api is totally different and depend on specific hardware. With modules
>> alternatives feature it's easy to use this kind of modules. You can use
>> required alternative for specific hardware and all depended modules can use
>> external functions directly without any wrappers or "if" statements to resolve
>> dependencies.
>> With using depmod.d configuration it's possible to choose primary alternative
>> into build time but in my case required alternative is unknown during build time,
>> it will be known only into runtime. In this case it required to regenerate
>> modules db into runtime and I try to avoid this.
>
>It sounds to me, as if you would like to auto-generate modprobe.d/ files
>for your platforms at boot time and implement the pre-loading of some
>modules before some others with common modprobe.d syntax (e.g.
>'install', cp. modprobe.d(5)).  But you probably evaluated that before
>implementing your patches?
>
>If your module load order is just platform dependent, I do not yet
>understand, why (possibly boot-time dynamic) depmod.d configuration is
>not sufficiently flexible enough.  I probably have missing some
>important point.
>
>I strongly support Lucas' request for a cover-letter.
>
>Kind regards,
>Nicolas
