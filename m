Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC763033F7;
	Sun, 11 Oct 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733503; cv=fail; b=D866IIyUuZgOEWt70coLX7Z7p73YdTkWrx41iiXnC2vjLVdaMV29BBXzGiwPHUUOL7yaViXgWFlcFycFGqkRLmDXCVBCGJ5nPbsJaf1rF5Z+RE7e5emrHsu9L7eDw5hpP+OIRuTsqdp/HKF/d7DuOjO5T2QQaRm6/qz+EbcbZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733503; c=relaxed/simple;
	bh=B2DSTDTOGOv/rOHdqhBboZSJ08oFMA9/3czWuieaXo0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Vw02JltWyiYFYCh+iN0kHwMhZYuYgwL6mIl7ROHfNmYJWwk/uLFy9v/H8FM6DeiGFo3+g+FbuoqxlMdi4CsTB7JEdGkn6ZqbmLjz/vWI+9Ah6HR6xOghW8tJ3KMNwleCtn8sjODKht3IsDAC6NN9pXe3ZZA48hckLTNlU7iHhAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PQhQRdHt; arc=fail smtp.client-ip=52.101.196.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PQhQRdHt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQyciRTVKOP9otcHo+2LQRaVLd0D0Ros72NxtO5rxl9iZpEpD3WK+JYKS0s34bHSyRkmIxfWdzd6iYRrXROs5aAshwrSpVw1Nvg0Fi4kk0fwWUB85if5vUJqmRK7NGSU0JGjJh2i1cxblwclz5zhFtpT8iSCmyXOycHGjF9LfnbE4GQsj3DCjo9teFYuRR/ag7ooXVt60zglXNd1MwOcx/hu2fXAaEd5JZOhE7Wid4e/6xYggDU/oUCtBRxgbKIeD/vhYvwknan9MbyDr1xdNfTGjs682NNRn20DL0hVcEqby0JeGxhM8owxejgBsyZkOw4kdlZ8MTacMy1TzVrfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqtP/oN0mMwKvxkYAcn5T+CY0njKIKUQcZNGGAi1TOY=;
 b=wbGy7pnUiNR21PoYP/N1yYZNNh3y9nKPEOd+U5bFLm16UdXnmdokNW6gyhriEKyqQtZ/DXXR8vfLRmO/ShsPtE7XwiKUmnPApzoMVNl65put0eHjkFuBqoJ8c+LGDlTmQvr4H/P4dNi9zBTmXIT8h5WoU5Ig3rlF1I16S2GJ/6J632InUrV51JTZHPJnZ77USZoHyZXrj2iLFZjPQQ76vZKcdn1BpFKT4h+PxZHp+0ID1AsVEvIcFyiDXkXpYHXgBzAdrBJUbpS91PhCwUtL8QBcBiUzOJe4OrS3KSEqYkuuQnzqefkDoPhRSo1tYDaW/OzBOvv3X4iqE9AqM/6J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqtP/oN0mMwKvxkYAcn5T+CY0njKIKUQcZNGGAi1TOY=;
 b=PQhQRdHtqzzlh0RdoGkoGlmsjgPSAPqWYJL2lF3kjmz+uPCfqqEl7hZTHCnRlBJh45mkwMs8vPDDvllkw5EEw0I4kmq4GOSMpsa28gfAPO2AVgS3xesDwN0WrmeqB2o0ogJRi4NA57cc1vsB5k30+fpoU6iC5knTc+MJdO4fPrU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB283974.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:601::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 15:44:57 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 15:44:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 16:44:57 +0100
Message-Id: <DM24ILDFAOHD.1RK6EEYBJSI58@garyguo.net>
Cc: "Jason Baron" <jbaron@akamai.com>, "Jim Cromie" <jim.cromie@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Lyude Paul" <lyude@redhat.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin"
 <atomlin@atomlin.com>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 06/11] dyndbg: make _ddebug::flags its own field
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-6-832e4039b71f@weissschuh.net>
 <DM21I6LV89ET.346IBMXXFE97K@garyguo.net>
 <47f2f7da-dd58-4959-9b00-b96a54ba6ee3@t-8ch.de>
