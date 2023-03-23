Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D76C6FD1C
	for <linux-modules@archiver.kernel.org>; Thu, 23 Mar 2023 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCWQqV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjCWQp4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555B13D74
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 09:45:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NGhvGp014472;
        Thu, 23 Mar 2023 16:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=VwYvzohPgzDhAshjS+1v23vY9eoTsdG9XT2vADoLQeY=;
 b=HDwJhFEPEqyVbj3JlyZBdgYwLxVITCl/bo3kzGNKs6B8WRVK/W9NVpZCwJuVhYK8bibG
 WA3DcYuGqG4c8NghB2T6esyYaz06MyEaVjPSjDIdKRfj6RtM69vWKOPGc57/Yj2/3jAl
 rPKK/xlfZl7Byb5itzaPQeG4kDfbIvQJk2MH70GWO8liE0FJz1j6w85JJHGDKH27Irzl
 zwJ1b8JZODldoRudNgdcAU967iW5VGYKYwm3flHiQpBrSWkgk1L7X6b+JP/WQ7Elulo8
 xPlwW1OnIOL4FmP+yFUfpMJ2LVg8AX6XYUOM2GD55vCDCVLrTHTJ204tBjddCvs3aV6a 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433vcap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:45:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NGitLg026157;
        Thu, 23 Mar 2023 16:45:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgt8rrw9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhZmiD6PF7fj1i/V8UBEQCIuCtkIGo88wshB3Pr7x76Y1z4x8OVK+BYDG68Sf0KxdN330HHNnfsfCpbuMbVb5Lr/oHytdyflYSAJcsIxB7UwEU7l1Oz3kt5pLGduQ0cto124YJ/vThTA+rPKkknQOcRzhQ4oxfEPXsGNZiZtHlTpZD1lJHNnA5H4/ABPYbtgfkCDpH9m0BKl29Ohj+jv1S8HVcAgnQ7lXZoEkzDBO7dTnBZ3hfb1T+wpN6f8brZbm7UWhmsb1KEqanWVeS0KyOgq4zxOU87mpWmzK7++pfkc6x8RURuM825Wjr02DKqInMLEaTByUYzQ6tt9d3L/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwYvzohPgzDhAshjS+1v23vY9eoTsdG9XT2vADoLQeY=;
 b=Rc5Zat4HDj6BTKZs6gne2xEzLsYwSIbj+mu7fUwB+2hnkSj70c7mA7OslUHppC3fBDWeP75HU22DlVWz14uDh9hUkK7imo0ns7g//ER5JrwQJSshQq1XP0gqO8YxFC6H3UpbZvbYYblMPEwEAiX+BSV336ydkZpQSUPgveG4WvMUss6hKMvSNGTDCE4nn8FEJrXpmEgebCna3WEsPOhGlGh9b2pQ0gYYPAVzhUO/0iz/mWs7tPcq5SXh2mASNIiY78ySAAaULSHjmYW9xA5BmQ0mG2UcZkp5xQ4xX4aexE1DP5eR0W9zb7S+KSQZEcfAmpSqFs3QULMdck3FJo1kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwYvzohPgzDhAshjS+1v23vY9eoTsdG9XT2vADoLQeY=;
 b=Pn9VYaCvC+od/feS0A/+CfVzwz/+lD2c/YM4jME/fFspvhabNq2F1qDo2FtkKMSDgxt1tkxLjx4Pm0fFGggQhLJngmgz6g3urgP1oQ4pO9WDb4QjomhOFjwlrllIU/A2XECOdL7ZEn96UMIRn/TDd2fs0HqijViSd22ct0Y6G84=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5189.namprd10.prod.outlook.com (2603:10b6:408:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 23 Mar
 2023 16:45:07 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 16:45:07 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: module_license tree refreshed against linux-next
References: <87mt46s8i3.fsf@esperi.org.uk>
        <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
        <87r0tiqc6z.fsf@esperi.org.uk>
        <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
Emacs:  ... it's not just a way of life, it's a text editor!
Date:   Thu, 23 Mar 2023 16:45:02 +0000
In-Reply-To: <ZBuQOXi+my7bnXzR@bombadil.infradead.org> (Luis Chamberlain's
        message of "Wed, 22 Mar 2023 16:33:13 -0700")
Message-ID: <87zg83mn75.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::26) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: aaac455a-b606-4e1a-0096-08db2bbdf528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mnrwqCaEx5RXRzGuigNYNUNRjOTEpoZyFVC5gf9bANhIFfQWJF1ZEsRGail1PrOBMZOVfocOsRvXWG4tERr/h7xgIOiO7ydGH01Kpne6/eotI8PzM1R2S5pTfdhjgAmxA3L1anBoc7jlAkRjEgfDqctQRmmGYQfxu1+MU52Ldbt7f6F5MaP8yokA+XR5ReRm9WGi+3bfePOoujEhOtMDrVWnXdFjSdPNaerLk4QYZZ9XGDiVnMMTtobDYHe+jSFKojIMY/5+ps9dgeSY1UUFisbDk7jGCsECPTAQCcOpR5fojNGK5rfqDluAG3GDIj9TxeXTiMf5hx6ENbwCS8WxWmoDkcRV7iX0Bt+5tsIMiqJLwVscyvLhKJwiHFHtYl/1G8slIx4vvLrjCg5u8EMigt8GhaIPbcofNtYWPsYZ9zF2AIzPI9GzXQQpluiFvfdKX6T8hEMX0c7GxE14TtAnD3CyMKCV9qniF7x4HnMiwg0uRIG4nbukx5gvafI9ViEf7V2qCMonKaZugq9K7Vs/F5MTZfTtsw2yPRq1morp36oLTZ18VIMAx/J6MZIOCwaGXqKGCISGEsIfZH75EAQ50JM6JixQBSP1jZkJka7PVPZZdv9n1qQeOth8F9vL5BDuXmcY9voiBUm0NUYA0ZgXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(86362001)(6916009)(36756003)(38100700002)(41300700001)(2906002)(44832011)(66476007)(5660300002)(66556008)(8676002)(4326008)(8936002)(66946007)(9686003)(186003)(83380400001)(6506007)(6512007)(54906003)(478600001)(316002)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6r/ClBDacU25mOhsgazrIKVkj1gyLZG5aTAGZyaca4MnPDy7cmH4v6WvlybY?=
 =?us-ascii?Q?k1ht8y7dcc8/f3FxK3gZRCat1zl0dv3gWjf+adPCUl8Li0+rd0C89vhbr1Fc?=
 =?us-ascii?Q?Ex/A+1KOAExZRZYFCX5a92jfz65h4HVgshYYgzu44LOewlFbxFxkNMCxqCjU?=
 =?us-ascii?Q?4o6gl7XsZY4xuiA+/NrrOJNPlMQ3tQgkW+HxWpCVhNLwrv9MrH2qrI/TBou5?=
 =?us-ascii?Q?6Umcn3sSzkT8dbGMrSu1hI1ZGy/FQzFrEsjnGWuvJenaUBfkmyc9v9ZxT1oj?=
 =?us-ascii?Q?hiNzwd2K1fiGeyyYjEg+ys3HR1o3RnadFVmtjsIk8mPhS6TCqjh3oX2SN6r2?=
 =?us-ascii?Q?GD56/aqrj672TwqXpLDmWjEtUK578lPWrzPsSwKW3KeZlB+oV9LH/SRksVyl?=
 =?us-ascii?Q?hHXTHJZL5bSuKm2orQ5CsNADN/1EGWuEcCIm8wS0XzdmiWXzPRYTPwDIoWsd?=
 =?us-ascii?Q?NUpwUJJYxKyU3Zr7DGMyHjQiIWU5ciACEI7g7jFSm0agGZT9+OgbRHuw7cSV?=
 =?us-ascii?Q?Idy8MRWxBQa6v1c+WzUcm4uG2A5/CHhMgEQ5E8ayg5EHPwC4chK+Eusxzoxw?=
 =?us-ascii?Q?AxSW54buGwAcyM/+JzlGc9pdafwpdUzgOlxu+OLdfHu72Y9CP1bA4O/+b/ug?=
 =?us-ascii?Q?pZz/VXUqD9ZRwzITJmqVAr/WjDbQD4FSfGF9dRG3XzQWzl2cKx5Rcn7SS2us?=
 =?us-ascii?Q?gk0R6TqQeO0f9d6Z1mbi1jF2zdos2KuXbDsCBOn7j3KniFiq1W8HKQ4riH08?=
 =?us-ascii?Q?kTo2tFAAFlLMB38QoYdh5TEafgg4Tii+8BG/HGjsMpI7iHeehqY1p/qf65qa?=
 =?us-ascii?Q?4tVfAnG2VxKkt46GeoD7BiL4AZLDliCuPOH7614xelZNn305Y4grd17bj783?=
 =?us-ascii?Q?YNd2kqk3DlAcmTss25Rqwh4Hmy6K8bgDl1LgsbfMM/OdV5PFkRlMC6X8ONN9?=
 =?us-ascii?Q?qsKzwhRgheFXGkAjSAlzlDm/RZa8x6ylhE+7hNiciP71aBtujAKJsFGxwJ/G?=
 =?us-ascii?Q?LmSqqbCUmXL4zAX1O2arI8G1oFwrgiReC8xtKhbU7ZkJD0MDz8gfcCa52ujz?=
 =?us-ascii?Q?3JJ8mYHLSjTItA68PsbhruTKXbHCtKfwPOjDP3bwy2i/6QHCcTo4MOZORh2g?=
 =?us-ascii?Q?8QUmgecd7kPaJugMbQWJpvP03D6gTiESs9ITiOgsb/tOLHAQoeLmEFX7un/F?=
 =?us-ascii?Q?pKaE7Wpcd63kf+qJ+ytmyGb/lD5/crVIXTwrfyb84+RVfPAwDsu/tPAcrFyw?=
 =?us-ascii?Q?DM36YKZi7Ot0YIkdZMyFMkjk9bq8xW25NIbrMMudNKiDp62TSja7TawvaAh4?=
 =?us-ascii?Q?Yk/OvCTIwNxvSF1bdPentPICVVUP/lhtvVw5TihMB8PNaIQ0wLqSiWLkiFVz?=
 =?us-ascii?Q?uA/SHV5687+rNxiwKtEk+GdLHf+Z1QvljKJQl8hXXof7nN9vtQGiGUPhAtW+?=
 =?us-ascii?Q?tUqfsdLa7hnNG6Wj4iXlf9zwGPAC+dO7EEm1/1raBuaABkqTyUeRgYLK6qKA?=
 =?us-ascii?Q?AqHJcQ878NYLKe2az7Sggqcso2uZc8Sv/AcY7FAQkS3U6B1IprXJCPYPZTas?=
 =?us-ascii?Q?XRXXAM7v1Mej4ck5w3e+MwqF0hAOUnakfR2F+aixIIcbsPWwo4jHeQBhagsF?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3d8h0oAVLvD8Y4wGiFWmKhKkUHyCc2UQXSx0a6OgRHu2Xusbe+NhBH3Xz8O88fDe4UAp7sGL2FJDLOm4FTy4uDfU80WNr5T6Fe2n2PZWn5aM8t+u8qGxIMjKBZrs93EXsagB/weainLuDe7m1/JaF67ksSA6wqAiR5gi7R+8y1Mucw9xmnvBIaljWVzDYjYzPQ/MbVAPVaCw5IcQVWNL03yVJ1oE+RVUoSLKyAbmbAUBvwAcuXO550gEN6vox5A9YEAUDpJqW831/plWvTXXaaYliDpyvVYb2EvUrHptLMiWHRzujRxA3FDxz84t0LflKrMPeY3nfRrN2ayXuGn/RBeyHq8q4txBwU9dDO40zEBI3iXC2WcSazGtnpR5a0uKG4ynk3O+QPskNnHNW8tXFvdNhkV01Q3Wb59br4+wr8PJNmOSn2NoM8ZadnCinkYLTSEAE/Qq51D9fiK2HFhJeL2QMoW2MkbqWRQmdNvn1KeUgJnE1kgstqOG6TYY8unDJr8DT/vkweajHlHIi2DEaA+VCST+204Hu5FtgeTfI0cnsCmdnUP0SYRgrPRcvTwaamgXAexXvlAx3ibIZLvZm38bG+v0CyOU5QH+lnXUppo8Pe/0GbWgcKLpPVHPRzetolm1QCBmmGrYMr3UY6xYNfsjAtW+iJ5jLGFtJ54MBYX5tDE1W/qbIGwcpzM3Ar8e/BAyO5Rvl1KPc4FBjRG8zJpBoDP9u9J+2NAqBmnom22ITwQ1VSsxx4Sejwqg/BGvc6dpgcZ1Monas0632Kd8t2uTHw/Wov8Pky/C4Aab2BxZsDiV10xSinCsBYMr6coG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaac455a-b606-4e1a-0096-08db2bbdf528
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:45:07.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dUdAR/Q5lhsPH8kgOhfPIIvryp0ZnX2tFDwJDKtFcaSC4dCNoWUe8agulhCnVlXEtRSUyNBQJHvEh3qDbaEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230121
X-Proofpoint-ORIG-GUID: vZSR9nnGz7Hk15gOdp3ORhLQK50GX6_7
X-Proofpoint-GUID: vZSR9nnGz7Hk15gOdp3ORhLQK50GX6_7
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

