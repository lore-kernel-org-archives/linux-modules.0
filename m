Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793744403;
	b=VODfGsggZrHBG2sRVDgl9AfrsM4JBOE7Bp/Xi8S18BRHlJ0l85JS3GA6zXwg9LdxEiLx
	 yHQm27QxyqSCsMKY/JiqnzFnznJg9ayALRCXji4azFoSzACjjKuHltDKcqhhhzJjnMRV8
	 betSijnI9K4KHoGZ9zmfEKRj5I7os2zSnj4ndMnk1XJJMz8O7I4LEb00ny+i3TOdjmncL
	 PsX/JT7kTtrdNpp/k6AYF0H7MWz2BNF+PpE/dL5X9yhPA7EKUQaloPjGEtugPRIyf1MeP
	 BBDQ20OfXjN1kV5zAZ1O4Qy4IKjV8RNu32cRs2yQH+XnLwRlNGj0fZ0Xi0jieort8aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744403;
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
	bh=viFqSXwGZCNY/KAf35usFf+1OwB6SuapVmFMpxm+pYs=;
	b=FuSKqs3m3ooGuKqgQMeyZzmOGFT8qrU/nkLSlRLQ29Ik+heOg5wXDsZVS1m3HedYwsY1
	 gwCcjHYXKAWaiq//0a4IDGpr7T0l25hXyRDkNeaDYBgjIGXqLjVZsUyccSxZ5YnU1YBxJ
	 lX21cUKVs5kTfaUmXkeGStLosIRWgTCnjA5tPvB8LYIKBPOraLb98HO19XRM/Nyt1ltRw
	 LgmQauN0DtD1ndxQRB2/dOgXokKySgkHNE3I1caBH16hqyybqWwcwCpdt9kmYntNXxLIg
	 o8wLnJRF/GtMA+f4fMUVXuIQjG082oR6qfSPCfIR4O6iCKlED3Kg7lW9u4yfmT/Uosw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.133
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020133.outbound.protection.outlook.com [52.101.195.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A669606A31B
	for <linux-modules@vger.kernel.org>; Tue,  3 Nov 2026 22:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A669606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7i9srMdtNlhSb+gf6u1l8dZWJwsxI9VIUpAGMrjTVLCe2hmWZrl7XAS75kmhciLKzeT1ti6sIdjVIVophevkTBmddHBggs5GbUFssZAgyPfh4Gl8gVqwlLeOfL52YBW2e6DFC73PJpi9s7jAkxeo54h0RpcCo1aYrcESnQDnaBqD06KEr676ICpMjcOZAVK7+L14UPWHxuY4Voz7AeXC8nLtBvvR8wisGz1omf60rRESENcQfU/OGKswmjwcXu8pcp1rWZFJ20qXahb73yITjKBwp/iyQN1KJ94uyNmuuAnyNcqr0TSDmbNacdbQY6FHeiShph6iaoaxJtyTxSWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=viFqSXwGZCNY/KAf35usFf+1OwB6SuapVmFMpxm+pYs=;
 b=Q+09H6LVu7I4VRFdZrrlK3LKZmxFkTB38O0UpcKHN4kVQDRRwWIZUETEcdNk/3a6jHckXWhVNdQicmk3155ZTHIq11lBNkpY79tKA+oaK/elcrPYHqY3ZtdvoYyTHFvWutJceXaPHHgeOjzssJ6qy4wk+HyOIwcuQtI6ESrKnuYP7qb2+7upIZLAmWy7tKyZ0HLlvfz1FVFJABQmp2zIKciyu32p1AfdwV4JzFtndAO7617fjXU0xLH4FESlJps7IIpsfQ3Q+0omyX63munq2wtS8RII6Ljea6681AA958vjWYMgvC1WfB24Nr7kb4xNss0FdJtPb7RJgBVDVa2JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB4231.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 22:19:59 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:19:58 +0000
Date: Tue, 3 Nov 2026 17:19:55 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org
Cc: linux-modules@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	ojeda@kernel.org, gary@garyguo.net, arnd@arndb.de
Subject: Re: [PATCH v12 2/3] module: Extend module_blacklist parameter to
 built-in modules
Message-ID: <7gwjzm2amli3zjrhybhothz2chvpfo5d4i56xt4rt2ogzqbxd3@h2ejeyxx34xf>
References: <20261103214223.32598-1-atomlin@atomlin.com>
 <20261103214223.32598-3-atomlin@atomlin.com>
 <sashiko-outbox-196090@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-196090@kernel.org>
X-ClientProxiedBy: BN1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:408:e2::17) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc71c69-8e53-4bec-b6f1-08df39f898bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|4143699003|56012099006|3023799007|261026140227099003|261009223027099003|261026121527099003|261028144727099003|261102123227099003|261022075727099003|261021121427099003|260925022911599003|260925021911599003|260925021311599003|261022105027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Xu5io1IfAQxG9LqueLQCJpKskfGZdAh8Jp7zeC/vjhFaYq/cZadtA9O4rjTtLlea6nGOz5DIDitTuXvWKZDa6gbRUFxfJDyO3C0P1/Xj9MpYTyiqxwWU2Eabegac+zfhsiwEsxAAW8hV1ysDCPyrxZv/IYZmjeJn7cnu5Z+S5IMykVHz4el3fKQq5ZcIxkXUkOZb/mFGzsvsLRqqsfX90e/q2ufouJCdV0qBHh8Bxi3PlAIxDxCbiW989eFWF3V3NFxU0K/sUe/zwqy3epLJ/r4PNwtc/10UgUMRyqMKZ6EEBHp9SWVRTdbF0ui7alJNWaaxyYIZ4dWTmHbhVdAQb0tHphw7O4MaaYFt1+v1wjBUz0mCeRPiHs7j8sPnrkrBmMqtkpEUEk7Q+WYC6jdvyiM2CDFAFT4tj7Tki6nVaS9sNIK/rIK2zyyTdnsmNWjtKqh+++cNmN+jms3K7cCl7hkUwF0k1pi9phm6y0+C/nHsHqSHb2ufCF6JPYLXd7ZURjbBd0bJwoPzvw3i0nhBCNyKUOjXu/UIF2PRH6w8dP6BtfQaG59hELxUFFgP1QmKezQs7zP0b1u+lLO3hT3saSAVY5OMG6Y2imA4byBgGtWoVM4b48fanUSVANIFhGH0fSfW47auTzltm9i+wNkdCF5584HTCU65sGXQzmddS/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(3023799007)(261026140227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021121427099003)(260925022911599003)(260925021911599003)(260925021311599003)(261022105027099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdtZEdVQ2ZxOC9zaFNCVVNWOWNBTG5BMi9MK0JSOExmV2ptNzJBMTRwemcr?=
 =?utf-8?B?cTIxZURCbmVuMk42SFdqOStYeG40VElhM2J1SDhxU3J0SWNCTCtETlNRa2FC?=
 =?utf-8?B?WjFXSy82Y25td3l2UmU2aUZkYnMwLzFiNnUraUVOYmVSNHpxWXphR08vekht?=
 =?utf-8?B?clJhbFd5dVovVGZ3OC9uclY0RmxOMWIzbHhQTDEveC9YRnJ3c0h1WE1sZitE?=
 =?utf-8?B?ZVNZVjZ4TGY4VWs0YUtLTzVVZVE0WmRIRzY1cnRxZ3NlZVJ0VjFLMUhURUd4?=
 =?utf-8?B?TTNkeHJnemd6R3ZwMC8wRjMrMUtTVUgxL3pSMllzb3BQbkF6OEgvWm9YcXFp?=
 =?utf-8?B?OThJSkxOWVM0V3JKekZJejhCbkdGZTRHbmhGWk5ERXo5YVFxaWlaK2Z5Q20w?=
 =?utf-8?B?ZFo5R2FycytZaGREQWdibmR0K2hvMmJ1dlIvdkRVT1lwS2RTK1Z5QzVSc25k?=
 =?utf-8?B?LzJQMlRib0JYcnpmbVNxK3Z4eGUrL1hvZTYzejExU1lsczVFaDNzUFZkZk4y?=
 =?utf-8?B?eXdCclR6ZzcyaDcwa3F0Yjk5SU5mR3A5NDNUYnMrTzRZa01sZk9FdlZEODR1?=
 =?utf-8?B?LzAwT1JORGt2L2VhcC9aMmt5aDJtYWg4c3ZMZ3NXRnc4dUlCdXpxUm5RN0s4?=
 =?utf-8?B?aVdkNXVLaytBckVxRTkwZkt6dHJGbzdkcDN5SklXaHFSb2cvSEtDekh6clFw?=
 =?utf-8?B?OEx4Vk5HZ0lOWWZyOTJrTzlrS1dTbHpoY3g2QkhPVzhqd1p4ZTFPMlFwQTdu?=
 =?utf-8?B?STZBRWJzWUFTQStzdmVYVWc0K0ZvbFhYYnN6c3Rnc1F6ZGFwQk9iOG4yR0hu?=
 =?utf-8?B?R1ZNM1daRENTVGd1cUR2alNPdmFjZFFLTUxiUlV2d2xvK09TOHlJSnFQMmdx?=
 =?utf-8?B?NllxZTJUN1kzMXVOVFMzTEJTVzg1ZnA3SUFoSDR4VER3WXZILy80Q2x4QkRi?=
 =?utf-8?B?MnZRR0liNHRTNUppVTdiMGNVdmJIWGY1a1FnL1lGanNDenJjOWE1cnNiY3p3?=
 =?utf-8?B?SFN5aDVZbFZVL2VqdjlGYTBidE8rdUplbkk0L2FKTTIvZVhzWEthV3lCM2tP?=
 =?utf-8?B?OWltWXRnaXFXYWxtVCtkTTlzRlBPWVpMZUJqeUZqWHBveFlMaERPS2UrdHBV?=
 =?utf-8?B?L01NRTdLOUtiZXZVMnNwand0QlB4TXZEdUNnT0prZUk4UXRqQ290cThyMFFB?=
 =?utf-8?B?WDVvbjB1QnpRK0hlR3pxMVVvazBvVmt1QktZUCtSRFUwMmo1WERTcnUyV25m?=
 =?utf-8?B?VmpmbWNzS0tLSGJUdjBRWEZ3NlM3dWdhK0s5b0t6aEU0VTMxd090b0V3cUtW?=
 =?utf-8?B?eDNhL1l5NWZOeWxOa3Vpd3ZzV2VmaGdRaWN1NFJBZzR6cEI0NW1uUVNjR0J6?=
 =?utf-8?B?VjRxVG9zL1ZHcDJua3VzK1lESm9iMTlFN01QVXN2WUVVcEJNSkY1ZjNZRUJU?=
 =?utf-8?B?TG9obVg1ZHJkT25ySUdNR2lGODVQQW1qanVDb1V4bVd2ekswT2dMdGN4K1lQ?=
 =?utf-8?B?T1l2ZGd6cUlwVEtaQldDbjZ6V1JXbm5JN0lOSDJBSjlkRHI5WC9mWWRkelFC?=
 =?utf-8?B?WTJBU0JIaHhMeWRUOHg2TEY2MFRiMHBUS3c3ZGFMOWRGYVVaNXBqazA1NW1o?=
 =?utf-8?B?V2dNOGMzclMvYyt4SDNpOStUdjRlU21sWGh5V0gyNFJoOUJtWnk0UkIyYjd4?=
 =?utf-8?B?eUgxYitONktqR3NOZmYvZnovSUx0S0FmdXh5T2dyTUw2bmZiUDFkOTErbjBV?=
 =?utf-8?B?clkvdG4zRGVtUWdqazhGdWN5L05aM2xmK3QvUkMxKzVuRFQ2cG15RHNsNTVV?=
 =?utf-8?B?Tm5qR0M1S0ZhOWVNbWdydEJSSUdqN21Pb3I2eENSNWlnM3Q3ZDU2ZXUvaFow?=
 =?utf-8?B?QmNYWEhESWtJYUhFUEFMSTFGK0cybE9zbS9NeklQcFQ3TnBzS2JTeDlRUUEy?=
 =?utf-8?B?eDNWUFp4MWoxbTFoT2JVNUtwZnp2NFd1ZWtsM3F0Y0daS3FlMjNVa0pOOHlN?=
 =?utf-8?B?bGRaVzdBa2xxd0dxMXI5NllKdGd5bG1PdXpmZytvcHI0SHE0NzE3Z2hmdG1Y?=
 =?utf-8?B?cjBodHludzhlSUlZNDFsdHVnb1dXQTA4Z1kyMWhCbWVLY2h4UE5zcUluVVZl?=
 =?utf-8?B?T2VCOHFreHVpQ1o0ZkVwci90bGxaWnMwZzlJd1Q0dTA2b0p0MlJ5OXE2dmM2?=
 =?utf-8?B?eUZPR09CQzZDZTVnb0ZCZXJhYThxRnhUMm5aNGFmL2FMVWlwYkNrdGZxdlNh?=
 =?utf-8?B?NEkxdFgySi9GN09CRW1XcU5qYXdLeVB4a2NYelh1SUV2bnI0YUVrMmEzWm5v?=
 =?utf-8?B?TDBOSWk4cGVPbzEyelAvaGZpLzcxanJoamhBZEhSVGRHTksrc2tldz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc71c69-8e53-4bec-b6f1-08df39f898bd
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:19:58.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDUXGP6Rc/Dw3TM17J6CWBahy/x/A29HQ7Cqrg2KIgCyO6WZOYJsk+D6LUVWZ10xbDQG+R+DJ0QRAWuUlKsvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4231

On Tue, Nov 03, 2026 at 10:01:28PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] module: missing kernel-parameters.txt update for module_blacklist=
> --
> 
> commit b07237b9f1588393358dd2a97ba3add75969d76b
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> module: Extend module_blacklist parameter to built-in modules
> 
> This commit extends the module_blacklist= command-line parameter to built-in
> modules by recording their initcall functions and module names in a
> .initcall.modnames section. During early boot, do_one_initcall_builtin()
> checks this table and skips initcalls for blacklisted built-in modules, with
> parameter handling moved to init/main.c so it also works when CONFIG_MODULES
> is disabled.
> 
> > diff --git a/init/main.c b/init/main.c
> > index d7bf1ffc5f503..99df129d3b296 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1406,6 +1406,56 @@ static inline void do_trace_initcall_level(const char *level)
> >  }
> >  #endif /* !TRACEPOINTS_ENABLED */
> >  
> > +extern struct initcall_modname __start_initcall_modnames[];
> > +extern struct initcall_modname __stop_initcall_modnames[];
> > +
> > +/* module_blacklist is a comma-separated list of module names */
> > +static char *module_blacklist;
> > +bool __init_or_module module_is_blacklisted(const char *module_name)
> > +{
> > +	const char *p;
> > +	size_t len;
> > +
> > +	if (!module_blacklist)
> > +		return false;
> > +
> > +	for (p = module_blacklist; *p; p += len) {
> > +		len = strcspn(p, ",");
> > +		if (strlen(module_name) == len && parameqn(module_name, p, len))
> > +			return true;
> > +		if (p[len] == ',')
> > +			len++;
> > +	}
> > +	return false;
> > +}
> > +core_param(module_blacklist, module_blacklist, charp, 0400);
> 
> [Severity: Low]
> This patch moves core_param(module_blacklist, ...) to init/main.c and extends
> module_blacklist= via do_one_initcall_builtin() so that it also skips
> initcalls for built-in modules defined with module_init(), even when
> CONFIG_MODULES=n.
> 
> However, Documentation/admin-guide/kernel-parameters.txt still describes
> module_blacklist= only in terms of loading modules:
> 
> 	module_blacklist=  [KNL] Do not load a comma-separated list of
> 			modules.  Useful for debugging problem modules.
> 
> The follow-up patch in the series (commit 7bf71ba917d2 ("module: Rename
> module_blacklist to module_denylist")) renames the entry to module_denylist=
> without updating this description either.
> 
> Should Documentation/admin-guide/kernel-parameters.txt be updated here to
> mention that module_blacklist= also skips initialization of built-in modules?

Hi Andrew,

Acknowledged.

I will update Documentation/admin-guide/kernel-parameters.txt in this patch
to note that module_blacklist= prevents loading or initialising both
loadable and built-in modules, and carry that updated description forward
to module_denylist= in the subsequent patch.

Kind regards,
-- 
Aaron Tomlin
