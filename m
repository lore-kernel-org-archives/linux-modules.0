Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C07E95
	for <linux-modules@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08BA61CC2
	for <linux-modules@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGGTKU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42702 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhGGTKT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167J2K1b002984;
        Wed, 7 Jul 2021 19:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=vbEfcgTJK8pLJYBE8vsKH85e2xK8mRGTphAFvlqnK/M=;
 b=cqRUW6SwOn5BvNOeCKD3aVjrlH9inM/K1uE2jxJfFBt+sPvB9gQ56NkFdBVxTs52rzRK
 MBVii1U6TYHDhoHbwGajQsSS98ZJvhof1o1jvS3fNWKd4/SarXabWElTWID/u2R16Oy5
 JgkIsSG5ADoe87j5/uCPKkkRkLeom2yQMXfEGof51rQt+zk6dPFGwxt3p6v6lXo8bFXG
 NlTRhM3mOC8BDkzex+K2LlJcHowBpZ6e3AxuBmPcvdcEbDE7iUg8LiZH9z5i7SYYn/L/
 3KB6mLJh8zEj9m/xoNIcZ77lhXYgG8pcj9s6PqigtRcXaLQ5KZ2cpt7BZTzb0OWCjQQO FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n4yd1md8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 19:07:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167J6YNb127797;
        Wed, 7 Jul 2021 19:07:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 39k1nxr1bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 19:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3larW12Kxts0vhOEgH6G4pRvYmVo32mTCqOxo2/A8L7oiNB/sraKMjr/b7NZBsxihi7UAQr3ITKRLztv1nzPnPJyHRD9RRuEsUVFfpMEojAMKzYQ3cbNB42ZvVJgWgE4LNc1AAYQGlsKlYiqYSV5oiql/TVcaZlSRkbVauiJCv6lhzR/RkTIgTxIvlP48JoSJjHY2NOUzGdGCEkZDOL7pqE+lJnc0wevk0V48BYqMBftk42mQkXpDi8RSuxrCMKx4itnWDhr3Yx9mzE7DeJptsrUb1ve+W6DAkxLBFuz0krhcx2ss4ZDyUOgf4jxL6NwchuwLJisIi+MpK0DwJt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbEfcgTJK8pLJYBE8vsKH85e2xK8mRGTphAFvlqnK/M=;
 b=e8+SL6bby5DFlrymq46KEWEHkbRYVe6j7OfJawzRQH5t+0iYsicpgaYCuB2dbEmI0lhZqTgI4ATkkmvWgBwRvyh5mcbXa/lfWSWVSiYG7CK2KPadw7uieQ9V6WSwFSQwDBYadQiE8o58Ht+2oe8x3pDSE2Npnf+S5DyZg4K81+BgaDiC1uoJ1cQ8qUPl7gpj46MxMtNoV40BTnhH1RSsE6rWczUEw3NzggCnBiFI1Aj0OlmLc1wMPd4U6h77ziGIq9UQCp+ak8atHrjtxxEnaleDrOE4I8XP57xmtxPVEcMWrr/hOv9ZjjDsEchVry8orobqxQNCBUTnncmLi0dQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbEfcgTJK8pLJYBE8vsKH85e2xK8mRGTphAFvlqnK/M=;
 b=eddFZghqA6cfDF1itdpoASUq7En5TbJ34X/ZuyVH72EQNN7KQ9Sw+UEOtib1PmcPcDQ6yQ/jJUDYs1NrT+v+g8FnKu5WFbfeKxR861zJS9CCCYETC7A9g5fbKuvLbvWrcysTM0bmDX4SwA2fz3lWWYsEtPQT4qOdkT/gEQqe3FI=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4409.namprd10.prod.outlook.com (2603:10b6:806:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 19:07:33 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 19:07:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: Re: [PATCH v2 PING] kallsyms: new /proc/kallmodsyms with builtin
 modules and symbol sizes
References: <20210629221542.93728-1-nick.alcock@oracle.com>
        <20210706193334.474270-1-nick.alcock@oracle.com>
        <YOXAjHC9RPAI5QwO@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
Emacs:  an inspiring example of form following function... to Hell.
Date:   Wed, 07 Jul 2021 20:07:26 +0100
In-Reply-To: <YOXAjHC9RPAI5QwO@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
        (Jessica Yu's message of "Wed, 7 Jul 2021 16:56:12 +0200")
Message-ID: <87lf6ic58x.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom (2001:8b0:1101:10::2) by LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 19:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c60250-b903-4068-322c-08d9417a797b
X-MS-TrafficTypeDiagnostic: SA2PR10MB4409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR10MB4409184DBA2F1E2DCB540B638B1A9@SA2PR10MB4409.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ScrgmxDTQSKsOE0K+LsOeKDiypP5ap4SKC0rivBl7jS6Je+mC+g4eonzr4MKBeaYzTRd5SsK+iCQJk7D7Rx6D9gz+OWd66WZXWerkJ+NJVQntfNV+kPjAioimq6yiAcdmrRtLytms6c1qsKhArryXDzQQeCl89Pk08XHJpjEbKj8s9G/9j72RBHn7Q8omQ7Hux8UWHkIr9aOrN1CrH9pYCntpj+JAs6YC4m+tEh/t2jbwVUaRybhqGytolJp1izp2eEfK/DZnMF9wN0esfBlSzgGC0pmma80sv7MQJKfGYBOaq836AbmwUFozMJY987yYWWWpejsOUqZI3h5esJ5r4e0nUtU/MCTZC9MxkBOGfKinkWb4X/dpandfqDaKNLS/YwnJ5lSWLQQblyzJIgxkugzOwksi5GvIFD0wFvzGq9d8LC9AHMDSOBXJUbrde/8Ls9JIcLycKtJmnE1p79MOWEne4EgB6/fbeufL9HfftiuIJ6Gp1bhik7Ck+7IhnLDd5EJxCGFVz0Aev/zKRKfIdGZWPDkTCF63bUkinK0QiiV1yWEbjyYb2DgA0Hp2iZd9srugK5k1ghsgcIf+D3erOHdUelkwQRRgAGeHLisrH5t9KFKjOXjCqBQJlIxOQjzE9rM5kkkYAO5vXrbQxR/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(38100700002)(6486002)(6666004)(6496006)(8676002)(6916009)(86362001)(107886003)(4326008)(2906002)(83380400001)(54906003)(52116002)(36756003)(66946007)(66556008)(9686003)(478600001)(44832011)(66476007)(8936002)(5660300002)(4744005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfY5RKDc4aFCmfoqt9PpBFr8R1Q9zOh+BOjU50Kk9+H2gqaCUsNTdCj9LslL?=
 =?us-ascii?Q?RYHMmnRieTNBfz0k+vTWNBonwGO0YhyGscAIO7DRyhKCaUSezyjJfA03XcKp?=
 =?us-ascii?Q?ggeHHCv/Kq/Jv8Vs1eN4s4Ee0PFvmaasxMv8cxtBMMBBe20Tz7HyWqMJRnYu?=
 =?us-ascii?Q?Q4isNnntu9s1T0mJeOeH6RZ/Tk7DmXUgbm96q7zqt/iEtdaUdezSSMU+PlUk?=
 =?us-ascii?Q?PHCFIsf7iiDYdOlgIOTKvryXl9jzdWLjab9JTlRdJQldOibVYuScfLyyRov9?=
 =?us-ascii?Q?elDaYPLaIFDqqFRAEDOjLpR1guj/CA+gzg/voKkar8N4MZhVJFiF5RGQdoxv?=
 =?us-ascii?Q?6UliGZnhQoIKChjQEwIQuTO/LpR0ugZj39VROwO9/ZtRkX9VQTJUMKTDm5cb?=
 =?us-ascii?Q?nxZv1TmASj5m+vB/fifP7Nb4JoNY7yYPH1K3qEpld1+EXqTRpdXga+87upW4?=
 =?us-ascii?Q?C142IjPmkzKw7f0KsKqUod3+kQ5CpDyqb5sfllefhI8iLx2AcgFIGXqVWJCQ?=
 =?us-ascii?Q?36NphltFNZubqqVQswbIg7rDzRoW2YFDxgIHtwE38DEi6AnI4kySqxM+URpP?=
 =?us-ascii?Q?dTzeCtGGSiYP6RQfHQg23PTwTmLBeb1/qtu4Bn09g2dSw5nlIkiYlpQrq4oi?=
 =?us-ascii?Q?+WnyU3Kad12F4mMupn6NMWQGY4Yp9SvWqphmeYXUPu+0fCKmpK0mK6TYbXYH?=
 =?us-ascii?Q?/LyfYlN3JeURycqzJwtpjy9iB/55AyaeJpfM7Ipj6Y4feqbUEICrGqRWtaPq?=
 =?us-ascii?Q?OBPT/9K2makcJVQrwPjg97vr3NJNmEbkqxzbl3gro34z1At1Ygsvt2SDL05W?=
 =?us-ascii?Q?qwurleLfXfQ3rSycIbqmRGscvm3Ubhftvya8/G3dofDN+1nmih6J53Hex34l?=
 =?us-ascii?Q?9mD65z4I5mRGnKVyeQJ4I+fAl+SpDLvGPd8XWsGN9b+rKDEinX16n9g6Z8Xh?=
 =?us-ascii?Q?HAzqclElCzcA3E6iyyQ3g9I1EW62DqIe50SWTZR/TeDEvvea6fTyKUpD6mfB?=
 =?us-ascii?Q?87aS3zoxsKFXGoEUi8YbVjCMXJ/hF6G9N7iMv6lix9Xp2qwD/73UtHg+9RP7?=
 =?us-ascii?Q?IP+V38BiolznTnAZMMNNSaqT4jMBCoKMCT4/ysxqoUDLSWkV9Otk9tqXHg1b?=
 =?us-ascii?Q?msUWQ9+OkaMThFFY2CnTqKAo5/DI6m6LGvQ7/46BtUgk872qmj7J6WAShPP/?=
 =?us-ascii?Q?INcbZvcg8dE49G2EenvPkFpJsZFf1YfTsDW4A3xG230rCdnchN5O5P+dNCJs?=
 =?us-ascii?Q?24xWPrZLcxiwpTveEUI9+4rUbevke4adPi0WPxktSbJZ7BEn90s7gi0ZY0aT?=
 =?us-ascii?Q?QrlHTOZevmLjkv8rYD4wr9+79tMCR84XbqOe5f9pZeb4uA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c60250-b903-4068-322c-08d9417a797b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 19:07:33.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8DzRBvCYKiWHFjUoJFJP5bWddjnHCKeXtUWzMrq25KSkDC6VpNEkQz4ATGw0S4kajy4ndo1YFUhBDbOQCu5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4409
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070110
X-Proofpoint-GUID: 8WTKdxlFs0wRhYdP6C5L7_3_himUUh6x
X-Proofpoint-ORIG-GUID: 8WTKdxlFs0wRhYdP6C5L7_3_himUUh6x
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 7 Jul 2021, Jessica Yu uttered the following:

> +++ Nick Alcock [06/07/21 20:33 +0100]:
>> 15 files changed, 1309 insertions(+), 67 deletions(-)
>
> This diffstat is seriously _enormous_. Please don't send patches of
> this size and expect people to be willing to review :-(. Please break
> this up into a logical sequence of smaller patches to help your
> potential reviewers and resend with a cover letter.

Heh, this is very project-dependent it seems. I've been told not to
split up things so finely when sending series containing 3000+-line
commits to various toolchain projects before :)

Since you are in the "slice finely" camp, I'll split it up a bunch and
resend. (This will necessarily involve adding things in one commit to
no obvious purpose in that commit, but I'll keep the intermediate stages
building and booting, of course.)

-- 
NULL && (void)
