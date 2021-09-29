Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C9C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B2960FE8
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbhI2VyU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47748 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346518AbhI2VyO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TL3xwe030863;
        Wed, 29 Sep 2021 21:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=Yr9XvBb639CkssjKXS6pIN9SJQ67vHg9KmQRxESNzDvcjqz8AWEDrBDFcfvCHoEpBUwi
 pjzQc5AoIFKYZib+rLb1yjHQqbfnGkDcpBpiiu4wkhW2EyK/feczzTF2QvG2sjRCiG6G
 vMr9iiHHBvR2pzEH898xVQp/Gd1BcC/fKHHhIpFedRUZ5naKKg1nug+b+EVmGe3F3o1B
 spjj/AlQju4WsDyNEp6OI1sP79m/v74OpIWDiHPX6S8U2AyufDcl/gquVW3zpsHtT2hS
 TMK56N0GfcFs3eXWoQw0oIJuEgtkskYJ9eTbtMyFy9yltcdFF/iUkZVvTMemnSJTlOdN vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bccc8jg4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLkUo3071072;
        Wed, 29 Sep 2021 21:52:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3bc3bkmp7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMtNf/tUQ+j3t51zJ/13/pE3q8Nut5SQOsjsIA4Vfrz9OfN0DDOJqle9+dq2LxXsLY/AC94BubmjMVH8LwRIMba98KwYO0UDn2fQmobo2NiUTIdN/BcsxE2j3utBkwa0svkKUDYQFKKr+1gD7tpv+1nBe2hjAXpJUm72SREy8zW8P18LJVFDzlO3TvF9djhpUvBi/JcLYrnEODCKhbj4jTZEsPrH7lCIXJ7pNT2cGJqHzIAPG5FkvNPZ/F2wnTPAWYGDj4WH/i3ndlKspky1Sm5OfK/6JMBCvrfDi0KR994Sx+r7ob47AIYhq8YcLHBZ6XX3FuVRdsc67/vG27HZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=nalu9ItKgDJXE2opG1A7/V7TzF3sXyKMk46a2u0ctuSxSxmwYqKD08CgDqG3DxYAQvI5hsevwEJV5vAAVSRYtJCGmgXMRKVfxWnVUdFoDC8vTHB9rU9Ky/PE58Bq3tJpxQvgFcRip9nX2gvbux0b8NJMsh4xjGz7otQ3FR98JySrpGBzuDFxuuN6ItfkdhnJiVp6rAfYKsvCRBDtax/jrXkW7YPiu5PNRXP8Sbgo9IDr+QPmflepJ4ZZ3VGX2fwXaBOWn4zsKKCXJRIlF0ne15oZ2Hz8Ond65XVuvYhxJWviZAaitLGOQr1hGwWltiXYF+XSwOZecGGfkkbipgtVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=lZ6Cv65qWGZ2DTwejDmDb693T3viYYUUbizDNQMpRrphLAdyTCrQORCxFwRWvOMVIpV/tHcl4EPKDumTdkXoP/1L1bB9goyivkvNuNoCSwA4Tf7YQgFT6JjLxoxJcdssO4hJ+tl8YdHdnZ+jpm7So3ElYYyyEmeQYe9wT17pwoY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2831.namprd10.prod.outlook.com (2603:10b6:805:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 21:52:25 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 7/7] kallsyms: add reliable symbol size info
