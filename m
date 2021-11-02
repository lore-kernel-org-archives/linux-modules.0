Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD97C433EF
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF09C61050
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhKBSmR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:42:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235556AbhKBSmC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:42:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IJ5GW007875;
        Tue, 2 Nov 2021 18:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=H70oT6lA2/SntRdJKr9LaVbbOnGznzUznGWKQdtKB4I=;
 b=cUeVJ8iJZLllHSK+lokda2mwr9ozcsPdVjHxM8svnt/ZA6BmVeAS8FaKDPRFDVKJhHyg
 yg1EpW88gwFzccyt4+Jo5bMYPee6httIUVkSdoh4MS/TzBg2nfOTkmhal/3qmSJ85uB0
 mN1mgCp+CCrN3YMNuISeCZWXfMvqIg9uwwpsWGAdxANbpVEiPuetHSnBxK6EtMoQhgK0
 5PSBN6GvkH0PGI4Z8oMN64Yxl3zVyB9qnLKt0zoJsy85ctyxKUrHUkkT7DQMekcT5B5X
 qJjXYNFekJBLxaF+3JiSkyO9RPdSawD/V4W+Smd8aJvr41/LVxO7tH/NnhhLNOr/MTqx Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8hebn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IKJmO109853;
        Tue, 2 Nov 2021 18:39:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3c1khu13vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNNi+JU2lONwmOvj9xntsxvpc31jud0gX2+bCHA+9moGa6xvjgr3DQbDRTK74oYODiT+Z7ufURO1ierkJaaLrXC1vHMX8IrTrf5jHE73Tn1wJq3vwcRa6ub+50jb/FgB6yK/QIAgmOIxmtpcf+vQopkubvqzd0/0v+Fz/4wLyNsawdDYW60Selm/LJg0Czc848u2d0aSEjJn4vaEzI2HkKIt5th0MlZpSxhkIyh2VcYSPOWGmcVMR95/oB+WBvMJAtrlvwKN9vf0EG2ZEjG7pP9CBIrJo3zEyRDft9oWKGOuE+ft1foykEuoddbQoDsBC+pyl/YGmoE1hFo+8lJBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H70oT6lA2/SntRdJKr9LaVbbOnGznzUznGWKQdtKB4I=;
 b=UR0dxd5MbLwcWNVZpZD8xFwSDQzvM+RkT63V2TMVKCx6EX+8mPPYgjW+y5aykTGoJcFUQpqkzBHyxEXiqnXBWfyVJPjgJr6Zpps+iM2kwlTw+eoqPsHiOdP/GTD+lBJAC2T1Z8TrdK2593vxEdc7T8DCbxVW2cBfeCIPCLs1C9Y2pdDiIJAK4r4h+IWWU/nX2ubUnSnX7pYKuskTJm/D7b6lXkJaXOnMQbclFbDUtRIyrP87vwulSDXnforzVUm43zjO5In8PPsH81gm+WQnnWlmMkPQ/UuUAf1kejkJyXbOxhn6B94TQFzClSR03YXSWclK0aIZkeBHNc4c0avspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H70oT6lA2/SntRdJKr9LaVbbOnGznzUznGWKQdtKB4I=;
 b=GR0bXeW5vzMKBGfMJKEKm7pu3nUtbGFOMcWvYihO+Ya7lyMF6Lyjx5dqreYXt/KwaL7VSpNE8fCZqjXzryIbzy/7RfoQXnDLy4J6sQKUubAG3I8whAFyD/+fvjXJgDsdnLOCJ/KrMlQcLmgQ/284njStBf1Gjbz1NaDUwh8U31U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 18:39:20 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:20 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Tue,  2 Nov 2021 18:38:47 +0000
