Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021117.outbound.protection.outlook.com [52.101.95.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464C3859EF
	for <linux-modules@vger.kernel.org>; Fri,  4 Sep 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532494; cv=fail; b=qnyVsY5Mwu1BJn1taHbmeCGPTzfZp9Kw83/rTDk198EgDP3ZOOW09AUIsCVLTC6qorhZvvaVOjGhIvTns9GNrNFuVlejfPjzVxfhBWQGRgsnH4fan5dCo2ajLYAw+jf+8OcVVb7ac2NIIFhekqONsqmb6q7i2ecwyAkqwjIh52U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532494; c=relaxed/simple;
	bh=AoJpFnB6k6SrxDbjvjhPL/txxX6eXVyHaOOzi5+KSaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KjTezjl/XHSZW4OG1QAx9pexLIt/G7CTKBA2WGfv7VQebpcCST6XWvnWVzGHSIqVV2l562/VOXGFjG1u+fklaFKdQkeMJvd2aOy7996OgGDRiRjbY2nnzerLwhWke4mjx2zwoQphyJGxZQHCrhZ7tap2zJmIOuLar2qS2iWrfc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UljjyN0k4E5yZyP5KM/W117kXNKbJt4AZ7Ua80OUqG0+7W2mP9I/YGclmH2CIaTTEEdFC7Z8epnubf4Qs4m1/jmnI2BFZrk0cq85LE9ENIev2kiTeOYimQbmqUOGHJsJ0WTD76flbG1ao45DD2gW3+fUIXJNxvJHlc8eJwQ7UvNh3PZ/hPvXAmh5dtuswq6tdCL6KmiBZRntLbTuFi9qZdd9XjzeEX7TkojkY99cmS17N9KY0O/zVQLEl3dEV2jUe0WVyY0cd/1Cjn9WzJ0Z/F/DC2V7k9SGdHJMNi4nqklGZlTwLeIXoVaYPb3PpAgjzWBjw2cA91yy0Sc9AWxMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=26YHRvEEs/dCMs+4uwNayGYevrF/h38c5/zI6YPQ1nk=;
 b=N5beSI25Ueq3nz2EtRgk6abrPa7BXQT5Op2mLFRs+khajfwpgoEG1uJMTCutKUx/PolKEyEPj8X1Ne4HNyXWI6769pMDEltylB42PRbezHSv2MG56SnlKjQEe05nYmk2W9zYk3g8PcNthL7zBso33oHyMXzDxSo3WG8Fsh7rSwG1UTJ2q+LT1SuylrcMev/f8ZGMgzEqhDkQ2cYX2amrOOvMzA04WOTUfHvgLJYUUD0C4k+TB2OsxqVua3Ib4+xrhsrvC7txSjChyQoMyBycTNTMCCMnnPEziD+kqheT0GphVntnbJAyFCgwPEnAhXxSLY/dpPKwqExRnqxAMYtfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2802.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:34:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:34:48 +0000
Date: Fri, 4 Sep 2026 10:34:44 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, petr.pavlu@suse.com, gary@garyguo.net
Cc: ojeda@kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v10 1/2] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <xuj6okhlofl4cboopwjzqe3jyfmaxgvdpf5a3ek7bubew4vcbk@nkfqgoe53533>
References: <20260903185557.183224-1-atomlin@atomlin.com>
 <20260903185557.183224-2-atomlin@atomlin.com>
 <20260903191303.5A14B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903191303.5A14B1F000E9@smtp.kernel.org>
