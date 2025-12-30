Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021135.outbound.protection.outlook.com [52.101.100.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80F22301
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064277; cv=fail; b=XYXT0TywwnwDyEYXsn1e4NipOz6W4Sc5vQoJS5Vz2nw0cFr0FBakvOEfnq10nGHUnzqvLSWlP0gfGv2JrHeqXN8DP3MLQ/zcPKUpXt9Fhp7RsQmokLbjTXsfoyfaVwDqKOoLR/EkM1MftNEt+3jxzJ/1tKsLrniRKw5+ziZdNJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064277; c=relaxed/simple;
	bh=TtFqP4IF3wokEPs7XaA7bvniq77ceqYoZ3Aj3k8Z6p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp+H7tHOL5nD1HBwK4FZuAbbQy4NmMPvg6fbRD/MdFMp5MJbYdXkH3hVK9gSgZMTn+Kt0Ps84snMWgfIaGeBS1NvXOFbUWuKDi5a6R0c3S4YnQAtvXgzzgKB76SlyxAQa60j7GFQ9+80Wv5fasIzNGSyL+5+51GA3KN92KsOZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwwMSgSy+YiIPk9qBtR+t5kL+LvS7LjKvaBnS6usftxbOOnfK7LulnGjlf6zL5NTYzfvEIq7TTdPU8ZEe9isZ6S94gPDCWZixez8z2FfU/18j2VZLGG47k6WiE1Ts3NpVKR51ZA3P3ci5cYGi9S/3pVYvrqY2ozm9+TyzD7zUU4I45dtY/DzgM448qrKxJqouD7/HcVIZ6hkp2ORFYuqGqeKchOqww4xdyxhP9+dhIBfXtD74Xgkel6u/EL3YgzSW8k7/BAzI4gr/bI5EEGUefl7h98Wcg5yLqvgMOpTBTfVeJWMQncuk8JA7fUYKL6xoJs5btqt9HcVh8O7QIU0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AFw46iY9tWbEOW6pNv30HM8UZ7CH/oz72yPQf3uYaA=;
 b=TJBqu2DoK2Vsh9zSGRrUxitg9Jr2USVBie52MGBMaX3nSG7NftUYcR1w73fPFzEHzcTbPMPKAJ6DDz/SNTY+tIP8pvCTCTw07hQj5H4HE+ymxbbkWUlGgUl1nJ7LlSLJ4yLdV8spbGQUAHyNqKHNCrl70DPHoNk1YmkEk4/RxgP/INWYzF4q+dp7Wa+E+v99hhB4+VEl5l6+tHBM75id4ZW1OtZTAW8XysKa5RhKnu45isFPmAFQmozAEzJAdaJJfjs3PM4rjzL2Xm/lBWkbbVbHxNP7VzM6aqHk61id4/1zwRFqqEvkKD0ptSASOjYAb1WAS6mAKEBKE7hKjAeRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB5857.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:196::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 03:11:11 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 03:11:09 +0000
Date: Mon, 29 Dec 2025 22:11:05 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: show module version directly in print_modules()
Message-ID: <bdp2iitkjdmhl4ycfiu6d4sri3mmsqn2dd26p67heilu33bosv@zmkzcnyayqbt>
References: <20251229024556.25946-1-laoar.shao@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fidc3v3qci2pqkub"
Content-Disposition: inline
In-Reply-To: <20251229024556.25946-1-laoar.shao@gmail.com>
X-ClientProxiedBy: BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eb7fe6-4f3d-494a-a288-08de47511442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3NQZjhyWFMxdDR4M0dncGRQTU8wY3JPVGpieUZnWGxzeVVvQ2RVdXRROVls?=
 =?utf-8?B?NGk4Wi90aklzQldHa0JZZmI4Z2ZmdGo3dUI2aU1Qb3FMZkE1WVhWK24xSGdx?=
 =?utf-8?B?clhoMjk1VTg4LzIwMkg5SEMwaTdxTjNWZ3NHRDRGTnFsZW1SeGp5anhjcUhi?=
 =?utf-8?B?T0llYU56ZURRKzVKaTdsSnBOcDFXUGZaMkdrdjZJQjlldElsbWduemFHWUZi?=
 =?utf-8?B?Vk9pSnFma2E1ek1KUGR2a25vUDNOc1VsdWUrZTl5N0NIKzlEUmd4ZzNyTkV5?=
 =?utf-8?B?SWd0OXpsTHNBTXduQmVZN1M5VEVWa01idlpCTTFJZ0JzY0piVGh1c05yVDAr?=
 =?utf-8?B?U2dmVjRZc2o4QjR0NGIrdjZjbHhjRnNUY1lIaVM4c0pDNXloY2xlSHlCTTla?=
 =?utf-8?B?WEhtdU9QNWdpZU0vS2I4ejhlZHp3cytYOUhFZHA1MjVaTmRrdS9DdFNuN0lB?=
 =?utf-8?B?SjdPNGoyeEZYb1VFbXN4cnBiS0lHMkdLRnlXa2tlaUkwRGRhWjZRQkZDeHlU?=
 =?utf-8?B?U2ZhSWppNno5V0ZPcmY5NHV5WkUza1hBSXIxd0dldVZWaThMZm4wNGhJS3lP?=
 =?utf-8?B?WmRCNGhxakFRM1ZzWUE4WDd2OW5TK0d5Q2RKQkdCcitIYlJwbnQrNG9mb3FH?=
 =?utf-8?B?OHBvYnpXelZKT0d2bm1qNDBBWGI4NW5BWWdxMVdKVU9ZSEtkZkRvZUNqczVD?=
 =?utf-8?B?dGFoM0RRc0dhZDMzY1J0N3IvTWR4OHJyTkplWGszcjhSOVJBbzVVOStOTGNn?=
 =?utf-8?B?NktOUG1EV2dPOStsUTVXNTVvcFpxdUhuYW1TT3ZDcHdiQnlRVjJURFZkaGk1?=
 =?utf-8?B?NnYwd2hUSWlXb244QW9iRmNaTWxVS2VVRHZHKzFsZHA5MEVkTUlmK3BDNThE?=
 =?utf-8?B?cHFsenVvK0ZITUY1YXVaRW1yMXBxUU5ZMC9BVTV0aGNVWlRtMWNTZzJ6L0l6?=
 =?utf-8?B?dWcxZCtpOFNuYzZUQ0xRY3BFc0dEanVLYjlkVytsaVp2N2E4Wk1QRXE3OVJl?=
 =?utf-8?B?NmNjcmxseXJsL0ZQRmFtaEt6QnRxYUFwVTl1U1ZVOXMrNnN1ZW1XNkptRmU3?=
 =?utf-8?B?RytNVGFyRUNKN1BFcnA2YjFBamVnUlFYdFNzS0kyNUJkaEJ1U3BqZ0JqV2pM?=
 =?utf-8?B?R1NQcHhzMFh6TEZGeWFlZENtYldibEpFYlEwTzFhQzBPaktzQTVrQktLTGlq?=
 =?utf-8?B?dDM1RDJaK3ZPOXRIdk1iSWpQT21XVXNGMnVaMk56VU5nTmg3dmFLOE9KU2Y4?=
 =?utf-8?B?MUNKbnh6ZVVNc3R1cnU2a1E2N1FkSFoyVCtmU1lvdzVVdzM4L2hLMkFmbjRo?=
 =?utf-8?B?VkhNTmZCOTNXQ1FWb2JmQzBZMll3eis4QlAzb0NuVmtQQ0JHd2pKRFlUZzNI?=
 =?utf-8?B?TTJLc081TVFXV2RydFZvaXh2Nm1WTUYrb3h0TXdpM295UTZZZjQ0a1pwcTdR?=
 =?utf-8?B?Y0EzRnU0NGhtNjB5NTBiTUZzZmpsVnlxdFZPLzBWRHliT1lCQUQzdDRLaFVy?=
 =?utf-8?B?WHE2RS9SOWJ1djJJdFM5L2pmRjBjUUhWcVJTUW1WUGM1SGI2NkRDMWNCYjlE?=
 =?utf-8?B?b0xVVGp5TW42ZXVqQ09oUjJZYW83NFk5ZTBYNkl5dmxGV3ZXVzFrUzkxZlNM?=
 =?utf-8?B?Qy9XbjdUdWIva2I1QTd6eHhNeVk0L3NSZEpxZVR2czlnUitPbW1sdkxsV0pC?=
 =?utf-8?B?NjhvYUdWNmJkVy90VnZKdzNNZ3E1N3hEcFhkU2xINk8za0FYbnlBd2VXRVFD?=
 =?utf-8?B?SWgzOERjSGVCUy9iWGNRblZkbmpCOEEyQ3hmVTVQRkduWitibWFZU1hCKzlV?=
 =?utf-8?B?RFRGamhtV2xhNmlxV1VQZ1FCOVVDRzk0UFl3TU5rVmMvc1FvTko1bGxOdHdC?=
 =?utf-8?B?dG91QWpWTHJweGdTcDUyVDFUQm9LVnc2T1BpVjFxZ1dGL1Vjakp3VHZpTGd2?=
 =?utf-8?B?Z2s1RjFCT0ZDWG1FK1RJM0xSR1NvcE1JUC9QYVFTT3paV1JzNlVLa2VuY3ZM?=
 =?utf-8?B?K1FaK1RrUk45eitDazVCR2doSmZTL3R4Q1MxVUFOTzdvenZpSWlGNDM2MU5u?=
 =?utf-8?Q?iHbpC5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTZXUDhhTDBOOHkvV2pBZkZmczFkS2x6TFkwNGhqYk5HWnpORENhb2lVRkJD?=
 =?utf-8?B?SitZWnAwZzN3bENWdEU4SXp4SmdKNlllRHNFWi9JMUVaMmFpWkZxTjNjTEw1?=
 =?utf-8?B?cTUrT25LczdmYkhyelZPQkJWajFvQlBBNWpuRWJNN2F3NGxUdmJLQUowOW9a?=
 =?utf-8?B?K2JEY3pjVDJhZ1ZPT1ZJRGdWc012V3FNWjlzTEEvVDNQU2Z0OHlmamJPaHN3?=
 =?utf-8?B?TE1jSUczWjR6SUxRS1NsZ1JpNkFwTDhOdGVWNzN0ZHV3Ym1WYUo2c1BCVzIw?=
 =?utf-8?B?Wnc0RXgvbFNsVGVOdU1QQ2NsWHZkR3F6eC9FUmkwdVJPVkRkYWxFdndna1Fl?=
 =?utf-8?B?RmVwMnlyeThjNjZxSUpzUjBtYjROZ0IrclBGV0ZDSnpyc2RHM3FvNWkwMkow?=
 =?utf-8?B?UXZVQWxHVnNxQjNmQlUvMHdWQzhUWVZyWEZQdEJXNEpvK3hzbmNTaWxBZUtq?=
 =?utf-8?B?U0xiek5uR2QwTzZYSHB6M0FiTWh1WEJJelNVcGVrUkw4dDFXZHpXVjdqMkp6?=
 =?utf-8?B?M3JUWkR1a2p6a2xKZ01EVkRYeitHd1BpZUtvek5tMXAxUldZMytBYlBEeWxx?=
 =?utf-8?B?Y2J0OU9ralgvbHZ0RjBYV2pDYXM4aXNGOU5YQkR4aDNKL0tWT0piWEl6ZHRp?=
 =?utf-8?B?bElNZy9tT0JPYkY3ekxzVHRGL2JRTmkrRDRyR29BOG1zeENZbjJVVkNzbTcy?=
 =?utf-8?B?NWZNSXBiY0xyTHVEM1dmMjhycFhlVnZXdlpHeWFSQUM5SnVEeG53S3N5Y3I3?=
 =?utf-8?B?OE9oQ1pNdEd3cVFBRnBSbWM5Um5DUGUvMlA5eDRDNHd0NThWb3R6dzR6Wjll?=
 =?utf-8?B?M2RsN3l4MUkxMi92eW92WDZvUHplTEVoa1pRdGNVL1FHVTZWUnNFTmdKeVE1?=
 =?utf-8?B?YlNJVnBGeUl5UVF0MWVDdVRCL2NtcWEzbTFLdzZCTmpCK0d6T3ZsQm04djA0?=
 =?utf-8?B?cGsxQUpoYlF5N0lya2pFK2Y1eGJlc3JidEdEVHZNa3I1RG5QdXpIN2tnYU9w?=
 =?utf-8?B?SWlqU2phNFdLakNRWTBmdkpiTTg4d3NzUmp6SmdjWjUrVndqc2FkRUh2eGVL?=
 =?utf-8?B?QU5VdU8xaFNKZWFDVDg1OG1nU0ViK3ovdTREeEdwdm8reC95ZlQwN3cvZkxr?=
 =?utf-8?B?N0FwUGhoUVJja1prNStsMFM3RGJDM0NzSnFoZjJkeGwrZEtWaE8yU3RyUmgv?=
 =?utf-8?B?Uk5VWXk0OUF4aUtCVVZaUGdYejFOaEdlcU9qckdmMC8yK3JlZVZUam9kLzFS?=
 =?utf-8?B?akZwSjA2d2EwVEVwRjFBV2tYNEFLTWFxNHNqOUtkR0YwV3djQlQ0UHBGVWxk?=
 =?utf-8?B?R2liK1NId21vWFl0SjRIKzhlT1BTTnhnWm1jSVJnV29BallESjBURy9RTEpB?=
 =?utf-8?B?d3htU1RzSjVjZXJWSERVeDcvUVVFaVBIbVl6cTREaGlhcWkxQjFMS0lQZ1RM?=
 =?utf-8?B?S1hWTmpkNjlrRmJVK1lKNnhQbnI1c0s3TUExUTltZThBWU1VYWhnTkEvd0tN?=
 =?utf-8?B?K0tGWlVJclB0TnZkT1l6eFBVV05VN3RQRGVPQW91Q1NoODhRekJDQXVuWXNj?=
 =?utf-8?B?UUJXeTdCWnNnNVRMYWNoK3FWTyt2aEVoNzVjcVdYb2xHNzBqM3U4UVNwb2k2?=
 =?utf-8?B?UlA1bldPNGQvbWxVNTdRaWlFNkhpaENRcUFVZndIOUd4RFZHdStkeGhCMUY2?=
 =?utf-8?B?cWJLM0FJVHRJZENVRWU0TE9INjY1bmhTRGVETndJeXdRTUdjeVpwSVNLR25q?=
 =?utf-8?B?WEJjMHJlcWllMHMzbjJxNVR5VDkySEV0ZG92cEF3NCtRdWoyQ2hXWHp0WldC?=
 =?utf-8?B?ZlQ1VncvUnRWYityNFMrTEZ6cTI1SW5NOVk5bHJlb1ZsS2xqRWFWTytuUnlS?=
 =?utf-8?B?aW4wSXl6dS9Zdk5Ba214R2RpVlBkK3phcEZxSG5ic01aWGw3dGxmTUZrK0Nh?=
 =?utf-8?B?NFIvcXhnVHU2SklCRUZ3b3pacWE5N1NIeXRrQ1pJc0pvMmxPOXVrMG9XbU9n?=
 =?utf-8?B?Z0lCYWlhRkZoZDd0Wnl4WmFmRTlobjcvQmZMc1hSa3FPS2tjOE01a29pdXdW?=
 =?utf-8?B?aHlhWHA0UDB6VHVQWGJTSXN1S1VsTXR0RUJDS2V6WnpVbjFGTGYrcTRDeVFy?=
 =?utf-8?B?S3hGLzBQaGhYOCtPbnhPcXVCcHJpbmhYRkk2ZllCRXJkL1p1NmdwZWJwc0F1?=
 =?utf-8?B?MVNkZG5Yc1Jtdm1JUjUraXNpdDJKVmwyTEhjUDVoZjFIWWUrMXQ4MFJjcXJN?=
 =?utf-8?B?em9ZL3l0bE02OXlXT1J3dG94WitNbXN6UXdmOVBVYkEzVHpnb0JmRCtNNmQv?=
 =?utf-8?B?WlNzbU1ody9NaFQyRkFlTWY2T1NocFYxelE4TFBzUWJxSnhWTkpoZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb7fe6-4f3d-494a-a288-08de47511442
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 03:11:09.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhVRSZueiHiWknApNhLRzfKZyBY+BIBPMwO3HmSaImYz7vgMJ1cnoRnB+JFuXIJ0oV4eD9pF6oXrU8Qj3ezivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5857

--fidc3v3qci2pqkub
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] module: show module version directly in print_modules()
MIME-Version: 1.0

