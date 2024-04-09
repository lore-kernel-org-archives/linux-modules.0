Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FA130E2A
	for <linux-modules@vger.kernel.org>; Tue,  9 Apr 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675455; cv=fail; b=gZZYSmP9MwM89jEQm3evQWm+ZXPKNDPFTk1ER8HcOhnauOOPhmWhKeOtcqn2eyHkxjsuITz5Rmv4IaC4r4VwoGrW+/lRl5Hlvw3bi91ilhP1raMD9w1bbnqqlC1QPE8QupNGgMDQd5+CJDM0XQBvZGMjNavvIlZc5xXMWxrkgwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675455; c=relaxed/simple;
	bh=KAucxi4D0HjDqPXhGuKT/p5SMlhQ9CA6NPtcMScw+q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jq6JjcJkDyDOKVpa2WWdxB+Wcg0+/wIjsPrl6sE+UoGDK+nZYzwv8IrjPR5DaI3XTj8WBRFgka7l/oV3IVTD7ImmjKPrAVEL9TsLjub+z3hs8TSq6Qqg6vJ+ck3OPGaL9zaJ6NKZk9xs8p4z55RuCsxR1THo+iUsxxINSTpvTWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT55+c3H; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT55+c3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712675454; x=1744211454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KAucxi4D0HjDqPXhGuKT/p5SMlhQ9CA6NPtcMScw+q4=;
  b=mT55+c3HyR1i4CDMIQjrYASVJMs8LSBfxNKk/g51EgaPQy+BIiHGjYxk
   +MpoHiBr3Rp9G1jqXGjaOrSmRO+Ektav/cKYYadLQ5igrCPhcXGIfJNOy
   uWKqMJWdI4mTb45EPSBYUFWNkRd4Pl0DRuUqnOz9UHnpehNl+bi/9h/+d
   IEa2eNB82TrmmXhVpobyJXQdVMYQFMs9VvXDcvMruixaHZNI2DVWy6zaX
   6UL5+nvigNQSN/i530mKuJRazGc/1qeUEv4VrufWA5ykarKldsXr+jVAO
   WLdDpkVkTY+jd71jchcoV1rSJs8Uja1cktTvLKpBihRrQB0LNiTkWxYnD
   Q==;
X-CSE-ConnectionGUID: 7ZDrNQgnRuCldTNcqSctJA==
X-CSE-MsgGUID: CDxPK6SXQka9WtgqKYpFyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11834564"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11834564"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:10:53 -0700
X-CSE-ConnectionGUID: f987QcSfROGSnM6Jj5ksdg==
X-CSE-MsgGUID: nRFtCHQ/QSWJvHDzOpr0xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="51245583"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 08:10:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 08:10:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 08:10:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 08:10:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 08:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIPTIxHbu/feM6SbvK1iAs3Rl18z+yXCzH0+7AgcCXrNiw4si16lk0p0CPLGBKgIBGApK2QAH35hIBye8UaTntZwuPWtSq03LQQ7Jq+bauRZyG7J4fbWQQ5HzndJuwi/VhsY0F56K7ixwfporBMtB7fJc34oMV6MlaCSvdySx36nhrpN7d6onnG4Ts06VymnpnCWFeiFJYt10EeCLO1UB5nPFnby9pS6g0x/YaJfH+6O0GvK3mZ8mGPI+hr/5dGIDCTp1KxS/4U8E3tw03SqO6DW9ZtX9yC5tUvq+pmDtGg8IVnH0lb+2gNGJwArYdsI/+mZbyH2Cq3oWrWQ0WUTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP8AdeW9EcMZqD4DT9BD9iR343zyyE+cs3sL+tYstzA=;
 b=QW1AyZQ0yNQ2oQmV3WY1ALUEx1AQFBpQ2z8QWL4X8zeJCBDt5JxDwzu+J/fBzVJOOoIOj0y6cDOFIQX4KX0GmEst5/tnbTBDqrMkj7Hw95jJCnYEvpDPBGGR5SSZu2kQRPp6kJc2y/sTIsRmWcAZcegoLvG5e71vb357Deo7XT+8fZbo9z0CLf1sHyBG/3YMimVp1mRVezeDqAWj6LRBwX1jF7DLZyjQoW31lTlKPb0SjH6rV/ec2FxVA67gP1n2RTBEROgdL7O/keWldNtvt3gsh5Mj6L5MPeSOW2JEkRSzYjxmiAW8NVKH2+ru19ltlqudKfSlFyWH9TmKEcbB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Tue, 9 Apr
 2024 15:10:40 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 15:10:40 +0000
