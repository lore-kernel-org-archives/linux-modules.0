Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9DC433FE
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323D861053
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhKBSmg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:42:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21568 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235588AbhKBSmN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:42:13 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IIxCv018462;
        Tue, 2 Nov 2021 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=RBTaohJmfFU+h8NnEpwLZJWmdNqu/jINYLWInmPb1t0=;
 b=Uvf6T4hysdesTniH/VVqhB99V9s8ItzX1wYXAVQBxIu3Wvt3G5BJeLmEMPyDQ6Yq+5wQ
 rbEhZhVJoBSrVS9nY8gnxu4PxYhkGTCnCHcF5Gi/06PAm3kFDTP/IVkuKwd6Ha2ej2eK
 3HtZELpnECiXsP4R2CO+c44vNjph986VToKvo1+3Bh66ZknOeILcbCvDws+0c4mfoNSk
 4SaPXiMTaJZLNX1/CaP2PTuCc6fKYBZrYQw/aWrQgzkv/Jlezj0K8R1+DzV8kmH7mkGr
 zuwzyfmonGLsFgfxbT5Wzttkh3/UbZOJKSghKU4r3n1fc2A7qWm13bh2YzlrkyYqKZst +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c28gn960q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IKHPm109736;
        Tue, 2 Nov 2021 18:39:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3c1khu1422-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB84uyCqQgDTkMhT/EKowTZEYTiIgLh4GlKB9y8qrbOiTEnOd7BJV9d8J3w6VQLhoEJnvvsjuV+jOuSYAJO6KAtqcqRhwfH/2Cgo+aMwzkpY7OTXPNRHKXxX/lUKi85xf+Jq4vPChuNPfUYId2SdyQ4cSy3N8kp6d3KAhtlaoLWF29lYDApbusCSsVDIh9HNG3bJxGIQS3uXIQYZS27BKmXPvfD4Tc8e2sTmHoJ84HrQLNOVGtdsepyQ+ykG0KcMds5K069qOZTGD4C7vtnsSaaq9TzpSY7VTbwhIzckjk/TchURhNE8i0W4AaDpFP9y0cJAL3U8Q/ApJTCUUx3cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBTaohJmfFU+h8NnEpwLZJWmdNqu/jINYLWInmPb1t0=;
 b=HR1pcl53Cd7C+r+IR/9Qu+wjcicznyC57IJmrwzyb+cw/67kF1PWmclHOOI0OUVXd1WTClaxt7bzssXh6rRWvPR6H33TXzjsdFGMPC0Exo54vzhPEXzUuht2V+SSP/nfMqysnR57ve7TAj//i8ESRj7FjR9C8V4ctxKYs9txCtDxlSH34eK+W1QmTRUBuWl4bd1Lt+wQ+aq4WU/RXylfcG8pMWnR1PY5NYi+Uf0BH5jYrPSipLitFmw7tuibQSVCe/mWpwKPrXKuwyq6sM0BB29Y6lnfSkb34OiTTxskVJAla6rVJzABP7rkwOwm9NdRrHLiskVvkxwepQ+AYH7nYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBTaohJmfFU+h8NnEpwLZJWmdNqu/jINYLWInmPb1t0=;
 b=B+cBh/rXgKe0wiGhbvPk7yyo+rk+FupEeI5/vnjruyRl1yq96vYBF8jTnMzJfxpuZWIGHi6q5IAixjtUMkaYm7uEDilE0/4TsQT/8F0bTHrvo5QPbcTzJncj+Z2/ihWQDf9XZC2Susex1xmdZpvnd7PKWZ5rWEukAzzHeCy4IYY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 18:39:24 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Tue,  2 Nov 2021 18:38:49 +0000
