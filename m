Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6E3F3299;
	Sat, 25 Jul 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784997061; cv=fail; b=Sf8Q9s83g7SHn1e5IeLVMKPlnQTN2GHsDKV1Nr44zPTOywWj/nw1KcYHJ6LI9/gcV1UJBgAWXbBmhieHnnvk3ne1WU4LdjWIOrkvH6XkeLe35rltgXcMXfF55N0+XP/K65J3hfiPkXFU8JDkMhHfPmDUdkujCLxGNK29bsO5RR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784997061; c=relaxed/simple;
	bh=O0I7lRRmneTyHCw4VGa9BGwMwpkbGAukfgxaSssK8Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D0/jXLGZuhxbojV0iYYAlGKnvyG+FlbL403Z58wIzXFqiXechOqVGMxoy/wGRNzcR09dIIYasYWV+45NKNBfoeXY0XxbMVhOntEE60/XHqP0G9ZKZTEDcFrTBHBUqF0szYKGHHFAhtP4p16O8lRZZxp4RanbGTLwcW5OgJEKL9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X404F8Lfb+Vo3raUKZ6QOCFB0Irc6PVu925dhNNxpwlAVXNkrVgHfojVfQJS1jqw68/5/NRfxwjobIph5p6AzYjZxlA5aj0dJc+8gllY62FwvEJ9Af7TN6HIIXKyfHbdMCRUtHlKuUL5cHLmtUc4ytkxll9BOC9Ubq89d358Isu4CJyvi4XpIrqQcK6A7uo7Xcu4pc8AAZoL2pd+lf4xuhoQhay16VpESi+xlaU+Cxbg+U42KpbpEIc+DEyiQgysCS3HKyNrK7hWkvG6bqQZKFBfowPu0K9ne0ZvfyUSP4A4Z7xbPAlMDy1JQTumtUMpPBNMrN7LFkDreZQyB06yfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Cdk0aca0iRXrVq4JcttqF7vY2R3oECN5dUlDHDawF+k=;
 b=wIBqj3J0jkqUGp1LxFgriy/JCIrm6f9FRM80+V9xIFhXn3mBzsSL8tBFXixPHM99sTtbzFAXrD9QL9y+gaJRm42GllmBe6LgwGb+tyzAeAcjMqlL09nRn60qnD94g+nadCgMTe+oHyMKP5ITilpmqvCBeJ9pZYNJJy2w3fhaSS9WtTDXJcoGBWrw1wrlKJpku1Lff7gH7KOxG9Fw+Y+kGtUO8NzECIX/pnh2wJjTJVUrVnMdz+MnUntcS7lmZBEztVihKHBKjx4/nhlVucTFzKy5r2CrqgltBMYkc5L80shCUw6OsEF/abe0b8p0keLa4zXPo8LX7SWenwTo3WszaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4300.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:16b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:30:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:30:56 +0000
Date: Sat, 25 Jul 2026 12:30:52 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] module/dups: Use strcmp() to compare module names
Message-ID: <5e4qydb4z4sxrdcpxq2sknwdjaibixmkyn3jqa3s3kfx43rnlq@ahfxhvvgkuh7>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
 <20260723-module-stats-rcu-v2-5-bd582261fae3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-module-stats-rcu-v2-5-bd582261fae3@suse.com>
