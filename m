Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12FFC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 17 Mar 2022 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiCQOj2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiCQOj0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 17 Mar 2022 10:39:26 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BDF2DD8
        for <linux-modules@vger.kernel.org>; Thu, 17 Mar 2022 07:38:07 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22HCuq0L026419;
        Thu, 17 Mar 2022 07:38:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=zUm3rRtgzgvcBiqugXlImX+mOajZWBfBAWk8reOFC1Y=;
 b=sg/2+omuuRj9578jI/X90Q+q5FrsXcJ/8JLjC18Yk/LWdqPyx8rW8dudENYM1NqGu1Ay
 Cvy5e8eYjECFa7gJjQ4fuaxYMXJjZfxpJUkIxttKK5O/DmHlpOtmTfURISItcsMWWGbY
 MtyuaLdqfuf8zMjKZc+ltTsNZ7NfMmKUizvRuIrizOg3rkK/0tAz9mdoZ+CKLkV643XH
 weUlJfUuX8FKe9VMN3ApcoYV3JblAUui5b6m1/1F+PC6vo0tOpvK57BhbEFiHddqKKLD
 NDsIiyGz8Jm3oucRNxjlS+NEh29OCaduamYxnqdg8BlSz50kClmxTDKbiPru4ThfpYnm TA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3erqp9ccpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 07:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgIXf2/1e4bn4RWmHLO6g4LfAjedwWQMIqIcKlAaRCO0OYhu5oCCCTUEJJy4vxMInM69RDkZRb96QU3yRX6BGEQpLVl3PRBWB9XzIf/pt6q4t86qLTJvvZxn4nFH5iTkqe1k9xO2dn5V+DjSP3aA+lLr9gYWoRh2TodxXBgdYGfsBXZMCPETmyfnRwE7jRLFskijUIKNdFVpa4fA8vYjOh4YP4vAxmPl2k69pXz3iyKBM87ZsWK7/hw9ZMyGwEpog1ogQGFW6ewzEp9WACXAvZukuiDpJOMP5g0/gF5jDoYA96HrCKwVHXl/khlWKbwBPCqW3ayqiXswFxvOhPOEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUm3rRtgzgvcBiqugXlImX+mOajZWBfBAWk8reOFC1Y=;
 b=mF6DfZbPZjkCHl5ieTVOwPMhHA2A+VQpvbox0wr7MRAGocnb0Vf661uRugw20m1KNjc6qlQpB13B9NIvNNrol88eGil5lWB5/e+aJ7IX+4esTMkL+DI4SDu/TtO9wObqC36CGqdAojZxCd1QtUMcexc7CdPA2A5ONwo1Poz6MKWFc788VrRa6MZzzdt50MvkBd7xx/S7wiQTSrnCZlW3MTF1dS+e7vTGcrs7+yZ5n4IyXz+JkGV6/PToSJsAXU9L/3LFGwzXb1CVc3U7ZbVT7cHPLj9ocaNtUpPe4DglFMFwcZTOWbRliWl0LTPa4f+fdRUauz1Qr8pb5ridjZs4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7)
 by BN6PR11MB3891.namprd11.prod.outlook.com (2603:10b6:405:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 14:38:04 +0000
Received: from CO1PR11MB5076.namprd11.prod.outlook.com
 ([fe80::85ab:e185:1d9f:33af]) by CO1PR11MB5076.namprd11.prod.outlook.com
 ([fe80::85ab:e185:1d9f:33af%4]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 14:38:04 +0000
Message-ID: <2f6ef6e8-3202-32ec-e07f-8bc512276e95@windriver.com>
Date:   Thu, 17 Mar 2022 07:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: depmod scanning / priority question
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
References: <4b6c4e71-c7e7-f9f2-3072-bd0a66926143@windriver.com>
 <20220309182552.zxlaj3at4sja2b3t@ldmartin-desk2>
Cc:     linux-modules@vger.kernel.org
From:   Saul Wold <Saul.Wold@windriver.com>
In-Reply-To: <20220309182552.zxlaj3at4sja2b3t@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1601CA0018.namprd16.prod.outlook.com
 (2603:10b6:300:da::28) To CO1PR11MB5076.namprd11.prod.outlook.com
 (2603:10b6:303:90::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f50efa-9da8-43bb-7bd0-08da0823bebb
X-MS-TrafficTypeDiagnostic: BN6PR11MB3891:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB38911BC27757D52F8A5C9075EE129@BN6PR11MB3891.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4CffdUYn4fgEOmtgrvHBU+0IkyTztgdRmJdDTfXCzv3wtGMhUAH9HaNV8lD9BySjToxN9cgEMYuoQht3rgzRfE+IaiSd4dk0PxUruPuVDmHHXQh2kF0aHsLtWC8m/m55p192cQI+/GyRA/DrLvigJFNvPRTKB4o4GuY4j2blmtf/PAMxuHhtEygUV+Q/nNErAG13UI5STudYRf9eWZrV6E8/yxi9S8sNNdln8sy0cT02DIynQyAyfWz9HJGNPnvSIke4+0qkvcgCMvPiy8I1odEkavyQE/aJ+rdFY4GkuLaT7Z84B7CmrhoHLSTXTl7o/so+6KaTf1CSlL93YQwHG5YRobQvnkgiH+sJUVxfMsil+1567JKFAVwb1FiT499RCVUvumXXmLMC9FCg0ISHgflPbROuvuCMsPeT14nxVXmhP6DMCq6t8RjRnIzyWT79MbioWKJy79OYWHc7/V2nXI2z4fLLmWrOmcfFigMLJkjAVJ4xfViiqdXca2xDku+rAh8vvoosfl9kPppJ7AA51xuv9meE1uIF/6Cq3NBlCtmLCTvWfEuDLYT0gpA+WR/mPlOxHQUOorLghLs9RGlKf0Rj/rHGjSJvRXPM+GpxkIqiMoQdNI0eEY0RK09JB5a5bIP6R0RiRvBJgLPeAhEWQSiGHBt+nzQhHL0yPKV6GetzzuKwNVyEmYC396EmTxBNmrEjV3Mlis/Wwv3xV/sruvAtZFX9rRrz1Rt10JiX8qGmdOSrLOoaL72eSHZhGy4OUggCggAErA5Tj0rBerlMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6916009)(2616005)(508600001)(36756003)(6512007)(52116002)(53546011)(31686004)(316002)(6486002)(26005)(83380400001)(186003)(66946007)(66476007)(86362001)(66556008)(38350700002)(8676002)(4326008)(31696002)(8936002)(38100700002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dRaWpOaTVnaFNrWFBlc3dxMEdrTjVTNjJJR3JtRmh6dm9BK0ErS0luaEcz?=
 =?utf-8?B?ckNXRVp0Z25MbTVKUzZadC8xUUdKWHRYN09WUWFHN3RNQVdaaGx4THdCRTZJ?=
 =?utf-8?B?SGVRNklnbkV6VUNxaE5JSmJJZVdDTEV1S0Z5MllpdGF0ZHBITkpNOUhzOGNP?=
 =?utf-8?B?TVpHKzMrZ01OSlVxakdZSTloMUlTRVRoNWM2dzBxY2dzS2NFNE1jYmNxK3pM?=
 =?utf-8?B?eU1OaHF3UHJ5UlF5OXZIZWgwL0gvTUhmVlBDS2pnZkIvL1haT0Y0bFJ5a04x?=
 =?utf-8?B?bm1HTzBPbUhOQmQxV2QyeWRuM3dXVTZQWlYwT3ZyQjhmdmd5RGtoaUJ4a2hP?=
 =?utf-8?B?ejI0eFV5Y0sveU0vSzJSYXdUN0NWRkFSOVdoYW9MdVpURy9sQytnUHBlQUt0?=
 =?utf-8?B?L3FrMUpsZnpqdkRrTS9iRWUwZ0JEdjVIS1RySlp3azY3Ny9OU3VqWVJXM1hM?=
 =?utf-8?B?ZHI5TW4xUlJBM21YZVBBWUU3dmVaQlBNOVV1akkzT1VuK3FkRllkTjVNTm1E?=
 =?utf-8?B?TXRQZG1BMFlXTmg1cE9HTS8rNmhUdm8yWWJwalFYS2k5RjF6RXA1L2NsZ2xP?=
 =?utf-8?B?RFBPOUtxdy9LYWJOU296TFkySXZmV1RQWi8wZFZUZlQ4U01mbFhGWnh6QnpR?=
 =?utf-8?B?VzZuVVNpUFFkUW0yd084Rm1KSUpVNEtGNkc4bHpkN1RQcllNV2xqVVVYUGhB?=
 =?utf-8?B?amtJMjdoV2ozS1RXWm9ZVVhDdVJDbFhZSnJXVjU2NVlsZ0YybUhaUWl2QWsz?=
 =?utf-8?B?VGZNV3lQTkdCMWlBa0dHdFRqbGUwWXpsUjB5RFdJTjduNzZJSldZbE1xcTNs?=
 =?utf-8?B?WjNlVGdDTlFOVk56VFpIaHJTL2hSRWl1Rml4bjY3SFA0VnJXb0ovYkVlZ2Zn?=
 =?utf-8?B?RzgyN3hsVXlUWHorZmY4anQ4ZFBaQTdodGJ5M3hoMXpQZFhrUHNpVkZpMkFI?=
 =?utf-8?B?YWlxWmJkZmlKdERtK1o3anlSWSt2eGR0dlFWWkFqaTU4MjFMZ3kvY0diUnJC?=
 =?utf-8?B?dDRESjBEZWVXY2ZOakhOM3VYbUJQMk9HL3czcTZXL2xPeUF1RDA1dWhFMUxh?=
 =?utf-8?B?MElCK2Jadjl0NnVacE90RCtmRDl2WlBiSnZVUFd2TitaelZJZG1nSnREOGFP?=
 =?utf-8?B?SW9WTUhEMHlId3gzVUU0VTNiTHNRb1phZlpJMzd5WGc1RjdaTGZCbzVRbWty?=
 =?utf-8?B?dURJY1V3NElLS3ViSm1KdjRHOGRTMkVBVkU4M0ladUNnRFBDNTBGV3RDWlIx?=
 =?utf-8?B?OVZ0VXc2a21HMzZ3M2pQRUNmQ0NrckptNDNFd0pBcDRXb1ZVbTNqejloOWVO?=
 =?utf-8?B?RlhLYWIwaFJlSFBJcGp0OFVoWTZVK0RHeXZKWTM5eFYvVVhtdzZWdzVBc1M4?=
 =?utf-8?B?a0U3R1dNTFJaaS9aMVdWdFMzY2ZrZ1IwWTlUS0FNRGVPNDhjbXV2RVZUckRS?=
 =?utf-8?B?U2RMeVFmZ1VrK2tSUlhxdFlhQVJmVW1TcHN2VERueStTZ29oeWEzSTdXQnZm?=
 =?utf-8?B?U21XdEsvWE1UVEVpaHphRzJHT0I2VlNWWXBRS3djZ244NUdtQ2puR3pqbW8z?=
 =?utf-8?B?Nm9iUHVrZlpSY0pVNDJidnVJSkJuUEV1TytybHB5c0JhZTI1aUluUElSWlow?=
 =?utf-8?B?ZkNiK1g3WVpRMFJVZmtTeFBqTVJERWZydTNFS3liSTdZTXladlNzUHJ5ajhk?=
 =?utf-8?B?VXd6dFNZaTJBSDREajBIK2FHb21rMWdpR0llSGpWZER3VFVFVlhSWW9HeUd4?=
 =?utf-8?B?eC9OWFQ0aCtidStQL2NJMVlrWUJyVGorTVZoMnRBTmNhVnpGNDdaM3lGQ2l6?=
 =?utf-8?B?K1VTL2pidHF3ZTRSMS8yZTIvU1JjY3pkL2o1MHpVT1RUS0JucnZhRTB1MGtZ?=
 =?utf-8?B?b1NoRGhOdTUxb0lEelEzQzVtUUlIdHpoSUdQU29WSS9RU3NyY3BwS2pIb3cy?=
 =?utf-8?B?bmFOcGgwZFZHcnJ4ekxGRGRubGw2dy9zVlJOUmlxcEVTVkJCMWczS2NlZXUv?=
 =?utf-8?B?dHJveVpNZ0xBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f50efa-9da8-43bb-7bd0-08da0823bebb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 14:38:04.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZOh1P5nEs+k5x7W+knMBEg+aSQBhQkepQoD8KTK57HLfMDhlqwow5qbymMTJjq9ScN+pyoGKDY545kzLn0h1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3891
X-Proofpoint-GUID: 8rsFGJwD7XRou90ZpmYn1GB-V4hqvXCj
X-Proofpoint-ORIG-GUID: 8rsFGJwD7XRou90ZpmYn1GB-V4hqvXCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_05,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170085
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 3/9/22 10:25, Lucas De Marchi wrote:
> Hi Saul,
> 
> On Wed, Mar 09, 2022 at 10:09:58AM -0800, Saul Wold wrote:
>>
>> Hi Lucas,
>>
>> I work on the Yocto Project and we recently started to add kernel 
>> module .debug info in <modpath>/.debug/<module>.ko.  When depmod is 
>> run, we are seeing that it might pick up the debug module instead of 
>> the correct module.
>>
>> This will cause an "Unknown symbol" failure when it picks the .debug 
>> .ko file.
>>
>> I am wondering if the correct solution is for depmod and kmod related 
>> tools to ignore the .debug directory instead of traversing down and 
>> processing those modules? I think the code in 
>> depmod_modules_search_file() should maybe ignore the .debug directory.
>>
>> I looked at depmod and see that it compares priority and seems to 
>> randomly choose between the 2 if priority is equal as sometimes the 
>> non-debug .ko is selected.
>
>> Thoughts?  Concerns with a change to ignore the .debug directory in 
>> depmod?
> 
> I think this is very specific to the way you're adding debug
> information. I'm a bit worried about ignoring a few special directories
> inside the modules directory. Maybe all you need is to ship the debug
> info to side directory and configure depmod.d to search there (if that
> is what you want)?
> 
Adding the .debug directory is a well documented part of binutils / gdb 
and the Yocto Project / Openembedded environments use the .debug 
subdirectory to store the split debug_info. The splitting is done to 
help reduce the size when creating an embedded target system. But we 
need those files when working on debugging the target system, so they 
are optionally installable.

> See man depmod.d. This would probably what you'd need for a side
> "debug/" directory, where you give preference to the debug one:
> 
>      search debug built-in
>
This is kind of opposite of what I think is needed.  I don't want to 
search the split .debug/<mod>.ko files as they are just needed for 
debugging. The debug_info related <mod>.ko will typically fail to load 
due to missing symbol info.

> Would that work for you?
> 
Honestly, not really as the Yocto Project / OpenEmbedded uses the .debug 
directory to deliver the split debug_info in the standard way as defined 
by binutils/gdb and other tools.

I think an ignore vs search directive might be better.

Hope this helps to clarify the reasoning.

Sau!

> Please consider Cc'ing linux-modules@vger.kernel.org to get additional
> feeback from other distros/people.
> 
> Lucas De Marchi
> 
>>
>> Thanks for your time.
>> -- 
>> Sau!

-- 
Sau!
