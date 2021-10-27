Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC065C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBC260EB4
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbhJ0RuJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25280 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243375AbhJ0RuD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RHVEZE004973;
        Wed, 27 Oct 2021 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=TCyH7RRipclNFWLj7lUUoL3oxRNkoyJ0Cz8G7cSdjJZZ4aLf8+15tJ7XwkfY0AOTTsFf
 lV0IxZaoC00gTshprBnercqjyp5tPfjvgn+Wu1NK8th/cwe28Ry5xVz3aaqr6wkYqoYJ
 PcHCUCR1EiIYfXvvlWG5eL6/4diaqMpt7h+W5gcaQpNOxyv+/B3jKoZpPaR53faaU/dw
 Ss0YDLKlNUchuckyjSi2Jm4af2fwYy36gJu/Bcmm/16veVgboRXSIyoFe9TJKnHVsysA
 NXKH+4OwcUbxHdeodZ1r2K31kTvOSUL+XWOEX8AIL3dty33JRwTXKEUVKy/a7tgUZTdK wQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fj4pmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHg13n049457;
        Wed, 27 Oct 2021 17:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3bx4h2ruat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErBeXfMai58U/gmXuX+6jjAvn1MXmBnZHzGCwF0NDBWVEdPqXLDU2Ovf0wZS3SsiPcSKoSay+Yqtm11DcbNG4otdARTHklkSQIgxDcqr3Dxe0INHUmKpP+KDi//E8rYylw5t1jK1nvTQJL+kUgTpHLM5CGdx4wX9QoqkzeQM1S25nPQ8ZM7l1VzRsypuLzNOYVXYHmIJeBHcMafe6YIRvZYDC0zaTwPNwDpOCRMTRERRA0zdLCO15QKzUd1ptGXSVkCNuunI/iPHG44j4viwYCi2PA479iniZqN2Ehlk/QQqUSFMVA9sUVqm9k8+OTfuVn9KbS6MGGudf7FO9ibSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=LPD02lIcV4qumdDbZKY0ewyrW9xcvxcs9R8jXx329Qn3fz056uSu3EWbGcsA4pJImb+6uRBx/D/qBz7lJF26KSpES58js0Ghf57/YfZr2nYXSq0aVCZqgoRI8saGjFVxGRLT/tih+d/H9nQnflegeo/AstvjBPHJCrAXXCmdroU2MmKTxw9nesGDk9UFSM87yPMTypzZg//3pPaT907/3pc2RmzgWOkqhQvc1tKNAeQHtJ8AjsDxpwIIq85UTtLtdwJc/SCxrSZfvuFurMRrMnHwtxw+VrWFsPPGyfgCXySEJyNcm/LWRx5VvB8lZYYAZY7XJom+TCLECLYOuXliEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5os/ALLZ3fEQlkrlXWMgkJ1BX3RBm/OcNXMhTN5u1Q=;
 b=TqtqBrSMF7yzPJ/frBElT9TrgeAWHwyq53ZkZp7kS45Qe7AhXAwVLMfuTPAQ8rD1QejLUHWXI+yr6406UENJW7AvZ2p0CV85x8paj1kwITenQekYYdLac5SZ5u1alGL0rvOfkXpWeWG5E++vbhMBeCXXxojmkSphzeko1GyHKuc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 17:47:30 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 2/7] kbuild: add modules_thick.builtin
