Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794234505;
	b=DLGz3eLE3hzm50O/9OofgRwDYx6R9oNOzPfioenANRmgwB574SJgZ8iiW9ovxDtZKFz3
	 KOWKhfzqgOnRveuH8JjE3iEjd8uTeSPyx7k+73V8vwdO/7ctVPm4DhyvY7/4a52pmFBx6
	 hilzgp27EoN/uUy4yBKtBZ/H7PBJIsER9va8QDiWfFlOYPw2ogHqoxH3lSBM19MGsabJu
	 BCrgq726TX77DOY1Ienw7L/kRL3HgoMLUVBUSxocBT5/5j4W484Z9k9zO/wOdiRWxflD9
	 vdTMSEKi4fljoiPFI5tTdkD1ZwZzhCsEQzpvN3JJIm4oDqc3WaFsMG2obdB8WL+k8Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234505;
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
	bh=cNKXOhTIn1Mvm7r1yxcC5tkaje9VgcUxQO1c9TiKYk0=;
	b=uJJN/my1IaQ4JiPX0igLiZMY0Q66xktS28Gd3zQi98AFRp9J5h1aFA8fH1X5YB2htXeU
	 G5GhF1Xoi65s4yltoVZlnk9oCrkop9SABdD4WfZbo/XVacyZzI/ky44STBz+QtMA+0CN+
	 kzsf60HqjD19Ob2jpj+Bd0cjlOB4eDKKba7QanatpXPknzdOsjiKIzhjox0mzpoDDu/Wq
	 t+tP9Oy36Gv6kOw/9Nxb/KMWhuJnMcnofM9s83LfeV7A8BxwUaYGkR36aHCb2BspblLlU
	 F8Otjopcha98CGnkUN6gjtNAwFa4PEgCznt/Dmt9eIwddmb8V8i0fklXYOlsDyYdxnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.120
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020120.outbound.protection.outlook.com [52.101.196.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C74606A323;
	Mon,  9 Nov 2026 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C74606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNzg9iUKkYhV5WfxGi0F1FvUTgyvr4KlPnV5Cl9VlBq3MXfYLHTLicpC1+Q0n7pCpafgn1gks6kZmGNi1VciUKJ5xABGoWjwqwShxmmPOfo+OyckNsw/KCMksjnXTlVqRmp+BjrnStl5ID6TKkCcGbd/b79lTnBsiz9qmC8TWTBtEKYoYl/qeFbXrTXOHrTR2K1q21X8f3ZVipqAPRIR/Oe+2WHUnYk8vgK0BJZXZlYra9XT2Qc0hI9ikSZNVjfxO/zdQkr1dM8jReSVlPqbGk+6yipb3oVG03g64u+vMt02lTRIGzieEtqB6I+1xkUiCoS2fP9w+UIVR9MirSmI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cNKXOhTIn1Mvm7r1yxcC5tkaje9VgcUxQO1c9TiKYk0=;
 b=uNVI6HCBF+xx3Yzgs8NqBsvEVIVR73a0UPe82GGW5wvCODLZ190myJoOsjozhjvn7Hw+i+1Uuqd19IIB7KJcnrC4bnltwifM7ZS2b7y/qPjVbajviNTBRS1PJgm6tOwhoDWE1quQ6dljftK9EqyXmJXEWqwMGZPVwuOtGSkQo/uYXOeaTe1CJcQ3iBYQP4fxBcrKhLyI5SnSFQZ47+HNqfx8X60MONy5vcDXy5J7u73cAH5RRvmZAbcLjaz+jXXmxSYzdFS79UUpsor9ZOovc9EYTGJT7cvoJDpsQskTiU+jpMSkj019IhxwUJrpVglbf8Suq2GYISiTua2JL1ygWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO3P123MB3274.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 14:28:21 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 14:28:20 +0000
Date: Mon, 9 Nov 2026 09:28:16 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	da.anzani@gmail.com, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
Message-ID: <zjuuet74suq7dujrlt4pfeoajtksegfrslsmokgvfjg6o6pghk@dbifrqvwrnaw>
References: <20261022184517.66438-1-atomlin@atomlin.com>
 <2fd1031c-7a86-45cc-a595-bbd13e102d43@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fd1031c-7a86-45cc-a595-bbd13e102d43@suse.com>
X-ClientProxiedBy: BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::30) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO3P123MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: af21eace-e6b6-451f-ec1e-08df3e6db42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026121527099003|5023799004|4143699003|261021121427099003|56012099006|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|261102124527099003|10067099003|18002099003|22082099003|6133799003|13003099007|3023799007|27256017;
X-Microsoft-Antispam-Message-Info:
	o+XmMFxwCevw02aARvl61kt2Op3I/eJ6oCVHfknhrTazx6Cchpf6fA2rinoCL4Sl27v7RaHs8IesLHlhYOY4DFV8eN69sRqPnIqsTLkFwCHxMi7IZYJVTvq59Y0mX+80CUDKSE797Rb9yEgSFm7tGXX9+7S4tOnz2zJ6cgZMtlCzOonTIa8ejLhdvVsf9FUgkGNY+wehT95zECZg8Xnt3MeJCz4HctmXITMNsc6ZXX/0cqBjFOsF7LSTAs/iohUzgvzFdOIWiXcmfgYX+sRIOoj8hMhOWbnlqzNXlOofbgGTl7JnJJMV5GLlWbiPOtpjsHvf0wXByCaxkPoaWotzBhimk+1Ju0is5tdbY7BHVaRBo0MBMkuZjwffCK6n963kQl9qyyt7IanPAmYGdhFm6FxQZXkRMXTw81aegeZpEowEKrr/kmzP5/it//WrSMhxUrbirI++yTfM9KwaS9jHAX3UUqsyxBenTkDUVkSq6aSPRqHD5SQLvSPXLh76BhdhWTVJKFTCTKTnlTE/aEffE/+AWn/Y4lZOgUvwVgi2B+eWfZPwIbYGfOficTpTakSw6kmUFPp/pqXkD79eTu3cRa+0fAAqEhTz1QeRS5GfQn7aK8emOmt2WZIPK9Bmza7lqj58thEEMWOnAzdTsrh/3S3xJXqYOepLD6ty78gU4R0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026121527099003)(5023799004)(4143699003)(261021121427099003)(56012099006)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261102124527099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEFiVitmM1ZHWXFxUkYvTnRHZkFwNDVCUEtkTEpmSWZiZDV2Qmt2b1dwM21p?=
 =?utf-8?B?QzQyUXlmdTZQaERlM2FUOHdENjNlZUNrbE04dDRkRTJCR1lDK2RNOWFNTytS?=
 =?utf-8?B?Z0N2dWNEQVQySnl3a3IvY3FNVXBXQmZZaFVzdTBHS3JJN01iZzV4QjVoVUFY?=
 =?utf-8?B?dTgyaHpkbFlZdkZKUmNxTzFLMFRVT1BtMyszemFLbFlFUlhIOFVyNHNqVEpL?=
 =?utf-8?B?MTBOQlBCa2lIQXNwK05kc21pczVZN3I1ckZ4cHZpWUVyWDJwcU1HRDdjWjlB?=
 =?utf-8?B?L3NkRlpaM0w0TzIwK2dtSlovRGhDaXlub0o3VFVkcG1LT2VURmlHUkI4akl3?=
 =?utf-8?B?aE9Qa0xhb3lDNFA5d1FvWE9CZnI1QWc1UFg3UDBIS0dod2ExT2lzaVJUUnNK?=
 =?utf-8?B?d0I0aElmMmNTSDhMbkY0S0taOGlPdkJxYUpHTFc5TFYxNzhSUG0rYUhWSG5h?=
 =?utf-8?B?Qk8vcGYrcVE3c3FIQXNPMjVOdUpWVzZhajBJdmtoWVpJTDAyRldnWC9iZmZ1?=
 =?utf-8?B?bEVxeFpuTjJjVnVNRkYzczVuaWdqR1VmNVFDb2dORWp0Vk1IeGViVmpMVUUv?=
 =?utf-8?B?NTkyRGEweU1RVEdnUUVlNFdrYmluZjZpT3FRZTFod3QyU3BBQURBK3l6dnla?=
 =?utf-8?B?U2JKZlQyM2YxVTlEQi84c1gyakZNNjJidzdzQjRNQTVpbjh1Q2RvSk04dkxx?=
 =?utf-8?B?UmZld0o4bzFzeG9QeVdlOWJlNTY5dkdvZ0xyMWZrc3lKVmd1SFZmYUp3Rlp1?=
 =?utf-8?B?Ti9XelBGUTVMV3FaekJYbStBR3hRbTNYenBJbnM5MFRBSG81bWdVNWJCZmRK?=
 =?utf-8?B?WDJleVhqZktIeWJJeTgzVzNac1dQWDdNc1d5QmRZaE1SZnpWcmhrd1BtWFNt?=
 =?utf-8?B?RS9FQitBRHhQVEJ3K0VvdStoZ1d2ZVNTZ0JkVDRMOTJqSkx4RGZtWHZUajY0?=
 =?utf-8?B?TDVWZDhEdndKMzIzbFIxRkRnVnhMM21lZ2xjbm9uQlB1WG1hQ2Z5VGx2cHBU?=
 =?utf-8?B?WXYzaU5qN09xNDFQWGE1dHVpYVVqTm5iTktCbVZLQTZWbnRBZHRvU0VzZzVi?=
 =?utf-8?B?R3JQaW8rdFltdWI4YmhMdlNkai82QWhZVG5OOHBsSllqTHUwSzdiaVhkZVgx?=
 =?utf-8?B?cnVpa2NUQkltRE9xU3l3bVNpbXhPUWlDMWJZcU9BU05ZLytZRHd1eng1bzk0?=
 =?utf-8?B?T0szemREZENzNHJ0bG5iR2tnRnh1aDM5clh0UGNoWUVSclhPZWU5L05DelBL?=
 =?utf-8?B?MzRJVGVFbnMxbUVYNG1SeURGT1NqUnFuZVVYK0dCU3RxYytNN3NTWU9aZ25R?=
 =?utf-8?B?YndNVnhsdjM2SW9PdVEzZVI4RGh5WjJ1V2lMZk02LzB6eW5WWUZnYWpndnhP?=
 =?utf-8?B?S2o1elp2TUx1UjE3dWtYQW5ub0EyU3FwT0pjanFGODhOQjdtdEo2Q0VMWVhL?=
 =?utf-8?B?T09wQWxkaGpvcDZRcGdzU3RVTDIrWFhmVnJtbTZLRnJKNkxKdUxJNzlvWmJa?=
 =?utf-8?B?dGN3ampBazZGSGRGNzRVbEVnenJwM2NJaVNyMjZYU0djRkR3anB0MkhPMCtk?=
 =?utf-8?B?TVpXZTFTV2hWK0FRSWJ5bTVKcUlITDhGSENsUWg4SDRGV3k4a0FBZDc4VExv?=
 =?utf-8?B?T1BjL2FoMktlUjZJWTlGSWRPNjJVcUlOSlJqMWxmbTdQeTk3SXFEVS9KZGx0?=
 =?utf-8?B?bVd1Q2RFSGNlR3Q5ZWdBWEFCbFlNOWZlbktiN3dMczd0T0ozYWNLYzNBRlZB?=
 =?utf-8?B?MUtzL2dPWW9peithSTE2U0FCZm9ZdG5OcFRoUmNMczdxN3Ryd1N1aGtSZjhj?=
 =?utf-8?B?QnhDdUQ5TExoNzJySXl1WUlGVnBVRG84QnVjSEY0aTMvQVRxa1Jqa0hSeUQv?=
 =?utf-8?B?L0RyK3JPakJNMEFLenMrZVA1SjVvczBWeGM2ekVCRHJQc0NzaXJmYVI2YW1m?=
 =?utf-8?B?UkZBbWlMK2NOcWlIYm1BWXNhdUVqRnk1YloyYWh0dXRkWnFLYXVpdGtIK1Zx?=
 =?utf-8?B?NVIvM2QzZ0U5UDVWRVdjdWZJY1U5UE9uSGphYnY2M0s3WGw2WkN0aVVVWmU5?=
 =?utf-8?B?ek1RcVJaOFIxbzN2ZjFYLzJXOFpoSzZMakYzbnpXNUxoZFBPUklFMlZvY1hx?=
 =?utf-8?B?L1dyTDRtVkdQL21KYUVjNklYSWJ4cDVBSHBjYm1xNkhDSmVkdkVEQk5NcjEr?=
 =?utf-8?B?S3RYZXB4OUI4Wlg1YWNWU1BLWWF6TjZOcGFvM1AzQkVMbFltYVdNcWludk9M?=
 =?utf-8?B?YU9JRWJ2NUp4S1ROeC9PaTJlMGZBbjhMNi9uR2xYcVkzNXJlTWFmWm5zK1Zy?=
 =?utf-8?B?L3hpSEtaMVVxK1VZTlRDNDdNK0ZOeUg1bkhYeENQRzBNZzQxVkpYQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af21eace-e6b6-451f-ec1e-08df3e6db42a
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:28:20.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGH9M0KNXnL3qi/Eneb8IiDgG8TB3c/z9mipiHd8HKckth/bCrYqnBdzN19B8FUR/8QkwzqnpDrE1uCoo6wVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3274

