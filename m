Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C43F210F;
	Tue, 28 Apr 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374657; cv=fail; b=FqRBIBGmEt2Ph5JHP2DVAXONApdE5yH3JdfTrkuZyAaMNHpyXo3Au7L9cIBCHHpi3ILwZYkWuCoWLmcI3iDU3heCPZNcmkJb4vw8jy6SCUK+VnsZDk81+O0tvO4KoWUT8HEnWjpIQcDlQ1xtvE+SIM38NBwl9moTaMUMB3r9o1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374657; c=relaxed/simple;
	bh=z70S1gJx11eiD98H+mte14IrD5JxIBQ1Rct8ijXmO8U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XMyiYBMciEprGp0ZVi2a2SgmtfgUW/62YgbSWDd/U6LFx+J6pznEXNxOjOITB7dFAU+z5MPTrWFa9hkQ3Z5m1S27iHi2Iiv8efQcIBoAkFNWT3YEJGRNHtQUsl+ooU/caa+FcdL3ox5WNQohPZP+dqvj5+tJwmXyjM/igBnfHG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vxBl7FXU; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vxBl7FXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOOHZUSrKJDANGlHLnaD4wljszUzb0ueaXkY0ubNMkWF6CPT9GHJsgWpqhLCz2Z7uguSnT46jnsp4Qdg1BiN5h45kOVNx00uyF5WW7qKpNCU8K2lwOtcFKa97iefoDQJVlL7rvY1UgdfNTIx6UjN2AM3sm9KVCwIg4toasveMGwfu33llmVNijz8eqvLfchSnVMbW83p4r5nizerig6Va0mTzlIsbTWvdh5q7CmuHSGh7lpBJOZJRBy60POTDZOx0RmPqNaCnac/OtyCxVn5/bS/qIN7DIISuWi85HErv1MXylD1ohHF5pnmYWBrbnAhNUV4zIpTQOliEneObx4H5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOWbkNYaOXa8HjhpgCfanb0UICU2SvQQvUKJYhRS5kk=;
 b=DWfMCNymbEGUWU7o18/DoTXUtxS50rBpLBuoYQhicdZ3g9BAVuZBzh11NC1DnBFgHLGVvAePvTzDwklzERi5dIGxqdq62p7eZNx5fM8R6Ack3OCDR7kAHclDyxREmNyENGSXk3lTpfL5dnvxILI/PSUnWVByZ1e0tKDltrt1CgZsCYJccbeDq60hjzeRCXQ9U6vSTjRaxCxCSRIWTL5MQP3PXEvIee53PNjNnCu+QTILJJDru/dR33+e+JoIQgW0GrccbX9JYB/mDKiCJorvW+cY5G2YZi6cOm+r9dcUSj3hGlTMbbCeOC1K9ObvWdISV0Z03vEn9I9TA+H4StiJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOWbkNYaOXa8HjhpgCfanb0UICU2SvQQvUKJYhRS5kk=;
 b=vxBl7FXUDFyG8u9b0zxwXr3J0hBSosJ70S4tZmFcfXkuX6MgP9mtqfNlpS0/h2HjQgzVG5YrFmo7bOWLLUyfZy15DfItpfcuFu1q01Yw02KZVQPzLc0UO5mKmF2KD2z82JbgqWYpOEFVrURm8X5WdUAyHrroWs1mXMXK1BmM+zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2892.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:10:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:10:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:10:50 +0100
Message-Id: <DI4QQA6EGIA1.N8WRFWVKG91S@garyguo.net>
Cc: "Suzuki K Poulose" <suzuki.poulose@arm.com>, "James Clark"
 <james.clark@linaro.org>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Richard Cochran"
 <richardcochran@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin"
 <atomlin@atomlin.com>, "Mike Leach" <mike.leach@arm.com>, "Leo Yan"
 <leo.yan@arm.com>, "Rahul Bukte" <rahul.bukte@sony.com>,
 <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
 <linux-arm-kernel@lists.infradead.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Daniel
 Palmer" <daniel.palmer@sony.com>, "Tim Bird" <tim.bird@sony.com>,
 <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] kernel: param: initialize module_kset before
 do_initcalls()
