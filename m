Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B96436BF8;
	Thu, 30 Jul 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422909; cv=fail; b=rWH26Zulp2tegJKmGYuNnpO0IxzT5mVcu61OqU89Aii+ragO0x7hW92CIGQ7YfdAMnVvLJ8wSud+VFSBD5v3cinViQAI+TUS3QPsxbBhcOIdczjDAwH5ieQbrkspHBtC/3krJh4p577Y+LmQ0bZVQ0ckFxMgwNOUl6LOv7ZV8Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422909; c=relaxed/simple;
	bh=I7kOC8RAg/UsHXOzS7IheKoDdn3iYPaHrfjC72PlL8I=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hyoLAI67xv0l/sdsIKrJeGBwXIxdzV8BkkrMuALByamYTqm1l0+BbBgiCIEwn8QbZfTCfmYnT0t3boo8zzeajVLj4/b2CUqUTYhi7TXxPBmLJVrJL6yeoGBBm9XfPJL4bBb43bnwtaT70F7BhbcDhEY7UHLfqfCqdWNrktLTbQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajx1s45f; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajx1s45f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+wMUOGZS407eqnLHJbHiJuI8PWbTeU1E1fIjdVYt5AyU9gtI6KbTmyJCXzP9gJDLnWAjTtpMBjfScZzb1BLpCkuUiCHFTkxRKaD6t2lsDfCFn/zi5Es8jQbfS5b6n8Z2fLKRxYGKLquj7I/yQvb6bPSYRHBW6YSaI6pW75TRnIiL1jbUbLtWN7zrJH1Wetoq5hdhFQk8Dmnix4+5KO8kKaAbnx+fqJJp2QTlHrtFFxYlS8Cdb6+aF7nXwuRDNOKaFfo2Jp5J6JJfxiwZKIDKPBqqTN8158cLsWDgBws+B0UssI8rpT3QX2qEO7eEG+7ZzGRIKp7eauZym08a+eDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2C2RoWeDxtbSWzyVmjEkMfyWeFW3FqquaAVio1kA6k=;
 b=IFJ32HRyUXhQeh+ToGn6qfdP12joGumrR/cLkCyyUyoTrJdhKCFHEq8Puiar8Ggq3wAhAbr4xH9YFQGbk111w2NxqrMgzZ5LXVNPgOeWdQBnsf7JTHzBz5iVnFcjze+Z2k9N4FBdAid9EYdhjo/3WPVvyw6sTo8UacXSb32bg4uhEeAb/fiZZR5MF3ER4Rwq56/pI2+KXEqIC8Vpk7XP2qYaoEQcq7U03Avtmtrwo6VJxpQkg0rH3EnF5kruLXZ0wOkP3nhfAob7zHrxqNPNJSchSzxqAAvkVB0bOVfVo6wgm10w6Qm/xopU+xORhsXIJ6xbhg8cOOJ7PoOOTT0FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2C2RoWeDxtbSWzyVmjEkMfyWeFW3FqquaAVio1kA6k=;
 b=ajx1s45fCrFFDGUGCNp1flIXpZ7Y5p0fL+IiUUNpjgbOOupd5p78RN9HBJ10u5RwNIUDNsU1hxGbHzcbmKTGfbLxmZ9qC+/BU9pPPCdJK4i7KgHfpiHRnc8z+1/WMkfZ3FOev7C2tDmiq/AXTFHlC/djQG3NdFbUba5aLzc21UKT1zBF26Py6N+6ZuT2eiEVAsjXH+XbGBLvtOh5nK/kryXEF7g+B+OA/Cbc6mWKJjAaLt3c5SF4CIhQR47Jt5GSXEXG+m3LL+r7Kk/rA9KF+T32e/RV4DO3SyCtnniFJlIBVihvUpX0zjOTxYxUd4GMxbMb8K2HicjxO5XhvkS3vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Thu, 30 Jul 2026 14:48:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 14:48:20 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 23:48:15 +0900
Message-Id: <DKBZLF7RMQE8.2KQJKLGIE0X6N@nvidia.com>
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
Subject: Re: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Lyude Paul" <lyude@redhat.com>
Content-Transfer-Encoding: quoted-printable
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
 <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com> <amsVU-1o_zNOIOts@google.com>
