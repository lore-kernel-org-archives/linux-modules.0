Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C72C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7F610A4
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhJ0RuB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19020 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238579AbhJ0RuA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RHVEZD004973;
        Wed, 27 Oct 2021 17:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=UaUGHffwn2GA0hN8MZmSFKwU1e9uJShaJVmP0sJ69AJpBgfYWAZDlrLsPGrk8gI8n/es
 HaLuZydHnWWHWPP6VQj8J3qZHNmn5oXtaNcUjCIUAPKeXtuQaYhupUwXMQ1jezuwkPK1
 GofFba6UoiApzLxySoVfyJ/9SSTFr5hEB346zj5a1/mAXW8WLoGI7kApf5ESY9g97tdt
 xNuYT8YhNylSZuuSMdNANx/RAUpJgpsqGB8SuudvQqHnDFLoPglwOVbwMtfuMWVulAfx
 YJsLjMb8BcrAE1QYgimhTn+cEufkT0/2qugIGzd/Qa2SEL7w9G2b3c2VRQvi4R0KbMjF Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fj4pmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHfIVQ128934;
        Wed, 27 Oct 2021 17:47:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3bx4ga9wd1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h75FwizpPZyt7IcCDAz/YHCkAoPl5310Ys3peUuZNZUq9Bxeq5EbqPrB7d3iR6QYXRZauhRUC787CI0yQQFmkw5QrJui++3Rv21ulwh4TtkndfOcMzJ6BltXwhto0QwoOjQHUvMqy7Y+mYvKs4iwUC/Eq5HW2yeRjFB64KOTSvsmu9HVU9HdYhyBMehyLKsv2TrGF2alDn71phDKXQS81eC0VRuYk44wtLpFYmt+6b9ao5YbIvR9JSQzWGZaNGRMlSt8f2gFSdQZ69zlpTsg5jUFngzzJ/GTGD/hp2Fgb9eF5tVsiGZeEd4xhQ3ms9LWKeQFeIXa0eULd4Yek9bm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=OeVapGt5SOD+9MfmlCiLpRsCu9ULabj6eufeRYxApRehWObN1z2qHTYL4+RAMHlj/lbVSkb8cyRoFwgtjuLrs8wUX+nZR7CCopixJw3S94y4GfQW62rDGaA+ZVNEemsr2p5vtb4dJSlPYFAXHxToyd7DtbziVEVGqPT6WrnjVG2D3VhcVdDHHDhp0FEIBemay0fjR+oAHlryQ1QTZAWYJfD3m/g2Pmb9JGYdxTaVLActxMjwIYMuh8Xl1IjOcUPtkMN3M8tWNqJd/b9D9DtId7wjWpVfwy2YROk1mOn+nLuEv4LQFQ4qss14gc7cooTF9f3VbwONH5RvDZN5DRUuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOa3UXtxF8rBy0wRwDON0hJQFWHlXomEbJXPiw/4UcI=;
 b=e+4E2jRt23xy9Jb+xEEAP37jxN8X0N0+64KFo9QD5JUqgPo7MqBfOtZiQPJhwt9O3BYEepJ+1AhJImpuk981MIxkxhlQHjGYQDaFZL/0Ol3ljH+Hc2ATCSo1sFVUIKOUNKH16g87VJ+jkpEuN047zMFKOtnbV7/6F/2u2RvAvZw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 17:47:28 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:28 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 1/7] kbuild: bring back tristate.conf
Date:   Wed, 27 Oct 2021 18:47:00 +0100
Message-Id: <20211027174706.31010-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211027174706.31010-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
 <20211027174706.31010-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25ab43e-c5cd-461b-4faa-08d99971d7e6