From: "Gary Guo" <gary@garyguo.net>
To: "Shashank Balaji" <shashank.mahadasyam@sony.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
 <20260427-acpi_mod_name-v4-1-22b42240c9bf@sony.com>
 <DI3Z28IZZOT9.349TTWNN9VDMB@garyguo.net> <afABOMT_s9DvF6NY@JPC00244420>
In-Reply-To: <afABOMT_s9DvF6NY@JPC00244420>
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2892:EE_
X-MS-Office365-Filtering-Correlation-Id: ca193b7d-0242-456f-b0d5-08dea516cebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wAgTvcQomEl13w18R0UMiJJJOaRKR1oFc2x59ArlA/vLFu1gjme7ICdf2mzPYp/I90NhlD5hGepdBQjvvZaOw5gOo6aXby0Xkp5c8sjezq63PTeZ3HlN/M1EUrx7U+iMsjMRWmZzalzEi+5Mvu2rDoMAvSPpTMUrn2Rg5vF8v1NzYLpsMPRrkmWMF6CDFCQzkbCjSPzhkfZWTT++RBRW8fCM1SX+0lplO7WY9XJLCuUjH/JeLhqUAXjDKvYzLc9vP9MQBBKgFP5LjP5unamyn8eCofyt21jQlCOy5qCAwfrRaEZO/ENxGbl7lxxrRtcF95pe+wbqKPRcgttTSg8S75NIPWyB4CKEa6ddZDtNdB453c0SX13GVqt9Bgy19uVlbD4sK+VZqVf0L20ZsYkHOJMpeJahUPWZB27i6d3CeoUifIovqGlXbaC07cjdBUjVrfi1u6Sgp5RadQ31m/4Mc2r9KA1z7C2TSMKW2eSKnnz9jZ3wkuMgXPyQH1s8NJ9cfcooHOtSgzU56nYFbkbPxzxf/LvbJkUvZvEPVX8O7KQPRyD/co2nJP6s/nEeB3ChQz64xenFu806R8Yg8xftCO5vPgKY+XK0mmiSsiRZCVp+Xhfqi7qBqBjWdQ6aaRKcA1ev74OxkVdllzS2QfLmQqjlt7u8WRWwukBlf1M4wvQpYlLs5AznyNNyBGATU3eg49FTO5VV0Qvv/p5S5TYj1S3MvujHnRwTiCgfh++7AlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21PWGRJL0p1dVp3VWRBTDVFQjNVRHpyUGZIZThYLy95clFGK09tU1JKOFNP?=
 =?utf-8?B?bGp6dytjbWc1YUdoUFM2RjduS0NZazl1YTRmRkFWR0xRV3VUVkxiQkw0Umsx?=
 =?utf-8?B?RW9iOE8vcDNVVGNPSjBBV2JSYTVIaWZKRzlvTnR2NHhQbUQ5RkhPOXJlSkFD?=
 =?utf-8?B?YWZjS3JkK29ZVXVZQWVQT05FLzl2RUZaU2Z3SHVoY0JtR2ZGQm51T2dqU21m?=
 =?utf-8?B?Q2xiUFZCN3dhR0tVVjFaVUI3bWhHWUdNU2hzY0NOdUJKVGZVTWJPa3h2NVA2?=
 =?utf-8?B?MXhKQXRCcHkxbUNWajlTTUYvMlpMZFJHbUdYZWxMeG96TVdUb0NHalJxOWhJ?=
 =?utf-8?B?NGtxZm9xRnYzTSt1ZzRWQkw1M0xyVjRmeW9VVWEwV0s0eGZjbnh3VFUwZDNI?=
 =?utf-8?B?amZPeWtRY1d0cWNNZHh5Y2NpZGN4OEUzZEIyajNHdzhBYnVIL0lXajRxdENy?=
 =?utf-8?B?c1BlMzJQNW5aMTJIYzQyRzlCRFJZVnJLL3hnLzJkUHpTM0ZxREFTeFNQcFdz?=
 =?utf-8?B?bFVLckx3UTYzTTNPMzFzdVpFZDdTU2NUcGZSdVFsQVMvUTZRSWhIYkl5dUlv?=
 =?utf-8?B?MGw0Zk14RGtpbk1UNU5YTVhvRDYxKzVQZ3ZhOGpEcXQrZVZzaEwvUHI1NUll?=
 =?utf-8?B?K1g3S2hCZGlXM3pYOG1sT3lseENEK2V2OEhzcFhmcDBNU3NGdWtRU2xVRFlP?=
 =?utf-8?B?ZEJXMHNvdk5XY0ZXSGNRMXNhaEV4YVhyOXZ1dzNJeEpQOHRWT2syZ3pHTnRi?=
 =?utf-8?B?OE04TTlsOHRmbUhjNklPUXRwSDZJaUs5dmhBUkxCN0sxQ2loMTF6dEovYkFl?=
 =?utf-8?B?N2FyZVpMNlhUaVlhejA4MWZuV1hlOXFwdmJOTFozOERtOEVqd05ybG9vdmQv?=
 =?utf-8?B?VU41Wk5uRDI4aUtoNjk3bHdZemd6YlcxZVFCSVVRNkp5OHVCUG1seENYOFdF?=
 =?utf-8?B?cFdCaHVNWUFuVTZwQTh1ZXl5U29wd1ZMRENRbG45M2Y5T3AzYmlUVWlMeVZl?=
 =?utf-8?B?SFdWd0luYmk2dXhFVHB2Z0kybGthWk9CMVRVY3BZTVEzbFg5bExPdXBCaXVy?=
 =?utf-8?B?R25MeURVRm82aFBFcFVDcEFxOUV6MHk0UkVBV21nWHdYVUJ1Vm0wTEdMY2xX?=
 =?utf-8?B?b0h2SGNMZUFUU04ybU9zbFpWcXdvZGM0bWk2SXEyQ2tSSEZKalJia1dpMkJm?=
 =?utf-8?B?aEdEVVZRRHZLdEI3L0RGaG52TGNDbk0wdnR4YncwTDV0c2FmdjdmeHNDWG5j?=
 =?utf-8?B?UVVZL3NVTk9kVHFHM1FMdkRsejRGZ2pvVURwMTlzVTczTEw3NnFhdVJBaWtN?=
 =?utf-8?B?NjNWWFdQcHlSdktFYnBtdnd4VDhtdlZIbDZwVFRYS2lSb2Jpa29hWkFnc2xO?=
 =?utf-8?B?THlVVjcrRU5pS0Z5SWJKK1E4ZWExcUxVWEpOcUp5QWcySmJLRGxMQ2dSdGk3?=
 =?utf-8?B?djB2TUx1eFNlTk15VzUwY2w0a3ZDWjFvdHV5ZkFVV3ovRmE5RG9nK2Z1cnUw?=
 =?utf-8?B?OU9mc2IyZTlGaHRCYk5BNWppNGRiRXB4TURsL2ZLa0VBZ25TVkFVazNrMk5T?=
 =?utf-8?B?NTFtZlN6WWRXaDZxUEdJUEl1MWZmMjJ2em53ZUVDcUw4dDhGaWg2QWUyZ2Rn?=
 =?utf-8?B?aldLdElxVU8rVnFNRHgzaVJLQm9WankyRER3S1c1Z0NmOWZDdUZHT210YzZF?=
 =?utf-8?B?Z1BYdmR4NTlYUmhMRDV6YWVPOGhzNlQ5N0RkRUVJZVNIUDlBdUJ1bW5VNyth?=
 =?utf-8?B?RUZ6elRONWxxVzliRVJLczdOazkyUUdORGtjSTl1R2dvYXVjeGplV3pYZVVa?=
 =?utf-8?B?SUJUaDNsbVFCRXVvbVZjQTc4MnhDSjM1d3pSNUdxZmliUmp0ZGZ2Zy93NFpO?=
 =?utf-8?B?VWw3OFdKNlJCZVFqYS9Ba1d2RU5YRHMvd1FTbW9VR3RhNWRlQWg5SzE5RlNT?=
 =?utf-8?B?QmNrRFlWcURtaDhQYW9sTXJpM1Z2eXN5M2ZlRnFGSDdYeFlCdEFIQnhaVWhI?=
 =?utf-8?B?R1lCcmNEVnNwVytjei80ZkFHc2VaakJ5MTc3eTFVbzZSV1M3dzl2SWYyb2Nz?=
 =?utf-8?B?Q0Q3eks0ZXdRWjlVdjQxRzlYYjFDbUVGdGhCT1dJUFZmS2ZSZGREUGFzQ2Vh?=
 =?utf-8?B?UThrbzloQ3A5YWNTM2NmMXNWOGh2T1ZLRk0wYzNGR0RvK0l0cE9yVHlVMlZl?=
 =?utf-8?B?L0M4SUFYVm95dHRneVJORytmK21PWXZBbld1VGhkN2NiVGhpdi9sZzBsTERu?=
 =?utf-8?B?K2Y0LzRqOGVlSDVmZENTaUVwczVNK2dlSUhjRmR1VW5SOGwyTnFNbjhnUStk?=
 =?utf-8?B?NzNsRjMwSG50alMyNEhKUCtLV0FlMmZYVkVVZmkzUldCNEQvRk1oUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ca193b7d-0242-456f-b0d5-08dea516cebd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:10:51.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMTZwg03cQz4eVqfegxy+BotoQximZoBYKNVNQTvZIfbWdc9d9pNZqsUSnos8wYjlK3j9oQWqer1Lf03V5uJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2892

