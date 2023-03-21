Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF14C6FD1D
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCUQwi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUQwh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Mar 2023 12:52:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883EF26C1C
        for <linux-modules@vger.kernel.org>; Tue, 21 Mar 2023 09:52:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGnFx6007377;
        Tue, 21 Mar 2023 16:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MnsKg4cXHd2dqR6yQg3ErK1cjtQ9vGH1v5eiJ5HBcAU=;
 b=lWs1MFcTLK0cro0G0MaSF6FaS6DVD6cQ4oy2ZqEsqTt5jJUIT7ib2lCPfbj7BF5qWO+Y
 rgT0U1qNvKJsL8hCTwGWOjhrZVoIUiUftKJniubxjvWCtr4bZe06xMVHOqDk0gFIwZc6
 2oxSm1PKxxloizgs3qxATps4SoQf3j4JMehZh8OhF/7JxrLbdwD8Xdj3C3qa3/OgINEC
 3uvpOH2JcFZlJbbE2khTUjk6ANyTH4WN6MjBD51wa6AHpiaZg30Zm30CjPghXkDIuN36
 N2Fb1YuyoLiwBwPF8yr4IcVvjPxqrztEFZRp/JJgOLIFzhFk52+QEQ5w/EwgSXWXCHwX Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdpsea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 16:52:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LGFVdP015374;
        Tue, 21 Mar 2023 16:52:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r6j2h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 16:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh2SClTmqip8IixbWG2zr0ZWfHtXdtr/+zI/LY30rpv8sT2Ww4YlRpbuuk/tdOrmvPnh9Lt7TV+5aOwCqdgVafbzZuACRuFLtWDEvCbcPuZERGszFxEWLpyhVcOfbBK7hfXDbXPw1vK4nYqEe8vhBrl1cXCALvjwY8AK0Z0INtse6oWJCUqHysE0jgLInIaQIDS7p+++7gAY/sRYKIzq/W/+MXrQgm3Wx/qVU1Uw9/zfGD2XY15XZF020auQXgjvUGso0LO7Yvn95iqMOR66m7+FxpKW5e+lhnS1q4NTiyJWiCcvUW6chzAvLWFFzSlJinEtGuyRuv8tv1vKrGRjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnsKg4cXHd2dqR6yQg3ErK1cjtQ9vGH1v5eiJ5HBcAU=;
 b=n2mxRo05vVYxXhL0HTpjDbm5y20Kwrk24XLMQ8ngKcxegvGz76ZwRxwHaVytikkDrCC4dywi/vh1+ENehmzw4Re+zBK3lHO2101h045Y9zu8JjzWo2/xuAri238IO0fBX6qtQhfsyA9ShmKtSqFDOundyCZ05K/2nnOgMCH7zUo4IWmfV8C35yQh57V6+stCdmq2Na/nrjT0Saos/qyMRB+3L1rATC3Ln4vbuH+G3Z6RfB2FgtmPDmS97wElAZE7QNsy7ah1LcpYP1dD7p4m//luW4/OlbyAU2FzNLmOR4dQl46AizxaXMNjVpP4hFHTm3wI609EFmqhE0eJH2E8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnsKg4cXHd2dqR6yQg3ErK1cjtQ9vGH1v5eiJ5HBcAU=;
 b=JSDUbNxxcj7Kfdam2j8xgC/JkqbYDaANgfX6EEyEVhHg1L26qP7ELJQ9hnr/kg4qIDbED3y5dxVJcgxCqcraUo+XkDN96eSKCo89MXMNIDsnTIctAGkWypb0kRaPN3cDaOoStcEa+K/X38Qrp+9r5B5OCDeSY/GVslVuhAtTswg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 16:52:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 16:52:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
References: <87mt46s8i3.fsf@esperi.org.uk>
        <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
