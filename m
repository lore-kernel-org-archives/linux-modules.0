Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA24C433F5
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E11B6103C
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhKBSme (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:42:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18716 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235585AbhKBSmM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:42:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IJ5g0007858;
        Tue, 2 Nov 2021 18:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=F5KWa1H3IrUIoK2BXblQt2A0goXFDuE5Z+UNAcQVQvs=;
 b=sgCSfT6tKP/Wxqy4dhdYPuO7n8uyRgXj7athsAO7c5pRNrHN3BXL+CBNj/Y0HWv8Cz3v
 +RQEzs7hozRnL85vyrcxxyQE+mzgUyOQCO2Zfz8RXzUjQS2ESTx7pzvKNb6XYnoIgG8L
 y+FjONUH2v442/7FfDK4LOuq9pSpdkVsNlBivAP2rtZsi3fFU06qEITIw+3hg1I+QwPC
 tNedSbwJIj/TgDic2hpnFQcg8Ou+MHNyEwBpsk23Xhq/t1+l6ouC0pDFY3Dc3EkvrGTk
 VVTdMtMDxVHxoaW8FLdysdTR4dWcWuUsHf6nJuV7zOmlR+7oq64SRi0PjoPC5J2TN2I/ 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8hebx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IKJTc109954;
        Tue, 2 Nov 2021 18:39:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3c1khu144d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu+chzTn0nvxxdX5IvAsr31pGES4kMM+V20wJZOz3CFuFeZsRsox0B2J5AOd7DJR9rKRAjKVKvVy3XlYN7qrctkzPsgqjs+I3i5vg13NoRHRTZO0x4L6YlPNfkO+d1qR3if5DLW3RYq3iauN4tHKQX9lDjgpLgQswFLAZXwvjWixUtRAQFpdcFJ4weRsaCI3AskWXdpjVAKPli7LrxdLZ956OY1N3d7FDAeOg6ygtfKWLGRBNNOQGFdlv2UdN1jo4SQrMeKE63wUqGpnSk0ssB7P1it3IxVOirqt+I/V4fzuF4FI5WUqiZHS2FmjSNFAw3TzjlsmdoGVzw6b1nr+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5KWa1H3IrUIoK2BXblQt2A0goXFDuE5Z+UNAcQVQvs=;
 b=bDkDWfsp+JlmDrPcVgl+sFbCv4+9lLWhcuOcF6B4uUGZNZnQl3nqnrFbXi36JXYfIlu4uNaJUoNX+GjHYq0xXR+FLJUb7SXbqTtZnBpfB1uqVr3NaeyC6YhmtTn/TFdove6N/HFKlLta8cLAiF4IQHIa66F7fKc5xnDrVVJBRsbipwv+UHDceHVqrSWKbcEsuT/fqa2vZrVknLg1R5YLdR/BIOWwOZ45SKWY1WykfnayXt6etHfuKCHJg6yt+zZxsa7HsRY+Th1EguNrXBLihL74pB0PfQqirs8gEwrulzbYbe/7P1OEnJ+gKPy+dbAPqxyjxBSloQ16JUgF7VOp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5KWa1H3IrUIoK2BXblQt2A0goXFDuE5Z+UNAcQVQvs=;
 b=HQsMpz1hSYr124GCXHkYz2B3vVYJyYGBVST3c1xZMIJ8iwxFLh2lRnGdmqbPgnaDHSE6M9xI82+oqctrq2s6L67ApdMycvvCigFKp767M5NBpnF/T27G4jKT0VtzuDyeWvZDmjo31xfzozCcD+AU3w0n9qR5Ik0TwepBLZHMuvs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 18:39:27 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:27 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v6 6/7] kallsyms: add /proc/kallmodsyms
