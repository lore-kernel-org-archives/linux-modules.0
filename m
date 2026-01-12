Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020140.outbound.protection.outlook.com [52.101.196.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F22D0C8F;
	Mon, 12 Jan 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246191; cv=fail; b=BK9BPAsajfTC5wEgvHxW+xPdbrOyO2Exu7o1WfDBgHe2EiMuIHYKoZj5i9SQ9/pOTFrKgWF9OKIrVB66zCTrrwsQls9zFc/Di6CsTYE14TjXnxPdfOGvAogoaNLH97NtPNQQwIQpDoZ6rbHAuDJfvOWP0eouj/GWeXo13wM6p2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246191; c=relaxed/simple;
	bh=8vGJ9D6z57fZF+4whrMlk5P7f8tf1B8ejZiIKr4dmcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwfMYZgknAQpYPDcIQNtbvNWjDOUaoUqZxCDzKlWPx53KAcut67Ji23Z8231eRcO9E3PP2DmCTRqUCwnAJ4Y5FZM1qoBqBJf/ErRWSZR8UqAM7Xrzc4Be2NtZ9uJTprL5tvDJrZz/Un1wsoJpHYU82puIvzkeZOdCxlWfXXD/m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyBSJNKBFVIdqzQbC1d48oauS96bjEvWM8j0D8xuSA0mBKZniYE0Qrnfi/MLxAZ00D0INVk+m9rGmZbBLL79wLSnLZ8tdWa32dc9b2m9tqo2ElI9iYNlOpeecXgMYp2lR/JP+ULDkFa/rtmzLnDrXXUl5ayLiATb0ECkq87rk4+Y+iOqWzGXJNObps4fZ9ubDryTEEa6t119dI6W+4zw2GlTQc20BaAZTmB3W3M0a5Kbo7tFh/mOseFvxyaQiQsvWjYKNoptLwXjK9Kru5frvPZzsePj8O5tcC3wHsy1wLe6vrY6QZcYYlSLEh3VRIG9SjKkHM4fP1btRDNqF/MBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMb42htgXSInr9UxUQyLHxBtORZv8015qMOeBR0AXNk=;
 b=goxrJHJbgqTPRL8e1tsc6OYYprDHX7pmq1YM3oTmTprE2JmJK4dwohRUGm73+jL3adc7tBJE5pVflXPWkmmSgYyRFNbhd3KNE39Qn6qLZIaxEqYSonl9khtYEFiuKWbxvqZlviVmsq6OUZ9t+bgYDVwF2s5EMCyhWZTwm6YD57UcYq+Tf8vWIQjI4IzMKRd0E0SaKCOmkAT9SVaEvMwCFVijb9gs+lXJ9sfMRwUCEKS8MK6dDTOuMTuXyJhfFjSXndZPGuNLWsrx6FVFU2sv1fCtGKIFR0KWCn60zkQBelNBQOtU06pkAhle799O/AGaEmsIMwAFG33syjBBAOMxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO9P123MB8507.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 19:29:47 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 19:29:47 +0000
Date: Mon, 12 Jan 2026 14:29:41 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Song Liu <song@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
Message-ID: <klpmi2dad7wogo3etdxlg3vt6k72tlnszaw4otbzuamz7mzjs5@fhwdyr3ciy2y>
References: <20260107122329.1324707-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107122329.1324707-1-petr.pavlu@suse.com>
X-ClientProxiedBy: PH7PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:510:339::34) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO9P123MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 12681aa3-a5ab-4ed2-84c0-08de5210f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnltRGpZbVNkWG16eEU2d3pJajJsQ1hnRk9lM3ZOc0g0aFVheUl5NzF2OWdL?=
 =?utf-8?B?cGRka0Rra3pTWlBXWHBpallOS0ZHcENyL3k4aEg4TnJYZXpUOHhDaTBTMjRr?=
 =?utf-8?B?OTdqdEdRcnlzZGFSSTByYW5tcmtsUnpiRWJEWlI0YTRDRnc5WlF4bHRkNGtj?=
 =?utf-8?B?Ty9XVmhSeExmOXk3VzRPY25NZmJ0VVc4VGhZODNpUUh1bEtSUGxVS0pHZVIy?=
 =?utf-8?B?THlud2k5ZlFiSG03OEJ6aXVEcUUxeHBlZVBZdmh5UnNOK00vRzl2cUlWYXg1?=
 =?utf-8?B?a3BtaXpwZEt6ckR3bHhSMGUvU0t4WlU1TW13a2FhK1N4N1JNTm43Y3V5QlpT?=
 =?utf-8?B?VnphOHQycGtVb0s4VmY1VWZDQnNhSWZ6OEFVQWtjRFdST21GTGkxbFlYdENo?=
 =?utf-8?B?NTdtR1F0Q2lHRndnWW5TMGhGVEZDUDk3d1dtdlpZQmRqVjNnYUJkdUgxcUxG?=
 =?utf-8?B?NmpOL0JTZ2NjWkdKK2JOWW12S0hqdnYray9XbkxwNmdtSkJ4UTR1VHQ5OFho?=
 =?utf-8?B?OWZMdnZnb2JUb0RjQ1F0VkNSbE1CMHZRR3FTM2RwRmcyMmNxWHFmd0ltUm1h?=
 =?utf-8?B?VG8rVDBmRWRDUkI4SDQ5WUZJRFZialJaTWd1SXNQZjc2RnljVW45QWNPcWhw?=
 =?utf-8?B?T3lWWDhkclFMamJmZHh0NS9MN2Z3aXhrZU5taS9GSjBLVmdXVmoyTnRJNHR4?=
 =?utf-8?B?bGdnRzZmR3B0NWxlUWtMSFZXcENIcnFLTnpaR2RkY2ovOU9KeWk4NHNETHRh?=
 =?utf-8?B?VFVtTk5LNTRCY04veEt1WXdaV3pOd1htRklKRnE0aWNyazBxRnl3T0ZLNkhG?=
 =?utf-8?B?TVByUitGTVZmUDloR0xnWkx5TTJUWUFsTklWcnU1OFdtK0ZuVFNXYnVJbHNt?=
 =?utf-8?B?Rm4wWlpCeVdjNzgzamIyQkxabmROY2FITXBlZHFkTHIrdEJJSUFFUU1TMFBJ?=
 =?utf-8?B?MFdwZFp2UTM4bllDNWh3TDVURTRZOVVpL2tTOFczM09abldUSFlwSHFsQkNw?=
 =?utf-8?B?QXlJSkY2SzFEWktYVGxIU2RaVDNmM1hPZHAzRjFFb3BZc0JjbXZmNWt2eDRo?=
 =?utf-8?B?VnI0TUdSUnExelp3czAzVGVaZ0ZJZmZaVTZtQWFLc3V5aUFqeVNkNHE2SWZJ?=
 =?utf-8?B?a3YzanlIc0dtL3hZRGxKNm5HTWxIK2hJOWpzOTFodWZGMkVNZFJnUkVCK2R4?=
 =?utf-8?B?MFBWaENqQStrdldrWERhdUx5MXJ4K2FpOXdJWk5jVG0xZTVWb3RkVVhQRm1r?=
 =?utf-8?B?MVVUWkV4dzJXNGltMjkyaXMrMkFneFFOQjloVVBuMysyZWQ0dXRqa0lvZGdx?=
 =?utf-8?B?SDRNMGFuaDQ5RklNUDZhSldaSCsraDNuRStyMkdoYjdrSENQbUNMd1M2eTFX?=
 =?utf-8?B?ZHpBMElkNG9WNVdncThNTzdrQmxOYXk1VTl5a1BjUjY5RVlnL0t1R0RGNnRJ?=
 =?utf-8?B?MTRmY3FDcElmTVZUcFYrbnRrc3NQMGVVb0k5QWY0VGRwamhTcllkd01kWWZ5?=
 =?utf-8?B?L0szSTk4K0ZpL0VjMWhKWnNFemxGalduYXhOV3VucnJhcmc4Rk9BeGtXbzU5?=
 =?utf-8?B?NkZScGc2OUdJdjcza3FNM05iRUdvVGVZZWZHbzUvamZYbVA2Y2pQaWQxc1p0?=
 =?utf-8?B?N1ZqQ0NsWXVBTnhmNTBHdkxoV0piREFWblE2NmVNVDVEOExvOCtIOEVmOTkv?=
 =?utf-8?B?NktqL2lBSUJtM0Nta1c1elliODJIVzlYZmJ6dFFseFQ0L0VuQnpNVGRiRnor?=
 =?utf-8?B?dmRIZkw5UEQ0b29McVgwK1FHcmVOVWV5WWRFR1Q2U3pnVEJPMUNkc3V2WTVo?=
 =?utf-8?B?R1Vwamc0eEZXbjJsSWdOeUY2bVJ2TGVvUTBxWTErc2tDaDA3OVVsZndkTlRN?=
 =?utf-8?B?RWFlcWFTTEVsYW9kQjdZMlFYcXlpeHI3N2R5UnNJWlNiOHFBMWdUQW12MU9L?=
 =?utf-8?Q?1DFOy04GlnU9NeH0W4yWGrBF903DLAS2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkpxVUNYaHc1ZWJBVHdrQWllRGd6RWV0SDhkbVlOZ2o3YTNsNDVheE5laWdK?=
 =?utf-8?B?QU1WcnBhaVBjYVVqWXJJT0J4bWJ6U2Y2TzE0R0NvSnBCQW95YjYxVngvTjBo?=
 =?utf-8?B?QkgxOWZ3YURyM0M2OEdGUFUvUDZDZzgvU3hhOVEvVkR1Smlia1JJL3ZJN3RC?=
 =?utf-8?B?TlV2aElETytBMTZDT2FWa1M0WHZZNEFjOXdBYThJZGYzb285VTJMTGF2SzBz?=
 =?utf-8?B?SkxmR1NLbHRxclpXTkZqMHdCT2NMbFJMN1FRdE5xejdDQkxPNy9SVloweG9u?=
 =?utf-8?B?SFRHeE9ONXgrNVZ6RUFuRDlGaXVnTzNxZ2EzbnI5VUtJTXBjNFAreGhVUlZ6?=
 =?utf-8?B?S0FOUEJldEZOb2gwNVBtak9UeGVxRnRINXQzclRYdTAvTkNHNEd6ZlVZUFpO?=
 =?utf-8?B?YTNIbTl4dEZBcTlPMUs5SnAvaWF2UTB4Sm5oaVNJTjdNK1kvL3BsZnJuOHVr?=
 =?utf-8?B?Nk54UlFLYklyd0EwejJHU2hsWEE2Z0FXd3VjSUluMEU1L2JUVitVbzdZTGI3?=
 =?utf-8?B?cUhCdFdtcGxtcWtZV1VvaG1mM24wRFdlcDBhMDRjSE1KUTBENUh2YmZhUlcr?=
 =?utf-8?B?Wk43c3dXaEp5OWM5eWJuM0NXQlc4MVNnTFFTZmJzdEhiK2hiV3o2K0EzNTRZ?=
 =?utf-8?B?VkgvaDUvaEIrOGNCS0RzS0tBR29WS3JZbG13cURjT0xxT2dlZUI2S251djNU?=
 =?utf-8?B?K2tqbFZxZXM4VE45eGVrNjVjRzV2cFJLOCtnczMveW0wTndta1VUOFl6MFl5?=
 =?utf-8?B?ZUp6T0RwSTBqUlp0S3B4amFSYVlGSUQzd1QxV2ljV1dSem5GbkluRlBVVWVl?=
 =?utf-8?B?QWpWUTRLc3JITk9STTJxS1ZaS1NMQ0tSSlJCcDBzN0Z0N21udm1tQ09wemg1?=
 =?utf-8?B?WEtKNys0TER2MTE4alAwbGlFYVJuSzEyUTZsK1l1NVlHYnFESGJRZDZzZlo0?=
 =?utf-8?B?SXo3Y0R4cTdVMlc5dHJya1VHa2xidnZnTUFYZC9ZblpVL01hQzlmaXZHaVR6?=
 =?utf-8?B?Z1FIRzZCdzNnN0RTeDA2blpjTmJsdFBFa1BJQnI0TEQ5VG43amkrbU1rcjNh?=
 =?utf-8?B?M2FQMXpLa2NKa1pVR0hFUE55SzcxTmNJbjJhZ1RHRXZyb2dqMnpUWVFRUU9I?=
 =?utf-8?B?bm5zTWdoY1oya1NFUWt5QXdwUFBKYmhveEx6MzhXRy9YN1RocUlGTmdTUytF?=
 =?utf-8?B?WXpDbzZsV01pMFltUFFSNHB0Sk44Rk1VUEJZaVVyY3E4RGRSSHpwRVhPcmVZ?=
 =?utf-8?B?dXFWNVY1WS9UcmkrcFNyRU8zeE91aHVXci9LQjZEZ1FmWHQ4K0N1VnBLSlQ0?=
 =?utf-8?B?NDRzZEZjYTVlQmFUWklJcmtvdVp1U1N0Zk9tS25Kb2tOUkVJQmVGejU0QVdy?=
 =?utf-8?B?aHIraFJMRXpyK1prUXdwUU1vb3R0TEZ2Z1UxQ2NOeGtobHpZVmwxa3hWblFR?=
 =?utf-8?B?a0Q1MnNNczhJb1FxQktFRVJkOFkwR3hRQXVvaU1Dd3d5ODBJMjMwY2NNT3hq?=
 =?utf-8?B?WEluVjhmU3BKcitJV215R1Q0M2FZM1lZVzF5UGxzemVieDBRN2w0OWVhR1B6?=
 =?utf-8?B?bWdDWmFldlZobVJyczMvZ1Y1ZVFrZVBGUXpLWDNXQ2FSWFM1WmI0RVFudlRm?=
 =?utf-8?B?MlpoS3UvczcwVVY0YU1CRjZTaEFRbVQyS0taSTg5SUhxaXBKa3kyaU0rRUQy?=
 =?utf-8?B?c2hacGlUNFdCMXozdkg0Mk5Td0ZSUkl6SnVGT25FcHdaaWErOTVVTzRkWm5J?=
 =?utf-8?B?bkJVbCtBTEtmR3NhMFBnVGFiNTAySWk3ckhaWGIvbmthd2VxdXBicWJadFZ6?=
 =?utf-8?B?VDh3dUhPR2xFeFdpWExUVW9KNHY5QUMrR2NCUW9EVkhMSkpudWFGSHEvSTRD?=
 =?utf-8?B?WkxVdTNrd2ZxSDkzMTBxb2VQRE1ZTTM2SWJMa1RwMGhxMU9JRW1PZnJ0WC93?=
 =?utf-8?B?WGhwMW5IcXo2NlRwY21MamF2bjNQRHFGYkpxZlZrYmg1b0k4bUZSQVVTOGZM?=
 =?utf-8?B?d0lhVkhQNGxwQ0FhanBQZWxEbm9CYjFwZURvcktZTmwxcmUyRncwVFEyNkow?=
 =?utf-8?B?d0R2USs4QU5ZT2NBa1pjUUU4SjI2dGhZVm00ZU1YdVZKYnRvalFKSERuUWpD?=
 =?utf-8?B?QTdKdkNwMEJZdnF0NXVBdjBndWVLdGZjZFdKbkdjT0JHVVJBL2JWcUY2R1hU?=
 =?utf-8?B?YktQbWt1ek5ML3A5SHRpQkEwaFdpZ3FoeEJXUWt1cEl2d2FZcCtGcXN5MGE1?=
 =?utf-8?B?RVFKOVlFby9FQmZhSkkyT3lhMlo1U016VUwrKzRyQ3JMbVRTSUZQdi9QdW5P?=
 =?utf-8?B?Uk5OaFhQUGh5bDZiR2M5TTFGcDVTak9wK0h4a1lxSHBqTk9VZmlIUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12681aa3-a5ab-4ed2-84c0-08de5210f213
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 19:29:46.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irK38enhog31VGbTOC70dHbkC+IezFbEHioMAgPnEfrVoNx3ZOJNMiPcxTi8R3rErrb3kJCkuqk2zJ9W0BHGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8507

On Wed, Jan 07, 2026 at 01:22:57PM +0100, Petr Pavlu wrote:
> In the error path of load_module(), under the free_module label, the
> code calls lockdep_free_key_range() to release lock classes associated
> with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
> subsequently invokes module_deallocate().
> 
> Since commit ac3b43283923 ("module: replace module_layout with
> module_memory"), the module_deallocate() function calls free_mod_mem(),
> which releases the lock classes as well and considers all module
> regions.
> 
> Attempting to free these classes twice is unnecessary. Remove the
> redundant code in load_module().
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 710ee30b3bea..bcd259505c8b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3544,12 +3544,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	mutex_unlock(&module_mutex);
>   free_module:
>  	mod_stat_bump_invalid(info, flags);
> -	/* Free lock-classes; relies on the preceding sync_rcu() */
> -	for_class_mod_mem_type(type, core_data) {
> -		lockdep_free_key_range(mod->mem[type].base,
> -				       mod->mem[type].size);
> -	}
> -
>  	module_memory_restore_rox(mod);
>  	module_deallocate(mod, info);
>   free_copy:
> 
> base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
> -- 
> 2.52.0
> 

Thank you!

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
