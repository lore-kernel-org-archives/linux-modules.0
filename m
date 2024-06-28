Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5F78C9D
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611732; cv=fail; b=l3+ej33o5kfiKBeaY6LV4CbPIklAUtVHETpsq1HvNWWMsgwlt61pDPYGI3BUZ/ItAiQbj0B/mZn4HPa+HoFezs+SZ1wtF4+rHeilIGtFeEs+ozZdMIVgdZsJ9UIuIxdmzeR3GP6Omi892OOZnLBwpbLnKXmTRchsmrSbrB/aP84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611732; c=relaxed/simple;
	bh=jXe/xZaohJwqZlLFxP5+28xOk7GIh7YJgcY9F4j6bc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccseXOhtLC7ckqR11Nt80ucMImKK3bU5STbTfklWAW/mIZCaBP4hd0xoEvrkOwnJw8lv+brGAiXOwnShm7RWNZVPIFke+8zq5+z7CSbVpoV05qnIq6GSWlTbK/tMwtTGWPMFV7cXI0GIhyhmH14WTjSYOTvSzSIHasvbXPIlQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4yZWv9A; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4yZWv9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611731; x=1751147731;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jXe/xZaohJwqZlLFxP5+28xOk7GIh7YJgcY9F4j6bc4=;
  b=U4yZWv9AnW2ty+yNY8ext83mjfN9+89H6tQz+sEHuzH1SFbrvV+Y7Ceq
   8nN40kYwZscPLSq1dFtXpPrRP/tmEHp7IE4lOerme6qvZ6BPBA/b0XRzr
   JN8rHTl6KB744DeUORRJNmXciZ0rMi9DWguhzI1o9Kn1CJGQnbz7pcCd1
   EwwdtAnjy5gMMXh7M2FFfgSPKWDeuMzj7YXXVqKlHIGN4ucf+vFJnuhll
   YqG0SF+8jw8zVr+KBhBdp+OKO4vbFpNIXV9dLlp96gZG22Za/0P82GrHz
   UCLFTugzT/0+RWaH3huVvM3XFABu9l1SOALTcXCl792yOoELkIwdCbkDx
   w==;
X-CSE-ConnectionGUID: LeIgECcST/6+LKGZOHb5/g==
X-CSE-MsgGUID: DRR0Lm76S0yQu7lxByOdZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16935639"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16935639"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:55:06 -0700
X-CSE-ConnectionGUID: IyGT+wToSDGTMGdK4VUBbA==
X-CSE-MsgGUID: 1PAjCUNDQfmRDyyB6Xq30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44746194"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 14:55:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 14:55:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 14:55:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 14:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGQU32xKFZo1b44zMBQVOU74HJ4H0wshWNmMAPZUA26q0gUI8bDXvmEj+MpC6EEi/ST9+fPqLRV5JcMIV7674CuUSgu2aVKH7fbMucvwjAobtbvlsVEMFOAHZZ6rYGcQbWpLyKfy3zEl8ZLUrf6bmE/vyAt1fiFPy94+/V2N8IYbcUFZB6+7UF4upGxCnIRzIGN7TCvsHK61GVdndSHxocyMgUK3/7NjDXf6RzfSwvmLYu+wS/NAcTxEJ0mQKJqsyvxQP+TaUpO6p06XrRJ8V8uY+07dS3wwd4WXgU/dprpuU7z6TAzH21DWM8syo/ILAel5gCd4kibmTXAJJU5Hyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXbJ2FYBrOb0Oqlcj2qMpv3STIoqXtmqaYyqYZlqn14=;
 b=eZ32bR7gfcBdCHP+N3Eyzv9digIqJSV0PepiA+u4Phre9NcfjI4TylD5VOw2DdmFf2pDOiRpjmYwifxinVc/EK7Y6aNcTlfhi2+qvIwR6qHDNhrCU4x6JhWNjnsJB9HS/ITeKDq6aWI5xDU2teCI7yIpy+AJ5c38Wtc/wf3cV01zCpBnXlWx1SDuoI2ArU322cmv3DQqrybfaMISJqfT4xzyD/nTqKD/mOvYHHoIaA8XDktxT+q7F0UDo2AjaR0kv+wDtF94jl6AoSUk0wqCiG3FL7df2lxD5bcBSnC/8Y0ASxKH1i2ys4Vb/xMucs/WQHdF8t1lnjx/x/zLVSabpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:54:59 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 21:54:59 +0000