On Mon, Dec 29, 2025 at 10:45:56AM +0800, Yafang Shao wrote:
> We maintain a vmcore analysis script on each server that automatically
> parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
> us save considerable effort by avoiding analysis of known bugs.
>=20
> For vmcores triggered by a driver bug, the system calls print_modules() to
> list the loaded modules. However, print_modules() does not output module
> version information. Across a large fleet of servers, there are often many
> different module versions running simultaneously, and we need to know whi=
ch
> driver version caused a given vmcore.
>=20
> Currently, the only reliable way to obtain the module version associated
> with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself=E2=80=
=94an
> operation that is resource-intensive. Therefore, we propose printing the
> driver version directly in the log, which is far more efficient.
>=20
> - Before this patch
>=20
>   Modules linked in: xfs nvidia-535.274.02(PO) nvme_core-1.0 mlx_compat(O)
>   Unloaded tainted modules: nvidia_peermem(PO):1
>=20
> - After this patch
>=20
>   Modules linked in: xfs nvidia(PO) nvme_core mlx_compat(O)
>   Unloaded tainted modules: nvidia_peermem(PO):1
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/module/main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..1ad9afec8730 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3901,7 +3901,10 @@ void print_modules(void)
>  	list_for_each_entry_rcu(mod, &modules, list) {
>  		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>  			continue;
> -		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
> +		pr_cont(" %s", mod->name);
> +		if (mod->version)
> +			pr_cont("-%s", mod->version);
> +		pr_cont("%s", module_flags(mod, buf, true));
>  	}
> =20
>  	print_unloaded_tainted_modules();
> --=20
> 2.43.5
>=20

