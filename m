Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC491C433FE
	for <linux-modules@archiver.kernel.org>; Thu, 30 Sep 2021 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B777D6137A
	for <linux-modules@archiver.kernel.org>; Thu, 30 Sep 2021 17:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351995AbhI3RV4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:21:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46578 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351904AbhI3RVy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Sep 2021 13:21:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UGJ3Xr018034;
        Thu, 30 Sep 2021 17:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9ZQ5spWxev1O17FrxvhAdD03ei95r9sPtGE8obTGjf0=;
 b=c6i1KqauM8ULlvLhXXTBeCHZ5UWLKpUlgRy14coe8jXxuvd+Z0PjyF/eMCTOfco54kWJ
 NbYA3K6ZwUG/KgKguzdcSMq/agVNbwRmsmqIaP6TJoEbyUsQl/dEUQryfKBPmfLoMmff
 3igsNOO/oY2xsGkwt1KcrJ8qd3mbDxq5aJH9WjD+XmYGx03F+A7SzH4VewCsLUx1Aa/R
 xT6ZMu4e2cdtx1gxyB0qa8SdlgwQZcemgvO4MXSBcgxIZ6tDg7FJ0h7e1uN3gYEOsAWp
 55sTbtyp2gPbCyk/qyzhemF+3EXMNxLXi6VpoCcakvAL2QmohGTtzZDMOi90rWZ6xg4f Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdcquacxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 17:20:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UHAWgq186018;
        Thu, 30 Sep 2021 17:20:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3bc3bmxk25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 17:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHPAjV7dkDakKU0HqQ3hBkY5Qm3NirzGrJUQBpdu12cvzh41t0uauyTOloJTrHRZY20Jt0maGEcrrLXTnmPLPSca6DgcOVr+cYLCU0cPdzD1L4OftpbUug3mQlGisIm+2YPDHJbw6/2L5a2RlZXM3vAYqeHq1CdU2cDrb72cyb5jDhu/gMbPU6sSpuV/UGhMo4yg7rn4V68DorrMSzjzx6YVJix9hBFNVKuc+NhLdEcES+WvGOouc6e0nnfp8003CjFThvohmL6GM/7zfOqJra2t0v0uvIcA+NBRx3EGx4acvDB2Vc1UjW4bjK6TvBccPjB79wPS8i+wc1TUr3pjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9ZQ5spWxev1O17FrxvhAdD03ei95r9sPtGE8obTGjf0=;
 b=NkWEQfPg5iHMvYAMAIo0rdhRoUFT0x/uI1RdtREUye1aC8Yeu+V765a/S+yC/R3VSfobd2BEiy60DGPqxXq6xs8wF/Rgmjt53BPcgARWRSYNZxF/byDN87yTcbib/ji4S2ukBJpJOEXFOCDCrEJ9RUAEvMAmYfPR+8df2e/5HByc4yJfjuQcHHknE6UIMJs1+FZBBfVNsVDG/+lLrTRv6tuH55FAYG0LKrkHUBael7b8NI66P/ufiKLiZeXp4H91f1qlnVzOeo4DjkhZCtnIiDihRB7aSx9vx4jWRB+co0Su5Kw9ZsVZ6rrKe3rSBi8ug6bNj/Kq8xmQ4H8igb0n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZQ5spWxev1O17FrxvhAdD03ei95r9sPtGE8obTGjf0=;
 b=ue00hb1RhXW0urWCEEmmklgh/fqxkwwN3K5G0Q1+3aLkk+Nvqc4capNT9NcMzC/+8IzsT/2T/b3TaBhDaoSa+AAW2IPJ4SmM0ZKuQdCOYSRQCIzcdxvyPJpCYZBMqLGC8aJvthTzivatPOL/It19bkg94oHG9OtRWeG8+nWwVbk=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 17:20:01 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::6030:34a7:cec0:a5ce%6]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 17:20:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
References: <20210929215154.300692-1-nick.alcock@oracle.com>
        <202109291629.81106C83D@keescook>
