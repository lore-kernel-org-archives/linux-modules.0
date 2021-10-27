Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F3C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EF860E73
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbhJ0RuP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243393AbhJ0RuJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGTnee017567;
        Wed, 27 Oct 2021 17:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=qU1INEbnldQR/XRf3Uo8bSVSLkLTHn6HDdulE3BTS7thdwtXjhoGl3B4yQEwAhdU8dsD
 9UrK4aBDKLk3h+F73EE6fxiIJ7/u4oE3z0F72dlA2Wbs8zI2lo18y4109CTYBUsqU/t/
 GVs95HqvtriDtEe14erDNpzqRfhnQswtL4GONa5UYF2+kcZ/iVgPCT6sHrerenVQNPfB
 Zi/xRPZqH1G4Yashu0PaFFMGWq5Q7s+SEghgaKf3B71V1Cbv+I+xh0PQlqBtfpWrhxEQ
 U2KQ6PgQIaLgRDpgGZjtSng4A/whrzuuhODu1oHrv8N3a7xBKoMMQq/oLHE6oQD07VPV 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fg3srr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHfZaI186349;
        Wed, 27 Oct 2021 17:47:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3bx4gd3a2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD9BJtuh1GhvnKBCyQMm+3Mv1QM6U2Un9zu0H3IWrjPY0euSpAV40mxz9c92jLmQ1GSqZgEvWTi9Y/P78I3DwaT0u1e62m5dUorVvI8ZngT2lO5KI3W3Y4hvAwyid9rnEkbdVgvyXyGL/w4dpjdBbHZNsT3ZPLmOMtsdrVcC7rBtlUCxYvy8GPmFhFjayhYpgs4X8hU+I6lG31idCc+CaArd8ytKGIFFl21RMnuWo+zd6tMkPIKbqvFm9QRNFdIooYoGE2zXXI7PuEpAIrKq14fO67eavtcuJUxUkrozUpq9zR9/gW/28WFNYuwmIsWx/bwa/IhYL0B0Ro2RaHlLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=WR21UjmZDrDWBL2RqLFoh2DScktKx4/XbE8J6fnaPOPpx74O/opF1k9TVPWk2PFGQxnixcNTJLc9sUSWM5eMkzivo7tM9p7yRotRZohC7gCCRGf4GseLYdz1HXtHlv+hojTxn9kpCmKLRpuRW4YQwavf5PGCh7FTvaaD3ZqZ66ekar0ZOdVzp7mIwcZE9vHPfKOtS81Z6PNk/zkbKGJaIh67YROc9DnlKd441zURi7b0sOI9nwfqX6wqCUmQ9i6/ViS1oew5igYK0cM4KB97mwt90QGhmRHzCIJSxa+otGT8h2lVJnbGhN64B4u9dImNjBYXmVdEz1iOocgM84wXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=j+U68u+/yF/mHaBIjHHayW/Y3Cq8fBQa8SlwpOb7DYbD6+Nsj86NATjgBfnZceH/g4jJmG+1rgnOO38q0ecWHJMt7ryKWKFzGQdyJB+TypKPIyP7qO/8t9h1jWAOoPba04Abjes1zgUwV6z87T8cSKQQL8EsuEFz3AW2rVDs/lU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 17:47:35 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Wed, 27 Oct 2021 18:47:04 +0100
