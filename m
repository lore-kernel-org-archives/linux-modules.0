Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C41A9F87;
	Sun,  2 Aug 2026 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785632628; cv=fail; b=g06sc/zj85bhslEXCieT8DTVuiIEHgktiZu1RH9sq4gfgG9ddQw3M6hfcwwotVFjorGHmoa2qTnbNMesaQjLiLjXih0nO9SmHOq7+WEr9QGBIuhniH+ZskT9Pkr0lMFX6u2NhGbYwCQHUrZFmB1WyONtXJxjzMsFCDW5bRxfr7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785632628; c=relaxed/simple;
	bh=zbSNz/wdt7E1hKMynmRms/ngeGRnC92/v0JiMYhs9Us=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DphIrO4hTPslv0RTf4N3du17SNewRPtan0Jr+stSjaXM2er9wfSc+oW+3MChWtKVV5PuO4cZZevQ+7iqh7PuwPAIpL3okuRy5NVUA88+Y0NA3mSgoYGddbUYqfWrsQyMbZbEdqQ8C6fAEwkADOHSLGf6a0RPwlTra3FdeaR3t4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LW7gSVRH; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LW7gSVRH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AilzoJxZ2HjCznx5LoSnnVL3p/jm34zLud+6z8enE+6usVecJNdUlRQ3x8otkxZC5Ws5exc6Q77IDLRs5FYvjtI2pfsO7MkeWIuNgJIl3VdtFpG6Bge+IK/FU6Pv8IXmHt7TpZcu0TuCzApMhKW73enxGvcs2eP/2L3snMDLqZrKDO1ywd5bT0BntMODMzcabLcM8titMv1ILIE+RZJZLtcZJWyccXmAPagd1tyDNhTJmZNANS65gSAGej9pLkTXkeddnmSSbVnAwtJigo0wsS6qsx00nc524I2JedQ279AEuOfVfYWTpJhLyLV6lFNcbxbHDTVA+bc9We/6CCsO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNaCOJOuwvI1f12Qrybb54HX4Jf6+q7RQokr8/TynTo=;
 b=GB2tBMRy+uLIEXL+ldQ4v9cNtctup0NamCbBGKfW4Xv7o67cSj8yd9kU6pY84vrht2JFxFaTaL9hc9qRyUr+OELN66bvI45PR5KIzrfV5jVongZ2co7UCCGuVJwV5dNqpa8b7QaIP2WjO6rd9GXSlfoQMfImPRF8A1hurRzYd/KGZS/Oo+u1/HWQ64RV3r+Y389gLAjudb7Ziioug7QCVQhzfT0asvykishVdU77uBX9c/yk8sMHJOqnnx+Jyq04sF8y8EagmRuBESmOAAZMcJkrPo8ghdt+CWWjGK8ybZnv76kuId8PNb97yZXRO5Ca+vmfvZj4l4XYlgfJsEPBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNaCOJOuwvI1f12Qrybb54HX4Jf6+q7RQokr8/TynTo=;
 b=LW7gSVRHl0aYJLOWiGE9iuiaqSWmWdK1WznfZCu6nrVqX2qp/5o3dQodWDS8fMKQYz8JitbgGpxR2tOR2KrikzhlgOsTMJ3LC392YvzIVW7KP0z215cZzV5NnJ1yT5FYcf4KKrd6OkuO3hPohbGnupmBopXizG42qnqQerctbRQwkb8dQW+EIF1dsHrh72UmkCWgftHQzhPWrh2DBBzSIG35LdT0Ad4OdkpqilXJu1pOHOSJI+K7YnE0stxR22/q3OMtMBSJoZ+73n9RncfnUsWEEsXrRvppq5CoJcU0pXe0eFbCcsGOMQzOce7kC74tTNpVixF3fYiHsrk9zE14jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 01:03:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sun, 2 Aug 2026
 01:03:43 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 10:03:39 +0900
Message-Id: <DKE1XOP6J7GZ.1NFIHWZXENTYH@nvidia.com>
Cc: "Lyude Paul" <lyude@redhat.com>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Carlos Llamas" <cmllamas@google.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tamir Duberstein"
 <tamird@kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
