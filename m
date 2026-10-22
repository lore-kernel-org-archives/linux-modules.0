Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792695877;
	b=lrJ7A4/gEC3ZF1hR5zBcX2ZqujVrid9N2sTtxDtbP323Ke45DC7eck4lzWP08jopF9ki
	 GquIJ5db0qjl1Y+hh2kYmWDxOHOXo+RSNkXRxilukEsHoyz3Eirklo9xpWZjkRk1SiFzC
	 5hAiCvtkSI0lcdzo1YDKc7XZVE0bDjsz7AzinvXTZ/y+M6zXxh8zEn+cazHYC+nzfdTUo
	 7E+CuPdgCg7qbh6wz4NZGwalMyAKS40oBWt93NKO9ee2PnXaYgeExTHj9M9L9ckWqTxU6
	 ARCiwymJIDh5/xuyQ8ESgpHhVAjfeq31lk8EwtsxCDWAAfWIW1c7QN6qiUTKdaP7ugw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695877;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RxStaOPPvVmeIILaqR8HDJN3uO2GPDcoVsA6i925JSo=;
	b=mSDlrDZJGpdxRHAdnZ3Dtor+sCPaBdmCMe/IzyPWzahvOZ/V2SIN1D/BCVjBMTj9/66q
	 p0cM5XTKRmknN7qTKkm84Wdk2B/rP8btAlSwCo8aMh3vgVwcN0KAUEQyemuCFU5CRVt3i
	 9/RK8A1TMJkmlMBPqR54SgAvIIFObE0Ejjpv94yr9AWvKV6APnWU93JbR7sOeRlDVPaTk
	 zaK6F7bNCJ7IvpDgNK1yKkb7/JbLFwLwT03rtHERCujK6vQZDLq4iVyxipX3E5Bf8/rTk
	 9AC2/abUA1DyvUajGn1/DjagH7tG62PWzlYFDOjOXVCKXSndEfDAaQm2ZEbdO920b3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.136
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DB606A31B
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 19:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006DB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKLWoUF6/zSfaMaLH4X+548vHmwF/O39WFtUTgh4ULM64abF8yGWWKrclC0f+hNwDdeirm8+GDzg2ClAtwpZZ6KOcrFWDt3EiI/r4gD6MlGkMNugxIazbL+c/UT6xBMFjrB+68KI6ykNel+dG4L2Kj7abamyOgySF8RITG9w5W/7exq47MNGXcOxyWDCLJy+nBlZnpfoEQHzfkb7TU0Gn1m0qkCak8gNWlfmAemka4RM0vgvqQj7cywya8uHr0yLIM/+jsomSX0MgVmAo+db7M3JmHRy69vDKKjq7iqePecpjcCSIGGBq5e1fsi+RB6kW4eFyFxuJNvpexdMHxkuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RxStaOPPvVmeIILaqR8HDJN3uO2GPDcoVsA6i925JSo=;
 b=tFsyPj62gAyNL4lsCDvaeW9vcPP3oXfwPo5MSc8n99BghCbZNJpdloD/JiH2O40SrSxMlVcpgDARz4jCzviv7ghE7qVIanT+e/6gLOCK1KyYSyhJSmrBvhc4k56SKosMXFS7e2eNvhyaaLaJxFVW2QKj8Zsvj/ieq1iBsGU8Xzv8c7Mim1UzgG49W6xjUsD7xvhaxbaQlKeImPIE2RsCPVuo4djp1x39V06fu535Rkr/X1pX/CjMb6/UdmgK1H+d0jGHCkRQ+s//VDERDNA/+RnMB0gAqFntXp5st/81m4hBPrr1fopn1QSe7JpkHCh2jfsXgBbXFkSucyDMJA9F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7423.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:330::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 19:04:33 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 19:04:33 +0000
Date: Thu, 22 Oct 2026 15:04:28 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
Message-ID: <xkmj4fhe6wvtq54kmpg4anfmxrcqrpv3yrc4d2adlki44v5hy2@dxkednlyzejp>
References: <20261022184517.66438-1-atomlin@atomlin.com>
 <sashiko-outbox-181939@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-181939@kernel.org>