Emacs:  or perhaps you'd prefer Russian Roulette, after all?
Date:   Thu, 30 Sep 2021 18:19:55 +0100
In-Reply-To: <202109291629.81106C83D@keescook> (Kees Cook's message of "Wed,
        29 Sep 2021 16:34:39 -0700")
Message-ID: <875yui0ymc.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::32) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
Received: from loom (2001:8b0:1101:10::2) by LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 17:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 429945e4-2517-4aa3-0db5-08d98436891d
X-MS-TrafficTypeDiagnostic: SN4PR10MB5558:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR10MB5558C2C666AD7E63B8B4C09D8BAA9@SN4PR10MB5558.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6DX959eagbH36WVcoSmQ55FtC/zNEH5rQWrxEZlohjTFHjN5DzpRMrtg+P1zbTt+uYimIjSS/ZCnyGxVGIqhDGjVokYuiLKd2NCUXkmnBdzAyV9r7yWRCvaQjhAvevGJWb5B/+hFdoPfjcmFcik42ppkf8KEW31H4IzvVMTVZ3eElivcjcAjNRq0ZFaHWCdlJbJCEFz2MoyWL+huwq63xOllZdK+nE11eJBK+730XUE+GbQJWUuMlAp3Qj0G/MKtpd6q3mcXxCffFIRb5/E2sg1784SNVodkh9rEw3c7wuVEzWF3MSFSHGLRrRaqtZDxjA33xR7PtmB2RlHvqgYRBTX/bef4tX+bDAIWyR9jzVK+wKAIoiiqs5e5PxjEb069vFMatEIjGsaBkAb8j+51cU/0N9/PeDdxBCf2M4/n6EGdhmn/s/qJQCNTru8LkeiUw0xPRRqxWekTF9qLOX7nEPiJvU8HLnVWaNgCNgozS+vkIcexkMLVI08ls7R0i8RpJx4huKbIvr1nSX2h0DsO1dD3JyohGeTLsam/rHD/OXJ2MfmD5O9knl3ZSZxTVjw31GWRzxbmYO+OV77YsmNJps7EsB+MGhbRzcC4rxQbyxUmaqeHXwhdS73XzNCDrTPSYMFOXHZd4ySi+YThMl08CZ3AFybxtAKeHHqzDX3oydsotcwQP+BXVFvNs/zXM5NIpGn8QTE7kwiRGgrK4tJaPWUD73451vpH2F4p2drPz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(36756003)(508600001)(6486002)(5660300002)(66946007)(66476007)(66556008)(8936002)(83380400001)(2906002)(52116002)(107886003)(4326008)(38100700002)(6496006)(8676002)(186003)(44832011)(6666004)(86362001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTs/FdIuwidMkzqNBxUhsAKa22cF6Sraeh2NOVxr51vakgRa7U2jwE2dw6xM?=
 =?us-ascii?Q?LdZ1mYqBLQWtGj7J0fCMQaaWc5ohyw//qqY7c9axN6UXsb0hZrraHZmoKzum?=
 =?us-ascii?Q?f8BAOaaETYG82SIrhSO2BGjJty3Yh3PDFUPniM9AdBJ1TQlXNQ1p1QofzHud?=
 =?us-ascii?Q?szTCt4gvVisGJGJgBGOlrf9EaKlFG4BsmpHO2wCdOimKmpPCDxd+fA2IKqjs?=
 =?us-ascii?Q?UD0EePtcjruvbxUVqLKeSvVBW1oim3sw1GkK3Q+BKYzgwqQdBak+PNs/Gian?=
 =?us-ascii?Q?RRqrO3aerijceLt73SnG3bjNrT6tkFtl0m+6ktPoQj1pY5mYiyr/5BWCNfz0?=
 =?us-ascii?Q?TnCn4vG2lylt61PAEWzglsMfWuJ3W45UjXjkLRIaMCHzB4u/yPMIRXshLa9D?=
 =?us-ascii?Q?AgebAs1g6THjsYq9rrZ56zUUUl41o1Q3NcUbA59roYbdFk5ZuObZ6yo6ux4C?=
 =?us-ascii?Q?NF3yll2q46DBdZfk3PaGzztW1dApt6I8KJSEfcRAZl8NmAdAkePWf1cstYMv?=
 =?us-ascii?Q?1HDWEG7h5OVqp7/sT9UZc8gJYvi3dmqCG84S7Jt15v++L7uHktsBmyDlVQDH?=
 =?us-ascii?Q?Tg/e2sU/sjUxHc1vxFogxBGOxpjcK6RdvuREX74BSeW+fqWuWe40zmBGbYiH?=
 =?us-ascii?Q?Lf/9Nmx/SjathCg3Nvm94bCmi8Xd/xqJ3IJv2350ZE0sEpj+MpaPVI5znv5y?=
 =?us-ascii?Q?WDTCkBZ+bnLdD7XrHBoG28pTc6/6CctPkNF69gj3Kc1yyAc2tL/0VCLjzlbG?=
 =?us-ascii?Q?D2sTRFOOBGOOROLZ8bDkQPgDzXbb2ptI0ta9SS9q/fS7YupfPw5VPPHzcmb2?=
 =?us-ascii?Q?wKNrmXjSayCu9HLBrE+GcmD6bKcsaltLwWLmpjpbQSzgcSGs7n8tWBavhi1Q?=
 =?us-ascii?Q?K6a1IrEBzaKJaGwetcZ1kPe1zLldhGiePg2XvvvcI5ER0wTAI88Oack28vlI?=
 =?us-ascii?Q?DjzV9iLfMxLpL7LtGdsio8GX0FKuvpI4TtEqK3L6ncH4yHP3AylMiEs3UHJ7?=
 =?us-ascii?Q?0Nac0LsqkXQrLyMU1M5PKshuyPH6lE5nN80SQKRs5BvuLbtIQ8UaJGUHDyau?=
 =?us-ascii?Q?uKoyd23o9br7qtn0yMONxH+sX/clMzj49TknMobjdr5WFQAV3EJNIHgnKAkF?=
 =?us-ascii?Q?IWADqQtb38sQcNiUdGNZOXvsksrSnj7RXqow6srCAhtcTCDK0mZyjjOBLYdZ?=
 =?us-ascii?Q?ITRrJbMQNVyL+XKnkbzux7lE+52c9DipHb8MuJD7ZYcK3wK1Cchz9b0xVYB5?=
 =?us-ascii?Q?jnAvv/q56ul17NtQNkr5PAJTN55bENYe/P+slZ09fHAEfXCj34aNMROloIeM?=
 =?us-ascii?Q?yxGHft16uhgjacbSQnz2qGEBjRF4azG/47BhwzViGlEIlA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429945e4-2517-4aa3-0db5-08d98436891d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 17:20:01.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oL5zwv2CYL3yHr14ZAHbAR4T+p5K8RpUIzDZTM88zMIpUnvKVutjcpYorqI6CChnGzSlwUJe+SIhqVJCDrZtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300105
X-Proofpoint-GUID: Cv2qZ1H2lxn7KT27mm4kRCqC3hbQsHie
X-Proofpoint-ORIG-GUID: Cv2qZ1H2lxn7KT27mm4kRCqC3hbQsHie
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 30 Sep 2021, Kees Cook said:

> On Wed, Sep 29, 2021 at 10:51:47PM +0100, Nick Alcock wrote:
>> It would be useful if there were a mapping between kernel symbol and module
>> name that only changed when the kernel source code is changed.  This mapping
>> should not change simply because a module becomes built into the kernel.
>> 
>> It might also be useful if there were reliable symbol size information to
>> determine whether an address is within a symbol or outside it, especially
>> given that there could be huge gaps between symbols.
>
> This is a pretty cool series, but I'm left wondering "for what reason?" :)
> Perhaps I missed the specific rationale; there was a lot to run. ;)