Content-Transfer-Encoding: quoted-printable
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
 <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com> <amsVU-1o_zNOIOts@google.com>
 <DKBZLF7RMQE8.2KQJKLGIE0X6N@nvidia.com> <amyailSp5MzQQZUY@google.com>
In-Reply-To: <amyailSp5MzQQZUY@google.com>
X-ClientProxiedBy: OS3PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:604:dd::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bfa253-b60a-45e0-b900-08def031e598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|6133799003|11063799006|10067099003|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xbz02nnGuylbmBfBhk2+aCxL4r70KSVeBXB71Z2eVOHsfDTmD1UzngkQWtfuTO5qAptYvvZmav9fkUqn2NWxMY1bdqPU4KWsKmEBgBa5NRuYd49hyzzKchCTOQOr+DjREfz1ZJZSWlJB+G8/gQ+ZZZ/cH72AUgf7PQV46vaeA9Xjh2Zg7oT9aOGY/j5AmzwEVS3z/0TmhxtuAzOngo6jSOUfxT6T9lzxo14Qhyg9umhIHPfIfQl5BzuGpWm/wZ9XI5OQrdRK6EmTPQ7kLOSOg8JRL9JLs7f8QlSy+bFwmEa7SCbusgG9pdP9o4sPD6Arm6BG0GEh4MoWbtUG3+yS2U+Vs9lcsgAtg3OGq/nbILpScix0YCCB7BpGIL2bEz/fVUFiLIYZu4l2sntrEi1IDOTR6MM7eO8qtgkkBOYGqtnIF0sX9Do/zKIDpsenAhQk2UttNJEB4dcCeunZopiE51ApdM+BBJRSoorXy19YBF7KaYlLJtVBMks4fPvsfHeUG1n5AyB+LptJWEvUZzMidSo0CwkwWB7ZtkhEowmOSb4K4QnDNOjcAsC5Z0sHzopy+F9r6kXwLmg+qMvL0vhohKxOwQl5LadF/x9IidDfiffeA+S0qfZkdq9XdsKk8eN5FD/CsUXh4vBLdGmAywCm1EBw59M2d6/eICZ7hFlsank=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(6133799003)(11063799006)(10067099003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnZYUVp5blQ5dWN3V2dyd0VpeUdsQ3c3dXp3alFyM29yL1ZhQW9GYy9nZ3JI?=
 =?utf-8?B?T2ptU2JxWmt2djFCcVVFb3dsOE0xWk93cy95WjV3eEc5YksrTFAwWHNHbjRW?=
 =?utf-8?B?L1V5OEpZemlac0lhei9PVUpSWmlqaGpvUFpQaFNGT3Z0dXJCazFxcHBsVWJV?=
 =?utf-8?B?ZEVmbGNROEUzZGVnUlhtS2hDdGF3V1ZqemR5VUNUM0dVMHc2YmdFNW5VcmNI?=
 =?utf-8?B?LysweWJmTjMxMjFLU1ZYVTh1L2wxaDdiZG8xVENhWStQZ0RHQldQZW1udzEr?=
 =?utf-8?B?WEVoRzBDYlR5b2hxbng5NlJOTXRmQm5tV0R6U0pEZ3BBUmR3NjdsNU9EakZO?=
 =?utf-8?B?dmxFdHhkUjU3ZFRsQ3VNN3JMOGpYTXZDSWVjaGwzQUNlbVZIS3ZWWHY3eEMx?=
 =?utf-8?B?NXBwT2JUMnUvd1ZiYlZ6RGRlT0RhWTg0ZUE3ZmZMN0x4d0lkZlRZNG1NbmJG?=
 =?utf-8?B?ZnU3OHNOSjN5VkQvVElXMjQrMEdoQzR4ejEydzZQZUYzMjBCb1NsdGZEcWNu?=
 =?utf-8?B?ZW9GcEFDZXNpL0JUbG4zVkF6NGVxQ2lmQ0M5RGRJVnNGbWZkdCtrcGtFSXhm?=
 =?utf-8?B?bjMxZjMwOFlOT0E1WmN1Y2hUcGQ0Y1VsZU4vQlE4aHZ2V1l6YWlEdGtMT0lW?=
 =?utf-8?B?U3M3SjdlZDY4eFM2UXhxcFo4WWFEaXZpVUljRVREU1JGS2dJcGRsYkZLSUxU?=
 =?utf-8?B?Y1JLUHlwWFZXZUZzRGZmZEtDV3hvQVZSNVZuODFjUTNXRW9jUk5oZTc2MEZX?=
 =?utf-8?B?OWxzejUrR2lIQVh0Y1F2Y2ZTenR0eTZYbTRiSUZlczdYeUFncXFBMUVRQk92?=
 =?utf-8?B?M2ZaZDVWWkFhcmE0cXVXUVlFdm1nWVpkcG1qK0RKVWVMOTFuVWlNOTJrKzhi?=
 =?utf-8?B?ZGpadUl1RDlVbU9uWVZUSi9XZzNmN052Ull0a2N0ZnlTZVRlYlJ4WEJlS2k4?=
 =?utf-8?B?SlpyVVEyangrUGdXYlpvYllnUzB5c2l1c2VUQUJlTkNPZHlkYUFEdFpmQkRI?=
 =?utf-8?B?MkR2Z1ZieC9GOFpacm56Y1Z3YXNBTWNpTnc0UUVNNlRFM2RBT2pOankxZlZy?=
 =?utf-8?B?ejZIQnBhUjEyOUtLWjVqelMwbEdCTjdkaWZxNDlyaWMvTXdwNjV3Wk9ON0ZP?=
 =?utf-8?B?S1ZZZWs3YUF2V0tuR3FKNXFjbzFyUVNmTkJ0cGdqKzFDR0RSUUlzYlFRbDZm?=
 =?utf-8?B?WFFHMFdJT25oQjV0M2pLUE9Vak93enRxOGlEWVZoOG5QcDBoYzJIeFRDRDIv?=
 =?utf-8?B?czY1VE1vQTVwV2RzM0w3UmlHOUlTVklLV1dCK2krWUk3ZEdDZUNucDVoUWZz?=
 =?utf-8?B?ZFRUcWthdCtzTUd6MG5uRUNZZk9HTlVhck1GakFlckZYU1RGMmZmZGh6UnBP?=
 =?utf-8?B?MTBIZ0paNHhTSlZEMHNVNGNlNkpibVB6dUVsQlBORGlvMCt1MFFkc2pldzl1?=
 =?utf-8?B?b3FEb1M2SjdWdkdkUk82NkpGOFExOUhBb0I2eDdiQXRvc1RTZ1lMQ3pTcUFP?=
 =?utf-8?B?SWJ1OHRxbXJzZlZ4WkJUenVxNmJ1UHFuWkRTamx5MGY3WVphcTNEbUN4dnRn?=
 =?utf-8?B?U3NheUd5SWdrMk52eUlBNDRqZ2NDV0szUnVFdklybExWOVlMRDZTNVF4R1Bh?=
 =?utf-8?B?M0YwY1dBaWcwaVg3Y05NMDlKS2ovcThxZXV3NWpaV1JLVEpnWHo5S0ZxWUZa?=
 =?utf-8?B?MjZIU2hNcUo1bkE0U2lDTTBMc2JndTcyQzlBeDRONFhJSjFQenI5ZE9ML2VU?=
 =?utf-8?B?T253SEQwSS9MRXBLV1RMaFJPQW9IcDczbXFkSWVOUE1WSVJubmNGTXE5bGJ6?=
 =?utf-8?B?VENScmQrRytra3pzZ2R3VnYzNzlOTGgyQ1lVclAvZjYyWDE5Vll6bDRGeWVo?=
 =?utf-8?B?RUZmUnhjbHlyS3lKUjg2ZmRYZEJDZyswbE5SUUlaYnhxTHJOY08weGFIcERU?=
 =?utf-8?B?UFl6K2hmMmJJNTJyUHNKWFhSWEVWMWJrUVg3T0N4SS82RVRIdE15bzRPTTgx?=
 =?utf-8?B?YXNvSEJUK2d4eUJKam53SlVRV1lJbkMxb2xTSWE4TkpoZ0tGcXFXdkV4UFJY?=
 =?utf-8?B?U09LTEltTzVqMGZFUm9ZTXBFM0t3MVB6cXQ1N0lOanUvT25td0gwd1d5U2Jt?=
 =?utf-8?B?Y25IN01Pc1F4eUx5MXNqZjNwOFlHemc4NVIrYnpxNUxIY1krdDF6alczMkdL?=
 =?utf-8?B?RWdYZlJXUlA3MjliM3dVMTBTeTRpMVFZK1NzRlpxR29neUN5UDZ2Rkt1L2ty?=
 =?utf-8?B?MDd3Ti8wVUR2VFRzc2F3MENWRUoxQXJSQWVUZ0FjWHR0VGJsQnJ5MHNXSUpC?=
 =?utf-8?B?WWZmQ0I1Mmt5dmlqTm9TUFFNcEV6TFM3U2kzdXVkaU1nS1I2VWFTZnViVzQ3?=
 =?utf-8?Q?GaRTtgNsEoB77+Sd1F0FFkvhi6D5yOL0tZJs15wTQGONC?=
X-MS-Exchange-AntiSpam-MessageData-1: 47xyLlH3UnsCRQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bfa253-b60a-45e0-b900-08def031e598
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 01:03:43.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMJ3+jatX8ekJSqqEzCoeSJYvOIzc/tlJ+Xs1DRt1sFWnpldGYvu6yLAmEulku7+UqTRi75mph8pmZ5ALkC7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

On Fri Jul 31, 2026 at 9:52 PM JST, Alice Ryhl wrote:
> On Thu, Jul 30, 2026 at 11:48:15PM +0900, Alexandre Courbot wrote:
>> On Thu Jul 30, 2026 at 6:11 PM JST, Alice Ryhl wrote:
>> > On Wed, Jul 29, 2026 at 11:05:55PM +0900, Alexandre Courbot wrote:
>> >> On Wed Jul 22, 2026 at 6:16 PM JST, Alice Ryhl wrote:
>> >> > +    where
>> >> > +        B: lock::Backend,
>> >> > +        F: FnOnce() -> Result<T, E>,
>> >> > +    {
>> >> > +        if let Some(value) =3D self.as_ref() {
>> >> > +            return Ok(value);
>> >> > +        }
>> >> > +
>> >> > +        let mut to_insert =3D f()?;
>> >>=20
>> >> This means that `f` can run more than once for a given `SetOnce`, whi=
ch
>> >> can lead to problems depending on `f`'s' side-effects.
>> >>=20
>> >> In the GEM shmem case, we would create a second `SGTableMap`, and sin=
ce
>> >> `SGTableMap` assumes it is the sole owner, the last instance to drop
>> >> would create a use-after-free.
>> >>=20
>> >> Now this sounds more like a problem with `SGTableMap`, but if we cann=
ot
>> >> avoid calling `f` at least twice then I think it would help if this w=
as
>> >> documented.
>> >
>> > Hmm ... this is the behavior I want in Binder. Actually creating the
>> > value is an allocation, but my lock is a spinlock so I cannot invoke f=
()
>> > under the lock. This means that each caller will make their own
>> > allocation, and then we throw away any extras if there are concurrent
>> > callers.
>> >
>> > If GEM shmem wants f() invoked under the lock, then that's just a
>> > different operation than the one Binder wants.
>> >
>> > Do you think we should add both?
>>=20
>> Possibly... but this would introduce a potential footgun that sleeps
>> while holding a spinlock, unless we limit the run-f-under-lock version
>> to work only with mutexes.
>>=20
>> Maybe the proper solution is to fix `SGTableMap` so it supports multiple
>> instantiations. It is, after all, a bit footgunny on its own.
>>=20
>> In any case, the current versions should warn users about the fact that
>> `f` can be called more than once imho.
>
> We could extend the naming scheme:
>
> * try_get_or_populate_once() only invokes f() once, under lock
> * try_get_or_populate_racy() may invoke f() multiple times
>
> Though the _once naming isn't amazing since it still may invoke f()
> multiple times if it fails. On failure, the next initializer gets to try
> again.
>
> Thoughts?

I cannot come up with a safer design than the current one, and adding a
variant that can deadlock sounds like adding a different footgun that
just happens to be aimed at the other foot. I'd rather settle for a
single operation where the caveats are well documented.

Making `SGTableMap` resilient to multiple instantiations can be done by
just adding an atomic counter to GEM shmem objects, so let me try and do
that. Then we can update the GEM shmem code to use `try_get_or_populate`
after this series lands.

Which means that as long as the contract on `f` is made clear in its
doc, the patch in this current form looks appropriate to me.
