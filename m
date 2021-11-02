Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D9C433F5
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7359460F90
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhKBSmB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:42:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51970 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235539AbhKBSmA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:42:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IJKNV011997;
        Tue, 2 Nov 2021 18:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=g//qlX6KXO2DZ6J7GvLQtzYHthyykBqhik1uL9cIW7w=;
 b=XAJoasQsbRTx0EL0iwqqulZw3Pw5ZfSFa30cemsXr4VZr2qZHXODnYmSa51xsUtFaTxD
 J3NKslB+UA0Kw2ksi3OeBEXJckIFWYpC86ZPv9mOVwyY0TPhxanTFGmysIDfDQesfkoB
 j675VFcfuUUGefPHT+mhJ/wBWfREyW3ncZ7g3eWAjDrlqKjou3xKw5/sQtreRY0rjU8u
 +6uzkifSyksBWa2qYbW29RG/j1pc7u+ibCFzIRIuiS7/50cTQSPEv2Sjjcf3NEHdpbQC
 TBFgiAn88ogHzIpbTLSxCIMXvilLCekXBMw175981m2sJb5YJ3G1SAqDXCgnYBo8rHVC mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c290h11ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2ILuEd176143;
        Tue, 2 Nov 2021 18:39:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3c0wv4su3c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBgh+rVRSIssXcUyhCj/8bmVL1QS/L9aFJXH+XBN33z4Vm6gE88UO2K9tuRzAb2EaAGG1ow54SFRdQCa9ptSH9Vu+JrnlVRA1PyzAEb7MwVxZGisltA/10EDsQFhceiuGFHD8Rfj1akeOrsBNoNesd5pVDjqMFQQ9rx0XW/EKHb8RIY9kUjrAkHWSKKmSMp2uZizHY69L1bvx7Qu356/VTo3zrC1rOVndEWRcEZkyOf6s7qj3kV42dQc9HwBi73ozMAq3bt6ZjEefRuPhLZAq0ziePtso6X8xxENHyjFOutiJrbItlKHgNBTxk+gDKJSXekOMzXiUblkTPHPftXGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g//qlX6KXO2DZ6J7GvLQtzYHthyykBqhik1uL9cIW7w=;
 b=Hre0V7uubH9Yrm5hdvpr/TiopUm1RKH2gzLUiScI/BsC1XCrM7SjmNjFwBfPOJ4gRHl83fGMpIsgSV9Qop30pYocoEnYhiPXBPhsSbiCaD8YW7H2lUl5UM2wSqoclatRTclmWpwbYm5QjNUb8wli41oWPkV5+NQvig7k6hbarSgxc485YOYDLXJlnDmV9pnhK+ubZ9uU/Rcnw3WXbPR6DZY1u+jIooZJJLNucZNk7uO462gJGnoiteJBmhCWyzEpPHl9sqVWDT2aoo2lz5m14vuAfqhSnZNtOm0B7JqsQbeyw1oAEs/+FMy7emIVXUXgIJ7H0O5jLZdXdhhBMlxzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g//qlX6KXO2DZ6J7GvLQtzYHthyykBqhik1uL9cIW7w=;
 b=tA6XGgi6a78DjR2sWivbPeL1kDE1kpHTKE6l2w28S5Gurt/1qx5jiNIU2ySXyoF9eHY+XZNbnqrNgUCulLIABbUtqEUIrDQir8nY0wAKPfVSA/iaZFwd/rYzxoU8WoaBkPVGgQ401pYk1g//FyC66pOTKPpNG76RQwO5ibeAE2Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 18:39:18 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 2/7] kbuild: add modules_thick.builtin
