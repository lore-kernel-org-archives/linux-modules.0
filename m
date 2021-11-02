Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB16FC433F5
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60066103C
	for <linux-modules@archiver.kernel.org>; Tue,  2 Nov 2021 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhKBSl6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:41:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60608 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235445AbhKBSl6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 2 Nov 2021 14:41:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IJ5fv007858;
        Tue, 2 Nov 2021 18:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7TXkWjpwrWe/ryW7X7pOUfExes4pJxwOTKjx9YlON5k=;
 b=BmbK4kYmZnkN4p6xW7IjH/fmCsBJBZy37CSjB7tCRiCKL2mpPSw4b8Y4h7430eWn73LO
 aiL0HUvN8+f7MXc5g2Kf0r8uiooVvs9ow7Vokj+6+48CxjBshp4RLrA0kkB+V60VBuJ5
 gbuMG1IUsV12A6tveBobn91RXnoWnkq0F8t5N5lD2hv5JtZ+8p9C8e6CWwz6Ckmz8Mum
 6FhyQIyUhY8peB5mbz2jw0yHAWZ7ROP4AisQD5aRWdSSIIgkmIB89/hr0SO4vcsatoJr
 K7RVV7IGxQFcgXJ09dy6+1uJmya97sLH7F17pdTYCyucoDLJrxSqTrYw+nw9W2eUACi6 rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8hebg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2IKKU2110028;
        Tue, 2 Nov 2021 18:39:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3c1khu13pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 18:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm4GT2gBkGc3DdIbZymmZL2aHdJFoFuWw1Scy0grkdMftU2ZvWLIuWyhPJHYsB1ZnBze0ca6QRLVTTopmIWk7yudR6oqD3QInwdAlDcQxlfbIYZXMH0/fbtYUfj/EGsi0qC18VJEJQewAYoZXyD3SDa+pT06gc46DNbwOnSKvrIAYzsXOQT+fl3yuyWRo6gt6V1nQe4VpImUzKO1CmYZmBLj+TsPp+1+Zu+IyoF+7HVbfPRMnQ8iReTcQ+nDubhNF8e5a/iJsYibrZ1ka9ILap8DDpDbUwR0hQv0t844q7+sGtzbRcsMsohKT8rLRFVuOlNTArmoEaq+jq+jchX5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TXkWjpwrWe/ryW7X7pOUfExes4pJxwOTKjx9YlON5k=;
 b=N9h1K35aG8Q1cbx3HXByY+7CiNGSLPCq9Ey35HT0AiT8POiYYOrWxaphlNkbDgvVn8V/a+3aHh4vmnpiAQIRa1Krttb7afjRsG2RbXidT5C2VGvkS+7wLpnP7AOtt4meyJlob1HDLYn8ckHz0GuzHtiVS28uTTsCJ+W1rG1idZjZFF1KKdiDdJIXKenKG4EVjceQjYi99fhKjJzXDAlHhOgp5ghilj5oEjzX22CKJTZEvyzlsqtRGCbA62N5SE2Dc3Jl9UkaQp72XiIKaS1psq1WgIPGoF1b1pCdvF3OkgcF9xxiEXMxAIGeax9gXDaHD2uHpyXjVQV0n9FJ645GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TXkWjpwrWe/ryW7X7pOUfExes4pJxwOTKjx9YlON5k=;
 b=ZgCkpiPk5hzR4H3KtgtQ5rzI0UG45SQDE4DvKTHJ0SciPCtNPhm0aopwNQRhyHJQzK04FYJRsz/5dULcJ1nldB+lHxVtiMzc4tZraiuO6ZoJaIODPKtbIA17avHM8bOD1zkegMYUN+IJcWJqKf7ET+vGK+IwsqBQo7mvXwpKJNI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 18:39:14 +0000