X-ClientProxiedBy: BL0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:91::38) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2802:EE_
X-MS-Office365-Filtering-Correlation-Id: 9316e5da-796c-4db9-fc9f-08df0a91ac18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cj5QTEgC1fTNSiX6j54FQNW2p/d7xCr6D/45RXeuCoVvzsbXJZCQnXP1OrqmvFaE7/PAxPVSljcIuTkVSMMDil9mIfvPuWOC05WJ3L3kawxlW6+y2qB6Qg/gIPnRY5XcnXzetD1bSpTacndB7Vlxj5evaTcNMjr2JE+LliM/3RbfI7aFMQ/FHt9wgEEt2pnMzRc9P0ePI12C4XKmI8E0d/SR9HBiSYQx++WDpc9AfIE0APARyIVGRUYtVlvQoyzWWshh3VLpYP7mRNzTEawatyDW2v5aRES/zPQxMTB08+kD/Ap2T25/yly3foYVIVEAMugabHM0UQMNsVybkQuEWnRXhav4pYHSG3ODWHInhqDSFhZsUh2TfCu8g/lyp68JaJ6/Vco8PPuk7PCtnEp1Fxu34DNjWy+HwD+O+lDCsqQv9wnMd4sNlXi0Zfz5bkrorRDSmjH6FGE2H5Rlh2Z6/B6/UdNbjIH4U4D9fenFNu8WsTq04hgvTf5Fy217Iskw9FVCQ+uYX4Z8bdbxai5Adf4vMCjkuIA9Vee+FpMyCMqdNOdl1OML6UPLW2Wt5fRo0UUGg4br8StX4pEsdzOU34Wr727z0aagZLZann5Fhnv+0lLCsZZQljb2voq+nEei7fl9S+fe+5z6noeIkHB9TdUTLA6KCuMERnjnxO+f054=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVMSmZZL1pNQTJCSUpVZDd6eGJHYmgvb3NjeGk0T0I2RWpTallZbkpIK1U3?=
 =?utf-8?B?OC9iMHo1eXRuY2thNHVxa2s0ZS9TNmY3SHIwTXNwR1NzempHSmpJbkd2b2lO?=
 =?utf-8?B?ZHdMTEtlTmNjMVVrVkhiVmxKd0k4c1FkU3gwOHdDQzFzMDVGZmlMQmJHZTZl?=
 =?utf-8?B?bzFlczBCYVluTE1weTZQSVJKd1Y4cWdQZnIvcVl6TkJVQnhRbExWUEVoYVFn?=
 =?utf-8?B?ZSsyRkdESUFIRkRQU2VkR1VLMHhudEJvOThCTGJFZ1ZLa0xDWThqNENOd3pJ?=
 =?utf-8?B?aWxLbmhOSkQrS0xkOXJSTndheGVPalVJbWF5RWhDcTZhTmlyU1VHVFhmQTc2?=
 =?utf-8?B?clJqR3hrTG9BQ3Bhck9lNm96TjZ5aDRoMjE5VVFBU05DWitUMVppcDhjZUFw?=
 =?utf-8?B?R0oxOVdnSEYzbVJUeklKQ0h5MVk5UWEraEFCVDloK2hmZURNOWJ5TWZjKy8y?=
 =?utf-8?B?TklHcHRUSnp0cmxtV3NYdjFQUzRBblg3WXpFNGFnUURWcUluVjVNWGJ0UlNt?=
 =?utf-8?B?QVFXclJIcnpvUjgvVHRQMHFwcGo5cnVnT0FIZXc5WWtZTHNiWGVZZDZkcEhk?=
 =?utf-8?B?d1QxeGZiVDJIZUZUNjJlZXlIdVB4VURVRnlRSHB3ZXNnMy9oMlJ0S1NET05Y?=
 =?utf-8?B?ZDhXa0M4STArSVZnMlp0cDR2OXNVZ1NmRVJ6QTdnUzNYR2FidWdLbGJDOGhE?=
 =?utf-8?B?RFZFZmh5TlFSb0xUYVphaUkweFliQXJ6NnQyRk1zVkpkVUlLRVVpZnkvaWxr?=
 =?utf-8?B?bmd0SldmMGNLRzFPWXJrek5hQWpPU1FMZjhkWmtmNjd4S09xRDE2aGtVdUtH?=
 =?utf-8?B?QTE1dk4xQmxPUkN5Nkx4eG9RYTVUV28vVUZzemhKak5ldVp5TXRzeFNsR214?=
 =?utf-8?B?TWowVFF4c1RKRjBMWXNyUTJ6SUphNEF1ZmxRcWprMmZkUDloaGc5Z2U2b0V6?=
 =?utf-8?B?U2JvenVJTnQvckVtNm9WUm5WbFBTMmRCNGZaYyt5dCtzVmkxekYwN0xoREdx?=
 =?utf-8?B?UVd5NXNxeHU3ME9sdUVwck1uMGpyQzNjL3dGd0FheUY4MEIwOWRLQW9zbmpt?=
 =?utf-8?B?QTRSRkNOK1dOSldESDgyU0g3cEMwQ0FlSWNQZGxXRjhYcWlaS2VsRFhxT25k?=
 =?utf-8?B?S244TGFRWHpONlZ2VFpJblVhblErV0VaN1NUQWNBSHdZaG5Nb1kweHZyeU5H?=
 =?utf-8?B?MnhoUVVaOU9raTZEUWw5aDA0Ti85YkpsbCtmbmFzRm40bWdvR2l6a3p2NS9Q?=
 =?utf-8?B?ZXBBY1VKc05qVVV3cnRDRDBURWVZVVQxTGV6dGNZZ3dJYTF3K2pSWHlHTWYx?=
 =?utf-8?B?djh5VlZFbGRCaTk4dFFNd2pXSWtPVktZZmlNbk15ZG52MGxJdXZXUzR0QzFI?=
 =?utf-8?B?MUZXRzZTSHRkMjNESmdQUnZzZDhGZ0NwcG9qR3NpSE9paUNOQnU0eGgrVkx2?=
 =?utf-8?B?TVl0MTdHb2k2TWdnb3V1R1V6SThYbXJqT1dTODBtVEZBTjdaMWdyRUU1NlY1?=
 =?utf-8?B?Y2hIOVR6SHIyS1BNMGxoQUhaS0liVWI2bFRsK3ZFSmZYME5lSTBpMmJBUS96?=
 =?utf-8?B?dWFmOVRuZUZRVUl4STlQNTgwZTIyZnZmTFZXRmZGaURzTi9jMzRLSTRwcVRw?=
 =?utf-8?B?Rkx2dDA5SmJleVM3d0hNcmtINEVQbG9aUmNKNjBhdXdHVGgrNWNQbHZxL3ky?=
 =?utf-8?B?c29Ib25MRkVmNFZNUHJjUmxMZWxaMUV3Zmtoa251UVljK241THBRbWJuR2JN?=
 =?utf-8?B?MVd4QUw0L05KSkM0Nnk5YWRsMmNXYmcxbGFHYndIVXYxTE5UbGtJTWM5clpp?=
 =?utf-8?B?UnVIQzBDWFBvbS9HcDA2d1RFOUVHMlBmbWEwZ1E1aGhXL0FTN0dtdE0yNGdM?=
 =?utf-8?B?eGRSOXNJK1g0SDB4MGRRL3d5WkdUODNJUUViUGV2ZHRUWlNmWUFNb2R1d05q?=
 =?utf-8?B?bS9rak5iL3hGbDJNaFhSd1ZRaWE5bEhDWDBiUXYzbVN0NVY1YzRXbFh1ZjNH?=
 =?utf-8?B?UzBOOFVXdDcvcE9GMktJdkIzTnRDR0U5QTN5bjIrMER2TVlZbmhIa0FiRlEr?=
 =?utf-8?B?Z2xaQ1krSi9FQW5sMW9udmhzeVJrQTJoalUySHBxNHdOMWFmRGVzM1JRVGEy?=
 =?utf-8?B?SitlL2tKWmRaZ21keDdqejgyUzRWdXRWZnNHV1N3K1JOaVgvalJKMzR1WWlK?=
 =?utf-8?B?SWR2MURZSDFIdUxOdGpFL21iTWF5ekx1Y09vOEhpM01aOWtSN2VYS21BMDVm?=
 =?utf-8?B?MjVOOXBHQWd6L3dHSStXa2k1U2VNMmIvcnE5dDZCNUpaRFZRTXN2V28yaC8x?=
 =?utf-8?B?bGJvZi9SdEwySlptZmIvNFIzMithZDFNVTA3WHVNZTllUkUzSE5MUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9316e5da-796c-4db9-fc9f-08df0a91ac18
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:34:48.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOoiAp1e4JmveKrLprC3TmWAAT+1KItZPpTinKMqdAB3km2tEbLrA2aDJHSQc9hxj3lGb+WsJVjIk3YCU9dU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2802

