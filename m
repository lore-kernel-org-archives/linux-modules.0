Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D5364A9
	for <linux-modules@vger.kernel.org>; Wed, 10 Jan 2024 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cQbc6H4v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLk7zBH1+2I8CYx6yLsAYTYH3wL977TD/K/LGHJxiLMdZOC5a2M/lkuk7F4T1njP8qFT0BJccDhNwg3OThFwLcS1G+2GlhJmAMmuznIUQk0izwnG6Nf7Po4HwdtyJRhdUq1tHUTSlVV2bC/syt7PDe6yU3fbsjfACUPKNwQJXhAohsCQr/f2YRmugBE4Lrfl0KHUlBtMrTUUQNOKT/uxhEkyUKizZFKtXSBoA6Wqt8heXvUGm8tmSegIMK04Hut5FWH48NkDfiSeVKy9TmdiDT1fCrTS/PVloGT7ZAownhLPkaU2E94jjicy1KvYCLwEDMOeBuIU4tfrpaFZkyNRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTfFYgc6A5gRuH1Fw2v8KMXyhg5TOojU0abM3fAKTNU=;
 b=A6IOaYklayDosWtYX+h5IR901BJgN02DGyUqA1upmyGR8fflWacJJhQOozHzFMBOonA7C++2QqbjqRUHe7QX5y03EwhepeUTc6lz3LrQJ0hb339JvM3ffVGyxEYmm8i5CA5YHLk1PbxMpl++iWEulT4zpWlFBmSjl2m14wfYmPvmvDMPsXmykAuOyCPGJ+t2P0lAVUVZBcpEPqav3OHG5MA+28Wep2wJ0eHkxhJaG5HxQfHgkk9lLIo3qu0eUIDtGMuIxNxS0ouOahrpCt05igHflLEr9tpKn+Hm9Y5tpUBFXzhJxiKHJHpJHGLsW/yYWZsuIkLdTBrgRsf8ymN/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTfFYgc6A5gRuH1Fw2v8KMXyhg5TOojU0abM3fAKTNU=;
 b=cQbc6H4v6Dl+Db8R/WX0YIjXeU1s6trRcve0n90+q/qFA1ExRMmHCbPuF7chiQORLaYxZ1pG9Qc+u9nl/c2dleu14C5yUzaRkFeUcIJlQnzqzlo77g2jNe3s0NpCwd8Bnf75GxpXZmFOZLfKhiuyaUBg+1Tm8FnCgs5ZM8sEqCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 06:19:45 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::1f57:c794:8d56:389f%6]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 06:19:45 +0000
Message-ID: <45e92092-864a-4547-a01a-8e1addbbc413@amd.com>
Date: Wed, 10 Jan 2024 11:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/12] x86: add support of memory protection for NUMA
 replicas
Content-Language: en-US
To: "a00561249@china.huawei.com" <artem.kuzin@huawei.com>, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, lstoakes@gmail.com, mcgrof@kernel.org,
 rmk+kernel@armlinux.org.uk
Cc: nikita.panov@huawei-partners.com, alexander.grubnikov@huawei.com,
 stepanov.anatoly@huawei.com, guohanjun@huawei.com, weiyongjun1@huawei.com,
 wangkefeng.wang@huawei.com, judy.chenhui@huawei.com, yusongping@huawei.com,
 kang.sun@huawei.com, linux-mm@kvack.org, linux-modules@vger.kernel.org,
 bharata@amd.com, raghavendra.kt@amd.com