Received: from CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e]) by CO1PR10MB4706.namprd10.prod.outlook.com
 ([fe80::1d71:7751:c11:e12e%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 18:39:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PING PATCH v6] kallsyms: new /proc/kallmodsyms with builtin modules
Date:   Tue,  2 Nov 2021 18:38:44 +0000
Message-Id: <20211102183851.168676-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 18:39:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e85d2f1a-423e-4aae-dc8d-08d99e30115f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566EED3DC946A6199FE231D8B8B9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ3SjwakG03LIAOW+yN/ekp5nzQrV9roWOKV2d/QwzVU261txYu8wJzNSkbY8zaCA2JmEZpZdD93+acBL+vbcDI8ROdEoxpdFbsQo3WAZnEO9xWjF0ANtPqlGllyptwyCrtvOVBlGb0U79mKtXEGEdAV2uEXG9FFHDsFE3a736nzc9yCPOjRktH12U617wnSLVYklMDID+Hwl7dYj1dswn6c+Nau5bvI1HrmTSVyqoPp9sGRphHH97x5HaKx6+9WSUIg/g1idjnWEQcHkFynjdbcxiQDSGpiH5PmNBxozWHgx7CeEgfU7INolM9uzjLWSE+lRuBaliRxSTxoXIhzhuKcTPGyij909egdJHPeaH5IbibGYIPaDNsGU96y7JVu5aqZjx2t5t4YCGXKV0JTh89wdE2ZQzuFC90Yvp6VWpRONX2hA3Y/vM/yjp4YPQYWN8axJMuR+jiyFPGa/mywAnvag+zFaJi8bCm/bg4HTv/ron0sGijxY+iQo08RBXKJ+ASfff768KOvV2Cdx+3Qurljp5rKOF+eKjYTUO8W+Y2XiS576I34TAFceDgTp7bkLp0x5ZRFOH348Qj+npXlcU8WT2pm2anXdqFs6X01GjjAa7UyDI8umnGrwEZ8w5Wa6udIbOUseyT6sYqfgxSjHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6506007)(5660300002)(4326008)(66556008)(66946007)(86362001)(66476007)(6666004)(2906002)(36756003)(30864003)(6486002)(107886003)(186003)(52116002)(508600001)(38100700002)(1076003)(44832011)(8936002)(6512007)(316002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuc44AnI1U0AB9YiAn6S5ts0Q2s9VL5GJ0Gf1k/RfAM7PgZIHZOC+k47dkJP?=
 =?us-ascii?Q?OtH3OJ49K0gY4QGJmix552hVq3o/SRwT88YAS7MsAO12oyd8RyhkgryJBaf/?=
 =?us-ascii?Q?4zrd1XxUUolwQZJK/Ji/twygSPb7KkGiT5IsYL/gxT4983K54lpYJoQtKs4w?=
 =?us-ascii?Q?tTOQf10Dt96YOTTiNmlx0mhbgyHvKqrKtxGx7FTUfdvTVExu3nLDZ3Ukj8F6?=
 =?us-ascii?Q?FhqJQGf2NVBHV4AH3o7q2NdN9+l0rWZorxt++fN1C4DWKwYFf9PIoHbceTKU?=
 =?us-ascii?Q?+ZSnkalcpDTdGqnQbiOUUlddpFDX2IYvpOHtz0gzpSzY6138rX7qe0dd6433?=
 =?us-ascii?Q?IGKxZh47w3h+qbtZBecKhFYHwxyWTMsRc0bZ/23cnVEQLdNqjisIwXWlNv7b?=
 =?us-ascii?Q?eAkOYCwHx4KEAF+QC4OgIT1ngxpYrvRGjAWAmiDu99X56Tx78JMFDSjbIHhC?=
 =?us-ascii?Q?sLIaSkKO1KsukmgKg5GEt+DtTknIcjXBQ8Xx3++raPJRIcPdUzal8W4PJCVa?=
 =?us-ascii?Q?UrkjYuaMc9vFj9KY1qOWMOU/HjIOovmDTK8Vdh6t14YvBH2+4Wp4IFNLLZqr?=
 =?us-ascii?Q?Fa7dO1OUHUYRnwpyWE+pr8vOa05jlqF9ZLs22f9URpQ4RpMxz1WVcEDxAoX3?=
 =?us-ascii?Q?MEPhMK/F3bbTspQZBHBHgWDT1BNaNb5fn6qJIkZvZirx/MB6++xq9rdk2w5y?=
 =?us-ascii?Q?5ML11yUSDRfDi4KxO3AuTruQo6Lqq02MX6cXqN+phUUkRAgODdJTaTsjYPjb?=
 =?us-ascii?Q?UqHaXsz4BHA9D35jWzAUh9PtVPPU41bDCzn3SRNCEufXe2alvlpAIHu9d6yB?=
 =?us-ascii?Q?FUhUS3k5ZD7pllxmZkU7A6yqqViPevcqlRtPXl/B19p4l6ftiFsCXF6yvC4a?=
 =?us-ascii?Q?nq9kEQNcO+/+3CHmQt7vokM0rL4MF6BdDafZzfMhkU5ssTV+cEObBWor52yI?=
 =?us-ascii?Q?PiQUaFBVUo3/659SOIP4n+zSuaqBC2TmRmtRnr9J9y8pT7ea4mpfww/62fym?=
 =?us-ascii?Q?oq1/qWIXot//+Cu2sIqTwaok9FRKXIxDf1G3ftoVYKQCqjEpF6MOI1V2x9zu?=
 =?us-ascii?Q?HTPiR/MMX9MiXw8AFr7MCRu3IZuKUgq1kUZPZWVVyElgjW0CadEBIWC2ok6O?=
 =?us-ascii?Q?azPgIRz98V9Yhs7NzPOfL23NJbqLwU7EupPNx87prJ6pLnL6GYufqJR7zULd?=
 =?us-ascii?Q?wNM6XPKcN7odeSkNeI0MlG46/26Wcb8cdm709bClCuq2ylPH+xobVW4UpLGj?=
 =?us-ascii?Q?aIl3jtAQcQNQ9Lx2uFQpHftIwpUIaO28A3nmIf5lQRdfSf/0QTUm3o7IV80R?=
 =?us-ascii?Q?tP8DBusy4r0Ump5ETAb151EadL+SC4uuZfaJ3FkPF5pvJH2egD2xckgY7nCM?=
 =?us-ascii?Q?lIT/6T0ayFfq6yJSPtm05QYqKFjC2bTVetaGDrMb6YekYYQemCIwdCQM1JKw?=
 =?us-ascii?Q?klsJiRS9huW4Ld1hsc0ArFvd1FfOk9FBLqgKHAFUfq4O85cbyQmqFGgn015z?=
 =?us-ascii?Q?ah9TGDDy4vagOXCCH224Lenh9bW39h+VeJlb3s0UmZ4QFc7zyDABFp28/hgl?=
 =?us-ascii?Q?dtlWqDSQgttNUMEvTEvVUxgIE5VXg2RzW3LAeBwkjifT39QFbMovqRlKyGgx?=
 =?us-ascii?Q?7ndv9trU4qabsleqCbDQwk/jgi1RH9dt+9OUrQpyH7iY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85d2f1a-423e-4aae-dc8d-08d99e30115f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 18:39:13.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agtj9JPxy5EfWcc140/AjNSK6uu8uKBAVip9imCtpFvW4VSeCffEn94bgCTD3lffdsm/3eN4u02QgBmox3T+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020101
X-Proofpoint-GUID: bGhT3oZ7gx713_dW0GFo-z6jvHMkobf-
X-Proofpoint-ORIG-GUID: bGhT3oZ7gx713_dW0GFo-z6jvHMkobf-
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if there were a mapping between kernel symbol and module
name that only changed when the kernel source code is changed.  This mapping
should not change simply because a module becomes built into the kernel.
(DTrace for Linux already uses the approach in this patch for this purpose.)

It might also be useful if there were reliable symbol size information to
determine whether an address is within a symbol or outside it, especially
given that there could be huge gaps between symbols.

Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
when set results in output in /proc/kallmodsyms that looks like this:

ffffffff8b013d20 409 t pt_buffer_setup_aux
ffffffff8b014130 11f T intel_pt_interrupt
ffffffff8b014250 2d T cpu_emergency_stop_pt
ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 ab t handle_timestamp  [liquidio]
ffffffffa22b3b50 4a t free_netbuf       [liquidio]
ffffffffa22b3ba0 8d t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 b3 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 203 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 16b t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 1f t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 1f t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 d2 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 9c t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 11 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 11 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 2b t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 738 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 368 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 37 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 18 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 2e t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 69 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 92 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 175 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 ab t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 4a t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 2b t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 7e t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Much more detail and information on the (nearly nonexistent) memory usage
impact below.


We have to do several things to make this work, to figure out which
object files are in which modules, then which address ranges correspond
to these object files, then turn this into per-symbol output.

First, generate a file "modules_thick.builtin" that maps from the thin
archives that make up built-in modules to their constituent object files.
(This reintroduces the machinery that used to be used to generate
modules.builtin.  I am not wedded to this mechanism: if someone can figure
out a mechanism that does not require recursing over the entire build tree,
I'm happy to use it, but I suspect that no such mechanism exists, since the
only place the mapping from object file to module exists is in the makefiles
themselves.  Regardless, this is fairly cheap, adding less than a second to
a typical hot-cache build of a large enterprise kernel.  This is true even
though it needs to be run unconditionally whenever the .config changes.)

Generate a linker map ".tmp_vmlinux.map", converting it into a new file
".tmp_vmlinux.ranges", mapping address ranges to object files.

Have scripts/kallsyms read these two new files to map symbol addresses
to built-in-module names and then write a mapping from object file
address to module name to the *.s output file.

The mapping consists of three new symbols:

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are
   assumed to tile the address space.  (This is slightly more
   space-efficient than using a size).  Non-text-section addresses are
   skipped: for now, all the users of this interface only need
   module/non-module information for instruction pointer addresses, not
   absolute-addressed symbols and the like.  This restriction can
   easily be lifted in future.  (For why this isn't called
   kallsyms_objfiles, see two entries below.)

 - kallsyms_module_names encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  Object files which appear in only one module in such a
   multi-module list are redirected to point inside that list, so that
   modules which contain some object files shared with other modules
   and some object files exclusive to them do not double up the module
   name.  (There might still be some duplication between multiple
   multi-module lists, but this is an extremely marginal size effect,
   and resolving it would require an extra layer of lookup tables which
   would be even more complex, and incompressible to boot).  As a
   special case, the table starts with a single zero byte which does
   *not* represent the start of a multi-module list.

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).  Entries in this list that would
   contain the same value are fused together, along with their
   corresponding kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in here do not really correspond to an object file, but more
   to some contiguous range of addresses which are guaranteed to belong
   to a single built-in module: so it seems best to call the symbols
   kallsyms_modules*.  (The generator has a data structure that does
   correspond more closely to object files, from which kallsyms_modules
   is generated, and that does use 'objfiles' terminology.)

