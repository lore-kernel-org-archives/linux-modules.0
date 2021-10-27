Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB0C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE25610A0
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbhJ0RuN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243391AbhJ0RuI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGVFrK017554;
        Wed, 27 Oct 2021 17:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5aZJaUdVlRqLRMmExFcUz2pSHzaGMhQRM3UreJKADGI=;
 b=dwW7vqSV3Ry1ZLAYG8pBLsdDMHiUQqkcA/Ufj6M/+0fGdaKT0sQAOlRIfH5xvNNAHQcI
 3y4fKQxRvFPs3eXjcgv9Fgv+ArEZ4cPqExpoMqMjXYRfCv2EjjXcBfnMyZSAr/fUw2CK
 cv+3u4Ugoy1T8+7bBEf62AuIqW5CPnFYyXHQYjuVELLvS6OBUnrv54xfQUvn2pnoi7WO
 l2/rpy4m4Ls6CjSAoCA2F6DtAO4nr7xFly8znqnIBvFO2Bnjh+alIN9yWot2k2acG2cE
 6CSVY2f26fUA/cz63OMYhmyRokE3hGjl1n8/jmYWd1udcJKg8O/6EQI2gBJra2LwAqix 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fg3srp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHfvQB056661;
        Wed, 27 Oct 2021 17:47:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3bx4grfju7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0yNsyBWSQOebHjg3jeDH+iD3PPO5mVnLQcr+hNOXoQg/jSCLSUOfrooN6edRnvjezvihw5Ia12p8zmZuybqnnTwACTPC4SaF/+nJvttmt2cuty5sESzrV/H/5SdEAF+W5IJnEZDgqee6QvtZF4YS45WodcO3PTI9Xve1lZ6qcQbA8Xv94Rmym7fbn8wPVjDw7pFHymf2G/kCBNEj0dJjubLEkr04GeTDJfZjL8F/7uEkR6ulQKPrIccpinEVv5e3yj2zDOgARrD2JALqQyk7MXn7Bxc/7mfXrbKL5iF9cQL+L9hZvUM0W2gWmgAMfdYwee8JDWYxLJkkZmPdsXOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aZJaUdVlRqLRMmExFcUz2pSHzaGMhQRM3UreJKADGI=;
 b=D2vw7BcLOn7BAGlvdt+cJyleYOIfe7au1DDulFuuR/nznOC3PHnK1G2O/+gqawlJWClv2pDayXbWkXzrHWsNjLmd0ADikSznthCWEBHFHXthrhzxbOHMEAw9bLqwGrAoPUvqUeWBB0AmWXFANObAkbk1ojYogoUS9Q0w5djq4uVbqCaCPkxwT5rnVeopVQYvbFSBVLgUffq5ZygexszIDPLt2+QHHczQAR6KuTofTE1sWpV/xOQzp9uo1v1Klht10we6AzoGwR/oKdMcx/LLKX1l6TrOVAoVd0ezkKhAuoZ9iN6z19e93EP12n/7UmgpheZrNNwN3dAIHXnTm8POAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aZJaUdVlRqLRMmExFcUz2pSHzaGMhQRM3UreJKADGI=;
 b=Owhqh6fOlSrElidRMhPxrth1DQeU2VT1coTsyB5pwUd4JuDKVLFbtU4GVjR0ah4Pv5CNKTPdm7riI36QVS8xI11a22NnBZimQKYbiDx0qbELLNNQWQURUKZu72bWJYIQwepMPstDX4B58LuAXHLLZKSLcztCO1CyRJfRPbPqir0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 17:47:33 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 4/7] kallsyms: introduce sections needed to map symbols to built-in modules
