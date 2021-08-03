Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B7BC4320E
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579CA60F70
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhHCRRO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:17:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61058 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237839AbhHCRQz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173H7Snf006793;
        Tue, 3 Aug 2021 17:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1i/KkD9hbjXrkOyDSekf8lzdMmoeB296k9jItlyWS5k=;
 b=UaFon67dZ+Hpri73X2/MMzZvpX3aW34pEDsBJobPJT/TLUGAUJyPW0q4/j/DGl98XO8P
 kwj8MonWZ0NaYwHKU7I2vhYXNYYBmi98dGUjJ/+oaZUIZP5ljs+QTGNjKjH0W+pI+IQO
 WwY5Xj1exyCifwdT/EbOSqsTJ4GXeDNz01fnQz7BNfHQxlEwb7X+SLGgV4/l8Yo9D/Nw
 pCyz3k/o388KsLwUYq9ZYek9XjjpZTvGXw9q20O1YU/i72VPgctMF533AOvgPV+G1pbk
 Znr4XuB48tGgnL238ATpkZGWJv14uostwQ0b2SRqBOLmpVFmB2EjoVtOW+ApIMfOxaqb /w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=1i/KkD9hbjXrkOyDSekf8lzdMmoeB296k9jItlyWS5k=;
 b=HD2B+h22wWUbXNGb4lDW7n+9eiEQVWak5VvIe1VHVCcJQlZRXvhV87ZSXzqPEbyFqhe/
 CtP3JjoFncjBj2kSQFbBgdYANvNkfgruU7NAs0HIj9cuy2rrmtvwG2MsWvI2F/8YIsoH
 WcA2Y74xTnZ+8Dr18/yzpBGf7F6WY5BNxPvCobhTh+1S7rdL1B+1mJ/zMsiNAyzO0Iga
 J9KMKMGBFE1LcxjdiiWZ1Z5lj3HUpC9uRf0GftlPZaLN/WMDufAM+RZiBHb8b+zDCTwG
 MifMx1U+4+T5VSmbdpA3rYIqjHwa+2K1hL4fOWx0x7NCQMPWO2BpXbGLyHiRm5K0J0S/ Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntm8r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HG4ma089331;
        Tue, 3 Aug 2021 17:16:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3a78d5503w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzwM+dG7IgOKRkjTKvkwjCzhjqEW5kKSzA/j4q9XmEKeLcwAQWQ1CC0xXX3dYSdc2dHfRB+ahUPM+z4+N+LUNNU8oUt4Slbuo+TpgU53gAbu/15oqQhpMTf86pYT2agIjzti4olpuZTwv30Isfiyun8p1ncla94A2n1gJeVSWYa6G262MCwZV1JqBpBORVlrUGfExiuwAlLpafKnLibVaEBxVU17spEOOCZEv43fxquHeWImHJpB3aT19uLNhO2nnwisMA8Lqr3Vg58dZQ1iq4pz1xupYFcwg/9sYY+ehhLnljRsqxw3t7DlLrYQudLBh6/DhtN5g3flzLw1lG6jkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i/KkD9hbjXrkOyDSekf8lzdMmoeB296k9jItlyWS5k=;
 b=HbOtKPqWu41gSicfDlNfFlQRbx2mIA8apJflmvfEzlvyGcPxsj9GTmzH2mI7Gpihr6zJvsmv3+uIgbxPibf1HEA0CWafwcVBPMR/UiMhNL4HtioOS31dlgVotCbE+RZ5P2mHDJkEsfyKXxsj3ViuBCUG2nX3yoId6R1alnZRL9Ui2Ad5Sb2I9RmZDFZmyHrgK2PjES4ZPrXsC/1+fRoyL3nha4jkTDNHRfCHFfRs/w3yhotjlw6ykc/3B8o5l/Fm7rbHf5vxkM4GjmxVWVCfBaUo36wFNOVLg6BDUWMANRApjiXI77NWl4MzGhz8IZQzHdIWVODakMh39+JFbj5KRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i/KkD9hbjXrkOyDSekf8lzdMmoeB296k9jItlyWS5k=;
 b=hoa+lnMJ9knWTsHCfNI/p7A3oZ9ei5/v60zJo5jz6Mn/bFC3bq/jnU49CifGl2EVLf5UFwRifM63Thzx26Dkq65/4nzVzQPZH/B/gTuXd3UIxEVlS9BaemeqQA3RhW5Q3v+c7I89wB7M39D7Wabol6b616XCwRZ3+Yh+H7cAgEA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:35 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 7/7] kallsyms: add reliable symbol size info
