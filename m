Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B700C74A5B
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 10:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCUKaX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Mar 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCUK3w (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B747425
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 03:29:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HkE4019792;
        Tue, 21 Mar 2023 10:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=naIdpHkglB47VvvM2mUpKP6MGyFii1sgUBmHX6kPPiQ=;
 b=TxnGgAp6QOl/gaRxAbHTuK1Zy6AG69BKFmIcThQsxOZINAyun/3FY0ysMlefVm01wT4b
 Vc4Aghz0Sjjy48mxOOqUFi1ooMwMRbHeZIP0bsp6FSgJUIiEvwih1An0KBD5xqIiaV1j
 PDDZjKsXtDHSTrch4qLcWvwdkRh1eFKWMUjCnUfTnXT2AVi68AZjUQ8Bs2SMJlap8D+3
 0NkouM60KUEQ0O/Hhc9ZTGy/Y6CquWm4BtqkMXaLhqIPETFy3naSxu06lBmOuavtxg3V
 cf9uxPoKULX06OvzpB1uI9+rqf6fyIoD2LkOD6+iTwv9gVBKZcQdRZRo16qD2tBPD4f/ 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uudrhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:29:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9jUSo026460;
        Tue, 21 Mar 2023 10:29:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5hce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 10:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd54vaOIUJG2F9ev61rLpZ/KW5TawNvfIBs8VesezS0sbB1hiAMlYNgq8BrHkZBaSWWOsndU5dahLAeSO8MiflU6XrR094BMCRWSXROLPgGx/2JXB02CXft8bDNzkFT9VibLyHT+mlPLSMMhyvqtINbxBFtnx8BOWiLcAVietGcDUW1t43oOxrOjJP1yK52LVpt6St9pVNgQCJwpMD5e4rUICpFl/oNahFPHZLbqwiMx8bVsp/gJKK2wfPF1IiLWV5lZWj90RDLJ0b71FokcuyqMM6XH1+PoxQzd/N4fgsRt72cvWoT85s/jAIHEeQylKuJvKHpViOWTXBAfkl2DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naIdpHkglB47VvvM2mUpKP6MGyFii1sgUBmHX6kPPiQ=;
 b=UyiS3xSbkFefoy/fxNq+UyNyEIA5k+pjjXt2n2QVcZOwbeO8MoS9GpfSJQYqmHSPDWl8PlLW6DRnytiGzC+6nInHraE287sHMOMIDUzETnjFeMmona+0Zvn1lk17x9T6HHuQRBdczmXEPZZw290BGhSSyOnJ28pMJtYnaDc6I3DbceLpw47vn8XwIjhkuc5b1XTpzBVwMbNXQfBWaAXmdGa4wUi4PfAzSCCtXlxid4DDyeC5l5XEYQvcsptRCw7OeVz2ay2aspQKoR5e7YzXxTk2Pd4ljlMyYUzFJwu65fuangBM/1w+0ZayOXe6dhfo1LqDDFT436TyEVPScAkGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naIdpHkglB47VvvM2mUpKP6MGyFii1sgUBmHX6kPPiQ=;
 b=tTHLV3Trc7rLM6y0VBdrTRAb0nI4IQM+QIHJd6j6NSYayPHXybRJd/S1u4RLjkXcAt+0bfbeKA0bIYvApbRZnddBlZUsf7MS68BQuw4MSLdS/64l5q8LKorg6fvOn+aP3rfBmKUf8A9JO9XCukXGI1Sm6uhIJDtg2Y7QX9VGHFI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB7097.namprd10.prod.outlook.com (2603:10b6:510:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 10:29:14 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 10:29:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: module_license tree refreshed against linux-next
Emacs:  or perhaps you'd prefer Russian Roulette, after all?
Date:   Tue, 21 Mar 2023 10:29:08 +0000
Message-ID: <87mt46s8i3.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0346.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::22) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 8754366c-07d5-4799-1d75-08db29f71e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc04ut4R3wfS09UwxuFLN3jky7ZYpVRFhYMav+0xUPepivvmRfzCCFnnnN4frNsvR7WzxewC/mtBa9YYukMAtuZaT/ByL6eHaqCrXQYolCBj0Fm9sXmvoy8MDKpHnwkmjH/64ssYA8GPp6e7lNyrhSJ7lDYnb0Zh6BQFPgUjrH9Ai8S2Vo4591eWRtHjUkPr4t3yo4X2wAi3BDgdvffu1zBdqzK9hvbRT2HKM0ApWCnP9MYfZfMrKOy0zyQYObCCl0I6+HocczZIsaAU5bV1ODRylsS8e0mePDHlsUJDSaVHRq0lVCWovqstri7p0cTXgmdnosw0iLEd5pvvgNy+67oUYeRGt0P5hu1Kp5NyauZSHWdBfBiI4jSwNT6PbYfF4HhsJLF8kHElejUIEyr0vKH12LIgd/jk2ePJMA21yHfy2aFE9FA6hU9eC/o+Bz5I4BBHL9A/BJ21DaO4cr03qu2d1bnc+9XZ69xeHJnVppF/+8RteLEXv+nMVRh1S1T53wYzqipGRV7V/ahZCtGT0glK9oyGL8Ad8TviMuHYeBsZJ0H9wxTPMLJv8xaDvM+dt2ysQlSwNH8UeEb/sUmdEpvAJETv5H+PTxr1gVflN5VC+M02rPEYZLVCrCRbuZ1e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(6666004)(186003)(966005)(6486002)(9686003)(6512007)(6506007)(38100700002)(86362001)(44832011)(478600001)(2906002)(83380400001)(6916009)(316002)(66556008)(8936002)(8676002)(41300700001)(4326008)(5660300002)(66476007)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBqNpETMkq/pWGTSWVdPCX6OHt4O5w4yNflTTRGhsqUQtqr7nKxm1it/O0Ll?=
 =?us-ascii?Q?hW/mfqH925zgHHttKknJQJNFec5FkUyQcfolJ15jJ7xQc8tSnw8YB3ekfnCc?=
 =?us-ascii?Q?2HLumSbcb6EgnG3ozoWNoRC+fp/RvAMP9T26nQRclPwfoQl8Yw248xvpNQkK?=
 =?us-ascii?Q?cWqtQXjJoTXz6WdSDI79CGEQxE/HGlBrD20MT+V+IRhi8lZBB90bEWdKjNfM?=
 =?us-ascii?Q?UrTivAnqG2nQy0Pz707yxJjxdEgf2i4FFLaKwXiKLbMYyC95sJbQ72Ceycex?=
 =?us-ascii?Q?L9APk0IekLid86WHSS2k5Bd2mrKn7lFWrR4uyoJ21K6J9s/89IAwuL55EEHu?=
 =?us-ascii?Q?SLAseLzm0+4kR7rQPDUah/q2HWFZ8/OTckH+RfSLQHudNNo+1lxnusETREZ8?=
 =?us-ascii?Q?ZsJhOa3gxwHodVd4yypy6ms66QsC9+1WUS7s1A5y1pxKLyM3OZuMrPWGinPc?=
 =?us-ascii?Q?/lLbdX8TuN5Bk76M5d7+gSwiAWHHl0FXxXbXA5P5c2uY84R5pB4aavWXsdN8?=
 =?us-ascii?Q?UwGZMCYBlSQWK/5XLu8MjSmzggvQdOQ8MprLrnAMR2Z2LFq1zG44myvxNuii?=
 =?us-ascii?Q?0/6yztkmdp0OC6A/dwHvFHqPOwNN3z9gYo4WBIG+tRmi5I5LEOJp92S6J//5?=
 =?us-ascii?Q?TGlGx0LUjLKxolhcymWpmgmb+Q9MC2b+ktKg1blE5H25LwPjmbtElCgrDQwM?=
 =?us-ascii?Q?3Y5keDk1d48okFAa+hvd96TmRqbdDFLz4F8J4niU52gEvLo+YpJtx3XmjUcD?=
 =?us-ascii?Q?MM8OOl/B1qgw+YaiIkWNp/pSdwq1JMWL2Uz5QBRRH6gpNnTLv1w2IcgL0HE4?=
 =?us-ascii?Q?GpxyPEjut9tGN0+TQBgY+fYaj7i83yBU7DrxyfrmV0N4LtH4zanbtEORLlOj?=
 =?us-ascii?Q?0vE6WIeAfd+CYgwOGg2IEaIY5KxHHSjN9d4aPk77GMUnxiOeYXpYC8fWmI2S?=
 =?us-ascii?Q?r1RwOvHc99I2/Cyztul3+L8gCx8W+uMvIL8VX7JSIRfWj7Qakq5OJ+2Bp34l?=
 =?us-ascii?Q?TpKaZPRKK43WYOL1jS7g2cYL3AV8Tsa6Ipl2O8Z+PqsIx7ij9lYToPr8yIMm?=
 =?us-ascii?Q?ijXegnbqYEkGb8eu60EI6bxQRgpvTCqBM/x6blr+DGC4S6UiGrDI/V0vWwa/?=
 =?us-ascii?Q?S7OVt6WWHyvG/8U3AKhok3SbixKtjr40OGISRXOWF5q3Yx6WsunR7ZyQGvw2?=
 =?us-ascii?Q?hngdl4YFsGHMC+NFt75DQmtTnMr1ECCPo4Cej45D9qDC9Sm46dqCU5zn6/Jd?=
 =?us-ascii?Q?+42/VioKmOobbwrOmIXOUaZ2zubGmf3ef+FlC/ZrJgTrMNyThC4VkMluwA0z?=
 =?us-ascii?Q?zDREhMrTiOs3LpB2mdBuhvmypEvxgo1R5swjTa4uJr+++/K6Riudnr+7wGop?=
 =?us-ascii?Q?/dzq9cj6Fwz7nBxBfbcJSeNNPvFaGsMkCbcVCEh5xGNH8NP9RMC6mrDvavnd?=
 =?us-ascii?Q?ZM8uvSKdha4uN1A61rmqXx2eHIkHtUBZ9nG94FAe/nNBuz+TXNbUf9zfayfk?=
 =?us-ascii?Q?ze9YCCZoRAskI1xT8NFaU4n69Dohitf/0sZrx6r2slTRiOMvXAd1EUiBN/7Y?=
 =?us-ascii?Q?nznjwdCBhGCK9UQPIEr61sI1frig/Uoh3s2vWH6ina9CLdj0Q8ysf6zYFD49?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 009O/LJ3R+IBSxaq27g5up3wsHJz/Ili5UryxfDf5TrNFuW6/Zm8KpbyVI4zdnJ9vn7Cs0LG040vvV/fM5qPr2vbJYNg7KlZDcC1iqynXAefoBwEKDXfMnd1DnMk+4QMxDYA/DbzzC29njN5kc2sumRXANwK5jKOdhAuIeOEMqK7EmEmGmeT13115dHHnghQnuPg0r2c2wn60f3xCBRZKiCn5eagIDWJUfKQEMrQ7xzV8YAogobHkHoV7vse5s0MYHE7py/qsLKyxiXiFGs/ni4KF6qF6IjM6YBZ18tEEaFsonxgfkoqrcVfWBs7Li9jSo0qhvNIyE7hGMN6emHNAMsz2Vlb5+BJmheM6er8xPcUK2kVBbUBChqYBARPLELNV7rSishhLzql/hICHNrHLoR+eNwXPi/U8F9z12+I0wZKiqS84kVwNmUDvwY6cB0WDhIIiY5NZ02DOwAXmyq5WsO5auQ01q2cZ/v2Wza6a52nSP7/MSp/FZfTy+Ui/P+3pCIivG7aCb5yIf0aGea387xNuFPFJ+FKTNoh5SozI3R+eNzhb59CVG54sXrrT62ZgCPZkXnJnbKziur4Ht1LIOYPdW9L0DCPT08lLnPbS06I076O/sPNed4w/2b2gdjjc1+p0AAMBH4Z162mk0Z3K2mz/OsyvZhAQqWDiYgC9nOLsRY0Ci+ffh/8U0mVT6LVR5Uc8WqAO0zry4xUAXaW7HYde902zckgZZDVenxq91ylW3JZmjW5oAFGjVwf2Fc9yHsa5gGfO50kZs3FUoOWg9DV70ZNs0NvtxAU55CDTrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8754366c-07d5-4799-1d75-08db29f71e09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 10:29:14.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o445b6wxKUISq+UJUPZ0cOBaxkEX/b9nTilphS2h3qtuhk5ZzZs2uqW6W5Rv1ODX/mo/bcXK1O+acV9sbdjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_07,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=757 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210081
X-Proofpoint-GUID: 5HVudat1X1Fmwm1iB90apeANa6kenVl3
X-Proofpoint-ORIG-GUID: 5HVudat1X1Fmwm1iB90apeANa6kenVl3
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Just a note, now -rc3 is out and you might be considering looking at the
module-license stuff again: the current module_license tree at
https://github.com/nickalcock/linux module-license has been updated
against latest linux-next, upstreamed commits dropped, and all the
acked-bys/reviewed-bys I am aware of added. I've also introduced a few
more commits doing removals of MODULE_*, module.h inclusions etc where
maintainers have asked for it (but have not done that treewide).

I have not dropped commits with Greg K-H as maintainer simply because I
kept on oscillating on doing that, so I thought I'd leave the commits in
so you have the option to do either.

Test-built with make allyesconfig and allmodconfig (with clean tristate
checker runs) on x86-64: runs on aarch64 are underway. Not even tried
booting the result because booting an allyesconfig kernel is usually
troublesome even without linux-next in the mix :P

If you want a branch containing only those commits that have
acked-by/reviewed-by, I can do that, but it would have depressingly few
commits in (largely because most people who acked commits also took them
in, so I dropped them from my tree).

I hope my doing this makes your life a tiny bit easier!
