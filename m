Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792694725;
	b=sTawBiutNdWlLH4QcnSLc5IRY0Abjtncrwivh7N/c+WVPqVv2cgL72e7M003wpa7F1qA
	 2Kp0M/G/bAhTuJEBIh8iL0LMi1PMumEqElOxgwuKFSnpDUig11/L2FI6z4F6eBDQYvSF9
	 05y3og1NX8/pNNJdJDdfC3vi9BZcQRYzL/K7HpkUjY9hsjpQa5BbM8gC41Q4bP1PIVngC
	 /hQxWnQ8ep6D4YST1U/Ra43c4viEtqOWnRJ5uUkJWOybHuVtWpzz7CvIyq1FtEwTJhWAk
	 8psdA9am5du7s2VRxSfZNAN6Xt/pZfyC4FURZ/uy973+wrynFc976zj2J3+KPH5FMuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694725;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=xpQJDiY+X4Z+4biA5PfVfrC8ZHPp6CuboRr18KB6WMQ=;
	b=o6BoEM9HQmZwiFHzul+YK9c6yZo0oi66hYFhY+KT5CVhwQ4G+g3taCLxZulAcQD4BKyY
	 y1OuodCZ7WTt/5CiPq6XZrJS5WoOf5RTcLyNHhB5g8KfuUMd0mIt5AZ4DSiPJz/caRjEx
	 ebde6KODaOJaz4/PHy4WJvVwt/FfMYxc/XDhSY6tHnc9TZ3svNnsfnhTyU2+AHw7YQVou
	 uN0zzN3YTTa10G1hvIvFzZJAS4gFon18iTOzrgFknooWW6fd+18bUzOV9qtvJHz+de03h
	 YwEhuJUrkbYwmH8LuUd9ibRIVjF7POBRUM9mAgHk4mMr9lel4vZhxKAJAxXvWCaLJBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.127
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022127.outbound.protection.outlook.com [52.101.101.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC6606A31E;
	Thu, 22 Oct 2026 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5/O2f/24Zo4lzW+9j9zuapNKe3+pTCELkkI/qb90x9+mp3Fz0TQO5LXrE6dltGa/y+pZMeAXRoGxaq1uQO8ASzD+t0F7sdg2b6R8w4Psz869PSwL8z6p2J6bMjN/wpA2qhOyFqmZ39FVEz5dPS7SBuH93KKCCrmuUpdKGTc2fZFJydxfQxBqh6lYKjTA3HqEA6y9n0vWaXYcsp1xjbiUyE9MCuZPO9LRbC9vsJwrHNDXyCp0w5jDAGAv0HMJMlVsp1yCvkG9iMvkQraYPwLmhv/mVOCFcxCKr/wmccAFZiJVQs8VC3W4ZpR9AZwwfhBD0ZMBtooKH7uYs/kC/qlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=xpQJDiY+X4Z+4biA5PfVfrC8ZHPp6CuboRr18KB6WMQ=;
 b=WsPpIsYTMsQptfbBTS60YdelQ2+hBn8geaIrQCK6uGKfyp26jSDi9pC/Y8Avx/TkDrkNpePEMm76OTpslpb5M+W975H46sUES+lPibj4At3/KpWxov1ZwRfk5+T+LpMlP3Ty4ViVvi5W6/OULjMlwCouvYxtxSadCkUIpMwrDqPlveewKFSwPg+Y4W6nHi/3lTvwErisHZ2+h9kVlTg4ssmNmNvxY7KoB/nPQYeHhL9M3tGboI82+jqAJxJG8I4jUiQlQVuS5vRGUE6HuEj5b2ZySFsYrQ0kcoHHDialgaUFt9DdqPddzGvogPuuKQrklkkzcW94umg73BTTpIVytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB132676.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a01::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 18:45:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 18:45:21 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: atomlin@atomlin.com,
	da.anzani@gmail.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] module: Fix use-after-free in module_put() tracepoint
