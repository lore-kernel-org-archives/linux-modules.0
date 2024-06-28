Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8F1C20
	for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613935; cv=fail; b=r8gsDoA8VWOmE8a/z8hg47c1SjA50wEog0nQIP8UbsdA0EGqx+jN5XQGbZWkRga235oAkSRjw0qDheCxHK1jA5arN882C4VJPANvoBM3HBitf9UBPgCyOP+ecIAe297BrVFiYrGyjohiuYuBZzW6qDr9cZpBnuRZrHAUvKQvyAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613935; c=relaxed/simple;
	bh=7reVqzjq6iiemnQXFQbTrkitqIQuoNP7DhTK+chkya8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TODlWb6/ghkbfHg+9o5JoSLh2fxwq2R3waCu9vTacdsQklh91BrCZdV0QWDaCq7RxJjQyQrPsf4GzNAzd8uPdsf1eXM17Jn5L/wWgb6USSlCjlF2co7F1SR3vWf2Bt0ngkpDrW+EPRyYOxyWk0zzE1OSAsB/bi/k/s/WcbNssAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kg6teHj4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kg6teHj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719613934; x=1751149934;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7reVqzjq6iiemnQXFQbTrkitqIQuoNP7DhTK+chkya8=;
  b=Kg6teHj4eNr/+m8DtppnI9aRSdpNfqQNylWbUSf7cWHwOF8lJ6KV0Lr+
   VUO2btcPXtXiZ7hSVEf/oHguEAN1qPV+RpvFuOPKsExkrPi/G8vgaes9X
   vcBR0pf/d7QDQAU/9x84TghPjfFWS8K2ZosMUxvlEhbwTjh3PsHG0aC/O
   WZAKgUsuMz5Cnag2Ftv1jOo8MHCiQfaDXkF1zTt/hHNb0V+STFE4BOf2C
   6SxypnV2TKNC0r7Lbdq5+UHkeunDxmrdsQeHPzlowm+4onzYasR7zt81h
   XQFLqBF+XO3l0ebaCO+Q8JnmqhvTAkArfCFEcoz1MwdlU2ttL/6Dy7T1B
   g==;
X-CSE-ConnectionGUID: U2EgX8ImRqi2dxCojD9BCw==
X-CSE-MsgGUID: Tu5X/chiT+q8uJVpnRNspA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="28204216"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="28204216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 15:32:14 -0700
X-CSE-ConnectionGUID: Aqt63XNlRMaTt0PLXQyJRQ==
X-CSE-MsgGUID: oHO1YDyITkC802itFC3DdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="82419356"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 15:32:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 15:32:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 15:32:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y85y540j4bw20Rb5T9Cfh7pTaiz98Wv35e/q6YJKLd7QNeFcYEb33pog6pZLBylXdv9qxK6VJ1+tgiRrpBYzRefHsBkol6mR3qgd3QFCLUOLfFaZngE6S39/0lW3wTH7f1Vzs+wKykjL2MbZsy5kfWd+SiqcZhDPyAeHuebeE1l/j8AX4X0dftopmzhROsJo3IxTLpHCRPRpQAI3AqAKeOQwo1DikhuLzTafBgIJiJ0utvRIt41PibBcF+l3ozFTWaZ3iahP8dJmUcMLzwmqbw2ifFwkmOcVIsMeqCVubTRjq8RFlu5iJLUdrY0xg3UN98H6gDMK8ECY4+ra4G6rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uy2xoa4caou7SDRJHaq9AP85FAB0grySD9V3cVO8qI=;
 b=N5vLqbnpFZsYCFid4xTOEDR8AhB0O1h1tqjx/uHiCC2K78t/UDJr9QAyEO3wd43jWwKOFPJ3+hwLysGn9sJ4wyaxb07K+GDvlv5c138MLq5pUT9p/xI2SgHU0oo8UDobqMmF1VHpo9XGSiCCf15lXLesQ0IAQOSt5+0TQtJBwY7hwgmd/RnDe9Og6/o1CORgCnK+qpFF39K/FzlFqjnl9Li1a98/Q2ycaT6GH8RbcbGH05qv39MkqrTZjbTFhlzOu3dkiUZB4kGNYchCo0ffJKik6hPvdK6a9A5w696KhdGGtBCIZPSNYmEvCuFVlRtz5IgSfZGcHkg/j/KBBsIHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 22:32:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 22:32:10 +0000
