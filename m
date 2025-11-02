Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C313B2A0;
	Sun,  2 Nov 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107804; cv=fail; b=qTvD7oHuQq27svlHOjsAMNUvMpIa2BEK1sBKUDvo6nZAc2zWOxJWqx/u/wG+Y7sfQ7ohTFqrAonE3P2RvehafMVUHIHmeFn10f5/PiU01NT0tqikcnpcA8MbfjKNH6QdoeRlH/xB3pdS/Qi3D9wILlG+LPnRQqyeIAFm+/ymlrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107804; c=relaxed/simple;
	bh=SLshKaQ9XaJw2RE/D9RjtElUQU8VNrONsoM3p2mxKCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHuTIRnwHQuPaxZiA/wsCwDK5n5NQ3RUF01gqOPGWjbWbVqZXD+2WUrszQJ18huy5RqF1O9rGKxtpFdFtMF8hbmeFzKuIHc0MvscChRqV9BDzrLxQvc6B0Qh1W2emKwBJS/OqYzVDLWH49+wUlH5dhE02n/yy8F5j5fTq0nvvRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAumqTuMinQvh7K+ImJFN+m6ijumqJuSfCwYespKRpyyVdq+vyXcvSrXw2dgE5RR/Nq0phxMs6YL6lqf8zolBe5Lrl7+LFAbCTkNc0+5DQ0P1LRy1dmkjxq+l8XqybYLEtdsMcPqXWEH1wWKvJ36k3BuUH/+K2WFt/4IxO88h9FwopS5KtR2HAeUDzV7u0CXK3F67vVB7ZcTm8lBrmcwBEET1FZ3E6Ly3VdUtzQDpiSOWVi8mvpR3cIzoboVtU96bMnBKRs6KMko19aGYwGxkTSEU0UveiRMRMj1cwiaYCK05viViL+8iMA7sTreiWVW6VZ8JyY92qnpCuatVVtEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVluQ+oBLxKEO67OrYfnFGiyyqhN+f3YqJdNbEHILZk=;
 b=ZQ+0iIDWpVnOl8KKguaNrgDD7wQCGLbjyZyqF6oV+rTADzXzSrXBwwecnSIoVBVwUwfTjAkJc4ve7e/prZwwo3M2gKSX7076dqaXJWptqFWHHziVcWmbyxs+N/32aZM3q2EhuAHX/i1Q1OA2WEfaX6IIXrfWYn+3TcqsScJALUveV58eQLcp1gZVBoQiMuVWPmtUtXuR4pvgsRQQsneRPzYqegfNxsg2yNnSqMcQCGGKrbwt3JIIm6VbWbiFouABSvTySAwTB4HJU2NOHOdasa4Lvx3FKH2Y7/90mdAhBy4mR8dNDWjeDU/IbrlTpgQFrV24V7/Qom/Ptc1DIXnCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8286.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 18:23:18 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 18:23:16 +0000
Date: Sun, 2 Nov 2025 13:23:13 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH 2/2] module: Simplify warning on positive returns from
 module_init()
