Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96103C7E17;
	Mon, 27 Apr 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296602; cv=fail; b=e4Cl7bn0eQJm5I42OjzBuq+CawkRZWRCoyWLpyVHAjdny4LzJ7tL92V3TdaC8F1iFneLMHvOtCa1EEgqETQJmxqEzYWZTpt4AyJ2VEKveCEqJ0OGLPj7JVS3GrLlbBwW1gZNlzfyl9reuGrubj/ZyuPBQ+gcS8cghZeB6LFFGMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296602; c=relaxed/simple;
	bh=A3bRJQhtO+5DTrNwsWGKdzLhDqP830dGmmto4lcUQoI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RwsBHfeGWeU9sdm6CqIB+GabTM3JitnJTu7zhEde4GESYlSUENecMtlHlA9KFxKMJQ4sGx5zMzykrvpxJ295tADifvRG6bBjQpznMEtxj2eVAKNhgnq/i3gQk8uPb8KAt/1NWyuQPpK3ybbvIGiuu4CyDtuKiekz6wEBqaCVTGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=n3HHlCbT; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="n3HHlCbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV4VWpGb+41lJ/FnXxZcfy7SEgc78/UyQyOk0WHkGbZRwJr6/C4GZyBGXoNyBiGYzguT5WXW0mhNWgDHeo4w7kbwk5+/SA5exDDrZOU4ack6kvD2rAyI0De2PltSdTyEujLzPUcfem1aqWHuzmnNA7VHh6xZeQ8jLxmXif085vTjdE5AO1m4FnUmJv8ga43turTgiSjgsP0PwDerO1n2aLKi9f9iDPjs49QwrB0tI8RcFNjz3kyKI9rE9CX2Ox0/ICni2HLRPJN6I5swR+jFxTk6PjBAiLicnJDN+C0IESDxy9EmU3/G5J5Q0B1z2/XJacjuEGzzLdZn5WE8aky/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5aMnw16kRZJmZSBiObovUG/8QP2+23ctzobvVKlEJE=;
 b=ZxKBqkDYY5dhHDkGKqlEpq5IRUh9bpxHrCq4kSuY5+MKT49u9eu/c9uN+HMHfpLU5RAsBxZaS3y5+aBzi2UyHXSouE3cEw5xnUKHDT7wnl/mpZjODriW10cfJSD1FVszJzzi5WOy7U/wU58AEIGVWjCDuktFsIY5W8dDBwpBrSFV9nms9nFX20IpOKn154VXCOjsyBKs4BuiNN+cr4g5azuNbreVRu8X/ECBlzHJpuh8xX0ISsB3cna010rqjt7Bcf1QoL1ls038Oaa36d6H1cNKu0Lln6UCoZn2dHh5Rwd33IO8//BhiE6UvRLt3infY6LnalytE6pwf3CiztO4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5aMnw16kRZJmZSBiObovUG/8QP2+23ctzobvVKlEJE=;
 b=n3HHlCbT6Az0Cc0xwBNq96dF5e428Zj9qjTDMvkGoKd8JgT1QMvd5rMRdVMLdYFIQm/sMWvkn4uWLqlfGoFfKfP6GbXj0lQBrt54IXs7+6ZRYHdD9QXFCm3RKlva5noHMx5Vm1DKWqzOH7ZVmeUykuI3wJhZ94ECcM2ynkXvfzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6729.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:29:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:29:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:29:55 +0100
Message-Id: <DI3Z28IZZOT9.349TTWNN9VDMB@garyguo.net>
Cc: "Rahul Bukte" <rahul.bukte@sony.com>, <linux-kernel@vger.kernel.org>,
 <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, "Daniel Palmer" <daniel.palmer@sony.com>, "Tim
 Bird" <tim.bird@sony.com>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] kernel: param: initialize module_kset before
 do_initcalls()
From: "Gary Guo" <gary@garyguo.net>
To: "Shashank Balaji" <shashank.mahadasyam@sony.com>, "Suzuki K Poulose"
 <suzuki.poulose@arm.com>, "James Clark" <james.clark@linaro.org>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Richard
 Cochran" <richardcochran@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Mike Leach" <mike.leach@arm.com>, "Leo Yan"
 <leo.yan@arm.com>
