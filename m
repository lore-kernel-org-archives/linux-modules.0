Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020141.outbound.protection.outlook.com [52.101.195.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC754E324B;
	Wed, 30 Sep 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782663; cv=fail; b=ZCo/wuK5rDLfEtKejq1n657QWbVxUkQ5ZCLG/NriKuhpxPBRb8/OSbeG42NQCnVxtkYcVZwRmLjLtm5nKB0GJ1RvPQAbeyk+EwOUpYH+jLu7BW5wJQvp49riXfH/aSGNSZC0TGiVN93ZZakix2EbyX3WqRJK0/itrbUIwSPyJKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782663; c=relaxed/simple;
	bh=GHm++a8Yj7uLZczo8tFwcZDOndoSyenTGhgJ+k4ejkI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fO2O7k7urXGcPutHQukCl4+Bdcn012vgfZpzxQ2WMnFvDSIWJg7hbhEC2zj/Et7mJwgl94ypaHszQknq3tsIn2LDdaRmL6n2Wm3m38fXkueUMrVHuMMl54mttON/OLarD47Q9L9iI8e6cmV12TL8J53xbG84UTk7mwqGzOLM0FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SUa/NJAp; arc=fail smtp.client-ip=52.101.195.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SUa/NJAp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQp4wC4rqkP9K5+P2hghrkG5CS5huUnEghGPm61lKpZidpCAXzj5njWz9kfjYS1Th6g2Qq1Q+7ebHDQOFdnn8U69No9zHWqhrVT9scYz/MevwSh1ynYbI1ohiEsjdSk0iuE5Ggt1dRKr6bMg8UR11LkYhyBaPJkq0DRvGVQvZhQCQvvz32G/AzTv8nD/9NA/4mreDQbV8/xhLPrTMJaO8hhl0L862Gp6PL6XsQjKBhfPtxxaD/bob57lbCJWCBg1TQaflNOPpDLFbBguxLCTyMrXzL5zeingqw73y8ZGWc6I2v8evIdgk3EmboNE/pOjTORJ2hN/a/4gkUKAghOOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHm++a8Yj7uLZczo8tFwcZDOndoSyenTGhgJ+k4ejkI=;
 b=YwgsSMgGf6DMxsWWeFFQjl43J0gfyKwGt1g+EQ/mZQFml/mSDHP0fG7ck7Hi/vkfdk2SFG0VguPO2L3DXsATAnvIHWprtUHd7U2bAzEDn9jGeVjeqBYPLDYaq+Tqntp6JU5qz9y9gImMR3KisvwNjFRODtQmaDDdU5r35E0KBsB2bRfkUnH5kP4wuXhlzDB++Sn/eE3qK3MYDV3Pp9eZTZpwimvn+1teEhchPz0kFch2JVDmeGlLF8fwdC87Z4P439IrNLt9aFJqtohroIoV+ODai5mn1TOsTOfr1ts5/mCkQJVmPGNiDksD03jdI+8Ne4B6cTW3C88XSfNMyXCh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHm++a8Yj7uLZczo8tFwcZDOndoSyenTGhgJ+k4ejkI=;
 b=SUa/NJAp7GVDzZ5fFROdbdj/0aUTT41qYXgpDhUPT1i8AeShSKPDRnqjgvlL/2/02IMQDb8pRRT2KoKoQ4Rg0/+Y9Nq1mfsEzPbkDrl5VenWFYFnYGYy47JEDKrTy2JX5vBcgCikk0wd8+R5Ij7UW/OIUd4aWgxbHPsWVQj4ljE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LNXP265MB2428.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 15:37:28 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 15:37:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 16:37:27 +0100
Message-Id: <DLSRGVBPWMXX.1LAWUQHDYKLCV@garyguo.net>
Cc: =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260917051147.98775-1-tweek@google.com>
 <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
 <DLSOH1EVCWKD.XEIME3CYEYYJ@garyguo.net>
 <CANiq72m=rhBDJSSPBZ3yXb_r0jiCq7f8KOy+Fs1k8SzWJUwkhw@mail.gmail.com>
In-Reply-To: <CANiq72m=rhBDJSSPBZ3yXb_r0jiCq7f8KOy+Fs1k8SzWJUwkhw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LNXP265MB2428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9463cb-663c-4805-0491-08df1f08bc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|7416014|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	20qP1yv6PRKJwvMYVYw+lYJbebROcZT1cYFLfSiN6OSgkkFA9m93RvKrBEphGdp+RJ5qwqZ/jWiCj76o3eXQitU/eFk3aDbMGcu20HQ0I9DlPoqnNuTPwKXNIzri+jL76l6AIoVqSxbw8lbo+WAaId6ANgC/7eiBgey5r8SEVmRDCha6ML5pz4NPZxB24nGJLhAexx+uaIJdi3s837N0Ro+rC3wc8hOywWIzYAJb9GdMjP6mGyGytSocW32NBYqHJoNPye8bkaBntgTtrFtJBl7IVh9vq63GnCe93y30JbIh0xalCMlzAVnLvqCdFN17IEYKF4oNA4amhtdbuNzmsIUM3hVCHWDO0Q4YrAlO0K+po9cEhKmKnMlyWAN8aH01TbspyOVrv3unO10zIP9MUUhqenT5FnkNNngKGsQ0ekV3hvAUE5NI3eZb41TmCVLE2WVr6xUOxu2FA4vJQHsyhB7PN+3NfUTwythVBpeyANnOY19IyjZ4PiM8xGKFvNMkivBEJBQpBscAf8BoKzJsH3htg9F2fTUL9Lsf8E3Z49qMqw6aF8MkRS+npPgURsFPssNzc+IZd/66xzEwQpYQG8kJACy0kf/RhafMXMjYK+Cy2dCyx5gZgSteINYzVoIGVDVL8FusF4rvWNJOqYFgrNYaaCkj18/y4QXXPVwNjD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(7416014)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjF4dnpPVFFYUTM4MmQ0VytkRU9JN1RLZGF1VlN4TGVheGVzRmRQcHlXR2hn?=
 =?utf-8?B?Wis2NVV2YmNxNDR0OWl2Z0psQ0dGQ2V1MFNSWmc1eEFIaWNqLzRkMVZVMXRX?=
 =?utf-8?B?WDcxUFhvL2RRYVNuVjZWcmUrS3A2TWN1M0xqUExIY3BEcVhSa2RMUFBZVWlR?=
 =?utf-8?B?QUNOU3Z1Yld0ZzJzd2VNWlNKU3hLZVBseFFNdkZaWlZhT3lMOWY0R2NQZWVR?=
 =?utf-8?B?T0ZFbnovM2E0aXYrY0xwSnJ5MWZCMFA5Ynd4WitBek5XRmEwbEhpdVBNU1Bp?=
 =?utf-8?B?TExIVUdwdUxkRlQwclJ0RWZlZStHYW54UXVvK1c3MitDcHo4LzJoOGpKaEVw?=
 =?utf-8?B?TTJ0ZHMwWTk2ZXoxczBtUEliZEhvRi8rNmdtV1NQY1NJTzhDMlI3Nmx2Mmlz?=
 =?utf-8?B?NndnSS9nN0xnUnRMdGQ2M0pHcVc3cWtBVktJU3dxSFRWOExTWjA2cStTeGk4?=
 =?utf-8?B?Wk1WN1Q4N1RlQTE3Rk5iekxhaWI1ZmtudVZ3dnNJam55Qk5wTWNQdnVuWC9a?=
 =?utf-8?B?Uy9FdWJkYUtpSXIwb2N1RDMrT3RUOFExT25sNUpHQVBqUDRCY2JJOHJVQ0l2?=
 =?utf-8?B?VCtwd25DYmlWNTJrZlZEa0dXTjhuVHMyRld4WjIyUzVYeGhkKzVEbk0yMjBO?=
 =?utf-8?B?S2VUVFBiY2oyMEhxTTZtTzJ6YTVjWFpKaHpnVVdKWUxlRmVhTDhVanR1bFZ3?=
 =?utf-8?B?bTdiV2xmSCtxaVhYMlo4TlI0S0JvYm5YYmNXY21iNjhuYkJFSGZXMS9ITE9R?=
 =?utf-8?B?NHBUOW5FN1BPZmlEWXJpZmdBL1JadndWT0ppRm4wTjdpNXZHSG12RllpV2hh?=
 =?utf-8?B?TXZKZ0RCQU5wQkkxZkxxVHY0RTVZQUJsQWNUbUQrMHRadlVLUDkvWXN0emEy?=
 =?utf-8?B?RDE2d2s1NFA1SVI3TFFjeU01Qk1yVERmTFNpZWRGS1BPUk50SVJ3TXdhNGF0?=
 =?utf-8?B?SVptWVoyQmFZQ3FJalAvc0k0S2N5ZGF4alVBWFFvanl5UkVpV3c4VXpWdHc3?=
 =?utf-8?B?ZWw3bVJLazlnY1hNYTg4Sm9MdVIyUVBwSk9yMHN3Y1hUVnlJL2ZIbE0zWFQ0?=
 =?utf-8?B?OVoyRGNGb3JLbk5WZmduTWY3R0krTEZtVjdDV2ZHQk9lWEtSSHpqdHZkd0sv?=
 =?utf-8?B?eDh0bW1VdjFIeTBUQ1d4dDFWWTJYNlRoZmhWRXFBZlJ0VDFQVllXeGU1RDBM?=
 =?utf-8?B?bHF4RldRMk92ZjdrVnpZTzV1dFVnT0lYbE1Mdzl5WDFiRDRkUzBYUFZMeGRF?=
 =?utf-8?B?ZkZBdHE3N3lZZWEwSHZKMzZqb1E1cy9GS2lzR2VZZlN4U3l3WWc5QllwZzFl?=
 =?utf-8?B?RkNGVm1VNFMzb1ZSYlpONlgrVGEwbkZWSHlmcjNrS3gzRE5jdHRuNXRWckgr?=
 =?utf-8?B?a3hKTGd1MHMrQmpoSDdqR1pKdGRFcFlJRHJUemszSHV6ZkxjVmQ1Y1ZGZk9l?=
 =?utf-8?B?azNoTG0wS1RacGRVMFBUVURwL0Q4dGdvMVhHZ2p0eEFxdHBxSEY5WVhjQWxC?=
 =?utf-8?B?NWZDQ3g0VURveHZHQnkyaHpSN3g3S05oNkJ6T2FJS3owanlMZmRoSWp1KzRt?=
 =?utf-8?B?cFk5TG9oUGJmMTdEYUFFbS9JL3dUZnVHTWtwRW1sSTk4ZVBwcXVCRDdxSloy?=
 =?utf-8?B?K3BkZHg0QUhGaWJwNUtEbUlVaElEWHg5VjA5OFF3ZDNHODRIRGg4K1NVdlU1?=
 =?utf-8?B?ZW9NdG9EUEpmQ3o1OXJDSmxhUVY2UTl4ZnEyTExnR1ZKU3NpcU9vZ04rSTIw?=
 =?utf-8?B?Wlg1N3lJeUtjSVZ6QmkybUZ2cUtxNGFzVk9HbG5rTDN4U2t3SGxsVnFKdFZG?=
 =?utf-8?B?TlN3RHErYThZbWhWUEp0WW5Rd09Pb0dsQ0xZSXM4TWJQT3R5dUl0N3psczBY?=
 =?utf-8?B?RndDQk42T25LOHBweDJ2ZGZKblN6UzNjanl1ODVUemtKVUlJUHUvRVNWNUR1?=
 =?utf-8?B?NWhSRS9Jb3JueU9vc3Y4M1VsRGp6bzcwZUt3Y2tzMG1pN3BXNjMzMUdIaWpL?=
 =?utf-8?B?Q2I0dVR5ejl2bFpoU051UExidWZ6K1lNZkU2aGdzeXIvMDdNU2pUTEp2ZDJ3?=
 =?utf-8?B?VFNyZ204VjBTeUU3TUpYUktzeTJXK1lzZkFWMEd5bnhTOUpaVmpwTzVENEVF?=
 =?utf-8?B?OGE5T0d0U05wV3lWblJaQUsrS3NlZW5NeUR4SEVCbUw3eDNET2VIV2I1RlJt?=
 =?utf-8?B?TkwrU1Y4M0wyczV4TWt5QWRxWStrVy9SbGk5WWx2ei9EemJqejNaeDIwVEVa?=
 =?utf-8?B?UDdHd3k2NFZZUzduaXA2QjNjWXZzWXY1dGd3NjhhQnpJL3Z3THhIbHVaOHV2?=
 =?utf-8?B?ZDNxaFRjdkt5MzZkTDJtYk5qT1hYbXVzcEI2RlNaTllBMjlTSkxpZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9463cb-663c-4805-0491-08df1f08bc03
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:37:28.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6DejOPNCzchXQse0CM/YlsMO6flVHwYgFm+U1jrWOh7rqB3TcMOvpzSXf/UtPZTZ8N0qEZi/u08Q0FVE7SE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2428

On Wed Sep 30, 2026 at 3:54 PM BST, Miguel Ojeda wrote:
> On Wed, Sep 30, 2026 at 3:16=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> I'm not sure that this should be considered a fix. More like a feature.
>
> Yeah, I had the same thought, but given we discussed the topic in the
> past and we supported non-ASCII on purpose on commit b13c9880f909
> ("rust: macros: take string literals in `module!`"), I thought it
> counted as such (that is why I mentioned it was unintentional in my
> previous message).

Ah, that's my patch. It had been completely paged out from my memory. In th=
at
case this is indeed a fix.

I don't think it's worth tagging stable though. It's not something worth pu=
tting
effort backporting, but if AUTOSEL picked it via the fixes tag it doesn't h=
urt
either.

Best,
Gary

