Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECF18AEA
	for <linux-modules@vger.kernel.org>; Fri, 26 Jul 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016576; cv=fail; b=T85nnhnrXniAG3Jq3Bq0g7Itc4bLcg3XeDbC0YS2Imvkj25n8KjdrTNgsJm0bNvPS32GqFmUzY2fxmnueUeY9oNyq5a0EC7VRynnd/P7WroF1x/NOb49RPEArKlQuHTI9VuPVZN8aIcSqG3Zcyc3Xfpy6gsgjQUAuUSxK5/vE/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016576; c=relaxed/simple;
	bh=ZPGiRi0V9KlqTplXTuMuG1QI1AtQ/DZuDUKZFdrHMRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPiaxXqhpkSK3TgpP/AmyOYTAGe3NfHXCsuCH6ySGmvwKm26ywpBIg+6+3KNepUmBzNuIfXT8i4omAEJGB02HZT8VTrIwhaaC4guaLRNV2K4moV/pWKqimTk1MapaxaRYKfjKXaExjSTixOUS9AZaRuiMXO5c0/7je0BINZnTHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge2dTWuz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge2dTWuz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722016574; x=1753552574;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZPGiRi0V9KlqTplXTuMuG1QI1AtQ/DZuDUKZFdrHMRg=;
  b=Ge2dTWuzRsLXwPowZy5ZgpT+Ug+f3hdWb9Q8f6P1l/VYCv7Hcnx79C9y
   rWXkHm7oImrGQnPsMQ4gLHCLKDlBqybOrB0w6vsch6Sm/5Pjyz1GnsAie
   YeAbmmAHWKGVaiFPbDmSVVyyYLM7bJ2ZkDRuQYBnjzoD4zZtT6ZrA0J99
   I/CoIcpRqRMkbNi3Ps3HLRfp8hFDhidVX1YYdUYNG8DeITdGlMQiOQiQ+
   SxZTSzu6pQdeyQcwwuwsu9vJzyKKKrMTyJXJ0wFWRX543umkm8QFcfZ+Z
   WiBqN8P0xLWa5kZd48W8HRE3wY25CTLtXt9IhLzKcUIcE2jp1b/4JxOpD
   g==;
X-CSE-ConnectionGUID: wfktAkniT1erBb7syi3+nA==
X-CSE-MsgGUID: 6qlQ8FLfSj65pxRPHBmAEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="19622854"
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="19622854"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 10:56:12 -0700
X-CSE-ConnectionGUID: sTttfaxiTYuh3wPtHt+tDw==
X-CSE-MsgGUID: U1cKmi9VRpW0K4R1z1wZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="83976278"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 10:56:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 10:56:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 10:56:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 10:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD2AXRBQpn6aqWhY/Ua37NsnVu2zg5TOvmfrjiI5W4jM8dBdHmQ4p4wR8CzopO8AXf8RA5PzZSlU9h10aQNkuL85A71N20mIqUmplvHJlS82U+CI5mbFQZI9SsfrUmZDO6rCQRWb7N/3Xlbymim14fkfbDDnIXUnGJv1X2S5vwFEuzj0Cwy0hKGCLdDDph/uAMKZbzmFDUglmblPh1gFhT+ZKUfYA2810/a9S+bzTE0fhKYf98om6HIV7yVfP/pRPZQvAMAGu9URN248F4v/NrVlVhP2u1aYq+qwfMBWZaPWOmhNPoowr5YQ3PLMQtXxCHtoZq8/DajY/kbi58ce7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8bfEC5ScHf11KZj43wUKfAIBJWn4AxlWOLS4D/4480=;
 b=mquFP6vxubFfEEEVzFOAdUzUmsOCMV0AQlgkQQeHyoslaWC9himYmMCrZua6rO3vg9CoG0sWQHgG+wUvkSaPqky2jFhoAvQk4l0kCYcHlzmsNbP0LdaLNTLDRRkSO8afQ64xB4RdkUuCi2JJcBjKp2ixJiE/ZrZnWYkrv2sHHolrdj4PEgLl60sI8tURo7+zsjjbXIntKwh4DnAgO4ONEiYgE1o9Yi/TeHqrZhSLAX0eADXE8H2zl1MdVlD+S6YZ+TgLL4d+LDGJIoVD4+hP7G8R4wU6yYIoIH/uVSSu6OLiwX5kp+ovAvco3fofg7zyC0czs4qrhbIX5yCsGJoxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 17:56:08 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 17:56:08 +0000
