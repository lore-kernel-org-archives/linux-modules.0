Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402A83A19
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407657; cv=fail; b=cQ7vzmfwj1tBZVrI9n5q96zwNQRAMjwrDwcenm2wZ/Jhdy2r+vmOAU3cV4yYhwTPy4KJ3PJgkvqSJqatE+qSxMTlk6b83PVyNXCNeUR9ty0LWYesHFZU2h7Y0z3e1RNOD61ZrLXymkOe7TkPngVLMnjHkUkxpQI889oMrORsW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407657; c=relaxed/simple;
	bh=1sSUPH+Cal9U2yDJdK/+5H0u59gNZidnFSnXE89WIj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y58mP5HQ35Kgykast+FJv0XcVrgURflMrxkf8oT7oAb+b/+ZJ4raqGvOww4t65J46efz6hmbUeMLSjvZKsZPa4JJYEdFbV8MNISq0xmIpiYqwwtM55mbffVSQCNJZgHZQIFoto9vCVFrlDujlAwmlQri6BKw6g/SmvSc+3bfAfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzhrB8zt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzhrB8zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721407655; x=1752943655;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1sSUPH+Cal9U2yDJdK/+5H0u59gNZidnFSnXE89WIj4=;
  b=hzhrB8zt3QlEk5gSnFblf9TOnAhcvKwCiTLM7EKY4YqyO5Yp2w3msUHr
   44SBiowvFuQlsh1+IxArVYRTaVvD0SxVV+VarSkpFO5z67Oe+rmDTkloo
   X5P7MU9zYud39j7+Lyg0Sg67qbTaHedEk+QkPnVNRlRXLlqgLmKjLqi53
   j3mNb5Nnlpw5ZSqBNHoUofsvChsgBTDBiHck7+nGyqrAVdbRwfZCjVnNr
   znvZBbcS6JcrJxKGYR8+sfWXRMPZcwc2DGED8A53REG6lJNgpRmdHhDnK
   4ZJ5vMg+Rq3q/I/NTnYwyA0vFCp+OGf3Ghsht6VY9KcsCX5qdztW3aca8
   A==;
X-CSE-ConnectionGUID: 4sPuUpLuSd2bkjf+Fq3rFg==
X-CSE-MsgGUID: k8IyAUJPRTOlxPYFHVXpyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="41555440"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="41555440"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:47:35 -0700
X-CSE-ConnectionGUID: VJUQbGKeRl2YMpR3fXXa8A==
X-CSE-MsgGUID: K3qdc2oFRSmkVFY9FyI9GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="88651242"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 09:47:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:47:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:47:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 09:47:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 09:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVNflFUpRXBPTiBHcFjC7HRKXwT26GYKQFY3/Qk3Y+jOYIsqso/fOOe+gd3DRTjfMyxfzuSiaU73ND1WgZDvyqUW2e9i3ObGSH8AVOX8lTaJ1KUev0Bvm7U4mdmQR5LMDKvdK6e6JuWghGYBNaX6yuxSAKGyskD2zDhZdiFueR/e0+hMBzgPAtdVZ6MHK+PIKsDa41nnTdNOX+ymU9uk9e5Vz9PBATAhMPtf4ke2K27oajT+gkgtxkdEdNzMy3Wfol9b1thqDGt+RqJT8DYXdJSa2ppP8ymfCnp07a8UaLj0vWtjNVOkeZHTzMXBf2rPJrGGEP+7krF/yKcRV6pGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgPON5Isy1PEFGIDvAlLUBpvv+s8v0eh8X2CKyqpOdM=;
 b=VZLMgI2fdEREOZRnLg2MmhDDSJ9af4bcXx8v9HlgIXP5uiaW5QX0rI11oT8R28iY1WpELJe+lUKVhSSSreB4ygnW4OhMJjVeCUO2VSKhsimsksp5fQKQ8U7wkAQA/MyndfOVpgIV8QYbPME6PImb3FOL3MeIvQhYVrR+8xo03Wq1ztBveRRE6CwfVV0O5r6KOXWZX+mJfwUtQrweifUv/AYNbbC2fUD3blp47VLR5V1gGMrCN9nfVemHvZsiZmTAajwTId+gTVVEqfT0jnlarUUom3jIXaXvCSzwK2WKXdEXDSNA52fijKNYpLB1K20mQzKfLCSYVIRrZFpeFmjwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 16:47:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:47:27 +0000
