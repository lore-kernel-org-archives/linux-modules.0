Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723476;
	b=JJ7ka+JGDAuQnv+8ErZ76lgUYGnySdoN/E5s1tgQViDEVSGqj/VfYYB9TlX6e4G7soPk
	 SqLSjUkWlw1fNAypsLWeNkyMO4BVz/iBnkUgdao3W+44YLYLL7T5zJBCGtoEB4PFAAL3M
	 XQVNK8jeTzmpHUwg3NpJN9K0OL2tyNA5kafs5tF2vR6joVlAxHrpgwLa3kckJ8wi4Rhh0
	 /K3iQYRVi7udxrL3MepJmLUn0eg3Yj5WtAkYXl2+wyraHjnOvcYqaB7hzvyHWeWY9c64a
	 zaqyHGSPxCJ5uYiwOJ1mGP8dQgzDyPbpiRTeOg+e9JvACqvyWBxS0VcJPpwYI9tGVzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723476;
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
	bh=/qBWgcsbI3CdI8jCN7M7SLFgcMjH2FnO5xgWy5Fn8/Q=;
	b=Qf6QavLzT1Ybv154rkug4+Q54Qy5oKue7uX0y+mTS5RmYJCToZOP69tfYh1k+CAnCSYm
	 NpwG/NrvAttoturBuS0X5TQCalhiCDaYTcnmsmrzRNdwduq5uA+JmqMaJD2Xtj84RFugN
	 EFy3wgF51nDLeY+s4Lu9ipGIUCB+mzMEkO3y3gfNVp2m73ggumJDKkuptmN5CE1Y0VvDH
	 tBzqP+uhRM6fzQIwqHHf68SoFmim4MVoRjIU0/Vd1pbCPxyKgnshZKdDLNJSVIzUjJK7n
	 F8KFNukSpv8q3iRA7T8iNklD3T3Yr8STFhs/LyqEuQDzwyQkZkud1wuWHUTggfDnPgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.131
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A89606D802;
	Tue,  3 Nov 2026 16:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A89606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mez9pLTMbo2Sx/xTbci1BwDSU2ODIHEAKySMYoE+PlalmJPjSMqaz8f45Jfvl+QsGBie3v2sCQ9ent/IWtYKw0Cc5K6mQYOmKsXNHMOzdR/Lpy3RMgahBr5U3z8qY8G7R1Mv8qFkx1TJk/MPdOcfLtXYsMUtYH3MkK5vieCXUZECAm6HGNr7ruF2/JsLd/J03JCiqiAQBPCI+7sT+mjrv5O/D6t6JYBABGIMk/dK652PLj5NrFeeU0eJv/3p1iJjnw8xHacA+WxiO1TfeKlWrJmuD9xx5iIxOVliMZqtYowGrvQZ+xy4aJ5Hyf68pj2OssD2Eb3kdopinHyEkKXhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/qBWgcsbI3CdI8jCN7M7SLFgcMjH2FnO5xgWy5Fn8/Q=;
 b=s3+522yJqpaj1fccWgkjWPWmTudcRU8UmWGnShsPesBCpOy4jrAMHTton/kTrSC/TLQ2hwHQo6KaT3tZ6oOQwVJFZ3mh/mChhoLQXPANOPfh+BDlgZxrGUqXsLiDDJFraRxoeYkq9y36Z4orofzRjdq+qJ02IHXpAijItca1cGRWC2U0MwdnKH1g212AGZs5wDVCpplyf9+mcJHwPLl/XA3XxCWKXPDsu7jULTwf8koMkeilrpuHPRWl/olwKa3w6r4wI0CdR71I1yJrrH4kcuiZ2VB4BzVDBiq72PqeDvnc22KZQvd1la2KfXGNYfE/oqUxyU/cVO08EbOF9UkYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOAP123MB8654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:49a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:31:08 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 16:31:08 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: atomlin@atomlin.com,
	da.anzani@gmail.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] module: Fix use-after-free in module_put() tracepoint
