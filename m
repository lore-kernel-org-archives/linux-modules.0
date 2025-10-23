Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022133.outbound.protection.outlook.com [52.101.96.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DE2222A0;
	Thu, 23 Oct 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187549; cv=fail; b=hB4trFkV1hlCIbulXOni+YyT75Y4ZcaQpuoNJW+VXZTH8jA0dDmsWEWkIzMKAJjUdQNyldO+FmxHXyqPwiT66gDOpbUl7FnpnMFpuafLhy+Rquv9Dd4l/o6hXt7wDH7qok29V1ojBNIl8W6if7R3R6+wfmmzwSKBRjY6D1tRgZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187549; c=relaxed/simple;
	bh=r4PUV14RdyguU7dA9LLh2HiqbPO6RdMz/H7MGoNlXnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GBbI3xoDU4/zR1dzzO8+nKVQxr56Gl2fCzKBkO07e9FY9bS6oy6hbGmJdXLCH5hg0o0QpAn0sjLfkL2QShNq4B3gT+zD/HPxKxpAq/GiP6pCi6sArSvtoTXkN1FL65LWTXmjGidYBbFEGGZ6Qso5qVj/1eWSanHaEV6kNG5BJ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEoijiZc1FLSMElSQUsf4mANpm6P2ejcx/rFCPJYIHKphN3DFlHzWekV2GK6ONCO5fZSoAiTsNR0HzVZGQPMjDgJRTpQk2fTHCHXQ0bpQSSlPtF6pxzkzLHAB5u8vRipEhUxuziVrq7EF+bO0mchZ3cuzsNs+lDzYKe6SqQi2aTPEvAEq5u27dG2hJTxQRjLhuHwAho4vsI5dwGcBK2/UaWV/8Nx93fzXCO4LA7OcO5Z4KlB1X/vgAMwFLPkYLtwwt2ElfV0XNG5jlGCvHVwSzXDDu8+FVjf9NLJ5f6ksImPeKNZAIilwCk4vQq99HY4+GdzZp2JVBIs/CyuCn0Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv8syxyndtjpSOQsM8digwEzdcahM1As21KoJwjf3ZM=;
 b=eBi50X4PnVKBxgPpzeMy1mbf0AYI8t8gw9EPaq4lvYUro1TZOFpsdhN+UEdxFvGK/ebp8jjtvFt3G10oftV1eJ04OHCsqrX4rtmkLw2WQ2JZrI18JYBlbgGVb4J3ci2kxZui0bwsBVMKlE1nuuaYOgOsjdbnzoruMkj20BE05r7VeT7CYFd05A9sMSahamNkGHMl36Sb5h/oEa0x64IMCB3XJ/bcqHJ8WFH+02+LcFmUPK+YnyQjWocZcG7+RNWP/3v5lU/Eyp+GBWFRgFn2MZINBTHYaB0qv90e5pXTy7SX54vYEFmWnXcDNZ8tXt8YHqGScS1woiQ5q6wY1dB66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2879.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 02:45:42 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 02:45:42 +0000
Date: Wed, 22 Oct 2025 22:45:39 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] params: Replace __modinit with __init_or_module
Message-ID: <5chps2fpsmvvksqjnxdenwfl4ozkkwqgfki3sd7rkuxrfme2os@bfn4b6d45d5c>
References: <20250819121248.460105-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819121248.460105-1-petr.pavlu@suse.com>
X-ClientProxiedBy: BN9PR03CA0736.namprd03.prod.outlook.com
 (2603:10b6:408:110::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2879:EE_
X-MS-Office365-Filtering-Correlation-Id: 717168f6-8bd7-43cc-06c5-08de11de41e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkVGUGNlMHlZdHI4ek9adkF3aGZ1NFBLVnVFQVpja3dWd09teE4rVExXeGZP?=
 =?utf-8?B?OGd4Q01YS2F5NGM1d0NRVmpzZFI3VW9TSVRJRGdIdWQrWHVkbEsvYUNDUHc3?=
 =?utf-8?B?b0FBczNNdTN1eUt3SU9ZN3ZEZjhDd0pWS1Y5aEZPRnZ3ZjNjWVZMam52V1Fo?=
 =?utf-8?B?UDdKeFUrU2RuNWhBQXZ3WmZOQ2lUV3pWOGZRZ1pqK0t5UXJXaGxIWWZqUlhN?=
 =?utf-8?B?QnMxdTVHMi9HQlZlSzVxcmdGd3dCb2lOd2VORjVISlFqVm01S1NrcXRoUmds?=
 =?utf-8?B?djRhR0czYmlMcnlpRktqOS9IVlZYa0F2K2VMWWtJNkVNdXdwUzRuYTFXanNI?=
 =?utf-8?B?R0NjenA2UjhTTW9CTkxLQThrNTlCSVY1UFZ3MXJGVlhJTzZDRFozWVRJbWtJ?=
 =?utf-8?B?QVA2WUw4a3F2TnJtYXhqODZtdGlxV0QyMkZvWjVvdEhSWnZQaFJLQlNadVN1?=
 =?utf-8?B?OS9PUWY4cXY1SG1POE9OYjlId05VQkxVbWNjK2dsOUlESENLTWJDNC9XNmsv?=
 =?utf-8?B?aWRmNTlxczM5VnN3NUZPV295VTM3ekdNVGxhanJLOHdIa0dLRVFTcGUwYWdV?=
 =?utf-8?B?OEI1LzVHN3RSUDdLdmltTFZ6enBQVDFqd2F6T1BIVExDeGU1Ni9QSkg0Z0Ey?=
 =?utf-8?B?NjZzU1hHTmFmT2NhcWFqRERCRk9YNTl5ZnYxaDBFYzNOY25xZnlNYlIwUVps?=
 =?utf-8?B?Qk1GcUZONlhEWlZDdzZXb1R1WWd4NldpUjRGT2RMWFRYY29MTlBrUWo2bE01?=
 =?utf-8?B?MHloMStSenpXZkNzSmJFTWh3eXpGRzYvWXRNS0phb0hsMEUyUUovY01xYjdk?=
 =?utf-8?B?YnFwNTVCNmZwSzVOeHJlRkNmZTA3UzFmcHZKazhMdVhqN3V0M0h4dEVGK056?=
 =?utf-8?B?L0Y4aU50WDduZ0RDSVhiMXE0RlJNd2J4TVdQYm9aUGlSenhnZnNPb1RNenE0?=
 =?utf-8?B?MTZqZjRlVFVISDBFMnBqWGRQMGxhSjJBVmkvTGJSYzVSbjNRUGR0MGlMQnYv?=
 =?utf-8?B?aGdyZTNjbzlQaWFGMmg5dVJvR3l2LzY3Z0ZrSWVHcmh5Y0V0TUo1eElNdW13?=
 =?utf-8?B?N1ExeFFETVpJeXVSZHFVdGRQbHU5d0ZkaTRscy9RMTVwazAyTk5td0tuQVVk?=
 =?utf-8?B?OVA2djVVTXprKzNNU2hXclVDVlgxY3QxdGc0YzRDUnhyZWRLdkphcmJDeUE5?=
 =?utf-8?B?OTc5djJnQ2Y2eUhjM2daQkV4V2Iwck5GKzd5ZGpLbERjWDVLU1lzMG5ScTJt?=
 =?utf-8?B?SnBNeWprSEFGUmljREloVnRyT25xb1NVY1hjVVh0UCtmWUV2eEw3SDhSeU9X?=
 =?utf-8?B?UVFTYkdsUW1EMEVvRFNxMW1iVjk3L3lUTURraC85eWJLd0ltdXFMejdYVXRZ?=
 =?utf-8?B?WCtjaTVBbGFsampZcDIrZmlYaHk4NDA5dXhjMnJEVFFNZVFRMEFyOHNoY1Av?=
 =?utf-8?B?TXg4RWhoUmh3UnFTVDhWc0xBQWx4NlAycituUHRYdjdUSlQ0WkNNRWJkY3Zk?=
 =?utf-8?B?em42UG5FY0ZRRXlpZEp6MWJQVm1zZ1ZITkN1WUhpV2Z5eTRZeFVkZWtlVE8z?=
 =?utf-8?B?MHZVUkY5QzJBREZPenRvbWcxVXdaNlhpbDVTUjBseEJuMjFxbmNKd1dJWHRW?=
 =?utf-8?B?aTNaZkxhTFhrZUZiYmRuaXc4TjQzcHZ0T1FvWFZ1Sml1cDFHT29jQ2dMNXg3?=
 =?utf-8?B?S2RvRGFBamV2ZG9VZzl4MHVJcUh5TUM0SHMyUlBaM1dOaDNtR1BFbEZoNHlI?=
 =?utf-8?B?KzdiSzlkeU1LUlNxUnNiRmVNUU1zdE9ucVVIQ0Z2VlhNQ3lYRDVnVVRaeksv?=
 =?utf-8?B?V0NXSTBqSE9CcXdpK3owejdEeUN3dGxobHkxVkQ4b0pkRHBrUVRPNUlqUHdr?=
 =?utf-8?B?N1dlMXdET0pyV1Q4bUd5WmtQV3U4ZVYwa25XRlN4c3RkQlhtQzErZHdzT1Vr?=
 =?utf-8?Q?eKGYo42p/9enFdiPN0dDzO629Gxivxa1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjNPeDBkY1VGVlBTQm1XNU5FaXlrMGd1NFJURThGNjJoSlE1MGx2TlNURzFF?=
 =?utf-8?B?cE1tMjJGR2lZZ21MY2Iyb3p6OVZkRjVnL3hwNC9UYU9VSVpiSFZYUHB6TFNu?=
 =?utf-8?B?Y25OT1JrMFVjWGF0NUNwRmJMM3o1Z0dSMUI1a0NNVEl0RDd2K0JCM1hRSkdF?=
 =?utf-8?B?SVUrdnB1dEt0Vmc0N1FBSnU0dU1BRThGd1Jxc24zVU42emxaajl2bEZJckg5?=
 =?utf-8?B?MXJLNVNtZXFXY0dLSUlLN1J1V3N3TU84eTNqbTRqNC9OQVRXcng0OEVkajk3?=
 =?utf-8?B?ZHBwdTBqZWd3cUFta24vUDFBbW9PNzR1N0gwV0VVaEJSd3JzSDNJRnJkbEhr?=
 =?utf-8?B?YmN2WHF2bTN3QWJBci82WkRGOFNZOGJVeHZzaGJmMTdSQ0pLcWxrWFVYUnlQ?=
 =?utf-8?B?NnN4NFpMMy9DdmxxMGNjaXZUMTRSZXhrYWtLVjlXeTRXbkQ4b2d6RjB6SGJo?=
 =?utf-8?B?UHpDblBudUhZSnZ4dlpVRWlXbVoxRjM4ZWNoN0xGQ0tvYkIyalY1WURLeFZk?=
 =?utf-8?B?dWNTditza2tRcEYxWEE1MTdIeXB3RktNdEVKdU5jR0lFS2dLOXd3TGluTk5T?=
 =?utf-8?B?MmFxNmFWTW1yVmlodzExTkxBY1NucXhwV1gyZmJ4dWVjNWRXL1pNcm9PQXhk?=
 =?utf-8?B?Qk9MTFEraXd0bFdUcTd1ZUtuTmtneHBEM0J6SnR0b0ZvMlFMWm80eHVFMmhW?=
 =?utf-8?B?TXlhdE5WeEFLV255Tml0bGFORDhkUGRESU1Oay9KUWdFUG9LNzdhUHM2WlFQ?=
 =?utf-8?B?eC8xcmFpOG1kNjJ3ekZUSUhlUXlTVnhDL0p4OXAyNHhYbC9YK2JJU3lFUXU0?=
 =?utf-8?B?WkhaREdUNmRVVzdKNjZ5cmFFTnJNNGZ5RDdnNmIybUZHWXRIeGNsdjlHLy95?=
 =?utf-8?B?SjR1dlZCeFVHbkM1Nlc3a0RCMnQvUVVBMjFvSU9SYUZoSWE0aUVqcTRjSmNq?=
 =?utf-8?B?YVVJK0hldkYwdEdqUndDVXE0aGRMMUpuTk1nazc2Rkw4dXlJdkVFUCt1UDNR?=
 =?utf-8?B?VDVNRW9udzBjTkkwdDFUbUo0bldHOTZ2M0JrQThJS25mMHFKbDNNUEhlQWZM?=
 =?utf-8?B?bE1LS0FqOE8vYURVbVBqeW11QTh2bG9JUFo0TmFOUWV3ZjJCMVNHTmhGb3Zh?=
 =?utf-8?B?LzYzK2VwN0ZUTEVPNTU3dGhIbk9Ib0FGLy9obUVqaEY2bzFJcHdYeW4yTllR?=
 =?utf-8?B?YlVRYWNlV0owb1pMZVBXQmt0amVxU2dIQTRBZWhiRi80WXJROXBzM0h3SmtM?=
 =?utf-8?B?QkxueGo5WG84OG43VHRxS3pISFRYanppeVhPYktRQmJsenpvZ0hBYkdHTWpD?=
 =?utf-8?B?RTNsNmFxWDlwU3pUb0s5YXVQMjBPalV2VzFrbEdIVVJWZ1kxNUd2Wk9XaSt1?=
 =?utf-8?B?ZHA1K1dib01SUVBYNExjRm5FZ3REaGlod1MwTmtpTHZqWWU1NkpyVUdVZXMz?=
 =?utf-8?B?S1RVYVhTU0ZEdmF3dFRoc2NKeWRMRlgvVU5haFE0czdHZnNLZlk0MFJRREdR?=
 =?utf-8?B?Vmptcmd2THhZZzRDdm1ORy9uRzExcjFiVUNLRE8yM3FpUFBiZ0xjMGVPMjZY?=
 =?utf-8?B?M2s3YmtobjJ3R3pNN2QwVjN3SHZsaHJMZkh2d1FsRUxQazl6YkdvWTdGbWxu?=
 =?utf-8?B?Y0dNd0NYNkRhekFRSzYzUHJnQVMrYStMYmNFOWR6Y2xKdzJ0cXh6YjhEbHMy?=
 =?utf-8?B?Ri9HamtJWlluMDhCMmF6MWNTeWtpSEhmT1BqMlR5STAxQ1BjNW9ub2k5RCtj?=
 =?utf-8?B?VFdDb0xBbFF4TGQ3ODBwN1dvb2dUL0ljQWJxNUFoUENmZWt5d2lVWEJzV3hj?=
 =?utf-8?B?cnFUNDgraDJyTU9MOFVJMkZUeGhiY29FT0xGcTRBaFhlZ3E3YnhFSHhxL0E5?=
 =?utf-8?B?MmZsQ1FYNUtKNmhXckpMZGVubzlYQVJVQm4yNEdzMkUwU2pMSGFCaFBZVmRB?=
 =?utf-8?B?WXJxaXVtOXBtYkFmWDhGK0lZV2FNYTMzczAydzM4czJwc1l4dW9sUXRiTlN5?=
 =?utf-8?B?Y08yNWNJWmFzZzQxWkNlSWpvam53cWVubTR4UnNsUTRtSW1FREEzTjhYSFBY?=
 =?utf-8?B?bnZuY3JnbUtjeGcxbVBHS2w2MnRRSmVyTWZhQjRKMjF1aGh6QnFiazZsbkts?=
 =?utf-8?Q?dKG2e7XGV7TVKAJhK3+cjON9L?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717168f6-8bd7-43cc-06c5-08de11de41e9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:45:42.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+VUSfA+g1V/fY9Dvu0MN68BKc9DzzqkEGQ5+ljQ5qaaqn577m2NeC0fO/Zjnei+XWDoi+OWyrBhT0O2WKzBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2879

On Tue, Aug 19, 2025 at 02:12:09PM +0200, Petr Pavlu wrote:
> Remove the custom __modinit macro from kernel/params.c and instead use the
> common __init_or_module macro from include/linux/module.h. Both provide the
> same functionality.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/params.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index b92d64161b75..19bb04f10372 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -595,12 +595,6 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
>  }
>  #endif
>  
> -#ifdef CONFIG_MODULES
> -#define __modinit
> -#else
> -#define __modinit __init
> -#endif
> -
>  #ifdef CONFIG_SYSFS
>  void kernel_param_lock(struct module *mod)
>  {
> @@ -625,9 +619,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
>   * create file in sysfs.  Returns an error on out of memory.  Always cleans up
>   * if there's an error.
>   */
> -static __modinit int add_sysfs_param(struct module_kobject *mk,
> -				     const struct kernel_param *kp,
> -				     const char *name)
> +static __init_or_module int add_sysfs_param(struct module_kobject *mk,
> +					    const struct kernel_param *kp,
> +					    const char *name)
>  {
>  	struct module_param_attrs *new_mp;
>  	struct attribute **new_attrs;
> @@ -760,7 +754,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
>  			params[i].ops->free(params[i].arg);
>  }
>  
> -struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
> +struct module_kobject * __init_or_module
> +lookup_or_create_module_kobject(const char *name)
>  {
>  	struct module_kobject *mk;
>  	struct kobject *kobj;
> 
> base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
> -- 
> 2.50.1
> 
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