Date:   Wed, 27 Oct 2021 18:47:03 +0100
Message-Id: <20211027174706.31010-5-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad1b90a-c9f8-4826-f978-08d99971dafd
X-MS-TrafficTypeDiagnostic: SN6PR10MB2925:
X-Microsoft-Antispam-PRVS: <SN6PR10MB29258814C318AA2D970D3B9B8B859@SN6PR10MB2925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwecPUALNNmM51qbslPfPIJaK62nH6t6q3lMoGsvGm/mjBL0vZ61YnYmfuJHHJfjegt18go5tg05/2kbL6ayDdwJo8q1pFz/aEaqWlJ1SMEMcDctnCyxgEkZuFFOTYEBFeYpRA7y7PmZkjxewSwi+QQTCwGKpAD5X+9djyhrgnjqK9VZdnfDT8Nqf2yyeinrk5B4Ubwtr15fCpNfP0yHNptbOKc0Ysqe2ahwfebEmnQ/WWgX6aqSOZlUOElKqFZwDdkObNEv88y4II27/LIxXaLbKrsrK6LsThfVa+IRTm3SWXOYP83YbrrYGIlmnvaXmOwMMHWX4Y1yWKmqhpXgSnNBw4dgH4qEkcVo5d3Bv4KI04sbqrBm5oG0gjgcnEQB6d7L+qjvYjB+pEmSJuSchQp24+AczaBqj4UhrIN7njpB68VpVYIKXqUhzOSR8kefnCWHrQ8iXdmvnhkE95UztbsngugHAnboRROVN54GqnNz83HP0YFtyOGUmXZQ7zOSXCQK0CMQcPUYHHuH+TuKSaowcMlPaXjzcdi8Almts/FbCGsTz3rUEhqTqxfLwnqP1sz7q1e3PSFwA0zo5DisFl1FwRnbLgv6n2cifQbKP3LbxTthjiS65r8E4t8ywTK90T9sEUH945ug1iNBfIqCEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(1076003)(186003)(66946007)(86362001)(44832011)(316002)(36756003)(38100700002)(52116002)(6512007)(107886003)(8936002)(83380400001)(6666004)(30864003)(4326008)(6486002)(508600001)(6506007)(2906002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdc1+WUBIwlbHk8t28zv3bzJAaUSgvQK4aT7Wiy2qVc4U6ssdK5ML1kPAoIm?=
 =?us-ascii?Q?DZCvBL+Mlly6yklm0QHPwzKs0p9is/WZND8Lt5pcf9kcw/BOtnhUTAxzqvMD?=
 =?us-ascii?Q?w9ahR/cWx7BkZBupWC08xvNdDdEs36v6cyuHC1S7qTsMLBG1ro9xw3cPxCeU?=
 =?us-ascii?Q?bEbNrgYObdaTT0mcF+EtvPr1G95/+RPdolsLrb2DKAzRO0mExesTZcvF4WMq?=
 =?us-ascii?Q?/E9YN1+6BeGuIIdPtR6PHLMF9ss1zCsIWCVRE5V+AfIGxDBdLR6ECNWNdRLy?=
 =?us-ascii?Q?x5Fg5jNPQkKin95y+0zya+inize1UEA1ulhGRSLXWVM2J66H90jZSHY5IPNI?=
 =?us-ascii?Q?eWvrcin14a3n1pnvqYXqBA+9PFIBBWPIIfmv2CKjnCYTIFoeP8Y5iZDDGOle?=
 =?us-ascii?Q?BjVYZeTeDJm4jw7dEBHhvWJwhR+r3AM56rRwldy34ir2PnDH7mbXMh1uxPmt?=
 =?us-ascii?Q?5YcIVbaFt8q0dPWma6M5Q4KUSeK2/9s7g3IZ30HABbBnvMyhuKeAja59yvF2?=
 =?us-ascii?Q?v4pyZEdik9h63SJieTjpW2ed6Lfo54nOCCyiKNC2mkNP4OYcV9C7mANXiL2q?=
 =?us-ascii?Q?FGlcmaCNOZgttWE8AmfadyoIJCS2WrBNvqiDbB9uJh+YCOiYg7ZocmJ43Xvk?=
 =?us-ascii?Q?BCuhOO65dIIAmOej0HbDkxUSEtYpmzxaMmpEywVQLM0bMcuod/Y20JH7wWsh?=
 =?us-ascii?Q?0NxmA4+ynoCV6vDwGQG6wafhxGOsqMus5Hahm+oZa14omtZLptpBQvsZSrYt?=
 =?us-ascii?Q?W+23+PGx0ezsRXmqclwc+Oa8uU0RMhRpmRa3lurdlKdo69L8g9aV1HbN5H7F?=
 =?us-ascii?Q?I2/u6dcM0q/JTPz/4wjgxUCs3Qvm50pNnhV3PC8ffuN28TpP1x4Vy3BdXcNk?=
 =?us-ascii?Q?BO5SJlBZAMgxgUh4eqL3NaTQc862oGwvMw9lhcepE5UHPtQcDxE2ykF5wU2h?=
 =?us-ascii?Q?aosEmqc4lGfsT/J8aoWZEUNqYe9Ddc30qDCpVyhxT3VoBGymWs6rfhv82czA?=
 =?us-ascii?Q?bLSb1fiWd6YXAN4DY/JchQ9k5uCD3BZ9D6uh4929zrsBZqfl/wiFoGLXYmiR?=
 =?us-ascii?Q?lsQShmjphoZYbc5todp1aaKQgaA8042As2gyR1HiFuS9Uo0LsfgxetMcp3i/?=
 =?us-ascii?Q?jnuTp5rLXWF/Xt2v4cvrerMO0JChO9PSkZQxG3e1xWSa8GLqBXf41xgXzgMe?=
 =?us-ascii?Q?jdef4NFkDyVP/dJa/1sEefzb6cKNhkLn5znfcvFUuFGsbZLSJaU9hNlLXOJn?=
 =?us-ascii?Q?zZA8mB78eiLykWrla6LrrOA6cCMwbRCpibMi3hnH5Q0Cip8dg1Ux1uH+Wp/m?=
 =?us-ascii?Q?TLAud9JMDA3B4ykGB/IdySRx1Yrn8twzegepkkAHN5M3U36Z/UCP6VNgJg0E?=
 =?us-ascii?Q?TDM9bfxsOCF0/AqSV4KOBcIV0aCIi+HvnQXppR5pE2kPmmQWhS0sDdDJXn49?=
 =?us-ascii?Q?MEJrawxG75jznnz6MuzndwYD///7yOsABJuvH7t3bwqiq6ZjylZaNV9OLJF3?=
 =?us-ascii?Q?YajTMk0Mkgnas4UKIBw8saiaCz2zs0nBdO+dXGLnYmi+xQSrAAs7UThGCZ+u?=
 =?us-ascii?Q?GRQtexP7LXxhcernXhxazzsTzX/cVGCF+acAcMnvy37VhldewwVY8Mn48yQ6?=
 =?us-ascii?Q?fCab9EZ3QlvHVmiNXP5nQYWENI+JS0OJssjCvphwZs/K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad1b90a-c9f8-4826-f978-08d99971dafd
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:33.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Kzde+ty+uPaQviiD6M7c81cQ3RdVhFSZjlxY6+275DbYm8B6Cvi+F+C9bwuA/WZtzIasfI70rBtxnQHPSfkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270099
X-Proofpoint-ORIG-GUID: Ycf8FG_eJEjE9ZkC7L2QdNC6vIVvlteW
X-Proofpoint-GUID: Ycf8FG_eJEjE9ZkC7L2QdNC6vIVvlteW
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The mapping consists of three new symbols, computed by integrating the
information in the (just-added) .tmp_vmlinux.ranges and
modules_thick.builtin: taken together, they map address ranges
(corresponding to object files on the input) to the names of zero or
more modules containing those address ranges.

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are assumed
   to tile the address space.  (This is slightly more space-efficient
   than using a size).  Non-text-section addresses are skipped: for now,
   all the users of this interface only need module/non-module
   information for instruction pointer addresses, not absolute-addressed
   symbols and the like.  This restriction can easily be lifted in
   future.  (Regarding the name: right now the entries correspond pretty
   closely to object files, so we could call the section
   kallsyms_objfiles or something, but the optimizer added in the next
   commit will change this.)

 - kallsyms_module_names encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  As a special case, the table starts with a single zero byte
   which does *not* represent the start of a multi-module list.

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).

