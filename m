Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022094.outbound.protection.outlook.com [52.101.96.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB72FD1DA;
	Fri, 10 Jul 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697838; cv=fail; b=NvsigTGvACYXE2b/6SITh7Y2Pe8f6AKvAdG1NDqf2ccNzrd8UJZuz0o7wgGdvkGJJHefs3QHeustdq3MN2BkHwCalBGJPxvQtjhT1DZAysXg9iDu4UDQdRdTcBk2manjryR4A31gKMy6EoPTvLIZxDWNWI1XAnSzo7O1oAl1seM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697838; c=relaxed/simple;
	bh=eeaQv4PVWei136J+20RqnNZXLrcMOr65eTAiRnRUUSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgXe152LgZYNtovQaf6imfcwE5jEgWRgAEyGMbOHOpG/frB0RdSXD2Y0ohsWVqb6mFUzoeJstBmjRNq07o/D0Lux/X2SblvYSoa1V3KbIAWPDbGUo4VUuH3XZsBBmb1lHqY5BSas3fpb+fIAKyYqJOZzE/OLp+WEe9MHBBkGMkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN+fqnTExGYyOC62PB+5a1AaMScSnlANXuPWjcCNuxzC86tH/VIWdHyu6d6PWjL4MJdJF8uk4ZsJYiBbdLdThe3NLwO0iLuK3lRTqt2D3ArYU7ryWcMw8mSt6jULyHc30vsEk1p6MLSjLECgaz9i3jGnypv4h5r6q8cPmb8qXalMvLCDdDFHuVGP++rFZ9wymgVqlH/oQ9INMnk59B/UbueWBN0hPP1tVD0/+MjJ2aEDMS64oDLpvrOhPixm7yKWVE9Id1WgiLaS8YExBFoJ1p9kBSeTbZBi1vCJ0cxGCS28SZQlGG4U2pQ4sWJNiYLCcIUMBoOkNU2zfUOl22RbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=j/xNTQ/svEh6KyJkww1qlxwojnW/hpEogX1ma4+22iI=;
 b=VLGjigyz4sDWiMtZzkkM0fHcpgSauda5otnxRVMrtBzCg+0+5NSYTCdxjUblU56WdANw4RjuTO04K6UmwEtHq9tWAwetupYk/h2os5SurH1DgiyB1+QOPbPUTNypljLVELkhRklz8ZsYJPEVtOLpcQSECjHbZfhWDMWhe0vh4GOLunYVI+lnlKqdCz5BTf+jFzWQtI4hoBMlUhwTO6qhAW3LAB1mWFQZ3msWC5ew8zy1TCqsToklXl2s+L8vECKRJfy5jwdeP05EbLK0gLLrsSKFC6h6q/3TS6jlnEaxQjixgrEJ/IWiz8VZsb2VpUmK49mFWoMICspS4p4lIFm+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB5884.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:193::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 15:37:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 15:37:06 +0000
Date: Fri, 10 Jul 2026 11:37:02 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Siddharth Nayyar <sidnayyar@google.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: validate string table section types
Message-ID: <masvkg7lr5o4alxc5f5xbashdy4jzvapbvobyi7bnuov5efe5a@wtglbs2pfoti>
References: <20260708012107.1621513-1-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708012107.1621513-1-tweek@google.com>
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: dd663617-5784-431d-ee9e-08dede9918de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W5CNeg2OTFVz+sbLaubMAjScK5Io9OHYiVIVNW6mGP5QyzyuaqRQK9m4CgktN086BbHjPGJlTwpj2nBsHgcyiwtZPcz0C6lr4H0sa1MClGWXxjC+5q0HVt1VUKtKmi1dKUONqFP4Y+/wKSnMdtwYO1KFZJ8uVKG2cVnPz632hXvS9DCBgTyNyIlvcQW9S14xIuzO9mchCS4NkL3QO3Wamf7Tv83KgQLgBDJtDStdKoXjSaO9WFt37u/Yy6HmT/aogGA9flFXcfwC0/DhRzMI7HBOKyg+TYQJzKrC1/oXmaKIsVh4lH5okF5aATnJDAO//4iwSk7L5swVmJJSSgFc+lqNkK5U5L6NH/ttlhPUYiaNdKUgcjW/Cw2V8knCThVeTRC9+v3ZCSdwgWEASBSmAHU7u0X2fN0qyW0pokK9Qkp1y0hEmMo70/3eXbH9HHYNRs69eXqW7BJ28evox08bszn2ch/Szi4W88FYEwmEOoQvaZ2uvimvswHEM7cBrYbgauCyTD5cmkUBVzTkk82spEphFgmNvQQUar2fe4vxDks6z/WKbwOSelLJCkc81ea65Pr+ZrW6daZpJzMRAbkdt8ERgU/VgvbsF/tStTzdYb4m/wk3f1mojnFuGmFN6Tr6EdCRhWAYgNa0yl7IMInN7hdPMbCEvevyKhuXgx+lydg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2c5cWluRy8rc3I1dTBTcWN4VmxUODJiZGFaeENPbERJSDdHZjBBbStNNHZa?=
 =?utf-8?B?azRRcWNPM09WSHVsRjd3ck9FNW1tTFRheXJpcTdrQ0dEN212QjVPREZBaUk2?=
 =?utf-8?B?Y1dXOUZ1T2lObmwxaXB4QllhMHh4N0dBd24zY0FHVWtuSXpGOVBTY2N0NEt3?=
 =?utf-8?B?c3JONkE3WFBTRlluZVgzaEJsWVhQa1I3WTF0R2hGQ2Z2NVkvTm9zZUFTWnNB?=
 =?utf-8?B?N25kK0RXMWtwQlcyN296S0xTbHVySnJFKzFrRVFLaDZrazZTMmR2dEl5bkJZ?=
 =?utf-8?B?Mk0vcTBEcVdTOVQ0SnE4dlN6cXRjV1A1NTNkdk9SbERPMjhGajdMeXlnTk1v?=
 =?utf-8?B?M21zNkxzdVBLWldyTnNOb1I3b1RtdEhLMmJqTzg1QW01WnhHWWNOZ3hDMk80?=
 =?utf-8?B?SW5tTUZKOGU3cS9DWnJVZkFBczluN3Y4L1lCdGxEbm02cVhpWXJQV2dUdHo2?=
 =?utf-8?B?S3dpT3Izd0pHRWlSQmlUNDJ5YVhFYmhlTU1RMEFBTTU1SXFaR1lQMmJEVGZN?=
 =?utf-8?B?SGRIQVpnay84RWxibEZsTk42ODYzZFE0ZzFDeDJzRk4vazFRbXQxYWpuTXpu?=
 =?utf-8?B?Zk1waEJEM0M2SVgwdkFGazNhNDR1VTFJbUxERVJURy9rc2NKcGhrMTBjS2hw?=
 =?utf-8?B?YVRBTkpSaG8zSjE2UGNJQWhJV2VPYkFENXd2dFJ2WUYwVnY0Z1poTHBiYW13?=
 =?utf-8?B?U2JZRUkxM1ExQVo3TkZnVGhZNGF0SlhDdkVVc3JmMUsrbWQvcFVFOGNLNWh5?=
 =?utf-8?B?dVB4U1R5RjlMSjNqcVJVYnJ2cmhvTFJlQzE1SGorRXpQZGk2UnJqOU41NXhs?=
 =?utf-8?B?UGg4WHVFRVdVR3Z1cXlVZTFwMXEwZXZwdCtPNXlMZ0VNWTYwSW5mUDh6SEJY?=
 =?utf-8?B?K3o3SXQyaHJvT2pkeERTVENPUHBvd1F2UktFMHprY2R5eG1FbTVvV21DQTlv?=
 =?utf-8?B?UHBHY3V0NEUvYlN3K1h4eVVKWnJoWmp1R0xseGtrdnJ3NUp0ZkIwM0RTVi9X?=
 =?utf-8?B?K25IelhNYU9lcXU3SGhrajlOZ3Y0dFFrR3hld0VYQVdOb0ZQM0pLaS9BN2NP?=
 =?utf-8?B?NEhyV0xBVzVsSHlwc3B4SmYvbUVYSlFtZlMwS1pvVFUzWHA0NEpwSFhXTTkv?=
 =?utf-8?B?YkxMdGlBY25SOUp2bDcvR1RxbDNlcnkwQTNLZGJ5bGFLZ1ZRMEt3OTl2eUVm?=
 =?utf-8?B?SFRhaXJWZXFWNmM4L3Y1SFY0bEwwVTkwcENXRUVrcC9KSk5xcjNlSnVvQzh6?=
 =?utf-8?B?SWowZzVxOEptK2RxMU1FSmI3cm5pOUZtZmluQVVUd29Xb3R1MDFmMlVjenZR?=
 =?utf-8?B?ZThsVVluYzg4NzhISEFDeUhqc1J5OEloSHExdncrNGk3cEdkUHFQUDVwQUpq?=
 =?utf-8?B?SXd2cGhtMHRPTFByOUFtSlZuVGNIYnRtNFFBckx6R3gzays4VC9CaHoxMFZp?=
 =?utf-8?B?dVl5QlJZUjYwVDl6NHlKYW5hZENwVFM4Nmg0ZTZuSGpUV1NqdkRSa2lZV2tI?=
 =?utf-8?B?MWMvV01UVlhwTENHMVNoYXdKc3MwQ3VRU3ZoeWlDV3V1bUQxMUxtWmVaUnFX?=
 =?utf-8?B?SmVXNEY3YjQyalZXekl6cDRkOUg4WGRaMVdFWFJUZjlzc1MxL0hFZ3N4Y2pY?=
 =?utf-8?B?R3RuMHpVdU1tUE81dkhmaklXdVg2TTdPRE1pVThObHA5YWZuMGdhSnlXNVlh?=
 =?utf-8?B?Q0JXQjdVeGRlOW1tY2R0Q0Z3Ymt3NzZGbVh1cGlHMUJvSkJnVUNkQ2ZMU25P?=
 =?utf-8?B?NWxocEtxckdYSXd4WXM2U3QvZTJxUm80UWRWLzFKV2FySDlYY3BTQng1eVE3?=
 =?utf-8?B?djRSTGV6OVEvK3pjYksrT2JsTHR5M3czSGJOQkFSbVY2azV6TjJOU0JqT1lW?=
 =?utf-8?B?dElHMm5rUlVTTTdnYzJrNmdwU3ZwWmhaayt4dTV1L2lMZUF6dTRSSlVhUVJy?=
 =?utf-8?B?TzdOanlGTm5zUndkUkpBNWZrcXlTak1ZakVnZXFua3doNWlkbGxWeGRpTTk5?=
 =?utf-8?B?YkZkeFBRbFVvY2tmU05SUzg4djVUQW1xUGMydzRDS2d0clFNNkFnV1FxMVFM?=
 =?utf-8?B?YnE1QmxnZ29ON1daZnVITDNxaFlpWXlYMCtyYmVIQUJ0aHQ4NWhlTVRzTTE4?=
 =?utf-8?B?NDJhU0J2TW1tQXZlSU1kckhibjRFam9Kd0xRMStiUXhEU3NkK0VWeG9JKytC?=
 =?utf-8?B?bHZiLzJQc0J5NFk1anFFMUUzT3BqcWV0a1h4Y1JpMm5qaGJtUmxSQUJqaHM1?=
 =?utf-8?B?U2kyd3l0cEtPVG9OSEhBNjNnK1Q1ZXFiZzZ3NDlTQThkZVlldW03YUVwRnFG?=
 =?utf-8?B?d2dsVE1taXBHQitsSWd0V2F2NG1FbkFTaEdLUnM0TGN0aXlrV2xkdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd663617-5784-431d-ee9e-08dede9918de
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:37:06.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76uJiTjCrfOF5sr9DrfkN2hIrDRTLqtVym8xu+dBoP/NnboaECw+mRBBAy1j3BX0W6ZNo3F55umDn+kys/bnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5884

On Wed, Jul 08, 2026 at 11:21:07AM +1000, Thiébaud Weksteen wrote:
> In elf_validity_cache_sechdrs, section sizes and offsets are validated,
> unless the section type is SHT_NULL or SHT_NOBITS.
> 
> Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
> access the section name table (.shstrtab) and symbol string table
> (.strtab) headers without first ensuring that their types are
> SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
> not been validated and may reference out-of-bounds memory when
> dereferenced in elf_validity_cache_secstrings or
> elf_validity_cache_strtab.
> 
> Validate that both string section headers are of type SHT_STRTAB before
> caching them.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  kernel/module/main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..7cbc8f0e28c6 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2011,6 +2011,7 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
>   * Specifically checks:
>   *
>   * * Section name table index is inbounds of section headers
> + * * Section name table type is SHT_STRTAB
>   * * Section name table is not empty
>   * * Section name table is NUL terminated
>   * * All section name offsets are inbounds of the section
> @@ -2038,6 +2039,11 @@ static int elf_validity_cache_secstrings(struct load_info *info)
>  
>  	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
>  
> +	if (strhdr->sh_type != SHT_STRTAB) {
> +		pr_err("Invalid ELF section name table type: %u\n", strhdr->sh_type);
> +		return -ENOEXEC;
> +	}
> +
>  	/*
>  	 * The section name table must be NUL-terminated, as required
>  	 * by the spec. This makes strcmp and pr_* calls that access
> @@ -2204,7 +2210,7 @@ static int elf_validity_cache_index_sym(struct load_info *info)
>   *        Must have &load_info->index.sym populated.
>   *
>   * Looks at the symbol table's associated string table, makes sure it is
> - * in-bounds, and caches it.
> + * in-bounds and of type SHT_STRTAB, and caches it.
>   *
>   * Return: %0 if valid, %-ENOEXEC on failure.
>   */
> @@ -2218,6 +2224,12 @@ static int elf_validity_cache_index_str(struct load_info *info)
>  		return -ENOEXEC;
>  	}
>  
> +	if (info->sechdrs[str_idx].sh_type != SHT_STRTAB) {
> +		pr_err("Invalid ELF symbol string table type: %u\n",
> +		       info->sechdrs[str_idx].sh_type);
> +		return -ENOEXEC;
> +	}
> +
>  	info->index.str = str_idx;
>  	return 0;
>  }
> -- 
> 2.55.0.795.g602f6c329a-goog
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
