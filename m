Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793981506;
	b=DyjZw/8ytww9obwXQKpxVa29Bai0Z58UfIKXRwQddU0NWFppXWv3PjweMN26kVxB+/tf
	 DOLyCuYvvBDFuX39BZL39hVg293d6yRdv+ChE6Q8JgYUsO55b45soYj8KPIAQGKzvXpXp
	 cmdSauMZVZLTuYvieC62E7UVhYvzNj6HXLSFnxexJuhfBEO3WoHdwJxnJ0NJ5rpJU7m/S
	 Vk5R3IExCXC0eq16OhjaG4tFMHvunFn1WyDGSZVKLL4cnk9Eg0Kqp2UJ4yol13Bu8gODV
	 yJ3c+fSt6hK1/5VfS7Lbl5aFMH6OvuC9yx6z7VdKQZkfoyI+nvW7nqllNR/Vg7K775A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981506;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=/9sCaTbuBAZqxHlwnUmY6HjOC1fugGsa3qeYEnDj5jE=;
	b=VugRGlXnAMSDSmwFSWILA3TqxyX4KwhAEZKQAxsULJM2IYFayFDeW5Qvl8e5CXf0E9Dw
	 UR+0EffEomN5ler1SYP3U5QVO/JC2DkgQGwuV2Bu4stgzpX8bbYU70nmDV/EcbBMy0+bt
	 CQGuWnyszYQV4T7/MRmOuSs9IEry7kRSdqZiRwnsUm0GFWB0M4ZaAWIM+I+R+Ap++MtI5
	 GJPt2tn7+68Gf7cp4989gs5aEJt+Tu3IDDIVJw2erhiZW3RajiSct/i56cQTBU7QgF/T/
	 wBu0XY98g+ITrtElgVmpj1wIdDC9OIxZh0M5TibcJ0WELN/Yhl5SYCoKGg3+dblDCVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.109
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021109.outbound.protection.outlook.com [52.101.95.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5C606A99F
	for <linux-modules@vger.kernel.org>; Fri,  6 Nov 2026 16:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F5C606A99F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnlXT7wJ7gOYKSOa8g1MxqHxMmKSzWAkTMWnhBBNd2RnlydrUIYSNNbODm+1wVcjFA6rf9xlVkcmHjkC2O+K4gWfmocYSKICpMtUeUc6WEJbk5P4NH9hTBmdqjxm2MJA7kqhvBs217mPJ3bX2Y1q/UuP6Bx0niOFZfbSDYSSoDbmF0nS3lghrSm0t+GOfmGDbRws4KQ0QYHICcq3ka8UesppFppPUyiy4cv62eAht/7ttpc4cIP1doWnE/Bo/Zp+TZS5hoHxLJW+eQa7j38lxnAOmta7xqNLQKKATYQXXN7J6AkK5a0sK/8QYOcRFuBYGQvp9FZe7hjrlcdYmrwMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/9sCaTbuBAZqxHlwnUmY6HjOC1fugGsa3qeYEnDj5jE=;
 b=ZqCNGRihQflFjgvGBU613ipVnpwmjsRDLoQeUVjUVmcpLAvOYV0668ATBZVrzzkAb4YeXYLL215TYoX5D5t/hTUObeQNXTy4B5yzQpvQ8uffc3XIvfxR9rid71VMrwMDdwYlhlWWYg62ZlSSOIUSi+V1dmLBVNaYVhkGPYkiTYTHIV2KXX4+X2y3u2ThTY3wMy4IdjCQpa8KS4QNS70VSWZtSenvQ648s13/QyDk39OSVxKqLnysOe9rAE2mkizkn+2xgmi0nksIqFa5iFgQDE6Y3BFTNAl/Mrg3O9qBKAU1hgakU2MZngseu40b4vun9EmazfMn62LPszoLQuAd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LODP123MB499470.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:11:41 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:11:40 +0000
Date: Fri, 6 Nov 2026 11:11:35 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com
Cc: linux-modules@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	ojeda@kernel.org, gary@garyguo.net
Subject: Re: [PATCH v13 2/3] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <fg4m7owa7g2dtegwemsmbmsxh5dho2bm4ynrxuyzvfsd43cx46@hpd35p2ulxfu>
References: <20261104154003.43313-1-atomlin@atomlin.com>
 <20261104154003.43313-3-atomlin@atomlin.com>
 <sashiko-outbox-197697@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-197697@kernel.org>
X-ClientProxiedBy: CH0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:610:118::17) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LODP123MB499470:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a07f0e-888e-4ed9-9912-08df3c20a43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|10067099003|4143699003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021130227099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	5UtAEhAnBW/MdDlQ9mQiI82R2NgjKj3TomKenfQyoBSXBRaMu/muAoJPZwfZwdsPTSNOiyUOZohqIE0lKm4OZO2AahaF9eKp3DfOQyH2X2IqyKzhUKI9PKePW/1+nGF7BcWllB/m9sJPhohCN95ZtHGb82pPdGjXtAKL7nuwqJVoPSVRY5wzCD30d+3kYEdFpOfnCwQRGVu0i6YvwuFxEFedDkpRs8B2f6jtkXNwzX2puERm/Kk6B20sTsMF5JGjN8k0vynZSwVCfmUa84NDxqijnzyLofRz/tVPkWB9RnbDNT0aNGg3PmTMBwngVpncZfzmAPYPA0z5cRVOAkxFFEgye3mjjg9CoJZ6eXppxmZfUcqXBXprZVyhB0711c9lKr9x3VM8WWXlZ5uZ044319ojUVHHtLP9yFOjycLi7xj18B9Q68YdUJQMQAOyifyjqt/B67raitY/5ApSB9Abgkn7KvDX5nC05KHTx+aBerhHO6z9RY0jM+rnCGywd1bqtXs0baM8HJNMPheeopM4xzwxVPmEE0nvGnfiIExu9tqS94vWNH9YXDn49lAh0TGPX+FvddBt67b/W7ibG276CHfg9EFpWlh/SZKE5wUAShM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021130227099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVzWDVhNXVRdVdiaFNoUXBEdko2U05HM2JUMmFnbVNJNUZxNmVlaDJTOFVV?=
 =?utf-8?B?NlpTVWNnYkNvZ3h1V3hCMU1lV3Z3YUtyT0Fwd0hxL01GSjh2ak5HQWxmU25z?=
 =?utf-8?B?TXlCenFIWW1CZFA4RWw5OStoTXJXYnV6ZTFOZDdnVUpNcWZBZy80T3dJVG1k?=
 =?utf-8?B?YXE3bGZmZjlTM1dqUlBNTG1LNGh6MnJHL3RZdWxsdksrOTdxdlk0ZlVzTndR?=
 =?utf-8?B?ZHY4Q21oZVZmVHNoK0RGUEpvcHZUSTNlVmF5bDI0RllneUJYZ3MzQnBUT2Fw?=
 =?utf-8?B?SWl5TmxIN3JHQklGQjFDalIzNmp5MnpVeXpFa2YwWnZtS3NTSnBuUjM0enRv?=
 =?utf-8?B?SnE5a2YvVmpmOU5DRUs5bEpYc2JmMmFDRlJ0Q2NsL0xsMVRjYTVKRjhrcHVp?=
 =?utf-8?B?WStweXJaNHlVU0pybTV0WEhkaUE4cVRZSUt0YmpZZDZtQWsyY0I5dWNNaXgz?=
 =?utf-8?B?a3ZQVDR6WC9BOTN6Y1ZLWmNYcmxzNTROTWFOS2R0MGxMaHlxekF3WWJtQWNt?=
 =?utf-8?B?N1M2YnliNHFTM0JCckVwblErcllRbkdaQUwrZGZBeHg1RTE2d3NQWHIrU2tZ?=
 =?utf-8?B?T2MwS1BFOSs1V3lPclJGSk1KRjNPZ3gycGhBMnNLYnNORTJiYkFVeDh0VlE0?=
 =?utf-8?B?bTFBR2pGSGVYWm1ycHFobXFFbzl5VEZza2d4ZmswUVhqQWhCTmpNcGlHUkE4?=
 =?utf-8?B?OVU2amtIK3Y4dVRUSVRWR3V6N25WTGxTWHRmb2FIa3J3L0FPTWtvcHBlSENG?=
 =?utf-8?B?MGRWUlFVTnFqL041UnhMSHhGazg0WGszNWNOOTZYMVkxNkI2cWsvN09FdXVB?=
 =?utf-8?B?eVVvNlhQUHlSWTZHRTZkVWpRVDUwRVBLRDBBZFcrTmZVUkZ4TEl6TTNrRlJ3?=
 =?utf-8?B?UTU5MWFLUWdFbVEwaUR1VTA3TEJKc3VRZnJOdlJ0UG5nY0dac3BVZWt4ajQ2?=
 =?utf-8?B?VHZEQVdrcjQ3OWdPSjJCR2gydXNkbkVmeVlIUjZNSkZ6eG05WTZmMFdLaHk0?=
 =?utf-8?B?eTFBQUJwcTNQb3NUNTFWNDVRUGYzM1Vtd1NOMW82ME1TUCtndTBQdGs2eEht?=
 =?utf-8?B?cnJaTFgrUmt3M0kzRE5NVFVlSVdyWmhmU0ZERE9rOXBPbWtVeU5xelpFRzdQ?=
 =?utf-8?B?Y2cwVGdjdWNwQnFGQ1ZuSTlKaFRGN2xqYndEWWpKME5SRWg4andMcUdsNHA5?=
 =?utf-8?B?cFBlcXZCcVBHZFVKS1JsMVVmd1dxVjlSL1QrNHBIU3NHTFlYb04rNU51NDdh?=
 =?utf-8?B?UGE3N0ZZQy9zQmU0U1FESjZZVUR0dTljQ2JycDcweklpcVA2Zk5oUHVTc3cv?=
 =?utf-8?B?dG1FMXpQanVTdUNNLzJZQ09UUEhlUGJoT1lJZXlTTU83dStpNnNLVkRWSlNs?=
 =?utf-8?B?RGV5QzI2azVkdllvREI3eXEyR2NlbjBQcUR3SnZrMk5sWGFBOXJTdUo4K2Vm?=
 =?utf-8?B?QUZydXJvZDFWRlRpOXp5R3UzRE15aVpSZk41SGR4a1ROUGd6bGFvbTc4VUcy?=
 =?utf-8?B?emdGMTFPNktsZEpHZGo2ODhMN1BMWnVuZ3hLajhkTWpIa01LdGtkNGMwVGpN?=
 =?utf-8?B?Yng2YmV4aUNoYmJ5bWt6NmQrSEhyQkVZb01XMFcwNGsxRHpnMFIwbzFEbXVF?=
 =?utf-8?B?RmlLVkxIU0poZXE5K2orbjR2THBqRTV0VXVKSjlidTFGa0NzdlExdVdjcWF6?=
 =?utf-8?B?ZTFBUzJIdWdMVlhIdmt5ZmI3TFgyb1VLNktNanlicEV4QnpTNFU4dHlnREtP?=
 =?utf-8?B?V0tvTnh6WnkrbGN0bUJoaWd3azJZZm02ZXJqYzV2alV0WnU5MmNJM3FUM2to?=
 =?utf-8?B?cjZhd3o0UklyRXpVbWVTbncwcXhnbGZvdG5XcGJQUTRnN3dZQTEwUUN2ZDF1?=
 =?utf-8?B?bmZuT3dRV2pnTWhpYmdMM2JsRTdoOHI0S2JrWVZYODJvQVhkL21PdFhrdEVQ?=
 =?utf-8?B?a1FlVDVFQ0lqdWRpV1VoMEpSYUVJZW0vbDNnb21GVDkxOSthblJrYXBYckhu?=
 =?utf-8?B?QVF4aXZndDErekpRY0FiTWx5VC9qMHJEdThjRXgrbm1RN2xiMUxIWURMUWpY?=
 =?utf-8?B?U3JxdXRmbm1qOHJKR0tXOC9CbTJJYkRDenBuRllacXRJU2JoTU56ay9zMzI0?=
 =?utf-8?B?QW5jamZscXlVWVYweXVSeW9HSUVCbXN5Z2t0bW1FVE5taEkzODY0cEIzUW1w?=
 =?utf-8?B?ajlFcytkY2VWdENiUUpLc2lsVkw0b0h0SXcvdjRlcytieTYwTUtiamR1eE4v?=
 =?utf-8?B?U0U0bkVFWjFQNjVUNFRsOUk5MVF4RUY1V2VFQ1FzZWJMMWh6Q2pkVncwV2tF?=
 =?utf-8?B?Z245cTJVZk5wZkk4YU54bVVrREp3dzQxb0dWOGpmZkdONm1lQVhEZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a07f0e-888e-4ed9-9912-08df3c20a43f
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:11:40.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tn3oi131ZkzlCQQKwH2SSiBgjcJdNvyDAlmdyjsC82hAFIAadfxtNFEIgSUIFs2ivPLJtFD9bnam0Acqpfmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP123MB499470

