Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022138.outbound.protection.outlook.com [52.101.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F571400986;
	Mon, 19 Oct 2026 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381748; cv=fail; b=u3Naoh1w8EDEQomy6AeoYdFbrZ6TeiKxwkNK4jkkPG8S2iV2EkGO3erbVSq51qQV/N39K+CTY1fEXJOGqquhV5toYBGS5H4GlIU7GTfSZJisTOo11HiIcGQC2on7ONQiQtuAGQbO4lIb3SNONLoDr6qSDS1cPC1M3YLDZKGIUSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381748; c=relaxed/simple;
	bh=eOqLDk5FUohMabmMWPfU24DF9+BHv9ZIjYJqV1UCdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jpdkMHBfeDdiSxOTmMw1nXmg+U4lej0rFr501dOdY5s1mRpORM24hhZaU8L5NPyD7DcysB/KEKzGVpEGshL4qEPJxbM8HQw0dXxJjKhPayzsUn/CgUyvNj5o4hDaqY1BQBxaMwQ1L4OR1bIy02x087ZZE2No9Z8099rxJdg09n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5CYk2q9eTRGXtV7D9ROzymdEnkyROvpPrHVKXL1BSArAgToHYYApzu+WuXF01R2TSOakSmviNllFGQEebxJwgCIcb0PjjiERZCNiMR5vVegXxugClEHYtktArCddZwJkSaFWaegZBIsvXIylFJmsysvh7hNjFSIO+zQznlk/CnepjGb4yh2BVzQcvF+ElgZaI8ajwfweREel1MYupTUtCv8hCvMFiYwXgO4cXbaP5AwDZfk4mdxDyK5M9sziHdMEaFJ+2gdJtUDVL8mQNzAP0sk2vBv/Ixb6Z+qjsKi5CK3X6SRpeD1BEQTNBh6GjHIIC3WAGcDgVwO+AWEqevJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=N/PmsjwKsn/EhcBNlMJrTwq50oKXo/xDyJ2G3xkpyWM=;
 b=bGkrKNjAfsdNSTj42DSPs+ovMl+e8gtDkCyrxqEs6sBROMNO0K/4MsPSk3p4ch9oGJYCbcmpGQG2cJfCnXp43ayGa1S9ztfwqGoUW5ml/Zk4XbAZQ6HPK+BPkl0iBQwtT2a0lsSUnS7tn+XCUUPrUKQcshYDT8zHt6p/iSXFvlH3WYIrBOfX3bclVNtVpuw+UwI0OhaZnAMkT4mQDF15NQLocY6lFp7U2jDM2qVjSU2w1c9+W//8XcZIoZ48yVQXbTj3N2qT6DqQoaUgRPayJ7krR2SbHMQ3+ALfLCqMX2ZpYRQlYDmzkjhoUkgh9xJqwE3z2xXlSNebNws0v+ikEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2971.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 03:49:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 03:49:02 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: atomlin@atomlin.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Fix use-after-free in module_put() tracepoint
Date: Sun, 18 Oct 2026 23:48:57 -0400
Message-ID: <20261019034857.654569-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:408:e0::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b09552e-1957-41bd-7536-08df2d93ea21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|5023799004|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iSLiO8tAHqaKE2wtBBbteEDxpHCtfxk27Yt4+zP1gpQD658ZUGkc9iju8EjJ0SM0cRn99ZyDmBRHuJFfUPpE17D06ubhaXJjxC8J6rURHnwRRjBoVivRuN9e/FX1Xx0rVvbxoR4CVf6PPQq5YpQVIsZyjr4QTGZwq6eydLl21rRXvx+Vb6Xz8MnI0UdlFckP+K3Gaupu8IItZozdfnYiks+SRhy9ZrEzEFqF1C5csmOvcSC86+oyUDD+nhQ0uBSt2feE5+QTu5IGP3/bXwb+Cnmio1PtHccXg4PzseG7cQMYqY3vP0FoFv+Km6kfNMUm426/Qugo0p3VQ1JJjbXc/2kmLhFnb9w++gUUpgxOdD9m+AHIUjC/HFd20/65cUe1Qfi8t+rhrne1qMTej58fK4Vfw61B1lwtsUyWgfgyImKZTRV2CMSDhGxr8q8Fa7euvRTUiiuWqPkEL4hsBAQkX2Tzv95TERL1HMYd0LM4D85j9EAGHPx34OYyEZ/u6luBNAL+t38XMYJ7RwHKFMprccZFXwJzAfx2o7871igDqeG+hz+FY6ehrbS9oVp1Nc66It7gENw4bj/7eQeeJCG3f4y0bXZFl8d88kdaQPczA66qHlp4MRGjs80S9uMX2Q+n2wt2+2AfBDQZxtLYOTHh9vKaT3K1UGVOtjQC6gzXKIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(5023799004)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9GKzRMUDdVOEFFd3ZRdFhDQ2xlcFdRZ2MzM3lzeEZMZUJxV3ltTExVM1cw?=
 =?utf-8?B?UTI5aDV1Z3NRcU4rL2FGTG9CUU5ucUxUcHBpTGd4a3hZbjBZSkhtaGY2WnY2?=
 =?utf-8?B?RzhETnA0YkRUMkVTbUMxcnc2eGIrVTJvWXZkSVdtOVlKOEdwcEZYNmFwRGdn?=
 =?utf-8?B?RytOZldHTHVNTGRoSFRRcjRQY0dOS0RxR3ZKdnVaNEpaanE5UExTcUpSQkNQ?=
 =?utf-8?B?djJiczZQOWlEbGpOQ1g5eGVNaU9HQ1M0VE9tQU5Ta040RkFobGlKcFRtZjhN?=
 =?utf-8?B?d3Z5MXpVL3FLR0JYOEp4MGI0QWNtTnFJSUdPeGZtY25Zd3JINkdMRnExdmsy?=
 =?utf-8?B?Sk5mYXpmR3E3c3VjUGxhbC9vcXZDQkRkQnBnY1luN3BOblhkbzNadGsyWnZy?=
 =?utf-8?B?OGhrMVgxQUZ3RWg5NFJFT0MyOEZiUUgwVlRCOEZIQWpCc0JnaVBEUzIwRk5r?=
 =?utf-8?B?WWg1Wjlpdjcra0Y5dEhiSC85Z2gzcnJEZkNReUJWV2pmNnpVRU12UVdzMEJq?=
 =?utf-8?B?elBWbTlxYlpYYVlQRkZDNGhSZm1hTEdBcGpyWUNBd0NadWJWam5USmtPd0VU?=
 =?utf-8?B?WkpyblpGNDdwVUVuQUU5cUc0Y2FYdk8wYWJQTk4zNHF0WVVNdDVDNVRCMW1J?=
 =?utf-8?B?M005RnBvQkV4RDd4T1I1TnRIUUtUSnlHRVA4ZUpjaGM1bEhSa3FWQmp6a3ZO?=
 =?utf-8?B?b29RVlVtUFNkL0NINXMvajcyR3RYV0FlNkc2dXVLZlEwYmNpMURidEJ2MzZB?=
 =?utf-8?B?bjFzMjd1R3FYM1B4eitFellYMlFybU9UWXAycUl1Znk5bFZlOVVUT0xoM0Yv?=
 =?utf-8?B?c0RXaW1SUnd1djVNUW5tNFdURDhUMzJhRXF3ODloQ1JUay9wL2JJNHNNVGFy?=
 =?utf-8?B?L3lKa2dkaEtGczg5ZGUvYUFvKzg0RW5OQVFmOW9qUlBiajIwM3pUdGJNZ3dV?=
 =?utf-8?B?VEF2amtXU081VWVmZFpyaWwzN0J0ZkJyZ3N6cDJOYkFBU0Vxd3l4UE1LVnd4?=
 =?utf-8?B?L1d4S1NzRE10bFIvQjlzb0NVOUtRYTZyNHpXeFMwQmRBaGdIR0dSdklzNHJP?=
 =?utf-8?B?cmRoQW9zeUFxWjNIdFREdE52a0E5OXlZMFkzTUlOS0hqWVFvTjNTWDBBaXJ5?=
 =?utf-8?B?Y0kyN0pmTFFHMmpsK2p0WFJwQkxjMkQzTG8xeStNZzhYR2RSQzRmRTYxZ0Zq?=
 =?utf-8?B?OEN6QTdRTDI5OWg1WTg1TUw5Rit2VGJKbFAyMHVQZHY4WFNTVU1VN0svdnJp?=
 =?utf-8?B?dm8vcVp4citWd0hTRU5saEpUK1J2SXhqeGRuNGpPQnMrZXZQS1cwVTZRVFFS?=
 =?utf-8?B?N1VxNjIyRDVSRFJlUkZwNHBiSlZZQXVaekZndUgyODRFRE9EYmNJUVNvcWhh?=
 =?utf-8?B?RmdCWnRLbnNGU25IU21UL2cxbWNLV0pxVytYTXRiV21iRWE2aU9DdDZPT2hq?=
 =?utf-8?B?TER3ekhBRUNHdGNWSzhkZHJvbDV4MWVOdTNCMTR6RXZoOFB5ZlA5NUd3OUdm?=
 =?utf-8?B?Yjg3RXVGaW9DaytGbHF3TWc0RVFFamlYUHRLYWJhMGFFd2E3aUhkVXkxRGc5?=
 =?utf-8?B?dmFaYXE0T0ZYVEJpbStTQU40VHgzWmljd1lneWNGWTJyOXczS1lvaVJuYkkw?=
 =?utf-8?B?VzBVT1ZZaHJuR09GVFlYYzhLYmRvY1JXdktQdTUxYW9JWkIxM1JVbkxpQU11?=
 =?utf-8?B?K2VaVDAwUG0wM1h5Qnh2emhwd1pKTWQwRTk5UUdMUk9sZm1abmUzaFcraEQ1?=
 =?utf-8?B?ZEZhN0c1ZHg4MDZPWmNpOHJGT0wreDVvYkRHdDFJempqcERhaGl1TndXdDd4?=
 =?utf-8?B?Qm85aGVJZldZMWdkL3ZxWTRVS0NCRyttbytlREdieXpyZ2VhN3pTMndXZCtX?=
 =?utf-8?B?R2k2d0s1VUNuMmNwWWpuS0tscGZUaXJTdmhTYjNDUUpaVFUxVDZzUUZ1OXJB?=
 =?utf-8?B?aFBkdzJaYng5QU5ZcjZtZVhTRHNLQk9VdENCclp5OVJaMUhWeGRQUm1QbDFu?=
 =?utf-8?B?TkVNVElYdlVlMzFaZloxbythQnRnbjNiRXg4Z1pNekFqcFRuL21kU0JqRnpa?=
 =?utf-8?B?MHBVVkpEWjNsdC9oM0d4VW1pdG5OS2h0emliemtSMERYbzZaendLWDhRVWdP?=
 =?utf-8?B?bXFLSWNTK0hnOUdha0h0eWd6cXRtdHNzV1FCalNaMFhCT1Nta2FaalZqNElE?=
 =?utf-8?B?L25Fd1N5ZlY0S3d6ZGxwcjgycFBCbDM4VjRLQkp4UjFCaWk3d3ZJMVRONWxO?=
 =?utf-8?B?Z1oxZHd3SnNvM0l5Q01yclBPVklzRTVJS0pYbTFVTW0yU3FpN0ZLWXVqVVNl?=
 =?utf-8?B?RkNmZDAzRHVlREJSOWNVQmc0NC9YUWIwYlIxOG91eTRkZnlQODZjQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b09552e-1957-41bd-7536-08df2d93ea21
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 03:49:02.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA2VphcbM99fxksFNxrMRXkbbqp+eo3VhLorjTo9YpRhgn/BBr4eBmQPn+eZ156PXaRmfEwm271I7QFzMfjhiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2971

A use-after-free condition can arise in module_put() should a thread be
preempted immediately after decrementing the module's reference count
while the module is concurrently being unloaded.

In module_put(), the module's reference count is decremented via
atomic_dec_if_positive() before the module pointer is passed to
trace_module_put(). Consider a scenario where CPU 0 decrements the
reference count without reaching the baseline MODULE_REF_BASE level and
is immediately preempted: it relinquishes its reference while still
retaining a local pointer to the module. If a concurrent CPU 1
subsequently drops the final active reference, the module's reference
count reaches MODULE_REF_BASE. This permits the module unload sequence
(via delete_module() or the initialisation-failure tear-down path) to
proceed and invoke free_module().

Function free_module() invokes synchronize_rcu() and subsequently
releases the memory backing struct module via free_mod_mem(). Because
CPU 0 was preempted outside an RCU read-side critical section,
synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
execution, it passes the dangling module pointer to trace_module_put(),
which dereferences mod->name and mod->refcnt, culminating in a
use-after-free. This sequence of events is illustrated below:

    CPU 0                                       CPU 1
    -----                                       -----

    module_put(module)
      atomic_dec_if_positive()
      [preempted]
                                        module_put(module)
                                          atomic_dec_if_positive()
                                          // drops final reference
                                        free_module(module)
                                          synchronize_rcu()
                                          free_mod_mem(module)
      trace_module_put(module, ...)
        mod->name

Resolve this by acquiring an RCU read-side critical section via
guard(rcu)() in module_put(). This ensures that synchronize_rcu() in
free_module() blocks until trace_module_put() has run to completion, even
across preemption under PREEMPT_RCU configurations, while avoiding the need
to disable preemption and preserving the post-decrement reference count
tracing semantics.

Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..8e2d0ab96e6e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -953,6 +953,7 @@ void module_put(struct module *module)
 	int ret;
 
 	if (module) {
+		guard(rcu)();
 		ret = atomic_dec_if_positive(&module->refcnt);
 		WARN_ON(ret < 0);	/* Failed to put refcount */
 		trace_module_put(module, _RET_IP_);
-- 
2.55.0

