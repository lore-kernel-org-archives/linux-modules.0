Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC219C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FB2610CC
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbhI2VyE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32474 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344383AbhI2VyE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TL3wLC030856;
        Wed, 29 Sep 2021 21:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=zY4FmqM+Kgl9KfEMsCTX0WBMFAY1avUZy4GhCLC68EoKMy3DKBtYtHke0Kqk3T/l7TRh
 030NcZdO+iUMZZnHVkY9F007LDjgQoFsMsQs+kU63VyNXEIloINLXcpXbEMnUm+H8z5d
 tHwD3fNWblfy6pWvIRyHtAbSmOJRMe3I//pQuDmCI0EU9ddOh9yGDel8AKfRHZwwmhBo
 7+k0S6cPD/knfPyI4hrgvInkIYkzstWgTICswCaCkEAcY4Kl/01jmy7K9ruIGHlGBZsw
 wFvFf5LQ6L1eNpzahkwKBblqK/Y4iwv8uLyng/jNnwvwyYv6Fz5hlfMYRkBo7RK32q9X ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bccc8jg3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLj3D3174574;
        Wed, 29 Sep 2021 21:52:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3bc4k9y2df-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWmTqXGgG25dkMu6445GNs81DEgsloFR1MpR28XXI7rdmXa1SWiT6qG14DDoJQHzA+QXYy73kFpFkISNH5YGmkSezbbCADyYz3BMogd4roU8D0dgoPpgSb85I03MgaCEc7PqcyWgFUBkjIFUdeczYH0zsIz037phamn/z/aLS9DCeqtnvhtMJ5PYBCi3oVCF661kk/iFHVYiQh/1SoW1UNuA13yz0EiNGD8qA9ofiH/SNDSPvQHNmGkwVov7bffP4I4AdB2LH88YKq6dbzuclaz/oDYuctO4cimz5XEbB8BHo6wgmrWHqXmKXxScRKsVy4HFIy981UO2fqIe4DZIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=SpLYExP2nwkR/FJs33cPkEk4oMSRVhB2441ZZTgYBDdHdZyLPKHaAsV9zAhIsOywfn/zCmaWW3l3Osg/i7UZq8CDwzRFV+IrahM3LtILvpmaHzNhc8Uro05Kes7pepCaAPWqz3ZxSNIfB4toLz5uVJ4v7S7j9nusSuZhBvMUFRJr6iAFa49UXUI7Tpcb+nMLKHbeyog6nptBWY5x1DTLo1oXFaAMHkJy9M3s/8JvdCvQ48x5Vn3Uc8siPal4njUR1Wp10pBgEDDOw7ES54kbl3ZiSicHSU4+ibQSQ1eW70uYKKG46OG0QhOqb1U3m14+QIibzGEsDw0nsuunkyB+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=yFXbjifD76SVN439XBLJNKo5t/a8CHO3pXX8khAfZ4qR9r0MNoFrSrA9e5WeI2yPQJG8K+L9pLtd+hyoktr3OfjwDnl7upnfXw5AHxUROTRWN7B7f8AIE1srkPOwmNy0iTjhf7YNez8ggGVwob182d3sn1vz6EZWXIQy44L7aII=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 21:52:16 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 1/7] kbuild: bring back tristate.conf
