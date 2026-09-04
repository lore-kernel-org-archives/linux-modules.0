Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7684EC671
	for <linux-modules@vger.kernel.org>; Fri,  4 Sep 2026 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534806; cv=fail; b=OtdS03hOJFsOIHeWiyY5bC5/xA6ud5qMcNjGPzZMg4YC5AMiYZNH1BVRUDN5M0afUzb09ClGQ5818DV2ioPICt+doVCbzoeWmwbRYmNkMCQOhFXruagkR49knWFeQqTm/Sj4UxFtctVhkN7bQu2P3o/+RZFvi5l3C5BPlXrFgEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534806; c=relaxed/simple;
	bh=CqNjuiA8IIA7ta5Qx6hGC8IvoVcz3j63UWLQCflKfso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uf9MFT5w/oEufJpAxF+rZzCyds8dZGR7qmXkiGJmeeRJMBr7RTDRFgW0pu8b7ruC1ZqgUf7SOoNOOMsu0thuDjkAxKu8E8GEg0C+Xp0GQeQMAXWcQrFDXhmlu9R+nudwgxqqhwbJQKhEpBFWo3HJ1udqxgU65zec0HHwqwRv42I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsDv6D5GKQBh/ZEFuFvEDpSvkxAudmlQyN0ydFa93e/RB6zTYgL3LTKHxcs30mfUNjqRP4diEj0TcNt4Q3T1CE9McxnHpF4+roSBKLstJeuhkwuYNxaFRxrvJLyLzm8UZ+M3lfkHniSXqFXOFpDu16yL3dPN5RyKfkmtlEIVNsw9iepnXbi4WFTxiAvLU5/GIKNEmjBGz1ngdgdJ8u+Pblu3c/POzGR0WcRW/jY20w6efUoqJvc0QKxDX/sd1uj99Tzsz4wghEofDjxkK1m27jMB0oPMOE1cyR1ebDpo/FJVjo1aPCTpRXw6bFCd3UeYyeqVcjkov6gt3/1mde8xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jfs9NUkTG51XrSDKPqUGfclA/SnvzxH67XuOGYm4LBw=;
 b=xHg4Jn/ebhCim8cJLlDrMVnlkT/hyUTG0Qn2R8IFHRywuh+lY+Zspw0CQaRwxQQPXkdVh7DZkS3sQu3PfDjODeUcA0m81G67ih3JUpNoIGecL3lAQDdAQd5sqjjH9N3bmvJmfzKuIhTKzHbKtTRG8NZ0Zad1jLvJbjSj9FY06SYzt61IaHsQHD7SGbFymtRk2yQpur9cZW1HMatUukqACFBjAX/0DkdobOcdgDq6H7gEpIFpG3igr/MDOFPBrSBnB0IwJ5LydT2QV/8b69kxsUGGz73SHf4ynA9nbeOiWgQjerh/5v7fR39oIsmpkyDHpJC18bfNFTBGSnHCXOiwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8526.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 15:13:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:13:20 +0000
Date: Fri, 4 Sep 2026 11:13:17 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, petr.pavlu@suse.com
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v10 2/2] module: Rename module_blacklist to
 module_denylist
Message-ID: <b6vcua7y6t7gytrcmh7lspkkmhzqkmfhvgqf5mdrjxrlkxobgq@t47as2qufspe>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-3-atomlin@atomlin.com>
 <20260903190735.82B051F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903190735.82B051F000E9@smtp.kernel.org>