Date: Tue, 9 Apr 2024 10:10:37 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <emil.l.velikov@gmail.com>, <gustavo.sousa@intel.com>,
	<linux-modules@vger.kernel.org>, <mcgrof@kernel.org>, <md@linux.it>
Subject: Re: [PATCH v2 patch] libkmod: add weak dependecies
Message-ID: <ut6662ojqsf7bksfmqcsvdnmb72xitenjcuwx43qpyi7vv3ymq@drqkyj5cmck3>
References: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
 <20240327141116.97587-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240327141116.97587-1-jtornosm@redhat.com>
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7532:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7lNydGVJYPoUSpqloe1F4ObBBNk/tL9YtP3ug9v+DN1fCAgzrM70+8va9uJTGoAwkYnVq9MOKjS4+zWaDLHm09swqnZxS9eeFa5YG5Xv03LIp6C1SD7uzotHVGT3lYFq5x+YDA0+F060KVN4wtpWvCnCX5sOpC9157Y0ZgCHUfgi1ya0AE8y0IvD01QnLNBKgkXe+r5aP3QF8YUOQK2Vh8n9X/B2nNVBTvwUlZR7lAFQujg6Cy5bdrwxV0wd9UkfQsnzlz1ketb2zORsZGrghbknVC3xccyX0AIOvsfuBYZVlqIgJbRdgr/oHQp8PN0NBOWLadjTgROUJpoAP1Vv2D1Inr5VI8P0rUn7ApO6gLr5fSVg3oNcJaTFp4Ho8JL7eDE3ntdFa5k7sG3ZkIhmqA4doyr/756MSuSJQZeOfToJ1bT5ZsGUMr4rTfCQYOdRZPcKrOE5r8KKeSso6eDyG/cGnbHOw4yBQsemzoP1Aal+L32SWeDb7qEpkG7eZY/DF7Adts7Fyuq3gh6LRpyMJv/+5eWW4qN1VP1P903tvyssZlwt2Lv2/jQj+9T1+GxWDJKQ/EYJDOtwOTrUGg+0z6Rlxt1N8bufuG29ZP0IBEtWCOcZJzsVwvqQDHtPrxlVtWrCUTJR0ngpe1cG0DgrtjOQROybsF4f+FJ79KbzpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4Qc7UIorUJQP5lcd//bS1NXvuWtAHBzjZxRttbsXish0QJXxYHRKkKUfPiE?=
 =?us-ascii?Q?BRjayvG98MZLCsNJR9+s8No0ivWO4r/o3pge1ApVk7wcfebcR1KJPIYDH3O2?=
 =?us-ascii?Q?vAeE1aURJRLPEo9cOEc+nrg5xJ9V206A/8xEA+zrx/gth4S0TlYu+CWj9der?=
 =?us-ascii?Q?btYkzHen4pHlXI2IpSMLyIJiYs/7L6OD7Yb3cSCiwVAZBQ20EsOETK194n9I?=
 =?us-ascii?Q?2Q2ldgtUTwQEaEzQX8a/9403MXGuRhkcFNl69Q4SFSRGNb1QZ8WB3sY3pWP2?=
 =?us-ascii?Q?KqO2u60FwnaA9cEUJbulqjOm05Gu/ucPKqU8XrmxBP6TuRuT5OfH7wA5S2s9?=
 =?us-ascii?Q?nYm2xoGeECYgEYl+tbjtqlubjxlykvRE6LT0GmF6SNtVjb/d51m2f8DKPDvg?=
 =?us-ascii?Q?4+XQwNhieDyqIlc/WSSfZWtrq46i/IInCyfTLaxCBqylP7GpkNOhWCFahjHm?=
 =?us-ascii?Q?v/9os0hOrHmxqFGDNZXG9AGNYnPnU2Y2vvWjxBRJc8sS7/WvCbk5wfOiNmi9?=
 =?us-ascii?Q?30AxxaGYtqpfODJHSI8ydPU5vdkTMX97jUM6meDdsj2uRIluDRZPPXLHvhtZ?=
 =?us-ascii?Q?w5bT+NHSonWHY9relk7PfVE1A0MzHP+MWUpxX08HfSIpanuIYZmr5JA7d832?=
 =?us-ascii?Q?EKnes+Ag0PCgzZ6dHvr7/8LT8Y+idvjVOBuERzGBEuNRtyv8KxynvvS8jJiJ?=
 =?us-ascii?Q?UFNQCl8GjE4TDCg0p4mGb7N7UKPEneRL7XmjTEvqbScHYRcYie675NP59htV?=
 =?us-ascii?Q?zIGF/MNBYLcnmVlIlZj4DXn5/r5+nlHaFEXMKgOZWfx5dWw71OJjQDb/UKbB?=
 =?us-ascii?Q?F5dWNaJSgTt1w1HOLBIQ0+BjswF7mMbfBPpCu/vYHo/tFDYxSyJmpDaMN6RZ?=
 =?us-ascii?Q?A/kZznmhmmAnLT1MwxHb6ORJTgujJU6Z5/ogJa6g/LSao/ha33YqtZyc1m7g?=
 =?us-ascii?Q?mH+IvgnZ1ZkRtLAqTw14xPfk36QOEDYRwHF17nyaSDu17JVyrG6W8Xwxovxp?=
 =?us-ascii?Q?VhChi3UgHE8HraBtQFPauC+eyYaFUf45d0Pvj2W7x3jW9W7bdKhYfIcLF0ar?=
 =?us-ascii?Q?Pgo22HInCqZcppBFFtOjEe7iE1FHyo6JnLbepoRkvvAJgpjDsbXMT90hM2mE?=
 =?us-ascii?Q?flFMnnu+XELcNcLu8S7KY8QRCyQ9tR5OE2ztu53IwEzgSpfTVigWpNxxMpC/?=
 =?us-ascii?Q?OGGiAWvi8FvIAYFlPFOPt7HIPpNe33vpS/EBLca3ZARmXNah0KbLUOtulimX?=
 =?us-ascii?Q?8vVC0i9Rr1m7/1oazBIHpqexQk6X7rG07V8jXckOUX2aXZz/nm7JAtf/YS1Z?=
 =?us-ascii?Q?IlLqFyCUNfH2jcO45/ui/KNrgQDAtpH4vi0RCHx3PHnlcv0FBKYuaBuEf1Tp?=
 =?us-ascii?Q?oXXllCjc/+1sbtcq89zRlmn81nZFnXFP2RTLEgPW4NaFmnBd+yNcpUwCnK83?=
 =?us-ascii?Q?nHCIKVitAIwNXDAwz7KryiTGsRKcVvEYwpyEbYG+xm2sRs7RdG/JiGnOPCJd?=
 =?us-ascii?Q?6ci8cekBFByg17EB1W7ZaDeIzjwxc/SuPp1FQFrDnyDdaGBOHD0siBnau/c6?=
 =?us-ascii?Q?1lifdZGFblMk9z4/7zSu+xJ1UzOFhbvgkS0QaVMwHVkgNXZU2qs5brH+iCDT?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f1dfed-6298-41b8-e32e-08dc58a737ff
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 15:10:40.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AExSBXK3hAeeZ3KMJ3hLaaY4pInaMbtvZOECn3FQBsYPIrLNy7Aq+TUsVcxFp00Z5n2yyswk1dBaI7urlwR/XxfYNuw8eFfpIipD8wBUbjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com

Sorry for the delay. I will review this later this week.
For now, I'm a bit confused. Why do we have 2 patches?

	[PATCH v2 kmod] libkmod: add weak dependecies
	[PATCH v2 patch] libkmod: add weak dependecies

Was one of them sent by mistake?

No need to resend now, but it'd be preferred to skip --in-reply-to=<v1>
and just rely on -v2 and let b4 do its thing to detect new versions.

thanks
Lucas De Marchi
