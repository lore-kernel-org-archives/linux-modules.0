Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0519EC433EF
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12BC61053
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhKBSl7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:41:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235443AbhKBSl6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:41:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IIx7H018451;
        Tue, 2 Nov 2021 18:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=k4g4ffgPFqsDwIUyOPkjYeei0AHu46OcSKBoWfVjnnU=;
 b=y0TOphxh+alvhyfeizWmfsotkuRjuQ/uAo11sQukBEmr8YPabbcoaT2AkHBrrYknruta
 PDTAVlo4rPfbQmmXgk8BxsSdaFT7Zx7p3UD3OM6qqbYPrmFURhJlYDC66lKVi1+a7v+k
 GkOIVRAYS23cy6cO+YcV45e9txWeEIIbagzNe2jUkMhwrO5/9D44IPxitrKno4hlmNSj
 oLH2mTGr7Wu3Oo1hIa9sHkiKEeOA84NiHO+Mf9kzuC/K5Dl6ATKva2lyqoHh+iVxcI+C
 Ds66JdIw1uLoI7SKdKHUFnG2Rg5c2dglLM+GOkSGAveZZ2vzYm2Yci1+q/IuQL+xZW/g jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c28gn960f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2ILuEc176143;
        Tue, 2 Nov 2021 18:39:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3c0wv4su3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxJ5IVGfsljCUL+NDygdoMxXOBUTlrNEc+EKET7gdC/qKTbhdPv2f53N5mWmHSs+apCim/V1VXuRCqJkM5PaLpTQzl/C94CoO9ZhZP6++oGVFgcnlQMnWc6jslNLvuqgL2fMnrc85sM+DwUutFnFDRz7jh4wH9cDNVzEjGjv4aC1PB4sJpAtxQjJ/8D0+cAsw79/EKfOERU6IOrATbmcc5Fm+QUHWYKHvKE3sBuJbmZEBevTrZJ4e4ZoYUFwBTS2m6trUNHKJ4zyk7EJ8sgCR6vmwmJBODNloxvJGzesYmwYqgwLFnjJvhm90J3dkegn8d99c53+Zf687VlhjRkmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4g4ffgPFqsDwIUyOPkjYeei0AHu46OcSKBoWfVjnnU=;
 b=LKHIE0rVSd/p3uvCFXfMWL0j3kahTdExZIsNoeTzh3KETBZc7zZBEJ2zqjStMnEumsQZYPDShfzmbxXv9pSZmIWxC29JPa7kE9mYx+h1p5ru7xMCzBWZl8yH0IdV/gbztUFZ3J1MGzy3TcpGLFYIeaQYSpl5X6wWiCBebxvXoh7a69jW9NYMVGGyQujiKbY1DV4yywdN6zR/aoAn27/A5rxxp9ogctUPqVsEvtbjYoIdY0eZvACDhCeMKU152EwlTECNcxD+c0yQxZyV4mYH2z56oct1EAOtXzljlhFQokUubDm6JnrbcqfYayDaCHjxbqwon3XMORRPpNSZnz4wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4g4ffgPFqsDwIUyOPkjYeei0AHu46OcSKBoWfVjnnU=;
 b=y5ReN4UYy4e8G2ZxweseDq+NuhX1UwHFPnY95FSiGQfa41pd9E84jCRKNBT6eOPVQCybxeZFL7Dz4aEwi2qm9WUswEjQI5Pn8nMm8D+6q61Drhw/AzV9dQcu3acQNU+i3koBFUWG7A8y08kZ72jod0W4Svj3szA05VqHpYUMImQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 18:39:16 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 1/7] kbuild: bring back tristate.conf