On Wed, Nov 04, 2026 at 04:54:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] init: klp-diff failure on __modname_<fn> with LTO and PREL32 relocations
> --
> 
> commit 4ae71df0c31c4118e7804e6488565c6666998f3a
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> module: Extend module_blacklist parameter to built-in modules
> 
> This patch extends the module_blacklist= command-line parameter to built-in
> modules by recording each module_init() function pointer and its
> KBUILD_MODNAME in a new .initcall.modnames section. During boot,
> do_one_initcall_builtin() checks this table and skips initcalls for
> blacklisted built-in modules.
> 
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 6326c61e2332d..08cb8a2943758 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> [ ... ]
> > @@ -252,6 +257,7 @@ extern struct module __this_module;
> >  #endif
> >  
> >  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> > +#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
> >  #define ____define_initcall(fn, __stub, __name, __sec)		\
> >  	__define_initcall_stub(__stub, fn)			\
> >  	asm(".section	\"" __sec "\", \"a\"		\n"	\
> > @@ -260,6 +266,7 @@ extern struct module __this_module;
> >  	    ".previous					\n");	\
> >  	static_assert(__same_type(initcall_t, &fn));
> >  #else
> > +#define __initcall_fn_ptr(fn, __iid, id)	fn
> >  #define ____define_initcall(fn, __unused, __name, __sec)	\
> >  	static initcall_t __name __used 			\
> >  		__attribute__((__section__(__sec))) = fn;
> > @@ -271,7 +278,23 @@ extern struct module __this_module;
> >  		__initcall_name(initcall, __iid, id),		\
> >  		__initcall_section(__sec, __iid))
> >  
> > -#define ___define_initcall(fn, id, __sec)			\
> > +#define ____define_initcall_modname(fn, id, __sec, __iid)		\
> > +	__unique_initcall(fn, id, __sec, __iid)				\
> > +	static const char __initstr_##fn[] __used __aligned(1)		\
> > +		__section(".init.rodata") = KBUILD_MODNAME;		\
> > +	static const struct initcall_modname __modname_##fn __used	\
> > +		__section(".initcall.modnames")				\
> > +		__aligned(__alignof__(struct initcall_modname)) = {	\
> > +			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
> > +			.modname = __initstr_##fn			\
> > +		};
> 
> [Severity: Medium]
> Can this break livepatch builds with objtool klp diff when
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y, CONFIG_LTO_CLANG=y, and
> CONFIG_KLP_BUILD=y are enabled?
> 
> Under those options, ____define_initcall_modname() initializes
> __modname_<fn>.initcall_fn to __initcall_fn_ptr(fn, __iid, id), which expands
> to __initcall_stub(fn, __iid, id). Because __iid is generated by
> __initcall_id(fn), the stub symbol name embeds both __COUNTER__ and __LINE__:
> 
> include/linux/init.h:
>     #define __initcall_id(fn)                                   \
>             __PASTE(kmod_,                                      \
>             __PASTE(__KBUILD_MODNAME,                           \
>             __PASTE(__,                                         \
>             __PASTE(__COUNTER__,                                \
>             __PASTE(_,                                          \
>             __PASTE(__LINE__,                                   \
>             __PASTE(_, fn)))))))
> 
> During objtool klp checksum, calculate_checksums() -> checksum_update_object()
> hashes target->demangled_name for each relocation on the __modname_<fn>
> object:
> 
> tools/objtool/klp-checksum.c:checksum_update_object() {
>     ...
>                 __checksum_update_object(sym, sym_offset, "reloc name",
>                                          target->demangled_name,
>                                          strlen(target->demangled_name));
>     ...
> }
> 
> Because demangle_name() in tools/objtool/elf.c does not strip the embedded
> __COUNTER__ and __LINE__ tokens from __initstub__kmod_*, any patch to a
> translation unit containing a built-in module_init() that shifts __COUNTER__
> (for example by adding or removing min(), max(), guard(), WARN_ON(), or
> __UNIQUE_ID()) or __LINE__ before module_init() changes the stub name and
> alters the checksum of __modname_<fn>.
> 
> In tools/objtool/klp-diff.c, dont_correlate() -> is_initcall_sym() skips
> __initcall__ and __initstub__ symbols, but does not skip __modname_:
> 
> tools/objtool/klp-diff.c:is_initcall_sym() {
>         return strstarts(sym->name, "__initcall__") ||
>                strstarts(sym->name, "__initstub__");
> }
> 
> When correlate_symbols() pairs __modname_<fn> between the original and
> patched objects, mark_changed_functions() sees the differing checksum on the
> non-function symbol and aborts the build:
> 
> tools/objtool/klp-diff.c:mark_changed_functions() {
>     ...
>                 if (orig_sym->csum.checksum != patched_sym->csum.checksum) {
>                         if (!is_func_sym(orig_sym)) {
>                                 ERROR("changed data: %s", orig_sym->name);
>                                 return -1;
>                         }
>     ...
> }
> 
> Should is_initcall_sym() in tools/objtool/klp-diff.c also exclude
> __modname_ symbols (or should __modname_<fn> avoid referencing the
> __COUNTER__- and __LINE__-dependent stub name)?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261104154003.43313-1-atomlin@atomlin.com?part=2

Acknowledged!

Since __modname_* lives in .initcall.modnames (within INIT_DATA, which is
freed after boot) and is only traversed via the linker bounds
__start_initcall_modnames and __stop_initcall_modnames during early boot,
it should be excluded from livepatch correlation just like __initcall__ and
__initstub__.

I have updated is_initcall_sym() in tools/objtool/klp-diff.c to also
exclude "__modname_" symbols for the next revision.


Kind regards,
-- 
Aaron Tomlin
