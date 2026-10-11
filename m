Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022081.outbound.protection.outlook.com [52.101.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D4381E86;
	Sun, 11 Oct 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725007; cv=fail; b=nm2un2HmqVvPLL7lcruUlfo704c9zdeu1ZP6uT1KoyG+l0EgGcAZ6WGGrhrkMWxxN0RugbiSka6IioAUQv+5IbLIc0MTNGAvBKTK5aPeAu8t/WwfY0iV87ks6WB0oa+8T5z4qBWEcmjt/ceUfRljsNbb5tmk7N2KS/uV4DvYEv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725007; c=relaxed/simple;
	bh=I7s7IjltE2gBzIVvchNEOCfs0vPtkNIHTpyjHMYcHgM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qt9Rz4bnimBxQAOmvxvBy1i5JDpRLFil6L5FziTfeXwdwHgk63pw55T4QB2Ibqlx0b1UzUG5PtIgoJ0j1P3Y33webpmwnDfNbtuDTMjvnxSgo4aFlPrRU5YInKYpEMyyX6jEm+gpOcH0J/rX62GuqR18PupUSIQR1wD0K0td4ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ypCo60J+; arc=fail smtp.client-ip=52.101.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ypCo60J+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/ktHY/06UWdpfaFNH0/tv/YXYqkvjBrCbJMKwz2SR/r3KTZP+PRoFHRHZ9fckfiDM+AXAMZpKSO9UbAxxdlz1ucddhpwcI1qe47u/1q19tnsqLUYf1sTLGnxYKL/BF9kJSWHpvhLnqmCmQGu6KdH41JgvLr5kRdevvGQ/txK5Cc840PJqqZU5WFxgwwawfx/lCFl47R6L6wEwriqivjchKM51Rn2y/fiyzKu+aCeVFTaMPm4vhF1OoRLiDU4fIx67DZSXinR5QGzZHbfjY2r9expuxIc9DnL3zvktpgw08+/+dt7WLZej4X22C4s4ofAAsY0ZoL9mSoB/DrNP5Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q6rn41FRrNyrhBnN6KUNLEAavW4HbFsmA+/2yEWLNE=;
 b=xZfh3sJSA7TNhfBZpvxJ3W25AjsS5Jqr94UqxKZMYUCoOWUYNjhdDMF3eRrQLJ5tOLn4UPYmxnkOw2WndYm/+N1mV8UloDbJME6ANxQC4UiT++3HR99WfBBsjWHFl7LNObZ45aT7Eza5cEZatr4a2lvcQY38tMMDIaJyAiqPb6feO3Uh5eDPtncRFkT1do4a0mVO7bgLAUvQIrX5sMYlhLGdnQaGW5KCrPW+s51c1xytaBWgvlEyGz0fqULDfX+icCCFWetWzPiCi4Z1+/x0Bt+eiGUWxTNdH2O6+fLB5n83fdkQyy1QbFB7UWDmRmYrt1g+nsiAL8vND/OU2db5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q6rn41FRrNyrhBnN6KUNLEAavW4HbFsmA+/2yEWLNE=;
 b=ypCo60J+vhOo7YzbzAOREftJycvvMlz99tTuusqCtTh4Hb7ozOxZRq8EsaeIG8RCrbMwsVQgkon8nVB2fSoM8JTTDL7Asjo4R1Y/TpK+LlmuTM3TROw0KCnsxJlBPEMdij1twYT7jml2wKyiqIRXqWAM0Nks0UhIKdjTmdyvD0Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB5979.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 13:23:22 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 13:23:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:23:21 +0100
Message-Id: <DM21I6LV89ET.346IBMXXFE97K@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 06/11] dyndbg: make _ddebug::flags its own field
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Jason Baron"
 <jbaron@akamai.com>, "Jim Cromie" <jim.cromie@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Lyude Paul" <lyude@redhat.com>, "Yury Norov" <yury.norov@gmail.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "David Gow" <david@davidgow.net>,
 "Rae Moar" <raemoar63@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-6-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-6-832e4039b71f@weissschuh.net>
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: d3745a1d-22f8-44fd-5c92-08df279ad299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|23010399003|921020|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gV7Sa/SqTpjgSx9aem+8mkd4jKrzvw7OQtE+rDYI9kQIduPQpvwQFPE6/s+vvUsuL6stCieWCKvtCgNb/2NpWrQrHg7TBX5S1YG0uUa5liYIWu6OWZtGeF8Om/iRNtYG7vTg2cMuj878qP2roKLE8VIsRVDn8rj+9IXummp+589Bq3nHAXQGCTeorMFN8GXLx/Rn8oVMfGN15ljkycT/l+HrhH+8cxtpEOIawgxts6q87f84mFc67I6sl/706T3Do/Ps+Vjm4+3Lj5G91JZi0kR2dTuzteSystzK4Be1e/mn6A/JCql+JLwk7fxiXd1YQ7XMDEHclTsGEnd4PWtWjVQw7koauSEcOvYIFJtGdX5PLbtw4qFCRSngfHWhJRGMw3OTRtHMGWr7uYa4ujTN6mglxoyJr+iBLaJNm7OXPzJszuXakGuwdUnfdNGJOnuiQAAE4hB4nMtCFjR3Ba2DhMruAoELHD0JiHb4oCBGbJPN+IqMXJxkR1fFLxcC4aVL5Gf/mS/bxWynzuiRvcWMWJRhAMeZYQaqOPLugyOJ8VpC58rW62XK3qLAYfNoWril7b+votOlecKLl3W+FsFnsLQmKLZPoxlRsO+fWQUiVfmUTi0KC658QA/oPU/Ej6mAcJ+8tR45Ltf3dBF5voLVkMqZb20+hUz5BItADOf+TM2KBER6FwNub7eHpmNLlpNaZchIwGRJ4/hE481RGzYUmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(23010399003)(921020)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVkRWR0VkRnS095Yzg5dElGeVRzd0YrZHJ0ekluZTZXWnFjQUQwYVBIU1la?=
 =?utf-8?B?M1dMQ3NWTHYxQ1c4ZVg1dTJaUU03cDU1anpFcXZSVU9JM0dnQmVJWjRqdVpt?=
 =?utf-8?B?ZDRkazVGSU9mcFdleXZyd0RUdGRzRU5FTjBudnVOWnNGTE1GQU5pUm8yWVlx?=
 =?utf-8?B?c3Q3R0ZTY09NNEptTWNON3FXcUh3QXJ2L0dxSGh4TnQ3ZzI1VXZUVGxYZVlU?=
 =?utf-8?B?UzZJc3g0d0ZRUTRLVU0reXJMcWMvNnpmeWFnYlUwdDFtRW11NnozelNlNXg4?=
 =?utf-8?B?bThXclpkOWtld3lsdXdkTEtlKzFERHpYaEdzVU9xeDl2ZWtzUmNndUljbHFi?=
 =?utf-8?B?QXpwSGszV3pTWUlXVkRZWVJYM1pqYzk5NDlyZUJuVFVIVW13d0FuS09XUm5u?=
 =?utf-8?B?d0xWYzZhQjZSdWtzUThiUVJkK2NDcEw1b05QMjRHdVB2VXFGMjIrZ2E0TlNC?=
 =?utf-8?B?YlFFcENPSzNDSC9uSkkwQmhzZi95Ui8ydEhsMG8xT2pVR3J2eHZpRm1TcWpK?=
 =?utf-8?B?SG45dllWZnFsNkYraGUvY29WdVFsZkxHRUJGaHI3aGhoNGlIOVYxeHh6L2lw?=
 =?utf-8?B?aWpsYlJ2d2JuZUZyYXFZR3FUVVNvam80UUlnSW5iWkJGSEJMM1QyY2ZacUd4?=
 =?utf-8?B?N0MxNmpPQVZoYmtJL0FzdHZHOXFubndSU0Jwd3VUTDZJRlRGQytLQ05OSEk0?=
 =?utf-8?B?WjBiM0dKTTU4ejA3NnIvSlVpVkljOXl0SytvMFR2TTdwSCs2T1hKWGp6d2p1?=
 =?utf-8?B?MXJmUGM3dTQ2N094Z0M4YWcrZDN4SzVoVU1aVWhlWUdCVGs4cmhQNWF3bVNF?=
 =?utf-8?B?U05iQXFyNTJMNUI5V0RhWW1vNTNSdW9xSVJYbENZNTVvODZ1Smc0dGxrSWQ3?=
 =?utf-8?B?OHByUURzKytPMlhUSG52ZGpSWTBKZzROSUF1cmxCZEhVR1Ntamx3NWdja3Z2?=
 =?utf-8?B?M2w5ZUtTVGhOcDRlYisxckRjQ1I3dkJQVmxQQzVBSTRSc0d2eDZ4eE4wOVZN?=
 =?utf-8?B?L1NZWjVUTkU5ZzloVXhURGJNQmNMMnlPc3pPSUZyYlFnZlVjR1d3ajBaTm1E?=
 =?utf-8?B?UEsvNWhhT2Z0bk1BZldEODhZckxIVlNxL3doa2VqWmxhakFUUCtETEMyM0pH?=
 =?utf-8?B?cWFRYm5Kb1E5L2VNOFJOek1zdUNYSVBxUWE2RUVpQ3pDUUJSWDI4WlhCd2cw?=
 =?utf-8?B?S1VCcjhibFpPaE53WDRPcHVrc1h3eXM2L2FXb1dOSDZ4ZnVWMDF5K1piN0d6?=
 =?utf-8?B?cjJaRW9vUlRkNTUvcENyZjVlZDh4VTZaSlJ1eHZvalJOODV2RmNjam1qcjhi?=
 =?utf-8?B?SjJreHptYUtTM25JQzZrNDlBR29LaTA5TWpEb2tYNEFKOGVkSWozQTdvZGFm?=
 =?utf-8?B?b2VZdzJMcDFCSWVIaW9zSVFTSVNSclI3RnlkQ3lvVU81QnQ0dVlJdS84eHZ5?=
 =?utf-8?B?eGN3VXNjc1J5RlhiSzJyUkR2bDJvS253Tk10UDZ6RmxmYUxmUjhNSEZmeDRR?=
 =?utf-8?B?K2xtOTFscFlxb0ZhSjMrNnBueHZWNkhkOERXQXU2cEc3UEYvbmZwUkxYV0Fq?=
 =?utf-8?B?QTlYelpwZTBtZnJtSXYwWDFYcWRzMnU3QWdtTms3NFVlcGYrRlBjeDJqN0lv?=
 =?utf-8?B?WkltenBKM05sZDhRSmExcnpxRjVKQXAxY3NDWkl6Rzd0TitXMG10N1FHb0Iz?=
 =?utf-8?B?K2RlY3IwelpwMldmc3pxVG42eFdOYUZOeFBJbkJNZnRackNkaFI2d0lZM1Yr?=
 =?utf-8?B?THBTR2xRRDh1TFhzZnhwalYza25SdXVhczg0Ry9mTXlsQkJoWUdHb0UrVHM1?=
 =?utf-8?B?MXZaMVpXSUMyWHVuOXp4RkJrWkZrK2g5NjZIdDNnUllVWXE4RG9KRWl1REZz?=
 =?utf-8?B?Z3p4ZGxzZzczQ1VYUE9XUitQVXZ3N2hVS3J1R2Q2ZFk1cE54cXBmRmVqZ05T?=
 =?utf-8?B?RjgzQ1NBWk40eGFtQUpmYXN6aUU4UGVabmhSaUYzOVgrbVVjc0hyV2lRQjhs?=
 =?utf-8?B?Sklic096TGFtcWN1NkpYK2JCd0crbXpsaHRzbUM5R0IwRUZyYnNDd2dnM1NM?=
 =?utf-8?B?ZGhMcVBFT2gwVTRCaEVCdTVyK1VDcDB6b3Voc3ZuVmwwbVloZHQyYk9FT1d6?=
 =?utf-8?B?c1A0WnkrQVduS2d0OFZyTmZxWFhrWDcySHhxMUY0YWwvYjRJY0RwajdjT1FZ?=
 =?utf-8?B?NDdBYUZaQndSbklQd3V1eEtGN1VPcmNDYWkyMGxnQXNCTGNTb05sY2tsNlYw?=
 =?utf-8?B?MmNpaUtsSWxJY0Qwek1ZNVk3VUhtYVdTVkh3TExJZXhXREU2anI0SjRQYllt?=
 =?utf-8?B?dHIxczVvZmhXNFUzZlFDbXJoekZWTkkvd1hCWGtCMGpuQTVLNkZXdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d3745a1d-22f8-44fd-5c92-08df279ad299
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 13:23:22.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS22nEBryo07HulsclVN9th9na18FjKrtHLxjBt3OfuQFytLtRR6LSnehiRYMqBgQ6/LPZx9wZIfG1iYyoXNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5979