On Mon, Nov 09, 2026 at 02:47:31PM +0100, Petr Pavlu wrote:
> On 10/22/26 8:45 PM, Aaron Tomlin wrote:
> > A use-after-free condition can arise in module_put() should a thread be
> > preempted immediately after decrementing the module's reference count
> > while the module is concurrently being unloaded.
> > 
> > In module_put(), the module's reference count is decremented via
> > atomic_dec_if_positive() before the module pointer is passed to
> > trace_module_put(). Consider a scenario where CPU 0 decrements the
> > reference count without reaching the baseline MODULE_REF_BASE level and
> > is immediately preempted: it relinquishes its reference while still
> > retaining a local pointer to the module. If a concurrent CPU 1
> > subsequently drops the final active reference, the module's reference
> > count reaches MODULE_REF_BASE. This permits the module unload sequence
> > (via delete_module() or the initialisation-failure tear-down path) to
> > proceed and invoke free_module().
> > 
> > Function free_module() invokes synchronize_rcu() and subsequently
> > releases the memory backing struct module via free_mod_mem(). Because
> > CPU 0 was preempted outside an RCU read-side critical section,
> > synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
> > execution, it passes the dangling module pointer to trace_module_put(),
> > which dereferences mod->name and mod->refcnt, culminating in a
> > use-after-free. This sequence of events is illustrated below:
> > 
> >     CPU 0                                       CPU 1
> >     -----                                       -----
> > 
> >     module_put(module)
> >       atomic_dec_if_positive()
> >       [preempted]
> >                                         module_put(module)
> >                                           atomic_dec_if_positive()
> >                                           // drops final reference
> >                                         free_module(module)
> >                                           synchronize_rcu()
> >                                           free_mod_mem(module)
> >       trace_module_put(module, ...)
> >         mod->name
> > 
> > Resolve this by moving trace_module_put() prior to
> > atomic_dec_if_positive(). Because the caller holds an active reference
> > to the module at this point, the module structure and its name are
> > guaranteed to remain valid throughout the tracepoint invocation without
> > requiring preemption disabling or RCU synchronisation.
> > 
> > Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> This version #2 looks ok to me. I plan to pick it up on the modules
> tree.
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Hi Petr,

> The additional version #3 [1] seems unnecessarily complicated to me. It
> is ok to report the value of module->refcnt before it is decremented. As
> noted earlier, other code, such as xfs_group_put() and objagg_obj_put(),
> takes the same approach.
> 
> [1] https://lore.kernel.org/linux-modules/20261103163103.13195-1-atomlin@atomlin.com/

Thank you.

However, I do prefer the next iteration [1], since the use-after-free is
resolved without altering existing tracepoint semantics or introducing an
off-by-one discrepancy in the recorded reference count. Finally, the fast
code path is fully preserved when the tracepoint is disabled.

I found an example in dma_fence_wait_timeout(). The following is an excerpt
of drivers/dma-buf/dma-fence.c:555-559:

    if (trace_dma_fence_wait_end_enabled()) {
        rcu_read_lock();
        trace_dma_fence_wait_end(fence);
        rcu_read_unlock();
    }

Uses trace_dma_fence_wait_end_enabled() to avoid entering an RCU read-side
critical section unless the tracepoint is active, protecting access to
RCU-freed dma_fence state inside the tracepoint.

[1]: https://lore.kernel.org/linux-modules/20261103163103.13195-1-atomlin@atomlin.com/

Kind regards,
-- 
Aaron Tomlin
