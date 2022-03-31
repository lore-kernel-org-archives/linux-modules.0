Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57147C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 31 Mar 2022 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiCaV6v (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiCaV6s (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 31 Mar 2022 17:58:48 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B184243731
        for <linux-modules@vger.kernel.org>; Thu, 31 Mar 2022 14:56:53 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22VLpsvw024459
        for <linux-modules@vger.kernel.org>; Thu, 31 Mar 2022 14:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=vHwio1KOd3ICxNuwuR06g6B8DOPoUMEF2ca8bN9uZQs=;
 b=oNLIHnEshgFu3RnEpWFj0dCwCR0F6BOPbHdu92iGTGxMx1FYrAmB3Dl+FBeGXfVpcAR8
 5yTpB/xQS2bpxQkJ+xL3OgyDtFe+6Zp8Z1CcTc20NUc947K+RjVuHSpt425Bc9wGqIYe
 r7K6V6RTti18V9c+5AzhMprGGfR3/ZOClhNUGXzaTyn45qzkxP0ij0ScdUvi1BOAmI0F
 CexA5judzsAVueGp3XKO/e3rxi7OuvnX9HEsMw8Q3TT7VtD2/6vXzCD8LK/0wzu9Y3XC
 O7aSQDNmMCzaelPTuUAvfkQfb3XPuQt4sG5wvZjtcy873pqiPOzGYDVNKibAjBr3Odxt zA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3f1x42n0je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-modules@vger.kernel.org>; Thu, 31 Mar 2022 14:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y07CiBjfEaVhcxByfoWDfG2k6QIbiVZKb41c7soddOjmUHPfFHn7QP3B4MfnnlcM1ikfQuz9fA1u1dTqWFOcU7vIcx8gCLBXYfo2KKrjxPtW6B4Sr45gnbvfz/6nfqmM5mdnI4SoSMoNu0UFyJ6ijf+f3qmBxrnKw/R30YBT5jmipNSSvvfydbsoj3PsCdfWdur4QcR1nsp1bw28LZTnDNEETxTowUWPxFdeQXBOe4DP7G6DnrvL71VWvwVDK2GPTgeKlJY99DB0O81qixYH/7lcPxIAgbfg1obM2hmSerzYDMT0wQu+JsdlWBzqdYe1jBL1N+e6efN4dp7L0pftwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHwio1KOd3ICxNuwuR06g6B8DOPoUMEF2ca8bN9uZQs=;
 b=EdG+BOV9wfj1LOMyuYApxuNk/t0yqy+OAvqDkYWbKD7JHGVXPKoJoGhoYbVhxvrBLO5aWIVycCp5xzIvRC1C63J9VwfxYWYDAG5AnswJgrked0ABk7rq0otcg7gdA7eD26mV6nFaRpoqjjr4B9LjlL4i3lNPeUfao50x50OmUrx5VG9XUmtr2HTg6foZ/773aIUPh7BJa6u1sWDaI4kaoNWlizpmFECQT/12q1Eim7+vGRRgRCl2JO8QDJ5fxGLuE3GNi8LqlD7S3sh7dO5MdGqsjtKK7KRdpIh7VWBYj+DrYKXdtgCXshB1ooR/XomPsMhdebnMoVEN2qLZpZ7bIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7)
 by BYAPR11MB3319.namprd11.prod.outlook.com (2603:10b6:a03:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 21:56:49 +0000
Received: from CO1PR11MB5076.namprd11.prod.outlook.com
 ([fe80::e581:b741:b80d:c8a2]) by CO1PR11MB5076.namprd11.prod.outlook.com
 ([fe80::e581:b741:b80d:c8a2%4]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 21:56:49 +0000
From:   Saul Wold <saul.wold@windriver.com>
To:     linux-modules@vger.kernel.org
Cc:     Saul Wold <saul.wold@windriver.com>
Subject: [PATCH v2] depmod: Add support for excluding a directory
Date:   Thu, 31 Mar 2022 14:56:28 -0700
Message-Id: <20220331215628.70679-1-saul.wold@windriver.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To CO1PR11MB5076.namprd11.prod.outlook.com
 (2603:10b6:303:90::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2091c2a-a649-4f04-9819-08da13615b81
X-MS-TrafficTypeDiagnostic: BYAPR11MB3319:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB331913708DED144FB65B3F60EEE19@BYAPR11MB3319.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq3NKyB6cMFTs/LiUWBBacaPPwA834vRsOK8CJKirkiI9ziG+u4w0Knky9+hpJWmIqt+VddG2E57ySi0B0ACiAHF0WwvQQBGTZ8FLyikEbpLR2Z8/1/WGrrpsHo5pn33xkHdBHTIPBZzqQ6TwaQFs5cd+AEeoBQ2Q37kjcIW6ouZHxTKtRZPnWY7YJNbHLk/s7gSgJvNGWcvRNrKkvvP1YOaQR5tTSdD5NoEZ9lLsXEXoBn3jwtEM6VHe46iPFLFAATYOo8qVTyVmyRBbTUErEWoDqPwmtEXcQFolYr21MOcuY8+vHCkp0a7/9kcjvph5Sh0tMpkc4B1E6uA0dXygNFIAOvWcp0phGHwTkmtATl4lQOjbhmY8VJaESBzPagRC49KUarJEjxS5RWFuXpmWVZQX8fqITIhcnnBnvXLkXdO6BvW09scOPqOnhfLXv5CEFVrd+1tPhcVG9sSShu8632blEVC9FJFiy9VBN5VLxicqlqPXQ/Ndxmnmrv6aaLOTige87GKZPuIf8pA3haqNBioG1mMfh/rgboDrYIbkF2gdKnARN4KnIK8TOzJZWa76qr5gqHDOZHcd3tNH2YDdIpodbzc/XppcR+OUIJvWRY7DXMIjwS1XJqKl5HTMLU++McaXhmrnOUbczSZixjuvMfX/LIejiIzzEmKe+/I8pZHve7KQg9gF/hBqPk1cz9zvzTA3hF4mTPdtI8H96MYEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(44832011)(6506007)(6512007)(8936002)(36756003)(66476007)(38350700002)(86362001)(6916009)(66946007)(2906002)(6486002)(2616005)(186003)(4326008)(6666004)(1076003)(107886003)(26005)(5660300002)(8676002)(83380400001)(316002)(52116002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zelkv/yI8MO+m2nxKdFFQjqLekTpL1COnmz6ZEY09Y1buyR2kznqaFL48z54?=
 =?us-ascii?Q?T2DCONYOIEkWdaTWd1wb10k1xft6LefZWPBxy8In3pUnoKGybv0JX4hqjcNU?=
 =?us-ascii?Q?a3HVlRa+IV0MLWGzYxetjyg3GSbW7E51aR/wEH+B39tEbIrMSRA5lv1K3Fg0?=
 =?us-ascii?Q?/eU99btVbxZyIVH9w8Crz8ReWKzN1FrIFoRLsfZ+R/XIrJMxfmgdHZNA0GpX?=
 =?us-ascii?Q?jpnzJbHma7Xbp70dgIRX6jURmNlDilwKfRbKDMj7Thisy/emGuHT8eEAwy31?=
 =?us-ascii?Q?bHE3qvwUcatgbJg/h+Uh+LSpuOTjKGPraWAyuW0Ko98GC4PkUSowFSD4xqK0?=
 =?us-ascii?Q?fCqHThFtrMZ2oVq6TJOANEZK18zCb3p3IqA/dQG0MSKLbVQQFwWpnWdK2Zun?=
 =?us-ascii?Q?lCO9WVob2+EMy2lw9K05E7o+LwSCd/5eRma3yOCH1YkCFlooDG5u9p1Or9np?=
 =?us-ascii?Q?V+2RaSQy7HjIhgJyDJhmXSvq1Tt9VepHM7BpaVN1hNdCb/KiEzVLBORM+z5S?=
 =?us-ascii?Q?gVDPcW1Iu7QmG/hU9iAEfay5Q6NYIa8M+BXZPS/ZHvWt1XB7iliESpZ/1ewZ?=
 =?us-ascii?Q?nWCLTCMlaNJv9VHLh/5kjV6cYx48ojH7e5pogBrqlXLqfr5jCsFjyK82zbB4?=
 =?us-ascii?Q?jSl9GHRMh//nHUwyshm7H+j2N0D9DN6BCGwnBSfbkioZbSyYNCP4sXnzI1DZ?=
 =?us-ascii?Q?2M5jTNBfmTjsJrJnOCazJKSDNHssNX4m8pWKYgXGz0iuxyGfwrWHabYC7Ocm?=
 =?us-ascii?Q?PCbjWY/xPxVZZVB30oQ5bTE5SiE18fBITKzqh1Kse4v1BuhSkkrAjlm3VCtM?=
 =?us-ascii?Q?ZFB27wVx/mQINV5sn2Mv6srx/JfSj0SWHR5UfYu+z7VQIpsNvQgsJQgHh82v?=
 =?us-ascii?Q?et02SD0rj3EzQHy3Pci9t/tTsxjPANipAv2Z9cWr/l8upMqTyu+90jEPKDuM?=
 =?us-ascii?Q?CzwIzeliJuti+9Dw7baCwTn142KSAExxl3JwKB0LGOnLt1q7UO6dqwnNIjx4?=
 =?us-ascii?Q?3oKbCuJLfHy8Fu0tIt2/kKyEMmDnWP3eJJWMk1XxfYYhHEv2xSo4YvoJotgB?=
 =?us-ascii?Q?/yVv3oFo4Aa8gzIw1E96bfDYfTcnmschFxiY+Ft8sRxeKkqdJoVueByt6Usu?=
 =?us-ascii?Q?QvcwBP1nCK7JP98WKRzi4zW569Qtt8fZEMLl8+lZO2LdkR2nTOxtE8B3OPIk?=
 =?us-ascii?Q?UTL8aVyHynuy1RA3GpAZMe1/oNegGkB/MaqcQ7c8Mj5DtbKrtIY+8jSm4F0r?=
 =?us-ascii?Q?UPTbXqVMuqfUUy089QK+nBFseHJSNbAdCGtr9wAgyTrfL4sogOlj1RqQ1r/W?=
 =?us-ascii?Q?2rABeFp5uGVwgGulNoJhzfUGEFr0f75WdYxlTpNugRaGjA9wQwZ3AEm4nqHj?=
 =?us-ascii?Q?q3MTaP2Dpm89fUy3X96DrTofWsZp6sIFivG0o67cWKhCvUWBbSk88rKO5J14?=
 =?us-ascii?Q?Hanl8Ng3PEPhFZRHWl1qaGcGYir1QJ5/k86Owfns3t/2BA6tTAc+pXPyQoCM?=
 =?us-ascii?Q?5cSx/HSyGibuMsSlyfNofKPzCTCmAFO4gK9ruqUSQpet5eA+sA7Ct9yLd9X6?=
 =?us-ascii?Q?0f8y6O6SiNry/NAEwUP6q+4R8YyDOTmo4IvvWARmUoCswXpdIhJ7OWhCTTd/?=
 =?us-ascii?Q?YM6eqJveaOyC8P/zQ1lA9/AQKISSSIHHTKTcK2SWhQCzWZqi/u/sycSl2Oab?=
 =?us-ascii?Q?ObTxhYYp2bOe14iLweASeUmgdzsSazsCnKwWUxCt78F7B6Yf1sVAzXQScXkc?=
 =?us-ascii?Q?QJQKvYMqhI7JAG0NY+fznN7cGQpjWds=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2091c2a-a649-4f04-9819-08da13615b81
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:56:49.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I0eaPvwAeqso5DstWwD+xzbCyIx50Bn8hZphijjg+E8/zBj8w3yOvms+ARZWkCxlTnzgx0x1FpDc2+sd6Ks/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3319
X-Proofpoint-GUID: G_n7fsga5my44DghPeYJBw5RMtNlLvaK
X-Proofpoint-ORIG-GUID: G_n7fsga5my44DghPeYJBw5RMtNlLvaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310114
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This adds support to depmod to enable a new exclude directive in
the depmod.d/*.conf configuration file. Currently depmod
already excludes directories named source or build. This change
will allow additional directories like .debug to be excluded also
via a new exclude directive.

depmod.d/exclude.conf example:
exclude	.debug

Upstream-Status: Submitted

Signed-off-by: Saul Wold <saul.wold@windriver.com>
---
v2: create should_exclude_dir() and some clean ups from Lucas

 man/depmod.d.xml | 14 +++++++++++
 tools/depmod.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index b315e93..76548e9 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -131,6 +131,20 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>exclude <replaceable>excludedir</replaceable>
+        </term>
+        <listitem>
+          <para>
+            This specifies the trailing directories that will be excluded
+            during the search for kernel modules.
+          </para>
+          <para>
+	    The <replaceable>excludedir</replaceable> is the trailing directory
+	    to exclude
+          </para>
+        </listitem>
+      </varlistentry>
     </variablelist>
   </refsect1>
 
diff --git a/tools/depmod.c b/tools/depmod.c
index eb810b8..ac365e9 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -458,6 +458,11 @@ struct cfg_external {
 	char path[];
 };
 
+struct cfg_exclude {
+	struct cfg_exclude *next;
+	char exclude_dir[];
+};
+
 struct cfg {
 	const char *kversion;
 	char dirname[PATH_MAX];
@@ -469,6 +474,7 @@ struct cfg {
 	struct cfg_override *overrides;
 	struct cfg_search *searches;
 	struct cfg_external *externals;
+	struct cfg_exclude *excludes;
 };
 
 static enum search_type cfg_define_search_type(const char *path)
@@ -580,6 +586,30 @@ static void cfg_external_free(struct cfg_external *ext)
 	free(ext);
 }
 
+static int cfg_exclude_add(struct cfg *cfg, const char *path)
+{
+	struct cfg_exclude *exc;
+	size_t len = strlen(path);
+
+	exc = malloc(sizeof(struct cfg_exclude) + len + 1);
+	if (exc == NULL) {
+		ERR("exclude add: out of memory\n");
+		return -ENOMEM;
+	}
+	memcpy(exc->exclude_dir, path, len + 1);
+
+	DBG("exclude add: %s\n", path);
+
+	exc->next = cfg->excludes;
+	cfg->excludes = exc;
+	return 0;
+}
+
+static void cfg_exclude_free(struct cfg_exclude *exc)
+{
+	free(exc);
+}
+
 static int cfg_kernel_matches(const struct cfg *cfg, const char *pattern)
 {
 	regex_t re;
@@ -657,6 +687,11 @@ static int cfg_file_parse(struct cfg *cfg, const char *filename)
 			}
 
 			cfg_external_add(cfg, dir);
+		} else if (streq(cmd, "exclude")) {
+			const char *sp;
+			while ((sp = strtok_r(NULL, "\t ", &saveptr)) != NULL) {
+				cfg_exclude_add(cfg, sp);
+			}
 		} else if (streq(cmd, "include")
 				|| streq(cmd, "make_map_files")) {
 			INF("%s:%u: command %s not implemented yet\n",
@@ -857,6 +892,12 @@ static void cfg_free(struct cfg *cfg)
 		cfg->externals = cfg->externals->next;
 		cfg_external_free(tmp);
 	}
+
+	while (cfg->excludes) {
+		struct cfg_exclude *tmp = cfg->excludes;
+		cfg->excludes = cfg->excludes->next;
+		cfg_exclude_free(tmp);
+	}
 }
 
 
@@ -1229,6 +1270,24 @@ add:
 	return 0;
 }
 
+static int should_exclude_dir(struct cfg *cfg, char *name)
+{
+	struct cfg_exclude *exc;
+
+	if (name[0] == '.' && (name[1] == '\0' ||
+			(name[1] == '.' && name[2] == '\0')))
+		return 1;
+	if (streq(name, "build") || streq(name, "source"))
+		return 1;
+
+	for (exc = cfg->excludes; exc != NULL; exc = exc->next) {
+		if (streq(name, exc->exclude_dir)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t baselen, struct scratchbuf *s_path)
 {
 	struct dirent *de;
@@ -1240,11 +1299,9 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 		size_t namelen;
 		uint8_t is_dir;
 
-		if (name[0] == '.' && (name[1] == '\0' ||
-				       (name[1] == '.' && name[2] == '\0')))
-			continue;
-		if (streq(name, "build") || streq(name, "source"))
+		if (should_exclude_dir(depmod->cfg, name))
 			continue;
+
 		namelen = strlen(name);
 		if (scratchbuf_alloc(s_path, baselen + namelen + 2) < 0) {
 			err = -ENOMEM;
-- 
2.31.1

