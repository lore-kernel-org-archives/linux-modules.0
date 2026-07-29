Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB48D899;
	Wed, 29 Jul 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333967; cv=fail; b=BN1DiQYxA8XVX6G30o6lMuiCCZ3/vhOZGxdF12ZJ+kqTkCJzk9877IS4wGPs5fb3ut+TyEJEYoUQohQxr6ubVICM2tHoPFYko6NeoG7DNWFBg3mCUhBOSl3/+g1D7zcPVq5cb9JaJnrj3tqOPj+GA+2/SW/rLkPft0OucUP5QZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333967; c=relaxed/simple;
	bh=o/gqhak8kx9Fti6cgjDaiwkfANe6c9+61ew3uzjYY80=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=siLsGd+2WNrKP45XUg3iza8R9zRIgiCylj4ksr2UrBMF0+GBhCyQPKIrnnfWwOACo+LqHusk+I4T1JOZgSw+8APt0eF0QXA5+yiLBL5/KHU70XSrexJwRf4Quobci24iAz+T7YKz4pRU1F4qjnhvOUmxcjoaeDld1CToztttX8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKYlWmeE; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKYlWmeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw2VBLZ5c7hdqLIh8btU6v1XsKCdVVzShYngho1QkegMY1ZVbT9bXdIvo9dmlJUSO+EYQvKssyxuRzMr0Cy/J28Ar8fxeC4UxQPMObeX4nL4UgOGkesZhQjWugnlITja1iv4nG2DCW5isjKf3MPxNDeu+m/oYmCHJUjX0tcHMJIxkBONNRvM6+LYjs+aj/ipZ+CTAHxFzOT63GE1im1MTrgr0YL1JuQB/CHBMjE0fJVDH3dtpZbvCVgqJ3sf6fLVwyHrr47bD0FI3n1G67RyrTGRqVkkmTpHINU+RZHAsHbYMbptX1l04gfj4ffP8yodhvwc3UsVHHK1VtqtQf2Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCBLZpViAM7UInKqUQSIF6oxKxvGtGHCvOE7+FAa4Cw=;
 b=NWvXgK3Z8+YT2ASn/iAX/ODBVnlpZJrLmhnyBehYJvsE9KPPSJMveXOoXeNmWaiKAvUbtWobFsgEk+tb2JxJkyVdbijIWGxHg9PGf4bbVpOCiflakPmPRpZneDmnKgyQXl0Qkvc5qIswSWgmu2BrBegIBlfDlOO8WnsNaZSskqdPIpr7LEWulOX7GLYC3bXEgCmp4DDWCT2MWj6FumI7P4oya+DVHMTk8PkyXfy4Io96s/mSCpvd6ReFCFEAJHqY6XWChTcbMRIbybYC1Bj7w/32H4ME+eLVqJxAC4pHmJg3oDTsBj5Dr2051R9P0kZYxZJsSEUVfA6LLTjvETD0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCBLZpViAM7UInKqUQSIF6oxKxvGtGHCvOE7+FAa4Cw=;
 b=bKYlWmeEHsxFKa2L6d6TcmqtcmTGC2b9Gd1fSeNyFJoRawyKB2Oky0i+gM48O4sNg8mU1q9rzT/JYaEIfW956r2srbpPDjX6ldpPyMKGIyr/T4vnI/aQwZbIMtUTHg2Sf/iMHMzh9FhA9woiDyaYA7g4pNsDpRkx93RYf/GihnTSKw69RYm48JXoJp6nPcd87QGjc9tfVWeMjbOkM8rr8wT0X/FOHRjhGpFrdli6eFEDg4IYhlQsC8tEXCM3gz8oFgAaEz3WO3cGLLomqVZDKhgWFsCfoLpXYDUMJERw7kMyNiMRrVDK3UC8cSdOVTqbeuiy7hHR8z8+EecW2RhYFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 14:05:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 14:05:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 23:05:55 +0900
