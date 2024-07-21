Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4541373
	for <linux-modules@vger.kernel.org>; Sun, 21 Jul 2024 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721530140; cv=fail; b=MvT4SEpEGka/1iZ37K/zS3CtCCR59Umar5RJs39iTNzurtm1EtMUngUIYfZXUInzRpW3zVoZY41l7T04sdugXuKZzDp/9QNZ0bt8vdk8jIV9djdnm7TawK+jAh648BpfwgMp68nxyjmIe0bcK3hJGrTPzT27rdP6hl5qNkElxBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721530140; c=relaxed/simple;
	bh=sM4CY+m0Jn3PcGu80AR14gJAgntMLiUHSfgN57hZ5Is=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nNyOZ3e208wkKG9sTiJOLa9esouoLSal5j/QYAAyiQUael6PspWiaFEmps9+o56XzmeaeUBbyD0bzY3FPBPFgaFJFvepQ41pWjMaKPxwNDJfFUa4grxsOBjVXRLhxNl/H7deOhovFs3Vz+IBiLQZtxXdT76d3wScysd6A+6Zc90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tuf0oUsS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tuf0oUsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721530139; x=1753066139;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sM4CY+m0Jn3PcGu80AR14gJAgntMLiUHSfgN57hZ5Is=;
  b=Tuf0oUsSnHLiJPucaQLLATn6Sdh/H2Jfrxe8m9AFTFbhSvklFfHfXYmU
   Y0X70944emuOy/mL+YPkP490PGSKTugVO0r76BWLtyKKh2+tsxYtspKEH
   fbWF2eHGatV2X7bFbPb23b5Cn0nT7IL7GoNYjO9mvUZ25IjUFAoQrP5xz
   S/O2bSG3guWLer5kHq1qCS3XdB4t8omVGEFKpa04ZCfNbBPYp5kXbuEjt
   ZDFzMu8WMzIDSfItPC922oT3vJ076+k5TONTG/m1fUro1GxNbABvvhHF4
   Og88wrGcSDVIaGyBSTHX67CAULPAFMHlUXUbQV9kDEvY7dlEzxrJkbdg2
   A==;
X-CSE-ConnectionGUID: kBVMJj9kSli921jWaNGxDg==
X-CSE-MsgGUID: S1MLgsj4RjWEQl501EAY6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="18964074"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="18964074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 19:48:58 -0700
X-CSE-ConnectionGUID: OtFnu2voShKdl5W/GmHCKg==
X-CSE-MsgGUID: 6CC3qQHSTt+iL6jv0LeWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="51400721"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jul 2024 19:48:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 20 Jul 2024 19:48:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 20 Jul 2024 19:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 19:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMZWv+Dz/2KkBrncKtEAsrp5yI4zw/0mYWBRLU1ns/+KlnGd/yLaUIl+5x2NxhwTjV4GnswU9pwbIN5j9UkYf7UvCZD+BJY1bVL5JOGKt1nv07/eZfWoLWlUIb0hEvGRQv/x+F7wDGH5IN7uoumHrCaWeUPahT5IYMjpvEbpNM0Kg+s4cmHgAVZgMSPKX/j3XPsis+IlqBzJKGDaJS+nXxmhi+x5d4cEdXs3QmgYuYLAil2TiA+NZDVs9526UsmIpw+4nHWtmqf+DNmWJ7KiZfTXDEPaa2Ah090mrGSvoMvvxKfpoRx2mEPhHzxx47ipBL5Ke3m/EXyEWWR6xq8s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx2wQF8sbaCSjiRDW2KWiXTWGk4Z0r3LJqcQjK2anm4=;
 b=JbPGtALHMYNLU+q+lslGAR+azed853JKW3Exe36vPim4UECL60FTNuVqwhFjTG/ZWb5aZSBwOaC2CsXDAd0nr6ZD1Pl2JdOwTnKU7ugda6AOXitBQ4RzEH7jZWx9NHFOXjsDwNbD8ZEu3FzOKL0uOS3l7oi0u6ZkAL8EBt+MeLobDcx+ITKqYC+geTB2HEunuUj6Qwue7sqiBZf2W5mpN1UII3+/EQ8PHlNAJwXOPepcu9es6eSbZJbA8FkiPmkXaPxD0MR5ExwHBe2SDOsN8iqMVoBnmusSRJM2zBCpP4TPH+ZfUyWWB0Zbt+aN/AbptetLb/mnWRspgEibcXUuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sun, 21 Jul
 2024 02:48:54 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Sun, 21 Jul 2024
 02:48:54 +0000
