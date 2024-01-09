Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6479C4
	for <linux-modules@vger.kernel.org>; Tue,  9 Jan 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GZbecohO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYLTxdUUWLFzKt+ugwMbnF7DnZEtmhXzXRq3qz8czfgztPCnXyUPm37hGCJXPQUIZ6o4u8DKZnD33W0na+8XfwCy27vsUl/xFV8D+l7gfQjOI/FfEXQX6ER7BTUMGrhsSPTDlsollbNwsgJb05Y6zqSuEFxM1cE02NF8p7nz7/kfCE7Yegwh20CZF0j0+tQyiOgU/4FLzUstXOpNXLPtpqRKJzH39GpUZctXyKhn+Dg54+05aQhoWCqzloKelqiY+f5s690YxHyRP87tbTXzqc43JFlj508AIA+2opLdmbh0A+QnYm4znWg8/1Ns2lF5olnX0XdTv/uSR66R8Ioz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMpRMkI4Xjmo57enVKOL9iMk1exp8cqbpBD1SIKQXGk=;
 b=WQQvXqnHlOP4hcd5sMQQltmFHM3VkI154AgQr1E1Y29wupozPJHjVsKrNlkMbtrGil6JHyEzYpwRR29KSOjI0LbxtKvJtb7L2b0bdMARQgpAvrEuaKSyT5Am3St/HliRQHaE2zQtwdv8vIVwZ1tjAC7Ww/2+Z8oCpSZ2XZq07c491wc6zFr7jqMSD+aMOTd8gQb0BFHi6y2rJCQ7MWX3VnSs5LgKIScxj3XnlnerN27gRHHkL9zDlKU8WM5wk4R/vFq+baMcJ362ZuQ90w+VRghMqhIKJwGi/2bnwX+bHJ/yFpfglYCY3efLPDxZc8uWu66chQXXxjgwWajfIfX/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMpRMkI4Xjmo57enVKOL9iMk1exp8cqbpBD1SIKQXGk=;
 b=GZbecohOQW+5sUQNKgI7trsj4jO0sNK3aNuVaSJzgjZ4Ypn4pPkxWE/35aVg637G501uyGcLWP5cYTPabJgFeFrSM2N7tbyt8vaQsL62PI3AJ1k0SJc5LoZRuoqzW5hTSm+YdD/pruEhD6giGEw+u9tJMoCUG4HCzSmWV5zeyJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ0PR12MB5470.namprd12.prod.outlook.com (2603:10b6:a03:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 06:46:15 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:46:15 +0000
Message-ID: <083a2549-f4ed-478e-a4ff-938a3eb15ab0@amd.com>
Date: Tue, 9 Jan 2024 12:16:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/12] x86: add support of memory protection for NUMA
 replicas
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
 <20231228131056.602411-5-artem.kuzin@huawei.com>
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20231228131056.602411-5-artem.kuzin@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ0PR12MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 703541dd-0b59-4365-6437-08dc10deacea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UWgrrTWDPaao/WAXsTJHPbDgKLKxhLCjXPunPgt6WSZ+uMpGyf4TwB+U+1iYvMWl8oNU3BTc1s+RN5cR5k5/D3VhYP7Ze3lLLSy6r/g28aZo+2RNPKZ1nRa3soHp1/LuhGKhvuxDj9ykAA8k4EQUUQz9pm72ij40K7Jn8CXZxbeKD9T1RGzw6833jQRByoZjZfD2CxvXQruHNe1yztAZyO5lZXTlbcRO6Nj24pHPx97/y0aNIk7uGxMEDGU8kWxpqCZhJr3CRhE/o2GKEn2CfSaan3s5AD3bCw7qcCCmg6LfG6pE7Qp+P2IqR8AxLQkwJE8suCViRSUNK+p/kO6xUkRYdxg3NUU7tow5UyG740g2M5M1fkDLMLocRuJhZ2nZDzwVlvqHjMXlpN6mCHK+pXVoUzxhqTGae/CLzrpOEaJ1zFOZatBzNul8joZyupJ/cnydjmYc3L1fZ2dkTkWLSNcfSG6/u1UzwPqnmYES9MZDJDc53/kdEPDd53P+DF46dTuEA2pYES01buDlNT36bqBCw8l/EPbt07hF/ZM3CgwCaZszjVWJggk/EpomxF7kD3a99K4nOkJ8gthN1KP2DBQ14t10xfpZ7LwFsdxYTcqgrtJFEMS6Jq9O2Rg8kDTd50jBgiauYWjHTO1ndudqvZ2c0fQtIDqRqvBOUl9XC4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(5660300002)(478600001)(6666004)(6486002)(2616005)(86362001)(6506007)(31696002)(6512007)(8676002)(8936002)(41300700001)(316002)(36756003)(66946007)(66556008)(66476007)(38100700002)(83380400001)(26005)(4326008)(921011)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzZjdEtUUEFTTUpWbzJzeGI5ZGs2YlpFSVAyaWU3U2VtSlZsVStOYm55bSt4?=
 =?utf-8?B?ZXZ4NGJYcDZzSWhMcW5FQjU2dE40YXNPa25mNlF1UWxRcVVMMWFWYUpqQ0Nn?=
 =?utf-8?B?QU4xSkVabHBCZjZxUnY3S2JqZVRVbU9NRU53eUEraVE3TWZWeUhBNGd1cFVQ?=
 =?utf-8?B?QlMxcEQ2N0hyTnNwZE1aa0dPcm8zNUVaTmFOV1ZkU1pIazJ5Wm5QSFJNVXor?=
 =?utf-8?B?NzNmSXNhSFhERHhROWlBS05UZGFIQXpLeGtjc0NFZDFLcnI3QlUzQjI3ZlF1?=
 =?utf-8?B?MHVZSGFBVEVqLzY4clhEeThDdWl4ZnNybnhaTFBYcTMwVkJ4U0ZYSm5RVXBv?=
 =?utf-8?B?QlZCU1VNNmYwblFWajFYc2pvWXF1Q2tMMWNvbU1YQ1VXQ2R2U1ByVENQNnhw?=
 =?utf-8?B?YVljbFVHTE8xUzZZZzkxSkwyWUNHUDNhYTE3dVRpK3NFOTEvTGgzd1lLeWJE?=
 =?utf-8?B?QUVQcXBmb3kvL0djaGhtbk5hOTVyTVNWZFlwc0RqdXhMa0ZlZHBBaE1KMllN?=
 =?utf-8?B?Qm1KRERNYmtoNjJ0UUFMYkRRTXNseEJrR2I0dGMzOElEM2IyS0tRVGpYS3d3?=
 =?utf-8?B?aEt5dTB5WkFHU3RmRW52TEc1Y00zcVl0VlgyUC9QbXdMNlRHUzZaK3pLY3B2?=
 =?utf-8?B?aFV2N0sxczJsenZ1a1oxVkJOdWRUMnFvakw3SHhNVmlZZlpKVWY0Wjk5ZEJx?=
 =?utf-8?B?Y1h1djRZUnhLQWQyMEFlQTFRWFpRS1o5NUV0Rk12a3ZBZWROMVo1R25xd1Br?=
 =?utf-8?B?T3lQUmN0L2RZWEJTYWFnRERKdHJhdjRLcTV1dklGZlNYZmtqbjQ5UGE1Y05F?=
 =?utf-8?B?YVFKMFdxNE1abDB0Wm15cGdBcU9vdXpQZmtNVG54VVZzNU0vdVByTHRqZUMv?=
 =?utf-8?B?RS83eDZvalFvandVb212VUN6aU5hM1p6RTJsOFpiQTJQcnZ4bVFIZG5mM1hS?=
 =?utf-8?B?TUtZS3BhZDRjSWVsU2VKY0M0QVJLVXpVWS8zYW4wOEtpbTFqUkZCRzM4M2JL?=
 =?utf-8?B?bCttRStuNExLeWkrTlMvTVhnUUhTZkJadG9RMU1OQnV1QkxNL3Vrcm1ObmxQ?=
 =?utf-8?B?dXRSdzVpdDQveEJ2Kzk4aGN2QThXNHRpdnFLK21MQnczenBCTDR1TWc5SXdt?=
 =?utf-8?B?YlBlOURGYUpLZDR2QndLbkR1cmwxT3FZZVVMQkN6MVY2TWU4MWY2ejJBbW5v?=
 =?utf-8?B?elh1Q0lBTWJqZWdVbENFcXNtZGNGTU9RNTFOSmdzcUN1VXQ3bnIrTzQ2RzRt?=
 =?utf-8?B?YnhXRE1oTDdIak5jT2lVR2NiL2pzajZFTzJGdEdBYzUrTHlmQmZkY2VDQ1Aw?=
 =?utf-8?B?WDRXUVd3UWlwSzlvTzlCZ3N6b3JFN2lvWnFMdjRoaTdPY1d4bnloekl3K1Fr?=
 =?utf-8?B?cTNjQ2NTQldsc2MwYXA0MHZmbFFWMTZhSHZHeTd6UUlLUmRqdk9tNkd4aVRt?=
 =?utf-8?B?L0p5TkIrZGVIVkQxSmxEOW91Yk5TVkxuUUpkUUpobW9wQ2RyVDIxYU4wYnJL?=
 =?utf-8?B?ZUQyOUduSjFYcmV6UEhnVXRmYzl5cDhEakJjUXlBcVNBUlkydnZ2UWZCN05K?=
 =?utf-8?B?b1BMQTJiU24vMmFIVzJqSGVzZmY1UWgwMUdyazd5OGRhU0VpZW9CLysxNjRq?=
 =?utf-8?B?YzFHSG1SSGJJQ0dZL01raXZlUlo3T3ZGSm9WVHZ6NDBJYjZlUmpJWS80UHhE?=
 =?utf-8?B?SGIzT1ZjZEV2aEpTQzBDUklNQUNDcjBXdHErM2pXRTNBaExxdFVyNjl4YXh5?=
 =?utf-8?B?S3YxU3E3YThmajZjZm5YdHZYaXpveHIrMmU3TWhjZHgxL3huWEZ1c3dMbUt6?=
 =?utf-8?B?RGRhVGN5OGVOb2ZybkliV2c2VVlRZGhzUEpFS1ZIWEtEL29aVzJld0V4MWRx?=
 =?utf-8?B?bW9nZktkSldBSmNPMlZ1bi9kQXNpOEIvZHQxYjBIWUo2NkNTVi95SGY4MnVs?=
 =?utf-8?B?SFpwV2JWZldtM0RSUDM1cW0ydkdnbml0QUtNSEVNQkpVazk1K2dlQ3FxcjF0?=
 =?utf-8?B?OHJLNS9ydlgvaVQxQXVMU0ZmSjZNQlluMnJteGl5SENMeHhkTVpRWXN1MUtZ?=
 =?utf-8?B?WjRGdzNWSVBpL2g2d3dlL01BcytvQkhReHBCeGtKbEF3aFQ1TDlqMXFhWjVB?=
 =?utf-8?Q?4X+tv+Ie518vWJWG54lvrxz2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703541dd-0b59-4365-6437-08dc10deacea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:46:15.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwkABiYfcvJqXx/vqcLT7gnl9I1AKFS+6Q5jS+aGjczG0mmChLp65mx0m5Kg/LqNs/HIMPaW+4RHfU8JZv/IZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5470