There is no optimization yet: kallsyms_modules and
kallsyms_module_names will almost certainly contain many duplicate
entries, and kallsyms_module_{addresses,offsets} may contain
consecutive entries that point to the same place.  The size hit is
fairly substantial as a result, though still much less than a naive
implementation mapping each symbol to a module name would be: 50KiB or
so.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 Makefile           |   2 +-
 init/Kconfig       |   8 +
 scripts/Makefile   |   6 +
 scripts/kallsyms.c | 366 +++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 371 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 880b3e67a47f..572861a7d578 100644
--- a/Makefile
+++ b/Makefile
@@ -1179,7 +1179,7 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) modules_thick.builtin FORCE
 	+$(call if_changed_dep,link-vmlinux)
 
 targets := vmlinux
diff --git a/init/Kconfig b/init/Kconfig
index 11f8a845f259..613dec86f5eb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1526,6 +1526,14 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLMODSYMS
+	default y
+	bool "Enable support for /proc/kallmodsyms" if EXPERT
+	depends on KALLSYMS
+	help
+	  This option enables the /proc/kallmodsyms file, which maps symbols
+	  to addresses and their associated modules.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/Makefile b/scripts/Makefile
index 9adb6d247818..d677995d3f31 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -32,6 +32,12 @@ HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 HOSTLDLIBS_sorttable = -lpthread
 endif
 
