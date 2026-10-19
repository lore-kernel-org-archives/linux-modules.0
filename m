Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021133.outbound.protection.outlook.com [52.101.95.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8B361952;
	Mon, 19 Oct 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409277; cv=fail; b=HLFSj0k4YRWT96+RHW9KfIb/7XZ4gnmABLjdQoqW3J/aX8KpH0Y7F/EWF2cH+IuNgdSttLj3d54ArwShFm3D3ngFRuivOTRQ4ziw4SNFsZI6eqxmqlfJrM/CZDhjHLHxxytraIYiiyaJygyVoloSJYytvDtCX9nlyQpHziYr5s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409277; c=relaxed/simple;
	bh=0CbQP3bEvBnQ74mkkNnB9s673z0Hgh48pz+hR3NV/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYB6EMxhMocz65zUViIX2HF3WT0twOiZyV3v64Bab8lqmAzhs8EGsZDu9aePSK3HTxcHNsSUYzduRZbcBEVGjgLKl25JqSzBR/E/5sZZPNS32/VDvA5pknnV6upO81lPMqqH+NFhJQBq6SSZrWiNgw1ZW0OyIWO6SwZldVnNn2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf3CCFxJZ4QKD1f5Lb07G0uaCWR9WpPIV0C9Kf18O/fMXY5cvapjZz6X6LpE6sAQumXvj9sZHz0L2278ru3oIUkLBGVKiBEyUzRvFeua/UZO71YHhnK0ZdSUS6o0Zo19KarrjtwqiX/gMglwhVQAh/i0zNIZ0H/obwYD3nRqsqySJERvllM1wosXg6rSWxyGhuXgnKtbgqXY64sWSCT43ueBJauJlTcRfvy1FTPoFLUbVfULCX/it7YdbsMyHJxUviSor45+/xS6mFoaxXytM1liOvXFcTkoaQGL58Aa1tL0BEdTwdOKT15Nny2XzTI1llhPOqc89eFMB/2LTyLM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/mGqzHlMTNmYHMQVBuf17sl5BxH+fRky3OIO0uULf58=;
 b=TesVcmO225eBzEhwkVnR9t+joo5a4fJtr7s2/ClEZoxyfzZtcj0Cqp7c7ydwTvP0yfkghH27+AfWF1aHx6bFoypvJMs+17jkmxhH9pfDUywTuXBMGXv4qb3qtEFVTrrga6NVTkllG197mTi7AYw9HnkTfQepT2F6ZtHVQlDOngdKXBM0adnleCJvF54EKpOXcqL42SORXYirYjsNJAWyMkKq8J33CfsFQiMK27JTvDVVx3dGYlk2AVbTPtJadCLDU3DHNzSkH0jE/bSf4o5euTvSJKG7oGZeZyeNIPRkeBk11EbwQ5+o0Idr6q8qbeH7X9Yw7+FCKTqonP3MVI3aUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB7474.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:27:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:27:50 +0000
Date: Mon, 19 Oct 2026 07:27:46 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix use-after-free in module_put() tracepoint
Message-ID: <4ex7fuogdtmtxil4i2bzx3yqnkqgb2x5wxysqpwapauohmcok7@jvaytjn5fo62>
References: <20261019034857.654569-1-atomlin@atomlin.com>
 <a5e66dc8-155d-4eb1-add5-8c182879cefb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5e66dc8-155d-4eb1-add5-8c182879cefb@suse.com>
X-ClientProxiedBy: BLAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:335::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: ceda9bd1-67fb-4406-5567-08df2dd40242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|22082099003|3023799007|5023799004|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hPaVD8265xStGYxRtjyEu7TNbadQmZRG8JOAVB76hyktmiWuOA8Uoo6/OuMJD/nfncS485Q6iUmYWGjjEPOvFWR8bCZefXSCo6C/1qcIyo1sokaKdo4SmPOKLJYtpdBVhhDF9AODBdXR6Inn2HRlVkvRT2h/FuY5a3GQbWuMCSOW60LCh1ysXX69jV5qTUfV2C2yvE6r5M9+8GDMwx1AadfCgcPg2YyAixUnLjmHsg4DaAGzBY6snLA1zwPpMs32X4YGs8PjlW4i2aRvX25pHVLghB4Kuy1z9Gx6ylf0uYv5/NnNI1c6HQveGvG1umu2/OT3KiTyx5IhZ/eRNtjGGAUdAIl7vhpWLM02kFiVbswPSMP5rLzjigTGHWYiAEan6cBAe7337/D0eNfThHaql7+b1GXF2si8L/KAt57c7nFWCJz/KYRFbV7SS1aMjvp4Uh5oFPv5qQUrpg1hek7f++uVeF2lLEUMWrK/GfFEeYEnSB7Z8CJxgIdlxtYWu3TlVyOq3bzoaS9WckN6GTFikD2Pbkk4cJd3Fcu9dP67QBCKqoEa27JbAOsEhUTExfYQ+IBz642tHGPjgUwDkcLzuPd6M9vjsqQ7KtGDIW2P4YRX3TSqh8vUd6fOw5QTGkij97CzJzURNyTRMvfIQUIs9x3U2CruTMh4fdh+HkeC2zY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(5023799004)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0o1d3NFMlBlRGNmQXU0WGRyUnMxNjZOamhFWG8yMjlZMW82UjN4T3JVVjcr?=
 =?utf-8?B?RmNVZTFDUDREWU9rYk1jeS85UHpzTFErUTFOSUtXNkYxNkxhbXNlb3pPZlFa?=
 =?utf-8?B?WEp3UldsRjZHUkI5ckJlRlY1UjVFdzgyUGFibEdBTmJ5VUlIeldERHI0T1RM?=
 =?utf-8?B?ZXMxZm1yK0M0QTBwQ0lTNmdGcFJXbWNSOEJpWnZaWmFjakJ3RGR6dTVUZW5D?=
 =?utf-8?B?YkFYMitMaG1GNVg3cGVUczl6ZzYyQVJ1TWlwMTN5TzExZWNicHBWNWduNW4v?=
 =?utf-8?B?NEZ6WWdwRFFsUTUwRzNBWHY2OXFSTWFiU2lqRnl0TjExVlE5WG42ZjRlZ0Ex?=
 =?utf-8?B?N0pTemp4S1grbnpLOElGcUtqNDJ6emNNRmdtTFl2MzNXajJKZUVJbUozamky?=
 =?utf-8?B?dkpCd2oyeHlUVUZLOURzZlBRQ3JJcGlKVDVXMUtXckhlVlZRWVlhbDcwczlj?=
 =?utf-8?B?Qm5SM05ONDZ4YWJ5NnNIc1RBTDBQUUplbUY2RnZvUzdLcjVza1l1dHY2bE5C?=
 =?utf-8?B?YXkzZytXU1d4Q2ZCRFgrcXRlbDZuOWxMVFNDZklnekUxU09rbVljL1B5eS91?=
 =?utf-8?B?TW1FRVhsR2hyNnZhVnVpZ0VhSm5PcUhSeDN4TmpPZ21aSGovNERKSEJKQ2dL?=
 =?utf-8?B?TG53bjdiUS9pdlVBelB6bE5JMTl3QkphaG8valdWS1FBcTVuVklUQi9VTDZO?=
 =?utf-8?B?U2VKYW9Ta1NRa0xmY2plYmNweXdoN014dGpTU016VEFDOGZFQ3JBVFE3SGxo?=
 =?utf-8?B?dzhhTFNBSVZoVjZDU21FU0F1bVFYOElGekdDcGorZlVpOGJjb0hsTUVUYjVC?=
 =?utf-8?B?WHBqclVDaUxseG9jY0xnbTZYZVR4TmRQYzBUVTBYM2JhSm8yemdJY1JFREVB?=
 =?utf-8?B?QTQ5T1Q3Y0REYXN0ZURxWFk5SXZVZyttUGhleHVPTnNKOHJRR0srTUV2NzFn?=
 =?utf-8?B?UWJMR2RWVGNZRDRBN3dSMUdCMnVkUnRTLzhONmJhcXhLZmRlcWhWNzd4NnhS?=
 =?utf-8?B?bSt0VFNUVmk5OHNObTFhVVF0dUx6UkdjZ2pRQTNpKytmcmVJMmhWNHYwak5o?=
 =?utf-8?B?VWJwYzZUekxyWjgxZkpLMi83d0FLUGYzMitYVlUva0RVNzBsSGI2eFNCNWpQ?=
 =?utf-8?B?ZVE5YTVEWjg0VmFIR0FaWXFPSldIdVhrRFVGOGNnVE9XOVRRS3pKbm5maS9k?=
 =?utf-8?B?ZWFPa1UvV0RycEdnejc1SDVkTWtzMDlENENDYWFmUEErZzA3OGN1YlliQjFX?=
 =?utf-8?B?WUs4RGMzc294MXg4bUoyNi9QQ3l1NHJqcmJ6TTB5T3Jmc3BqdnB2ZEx1dHpV?=
 =?utf-8?B?TUpaVE1NeVNVT1l6UzVtazRKM0lnTUV5MnlIbDEvOEhocmhZeHU4ZG5NOVJp?=
 =?utf-8?B?dHZIcjJaR3RTNS9vZUpzakFlc0tudm5LVmk4KzdNams3VFNzeXp6cURQVUhX?=
 =?utf-8?B?cWFzNDVnYXBZM2RaR2gvWFgwVEFBTFd4bEpWTXhXRGdwS0V2SGZvVWNKNk1a?=
 =?utf-8?B?ZHdsWGRlUmpTRnAzbkZlbklMcnZYbnhVandrb2VuaUNUR25lVVN3b2xPbTY4?=
 =?utf-8?B?enptcThSbGpHVURWcWh0WEZCTHFPWWx3YVNCOWlQMXlBNTQxMzE5Rk5BZDdz?=
 =?utf-8?B?cmlUd21lc2d2eGwySXBpdmRaTm95ZVdadTdqUlE5akxWN2pVeTF0RXRvM1FY?=
 =?utf-8?B?Q3cxd1RVVmFzUjgxbmN3eXZMcXA0L3NBcVJudlpOdkp1NVdialFKM0VTS0p3?=
 =?utf-8?B?YmRXSTdIZ3hDYlVFd1RVU0tXUld5TUMzQm1rTlI3OThFVGpMRnp3NzhGRTZY?=
 =?utf-8?B?WCsvRlJLSGh3TkNvNzM4N0VoNFNzalVTbm1qRkhOTExtaTZzTGNESVZKRjZ3?=
 =?utf-8?B?YTVtbmhjV2VWbmVPeU9WSnZPQmcxSEo3KzdDUGFpL1pZaGgrSTFPeDZ6a0Zy?=
 =?utf-8?B?M3lzTGZac2h0S1JnV25jdTNxckJzay9SYk9DNDV5T0hwYkFUYy9FRDByVWJO?=
 =?utf-8?B?VjZUeGdYMFZMRE01a1NFMjk1WDQvbXR0NVNaUm9EUnd1ZWtjY08xYnFWUEU0?=
 =?utf-8?B?Zjh4SmlrM1ZOYWJGdlAvVFp6WU9YQTI2YnV4Y3M0dmVNS2FMNlZjR0ZudVY4?=
 =?utf-8?B?Tmh0NnZ3Q2JjUWpEdVgyL2JITWx4MTU5TlRZVlQ3NVRCTWRnRkdNOThVUldi?=
 =?utf-8?B?MHA1MDRSTUhCdjBaeCtzSE5VWVRPQU5sNHJVbDFWUGM0RHNoSm5xWU15SmIx?=
 =?utf-8?B?bE51SUk0bS8yMG5LVDFhUTdEM2VxWGdjSXZvb1VMc3pvSVRGTTVSQ05seGsx?=
 =?utf-8?B?NGxjUDBnVHBMQ3JUL05naXIxR3BEaCtuVnBUZUR5WlptM1BSMjhHZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceda9bd1-67fb-4406-5567-08df2dd40242
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:27:50.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/oPYKVY2MA3b/DnWyeFOSNVpXOJYlYB+0KTsUxG5/mwkJfrZtKW8QWhokVGuVVGs4PXc5j+m10TZjiguFWF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7474

On Mon, Oct 19, 2026 at 10:48:44AM +0200, Petr Pavlu wrote:
> On 10/19/26 5:48 AM, Aaron Tomlin wrote:
> > A use-after-free condition can arise in module_put() should a thread be
> > preempted immediately after decrementing the module's reference count
> > while the module is concurrently being unloaded.
> > 
> > In module_put(), the module's reference count is decremented via
> > atomic_dec_if_positive() before the module pointer is passed to
> > trace_module_put(). Consider a scenario where CPU 0 decrements the
> > reference count without reaching the baseline MODULE_REF_BASE level and
> > is immediately preempted: it relinquishes its reference while still
> > retaining a local pointer to the module. If a concurrent CPU 1
> > subsequently drops the final active reference, the module's reference
> > count reaches MODULE_REF_BASE. This permits the module unload sequence
> > (via delete_module() or the initialisation-failure tear-down path) to
> > proceed and invoke free_module().
> > 
> > Function free_module() invokes synchronize_rcu() and subsequently
> > releases the memory backing struct module via free_mod_mem(). Because
> > CPU 0 was preempted outside an RCU read-side critical section,
> > synchronize_rcu() does not await CPU 0. When CPU 0 eventually resumes
> > execution, it passes the dangling module pointer to trace_module_put(),
> > which dereferences mod->name and mod->refcnt, culminating in a
> > use-after-free. This sequence of events is illustrated below:
> > 
> >     CPU 0                                       CPU 1
> >     -----                                       -----
> > 
> >     module_put(module)
> >       atomic_dec_if_positive()
> >       [preempted]
> >                                         module_put(module)
> >                                           atomic_dec_if_positive()
> >                                           // drops final reference
> >                                         free_module(module)
> >                                           synchronize_rcu()
> >                                           free_mod_mem(module)
> >       trace_module_put(module, ...)
> >         mod->name
> > 
> > Resolve this by acquiring an RCU read-side critical section via
> > guard(rcu)() in module_put(). This ensures that synchronize_rcu() in
> > free_module() blocks until trace_module_put() has run to completion, even
> > across preemption under PREEMPT_RCU configurations, while avoiding the need
> > to disable preemption and preserving the post-decrement reference count
> > tracing semantics.
> > 
> > Fixes: cb0b50b813f6 ("module: Remove preempt_disable() from module reference counting.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  kernel/module/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d0e1e0bd2ad0..8e2d0ab96e6e 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -953,6 +953,7 @@ void module_put(struct module *module)
> >  	int ret;
> >  
> >  	if (module) {
> > +		guard(rcu)();
> >  		ret = atomic_dec_if_positive(&module->refcnt);
> >  		WARN_ON(ret < 0);	/* Failed to put refcount */
> >  		trace_module_put(module, _RET_IP_);

Hi Petr,

Thank you for your feedback.

Moving the tracepoint prior to the decrement is certainly a more concise
delta and resolves the use-after-free, but I opted for guard(rcu)() for a
couple of reasons.

Firstly, symmetry in the tracepoints: trace_module_get() records the
resulting reference count post-increment. Moving trace_module_put() would
introduce an asymmetry where puts record the pre-decrement value. When
relinquishing the final active reference, trace_module_put() would log
refcnt=2 rather than refcnt=1 (MODULE_REF_BASE). For scripts or tooling
monitoring reference transitions, this off-by-one difference can be
confusing.

Secondly, keeping the tracepoint after the atomic operation ensures we do
not emit a trace event or dereference mod->name should an unbalanced or
erroneous put occur when refcnt is already non-positive (which triggers
WARN_ON(ret < 0)).

> 
> I think a simpler fix is to move the trace_module_put() call before
> atomic_dec_if_positive(). It would change the refcnt recorded in the
> trace from the post-decrement count to the pre-decrement value, but that
> isn't particularly important. For instance, xfs_group_put() and
> objagg_obj_put() take the same approach.

In the case of objagg_obj_put(), the caller invokes the destructor
synchronously within that very same thread once the count hits zero
(i.e. __objagg_obj_put() -> objagg_obj_destroy()), without an RCU grace
period. Placing the tracepoint prior to the decrement is therefore
mandatory there.

As we know, with modules, destruction is asynchronous: module_put() never
frees the module directly. Instead, free_module() already executes
synchronize_rcu() specifically to ensure in-flight operations conclude
before releasing module memory. Prior to commit cb0b50b813f6,
preempt_disable() served as that RCU critical section; guard(rcu)() merely
restores this intended synchronisation contract without disabling
preemption, incurring negligible overhead and fitting naturally with
existing patterns in kernel/module/main.c.

That said, if you feel strongly that avoiding guard(rcu)() and keeping the
diff strictly to a reordering is preferable notwithstanding the tracepoint
asymmetry, I am happy to adapt the patch accordingly.

Kind regards,
-- 
Aaron Tomlin