In-Reply-To: <amsVU-1o_zNOIOts@google.com>
X-ClientProxiedBy: OS7PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:604:251::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc004f9-390b-4e2e-799d-08deee4998d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|23010399003|5023799004|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jLfILEzj2qBzdppgXFVm/tCyQxFESGfGfmZ0dW8laGyzrQcgNLaPhsq+mS7MoM2ABLW11Xzg0vYbIx1xhsxsay14xuFcvHjXk2+tJJ17imoDSuLOUpH9nE/wYBP17KSROKUEqSvbxzdlHn5qJWfCSD/qY4wQ4dWvCZcv4cQL+XSGBQIouZtYa6ejkwtLZmFnSksS5fUfHVlyioguzzcQGxSRgpM2k6nsMqdVM3F6ilQRsIk00y9JQz2NINaH1F/m1Fv4RpOFzQxrEpuFijihkYbM1W92beSXEgEAK7hDWvQf74CRUM1QkaW8Ml8HQH48fNf7qMEWePAhzotgnHeX4cIxZgs2xtr+KSxIx6iruYXibayEHIJJD3OBb49+4fxponIzDp83R776MIb1jjJNRarIf9naohm+hG9/i4+V98Ri5serVBgxc4ABiqXqRzxfMxcyK+otUAftKaEFvPFLqNKM+p5uABXa9NA1rB3yk7uF2+YQ25sa85dyTmqp/mzAIq+OeswfS3RqRxnbx5o/Nvtk9f03Ikis2i5U8gL7+4MhPigfJXWIxyD7qQcL3H113SGXQ5SsLCz3bTV7GkUYRA1GN9tTYJCu7//lbkv4jyKRlJG9nz3L+/fyTibfwjVnOLinkwz7WzrqxVS1F9M/sIfCUw8dqBC5YjDjxRYyXJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(23010399003)(5023799004)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEI1RkJWd2xtTnV1OGxTQnBTZjhwMG9aU2ZCdzFRRmg0Uk5LZ0tCNURkdjhr?=
 =?utf-8?B?UUp0aERvRGg5VHFNekl0cFA1TFNDem8yVlpiTHRTaTNxblEyVUF1S2FKdWIy?=
 =?utf-8?B?WlFBMTNDV0FmbzFBdCtPV21OTkVyeTdUK2NRZDhoaldrMTM5QVg0Y0dTd2hB?=
 =?utf-8?B?TExBWFExSUkvOU4zdzBIMk90ZEtsNW5Wc1NrbXhwdlliQ0hjWW9BVkpNOGh0?=
 =?utf-8?B?Z0gwR1BPRkZhRlM4ajBDbFBXVHFuTFhoamR0SlhBTWsrbmZDcnV3WkszQmpn?=
 =?utf-8?B?cnhIU1lWQXI5S2FKc2NFY0VCL0dDMHNBNEZjZ3BWZ3NvYk42WUJnZDlMSkZ1?=
 =?utf-8?B?OVM0eEoySnJTM1g1MmRBMk00cG8xRm5SZXFzTzlQcENrTGJXdmcraGZHVDBq?=
 =?utf-8?B?dDhDZTM1a0R4YlJ5WWpwdmFNNzVPOE5kWFMreU10bG93Ryt0U3haQTAydjJk?=
 =?utf-8?B?VWJCRXFZU2RCVjdQcEFwZjJNYThLMXlGUHRISkNWaEdLRzFaT0JRT2pua0sy?=
 =?utf-8?B?a2hHMTlyZm9vallaN0ZDZ2ZLNGI3dkpuTnFlLzROcFBJdWhUeHpPb2htK0hB?=
 =?utf-8?B?NDJSMFlCZnMwVXo4OXZTbEpxNzNGNmxlajBDZG9obHdRblVBNjM5dVFxUmV0?=
 =?utf-8?B?cTBHd1NLeGV2K0l1OUdwR29Uc0xUaTJ2UE1YaU81M2ROVEFPeDN6T2VCam9j?=
 =?utf-8?B?OVJVVi9ML3huS1ZRSHJVSTkyU2xrZkhsdE9GdXp5bGVreWdIcG91VkgyS0Va?=
 =?utf-8?B?QUUxWDNTeFZZQUIyZUdMUUt4UWlrTUgrdEQ5M05iUEliY0lXZjhSZlVwV2FH?=
 =?utf-8?B?Ry9FQzJNL3dCQXJrVFlqS042WktaMWRXY1VEQmRac2lsZXB3cU5QME5FRDd3?=
 =?utf-8?B?UnREZ21mOFoyRHJ0bVA1MVR1V0UzMHF3RG1OM3V1enBDSi9kbnNLUlZDK2NG?=
 =?utf-8?B?WTdlQjd6RWtZZmwrNFFrWHlTZENmYkFYekZEb2hlaVVsbVZrbUFCc0hHNEZs?=
 =?utf-8?B?K0t4TzQyWWFwOEFVWUlEV1VVK2p1SEM0cVJKTm1yRndEMUNqNVNUTVlWa01Q?=
 =?utf-8?B?cEE4RXJGZ1hWSnp5eTd5Y2tVSEJ4dkZlVHhtaWhTYlNoUGZrQ3hqRk1jWmpM?=
 =?utf-8?B?SlYxRVVSdmVkd1NGclZ1VThpdjNWdVp5cTYvZmt0STg0blV5WjVWVFlXSU5I?=
 =?utf-8?B?NFJoalBRUXlGQzdES1ZFRnN2eS9sUFFFMUx2bEdpY2NzTExtUnlCZ2RaWVE4?=
 =?utf-8?B?YUZFamNxRDFIMUJGZndLZ1grbnpPdnhnTi80YmtNdlUwWS9xRStYTFBKeWhm?=
 =?utf-8?B?WUJGa1EycjZXQ212TCtyODFpVUthY1MrWFdzL1hTc25ZTnd2bFVBekFhVWhW?=
 =?utf-8?B?TGs4NUdiNlpCak5QVWRXa01iT2IycnBCVWpPVjV3MXkrTWd6REVsS3UxaU5H?=
 =?utf-8?B?a1c1OUJNaFRCOTNjdlJKa3ZjZW5TL1NYSWd3RVhZNVg1cTZydzRScy91TTQ5?=
 =?utf-8?B?SGNyOWRnalFlWTErWGhZK1BWdWhjUzNRUzlIU3BkVENudDlqT0Uvbml6Qm1V?=
 =?utf-8?B?WXBvUEVoOTMwS1U0SXg4cXpXclRnbTFZbyt4eGszRVJEQkZEcDFlb0oyOXps?=
 =?utf-8?B?NFZBYW92Q3cxaEFyclE0QTJIc0NZaFZydWxWQUNtd2h0YUw1cFZ2QVFPaExN?=
 =?utf-8?B?YWNUdExHWHhJZ00wUXYxaUcyMFp3NmxqQjhVSDJnVjlYSWwzdVFGY21SUzFu?=
 =?utf-8?B?NXJ1WWdMZVhJUnlWMmZWOGpRQUxOL1Y0cU0rMTFGMVprbHRxWXEzUW81djJz?=
 =?utf-8?B?cVQxN2VDUEhFS0JvSWxmR0NUUzZaYVZuWWNYYXF2eG15ZkVtankwMW1wbzAz?=
 =?utf-8?B?UXRPOHd0WE0xRmRIbDAzS2I4MUlzTStjYWZLRFZlbFZiMHNBVmM4SDU4di9H?=
 =?utf-8?B?OWNkN0YzdlVHaUhMNEtNS2VIOHFaYUdrOEdzUk1WS2RNa3VBQlpvKyt0Ympj?=
 =?utf-8?B?ZzVUdlcreXRFdVdwNVNLOTBTTXBNbTdkdStMUm9QdDBHbjdZL0RyRnR6WlRD?=
 =?utf-8?B?NHNXRTcyQW9DajkzWnhYa3I0OVdXL0tiZy9JVm9mNnFCOFRjRm1QdlhMS1Vu?=
 =?utf-8?B?UXFVWGd1VnB5ZmpDZjVlRnFkRlpldHFQdjl1WnVDNXg3UkRYSDdkU3RFQmEr?=
 =?utf-8?B?UkIvK0ttTkZVeERKUW15Y2VZeG4vVGlqaFpIeUdxTE1ycHQvRTBwRDE3Umlo?=
 =?utf-8?B?TTdrSGQ2cGZ3a3BmZGdTTDNnaSsxU0hDTkpIOHUxQlhGSG42TFNMUEVhTndD?=
 =?utf-8?B?c0NRVWNrWmNhdmZEMGVoRVVDdVpjbEJRc0hWV2hLcDZVQzdOOE81K2JhM3BV?=
 =?utf-8?Q?a/DbOGZAkZV4gUL8b3ExrxO0xY1N9g8PSKC4naE/HFZ5J?=