Emit a new /proc/kallmodsyms file akin to /proc/kallsyms but with built-in
module names, using a new kallsyms_builtin_module_address() almost identical
to kallsyms_sym_address() to get the address corresponding to a given
.kallsyms_modules index, and a new get_builtin_module_idx quite similar to
get_symbol_pos to determine the index in the .kallsyms_modules array that
relates to a given address.  Save a little time by exploiting the fact that
all callers will only ever traverse this list from start to end by allowing
them to pass in the previous index returned from this function as a hint:
thus very few bsearches are actually needed.  (In theory this could change
to just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much more
robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

Those symbols that come from object files that are genuinely reused and
that appear only once in meory get a /proc/kallmodsyms line with
[multiple] [modules] on it: consumers will have to be ready to handle
such lines.

Also, kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am open to changing the name and/or format of /proc/kallmodsyms, but felt
it best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly brackets}
or something to denote built-in modules: it might be possible to drop
/proc/kallmodsyms and make /proc/kallsyms emit things in this format.
(Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)


The size impact of all of this is minimal: for the case above, the
kallsyms2.S file went from 14107772 to 14137245 bytes, a gain of 29743
bytes, or 0.16%: vmlinux gained 10824 bytes, a gain of .017%, and the
compressed vmlinux only 7552 bytes, a gain of .08%: though the latter two
values are very configuration-dependent, they seem likely to scale roughly
with the kernel they are part of.