+kallsyms-objs  := kallsyms.o
+
+ifdef CONFIG_KALLMODSYMS
+kallsyms-objs += modules_thick.o
+endif
+
 # The following programs are only built on demand
 hostprogs += unifdef
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 54ad86d13784..8f87b724d0fa 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,10 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: nm -n vmlinux
+ *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ *             [--base-relative] [--builtin=modules_thick.builtin]
+ *        > symbols.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -24,6 +27,10 @@
 #include <string.h>
 #include <ctype.h>
 #include <limits.h>
+#include <assert.h>
+#include "modules_thick.h"
+
+#include "../include/generated/autoconf.h"
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
@@ -67,11 +74,116 @@ static int token_profit[0x10000];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned int strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+#define OBJ2MOD_BITS 10
+#define OBJ2MOD_N (1 << OBJ2MOD_BITS)
+#define OBJ2MOD_MASK (OBJ2MOD_N - 1)
+struct obj2mod_elem {
+	char *obj;
+	char *mods;			/* sorted module name strtab */
+	size_t nmods;			/* number of modules in "mods" */
+	size_t mods_size;		/* size of all mods together */
+	int mod_offset;			/* offset in .kallsyms_module_names */
+	struct obj2mod_elem *obj2mod_next;
+};
+
+/*
+ * Map from object files to obj2mod entries (a unique mapping).
+ */
+
+static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static size_t num_objfiles;
+
+/*
+ * An ordered list of address ranges and the objfile that occupies that range.
+ */
+struct addrmap_entry {
+	unsigned long long addr;
+	struct obj2mod_elem *objfile;
+};
+static struct addrmap_entry *addrmap;
+static int addrmap_num, addrmap_alloced;
+
+static void obj2mod_init(void)
+{
+	memset(obj2mod, 0, sizeof(obj2mod));
+}
+
+static struct obj2mod_elem *obj2mod_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
+/*
+ * Note that a given object file is found in some module, interning it in the
+ * obj2mod hash.  Should not be called more than once for any given (module,
+ * object) pair.
+ */
+static void obj2mod_add(char *obj, char *mod)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	elem = obj2mod_get(obj);
+	if (!elem) {
+		elem = malloc(sizeof(struct obj2mod_elem));
+		if (!elem)
+			goto oom;
+		memset(elem, 0, sizeof(struct obj2mod_elem));
+		elem->obj = strdup(obj);
+		if (!elem->obj)
+			goto oom;
+		elem->mods = strdup(mod);
+		if (!elem->mods)
+			goto oom;
+
+		elem->obj2mod_next = obj2mod[i];
+		obj2mod[i] = elem;
+		num_objfiles++;
+	} else {
+		elem->mods = realloc(elem->mods, elem->mods_size +
+				     strlen(mod) + 1);
+		if (!elem->mods)
+			goto oom;
+		strcpy(elem->mods + elem->mods_size, mod);
+	}
+
+	elem->mods_size += strlen(mod) + 1;
+	elem->nmods++;
+	if (elem->nmods > 255) {
+		fprintf(stderr, "kallsyms: %s: too many modules associated with this object file\n",
+			obj);
+		exit(EXIT_FAILURE);
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+#endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
-			"[--base-relative] < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
+			"[--base-relative] [--builtin=modules_thick.builtin] "
+			"< nm_vmlinux.out > symbols.S\n");
 	exit(1);
 }
 
@@ -95,10 +207,16 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
+		"kallsyms_num_modules",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_module_offsets",
+		"kallsyms_module_addresses",
+		"kallsyms_modules",
+		"kallsyms_module_names",
+		"kallsyms_module_names_len",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
@@ -246,8 +364,8 @@ static struct sym_entry *read_symbol(FILE *in)
 	return sym;
 }
 