Date: Fri, 26 Jul 2024 12:56:05 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Use SPDX header for license
Message-ID: <and6xlmx5hk73wpmii3gxs2xormfsurzdxtjdabxcxp3zohqti@2dx4cirt34b4>
References: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
 <20240723185921.1005569-2-lucas.de.marchi@gmail.com>
 <CACvgo53D4O+-bEDV8OQQjURAUNQ3i4NjOGqefNk2po68DbguZg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACvgo53D4O+-bEDV8OQQjURAUNQ3i4NjOGqefNk2po68DbguZg@mail.gmail.com>
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aec1486-9add-4060-9b2a-08dcad9c3a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YkCFDhnaaPt8YJUZEmYwfUIbCGLkLQ5IEO0WR9hjzYsHnrEviUdHffFJD1?=
 =?iso-8859-1?Q?0i8FVJwZbhfrjy9N/xN6i+8AFzhJMunkiSpYoMWszTNRnOyeAvfaNTJJK0?=
 =?iso-8859-1?Q?cujSGfjHP0Z2t3xM1Ul9JmwG19fAFUaa9YUNSP1TtcuM5XF4J28c5EiZqp?=
 =?iso-8859-1?Q?Ii3A5fbz462N0n2xX7+2mtvBbPyCDpTtDWNPFTuLz1efk3eOzqN8ex9PzY?=
 =?iso-8859-1?Q?+eTZmar6axoeNr9YbO3hls+I7zdKC6noiHiuAOlyOHBqlyEeIyi3UUTG/H?=
 =?iso-8859-1?Q?TPKKS3dfBNoZ76aNuLtgDCZL8T3lb7hO/mbYcYdcFMwegoFIF9gqoSe1jN?=
 =?iso-8859-1?Q?clcQTDXfS1Yw1cCTswNT8vnWL5qV0luZQ/NVrugjX9f/D21ycSFVFelXN0?=
 =?iso-8859-1?Q?B/2/BQGLhgBjK3mO4hICjOWJ3ZVuHVG/Y0F1T+wBj8aPCbq5majso85JJ4?=
 =?iso-8859-1?Q?KmOYoIuljHf9u+WHCmbOh9ZaWs0Eg6dN1J5bCj31dOs5XKhnzKgjz4pRXn?=
 =?iso-8859-1?Q?g3IKlOMvV7lhYxjd28KGb1hEbUe3v5J+Vc8c5Pk6Xqwi7hemr719sUooc1?=
 =?iso-8859-1?Q?ca61zhsEHOhjxrAVDA/WYgCsdDidRgIYcOEUivJpV7tz1ZqQUd6eOJZY/P?=
 =?iso-8859-1?Q?o2w/C2QnFR/SC+GZTHc/NK7X6KkIKhR4ikyrVuequem908/Nl1Fv9DPuoE?=
 =?iso-8859-1?Q?UoJjYwajA0GTp+m8Nu6Ng0hND7pHiTg9m91edcqCVgnG3zbYj/0chcHDW9?=
 =?iso-8859-1?Q?HnIJ1ZdY6nSIIsnOwIk7pwuiO0OriOIYsLCOeKAQ4rnvJxUfO9SQ9RTe1B?=
 =?iso-8859-1?Q?5HWayr5//lfym8IyobACnk3ftd6ckoUVeumdvltVfOFKqV6rBZbv794ei/?=
 =?iso-8859-1?Q?83i5jcXFm/VS3iL9nEiGaCEu1y3xTz+h00i0RCX1U7y/+sR/VQgj/uiuGS?=
 =?iso-8859-1?Q?vXkN5Hz4mqth/arHuGVMyfAs30jgwqGout8AecQh7hWEfRkEDqBgZga4bu?=
 =?iso-8859-1?Q?owlNP3OSkcZKRq4iCPjtN/s1QpmrvxljHyHYRYqfz1VWBsE4kiKCQt9+8n?=
 =?iso-8859-1?Q?OjhaCAJP+3YU6Mdt5WZovAtb41ShbBV9nPHvP/LK32stHgyD3E8nquYy+z?=
 =?iso-8859-1?Q?0VRxPSUDeF/QjWiDlndbnvPd0W3gJ2ZXYxgeFtCxKA186JAVJY8WyQAS5V?=
 =?iso-8859-1?Q?pGNIpckdhRwp4HLdxa1yQ9OUXh5t3RsfbB3YjrxHhJGPknrOM54hwIfLcO?=
 =?iso-8859-1?Q?jCtnvyA+Yi80r5EsuEVewiP04er/2EKWmckgW0kcAK4gjpYlE+BFfursE2?=
 =?iso-8859-1?Q?qBVFdSLE0kMGYF10KmU5YvLta3CRgUJaHfL/HODKpG2x/pU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oLfwzbheExsqovRiySJ4ZwDdUeyiq+lJATrMFtiCB5vNjeCqyLvOWzVJ+G?=
 =?iso-8859-1?Q?pMEoNKP9DTbW1zrr1QU8eDsJ3gDKJT9mHV7yImh7pbOZO+TGFDNu1bxPdk?=
 =?iso-8859-1?Q?a2PbSQNhUltBDPPjZepx9GCgxIZ32++OYLTJZDTvz7KL8REoC/24xVV9Xf?=
 =?iso-8859-1?Q?hCuhs1rICHQwBh9iHbtlRoVrb+ZWIy4qsCrYiTNq73rLlv7ACZlDZUD23v?=
 =?iso-8859-1?Q?LjlWF7Q4hVq07T7CkgANRZYv8n99d1AY5e8KSttiVPlCZmd6Bs6y212kJT?=
 =?iso-8859-1?Q?1Ve0efCRIDCUA2KPXAuMiEo9ruligVyYV6V6v8quIWGR7wB5uKPPkEp+7z?=
 =?iso-8859-1?Q?GttMgdlUHlnXO1g27utl2M4eDIjtAepZyCEYXLOH2WLC0svxRyyVPxYzu8?=
 =?iso-8859-1?Q?9d6sVgzcFR0BiBv9fkJglKNeTNW+Kde1l4IOhMCiDg7tfqBYI/m2orYk10?=
 =?iso-8859-1?Q?Li7Afr5jB3gkyefErNCQE3lBp57konxRJpTSenx1gquvuqHvbNx6zhDdNO?=
 =?iso-8859-1?Q?ggCjbUasD4Dw8n5PcbfbzawsUjy3icvwaC1RQ+0qdpyDdv7r2FnIuELHpx?=
 =?iso-8859-1?Q?HRd433rPcLIqHLIpG51ZO/9SYog7JcQMKVcUekgKxxGFqScIomV7uyZSqO?=
 =?iso-8859-1?Q?Tg+g/vAcjNlautF6TVAfjie9YvyPtTlSMsMq14YWEDn6dszf17SgNpktTu?=
 =?iso-8859-1?Q?dTv6zkA+otHEHEOwpq8OncvzREZuVgMhXd8SYMllhcMwQ97fku319mik+M?=
 =?iso-8859-1?Q?fT8TKReSkcVl3FLT76zOPTgxDDvvX8YnnIebKhJWfYCaho7mXjd7F+T785?=
 =?iso-8859-1?Q?hpAnrrgUpxNTgXq6DXraLp5m77RpFb+ZRsauobQot/vT6L3kqZsiLOwwtU?=
 =?iso-8859-1?Q?N+4BtCtRZ73NSD6EDn603YTPxCUGtKj4u258IV1N4AU1RilQU815S/v/7A?=
 =?iso-8859-1?Q?R8K71+tqszSRUUUbsWoBBX0fY1LwYkyJGdSbVrsy+20QZsYYq2n/PbFCm4?=
 =?iso-8859-1?Q?yfsk+clSLk4yf4KVMF5MDsz2YjhwqXGDgpNoioo6EffqevEa6OxoLb0zHp?=
 =?iso-8859-1?Q?5s300GDfMw0jrnQkQ6Ej9OI2Cbj1ZKWTUkfgqeQhhEk6NxRn4b6B9DUoSq?=
 =?iso-8859-1?Q?12TCoYKqNK5hbk2EPHZ25m5JaBHlqAmKAkIQ3IFEyiVPX2BOvDPgZ1DJMd?=
 =?iso-8859-1?Q?rva6SPIS0GsH6nm6GPTYXC6voJhZO08OlV1XLHHUGEvLZS5Z71CcWPQ/qo?=
 =?iso-8859-1?Q?rnBPHbxeSMJceClr5nDSqCcE0pyo5r05K9ewcrbNvhr2jcUC8Kreh6b8Ml?=
 =?iso-8859-1?Q?OjUxd4QQqeYNXEbyCMLSYY3LxN8Miq2JX4Jdu8+LJNCjALRR/1IWC0hwSc?=
 =?iso-8859-1?Q?S9PwWzYcxj/z6vRD/SaHXmPY16Lq35LOLGKtv56m1oeIQEB5hfMthjQBL/?=
 =?iso-8859-1?Q?FTFK3HqNjaepwjtqB5YQzWMOo/90QRwSr+LXLeAD+93Xj48yFtvYWA50nK?=
 =?iso-8859-1?Q?kFAhrFHj3mmSqCHsfjM0NLC/x9cfWLTd3pOABiFSFoLl1lUCr52LCiXVoz?=
 =?iso-8859-1?Q?ZffHgRf7N107hGd/e1R5sb5YxUZTukX6w18CZ5GTjsXy+UsiLWgKKL2d5y?=
 =?iso-8859-1?Q?umvB+Sy4JnsZV7MeYfJD8/6SHb7Z1Dq0EdNa63rDxhLS8p+rAaWXEI2A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aec1486-9add-4060-9b2a-08dcad9c3a38
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 17:56:08.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShJ/JbRzw+sP+0zuNhygeMoTskUkC3J9xB3eHRcSaHy6NN9g3XXL8QuTNrMHYsNnIeuz7pWnRm1su+RRU3rvbM7sNQGDCF4kQwJ/ij+RkVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com