On Tue Apr 28, 2026 at 1:37 AM BST, Shashank Balaji wrote:
> Hi Gary,
>
> On Mon, Apr 27, 2026 at 02:29:55PM +0100, Gary Guo wrote:
>> On Mon Apr 27, 2026 at 3:41 AM BST, Shashank Balaji wrote:
>> > module_kset is initialized in param_sysfs_init(), a subsys_initcall. A=
 number
>> > of platform drivers register themselves prior to subsys_initcalls
>> > (tegra194_cbb_driver registers in a pure_initcall, for example). With =
an
>> > upcoming patch ("driver core: platform: set mod_name in driver registr=
ation")
>> > that sets their mod_name in struct device_driver, lookup_or_create_mod=
ule_kobject()
>> > will be called for those drivers, which calls kset_find_obj(module_kse=
t, mod_name).
>> > This causes a null deref because module_kset isn't alive yet.
>> >
>> > Fix this by initializing module_kset in do_basic_setup() before do_ini=
tcalls().
>> > Modernize the pr_warn while we're at it.
>> >
>> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Suggested-by: Gary Guo <gary@garyguo.net>
>>=20
>> I didn't suggest this change :)
>>=20
>> I suggested `pure_initcall`, which is just a one line change.
>
> Oops, sorry about the misattribution.
>
>> diff --git a/kernel/params.c b/kernel/params.c
>> index 74d620bc2521..ac088d4b09a9 100644
>> --- a/kernel/params.c
>> +++ b/kernel/params.c
>> @@ -957,7 +957,7 @@ static int __init param_sysfs_init(void)
>> =20
>>  	return 0;
>>  }
>> -subsys_initcall(param_sysfs_init);
>> +pure_initcall(param_sysfs_init);
>> =20
>>  /*
>>   * param_sysfs_builtin_init - add sysfs version and parameter
>>=20
>> pure_initcall is level 0 so it happens before all other init calls. Does=
 it not
>> work?
>
> tegra194_cbb_driver registers itself in a pure_initcall too. We wouldn't
> want the ordering of its registration and module_kset init to be link ord=
er
> dependent.

It's the only device driver that does this. And I don't think it's supposed=
 to.

From documentation:

> A "pure" initcall has no dependencies on anything else, and purely
> initializes variables that couldn't be statically initialized.

I understand that given large amount of drivers registering themselves duri=
ng
core/arch_initcall that there might be regressions if all of them are moved=
, but
surely we can demote these two specific tegra driver to core/postcore_initc=
all?
This will still be called earlier than init_machine call which happens duri=
ng
arch_initcall.

Looks like the tegra CBB driver is just doing error logging anyway.

Best,
Gary

