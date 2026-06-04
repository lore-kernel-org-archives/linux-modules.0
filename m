Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B423AA1A1;
	Thu,  4 Jun 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579553; cv=fail; b=ETNAtI9nBxlu4W6VyNN4d22c9iR/AWj2bZEjEaTOtqWAFhGiQz+kbOkxKvvfQvcY7PdJIv/n8gEanTQ9+cooFPsfqRzFvdyqBV7qRi88ACLbDOH5BtMiomAhnHTUa6NF9ng2AHIjdGBVPnCI9tPq8LBKq65IlW3QhI80T3BwH8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579553; c=relaxed/simple;
	bh=IjifaybhnBRBHkS9ZuimDGbRnN8KI+z9mHxkn7hyVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X91E5wUXf7/JAt5dTneba40Z+V8y/yhyBBOeIcldOkjAffPYfwccYETKO5My0jPED9nTn3XFPOpVHfTB0OeASS6ugEw/r2e8fdE4bKlvV/DNfwlrZMyCkOCNUkrPFEvQMU1n6BKGND8xuWGy8pl5HahiFIYdUMi7x+gYwTsZGQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKjin2P6PXV+NWDhyLLjF7NzvnDUo7DpcPP7EKLfHN6QcKRP1WFMtJPxE1PgRqdJal456/TMcxwnQsHk0pjOOuU9TdFlnpYvgf0Bn0efqe3bue6b9Ig3gg8PhXmhmL1mWY3I9Vs7N42h9NuXYRNPAwQYId9ArQyQ4xah6vmzk15QP/G2JoMd2lWbxT8TXL6YsH1t0MUxvMujpCah6R6HRDU5fbEp02j/kdXzHZaxGTRsIDxHEvUpcKBD4ir7hPUmBBIX9PME/+usjKP27QH7Zy+09cKPSYijKJaJ2Q6kDePipKRAggh1hzkAcerDVBK1xMlLWL3r120X4XjP+agNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=JA1F5gtLZxSunUCfC/nXcWa/U0bUtRd8k/4+eYB1/yE=;
 b=OmiuYDhba4KW9cyLjxU6hwENLWzgY6HlHEbMlQ6WdYHbsVM2tcmUSuTNdKIMbU+q0jocKP24zNYRnBSiyt2qq5PdQRrXE+ro50yuwsKFKd6E2xl5r0kWQFw2VE350H8Z07TYO5nkinL0yAEf5ojFydPbxgNKmzMfmHgLEYnNF7vj4Xph967kF+qzQEWT3Ot3A+IALuzCTA2nOtRQShMkYUDJllSTrCf/+hdhcEcAd1Dsc2eUpCNraLYqlHhTwIZxD+iz1XflCiCOjIg0/wOr/hUVZISIVIsZH5844AHDWDXPycW9W9djJnTx4bGiMLd6UkSdssa/8UI6ciwtDO1I0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6985.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:25:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 13:25:49 +0000
Date: Thu, 4 Jun 2026 09:25:46 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Matthew Wood <thepacketgeek@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: Remove unnecessary module::args
Message-ID: <nlnjim47muiovjae27ml6bkb4nzijcyh6rs2w4g5nvedgnr67x@eti3mgbqmr75>
References: <20260604110455.1608038-1-petr.pavlu@suse.com>
 <20260604110455.1608038-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604110455.1608038-3-petr.pavlu@suse.com>