Date:   Tue,  2 Nov 2021 18:38:50 +0000
Message-Id: <20211102183851.168676-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20211102183851.168676-1-nick.alcock@oracle.com>
References: <20211102183851.168676-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bea2908-9772-4422-593c-08d99e30190c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5679DFDFD4B3E64CF68D21FE8B8B9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5Sbx+lFVatYNqLu1jkbh0hDdwMOXHOV9SbykM5hrpLND3mmbbVxYuAgApeIWySoQ19FY5T8frAiG8KtEIS1MzBUx2L9nbBk5O4L90EFIzfB3NmCwJQQSLvGc2gZ5GG136YPczzm/wBsodllb/irl49PZB0XxpEZph+l9EcO5MqFFcbjJ0yMWKkErXZZoRYSEqtN4gRtOLemnL2bkEtLtxlIvstYjX540VBC2E+VgGr1JLdwg7xBa37ggH0VDkQTuhKPhYULsBGTJOAIBzmDxOrZ4kimYg0gBbfN/XhHVMcfIFMcrcUuRePDIIAn11nXWC2KHoiUtbYzdyvS9O2CiEeA4SnRqOKQGBeODIFylA1lRn6UhoMlxG/yHt8bshjiqkeiDEp+I3w1TyLItraXzbVdZs/U7aj6wySOiRQDAUZkBrdu0TvMKtYtKq3EuqkJF/2+T3fiVjQuVyBVu31+mFTl8iMbo6AzXTWUDo7j5u0c2LbhaNUFviO/ubvQpiBby93o00x8Dwbyl6/yjnZVvml2XFPaIZWWsIWw9Y10OpUFlq0aDLHIc5gyDUD8BDZFABoHr7weCcNNoDbrVcuH4Zpzs35QktDrcjlqEzyRIA382bbv5btKKBgD1Lyl6NG9Reqdg88Zro8Ge1dubuxtIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6666004)(30864003)(8676002)(36756003)(86362001)(186003)(107886003)(316002)(6512007)(1076003)(5660300002)(52116002)(6486002)(38100700002)(4326008)(2906002)(8936002)(44832011)(66476007)(2616005)(66946007)(83380400001)(66556008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SaS+ZrMiOmOWrehoGSADzyPJhH4qiH7WYy+J9mhvepfpd0KU298tcE7nbYGC?=
 =?us-ascii?Q?K0VGR1SqO66lSkJHKmhm2lyXLRP0kuZwIu93kk7V113WJvHdc2J0vVDUDN6y?=
 =?us-ascii?Q?U3BkN774e9n1i9uWJ5RnuBgi5DESEXRxrlOwQji+7m81SCKYWypAWXufJQ+A?=
 =?us-ascii?Q?FNi908HNsYH+RMn3TnrVVnwDWr90cfLoTUIcgud+ZsRw7kJM25J2zSBAWqlk?=
 =?us-ascii?Q?sBNJD2PsqBL2mRJXStG6C+p+E2V/lJWz9lnHBziPaxP1vmsfHdLyMbVh2n2e?=
 =?us-ascii?Q?0x0X79WZE9pB9jnnFVAiIOdRs5SwZPzL9BZBwAu+D0MjatvYY4DgbVNOPV1/?=
 =?us-ascii?Q?8h6emxIwkwA8hlXh41AZUWK2I9T2ljIyNEu3UAXWb8htC7lMZAhDq7BADD7h?=
 =?us-ascii?Q?YVRWhshhx0PeD4iJo/Qm+BW54UF2KhuDVmZN0jAWG9UtL5Rh8K4iHlv4w1S7?=
 =?us-ascii?Q?ImA3NovLGI9HgFohJM3HMCx+qe37JqnRr4cfTyHETsn4B/f9BWWW2UwXFi//?=
 =?us-ascii?Q?jP2uBCCVPdLNnU6sF36bgsKl1qyQdGcdICeoQZAFX0Q8EJHER71704Yn33OB?=
 =?us-ascii?Q?NxrK1l+BvbF+cxs2VJz0xOOsh8X1+zp8rdzJgQBCL5UzBVcHx+Ll6cOl2iOY?=
 =?us-ascii?Q?ktZ66sROsDjd/J9dosb/+9sV07/X4nR9j0nK/2sdQHehYaYMpwvhQiVW2rX+?=
 =?us-ascii?Q?CUx+9MfqhQLda2fERtUFubz9QHZ/6mZSdqFPnhOBIMi8bVAZtQ0KItTRbzxC?=
 =?us-ascii?Q?9Uogs7T0MJ9+LDBFsZojYO10qO+Vi9kyq4leS15XDikRf7HV3S5g7GbcuQ8I?=
 =?us-ascii?Q?7s9qGkbSmvf64C/YuREwrIAL+7mFyM4KFkriojlhmcYpC//A+lPFknhBiKD5?=
 =?us-ascii?Q?Z5au7SEwQA6ugUb+NFXrnW7tfJNPuLgdNbA5A5LvJF/ylhusfAcvU1YX9CHr?=
 =?us-ascii?Q?MhAz/CD6sRhH6gcI9rgZSnq6hy3rTqvaqszzg7hJyFqPYEfYycI7Fx0rQ3qo?=
 =?us-ascii?Q?bh7RqWREMxPTt6MxacaLk9bDGXFxxNVfJ+BiRJk5sGgmStmK/1id4MV0bw+E?=
 =?us-ascii?Q?kajLcWOBUpDCth3AUFSoCXLP8ZWU42GqdNTK5dXoisBI80hPYmpZBxOTVP8X?=
 =?us-ascii?Q?Av7LXcI4OePT5ZXJsrqu2Y6WcTRz/z7xU1RRRqWX1f2npgKYXlCSww4OD7Qe?=
 =?us-ascii?Q?GXa0hz5u4PVrqhOiXuM0gtzaMrwqliWcZgfWGmNmSoD8SLkXHdyBr1RAA59s?=
 =?us-ascii?Q?p4ntiQJ5V4icRqDARGYPM58yrDj3zPrVxjTqSXeYJqlCW1V7ZbiB0AUm6ZoO?=
 =?us-ascii?Q?ffsoY5FzUFN11UpapH1/KKjFHDyoW8vnk4cebVKdLM53nD4oqWv2kb8fgEA7?=
 =?us-ascii?Q?fnq/WacCKWne0niFLyWcgh327xNOe79kOqEMfgw3DYoh+Dt0wmCuXa4O5R3M?=
 =?us-ascii?Q?CsuZqUcC3hYKUgcl/TO1hDQUNofH2aql5cFdvhQYj28eeQf2qS2iBTw2yoW0?=
 =?us-ascii?Q?OO1IAEYLg2iI2zhiFJIQVspNCUnw5Tef7pzbFrOIyQ249kxJuQhIr9doDV0h?=
 =?us-ascii?Q?yQLoOJAUO7er1sUTbSX9CfQ/ABJIsBjFI0NE/OGmD4QPLkIOB8o0YkGXvuHq?=
 =?us-ascii?Q?qY8yAmbcpafKweNAsntszuUl4suzuuFD+tAN2aXqDLwv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea2908-9772-4422-593c-08d99e30190c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:26.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tryz7jLmuLHvTCCFW/SVjQDJzIplUhPjI7xwO7KxkEy9Q+CgO/dp0pOUYM7E3mNekSWvg0x/BLvxtlSK/jD58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-GUID: zwsO1a5WrOG2poTJP3JsFrHnjq-FJQvF
X-Proofpoint-ORIG-GUID: zwsO1a5WrOG2poTJP3JsFrHnjq-FJQvF
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by size, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms,
where all symbols associated with a module will always appear in a group
(and randomly ordered).

The result looks like this:

ffffffff8b013d20 t pt_buffer_setup_aux
ffffffff8b014130 T intel_pt_interrupt
ffffffff8b014250 T cpu_emergency_stop_pt
ffffffff8b014280 t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel (but,
obviously, not if it's not in the .config at all, or is in a module that
is not loaded).

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 t handle_timestamp  [liquidio]
ffffffffa22b3b50 t free_netbuf       [liquidio]
ffffffffa22b3ba0 t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly
brackets} or something to denote built-in modules: it might be possible
to drop /proc/kallmodsyms and make /proc/kallsyms emit things in this
format.  (Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_module_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules array that relates to a given address.  Save a little
time by exploiting the fact that all callers will only ever traverse
this list from start to end by allowing them to pass in the previous
index returned from this function as a hint: thus very few bsearches are
actually needed.  (In theory this could change to just walk straight
down kallsyms_module_addresses/offsets and not bother bsearching at all,
but doing it this way is hardly any slower and much more robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 kernel/kallsyms.c | 242 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..38109bb02bef 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -48,8 +48,18 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_module_names_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const char kallsyms_module_names[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
@@ -185,6 +195,25 @@ static inline bool cleanup_symbol_name(char *s)
 static inline bool cleanup_symbol_name(char *s) { return false; }
 #endif
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -288,6 +317,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules, or (unsigned long) -1 if none
+ * match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_module_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -559,6 +636,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -589,6 +668,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -608,6 +689,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -622,6 +705,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -642,23 +726,53 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long mod_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			mod_idx =
+			  get_builtin_module_idx(iter->value,
+						 iter->hint_builtin_module_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings) and module names are known,
+		 * and if the address was found there, and if the corresponding
+		 * module index is nonzero.  All other cases mean off the end of
+		 * the binary or in a non-modular range in between one or more
+		 * modules.  (Also guard against a corrupt kallsyms_objfiles
+		 * array pointing off the end of kallsyms_modules.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
+		    mod_idx != (unsigned long) -1 &&
+		    kallsyms_modules[mod_idx] != 0 &&
+		    kallsyms_modules[mod_idx] < kallsyms_module_names_len)
+			iter->builtin_module_names =
+			  &kallsyms_module_names[kallsyms_modules[mod_idx]];
+		iter->hint_builtin_module_idx = mod_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -704,7 +818,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -714,7 +828,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -724,14 +838,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -740,7 +854,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -751,23 +865,67 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf (m, " [%s]", walk);
+				}
+				seq_printf(m, "\n");
+			}
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
 	} else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -775,6 +933,35 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -810,7 +997,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -818,7 +1006,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -831,6 +1019,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -841,7 +1041,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -858,9 +1058,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.33.1.257.g9e0974a4e8

