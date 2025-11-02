Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D33B2A0;
	Sun,  2 Nov 2025 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107840; cv=fail; b=E+IR08EXEtbBVU09uZ2qEi3eGMEFIVyv6njAxE22e2BGmqe1XKUYENqCVQqOPz3q5A7SNUmeSyGy1HjGdPn3i8dUGgzZ3voM5DQljuz8diUNCeQ8OezycuEv8DU6BOC8AL9CjvAqg9oMsaDz6e+r4gCgpefzjuePF7ZeeKfsikg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107840; c=relaxed/simple;
	bh=qILR4hz+S+9ALWqC72yYZD2WNFewpNYFbDrst8XmNYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YuHv47apX6RTP/5bWJ8qPYBxfQiSMcj0uPAYpxzqGgq9rN7HVWSqbaxCq4C/L8F6GcwjTsdrIyHgYt/owZpntEfyhD81RPc63CbuLBaYjhov+/Z8HMM/EwwWNWy5zMkfwYUw/RzcOGPLg/ZhvprqWXT40HzjHuJt7lBbSmGwnBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbcBkvTvHOA4EdgDHe9N5PGfBZ0JK9S5RG8IbE/eIsZ1meNHQSkWitNqAjsvhCO7teMTbylAsIuOnnEAhvL2ldre1IQbvsY3zBAkdnTu+BX7SJr6v3HyQ/AuYBvAzwYs3GQl+ocTvMYBlAQKccB4ytO4YrL1hrx80ZR7gXbCNiscmyO+kVEe1IypZSXFOATtEGAiNLKRU8Yv5QJBJWQGA0qkDg3NvQcCFGxG6Ih8BaKNyhLs9ymT8Y3YBAQd+zPS9cr00U5VSu9EaseH5IqI6fDi0/Gda1U5GbHHPxw7qEWnqjG8cU9IlVuBRku6aXhItb+fJKys+apJ+YT0Z7pCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3krqG5WqXss9KDr9bUY6ulxVyEKdUCk/5Mgbj3a6IoA=;
 b=i0euAQ9w+oLK1QeedE9gxIbK6BPr/HFEV8v+kWso2qV4aRx3ejmlQIeKZkKZymHNa9yRkuzFVYPu/XviOPpA9H85Q2/p0Lgmdb108sBDsdPf/+UDw/I5hHQxSCXeFysDWdvs7R8QCnn9yzvCZIZU4nEG1Bz6YG/rUZu69YO6waWcYk3/DG5DayP9iEAXWzo4WrIeR2+J2dQcmi+92ZV+6NAAxiXfu9+5DU5Ivegn228JTxuBgU3+m9Z2jWxXBTeD2B+hUQ/URc4iEe+8pdn7QxCvsoSl8FL663tBJXF4hjLuqU+EGL2k4HwpSqk5hRbsZNK3ePh52n6hxfpPXXLMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8286.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 18:23:56 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 18:23:56 +0000
