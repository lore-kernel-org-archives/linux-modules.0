Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25978C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE1061368
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbhI2VyW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346393AbhI2VyM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TL3lca017463;
        Wed, 29 Sep 2021 21:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=EBoLwBlMpXFB/C9MRRKs5QfKl+VZnJ3GxpSG3BANAp/+Jw63TFe8f1a6f1ug4TYsRGIS
 cZDIXRkbZMnxHCHsVK9VXmlvnyNmDjTVNDBOnxhv4lLB/5B+pZXOVSkaJ3aBBOeDRH2O
 jygIUwMbzyeBBUBB8rPE8WOLXfWHVUnG5V7kB2eOsvCJtDT9el5QSqdJ1fZjaWccZRgd
 Ea078l8m71LNY5kaS14dcmAQF4oHb4vHtOrEMxVCiDvpcC9OgidPGfqe11OqWHmMbHdd
 bVHPNLZplUzudIsC9lP3Lr1vrI2rM4UCo4ktz7rDX0q6a/juq4yeJxMqx9QMzQbm08Zg xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hrxcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLkUSj071027;
        Wed, 29 Sep 2021 21:52:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3bc3bkmp5e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0b1p/9uSD7cLZnKUUCjHcWMRYi/BPwMp3igbLiRwyNJDMdcjVo5azrs8EQPOjPicKGyIpTxNNaZY4yqjn/kKmWazplHD6/FIAACIrEaypZHZ59Bn6/ag0CzsoOi+YBVI0m3S7deXgfjR2P42C4lTLYr+yZMEXnjaSWopTLk6ihJeBiSwHdsBf1sLAg0BOC3Q/xlQen6L9emn84pKrCvbm5wqORlOwnXXMlSSgq19m8w+HWxm4qPrbw6Bvvvz/rhqCBH1v6RzZdruxDx0yZzCuRA5aS3uuZarYW+36YjQ76tbncaDdxITpmQ1VpvfpVvXHlf/NL4U2cZIfoPpHtDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=MssUXHiYBpuRgjCoYKeYYWZgptLpDLYje8HKYF6uarAMuDGeExwFzSKkbmcb4ud2+zc/cchWqkhHLilkkOaRkXcY/vYkJwH15Is7Q3StNcX6Ph3NXABadOrP584awWlE1dtA5EYDACPSfkzIWDDp4NMbn+NX5jMLaejid/hFsll39Z2NTFYTUTYPKCU4JhNej3C2hKz6cOOlRSYz0pVOmjiCo00bSewMlM0QdhDKbDznLTRkRc6/s1HN9ZzbOx6eDvzOlVgdUt858wW0wpyuxqCpJgngKIXO36Zg1Q9UIh0TaCDxJACYiJQssAbp3On7ojysY4n8Gx6oBTaH4JRtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvvQtessmyoYK1pqUcup3bTjRF4Sbj20I9i9NR9B7U8=;
 b=kNsSHJw4CcAAya+c9ftYF8nT+zR8beVdKyg7ar+CTgfJ2zB/a/jvStQGhuKPFhEh/ZsVnxBtOEKgeC+Io8XL7K5IoR+2LXvpY2XrWSsAqKp/K9t50UFhEA1zPbVMwC7XG2+qEyxEoVfiDOrFUIOLZMOtrlVKQlbkCsiNUrYwXY0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 21:52:22 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Wed, 29 Sep 2021 22:51:52 +0100
