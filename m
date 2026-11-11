Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794413112;
	b=DxK3kv06s3kg0cZvqcYLYZtbRw6Olt+z4o4xAOhivf2/pz8rA2A0PkIvDhi7D7cAef/D
	 JIFrK2oEnQPPBuPl0nfaY8nU8r1hNRFOglktNvSiviOWRkRgZBQ3ltRPyWhPmtBDtA4Im
	 8CcDnDTyciOw3dw5SvFswO4d56dRQlWH9fAgkjf+4ELi9CiocSx3c/YCvLIjlPVn0Dl5Z
	 O2fEz3Cl9FtmZZuxR3U5Lh/jPGCs80nkzsCH1rjgh0Ige+JLqE6VLFYXw4cnL8DVpEGG0
	 N8xnp1xxQRESY6YAHy2uEgDPvQPjdnIZ6cPcEI2UtJXdkt2dicO7sDOpvaQ7Qz9i8kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413112;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=K/jnftyZWVhm3wMkfTur+MENePlCTNYie6my4R998rk=;
	b=GgyhV/yHPtLqsv0g/K4Z4u0uWFltOfbGC6syxRAcZZCrC/uW6IGrMdok6amaGL5OgkN+
	 1B2jmyi0cMiEBMEeMFNneHgLo2K3nn3rgxiKaIi+tSjgz0yl8HsdicFBrX/Myg99cJXod
	 iUFdGCXh7FydGu7L/qnAu2n2otsq9mhLe9CuaLY4dUi/eba9jU50HpTOfml+DXoijr2DB
	 kczdErKjC/BONQbtNiHxMMqOi4BvHZYWF0RYDIYz1b0sUcVXYIT1BlPEGmLt6aRTWm/fm
	 KJqsItEhUdW9mZZO6F0+xxtM9PaVJENGTy19JwJd1CCpX/JTk66Ak99AKtkKUSeZ+3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=wDFvfUeJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.117
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020117.outbound.protection.outlook.com [52.101.196.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F924606A326;
	Wed, 11 Nov 2026 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F924606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=wDFvfUeJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZASefBF4I8dBm5yXEn7yI9oPI4uYLozxwYxX7adg4VYRQBmKNHUtzy7gCkY2w1ZZgpaSHc+q64qUrNA55O0NKWKaKr0q4UYhY4JgHkNkB+u4e0lHV91aHbuqnOwJa3K8T3rvxfgCBA1A0/sbEx5Pkyy+GqMZA7Bhc5uHnMRlwrFU/ALvxJElbbuzsLZjE5Hss8nvKYbeHB9Xro3h0UuPQ50ABGpfR84ORdooP4rMHyPSptzbw5HNAB1IXfHjt1x7VkLJGcVRlvuFKIDkdNzva40XWomAUcb5CIlm7oKxYFhlODGirkWjO17lsKYgTq9X2LywHDzRYDHrfTJ4mfyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/jnftyZWVhm3wMkfTur+MENePlCTNYie6my4R998rk=;
 b=jtYU+TVwyGjHpiqTe2h5ovtD38gcCpWdsyd2RvdnJZDQN7MvgMVTiYfk8zlNikpTd3MGSdGPT2WQgTwAVB4xu130saduFxnAQ0J46l2kba/uZb8vvmLUUpLIplbKpaEONB77qm4HrXWLxxGKcnnnqRyX86Bh6NXE2mBZz2GPTvRfdxdoq0FCfgBG+AtROu/VobdHgFBMp94UgzPGBxN/RKrhvvpHx+ziYfEzY/5fdZ9XxccKr7a5S9tDAHmdQWfo7XiQbhyoiyWw4f3o255AzuGMyJCiXHMTLp9yMalhaLRYfORnHq58JU/9GfZq8aXjHB6TYxD5iKUov4CH9z17ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/jnftyZWVhm3wMkfTur+MENePlCTNYie6my4R998rk=;
 b=wDFvfUeJmqaU+8mtMQ0W4Lo01AIHdnKmsG11kppn/sevsl74N3jm9e2JRQE5Yp+bJdcSjgoftqetokk9M74/OkBdC8x7aa4QDXaXaZHVgXAE3eTzkplqew3WkUIOs0bkhwzcQiO7mQ5Nd0icL+bmLns6PAlQ8zJe8XM6bQhXF8s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB6727.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 16:04:55 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 16:04:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:04:54 +0000
Message-Id: <DMSICREJD2LU.TAXIO38WREMW@garyguo.net>
Cc: <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
 <linux-modules@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Nicolas
 Schier" <n.schier@fritz.com>
Subject: Re: [PATCH v5 10/11] rust: make exports.o depend on the headers
 generated for it
From: "Gary Guo" <gary@garyguo.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-10-0f6018be8dae@kernel.org>
In-Reply-To: <20261104-build-speedup-v5-10-0f6018be8dae@kernel.org>
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2d7f73-795f-4e3f-edb0-08df400d86f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|921020|4143699003|261021121427099003|261021135927099003|10067099003|261102123227099003|261102130727099003|56012099006|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XNvEWAqN1RrwnYhGsroprpHeLrW5X7AfwMwtGlB9P45j2aPQbMGSsMrFOijaqh4p/6mhMt7sGFXMtslweIP9It/EaeKa7Nopo/Tu7P5Hp9oBmig/23Z6p5M7OVkLMX7bfsyDnHt0AIuZRtJGY4PfySRKfyUbvEqSEQGY3CcJhyYkG4QPxh7lV1qi1DAU5TozR9QPq7TNdmGIWFMm9ba/6QRBpMngEgkEx4+s+forX5lgGCYVEWLmzTWKkk2WNTu3nrX56b4NuzBQC4kNBoNQvNb856yLWI5SOmy5y7GdgVGygToCERnVVepRSeOmPqzzBktjKr4PV6AwHGGMt6sSAXwUvE0NgrtidlcewkAtLswwf8wKmEaQJpJn9oMIp8EK8CNe7ocKIpkxn3ZycbGFmftZjl57Dl51noPHmUbXQaylzw+cJT0mrkHvrCVykM3jMj252JgTiejCgsCC/xaNeYtANzIDv41KwHNq6Iuc+qQhn7VxBTHgonenzd75kUcll2qT+3Xm+AKUSXrNaEOvHnLJbjKE293iFLxED4XUM+jhXnzCWoWEi1BJiDq3EZxsFTU0YajioB92TG5nPGWLFrh0f/T8FsfoBphmGXVc54gKKO/oba4T7JlKwNAgkME2t/lpo2azthrJMeMxA3QqNI64jiyHgYRgfxQEeNgwbFlLsur64D5jtToEIrcTEjgOGYVtQNJVKa+qDP3S3TwSxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(921020)(4143699003)(261021121427099003)(261021135927099003)(10067099003)(261102123227099003)(261102130727099003)(56012099006)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2ZuNzJNa3liMDdSR0VUNUpMK1J4Mkxrd3YweEFCdGFDMjNKSjFySWdqTW9m?=
 =?utf-8?B?eW0zL3dKV2Y0WGFYNVA1SllVaXNiOTNQWkJyZmEzb0ZvbmJVLyt2Z0UzbDBv?=
 =?utf-8?B?cldhQXRKUWVVRTRsSWE5c0gzanFGUzdiVTdSWHZoOVh5TDZMMVBlUEo1MmtD?=
 =?utf-8?B?WUZFeHRCcjNjOVdRc000VWJ5cmxRT3k1QUdudlF1ZnVSOFdXdlY4anU3WC9w?=
 =?utf-8?B?RVcwNFgySUJwbDYwcjlST0FEWWNhbEdOdFIwRHhNcFA5RjFEUFBmeHZEb0Nz?=
 =?utf-8?B?dkxKT2ZYQUJUQ0J2MFNUbTZpUnF1b3hrRlBzaFRMMHRRMW5uSGJBVU1pRS9K?=
 =?utf-8?B?MTJvelp3VFl0OVM2SmROclFjbk9ja1pMbFpJN0R1OUJYdFpLZnEzeTk3SVkz?=
 =?utf-8?B?VVQxM2toOUtGTnZDMDlCak56T0VzZy9ubEdhc2x0UzFoSkFaMU9rYzdPMUVt?=
 =?utf-8?B?ZDBHM1VpWE8rOHZrWFF6WktPSGIzZm1iZ1lwUmx3eFJmLzF4YmpMcFNsUnYv?=
 =?utf-8?B?NHM3ekN0T0l6djN4SlVkN2YvV0YwL0JGaytHQ2xqOTRkQVpnejFZcFFCa2hV?=
 =?utf-8?B?Q0syamh3U2RxbitGSHpOTy9xRkgwK0F2RGk4Sy81R1hHWmZVenFQbU1XZ2N2?=
 =?utf-8?B?MG9qZHNkemJXMWM2RDJoanJzQkZtblRrTno1d28rU1RHUDBrMFNLc0FJME54?=
 =?utf-8?B?R2ppMGtIRnZvU3ZPd2dZNnlNVk1ETzgyVlNzR1RmUGxZUHNpY0VOK3dheVcw?=
 =?utf-8?B?cXMzMnJNZHN0bWNiZnJXNWpHdUNHY3JqclhyMUwvRzgrWXRYZmdkZHJCc3Zm?=
 =?utf-8?B?NHlLZVhiVTQ2aTU3QTlGTXJHNTFUNDNVTnJhVHdOWVFIcVFhV2tjSnZibW9Y?=
 =?utf-8?B?bzlIOUlKemZmTUd1b2F4YjFxa2haV21SZkc0QWFDS1ZGWXFWNlNjVjFYWWVR?=
 =?utf-8?B?blJjRDRINFJTeFFNSVNkM0VuS2M0bytEMEhNTmpsUnZqMCtreWR1Rzdsc28z?=
 =?utf-8?B?NWt0VWZnRDE0bi9xdjJaRlMzZzlSbXhaS2ZkWVduSzBIS2tMbFhjdmgybDZV?=
 =?utf-8?B?WEowSEkrNEd4bC9GQ0t5YTFxVjFYQjFkbVRaSHUwNEFvNmRhYzVLcFBHZ2Fx?=
 =?utf-8?B?TGc0aGJzb0NBb0paWDdpRHNMTEVaR1NMblVXZDlNM05jR3MrSjZBTzZNeFc4?=
 =?utf-8?B?bnpvU1lWVUZ0NFNETjRhVE9GeDVJNEdnb2c3VTFEaldkTHdCbHhlZklaNWdS?=
 =?utf-8?B?KzlCa2pDb0xBK2gxaENOK1FUbmRkVFNXa1dpMVdJRHl2cFZiMDREZTZNWlFZ?=
 =?utf-8?B?QS9rVkplTGNKdTk5MVpYNjd1b3JIL20vcmdSeGVMYUR3SUxDb053MXAxK2NO?=
 =?utf-8?B?TklTcGV3SkFEYjR1anVBa28vaFBlYVNnNWpORVBoaEFEVURXUjB2T1hBWkdL?=
 =?utf-8?B?U01rVnllQzRrb1VRVmlIenFzRDZ0MjB4c29nMzRJZzRiSzRmbkpKVmtlQTRM?=
 =?utf-8?B?SWxrakNLMU1WN1hJK0EyUktYdTUyVkhOWmpGOGJWcVZzSm1FOXhTY1QxdmJh?=
 =?utf-8?B?bDcrQnJ0UzF3bWJIeVBkd3JvNXdaOXR2UXdEYStCVzc4Nk9MUm9tbnpDZGRV?=
 =?utf-8?B?T3ZENVowWXIyK1hlcEpVZE1jVENLR3FkYlVVQzlvWklJcHRVODVFTGJWYWFG?=
 =?utf-8?B?SS84Uy9ER1dBckZ2cHRTL1VWSnZ2T2VUWUpQUHRqRUtXRGQxcXNpNkJaQUgw?=
 =?utf-8?B?b3Z4YXVhakNWSGFQWDVtTm5uc0Y0Z1NpMkNINzl6VncwVzVqTlZsVUMrYm9y?=
 =?utf-8?B?SkFkU09vWjRRekhjM1Y0QzRXdnp0WWtJdkpGYXJteTVyTXJ1cHpKVXpKMDZE?=
 =?utf-8?B?TXBaeDZOOTQ1L2lJOG5objNibFd1Y1NzcktoNzVYaWVpMjc4N0s0bUFnT2Uv?=
 =?utf-8?B?Tm1kSEpDRnZMMmoxZUxIMEdMaVRtemVPRjZtaXpkS0RFK3JETkxpUUtsTmtt?=
 =?utf-8?B?WmREV1hxN2h2MXRQanNNZ3Q1Y1NVZmo3Ny9JSmJkVjZTMmpSTjVQZlZmUHpU?=
 =?utf-8?B?UHlQbEVCTkhFcVJ0WjBScTlqbHcrTEVTb0dzZTI4NSt0ekt6YkFBeWI2K0xx?=
 =?utf-8?B?SUFsZmplRkpiQysvSk15bDRQci9lNk0vWURRK3piSjF2RTVJWVQ0R2NpOC8z?=
 =?utf-8?B?cnMyMXd3Q2VsWEdjaU5BZERpTm5oZ1RFVmxSVnF0QnZ0K0NyK0h6ZzB6MDJM?=
 =?utf-8?B?THZaVFM4enh3K0M3NFBQZFU4RkVCZHRNTmxnOUlKN3FvYTJTdWJUbkRYMHRI?=
 =?utf-8?B?QU54Zm1BWmtWcXA4bElVenF3RVUwdnBpS0VucUMramFtakpoOGRoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2d7f73-795f-4e3f-edb0-08df400d86f1
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:04:55.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rhi2L14BQA7GdHUR2YcljAUOho0bacEx13TxrVZzA/YuwKyJyfoqvryn73yTgPVe1KMk9fSVLzQDLg5fjzROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6727

On Wed Nov 4, 2026 at 6:20 PM GMT, Lorenzo Stoakes (ARM) wrote:
> rust/exports.c includes the exports_*_generated.h listing the symbols of
> the core, bindings, kernel and helpers objects, but this is not expressed
> in its Makefile.
>=20
> This worked previously because the headers are always-y targets, and make
> prepare built all of the rust crates first, which is an implicit
> dependency.
>=20
> Fix this as it is a dependency of the subsequent commit.
>=20
> Reviewed-by: Nicolas Schier <n.schier@fritz.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