X-ClientProxiedBy: CY5PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:930:1c::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: b8727f7e-3cce-430b-a48e-08df306f4ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|4143699003|261009223027099003|10067099003|261022105027099003|56012099006|261022075727099003|27256017;
X-Microsoft-Antispam-Message-Info:
	YcGpZ2EnSS5dGSLWqU3WV22gwn3qbW2GY4r3GhQaxLpQXB41P0AOaWyj/w1bA416B1vRNIyN6mYJFT7NbwRBKlYTjin89Vgm3bE/CTqKDjXVAzIZ/DrHsxgLnxrr8nszUqvQcvG3TMlDbdvTBLlMfE2MbHMbnao940aXYOEzt4gGbgt8GWalMtV/Hlf5PAp/9WW4h6e0hrA8m/C+iEHyDpetG9KOuj+9nFL9MY7ySdisczg3RRCnRQrZ+MDlepJutDYCgAPt5Xr2Xq1xiddQPF/8ZAPQDvNQG3ubNbfing8zst5/xY9blj34suh3E5DXUeJs4Xep6GuNS5e4JTpxiibmnX28qi8NLdfcHbc4nz0qAL0NAapi1wwkmPgcbXAADEcVxZFUnCU5WUR+z4eXili537cCh0/6OikPHxqWePpP6jwVGif5zgh0r7Kq2MhI25R+Lv65U1mt4NZdGZNqr4lDILIf2Q4dYIJpSuBLHSWgPwNt9ZTW84gAAkcaLOapOw9UurwMElfzYZ+vGHeBDHcRPCeWypLmiIB/SH1CuYf5owwlZtnffdjG39nnhMvXPEwofAwX9C8iPTDG0TSJykANjrKiV/JUahrsemGx4xrd//y5menACBqAtkmPEsEAnoQtGt5jFSD9Pucca5v7LBy4Asmjsvp8hJC7Mnhr240s6F89Ufv3vxEijAgO8e+XC2tflRUCCexqSmXoIroHTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(4143699003)(261009223027099003)(10067099003)(261022105027099003)(56012099006)(261022075727099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1g2NmJBOExGV1FhNU9NTkhnQlhoVUMwdCtNOS9VZGU0K1hPS1oyYUljSFJL?=
 =?utf-8?B?TWJTOTkrVzFaTXpJRGIxWEZQSjFJRUNlS25uV1c4Um1JdnhHUndodkJsVmY4?=
 =?utf-8?B?TnZ2WTU2STRDNGNZaXZGc0Zrd2lNamZuWEVscmVENEExVFB2RkMyYmN5a1N4?=
 =?utf-8?B?VHA0bGhiNTJrK2h6Nk51ZTQ3eDA4aE9PZ1hsTXFUR01RK2RVZzZpaWVkQkVF?=
 =?utf-8?B?ZFFOelM5QkhoNExCWVhrUG5FVkJCRTBtK0M3aTJnSmp4R1J4UUJ4dGp1UExu?=
 =?utf-8?B?YjlvTVVpU3NuS2d5NGVsU1F2WVhCOGpoMU1mSWFIeVRVU0RDLy81d3duUWFt?=
 =?utf-8?B?cFhhNnFGZXBxSExUendxdUZxdW0xZzc4QWQ1OURWNnQ0MGdZSlVOaVNaSUlt?=
 =?utf-8?B?Y2FuL2IrelU1SjRuWHNPdkgrQUdOaEJneHVZZFdkeHJ0U1NjQjNDTTMzN1NR?=
 =?utf-8?B?TXR5N0FSaEhXOUh4VjVYbDA0RUF1N0RlajljQzdlT2FobkVOZU9ZSnpHQ2o0?=
 =?utf-8?B?K2xPN013bDV6U2YwRnBId3VFVHpsRXdiczBTbUJaL2ErSDJRS3lpeHNyUklt?=
 =?utf-8?B?d1hRekJyTGdGbFpRcitYaC9tM21wTHFleXc3elQ5eXk2ZlV4MTZSeURWRnBE?=
 =?utf-8?B?dUlFZ3p6QURramdMczNlZzFNOW9yMlpCREcyWERuZjA1Nk1QeC9NeUFpRzhF?=
 =?utf-8?B?SzVHREFZQnhnTGl4aGwxY283Z1BZaWJzRFpmN0FXUng0VUZadjZVQVY3d3hQ?=
 =?utf-8?B?SWZESHFVM0pDZnBVQ3JQSnNQUEtsbWMvQjhmZDF6R3NCTk44ZFFVSGxiakp6?=
 =?utf-8?B?bFZqR0lYcnRKQkV5THhTRDJMb2JVdjdwTDhSV2cvdVl5Q0l2czZkUUdlU1ZS?=
 =?utf-8?B?K05PcXNQR0hRQWVtcUFJNU1FOVo2dEpNdm04T1RaWjRMNW5GaEpGR0wrRVJM?=
 =?utf-8?B?czJvOE1sU1FRZ1FmYVFGSGhzUWRNUjIyMCtMRS9iaVI0MngyVE9lRVhZVEU5?=
 =?utf-8?B?Q0lJMjVSSllEd2pYMDhQTUx6OTgzQm5JUmwxTDFQdmFBU1k2d0NlaE5oMGZk?=
 =?utf-8?B?b1FEV0tvNnhCVjhodnZXT3ZKZkxCbElibVJ3alRXekZSWTViYUFsazNTMmJX?=
 =?utf-8?B?YkZoUnpNcThmcGQrNC9PSVFzUjRwRU91ajR5cUVhYzVVK3JWR2xPNm5sNCtm?=
 =?utf-8?B?WjVTWE5QcERDSFA5aUF5Y2JIVlJzZkpqLzg5NDV4cnhmaHBobk1IVTlSUFJh?=
 =?utf-8?B?V1VGR0FxSjdFWHdFNm12Zjk3MmR4Wjk0bElYYWlJRjRPNVVyamlkQit6azA0?=
 =?utf-8?B?N29YanJUdXp0YVlQMUs3dCtQSkdyTnRtVElEOTNrdVArT3JndDVheHpaTDd3?=
 =?utf-8?B?dzJLcXZxTmpXS1FuZmZpM1YzT2xBYk0vUldhYWgwemJxc0tLOW8vWjNUL0FC?=
 =?utf-8?B?cTVsK2JNejU5eHFUTURlQ204aDJRRmVnSVNUajRNZ2tTTmdCMWdhQjV5b1NC?=
 =?utf-8?B?Q0Fyb2NsSFFIaForR1ZIZ09LQjhXN1FORkttNEp0VFdETFhUQnlFRWZFSzNY?=
 =?utf-8?B?c0x3ZUhnNitpbXJrZHR5dWVlMEtxcXBlMXN4dFBGU0N0NXN2VzcwV0Y3ZXlt?=
 =?utf-8?B?L0NTcjJMTlp6cjJaY21zc0xOcDU2TG1YY0lkWVZKbDZ1cFhscld5Q2hodnph?=
 =?utf-8?B?TFNBcjJUeWxrWGxPekZWQm1VaFdrSFF2SXF2YUduQmc4clNTRndTRllKdmV5?=
 =?utf-8?B?b0QvSVlFVUY2QmgvbE85TmJGUEhGL0FCMnhNbm9DV1cxR3ljcHZpZ0F0UW53?=
 =?utf-8?B?eVFmbEhzcVVjeVRZbk9EV2l0STFNcTV3VC9XdFV3ODhHQTFhKzNHd3hoQlQv?=
 =?utf-8?B?UGRCVmZZK21JY0lnL3JheVpJOWpiZVpGRUJFOTZBVm1sQTVxMHdFRGtUbGhG?=
 =?utf-8?B?NHdwVWZZL1ZyUHdiSlJ5YnJnMmZjRzhvWWp0cUFub3ZCeGUzUkhINjNxd3pz?=
 =?utf-8?B?N1NaRTZhcEU3RkpQUnl5S0QyMmY4Y0d3WFFlbTcxSk5oNEc4SWtUYmZWbENK?=
 =?utf-8?B?cnQ3S044d1BtdWI0aElnNXdLMzlhdjlpM0psVTlMdHR6c0JLRFNmWm4rYWFY?=
 =?utf-8?B?RDgzMHVMUXZCejE5ekJrejdZUzA5eWpKdU1BR1N0dm9ZWXdvaXJzWUZuWk5t?=
 =?utf-8?B?bGdtOGtGMWN1Q1lzTFZ0K1k1OTFIbVJRUnpJeUh3c2Ird2VSdklnT3AyMGdC?=
 =?utf-8?B?Q3ovenltV3Fya3k5ak51RWhlN2JjZTNwYVdFVzliSHVMV1BocWhzeDRabDlS?=
 =?utf-8?B?R0ZRTjNvT09FVjM5aFdBLzBBT1gwR2c3UlNaaVlFYm94U0VnK2V2Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8727f7e-3cce-430b-a48e-08df306f4ec0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:04:33.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kmzw6xdYNAtIGhtUIEVjFdFK83mju+eMHSglloFue2k4IA7yZnfL+WMmA23ZzNz6lsHY9NJOdBtKncSmuzcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7423