Date: Sun, 2 Nov 2025 13:23:53 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
Message-ID: <k4oueia5w5hjzusdcmhvimvpjcpjq4blhwc37y2w2luagdywaq@vrnknn6gbydo>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
X-ClientProxiedBy: BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::20) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cfbf56-d4a4-4ea8-48db-08de1a3cfc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU4vMTNabDgrOGl0QTBISVp6Vk13am9Gem1YbHJrUmNHSUN0dFBneXgzbGR1?=
 =?utf-8?B?RGxaWVpHU0hTY1hyYzJVMG5aT2x2ei8xblZQanhPNzJsTzIrV1dwelBoRUVp?=
 =?utf-8?B?ZUxXOWVrbHhHWWNET1FTZTBzUGhxck01TS8zRUpjRmp6bW9sWFk2ZHp2ZjJV?=
 =?utf-8?B?MGFoRVoyOCtoT3l4WCs5YVU2eUFMa3BRK29RZzMzUzJNc0d5TDl0aXVjSXlY?=
 =?utf-8?B?cWN0WEdSMFNvZ1FXWFRHeVhxZnpiMlRiNUhQL2ErcTltR2MyZUpyY29XK0xQ?=
 =?utf-8?B?UWg0NkJjeTE1OEgwc05xelVBVDJEYVNCd2FZVWkxUFMvUXp1T0FibWppOTRJ?=
 =?utf-8?B?ZHBDRzBtRGNxZjNPQmZCeUNqTDhNOFM5dVU4SDdLRWhzckRJMFBWeU9IWmRx?=
 =?utf-8?B?L1FSc09NUDhqSENIOFBCdC82WjRSUVMvQkRhclFYVm9IY3FtZVoyKzgzWEZP?=
 =?utf-8?B?MW1hMDBreHdOSHhXS1NWR280UlJscXFub2xVM1Fvc0Z0WTM4SEc5SFVQbjNI?=
 =?utf-8?B?VUwwLzNDUXREVFBTaFBmcjFWeThHQloyYVVueWtzczZtMjlMQXRxNFNKTWJj?=
 =?utf-8?B?aFdSMlVOc2ZwdGZ6ZVBSaXMrSkpHU3FVdk5tdDdMVUtoTFJKdDFoeXVXbnJ3?=
 =?utf-8?B?amRrZ0F6Lzd0dy9uRTJwOS9IcmN4cmsxVW04VGprNm5DenhLWXBFanA0Sm53?=
 =?utf-8?B?L1pWY0Z4NWxuWmpKVFpBN3dGb2U2eVRkQjZjQVp6K0hpRjNzdDhZSnpGc2VC?=
 =?utf-8?B?UHVMWGtrcld4Z2pSSlFGQVl4Y3I0L3E3b29KUWpOMjNqWXk4Q1k2cjUyQVNV?=
 =?utf-8?B?eEVhQmJsU25pZXZRRUdOMDQ4QnVidEQ1ZlJXMFRoZ3RqTUIzMjdydmlFUHhv?=
 =?utf-8?B?S3FBWHJLdGl6RDlhT1FnN0tUT0ZGUCtQd0ZoNTd6UWNWWFUvQWdPbkJKK2Q3?=
 =?utf-8?B?YjNOWDdlNWNNb25nK3BPWUd5TWdmMmF0bUIvc0Y4a2g5TFVFckxaeFIyMFpx?=
 =?utf-8?B?QTlKZjVta2dZR3plbEJWZFExY3lxNmthZzVVUXJZYSs4M2xWWUZnTGVPT3hK?=
 =?utf-8?B?VUFNT3NaYVA1YWQ5NU95SFNsaElTV2ZLQmcxbkRDdnBoRXJVTHV5OFp1cGxB?=
 =?utf-8?B?YU8yZnA4UXBqUnUrcWtOOVM2bXNMWS84eHhFaERBeGNZL0hHT3owRFRpR2lC?=
 =?utf-8?B?TDd5cmZKRHVVUzVPRVZkNitMdVl4ZUVoUjQ4VW9uRThNNUExSHlpcE1uWkRu?=
 =?utf-8?B?c3VybUZ4TUM0cERqVGxZZTZyejZkODBLeGN3NFFuOWw3eXJuSmJPbmFDRFhu?=
 =?utf-8?B?ZVdPbllRNk1MRVRzNXo3Ykc1SGF4ZlB5UHhMZXVxSHRpRmhISWNVWVRqRktS?=
 =?utf-8?B?eDJRUmJsTXRCNVZJTExmMFM4RG51dDA3Z0RoT3BJL2dYd01mVk1MLzc5eTZt?=
 =?utf-8?B?UEdLSElLN21hNVd0Q3R2VW93b09lS1JrVEE4U2lpNmxOa0VpQjkvOTVTSndz?=
 =?utf-8?B?bmVyYUlWU29VZHA0Yk1WNzlqVkZyRmlMR1FENkYxNnVKcmN5K1dnYUNOaDVZ?=
 =?utf-8?B?SnpEZi9MMVhLTGFpWEFIc0s3cVBRMzNGS3cxRkZabTNIdzhEdkd1QWxZbzR2?=
 =?utf-8?B?NzZLcnB4RUtMdUpqTDlxOW83UWtxeGRsSG9LdE0ycWlzbkdpT0N0RWNGZGU1?=
 =?utf-8?B?aWhYWGJGelVaWkdOd0VwQ2xWMytVcytvclpXTDdrN3c4aGpkYzZBWXk3VTVj?=
 =?utf-8?B?ZUNLWUV4elNIM0lQUitiUmQ0b0tId2JYZDFFbUVqU2JPZEd6K2Y1YkNXMDN3?=
 =?utf-8?B?R0dpcHJxamVOR0o1SGZWblBTUVV3KzQzWHlyUTh4YnVZV2lmaVBpMFJLKzF1?=
 =?utf-8?B?OE5JL1kvZnExZXl6Vnc1ZDZITm5BNE1aaENKbGl6Sm9zQ1VmNTdWaWFubnZO?=
 =?utf-8?Q?2MC0dXI7/mnOA9YjTUjn85UveuTMZe0I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05zTlprYkdtRlR0NGE1VG45WnhuUjZPYlpHK0NwMHhZc1Bhc2owaUFQNHNX?=
 =?utf-8?B?RnlKMi9TYit0dkxmb1VSYlY2VXA1VlYrNDlIN0R2OW9oM29GajRwM2xXZVhH?=
 =?utf-8?B?Y21LcXFKOFkrQzdkWjdDdU5kRXlodFkzQXQyVUVUQ2JBT0pvUkZDckZRV2lB?=
 =?utf-8?B?cVVOWXhUb3Q1TWttbGhpcjdFYWpwOWpjdmdmKzBFOGJNK2drUEZ1N1RPZkty?=
 =?utf-8?B?RFR5Zko4clkrdHZzS01wRm1idDdLL1VJZ3BWSU1RNDdmZmxSc2cvWWMyMFZk?=
 =?utf-8?B?SGY4a01GblVKL2g4V0JXSW50ZitJdWU5S2NaMmFZRWNUS3pxT25nZFZXeksw?=
 =?utf-8?B?TFo1OHk2M2NNQlBlck1GUm1nc0dsRnhwUmhZdzVrTGN2TFEzY2tGOHJpWkxl?=
 =?utf-8?B?VVgzQ3FXVTFPb3ZNQXdYSFZoKytmOEc2QXZYWWQ3R2ttcjFNWGtKc0N6aVcx?=
 =?utf-8?B?QW5jN0ZIY0NpdzNJOFpzdXFtWm1idmJlS3FqUHFVUFcxYVN0ekN5OEZCMFNa?=
 =?utf-8?B?SDByWTFEWUs1UlZxaGQyQWR1NkxRM3dVUUU5TlVzb2t4Wkhudkd4WldTRFhW?=
 =?utf-8?B?MWlLSnhGZ1k3eEcvL0hKWFQ2N05mem5qWERZMFVlNzN2bE45UDJKREJ4V1dY?=
 =?utf-8?B?dWlvaFRlSWpkYk9RbGNveUJCRFNsT3A1aTRPdVZ4Vk10ckJlZmV3aGt0V2RK?=
 =?utf-8?B?cGFEME84aWZ5RVA4K2gwcjlXb1NWcUtoOUtxR3hQQnZ6V3pvNldaOER5ckpp?=
 =?utf-8?B?Umk2YVludDNPZGdjcWhCYStuWDRZUVJ5WWpubkRicVlTZUpXQ29adHZlSlZX?=
 =?utf-8?B?bG5Sd09PNkVBRzExVlhNUE5vT01zUVFxTEdDUDNIUTNZTlg2WVRZTzFJZzRC?=
 =?utf-8?B?c3ZhN0hPRUdkNWZWSjBtOWxuTGV5bC9rcjlWN0xlWWRqUkxScUN5dllCNFYr?=
 =?utf-8?B?YVduNk16VVVOK091aDNia3NHbXdSYnNBeUIrL0JSdFVUK3Q4cHc1RWI0YVJl?=
 =?utf-8?B?b0xWU0JnNDRXNXg5S3Y3MVZ2eVFMLzdoMzVEeWlxaXlnUm9OaGdkYTI3UnY1?=
 =?utf-8?B?VEdFb1RjelpsYTdncnRSUzg0c2RUNnEvNm1aZklLQW4zeHFBTUVkdmxRRGli?=
 =?utf-8?B?Rjd2aUVRZFZjdE1YUU9Tejh5WHFHODFKc3EyQ1ZQWmUxWXBHbTJzSURSaDN3?=
 =?utf-8?B?WkllWEROaHlBS0xQanROTFZTQWpYZVc3NVY2MEM3ZDZDSDZzQnMyN0ovbERI?=
 =?utf-8?B?MTJrR2ZQZFc0OU4rNUZMcERnNEJHZHVoZVZzOFgzbTRTdGxoc1IzbWZpaXFF?=
 =?utf-8?B?cWRZcE5UY0ZRZFhnT1RacWhZdW5hczR3TitKcG15SmhIMnBpQ1Z4VmIzWEYr?=
 =?utf-8?B?d3dMRmNEanBscVk0OVJWdFNNK0FtNG9wZ3Vka3k4b3BkaHZ2cW5vZ0g0UDAx?=
 =?utf-8?B?bmhXVHh6bGw3K0hKYk54YklBc0dvclFlcnpONFB0MUVsVFFUK3pZeW1aSjdh?=
 =?utf-8?B?eEFPVmw4UzNmQWtFR0FCWjNkU1R2SzY0ZUIzTXpQaEhmYmlJY0crOFJPK3FR?=
 =?utf-8?B?YmFwY0M1enRHZzlFdzI2bFo0YWp3dUdrbVR6R3dWeG5DaGJxcTMrSzlOU1dV?=
 =?utf-8?B?eDhtRXlyWUszdWtzZGQyTGNGOVhsLzdCZ3J2Y3p1ejJldVhuNk9paTZIN3Zm?=
 =?utf-8?B?Tm9oWjlXd2dDWXZtY1NEWGVYT0NPcHN3K0pjN0dlN05xdnJNVTBjUGNzRnk5?=
 =?utf-8?B?Zjh3ZDdFc3F2MmlySlNzcklUUE1hZU01cWVqemxrWm0zTUpXZHo5ZnFsSk4x?=
 =?utf-8?B?WXNuQWtpc3IyMG1XY2RIamoyNGpRc2NieGg5NU1xK2l2L1NLZS9IWjc5dDNk?=
 =?utf-8?B?aWhadHZZVkpSekgxS1pVMXNVOWhXQ3FOUWgzNjgzUEp4MVdPajk5dk45UGtO?=
 =?utf-8?B?QTdWMlI0QXNzVC9NTTlsQWdCQ3RONGplbWg5VVl3S0hVQTJCWHlXV0dyRm16?=
 =?utf-8?B?ZHdaVTJCaWJHT2FhalhCVmNRL3FheEplQ0pST3diMHZoaUFXOGhvTXRJQ0lN?=
 =?utf-8?B?QjZVdG4wYU9GRFAxb2R0WWNiRXFwQUxNc1VUK0xjVkFyTHNaUkxqRGkrZHVL?=
 =?utf-8?Q?d+GLwwenMnzoleSr/bLpCThUI?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cfbf56-d4a4-4ea8-48db-08de1a3cfc47
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 18:23:56.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K02IWPcJaqPCIEeItybD1AQieEddzclMbUw28v6yH30Jaft+Pra44SqjDODpNPo/nElh00tO39213viovXQbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8286

On Mon, Oct 13, 2025 at 09:26:23AM -0700, Lucas De Marchi wrote:
> The -EEXIST errno is reserved by the module loading functionality. When
> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
> module is already loaded in the kernel. If module_init() returns it,
> that is not true anymore.
> 
> Add a warning and override the return code to workaround modules
> currently returning the wrong code. It's expected that they eventually
> migrate to a better suited error.
> 
> Closes: https://lore.kernel.org/all/aKLzsAX14ybEjHfJ@orbyte.nwl.cc/
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  kernel/module/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362..74ff87b13c517 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>  	if (mod->init != NULL)
>  		ret = do_one_initcall(mod->init);
>  	if (ret < 0) {
> +		if (ret == -EEXIST) {
> +			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
> +				mod->name);
> +			ret = -EBUSY;
> +		}
>  		goto fail_free_freeinit;
>  	}
>  	if (ret > 0) {
> 
> -- 
> 2.51.0
> 
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