X-ClientProxiedBy: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 601f7522-0bc9-4e83-cd7b-08dec23ccb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|3023799007|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jy1rP0pACu5wp1QHX6bWWd9wKTBbvIIZL/tYd0oXqygGIWjzeY4cUHqECGPj68+j93N4Zs7npsGiAE7yKBmH14utJov8VfODi6HwcBUG4Ax8ZpEh2Giury0f5If/lNm7izW6O75laoUCPqTVA8H9afIfVpDUGaxGpsjg/ZvM8aunlgB9gMKHdFwuoNC+uaex/1EN/T/iCFzG6sE1ne4hwldtK4Cmcopf6Eme+aGsnOc3lfjOJR/oocWBZALQQwmhQ0AGB/Dv3UUbsbuQbxcSvEzlF6e+ZYr1agRhrN5cCfE2yNupvcK2s9svla1gC53RP8Zt5n/D3RHawLuafEglDpysxi0BSn8baIO5PRAgmwHXE5NT5JuMYX/ikBKTXdWTJBsGQKofP58svtdEbJJDU6FnJz6vey+YgtGrxfl5f/x0P1NVux037yLCTjczKP89uBL30z7OYqGlGbjeC5e5oWpR5ISiTGSq5r5n5B/Tx+imxTS8IaKkN/Nlwzfp4bdxf5buDTOdDXnLGYIbqLoG/0qIjh1T11zfJEaueOCSPClgucLKZbO+XVvk22cErcDhayMrL5cQsTn1JT6ROlYRzjIvd5ofPixgAQx+jBhYGPUeRzsp9eNNUbzJ60grp5xgn0S90BLgL1DYc4BMY00d3EAXfSyKzUcWGAB7FEzYkDqa+8QcZyagj21H/eonhTjN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3BiWFZkN0hhZHZPSlA3Y01GanMzUnF5aC9PdG9CZG1lem03UlExQlBqak9T?=
 =?utf-8?B?WCtpcHd2YmVBT3NOTXBxRjJOUTNVVzFtdzRSSW56bmZ4Qk9LUGdUWU1uWGpU?=
 =?utf-8?B?YU5TWlFwcUxnN1RJYlp6bWdhZ28wWHhZSTd5a1A1WFRrUzRjMExDMk5pQXF2?=
 =?utf-8?B?UUJFYkpZVDBnRHJENTR0R2c2UElzRGRmZXhoaTI2ZEZ1Vm1xRnBrMmdGL29z?=
 =?utf-8?B?UkxRbTJISno2L2hRa2Ntbnp0ZFVPVmhSaEtMMzF1VEFLZitRbW0wWFVIdXlT?=
 =?utf-8?B?bHl5cFhETEJRN3dYbnBxUnBndFBJenh4NXUzcUY0dkxVNjNNZTlIZExKcmZB?=
 =?utf-8?B?NFhtY2dISEVoRWdDMC9wRWttdUlwaGtkUy9kRFJVMVRvMU50anVnSGJya0c2?=
 =?utf-8?B?UHN1Yk1INDQxQXF5NmVxWkZtUVYwckluNHVwTE0yazJVTk9sTHc3ZDUvUmxv?=
 =?utf-8?B?OW0wVUpEN1BTMUR0QU1LbWlXNlJxQjV4TmgyZ0paYktyTkJBcktuREVaSWlu?=
 =?utf-8?B?WktVWjA3V0FhNDlobXJ0NHpWbFF3dWNzcUhGRTEyT0FRaXB2V2hQN1ZHVkZS?=
 =?utf-8?B?NXllWFlpU3pxYU5ZSTV5NFRXLzdCNnU3MGtzTTJob2tNdGw2UXZKVnBIZ0Zs?=
 =?utf-8?B?YzY0dmJpWXlSNG1QLzk3cTd0S2dUYmJwS1dyU08xU3I2cG5PaHZ2Z0lhS3NJ?=
 =?utf-8?B?a2JsZG8wbXdTOUdVVXdGOS81VW9CWUk3K0p1VWlyQSttMkJpUTVUZjV2ZkEz?=
 =?utf-8?B?ejUxaUVNWm1rUGI5WXV3ZTlJdzV4ajJ6enVoMytqc1JMT0swc09zY0t5TXpF?=
 =?utf-8?B?Y1pQSEt6ZnAwK2ZyMk9IOXlELzB2b0hiNWJQYUVyQ001bStlcmpzQ1UvWGZj?=
 =?utf-8?B?NUU1K2lQOXpOZVdGNWpGRjZFa2tVeCtFdG5zTUNidE5PZTRJeUZVL21LQk91?=
 =?utf-8?B?TVZDWC9icStOQ05aVVIzTzJHNU5CNTg5MEF4bDhYVE8xSzg3VGd5WlFDOXhQ?=
 =?utf-8?B?UU85bG5RdEJlQmZLdktxcmdWZG5tUWJmN2dpTnZ0M3hhVDhGc0w1bzBXMHFn?=
 =?utf-8?B?MHRJZ0NNak41VSt5SVh1cmVpYXJZVC9EcW41eEU4S2xoNjQ3WXQ3bDZnN0dx?=
 =?utf-8?B?WEQ0bDBEeUcrU3NRZnh3Vk4yN2ZXNmU1RVpsUDZHcnJ1VlpndEZOenQ4VE9m?=
 =?utf-8?B?RXVwbHpUSC9TSkVVYklURmtrRTRqQkwzU3ZIb1RTMUpOcHVNV0pva1JkTitK?=
 =?utf-8?B?MDM0dnFXMTJjazlJN2g5MTJjalRlbDJCRmtTakUyM2d2WVpYTWlCamZLdjRp?=
 =?utf-8?B?aThqUWpDdURFT214TDY4bmdnTmErV3hzL0IrNGlnc25pSzRINjRRczZTU1Fu?=
 =?utf-8?B?MVhjVE15UXpPbGdGRXJ5a21xZktVSlF6Q3NaY3dsdDl2VFBZT1pIckNTUFE3?=
 =?utf-8?B?ZEhkaXFZa3docU1sUkFpWlJkMVdRdGIrcmZDaHE4RjkvUEJhM0ZKWkRXZ0Iv?=
 =?utf-8?B?VFJJcG1vTG43b3E1M2ZuV1hIU3g2bUE0bHNSVVRKTnRaK1FXVThaQ0YrblR0?=
 =?utf-8?B?M2h4ZVY2MlVsU2c4ayt4RWNkQ1pCUDBMdHhkVHU5Z2VqVmRKb0lCR3NIRGo0?=
 =?utf-8?B?cm93Z3pTU2ZMaTRoaUVFYVBEdjZwMERJTjZCbGhMRDhJcTB3QUFwZmRkZ0s1?=
 =?utf-8?B?T0h6NEIvcFF0UENEeXN4Q0d5RWNUWGpOWHd6OEhTWncrSkZuWkxNOXFWSHdB?=
 =?utf-8?B?cFZ5bExXbHZLOHZoOWFtNGo5b0NNNXRNaWs2bjljeHB4TUhXLzd6anlFRDhr?=
 =?utf-8?B?MDlEc21DcWQzSnFGUUpmVUNiYTJTaDk2Qy95b1JOYkViaWp6ZzAwcitGUjc1?=
 =?utf-8?B?eXlJK1lrVWZMZ0hSK21Pb0FCUlgvMDdzc1RpMGtacTVwMmYzWGJXYWhBd3Bs?=
 =?utf-8?B?bTV0MGhTVCt5TDlPR2UvVkQ3R1BlalNCeTVjeFJWa25aSEtJYUluaUhQUUxB?=
 =?utf-8?B?b0F2TWFCa2xvdUY1THhQNHBQSXVUbG9HcXJsWGFobm5UQWZCOExXMW52N2Ur?=
 =?utf-8?B?aEVqdU11Q0h4WUV5K2dUWXZiUlZpWWx6NXhVSFhWMEJCT29DMWZ4a1JZTlpY?=
 =?utf-8?B?Q25pVXVrZVB6MFJ2eVlRVzJUdFo4Zmo5TVEvcUo1V1p0SGJkRmd0bmhneDds?=
 =?utf-8?B?TWhsazkwM2tqWndhOHN4cEhvelN1U0J6Qk5wNkVzbHJLU2R2WU10TkhHb3hP?=
 =?utf-8?B?M3p0RjJueTJwVHd3RGxOT3dDbHVCQ25NMmxsMHhrVy9FOVpuT1NJSVpoakEv?=
 =?utf-8?B?REU4cDJ2SnBBWFl1VDRBVGkrQ0RUSFlzZzJlZlU3RTA0c2g4cEdjZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601f7522-0bc9-4e83-cd7b-08dec23ccb1b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:25:49.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o35iHn3vkB/bb/1jrszM47eau0DGUBvTnEV0rB56MsW7S/D/g3ivnn/e3zfCirXxFIeSFTIGtHI8xjVzAUhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6985