Date:   Wed, 29 Sep 2021 22:51:48 +0100
Message-Id: <20210929215154.300692-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913bd987-9b43-4f7e-3df5-08d9839366f8
X-MS-TrafficTypeDiagnostic: SN6PR10MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB3440C38FDB22382E405847C88BA99@SN6PR10MB3440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SprkBzR4rt2hhfTfH4SQ3R3pfNebugmAcEtKiYXmQGCpbJsmliENhujqiwRg9r4OAmXVMymVBUxijZwi4+iFKHJHkhszWeC9tRGRXxW/9HY0csvu8CGdNwwKs+5jKrGqSmWqoGvfyc5b0gwFkcDG7vNlXCYM8l5lQmZ52O0ZK7QPATOaGJMzD2bNdqXQUWKYhWvGsaQjbDCADiprDys8hiVzd5nJnsHrLLWPXFHqxnQ+P74daqd+Nz/9JEch4et2OgSWFHK20L6xCrGlZlgRYkh2MX9ejC0TMrpmAyRdVAGA2/UskUK2H11eFvnAifBqyYlezJHC2kgXHxd44nZe3zsYBx2gQHV88mN+toOAQWLOLL+EZA8VmjZ5WRfaSlP4bA9ugz2EpA5kI36SIyLumQBlAG8oO/OWIgN98P1HOxdoVVV0DJwTqLZxKCWVKKSaHagMQQE4SP0e33IN8LGFvEAWvNK8s/6/kQwLKk9HECqXDSofVnW6PLMyU0iY6bgBgRdc7B7uvRqHrEza/PTpjWwaRfBfLRkjkanapunUXd/cnh+OIMOk+d+m177VHIMI2KEQBJJQa5MeKdH8RHlaHt1moVGQCXx72atXX4c/ZqBwpuHRKPt2JTkKY5st/EU54rlpLCfEg6+Fq+Lax7u0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(316002)(8936002)(5660300002)(36756003)(8676002)(6512007)(2616005)(6486002)(38100700002)(508600001)(107886003)(66476007)(66556008)(6666004)(2906002)(186003)(83380400001)(86362001)(52116002)(44832011)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlX2deScdSLRzr903Opa7/axNeDMZICTvxj479DqJUMqYhpn28X97ILaJn1v?=
 =?us-ascii?Q?NiuviKWn9et0je6wJvce+1pQ+nNPMs/KX6cL5rCZjnxfrrj3sIeJrQcYCOcy?=
 =?us-ascii?Q?mXfC+uLQv7jftjJw9+WdaWTcQ9geRYALZuoR2iqbvU0w9yQKrvOp/SUKwKr1?=
 =?us-ascii?Q?56KAXgysQmpvesOobkM9JeDcPpJxQ9sRc5OeEiBnrL7HAt12uSWF9pj9O0AW?=
 =?us-ascii?Q?v5txzzC7OgA2pcSozm7/iRh8VPXrQ0s5b8d0f/hYe1PqfpLdX9f+CSQkHD27?=
 =?us-ascii?Q?vB6QzC6hhs5WjTx4Rh5rA+ionOEY75iDn9pz5+MMf5pFLSeJsDD7Rlt6L2pw?=
 =?us-ascii?Q?SFitwueWLyGAIm4ts+NajNNAfkS+yXfpvbOEy6KDRslICYgPZpLEuww/iO9j?=
 =?us-ascii?Q?9ybdCIYeQmg7CcY0l9JGj1i6T3ll++gbVRlRh3+8FP7AJp25sBVbcg1gCv9X?=
 =?us-ascii?Q?vVf7CuVKRGbba5mTysCfo4HJN85p+gMLnNoqBbZeflpfrxd3U6TT4faBj0a1?=
 =?us-ascii?Q?fEJQO5kENH+Xj7+oJuJtFPa7OIq0tbCkmXZ9vzwg4rHdRH9f9CsSAmdfQRWF?=
 =?us-ascii?Q?JqkH68ouHuZfEHRD76Ab88G1AukV+dCerFNPs9vuqc+SEgRphwBnHYPRD7sk?=
 =?us-ascii?Q?RAKuAkJxnk1ADbLvtlTJM259XTCwPp3HpapY7mR1Op+oeEkQylknNDL39Rej?=
 =?us-ascii?Q?3sWAlSx3D8S9aDDULBhRNVsBN+a4CSUUkY09cjDgXtqAF/E5V2MarsSoUSQj?=
 =?us-ascii?Q?CVKOOafcQJyAd7XzEh3/i0wZ8nc2s8kGrYj750KJiQX3egseNB0k7o5vCDGB?=
 =?us-ascii?Q?ddqxO+N7tr5qhYVciC+2E5FxuOETEtV2ITbNAk2gywMa1inSdKtIzSIlrf/S?=
 =?us-ascii?Q?OUTcxColuIAbbY1ni/7/yLCa8kICY4yy8sjvtIYIUHK8b513HAvuqvpQc1pA?=
 =?us-ascii?Q?l6newwT9qx/fayUVhP0XXhYib8hxfCe9B7iGBtVpq68R6I4L0SBFKKrEtGGB?=
 =?us-ascii?Q?s9JuV7vq+dvl0WH2/AZ8qTudicaOHWYzZujixOpYhU4RUXeynxbptmSqoSoH?=
 =?us-ascii?Q?4l6WMesRo18vV3QiOxTBsllapGvgMON65RKUIQW/HZmwAoTy8PiF5gY+F4u3?=
 =?us-ascii?Q?QKc+VwjhyaTLThSRyFPLLAQvVKACygCNCioYU7gGsBvDJYet4s16GXrb9OZd?=
 =?us-ascii?Q?vHz1EF5O9E+OnDfHC/ckwK406FBYm4eq/5rz7bQspPUjSe+MZJpeTH7PEoYu?=
 =?us-ascii?Q?qbMFZjTxvJ6I1kQguc3hPxHEb+F4MBD2htY3fSk+C27cKcrOR1YkDC6AUDRP?=
 =?us-ascii?Q?L8+733lx3SSMbFAUzjL6Ifa55N5zQjKmmKTXSLn170pd7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913bd987-9b43-4f7e-3df5-08d9839366f8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:16.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od8uM81qzZIIUc1O9D9e2qwsABcEohekHu35nXWy15+46MJDjWNSwttR8xA5jtHZsjBGyRlMt1qcoHfdlQkQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290128
