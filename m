Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C947FB12
	for <linux-modules@vger.kernel.org>; Wed, 29 Jul 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329205; cv=fail; b=ISuEttsBxu1tkSTbTgOkYVjLFOKH/128ofXWUGEWbTzcdwvdJkZF20qwFIHUdnTO1Re8eoPOs196+QzNIhevOhqEg81S7W+Pmiqw9/CcGwJkKm8uOjWx6ezZx1PUx1CVh5MP2n3OgdgmmEvJDoERfh6yLfL3JM7uodg+NmwPz8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329205; c=relaxed/simple;
	bh=0S4EeOjTJTvOQ236bt6XB8xHpAihiullkRvHA5tHVDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWo7CraEGWR8DgzAuaHi10UsxYjM4XHw7wV0w43XeASun4XbffK8F2Yw2Qn0D9wEtdMmiWkBe+bWrsZPvaDD757y/wY6PBYEkW0JXgji3KolHrHbbvK2cqedBo6qR0mNj5yJfqB6Zddo27ZGPxbcwEd9SyOIUsF2Tmp3+QxLiTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMu9JlA2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQTPL+EL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMu9JlA2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQTPL+EL"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T2egRU1922615;
	Wed, 29 Jul 2026 12:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gITS9vN5zdJ8iwxwxWsiFQ+i3ZhRsypv3sNgZNE5iPw=; b=
	lMu9JlA23+88yfJH3MPmZphBDSfxjA/+YgM0iZI1ljFfmDeJYOnQjJIwY4ELii4a
	FzyvadEX0CoZsgVEtbi0DDdFYz/fXALXBsus5MS8tzkE1Qu69AdeKohf9rnPyKXt
	fWKP6CkquGQH2JJ8vexp17d9Re0x9Uvjqz/7jGlwoeOcopVoU3s49Ri6+TGxs9iP
	qodEsqLPyQs2DOIUvLnfzHFqvdn0gKYR4Akfuf/kYAHxdOOdXi84bl7IUhotnvqC
	gqyaczICIQCdYdUX58i+wBUyDHRLnHVU2VjU1RECqs3MRm/e/ARAw7lKmq9QRozU
	IwAVeZzx3QI4FTejPc3zvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5nntuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:46:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCPZhi033496;
	Wed, 29 Jul 2026 12:46:37 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6qx39x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jul 2026 12:46:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvb8FC90tiP6irs1DUKbm1JswopGBmxypkDBhxFkR3MGYtA3WQmARpNLXMP4/EPOFiV7PKCk3KucsXspAS/VzV9LY5QnbHq+a6FaacETz6RAy9itzFW1DMAIAirVv4LaYw/DVtAXTd8t9JXvj2XhFVd0EsBqrYDxIQ70U8aeGF2eFgvU/xYKWTb7WADl0zKYg9I7jlaJNitzqqqJFRpvtKa7gsusXHJ/n9vI568ft4m29XKPGJUEknj8xfWN9q8EUtn3TL5a38xxe1o4gA2K6vyMTztMHnQApaLGafMoil2TFd7D/qRS7yxJSHwkgB6ZDF8C5Q1M6k3psIp4Wjsjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gITS9vN5zdJ8iwxwxWsiFQ+i3ZhRsypv3sNgZNE5iPw=;
 b=JkD9JemBbdhPx2+3j9zGpPw4fhrTXnCiWp2dIr5Eot+b4c0xGZAguIkThJ+HWRbCcxmpEJOfmdIXF/6I+PLGD2PNIiSMm1XYkJjFeRnssr94RawUnD4VuVOkBQr8sBNbq2KEyoaY/Hs1PnRGzWsPA2i+xXyPY2tPQ28JDlSz7hICkzQwbtF/44FBhnlhtDAW5HmP11eh72wAtW/8vybCGzXqXwDqJAucilXxMFPlQjUTXsEx4CJC6V3Mho5U0CLRO8JFLy1zHm165Ixtl9M8aHMVFDQqzH2nHzHWF3cgywG5J/bXY9gXgegKLmY3ugT4M3m5wr6+zIVsJ1q2D+OOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gITS9vN5zdJ8iwxwxWsiFQ+i3ZhRsypv3sNgZNE5iPw=;
 b=ZQTPL+ELeReXeNro/jz9WAxMPt/A5GtqsB7hf8WQ/fsyrIUL9LjNmEMLQvXyfcVmuVqqxYc375xKf4S10vyQ/400trm7qpeLOW8k5w6GMNl0teBvM2tLpSL8JYuOvAGItyk1uBjiwfh2R3kbtcxbxMCNdDUVTY7qM7/0XIimKGg=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB5562.namprd10.prod.outlook.com (2603:10b6:510:f1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.13; Wed, 29 Jul 2026 12:46:30 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:46:28 +0000
Message-ID: <87908221-d205-4edc-a7bc-f05c49c7d698@oracle.com>
Date: Wed, 29 Jul 2026 13:46:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: About THIS_MODULE
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
References: <610fc63b-f3dc-4824-99fd-907fc96f3194@oracle.com>
 <79bba1c7-01f5-48ae-8b0d-07e4dcf0127a@suse.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <79bba1c7-01f5-48ae-8b0d-07e4dcf0127a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 09708d20-a693-4ae7-bdb8-08deed6f6854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hoPz6iNDECm9wrjCK95SP+ONjgP2OWUwKOZj/SK3HrRCzAbxUCTqshUoxUSscBxBtoecxLi/BZGzuyWB7FI96HBewVH/fuaE7pGjdCYr9+nOHsdmMvIccTn6N0Ib39lnpUIGSaZ9ZX3/N7R7ZMKR97ydkMG4EUC/wqE8hCC4SjMjEoEzSkZ2plB3HSbi+TUXogdGZnYoFKf2YcSH5aT3epoHulKzvWRtU/ZU2O4dodaL1sfk4qewLoJFy+9K3NDJQ135q9V3podH1CaYpx0reRIjNGwbSidZDmp+gHyoB/ou22Gcb38DdUChpd9O4xfRVA5g6emKT9x/5AE4IU6Q45Cjg0lk4hhUzHR3csP3Op65xb1nqSLKq92kGvOXsAmLcfECFXC8zKjRSTL0IxtJNXJmBYV8pvBojp/TdRyjB1bWTxRtcp6S0UtBhCtau9wv+KP8wMIy04vVSShwoGWJnSIDx0pVnGBiFDcy6u/MOsjFqRnN00YidBp6h8ExJNJ6cbxNQyy8UzA9Uyxx+FSNHNibaD/SZEvFgu1wH92xt2p9XzTlIazLt/Jemo4IU5H7Gl1b0OHKBF7BbvfgmqgedmPyUFMrC4GDfFSRnzFsPXcF0dKxuXWYq0pjJPlXXbfAhIVgy8hn5caxab1crZvW0uWq3dzwlE/wIddcIXsg2Vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnFqMHF1UVBWWVVtcU8vV0lhbzUzdStQTURsRENkMTgya1hiaG5MZTVFckdS?=
 =?utf-8?B?ajNxOHM4QWtBYUVnSmI5SEg0Tk9icjZCenZrMjREelJia0ZTdXBYcWFEMzdC?=
 =?utf-8?B?Z2RMdGpRaE5qY1NaTEZKcG9UMlhJOTd3MjNaRkkxRy9YTGQrYzE5Y0hON2xX?=
 =?utf-8?B?dTdQYWU5SGRPWVN6SFkvdklzQ0F3b25lNzhab2VPMytzSW02M09lU1ZWYU9C?=
 =?utf-8?B?Y1NXY2lvc2ZjZ3E1bGg4dFdVUzVRNlVyNngxQjN1RjBIOTM5WjZwU2RjMllO?=
 =?utf-8?B?ekNWaGYvYktJRURPSlo0d1dmSTRtWTFVcXpldTNsQTVsQm15dmJkVEFZOWpH?=
 =?utf-8?B?V2JwWjRoRFdIM0Q3cnlrMGVoZlpjRTQ2d1dZRERBQ1FPM2FyOFlCbnVSaHhD?=
 =?utf-8?B?b1NxbUFTV3g3N0IrazVZQzgzVlltUVpGMWsyVUwvMFBRZHBUYkx5U2lJUHB0?=
 =?utf-8?B?d3hFMWRqQXRjR0wzY1ZIZUN3a1B6a0hVRldlL09DTE5WMDU3UFZYNDJJSXRL?=
 =?utf-8?B?WDM2bnRIMUdDNGltN3R6cndRSUFNVFJRNy9BNXo1RVBQL2JIVlRZU28xQWhV?=
 =?utf-8?B?Uk5hK0dFTkRSczYzSVlNQWZQUlgxdzhycHhJOFZMY1YyaFRvclFyb1Bmdy84?=
 =?utf-8?B?VDNhaTBCYXZDK0FieVhDNk5MWnFPajNtS3BiR1N6eGlZbStRbGZzUW9ENTFR?=
 =?utf-8?B?YkNObzZIZllEOWNEb1hGOUFUUzZOdHFacW56YUlNenlTMFAzLzJ2UUR1c2xB?=
 =?utf-8?B?RzlSY1hGL0Zjb3JWcFZWQ205NFViQnF6WHIra09kWHd5bG84eHpzQ2FGYitM?=
 =?utf-8?B?cmI3SS9vL1U1ZUI3R25pcVgxamY3dXhDZkJ4cXNZTzBCd1QvdEd5bzNRZ2lV?=
 =?utf-8?B?NldPcC9jaXRTNzdNdGVzN2tlV095bmEvcnB5RVRMVEVDcjF0RklpRGpDbCtB?=
 =?utf-8?B?R0ZuQU83YTdXRzJudlVsUElPdWtkV2VxaGVTRlN6N0EwZzgva3FJam8xdFFY?=
 =?utf-8?B?bUVXZjBIYVVDdE5BU21WRTBGUUVKT24xdnlEQWFVWXNpbE1ad0tDOThONWVq?=
 =?utf-8?B?SlRRNTVpdHhRS3FZM3hBdllTanEwb1UvT203cGU0T3Yzd3F1ZlRBSWJpMWtE?=
 =?utf-8?B?L1prUlE0V0l2TGNqKzdUOStNclhuUTNZekNrVE5oQUxsTXJ1L3UyUGdra1ZH?=
 =?utf-8?B?U093Y3U4OTIrRjFSRE5kMmh2UXlyQVF1MmFzaUFvZ3ZZc2F4MkttWTlnMkVG?=
 =?utf-8?B?VDg0aXBlL1BQVDVqazhEZGpudml6cDQ3dU5PZHY1dzNGam9XL0p0Qk80WHFm?=
 =?utf-8?B?SEtJaG9zbFNiSjVZOHNqRkFLTjB6OVRycEZiWVFGY1RyTFA5WkFyR3JGMlY3?=
 =?utf-8?B?Z21QTWE5YkZQNmF6ZVVLcmRsS2FXcUNoMVFVSjlCd1hJRmZTT2J2Qm1heitP?=
 =?utf-8?B?elJabWVpUDYxVGRWelVBbWc3YnpGZWZCTUxmZFJpMys3Sld0bkZqSjk5bnEv?=
 =?utf-8?B?c1NvRlN2ZmZZQUtYdDlnZExFMjVGL1RVaE0wSkVZNU1MRjdBSzdreTNkbWZq?=
 =?utf-8?B?UGt5OTJyd1VhWnFlZk41eklDamF1aGNJUDUxMWRuYlAxUTZaUkhjbGpNVUZB?=
 =?utf-8?B?RVVwdjhocmpablFxTGVUa2xKbTNwTS9MRHRXUjNiQ050WXVDZk1XM3FaSXBX?=
 =?utf-8?B?ZGJjU3NjQVR2RkVHSlVWakdpVDB4MzFHcVJOK1dwekh3WWQxYXJURWtROFRO?=
 =?utf-8?B?U1h4bTBxcVVPQTJ3RExNK3ZkNmdZRDVwaUJyOUlBWkhONEQzbHM5SlJFOTkz?=
 =?utf-8?B?RGNMamFJeDdvdW5zNmZHNTlXbHYzYzU1eE01REo1Z1ZLTUxTVTFVVXdNaWVZ?=
 =?utf-8?B?aG5EY2lHMjAzTkxSZnpKM0t0UkdtaXBvcWlmREdxZUhaTk1qYnQ0YzhsMFJt?=
 =?utf-8?B?ME1xanRqSVhxdUZnY01MRHlKdmtidnI5MS9LY1BNK3YwQjJ2VWE2ODZySWZR?=
 =?utf-8?B?dlErTVRkSE1HVlk5U2ZuOUtTVExsa2FLRUE1b2VEbTZGR014MFdtSU04eU5D?=
 =?utf-8?B?NDdjNHE5Q2ZFdVZLWEsvYVMxdUIvZU5HaW9XcFgxZ0YxOXpybFViSEJmRXRU?=
 =?utf-8?B?V3VHZ0xxY1IzK0J3MEJHVWxWY1h6b3F3SnFCcTdxVGkwSkRWRTdKTEZ1a3d1?=
 =?utf-8?B?K2V6VlkzcU1INGJOM2dhTzJaWXh1Ykt2Uk5ZaTRsNDMrTzVicDFDMG5hSXJn?=
 =?utf-8?B?NGwzSzU5bjluNnlteXNud1V3aXltUWpSd0dXZGJ0R1N2a0JldVlxcGxXaVFi?=
 =?utf-8?B?NjdqVE00SnJWZHNRN2U5WjNCSFNJbmdvVDVPMGFaS0RvR1JUamtsNGVXblJm?=
 =?utf-8?Q?0zj40GfZv9/MSfxY=3D?=
X-Exchange-RoutingPolicyChecked:
	k3P7Y614s8wDSnIVqbQkypkUCGG8Kx1AuGxeuoEZZmEB0edz5MZXyhvxILLOIINDC1X5OidJF3lxjVXMJGv3tkG82+oaUnBHE4a6vPTJywd9CNrBxob7+2t7Dg8m9lGpR1F8LIU2OGvJrfOeWO8tnRuUJJYLwzPWILH+CckVR+KrGkE9fp7RtxZP7R6ur/TNJsPC0+SWLPypJnBGyDYuLvL4CLxZFIzZnZS/gYBNyjSUP4ErnmpXSlExhbDNKyY3JTFzqudRFmSUnoNdFNkCi3Q82AxTDX0qYTWIkrccC2s8BCMue1VrdgWmvIS28Gq4i8esrVZyJhOfCGEiYaD8Qg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WV4BLFl0oxT4briSuUrIX7lToW4p8SM/Z+CHF0wuv9vHwxqVn29vTCqJRsBLs6WUzjt6lsjhRld95/hD0DalyRwi6/NwlNkqNDqva25PCJszwuA7IN2CaKkd6AiCmH7AEzg54c0GU0hD9454rQQVR80j6jUc+VCqDDJ7RZ+EU9/tFOQpzYZJdIFR64+SA0alk8TllBhwOUqqNKU+Fq7Ll/ys66asvJad4pm5r7DigxpxuP8+3QoNTe6HYKWgnBZKOUGGaDNLv33m8Ssyb0ptMrpPus0A6GA3fCfIPTQaENYNjGM7u2NBkIV+hU+GMSTPqWwFHFWs36hgYBndRbKPDjl2ikK2Xv/G7Z1pg4qA7Q+kF7EExmUMatKAU56hAcInrw8I1Y1ElVEOUyAUSIpDxt1C763jNaNDT+DGgPMhkXMz2hHk6Lz8z9kgvTE4I4pgrx9MbULxKhHRGT8GuT9CHlXu8172LQWJxqT4Fn8aIreAmicIvs1ikAZWR3pviCjtzGRkLIFgECuI2SHI0ETylCvljxgO5onssOmmReIZ3LgkP0YUqQbDBmdI12cjPgPVYa/3mxjEvARfb7mqfYhjSx7/7i/mJSlmxCQLp9AfvDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09708d20-a693-4ae7-bdb8-08deed6f6854
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:46:28.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTUOC4bN7mvaWlOhGXQGhe8nlyKnh9LS7uXlQElhAyYgFpF/xDR42nWzYjCFTEXEALAS0yEXWERVFmLq8vCS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607290103
X-Authority-Analysis: v=2.4 cv=OPsXGyaB c=1 sm=1 tr=0 ts=6a69f62e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=gNw_Am1gX_56xKalOfYA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12106
X-Proofpoint-ORIG-GUID: jUlpekhrIrQniOu1e0h9aJ6ue2dxNXeJ
X-Proofpoint-GUID: jUlpekhrIrQniOu1e0h9aJ6ue2dxNXeJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNSBTYWx0ZWRfX2659prAELiKh
 Nii3FlM0+EJpQULyHIS2fl7asen731HmVy1T+VqVKGmFbuMoUOAjv1DYzSzN4fOOGXhySO8lQ65
 P72Mg+/3iVrvqSjz4nwhzKtDkhGIh6v7O2g1YTs83jJkD1jZBqAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNSBTYWx0ZWRfX/8g92Cd4E1Ej
 3vfU7bYUjqPo9z48ycDKc5Ye8HM/uOGg4V1HaZc08bLjDYBGMfGQPUnrEXwtnuoU5IL1lhamH/Z
 Oe11FlU8MMKZrXMMTRuftoAKq4bKe9Njx/+OtQpbqtCT4qeND6z6F2cTltfXwBuUZRvwiKwoE9b
 x4D+JdWHJEw+OXaI0SAJNb0s6Jkc/Vg90Ct4FMDfrvLpMphah5CYtiI9BZt54nDzActlq79Dk+4
 rHjJJ7kgyTRwQc04wcYVxkAPLNeevtWIzs/ulHPGngqexBEPwv7vOB1Gk0hZrdqyf/M3Hf5CbG/
 cpJDc6kSiojNoh2LEW7gJZbP6f7hjCv+1NQRNis40xdMy/DVM6Lc2wL5U0l9Nc7y9uCk5+jhEhY
 fonGzKA6j+hONxF88aHvWLJhcUIfU5oYxruZ05zY/eroJlJhV/3/z3gNnvN8y37zbCS6UUBzF/p
 u8VExw1VJGpAQd36Dj0N1X2B6oj1tO8AqRXnci6k=

On 09/07/2026 15:31, Petr Pavlu wrote:
> On 7/3/26 5:33 PM, John Garry wrote:

Hi Petr,

Apologies for the very slow response. I only noticed your message now.

>> Hi all,
>>
>> I have a query which I hope someone can advise on.
>>
>> I am adding a library API which requires a driver to pass the driver module pointer to the API.
>>
>> So we use THIS_MODULE for that purpose.
>>
>> However, adding a sanity check in the library to ensure that pointer is set is a challenge. Normally we would check that the module pointer is non-NULL. However, for a built-in driver module, THIS_MODULE is NULL, so rely on the non-NULL check.
>>
>> Any idea how to deal with this?
> Right, a NULL module pointer is ambiguous if you want to distinguish
> between these two cases. I can't think of a neat way to handle this in
> a library API.
> 
> One option would be to rework THIS_MODULE and introduce a reduced module
> struct also for vmlinux and built-in modules. 

I was thinking of something like this:

init.h

extern struct module builtin_this_module;

#ifdef MODULE
extern struct module __this_module;
#define THIS_MODULE (&__this_module)
#else
#define THIS_MODULE (&builtin_this_module)
#endif

main.c

struct module builtin_this_module;

bool try_module_get(struct module *module)
{
	bool ret = true;

	if (module == &builtin_this_module)
		return true;

	if (module) {
		/* Note: here, we can fail to get a reference */
		if (likely(module_is_live(module) &&
			   atomic_inc_not_zero(&module->refcnt) != 0))
			trace_module_get(module, _RET_IP_);
		else
			ret = false;
	} else {
		pr_warn("cannot take reference to NULL module\n");
		ret = false;
	}
	return ret;
}
EXPORT_SYMBOL(try_module_get);

All the module APIs would be need to be able to handle builtin_this_module.

The issue I then see is that other kernel code just relies on 
THIS_MODULE == NULL for builtin or forget to set, like:

static inline int netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
				     const struct nlmsghdr *nlh,
				     struct netlink_dump_control *control)
{
	if (!control->module)
		control->module = THIS_MODULE;

	return __netlink_dump_start(ssk, skb, nlh, control);
}

Cleaning this up would be too difficult.

> However, this isn't
> a trivial change and I can't recall a case in the last few years where
> this has caused a specific issue. Additionally, if someone forgets to
> pass a module pointer somewhere, I would expect it to be fairly easy to
> detect and fix.

Removing modules test coverage is not generally great and that is where 
we use things like try_module_get() to protect - but it only does the 
proper job if the module is properly set.

Thanks,
John
