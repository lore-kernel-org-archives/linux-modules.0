Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F425B663;
	Mon, 10 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788727; cv=fail; b=omikjKos2fYnmflX8PJ5hMnybLH8EJOt0qS3lsHBINIvQVcaWZQoMo1hRGedFdNbe/yL7s8AbWfDTMpqBW30CpbhUJ0H5whEGsqKi8S+QrF/9lTYRdTcR2YsciHZ/m5JqcZVh2Nay+7iV95/onZTIy4HrZblCwMmOXC5IroRPCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788727; c=relaxed/simple;
	bh=MF3t0av78k1KZxahkS4RtycDnQH8/Aot+X/i8wDw+U4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N6B4Ie7uK5nkfjBGqfyXAwnPAYUyDcG51443V2Ag+1+KoE6iOv1V6RvIYkJAO+34694uW6IOiMZ1bvxB4dT3u/6D1hYAPtQ1YC2ZZC5/s8rCs0KTqOjX9oHxdWV2iHXGHiJrUIM9UZgN8faq6OtVQ3+aNxLHBS/QteRFbYgfVaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIPXD0fH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIPXD0fH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762788726; x=1794324726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MF3t0av78k1KZxahkS4RtycDnQH8/Aot+X/i8wDw+U4=;
  b=MIPXD0fHs6fpxge512y1OiGWdN7rQTa0fpzazI9ZsS81+y9+/qhLQw43
   LIL9OoUXH3zAtVyaQ3zNZ/ahHR2tshNSpSgY8HpBDxgDWnhoLQfG5R9gS
   eQ0VVzObVqXBweBolg6CX+aKDJNskvwhafw0ub09ItxuYQabKN0ovSWno
   a69Vvnc+OiBvzwgKjJdvTCGnFCmzjAMo1ULSKFd6k0AM16ftkV/f8lyEt
   BIcMp9uWziGbY0e2zupaEkJfU28uZDX9Qs9OBbKimhloe44L+uyA7koIf
   RvEgVMk5tbiKPx4ZVByR5vztoiDCVNATy2h36LMoP4DsRj1ac4Bmo54R5
   g==;
X-CSE-ConnectionGUID: 1GB2YyxqRSCht41pKShh0A==
X-CSE-MsgGUID: WKVsfJb1RNy1g1ulR2U/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64879825"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64879825"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:32:05 -0800
X-CSE-ConnectionGUID: SFMCuGacQKC9Czvb9UFcMA==
X-CSE-MsgGUID: RSKp82Q3Tx2jMu7hrE44Qg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:32:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 07:32:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 07:32:04 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 07:32:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXT2cZEcOiF3Ub2PhQclGRJb/3L1EThyWDL2tpJak2clxaS0eQLr9+GM/RGuCTQpZqfDK83kJns1hC1XesA6mDAnslIK0eSYbQH3EcgPjIbs79VVT/P0JWU1yz1gaiik8paoSjjs8pnKlhMcXxcFz4tLXfHZGFdHz8AjemWjdaaQWy7EkeD0PwBSONmEs/PejZ0bt0hX8/s1HbW9Nz78njttjaRt8Q86tAV5z8rl5giegSXUmLmwUlEqfIpZfliwvqqjsEo/N+kNKhYYu7vlxJw2f1LKt23yx3DdvKmqwZhE3HnGlGX3mPe2QKfkNuFqDnqkfHKJfh2vN+v6XbDBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF3t0av78k1KZxahkS4RtycDnQH8/Aot+X/i8wDw+U4=;
 b=TOZ1ZklBDWBCD9Kcaa20gHR893DuN/SFN1Vp7bmgirQmZM10lx60lVRrwTcvBsEhwz4RDx2vyH+3arF0MNlEDwynxP4WA5wEKuHAHDhgl0rww2h0GDHwMv3/x+aoeElJf2BrVZM5c0PYVogB2raGAjTAWFuFbAXKuz2OFa7DMl2kb83U1aYBENV0flF9NMTLWkacJQHoQpCkhOCkEgY8fq9m1gGhH8xrsif0eNHHsZ/8Ar/n+NIRitkcYjapVfYeaQAzB9l4LezFlXNaKEofDq8skBlD8Fyl2oMfloy8AwOHZ8aDGDVRgNIo+/2+FvjjIrBbH7XN4J4uxERwWKkmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:32:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 15:32:01 +0000