The last patch is an RFC to see if the idea is considered to be worth
spending more time optimizing the representation, which adds a new
kallsyms_sizes section that gives the size of each symbol, and uses this
info to report reliable symbol sizes to in-kernel users, and (via a new
column in /proc/kallmodsyms) to out-of-kernel users too.  Having reliable
size info lets us identify inter-symbol gaps and sort symbols so that
start/end-marker and overlapping symbols are consistently ordered with
respect to the symbols they overlap.  This certainly uses too much space
right now, 200KiB--1MiB: a better representation is certainly needed.  One
that springs to mind is making the table sparse (pairs of symbol
index/size), and recording explicit sizes only for those symbols that
are not immediately followed by a subsequent symbol.

Differences from v5, last week:

 - Fix generation of mapfiles under UML

Differences from v4, two months ago:

 - Fix building of tristate.conf if missing (usually concealed by the
   syncconfig being run for other reasons, but not always: the kernel
   test robot spotted it).
 - Forward-port atop v5.15-rc3.

Differences from v3, a month earlier:

 - Fix a kernel test robot warning in get_ksymbol_core (possible
   use of uninitialized variable if kallmodsyms was wanted but
   kallsyms_module_offsets was not present, which is most unlikely).

Differences from v2, a couple of months before that:

 - Split the series up.  In particular, the size impact of the table
   optimizer is now quantified, and the symbol-size patch is split out and
   turned into an RFC patch, with the /proc/kallmodsyms format before that
   patch lacking a size column.  Some speculation on how to make the symbol
   sizes less space-wasteful is added (but not yet implemented).

 - Drop a couple of unnecessary #includes, one unnecessarily exported
   symbol, and a needless de-staticing.