Message-Id: <20211102183851.168676-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa56c01-10b9-4081-f96a-08d99e3017d5
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB56799D46899D886E457A13D08B8B9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/GR0ueC+jFjiZdW7T7fupbXsKOkOzb1nVVupJ/wfvwJgGRFtyMQYwrdP400WE42v8qUKDMzZPZWJTrn9/pzq65eq3s3GAxkhhQ+ZbVURoihl+Nj6g9Ut2307w4wvd4nlKXo5OZoffi/RG8pHGxiXQ2n5gbs/+OQbhFl/RBP4OSYY4iv5f0vogYWs1FBJFECQAaQozNwxWKfWXv3pqG2KOjNYCOHVyLmlKWmJjgKQPkYjySzSXilEYPLVQ2ZG/uHdzp/hpMQIkbTTWFMJewDg70f1QJfCSmn6u/05IP2q0jpm3+WrQWRpfR1w94qq4hhENsf+Lahe9ka6OCKrlewAX2nHBXp2ZtP0QE7awWyUhOMVLpjmtBrADW/EcCRFZY9ESAUtGOYFqngQimkgKamkkUS3+EHnFP6yFmnTaw3qqH5zEznSjf3nZ5E+N310LTkH/NIaQe6CvS+EJqdP/J7O+NON0wcSxH2GCoy2Bz4Sn3L4f0p6EbKIvJwsTKgne60NFmJCmxRxNmPSmg5Q2B6d1BOUIH8p9mcxPvhOzKq9kpbwhOq/OwjyHrRcj0r4H4yZF1/8UOYRDgxISoDJ/OFnVZgzXYTbBj4mkq2WuHvIHKcppnq6j91ZcVPCTA28zvwW0Eh/SFiAUyJ6HJkdv7ifjouTIRe7Cb1QlS/0gYIYI3PmLiZpSA79YkxYq2Pih3EfmL5eojHxaUfOpxcmiqzGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6666004)(30864003)(8676002)(36756003)(86362001)(186003)(107886003)(316002)(6512007)(1076003)(5660300002)(52116002)(6486002)(38100700002)(4326008)(2906002)(8936002)(44832011)(66476007)(2616005)(66946007)(83380400001)(66556008)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YS/1kvpe3Fr6WO/hgU21yWKsr2aDFGMyhUSWG3MVVTEYFWuhslQr78EBFqZ7?=
 =?us-ascii?Q?6HfcOrqatnUcH/iCwW9nlf8R3y+3IiE3EavZucVUL11NV2af4AA0n24+jZlT?=
 =?us-ascii?Q?2GFdswjLjym5QqGpNYeYcc3/I4CE4EQVjMTPB0EbdubI29XEhRXp59BpefuL?=
 =?us-ascii?Q?XoisfZw+ygsL1XzNhOswzDuep7eZ8ziOl8wOS71lJQaytth6R+UVoLfi5lJD?=
 =?us-ascii?Q?CfqkNJP2ZF4mYpMHU2jwIFQJpzeQkfl2diwF663+BH3Rrcx6i6KiHSR/wnje?=
 =?us-ascii?Q?leIctDGm00p9LbSTsrfskYweUi5XQZGhrkBqAh+x4fUMBmtMPNnlqjr2o90a?=
 =?us-ascii?Q?2QKictwU4C9zfXH1UdZfRcQx8ongiaev9RBP02mUwMFGGPVu7u70mxZzq64u?=
 =?us-ascii?Q?0Ppb+02Hyn7PeFJXodb3mWylK2qXq/17nb7aaQX0VhV4bnNkCFdhrgQAX+iI?=
 =?us-ascii?Q?/pjIe5MU5Jd+HmrZLpy++VPLKTdWSIWOpmeJZzPOFbqrcgAdn5lZzujRMUU9?=
 =?us-ascii?Q?M2OT76rS14whde64DSZKvtt9p7rwB08vSfdZTjvxyy6n7hNL6Ktp+kPsl8Fy?=
 =?us-ascii?Q?Jj5Un+hKHR7im9LuIv0XJc0ILTpL9iqEj6s+SqnMBRIf3mKA7Tj2ko5vsgQw?=
 =?us-ascii?Q?dT7CFezA0uzgtBPrGQr4SAWgAc/PDchQ6j+oTqgBmZcdfSgkqbqrYi2GMH/k?=
 =?us-ascii?Q?R1l0Vp+PCEBbPKeRkEJw1CSilSH7eD1l+TtHHWU+8qcuMGvOZFXRgXMoyprS?=
 =?us-ascii?Q?S1VEO/vmd3piisXNg8DZWAzxJmd6Iuhw3YGbSVdhOqQufKVwc/IbqE4Cy0bz?=
 =?us-ascii?Q?OzK1DAbCA8WVxfolUCAS7hnj2krcxcxlZbDrtJy2UusWTBDEFJgt9u+bF3f0?=
 =?us-ascii?Q?1WKOzxNnfjAA6DfABZCpGybvAxE3Lu7iaunQyxEcrvxWkWOtkvYNCttotNmu?=
 =?us-ascii?Q?64iiYBlV2tpvgO95+bZ8KxMGbStAQ3pznsihFm4TGjtmzz4QwqGAZz56maUN?=
 =?us-ascii?Q?YYBdSzLKC5EWOplGXIiJqUE9KkQgNAjab5TaARDNaeQ7zLdRxGN/oxl0dqCb?=
 =?us-ascii?Q?eeMpbfns9tIK4eT4BevRHE597PmhdtrTMriG8Xlup+1MS4t91w1LlxoRkDcP?=
 =?us-ascii?Q?tacX+m3hocofxPdwtO6xP+FGOutVNwEZhFK0ZO9pIGiYMekzauidH+jwA7jH?=
 =?us-ascii?Q?lBFtaVhwSqOCHYkpQhygkQvx8i/waejBePt/QPKywdN7hhjT7KuYkgFNZfIZ?=
 =?us-ascii?Q?1LT0dLd1dbya549P3FsIne9StP7OHeu6pAdSjGUcfOip15kwsdiSP50s0WIK?=
 =?us-ascii?Q?NDY8O0Lay9sfdxRMI/KCfm+60T6dAIckF9QmDVHcA+loxZ3M/U0QndPxQtgf?=
 =?us-ascii?Q?9TwUyQAWm9tR7W37vdIdiNQfsnmYIRcEdHdD/Cn2Jcgllw97nWhMR4RQxLma?=
 =?us-ascii?Q?r840vc4YoczYmrTn8oZxzKYBMp0GtZuSu4AYSXxCWGv60s1UM9lqkTQNeWeS?=
 =?us-ascii?Q?tyZ/63LcaPbLn6b/l/Y39QdOng4E6snkgN3ug98xDthIFhuHzVrAgMnoys0X?=
 =?us-ascii?Q?RjBHA0rti5jLMvkiGg6C8YmuzQ5vtPbsO4UgPzd+2XoxhxCwZ1Ov4oiDCMMb?=
 =?us-ascii?Q?vUu6cCgRR/b1D+/3hxY/qje8/pxZzmXmZo/NDWSVsh5w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa56c01-10b9-4081-f96a-08d99e3017d5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:24.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q0RVJY/kRz2Y3u0UdGyjpUail0xEfHSwJ4NVSYpWKOQb+ZgcUG0t2Qf3CcbYKq77Zo8JHZmt1/1Wc+PWrWV1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-ORIG-GUID: hg27jMaoNLHKhtqI8g1DpU_3CzOTv8Pl
