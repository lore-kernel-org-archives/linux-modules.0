Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21208C433FE
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0991B60E73
	for <linux-modules@archiver.kernel.org>; Wed, 27 Oct 2021 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbhJ0RuA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:50:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2782 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235983AbhJ0Rt7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Oct 2021 13:49:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RGY8jc023028;
        Wed, 27 Oct 2021 17:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=f3JLQ3h4t6IOlYK7DBgr+BM3ziPT+Bam2GRLRW35MMY=;
 b=EOr77kXsdTEiFmy21qCtlzeJsJnkCma2FzxfRFiue2rBiPD5XlomT//2yW3TuzI1tAT2
 yiXaf9pm3keyGiU2d+5BIqVtyZpobMv/x5COsDJzIhOebUuC+WsV6xUDaq4OwjAVkUbP
 xrJ6RQj90oYmbthB7yHPcDeEVxicrCAlCkhFAebgCCKfWEB/hLbDlZKwACBmEbyuHFts
 doaK12DP7lo8gwgjc8ypbWDZUQHVPF9OZwT+0zYG3iUFo9bWObFkZw3/Uy/EtDsCSaLL
 8yaJh8gA/aCFKH5V4+DbSc2qv9NcqhuS33yEzsKYBcbrGIlxrjOh8zJpLOkS2hUfxaFG 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4g1baqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19RHfIVP128934;
        Wed, 27 Oct 2021 17:47:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3bx4ga9wd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 17:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTDzP6bDiM5VycGlPH+1oVdo3pdzEcLeuAPAm3j1EEjBArlu9vpMk6Xkxw53hyf5HFje4pQuWhwCWLcU+XXViSyaRZzlOfnqkm9YN2g1RW25LRKxognamgh42zJ5PMqCGYN/lBtU4tv8qgW5j9FCKIBne53hoOENGvUi7q90985Rc/PWSE1s6d0FuggGy2vp9yB9NGV8r40Fonuz+cXXhqOcHBRTBUW268zlbhpz4QJ7hSPliOXYAZdKcsIsT2U7VbHM2wVU64MyaeMimK9X1S1a5ONkGbnsJL0Bz3iUSpB9fBhGJFIElxE5FmzQA/nZsTMK4fVbj2UUHPsamKMlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3JLQ3h4t6IOlYK7DBgr+BM3ziPT+Bam2GRLRW35MMY=;
 b=hJciTR81U5Wq9ByCG3TclcwwzMzpCbgEYPhbjCOa/HBnul4YwvUS63Y1vWd990wrZnhfdlIMj57g++jgZRMmRFNxrJvhDqWEXnBZVMqfrxBePbhHEz9vpl9kAxnGLpERjcXxXx3OzwaAAQe5RI1HtwVXg66XufxWbTyJIlo4ykYjl7S+uNhz1Jj0YUtk5YmsJyX6tOyF+EYDTL0uGAtpKOjDZg+dCujCi0uBQCNEfoF8UPvKFKO6seAIrXxo6zhZE2VO8tqPGNB1UcBf/JX8OtaaSnvvdYKqulE2uVFpUVTEuUJZGE0oiHiHhiiA2EPY7KHSx44j6qtEgXk3OUl64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3JLQ3h4t6IOlYK7DBgr+BM3ziPT+Bam2GRLRW35MMY=;
 b=AplezMZINDAihGl2+ZtmU0TaOS50mnO3dlxc1oDHZjaaZNRTRFqgjKdc2O52Tf9mnmqw5EEbe8362iXjILzBqmSbxtXczSXD7cx4mRka5z0O+QLsKgmsAZZySZqw12mDTSstbU8NZXbTpf27YlII3mdeB8J5Qomu0r+UOdLWPP8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2925.namprd10.prod.outlook.com (2603:10b6:805:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 17:47:26 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:47:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: [PING PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
Date:   Wed, 27 Oct 2021 18:46:59 +0100
Message-Id: <20211027174706.31010-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.33.1.257.g9e0974a4e8
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::18) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0493.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 17:47:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d5e93d-536b-47b1-8a5b-08d99971d6f3
X-MS-TrafficTypeDiagnostic: SN6PR10MB2925:
X-Microsoft-Antispam-PRVS: <SN6PR10MB292524425F07645EAE4ED6FF8B859@SN6PR10MB2925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOi+q70ocoL6EfecHUklaHGlgxXzpozLVNdxxdAbM361EA6RQ1EUTOImvhESWo82PLElmrFYgxSDn/OkgWT1nKsHggVWhP5cW+5bL5LUuN0Xm6CQiQd23Vuz10OlHCTskVQyuO1sj7n/Zpt5/DEgoKPRfFY7mUqmXYe0iM7VQ0H9h8NumGkIXAgnmIqu+6f3rr2f0qPEbohfBvYlYvoVibP9YH2NOl0/bIVZPW+DukxmLwWdZVABe7pIfhkxPwhMpHv1N9M/rXF3UQ4yp5h0Eoneoi8c89a2b7obvG1YlV+EvQVSxGk/1xP3JCxlFOxaaEpG+LilSMMJQ8Ej3CZPkYKD1NFGHF6v1jFgY/ei0PxXSgqO/F0/X0wbK0p90yRKSEeH2yoDpms37l84a2GTEEp8gMgMkunp78HS1zUwZINYxTelPxqmyK9ezR5uK4TdEECudVyRtDWpN0jmw4NCr4s/BvFE/Oo0fH73jXsVKR5dV1KcAwjbk3f4cK6LhTb0T+pLql04YB+G+o/KmyLrVCG9tlsaUIU2ct22loHwXmSPqJk+K3YoaBeMQm84b+xjL0QpGGmqGM7q94ovoVOyI10BnxFVwSL7lsYrYui5nB8LzawuebhU6rg02XoGOv6B/ZYvX03L8UuWyKe1EMdUrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(66556008)(1076003)(186003)(66946007)(86362001)(44832011)(316002)(36756003)(38100700002)(52116002)(6512007)(107886003)(8936002)(83380400001)(6666004)(30864003)(4326008)(6486002)(508600001)(6506007)(2906002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqBk4nc+IGW771GgHgXJ2Gpf/OPCgj0VM9X/HevVC/pBG1/gmasEoLBr2Mo4?=
 =?us-ascii?Q?GzfhTJ1KwskywgpExI1cWowF159kEXV2NB3UyJhOC6FxXOhb+qO+KK4SsHvk?=
 =?us-ascii?Q?763zX5Sy9GGD1wGUcBB22LPDzCHFu9wGbM3mwzt6pBOitbR2detipvBBz5dZ?=
 =?us-ascii?Q?VrORNhYGxBou8ZV81y41KZnGG6QbHurbWIUG0flSs50SCuRytmCqx4zb/dmc?=
 =?us-ascii?Q?Kh/bTWpVOTt1T7LjjKv6mi/ngVr8ymkWS+4Qzopj1ogfwXDzHulFWtdYjjTb?=
 =?us-ascii?Q?O4SYZuFSnCMiWs4cwopP6QRHq1FzcgZUz0qsGrCVGT1Lmx1Hjp+58VR6vzcb?=
 =?us-ascii?Q?UZAT8v3198iVJHSXFcdzMsffT5eS9wP6TQ5nW9H/XZxVYq9EzdkGwDhvU+yY?=
 =?us-ascii?Q?YYxLW+WBr/JkPdJVo1dWHl5ziUeLHlxZGBusMB4CHSKIv0Vl9qId4/Y/SopV?=
 =?us-ascii?Q?OtNf6xU9Ucg3zPDSBxYRichvvaEUt28GUiMx41bjlNoSv77BjpG+MxtsMrtE?=
 =?us-ascii?Q?vYIz0FvkEbD7s7pFDHUIkqmhgrFbsAp9Hd8ZG1pYGIvycFNPYiryBVugbmMM?=
 =?us-ascii?Q?0dglUq40UyUj6sXs4htv168FIJkwphsaHtNDARaqpWkssD8TdkBSq9S6ig3q?=
 =?us-ascii?Q?3VwoV0TVdMFgupMDY3i5a0V2FOPOlsRZYdiUNhr5Nc+QU6JOtts8ODK/7lw0?=
 =?us-ascii?Q?muPVFEV5EIAUnSp0Rlyu21URvj6koZ5kSa2Gk7iOZWugXrX+jDW4UeNM0Wwl?=
 =?us-ascii?Q?y3hvMdcf0kuoKasPg0bVA2YYKrJNc0XCgRnqSlJjF276nuRvfaF/xXuqefIl?=
 =?us-ascii?Q?P1dcnRIYBVnC6C9zTh84dg4e8qboMyjnM8LZQ+XG38agiep12199twTexl4E?=
 =?us-ascii?Q?DKX8MY+73z4rxy6JC++be7kqWr4p0P+R55CTSCh9dZJE9ppd6iGrDfuUR88N?=
 =?us-ascii?Q?fe5ZQUsNOKfs5PakugPoRT4luW3n0U0Hfw6hHCojw8peo6VC/9AMabHrmGOi?=
 =?us-ascii?Q?4q6HsUVdqITkVkALi5dGrRzTzV+unG67uDXsqsBwmrzFGev3lK/EwnLR6Y7C?=
 =?us-ascii?Q?FQp4a2kPGeAla/ZyLvsDixyMXHjt4chxsV2GUb1kjJkOCBRgTpAg2Ibb5Gjo?=
 =?us-ascii?Q?YAptPkPLp4J93oNVKPAJCcdLa42CKwx6Amj152c4wWoTdxW5k4g+gbwfNAR+?=
 =?us-ascii?Q?5Dr2Is5dxDGZDtjVYS9hO1TecjYKMgogEFMJzRIUO4Tt7+j/mjwuaFDdHY5i?=
 =?us-ascii?Q?aMIEBlif3QoXqrcicdivXAppZdJ3/6WwTqsas5U4kF7yStimc6k1N9ruAUra?=
 =?us-ascii?Q?pd9tt0AuN0GgvWViIz8qQbKq8xpyCBKIWBOEhAeczaUSDOXzbkEVljJzrTYv?=
 =?us-ascii?Q?vc2tNuO4iOnTa6rvlcelMYk/GrL9q1sHpp+ZhnPpBBX9uynmdKsL5idJmPw8?=
 =?us-ascii?Q?oSn4AYQHqiH+fdMe0XE/aFRsuiAaLqt3W0LRTLHwM92bogOIO6PKvX0Cutkv?=
 =?us-ascii?Q?9fV+RavrNaEkANlsEjevv7cWcWuYUFL3YpLyevvAkTTVYHxHWpz9p76qqs9V?=
 =?us-ascii?Q?x6VdjaLngE6u8rXySJNy3H/T3o29HgaiUwiFXB5hWY+AOBHxLTBIZyuzLluT?=
 =?us-ascii?Q?Mo95APNtEXVP6I3U3mhWHkifEU8RTqVqCocbY1EOXryr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d5e93d-536b-47b1-8a5b-08d99971d6f3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:47:26.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u95D/EdLSaHeBEcgVILoCNhjgoq9FGa0MilKlWIWf46Sf6R11KfOCwSCf9S1xXdNfJR4w/TwauoeOXMjeZKsBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270099
X-Proofpoint-ORIG-GUID: UR_NUbfSVea5M0qmd-Sd_3IISMbRNQz8
X-Proofpoint-GUID: UR_NUbfSVea5M0qmd-Sd_3IISMbRNQz8
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if there were a mapping between kernel symbol and module
name that only changed when the kernel source code is changed.  This mapping
should not change simply because a module becomes built into the kernel.

It might also be useful if there were reliable symbol size information to
determine whether an address is within a symbol or outside it, especially
given that there could be huge gaps between symbols.

Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
does several things at once (introduced in distinct commits inthis series).

Generate a file "modules_thick.builtin" that maps from the thin archives
that make up built-in modules to their constituent object files.  (This
reintroduces the machinery that used to be used to generate
modules.builtin.  I am not wedded to this mechanism: if someone can
figure out a mechanism that does not require recursing over the entire
build tree, I'm happy to use it, but I suspect that no such mechanism
exists, since the only place the mapping from object file to module
exists is in the makefiles themselves. Regardless, this is fairly cheap,
adding less than a second to a typical hot-cache build of a large
enterprise kernel.  This is true even though it needs to be run
unconditionally whenever the .config changes.)

Generate a linker map ".tmp_vmlinux.map", converting it into
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

The resulting /proc/kallmodsyms file looks like this:

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
compressed vmlinux only 7552 bytes, a gain of .08%: though the latter
two values are very configuration-dependent, they seem likely to scale
roughly with the kernel they are part of.


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
2.33.0.256.gb827f06fa9

