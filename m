Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A755AC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 28 Oct 2021 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890F5610C8
	for <linux-modules@archiver.kernel.org>; Thu, 28 Oct 2021 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJ1VzM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:55:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55884 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231324AbhJ1VzL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Oct 2021 17:55:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SKVVBE032294;
        Thu, 28 Oct 2021 21:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=d++wGuqx9EqNfmNdZVfNgxQ2C95sFy6e0+EL2FAf5m8=;
 b=feQCuZojijDjNs6vl/byaP6c7kBUuAiLTJTHFf/1AUREbg58RZSEgIoKypDSDARMweyf
 GDLaJRrHVJYc/7mX2g7NLyzZpwULV8ZZdaytPc0lkUiU+2VlHHAOFwnKj6O/LWHlnqqo
 yL8D1+kxmGG05lgKXc5GLjRIuwb8YSbbRLxpIB2KV1R7oiGS8/TtvXsA+px7k2VYUgob
 YhLzbRvpovdBZv+ZSmF/EDmPI2W6hJoOJRcIwGC6lkXOyVft6VIvbhxg9JykeabIYHpT
 qTHL6xWxqW5LCxWbp+MFZN5lo4KoUVTlgd+wNgb1gjLTrUOeXtfKFn5cdIU1Xg9uj6Bp Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byedanw69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 21:52:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19SLpcUd061358;
        Thu, 28 Oct 2021 21:52:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3bx4gf0qu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 21:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkRi5a4gKNXL40aKjYgeelY5zU6Q+uv2IR4XYkZAKvuDqiEuXqHhIzy4ZjLkb2LwuNpRfFz9kMhV2g1w5ETYu0nyreZh6RuRrfEXZIvX6K4BU0xZpO1M++Drav4A8mZueQOZw/8zbnNRjQwQ608cyaH1jap35HbroCZ/cec3IpdYX/8GiX6UKmu4+eI8v1W6Umr9SnJaYxh578psJP3H8Yolx1nUPPi5ObR1x9hMyhpd6Nt7R/n6BcGvuxiTs8SEDw2olBZiPe9aDF0h5ouDZEesPOKnNB6EwBMVvzcZfXR+n9bsvyV8pXsGMqaWK0q0hQawmi9Hnxg8O/3s9Obj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d++wGuqx9EqNfmNdZVfNgxQ2C95sFy6e0+EL2FAf5m8=;
 b=FtJv7Rn4gk6rA4NEXXIYC3hrSNeGoGV2VKFlRCBydlyqJ1QQyzgfsVR/KArmKjherD2zfnPfel2LcSf9Egy4lKbZ8X5ca/Ff3arUf+ifFCUNNHnQz2BStY4Zia0xU/aRv63sD26x9+mwAGHeu/l+/F5zcbt1TeCmu8N42lXf5KQT2LSyJUnVcBrfkyu9CM/LxwpnooJQVCasP7yGfG++tAGbugnRrcZJvXLa7wqKrYNODaqvqB6eqXDRiI8qR/xTIU3fVmryKSqbqUShPCvqObQuS4qPtSWU89+wDIbLc7N7uNsxuyAUv4Qrz9z+PGt2UHEXfrELkz0nmz7s+49D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d++wGuqx9EqNfmNdZVfNgxQ2C95sFy6e0+EL2FAf5m8=;
 b=en4CH4vfHxx8e1Pni4EN5KJQLEaPLehhx0hiI125HQSQAKgg/8TYU0EHnZql/DNgqGVkcVUWGZXIMHNODGyYeZlwOT1HoSugq8WMX90/t5hUnhZuBPa1VcP5vNww/fNhBZ/oWgZC7w18fXbHeqzFC9iQx0LRlinRpvAhzHz6nlo=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN4PR10MB5606.namprd10.prod.outlook.com (2603:10b6:806:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 21:52:20 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6887:4e61:85f3:a83c%7]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 21:52:20 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Nick Alcock <nick.alcock@oracle.com>, jeyu@kernel.org,
        masahiroy@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5 6/7] kallsyms: add /proc/kallmodsyms
References: <20211027174706.31010-7-nick.alcock@oracle.com>
        <202110281914.lE4Jfz7P-lkp@intel.com>
Emacs:  or perhaps you'd prefer Russian Roulette, after all?
Date:   Thu, 28 Oct 2021 22:52:13 +0100
In-Reply-To: <202110281914.lE4Jfz7P-lkp@intel.com> (kernel test robot's
        message of "Thu, 28 Oct 2021 19:36:46 +0800")
