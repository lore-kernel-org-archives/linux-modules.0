Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792508972;
	b=YSH7AIiVH98J828AR8gPHwqpyyPp70E/W5LE2/ztzCqZmzJLLRK4/BytKwBLpNPbMl5R
	 Kws2AWCqHamWdW+n58u977u7ivzRqD90ICv4P47kQuQqBki4tHYV+CL4ZiGq4224xBSta
	 MAPC/YLoTFzCUjhCwadoTwEtlxHQMcVFmlTmshLx2LF/fqXCHDqAnL2CvN5reRd4IMnXF
	 pOhyv6Bo0KFmVycooWWGyuI5HGQDkbLVK28Qp2t7rAho6FDtKRim6wPhScCMZ5GJfBk2p
	 XyXMWL/hB6INhOPFsJklRexE2W/oRDkLrhaoqmgu98i22KUS7WprUsTc7NHFHSeONcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508972;
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
	bh=+zLa6gZHrSnbd8FiB3pktwDNAZTIIeWvhkTrZk1wTkk=;
	b=mqFMrnzPdeG1iv0Fc5lOdawMjzzPZAufs3dLUNSD0Gjwx0QqsZKxpAccldTEMSJPioX1
	 h12Yin7hJKDQuEgY8kNV4I2t07uY2X4o8z7cNYKPg7r9tf7cbqfqM904+/pKkjycC9ypi
	 Wdg73cFGo4jS2qa1tb0tPthiPGAOspMgxQ/VLTIUHCZsUfg6kSJ9QQE052HC8CiRNwLhS
	 J+7vPdtco8u3Vvl0hxrv0YAbYdWBq5o05TygKclfOQXPAQ4wPDbIlCiiG7o1ajBkNqRoa
	 y98j2lKfnjhqJ2KEi7RmMiJB0YV+RHGI9pX4OOzzzmIZwtNTrmXIyU/8hytVmKpGZ3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.110
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021110.outbound.protection.outlook.com [52.101.95.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07B606A31D;
	Tue, 20 Oct 2026 15:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A07B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab6NERkjwDT896qIXH2qYUI0kCxjJ+wDGzHP+TJpsXi7R5+9RGBzW7KobESc2bahZjo1phsLrA5sWHgTaOsfwMgO8az92rfkBATD0kSyTbikirOIe4qSREs81BZLOkZxJxswEV4888vWsTiFTPknnvCTqSFTsbx+d/Iruj5seaohSrs4v3i/2d61+e71rFTob3U3JXWv1l3iux4idJSy9r1Jtces4QXtWU4/iDvgWaRwPnABlR85XPW6E82s9bhY4p8HHmTSWaPVfHgPgP8r14oWqe/JrsqblZPD+WybhiVnox+L4YrjrwCDF/X9VXi7xvga5lmIul6/IKsVsloi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+zLa6gZHrSnbd8FiB3pktwDNAZTIIeWvhkTrZk1wTkk=;
 b=sGAUHu1+O8pnru3erDqtLvs5grScU3gvZko5oAm1AaoTdiUWxcMvm6I38LWgQX64wy3N8ywN2FRmky8MJ3KWI797qKaI23ZkAdD8vAgiQSP2KvrWJxcUOow4NaAZ99/x0EOg8VBn/vp09Qo65LMuh4ePQSOsXrnzj3/4xvcHTA6Z5Rvx7koml3zJRMFB3WeTQbybrE63dnpHSleudwg0jhD04UXtZhV7rwURb3vE/3yQaDFYkNmTF+/jhlFyrTqFengdjnXdTrxXlmVH6E9kqU1LnhAnxYzZI1GTawGAiTLaW8EF/vn83pe6tx0BcHcqidE0EV+xhVFJoDZMGEBqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8258.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:09:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 15:09:28 +0000
Date: Tue, 20 Oct 2026 11:09:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] module: Move mod_unload_taint to tracking.c
Message-ID: <cdkh2bbie77upvj6qnklzsx2swdia3eg6loajkqgbz5heur57v@4qkhgtbec7ef>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
 <20261020-taint-unload-v1-3-d1c764889afc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-taint-unload-v1-3-d1c764889afc@suse.com>
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: da4b9123-f69b-4065-4d56-08df2ebc22bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uagB2DKb4/rziRYUMtd8Q+KZMQYEgPz/XguSrw/aQRl8BjNy/2P8tg4slIfMBBCcKiup7djBmM5ezFHJl+ZpMYrSfaFc/UCx+Mrge5avTCbKhDfZB6Is9VB2Il25a8wG1YrCbKF/+U2+WXDmrq9UcBkQkxYOSn3F8KBBtVIAh+9IVM6TP8KfIEafWcphDeE1qW54AhqvfwIc0QO1d67NvDl/vYGL9CrN/Fs8gXjC8HfUATeYdrdJq0I2f9Cz66hQzAXFF3sE8/0qFbX7H0UwyczKKPGGTqrP8Bjatp1GZjnw9aR5jI5iMk+csEaf/OFPGgLGR+wK9mSV5ugL4Zbye8CHlmqCEQYmqHPYpdGo39/gRfD4u0JqXNRO8tVGveOwNQmRlZb3GlDZI+LzJph9eD+YbuH9lVAGCvnyVeWRJqrgWVhKCy5dFuQSSHJKf2jsa2npD1UyS4M2+WPWbzFVXBbObxf0YmX4mwj3I+8Z/QNFErSkYeDeqS/xLONySeI9rjvoEpFk5uQhJStFCFFA+YgkjHgqsJckv0G55ALJvdwncRm01AqCm4r7Ouw3lypLeAvwgeiQ/isjNeCpy367D/NFnTxCUAlll97j3x0S6i5ALCPJw6HJW9216Ql20YcRtc0uJWGKp86KQTN+nZ7hgZE9Y0Oyq0DUB3z92eiFAzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnQ1RFE0Z3BLS0NPS1pnY09DZGxxWkt3eGN0NDgvaXpnVUpaUE9jc29rZS9k?=
 =?utf-8?B?SVcyZDR6TDhMVFkwdDRLb2RINWdFZDRpZmFnK3VYTWxIbERQMGtyeDVzZ3cv?=
 =?utf-8?B?elVydmIvQWltdnFqNU1rdWpKTXE2enVFRU1IMk5tMnZNUy9DMVd6MlRtMUwx?=
 =?utf-8?B?UllJNzZGdDR6VzNhQmJBdXh0TnhKWjIybXlmM3ZocGlpVTllbFRndlFadUo0?=
 =?utf-8?B?cXFlaklZd1h2UUpDcmplSExaTGprcUhjTkFKcG1vUitISE1wMS8veTJOQmtt?=
 =?utf-8?B?bndoejJLNmFWY1NtUG5NMWhlR3l5WDlzdCtFckJmNEg5QVJPdmh4T2dBSHpT?=
 =?utf-8?B?ZkdHRndzektxTDRWbVJLREZpK1QrMEtRcWM0OEpENjNyWE1paHdRREtockxt?=
 =?utf-8?B?YlplcUY4ZDYvL2F2UnBWbmEwM3dzekxteGF1OUU2WWM4Z05rUFZLZktQaFlz?=
 =?utf-8?B?VDZUNDY3OUpLemlQTUN4VVlLT0lFSkw0VkhaSDdFUnlqZDk0S2FrQ2FYWGV1?=
 =?utf-8?B?Yk0vL1QrbnVqYkg2YzVMdEJWdXc1RDMvOGdMRldUeFFucnZyVTd3Wk5uYWs4?=
 =?utf-8?B?dlNnKzVXeS9vcklkbG1XTldJNnl0QVpQUWFNVXhOL1FwSmtBc00vdGRCenk2?=
 =?utf-8?B?aDF4UlN1SzJFNFg1bnVnL3Q3d3ZMcjQ3Y05Xb2l1WVFRRnNaZGNxR1paSlJE?=
 =?utf-8?B?eFdsWHdUU1d5YVRIWGZsdHBzbTNtUFJHeXZvWHZWbXNBSVNzTnY2ZkdTVHVI?=
 =?utf-8?B?UU02Nm0vVUE0aktiOWdYYjNWem5zQ3hMU25UYUZteG1GZk5hNmMrTHZCalAy?=
 =?utf-8?B?Ty9QZ2JjbHNJOXNwd1c4dGt0ekFaVVhVSm1lY1ZqNlpvS3VHMkltY2ZBNnFJ?=
 =?utf-8?B?WllKalZmYWVDZ2VmN3pDWDhDV1RySm9QeitLU0kvZGp2WjhXZ0F4L2xRTTZa?=
 =?utf-8?B?ZFNOVmFHUitkamJ6aUt4aENPa2krTS96MW02dEhoeGswbWx5eEQyVmpaYStm?=
 =?utf-8?B?OGVLeXR2YTZiaDRiU2NISTVKRGNCNE1WdVA1T1VwcHo1cmMyQk1KVFZrZGsr?=
 =?utf-8?B?UnJ2cjdHbklSYkxuMEtiVnlUSVU1ZjR6RFFnRnJsM2l1RmlGOHBId0R2bG5M?=
 =?utf-8?B?KzFNOXlKS3U0V3FCVU0weW03SjRHT21iQ1MraEhsOVZFS3VOY09mNWVvd2sy?=
 =?utf-8?B?T3o5bTgwbEVmTDBMdjI1NUhuRUZZb0Q5cUcxZ2dXMHZXdVFGVHZyUHd6cVly?=
 =?utf-8?B?bEF2TEJvbXkxQ09UTG5tM1grVWVTdTg3Y3QyRXdwdldsSy84dmlsOUI2eUVW?=
 =?utf-8?B?aTBJVjgwb1Q2Z3I2RlZoMGU5MWpoNndyeW8ycjhNbG9JSjNteG5LK0dVUlI2?=
 =?utf-8?B?Y2Z4K0d2NDZaNWplcFJ4N1FNcWpqT1hRdG94VkFVRmV1S1hKOUk2WDdsVFdt?=
 =?utf-8?B?K2x0c3VpdVF6d3BkbENqSnlUR1NpMllXdCtJV2htbHludXg5M2YwR0xsZWl6?=
 =?utf-8?B?NWpWd1ZuakFYVWxIdG9sNzV5ZFEzOG4yNkkwdTdocWQ5dFNGVEszRnVFVEhr?=
 =?utf-8?B?NVBxWUdHWjB2M1Rwa0VnbHljRWJEdTZFMkN1SkQwTXBEWmZXQWcrSlNlZmNV?=
 =?utf-8?B?R05RanVwQUhoczAxZk91NDJYUm9IOFY4b0w1WGhoTnlLcTUvR3BMckRPYVg5?=
 =?utf-8?B?ckNqWnRqcVp3RG1qWkdibFFNMk96NVA4TndwcjgvbGpkdmMwejRYTHJUVlg1?=
 =?utf-8?B?TDQvVUE2WWRaY0pCTDR0aW1PZFY2S2I5UkFDQllVc0ltQURxWGFRL1RueUly?=
 =?utf-8?B?alloMjRQRDhMZDJ6SUVHV1NtS2tCRU9CUjFuVjJLWVIxMHA3a0Q5UEYzcVlK?=
 =?utf-8?B?SDB3MU5wVU9KY0FxTFQrNFp1WnBvdFh3L01KNjdiSFlwVU40UU15c2w5bkNP?=
 =?utf-8?B?TmVPSXZnUDY0UG9YRUZIankzaW12RWh4Z0NiUDFDUFJPZU9BNzBCQStITFZD?=
 =?utf-8?B?cklleGI0bzZFRUVGRFVxV0kwOEkwY01DMm1Yd3RGS2tOanhoN3FoMUJyQzBX?=
 =?utf-8?B?OG1hYkpJQmMzL3UzL0lmWjhrZU02UWdOb1F6Q3JjdlpyaWRSVmliOWhqbk1D?=
 =?utf-8?B?cEd6cWticVpDb05taGVRTU8vby8zWWhMdG9id1h3VWJoVWNuRVFIRzY3ZmZ0?=
 =?utf-8?B?clV5NVFtV1VWNEVYZFVyaGwwNm1qSjRHUXprQzdqL1FrOE0vR3N2WWRuQmhs?=
 =?utf-8?B?ckVSVlBUSnd6MlZLTm1HUFNsVUUrd01TRWZuQXdOb3kzVjh2dEo2MHFuZmp2?=
 =?utf-8?B?NVZRMWJORzVTMUFBZDJ0WWYyVjlNQ0lvOFNFZUNmdUliK1l6aXc1QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4b9123-f69b-4065-4d56-08df2ebc22bd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:09:28.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHcJB6WJGnKk+bHRgZIPvkxP08JrFvl2C0fNMCokKfNOb+VWgtqku7H3SOw32P+uQfIUKOJqiOplwdxlzsBpDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8258