X-ClientProxiedBy: BN9PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:408:f6::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856d427-38fd-4070-b0e2-08deea6a1a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9mb7LdH1hn2MKiUDItujV3ZSo4glnEuhajAfgk0bubzf2bAkl7xVwDBxAGLj1XP+Ux6c6U4qQHIrvzj+zhvL77KKJq5zOjTU7ikjIWaFPpNYkHexAIOz21Zke2b2UzHMSmJxy+LyuhQq9EfnROItXTircy0TXjuSNXjfEo13Ck4xeaNaRNNO3o85q35q1XzarokyACToU/3z13ylUCrK5D5L/nt6YE97sPhfHipl1rbCBj5EDE+S22e1H5FBIj8IcU29LZLScftOCPIVc2JzBa5tD9mvot2hpXF43MT1o4zTbiDUva3CBuHPm8GglIIvSrmxnypeqQB9aypQa4DSuVpeYTcogXnHHr6pLMA5dRqH98FmRZhn0cKo8xTs7b8Rpp2ZV7HBCB3OLevVOAWbIMO1MpNIa/C2mPzzeK2oHhHRCbQGAM/5GSoZ/eg21tar69BpCGgUQrnwGDIXh+ialEPFwMjA7nNGVQ4xJ0ttYF7M14BkIL2GThUcv+B/w/tPZcbMNDnWdT28gfyAEwIYJOLr5Ux7ml4ie2KxQHAHIi4UmC4eECdhAbLWZ3fxboULvd0JPJk2Jk3CdYigBz2ES73pn7Z3ifoNavWFxTaJhWkHoaMIaiSNFdQdl7gtDV6xS4GGWcXecBapO6x6meJbv3cNbOxepwMm5xYjMihLY5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUVmSjVPbHMyUGhPbGhac3F1Lzk2SWd4N1M0MUpIZkc2OHNnWnF5bHBITk95?=
 =?utf-8?B?NSs3OSsrZ2VmaE9aNUxnWnU0a3dWZkZ4ZnhnODdTd3JlaEZ4Nm1wdlJzOXNy?=
 =?utf-8?B?RGJZV3l1bDhIRW9Qd2hkTWF2a21mM1VnYzNCbSswTmF3MDdyRERJQVRtOEw4?=
 =?utf-8?B?MnErZnNGdWR1aWpjUzB4blVvNGp0RloyUGhsYU5rNVhwMjZhd0V2cTY5S0h0?=
 =?utf-8?B?Q0JONWJVd3N4blB0WUM0V29wUnJCUlh6TkZsaHJlUkU0YlowcGhWb1dhcVp1?=
 =?utf-8?B?eFdHTWZOOUswKzREUlFhZWJJK0FLeEtYaW5TWW9wUkZpV2RNOFVlbFRPWVVx?=
 =?utf-8?B?M0ZpSUNpUWRiQy9WaTI3dTViSktvYndWUEdPRHh0SFdzY1VSaXJiT3RLSDFQ?=
 =?utf-8?B?OTZGbWh4RnVBVURFaHJldEZDYWdnQTlud1FUOFlhajhtMGRQMHZJRUpoMU14?=
 =?utf-8?B?ckswQ1ZCZnJMNytMMjY0QVZQOXViZStvMmxoUWE5bkZWUHFXdy9GOFM2T2Fv?=
 =?utf-8?B?SzBVcFU0SlpFVU9Pc3ErMGZ5azk0RE5rTmRBTGk5cWRxU1NEK0ZNMG1vWlZu?=
 =?utf-8?B?Z1lZV0QrbzJZNjZtcnRSc3lkN1BQVHlNRzVKcTJBeG1NMHZQMnVZaFNYZzN0?=
 =?utf-8?B?S2NJbFVyT1BZVXIvcG4xQUh6RXpTTlZScVBVOFNCOXJNSUNwd0lFOXpibVBR?=
 =?utf-8?B?RXV3QkpCN0xOMENKNFJGaHZSMXVFVkhwK0V6aWUwSGlnRGNIbHcyeUlYQTk4?=
 =?utf-8?B?OVMybnVUcUNIb1hRVzV6cm5rMVRDQU5pSmNWdWQ1V3ZkbC9XTHcvWW8wRllD?=
 =?utf-8?B?Y0lacHE5dDlsSWVUdGZDVk4wMVZrbThJLzNiMlI4ZjAySEMxZU91dC90VTZk?=
 =?utf-8?B?NjZYL3F1NjRuYXo5RnJaNXZFSFY4ZnM3UmxocHd6REw5VG5GRnBOa2tlSEdN?=
 =?utf-8?B?Sk5DdEVTa3gyUlUyNXZwN1hGdFB5U3R6NVpEZzRYT2VuNUk5V0YvRk5zSEJH?=
 =?utf-8?B?QmUvTUh6ZXJUc3pyMHlmTDF6d2Q3V0ZhSVJ2eFhEWHZTQ2lSeGxVZ1lqNmdZ?=
 =?utf-8?B?cVZxZE5qdlBNcnJNb1N0My9WZUEvZ2VnWndFUmRMZHA2eGU4T3lFUmRIcHo2?=
 =?utf-8?B?MFVVK2FGWEdoVWd3dkJlODd5b2phMWJGd0l4am84UkVSQlFQeDhkR3hhOWIz?=
 =?utf-8?B?L2c4ekJrSFNxTVRvc1hZUmo1T0N0OFQzd0k0LzJOUFlmSmppbW53Mk1LbVE2?=
 =?utf-8?B?clRWZm5tYS9Xa1Y3S0VNWTY1N1p2UkpHYmwyaEdCNUpISTlnSmZXWnd1Znpk?=
 =?utf-8?B?ODdZelpwTU5Kdkc2STdhaHVXaVV4NnVMU1l5SkZoSWxiTFRSODF6OEVIdmwv?=
 =?utf-8?B?K250YjhyU3ZUYVkwR1NudmNIQ2tLdEdpUGdEOUNXNlF0dDJZU1pqZ3BFcmxv?=
 =?utf-8?B?TFhuMWJtQVQrSFVyUFVmYVJHaUZRSzg5WlpMdXlzVlk4TDY2VFFScE01NDcv?=
 =?utf-8?B?amlYb3N5cVJ3VTVKWnVQU1drdHdTMyt3S0FRWTZ6UGhZSllIdVZiek1jMXJK?=
 =?utf-8?B?YXk2Qmo0L2h4M1FZSjFZd3padktvWTUvTU11WFg1eGl0Q3Y3NUhZOEp6NzlS?=
 =?utf-8?B?TmNwR2RsVW9mTnZDZDBCbklqQkJteHRxS2Y1dkxTRlJMRXUwYTNma2x5YlpL?=
 =?utf-8?B?V3A4Z2dlU1A1M1E0ZzhUWFdlY1BWN3R0UllNL29wVk8ySkNBMjJyblZkR2ZJ?=
 =?utf-8?B?TjdZQWEvZXorV0tudHV3cHdIa2REZjJFR2xEd25VYlRSdDMvQ3MrNTJ6Z2pW?=
 =?utf-8?B?NHBhMkFiU09MakJEZnVXVkMrWXdNdnBXSk42Q0FTeS9pODZheXpHUlNqSG1U?=
 =?utf-8?B?OGlFL0ZmN1Y3OHJDRWtTWmVBMFp6cThjOEVhd1U2ZGtsM29HVWdJU0pDWDBa?=
 =?utf-8?B?RnhKY09rWktZdVFUclNBV1dpQmtBNnNla01VL1F0YUZsVEpGM1NTOGdxNFh1?=
 =?utf-8?B?KzdFM3ZhZ3NTcWdFR1lxMEZNUHdFd2Vxa3ZwV0xzKzZUbWNRMnlkRXB6ellD?=
 =?utf-8?B?VjhlaFovaHhrN0d6WVRFVlppMHN1aitLQWJjMjVjWURJQWFnVTREWk90cGxl?=
 =?utf-8?B?dUZZSnFZcHJGWktxUWQwdHNpcjVUMk9ZT2VBT2lsNVg3Qng2VXRNRUo1dDhG?=
 =?utf-8?B?ZG0zek54SnZGMGJwRXhGL0t1Um1NTFJjZnZ2SEJCZFd3WThQWVc1MzJwL291?=
 =?utf-8?B?TlJjMEFNc3BTTVAzckRxMVkxZnZMcThYd1dmdUlqLzZ2UHZuVnJobnVhOFBQ?=
 =?utf-8?B?Qi9wYjM4MFNsaEpFV0FEbFE3b09QTmxYU3JRYnZ1anM0bWxWTTV3QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856d427-38fd-4070-b0e2-08deea6a1a43
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:30:56.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnp+ETnrUvH99HiFTFgS/09Vqo6xj+J6kecwPLuBEIP+DnwbY1YZr6jeOnKE9wWU1K09bWznRlO2xzeN+EfAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4300

On Thu, Jul 23, 2026 at 10:25:55AM +0200, Petr Pavlu wrote:
> Use strcmp() instead of strlen()+memcmp() to compare module names in
> kmod_dup_request_lookup(), since all strings are NUL-terminated.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/dups.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 56d659f049c5..80e1638ac34a 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -72,11 +72,9 @@ static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
>  	lockdep_assert_held(&kmod_dup_mutex);
>  
>  	list_for_each_entry(kmod_req, &dup_kmod_reqs, list) {
> -		if (strlen(kmod_req->name) == strlen(module_name) &&
> -		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
> +		if (!strcmp(kmod_req->name, module_name))
>  			return kmod_req;
> -                }
> -        }
> +	}
>  
>  	return NULL;
>  }
> 
> -- 
> 2.54.0

LGTM.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
