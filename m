Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B7C4332F
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAF261368
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 21:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbhI2VyV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:54:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346466AbhI2VyN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 17:54:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TKthL5032192;
        Wed, 29 Sep 2021 21:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cDnlvyIOqvnHQ/aW7BgZReFoQjnr+wWq5+8W+U6dikQ=;
 b=CEyQDsPOc8mfGybYj7azbF9D+Wg/V6slO9e6qBaN3YDfTKtAsxX0Wb61/qn2SYdHkgJM
 UM67TohOR91TTIx+V2VUN5pJ9yT/y+8O0JMzZltcgzCRZPsUVUrWs0t4YO9Wricoa971
 hDZHHw6xuaW1vaCrQ0L/gNGpOoc8muooZvO8RhXVVsTGRoO+F0lOWgosrychxnr6NJmH
 erJ1TiVJJkrpv9M18qqk4BNu95DHNd73cGN0qXPkAuMbkkrI09YshkagRQqLDTCCxmSg
 3bhJKCQ5lbj0HOu1+iIQDmWa6HR1ZqGQv0+CpwiPgnVMtbtMmrtcwvsemwN1xHlhJK7V ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfkxqr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TLkTAn070931;
        Wed, 29 Sep 2021 21:52:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3bc3bkmp6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 21:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8fd38wjZdyRv0TPXj1QDzeFENJUMCVBdUUDrz447+1T4aM/oqmi+z3lw8+auCbGu+OGoycRGkD93D/4LfU4XMkaZ1ONbtP4P5DTrud2JXpvk9fSZ62V8pW5R2+V0ptdRl30xqmzktQP+RrhoJcQm7xNUneU06whCrZTTkPOivvNejoti+MReLWv5tY8DiLChi4VcnQL06PPcNFHDV4L8V2agGfh8GLPRvxm8d3jXgocB6TOFDbhOAybg28rN3mukH8O91wA1griDSfsKoBH7fEI9/WXpn85ahXym8DB5S0dJTjtiElj8jgrkMMUgzb0Y6lO39JYicYdXP/NC7mWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cDnlvyIOqvnHQ/aW7BgZReFoQjnr+wWq5+8W+U6dikQ=;
 b=ILUx1tLVlpECT0RFZfbNzN5IDoS1Ztsr5670nOKT0KppZreqEIevqLvH0715QhrjK3SjPmvYLRC4NIxg8dwVkQyVslqAXmQi56aZ3SCPKGI+d65iDm5jCBa6aA0B3u3N58G++OKG9R8A1ZxcUCkfwC8LBOWZP2JAnM0rVJPzD4PLx4F5b9Q4r5O8i7sE0TsnsFLUj68yZ6SoVkFJ4O0WsUV0R+78YEAwO9i96ixFz+jaXKBbghRHZR1NrHBWYhqkjOYTW9TeboHx3MZ+fDXW+QnmGqGGwblFQswKwFPftDmrqw6YJL9syhGiI4rzwrlXWbbDA+CfbP2xybjhW7UYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDnlvyIOqvnHQ/aW7BgZReFoQjnr+wWq5+8W+U6dikQ=;
 b=kdobtpd6eJJnvID23Mnf8U3+CAjBF88nWEgKSzgkxSYB1KZ8aez3IUA19P72A8ukppBEcfKThxdLpJqbSZ9G3istkubdOWUcKFRp9VqFUfcQsXsnE8OyRsgISLpIM34Vug47cZ+XaExNRkfVuu9C8gGT5aT6bomFJ/aoVpVRYo4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB3440.namprd10.prod.outlook.com (2603:10b6:805:db::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 21:52:23 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 21:52:23 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PATCH v5 6/7] kallsyms: add /proc/kallmodsyms
