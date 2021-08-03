Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0436AC4320E
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DD560F9C
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhHCRRG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55758 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237938AbhHCRQw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173H7Snd006793;
        Tue, 3 Aug 2021 17:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=Ju+vObwU2yVAq+7AxsecwwDk105AdB5NzQGZL5Cs9tefGNaKqRIyvFyspxYG8sCkwD/j
 EmbYZ1PKb6xTlpHRDFsKZ/lxpdn+fAGOgIDAmYF+SwEYNLlZInkMpxRwERpKqDprC4j3
 9EnGwe7o+DH0td3OSFegbVUoyGz2hfum8MHEslHqDu3mvWOtufxQnhmNZcPYMGVQH2P+
 VSIeXJLl7oOr69jqLNLogxITC1z82g59yUBp7ZAogRclI0/pZbaN5/2qv6jBsrWnelQT
 R56XDdfZpF6pXRFIJ8Df2ks/7cHc1eQfVGgpOnhL2fzaj5d1qtCjXqG/p/9Av8phk374 AQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=awep4IXO9AeFWi3H6uWBNgv13eSOjQksqffo8wxaszkwsa5UvaLXrGkEX/2MQO2rwfKu
 OoNc4rDNtpMVlfgM8WH7PqxeFXRsj75Y5lqEKmxq6QL6SS4suBoYpcAo4Jg1VqkPi2Z/
 fAnw2kExa3MiEDO/5d8uq+ZJGk26wrzEUD5TZtAa4mEJN2NLjryFZSCIOpUFy1a3kKN3
 LTZMt65+9IYE+4MzWIwhQhpgc/aP2SjSkcfx+V7RG+fawJIzba2rwL3MVZpin0SAs623
 nDspKIT969cvE7q/0PdXnKNPaRAYaeDVfrSh/OGz5yS/uCtnSx7ErXEcBbZhtzmFCATr rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntm8r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4mV089331;
        Tue, 3 Aug 2021 17:16:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3hlKlhiNaA+kXwA+SzMaPgOeeBxyHMYSblumWz/IDmhsB9EAGVsqss4TqzMqpnVbWJe969pm0yqj3WIlY7g8iqz/PJNa0JQHzBhXJiG47TWAy8MCBEKiTiVhJivJob+R/9np3RNTTUT0oC/tKPrGkQumVjE2S4kPaFf95o+XCwbFZ9ZPpU6Qq2lIKmlQrI8g6r6ULqbTBSuVymDM69Xe6NjkPx6qO2cwaiz5iEV5q4n1xzGkJEHtF163jE3Z5KaVzkO7nhekjxYnaV80GGQzeRpT340o9WLEy3uzwmsjEfZMl6FXQIWRJeZVqKf+TxUL5aIxMdF4IoWeLYcC7oEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=Wx8Y4HPWxLH/2MVJhK4Q7QLuzZ9s6jYfgSrJyfLC/fo9oQeigL1vdyljYDYCKKBFm6eb2BpjdhEq48Z0sVyYDApvto+Zru4s1hyhavMEpoepd6kvgpJsyyMq89jPLYhk96GHcakyqCArpTq84XLSP8usZkT5TtMTR7hFgAtgyyB/LmSUECZPihXrJCfeyk7a0ahHw+goNRx+AU1MsY0UhK9q31SE2NdEG3oTPCvpa+jSlS7Yau/1Qrv32HkqW5X3EIlwbpDVGgJ+fd2uN2x8te5H3eQjvksi1KptugJbibcB1gT+JvfYLEspnREu4Qy4sM/8/xcemj0m5xyBBlC46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihhv38YYPVPYETSoje2STQy/1VMALYHlHaGOxM1tZc=;
 b=vrUv/JOL3Too0w4vHjNQ2BzJhbRWv+GNkkbDBXPlPZAkQPiyEBSMQWS4Im19RJuP9ZajH+2JNd2o9DdnpplElga18QIn4qo8DZCZjdLL+3KyHKGPZZoTV7eTFI52mvlh7kIXDmdsrvKW5YYmUUDOBbY0TvAg4XP/gOES0Zg9Yx8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:28 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:28 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Tue,  3 Aug 2021 18:16:04 +0100
