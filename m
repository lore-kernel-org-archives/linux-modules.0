Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61512C433EF
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AED610CA
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhKBSmh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:42:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235595AbhKBSmP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:42:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IJ3iq003237;
        Tue, 2 Nov 2021 18:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=hS10Ps9FwsTIcOvQ+MT+uHzblurG771GyWg6u3T/b/0=;
 b=QDKID8s97PJy86PV2nihjcuOdWcq9oifiymrZm2i4dEswA7h3COmVSwt17SadUsKR64K
 m68h4xbTzFxLpexCmr/8TnHNWrsmS5uEq4ZJ0ua7NwkRPpKA/KR00NeiZS1Pj90Pbogu
 okg1OwMJxbQLBnp/roWHsh6IVdvcBEa/doMt09lOXtI6Y1R3H213mH9UoliBB0q0i46H
 wSyrRX9u/EfkT4a+bcGahqZKZHclQl6s51U4HR6ag9bXkP+a5B4QG7SXZOZW06/wt1Ic
 LrAAcWsrR52igcK2XHVk7RPTH+7NyT85PqvbCRp/io6T3LBCtSwCqwxyUHDQXHJOig90 Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c278nhdm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2ILucw175746;
        Tue, 2 Nov 2021 18:39:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3c0wv4sudg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUc+OA7BknYrfHJQcwOmWm3Of8A8AdgSy0yKbUjE2bl+rnFTexyGYbS7N7hR3xK2sEwinG1J5jfmUi9NRirkXRts0PrSkmLIjbCE/6k94+CgYbYd/EzxQIDzma2W0k6r1EorwnDpoBDQIbgrji5p3+lF6MgViyEhOVkC67CJcknnyGFQT/l6+/zYZ+gdv8W9CWfT+Th5U29qcrxra4f6IW8eTKjAc/jnf5U3RJOxHwVv7r/KAH9hxX/SiI9CfneDv38xGoyccVYJSxD1A1qBv7pVm4Ulwoq3TXdrs6JS06kWNmpmkcysyH4WBU0VlEw3Gp/SGJO210m2oOzbugcEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS10Ps9FwsTIcOvQ+MT+uHzblurG771GyWg6u3T/b/0=;
 b=DyqEAQPb0Xfg44bp54ILg8M3+JXBqog5MnawvI08QbiD25OcCuH9Xgf77C+oxZav/Uucbbe4IUAUbkEqn7MJcd1GKw0aM3wTrb4IitW5CJbGzFmE/gKvknBqveeqbgLaxj1XKewuJC/gTHhLuRPSQF4R4gOeYdLdA97PU7sOXh1+SaCTbtQvL5rLvw9E0PMqxdZTQtajqv7TqDyfTvzfeVbY6WOCDkgCpU4peNPZfyCm/b3hcRgQAC5JBdTtGcU8TXGHwMXf2jYLPmhjvYc0Yf7+uK6WEG7rOla8+9b+HFiw1TPUiMJbM0C8aLor4edptwf6QcwnP2osKeGiE0cFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS10Ps9FwsTIcOvQ+MT+uHzblurG771GyWg6u3T/b/0=;
 b=DNIwtsp6OpqMDhRgE3HA+1smHRnCTqrlCaj87gqpvpN+bHp+d7tqzW6s/Sfv+jGnXr9X2/8LjMAYOn8wyOHtlH+wHYbJwz4a3QyZdi37CPxRhJfnjkIu3XBmUb20gbBK2589qlsngO13Evnj9esQy00sufjflFakiBv5DWav1QY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 18:39:29 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 7/7] kallsyms: add reliable symbol size info