-static int symbol_in_range(const struct sym_entry *s,
-			   const struct addr_range *ranges, int entries)
+static int addr_in_range(unsigned long long addr,
+			 const struct addr_range *ranges, int entries)
 {
 	size_t i;
 	const struct addr_range *ar;
@@ -255,7 +373,7 @@ static int symbol_in_range(const struct sym_entry *s,
 	for (i = 0; i < entries; ++i) {
 		ar = &ranges[i];
 
-		if (s->addr >= ar->start && s->addr <= ar->end)
+		if (addr >= ar->start && addr <= ar->end)
 			return 1;
 	}
 
@@ -269,8 +387,8 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
-		if (symbol_in_range(s, text_ranges,
-				    ARRAY_SIZE(text_ranges)) == 0)
+		if (addr_in_range(s->addr, text_ranges,
+				  ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
 		/* Corner case.  Discard any symbols with the same value as
 		 * _etext _einittext; they can move between pass 1 and 2 when
@@ -352,6 +470,121 @@ static void output_address(unsigned long long addr)
 		printf("\tPTR\t_text - %#llx\n", _text - addr);
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/* Output the .kallmodsyms_modules symbol content. */
+static void output_kallmodsyms_modules(void)
+{
+	struct obj2mod_elem *elem;
+	size_t offset = 1;
+	size_t i;
+
+	/*
+	 * Traverse and emit, updating mod_offset accordingly.
+	 * Emit a single \0 at the start, to encode non-modular objfiles.
+	 */
+	output_label("kallsyms_module_names");
+	printf("\t.byte\t0\n");
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem;
+		     elem = elem->obj2mod_next) {
+			const char *onemod;
+			size_t i;
+
+			elem->mod_offset = offset;
+			onemod = elem->mods;
+
+			/*
+			 * Technically this is a waste of space: we could just
+			 * as well implement multimodule entries by pointing one
+			 * byte further back, to the trailing \0 of the previous
+			 * entry, but doing it this way makes it more obvious
+			 * when an entry is a multimodule entry.
+			 */
+			if (elem->nmods != 1) {
+				printf("\t.byte\t0\n");
+				printf("\t.byte\t%zi\n", elem->nmods);
+				offset += 2;
+			}
+
+			for (i = elem->nmods; i > 0; i--) {
+				printf("\t.asciz\t\"%s\"\n", onemod);
+				offset += strlen(onemod) + 1;
+				onemod += strlen(onemod) + 1;
+			}
+		}
+	}
+	printf("\n");
+	output_label("kallsyms_module_names_len");
+	printf("\t.long\t%zi\n", offset);
+}
+
+static void output_kallmodsyms_objfiles(void)
+{
+	size_t i = 0;
+	size_t emitted_offsets = 0;
+	size_t emitted_objfiles = 0;
+
+	if (base_relative)
+		output_label("kallsyms_module_offsets");
+	else
+		output_label("kallsyms_module_addresses");
+
+	for (i = 0; i < addrmap_num; i++) {
+		long long offset;
+		int overflow;
+
+		if (base_relative) {
+			if (!absolute_percpu) {
+				offset = addrmap[i].addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else {
+				offset = relative_base - addrmap[i].addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"objfile %s at address %#llx out of range in relative mode\n",
+					addrmap[i].objfile ? addrmap[i].objfile->obj :
+					"in always-built-in object", table[i]->addr);
+				exit(EXIT_FAILURE);
+			}
+			printf("\t.long\t0x%x\n", (int)offset);
+		} else
+			printf("\tPTR\t%#llx\n", addrmap[i].addr);
+		emitted_offsets++;
+	}
+
+	output_label("kallsyms_modules");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2mod_elem *elem = addrmap[i].objfile;
+		/*
+		 * Address range cites no object file: point at 0, the built-in
+		 * module.
+		 */
+		if (addrmap[i].objfile == NULL) {
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		/*
+		 * Zero offset is the initial \0, there to catch uninitialized
+		 * obj2mod entries, and is forbidden.
+		 */
+		assert (elem->mod_offset != 0);
+
+		printf("\t.long\t0x%x\n", elem->mod_offset);
+		emitted_objfiles++;
+	}
+
+	assert (emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_objfiles);
+	printf("\n");
+}
+#endif /* CONFIG_KALLMODSYMS */
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -451,6 +684,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+#ifdef CONFIG_KALLMODSYMS
+	output_kallmodsyms_modules();
+	output_kallmodsyms_objfiles();
+#endif
+
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
@@ -735,7 +973,7 @@ static void make_percpus_absolute(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
+		if (addr_in_range(table[i]->addr, &percpu_range, 1)) {
 			/*
 			 * Keep the 'A' override for percpu symbols to
 			 * ensure consistent behavior compared to older
@@ -762,17 +1000,124 @@ static void record_relative_base(void)
 		}
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/*
+ * Read the linker map.
+ */
+static void read_linker_map(void)
+{
+	unsigned long long addr, size;
+	char obj[PATH_MAX+1];
+	FILE *f = fopen(".tmp_vmlinux.ranges", "r");
+
+	if (!f) {
+		fprintf(stderr, "Cannot open '.tmp_vmlinux.ranges'.\n");
+		exit(1);
+	}
+
+	addrmap_num = 0;
+	addrmap_alloced = 4096;
+	addrmap = malloc(sizeof(*addrmap) * addrmap_alloced);
+	if (!addrmap)
+		goto oom;
+
+	/*
+	 * For each address range, add to addrmap the address and the objfile
+	 * entry to which the range maps.  Only add entries relating to text
+	 * ranges.  (We assume that the text ranges are tightly packed, because
+	 * in any reasonable object file format they will be, so we can ignore
+	 * the size.)
+	 *
+	 * Ranges that do not correspond to a built-in module, but to an
+	 * always-built-in object file, have no obj2mod_elem and point at NULL
+	 * instead.
+	 */
+
+	while (fscanf(f, "%llx %llx %s\n", &addr, &size, obj) == 3) {
+		struct obj2mod_elem *elem = obj2mod_get(obj);
+
+		if (addr == 0 || size == 0 ||
+		    !addr_in_range(addr, text_ranges, ARRAY_SIZE(text_ranges)))
+			continue;
+
+		if (addrmap_num >= addrmap_alloced) {
+			addrmap_alloced *= 2;
+			addrmap = realloc(addrmap,
+			    sizeof(*addrmap) * addrmap_alloced);
+			if (!addrmap)
+				goto oom;
+		}
+
+                addrmap[addrmap_num].addr = addr;
+                addrmap[addrmap_num].objfile = elem;
+		addrmap_num++;
+	}
+	fclose(f);
+	return;
+
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+
+/*
+ * Read "modules_thick.builtin" (the list of built-in modules).  Construct the
+ * obj2mod hash to track objfile -> module mappings.  Read ".tmp_vmlinux.ranges"
+ * (the linker map) and build addrmap[], which maps address ranges to built-in
+ * module names (using obj2mod).
+ */
+static void read_modules(const char *modules_builtin)
+{
+	struct modules_thick_iter *i;
+	char *module_name = NULL;
+	char **module_paths;
+
+	obj2mod_init();
+	/*
+	 * Iterate over all modules in modules_thick.builtin and add each.
+	 */
+	i = modules_thick_iter_new(modules_builtin);
+	if (i == NULL) {
+		fprintf(stderr, "Cannot iterate over builtin modules.\n");
+		exit(1);
+	}
+
+	while ((module_paths = modules_thick_iter_next(i, &module_name))) {
+		char **walk = module_paths;
+		while (*walk) {
+			obj2mod_add(*walk, module_name);
+			walk++;
+		}
+		free(module_paths);
+	}
+
+	free(module_name);
+	modules_thick_iter_free(i);
+
+	/*
+	 * Read linker map.
+	 */
+	read_linker_map();
+}
+#else
+static void read_modules(const char *unused) {}
+#endif /* CONFIG_KALLMODSYMS */
+
 int main(int argc, char **argv)
 {
+	const char *modules_builtin = "modules_thick.builtin";
+
 	if (argc >= 2) {
 		int i;
 		for (i = 1; i < argc; i++) {
-			if(strcmp(argv[i], "--all-symbols") == 0)
+			if (strcmp(argv[i], "--all-symbols") == 0)
 				all_symbols = 1;
 			else if (strcmp(argv[i], "--absolute-percpu") == 0)
 				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
+			else if (strncmp(argv[i], "--builtin=", 10) == 0)
+				modules_builtin = &argv[i][10];
 			else
 				usage();
 		}
@@ -780,6 +1125,7 @@ int main(int argc, char **argv)
 		usage();
 
 	read_map(stdin);
+	read_modules(modules_builtin);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
-- 
2.33.0.256.gb827f06fa9