Message-ID: <878rycrf5e.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom (2001:8b0:1101:10::2) by LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:152::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 21:52:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8508f729-6473-49ba-d7eb-08d99a5d37a1
X-MS-TrafficTypeDiagnostic: SN4PR10MB5606:
X-Microsoft-Antispam-PRVS: <SN4PR10MB5606B0B24A902D6B6DE77ABB8B869@SN4PR10MB5606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQ/8oZV+7nXS3ja4XYaNXI/9JcGsxDbueTosMjt8EQ6EN/C5IBEMsWIM3ef1icOupZxA+B/44hpxMPw8INIlwyp96S1I/BJMZJ97UUqbQ9Anx/bjMAHGPfxl7U0w/uHUKNGCuc8RSVYNsPPwiLU68zUzbrX6yoXE9oqJv2BvFmGFO3vIXCNsPX0bMykVsxJj9tqh/uDp+ibh1eac4gzkQvIN+9YeZUIuUVWQC529ioW4iHRjd2WeVHyEX7RUGSSgtVKCvKabKDTwLfNTHx6kQ0ybONSVj+CJPd0NV1A6DmxZWZkZiS9l0AeJyyu7h68JTPGS6oOrAjyM61lknVPIhaR44hll16tGCc/soLi5Zp13HTqGkNoP94eJ+s8W72pY35AWpsPyOrxHwx68jARdBvOrxkxXp+nTZUYbEMqjwX7DhlWPKjLclY3SRJOQjfc3AfjfH/XirR/AC94WuKS/yEzL5k0Fl++KSeF+WZFt9u5viWlA2VqcKB/hXuWzu8Ep44Ebb5ES3rZ+Mn5dMaPZDEdTHzY6Gd1Ls+qqst0BIDA1nJcqqlkRRyu+0zLlZbkFuAd2diGCHczpICHFEIzLYGx0gj0o0KRR5zbHd1vWxTYifr986gVjSaylddDU56QvNSfxQi1mbHU5E0EuO18EpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(2906002)(6496006)(508600001)(5660300002)(107886003)(66946007)(9686003)(316002)(186003)(36756003)(8936002)(52116002)(8676002)(86362001)(83380400001)(6486002)(38100700002)(44832011)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbuLGPWubd/r2iRmf0qeFGIgSVq3jnK7BdZWqOIoIwoBmkRmUZxL+c6/zcey?=
 =?us-ascii?Q?g+5dNjtQxX/dvZPMI0sWTZ0wQNwrikkW+2xddPskpTnj4utUmukFUE34t0ht?=
 =?us-ascii?Q?5n9snDZtZsLr9n+a46ZqCPfEzeqv7crvWs/5z75vlZY+leJr8GW4MEKV91v7?=
 =?us-ascii?Q?KN1zp5U0rA6xASQTJdDn4WI8Y0xm3VxZp/VATy/LlDeznY3snH2noLt09YWP?=
 =?us-ascii?Q?r0UrGVxGzGfF3370Vv8BxwI6KsfPdKagDYSJJL5XtYLGfyZbBm1oimBUhwJ7?=
 =?us-ascii?Q?/EsL4f/c7oBlPDAc2dnFUQYsn+8GnCYZBfUlB2BUEJYHTbSz9XLykh9YdFAz?=
 =?us-ascii?Q?EGzvODWoBbxiBTshT60rYWiUpD820M0RAyLijhX5sri3aRxRSQ+JZwDufxHE?=
 =?us-ascii?Q?MNX0FLQ4yOPs+Pz9iq51GJiYtIYFhYCFVRwdfgGawSVdSypL/5qGpV2J6Uzy?=
 =?us-ascii?Q?6TguRV9V7KWochOuIXnOnGr23k0QComkHcoS1fqsZ66eU/VcnZNaqbk0kq/d?=
 =?us-ascii?Q?Rq/44wNhZutYSI8MyRloCjqPYLGj7NtNqOM70VkyeVdzc7Ikc4XfSK1qYU3E?=
 =?us-ascii?Q?5roNTi2/aMx7FObSgG3fzp9KOKNYrxIweLf7WQUHvJZALblxgioLjwo4b11d?=
 =?us-ascii?Q?LA5JUawVmrUy7aenaFsPzCAr6NT7vwqnMM/cnJ+kTVpafKi3gDMJQh05ML03?=
 =?us-ascii?Q?5XjgeAT3XVgtIGhII614jl4ySO3D83tjBZ0Z/b901/C96xE6Swu1yadM6qb2?=
 =?us-ascii?Q?pz3WsEW079wGZ+eJeAapv3je6rLgqdDnmG/2NoG/Nw20lrTWZNLclLi8u42F?=
 =?us-ascii?Q?vDgwajyexwMKLQYOhrFKPjk9MaQRJBf/Q/PNl/vVnObudiYOoAv5ow1w/6BQ?=
 =?us-ascii?Q?XFQPNHXn2MWqb2XEBzo8NcKjuI0h8x94cXy3z388qbv7K5ufZ7J4bGtTczmL?=
 =?us-ascii?Q?tbqwZhRxseSyY5JPTVyTcnFwFAo9NlfxgpANV7YP6BxP/qr0RUvqMVTTP8m5?=
 =?us-ascii?Q?vPaWMug2Broic6/SHJlEWeu/pybWqFzFuO82IyB8dSc/7kaWIMmMaL7azrFj?=
 =?us-ascii?Q?D1KS97HtBoYrT0Zjr3w9J2gC2YG2sK0h9uKqqUlf09/S2MMyYA4emycop5hn?=
 =?us-ascii?Q?v7Wg38Q47yAnR0RIaCJ7kkb+2hnCLfr/RJgy1p9cr/6PU3O4H59t4U8EzDag?=
 =?us-ascii?Q?FigFbnANR8JkFM42YlgYA5iTYUjUGvSxoHM0RoGG2cCkZdzQ/0iefZPDzjnI?=
 =?us-ascii?Q?tgFfMULqjotYbMoGPqN7s8uOCcHN/8GvP4Z0h+OjwibE1RTJVXorKN3FS3OX?=
 =?us-ascii?Q?G1bH3AqTYRidc06mHediuip9wR7C5O7ThXcWVx+29nQ4fzjzthLLTUTHp5i4?=
 =?us-ascii?Q?zolIQgZbT1lfMe3C25UcdO42Q4vt8Skh3bY58rNP9Jj6+nFnXLF22Q/vwQJ+?=
 =?us-ascii?Q?WSO6xm/oNDUS40pmJk/LuLGgzB/yL5Bu1i+ngC12H1tDaZydVPnFO+Oz/bU8?=
 =?us-ascii?Q?6KIUDvfFfDPi1VlSU0Y9NPBeQKxY3a7cmPYIi0LUi7w3iBofxEO/JLlyrPmd?=
 =?us-ascii?Q?y0zkgcrC5yX0kpn5fA1bfnx9h75aflB47KJS8BUnnl/WIAvkCd5bLutt2d2P?=
 =?us-ascii?Q?SQlpDwMXqEUu61Ir9f6gz9ZjHQ02V96SF8Rjxy3xq6gQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8508f729-6473-49ba-d7eb-08d99a5d37a1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 21:52:20.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAd7sLt32B85GSYgy0LYZPXpuDrLY6DvaHUC8Gql+BonUaQpHw7HGCmqwO6FoZeRCkEE0p4HF2OOHa0U8p1SNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5606
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280114
X-Proofpoint-ORIG-GUID: 9cPEcEW13fDA7izW5u95ZhaNdu3uROZP
X-Proofpoint-GUID: 9cPEcEW13fDA7izW5u95ZhaNdu3uROZP
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

