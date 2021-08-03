Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327EFC4338F
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F45B60F70
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhHCRRI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58862 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237901AbhHCRQy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173H7Rau006788;
        Tue, 3 Aug 2021 17:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=ASsvXbEFuQwMvSL++qfiDVSUoCYDlT8U1kzhYRBY9sq9M57AhAwNLbnRpOSAB/J1EezB
 JLU2BjAqDaR+GhOGQDon4k98U6HILPJW0AK5vIsZN2ToTYLkeWYg+nI/Y3s1QZvf3df2
 Wvhc6Fgw9K1EcDjMnuIoSYLYguOWRl7cr5VY02aBRs1igjfRb7iw3PIvj22QH60p2WDO
 YN55KkaN6HRZzk3nWa2/dqkuzlGuXWmFdqr4WIXAliWr0owz0XE2623bFOb8S8aOx7a7
 1O3IKg+HYAFH2t5LLr+gC+aBAAdzqNX2x4UmUk9kh2LjsWrVXx9raUZVmAooJMI2P8FH nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=D+1m7xyWgd8FUGKJC9C7tfvtFMssniQSqGCQIPthKZ/dfxVzSTbeB3i7jCZx++pnsdZy
 /HJFYqKxUPQ+8u13GX7/Q9uBcL4MoGf8ZtyQQjLvjNr51emBCpYdX0AZ12tmT36xf+TI
 azHrI9bVfaFkxL6xMI55k2fDePHdvkWnff3jZqlianqKX+B5Zrc0kv5SZTskdSRcjvzQ
 PMKmfClyFQZQ1tHSavuhHgN1asYtLjrin442bjsolXhauTGlwq1ao7a0HGsitaZzFib7
 nHWhvc12YSUu34Kc6bnHflBoC17LA11OkzBE5h6c69xosZ0+lyo+ymocNvQ0ZKpWDpEr 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntm8r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4mY089331;
        Tue, 3 Aug 2021 17:16:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmkwUqr+vlVJAY+F+XKua5ytZ2qyILE7lf/nm8ATSoB1KYcOcVY34MjWP1e6mQ+uZoxBFHpJqGjdjebR2TWKpRzMHHIPJMToMsWR0lcrCHAydi/lBMKV8B64bV4hphhEhloYwSkxeZ705Dn88Eufzi7em1o4jrUn23TTG+g2T22XfZDcukJbVyBshCOuNTmnq8eAq3dXocQleE9jpIUn3yS8poXzz1dzzRbSOoRdWBEgTGDcL4NgA8EcZE5YtjcGxS5jrfM1YbYuQzaGSVlNFUQ4ZsB5d9a7shnYz+IOG2ZMDlYQFyuUicwdU6nTmf58/njv394eL92U3B40hqgf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=A+LkUJmC/oCGr/MFK4US2L381mquR8Y6js5dXTcO3/kvxk+x9+8tpiVoBlKHd3gGQAUBFtluGuVd4v04PUa/KCP8iPruySBEJXDZcuHNJiILL9eKZTiWk6Go2M6HWViRlS+umEe4jJ+TyvakExVErwM/olozTH+oN/A9bTNxKgrfK5i+PvbD+DjeklY65S36NjGXIvwgdoI8Z67McsdS49iW3P1eY4YR0IYbf8inUR0UqYmpU7zUiE+5xVcf3JdGCof2o06zu00sgxpjfHjko5KHSNYGzCd1BQdGTS/ZrCdYk/0fIVP8SAGPCYfzRH3CIIxq3GUe0i6zVQpztl3RwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=nHKImNGDzyW+HnTtOrLMf5Vwg5w+I95xqSoF4HlAFsMXVnyPT0MsBieS9p2sFKLbl1H8rncrITpzQV+nJkXiF5A+txiUZzfW92e4Flki/OLWVmG5Pq4x71LldKsD9FFJ/6lgdUdgwHHKO3+gKeg3KPVNVzE5zkKDX3qyFB2vZgk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:31 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:31 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Tue,  3 Aug 2021 18:16:06 +0100
