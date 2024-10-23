Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B211E8825
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718716; cv=fail; b=W6oaaCD7Ent+0+TY29ezAf/SH1VLCS12Qj/9aRyv1Pjj9oknVlZ2McMDc+Fb4zKY1v2iyclt+OXIkbFh1Xtg2C9bpX299ljN+Xw/9qSsWOfyTWA1yBuIKvFCbR5a2TE7IOms8t0LbLbG5VufFEMtELSRZ6nb8xlBshnDhhpXOI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718716; c=relaxed/simple;
	bh=j8kYXPBhp+1EVxKw27PrkyQ2MBbCSckvQeq4QOvlMGg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QtwvfpQM8q/1m90RqAMCFwTisgCqfHsCFlfY4b1KB6t/xSVNRogdOaHTMkCQDTKVfYWJqAMovpNgQiOxtjtStb78+s4weIPIhZLcxn5U95ZEc2p/pRCaXz+Lamz1TUOSuC1OAIlOqqcy/ZbWfzf1D9mWkMDR5siYA8NdWFswlIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YclpWnJj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YclpWnJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718714; x=1761254714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j8kYXPBhp+1EVxKw27PrkyQ2MBbCSckvQeq4QOvlMGg=;
  b=YclpWnJjDfL6wblqUHP4UARc4+OrpI/Kg/sBmWJcmir+lI2aD3JlRqZo
   8b5Qd1Qtmb6wXuo/GI1fed8ZaiBl7K7UGOh3HwE55lsEvf5i6TerAum3h
   DMTc1hAkY99kbOUBb5VNVtDE54QKVSsAMv9mGMJ483ffyvDDfZmC+ktzC
   A6vL+PAV0EWtfj9BEgfGeerJ/t1eQ6wmjb7GqJqkZIP9h0x7pKXChdfat
   RDliFL3sw2pK9iwPfdzf9LhmotgtrnjPcOCf3QZXBwil90nH7dVkHRADv
   Xbf68bcwg+1xn7rRsxcu/lGZkRmL4eJQxFgCCD4qYk5G1HtZZ+kgAuqrX
   Q==;
X-CSE-ConnectionGUID: EG0DwoafRn6dg59z5jzmMQ==
X-CSE-MsgGUID: y2VRDTgxQ1ur7dXiP3+lkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29434588"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29434588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:25:14 -0700
X-CSE-ConnectionGUID: VX+LSz69TXa3ZZXQLkakCg==
X-CSE-MsgGUID: WbZjjIlaScKmtimdae3VhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="111194107"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:25:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:25:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:25:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWEMkpPadpUjfpotFCNma5gMiKUFuFSgrFLIEankwFAc7DXXL86vzAPwG2rA569S3g7IRGdq3uJmPP0WWnbyierES0aH8ihLVrXXc5AKZBBl4xZfH5+a/2+cZkl1c4MhLi/orWovPlaAQE2o7Nfe0OLSeGtGo5mDEqxKvPUqG4ZOS7y4iU7yXr3OtmLKFnKVniLIVdP9RZu1Y1+z9HRlRqMw0L4SR1lsC98yotAc6460PuOftFXaH8k9jZiKKcx9hYcsI7ZdVU+WKNsWQ9wNGgnOM5adwbX8c73qBtLs7g4O2FnWPdcLCI9C316m9komcjfmAMumeTQcqlReWC12cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8kYXPBhp+1EVxKw27PrkyQ2MBbCSckvQeq4QOvlMGg=;
 b=xkaNKryQ+FptlOQcpoJWZf3AbznULWZgqKUnhGjXNYRR0rgHZZs1scZn2h6gxRK4uVn/AgptPxVqTWYl92K/XDeRcQ4VO0CB3knVtsWYp6JE/QmVAiJnWfGdb8dUDs0QYWW+HrN4Wh77Ur/kqhjJ8xfOTQej0RbKiv9UDjmgpOvwaUhIdobVXaWjxX5k7FLcLGjeTY/QSiKIn01bABC/0TOhYHRSkyKyjtKirl2Ix8XOFdLD+J/O916nJ6LAZn40bo/uFAcpxDvL+8PnPl+1mm7tZ8/TTOGzfRFp32PkEBV33KVMK/F1wvJ+31ZPCbKY82jnR4JGURra+23hfnxmtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 21:25:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8069.031; Wed, 23 Oct 2024
 21:25:10 +0000
Date: Wed, 23 Oct 2024 16:25:04 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Sedat Dilek <sedat.dilek@gmail.com>
CC: Emil Velikov <emil.l.velikov@gmail.com>, <linux-modules@vger.kernel.org>,
	<lucas.de.marchi@gmail.com>