Date:   Tue,  2 Nov 2021 18:38:51 +0000
Message-Id: <20211102183851.168676-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150b91ae-0b3b-4f33-ff2d-08d99e301a7b
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5679C69BD2CFB4C02CE0BCAD8B8B9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjv1BQy8UZpXiUnPXbh+Ico7v1vnO2tmWm4MIePyyfPCPjlscDbZkmfN8SOLiq7I1PslN9e63QWcXrYkEwpy0NiYLEyTrlAtHiPWyVlrAi3uFppOf7GOtU+j53yqYjt+yW8Y7cf0bf+O3CJwQUID75zfB6oGSJOHIyFtUJwtWKRKw0BaOOzet5PFka4Y57gE+k0VnlQMPv3A/qJpOiLnwln/NY+EbYTciOgn/2W0WJ6QNnsfXfHGSvKOMV1nE1pGjkZSDRDStJHtcN9wEpGFwXnBfx2VBt9Uf8SW7JQrrxr8c62TXJzrGr6pa6kTfhLqzsU9TajxqATbiIVpiYHmgfDIVh/Qls5ohrKBmNtTvxQwSBVW3mmBoHscQc4NqIBoeUo9ts14bhYRMJ/dlG2pEcx2Mx7ShdrACVAR2ajxcoXixeuHdKZpQWQmpGB44TTUqbGUZqn7c6pZ5u/eOq7sxFLJl9RUr0kKN24ubC4O0xglwGptkHbUEOxSGmpxvpWF5Y2Gz4xTOuf0SoBUG9RrKFjGavofmoInEFn2+ZwOhL7EQk3H1WwGcuwg0Lkjxef139kdYOQvCe8kAcZ1XcuccXSl+WZeXI0XQbqhi8hKBomaSlNxrlurjpLnPigBEnTuiG+51grKnk/Kfn7hrBNIjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6666004)(30864003)(8676002)(36756003)(86362001)(186003)(107886003)(316002)(6512007)(1076003)(5660300002)(52116002)(6486002)(38100700002)(4326008)(2906002)(8936002)(44832011)(66476007)(2616005)(66946007)(83380400001)(66556008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jg857eGXIGiDbuEYi32lmuemCWqqP/LFZWhetOqdyplyfeWvz8Tw03ihSEjj?=
 =?us-ascii?Q?j9eiyXkhYLs5aZYn4GS1gy8IfFhwmjVy0rrZXqpEG6nu036O4viSnxAFlZbz?=
 =?us-ascii?Q?kBUV9IIWt4JZMrsIu6rXm3Acn90+RIhyAFbKwzdrFcOWJAMZ087Av7xCbgHG?=
 =?us-ascii?Q?K5NPtF/8JzGzKPa1Wpu0t2+InLyaGsfzxpk7t1mU7YXQoH5kmLC3ZUk93KdT?=
 =?us-ascii?Q?gl+ryLNNc5aNBYZfnD2IfFcqOXJ4HWxlFQqUMhk1C+dgmMXkNsalUjKX4xxF?=
 =?us-ascii?Q?1N8IXwiIxuep76NY+cr/p8YpT2IOr1IiY0yW3OUA6Rk6hf/3qhV0u/+UCO5F?=
 =?us-ascii?Q?zxsIXLU7kYNDO9AHozH4lIaCOkVpbz/cE0Cd6tGwMjXmnXKAoLv64TWYgKDV?=
 =?us-ascii?Q?tEzgzjdmID7ulu+B9mBH3KQKcJI/+c5hlHLV2mCx2hJ/FE14jDGBVP17npn7?=
 =?us-ascii?Q?CZ4ydH68VgI4xBwGEExSu2SoFerVNaAhKAK9FP60dlZyafsNAm6LyLlwL667?=
 =?us-ascii?Q?YXnPWlYcAWf5Ck+MFqyMJ6QX5dIXb7dGOZbXIyspjA2wmpe72iettFgyalug?=
 =?us-ascii?Q?X5W3yXHfq2iyULjkXMPC3tL9aTbX/cuJPblQF8yYmBy0ePDwkNtk7gSt7/8E?=
 =?us-ascii?Q?6et1HoZFzYWzNT8bUXh6YOrZKNSJPpvjVATvKIiSw7IGaC9P8n8yE2kM8gD7?=
 =?us-ascii?Q?ekJ4UKuiHIzVMXv8veHG5znVpB9DaJ6GfYLNv8VWc0S7w8NVvfN+Lg8sDdtD?=
 =?us-ascii?Q?tGPNEOenOOziY9kVLhpouSZC4xB2L/3BJP6VLg1rFp5zWC66UnZqJDTeSKCj?=
 =?us-ascii?Q?DIF7HlYQVLi6pcKo6VuAl6/sxOtwl5ArAYga72BRKMG6fHwnl4WXAeAn1HyK?=
 =?us-ascii?Q?NwgbMu1XpalhY9dTP6G5rWG2WKdG5B4SJy9x3XSe2suQFnwgyyJ4BxHwosoL?=
 =?us-ascii?Q?FRZ8soYzfJB/fFZcOviPm68yNRguxio0PVG0DbgLNuEIQsoR9wRXmpnHy7/r?=
 =?us-ascii?Q?IdOPD8pV/0jOUuYfkLdBvz2dDP2QmbMGsPMOHoIX6stFwapvd4NDwH4Y9B1C?=
 =?us-ascii?Q?QKWSEVB+VcoHqxRW/fVu9Cxq4fLyCYNvCpj+XSOIF+AjJ9LjzEjtJx9PZBy7?=
 =?us-ascii?Q?ZvzYSchpCf3sv4HwQfWDlsQT02V5Ao1nmaPdlfabO2o9nt6R6PN0//0XoHZE?=
 =?us-ascii?Q?9vS9FgoOZ8pzsv/X1Mn161UTp8pk/fa/ShNzcq2rZSJ8//S22seZCnxcRg+u?=
 =?us-ascii?Q?IIkLZMWmpgoTqs7rtFWRsXOrzlVtoNDQ8bZ3LnvpIuvs9yRloRFA8EhsvK1z?=
 =?us-ascii?Q?F4ypVdWNA2DeKjXcUklDq73BNLM0SZCPr7NCnPc1EtJSDVtpvk3dolQKQkxk?=
 =?us-ascii?Q?ilLWB7vN6TPqlG2bREm5KUYasDI41xVpBrFhzPsQf4DtrJRenrdHl0nebNYN?=
 =?us-ascii?Q?Jb7yADvDYlouGitJfIf80upkQxFmigrEpyctTWD7fUlSq6CmQbppeM1adPb6?=
 =?us-ascii?Q?FN+RT1qKnXeaL//E9+1d+vsmB6Nw7co1+6rn6juAjSe0KCgagCHK0g620Pns?=
 =?us-ascii?Q?u+CsC0cf38F8yOJwZiZM1yMrK3D3SQuqXTeYa+gK732qZtpDW8ZDW6tp5+f+?=
 =?us-ascii?Q?CFL+HOonZbpqRsgxlqujy7/MXkolIJbYgt24AdOca32Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150b91ae-0b3b-4f33-ff2d-08d99e301a7b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:29.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHIb2CBMPe2ADKZgdh6HUhB3DWLNmsNFXJjlMWvnxQREUvwmiM5YY7aA623jNUVeKMylkF8wygqVojY96sSfbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-GUID: AY8zBQFCvQ0ISxahJag4Wtgw9GiWZil9
X-Proofpoint-ORIG-GUID: AY8zBQFCvQ0ISxahJag4Wtgw9GiWZil9
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The existing mechanisms in get_symbol_pos to determine the end of a
symbol is an inaccurate heuristic.  By passing nm -S output into
scripts/kallsyms.c and writing the symbol sizes to a new .kallsyms_sizes
section, we can get accurate sizes and sort the symbols accordingly,
reliably sorting zero-size symbols first (on the grounds that they are
usually e.g. section markers, and other symbols at the same address are
conceptually contained within them and should be sorted after them),
then larger symbols before smaller ones (so that overlapping symbols
print the containing symbol first, before its containees).  We can
also use this to improve aliased symbol detection.

Emit the size info as an extra column in /proc/kallmodsyms (since its
format is not yet set in stone), and export it to iterator consumers.

The notable downside of this is that the new .kallsyms_sizes is pretty
big: a PTR per symbol, so vmlinux.o grows by almost a megabyte, though
it compresses pretty well, so bzImage grows by only a megabyte.

I'm not sure how to reduce this (perhaps using an array with elements
sized to be no larger than needed for the contents, so that almost
always two-byte entries would do? except that in my test kernel two
symbols are bigger than this: sme_workarea, at 400K, and __log_buf, at
100K: the latter seems often likely to be larger than 64K).  A simple
scheme to reduce this would be to split the sizes array into several
arrays with differently-sized elements, and run-length-compress away the
zero bytes -- but that's not implemented yet, and might never be if
people think the whole idea of this is pointless.

