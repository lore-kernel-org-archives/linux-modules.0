Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792509032;
	b=iWqhhLLyuATUKbfszTuR6dgqeg/8Jw1ddLMXJRxSztMYa65wZX3zK7rWDCoDu94sncl+
	 247evzXzghmW5NrBlQVQ/g3/zbw14rTf0R2cvta26z9+Dl5NYYz2QdOPXvkuZLbmX4/yZ
	 v7OJXVx8i+SltkPCBF4B3yOFBEm43MwYS8clhRLl9+4Hguq2QmaXWPGwCUVQlCBxc9Ywr
	 E2uzwOJ5t3NEuMOvJK6ipTqcFYi/IvW4AsiMhfQH5Lh/C82+mN947vKosq49W4+iS8Axp
	 UIR9L7hlAUVGHlzg5rRg6GA1q/+4IZ5LBhXsC8gefltiuQr51rCXRXaszdGArSS8Rkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509032;
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
	bh=vLUMJko2hAVgdKOq2C/MyrIOnObIfJB9MSPRfOsTWvo=;
	b=uIqNXwS9rHyuq/7N3Bjev2l0zop/WVVfNSNQQpBPOfHhbP7qxlfVBrpZJKYuhzyZFKt7
	 IDP5I6OnelrkJJWEr6bTwj3OBKBRidvKK4eMmNCXaVyrGfi2VcmzzU9ggy6bYOb3pV4bi
	 5h1UaC/zIz883RhnaGtt2cq+tTSC0dVdDhXPdtd8+8e0ucLCZozRgKEqM86VAjZL01Bfa
	 N1ABij58gY6ynSHdBg+lmWHTwXbe+kp0usTok+e9KC8Vvd3tvtCRcps03qeYOLeMyVQ6k
	 dRum7j1kmxwaOuMfnQ2+Qp7b4tcy/9ZrYWbf94XI1MAw6jMDWmhJz/XuX3rI1QcwisQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.72
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020072.outbound.protection.outlook.com [52.101.195.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD3606A31D;
	Tue, 20 Oct 2026 15:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqUxLIuCyCpBBWOXVHIse084BTHOdRit1PRxjYnTeGmYCo4r2f1pQyI2BMO1TCNcFiP64aXf/jZrLlWhaxEgpiUjpDcj3IlYS0n5nenrHSH00oECP/KiPaUHvFBBlNcfxOaGQ4b1KLYY5iYflVtWpB8kmP7paWJ8DQlm1LiLsiXW6GVHdpmBnZwgQJzukoCkIi9nfwYTWAmylch6soEc0DMtLuGyoYbFL2F27BDapwSd5coM/gOxYhA5+HRD5XD4rEzmzStyfOGv//ppRIkpZBhj1u+QyZGe0VTG8TDVGoZHJgtC2VEKOIv2SXJUOtS8+7cxI0hZZMfsyOqy5KCGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vLUMJko2hAVgdKOq2C/MyrIOnObIfJB9MSPRfOsTWvo=;
 b=dBpPp/mK2CndVu773XuqK/NbRCtRddRYuXxQi5MtInxdD5ugnPvLi+EhnCuMsGe3pV2jorIcpUGIN/fzPhPIDzmzFNpT7B8EmlMcZqJME2QlRYEOsDJnhv/OoO93xZ62Xjt1NXDZ47mfHOl0w/x9kf14Cf1QENTy2v6Ueia0zIwsISzlNz6KrDvJ06Tzv2o5MXnQBu739XQDD1JHsR/K9fR3QhtAbh/0brTeev4PH6GpNW0OHMlKbkYpi+yMuWowLZRF0dppS6LSCUBp+Goq1GRqz0aUJT3yhMXuGXBgmC1L9QfbCo9ERBLJKDjqU2UxLjl8R+oVyQ8Hk5t1JWMF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8258.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 15:10:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 15:10:29 +0000
Date: Tue, 20 Oct 2026 11:10:26 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] module: Fix missing taint flags for unloaded modules
Message-ID: <nbkd27f7jcpobl6fe7ix3kfc2fhhjdyathb6vwf7imp3plio47@25wfg54utfof>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
 <20261020-taint-unload-v1-1-d1c764889afc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-taint-unload-v1-1-d1c764889afc@suse.com>