Subject: Re: meson: always pass complete path to kmod-symlink.sh
Message-ID: <mnt2nwayrvsccxfgz3gdotna6i4w5ldi5fiuyyvwovcduacbmw@mihqgpmb3y7t>
References: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 745c1194-a0e8-48e9-a764-08dcf3a92ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7800dqM+iMDc5zRb9IDUPxnIQwOk07DrUCZw+D6eS4EEc3OaQgGXoko2HJSR?=
 =?us-ascii?Q?Dda+bMblHSSo/2o8gBBU8193IkN9GhKPVoKp40NV/Qf0pbJl2GMU/n8rXrqY?=
 =?us-ascii?Q?6db8OLeAJWfODFgnYJTBlvJxN9zWvQDRJvNWTyqoWqMF3DElODTNWTjOKb82?=
 =?us-ascii?Q?MGugl4SOhvBc5qjrLUN60QOp1nRjVhzZXv5uXWtL2a1v/trLG4Pi/2o2X09z?=
 =?us-ascii?Q?atbpUorVf1L3eg81JJyTEVUGSFknTi3peJ8opdgCOb+vtaVv810Ue4KLi7z/?=
 =?us-ascii?Q?St4qbw0Mlsx6c/bFvAXrob6v2hNuMe6Uyubs4jOXrRWd2/f00DfBJNfn5Xo5?=
 =?us-ascii?Q?cpBCmuGhRXofNxOJJbc0f1hoaTPDU+xSAgguj7aabrzav+d2iHKDZ3pTarIC?=
 =?us-ascii?Q?TunIVLzQqHzLa6Vv4XvyKm3oPdIVWHZYSFR18auQDKTjwTig41RugWzGvyXk?=
 =?us-ascii?Q?cKreAP3owbluP+14h6prV7do+rHfgCsP2EK3IrLJbpUyf2TUYrHV0HjJPdaW?=
 =?us-ascii?Q?PdvTeD2oIGw+51u8bx8C6R76Pa9qpCyiSNjnnKdcr5xOItPA1GYCi/pYWh35?=
 =?us-ascii?Q?ELEEUiqkeHul14ec2lEpiRmq1GVlQbgBV4vKNdXbMz52xuWeb4q7MorB03YF?=
 =?us-ascii?Q?cDYuPeuDZmCa39Jazm5OOYe/Y0Okn0AWHp3nnVp7lvNG8CRSwCf1+WANKl3n?=
 =?us-ascii?Q?RkhYlq+yrQ8flK5uCiKF76GZTZgmjQcZHCfBrpLlGeGTW7G87OpAnDLmfPVX?=
 =?us-ascii?Q?6MoPI6SG1wPwNi5DT+Po26XWqYLp62zSItkYDvY8v4uHeqBR06zG9tadjZVf?=
 =?us-ascii?Q?Ri7qpvzS/LxTimTA4VTXz5wpBA6xY43X5KpprFN/xIazLLRidVn5ahNnYGk9?=
 =?us-ascii?Q?vJtWMoQuLx8gSHP80wseSNfSM66TSiuXb5anMvntqioXq5hkeapHbCLeCk66?=
 =?us-ascii?Q?Kzw0zkxXV1i77FW5K3sWoTITDJpJFhR7VTfy7m7lgq53GmxoOOzj0g8ZrZXE?=
 =?us-ascii?Q?uQHz7D4qRezEip6hg1Wk6QmMdmzbodzkCYZDeOmb3ArZX26xRmP9M+ojsJnX?=
 =?us-ascii?Q?bo2fcChX9xSQiQqKBQpQIVVM2wy/mZkLyXLnh3AFmp0yX+SxatUIYX8G36Ya?=
 =?us-ascii?Q?8BDKWPrASjusSRocgMrE7IcZDBZ/jn8MwhJ3VhcMipCHFTphn63mETXkXOfg?=
 =?us-ascii?Q?O4A+BOm5I9GuZ3ttV7ycb2sEWgAvENYaamq80P/K3wu5zBikRhrc9CD6dRAE?=
 =?us-ascii?Q?bPKzPpvvLWNP/Uo48RqkvpwoBPvJZcX1ZYgsBQoqkLfsVkFKjcMPsAUNOh58?=
 =?us-ascii?Q?Vj7EoQXEKzWmweiDEl3ViA3o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JneEp1pfQdloVHo7ST+c9kbYFOI5jgahsezQECbIOAqQhmTIHsxHw+KMTZI?=
 =?us-ascii?Q?Gw50O/s5/dYOEBCjo53xM9LDlinhs/2poMH4lrBAWZtnIrPrg585hTEC8QIw?=
 =?us-ascii?Q?WBYH65lpA9dkwKL5j95pdFNHH40cxQNWOpDWP8+ODM0VrnnIU41RNV+PTR7x?=
 =?us-ascii?Q?pl8GMyc3N7yE/de/zg5wgrGMGLqSnpCJ7pmKTg2M/XEJQFtPF6h5t/ItcEyd?=
 =?us-ascii?Q?n3sr5YZ3z+8syRmok1QLL5LfBhyffbJ6TbTniflsbtB1suwO7EoOpSaNjxae?=
 =?us-ascii?Q?9va+LTaLxpbfzB5DhTO568EWNqwtaJb7mpTua0hBgKSeKz7hcMRe8zDvQm64?=
 =?us-ascii?Q?2H3EfdWti8E0pqWZrZjEldD19QM2VGO7oyMemIACtF9T2KlI68Ejhh5hTAlt?=
 =?us-ascii?Q?BjcoX1JelkeZ+Wog00beCD78sc4THwuH2ityibn1mPN+TL5vWmB4l01o/W0I?=
 =?us-ascii?Q?pJVf9e1G2rVxj3pwfiLponhTqy59LaUg/3+itAgtZU8ACN4BJIZwnyZBrkZ9?=
 =?us-ascii?Q?X+KiubvT1yzHwBw3TOjweQhtfMmXZ26KgIpH4jKctVId44dRzbWEq4nXg5lr?=
 =?us-ascii?Q?nuLQBcf0eO9hkokiCnlCxEUGXabMqf87nG6wJQQzEftqKL3Oran9H5pO3VOI?=
 =?us-ascii?Q?i3pUG+wh/dFIryCu/XvBTXYzEp4X1FBW6anCWRPHj8JoosJ/VnR0YAlkJ5Xf?=
 =?us-ascii?Q?y7NC7StcELSGALLioP0T5kWJ2HUvoWiwz7TxE/3/YsM3LsAsHN9KuP8tzlnB?=
 =?us-ascii?Q?Na9QuRN1p7FuK4u7ck4P9jganpe1xeFQ03oilN1JWV86v0A0uq55Wen/tyqR?=
 =?us-ascii?Q?Yc1DIJPGb3VD1H3Xz5Y2O5a+MDrw8JX2yUBMS/wCUP2qOdm41M1hJz2sZkDV?=
 =?us-ascii?Q?33MOWRopdpa8LakgpO2ZNgF/ENejwHJMrAQmk+6dMl35nuZHoOBCN9yGr6/O?=
 =?us-ascii?Q?x1EPfrqaT0qlxpy7gep95IBXj6S8XjcpjWc0pY4GEQjpaCWwtexvQjEjmx2I?=
 =?us-ascii?Q?KDinIU3lW0pr9H1vOR//GSdfp1Rc5S5kUxd+SDVYj39t6KwaU5WAWBA0CO0z?=
 =?us-ascii?Q?B2E64tKCoC9vDP5xX0D+kp6wl8s2tqSVl77sXpKdSMmpdgmuL4ZJIZi5A53O?=
 =?us-ascii?Q?FZvJ+aX/bE5DE4te32KEAuNw2aDVp6QhW7lbXZS+/8Slxq4yDnoKSBjbe+FS?=
 =?us-ascii?Q?TxcXKBOCoU5PKCBQEOIwg7p9fWBp2HjMzT1HR/DuYhNsUJBXxpqwm64pzHQg?=
 =?us-ascii?Q?JH6hbaARfBJ2JmXtrTldPZkKWNuKKVKvuRfuIsW8t+XIkqqC6pgXLCUQIDiS?=
 =?us-ascii?Q?qsoHBAXkN+6J3aTOqajt0q7LMKmSXmRd+Vw8ZGKwYRZBXd/h1As4MFsNaLBA?=
 =?us-ascii?Q?Y9eAo5j8VfiE5KTBIqvVN3yWcPfIz7UTuiGnxuQm37h+Aw5Pwsc2JRO2ZFv5?=
 =?us-ascii?Q?bKo4/XNPs5YmkTKhG2iQXfagCTzXXLk/rcB6Um8NC9xHsJC0hz4qb0Unp74q?=
 =?us-ascii?Q?WgaSlnJwXT2plXns3CybLV6661tIB/s1k8jXsR0ANa7rf94bpa5bn8xMxj90?=
 =?us-ascii?Q?/1IjwFCSw/b/28yv8JbuxDFDTP10r48NHBgjWjyrhfKxn5fvOzllnXaRbO2H?=
 =?us-ascii?Q?9Ef6SYI+qMP9qwV9Qzb0tjKssUlun7xeN8ycDd3fMIkYDyngLG8wSrcRDuYr?=
 =?us-ascii?Q?C5n0kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c1194-a0e8-48e9-a764-08dcf3a92ccc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:25:10.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QAW93D/cDIJf+KsqWh+fZt7SWQz6uK4R+Wo/BEKPxU1dXHrCl/q8/Dyo0ZjH98Fj+aoakIanbU9xBfdhQYC1tLZOSWIzaXpFokp2NMuIW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-OriginatorOrg: intel.com

On Wed, Oct 23, 2024 at 11:07:49PM +0200, Sedat Dilek wrote:
>Hi Emil,
>
>commit 844835cd9a4e5f08e1a3eefb4928c5d769264894 breaks when NO DESTDIR is set:


This should fix it: https://github.com/kmod-project/kmod/pull/206

There's an alternative to let meson create the symlink that depends on
meson 0.61. Maybe we can go straight to that and remove the script.

Lucas De Marchi