Date: Sat, 20 Jul 2024 21:48:51 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] Use SPDX header for license
Message-ID: <yo6aq7kqlmwdkg2ls2gqpj4fpipgisbvd55cgn2fbkreru2rok@qjvn4oceb77u>
References: <20240719221249.376162-1-lucas.de.marchi@gmail.com>
 <CACvgo52Gh269GHA29Mu7Sq2TWhLNqNJj5weBF8k_ZANfD3=4ug@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACvgo52Gh269GHA29Mu7Sq2TWhLNqNJj5weBF8k_ZANfD3=4ug@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7168b410-6a99-48e2-6e9d-08dca92fa8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fEzXYbYHB2+bCcJ5Jjv5m9rfikD9kyOsJz+flrkKp0ynQaRAS/tzrg6xNr?=
 =?iso-8859-1?Q?Guw/5gikXaJc+tMUR2epmoo1KupbwB7A7QxmRtt3GFXvhbavKCsayo9GuY?=
 =?iso-8859-1?Q?mgwP/AP0abSDi4qFRiRTTnAixSdkNGnKQ+vGGVyywOu8E08MaMr+aOx2aY?=
 =?iso-8859-1?Q?4k8r98Npkxud55zwUjYsIBIP7mH6TpFR1mHpk60X/Gt8Uz79PgpHnXxGsx?=
 =?iso-8859-1?Q?/9rS4veY0SsB/oDX0wpOB1Njyzsw8AGMu5vhYIE8y+RvAqvueVRg7HbmkS?=
 =?iso-8859-1?Q?y83gBCLZepoU+nXUA/fKbTiD0ta6+pibj24MSi22ZDglDLDxDrP/2mkhOG?=
 =?iso-8859-1?Q?J/WyGLJWARF22By417mp/tFpLjf7F1m0lK2VlizsmEH6o9z0PQlCBF4vLu?=
 =?iso-8859-1?Q?fJJXgLNL2o7oqD1oJxkqAqZ55KIO0DNnLQt3tHAVBXk3nym5TCiyyCLaxZ?=
 =?iso-8859-1?Q?vmihVyLong2ym9bZ6EA6lZCza0FEhIZM3MJJGvV9d3hKhePfezPOIc8l5+?=
 =?iso-8859-1?Q?ybiXJXWeo0Kw5slSV041bRaId/7m+vTLaKJWqhVltOlWOp/XCE86v1SC3n?=
 =?iso-8859-1?Q?p+uXV2UZwh2avKv4RlqbJnF1aHra2pnkJf8zBwjlymjxKxubohn6vPPywq?=
 =?iso-8859-1?Q?nzI6jUO9Pp2Xy1k9iQw5R/P3pDC3V4XsZFH8QFESJxSZWhsXuRbkI7eM2h?=
 =?iso-8859-1?Q?5wAQz6nggKjTqD19k4vigzg05L/ekcXV0wxhGuSGQEhaWcnwL6bhrzAn2i?=
 =?iso-8859-1?Q?HhfpWfbVXhiQsOUzASp9ZBI0/FnWVCyp/MfdKYSBa1pq9wZ0JbDWO4LksQ?=
 =?iso-8859-1?Q?I7FIMBveX9pq1/Ls91f3HNzx3VUxZRi4orPXrTjAzvNVuIBZ2Es7lN+C2X?=
 =?iso-8859-1?Q?m8Ynk3sEgQOc22LnZ+7A2FXfMRGvpM4zjiGLnntcOopccUXUB852Smo11h?=
 =?iso-8859-1?Q?sLlIlbl7Xs8njv63KWaDvs2Gxd8minzNutCgdcZ2yduJ2HE7Jcebj5aiCy?=
 =?iso-8859-1?Q?l0vNoa7FWA9Yuv5SgwbHw1qzr9polr64m6z6uzKpTzgFYcLdNJ1Uz3Fya1?=
 =?iso-8859-1?Q?/VbHmCXviMqBuQSzc8mPLBRKTJn/43W0TV+erxCwg0Z76X+C20+n2vGcS6?=
 =?iso-8859-1?Q?295vrJgt15xJy/ceUsO8foxmqIFKcnxfPF4saBMQFAX6/8n6BLcvEklFrU?=
 =?iso-8859-1?Q?uRqVduTDaKlDfEgwxYtFk4Y+Mn1QYm1Wv2dX1g9oBH8XKbD80guG5+ei7r?=
 =?iso-8859-1?Q?CGGEzhwlK+vVwm5OWs6vX339YYxjaf/RF0U7nU4rWu2BWlojLQNHLC8PyR?=
 =?iso-8859-1?Q?w7S2kI4swTDXjg7akrj7vx120elz7o/XTXuZEzcBns1wrKWJT4qG3dy/pM?=
 =?iso-8859-1?Q?A750Y34+FE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OrSkKGBoSJVLINNmSGICwpHPAMn5e/2Hixm3AFg4MgCwR1E0hbw0fY0SK7?=
 =?iso-8859-1?Q?6kFP14PoLdHzYbw6G8d0tdW2+s3jJLYtOgm6pDUTwg575GnCyQlnUEjWLx?=
 =?iso-8859-1?Q?W+E8j0iIAfPg/dm1eZ0WL4YTpP23tIK57TFxHQPJ+v5DdT2PbbAIh82oeV?=
 =?iso-8859-1?Q?hywVKuZlFZUxEOJki5ziipKfLgQfrYftTMStUjgQJZh9bAenzrfTI7ii1a?=
 =?iso-8859-1?Q?FOl/jxDm+VXbFLB891JJrwgr9TcipfxBNp0K2tSxcb5ofo1Z+/DYAs2gFS?=
 =?iso-8859-1?Q?dDONqN2K+BEcJlxxkINLOi0IJtZR7h4eUfk6Q/mJkStcuGcGf97tiv2Djh?=
 =?iso-8859-1?Q?YUSS1RxUeZ3VVRIHzoRtjtBKODzkAyaeppOpDgjo4vck86YbtOV7qtJ0MN?=
 =?iso-8859-1?Q?u5G+OP8WKa9K6DQAdYNwh6Qnu2lFLNsNMdskd3Dl+iT4PTDgl0nD7BR0y8?=
 =?iso-8859-1?Q?CkKlRpfWlHNMSgaRjOsPNlcXUD9FKAdo6cyCLt66ssWiSNWxye666KFIkH?=
 =?iso-8859-1?Q?dT7FSBynuyHxDzRfCEoLP+zU3m9GFzNy9yYirSXpn4yNXFyWgeQ4PXHKAm?=
 =?iso-8859-1?Q?ydQ+vnqnN4SeUjlaW7/5dZt/pKpkSQyBJGVP0+tvHMsqWO4KOZn5+CyyjX?=
 =?iso-8859-1?Q?aJe7sUjyZIFkuGmwPeun66CE5mAU8vHMrqUfki2Dvu0VSCwmLxqZeFL/J2?=
 =?iso-8859-1?Q?VRo7nGs8omjXF6219bvthjJOAKOlsJwXbnQxFV/mdIx/t/1PLeQ+VPwbuA?=
 =?iso-8859-1?Q?q+k8MrtHONEPxSzAQnbvosPXlRy4NZ6Ph+mNW2kBybCg3CZOs+k3N/QO0Y?=
 =?iso-8859-1?Q?+Lm3RSM9tYSKgPT7p/P8qfVxn/L6TiBQilT5G6eoayEHC177E3ezNzvM4x?=
 =?iso-8859-1?Q?ScT3eGZSi+WGH67OWN+04FA7d4qKOtXZG6VxvzS3LUjh+MW/nKWfk6v612?=
 =?iso-8859-1?Q?m7TlWw5F1XCVsgRHcswzpuR9y0NHF5rroAZmyRyJrceRZlKB++YamJ16cF?=
 =?iso-8859-1?Q?ZMFGVaCY3cSQsKoJtnJYLCAZPG1ZydrW2Y9wipwcR1Acb5JPNVWvwN3Nr+?=
 =?iso-8859-1?Q?roMSrvpSsKavAwe8mKg5kDhHmx7Z+2drobDUbmB77kyDG5W6BtRSiGvC7U?=
 =?iso-8859-1?Q?C1qXZJloo2UdbcvVuvNzzLtkEfCTZA3OQOmAd44WTK7EUHrVKvr8BwB7K5?=
 =?iso-8859-1?Q?1khDANgD5ddUPlRTuMOjS31F7cMNq8rOpqqlIjZfmarxFQiuB1yfhNq2YB?=
 =?iso-8859-1?Q?C1xkiakQtU9MtTXmdnTSMl25vymsOu2ezK53TPQi1gvp3BHbk+/Ta+jNW2?=
 =?iso-8859-1?Q?eQ4fD/+qG3fg33ebq6wi1mA2d+fF3/s+C0hyE9goKoS/dOMRlD1VTaELuF?=
 =?iso-8859-1?Q?9YBeeI3xBTJB90A+yquJMGAS7DT9AlWq3hII/PfIkFn7T//pAp/h8dusbG?=
 =?iso-8859-1?Q?sV+Cax+s2E5Qk1UZ02hwHTB33amPRccRXDZiTBk86RcnKa1MhmIhn/PrLo?=
 =?iso-8859-1?Q?FZoieKk1fVKJLRsMkk4HXEf3Ntp7aeKLCzstALTwztSvRLdqgWtKZgfPLU?=
 =?iso-8859-1?Q?KOGgXuU1aKDHo0/tbWt6xTYjjtst+t6F4E+POfUo+/BaybTU3tsYw/pnHH?=
 =?iso-8859-1?Q?4Ae/MYfUNpDMTSAccji0w5fPkv2G0m86562PDTThlE4HKJl7isI/Q2cw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7168b410-6a99-48e2-6e9d-08dca92fa8f5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 02:48:54.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL7X5CC/8BZqN5a97ON34qsbhxhhFJunlSyIIESL7qAVJtBCweEBeewC+uYBPvvfpy1oN5VZFjkhMSV0HhpSaaBLxg4WcDecQoIWKghLoB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com

