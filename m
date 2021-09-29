Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8385C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC5461368
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbhI2VyM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345966AbhI2VyG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TL3k4Q017456;
        Wed, 29 Sep 2021 21:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=EEmby9aSGAFbtYqKyZY9DV4+7+lirr0rPzorjzA2Ymuxr0/qrypTined+2wv8bxGap0l
 8C6Od1kZPU7EJSolMgEbtq/1twGm5XnUGCWf93zC4t8t6cWpqr5scBEopPR4pT1wUhNw
 4Yf5OLybuOrpg7Dd253oNfn/gOWEW7vzaHu5EZM5kYiZK+p3OZCtPG7SgLgffelvrM1H
 iI07NWbj9EPE2hwUrwgYiuivjTakNYsXNKE3akQqrDCuvdfSiQQsfO8lSb2NaY3VzE6m
 c7fp5PqVvN2s9H/qQwWcmlYnC2ZG61fOJTuCcmCqdw6QZUV1nA1XdlYa/k/T3nj9mgxj rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hrxbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLkCms128151;
        Wed, 29 Sep 2021 21:52:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3bc3cewskm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni4bYKKK023Rky8Wld2vEmcpW9AshoEYIrMz/sy0fjYDOYsAU4bF8rTB/4Wy9qTCW7t6Q8sIM0PHU8fuQVfeHl0gVY0vuop55mW1ZQuXt64oklqzbu8bL7n0IlyD86aEY+5/40H76HOUVVXG8+o9M/QsYV8IAJgtRICAgR4x+I3QVFX0m+71xaVz6h0mE2oL5tfR+1IvPailvQfnaeCtMnbh6GiPGNFJ4JHaaYyWpjdPL/OgxhRUHpyp/wEHCVfTfcLaXIiHD0Z+iPAm6kfWiPMzNsZEZdVHM3gV0E0c0qwt4FI5vK2eZYdAlvgnE+Zk07McgfSGOHYqmAvKROlIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=kQakQQvu4S8jvftWjy+LvNSLjbLofHh0yyD+11kz+HqTafqLigVHYZvAGg0HEjDG7kZ2u37AdMLPTB/FaYkNDVLHkTaswbHKrZxxBPasFrmVCFa5zjcNG8QXul+kR3bfTf3y9nFApUvDauyLFck74FL8TDMDHDA3yr0rAlCQqyQ7//5rKiKESOUyvYWOw5fWTa3S0rDhR47l+lnD8oY0xil8a2wI3pTpbdEz+i8tNHwPgzgBljAIFRczerSl63EeQGmsv+RZCMtNqqi0wrVmcTbKMU4XRBw8UKCGCl7n4OAwh9UgUbQt7ecNwgsIAFxwBMA3zDpN6Ydb5O5xGq0wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=OHz83cCovPPGL7v86tbhDToIKsIK4684ZZOBALTu/XH3yeG7PR8ngPukEu1PHR3wFFAgD3OVS+5nTpiwfrFtAavfSebnobJVpLK88lQELhM5P7y6n3MnB+/PVPIKMr54vukafx1pwEgWJ7nPVyvWc3Jia3ZlDfoqOOI24DCp0qs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 21:52:17 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:17 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 2/7] kbuild: add modules_thick.builtin
