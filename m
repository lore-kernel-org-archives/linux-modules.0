Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021126.outbound.protection.outlook.com [52.101.100.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D2224891
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111016; cv=fail; b=Cn8Q5W4BzOHE0dGx28XxYxkV9pY/PMrq1prjcuKB0bPqPCEv5JwLFjVhRs2LG97G+9NOvjay5joVPJDhc/BY9kPjZWA5VL7hpUV6ESbM0dgpqOBqV26GG1XPLG/aYcM/AZDkXhNR90R2BEsssInV3pvCkxJrDwIG+yUb/DSfYmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111016; c=relaxed/simple;
	bh=BGPesFQD9coig0Q1v6avpfQ+z6trGHHTgd+YcIepmIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqZ4ko/p21Vvy92PozohygBhAWFb+4f9O3ln4fc691JlfmMIYkM/u5K7QYW7uGwlNkqzjg4UsQ8FD24IklbRhDCkbS3DMrNd6S6KEHFMQP7DrTcFEJZ49oFIyMZcaLhv2JsbN3fa5EpGxmMT6JlGHdXGgC46eRwjsbNpnmpUEOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNN4gvrSdHLvQIqN51j/4zFV0oEDGs261jTH/7BXxRFshyDFEUeeQNF9j/xh72PnSQTE1pcV/WxleS7RNu+/qvHf4tunUDT3zhLUsxHHBqDDEXbNB9kxoq4yuYDqW2GvTKG9vfTj8N4/WF3ksdnRyUlzGmb2mwttZ+cOIW6YzWcL82MZT9med2mc3Oa2WO4rmbq2IDVRWHRGPcNEBdP/EhQp/vD7FpKzcVx71uIp7DzITbwk9gbM20EI0qMGRQK3MX/XKBTeMvdOhOjZWWabNe9xBndIc0dPdnGrcb+/Up9iYxTeXXc0Dq1YXnFve/Vz9iacz0wB99txdUAd7Zse2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJtnjEPtlxtso4fKeDviUt4KUERa7o36Wn3nSYzMlE=;
 b=kLN3p2w0yfFJaxTDS8uNfkWOZBc2sRjJ7EoaoSqYlHNHf9gvVZr7TGGKlXkoKnb9jvjOSpg5QP+LsXUUuNIaGitoSYFI9tvBa5X+RULoifdInUSpqT5OEs18Qe4NSTtwgkG/ghuj7Z5EJLMKFstYPbwo4g34gPu09ywXCUoLS22wGb8E1VVo1/sJfLL2Dez6+B5APciyICpHjf5nhZZ9QIqr14hBJUacjme/7kY/24agpMSo1v8pq15zPf4q2PupEvw1Gc8OWDB02fU+UdZEg6zqGfp6qX/D/Vq9UyIPw+Hf31rB+RYxL9yFJqLC1io60kIz3MbkNd+xpxZ5m7QC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 16:10:09 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 16:10:09 +0000
Date: Tue, 30 Dec 2025 11:10:05 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org, 
	da.gomez@kernel.org, samitolvanen@google.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: show module version directly in print_modules()
Message-ID: <ydmepfnm647kpwuiv5a4grvvdmuntcmxknowa3nf6hnx4unlj5@5ne25xb7e46k>
References: <20251229024556.25946-1-laoar.shao@gmail.com>
 <971b1fd7-5702-4cf7-ba84-aedde0296449@suse.com>
 <CALOAHbBF_Q02amBXKh_iGPepp_-CbF91a-HAXa3pSnO4qBnX4Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="age2g2poataqwmvh"
Content-Disposition: inline
In-Reply-To: <CALOAHbBF_Q02amBXKh_iGPepp_-CbF91a-HAXa3pSnO4qBnX4Q@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0594.namprd03.prod.outlook.com
 (2603:10b6:408:10d::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a93e173-e4fc-4574-e575-08de47bde76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHNublNZS3pYbWs5MGJIaVY4ZlZFenB2SW16akZBQmRHZkJWdXN5WHJwSEhG?=
 =?utf-8?B?eHZJd2IrV01CeHZZekR2VWFObVFtL21OZkZFOElaL3JaYVgzcEN6V2o3NEZB?=
 =?utf-8?B?MmNtZlBBWUFjaUxNQ0hqbWpML1FMSlhoWVBzZUttRG5vRDM4Nm9kU2dNbEVM?=
 =?utf-8?B?S3FwMllaMmlFSjQwNGQ3dm9xc1JyNVpYN3UwTG51dFlrbktGKzZMWmVuT0tL?=
 =?utf-8?B?RUpybXNBbXJQMEgvcGozK1RBd00vMXdoYksxY2s1RDRON2d5NFZRZGlHMTNQ?=
 =?utf-8?B?TnliNytMK04ramtHbVk2dC81WnpMdmtCVy9Sb01LSXBKVUh0SjlWT0x5Ti9U?=
 =?utf-8?B?NWxaRXRKWXBKZkl0NVdsZmpJbTEzalNSR0R2bW9BRUtPUzJhSEoweUN5WXBs?=
 =?utf-8?B?bEtmVG84ZXowWXhtVXJqQlR3c3RKZ1dBREx4Y2dJNmJldkxXRmlQRnhZWXdY?=
 =?utf-8?B?eENxalBOTC9OVDAzc3FWNmlOcVRKTER6UWJyT0pnNjM4ci9PZUl0NFNGKy8r?=
 =?utf-8?B?ank1aU1UYS9HdSs1WTlXREROc0hTOHNHeDdHWW1XTUhsQXBaYUFZMVlNVkRL?=
 =?utf-8?B?aFVENEVJdlR6REJ3MmdrTStWbXN3WVNpNGh0WGgwc3E4cUhBR2piMlAxUWRi?=
 =?utf-8?B?TjVHRUlxYzMrNGRwZEpiQUZ0MXRWQ2lCV0U0d21FT2xWbVB6SGNvT3lDODM1?=
 =?utf-8?B?SGZNY29LcHlhbGNURWRudWpCZ011dDhPdk9WY2pNOGlsNW85YzdCakhJdDFl?=
 =?utf-8?B?eG5uMTdrWGw2VUVTbXN6Q1l5THBXcXFZM1o4UkJmNFUzNDJQQ2toMlM2Q1ZH?=
 =?utf-8?B?U1E0d3M5Tkc4OVhnMnM3MDBVamZKaWFESkJJdzY2QndZTEVYM0oxNXdSQzVG?=
 =?utf-8?B?bFF6d3A4NkV5MTh6cWdxelRhM0IwZzhSMTFVTEZWNzhEcHcrUHhVVmNDWEV6?=
 =?utf-8?B?V2VQTG5XckQySVJyN1F5KzhNYmJzTGsyL00yUDNNWUs4VzJYT2FJTVVsNWNW?=
 =?utf-8?B?SU9UTzZHVld2SHZRUXhKUE9Wc3JvT2FkMjF4Y2pTUVIvaTQ3ekphZHJsMExv?=
 =?utf-8?B?UUJEc2RaSTNvQ25kU3RFU0hyTUVZZEVnMkdmOWFvc3cwcXhhczdwcXZXNjd3?=
 =?utf-8?B?VDBPMURQYkdEOThERTZ5RjNOdy8wOE9OZzVtem9MT2tCeE5QZHlYOXhnRUZQ?=
 =?utf-8?B?cVZTZ3M1K3JvcXBFR0VoTTR2NlZHMmQwUENQYXpUZ2pkbXoyUHRiK1BuQlpJ?=
 =?utf-8?B?VmhPNy9MRklPK2ZrMEh0R2NnVVJSa2YvT2JoQzBrV3JIL2ZTQzRiS1NoVita?=
 =?utf-8?B?OEYwK2xZRzZ6NGVGa2VtZzJCVlp2QTBGdElzSElYN0xZMllZT2NJS2pyblFU?=
 =?utf-8?B?RTNwb3JaRG9qTjF0Q2xGMzVCeFI0MG5qdTlyUFpQeVZYOVl5U0dSL2lKbGVi?=
 =?utf-8?B?SnNlTGpwRUdvclcwd1BQNmRZQVJjYzJ0STRST0UzQXJvYU9JQXV5SGRoK3d3?=
 =?utf-8?B?SmhNR0s4cXlDZnQ4SzJjSklMYW1xVWVXa01uZy9Nenh0NVJmajU1TkFyQVhq?=
 =?utf-8?B?d1ZtMjVESHRyQUVWRytPTm9wNVJ4STkvK0doRzRKdlpnMEQ4V05ZQjJZMmkv?=
 =?utf-8?B?QlJqTTF1WHd1Y3cxYXFGT1lFT1AyYmVMK2U5SDFkQjh2cXFIekhnN3lYMTRq?=
 =?utf-8?B?b1BnRDc3Tmdqb3IzQUhudFVhejNla0QwREptZDVsUGVkcHVhR0JQQ254STlj?=
 =?utf-8?B?ak9MWUl5VjlHNE9NT0toc2VYS0E0OGdmRnU1L2VWTVMvdmMwbUVQa1FIY3pB?=
 =?utf-8?B?cTlNTkduQXRTM0NxOFFMUVdsNnFPU2FtbmxmN1IrWFVTMFNUellydXlrWGYy?=
 =?utf-8?B?MmhLV29BQXQ1L1ZJcU5SaWE4QWtaQnpHeWdlbUN0VWtyMDZsSXRjNG56a3Fu?=
 =?utf-8?Q?iCByq8gWKBhuIadI6NLJm4spVQ4ieJY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRtajlvVUk5RzNPRmVyblBmaGxsUnBrS3pOSVRMSHI2bllCWDhzdmxBTkEw?=
 =?utf-8?B?SEpkWkxORFZ3N2hWS2dWbFRaVVVRWjRORE1mTjlMOUZGekdGUFFLUFRUVm5W?=
 =?utf-8?B?dDY5RnBqRU1jWFJINjlSdVpXSWFDMWxoN1pKSEFVbVZHbWNhc1hDeHAydHZj?=
 =?utf-8?B?SjZqbXR0ZThJQWNnUE9URkZmWGJDK01RTnJjNFpHclZYZ2Z2ZEQ0aE5BZFln?=
 =?utf-8?B?aDRRY01QbWYxNGplTThlVEdpZVRmMExtZkFERzM2U0RGbXBYOXU2c1lnMFlx?=
 =?utf-8?B?R20rL09SVDNvNGg5VUZXazJwWmx0QmxCRlJraFd4bVNybFlTMWxNUHRmNUNy?=
 =?utf-8?B?bFRzam1adCs0NFQwLzdrTnhDVE90TjBIQ0FtWFVTdXVvcitvSFZKQ0hZeUM3?=
 =?utf-8?B?eEtpZW5tWmpld2tmSnlMcEdyVTh1cFpYZUZXV2hYNzFwakZHMENXaEpYdUdY?=
 =?utf-8?B?K21TT0VUb1RaUlJxU3psQzVEeG4rbS9ZanpOTkQrUkRoRGlMUjd4T1FPczdj?=
 =?utf-8?B?VTlpa2NXRHFVWlozSnAwN0x1YWJNcVlTUUdaWnpkbW5xV1ZUN0NWdUJSMkNY?=
 =?utf-8?B?RmRjaW1LRHM1TzEybHhqb3ozaWgrQmJhR1ZZZnRFcDZLZExneXUwLzkrKzc1?=
 =?utf-8?B?Z0NBVENmSHk1NjZnTkZRNTdHYWppbEl5TmdEandTTUdNeUFSVlhmZVJEOUZG?=
 =?utf-8?B?WC9VK21ROTlDRlRBV3pIU01TTWtXMnI5d2UxOFMyQW5hUXpnUitnMmNaSGdH?=
 =?utf-8?B?V0JqMVY2WjRMb2RDeVVkeTdRL1U0OFFpUHlCekZGMHRreHlneFJtejNoMmNR?=
 =?utf-8?B?YTJ0aThBQUdqMk55R2RHUUI2NHNpOVFtdDFqNkN3M2ZKaGI0MElWaFJyOVVM?=
 =?utf-8?B?VEdzM290Q2xkMVRNMEtlSG0zblZFc3V3dVpPVlB2SDY0bis5bEs2dXRjV2s5?=
 =?utf-8?B?V1ZueFpIeWg5QkpmRkRPZnlWeEc2L0tsQzEwaGJON3p3ZXZCZ0hKK3oyMUli?=
 =?utf-8?B?VVhtbytZc0FVUE82VmpqU1hPYWlWcmxGL3pNVGRyZjZpaktxTnJrc0xETzR1?=
 =?utf-8?B?QXRtTlFuTzQvckluc3hKUW5yZGdjVHRGbTErMVVqZDg5V3hBQ3BIV2dUaWx0?=
 =?utf-8?B?bmF6T3kyZHMyNytCZ2xmV1VCbFdaOEgwRXBocEJiVFNwTGtFaFlNVFBFQWRw?=
 =?utf-8?B?ekFBMDU4VDRUTFB3RE4zajQ0MkwyNUJJSllFT0dlODQwNDA2TWRIeDFTckNS?=
 =?utf-8?B?R0Y0UlBPYnVXYmM5eHZPM2ZQeTMwWVNhMjZsTlpGMlNwUTUyRzBxeEZRRjA5?=
 =?utf-8?B?Rk9tU1kzcXFIUnZyL1JrRW90ZVdqVFpKY2RrY3NMdk5TTXZmU05QUm1qRnBi?=
 =?utf-8?B?ck5GUTJsYk9IK3lSNkF5REZRbDBBUEVLNDJZbC9TcFFWMko0U2hrazhBK2U1?=
 =?utf-8?B?QWFhajRwTzFUeDR5SzI3b3dyeWdQd3daS3VHS21tOUlhMklCZDBmQVd1dXJo?=
 =?utf-8?B?dzlzUmpGUGpCcW13TkRITm1XeVRzOGVJSmMwNVJWaWkxOXNXR05XYnB2dkFq?=
 =?utf-8?B?a0xtUWR1VEhvM2t4SGI5N2VZaE93OVdFb0EwaDVCTHh2UUtERytPZU1KSnRM?=
 =?utf-8?B?Qk9KSjlBdzlCNVVsTWhNeHlYKzdoVGFoOTYzY1JTYnFnV0NkRjhSZVdOdldD?=
 =?utf-8?B?N29mVUUzbCs3b1VBeWF4UWc5U1k1c1J6SVhRZjVSN2Y1bjJLdTZ4a2dsTysx?=
 =?utf-8?B?T2ZEVXVmSGVJTjlwWUxTOFJESE9Ka0J2VW8rWDl0WnNQZUlhWkdPVXh6dVdn?=
 =?utf-8?B?cC8wV29RdCtHd3BXeEdtR3RnbzBaZEliY291blhLQXZpbFQvWDBCa0RQUDdC?=
 =?utf-8?B?VS9SREpkYzVSOHF2UWtqd3prQ2tEbmpGd0haeDRYY3A0WWI4VUpibTFQclZB?=
 =?utf-8?B?K2d5bWR0eFBxVHloK2xqTzBNeHJaZ3dKTVFjZEVjL3ZjQVpQY3EzenNKMlVy?=
 =?utf-8?B?MFdnbG14a1VETFp0bUhzT2REaGRTQVJzcGFzRXZoY0hjRGUrbUtGZElGRTBX?=
 =?utf-8?B?UW9EZ0I1YmNGS3BHRnkvcUdTWkRMS1dXRlRSeVVvOTVobzZOQi9sUy9YZ0Q0?=
 =?utf-8?B?TEFWaUl4MzVwMy9GRkx3dERrV2hPUVFvMGVlZmljVjdIRzJSVDc4UzBXd2hO?=
 =?utf-8?B?WTBQYnF2MWtMajJlbnc4cGR2a3BtN0FDaGJlc3pZVE8rZFg4QzJibkNBaDM2?=
 =?utf-8?B?YTNXSVNHTnF3UGNaVDdVSWNsL29UZDJoNGVEYVdaVXlEMThpUFVXT0JNWHVN?=
 =?utf-8?B?MGV1Zjd6bTEyQ3duYTJJMUQ3K0g3b0VFQUVQQzhmdk9Yd1Qramo1QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a93e173-e4fc-4574-e575-08de47bde76f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 16:10:09.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcn6nkllU3KssyOCXbE3OPCiHybtrJ/5F6J18Elq4tBnkRSbe/KtWmqexUa4xtVoq+Q2XioMcowS5NINe6Q/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

--age2g2poataqwmvh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] module: show module version directly in print_modules()
MIME-Version: 1.0

On Tue, Dec 30, 2025 at 10:12:09PM +0800, Yafang Shao wrote:
> > As mentioned, most in-tree modules do not specify an explicit version,
> > so in terms of bloating the information about loaded modules, the patch
> > should have minimal impact in practice. Alternatively, the version
> > information could be printed only for external modules.
>=20
> Good suggestion.
> I believe it=E2=80=99s sufficient to print only for external modules.
>=20
> Does the following change look good to you?
>=20
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3901,7 +3901,10 @@ void print_modules(void)
>         list_for_each_entry_rcu(mod, &modules, list) {
>                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>                         continue;
> -               pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
> +               pr_cont(" %s", mod->name);
> +               if (mod->version && test_bit(TAINT_OOT_MUDLE, &mod->taint=
s))
> +                       pr_cont("-%s", mod->version);
> +               pr_cont("%s", module_flags(mod, buf, true));
>         }
>=20
>         print_unloaded_tainted_modules();
>=20

Hi Yafang,


This refined approach is significantly more palatable and addresses the
primary concerns regarding log bloat. By gating the version output behind
the TAINT_OOT_MODULE bit, we strike an excellent balance between
operational necessity and kernel log cleanliness.

=46rom a maintenance perspective, this is a much "tidier" solution. In-tree
modules are tied to the specific kernel version already, so printing their
versions is redundant. However, for external drivers (like proprietary
networking or GPU stacks), the version is the single most critical piece of
metadata for triage.

The logic is sound, though there is a minor typo in the bit name that will
cause a build failure. Here is the corrected implementation:

@@ -3901,7 +3901,10 @@ void print_modules(void)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state =3D=3D MODULE_STATE_UNFORMED)
 			continue;
