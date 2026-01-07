Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4D35C1A0;
	Wed,  7 Jan 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808504; cv=fail; b=mnKdu5lXS7hNlXyG928pMy+1roZP2oSZPgAKwFBNphTDbT9JOKqo8hqYULLF57Exz26mULfw5lRdHNQEAqt/cY0nqxePSsILRbzFpJY3vWbbeyWRI7aJ8fUeE1uXpo3o4hHgLW9S/sb5B6NUGZ3XuddQmnHeuJP7MwqN6d5JbY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808504; c=relaxed/simple;
	bh=oAPvfy8MNBBp+r61Yw4bFZtMFhWYCzKqjG1CG29fVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPbyUbRjzse/qFBntyV5FJ1tVOjDJrtMGMY9Zs666MhV0RxyDeRV26aU0wk2mo24c4AvvoWs2QhoRrJIhRKA1PZhysPFbmUtZI6W/PdaDMi0/QiDl5DXYEPiTdpup4HPXIgOirffDi5HlA2UuIM2oqAsjPRr0vRwNeB7yA2m0Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=AKR+/mpZ; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="AKR+/mpZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkRGUJ3+q2ZFvfjsIo3QfrzFtWgR+kHfcwlz5p9HPWp9oeyhQYzsesxBSKOsZGSYV48UVmlKK3VEeiLwZPQY/zw5Agmc18eS8lzLL3Yvss8xmXWrGqhFkFrNZklV2jn10KMVONy2D8/WqJSB2/W07oCCcH6luvHforuKoo7OP44AOQo5rgtxV7p/+l0iYOhh2CirgflvLYpdHlJwY3iRSS9rGu8NcYyq3G4+dGoOxuRjJ1bqU12YwlqTljEoGmEPy8LauJrJEvcj6ezPRU88RyWRSFjmsO4irmjqQvdVFlaC/jYrOgYU7PiNRp7rck4/tHR9To7bNXnd1TOQAPIkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAPvfy8MNBBp+r61Yw4bFZtMFhWYCzKqjG1CG29fVP4=;
 b=jiDJo5cJZJVi+brbrTp+T+DTeRaNZ8fihXdEzIphLXN8C46/pzcR4/7NNqHK8dL8SoxSsGSTB/kHfVAqJU35zJcmWcPDWp0sTfetsB/XQcu3xUMduz8hGpm5OnDX2rLjyTfhBWySMp921F4aQqMrs0HUuBZg5KIqyNXTfLBWz4H/Jz7XdJ5mDw/nEM+A6ABSkVQnGhO1Q9oRiNQO7POSeuH/2GW9ZmcFbQMhsLb8cgwWa1NwuuIo9SOEUx8lO096l6TmDoK8RTMSd/9930T7P5FitPqPlaEHx9LpynVyt9S2Sde+sF43AEIMkFUGn32mmKl+olvxJ4x7j/FuDdm86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAPvfy8MNBBp+r61Yw4bFZtMFhWYCzKqjG1CG29fVP4=;
 b=AKR+/mpZobKAZBx3Jk46qTeflQNeemFJlPsB5QGYiCpbptsOE67HwZ9kz3RieCZ7widZbIn3OSR8BBasOWGdkIfQP5xZ9OAnCQ/1LL+okEREl257JW+ccTS8EGG0li4EBB6tp9Dvn1a0v58Jf5ZqUyyvXfdNMMzvSBPyBBFY//M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7541.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:54:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:54:56 +0000