On Thu, Sep 03, 2026 at 07:13:02PM +0000, sashiko-bot@kernel.org wrote:
> commit 828a4fa4f29a0a3c5aba9065f4ba35eb845dddef
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> module: Extend module_blacklist parameter to built-in modules
> 
> This commit extends the module_blacklist command-line parameter to apply to
> built-in modules. It achieves this by creating a new .initcall.modnames
> section to map initcalls to module names, intercepting blacklisted builtin
> initcalls during early boot.
> 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index b2988aa12f664..7490278b7a2df 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -734,7 +734,8 @@
> >  	EARLYCON_TABLE()						\
> >  	LSM_TABLE()							\
> >  	EARLY_LSM_TABLE()						\
> > -	KUNIT_INIT_TABLE()
> > +	KUNIT_INIT_TABLE()						\
> > +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
> 
> [Severity: High]
> Does this section declaration need an alignment constraint? Without a preceding
> . = ALIGN(8); or similar, the __start_initcall_modnames label might capture
> the unaligned location counter before padding is inserted by the linker.
> 
> When iterating over this section during early boot in do_initcall_level(),
> could the kernel read padding bytes as garbage pointers, breaking the
> builtin module blacklist feature or causing an unaligned memory access panic?

Hi Petr,

I forgot to restore ". = ALIGN(8)" in this iteration.