Date:   Tue,  3 Aug 2021 18:16:08 +0100
Message-Id: <20210803171608.509163-8-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa13decd-c862-4490-6c03-08d956a2721b
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB47150749A50990E49D57FACE8BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEztYJ7TzMYxA/wBxheAjeHCLggAL2B3QGWi+Ygw0VxKTsf0xxHQzKPgAD3kH/mcSSMKq2ycNjvHvrZoAPa9ceb0K2qdww4fQbK64GG0ye4dSBqki6GIcWXxyQw+rqUaqouk1CP2clz+L4Ckihb9IRB0gqv2+4WqcxnalXf+DCrtTpzJyr/kOF9clVWREPd7vCQ6KYn6avRWuth7q74RrUAnhCvaX1XQNIIvEixr5vWsy4pWCMa1b6eFScfkDKD7SispzWVmPp1pAuArF8sgsyRMsD31M4qhwmz4TTWLXQdYZxNXI/llKwFFWWCvAFWDB5NfXfrC5+Vbj9t0vTjW2kM85IwtbzQQflm+xbfHTgHHkDYcsJGn8FF/9H6gfSKL1SUYVFVpDbS1cD5dtI9hAfGi+9r5xHzcKlYOfCMnQhOf4rplay94nWjvepeKD79PBJdpINscvqxP08Ij32dif1oOUIhPfN53f8b3m7AGzTYrvZVI8TFZ/ivX+Y7O2IZTd3GyjviYx1nXyGBzYdkPf0CmV6EFMxDhvnzyCEiNflU0cMBx8dChKFkJKDInYi5LApCe/d5pubqVqNG71hHXAylUEoQK5XpAUttkfckrD+ufs408lWL07hHsz7OLnhccLsJTcYU92rykXrF8i2D+yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(30864003)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkkfCnOtQ8EUbUxnaVBuYXGpzJcpZzDgAnT70Re8LRwNEIovikH04okDTEab?=
 =?us-ascii?Q?bUWHhZjVut6vUUK89CQ40s0r97PJxoFj+a57vpC+5MZnZdb+lyOctW5WMEjA?=
 =?us-ascii?Q?eAFA/Ip9A2wKVJexWoeaokWQtafctnKZGTwQs4M1s+YTaE8mPNuDolQo2qmk?=
 =?us-ascii?Q?yj9bYRV7GEC2nYAFbN8nFJhYkVBRVHqR13WIDlgLL+dJGpIviIW2oq+xJqf7?=
 =?us-ascii?Q?EiK60CH39DXSGvcMqgoXe1ECvUeBut0OFnZz/xMnFJWXHiMgbewxcjLci8hw?=
 =?us-ascii?Q?KxTVAIJjpxmXOLEvhOr+Z1ZrXaSv/jkW8jdKNgk2ATh/ocm8zTfs/6VkDwiF?=
 =?us-ascii?Q?rCdtw/re+zxE8XIaezdfV444XwNRlPH1jQgM/d+b5m2E3+dLk2Dkoc3b58o8?=
 =?us-ascii?Q?9Lhw0PgqnG7bY+d90JVJSRBx9SYR6MIZoZ9c3LeeCaB7qVe0W4zaDddQ8N2C?=
 =?us-ascii?Q?CYCBifRqSwIP4DW9asGMrCRnMllbcfxVKGkOOtxGpJW/oxDL9hY+yXp387zK?=
 =?us-ascii?Q?hIrUsgFqaQ7Hi/tpymQaQOfMgztNJFyKMIBMJysfDvMecJYen3xRzBlQ0jx+?=
 =?us-ascii?Q?mKrU0brNXyC419g/oKcK+7a3TVV2wl9KOzUztK7qETA6GyNu1GyZFOonMvLa?=
 =?us-ascii?Q?YVR+QueUS/zBZMjr20L5fPVJfvc0+zDE1oi6A8FNwzjX+l2KCLQtZdWgz6Cx?=
 =?us-ascii?Q?fNXaRmGVK8xUDlrkq1NB0/nliahjnpSq5aVW9L9kuNr6u9NsPgSFK0weFmif?=
 =?us-ascii?Q?KdOcWnvTQiD28pbgKgMnkvEfdvm48HJeQvS5ojQVda/udQ+NVwGAIkMBjFLD?=
 =?us-ascii?Q?vQTaQd3t+I7xRKwkT0K0H5Gt/ow6BJBwqFuCwtJ/7UVBa2wcgdaFMyJYXaje?=
 =?us-ascii?Q?VhvxnhLVtTPgukpHjiMYx+S7t+AhGnigU45SOx3N5sw16c43DT6pWHlifmsL?=
 =?us-ascii?Q?NNp3rq3yFwTyP0zze2JrLvBbXSdtE/IIjRVDKcSXXqZwZdr15pAr+dfkuyZA?=
 =?us-ascii?Q?taVV368BYQnlI9Is5rUWZIYoB535wXdUUatBe6CVXn/DfUM8XHPD7UP/VXCB?=
 =?us-ascii?Q?Ne+3U8PsBvj8C3gCT63NmYP+QCRQb9Aapx1p9rabd1NM4+zY4vlYUdCZtBdo?=
 =?us-ascii?Q?TY3lJqNjtxcvi9CwRBARMOCd0qh45p4ip/B2CQ5Ss9GFHlLz1Q1I08IMAr7K?=
 =?us-ascii?Q?hEyq/3S1L93J4d5AwIs+rdX9QMl0Y1aQtvXq8dq6w5hnjw6fFtYjiX2fyLxZ?=
 =?us-ascii?Q?XGv6miO9AyOQXcxAuWwd3+DRej0X8mVXXnKpItqcU6FSlR3j12R5bLdufrQl?=
 =?us-ascii?Q?iFS3zWbNB5MEchWWLrjEL4SavpacnlkVhzbCBVFFARyXmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa13decd-c862-4490-6c03-08d956a2721b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:34.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyKjvgLv6r7sANwWQ9FfTo94l58Q4uTN8IS1OQ3ZmQZ95RFNWeD1o/oxvIbHql25aKQUYDipd4p3/VoeLDYdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-ORIG-GUID: v0IHa345aq6OquZgFiUu9he55DnTirS-
