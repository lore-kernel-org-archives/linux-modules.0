Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795118115;
	b=l3Xwb7OOF2pxadxk/PAWlgbX/UcvyC71beWdHA5WwC25khq4GtugOAWh8xOQbs8Eqfyg
	 GT92CiIfigCgCckJCalWrXlGAx1wFXIuSJR9xN5Stt9EO8syvBnfcQ+sCPtkpphtzMOG8
	 CIvxjdI3k93blXs33+KESDgZc7N4wYT34qsTCOwCPtPMNF0IB00wPQP8iYwUN4rKMuf5u
	 sBpb7lkamkvmOwL72kXTkcKYuEqoeQkA8v3S9xsH437BJjZor5brBGhExyDngc/xWKCb+
	 CqvqRY7x3nKiWb+rfDJuPvLW15tvEZtdZxmJi0s5uAwk4Yy2zMVMJfm/Zq7G9qpWUkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118115;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:Cc:From:Subject:To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/aX/p+DXTpEM0//85gWWHzAhz0SaoWMJPIpYGUzA1O4=;
	b=gQ3KDPeNkQoOjLu+U9mH01DOTZlgBzFIs1hOrVGCRnuR36Rh2oXG+hjdURKUQtPHgR6K
	 lXnt4z+WB/WwEeIik54HMnK6cdFV2DyeP3PsCHMIqw3tJGaKzpKmaR/UFQ4tPw5Oy/ouG
	 Ks/te8ZCTv3yJ2T6ynWpMCao3gYHCPIiafHRhGoTBQ8z2a0dnxwIBqvk5ZY+9qc+Rp4o0
	 GUHRyrNeb/5d+amkOmxfGvg27sP30fuj/iWJA1OslVNLEUnG2lPwsUVCGnIk5HB/FN6rl
	 dAuHXC8pg7KNViLtxExK3/Ywi4/v+34wqAvNqi2tpVE+jdsQ47O4wy32dKphvwjOJxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IdXwBgHI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.66
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD6606A32C;
	Thu, 19 Nov 2026 19:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DD6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IdXwBgHI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5x/oLtN4aJLdKtgIaHhQ30gzv3gSidAn5fDVX/4x6MIx8dtLaGANFRI4s5ChEMED+TFtf06IkwB3JH6t3qz1+uyNvvIsvG4XV6x9URkMzRuFlUY7UDWUlNtzRMKNqezw0EZCj95qdPIPm6gouplQeo0hUqrSkOGaSW6AfuY+T6F7dxVk9gbIR9ILmDjdRz5+MJb5KNLgmCZNd3GV326z7e4abq1V02qoWftPg0DLmwDAAPkP9rRkpp0eNhn8btQE792gSB9GR5g+M+YrurIc71AQQkqCigC1w4zT7nO8ixyqwka2icno/TSKbXqoi2AV6M02rI/yM7UegbO66QGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aX/p+DXTpEM0//85gWWHzAhz0SaoWMJPIpYGUzA1O4=;
 b=coa8Z4BNooZGwVgkaTwmelogIDN7L+5qKCW6mHDmKSS1E9he1FfCLwxkISsDwlsUi9p+c6Rwf4LEEkG9Q6MuFwsodV4idCvbY6S5yktVqbkdpXkLlIAymGXD+jP+dOJlbZcN61XsjYihwe26SgUA09JGBkThVyJvP5ibFQJ1F1eyiiLvOf/cjr+cB7QaN86Bt6q0wvZEjPsyECRdxVIFtTJ9WFYvUNNEq/zvfYcxolS9yk7BQXboLVU6SiivxOHrGJhwp0KXV/MY6/L7d3boBDHgss1CG8akSWn1M1Xk10+A6ZuDK18g8Qera/EBq15wvYh+UGYFZiMmPKRH9DfhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aX/p+DXTpEM0//85gWWHzAhz0SaoWMJPIpYGUzA1O4=;
 b=IdXwBgHImTjJuag5497QCVvwz5aO+fDQMbv/p63LkYyO3VPVib/oNXVGqhy4y5o/KwzBwBAh5RxrQZSE/xETTvoXm4vpOOX372mCXk3WrOVy/goYAclVrsMrHJEOXYyusfADFcu8pRWak3buEgDN/r7MF3FsiEG9YVaHlER3rz99RduC0ARiCYZU6zQxLI9xuD71AO1Y4bx7hNfgf79z7Miz0xtQGV9C39PxwSfbqYSlG5+bffOwh5NJtf7A3iS2r0iEkC0RXvb6rsknNjXowCFSxbraWo+ht1nto3Sef0RylAPqH4/FiPrrpH3FxJADt3LPj957DfzFW/jMfADHyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) by
 MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:55:04 +0000
