Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E85C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285426112E
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhJ0RuJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11382 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243382AbhJ0RuE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGaHaF023023;
        Wed, 27 Oct 2021 17:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=axCflIaQpBiR5n37f0OIGDKdrcVlQDow+1QQxu5MO9BOuiNESPTV+mQYWSgpGfQeXSTN
 ZzhfN5OMVz0islkJrkcPI2AifoWj1jLfN9rIWvRxZVNIeaBzsb0UMF4vACXWCKyOMIGT
 fladmJXcNs+r0ucuu0adVgUhUk1S8aIRpAzALPBYkfj86qo5FhKqpSqjnhTomRzE1gFS
 RjIhKhlIjvnHPYSgbsPTiG2k1quuIsGWn9VN3m4691BqOdKtE9ZtWIxEE9oRs64449WZ
 xm9yGpeXMFrowYd2LDhaUVKqUoNNJWstF7lv1IHYL6227p5MGbO3jrjQM6AO9jsztnNV tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4g1baqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHg13o049457;
        Wed, 27 Oct 2021 17:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3bx4h2ruat-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxtpPiRWRZ2UDOXc56RER0Gnte+UuytmRTfQQc+ydSjB9kIsJ492KQ+kOUMGfSAym6FDR6OFg+wSP3by8mLphVTqOIKbZ1FOaYBKMjg3l5QjNYkCXBAaV/AvEPUCv3akBm5CAEsCbK/6cZEeNiNRc+42Q2D4bb/pavUEZW5x2oLvs/8SE1KQDjxW5lgvlN+fUM9K2LSK5+nXOJxbVv8Aqt5myBsGFtiNHyd2yDJSjub2AWfJ279K6mx06ugQQf7E4Wj5haAQqbI5TUApSvdjNabfAeQvj6p+sh6G9p0QhI4pDnEoFcqKMJL2qUJAoxxA4Gvl2CEBnuLlan2hICENFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=WmCHZSYlrXGzgq55yN7rzglfpm0/UKd+ZP4ehMAMFQ/V2YfiI/M+pmrUPM1Kd6PM0Wv5fj6IScQhH88LQh221OpCFAoGW17qAS7M+EKZzh71xwbYJZGqJmku1kWX45wXCmpAf+mW1Y3WDSZaM2A0H6NB0yfwPA8Ocja4bwfjIfw81a2fQG8hyiZvBnTMsDRQzfbyOVloxfHBzKSot/ja2SARv8Hw1n40IkbiVGjz+Tu+1bvliT//ve/CV1U7kUA569Gq1VNR4paEAtTdcMNtjV8pxfSHip90HcLhON1F0FRUmy2pTxksIETIQW7mozv6D59eQ23hZ4UNFS3UAMQ9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=imXFNIMX9ZbrMmJw6WhCvFix274uhJWk6YIJcbAVUhQa7WFP/GUIfEVccZLu90+nsoW4A1Y3zGIec6Y7gbxeIYzi3UgY+B2YtvIGJcSYPubjLoj2KtN3fTIxiKVnLfCzGnVgzZrp5aUSsj89W9Fp8omvDIatVEnd6jXEx3lB4XI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 17:47:32 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:32 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Wed, 27 Oct 2021 18:47:02 +0100
