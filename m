Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84A483BFE;
	Wed, 29 Jul 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334336; cv=fail; b=LEw/gceOVWMY5GAzqf4I7YsvsRyzO7BM2Ki7QjgMMbJwA9n/oWH7L/ebz/7sgkpWJEcRKqbT9wC3VAKBzpWsUbVKwL+/UFM/j3LUKN2BCzn4GKvzQ1EucKfANTRSy3+Xj9a88QDH1yKlNixuKxIPtXe9Q+gH0oyWR9vMwJj8qOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334336; c=relaxed/simple;
	bh=WndhKElG7+hxzfzIJ6CGgSnfZM5oFmJaC389kZAc/hg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=anxMBQyeaeF5rYpYCEAoifI4ZIvu3M0DA2EkO8GnLYuApuZXG1jJiYtMFHuw7wIyA1DiOl2JviNZxWWIs2jmB52qOPbS1Ey3c6Gk7qPk3J79ZRiQe0280tIVHt6VjXiZwkFJBnoli6MVLAoSCMHn/jNwl0goiRV+md/2wDD7FjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCT1WrB1; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCT1WrB1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC92IjpK+d0RaUPgnCGfp+YUaeYMUpccoUUROqXuAdN67UavuxJ5oXGQGJYEJ2sgThYFbm7PSRhVmXc3DW6RsfHJs3ltc0RH1DiK3+RWFbbZmsMvvSIoOYV5Dhgl91A3MfNMd5ERZg1qp7ms0krlxFN2bf0I9fPSVl+f3LRjCYIE2pZfTcnMMUvFsaktRwT+0fEMfx+YP/GZNMOjjfdTorO1UNFtASqFnnvKL6azNXnl/mcLgYYKxsGsmtrlK1VjW585kSQLXhfQaUKsH6Bci9DP1QTWFcr0vgKZbb5qEaxXiBZBEXHmdSu04Pr2/Ij1EF0LM6G/0Ioqiz/fhXzBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgB4R1dInb0fJ0wucppnFsCJP6/IKVJV8U67pBWNZP4=;
 b=U9ruVSbAJM6si4TtmqamNUFzEzXdGk31ICkcIFApsgjbeDdVsEv4TuKrYQKE8QBnRrfPoVOB8Qq8y9n9SHnTmiLwa7gwa5BmB9fdJhQlGlfMMeHrbevUREQmw+/eCRpvYQHD7NeRQs9BoTzYg6ABh+AtsGC+0RnL+deBGmgp7alnQaLSMPpih0/F0z53I+3g8mgrinVs4cMNuUJiJF4FA8obM1nSAu6/G9U54eMmo9i8nARfHvWE6swCir/XDxVdJyy4dWbuJFfACCB/hlYtKPr2KyJ0hvfVUnOTep/13r5gVMPaTVYmSXG08JP4yykeM/LWcvEzJLcTaPnsl5BNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgB4R1dInb0fJ0wucppnFsCJP6/IKVJV8U67pBWNZP4=;
 b=HCT1WrB135nKvT/AbIZHT55RnPcSCQdWKLhs9PaMXlv4H0UJPxIPbrNxD/y56LCMO2q9xm7Xt35IKmydURB+cFOVlaPf7dJbKFUJTdFkV16COXxPm4tS55HSpZAmiJIqMzV1lyZxolPQIdncwHjF0ETd27DA6vL3UUiLq/MXa94d4f1ef3ISdLemzDBR/+d8IHEhZ6q4Nx0KeefWSw4wnl9CylJwilaRpqoQw8Tyjq5cglZ6qTwE4vNfE3XXTV3ATwdO+JVpD/DzPGVKdS9Q7b4AC+Oaei3dXWFczMDlaOnsWqfusJd88BsgONQC8cgoFIiHHNU9C7DiKovmF5wk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:12:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 14:12:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 23:12:04 +0900
