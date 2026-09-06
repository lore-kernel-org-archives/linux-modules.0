Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021098.outbound.protection.outlook.com [52.101.100.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD93BB48
	for <linux-modules@vger.kernel.org>; Sun,  6 Sep 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707231; cv=fail; b=IS8Pay8jHtiuLZHg182hG7oBl4q2kr792UJLgKyA/ICVmmELejRPmXXzoLptIePPoUemGC0hUxuHk0sGlKj9hMD5E54vFTac0q+V9KDotvGQtgPsSuLiKMY2I9RJf6q6rSJpOPcES4mCYpwcf72L6q2KHZYMobIAr1MevE0v6h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707231; c=relaxed/simple;
	bh=yjYAwvN5tZNmCUpV+8JED4p5glGpFHzsFa3rIP0kPPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jAx41259TBbNNFZx+XXPT82BauKKGX3GAMrPbwY0iKtK9p0mkzDcCnXZY2ylGcS6a2YVlXtpdDaj7Ad03Awo2ETqi8xhn62OYiKszC1I3EumWXuCy0NmISvN1l8iNNsgfFhRU3GqwcCovuJDR2HOrPDwMiyIqMpkgr3sBq+mV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvx9dCb/NnitUgze/0sqnRYhubklrGElss+hv06BPPio8d0J3U9RW6PfR+NyGtgbVAXjI7W02M3cPMjKoq9a2YzwpsV5KmnohYRRriPVY4K8jbl7mLCgNWWr48DPA9uS2b+Ii5VoUpBFLwsHZXIgUteEzQcfKyUGjSsOvL99iuhwVF2TiHd72390bxHwyO6CW6fHRS3sPEwLz/N+jQoEkW/n1S8UfcrgVRPODNN5svOzozuv5ef7JUfpZo7EetozNZ4m8D7RLTSGyctCAsbyNLumJ7QKD8x2Di19UF8/DQCMz93NQ1SYQcCqqKcJpIV77aFYHclPiTa7x7V/TMem6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KQGHB8/+EWMiKWWDmnFqyr3w/nwwv960ieHARgM1CPs=;
 b=jyQhfhT7f6KuC5QTbuiwhJ+2V8gpHGk2Ot/DPjIioxWfrOH4FgIMb4GzO6Krnszgproz7VZUF9WIB0LsVdjjPa8MVtUlP2bcH/ReNxB75DmgfFGOIacCFeK3H3jV3gUDFboQL7WnTqqjG9bjg1GlK1XmBPmlVeOqiFqVjiS7dudqNLx4iPRqy+151Wei59qcg8VnhFnF1Jj+JIlAiQkFTjWC2SRh+blsT7iyDUfaOR3khcP5N4+x5WWvzvJ1LOZj3AG8ULc8uuIyR9SDKNfAm7xrp+0UCO1X9GEZ++2FU8Lqc4fnJU6cuq34rRGua5V5dFBqD3/z22KdPuKdl/81Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6726.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 15:07:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 15:07:04 +0000
Date: Sun, 6 Sep 2026 11:07:00 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Gary Guo <gary@garyguo.net>
Cc: sashiko-reviews@lists.linux.dev, petr.pavlu@suse.com, ojeda@kernel.org, 
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v10 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <u5fmo2l7tyaz37goqu3rek7m5iha7kmuq4rme3lgriq7zycycl@ix6o54np4fqx>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-2-atomlin@atomlin.com>
 <20260903191303.5A14B1F000E9@smtp.kernel.org>
 <xuj6okhlofl4cboopwjzqe3jyfmaxgvdpf5a3ek7bubew4vcbk@nkfqgoe53533>
 <DL89X93TI07G.18X8GZUFIIM6@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DL89X93TI07G.18X8GZUFIIM6@garyguo.net>
X-ClientProxiedBy: BN9PR03CA0802.namprd03.prod.outlook.com
 (2603:10b6:408:13f::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a46088f-90e6-45b7-d0f7-08df0c2882c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vuDjQJIZiOLOB+YFs71DWXS8AddGw6AtbtO1Iudaw7kknCp3xA1MGi/4Qh4+IyfhY119XPfqvhVs5sY23jWsjwkKq/BtAqhDadZyQmdAs9HtDbw0JqFJlb1BpQ/6/yHrOu6L/c+av3tHaZ4zF6fwY/73CgpgnAkcjIi2w8cOEp6yI8sQlfxKWrfha+QwS3GXLMoHXDNH6Z0ZCWpbc5wcQdFAGKYevTIgWkYDpiNdcfwyL5JAJNFUmWVUUFKeGvdyn+2+NUk1lPNSxdxwqpjdLimkroSKUlDhAPBzzVx/iQ93z+auji2+nvVMW6yNyPsrxJr8dnPULSe7DNJPvn2b2ogvqaSmmw9Jc/nanU9tYrXpZJNAMfo3W7X9HAurtW1vR/SXAjtGTPzJnbE6xTGLBqKoe0kmpaWlYgjYmSbfnmPTA6JFfvv2DZrS2XFRTX6eE8pdfLvZYUiZx9kDcCofwDE7QF3A/sKcGf5VqK3qqwJ6os2gD6Vru1zqdfmiK66gGMflDeBBynNNRhBAA/0IwrbAuEVMKBYDapiu+fpNuCAWIAFF6HSWuY6FztzfzqTq8L7RsLDvKnAqRXevMvqWs7zgSVfAKT+BXlcufdA4JeUNdZLN6fAXppi8eQ/EXVfxJ3b32w64EcclBGFFEcrYDDcqwuwzsKOWXIqy0e+4GYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjZNckxZaHFZRG03cC9jVmhQS2lxOUVMbllIcVNyY0I5QjhpM2NpTEJCVUt1?=
 =?utf-8?B?NjN3Z1ZqL2JudzlJQXN1RE5WVnkrK2ljNFdhS2U1c3NyekM5Tmt0QjBFSml5?=
 =?utf-8?B?ZnllQ2pMNjVKMmlKTUJQNlpIVHNSSDFqQ2tmeXY4R3g2cCtLSjdaSlZRQkRy?=
 =?utf-8?B?SDlMNDFEUXhrdVpsR2RoZDZtR1FTelBIZHo5ODhQWVpjWW1KcVN2OWNCMis3?=
 =?utf-8?B?cU9aYWdmVmhVZDZsVGRQN3V0VGppck5aQkxVeHhLSmtqKzQyV0M5TWpoRytp?=
 =?utf-8?B?VkJjQ2N3M3RxeGhTSVBBL3o3SzBtQytmVVF2UXZHcHRJeGEyRCtQelZzUzB2?=
 =?utf-8?B?VGFoWWVwN3Y5eE40OUM5d1cybE9JeDJ5em5wR1dybjdoM0JEUDBScTFJMnhY?=
 =?utf-8?B?TUhtQWxPQUJON2NwZDVTU2NwUDcrTDV3NmhLbEJoOVNyYVcxUlQ4UU1CeUdT?=
 =?utf-8?B?WEtjdmlpTXlwbzdUMW40K1JScVNiNUZ6V240RnliK2EwMFJ0RmY5Ui9TMG1n?=
 =?utf-8?B?QmE2YkI3cW9JekJneGl6NXVmRVNqNFNla3M5RVAwaFQzTndIQ3dUUmlBdEhP?=
 =?utf-8?B?QWlLVktGekh0MXR4b3FWZTZYQ0lpeXVsZTVUS08rbHN1SEx2Wm5iTmhTSjY5?=
 =?utf-8?B?SlhEekF0VUFSVm1sTmVaTER3UW45UU04Q2V1OWM0RGNxckpzbEFyY1FQSGh0?=
 =?utf-8?B?bVJpaUVyOENtdFpEeS82djJFaFZyYWVucW1nUExZSnJOa2NiWWdyM0lsZUhM?=
 =?utf-8?B?MHQ4WXp5OURuQ2R1dUdidmFYZUNsOElnUVQvVW0yTERyb2lkYThXT2JzNVF6?=
 =?utf-8?B?VXM2Umh4QlR5b2owS2h1VHZrUGk3RVVkcXJUQ0ZuVTI2N1U5TWJvNyt4dVNa?=
 =?utf-8?B?U25FNTVzWUtVakdjb3ZYWG1kMlRndlArQk9hVndHVnIwdERxZGd1czBTMjJa?=
 =?utf-8?B?SkYrVGVPVmcyTW9GcTdkSVZrbDNOZnU2VnE5b1hPZk9yUjQwaThZL3NxTitK?=
 =?utf-8?B?Y254d25oQlFvUGVPa0dPYXcxVmRScGl5akFZaDlvZHJGSURWVi9oU290Nmlh?=
 =?utf-8?B?ZEJJR2lsYkRWOElqR3VKa2F0RzgwMzVFREdESVJCTGNvR3JIZ1lvOE5kZkc1?=
 =?utf-8?B?S0VKTHNCbGdudzZkTmtPamdlbnpGb2w0R2I0R0RYa1Njd0Z4Zkc4bWJaQ3Bp?=
 =?utf-8?B?SHBPTG5qM0Joa3hYQUxHL0ZScFFXVGdhQy9pczhBclcxM2tVRUJOSTk3Yk5R?=
 =?utf-8?B?eU1BaW50QVdBeHFRdllyMGtORXRTb0FwL3pEc2x3anplU3dLVUlaTk9yTWRh?=
 =?utf-8?B?UEZEalZrV0NIVi80NkE0cmd5YzhSOENWUkZIcGVHdWFPUEhrYmRlOEd6cWNH?=
 =?utf-8?B?OTRrY2NnM01QcVA0MHhOVFJwTFdyaXJTTGNLdEZHbFNXYU83NUxMeDNxeE9w?=
 =?utf-8?B?RGN0aHo0MDNpdU9SRk9OS2lYMWZubWtNaTNqOWhtNFh4S0djaFFoSTZHRk41?=
 =?utf-8?B?emN3SHhGV2I1RkdHbkEwZEtEK3JFY2Era0FDNWFaMzBsZlhQSTdNUXdDRzQ5?=
 =?utf-8?B?cm1IRDRZV3F0dnJOQnlzLzZEVEsrSFpzc1JhaXRZQkZQUHBPTEdLem5ONGFZ?=
 =?utf-8?B?SDY4MHpla0gwcFY5Zlp4N3M4RnBERjhta3I4bVk1UmdaYTJ1cGFCTVJwdFB2?=
 =?utf-8?B?Vm55WXV2RCtBdzRZNE9aU0dkR1FEN1FaMjJ0RUduSFlDTnN0TnV4cjhrZ0hP?=
 =?utf-8?B?aTRESjhONVBqZXdyck00SDdrWEtFTUZkSEpJT2cycFB0S1BYVzZ5QVFvQ05o?=
 =?utf-8?B?aFRkaFlDdVh2N0tWbkFKejMvT1NPYUFCS1NxdEh6RU1vYjlhR21RV0pWQjJI?=
 =?utf-8?B?dE56Ym81UTJEYTJKS1NhcFNnOWxHNnZlY3cwdmFsblh0L0xPN2xMRWRDMnBH?=
 =?utf-8?B?dVAwV296dGh1WHpFZnAwL0pXZ3YxYzRHU2l1WVBwSzgxbmZVT0h3VHVWLzRH?=
 =?utf-8?B?RjltbWd6UDRjeDczOHFwc0daRVp1OFFCRHlFaTV5SGxhWTEyd2I1YmpEcUV6?=
 =?utf-8?B?a2IwRjc4Tkh3VkNEYnpZRy9GRUNKMHNvVzBVZUQ0eGlvT0kwczZDZHJRaUd1?=
 =?utf-8?B?a2FySm5rZWs0OE5ZMlcyYnVOeE5vcmRQUnV5R2FyckpzcGVsT2pYMXUvbEUv?=
 =?utf-8?B?Sk5lK3hTMEhWdkp0MFZOS0JaMm5sSEcxK2g5M1lkdHZTaFl0NGxnT1VmNUtK?=
 =?utf-8?B?dW90cDFvRVZHOU9JUjVnbHpaT0Fha2c3N0grdGluK290TS93NERWdVduM1Fv?=
 =?utf-8?B?REk2TzZqeTg4dTNUY3hsMlB4V3VBZlk1bThlZkVXN2JZdFNIK3YwQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a46088f-90e6-45b7-d0f7-08df0c2882c3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 15:07:04.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD/cio5o4Byxv120td8YQr7+uyL5s8iPVtSO+qk+F++clLz5pfe8rT83y95tR3thb0PyRTDh6Oc3NR4tj93g2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6726

On Sun, Sep 06, 2026 at 02:39:12PM +0100, Gary Guo wrote:
> On Fri Sep 4, 2026 at 3:34 PM BST, Aaron Tomlin wrote:
> > On Thu, Sep 03, 2026 at 07:13:02PM +0000, sashiko-bot@kernel.org wrote:
> >> commit 828a4fa4f29a0a3c5aba9065f4ba35eb845dddef
> >> Author: Aaron Tomlin <atomlin@atomlin.com>
> >> 
> >> module: Extend module_blacklist parameter to built-in modules
> >> 
> >> This commit extends the module_blacklist command-line parameter to apply to
> >> built-in modules. It achieves this by creating a new .initcall.modnames
> >> section to map initcalls to module names, intercepting blacklisted builtin
> >> initcalls during early boot.
> >> 
> >> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >> > index b2988aa12f664..7490278b7a2df 100644
> >> > --- a/include/asm-generic/vmlinux.lds.h
> >> > +++ b/include/asm-generic/vmlinux.lds.h
> >> > @@ -734,7 +734,8 @@
> >> >  	EARLYCON_TABLE()						\
> >> >  	LSM_TABLE()							\
> >> >  	EARLY_LSM_TABLE()						\
> >> > -	KUNIT_INIT_TABLE()
> >> > +	KUNIT_INIT_TABLE()						\
> >> > +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
> >> 
> >> [Severity: High]
> >> Does this section declaration need an alignment constraint? Without a preceding
> >> . = ALIGN(8); or similar, the __start_initcall_modnames label might capture
> >> the unaligned location counter before padding is inserted by the linker.
> >> 
> >> When iterating over this section during early boot in do_initcall_level(),
> >> could the kernel read padding bytes as garbage pointers, breaking the
> >> builtin module blacklist feature or causing an unaligned memory access panic?
> >
> > Hi Petr,
> >
> > I forgot to restore ". = ALIGN(8)" in this iteration.
> >
> > The following ensures the location counter . within .init.data is aligned
> > to an 8-byte boundary before __start_initcall_modnames = . is captured,
> > preventing any linker padding from preceding the first element of the
> > table.
> 
> Have you observed cases where this as an actual problem?
> 
> I suppose this could be fixed in the BOUNDED_SECTION_BY instead by doing
> 
>     . = ALIGN(ALIGNOF(NEXT_SECTION));

Hi Gary,

To answer your question, no. I have not observed it causing a real failure
in our current x86_64 build. This is because KUNIT_INIT_TABLE() happens to
precede it in INIT_DATA, and KUNIT_INIT_TABLE() explicitly sets '. = ALIGN(8);'
and contains 8-byte pointers, so the location counter coincidentally
arrived at an 8-byte aligned address.

However, relying on whichever section happens to precede it to maintain
8-byte alignment across all architectures and config combinations feels
fragile.

Regarding using ALIGNOF(sec): in GNU ld, ALIGNOF() only works on output
sections. Because .initcall.modnames is an input section within the
.init.data output section, GNU ld rejects it with: undefined section
.initcall.modnames referenced in expression

Placing '. = ALIGN(8);' directly before the section matches how other
8-byte aligned tables in vmlinux.lds.h (such as LSM_TABLE, EARLY_LSM_TABLE,
and KUNIT_INIT_TABLE) ensure their start labels are properly aligned.


> > Are you okay with the following?
> >
> >     --- a/include/asm-generic/vmlinux.lds.h
> >     +++ b/include/asm-generic/vmlinux.lds.h
> >     @@ -735,6 +735,7 @@
> >          LSM_TABLE()                            \
> >          EARLY_LSM_TABLE()                        \
> >          KUNIT_INIT_TABLE()                        \
> >     +    . = ALIGN(8);                            \
> >          BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
> >
> >      #define INIT_TEXT                            \
> >
> >
> >> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> >> > index bc7027f8dbb2c..a96157598197f 100644
> >> > --- a/rust/macros/module.rs
> >> > +++ b/rust/macros/module.rs
> >> [ ... ]
> >> > @@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
> >> >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> >> >                  ::core::arch::global_asm!(#global_asm);
> >> >  
> >> > +                #[cfg(not(MODULE))]
> >> > +                #[used(compiler)]
> >> > +                #[link_section = ".init.rodata"]
> >> > +                static #ident_modname_str: [u8; #name_len] = *#name_cstr.to_bytes_with_nul();
> >> 
> >> [Severity: Low]
> >> Will this cause a compilation failure for built-in Rust modules?
> >> 
> >> It attempts to initialize a fixed-size array by dereferencing a dynamically
> >> sized slice returned by to_bytes_with_nul(). This could break the build when
> >> CONFIG_MODULES=n or when a Rust module is configured as built-in.
> >
> > Hi Gary,
> >
> > Calling .to_bytes_with_nul() on &CStr returns a slice reference (&[u8]), so
> > dereferencing it yields an unsized slice ([u8]).
> >
> > To resolve this, we can follow the pattern already used in
> > rust/macros/module.rs for emitting '.modinfo' entries construct a byte
> > string literal at macro-expansion time using Literal::byte_string(). In
> > Rust, a byte string literal (b"...\0") has type &'static [u8; N], which can
> > be cleanly dereferenced with '*' into a fixed-size array [u8; N].
> >
> > Would the following be appropriate?
> 
> Looks reasonable.


Thank you Gary!


Kind regards,
-- 
Aaron Tomlin
