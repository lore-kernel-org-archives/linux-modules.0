Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0C3CF1E6
	for <linux-modules@vger.kernel.org>; Fri,  3 Jul 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092870; cv=fail; b=hPCqcT6X5UEWe88fKpGntDDGFGHE91wp6PyJQZKO3XAEap1OAuKa00VK7t6aAZ6xe/AL6x5H4A+bJVZ5SVdfgte7A3sAKFMoz1AISx8r/Aj1nt7z/DAnkMjr9r4JYmu0lWqsUK4F7xiLuFzy8C+rUXJIf7XrtIU63g45W3pqPss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092870; c=relaxed/simple;
	bh=noM6jsCPxUI8a7KGDKL4ZcLxOt2r5fBmTOB1ZWqKFS0=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=cjh0SGaTmJXZddG6mSjbAvxnkfCNnY9zlejsg25KxfEIdi0CHJ9wT35NAleNKMVBqmzSG51XHYEOKSk39NzUWn+iU+0ZKeOcRhjqnD/RYYKKYo2ws7wNs/qulv26/uhltlAa/43IOGxyZXxQg2NK23uDgQ413YevnBa6poOZZo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KI3YddCY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e5h3mkdv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KI3YddCY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e5h3mkdv"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Eam3k3953044
	for <linux-modules@vger.kernel.org>; Fri, 3 Jul 2026 15:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=IaM7pnFkaodEO82d
	hV4xI2+3+sceKIcl84oVv+4BX5c=; b=KI3YddCYmZCuwLfl87gHWy5elXZ7zkW5
	jJa5VtzSClY3Umw77OGg1qUo8YGMaXOvpVJHADyi/pPCeWhVu9kh2TjMxTV0eLhz
	QJpSmulj1UPR2JoV4aTs9Di/fEGEZEA7Yuci5L5l9+CXNsQ7P5uZnbEQjnnympma
	pkL+XrLm46cRKrLWt4hayg4Ye+KWqSHB9wAqpUAjq9N4O703Lxqd+5RWrZqPArFL
	iklQZsEt/NAQdU2Z0cRQ1SZLsZ0FMtUiP8QmquWQzlS4MrTPui59R2Vt8BQTAMRk
	0y3kMPIKesMZXqG3UfS5SSPIc7VymFci/wT62ig4/mHmjdls0Ge6JA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p8u8jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Fri, 03 Jul 2026 15:34:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 663FXaK2019138
	for <linux-modules@vger.kernel.org>; Fri, 3 Jul 2026 15:34:27 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yuj9vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Fri, 03 Jul 2026 15:34:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF82EEdBVtkQ/E6odWiFq+1MzOX6yA0ZS6upXGfahMhRaKNTVYcGPfdZsllD2fq58w2XIX9vvxCPolZ7WyxtYyuFryBmf4f/DSEk5YAsnWhg0nbNgxNbi4KpdY04ZguTPCEoHvlb1pwT0m+MyooxIcwEWHv0/6Y+ZHqo9c9UXgmHKmjT87XZNz6pbMsuWIyzX6fbSK2/3WZ6l3dByedREpZY7sPEZGLs7V6a4mbTHjxXIpo5yjUVQJWHOyq748g7pQVjC70DXa/ECDPmjvEXeRORGsYbuhI1fxzzfcMs7cyp8EWn5U8S1sK+E/PiFCJJNix9rr67dWDSmVqnU2fHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaM7pnFkaodEO82dhV4xI2+3+sceKIcl84oVv+4BX5c=;
 b=Rtybc1qSE/v+HozBKV/LVVaQ8tEzqJ912FHeN6zwz2yB8WNmOraN4mEiTEf8Wy8s9BOtYEXS6aZ+JAOMXuktY7aOx/SVF2WKkc4rWan/9B+X62CmRurBmiFkfJGRH+Y/TI7MAhbFXqdzr0gPQ/iOsmkEcGrynF3M0ZcXOHioGGOFmZRDcAefz4baeJELY4yKDrfEvuqwEIT+RXXFdfqe9x8Q5feoTDsSgczbtS+GaM5L19kWbYOHh1mNGUfEn3IXiTTqeLrqRcZ83o+PDLZ6E6NNzOejRi1u13LsMo3JejYWVB3Wol+fEtB30xpbpNY8HHRq8w7/Pgl4fOn1LWJccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaM7pnFkaodEO82dhV4xI2+3+sceKIcl84oVv+4BX5c=;
 b=e5h3mkdvQQUajmNIakuK9gtO6xNWD3ce4QgwYjVbri9T1b1bSS9UUcBvB1dkcS5VJrKQ7pBqbAr3eSZtouwCIIJ0Dee+s2vDomKpUl2uZdZSWqhcQhVuApdfn66D465dSjgu2QyLMe2jBPvzis7dzzPJZ9Rr78kAeN+h629rs9Q=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 15:33:22 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 15:33:22 +0000