Date: Fri, 28 Jun 2024 16:55:01 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Valerii Chernous <vchernou@cisco.com>
CC: <linux-modules@vger.kernel.org>, <xe-linux-external@cisco.com>, "Nicolas
 Schier" <n.schier@avm.de>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Message-ID: <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
References: <20240510112128.2417494-4-vchernou@cisco.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510112128.2417494-4-vchernou@cisco.com>
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c1b129-a89a-4d58-0063-08dc97bcf4ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JPs/npnzBzA9RXPXL+jlpwy3+WS8L86Fl5fFLCdV11LkR9px+ThmhVoGMh93?=
 =?us-ascii?Q?+ZNNRds6V3FLy409yiF22FPnoxbVe0SLIXXjcEuXnlHW65V2S0MxfJyuAFuc?=
 =?us-ascii?Q?1XOl8CFBaer9C5Nhgca+2BsdNalySON6MjJbenSN8G6J76/H9kF4KqIkKo/5?=
 =?us-ascii?Q?CgybavEZzVSxtbjT5EQiY+oSgDHOvK9MW8nK+2HvafBffITe5AqriPZKlKei?=
 =?us-ascii?Q?fV0HtzpqCXvF+4OeonNHxLRud23ckIneJtpfQ0byQbqs9DR2+cSWDyLl0f8+?=
 =?us-ascii?Q?q7yDs9KpxeqJFnjzqoCkHVeKhh6296cvPEQoZkEpRnD8CzptiNG3r3dJEXAW?=
 =?us-ascii?Q?dcV7mIhGQUi35eYCgqEfG7VNImv9ruLZYOeuG3zjH/vmyc6M325ym8Phjng0?=
 =?us-ascii?Q?xE+R8JR/qA1s51MezBqPskzyVLK1NHliRwey/xfkCwjBYkk5vTiGQwhs2iqx?=
 =?us-ascii?Q?/ESESqGNDd6jGY2tnUqeDpnxZl0hDOP/DmwJXZ3Dj1lSYBn5IXWeGnp7lUIq?=
 =?us-ascii?Q?+pmWX8KOnD+4yXmcEZG/tJhwsfADG/Vov0c17jZV5eT2UZ14S9wIaN13c52v?=
 =?us-ascii?Q?JOa53mG47CdaCOOrWtAmOwkNX8NjU5qqhs02+tKMGCTSs4T5AouBnmbP8csd?=
 =?us-ascii?Q?s4jtGT4xskrzBS/nYqG0pvM29PFfw8f7OQv24WHLdCIfy6PwVLqMvycw/Q7c?=
 =?us-ascii?Q?E/GCuHeXpv+4nUHvwSdQw1fTNWdi10i15oFcIROp1Dyklx70UdIZ8Qox8Ci3?=
 =?us-ascii?Q?r8EtUOzyJomGXF4+WYHDg2U7HY/5DSpnrElM18bRVd2xGIMsrbuLokX5l1A2?=
 =?us-ascii?Q?SVBcAJmKLESXEm+R2GG+VVNR68q/3gfZOrpOfrWsqRo79p1OJulWZnX1Tiuk?=
 =?us-ascii?Q?/Mq2qU59/CKxwVCBzasnlVXHMt2YRhM/csYDefue3uGBK1hAw8WnVq44a/yo?=
 =?us-ascii?Q?9Ney3hMnj5GTazc0FtQyK3aeTvuqDQN9u/NdDeLNLhn+4eWWpF25gdBfmYZB?=
 =?us-ascii?Q?UFDwByVmcSrQ9Qf7mW863FWPs9MsOXx+epQ34rO+5klC007zyIN8A46tcTee?=
 =?us-ascii?Q?VhC5FCHXI++5bGJLSeoLpy/57tQ8erZVoDwLcFepch4oqqr0I56f7XGJ+su+?=
 =?us-ascii?Q?re9lku5jGplc+/TLGo7ICmIvK5kEKfFpBvLZh2ZUmq/0uZu+Fx1tSMRGuq+K?=
 =?us-ascii?Q?YAWkXRfmFqob0PtofOPQUrzU8FhRvZqWGcm74J6hPlMvnwXeAZe9Vh6zqShI?=
 =?us-ascii?Q?4kp9G3A8YlKGNkzEKebx76M2md+uwFy5iX58+Vf6PfurTiDVgyqT/HiPjKNZ?=
 =?us-ascii?Q?LaIVtw6evA91S6gkP5AOhz0YVrAiJ/3pTE82CzYkSf86Nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tq1cW8jzUu/BNzJVh6/fMYZkAYMdRo67SDb/0mtM47CavPSMdIp8ZklpnyU7?=
 =?us-ascii?Q?2pFDKMgvGz5GUspyN6hMis6VdLcKg9D5Lp5WJtFEXcJCHB1Dt8Vb6VY2dWBs?=
 =?us-ascii?Q?tWmCy8+yfLRxASUJ+f/HUoVV+D6vv1JeKS6Rw4q4wd1Qm5R1WqU2tCYexrBU?=
 =?us-ascii?Q?S0AidiDLQqJtzV5nvLo1YByjHlak1sToVqfsZFTiSlbZ4xi5d7g0oeHv5my1?=
 =?us-ascii?Q?niGpiw0q9q+twqDEy/Ymq5guiJ3GbjHb6GHYQifDlNeuNvl5L/GPzOhddlHo?=
 =?us-ascii?Q?Hoy9SRQM4v2zA46yWpp0nQeB/hIoP5QtTowyIS+ETfxOI5/zVxjgfYO9Rkyn?=
 =?us-ascii?Q?6xb/V7MwoFViDanq+2IjJvSv7zdj6GJyjXshUv4FKF6thA7UH8HWCS0vk2VX?=
 =?us-ascii?Q?C+/GIBVlKMqNQnrVdsH+HFJ64CgXIAVF0d/VI2SWLk2pUI8y/d4vQEldR4Nt?=
 =?us-ascii?Q?V9T9uf39JeDz+DEno62As/Z9eJ5aSvUtbm8iy53vHtkWALTaIGNbuMOL+T7f?=
 =?us-ascii?Q?W0OVKG3X80Kfwh7axKIzkl/nhrSvCto7KF0HkMt/OoxJC72z0ZGFVkhbHmuU?=
 =?us-ascii?Q?Yt7SL5YbCdw4fpmJpGIAyA6V97epoQc7NEdiKHczd41AxIOMZpkDw2Eb2RKu?=
 =?us-ascii?Q?rGGZFjo+qKSaioQ3i0pikq4edpTPBOH/t1KrFhInoxRvTtlZqvP/7XXZFUy1?=
 =?us-ascii?Q?WUy6aKCR0fIo4grz3INeuL8WCEhAam+qmr/ij5vjrl8DX9KIaPowd7Shu4Kr?=
 =?us-ascii?Q?SVdEeYPL5ZVD7tUvRLo43ztvOlOZUgKBpiAkDUQJ/Iu+imGArFV4h4qVkK6+?=
 =?us-ascii?Q?SrL+vu8uRIV1GFe31Op+3SIjREm5NrG4aAY6T5go//LsvnybrmEUi/nX4BvJ?=
 =?us-ascii?Q?khJUGyzNmcnItN1QfoQbYrmYmyrEjWuvAAEaQRaEwVNeoXc0W2kzPV5r0p+i?=
 =?us-ascii?Q?cHlPZD+4i7k2qMkneTNkHgj5xfG4DyBB+7WwwAJL8KpxrNwQHoOQOf+2DWH2?=
 =?us-ascii?Q?5gxTDDlg4Jg1u7DELVKY/QAlU4TB0GPtDoUTTYUrk2EhV4VHPvLC8LF2Xn1n?=
 =?us-ascii?Q?SOPMRNMYNMLy8gmStjsi0FMjYuy/OVrqt8zNrGXL9LGzDKfgN1fI6eQrEdJT?=
 =?us-ascii?Q?mjxMUiV36CFZ3aZnuSLQlSNnlCbNjUJLrE00CXZ8VopQ3l0kD55j8EDaZh8R?=
 =?us-ascii?Q?55NfA3RrfFchGNf3QNP2pHU9w2eE7pCv1hqqjZLfHS9C4Q7+4rG9WAIYj8UT?=
 =?us-ascii?Q?RZIhom8e6efho3fpgNzbR4Jk93iJBFVUwb1ln8TfgPiqW//ucJX6CSOGq98M?=
 =?us-ascii?Q?oVF+j3wlO+YnChJXDXqGbW+PHvmVvLngPRbNZA8vc7OYKr6xetLGWJGIbqhY?=
 =?us-ascii?Q?jCX9tbdYYb/NtiU0lyTS7mxipyyX5vWf7CZ31V56WW6V6P1IoYJA4UtbKFOb?=
 =?us-ascii?Q?iSUHMLe1DDNhB02qQrgr1grCr30B3v7mIO0QZzKawiAr21lXczt9o/i9SPgP?=
 =?us-ascii?Q?UManNumCI7CgH2gLLMMHya1lOPWQS5pMcinPDQR+Y90TsDjbUXxXgU9amZti?=
 =?us-ascii?Q?1wEeAS8UqEqJGGknfJ13D70ZAyPA5xJv/VazSerbgD/2bmJnckM+DOTy2gJa?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c1b129-a89a-4d58-0063-08dc97bcf4ae
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:54:59.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukAq1igACgxeHGRI/70PxnzOKO56x4laQjXGf9JEh6IDPIzZPQxtmufkb3Ct3EaPggiLAljYD1ftFDcfYNV59lMzP7F+jdMjdfQopyN+Wb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
>Cc: xe-linux-external@cisco.com
>Cc: Valerii Chernous <vchernou@cisco.com>
>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>---
> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
> create mode 100644 README.deps.alternatives.txt
>
>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
>new file mode 100644
>index 0000000..9ad3ce5
>--- /dev/null
>+++ b/README.deps.alternatives.txt
>@@ -0,0 +1,40 @@
>+Modules alternatives feature allow to calculate dependency alternatives
>+during build time and aviod to regenerate modules db into runtime
>+
>+To enable deps alternatives calculation use "-D" flag with depmod,
>+it will create indexes modules.alternatives and modules.alternatives.bin
>+This indexes will be used by modprobe in runtime
>+By default modprobe will load first(primary/major) dependency from list
>+If it required to load alternative module, it should be done manually before
>+loading main modules set.
>+For example systemd service that detect platform type can load required platform
>+modules and after it run main device initialization
>+In case when alternative module loaded, modprobe detect this and skip to load primary
>+dependency
>+
>+modules deps alternatives generation basic algorithm description
>+1. Load modules information(imported/exported symbols)
>+2. Find depended symbol alternatives(create list available symbols
>+   alternatives instead of storing last one)
>+3. Choise primary/major alternative per depended symbol correspond to
>+   build time dependency(build time deps getting from module info section)
>+4. Create a list of dependency modules alternatives correspond to next rule:
>+4.1 All modules alternatives for module dependency should provide all symbols
>+    from primary/major dependency module
>+5 Store modules alternatives index(modules.alternatives) as key:value where
>+key is a pair depended#_#primary_depency,
>+value is list of all modules that provide all symbols from primary_depency
>+for depended module
>+
>+Note:
>+Current implementation/algorithm doesn't cover variant where requred symbols
>+from primary deps provided by more that one modules. Exporting all symbols in
>+alternative depency that used by depended module from primary_depency is
>+mandatory!
>+
>+Note:
>+modules.dep index different for standard/basic and modules alternatives algorithms
>+modules.dep for modules alternatives algorithm contain only direct dependencies and
>+full dependency list will be calculated into runtime correspond to preferred alternative.
>+modules.dep for standard/basic algorithm contain full dependency list for module and
>+can't be changed during runtime without rebuild database via depmod


well... this kind of explains the what, but still no clue on why.
If multiple different modules are providing the same symbol, then they
are doing things wrong.

If there are multiple variants of the same module (again, is this about
external modules?), then I see no advantage to delay the decisions from
depmod-time to modprobe-time. Just setup your depmod.d configuration.

Also end users have not visibility on a README.deps.alternatives.txt
file. Documentation in kmod is kept on man pages.


Lucas De Marchi

>-- 
>2.35.6
>
