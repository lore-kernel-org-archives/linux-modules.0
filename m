Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A109C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B29F610CC
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbhI2VyN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346071AbhI2VyH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TL45j0010951;
        Wed, 29 Sep 2021 21:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=UsRukvl0maD4LHUdacyTgjMNtyEqsmwMlY3xr9Xn/EcZrZ/eQfzQhyw5KdUefC5WUALo
 +zm4x917jhJt2JMbdaCtRVIHRn11R4/VYQ0St+wY4aEtLbFY10ISFjkMdrimIUnJHRDb
 4mdUBF6VOo/keshgd0v5Zvnmla1d86eW3NsUwdscAb0JXyayuwB/tVdAxssWJ0kHb3Qx
 HsZaeT79+IiF0VG4ARF241Bi9wimVgVYYU5Hzkw+VFwvNQOzHS9SXLULjvcr1JKqrvIN
 9V0MzhZzQFDrCkBGke+6CMQINMF8h4PPWf6qs09TXm3oiDqSgTBwTHd5mTx7/i7umL8G 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchepswan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLkCmt128151;
        Wed, 29 Sep 2021 21:52:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3bc3cewskm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDAfOBGiq1EfQ6Kc9Txl2+pXVifT/bAyOpjSz37gaebStiqkJrssSL/L/3shBBCXYZgY7tkjs83Z+hqwHI4nVlxrM1Pa7INIr3I+vQweMxSIcU+EqqkafcCbzyECnZ7tJw1bAsZM6Df9e8VWyQ/5QdrhuNxmpBZaLsknVnD7xXzupq7UlAehWiZ8SRQbnaeICJ6HHa0mUc1tXZZ5gXNXXZ+Ss9vR7QnCw+cyfLSvUWFhQqDDktIeihapoz53UzYBSMn2vSahiIy/G7cFnMjwgfKLhN790QvtUIccFal17Y0aQpo38Y1pm8XVm4C7W8eirozLXyLTousVErkMfTDMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=B/+EwtbcgMmy+W3X1uiagapHTzbrEIvexV9RmUmlbq4Hm3d8qYA2bilB3T45DecNghoDyoJHIx/ShWB7sDfANISxiuuRtn4iISfTZug2fi/VZDwm14Gz8VSnwvOZGVYpPRWKmj5sKOItH3ncHKcZjwUJbZtXmqkn5G7PKKnXRa5CjA7o/IXxKmg2t4lgJ5iHE+zUKkqK8h8BkteG+D3Xtk2xEbRbjJh30uevNExH1YXV7bnNggpFyGiVU4QA4dJOPLwRVtrPcer43aGeMgy2FdAyO2Z2BqMSgMSkPFjwpI2IgT8ig5h4ZHTNmZeizFwWQBQWy1fVn0uiIXO1Eh+inA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GJ0zwXvo94iuocSxhRRma7AXGekiaAKM5zlJ5h9obg=;
 b=OBE4RMJkUNVRhAHJwkzckcJhNL/q8F8IydW6ZjqpKp2bCDtgY9B2CICW+jsnfudhijrxLbwT9juJQMK7EHUNn8lvUmeA2CIko/X3pGHczDXwsM0MShWw+INjGzF799En42Xowk72hdX9byaEVs4cJ9u9WDKX8co5CmpBv7gT60g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 21:52:19 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 3/7] kbuild: generate an address ranges map at vmlinux link time