On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Wei=C3=9Fschuh wrote:
> Keeping the flags as part of the bitfield prevents the usage of
> READ_ONCE()/WRITE_ONCE() with it. It also makes access from Rust
> awkward.
>
> Make it a dedicated field.
>
> The new field will stay in the exact same location in the parent
> structure.

Incorrect.

>
> No functional change.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  include/linux/dynamic_debug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 0b34343df594..b1ff7c0e9a5f 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -51,7 +51,7 @@ struct _ddebug {
>  #else
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
> -	u32 flags:8;
> +	u8 flags;

This will change the layout of the struct, because it'll no longer be merge=
d
with the previous bitfields.

The layout change can be avoided by make lineno + class explicitly take 3 b=
ytes.
Perhaps reduce lineno to u16 and have class be a standalone u8? No kernel s=
ource
file (apart from pre-generated AMDGPU headers, which doesn't use dyndbg any=
way)
have more than 65535 lines.

Alternatively we can just say the layout change is fine, as for 64-bit plat=
forms
with jump label patching, there's padding in the struct anyway so this does=
n't
grow the full struct size.

Anyhow this needs to be noted explicitly.

Best,
Gary

>  #ifdef CONFIG_JUMP_LABEL
>  	union {
>  		struct static_key_true dd_key_true;