Date: Mon, 10 Nov 2025 09:31:58 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
Message-ID: <geqat2upyxwvqjsp4ietmeypf4gmeoerg6akstbvelnxe3zpl4@dzqhyolsvtvc>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
 <ea36d12b-15b9-4c1c-b81f-75834bc3269a@kernel.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ea36d12b-15b9-4c1c-b81f-75834bc3269a@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: f6289fdb-784c-4787-df5f-08de206e4ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ai6t9YGuUJU05TcHD/mHRhGER/NGwcqIxjd0KJ7QyfynfWqNOeQB9/OaPpMu?=
 =?us-ascii?Q?WodhH7ZYOQaxGgMmYnO7xSjxNbXRfiW1KLyta7llQRnxFiO+VIHElUsb8WPm?=
 =?us-ascii?Q?mP+wkXweKIZGcZwLWZBAFYzjeMcJzutrmL/xZ9kOQyaa5q1paTI8cACBUFvP?=
 =?us-ascii?Q?5dT4nWis8cgQIuyxTXesRulYvuN9KJ/zwq8cd2TdNnQpS56FAN7zzBvJuAJG?=
 =?us-ascii?Q?6g7ePbzwTqZlkt6/HSAkQs2m5vITrHMoW85AYFPXzmrVAW/VN6Ymfyvgys5B?=
 =?us-ascii?Q?joF4xw7p1tHFU+3CNDwskg0Ir4oIofwJPSkOnBLRCADCU4Dz5XsxqJcQQmvY?=
 =?us-ascii?Q?2YBoLPxeou0c4IHJJp+5QyY4ybaEn0bNtimdQvwd5xm2xtl/dLIO2UJwojgR?=
 =?us-ascii?Q?2QHV3JFKRU52Fb0pexQ1M0+nifr48Q3bCGvQHFRHpoK5TU5FdVTTSIdtbyNZ?=
 =?us-ascii?Q?+Zp3iCXD5WIcH02F5FHA6XKrqN2i/jNbLEpMz8JdYz3NeXLjXngG/L4jirF4?=
 =?us-ascii?Q?9MHI6LFa8gjLyVfP+6vUCDiXo+pNYXRy/dZgB95MOt2hV3Fnh+Gjj105BWF0?=
 =?us-ascii?Q?q1//GGJDqiAPROeBhyk1iU/HIzG7c+Ve4svQ80y0P4Tl8pKBVsyqWJPvACnY?=
 =?us-ascii?Q?5Jn0UIFvnoaw9pgLPjBeqDuQLKYOxRQlkezJF08yz9/MJ8avb48S8+1WUYpc?=
 =?us-ascii?Q?40hSVOfz15bYRBRR49cLP6CVD4+KIoQx413sZBAAeiuw9SWW/d4utEYpk8YD?=
 =?us-ascii?Q?at8uJfvcukLafL7LUJsrKAV2DN+kBnCopyzpG56FXJrwfmu4glUXa1c7uagW?=
 =?us-ascii?Q?4cA6IhsZwWR0q2RILzdcmHrl38+o1CgkCKUCFrsnlUM8Nxt0NYSlqiegtPvv?=
 =?us-ascii?Q?5a6/OGd0z/AZ/6F3E/GfkhfY/nCJoiWmPQxhPJGjltICfQimaCWrXayBtXOk?=
 =?us-ascii?Q?eXah6ZM3IGvbWUEtlc+xUowfIHLWaOSEIlbpZE9TMjDQYMZL91FQIfw0oP0v?=
 =?us-ascii?Q?c4bonsW/rta2cIisv4qpRC10SPsc1VEsTKTZlBwe9LZ3UeXjcAH1nVzexAlz?=
 =?us-ascii?Q?Y1JOrllbRrrDSt+WF6mXCaJnIep0ni55JRZHqfMephVYXgjdgLQZOsmqDDhe?=
 =?us-ascii?Q?Q1wiNu/Pa1wn50gYUDoKtJqTJaLrPbWEAv+c+OGyzXXuCL2yt0zn+8MNe/xH?=
 =?us-ascii?Q?D7X632zBSKdihi74pfDmuI5d/CADwJCsJtTUhpM1sx01UxmaRMGVUvi+6Xdy?=
 =?us-ascii?Q?TSIryD5t/vMz0Av74a4KjfLYN3NHy7YrbJYuAc38Te9zOfXGDjqt0dtJCJyL?=
 =?us-ascii?Q?IwfKDU7tnJJNijS1rD7u4yXZVGpw1UcEEeaabrwkDXutHE7i51KYACxGVvrh?=
 =?us-ascii?Q?ktlSAfqe2CaO/nB+gNa4AgFWN+ljH5AB6dUJ46iI/fpO4ZHKAEh+i2npH20k?=
 =?us-ascii?Q?r+eedK347UncV0Up6KJpihzZl+JUlywBoMbK079FnMjq5f7EbbYUFz4uikv0?=
 =?us-ascii?Q?nsE5dc0V5nkDM6V2cRl0NeMCeyKVHv6qhAHV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/muEMb+Wj6FONcEIhlY7zFmPONa4wpJFgOJPlDgRx5R9GwkAufkjSNcWIqqX?=
 =?us-ascii?Q?zUmW3sz4AU90N1cwtCjHZApFrqZbAx9O37yGqN4DmOZsyK6+BYi+8xyFghLk?=
 =?us-ascii?Q?g6jJiiEY0Hi63RA9HjgsXbNA+41CgNS6jSPTgp+LbYM/8NcFw1JY/7IqWbOy?=
 =?us-ascii?Q?7nJuSmzgDztiKa58RliKWKDjV6L3YcWPB1xuBZJesahzzFaNTaiXl1g9WaSN?=
 =?us-ascii?Q?ULmo2we9h6ysTnXmREGRLL68mPVcHpUifLqyIpgqa6Uy19xca9Buvk1xmxny?=
 =?us-ascii?Q?WgXoO+XzIYt8G/HSraEmRZZxhHnsllPFtt7rGXyyxHT50hE8iZUgD+qWfd0z?=
 =?us-ascii?Q?45CViMc9wVVoS9CdwvcJVVZBWvuy1jQU+9gQSZ3Zq9kYl0Bi7M4wQZYOhbHl?=
 =?us-ascii?Q?gc+Mivnzep944TnRPxGkB3BsGR9jj7CQDqE7NvLiSWVoruO0rlNFiWUc96A2?=
 =?us-ascii?Q?eiZ6u3ZuE/G4EZ63/pKJsgHEAEUMJK0dqkIWot7Gdqlk4pSRy2tS6ZITs1xS?=
 =?us-ascii?Q?5j7GFd5+ANvQiT07Slzs76qJJGrjvQYidmykCABYp0a9jkR4lYy18QgwoXIR?=
 =?us-ascii?Q?zD4POZKCo5YlxD19ZM5rhUmPIm5MqPlwi237ezn2VV2CQwRn7tC2l99Js/dN?=
 =?us-ascii?Q?GeQsboKE45dBiFC4tHyWIY5fv3PYnt+dC2XzNcvaRb/iIembLMBX4n9zTOo3?=
 =?us-ascii?Q?BoT3FMcUXkk8CTLjV3dKg4g4pBpdsu8TAeDv3HDtINWawKhhu+P95/Y0bMXN?=
 =?us-ascii?Q?W8egtJvdHkvszyO9WlOtKKBsFJc3Byg51tKgxAquuZXJ6P7lgnUe7Kk2Slhj?=
 =?us-ascii?Q?kBAq1HWCoaEr2Fw1+yQIlvWjmyPfPy2PjmE2Cc+ReXsqaWZsXn669FaV0VOs?=
 =?us-ascii?Q?MIE5DelD1Q8P+TKw77qkODglfisIk2GAZnVDOF2loRc+JbEMlx/3BuOy812r?=
 =?us-ascii?Q?Arf8Iv39+amoDCPprdKAkPWzkWgvNBfFlaYV1ez6iS6EBFoNEUrpoJpiNNMu?=
 =?us-ascii?Q?53Y24EUu0zrjimHZY2vUkQTzRcNJaH67cSsJNzvD4zMXn+8oS9v5zWflBrij?=
 =?us-ascii?Q?+r7maft0rAmdclg1tgtkONWW8Hu/bo1PKLjxnZlPHsOy4+6gQYYL5pWMI+/A?=
 =?us-ascii?Q?aFEGQbW1Rlj4O3whuME4oG7nUaGl8KS6X/zrENk0pHOqJivUVtZwrfwy0h/e?=
 =?us-ascii?Q?Tqbk7fOO8L28ANodwFp83Lco57hT2pqLQQzbIaIfZqzn3KLjMs4gGD7DFhrM?=
 =?us-ascii?Q?Ow3/h2TOHc/71H9z+wdNsdvtBT62KxXNooZIx4OXHKAjkokUEBILI+PJ+abW?=
 =?us-ascii?Q?/GWQO+/g/j0Rr0xR6tA95YHAwcwQtZ+SLsqJf7qIwPIwxT5JSStrq7fHlNco?=
 =?us-ascii?Q?m07WDxePf1mSkoHjEK6bhT0+7jsc1snYvfJTaAQLq82buXc8J46KX1K/wRFY?=
 =?us-ascii?Q?5ICqugIORuKOuIsIYyZe2i83fg9TLsb4K/UfgP4H1DCteXb+ge0gRlFMKy7K?=
 =?us-ascii?Q?tXbkPWHcyHe40Hq1Lcu7yUBGiqMRp4E77UHwJNuXw4if6U3bCo750+jfb+Wq?=
 =?us-ascii?Q?z3Y1WYazb766OnEDVTbuzqRD6Gm2acIhhpULTiXz2qKYDqePX+gw+SkJIvH8?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6289fdb-784c-4787-df5f-08de206e4ac8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:32:01.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grn7X2YHYwwGXb7eJX6HjK+iFD60tdSPII8cIQu4QrtbEiVc1NL9/YqoCwZlU9puuDW3kRMMQoRNpO873Q3Lhz6pSGuWWkn2jZDm4vavAl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