Date:   Tue,  2 Nov 2021 18:38:45 +0000
Message-Id: <20211102183851.168676-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd613a70-5d51-496f-53a5-08d99e3012ad
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566E2798AF6255B41CAC6408B8B9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY27WI+HK4vEoEuLEp4sCoF+iUoQp0vTGiMGHWMSYycLEKq0/ddRDIT2maTiEGxw4TM+1cFzlsJiFdKt8jtE4I8sIrIEq1dcVgAPQ2YlPCeIFmjOKZKhioiA5kJE6hLtRX0KaGb0yhlQpBnU6DcRGON9pqrjhYFqViJbbvtLBJqwLVMm6JzOVU0xuMJKflQfyaalicwWIBhd45j+U3molZnk/09N3l0acpPWjIH7AKg23rMWY1qFUngLlXpE1BFZ2frX5EX2tk0EuqcmMPNM3MSostR90BakxlvKXjeTyZ5cu6FTkjsj8WIArq3Myo0/nrX1SvEr7KwHrdw7Sy/AZIb7nRymOqFbzYHxYvXMw8pabwn2SATeqX64WQ1qM+ale8splLJpBhVg0dcvGmCJc/WhjKTq32RyYsuNvgeAjZsBClZqhrg3NbBJqeabbBXvBx7BhecUnNiO6Cy+JcVyAQbCCMzxb7qH0FiQK5eg6JVT46ujkQ3aS0QhCWN31vYfdmrZjVfzM+YS75iWi75QsKxSqJCecdnSd/eznQunbGc2S0JN+s4WZHhAOW7q43aVD9gYEDhv+7JZMi9XuN5kP/IWbfa9McX/4BrTIQyot9kStxRs216z5kchrm++TJZrWHWC7OYPAw1soORWN9XPSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(5660300002)(4326008)(66556008)(66946007)(86362001)(66476007)(6666004)(2906002)(36756003)(6486002)(107886003)(186003)(52116002)(508600001)(38100700002)(1076003)(44832011)(8936002)(6512007)(316002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uGjaMj7nlLYG38CPsv7NKssmEHmn7Kh7Z4Nm1SBtkJEwJr2lhWL1QudtxAhL?=
 =?us-ascii?Q?Cani8oDSw6TQ4FUuOX9U2zQo5iDrAw8YihW1A4lgNyWaAyLtMmd40VP7VQxo?=
 =?us-ascii?Q?x5SiwW8rHU83rRbEj516iCN4H61I5aGz8sRvH1FOMBBCQySXivrEO0zbait2?=
 =?us-ascii?Q?xK/Xb+pFGl02AgBIbRPfSml050M6qK2biLPUCNVpbbyLHvNFOjTogObFyIYZ?=
 =?us-ascii?Q?lejEvzZTbTe384VaA0SfAPjPQwKNH9wIl3zQL5/cIxIzfA8BCQBG1Cjr6Pwr?=
 =?us-ascii?Q?rBkba+dy8WH4Xkt5eJgQozPriZq5EbWgaVZzoWWRpfTc2z99HFmrH+5tED1n?=
 =?us-ascii?Q?Vq5dEtRG1DlTkHmCfXLvzRiDYIdO3VCJRPJTzf5Vh4SgTL6bHrnwD2Lp8oZ0?=
 =?us-ascii?Q?l7tNhvvaibOKdll0l85/StkAAkyvY2Hyhn2Ph6FwHSwPLNl4qmvA2DH4u75A?=
 =?us-ascii?Q?Z9gniwuM29DB7dgvlQBqRAInDTiS4LKP+wkmkGA4Etn3Zj2ir3DXw7GPoL7i?=
 =?us-ascii?Q?0RqXZQJxh3lGCUX9Jo4+Fsj+5YmjpK6MIQya0CdDXEzzQVdOQwqSMSCpT2XN?=
 =?us-ascii?Q?6y7/RAWNHUwZyKIR2eltr0T4MyXL4B45eKtYlFJn2rPMK9UcLKXhL27+OEIt?=
 =?us-ascii?Q?1ZciSx0HwdHsv7mh8BGmR7HG7+AMRyG8QqFi+rhN6FUY5+ZAY3P5UgghIW4s?=
 =?us-ascii?Q?GJBDlCCZCdIO+Qggj8wlM80SVDrtw13o+QtJjTCoxP7DLADQOSEQdsuo+CsC?=
 =?us-ascii?Q?yRbOIXOq5JsL/O2tXMDbI7GKQTLwmHsNY4stic/AUyqfyQbBED98rKiJJM8U?=
 =?us-ascii?Q?2OPVFHUW+qTnP2/jtUzJ4/SxFUY+S3tnlPGkd0aZTcTXpFO4xPKSwyOfgsS/?=
 =?us-ascii?Q?O8OhBea5vrUzLEwn97pOxRIr2Ktt0N634MICLlinWUPvPJar82INkeND/ABw?=
 =?us-ascii?Q?I17vmtXZGGn+jrnyl/moHaqefFSlnisbKEGQ8f8tWXKqiJDXBQAEbPso5I+X?=
 =?us-ascii?Q?wR7Pg9APd7Te1VN7cFEIzxh7zuMXCygiyglmaPhDcEimyN7IeBrvUvkA2pTm?=
 =?us-ascii?Q?xiBduMIM9kTd3UewwVbWUj50gkLj6r+cIYD4Gkqlj1mE1YgV0vWjrwerFi81?=
 =?us-ascii?Q?E47Io/0jFz743X9mEwmf0VVTyEoLi+6hKmXDqIrar/73U82YPmj6DiS9IQwl?=
 =?us-ascii?Q?CwNJ7c8GRMXgE0tI6mEHinxSJGlGG4vuZbT1Hm8rKzYmfux0ADsIAJuIgzQz?=
 =?us-ascii?Q?j/pzyNkflLpyKwRbB52rU4ssCyHVO4Rt8rt3JbCplPG7bh0aqHMurxmeqWdm?=
 =?us-ascii?Q?oy9T0aLL6jbtYZO3G7Ab02LvuatMExnZKlfmbc8GDBO6auwZ1rudcueGlaD8?=
 =?us-ascii?Q?A7u6EwXPw8dpHipVWiM3GLopbRvLQ3i9P+X7ATrtxxFNYekinLkelf75QEKQ?=
 =?us-ascii?Q?3Mt6+iCcxsSa2LX/LWqVUNfr8dAQmGQssaedS/oWtIVuIvDq8i1b455zR5f/?=
 =?us-ascii?Q?4T548gG+ovNmx46hYcwRGVyxmGjkuv3a3GHO8+r5X47694/po3kyGIkyQ9eQ?=
 =?us-ascii?Q?TY5djv0USiIAtq7w7fu7yOg0AvcWrt4vsFby9kxuhrH+063Yrx2m5nADhjdx?=
 =?us-ascii?Q?VQcUzR7Aeh9w7ySVcLxy+r+FWMQ3dd8NgCBAm5KO/AZL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd613a70-5d51-496f-53a5-08d99e3012ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:15.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fas+5Y5QceTPmSvApdPJfSMVakPNreTEYhgB29H2MnDhiJGr4sMrCNnJ1SZTn/i70a9tRiyTI3B4FPjogVueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-ORIG-GUID: LMF03Qzc95XrH-C6j1yrlCEN-jrOgx7L
X-Proofpoint-GUID: LMF03Qzc95XrH-C6j1yrlCEN-jrOgx7L
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
index 30c7c81d0437..1aed60793f47 100644
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
2.33.1.257.g9e0974a4e8