The following ensures the location counter . within .init.data is aligned
to an 8-byte boundary before __start_initcall_modnames = . is captured,
preventing any linker padding from preceding the first element of the
table.

Are you okay with the following?

    --- a/include/asm-generic/vmlinux.lds.h
    +++ b/include/asm-generic/vmlinux.lds.h
    @@ -735,6 +735,7 @@
         LSM_TABLE()                            \
         EARLY_LSM_TABLE()                        \
         KUNIT_INIT_TABLE()                        \
    +    . = ALIGN(8);                            \
         BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)

     #define INIT_TEXT                            \


> > diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> > index bc7027f8dbb2c..a96157598197f 100644
> > --- a/rust/macros/module.rs
> > +++ b/rust/macros/module.rs
> [ ... ]
> > @@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
> >                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> >                  ::core::arch::global_asm!(#global_asm);
> >  
> > +                #[cfg(not(MODULE))]
> > +                #[used(compiler)]
> > +                #[link_section = ".init.rodata"]
> > +                static #ident_modname_str: [u8; #name_len] = *#name_cstr.to_bytes_with_nul();
> 
> [Severity: Low]
> Will this cause a compilation failure for built-in Rust modules?
> 
> It attempts to initialize a fixed-size array by dereferencing a dynamically
> sized slice returned by to_bytes_with_nul(). This could break the build when
> CONFIG_MODULES=n or when a Rust module is configured as built-in.

Hi Gary,

Calling .to_bytes_with_nul() on &CStr returns a slice reference (&[u8]), so
dereferencing it yields an unsized slice ([u8]).

To resolve this, we can follow the pattern already used in
rust/macros/module.rs for emitting '.modinfo' entries construct a byte
string literal at macro-expansion time using Literal::byte_string(). In
Rust, a byte string literal (b"...\0") has type &'static [u8; N], which can
be cleanly dereferenced with '*' into a fixed-size array [u8; N].

Would the following be appropriate?

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a96157598197..67e3df8d4389 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -493,7 +493,9 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     );

     let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
-    let name_len = name_cstr.to_bytes_with_nul().len();
+    let name_bytes = name_cstr.to_bytes_with_nul();
+    let name_len = name_bytes.len();
+    let name_byte_literal = Literal::byte_string(name_bytes);

     Ok(quote! {
         /// The module name.
@@ -596,7 +598,7 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(not(MODULE))]
                 #[used(compiler)]
                 #[link_section = ".init.rodata"]
-                static #ident_modname_str: [u8; #name_len] = *#name_cstr.to_bytes_with_nul();
+                static #ident_modname_str: [u8; #name_len] = *#name_byte_literal;

                 #[cfg(not(MODULE))]
                 #[used(compiler)]


Kind regards,
-- 
Aaron Tomlin