On Thu, Jun 04, 2026 at 01:04:46PM +0200, Petr Pavlu wrote:
> Historically, various parameter-handling code kept pointers into
> module::args, most notably the charp support. However, in 2009,
> commit e180a6b7759a ("param: fix charp parameters set via sysfs") changed
> charp parameters to kstrdup() the input string as well. As a result,
> module::args now mostly wastes memory.
> 
> The last users that still pointed into module::args have now been cleaned
> up, so remove this data.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/module.h |  4 ----
>  kernel/module/main.c   | 15 ++++++++-------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..96cc98568eea 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -477,10 +477,6 @@ struct module {
>  	struct module_notes_attrs *notes_attrs;
>  #endif
>  
> -	/* The command line arguments (may be mangled).  People like
> -	   keeping pointers to this stuff */
> -	char *args;
> -
>  #ifdef CONFIG_SMP
>  	/* Per-cpu data. */
>  	void __percpu *percpu;
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..528690ba160b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1458,7 +1458,6 @@ static void free_module(struct module *mod)
>  
>  	/* This may be empty, but that's OK */
>  	module_arch_freeing_init(mod);
> -	kfree(mod->args);
>  	percpu_modfree(mod);
>  
>  	free_mod_mem(mod);
> @@ -3425,7 +3424,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	struct module *mod;
>  	bool module_allocated = false;
>  	long err = 0;
> -	char *after_dashes;
> +	char *args = NULL, *after_dashes;
>  
>  	/*
>  	 * Do the signature check (if any) first. All that
> @@ -3523,9 +3522,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	flush_module_icache(mod);
>  
>  	/* Now copy in args */
> -	mod->args = strndup_user(uargs, ~0UL >> 1);
> -	if (IS_ERR(mod->args)) {
> -		err = PTR_ERR(mod->args);
> +	args = strndup_user(uargs, ~0UL >> 1);
> +	if (IS_ERR(args)) {
> +		err = PTR_ERR(args);
>  		goto free_arch_cleanup;
>  	}
>  
> @@ -3546,7 +3545,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	mod->async_probe_requested = async_probe;
>  
>  	/* Module is ready to execute: parsing args may do that. */
> -	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
> +	after_dashes = parse_args(mod->name, args, mod->kp, mod->num_kp,
>  				  -32768, 32767, mod,
>  				  unknown_module_param_cb);
>  	if (IS_ERR(after_dashes)) {
> @@ -3556,6 +3555,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  		pr_warn("%s: parameters '%s' after `--' ignored\n",
>  		       mod->name, after_dashes);
>  	}
> +	kfree(args);
> +	args = NULL;
>  
>  	/* Link in to sysfs. */
>  	err = mod_sysfs_setup(mod, info, mod->kp, mod->num_kp);
> @@ -3597,7 +3598,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   ddebug_cleanup:
>  	ftrace_release_mod(mod);
>  	synchronize_rcu();
> -	kfree(mod->args);
> +	kfree(args);
>   free_arch_cleanup:
>  	module_arch_cleanup(mod);
>   free_modinfo:
> -- 
> 2.54.0
> 

LGTM.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