Date: Fri, 19 Jul 2024 11:47:22 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Marco d'Itri <md@linux.it>, "Eugene
 Syromiatnikov" <esyr@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>,
	Yauheni Kaliuta <ykaliuta@fedoraproject.org>, Alexey Gladkov
	<gladkov.alexey@gmail.com>
Subject: Re: [PATCH kmod 1/3] libkmod: document
 KMOD_INDEX_MODULES_BUILTIN_ALIAS in kmod_dump_index()
Message-ID: <z67zhdkotvjg4nq6nd46njqiofomxr6nqzks6usamkkjszcbf3@lskfgq6esgyr>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
 <20240719-abi-fixes-v1-1-1e6d99a2846b@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240719-abi-fixes-v1-1-1e6d99a2846b@gmail.com>
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB4813:EE_
X-MS-Office365-Filtering-Correlation-Id: e546fa64-5cd7-4bc0-67b3-08dca812790c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4moYVZa3VTkL4Zx9zpH9aZdeOzLuFI5Rr3L3JjReazlrrkcM4jQT11+sRpvf?=
 =?us-ascii?Q?uTq6FBjKHe0vIIYsE3EAPdrE5V0sAyL/kVG7m7xTdzzVduOB/G76bA1Pqkr+?=
 =?us-ascii?Q?bkw6KuiRFoazNvm8FZ1u9xXal9CGq0LztRTRmbCbTjhwSTvZkHngwOJveAdt?=
 =?us-ascii?Q?tMTqNsJgErivuVhKT3P4n59QrfJnpq6PZA2Bk6Ozruu70JL3x0XcJ9zyivSE?=
 =?us-ascii?Q?wOLaB7VDzMgeZzWEOflbJtlwqmQ0kZdE8PO3nxw30/92mzQDneKT7wsR3q58?=
 =?us-ascii?Q?0XcJpUMJhslr/vUmnCv2joTTlMUUB4ZyqMdw8vYxaVMc+bdoWSLpBL99RfEm?=
 =?us-ascii?Q?7JL4a75jlAD+i8Ux06HIqydV7oJlEWentpNNIvfftm8WwP1ej8JqmSR7OQwW?=
 =?us-ascii?Q?CPOOUkAm2kbR5uyJZU1suY+PKsd5qD+eGnMCzb3x9wtSO/JX082xnivdlpv7?=
 =?us-ascii?Q?FT6267yiea+kb+G5lM7RVmSYkodGV6vJ7QBcf55GvepoYy2X28cMsfwhrLS8?=
 =?us-ascii?Q?DeRLHjKufZq/XG61KhMB03j5+bL1bHNJL56oAV8DdczMpGb8WeXbGl9omYL5?=
 =?us-ascii?Q?tcwNCwjA2zmmIOoN4Xp32cnoI2ht/+OVAQwpFzWVWs8jNft6PqraHmXligtU?=
 =?us-ascii?Q?aCnXYMm/pK3bJU+3ACDsm8GCHHWr5YcvjvyhN7kvimAsUgnXrK5w07/twHXH?=
 =?us-ascii?Q?RNg8yvAqAEcfuFvWAjSg0bjibvZQXsZHv1D1+lMRAIrDiC2THKfb/h+EnDGC?=
 =?us-ascii?Q?fistzUrcoihgEJAJ4wo2tQ80vx51VIRS6Py7cN68eljR/ehpmvfkB11mnc31?=
 =?us-ascii?Q?GBaeXzwEODrKAEc/7ItvXA058+1bFRR/Es2/XA8N+1zRsvl50Lzn5nctOCC+?=
 =?us-ascii?Q?HeadWj55YdP4FlrY4QLbjDTvUr9rmuGqw7YUtUxheY/oNU2996YhXVGRgpbT?=
 =?us-ascii?Q?YGd1eBg7XZtCCvkEQfHLVHGSLQexSDCIVdAgXLnCyDuS08a4puFe0I1PSTa8?=
 =?us-ascii?Q?KEbdxhsQv9v4R//OlyWu+JJGVYkwcbUsoavfvYUfS57Qxla/8JnLI5A493gV?=
 =?us-ascii?Q?eqDNMJtbZRBIVTR8+Ju1h8cECDGv68Hu0Kifv+PW6YJnozjelC3NjrcLYJCT?=
 =?us-ascii?Q?EKHGp0PBS/7qcAgoYflEa8C2PgMbLdokkwWlyy1eBX2vuRuBHxK/CcWiGvVm?=
 =?us-ascii?Q?acW9wTfCkHw6OUuddzC2Dny2g9YDupSay973vfkS4C058IrYgAxqbyCfC+Nv?=
 =?us-ascii?Q?yrYVE1MtFEQIX/VlQX4wstFuHhmiF1qBWWDx4PQ9t61f9CofqIpkL2ehArCM?=
 =?us-ascii?Q?5Zk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCymuZmdaQDhy157C7+lnTAo6K4p4RrkNQ9yPYx5FdNdUoym4qgG6Va2eY5g?=
 =?us-ascii?Q?13Ljig6oIYyJEEv0qhPP/NiXYlGwoQDBGYQcTVldxGAM6K3WymY0As6ILu/M?=
 =?us-ascii?Q?z6VWGXKLxh/IBhFLP2qjm2/JK+y51tpNpydCB5J6N0E71/qvxOoimIMbxLmV?=
 =?us-ascii?Q?7lfYZ+lbjrUcfxUKRuVN2muPiurckOXI7sVkqVM5xBXmzKhMeosuHCR2tJtg?=
 =?us-ascii?Q?BSUcwYZyyqGSMVkABeIxXuYrjUE5UMGN5CY0nooQUkAR+s74rwqRNW34aaOo?=
 =?us-ascii?Q?CiFztGc0pIbxNK5ZPq+arx9H2dwgZwIZEtFv+z10cGn5QpYCcqxT8I1QMBOq?=
 =?us-ascii?Q?d3cUMNeVhb5UcE7QFPSq6aAcW4oXpHi0l5VAVyl6v4b+KY6kcf143Ic7rQec?=
 =?us-ascii?Q?fh72k1YxnHgmDuR5ic0hL4migw+J9gO3Wi0GuFGO6aoxMKMd7u9ucvcFltdy?=
 =?us-ascii?Q?PU5Qgg+A8AQWsCpQywgVeYt8UhjADPyBHeSvFTQx91s2e/JdFDJx43giQDIL?=
 =?us-ascii?Q?1PPWtn+NdN1lZq8Y9YzBXO66Hg2C+pRkX+6gtuv7tHx1n27mwxmAEruCydyb?=
 =?us-ascii?Q?7xbcDfMw8pGzLyEwMqtS2yGRE64fUFr4eV4SXQb+9GYaKPAzMHDU9UG6pKhs?=
 =?us-ascii?Q?IRlmUgm33ysU6/q77WthmOGDyTS46m9n38F/XXqX+jDAuzTtmvmZq3rkK0OA?=
 =?us-ascii?Q?bQ4RwKUoMWfucVfYxbHOhExmDj6gTHj4nNKKwbjjKYRZoi8rmLliRbaX9NYE?=
 =?us-ascii?Q?6vtfd0CJGMmYWYltR9Cm9JwNM7FIIH4BLICad6rTDdt8ZoQbNEtrxA2gev5S?=
 =?us-ascii?Q?5mEAaprf/BKupe+Nm2Iuo7dAw1DgWRQKmjCGWvpxOIoxMCo5FnC64BI+qrmK?=
 =?us-ascii?Q?OHtb3afRAo0IeU0bw5u1S3FREJf6nPcA3QkOWlaOto7r4oES/GW09hsClD4W?=
 =?us-ascii?Q?LWxCxBwlN93OkO4GOuZWTP4+GxGAEovZJFAhzcg3cb7J7azM0xd9SHSVwLZ0?=
 =?us-ascii?Q?RIDLa8e4JtfzlYV6qce1FkgLytsJq1dU600WxxIXT4hA4r5zJYYAr2St0pUo?=
 =?us-ascii?Q?kFlnwCUlFHfOE4h+ybDNXE/3vmVLc2xIlhoWdG3HQsSnZomKWjj7hvZAWTRE?=
 =?us-ascii?Q?KRKDIzdXeHPq4gFqpH7eLzOTf5vTbgDKDhgIelW7ii0gAsUqvit3QUCJUZej?=
 =?us-ascii?Q?y/gKiZgp+dwuat/ei1fj+fI++P3ZdeehA2PYJ3pntbrCEs8KE8+GYUGj6T7h?=
 =?us-ascii?Q?Ejp661exAa1xnWA/zwjoiwbGOo7HnXvnusNd7ya5vKyW/C+EpP90IuyknC2U?=
 =?us-ascii?Q?CK6aPUc0hu0btSEYxMCiU0x70IVQriiuFV5vkvTuxRlhYlp4log1uLmsp2xh?=
 =?us-ascii?Q?ZcdUkirDqzlAjUb4enxioK9w5oalCe2G4TSN2vA6ulvOnrQHqQNHQ/analKp?=
 =?us-ascii?Q?5NxlIJxhjFwAXH87B+Snvk2GTA5WSdxycgR3m/Pmsk3QfGDe1FrvRlyQbhtT?=
 =?us-ascii?Q?1NSWr8Bq9M25F9/OY0NpnU4GkBdX+L+HecjD9tNDueYsPZkecy1bM8idACfN?=
 =?us-ascii?Q?JU08Hq4sZAPKfqlD8yEMoYoTXd0/TYwBRH8+9jno3Oq0dLPWyCpgS7eGde2u?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e546fa64-5cd7-4bc0-67b3-08dca812790c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:47:27.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn93CkPAet0AtDnp1gBJoKqoRcwAwZO2W3YqADNKQE98KrKFXx4Koh3BLDouOECekCbFFHou99mxps0sG1BFjaJBYGgPCgQq6ROkCZIId8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 05:12:41PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The extra enum was introduced a few years ago, although the (only)