Message-Id: <20210803171608.509163-4-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ccf9bf-4f64-4015-d520-08d956a26de0
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB47150DC3F6D5EEC98490361C8BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grsfBzRR+oZStfgdx2rvJ+cNdBxkfCs+brBHwlUeKU/07mqzjtJmVuD75ex8ZMEOf19EmMTbRTpTsalDG7qCwg3mGtXVcmMsnfJ6xgWtIjgrR8513taq1FFMlW8iUXUqKQ2jeXD7TO+PI+YhNTvHs7SahvdliCvftSXnItwkJR106b/4GZms9lMFEp4PxMy2qDSuRyIyHZQL+W2mv4swNQEUajWjs+oH6ixkq8s7CnNBbauHgsvS/Oc8haKAFiCOhVfR5Oww7ELkPQ2//RHqrpIQdGWRIUtft176tKv+VTCHTHB0fBQNALQ+yuqHBaeG8UcY4shdINPdETgGXOQqbiBPlLnR0vhbVBftuMVoccTpOzB3PFcfJuFvySKDL33IitV0i/kaiAWct82aHv7K0dyfvYD+4eWaJ0MnNQBpLZ9HVAewXOEcXSVIUJRi9Vz2lWWEpDMLDXmR057zabCNeYidkSLDLneEyv2qlyVcqUgFPo1ME4yW4zdUcXyDdMfqaxduWZoAxGzfsvXE8KoUWMw2idfkoH9hLUqsD9UPV/HSr3jnHyTSvO1xjk/s7Q1ZwI9dOc/3unKOxAeIU0bnCSVIdIG9p+MW8thJh4UpKblC5vlfHTnOVS7JsIDp2lq2aqo1w+89mrbkGPdufnSBZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(478600001)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/4pi8Gd9P4bqFG+IWyqrgyzXvKBpVic/o2WJfF+81ZbNECr0/wBAlhc+ruG?=
 =?us-ascii?Q?pwl/bZTu6ckJIMLS840HBt3RolLIghg3kbyIHmjeZM5ezYdjkt6f576Y2W8W?=
 =?us-ascii?Q?MN2sYNRIG4sBe1DLdAzw8ABVMMGUGff+JCLzwavU+Ac8HZ/gJKKQUxzoR14R?=
 =?us-ascii?Q?qhh68LtM0MKDKDZ7sVF5qlr5/118O+BmPWHUZhukboGwnVOQHVrNk81idmAq?=
 =?us-ascii?Q?TyDCGzneBd2CD9ezP0smvfUljoIYAvrPehnhRSl9nuV5bqjWEhJdaOYUEvOv?=
 =?us-ascii?Q?w8gvdXrGH5esC+uX+aGLrrDNLoELmNiQC+s8A/h9bckLfFkMU3xMlzTd3Mwt?=
 =?us-ascii?Q?4trcPdwPaYVyAK2LLYwMrWpm142ceNDcvF+zsZPJ7xa0ETl329PrNtCX+N02?=
 =?us-ascii?Q?89OdzzJy0+ebIpRJ13/qY4sZSGhNkzPXKM4nqSviarRjTJMVLM4TBI+fb0Q2?=
 =?us-ascii?Q?TpkOGi6sPMR1i9cnXKctQfgce4cui/t5sz6WGudakMV7FlhoyEPDOI5/AXkf?=
 =?us-ascii?Q?9mtIcp7cHXkMkm1VlZfhrsMNfUIFudgKBr/Cgsm3Qm3cjVooWLROi1Yh5ujw?=
 =?us-ascii?Q?0pSHjaO2firrYJtG9B4Wpx+M33MbYG5YUANjbKAZ3T2A9Zq0VKzzJUL/qxIM?=
 =?us-ascii?Q?kOQPk5zR7WklrkjrzsX0yPDBlX9OMz/1lAtwKwiBO2UtSmKTK+LYLEYysflC?=
 =?us-ascii?Q?wX9geKjN0/XHm4jYGlvbtz4y8tEEzFmo6A6afZ+2U/km3HtZUSmOD7145c59?=
 =?us-ascii?Q?YGMuPasINTWBAuh/y5l/359wXLsdObf07319CwHuSBbJuWsuDaCaNM1/NoJj?=
 =?us-ascii?Q?I2inrL3HUABo8T9fOXdTnlWhu1MrhO+yo7yI2N6hZ72Eaulhhqh/V5qT/3Jw?=
 =?us-ascii?Q?mRn4aSsTwleKpBZ6rTFdVPsLX5vsIrOkz/2ZLKO991a8kR0pwp+iTDRr6InH?=
 =?us-ascii?Q?uTxP6S4Ra4RTdGkKyu/4EwkO6bwAonBv+KZ3ZMDUNUijCehZ2kA+53p9MpzX?=
 =?us-ascii?Q?+V+Wk3W5h4+wNbspHZfjDQBQ6a0whKWcZ31Y+AfNlg8Uqna1woHDz7ngsJbS?=
 =?us-ascii?Q?93EkBJUbMGQRLG7aI4MtgomnHb7UIBrL0IzlCUyibl525+3Dl7MQBFHoW6ea?=
 =?us-ascii?Q?k2L6Jd8AyNSYOwNDHEwmvfOBup04yblESFP8BZOwGW/mcfDLQtVHnS4GCN5N?=
 =?us-ascii?Q?AI5dkiXPY2ts296/3Gk4axWleMQPQ+K232rPkoINmI+hyFgtYfMblVhueptj?=
 =?us-ascii?Q?KDnbgDsdAJ3k0bHyNBe1HgEJjjDrBZwKYJVq5GzMgooNxKxsude/fk3erz2i?=
 =?us-ascii?Q?znWAqLHiIpeVKBlLJZUoR2edVoXqvGiGhAMw/prsuBv0Vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ccf9bf-4f64-4015-d520-08d956a26de0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:27.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2arhANmFszkQf1nLn5PUPjKd/m2BQyHeN7E5dr7GOTRUjpMYOBIhx22hKJKNzskBS9DBJfp3ZcjD44sDIoKTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-ORIG-GUID: qBP32KnZwI-coCr0gryRCCgBc-Ml7j4F
X-Proofpoint-GUID: qBP32KnZwI-coCr0gryRCCgBc-Ml7j4F
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