Message-Id: <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com>
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
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
In-Reply-To: <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fb02e7-0b74-4439-5a01-08deed7a838b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|10070799003|1800799024|56012099006|4143699003|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iPYTSIBchss1Uabm1GwJ1M+Lk7lTuySOUkV10zyG8IALac6p23f8OEhC8sNdHS59QykoEXJoEtNT+23PBTp3ZN/TXoki5G1G1JahsFQUfZQ91diU+bywK+Nsz96HXVAJJLa7d0v1zIWmsTdmKPTYySHq3VZ9GOg/NbJt0L9DSeaoGSFiK1YDnr3dy6tGyC6/h8KaYQG6AHqHjuHq5KiXh685kzeuiPdD+G78R6eMPXVSWq/An0BYgC21s+qj1Y5288lcDncSgWCvlQ9nScfzFEqTwGpY7zKeX7oXmQRHszZIYET3elGltqb5n9yzF72obyOl3zT8l+ryIG1A3NlXYA+91Qbv5YXc43CdZ0zbqNOtXsONiWSsZ02D9mxuRUXPo1o1ke3YY7lsceV8NYY+9pSz8cgCPX7OtD1i3YoZQS2/C1KynWqRmweJFAzei5Vky3ENGsFznhUbMQOPRdtB+ykmVxMhaJez2TvarHQ5UxRwdjVggu8+x3T2QcnjWJ7jvoGTE5+d2XHr0svqqHPrm1onkP7ovwvMsuQCUJbS8UcorTP5bN2AwtNidzQiyqiUCfuPSo9ytjJI7jy/WRQc24vCOxhO8RYHPfp40esJ2cduMSmTsDF/lycT3I1y4wmH8Xb+fqgveCPslxaNvyN0JIuasrju9mV7vIUVnrtrdLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(10070799003)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUM5RE15bFVFbEJDcDByTzUvL2tabks3RndZNHJRTzZac0RrV3RnS2hRTXVF?=
 =?utf-8?B?TnM1blZGd3pZdFVwVkRSRjZIcWNVZkMwc0N6ai80dnlUUUlxMUlPZ291dVMz?=
 =?utf-8?B?Vk11cTFQc3BDRXA2UUZiTXoxalVhZjB3cHhnRVJPTlFva1EwNW1lcVovV1Zi?=
 =?utf-8?B?T2VHLzIvZ2hKT2lnOGJWa3dnLzZUMGFDczhZYytLL2VYa2RGYUY4MFFoa3li?=
 =?utf-8?B?TVJ0MkVUUGdmcmJSTjliUTVkQ1VhS3RMRnliY2ZZYlJiVzRLaGQ1Z1NRR2Rt?=
 =?utf-8?B?R3dyOW4zRGliSUNNSEVTNklpWFhZVllFTnlMSE80ZGU1eDVmWnMzQU1nSXVn?=
 =?utf-8?B?blg3M1A3SUl0QlNRbEp6SXF2Rnc5NFI5SHlFdGduNTF6YjNZQ1lHazJZUHRI?=
 =?utf-8?B?YklNRXNDeTNGTHYvNng3b0JzU0tjSFI3R1ZsdDJGT29QYy9CY1VjS3BFdjlJ?=
 =?utf-8?B?OEhCMVlUWFh6MmNUSmhxeDFZTWdRUkppR3NpeXF6Rm1jRDc3MGFQMWgzWlR6?=
 =?utf-8?B?MW5kaWRaY0lrWTRubFlaSXl2cUZJdTB4di84Z0N0SitlMFowVHUvRGFNRUFD?=
 =?utf-8?B?d0oyS0FSbFBQVjRCYzc5TjVISGk5Vmk2WFJ5cjdJQ29xZmdaTko2ZWNHTXhZ?=
 =?utf-8?B?cXh2WUJXaTJTKzZJMXBRbXVEQzRXMVZrRktDWDR0am8rcW1vNUx6OFJ2RG9V?=
 =?utf-8?B?di9NZDYxK0R5NUdQZ255SVRmVk1HVG5XbzVIZjhPQWdyR1BMUWcvV25ZTTZV?=
 =?utf-8?B?K1VmQTJ2eFg4bUtCWndJSGd6MTZLZjNWeTNmWitzTXNXWDNvRWl0T1o2OVpo?=
 =?utf-8?B?Ri9qRjgrQlIvZWFobS96OHJOTFBkeERrYU5MUit3OWxGMUZESElpK2prckgw?=
 =?utf-8?B?QlVvT0F6QVhxdlVYbjhuWmthQVJQaCsrY2pxQXFSRDNpRC9IL1Jnd1NuaWFq?=
 =?utf-8?B?eHJVRmRCWjlNbDRuVFI5MFF0cjFEN2F4SjJ2MkxsMGVKYVRPdmNHUlU5aFd6?=
 =?utf-8?B?RVBINVFINWJ1eXcwSVhBUCtEYTc0VEU3cmtpS0xrYUpJOUU1bFgyRjNCaGNK?=
 =?utf-8?B?OXgvSGh5WXNYWVhzQi81cnRHVE11d2gvS053Sm5KRHIyYThBM0VCWjMxbkRW?=
 =?utf-8?B?WUwxWTMvVEtwdmpnYTlTeHFKZGJTZ2RtcUJ4VVMzdVhlbWJwWkNsR2VObzBZ?=
 =?utf-8?B?YWtLU29Hb0FPTjZNazNqY3gxbldTdDdMRjIyQ0RKcTBzYkU5cHgyV0NzT1cy?=
 =?utf-8?B?aGdyM1ZDQUdUOEdsd3RudlU2UE9ZV0loa1hHVDM0N1Q1M2F5blNURDJXVlZm?=
 =?utf-8?B?TVFKZ0tiTFZxMEEra3ZuMENBbVdVbG5jNThINGZ2RkdjRVFmWlF1QWpqUGdh?=
 =?utf-8?B?bTNyU2dudUlFYmV4bFJsOW5ESGZNRVU5b0ZGaDVRbGJ5SjdTSHAza1JDd3Ew?=
 =?utf-8?B?M0ZXVk4vV083cVo1VEpNQlcwbWpQa0VkSVNyQ1VrejFaOFpLR0tnK1dwWmxq?=
 =?utf-8?B?aWpteFdRUnJxU0VqUnBxM0RIam4raWo0N3o3SnVQRHRDbVlRbUZZcExOR0s3?=
 =?utf-8?B?a1U5SW43NWlQRTFsdmFXbTNzcUowbXNuQzM0ZEtRdXd6bXMwelhlb216cmhz?=
 =?utf-8?B?dy9RYm02YlRPSmhIc0xvZDNVZE9JQ1d3U3BMa3NwZVhZRkxXUjV3YkowUkdG?=
 =?utf-8?B?emh3SVp3M0JPcnJsb1ErMVVjWWNNYjEvaEdiM25SVnF0eURPS0RVU2d4ZWor?=
 =?utf-8?B?THQ2TFBpNVkzSXgvS3djaEZXNjM4dE8wcTV5eFJJYm16TmhEK1RsdzZ5OWE4?=
 =?utf-8?B?bTFoOEZ5bGdlbnBuNlBhWEhudkZsZVFGTDNEZGxScWI1VzdwRkZtRzhkeWxj?=
 =?utf-8?B?eDNUUThnQUh5WkhueXBpNTZaR2YrRTVwbTZwdzY2RjlJS1ZuNnZDU044N25I?=
 =?utf-8?B?ZDZtTmxOc2FGMmZoMHhXcUVabndadVVVSjI0NUZ1aFNGSkU5YlNBQnlyUzM0?=
 =?utf-8?B?a29FZFoxQkNwaEpaT05GWEdxMDRBeGpZL0FoVVAvMHNHQ1IrQ1FOY1JmL2hV?=
 =?utf-8?B?U3F3WGVjbmpBeVZQdVRxZGhuMVptRW9uT3RQSVZiYnYwNFkwOFUvSDZ5YzFi?=
 =?utf-8?B?bnZ1MmJYb0ZicXE3VTRkSS9BRUwxTzdnSkhqTTJjNVBrT1BDaFdLTXBpMGNu?=
 =?utf-8?B?enJFQTF4dkpuaVNZY3Y1TTF6aDNpQ1Y5OVdrNmIwNEVSeVhqUFRhQUtnM2RC?=
 =?utf-8?B?WUU1SjNiQkFCUS93dFpvc1ZCblQrR2VtemRrVGxGVU9SNkI3UnRLenF4dEln?=
 =?utf-8?B?NHdxMGlMbi91WUgyRkw4K2QrdHl1NzdKNG9jM281WE11cmJrbngxTXV5QVZq?=
 =?utf-8?Q?DDbDn6KzJUfZnWyczUeIB0hMGVG9d0NiAU2DjquNQlOgk?=