Message-Id: <20211102183851.168676-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20dc8d6d-fc73-4990-b90c-08d99e301529
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR10MB156640281F8E8908C913327B8B8B9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCK74jg9Xm2lRbSzuaEFNXizn0yvV+QSqpWa7/w4D6KwOQhW8lcUR/t+u3+YlS+fiHb3fuSIeeyL2mQtXHe3wZOC1ng+5ffieVzSK4eHOpQTZPHD9UVnor0uqGe30gU8t0Z8Q0+S5gs1DzIrZTq0gjujANoZuzC9V89ESNMfXxeEx3gDxVxh/ynZZjOGaAltwOTCNbA7MxSYv3dwVskqrY1eBpn7+qbjFPa4zpZmPcTVhwECnDhmByyrVTB12mp0nPXl//Agi/gEgMjkbSW8j7Y4t7shAl0NaTH+qs0p+yTJXD/xrEqTO4gzSJNmiekmodyjyQYr1nB9VngCKBjVpAXTC0PhuNCjIs1kcXziDWXLzsTPi+foO08i3to7wGglZuPuCsJn76Mq9MnITE7VEYNYNjds0eCpS/QU3CXAwLQi6L1beJAPQSFsmJj2SBZQQzLHG+TC77b/0aOW0yTOkZtaFamMUVdHyAk1tuVr+jIDsdGJWO8yj3e6BX8eTjOnhhh+6LQlGr1dXr8PVDWbYvys5U/jRWQKUJ4FickcPxLh5cXLJ/Qr6eHPYlhE7BUsscwd15TuZSNwXqAqKNjgHRxskkI5F8QL0toiCYM+XFXoYKTvF/zWqN3rXHDk8TXj5ybZDGgc5OxEvTGeQd/hHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(5660300002)(4326008)(66556008)(66946007)(86362001)(66476007)(6666004)(2906002)(36756003)(6486002)(107886003)(186003)(52116002)(508600001)(38100700002)(1076003)(44832011)(8936002)(6512007)(316002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEKKfkof1nCP0ZMOS+SRppWQOK84ADvQCuXnIK6Y5A/Erla6uZjGWBd+j/Nf?=
 =?us-ascii?Q?9JiKCgU1+LJD2c9TOm8Sea9GpEvfo+0OuCZcLbjAv+DPYG1Gm3mSarjgawC0?=
 =?us-ascii?Q?IHjUWIH65Z67X/8uTS5mBFv7ZEXhxxXdm4E5t6r1Tyq5T+eiAtZOm9oVb7Io?=
 =?us-ascii?Q?fu5/i1MVJKc6wRvQFtuINxVbHLZOzgLwUjLRrZ8cP4pELgGF1MBdJFFPIGnN?=
 =?us-ascii?Q?35njCJvK/WYo6zwgVWRwR1ppgXq5cszWRrv4xyfDjicKPpYXBlx5mdxAjdoH?=
 =?us-ascii?Q?QdbX0W0RtuUjOnVoiem/hRb5t9DT+PUKmOeSt6CuHPLn901xrYfreiDQqmd8?=
 =?us-ascii?Q?hhiGn/FMYImwXjKvUtIsOMuOvln9zGmqpRzL0qQNEj7etFeeUUUu1ff46BPW?=
 =?us-ascii?Q?HozH7oGqQYc0kSWjdDnILkKhDw0ezgCF/RUUJH+B6u2/qv1PqapUEzDNXafL?=
 =?us-ascii?Q?89x6hXQxzjbJ8K4XFObmjSjFmAbb9uY2OVr0wBm5vJqd3D05cJVWodCK0S9e?=
 =?us-ascii?Q?dNWxTL8XfFzqCQMO/LxPwaJyEP0VoO+0e6uNfYiAUDzjCZ7szuLbzVcs92at?=
 =?us-ascii?Q?2/YtjQnmHjatkhFysrZktnBpn9yKeFAulUDGs6aR1FN2ZYceBNRkdBQuB1ie?=
 =?us-ascii?Q?TLiqpb6Qai74S5hgOVYEX/Mt9HED80ZL1WkV4aBEjNukT4Ka6UVSJjzPDtFh?=
 =?us-ascii?Q?nCgRoTHYx+DxBIqoZqzF/LYmlEpm5n6fzfdq32kPS8jFjrjhma2zQtKenuWl?=
 =?us-ascii?Q?BqnKxG+k/6Qen4rKDT3CN0BrzMVEn7vhnX0qigNK5eiYR3cJZAOqQYqUhIVe?=
 =?us-ascii?Q?rqb60lu5CFxJHv08+R8MIOAYOgGHkWvarwLWz5Hw/ProytKD2r5qyP4Sunm9?=
 =?us-ascii?Q?sQ+fdwzZ5YslWloqA410oXQcgpQogx7K3nEnLx8/4x3MDyC8vSz47/vojrI6?=
 =?us-ascii?Q?kVYxi1p9hgwJH6HsSqVs0UCCKXlg9rg2duKCARjvKW5R3T2ZKEhLpPhQXpTD?=
 =?us-ascii?Q?gYEAsPQMKbRseeLf0f3p6Im4p7LY1od3dWJoR4jdpz3EtYlXUdo3H8zcr3M9?=
 =?us-ascii?Q?wFTaD50G5IcGOV2dDj7kzKLLIZx1WcypRw3OA9MR9TGHUqL0/ZwWa1d0mFcf?=
 =?us-ascii?Q?OSL4TAntHeeOwLSkRjlmvVyhDlEtFh1dEueJQqUgFbQ92iaa8OmRdKVR3uLh?=
 =?us-ascii?Q?jBOqDi5cCBq/aSqI3PWu4sMKbO5GXO3iv0echVPHHeS+a58M+i3l/iqPMU3a?=
 =?us-ascii?Q?cMpqL+TI3Zx7P1udnURp5G9EuJ2lItcQkrv/SKST2zEG5+wVdoEs4vskGnf8?=
 =?us-ascii?Q?oUWa2guq4kzZDiv512I/n8YPdUUIkayxwJ9K2sK7f+u++1vPXbLXcuf9CRMO?=
 =?us-ascii?Q?KN2c8n+e/rvt0R78IDk5onA3r9jmvgrao01VbuFmEpWJnP+2UbdUYhtbza3K?=
 =?us-ascii?Q?3d9AOv5QQSVFEhnidjtYInIkyCOpete67h8LTfy3QDPlZHxCS4EJTKTx1BDF?=
 =?us-ascii?Q?z5MlB7DsPbnYEyNuKl4FpI5DBwFL2oZNoFf8v5Fknk6Dm6asjFlLu2h+LOPC?=
 =?us-ascii?Q?RX+bM3t5sss6u0nVHWpQ4FayIGPnMRvUuMhBgjF/SJdfZKrKGQHdPAbH3+BK?=
 =?us-ascii?Q?PdteSMe8vMHQFfghFcCpolfJp/6SCXAtzOQKuhoz6sMW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dc8d6d-fc73-4990-b90c-08d99e301529
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:20.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GOiQVBS0/QWjJOdAduIZOshycT5p48QW52p6PMGhPasKT00TEasmb77xInqC4gP9kWeINe7p5vP+Ml8mrLtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-GUID: 2bxutvnNteBfF4AnUI72pFuHLi1WD8jt
X-Proofpoint-ORIG-GUID: 2bxutvnNteBfF4AnUI72pFuHLi1WD8jt
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

Notes:
    v6: use ${wl} where appropriate to avoid failure on UML

 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d74cee5c4326..37fae04523ba 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -196,7 +196,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		${wl}-Map=.tmp_vmlinux.map $@ ${ldlibs}
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
2.33.1.257.g9e0974a4e8

