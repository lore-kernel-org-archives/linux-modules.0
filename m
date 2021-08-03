Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D1BC4320A
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C90760F70
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhHCRRJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22634 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237952AbhHCRQy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173HGRNJ010303;
        Tue, 3 Aug 2021 17:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dk/+K9jub5uRxTCWF09RTLlXu15OTyiWbbzyh9erB+s=;
 b=0DnPb7ooxNqAG/mRifZ2iqtFTUmj9J/EKt7dZO//hRxcMmRegm1r5Qo/zBang+djiWJo
 DfUsOVS8mSCXf9ozsdodAuMDOLOTrCW8peALcStfgagBoBzLT+1qbPiiS5jsqVq7LIA9
 O/mjQjQv6oLDnmLvJRi0Int+9gr6bTzToW8wbnT/YzLvn61eQt1sACngK4UjzMbK76Gp
 ozmzyqTXqEw+5KRLJp1fmIZ5DDHIpFoaTKANXC0jBbgIqo+L9Hz6C4n0gJ9aQuEc10nU
 jIsi1nBcOpsZSGK1rkNg0zhz/jDWm+IWKYd2PVqSwmtzT3R+3Bjf6++/ZepeyoktoUp9 6Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dk/+K9jub5uRxTCWF09RTLlXu15OTyiWbbzyh9erB+s=;
 b=dzi78CeRlTau7d9WnMKKL0Jiq5pwzplujLY53VTpV1GCYtmk4gqLQxBM4b3k/JwcdT8Z
 QF5FGCtpK5de1NJdtKRVHzWbnkJ/+i8x/8gHW2tmiY9UskQ2XlI//XpgKFl93pFmyqTY
 VhkeuXO1BhqWs4V65mSm6yic096zXXFrEvLMXSjnMNq3bz0TTLx96QBg9n2rOX78ko3m
 6cMLjroiZN58hmZusPhlc1iyqjU37aC+ln0Mx75BvjFUsATtfoJvdMXqRusupxgF9v1f
 CoXiqm/WN/t/0fb6gdBQeR4la5HMUDaTjP5zrH5rY+/r+lWUdlPvxZM/+Be2G362vwtt 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6gqdbsc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4mZ089331;
        Tue, 3 Aug 2021 17:16:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7tRzwtUfyvF+BD87XhuuFN3uBWq1Kd9SGdC+14PnwuaSKn2B7jpKhGOD1vtbpI3Y23xSo2r90Yr+oyWHldTaGNsC6LD7WZgM67crc+irYtJuasnZaniusj5yW3Vz0+kd++Rn2lg9svdP8uHUGM+9KJZxPz7oymquOTsCspOy7X1OaaeyDspJdVadRZnsQOrAOPll4LfeKCY2WhmvNPbIUraCvv1TsqtbND/f7wpzJU03WdPreECygWSl3reHJ3Ka4HiWFzrqG5YWTo4X+L4ESaUZpi+9IfM6TlWzO5USCRROHo8UV3n6fgIkqlUZAJljITTQsFQIImOSuRW7loGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk/+K9jub5uRxTCWF09RTLlXu15OTyiWbbzyh9erB+s=;
 b=RRA5ISPMM2AxOI01M8QB4zDlG3EMBNMenAyDKWm8HFvY4qDZvyFUXvOggHe9dj3d3X4cYCHLW1ilUk4kkiZTOyPdNvIYJTuGNbky/aTWuc2UHO/LKUKX62qYRxIiCjvn1Fnm66AIU7qk/25N/1GIkxKRAvvS5Pij6MLnHKBB786YU83fKiZkyXi/n4zvjljEaHyvjyznFS91CJrjxZN//1Qy8Ug9wR8XY2UiGTmZ8ookMX7DJZDx2E4c81jrJ6GUftpNN4CwR09XLy1WMtOoDdaVAUYsc/lZBLnsH8c1gRM55PTJt8UF5JS5e/6EEJkgIaT19vBtvz6ZJuvz0H9DJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk/+K9jub5uRxTCWF09RTLlXu15OTyiWbbzyh9erB+s=;
 b=FCbDvoKisdVtocMlWEzjA7vbfWZt2lBpi4A+ytZLa2SxSZt69sjXrFszXEAQokT6rvf1xRh9XcoKCOcPrgWk4tFhO84iTdAtWyLVP56F2q2zqkLXoaF0rXRpHlPagCP0nIVkCpQIW3pmiCNO7DoDp/RhcbhMmYNeFcRxoWqkpFc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:33 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 6/7] kallsyms: add /proc/kallmodsyms