Date:   Wed, 29 Sep 2021 22:51:54 +0100
Message-Id: <20210929215154.300692-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf474fb9-b11f-4412-2a3c-08d983936c91
X-MS-TrafficTypeDiagnostic: SN6PR10MB2831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB283113C5D0336DFCBA71388D8BA99@SN6PR10MB2831.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FBVFrNnS8oACSuc46tFplpAZPVYrW/deLkCDt0CH1qDOOLjtiANK2yFXTcmtYnfSiU+cfhYz+lgs/rHYr+VzPFtI06GlYroD9Xbej7g56O0CXSOqcEjH0h+S/R5gJt1TAQm0y2l5OQVUtchiTk21CPAP3ivACTL0qQXaFTRfAi6+nB0nFMwqBuhnPCZ+5thn0Up/1514tU4fV8cfOmoRqKoNo+puV5aXii//2CHkv0PH1eHOCJ0qBv+Nr6vVgcfGtd9D6xUJn9chblQ1Gb4AhNXMCgCvuDvLfIYA2Yd8FA0OCvHJsG+1k17MLmHfgTxpB3xlYUjzbP83HFXKleNvAng5muT4L0XSN4u29KpCCqUsAXLaT0GyzSJ/hJmHq6fN22fvbiKwF2MNUABiUuWk4DdpSmse7/+v9mflmIzSJYyOVs9VNItvHIwN9M+8vJhsX6r7Zvv6V+tnRAFXqtWqWRWInXoAso1zSiSoe8BvnncLaGOAZZReEU/R3VEy7ITi+zCREk11ipX7f0mV8ytCz23MrTUxXbAZgKSH61vBlCGO+BiuWFfVYzX2xx7aNv8vvE1T2z4mrWdkaBIsfcK0zw6DrEtPq62taROLB/Fn6viBBd5U6n9FMyVe2VHcMEjwsdyzHhz4+/y3c1k+0rBDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(86362001)(6666004)(316002)(8936002)(508600001)(83380400001)(2616005)(44832011)(66946007)(36756003)(5660300002)(2906002)(1076003)(6512007)(30864003)(52116002)(107886003)(186003)(4326008)(8676002)(66556008)(66476007)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?El1rZEE0NTsV0gys9Joad7mSEDcZPVDycf8m+YRw183B0Yl8R+0QGzLUSrOR?=
 =?us-ascii?Q?IoDEy0Fe+eTfsQsWHdf8/X6reIPmryyV+FEMJZKWNCbvNFkMi90Ok95JZd5Z?=
 =?us-ascii?Q?iPUkxmaybN2WyCyjOTHvf9t8qeOzxwOpsr8IqUMK8ZHhOEgDvndUskCIrUAa?=
 =?us-ascii?Q?nJ+3hoK4NsNW1NKqR0VTQ5tCgdUBjJZEC2FqIh1lkgCL4L/am1BEmbfIbP4s?=
 =?us-ascii?Q?CZa/ptF6p8hDxUz+LIJN1DCzNI9NLljC+is8ThDol9rCj4iBTjxgl40qA06l?=
 =?us-ascii?Q?DAOsRR+L1/OHmVNSVPjp2VTfPHxbiCcYmWK7IjXuJn+E1rYDd/hIWRTc/GYq?=
 =?us-ascii?Q?QHvc/KLYH+Cim7Kvj5mzl3XczHtl2QiL0yi4iqBN5Oz4dr7+fW8P+IkTJxLW?=
 =?us-ascii?Q?FsrD9zu/9/XtpM7zgRG6STAW0FqzbAlddsz2565QyBHPFlgT5SqHFiKBVtlW?=
 =?us-ascii?Q?wfJaSOoUy79CYQee14wl6qkuw9mQ+W4CB8qbt8D24WBuGYU26Qt7d1iXVct6?=
 =?us-ascii?Q?sPABI6EFX6nYanqtbegeBXqMpquvHMF/+2qTd37MKzHLPxiOyZxQqanoDbVc?=
 =?us-ascii?Q?cHVVkv1nZbucSMqzyIV6vrlwshdruIWqOo6rMcQeiaXXgPZzrfogzw598jEI?=
 =?us-ascii?Q?lq0c695H/FUaiph6qC9Q+R6UcBzZ0HYBYK4Z7GsnZbnDRlCD/vaog3ZWHUBI?=
 =?us-ascii?Q?BG+LyNhN1O2VKctDl6IbQ3yHzGe5qvNHSrWcVC3ru7y5C094hDM2a93LUC2Q?=
 =?us-ascii?Q?H29Q8f6qB1eBpe0Ong5UlIUrBmVvKck5Fpb/JvL5xZa2vybZ0WJ3gOV3l2bW?=
 =?us-ascii?Q?rewfynKAONbvNBpFaCVw7arHQhCMNfr3SeHMVGuyNaKqeMjqKWX4rVPcZHc9?=
 =?us-ascii?Q?iGBLss1S/wbafoHi43DoFY4o4K2SsMaAGSbNiL1sciT3QUZWmIlWhHzLK51z?=
 =?us-ascii?Q?YsqdTuyOz7Ycufqhp/snR8Mg0FYpkHbX9C9LvIHVBgVb0QwdDF4gz+0pXuzL?=
 =?us-ascii?Q?ZxjwUiyaM7pLPAtx4XVVaA5zNuz+NkaB4y/CcGFAKGeM5Gj81Oh3w3asjAN/?=
 =?us-ascii?Q?wvS9rUUif9w88HCMilOwvCr3j5i8qj5zReP3auXJOsJE2EX08iCLwThjBUb/?=
 =?us-ascii?Q?qkmo5SlGdadGa5fDuWzxSiLOhwWZA0lO80gA+AVUovRQvxvvSW4TSKW0U2jW?=
 =?us-ascii?Q?6mYHZzkygQgVqpA3a2dP3mMsFX4eKCPFlSKqQXJoBINcJrctGAbx2NyANZ0Y?=
 =?us-ascii?Q?v04Z5SKtV87eOYqSCeokTbuCUFJduoqg+BSdSPTjJIWDLpFPmtv4i74+QpsN?=
 =?us-ascii?Q?VgQSlPDuV0KaU3h5VS9jy/x26KYKqWW3sCJIr3LGNkdnRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf474fb9-b11f-4412-2a3c-08d983936c91
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:25.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82mcpd1zTOd055m6LnS3ouUEdJEsY4yCsVgxJcC2/bhSXQOsVodxyuDFBYSBb5/D0wjeSPxwjnlyUMAjLdZ8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2831
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290128
X-Proofpoint-GUID: HmcdEWEyd7R-BzrLrxHZKAyeoZddFPZ8
X-Proofpoint-ORIG-GUID: HmcdEWEyd7R-BzrLrxHZKAyeoZddFPZ8
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
index 40ec9a030eec..3653a7de9b41 100644
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
index a30075c14a25..c780f2a5d10c 100755
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
2.33.0.256.gb827f06fa9