Date: Thu, 22 Oct 2026 14:45:17 -0400
Message-ID: <20261022184517.66438-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0674.namprd03.prod.outlook.com
 (2603:10b6:408:10e::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB132676:EE_
X-MS-Office365-Filtering-Correlation-Id: 456ab09d-e42d-4d86-4a6a-08df306ca00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261022105027099003|261022075727099003|56012099006|261021123027099003|5023799004|261021121427099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	j+jHqw7ceySM1cPT0c6eh7iQTS7PRT2GzqjLC+tQPSsHzTEZq1QgkLIBhjg1i2pwLJ7cGnAYc09KCoZh9J0Uzl8X80hPubgSquYZlf4HenMqtqLeFDL0YsB+5Zy0/QqxrSCHw7lar7maVG3M7r3vsP7sgKtz7ILuGJkjG2wrYteDkOh/EGTyfj2oXFDPN/NbpBwQmt9a06suoSi4CHPY6KjY9ydLPWXUuMHR2HwnwEkoqDepgm3zfUKtznJ/+Kb6zWeuf4f5pPeFdCs0XtZ3J5BlIsRiG6ww4+IxGxj2hNCKYpeVRWoxntBGZK/AISpreY8Mjp9AKF+AghHirmbiLHFwdkAp6zbcIlqhorjzx236ieGQxiG8iRxISiBGPJFcs0S8giw3tGd6S26ohHmf2IwqnQ345Q098HxIPpNiYjfqh8Sl/7/7DFS83YBchRmJoIwzeDU3Uvck0oxuGrEvhwnK7i+0NSJo/XaQe9YZ9DYo73KhbaQRseVfW2AprU17h5h/94qvCGRaJuQoovja88AlpDXxZLn/HST4BtukriFRqbm4J2HaXNeLUjhZB6CopJJaJq8yuwcYR78OzUhoE5m9+wN5ISKdGsDXYYwhCwNrmfL0Q3PON7AXEv6I3v3q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(261021123027099003)(5023799004)(261021121427099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qul6dOyFePmMOe+GktgYiTT4ZmuQbLShls5iZQqHAsf+jqzlOnZKOasRlbFL?=
 =?us-ascii?Q?yN2rw0kYlXZo2y55XM2csFw95ToUge/3IyzQdzzUhkMzX+ltZQz/NFEkawQT?=
 =?us-ascii?Q?uUpzW/VonlHUcd1a24MUpBBiqtHSwpzNezNtxemtEN8NbAow69voO18jOcTD?=
 =?us-ascii?Q?jSiVK3V5KNdj3qb/5bWm1feqE8LGl+Auv7AReCq6YtQ9xmlAOPQQvFrzLKD0?=
 =?us-ascii?Q?IvBWoitD7vU4fz3rkc+Mgj3OFZnCuRirpYeHnal2kF4OIlCrJcneDdEeNol8?=
 =?us-ascii?Q?ISh8i7NtWBfu6YVVTHU0Ine6qugHsSsk7xB63OxT8M3PfeMJv/Rvg1W5FfHv?=
 =?us-ascii?Q?hp10eoGbeZvtmxKUSX2IfOteoGj5e1J6no/d6+3+Pf6LtExRyZwCgdjkuPi6?=
 =?us-ascii?Q?kjfmoQelxA7RAwepdh0oU0MvfB5Y+itt8ZuTib+Qh6eAdsEFUTvBG5/OerSM?=
 =?us-ascii?Q?ERfYui2k3Qs7xgpcriZnDzWKw3BnsKkyaa+6QKBsB2rBG90cjz/SOIS9RzJ8?=
 =?us-ascii?Q?OWlcOnmIwZ3kgMH+CLdgEIJX3fNCvCaP1NzeTfl6eRRHocbsUMrUEvCDCTTk?=
 =?us-ascii?Q?X7An5l5PRKQbO4qdQ4g3rfPJbLDtVa2HDHsda/lzMDJvHhV1fmx+PcLD1mYz?=
 =?us-ascii?Q?pqzuxmbPLNUjUL3L22xGy4PNT5pyaxYST6y4EKum88HBCCP8Y4p2OXhVWLVK?=
 =?us-ascii?Q?NCTDK8+I2sN2cZTqGO3XblmKop+mz4uQm+8m7N+39sDp3Y8uVQXS58SPFjQX?=
 =?us-ascii?Q?Ffkwr199gQBBfu5s6wJnhsKsk9bLCA3OCLuve2Pm3KNtXU2X4S4Jdf++nT3+?=
 =?us-ascii?Q?BT65vSpRVekt3ODLUDD8DsE3gMYzwT7ZDSTM07iWtgiS+F0+HSKWpcTALn+w?=
 =?us-ascii?Q?PBunazGy8eXrk6wwBh05XudhuVsLwDe100P4nTaTirc5awTicsT1hCl24df5?=
 =?us-ascii?Q?Pdg29dbjpieFdyDwaji/y2SpBH/Z/enomIk7QcccD+2c7pIrs6cb/StKAwbO?=
 =?us-ascii?Q?aXYGARn4SuCQwyXf0fUW79tYs/ks/vcO9xs65oxwJaaxj73pda3Bb/r6GtkS?=
 =?us-ascii?Q?WjrwYrgKD89kQWWMHT4lmd2yIG6KQ5ZOX3OmQr0DT9N9n/K4u5niJgcQm4+O?=
 =?us-ascii?Q?zqqFm4/9mmOIIWs8t0E0gDrlKhrjGep7COsIMe2PEuzJLQTvPU8M1JT1eNwS?=
 =?us-ascii?Q?3XfUQtH6K/qQF7W78MH0lWRlpruV8FBVZiZhHkL6bJiUvMZGWTCnLdUkJTnk?=
 =?us-ascii?Q?3+H3iEg0ZEBQUYpP2Oezrundk4FbgNo+dNGLW/kpPuU0+qf4jOtui4Jj8sh4?=
 =?us-ascii?Q?cVBuMPugqne5GawXYbK+Z3ZI7XBcRLZLLTVTNkZsWyWv+jN/xzvpkNV+qeK1?=
 =?us-ascii?Q?Lc+qXA67AYI56Xig6Bp5FQtVLtXKaI1u5zFh1YpcUtBmMMg7nOozTtC/LYSF?=
 =?us-ascii?Q?hcjjE2irpFR+IeGaf1N/MKgbpwCMAlu2xx3fiYZrTn9NLBMhoXn37DgCUFpX?=
 =?us-ascii?Q?cy1nDnr7arI/QYq4+RcaCEU7hnPz+jRZ+svronJAGblY/xLuutuQChW5pVOo?=
 =?us-ascii?Q?QSGeZ7N2XEsOmvipzPaPGcJCTWZNHNGnWEjRr7n3T23ajN/waese+oORzPV5?=
 =?us-ascii?Q?nF7biThv/9S4DHi8uOHm2D7gpDYSNsvbW92mq8ud1JrwQSPqJtktSVh1/pSW?=
 =?us-ascii?Q?8KlX78ZoQngpvw7RqIMrVroL4CvgmqiMXv5VWCXVXj5mfPNKCvoqPLBD80Q6?=
 =?us-ascii?Q?ZvfZyNbWrQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ab09d-e42d-4d86-4a6a-08df306ca00d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:45:21.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfzdNmNrSGO96Ty0+Lwh2N4W/dMDnaVAWyTd+VqVcJ08PR78HiGtQP6H6s4V814ptyAl78ECvS+OeLdB5XfTfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB132676

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

Resolve this by moving trace_module_put() prior to
atomic_dec_if_positive(). Because the caller holds an active reference
to the module at this point, the module structure and its name are
guaranteed to remain valid throughout the tracepoint invocation without
requiring preemption disabling or RCU synchronisation.

Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v1:

 - Drop guard(rcu)() and relocate trace_module_put() before the atomic
   decrement instead, avoiding RCU overhead on every module_put() while
   safely relying on the caller's held reference (Petr Pavlu)

 - Link to v1: https://lore.kernel.org/all/20261019034857.654569-1-atomlin@atomlin.com/
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c1b34dc1e89a..0c8df0984bc2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -953,9 +953,9 @@ void module_put(struct module *module)
 	int ret;
 
 	if (module) {
+		trace_module_put(module, _RET_IP_);
 		ret = atomic_dec_if_positive(&module->refcnt);
 		WARN_ON(ret < 0);	/* Failed to put refcount */
-		trace_module_put(module, _RET_IP_);
 	}
 }
 EXPORT_SYMBOL(module_put);
-- 
2.55.0

