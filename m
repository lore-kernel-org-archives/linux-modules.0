Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C82FC4320A
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C3960F41
	for <linux-modules@archiver.kernel.org>; Tue,  3 Aug 2021 17:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhHCRQq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:16:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35158 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237745AbhHCRQl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173HFuR5028928;
        Tue, 3 Aug 2021 17:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=wbTwLV+a7c5salETSZh78xW3vCaEdfOrndVE/Wg+Hn9zxTzCgF7KUSUUR4HL1ipleaf1
 uGunA2WTS/CijXLREqIMbB6dHp5beKCBbl7w0VPwb2/sCjpKkoqBrKyVGJDCWMawpRPi
 fFxRjM+FSQo/yrMqo8AuPxLtZWdXV2VmWY7rOu1RhWSxXX3JZqiJLqZwj4hGinP5wtqB
 G2uMzPt6mk78HxVS8TqzXEhvgZzWzUCR5BfpF7dEbHDDjYhu1pPdSIpqQDmXOBk4HlFf
 Xi9d2bgUrD1UA/FYU8rH+rN67qv98LliHAE34ePcurKQI+97ON7Bv8DahJP9ESGHMIxe OQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=mmzzxXFGOgeJikgIAH62+h9+B0KS2qxAYD30IstLt10yQ0bAyDlx9loXf17M3aY3Rmm9
 gyOeaD/DoE7E8r1hkW5UfBd60ac5huV5H1Yo0e7FnRlRwwvNsynFqB7lffgSvM/Tko+I
 FyMxJoLnrMZdfd2HNgeMbay0OPFZ8t4phOqCjMqc7xR1x5zGv0uxYujxJmbOI8aTweGn
 67WTxgKMC1wY34TnmKuVOQGXV7+mdVpmOqt2+6O84GBV4yExriCduyoGfwdEap+4ue+f
 ObgFENEYeQtg8d5I4XsVND/1n8JV+g+UBZ12jV8aXdHosrbQZpE6Ns8MolhQD3eMP0iB cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjspgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173HFsPZ183317;
        Tue, 3 Aug 2021 17:16:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3a4xb73fj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 17:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxBfHK8+PxXRHt540n2uDNTAmVYEIElFpy93P+SujW6px8GGTW1nZtxkOzhLkaXGUNMn5XZ9YpMddZQZTH1ljdgYyECpJbWBhjQDmxm2Kss77ptmCLWtQtxNEmPUpPZRDNdMsCX0YLWaO84MTVF39i1sBiVY+h4Ja84Ng22uCpbqXTKWhIGfjnTUsic/7U2ukyV5ME9ZhhWO5fsveJg9kHYDSp42Bq3lXvnKJBq8yXW9f8yRaRdBuKAVFFTKxcQ4y9KELlNxWrxyBffphobL0pOOjrfIcIa8XtvdryCOMi8ggMBU9HgD+PMqcqI5EowyUMiTmI9r4sG/zIdVS/15LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=U41DDScs1nTX4DMeZ8iWC3iNVctXgOUlrcn/LpkVZ73O2yLdDXC1+tOEPsTPgqulmgDU0g2v9sfuNCcM8ZVa1sn6dN64ezsOj104h2pwCRTZ/bmVDuq7TRuNV4MuP13fZhcQMlc4bofrBphIw92D9TvCGmrm2EFAIq777n0+rApFn5naL4ukm8QQNkEFNxp96faqJHnGf08HaaC1XDSG9yccjycP1L1FvYeElQsZZs5lifh6fnoZ693tkbAoo9FAAnxgbFMFOUusLR9XgengZUhCtjosqfnl7D1G46VDQqruZGEesWnE+qTi0wxupnFlw/Rb7QgSrQ0M5Ihf5j6pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuxiClIYhvq8cOtVJlzo2XffYl3YRqTBRUKWLrFmFI0=;
 b=GcE0DVH+xeFYSKWmXKY27stxr5EHipIkuub/R5BnVEFVEJ68QaNTMeqtq68WnKVBuDWucdf+37DxswILhWPKT4I0lUw2UXfkoq+JDeuq7zQgiMMxuyE1M+1CvRvhb99nxSPjuGTO1IZy34DYVeWWYzzhsga5ikbzLRj/Ff1WYU0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 17:16:24 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 17:16:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v4 1/7] kbuild: bring back tristate.conf
