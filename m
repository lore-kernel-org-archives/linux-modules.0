Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48DAC433F5
	for <linux-modules@archiver.kernel.org>; Thu, 24 Mar 2022 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiCXRF7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiCXRF7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 24 Mar 2022 13:05:59 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD68C7FC
        for <linux-modules@vger.kernel.org>; Thu, 24 Mar 2022 10:04:25 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22OGk3Gm000722
        for <linux-modules@vger.kernel.org>; Thu, 24 Mar 2022 17:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=VXRMq3LudfSg5r46ozEnYXdrDaZRzCPp/bxo+hU/r/A=;
 b=AkR8k7IByoGQceuzj8uRhppjsJPoE0T0U8pzsrCm1OVH8WclmzalMRbt8mTEpa6aNzbF
 myAia1xUdG6VNpEMPLLZKiU7yaYonfd0FvQfWyGhqFlYEqGMYJbaFP8wkRsN8ppHDDdh
 Gq5CQjFJaQ0Ayyp7v4ZObAh45lhD58dAYkClG2RKuXO9bPY85or7MeVkriCkzj2zKBHs
 D//R+ECaPZfBZ3BYSobgZdnLZ2Lbtls9RxMkDoOLE4AVvR21LYe8oqLBU9zgZRzqMlvn
 KzIFSIF0P9nxGcftKC+mXlqDxvhL73Inh3JjoKoiPnUR3Z26eXThD+TXcJdZ5LkuHEiU 2A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ew4d04sst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-modules@vger.kernel.org>; Thu, 24 Mar 2022 17:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnEll9rdT05gNcnNDu3psA2fSHgNR8HkhzRMktbML/3FeqgKSkinhkYlXfrftbiaoNYRN/0ODS67fD6V9G5cE639frrF0l68p+zqDI5G2RgadLO8lulP8r9E339bwifBnAHptBhdDITzd06ZuqHasMfocSPrR7UjXt3RIJDx4FOksMDDMnS9lhd0jLN1JYPRJClHElqvbS10ju1ih/gOeqCED3rxdTOFGbvOm5gESB5De1R12Lq5jqg1peIpHAPH0rOSkuA5cDulM32zJi0TP4qc+zBbLlPmj2Bq4ko0H5bVlsxNUc19taJzkO7yWZr7IEmS9EIbt1EZsUXUHc3qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXRMq3LudfSg5r46ozEnYXdrDaZRzCPp/bxo+hU/r/A=;
 b=NK0jOClYq/ZlKnPRpMLQF/TKwvWjfXiO7L3k8GSjyJbFgaTuutFHVksk4Rf62K9yDjdxTbk2IdN/lTWIrBUMZhpJoXFf+5/yxJvuL3+TeKfIq9NePKbMLX9PS4kToXt+9q62PoaJsLmai0Mh7zOEc2Hgr4RpFSBnYv440MYYsTCLYPHeeag2UdDloYDXouarqiQC30JdBnen1kMw7OnuJ7Lx8MaJxDYVQr6aLXXOcvQh4ZDIwcr0ewi1TDoCj1jglztpbx9qVKwa9zsMRBumW+YJ3iI+N5QJJHvWb9HwUlLpskP2f2i9c6jqscC6EikNWd6EeUxm1hbCss9VcofPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10)
 by SN6PR11MB3166.namprd11.prod.outlook.com (2603:10b6:805:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Thu, 24 Mar
 2022 17:04:22 +0000
Received: from SJ0PR11MB5085.namprd11.prod.outlook.com
 ([fe80::fcaa:b39f:1270:2c5b]) by SJ0PR11MB5085.namprd11.prod.outlook.com
 ([fe80::fcaa:b39f:1270:2c5b%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 17:04:22 +0000
From:   Saul Wold <saul.wold@windriver.com>
To:     linux-modules@vger.kernel.org
Cc:     saul.wold@windriver.com
Subject: [PATCH] depmod: Add support for excluding a directory
Date:   Thu, 24 Mar 2022 10:03:54 -0700
Message-Id: <20220324170354.67733-1-saul.wold@windriver.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To SJ0PR11MB5085.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4f6d4ba-0e7c-4962-df58-08da0db857a5
X-MS-TrafficTypeDiagnostic: SN6PR11MB3166:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB31668236733266D5AB51AFD4EE199@SN6PR11MB3166.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7M0FjsP27KpIa6hXwN+FXPogtnjiEQKlS01IEbLeqof7RLpSKCx3FGWChTJJEDKvc0UcfsD9C53Xyla4LAATmk4Cb4Bu58fuKY7bWHsXwDx3CrfFh1orbbmbpAeR0wtpF6eIp7PDpaUZAqQjoROHoUAxxMUTkYpuM61QKiFuCUznxIMBgGP6IbbQAQRQ1UjX31PudjtONuBg0rUGaUAQ08er1oUbruVizW+1fqe4r/6ZTuXSGbpvAJtOCylnSdgxL145FF0xyf6Ikag/9DaTdr+V5+lmJ68+mbRwtfx/+lKjIwoZl288mf9md7pCQSVTFVxLG2q4i+o0tAD89Me3gmgg/zJJQpZVXpAnV9TlWZH7xqAnR+tmk7XvWQfO363MjDnHTRbsZa9IKm+/q5L4vPcQSj4Jeke9WpvXVSolnlPHeo2RUnJJQz9H0l601SarDJSowJ9ZoEcyazsOdEjJ2vL6ydW6ASEwSlYjHCxNQ88/phuXsc5SMVQxBBvcnMojXTzNdYi1wN2mrnBxS9LTFIF2neDqRdVkWOh1m0TFeYe6NOTdvRYhXILQO835OqPyBVysvwX5tX7ni8ODwn2g0vIPTGlaHjZQvETad9uKEHGdhMc/bKpEl7wJqHUZUQBzYvkYBHOkkLCnqtHiu1Io8ZM9bVK1CUM6ZkYYVkHJ5u0dyfV7SxlPHqxU41gKVG7vInUoHaLEgxiZrnef7zN7Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5085.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(107886003)(186003)(38350700002)(26005)(2616005)(38100700002)(6916009)(316002)(66946007)(66556008)(4326008)(36756003)(66476007)(8676002)(6506007)(508600001)(6666004)(6512007)(2906002)(52116002)(86362001)(5660300002)(44832011)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WsW4boFZzqUzwZEC8eOXx7LpXagp0qlbsJpaUdpR1+lsaixnnmSyI5px88o2?=
 =?us-ascii?Q?wLqO6lqD5k5b5JbmiPXzoHduHGO0N6+36tvgLBunYgRbZR+CXLzhLtQNKCRY?=
 =?us-ascii?Q?lRh37p8kzoEGETyW+V6hCXJKk0gJqbtgTE8ufPDm6NW4qmBZ5rYAI8M3i99E?=
 =?us-ascii?Q?E2ubefgtTGOUdHtrFKVmzWr7GmfZ2KKfA1A9ITZrbFcoIw5ERhrtLAqTSwMO?=
 =?us-ascii?Q?oXhVBTpNxojKlyesjpWD5aIunwiJ7/D70iV0F9Y3naltduyS0hmvEMq64kB9?=
 =?us-ascii?Q?hxhcmIRV3ubD/Fmy1fN5Ajemb491B/JBcbzlA4XTu8jcS9dJkaq8G8S/puwg?=
 =?us-ascii?Q?0/GsZP6eiAWEPYMF+MracJyAKldMUrgZd/MUJ7+L2cZ2RDTVmArQLNSYA9x5?=
 =?us-ascii?Q?FwF4S/GxNICRcmC4/O9f7nEEyyG+eiO3xHArVGUrf94unOJKqpsHQxzI96JG?=
 =?us-ascii?Q?vO9D+Lga5nhRmDxviNUf3rezZq72y+Q8k7XKymDPtF4GAAdDfStFoHjcFHJN?=
 =?us-ascii?Q?3+OzjnU/0U+qPwf1klhopl9j0qs9udR5+Er2pu9RTz/w2099o9aavQU1IrHY?=
 =?us-ascii?Q?xTWrO1k0E6nCMKEnPWHYV0D6WQk0nqP3zhkI3dUfRhZ9gThdscZu2fOZQKHk?=
 =?us-ascii?Q?SCrtcfizgHeFDUpCAsUToDnUwgpd/xC3rIUR4NfW9zf+HG0cNGpOchhvDYmm?=
 =?us-ascii?Q?3nIrsRyZsVu8vAEyTJflUdkoOiA5Kd4UC13zs+eVEOnPzI2y7BNBB2URmBVR?=
 =?us-ascii?Q?VkSdN6fwIW715PDAu+8oXT9fGT1G0tBFTx781q12GhocmNRBzLdVVC2LJI93?=
 =?us-ascii?Q?GBHtnhUYb8sVGQ/mLFDLGsqgF5u0GAjfRsoTQyfR7FWhgprH+aY9XwiFH33U?=
 =?us-ascii?Q?sbgBsNcQ7EBnxxr5QztNbYnbjuWZl5OEVL1TCJ7VI7Y+BFv7P6RfGrEaYeA5?=
 =?us-ascii?Q?ix7uMkVvl9TsnvjLH4TAHQBzQ5rcgYLQYVz/z16ssj23ZNRUyxOSIBZvVsoi?=
 =?us-ascii?Q?pF5CHV2BlKhlJx0ZRMSFR4/M7A7JZPLU6RGEKp+rTSzhKqlpCn6IRxLK9V1T?=
 =?us-ascii?Q?U99mPpCK2cj8wAfRseaLGekIs4PQOhyRruZ2gtU54CMSKJQ1cZlDW2tqRFZR?=
 =?us-ascii?Q?yebc6xX57MYxDPDgfmtIhKwYy2qOrPNTBSLDDIO6+g8LB5rAO4b1iCxlnjII?=
 =?us-ascii?Q?NoTBJImDkLQoL5UC1cu+ZBG97oBoiJVk5il5S9oWP1sSMd6J0qrH9SIRHoU/?=
 =?us-ascii?Q?73ljAD9mCSYqotvIzFycF+HRDp7sb6Vt0TICce4A8aZJsvjmxH9VCeB6uBk+?=
 =?us-ascii?Q?jPEQ6xE3sqlhYDDlFp5Qoxxp7UCvJglqpG6nj1zGZhZW52UZENKD5NRFz5O7?=
 =?us-ascii?Q?XfuI96R1U0cvSwcICatQj86HdWBVNzx6+4tDTT3OS77a0epZJo8yPEm6vWNW?=
 =?us-ascii?Q?7RGBZMTxhYrtyGGWWzVp2PC15QI0isS5z1OoP0NQnMQnmoA91/QHxQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f6d4ba-0e7c-4962-df58-08da0db857a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5085.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 17:04:22.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwTkXnqmbrtI8UrI7jWR22CULxEz68CSoiSvZQTARMtukOomKK7tFTIAV0noP9qsFpQKVGccllh3I+cPBzUaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3166
X-Proofpoint-GUID: B3RBMFWUE8r4Bj6CXaknXHZu3G8auvde
X-Proofpoint-ORIG-GUID: B3RBMFWUE8r4Bj6CXaknXHZu3G8auvde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_05,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=913 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240094
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This adds support to depmod to enable a new exclude directive in
the depmod.d/exclude.conf configuration file. Currently depmod
already excludes directories named source or build. This change
will allow additional directories like .debug to be excluded also
via a new exclude directive.

depmod.d/exclude.conf example:
exclude	.debug

Signed-off-by: Saul Wold <saul.wold@windriver.com>
---
 man/depmod.d.xml | 14 +++++++++++++
 tools/depmod.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index b315e93..9ab790a 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -131,6 +131,20 @@
           </para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>external <replaceable>excludedir</replaceable>
+        </term>
+        <listitem>
+          <para>
+            This specifies the trailing directories that will be excluded
+            during the search for kernel modules.
+          </para>
+          <para>
+	    The <replaceable>excludedir</replaceable> the trailing directory
+	    to exclude
+          </para>
+        </listitem>
+      </varlistentry>
     </variablelist>
   </refsect1>
 
diff --git a/tools/depmod.c b/tools/depmod.c
index eb810b8..4ac758c 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -458,6 +458,12 @@ struct cfg_external {
 	char path[];
 };
 
+struct cfg_exclude {
+	struct cfg_exclude *next;
+	size_t len;
+	char exclude_dir[];
+};
+
 struct cfg {
 	const char *kversion;
 	char dirname[PATH_MAX];
@@ -469,6 +475,7 @@ struct cfg {
 	struct cfg_override *overrides;
 	struct cfg_search *searches;
 	struct cfg_external *externals;
+	struct cfg_exclude *excludes;
 };
 
 static enum search_type cfg_define_search_type(const char *path)
@@ -580,6 +587,31 @@ static void cfg_external_free(struct cfg_external *ext)
 	free(ext);
 }
 
+static int cfg_exclude_add(struct cfg *cfg, const char *path)
+{
+	struct cfg_exclude *exc;
+	size_t len = strlen(path);
+
+	exc = malloc(sizeof(struct cfg_exclude) + len);
+	if (exc == NULL) {
+		ERR("exclude add: out of memory\n");
+		return -ENOMEM;
+	}
+	exc->len = len;
+	memcpy(exc->exclude_dir, path, len);
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
@@ -657,6 +689,11 @@ static int cfg_file_parse(struct cfg *cfg, const char *filename)
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
@@ -857,6 +894,12 @@ static void cfg_free(struct cfg *cfg)
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
 
 
@@ -1239,12 +1282,22 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 		const char *name = de->d_name;
 		size_t namelen;
 		uint8_t is_dir;
+	        struct cfg_exclude *exc;
+		int exclude = 0;
 
 		if (name[0] == '.' && (name[1] == '\0' ||
 				       (name[1] == '.' && name[2] == '\0')))
 			continue;
 		if (streq(name, "build") || streq(name, "source"))
 			continue;
+
+	        for (exc = depmod->cfg->excludes; exc != NULL; exc = exc->next) {
+			if (streq(name, exc->exclude_dir))
+				exclude = 1;
+		}
+		if (exclude)
+			continue;
+
 		namelen = strlen(name);
 		if (scratchbuf_alloc(s_path, baselen + namelen + 2) < 0) {
 			err = -ENOMEM;
-- 
2.31.1