X-Proofpoint-GUID: v0IHa345aq6OquZgFiUu9he55DnTirS-
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The existing mechanisms in get_symbol_pos to determine the end of a
symbol is an inaccurate heuristic.  By passing nm -S output into
scripts/kallsyms.c and writing the symbol sizes to a new .kallsyms_sizes
section, we can get accurate sizes and sort the symbols accordingly,
reliably sorting zero-size symbols first (on the grounds that they are
usually e.g. section markers, and other symbols at the same address are
conceptually contained within them and should be sorted after them),
then larger symbols before smaller ones (so that overlapping symbols
print the containing symbol first, before its containees).  We can
also use this to improve aliased symbol detection.

Emit the size info as an extra column in /proc/kallmodsyms (since its
format is not yet set in stone), and export it to iterator consumers.

The notable downside of this is that the new .kallsyms_sizes is pretty
big: a PTR per symbol, so vmlinux.o grows by almost a megabyte, though
it compresses pretty well, so bzImage grows by only a megabyte.

I'm not sure how to reduce this (perhaps using an array with elements
sized to be no larger than needed for the contents, so that almost
always two-byte entries would do? except that in my test kernel two
symbols are bigger than this: sme_workarea, at 400K, and __log_buf, at
100K: the latter seems often likely to be larger than 64K).  A simple
scheme to reduce this would be to split the sizes array into several
arrays with differently-sized elements, and run-length-compress away the
zero bytes -- but that's not implemented yet, and might never be if
people think the whole idea of this is pointless.

