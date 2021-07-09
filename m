Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADAC07E99
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B045613BF
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGIW27 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:28:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5394 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhGIW2t (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKoWw028043;
        Fri, 9 Jul 2021 22:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=zR7S/77TGJHP9EdmAAC8XP2psg23Xe0f9QaXOS6e/DHlH8Fo+oWoioY3ZaVPn/2d9Mso
 9Opv1IYQCl2zBAuSz3exOK/ZT3zOUyWbLAK6+7OIAkFnVoL/J7U+Z3iIQcRQ4fwQqQF9
 b7lPZARERJlxD7kWDw1rvlJuVGJX7eCszFMpVNGumacpsvyMGalrm+GbiR/t1E/Rn+KI
 yODTjJDvUJJdYaxVNi4V7jgug/m1KNWP73z5u7WFl/D3TWjld2PfnqE7c6ry8DsJZF8n
 QMw0gdMlMoui1NdqmBdAt0CDM52GbOVBbTaD0BqtQC0eW0tNV4oW3c3IDzx99ha87RpA ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pkn49cjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MKGO8057329;
        Fri, 9 Jul 2021 22:26:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 39jd1byq7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA15eYFHeG+/isdKKddekQGMPljL3QHrbXkZtdokz+5udXLnericpT5ioZO+dPK46mbuYjfEJwgEQnLn2vZgn9kOHrcXSw+hcBNkBxIsqWQ3A1zVNezaas7PE7S7gpQJNLVHJM/9pB0sTsmgpydbAVvnyefLXqGmNN+3JsrZ4sM5lMHG/MVbNrlogT6JtIe+l0ubEmYIvk8RUvMgfRQvBgqgYJm0FZX8xgaB05M1n+QfClcYfIc5P2hu4wCbTcabC3PnwfmZ2G7965QNNjiJhaXg/V1L8Gc3kDE95UE35+DHKLXeAdVVMWMZW32m5cBWr4j6uRS3A2XhcUq99G2Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=W0iWvJG8ys8I1R+Q+oy5gJOzSOyVkFDhErT/A8ao6JMp6coTMq7HaRlGSPnt/lYbENNxbR9t0ZfgHRj2ughX2SNx72DQL21c4MJPeIZaxEBzB4Bv30m22si10PFBdXPIQ8PqM5+PcrLGz84rs3VrNZjY8FbocoooWEY1QpvPHUUvPWwtcKnisyy35uVvHJ2hrdqtL9pMLFtjd6A6OYb2Xaqmy857qLcFOcaKAkZINpLT3wA7mB4eMwj9eJ/yR1j1fMv+Dabb9WE1HNQipl5YkDCW6ie0lHRRWTsQ0aJLK9nS/h4aSouuC/JVRoP35jjQ0S673l/1nFwf1W3uRPk15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/37msxlFiJLKgtSdrnOIX6j5D/RTjn/uEhN2RNC/7Q=;
 b=FkfDHxR47gVlNkiDKc3+/ukiZ4o3Dk2a3wBEFTefjzCLMvZHUnkZlKvNKmtF0mIjEmkVjsZb3Qvr7CvhGaDoTq4nwH6qFggavz4Tg0HjSbL1B5vUyEeaHMo+fZ0i+GYEER7cnA4bcobdy883CC0jWQ0lUTcuh46ZnTJQY9F+E0Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:58 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Fri,  9 Jul 2021 23:25:21 +0100
Message-Id: <20210709222523.17639-6-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d52d7397-ce8c-4b1c-e648-08d94328862e
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-Microsoft-Antispam-PRVS: <SN6PR10MB29272F28174B1B1F5D6105888B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98XWVlHhYeyCLFPNF2KBcdGhddDrRwcLZ5OlJB/cEyjst94jLAwmqrdt8lpps6GJ1ZoOH6AZhc2CwsUdEl0SFKBFA/mN0FZTX152IlcEZl0IfPRwmFpGxWTz4Qi3CFTS/ax4hQkJYXByCMoixI9JkVkfwfFeLGtsAJjed8Xy5i31BzqLqrERSdjS2JeiX23Vi7QgkMEmED7vKmAbjVsWNtvFqIOydvbc3GwmlTczm9PheRvvd8TSt26Jg6+v7OKxTHle6fbUovGZoeNxTHIPMOeT6CM1MtDDqvYlEbrnshWIZaGESfvc+2ADMsTeWBWPNcqZP537R3m3WQQqwtGOK2Bo2MJ6pXXb578xWVcHVFYu2o2+P33Wzw20P9qRDjLyrDXyKrqq3/ZCK6KQuVNNvnXhgzzMrP9aDd0vja1avt2DrXFAgpY/8MktAhg1eGkaTHTbphRo+2WbuHIYRkxsAovu3GR5x/UOMsZINhxe7E786bzrExOiMHhMSuOd4N0FaekJBtV1twatMcFmQxvoBrGALAJZxUVIx7kOzIy4u9WP5QRh09wZBOQLHWe5jmAmlzK1rsQTF9GZKHjBGUi+SEmhaei9NnXh8ax84+0kJu0Srm5uNvNJu8IdqnC8/Kqgfg+R7ZNKUB8LDH+cbTHoYEzT8zRLur2n6fbIgbRdT3tiUL0+c6cMIYJBlaUFT+aUkj9vTZ3JjBdMg4/mQAUf/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(8676002)(83380400001)(2616005)(66556008)(6506007)(30864003)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5in/2EvgF2uB4o49uyV+KG88r6CQjGegjWtQBnnoBBy+cHaUTB/CMXn3XmIK?=
 =?us-ascii?Q?SdmyS7nTEm63U2mnQuCUWsEgTGRXZDJn9C68kkyGrk6oqDLBvubmmrF7qzNT?=
 =?us-ascii?Q?Ui43fXnLs1zwNej81BqeAv/Ng7R0JyNNmkooz/boDspZGJQIcqWJnXTjFP8y?=
 =?us-ascii?Q?B2Lg1TrtyrDRHSFdSnwlYKwHPpv71S+TPhYZrid/tAHp3ujwZsvFeRSYSLDD?=
 =?us-ascii?Q?6bOA8P3ZTIsGYKHirfHz3Sq1VEvv3eCGFlJDGoW7B12Za0Si62RiTam6Huz+?=
 =?us-ascii?Q?zZaR9tIRRDYthKznqX2IlYFO7UTXLHsLp7H5Qj7hG0eivTZNRmZK8NMSUhr+?=
 =?us-ascii?Q?nIITyS5KRoeA7Mt8lipMd7QI9dZn9MCTLK9NXH20WjV65nXLPKhSslWrMQsX?=
 =?us-ascii?Q?9LsUqO/Q+Nat7w1cWzscslBPnlxysWWIwJ6nwJI4Nn18h0xG4fU3ptJeH66y?=
 =?us-ascii?Q?k377R+7hHf10DhEPAKihMF5S1Vyfa5N+ZSdVEW9GqLTCt1WdwQB41o5JRn+6?=
 =?us-ascii?Q?A8FbqEerd+B+JX285sQd9PeDzPD1TWtmM0LTE73Rt1+Ayyd3BvUo/OV0xPr5?=
 =?us-ascii?Q?sVc8TdObvLjdSPgGraq6MpfW2+wvTd6zbkvOWNinyPNZnnMNlaK0EdnfAjG8?=
 =?us-ascii?Q?YOiIOUYIr35YPfNTyWND3hEkT1kTb/ZLcKgKxuIskEzzGY+eyCQ7I8GL4wS5?=
 =?us-ascii?Q?y5+mbmK+3mfFYjCQHC16uPwSWWob1HnC/o1vYl9uWlQ56AKbzCFWUBHE5FmD?=
 =?us-ascii?Q?AB7DOTrXS20mwlpH/Z9eE1rBbp3AO3jb1sMeCrr3FX0tcon0oNIq6ucj6Fvg?=
 =?us-ascii?Q?ZnVukuHa9SFGlSeZaaa3baPOt9nzmYEwRf/c8tfTfAfZqBlCvn4aXXTFuwMM?=
 =?us-ascii?Q?x+SX50UtAYa16pwO9M6EigDC5m+ohm1FTBnQaSk7ZMCUxcZ6k9l3RaIvKEBb?=
 =?us-ascii?Q?rTrCIB+fUsMdwS+PgzjW35E7PErvxElJOxFIqj7KPuu7B3IUdoeCD9KOJvK2?=
 =?us-ascii?Q?5yJe620U5zCpxzjJ8Ajr4nD6XA+vq+Qu0Y4G8alCMfxWYcYwtL2RjnqOGez+?=
 =?us-ascii?Q?4bc50kfbi5Y1xlE6U0rP7H9sGGpohl79/feHzGvMngsh7q8mygDY+qLPHw8n?=
 =?us-ascii?Q?d+ODwjev5gFCelsYoLa4+Df/gSwm2gHvk6fYnHbP5Y5NF9GDpyzcWJqLbtCG?=
 =?us-ascii?Q?KWU0LEPfG7cyBuFN0Jm5ChKarbf+OSmw/e1bZV1psTFp1nXhdxHMyUZP9N6f?=
 =?us-ascii?Q?3lb7VJ0aYgHN3NJw4U/CmuNNGsGsgVMYU6BScV27jQNcisYC1DnxnogsO73W?=
 =?us-ascii?Q?VRrwCuoaKiDgDwmUXH2ABv2DE9ZO3EY3CquC0coSiOiubQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d7397-ce8c-4b1c-e648-08d94328862e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:57.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZufB57CgpYHbFo5+rCf386BDL/9ke9+phSmNsOY0prqXM5cLJbeoX0eis0o1AvDlHkzqjUXH8M9nyIn1y1MKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090113
X-Proofpoint-GUID: uXBr2sjg3AZKG0gFCKkmJZdz9EPolYPi
X-Proofpoint-ORIG-GUID: uXBr2sjg3AZKG0gFCKkmJZdz9EPolYPi
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit), the size impact of all of this on the final kernel is minimal:
in my testing, the kallsyms2.S file went from 14107772 to 14137245
bytes, a gain of 29743 bytes, or 0.16%: vmlinux gained 10824 bytes, a
gain of .017%, and the compressed vmlinux only 7552 bytes, a gain of
.08%: though the latter two values are very configuration-dependent,
they seem likely to scale roughly with the kernel they are part of.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/kallsyms.c | 267 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8f87b724d0fa..93fdf0dcf587 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -85,6 +85,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -94,14 +105,24 @@ struct obj2mod_elem {
 	size_t nmods;			/* number of modules in "mods" */
 	size_t mods_size;		/* size of all mods together */
 	int mod_offset;			/* offset in .kallsyms_module_names */
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -143,6 +164,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -156,8 +179,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * TU appears in multiple modules.  mod2obj for this entry will
+		 * be ignored from now on, except insofar as it is needed to
+		 * maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -177,6 +207,164 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+/*
+ * Used inside optimize_obj2mod to identify duplicate module entries.
+ */
+struct obj2mod_modhash_elem {
+	struct obj2mod_elem *elem;
+	unsigned int modhash;		/* hash value of this entry */
+};
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	const struct obj2mod_modhash_elem *el_a = a;
+	const struct obj2mod_modhash_elem *el_b = b;
+	if (el_a->modhash < el_b->modhash)
+		return -1;
+	else if (el_a->modhash > el_b->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all TUs in obj2mod which refer to the same module with a single
+ * obj2mod entry for emission, preferring to point into the module list in a
+ * multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_modhash_elem *uniq;
+	struct obj2mod_modhash_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_modhash_elem) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n].elem = elem;
+			uniq[n].modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort (uniq, num_objfiles, sizeof (struct obj2mod_modhash_elem),
+	       qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_module_names as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i].elem->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i].elem->mods;
+		for (j = uniq[i].elem->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i].elem;
+				assert (uniq[i].elem->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = &uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i].elem->nmods > 1)
+			continue;
+
+		if (uniq[i].elem->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			assert (last->elem->xref == NULL);
+			continue;
+		}
+		last = &uniq[i];
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -479,7 +667,7 @@ static void output_kallmodsyms_modules(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
 	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_module_names");
@@ -489,9 +677,15 @@ static void output_kallmodsyms_modules(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			if (elem->xref)
+				out_elem = elem->xref;
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -500,13 +694,13 @@ static void output_kallmodsyms_modules(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -533,6 +727,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -558,6 +759,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no object file: point at 0, the built-in
 		 * module.
@@ -568,13 +776,53 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module entry,
+		 * or from single- or multi-module entry to another multi-module
+		 * entry.  Single -> single and multi -> multi always points at
+		 * the start of the xref target, so its offset can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1)
+			mod_offset = elem->mod_offset;
+		else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert (j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
-		assert (elem->mod_offset != 0);
+		assert (mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1093,6 +1341,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_thick_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.32.0.255.gd9b1d14a2a