Date: Fri, 28 Jun 2024 17:32:12 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 05/20] man: add some extra bold/italic annotations
Message-ID: <mbtfj4xyymb7dy7xcui2zvb3ko2d3bq6zimru4bsnedkzw4sr6@xxlci66nolpo>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-5-bd6864d49639@gmail.com>
 <zfgska4tdkbpi5ml2fgg3k4bs3gxledfek5jgoetnk24srqd3d@o5grujvkszsn>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <zfgska4tdkbpi5ml2fgg3k4bs3gxledfek5jgoetnk24srqd3d@o5grujvkszsn>
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 91488330-b447-4fff-1989-08dc97c22644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0UCuFGG/apPeAh0WR+/S2TvED1C+1eTh0CHopxgrPRz/Ej2+5vajGHrj7pNb?=
 =?us-ascii?Q?CXu6Hm5GDnJSPa0Lz6c8353rtTcunJ5axtXNA5i8mmycMkiGleJ0qpOXeREF?=
 =?us-ascii?Q?U6HaJ4JONLhp/fE9BDNuxYkjgHu2P7kNUEoJFR1Nn7MYHaKty/vP5HZ1eYY8?=
 =?us-ascii?Q?8nOO5LTpyQDsdYl2ovrjBjzsjX3024sVOYENo2DD0t2equLpDxGZ0rmT/8V1?=
 =?us-ascii?Q?eH4gA9v6eIMNOSAZ1Twr/pejlkoY0dw+ZoILG5UFt2hWSRoWIeLgvpi31qYI?=
 =?us-ascii?Q?hN+hPgJIyabT7dHFMOsRw35VI6tYC93x4qjKpuzG3vnBLoIwYy31coh+8Wqo?=
 =?us-ascii?Q?5kbUyczKW0yOyug0BtXExJ3/UGrGwalbGmLbG2PFGQsw8PcNM25a2fcuAaDD?=
 =?us-ascii?Q?QpfVLxX5wOfjtKvNRF2yDXkCvUcpEVUzj9B//m7e58h98G7uRtDQVFNz6L9Z?=
 =?us-ascii?Q?GX6vGx2la0mPx8dDb9wPdVs2m9E4WcItrTx5omxawRe/zXygA1vzBg8FEaHO?=
 =?us-ascii?Q?c66Hdgew0Ot2wI/DpHuSqfOPAIon4fEqbl0x5UXdEAyz10Ps7YaPqu6axmC1?=
 =?us-ascii?Q?CZktfmcTMFUMhivnD/xkTnxdfYwJAHolFvX5sRakDue9CWNfg8kgAFzYIqoT?=
 =?us-ascii?Q?M+b258KDCi0IHkT28MOGVok5yETalgTds8Pjs3NOlkeqmmeufWO0MqBxPBUY?=
 =?us-ascii?Q?ndpN9g/2C0PPaYJ7YUxADcrhqBg5K/usn3YKgmc/5Vywu/81wFWeoae36apl?=
 =?us-ascii?Q?b15eY2EnPISiaqlRN3B6dsviDdbfoJXhpjBqgmbsMyQfmbZaIj2UKOKiZZqa?=
 =?us-ascii?Q?XMVy0PDhkdZpjRZ4/Kfo+7PC8tTLLaLM9n5jq8nIPRG2jpgD3vR2jZWyZEVZ?=
 =?us-ascii?Q?NcGs56jaIpFiUIbZ5za5iUob5DqmAWWjVn/w0ptPyFCR4Talp5AAhNhJ86Ez?=
 =?us-ascii?Q?8Zf47NafWthpf7mVQb7lU+MieIJVJo0v3EtgNzgBtSVYu+sDMaR8ihoMsYu4?=
 =?us-ascii?Q?koqyfDs/ma0OIECIQUq2DOtFhCKk/6VSb6OR/dwuUIMk0JIFP6a8WZYBkPCi?=
 =?us-ascii?Q?j0kMfpjS9RBN/xGECFoxfknb3brz2kfQ1g6BbohbqUIOa9kti/AWvmzFSZcw?=
 =?us-ascii?Q?GGUpy7SGTkCSddgmBKCXM4b2DpSMkCj9RoUeoX3iPw4hipEQOzPbQS2qnbVq?=
 =?us-ascii?Q?X/O4BBgqUn8CTlgGi0LKhQrxy3y+8GNBt4y51s9OaxZd/2ydg++COsPWlE+I?=
 =?us-ascii?Q?0ZcSmZ3eB7+LZ/RG3Jdzmf0KAqUQrHpSzFCs+2qLS7whlr7eRJ0t/kaSKm7V?=
 =?us-ascii?Q?kve3PnBYyDGGgTj0CyziPMEVHoZamVXY/u0D/X5NORx7NQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1CKK5NvyhXvrAYt2zNW3596r8Qg1npjKA1XOHIdRep5mi1spJVlsFZSeqEoq?=
 =?us-ascii?Q?JwB+sHXQMDnQQYrXXHwegTY9BvGt4mq1Bpwjn/MSrIZkvIL2bHk/MF/URHji?=
 =?us-ascii?Q?J6Uo+fwM5bTwZ+CtTm9ZBTJY7XAI9UU1uGLptd5xBRMyCRNlZDLOelnEhL4g?=
 =?us-ascii?Q?F+pSPaRSJzxsX2dg0XmEJXb19wJTHoTz3MNeD61oXuo5MaCPj5YTx6RoI82t?=
 =?us-ascii?Q?HATptkXFVJIPAnyZZh6YNnbyufKIbFPWKNAmbuXe7OLQecHUqEZ+ADq1N76N?=
 =?us-ascii?Q?RM4kSoQO/ELQyjYHdoW1xQE2QYRyvKsNMce8HF+oh2vbSzMwalDToqmA1Il3?=
 =?us-ascii?Q?bUZan6v9LPz5qwF4TMSiqVE0mQn6NZG1+UlhKkCSG+NYbhr6u6tEIVR4EIp/?=
 =?us-ascii?Q?03n7eU0EBZv9VGO4av2hbv9GYjoe5BvLZeVavWYc/aRQsWOdjbGD7QxreIQM?=
 =?us-ascii?Q?feQ/ns+MtKdFQoCeBn13ze9Fy2lX7BmYNCDj/ZwR3SjskpeXoXH8mx2nH3bV?=
 =?us-ascii?Q?f6HbF53U6eMTKlhBrkiU4OQDQVetzUh1MZ2qvoBAvl2lgaY2nymoUKOrkYsf?=
 =?us-ascii?Q?ZYKG/EAtEQ+G+kRCuVOSmPHxegaREvF5wPIECZ7Txd6GPIO+6T4EuIAfyAT3?=
 =?us-ascii?Q?rnwcayE1Mbrj0XCrvJijEINg5bkaxE88RP7c8st2viDTCoIff51oP1uK1dyF?=
 =?us-ascii?Q?rTmRtjdOXko5QUQ2+BK4HfWbCRFikHVKI8d+rqPiGAmHcGECGafmg1lo43ZA?=
 =?us-ascii?Q?tKu6j4hJSCBvnl5TkTiIqi1Mp0UsiyhqTYWZ3Bk3sLCYRGI8yzsz4k1w8YAe?=
 =?us-ascii?Q?U8PUrtsSEIa5BcOIhukmPVCyH5k1Opi8Zh7B57umK9ndeu2h9rnsM1Dpmelc?=
 =?us-ascii?Q?HTAfH5k0Vizeuv7iQV0USH8naPmWYEX6L+6TfbiuTcbCC75nDiFRAoBjGVDe?=
 =?us-ascii?Q?UB4KWC3qsJWO0Cm5Egaln7m2EKRewCb/SPzCxWT0yZmnnKg4DP/lpitc835s?=
 =?us-ascii?Q?S6sGwTNkcYeRoh4VEQZrjseq8VxLbp+2rGkBBt5kwGTzbldtA6+BWaSREJ3g?=
 =?us-ascii?Q?aB4SDchwlSqYRVC6V8ZYCaU1Ikwp2E2rQG7CWIrsMQxTD5P+Xdj5CZf3ec6P?=
 =?us-ascii?Q?Okfkyb0gYgzLLuXXDaLatzo8BjG0QQTF+s9Oaw/B3+rFhLCBndx4cfzB8lfc?=
 =?us-ascii?Q?d4xCor2qPFa7LDA+zgGbN+4JafmKd25puoQ5nAhGesayGP84dwjbYZAO76qZ?=
 =?us-ascii?Q?NnZthwXHm6nSHGZocLoicruQea/w+0h2U3PfQAAehFZ0vBKkXmMI6/lNdRCx?=
 =?us-ascii?Q?+JLC+iakBErNrNgCcDAV+cEulLe3h/6Pkoz6j6zo2PIMJFum1OyjyG5Gmubm?=
 =?us-ascii?Q?+ITBYYyzV82OUX+dRF53OiYOIIzQss6bvcxlZlVU+jotS9rzCQr3MeQqo3/B?=
 =?us-ascii?Q?oWuk4fdFJbDK66aeY+X1l6gz5/MgbNW9lmwKm7bMlr8FjSUD7ZrDtJWcgTzI?=
 =?us-ascii?Q?B6dwzRkyp3+Vze/dJgtQqtLGSOhg+hxkP2dUYd6jsv2/p9ikgRgGLmBlkd11?=
 =?us-ascii?Q?Nw1Fv93DL4DqxeY3+vYm0syzwJ7JckHdPM8+5mLAwhngATOkjfGQMtWkaAJ0?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91488330-b447-4fff-1989-08dc97c22644
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 22:32:10.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IGS9LlHllQ26yYBCHkizGsGtvbeqqnFYlzi7oLUrPRcTUKstUIn8/xWmqGXqJErlxw94u8KVCvyOLiRXGw5aF0j6Rsqb2b7jHSU6Mw1ah4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com

On Fri, Jun 28, 2024 at 05:27:09PM GMT, Lucas De Marchi wrote:
>On Tue, Jun 11, 2024 at 04:05:05PM GMT, Emil Velikov via B4 Relay wrote:
>>--- a/man/modinfo.8.scd
>>+++ b/man/modinfo.8.scd
>>@@ -29,14 +29,14 @@ architecture.
>># OPTIONS
>>
>>*-V*, *--version*
>>-	Print the modinfo version.
>>+	Print the *modinfo* version.
>>
>>*-F*, *--field*
>missing
>		  ^ _field_
>
>so it's consistent with the rest?

oh, ok. This is in a later patch.

Lucas De Marchi

>
>Lucas De Marchi
