Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F48005B
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612499; cv=fail; b=W4lqOwbDR4n7y7qdTdgKMA5mE3G7sE+m6XC1PXHYWtY+sx1zlq1bnU1VEZwnA3GsSrIrHv3SiemK1asRGuwNwP3Ub4UKluO1/nOgZVZCjr9V3LsJBE3wbC4ehRzbkKXZxY+ECRxbOsDKDPT2RQaGF+MtbBcSdwzVMvEVcVYBUnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612499; c=relaxed/simple;
	bh=IfBL/O38WgUcr6c+YSU0sFICLHqsG8NCaGIaBV5umk8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qIrGNogXJ+OnOdHRs7kyV47awTidkPBtK6FPUqbDdiHYikxt7pLMLcVad0WW9htMLtfq6WiCaG/xNe4n6LMh2TwNRkVcXTWbhtbpYs+MHWURBWDD9jPPB08uHHkVTJHmWjIL6jxw4/hx5wp+OAZ/9n6xnknF4NFRovSDShNt3Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpN/2p3m; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpN/2p3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719612498; x=1751148498;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IfBL/O38WgUcr6c+YSU0sFICLHqsG8NCaGIaBV5umk8=;
  b=FpN/2p3mpqwU3QoHbzjw4K2VB0QJzvcPc+u97pkrb+rvOk4HZc5pmHvM
   joLJKnq6iP3NXDr3bCuTsY5wRJVWBu7K5elKvyxah1r6TRFlEIvBaTusy
   dRYLViXeGY6HMboCWz6QIC5PJH/2RTeJOEGtzYg7HCR4fM/MK9o2wf3q9
   GTz3SNdryDyidx7ZaR5u6zBbv+OXMWynwKRkGPrcyAPGPXxkZqW+N2eSb
   u5BZ2DDOq0brX3w3LkhBG1lv/usS77U69poK8ZzGXxzJ7HwdgBuDYCLiB
   2Oc2WU26YLyjMV+Y02eUwvPJ+rb0loJgfc3XYT9Tbj/zoha7VILgw4nGL
   A==;
X-CSE-ConnectionGUID: HbBUzx+7TPG362Z634Byjw==
X-CSE-MsgGUID: IVT4gxMFQEOKsCwEdWEaJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16764360"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16764360"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:08:17 -0700
X-CSE-ConnectionGUID: bLUCUkWDRoO9KJZJwsjZOQ==
X-CSE-MsgGUID: +V8WkKQtRyODSvCBMaJTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="44751907"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 15:08:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:08:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:08:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 15:08:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdsWnolLIZF6CoDlQMFHRa1jVdMYUWv+J/p1djYDn5vraoIURS/Y5FbVpklVzkKCw8AWSHv7niygpGo9SPSeF73zDFu2yJtibwG7bv0B+8wuKA0yh6p3MZ56cj70QHvioc2Xmc+oG8UQTQqxL/nZkrHOpx356vY3mgzFqh14egfCRPnMQxh41Ru1ATZRC4Lhqxd2WyYxhtYKC3xknF8KnNoF82Hq+rRfPYOeZ2wC7tAtN349+Fay91uJszhvQCrSBp2UJRZ+kCzlxwYwI/wY0NYQ+QSp8DVLBvGAR2lvXNU8OwtgGXB5MRyBIjQt8ojpQRu5V7RPEZWTHZHOul7cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfXhNEWPUAawYi6P/onzVPmtcSLmAsqlWCzmZIlMLRg=;
 b=lTE4h2v4+42el0SUD2j5aZgFtNE1fyh/MOoJBpYMWHq7iY6P8Wsa411ZzcVi8j3xjwz0aySbqTku91BPna7GRMtLx+PXAA+wWMNgthiIR0G5VdrqLOTnSnihCH7+hclWNPa4KY59o9ufCpf6Gq6JID0tFEoauQsHMcHLNSlvi0/eGkiWdspp4CMVTZOeVwQsEgkuCucT2jVxE3Lom/Wp4j59ecaq/+Katg4JrfIDLdRzMZZEgk+15iCZMfWoUwxh0QXWgTth7Y/IJxwI0gtFgOz8NQVoQwfI14beIiDOAStbMnYcYOV7iTVBdNIQjEudUGXrUHR8UXGVq5s4ExkQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 22:08:13 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 22:08:12 +0000