Hi Artem,

I hope this message finds you well.
I've encountered a compilation issue when KERNEL_REPLICATION is disabled in the config.

ld: vmlinux.o: in function `alloc_insn_page':
/home/amd/linux_mainline/arch/x86/kernel/kprobes/core.c:425: undefined reference to `numa_set_memory_rox'
ld: vmlinux.o: in function `alloc_new_pack':
/home/amd/linux_mainline/kernel/bpf/core.c:873: undefined reference to `numa_set_memory_rox'
ld: vmlinux.o: in function `bpf_prog_pack_alloc':
/home/amd/linux_mainline/kernel/bpf/core.c:891: undefined reference to `numa_set_memory_rox'
ld: vmlinux.o: in function `bpf_trampoline_update':
/home/amd/linux_mainline/kernel/bpf/trampoline.c:447: undefined reference to `numa_set_memory_rox'
ld: vmlinux.o: in function `bpf_struct_ops_map_update_elem':
/home/amd/linux_mainline/kernel/bpf/bpf_struct_ops.c:515: undefined reference to `numa_set_memory_rox'
ld: vmlinux.o:/home/amd/linux_mainline/kernel/bpf/bpf_struct_ops.c:524: more undefined references to `numa_set_memory_rox' follow


After some investigation, I've put together a patch that resolves this compilation issues for me.

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2268,6 +2268,15 @@ int numa_set_memory_nonglobal(unsigned long addr, int numpages)

        return ret;
 }
+
+#else
+
+int numa_set_memory_rox(unsigned long addr, int numpages)
+{
+       return set_memory_rox(addr, numpages);
+
+}
+
 #endif

Additionally, I'm interested in evaluating the performance impact of this patchset on AMD processors.
Could you please point me the benchmarks that you have used in cover letter?

Best Regards,
Shivank

