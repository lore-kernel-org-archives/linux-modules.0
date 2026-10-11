Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022072.outbound.protection.outlook.com [52.101.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1103B5DE9;
	Sun, 11 Oct 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723904; cv=fail; b=sQSw125gx77xDQu0saZtt8tTxIGZqzcsLb8A8j8W97EdWYl5Iw/3s9FWOYc3hGh/DHC2fYIhNqIDmv5tvDcgLtBZ2mZthDzm8a0AU040gLumTAzVD9/zrpZVDelPFxMaj13QRSt1nY1gLi0FIzBp04vD7E5q6UsCwEluQSZNXWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723904; c=relaxed/simple;
	bh=IJoTtWk4iImCFbv6flJ3vX8ZQMyNF04gqUaJL9n8aEY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=sYtf8EqqTTghsrsGQv0MdXTz2VY34j0XCDLv9Z9TWcjRK0Rtwbh70lQh9CjGZypXtjtTmBZWeyCtGsAuJVbhsx2xdMp/Y0PmahV/IsEN09dVnLo22fT/x+8/sFhPnIvAhLPl5QwvPkYhVF73ApclUql2nll18ItJ4YqhnkUpaec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JKKnz0FW; arc=fail smtp.client-ip=52.101.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JKKnz0FW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWOfObEaiI1aR6E/1x/nuW58wKg16Px8p0NABuCm7cY0r6MslYfITWfpFTcnxcCG+gd2NQAXxq+Nz7wusgA3zWAa9ihzAiEMsQaj+PLVe8pennrK3EoL4fr/pX1FqdVHisMGiadTCOaZjbUdOOIE9qY6C9xmWWmp5mBLDZ/Q631EW9aG5V5MrJVGERI6ZmRgIGFE3kh24uOJCX98ec1RODB22ly1gpXNCKovg88llC43vnqe8A6N/xYxkczW1CmEGHK0VbxoEw2uwECbN6jmh8NReQy4fkEO/WvlEM2PP7s1uFpGuKGmXwUCon+xEwvYnhQWlKbyYEAViFBzYpAQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFIW3I4AVifn7gVuaCXbLaoCurgUbfk09LfacPe9BVo=;
 b=aKNC/M0f9ZLxw5bsyOqJ9PlTI21GGxZhYvI/0I2qXGxqfCP33HOzBeGWMfwvBC3cZyWbuMBuo5UcW9l6HAVpqVIVMZeUo0D/xLxWQvMmJPTROkvkVaVyHqIq1mJNNOZSoWXSsriBb0hhyP3fU2s4Cm4U5e5HlAXBcAVKoBH6vnd3ZdjglsqZj44wh50aZOEjgf8ZQbcNbnU1C91K5axFdPRI2FGFxsg9OCMpR51h0YazZmWohi7FpGfgcD2eTnCTRSS/A8CLntnN8VcO8Zyvkuun8bhpQWfZMImOBuH2kWPIyJG4UjsBC7OZDnXEyubYYxVEWNwY2XS/99ekepibUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFIW3I4AVifn7gVuaCXbLaoCurgUbfk09LfacPe9BVo=;
 b=JKKnz0FWdYTMwUvOa4y8BsX0MbIGUTjcgbL8BLmQUDMbUY05PTS9tAHVNZQ3i8zD75v7rpcF2CyHSDME8uM5SO6bTqTblNKKoa5XOT/P2NyllY1nq1ouwLp56u5TcI34YCWeOGDXOi7JuCKbk8cdVplVl8KL4SM01NniBA8fHeM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7621.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 13:04:56 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 13:04:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 14:04:55 +0100
Message-Id: <DM2142ONE3LQ.381KFFXMWZQFQ@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 02/11] rust: sync: atomic: Add Atomic<u{8,16}>
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
 <20261011-rust-dyndbg-v1-2-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-2-832e4039b71f@weissschuh.net>
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbd8916-9381-4d55-3fae-08df27983f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|23010399003|921020|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TGGQDQaF75aj09IUmYOpCLkshpA7WJA/L/n3B6XOdPV4I4TrxrhGiTGL+G/0x5yn+d498Ixvn88z+g3BNeYHMt+vZon61qYtMpGjujuEa8pDyhjPOlUWwAPUu0cbMQoso6HHb06RHCo3Gf0Lt/2FqHP3CMk5gLw2fflQyknGFwPCDF5PySt6Xi0LcVw4+wBmx2Fn/38OEtkYsLg0u4vNGP/2zkx/zot0pjBhKYvgfAuD/W5PXz+SZuU4pRrnMrygpfdwfRTYB1KSTle7Li6bsvbBwKPDshJaF4LUHH1sfKTrOp711QplMWkuRRPG19m9tkmCHLcvkwzNQtJHdQcqeHJ1YWc7FtSWed62Adpm4c0rxQ79U3S4uD97l3+if+vukq/J/zr/QBwLSyPyzpqDCAjwEbum2Y/oiYb5oZKlO4B7GJ2z84rNYT3X06CE5dNeCGn7Kh99FxuWeHUYL1lBVodnX/Hb9ScYXyRDqithSepxI+fdQ6CuJD6m8W0IUkkmBVInXGCnG08DmVml1ww4z82HkoL6ttMhUwi2u1w4KYRnOCtRBQmky1pLHNISKbHV5ucQPzx4ny7knZP8x6UrHafTd0KMOn6anQJM3b1EXHrKvEbT/t58VC2OCdfEUhkYG2JuCKUsJVsUPGWXOkg8eptNhtKB1kHtC9G66eEbaMXtcFYxihTlE1kXaGwMombPk7T3Poq0tMIBqS6TzksUqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(23010399003)(921020)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlNuWVJ4aHAwUXZTN2xzLzcybDQzT2w4K3lUUG5NNHIvZ2hJYmViUHhucmNq?=
 =?utf-8?B?clhJY2VMTmdmdUtiTWxTU2FMNGd6SkxTSTlSNXJUZkpnVC9Oc0wvRFB4aEtH?=
 =?utf-8?B?WmdXMWU2bk1qNnZmT3NHOXIxYkgrSGJyaXRXc0x6aTlSZ29GUFlRZTlCL0FN?=
 =?utf-8?B?TkZDem81QmRqaTdsRmpOTmVmcnNYczZVdDJNM1ZURHpBV3A3bWU0cHk1ZWI1?=
 =?utf-8?B?ZUZad3ozd2Q0QkxMNDNtMTFLM3EyS1lXZSsxelpCSnBjOS9WbFJmMDg4Z1I2?=
 =?utf-8?B?MHhCWmtoQVVheE9qb2psVU53WHVkZXQ2UEw1SVUrSjdDYS9PSXk5VWdoS3F0?=
 =?utf-8?B?K2kxTVpEeG94bXpHWHJtdHY4dWkvb3FudVd0NjhPYXhFd1A2SFdveFd3a2g5?=
 =?utf-8?B?ZndTMkxCSjA1Q09MUXN5bHpoV1IzODlONjNvM3R6VVpBbzdpK1ZMb3ZuM3kz?=
 =?utf-8?B?Sy8zU0xKZWlOTTJuajY0UktTTStGUW9NQlpCd2hORUZTeEhCNzB0YU53M3B3?=
 =?utf-8?B?akFOeDBjUTV2QVZEWEl6YkRXa3lBanZycmozR0RvbnJ4NXdRZVF1ZEt2d0ty?=
 =?utf-8?B?TDRKMkRTMUp4cmh4QlYrL2YyNTRpNUlaKzVlWXJNcmc3SFl6UXBabm1reTQ3?=
 =?utf-8?B?cWlsSVR1Zmh3a1FzMnNwQWN0TFVEd2VJMnNhR282MWo0MVBPMDlMMEpLV3l2?=
 =?utf-8?B?a2UzQzlJK3R3amsyeXZrTEt3UklibmVmckoydzFuRjhDQ0hXeHJWbjkwRTdu?=
 =?utf-8?B?dnBLRVk5a1pQdkFXeGNUL1R1elA5Q0FWWnpaKzROQzJla2VXcXVqZ3JmekR3?=
 =?utf-8?B?eFlicmdESGs2RjJib3pWS1pHUFpuclhLVkhLaFVXSkVKNzBUejNIL2Via1o4?=
 =?utf-8?B?ZjZjNlQ5MEJzeFZsZFdVbFF2QzdjVTA1bmpldzlIMlJsTkFhL0FDaEd0a3gx?=
 =?utf-8?B?RWJsRW9LYURkVDdVcTlSVmNHeE54YzNjTTBjaVNjZ2pRSmdMMGlEanNwdGpn?=
 =?utf-8?B?SHBldEdQMUoxTGhjU3NwWmg3cTRIWnhKR3lkMHN4N1g5d3RycnRiVzgwSWxm?=
 =?utf-8?B?TFFsWjRsMm5pd29JQlNpREFSNG1zRzZwdnpOYTZ0eEh4UFJZd2RXTGs0R1o0?=
 =?utf-8?B?VjdBNW4vZnJxNGUwQmEzNXZxWGdORElOK2ozVDVVaGRrSE9udGFHV1hzY0lU?=
 =?utf-8?B?VlZmaGJuT3FSV3dIZmgzUTVobytzZ3RlanJOaFVhK2xDQTBHNHNBV2xFeXVI?=
 =?utf-8?B?V2JRM0ZSSmY5enZUN01KOG1nVDJkL1BYbzFBWDFJczdvanF3STV1cVkvTmJa?=
 =?utf-8?B?ZzdXeTZzVVh1a3l6OXY0N1NENG40RmVibVRwUDFrMWpTRU8zKzMzREFTaGZp?=
 =?utf-8?B?WlFXbExLOFV0a1lxOG05VkFCdXZkaDgxaGxzOTNLOGhKYU5pQ0M2cXVyVjFx?=
 =?utf-8?B?NmxwSTdMMDRkVThvVmg2ejVhNGJBUzhZb0VHSjYxOWZkRjc0ZjZPSEFyWlRr?=
 =?utf-8?B?dWNEUmRoZFVSRlIxMEQrY3JYUXo5UWgrSnRxTjQ5NWFNT2RBdkJxTXBCbm44?=
 =?utf-8?B?YXhwM3RodGYyL1pOYzB6WDQ5NHgvZ0dvUEY2YkRnUUhpdy9scHI1M1ZSTFBQ?=
 =?utf-8?B?UzFMSVgwUkNrM28wd3djOVhjVjJiQ1QzMllueHhmU3VSaGI1T05NbjZKWTR5?=
 =?utf-8?B?aTZkcThNTlpyL1oxMDlPRDZzdndoM3hOdVZ3ZGV5dTJES2FkNXZHZTZEUCs1?=
 =?utf-8?B?SUFBbDM3R00vSDJGU2pkc2hEU1hxZ0ZqVUNNRmd5Wi96cXh4UktBM1NpT3Fi?=
 =?utf-8?B?SmpSQ0RaTHZEeWx4MnJUNmFxTXgxS2V2b1hNM1V1Z0R5dklFR2dOeWhocEdU?=
 =?utf-8?B?TXpZdE9xSEhYNklFdk5pTnArQnlaY3o4OVJsOU01SDgrenM3My96V2lueklG?=
 =?utf-8?B?UFVqK3dRZm1tbE9VN2xFc0d5dGlvQkhaNVk2VWZwd2Rld3dpOUM1aGN1QWR0?=
 =?utf-8?B?Z2VWSjk1aElSYytjMVFwVFdjaUhORXhlL28rRnp6UGN3eFpkRlhoNGlkMXRk?=
 =?utf-8?B?Z2kvNzB4Yncrajd4YnVrRmdlbk94TGVxZkZLeWRSQ1FJSDVjOTF3NVdFY2d2?=
 =?utf-8?B?YW5nelFqaTVRZkhCMHhVdkRndGdscXlod1A2NmZ5cGhrcnRJeGZLMWVoYkVG?=
 =?utf-8?B?YU1EWHR0VGpWdUlyV0wyRWxDY3lKdmhxQXUxTXpSZkYycjVPYWNZRXRVSW5M?=
 =?utf-8?B?Wk5DcDNTTm9iVGZSSDJGeUJ2QkxiN25PRVBRNjllR253NlE4cUNYb2lKb1ZF?=
 =?utf-8?B?dXhwZUZLdU02U2ZTUGtzNVRxL2xmUGRqb3R6cHhkdHdUem8rT0trZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd8916-9381-4d55-3fae-08df27983f94
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 13:04:56.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uNEFJprGpa3gtxe/gmPmsrIVzEpMI2CBChi6NzRm3nj1buHVMeH6OiXFd6vTxzmkJEVN/TeNQ/uvsBviQUuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7621

