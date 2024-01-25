Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AC1381
	for <linux-modules@vger.kernel.org>; Thu, 25 Jan 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157026; cv=fail; b=NjGZB90tAmnmfyZWsIcXz7EKwTaw847e5g85EI0+ISaAX+r1kiNQtWP5R9780KRQQCr9GxfdZsfMTWdBqec1qm9/AfCIblFGeuCDF3TaD/0jcVbcL8gUFDkd6A3EPf7e0g2uzHocAVXVET1TYAFnpVqKwBBp1+U2XmrYuykhsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157026; c=relaxed/simple;
	bh=aKn5trc9vCCJ+H2X7oCR8bgMj+8f4EapN9t8sku6NeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqsuDtiI49TjkSWHnHzqTBwHZCAeX+rF5r9xn07S++oVueBOv7y/sTxNi/USACgTnB4GAFDUQ0SR7Nmj/QRfm5xGSOXfgwTN+JfbVZxBD+PO8jXWOTMhJAz2b2TynADHwuUIJxLMtn1rGontd8qCL6NcIDzG5mfJtr7eI0NYwac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tpnt/b4c; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tpnt/b4c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC3YPdtIKvPAj+yilCSkFiPmf1as7TEvrNB7Zb6CiWip7jQX7VA7qCsaNNRFdm9O1a4S28rcfHr0h7tUSVsjWNYN6VugsxbiyGlLag/FMyfIgoRX2vkkXR2eOHtTpgEjgNDE2wR4v/S7al8rgTx+hWvv7LO4+nlnGDxGXFHlHUEUznwulThG+foIKTfIjLyT891GeyX1pveQAg5tHmdu9Ydqj+vJg+OBzGeJi4bvHBP27r6hKg37coTknKF7ttNE99KKRiZJfWpHgjzFxk113a44k85KAhMTbJTkBpgT77r5TdYUw6ivH9RJdy/fF+c5MLc+WKNH90ZseVwCDkTvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iyzNeE1gFXeiIdH4zBJDn4/7YKNcgewSwhy9K7/C6Y=;
 b=TmBhMYdowT8ucfrdPPxeKyCSwOTmYvu3uVTl9JUYTTHKmU1PJrbRC1FmrcsPZsDrCnSPkb2fanccjNoEF5kqSvZENE7wqNS2KAK6jtfCaVYcFO5wTeLBSTyy4G9ChzIpqti0a88czyc0Y1ouJjXnp/qvbXq2Kk1e7XU36J3FA8gvzpAQA+/aoC7c6L9WeP812IntLzI9Cdg1cpn3EvRk6K7Y8AMGX/PMqLIVbC8g/83pGrNHgVD/LmpIgY7zY0lAkhcb9ZjS/szJ9qE39l0pWtGaSy4D5Z0ZHy+G7R84xrUH9qRMtV9ni9/MASq+sjzxhyGAnCCHM7rX/1gSzkOfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iyzNeE1gFXeiIdH4zBJDn4/7YKNcgewSwhy9K7/C6Y=;
 b=Tpnt/b4cc73fxEcVURMe9jyO0JZ/j3ajQK7bxVJqbGTD5VXsBQkO2HToojHMNxqqZplUbmFYwI4PyHxVXl8y7gimTe48ZhABLB5NFwTQxVljlsCvc1H0GAgFJwk0hp67rsiF911fLpKZKwbNoHX9lhsWG7bDDk4a+Sc1E2KRi7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 04:30:19 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 04:30:19 +0000
Message-ID: <9cbb1c1e-9dd6-478b-b75d-e6c9f3d6c8f7@amd.com>
Date: Thu, 25 Jan 2024 10:00:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/12] x86 NUMA-aware kernel replication
Content-Language: en-US
To: artem.kuzin@huawei.com, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, mcgrof@kernel.org,
 rmk+kernel@armlinux.org.uk
