Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF7C74A5B
	for <linux-modules@archiver.kernel.org>; Thu, 23 Mar 2023 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCWUir (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWUiq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 23 Mar 2023 16:38:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB1272C
        for <linux-modules@vger.kernel.org>; Thu, 23 Mar 2023 13:38:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NKU4JK021713;
        Thu, 23 Mar 2023 20:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rYVH016btmLEE34+A9gqlEd2ggNfscmZdj5SqCjkQ5E=;
 b=nwev0qXNxgRsXgBykrcKNje6gbvGCma3L7JffSLPKfH8o+XQsoYaszwa6mQHBR9PEmDj
 fOzaYfrff2UzAfOOTsbnE8MIB2bxiZ6m1OW3KEh0iXK0LtUmTKl4fZg0hiVpc+7RxZG7
 vnENwJfF3g9Qz3VBPIvcpCnoPwXc4viCzIWN8bOmzOL71JNjT4UEeU2goBn9JLeApXix
 MvskW9tup0eA3aSqIkyrbpgNFaGq2qsRhvAOn6LT0BPpQqoO7qweDkAQtv2zdyIjvuDp
 TeFgjytrqVT1O+bXmT3KvhzS5T9i/h0haxpg5Sm4FSQl/q9rZbUrbpNZcM26jK36ofwV rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgwut80gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 20:38:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NJwBQ6025700;
        Thu, 23 Mar 2023 20:38:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgt8rscgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 20:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcLlhKaiiBoOR1hVh5nNPx7E+33iyL8JQaRYUzadZawjbIZpVOTvrYAzUUglt5TI0VrFQCuZ450+knRbIBTvZsIslbi0Tpn7//Mu0orqmcGPoT2Zsud/EfhXUSk4DoC2ZfUMrP821qal8yxqjNn7mSwt7qsYXh7aIjQHydgRkuch7jE0YWKBdQgo4fCK0wFsdABLRLBPHf2xZzxrMOGE8UEHtC6M3BQDyI4qKuMMzPMU+VvWSgwe/imEqwjErT7u3LGNzhZcyrkY0peIbxoNWlz1ODEqA3N3pZwEoXQClgF0KpV9yhQZZsYM9reSLhMmLtW8rjqfTG3kyvSOmBXYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYVH016btmLEE34+A9gqlEd2ggNfscmZdj5SqCjkQ5E=;
 b=Wh6a9L33VUlY2ENjIq+WS5Q0BdBnUEUClhByBsAY+t/FgCO3N0lyxXrJ97wS55mcKf95dKsOfppKjZ3um+jA2gVN3skw82o03LdA2v4jd3cHe3R8a65RCZHwCz11h9LAyOtB7W9WsVbAPoPzL6A/aQfVFLVMBRMxBOvYMpKMtlXfCceuPAPRF5MM+jjzjK2DV/R00lbwnWb5gWi2pj2SLj54Z/4AMl/y7K4BmeGUYGUVj/mIN6z+tUVxHHJKhN9U+MoZMEpw473l9nndF7CLfVsL4Nys9CX5TcKdqmWUCmGcF71yT+P4hn+P0+gA3Jdr3c8lI5lB9HC+nk9tDkBYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYVH016btmLEE34+A9gqlEd2ggNfscmZdj5SqCjkQ5E=;
 b=bwrm4IaGApfVakmGsZ7idfI2fsa2eYRFKMwRvd42rDjHsV/D+jzCZ9adgg5ZKl/H0sSHmo17+Zz+sJbQRcF2IZEBzqFDt4PQNAWD16/SWdyS8FI+YnqiBmYa4xE8EdcBSFfl9xaR5nA/TmT/6VlNHok+3GkyoVa2gpajEj0Ufu4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 20:38:08 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 20:38:08 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: module_license tree refreshed against linux-next
References: <87mt46s8i3.fsf@esperi.org.uk>
        <ZBncDHaZfKEHAjGu@bombadil.infradead.org>
        <87r0tiqc6z.fsf@esperi.org.uk>
        <ZBuQOXi+my7bnXzR@bombadil.infradead.org>
        <87zg83mn75.fsf@esperi.org.uk>
        <ZByr4Wpg+OHX93lf@bombadil.infradead.org>
        <20230323160022.2e4331e9@gandalf.local.home>
Emacs:  a learning curve that you can use as a plumb line.
Date:   Thu, 23 Mar 2023 20:38:02 +0000
In-Reply-To: <20230323160022.2e4331e9@gandalf.local.home> (Steven Rostedt's
        message of "Thu, 23 Mar 2023 16:00:22 -0400")
Message-ID: <87v8irmcet.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: afd4cd05-9087-4658-09c2-08db2bde831f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGnII91xlm4bI76zbmVlqy0D0Hxt+hkuQNTEJba/s12wkb18V8QjOmnFzVT7e5T31qrCvFcGOPI/peyrSp6G/qwrvtApVEKPLCCX2X2BGBBK9ibE1QKy+wmkACvxtjYl+WJpdOjNgGN3QeMopEYQChATTWVpOYHwb7AtTl05iUzPGQwTaT9irXgjdHUO2D8JPnw7+t+dQyGo6dvy2ple1Bkyr3LzscLU5eZOGTR5gUsbcQ1H1dnr+h7R3/ZjeI4OiZLfZJjt3hpxkhM6IzklNoS6ryglfl8v/oVk80skbBl1I+YFzgdjK4xpmBzI9s+vCnkrLfqgSPSJn6vkBaEgXAS8PxymOJSd4wdO0iYCmDwXqQlWz2sD/NIzt5ryvQFuckiz3YITsNGn2qejupaCn9qZI+txBsYkxg8Ol1vEI9Jn7/fOFvXmW3VvJ8YW0rx9yhmuYAk2fAICXmruCMHPa+nygsy2zgRtIL1reT1qlDgLv4rS5r9DFIJmN4mwQJgcHxLuvj5x7kG3/iIcCp8QTlI6jGAGYPgzO9v3nPyIP3sLsDE3Mp5verGkqZ1ifAvRhRFvEOL4zku8qo5hNHKUwcgYftzjy88u2l9MhF7+4VgBDcU3c1f8OyE/XrBjT5MgWWyDsHX8EJx6LDhutyF+GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(36756003)(38100700002)(6916009)(86362001)(8676002)(4326008)(66476007)(66946007)(66556008)(8936002)(41300700001)(6486002)(316002)(478600001)(54906003)(44832011)(2906002)(5660300002)(9686003)(6512007)(6506007)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vd/jtc0zakbJargTypzXtYVJW/LEGedLqnZ5x3ukjkJeIoVt6ETWh9AooIbO?=
 =?us-ascii?Q?LVIHOeSHbEFdQ+92t3JfYvkVFrsafnmbp8uTSZ4hyA3Hc/wNb8dvGYz1EUqK?=
 =?us-ascii?Q?Ie5+6zc4Ud5PVkyMI0HAe8SiwK5BCcQ3/5E+8uosV8aqBGEiQSuzWK2x8D9i?=
 =?us-ascii?Q?Sb7SUhcy3bseRhQztGGaIMH3QMLWKxEbXk8K2AE4E92MKQTlAMyEOmRcsyoG?=
 =?us-ascii?Q?wjQeAyVJ5qb6jbEXUUhqayksGIbqFduB2RulvmZ/F/JBQsD9aYAHIF1IRwk9?=
 =?us-ascii?Q?n5o+bQGPXt1zfgz6QACEj3C3osrCc3wtUAzK2ZTQntEi0ebiqZhcQaE/Beoz?=
 =?us-ascii?Q?buXOI0J4t5aM8VP6wl3fORaGsFl544Zf2cWYxFsSTjTP70c8mvJvJNUe5wa+?=
 =?us-ascii?Q?tCDsOTobYUXKmjOAPTR8MFrbhByKhwisMONwHTNyJGkPikbE55iAmSdqdl0n?=
 =?us-ascii?Q?2f9BLOV9Vxy6jq7axKN5v45lX3AFr5DfmzNg5C9zYjpYkTa2RiSdJ6R9iPY9?=
 =?us-ascii?Q?FWicKIz2U/VcsFIv5l3rjNZ89WnTDoS5RCqrKUFjiD5ceYxqlNVbLHjmO8ho?=
 =?us-ascii?Q?dtAyFw+9C7c5ibTAj5frBYtYuYxsMCj2gBhD18R6ntDGt5P58UYm4JKV+Czv?=
 =?us-ascii?Q?OZWetusxcWZrj2yTjyLoDJpFrTgGY2h+HgCcGGodqvC/OD472tJIBAGRUHdA?=
 =?us-ascii?Q?jjohR51u7F6g519V0KMzqlSsF9l5KBSof2DBVMeJSjpmF/+dGEG+R16Mf9oj?=
 =?us-ascii?Q?4cNz4apeR9DOxcEGmBuvIBvmXfNsb3aH9ze2O5f8+dDCHOYQkrM0z9RJtODj?=
 =?us-ascii?Q?C3TY4ZVcpz9zJenaFmvAlCMLOdkLVlD3cP3Nu5Rc3W6EBHIWakhpsRQbW7GQ?=
 =?us-ascii?Q?Bt3DRb8VgHztuLTcy6jsrbBya1Re9UCIZjSVJR37lctTS6dmSVIZhhaa42ZN?=
 =?us-ascii?Q?2jfIe1ZweVikuwvNS2bLXrJA63ikifhg3PAVpfBIoz8cO60cIFJB+fRT5egH?=
 =?us-ascii?Q?bf11G/ez/gZSt0PtwGf6ZlMajQknNU10xfOGVWzPPRhS0EKGDXiRmx+sj26u?=
 =?us-ascii?Q?W7Vy0FHjuInWPQlt/TxYblbpSkdCkbPfks7D+h9nI8lqhpe/3HXc1URWA9JO?=
 =?us-ascii?Q?TJQRzKZPLxDp+MAICki1yrNuYJone0scV23du4yetkYg/MVl6aHafJiM23dJ?=
 =?us-ascii?Q?UVLQwqLvJ+Hts1NCszHmE8YFM39z+e7dR5ikgEJPBTRI6/J6on9wb1wW/Gi1?=
 =?us-ascii?Q?9VPNFOUmLE/J9ndvfnB0uCxlcIHqXsZFka9tkQY/o+Lk5U/cIcUH1K6UkKoA?=
 =?us-ascii?Q?1YcJyVAyhIjpx2l/tPx//zlsTO2JWKRc2PgUqnLroAeTnFXiCub0V+g8JyD4?=
 =?us-ascii?Q?HknsFROqt6iNgqPXndvCc77eNmstPV0J0uM+lvmN5BDe8y6uqbxXm9iz+tvp?=
 =?us-ascii?Q?kW7LkRx2OcC7kClOeaL1z6RdChDAL41tEpMAUYVpitPwCIA8wVvH6pWQekh5?=
 =?us-ascii?Q?UZ0oXUsYMYhfEYrEO9IaSSlLZ7+HtSKmczzK/OWTKHPLPWj6OxFDAQ3kwWpK?=
 =?us-ascii?Q?VLos/IpTPgKSH9sL61L0sabo+xxPaUvnm6FZITLfH5WXgPDa+qJyXRW3zi5A?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aBJf4cKTFXbBwExp/EgOB8qrp0Xl1hw4XfsnvbLv9uhg58fjmT7y2XxSf+yqxL3avqrgEfhG0EHUCxfO+bjrGKwroGQzsIquNs1IagMDUcsMD/LOV0mn8T7uxuxCT3JDs6fPVWMp67M5f/gBGBX+RVgRbTtpUnn1zTA3F4l40QBWmKmSQroyEKjN4HNSVqZZtP7PujcbebHExba0ubaEnD7cLcolnXQa3L16ZTNbhtyVIOhkUNRay9FRQQjK1woAT9ai8pL9vRCYgnff8nLmzoRYptAmWnDRBrOF38iv8HuBhp9kl7zUa1IcxQsDeyfFexuajbsIfoXriQkdcELhsCXBtSXu5OLI526YVR5pWE4PelaL1sxfDWjoGc5f0Q/7+k1i0z6opHR6jMWGtpcyYoo14suTbWkR/R+z9zS6HfZYmufLrzEnh7QGp/Hmw21LjEWaXYx8pNosqoa/aFUyIDGLD3V4CzUd/N8EwjNuSWtjd5Yb3eY+QuOqfEdI5OSTo7wjwaL1tWkLrnX/TjHNEe3XHjozGdyz0qpwJxEXdsUPECsU7yErWIa5HzqGnUYX9nkS4oayJPhNhf953scRZIBorHP2xuPcdJ0RjOLTi7geM0p+uQhlnkLmXQrRs2BgwvxHguJXi8hEiKbMs7oi+3Xi7vUx/uMBqHDoZUJRjJ5sqkHDulSVskqIfn2qhQbs/cQIVpYaqZ6nRgCv7ru8xlAonzjPd/aOM2RGF+QqFLRKPX7I/xvp8U9C9lgEWwYEvmbpjNq6pkOMItQHuUdS6FRHinHwJ47EpM5MfDiuO8aHrEA8aYpYLjf0qx66DOh7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4cd05-9087-4658-09c2-08db2bde831f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 20:38:08.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5YRHy6o//jCf9CwpYMQsluBbUq+TrtI9XxRRPIqiKvQAN2GERiq1QbegyRwCfPSuVun1lnSJJD6K69yVYbG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230151
X-Proofpoint-ORIG-GUID: wF6R-FpD2fNk1bgNZMSoiPM9VUeUZKv1
X-Proofpoint-GUID: wF6R-FpD2fNk1bgNZMSoiPM9VUeUZKv1
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 23 Mar 2023, Steven Rostedt outgrape:

> On Thu, 23 Mar 2023 12:43:29 -0700
> Luis Chamberlain <mcgrof@kernel.org> wrote:
>
>> On Thu, Mar 23, 2023 at 04:45:02PM +0000, Nick Alcock wrote:
>> > [Cc:ed Steve because I think he wanted something like this]
>> > 
>> > % echo 1 > /sys/kernel/tracing/options/sym-unambiguous  
>> 
>> I'd like to really hear if Steven is really super excited about this or not.
>> You keep saying he wants it, but I haven't him say it yet on the lists.
>
> I'm not "super excited" but I'm also not against it.

Yeah, honestly I don't expect anyone to be *super* excited by any of
this. It's not that big. It's not like, say, ftrace as a whole. It's
just something that can be used to implement small improvements here and
there.

>                                                      But I don't like the
> option name.

Oh the name is dreadful! Better name suggestions much appreciated.

> Perhaps "sym-file" ?

... Yes, except that it also decorates with built-in module names.

> Or does this happen only when there's more than one function? Either way,
> let's try to come up with something other than "sym-unambiguous".

It happens only when at least one symbol in a given (object file *
built-in module) pair would be ambiguous with respect to some other
symbol with the same name without being given at least one of those two.
It's a bit hard to pack into a couple of words... sym-unique is even
worse, sym-objname is deeply unclear (what's an objname?) sym-filenames
maybe? The question really is what property users care about, and I was
hoping it would be that with this option turned on you can always tell
all symbols apart from all other symbols.

-- 
NULL && (void)
