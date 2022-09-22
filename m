Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8CCC54EE9
	for <linux-modules@archiver.kernel.org>; Thu, 22 Sep 2022 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIVQuF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIVQuE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 22 Sep 2022 12:50:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC092F76
        for <linux-modules@vger.kernel.org>; Thu, 22 Sep 2022 09:50:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGlb5e018427;
        Thu, 22 Sep 2022 16:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=8arHb/P69UZtlFQojUezUCf5xWvEMKjOR/opjhJwWrU=;
 b=q2UWNCncAT/Ju0BNBTvnwW8DnKWntk3UpuBuqER3f3z5fpIFHfLkdubqO51T5skhSK52
 a7dSbvTbS+mdcf0hAcW0l2fnX7jUMhhQhx/XYvFXLAbnyIHUGZBuuM7ltA91jKBN8JCP
 UerVRdXQqSfaHACJQxJObpf7agQN3aq2418N6ti8NyNek9l8WFZgAgA9wG8pdUheR9U7
 AYdK7Ywv4Uoh9ARG/XUgLVwzyD14eVWqUvlSCf3lJ9byV5+L5r/kr51aHq+Ao6AlG/ft
 +QKKLGxt8/9/vR4fHcJBtOsDzjGfZsLvKD4kpcMwg7pvpvuW0ucKOUNfaK99Wv1rVgcO NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68me5y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 16:49:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGF0GF005682;
        Thu, 22 Sep 2022 16:49:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cqtefj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 16:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsO/Md6em+wXZxj4XqOqNq3NwXdfyHZsY62MF82rw1BdQaANwSw+sLtKc9cSvbbNotpmA6Qvii07s5gTJYOprfUx8wQ+UK3jJKg2BKxPWuyW4SpqGTsOlueBHWoUk4pJT3y5cwPvFhdfWoPZlrPOxTwbcDGCcaFVCMEIRHCOQMIvnxYVVmmDR7pVneyDe5KmW9psKfc8sn8+jCxYq2usQggnjKk2aA3nfS8RvlFH2lekOUg6IXPwsTZdaltzKNvkL5nUoGXBvLw8wbUl+5Kw1D1g7szhl9gSZjruAhePlFAyzsRSCevxWOO2gID+bTnvKDuVynOffrQBlfJeFKhcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8arHb/P69UZtlFQojUezUCf5xWvEMKjOR/opjhJwWrU=;
 b=bDtiaTHq0LoGf1HXMDRYKLuN2+/2HCWlJXrrkPFsOjyueI+BJhwJfi22NxUI1Z/lud9tpBXahSesCmUhGPuKOWXYD1drMvgygtpEKlawmpreBtLlGOMbzURleRf2Vczsps77DOVDHn0pTBRvOtz57cm7jQDE/hWIRfcyR/X+mCUBFDfpy66PEUKzuyUxqAYCfRHVHguJEPQADYh9m6RfdgoXk6/hk9JQme5pPGXvSaOiVxrfuiTbcGCb7T1Zoz/YYhXX42y9iL9Vm1v6iv8OPdN7QUqh/vQtscoPg9tkL1/JNVc8NLBKtvcpszzGwdzZsTRIEJP3oysyYHmYXLbuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8arHb/P69UZtlFQojUezUCf5xWvEMKjOR/opjhJwWrU=;
 b=KSCMwXbd0rpodjUHWnr4I0cYktlw/h6/X/lthcKSkDA/SRwBLdD2RP8DB25hd/O+x5pWpNnZFVLwKXMbFpNESr7vvEQgzu7/qZ97AgEwgWH9dfCiT69GDj/E5WGQ1dEg23fYMV9G6ufYEE8f+8iwkQHt+j6WccvFHIYdXTpvMSo=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 16:49:55 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::9cf2:b5bf:e865:362f]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::9cf2:b5bf:e865:362f%8]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:49:55 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: kallmodsyms: just checking my expectations...