Date:   Wed, 29 Sep 2021 22:51:50 +0100
Message-Id: <20210929215154.300692-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05cb3f8a-e081-417f-a0a1-08d9839368c5
X-MS-TrafficTypeDiagnostic: SN6PR10MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB344043DF422535588E7AE0B28BA99@SN6PR10MB3440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l/7UUapYP56KC/eYY0eZUqeO/JfiAHgfJjIGxMIDAPSTyiN7hXme2VHRGQ2QTuyaZEJGJbuz0CZFzCVKZygDopXH6bbcSMGJxT9Cv+YSeg+fatYXj8lYptxVC+uNoHv8cXAb/5yPgPYEycbmEnk9dr7vh94g3uU5xq43Htu4AbF5KTfr6nN7zHWaID+08nOnsrRXdqT6oxhpuXislKQpvOmqz0Et+15VQXspSw2YFVu6l7A+GRhSOUeOusBwrs4WSR2OCtdvlSuzLTbyXRNvUZWN0DTfqhSNqQED/UuuGle0h1VG+KynwdBqq5o925WAph1NNSLFmgRQqNGZ5rYM7JL8yWJEe5dvNG5veAfzlMztFPGoOCxYgILDviVbvz8eYWT/NKdF6Qmxmdbx/DOsnn3GX06HVJOj4ulzPlDhZBvH9cDyKBunte0pzM9g+1QgHR/9w1xDySvwSuEGJ70K5CE6BtL5fqm6ux1IN44j/fnPnSG9wwdfN97ppg1T3UrqMFKc+zXA8z5H2E5spOLnsjftMqIJyPQAFLmNutxWG5NzezYjg/MZxn+ZKhL45yf1UfKODPlt538Lz3plwl7daSUMLxrmSl3OwQ/fEZtOs44b1wxW+0l0jCdJNnysLBrL6YyjXYo42/Bil21QsIjUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(316002)(8936002)(5660300002)(36756003)(8676002)(6512007)(2616005)(6486002)(38100700002)(508600001)(107886003)(66476007)(66556008)(6666004)(2906002)(186003)(83380400001)(86362001)(52116002)(44832011)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOhMtfL9W69Xmfk0g3DVyqZk7OvHiipgnQeQN6AK2HC6tQmFvUD0ZCHCpPKH?=
 =?us-ascii?Q?oYX7B3elgH2Z0uORfgb0+i4LgReuHsUuvOao98p2XQmBco1N8O1MKEQZC0S1?=
 =?us-ascii?Q?BfbYtJeqB1mM66pAvHuTMjRTUgejeCvpR+0f2Lh5d5hYZRRvyLW5zqIugTII?=
 =?us-ascii?Q?Jwu9x5LQPh8kRTfQuucq06I4SGqkM5ZPwA9LP8c6I2ywBSccj24/ecRMnQ5y?=
 =?us-ascii?Q?K0yB+L8jIpoexAVbMnoHqmxG/tOqS6+POsdHMVuQ0xceaxL3bVJ8X0nHWFca?=
 =?us-ascii?Q?b0RKBfpzFw+jaQnFlK3u43UzNPif/dZIqoya27I7GhZtFYpVJqV4CFLaN2ZQ?=
 =?us-ascii?Q?cqKvF8Ghvg665myeRJJmbMzcRV2arRQT+fnafg8jr4oXf41BrXPTAWiJIy5a?=
 =?us-ascii?Q?bKE+osHC5g79l2Iw4IpqLnyTlHI2oQY8YgwkQfj7nsouUDqVJTJbWSutCUXb?=
 =?us-ascii?Q?Pt60kxPIVC8sp2l59gLhFacBTiqujHcUPURDd5Vv5Afd5TEiZB7eZoXjS2ia?=
 =?us-ascii?Q?tOhA1QrGBgMy0TFCecqw7pJXRGXrkmlAo81vvwObhZF0tFBYFpfhvghsTgZs?=
 =?us-ascii?Q?uQoAVnuvcxO/VLnLv/XdUhuQLQFefdZ/JmUIpDZM/XIYR6SgNs8Y/CylWQUo?=
 =?us-ascii?Q?0FWFjYoouTAmAUwQoVr/xUD6xDMhHnMHtvJ7YQElME+r0k+74YYGrPl1kAQT?=
 =?us-ascii?Q?Kc/ocZ5TmI+Uika/rNv4dvM3W78wzvWkjUIuHWfNQVk/iAei6jUFWG8ZR4Oc?=
 =?us-ascii?Q?7UAGBuLPyKqFYhgysfWm+8c2ynWXtpZxpw3uzOu9CBLB93ccYDA47PGXkSAK?=
 =?us-ascii?Q?Yx86cQml7r4nClWyZmhucofFRVS5N9ZCYcgdJwGY17XBLgT/hrh8dTzjgpsT?=
 =?us-ascii?Q?8ECg42u1fFGiEhmDam340Abbhz+BOAxVQw4ZwNIi8DIv/ZA/4LGbn7RnvjZM?=
 =?us-ascii?Q?d5cy+h27ojRPVuGMAWBEsvWza7xeLSpuIu2vP1B5ofwX2E0PD3D6cf84sTPS?=
 =?us-ascii?Q?Aej2iMKz8fc68CnWIugd8qnKN8UxrSU8V8dkCVmKIZ80A3PG6cR9ZAQQjSyS?=
 =?us-ascii?Q?fB6cTKfr4Vwc8cULuDjzsnAWnxANs53JUqDnSv91iGyzCOl5tqbwxiuX0p9I?=
 =?us-ascii?Q?rAkXyhLvJmInBVCP+UCkjcjZpaTTB1zddOZkZ1KJkInJ9CO13tcWAQpjZ0Te?=
 =?us-ascii?Q?driOtYjO0X1sUhMMqtae7pwXfxH3B36/QwcAM6pRQ7rictJ+adXhihwxQHQh?=
 =?us-ascii?Q?ho4wZvl7qvL4WVXw2FlCEsY8NnS6uTF/SkLgVdZjso2fK3poM3zgQLGxKoBp?=
 =?us-ascii?Q?jh4BHrVceyFUTTwpMTHyiJT1BCWTJzzHfTRPoc+dDlUe/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cb3f8a-e081-417f-a0a1-08d9839368c5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:19.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rz5mLdW+wJ1w/JGVx2fW4jP1sTtKkKwbJ7VGKtz7503peQNdTtflPM7OUfUyTgBRxkCdcGIAxDpZ1OHuWbezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290128
X-Proofpoint-ORIG-GUID: bg7Pw-XeqetEY79wgVVpRfEcyzaW_fn6
X-Proofpoint-GUID: bg7Pw-XeqetEY79wgVVpRfEcyzaW_fn6
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This emits a new file, .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up,
e.g., in part:

0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
0x0000000000006000 0x5000 arch/x86/kernel/process.o
0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
[...]

In my simple tests this seems to work with clang too, but if I'm not
sure how stable the format of clang's linker mapfiles is: if it turns
out not to work in some versions, the mapfile-massaging awk script added
here might need some adjustment.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/link-vmlinux.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d74cee5c4326..a30075c14a25 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -196,7 +196,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		-Map=.tmp_vmlinux.map $@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -248,6 +248,19 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	${AWK} '
+	    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+	    /^Linker script and memory map/ { start = 1 }
+	    /^\.brk/ { exit(0) }
+	' .tmp_vmlinux.map | sort > .tmp_vmlinux.ranges
+
+	# get kallsyms options
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.33.0.256.gb827f06fa9