Message-ID: <610fc63b-f3dc-4824-99fd-907fc96f3194@oracle.com>
Date: Fri, 3 Jul 2026 16:33:18 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-modules@vger.kernel.org
From: John Garry <john.g.garry@oracle.com>
Subject: About THIS_MODULE
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f886209-44bd-4930-a263-08ded9186a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5GOVjAiTJHXipwq+pzVQ2ZE0fQknNzRSX+mLsQBP+bTNNTDgZE4QHmnk7WxO1MnYMWfk50QnxVVOFD3KAhEx/ahRVzPbUnFGJ9qlytIRpSG0m7UbiAFSH9TE1SSmIfcUCKBTjyVP3bTovFKpcLofAV/0tstj4XCVOAZ8Ol1k9p10GAXGtCRnGeWvinZiOEA1lfia+RCj3Qb46gCzUPZJjWDSxpLAbzWRbDONdo2dvr8ZObNLf2BcKgOBp7erNpZFQwzmy6fyGd3yhWECeATdjhulAdrJfS7oHwve0fteo77Lk8BVG5+6gyw4YCnQKzfih7qTrwf5V5jJSm/WXGAEY7iayhpP+//jTml0iwWGqW6ctujq54vfHG/EbS7yfEForJ7M2xw535jb253uswQ14OfklPNK0difGf1XqCrx46HVShYvHoKBGrIbhscuhau1sMonQonK4rd84vTUyTTyF66vKCu9MQFxDv9ebraSyvGchA/sb+WE5SL3BtjYW1PxcUzaRjYxVPBYQO3Mb1qegrtAfB4lpDzhqv2yChLxBdmV/wl8wUiaq66jddArK9tXBfm3N5dW7eEWJIHGU+xCDvhldg6bsbrmuH5oX72KE8wr9fENotRQAfYGilcwca9+MjFZ/4dZEi4UAwi7ntANjLiQdDhHLuNv26R6aR7ngxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzZKVUhMa29LVHdwR3BRSm56NUsxWWVsUjVtMUpVMjhlaW5ndGVhRmdxano5?=
 =?utf-8?B?cVRINUZvUGRVQXVHRWFiTUZBcmpvMVJVcllDcDF5MDh6Y0RYNTJaSE9xZ1Bw?=
 =?utf-8?B?bENjeSsxY1BWb1JWYjlzVWJTV2MyWVpjcTdSV01wdkkxeHliUnYzZlBJN3pF?=
 =?utf-8?B?RVRuaHIwblczb04zVWYrQTVaSVJaelgwNEFxK3pnSTZIbEZPenBnZXo0SHRo?=
 =?utf-8?B?WEZSNTBmOUVxbXhsTEJULzMzQXVWeUVKT1FWZUtIdGFHSkc4UkJKQ2VuRVJp?=
 =?utf-8?B?cjNBZzNxRHcvaVdBVXpTNlBpRnJoNXpRYnNTM3QrelJLTG9VOGpHNDUveGhn?=
 =?utf-8?B?Rkd1OTFoc0hQU3dQb0lCVjNiNXVqM3d5enB0aHdSV0pyNC9GQ0lpNEVSb2Ir?=
 =?utf-8?B?SzlaLzRpRWRTNENwZGNvMGx4cmUrMTZkQ05jMFMxcm5EVEg4eGg0TDNsUGIr?=
 =?utf-8?B?NkFFUEE1R3QrOHVuM0NOTk9zb08wZ28vOHl2MG5Od1RoY3I0bWlXMHlDV3VW?=
 =?utf-8?B?bVVLMzFNTFFabCtVSHZsMElVRk1GcGwwOW9YNTNuTGRvM2lSWFpwQk50SEJP?=
 =?utf-8?B?T3prbElXQmE1aHhHeTZjNWVhYmFDWElvVGV4bWJDaFZYNWZTY2FPZEEwSzZu?=
 =?utf-8?B?SWs0czhpZzhoZmQ5Q0NqeHd6VUJ2VmwvQVRtR3NuWTNHTUdMa1hXTGFsUlJp?=
 =?utf-8?B?QWhxdm1TcjI1YURDVmx3R2FyU0FwQndhUlVwUEo3bE5OOWJTQitUc3Z6bTVn?=
 =?utf-8?B?d1hUeTV4Z0xvczIwMkNPL2lqWU1NZlFTL052dzZBd3IwWENseU1mRE9vWHRx?=
 =?utf-8?B?QXJYbHpDWVU0bXBoMVArYXN1RTNmYTFla3RnVlRTRHhCVUlGMTVSOWdDeWhi?=
 =?utf-8?B?VThYUXF4S3pMZitKUUpPNzZPWFVZUUhJVGJxZ2FFc0hZK2lSdWE5dXhQUkxT?=
 =?utf-8?B?Y3VUOVNqRW5DOFU2Z0xJL1Bkb3lmUGRyYzFKU1FSZjVPN1JGWGdsTzRXZGRq?=
 =?utf-8?B?RkFiT2lqQVVSTXBPWUlYS1pYTHo0M1MwMUFmT1RIVlQzUXQrTlRsMVJtNy9J?=
 =?utf-8?B?VGhEQVhGSmZxS0xtY09lNVl0U0FGb0RxVFQvV3F2Z2wyWElZVTFnbUptYU16?=
 =?utf-8?B?ZjFsVm15TVBseWg1MXZKNzhPTVBIM3BoaEZobW5JQ2FMTmN4V0orS2wwMkNr?=
 =?utf-8?B?N2lhTHRHcjN1eEdwWnV1VGVBcklBVFV4VDFBNFBPQjhsZCtqQitTVTNIRGZ6?=
 =?utf-8?B?cnZUZnhjRjUvQWZ0K1E4RWJsUmovOGxBRjRtK1FmODRwb3VOcHlPeFlQdEZR?=
 =?utf-8?B?SEtiMDNGWEcwSExDUlduZVJtRDd5ZUg4Y1JocVI2ZGdndXYvbnlmTzhjWDRn?=
 =?utf-8?B?cUtBM3h6S1Q5Z3ZSempNdngvbEFSVWtveG9JTFFTWGJyRFhKNnFLSmZvYjlQ?=
 =?utf-8?B?Y2FyK3dCdi9ZdXFaUXJ4Ujd3WWFOa050UDQ1dGdtb2NnZ0Zpa1B0RTVKQUZ0?=
 =?utf-8?B?VGlETEs0U3dNUzkyOHh4b3ZjdUlxMVV5RkRMRXJEa0pmaXltZFZoaGN3VGE5?=
 =?utf-8?B?Q1Z1RTdhZnVNakZZb29RTE1qZUM0KzJrZkhteERsbzJzV3lDcDVOTFFDNDdt?=
 =?utf-8?B?YVlFVlg4eVRHLzFEandTRjZPMTlBQ1FkdWxEQnk4V2w5WWxPNk55RHAzQlM1?=
 =?utf-8?B?ZHJXWmhybGlEZHhraGtJWjAraGhvTkp5TGlNMDJNZWNUZTBLdDFwN29jc1N5?=
 =?utf-8?B?SWNWdEhJblE5QS8vWERrdVkwMm16OGx1elFlT2d5TGhoaDI5V1o5cUhYL2pI?=
 =?utf-8?B?aFdPU2Jwc3pza3RyUUM3dUFqdkhIYUlMVXphbnFWVjhtTjV0Z2hUK2hGTHhM?=
 =?utf-8?B?cy82U0x0aHZMQmgwQXR2RHZ2SU1mUlUyUUZ0ZUVkY2pBYzFWVmhTemtOZVkz?=
 =?utf-8?B?L1JOay8xc3dTdExNdzcrbzhvelB5TVZEZEdlZ3JVTVBmZUp2YTJVemZlMzJD?=
 =?utf-8?B?MHBxVUJkUkpWU0FrMktQVFkvYlVhdWNqSEVkcWoreGxPcGhidTFscWE5R1VJ?=
 =?utf-8?B?VDdaQjFlSkJ1aTNGbmdpcERhT1B3SEEvbUtqeDhPaFZmUVdPY09RYm5Ydmcz?=
 =?utf-8?B?RW5WdzJTSFN4ZnRKa1dHeVJEOEpNSVZINEZ2eFEzTVZRYnUzRUIyK3J5Y0Jl?=
 =?utf-8?B?MFc0MjlPc2dQejJMeCt2Tm5LQVVWV2JiSklrRnBrU0lMMFM0MDJQb09DZVRj?=
 =?utf-8?B?ZzkvQktDZmpmbjZBUjl4Z0hEeTBrUVRuUkw5Z1RmUU9RbDRFK1FTMDVSSk51?=
 =?utf-8?B?amo1aVdHbFBKbkVBbnowTW9BekZqMXNTdnNNeFhkdktQQ1RuZ1ZqcExQNkxP?=
 =?utf-8?Q?6vHRSXgbksSOfYs8=3D?=