Date: Fri, 28 Jun 2024 17:08:14 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC: Yunseong Kim <yskelg@gmail.com>, Lucas De Marchi
	<lucas.de.marchi@gmail.com>, Austin Kim <austindh.kim@gmail.com>,
	<shjy180909@gmail.com>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod: fix result of comparison of unsigned enum in
 kmod_dump_index()
Message-ID: <anmpwpc4qssqjyotdnlaq2a2wrryfiiebvcdgmijfu5wqrojy4@j7ljhrunxrq5>
References: <20240622061321.9005-2-yskelg@gmail.com>
 <20240624074956.GR19642@kitsune.suse.cz>
 <72c771f3-250f-430b-a7d9-f233e929ccd3@gmail.com>
 <20240624184612.GT19642@kitsune.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624184612.GT19642@kitsune.suse.cz>
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6703b6a0-c806-403c-52d4-08dc97becd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEFIdWZOalgxUzdIWE1Rd2xvM29ndUFnUUhRL0Vncys5R0N2Q016Mzk2WnpK?=
 =?utf-8?B?OS91N0lrR0dSQWlRMVJwUVBKNkNudnNPOUZIZlJBcHJNWTNwM0toYjV1QVZ3?=
 =?utf-8?B?S0RpSlp5RWhjNEoxcXhPU3FPWjl1ZW1XK2wxZGkzVE9HM2xlNVNWK09DRk1q?=
 =?utf-8?B?TEZydXBxRmxmbzJ4ZDBwYS9FK3E0clhKditjbnEwVkt3Rm1FQ1d1V2tqTzRk?=
 =?utf-8?B?OUNWM1loUHp5NGE3Ujk2bEtjOTZva1NGYU5JT1BpTzdBL0xVMlBFK25lZWpT?=
 =?utf-8?B?WGlzYndoUUlMdzVNdDVIaEpaSjZ0NmJqZmpWNVV4RDQ5QlF3cU1ibzhsYWVL?=
 =?utf-8?B?c2xEOUlwdHJKOXcrdG5UdlFWb0ZRNGlQMW5ZM0ZqSXo2MDAxSXNCV1VJdHRY?=
 =?utf-8?B?UVA2TEpKbm10OEphbERRby9LR1ovaEZ0amd4N2RUb1ZZNjNHeWJsVGNlc3BC?=
 =?utf-8?B?a0lGYyt3VnR3d3ZpK0tIbTFXUUkrMnlML2xIbkpmRHF0LzZDVHMxSWkrTndz?=
 =?utf-8?B?akFpSFloQTZsb2k2SXc2Sk1RYTRxL3F1RmFCMXYvTi9yZ3FYRkVxVnhIbW1T?=
 =?utf-8?B?dkcyMCtZZEkzcWZXa09DVCtrQmdrbjdqWXcvU3REWXErV2tPeks2elVjbzF3?=
 =?utf-8?B?b0d0QWxOSjhSdkFpSG5iR3BVemFvelJZazBscFZIYkZVSkxVY0d2VkNhMERM?=
 =?utf-8?B?TDB0M1RZSXRyUkV2dGM2ZU9yOTFpSTNrbHZtYTBUNitDUkZwdlVSQ1daMzd6?=
 =?utf-8?B?dUtIY3dvRm5oRDRpbExXNUlDT005aXN1enlBR2FwUlpiYXZZUUZpNkc5bEo2?=
 =?utf-8?B?dkVJVlUvRnJXSXowcGIwSlAvSnZGbzlveG9Wc0F5ODRTRjFjbE9OSHV4ZWtC?=
 =?utf-8?B?SlUycTdEZnFPb0dMTWcrY1R5SnhVcks3M1QxcExqemRjQWZrc2ZpN2VLcThv?=
 =?utf-8?B?NnZDdnJaZmg0NE5hQXhwQVNQSkR1cWFmZHY4MWl0cGxBRGN2Q2NIRzdiRDRw?=
 =?utf-8?B?NWlTOUczODJKQ01jTElUOXVvT1dsZGdtNlpkb1dUNENYNlA5RCt5Nk1XMGVU?=
 =?utf-8?B?dlg0YlM1QWtheUtITUtMV1JzMjA1UTJ5bDRwcVBzbDUvYm8rbU90Yko2QmVv?=
 =?utf-8?B?eUkxM1VmM1RnMW1aY1BBQkNNbWFmWUliTW9tcDR2eDFVczhvSGFXRWlUNFJ1?=
 =?utf-8?B?SllIOE9SY0hia0FPSUxrc09HK0hWWjNwZWtFZmpXNW9uTHk4WlBORmVxdU44?=
 =?utf-8?B?OWV4d1VHVVk2eFhQN21nRUZMcTdLd3BpNEdabHZhM3dCN1BYekF3TXdORjBL?=
 =?utf-8?B?dWFvb2hFRU1hdHVocnZPQXEzTGRkK0REVHlqazc1aGFlN3I5Nit3MVZFODJk?=
 =?utf-8?B?TUViemNGajRScEhZMFdreWMySVlNV0xoQVArT3l4VDQ4LzFORjM3NTRwUk50?=
 =?utf-8?B?SkQ1ZmE5bW53MDQwaTlDSHh1R01NRTNmdnpSQUdzWXJCZGZ0YUpBZVc4WUhX?=
 =?utf-8?B?UEdwS3hLS1lJdWJQV1hXRzJkSWNueVRtV1hEdklwRjRsRHlUdkllWWRyTlRK?=
 =?utf-8?B?OU9seE5YV0RFRUZLNGdqa1MzektsUUlWb1RacWEzNFZvTndkREFPZVowVnBi?=
 =?utf-8?B?NXBoNWtkNXQxdTFMdjNrVzRHbzZ2TytnVU1qeWJmVllxRVFicWZMYkhnbjNp?=
 =?utf-8?B?Y1pTQnZaTG5CR1pXd1pyc2s1Kzh5cHFZaTZIWWYzKzVBTzIrYStqTTM0MHZY?=
 =?utf-8?Q?945uvoAT5ph32qton4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lmZUkvSFd3YmNoeFFvMnJJbUxxNDdScmo2Q1YxWU14a3dmZTJ1eGRmS0xi?=
 =?utf-8?B?UFRxMkdPZkpNYnJSUER1NXB6ZzBRYkJ3Q3l1K3hDbVdibm1ZbXJHMFJaOUtW?=
 =?utf-8?B?YjB4bjZsdVVmL3Vsa1B1dXpKOTcrYmNDSWZLVGJhYjh0UWQ1emVXNG8wcUNl?=
 =?utf-8?B?YUp6SGRjVVh6aGljbVBNcHMvTjU0VFBiNkR4YjZpYVZtZm9reWhOaGxWQXVR?=
 =?utf-8?B?U2hmc242M0kzTHBnbmVpZkxBRjFNOVg2a29rZ052Qy9pckRreVJ0LzlWZ29O?=
 =?utf-8?B?Q2lFMHN6aFpsV2U4M1l5THJFdXNscUJsRHJmS0QraG0rM1RIdVlzaFZpaXli?=
 =?utf-8?B?d3BWME91cHE5T0ZjRzRtVHFPMjVaa2JoRzkzVUcrdmZxU2gybG5VUmxla1pB?=
 =?utf-8?B?SytySnNoLzU5bHlmZHVydjVibEVKbXhqRW1uOEpHV0YwMjFRM3MvL1B3SWEr?=
 =?utf-8?B?ZDNBSTExVERyZVV1VGtIRVdGNVFaL1Q1dy90Y0R0THp5WEdOclJCa2gxQzV1?=
 =?utf-8?B?ZnllS3EyYVdWejRSbDZIb0xVSFVpUFBrVkNkeS9TZEtnY1pRZk1rL29QbGNM?=
 =?utf-8?B?ZWVtZ1lnR0JqcTIwbkFNS2QySm5lak1XMWpKc0ZxVWE0UUlwZ1ZUODFWQ3Uy?=
 =?utf-8?B?ZTlMRHJmSDZDRFRVdmd3YmhKZmxkRlh3RGtSZWxGNUs3MUtqYmFLZm5jdlkv?=
 =?utf-8?B?QVk1OHZpUWlyZXowNmdlYUpXSzk1RUxPekRpNzhrTVNFS09ycE1SZVNERGRN?=
 =?utf-8?B?cnFtcjlaR1VMQkwxMGVjSVUzUEEvaytTRmJOd1JTRjJnTUF2OElGREl1aFJp?=
 =?utf-8?B?RnhtR0Y0RVlQWTZmd2M3dElKNldyZ2h3STVkZERyVk9GM2tINUFQTCt2NnFZ?=
 =?utf-8?B?WVJ1bUN4QkZjemJkT1RkNXppOW9UTVFLT1kwY3MzWWR4eXQrWkQ0UHBmL2Mv?=
 =?utf-8?B?U1ZLdTBUdm9udERLY0RjTlhQelVKYkNXKzUrMDNBMlpyMDNBWUN4VVVPQy9h?=
 =?utf-8?B?MVBkM2dNWXJ3LzJlZmgvRkJweUx3Ykc5cFB1Y2MrcjBHVDJhZFVpdGQvd0Qr?=
 =?utf-8?B?TlllZ2UyL2NsSDZBQWJlTWM5MkF5NnZNeGIzQmZGUGxmdzZjNWhVU0Npa1RS?=
 =?utf-8?B?WXE2SDd1R0RFV1lmZUNCV3l2a0VZOUtwVzNXSkV4MlhHbzJYNE9ZN0grOFh3?=
 =?utf-8?B?N3VXbTczbjk4RDMzZlpQaCs2ajVsdjc3Y3BMb2Nzckk3azdBR256UGNLM2Fa?=
 =?utf-8?B?bFhlNU92L2ttWmZqcjBvRHY3V3pCK3RwQXdNdmRmQ2tsaDA3YmpjOVc4R0c3?=
 =?utf-8?B?aUZ3TWswSlE2SXZMcnlyWHVxbzV6eWpIRlg4QUhaTWxoWmlOY3BqaEQ3d0Vz?=
 =?utf-8?B?K09NemNpZXdoTzcwVjR4RG9iZEFjUGdnUS9tbWlGUmNaeVBBendzaC8xb290?=
 =?utf-8?B?b01xS2R3Y245WnJZcTdwKytZRmFscldNSTgweWgzazBsdUJyUXFHUG9mZ09U?=
 =?utf-8?B?MEVDZE5DUjBqQ2xmeUFSYjE1bldFQmlEWUhLZUNoTy83U0pNbm1RMjN6NzlR?=
 =?utf-8?B?anQrRWdVdXRsTjhlTjV1TUhaSGhVdVpZTDM2VnVUanFlK0JTTnpRV1p3WkM5?=
 =?utf-8?B?am5kOUY1RXIxeFZwbHVoVW5rNEp2ZlhYSzR0Z1hGK2FmWFR1czlMQWJJdXFw?=
 =?utf-8?B?ZStRNEs5SHh0RGJXWDMzTzBiSzV1WlA4Q3dDQVdITzM3Wkt3K0JLTDJHclZM?=
 =?utf-8?B?ZE1ZcUpFVUUyaUxHZ1VNZFRzZ1U0ekYzZDJpZjdGNkN0WUJ6QkI0QzA4dTVH?=
 =?utf-8?B?QzBuS0lubDV6bnpuRERwc3NJRkxFaU9yTHk3T3haTmZONVM0Ykg4cll4a29N?=
 =?utf-8?B?cXVLeXNCL3A5WWtGSUNJSzI5SzFLbVIrNnV0NGpiMHFVQThFSWErVG5ienpa?=
 =?utf-8?B?aXBvOGdIZHhMT0dNWXIyd0VFd0F6bzNjTXBjRGIwanhMU1NqVmZwRXVyYzFt?=
 =?utf-8?B?cVoxcEVFT214VUdhRXpPVERLdVJXc3VlZTlhL0tFRnBOZTV1Vk82TFQycW9z?=
 =?utf-8?B?MnVJbllnODBWZzM3cHJhRENaUVpsTDVYV0pHWkx4aGc3NEdTUmQwUk5Sbmd1?=
 =?utf-8?B?QXU0QjhWekR6QThFMWQxc3RBWi9rbWR4WFpCd0lwWVc4NmJGNWFUTjloTFlq?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6703b6a0-c806-403c-52d4-08dc97becd85
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 22:08:12.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnPKTx0CsPz082jGN3kK6NPaidLnLS+U0LKRJW0AuLh9/ZezpOecfV8Ft8FfHsUp1GinStr7KaMtR3dh9lG0KZA//8dSuEkFYlTlk//wdus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com