Message-Id: <20210803171608.509163-6-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d1c57f-65e2-4123-9ba1-08d956a26ffc
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB4715C9E2F61A976E14B96C4B8BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Akv1hqHLMOdVWJ8Ew48MT2mouyTQtBOkzBrICQqM5XfdIPjCGcd7fZAgKgBBc1743xl2Cc6hGjasHAee+sf4NbqGmD0wdSWO1FYhfO5fkp2ujIlxiPHe/M7cGnRZa5bDsp34nm7Dk5IKypDr9DykhvdISF9RlYafu8eGd2f4FA2b4BGwfwcaAGZ833IFm0BAwR9pN/hN2flEMvsmmMdWOAWgMZsoRiM79+MM+Crg+EMREejEHY1995YIR/h6PEu+gzx4vCyyytGn5rxx5HyLDhsoh2f/Q6YHRqnFjGhMAFFVz+3xhpHBhzCPtlxfhvqiRqS0+VX+1YS3pzrDMXAoz3Q5kFd2M+u/9XJU/PEiclp3gHqlE2CVjBPk0jGRiWqWck1CN9sAn5+2uTS6Ju5Dh8IXB+bkQCl4YD0S5r902R1fqwWGWnsP/eUtGcZWSxRUoFD/uFmBrNfwBV1lPk1JNXrA2KDCVmvBy9PPh5FS7VxXs2k8X7HyDyAe2Yyygls2cVdDRKzb6A/UsKCdsljf+IoXjw6L1vnOVuGmpoQPbM4MB8Zigo6oOZn5PeQvrV6OcBW+joq80KzHWTnh2/GxmjLGZazMyiYCIew/IyDLR31Ggk8R82IzZmayC60LqADJTT6FSsO27WIrmXnH0iRKs4rZYG02g3qw3frodJcRpeuEzG6OhrsDIjYhX+ZN9vtAg7IZzAGdTAODmbVxqeHnTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(30864003)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wPwNPX8ZGH4FBZnclWXIaFWYCqKQGFkI+7Vpyk6BxKQIcNTdDbF8Z/GWP0hx?=
 =?us-ascii?Q?UG6r+vkHYR2aZJKjHbVHR6YNrQyjybwh7tnF15jyPv7gLkXbOd5D1ap1mRjC?=
 =?us-ascii?Q?oByM2XNFAgHGv2gLqgTaLtmFv1OE+Ik7N1Pdw1s9bcm7SGFlCaCLOsgdygXG?=
 =?us-ascii?Q?qovh+38Z/wH2O+ftBFXGDzt9yAAJOtPNyFYttTJj0OZ25L3I6n+H5KRP2JJf?=
 =?us-ascii?Q?agFz5I4FXDoNYYFsT/iOkEqAB9T5jr+TjhYFsZdo9ZH8AKfcP3KsmczeZYeP?=
 =?us-ascii?Q?mWCPWI+Eav7o2pzHX8AIgyJk/6UmdKEbP1eSTNXO7E9EOnBwlfSwBqVc4SfH?=
 =?us-ascii?Q?ek9eU65LM5DU6wvcUSfZJHmfetdn/4mrNcHlYoqzzFm+GBX9a1PVwg6OMFO3?=
 =?us-ascii?Q?JEOQJElGN8juqBZIq2gnfzEkhgjUY/uLcw/7A5ngl97BUqvWHofbbM8+z09k?=
 =?us-ascii?Q?BvX2O5DaxUvy11kcACcj6w7oRIgpYTVgkANGSGVKEAnWK37LfeQSeFrKrmwR?=
 =?us-ascii?Q?ZQrldGl0DWjWuiTHE+DlhCAbOk8SHRvuKB9Qy/pB8VL6mrOqVvWT9f/iWmTU?=
 =?us-ascii?Q?9R70eZGyRbCJvRlM59FTocv9WwB4TwzRtCTcJgTcFVssdcyevnHXaQWKDXkQ?=
 =?us-ascii?Q?M3/IU3ExxChxBtriBjme6Gb4Oj7o4EbQ50GxSiwzb8TY0nSDeIGPfeUR/fbz?=
 =?us-ascii?Q?JlyYhehzl9tJODl1ll4rmtoG+kzK6AVzfeRZ3aY4Pp2MuEdPGXCuJxAVtiSV?=
 =?us-ascii?Q?5mA+JDF4uMBPhZk6kIT06AcywTd5R36k+HYu6VuSqh2jrr3ifGHlEKlrV5ts?=
 =?us-ascii?Q?LCzu2Nrylf+OLLFyivmWvM9Gg6MtrESaAoThEVZnkZrpBLTUFNXVtcKpMiEq?=
 =?us-ascii?Q?FhvdMlQ6ID5oD3R/4JtzVL7rV7q27Se6iX76XZ1DJgJbO0iB2oKk8vyx+0uZ?=
 =?us-ascii?Q?/StQyPk+3y4lwyw1dh/DjrH/r/IsFKebpJkCto4O/HGZ5Ia4iqqTOWVwHM1M?=
 =?us-ascii?Q?vh6reuhUTOz0opLBvGVTHNoNZ0x2vTb7JiSvEwNunyu7kXBpxGEMHzHKxzaN?=
 =?us-ascii?Q?TOxPt7BGupWCcv7E/qQigLjuHdxQrDs5+ThJDRydjKwRFSUZvEZ6UckVivZO?=
 =?us-ascii?Q?KOSJlbqf7rDwDFVqZ+u7jJPYLLDMqXGqKoR0uP31xbT8eg5thSj+uU0sD8qO?=
 =?us-ascii?Q?O2kNoy8ijHyjlWmuYAvUNa4xOPv1qtSLmaH+E3jWzx/30bNx0My/Y+Qqknbm?=
 =?us-ascii?Q?tD8nqPPx4/+029WAPJeR+E0JqnlLZUMMlzoyd5XHAGX4yijBvGuO9aWx1CBj?=
 =?us-ascii?Q?aFtm+2ScMac7kf6LQ9ddyNsWw52tGbr9x0xuih3s23qt+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d1c57f-65e2-4123-9ba1-08d956a26ffc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:31.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnLpolkYtsoespSQy2J5w8cAtUlpSeb9Apa8lmlJJ4G3eRP7RbvlE7n0I8CleZrWkKQ8iom0kQgU3hl8cLkKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-ORIG-GUID: IeNZaa_rpf9XT7B3fhv3JV9Y5RCDfSBT
X-Proofpoint-GUID: IeNZaa_rpf9XT7B3fhv3JV9Y5RCDfSBT
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
2.32.0.255.gd9b1d14a2a