X-MS-TrafficTypeDiagnostic: SN6PR10MB2925:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2925666CA7ED97E2D1F344288B859@SN6PR10MB2925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyC8PzfQfgolek1eSjFa4eVPuKq+bNatPNi4/y1e3OiSXL72IrPgPJfmgrgzv3BdeyffNYqedBx1YoqsFSH5VFhRmT8b1vjC1GG+hMvKhN6ZtwKMl30RS9EeXALnkFBcb7UdUu5ymApkz1gjnhzsbLe8jG81I01VdVNHz/sSvvAO0Pqp9G3pw09GQsXcq1fPKMEwTNZJhHk5UQUs5c8kQTE86zmXwZCzcl84VnYnpEr3A/VKdANxk2NdrzEyIkWHnPog5XWaRJao0dwb6bGAh+TZkTDLq6AT8UixtWgDz8hBTtfYebzs3NTUVNIV7LGR4l6IwyvVb09NRxOvbYiBVNzZzGRpzSiSuR5/xnYMQxZswFgBEVSU/d5fqE2PA6BHIzZks7O1iZvr+fCuF94dhsFb0fggTGS9/5RFRXOP7puuGpaadn3qcMe9iOioyEzTNEIerzTY+KwWbnF9/rCBnvCd0JOtbqTTHyht0jiaY7+EmfpDz+j/cl49dsIHEiTIj0KbJtS7d5P5X8GmyuRaD/odKEJ08d8qz1h3Z35Th6/mvAapmyrFrnS89aD342cVwcnEqgedo7FCV8NOAkpRnAYWhYQq5ey7sg4XTEEwgjKO92Ckxu+Sl9zUuTpvQesSH8T+B+OJnRRvyqIvL2lMWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(1076003)(186003)(66946007)(86362001)(44832011)(316002)(36756003)(38100700002)(52116002)(6512007)(107886003)(8936002)(83380400001)(6666004)(4326008)(6486002)(508600001)(6506007)(2906002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Odzlwc1lSjj6LF//UW5zKvEXsT2r39yFUnILNerwzWQhQN1Sh88SljToRhNG?=
 =?us-ascii?Q?T9b+L0hpi3WmJcXtgF6GClPNNaeLqf5qlnv+j3Q40Mot07VXaTo9KHosBOuy?=
 =?us-ascii?Q?a/BDXegqwqWPfz7qWnt3vBNmNF8pXtQYjrxQhCzRUt0HahNhQE5uDaE2+X3T?=
 =?us-ascii?Q?AYJxo99+Ouji0hXD+jQ4hGoKORiCyq61vAOIS7klFPWFNi1r7fOokHP0UPVn?=
 =?us-ascii?Q?Vztgp2D5S7vhvH5OQl4IuaYIXL1ean9fTMslUhZAfiOwDvVNEeOu5/N91Tnk?=
 =?us-ascii?Q?hYMMqbweYbfvYUCCZ2zm/E1/NjgwQGQWFBTVJ6FGAp6KclqXGFTScOJxU8tA?=
 =?us-ascii?Q?hwjEk6eGOe55WexPY+Xci3a+hCOeOiTJZDGUJulWgdq4N3rpjV4VklD519MD?=
 =?us-ascii?Q?NzTPRGwOTpdBqeAJ0xr3Ce8t2HfcnvZJlqizNMR7ZwpxuAzfAnn9n4fuvw8q?=
 =?us-ascii?Q?okTbh5nhp4L8Hlm8GCoyuMkaAPzVIQUSZFgDeSaIOsIwKHu0E1epoZ67iu5p?=
 =?us-ascii?Q?eteK8kEXAZRf9GrbETHBwsG5iaWLU54jEHKZQoufijF8oH5/s3dudLJL12Rh?=
 =?us-ascii?Q?8WWXc8Yzz6v1fRIeK5jTxdTeIpsZYfjwOOfOhn5tcwNKwmhrfnUj1Qe0RLIJ?=
 =?us-ascii?Q?pb9342P1MVL0vbAKB2/4BOGCjLF98q5lojU9RPcwzIzK3I2BS9xKtPMeJEHb?=
 =?us-ascii?Q?DfQ4GviH3samRp1j66B2NlqmXphd0TtOH8TINKjjV5utrJHy1ctvKrJarttK?=
 =?us-ascii?Q?nYTTz5AUB2Yh2ZJXNWdLnwQJX1hQGBJ9nmx8wZGaXeIcRwauupOdP2PBK8+U?=
 =?us-ascii?Q?W4w3QuPnlCjtJ37lVLcS8pILQ61I7h8Yzqhhv1fKuohGeeMeINM4hpdJ5Py2?=
 =?us-ascii?Q?V0+cdh4Hs04Lp9DxBASZ6pjGdQeOOERo1UvD0mKZ5vyv/yf2NEL9NKJhoRAL?=
 =?us-ascii?Q?v8sghQm4c8ODxsjql60QxA9BVYUQJ9LLYl55qLzLxxfqJUkv+SCvzVVQXOgo?=
 =?us-ascii?Q?4UOssKJO9iylt7R3fnmJUtxFN6dpO+Yi6WF46ssYFk8o9DmpfJVl3+1NW39a?=
 =?us-ascii?Q?EwaE/gO8QPWSh1VVRAuPOziBwbTkGHYYOeKDirN9bG58VIEeYAmd9lC0NpY+?=
 =?us-ascii?Q?FCSFYIeHOab25JcJfWHHFL73vG6aJpw9cWZfQ0C1xs09aRA6ZztIM2bPZUEM?=
 =?us-ascii?Q?qyR/X6CYrWsPB0TdonaQXjx1tCFloI6iJ/NOVTKV66CK6APJ/uc4PO3CnATL?=
 =?us-ascii?Q?Q81siYT6/edOHd/owmcgJZD4Ue0tJd6VFliYMLXiQa/wyaZjwmL0nZ3IweGF?=
 =?us-ascii?Q?O9KKKpLs9fcvS1NbBt/Iyj/Si+iHm/+cuVb+wy+SSXvGgV3zo3LgjKKnx95J?=
 =?us-ascii?Q?N52lP+STs7ceJXDhLm6i0UJAK7lyspsfCeJfSd/WDGeHZ3tWsv+x7Nsd59IB?=
 =?us-ascii?Q?dwGctwrpL0/aZbzQ1ly+KJK94FiXOJQJOwwTc+MWYmbzN1zv1fNZewhCuOBK?=
 =?us-ascii?Q?6dZ2D9x15fFtbRKfO5UM7SxZZEkVMBEDZYPfB0+5OBfGTYZ4rw6PwYEJiXm7?=
 =?us-ascii?Q?Y/5Zvfvt1KG9zi41go9Qobn9e4oUJztlM1CM1jhehZAOltkv5L46cVwGMysJ?=
 =?us-ascii?Q?CD/38Y5uyr9UxkTHxhxfrRFl7rlIw29PAGtmXEHHbyll?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25ab43e-c5cd-461b-4faa-08d99971d7e6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:28.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9JmqEZVP6jSF+HhddCzW2n9Ro5mvdKYCuciD9v2VaLMBWhX48HDAdY3jKiWlx9zHyzeH+EzhgqbVO9R167nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270099
X-Proofpoint-GUID: 0iV0RnlfvAHWDKY4F7NFY8JTDByuUZwO
X-Proofpoint-ORIG-GUID: 0iV0RnlfvAHWDKY4F7NFY8JTDByuUZwO
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