Message-Id: <DKB4767MNHI0.VYDHI9YEYILB@nvidia.com>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Lyude
 Paul" <lyude@redhat.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
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
Subject: Re: [PATCH 0/3] rust: sync: add SetOnce::try_get_or_populate()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
In-Reply-To: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
X-ClientProxiedBy: TY4P301CA0094.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: c6833d7c-b38d-485a-2f1d-08deed7b604d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YPesWayPBPJeezWoWl4wMsrgiCVNj7ItbeVY/oewZVHz5c4VpdNzELRNNnJUKX+Qs0bA7s9XhTEIN+scxv+yuPcbsZ327quG55++flG8tCV0MTcPqZpft/vvAO1Jr9lmchNkLNMOw6hPkFsGf/y0DTXAa1j4W903gEchrjhagxzKpcLunmFVgj1rIQJmD1vmBsphvH07gDtQJ0S0EZ/CRkPtEJ+yK0I3NgfqyDRY4Mz/Ddx/9T4F/mtZcklFFxTusJQmNwfLvjP5EetOTQeANsGMOp+HxGprkjdG04W1kCQhEyWdr8c+k73wN+Hk1rR64DJdeZdrZeUv2IW9aCp4rRneoHrrIbYkFHj9jHewZp9j5sNnxFuDS1CV1zDzgGEkoDjm4rkxPiN87bg19CQV6mDZtRiDMPUREjOooUKTN9bhj5n7vdoLxs5S8m169v4af1YZFj7YvJ4YuQufLtOV1hbAC7Ka0p+IK7NZJ/W0VfbM+a5q/hfA3JIHWZnMuMZQypEBiRNf/3KTkkH1FfLVfC5MhDxAc3yNaSp3bg9GsIvCuN7PebT25H59C1z3GQuFZ8l8th2Qij8uGLQLLSDP426ECXtWtvYdooJTij69p/J3cXr0pUPl7Xn53T8/d18xanQX5nMF243+6FBezzs6YiK1H5VlmCeSTOX3l7qnzsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEE0QThhYSsyb2NNR3JqRjlYVWtLS0llWGkyckhGWDJiSis2ZGJzaUg0bUph?=
 =?utf-8?B?WG5wNjl2R3RlQ1FSeG1tMjdMN2IzaTkxd0VNdElzSUVKVUV4Nm56RXV2UWZx?=
 =?utf-8?B?RFhiTkljYTVrUlcrZ0lhU1pYMjB6UFhIWVlGNU9xZ1JkUTNxRmd0NjBoUW4x?=
 =?utf-8?B?YmU1dncvRjlWOE5kVVZPWUNEK1V2TkxaWWd4T2dYc0o2WFpZWnR1MGNqY1BN?=
 =?utf-8?B?QitidE9hVVNoUmtZUExJcGJPbXJPay9aOHVBUGxmREhhelNua2VwY3l5MGlF?=
 =?utf-8?B?WC84MExjNzYyVGdkcFNCVHh2UjFRWHNpNXdRTUJ4Uis4U0pVYWlPdUNKODNj?=
 =?utf-8?B?MU1DT3ArVDUxMzF4dnZJSnhVWldNT0lUNWdPWkVqeVNOZlQ3ekI1TnovNkZ0?=
 =?utf-8?B?K0dBbzd5Q1dwZTg4NW5lcXJXMEwxc202TXYxZ0tRMDM5cnI1R2FHUFJBTW96?=
 =?utf-8?B?Z0hTV2tyUlJkczhYS3dsNWFodFFmQXF6TUc1UzRBVC9zOC9GTEs4Nkx4Vm54?=
 =?utf-8?B?NXN4R2p4bk9PT0hMRjV5T3FUWXJvT1laQklhL290UEJ1VUZEbS8vRXpxTEtZ?=
 =?utf-8?B?UW15SmkxdGc1bzFWV1oxRldPK1VuT0ZDQmVqZTNweGFJS2ZuRDdBWjZiNDgw?=
 =?utf-8?B?ZUdrQmZQWHJaUURvemlqSWVLM29iejI0MnhMUHMvd1B1WDR2QUFZTzBFOWJz?=
 =?utf-8?B?amt0dWJPYlJESjR0VEx5QTZMWjNmakdKVnFGR3c1SElvMzJNT2FPQTNsUExa?=
 =?utf-8?B?S1Uvci83SDJuSWZWcDIrRFZ5OFpLWmxBOVg0SU5uaTFyaUxxMzdvZnFYcEo0?=
 =?utf-8?B?Q0Njck1qSkFUTXhSTXBCN2lKZmo0UkZtMnVrNHZXVm9EWXVxcmw4RGpwU3RB?=
 =?utf-8?B?R2hDb25PZUtCM2FFYXh1SGtIVzl2TVlxYlZxQWVPWkQ3VDhnSmdkVDVsQ0E4?=
 =?utf-8?B?L0l0SGRwUnIrQXJaeFBNTjVVNFROUkp6WjZBMDV3Q09IbU5rQmlxQ1pNUW1r?=
 =?utf-8?B?L1RENEQwaG9DTUhkclgxeW9IUFRHYldKVUIzNEtJSnJKWUdvRmlMQzArOHFQ?=
 =?utf-8?B?Zk11VFkxMi9RV2doendxek1SOE4wSjdxMWRoaSttaVVOVUtKNENRNUdiZkpm?=
 =?utf-8?B?Uzh1MWVtNU5wbTM1TDA3enh4M3NBN3dGZTI2aG1GMVhnb3h5VXpSU09LaDR0?=
 =?utf-8?B?UmpYZjZqQUxrd05aMHVtTjJhcGRUZnZpOENnU0l5ekJnYkVocjBwNXdYazFL?=
 =?utf-8?B?Vll3eEQwNytVeVB3RElLUDJUcDNYcTZSci8zN2E3b3NidmlEd28ySjl2TVh3?=
 =?utf-8?B?UGFFMTU2RGxzNmhteHJDQVlPU2xWTGFRSGk4NCs0VjRsUGw2WGxtTXJpV3Ra?=
 =?utf-8?B?MXNFZGlxbUlPYjVmdXR4bGZpT3JRTlEwMFFibTNHTVRpQ1J5Q1hEYUN6alJx?=
 =?utf-8?B?YnJSUEVUSzhDZ2o2b0Q1OVV0cHRiYjkvV1diU3Z2aUxOZ3BQbzVPU0VYKzE5?=
 =?utf-8?B?RkZKY29LL080OWtUQUsrR0J3ZVFSd3REZTVkMW9oQ2c5WHMrSDc5ZTRFU1Br?=
 =?utf-8?B?cTVBNmxkcDlZT1pMOWIyU1hDZmhsUjBGOTh0bVdSbHNwZVdQTWhaVWRCUHov?=
 =?utf-8?B?czFIL0xrWiszRzBvTHp0ZCszTFNKMHBmcGNLK1dwWVB3RUo1ZkkyaSt0a2Nt?=
 =?utf-8?B?MWhQUW56Tm9NM0ZvM2J2dkFIZ1doYm5yZ2RMTlRDNCtFY0lOeUF2aUoraUg1?=
 =?utf-8?B?c3lEaWNtK2NrUlByYkpaTlRBWm8zdHYwckRSdUs3ZmZzOXhqTHRkSEhpWVFq?=
 =?utf-8?B?RjZ1eklwaWxlUFh2NGtBbUx5VnRSeXRjWGE3ME1qL1RvWTlibWY1Rnc2aUpJ?=
 =?utf-8?B?d05FR2Q3dzBFMlNYbEJEOHo4dytUQkF1cDAvZmhBOTlia1pFSi9iekRYaHNV?=
 =?utf-8?B?T1ZvTnBva2ZORDJYS0pWT1JpQnBIUncxdnNYOXFxM1VRQ29MNDBKZHFOUjJR?=
 =?utf-8?B?K2RHNFgvWVUxL1lGSG93Y0lHTklVcXVIZDhnenQ3dnNVU0VMeEUxaGdsTkdS?=
 =?utf-8?B?d08wd05EZ21FR0ZrUGtYb1JicTZQM2szQzg3eXZHOE5YZ25teVNwQUltdUNC?=
 =?utf-8?B?RkhvUEM0dE5zUkg2U1JQV2ViaGNSLzY3OUZEQzM3cExQb2IyS25hSmU2WDJw?=
 =?utf-8?B?SFBEc3hOaGRDYVBRYlFBMUFsaHpMYy8wNUo2RlRKdFhIeTJRbWphK2Zidmgr?=
 =?utf-8?B?K2EzdW96N1ZRd3ZGcGtqWWI3Z0FkWTA5NHBKcTVvck1qZk56TGRYdi9wM1Rm?=
 =?utf-8?B?bkFDMHIrK0lrT2wrU2EvU093QTFlM1JQTWlFVnZ4Z1NtYko5UG14anJWUUZh?=
 =?utf-8?Q?jmGsHvIjVVwHvE8W1GkzX/2gzj210reTJOyj7gwWS0z1O?=
