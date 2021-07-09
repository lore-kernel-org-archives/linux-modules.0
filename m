Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39360C07E9C
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EF4613BE
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGIW3A (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:29:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6014 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbhGIW2t (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKZ5p022453;
        Fri, 9 Jul 2021 22:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=zG1xxsXwvuWWBkeyUrsqf+zUUDbiYqlyqwVGBp6+f9Y=;
 b=y8V8dxrcRamL52vgby8lDboC6Mzf6L8QqInzk+MzjO241yMaCFUahLtaNrfPXyJaHhbC
 9w6q5+yjGRb4m6j1LG/Tk9FNxESlLg2hNiE45MxxGRevIRVhZrIFAhyVT2XhVmzK4W0Z
 5w7zpk+eIRtHOIa2KUk4nxnLG6oZWBJav+ekDqVioTTf0cK4jfsGNHVq+aBd45ZXmiRn
 5W2frJ7QzGZztshAMvesSEF/rg3QGx+bUUymRsy9yhHYYzuxK7ITfBFnyp54o3I2NPnp
 Wl1tVYSD01OXiVy7FscCwUd6BtP3p8lxNsDhbBJqs015bQ6Fv2XgPX+h3dra40+mrURY Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgmh9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MKGO9057329;
        Fri, 9 Jul 2021 22:26:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 39jd1byq7c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCy/0VfcfHJT29QRlJMEZEDFK1NblWxB+bg8NBDA/UnAcBMMjYV4ByW8qhInQGaowXiUZ0zpldfNdHDu7jDJEZMRFvNIMoBWwb0xmq5NKm66axQbyLM/vv7kgj7PKYAflLZdrJ+9eVxr7QqGhP40pEm6WjzNXAksZNznpYTuppuaegYrB/HyuUODHg6LCw/XNYTyyXfdX5Y5UX/Aw/ys4CkIRivGKKO3YCnqJCmBXoVN1JnmIOgJlDBAazVGkuIHjgN7TfuuydZTDO0SDXOJxYTgdKQwSm/M2B9N7a9h1D0/RrLSLmaHZy/hQ+Ltw5SQGCR7Bra2wysSq03T1/3qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG1xxsXwvuWWBkeyUrsqf+zUUDbiYqlyqwVGBp6+f9Y=;
 b=ZArkHpatWdVhE/Hd+kgzAGW2qqc2B5G6EXtYA0QTUmOrlP20lPA440AmJ9zS2Cv9EMFy5d+iHz/leFfYe2hS2gqkj3g0kP9icQ+DDhTWZYLWLehIa+GRV6hvLupNPeHo68TXMpOhVUPPHbX8Lc6unc/Z3WwHr+DVB/fEsM7C0M7qQARJ6rC4XMOzop3DmQtYRqdDziT8FpfoBEBBkm7ilPg7ljHSBsLWj46kwWpkZgv2Vpw3nhg63+QYQKysNOKWICcA26mQayu68OOjfRZs61wN3/GWMu1rRF06fXShP2/dgk7Xs53tjm08VgjEUMJ04XMcdZgg8c9JE4/JX/bkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG1xxsXwvuWWBkeyUrsqf+zUUDbiYqlyqwVGBp6+f9Y=;
 b=TZhJlXkv17p5wxk54/TtlpMCOABNTwjJy11duCIjscJm+1jYiQenyk6qIcg+nVfSLx5JqXK4Fx5l7PrOGhVuzZ0FoECcbvC0sJWh/2J2HbPty/usi7NjCDOJaUOKfw8gEcjxe40LwGw1OeqrqgRwq+wNDNhPsu9oSyu8UO3dx98=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:59 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:59 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: [PATCH 6/7] kallsyms: add /proc/kallmodsyms
Date:   Fri,  9 Jul 2021 23:25:22 +0100
Message-Id: <20210709222523.17639-7-nick.alcock@oracle.com>
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
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96330858-13d1-4fa6-aa95-08d943288709
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-Microsoft-Antispam-PRVS: <SN6PR10MB29277F9DFB776E5114AC81BB8B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqXq5M+31Z7Wupwilsi2iQTcj4150+xOWzMXaXfPbDGmwpnNnYJ7n88BcmXz0ljdkQyIqyUvWPRYHrDAr0OK4bP9UOlq9xd7hESPsCDo80qApl17FxiYOREi2AO0MgDCMAA0uvAvVZ55GkDdGuVQyQvmZD7SodeRGWpcX3Ft0alPyyFVGEPPTaeFYI7TLWX2oqqS7SS4ZwEczIMmoJ40RZLKKYOiV2Fd2HZDhMVAzbgAP4mfkcVYFOImKrFdfD6Dt96VPEGjN+Tuq96+sdvc6bMNZcqUac23Hy1HHRBwkEduoUyIO8AHqDmFMLEDJx0rNXG02iK3gKbsyoDhPvlNGEbew5BIb2WUJMO3KXpuoTeP1d3Z4fK+nQ4wlbviHDTQs7/GPKzw+KGt2BirzN4BpkoxTcOlUc4AKgqce8OYVmzHu3H0CMkagqbD+bqipuOFk9/s2ovKOxQcf10/lq7unaxDN50cq4r/PrxDTbAUReVxEc5LlfCzMgQ/yOo+sGyVmadkovppZfnfXE5ArnOJTUXECsLJPXSW3rx6NiA8hyvyKwTn8G/SCyJavLAzXTfQfLgsTpFBjRic1gad7ewIVGTWxhH3GLWYQ9QXUUjBNjnt19SVwxah2jBGS7jnYX4p/YavrPJtafSQfgZUUvJBEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(8676002)(83380400001)(2616005)(66556008)(6506007)(30864003)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/f3zogtEgj3W2Sie3gA2VRhHowZoE+zLVpQzdeEsmNE1Zw4kLZ9I38cp94LV?=
 =?us-ascii?Q?kYodEb8R0ygUxJYzezOC5CBPPEFTJjtptpaPbGWzrTQUAF/szu+JcnF1EveL?=
 =?us-ascii?Q?G6roUzIh/9TGQi1giWLAkoDbSyt0kXfhhHOlnPKQ4OqFuOv4vcfG/o8fqXDK?=
 =?us-ascii?Q?LGUTM0FLR8nQL8P7dVthTMcZ8ip5Pz110hqhRwsN/Auxvhw/QfwkJjjk3vSh?=
 =?us-ascii?Q?y10mo8Pf/981uOXmJ+T/CeUoDzX5J9oTqGE7z51O7dkQgHrXt3ClMOWzpkK1?=
 =?us-ascii?Q?zfbao4L0BPsdOEehY5Y8IZt3w6Z9JRBu0AUx3Lu9pYApQHvBzgx+rjdr6KHE?=
 =?us-ascii?Q?3LRdMOZQqG0Ygr97ganiaUVFaifCoQnjGfHCAnU0OQoXIoOMnrtJ4ppPCyLf?=
 =?us-ascii?Q?uYPgCOF+3I3e8APYW5ya3XQNrNX2BFPxjKOKVngrvYH66Jx+mba0mYReRV/C?=
 =?us-ascii?Q?cLCuu/a6UZpMtd2lD2GtsSy7BMaWYMYTe+mrCr/ZVGQQFpkvlJGfp5PU8lfy?=
 =?us-ascii?Q?qxyGs2qqKaWsyb+EjDVP5tmJOFgAdVy5153dH5cJLcKo9/gZxpSDF9nnw/ot?=
 =?us-ascii?Q?RMGMfJ2obrvCBXAEU++fPnhbmZLQYDwBC8LqSkC4wmPgTbM9yt+UJ9pRz8Ve?=
 =?us-ascii?Q?CmCSN4C9/Hz4uq0zEu2OYxKTMnKaL7QFR7KyArikGeFTa9xtTq8IKVDJYSK+?=
 =?us-ascii?Q?MWCoM8WFoYvf3q+LuyvVWCO0Odk/illuCtLz2xITE8l+k+Tp1fYdlY8Couqe?=
 =?us-ascii?Q?MXo/UDT7Ifo5ydCUmb8LW8pVZXCXvlwwoNdq2d8Y077LqzfACN8yXj5Qni4J?=
 =?us-ascii?Q?OzDmlPSpo7Y6dpuS9G7/UIzsjaGPTeqNRDrV7x02OaFX6ZMq6d01Td/azAc4?=
 =?us-ascii?Q?YKkq6l/LmUkL46sMhSdFyB2McB9xFvTJ8aO0psfwvTYqw08qqxP2F06nGqov?=
 =?us-ascii?Q?rpFec3HunJl6yswthAHpii9Q7ZbrdZCSakEnt1u0W+flke5AS8mbJgLL3Svo?=
 =?us-ascii?Q?o/z/MA5bwIFvSVtG2CHzei/NLwv6fUeXAB1J3zs5q94bG9SZfjJFflm6OTok?=
 =?us-ascii?Q?z98z4R80g/pDm3aM4G9jbE35u7wYsDWq3IKUcXeOPR0gkdlylWlJHKh8SZ8v?=
 =?us-ascii?Q?sZRi2npmIXYBDVdjaYvL2vF6exXPtNz6Cf/bjPA2L+Shk/8tDcABcCP6z8iv?=
 =?us-ascii?Q?dSVnqkCH391JtpTMY/Flpw3TwBTEbO/2bFDgKB5f94XlFy8URQQPQ8G58gXM?=
 =?us-ascii?Q?OCROZPcNOMRMmZEWq3u1T0hzkKSoeSyP8n4c4jwlyUDZTeVDojMiIDUX3DEN?=
 =?us-ascii?Q?62P//uIlkm0Pky4DkkxrHdYNRpa4T/OQb2PYX+raXHjQ7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96330858-13d1-4fa6-aa95-08d943288709
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:59.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YzeCSM9BHu91t4B8Dv49V3YMR2DhwivO43xSvhGsH/7mrBSqacqbgLVPpcYQguUKH79GWdUbnDonKQGIlRCdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090113
X-Proofpoint-GUID: uK1Ia9scf6TEskaujHR79682fQvUd9a9
X-Proofpoint-ORIG-GUID: uK1Ia9scf6TEskaujHR79682fQvUd9a9
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by size, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms,
where all symbols associated with a module will always appear in a group
(and randomly ordered).

The result looks like this:

ffffffff8b013d20 t pt_buffer_setup_aux
ffffffff8b014130 T intel_pt_interrupt
ffffffff8b014250 T cpu_emergency_stop_pt
ffffffff8b014280 t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel (but,
obviously, not if it's not in the .config at all, or is in a module that
is not loaded).

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 t handle_timestamp  [liquidio]
ffffffffa22b3b50 t free_netbuf       [liquidio]
ffffffffa22b3ba0 t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly
brackets} or something to denote built-in modules: it might be possible
to drop /proc/kallmodsyms and make /proc/kallsyms emit things in this
format.  (Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_module_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules array that relates to a given address.  Save a little
time by exploiting the fact that all callers will only ever traverse
this list from start to end by allowing them to pass in the previous
index returned from this function as a hint: thus very few bsearches are
actually needed.  (In theory this could change to just walk straight
down kallsyms_module_addresses/offsets and not bother bsearching at all,
but doing it this way is hardly any slower and much more robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 kernel/kallsyms.c | 241 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 226 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index c851ca0ed357..ac095691008a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -45,8 +45,18 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_module_names_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const char kallsyms_module_names[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
@@ -182,6 +192,25 @@ static inline bool cleanup_symbol_name(char *s)
 static inline bool cleanup_symbol_name(char *s) { return false; }
 #endif
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -285,6 +314,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules, or (unsigned long) -1 if none
+ * match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_module_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -495,6 +572,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -525,6 +604,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -544,6 +625,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -558,6 +641,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -578,23 +662,52 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
+	unsigned long mod_idx;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		if (kallsyms_module_offsets)
+			mod_idx =
+			  get_builtin_module_idx(iter->value,
+						 iter->hint_builtin_module_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings) and module names are known,
+		 * and if the address was found there, and if the corresponding
+		 * module index is nonzero.  All other cases mean off the end of
+		 * the binary or in a non-modular range in between one or more
+		 * modules.  (Also guard against a corrupt kallsyms_objfiles
+		 * array pointing off the end of kallsyms_modules.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
+		    mod_idx != (unsigned long) -1 &&
+		    kallsyms_modules[mod_idx] != 0 &&
+		    kallsyms_modules[mod_idx] < kallsyms_module_names_len)
+			iter->builtin_module_names =
+			  &kallsyms_module_names[kallsyms_modules[mod_idx]];
+		iter->hint_builtin_module_idx = mod_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -640,7 +753,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -650,7 +763,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -660,14 +773,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -676,7 +789,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -687,23 +800,67 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf (m, " [%s]", walk);
+				}
+				seq_printf(m, "\n");
+			}
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
 	} else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -711,6 +868,35 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -746,7 +932,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -754,7 +941,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -767,6 +954,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -777,7 +976,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -794,9 +993,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.32.0.255.gd9b1d14a2a