X-Exchange-RoutingPolicyChecked:
	Coiw+HucrXz3Rc7RAMkZQtwYCnjdP85YudU3s9gBYL28+B7qZg6ceTyw7B3dqAXG2vW74UeYWiO+4PLLSwv+YGWk5Y4zWmH9wSkEnEqATpAgPPYaF9yuAej3aBFi2tod9IY6urCd62tco9TF5/fvdanRKvYc9NkAOVXOe3umNn+0c1lXHOgYrVvc5Cz65OwZ5ccwxADzLnR9PRE8g5fRr9bF76lJpOm1/heAOAedwPpx0+6Lfhs4JvzR1mZj+uyPn/nAgOAVtbbiCm23ZlL3RIPfyLOzeWqAWdgEcwa95E03pzAIAHb+igXNIpy580Vm4ZVYVAdp7+jg7C2pZHCcJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V1Hp/ISiU3Ej8x39I9QffLR02cZwnuDhQyxUiAH45nk9MkpmF1/0znyJkVBEoSPoVnGDiqOwS4iDRqcJXWG20Pxzh8Y18cMEWU8Zz3KMU9Bt4tV0t92Jgj1rn2QvwI8Q/sp0ftVGJxjFI4n7bl2fCsdZQxtAI2ETdNKLXM/ryCAK5Vxwx6eiOyHkrUD0AuagPPxKWCa0jPZrYMhDwNDXyk8A6ChyZ1fk1GxZSZLvXDSWUDZSY0j7Ae5aeAOOKOPhbbbVXthhNxCJRhIK1A3Mppw06ahKvVDf2XF+CuQROudk1MKxTCYNUFJpTy1rd1VdCLQSatWl54OvTqyY1DQVaOSDqAEIZduFULqBFBJV8VhY5IBH6DHzm/Db27eF+dbvhNlR86qwBoudLEkIHW5VGR/0WH76VAMbdDk4apVlJoGlAN7M9PfyC27qluyoEaZeRawYpWNmDj2hjw7Ujr5QKaIYC6RXmfMTuoWj2hBR9EqGwY4Umg5Q7PtnGHS2aQYdhrgOMoMBsrGNNg3pkHwACYLeqkks52GvhrGVkWn0XLBqItl5KdBUkSTeiU6V+tmkKowwe8RbGcpS7X/+kvVy3EaKp6ZWCTKjk5SLAe9k9Ag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f886209-44bd-4930-a263-08ded9186a20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:33:21.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbrmEyQIUhzpKEl/tozPmmH+EEDTkc8kOa7M/1cJ7KYKKWxyQuwlasMltQNaOB4sUejWnfnHdxStgZbS4gWpwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=642 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607030154
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1NCBTYWx0ZWRfXw/vLI1csyMKk
 oSftG0regGlrhdBM6ztGWeMksfC33N803kXafGN0q1zokB1saGG7GKKzWizWOogj33rNx878Jy7
 9zqVoPlssBWAseou99US3VnhI8OUlB4M3EzH9dLsVKkFsZq2VPjt
