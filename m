Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C7C11F66
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BED613C2
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGIW2o (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:28:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhGIW2o (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKpCA028048;
        Fri, 9 Jul 2021 22:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=Y5uCVMXB9waiitnhSvLKZ1cs4mQUfxOxJGtYIGqEORJhmhJ8xlhqHS4WfpY9gGKeBa2a
 DRdzUrcHTPOc0z/ztzWEMRcWtmhVlcWj7cTPeJUdttd0rAXjfrbxuIxnSLpuUYZSgbHA
 M3MOXFU72iKyfItA1ARMjjYkpt1r8Ka5m6Zpmi+HYCf4DJ7nQ3Ohn6KZElHszofu/Qvx
 e1XnBAu7lKqrXXxr8CuQE//r8l8puNkbMd7Zk/180/31uniXCIQSD+Es3/zQFq7lgu06
 noHOytJVTParJeI3E3ddXh3swmjTJ79QVYjQF0JnIyVKerReumzjXFK2d7CQVMcJplcF SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pkn49cjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MKHWv057355;
        Fri, 9 Jul 2021 22:25:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3030.oracle.com with ESMTP id 39jd1bypkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmjcfcLDAiH9J+AN8q0bzWou6P5MczGgf77KXQ1dAMC3c1LJGulylYUTFpvGqw7ye5cPpr16W1/+0ld0AGZaPzTo8uV6/uQhYQDiPq3ED8q0w7rDALb1bpg+Mr7oMERURkcglOEfhW5XVZBtW1y8Xd5Dv713djSBQmWCDLbMv2GJMNzzUWMXds3VUHURknOa0qS6atRmjsY/xWw7afg/eEJvkPck79gEeRVohKhu3p+0iQmoFuN/9v+RJifzzYs/dNLBIyKgSXSsYL1EQGDBv7ItqdKMbcZ6gm4Zybg5YfZ9dUh1TCa9W19bPWN8Noh++2lRpvOgldzvJXwRrKdJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=l1+RMWsVNZj5atPnB85elSIqjuEamngb833c2pceDRyrVXDJMYqv6aDZ+nYTvqJEpty6K0aOFxINXLVYF8AX5s1KhUH9iA+PmBrauh2czkzfxszB0RJnUh8iAsgXpUA+TaP2nPC46ZnfD8yV8jzrwhYaXJG/GTgM54XYiw8KrAth6SNrNGL91InBvwPxWLvYTPnAXVGD0242Oc6ZE6W2qPF+xkvItPJkJlCcZI1+OgLIGpK0t+7iC+NF9F0eLXJ68IS3L03JtKy9qxQgUeXwInboff9bbmi+yI1z0wJiU+QFD3rh9bwcmXp3z6oWSpBC6dXPIKf4SJUHHfw1bJpkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9nNKGNRU6sXJsi/IiNkFPpEPjrixJG72xyFEQj6SMs=;
 b=V2xSrOMBSgBhjCDP+AHlZDo0hel6Rw+7EmIoUcIXVZLgQidDCOoshWFJ5AFWoV/SN2MaoUra/Qp/KI41USFHu+kGKorkXrDzzvS6v6YBD1agOHFgwYBYC7HF1Xgq8BeZtfPI2w3hglkBDpY2h6+O5kQU3QxWd1Uz+pKhyyn6zao=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:53 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:53 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH 2/7] kbuild: add modules_thick.builtin
Date:   Fri,  9 Jul 2021 23:25:18 +0100
Message-Id: <20210709222523.17639-3-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b9435c3-575e-48e5-795a-08d9432883a8
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2927A0303C85C5C91020F3DB8B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRa/1izBQIom5HUL1QgoM6LfFvyM41iTJ3+MmNwJ+aEKxkuEP+Ej0rCj5Xcl5+S5ZHdDaV4G0ayGXkCwnPb9nIleYQFT567C88f9QmFM29vzqi+onI97Qhxslnjmepf+iVrKO2QrKtS2UIaHHfDx6pyIUsJFHAeVzy4aB5YWEN92Oh97jiZgaUQSGXuneU1rAL7GeX2/mD5BzHVKSb+eeXFjvf6C3gnax1qLpmB9ruwzpLxIZS1w6qsteABxZt8fDsav+772ufcCOEYTEeioIKF3Vbf5oFVctKk52goRzaZ/b3I8jkaAW0EWFdmCCI9r6Y30bVPNuouUYUKozLPpuyy4OoUOR+ALnPuzDA9v/qpZxzEPB02kzx4aHh8PzTqe3PQ7ZQ2NFgHZOMDot90rKrsUQbXDdVRTEa13iLw1L7hErEcLMOmfOJYXccH4mfIH2bPbWysXaNDJShpJJnc5/HGd1AmqdQbQGZi0tRhGwfY1N+HOyQZ4RD2hp5cWdr0Hiecgm3MTGw9fytXIjAaz2YDTTAmM0uI7YFh4DYFsbh0xwsKDDhvRZL6nzci5nCt5KFV8YfWfYNeD4HouJFU7Ph4CZiN7otfyEYjD/+ItBGGxrPEpeU0cnHj46GQa7JEfqZRaDXeF/qxi4yE3phB0lp8d5mLA59omxdNAa0qpeUiS3S4h3A0/xAAw0TC0g+i/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(8676002)(83380400001)(2616005)(66556008)(6506007)(30864003)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP1/hBJwdALgNPWB0qPBfOkDdRWUy3WexFVs4Itd6a33uyQsgK71eZRTJpU9?=
 =?us-ascii?Q?edlsujKHgxHKiss5L9Y/rY0R2WzB3LEswC3wWROMUrw7szzcNyWmr98dLl7l?=
 =?us-ascii?Q?Uh3NVfWKbz227OzzlElwY4c0gykkJqXpsF1pq+UDFv9DoTDlfMbvFOzOMjj0?=
 =?us-ascii?Q?9aESaESlyaqN2AX8koBC6hpPfuz9i1u5CdfRQ22BqCqMO3UTVwHpLfyPcJuy?=
 =?us-ascii?Q?TYajKXprxQAJjAxJSix5XNNYlYtunlRlYVOgOUU8AAHhTz3R2Yilpkj+rwIt?=
 =?us-ascii?Q?KrfVavuTLc0G7HsE9LMcvYInzGrtPF0cBhpGrLmlv23Ct27KVyp83cvHqzkw?=
 =?us-ascii?Q?7Y5/p1ErJ2RYuivwaVzj9MSMCoJuP2TOpedQedvt2PF19EDG1WTQK5wZvxhW?=
 =?us-ascii?Q?K0+TjfTdrsn7BLq0HRw/2PL8IWaGKZVLuN0WAkCRiZwgPnLKW++I673t/U5I?=
 =?us-ascii?Q?cz/29Vb2PADJCzm0JtpRkR3vDzDJwRrlO674D7qolROq7o3XhF4UwUflGoh3?=
 =?us-ascii?Q?3jHk9WCBhBlzXanFAdAnniTwENgPGWgHQ4OyhMOtoAbvl0HSOMNeHHFklVIB?=
 =?us-ascii?Q?hvpkEi74Qn3KvPWcxtNB4Ch7jHE39fnLg0ERb+CT6Sw6u5UNX/g0HKoIDkbN?=
 =?us-ascii?Q?LyTkDEmHt+xTpCgJTy76uRn2wxYnPcYhkVrtsWIzGPiCaXBmEmHdOSptFq1/?=
 =?us-ascii?Q?oqLmW2kzRQncNHTF66OhhsXMkuaRdAuXp0TlPg+uzcbmLmt9OV08bi3jnbGi?=
 =?us-ascii?Q?JqWFs5QUDVYCOLQhsCS5SF75xGrgBqlROlkoPsaDI+oh6UmvtrbCCop98FUJ?=
 =?us-ascii?Q?bLaSTJo+mYPLLobuPRLIrtTTFvm/Hzfun97ICWpBon/A52qlLhY3aCeN+c6w?=
 =?us-ascii?Q?Z446xBo3CchHJBCwSViBBzn4d7UKDkALTLg/D/ogKv7htsLi6Q6E0v1rosv1?=
 =?us-ascii?Q?UJDJO3z+f1uRBDnvOEB2cMDOIryZ4f55Qv22jzCkf3OxG9vL1tdlzFW353vb?=
 =?us-ascii?Q?YpF+45bXaxj/qgyUeobHZZuZMyepYaO3WQ+G+UgV6/tU2DOCrCWvO9U2pGk3?=
 =?us-ascii?Q?Dp2DuZ6ne80jJwktnTjouOg47VBWqmbBO+TKn7OXxVul7chBAlPYb3gIAVza?=
 =?us-ascii?Q?nz5h/tZ3a6FLTfMOOnczxKfFgVDzPCu4WPN0nqd0DTTv4UcDw2vPX+hty9gm?=
 =?us-ascii?Q?LVgvf0JLcGp0M6FTEHFYqnkqqb1pXK5abkUAeSlDpxsjMYr3IIMech+Yl8bE?=
 =?us-ascii?Q?1j4Jf4ae5RGcS/zLopaARJ6vF+NGiflyNyb30bRn+enpa4rCasIFr2dntWTY?=
 =?us-ascii?Q?evrH8f/xYDVal5U3qZ/hVQj0+/dLWDD1ItrMdsTjZEVvlw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9435c3-575e-48e5-795a-08d9432883a8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:53.7469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grejgEf2QxvE7aMaIOsNmMBi8JQe4seVKqa5Gc1C/ytbu/0OtLGLSFtHvUB4HVMl7jpaPIMMtSe4NViDs0IBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090113
X-Proofpoint-GUID: bY5TIW7aKsRSi2ExLI3qg5IHQrhe4XzQ
X-Proofpoint-ORIG-GUID: bY5TIW7aKsRSi2ExLI3qg5IHQrhe4XzQ
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
index 0565caea0362..94933f01fd95 100644
--- a/Makefile
+++ b/Makefile
@@ -1496,6 +1496,23 @@ __modinst_pre:
 
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
@@ -1865,7 +1882,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 82dd1b65b7a8..b8cc96cd8a9d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -73,6 +73,12 @@ endef
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
2.32.0.255.gd9b1d14a2a

