Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020082.outbound.protection.outlook.com [52.101.195.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF154071E5;
	Mon, 13 Jul 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944887; cv=fail; b=l5l6BkvXlh/LAyzFNPCk+BGgChr7j97RDfttqgiYnvkzlLnbbQQp78k8t8KPDiZpMdO86Q38y7wVewfvMyodYtjCY7dTzHGqndoLQZzogzOyArd5LakfGynGR5FVQQPqBX7+N5L78MD95qWOV+gLMtFc1wlYCclnH4m5JCsQQ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944887; c=relaxed/simple;
	bh=DOMpWfacbuBPqRclKOUcsc5EvrGyJzMVEyWvDWY2bJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uPUvR4s5Hi/YpjOgJyzeadIOW6tFT7MVQLdQdGiTe7fOI+vTuAfrmJLZvk7kPzQcqIffO97Ui0FqXDb3FhmVaJEJkPUfzKT4M1mKqsA0p7A5tQ/8a1Z2uEd2R6Fgm939RNb9oErPJdq9hx2glJz9yfmeWf4MPM4bpLhsSLS1fK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMIvu67r1wk8/M4yZFwNc/NGkx9JBYCj3hTvuWFz86HqT2xP79H9eDikIGUh1IiOuMEYOjJVkiQbeIpsXpCLQZCL2Ulututz/lWKBU1OKIFHKKiU0w0HT0B6KdMIl4rISyB23C9v5M4UKbQ5zz2qojsexAXbV+uPS170goEPEGKIzKpVcMgoZBgrspi64mlVjIhczM9A9Qh8Z3qUBeJSCGP28XLxxiEWfkLauQ2cTZstccwN+8ilowt57Vy+gN1lFjDZnWOFOlqfRppVjYL3JHpz9DhQz9wZBKfcJQOHOLu3eUfaUdyLDSiRVVPXMYrUmTif3ItvSNCLHOUSPFgqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=LGxI3/Kg8ZEb7PzOhU/8rQAnF7GMFHmuJq5QYVTSuEo=;
 b=AbrlyRnvnR1ViqO61A+lJTyxVCNBvG80S40pWEwhqIQYamZV5Km1fn1lVhrFVoSDCDmLA91bPkfJwq0xPikujwn64aMdxBrCgaHzPuzvA7r3mfhNaOZGUvOoMPF1xrPCSqU3qlLcs6BeKaNxu46+/E+NQ1SNqKvlBMXsx0tZcXlhhtFqjxzT8gSSOajB+QOwa1Ke10nDMAH4OF9zbD6PrAndPqnizkTBKUno1NEI9dqA086Na9XObVbDyMIJtXjntN3Bka7sOrijRVvXiRccTyv9//pMU6A0MMJye4YTx4me2AxPlUY4gn3lMmf2KJDt6Nzhk5on7x+lWlZPaoWHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7261.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:336::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:14:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 12:14:40 +0000
Date: Mon, 13 Jul 2026 08:14:36 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	linux-modules@vger.kernel.org, Daniel Gomez <da.gomez@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	Siddharth Nayyar <sidnayyar@google.com>
Subject: Re: [PATCH] module: validate string table section types
Message-ID: <j46ht6nbnztkkkjbcxgx2aq5msszjsvxg7cwffxdrxciihbzen@p6q6k6hakgzy>
References: <20260708012107.1621513-1-tweek@google.com>
 <99301e32-b067-4d0a-a087-2c77b1fe0a90@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99301e32-b067-4d0a-a087-2c77b1fe0a90@web.de>
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 221577d9-0ff9-40e0-e426-08dee0d85085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	z0Q+3Q4Z/o4Urb9vPyUsEFtMaEgvtid8OKwtL0myuiH+tx5B0c+tj2Sigm1H9VV1A7GU0y6L7el3uvKMFiMpebqyjcV6nl7eZs571bRcHS3/ZRJhXcR/ifTi11lBTxAAwMDeH2TMg1MNYnx4RaifvCDHRoZrmVI9wW0oVTWuZugD37uQRDH+vuDZxhnoh2ZFV5+njHIKiFbY37B9nULWyW1IfU73GVC2zvcRtprDLFK3RbcDHjsVUC0ny0ly/f5BTVmZJrd8WcaRb+zUnwUtV+edOqfLNnP4x/UAT5KjwpheZJwGyTyNTTvvlq70i84Oy+2nniK5oK9zDqj4+H7tTgRzpLdo3d1MgxzVnwbJT7JIQT+/0Njfb0b/Ter4Vo/jJ1wivBAx0FqpWbY3sY6LrxgGSihwnBuyLexNbd1epVAiWfz2l66mychstHi5zB0oZUpxtO3oc8ZTz2ji7rJOOF1QY7atR/yRvB3nfg+5IVe2Ddgx02Tfyfx14FReQfsB/AVdG8QUuYOmmVattCWEEYufoku1vm8SndpPFVwd+NcDLlRgri8m+7wGT43I3kcAU5GdsKOtbszsLArI7boFpH09eVuyt/1g0TnOD8uAR1j3V552BF0M+K4LIkyVyOVe/vsZJh0szgjyHu8DKfWM6Q4VU2Cov2+2/8dZkayaxPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01TTXh1WDErQm5WMGZ1L3ZkaE10VXFLK2hhQ0Z5ZDFVTk9PdEt5QThWUjhi?=
 =?utf-8?B?eUJQYzRXdEhSbWRYR1ErMGxhb28yY01MSEVlMWZOUnd0cnF2Njd3czk3Ymxn?=
 =?utf-8?B?cFhDVUsyT2Z0RS9HMVBxc1JzNGh3TGJ5Wkg0M1NFSzRQYTFkK0ZKMjBVRjVv?=
 =?utf-8?B?clMrREpoMGU1dEpjSyt2L0hHL1RRSmNKUXZobVV5NU5rMUJENEdMd3hWMVBH?=
 =?utf-8?B?Q2xLQmpKU0RhN0l1NjZLbUUxSGNxSXFoUDJBMk1qODJJa0U0djJwTzVjQWpk?=
 =?utf-8?B?L0x5Sy9Xck9QOUpoa3pZWkxLeEpocTRWd1RNZ2o2NTVqV3hvbVVwSEFJSmJn?=
 =?utf-8?B?clRMY05TejVpSVlNRTVIaFZueTFFcmdXK3dOWmdEMVJCUFQ3RDdFaWMvSTNm?=
 =?utf-8?B?WFFnbmZWazRRa2pTbmx5MDZjNWc5TzhTZUdEb3hMU3ZTT0EyTllmQXY1Y2lP?=
 =?utf-8?B?ZlFsd2FLS0wvTmtYdDNBeDBHTTNkMWRtR0NSVWJIbHkxN2dHbXpQY1d5SjBr?=
 =?utf-8?B?bEJCOVFDY3hDVGIxT0YvREk0ZlpTSDAwWlFlTXJRcjJ5OS9oVlk4NGIrUmpH?=
 =?utf-8?B?T2c0QUUwdFQzRUtBWHpZdVVXRS9QM2dwc2NvL3pvMGFZZTBNWWtUNGMxN2ZK?=
 =?utf-8?B?TE95OXg0QmQweG5RbHpGNkV0S3dBeTNBZHFNZXdmdHM1eFplVWZPQ3pPMjVa?=
 =?utf-8?B?aHdINHhuNzBjS3piam5DMWJUUGNseXdvSFdIQkVBS08rMytYQU9kTkFnd0xl?=
 =?utf-8?B?Z0pvM3lSdFpnRmUzZEp1eTJjeG4vVmhjODlFcC9wMVJKVlpzaFNQU05HaXJm?=
 =?utf-8?B?cTFvQThxME9maGcvZnRUTjU0UnIwTDh3V1ViSEp2ZWM0Ymk1WVlsSGhjV2Jq?=
 =?utf-8?B?M05GcE9zWlVIUDkweXNwS0N3eFA1YzU5TEg0SjV0TkwyTEJXRFNReXJHMWha?=
 =?utf-8?B?U0JOdTJKV3pKU0R6TDJMMU5KWUhzOS82c2hKeWF5UFQ3dTJXekNYRFJ0M29Q?=
 =?utf-8?B?TFVldjc3OEJJZDZIeER5UGFmVmFvb1Fkai9WZDZRYnlUdlJXUzk4S0NIYk1R?=
 =?utf-8?B?WFRFTXdUMjc2dnpJaVRtVHVWdGtaKy9DY1BpeCt4NG1rMm1XMmZSc3MyZC9w?=
 =?utf-8?B?Ti80VFN4YzZLVEZSbmdPdXVKTTU0UTloTFRpSVJzSVl2VnNTdVNHU0RpcHMw?=
 =?utf-8?B?Sk1CdS92SjhTenVEcEsyUVQ3QXo5TlgwdGVETGFwaDY5OHpMWk12a2RjS2VN?=
 =?utf-8?B?M1NxMi9yeXBBYVpTUWdNZ1RnQ0llb0FzVUhWSTBqRGJRWTJoNk10TzNaeFU5?=
 =?utf-8?B?WVNIanc3aWpHamkzTERPc25aUlBrYTlWVjlaNFg2OFhTQ2t6OER3NFhVa2p2?=
 =?utf-8?B?QWh3dzNlemkrOFQxZkFEallROTB6MVFzWnlVYUp4UGtpeHg0WldITEl5ZndL?=
 =?utf-8?B?UnFCOGlWbUsrVWRQdC9WZjcwaVRCSXdVcGw4OENnL01pdDllMFdwUm1lazNl?=
 =?utf-8?B?WnlzYUhQNHdrNHcrVjFENVFlQVBtWlVZNHNZOEFEY2ljd3UvQWZ2V2xEdFpr?=
 =?utf-8?B?UW5nRkpHaUh2bjY1VC9BcVBwZ3EweWQyNGJiSytYckc2L2ZFb0JLQnVMZTZF?=
 =?utf-8?B?eTJGeCtqcmgrc1krUWxuYU1NdGlzSlhSMkUrT3pQRllibDQwbnc4WGxiRnBr?=
 =?utf-8?B?a2JkaWI0RGxkSEdicjJUS29LTGs5TSt5MENuZk5HRkl0akxCem5ZS3lQMjJV?=
 =?utf-8?B?aEM4S0xBUUkraWNucWlqWlVWQTg2TWtJZzNuYnVOZ2lmbE9IK1dGaitsNzRP?=
 =?utf-8?B?TFZFYi9kUFNmRkZzZEIranJacWxPUTl4UW1DUzREbHRNa2cwS0ZjcnJMUng1?=
 =?utf-8?B?SGEycFFPUFVlNlBSN2JHek9RV1o1L1pTaHE0N1dKd1crTkd2N2NPaHB5Qkt5?=
 =?utf-8?B?NGRXU0tUdW1CZG03MmNrSll3ZFlSYW5HMnczUEJSZEFxTU1rb2FLWjRpd2Z0?=
 =?utf-8?B?U05ucThTOVREZDlvZEgvZlNrTTB1cklPM25LL0I4cnFzYm9qeGJXQmhDaTl5?=
 =?utf-8?B?aWxTTTBPUTNLTWw0aXd0WGdUdEFEVDkzcFZZbDUrUDBtUEFTdGRxcXZjRHNS?=
 =?utf-8?B?TVR3YmpZTms0QUE3NWpoZDVLdUNEekxZSFRwLzhSYUUweE01NktTeWs4RDA3?=
 =?utf-8?B?YUdqalRjd1dLK09SUlVwTmlxVG5CV0dmSDR2VmNIQ28wUVVxQStMd3BJdkhP?=
 =?utf-8?B?cms1TW0yUjVKbDZzY3hsS3MweFArSDlCMnZ6MXY5OGFuWTRUWmlkNmR6TDdP?=
 =?utf-8?B?Z2k3QXpMQ2tnYlBMUm9aWXA4VFRkaDhIL0E0a1pwQ3krbnJMNzRDdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221577d9-0ff9-40e0-e426-08dee0d85085
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:14:40.2968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZAuZO3+0korzV/+QzHrDMpx2CKJDAXik5dI5zWp4z7CcZ0TBaw7cTWBVU8m4kwQD7pSNHIXh6mUpP7vufcZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7261

On Fri, Jul 10, 2026 at 10:23:00AM +0200, Markus Elfring wrote:
> …
> > Validate that both string section headers are of type SHT_STRTAB before
> > caching them.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?

+1

-- 
Aaron Tomlin