In-Reply-To: <47f2f7da-dd58-4959-9b00-b96a54ba6ee3@t-8ch.de>
X-ClientProxiedBy: LO4P123CA0399.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB283974:EE_
X-MS-Office365-Filtering-Correlation-Id: e03dbc54-2d25-42e4-044d-08df27ae9a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|10067099003|18002099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SZwn6fFktR3HWCLCB2stzoIc17SVGMVaxoRnYlE+1dBfTIgELAgl5UC60ih5AMx8fplDjyHp39nuowysVlq2tT4BM17/YKCDCCA6RNrxDLvGUtW8Do/n1+zEwcV1U/ljZ8Zvf64ZZL+kWcIq7JsjwdxG13crFJkq7qfQy61uXfSRusBJanT1oM8jdS6o0C8N9JIwhsqobp0CODHescBQrf24rIaFHvgXYlIBTkz1EbXurm1UGplrjmw96gW37AmLFDP0dVKGARDnnYJr52LPU5YPdzCpNv74/fRTRm6L4qtgQcRRo0MfcOp6LZUV+gT90Aabzdawg96dlwB/mb9+lxfyp7dZVU4gq7jeIlv3QCrmCmed0Phr8s/1ZCBfT0X/tAwkpfdhSgnPWzek1QQscD0b5AubVKTCMpe1WJHBBG2t+fgbvATvJt4sZpAHy2PvT8ZiBp4gOKiQVGw+lBwgDFwCUWb2a3utOuhiI3bQ/SsSE/FojRiGnf4wpsB10SdDaNUfth5dwlG832LvuH37cI/s1O46yGNeG/nV9B3ERrOAvPVLk0bH0IOPJZuKGcVUdewyl97hC2yBdUlhoEIxnBonR/P85Ksvx4sUCqSouCiJTnY7bfR/iB8dafLaAUE2zFSdyAxNiaP1t+6F2y17NTFWdzwjcCpuTdeiRgtICY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZRQzRkbGNIUUdEd3dhcVY3TEUzanN4Q0FqV2hLd1VmTytpRzlVTmFEa2Ry?=
 =?utf-8?B?T0twczZhc1QrcmFybm9jb3ZlV1N0Zytwa1BVVExkR0ViYkQ3czVlZGxkRytZ?=
 =?utf-8?B?ZXVaRGkzL2FYVFdqQ3RyUkxweStlbjgxRlBMcFc5bXFWaGRTKzJpcFowNGdV?=
 =?utf-8?B?R1RWUkM5QUtjTmpHbzBBOWMySGUzSkRUUG9CUDZiME40SVdyZHhIMURONFlj?=
 =?utf-8?B?bktPbjBsZmJPUlRaZU85Z3F3YmtyVHdVOXZlYXlxM0pZUEdEVmFSNHc5Mkkv?=
 =?utf-8?B?dUZtbUJlbVZRU2FTOXo0ZVFjMHhKaGZzaFlCRW5xNk9DR09ENW1wR2hmREFp?=
 =?utf-8?B?K3FkQ2V2K3gwZ3FEMFVueWF1cmRLcnJkRXN3Nm5jQTNPTVdqSFkwdjNjZlc3?=
 =?utf-8?B?c0hMbDJJK3B0dTBqOWVaNXpxbUc4VE1qM2hCc0FiN3hjdGZ1aW51SWk1eDFF?=
 =?utf-8?B?cWVZc2xQWlR4ZEZSRFE4eWMrOUlQbmpuNDRMem9hekRCWVNRNnVoamdmcGdT?=
 =?utf-8?B?VnN3YUtzSTduWnRUTFpjeXV5Q0VZVHltMDBYQkRMQjZrckhraTQxeFRucHZP?=
 =?utf-8?B?b05xc3BNWVdtV0J4ckF0S2NtOWxVZmpuSUpyWERiNUYvZzQ1c3lOdkxQVHlF?=
 =?utf-8?B?c1hYT05GMDhiU2c4R3lBVFBXRHJNUjdLUWpicFlvVENiRGZvcGtqaFRBLzAv?=
 =?utf-8?B?TGZvb2hpZGZLeVVRNFAyL3ROM3B0NGNOTTFKem9MeWRXK2VNSGo4Zmt6L2wz?=
 =?utf-8?B?MU5XY0RaMWsxd29wc1VxcVhtekNySDdqVFp2aWlJZmpFcWxkK2hlZWU0S2Uv?=
 =?utf-8?B?SzlpL2R4WmYwZ2FFNldkTGg4MDZKdlVoNWJyRjh1QUpoM2JicHZHbC8wbUFl?=
 =?utf-8?B?UTlaREJ5R3Zka0d6UDBTc1lPb1lmajJTa3Y0QktJTHBUaHB2cHJMVXdHc3ow?=
 =?utf-8?B?UlZnV3IrMGEwcjV2djBENHlJelNkdFhCeVR0aC9oU0JEaTRrU2ZnWjVMRkFF?=
 =?utf-8?B?ODBmR1FibWcvTEwxa1VYb0pycmdvQmhOb2FIOUtrVnZwSTlWMmpKZXRmRnMx?=
 =?utf-8?B?MnFkY3ZhRnhKNjZ4RzdnQ0VRM2NwekFZbElmZzhmWVBqK0JpTGgxUm5NWnU5?=
 =?utf-8?B?MHBzSXJrUEp2WkVpTW5YMDlDc2RiWktyZ01nTGdlUU1NMzBmYmhhNm9pSUdi?=
 =?utf-8?B?T0dmUGw1ZHY0WXBQb3FTU28vanE1bEFSbEZuWEFVQjhka1prc05HVXJlc1R4?=
 =?utf-8?B?UkZJcldtQUJKM1orWW5SZmRhekRlUjllL1Z2cjRJbGtBMEg2RnprZnR6NVBP?=
 =?utf-8?B?RGJnZU9BbkUydXRSQ3dtMW5zNUVCUEpPSDF5Ry9OVjlXaXRjdHA5VjF5STVv?=
 =?utf-8?B?c2tlOEdoZnVJME1HNnpYMUxXMFlRZlFPOThwSVlBVC9QVzZyRzdibFpvTnNh?=
 =?utf-8?B?cnVZVXdFMXg5emFETkIwaFAzYWdnM2YwQlgveFYrVURuNW1yeGt6T2hTOGRm?=
 =?utf-8?B?VXI4MFhrMEF1K0NKZlFpTU51VlpiUlRvTnFicy9xc2pxWU1CTnFqUDA0Mkl6?=
 =?utf-8?B?VktRZzFuNHJnVDNMSkNsZHo3d2NUQ0luWkhYRVIzQU5TN2oyVkdxRk10K095?=
 =?utf-8?B?aVVFc3BqUnBndzFhZUNvdUE4RE0yWGhFYVlsTFlZSkczbVBxdEdnWkxCZDNF?=
 =?utf-8?B?YzdSYW8rVTNZdDArWFlvZzlJSTU3dEdncnl4OThIV1dxdWFwdjlJVVRRWllr?=
 =?utf-8?B?d1hDeFBvdTlZbkh5K1dOOXcrZEJYaHI4dDlkU1JKYkdEaHVkMTYvSmVocFdZ?=
 =?utf-8?B?WXdwYmM2RG1tVTVqM09rajIwYXA0TmFNM281dFRRYzJ1MG5ndks5MnRiRkUz?=
 =?utf-8?B?TnZ4TVc1MFFiZ3dQMEFuY1lXVzNmTERBTHNBbFNxQ2MzMVBCOWIrYVVqZDlp?=
 =?utf-8?B?TmFRL01zcUpBV2xnYU9TU2V1ZFZXdFd2Qk9ZajRVTkNUTVgrNWVkVTVBZkcr?=
 =?utf-8?B?aGxxMkhDQkpDK2dZYWh0WGZ0Nm9DS1VoL0lDQkw3UXlySmhlYVBoTm93R1lU?=
 =?utf-8?B?ZXNoRGRpdmVXSlNWRlZJWW13WDc2TXRxMk9URG01WU9uM2NaN1llZmp1em9J?=
 =?utf-8?B?aGljZXhRbERVYU03a01NMXYwdm1XZGtNRE9uMktiWno4RW0rN2ZDUnNrSWNy?=
 =?utf-8?B?c3FFMWhCYmtvaTRRdG0yTjhPUHNwVWZvcWJ2MkFBejhQQzMwY3JGY1pFSXVr?=
 =?utf-8?B?MHZGMFIyTWZpVlZCTkRZVUJWYnpOZ2kyblZ1RWZIK2VrSWtXaEpGWTFuUVVG?=
 =?utf-8?B?akNlMWRwRGhUQ0lORTgzRHFsdHFyZ0lIRU9HVzl2SnNBNFVSOUdoUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e03dbc54-2d25-42e4-044d-08df27ae9a49
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 15:44:57.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1TCtdjLmsEVpDD+boG7EQjMdEBdECpzPEdMUNasbGEjyIOgop8wjplmbQ00fPZss6Y0H3Az897/2B/xhmgnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB283974

