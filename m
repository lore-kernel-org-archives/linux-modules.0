Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6DFC4338F
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50F161029
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhHCRRH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20650 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237886AbhHCRQx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173H7RHt023889;
        Tue, 3 Aug 2021 17:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=XuYUppHLJg/9LA2fhiI6Rsoyz3EtxzRT6u2Pfsh58og=;
 b=T2y57srzI7Q73AF6Iovdv97flO6MqsHvUEMJ2wWg+l0LOyNC0sfeYndhDxshUssKK43o
 mLts1LEuxRkQ9IfBUIETbTo5OfYt/MEbO+yCmxgqITq+DHLs78rIYdWzzMxskHbiPGqd
 EXiSNOuMXM6X2rmKBjPTB46MG3x6sMHh7yaXUCwKrWTJlcJFaL1GhBPlDD0K1Q+Rt6zy
 JW/3f9SadnDnKVvLHOUxF0QUQEQSvIvVoK70FpCttqDXTdIwzF8XHWnryUZNxPVisi/3
 XMtyBtN2wkb+gvGKpUO3z7Pse3whjSbDgOayRjSoF73KLE7cVfVY1vH5JIMUpCEy243/ 2Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=XuYUppHLJg/9LA2fhiI6Rsoyz3EtxzRT6u2Pfsh58og=;
 b=js7l149FnTy96GAoL33kqDTKgYk6phMKYc3xQfv1+wclUbh1nsPpanH5sCU2m52hcdht
 DfDdGcFXXnWsL0jl2fABSSwjf8lDWaoWQgFepbeX9RFmGnSWND4Brk6VAIIwG4FM2iKN
 c8DPbg2SX39VbxAOLAoShKETuIQXqQkpgVyz+u+AyGtI+1rPn1fZdvh+UH3Pbam49Nnz
 q5Uv+/m4p19n55Za9TG/YmO1RYFDCr4eW7hTH9WWsomQpQ8xvh0fYQFV2Y03P7tPl5Du
 /jBdY9hkefzbwqGcl1v8PxV/e/B6Nthou1dKAgoTFxl0BMZncbgx3w3Z2f1aRoD4exQs Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vdcsn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4mX089331;
        Tue, 3 Aug 2021 17:16:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noAxmv/OBAUv7dVVd0dmcEZyY3ou/Mm2iVUcYUTnYcVnPapV7BTkQHUrFmMQ2dyqFGOY6Nt2iw8uccv+KYrepiRm11At9fIHmbf1Tkz/J0pGtM18YZrTyfZR8/G+cDRUy9Mk2zrhNHaHBGfmBDz7XXeAxmp800TMi7StHRY6qXI79P3LyLuhDqa6fWLw4X3YkVRqTPK7QIhmtTFXUPD67mHT1xzmeaWrjPhzFA/C38y9tFEV+itwqZ5Gjhz3jl+Qxu/arGr+7huqUoDBRyWQPUHYqLyDHeSnmC4MnsRY8I0kVrxP5w7QQN6HJdL/V4+lixWaUNe/MT3cQYpSAG1x9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuYUppHLJg/9LA2fhiI6Rsoyz3EtxzRT6u2Pfsh58og=;
 b=LWJdz/iI1w6xpX/nsxtlbAmSIc9+zrifFy1gc6c2y/3L4IA7lEBBLJw1xFYSjtxWZAOVUxG+sCdMMN6aL9f5qyAbKUImens/3tmQeSDjWhMTR11Pad97OUTw1bE4kAqGts19Wh1D7+71I2303v+BAbZ6nzsGajC4EMHt7HwVHmWfqlyi0+d3dUBNEw6g3nhPMCKkV2kXkH69tnJVk7744fxqmQJypz0PyioNrV0YT+e4WSRfm4ZdGpwytzxwch1qfEZ8mV2BbxKC8jesbA7hSdkpNrY7wOfmf9xWCyAucS0VNnqFkS3kot0JLMHOlQBMuv/JIcjlnm9fM8DMT0Iiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuYUppHLJg/9LA2fhiI6Rsoyz3EtxzRT6u2Pfsh58og=;
 b=RAY3sW8PnNCygx4Yq8GMCIAbTI6ADDW4CItxXecnMK8G+Xy9Fzy4Ad6WeqNeErDPPD4j8YWQWevlxZLRti/oZEGu0lC1pG8XjYV+bm1OqxCjjksc0rwGYx7aoR5GI/WadBMTQP6b5o7c8ZZknqe6arCYzh5GBQNfUO2+ag3db8k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:29 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 4/7] kallsyms: introduce sections needed to map symbols to built-in modules
