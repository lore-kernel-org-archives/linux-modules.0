Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79CEC433F5
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9338C60F92
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbhJ0RuT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41416 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243403AbhJ0RuM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RHT3dG028933;
        Wed, 27 Oct 2021 17:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=zOJPn8XftF3Nf5SOJSO1DsNeT+CCTR7l6mZrErqqjlwscYsbBHcHoa50kaLPeDjuN+mA
 blDqmtgyu7/57XBjZ9jg85Px//0i8zyRjzCsqXJcMrQxdqOwcbxcYyL8FNG6efbSKZJX
 32fPXEDe9zp5qeuCTzjimnUu8LgCk6mj6FAehJH8NTqIcE09L1rD41rnuYZL5atYNUfR
 0c6ztDYG2dtHMhB79VC33X+jzDNZKS7ObVhzsdITR+2dHwnbq5gAoGqEyor8ZtpMzySy
 bdhYMTF3DzpbizdlREXECv3BJWwylGf3vgxpouAfM3CMb5IJqIJ5+gYyf6PjQ4U8L+eO sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fjms91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHfwo4056701;
        Wed, 27 Oct 2021 17:47:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3bx4grfjvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVdehk3NxA0fbxCpWMXW0SAJtNfc3hNkNEHL0VCcU7ybC5qK5D4S7tgZdKatPE8fxaf3jG/b552wRVg1uYsPITSAXlkyd5QqmF2sUttlZp1Ls3fRw1+ohza34B60BnvSnUkUrt9/TAx/9OBba4ZSBGaR2HMgPl3nFOxYMWd58rhjzyFUJMSGwnDLsr+wvD1Z6ousd54jNWvw9Id3XomthXyv9mT7nT30TFiRM0UVeJQvQ/S6d8zvsosxUopxpNhuF5gB4O6P/bBO2WJ7KL+ll9KHU2uGJhMiGHTDB2Pj14wtWCdT0XKhT9Ulqq2x1H61GWPhsItno8WkT8sdacDCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=Jaa8yMOr/7wVvRc6yMeuNkUepijibvB05ZePN5vVqvWQsC8bTajkVpAN8jPIgAkX/DuNWIwAT+4v2JpjlsRfjWvIv+WKUyNyUa4OsaCRm0yEchQc25oxO46zeTpzx9heyFtHJN8I5xqzDHq29a17CcuwPTMkZdJtcqufrhX0ahVD7FckF8a8o2cYnjHfB/Gu+PrRbTcMTxXmPcy7OjJTUNy4yo1BfU3UO+ioCPvI9jwcgqmdqtydPJjtUNw+xbSwKec3Vup9+O/AnWZCFBDKQweeAYvx054IT3jWWJovHxGWE11JTvPeB0qGY1xpoTr9zFS1RIIL1Kj0vND0V89QHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJIIpG5J/sZ/qkqMAjoO3Bcnzu1odC9OT6db7awLjKM=;
 b=Ro48sIZgt4Vy+GXtmgt805IIGzrgg5EE47sLIh85f4lkhGlDScs/X2KOXURJTVp/wJeUOFZ3KkA275tzEWQ5uMDgaB4W0XXPt+7kYDFrhYFbtwpvk3kEhINzQmmOYpvLYlzhYgyCRCeSMTxOrOeIR5D2ER2spojv3kBsJ1iuWW4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 17:47:38 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 7/7] kallsyms: add reliable symbol size info
