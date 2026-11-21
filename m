Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288034;
	b=BLYCJ1w2xoyQNlGG9ZOeSMgio+FBN8lLKc5QyfBwawAXXFbV014CjrA/SsYdCllszqTS
	 SZIDEIOCVRjDBLgUmhZmRtMXijPGhzrVJz9GrXLX26m+7NAzgT+xhfqEzkaE0z597YRQu
	 L7NLZe3hkQ7DMYyhAbO1TirtbmDWiv3ub/ux2DrMF+ZNLTsrlyRVa+cg8uOh4NDb1xwtw
	 XWexEUd9bD2i3N6mDGDyEeS1t+xhu7atnHTyv+IZEtxRHBsfVqyybu+7MCgEP5spjGcpA
	 XpYXI6VC1oxJf2H+bxA9UZcyCTBpU2SfjRfRuRjFkJEiI72RX1bIUHXp43o7nLY9/2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288034;
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
	bh=utccSXcUx3nMfrBMSzeVls7K0JPx57k8P3PqldUHswA=;
	b=WIaII+mQ1bXtdS7CCAnrhDwCO82E7faUd1cvrfhFhhJSZRbsIBBDVn5FASKXBwh0wRMD
	 5RvUlELhMRPqiiPhZ5WWVN5VcEaJhSsyi5YEaOWKNfyBL8bY/gFi8tA++Ej5RQZ81acHW
	 Be7gNXRDlXOMBTTzOS5xncAy1fKpiqAOv4xicbo8FoWYNEl6kxFfMl1pvEtNOXDde3JRR
	 aER6QfC6f4okN+vVunVfp6rBpylr4jTWO78BVw74EkLtNIwr4InQja32tkehs06YmVem/
	 OyTEPqH71b7FqHDcoud9sLHeCjMF/UNcpwWWFg6iPNdu1kht5rrJHoiSeKHFgQYXqag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.114
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021114.outbound.protection.outlook.com [52.101.100.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6B606A320;
	Sat, 21 Nov 2026 19:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC6B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOmUMBqqf85cgrMRsPcTU0y6cuszTCudNBtAcpV1BcTUYIH8aZKwby3NfAOFwqhIMFsvujnpH/m+fHvThUssRZS9tA2n81PDgR1NquF/X3lfKr1AsU5VeRz/tBuKyEKRNE8SdY0CQ4vVrGMsYPUXt6lkJGnSGWfb0JIl1pqGL56EcYTCX847B3p91+gaz33WNchqwxPLyF09kP7f12Q8YMQU4+vS7VUuYOvnPwn1CvgyKKDaa0OkhMGLEqeW6hqpt2TnWwv7//ZcLQLTwbc7Vr0pSPRitmmJMVhPaBtqvEbYrTseS2oF2/gADFL+1RLp6g5EOAEDUYjM2cjhfFgfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=utccSXcUx3nMfrBMSzeVls7K0JPx57k8P3PqldUHswA=;
 b=sXbG0sY0QVguLmSU02S2mAGogoiz59GgCQ9BvO7tTrfee4j7CYkLZYtDwPW0uxGNMMYnylhcJ1gdKIX3ykVoSI1yQrCsiN0mhtwpUELKXH7J3WPS6kep+iYc2NmkOuTS/dzXK2j45fVlUdswxdKn4OTbCBRsFbwgW1jO7YXyBWhpVF1Eiist1W1j+X5fnrJ6v0yx99tmUBE2ca5V2VSGh8VjmZeG8o1vzor9uWWcOqyua/CyNgLp50V8UTpSsi+Xp0+7pSnUEYKfl95AZ6ESU8al3KHyqy2u3Q7dgiVyQQBxgoNIgXFeXXmvmsT7aR2gnHiudAJdlhNmehv8pQVMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LNXP123MB3817.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Sat, 21 Nov
 2026 19:07:09 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 19:07:09 +0000
Date: Sat, 21 Nov 2026 14:07:05 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Clarify purpose and description of
 elf_validity_cache_copy()
Message-ID: <zbu6fisnk6c27aixpcmy267fukgk3t2ss3tfyp2nlabxqi2kfm@6zchi53y42ee>
References: <20261119-module-elf-validation-v1-1-69a74a84552c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119-module-elf-validation-v1-1-69a74a84552c@suse.com>
X-ClientProxiedBy: BN9PR03CA0500.namprd03.prod.outlook.com
 (2603:10b6:408:130::25) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LNXP123MB3817:EE_
X-MS-Office365-Filtering-Correlation-Id: da2a62ef-756d-42dd-d53c-08df4802a413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|261028144727099003|10067099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|56012099006|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hjW3UNFciBbHlfdvfthzY9+tv9P2kssnVbwfUCEjysMjOF6M2Uw9H7iWWLSt82AmSabAbk7suHxlCUiAJyoYcMfe+zz4TD91Hdiwu7Ih8ba2GXF35lzD+QnZ8azInQgD+vmZTtBs1WW9nFYeNODtTK34BjGUFU8bvjleGsGG1eYC2l2aV8SerBfbyqz2fOOTswQlEwdaHUJ3yUlnRxuQpEzHZ8OmV6xHeinCvLPOZ1MAP/TbBIRAQynxv3nHArpRWcdZRbDhyrl6M7dJkSK6NewIM3dxFdHZI0r/1lsz50dahf3t6DrptvKuIevYoI7Jq36+Cvt9sxzLTm7RHGnoRZP0nDZ3p33UgU9bprSlbPIWxdGoxpbdsTAvIDfaKbrQTUqs3tjWv8lFEaDLsDKD+ULQNJ07y5BzyLHJx28MqFBOHyw9IZ7duGUqevqsjEBRgU5g4uF7UWyGl7NSgy/YwMy2SwINT0cKqvJ93PQW89Pc10TXHCOLfx23ImNVc/thiG99ytWbp29DtnGpbI4lTvb0eKXzD0Rh9gFkeijsEpdQc1t40aRJjsTC6f0xjiaQLRMdWdhw3Sfb/rx5aBYMnzhNUjYbLzpA27ZJCS4bH+UuavKDt94JqSx9wZJ6fN2M5a9C6nctpCpaz9U9LQHQ/iShCbLVO00+62hUEWWNQqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261028144727099003)(10067099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(56012099006)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhCNklDV1pSeDMwWGRONDUrRGJ2emVRdVhyUE01L3BHOG1GNERpZ2ZFV05v?=
 =?utf-8?B?WEcwb2ozSmcyM1FpN29FZWhxYmhmc3ljMXdlODI1V2U5OEs1MWVMblIrN0xR?=
 =?utf-8?B?TFRCVitFUjRlZlYxM1JpWU1JVTN0V1hsWjVCWkZuUmFXMnIwbGNabjRHQm1H?=
 =?utf-8?B?WnlnMjYyUEk0SWp0TnFhMWFLQldNMUpsMys5S28zOUd6L1JMVmFPUENEeUVy?=
 =?utf-8?B?R0tmeHVLcDdFVFlPZ1VLS0lPQUtFTzFIM2tEQXVyRjhsWm5yTGRDY283b3Fa?=
 =?utf-8?B?U1hwVDZZdXcybW5kRFRiNldJVnJuVkZSOUt4RER6VmRUV2VVRVkzS09LbnNE?=
 =?utf-8?B?cWlVTitER3M5dVlKQStQM3J3QWFkWFIvbXJkTVVRMzBMdEJMSmxGbG1IYi9j?=
 =?utf-8?B?MEl5U01KeFB1aWJFQlB4MGxSNXgvblNTVFN3OElEQTRUbk9xZFUzejFoTjZC?=
 =?utf-8?B?QlgybVAwTklibnVTUGE5N0hLV2RDMUFIOVZpUHNGM3YrcDRFeTRlOTlmM2I5?=
 =?utf-8?B?RWlrc2p5dkRKVjdiTWxHQURaanRvVk1tSEhBMEZIMlNnVjYxalBrbTREeEZJ?=
 =?utf-8?B?cHJsMFF1ZXlWS3lJb0k0YngwekdiVVhQVnExUWxaY3ZxWk1LNksrcDQxK2Jn?=
 =?utf-8?B?enV0QXFkZUtwc2dCelFFNDVGTENzTElVcy9wVXFoVWoxbkQwYWhmd2JydGZJ?=
 =?utf-8?B?QnBMMER6UmNlUElJeTB4YlJXNzZhUzdaVjAzZXQxKzFKUWI2b1B6VmJjTEsy?=
 =?utf-8?B?ZVZMK0E4aEpPU2NJUTFndEw5eitRZERBSWpJdmlEWkJBVHMvTTRnTHMvWTN2?=
 =?utf-8?B?TG1zdjNmU2M2dGJJcTdKTGtZcVBYU0Rwb1FvT3lYSTJiM1gydTgyQmhIeTQv?=
 =?utf-8?B?TUV4K3Q3U1NxV2RieWNHUTVBRGZMZTJWLzhMNlJmWE9EYTFXWnVYUDJQT1JL?=
 =?utf-8?B?eEFrK1RteDMxd2daZllNZXllczkzRjdtUnQrekhORlJGVGM5Q04yY0NHUHha?=
 =?utf-8?B?TnZJWE5iRGt0elZvd053aEtKK3ZQWWtmQWtjMjdrK20zYTZPSVAzQUNIMU5I?=
 =?utf-8?B?dU9NUlBtZ2pqdGhDNE1GSS9MNkVIS1hpZjFkMURsRXFEeXV4VE9VdWE5Mk83?=
 =?utf-8?B?SUNFK0ovZFRnKytDdDZYWGZocWNaeldnbEtVaG5pRnhpRHl5TUVNbkd3WGdL?=
 =?utf-8?B?Z1pNZ3I2R2tmMkVJb1VSd0lTbFJqL01IODZjOGE1VDFNRng4alpxdjNKT3R5?=
 =?utf-8?B?UWhaRHRvY0luYVI1dEo3aUJhdVQ0cjBxOGllaEduNVJWd3pta1FiUm56S2tq?=
 =?utf-8?B?TnhGVkZoMGJiaFRnQTcyNjFBMXVnOVBIZWpCSU5Pb0pGeWJ0SURpMHJRWVBX?=
 =?utf-8?B?NTB2NWY5Nk92SzhMc0J4MG9WcEJrQW5vKzVZTjhCVlFONWR6VWZJYVdaaTNY?=
 =?utf-8?B?VVh1RUZhSE14em5PV2RtTExOZzV6TEJPY0p6NmZBbWZhK2RXMkQ3aE1xZUJl?=
 =?utf-8?B?UDc2WktjdE9ZaWJqR3JnbHB6dC9URkxUVmhFODN1bzFLSUxqZFVzTUg1eTQ1?=
 =?utf-8?B?OVg4WUlkU3VJdXZEQlorQi9Vbks1MlRWNEhVY0RuSUJwQU8xRDlIeGJpK2NH?=
 =?utf-8?B?eG91VnlkalhTTEF5ZHNMalB6eko5azY5Mm1ESHRxRTFRQTIyR3E0S0JQQzh6?=
 =?utf-8?B?RTdIZDdLejVZK0VLekUwY3FMaEUrR1RieFFIdERLaEtGRnJaL3VaTU50aVRa?=
 =?utf-8?B?OWszeW5OUE1zYVd2dU1DVFRCM2VBa1J2eXF0dk5uN2t4L2FOWWdobmFMRVJi?=
 =?utf-8?B?eC93d3RHbC9mUDJCbGNJSDQ1VDErS3VYdTNXbDBpTThqNkdXOFFWdkVoQUpz?=
 =?utf-8?B?dVZLVUxkeFNodWQwYlVoSzJINmhyMGIwTHJXNGhkTys5bmdxalN3QnFPbHlB?=
 =?utf-8?B?UUdaVjBlTlhSL2U5ek5TQTFzRkpGVHVEaFNGRVlSZDNTdnNXSVAzZWV5NDd4?=
 =?utf-8?B?T3ppc2FGS0hkUEcrdUZ3cTJLRkxqU0dwRVgyL1doRnNjRm1ld3BTSTZzM1BN?=
 =?utf-8?B?QktESzlDSjJpUjA3aUwwME1vWGNlYWRmMy9zZSs3RGk2allWYW5COGYweXdV?=
 =?utf-8?B?NEhrQmF5R2dCckI2cE5uNzJJUmJsUmpvN3R2ZXpnNVdqaDUyREg3eEI1T2pC?=
 =?utf-8?B?OVNaYjQxMVdGWEQ4c1h3U2RiWmoyVEpJQ2ZJNUNzdGZYZVZCNjE3eE0ySFps?=
 =?utf-8?B?NEJWSnBXTm4vR3hPV0ZaK05GS0tLNWUwSlZEZVlJUnBKTTY0QndJRTVnU1VR?=
 =?utf-8?B?MzJGNGRIWURvVjBUdjR4RDhsaGxjK25HNmZTMVAvdXBOOWVVYzYydz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a62ef-756d-42dd-d53c-08df4802a413
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 19:07:09.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpXgxjI2BbOPKbTxmjt4YGRPgJ5CudP1mFHui6aludkmx5npHREgiKg2BkBWkmNgW/jHSUjerMSMuSB5lQUEJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3817

On Thu, Nov 19, 2026 at 05:25:27PM +0100, Petr Pavlu wrote:
> With the advent of LLM agents, a number of recent patches and bug reports
> for the module loader focus on its validation of module ELF metadata.
> However, many of them are misguided.
> 
> Loading a module is a privileged operation. The ELF metadata can normally
> be trusted, just as the module code itself is expected to be correct. The
> checks in elf_validity_cache_copy() are intended to catch accidental
> corruption and basic violations of the ELF format, rather than to provide
> exhaustive validation. The only requirement is that enough of the ELF data
> is validated for the module loader to safely reach the blacklist check
> without crashing on a corrupted module file. This allows a broken module to
> be blacklisted and prevented from loading.
> 
> Clarify the purpose of elf_validity_cache_copy() and otherwise clean up its
> description. Hopefully, LLM agents will take this into account and the
> number of validation-related reports will decrease.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 34e0204ea37c..0c204f07ca68 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2421,24 +2421,33 @@ static int elf_validity_cache_strtab(struct load_info *info)
>  }
>  
>  /*
> - * Check userspace passed ELF module against our expectations, and cache
> - * useful variables for further processing as we go.
> + * Check the ELF module passed in from userspace against our expectations, and
> + * cache useful variables for further processing as we go.
>   *
> - * This does basic validity checks against section offsets and sizes, the
> - * section name string table, and the indices used for it (sh_name).
> + * Loading a module is a privileged operation. The ELF metadata can normally be
> + * trusted, just as the module code itself is expected to be correct. These
> + * checks are intended to catch accidental corruption and basic violations of
> + * the ELF format, rather than to provide exhaustive validation. The only
> + * requirement is that enough of the ELF data is validated for the module loader
> + * to safely reach the blacklist check without crashing on a corrupted module
> + * file. This allows a broken module to be blacklisted and prevented from
> + * loading.
>   *
> - * As a last step, since we're already checking the ELF sections we cache
> - * useful variables which will be used later for our convenience:
> + * The checks cover the ELF header, section offsets and sizes, section-name and
> + * symbol string tables, offsets into those tables, and selected
> + * section-specific constraints.
>   *
> - * 	o pointers to section headers
> - * 	o cache the modinfo symbol section
> - * 	o cache the string symbol section
> - * 	o cache the module section
> + * While validating, cache the following for later use:
>   *
> - * As a last step we set info->mod to the temporary copy of the module in
> - * info->hdr. The final one will be allocated in move_module(). Any
> - * modifications we make to our copy of the module will be carried over
> - * to the final minted module.
> + * * pointers to the section headers and section-name string table
> + * * indices of relevant sections, including .modinfo, the symbol table, the
> + *   symbol string table, the module section, and version sections
> + * * a pointer to the symbol string table
> + *
> + * Finally, set info->mod to point to the temporary module struct within
> + * info->hdr. The final copy of the module struct will be allocated in
> + * move_module(). Any modifications to the temporary copy will be carried over
> + * to the final one.
>   */
>  static int elf_validity_cache_copy(struct load_info *info, int flags)
>  {
> 
> ---
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> change-id: 20261119-module-elf-validation-a5a0e28e6dcb

Thank you.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