Hi Yafang,

While I certainly appreciate the operational burden of managing a
large-scale fleet and the desire to automate crash triage, I am somewhat
hesitant to support this change in its current form.

Perhaps the more appropriate approach would be to extend the existing
module information infrastructure to include the version only when it is
explicitly requested: introduce print_module_versions().

In my view, while the requirement for better version visibility is valid,
we must ensure that the change does not compromise the readability of the
crash report for the rest of the community.

Nacked-by: Aaron Tomlin <atomlin@atomlin.com>


Kind regards,
--=20
Aaron Tomlin

--fidc3v3qci2pqkub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlTQsMACgkQ4t6WWBnM
d9YFyxAApBXBJC23PdU+PqrJT32pj69sN9pTbvvJQs+yqVadPVaOWiOLdtZ1Ln/O
/k5FUJh3GuN0eE/iPqitBQSZRFVHHYnXNW4QV1dMC1ALZ3nzpG6Ih5yTvzbn5f29
DzCtRfEHizucVV0tN55BGPSb9YrktgiI3SDJdgWnVl29YjSI2uvqtBCfTgTdRt4W
o5+a1dxgrOMux5vskgcQ3ThlgO5A8GAAmEQwZOQG2uWZOHvGTA+N7AyzcdEFzN0j
rxgGlDw6pL0jApZQ+1MBZ8WIoXkdHMg8sWVa4k2kSfY0FYT5PL1m10A17xCb+49B
+XnqcshdeM+IFFqHcKH1RaHYtAEVPWU5JDoARe2QhuOog9ZhikheJsWXNjLHsP3c
B7HR5W+P8C/LQj7dz3n3CC24veQcXXQr5vxI1/al/+AxZ8vMKl4sfkGq+OGSJNve
Z24CXJKSvFu9pTltprePidacJbjs0YVX7z4f3iURJLfMYtjApvxGdv1NoSXZjZNM
dF3t6bLIH7veD2f8HK8WEP3Uvm0LX/2bey9tP+Uuz1OcaTLSEFXSySGPbwv9MAk7
B66IAdCTSx73OqQypsoS9sFk8DOVOrmx6eSy2N3qHcxKyYBxwt8cL5XFV25Wa1UN
pDNbpyrEYVzL9fpWbKZNqj2/ZOpjYqmxklSPQWA6JyT4ACZwPS0=
=jYQ0
-----END PGP SIGNATURE-----

--fidc3v3qci2pqkub--