X-ClientProxiedBy: BN0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:408:141::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0e4351-10f8-421e-e6f5-08df0a970e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EvxxAseLiXRPp/ozF/5RiIW1MGZVuOCicL4/2wEgj/YxJ96Vz+9No6HgMF8WGwzcLei85evQ9Yzv5I/o1EkvaHi9Rn72Rw7xC460363Upj2QqT86oLL6PTkKkyRhnXVWZDEKuKq/8dIO50NR7WivMHTasW82F7fwCAq93fVkGFn5g51xflN2Q3aLjTWlFNq19/OCoP1JcwkoyT15yqmnCbXy8GPQiQ02P6kA8lZmE7bXDarscl49P5o+2Qu8cq8ml2K7DyzcExd6cYqnk5EF5eEnI1FdV/28KUDAtw7fJZ43GNbdclRL9cyFybJq/NmmDmUf1xSmDb++5gb9F0oub/PpqRPKckKw2nQD47WREeEoTDEgIuO33c3iWWKXVdl99D9uPGNWSWt0fd1I+3utiLqWPeDEZ6WSvQKdaNH6hb807SkqjTPW77pih0Bu1VsbWFb3AwNGZ6Ysv1rJ4q7icP2rRGTPz6aQ6hZWGjQhG5imng3+6I2+gcWDtDQVtGWgL3X+UxMx9ZZHALsV7eZ4i7v2/1b4wdw4xGQ0O+XOUxm7FSwxSm/aXpgBpCjx8HmA1Q0JRT7W+Aoe1BB9HSmdary8oeV2/a8C+WZtK9qT6s6mLXpUsq9DsKCFrvhZNWO/AubVFK62MeTx8nQVf2x74roRoAh6EEFNUpASEIkAiIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdpa0VRc2NOUkpFVnhEOXN1My9TaHBBeFM3anMwdmlTdzFOcEtyRVBHc3oz?=
 =?utf-8?B?YnhDKy9uK2taMHNGaGxtT3JPOXR3VkR4WWZ1QU45bzk2RndsYkt0OGZxSkNK?=
 =?utf-8?B?Q0FHRW1FY2NNaUp4Ym5QbVNSK0pKaFVFWGNlMUIwU3VUalhpR2ZsUko5K2w2?=
 =?utf-8?B?N0l2ckZvQjMzQTFKeGxrWTltWHRBTU5IL3R1UkdrRFdCNHk3UkF3WnRhZU95?=
 =?utf-8?B?MUpUdk81aGpzdmdGbmJvTjdsNCtjejZUV2Z0eDYwV1JmNGhZZDhnYm9TcWYx?=
 =?utf-8?B?WkR4UUVUNDdycndlYjJJSlNHUDZ3MUZhZzNoVFMvTmx0SitHOTdCOWJDY09Y?=
 =?utf-8?B?bmliRUMzVjlHTVVkUG1uUm14T01SaEpQcDNBWXpLU0xuMkViWVFQdi9EVHBk?=
 =?utf-8?B?b3N4QVNhcWdvdnZkaHdsMmt6WGV0SGx6ZmRNSkJWSis1S3ljRGxBclMvZFdP?=
 =?utf-8?B?SktnWk1rK1VLVmhUd0pJb0gyeCtPNXFJVFpjcGRtM0JCK0ZraDF4dHFZSFR6?=
 =?utf-8?B?YnBRa0Ftb21BMzV6QlJxZWswZVNzbmVSelJucGNKU0ZhUEhXUXhuY3lrSEZw?=
 =?utf-8?B?LzdGSW5jcEtsMkdiUE1ETC9oRHZMMzFEYWc2NnFCcmNTMktPbW5sdndpVlJs?=
 =?utf-8?B?TDFBMkZzYjVYV2pTaW04cVgwd1YrajlsanRBU3RQUkIrcktxYVJXa05UT09r?=
 =?utf-8?B?QzRyK2xsdGMyeWxmVVhJUEo3Q1hJQ0lrVURaRmpFY0ZkZnRsMmswT1Jya1Js?=
 =?utf-8?B?YmlXR3R6RjlleFNCMHlSVldsUWlicEc4Tnp2TWZwakkzWldCY1NrdUN6MWlv?=
 =?utf-8?B?RFEySm9aYm1IMmJ4ZW5Ub2wxdWZjT2VWRDJyNzhJM1p4RnB6Vkt2TUFEYTM5?=
 =?utf-8?B?akVWMXNpQVJHak95Qjk2RHlmbFNqcEV3L0xyUmZIdUpmbnhVeHdQRlYzeXBE?=
 =?utf-8?B?aXdscU5jOGRyU0xMcStlVkNsaHo3UzA1UW9CZWtqMk1VdG9LZTNheFBkYndn?=
 =?utf-8?B?SzZFaE1PVFNCODFnM3JuRVcwRmt2bWNVMThTNjRFTStXeXEwaVd6YUc1TkRL?=
 =?utf-8?B?S0xYd2JRUFdIeGgvNzV2QjFka2h6UUUrVVdEVm4yL1Q4TDVYZjJOTUU1YWN5?=
 =?utf-8?B?dm9oVlVtcXFIbFJQVTVNWExGWGJhU0RFOXBIRC81V2tNNGhyRmQvUjhScmM0?=
 =?utf-8?B?cGhtOHpyTys5elZBNGVwTTVUM0RubGc0alpZakwvc25mc3RudzJwZHpqQlJI?=
 =?utf-8?B?NnoyTFBpSUc3ckhya1VOTGpCZ2tNMHdNckQ3MGJJS28wRFFPdVhINFlDNEZB?=
 =?utf-8?B?KzlVd2tPZENYSmRkVEtuK3daMVZxU3ZHUVl0NjViUlR0eHlXY2JIeXpyL1Fr?=
 =?utf-8?B?UFRXcDhSbmFDNUk3dHRtdUtvWUlSOWtUZThub245OC9ONk9sNTFhTVJkK1Vp?=
 =?utf-8?B?M0ZSOU1xMU9CdytwaXFpVG5RUGVuZVdyWmJRVEl3YzZaVGtqNXpjb2wyVFNN?=
 =?utf-8?B?MWRROWZZZmJMTGw4a0J4dmZRajFGSTZRZ2t0aHRUWHE2NVZ6cGpaQlZYSzJG?=
 =?utf-8?B?blNBS01Na0c4bEJoaDNtQUFmcUl1YkN4cFpLNGRwNjh1Z01UaUs3YmxwZXJ0?=
 =?utf-8?B?V0tyQnJxZUN1aDRGQUROaDZ0L3h2ZVd3b212a1B0RTltNHlzZ0xVTWd4Qm5S?=
 =?utf-8?B?Zlh5WlZJbzMxcFN6UmtVZXRRb096Skg1ZVlhSENsRGUvazRLN2hWVzNhOUVo?=
 =?utf-8?B?T2k2dk1SMHJwWjByNnI2eU9FMTJadGYvREV0M0tyV2o1MWpJLzYvbjRuUXJ4?=
 =?utf-8?B?ejBsVnVlQVNhem5MdkhMZ3VhZy9EWDV4WHVNbzMwazlGU254anI3L2FONkVR?=
 =?utf-8?B?VTYrVlN3cEt0U0dPd1lCWElCamxJQjN0VjZheFZTZ0NDMHE0cEVUR1owc1Bm?=
 =?utf-8?B?MTR1YTBOS1ptcEpad0lRaVQ1eXZJQjgraHBjdnFZVHlVdVJEQkltV3EvK3BW?=
 =?utf-8?B?S1Z4UzNKQTVCMmZvSWRvTldUcnYvTjBaeGsxa01VYkgzRHBSbDc0d3ljT2ty?=
 =?utf-8?B?eGdSWldlV2Q4TnBjTVQ5RzBzUlpBSVVLeFdjRE0vTkFmWjcyZ2trZDlTTWJL?=
 =?utf-8?B?cms2WUZ3ZUtLOFM1OGh4VVZpZ1ZFcWdWamN1NWxRV3NvcWRVelBiSktTd1BE?=
 =?utf-8?B?TXlFOWRGWXR6RlBKVmVOMGExRTM3QXVQbXJub1JRbnpoRXpEdDdOSFM2UkZU?=
 =?utf-8?B?aTdaRkU2OE1tNnhCR2xJaGFWejVVTlBGSU1YckhTY0FaWmJhZTJ2QzRzcDRM?=
 =?utf-8?B?Qi8zWnJnMUQ5U3orKzIwK0k4Y0tjY0srWkh3KzFuQW5kaGw2V3Nxdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0e4351-10f8-421e-e6f5-08df0a970e49
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:13:20.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCKXisM6ATk1I1hPylbr99eNVOyuQWw9cJG6OcgyYDJKCf/yx7ppZx/ChOWFaPF1z+hGw253A2WkKAQLYubw8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8526

