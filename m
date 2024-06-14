Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BD19E7F3;
	Fri, 14 Jun 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390896; cv=fail; b=oxpf4GQErN8P/RKLJH5gyRHqO18lAc4ankKuS9Ho9zyav5El+8SkFk4bBE8zpzqYv8GHD4YtkRNznMRNdXbccrQAjqMfzx4vYF6fDjxdtuZ3YJl0lB/z7NGPbwzHyq3BK2dsO1sXYobm7aQRvcJhd2mN7YttA/RL67uz3zmD61U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390896; c=relaxed/simple;
	bh=B6bkkDZSooNXrCWMmktt7dy7om0PmQTsEol8nW3z/NY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sXafYWnk1c6d1RgP+I6Qo0KhCo9qfMqTX2DIFILI2kUHlv2rPH01UugsZT9nowMh2hogWO1PeOrvaBWbMhrLezKWYLTejgLykndmJDz73aYLN5Tk2vMXnYCyMkqa9gWGSD1I2/DS3s7QO8Rg6UJEEPjS5tUFg7WHHsPH7GHQU78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSsVzYn+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSsVzYn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718390896; x=1749926896;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B6bkkDZSooNXrCWMmktt7dy7om0PmQTsEol8nW3z/NY=;
  b=mSsVzYn+iH4EieeLlmK6Y15Omy6+z96QtsoKyLuIrDjpqoeDOU3LfBHE
   hheZmzqJ1cknU06qOXNzKtr8SCEqo+28RV3uu2PBaxk4GnSOwD944wkx8
   Mol8HbBn3G4u3elOOJqQ9rMjeVj1kAb7fOpQ3pJp+lOWrxgykNSzwB/J6
   VE174mcYmgXmEEHMhFwm08oXabFKovVKUIrE2lip6euNxm298yMS6UcC5
   aKp4EMojdwnYrCBRpM8Fzth5F0YqOfootyrhbvD+18BuioBpjNm/jouha
   Pr2jpW9Ov93yjBdB3S6SXoRtVDi5nu7tyBri9pP5kmxv10MiPRSXj3RL9
   Q==;
X-CSE-ConnectionGUID: rWIsNXybSc24SgS8a7YtrQ==
X-CSE-MsgGUID: 9rQ2gs4VTVigvWno3mZZZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18214369"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="18214369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:48:15 -0700
X-CSE-ConnectionGUID: lqY5f7F6QrSVvw8iO1v8Bw==
X-CSE-MsgGUID: sCHibM12SC+6gMdsDdFhDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40438373"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:48:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:48:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:48:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:48:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:48:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klGpds1hUJPsSEntp+Q9GC+mRpblz4Zwvvg9A7oWVjoS984Py4m6DeqjL9jnyNk1Y26ibu4Fh9ZLd4JSqdWtD2uoMpiFbo2uc/OOiLKyNn6XK/5iycWWne2ZoohDfhznqcj6Yct/XJojGmC8w2cpV3KEMENNsj3Xv7CTuXljWh+z/uWRsJR7IEp4wZvPgFLXJcJ9PH+krKtje8A3Bb1eRQC+kSZqKJIFKlrcVXjpZFY/smbPZidbUEU/aQNd6i7NUx3S15Sfy5OwhezT6C7aEUeTQNaEVfspkKjtFENIzRoTe0Zs1HCqOk3HUHa5Ak/8xSuxdCY47qggGRhHHfy/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY08n18xtEzmdoexlHF6QzDYdHRlC3Af5vdqw4suzI8=;
 b=WRfAmGTrLlJnCSvJ1M+N1EkkNG8IFhuet0MmanEyD+AfEY979xEJ4mTgn/U7XpoXPFVM9Uz90rK7NMzLjwCFiqZGzF1YCp3V13B8fqpSqVVmqLxnVYiEu+vDR156ifC4fIOKXoNnV9NxGoLWVvUP11bt72833cmMWxW9GMQ15AnKF7ac0Nu6OS2YNiingO7aS0k6wvtM9OLvceiVONgja13TRfF37Ai/Nk9oGCta11SbpK53QhqttOepdYPLZHwxccTOmhsomnHlsEJFa0O96RuNLIRaXkhTnaIMAZNF+MDzy6UeW07WvI4pgfvk3+jX7UhCKmMQmAvZWk4EOYIMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.26; Fri, 14 Jun 2024 18:48:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 18:48:10 +0000