-		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
+		pr_cont(" %s", mod->name);
+		/* Only append version for out-of-tree modules */
+		if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
+			pr_cont("-%s", mod->version);
+		pr_cont("%s", module_flags(mod, buf, true));
 	}
=20
 	print_unloaded_tainted_modules();


Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>


Kind regards,
--=20
Aaron Tomlin

--age2g2poataqwmvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlT+V0ACgkQ4t6WWBnM
d9YeaA//dcd25F+glqk7Jc7fjtZd8BtSAdPRAXQ2xu2I5R5UrcJO6ct7EAn3ocU6
MOhabeoDMYe8+IbucbR5LHnyQnPnR9UrJb3yLnB5QNQlrPiLqPHp44T+GuMPDIo+
ZRPKLLX+H46W0+QNTwuIaIpM9BzR6kYDvAadeRD6VOo1H+GvC1hSxcippLADUpRH
mIZziiG7bqx7SH9U0P/Te98KzrrM+qT5+560VDEvKqHKIM8BpWnUFLCILVCUcbAc
FHOKni0aa3J6aFVV4ZpCax7coJYQGskanAUh9z8mpsF9PSub4bjbK+EutKok/1kz
8MuYmAqOvw8IcIpgWkDY+YmGZshxH9fwkMXlpe8uM7uPgGIdknqPaNZ2e/hAMpQh
D06GEpiUtqy9H3kRU9R/+BlMT6SGszj+kWsqVagi5SgKfTJdqLWDiizZTazNptiA
grnoIUBMSpxZQbpheYJCTisq/o443mwRjQi3PMb9laVY3MrAKGH/8ttuEvaUCiNJ
vfMIXBMmLjX7UfsLI8gim0J9feOeoHYp98hjtaM4CgUP2NKseFNNVx2ZzynuUzny
QIn4XybaMau73Wn+whrNoNTKoRf0u4S8XDB+ykEm9PJrCfev4yFSIMoqBcYFU18G
313tL2h1KyxzlTwOumnJnyBX97WdZSgYI0O3Ey6KxMsUcJcR2+w=
=12by
-----END PGP SIGNATURE-----

--age2g2poataqwmvh--