Date:   Wed, 27 Oct 2021 18:47:01 +0100
Message-Id: <20211027174706.31010-3-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af658b01-305b-4201-0323-08d99971d903
X-MS-TrafficTypeDiagnostic: SN6PR10MB2925:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2925BD1846806D001EEDCB3C8B859@SN6PR10MB2925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmjSjluGFTr7MU74JJjULPfuMs67WlQQRD0dFwCZ9Em5tkOYGz1blhI9jbdGChWzOFwBssPyb5T0ifhjtEtnkiGHWLQydYiU6+rt5Xf6D+YoTehGxAf0L4uM1NEggNxy4Y8Upl9ktAlw49ykA0yXIzVIEQQ0d0XWObkoEQVA+ZPs3hXZa3ZauyymFqhfFMcZLTW1ntm7JOW/603s7DOlvILhGqh68lHWHfO+DlQ/PUROUAl4jrDpLuu3PvchPEVwbIa0gmY1s6mAr9duO1u658GC0zsOJkwszv3nd3fD5csVpjXCo0hew/G0kp8PH2wz6lbvqrlq4nDf0Af44O8djaqfwGLqywDsuWMWF7PhQdNhDJLB1RglfgQblwfFWd3Ft1XBGF24aTrsVwUWO6Cfc1UXFV4EXOwcuO1DcRdr8vjaMYeEMJB+ax6KRGXP6SQAzVmwmbrZHKTyGCwAoChHt4MmzzugXcGRAZgFu+e2cRRNad4njsiDJglypJa+oQZHsCKak0jTPZmAEkZ/VzDd+xzZ0Am75yx0+eKBSYcLfUEK5XJ+2V7jJEtw01guc0U3YKBJaAPb2p2TkYpwMHTWjlpU6lB5MWCO70XvcLQxjc0hyCodAMO+D3FRtz40H8r7NLY86YO2QbGWFzoxS0+kFLQkP8geSxqsk+XrGCtu1pP+qGqHSVsD2cqA7hPxYx3/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(1076003)(186003)(66946007)(86362001)(44832011)(316002)(36756003)(38100700002)(52116002)(6512007)(107886003)(8936002)(83380400001)(6666004)(30864003)(4326008)(6486002)(508600001)(6506007)(2906002)(2616005)(8676002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPvDX+wEpN/Crvi2b1NPVEB4jWkSp0uxP3cWqKLsSIx3wJ/1cGlJIsN2jsID?=
 =?us-ascii?Q?ViFj/WYcWf62FJgWDUNjOwqNuIWy1M01Ddm3ivlTKi5RXZ13OJcrgDhQFyM7?=
 =?us-ascii?Q?pfF4N8V8RNvPflpNwgk0sGf8liQFlMOPMwqMejiwnFN3XlBgbkcbrZ6hfPLR?=
 =?us-ascii?Q?GeNZ6qrX7o1U59+KigDDx/RcWV7NoXEUh7WYR/D1TU1qijTLMH7EFC/Q920w?=
 =?us-ascii?Q?8gIO+AhSqoJHXA94ktTWMHHyUkvdGsuU+bQFiXLBhIZKlP+rfjOk6AEUVJEt?=
 =?us-ascii?Q?TZErxR/YMIP7wU2NRpX1EGhVqZjCydH9qdRgF+hVHENFkEPYwNrz7N68fIJV?=
 =?us-ascii?Q?uhPPIw7pz5XUyfzI5069lDbu/Pr9woDyNxsx4w7CoFW8NVLhdsL+ClzHO1Sp?=
 =?us-ascii?Q?wskp4CcwDlScHSbbySF55VfDLaBKmehCAs0aBa3XvjOQ1S8Q/8m0N5W2jYNt?=
 =?us-ascii?Q?L0nntJKzW9F8NK1NfJnQPAjdipk2XHSPecjKV6cX8GvabMxdGWRKRVr9atsM?=
 =?us-ascii?Q?o8VPgDpXbgf3PGYoW1Q2Tcx1ONTATT97wiGjfI/q+h7XDznN70pW9zPhYiIH?=
 =?us-ascii?Q?6uMzadwL4oA7vLbA1aykIrLUgrOqpKJUjj2TNY66j4CR1Tht+SEt7+TCjpAS?=
 =?us-ascii?Q?8S5fe/ZGHXB3QM2kwjPm49uenlmzSoESAOmyspFdz1dgUwKUCvhZ4mEpwRJ8?=
 =?us-ascii?Q?81Tcc6qQMhJefWrJSSPmiGECgSZXlF18E3fx9SUn/RM5b8KTv+DO3bARYAMK?=
 =?us-ascii?Q?LSB2xavrfKFvI0CEoacOQxyG2+3KQSQTmvMhwHvht+izRUdH0VXjK9HZtVxx?=
 =?us-ascii?Q?5lOq1A9NJ27XKbALqmKbxiySywaODNU2aJ6kwVTLap0pJBa0hY6ikMvCD090?=
 =?us-ascii?Q?Y9RRj+OTSgDfD5mz3fJfk0vjOCDm320+7YDCuXNF9CtDvfmOgt9NWPilMAVE?=
 =?us-ascii?Q?nhmQU0e/MpvR2FlLxOOmWiOQON44f7c2mWMb2xqV5iLjPgcpA9ou7Kuzw/dF?=
 =?us-ascii?Q?FPi8dnmfQdmGMBOdGkLLzAgTUoMiN5Fcklo3Z8UyZ1nuYaC0OVjex8lRdth3?=
 =?us-ascii?Q?gH5eIpWrr9eHh09szotcpkd69+savrno0n5X78jUJq+SePAQcVc9jGZYH1CF?=
 =?us-ascii?Q?5EtjJP/KOPJ9TXoSEvL4dQYwMDBmILHWlKWfdCv5k/eQNKMqATD9u74AHzvv?=
 =?us-ascii?Q?8BOkgAgizoL5VFs1uiYc59mMN2sB9p1OmHD8KROLCE3lorEqCaOD4jguti6V?=
 =?us-ascii?Q?yngGn24rR9D9m8F4sa2oNROOwWzGNN41nzO5c7TXxw02MytI+6JZWMFFBWTa?=
 =?us-ascii?Q?voXnF7tuS5eMA/8RnIMoEQWZd1BzI19hFVIulHaXXLJUGDtyYlVKS84u7XOi?=
 =?us-ascii?Q?kxwzOMFYjtqOeRwiFhHp2d5ZC01/LYjKradEhIZ6BCSwXE7CDfO53+wDU4Uc?=
 =?us-ascii?Q?sexXba3EgFE9OcuiVNIKDIu+dbphTMwNxFW5TvgMi7cg7u6e0DWtQmsxZ5yc?=
 =?us-ascii?Q?4Epd0k+lw9eNp+PvQp+M5ldAhHkRbLc1G9x+eI+fV+v2dxxWoPcIyQ3WjxM5?=
 =?us-ascii?Q?zgYq1CrtSsEp7icWKMkG/djf/rQTyaqHLPOYCY2qmqjYKaa6CYgN921Um6d+?=
 =?us-ascii?Q?QxfUcBgAtbshsFO4lA0PpvvRPR6s84o1e/mvd1eX7PPF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af658b01-305b-4201-0323-08d99971d903
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:30.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPR/g4+g13gkJdd8iuyKKsLBKuCpTok6jifhf+f2o7d+EkJnnuHdKO14f8l1yL+t98MjUYYuXwpfmhcFzq3yNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270099
X-Proofpoint-GUID: CzaSKRroAFaluN5LpTRBnuLi8a-zqSL3
X-Proofpoint-ORIG-GUID: CzaSKRroAFaluN5LpTRBnuLi8a-zqSL3
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is similar to modules.builtin, and constructed in a similar way to
the way that used to be built before commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
and recursive concatenation up the tree. Unlike modules.builtin,
modules_thick.builtin givs the names of the object files that make up
modules that are comprised of more than one object file, using a syntax
similar to that of makefiles, e.g.:

crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
crypto/aead.o:
crypto/geniv.o:

(where the latter two are single-file modules).

An upcoming commit will use this mapping to populate /proc/kallmodsyms.

A parser is included that yields a stram of (module, objfile name[])
mappings: it's a bit baroque, but then parsing text files in C is quite
painful, and I'd rather put the complexity in here than in its callers.
The parser is not built in this commit, nor does it have any callers
yet; nor is any rule added that causes modules_thick.builtin to actually
be constructed.  (Again, see a later commit for that.)

I am not wedded to the approach used to construct this file, but I don't
see any other way to do it despite spending a week or so trying to tie
it into Kbuild without using a separate Makefile.modbuiltin: unlike the
names of builtin modules (which are also recorded in the source files
themseves via MODULE_*() macros) the mapping from object file name to
built-in module name is not recorded anywhere but in the makefiles
themselves, so we have to at least reparse them with something to
indicate the builtin-ness of each module (i.e., tristate.conf) if we are
to figure out which modules are built-in and which are not.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  19 +++-
 scripts/Kbuild.include      |   6 ++
 scripts/Makefile.modbuiltin |  56 ++++++++++
 scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
 scripts/modules_thick.h     |  48 +++++++++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..b49cd96f587a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..6a78988547d0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 77062b44a4b5..880b3e67a47f 100644
--- a/Makefile
+++ b/Makefile
@@ -1507,6 +1507,23 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
+
+modules_thick.builtin: $(modthickbuiltin-files)
+	$(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
+
+# tristate.conf is not included from this Makefile. Add it as a prerequisite
+# here to make it self-healing in case somebody accidentally removes it.
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1886,7 +1903,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cdec22088423..ef68635831b0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -74,6 +74,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif
-- 
2.33.0.256.gb827f06fa9

