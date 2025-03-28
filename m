Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDD1C2324;
	Fri, 28 Mar 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177053; cv=fail; b=DkL8TgUYSbGkDSWjGrdU6susLuvirWP0nsjckdIpjZRMjg+ahxH4ec3rTW2nghwEgbEgxT950aMOWPXa0RSI6po9t7CAgB4IdPfBpnXvgcO47uIS63BHnYF9nfgXz09Ub8etCCLQe+gSa5OCsoWIEtKhWkVFxTVQhLvW+8cXw5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177053; c=relaxed/simple;
	bh=vFAywKQ0qIejAOdbXvYzspQoHhUZhBn0Ix1MhJa9VZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+1JmYt8V7u8mfIGj4dWUaV+5hKck+4jn5HzTucIHmI1xyr3jCjhae0EwvFFqbDV9IeJ+hY0G6uAumUAKn/Bz/Zj/cZZ9v0QUAmjrlPt+W8vhkEwNjczrHYJACDAYvf9CrQlcAUwJqHiJ2FEncNrqIGNvq2RVVmWl/YpXyGl6H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXhgKxKL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXhgKxKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743177052; x=1774713052;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vFAywKQ0qIejAOdbXvYzspQoHhUZhBn0Ix1MhJa9VZE=;
  b=nXhgKxKLCbdHQQDsqMTAnF0pboqlltsYJbhMzuMA2MA5wPUwfTr0mKkZ
   owthDVlc+THoDpzFXNjegOFPq96tURIdYuG02+4QTthsq+QZwNScnhHxw
   ylqbDlO9d8/5NIxWWCBnnKTbMmN2j+8MEL0uYpzfJfdGecMOD4TlZ0xZ8
   c73LvDuubs4iPD3w3bSpVUrT8Zpu66ZpPKcFvhyoiBFvwe7aR2p2t+apR
   W3hTNyGh/ZMBtXGwCa0w2HzsC9qdLth+wv9tEpnwoI4pa2QyANwxCiQDk
   HfYLu6BeOeBoXc/Y0Zwr28yFVqZYDg1UK25rgbky1U/aCPJAWYKwT2d02
   w==;
X-CSE-ConnectionGUID: VqJrdigVQPul/MSmacJJCQ==
X-CSE-MsgGUID: IJq1gkwkTx21sgwDfuD2+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="61938887"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="61938887"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 08:50:51 -0700
X-CSE-ConnectionGUID: XbcDGHqkSlejTzHfCf2O6g==
X-CSE-MsgGUID: AHOLBC5qQgeplY92/bbZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="130180240"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 08:50:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 08:50:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 08:50:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 08:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl7W/iuoV/uMSgZWO8UqBcOSYOWhZECnsSlTGLQnNXuMeaAO/o8uQbNyBv1URF5SYiM8KQIW92v6unqUaLBXiyzzJc8BlSCIaZeacFskIocyepi4mmrQxqfpKY3mIUALfQz1Ar/rknzl3viKfPFnyprcv9cTrH/HRo62ZiamW7q7/pfjo8PKoDaBnjWUuVYfASZsJaQIsshYVzJNm6cybA5sGwXK0xw3tlLr1V/pymzVsg9UHR48LhMAowecliD3rafthhwS0iqqxwfn1JqXdgjCDZS2lc3TmXsw9zBundzvz+gHDf5OTQv21Q+m9HTjNE0DTxZX4hAHUDVefyRtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsBLFft1oOhRFgr2huc5f4YjwMaCS71FTdQbM+vKSd8=;
 b=zV1iZ9SoGNUCnoWOMKaYxBAoDddKm1YbpS1zOlTzZDmpcUsL0LN9hhlrLJXMn2PEpyDmI+pVxJujcQt2TCK/8WbWG+Zqwc937J0I3Wx6Yk/71zKeHCiXJu8R42uRe2s6Mrdr/vrZhnI532f3J/8a/M5lAjclggcrq/ZeDFArf63QMKgZvaxx6SmX3msAPsPxFx1Gc9vf85cXVQcTxYKVLQeJluB0g4s8TSK0EXCsXrJXk/pzN75tbaDYPPcSgU2FY/j1IvKcGHc13SxdyP/M2NxXzQqQR91tckrT5K1JCKfMuQO4zs4BDkiLPp7s6a8Ba/PbEdXakyxaGvQ/pRWZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 15:50:47 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:50:47 +0000
Date: Fri, 28 Mar 2025 10:50:43 -0500
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
 Donner" <hd@os-cillation.de>, Jan Engelhardt <jengelh@inai.de>, Jakub
 =?utf-8?B?xZpsZXBlY2tp?= <jakub.slepecki@intel.com>
