Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022084.outbound.protection.outlook.com [52.101.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5B369D6B;
	Fri, 29 May 2026 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057333; cv=fail; b=OldW6AYGWr6RkujNooqbQpFITM/hAfnC1HBKp8LLpE0L25pzzKLLEemrBUHrmy+0xY+vh6uHBgUc3V6l4Zmdh8Ohpx561UTVZAurJYSsVEkagigilDNpN6T5cjHEuLFeRAi8Y6W8zPxd8WAPsq/oRdu3TA2u5wbJ9rNCWVbIL70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057333; c=relaxed/simple;
	bh=ETagk04eBntkGYdqR3tq6zoPyI31ph2U89HL0DD52mc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=aCT1PYN04bNNjaPn0/0FrAuS3ZSR8p3thOoNmHDnGrVB7ostWvK4nsCvMaQoU7e30tDoZtMFr7LEb+8EgdY0eRbbmq/BPA2UWueBbkPCasEBIHfFMQKzDBe+tAvpgmhkbOtYcuhp82SZyEE+nl7y+6NqUAvKcRO7gr5fRrtotaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kK4XCYj6; arc=fail smtp.client-ip=52.101.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kK4XCYj6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jpbd3liuK/NBNaKVI7gtMM3KP37SI/vP9vQ8ePKVpsR+SvjsrQaBO+hCbBGCTWHiImr4k2NeOI2y1m6Ak5P0pXsnM7ZSO94fpN+tf/LSaXuZIYOSi6rIcOQVaNMD7S9+2hZCI+bLXALw+G/9RJJAO70k5PUPW7jWWtUKhPj8O1oNkl7poiK/QRbnxbmn2phMY7O5rD9DyQipilGssyCJyzKhPMPtg42FGtmeFUN9ksIKpJS6+gW3UlOHZhKabTYr4wgUwgLq/gK81cR4zY9A9XeeC8fsaV8ghwVKwfZdNvVm6xyUHoFeb3y2UQAY9CijXmJhoOglHetIrHTEgF0sUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS0DHUvpYJkOR31D79iTdOg94pPOnkT0yn1CE66spfA=;
 b=osv5n7hDG6bqu6qw8az1I50xxfXOL8Hl2jZxkUv7BGMlsQxmWYzzJ5J7feWdedPqCqCAvTbendqlNWAikBIYZjRbwUu0Bc47S68OkVVMod39GoqvpMof2XBjNHkgXvVyyBA6+ti2aL0hGbPduhNjyskyF01ZblL1d5Uj/qdRW/LYHZdygOHxyZp8DUUYnot+cdtJ8Prg6G4Q+DkO1qi3cju8U/OeWlFK3N6fky86lCBNL2RU2sKL1OqEizcqteiRNFCGMBO1t3eHItm722mZHjMEU6hZks7cWiiktpxk9WjHvK2IXAaNvj9LcEqVQrDtXIdTeSHGY8AAgA+WXpHy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS0DHUvpYJkOR31D79iTdOg94pPOnkT0yn1CE66spfA=;
 b=kK4XCYj6Otu4cmMKxI6OS+i47TJU0cQ3cc4jXnkv/64tsL8hOaUJjV+X/UmH0JP2h27PstUVoU78Y1aN8dmm3x/GzXf/Hdn7vW70kLkgG+W+/XuShri7KFSotRV+HfLo2N6iKMi3k33KbXgAHsbfFVnabMVeBcOEBexYgI+XDFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9078.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:497::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 12:22:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 12:22:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:22:09 +0100
Message-Id: <DIV5NRUFAGLY.1RH2GL15CYQCG@garyguo.net>
Subject: Re: [PATCH] rust: module_param: return value by copy from `value`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org>
In-Reply-To: <20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org>
X-ClientProxiedBy: LO4P123CA0571.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: eda73657-dfda-4517-2709-08debd7ce7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|18002099003|22082099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	6XJawLoy0deYq5q32GhTG+NvonnY8BXcIjs2ftu/aVVEss8OEvY6zntMJLEOc5S5tpRCoszaKSfCY8eit3Ke1YXzMFaaTwjXNXv1xttvxzj5dGJ12gCTduGNkWJbRQrj9UoNB8LHbhq7oHPHHQs7quYtJonObgtC4KsaVfZ36igcfrcvsKu1v8Bmsr2BuuptX2TvMqky25m1TbLQhcjY4I+zHYLN/x/phzu5cd9UOrhTDBrsO09fkDjDD6YnRM2PRANtBDoP7PSCvl+kr2MS1dCDrV4QTgP+JngUvwIBGplOntbQwv0fEXx2xzS8a7DWgX0LZ4MEJjgFx0Kk9lhCBqSfrCgS6wDPdssszi4BrD3l6vGXLTJ3H8YK7Rxaj9PxeZkheCKE00M/oecKxx0vbUCdOdbv67Lrj1ZOINfC9e0e/AyuTZTVDuDtgL+hOmkB84NKdm7TWAa/lWOSDARzxyGcnEiyVGkEgNojEav2q4GvnVqzebq5XfJAV4qyvkWTH8m5G0Fxdjs9si1ZTuR9lPQitPYzlWBGv111Z/DN+m+yYEibNlp7w2M08wE3KFrcoEhp0jOpYsEXdneRjyd/esO39R1K0r36ZIfWCURkXtXp/aPgUYTL4Y1oTVxpyDurL6lOfu59pZtSqWUOAusczgpKPB0qdCgz0CuEeAZIZDn2TCaNKB2UQlO0lGqsCRCs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(18002099003)(22082099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFF1YTlsUTNmMCtOekZRSDRwSjRwYUNmQ3VjVEVEREFKdEZybFE5UVltQWhD?=
 =?utf-8?B?ZWlCNjk2cGtwemdQejBsdXd0a1lsZDNhcHdCV3JpdzhDUXF0ZTAwTWdNRldG?=
 =?utf-8?B?SWRYUCt5T09IY0tWeHBEY3U2SGpBeTdueC8yYnhvWWNCV3FwaFdnOUJwejRz?=
 =?utf-8?B?WERTOHROVmpQcm1kUy82cE1oWGQ2a2h4cG1oa01CY1hpNG5PSXQ1ZzJDYW1I?=
 =?utf-8?B?eHhMenlrZUloRHE2Y3JOSHJEMkRZd09VSmJqcnR4dWI1VWZERzBLQzNMcTV3?=
 =?utf-8?B?MXZtWnpFdkx3TXg1SDRDNytmNGRTN3dmMTVyODVBQ2R1SVZGRVVBMWtWdWgr?=
 =?utf-8?B?Z0Q4OG9wd0gyS1UxelJoOVdGclVBZnNSb0UyQ0VXOEs0cmRvWFQxOE91dWJt?=
 =?utf-8?B?VVp3ellaNXlqYlBJczBaNVlXdHBTTktnNkIzZHMwNW9yYXdHOWpqbEltUUlN?=
 =?utf-8?B?bjFWTGhqVG51dkk0M1hrbVcxTVJERnBnb2NQS2RKVExRWVZYanJpeENsa3Ir?=
 =?utf-8?B?RGJJdU45RHdDd2VoUVNqVTZGMDk4YTNnajczV01pVXYrTlBRSlFEYjRnV1dJ?=
 =?utf-8?B?czJjTDRNZnMvMm1TZ3oraVNJTUQvenFZMnJBK0VRekFWV1Y5WnVrc1I1WXpU?=
 =?utf-8?B?bGdjMTNzZm9makUxQ2c3eFFDdCt1cnpkNVNRLzdlQTEwOWx4cHBWZ2ZGSHZN?=
 =?utf-8?B?SG82MENGRlVwcXpJZnBQc09aL2M2V1F4WnRYbExtY2dudWlHckZrRFhoekxU?=
 =?utf-8?B?MW1GZWlHVENTZjNJQ3E4ZXh2aWNGSzh4YjlmT2Y3ZGoxQ0hGVld5WmZpdG8y?=
 =?utf-8?B?M3RPUTFWcU1qOUw4OHdIM1dQNHRUaFVHTG42VkFuU09mUjBPSUZNaHZGWDU4?=
 =?utf-8?B?QTA5cExBb2FDUWxBajdYL2ozcE9IcFZnT2t6RkdYQmxCR3JRUUpjQnZQcUhF?=
 =?utf-8?B?Vy90WVpqbmdXb1dzdVZzR1ZqV0thbmVzTzVKajZlcDErbG10VFpzUWFuUWhl?=
 =?utf-8?B?a2F4REhaVHVKNDhPYndWWGNqN28ySFFJV2lPL2JXNFhJaGtRL3MvVDNoYzZp?=
 =?utf-8?B?VGlyUElpZTVFNmVyVG55Ri9iN1NndENjaEs5M1hmV2VTMnFuSFRqcGFPc2FZ?=
 =?utf-8?B?ZVQvL0hFNEFSRVZIQjhROWlsUE5PeExqZFl0VW5uYU1iQVQ4T1RtL2JCbmJx?=
 =?utf-8?B?eHNzYzBpTkFMbHBPOCtwbzl3WHYvR3BFSVh2VUxGekliSGZBeEFGUHd0TzNh?=
 =?utf-8?B?STMwN2pEZjAzMWxZamFyM3VlNmk2cEVlTWkwb1U0S05abkdLYWdHQUNZdnUx?=
 =?utf-8?B?dC9kQmhIMXJLMEQ1UWU2dmE1amhKZ1QveWVqUGlFTk8xOHU4N29sQlFXeW5D?=
 =?utf-8?B?NzRzM0Q5T2NKK01ydko4b1ZneGl6MnVZOGtvZFNUT3ZPdVBPeERNbVNOU0s3?=
 =?utf-8?B?RHd5RjFiQlVQL1Z6YUdjcjlnRkhEUSs3Z21maCtibUhUakdiOEdoa2w5djRv?=
 =?utf-8?B?Mk1vQ2N0dU9zYzFud24zckxWMkVGSjY0YzZIVCtwbVZWdkZhODRIRDZYU0JU?=
 =?utf-8?B?cGw2UUpzak5zZitsb0dEWFZXMXN4NG1sM1Bkc1pvY25ETksxdzhCb3VUQkh0?=
 =?utf-8?B?dW1Pcm9scHk1WmJuWmNPcDh1ZjRNNm1icTlILzdPejgxeG1PQVBuQ1FwOWsz?=
 =?utf-8?B?bzBJOU9HQ3p1dDdtVU1ad2NsbFRnNzVuTEE0NlZ5SGdaOWtTRWRCdTFSYSti?=
 =?utf-8?B?NUxyU1IvVDlYelIwUTRwcUlobjl4NVR2aEZDSk1TcUJPMTBMUUd1a2ExeHFB?=
 =?utf-8?B?Mjh4eWphS2ZkVGhWeStPdzBHMHN3ajJNVGljbmw3dVF2VXI3RUo5K1hNOWIy?=
 =?utf-8?B?ZFBIRlpWUFcyQkpmSW12SC9GWGYwekttenFyTXNjUHlCQ0pyZk9TUFowcnhT?=
 =?utf-8?B?bktTdHRWRCtkaTdXTkpxN0JoV2xrWmhQem9nYmlnMExhdGNSdlo3K1VmNlVD?=
 =?utf-8?B?UHRTM3ZQamNRbHNlT2plSW4xQTJlMk9GbzB5dk9FVnFWdDdTUE5aSmJ2RlZ3?=
 =?utf-8?B?RVpzTE1TMVAzbW1iRlFiQkpNa3ZwYy8yU1V2M01QQW9YTWxJS2Q3dDd3WmpH?=
 =?utf-8?B?RWZHRnpleWhqQUZkNUkzdFJPQ2ZSMHI0UFZDbzVaYkpTWUNWZ0FYazdtZUV0?=
 =?utf-8?B?aTBpaytpMGJGUHZJLzVRalkvTlI2K2FNbnJ2VEEzYU9SZ1hDN0Z6VUlXdEEx?=
 =?utf-8?B?TVRVMlEwMkFKV2xLL1U2NTVhZk1LZW9uMHduNGJjQVZudmFyS0dLdTRxZnYw?=
 =?utf-8?B?U2xXL2IyU09raEkvOGExSk1pbTN6QmliYVdqb3F2UGtuNFBWL2xOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eda73657-dfda-4517-2709-08debd7ce7b9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 12:22:09.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6PY0mBMZIpGzQDA990fRuIJcknPVcH7ZzOKdFoMbUDIiVg5CCRL6ygPgP8MmowH2o5YjdOIZAjN/rKr2wW1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9078

On Fri May 29, 2026 at 9:41 AM BST, Andreas Hindborg wrote:
> For `Copy` parameter types it is more ergonomic to retrieve the
> parameter value by copy than through a shared reference. Change
> `ModuleParamAccess::value` to return `T` by copy when `T: Copy`,
> and rename the previous reference-returning accessor to
> `value_ref`. Update the in-tree caller in `rust_minimal`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> This change was suggested during review of the rust null block series [1]=
.
>
> [1] https://lore.kernel.org/r/abfe2LbhLzXiGCkA@google.com
> ---
>  rust/kernel/module_param.rs  | 15 ++++++++++++++-
>  samples/rust/rust_minimal.rs |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
> index 6a8a7a875643..701210206bba 100644
> --- a/rust/kernel/module_param.rs
> +++ b/rust/kernel/module_param.rs
> @@ -132,9 +132,12 @@ pub const fn new(default: T) -> Self {
>      }
> =20
>      /// Get a shared reference to the parameter value.
> +    ///
> +    /// Returns a reference to the value supplied at module load time, o=
r a
> +    /// reference to the default value if the parameter has not been set=
.
>      // Note: When sysfs access to parameters are enabled, we have to pas=
s in a
>      // held lock guard here.
> -    pub fn value(&self) -> &T {
> +    pub fn value_ref(&self) -> &T {
>          self.value.as_ref().unwrap_or(&self.default)
>      }
> =20
> @@ -146,6 +149,16 @@ pub const fn as_void_ptr(&self) -> *mut c_void {
>      }
>  }
> =20
> +impl<T: Copy> ModuleParamAccess<T> {

Instead of adding a new impl block, this should just be moved to immediatel=
y
after (or before) `value_ref` with a `where T: Copy` bound instead.

This makes related code close together for readers of the code.

Thanks,
Gary

> +    /// Get a copy of the parameter value.
> +    ///
> +    /// Returns the value supplied at module load time, or the default v=
alue
> +    /// if the parameter has not been set.
> +    pub fn value(&self) -> T {
> +        self.value.copy().unwrap_or(self.default)
> +    }
> +}
> +
>  #[doc(hidden)]
>  /// Generate a static [`kernel_param_ops`](srctree/include/linux/modulep=
aram.h) struct.
>  ///
> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index 8eb9583571d7..60d03df6cd80 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -28,7 +28,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
>          pr_info!(
>              "test_parameter: {}\n",
> -            *module_parameters::test_parameter.value()
> +            module_parameters::test_parameter.value()
>          );
> =20
>          let mut numbers =3D KVec::new();
>
> ---
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> change-id: 20260529-modules-value-ref-e95a7ab94fdb
>
> Best regards,


