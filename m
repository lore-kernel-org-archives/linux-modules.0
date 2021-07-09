Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F1C07E99
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44A2613E4
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGIW2p (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:28:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65102 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhGIW2o (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKgmS022866;
        Fri, 9 Jul 2021 22:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=qG8DWyBPtqyJlrSuOKO2ryie51FpPVY5LDy0FZkGUuFL9NP20ZkPzJC1PM0zjRKwGaMz
 5Jfztl5EH+rWit53EZbB6RQ7vrHPlioskBKCk2Vo3YlaPhIAy1zTPZGQV+dMtvh4L248
 lpWYzF4nDck3lk31j6eoEHw6sytut2fIMV/E/hKd33slSxfqp7lNw4wBf4rjbCd9G8Ab
 eapgRcBCYaj+F4gOryO3XvzFw4/2xZgh4+oLXgAeRDWpSrs91Ox0X0Pbc0MFlEwZKLR6
 wiMJQ4L5JOkima8+sgeHGaWwshLK8pAmOc/lBP6goNTA1Mm87tEcM/RsTg5hU4Cusbkh og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgmh9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MKHWw057355;
        Fri, 9 Jul 2021 22:25:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 39jd1bypkq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxmtkAwfNMj7vPju9PvolRSllXEomT45fG1dR9JUD6vrVCLGgLS+BSCJ0Bz4OwmCMbv8j4UJrj5FkfEbst/sUOGjCAXc/5jerM2F9ZlBz3Z2BTdijk+2//AvrbXe4Ht72n2wAHAsgrH/VTQJ1w0wbF9NjVKjDThHKaa7zk2CXWYIwR1YTNM/7q9DK3VW2vqjLqGmqzWjBFgiEk7ieZERZ1HyiKIVpYV1Wy2i7bue1gofN4SIu2VkAQvDhB5FCdDE6ypt8KbhpgnJrgszUR0aM/JD18lU5PHa2VASnTxqpt+JKFOD722DSL3z/cly3mm8XAR1M5j74Vfah0JoK6/nzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=WCRhZL7jiMRUNtXOB0No1O8CSENdqQfmPEWr+YWgnQ2/A5+xtodTugUJU2SGhrAYfLMRm+HQJggCCfcwjTrJt8BNSOF5JIeCtI9JXk5u+uzuAYAGQnctvThrwX8NaEjlwEYkCpGcVEKrYrRCKUfndpPcpQi4IRV4/cFCAefZ7PLEg9JEYdxLeTaJ9g8VZnFOIMlzZ2eJuX6DpzknOuRT/VzVrolb8HSxRRp6eJQs82eqyR6yl8+7jCO1kBsvqqrVragqKu+oUBB7pfmHcZyb95hwK9GcXi/VFpfb4eGQeeXG4daE17v/UrzfwVjFxBmt+/KYfFeipB7Y3gae6teU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=APmKf0Ghn8hqAss/TCe43A/inlYw7qM2NO23/3yOXpj04pPERXarmZMxHhHglvkJBUlffCBCMnrm2/M3mTcHM3GRFrncl94A3YvFfbqHI66k89HzZ7RX75CS3daucVCNHSHfxVzUWMeJgN+tJghfeP2wb755MIqlQVY1W9h3S2g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:55 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:55 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Fri,  9 Jul 2021 23:25:19 +0100
Message-Id: <20210709222523.17639-4-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0dd7bfe-6e23-4462-0380-08d943288489
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2927B876B50F489377845A978B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +j7xrlU+wJktdnNzh8WN+ZDHVACKx2leed4oqvl9rfkVxuRACq0jts4fthq+Ks/GifrmuLY447Pkr9YdUHfx4jcSn2pJsWKET6NV0T90VzZt/Pk5AGFCvAGqK+PMc1idp1ryB5qcTwjOnDwgQ8iTlikqBpL0zIo2Bhpf0Prqf5mNFJhcWIdfuI2jp7OApvjPvlE/iCqwPfJj7OJGIxsomkDiWlaCcuNdI8O8NM2BTCtI0h4zMe+oLQvthNcs4K/D6pwBCXeWYjET9zChJpYIOJ2x3cVYN/XIjMlOaPigX2xhIM9MoAQXmlQVd6uiWldvPl98764NIuUZeiEbr4251z0sQZC1GWsN6ePJ4BHTmeXrGv5CgnEPILLpppMmK200ujwZxTuuajUKQoJxIhdNeE1cCvFwRr6FOYDSr/9yEuJCkdheKn+gtgsbwyCndEZOJTt0+K4BtT3nMlA/2MvaLRqNO+dDPnpvOYPnieGFpimlNH+IskVjo4DynbaqPgpXi0VD1+kAgqubFmKsai3JMswU73Rm2/Sk8gMNx2ijyYOINiqzmM7Z/yBTNZdjHf1Zih+Ks/rvhMZbip6SaIypmLKCjDcwK4MYSqA8wyGuGNsKtRGRUIU7AK7yFX9zClb0bPO3KCQPVsdgs+YcEwnDZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(8676002)(2616005)(66556008)(6506007)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dn97ybO+v8WplNRy4sItxdrMFyqgbWIGsKSrdpE0mPHYWPFjfObgWN5chqNp?=
 =?us-ascii?Q?wlvYElR74dw9TOhpNzds6WfKJEeN3muYt7kvPSvAzwliIn7DI9uVT0o7uRrP?=
 =?us-ascii?Q?n4Sns+fLh/FIh5IMqSfZRgxjRiHQ/Al203CkYfxl555gj1iWsgwpjlG1yh/F?=
 =?us-ascii?Q?yWsf61/u7SDyNUrCmtw2sQaPyvyDN+A1XIunVPogHOF2dMUtBvvQq63fS++b?=
 =?us-ascii?Q?/QybeZBjUn64TIvMGqqeZJWkbE2oxXO+hV8lVtOv4KQT+7XLgZ14BNNvYAbs?=
 =?us-ascii?Q?7zB37DVtcq3bnRVgSR4fGY5XHtK3nRGgF7A4MTBh5NlnNdTcpRg3Nzf1x5kr?=
 =?us-ascii?Q?AAW78tcl1/w//tZvuTgs6Q2DSf+fvidboLlSYjmJsgAhtAs4H24Uayh8b0wT?=
 =?us-ascii?Q?AXmq2Sgx4JZo5Sz8U00MhWajAGzgaLz8r5gIwwQ7HLvUScYSRDTYim2mIxgk?=
 =?us-ascii?Q?zmWKOGJwmRAP6nd1Hk9n4wR941Z6yXAkc60OiXvldxUuisEivYfXRSihQl/e?=
 =?us-ascii?Q?BvXGgtAfhrDGK2iSLAG9Ut2zUBPPT4WZY8TouzuGT4+1gdvxCY2ikYjYg5Bq?=
 =?us-ascii?Q?4AYDaqFPa7FrFl/yYboPpeUzIhjkrcyXsJ97MoWoXoWi5hgvLSO4Zel/0CIQ?=
 =?us-ascii?Q?kMG6BoAGU9N1+tA+NZ/BeqjHR4MDeNosobcDC8Rq+std+A++UznuQKHGDz/5?=
 =?us-ascii?Q?htPH4DXv7Z7cPfSyrM6fb/QgZ7edlf7NzV97jnqcBXdIyMiNwYR+vFpXQGDb?=
 =?us-ascii?Q?wHq0XPJuS3fzYyxrVOugydaNWNwoMfpfQiWygX1jgPpnHmM0UjeSH/72MZWm?=
 =?us-ascii?Q?isyaTf0d6DQlL9eU95cmaJoEN6mnt/lp00oIjiqnsNjrlUp5tPU6DhCWQ0lI?=
 =?us-ascii?Q?wKzp9Ujt2AplDXXF8muXBzJwxeMzUlrFnCrL/ST37Xx8iqjLuW+KCclB+GEj?=
 =?us-ascii?Q?0QxT6rRMQALUDPazl8rZFq+h+biH5E1DrzDxaxNcX+3ps1Go7iX8R/ngusip?=
 =?us-ascii?Q?cOVqoSQba9YKPRHrzE9rksMEEu0Y2kCRlh7Fvyd8rF2ZAd4YWy+0HkkS/fHX?=
 =?us-ascii?Q?mjq8PwbrPdY6PTnJIovoTtapR727yvWRudf3YjDryc7X0mu4ay+yaSrysqvL?=
 =?us-ascii?Q?tCQggI7Q2IL/eOE23mdON0fiqmbcNzWThZxEK2UP9qiDTcaQTXK9ULcu7xQ3?=
 =?us-ascii?Q?p5dc14qZ1ksKzmkCZ12FgLpYPZc1c4OeThTvpb001P0pG82eNh2ip8t+8Bw2?=
 =?us-ascii?Q?4GSJmYMQ6OiUVzfKeUUnGrEH4SCVQObzv7rYxs4KJ8Lh7azUuEil2rx+6Gi5?=
 =?us-ascii?Q?6M0R8lcW39USCH3IVeqHL1K2DpLxfZPyFe/Lhw4Ar4jQEg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dd7bfe-6e23-4462-0380-08d943288489
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:55.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbY0ToM8/QLecDoHAPRS+5kz61T5a/6LURacpZmwQcvHY6SB23oFPf1CtYQD9/bzvCMNkRySPG10e/8+nHIm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090113
X-Proofpoint-GUID: mFANp4f39TLmhK6UzlZnCnu2E_BjeLEe
X-Proofpoint-ORIG-GUID: mFANp4f39TLmhK6UzlZnCnu2E_BjeLEe
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
 scripts/link-vmlinux.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 0e0f6466b18d..00ad1b4b0055 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -178,6 +178,7 @@ vmlinux_link()
 			objects="--whole-archive		\
 				vmlinux.o 			\
 				--no-whole-archive		\
+				-Map=.tmp_vmlinux.map		\
 				${@}"
 		else
 			objects="--whole-archive		\
@@ -186,6 +187,7 @@ vmlinux_link()
 				--start-group			\
 				${KBUILD_VMLINUX_LIBS}		\
 				--end-group			\
+				-Map=.tmp_vmlinux.map		\
 				${@}"
 		fi
 
@@ -201,6 +203,7 @@ vmlinux_link()
 			-Wl,--start-group			\
 			${KBUILD_VMLINUX_LIBS}			\
 			-Wl,--end-group				\
+			-Wl,-Map=.tmp_vmlinux.map		\
 			${@}"
 
 		${CC} ${CFLAGS_vmlinux}				\
@@ -259,6 +262,19 @@ kallsyms()
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
2.32.0.255.gd9b1d14a2a