On Mon, Jun 24, 2024 at 08:46:12PM GMT, Michal Suchánek wrote:
>Hello,
>
>On Tue, Jun 25, 2024 at 02:40:23AM +0900, Yunseong Kim wrote:
>> Hi Michal,
>>
>> On 6/24/24 4:49 오후, Michal Suchánek wrote:
>> > Hello,
>> >
>> > On Sat, Jun 22, 2024 at 03:13:22PM +0900, yskelg@gmail.com wrote:
>> >> From: Yunseong Kim <yskelg@gmail.com>
>> >>
>> >> This patch fix compiler warning in kmod_dump_index()
>> >>
>> >> libkmod/libkmod.c:989:11: warning: result of comparison of unsigned enum
>> >> expression < 0 is always false [-Wtautological-unsigned-enum-zero-compare]
>> >>   989 |         if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
>> >>       |             ~~~~ ^ ~
>> >>
>> >> My compiler version.
>> >>
>> >> $ clang -v
>> >> clang version 18.1.6 (Fedora 18.1.6-3.fc40)
>> >
>> > If you look eg. here
>> > https://stackoverflow.com/questions/2579230/signedness-of-enum-in-c-c99-c-cx-gnu-c-gnu-c99
>> >
>> > you can see that it is not *guaranteed* that the enum is unsigend, and
>> > consequently a value lower than zero can be passed in.
>> >
>> > Consequently the bug is in your compiler issuing the warning. While in
>> > that specific C implementation the value cannot be negative in general
>> > it can.
>> >
>> > Finally I see that _KMOD_INDEX_MODULES_SIZE is defined separately from
>> > the enumeration itself, and would be prone to getting slale if the
>> > enumeration is ever updated.
>> >
>> > Making it part of the enumeration so it automatically gets the value of
>> > last used index type incremented by one would be probably less
>> > error-prone. In the kernel there is also a pattern of defining *_LAST as
>> > an alias to the last used value in the enumeration, and then
>> > _KMOD_INDEX_MODULES_SIZE coud be defined as this last value incremented
>> > by 1.
>> >
>> > Thanks
>> >
>> > Michal
>>
>> Thank you for the code review Michal, I understand your point. Would it
>> be acceptable if we don't need to make any further adjustments to the
>> warning?
>
>As already said the warning should be adjusted on the compiler side.
>That is either report the problem to the compiler authors so they can
>fix it or disable the warning with a compiler option if it's bothering
>you.
>
>> >> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>> >> index 213b424..fcb619b 100644
>> >> --- a/libkmod/libkmod.c
>> >> +++ b/libkmod/libkmod.c
>> >> @@ -986,7 +986,7 @@ KMOD_EXPORT int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type,
>> >>  	if (ctx == NULL)
>> >>  		return -ENOSYS;
>> >>
>> >> -	if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
>> >> +	if (type >= KMOD_INDEX_MODULES_DEP || type >= _KMOD_INDEX_MODULES_SIZE)
>> >
>> > Why are you adding a duplicate check here?
>>
>> I also think my code is really wrong. I'm sorry.
>
>These two are defined in different files, so it's understandable that
>you might get confused about their relationship. Defining them in one
>place could make the code more robust and easier to understand. It
>would, however, not address the warning. It's a separate problem related
>to this enum definition.

yes, but the main issue is that libkmod/libkmod.h is the header exposed
to the users, making it harder to maintain API compatibility since the
value exposed would be changing.

Lucas De Marchi

>
>Thanks
>
>Michal