X-Mailer: aerc 0.21.0
References: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
 <20260427-acpi_mod_name-v4-1-22b42240c9bf@sony.com>
In-Reply-To: <20260427-acpi_mod_name-v4-1-22b42240c9bf@sony.com>
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff95767-0092-4642-9573-08dea46112e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	SDyiiBD3iEfz7RCjysXc+dutLjjGs08VaCUPh/TaJDgxyNq4i+gIKSxHicTwWJYU03yrPAA1js8S3rRIEHuargJZBN9f67pNSHNjll4UABdnEKcmVVdV9NMwdI4Oj9aJhcIwL/INdUILSNRaF3vs2xUrvLRKChJ6j+m1jT9pcMrmOysjCi3hG0/+6geNg6DGsRWIp3JX4BUD4CwG+VUfLL/ATbCjtD4sfHAbETB6am+uCbrGaTTYwA8+3LPzZZ0XbwJjFBq+T8uIllaf4JJvIz4x+Y0O9pLydismd5x+pzRmH4TxSbXIOMRScpnYY40xqKBZKnsI0nWwDmancywxyrp9Dma9yg3jKATl03UhmLWOBy+ia3LJ1pSst/nO3XpohLIrDIi2L0pXafs87vMyrZeOq9AzgO7vBcYZVRHkOL6E2pxqfJXqw29LKhwCXya9axGuxM+oXO+JZFLdL9mEyr/xhFgPTrsB0OQKEn0xcA2x5Pk0wMgNaTomeHT+sbsyzDF3QCVIlcdMJLWtZZTyAWpEHj6C2/30ungmk2h0uo6UmB+8UiR2m0YQR7T9R6dwjaZi3gcvBdJE24sDj/JU+WPNyliQU78kTDi8buHjK63H/85jPgLSlFVahFu7IRd4VrxHzarRpyTb8wg70nfpDhaYZmqMP1iwIpVwsc4K9gwCkQKNmCzIxpl/nDMNiaE5Ly7jI2LYq9RttoMnHnaHM0XcQR1crSuD9W+UVj4FNxZEvB0Dc0RU9m4dvjZocPlL55BkdJmjWkL7HmH9MeuJFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS9RQUpHUmF4aHpyM2NTWHlubDMvVWJIZGZvMXV4RDFON2lTS0ZtYWpLVW5m?=
 =?utf-8?B?ZHBCMW91TmZlMnU1WVdjTlNYS2ZzSXQ3RDREQ2dlWlN5YnFUK1RscERSclor?=
 =?utf-8?B?NEZieEFaSzN3ZDBtOWRIUTgwMUVMYVJjTDVVbjIxNlI2eHF5UFhpODdOdWQz?=
 =?utf-8?B?NFJEbWp3YktpMDlwTHNEMjlZMDJwU1RYN21INmx6V3JLL3FkR3QzUld3WXM5?=
 =?utf-8?B?ZmpqT0NnQ0NUcHA0a1RYNFczeDF1Y01kRWhUY0FpazdNWGVoLy9ybHJGd0h3?=
 =?utf-8?B?eEZNa1lPQmRENDJxbzBMZkJqZE9TQkdGTitoWVVkVEJ5cEFwU1RwRmV6Y2Zu?=
 =?utf-8?B?THBKVVpVZmVBOHo5RXpHbG9SalZsR1NKRlZtRHd1Q3FuWEFiMWZrRSt0Z2xX?=
 =?utf-8?B?NUVuRXgyVGF3TzVOUTE0TmtBYVJUcTVyeldDRnY2Y0V4NEtUeDA1cU03YlI3?=
 =?utf-8?B?cS93M1I5c2pSVGJqMVNVSnJsU3UrWE14dXR3VVhqU3lTMXAzVU04R2piTWJB?=
 =?utf-8?B?bHdkeDEzbHhvZnlaOXRmbzU0amd6RnhCNC9CTlBuR21CaHdlSThlQW15bkR2?=
 =?utf-8?B?S2gycEx6bXJ0MjJKRmV6eFdOSTVBMTN4VFVXSEdJSEtVZDQ0dnY5SXRrOVJN?=
 =?utf-8?B?ZGwyeWw3ZWQ0WE9nMGd5QlFkZ0ZwaHEzY2JBbWNMOTI5UHQwK3o5YnJhK1NV?=
 =?utf-8?B?c2FDQ3lzWjMrcGNtQjVEVlRxVzltWXVkMy9YVG1TdXV3bnN0Wi9zT0g3dVJ4?=
 =?utf-8?B?UG84RmpQcWJUanBkNVBTTFFobzRFSDcwSXl2VGpwK0h4RzM1NHBPVk92cW45?=
 =?utf-8?B?dVZyczF4dTJ4dEgvRmdPKzRrTmtuczhPNWZSV1dPUlRscVI3VkJrbW1CaG5l?=
 =?utf-8?B?Nkx4TFViMFQ2YkxaNjA2dnJZV3lLR3hSWE01SHZueWlUZ09kenZxZGJvMDB0?=
 =?utf-8?B?RXA1WkdTMnFUT3RQME1POTZBK2d3M3RxL3I4U1U3N1ZCaHUxTjF0YTF1Slp0?=
 =?utf-8?B?QVNFV004UldseDZ0ekRBV1YySVlxYzNSZXJCQlpLMmVkUEdtVjRpY25HNW5T?=
 =?utf-8?B?b05rTnRYNU95S0VJSGlWWXhSSmtyek1lL1RnSjNjblN3QkJyRWpIeHJQZkt2?=
 =?utf-8?B?em43OHJYTGtQMjFSMVN0UDVZNko2VzN1S3ZlQkYxYnZnVnBtREFJWmt4a1NL?=
 =?utf-8?B?cVY3OVJjSzlNNDJpK3FiWk1PRWJTSEdDTGVxUmk4NFQrNFZYeGhMN3czUDdU?=
 =?utf-8?B?cDN3dFNvRWdDWm9PRmxmTTRaczNTZjV4bDRoVkIvVmtzcWRUS0I3cElpd3Q4?=
 =?utf-8?B?MS9UdFJoWi80R0J0YUNqSWNrT3BmQmVseFRVVE5BemxxOVl1S1l2MEpQVWpI?=
 =?utf-8?B?UXFLZXFxSnlnakpRY1VXQ2dhUzJjbmxmMmFnbUhLVXh6aC9aUlpCWjd4U3hO?=
 =?utf-8?B?WWRxTDhlNWlKRGFNTklvRVRzUjdaT0QrK0hOVFBTcVE0T1FMcTBudU5kaHZL?=
 =?utf-8?B?eHQzWmM0eHBEeXR4ZVJVK01CKzZ1Q3Uwc2VReUY3aldiRGs4cFZHRVdPMjBq?=
 =?utf-8?B?aXZieGllT0Q2SHNLOHllT3lwdmhPajR6bi9YNmY1U0VOSnNyb0c4dHJpemZa?=
 =?utf-8?B?MmVDREhlMkszT3gzREhFYWFmTnZtOVh2QTkyeXVQeFZzcGFWbGl6THZFdXVW?=
 =?utf-8?B?dmVqd2FLc3A5RjZrcUx3bnNZWFdxS2ZHamwxeUVTTGxFbzFyQzc2OHpsYmVF?=
 =?utf-8?B?SVM0bkR0b0hLSDlPaitaeTZPRWZlZStlSit6TGZpMUUycEtzcnhYY2ZUc05o?=
 =?utf-8?B?ZkdvR3NPTFJ0NTVKRlBvUkFlai8yUUJWUGxFNkJqWGM1c0Z2cEtibEQrOEZR?=
 =?utf-8?B?Q3ZjNmhaaWtZNmxLQUlSbFp6TW45b01QOTk3V2xhelRKTm9WS1FOdmJzazJp?=
 =?utf-8?B?US94SUw3UUdLZzVPT09FZGxxV3o2TDdLYlgzL3YvRzRpdWhUS1VzMXVOUGxi?=
 =?utf-8?B?WCtjNUFwclZMTlpoQVl3bFJnR1Rsb2lHRzBCcFJhdVJJSnh6azFRSGlaRjJ0?=
 =?utf-8?B?Y3JlU3JuMkZEOEFqRUgydVpuNGU5OENQeXBQcVBOM0h4NHlDVERnc1ErYU44?=
 =?utf-8?B?c0dmQXY1NmVOR0crWlVWb0VyMGI2UkRNclBpYlljN3hKQmNTeFVaeGFzZjVD?=
 =?utf-8?B?RHJ3R0IvOUdQV3NHU0tSSWpwaWVPK3BaUmp5SERDeFN2ZERnUHVaUzEweDJH?=
 =?utf-8?B?ZTlrZC9mZWo5Tkxla1pJSis1aVBNR3ZUR1U1UnphcTRBODdPd0JINFNodG1Q?=
 =?utf-8?B?RUxSYlhRVmxwdnNRUHBWYldLU2dtOFcyM3ozRVdiRGRqTStxNEI1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff95767-0092-4642-9573-08dea46112e5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:29:56.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrB/2WBkxTsifVL3k4mOyUHrDSoc5SyBx0tmULNhTqFeOpD07J423egJ1TVkc49r8/aMzPsUxfdmNbSfzf9NKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6729