Date:   Tue,  3 Aug 2021 18:16:07 +0100
Message-Id: <20210803171608.509163-7-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e891a4-5805-404f-2331-08d956a270f0
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB4715BF92545AE4DF998E3ACD8BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0Q9A1vRHWg6M4J6nsTSnr4as503V4mYwSDqL7B/q0kYiYyWe8dN6inWykN4VhTXAeAzIwHCXTzwYCKKhIwbvOaomHFjdkT7r4nWsNg4U4IvaYYyhDkoUVGa9gLIOhQIj9tIE7GeFQE5u9Tulmo19AvY/RAQgL2oCYTghBC4g6c7aei9PNL9jSgcy4F0EHijKNZYhRn658tYKScXp4SkxOkMLHP4oOhVdmTdJfOv7ovxVcNLxnRDOFeBqSfyQaxsgvAeMJtoJHvDDOYmRvbkk3HtPHlEpLKg6n6UfV9Dasuqf7O9y4Itz1Pb/LAJ28KO7bjvh113JNmOAsIw5cq5f60WdipT6uldz4nf5nYGgzUjQ13GyqOqJ6nPfv0rfzD2SLwqKnwjsGqS+l4ZcOeUllV96ICu3LSHGwUOPPUdK5u5QjUrVyovx3lehXFWYp3QPCwnNF9RI8Rnkp8Kg0w9G8t+l+xEzPH6nG6wdmhS5hD13HC0RC8E2CbPLw8DnmL94+lak0V6DqT1FerzRHtcls9qKpeYNB8mOCvBD7Qe19Vtxf6RdyVwptvOUt0P3bgPyZGbIe3FpWry6AdgjvzhpbUW+hP2QX0rq78BtgCg0nQmxVRoffLqugv60zBSvJ3cc+eV0dKxmOx/qV2BWXSq2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(30864003)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GzGbplweWkypmTbkEYcHZOPDwRK6DOLKS6cqbk2AVSqv8VitUIMTO77p7Plb?=
 =?us-ascii?Q?1rCmVlLzHgXRml4zSLlnYyVFFT2vc9mRT4W7rMSS8QqfkMYo/zCe0d+Jn5p8?=
 =?us-ascii?Q?Lyltae9xGavxSvs1xJXR+cPOCxV+523YRxH7E4fIT+KUAdz9OMfzjCsj7zUx?=
 =?us-ascii?Q?zA6PIL3d11zq0GnBfAROR8jWHEkIqMOX7eZxalUazl7awpzv029ry7BiyxTZ?=
 =?us-ascii?Q?dKu1NAf9GAbnEIUpX49AblSJxDotKXuDzwgVWNDJ6Nm+VEHsmaVokLeRXpd/?=
 =?us-ascii?Q?aAjF3Hy0cSAcuSs5SFqw6G7vSgD+oxEMbV47beJq2+423VoNQfcVABgwv4mU?=
 =?us-ascii?Q?ioe0j2aGuY9LpQ1Ig1Kx0MN03XNuV5lVSxzeC2EZ7VJCM14MfB9oNUdz5NWa?=
 =?us-ascii?Q?YIMWZihrdrgNZ/SwQq3ITuu0hor84zUpHyOHxMuKekt6gYH7r8CyLNsziZ0h?=
 =?us-ascii?Q?8YgknX+q9dpPzGQOpH8b0FDTdQDsdR2tY1Uv33wYwUsH/b4cWActDvhK066I?=
 =?us-ascii?Q?xurFPyR8sXF0tHinKFrenI9jdCI1XzTI4+NLlHfx8PWKP2ntQDhuwFHPpQZi?=
 =?us-ascii?Q?UO2hgPuPwLcpzR+cMi1FGJF8z9nfYAc64AtJr6MC4h5juMLmnTxemN6dp0oA?=
 =?us-ascii?Q?N48eklR4Ma6dGGyZl9CSKb9eVlU8RFfvm1uqskqZWIm4e8zejArj2q3w0McH?=
 =?us-ascii?Q?aGP7kF2N9ch5NXoe8bHvQ1DAKNu6zO2H5I6QqTZuLDyt+TLE4tFkfW+NKtbk?=
 =?us-ascii?Q?oD+lI3VPcBEobN25mQys/VonCJq8iLcK2x2fCFr63BJnwuomFGjI/qFQfmmh?=
 =?us-ascii?Q?83Zjb0cGlLqc+lZavugZHOrruTkDgarMNfS1VlVsg9M7WO5osxEwFS86u/Zn?=
 =?us-ascii?Q?+E0HRSstXkbNa1Pca+vHy6lArsbOazLntiw2FBLZXnBwudKMU8IEaADW1RD1?=
 =?us-ascii?Q?ngfzyWEheMfuisu+P2zSi0FyRGvfET8DuGeg5trzD6Io6iRsprH/4gUhBRte?=
 =?us-ascii?Q?H6wwUc/NBVj5u5ekPlKxkRRL8H7szPSfwgj0edKqFiQ1u19DNWN0kvbl3FCH?=
 =?us-ascii?Q?BI0TjkiTSGtgYTykzfaQyYQhx3COmc24ZWsZ4BhJwxm6y9p5QhPOa3YXQYJ5?=
 =?us-ascii?Q?nY1vaGQVKRgFnI7/ubXV87TNLAVC/YQ4g4Vog/5sD+tjfYXAKSaFS9zFuq1n?=
 =?us-ascii?Q?vqUxkHEEzqoB5WZvyTlsgwp2Fgd6KBU+QG8foAJKAL+A644I8uAV5/ZzVGfv?=
 =?us-ascii?Q?vW/CCyFloVxRutYTOP14ZTBh/G0CBCzjf/qIiF6tuyi19YkLkeAZPRBvLRm9?=
 =?us-ascii?Q?c5jIBd8r9BXF/YWGjS4XYktx5rrOIHfPMxhB9hNyZXJ9pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e891a4-5805-404f-2331-08d956a270f0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:33.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZnTTwHfLXCH9iCij8cyYEqZdrtUAukk/jbEX71EoKIambj/aZjW1Lj5ezxdSjoPbx18DwTBebsi3IodYAHALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-ORIG-GUID: XLDi3hen7CfORTCuvvsPnJIddjRuOb3K
X-Proofpoint-GUID: XLDi3hen7CfORTCuvvsPnJIddjRuOb3K
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
index c851ca0ed357..daf0c763da24 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -45,8 +45,18 @@ __section(".rodata") __attribute__((weak));
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
 
@@ -182,6 +192,25 @@ static inline bool cleanup_symbol_name(char *s)
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
@@ -285,6 +314,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
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
@@ -495,6 +572,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -525,6 +604,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -544,6 +625,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -558,6 +641,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -578,23 +662,53 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
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
 
@@ -640,7 +754,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -650,7 +764,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -660,14 +774,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
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
@@ -676,7 +790,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -687,23 +801,67 @@ static int s_show(struct seq_file *m, void *p)
 
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
@@ -711,6 +869,35 @@ static const struct seq_operations kallsyms_op = {
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
@@ -746,7 +933,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -754,7 +942,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -767,6 +955,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
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
@@ -777,7 +977,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -794,9 +994,21 @@ static const struct proc_ops kallsyms_proc_ops = {
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
2.32.0.255.gd9b1d14a2a