Date:   Wed, 29 Sep 2021 22:51:53 +0100
Message-Id: <20210929215154.300692-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.0.256.gb827f06fa9
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 21:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26c7655-aee3-4790-73df-08d983936b7b
X-MS-TrafficTypeDiagnostic: SN6PR10MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB34407BC3A6E3824319259EAE8BA99@SN6PR10MB3440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCG6nUI0gjBl1zuJ+SHQJnjcqI3MXO9wv4m1XdfPEWffcAc74QdHc+V0ZEzXcms8ZXQhK2uSAZbA3rqE0pzeK6xFhw9IHnd6gt9dtc5YPEzhTKHPLAIiww2f9IShYlRHppJOS7SWemg45p3tWyefVYwaSTbQGOXWTUQjMfojAXwGlCb86AQmdNPMzOSkMl/HYaAPykxx89CsfQ+DlAGhRQjEnhkQPxfrhZX+NmcvAt2RAguvCdBW+8/XlUhYOKJe4L1HcVc9j3ytaxUlAWg1gnMFJe+yV8X0fIUjlgEW61F6LeGBRI6n5uJ6APRLZurXwjiuM/RTBNvqu3rUaUTGWcYS6G+1T7Bd04sqNcT9GUuHN8eorRP3rV8acdjQjAbUOscrbizIPehnt1WdnLss9kGJmr24ih7qOFl33cj+zE8+rrtTurKYSBiF3Xgi+/xW1NN0Kj66Nvd0IzUPqgAhCmRHg8rO0QMol3vGJ3MVDrpfdvgjs9SF1x2fyP60yl77AcRYZbEsr34wkcPr7nzbX8xw25KfZuDrc0kfw0YJaxVyX1jBuH+RU4AS+wzUVDUfm9kUjvvwDhOhkxGt1e5gJUTIL6SWORJEU2FPiQKIKp2dSDnkS2sfWOERbj9xKsn/SgQPk0w5c5Ejs2TVlxkiAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(4326008)(316002)(8936002)(30864003)(5660300002)(36756003)(8676002)(6512007)(2616005)(6486002)(38100700002)(508600001)(107886003)(66476007)(66556008)(6666004)(2906002)(186003)(83380400001)(86362001)(52116002)(44832011)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/DvEi56MN8NZmePePrY4oR0ipGwvSFgR7J31lQSAwgaaQhXBojWGtN2jXTo?=
 =?us-ascii?Q?bZ+Rb5LqdoO+fzP4Oc3Rz+T0BIeysOBfrCjIRh8ICT10SiFX1oK26rtm4HFT?=
 =?us-ascii?Q?XzUsr2zr4A5suzzZen6dQivou9tA0qckOTD62HMswwEEl2lHS7YgU11uio4M?=
 =?us-ascii?Q?k9DOFjXpZ3r8kSia+NE8pjLrj/JLi4L0D4Q+koZO7d/FtZiwEMW/uFKW/blh?=
 =?us-ascii?Q?8jx8xWUFARoCkogdLGYIBsd8Tv5iFFdcydDZ3v9nA/CJO5qeYcKDBiIwoPUW?=
 =?us-ascii?Q?zFPr9EW/wV5dMgeT0M0HZw2vADMnQvOExneEWm1v6MV883Wk5ZVsXV5ptaIa?=
 =?us-ascii?Q?8e9ZR8hPDM2BKqymDFMUaEDlcr0HNfPaY+3LZtUWMjZg9NVtcgmzziykGC3Y?=
 =?us-ascii?Q?xm8c6hHpeB+51Wxg5rvsnDA6YOdhiy43NyQbCA+RXjraUEr2PRDIRCZuGzKA?=
 =?us-ascii?Q?nDbQ6avddQ9NFZQdMNtmIF9Eu43lgo//agLotjh5wK67pcbZos3Qi98jIxTy?=
 =?us-ascii?Q?BeGTwTefyQ0pLYkU2Yyd5i1/6GoTwgyf0jK9/3xP+KsH8SqOuevIRprNFU3/?=
 =?us-ascii?Q?5WecGsfnMjV1qFK15KVcXndI1mB0VfhGn8ygzp35J/16WkH2uUpeKavG06cK?=
 =?us-ascii?Q?027S1J7maJYHMCxsd5/fUJAfm2B4fOcEBruszuJwZlweUpsKRpOxt3ffIxxg?=
 =?us-ascii?Q?/a9Y0N6fA815JjEbh03sv+8CRTB5ogeTyU2hS1pd/Laqj3m09tbGy9HflDhe?=
 =?us-ascii?Q?Fq+VbKbu4/FDa3/Xk1Ghy87zQuoKetCtd5wPgYe7lb5AphJtoLwuT7m9pb03?=
 =?us-ascii?Q?D1lxNa22vAtqXeLLqEkuuwKWwpU8TJKHCsacQkNcSYQ4Fc0dAWq7uObOKO4H?=
 =?us-ascii?Q?Ntz42Aew9T8zrF1OexY2lbdMwmuatMPj9zcw2A2EU9q/86bYZBou78IgeZjt?=
 =?us-ascii?Q?pJUal+1tnGzdXLclVqbDtT5TSdKdS4PUV0poLU3+7iyxdCyC0cIah1Lw4y2J?=
 =?us-ascii?Q?Xq5feeFrsoxJBVuTkxxOK3oO1HK+3hm26zqn1K/wp/YMkwwG9c7IZ/XfxS+b?=
 =?us-ascii?Q?AWqDKifdKm9v7r86mXGBEJ/YCpTOsz2I4tb8wWqxoKlyu1sBl6LLtTbwAuOo?=
 =?us-ascii?Q?HyFqLQN7Du5GYeDNZH5w4d4UGdwahZD6ub9jWQnsxJdEJKYsGLYPryo0AKJ5?=
 =?us-ascii?Q?Li5R6EeEyRahqFKWcZSkgrgrpRIcQgCKHSFyY0+Kogwmqc441DtH2ABnca31?=
 =?us-ascii?Q?QuwwOL4OQiHJFeIFoDai4nMSx6kS418d+C61A6zUUTZZ8/PZjBgWxwQ/KOvF?=
 =?us-ascii?Q?jkY18jQvFITTdfJhRt8zVtZkph59hwZkYdythPtwR+N+Ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26c7655-aee3-4790-73df-08d983936b7b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:52:23.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4AuuGy7/CMHuqE7gAX+0Y2Qqvd7UvcYVQ/psCVxDjCGw3uIBQSFw/R3gVCD4g6dqRGAk7+pRUXtzfdv4cTarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290128