Cc: nikita.panov@huawei-partners.com, alexander.grubnikov@huawei.com,
 stepanov.anatoly@huawei.com, guohanjun@huawei.com, weiyongjun1@huawei.com,
 wangkefeng.wang@huawei.com, judy.chenhui@huawei.com, yusongping@huawei.com,
 kang.sun@huawei.com, linux-mm@kvack.org, linux-modules@vger.kernel.org,
 bharata@amd.com, raghavendra.kt@amd.com
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20231228131056.602411-1-artem.kuzin@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1d72bd-b267-40ec-60ae-08dc1d5e5638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7GLQjUM5tqsLtvw8ZXfzU/xiQpU7BHMe16c3RwR/yQoanzo143qCShsj2l5AUByZL2Aus1MvjTgSlKazERaYl5eMW08o3NQB3/tokLCKZq1cgbf2Yo7fvBLhCC2RGdaeBFSlxORDbLujiRs30uSvM23XEzbk7Djx+ZQAn1I9F3iJfbGlln0Od2it/YViTW2zXREZGaJuh61bFcYIlRCpur5ul0J787PQpi+f3KahLXIgBGBSMHEi6ImYJPKCwSZ6n48Z5dQXfdorhVYn9/DQREwVyLKVj2gsd8DkdymQ4IeFTAnOs43/gyoMcaCiiOoXumMcNje1CPb8LpFBzBa9oLQ4gtqRTLg8aBdIAURv85lt+p4yTy1m11wD+3AnI2npHRc4Xzz6hTs0eQ/P6jhN+NupBg8I7ddtd58MlU0my3SdXPw7AzAHdMyAoftNTa6TrmiIkxL5MGj16gP4Z6U+WaUnyP88bzLyLfaiTYsvfzuQKmJ79hvfB2KjwOakbj3r5NZXP3WAVmPhpEdYhAyl1cKU08P9YdVB40EQOTux0BJXNPg20D/4lZqwV016rmapI3Anzjf1CPS3ss+89VfXaDMTpX9ctGm84ZWQmFk+ZhbJEUoJwgFwtLCDEBxYJSucfcZXgLcfi4Tb8V76TolV6Yzk6lr8SSJ0jKsohlG5rcE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(921011)(31686004)(4326008)(7416002)(66476007)(6666004)(8936002)(83380400001)(8676002)(5660300002)(478600001)(6486002)(66556008)(316002)(6506007)(2616005)(66946007)(2906002)(6512007)(26005)(38100700002)(41300700001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkcvZ0FrV05md2lqN2JuTFJORW1oOUlIeXhwMnZKTkFhQVpVdUlJd0YxYlhU?=
 =?utf-8?B?RVVNcHN4MXF6MFpVdnhrM0FId3ZGcXNqQll5V0hHTlpNZEN1Q0krRGRVSWc5?=
 =?utf-8?B?S2Nid1ZsMWJEQ1IxSHF6Vnh6YWxSSWNCSGZiUHZvdVZMK2Niam8rQ0pqNDYr?=
 =?utf-8?B?SGJZcWlKcWJZSG0rQ1hpazdqMzJKRFJvSkczV2NIR3hNMDNCM1FDc0pnNWdw?=
 =?utf-8?B?MXJvTEdMNXEyRm9Sa3BZOEJuSXBkNENLSDlVZFYzZTZ1NDAvUW5IOEo2bnkw?=
 =?utf-8?B?aUN6NzNBNjNvbmtjRmpQWll1dmZRMXFsUWJHeTF2OEpWQUhsdk1OejgzZnJt?=
 =?utf-8?B?aU5wR0ZrUllXcFVTUnRMQUVKZEhkS1J0K0dvc21UR0R0S3Q4OEU1N2R0aWw2?=
 =?utf-8?B?WlJaNm5QYjlFZ2o4Z09NOXd0djBISGc5T0tQNHkxSTdlNFBoWE52UzQ5TzBx?=
 =?utf-8?B?a1E0RFlFa1llWWp2V2RHaXhMZVJRcmxEOEg3TVh3RW56TXZtVForbFBDdTdW?=
 =?utf-8?B?SFQ2UG1JZnpUQjduUlhhSkVDYUcxT0YzeUJtZjVFaHAyNENuUzJEK21SNXA4?=
 =?utf-8?B?UnBOd20vV1ZFOXdoTlNEbVpHSDdKVWNRUU5weG1NQ0FtOEFzVzQ4MUUzZ3Zs?=
 =?utf-8?B?SUZuY2dBVlc2QW56WmpUZ29YVy9jbFY0SC9PcXZjWGlzVm52bXZ4VnpLbEE5?=
 =?utf-8?B?VUtCNjZEbUFZVC9laFJZdXpXR0ZSTTFMWWxScjhzK2VIQUtVaDJWQVlxQmtn?=
 =?utf-8?B?cVZCZ2tJQm1PeGZiTXhPdnFXYlJNaVZYM2xNbXdSQkxPMlpRcUVnTG5NUHR1?=
 =?utf-8?B?Mm1DNmR4TEl3RURWRTQ5eUU0SytpZEtCdDBidFZSWlFrd1V4V2hhRURwRTRw?=
 =?utf-8?B?T3BsREZuU0tEUHAxM1V1MDhSaXRwaVR2OFRXc1ZBSnoyOEdBcy9QMHRaSnBD?=
 =?utf-8?B?c1NwNGtSTnJlenBuU2ZZSit4V0xZRSs5d1NWMFArMG0yWHV3R01UWU9neWNx?=
 =?utf-8?B?TTZuOWxkQ1BpMEdYVnAwZlZPMXl3amhFaXdwbVFSUy9aUHIrU2NyY3gzSkhO?=
 =?utf-8?B?cHV4YUtWYzZheS9GbVA0Z0FPdFpTN01GNW9yWjZrVkZEWFRablU2RDc5QnJM?=
 =?utf-8?B?SlRkWVRDTHEwY0JKZ2t2Nkh5WEt4aGJ4aGJZTXJtYjVKVmt1d3Yva2xVQU9U?=
 =?utf-8?B?NDJweGNsd2F4WW90NmFSbEtFYzhzQTZBU1J1REVPVHBiR2NsUDYxdEtJSTBX?=
 =?utf-8?B?UEV5aGdBM1VRNHQxbzA3Q1J2WGF5UlIxQVpHaEZEdkl1ODFVcmYyL0pKZ3Zr?=
 =?utf-8?B?UjBvU28vMStDNjkyMkdpd0wxZUtQTm9kOXZNRzYyYUFxVXV2SEUyZDlhQWZM?=
 =?utf-8?B?N2FUMFNaTEc3bGQxZ092azdSNVNKakoyT3ZFdUVmY3N5Z1cvcXUwcE5nK0Nh?=
 =?utf-8?B?Z2JnWUljOFNLdHVLRHROWWwxWXM2MHZJdGE3QmUyTzBIa0F4eG9JK3ljRHNL?=
 =?utf-8?B?d2lmZ21zZ2hsSFBEZFNHdjFQN3MzK2hiTUpTbCs2ZzlrekVTazlsUUJxbzRS?=
 =?utf-8?B?V3JpQm9nUGU3K0t0Z2F3UzZsaXQ3aDU2QWxSdDBJT0xGZkg2OERnbXJ4eERi?=
 =?utf-8?B?RUlqWXpSdkRtdlM3T2luUFV0ZkhTUzYxWmFXcmw4UmdKQlN5NUdHTVBSRXNz?=
 =?utf-8?B?ZjJ5QmNXSStnQzRZUlJTU2JQMjB0a2pFUEhUa25BSHVQMkt2bzRFTlh2L0pv?=
 =?utf-8?B?VW9GY0NKbHkxbGNoUVI4VS9UclBid1E1aGwwZVJIS25kNTZLS2dJUGtraHVs?=
 =?utf-8?B?RHVpNzA1eGNoTVFxaVhKK1cybk82RDk4T1FHd1hTWTluQTdzanlrbEUvWHd3?=
 =?utf-8?B?Z1BXa2tVMGVmS1NqbXVBVXlOcUlRS0lLeWZudW1CZEtlTTl5UDZSZUN1MFdX?=
 =?utf-8?B?U2xpV1lnNTBENDRWVEhRZy9UY1RnR212dW96dWRpenM5WGNJeEJsNkNiUjJT?=
 =?utf-8?B?SkorMXYxbkhjbGRLNlpKY1o5MmVGeUF3b1UreFZ0bEk1MWpPZDJEWFFCd1Zy?=
 =?utf-8?B?V0ZReUk0RzdYTVhpSkt2T0pKL0dHUXhSOXE3Um1iMTJzajNRL0N3UHFmNml2?=
 =?utf-8?Q?Hp3NGBpzcJbfK/F8LRAmrzZjm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d72bd-b267-40ec-60ae-08dc1d5e5638
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 04:30:19.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3ieavLdYOLGemxwG6cIgAXpDKjPhyUiGjaLV4FNaNmmasiPXvFCDgLNUmMsZ3s1ToXWGWz/xogxF6wPCZ/SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

Hi Artem,

> 
> Preliminary performance evaluation results:
> Processor Intel(R) Xeon(R) CPU E5-2690
> 2 nodes with 12 CPU cores for each one
> 
> fork/1 - Time measurements include only one time of invoking this system call.
>          Measurements are made between entering and exiting the system call.
> 
> fork/1024 - The system call is invoked in  a loop 1024 times.
>             The time between entering a loop and exiting it was measured.
> 
> mmap/munmap - A set of 1024 pages (if PAGE_SIZE is not defined it is equal to 4096)
>               was mapped using mmap syscall and unmapped using munmap one.
>               Every page is mapped/unmapped per a loop iteration.
> 
> mmap/lock - The same as above, but in this case flag MAP_LOCKED was added.
> 
> open/close - The /dev/null pseudo-file was opened and closed in a loop 1024 times.
>              It was opened and closed once per iteration.
> 
> mount - The pseudo-filesystem procFS was mounted to a temporary directory inside /tmp only one time.
>         The time between entering and exiting the system call was measured.
> 
> kill - A signal handler for SIGUSR1 was setup. Signal was sent to a child process,
>        which was created using fork glibc's wrapper. Time between sending and receiving
>        SIGUSR1 signal was measured.
> 
> Hot caches:
> 
> fork-1          2.3%
> fork-1024       10.8%
> mmap/munmap     0.4%
> mmap/lock       4.2%
> open/close      3.2%
> kill            4%
> mount           8.7%
> 
> Cold caches:
> 
> fork-1          42.7%
> fork-1024       17.1%
> mmap/munmap     0.4%
> mmap/lock       1.5%
> open/close      0.4%
> kill            26.1%
> mount           4.1%
> 


I've conducted some testing on AMD EPYC 7713 64-Core processor (dual socket, 2 NUMA nodes, 64 CPUs on each node) to evaluate the performance with this patchset.
I've implemented the syscall based testcases as suggested in your previous mail. I'm shielding the 2nd NUMA node using isolcpus and nohz_full, and executing the tests on cpus belonging to this node.

Performance Evaluation results (% gain over base kernel 6.5.0-rc5):

Hot caches:
fork-1		1.1%
fork-1024	-3.8%
mmap/munmap	-1.5%
mmap/lock	-4.7%
open/close	-6.8%
kill		3.3%
mount		-13.0%

Cold caches:
fork-1		1.2%
fork-1024 	-7.2%
mmap/munmap 	-1.6%
mmap/lock 	-1.0%
open/close 	4.6%
kill 		-54.2%
mount 		-8.5%

Thanks,
Shivank