On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Wei=C3=9Fschuh wrote:
> Add generic atomic support for small unsigned integers that have an
> `AtomicImpl` with the same size and alignment.
>
> Also extend the unit tests.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

AtomicType is something that I'm getting rid of next cycle. The plan is to
convert atomic to use `kernel::mem::AsRepr`.

Best,
Gary

> ---
>  rust/kernel/sync/atomic/predefine.rs | 44 ++++++++++++++++++++++++++++--=
------
>  1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atom=
ic/predefine.rs
> index 3d63f40791fa..4c1fb5e08dc2 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -113,6 +113,32 @@ fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
>      }
>  }
> =20
> +// SAFETY: `u8` and `i8` has the same size and alignment, and `u8` is ro=
und-trip transmutable to
> +// `i8`.
> +unsafe impl super::AtomicType for u8 {
> +    type Repr =3D i8;
> +}
> +
> +// SAFETY: The wrapping add result of two `i8`s is a valid `u8`.
> +unsafe impl super::AtomicAdd<u8> for u8 {
> +    fn rhs_into_delta(rhs: u8) -> i8 {
> +        rhs as i8
> +    }
> +}
> +
> +// SAFETY: `u16` and `i16` has the same size and alignment, and `u16` is=
 round-trip transmutable to
> +// `i16`.
> +unsafe impl super::AtomicType for u16 {
> +    type Repr =3D i16;
> +}
> +
> +// SAFETY: The wrapping add result of two `i16`s is a valid `u16`.
> +unsafe impl super::AtomicAdd<u16> for u16 {
> +    fn rhs_into_delta(rhs: u16) -> i16 {
> +        rhs as i16
> +    }
> +}
> +