In the absence of a way to shrink things, this should probably be hidden
behind a new config symbol if exposed at all, and kallmodsyms just shows
zero sizes if it's configured out (but this is enough of an RFC that
that's not yet done: possibly the benefits of this are too marginal to
be worth it, even if they do let kall(mod)syms consumers distinguish
symbols from padding, which was previously impossible).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
---
 include/linux/module.h  |  7 ++--
 kernel/kallsyms.c       | 74 ++++++++++++++++++++++-------------------
 kernel/module.c         |  4 ++-
 scripts/kallsyms.c      | 29 +++++++++++++---
 scripts/link-vmlinux.sh |  7 +++-
 5 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8100bb477d86..8b5d1a7f6d9e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -579,7 +579,8 @@ struct module *find_module(const char *name);
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -756,8 +757,8 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
 }
 
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
-					char *type, char *name,
-					char *module_name, int *exported)
+				     char *type, char *name, char *module_name,
+				     unsigned long *size, int *exported)
 {
 	return -ERANGE;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index daf0c763da24..197370f5154c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -33,6 +33,7 @@
  */
 extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
+extern const unsigned long kallsyms_sizes[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -254,12 +255,24 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+/*
+ * The caller passes in an address, and we return an index to the symbol --
+ * potentially also size and offset information.
+ * But an address might map to multiple symbols because:
+ *   - some symbols might have zero size
+ *   - some symbols might be aliases of one another
+ *   - some symbols might span (encompass) others
+ * The symbols should already be ordered so that, for a particular address,
+ * we first have the zero-size ones, then the biggest, then the smallest.
+ * So we find the index by:
+ *   - finding the last symbol with the target address
+ *   - backing the index up so long as both the address and size are unchanged
+ */
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
 				    unsigned long *offset)
 {
-	unsigned long symbol_start = 0, symbol_end = 0;
-	unsigned long i, low, high, mid;
+	unsigned long low, high, mid;
 
 	/* This kernel should never had been booted. */
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
@@ -280,36 +293,17 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	}
 
 	/*
-	 * Search for the first aliased symbol. Aliased
-	 * symbols are symbols with the same address.
+	 * Search for the first aliased symbol.
 	 */
-	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
+	while (low
+	    && kallsyms_sym_address(low-1) == kallsyms_sym_address(low)
+	    && kallsyms_sizes[low-1] == kallsyms_sizes[low])
 		--low;
 
-	symbol_start = kallsyms_sym_address(low);
-
-	/* Search for next non-aliased symbol. */
-	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_sym_address(i) > symbol_start) {
-			symbol_end = kallsyms_sym_address(i);
-			break;
-		}
-	}
-
-	/* If we found no next symbol, we use the end of the section. */
-	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-			symbol_end = (unsigned long)_end;
-		else
-			symbol_end = (unsigned long)_etext;
-	}
-
 	if (symbolsize)
-		*symbolsize = symbol_end - symbol_start;
+		*symbolsize = kallsyms_sizes[low];
 	if (offset)
-		*offset = addr - symbol_start;
+		*offset = addr - kallsyms_sym_address(low);
 
 	return low;
 }
@@ -569,6 +563,7 @@ struct kallsym_iter {
 	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	unsigned long size;
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
@@ -603,7 +598,7 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
-				     &iter->exported);
+				     &iter->size, &iter->exported);
 	iter->builtin_module_names = NULL;
 
 	if (ret < 0) {
@@ -676,6 +671,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms
 	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
+	iter->size = kallsyms_sizes[iter->pos];
 	iter->type = kallsyms_get_symbol_type(off);
 
 	iter->module_name[0] = '\0';
@@ -794,12 +790,14 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
+	unsigned long size;
 
 	/* Some debugging symbols have no name.  Ignore them. */
 	if (!iter->name[0])
 		return 0;
 
 	value = iter->show_value ? (void *)iter->value : NULL;
+	size = iter->show_value ? iter->size : 0;
 
 	/*
 	 * Real module, or built-in module and /proc/kallsyms being shown.
@@ -819,15 +817,15 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 			 * /proc/kallmodsyms, built as a module.
 			 */
 			if (iter->builtin_module_names == NULL)
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->module_name);
 			/*
 			 * /proc/kallmodsyms, single-module symbol.
 			 */
 			else if (*iter->builtin_module_names != '\0')
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->builtin_module_names);
 			/*
 			 * /proc/kallmodsyms, multimodule symbol.  Formatted
@@ -838,8 +836,8 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 				size_t i = *(char *)(iter->builtin_module_names + 1);
 				const char *walk = iter->builtin_module_names + 2;
 
-				seq_printf(m, "%px %c %s\t[%s]", value,
-					   type, iter->name, walk);
+				seq_printf(m, "%px %lx %c %s\t[%s]", value,
+					   size, type, iter->name, walk);
 
                                 while (--i > 0) {
 					walk += strlen(walk) + 1;
@@ -851,7 +849,13 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 #endif /* CONFIG_KALLMODSYMS */
 			seq_printf(m, "%px %c %s\t[%s]\n", value,
 				   type, iter->name, iter->module_name);