In the absence of a way to shrink things, this should probably be hidden
behind a new config symbol if exposed at all, and kallmodsyms just shows
zero sizes if it's configured out (but this is enough of an RFC that
that's not yet done: possibly the benefits of this are too marginal to
be worth it, even if they do let kall(mod)syms consumers distinguish
symbols from padding, which was previously impossible).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
---
 include/linux/module.h  |  7 ++--
 kernel/kallsyms.c       | 74 ++++++++++++++++++++++-------------------
 kernel/module.c         |  4 ++-
 scripts/kallsyms.c      | 29 +++++++++++++---
 scripts/link-vmlinux.sh |  7 +++-
 5 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..b58f2de48957 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -590,7 +590,8 @@ struct module *find_module(const char *name);
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -768,8 +769,8 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
 }
 
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
-					char *type, char *name,
-					char *module_name, int *exported)
+				     char *type, char *name, char *module_name,
+				     unsigned long *size, int *exported)
 {
 	return -ERANGE;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 38109bb02bef..c87a593b40ea 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -36,6 +36,7 @@
  */
 extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
+extern const unsigned long kallsyms_sizes[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -257,12 +258,24 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+/*
+ * The caller passes in an address, and we return an index to the symbol --
+ * potentially also size and offset information.
+ * But an address might map to multiple symbols because:
+ *   - some symbols might have zero size
+ *   - some symbols might be aliases of one another
+ *   - some symbols might span (encompass) others
+ * The symbols should already be ordered so that, for a particular address,
+ * we first have the zero-size ones, then the biggest, then the smallest.
+ * So we find the index by:
+ *   - finding the last symbol with the target address
+ *   - backing the index up so long as both the address and size are unchanged
+ */
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
 				    unsigned long *offset)
 {
-	unsigned long symbol_start = 0, symbol_end = 0;
-	unsigned long i, low, high, mid;
+	unsigned long low, high, mid;
 
 	/* This kernel should never had been booted. */
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
@@ -283,36 +296,17 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	}
 
 	/*
-	 * Search for the first aliased symbol. Aliased
-	 * symbols are symbols with the same address.
+	 * Search for the first aliased symbol.
 	 */
-	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
+	while (low
+	    && kallsyms_sym_address(low-1) == kallsyms_sym_address(low)
+	    && kallsyms_sizes[low-1] == kallsyms_sizes[low])
 		--low;
 
-	symbol_start = kallsyms_sym_address(low);
-
-	/* Search for next non-aliased symbol. */
-	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_sym_address(i) > symbol_start) {
-			symbol_end = kallsyms_sym_address(i);
-			break;
-		}
-	}
-
-	/* If we found no next symbol, we use the end of the section. */
-	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-			symbol_end = (unsigned long)_end;
-		else
-			symbol_end = (unsigned long)_etext;
-	}
-
 	if (symbolsize)
