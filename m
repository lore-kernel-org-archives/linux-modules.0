Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021110.outbound.protection.outlook.com [52.101.95.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FA49B1FC;
	Thu, 24 Sep 2026 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281705; cv=fail; b=TtM8pvS0z3qD4VQfEuQj961xKEDWXAnN0AUMn3bsuDVn8vK5AiUNqCWwP6gnNbrV/JfOzJSyiX3623SXcUxpwGFzQwnN+tbb9Kikswlk9boLkpSP8iDsrpRSFyq0/VFq5Vip2L9ED1ZdB8MDZ8R/PMiT1YkyTDCXG1jC3AA9Eeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281705; c=relaxed/simple;
	bh=/Pr87V4yV5QdoRAAAZIGkkbPnji8/k6xWtaeNdZI5Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NwlDQRZuQj8qQZIwG1kA6za0RG9/70cWOVsfhzKG1ZVZ0sAqpnIsCXtTvTiSbtijLifW+pXUFRpH01E+7iGn/ZxI5YEqdveNjEEmBWix+6zUwLLJtiPaHsyiWtlNjzBi8nnmc7+USgs8BoAEERrt9eKbp3cRhpovNhDEaAa3v9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC1aQxj+0rRfMuc+S+AykSKrQcYZR5RoeuysHQSGayXlBGf02GbsmgDrlfWWYrZG4ABUidRzhbFZlkEMuvaPSCazPc4GS6mIWd18ctlWZ9LOf4zbJ6ROH8rtXon+kBxRsUbNK6f5JUoWlul1zdEcXe4ARWLC0m1/I7G0QzAcdrAxXu9GRpGTAHMDvmTEKT8kEjwwXELDeZ6O+2R4NNCrG741ZIpS4nvKlE1Z7mEUZgOlygX86XaWo8fu1xRqG0ja4Ply5Mo7udKVfvQkdV8wiJiIRBkhx/2Voj+k6IpgwGUccIly7qE9sJeISIkpSNDVYdAfy3GP4r8HO2aiuA6J/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=bhytgpVnL6mvOKCFA5hrBzS17irb13x2oSFuGx/iLcI=;
 b=EpNi740LsIJnCV6P4JgIsNUirosPcDYZBnTkQexYlClKOQ3+o9p3/SbHSP5lKJnb6lJVV5trCtuVug6OGOV2XW1KIbbc3yKzu5WHZPxoOTfbzZT7DMna6BZt8kVF46I48Nm4oqPzLaXuO9DenCkSvv67IBjnC4SBwPneEmsVldtrvLngCp3kA3sn58Np7h6Dv1/gmjs6XJ01yzQlDjhjuxzhsD/y55jGOJMsHNa8aLp/0D9mPJ8VchFxryLWDelwwfqee1XKsZMb8PioT6Jdi/QwLdUEsnMMPrGKNSsD9fn7Sa7GAmYS2FhLmkoic6dDcD15EkxNLJtLJQT+JvNECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3180.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 20:28:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 20:28:13 +0000
Date: Thu, 24 Sep 2026 16:28:07 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-modules@vger.kernel.org
Subject: Re: linux-next: build failure in the last build
Message-ID: <qascvrv6wprgcnd5rtc2n63ryq23exbzfcshmejmk4tapmrbnc@rxce2vktppvs>
References: <arVxd8GejREjgvPt@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arVxd8GejREjgvPt@sirena.org.uk>
X-ClientProxiedBy: YT4P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3a408d-4242-4ea3-5c54-08df1a7a5b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yrCGzgwO9MYDlpHijE7uA9S1E8ErInANhZKoIA/4D6VgX5CtR95trYy7ARBZKyR2sRPfJtbSSokBw1G1eJI0Lb4ahnWomhKH2bUqZo+R4PZM6zl2CbvUhG8WwYC6DBzHsitY8JCnI0cPthRpE0cMK1DMjDGRK1nyaNTQLQbsLCBoVTWea1OzTggZ+EoNpQb/xR7UKVMsopNkD8037iY9TTOCYoy2MeymdCU394P1a7qGMa5WyQRNnGKV5bnNzpAL6v32V9z5vfaaZUXV8jiAqCgL1fv+GJ4AklUIiZrqB9/5vsUzh+UMjickzEqHatdhZwa5bh7WxMODdssFNiEfuGrMW0xOISOpQtcQQAE9cziT6+ok6WsBRtppV1ycKk9xGQgYR/mEt9gKqgnROTwHvDvhlTD7smK1J0xPtMPeqCvIhj4espxJ9UR1apqxDZhwXwwRIrJDwxCyWbz9z+P2HmPTQf3EkBzjfO6CSjWnhOK2AvSvCRlltFl2cr+ksejhQ30d5Oc+reb1d7Tz2EAobzx1X9i8hzg3Xy7kR/EXwQQDJniRq8gIJ7d+ASzv4aFEr+uhx3sy5B5bDTnyUWn2pC5Kuvrh7Vz3/Ri0EMGf6cQ2U2RcpiozAHS8zUjrAx23tqnMDAbcJxOIsRuFXyyDe0nigG/tkxazr8/ZQF+fW7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRZZDdGeHB1d3lKZDE5dnJJb1hCTEJvemdBY0NlWTc4bThLNlpFM2oxRXBR?=
 =?utf-8?B?UUptUDZSQisyM2ZIWHJIelFlYmdhWXNMVUphNzNHcjdmbzh3bzNoSDlBZ0U0?=
 =?utf-8?B?VG9RWFU2RlhNaXFtYzlDbHgwVGNoZEtUOG9tek9lMWFwMUJFZ3BOSHJpclZm?=
 =?utf-8?B?dXErTUd1a2VLZlBBRUdsQjVTTVFQV20zMHRxN3M4b3ljQU1aa1dCcjdBRWJ2?=
 =?utf-8?B?blZxRnh1QTV1eDBwYW40bTBOWHMyOEljcjVCcmxLYWlJdXpGSXFMTVc1Z0ZB?=
 =?utf-8?B?MGUwQldZdjBwQ0VTaUpiSjN0T1ZmUkUzdWxRNHpGQ3ZTRWpxSUpKNlBOQXFr?=
 =?utf-8?B?WUFlb0tMTGJOME96bHY4VEd1LzJGejNmUGJ5dVhrT3dyV3hmdlVPR2d5S01E?=
 =?utf-8?B?NU9EZDRDN1pjeTIxNm5uTkxZczZYZ1p4M2lxUmYrbFMyeExxei8vY3FFUkVn?=
 =?utf-8?B?bU5yWUkraXF1UHZvVXlBNmlTdUR4U0oyMVVCdzU3N25Cb2FEcnpnYXhhVjBu?=
 =?utf-8?B?ZGxwQ2JLNEVRRk0rWEU3R1ZnR1JPQUk3dnVFNFVNZEVTUHloZHcvN0oyWFBU?=
 =?utf-8?B?VWRHeXkxNnU4SnVpMy9LUFhJanVTL1h1T0hyUnhNOGRXdUFpTFc2N05OVFVQ?=
 =?utf-8?B?d3FGZDB1RXVoeUFHUnl1UGltcnNqanVJYTYzSFNZZzk3b3FIdDNGUHk2Tkov?=
 =?utf-8?B?bVpmTWxvTGwzZmpHaDRaM2UzaklhdGRHTW1xWDgyejJRajhrajVPV1FKRGNq?=
 =?utf-8?B?TE1ySHVQVlVlY3RTSndOZHNlZklnK21PL3NscVRMdDBTYWdKK2o0UGJZZGlQ?=
 =?utf-8?B?SXlIakpiSlUyV1NZclVLQ2tMM2dweW5NcGllTGNTNm9LSG5YbW9FMDZWZys0?=
 =?utf-8?B?Nm5oekhzWjBjODN2eGpLLzJCVmt0NDV3RFFNT1BBeUFzNzBacFNidGl4dDN5?=
 =?utf-8?B?eUh5SUtlUFU3V0FXYUxhcmZnMFJDSENHVDUyUFhyMkZjSkNFYVg2aWdpbWlY?=
 =?utf-8?B?bWpzRWUzSDRYaFdoS0NkMlZLQ3VyUG5YVzhPY1MrWmVETUpNVHJFVWNvRXVM?=
 =?utf-8?B?bE5DbUFUQW40WFR0RThqQis1Sit1bVBaTklQWTNCYjd2RU9wWG1YZmRkREFJ?=
 =?utf-8?B?UWJKU1V1YzdZQnUrWDFDcmt6SU1GWUxLVEJIalBNb0RmT0tnOHpmNXRzSlhn?=
 =?utf-8?B?TXIzTjBDL200eXA0MmRURmtER3ZkQ1JIUG9nS0xxTWFjMlkzek1aTXJ2dGJD?=
 =?utf-8?B?bHZWelVVUWthU04zb2UxV3JNaWhma2pVa2NWQUl2cFNxV3FhM0htSzh2cXRz?=
 =?utf-8?B?K2dSZENWcDFZM2hzRU5qZ3RrZWFhWFc5MWlhNHg4MWo1NE5Sa3d6SkxaMEVW?=
 =?utf-8?B?aG16N2g2cVBTRzhsNFNLTHBkaVVya1NOVG9IM1F6bGl1M1JLa0YzMng3bEdL?=
 =?utf-8?B?OVp5Mlk1b1ZIT1JaOTlvTXp2RHZ2OWh6Vk5xS3Z1ajhORUNSQ0FRV1Jmenhy?=
 =?utf-8?B?NkxNL2lqUHJHUGFqQ1ZIenpjUTNIaVRDQlpKcERSM2dPQWgyVkFxQ3pHOVFP?=
 =?utf-8?B?VmtLTnRwWXFaUVl3V3BtSithNnZIS3FZYmdTdUw1T2djRFZGRFgxY05IczNi?=
 =?utf-8?B?ZXVtRHpSK0NxRk5VY2ErSWpHWEw4V1R5MGJ0cGZLQUFSQTBOK0ZVa2lpQnBW?=
 =?utf-8?B?YitIRXlQL0VibVBwQ1hVMitjeW5UYTNRbmRPTitWSWR0eUxEbGF0Mk5MSEpk?=
 =?utf-8?B?TFdWYkxESHFFUGNnQTh2cnZPcWdaZU1FbHNTWmNMdXJZcTlPZDN1RDhPeC9X?=
 =?utf-8?B?UUI0NUttYnRxMFQ0Y0IvRU1ESjJJYnhydWhCbDhIVWpON3BTQnU2UUVJLzBS?=
 =?utf-8?B?VktuWmpYOUgxakpoejk4bm1lMUZuM04yYjhJSnlhZndhTW9nK0w5OXBBQWFD?=
 =?utf-8?B?OVZhd2hJa0c1MmE1aHUyOXhkS0ZZTTk0b2JLMlNabGJOTUt0QUZrbFYxN3Ir?=
 =?utf-8?B?NkNMMkg0d3FMYkQ0dWdUd2hsWitmSzBHdVRBS1dJSytEQUdodEJBRzNFcGJZ?=
 =?utf-8?B?YVYrYS92STZtZDBqWG5nM0VvblFBeVZQbU5TbHlSZmVwR0s2TndSOGhHUWlY?=
 =?utf-8?B?aGtSZENPTDdQemlYKytTYnRlaUZDbDdiQXlKRThqd2lWdDY2a1p3S2NrNnFa?=
 =?utf-8?B?VEQzNkc0L0w0NENCVGpFU2t4T2kwTFhQR2R3cHplcGJNUndkd1JUcnY1NS9L?=
 =?utf-8?B?dFZCYldzeFVSVEhQVFZNOHVmUGZ3YW5WVERWNVBsOTQzb3VCeUQyYzVvQWRt?=
 =?utf-8?B?eEQza1pITDVnajJEdjZKcUZMQWIyLzBxR25LVEdLSFJLdFhyRVFRQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3a408d-4242-4ea3-5c54-08df1a7a5b66
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 20:28:13.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj0PgK5Sxc69i9HqMG8AMT5g5FjIlV/xph4WOqHDF3DJGMHEAN7f+MpRa+g7apNxCIgY8jakAkFWxFu3j+Qfxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3180

On Thu, Sep 24, 2026 at 07:52:39PM +0100, Mark Brown wrote:
> Hi all,
> 
> After merging the pagemap-headers tree, today's linux-next build
> (arm64 allyesconfig) failed like this:
> 
> ld: can not size stub section: file truncated
> `$d' referenced in section `__patchable_function_entries' of kernel/kheaders.o: defined in discarded section `.discard.addressable' of kernel/kheaders.o
> `$d' referenced in section `.init_array' of kernel/kheaders.o: defined in discarded section `.discard.addressable' of kernel/kheaders.o
> `$d' referenced in section `.initcall.modnames' of kernel/kheaders.o: defined in discarded section `.note.gnu.property' of kernel/kheaders.o
> 
> Caused by commit
> 
>    69efc02bccc76 (module: extend module_blacklist parameter to built-in modules)
> 
> I have reverted that commit and 1ca4515ee4e01 (module: rename
> module_blacklist to module_denylist) which collided with it.  

Hi Mark,

Thank you for the report.

At first glance, this appears to be caused by a corrupted/truncated
kernel/kheaders.o on the build runner rather than an issue in the patch
itself, no? Could you try a clean rebuild of arm64 allyesconfig with the
commits re-applied? It should build cleanly.

I will take a detailed look.


Kind regards,
-- 
Aaron Tomlin
