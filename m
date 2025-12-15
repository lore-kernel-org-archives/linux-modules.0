Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020095.outbound.protection.outlook.com [52.101.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC942D9EE8;
	Mon, 15 Dec 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765836037; cv=fail; b=IoIWRjDpM+mmmpGZg6J/CiecPAdGLO0BRWe3FvSg31smn91mV292aGbOwRm7MFNMgK0SfTaRabYbwK5w9PtgrknOzQbeZHKGBjTGEnir2rS5jNruHBuPi+DJW8KjqC3BCaYhpeseYXzI9ceqPEQMtuJAjrQJcWzTdBCWyjqqLlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765836037; c=relaxed/simple;
	bh=ptXnZyJh6Y0CqsaH68M0lqeS8FIu1k8kdtsE2S/WojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDTpoff9ZLWfpuTBqqmZBnSyUz2WMFTws614B2YITIrhyS6jnuUaou17U0xDhFp4uzCHcKJjyQaJLpoWfJcPnfvkJlALgAOMKOsWxTHGyrh1sZYgd+khvD/4b+/svPCL7Cpog6AQlL12cbdZAHN/XP4Sfn9awEEor8HkyVVUzHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9cWDBeQVz6ycQ0ZjeJ2ue38PGCW4Ejs7audXrt140S4/20EsXuY/dyp0T7RpEC87Q+6OkNZ4gvmINYYN3OOG4DRTaBwxtCJvsOxqmlVrG/BvbaXKJ+lZjzIsyXPyCavxODu7EOmtoGcSy8Teg0kIgiEa9j/J+PCxrkqa1ZxY/gIc4ZVz6JmuWyBXdso1f3SmCY/BrK3O/fJF1qdDON3Zo1wV/eec3iw5X3MTKvhun2zAOyRhNhhPwv5fW495Bjvyu8ZIWdlXNmCGEmpNn0/VhaQJ9Vv4s/xTW3sF1cE3KYYLnk7GY+6lM//TG6fykzqQVx31G1R/Q5IjKnTlKiESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfv8yJD4M+R2IcWFOuie0F3qcHcbmA005BRjt4XPryI=;
 b=bjeWTuAn/Ti8Jxy7cUTU817ofAziNcbYaI8BiB58bRowZDNWpA8gf3eEnwum2aUZrmYFKsvuwDAojSp1JgpxMaLjaLNRscglSj6Q7OR5es5vCccCLslzUHQcyp0sVL4BWfl0cYdkgSp60ihrqxxYUCfa6Zbl40342p0qIcLIFZ2LeOZim4k66BHwDVFPgi1WRjHtvCeNQQqZaa6qYMSkK5QLSxXclgyi3/icdXIW4fZf3ilnK7PQPkw0PyWK07rd2kSoKNGdg64NbPOtWgkZghqIO8/Oqhn6LRYFuylba2e4OefpmMpfdorr+oCUOOo+rqflHdfB4AqnBA2WZyRycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB5891.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 22:00:32 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 22:00:29 +0000
Date: Mon, 15 Dec 2025 17:00:25 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update module subsystem maintainers and
 repository
Message-ID: <m3c6aqpgpfonledtpvoyyz63462owqukrvvqfwutgj4vofvrxs@3t4wc7ld7afk>
References: <20251215215545.1332626-2-samitolvanen@google.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w24gqkhc4umc6itv"
Content-Disposition: inline
In-Reply-To: <20251215215545.1332626-2-samitolvanen@google.com>
X-ClientProxiedBy: BN9PR03CA0574.namprd03.prod.outlook.com
 (2603:10b6:408:10d::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 803fa3e4-3137-43fb-811c-08de3c255c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUt2RERoWDdYaFdCUDZ0MUpuaFF1ckQyZWdKTUwzc01lYzkrNWtha0NrVTdq?=
 =?utf-8?B?TnRUN243T05FWDRjT0RSU0tWN2RhK3c0YTdjZkUxd2c4cDlWanB0R1JudS82?=
 =?utf-8?B?VG5QS04zWDdmRHZhVk5HRzg3MDhSY2VhMUpEQXg0dE1QQm1jT1A3WUg1V2RP?=
 =?utf-8?B?c1lrN2ZocFIzNU5DMi93RUlhSHRoV2hNSnRMVW1UZEVzY0wrQ0xMV0tsNWh5?=
 =?utf-8?B?OUlYOHNPNXVhcy9CNDhOYUVUbjVuVTRLa1hrRFJUWUxGZEJ0UDZOakRacVZB?=
 =?utf-8?B?b1p0K0VpQ0lvZml6THBiQjJROUJWTnNJVU5hQ0NrbnNCY2lpb3h2TTFsT0Ez?=
 =?utf-8?B?Wk5GMi9XOEs5NysrTGxNU2kzNXMwVTFldGxqdVRXcnMzcFUreXBCbFF6Umo0?=
 =?utf-8?B?dHdzRVJNbnhBazRPcTVmNW9BR0xLY3FlNmhWdzA5QUxSdlZiSldLWEVBRmFV?=
 =?utf-8?B?VkM2OEZJU2lvQmhIUUlyUmtVQk10YnpPeTAzRzRnN1V1RW9uSllnUkJmaHNy?=
 =?utf-8?B?WFMraDlESXl3RVZlcjlOajJOUVEyT2lHK0tWNTA5K3ZaeG56MVUxeUxkaHBV?=
 =?utf-8?B?a2w1L1FzV3hIL1Z6Sy9TcERRaHZPV3dBZ0plVHQyTTBKM3d5NjM5ckJMSFdJ?=
 =?utf-8?B?RUdvQ3dEZWhrVytxd0hZa2pGTzZYQVRKTUhpcWtKS3JYSk1EdTMzdFZ3b0pO?=
 =?utf-8?B?M2llQTV2TDlEQ3RUYnE1Q01sNHVqMDU5blprblIxcXJRWWIvSmNYdStkVDRK?=
 =?utf-8?B?ZytRQ2NINUJHemhiRzRjejd1cUZzclE2TTJmODBMV2JCeE5DSFV0YVB1YXBx?=
 =?utf-8?B?ekJla0dVWm5RQ3A2UXFXQUlOMUJqV1BoM3gyUWJSMmhmT0JyRk9YT3BIK1Ry?=
 =?utf-8?B?WEs2ZzdoenM4bWo2MTNmMFJRTlVKSlp5ZFdwVmxCc2tSdFFNWGVYenQ4ZS9B?=
 =?utf-8?B?a3lvNVc2a0xYNWlhYkJEMHZQZVhIWlpDd3k5MkJabWo4YW1vZ2RLeGdkSFp1?=
 =?utf-8?B?K00rdEw1NGVtZGgzQ25INGh0dS8vZVpmNnFqbUsxUUU2U0xwQy9kQUNxUHBN?=
 =?utf-8?B?NVZXcHNjZUttdTRWQTNUWHlqM09MN2NiR0hqR1JaY04wTmsrdFIzQjl0MGIv?=
 =?utf-8?B?dkZxc3lWbmRIbDZscXdzMWxjYkFpcHp3ZFc3T2NSUkN3c1hLT2dKMkZxbkdn?=
 =?utf-8?B?UGI5Y240eVRjdmpud0R4eUFVY1lNcVpnZllXSWpuUEkzR0QwSFUzNmpFTWVC?=
 =?utf-8?B?clJPcjdlekNrTTV1R0dydFJMWTZQQWdBRGZPTzZSektNYnZLbll0c29NSTlo?=
 =?utf-8?B?bitSdWJUU21DZjBHb3o3U095SGdTS3gyZXo0UUNLZzRpWGlWTVdkSzJKQmUz?=
 =?utf-8?B?UERxdmM5aURrb3RMMDROcC93OXJ3S3pRSUw4TDJGVHFVTWNFN05QNmhUK2gr?=
 =?utf-8?B?cHJVRndmeGtVMXpaZWVndEVFbnErT2x5UU00UWFNRmh3RXJEQ3VVWEVJaU9G?=
 =?utf-8?B?WWVoN1BxTXU4T2hnWVJzSEhPWkIxbkxLYlI3eDdLcjBIUURLRG9lNDEvNW92?=
 =?utf-8?B?cjUrYzEvWVNaTkcwU28yekxaY3ZUVkJ4ZlYzTEFKai8vUDhsMGJ5MXJWdFJ3?=
 =?utf-8?B?TElmNXpWRlFJb2hsS05BeTVoYmdGYzRzbEFYblpVM0VBRldPVTE4ZEFyYWdX?=
 =?utf-8?B?QnA0aFFWcTcvbk1qNyt1VmtZOXNtT2tlK2t5ZnNqU2ZUaEFYa0lXNFpLcEdm?=
 =?utf-8?B?S25ZYXRna0lkbXZYcjJ0dHBCamdzVUNWbGdvRHkrb1pCU3dFZkRvZEJKQjVW?=
 =?utf-8?B?cjZ3UTl1eWJHem5McW5EZ1hHNWtKV3BEMUN6ekxHSThneTZDRGViYlJuSlN5?=
 =?utf-8?B?VXNrd3RvMlVScVZiMDN2eGRPRXhHVS9pNUdRRmViMFd2eG5VRGFwSWpGMU5M?=
 =?utf-8?B?am5Kb1VOMWVjVHhuYlJMazhPd0pjeDExOGQ3R25GYmg0RTFISkwwMjFnNmxX?=
 =?utf-8?B?K2prWUxOaFFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhLM1BIQ0JSdzB5Y2lxNGdRQ25JL2dsTSs0c01xdzdJRXk1VGx4K1V3Z0do?=
 =?utf-8?B?TzRFZ2Y3Ni9LL1ZycFVaT1MrdnJKNFJteXBNYU9KVDI2cjNhc2tBQlJBbzlz?=
 =?utf-8?B?U2V2K1lWUDgzMnhzcmVkUXArci9KaDNqM2RITTBLendSZXhmSUQ5QVUyUXBo?=
 =?utf-8?B?SjFWQUpwTG9Fb3FCVzlSWFVkOW1CUXpqQ3BhTTZPeTNNWkVSc1krSGdVaElq?=
 =?utf-8?B?R0tPbGl1bGdSaSswNkxQSDEvdldxZUpkZlJMNWN6NTRtV3pnRFgzbDUrb09X?=
 =?utf-8?B?ZmJhQllhblp6S2tSS3YyUzY3bnY1V0lEeitEV2tFQU9lYXRka3p5eXU4cm54?=
 =?utf-8?B?TzlLNnpEV0NtdGpMQmF2eVlScHlGbTM2Q2dZazlRcEtMbzdtbnhSbUNSUHhh?=
 =?utf-8?B?MEhSaC9uamV4Z0gzTnZWVVVpOFhVNklMdmg4K0ZNZ1d0WHdBS3pieUd6S05D?=
 =?utf-8?B?VDlVQmp6KzJMWDExbEZrb3dPZFU2NER4T2ZxaklISWplWEpKdnZwVWRMZ1Az?=
 =?utf-8?B?SVRnU1ZxL3RNeDdrcGo4ZGlEWHVmUmsrdkF1MDBwZXZ6dkdPMXM2enI3SlJV?=
 =?utf-8?B?blRFclFBTDFpZ2dYZ2VpVjZMVTB3c2orakxvNG03QllTYnpqMnZtdFludDZu?=
 =?utf-8?B?akFxNVdSUjdZWkVOV0dPUUV3K3AzVzFTUkxCQm1RNTgvK0d1clFxMFVJeEw3?=
 =?utf-8?B?Sk9KRlI0Yk0rWEFQZEFMVU1UY1ZWMWdCT1YveUdHdUlyMzFDUW1iTTRrK1Rm?=
 =?utf-8?B?Y3I4b3VGcmFNek5WYWhoNDh2YUx0VnVWcVJHY0x1YkVHTkpMN21IOXY3RHIy?=
 =?utf-8?B?eUhDT1RsTU9IbW82RUZ3djNXWmFJMTMxVlNMb2l6Ym1kUTJNWmdDc2RGOU9p?=
 =?utf-8?B?V2hhRU9TZEtzKzhSazdJZmxZY3lpYk5EdWNZTGdsczhCZjArUmhINXJLVzQr?=
 =?utf-8?B?U3R3NTBZYnAyZ1Nwa2FYVnprSXpvVGovMXVxSTNxVXpqem5Ha0svREVzUzFu?=
 =?utf-8?B?T3dvSnR4a1dLTEc5a2xQRmRRMEl6VFVEbXh4Zkl2YVdlbXEzdHlUSElqUzBs?=
 =?utf-8?B?VHVuaWxGaGxKanFiUzRSci9Rck9sQUVidXp0ZFhxUmRZdmtrMi8vQ2FaaXlS?=
 =?utf-8?B?MnVaUllxa0hKcTlBbFlLUVRPajBiL3ZtcTBpanNjM2dVZFdpSVlWa0UyNndX?=
 =?utf-8?B?NjhSQmxyY0NTRThjQVpyeU1KcE04aW5IMTVmTXRHT1oyL3lBMTdJV2NjWUJB?=
 =?utf-8?B?ZTdNVWlLYnFzb3VwY2pCMDhxQmVlNlIvMCtSK2NJNWVibU0zR0dvSk54aHlD?=
 =?utf-8?B?ZGlzekMwV3dqT0VMQkdCOVZ3ZE8yeGhVbXRFRk45Y3haaG9Ld1dJQkhYRFpN?=
 =?utf-8?B?NEIraTQwb0Njb3JpUjBIZzBHZlJiSHFRRHdvU3k2MUR3T1dBMC95dkNXNm53?=
 =?utf-8?B?Zzk5MEFvVERZWjh1SFFqdnVtVjl0MlZqL0t1QitIRk9BK0JlUWtRM3FFcC94?=
 =?utf-8?B?V0xsd2JxVlpCdlFtMFRCOEtSZDlmRzJ4a05PYk5DMWtnckNITG1JeVlXL3RM?=
 =?utf-8?B?dHpoYmszZmR5NU8wNnFubjJ3WHVsaUlsL1gzRTVTQVNTMnRPU2toY04raTE0?=
 =?utf-8?B?UmZGd04zZG1sM3JiaHRlYUxhaElsVTc3Zks4OWttVFZoanhMbU9ERE16S1Fi?=
 =?utf-8?B?L3BoS2RsZlRFVXRoVTZMeDFkYmxDTzlnWGRIcitsS0YrN1g3UDRmR09IWXhz?=
 =?utf-8?B?TDJyVnVXandTWjBJNytGRENzQ2Z2emFaV2t4UkFDK3dKUGtoTXo5UGFKcm82?=
 =?utf-8?B?WisxZG9GVGV4NHlhT0NCNDNxMUkwd1dMMWdnUXc3aDlHclV1U1dBcVZjQVV1?=
 =?utf-8?B?ei85QytaTGwzNnp0YVpmK0k0OXpCcWM1ZERtUmxXVzk2clZleHhrZVBVcUN6?=
 =?utf-8?B?Z2EzbTl5VEZSSklCbWg1MVp6ZnpISVpaNkhSeEtNOTZCREYzd0JlWUhTT3Iz?=
 =?utf-8?B?SmhUeTZKcEhxM2h0SFBtR1c0d3Rsa1QwQXVrUEVyWm13R2t2Znh2bjMxQ2Nm?=
 =?utf-8?B?MEorY3pLQjQ3YjNQSlhpZ1h0aEJKaVRRTnhpR0gySUs4T2lqUUwrM1h5NmM0?=
 =?utf-8?Q?/S9QhyyRN6giAViS1DTHzZ5Ig?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803fa3e4-3137-43fb-811c-08de3c255c5a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 22:00:29.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBT90iO1zB5sATRtlkxIPwtLk0Cdob9YHwkxq96axmd9VIsJ0F3FW66/q6bKWhfJYeMa7tMFCHRK77YvkfVEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5891

--w24gqkhc4umc6itv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Update module subsystem maintainers and
 repository
MIME-Version: 1.0

On Mon, Dec 15, 2025 at 09:55:46PM +0000, Sami Tolvanen wrote:
> Add myself as a maintainer for module support as I'll be handling pull
> requests for the next six months according to the previously announced
> rotation [1][2].  Also, update the git repository link to point to the
> modules tree, which is already used by linux-next.
>=20
> Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.inf=
radead.org [1]
> Link: https://lore.kernel.org/linux-modules/20251203234840.3720-1-da.gome=
z@kernel.org/ [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..0c18b87925f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17613,12 +17613,12 @@ MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Petr Pavlu <petr.pavlu@suse.com>
>  M:	Daniel Gomez <da.gomez@kernel.org>
> -R:	Sami Tolvanen <samitolvanen@google.com>
> +M:	Sami Tolvanen <samitolvanen@google.com>
>  R:	Aaron Tomlin <atomlin@atomlin.com>
>  L:	linux-modules@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git mo=
dules-next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git m=
odules-next
>  F:	include/linux/kmod.h
>  F:	include/linux/module*.h
>  F:	kernel/module/
>=20
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --=20
> 2.52.0.305.g3fc767764a-goog
>=20

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--w24gqkhc4umc6itv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlAhPkACgkQ4t6WWBnM
d9YhuQ//XRyL9Ap6A2Mu/q+H/+8XFHxR19lMFpllcJ6rmW4HzbHeC6EAOz0yJXi3
9GyWZ6nxODUvzSKKoMMXEUsQy5ls0TV4WO6zbEx7buRAbk7aQWZMGYl2RrCkr/jr
ypuzam9vD5YF2o8xf4w8oAH4OocW2xcGC2Wwj6ShZ6TVTZef2c2mgj6Gsts7k0b0
50iU1g2LjJzT7/i4NeiF16/b4NUyi/xpzxESbY0UkgPq3hDQeVnqG0azdaOikSgX
l89FmeRPzh6yAFgJCOPivdhhcCN4gfhnttPTzQUxT8hz82+hI5yeCuyk6QGEDdcD
Z5TFrh+dxLSv9bxdCZUTBIq2PRkAC9T9YD8pzYLJbSrpV7l6pHzdQfuP6NJ+vYT9
MGfmhLYFCtfAPI4koBCHOwuXYkJL0iRzFEn2OjkeO+8ENsn9qbYRfdO2ZpHOP+9G
PKkbubdQ+i4eTS9fGZxudvxRx0cGTBXP1dApJnIhPs8vdO18WwtzUlYR27bUDP3l
mBfM/TD18YoFzjPez6cukFULCqp606niBVh9AIncVjVjqYhqEv8hdBwseB1RK7UX
JSgsYG+tco2usjWiwJ9TUGd0FM205HRFBpxMCymThc+cRB4FUwLYlWRMjJfjKdmF
5jgEczvkV3D2IqgAe8OQBTydeNHnPtufpUmSaMZNLfRbbOC3Cdw=
=j4mG
-----END PGP SIGNATURE-----

--w24gqkhc4umc6itv--
