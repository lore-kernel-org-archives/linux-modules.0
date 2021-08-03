Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DFC4338F
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5772560F9C
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhHCRRD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237920AbhHCRQw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173H7S7e006798;
        Tue, 3 Aug 2021 17:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=fZtd+u9o+fUIUyqLsaMRoric7jKTXRsNmaF4bkC7hOajenvikhqfctMolRsZ9Wrb6WCm
 rMt5CI7JtyoJPar/f/Dn67/PFiE4A+bmkV5Cd2rm2M1xLfM7m8870DNaJvBvlLg9oAG4
 H/CJzwgfiysoVQNl2B0LYt6rcj48vGCBy/qyf2/VJqLw5dtNx0J5CGGXcAoqcB0Y/dpF
 Ba/M10eJmPWODcx7SIAle3PIS+JM05V+c8ZuG6bixvfzawHn4NYGX5bm1P7kMcdGLBrv
 WlPYdEVX4HKUcYJuiFAjKC+py6q4WnmZ8d701I4bZx1sI3dLui7z+qziytMP173ncL3D Ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=tl1RGufNUksQm3ruUvormfo0UvxaweznZMzUIy/4FYkhBCY08DzTBzWXwolcNw3lJJCJ
 989TZr8vgvfNvBY0fTuolytIsHpfeIIC+bwyG7uYJm8XxLjEk0c121BvlQw4RH0U+W5A
 3/HaNnQ9oMWvOu2szO0PT1KIpK8y7yIKWur4r8yj24sojJbd66orDdkowg7NHS2G5XcR
 2olO9g+1Vt8+I/4d+Nz9kZQBehnTVHMg+7kikxfYs9KozmBvVkGm4U4+okx0/bbYTan7
 KfXtSoGmQq1xsNWuV0OLzf3w1pt71KwqkCUDHx0g+ES5BkFvyen3sr7k2HJ5wmUJjUFy BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntm8r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4mT089331;
        Tue, 3 Aug 2021 17:16:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj9l7syucLen8p6oEkXG6yxTPdICYjpQuzdh1N9O9g/gza1kXu0vd9UtC2Sutq7vLFh6zviKGXwKZeYyAAwDc3Pc2TgXzS9KMEA94ev22AG2krA5a08Lu3AfrbCY0asoIIrwoGFVMiTh3NX+aBeaBT5NB1/WAiDe8s9qYGrcAQhNSv+e47pg4UbhQsdcBq6sCcKHtqNz0pPyw45c1BtA4VnOVF/3S48k+RpdFjsvjszQxh+rimmVQKkTPKHip/lx/f111EHrMp9AF1nIiSpEWyvOlwaTSV0iygvCGua+r6VkmBQAFz9XC2vps6yzC2L2ZTTgyoCyIaALVifXCnUFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=TViBS7000Jp2qMsaauOeVS3L1gYErX0tp22ubb3IqOQFjrxYZ+xP8irwkV+0P+Wp16Hi36qFwQeECVlBhcj3tAkaMUdWLjGUqLHZ2KgY3KSNWJdiGe+dNhPNKv7h4E4VcfVZa422u+mc4InhWdAldwOATwEs3WtPZzO/k6aivzh4BTutWi9K4fdrKO96RaPhq2aJMpKp36aFv1lBYEPXLXDNssEVxelTviW3CjSVc2hDjQTZch3l7s5kBXn26Gm8r2l7cPkPmY1wRdg3N/xuNpO5vyOsrL4BCY+F4uV6g0Ge5fBBVjvqZ8/qjo60d4HbY6J3J4VA4ZeO2VqXcsjb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=LW+4CBrvSuVzTLhmFnL63hCn8wnzShFwDjEVjQPeTSm/alqIMRMFFjKV+uFf9brtCl6QeOLwT3U0UweUT3Mov+9vdSfJ1zJ/UuSow9kLxsTYcnWTlZ6guNEkS+F8Fvnx9TUeAWfuI6sIhQjaL8Sfa+Vkndl/fWl0qkvK2fkvm+0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:26 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 2/7] kbuild: add modules_thick.builtin