Date:   Tue,  2 Nov 2021 18:38:46 +0000
Message-Id: <20211102183851.168676-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 157e039e-16cd-49ca-2ef0-08d99e3013ee
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566BDD9E830F27CF3E9AA5E8B8B9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVMJ2sKjV3qqKRyUu3ON2nuJychxWoLMltX2JKdRQ7mg5FCZKMzpybN+lZviXlIviXUU4x5v3IFbX+EXcDUq8+TECf9JDivmg8RAa4FEwI8rECfVH+RsTS26egS/fpNk/w4fCRiOMnZVbMBC4JthRDyFrBe1nF3KlpkaTUiANweP+Q761ef6grPbl3VLQJAIjfZO/x01e1PpaIxvwh4mK59ear94UjsVEeU1iZopk3CgQTfO1G+ohdMi7fg081IOGK/agGyMtrqfEtb5z9lsoFLby/q8jXkjXqroeWZ8UJb6z4ZozeFm1N0h6loxCCCT/lRQoOTrGS/Lh2ZT9xuGthWkujRqxVjCQXAd46K2jAj/avTbl+AprPYO879HRT1riT+VIWeRxHpsjvN3nUDSY0px17YjCPhJGVuMdhwFrnVGJEeWjr+lzVCkvl0lPVeCaXaKWuiLlYTOuXbTWAE3Hsf8c0N5j3iUktxl7J8KdPLRNJ9bI+70scVqVMxZQ/3DeJg5xEnV/L+JTVUAptSPma6k+Ig2WcrnZlqfrM7yvXKjvXSlbKwPxxVDGQGIyxTFOV/BiRV/1e1cvqk2en6zUw5oX62bAiH431rmSNKQA/8MOAjkNq+mBPo+gPgbs7sM5oN563YQWNaAn9fz4xfb/wc6KTFo6LrBHY5fA/GWkSAqtawjK2/+teQc427i67Nd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(5660300002)(4326008)(66556008)(66946007)(86362001)(66476007)(6666004)(2906002)(36756003)(30864003)(6486002)(107886003)(186003)(52116002)(508600001)(38100700002)(1076003)(44832011)(8936002)(6512007)(316002)(83380400001)(8676002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tscpez729lYRTcMH17MUhVfBoP6WG++IAVuyUhuQG7S4C7xX1sFdBM6f0yyx?=
 =?us-ascii?Q?/JRV1TBgUnQn1gi0DhPxawDNrUV0OWIuLVHxZmylAMoWMvZ/j0/gdT+FSFak?=
 =?us-ascii?Q?szXksN2F0xeIRrwugcLaD7qRpO9tSGHWfqtcxoyrLIrjlV/CWBhz5FVAjWXz?=
 =?us-ascii?Q?Ib4INGzLXrYF8WKogccBsEyRvuFvNlllyWtUEOieS0cXQcGev5F5JlSAvkai?=
 =?us-ascii?Q?Oilsi/2O8gk0xrEXUFuAngv37hHJlVWv8rldn46XApiFTIdGBQ8v9StaNtJH?=
 =?us-ascii?Q?S0ld3go5eWI7UV5+iJiEKULSiqGWiAH7eHQHNOHOX9KzZ5XZDEuE+7hKEBsO?=
 =?us-ascii?Q?3dOZGod6Rdwl8GYAhZQAOx2Wdmv0PvFzJJ6GYWSDgu+E7LbwSzWvx0iMJ+FU?=
 =?us-ascii?Q?RoVjxnfQCTJOvU8is3OYU43WpG/QQP2RKvM4Leb/u0IJQmoen+1eWY/APMOU?=
 =?us-ascii?Q?jTRCaR/QlAGXF/wV7bV3f9bjzzL0/4OVJ/+D4fuyMOvSNwrUMvn+xI/bKRvn?=
 =?us-ascii?Q?1/CuKW+fWa8EuPCGvQkyG93DBvImQZ7+3t0/VuDXkeBXdhieYSsi01dmncgg?=
 =?us-ascii?Q?kqTNaRRJ61Ba4GkmdRFeBXEJwQKzOibamWx1HPYLwniUU2To3Z2t6zf53cvP?=
 =?us-ascii?Q?getbCMYLleSgMLnKNz+8qa29LFe+5ttv1e2dv3qlMJrfAde0kF9+H9mG/9TO?=
 =?us-ascii?Q?d380eLq0iUBIWWnNmVhVuula70/vcht7rPKgJk/nk7O8MUSWDZx4Gkpvquy+?=
 =?us-ascii?Q?MccjugpFN3YnJVN6hM+FNbU/HZl1IYKaZClBJnMGyoMpqOt4swF5CdCB/2WB?=
 =?us-ascii?Q?Siqym6rQ0WvFBmPGQRdZKTke7GE1M48GxDnp+d3acjCLjvhUJyhPXoYkyPV3?=
 =?us-ascii?Q?W1jY+LXiuTfUsnw4qh0D5MgkYLrag4I+4KUEkGCTjOBvlxauSCZhBP6oHD3K?=
 =?us-ascii?Q?HNePr1VrKLB/Ncwld44+kgrCkZ3i0mrnlfOhzzb8lGB2A+HpP2GeskMCFUEp?=
 =?us-ascii?Q?MlO684Uc2xwAS9TFZvap6qhwBnM6WvNovWcxnKQNjO0qXxVy5jKLOmJREIwR?=
 =?us-ascii?Q?9RI9mviK1g5a8lwoIHegRsJ8pynpOWqQ00nvVSXhVhBdEfVFK6iSqn09CcXs?=
 =?us-ascii?Q?9WVhPC4Ze2n5B7FrFynp69gpCqQh7Ja1nBtj+SlYHMBMwIanuBPymMLnvJL8?=
 =?us-ascii?Q?3PkmJdPi+Eb4HughVKXawUPap+rF81bKRPztyXEUJF7kASHO7Laxc6OOViRX?=
 =?us-ascii?Q?xiWErp/4qK0EcMTZJUagrW2ZwhgX2+cCnPW5PO2GCJaRI0l75eMrTDH6Vwra?=
 =?us-ascii?Q?BZPnQlsqHXy4zOo3k8ZNNgQMy3igggwXVw4+CcvQ5Siftvu5WBzBjeCz5jCk?=
 =?us-ascii?Q?/QCV4h12jA+BSqte4BM/qFbtbAzlR12tvq2klfB6gph0eDi2pQFyqL3iM8V9?=
 =?us-ascii?Q?tktTneFmXMnx70P8eLQ5gHvw4lffciiPbeH0YpcRep3zf24NUToSaNcdqxLT?=
 =?us-ascii?Q?iYFhF6kxmvH6i1NqnHfU2bcBt1dwMvqDuZJvUkFDWNI6SqftNu2qEgQ8C6k1?=
 =?us-ascii?Q?gql6/+p66GW/WurmNe7sPkbRUdLJwnHVMnFMxDTPVSJd8BjGMDrJRJQ6trhP?=
 =?us-ascii?Q?aoA0/kSFq1fatXhtNYqpu7V2NTbFB8ksvxZ2jV3/JBEL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157e039e-16cd-49ca-2ef0-08d99e3013ee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:18.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4fHlKvwXw25CTEhHzNynVkvxWfk2KoFsQL5QTS0dMR6WDoRwnvBZSHrftN4UO4vN8lUz7STlFb7u186K2VMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-GUID: 5besO5l-76sUVP2qpiOqb5tz3eIElq94
X-Proofpoint-ORIG-GUID: 5besO5l-76sUVP2qpiOqb5tz3eIElq94
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is similar to modules.builtin, and constructed in a similar way to
the way that used to be built before commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
and recursive concatenation up the tree. Unlike modules.builtin,
modules_thick.builtin givs the names of the object files that make up
modules that are comprised of more than one object file, using a syntax
similar to that of makefiles, e.g.:

crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
crypto/aead.o:
crypto/geniv.o:

(where the latter two are single-file modules).

An upcoming commit will use this mapping to populate /proc/kallmodsyms.

A parser is included that yields a stram of (module, objfile name[])
mappings: it's a bit baroque, but then parsing text files in C is quite
painful, and I'd rather put the complexity in here than in its callers.
The parser is not built in this commit, nor does it have any callers
yet; nor is any rule added that causes modules_thick.builtin to actually
be constructed.  (Again, see a later commit for that.)

I am not wedded to the approach used to construct this file, but I don't
see any other way to do it despite spending a week or so trying to tie
it into Kbuild without using a separate Makefile.modbuiltin: unlike the
names of builtin modules (which are also recorded in the source files
themseves via MODULE_*() macros) the mapping from object file name to
built-in module name is not recorded anywhere but in the makefiles
themselves, so we have to at least reparse them with something to
indicate the builtin-ness of each module (i.e., tristate.conf) if we are
to figure out which modules are built-in and which are not.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  19 +++-
 scripts/Kbuild.include      |   6 ++
 scripts/Makefile.modbuiltin |  56 ++++++++++
 scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
 scripts/modules_thick.h     |  48 +++++++++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..b49cd96f587a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..6a78988547d0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 1aed60793f47..aca770cadd80 100644
--- a/Makefile
+++ b/Makefile
@@ -1507,6 +1507,23 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
+
+modules_thick.builtin: $(modthickbuiltin-files)
+	$(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
+
+# tristate.conf is not included from this Makefile. Add it as a prerequisite
+# here to make it self-healing in case somebody accidentally removes it.
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1886,7 +1903,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cdec22088423..ef68635831b0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -74,6 +74,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif
-- 
2.33.1.257.g9e0974a4e8