X-Proofpoint-GUID: hg27jMaoNLHKhtqI8g1DpU_3CzOTv8Pl
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit), the size impact of all of this on the final kernel is minimal:
in my testing, the kallsyms2.S file went from 14107772 to 14137245
bytes, a gain of 29743 bytes, or 0.16%: vmlinux gained 10824 bytes, a
gain of .017%, and the compressed vmlinux only 7552 bytes, a gain of
.08%: though the latter two values are very configuration-dependent,
they seem likely to scale roughly with the kernel they are part of.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/kallsyms.c | 267 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8f87b724d0fa..93fdf0dcf587 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -85,6 +85,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -94,14 +105,24 @@ struct obj2mod_elem {
 	size_t nmods;			/* number of modules in "mods" */
 	size_t mods_size;		/* size of all mods together */
 	int mod_offset;			/* offset in .kallsyms_module_names */
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -143,6 +164,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -156,8 +179,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * TU appears in multiple modules.  mod2obj for this entry will
+		 * be ignored from now on, except insofar as it is needed to
+		 * maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -177,6 +207,164 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+/*
+ * Used inside optimize_obj2mod to identify duplicate module entries.
+ */
+struct obj2mod_modhash_elem {
+	struct obj2mod_elem *elem;
+	unsigned int modhash;		/* hash value of this entry */
+};
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	const struct obj2mod_modhash_elem *el_a = a;
+	const struct obj2mod_modhash_elem *el_b = b;
+	if (el_a->modhash < el_b->modhash)
+		return -1;
+	else if (el_a->modhash > el_b->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all TUs in obj2mod which refer to the same module with a single
+ * obj2mod entry for emission, preferring to point into the module list in a
+ * multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_modhash_elem *uniq;
+	struct obj2mod_modhash_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_modhash_elem) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n].elem = elem;
+			uniq[n].modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort (uniq, num_objfiles, sizeof (struct obj2mod_modhash_elem),
+	       qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_module_names as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i].elem->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i].elem->mods;
+		for (j = uniq[i].elem->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i].elem;
+				assert (uniq[i].elem->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = &uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i].elem->nmods > 1)
+			continue;
+
+		if (uniq[i].elem->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			assert (last->elem->xref == NULL);
+			continue;
+		}
+		last = &uniq[i];
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -479,7 +667,7 @@ static void output_kallmodsyms_modules(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
 	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_module_names");
@@ -489,9 +677,15 @@ static void output_kallmodsyms_modules(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			if (elem->xref)
+				out_elem = elem->xref;
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -500,13 +694,13 @@ static void output_kallmodsyms_modules(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -533,6 +727,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -558,6 +759,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no object file: point at 0, the built-in
 		 * module.
@@ -568,13 +776,53 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module entry,
+		 * or from single- or multi-module entry to another multi-module
+		 * entry.  Single -> single and multi -> multi always points at
+		 * the start of the xref target, so its offset can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1)
+			mod_offset = elem->mod_offset;
+		else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert (j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
-		assert (elem->mod_offset != 0);
+		assert (mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1093,6 +1341,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_thick_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.33.1.257.g9e0974a4e8