Date: Tue,  3 Nov 2026 11:31:03 -0500
Message-ID: <20261103163103.13195-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::27) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOAP123MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: c8487c85-dc5b-4063-62b3-08df39c7dd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261022075727099003|5023799004|56012099006|261009223027099003|261102130727099003|261102124527099003|261022105027099003|261021121427099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DJ8l6qjg3ayYHY1aH+DBaAvaQb8NHgXhfrIjfyL6eHknCIb2DdCU+W73tko3ntA2UaUq3mqXBAynVmQ/PLNlTXuaO+x8KcpnPhBuOB+gAi04P+pm0aaRcz5eRAKl61h0CGWla9x/JT5GjucJvxoIXKViF5wcsZVnjf3n+tTruLvdAXIGt79IGyHWk2TwE1YLcm+eHHtVHL7U1NZdl79xd6oUCwe4Rql/Axa+dn11+F+XUgoNm/VhkbSxhAp2fudkrtRN5aViPWpNBD9JXLPnsYXpcY/qmlHhwBUxHW2jSLoBnbL7Kjv7/qMB/FraMLr1DUJUp1wqcHmbgqv+lH3a3PJ5dsrAdV/scDXCSA69UyrlTgDsS2iQ9zEohXmatiTojboyRvj7Uxsaqsk9FtSdbTUl3Tc/3OaITAZxi5Nk8KP82ZH0ZhU8/xmlvRuelwXfTWAf20zKSQwhWBJnzVG7oBlNPEIGfeiKaEWMG+vXxEkBTBXOUn2DnRK04QBH0U7NUzUtG2pUWanO2qtgih6XMnTNRD1iKOLlKbePcL/1QZu4o5/cOpRY5zksNxqItuLWXni3m/oS65CO82tgTKjGX+mYaSWkHJ5giFLzEQ+lxHim36x77tjY+8mSC2gxLaZ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022075727099003)(5023799004)(56012099006)(261009223027099003)(261102130727099003)(261102124527099003)(261022105027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83tEnffPPJKTuIGieusxljLU5JZWF7fCmr1vkGm7h0r1cTW7votkiQJuRyNj?=
 =?us-ascii?Q?dtrGI3N0mJ4QIV9CU0/lh3yXOQsJNQ4i93FrK7LQI38WxljLfAIpOGWYbE6o?=
 =?us-ascii?Q?QPTDeEY8sicWMtkREiTpmmndcn8YQ85vS29AwvInU8a291ESTrJgG/azC6sd?=
 =?us-ascii?Q?uqnbiCkGgNZMXXYKa/IWQ8JvudVQ10q1S6I1eYM6/N6pW7HOO85vCLZXTL3w?=
 =?us-ascii?Q?4IxctHP93iU0M7Lg2VT0HwbGCOBVy0nj2xYOuhteo8EKBldVBsN4d1Zb6gKb?=
 =?us-ascii?Q?d/5eNTTaaF9Ray3pGxs+ais7mIYvjADtIHFrsAxma6dPgmnrLr1Xm+bSU5vG?=
 =?us-ascii?Q?IvdJ8S2aUsskZrSIx2KzllmBRRNFqeDe2bBhD1UEPXLi0gZqUObJHc+fruLA?=
 =?us-ascii?Q?Lfw+hcV2M9fCAUP5tVfQbDSjGlSoMlM3AMbXxFWAlMiOirX5UCXV2gIotmbO?=
 =?us-ascii?Q?iVH5I0gRtCDKBNBCLzlY3XzjCiPDgjXbedvrPsZnGP2Blsp89WMGYSwjC9/L?=
 =?us-ascii?Q?iTc3YJXwWCCIY0PFMVAFEehlYnFhh7LwnyJLFys4uon1Zqy2T15ApSgxaplY?=
 =?us-ascii?Q?yDuqs4u23DVt2dKHIO9IQCBmlgwiMsKX8DskUHdV71R+cPXjMgIdDd4ECEYZ?=
 =?us-ascii?Q?DbRFXfUJNXkKHWjZL3ah5X74gARJZCfZzPzw+MrRZ7slF1J9mEl5VIZ1b2xG?=
 =?us-ascii?Q?BXd0/7aBGKry4+//gI32yjSRhHLQMCafCxG9uKv/O0b4+TKNiA+XeVylpQBp?=
 =?us-ascii?Q?Y1AjRmlY+SYiIBlZygkytoUZE4yw2TZ4djCHX7dPnvpcJsp5p1arBq5a+Q/i?=
 =?us-ascii?Q?fDT4oWEFp5NRu4q6VmdgS5JHVpX3RUaXvfci/kz95oSVXRMHDZCVrolsWxJ/?=
 =?us-ascii?Q?86v5olFgVGrvH9CrxQTNKRmjOi/8y9yXsrHUIHRnVDQ6ZPO4hsCuMaBWT7T2?=
 =?us-ascii?Q?22g8snZCeiavj+ZBKhMDFSCZXQYpsBnyrkE99N9L3hUaXBHtHW5amDanJ/NN?=
 =?us-ascii?Q?0KIbO8LjYoVqxsoeGoqbtRJLXDcQs/9JKyz7Yfhv07+y//XvaHcJKTgKhX2P?=
 =?us-ascii?Q?bk8DMQNkaZ7HdREg87nRQLFl3XhSE7uBD6vZQr9Jc9mFskdfLmLx//EzRG+u?=
 =?us-ascii?Q?FYcnMiBHz23TJJghPUWJIi0tV7YYIu+zlpv6LlPJ8OL18HMB7UvQO6bWTGQ4?=
 =?us-ascii?Q?Rf2e6BmX+eRQ1Or+blQhlVHPNviqRszKTzPrYqkq1OPaAt7yUXSzQfNM7UKk?=
 =?us-ascii?Q?+THLkXihdqYutbGU/FCn3hbI3guQorQqzCvXkRl7NfbBIqlbMA13lD+7tY0E?=
 =?us-ascii?Q?aAXTThQJpbHiBKQZc+E5Av1EmSOfUQYNKay4WhSLifaf0PuTccjYAd5Krx6c?=
 =?us-ascii?Q?4HvFKwMIRFyr6n0r8spfrQ5aYQ2HVUf9mdothILUN2aRDnmvh7KHues4SoL9?=
 =?us-ascii?Q?4LLiFiADUDiL2vXZo9jCk9YBSOGByZflgEVc3LVZGpNEYyPm4UhbPCds+idb?=
 =?us-ascii?Q?m69mAcJVjykKt+lDUEQmcgIN0DuO1US4THjWWzdpXaG8GF+RkDIAxuL89EB9?=
 =?us-ascii?Q?LOvypo4M+59jPv4L7hhGeORXIId3zREDRb+y8EhuK9EnYQ6WdiPXDijFVjSP?=
 =?us-ascii?Q?/ph4PNg5Es+kFScfD+wHT2KbwzMjm5jY/eOZIoxwXwTbs5qoAo/cD6H9ASZO?=
 =?us-ascii?Q?siAGFpxywAQAu5vFw40JheasuSMBG8jH8ZE9Fupo6+eJNGIRyILPHHofqb+x?=
 =?us-ascii?Q?34oPFM7SVA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8487c85-dc5b-4063-62b3-08df39c7dd59
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:31:08.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUJpCiV2S+BCJcI94/9GRVjGN4Qah5XhsC2i5fxrxyplQ64lUBxdvSFVqhED6VW8rwwKM/rjOoO01LbKlXzN/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8654

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

Resolve this by keeping trace_module_put() after the decrement and
enclosing both operations in an RCU read-side critical section via
guard(rcu)(). Because free_module() invokes synchronize_rcu() before
freeing the module memory, holding an RCU read lock guarantees the
module structure remains valid until trace_module_put() completes.

Unconditionally entering an RCU read-side critical section in
module_put() would incur unnecessary overhead on the fast path when the
tracepoint is inactive. Gate the RCU critical section behind
trace_module_put_enabled(), which queries the tracepoint's static key
via static_branch_unlikely(&__tracepoint_module_put.key) (or evaluates
to constant false when CONFIG_TRACEPOINTS is disabled). When the
tracepoint is not enabled, jump-label patching turns this check into a
no-op instruction, bypassing guard(rcu)() and falling directly through
to __module_put(). Factor the atomic decrement and warning check into a
static __always_inline helper, __module_put(), to avoid duplicating
logic across the traced and untraced paths.

Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v2:

 - Retain trace_module_put() after the reference decrement so the trace
   event reflects the updated post-decrement reference count and only
   fires on successful puts

 - Enclose the reference decrement and trace_module_put() within an RCU
   read-side critical section (guard(rcu)()) to prevent the
   use-after-free race against synchronize_rcu() in free_module()

 - Gate the RCU critical section behind trace_module_put_enabled() and
   document in the commit message why this check is a no-op via
   jump-label patching when the tracepoint is disabled

 - Factor the atomic decrement and WARN_ON() check into a static
   __always_inline helper, __module_put(), eliminating code duplication
   between the traced and untraced paths

 - Link to v2: https://lore.kernel.org/lkml/20261022184517.66438-1-atomlin@atomlin.com/

Changes since v1:

 - Drop guard(rcu)() and relocate trace_module_put() before the atomic
   decrement instead, avoiding RCU overhead on every module_put() while
   safely relying on the caller's held reference (Petr Pavlu)

 - Link to v1: https://lore.kernel.org/all/20261019034857.654569-1-atomlin@atomlin.com/
---
 kernel/module/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..14bad822e18f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -960,15 +960,27 @@ bool try_module_get(struct module *module)
 }
 EXPORT_SYMBOL(try_module_get);
 
-void module_put(struct module *module)
+static __always_inline void __module_put(struct module *module)
 {
 	int ret;
 
-	if (module) {
-		ret = atomic_dec_if_positive(&module->refcnt);
-		WARN_ON(ret < 0);	/* Failed to put refcount */
+	ret = atomic_dec_if_positive(&module->refcnt);
+	WARN_ON(ret < 0);    /* Failed to put refcount */
+}
+
+void module_put(struct module *module)
+{
+	if (!module)
+		return;
+
+	if (trace_module_put_enabled()) {
+		guard(rcu)();
+		__module_put(module);
 		trace_module_put(module, _RET_IP_);
+		return;
 	}
+
+	__module_put(module);
 }
 EXPORT_SYMBOL(module_put);
 
-- 
2.55.0