Date:   Wed, 29 Sep 2021 22:51:49 +0100
Message-Id: <20210929215154.300692-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a0b866-8e9a-461b-ab29-08d9839367db
X-MS-TrafficTypeDiagnostic: SN6PR10MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB3440552A1AC08911B2FAB9D48BA99@SN6PR10MB3440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsHyUmI02SlNrnGPBvIiNgrVg/VJxIO1JaGExRfaat3AuH1NomkGXO8RHCYkfMYiNePIZwg88IA6ngF84S2Teb5Rw2J8lU8H/3raOReg8j5GeGrT4f7zhVteVdYnDvMwzK9+Ba6io1JXYwGqAb+6jZPH0R+7Yw25ImC2vJN4g9InGX+gbulqgCHVw6b3j6rpiyWHT05rYp9mrzlNiOlT0ztZAoLwy9sX4Ft3Z6LbvsLcQwB2H2CoHsxYNO5slXZSXTVhD9q9xpJ005bAdlXnNJLmV17NYhxYTCQuDogFEy8bMaGEC9VafLrXcVOU+j3f9YwfFAnKgWKEsf6qtAwGbki5oLNkRLAVp4/zIAvyIceN8T+5MB9toeXkPKXMSqcwExKOpzk3l2m31DRXej9nLMpw/KBezREUTwPNKUoD24XLtj+DGjyKQkC4JhvQoboy6UKU6oA9m7Xz9agfrD9Arsn91mqc623am07+IQRtw+ahql+nzH4bxvNguSVkjhYheb2vvTtkN5q3zo3sNwsTaF/BYCYOe028ZoY9yyRfZwSDO6CxRRo1EFP5elAEG1VU2FQxGG764/9idaN2v2jXgHsWEp708SJqd203Xjg/96oZ5wkhLGec8Zo1MYUlMMOZVLX+fAbxZJcHYhsuSnR37/zk26MreX1jut91ussLaXG6/FN8kkqTkMIM0E75s4es
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(316002)(8936002)(30864003)(5660300002)(36756003)(8676002)(6512007)(2616005)(6486002)(38100700002)(508600001)(107886003)(66476007)(66556008)(6666004)(2906002)(186003)(83380400001)(86362001)(52116002)(44832011)(6506007)(66946007)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5EQ1B7kUu4FY9Afqt3LcBjsMyVhI15ZpSVHNe31Hn1OwWwWlXy6msXUD516?=
 =?us-ascii?Q?uoFkcoU+OxbZrj1vpvsroPkCUb/ARzv6SJqdv0xHBM4KYbpbcJ3kcU2Z4kZ+?=
 =?us-ascii?Q?lHRgeAtyrNV4mE7Yxp9WQJws7TcPrq+KzYnXXxtP1Lgedi1AHQGkCwYDZaGK?=
 =?us-ascii?Q?fXS817hLSGkYNtC0UMhFLuI5bxh9MYiEBgRnra2fpGK7R+wrcsUocaD7dK1W?=
 =?us-ascii?Q?u43Nz39yNbPSe82JWhCA8ExhvgoMR0XZFghyRv2uBOrtIo6tDBDa/gV6TKtB?=
 =?us-ascii?Q?a6mGoUuEQMf2IOBnRlxL/1wylKa/0bXEmdw4xAxpUcks6SskguhhOBDDuoum?=
 =?us-ascii?Q?6QakQ1sCukeCSuKxJBYDJGtjvQlc4eiwEEc92alZCT0vnGbHR7rJnx5aPI+6?=
 =?us-ascii?Q?SHHVcKprY9kJ6HhFniC1K7yKwen8sE8b9/iMALazwP6ZP9Z4Pt2zy16OzED+?=
 =?us-ascii?Q?nlFwnVPUJ5EGofrSlPfWXMJwc5xYyXdx1uJAG8imu53hnv9sJ1/vEZBgTeSi?=
 =?us-ascii?Q?VebDBfo3RPEgPR3rkdxyzCyz3bu1aPdA67gcCe6uX8Fkblr+2ypM4FLUcL58?=
 =?us-ascii?Q?/kFFLhfQ9CPiih1zDmu+Hj4yk0CSNCq9Hsf/tFwpxXCyM2mejBDl4GizTZFi?=
 =?us-ascii?Q?dOETyb7weHsMqXj4xdUzLxwO7uTssPglEHbQ0rMoNYmUFznbVl7JzJ81YOnr?=
 =?us-ascii?Q?i/YPXiztlmZ5QYdNqE1uiGOY8EExdlcqBeMb2T8lsrDJqT7m+H+MzJ+24IBH?=
 =?us-ascii?Q?I0C07VPx2LuaERsCQgypyEjHQnvLmtCRxIhnqZ7geOh5lDqfcOGADy8apxHK?=
 =?us-ascii?Q?qAyn7DDMp7+kzTtAJQni1ytnKCIk2C4jVTMWsln2848MCYxTiESAZby2STFY?=
 =?us-ascii?Q?crmKUwIySaRcMrHkext7tEhT5Yc7hKMVvrFAUoqrHMVAARwrJeBFHP3J4eFJ?=
 =?us-ascii?Q?lSxUDyewovEKL+VQA/PpM5AiuGYe6nmyNbshvmmFv/qOSeY2xoR6n8z3/+qY?=
 =?us-ascii?Q?Xfogbl8eYd8gXDV82ARdepmBV2BrzdPPwOuCg8bd+8jV4e4zGCfxqyiGDZIU?=
 =?us-ascii?Q?qowoWkuj+qrVV/NaKetfkDFCL1nHj/SrLus/jM9xVFykd8ET4MXjEJNVqoD0?=
 =?us-ascii?Q?sIKvYY5FjRnRVKcbp5nTB/F4Qm6s3J40TNgA58qfik0kiy8gnJ2XoKj2Yz8n?=
 =?us-ascii?Q?DYNF5AInAwSjnZveCIT+S5sA+VsF/48De1VNIzZ+klPkSDqdqJhUYEbYq/+G?=
 =?us-ascii?Q?MsvMwySMyfPVSTpU4YAzBtxLTPlYpIvAjbQntZ+wGENilb4P5wUweNbE1pqE?=
 =?us-ascii?Q?OvRgzWL+0ksPGj62P7yyHS/2x7ABYR2YdwgXWAhOY5iABg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a0b866-8e9a-461b-ab29-08d9839367db
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:17.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uc+xRPzpj2595SdniFr3ns0mErc6nC2FGjdIbUrqPKO864XzicL656o/3WX2DPDJS7++nNJx0VDmr7vcXRBmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290128
X-Proofpoint-GUID: YZ10lC2fV7OosbtZx6JTHuxaYWfyKhKZ
X-Proofpoint-ORIG-GUID: YZ10lC2fV7OosbtZx6JTHuxaYWfyKhKZ
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
index 77062b44a4b5..880b3e67a47f 100644
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
2.33.0.256.gb827f06fa9