X-MS-Exchange-AntiSpam-MessageData-1: RQ1hi89Fby7MQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc004f9-390b-4e2e-799d-08deee4998d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:48:19.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPyEng9frUZD9xWgzqV1u448/IkNBQ4GFxK61xot6gLqpsSXkHGGoLR25s3qTjpcoNTrklKslNUXyw0guZs5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144

On Thu Jul 30, 2026 at 6:11 PM JST, Alice Ryhl wrote:
> On Wed, Jul 29, 2026 at 11:05:55PM +0900, Alexandre Courbot wrote:
>> On Wed Jul 22, 2026 at 6:16 PM JST, Alice Ryhl wrote:
>> > +    where
>> > +        B: lock::Backend,
>> > +        F: FnOnce() -> Result<T, E>,
>> > +    {
>> > +        if let Some(value) =3D self.as_ref() {
>> > +            return Ok(value);
>> > +        }
>> > +
>> > +        let mut to_insert =3D f()?;
>>=20
>> This means that `f` can run more than once for a given `SetOnce`, which
>> can lead to problems depending on `f`'s' side-effects.
>>=20
>> In the GEM shmem case, we would create a second `SGTableMap`, and since
>> `SGTableMap` assumes it is the sole owner, the last instance to drop
>> would create a use-after-free.
>>=20
>> Now this sounds more like a problem with `SGTableMap`, but if we cannot
>> avoid calling `f` at least twice then I think it would help if this was
>> documented.
>
> Hmm ... this is the behavior I want in Binder. Actually creating the
> value is an allocation, but my lock is a spinlock so I cannot invoke f()
> under the lock. This means that each caller will make their own
> allocation, and then we throw away any extras if there are concurrent
> callers.
>
> If GEM shmem wants f() invoked under the lock, then that's just a
> different operation than the one Binder wants.
>
> Do you think we should add both?

Possibly... but this would introduce a potential footgun that sleeps
while holding a spinlock, unless we limit the run-f-under-lock version
to work only with mutexes.

Maybe the proper solution is to fix `SGTableMap` so it supports multiple
instantiations. It is, after all, a bit footgunny on its own.

In any case, the current versions should warn users about the fact that
`f` can be called more than once imho.