Emacs:  freely redistributable; void where prohibited by law.
Date:   Thu, 22 Sep 2022 17:49:50 +0100
Message-ID: <87mtaricb5.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0213.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::20) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:EE_|CO1PR10MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f469c18-d305-48fd-c787-08da9cba79eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52SnUgQ/8XyAZGxSbEql1Nzbp5g1q0H34qIW4za7EyxCCi13IIH4+N6JvfkMugvxTfjFCc8UhIwGS//hhaSBqWg8snoPmR2smsOeFjlKIQ5z7jRxjp5Y91gVIYs13jENoYOLKbdxauHKf/2S1kI4O6byvO+18j04XkM4ESSGWCAyJao5Ltpcs/jC7r8gC60Eo4QfaFhuZKpGZWjDBxDPmO3Fzs5ISnopdHdhUih9H0vFxg6aN+HGPomW89EAyIbXaxjgHuMlP37OYA/LWfw5PY/0h/nX5kSqpWrPYpO6gFE/JliZkWMULoS6q43zf+O69FCCuWLmD9e6+mtB/Jh8vzK6PBbtFOIwiVJisxNe9G26LGtvOwiMDHlPkWp5Nl2/y31unDrjdtG8OXnDdTheMVH31pE41tW+ruVveL+UkplBNNx9KGp5rN1wD11/udstqxVobQoZnUgeZZ5E1ScP93ilGmczHrqbg3VHkC1CnZ3z6AHo0u4HrQNMmpoVTiz0wIRPpr03rcPg+1lFypEydXTN7Ww0M0zqM8NDWNGPV0zWi+lp8vT/igttvd1wkRPoHli5rebWCp1sbk3qdVrZdW77UxuWnWv58PPAhQ3NSfpsEGU1hnwhIiOcu3k9hsL1c5aP2UXdaGMJywQ21+afqrG6d6h7YOjUKO/uM9Xyarxu9vB7YkXxPSiExuv2YfzLS6LgWCXvHR93bJ4guq2hJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(5660300002)(4744005)(44832011)(110136005)(316002)(6512007)(9686003)(6486002)(66946007)(186003)(66476007)(38100700002)(2906002)(8936002)(478600001)(36756003)(86362001)(41300700001)(66556008)(6666004)(6506007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dg9I2cU54inPWrTQ0GuTuEsdaWN9IT8ZR30snLpyejckNSCMS6LLYa20teQj?=
 =?us-ascii?Q?L8cNO0K9dNnTBGp06jbebVu4hG1rL4TE1lo3aU7zavMdtCuJ7ua1vbiMO0xT?=
 =?us-ascii?Q?QI/9+sLGXo0dw2ziePSfq9k6LroygTC8rDwWuYcx6iX2CRulJ7PywKIaIa18?=
 =?us-ascii?Q?rQkCx5oTbLWQLZxYb+VaOz06kZlHH5zRqwLAWNiylF983AXYeVW44T+ROT3O?=
 =?us-ascii?Q?Yx/kk0icxb8UD0Y4r3r4WurdjoDEQ3Q60Lxs1bPjnV25P/AD6V3uPCOemC9x?=
 =?us-ascii?Q?D6c8jpop5YeKm3SozMrANG+239d5++ZQObiBUYGw5RmSoLYiUSHHqV8ljIX9?=
 =?us-ascii?Q?LmsNjbW9oM70WnpmqlN/nN6WhwI4kmn45PmDpSd94LnIdjmKV0N9hTW/+vvI?=
 =?us-ascii?Q?zXIyeYWMB8WmlCn6Urgl1aL+x5fD6tJCoeWpp94LNkYug4cUVZ4CaeXKHTSL?=
 =?us-ascii?Q?Y3NBguDYTBX3PwLDMuY8czBAEEMZGBywASjAa2APRVFUv39dpF5QMvSWidV4?=
 =?us-ascii?Q?szrNi5E0d0V7naWk4BpEvlylaJO3VYX4fWZNZrCtLiP00YBFl5NiolBie/Wz?=
 =?us-ascii?Q?xF/Cox3rsEcAD8PYGx8fsW8E71cf34yTB58dzQCBm7v8KNZ7NCLBYRsPzUL0?=
 =?us-ascii?Q?xaLZm3jGYL2pu3Tm2FyBYipGrC/J3sBQSdW0QLc94IOb6TnuVwqX33NQRX9C?=
 =?us-ascii?Q?BcF1XVB9J+2B+Shee1j88swo/4h51vT0mCZyhH8t6QkC/jxWbvoEluzqOR+m?=
 =?us-ascii?Q?ruzlGBRkJdArn+oJQBEDJEZW11Wz1VcsmApKqi99l9y46C/L032zbyA07dSY?=
 =?us-ascii?Q?VErndtt9fn8KDXDoDkOD5zvpGzDzwQoUYL9nHZUpdkj/lOQXDDuFtUNGbm5P?=
 =?us-ascii?Q?EUDi0fISCUa4FgKAIUoZVBrAfvYYfqMlojHSkZr0ChSxz9Q4zoagadZ4wVUS?=
 =?us-ascii?Q?jEx+zmB34ms0Hdj27E9av19tnotJAtd3VyTsPvTH1q3CkjYAGmKCAFNT4YFZ?=
 =?us-ascii?Q?0c4mzip3b9/aZh1d1yyrgN0kt3Ts59wb5vcDBe4T0/clVqfhMQYKkwM58RMY?=
 =?us-ascii?Q?UWFo5fO5PqBnLBlL16Lbw8fO8d7y09xfHqjJ3VftqR6fbhH9v5sdZuuPbD1R?=
 =?us-ascii?Q?8TEpoiP97SFnCPFi4nPWCOz6N71YUcCpcd4D4mw+zZZEzfF1aKgsNjH1h1Pz?=
 =?us-ascii?Q?DbBq8943vxAio4NvRwaDnPV2vFZSR6QYiN7sdD4O1AUGhtlVFA8VCj2AhsSC?=
 =?us-ascii?Q?OWyMZKk9AknJez/RRQAlMmpEpcxMgCVl47hp6BrykL9ADMJnsY11iJpPq12m?=
 =?us-ascii?Q?VTT18ODaLsmLcl90tb0Qp9ZUEiWOJNdiOQBbi1QvqiF59jpLjJYTl4CR294F?=
 =?us-ascii?Q?V34gWNZ19qbj+RYK0yRGS0t6jJad0xa+Hk7mjItVYlRvG7qI/aphfPMAbJm+?=
 =?us-ascii?Q?xcHkPO9p7kOfDhPsyIAB+WOyQdATKIrUxyCu6STxYl7rOAqygnLSmnwtF23g?=
 =?us-ascii?Q?Tm1rB3Ej869Lft1SXgKjR2lwuHKMyWTkDEJXcyIeYtolnOous++b1vjhaqwh?=
 =?us-ascii?Q?HdVKhbzzBZayoo+bbrj5Ur1UuU/epadUtEsWVZGnNZ73XtCyEo68414PxcNZ?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f469c18-d305-48fd-c787-08da9cba79eb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:49:55.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqOyNNOECnTJuZ8/anYlSRXsWLx9B7bSYuFBc/EAbUM3ZAi1V1f1SRsVprXUfZ1is/bILmmb1kWX1oTRqr/SLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=992
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220112
X-Proofpoint-ORIG-GUID: W_z0F9r-uxtlcYmInAsT6FqtWv2Uveqp
X-Proofpoint-GUID: W_z0F9r-uxtlcYmInAsT6FqtWv2Uveqp
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Just syncing up briefly after LPC: thanks ever so much for your
attendance and amazingly helpful comments, the session worked because
you were there :)


So, I'm planning for the next version of the kallmodsyms patch series to
have objfile disambiguation via {...} for otherwise-ambiguous symbols in
the core kernel, but not yet in modules (because that's considerably
trickier and can be incrementally added to a working kallmodsyms). I'll
redo the cover letter to emphasise its role as a way to disambiguate all
symbols from each other.

... was there anything else? I can't recall anything else myself and my
notes don't mention anything, but I could be wrong and I'd rather not
waste your time with a patch posting that is doing the wrong thing.