X-MS-Exchange-AntiSpam-MessageData-1: J7bw216lo4XSmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6833d7c-b38d-485a-2f1d-08deed7b604d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:12:08.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3go84Hg8o4h7NpQ1Op9Z1+gOnWc+F+tenUUN4q4hHD4/zs8VzMneBdnghFbS+FuXPpPXsUVko8yFXsE9zu1UXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305

On Wed Jul 22, 2026 at 6:16 PM JST, Alice Ryhl wrote:
> The SetOnce::populate() method does not internally synchronize callers
> that fail to populate the value with the successful call. This means
> that naive loops using as_ref() and populate() can lead to spinning on
> the initialization, which is best avoided. Thus, provide a helper that
> avoids this issue using a user-provided lock.
>
> One potential alternative is to change populate() so that the failing
> caller actually does synchronize with the successful call to populate().
> However, this is somewhat tricky:
>
> * There are users of SetOnce that construct it in const context, and we
>   currently don't have the ability to do that for most locks, so we
>   cannot easily add a lock to SetOnce.
> * Just spinning on the atomic is undesirable unless we disable
>   preemption in the success path. If we do disable preemption, then that
>   raises complications for handling the PREEMPT_RT case.
> * It also raises questions about deadlocks if populate() is called from
>   irqs.
>
> By using a user-provided lock, we do not have to worry about these
> issues inside SetOnce.
>
> This series is based on char-misc-next.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

If would be nice if the series could also include a patch updating the
GEM shmem module, which is another potential user of
`try_get_or_populate` - in particular since the current implementation
doesn't seem to be a perfect match yet (see my comments on patch 2) so
it would be an opportunity to refine it.