Date: Wed, 7 Jan 2026 17:54:54 +0000
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] rust: macros: use `quote!` for `module!` macro
Message-ID: <20260107175454.6c5e91f5.gary@garyguo.net>
In-Reply-To: <CAJ-ks9nzn3wgZMaQFXFHBOEf-Fuhr61Tp7Knvu0CWOWYgOEqDw@mail.gmail.com>
References: <20260107161729.3855851-1-gary@kernel.org>
	<20260107161729.3855851-6-gary@kernel.org>
	<CAJ-ks9nzn3wgZMaQFXFHBOEf-Fuhr61Tp7Knvu0CWOWYgOEqDw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: fd361bc0-4d20-4e3a-eb0f-08de4e15de81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWpRTEtDbEtXUzUvaUJVQUdUeEQ0Vzl5RERhTkFaS0kwOWl6QWFRUXc4eEJT?=
 =?utf-8?B?dEpaMnBSTGMvTXBMWFAxQ0RZaDlNNDJkbEhaOXhJbWs1a1lnYmJFRWdWNGtO?=
 =?utf-8?B?Ni9EUitpYTRpTVNzM2FremsreWU0ekNpVlpKbG5IYWwrZGM2TkJIaGFBaU1H?=
 =?utf-8?B?RDlNQ1V1dnNNeFI3SGNtRyt6L2tWMGxSQnl4QURYdVFqMWIwcTRMRzVHV2Jo?=
 =?utf-8?B?R2xOSTZOMHZ1SnRNM2ZGSWlmUjFESXIyaTJaL1c4U25tMnczdTB6SkNwdGFJ?=
 =?utf-8?B?Nno2N0FLNllKUWk5ZUR6dTQ3TlBDSHA3SWR1d2RqNmNCSmdma2p5YUExOWRC?=
 =?utf-8?B?b01wVm8va0hZbnhRYUx5ME5JOXJpdEJBWmFUMUFtV1AzMGI5S0xXSUJUUUpR?=
 =?utf-8?B?TW56akRqRVducldjdFBUQmQxZlQyaGc5bzB2RjhaNGxHVytNZktaWEl6U1Z6?=
 =?utf-8?B?dnpialBCc20vejYvbFUySlI3TmlrREZxekQzNnVWSlloY1JwcUdubWxtL0RM?=
 =?utf-8?B?YTQxc1ZralQvQWF1UExFYU5PZmVobWtVOHJmRzhTbHl1bkgvWjNBNSswSnhS?=
 =?utf-8?B?SXBLTU8zWm1IdlFHbGlkL2VMcWlvU1lMMmIzS0g3bDIxVklPRk55cjVBTzFo?=
 =?utf-8?B?MFNITUEvRjJXb0lsdllreHM3WitVL25ZMk5qQnE2Mm5NOHZvaWZwSE5mZERH?=
 =?utf-8?B?Y1BHd3ZRM0hqV2hzSDVPVUY0emZldGdYcTVTYlRVYXJBQmxaUlFsVXBNVUJH?=
 =?utf-8?B?YzZ4Sk5CL2lMTlhuS2k3QVV4UXF6VGdwSEpTbmx4T2ZsUHRRZHRRZFovSVVZ?=
 =?utf-8?B?cEFhYVV5anMzTkFaT25LKy9CRTcyaFpraFA2NFpuYjZpVnJUQ1NFeFprN25k?=
 =?utf-8?B?MFpSc2wzT2ZmOG5SQldoSFBzTkpsWmRyNTJGRm54TDh5T25HR3Y0QjQ5R2xT?=
 =?utf-8?B?QzVKaTlDaDZ5dEVEN2xGZjF4ZXlpRWJIVVl2dzdnVm1MbUNWN2xQM0xUNHFv?=
 =?utf-8?B?YU1PUklvY0tXYVpzbkNMSnNCeko5VDNMdkdKZitJeFpra1o5M1V2R1dxaCtD?=
 =?utf-8?B?a3VldSs2RGVJYmV3Y0kvc3MwN0x1eE03NXhaeENMK0ZTaFBKNUlHQlVCZFJ1?=
 =?utf-8?B?UjhFQUkwZzdsRHVCQXBhbzZPS0xKREx3NXhSNWZ6c1BjNDBUNVFJdVRaOGdi?=
 =?utf-8?B?OUdsZTN0SEhxbkErNFRUUC9yVHlGTlVRdmsxLzNoZVgwQ2pMeVJBbmpMeDNO?=
 =?utf-8?B?eDE3T1NwYW9xS2YydEIvRUYweHdVcW5idVcrVnFxYzZTOHljY3RqKzRUcElx?=
 =?utf-8?B?UTV6WlA1L2xqamJURGFPSmp5bW56TWNCWGVkdnZYQWIrV054Q2VKSHBMODBp?=
 =?utf-8?B?WEFmeEJTdTVBN0hpSGpEWVZ2bUh5WHl0S1VZeUFqcC9yMm9oYnpzTDI4bnQr?=
 =?utf-8?B?TkhsVGdyNlFKT1JUUDJNd2liNVdzSWFmZFlBWGNFNnF1OFZnNnNaL1MrS0F5?=
 =?utf-8?B?Z21CQzJoVDV0cFVaZk1zRHZRTy9KT2JBK1YraGoxVXlwMEhtTHpna3BiLzRh?=
 =?utf-8?B?RkRhcmNDcGhQMGJzYzFYUVNRaVlsZGVRanRmaUdvRVUvTlZQUEUvUUpCM05V?=
 =?utf-8?B?aDFtN0taNHlDY2pDcFpwSTZRczg1Q3dhM0F4OHQzeFM0RDVVRm9yeDNzcW80?=
 =?utf-8?B?aWNRL09GMWNGVE4rbVBiRkovU1ArZkVNNjc1ajEybDF4NS9pSzdSOSthRWkr?=
 =?utf-8?B?dnh5Vkx5ek12VXFJYVl0dkkzZlNVenVvc09FMk5CKzZJdWQyQU9iVEFDbCt6?=
 =?utf-8?B?Y25iZE5qRFRKMVhFMk9icUVvMFFxeFpDV3JTeW41VDk1S2FzVW5VYWxVdEc3?=
 =?utf-8?B?bVU5RjJya1U5Q2RqMVNPZkFvRU5hZ083c2ZCNHZqNHF5VldWUjNkdllLZGc5?=
 =?utf-8?Q?sa+J64G3PrKBU6djGxNelffstSVz1mHU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWsydWNjMW9XRVZTN3ZrRHNrUUhlbUtGVU5DK1J3a0NwRzdiOWRsc2VMbkRj?=
 =?utf-8?B?Z3VDUGc2TGxOcU8vSTYwK3F1M055V0FjS3hadjZIZnlsQVBidnNTOWNQUUV3?=
 =?utf-8?B?cGhTKzZMcWh2RGEva3RJK3dkajF3ZHpMazdIZzU0OU1jNU5xdjlNbThGaFhj?=
 =?utf-8?B?NTBZckdlOXNWb285UnlYaE51WVV0KzUxZDJDSUpnQWdQM0RUeDY3dkc1NlJI?=
 =?utf-8?B?a0NaNGlwM2hlWVg2bDkxNkVrVng2RjNrVmFHdmMxQVZVamZNMmNpblBDMkx4?=
 =?utf-8?B?UkxDMkFyU2I1Z3pCR3Z0VkVBSG81TGJ0ZlB2Um9uRFkrQ1lTSXEvRlhqUFpL?=
 =?utf-8?B?VFZZWHl3clp6RTFHV0QvMjQ5Y0RnSzh6Nkl3NjJYNDhmM05OejRKUVBuMlRx?=
 =?utf-8?B?UlpEUFZydzdzaXZRMlBjRFpEaFRVTGRSUTJqVVRMWUlWOTdTb0lDVThLZ0F2?=
 =?utf-8?B?ZVN1ajFnTFZySHQrUzBSRjZjbzdvK0ZuT2o0OHRqRXlJTjlDWkx5WHYzQVFH?=
 =?utf-8?B?RVl2aEE5WXFCRlRxZkcwNUNWV29DWEtQdUdQYW5OYWVpNTEwM1BtZ09vK2xX?=
 =?utf-8?B?bkpJNnlsYlFlYXh2OThQSjhBSCtlMnMwZ2MxZDZXclY0TlVZZ1hZUTR1S0g4?=
 =?utf-8?B?VnZveDkzVzFCa2RzQ1piQmk1VlFkc2dIendVQXF4UGVvSlpYRUs4MFRia21R?=
 =?utf-8?B?WnhmN0dxVXIxazc3bFBST1lnTDVCejBpYk53aGZJL3MrTVFlYWZGb0lrdU1T?=
 =?utf-8?B?Y3h5TXJ1bGg3TVhaNTRNdXJxaXJZZlg1WVB4a0o3WUl3Zk9JaEZ3Y1FPL2lF?=
 =?utf-8?B?QkJyektSVnlmZjZpUGloZElGdFpQQU0rVU5sN3dVMEFRdWl0OWV2M1J2TXZI?=
 =?utf-8?B?WjhKWTBRL2pYZ0MxMnAzRitzRHRDWmVGK1pxc0VvYnJjZC84WTduZmMxZmhn?=
 =?utf-8?B?SUYzdnAxbi9yVHl5ZVFUeExjdk45cW1uRlkyYmxjNGtGcmc4STFkb0E3MXh0?=
 =?utf-8?B?VVIwQVFyZ0crVE05MmhIbVBvMGhCVFY1cE9TdTFuRElNN2lxbEVudG1CdCtR?=
 =?utf-8?B?Mi9BZ1pqMjZuVlZaWXJiZFVpcit1RmdINmQveE9JbEdmTWk2WjEzMU9qRjZN?=
 =?utf-8?B?dEJOV3pEMTZ5WUlZTFBESVpHMk12eWV1ZWRPVWYyMkNVYTNqTkgzT3h2YS94?=
 =?utf-8?B?YzBUekFoZkZhWjVDN08vaTAxQURPWENORjJLdEl2RWVtdmVIYVl2K2tZYlhI?=
 =?utf-8?B?a1E0Z3JyVmx3RGJtOVdFMSsyVzZXeHRGM1lDNTZTNWthNVNhLzJZS3pSaGFa?=
 =?utf-8?B?dk5qWFZGcHowNWcyZ0ROUzI5Tm9lVHI4MmdzZE5aYmZ2KzYrVkQ0cnV4NjVi?=
 =?utf-8?B?M3lMbWtNRFNtdWF1RlpnR1pqVDh1bzE3d21ja1ZFblN2U3g2b3ZkTFM1dzI3?=
 =?utf-8?B?WTVyZzNzNHJXbXJ4bTdzd2RMTEszUEc2MGcweGRUekc0YWJ6RVRlMTRuRU90?=
 =?utf-8?B?MVRpU1ZhOEtWVWJoRkppdk95REJMdUg3bnliOWg0bVl5c2tnS0REN2hYaFFm?=
 =?utf-8?B?cU12V1lDQkczOUV6N0dRaVZnU0ZWYUxXTGJ4V1pCN0Q4R1ZTZDVxZFZTZ3Bo?=
 =?utf-8?B?Q2lSakIyODA0NXNYejB3VlFWUXZaYVNxTE9pUkNEakVlSDJuQ1YrbXdxVE45?=
 =?utf-8?B?Z0xISjFwU3pydTFPSVh0em9zenZoNXNnQXllb1ZZSFlSWndNVHhvOUNMZ3hY?=
 =?utf-8?B?RnJCS2xHWEtGRG5zWk5BcVY3ZVM1Ym1FZktnTVNlMkJZYVV1dFptdHpoMzBz?=
 =?utf-8?B?b09FMER6TTVHcWhpUnQ1dTd3ektxNU1CNnBCc3BPR25OTllraUd2SjYxcnpJ?=
 =?utf-8?B?YmFFaEhoa0lIeEZHZmhqM0F3UzNiRDVWVmNNcFdhZlNCWTZ0T0wrclZlYWxX?=
 =?utf-8?B?RzBsL1ZrSXJYekJmQVVzZENoU0NoalU1R1hRLzhicUtJSnRPQjNFTWZqbHNx?=
 =?utf-8?B?MTdpanUyOVYvWXZEQTVyQXdhOXEzRktqanJHcjRJVjRaK2tZNDhFOGNtNHBy?=
 =?utf-8?B?dUJTV3hKTHl3UkxXVzhqOGhQcFdZS2VXWiswUzVwTkc1MFJGZU9wNndoY3ZC?=
 =?utf-8?B?MmNvOVlhc1ZpTWt0Y0JZUlViQzJZWVF3L21OUmJkTER5eVZ0N3dhV2NKaXdN?=
 =?utf-8?B?c3ZkVXNHNlNBNkdybCt2eFkyc3dGOVcyd1BidkdzR25TUG5CZzhqRTduNXJN?=
 =?utf-8?B?U1ZNTTlNLzhRa3V3MURBNEVndE1ZTHRUYlJ5Wloxd3NuQXowVmZvZFA5K2tK?=
 =?utf-8?B?OWgxdTY4c0JYejhtYmF5Z3B3L0JkUTBUZGlQNXMyeDJtQXB2TE9oUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd361bc0-4d20-4e3a-eb0f-08de4e15de81
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:54:56.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76G0j5N5BzOueci8jiOVsyPc2i8fJ6RtS5dlkkeqDD+iJ/4bI7gV2QaA14lozLjrdH2nthBmtG9TdMK1jv44qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7541

On Wed, 7 Jan 2026 12:19:26 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> On Wed, Jan 7, 2026 at 11:59=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
> >
> > From: Gary Guo <gary@garyguo.net>
> >
> > This has no behavioural change, but is good for maintainability. With
> > `quote!`, we're no longer using string templates, so we don't need to
> > quote " and {} inside the template anymore. Further more, editors can
> > now highlight the code template.
> >
> > This also improves the robustness as it eliminates the need for string
> > quoting and escaping.
> >
> > Co-developed-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Benno Lossin <lossin@kernel.org>
> > Signed-off-by: Gary Guo <gary@garyguo.net> =20
>=20
> Are there significant changes here? You didn't pick up my tag.

There're changes related to added `params` which you probably already
noticed.

Best,
Gary