On Mon Apr 27, 2026 at 3:41 AM BST, Shashank Balaji wrote:
> module_kset is initialized in param_sysfs_init(), a subsys_initcall. A nu=
mber
> of platform drivers register themselves prior to subsys_initcalls
> (tegra194_cbb_driver registers in a pure_initcall, for example). With an
> upcoming patch ("driver core: platform: set mod_name in driver registrati=
on")
> that sets their mod_name in struct device_driver, lookup_or_create_module=
_kobject()
> will be called for those drivers, which calls kset_find_obj(module_kset, =
mod_name).
> This causes a null deref because module_kset isn't alive yet.
>
> Fix this by initializing module_kset in do_basic_setup() before do_initca=
lls().
> Modernize the pr_warn while we're at it.
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Gary Guo <gary@garyguo.net>

I didn't suggest this change :)

I suggested `pure_initcall`, which is just a one line change.

diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..ac088d4b09a9 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -957,7 +957,7 @@ static int __init param_sysfs_init(void)
=20
 	return 0;
 }
-subsys_initcall(param_sysfs_init);
+pure_initcall(param_sysfs_init);
=20
 /*
  * param_sysfs_builtin_init - add sysfs version and parameter

pure_initcall is level 0 so it happens before all other init calls. Does it=
 not
work?

Best,
Gary

> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  include/linux/module.h |  4 ++++
>  init/main.c            |  1 +
>  kernel/params.c        | 21 +++++++++------------
>  3 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..6478596e8f9f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -886,6 +886,10 @@ static inline void module_for_each_mod(int(*func)(st=
ruct module *mod, void *data
>  #ifdef CONFIG_SYSFS
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> +
> +void param_sysfs_init(void);
> +#else
> +static inline void param_sysfs_init(void) {}
>  #endif /* CONFIG_SYSFS */
> =20
>  #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol=
:" #x)
> diff --git a/init/main.c b/init/main.c
> index 96f93bb06c49..01552c6b62ff 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1486,6 +1486,7 @@ static void __init do_basic_setup(void)
>  	ksysfs_init();
>  	driver_init();
>  	init_irq_proc();
> +	param_sysfs_init();
>  	do_ctors();
>  	do_initcalls();
>  }
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..d1e3934fb3a7 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -942,22 +942,19 @@ const struct kobj_type module_ktype =3D {
>  /*
>   * param_sysfs_init - create "module" kset
>   *
> - * This must be done before the initramfs is unpacked and
> - * request_module() thus becomes possible, because otherwise the
> - * module load would fail in mod_sysfs_init.
> + * Must run before:
> + * - do_initcalls(): some drivers register during initcalls and rely on
> + *   module_kset existing for their sysfs module symlink.
> + * - rootfs_initcall (initramfs unpack): request_module() becomes possib=
le.
> + *   But if module_kset is null, module load would fail in mod_sysfs_ini=
t(),
> + *   causing request_module() to fail.
>   */
> -static int __init param_sysfs_init(void)
> +void __init param_sysfs_init(void)
>  {
>  	module_kset =3D kset_create_and_add("module", &module_uevent_ops, NULL)=
;
> -	if (!module_kset) {
> -		printk(KERN_WARNING "%s (%d): error creating kset\n",
> -			__FILE__, __LINE__);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> +	if (!module_kset)
> +		pr_warn("Error creating module kset\n");
>  }
> -subsys_initcall(param_sysfs_init);
> =20
>  /*
>   * param_sysfs_builtin_init - add sysfs version and parameter