X-Proofpoint-GUID: Amb503MfkS_GQN1o_xEIFduPyP2pz4vN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1NCBTYWx0ZWRfX6qayFHuP8EqJ
 h+QGqjL6Sox1T94Yuzja8Rh2xg0dPxenSuRkX4GxP5zBSRsBLvu8w7WLIStasqiJiQBFQnFj8vN
 v96SSRGR8HDvmM4LFz6YTogU82vIoWqnAbGjodHzsedo8TEZ04n6KUAFe0kfl1IFUB+zBZmeSNO
 rErsvyIstJ5f0upc3wMbfnS3N5PCwHm/Oqy/sC5lk8pfV43LaNQstVjc0yWG1vy3x0NgeqbBxlI
 EYN+jDdXVTnXyDYkOYdJ73cyBryQdBN+Xw+qcy6+u5TChg6N3gMqKqZxp/c7NHwYur/qeFU1ONs
 7aL2+PAIxEnG2sOxfKolXzshKgnHiwwhJfIOI2icbD3BFaITYXoWtZ89iU5t/le+GsA0xhbhyzG
 5lXkiK73RkWqeTU5+pu2enHWIAiFbwdxuuWyZCbspqkrqWCtb3ilHjcK70xvQmq/3QNOcZQF8SF
 9rfZd4nn0eKyqEDFm4y7KujuhCzYAVcFF3ftCKec=
X-Proofpoint-ORIG-GUID: Amb503MfkS_GQN1o_xEIFduPyP2pz4vN
X-Authority-Analysis: v=2.4 cv=D5N37PRj c=1 sm=1 tr=0 ts=6a47d683 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=dE7o45ko7l8vfbZahVEA:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221

Hi all,

I have a query which I hope someone can advise on.

I am adding a library API which requires a driver to pass the driver 
module pointer to the API.

So we use THIS_MODULE for that purpose.

However, adding a sanity check in the library to ensure that pointer is 
set is a challenge. Normally we would check that the module pointer is 
non-NULL. However, for a built-in driver module, THIS_MODULE is NULL, so 
rely on the non-NULL check.

Any idea how to deal with this?

Cheers