Date:   Tue,  3 Aug 2021 18:16:03 +0100
Message-Id: <20210803171608.509163-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.32.0.255.gd9b1d14a2a
In-Reply-To: <20210803171608.509163-1-nick.alcock@oracle.com>
References: <20210803171608.509163-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce3d7c10-8b04-400e-7394-08d956a26cd5
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB4715D685CEF8C2E4722870418BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JfYYshKeoWMSH0Lt65lHXvt1QTya/b3wvbwv9mhmsA4ycqsOdksaxqOkYOpfzf3zufSqNtcJx+Eio5iPzyD6zEW+9UXYNIPQfWALwKxjzipYEc3eyYv8e5fCGZ0VygwbtzWNYbP6X1EbclhFhndG3uCQMXsMzUSAztEOCHvCu8EZ2ZT4V8RBL2CeiKe1I31we5YMqDdPaqys/tjr11B+pGvGqZ6GuupNO26OF8z6TQ8n+g/nNfF29GFHqx57A44C2eTvxt57J+nJRDKnEOhNiPJyJ+WHTjrum0vhHCStKtqJFHnu5CgjyCI1K/8RujcTjsGBoMXNR9GqRJL9geWsVtCaNxTRGSo/GG6B/PgTeL/3Kt6UhKuzYA00ZSaIqajbGsPPOrk4OiH8BeTOIUolU4iNvosQI0dO5Zj1c9R/1ZHcXD/GDf1N2USSm8fGp7jERv+CEn2bnejfhELn9ayjdCMGjvfaOxpqYBEInEVyfR9jlE/yMzIiux4As/Yjo6zsHn901iaR+f15jX6I7q2ndRDQjby+t1ZlSrnxuBHP/AFN68spaKfVTKAbuMGpSe27NJVe06PYBs8FHjBixbXGEPVuQCUf5dYRmI92o+Mf/mfbRNgrn5trSRnsLZ9z7aSZwPsw9WG7C1hb8ubL4UC8rVShicCW+ROqlspV5106KHKKdaD6ytuqGjNhEE1/I0h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(30864003)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFJyfdqW24QeE1nrr44f1B/86UmqDZHiRqNP3w/UzfFmWnx2qDWEGj22cthX?=
 =?us-ascii?Q?hnzM2tZFMmmbxuSHnUKyrxxL4BIrT99ohVzN/R4yJW6iu2D8InvMDIEE5ndC?=
 =?us-ascii?Q?0FLc9n8poD5+7CPYQ1uSu6TUHg54jyGMeQP6vVIafwhkXMKmz64MlB8+XrbP?=
 =?us-ascii?Q?YXc/PDsj5UwCRrNCZx4lKeSVLtoz2UyLrkKMeNV2zcr2iFVs/LJPBCA8UCLU?=
 =?us-ascii?Q?hwqmf/FqjPFg0hFUgOqpLGgtZ4l1MjE/ML245ZKdvUKEJsO6vWk8HO5I1122?=
 =?us-ascii?Q?mlDrLAZaXloDYkoXhEH/88SBzuxVuUTKih28ULCbS0WWVJgM0IdoU9/bNn+b?=
 =?us-ascii?Q?79/voELR2ERE1vPVpaNxiQ+iXIxilJKOFpjNBY12z7wlzYVPQKeQ/RLXH/tj?=
 =?us-ascii?Q?s13e8ahIyuB8C9hmPC7VvkuTIEItwUfOLk5Cf5lgxKI6mzDLYwg/qGwZDgvl?=
 =?us-ascii?Q?5M1x5tWNktsEIHYx8pVprnbe+4zoVcrMxWfzyPHREyIWa8yVgK+j9F3A/Jr5?=
 =?us-ascii?Q?1xutU7n4T6uDlCiJcLEcr/RwglKAORZCNtxWR4h/4oyluhAw/U+6FUqXFbOs?=
 =?us-ascii?Q?o3DNx4SF2Vbi2L6+/MV6atM5XtUCyUGcVNrwhnb++MTJVmhL2ytl+dxKHjya?=
 =?us-ascii?Q?MP8N531UlaC9Tf8RWs6au1Wj8zN9NnAYwjb6oXqh+Utir5/XnLYH349NvJDy?=
 =?us-ascii?Q?sWq5H0zZRh7GjXTMqA07Xb+buHdPCTAurrN0eB7rfzmBr3R6kfbzvRpQ+Ank?=
 =?us-ascii?Q?kVddsDAZZg+imOevWUWM53uDWOO1l/4ZuZRkD5t3hJ+ZWpNfd1IdckRtbB/x?=
 =?us-ascii?Q?9VT0G5zPiLin9k/FlxWYAW0nEjgm9yISORdrxZLmzov50tBu7xLN7tVjw6Xg?=
 =?us-ascii?Q?7iSlFqAXUlXVXFLhYCNvolp4qZmz6FVStREHAdZkdMgzl6jyA8klYlNuLJsw?=
 =?us-ascii?Q?MhGsrbJyqA8ep+L+nRZ0v4hdNLXZQ4wu7YtWvYeMsEs4gG6Dbkm5EIILf0Si?=
 =?us-ascii?Q?1KWGTF6wbWCrgZNZceXtVe2g8SwY0LEKThdTuXOiFZ5bMOvIXsI0HWhkJ6iI?=
 =?us-ascii?Q?i8ihOasHpxVmQhaJTv7bDD5GmVI/3OSkA8XukXeXkn26JyzZpiyZAKOvlm8E?=
 =?us-ascii?Q?CkdImtTa972iARE10GhzsTWIQzxijRa8mTQ6mrkEoJbuhRKR3q78sUFu/Onl?=
 =?us-ascii?Q?lksy2VSI7WVyXHp56FgDr8s3l4s0guywwlHrj+Z6x0JHQSv0UHlSuc7mbgK3?=
 =?us-ascii?Q?wuVPkD7mcYdwX8OEVdcvFJfF4JXj/0+TRLU1nbWxaHt5as7HfA9XumCmymBs?=
 =?us-ascii?Q?fSKFyA9fkzyCp7S6vtImSYviBhqGhoK58td9G1M43X+7FA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3d7c10-8b04-400e-7394-08d956a26cd5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:26.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0noklNTz85Xcc9YoJcO+KPDVPreMFIVTGa5pnNgJgHzrf09NcK5uKye4HDlhVDosM+Bhux7aT//i0MgPZyyx+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-ORIG-GUID: CBpscqIfNUbYJPYAttdW6T_c7T9-GiFa
X-Proofpoint-GUID: CBpscqIfNUbYJPYAttdW6T_c7T9-GiFa
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
index 0565caea0362..94933f01fd95 100644
--- a/Makefile
+++ b/Makefile
@@ -1496,6 +1496,23 @@ __modinst_pre:
 
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
@@ -1865,7 +1882,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 82dd1b65b7a8..b8cc96cd8a9d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -73,6 +73,12 @@ endef
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
2.32.0.255.gd9b1d14a2a