Subject: Re: [ANNOUNCE] kmod 34.2
Message-ID: <nbfzghf5ol2unxajqj2fumagq25leri3dtnlu47rsxyr63g2ul@g5zgumnoxpps>
References: <hzjr4s6bp35apkmeyqaafsbhfrnetfzsarw34o5c5fvnuppfmz@n4yy43fdkpwx>
 <un4amoqszsfdngir4skk3rpztouptrxfxrd5riiwof4ba6gt63@hrzi233bjuyh>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <un4amoqszsfdngir4skk3rpztouptrxfxrd5riiwof4ba6gt63@hrzi233bjuyh>
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: d8280572-5028-4499-50aa-08dd6e104e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk4yNmFXclNBWlRhSzBNYUVRMDh3UzlhaWZnMEpWZ2s5SXRsL0dnU0ZmTVJa?=
 =?utf-8?B?L0FJaWdmMVFORGo5NVJncm1iT0ZPeTYzOUlJWmhsOUloZHBKVGs0MWtqTVoy?=
 =?utf-8?B?ZzVTRC9GSWI4YXpRNUJ3RWpESnJYT2VCOHdEa2FvaWlCaVpFanBXYk5RSmw5?=
 =?utf-8?B?eFJ5elgzSjIzbHZZOWprZy9VV0RxVlBxYjhUaXY2YjhkNndTVkluaGVnTWVo?=
 =?utf-8?B?eERUMGVpaG91am9TbHJlbmxzM3JOTk1iQkVpdVdidjdidTlBVUc0ZGtaZ0Ux?=
 =?utf-8?B?cWFjejNEZi9wRUpSSEdIOGsvMVVXaUJyNWFuM211OS9SbTVDdEg2UWFhK0ZW?=
 =?utf-8?B?THlJaWFvT2QzMm1iMktqVGI2UmpvL0E4RUpQMDFTcDJFTko5ZDYrMDI0Tmtp?=
 =?utf-8?B?UUJaWnVOTXNzNVd0RjR1N2t5K1UyUFhYbkF2OWg5bVBIWXJKSTl2c2lKczV6?=
 =?utf-8?B?M2h0THJaQ3FyRW83Qk5DM3pab1FQNUFWb0ZMMnA1d2wwcFFhc3NMb1N6QTkw?=
 =?utf-8?B?bkNmcmtjQXlCQjI5Wm0ycFBqamtRNHdUVmgrbEhqcm1UMGFMSzhTWGluTXFa?=
 =?utf-8?B?RVI3QjIzN1NqblFSeXEwQy9STDdBUXRlTlFXQzdsUjdWVW44d1ZSYXhSUXVx?=
 =?utf-8?B?WGJicjYxNEhNdWkxdFdMSnhZSk1ZMmdNWUJEejBXQ3dyOTdvdDIwWmFCaFhK?=
 =?utf-8?B?U2RXUHdpeElZY2dpbVc5aUdHL3hJUzJqcmQ5amJHb1U2UFFLS2pIWXNnZUJN?=
 =?utf-8?B?STVEaUoxWXRXdVNrL25WZEhhZ3UwOGU5bEFxZWZ6N0tKa200dU9QZ25PT0px?=
 =?utf-8?B?UGF1WmxvU1hHeldqbXhoVDRWV1ltaS83N1BqODVRTTJ0dy9jNmhpVGpLODJ6?=
 =?utf-8?B?ZmdCclgrQUNiMHFQQ3c0NHdYZnRQcCtIQnREbzZOQTEvWVVIQkMyZ3NOMDhx?=
 =?utf-8?B?elpJejR5aEF3ZXl0b0JXbFJDTFcwL3BUd1lFZktlMmdMcTVrdEFpTHZQM3ow?=
 =?utf-8?B?Yms3L2VmUEo2OEIyOGtLZWRlVmlGWDVzM3NuSjBuSnV3QUYvRXIrNVIyM2JT?=
 =?utf-8?B?YUZWM0s3amdOT0k2Z0VuQUNoS1BDUXh5ZkpuYS9udEJNOU1tc1pieG5lSStj?=
 =?utf-8?B?WDZMa0xXUTlNeEV2ZEd2cUJ4MG45R2ovWit2UTlYNUJ5NC94WW9Xb3FFcXlx?=
 =?utf-8?B?RGMwZFJ5c1JraGZESHduNkFpejFjV1BMZ3djbEpxQi9paUd4T2tDTEtZMEk2?=
 =?utf-8?B?M2VDSkFpOHc4eHNjc3ZWZ0xmcVk2QzhhNXdKcllGTytvRnBmcGFPTHRSc2U0?=
 =?utf-8?B?WUtNRHlWU2U1NVlVa2NydWtvUUdmN3paTGFRNSt5SXc1MXdRbm5FYnYzdmo5?=
 =?utf-8?B?WUVEd2s5d2tGYTVqWUVvNTFiR21kaVZ4cmQwYlIreVVDRFNVblhzTWhhUnpp?=
 =?utf-8?B?VEpuRlN5MGFQam1VNy82a0hpQm9TSmtPM1FwTy9nSFJuSjFmejNIUEUycnEz?=
 =?utf-8?B?MEhrZ1k2QkY3VldFUXBXMGg3SkdNYVBkSm5SdTFySEVuYXViaTMzU0FPNlZh?=
 =?utf-8?B?SGpBTHZwSHVPTXlEWmN5ck9ZZE1ZOExzeS83ZHVzQmhkcTdsd2ZpYjljdVM3?=
 =?utf-8?B?bzA0YTVzWFhhSXQ5bzB0S3pXeExBT3k1bk9xMEZtcG9ZZEI2Z3BqOGF2blNM?=
 =?utf-8?B?MWZtbjlWYldrZDlUeDZ0K2dHSlNLS0Z5MWg4K3Z6LzU2UjlaaWp4aWdFdGlp?=
 =?utf-8?B?cGZDekl6a1kvUExITXFHRm5mQXRjdmlnTGZGbTVIL1N3ZFk5cHZZMDRnNmo1?=
 =?utf-8?B?QmVSM0dqTTFVK1VaU2ZmMnJSaTN0V2R0WHE4MVc5VE9naVJ2Y2RQdk1aQzJV?=
 =?utf-8?B?NStWSXRLaW5uQldwSnpGaU1vaWFWOVo5YXM5UU1CUlRjS1JsS3lpdXVHV3hJ?=
 =?utf-8?Q?XK7Pdzow+Ko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTR4VFhMVXp2MGdGOS93Ry9wZkFNbVF1WjJWRzNnNDUxQ2dERHNiTjFBKzhs?=
 =?utf-8?B?RVhhaFFUd2tmbE5ndjZ1dmRDWS9Ra05aRjJ2MkhOMEVvaGlJUDZVbHQxSjd5?=
 =?utf-8?B?YTlMM2hFT2tybEhjT3ZpZDYwMXlqSmVFOVk1MWo5L2ROOU5NTjVlMU5DSVFR?=
 =?utf-8?B?UjNMYTlwektMc1hyNnA3WWVDS1ViUlVrRGpUSlpHcEZjUFBoTFYyeVVESkNq?=
 =?utf-8?B?emhqUldFcnVJNHFxcEI3ZFNvWDVDT21RR0xvL3dqMXJndmR0cXhuUm5zMnND?=
 =?utf-8?B?czVLOEZJazV2M3dOMUg0UmVVakdxeW9uVzF6YWZoUDZaMVovRjVCYlVzY045?=
 =?utf-8?B?VXVzaFR4SERnUitHVVNpajQyNEhLcm1qbWIyQkdoV0w4SFZTQWNtbHVOdXlO?=
 =?utf-8?B?VkpGdSs0OEFPQmZ0VGNuLzdWWUxUa3dDZDhLN3JyeGhhMS83U2J3VHhxZVE3?=
 =?utf-8?B?K2QvVzdIdkxuNmlRbjQ4TkZWT05QVHNhblY2bENvR0RNYVBRb3c4UStzcDdp?=
 =?utf-8?B?dWk2NkZkTFQ1RHpPTDg1RDdsYWF4ek5MbnBDbFhHdU93OW1mbGRZdFVFZnVR?=
 =?utf-8?B?TmozaVdlWm5DVExRVG1EOG4vQXNnVFpBd3dZK2RlUkR4akFWNllnVWZhaURr?=
 =?utf-8?B?aXpoRjdpeG1WT2hFblRIZjhYTE9xVjBsdjRGZjE3ODVETlR4M2lEUG9Zem45?=
 =?utf-8?B?akJCM2wxcnduRWNhdjMzRjZqL2k4ZmE2QmZJWE5saU4rWGpDZ2J2ejRzRjUy?=
 =?utf-8?B?YkxJZ3N5STNHK0xlY2hqdE1oOE94b1A5UW1kUEh4R0ozZHdYZmVJNDhMRmo1?=
 =?utf-8?B?UHVQbDkvdTZjam9vTFlTR3krT2tteTJTVVNrd1hlMmFVK3Y5T0l2MVVyQjN3?=
 =?utf-8?B?NWI5YkZRZHJDNmFEdFZ0RjVnQXcxOTczUFhIWXJQNEV2bmljRXFpMUxXdENF?=
 =?utf-8?B?Yzgyc0hMQ3VUSGZzKzgrdm05VVFRVHdYb0RIc0xMblQ1RCt3T0tSOHJIVXJZ?=
 =?utf-8?B?VmRGN20vZDY5RU1ubURpQ0pCcWE2N0QxN284UldWelp3akRNelZERXFQdWo0?=
 =?utf-8?B?bXUzUUtVbDlrWVZlc0V5dVJjVTYyUW5xdlgvdjUwUjB5ZU9RYnQrU1VwNldm?=
 =?utf-8?B?WjlqendnWkdlK1I1enVhZmY2Ris2MW1tM0lTODhZZHNBZDNtbU9kamhHWHNQ?=
 =?utf-8?B?QU43T2NxdDVmbCtweWk3UmMxMko3MktJU2ZtbDdSTjlQMDdWY3VkN0NZTU11?=
 =?utf-8?B?RnFGUXhPYk94aXg5NXVpSjJsM0xwSnZFQzRHOENBbUNOVERLMGt3NnRzRmtv?=
 =?utf-8?B?ZGZ3Z0lVcEtsT3RFN1BveGo3THhiZnFpY1UrVTNHL1NRWng0QzY5K2dwZHVT?=
 =?utf-8?B?QzAwMjlTOFNFWHR2NXBmVG1KRCtQcjBwUDhObHZXY090eDJLT003ZE5YdXU4?=
 =?utf-8?B?TndzdE1JS1h0NFAyMEhVZ2ZnK2IwTnNRa0hTNThTUUxmUGN4NXZHVTdqSnR0?=
 =?utf-8?B?WHB4alc0bnRFemtJWWd2bURtQjRjR0owV3Vlb1dTZ3ByTEF2ZDYyMzNITS9C?=
 =?utf-8?B?bnh5QmRhVDdHeWZnOWZiWjNHTFR2N0d2SHBCUWRNNWdta1BlTzBsSnFNTE1O?=
 =?utf-8?B?VWlwVjllTXZKRkZVMGl1SHliYUJWV2E0ZGlWZnBoR1RIdHZFZFJiTW1zZTVv?=
 =?utf-8?B?UzhLZWVYQVVuK29SMW4zSm8yRzZ3OWJBQm82RXlIWU80TUorbit1V0FTUmg3?=
 =?utf-8?B?cVNIOXZYL2pUZ1RsYVdZN2VRNy9IY1d6Q0tXZ0NtMVhZR3lzaEZaVERNZFVJ?=
 =?utf-8?B?dWoweG5Ta0hSVEpib1dIbTVjRjlmaWhqWEdGc2E4Q0FmZ2hzWEZDNFdJSUI3?=
 =?utf-8?B?a3lTZ2tBdmo1eEJCYzdjam9wa1dHNzFIbXI4TkkyRW52eFZCaWNjSzRtTG50?=
 =?utf-8?B?WWoycFB2WDZDM3ozY1pXRFRNYk1vTlZmTFI4QTBSSDNyMTdmUFI1ZVFNemFx?=
 =?utf-8?B?VlRjUVE3MGc2Uy9xcTF4N2k0QndPdlVzNzh1MVRpdG12ajJrVHFRZmwwK1Y4?=
 =?utf-8?B?VDVzaXd3bVZEVDZuMytOYVdWVlRQcEtBSzVzeG4xbzJkSTRja2NId3dUWmpa?=
 =?utf-8?B?R1BmQUVpVlgzQ3ExRHl5djlPajZKdmZ5TDlXZWxmQTZJUjM5YjV6WDZ6Z084?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8280572-5028-4499-50aa-08dd6e104e47
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:50:46.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUqgVZjZ2Pu4AdP1ZB74g59twC/x3AV/xy68ghtvIgD4HqIqMXS/kdBkKsTeFmGJK0T4jsdOJNJftfzz8kYwWtjBM26mdqk1of1lKSMYQX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com

kmod 34.2 is out:

	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz
	https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.sign

The tarballs generated for kmod-34 and kmod-34.1 were not very
compatible for distros still on autotools. Hint: v35 will not have
autotools and it'd be better to be prepared.

Fix it and also bring a few fixes to weakdep parsing.

Shortlog is below:

Emil Velikov (1):
       NEWS: squash a couple of typos

Jakub Ślepecki (1):
       libkmod: fix buffer-overflow in weakdep_to_char

Lucas De Marchi (3):
       testsuite: Add modprobe -c test for weakdep
       autotools: Fix generated files in tarball
       kmod 34.2

Tobias Stoeckmann (2):
       libkmod: release memory on builtin error path
       libkmod: fix buffer-overflow in weakdep_to_char

thanks
Lucas De Marchi