References: <20231228131056.602411-1-artem.kuzin@huawei.com>
 <20231228131056.602411-5-artem.kuzin@huawei.com>
 <083a2549-f4ed-478e-a4ff-938a3eb15ab0@amd.com>
 <dd35192c-a3d3-4c6a-9914-d4739376ffb1@huawei.com>
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <dd35192c-a3d3-4c6a-9914-d4739376ffb1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|DM8PR12MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d66ea6-d6e4-494d-38ed-08dc11a42369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QNPxThh54P2QzEpyAdJVa9dPuveVksXIEKbfYSibBoCn3R8OGDCp0jeLVwj+F4XtD5ViCVK3P7PS2HzQMPRxo+SK+u9QBkZRmZmAW2TqXBoXOXWyF+rMc5qX6TGfLuN2KbDMC/vhLb+qRvHgSzdM9xDn605z9S1c0/NDFAO/kBKRmoQpIf9dn3neK69hdJ+HKH916cDgQ5bTxk59CchUHjFEw/dQ9+U9jnjTdT6f1FtdRajLCq9XO+wUdXDKChygzhoTlmGukjBakX5wnk76qeg2wIGAZ35gRqzmuHXPnDu78LTN14CKWREoOPzEXvtDWBxic0TE1CpisDqQOMoyfIHRHU+upOXPIZ3ZJpCsTw2QM1GqMffh+J5mNZ56hJ8Coadi0PLxGG0gIQiyJjw00U5pW0IlerTi3V6GO5wxHv4t8Y5bI966CDynwSK9JZp7BnZNzaymOVfBj7H7R1pGh4nVvLKMrYnJ2/mAH2jRQvCZ3lmBgIcMUFIBW8VzaJ89Jq90LXmfbxa1KuA9gdH+TJ+ombEB9Rn1EfTRAnKPIe6QHHboCIovorv7+qxUdbFZhWbRLdMczoGnbeGsu8tAI3z0hCJmZTmxb6P0XH3+YeycqT65YfW4N2clYgNNnrjuvWR5WiNeKjWX4hPZ/XNYHdtZgbEEnfBG69Ri993e9iGxFfUW/lziIyeWU7S4LzRrnuZv6T51A6MCQkYN840jCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(2616005)(2906002)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(5660300002)(4326008)(6666004)(4744005)(6506007)(6512007)(6486002)(7416002)(966005)(478600001)(41300700001)(921011)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(15398625002)(43740500002)(491001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndFVWVkdWRBRmRWaGhEYWgwZ3BrUU9yb1ZSNHI3SmwzMjJKWTMvUHphMjZt?=
 =?utf-8?B?V2h6cjJDQmY1a3VxNUg5T3AxY2JFdU05Nzh6UVc3NTdZeWFIWEpkOVEycVlU?=
 =?utf-8?B?RDQ1ZkEvcDlFeHV6U05HKzNhZUVZUGRUcFhCUFFibytvcFc5ZEZ4M3hhUGt5?=
 =?utf-8?B?eXBoV1M4NjNsemhQcWJiY2ZRVGFHd1VXbGQ4ckNieVpDSUtBa1U3RmcwWlVE?=
 =?utf-8?B?cHBnMVZxbFRndDdCVzVycTdHQ053cnlITVZVM1Npc1l1dFdEQjlBVGRVdGFn?=
 =?utf-8?B?TVNPVzhrcjBZaFJUdWFEUFllT1djNFpJN1BnbXNMaXloVzlEbUtoWlBCREhS?=
 =?utf-8?B?RU4rZzBaQnR5eXZySjNMRjFLbjlWcTNDbjBlaHJZbnhZWkg3ZjBzcUc4Vmoz?=
 =?utf-8?B?eG9QV01mZ0FUUnZHVEJJOXNwaGR5Y1lBOEQ2aVZJNHlDdGpzUjNCcHFkUTRB?=
 =?utf-8?B?NFBnK1dCbFhhQm5ZRTNncHZ6bFNQMU5IUkRnRncwcnJTUDM5MGZtTEFDM3p6?=
 =?utf-8?B?azVrUGNCUk5PWU8zQnVnUXV1L2pPVnlYWFZKWFMrcWg4UVdwaTUwWkRpSVVs?=
 =?utf-8?B?Vnc2WWwrK29YQ2tOSWZYeGVWZURlbnpKVGFBK2J2ak9GSjFYVk1Ta1FKQlkr?=
 =?utf-8?B?aCtZS0ZPWHQxaE9Eb01sMDdLSjBZcTR5WGg0RzNWMVp2alZ1eWpjaXdPbURl?=
 =?utf-8?B?L3JQWDdOQjFJQm1zZWc5RHBkS3Z2a00wY2NLWXR5M3FlZDd2ZUU5aEh5NFVv?=
 =?utf-8?B?dnhlQkI1TzgyMUVRMUE0d1VzNW10d1FaZjFhL3JZWXpzYktidFJBZFBFMHlw?=
 =?utf-8?B?YWh6MFFWTmRDck44RUJrYjVmZDg0bW8rYzRkVXc5R3lqV3FRWjZIaGdZV21K?=
 =?utf-8?B?ejNzUTFIdTJrSFZyd0gzTUNTWjY2YVpQMGtPWjd2eTlVQnVYQndFRUZ1T1Vh?=
 =?utf-8?B?bTNwS0t6S3U5KzZtVDlBT21nR3ltaHNXeVRPMGovL2VHNGJ3OUxZZTI5MEFQ?=
 =?utf-8?B?NHFSYmtmbDR4c3ZJR3E2QUI3UGhRMDA4WEpTZUk4UWlEak1oUkcwK1hEZCtO?=
 =?utf-8?B?Rjg3Skt4M0xHUmo4b29QY3Bmc3N4aENEL0VOYWxJek1GOGo0VW8wS3JFS0Q4?=
 =?utf-8?B?a3ZVYjV6MU9WYnl5ZmpxazhHcUJrempCcnowWFNTQXc2czFHVDVHdDNnTElE?=
 =?utf-8?B?MGpNZE9IcHdYTTMxdkVBRkZTZUpmLzhTZDJ1dUVEVEZFODVZd1lmenJOZWFE?=
 =?utf-8?B?MWNXMnFucnY3Nnp5MDM5blNUN3BTaHBPMDk3YSs5WWtnczJpSzJRVXBvdGJy?=
 =?utf-8?B?Tm9EeEluWlRxM3dMeE4xSld6b1Z6YUFSdlZ6MjAzOW1JR0JuNkdKZjNrTFNB?=
 =?utf-8?B?Si9aMHE4amg5U1A2S2JSKzdlNVJmbGRpQVFZKzd6ZThmeDdaVXhJaEIwMjZh?=
 =?utf-8?B?UjlvakxWUmV4OVhBaFM1TzFoTUI2ZUlxcFpsWkYxMlJ4RDhHN1M5allYdFBq?=
 =?utf-8?B?V2wyQWZVaFQvbjUrcnBXMHF2aTR1bTVWMEYwTVNoN05XdVpjNmhnK1pLdzFH?=
 =?utf-8?B?cmdLK0kzNDY4Qitta2Z3VFdWdVB4QVJyQUMzaXhmUEVWRFZxVURaWDNUNHB3?=
 =?utf-8?B?L0o4SkVZZmM3Z0xVT2tYZG5RUE4wNnNNMVNYTmpJVHFwVlJtNHVtRis3Zmd3?=
 =?utf-8?B?MWIyTmM0ZFBmVmkvN1RldE1sT2ZaK25waXAyQnNqWjUyeTdrbzdFNHVuR084?=
 =?utf-8?B?enF3enJLTFRyS0M4enZCa2ZKNkdXdFRmbEkybjZsUnRkRmN5M1VtcTd4ZUxq?=
 =?utf-8?B?ejBxM0duSStVTENMUkJqVk9wWHhBby9rWVZFQ1BOUG1rUlpFWnRTWVMwY2h5?=
 =?utf-8?B?R2k4N0d0ZVJnd0g0T0NqVHpkZytISUpNMzFyVDRKSlp1K2dQMVVSTS9GRkox?=
 =?utf-8?B?Nm5WUkE5aHlLYnM1NEFPYXhSZVVpM3UyTDFvbU55Y1RuWGdqblhIRkFwK2hX?=
 =?utf-8?B?VkpUQzRmSkdDeEkyUFVDVXJCT1JZdzJnZmVmdFRDYm1sNUdJL2RkLzR5bnM0?=
 =?utf-8?B?SDdaYVZHZVdCWEh4UjFORU9QUTloMStPcy9IdlJzQWNtVnduSWFRd0RQMFFH?=
 =?utf-8?Q?M+tHLVyx0+ni+Znc5zrQrn7Lc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d66ea6-d6e4-494d-38ed-08dc11a42369
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 06:19:44.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wt0ZlJdvX+AtQhlVuoTxlRWPWSQZosc/1Cu9tsizAmk4quRzlz99a8PFYcj0r4LVyG9Hn6ugFAdrqaMMIddYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477

Hi Artem,

> Regarding the benchmarks, we used self-implemented test with system calls load for now.
> We used RedHawk Linux approach as a reference.
> 
> The "An Overview of Kernel Text Page Replication in RedHawk™ Linux® 6.3" article was used.
> https://concurrent-rt.com/wp-content/uploads/2020/12/kernel-page-replication.pdf
> 
> The test is very simple:
> All measured system calls have been invoked using syscall wrapper from glibc, e.g.
> 
> #include <sys/syscall.h>      /* Definition of SYS_* constants */
> #include <unistd.h>
>  
> long syscall(long number, ...);


Thank you for the information on the tests. I will try this and get back with numbers.

Best Regards,
Shivank

