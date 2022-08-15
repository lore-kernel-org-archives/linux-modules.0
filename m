Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB1C25B06
	for <linux-modules@archiver.kernel.org>; Mon, 15 Aug 2022 01:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiHOBqA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHOBp4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 14 Aug 2022 21:45:56 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2062.outbound.protection.outlook.com [40.107.108.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A276270F
        for <linux-modules@vger.kernel.org>; Sun, 14 Aug 2022 18:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKn+PvlJ2FYTb/aHLEZElU2J1SzzXzTbNiKGPUk8XEdKbtiyOvbek1U96gj2jnNyM4ujWkjWwTx/WWgEjKOqHLeaHbv91md6tOIIMA0GnmpQg3JV0co9lgDcsagwMeDdTUO39mEEyKfaAiFwAAx40iNjbgzM8FWyMMiNXRC9+/zEVgGiJcNw+y0P+8nfLIcl4tdksyzpy5ZQ1OYf5ndr3+O0ii2ubO9X3D4KqkAYpQ/MVhon12CfcWK0/DRuMJopKkuppa/z6j9E+qLNToXwn2jxJIDHO+hoEMRhkIbD/klW+lThsSt50ex91iGOrzzbYtht5Nbml1zdQKLCHuMRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e+6NS8VXb4UXL4zw2nQyQ56s517T1LV+epQYi0uRi0=;
 b=KoH86KGwmUBoVa8J7N6/fVeFEGt7NwnojxkQcyemUKq2hyw4H2NDQk6EFC4ftuOSzGjcZZ4vgKRWHPLlFyDntkRMwPYjUTHK83+7pV0f3vWJjDG+bJyxzobjdkyn+5R76wOgFI7q/lnzYh+bG5UK2FYuGBUc4T2yj9DthPag1e9AYZCIRecUEmrPmfvf81okiX8ZfO5i+LVljpxoO7jnTu3UmoTiHbqFrLQlKS40jgxY0na0w4/OuAjTuJTM8kfu9hxKOm/znGzAJ/sS1jpMw4xpDFiXGX/1kzIbBpAjx5N+7xjFH4yvQDnFdATiHFDYkzoFU+hvUD0XVWvLT9WW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transtechnology.com.au; dmarc=pass action=none
 header.from=transtechnology.com.au; dkim=pass
 header.d=transtechnology.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=transtechnologyadelaide.onmicrosoft.com;
 s=selector2-transtechnologyadelaide-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e+6NS8VXb4UXL4zw2nQyQ56s517T1LV+epQYi0uRi0=;
 b=l8tb8nvba/C0FtZ/UAY+f7XiU06Zx9PDJyquw4o3rhFrBScy/uLJ+o8SFrsYvuw7qMATyjnd0uOGZfZUeAlSNs5VKnJjYmwAAJh+cAB5Vch2LFvXjwa6DYURk8+fPeN7WniZksGsD/70H+ejswPfinHtRHM3wKGut+cSwuB14gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transtechnology.com.au;
Received: from ME2PR01MB6066.ausprd01.prod.outlook.com (2603:10c6:220:ee::12)
 by SYCPR01MB4431.ausprd01.prod.outlook.com (2603:10c6:10:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:45:50 +0000
Received: from ME2PR01MB6066.ausprd01.prod.outlook.com
 ([fe80::f9cd:d3e8:2320:8413]) by ME2PR01MB6066.ausprd01.prod.outlook.com
 ([fe80::f9cd:d3e8:2320:8413%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:45:50 +0000
Date:   Mon, 15 Aug 2022 01:45:49 +0000
To:     linux-modules@vger.kernel.org
From:   TransTechnology <info@transtechnology.com.au>
Reply-To: TransTechnology <info@transtechnology.com.au>
Subject: Thanks, your email was sent successfully! - TransTechnology
Message-ID: <ea7b9ef74f82eab3b04a757c6df155ff@www.transtechnology.com.au>
X-Mailer: WPMailSMTP/Mailer/smtp 1.3.2
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SY5PR01CA0021.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::11) To ME2PR01MB6066.ausprd01.prod.outlook.com
 (2603:10c6:220:ee::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190d93d8-5520-4de6-1cc9-08da7e5fe1fe
X-MS-TrafficTypeDiagnostic: SYCPR01MB4431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j36NcMC9WnGOWhu3A7I+g8udgShhqSwcJNp4KzGI93B2tBwoybJbADuyRgSd4ZXZL3k/BPXtIxXNy1Y1gDEkRNK3WAYzrKL5ZZZ0wzjMlnD5a9u5I0GFDHVk+ikKifGSrdhlCz/qg4U597su1h5i7vw/XSNFGMi6YPWXrOXWRx/6EmHPb/DaF90yGK14xdfrBugAqii/PQwP/eMx1rBaAXaA25pKSfyvLuKBpO52lEtfm4rArELA8phX8ciXtKse9F+IOP3Ny0gIYSOJzrgTlYzK5q4ERfz8MW0+O9XmEQptrA9ANUGalaniBguFcnPE602NsPPkNe2L4kNCEhfdvsXSryNKtzgArpKdEZ3/huSjBOyXErmq3JfiE8RgXc9Nx7HvGTgCWtT9lubj8lRCqecQkHyhWU0dFYgtPUg3J+dC+JVHD+TqZ8MERcuSzQjRnWLKK+0M7gA7+ascN6aRelDFFxNxlbCFOcN7h/AnjUAUp/RNN+8MgTz3J8yk5JEwfWfjZReF6Hg8l7MbTn2uDQ/tjAhnfmoGQBMYsyUMJOWcrEW3ByXycyhGwrcqvPQKmrNUza8nPsd7xXQHkhDaWAqumapTiaeiEJLZHfCRct0jnPNFp732qNU34QFtWrpvNcyQOPtBALuWxmo1IKC1Anqal+g7TvLWHphAtgvu+UAIV33sjKoyPFDZBGMBnAGKkLjSSAX+NxKt3GV1+wvvC8nCMUqg+THQpEtPuUvWCw7gDxzwFH7UTj8u6XRCXoK1mjUCOmS3J5qnDB2zdjiZLDwrRJxz1krYk4oxpY+g6XuFfgLKIqDDEV2OdW6xn/yj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME2PR01MB6066.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39850400004)(186003)(26005)(24736004)(38100700002)(38350700002)(52116002)(86362001)(83380400001)(6506007)(6512007)(108616005)(6916009)(8936002)(478600001)(6486002)(41300700001)(966005)(66946007)(5660300002)(316002)(66556008)(66476007)(4744005)(8676002)(3450700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBRS0lTWHVGY3ZEM0hCSW1pWml0VWRLMFIvZDNCbzl0L1FoL0dKdERMMmJp?=
 =?utf-8?B?VmpXZ1BBUW9FMjRaMG9mdjJlbDQ5TmJsdXFDYW1HOVJRRXhlSDMrNlExcUdZ?=
 =?utf-8?B?eE9EUE0wT2c4UmxXWGdzOXZITXgwWUJ4bXpJUUpNOUp0L3Zmd09oSXNUeHBU?=
 =?utf-8?B?MURTR1Bra1pIdlZKMXgrV1RZZnlQbUxlT0g1dFJjdyt2K2d0Y1FqbEcxak5V?=
 =?utf-8?B?VUxha2NSdk9kYk5HRElFUUxKZytnL0phS0VEa0hLdFoyWnJSaDJVSmdXZHRP?=
 =?utf-8?B?TXFxSlhSa1owS0U0V2VpenhCRDdzem5TMUJYQWxhZUYwU3dxWkMrdTY0c1lJ?=
 =?utf-8?B?MEdtdWNadlZHZzU3SFFYa1YvMnp4WUZ2WWxPOVhERlBzendmRy9KYkZtb0Jy?=
 =?utf-8?B?cUYzNE9IR1Y5bFk5L29XS3NtSDkyMS9DVm5wLzdQQnVwNy83RXlpejJsTUJz?=
 =?utf-8?B?WDFHNHUzc3JCVDRhSE8raEEvU0RHK2tYeVVWaWJranJTcW1QdnRYZjRyeWdl?=
 =?utf-8?B?anhWc09NeFphZUVacllGU2FsVExPTjJZL0hKVzB3ODlSd2dBdWEwK0NtYkRF?=
 =?utf-8?B?TG5UNDAyOEdud0J0N3FwNjRJMnVDSlY2Rzl3T2pjSEpvTEwwL21VTWNjUWxI?=
 =?utf-8?B?S1lydXhtZUFEZkFVRE55Rm8wNDNzeDFVam5QTGExOVZ6YkRCZzBBd0xCTUpo?=
 =?utf-8?B?SzNGekZ3OUlTZ0Rpdisvd2pQeHc5SDV0R3FVazg2QVd6cFdSZElWUzZKR201?=
 =?utf-8?B?NjJNSFdwVXlYOUN4ejlGdGVCMHBsOERyY1lvcW43Z21Bd0xWaG5UVDZkRlZa?=
 =?utf-8?B?eHE2VTg4YXZNcnMrV1paRFYxZUMxYmVwOGljYTdMSFVRTEJCSHFqNmRJUHFh?=
 =?utf-8?B?Tlg3NXVYOTEyUkFUYUR4bDdOQkQ4MzlHUlJjc3RaYXUxNDlpb0daR2tpOStO?=
 =?utf-8?B?OU5Sd2c5VzZYaE5zSXVBL1pXSGF0VXdsYTBOc05DNlk0eWVPdVhVZHAxNDZO?=
 =?utf-8?B?UjRTZGZrNGxxb2ZBTENUdmhudzdQYUxtWVZuMk02dmVrbVgwOE44Nk9LdW9U?=
 =?utf-8?B?c0FURVBTQXpDZE50bjRyZmQrd2Q4YWtNbzlnUWpsR2V5MmhwZkpERFVRSGNi?=
 =?utf-8?B?dGcxY2VjeWNmODdSNk5naDZNYWluZzErZTNZclhBQ2NDalQyTloyakZDRFdX?=
 =?utf-8?B?UFpxbzJWTGFrWnpsRjIrM1JuWmVqTmtXZGszekVUMEtwUzBTa09FSGdlU3Jy?=
 =?utf-8?B?N0F4KzZ3NEd1b3NmYVRYd2luVWVISlQ1dTFYejlkZnN3RWdJcFZIYVB6Ump4?=
 =?utf-8?B?amM5cm5Hd1VvR29iTXdubmdXd05xdTNZM3Iyb1pTbEZ2NHEwRUEvbnZlZFhm?=
 =?utf-8?B?UG9ZWU5XSHRFdlh5TXhuNnoya1p6aW9vckJBZUlvMHJIblpNMmwwaUtwK0d3?=
 =?utf-8?B?YkI5b0NUb0t4aUcwWFRROTN1SHFkajJ3SlFWLytFSjFJWHhGSkc0MlMrYVZl?=
 =?utf-8?B?bDFwMDltMUcvYzdCbE8xbytBd0lpcHh3SWNDRjF4M2I1S2dubGI1YlE1U3Fo?=
 =?utf-8?B?RUNFRzNkUzE2emo3N0dOdE5JV3NEOVFWdGwxNGZjZ2tubVh3cm5Ja2NFSDVy?=
 =?utf-8?B?VThscE12WERicFJTbW1TdTJONWw1TjM0M0tvWnBCOElmMWwrdFNQeFBGUEtP?=
 =?utf-8?B?dzZFcCsxUzRHNVVmaitBYUlja0dwZUxRRnZKL01lSXNnQXBWYjZpR2xIWTR2?=
 =?utf-8?B?Z1Z6TEh3V1FaTE9jUkN2dWpudSsrRFBaMTdtSHJMK1k2aG5SZlp6Q2FWUUtt?=
 =?utf-8?B?SkJza1RNWXB0OUFsYXBBdEJteDVmeFg2ZEpOSWhiaUVQdUo2cTlta3JVd3c1?=
 =?utf-8?B?c2xaRVMybUc5KzhIb2NHRng5bUh6aHE3MDRWQ0s3UzVSSEdKRVpVSnJYeUVX?=
 =?utf-8?B?ZnJ1cmtadHBIa0pRSEg3a1ptQVBJSEh5OEt2eVBLUWloNnUwVUFuTFpjTllz?=
 =?utf-8?B?cXJ5YlpnaGYzcDNWNlRzQlhSdGpKbFlCV0tnQkV1SWMvM2lwbmV1cWhMRlhm?=
 =?utf-8?B?TFJRZGFVOHFDTjB6VTZyQXl0eFNEbStKYTR0UTlsUkY5elMybEhhcEpDWmpN?=
 =?utf-8?B?TzMxV1UvUXlGNnpJQlUzYjh6cW1qdDZnM1d1ZEMvd0VtWFBvUWZrRFd1aEcr?=
 =?utf-8?Q?Eq7Hb9hh9erTT2NMW+pjnqg=3D?=
X-OriginatorOrg: transtechnology.com.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d93d8-5520-4de6-1cc9-08da7e5fe1fe
X-MS-Exchange-CrossTenant-AuthSource: ME2PR01MB6066.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:45:50.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de8773d5-c0b7-445c-8101-234bebd76041
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SZucJYsgQ/kdVFt3iF087wyhrSuR8ezRmU6NsYIbVcxbgwaK1q8B0CBU139rRpQmadUijgrzEndsf1DjI0jI0006D3sS7FUaw06BLuMzDDpX+gIVDC0YtOOnkaqFTy5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB4431
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Welcome to Transtechnology. Thank you for your submission.------ Original Email ------<br/>Your Name : Seymourmaw<br/>Your Email : linux-modules@vger.kernel.org<br/>Leave your message : Apple: $250 for 5 minutes on cryptocurrency >>>>>>>>>>>>>>>>>>>>>>>>>>> http://yahoo-news.amitmanjhi.com/bild-6034 &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;