On Thu, Sep 03, 2026 at 07:07:35PM +0000, sashiko-bot@kernel.org wrote:
> commit 2df01653b8cde06423a15fc161d3df5e8eddbdba
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> module: Rename module_blacklist to module_denylist
> 
> This patch renames the module_blacklist boot parameter and internal
> variables to module_denylist, keeping the old parameter as a deprecated
> legacy alias. Internal symbols and log messages are also updated to
> reflect the new nomenclature.
> 
> > diff --git a/init/main.c b/init/main.c
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1347,17 +1347,17 @@ static inline void do_trace_initcall_level(const char *level)
> [ ... ]
> > -bool __init_or_module module_is_blacklisted(const char *module_name)
> > +bool __init_or_module module_is_denylisted(const char *module_name)
> >  {
> >  	const char *p;
> >  	size_t len;
> >  
> > -	if (!module_blacklist)
> > +	if (!module_denylist)
> >  		return false;
> >  
> > -	for (p = module_blacklist; *p; p += len) {
> > +	for (p = module_denylist; *p; p += len) {
> >  		len = strcspn(p, ",");
> >  		if (strlen(module_name) == len && !memcmp(module_name, p, len))
> >  			return true;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it appears the renamed
> module_is_denylisted() function retains a pre-existing logic issue.
> 
> Does the exact memory comparison here break denylisting for module names
> containing hyphens?
> 
> Since the kernel build system converts module names to use underscores
> internally (e.g. "my_module"), if an administrator passes a module name
> with a hyphen on the command line (like "module_denylist=my-module"),
> the strict memcmp() will fail to match the hyphen to the underscore.
> 
> This would allow an explicitly denylisted module to load, which could
> defeat the administrative mitigation for buggy or malicious modules.
> Is there a string comparison utility we should use here instead to treat
> hyphens and underscores interchangeably?

Since the build system converts module names to underscores internally,
passing hyphenated names on the command line
(e.g., "module_blacklist=my-module") currently fails to match due to the
strict memcmp(), allowing the module to load.

The kernel already provides parameqn() in <linux/moduleparam.h>, which
treats '-' and '_' interchangeably. Using parameqn(module_name, p, len)
resolves this directly.

Since this issue dates back to commit be7de5f91fdc ("modules: Add kernel
parameter to blacklist modules") in Linux 4.8, I will split this out into a
separate prerequisite patch with a Fixes: tag and CC stable, placing it as
patch 1/3 in the series.

Kind regards,
-- 
Aaron Tomlin