Message-Id: <20211027174706.31010-6-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c05fec18-3bdc-4dfe-2a89-08d99971dc06
X-MS-TrafficTypeDiagnostic: SA2PR10MB4410:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4410A754E5C561C5E37A4CF08B859@SA2PR10MB4410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSUJloEzRx6Z1j/8jk5Dp/gu9zk5XXYHQX46/vCAqfxTGYCzfIvecTNM0zzPm+kyIY60OQZ9wMlbcmLy30qFglb3Ze3eTTz3X2m8OZ6rC3NiLwXh/eJGCbx9RE5lulyFIDg2H6YZx2zGMn1WdVEVuyz0GPwjtJwWwIjcrWvscDl21yDugRnGskC9fFi/EEFFSjnWKTBUAO7D+i6P0nU7F5bjcZxt3yHduNR3RRUW1khfNAK2+HfitnhFbI1tshhsQKJUN55EJQALh3WzNGS7QnUAVgKe8PjBiWAs40imLtdj9CkccBDe7rk8wNl+mldIvlY9ek3NCS1VGWxKSwK4YVarAVZDYiSFgLK601XZBWe+L1a/f8qVM6YYtBNgMm4JGTTmZCcrle+RIw1MjXzMFRzwiaaWABHCqhxmyAvntZPvrrTewBlItsoABykMP/gskbn7iIAyoJMkYAO9ZnnY56xNKaLGcD2bqCG1KS+G8X6OyDN5Y9k5hCI0YJFhb2x6IhAWbewxrs9/NM7qF05lp4pluIqhypyp3ThTg+VxVPvx/DQ1uzr89lfl05yIv7CuuadAtYUZ4AcpY9eRCvPq/nx8V6kCnqS4lpniKbs5hfxvV/IQYaTkvLAQOOuV+0qAPp++ecR47qMk9TXC50LZvFlasHSW0NHWPSummthckFnTHXWrX01C2cfa+9BqyyDSusT3wyNOV/ChYnrhPlbm2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(107886003)(30864003)(6666004)(66476007)(44832011)(1076003)(66946007)(2616005)(5660300002)(38100700002)(8936002)(66556008)(4326008)(8676002)(2906002)(83380400001)(52116002)(186003)(6512007)(6506007)(508600001)(86362001)(36756003)(6486002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxnmzWpJRkN8MZv0TqRZnCJJK7JIC1bCVrEQYZMOlByFUYS00x00MBkbI3wn?=
 =?us-ascii?Q?qwBLtkkgkFp9QrEwbT1rzcXmiWalPCU9OLYdfFPT3U1LsQT7o08/vFnDQ1ku?=
 =?us-ascii?Q?EJtzNcJufIpzrYEMunIQkSzZoCiRZLWSml/tB76tAWTX+NQlzwJAkU3U6VbZ?=
 =?us-ascii?Q?ktZAXrwCM0FhqLh7dRqhvguQcSYqENB8NZvFASSygzCT+N7orYCZNnvJ4n5L?=
 =?us-ascii?Q?1OlwdC1jyCTr9I2Y3XG8pFv8/CGb/mdZQHcQNJLd1+nrW0zPls7biCq4dMqs?=
 =?us-ascii?Q?R4I8lUm/kBgvig68yeW2jweC+Q8irB+vjdsavGxHw2Q70EHEpG3xO/ebBeRP?=
 =?us-ascii?Q?7vXQdwQHmjhzPAydcrmM/71jJ8/EWNFXiCGKZbRL2beI/gqKu3dXUBbKq66W?=
 =?us-ascii?Q?Qe5CzBE3pGLsDZhzFb+sTrVb6T2BHrXl21NahAEfbZfHSYAVTtysSFKnjH5i?=
 =?us-ascii?Q?xXsq7yKKXJfECU+zV2znEDS8dRH8wlSXx0n/K2RLf+UPXUuPUWX5FI9flpCk?=
 =?us-ascii?Q?K82vjKmZybwA59070onnMJIDriLcUlfrvOMGT3lkrujXV0ZOrW17zmNeGb9y?=
 =?us-ascii?Q?Zfx9fTewVg7HRha2tyTUnV1D90GnsGcB5uO/MSwwrG5XnbcUQgMHhD5NbJob?=
 =?us-ascii?Q?YRChjuy+Bmwejwdrh3iSHiCE6FnDAbjnlpqCyVHoUz+yitZAanmOOFCV/A3R?=
 =?us-ascii?Q?bp+1aKlsqjLYx6SLMjd/5ihBdQ7szfAxNiTATxyfiU6iOEnEFMrWTjwctPWA?=
 =?us-ascii?Q?GtuiGAbreqwAcm6wYpHssDwzArbv02RnHwDR2Oo5gm2lm5XnaihvrfEKR0Is?=
 =?us-ascii?Q?jAd0vuVckegdDZR3Qt10uBJOQz1r7iYFsyRXiBR326oK9Y8Xlcr8XRtntXGh?=
 =?us-ascii?Q?tVX6HHbYThOTKlOObNn8Q4Lun8+ZCbI0QFTaBcmuKlzlC/5dOylaTkMTsvZR?=
 =?us-ascii?Q?5/mySZMrE6K/al60t1J6Y+v7OthvsmKKnjzCva7jreVt9pIKyppF3YQyKuXD?=
 =?us-ascii?Q?5ip1yHSx1TVNm7eANvwvOOz0jZRjqceMFFoiU8tEaf5MmpfiDvjI8dH9FSB4?=
 =?us-ascii?Q?vlnsvhWXVdVJAEkJ3+MRz5SSL6jvE6JcJVi2LxDP/yj8Jg7AuidZN814oKDt?=
 =?us-ascii?Q?2OvzF/t+2e3qSSX+kESSYtjvDdUMGaKdIu7Alo1zguN3OoBfCKCcTX00R+2h?=
 =?us-ascii?Q?ezgxryX/j9ZeJ3WidWScllZNGulol7F+jxL9G0pkABNz0IKEk8qwndWymkbC?=
 =?us-ascii?Q?sxps4Zpcm9RAxOBMuiiDl6FCmnSEnI1UNFvIoZzvF2jB3QfzpQWQgG7c2VGs?=
 =?us-ascii?Q?SvFMxsQLSv+RwSOW3uk0lmjkQAuaoNefa6NkSTYzyVD0DrmgHMW+WMjUpFMW?=
 =?us-ascii?Q?GN8Hi9MdiSe1ECGUrRyCREKWLNjX+9oG1xJinUaq53jhWFhuXUxs28DwXuFJ?=
 =?us-ascii?Q?qLXyZFF/pXymEJZRWP+5Y0iIuUrMfpBB7rcammflbXt/G5QQUIAt7yovSjug?=
 =?us-ascii?Q?Ekf1cVV4UliqSSYoZyX5SYoCd7Dn6oSFYMlBCZQjwrangW+wOTfYTJT6yUR6?=
 =?us-ascii?Q?fhK3T058cjEe6zP/nfAFfvRMzFkQ+pysqJTAnaTkECmu7rtur2DALuhUha3k?=
 =?us-ascii?Q?MUlJ8D3ID/gLbSo0hFg370W/empPBBKT4yKv/kMO2OgL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05fec18-3bdc-4dfe-2a89-08d99971dc06
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:35.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVbZ5piuYFdUzdhQzBUtFByGyzpZXWWVOPvN2svcmS0OY82DZ13wO07mqcvVDj8c6NOsX4BEc0Mvj5GhQ6yx6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270099
X-Proofpoint-ORIG-GUID: 7SsDGp5qWhY14pe-WrrAl2mMqzcOBIZr
X-Proofpoint-GUID: 7SsDGp5qWhY14pe-WrrAl2mMqzcOBIZr
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
2.33.0.256.gb827f06fa9