X-ClientProxiedBy: BN9PR03CA0561.namprd03.prod.outlook.com
 (2603:10b6:408:138::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 083b7b0d-49f5-44ac-a804-08df2ebc4753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	D+AalLZ6GrNXwi65d3hK4xn/yYI8MwJwLt6VfQGW6T+4lC0j0CoOa/DohaXDH8bVLLhNaSTSMtisWr2R2+M/FnwLesVEXmVGTc0oLOzbC23HIWi2fBfzE231lNsOH7KMAPW9m8RwSjKqQXEoMp8OHjx97TonCcKTpIuCalkJhPDAictExV4VKgwmexEp6KFC561yOdQihFfGZS6EkQCgioxU7XLLR6nygMo/GGNsqMZZqPIHBucc9ZF26pUMVYxOTQ7bVEozfY9fHY4sCc1X7Hk7xiIPGC4atqFMPD2USrFX+wKCUeWOJ13uFGCqZw7+KaCWRJCkFzlpVZY8UmKK+CuXhM7eJ6dnR1r4vR7YnvarLShqLtI2AERcOp/E7IdGYOnM1qAbgSR0y2M02rwMAc24ETArBE+OHohQRdmLsIz7xBWAs7iRXu9STUa/NUCNKsjCNT41PjnDxhdcTR1DzF6xHRMyxJPUyrOVpptF16He0BHFnsyi8osoo5coeUJbfm43G9kX5QLXCqES/O6Byes7zyX3hD7tsKhWlgP+CUegzTtREYJ0NjVP3jfCeCoySvubBohpRQsCGaootsCrNA+3RPuwRag/YHKLxkmoJZjINSohAXcXYER0TRjGQQl8YuY2Dsad8mRd+KJopbHRgreeadjo9Zz29ysMxE2xxmc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlmUmdCOWRCSEVGdFFNQ0ljV2lsMEdTNFpKU3FGOHpJUnd1TnM5eVhINnFL?=
 =?utf-8?B?dDhwd1BqRjVnZVJtTkkwclFrUndkcHNMeXp2aCtKTTZOSnhtVXpINUdJWkgz?=
 =?utf-8?B?eW5oZXhYekRwc0NHbGgzZGhMcXlkbWpkWFJXTDFFSGozVjROd3d3RXdrWmV4?=
 =?utf-8?B?NHhwTmEwQjdKbi8xcmhUL1Y5cm02ZTlmUlJyajBRSHRqenhhaUFUcThVTEsx?=
 =?utf-8?B?d2RDeEdZejN3cG9UcnpRT09RSm1wdE0wd08vQjRQVDEvQy92SzB4VUx6ZzNM?=
 =?utf-8?B?ZXZWUW96VHJOK0RnUTFJa09UM0RTdnhPangrTjhoTVBBRkYyRVptRUR3WW9w?=
 =?utf-8?B?WmRySVluMlk0ZFU5UnZvaVJSVVdGNEpvMzREbG9ONGlhbzNoTmlKcGJRTVJt?=
 =?utf-8?B?M214NEJGZ2ovTnNVWFFFZUFmSU9rcDBHRm5ZdEUwQUpDVW81TXlXMG81RkJh?=
 =?utf-8?B?cEtNdlRrelVEdHZhZFpsa2czZkVYR0RZZWR4RWo0SDJxN2s4L0hxaS9oMWxk?=
 =?utf-8?B?RUEvbTF2bytUOTVBSUV4UFZDUTk3R1FDUzZ6dUNsUjZ5bU9XajluVmx5b1Rq?=
 =?utf-8?B?dXoySlp1eHZyRzR5Y2tPTHJnM3crOTRqNURIbEVQcDhiR2c1dmp4aU1rU1VC?=
 =?utf-8?B?WXNmNENyZTU1Yzl3WVlsT3J3b0V4bWZPaWlkaTZGVDJ3S21KbVg2czRKSjRQ?=
 =?utf-8?B?aXRjSjhaUUx3elRDU0lTemlSUTltcVRhRzV3akgzYldiT0VIUjFYV1VoRnJl?=
 =?utf-8?B?TW9HQytVaHhrd25qa3JuYkt6RThlamVIc1ZsTVRoRzdFWmxFRjFLRlJaK2Nx?=
 =?utf-8?B?ZncrMUtQTnFjcDZwTVhhMDNuYXRTeENlQUl2bityWEJvK2VMZHduSkdseXpK?=
 =?utf-8?B?ODNDbGNXY3NCVHpuZXpUMHFob1BielpDQk9MNmRpd1JwM0tiQU1tR2ZVanBP?=
 =?utf-8?B?alNvTkdkeG9HeGRUVDJWczBhOXl4dTRnWVdtcVZ6UW9GWVlJMk85SndhS20z?=
 =?utf-8?B?R1JnaThSdHBUUjdPbGxCZVZpUHc3QW5VSUxNOG9SWGhmbkwwcHpVVW9aZUxh?=
 =?utf-8?B?Tk5aemxsZmczeUhuNkxxdytsdDZSMGU1NGsvLzBIT0F5T1hyY1ZOaGIxVkdJ?=
 =?utf-8?B?N1Bia05rVG0xZENoZDNPVWJKRmVvdkplZHFGRDkvdVFVbXlUSGcxNHVvdEVK?=
 =?utf-8?B?NVc2MjhVcVhWSWo3UU8vTnNSY1pFVkpucGhFZ25IY3dreEx3RFhaSFRXbTZv?=
 =?utf-8?B?ZVY2NGJRZHMzeGtKZ3dWMjBYSCtUVVpoVXJrOG0vSTVWTEp1d2sxeFdnTm44?=
 =?utf-8?B?VTQ4Qk5ZQzNzdnJKV2hHMkpBdFVwMnk0aVBmWTQyK2I3blV5Q0R5c1A2RE5T?=
 =?utf-8?B?OTJKTFdJUmdrcHl5aGd0d0x3ck1xZGFJOVgySTVBZ0pVaVpzUzg4NDhYUHhL?=
 =?utf-8?B?Y2p6R25YNHB3OHlXM0t4RXJxRjhmNFFvb1E3OHZ4T1V4ZTkxZlZTVERGYUJs?=
 =?utf-8?B?ejJEbExzWG1hTEFLbVNJamgvSEkrM2ZHQUFjVDk3ZnBueWNkNE1mSmJ4cHNV?=
 =?utf-8?B?L2p6ajlFa3RBM09DdTU3TUxwSXJYWnUvZlFwM3pEbDZOZWpmbEhVcWpSOGkz?=
 =?utf-8?B?QlBTcHVMeWxWWEMyK01lSHo1RFRxQUxPdE95OTBMaEdmN3poWDM3YTBKajlF?=
 =?utf-8?B?OXZTVFc5RFZkNkVLRmM0eEdpb3RLWjQ5U241bWlKSG9VRVdFNnJ2c3dCczdJ?=
 =?utf-8?B?ZWttMEpTS000KzU4R2JZMDhaUEpDWTNESG1TWVN3OVFCb3VqSEZsaFFhNnY5?=
 =?utf-8?B?OHFjYkxJS3M4ZVZheWZyeFpuQ3lFbUx0SDJnUncxUFB3VHRIQ21WYzF0bms3?=
 =?utf-8?B?bU8xWUowcWF3dk5SZjZaOGNxVnF0M3hUSFpzekltV3RlWTMwYUxxMU1RZkF4?=
 =?utf-8?B?cUNuVHg5THZqdDJ2azY0RlNjc0E4eDdPUVFZamVybFRHc041WmZSV0Q3RGY4?=
 =?utf-8?B?MUNXUkdpRVdIU1pjUnpHajNWeVRVVXVsRUMzYWdKcWJLdzk5VitnWG1EWlov?=
 =?utf-8?B?bW1pdTh4a0x5WEw0alJmWjBkUEtELzY4TXNLMHh2YUJMekpJN20vVkUzT3Rs?=
 =?utf-8?B?K2hEZ3B2SVFoUzJaRG85ZEhVZG80TUFBSkp0aFhsc3V2SWRsOWxHZlFzZmNK?=
 =?utf-8?B?WGZsb240c1g1NnBJQVJnUFdBU3hmVVJFWE8zYnhUc3FYSi9WUXZKMU1hQTJL?=
 =?utf-8?B?Vk1oOVJQTGlwOFptL041YnY5QUNqcmwvREM3MmJzejJzcllGRjg0VytNYWRj?=
 =?utf-8?B?MkY4QnpLZmhWWlBNa3VsY3V1T3QyL3Nxekg4YTgzblgyYmNQSzF6UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083b7b0d-49f5-44ac-a804-08df2ebc4753
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:10:29.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwF9k3xujPGUL3K3kfAZE+gDQ+eRgKOZRsDzIvJ0GLYNS5NfJ+Lz0nsiW73Or7qg6xchK+Abaxn58JobQ4rXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8258

On Tue, Oct 20, 2026 at 04:05:19PM +0200, Petr Pavlu wrote:
> When recording taint flags for an unloaded module, try_add_tainted_module()
> can fail to record some of the module's flags if a record for a module with
> the same name already exists and the two have at least one flag in common.
> This happens because the function uses 'mod_taint->taints & mod->taints' to
> determine whether to merge the new module with the existing record. As
> a result, the final report may not provide accurate information about the
> taint flags of unloaded modules.
> 
> Fix the duplicate check by using the stricter equality comparison.
> 
> Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/tracking.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
> index 9033ff54c4e2..5bcd1c2701f0 100644
> --- a/kernel/module/tracking.c
> +++ b/kernel/module/tracking.c
> @@ -27,7 +27,7 @@ int try_add_tainted_module(struct module *mod)
>  	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
>  				lockdep_is_held(&module_mutex)) {
>  		if (!strcmp(mod_taint->name, mod->name) &&
> -		    mod_taint->taints & mod->taints) {
> +		    mod_taint->taints == mod->taints) {
>  			mod_taint->count++;
>  			goto out;
>  		}
> 
> -- 
> 2.55.0

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
