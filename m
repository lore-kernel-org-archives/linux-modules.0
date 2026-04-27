Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022122.outbound.protection.outlook.com [52.101.96.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8903270EC3;
	Mon, 27 Apr 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297002; cv=fail; b=EdDAQ8neEUgB6AF+dhmbblR8WHJUtoRP4MQFuqUpCv+jX9VJJKz+8HqFC+/FN8jtoAZuHOoKhPjPuoX2hLxfwkzoSfn0SqYMQfVdZCABDiBXM//S6i0AJzvgpcP9dghZqnDwpc4fmmfYVkMZ+bvlQAcel/QDFAGfws8/MG7pRRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297002; c=relaxed/simple;
	bh=TGovvbRSM7uoxLgIdrUuqzvGLWdkuwafwvj63pdQC84=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PMqgGw8Za2VPQJXCS0JpvfyHmC0/doNPkGW8h5icBVoGNwRzy/ZylBDLWt1TdBgJa7FRxmv1RVc0gMxI50ZGi4k/uRV99Ud7U9NQ8tYjV5zFnwYFpqbdQhOAp539ySB3Oyeq0Fnme3TXoxPMCER1BoLIamk6tHxImdgi6JlUdPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tBoNyGAu; arc=fail smtp.client-ip=52.101.96.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tBoNyGAu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRCESOPVCXa9L6KvKepbCUEYK5ZFRlCY+KnCnqZ9zzUvNUaBmtrW0LsBQ3kNgK+2PFqmLDqwmd1Qxb1tbEamAijeEQPNnWUa6VJJCy7RgzT88NioJ/hFjVbwymUJWtk4vf3fmq/p9s3AjSpoaUw30g6wov2enTdXF+obhzB8yXN+EDil8ITugNltGSTKqTMWQZvWigV6UgM19YG7IJgNwk9A/hjGCdmvDEkcw+7uPEbet4GRJrzc4/1JZGwVzH+I8xPAbjuDrJJgW3jcL5wHcQL4/+vi7DfZhbUeorD/e49vsJKLm+j6lfhfMRrd0ef1Q14bz5k6zSXzuSKkkSVqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o2HVTgvjX5+J6xTG7JWYS/lD0Ku5FPsdiDa09Sn9xk=;
 b=vfTaPKBzvCPyCEjIMVhzEJBSUIqeYcuavVlq4cJMyGONFNrNQ/z3sfexvHIt1Z8fxQwlpWlKE1sCBVB1Nev2jHOcQ35eqGDX7rvryNpWifYWnJDS0OXfexM3d+MgYQwDxDBTeE2c00tH25KW+CK5sqPMJziaGfx7MJoYaJr5j7u3jt4Sr6NHI6xh2cM2kqFpSO5uKyiysmD3dZKUt/1Tpm9x7UqYdRym6Ut/2psCvC/jc7K2hr8jSAmlw5zTrvUMBeX8GYULuUCQ4EGZpvWyE9VM/ORax29MqsxnE0BycCfA6PAmqJyv7anOv9sF95TADKKE7ozcRkPMg0jS9pBXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o2HVTgvjX5+J6xTG7JWYS/lD0Ku5FPsdiDa09Sn9xk=;
 b=tBoNyGAuChCVYnZmyeB4asV/MaBCUWAOlHbi4hzQ9q/1ompjTlHdXXvZplaw/S00mcyL/lTBF2eWDcoqB/fqEpXnxNZX5+QxOn87XBPQcgnJMxe64LONdAr/9SyIvbhAv4RsAgMSv6LwtKAhy+uDjfgBjXLPWrp3g3t4gNuLCbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2095.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:36:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:36:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:36:35 +0100
Message-Id: <DI3Z7CANHUX0.3JKZLU2DPV837@garyguo.net>
Cc: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null
 pointer warning
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
In-Reply-To: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2ddf91-20e9-407d-bc5e-08dea4620100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	kFLYrk9onR3XMANFcqd3Uzp9JBlGmBOr9f7X1ij6IE59LU/SLr+jaoMZ5B9LP2plmvcaPKCyCR9c+BWtNGtryRzLOC+l/5C+mwc1sQrG9jBziJL08fAA/8CBf/m9pQk4okimvoNj2XKbokActmof6XtTt/oGZTmZKGzb/d1u45HxGvRXK273S/2vkzMyvnLwQEEbNEli3uuMM8LwhgduBHvKvQSTarJy13Qh+09W4/S0L/OZ+1oE1vZ66zmbNooqVI0eKN/LVAdB7hghegbInMY7ME3s57hqoL6xzT4lT3Q0FPU5dW6m2xMvWm2GvEkKUvGbAuK36Lw+EMo11TD1XdFEhRB/tw2DMuYegJ4JPnrXb8blQifNxC2fSwoKjlgQ6HD28SrAcCIl64K2WZ7iGpKfhQhdjdyDn8m9+Z5QKl1CqdoRLPe8gRV+xO0u3xxYgDV28wYzNEp6yLK+XWqPBivHl7HMJ7jbqBgANbEqJ/iMh+ythXPryG0n1e6AC5eGaqtUm0WUZxp3uZ0YK8WMTkYfLktMbEP4G4V+5PD/Tiukaxgfbu50dzEFM78tFsQOZaBhhb96NqjuhvX5lM/aQiaLFb3vna4y/Y1aiP/b4RFhIRzGA4azLNrhd+7BGbPoZxTbxfaCAWPEK/vfnq+e0mSL+kZWI2Bsur7Rr3eVMV2u4UlnM1ZRtrla5vKND+cOSZCgdKFYzcJ4MdwoMZ4sNePkXcxsut80ixJe6lh2lkW+xtqeV4vLEf3eEJRFVW7Jr8ajjUXMLybnHaEaAdVsww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFjVjJ4eTNLKzlyMjZKMXJwQ3RvT1lNK2I0TU9HR0xJOFM2SVB5UWlYOGJO?=
 =?utf-8?B?SzNmZTJxLzhKOThQRjN5ZDhQTEl6cUpnNExmSlpsRVk2K0Rta3Q5U3lrYzJS?=
 =?utf-8?B?enZrc2dsQzZ6RG1VSm9TTDNGNWtEU0JzNlRmcUl5Tll3M0tWUEUzQlVSTGVI?=
 =?utf-8?B?WmtqTEp6QW55TkM2eEFGY1ZiSTRlVzRWVXJyMXhYdlVBN1ErTGtvemE0VUZJ?=
 =?utf-8?B?WVBFaGU3Ri9vbWE3VWZ4SWJRWTBoVTM0bGVrWHUxLysxV0YzMldaNXN1bHBY?=
 =?utf-8?B?TUg2SGlYbU5XTnFQZjcrWWlsMDMvSkJTb2FOZlcrenNBdmJVa0JkU2xuZGp1?=
 =?utf-8?B?V1VSWlBmUDFhM2ZIcGZVVExETEtsMXNkSHB0Q1UvemcyRTF2K2Y0eVNnbnY0?=
 =?utf-8?B?Y1lZb2I2Uy93Q0hKeURwaml2OWk0dlllOE5CMnNtNFI2ak5uZkxqTU00ZGJ2?=
 =?utf-8?B?Q2pMSGYxeThjVXlZUTY5RWpUMGFoSU50alRERThtTjdXdHB3cDRNUUdCcXlR?=
 =?utf-8?B?bmRtSWNCR3cvR1M0TXk5RDJXNUVCeHludXltTE1QRGFXNFR2aW1yV3pKK3h2?=
 =?utf-8?B?STY1UlJJTFBMZExQR0tWMU1mN2VRQ1RVRFNobWxSc09XTzhtaUcyL0JDYWNU?=
 =?utf-8?B?dW1IcWo1aTBhVUV1WlFQeDN6THdhVDlmbkhBME5uc0pRQ0ZsREVSNVRPU0h3?=
 =?utf-8?B?R2wvNHBqbmYxV0FvUytDVDdGNmtONnZhK1hUcFQ4KzdkYWtybGlwR1VxZEQr?=
 =?utf-8?B?YlkyaFlhOVhtZ3hHdE04WUFsUmVVMDJWYVZEN2QzVExiODNXT3dROGFQczJh?=
 =?utf-8?B?eW1zWnJ5NEM2K1RHZDNrdjBnb3dzaUJSdFAveW53azExQUJsYmhDUmZrd3Vx?=
 =?utf-8?B?Q1VvRW45ajAwM0FIcTUvWXZnTHdueEFyS1lFQVBMLzN5bHJyWXE2cjNFQ1RW?=
 =?utf-8?B?ODZLalNDUkUwL0lwbk15Sk5ZVVVoMTZvcWdSTzFyRCtFVUVINk8xSDdqMUR5?=
 =?utf-8?B?OHQ0bjA3OTBhY1NXYURZZzRTb1hLYWJWME5NUnBVUjRoU2U1d21ZYkc4NHBr?=
 =?utf-8?B?MDN0dENKZlhaMnpqYllLdVR5Um8vb1hDYWVZbkw4K3hhYkdCWnN2Tmd4UTZ0?=
 =?utf-8?B?Zmp2dXNSQTBiQWtSclBSdVU3Q3Bob2tWQ3pkdnRlanpFaVRibm5lL1BycFpM?=
 =?utf-8?B?azczUEhMbFRXYUtKOVk3ZjRuSEJTaUR4K2FvanJQa21OL3pScWhDeHRlTk9o?=
 =?utf-8?B?eGgzRitKdkkxYlMwNFBTUkRKcUdDVW11M1dwK0NTYWxWZGtBVTV2L3VKdWc1?=
 =?utf-8?B?dlNnMUZJZjhya1RpeVdCSHZ5SjZJQTk2b0JjZTVkSy9uaUd4TjNFQk9lTzF1?=
 =?utf-8?B?dUhWZFpoWHgzZnpGdGhYdW0xQ3FHYnpjdUtjYWd0TGFvd3VjMENJTldpdU54?=
 =?utf-8?B?cVA4N0ZBZFRoQk13bUFMMXpIOE54bWVHMEI0L3h1VDlYMGpLYWVQWFBZM3A2?=
 =?utf-8?B?cVJHUmRiZU5wS2FRNFVEaHZoZll6WmFRcXNrWFo0ZjJGWldBSHRqOTVxOHpx?=
 =?utf-8?B?L2o1ZkthekgyQ0xLRjB6UDdvVEtMRzR5bVE3OFh1KzBkMWdEbGMxcGFGclR0?=
 =?utf-8?B?V3ZCZ0VNbDBWYlNZV0RtbUd1TXlqZTJEKzZNNldTWTdva1ExQTk0V3h3eGFN?=
 =?utf-8?B?YldTbG96L29pT05HY25QVG9iS1lrYWFwUUhtOXNSakhMclgvUjVLUWZHV3VN?=
 =?utf-8?B?aVhBZnJLaWo2aWt1QlcwWmkvdFpEdkZPQjFpZ3EyZG93dlBLcWxpL3M5VnlO?=
 =?utf-8?B?dWJhZ3dnL1VBQklieTlCQ0RRYlZFbWFXSW0zc2NoK0ZIYnhIZUx4bUVMYVpP?=
 =?utf-8?B?V2xRMGF6dDVWUmZFWVYzQkk0aUNKSTZCdHQ0Qnl1dzRqMS9QZmRhQytKYTlB?=
 =?utf-8?B?R28wV1pPQzdVOGFWQVBxYkRuK0RVWjlpZFVzQmZVem15TXh5RjNzNHBGTDRL?=
 =?utf-8?B?WENxOEdYSk5FVDZrUVNUaTB2WXdyWUFjdGxNUThLQXF2bDdobmhxZWR5cll6?=
 =?utf-8?B?ZVBLV2JSSG84MmVFSGZ4TzIxUmxqTEZKOEJXa1MzVFNkV2VhMVRsRkphMU9Q?=
 =?utf-8?B?RllXS1psb0NyR2FtcTNmUmpDb2hwWG53VjZRN1gyc2tyUERaS0hXTVpqL0hs?=
 =?utf-8?B?aHBJQWswamduVGFjTk8zbjF5dEg2ZitTZWErRHcrb3BOSXV4bHQzaDJsOHFr?=
 =?utf-8?B?cG1DSHpqdW5lRi9ORzlEY1NQNkI3MXh3Tkp2aE5qbk1Oc2MvQXNCWmVsZi9N?=
 =?utf-8?B?Sy9hdHd0TEFpeUU0L1ZwSmp6K1dtUEZSTjBRc3d6TlB2TkNRYmNZQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2ddf91-20e9-407d-bc5e-08dea4620100
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:36:36.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /edkp1rW6TRPB4+Q0ixUOuCXH7fJF6+Ih5qgOsL0zdcI03dsSp2rxbKROBqVX4xKOsokIlSNV7hm2yQpwF7d3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2095

On Mon Apr 27, 2026 at 9:11 AM BST, Andreas Hindborg wrote:
> Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now th=
at
> the macro is available.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/module_param.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

