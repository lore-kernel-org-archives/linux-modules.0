Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793287446;
	b=J/xooQ3Wd1BuzMbEGYiOiXg0ah/XZFSgnGhmyUK8qA4xxG+NLDD56mblfpCAC33x7Mt3
	 WtkuTYHg2AC9+NJl6KsBZuB/tiXIeLzS01W/MMb0LsMO+dq3zrvzhDvvlCJUQrASuqgDY
	 l2wqpZKE/rX4fQaYyZtC2frFR2jGjw7dipIZhtws+nT+8YU8zdDRBjgvU/Xfl5JpC5HeB
	 1mN8cYmrro5az+e2q6TuHdd0wH1FmmZJ1l7FDMdiLhcUxY33zKO58YdDk2iwtyPNd9GTy
	 J4SYqSLgqyCBCbQgAKyAlI//B3Ss9WmTRv4kgwS8f8jTNY+iIioj/vuSgHPz8CwFWYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287446;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=B+Iy9KXGVfe34/z+yC7f7aH0Fb/hxUEycmQZPPzS/Kw=;
	b=gjx6FvsNqWgS1flW+/rW2E6eH+NjoNY2R4ExIQsDclde2kY4U9r1lGxeHau0PcNcgIW+
	 BPJsT2kMoRpEDhU8nTKZ4eWGiqHBcYw//tmUyFtrZLrI0617UdrVlrDkCXAEml+xTcT4u
	 0xXT5YdPMxZuLlTTXTFaA5nO3+SsRZLdg7yKsQnJfdYHGmry5/0MUzQj5EA9UbHe4xJwV
	 Z4Ey1FFPlp7h7JCJOccPTJWU0FatFylgVy1/RPD6nqsRfPNtlK2Z5hPn5gUymW2/vYlfQ
	 w6UWdFv/jDXIXsvPEZ430ZDRSlKTJ1WSdWK7xuaX4Osba8kNS9eogmH9lYW2E/K21Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.135
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022135.outbound.protection.outlook.com [52.101.101.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AF606A31D;
	Thu, 29 Oct 2026 15:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2AF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2wkj8W8oG0YiTWDB30gkcUTy3/ijTy3f0zS/mq/chOaBFGuQl8dQp/nRMhTHRpLUhnz/k6K0mkAo+jW3IApsJT/xsXcPrbbIBZ02o1V0Cxir2aWvOgkku2WlmjW3Jfxtk5L8fD+BYZHK2s7SFfs2YQvMr5zqvgViqolhH4Tr7yfhXByRLfXfZY7HoZ3LIoUT2yjW31bvtjZyMElT0s1PQtbAHLOIKrSqUgNga4uJ/+AQTiVTODRYHWbHlJYbxlXxqlsvXONAZA9F2p5IsDiGcdDD8NPDJEZAz0yxjjpdN5n+/E97hEtym/iSrusGlws3UlIoBBCDIOxaYoGEAJC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=B+Iy9KXGVfe34/z+yC7f7aH0Fb/hxUEycmQZPPzS/Kw=;
 b=TV0wrxqKNhOda2p2/GsXiYt+qLgF2G0xPPjvcm+1zb8sohhmOIqxVGNcAC3phPfvJMPD3WOlV8TTzrYlPqTjYjhexKwDcew3iRMI4GTzlk9LUdjJ5i6UI3muyo4VELv4dVOCJ4qNj38Kqw2LvE7GhGHZLf0XxE1ZbgQWVErvrRKtN68oShjPYtfeOllHA+lc4bfZh9+PKCgdtcsQd9TIQNXacju4OyWm+F/tiJFz/B2bjXyLeNCLZoXKJj2mHivkAVJusWFO2ztBQQ893nXJtutMK25GWESywHmla9j8gv2tiW3xDU/U6xSLuzLexOFxFr5VntaBjutaLqny1i976w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8912.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:497::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:24:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 15:24:02 +0000
Date: Thu, 29 Oct 2026 11:23:54 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix use-after-free in module_put() tracepoint
Message-ID: <an3o4dzjwt6p3wt45twtqsv2t3x527srauhcqv6u7uxtt7zz3k@22ye3vb5tf4e>
References: <20261019034857.654569-1-atomlin@atomlin.com>
 <a5e66dc8-155d-4eb1-add5-8c182879cefb@suse.com>
 <4ex7fuogdtmtxil4i2bzx3yqnkqgb2x5wxysqpwapauohmcok7@jvaytjn5fo62>
 <f7fe0439-d123-416d-b6fa-27a6dcf25d39@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7fe0439-d123-416d-b6fa-27a6dcf25d39@suse.com>
X-ClientProxiedBy: RO2PR80CA0006.lamprd80.prod.outlook.com
 (2603:10d6:10:2a::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: a93bf2d5-6876-4bec-9ffb-08df35d0a9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|5023799004|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7UEnVUNb85LGPBLkeYUxVSBSTrKxi3HwzwMUH/671UgADUI9xCEEbkU+DsAquQ6PaZM+7Lqi/jAlf2KRdZoP54h9n9kBQ0Bl9rJ4sniBgHR+2m86nNKGS3L+Fe/+FfSGZ0Er7ZYC6zPzR6W1e142VhEAnLiKcnbb/FsZ7CauE7nrQnLRLHF7d4LrcJY4tcb01DlcRII4vAb7+3ZDmuER5EHXUmAxhh1p8bxjSS8Cy/bqdr1K72La9lEwf1roNWlDNxuqvR3+H0HAloUqU7d4A6XbgXRRgeI1mMmc2NWaoFcUCaFDUEBnHjtGVxi9Ep1DKVA+fxjSCyLvdZn3OmquFKCuvZRWI4nHIhDHU8MOb3Hkw4NQSDJ6QHLBmCthkEfheyrgyq4z5PolkQh+8gBcpAtTYsVYp64qA2EP+ZHelOJleN8N3tVkURzDLoDCdtYNa2UDe65F4KMLKeFw3WrlpbcyDEcRm21uHq0zZ0Tlr0fknpYRP/yYrSsbBfGTqN4N8cF/fGeRflov0wpi2wwQaRHytpBowPdllQfXEewDu/P0uSCFjZ4UHN9Jsxuus1in8IgLCk7opeUEmL6vyCagecRdgG72m/ha/YeiAuyB9VfWVnqU2K6Jzk5TcMzs0Wg6iaoBo/Y4mhXm1n3oaPKudWrqrqiuQt2VfGGaUzARURk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXpIU0hXc0xnaHZ6VEdoUXliRFlEM2dKclhiTnZmc04xZWt6cjBvUER0YnVa?=
 =?utf-8?B?MnBvZ0RUcmFWTWljUWExUHc2anRwTU9jT2RUM2dDTWVJelh1VjBOV1R1bzNI?=
 =?utf-8?B?aEN1VWVuQzQzZXFLdXBVeXMyVm5Wb0ZiK0ttSjAxMjdxcEZCeDBpUkNZUU5y?=
 =?utf-8?B?SzJaYkNTVVNIMnpxbldrQStoNUhzUjBUa2JPZnJjcy9aZE4waEtFaU5uSHZP?=
 =?utf-8?B?UDlzR1kzNHlaRXNuT0JEcFhkZ0EwSnlwNnNTVlVVY2s5bDZOY3ZWeW0yMDlR?=
 =?utf-8?B?NHpjbFprMTkyeHF0OXBLVkJoVjhleG1XOWROaGtBY0JvRFE0UE5OK1kxcFQ3?=
 =?utf-8?B?RmJ2TW92enJ6UmJpMnBKWXUxUUFyczRBOUI0UXlvVlloZ0pqYW5MN0wxSTJC?=
 =?utf-8?B?c0ZkT05WNWpkYlkrNzBKZlhOVVg5SFcwOVdJMS9zR01oMHZJSDNrbEhGaWZT?=
 =?utf-8?B?bEc5eVRESkJ3UEZqME9obThvcjN6bHN6cVpJd1gvOS8vbnExRElqd2ZmRXIw?=
 =?utf-8?B?Q1pJNUkrRjFrS1E1V3FoaEZ2ZmhKcFdhYjVJcmw4TU55VW5oOHpyaFNJM1M1?=
 =?utf-8?B?RDNJRU9nWXNkN2Jpb1l4czdGaW5Dc0psSjFJRHhwbGp4TEhjdy93UXVPdjRC?=
 =?utf-8?B?SDh6WjFLWEJFOUZTNVRMeDVRbC93bkY3aFJvU3ptNlIyN2lxbC9BMEF6WmhL?=
 =?utf-8?B?L3czcGdLamVKU3NFQnVKbWlKdTF6Zkd4S28yaXYyNThMRHM1MVk1cXVmMU9p?=
 =?utf-8?B?cklwVVh0OFVuV2MxVGFZZDBYUXVReVMyN090dGphNWJ3Z0plMVlXMTBCVkpw?=
 =?utf-8?B?MzlHcTlUeHBuWTZlWCtBWFkxTndlQ3g2WUhwVFlNN3A0cDBHVkpwaWNDQitN?=
 =?utf-8?B?cWRaUnVRWmJrL0QzRm1LWmdNUUpvK3NOSGkvbU4xQlQ5UUR6NjF0TlBzV2N0?=
 =?utf-8?B?UDMxNm9RV2llcUNRdFF4VGZuZXNZWVkweHdaY2E2WTRveS80emM0Um12SFJU?=
 =?utf-8?B?bVVhWlB5N0ZlR3QyZUw1MlkxbmhDZ2QxK2lWbTlYNjdNT3E1RGR0dFZWT3U0?=
 =?utf-8?B?TGxzQ3BwY2FkZ2NXL29qNUNrK2FpSiszeHAyMDV5T2NLSXZudDFKTjkxSk12?=
 =?utf-8?B?NWtueHB4N1ZtUXl6bmtEaThDQmNEVFdQWkVMYlFnblVnZkZsQ3ZYdDBHNExG?=
 =?utf-8?B?cDVhc1hoUm50VjhjNkpRVGZDQ1Yzc2dybkxsTnBxei9RT2RPdVhObUlXczI0?=
 =?utf-8?B?Wi9CbnB0RUlxbk5kaXlGUnhqMitaOTRkOXdHWjE1ZDhURHFIamJRRkhLN2Fl?=
 =?utf-8?B?TUpqTittaG15ZGpra2tRcnc3ODZtZ0N3RjhMSS9qZzRkVHhMcklHNkluZzZT?=
 =?utf-8?B?aVVSUElMSUNXQ1RZUkhFNko1YWQ2eHhWU296Z0NLOW5wazN4N3lDNmhHWm96?=
 =?utf-8?B?V2pRdUQ0VVVLOWgxUGJFRHoxT2h0TURTSk81bWR5VzlDd1gyRnd6Q0tUb2hz?=
 =?utf-8?B?VmhyVG1jMXZTcUhHeG4rSFJyL09KQUtmd3g5c3I2MERsY2R3dzJvYW5icy9r?=
 =?utf-8?B?bUpyMjlML2dwMkFVTWdFdGtHUUdyR0xRK09KNDNFT01YSXdJaDR5NXZiSlJp?=
 =?utf-8?B?V3dDUUJSU2FpbVZoUDZwWUszNlRwT0EwYlcwdnFpTHdKTUFOQlI5Zm80bkV5?=
 =?utf-8?B?MjVmSUl0RmRRWjJLVGNya0JDNTdRYmZZN1JRWmVnZTJiL1VuVHd4KzRxSE8v?=
 =?utf-8?B?bmN6a1BpcUZKZlRsZklDam9QUmhqUVdXUlhJYkczNC96ckRxWElqSXg5WmdZ?=
 =?utf-8?B?TmZpMUZFQWpqMkd2dzJST0hRMVVzK3o2Z3NSd0gwTGt5Tkw2cVdBR1ZFS1Vx?=
 =?utf-8?B?SytZaDlsVFh1ei9JMjhWN3lIOG43b1lnQXFDZU9XelQ5bVJnSzJLRk5mWTVy?=
 =?utf-8?B?ckcrR2xBN3RIT05SL2QrdnNDNWVTaDcwRGRYaTJ1UXNSVzNBbFFXbFlZbmE2?=
 =?utf-8?B?M0JlZnZKNUZXSzdMUDU1VVhwMkVpME51WVphVmw0WEtIVzFOZ0wvTnlQdVd5?=
 =?utf-8?B?RXNSeG9NRXVpTURDVHN5cnA3bkFYMVo0MWo4eWxmUFY2OHV6WXlHWkNoOC9m?=
 =?utf-8?B?MjlRVjRLRjZJeDJGYkxyaHhWTHFHaXM2Zjk5Qk9zcG1tOXZ6ajhtbE1CdEhM?=
 =?utf-8?B?Qjg2UVd2NkZPeGdRMDBWSGt2endyaGcxT1ltQ2VnN3pBTDNmdm9UQ2ZUTlFa?=
 =?utf-8?B?d0tsRkN6S0llQytPSGwzb2cvQnRvTG81akFoWTgrR3VneEF2ZmJsd2krblFV?=
 =?utf-8?B?WmhyVys3SlNEa3hmZzBncytJZ0FSL2dxdU1oYkxSSlBBVzhrK1ZhUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93bf2d5-6876-4bec-9ffb-08df35d0a9a5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:24:02.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExSZbi+/c/yCoM1VPmbOsGLd+8QvzQ5L43reIxr4I/bV9w+NguKkC2QndpK7sf4oAYGq3Wt9O9BUUeoYQOZtEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8912

On Tue, Oct 20, 2026 at 05:22:18PM +0200, Petr Pavlu wrote:
> The trace_module_put() tracepoint is used only for debugging. What
> tooling are you referring to that could be confused by changing the
> recorded refcnt value?

Fair point. Please ignore. I have another idea to avoid a reference count
that is off by one.

> Normally, module_put() is not invoked concurrently with free_module()
> and doesn't need to synchronize with it, so an RCU read-side critical
> section only adds overhead.
> 
> The preempt_disable() call in module_put() was previously needed because
> of the complex module_ref scheme, but that was replaced in commit
> 2f35c41f58a9 ("module: Replace module_ref with atomic_t refcnt"). Commit
> cb0b50b813f6 ("module: Remove preempt_disable() from module reference
> counting.") subsequently removed the no longer needed synchronization.

Agreed.

> The fix is valid, but I don't see a strong argument to introduce an RCU
> read-side critical section in module_put(), especially just for
> a tracepoint that will be disabled 99% of the time.

How about the following to ensure the fast path incurs zero RCU overhead
when tracing is disabled, gate the RCU critical section behind
trace_module_put_enabled():

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
Aaron Tomlin