Message-Id: <20211027174706.31010-4-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1de9d8-23ba-490c-a1fd-08d99971da01
X-MS-TrafficTypeDiagnostic: SN6PR10MB2925:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2925D745D6C169FC3B9FFB628B859@SN6PR10MB2925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbIVGRhra8bLY/B+TQX91QjpyJtRpiwNOs0uAgl+BrR6aJIDMVc8Dc5OZkRn+6o3sgO/3ec2BbRNMbfgpKSJGRozSUbI5euGwQd7+nOPVbWbghlGZp9HJjNq8njAwOyumea3lb7lGu/Ia53k4lk12vjrYfbTv8pqd1lVaj4bhuVrqqlZhAzl+wJ37Ji8HsSbBbHw4MjHJvi6KKxJnNECu4U8YvEeY8gZcR4c1MjyOfZ/MRGv+ce4/+bxNaOauxKXQGUZxWW3LJmj2odLbIAw9PlAgroVt3rdFdnGaNt2Afv0tKyyLYxt3uX0JFldjh09GxUy0KAmDtIFISC7CiK1uuN5Amh/dws72JvHfo+fnVI48S4oo1JqZPBTS76hb/FTHsVs71ZxL1X3x3gbyQum4xUYdUcNzF7nD/3Ynph23qklE+bESM1l5FH7g/+lS1NAozxBh1+1c+DmCjhaS83K6TBJh18rrRQkjScV6V3l6byx2OPxAgEMRV0Jd0DnJrsPOTB5e0Ip0MpSP1oZwK1qhueFcg+KdYVghLgiEI7kcDtsppvIUgWi5GgNj1ydFSSPRIUDShm0sCSX1H0ox8dAXYWcDbcUHIlDA5qWIUVchIYkIMCvDqlnXztMjWHtzxWuOIQhm2oQSC2Ym/Wb/ik6rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(1076003)(186003)(66946007)(86362001)(44832011)(316002)(36756003)(38100700002)(52116002)(6512007)(107886003)(8936002)(83380400001)(6666004)(4326008)(6486002)(508600001)(6506007)(2906002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP5UgVGRowKJF9lfs9ptikJs8ZjoeqqIRO5OzKqeq65AtO1rVTz6+kqKcQPE?=
 =?us-ascii?Q?EVuNEPTAZuOtVIaz12IUPR2eTg4n+JbBo5gnaxgcHkbcr3Xy3G4Ck2iwkGV+?=
 =?us-ascii?Q?VFXtiVEVSYacZY9Ifn4yIEscbDb+6+HHPgNgMfORzfKV1hxG7StE09PMZVBd?=
 =?us-ascii?Q?2xwkN/9gWgHSDLE8/KEddh+FHOxyinaZJ3SvOJ4AF/8MKNYRxS1/t2sj5f9m?=
 =?us-ascii?Q?590Jo4H7b60av7bV1wm+ssBc5Zqf2pAITyLvewvfQX2vVbGwpZPtdU0zH2K5?=
 =?us-ascii?Q?pEDf8ymBW1huixaAJbUNxfsGLloBVb3/Yu3g6fF6aS+WZC2Aptbn4anPmukg?=
 =?us-ascii?Q?pxcicJZErvnD9Ejxd5R2Q+oiNp6NaOLhBu4YWn61h20g11BMqt3ctO33agxt?=
 =?us-ascii?Q?H0cDokXJccBISICW1PAwctMIcrBYVuI5nztCTWbZd80p8TA0m3w8SPq1rljX?=
 =?us-ascii?Q?vkwtstPednix0K9IdtRWzMMauDk1MdO/LOQ5rCEaPdR5ySFWud3aOT6sut9F?=
 =?us-ascii?Q?lp1oj8TGFoCgqVysqOYe/+4ZFbpJYdVsHOOkl90N2+2vq21CvGMd1Qg02dsa?=
 =?us-ascii?Q?UBGezBVTvtJbo1wHNrS/kcjiitegoOht3qgDAtkEbWl7613jIUqqzvv3SZKM?=
 =?us-ascii?Q?lW30GlYlfztMRfJUM4qgppMqFvclm7JnrafMohNnbmR6bTEe+Tb56/wbbQej?=
 =?us-ascii?Q?D9EgcQrs8xyvs60OVSBt/UnGKXrrLr7IbgYW3RoMChUB9hkbB218dMIvui7U?=
 =?us-ascii?Q?VUHhp+rBtr+ACAm/xwq1u09EF7q9Ylo16mUqthHlF9bW4Bb9H7/9Xr2vKLyG?=
 =?us-ascii?Q?xync7DabPB5WuWJE0LJMA+sGUx9ihVP3qC8iMe/KPgbNRVGUvADKH96KAdrq?=
 =?us-ascii?Q?8RnX8Uds0B7F7QmGHxQNfMjYFEjUiXyErNTQrqvtdQ06n7ikjxUuwT4Ta0L/?=
 =?us-ascii?Q?gjsEGbvWax8VCcbAlqEwOWID7/jKneAthmt5r9ljDoFrdZZp/zYab+NpOf3G?=
 =?us-ascii?Q?iBriKRvCzk5dudHleFb9v7avyAosEKwZkyCKD2l8xHaS1swFSgu36Nry4kYQ?=
 =?us-ascii?Q?Kua29uKUyMG7stDz2bp5sA+8eanKgfvfnDwzJYolYrZj7Ja8lOpqwRNtKGur?=
 =?us-ascii?Q?m1wPkHi9N4pAwSXMeSkwkw8wRPevZEA3dDM1fqyW1PVQ4YC/Ft8hh1YdrsPE?=
 =?us-ascii?Q?EcYKTUNUw+rcbFJrxKJ0yV3nMXDzdet8xn5gvhqbDcI7LB6s94Pe8SWVhG1L?=
 =?us-ascii?Q?dPa1BK6GZ6z85u5+AqcezDlPON9QwbENZnb5jN9yOsim7wsWjpen1RLECdX8?=
 =?us-ascii?Q?3ku2l58k8b0ca6+kVxGsDk4TquqbU5ntruqHJtEUGDlyvdXE7Km7sFN8RpC3?=
 =?us-ascii?Q?3n34I+kXrDZC+Sw5oGUo285MpYCT1j2VGxNv/NLQyCINpbCZbFlo0hhsxxqq?=
 =?us-ascii?Q?tLpvZ9t2i1LPMjSKo2fv+GYpxzmIy0EhC0CpB0JUCX0QzFIpRX2RnF/jggx2?=
 =?us-ascii?Q?ANb7R4GeseRIZhBCSCuX6UW6xmhiVXjEnyRrSEYL9tjBB/RAIxb9fadlPayU?=
 =?us-ascii?Q?Woobg0yCHAGSSieit5V4fkDdQ0z6eLHjnFp680HOTnr11ri1QNe/zSTDwQZW?=
 =?us-ascii?Q?087sNPMl5hFo5ivTxaJmog9CSOooJ8FZLwYD6MozqGye?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1de9d8-23ba-490c-a1fd-08d99971da01
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:31.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3b9mNxm1Cq74OTlMcZQ2mZbzbSrDbUDfLbS1yCM19k3seo86PFaDQyrZIGr4YI0vPC6BLQykHUK/X1OtZpIfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270099
X-Proofpoint-ORIG-GUID: BPDkYy5TwAffcdr3pLK0F5ebZJeqlhtO
X-Proofpoint-GUID: BPDkYy5TwAffcdr3pLK0F5ebZJeqlhtO
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This emits a new file, .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up,
e.g., in part:

0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
0x0000000000006000 0x5000 arch/x86/kernel/process.o
0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
[...]

In my simple tests this seems to work with clang too, but if I'm not
sure how stable the format of clang's linker mapfiles is: if it turns
out not to work in some versions, the mapfile-massaging awk script added
here might need some adjustment.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d74cee5c4326..a30075c14a25 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -196,7 +196,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		-Map=.tmp_vmlinux.map $@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -248,6 +248,19 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	${AWK} '
+	    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+	    /^Linker script and memory map/ { start = 1 }
+	    /^\.brk/ { exit(0) }
+	' .tmp_vmlinux.map | sort > .tmp_vmlinux.ranges
+
+	# get kallsyms options
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.33.0.256.gb827f06fa9

