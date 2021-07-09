Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D24C07E99
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61B4613BE
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGIW2n (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:28:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62504 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhGIW2m (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKZNV022452;
        Fri, 9 Jul 2021 22:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=i7lnz8V94Ir+zfCWM4NCv5qikJBD7wi9BXfWtCGIJ/XUR75rgSaAVlrUFbxg/+5l5iIH
 D+JuMOSSU1EVAFkuNwH3GphCqyD0TDmmUbAMfr1Yh3pyKEhmfiNJSPCXIbofRvF4V3IN
 vH1gi3rgKnuF/yKbljswzR935XFlTuUEQ0GGPlFC/GBa2aWy17nI6sDN+0EC0c5kKkXS
 nkTQ6loF7JxWQ422us1SgIKovKi5EIfzxveHQUOVF7rpvkcOjEpxiYohmelwFI+Wy3d6
 bGAc6b6kXtO8Xl1WCKSCoXDOWkhQHCmkxV7DWzWzBmfdS1L467fpRg3isDFFpLs8s9UH FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgmh9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MOmJo072128;
        Fri, 9 Jul 2021 22:25:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3020.oracle.com with ESMTP id 39k1p6quuc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK9FpBuOtuuMDzubXQ+opdXHrbc1lg2yBN4/3A49Mso7nEIaPHeewuPF1h+fZsutyH5DiA8NjdBYrycJ9jYiOZEBPqbeAof0CKU+YWpcyzntAwMTSLXt9Iyuqc4LqcivsdJZE5qsWArp6wPgxyoShURkyWcPSYNqktAUA/fQgvIHtOABgHGtmID+ItZPheYKGOOJ9ANSjRKCBU94nqAFhLPpMUKwSmjFnEHF4FaNg7/Xiz8/nH+ilXxwl1aFR+Jc6B9CToGy64LC0FgDqXrtvbI9TRGW+s+gEI0g3tegRUfKhJOL32bS21CiZC83c4K0gvaTFn50ncH9cYyPprUTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=Hsui0VMOv6i1mr9SLgA+gqF0aQZLGMsV5JuNTzoxM1FODUVq7w7N0m6W65HHgH64eVZnR1cFIrWnjPCeC8PckHW/BVimyB0+99OEtjhxswZzCiIh113lmnS3gcM9aPiNpYHxxK3HxsTQ9bPsdW8FqCREgOra9+c0HraNpttEXcF1Vun5rnhsRNS9z9aXr5ii16BxWRruufMCWa3VDzTjlQXzel72NOucXJFEOx28GEHgQQSWeTh1aP7vJ1mT5RKreti5UI6OzdPQH0zooV8K7k2PwFE5aihSAbJA7w6UpPVQarSdX1H+J6Wmo/SxYU22iQClDPSnjOIBdeKNfqNJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=jNZ4W1yyWbZsho75A09cvskawOGt/EmH7aJwIMZlkxc1f8gpqsxW3F6EEWG829vskMfozKWrhux4XmPqNfywHVDk8ZsinMrpwXzaRXwsgP27oFSARMrJ33P3/pXTi2uTuYoqmGLYMZEIWI+Eazk+jDW2CNZcb4590HjTZNuQ+wM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:52 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH 1/7] kbuild: bring back tristate.conf
Date:   Fri,  9 Jul 2021 23:25:17 +0100
Message-Id: <20210709222523.17639-2-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e212fbf-379b-440e-a53d-08d9432882d8
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-Microsoft-Antispam-PRVS: <SN6PR10MB29272AC415E23E1E1542D9338B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcj4bqyhiB1MzveFbXqO0tOHozlEqh8PSWfZDa0qRwy30UAQYiKr44hdcwULeG+WdRv5v9z6sYWJQG1sOD58Kbv699tqHgLb6QRQEtwejCMB4akU0FwcBQLTPNoqWgco71nldnb+SRQX/EqrPxYX7XSDalkGcVdufums83XRrZ7smfZqQOTl6a1GS3JhmZt2HmUKtWXVBOjFbuwVp2DbbPrdakJ0Y9aVGh3yTdrkyohDPt44N+seQeh9Vbl7inBlMcEFMc+LB2duEHmXyS28lGSiAhO/8hLc6cUd93LRKFVb6EBskdDtj39/xlxlvzKIEJVJO0TNkG/QqyLmjS7eHU87ehu2z3DTV0tu8YcrfJxZl3TbYeo/QAlqNXSMfA6/WTx4kg+bwdmplQU1PpPSDf6YtQypu9aXluhI9t+amqOP/qqqvvs8xdifCQaKQj8UMFOv0DUXxTOhJm8cGq3BW0YxpaygfDL+cF88mBFuaQZex9p47y//tsaI1JfLLVBRCxb1JnptlFgsgI7G3JdrlxdTix1Bg2RHSMSZf+6J62Vt75Qc5Q6nGTKMKmWVIIx/sbpf4kHEy90AHRwnFSrvSFsl+g/N4yep9yvwORd4k62HG5W+Mcq+Wr3mVO5rae8Ed2m/cEUHKq2Rnmpm5GckxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(8676002)(83380400001)(2616005)(66556008)(6506007)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00VvuYQHHQJdwZ1fYw65WFbb0gvLhZKSXR6VnW/bzNtwPjItmd8gXlVUbMxO?=
 =?us-ascii?Q?dDMrOmpEOAjS18cov+UKncXy/NXADGQzILIvtiuwoSIYQypUiWNqOCkADDwG?=
 =?us-ascii?Q?NJTiBBpspEopilyO/acWX1Bn5rW7O9oiDh54DsMMuabCT8vw0Ft5mMbaoOqR?=
 =?us-ascii?Q?2heT+SRPdWQSmA7+8a5aiqhSnaf00+fEGZaZJ3XBT+GmMoe2Ya+kr+i+9Swc?=
 =?us-ascii?Q?JkYRptGyfOLBJXCXeVaAdDau8Q/fNWicMg2EeRu2rk+VarqyG7yJl+kvgVod?=
 =?us-ascii?Q?6SWGTU3hnX8wq2jzUszIklQiv1c07lfxnEcxUV2CFPiWJNse9ER1O54m2y9f?=
 =?us-ascii?Q?VcOnu7PjDPQkVoCxqgXeg3cIJQUK5QmEyP1daOvNCIMQpKpAyVPf3cyBNAbz?=
 =?us-ascii?Q?t/DtQqCKW30fRKhxGC+1zEnB9ceJyloTtkDgrOiBTeouwDXJk09eaUncpAnP?=
 =?us-ascii?Q?1kCKRuS2y+IXQbM0lNDPpBIWa1M/gY8HvNQRoQvHMmBM2Mo55ueF9G1b/jbB?=
 =?us-ascii?Q?10hRI2hWd6KaSsTLLgsNfw6QXZRExzm1GKywtvkpyEC0qlHvaFAYOGyHlsDa?=
 =?us-ascii?Q?oUDUMssvcTu50SWqZnCZUknxmE+kQr+aLk39fSRyqUXJejBIDlf3FBxDhPsz?=
 =?us-ascii?Q?fS5TQk0cQynUPkaVhl0Ht47pVmuImXs0MDzYAdKrBl8t8krnNePwwFPIWprc?=
 =?us-ascii?Q?/IUWCAkckbSFGgsyrT9Gf37aWXDBaNaQ6ThcA0Lr9talvw2ciDmH5t9B5t0K?=
 =?us-ascii?Q?6oJIEVSrVJC4JCF+cdmMwliWIsf/GVSGAcu9lVeV2gnRBVmXbNrwPCn7xhjt?=
 =?us-ascii?Q?Dxop1LeVB+sGWsL+FtrPHEqy6s+YZFT1gcRvyraMsKgwtSNjgT8hJyDN8bgR?=
 =?us-ascii?Q?1BSr2bWrtOcWUe7OBb3qESqpCIjiM2gfKjuevVNlHLSMfhhscdTHLKCVtZBo?=
 =?us-ascii?Q?m1+/AMdmuiBeYRtsYbH3LLLQDRNvsoaBG2SzR/D3/nxLNUT0TcR875+lbyMZ?=
 =?us-ascii?Q?5ubw6Ir3I0DkAUeV2w7hmD5W7xo/1xZYOy9rS0DsSvs5mabCHj2KExB9I8sR?=
 =?us-ascii?Q?vzcFx5HH26IWFpXuPqGuXr7al47sFYJVDTe/NTjVPOcSVuU5KaEffck0NHmJ?=
 =?us-ascii?Q?NfjgYBd7xEvrODhd2htn9ugOPPBT7BTYnV1jCsjpFRWbia72v/OPEr/UDBNu?=
 =?us-ascii?Q?oLzcn4TOim/Q6awKxP8TnW7/clWQ9sQC0h4igml4eYyiOIdzu9NZOu9dvFn8?=
 =?us-ascii?Q?SlQSSUZCbE3bET4m0aBePg0kCw8MCjmcO1taWmjMUvWCzmhz7lJXhImOc0kD?=
 =?us-ascii?Q?apBhpCO0zuKvUeUlsmzqi81aufDYB0lS4rAho8lc+7wnWA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e212fbf-379b-440e-a53d-08d9432882d8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:52.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOGDizm67KlZsit5VOSZ/lmvddfgywPFTa+ya8JTlXpIYNpT2AGcHjlx2AJZ1t8ddYDGHGtXDD4QiX7MSxbyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090114
X-Proofpoint-GUID: eyZDHwZakiekTCAB3xmCSFgjng9nHLPM
X-Proofpoint-ORIG-GUID: eyZDHwZakiekTCAB3xmCSFgjng9nHLPM
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

tristate.conf was dropped because it is not needed to build a
modules.builtin (although dropping it introduces a few false positives
into modules.builtin support), and doing so avoids one round of
recursion through the build tree to build it.  But kallmodsyms support
requires building a mapping from object file name to built-in module
name for all builtin modules: this seems to me impossible to accomplish
without parsing all makefiles under the influence of tristate.conf,
since the makefiles are the only place this mapping is recorded.

So bring it back for this purpose.

This partially reverts commit 8b41fc4454e36fbfdbb23f940d023d4dece2de29.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/kconfig/confdata.c | 41 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index cf72680cd769..8f4f1b373dd6 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -725,6 +725,25 @@ static struct conf_printer header_printer_cb =
 	.print_comment = header_print_comment,
 };
 