X-MS-Exchange-AntiSpam-MessageData-1: vDi+ROoZAWisHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb02e7-0b74-4439-5a01-08deed7a838b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:05:58.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77fmE1Cz9N76D/kvlKRJvrR8phDxVJMBMQxbKcIAjAXYadtL1GrJY8yatUXV7uzwZJWOURFgSqTaTm/YE+mUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

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
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/set_once.rs | 43 ++++++++++++++++++++++++++++++++++++++=
+----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
> index a78f8c8e87db..d9cc598a8d78 100644
> --- a/rust/kernel/sync/set_once.rs
> +++ b/rust/kernel/sync/set_once.rs
> @@ -2,11 +2,18 @@
> =20
>  //! A container that can be initialized at most once.
> =20
> -use super::atomic::{
> -    ordering::{Acquire, Relaxed, Release},
> -    Atomic,
> -};
>  use core::{cell::UnsafeCell, mem::MaybeUninit};
> +use kernel::sync::{
> +    atomic::{
> +        ordering::{
> +            Acquire,
> +            Relaxed,
> +            Release, //
> +        },
> +        Atomic, //
> +    },
> +    lock, //
> +};
> =20
>  /// A container that can be populated at most once. Thread safe.
>  ///
> @@ -104,6 +111,34 @@ pub fn populate(&self, value: T) -> Result<&T, T> {
>          }
>      }
> =20
> +    /// Get the value, or populate it if it's missing.
> +    ///
> +    /// This method is useful to avoid spinning on the internal atomic s=
tate. If all writers call
> +    /// this method with the same lock, then they are synchronized with =
each other and it's
> +    /// guaranteed that no caller will attempt to invoke [`SetOnce::popu=
late`] more than once.
> +    pub fn try_get_or_populate<F, E, U, B>(&self, lock: &lock::Lock<U, B=
>, f: F) -> Result<&T, E>

From the API perspective, this still leaves the option of calling the
method concurrently with different locks. What happens in this case?

> +    where
> +        B: lock::Backend,
> +        F: FnOnce() -> Result<T, E>,
> +    {
> +        if let Some(value) =3D self.as_ref() {
> +            return Ok(value);
> +        }
> +
> +        let mut to_insert =3D f()?;

This means that `f` can run more than once for a given `SetOnce`, which
can lead to problems depending on `f`'s' side-effects.

In the GEM shmem case, we would create a second `SGTableMap`, and since
`SGTableMap` assumes it is the sole owner, the last instance to drop
would create a use-after-free.

Now this sounds more like a problem with `SGTableMap`, but if we cannot
avoid calling `f` at least twice then I think it would help if this was
documented.