-	} else
+	/*
+	 * Non-modular, /proc/kallmodsyms -> print size.
+	 */
+	} else if (kallmodsyms)
+		seq_printf(m, "%px %lx %c %s\n", value, size,
+			   iter->type, iter->name);
+	else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index 927d46cb8eb9..0229d91241d1 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4332,7 +4332,8 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported)
 {
 	struct module *mod;
 
@@ -4351,6 +4352,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
+			*size = kallsyms->symtab[symnum].st_size;
 			preempt_enable();
 			return 0;
 		}
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 93fdf0dcf587..fcb1d706809c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux
+ * Usage: nm -n -S vmlinux
  *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
  *             [--base-relative] [--builtin=modules_thick.builtin]
  *        > symbols.S
@@ -38,6 +38,7 @@
 
 struct sym_entry {
 	unsigned long long addr;
+	unsigned long long size;
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
@@ -394,6 +395,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_addresses",
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
+		"kallsyms_sizes",
 		"kallsyms_num_syms",
 		"kallsyms_num_modules",
 		"kallsyms_names",
@@ -507,10 +509,11 @@ static struct sym_entry *read_symbol(FILE *in)
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
-	int rc;
+	int rc = 0;
+	unsigned long long size;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
-	if (rc != 3) {
+	rc = fscanf(in, "%llx %llx %c %499s\n", &addr, &size, &type, name);
+	if (rc != 4) {
 		if (rc != EOF && fgets(name, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
@@ -548,6 +551,7 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
 	sym->percpu_absolute = 0;
+	sym->size = size;
 
 	return sym;
 }
@@ -932,6 +936,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+	output_label("kallsyms_sizes");
+	for (i = 0; i < table_cnt; i++)
+		printf("\tPTR\t%#llx\n", table[i]->size);
+	printf("\n");
+
 #ifdef CONFIG_KALLMODSYMS
 	output_kallmodsyms_modules();
 	output_kallmodsyms_objfiles();
@@ -1189,6 +1198,18 @@ static int compare_symbols(const void *a, const void *b)
 	if (sa->addr < sb->addr)
 		return -1;
 
+	/* zero-size markers before nonzero-size symbols */
+	if (sa->size > 0 && sb->size == 0)
+		return 1;
+	if (sa->size == 0 && sb->size > 0)
+		return -1;
+
+	/* sort by size (large size preceding symbols it encompasses) */
+	if (sa->size < sb->size)
+		return 1;
+	if (sa->size > sb->size)
+		return -1;
+
 	/* sort by "weakness" type */
 	wa = (sa->sym[0] == 'w') || (sa->sym[0] == 'W');
 	wb = (sb->sym[0] == 'w') || (sb->sym[0] == 'W');
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 00ad1b4b0055..85a2754fdb6a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -288,7 +288,12 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	${NM} -n ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	# "nm -S" does not print symbol size when size is 0
+	# Therefore use awk to regularize the data:
+	#   - when there are only three fields, add an explicit "0"
+	#   - when there are already four fields, pass through as is
+	${NM} -n -S ${1} | ${AWK} 'NF==3 {print $1, 0, $2, $3}; NF==4' | \
+	    scripts/kallsyms ${kallsymopt} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.32.0.255.gd9b1d14a2a