On Thu, Oct 22, 2026 at 06:52:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] module: trace_module_put() records pre-decrement refcnt in module_put()
> --
> 
> commit 2c168275e42fc7a4482d549cb0c9f1fc9f71e395
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> module: Fix use-after-free in module_put() tracepoint
> 
> This commit moves trace_module_put() before atomic_dec_if_positive() in
> module_put() to prevent a use-after-free if the thread is preempted after
> decrementing the module reference count while the module is being unloaded.
> 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index f1392c10907a2..70063fea52d03 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -954,9 +954,9 @@ void module_put(struct module *module)
> >  	int ret;
> >  
> >  	if (module) {
> > +		trace_module_put(module, _RET_IP_);
> >  		ret = atomic_dec_if_positive(&module->refcnt);
> >  		WARN_ON(ret < 0);	/* Failed to put refcount */
> > -		trace_module_put(module, _RET_IP_);
> 
> [Severity: Medium]
> Does moving trace_module_put() before atomic_dec_if_positive() in
> module_put() cause the module_put trace event to record a reference count
> that is off by one?

Yes, moving trace_module_put() prior to atomic_dec_if_positive() means it
records the pre-decrement reference count rather than the post-decrement
count. Introducing unconditional RCU read-side locks on every call across
the kernel solely to keep an inactive debug tracepoint post-decrement
introduces unnecessary overhead. Relocating the tracepoint compiles down to
a zero-overhead static jump label when tracing is disabled.

-- 
Aaron Tomlin