Message-ID: <tgktmvprrmokcfdjww3xttwnvilqvue3tqpae2w556uggltr6q@e5u7e2w4ztbz>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
X-ClientProxiedBy: BN0PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:408:141::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c530535-3260-4d0a-a8ca-08de1a3ce460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWtuR2lvZWVOREFYblZDZnJNbE1sQnlkcExrOHpGZmhmOWdCWWw4SzZkaG9T?=
 =?utf-8?B?dWVma3ByRWYrZDhWT01mblR1ZGxvUW5DY205MllEUFBVWnIvOUswVHU5bHFm?=
 =?utf-8?B?M3pFWFJhNUJ4cGFBd1FZYW9oaWNwaDQ0VnFvUlVjcU5NWnFNR2RJM0pQeU9G?=
 =?utf-8?B?Y01weHdFMzAyWS9NRWVBdTROOCsyL1FOUHFoOGF2S2xVRmI3VWYvRXNvS0Z4?=
 =?utf-8?B?Zkp3Y1E1Wk96cVFPbkpCZE9hRG9jZDlMQmdDUS9MOWM3NDRxejJyVUVCU1Na?=
 =?utf-8?B?OE1FUXdJY2lrVDhGQlJsT1BWTjFuMzRWR09Vdm4wSkVVWGRwYU5VUCt3MjFJ?=
 =?utf-8?B?Ti8wS1lZd0FMVlpHMGo0WG1La2FRMGVwcGI4S2tGd1NGc1hkSVNjVm9qR3kx?=
 =?utf-8?B?RCtCd2xMNlgzYS81TnVqT0xmTlRkZTZSV01DUU1RekUwdDZHZmNjMDM2VlB3?=
 =?utf-8?B?amxtYjB1UmRINmNaSlJjRFVqK3FxT3E4SENPTE5yMmdwKzFRZ1A3WDQxNHVM?=
 =?utf-8?B?SlhTTUkvMkxlcDQ1Y3B0RDlqcFZzM1dEcS9lSmpDd3FWbWFWTytJMUhDME1l?=
 =?utf-8?B?WG5oYy9DcWxGRXlMUyt2RXRzYWlONWxuYXR0S1pXU1ZTbEltRWJYeEQ3RVQy?=
 =?utf-8?B?ellRZ1dQa056SnBiZ0N2eWRvWjFtZnU2N2tWS0R1Z0tVT0tPc2QrV0xGTmMv?=
 =?utf-8?B?dnFCZ3JtMjFzWm9hWE5YSGUyM3JSdmJDUU9VZVpDaDBIUDFBZVFlU1htVGxl?=
 =?utf-8?B?L29XTmRWaHd4N2JoajE0cUJKUmRqMGNOWDdBb1did3Yva1FhYzlIemNGLzJm?=
 =?utf-8?B?Q3VITHkzb0IycW9XSURVNitSSjVnQXVVUGV1MlhVSVRpd3RGMnVwM3Y1enV5?=
 =?utf-8?B?Qmg0Nmc0SWFJZ2JUSnN6RGdPSXRUUkorUXYyNnhWUWN6SmRVT0I1WjJ5MjUy?=
 =?utf-8?B?dHV6WnJ0WHRnTXpMQjdmRjNrQ3dFOFRLZHhvZVJvOExGVTdxR2VvZkNRQ2tp?=
 =?utf-8?B?OE5zdjdRSHVKWjZUaVlHVEpHNTFXUTk2SUQzbnFwL0U0eEdyeGlnYmlodDRM?=
 =?utf-8?B?Q3UvU3dxWFVHR1F6c1RYc3ZjaUp5SUF0VnQ3RDFHb3IvOHphbm1BSXBGUnFx?=
 =?utf-8?B?aGp0cTRpRms2VzlQNFdoREFVTE5kb0tJSnlNNWJJWmNIcXJ1WVZuQXV1UWpG?=
 =?utf-8?B?REdrSzJGU2g2N01hMGF1b1RLK0RqaGtjZWh4UG5xZjVtOFozY0ovZEJiVDc1?=
 =?utf-8?B?TngrbnAzT1FEUGxMSTFENTVsaGFRQm9wYXFiNldOaWNkNGZBMXI0VEc0WE5B?=
 =?utf-8?B?UkpyU25vMGtsVCtzZUhpTG1FazFLV0ZFbGxQSG5FQXRxMGRWemNKemhianA1?=
 =?utf-8?B?VnlobWZRenJ6b0krUW56S1p6ZFBhS0MwM1R5dXUwN010RUJGZTExd1lEYW5U?=
 =?utf-8?B?S0xNYU81YVFBWDJYb0xzZ2I2UlZVOCt4MnIvS05pWURpaUtBRm1PakJpd2p4?=
 =?utf-8?B?WE95ZFdLeHRoZWNSWVF3c3pVS3dSUzBtSVEySndIY3FMUC9mbHEwbW5Hc2RF?=
 =?utf-8?B?cmV4OGdTQWxkeE83c0c1Z0E3WU5FZFE5eHV0Vjk3NFFJNmpyMm1DRGg1UWF3?=
 =?utf-8?B?d3dvNkNkRWJZMXdqR2JUdWo0dTBaWks4VnlSZTZubG9GeFo5N0VDdkVtREla?=
 =?utf-8?B?NWUrOXFZMitvMHlJaWM0bEU0WFBKaVRaaHBCT28wejR0NTVscmdMa21JcXc1?=
 =?utf-8?B?VEdwSFQrVktielRJMTEwYXVvSUtNL3FhVjdvS0g4SHR2Q01SYVhQRUhmM2J5?=
 =?utf-8?B?cmZhTjhsS2JORGI3eHBBS0V2NURwZXVyVHBlZ05HZExsSjZZR0NWUXVLbGdU?=
 =?utf-8?B?TGVZcmpnSWtqdWV3T0xVTHdWUCtPMFlqSDIxd1JCU3h4NXhMdHhFY21rUVZo?=
 =?utf-8?Q?9dMvfXK0EIzh1tIV1WGhWzXRcIpaoIly?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGVvRTI3Yml6Q2NhL0lidDZPUHhJYWtRWml2UW9pQVJKanNwcWZXdWdsMW4z?=
 =?utf-8?B?T2ZjOHB5MDdXYXVnd1dORnpnUFBrbnhLSm5nOVJkQldzOFRPMno4TkpSSWg2?=
 =?utf-8?B?cUVVQzEySWEyeEpkN3BtMFRUdWYxc2JCdU1TeVVzaVRPK3kzVHBMWE9TWVlU?=
 =?utf-8?B?bVJNclJaRXlCd2U5eHMrTWhYUWtGT2tuK283QnV5dkY3NWZaSE1FdDlSQTVC?=
 =?utf-8?B?NDEwYnlzUXgrdEpXSlQzTnNtdWtWN0dueGRWQmZLZzJUVHVOMy9pd3Bla1BO?=
 =?utf-8?B?c2lCSzU2VGFlSGxqaWthNm9leGhlV0gxa25OOEpsTitqZDkyRUtKQmwwTFNN?=
 =?utf-8?B?WEEvREpWU2h6T1lTdHI3S2VlczJNbUZibWR0b250SUNFRThZbXA4TjlIY3dC?=
 =?utf-8?B?QS9vN29ON3p6clpuWUU5MTc2cEJCcWxDVUFMMkc5dVFqUjVJcG9jUS9QSzhN?=
 =?utf-8?B?R2RPaW14MkVZNnFLQ09xYWkrQzVMdjRwNy9uRlhXa3F0aXRSd2xjUzN3d2VZ?=
 =?utf-8?B?NE5qNzZEQUZsWEVOOEFVSVB4SEJPVnpTeWhUOUwzQW95dllaZ1pIaWlKTkFn?=
 =?utf-8?B?OVduWDFneGVxdXhiOTBqcmR2bk1YZC80UXFYQmd6aXBUTmIreG1SNEZnVE9X?=
 =?utf-8?B?SnJOajVENm1PdTNvRlZYNm9tSDB4YWJiK0Jrd0R4T0ZGSFMzR0E2VWNBV3Ns?=
 =?utf-8?B?TW43bHdnNTh4dTJnVVFCWWxjV3pkSXVXMFNqSzliak9qYTlVbkdhVFpwZTFJ?=
 =?utf-8?B?b2FIMHIzckQvR0EveGgzaWFqVUFZZldjUXVwS1Q2OWRUK2VUUzdwbXFwdCta?=
 =?utf-8?B?QkF3ZStHb091VnZRc3lEK1JZL2dYSWVqSjhrNXhyQjFuYkdyS2FVVUl1VEFa?=
 =?utf-8?B?Q3BscitMdVJPZVZOWXFYMER2WDN2ZG11eW1tOURqTkFtakplRlJzSjV3cEhC?=
 =?utf-8?B?ZlNIRzhRT1NaVmlXbnZLb0g0Z0RTWjludXpDc2JSQWN1Tjd6RmIxYU1vR285?=
 =?utf-8?B?eVlBN3IxMlRuWjZyUERPa2FKZnZhUVhTRjJFWExlTEpDSjJSaEwvQnVyTDdu?=
 =?utf-8?B?Q05FOTM1bTJONXJmdXl1SFcrc210MElaSjI1WDY1bzFxZkd5V1pOek83ajkw?=
 =?utf-8?B?TU0yU055NktNWVJZZWVocVNmSEk0dzFnaTV3eGtQSmZxaFBVUDBGQ3F2a0l6?=
 =?utf-8?B?a0pONmw3RWt0eFIzUGY5RlVFNVhPQm5PQVBBaCtnSVZlVTMzaWxJRFFxTUN4?=
 =?utf-8?B?bGJCU0dJM3JtL2xDMm43TUNNck50elF6NlFHNzNObG5tZ0s0QXM2dFVTaW41?=
 =?utf-8?B?VWtLMXEzUklQcWdPRHREN2Q3T2d1QU9yQWRoYjJ3eEFiQ2VKR1RGcVl4dXZH?=
 =?utf-8?B?Q0cvM3pNRStpSCtIaWJtejU2Y0duZFFxTVoxeGVJNVkxbjlBLzBIY2dZNkNI?=
 =?utf-8?B?ZllydGozbm0vcXRlY2RESVcxaVlobEFWeWhtYVZaSDFLaDFYMUEwQkJQV05M?=
 =?utf-8?B?NU5xTUlETlp3ZTJlOWM5amtQbWhXVnJRU2ppVVdVMVBVTEtUREdGdlFNak5N?=
 =?utf-8?B?QnEzcGRPSk1QZnZDRmtlbzdnMDF2M25JK1VwSGJKRkorTVFCVnZ5Tk9LK2Fq?=
 =?utf-8?B?SElKSHNRSlRGd0xOMVEwV0cvOWQ2a1E1YjVCczYvcWRFTEJ6UUFpRlR4bktT?=
 =?utf-8?B?Sy9SRzdCMXpFaXZQNUhqZTl3RFlTTVdLK0lMWFNoYisxdUUzcFpJK3FlNVRp?=
 =?utf-8?B?K0FqclJFVmd5ZDlWSCtmbDJJM3Z1UkE4MnV5SzNhN0ZqR2dNNGo2UUt3OEg1?=
 =?utf-8?B?b2lESEdxWlJFSGIyZ0JMbVUvbVh5THlHMHdCanhBSlBJZktoZzNsekhnbnJC?=
 =?utf-8?B?VW1MRkZxNGExTlM4ZlJuR3Z3WGk2dlJUSkNzckdZYzVMd0FDcWE4NnFKN0t2?=
 =?utf-8?B?Zk0yaDdXekdBOVAyZmU2VXU3Rkx4SzJPcHpsTUtTUmViUG1WWWFMZFVIUWZh?=
 =?utf-8?B?T3IrclFVcWh3Q3podHpLN3F4SzlYSktpUitWb3N1eUtMYlIwMm9vRHM1NFJD?=
 =?utf-8?B?Q3pHZWZ4TGJVTFdySEpMM2JmMFdvdzFaWHhWWjY5OHBvMEROZEs4Q3oxN3hl?=
 =?utf-8?Q?OfIQfbHe4kFIZtMg0szuRmoMk?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c530535-3260-4d0a-a8ca-08de1a3ce460
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 18:23:16.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP+PvpP/j/c7ZD/+mAm49/GbVQx9ruG74c117c6rIqzq8fEOKmlwmb58MYagwTyTqWwJp5BRj9hfVnEOY7F9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8286

On Mon, Oct 13, 2025 at 09:26:24AM -0700, Lucas De Marchi wrote:
> It should now be rare to trigger this warning - it doesn't need to be so
> verbose. Make it follow the usual style in the module loading code.
> 
> For the same reason, drop the dump_stack().
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  kernel/module/main.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 74ff87b13c517..31c54bf6df4b2 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3045,13 +3045,9 @@ static noinline int do_init_module(struct module *mod)
>  		}
>  		goto fail_free_freeinit;
>  	}
> -	if (ret > 0) {
> -		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
> -			"follow 0/-E convention\n"
> -			"%s: loading module anyway...\n",
> -			__func__, mod->name, ret, __func__);
> -		dump_stack();
> -	}
> +	if (ret > 0)
> +		pr_warn("%s: init suspiciously returned %d, it should follow 0/-E convention\n",
> +			mod->name, ret);
>  
>  	/* Now it's a first class citizen! */
>  	mod->state = MODULE_STATE_LIVE;
> 
> -- 
> 2.51.0
> 
> 

Fair enough. Looks good to me.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