For reference, and to be maximally pedantic:

On 28 Oct 2021, kernel test robot said:

> Hi Nick,
>
> Thank you for the patch! Perhaps something to improve:

Nope! This is a (very small) flaw in the !CONFIG_PROC_FS case in
include/linux/proc_fs.h. (I don't think one can seriously call it a
*bug*, as such.)

It's not a problem in this patch.

> config: hexagon-randconfig-r041-20211027 (attached as .config)

This config includes: 

# CONFIG_PROC_FS is not set

> All warnings (new ones prefixed by >>):
[unrelated warnings snipped]
>    static 
>    kernel/kallsyms.c:1054:30: warning: unused variable 'kallsyms_proc_ops' [-Wunused-const-variable]
>    static const struct proc_ops kallsyms_proc_ops = {
>                                 ^

This warning already existed (and doubtless countless others just like
it all over the tree in this configuration).  This is because
proc_create(), in the !CONFIG_PROC_FS case, is a #define that just does
nothing: so the compiler can see that none of its args are used, and
will complain about those that have no other references. The proc_ops is
almost certainly going to be one such.

The new warning is just the same:

>>> kernel/kallsyms.c:1062:30: warning: unused variable 'kallmodsyms_proc_ops' [-Wunused-const-variable]
>    static const struct proc_ops kallmodsyms_proc_ops = {
>                                 ^
>    3 warnings generated.

The kallmodsyms_proc_ops is obviously doing the same thing as
kallsyms_proc_ops (because it has to), so it gets the same warning.

Short of wrapping every single declaration of a proc_ops structure, and
every call to proc_create, in #ifdef CONFIG_PROC_FS (which is obviously
gross and exactly the thing the macro in proc_fs.h is intended to
avoid), there is no way of fixing this warning on its own: it must be
fixed in proc_fs.h. (Perhaps by making a bunch of those macros into
functions with __attribute__((__unused__)) attached to appropriate
args.)

-- 
NULL && (void)