Date:   Wed, 27 Oct 2021 18:47:06 +0100
Message-Id: <20211027174706.31010-8-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a6f25a2-6f63-48ca-198e-08d99971ddeb
X-MS-TrafficTypeDiagnostic: SA2PR10MB4730:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4730802C9F908EF289FB38358B859@SA2PR10MB4730.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIkwqSgSJ8MD1iulO0lXzQfwQx8ks8ykCgpGIDq0ZOk5KkeieUw4Qe8ulKWfjydh1vnFWWc4HsirBhE8yTtGfThdmlej1skQklmC41TCY7KPCo9T+wt196MA7oYetQF6BtpBFqRVxOOSLfW0CWBZq1FymkuV/yYbAjbWHXO6a908oAbtEAxESnKQRjzU0Gq+T299sy3njWEbqOwNHSFSnUcqGMPpaaQjSDhM4nLDh5OL3r8VeICfMo9g1xfU5dCqa0n0DXzAFO0AOU3qeJMUkGnt4eBNqGUZBRPkfRIpSyghptVc18AdBjhZA8/KVnhho+1TD2OMTqyxpncopwbI7dNfEyWXGdisJ2gXi6wNtK0wRScRm0zhZ080tgXG05Gsl353u5o2vryZ93Bb8n3vU5IcRWk+hnTA5VZnz4vAOtZCAe39GVjABjLnGscEObak/gOt+BHb8l7zY4QHLwL3kz8oj7a9Y1j2aup3cQxZSAFU+VUxj1DJSHZ2uX+ljH1ldxTvD8PDd8etaj9EBnxH4L5bDiFgtt6BrmyKgUNccDkF7s77sxu2GYkexKso4njaO/+angAPznDggCjUDRpWOQOG03x+giINgGfYSTE1pQ5SWkwxstK3SLp7IA/up5xOcplYIbbqTRQdrRiOvcDD1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(6666004)(1076003)(66556008)(36756003)(6506007)(2906002)(6512007)(86362001)(4326008)(6486002)(52116002)(66476007)(5660300002)(508600001)(66946007)(8936002)(30864003)(83380400001)(38100700002)(186003)(44832011)(316002)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DY6CJcukuhiToj6Fm1/wr7L7ACiBamUCBf1VjTshrLyOn23zpDk9To79CheJ?=
 =?us-ascii?Q?0FS2ia7NyhpGPnn49XywxRkLbHe4+fInUQUjJrnnOhZTp18Bncpm8KCMR/u3?=
 =?us-ascii?Q?qd5WgH111w3fMwtFxTMChRo+PDx0HEWdwhNBioIEa20FjR2KJBUhzbD+3O8J?=
 =?us-ascii?Q?gjFzfcpDfmtBnXebkQBWp15gCO4w7d9QgBS1N0TzlUUoZ0MkLrP9lXe0DvTi?=
 =?us-ascii?Q?nxF1VvcFBArXZlVZDC38VaTcJm+6V0jMb6VWvKz5po8OXqAFaAF0qhEeL/Q1?=
 =?us-ascii?Q?ZztkBMsvNQGlcs62lRMv2u36DjkqGHVj4eiGGj+iRjwp45QX2RHqAsT6pIMr?=
 =?us-ascii?Q?Tqh9lzSjwhy9gT1Tu70Au3rQUw30vjz6MdYaSoSy4stxdErBWC2Nstg+n+ij?=
 =?us-ascii?Q?nIkSqUGdBax3RwQ9xGKNvlphJbS5KH/TXXn7FS1DzhSyaAinm+8FA+e4YMQW?=
 =?us-ascii?Q?40KoqGxQb1rtVLoMic29Aol0hIW2KJdAMvHP6P8Vb1CL8PcBqVRfEIb71hBu?=
 =?us-ascii?Q?CunjgnZ5FrFZ8iIrBtMyaZy4DuHTCf1IgOuQ1yt5vva+63304RQmm12M42nc?=
 =?us-ascii?Q?tLtD57OReEQi5xy35XN9kxQ0k8/YJNpyumRhZGFxlckHK9cySa70PWzQWIbA?=
 =?us-ascii?Q?7idiqQXCSJlqUqY4tgezZKe+ObWEVTCaEwgQSSXJF8hSFIlx4F6DeNeWA6/X?=
 =?us-ascii?Q?HptMM7W80YL9RXOS73ukcpjfesPQBDDOAjf916NYYJ6SSA7oG+9qsL/rld3S?=
 =?us-ascii?Q?6yOXz3d0YQhI3vWtuB/DdT0X5LoMsQDWOtY05C8ReNBoT0e0evwyOH9WzU+D?=
 =?us-ascii?Q?t/hzdptTvrrSLQsZSdHi1UcXr3VHbMEZ+IzL0Yc+H52jO8Ht9mSmcxjAOdAr?=
 =?us-ascii?Q?T00kuj1NR99zPrQ1fCyyaq8tq8iAppwbknr/h/0Z/mZr+LPAzoatZTVl6h/w?=
 =?us-ascii?Q?a+aklnbsHvgMMwaiLCI7ksX9hyx6cp5mAl0oW5KoRVUjT69FYkpmVAZZ3MY6?=
 =?us-ascii?Q?CRTfBvpSB6nO0od8CutMSaIAlEWsfUh1qOQ+/krX/TdPWJViGRpR9kI05y72?=
 =?us-ascii?Q?ZYDLx91WgIniGW+Ji3SJkZ6i2x4+4yLccTzvLh9lfr/cqJ6ANwK/Sxjw+iX3?=
 =?us-ascii?Q?GKYIWrvovym7w2GHitUPcBUyMG6P15C46fmN5dYpfqoScKRPkJE86cTnE/OR?=
 =?us-ascii?Q?B1msTYwOxT5ORi3EBHH3r9azUfXNe8xU1bwwvKL10IbIuS6O9bNW0mvYXC8l?=
 =?us-ascii?Q?+63avI/GQSfKFptSFlOLlY+GjXT1Wr582fbP3zUqpiBIwNMpnT6/YLhZDu/z?=
 =?us-ascii?Q?VPVSqdPwngJ0t7fxeM9UenCAswfGm9ySkXexIzy1AEcWqVEU22vY797DvDld?=
 =?us-ascii?Q?sMsHSYA2K6Tvj9BJzw0pbcGdhIZU7YVVFYBG2lZGn6/Qylljl2pprs1LJQ64?=
 =?us-ascii?Q?+To5xB4NWF/H1ul/xHXeOX4DuI8jh1y2r1SoSD3GjHu6+5Uwl4xTbJJCYNZJ?=
 =?us-ascii?Q?rdZ0Uz2pLL3jHXuDrb/8N0NrPTMC+uL4Ih5cYjcBpYXRBsSeNoMt9jQc011N?=
 =?us-ascii?Q?/dNr4hFPTeKDxGwmKNrgncKxmty/jF/ZeFkdG2IcjK/uvkNQ0ZURn1TLKMHh?=
 =?us-ascii?Q?SIaWosD/zqtcrWNyDOEtQPT6D4Zn7lt5n5Rl9WSz1jzf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6f25a2-6f63-48ca-198e-08d99971ddeb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:38.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so7zOcbT2/FEwtDqw03BBTzPHKtJK8bAUV9aRZ6TBphwBtEncjUU0nXE5UaYOv9vbCQlIwKqnfv+oBUqoPqn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270099
X-Proofpoint-GUID: i8K5H9AfOdWhCSoZDk-SxYcIW93GByI8
X-Proofpoint-ORIG-GUID: i8K5H9AfOdWhCSoZDk-SxYcIW93GByI8
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