X-Proofpoint-ORIG-GUID: nqm9OzBNxpXp9ECMwAf3QIsn97tpNPBX
X-Proofpoint-GUID: nqm9OzBNxpXp9ECMwAf3QIsn97tpNPBX
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
 kernel/kallsyms.c | 242 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..38109bb02bef 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -48,8 +48,18 @@ __section(".rodata") __attribute__((weak));
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
 
@@ -185,6 +195,25 @@ static inline bool cleanup_symbol_name(char *s)
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
@@ -288,6 +317,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
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
@@ -559,6 +636,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -589,6 +668,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -608,6 +689,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -622,6 +705,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -642,23 +726,53 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
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
+		unsigned long mod_idx = (unsigned long) -1;
+
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
 
@@ -704,7 +818,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -714,7 +828,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -724,14 +838,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
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
@@ -740,7 +854,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -751,23 +865,67 @@ static int s_show(struct seq_file *m, void *p)
 
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
@@ -775,6 +933,35 @@ static const struct seq_operations kallsyms_op = {
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
@@ -810,7 +997,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -818,7 +1006,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -831,6 +1019,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
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
@@ -841,7 +1041,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -858,9 +1058,21 @@ static const struct proc_ops kallsyms_proc_ops = {
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
2.33.0.256.gb827f06fa9