On Mon, Nov 10, 2025 at 04:17:47PM +0100, Daniel Gomez wrote:
>On 13/10/2025 18.26, Lucas De Marchi wrote:
>> The -EEXIST errno is reserved by the module loading functionality. When
>> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
>> module is already loaded in the kernel. If module_init() returns it,
>> that is not true anymore.
>>
>> Add a warning and override the return code to workaround modules
>> currently returning the wrong code. It's expected that they eventually
>> migrate to a better suited error.
>
>I've been following the thread (and apologies for the delay) and reviewing the
>patches, and I do not believe we should push this workaround. While this "fixes"
>the bug reported, it also hides the real problem and drivers will continue
>misusing EEXIST at module initialization.
>
>From the bug report thread, I agree with Christophe's suggestion that
>nf_conntrack_helpers_register() should return EBUSY instead of EEXIST. This
>would fix the root cause for this particular module and will allow others to
>change their module behavior, if we also follow up with proper documentation
>about EEXIST.

the fix will always be for the modules to stop returning EEXIST, no
discussion on that. This is the messenger, not the fix. Someone starts
seeing this warning and reports the bug. Then the developers can fix
it. It's much easier than dealing with the outcome of a module returning
EEXIST. Also note that we already have a similar reasoning about adding
a warning for module return codes in this same function.

Even if we had the means to check possible return codes from all
module inits, we'd still have external modules.

See patch 2: after some time we can simplify the warning and maybe even
remove it.

Lucas De Marchi