[Cc:ed Steve because I think he wanted something like this]

On 22 Mar 2023, Luis Chamberlain spake thusly:

> On Tue, Mar 21, 2023 at 04:52:20PM +0000, Nick Alcock wrote:
>> On 21 Mar 2023, Luis Chamberlain verbalised:
>> 
>> > On Tue, Mar 21, 2023 at 10:29:08AM +0000, Nick Alcock wrote:
>> >> I have not dropped commits with Greg K-H as maintainer simply because I
>> >> kept on oscillating on doing that, so I thought I'd leave the commits in
>> >> so you have the option to do either.
>> >
>> > No, I don't want to do that work, please drop Greg's drivers.
>> 
>> OK! Repushed to the same branch, sans what I *think* is the relevant set:
>> 
>> binder: remove MODULE_LICENSE in non-modules
>> serial: remove MODULE_LICENSE in non-modules
>> vgacon: remove MODULE_LICENSE in non-modules
>> tty: serial: imx: remove MODULE_LICENSE in non-modules
>> tty: remove MODULE_LICENSE in non-modules
>> 
>> I hope that's right -- it's all the patches he was directly Cc:ed on.
>> 
>> (other branches containing kallmodsyms as a whole, etc, have not yet
>> been refreshed at all and are old: I'll get to it).
>
> OK I merged this set onto modules-next. Thanks.

Fabulous! It really is time for me to get back to making the kallmodsyms
commit logs and cover letters comprehensible to people who aren't me...


btw, as proof this is not all totally useless makework I just
implemented this (in something I can't even think of upstreaming until
after kallmodsyms since it relies on it):

% echo function > /sys/kernel/tracing/current_tracer
% echo 1 > /sys/kernel/tracing/options/sym-unambiguous
% cat /sys/kernel/tracing/trace
          <idle>-0       [001] d.h4.    65.103804: available_idle_cpu <-select_idle_sibling@fair.o
[...]
          <idle>-0       [005] d.h3.    99.316093: _raw_spin_unlock[bcache] <-scheduler_tick
          <idle>-0       [005] d.h2.    99.316093: perf_event_task_tick@events/core.o <-scheduler_tick
          <idle>-0       [005] d.h2.    99.316094: perf_adjust_freq_unthr_context@events/core.o <-perf_event_task_tick@events/core.o
          <idle>-0       [005] d.h2.    99.316094: __rcu_read_lock <-perf_event_task_tick@events/core.o
          <idle>-0       [005] d.h2.    99.316095: __rcu_read_unlock <-scheduler_tick
[...]
  kworker/u32:11-121     [010] ...1.    98.665295: _raw_spin_lock_irqsave[bcache] <-__wake_up_common_lock@build_utility.o
  kworker/u32:11-121     [010] d..2.    98.665295: __wake_up_common@build_utility.o <-__wake_up_common_lock@build_utility.o
[...]
  kworker/u32:11-121     [010] d..4.    98.665308: set_task_cpu <-try_to_wake_up
[...]

Object file name fragments and module names in tracer output --
including builtin module names, though it's not obvious from that
snippet. All names unambiguous, though I'm not sure about the notation:
using @ is neat but it's not really obvious to the user that this
corresponds to {...} in /proc/kallmodsyms, though hopefully it is
obvious what it means regardless.

(I am totally open to improved notations: I changed my mind three times
already.)

With the kallmodsyms stuff in place, and a bit more to allow kernel-side
access to it, doing this was not much code at all:

 kernel/trace/ftrace.c                 | 21 ++++++++++++++++++---
 kernel/trace/trace.c                  |  1 +
 kernel/trace/trace.h                  |  3 ++-
 kernel/trace/trace_output.c           | 21 ++++++++++++++++++---
 kernel/trace/trace_output.h           |  3 ++-
 kernel/trace/trace_recursion_record.c |  4 ++--
 6 files changed, 43 insertions(+), 10 deletions(-)

(and really you can drop the kernel/trace/ftrace.c part entirely, which
is just updating the stats output for the sheer hell of it).

(the tree is still under internal review and probably still awful, but
if you want to see it anyway I can push it somewhere external.)