The underlying rationale that the earliest, crude version of this patch
was written for is that DTrace allows symbol and type names to be
module-qualified (e.g. hid`names) and we don't want people's scripts to
break just because they recompile the kernel to make things a module
versus not. But this problem is not DTrace-specific: given that names
are not unique across the kernel when things are built as modules, many
tracing tools that introspect the values of kernel symbols etc might
want to let users qualify names with the modules they apply to, and more
or less none of those are going to want a script that asks for "foo in
the bar module" to suddenly become invalid because the user changed
CONFIG_FOO=m to CONFIG_FOO=y.

Obviously, if they change it to CONFIG_FOO=n, any script that uses names
from FOO is going to break: there's nothing we can do about that. But
not breaking the m/y case seems like a simple quality-of- implementation
issue to make it easier to redistribute scripts to anyone using FOO no
matter what their module/non-module configuration, and a nice easy one
to fix, if only we could easily tell what the module/symbol mapping was.
And with this patch we can (at minimal cost).

(I have also found it to be useful for by-hand stuff, when I can't
remember where the heck some symbol with a non-qualified name is,
usually a file-scope variable: it's faster to grep kallmodsyms than to
do a tags lookup, let alone a grep, if I'm debugging something I know is
loaded into the kernel right now. Which often one is if one is
reproducing the bug... and often the module a symbol is part of is
informative. This is, obviously, crude, but it's still more useful to
have more module names there than fewer if one is doing this sort of
thing.)


(As an aside, this is not all a tracing system needs to do to get this
sort of thing right, particularly where types are concerned: it's still
possible to have conflicting type names across translation units within
a single module. CTF deals with that case perfectly well via child CTF
dicts, and GNU ld splits ambiguously-defined types out so that the user
can say "foo_t in the bar module in wombat.c" in the rare cases where
ambiguity exists.)

> It would be useful, sure, but is there something that does, in fact,
> need this, or would like this if it were available? Since this provides
> a userspace API, what would be consuming that API? For example, when
> Syscall User Dispatch was added, it was clear it was for Wine[1].

We have a long-term consumer in DTrace (e.g.
<https://github.com/oracle/dtrace-utils/blob/dev/libdtrace/dt_module.c#L1323>).
(But since we control this consumer we are quite happy to change the
format of kallmodsyms, integrate it with kallsyms so that kallsyms just
provides the same information if the file format break were acceptable,
or whatever you think most sensible. We just want this information
somehow. :) e.g. the code there doesn't yet handle the
symbol-in-multiple-modules case: I'll have to add that.)

But this feels useful enough to me that I'm hoping that more consumers
will grow.  I'm sure SystemTap would find it useful, and I'm hoping
bpftrace etc might as well once that starts to handle modules. They're
all going to need some sort of namespace-qualification and then they're
all going to run into the same script-stability problem as soon as users
try to share scripts at all. We can make that problem largely go away :)

-- 
NULL && (void)