On Sat, Jul 20, 2024 at 04:39:05PM GMT, Emil Velikov wrote:
>On Fri, 19 Jul 2024 at 23:13, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>>
>> Drop the lengthy license from each file and just use SPDX like most
>> projects nowadays.
>>
>
>Massive +1 for the idea, I should go and update some of my other projects.
>
>> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>> ---
>
><snip>
>
>> --- a/libkmod/libkmod-config.c
>> +++ b/libkmod/libkmod-config.c
>> @@ -1,21 +1,7 @@
>> +// SPDX-License-Identifier: LGPL-2.1-or-later
>>  /*
>> - * libkmod - interface to kernel module operations
>> - *
>> - * Copyright (C) 2011-2013  ProFUSION embedded systems
>> - * Copyright (C) 2013  Intel Corporation. All rights reserved.
>> - *
>> - * This library is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU Lesser General Public
>> - * License as published by the Free Software Foundation; either
>> - * version 2.1 of the License, or (at your option) any later version.
>> - *
>> - * This library is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - * Lesser General Puc License for more details.
>> - *
>> - * You should have received a copy of the GNU Lesser General Public
>> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + * Copyright © 2011-2013 ProFUSION embedded systems
>> + * Copyright © 2013-2024 Intel Corporation
>>   */
>>
>
>The commit is few somewhat unrelated things. Since dealing with
>legalese is rarely fun, perhaps we can err on the verbose side and
>split things?
>Namely:
> - replaces license verbiage with SPDX one-liner
> - updates Intel copyright statement - would it make sense to your
>@intel email as author here?

I hate to have author in these lines and recommend people to look at git
blame

as for the updated statement, see below

> - (C) -> © update the ProFUSION copyright statement - LF's LFC191 [1]
>and SPDX [2] lists these as analogous to "Copyright" alone

using both the symbol (or (C) ascii-only variant) plus the spelled out
"Copyright" is what is commonly used in the kernel. AFAICS the reference
you gave is only about parsing the line and handling all of them being
the same thing.

> - drops the libkmod description one-liners
>
>Four commits might be an overkill - license vs rest should be good IMHO.
>
>Btw you can also use SPDX-FileCopyrightText [3].

I like to follow what kernel is doing since the project is very tied to
the kernel... this thread is relevant:
https://lore.kernel.org/lkml/YyBl%2FFUVndtEFkW9@kroah.com/

For the Intel one, I just got the one that I know it's approved since
it's being constantly added to the kernel. So I just paste it everywhere
updating the year.

Lucas De Marchi

>
>HTH
>-Emil
>
>[1] https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/
>[2] https://spdx.github.io/spdx-spec/v2.3/license-matching-guidelines-and-templates/#b102-guideline
>[3] https://spdx.github.io/spdx-spec/v2.3/file-tags/
