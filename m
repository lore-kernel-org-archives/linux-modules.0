Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020112.outbound.protection.outlook.com [52.101.196.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929135CB73;
	Tue, 27 Jan 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525611; cv=fail; b=hbEPDnwLypfAye56Ru4kZm5JXE/mjraTLxlQ7AefjdF0OJlbSoi11x65VqBoEaRYPPHUDcrixDSuo+goTGPjUbOAEez/J280emrXILGcVNu9vMSLBRkcj5CQLuiSCL4vabw0RUXWGp00UQUZLI5IoR8/IPAMkxikJj+Im5JGW1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525611; c=relaxed/simple;
	bh=q01YsGd6EfXdjdmEewOF389aUjVnydXmkf8z7SIQsQo=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=YY1iniD17XVHHreVSBAVFM0Nft6mDkkeNP4WyjmMsqJ4BnpPtS0AuA+rXzxreaHW5vkTzIUE2yhWE8y9A3+nfY6YyRLR7g8W1k6eKteey2yWCYHKGiZ6quFzBp/aW63giiKEvGx4v7GmPOOO2fwqxWjeDyB12w3F757rb92Aw+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QTigyPtU; arc=fail smtp.client-ip=52.101.196.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QTigyPtU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj3Qx06L/ncA5PlFgGXwR2BBsiupGcqCGnNBU3cnNAtlIpokFgo3thtDUx8a3hoHdPx3GiGJ0m/4N4A0X9B/spqG1QsR3kyohuxrZAutkYzjr/pVMu/qLoUNiP/KPYTZA1+lvEOzfTNo95A7evL0OLCMiYu2wYFY4CjLduKMN4hpTnIeo2+PYBkoZVvpWhELfsXOjHmaiXOIPLAsJjOqXh8UQQft38/g2jlhsstdECGN4fvNHmc/sYMjaIUdR+mAL41m/sQrilG7bgu+eNBuM0mpXXAzSr6IZriPv+KwchbR6sQBCGk/XNbJgzFPQvZn4X4MyDEBtRRfotoWndlcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eDfCJhD0UJZC5pfMVV8FuDp0EqOWcSHnFKxHnRchLE=;
 b=K3k2uj1yB+/SPnHp0Pv/RD96mAmEQiodQbyBPq+IESqo9sEe91orYoYegElXDCKZ5eJPScGbHjLJEARISdH0Dzlg5D41k2TzWgrpjTYPrz45RDdI2VJHaBxEiIarbfS9lEhmuRExtQw5eOSE7yiPX/Iumrcpeb5quZn1ApgcV8AuvGm7lNRUvIA/WSyIQKlKth6rYAHilO09ZjlCCBTHq5wPWBOZeFNfIYRPnwdXNVRyrh8dsgS7kG32CkTivLoPmD18pgnxra055uhJ2NBkpwWH24zpweWdkUWbzFXEJ2SP0wj0tO11wSvYCbVNEs3bt4y4u4l/KdDkHd8axfRgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDfCJhD0UJZC5pfMVV8FuDp0EqOWcSHnFKxHnRchLE=;
 b=QTigyPtUn3PLkgKl1ts8YCf+SEFIVP3P6o3g7AXFJXlYnhMBv6iWDBF516vHGI8uKw2M0eNNDW/qiGble2pWNz8Os8jH9s7BJhC6OCX8BS8WZ3zZLy5cL/lYCqPsvxP/VwWHWztFu1fAsfghmVnLo28wWjEyuTK2NhQj2mN4924=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB1974.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:82::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 14:53:25 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:53:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 14:53:24 +0000
Message-Id: <DFZGH4IMZEE8.2NG4D64BPM9N0@garyguo.net>
To: "Kari Argillander" <kari.argillander@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Sami Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin"
 <atomlin@atomlin.com>, "Youseok Yang" <ileixe@gmail.com>, "Yuheng Su"
 <gipsyh.icu@gmail.com>
Subject: Re: [PATCH RFC v3 00/15] rust: Reimplement ThisModule to fix
 ownership problems
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB1974:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c6b106-e56a-4871-bd04-08de5db3d306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2pCakUwUnlSNm9SMGVSYS9KcWY0K2NpYVZoRFZmWlZvSFI3NUt0MGpLdy9M?=
 =?utf-8?B?NHNXeEloRUFuR1JyS3o4U08vWnpId3oxNTJ6OW5PRHhWNXBVSjRaM1pQZFRl?=
 =?utf-8?B?cjZxUHltTmxnYmpmdkpIZlB0aCs3TTJnR080ZWs3Tkh4QzdGQ3ZBUVZnMlZk?=
 =?utf-8?B?N0tyWUdlSzM0SENqc1FVejR5QUNBcXVmaWdUUUgvVVVsMldqY1VreTN5THpH?=
 =?utf-8?B?RGxpWXd1cHpCdlZjZXZHN0hLTmFUVjE4a3BWWitPWXBzMVV3SFBpbXBQVENE?=
 =?utf-8?B?ZTVVV1hRSGZCcXJ4K0JoMHQ2Rk92K2Zpb0FEWVJTRHU3ZzhzODVDajUrUlpj?=
 =?utf-8?B?bGJCYVhjd1RzVHdnNEJaL0FLNFVrRkJWYURPUGsxZEZSZkpEejlPZmtyME81?=
 =?utf-8?B?cDdOL252QTV0TEt4d2ZLQkV3ZlI1bTJUNHpHT1BMQnlqQnE1bWlENGZ4SXBO?=
 =?utf-8?B?dFd2TUNpdnFxaVBEUkdTaXJIYTZHZ1hBUWxLWUhSV09nZkowdmJrYm5uWXRM?=
 =?utf-8?B?ajFReWZRZEQxdFRoQ0t0azhMbnFTODQ3NC9TbldhK0dtRC9zNzZTL2FpZjJ0?=
 =?utf-8?B?TS9XM0tvaG1QQjB3N3ZwTGxMUU5MZytDVEptT1FBUUlWSk5NbDBWOURVZ1JS?=
 =?utf-8?B?c1VzZ0sxODE4RytIT2ZnMVZGV0tTSVg2WTZ0Y3FLRzdURnlDaDJxZWhaWWtm?=
 =?utf-8?B?Q3NvcGhHOU9oY3F1U0dhZCt6dE1IVWE5TjZHSTlsYy9kUVJEb0p5VGlqMHdP?=
 =?utf-8?B?dmUxSmFlRENNT1k3bW9QNVExQk92T3k3WiswMTNza0JkVVNrRHJYVkl3a1Nz?=
 =?utf-8?B?eTBCTU43UGZXVDVLTFlLbHEwb1ZKVWhFd3FSdUlSYXlITjd3OUhqMkNvWWw3?=
 =?utf-8?B?NU9RS2R3ZWkveVFNR2FYRFNucTJWRmZNbWVmMVlIdVFlT0Q3ajlnVjRFc1Jw?=
 =?utf-8?B?S2lTOEZZUnZyN2s4d3Y2ako4bC9kQUVickw3Zlo1V2JRTnd5VzZCMnNXaUV6?=
 =?utf-8?B?TmN5eVAyeVd5Y3lrSXlZSWlDLzNpb2k4WVppUHFURXFXYUNBK2p4bmp5TnBR?=
 =?utf-8?B?NW5uVFFhYUkrSm1ZTXN4bkRWYzV0MUs0cVhEYytDUm5SdURSbXhsK3VGZVhq?=
 =?utf-8?B?Nmc1SWI1VFQ5WEJLQ3RGSFlKZDZYa2pnL0dlY2EzOGRxM2d2WnBvV2daUTFS?=
 =?utf-8?B?MmZ4a1FJd1dKK3dEWmdwKzkvblkxampZUThMNnRSd0tHdnFTT2tuNmNLdENF?=
 =?utf-8?B?YXQ1Y1BOMDB0TjRSNlpTRXl0T1pmKzUzSFJrb052MHdXS3NWRmFObUY4eklM?=
 =?utf-8?B?R056VVRYOFFpZTY1a0EzZTN2WlVwTlByaC9pVHFudEVaRDMrVWhTOXFUeEVq?=
 =?utf-8?B?OTIxM28wcnBQYVBzNGhtYXc3bWZUTjFvRXByblUyZzlSbUdOWjIxTFhHMEM5?=
 =?utf-8?B?TkxIVG1xSlB6TW9aZ0JyS1huVm5aNjU5R2w1TFlBUnNYWVFZVkpqa0hwR0Rs?=
 =?utf-8?B?OVdkbDVNQ1VwM1N1MlczWDA2NXQ2VnpXNk9MTEdZMGFrVEZHeVM0N2pRRnV6?=
 =?utf-8?B?UGtNQVVJNDVmc25BS2dhZFV2OHVYQXorR1BmakhvSlF5VUNaT08yQlJFWXF6?=
 =?utf-8?B?blIyYWhYbnJtUDVsc2dCWUN1QnBhclBqMlhWbHB1eDYrWStEaWFtNGhBWFQy?=
 =?utf-8?B?ejJwdGZ5dVFZS2lYcWZKc1RXa0UwOG1Pajh2VDhqRTRWbkVkQzlHWWJ5N0Qr?=
 =?utf-8?B?Mk5WWklFaXZjd1loV1kyL01mbVJudU9PbFlLVEYwU0FmNlFqL0lwU29RTURX?=
 =?utf-8?B?NWJic2h6VHJuUEUrVDlhT1ZWYnFaMWdGU3VoL2FuUXFicXRKQnhYWHNwRE0y?=
 =?utf-8?B?MnBZNnFOYzc4enAxZlFaeGtiVTRhd29KTkNZWEhMM3lIcXQzdVVQNmdIMkps?=
 =?utf-8?B?MUlzL2U2VnhYZHNOZDluYllCek1JMEMxY1hSem80b25GUUkybnpNTXZkM1A5?=
 =?utf-8?B?bUhYcFo1Q0I1MGVicm1ncVdNZkpOMkVkdDFFOUR6bzFlbnNiUnQwNld2bW5T?=
 =?utf-8?B?aklYeW9uNlRxcklWa0pmVjVacXVzeCtPbEVpK2Z1ODI1NEk5bDYwZ1pETEV6?=
 =?utf-8?B?SXI1di9sVEdwZEFGZ0paeTBaaS9KblVOQlo3dHVjTVFhVmNVcUt4Tjc2MFdJ?=
 =?utf-8?Q?0wXlo9ugoDEihWUv0TWCTjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZXeGtJNGZoSjlUUDluc2ErdGZHUzZYU2JyWmJ1V01Lc3BKeDRUajk2ZEpn?=
 =?utf-8?B?bWVuOHUvMTkxQWlHMlJSeUFyaThJblhGWTdTRmNqNXUyNjNPbERLYXE1Qkpl?=
 =?utf-8?B?cjRuNEVKdWNSeHVFcThIVG9uREw0Z1l0d1VUL3V0ejUwRXEwZ3JOaWFqZUY2?=
 =?utf-8?B?NDF3bGFqMDJaWmJhTmtEYUMzaVFHWit6LzB5dTBoeUVJdzZCSEdzR2hvbHhT?=
 =?utf-8?B?YkxSWExoMmVXM1MxdWFFV0hjOWRIVXI5TlRCM0tVSEN1Y1FROG53bHF1TEIr?=
 =?utf-8?B?QkhvK3E0RmtBN1V2ZW5VcjRBa2FhblUvdVE2NjNSYk9HTE9wNGxpaUZYSk5B?=
 =?utf-8?B?enJEeXZmd2RJZDZGRGdJK1FqWC8xMXZNVURsdmVQVUhmTWJRenY0SUF5VEI4?=
 =?utf-8?B?cVE5R0hoRlM2UUNWUXVWWFBLUFlWV1RpbExNbWhpTnlqQnhDMjhJUE1lenNN?=
 =?utf-8?B?cHoxb254a3QwaEc1aWU2UDNPVnZDY1Q0aUxCNkJKeFNiY3Q3VnVNMkphMng3?=
 =?utf-8?B?R2tRa2FKMlhGdWkyU0hKRkJ2STZialg0Y01vZWhUYThraEdHU3orS3BGNlVo?=
 =?utf-8?B?aHdhb0RrT01aNjloeTlqemRIeUtYZG11YUQ5dE10eDBNZllwK0tHd1A4ZDBt?=
 =?utf-8?B?eUk5U0dNRWRCVVVwOUROSklGRDFVcEM2ZGprS0hVU0xmOHdtdm9IZWp1a1Vx?=
 =?utf-8?B?WVo2OExmajVBbEVsd25qRDhDcnA0OTRrRnZTMHduM3lBRFg1SVlLS3NPMWtl?=
 =?utf-8?B?QVBBaWNBbWpoOVFRVUNKSyt3Z2tqNkhYdVpaSFdON3ZMVHJISkhEUHJ1Zkh0?=
 =?utf-8?B?emtTUi9XWDRuN0svMXI0cEJXYlh1enRmYUo0M0xqWkpkbEV4YllsZTlIcFFD?=
 =?utf-8?B?eFc0UXZ1TzBORzVJS20rQmtGVmxuOVp6N3c4cE80dXZOUmo3citXZDE2OHBQ?=
 =?utf-8?B?dnBqVHdpYW5Xdmw5NXZCcHhucmk4Tk13QlRnc3BhcWVXQWw4b0lYaTN3Sjlv?=
 =?utf-8?B?L0tzU0R4cStOeC9pZCtWRk5XT2Qwa21BdDJXVnZNMHlqYXQ5cS9YSTBSNjhw?=
 =?utf-8?B?ZlAwcEVaWG1Ud0x1NTRBZ2NsY24ySkcwZXBrekJFNlJidzloQVRscDJaTFRW?=
 =?utf-8?B?NjZ5MG9iYm5JMCtrczdQKzBaSWwxeS8vdkltYlBIc05meUkvZ0Q1SGU1YzNj?=
 =?utf-8?B?dXo1SW05elNDMm5weEE5UWMzRE9IWG5ZcGFmUThtMUQwL0ozZWlaRmR4Qzh0?=
 =?utf-8?B?S2l1UWk5UEEyV3ZtVFFYeVpTMXEzM2F6bVhaRitLTE5Bb2VmQkhZdlMwUjlB?=
 =?utf-8?B?eGVvTnRtUVpySGFnRVRob2NTL0piWnZUNjJNTllxWWFGK3lOajROK3dvWHJZ?=
 =?utf-8?B?b3Z5UTl3NWU4RGtRUElZTjFQU3JxVWViNWYxS1ZSZE1xRElBYm53dkRuZ1Zj?=
 =?utf-8?B?WFBJRDg1VEVwZmNkeUZ1WGhuR2xrRU9oVXdBTHczajVOUWFKWGNXTW91RUta?=
 =?utf-8?B?dGRkQU5MOFVEWnA3cElmNVJxMjRBRHRCM2tKNzVxTlFZNjdVY3I0b3JOZTFQ?=
 =?utf-8?B?M01zeUVQcndDMWM4Wis0WHdhRU1rTW1razYrSE1jT3ExSGdsa2xoQWVFWkRY?=
 =?utf-8?B?Q0FqeU5hU1hLeWFFc2xtZGxqbS84bkRIUVhGZXF4WjZnci9GL1FmcWFQVWtO?=
 =?utf-8?B?dTdFWi9RNW5JaFVzdnE0OGpPWVhIT2ZYL2VYVGY0Y2l4enI4UFdoTXlwa0VK?=
 =?utf-8?B?M1RERjQyUmVoMW5KUmtJZVJmQzYzcmpuRXVGQU52TnFRTGlGaXBPRndTU1Bz?=
 =?utf-8?B?MExQN3M3LzJBY3pWSjNGTEh1MW1uZHpUSmlpL1RoVzJGOTBBdXArVDNoZzNl?=
 =?utf-8?B?MDZiSTRQQkd1dkt2aWVRTFdOUlZiZzZhMzJFbytRVVJaZzM4NTc1U25XQlZp?=
 =?utf-8?B?dFFKSWZzbUxwcDlXVEVoVWQ3ZzgxNGtJQVpvQkw2NndZWGJGL3B2dk1ScE1v?=
 =?utf-8?B?OGNTdjNnQU5TRVlJczBQQXN1OXVlMmNEeFk3UUtadnVEMk1DZGJDVDROOEFX?=
 =?utf-8?B?cnFobG1RMFovcGVHL3ZYZHM4Tk00bTB6R0dWa3ZLeHJWSE04WEREVkhjL2k0?=
 =?utf-8?B?WDIzaUZJQUk2OXI1UElRYzZFWWRiaGo0K3RZMWx2ak1sUm0yeS91L0J5S0dr?=
 =?utf-8?B?Yy93V1BFL2x3bWx4b3dPYjB6MkxIc3hkZ2xLTTBNK2Q5MlFsa211dnlIZkE4?=
 =?utf-8?B?UGtVdjdjU1NJQXdPWks1SEJYSWV3aXRMNXNmMVl2SUJmVjdWT1lYUitQSURN?=
 =?utf-8?B?UUxjMGZIWTFwbC80TVcyOWZHNzRsK0tBcklaRDh5MkJoZ045UlpFUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c6b106-e56a-4871-bd04-08de5db3d306
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:53:25.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SCBzmjDnfx719PJs3UKdKOugl/T09xhrtNwJtyH3pK7+AhaAJADa7yGNWDxaN/TDYbmJDn46SOlwmHtEDlBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1974

On Sat Jan 10, 2026 at 3:07 PM GMT, Kari Argillander wrote:
> Still RFC. Not all people for each subsystems are not included yet as
> this touch quite lot of things. I would like to get feed back is this
> resonable seperation and how we will land this. I have tried my best so
> that it can be applied in multiple staged if needed. I have not receive
> any feedback on this series and that is little bit worrying.
>
> Introduce new ThisModule trait and THIS_MODULE impl.
>
> So currently we have problem that we are not always filling .owner field
> example for file_operations. I think we can enable const_refs_to_static
> already as that is in 1.78 and is stable in 1.83. So that fits perfecly
> for us.  This also seems to be quite request feature but I did not found
> that no one has ever suggested that we just enable this.
>
> So basic idea is that we will have ThisModule trait which is used kernel
> side. Module side we will always use THIS_MODULE. That is completly
> private for modules and kernel crate cannot use it. Currently we have
> THIS_MODULE, LocalModule and

Why is trait needed? Couldn't this just be a `const THIS_MODULE` required f=
or
vtable?

Best,
Gary

>
>   module: &' static ThisModule
>
> on init functions. As we anyway need THIS_MODULE just use that for all
> of these things.
>
> Patches 1-2 introduce THIS_MODULE and ThisModule trait.
> Patches 3-12 can be applied any order after 1-2.
> Patch 13 depends on patches 11-12.
> Patches 14-15 are clean up patches and depends 1-13.
>
>     Argillander
>
> To: Miguel Ojeda <ojeda@kernel.org>
> To: Boqun Feng <boqun.feng@gmail.com>
> To: Gary Guo <gary@garyguo.net>
> To: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> To: Benno Lossin <lossin@kernel.org>
> To: Andreas Hindborg <a.hindborg@kernel.org>
> To: Alice Ryhl <aliceryhl@google.com>
> To: Trevor Gross <tmgross@umich.edu>
> To: Danilo Krummrich <dakr@kernel.org>
>
> To: Alexandre Courbot <acourbot@nvidia.com>
>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Aaron Tomlin <atomlin@atomlin.com>
>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> Changes in v3:
> - Edit cover.
> - Seperate module name changes to seperate patches.
> - Rebase top of next 20260109
> - Seperate configfs changes to own commit.
> - Fix one place still used M over TM for ThisModule.
> - Link to v2: https://lore.kernel.org/r/20260106-this_module_fix-v2-0-842=
ac026f00b@gmail.com
>
> Changes in v2:
> - Patches are now sepereted properly.
> - Removed debugfs changes as that is not so clear to me.
> - Remove module parameter and just used THIS_MODULE everywhere.
> - Made macro to make THIS_MODULE.
> - Doc tests also have THIS_MODULE.
> - Link to v1: https://lore.kernel.org/r/20260101-this_module_fix-v1-0-46a=
e3e5605a0@gmail.com
>
> ---
> Kari Argillander (15):
>       rust: enable const_refs_to_static feature
>       rust: add new ThisModule trait and THIS_MODULE impl
>       rust: miscdevice: fix use after free because missing .owner
>       rust: block: fix missing owner field in block_device_operations
>       rust: drm: fix missing owner in file_operations
>       rust: configfs: use new THIS_MODULE
>       rust: binder: use new THIS_MODULE
>       rust: firmware: use THIS_MODULE over LocalModule for name
>       gpu: nova-core: use THIS_MODULE over LocalModule for name
>       samples: rust: auxiliary: use THIS_MODULE over LocalModule for name
>       rust: driver: make RegistrationOps::register() to use new ThisModul=
e
>       rust: phy: make Registration::register() use new ThisModule
>       rust: remove module argument from InPlaceModule::init()
>       rust: remove kernel::ModuleMetadata
>       rust: remove old version of ThisModule
>
>  drivers/android/binder/rust_binder_main.rs |   5 +-
>  drivers/block/rnull/configfs.rs            |   2 +-
>  drivers/block/rnull/rnull.rs               |   3 +-
>  drivers/gpu/drm/nova/driver.rs             |   2 +
>  drivers/gpu/drm/tyr/driver.rs              |   2 +
>  drivers/gpu/nova-core/nova_core.rs         |   2 +-
>  lib/find_bit_benchmark_rust.rs             |   3 +-
>  rust/kernel/auxiliary.rs                   |  16 +--
>  rust/kernel/block/mq.rs                    |   1 +
>  rust/kernel/block/mq/gen_disk.rs           |  30 +-----
>  rust/kernel/block/mq/operations.rs         |  30 ++++++
>  rust/kernel/configfs.rs                    |  49 ++++-----
>  rust/kernel/driver.rs                      |  31 +++---
>  rust/kernel/drm/device.rs                  |   2 +-
>  rust/kernel/drm/driver.rs                  |   4 +
>  rust/kernel/drm/gem/mod.rs                 |   5 +-
>  rust/kernel/firmware.rs                    |   4 +-
>  rust/kernel/i2c.rs                         |  11 +-
>  rust/kernel/lib.rs                         | 161 +++++++++++++++++++++++=
+-----
>  rust/kernel/miscdevice.rs                  |   5 +
>  rust/kernel/net/phy.rs                     |  29 ++++--
>  rust/kernel/pci.rs                         |  15 +--
>  rust/kernel/platform.rs                    |  12 +--
>  rust/kernel/prelude.rs                     |   2 +-
>  rust/kernel/sync/lock/global.rs            |   4 +-
>  rust/kernel/usb.rs                         |  13 +--
>  rust/macros/lib.rs                         |   4 +-
>  rust/macros/module.rs                      |  24 +----
>  samples/rust/rust_configfs.rs              |   2 +-
>  samples/rust/rust_debugfs_scoped.rs        |   2 +-
>  samples/rust/rust_driver_auxiliary.rs      |   8 +-
>  samples/rust/rust_driver_faux.rs           |   2 +-
>  samples/rust/rust_minimal.rs               |   2 +-
>  samples/rust/rust_misc_device.rs           |   3 +-
>  samples/rust/rust_print_main.rs            |   2 +-
>  scripts/rustdoc_test_gen.rs                |   2 +
>  36 files changed, 298 insertions(+), 196 deletions(-)
> ---
> base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
> change-id: 20251230-this_module_fix-a390bff24897
>
> Best regards,