Date: Fri, 14 Jun 2024 13:48:04 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Aditya Garg <gargaditya08@live.com>
CC: "mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Message-ID: <2eybrtgvcbrvd63sckzpsldhnolnqve4v7xyqpfoq2uvvskdcv@rpu7vlrbdclk>
References: <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MW4PR04CA0386.namprd04.prod.outlook.com
 (2603:10b6:303:81::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef0dbdd-3410-43d2-e0c4-08dc8ca289a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?X0jDer2h4/rimOu8KaoQ0+TuQ/t41EKW26UygIa8KUToANIOYE6mYJhyKe?=
 =?iso-8859-1?Q?DV+1NcWyIER4re4u+uvEYAupmKkY0cZB00hZ8sqCI7XvkrPdTca5pgMgUc?=
 =?iso-8859-1?Q?pse92nJsPwiH/Po4uBnwjhv6w7XfFasfGxuId7G3N2vgmttH44/qeyVbNS?=
 =?iso-8859-1?Q?IOEp4TNVlx2a0RnUOe+IpdGENe9y9fXgaXHlZsxy3l48EyF4sPWeQH1VN6?=
 =?iso-8859-1?Q?UHtWvgjEzdGasDrkQ4WtbX8iOzw3Nt4noTUG14/vJ/0yXsxh1uvGt6EB23?=
 =?iso-8859-1?Q?SQJCxCByoTDu6wKciQNYC61zuugUuVlUTWEaiK86lAlS9GpEYe2v99wAuT?=
 =?iso-8859-1?Q?H8xXfwRJR/8UhZNIX29hyzCPb0HGHVzOfcQ+l+tzmNiLPjPMp7sZDTzKtQ?=
 =?iso-8859-1?Q?LPp+tURAK/qvsYxbpBqlx13kCCTJUqu17+mjBac7ubaM7NU88E7faV0BY7?=
 =?iso-8859-1?Q?zxBR4B0E9Yc40Zeew7yfunc4UTtlZfkfLj/VgHDWCq5uUKTfoWh73TJjYF?=
 =?iso-8859-1?Q?h+NG8oFh0pK6DEqhz1841K4JRfyP0o7IHrkHD5daa6twykKLUTW1kJ+o7I?=
 =?iso-8859-1?Q?tL1ZXeA2wBusvfD+MCzTIgVwam5ziutGje5PMCV61lnz1gevzE9KVxDOlY?=
 =?iso-8859-1?Q?+InjDwMJbQehcuLUK2sc5E+NBK9274g+gyqUu1uk37pP0YUZ08MgGdaZ+H?=
 =?iso-8859-1?Q?FFL4T4skItR0X0MpdYyPSWl3GdoCruttvB8oqInXdFK9HE96Ccq0CHIxL0?=
 =?iso-8859-1?Q?GKHGc2GiJ2FINKGoLyDtFY9XQKR1FczQsWQbqm+yPSoPjG4DqYktOtGWQt?=
 =?iso-8859-1?Q?nFdGzd2fBE20367petJoDkORe2ObwrIaokKsndLkkvjXVKCXXPMUyTJDT6?=
 =?iso-8859-1?Q?ZTlaVk9BlMF96eKBSS3xaS3hNdXxUTIR+mxLS0aSKz2eP3jVUTBvoa7Dg3?=
 =?iso-8859-1?Q?EePG6yjZ4GmTe4hvytWOP5P8qWxpivF/kp/SFWq+AI1i91qi+iPxaC43kn?=
 =?iso-8859-1?Q?8RPS3lL4VSCQIApC1uDtaTtLCU45rAe8AoUYPYZfmEZS2L2l+ByWYCKkC2?=
 =?iso-8859-1?Q?I0jO5PnDgHDbWgOW3+YfuLsT0zpxkJe0kiLoRdg0rU63WkcaoBI2x7Lxc+?=
 =?iso-8859-1?Q?byp9/iNfrTOpzmAOuKEI/L3fkpIB2kmoeIGhllkA/GfOGpu7txTCyHAKq8?=
 =?iso-8859-1?Q?FJZKkxA2IpLUN8fKEnHm3MVX/PtPmk/86qEpqph7x5ei0hpZ/gqggKv82g?=
 =?iso-8859-1?Q?iLazj0Ok91K9yIoFFwWeLwaB+aL9YiFep/SRuzoJQ8Qpjc35cemvKrzva8?=
 =?iso-8859-1?Q?RNgRgJ0t2gmHFr7Ma9wcSX57dI5z/rSsgSOebJZWR1IRW8tHvSYNcFPvpO?=
 =?iso-8859-1?Q?NmOzq/sFDC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZKtMfWlB1SWc+ZLzhgql1p1oOhq9Ap23yCmlpPL4fFA/593pg/+hf+RGBr?=
 =?iso-8859-1?Q?WSJ1lgc7XE9cYXpX2HlL12buEsZsNhOUdsYBeQnpGxwxSYnJqoKdwsdqkW?=
 =?iso-8859-1?Q?SmBs0c7+YY/FoHljarKKa1/mi712p97EEC/wxGXV9oMjy0ObGzuwUn9mn3?=
 =?iso-8859-1?Q?EvKaOwulKN0jabBnWp7tDppi4BVimojBEcmqBRFOgAZFQGwxrRQgePt5SL?=
 =?iso-8859-1?Q?HMIY5yLqJQI5yyRm+xXE9HeDRn8UQFDNdvtcgcSj5zSv+uuTFh+hi7yIE4?=
 =?iso-8859-1?Q?J9UL1TVZKMJQReg0NYS4qA4gLdn8KBemYDBs03Fh9w3k+tzZxAu2D3ldgO?=
 =?iso-8859-1?Q?O5yoWsUIv6WZtAxT136XDdW4DlGnBOAO0jMyyClBUucfmwYW5jFjoqQVDd?=
 =?iso-8859-1?Q?6FDBRXWmYeJwOmrudmOO7gST8XRHrEL+2HwsYcVTz4RID2iMIlAryrenHA?=
 =?iso-8859-1?Q?42y95zDTn5lcUAqVTBTJf7mga4An6SYOMI9KJNCsKpHF20MUQrRTCF31Hf?=
 =?iso-8859-1?Q?bJ3FKx8sM8yezTE41KlPufOhSYOAV8uHlwnOeT00nWZrd0jUxauAOlpP94?=
 =?iso-8859-1?Q?ukCGwTT9BfssCAUvv/KrJUR4w6+j4CkGRGIgz3K/E9Q1k6x4RsA8IYRejb?=
 =?iso-8859-1?Q?pSi293CNYx3jf3sxYG1LkrEo9ui4kxAjgC54dhQpvWe7uaRfNzJBYRsdG4?=
 =?iso-8859-1?Q?n9/voUzf+rACzHYab6rbFRyiD+oS/vD4qbQBXYqaL9h6W6R0b9KaZmScaJ?=
 =?iso-8859-1?Q?jZG+x3ZtqA08p9/fA+2Xgt90bROJPo7GuqT1UrI7bzK/yDzhXDD1nqdF91?=
 =?iso-8859-1?Q?h2C2YJpkrn5wXIC2QYeEJktIPTw43A4Fy/u5m0mW3dgUBgU/XYGMBKmw02?=
 =?iso-8859-1?Q?dY+JEMYCK48BDBaMYiZGYv+FUVfbtlUU+pufutTPOPC/Zb7U4mvJWm/mLG?=
 =?iso-8859-1?Q?CLX/JSLOpKEq+JQduFR9NfQxac++mDFK5pCrbZalT6ulrtjaC5cdWPK9Rx?=
 =?iso-8859-1?Q?RwQVa5AmqkvPKP2cdAlvIdiCKkeMxCKsxmUTR4y2NzLF4RebhWo43U0idU?=
 =?iso-8859-1?Q?udTax/ex6MIGZQfxWVGN988ey3q+T4KC1rsWghSLYGiSrT8A4FkQjx02rJ?=
 =?iso-8859-1?Q?CUPoLb+K6z47VSdvGXMvAA8MYG2O6I9nrEfeE/lRjzLG5gUGDVwYWRFG1Q?=
 =?iso-8859-1?Q?SScSLZUvNmFRjucae/l7ZEaEoBKpVqah/sXXNkI3VwPJ0yUJQRvm4ITaMp?=
 =?iso-8859-1?Q?VOAcvOqbT5IKcUyo1nqCmZRzOa6sG1OMuIrAy7u4+r4+ymc/c6QO8b6Y2F?=
 =?iso-8859-1?Q?toHpxB6K+pXMwDC03dXyvB1YtZ17j7OnQh7LV5/CqMc+oGIDua5TP0iUn0?=
 =?iso-8859-1?Q?7UYJMPovXfE7O06j1vC1KUbHBOqYS4bI5FcEMQBOz0TLafvGsEcekN+RNg?=
 =?iso-8859-1?Q?o5RKD/R4zNWz2XKG6C919M++4HqIfPFiVdhYWxZmO47p93vb+L70VM17OW?=
 =?iso-8859-1?Q?0DntdM7O7dImJ8Ac0jXGi8artevmb8t0zH0h67+1q3roG9fLMX3/FHvmlE?=
 =?iso-8859-1?Q?pmUmjqL54M8rEtdJ7rtM8kXVI6W1jpTyiwKvbWd0r2LE7N+V5U4IxOy4bn?=
 =?iso-8859-1?Q?UUZVmiYI81Vm3O34Ac5tsHnFt/yCuB2wfipECUSy7+MSk3AEwuCF6U1g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef0dbdd-3410-43d2-e0c4-08dc8ca289a3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:48:10.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwirsxRLzeWCOhJsFBEPOb4S/8T73XkqYGLWQw/1MDiLhw+8vk1IMHKMLwZwDJInZOGwzmpgDZKvs0VHuDOxiRAsLWGHTAXL81gsrsrGr88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com

On Thu, Jun 06, 2024 at 06:49:59AM GMT, Aditya Garg wrote:
>Hi
>
>I am Aditya Garg. I often require using out of tree drivers to support various hardwares on Linux. Sometimes the provider doesn't write good drivers, and often they have to be force unloaded. It's a common thing in proprietary drivers. I know the author of the driver should take note of the issues, but still the force unloading of the modules does come in handy many times.
>
>Unfortunately if CONFIG_MODULE_FORCE_UNLOAD is not enabled in your kernel, which most probably is not enabled if you are using a Distribution pre compiled kernel, you have to recompile the whole kernel again.

CONFIG_MODULE_FORCE_UNLOAD only ever makes sense on a developer
environment loading/unloading multiple times his own .ko module. Then
the developer knows better the state of the driver and hw to judge if
it's safe to ignore krefs.

>
>I want wondering if instead of a kernel config option, we could use a kernel parameter to enable/disable this feature, I believe it should act as a better alternative. After all there must be people like me who are forced to recompile the whole linux kernel just for the sake of getting a functionality.

Just allowing it like this is not a good thing. You may have a all kind
of issues with use after free, dangling pointers etc.  That would just
make life harder for people not involved with proprietary modules.


>I hope for a reply and suggestions

I´d ask them to upstream their driver and start sending the issues to
their side.

Lucas De Marchi

>
>Regards
>Aditya
