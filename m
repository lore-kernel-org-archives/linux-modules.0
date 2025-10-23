Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022132.outbound.protection.outlook.com [52.101.96.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51A17A305;
	Thu, 23 Oct 2025 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187421; cv=fail; b=XtwhleHTCtGMQebwTljwfz5qqa3c+0YRuD1J9mf9idg+IYF9OhPsrrKJ40dKPnY14P12ivUIRi6Hb8SJBOVAjWZ1JkoEK55upme9BGTp+sTo75cwyQ/0y9vRBFXtZEvjM3kLEU9eL7sckUVaGysyuytES+/PyFaBidN3kJ03v/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187421; c=relaxed/simple;
	bh=LBADxA7ua0vO3gGZaFWiOl1UADE0xPImRYUK8OXn+jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EKkX00ZPR/sGy1mz66wAP3Tul524zb9nPOPRJQaCrotiO+M+dS9xJOMF9ZNTD+HmrHVeDuLZirLwnRCbveqp/UNpTWFhpkYw5fltZYG5KC7mC9nqd/zOC/9DiLeet9tR2qUEH09jdbmXsxGPonKnl9FC1ddYmGHhIkg78S5OSPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4DNiuhwqlJGGKfuwU7+0c5p93oLiKr7oTGYeuXdlmVzVmw/aWC6Hv6wNq7rhWdC0so18TIbNEtX5XQ661M+WlMLNDm60+cteQjGI+K14kMi8oTrptKcc76QPo63Gyrgi9Y6xkEr/LS29WQthjxwKFIh3T94aG8W3jL6mIM+nkbjS+OafJDs73pEbLYItVFkOPIELGDrMrvnWwNnak9djyqic9RfWD9QFQdL5m9QNExJ58R2lJ2bJAebRZuxDZScyYCy0+tUaSXI0OrY9H8I9cpGRFg97WcExue7nUYl40csr6ko8GpBa6GcRnYFbcNYBtVeavr3mJBegic05cgqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hARGRg+bxB3DCyiYic6dS57/uBUSFbfMzB4hD3MzVzU=;
 b=nxwadG1o4ulvWTfWbiyb9COG6zV7T7tPrPJguoi3s6zSE5jVzOOEp0gIHhiKYRYsJtYb4+cMXUabrafmCC6DQlQwPLiMs1/EoMfQ+g/yBERaZ+f5+AqOd/JvveWrxks+852qmLsI6CA7JdofCxF9rx47HYyADN4k1ycw50+ExMJErtAOn6JtqlmRu4UhxjDgxFuwZy3bPz3+5qUn+b20qv5uBaClqGkJpNfbaWMmfQoPjA7/RkreJwqpwYISIs8D3UdH704pK8VlyVxMuJ+gX2VzxAesZrcWcyHP85spkbFgA1N6OU2SUuqPXZV0rhxJqok8a6hiDIAM9zQCKxHCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2879.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 02:43:36 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 02:43:36 +0000
Date: Wed, 22 Oct 2025 22:43:31 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
Message-ID: <fti5vtvzdcecmk52ykyom2od3eeje755ce3afclxkskpc76i7m@i66w4frh62f4>
References: <20250819121423.460156-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819121423.460156-1-petr.pavlu@suse.com>
X-ClientProxiedBy: BN9PR03CA0430.namprd03.prod.outlook.com
 (2603:10b6:408:113::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2879:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5ab2a7-07a7-4d31-009b-08de11ddf6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clN6RTJtcit2dVpucGxnU2ZIbk95Z1hFbHNvalBNN1lBRW5DbmlVZXlPYjRO?=
 =?utf-8?B?VytaN1p6Y1h0RHlDeExmQWhTOVhQZkowWWxSU0xIdWV3em1oSUhQaGxocEhh?=
 =?utf-8?B?MlkwMzFZcTFrakpHRkpXUTYzbXdSVnp1NjR2dUZWR2R2NFBWaHYzdUlrNnhy?=
 =?utf-8?B?c1ZDblAySzRuNGpPNTJSOFpKODRJMWhMYmZ6RWViVjM5L2pOVU1KdmxHQWVh?=
 =?utf-8?B?NStMOE9mQnFleitTQ05XS1lnVjRRSkw1bW1mN2F6bmF1QWgvRFlEV2JxbW1E?=
 =?utf-8?B?NmRSY3NCWTFhcGxZL3JQeDJGMVFXaXd6T2tVa2pkNmhOdFdrc0RaZkpKaVhm?=
 =?utf-8?B?dHZFSjYwRmpTVG9mWUswRWxLLyt5QmJFV2NxNlRSMzlEaTZrY29VRHYwVHo1?=
 =?utf-8?B?djE2b3E4T0VYQ09IeFJQL0txak9iQm1jMDI4a3dLaTdKZHljV3U1MUZTV0VQ?=
 =?utf-8?B?eEdkTzhaaXowcTg3L1NoVFFlanVPUVVZMGRpMlduNkNwUFc0YmpYZjBEL0R6?=
 =?utf-8?B?OCs2bmYyMU1XN1g4TzFYVUxVczVCK0kzL05OZFhpR0d2anJGT3VvQUZvOThp?=
 =?utf-8?B?R0RPbCtzYWU3dmpXM2xkbllFYWU2QThoUElMZ3ZMMGdMeE9xdFA3SEZsdDFX?=
 =?utf-8?B?MlFGRjFtSFRXNTdSOFM5dVpJRnhpSE0vRnZ6cndxRFdmQW82ZmdYRG0xemNV?=
 =?utf-8?B?UUxwTjZHaXZnMlZuSmZVeXE5UlVLVG5ZbHU5RGhQenFmMnc5SllTNXhSREl4?=
 =?utf-8?B?b1Fsc1M0L2dmT1FKYVNxL3lObFYzMUVWeVBHV21IMWpZSmFSakNBTTdkOTNL?=
 =?utf-8?B?em42RFdWdlBndHJ5R0JPOGNHaGp1ekVzei85bjk4SndZaFk2NWtQckdwR1dW?=
 =?utf-8?B?UTJvVGxYRDF1ODZ6V0pzN01IVVZqVEI1QXpMaDlwbjc2ZGZSMk5vWVZXUVZm?=
 =?utf-8?B?V2htSHhHU0RENkJ4RzJKNUZJTTVxNHd3NGJzVUdoQmFSUm51cHBRSW5qU3Vz?=
 =?utf-8?B?dW56c1hTOTQ2Y1d0V3loa204eGZJUHBDeXlXemRLN2NaM1FlMGhUU0daOEM1?=
 =?utf-8?B?Y2lRamlhOWdXbUFOSFNuNFQ1b1FzWU5BM21EazVrSzV6UHF2L00yYWhRK2t4?=
 =?utf-8?B?UUpYYjNhT1ZSUEJLTkNMTDRkYTdTdWw1RW1NQUFwcE90UmJhd3NZeXFVaUFC?=
 =?utf-8?B?WENJdzVXY0l4WUQwbE5qeER2d1pYWkYzL3IybjYyaXZsbVc0bXFZYWo5c2hZ?=
 =?utf-8?B?N2JadUV4SDlGNTZjY0tieWxYZEhadHFxYlBoRy93cjRPbkRBWXJqaFc3M1d3?=
 =?utf-8?B?eUIzMnR0M0RRem54WnpORDdkSGFzaDRyazhkTmU4L2xQemZkNTlvWWJKcTdC?=
 =?utf-8?B?YTJseW5LRDU2b2NNclM1Y0dlQjhJdm1rUHhJNThaU3h1ZW12YjVrWlVOVVpS?=
 =?utf-8?B?d2pBeWxTTUNwNmpuZGJCS050VUZJSEpxdHZrR1J6dTFiVkNnQUtrRlpRTGV0?=
 =?utf-8?B?OGRvVUYxbkRyNThRREFtTnE3NVFoY09Ya2ZiUStkYkMwTVRieEcxNXRSVlpX?=
 =?utf-8?B?UE5lQVFDMFkxVWEzUm5QZ05JSm5nY1hOZ1pJOEJ2aC81VUc2YWNlcjdNVGdo?=
 =?utf-8?B?SlhTRkgvRitnaDNOTklEZVVaVnB3dHZiN0tNT1pYVkFnSjlmTDUrK05nV2o1?=
 =?utf-8?B?dm9DWDRYejV5RDQwRzlmODdCa2tBNFRONzVjaStRVU1vU3J2MmxDSERLL1Zx?=
 =?utf-8?B?a0ZHTXdPU3VaNUpOWWpReWJvK0VJbENVc1FuME9FTWJscHhjUmV3eUJVMXlG?=
 =?utf-8?B?djdIOW8vdFRXWjNHOWtqS0tIVXI2TzVVcG96NlpUS2gzNUNLQ3pnU3BTeXJu?=
 =?utf-8?B?ZkYyamprdHFXSzJZRmQ0N2pZSjJPQnZtQnZ3ZUdJOVJzNldtRTRFNm9NSm0r?=
 =?utf-8?Q?HjBMk8rlkfIXmHo5gjjPuM1bM+fS0/46?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFOcFl2aVI1VXorZE9hVzNnbFBhMmZyZFMvUENodVkvcUFMeFYxcmRHWldr?=
 =?utf-8?B?UytsZTJxVndqSW5BUlZHVWZqY1dOZjJzdmdGNEVaZFduQ1hWVHZWNWc5dUZX?=
 =?utf-8?B?R200VGs3cmdNakQrMkVVYmlEZTlxNUxWTXhMNjZmTkw3dmp2amxzWEJTcDV4?=
 =?utf-8?B?N0FCdzU5VDVkYkFiOFBjSGIrR1ZyeWpaNThMenB2YW9SRWU5NVRaQmJHT0Fs?=
 =?utf-8?B?bzdMZ3V2STNyOFg1elZxWTBQN3BHalAvMnBjcWE5R2xEUFEvSnA0dVRvc0xH?=
 =?utf-8?B?WWorZ0xBMWtxWGRqTGxBNmNyV0lUZUorV1k4eTk1YzBZbDJuQ2hJY296WkJi?=
 =?utf-8?B?bE1NL285NWZnZlBrbUxmNkdMSHZDK2xNa0diTUEzSzQvcEdXdjRyeGw5Mm16?=
 =?utf-8?B?RVkxNjJ1ZTN4V29iUnRtN2JZUjF6bFdVUjVrRHd3dW1Xb2VaWXIybjh4Y1Bt?=
 =?utf-8?B?RUczMGYrQzI4andxeUtUZ0JlaXdNM0YxbHU2aFg2SGZUT3NNRHZ6anVnb3BC?=
 =?utf-8?B?WTIra1phY3o1RnRvTVRnL1BrQlppZGhPbkNhWmRnbVo4bEhMc0g3aUFscFVR?=
 =?utf-8?B?aUFPbFI3cUdLTnRwYlNMM0lkcUVLOTZEWXFiQnNrWElTRWcxQmhBcHFVeWVJ?=
 =?utf-8?B?dnBFRUhzbUY3Um5NMzhSSEg2QVpUaWIyNkFLMDZ4Q0pvS1ZIcllKc3cvOGp3?=
 =?utf-8?B?Q2N4aGt6dGtYSnJYdk9nUUc1eG1mdlYzaEN0K3JYN2p3S2lyTG84Smt5Mjhj?=
 =?utf-8?B?dy9TYWM4U252enFQTnRFbEFkUnBTMFk2L0VIVmxLaFNzSkRGS1NKcmJKMmdw?=
 =?utf-8?B?a1NNUURHWWRpRytwdjlpQmwwb2NnTFZIN2lSTWY2UlJBY09QSFFCRnliK3JD?=
 =?utf-8?B?VXl0YkpXSHJOVDdoTTdpaHZjOHJxSkZkMDlycDB6UFVUNlNpSEVqMktsSDdy?=
 =?utf-8?B?TmtmYzVpNkI1c29LZmc5S0hYZ1FwazZ1YkhUZnBaNmt6TDZ3U05PYjZCSUFW?=
 =?utf-8?B?ajNxYWNNUVZLbUhCVk8vOTRwcU53ajQyNnNCSVhkdWZRbmduVjk5VVFodGxQ?=
 =?utf-8?B?WGhCSFRSUnYwdW0wZS84NmUwMGpBY3labWJsV0FScjBhcGZnU05BajZHS0Nr?=
 =?utf-8?B?MGNMTjJ1TTdPSjl0dDJiMUU3YTZMcXZJVjl0My9kQjdDUjJwRm1sYkQ5ajR6?=
 =?utf-8?B?ZStIcDZUeCsrZVRYNlVJMW9TMnNpZktlTm1UM29iMjlqTFZXd240WlFmQ205?=
 =?utf-8?B?WnZmNEk4bkRWOWF5Sy92WWpIdFB2b2lDQ1lPMkU0VmxZY3llZmtXZGhhc0Zp?=
 =?utf-8?B?Uk9FOThvbGlQUnNtaU9jUlFSd2dmNDRwb0diaEVPUUVkWjcyQTBzQ2dNOThR?=
 =?utf-8?B?bHIxa2ZERTNSY3A3N21PYUo0SkUzamgxdHA3d1BCdVN2eERna0pVVzNtaFAv?=
 =?utf-8?B?M1UyQkk5UFBWMnQ3OXIwL2FQNUVGcDRmaXRQNDg1RmJDNFRsUTdQUVF3bmNZ?=
 =?utf-8?B?RHVnN01TdWlEbzNIM1RlSGZRS2cxUHkxcGJnZFdBL0xSU3F6SjdESkprMjE5?=
 =?utf-8?B?WnF4S2JRS0ZvTEdWY3FZKzJ0NkJBcU5ycEZ2Q25EbU5tMEJWTkxSaTdBTCtJ?=
 =?utf-8?B?Z2xsQzU4ZlByRWdBcERoSTZ5MDNIdFR1T1ZLTjVsUSszc0tLVEl3cVozZDdN?=
 =?utf-8?B?NkxKRm9BN0lzTFF5L0xyQ1hHWVh3enZ6Q3QzeVZzaUZwb0xPLzJlYUZ0VC8r?=
 =?utf-8?B?K1hyTWNjeENwbFFPRFZYdnVuM2JvSnVqU2RkSkZHTXhuc05FMDZrS0g3TEE2?=
 =?utf-8?B?WW1jWTBNVExhU2o5blhpaU9JV09GV2kzZ2MzQTIyejV0bUNOUFVia2psdldM?=
 =?utf-8?B?aElIdGU1R25BYTdYeTVjWnlpWTJ0M2VIZ3NENURUaFdJdjBOMXp6Z3BYNUZW?=
 =?utf-8?B?U09iTkR1dkFHNWVzSVRuQVVYV3Q5eGJ1cWpDVHlnald6WFMrK0VEMTZadnFX?=
 =?utf-8?B?dHFqTXgyZTIzQTY2SDJCUTg1dVpUVnFmYmVlNWdYT1VocWs4dWIwUjZLMEg3?=
 =?utf-8?B?aXhna00rK1pSdmJuYnFHcmZqT09DYnQ1VjFaNmdFcFp6MW1Vb2ZSc0U5MHdt?=
 =?utf-8?Q?sU/TftP3zGhv2Gf/5ZujYumH4?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5ab2a7-07a7-4d31-009b-08de11ddf6bc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:43:36.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zMfKWUxjMuLeCJ7q79yYgyQeQgHWOx50DmSsanyFshNPwquCbRHEtNy9UEItfpeQ8zhDx7yhN0T6vD8tgvqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2879

On Tue, Aug 19, 2025 at 02:13:37PM +0200, Petr Pavlu wrote:
> Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
> __INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6fd0
> ("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE was
> ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
> ("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
> this usage.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/module.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3319a5269d28..e9e6eeb042aa 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -151,16 +151,10 @@ extern void cleanup_module(void);
>  #define __init_or_module
>  #define __initdata_or_module
>  #define __initconst_or_module
> -#define __INIT_OR_MODULE	.text
> -#define __INITDATA_OR_MODULE	.data
> -#define __INITRODATA_OR_MODULE	.section ".rodata","a",%progbits
>  #else
>  #define __init_or_module __init
>  #define __initdata_or_module __initdata
>  #define __initconst_or_module __initconst
> -#define __INIT_OR_MODULE __INIT
> -#define __INITDATA_OR_MODULE __INITDATA
> -#define __INITRODATA_OR_MODULE __INITRODATA
>  #endif /*CONFIG_MODULES*/
>  
>  struct module_kobject *lookup_or_create_module_kobject(const char *name);
> 
> base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
> -- 
> 2.50.1
> 
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