-		*symbolsize = symbol_end - symbol_start;
+		*symbolsize = kallsyms_sizes[low];
 	if (offset)
-		*offset = addr - symbol_start;
+		*offset = addr - kallsyms_sym_address(low);
 
 	return low;
 }
@@ -633,6 +627,7 @@ struct kallsym_iter {
 	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	unsigned long size;
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
@@ -667,7 +662,7 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
-				     &iter->exported);
+				     &iter->size, &iter->exported);
 	iter->builtin_module_names = NULL;
 
 	if (ret < 0) {
@@ -740,6 +735,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms
 	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
+	iter->size = kallsyms_sizes[iter->pos];
 	iter->type = kallsyms_get_symbol_type(off);
 
 	iter->module_name[0] = '\0';
@@ -858,12 +854,14 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
+	unsigned long size;
 
 	/* Some debugging symbols have no name.  Ignore them. */
 	if (!iter->name[0])
 		return 0;
 
 	value = iter->show_value ? (void *)iter->value : NULL;
+	size = iter->show_value ? iter->size : 0;
 
 	/*
 	 * Real module, or built-in module and /proc/kallsyms being shown.
@@ -883,15 +881,15 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 			 * /proc/kallmodsyms, built as a module.
 			 */
 			if (iter->builtin_module_names == NULL)
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->module_name);
 			/*
 			 * /proc/kallmodsyms, single-module symbol.
 			 */
 			else if (*iter->builtin_module_names != '\0')
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->builtin_module_names);
 			/*
 			 * /proc/kallmodsyms, multimodule symbol.  Formatted
@@ -902,8 +900,8 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 				size_t i = *(char *)(iter->builtin_module_names + 1);
 				const char *walk = iter->builtin_module_names + 2;
 
-				seq_printf(m, "%px %c %s\t[%s]", value,
-					   type, iter->name, walk);
+				seq_printf(m, "%px %lx %c %s\t[%s]", value,
+					   size, type, iter->name, walk);
 
                                 while (--i > 0) {
 					walk += strlen(walk) + 1;
@@ -915,7 +913,13 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 #endif /* CONFIG_KALLMODSYMS */
 			seq_printf(m, "%px %c %s\t[%s]\n", value,
 				   type, iter->name, iter->module_name);