>function using it did not have it's documentation updated.
>
>The commit itself has caused an ABI break with kmod v27, since the
>KMOD_INDEX_MODULES_BUILTIN value has changed.
>
>A search through Google, Github and Arch packages have shown one user of
>kmod_dump_index() - the only API that uses the enum.
>
>In that case and all others, no projects referencing the changed enum
>were found. Although since recent and/or supported distros use kmod v27
>or later we've decided to only update the documentation.
>
>Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
>Fixes: b866b21 ("Lookup aliases in the modules.builtin.modinfo")
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


thanks
Lucas De Marchi

>---
>The project itself being https://github.com/falconindy/modtree which
>hasn't been updated in 12 years.
>
>The following distros/versions ship kmod v26 or older, where bunch of
>them are no longer supported.
>
> - RHEL 8 + community variants Alma/Amazon/CentOS/Rocky/Scientific
> - Alpine Linux 3.11
> - Debian 10 + derivatives
> - Ubuntu 18.04
>---
> libkmod/libkmod.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>index 213b424..fecb8e7 100644
>--- a/libkmod/libkmod.c
>+++ b/libkmod/libkmod.c
>@@ -971,6 +971,7 @@ KMOD_EXPORT void kmod_unload_resources(struct kmod_ctx *ctx)
>  * KMOD_INDEX_MODULES_DEP: index of module dependencies;
>  * KMOD_INDEX_MODULES_ALIAS: index of module aliases;
>  * KMOD_INDEX_MODULES_SYMBOL: index of symbol aliases;
>+ * KMOD_INDEX_MODULES_BUILTIN_ALIAS: index of builtin module aliases.
>  * KMOD_INDEX_MODULES_BUILTIN: index of builtin module.
>  * @fd: file descriptor to dump index to
>  *
>
>-- 
>2.45.2
>
>