+/*
+ * Tristate printer
+ *
+ * This printer is used when generating the `include/config/tristate.conf' file.
+ */
+static void
+tristate_print_symbol(FILE *fp, struct symbol *sym, const char *value, void *arg)
+{
+
+       if (sym->type == S_TRISTATE && *value != 'n')
+	       fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*value));
+}
+
+static struct conf_printer tristate_printer_cb =
+{
+       .print_symbol = tristate_print_symbol,
+       .print_comment = kconfig_print_comment,
+};
+
 static void conf_write_symbol(FILE *fp, struct symbol *sym,
 			      struct conf_printer *printer, void *printer_arg)
 {
@@ -1058,7 +1077,7 @@ int conf_write_autoconf(int overwrite)
 	struct symbol *sym;
 	const char *name;
 	const char *autoconf_name = conf_get_autoconfig_name();
-	FILE *out, *out_h;
+	FILE *out, *tristate, *out_h;
 	int i;
 
 	if (!overwrite && is_present(autoconf_name))
@@ -1073,6 +1092,13 @@ int conf_write_autoconf(int overwrite)
 	if (!out)
 		return 1;
 
+	tristate = fopen(".tmpconfig_tristate", "w");
+	if (!tristate) {
+		fclose(out);
+		fclose(tristate);
+		return 1;
+	}
+
 	out_h = fopen(".tmpconfig.h", "w");
 	if (!out_h) {
 		fclose(out);
@@ -1080,6 +1106,7 @@ int conf_write_autoconf(int overwrite)
 	}
 
 	conf_write_heading(out, &kconfig_printer_cb, NULL);
+	conf_write_heading(tristate, &tristate_printer_cb, NULL);
 	conf_write_heading(out_h, &header_printer_cb, NULL);
 
 	for_all_symbols(i, sym) {
@@ -1087,11 +1114,13 @@ int conf_write_autoconf(int overwrite)
 		if (!(sym->flags & SYMBOL_WRITE) || !sym->name)
 			continue;
 
-		/* write symbols to auto.conf and autoconf.h */
+		/* write symbols to auto.conf, tristate and autoconf.h */
 		conf_write_symbol(out, sym, &kconfig_printer_cb, (void *)1);
+		conf_write_symbol(tristate, sym, &tristate_printer_cb, (void *)1);
 		conf_write_symbol(out_h, sym, &header_printer_cb, NULL);
 	}
 	fclose(out);
+	fclose(tristate);
 	fclose(out_h);
 
 	name = getenv("KCONFIG_AUTOHEADER");
@@ -1102,6 +1131,14 @@ int conf_write_autoconf(int overwrite)
 	if (rename(".tmpconfig.h", name))
 		return 1;
 
+	name = getenv("KCONFIG_TRISTATE");
+	if (!name)
+		name = "include/config/tristate.conf";
+	if (make_parent_dir(name))
+		return 1;
+	if (rename(".tmpconfig_tristate", name))
+		return 1;
+
 	if (make_parent_dir(autoconf_name))
 		return 1;
 	/*
-- 
2.32.0.255.gd9b1d14a2a

