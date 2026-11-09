Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237254;
	b=qLb3WdBEqPKEAVIHwbnS411kTuwfCf1Xgk/D0FAOtOAbpxxgwNeNt6VZmM1pS1/sJhCy
	 JPC/Pa1CoIlCQn3oP30iGVaYrbAhBfaGLqaTNOMYItVWR4jbBa07bgOcdcmD0xy401kjA
	 L5sjfQmTIc2DPO0x+gBe3rsHIQVfgrZHPyBAdc0cbrDh5jBwtXcbRiCF4HjtvTr5kscCJ
	 H7WiNT1xRYwhN3htFO+eUMYwxbwsjoFR4eCOaTTQGSHX+n1veBPXhdqP2gGIfDiLaWLEP
	 bw0iv8c0tUB9YDfvMMvdPVx6NiIbRMlOcU5a2PuyihTZH64h3GELm/qL61cGMjrYfPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237254;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mYTPImb9a8pI+pOdyl17cm1+g9Tqr0Ojp2GadnQDhkg=;
	b=EDFqOXXn12gsj3vd0hdJ1mkjRdw0evAX9HYN03Kb0GoHKP7VZi1oF1Cc6p2YAtiu+WEA
	 vduzq9mfCHc4MTPVzpCiekhplsbIg0gekN1mKSvJGp81JviiwdMEbt13kXKupQokRIenO
	 8pVCPyFuC2jd57VeRMhGTKusRyWeFN7c8/HK3dMjgMzLKHGmmCkyGpumyMD720iJvheYz
	 eEDMWicGq7uirqIy8qw2djSUH11cXJcMkQ6sif/QlaH6FZXnzzAm75jpL7onj7kiaMkX9
	 scbebl8n3SITZLjEphUkj67AwjItUtsFaFbGCaEH59rW8pnOSWZFGNBjBH/0ZvzT/jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=MsOXq427;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.122
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022122.outbound.protection.outlook.com [52.101.101.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163F606A325;
	Mon,  9 Nov 2026 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6163F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=MsOXq427
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/hpjZq5rRBL8tDo9IIKj4wD/5jXoV61cWGAvNq/BKYDO7gNZGVdo/5tThP/TnYKpSdeAwXJdb8G5CAqX35vyVsFde5eA6vLD+5qLzLJdOIBHmWgM5v0m11okQbWNA8CK+VQFrvbYvjEjA+AyAdsV8SfY8TZO6tHnqPE9Sz73qC1N5QfO/SpNO+Uiqo7G11BpZ76O4vsBNjBadsla665xMrLd05KHoTpdjrEJbKid51XELSyA9fPwJiMocb6dLc8clQod1OY/G7oemqmMj941vmH504fowJo4pln55JBnMoElxI/r73BFhPIjM36iZXMrd2FQGrHt8SXSM0YELyNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYTPImb9a8pI+pOdyl17cm1+g9Tqr0Ojp2GadnQDhkg=;
 b=x8cb/h6gfWFs2/eEJCUtMR9yUN/5sk8VIegw1jZUO6pYFHDRrQzVB91tgmWks7xrPLfh4HyfiVx9MsAr0DupT87XFz1ym4MXnuoc1/Q08oSnURzZWvm57EnegrW+bObgLEv+0rQv8Y/cOTTtLL05F8vPT4SxY1+OBHb94Z3S78iXnpOsa5+1e1YHSATFw1dTctvkCXxS13aaTNazMvKCb3xsaFxhxeFq/JUGPfAsjdT52vPl0M12csoV0UgYgpNtqRx2j62ylQoZlSLNkTOtlJCDM2Yq6LI9S8SzS7uRnkocO9CPGQkNvu8g2uibWtea3h5wFuw6zS/FS69djD1UAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYTPImb9a8pI+pOdyl17cm1+g9Tqr0Ojp2GadnQDhkg=;
 b=MsOXq427prLzmm+cjJ9Zz7GvcYxwzaD23WjEjGdxW60AXnljXzDLtDGXKKhU1BHpr+O0y3YPnFWMWBM+wWB3wU5mCjFtEJTN67aH+3gDqAH9hRUHcHYoQYcN1h4a06nxUqFt9MOI0ap4gojNG+h0rBfURn0JTLgn1PtgZXtmWUk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB2481.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:14:09 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:14:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 15:14:07 +0000
Message-Id: <DMQS0SH6975Y.23Z4V64W0HWN5@garyguo.net>
To: "Giuliano Procida" <gprocida@google.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-modules@vger.kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>
Subject: Re: [PATCH v4 0/2] clean up EXPORT_SYMBOL_RUST_GPL
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <CAGvU0Hm04LXTywU0eL6KN4=SoOAC+LU3BKqENnLR-WV-sHsuNA@mail.gmail.com> <20261103165833.418845-1-gprocida@google.com>
In-Reply-To: <20261103165833.418845-1-gprocida@google.com>
X-ClientProxiedBy: LO4P123CA0144.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::23) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB2481:EE_
X-MS-Office365-Filtering-Correlation-Id: 378e98cd-4a19-4ef4-5a64-08df3e741a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|376014|1800799024|7416014|22082099003|18002099003|6133799003|10067099003|4143699003|56012099006|261026121527099003|261102130727099003|261102123227099003|261022075727099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xwSEuVvkcp/TpOwLGoitkU/oMCAT0+cvRKerJtGl1YAIuBo+ufS9UGdAx0t59Zcp4YVZXz8V3vKAHLZeuemVCMyfStqtuDD/YoulwOJPTB+wWw/oDzPpy33tY115/XsOGfGwt45uYJfER+VF+sL3WcLroj86HLeL9lEODw3TaVuJqMlOe+Cp1O7AfYT2QF4gt0JyP2tDddHiF1OSQ1XM7QoW02A+0f2IH3zE82XTGE3kCOxhZ3pGsM4WPZJeKHc0yATqcNgv6PvpncALL/InL4n198hq4VPOkHp9eBuzFc2Uu7vHDIotfNUhbwapo8YakWU7dMo2RBlXPWWlInojohjCLUSBErBlGxwN5GagndllVLNP+D3aZE+OkjB44PEYkLewv+Cx1k+LSYI2FRQbFMSnnZe+Du3+acffYbhoPM4AfKIhqXfYQmThHzyeAlK8DJGtkrfKO7dlyx4NrtuKcvnYYX6j3Lbzean9m7wj9pr8reuutwt5Th/zrr0+JNm7fogyE2icQSmtkbsY8/J1k6xxGOp64ZmZ6KSNgYzxSvXGUJZ6IkXvGlIjMirRKWy9rNKAgrFaPjmv33BMtbMfUfWj3cRRPpGbqRi1O6VZnzM3Y/fEp9UPJ0nchUMEZ6NGh1iBBrPcpEVmqjHYdrP+GCxm2WNA8q8EuZS6BDFItl8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(56012099006)(261026121527099003)(261102130727099003)(261102123227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czliajAwTEZRVUdnQ3hMbTJCT1I1TWxRTHNwRThiYThoTHZsRElCSnlJRit5?=
 =?utf-8?B?OExQN0NhMnIyTU5IQ0FFUHdUaDYxVmtlMGdwMzJhd2lCazU4c1l2bTRZS1U0?=
 =?utf-8?B?dVhFYU10dmhIeFpIV2NJNFFZd0pEQ2t3ZXFTZ1N3OVp5bHQrTktGbm92R0VS?=
 =?utf-8?B?S1VSYTJ2bC9ub3YyM3MxeTEyUjVmRllhMTFDM1hRMVBEckQycHlpZUtWV3BJ?=
 =?utf-8?B?OWNDcmR2NEFMWEp2VzNMWEplZGxhZVpUMmR0QkRrc3g3ZkcvRHFiOXZDQTdR?=
 =?utf-8?B?TmFhay9EdFhoeTFkTExQeGRtbDRpYUlJazVNczFla0o0bnQwVUZYMVFXMHd3?=
 =?utf-8?B?NXZGaUdDdWNBUklYQkZONFJOZDMxQk00cFBDazN1akZ1ZWFWZnU2R1ljeVlS?=
 =?utf-8?B?L0FUOVhzWTNRejJNNWlaazVmU2VFaXNaUVRhd2Y4bFBYMzN4OFNqZ28xbFl2?=
 =?utf-8?B?TGIvdFRkMGNLY0NhNUx5Rjc2QThUQm4wZ3N3ajkxMG5meG51VEhNS3dhMU5q?=
 =?utf-8?B?R2JEeGY2eTlPSndlbm84aFJwVHB2VytwMnorK2l2STEwQVp3cWZjK0NWY3Ry?=
 =?utf-8?B?dkJPOXAxeUs2My9qMisvazZYZ1JhV0xPbWF0SG5Vc0pCM3ArY2hsY2psOHBJ?=
 =?utf-8?B?S3dMTFhKekt1U1pCTlpmb1VZTjd4WER0VmFIODBvbTZwK25GNm1zSWlUNHo3?=
 =?utf-8?B?Z2hSUjdrVHdWck9rOTRRUlRlVFFvb1FQOFFFWTFsb09HSHphcGZlbWM5cS9w?=
 =?utf-8?B?MWZEd3QrMWR5dVFubHNyR0hYaFd3YnVyT2xJd203dnJJNW9jUzJCVVBlamNE?=
 =?utf-8?B?NTZsZTRaSnV1RWxzV0xGdEM1eHZ5T0lvS1ZlSUVISDJVeXNaazV2YVpWYzhT?=
 =?utf-8?B?ZXEvQk9VbUplekg3b1JBWUNvN2ZGbkJ1QnY2MGtUeTlTY0hodSthRzJZTTlF?=
 =?utf-8?B?eWpvcTJJWGVoRTNlQi90aE5kMkFueHhmQzl6NEFub1BMYzBsaG1iQUltTEZI?=
 =?utf-8?B?bEZBdFExYys3NDBOLzRxYVlPaFJudngyeEgvNmpDQnJIdkdJUWpvek1zSTBt?=
 =?utf-8?B?RVdjV05rVnhCU0Vhdnl4eEl6UVA1SkFjd0ZZK3VnZHBkTjM2Rno3aXJEblMz?=
 =?utf-8?B?L3JLb0Urck1MdTZ3RGRoTHVuOGdFZys0S21XUFpUTXloNFM3elJvOVFibW9t?=
 =?utf-8?B?NVZOM1gxcXJQU2lNZ3QwL2NkY2FPNFFVSjVaVTdZbXUvWUpOQ25kNXgyVm9I?=
 =?utf-8?B?ekx1ZDZNbFd4T3ZYZS9VYlJTSXMrT21IcEtlYUdCRDdsUW1aSXEwQnpzdVo0?=
 =?utf-8?B?RHZhc2FsZzJQVDY3VFFsL1Zzdnk3RzBQb2REY2F4TEt2aDQ2TVZiV2pDU3Y1?=
 =?utf-8?B?Umo3bk5xUHF5ZmVsY0VEQkliamFBVGRUeDUrTTBFYUpLV0YvcjhITzJKeDJx?=
 =?utf-8?B?ZzdTcjI3eWpoRXcwWXF3bkg5aW96Sk0waFVyMW9uOGg3VEtoVkFraThjODJO?=
 =?utf-8?B?T1h1MXI3MUJCVmJwVFJ1UThIckVNNWtlZ2ZjMnppZml3NTNoMGNJSXBLeW03?=
 =?utf-8?B?dVFxc1ZTVHl6Vm9Td0kyZDdsTy9YUER5OEZ5VythN3RJU2dMWFFBazFsN3Rh?=
 =?utf-8?B?V1FZZlZGTnNiWmVoUk1DNTJsY3ZtWE9TVDhVVndTWWozbEZxN1d0SmdsNFZx?=
 =?utf-8?B?bXJiNVBVdXR6WXloWVd2eHhXZkhVdkM2NWpKMGhFeHBFemdLalF5emlQYldx?=
 =?utf-8?B?c1JWSlg0OTRDYjc2cXkzeXlRVVJoQ2tPalF0YW13VEtJc3hIMGZEYWJVcFBo?=
 =?utf-8?B?VURma1VDdnB3WDE5YXFza3lGQlN4eThKd3U3cCtLUXdvREtOMWVqZGZqUDB3?=
 =?utf-8?B?YjdiSzBIQjd2VUsyUmF4cWxnUHRRcS9kcnBIMjd3K2x2QVBlZFNOUjkyRUV3?=
 =?utf-8?B?UGRIeitnU2d0ZWRhQ0FQZ09XaHpyUEdzK3Zld3ZqSy9BRCtCTnZLcm9HQ05x?=
 =?utf-8?B?dlN5dEhDRDBMWU9rQjdwbTdPblRXV3FGSkVlcVY4R3E2ZkJXZWhrS29ndmNx?=
 =?utf-8?B?VWZNcXNPMDdvT2hXR3hZWlBoY29nazZuejc2SVplMmRVOXdsMXpDbWl1MUZ1?=
 =?utf-8?B?TGJNSGdDU2tXOUVXSmZLeFZxZkZjY000YlhsMVVpbHYzY0JEeGZpTmNHaytW?=
 =?utf-8?B?STlDSlBPb2VPR3dOU1loZjlpdjZVeXB3SHlHejR3eFE4WnFjREJHQUZ3WTlv?=
 =?utf-8?B?K2NxQytvRTBsZloxaG5oUGV6Yi9lYUR3ZEd4LysrNnprdEYzR0tRaGMxeks1?=
 =?utf-8?B?KzBDNWRodWJrQUdENURpTHQrOExnZTdNUmhUZWpZMDJjb0NOQys4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e98cd-4a19-4ef4-5a64-08df3e741a08
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:14:08.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgfhAH5Wptg/F31+YdlEsoVhaFkZl5TBVs0dW1u+NwnLtK0q/ZqHDa35b9FdNQGNFGxhlI70CZXZv08EhrjXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2481

On Tue Nov 3, 2026 at 4:58 PM GMT, Giuliano Procida wrote:
> Move EXPORT_SYMBOL_RUST_GPL definitions into linux/export.h and
> prevent the emission of bogus type information for Rust symbols.
>
> Addressing review comments, the first commit now ensures the moves do
> not trigger warnings from scripts/misc-check about missing symbol
> exports by extending regexes to match EXPORT_SYMBOL_RUST_GPL as well.
>
> Giuliano Procida (2):
>   rust: move EXPORT_SYMBOL_RUST_GPL to include/linux/export.h
>   rust: exports: emit ___EXPORT_SYMBOL without C declarations
>
>  drivers/gpu/Makefile                      |  4 ++--
>  drivers/gpu/nova-core/nova_core_exports.c |  5 ++---
>  include/linux/export.h                    | 14 ++++++++++++++
>  rust/exports.c                            | 12 +-----------
>  scripts/misc-check                        |  4 ++--
>  5 files changed, 21 insertions(+), 18 deletions(-)

How about just getting rid of EXPORT_SYMBOL_RUST_GPL completely? The only r=
eason
that it exists is because EXPORT_SYMBOL_GPL in C expects the symbol to exis=
t.

We can simply change change rust/exports.c to rust/exports.S and get rid of
EXPORT_SYMBOL_RUST_GPL completely (plus saving a C compiler invoocation):

Something like this:

diff --git a/rust/Makefile b/rust/Makefile
index 0165626decbe..75de47028b60 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -571,7 +571,7 @@ rust_exports =3D $(NM) -p --defined-only $(1) | awk '$$=
2~/(T|R|D|B)/ && $$3!~/__(p
=20
 quiet_cmd_exports =3D EXPORTS $@
       cmd_exports =3D \
-	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
+	$(call rust_exports,$<,"EXPORT_SYMBOL_GPL(%s);\n") > $@
=20
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
diff --git a/rust/exports.c b/rust/exports.S
similarity index 86%
rename from rust/exports.c
rename to rust/exports.S
index 1b52460b0f4e..efe6bff0f983 100644
--- a/rust/exports.c
+++ b/rust/exports.S
@@ -13,8 +13,6 @@
=20
 #include <linux/export.h>
=20
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
-
 #include "exports_core_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
@@ -25,5 +23,5 @@
=20
 // For modules using `rust/build_error.rs`.
 #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
-EXPORT_SYMBOL_RUST_GPL(rust_build_error);
+EXPORT_SYMBOL_GPL(rust_build_error);
 #endif