Date:   Tue,  3 Aug 2021 18:16:05 +0100
Message-Id: <20210803171608.509163-5-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b834ef02-8843-4988-a775-08d956a26edb
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB471542E2D61CD41A0AD3A2D08BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KzDwM+3ItoU8gaJobb59jYU7qcd/SWBHclUN4TSFZI/P8LZyhoc4Y6kaVkPETRU48EaKU+gs4QSiSWLm8Vy4MjDFtK0P/Wt98y+btcHpMJ9iLzHHzO3jpYQIYYyts0H43cFIYg6ITsv7rU5hAfKqXzThnjILpVQ9n7G2Gm2tNowspUNfozhzELlSUcrFw9tMSZ/WHniLhsvRwHD63sJTb5dulBYdFcXWnbfc/ZzK6iqbneSPJRdJyIjfSirrZb7QP7OKQ3df7RTGRRXd8zzdckom+F4y7y53aA8gkL4cMK5wY+fUFvlpjfLT6W4bN+QVBgkLNBjPEA5SEGssAEQt4HDPhKUxAm8h0cGRi92QCi72cmfFlbdQRN4Lu2tpGy1kQiJw/6oQAcSfRIvYBFzyer0H0+oN0YFe/UsFCXeeqfL6VT2yaf3wZ/evzHTJgz6nS61pqyKf4whbH8sI+3XcNB2a4cvtHu8gfV1U2oJf3wax9UyFOWA2Arx8JrwMnooLG9dZNjIR8lHGZf1eRZ9D68d+923JbYYGshX6CL6/jqdceo733j5ZYgbkCik1HyW7EpFDxynuf+rcmz79/bsaVL57CUluNlzbvbaeAKrPgGE7RVP/AhQhFjt3TiEkLWzPJhw5YKkkrUXCc2m7Mgh8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(30864003)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUscHUmIabY4Aic61oQV2sqZkkv6Qj96apzMzPd3eh0eSwONPHhjcaRrN7NO?=
 =?us-ascii?Q?SQgC9JH5liQj0mnfavlTJ3gaaAPwDEDCZ8YEmpch0NOvuR98sZ7bgTB+vaeC?=
 =?us-ascii?Q?oSIYVM6f4MW/AGG3bTIXcttuPcGxLreufoPVWoQxQi6C7GvXywEX9P8dEsB7?=
 =?us-ascii?Q?RtAm5wvcb8mHpAkpfXLAy/LU7viGXhm5mPhjoDdFEi7utxM60rl5pFNeeBO/?=
 =?us-ascii?Q?nuSgSoBCj/hLbTkYUt/S08CTsXqCFB+oSOK8VHjv8anJ6XX/8hYmU3wLDPj3?=
 =?us-ascii?Q?2KEl5Ctlv06io+XOP6APxPIpn2FxkfO2R/wZLYrrRvnIoH16yILhPU1wiGkQ?=
 =?us-ascii?Q?KazcZnkDqJkGFxUEv734sFjMYl/tXOipq416y0FdhFmGHsRjMC1Ht8l4f95X?=
 =?us-ascii?Q?F2ZumqgNbnUV02Si8dmvtMZJrSutpIVRNzbbJbuPamk7leopeueS2JI04Uat?=
 =?us-ascii?Q?HUWieKAuCna6k0FTr0gWZSUhL9TD0uw8EvvlAfkrjsSWklClalC2FBeUGP0o?=
 =?us-ascii?Q?ck2fyOuX7+RXIIgirKSWhYtN8z+cvEEbGbU95ww8XpKFbOc0XbPMF+/+Lv4n?=
 =?us-ascii?Q?BwBdq3V0fKByZqn+YeCB9eocGvV4CpwIUHUqznNONhaGS1vj/89mPLyxkHuA?=
 =?us-ascii?Q?i6YNWzr5KDhEcCr2RVFgehUc0XLV/bqgi7SxotQkd/oL6FMEdWrR8QNNKazV?=
 =?us-ascii?Q?2U/JzCs17nKPbe3LXusCLPbbLijhtdqToAFRCpGTZvsVB/Bz0T7/WC/tJQgb?=
 =?us-ascii?Q?eKUtOSSntOF6Oyq70nwgahZod5mvoI8cAB9MpnkF1w+IUm30UH3V+p6BV+UK?=
 =?us-ascii?Q?yKDQB3Xkvuni+H1bG2xRN7tz/5AeZsAq/L8aRg8lhPUghMJpWLY8dM+QyITn?=
 =?us-ascii?Q?MCXPchBarfc4i8fwstJ+m2NjFJKLYAvZbz/5nN/LhBr3X89FJQaXjjx3PLCQ?=
 =?us-ascii?Q?+8XHeJZuBIMmrOhr/xS0ATJhlMSACcqsDjGcfAF5g4LbJ3sWrtt8Gket7F9S?=
 =?us-ascii?Q?wPVQXHEOGkoiPxn5d8xFDXD71lG5L79sKPEo3pMONuCTM/JhA+RLCez4Fcum?=
 =?us-ascii?Q?TFuEdGMAbi0B/kSvf6T29kVVdNbNb8jqTvuQtnrhK3sXnMIsAXGoZvirFRHv?=
 =?us-ascii?Q?2Bac11ilg/U3g2a8Bjp/CYYTGwMF09gouIt+a5UehZ3pIlsSQjpkfeKDO9Ym?=
 =?us-ascii?Q?2RSTXDgSU3KY719asJRROyyZIqKZevMc0a1mSliEyRBSL6niogFr+EuUkQd1?=
 =?us-ascii?Q?pA6uxr2HvUDcBx9oM52Q8+7br58I5h9ecySPHy9JyB0f+2k/k2xMinT6JmiY?=
 =?us-ascii?Q?URKys8sXyN/fQMw9JNmk/T0KtEfx2Z1RVLfgk6m0frSK5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b834ef02-8843-4988-a775-08d956a26edb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:29.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZTvX27YKM/12GUulAu0KmR1dXfxtYT91w25/ABZwS0gT5rY6DjYNgJZoct2PivGRSI1LhK/iE5LSFQnznAe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-GUID: eugN_ju0g-VuPE68jO8osHNndHEu0Lb5
X-Proofpoint-ORIG-GUID: eugN_ju0g-VuPE68jO8osHNndHEu0Lb5
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
index 94933f01fd95..bbd0b13a8f0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,7 +1195,7 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) modules_thick.builtin FORCE
 	+$(call if_changed_dep,link-vmlinux)
 
 targets := vmlinux
diff --git a/init/Kconfig b/init/Kconfig
index a61c92066c2e..1044b00b8361 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1495,6 +1495,14 @@ config POSIX_TIMERS
 
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
2.32.0.255.gd9b1d14a2a