Emacs:  don't cry -- it won't help.
Date:   Tue, 21 Mar 2023 16:52:20 +0000
In-Reply-To: <ZBncDHaZfKEHAjGu@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 21 Mar 2023 09:32:12 -0700")
Message-ID: <87r0tiqc6z.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0170.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CO1PR10MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793dd8e-c3b0-4eb9-564b-08db2a2ca63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9WpkRF11r6FUDrYzEnYDvX6TlKjS+1x5FFiIPVti6USTYTerhCRToXxzpYgInUYw5Kcgup7o6xm59x3QBCY1IwYMrbIgPDcULBt8BRHRi1WM0cVUUU0XifQjPTj3TxXTp8lP8vN1Q/qgDrPRl3AO5cLChgl4CA/G14ayz9fN+ze9eecC5sdzHUPuTBMmpbG0K7O//yaBbqcJ2Kg/ISe5wE/KqAe1no2wTpbMwviL40pSpOD0tPlZt4xWE5Q6GH57LAqItuXi1OP1vK2+VSB/HoX1UC9vpJDbxJrPnBqtSt5UmmIyuHUA+2c51gJj8b5FocYuBzmJgLzTOdSCg/iDFysBi34rT12+uLIDQpnO2ZwkZb+TvV3JIG1FPlg0w/8PSu1kErKIUD3hoAE711PUdRdtSQ46ResWJVq/TdzMsSdy0YGxW+HA+2BppUWhGTc/zMWZKxFQaOfzYypcC5QQlVcj9Gxu5wmPPs3x4VEWv4urt2Q/ZgeIz1y+lGZ6/8iSh18SbvQ4CqUlcQN5QHdN+K2C4P680CyxfhMNdb531WuXyAsjcbCKPFnHBXVh4pjOwkHEEf3jz9zwvjN8GDxIOPxowGQggbnzJk/ONxN+5KgP1/VVb4fqmvA4Pw0ma/0RL9aH1Orn8OOmWLUQsYwqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(316002)(66556008)(86362001)(83380400001)(9686003)(8936002)(36756003)(41300700001)(6512007)(186003)(6506007)(2906002)(6916009)(66946007)(4326008)(8676002)(66476007)(6666004)(44832011)(5660300002)(38100700002)(6486002)(4744005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCZMvHwVB0adce2IzgrAZAaXlkMhg13maZI8mL5WYq3M4UvBZVv5gYi0dl1A?=
 =?us-ascii?Q?4MVvgI+JbBQ1giqKsSc6Ni0wU/6AXYWrEUYAVRRA7yOsQ69KRm4K9Ocplkb1?=
 =?us-ascii?Q?m+hTqwru7ZTy9KAhAWuKoHoQdyQBI/cndtcAPZRV7Dn07wb0ZgWRtin/jMpN?=
 =?us-ascii?Q?+wJu4GEmUf1nVd62L4xVFbLB67ogU+dz4ofRIugxns8IfCyls2mERfG41aOR?=
 =?us-ascii?Q?DDS2CbkyL+3RXoOZE7RnwiKLQZYX+vqYfXl890zjgSHigMky6nt+2eqxoSf1?=
 =?us-ascii?Q?KIahvE0/dJHf7e8KKxqhWsRovG2z1/LUzr7+iaJlLd76X08NGWjWb7EIka8K?=
 =?us-ascii?Q?Y1Jld/GuBLGoiQ28My3vOnw37CVy7tO1ZSA+MOlWETffpOt5/Wf2SYPf/LwK?=
 =?us-ascii?Q?zNRQ5jcuQGh42GpoajAdxW352JV5GFrScIfOt0+kEz0sIi0wNM11OzT+brtS?=
 =?us-ascii?Q?4FcltnAWbEApFnWUxRrl9oyhWn4Y0h6U/EYNSfB3uUETA5YEp7gMAUh3WUe8?=
 =?us-ascii?Q?p4tXLiUumHYeaNcpHv9NSHhdSQGUBuNrHzCxV3+pCF4QIOOlPQ1Q6JNjv6l0?=
 =?us-ascii?Q?8FeOdLH+k3yGnhMt3IuVq4lpN8tCiC9EuQrUaGVxAYv6DYM/MYuGFpv4bCV9?=
 =?us-ascii?Q?v4GJ9XasLe0roG0tY51nKEx5eVgUIyBIjf4+Bi4Gl/qMxckYp3ugRpOf9pae?=
 =?us-ascii?Q?5E62AVvrrURXuCN0Fp0qKDHoaxCru2c65oUYZxPwhM3fzPD7mEp2j00iseOm?=
 =?us-ascii?Q?t5wOydBMVfzXTEuXstzI6wnb8dyYZLQMvfn2n4zCb4CDTu5fuA3bICJ/x98H?=
 =?us-ascii?Q?0gnQSjw3T2Ye+rAR/d7Jfndt3ynCQVwGqbuAirhba3N9u+nbBvcVk+4qoLUh?=
 =?us-ascii?Q?wBw+MQm/HntHdZKr+4nfC+ueYQ9+FYK+k2PxG2/HuKCnbu1Kd6gjx0awvvfN?=
 =?us-ascii?Q?p6NGfM1whhpGya0svdbfey5sWNxUpf79DGAO8jQIGE6WOq0ByrQ054fgalDN?=
 =?us-ascii?Q?Nbx3Ts43s5317JbJLc/C9QoeZzDBUdDnWCkVBQ0Z1U25/ZvM6ZZCeSdxMf00?=
 =?us-ascii?Q?JP3QhGN8kNyAh4xvH3PyHW3Y0/2FKDlIABSTVdbUiMrJwSsgYfPFEuI/R4EE?=
 =?us-ascii?Q?hGJoIqg7CqrV9Ho4KplkVNkths8VuM26uwNUoAxgqx9nP1kFuYHm0Pj+UCV+?=
 =?us-ascii?Q?1DY0ltct+P4IZinDSMhMuM6a5MPZJajnAxJlF7Kt1atp/kCK+9tHLAGBUUdM?=
 =?us-ascii?Q?W+8tvmKoAZILuxse+X4APWq0kr0VZxCxV9yuNORJxIfFr/zsjV+IzGdr6HHM?=
 =?us-ascii?Q?Zb0eHr0P//HGi1OIke89H+K/rskWfVi6dSyjEe+aWXfg+35HxbVk+Glmwj06?=
 =?us-ascii?Q?WOfrlGSSSBkVa4gbNv4bko7+uDKKyIvxGqTMBN7w34jz8Gv0z36hvjHkA/WX?=
 =?us-ascii?Q?SAIkHXXoIogl4MY8VGzKOTtUhEOmY5iZ0hTmbyHyH8AmcYci8cRZsjuUuzF+?=
 =?us-ascii?Q?ZgctevFy+dpmI37NgnmOfpoZpNXsLdHIWI4s+V5bZ1P+rqmiNRQ9mh6M+qA2?=
 =?us-ascii?Q?JoueDmHXlTHJrlYXBu60qt2E/tBMi0JQ5SXpyZjOZ9sC2ualLHPy5Tj/lUVT?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ubVqnRadYtguuOXInbv1fVr5HUVgIihzH6QJJJohO5LV9DkxhBD2rpOOdV1LjdM28gaeovsVrHkH+EbVWSaRp8vOMVwyy4UPYaOUjK/g7wPIeUPyUlolF10V7dEjIiVXqwe8GVK60nuvamhUEjVjyErTgcNFD25Y0rBnF5JEKaEwlvY7cnzWtKGadc4V6dISQO9jZDlgx8WHeO2+hBbrwbWCAjHMJ7hGkTJExyY6Yk0xtOzDgcLqEmQzOd2aCOQ+4N2khq/gUjEGTiNOPEbVzXZrvUNGDszzf0Dih7Vqg8SMQHQBu9ZUJTNyTT+O6g6e/MBLdMSBy/NCorAgqrMB38sbv0ApEVsVojkIRxYOvtIZYSXI711ZoEiu6bXZG2mDnoXveXCoYZFaVVd414Ede6ZeOlxCyMPZlMNd8j4NBzY+t/OPrez0hg9pdxRTlCivk8FlK2uMgwx1WKxnspbpUB4VvHPSMwVRWwwqHYBVNIyJ+Blspjud7eoM98Wn2SWoCJ/R/+vLJSWGOw1HJqZclsWabJPXKHVF3qRd41PhFCDV634gxolHiRYTsmVXI7bvRgdf9V07rOoFhoKi4Z2wpPbVZzudry1ZjLnwcI2HfbbXfclpnFJRIyfxjXNT0t6yZJ0dUhe6+PKvkMFxRRCurl2S1hYYGS+lQu9N09QIuRbiM3UrRAScYpQFHd3VVASBClIt1V0SPSm0+yALGqkvoPoSCcJyULUn/qaW1EBHdMYmBxVagt9tbljovaJVM3peqUVrc2SR2NKzD67hngAqDuEBM05QKQ0QugbQXGvgDOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793dd8e-c3b0-4eb9-564b-08db2a2ca63b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 16:52:26.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GG+lf5cAIwFDTzwP99HHKBvddLnoxUj0tQizgata3WfubouNCmUgzLrHMQqJ3nhhKntW3eFTcH8LPSGIsU8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210132
X-Proofpoint-GUID: HunNm105kCI35ZiMwYzz_OgI22huxbTD
X-Proofpoint-ORIG-GUID: HunNm105kCI35ZiMwYzz_OgI22huxbTD
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 21 Mar 2023, Luis Chamberlain verbalised:

> On Tue, Mar 21, 2023 at 10:29:08AM +0000, Nick Alcock wrote:
>> I have not dropped commits with Greg K-H as maintainer simply because I
>> kept on oscillating on doing that, so I thought I'd leave the commits in
>> so you have the option to do either.
>
> No, I don't want to do that work, please drop Greg's drivers.

OK! Repushed to the same branch, sans what I *think* is the relevant set:

binder: remove MODULE_LICENSE in non-modules
serial: remove MODULE_LICENSE in non-modules
vgacon: remove MODULE_LICENSE in non-modules
tty: serial: imx: remove MODULE_LICENSE in non-modules
tty: remove MODULE_LICENSE in non-modules

I hope that's right -- it's all the patches he was directly Cc:ed on.

(other branches containing kallmodsyms as a whole, etc, have not yet
been refreshed at all and are old: I'll get to it).