On Tue, Oct 20, 2026 at 04:05:21PM +0200, Petr Pavlu wrote:
> Move the definition of mod_unload_taint from internal.h to tracking.c, as
> it doesn't need to be exposed to other module code, and remove the
> redundant declaration of mod_debugfs_root from tracking.c, as it is already
> declared in internal.h.
> 
> This is a non-functional change.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/internal.h | 13 -------------
>  kernel/module/tracking.c | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 70ef20b97c84..3aca22253296 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -253,19 +253,6 @@ static inline void kmod_dup_request_announce(char *module_name, int ret)
>  #endif
>  
>  #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> -struct mod_unload_taint {
> -	struct list_head list;
> -	char name[MODULE_NAME_LEN];
> -	unsigned long taints;
> -
> -	/*
> -	 * Number of times a module with this name and taint combination has
> -	 * been unloaded. Updates are serialized by module_mutex and use
> -	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
> -	 */
> -	unsigned int count;
> -};
> -
>  int try_add_tainted_module(struct module *mod);
>  void print_unloaded_tainted_modules(void);
>  #else /* !CONFIG_MODULE_UNLOAD_TAINT_TRACKING */
> diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
> index 873fceb30526..46840dc22dcb 100644
> --- a/kernel/module/tracking.c
> +++ b/kernel/module/tracking.c
> @@ -14,8 +14,20 @@
>  #include <linux/rculist.h>
>  #include "internal.h"
>  
> +struct mod_unload_taint {
> +	struct list_head list;
> +	char name[MODULE_NAME_LEN];
> +	unsigned long taints;
> +
> +	/*
> +	 * Number of times a module with this name and taint combination has
> +	 * been unloaded. Updates are serialized by module_mutex and use
> +	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
> +	 */
> +	unsigned int count;
> +};
> +
>  static LIST_HEAD(unloaded_tainted_modules);
> -extern struct dentry *mod_debugfs_root;
>  
>  int try_add_tainted_module(struct module *mod)
>  {
> 
> -- 
> 2.55.0

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
