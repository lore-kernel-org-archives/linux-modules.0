Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021137.outbound.protection.outlook.com [52.101.100.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AC3803C3;
	Wed,  7 Jan 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803495; cv=fail; b=HtqPzWv6M8mGb40Pk4qoTPZNqV3+6Leov3+/f3WgV3YyWbD0t4rKTEqJ77uLBL4PX/qx+VgGeHFPtzTP6suvyypvlzFsWFRl39E5vrlufUEFpwVvwFa2LkqQGfxyu91a3HvATwher/ZW9CBDPXivYx+OXs/wd4FRBxY8i8dke/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803495; c=relaxed/simple;
	bh=swCcSb9KEJ/FcHCdtzONEEi3b7ayxeK+SIPEZCMvWN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9DAUGnIN3pnOTyxdMH6MyyceCLlpogX3trbX0lhOHqVvkIQ3aBN135IXry3S+aIDzTioMPEOh8/VN3ihqoI0p9MO6yYOUdq5ejDXZ40+6PLjTbj8MWdK4a9dK1ydHQ9/rZTwFxdd3Ft6ulXwQvDrdqEffgZh/QgskvbOttEw90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMCwv+lDNTK9uNFzozpkUin+5L5wNuPCncV9FxdPYt4V9is2zyAgyAB/D3S2Q3qYHomb00eAtIAxjya3w340HNYMd/5UFrKZCF422hWMH66X4uweWbDUHUke69YfukqClFa5dhhwIrggmvhHwmDWooCJVxyF0EBp3KtffP7Mij2xS6e9WP6VKNR5JUNgltdFsnb1kIwtkNcyXEzqFNNT25cKaX9eebzX+VtzZEpZwfex+e0wyY4BzJ1sfo+B1B2j+gn0kfmlNkOfuBychK+mg4YaDU78E0yRcf3J8bOdsAhJNgdCJuZV/9fVKCfgNsAPuvJRn8lv8N30IRVmZmiksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcwsw7kLKhD7t4XZI+QX+YLVBsdPRV4kv9t/I5yZmYA=;
 b=ifhVSgBJLW04iMzWhuNjOu4Rc+cs9AKtMHnR1Xv4J+0l0pjl73/l+xC6fQx3FA0prrTZ5njQA9IWvcq/u0Kh8u0TZW+ivFA+MudxFbmBpK0fk/I2RtQ2N30ZLMfHPUkLU/V6IW2xnQYaqsUgYdqwPe6HlTqUOd/J9gElplCgPsBeSoSvEkM9AZ8zfQy4NttwVmVrvvT6L/b97/gNuasLissA3/XJgwKTb0xSpTy36IrIOxnOP96fRfD4pGNDIJwvkiA7gwIk38ZQdnQ5dd+Lr1UigNtoOFFYKrPHY13e9dT59d3STSrtZob12L9l4uYJ7dddpHAUtqq0sXmWHfR8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7803.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 16:31:10 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 16:31:10 +0000
Date: Wed, 7 Jan 2026 11:31:05 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Song Liu <song@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
Message-ID: <vjjlkysj4co5lf2vs2tczxznxugfhtr5ept7sxat6pwjzetvmx@nzcen26ei5nn>
References: <20260107122329.1324707-1-petr.pavlu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwaihcjj5jb2lcrg"
Content-Disposition: inline
In-Reply-To: <20260107122329.1324707-1-petr.pavlu@suse.com>
X-ClientProxiedBy: PH7PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:510:174::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d1fd16-b1ea-4f5e-6bd5-08de4e0a2a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzVIaGZJanRXc3BNTzZqRE96TTRLMmJnbmVLWXR5bDdrZGQrYVhDRnlsa2FC?=
 =?utf-8?B?VzdMMUxLRmZaeHZLZ3pheDA5MU56MWwrV1RPa2t5cU1PdEJWbHZWQjBYaFVU?=
 =?utf-8?B?Vlg5Zm8vM1FQSUdIOXV1YjNUUkI1eFVrRUwycFpYN1U2WjgzMzg0dlJ1RzVX?=
 =?utf-8?B?QjViM2lMeFVsK3VXOXpIYjVKUkJHblZMS2pNU3FER3Ywd2NRR2lBZHJYRmpl?=
 =?utf-8?B?VHRIcWVpQ3RCY2I5aEptUWMwa3ppRWpmOWZ5UXNWQ3pSS2ZWWExsYWNTL3BC?=
 =?utf-8?B?Snkwd25FdTFKc1hUSFBOVTlpL3Y1VTNRaDY3cHhHcWpCdWZkV2xXclM5c2hi?=
 =?utf-8?B?RW5MMzRnemdjUXdmQjdXZGcyTENiR0dwYWpsMEEwcFFMTXRHS3A2dTNRWU9L?=
 =?utf-8?B?MTgrSnd4UEhnaTloM1VER0N4bkJVeWc2VEFUK051ZjZkTDI3disrbzZ2Tk13?=
 =?utf-8?B?QmVSRURoQUl5c281Snd3TzAzNHVJdXZOR2JOeTRhR3pMM1p5UVlvamNNNXdr?=
 =?utf-8?B?bFpreGVaa3E4SXFGVzI0K0I1TWF4amFwMVd2dFkwZi9TVnpzbDdweDBFRDFE?=
 =?utf-8?B?TG1tSTFnVDA3YTdGUVhkVko3QUNCWjVvdmZmN2J3dHp4REROaU83ZmNGUmtD?=
 =?utf-8?B?STY1ZGJ1Z0F4STdZRzNTL053ZXNQTGd5QTRDV2tEeXhxbm91em9pNUN4bE9H?=
 =?utf-8?B?Y3FGOWIwaHVyRGcyYm04RkZWVDJ1OHlaM08zRWNoUm8wS3dhRXFuRm13SzNw?=
 =?utf-8?B?SkpyTW1FRXY3Y3RLL3paa2ZGeEduQWUzYzdtU0w5RWl1dkFabCtEMEVKVUlu?=
 =?utf-8?B?bUZvc1lUUjl4c3libCtFU2JUSHUzQ1BCWjdqWks4ZSt6TVRSU29QdkFlWUVy?=
 =?utf-8?B?N2VGUURMcW9jdlN6aTVxVDlsSlFNL3lBZXUrUnQyazA5eWhnemJjQW00MmZv?=
 =?utf-8?B?NVo2VTgra0cwNXEydVE0ZU5zaUlURkVtejVBOEg1bzRYMm1BeWx2Mi9qVmhz?=
 =?utf-8?B?aC9ydHJaNGdiRTJZaUtQY0VKRW1nYUN2UEZoc0E5aGh0cSt5aW1DOEZiV2M0?=
 =?utf-8?B?bEhGdkhTSmloRkY1Q3FTemxGbEVQQmJmd1ZGUk1GM3VOaVFHbTJZVVE0WnVw?=
 =?utf-8?B?ck5ZOEpxeDR2TmNJWnNKempmQ1Y4NmFMWHJtV29FQ0tNMDhWR0xlUzBlYlov?=
 =?utf-8?B?TC84WnFCWUZYN3dzVzB6WENvSTkrUHdQQ3poQ2VyUWR1SCtkbEFEVTh5em93?=
 =?utf-8?B?WHRSWHIrcFU1eDhwUXdxaGpJbTM2Z0hBU1AzUDV0RU1vMTV3b1VwR2dkZlA5?=
 =?utf-8?B?QWFlVURnZWxUMnBPSG85b0Q5WEl0RFByY1pmWjBrWEh1OEhLcUp5UjZoM0w0?=
 =?utf-8?B?YkF2enFCdENhMmxtb0RlbHdtVHYxVWJ6UmwzNm4xR2lDWVdtQjhTMUU3RVgw?=
 =?utf-8?B?Sm83bTJxdXBBTEdVRWFUeWNZczRPNzljNE5VS2ZMa2dGb0pQb3lJMUV3S3Zv?=
 =?utf-8?B?REsrV2NGREhvSTNPdythRVFkV2c0dWpIbDI0OXJpM3luZVlDZmJuc3QrVmRq?=
 =?utf-8?B?Mm1pY29xaXg1MEVwaGpaVkxBR01JY0pFNFc1TnkzY1pBZXI1c1VSYWJrYXFX?=
 =?utf-8?B?SGJGQy9QVUJaM0tLdU0yK08wb1lZYXphWjhBVW1TTFI0czUvWUhVcXo1ME9D?=
 =?utf-8?B?UHpXYWV0N2VvMkJNb2V6eENNcnhWQzhyWU9nU2tnU1NRNzd1WEZONFUreDNa?=
 =?utf-8?B?YmtLUWpNaGg1VWxFRHhtR2JvVWtRSWQrbHByQVRVL1d4ZjRwYkdTKzdKbWRL?=
 =?utf-8?B?d3VxY1BraUNPUEVzNTdyQkZ3SjRLYXBtS282MkM2QzdmeC9LdHZmbjBnUE51?=
 =?utf-8?B?bTAzM3dUbS9mdkhqZnVJaFpvOE1xVmp6UFZSYk00dmNCWENBc2M1aEwzbGNP?=
 =?utf-8?Q?RYMvAOpFZFkvBBIzKXpob5wKUY/TTCmh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmcyM2ZTNUtrTEl3a2FCazF0WndnQWNFQmJuMFg3U1FPWm82ZFlTM1hkQ2Yx?=
 =?utf-8?B?ZzRndnVpUG50VCsyYWFBc2VvSjYvc2FiTmRuNS9FeGVDWWdDTmd6aWVyOFVO?=
 =?utf-8?B?S0tiMlJOVDc1SVFRUEdWVjlWSnJ0UkZ1YXJzc3ErTHhxRWdRTmgrb3lNd3RJ?=
 =?utf-8?B?QW9WUFNGREVtelhmSDRJcGxqcmxSbzB0aEFPSnJDZ093SWgrNUVweEk3Tit0?=
 =?utf-8?B?bHN4Vjl4dzhwckxRV3hoK3VJZjBRM1QxTEFpaG5EN0lITUVEU0pNdW9zSWgx?=
 =?utf-8?B?UkRBekxwcWd5YXo0OThWRlJaYTdCVWh2anVnZE5oWEVTaGdDYm1adWFWVi9z?=
 =?utf-8?B?eGVPbzN3bkEwUGlBdkdITDJZYnJaSllFYzQwSTZtdWZZaVl3ZmovOGN1SGZa?=
 =?utf-8?B?VStaUnJsb2tyVVVScU1Mc3JrVEFLamxEZmJJTUdtVlZJWDdHMjdZSHBYcFZU?=
 =?utf-8?B?R2RCckdlUllBVTJRUkt6WGZ0Nm5wYTB5ei9MY1hGNHBoVXZDZGY0WHdTOXBQ?=
 =?utf-8?B?MXQrRHNpODAwZHhMMmpVUzE3aDBxTzkycGVOWG55VGY4UnRYbjVkbUh1WE9X?=
 =?utf-8?B?N1kvaS8xUXZtdHNZK3JwZ3JnY2RpdDhleDdMdUU5cS9WUkJnWXJFdzFTbjZO?=
 =?utf-8?B?b3BlT21veDRpZVVDYzJRQy9RckMxazRQejJ0Ui9pL3FmRW14cFBXZTMrMHMw?=
 =?utf-8?B?QlBNNlZSZlFJb1BHVk1ZRm1YN1QxVkZETWFDVDgxTERwSGppcjFKbGk0V3RF?=
 =?utf-8?B?QWhDcmdWbnNvb0JrcTdGcXQ5RzZyaVl2S0wrcER4eENUc0ZqczRnK3V5NFll?=
 =?utf-8?B?ZU9ZQkl4ZFNaRUJLcWR5UUtxNGs0dDZPcW1ibW9oaGFWYUF0SjY0TEJBVHRs?=
 =?utf-8?B?S3lra096dHdWRWRPU3B5WEFneE0xOEZudTRURTd0WGM4ZjFDalIwQjROSjAz?=
 =?utf-8?B?c2Q3Y1g0N3hEMFhVdUdBUi95SUlkdmx4ZllPOVorS05RbEVDMmx4bU5vKzh6?=
 =?utf-8?B?NWo1Q2s1UGVueW9xT0lRTlBlbmVjaGYxQVE0dkVaYWZCZVE2ZU85UWwwTktV?=
 =?utf-8?B?TFdpdFl0SkxiL1FHaWZjRmhab1NFc3hDQ3lITExvWEtCVmZpeFkrWElpb204?=
 =?utf-8?B?VGt1RG1DaGsvMFdpak1oOVFFa3VPa1hoUWJyT0hwQ0NCYWpHTDUxbzVXWFpE?=
 =?utf-8?B?ZFhlVzNFVTFuRmFURzBQbWpUMDQyUDVnclFtc0FseGl6UTJIWTdiNWlXMGp6?=
 =?utf-8?B?V2ttd1JPcHlER2tqTVVsdFZRczA3OHRxUDJSZURPYWIxSDEwdHV0YkhKYWpT?=
 =?utf-8?B?dUFDWm5EeXdQc0dKenRHKzM2YUE3RzVvSE5JSEJ5OFVrdWNRcVRpdDd3VzF3?=
 =?utf-8?B?aEsrOWhkcHVVTm4zVUgrVFIwZnBiOUtlQUl1TVkrNW80Yzh4aXFPbit2SUNl?=
 =?utf-8?B?cFJabzJYeU5ZMjlYb1Mxb1RLRGZJN0RBcENMUDB4MW1XeUdMSW05QVdZRkxD?=
 =?utf-8?B?NTlqSUsxUXdRZ1ErQ3YweHY0T1pjdTVCYkhMRTlGaVRTeGhDaTV6TjBPQ2Zp?=
 =?utf-8?B?emhCcnJPdzh5YVh0NTB6SVVIYTJXdzJPa21UVVdxTVFIOTBEWnJhMzNKU3VT?=
 =?utf-8?B?Y1VQVHh1eEEvNjA5YjFJbUtxVUFlRTRUZURkZjVHWEtDWHI0SHdPL2o1NGpN?=
 =?utf-8?B?THI1U1RhYTFVazBxMFR3UWJPTCt5enA5SjJSSzE3d3NoQkdMSGJVNktwZ2Qx?=
 =?utf-8?B?NUV1N0Q5QkxIOUR1aFhMM1pTMldmcGE2WlRPbGtnc0JpK0ZnZ2Q4TUQ5NEo3?=
 =?utf-8?B?aWp5QW9BTkpzTHg3cmUxSHQwaXVXV2ZqYnNJVWI3Y0tzc1FJbzMxU0xBT1hm?=
 =?utf-8?B?RWQ2YkNjL1Fac2VMdlhDOC9yUlZQci9RMmtmcytmTk1uM0VsMTNBaU54UXNC?=
 =?utf-8?B?Y1g1L0xYOUNxMzRBZ1NrNmE1TmZCRGIzSEpubzlKUHh3ME1abTVXendteHZ0?=
 =?utf-8?B?OU91V1UzTC9yQ0FSRUlPRzgwbTlreXFvN29sbVNoTGtKRERvck5tQUYxSk9s?=
 =?utf-8?B?ZjNWdlRBUWVsOUVYSFJyMENhd1QxVHc1RmlMYmp1d0tUUHpnR0NRVXhnSXYr?=
 =?utf-8?B?blI0SVhOMzQwZElTK3FZZ2RubzRPUGJLM3VVVUd6Tit2ZFA1TU5GemwyWHVv?=
 =?utf-8?B?VHo1dG1FL3YvMGJ1N25JSG1WVC9aOFhVRnJBU080UDRnK01XWWY3Mnk0UFJa?=
 =?utf-8?B?Y2s4YWg4Vnh4S1RpcTFGd2g1YkVnZGdDWkVNcVE2RTU4cWxibEFtallMVUNB?=
 =?utf-8?B?dzJJV3pHWTNuVXhycnF0MUpkK01oeTUrNnFvYVhvUUU5WEFoeFZRQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d1fd16-b1ea-4f5e-6bd5-08de4e0a2a55
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 16:31:10.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93RmN4Ac3TfmffHoB5HxMzOK+LUANNKDLQPpksxsBkqSoeO9uvglzsvT+uskruezSnLPrrWHOZN51hJLqVMYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7803

--rwaihcjj5jb2lcrg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
MIME-Version: 1.0

On Wed, Jan 07, 2026 at 01:22:57PM +0100, Petr Pavlu wrote:
> In the error path of load_module(), under the free_module label, the
> code calls lockdep_free_key_range() to release lock classes associated
> with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
> subsequently invokes module_deallocate().
>=20
> Since commit ac3b43283923 ("module: replace module_layout with
> module_memory"), the module_deallocate() function calls free_mod_mem(),
> which releases the lock classes as well and considers all module
> regions.
>=20
> Attempting to free these classes twice is unnecessary. Remove the
> redundant code in load_module().
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..bcd259505c8b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3544,12 +3544,6 @@ static int load_module(struct load_info *info, con=
st char __user *uargs,
>  	mutex_unlock(&module_mutex);
>   free_module:
>  	mod_stat_bump_invalid(info, flags);
> -	/* Free lock-classes; relies on the preceding sync_rcu() */
> -	for_class_mod_mem_type(type, core_data) {
> -		lockdep_free_key_range(mod->mem[type].base,
> -				       mod->mem[type].size);
> -	}
> -
>  	module_memory_restore_rox(mod);
>  	module_deallocate(mod, info);
>   free_copy:
>=20
> base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
> --=20
> 2.52.0
>=20

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--rwaihcjj5jb2lcrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmleikkACgkQ4t6WWBnM
d9bR9g/+K6bXKbOeZDIHezz7K/AYsJYxScVdl+NiBjZuohZJQtDybDrRlzifT8v4
4UWjjilQMpgUSfwVwCbWYTVLtePUIdaaNwAJO6ItYyY3PQFCYDw/2DhwCrn5zCWd
p8DOULFp7HpF791hTF2skpsmJw5yFe9HgF1jO7qr4+dNcP4BptXOF9JlZcWJDecX
JRhup8SyMAKTTgU7+L9rAMjcbvFk25N84RIbYZ8tzsEZGTkq31U/EGv3qG4WoIeh
aPyZ4JLZawwNAok0reXxWA0prTkNgnLU9HSU6/whDNTXuVatGuRHgxduXuN3yshQ
jf9EMgiEhQ0MjlWkj1ITG6lZ9LzeT6XJxkNjnapA3iZ52n7aqOkbNhWbhQYB8d4s
v3HDRFg1Ngcslmc63vtg4uYcXvUoVkRvb6Sf04rEyQSmXAssBPHYAfT4OvcjclBG
AQc4aYj8vux+dmuaOBQSKODR7X66YEjt7LhQ9XQwI5eSgrsOZ2JMf1ZzgJzw4F+b
HRn1NppWotzm2nW0NYTmOtHUtvdFJcH4LnWzpNOwxDytpKThBuclv3x0Muc4EWyD
S4WoqI6mqfD1gV/s986eqEK1GDGmK6zdV1Hzx6Ul0nefLLAdKkbrtrwyyjxRQiWc
zgpSwQXgKR3JABO/Ot22xAsx2k3LDccCeE2FQEoIRZiR58lZx74=
=zD25
-----END PGP SIGNATURE-----

--rwaihcjj5jb2lcrg--
