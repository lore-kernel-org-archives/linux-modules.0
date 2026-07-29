Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC84B8DFC;
	Wed, 29 Jul 2026 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334181; cv=fail; b=t/wN8tgHtZmNDi+LmcMAGxain0F+1PRP0MDqxzvk1PXoXGKeK1ZLKHOXchlAWN6zz7xWAEitiKfxQB7FJbPcy2rBRYxf62dnUl5Rucll6GEpXx/IHyblTF9As3kZXRUFErYvTE1dVEOOT3uzobm+1b/XA7hiOdCgYdHMzMsrZsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334181; c=relaxed/simple;
	bh=uRWnC7f48GM5AGs3mDYMQJg2rSqqXzv98TAIsmplRn4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Zz9rbaMhf87QyBFFs0nyd1StnnGKLzKoXlJqWoUk5kLzIONRJyV5HjJ5s63LnOI23N1b3P+NU6S/RHIgVb2PHDowbHqpvz1v495kQBGQhKl4nEDWtC/JX9lYmh3NNf5IGXg2y7/OmWM7TCSnQI5TGwalsVMUDzCP305oVsDUOcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSQ3bXBe; arc=fail smtp.client-ip=52.101.56.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSQ3bXBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci0wYBtZQF3c0iLlIzS2GNjMPyL65LB/bltqwt6bWys3w3ZJZWN5+XIiYSKmUMHkfwwfhS/h8HomW0dlDcbXRS2GBz2q4eg4vF6jlm9Dw4hBlvKcClSsysQwxshctUn0rrVqpbrc+RqXkQgRyaNQuJJwPj0mh4+5OCFPXYVz21YP4GFSfNbrsZNnNUrty8it+sE1X0Xw34nqXb8uA7I3z6hFPKVf3OBmxzW/6l3l4rBJOC0D4nE4KSWLCEUES7rAzM7PiH1XRmOBATYyVRvLzb8FNnqawJ800u3E0K94vVHPWxqMZsMykDgpbl5Yar6kFZ8FB+lMdlBqCl3HNUd2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lAl9R7UiDeUz7jkc3vyOJjR5qE66NUfaKxGe7nSRF0=;
 b=DLYZsn613f1xkbXUwTgrmf71oTA4/jTg48PotheMqP4j5h2d+cIERiSjg9Lv1afOJJUN8tPGglvPwMAPqo+RdF6iuxhsTMQOmpGsN0ZtR58toAyvwkZSkhzczw7fhg7SVc+WlxZ5zBBU6axUeqms+/e99j0kmAd4RKGDN8Zi0pJxn8ysBPL7BTsyjepSqRMdd+RktrPaf0NV3L8zUFWSYj0IKhWErOahO4Zu4w+lLyAmEa/x5z7LssSKk4z7s6ftZP1C+InzvliGI75akvxvWt4S+eXxq9wxk0fterQKLijXoMai7TytSMlqPM5OkYHoCSz4bWNjOXHlOOzqTxQ+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lAl9R7UiDeUz7jkc3vyOJjR5qE66NUfaKxGe7nSRF0=;
 b=GSQ3bXBeKlVfp/nhz8umYtzW4TbgTSeN4QaZkEVKr/Qqf2mVNlAAIy1GAjgn1JytWdm5Xs3qyKT8Q8Xms14IQbNQiNXiWCe5zgFFGizcbf2/K2tzkM/QttQH2Zq2obVFqw41rCy0bdgR3UDyUTA3C51MuvMvouCnT61hnLTp40AgS+mApytrzpRemAR6mc1O5I6ksfCJpqME3W1iAFLoafQDlE3xL5zOLsZRrjNt5TckeIjinB6SMMcsMqgaDbI4jVE0kdh7OHNnt7v9AZwP1CUlqWzCgaLLBlgTHPRazuqO/e49oFhksyuYN+p7/6hWwTlKkXTMmSsXdrXZ/mYWWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV1PR12MB999305.namprd12.prod.outlook.com (2603:10b6:408:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:09:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 14:09:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 23:09:32 +0900
Message-Id: <DKB45883L8T8.2TOSLCGCMSHYM@nvidia.com>
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
Subject: Re: [PATCH 1/3] rust: sync: return `Result<&T, T>` from
 `SetOnce::populate()`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-1-fa7455c26c42@google.com>
In-Reply-To: <20260722-setonce-populate-v1-1-fa7455c26c42@google.com>
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV1PR12MB999305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e92edad-9228-4b79-e70d-08deed7b0522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	e/H9zgXLwZgDRQb+u0ZZn5TnudmUoTR+iebD1q+rA60Bhnfi7ztN5BUO8C4k0kIKsWZXlBVprsAvqTT6/UQ7tP4hu3N+4e9CyyPgq14qJOnkGwk0f7pRRsnArE1vZCCGMclVteh5/LZWq5ia0kl26K7csuwva0xgWyhpwIkVrSCMwkSBsgyqKXloLpRasoRsQFmcmXIr2efOEZDaRzpVqydV156+AT/JZyp/kJAnDFchbvIEh4roKHokt5eNeS9ElzMgxEkzrum4VXRd6CbJBQcbOmtxxZSCdQtiZrZsss8U5Zn+am5tv44phxut/nm8iOuqbH1DbcYjgjkfYYm+uGM637oqO6ixbq+HP0oC/xXrS/9UMongtWWsPX3wmAnLYCJFUyR6k1KRSxfvUCzGnLE+kxcpl5M0rZS5GFUGh4Y99CsDbw0rr9RFlRIARnTghSeZqE7GuRZkEFOCSfuPeQu6Uq8B2J2W11C3azZEsQa25dkKqNRvPhCPgoGrKj07JxIhyoYbqlG3mPjLw8Tdg7kUhSf/eqUQKxQcTBgZNv5URmPmVf4Iy1cww/Iggk3FPvGIsMjrqYrVSMVCHpRdXoBun7ngL/t8tIxxEpEtStTocS2OpeHGXiRT1/khrvSMIO+civX4q2FVZVYq+d2zM7Sm8kxlfCmVGt4brMlCtxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2lQSWtDOTYvQlQvWlpMOElrNTdSTUZscjI3QnYweDdWYXJDdmp2ckUzdWMw?=
 =?utf-8?B?TUZtQTFwNjhpd2NRZWozdVZXYnNWU1ZTaDdSYVVBT3VERnZNV083dVkxdERX?=
 =?utf-8?B?UE5GMXY3Mkg0b1BDRjVwMkVVT1RwbENQYlpxT0t0RDNyakJ3NXpVMlQxQXZT?=
 =?utf-8?B?aVJkV2oxZkgwY2gxTzlIV0RaK2FrUCtVcFcyQUpELzQzSG9HUXJaWmV4RDEz?=
 =?utf-8?B?Wk9ZaFAyR09XVmZQMzFoK1d1b0JwZ3M0bmNtYjBoWW1DRmlhYTVhWW01QlEv?=
 =?utf-8?B?Sk1pOGdKUWhzb3V1NmwwQTJGTVp6OFIyZXJhajFNakFUYmh1dzVSLzZUcDlI?=
 =?utf-8?B?MWVYQTVyMEs4TExNNFdmZHAzdm5JT1RUVHRkSmxhbENoWlRmSzcxMk5Dbm43?=
 =?utf-8?B?SDREdDUyWFlHZkVYdVhtRzVNS1JRcmx1NW5nSjZZdDFoVTdqQldsK0h4S1Uv?=
 =?utf-8?B?amZySUZLUjl3aXoySzFkbHFNYkk0OERnNUlxN3ZYaGM5cWFLU0V0ZUN5aGEr?=
 =?utf-8?B?N0lRYitZQWt2V3REM0hsbm1nZXN5QUwzSkN5VTRObzJXRSt6bzRpRWFPaldU?=
 =?utf-8?B?bkZjZDBnZVkrTitFa2dEdEVqZVV3V3RRWVZuTEUyNTZVQXI0TG50dkJyMUhy?=
 =?utf-8?B?TStRU3pwUnMvcFZNcVBEU2I3M3pBVzRhN09KSWtmZE9jdXZXQTlwMHBFdW5L?=
 =?utf-8?B?N2xiSUVJQXJTV3RUd0UzbnZadGFyNU1DdFB0R2hiMU9USnk5OTBBWUdwQ0Nr?=
 =?utf-8?B?U0ZWR3VTTXcyTEpEcnViajkzOGpleDBUTWNLZWt4V2JKNkxHNUNsc2V0ejV5?=
 =?utf-8?B?Z1JsaDVQVU5qSFdZMk5odjJpbE1mM2xGYUR5S2NKT2xoSm9wSkpjaG9wSUhy?=
 =?utf-8?B?b21kUGlBL1NhME51TE9EdHdLYUVpQWl4MmExbEQ3Y0pxUXd2Wk5INi9uQUVh?=
 =?utf-8?B?T21JRXY3R2pUSm9HUGcwNzNZQzFsdXlhZzIrZ2ZmTGlQQzdYc2FZRlVvOHNZ?=
 =?utf-8?B?OUw4cUVSVnkyK1ZIS0xKWkhpdVo0Tkl2MGtMaVo4VGk1b3c4Q2dybWh4ZWJ0?=
 =?utf-8?B?cURNbUtpSXlINmkxNklLMEVWeC9CNFZFaWlyVjh1UDJjOXhvMUZId1dlWGhv?=
 =?utf-8?B?MkVRVUV3T2lWcDV0bnRXSFlLUTQ0ZXB3Rm5RWkNkZWhvYWF6MjdBVDM2SjZD?=
 =?utf-8?B?LzBtMGtreDZUOFdQQU04eEJRWEZZTHc0VnpOUG83ai9RY1VwS0pMT2w4UUhh?=
 =?utf-8?B?a2s4ZTExM0ZCMlB5VEcyR0t3MERwb2NyT3kyUWtERkRwMXdENXpKRXc5em9H?=
 =?utf-8?B?djkrZnlOQzQ2VThUNytmUkRtM244alc0SkM3MWhUeWFNWUhoRWJRNnJaaGtp?=
 =?utf-8?B?YUFjdytYL2dCUnE0cllZQWptZVhORXJrRlphOHY3TjFxZkJMSFRsalROOW11?=
 =?utf-8?B?N2MwNDBLRUQrTERjTFZqa3d1YWtpd0laNXNHU0pLbStINnNLWVFnZitGWXlU?=
 =?utf-8?B?ZWFrUGFwb2s4a3FxemVRMlprTDNiNDRYRW9yS3B0QVQ0T00wZTE1ODU1OVNv?=
 =?utf-8?B?RktJRGNDVHVxOFBHMWduOEo4QkxKZEdBNDJRMzd1cHhRdDluUHlZRlljNlFa?=
 =?utf-8?B?MVRsWng3cEZJQXJSdzJZc0NVMnYzSjgvcG00UXdaWXMxYmZLaGpJd202TWxB?=
 =?utf-8?B?Zk9BNWl6VndSNlpkTmYrL2RUY1VwTnAxYW5iMU43UGJvNHlVQnpqUXBDNCsr?=
 =?utf-8?B?K0FWbkZlSDArMjBsLzVZa2JldXppYXpveCs0TVFVVWtHNE5tYXpKT3VwVHlr?=
 =?utf-8?B?cm5Cd1d2OHFiYVlJYjI5YURkNjFKV3A1V1c3U1NWVkw0UEtOMThQZ0xQQjJW?=
 =?utf-8?B?ZGgvNGl0UUVPalRWUDh6dEJTNVJGWkZmTFhnMnAvcDRCSnNscGJmOEgxVUhZ?=
 =?utf-8?B?Sk10WStRL2VpamJCVXRCZjZ5eElBYk9YUWgyc1p1UjE4Z2lvTmdQcUdNSTll?=
 =?utf-8?B?dWdPdU5HQmc2S3k5UlV2ZEozQVhKQW5WZEhNMUlVZzNFT05oclBmKzdYUXlh?=
 =?utf-8?B?R1VUb0c5eHo5KzN0aWYzZUlIR2dXeXoweXdNMkdDWDN2N2xuazdzSFczS012?=
 =?utf-8?B?MStlc0dmMUx1VnZFZEczWWZTU3R4SkVQV2FpZ05RSmE2K1ZJNjlYRkJ1ZFlj?=
 =?utf-8?B?RTZQSElYOHhDYmZkbFpTdnZldGdBTlR4RGNhSkNLOWl6bnZUYkxGU2oyRS9u?=
 =?utf-8?B?VURYYWJGL2dXQ2s1NUkwTmUxbkhORXpPTnRSS1dDL2hpbmxRR1BnaHhiQmMz?=
 =?utf-8?B?Q0JzQ2RlRWF5SXkyK1lkTThQTjFzbHRJbDJ1ZzFRMWpEU2wwS3ZKUHBQV1dt?=
 =?utf-8?Q?VPlIt/0dd0JoGUlkkjSX3hafJjgEAgOAxf3msEvegzVdl?=
X-MS-Exchange-AntiSpam-MessageData-1: bikylGWhv8ehfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e92edad-9228-4b79-e70d-08deed7b0522
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:09:35.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dngzbev0A7pvB5GRRVxbVsdYfAyp1spzPR77eO+9ejvzhJw//ALi1NrsiK7nKbw96ANa3U+AEWs/Kzpn5cxY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999305

On Wed Jul 22, 2026 at 6:16 PM JST, Alice Ryhl wrote:
> When `populate()` succeeds, there's no way infallible way to get the
> value that was just inserted. By returning &T in this case, such
> infallible access methods become possible.
>
> Additionally, when `populate()` fails, the provided value is dropped.
> This has two disadvantages:
>
> 1. If the caller holds a lock, the value is dropped under said lock.
> 2. If the caller wishes to use the same value for something else, they
>    can't, because it's lost.
>
> Changing the return value to Result<&T, T> handles all of these cases.
>
> Rust Binder is updated to avoid a warning about an unused Result.

Does the GEM shmem module also need to be updated for the same reason?