On Fri, Jul 26, 2024 at 05:36:06PM GMT, Emil Velikov wrote:
>Hey Lucas,
>
>Thanks for going through and splitting this, even though wasn't
>particularly fun.
>
>One small note inline:
>
>On Tue, 23 Jul 2024 at 19:59, Lucas De Marchi
><lucas.de.marchi@gmail.com> wrote:>
>
><snip>
>
>> diff --git a/m4/attributes.m4 b/m4/attributes.m4
>> index bfdb50f..208dfdc 100644
>> --- a/m4/attributes.m4
>> +++ b/m4/attributes.m4
>> @@ -1,23 +1,10 @@
>> +dnl SPDX-License-Identifier: GPL-2.0-or-later
>> +dnl
>>  dnl Macros to check the presence of generic (non-typed) symbols.
>>  dnl Copyright (c) 2006-2008 Diego Pettenò <flameeyes@gmail.com>
>>  dnl Copyright (c) 2006-2008 xine project
>>  dnl Copyright (c) 2012 Lucas De Marchi <lucas.de.marchi@gmail.com>
>>  dnl
>> -dnl This program is free software; you can redistribute it and/or modify
>> -dnl it under the terms of the GNU General Public License as published by
>> -dnl the Free Software Foundation; either version 2, or (at your option)
>> -dnl any later version.
>> -dnl
>> -dnl This program is distributed in the hope that it will be useful,
>> -dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> -dnl GNU General Public License for more details.
>> -dnl
>> -dnl You should have received a copy of the GNU General Public License
>> -dnl along with this program; if not, write to the Free Software
>> -dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> -dnl 02110-1301, USA.
>> -dnl
>>  dnl As a special exception, the copyright owners of the
>>  dnl macro gives unlimited permission to copy, distribute and modify the
>>  dnl configure scripts that are the output of Autoconf when processing the
>> diff --git a/m4/features.m4 b/m4/features.m4
>> index 82a244f..6a9b5bd 100644
>> --- a/m4/features.m4
>> +++ b/m4/features.m4
>> @@ -1,17 +1,6 @@
>> -#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
>> -#
>> -#  This program is free software: you can redistribute it and/or modify it
>> -#  under the terms of the GNU General Public License as published by the
>> -#  Free Software Foundation, either version 2 of the License, or (at your
>> -#  option) any later version.
>> -#
>> -#  This program is distributed in the hope that it will be useful, but
>> -#  WITHOUT ANY WARRANTY; without even the implied warranty of
>> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
>> -#  Public License for more details.
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>  #
>> -#  You should have received a copy of the GNU General Public License along
>> -#  with this program. If not, see <http://www.gnu.org/licenses/>.
>> +#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
>>  #
>>  #  As a special exception, the respective Autoconf Macro's copyright owner
>>  #  gives unlimited permission to copy, distribute and modify the configure
>> @@ -25,7 +14,7 @@
>>  #  Macro released by the Autoconf Archive. When you make and distribute a
>>  #  modified version of the Autoconf Macro, you may extend this special
>>  #  exception to the GPL to apply to your modified version as well.
>> -#
>> +
>>  # CC_FEATURE_APPEND([FLAGS], [ENV-TO-CHECK], [FLAG-NAME])
>>  AC_DEFUN([CC_FEATURE_APPEND], [
>>    AS_VAR_PUSHDEF([FLAGS], [$1])dnl
>
>If I'm reading things correctly [1] [2], these two should be:
>
># SPDX-License-Identifier: GPL-2.0-or-later WITH Autoconf-exception-macro
>
>... and the exception can be removed.
>
>With that addressed - either as separate patch or squashed - the series is:

great, I'll remove this and queue in the ci-test branch.

>Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Thanks
Lucas De Marchi

>
>HTH
>Emil
>
>[1] https://spdx.org/licenses/exceptions-index.html
>[2] https://spdx.org/licenses/Autoconf-exception-macro.html