-	} else
+	/*
+	 * Non-modular, /proc/kallmodsyms -> print size.
+	 */
+	} else if (kallmodsyms)
+		seq_printf(m, "%px %lx %c %s\n", value, size,
+			   iter->type, iter->name);
+	else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index 5c26a76e800b..0d02101645fd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4368,7 +4368,8 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported)
 {
 	struct module *mod;
 
@@ -4387,6 +4388,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
+			*size = kallsyms->symtab[symnum].st_size;
 			preempt_enable();
 			return 0;
 		}
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 93fdf0dcf587..fcb1d706809c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux
+ * Usage: nm -n -S vmlinux
  *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
  *             [--base-relative] [--builtin=modules_thick.builtin]
  *        > symbols.S
@@ -38,6 +38,7 @@
 
 struct sym_entry {
 	unsigned long long addr;
+	unsigned long long size;
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
@@ -394,6 +395,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_addresses",
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
+		"kallsyms_sizes",
 		"kallsyms_num_syms",
 		"kallsyms_num_modules",
 		"kallsyms_names",
@@ -507,10 +509,11 @@ static struct sym_entry *read_symbol(FILE *in)
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
-	int rc;
+	int rc = 0;
+	unsigned long long size;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
-	if (rc != 3) {
+	rc = fscanf(in, "%llx %llx %c %499s\n", &addr, &size, &type, name);
+	if (rc != 4) {
 		if (rc != EOF && fgets(name, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
@@ -548,6 +551,7 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
 	sym->percpu_absolute = 0;
+	sym->size = size;
 
 	return sym;
 }
@@ -932,6 +936,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+	output_label("kallsyms_sizes");
+	for (i = 0; i < table_cnt; i++)
+		printf("\tPTR\t%#llx\n", table[i]->size);
+	printf("\n");
+
 #ifdef CONFIG_KALLMODSYMS
 	output_kallmodsyms_modules();
 	output_kallmodsyms_objfiles();
@@ -1189,6 +1198,18 @@ static int compare_symbols(const void *a, const void *b)
 	if (sa->addr < sb->addr)
 		return -1;
 
+	/* zero-size markers before nonzero-size symbols */
+	if (sa->size > 0 && sb->size == 0)
+		return 1;
+	if (sa->size == 0 && sb->size > 0)
+		return -1;
+
+	/* sort by size (large size preceding symbols it encompasses) */
+	if (sa->size < sb->size)
+		return 1;
+	if (sa->size > sb->size)
+		return -1;
+
 	/* sort by "weakness" type */
 	wa = (sa->sym[0] == 'w') || (sa->sym[0] == 'W');
 	wb = (sb->sym[0] == 'w') || (sb->sym[0] == 'W');
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 37fae04523ba..07bbe519b252 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -274,7 +274,12 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	${NM} -n ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	# "nm -S" does not print symbol size when size is 0
+	# Therefore use awk to regularize the data:
+	#   - when there are only three fields, add an explicit "0"
+	#   - when there are already four fields, pass through as is
+	${NM} -n -S ${1} | ${AWK} 'NF==3 {print $1, 0, $2, $3}; NF==4' | \
+	    scripts/kallsyms ${kallsymopt} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.33.1.257.g9e0974a4e8

