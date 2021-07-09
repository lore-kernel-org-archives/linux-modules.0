Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD26C07E9C
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7113613BF
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGIW3D (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:29:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8064 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhGIW2v (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKqZ5028056;
        Fri, 9 Jul 2021 22:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=qqz42f9HY4Y3qac15HctYmJviY8V6r04OXLl1PSoXT0=;
 b=TZfmYY8ngIR4mg8f0+Ywdb9OTiM3wKO8askzfVC7v1qUAT4XX/Foqc+dtGseaqXHs+qY
 03HCihIBuC9gPuwL98IOhlz5Ym4l8/9u61RlEKS1uu7FSWO7xb68qrLilaidV9ea10HQ
 Fw/G19G06nV/ytRYeNebUrCS38Dtt1NESUuI5Se0QUgvLA4x5b/2ak2e1pIUyM7Sd08T
 F90utQwTOWe11bq6twczJtgdD3EXumC103CE14OF0euj8Cw+soFLWUtLrM7FE83rRi3I
 5csGJNK1aCbTouf/lUkkfjM3+iAU58hCaiUl0Jd2/0vmE7nSw063EIoQHqk3BfDRnX3e 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pkn49cjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MOmtj072029;
        Fri, 9 Jul 2021 22:26:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 39k1p6qvyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu98bK0vwkxyR6o/fjVvuMFmk8IPQ/QW3JlWQTyC1xyI1ohwT4KIhsczHyD3UnNJj0f+zaExG/AXZtyAQ8CdKtjdvdzRDDTEect4j0/HsHF/J0LKLdapd3wIt8fjcW1IqBCSPL1f4NlnfbFpS02Vnnqd7xi26gO29apWe8CTzb1eMxYI9wTawFnFzveRUAdQ0jI1tS0gV4NZ1hF2cbsTOeVwI/of8J4vSNfg3n9bh+TKvd9iqvrRXmVzRaRNOv8v6g3okEQy/83L/P5i2ZHOpawcm1flo96uxslO4HHz0Xhnzbt3/a6i0NyagwwjleoJfnC51bLF0lFQ7Ovx4ewDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqz42f9HY4Y3qac15HctYmJviY8V6r04OXLl1PSoXT0=;
 b=jTN+S1OlsobdUjrrpCju3+Qif67tnQcZ/sHDc9M7XUbNerQdsrowPGFVGW9KLwFcPgvjrzUahxih97Ab94vHelbYuvOimgK5CzoCctlo9unc64cVQgQJB4VHKwvbMXPW62omyDPJRx6Nb9nCYfVHsF+UxqBWVaDlF/ddtwdgItjiaAaMXcPq5S1p21eq1v8QrKigF8tzF+CjP6gHfMsWLc2jE60ANGe2UVVmVpvhWKVKDxbOaS9uTyXPcYTmlB2xSgoWFWHjgkYaqvDNq/a0Vz0JTEODHdJnzY9Wv175+3fn8QGDxnqycd2tEmhGRfmLvkYsHM9h85gz6iAsfwVkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqz42f9HY4Y3qac15HctYmJviY8V6r04OXLl1PSoXT0=;
 b=cJFp8tlngm5d36De5cs5p1uQrVhZEqRiM9cJqDogBPjCmXcwT7acR1pvhjnSuN64WiHb+CVom5NWksKGjTQCjobmBQUpY2Tosl5h5GNbz1p5feoc6smzC3TDqeOFVSjV/cfTnnFGoANmG1as0IoSIjoeFJ8ljjaUSxoP5VmSqmY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:26:01 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:26:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Eugene Loh <eugene.loh@oracle.com>
Subject: [PATCH RFC 7/7] kallsyms: add reliable symbol size info
Date:   Fri,  9 Jul 2021 23:25:23 +0100
Message-Id: <20210709222523.17639-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.32.0.255.gd9b1d14a2a
In-Reply-To: <20210709222523.17639-1-nick.alcock@oracle.com>
References: <20210709222523.17639-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb220e4-cfe7-442e-68f6-08d9432887f2
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB2927AC67604FC83D0559DFC48B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQye6tXN5ALIRyxuZEiFk0G0TETWisIOZjm8FPLlrMWRj45/warQbL0fNf0aLFz2E05bvtP6ligEpq6DpBY6GF6XZZUrWNKVzeSiwI2Smvv4WqKmicKx15MvuFfOl3LQh+aNj4DS8Am0c2VVv9TClY7zJ9BCLviXiZaKe1FTt478QqGFlf9akIIw+r623toEbxutgQMuvjcUjJ1AUcoZBOCNA8iSueb2HQm70jUxRMSgrErbY3xTe6rh9F1epllueAYeQH/5BecnhsMSh8PsIrdd2O/DK3qux73qN9naN5uFVHTKVV6NmiFk6Qa74l19Xt2/gVj06wIJ4+ezICOceNzUC3c3sHz/zib5kC4FLEgtvDysmek5Of3fXDqY8c8EZkl73RxWIY8kZGx2NS0UQIIyiwobEpHzbj80ucSLAC0N1L6G8S0hn1HWkAOWfFuo+zLlhUQ41IyERkb4AW2ATF/yk4YwJH4XMBhvZvK4a2NSgCOFHSAp4y/sjnQnKOvFfi0wjlrGkxxQP/D+8rmuGBNF3NFGPfy0vP2KzSiW2L7k57+o94pmhS5UrW6XHNsi7dnl67TEe2ld4H/IdwTcsDDbpYwbupRDaGc3MHqV0amUP2q67w6WWSuMuYGYs1/pQz+p/MvB33+SSiyQhJSy0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(107886003)(8676002)(83380400001)(2616005)(66556008)(6506007)(30864003)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjUohdFC/7jlywMhxuSE4xi+i8LPe9+cGkdXUNxtDeTKyZ34Kzy46jCpCkkp?=
 =?us-ascii?Q?0Z6NnXlNw9h7JQw6Hg69DFFHFeBI0/XkyYMFLqN9qlXhc2aZdvBcIsThUDqb?=
 =?us-ascii?Q?/0VkadCb8bz3v9Nj//wA2Va3ZmoiGPYQ+YHBSlbO/my6Ka6HrPD5q6LtS/Ti?=
 =?us-ascii?Q?vnd9Vz6m/4dUO0DwTie04539Sf7fJl2mDNfn21729yvM6D5l/33ZSbORXhAz?=
 =?us-ascii?Q?oFDAnY5Y2TsxrM9MMAUA9Bhbhip/miP2wkJ6w+j9Y/R9hJ+BcRHfN7ZsmiBU?=
 =?us-ascii?Q?Wkh+KE7neCUqyuGXK9D7OUnv9NXL0IayKTJ3nYMSM2TWRMNaavcIGp+KJgf8?=
 =?us-ascii?Q?nHvNuXGgbt2RqU0hZ75dMpJm6vpIx0cXdv4ckweJWCVKjgHl4SrFKxGUiVRd?=
 =?us-ascii?Q?erfHQsvJh0CJvAvBU34mmch+ohhSScbilA3u1A9Lt0Hbw5YG9YjSKb0zg2Xd?=
 =?us-ascii?Q?InIO6XnkDiWymljw6ybrAshrXQ4nv5ie9fEYSblJjdxRnsc5wvG/faDS3glj?=
 =?us-ascii?Q?BedphzPQbVl0Gsob98a8q0biGN1iFQUG43zmaSrTxquvTIDxk0FpLztLh2bY?=
 =?us-ascii?Q?9Te0b0y7AHxJkv5kQ3Fe9sThX+eZoIJS+8TjiZFd8AD3Rb6GORGFel+0R+wq?=
 =?us-ascii?Q?Gb+mYzSgDZQolcycloHv/TuVNZWu1FWLLghWbJ3YdTAf4FEzOuRjCSx02JOW?=
 =?us-ascii?Q?Xes12cDjlpS6whXu5yVpLqdkSJizoBQRt2X/d6RVsslM42udGzoONVVZd8fz?=
 =?us-ascii?Q?C47C75aJ/nhUxAXk313C+KH++/mu0fduBU9Lw8qmOqtYN2nwCcvGf5v6aEtw?=
 =?us-ascii?Q?E7ybHQWLU6oPu8sbMGN3lIMcpScFl2s9dCVeJRnpZtQhjX2oWxk+0sM45vu9?=
 =?us-ascii?Q?gHrraCeMBf7mL/hDaLs5AwqdefGPNCGOhtGqrIMWnAkN3N89nzC5bcIlBl74?=
 =?us-ascii?Q?tDmBUFaPxNnzvNEMYhTSHw9nIA4s67OHZVsEJE4u0f/a/LU8oT5SHR/4pKVu?=
 =?us-ascii?Q?/vy4N+GEawi1MuvYcVqVLsbBQGqo/cNaMOVuKRDO18lNW8ivOymYFFpTkik1?=
 =?us-ascii?Q?9TVnXt1/4whPXsyFYDdZ+K2gEM9Npk2iOVMKe//HCYli2174Fw9ua3YphldO?=
 =?us-ascii?Q?FlgzTk1XVTR3CbyEFJY8Mioj9+Y6kdW5FeOODcAduOcdLzQ17PU9jiamPl0y?=
 =?us-ascii?Q?aVLy35bXOaWAw9NUjyF8m/leoWDZeh0qvGoKXdapE8Yaddw+h7E6yDm6KwA+?=
 =?us-ascii?Q?JkwNokHgi5adYbsRwUO6kpihx0EeojXxePQeioeTBSY1lLibjO+I/p4xheuJ?=
 =?us-ascii?Q?0dKk/yXmAEP7zr1jjE7siHaBGpzpHgBpa+e2Ht+h7dOkBw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb220e4-cfe7-442e-68f6-08d9432887f2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:26:00.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2pzUFIWssgXHJvSW6qltbBWgwiH1TgNNJ7mpowtH7pw+xVVlH9GOAoAORX2VIxlFTLZejC3xdZ4eKX99XzPNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090114
X-Proofpoint-GUID: AsBwtSEFXTwMAgnbcdX0aiGtIM5fssCx
X-Proofpoint-ORIG-GUID: AsBwtSEFXTwMAgnbcdX0aiGtIM5fssCx
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

I'm not sure how to reduce this.  A simple scheme to reduce this might
involve making the table sparse (pairs of symbol index/size), and recording
explicit sizes only for those symbols that are not immediately followed by a
subsequent symbol: but I have no real idea how effective this would be yet.

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
index 8100bb477d86..8b5d1a7f6d9e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -579,7 +579,8 @@ struct module *find_module(const char *name);
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -756,8 +757,8 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
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
index ac095691008a..e72d4eacab07 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -33,6 +33,7 @@
  */
 extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
+extern const unsigned long kallsyms_sizes[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -254,12 +255,24 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
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
@@ -280,36 +293,17 @@ static unsigned long get_symbol_pos(unsigned long addr,
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
@@ -569,6 +563,7 @@ struct kallsym_iter {
 	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	unsigned long size;
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
@@ -603,7 +598,7 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
-				     &iter->exported);
+				     &iter->size, &iter->exported);
 	iter->builtin_module_names = NULL;
 
 	if (ret < 0) {
@@ -677,6 +672,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms
 	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
+	iter->size = kallsyms_sizes[iter->pos];
 	iter->type = kallsyms_get_symbol_type(off);
 
 	iter->module_name[0] = '\0';
@@ -793,12 +789,14 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
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
@@ -818,15 +816,15 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
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
@@ -837,8 +835,8 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 				size_t i = *(char *)(iter->builtin_module_names + 1);
 				const char *walk = iter->builtin_module_names + 2;
 
-				seq_printf(m, "%px %c %s\t[%s]", value,
-					   type, iter->name, walk);
+				seq_printf(m, "%px %lx %c %s\t[%s]", value,
+					   size, type, iter->name, walk);
 
                                 while (--i > 0) {
 					walk += strlen(walk) + 1;
@@ -850,7 +848,13 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
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
index 927d46cb8eb9..0229d91241d1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4332,7 +4332,8 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported)
 {
 	struct module *mod;
 
@@ -4351,6 +4352,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
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
index 00ad1b4b0055..85a2754fdb6a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -288,7 +288,12 @@ kallsyms()
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
2.32.0.255.gd9b1d14a2a

