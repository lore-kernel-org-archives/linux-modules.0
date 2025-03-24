Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2109.outbound.protection.outlook.com [40.92.59.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D726461B
	for <linux-modules@vger.kernel.org>; Mon, 24 Mar 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837759; cv=fail; b=hhiemM98RBvPRFRikDyb9VVFJDqyT87ApaaLxFfDZcGiZK+eq6JHozIpG016odNxv7fYwVVU8jlHwy+GU9shh7ExJmiYFidXnCM8p+PuM8VuEiZJadxdlhQKbBCegg03zG6zoXQ3HG6co2Nv9o+Biu7ljaulrD618Rzg/xuviWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837759; c=relaxed/simple;
	bh=RkT+2qdbTcu7W65G5fP9ufaEmCiZFAiu41mgYxERVF8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Z3nNyaquoUMzmukMDErTiWfbUkP7JtoVzLXQVv4q4OUo50ylz8drrgncG1tFu/fTkPZuKX6X7Y0kBJj5nI5V9128KFn5ovo8hjIknJqMS4TG0VyHiIK3Fn2Tuh8mszvuhNG1HPD+EOiwfDChTLeX4zuk8GH8sToGCYHG6yBHKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.fr; spf=pass smtp.mailfrom=live.fr; dkim=pass (2048-bit key) header.d=LIVE.FR header.i=@LIVE.FR header.b=j4vOgb6r; arc=fail smtp.client-ip=40.92.59.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.FR header.i=@LIVE.FR header.b="j4vOgb6r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSj7i1vKB63/bvC5SUW+QcfN6LaEPOFAJw6i9CHyDtYQkKH9fa3r6NCoRA6uYuyOfUduX1QiGm+Xl1Fqn1RPZDVWuFFY4J4WhMoBTAlJaAtqNRUaQVB47Gsx112QFe0Kxy7JA/rM7cbUec7EcH5/nplvXOKAcByWNtGGX8cE+nUSve/9+N8jmbPAxQeQ7+xJe2hzQwQ31jCgoH19nfePa017U06MWeAIAmb4WnWW0fTOhSvUmNjqV8xfVdX5fSHosh189Co6T0krmKrn0/+kQF+ClaZ/xsp6DKtk9N0coJ38QXvsE22tvvhpDIyT1psE25X35HI6fe3VngdJdYm/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6SKieBHyi6GC5gr0Xt0YKBXL50HETDJ32UANlhbtZA=;
 b=O3/ACr0HW+TQ5hqdKAYaExg1p/ns6YATjJfycnlBqBsYPJl5D/sv9lTT/AJqdvzTxB0cSddFz9gEAUU2QQpv+x7crCBPGGp5PJUbjXMvrXkuVM1iSV5IM8jitrO9qbZKZ39xma+vIYcFnLKPdGIm76gNQmb92Q0dkW7MaqOh/x1eKwvglZWyy6BSgTOAsS7zboZ76bLTL7Kl5NOQAuyaCtqyDa6x1TwYSkjTY8hRoihXPqSSEiPalml8Ozgq7pB30n6DBHvCj0kgLQgQaaGFr7nkoWlc/bvFum48m1fErVU9II13yUYLg8+ptI1xiGcimoNs/vhJGYyIirEpzwkcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.FR; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6SKieBHyi6GC5gr0Xt0YKBXL50HETDJ32UANlhbtZA=;
 b=j4vOgb6rFjvzPaLIHvruuoWsoIRHn5Ou/KorMQqj5STX3Dk0X33sJYPEWCEWuD3IBuaFGQTam2lwAaqkRaVaIir8p4kLoJR96zR1DdQO9ygeKq+h14eD2JIvIyNXkwupfxFIWaQTKOT1sMOi9bNhvkVsLXi+yxk/AfDbbPN32SBdenFYBr2OVeLMk/dpZBNNyNvYUGPPuth5mUOw1lAl7ZHJ86VKwVZoM9b009e292V3Kw6LQStA1DtptvaG8tZV7YFGHHTK/04YR6kBUMbiLEyvF4xxzESKPgcKl1P24hAMRBiKazbUp6hW2zT1G3U+PxwE8hJ4CdJkxjeWNreG6g==
Received: from VI1PR02MB4829.eurprd02.prod.outlook.com (2603:10a6:803:9d::15)
 by DU0PR02MB8571.eurprd02.prod.outlook.com (2603:10a6:10:3ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:35:55 +0000
Received: from VI1PR02MB4829.eurprd02.prod.outlook.com
 ([fe80::dc17:dd68:b745:db98]) by VI1PR02MB4829.eurprd02.prod.outlook.com
 ([fe80::dc17:dd68:b745:db98%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:35:55 +0000
Message-ID:
 <VI1PR02MB48291E3BDB7E764ED67154949BA42@VI1PR02MB4829.eurprd02.prod.outlook.com>
Subject: [PATCH kmod] tools/rmmod: fix garbled error message
From: Yannick Le Pennec <yannick.lepennec@live.fr>
To: linux-modules@vger.kernel.org
Cc: yannick.lepennec@live.fr
Date: Mon, 24 Mar 2025 18:35:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
X-ClientProxiedBy: PA7P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::19) To VI1PR02MB4829.eurprd02.prod.outlook.com
 (2603:10a6:803:9d::15)
X-Microsoft-Original-Message-ID:
 <00071cb37ac73c10ca2657a7c459ca9ea60bfbd3.camel@live.fr>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4829:EE_|DU0PR02MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 5724e1a2-dc23-4dd1-7ebb-08dd6afa544a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|7092599003|5072599009|5062599005|6090799003|19110799003|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y010ZTN6b1RlWDg4WTU3ZkZlWmZXQ0thWVVwNC9RdGRHQ3NCUkk2aFZIM0ds?=
 =?utf-8?B?WHJYNXRJdktLQ21GeU16eTk2dVpZRXY2T25RN3ZaQ1JiS29GS0FmdU5EUmln?=
 =?utf-8?B?QnNqbVJuVy9UL1Q3OXlpcXNLVDBRZW16K3l6WGZFQ0NIWTl2WHhFbmUzcFNP?=
 =?utf-8?B?eTRDVVpaMU1BSDlPdXJSSkxMZ2VTRUtWZzk1ZXpJOGw4dVhjU25iSGdLUk9l?=
 =?utf-8?B?NVBsL3l1a0JkYWtoTm5ZdXZTcllrdkFFVEpMb2hGWjU2dmJFdk9jNW1rcmlF?=
 =?utf-8?B?M1M4UUZnMVpyK0N5bkdWc1ovR1NRaUdkL01DUS9DU01wdjJvR0EwNHp4NlU0?=
 =?utf-8?B?MHMySjBCUGVKWXVseG1aeHV5TlF3U1Z4K2kvbXkxZmxHU3NmbThqQW1KZU1k?=
 =?utf-8?B?MHF3RmRzOHQ2SE9sc1RwMFdRSkhVZ3R3a2U4bnJGRkFyRldRWDgzOHBTd2ZI?=
 =?utf-8?B?R3ZsR09ESmNvQnNXUGdtYXBkS0dUUElTOTRuaFp3OUxNTm5aRmw4czNpd3cv?=
 =?utf-8?B?cm5QbDc1S01NcVY1SmpJejlZZEhLVVQ5aFdwVVJNK3FpNVBxWHRZczZjWGtO?=
 =?utf-8?B?T0tUNy8yTFM5KzJ1WnEwV095aG5TWklsL0lqQUprUmFIRk9FNkliNWJJVzBv?=
 =?utf-8?B?OEZFZlBFbHZqRzBidXNHTktYaXJvSi80VjREbmxVcU52T0JreVZ4dFVQNUh2?=
 =?utf-8?B?MWNXbng1NzhWcTYvT29ud1QyNWtFbWh1M3NzdmpaV2FoLzZGNElwNzBjVFpj?=
 =?utf-8?B?ZGR6TW1qd1Zmbko1cllHd3V3WUpXMXRyOFRJRDF0TTNIc0hPZHMvd0FrM3A2?=
 =?utf-8?B?NXRWbm5tVHlsWW0yU2xJdFBPQXVJSXpMYXAwcmEyYWJlVGVIRnQ1QVVYQmpM?=
 =?utf-8?B?UTZocVF3ZkJQWVJ1RmdDMTZNcHovakhoM1d1OVNzTVhCOXYzdi9OTXZJSm9F?=
 =?utf-8?B?N1BwS3A3cjRQRDQ4bXlqM3hQQWQwOHQ0bTZ6TVQwbno5WGJKOHdhbHQ1YXB2?=
 =?utf-8?B?dStKUGxqK216SGUxZllZRnp0R21hcXgxMHJ2b2p3Y0lTOGFLN2NmTGpFdlB3?=
 =?utf-8?B?L2NjZ2krUGhWSUR2MzhuYmd5eDM0R3ArOGcrMXRFM2pGc1FiREtqeGMwbWgx?=
 =?utf-8?B?QW1IeE1WWWxTdHBqcytqMGhYL2lNV04yZGNBTUpDNElxVmk5eWQxRkVoZlUz?=
 =?utf-8?B?VUlTRWUyUUtKOW1Ta3JtM0RtQkRnbjFzWmo3L0tWSnZVTlZXWlprT3VjLzha?=
 =?utf-8?B?ZEl3dmtRUzdmQjQ5eXNlRDRDVGlPcEJzRS9QMXRYM2NIcVBoaGlUQ2pGL25t?=
 =?utf-8?B?SUw4UGtpTE81OTVUSXM0RHZiRURBaGZ0VnFkd2NqTnRSQ0FiTzhFWWlUcXpE?=
 =?utf-8?B?UEoyMEhhM09aQWRxSEtIaHZRL0ExRGdhZXRNUmlzb1ZuRXR1Q204VTczN1kw?=
 =?utf-8?B?ZUJaQmhaUDV3M3BxQnh1UG8zVEc4bmEvMjhXL1RFNURENFBway90eE5wbnYz?=
 =?utf-8?B?SXhOZmVEaDFiQ2t0TC9iT05jQUZ2MjlqK1lBS0lyTDJ1YnZLTjROQ05OeHZJ?=
 =?utf-8?B?a211eGw4VWRJanZ5WjVUTENjS2FIVHVnMkZyampwSFlEakp6b2RkVXo2Zy8y?=
 =?utf-8?Q?LZfNjxWVVlFNjZ2D/HGnHYA2z324xAQK9fkvF/eD/co4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cENvY2Q5Um83SzduUlg4ZU9lQUVVV3hOMUpKUjB3aEtnSmhWQ1R3LzV1QnZh?=
 =?utf-8?B?d0NvTVo0Wi9NaWJXNXFPd2hKSkhycGMrYnJhS2U1dTEwdUtZQmtNZlVBczFF?=
 =?utf-8?B?RXU1eEU2QjJMWUtHb0t6RGFqY3lZRzcxV0dOdGxNd3BLVWlXRGNwQ3hTV1NX?=
 =?utf-8?B?MTRTQUR2SUJqY3ZkVmp1UTlTYmlaNERDZnVwejAxTEV3bUhtSWJma1Irb2dX?=
 =?utf-8?B?UVllaEtnMmZPOExwaDlRcG95aGVISkszUk9uN0M4S0VUeDFDMUcrMU9TVWYz?=
 =?utf-8?B?UG5TTklodmJLUm81R20yZCt3T3VwUzgvOHVwSmFCRFVDejl5THdQbUkvSHlR?=
 =?utf-8?B?ZDdieXN2dW95MGtRRnlBRWgrRGhzd3Z3TVBIazhnOEVldGtxckZZV25qRHJS?=
 =?utf-8?B?UWtDN1VlMFYwY1lIMVVrUjlGd2R1VVd6Y0dOY3pKbjNYbURsVnVQRWdtelR0?=
 =?utf-8?B?T2w3QWdrZW9FOGlUTXJaZlIrTmdLa2E3Z1FwUmRCUUZCZWlDZzhQQ2hYSHVF?=
 =?utf-8?B?YzNXZ09kb3BvUlFybmtoMmk0YVgyOTJndnlaSm5sWDFSWmRab3JxU3hjMzRG?=
 =?utf-8?B?MGhFUEd2TnUrM1B4Z3dmSjhMK3I1WjlkWmRNM2hDTDBHUHlJT3F3MzdPRUVo?=
 =?utf-8?B?ZDFrQkJMaXRqeFFBU0s3bWYwanJHOE85UFNZbmJUbW1VQUM3L0FUTzhNNC81?=
 =?utf-8?B?SEVHdFZXeldCUnNlZmVUbzgvb0x0dUZHand0Y2ZOOHd1c2ljZDd0YWx1OHlX?=
 =?utf-8?B?NzZEeEtYTUw0T0pTY3VWUmwzODlPNUdOQVdkOGo3c0M0L09uUDllazEvV2Va?=
 =?utf-8?B?OEMxaDZRbE1iTWwvZ1lIVUFvL2Y2azhsSlBCV2pQWmZQbW5PZ1Y0TlFEZzdW?=
 =?utf-8?B?MFBscXlkZlBlaXA3S2RmazhueVcxR2FMR1VkdWE0TUlXVEwwbzU3WDB3bU9h?=
 =?utf-8?B?bFlSajFNMmZLekF3aHFQUmorSXJ0OTBzQVl2NDV4SmlvcjJxZVNWZTVoQmpF?=
 =?utf-8?B?OWJiVDYxcDE1QmdkWkJFanBOOEZrcTJsS1FVcmFPSForMmpXL3JCMDd0S2Ny?=
 =?utf-8?B?TmV5dDN0ZWl3TjgyWUFPQlpFQUhVM2hsS0RiMlJRSWNpbytJNk40TUovUGpB?=
 =?utf-8?B?VW8zMUNod3BqUVBDTzJ4OGRaZ0U4YkRIQUh3VUNmbWNMQVFPYm9CZ01IaEZu?=
 =?utf-8?B?ajQxaElRUnljYTdJRDZkTnRETUtjOXNIWENJZ2hDT2VaZjF0VkROVFZUNFR1?=
 =?utf-8?B?OVc3NW4remlKMXFlMWJYVmFKRnFOb0ozZC9zaGJZaUgzSWRKRW5VanRKYzNL?=
 =?utf-8?B?ZmlBdVp5UytJaXdGVkZLcFdwUURyTnZmYnFHaWhxU3VjWkFwYXFGNnY5RFBS?=
 =?utf-8?B?aXFTaFIwdjhhV084WFVudjRWcHlYZGJ5c0ZhNHZVSmZSbnJNZ1B2cVZxQVNY?=
 =?utf-8?B?ZEdlZ3lYc3lqS0djTE1vT056MEJoM2RJdFgwaFdwUnI2NEJxOWFSd0VyUVJT?=
 =?utf-8?B?K3I5dnFsQy9ST21maWw1eVdxU3RQYzE0U0Jmcmo4R01FRVlRcytDWFFoWjIw?=
 =?utf-8?B?cStzVVNTWXVZMStUVGx0RmpoL1d6NWloS1RFSmllYldLV0JDcGlVU2s3Q3l2?=
 =?utf-8?B?UlJQYWhXdXVudG4vT3lrZXMwYlc0KzFxQ2RHeTU1YUpnY3l1OGYzS0JrMFlC?=
 =?utf-8?B?UkxiSHJXeTNoYXVIUmprQ29WTFNaalBtWGRGck42aTFBL2Q1dGZ2VGdpeHY2?=
 =?utf-8?Q?K8IgKCjHM6vjqJEM6zOreo1drVlUrpoUkyHhrhh?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5724e1a2-dc23-4dd1-7ebb-08dd6afa544a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4829.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:35:55.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8571

a6f9cd0 ("tools/rmmod: consistently use ERR logging facility") fixed
the split between syslog and stderr of various error message substrings
by calling the ERR macro instead of writing directly to stderr, but in
doing so also completely mangled the output because the ERR macro
decorates its arguments:

    $ rmmod iwlwifi
    rmmod: ERROR: Module iwlwifi is in use by:rmmod: ERROR:  iwlmvmrmmod: E=
RROR:

And in syslog:

    $ rmmod -s iwlwifi
    2025-03-24T17:22:34.878318+01:00 mangolassi rmmod: ERROR: Module iwlwif=
i is in use by:
    2025-03-24T17:22:34.889145+01:00 mangolassi rmmod: ERROR:  iwlmvm
    2025-03-24T17:22:34.889224+01:00 mangolassi rmmod: ERROR:

This commit fixes that by building the holder names list with a strbuf
and then passes the whole thing at once to ERR.

Fixes: a6f9cd0 ("tools/rmmod: consistently use ERR logging facility")
Signed-off-by: Yannick Le Pennec <yannick.lepennec@live.fr>
---
 tools/rmmod.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/rmmod.c b/tools/rmmod.c
index 962d850..61f2e00 100644
--- a/tools/rmmod.c
+++ b/tools/rmmod.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
=20
 #include <shared/macro.h>
+#include <shared/strbuf.h>
=20
 #include <libkmod/libkmod.h>
=20
@@ -63,16 +64,18 @@ static int check_module_inuse(struct kmod_module *mod)
=20
 	holders =3D kmod_module_get_holders(mod);
 	if (holders !=3D NULL) {
+		DECLARE_STRBUF_WITH_STACK(buf, 128);
 		struct kmod_list *itr;
=20
-		ERR("Module %s is in use by:", kmod_module_get_name(mod));
-
 		kmod_list_foreach(itr, holders) {
 			struct kmod_module *hm =3D kmod_module_get_module(itr);
-			ERR(" %s", kmod_module_get_name(hm));
+			strbuf_pushchar(&buf, ' ');
+			strbuf_pushchars(&buf, kmod_module_get_name(hm));
 			kmod_module_unref(hm);
 		}
-		ERR("\n");
+
+		ERR("Module %s is in use by:%s\n", kmod_module_get_name(mod),
+		    strbuf_str(&buf));
=20
 		kmod_module_unref_list(holders);
 		return -EBUSY;
--=20
2.49.0