X-Proofpoint-GUID: 706wcQfzjp9tm2cjDvZDdUlXO9GUNlZr
X-Proofpoint-ORIG-GUID: 706wcQfzjp9tm2cjDvZDdUlXO9GUNlZr
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

tristate.conf was dropped because it is not needed to build a
modules.builtin (although dropping it introduces a few false positives
into modules.builtin support), and doing so avoids one round of
recursion through the build tree to build it.  But kallmodsyms support
requires building a mapping from object file name to built-in module
name for all builtin modules: this seems to me impossible to accomplish
without parsing all makefiles under the influence of tristate.conf,
since the makefiles are the only place this mapping is recorded.

So bring it back for this purpose.

This partially reverts commit 8b41fc4454e36fbfdbb23f940d023d4dece2de29.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 Makefile                   |  2 +-
 scripts/kconfig/confdata.c | 41 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 437ccc66a1c2..77062b44a4b5 100644
--- a/Makefile
+++ b/Makefile
@@ -724,7 +724,7 @@ $(KCONFIG_CONFIG):
 #
 # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
 # so you cannot notice that Kconfig is waiting for the user input.
-%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(kecho) "  SYNC    $@"
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index cf72680cd769..8f4f1b373dd6 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -725,6 +725,25 @@ static struct conf_printer header_printer_cb =
 	.print_comment = header_print_comment,
 };
 
+/*
+ * Tristate printer
+ *
+ * This printer is used when generating the `include/config/tristate.conf' file.
+ */
+static void
+tristate_print_symbol(FILE *fp, struct symbol *sym, const char *value, void *arg)
+{
+
+       if (sym->type == S_TRISTATE && *value != 'n')
+	       fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*value));
+}
+
+static struct conf_printer tristate_printer_cb =
+{
+       .print_symbol = tristate_print_symbol,
+       .print_comment = kconfig_print_comment,
+};
+
 static void conf_write_symbol(FILE *fp, struct symbol *sym,
 			      struct conf_printer *printer, void *printer_arg)
 {
@@ -1058,7 +1077,7 @@ int conf_write_autoconf(int overwrite)
 	struct symbol *sym;
 	const char *name;
 	const char *autoconf_name = conf_get_autoconfig_name();
-	FILE *out, *out_h;
+	FILE *out, *tristate, *out_h;
 	int i;
 
 	if (!overwrite && is_present(autoconf_name))
@@ -1073,6 +1092,13 @@ int conf_write_autoconf(int overwrite)
 	if (!out)
 		return 1;
 
+	tristate = fopen(".tmpconfig_tristate", "w");
+	if (!tristate) {
+		fclose(out);
+		fclose(tristate);
+		return 1;
+	}
+
 	out_h = fopen(".tmpconfig.h", "w");
 	if (!out_h) {
 		fclose(out);
@@ -1080,6 +1106,7 @@ int conf_write_autoconf(int overwrite)
 	}
 
 	conf_write_heading(out, &kconfig_printer_cb, NULL);
+	conf_write_heading(tristate, &tristate_printer_cb, NULL);
 	conf_write_heading(out_h, &header_printer_cb, NULL);
 
 	for_all_symbols(i, sym) {
@@ -1087,11 +1114,13 @@ int conf_write_autoconf(int overwrite)
 		if (!(sym->flags & SYMBOL_WRITE) || !sym->name)
 			continue;
 
-		/* write symbols to auto.conf and autoconf.h */
+		/* write symbols to auto.conf, tristate and autoconf.h */
 		conf_write_symbol(out, sym, &kconfig_printer_cb, (void *)1);
+		conf_write_symbol(tristate, sym, &tristate_printer_cb, (void *)1);
 		conf_write_symbol(out_h, sym, &header_printer_cb, NULL);
 	}
 	fclose(out);
+	fclose(tristate);
 	fclose(out_h);
 
 	name = getenv("KCONFIG_AUTOHEADER");
@@ -1102,6 +1131,14 @@ int conf_write_autoconf(int overwrite)
 	if (rename(".tmpconfig.h", name))
 		return 1;
 
+	name = getenv("KCONFIG_TRISTATE");
+	if (!name)
+		name = "include/config/tristate.conf";
+	if (make_parent_dir(name))
+		return 1;
+	if (rename(".tmpconfig_tristate", name))
+		return 1;
+
 	if (make_parent_dir(autoconf_name))
 		return 1;
 	/*
-- 
2.33.0.256.gb827f06fa9