Message-Id: <20210929215154.300692-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156e871a-4593-45a4-c8b5-08d983936a8c
X-MS-TrafficTypeDiagnostic: SN6PR10MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB3440A967C9814F63A14538B78BA99@SN6PR10MB3440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDMbTO5PPHWW6SRDFb7ZQoO3wTZWO+Nn+sdZjD92m/WiZOybwLYVrfE10ZcNhQiqIu/DSHnHdFcibQrJVvAwekI9sxoaYuFjJyH8hCYK0hc4dpXp0pzM1FHA/YJO/jWm0Nb5mDO+444DIxGCY520xwIVo900IduJf64+7BF8/4dMg3yQao2QJ7/dzPG380Cyrxycafu77/2u0WGML7gYBomKoI2I/m5ye4B3cV8G4IbYY83guYkXVSFkG3ooIXQlHKbFJOfs6QWnYAEES8jTxMOQ1TCdgCEEGD6A7UnOZf+yvxl3viB5ukoNcaNkDexsdRCACqTBrPRbJRt3y/Z1MXK0OA09naeLPkZdxjny1OeurkcT4hClTMexeOoHTLk1EY74W7LhFr4PLSSA62H84s5XV3TssJBfGtAXFuEwVCcUt7OcbUxWfEI+o22pSO0LoX3mnvIc267xywZxNYWtI/TB7rbYHVP0lKNNwpmzsVFD3p0qL9ajJCGHKLmHXfWGmgMKRQ1vnXy8cWlQ9vhjqqmx+JxXmUNjWqyKegZINjP5u9yb+xkb9/qWZU1bR5ld+ktLxN4OYs5zFrgaocvSPx9ZMjNIX147MXOGIrwVBuqV+A7zP3uEZ68okFPu0y7UitNakCXit6BgclAkMbPA+wPz0WG/Bdyh2ydtuqI8SuKV+hxSmZjkfIt7Lewtu3ud4x+R6gNENSa2GELnvmNLpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(316002)(8936002)(30864003)(5660300002)(36756003)(8676002)(6512007)(2616005)(6486002)(38100700002)(508600001)(107886003)(66476007)(66556008)(6666004)(2906002)(186003)(83380400001)(86362001)(52116002)(44832011)(6506007)(66946007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ht6AEtMh3Kf50tXWliV/Rjxa5tzkSU3igp81EzTChR1U/vJPyxvjqeZZ/rAb?=
 =?us-ascii?Q?Jh/WHmJ4Ct7PL5j5GkvIRbAes+DS3gaPhUIVT8Si+uls/+HW5uNlRHgSCYmg?=
 =?us-ascii?Q?PWHAztdk6QUNMwnmfhGjWZ0DmeEkRZ+ubAmLcm7USxPdc9gKaiyIJH5d+Gug?=
 =?us-ascii?Q?CL8Nmscqgcos855X7b8DNenoQ4y24ASQ+DNXKtrwmP9hXuHTRAx3IGHOAPk8?=
 =?us-ascii?Q?P/o9vEYdO1kEptvuJ7tm61m5BtMd3zb6wSgNwmsWB7cIjK+9hv6k01OgcK2e?=
 =?us-ascii?Q?m0552Rhd57FWJsxToAYnPl5+8AKwgHDQGIfshTkyFH1n8Z7KjphjCB8Hd85B?=
 =?us-ascii?Q?VmQr8/57ilg8zhmOT1L2N7cTgLOTBL6Xpr1tJiDxpMFoELDAQTRT+USJpZ5b?=
 =?us-ascii?Q?h/Sm3voZX0WIqUllHyjQlqM1f6DE/rQeiY5hkOGLB/yxi5KIcgrYI1wI1pgQ?=
 =?us-ascii?Q?BRHYNQnHj1pz7q9fEKxRiLwFrLlDs4EddP+1cVT+O+jUo2TDnUyuUoDGRl1M?=
 =?us-ascii?Q?N2WoYVD+oBSsMbsg7HzLXGhf0ARhevVNFNpf9Fho7GnAruPBe71EloUUrd/0?=
 =?us-ascii?Q?QdP9mKP591CitvMjRGoH1lmBc+jtoQYSIFIeg4wlsaHGpXT5YkG4Q3YV3x01?=
 =?us-ascii?Q?b7zRJwdnz3/mG/wWYwzQP0E4X89VO8/eyN7hFBDrAjzsSrmz56UU9DEW7D3K?=
 =?us-ascii?Q?5ONLwPzsk/bfiRAHTxDs6Q+4FVRPctcJ5Pm88EOtp7zO5PUcXn9911w/3mcW?=
 =?us-ascii?Q?gKBlRJLlwE5xaEipKrJTHgAU6RR7rImVsieTdCBtb7YylKgVJ/czbqsRkInB?=
 =?us-ascii?Q?3omFHwnfARvrWo+Deuw3aeaAsTd4HOaObRWdMgGjshlFBrkJC4cC35wqBKXe?=
 =?us-ascii?Q?XDPazSXCWpYQ6uuNuDh+XO0TX7GRZXLUVurCHrpoQgXul1f/aKBQWtip/DVT?=
 =?us-ascii?Q?QBv1AsAvp9mZI8hvLv46hvIMixuQ6GULdiRHGagTEiKZYVJCb8GcrAomSp9y?=
 =?us-ascii?Q?Tx1e98DYBqEIlNepDymidGJlI5gcFSdL2e4upPFDnqNSAvE8i96i2SW1ugiM?=
 =?us-ascii?Q?uScAZUrlruqAe/BQBCyzRIwSS402+sn5jBzx0u5YSe1Z5qCfPoqNoz7Oy6eD?=
 =?us-ascii?Q?O3m9N7v841Yrv2SFi2BTjVhy3yGLgc03VWcYPXbc6B6V2vw01YX9TcaShkZ+?=
 =?us-ascii?Q?vD/GUDNZCSZvKyLY9K+co+phZPNTNXL/mWHMh8jHQ3TKljtTrR5MKiRHb3QZ?=
 =?us-ascii?Q?cinxZzKH116abZ8HprNGtWvAspWxPBneak03rvoazePJ3AOlJKXmvldNacR8?=
 =?us-ascii?Q?Z0ypaxw0Mi/dZFCMen4t6he8qfdZQEPysDYLMFGAWIlH7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e871a-4593-45a4-c8b5-08d983936a8c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:22.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9GSWtiUX5FZBWjl4IVqjE8GTcPMACDy3C5jhUt11SCEaSbXBODhIyNxLCYo4vyo4xUFkCZDkxY5ooZfHLr3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290128
X-Proofpoint-GUID: qtvKoqTOA1gqdAv_9o_txZByxmoMXrGo
X-Proofpoint-ORIG-GUID: qtvKoqTOA1gqdAv_9o_txZByxmoMXrGo
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