Differences from v1, a year or so back:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod
   below. I considered more extensive searches for mergeable entries and
   more intricate encodings of the module name list allowing TUs that are
   used by overlapping sets of modules to share their names, but such
   modules are rare enough (and such overlapping sharings are vanishingly
   rare) that it seemed likely to save only a few bytes at the cost of much
   more hard-to-test code. This is doubly true now that the tables needed
   are only a few kilobytes in length.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

Nick Alcock (7):
  kbuild: bring back tristate.conf
  kbuild: add modules_thick.builtin
  kbuild: generate an address ranges map at vmlinux link time
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: add /proc/kallmodsyms
  kallsyms: add reliable symbol size info

 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  23 +-
 include/linux/module.h      |   7 +-
 init/Kconfig                |   8 +
 kernel/kallsyms.c           | 304 ++++++++++++++---
 kernel/module.c             |   4 +-
 scripts/Kbuild.include      |   6 +
 scripts/Makefile            |   6 +
 scripts/Makefile.modbuiltin |  56 ++++
 scripts/kallsyms.c          | 642 +++++++++++++++++++++++++++++++++++-
 scripts/kconfig/confdata.c  |  41 ++-
 scripts/link-vmlinux.sh     |  22 +-
 scripts/modules_thick.c     | 200 +++++++++++
 scripts/modules_thick.h     |  48 +++
 15 files changed, 1301 insertions(+), 68 deletions(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

-- 
2.33.1.257.g9e0974a4e8