Date:   Tue,  3 Aug 2021 18:16:02 +0100
Message-Id: <20210803171608.509163-2-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 17:16:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89106133-24d7-4d4b-6c37-08d956a26bba
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB4715841E998720AE04658E9B8BF09@SA2PR10MB4715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbUEyoQJpv7BxkHwsp0jj84tsJay5Tuh+ijUt2whSUYw0ehu5vS2K4tAVNxfYb0BqGvqi+mK3LrqL6CUEhwpmd4jltGhjyebYmj2/xou1CHVYCwCzd0Mlo7nHFLMVhXvu1tdOMrytu74Jnhho8DEZ82lK+i0Y1MI9tjyps0edVwAdVlhImlEM5JUKzezAmpogWpEUVg1nA0ADG7UfIvxBP6u0IqL+BbWjxvv+X2H1pda1441IW9ehj/H34ThRaijSr45NgKfgp5+J5xu04Cpw2BOSjLgdMk3V18k+CvKTaJTxqjKMdrt8/9vz+Xq1Uc6aIIpAfbX3WAVEJYbY79Nm4zkcbwS/YZBsGClTrx/o25ExUi/3yE/t3mwVdhoe/e+I5BEYGNus/N0KhILTLjj0JA600FtWdL/MTQ+UdEd6Cv8xPVJsKGALa3oLWnlD+3/vlvaNTVJLvpCRLSQcjqBT7zqqjK5TT6gqN3/eJnzzTeJ6FcqWVstD748Jm45x/7h7YzCHGawZpN1dkPRRuPzoIER0ajw5/tpm6aoALdechVqkrIXa+rw8oI3ci4ctJk/AnA3epfbc9LaFWupe3thHEsmnd5rOojPbGHZZq6pphItyDkEycVg86XO3oPgkmqrMus5EWbfRwWYq/eq/8SJLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(2906002)(52116002)(6486002)(83380400001)(478600001)(44832011)(1076003)(66476007)(5660300002)(8936002)(107886003)(8676002)(66556008)(66946007)(4326008)(2616005)(6506007)(36756003)(186003)(38100700002)(6666004)(86362001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKWj8skXBngYye+7Pqjts86rJf5Tq6EtnQxBY+WmZMv6CzCiKjVAGk35FepO?=
 =?us-ascii?Q?skI2CX+k89oDTjFoW91CYyzXxvXntHdBDH48z6bQYP4varCz/RVcY1+VV7Uo?=
 =?us-ascii?Q?nf/rwenFnr9UaZ1Rf5plTmPDXNB5vWgrPOnbSN7NrLf/Y/28+CE50RQcE1gy?=
 =?us-ascii?Q?C+YiS91pX/uBAOPxCNsOLj6sigwScbs4t2iiPGfnxx+Y4uOP+JG1s9RB+XOP?=
 =?us-ascii?Q?Z2P3kBq3XInBVLDaF3frgn5Oi0lbaUP5JGIwGtAfEQDXbPzdcBEHsQR34A2q?=
 =?us-ascii?Q?soCrllvmc2wIDQ89ZWELpGUxe3v878q43nejE4uaHQ/b6ciRuSywha8OPK8x?=
 =?us-ascii?Q?8MXkyWIMC4xEMPV3Ww9XM1CXZ9mK0VI5Jq+OLrOJJQEboTroIK4dFrVmzpDB?=
 =?us-ascii?Q?0mJv2foN2ZZc9iEPsfcFkGeREQ9eiaLtmMbhSFZVytXgU587chfhd2U3Wg0F?=
 =?us-ascii?Q?qFx6CIvP2a+OkO7iV6q89xesRrqJxUYDkdjgCPh3NjP4mxJPGTIF+H1grOYj?=
 =?us-ascii?Q?Gn3LdguVv89oNvDZ7j7fTNfGV6X8g4KgGL8XUWRFMZx2WBFcM91AOp0HYViL?=
 =?us-ascii?Q?llIVqok3GfW2foMZc1KiF6H32slhg5kAt+YuBIVuAvlPvH/y15Y6ZD6S5P/Q?=
 =?us-ascii?Q?f47yEsxbrCrDP2VNKR81eBUtHSDPMdQY88OJzudOlExypziuuJdlyMc3hhCn?=
 =?us-ascii?Q?0V7BRuNoWs7rpW6BEv50l0YR/JiHXXGQoQQR25DaicNDct9DyiedgWIlKTQd?=
 =?us-ascii?Q?WVvkZSn5Ulo+uwoOVTb8Vcl2/63PkdBvsskkQGtz1adlYVmDId+MHKe+i99e?=
 =?us-ascii?Q?U0F1LG4LPxm2uH9d801HXJim/q5z1y90SXTbpz3X+Y1mcG8qkshZhxY+GxTY?=
 =?us-ascii?Q?7lH0xjdpGVQyBiGIMcE/62Sbx3tqbQvhj8bUjND1RPTPIw90BODqU70OGRAk?=
 =?us-ascii?Q?L+mneSsNzcm6mjNiCvUk5RBjg0HA/r35u0NoWTS4oHuYnkMX//upwgLZ7qne?=
 =?us-ascii?Q?M7OmHvqF3N2pinINZoSMFKmrwxYrRyMw81QX2Z/wuykB515x04C9ujJAzKqH?=
 =?us-ascii?Q?GfkX7Mbi4VSJ7HPkh7mlWW4LQUDuR5oZ2K5BazsO/pr0h6zk4drmEACa3/fv?=
 =?us-ascii?Q?Q5IKLynRpI/NsMmaQ6ioZ/tHNliV4xO8OaSS6Mg+qy61cEz+8mMAmAXOUuXO?=
 =?us-ascii?Q?kCeSJyvHrYD+HRHHXTeqXcUnowteOOiw8EnW0DjFptiSHiHASabISc+Fk2WH?=
 =?us-ascii?Q?/v6I6HgKAVUIfk+Vqyp0/52ihmR/Q4CBst6Q8dxHjmRlLexRvsDuM4M+EXDu?=
 =?us-ascii?Q?/X3GfYduIOc95PlK+rvfJraIu31C6t0Es1/ljuhCoRislg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89106133-24d7-4d4b-6c37-08d956a26bba
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:16:24.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzj6VrCtAE1UAm1FQZgL8C8cK9GL9iAWqHj+12yF9L2hOBRkal/sI26MqVybmDHP8OjjvrkLiQWeKn5rpgJj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030113
X-Proofpoint-GUID: GWjeLpICneemRwufUzHZwT15ySe1p6wn
X-Proofpoint-ORIG-GUID: GWjeLpICneemRwufUzHZwT15ySe1p6wn
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