Received: from DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::4f0b:dec1:4317:9b86]) by DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::4f0b:dec1:4317:9b86%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 19:55:04 +0000
Message-ID: <bd2a701b-866c-4d4c-bd0b-37b4410628be@nvidia.com>
Date: Thu, 19 Nov 2026 21:54:37 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 x86@kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>
From: Yael Chemla <ychemla@nvidia.com>
Subject: [REGRESSION] x86: Use RCU in all users of,__module_address() slows
 kTLS+wrk workload on KASAN+PROVE_LOCKING+kmemleak
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8069:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 93553656-bb91-47e5-a6c4-08df467700c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|261022075727099003|56012099006|261026140227099003|11063799006|261022105027099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vVGOo4Vl5SceXVvKMPcQhbUmkB/oRJ+RJf00N3IqypwO0W07iKYGE2+1Osp4BwvIkC2IzK5o0XxvVgq0qjzkGzwmGg9AXn3J+gqh5gSeaPqXju3nJdjb2jWzwDyf65sIxP1hPXM+sxzR5zdpzAo16b+7CZJ7Ss24vilbMjyl6Jp38WX8CWEf7eeafKssnIDAW+CzDpyHAFj2TlnBgcPO2b93LIdXeEA9gsyuqDV7Os8P9cSt8so5Ahv9kPgXIjNtarb7zw5C4Xtv+UjjMbPQbzP2YciivHDvK8+8fD+XXBY18YCWcfVs8oWVbW4d3nfF2JqFCgAaKFEKpic66a1QsW2p31gyMp/vU0smFAmP56EBcmRggy++WQR3+TIUlD5gSWMudFwtcwDdfqVj1/TfrnWgmFFVVpArTiBRJCBOgWbJ2hYP27eDE+gKH0LcWCXRBOiT2kcOywSTUy0RDfqu5A7KhMtmMQTKgFQDYuiUdLXuGcNijXv0asCNDMeD4I0K5J3171Dw3kLsQitOsGtZE413f04Ging2T7lPD4F268efYY8OA39lwgmruhL4OHCfQ77qAndeXeGF4Tv1w73nAStgz/RL+fOBlRadPIre8Iu1v8SvZfZoUxTtkytW+f5atiAqj8TaSRpGlBY0cwchrLZKoQIU8z46bnOr+H06sq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(261022075727099003)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261028144727099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1EZWJReWR1WngwTWp5c0lvL3BySys5d043dW1iYTNrMit4RittZnYrdlVy?=
 =?utf-8?B?ci9xUjA2Q3BUQjRUYWxUdWI2NzlnWEJLaTY4NUxjRlFSanB2blpoR1ByWVNo?=
 =?utf-8?B?ZjZwTFJvUXBoOU50Nk5odE5uVVlsL3AvbHozVVd2d2pKa2JYelR6RUphL2hi?=
 =?utf-8?B?dWdkYUl3V2ZCUGZoQ25MclFhcVRZMGkwbUttaTZhelhYNnhseDBybDVaRkZh?=
 =?utf-8?B?SmsyUWdZQjA5OXZlbVhIUE5uYUEwa2VVNjNMK0VuSU01czc3Qi9RT1R0Y0Nq?=
 =?utf-8?B?OFVkNWhUWDgxQmdWaVNCbHEzcXNSOVhxV2lUNGlHT09ydmQ5RUFPNEVXU084?=
 =?utf-8?B?UHg4cWZPTk9JT2h1RGxXRWlmcGRJbVhqbDBLMVRzN1FsY0tpall1NVJLWXRw?=
 =?utf-8?B?QmtEY1dyMlZrdGJocCtwaG11RWR6STdndGRLQnl3alVsK1VsR2hJVjIxMWJq?=
 =?utf-8?B?M0JYNk9HRnVBb0ZGUzZQYjl0WGx0N2U1cVZseWd5d2s3ZWFVTjc2RmNhRmtp?=
 =?utf-8?B?T011SWw4aFpXc21yQ2M1eWdJekdwVnhJS1BQUFJnYzl4YXlGTm1wR1pTNU9X?=
 =?utf-8?B?OStMUnlTRFNXOWFBa3l1U2NYbGpWVktDK2N1YzZlUTdjSGhDZHRCMkdtTUNn?=
 =?utf-8?B?eStOY3hqSDVvaXN2VVhVRmx5V1hVSlVQL1VxdWI5ZzlTbyt1STdqb1BBMVJ6?=
 =?utf-8?B?eEcyTk9kSFlKaXdKaFhSYitITUIwdTZ6VlAxZVg2Y3lkZnBoZGlVZUJSaS81?=
 =?utf-8?B?WXRic1hjUURob2lhbXJDeGZoNVpuNnZLZGYzYi84d090Ym9rdWFIZzJDYnds?=
 =?utf-8?B?SHd0MW1wbDQ5UEVTa2F2NGxDYVZCVHZYeWYxaEFWM0xxNi9aOUp5KzFIUjRD?=
 =?utf-8?B?Zk5CS1FjRnE5dktXVXRTTFB2RnVNSFR5MnB2ZFhML0M3RGl4bGdoZ3NET3Zt?=
 =?utf-8?B?SSs3MlpMd0s3dHU1UGlERDFFUTZGRWttSW1vekJXa01DZ0VqZ2t6dW9sZy9T?=
 =?utf-8?B?bzNDK2FPS2d0Mjc3NFFNNFdYVDRtcURZZWN1amplanVtNE8waUtJVzc4TGUr?=
 =?utf-8?B?YkZQVmhxREtUb1l1NVk4aXVLKzlneVBybk5sWFlyNlRKUE1zcVV2UGc1Q3hn?=
 =?utf-8?B?WG1jU0ZoS3V5UThSY3gzUFJYVFRQMDlKbkFsUkpaMkhKK1E5eTZhc3JvNjdN?=
 =?utf-8?B?Vkd5RGs0M1c4MGwzUjZtWkZ5Q0ZJdUlkUURRa2Z5aHVnbzA4SGQrR3IxeTlw?=
 =?utf-8?B?SndqYlMrL21Idm1iMFlxUEZQZURiWTVVMitkdUFMckRsczRJb2tXZUFaTC9S?=
 =?utf-8?B?YVdPK1ZIVEdTTi9uS3g2M0IwRjdDSHpvUkxybkcxZ0hGU2N3Nko2MTI5UEFj?=
 =?utf-8?B?UHp4YStWaWE3V0Zyd0k4dml1bjBSR1JWd011YUd1WWdxRXJJSWc5eWtnUGVL?=
 =?utf-8?B?U29BS1Zhc0EySnhid3ZMakM0QkJyUnNxMHR6VDZ2SHovSjIyc0RtTEV2MS9j?=
 =?utf-8?B?aysxZkNMNG02aWx3bi80aVN0RjRVVHpnbGtrd0VtUXVkVXNsRFRBdWpBVFd6?=
 =?utf-8?B?U2ZJRXNKbDZkSEluZm5EZzY2Wlk2Q24vbit3UzVVMXBCLyt6S0JscFVDMm9l?=
 =?utf-8?B?eVFQQnlFNmNQUTN1TzV1MEdPcnIyUzI3V3gwN0VYQzVmaGhROUE3V29naU4z?=
 =?utf-8?B?bjVpaTI4NWJHS2ZEVCtPK0tlQ3pSdmNlK1ZKZHFUSVhsZzdQUVFwVXU4UGlr?=
 =?utf-8?B?V0JZQmJ0eEpHSWI1KytteU12YUdLK0RmaDZaN0RCaFFxYk01azM3Z3NaVUR2?=
 =?utf-8?B?bmlqWjZsaXFiZVJPY09tbmFJaTdQL3Z3SGRxa1Z4NjAvcVhDVkFjdjMxbWht?=
 =?utf-8?B?Z2pSV3ZjWjV2LytKazM3ZFY1LzJTLzR5SUJIOUp4TFgxYWRpTlY5K2hndzZY?=
 =?utf-8?B?YnUxcWxtTlE4RFNLS29OU25UbWRTVnFaZWJ1ZXBXdUovMjVJRU45eDN5ZXVW?=
 =?utf-8?B?R1h1RnY1ajBpaURIQlM2OC96MlZWR3dyTVdOa0FNd0tZc2o1M1ZLQThCcTJu?=
 =?utf-8?B?TkQzVGQ4SjB6OG9nOTNuRDcvU0VRNlpMeE9OQW9CRHh3M0o2dm4wZDFDTDhU?=
 =?utf-8?B?SXIxWGZBWUIrZGJseU5kcWQxSWIxa2lEajlPMTNLN0FOWHF6NmI4Sjhzb1BP?=
 =?utf-8?B?Qy9qWDBvZjdiZUZjOFBicGlyVmd2MXFXaExFNllMaHJocDIyRFhqUlVGR1Ar?=
 =?utf-8?B?aHFFVjJxWHVhclFFRnlZVFg0bytSdVk0d1liS2c2RUZVSk1WKy9QSVJkbDRK?=
 =?utf-8?B?d2FSM3NPcXpVR2VaRUlzNTI1cFYzemVxN2JoYmFRWkVxaG0rcFNRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93553656-bb91-47e5-a6c4-08df467700c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:55:04.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOs0Q6bOITz+sXZiCE6lWNg9daPEW+GuiZzffsgvSa0sXqaCYlq7PbJGE87nJg/omYkz6W4MxKbnpjUMx2W3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

Hi,

A kTLS stress test started failing in v6.15-rc1 on kernels built with
KASAN and PROVE_LOCKING. It was bisected to commit 14daa3bca217 ("x86:
Use RCU in all users of __module_address().")

The test runs wrk (1000 connections, 15s, --timeout 5s) against nginx
serving a 1 MB file over kTLS, with 1% packet loss. It fails because too
few requests complete: wrk reports only timeouts, no connect/read/write
errors. With --timeout 10s it passes.

Reverting 14daa3bca217 on top of 01d5b167dc23 (modules-6.15-rc1 merge)
or v7.4-rc2 (7475ea8b5861), with the same config, makes the test pass;
without the revert it fails on both.

The failing config has KASAN, PROVE_LOCKING, kmemleak and UBSAN enabled.
Building without KASAN, or without PROVE_LOCKING, also passes.

I have not looked into where the time goes.

#regzbot introduced: 14daa3bca217

Thanks,
Yael Chemla