On Sun Oct 11, 2026 at 3:47 PM BST, Thomas Wei=C3=9Fschuh wrote:
> On 2026-10-11 14:23:21+0100, Gary Guo wrote:
>> On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Wei=C3=9Fschuh wrote:
>> > Keeping the flags as part of the bitfield prevents the usage of
>> > READ_ONCE()/WRITE_ONCE() with it. It also makes access from Rust
>> > awkward.
>> >
>> > Make it a dedicated field.
>> >
>> > The new field will stay in the exact same location in the parent
>> > structure.
>>=20
>> Incorrect.
>>=20
>> >
>> > No functional change.
>> >
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> > ---
>> >  include/linux/dynamic_debug.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_deb=
ug.h
>> > index 0b34343df594..b1ff7c0e9a5f 100644
>> > --- a/include/linux/dynamic_debug.h
>> > +++ b/include/linux/dynamic_debug.h
>> > @@ -51,7 +51,7 @@ struct _ddebug {
>> >  #else
>> >  #define _DPRINTK_FLAGS_DEFAULT 0
>> >  #endif
>> > -	u32 flags:8;
>> > +	u8 flags;
>>=20
>> This will change the layout of the struct, because it'll no longer be me=
rged
>> with the previous bitfields.
>
> It seems to work for me:
>
> struct _ddebug {
>         const char  *              modname;              /*     0     8 *=
/
>         const char  *              function;             /*     8     8 *=
/
>         const char  *              filename;             /*    16     8 *=
/
>         const char  *              format;               /*    24     8 *=
/
>         u32                        lineno:18;            /*    32: 0  4 *=
/
>         u32                        class_id:6;           /*    32:18  4 *=
/
>
>         /* Bitfield combined with next fields */
>
>         u8                         flags;                /*    35     1 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         union {
>                 struct static_key_true dd_key_true __attribute__((__align=
ed__(8))); /*    40    16 */
>                 struct static_key_false dd_key_false __attribute__((__ali=
gned__(8))); /*    40    16 */
>         } key __attribute__((__aligned__(8)));           /*    40    16 *=
/
>
>         /* size: 56, cachelines: 1, members: 8 */
>         /* sum members: 49, holes: 1, sum holes: 4 */
>         /* sum bitfield members: 24 bits (3 bytes) */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
>         /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
>
> (x86_64, GCC 16.2.1)

I stand corrected. I thought the type change would force allocation unit to=
 not
be shared; turns out that this is only behaviour of some compiler (e.g. MSV=
C)
where in GCC this is not the case. C standard says it's an
implementation-defined behaviour, and I guess that's why people don't like =
using
bit fields :)

Given kernel assumes GCC (or compatible behaviour) I suppose this is alrigh=
t
and you're right that the layout is unchanged in this case. In that case I =
think
using what you have is fine, but this should still be merged with the follo=
wing
patch that adds READ_ONCE/WRITE_ONCE.

Best,
Gary

