Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D476C77B7A
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 07:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjESHBA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 03:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESHA7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 03:00:59 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2070.outbound.protection.outlook.com [40.107.12.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43810C6
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 00:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY0zh0vF/A2yAqstviDEtzX+3ed12K6L4Rc+XU+6hc4zuxmpjf91CTCDtsV+wQVd+PTKUhhMGQellnaUouwkZ3kqFfFU/G+H76sImYn0BaoIidDtosi9t72UVSsfSoI3h/f5P3sfhmeMDf26xpos6vjZ5iK0mdVtuEds+HSm4IzlrC77IDopnJgk8xVFgTcs9uXrw3K5kUS5OlgjST5Src6eZSpPudoOMlck7/nFspLicxyAAw+UJmhfk2bOEQiG4mz84ZosA5tRSdYsil12U+sKPKDwk1EH10bqC3wWYHcYEFNmzhQ4o9OS0sr3q5zz7mKrvST8NxZejpnKmK35GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtMffiLFqgQDWD88aFUinxlpWGKMIUvYoheGXsGOt7M=;
 b=OPp2Qzv3BIGHyY3YXvI3KY2YmUdF6/pigZ25a90LcgEiH9aPTrwlmUacpaaun+hdS8O5jWRC/6AzGIYO+3q4bDHx9HXEjstpuRDQvJok629TMtNlw+K/LY9FgucluFZZQ4Symx8bnaN6Nm+YlWHlxXPTeINJOTrpovrjVDShJSCsTJ5xk5rJ5jB0BJFKnyKxZSphJjMbPEgdXelatc1LGUn6tR1D7aISp4lC8FsVNpJqh5+2RjpGuvlH2FGry4zkUXqLvzwighBaOSXpj8kGMjAOpjsIvRSXjAPqBbfPD9u6fabv3s8mBblge3BJXDEerWYRyUsXVfgD0XX7suOXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtMffiLFqgQDWD88aFUinxlpWGKMIUvYoheGXsGOt7M=;
 b=tIrL3cgUEkpQtI0nWxmuVLHLXy4vDIljxw6n0oKq0XZdYAgr0bS5373T9Lk3kc1QWG0WfqtdUHt//qPaDJ6zO2dEXBkDwzRIb8OoCL+KHOGeWyNnFBQmA8wVJq1G7120GXKQa3YttcxcO7qpFXqeOoy4rnaro8hWceeWs3sJeyq36PFA3wtYPC5Pakl06QPa8ZhbpgEGihNqe8/ALA9KmHhBSoms/4UakLCexyVcRUZ46T8M4rUXRGvW16U11nxTDK6FE7JHNXUYuElEJJ1xp+P62zFR7PTZUYoeDJJ3QRgkTd0wmdxKa3buT7EFRz2QA+3tYGAKjd+JY/HClpKLzw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:00:54 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 07:00:54 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] libkmod: fix possible out-of-bounds memory access
Thread-Topic: [PATCH] libkmod: fix possible out-of-bounds memory access
Thread-Index: AQHZiXfxXXIYSYlHt0iXaDgJYg4VgK9hLF2A
Date:   Fri, 19 May 2023 07:00:54 +0000
Message-ID: <f95eccca-3eac-5213-6a33-c9ebf1121a7d@csgroup.eu>
References: <20230518110000.62061-1-dmantipov@yandex.ru>
In-Reply-To: <20230518110000.62061-1-dmantipov@yandex.ru>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3162:EE_
x-ms-office365-filtering-correlation-id: 54260b2a-f4ba-4821-10b2-08db5836ca00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JmT3laZ2hCuXEopxgHsXCls0K0GQrHQ+xhtODvMZ+zc48xI/LHtXcky4rwP5feS6P6UDByFvQ7YoFTePBK/oaNXZiy05HQskPdmcRerNR8KHdlf6GMaH+o1qrVGwkK1PkKzcn4o2Xeg6uvLrDtmU7PlFz4yyErq1ea5vzpoYdtBT4IZ+a9ONZpqix69d861kPSuHBYVlc+l63B1ndgcUbChjc2DOTftrq/vHBtdAkoSPGw5BEQ4EEDCR31qGLkRHBnDdGc9pjeCCSsOosirSfWBRB0zC5CpBij9jJ0KYa6eU6oCgVl0Qpg5dYYisIW+SDfseGGX4Er9NuJk+OI8pujKgS0KZlZw5QehqhMJhUVyuJG8uB5x+Oh5U1JvbTvy+GZ2yA9J6RUkfMm24x4IM+sMMqbsJM57z1Or4vkzCvHfe7YbHTFj3YTA3GrjeVPZgp/LvPAMJyQJJS9QwSgAEo1dYzK6j2vdobrMIJHTWVq9MjqVJxvPb3Y154wv9ETtA5BPTMJMBzIYVxcsDreEH4gmHP9TKJFtS0+YBtqq32jxCAaSRXOzAds3hXPsjy4oURRLtFKPV+YNuYFkZrMjZrMKKWDrmlmKBIOQ/u04luQx23qdpscuOHnYBMPEMKxxPRib8B/8+qqKdzuUNUXUOtXzqu593fOlkPmXONbZlP2/2IgjGtddFNDO+pZA1sZo41IQ5ZWG990VzZlS7UofkbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199021)(91956017)(71200400001)(76116006)(31696002)(86362001)(64756008)(2906002)(6506007)(6512007)(38070700005)(66946007)(186003)(66446008)(66556008)(66476007)(478600001)(110136005)(36756003)(6486002)(966005)(122000001)(38100700002)(66574015)(2616005)(41300700001)(31686004)(44832011)(5660300002)(83380400001)(8676002)(8936002)(316002)(23180200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1EzSURJd0ViMjZPTnpSV1hvVG9QcXMxQ0g5L2hHYjlsQzlEMURtK05kdlFu?=
 =?utf-8?B?ZXhKS1FFNVordFhvazFIdHNMcElaRnRQdDYweUFFUERLTjVkWGtMYy83Qjlv?=
 =?utf-8?B?QWRGaVJ5NEJXMkVKV1dzTjlMMGFjQTVvYTBoK2lLV0F4YjdGZ1J1dXpBdjdm?=
 =?utf-8?B?ZHRjbUEzVm1TOGovem44OXZRNy9sNDlqRDM2TXZ4dm4rVExtcjNudUlmL2Vs?=
 =?utf-8?B?L0xXMU5FZUtycTB4R3dzOUlZK1gyaGdDOHp6MDdYN01ZcExGUlpVSW5ENytY?=
 =?utf-8?B?KytpVTBwRFRDSUdxaTZZQkhOWXlLL3AwT0lXRHhaM0ZXQUhVWUNNTDRHSHhm?=
 =?utf-8?B?a0VTMDN6TkdPNU5FN3lBVEpxSTRVNWpsd012VWxXNEp5dHhLMlFyUU1xZWxj?=
 =?utf-8?B?RTZXM3kwTytzSHk2dnFDQ3dEZnJXTUp2TnFRbG1YRGVIT2hHK3k5WjQySkVT?=
 =?utf-8?B?UVZqaC9DMXJUM0RseUUxSjVJNTZLY2lCU2JPZVVaVWZyWTlJQjQ1TGw4bjkv?=
 =?utf-8?B?RTQ4SnJZeExrc1JhTUs0c2ZpVG1CcmtoMWk4VWtkbzF4QSt1ZDFRYTU4eWNY?=
 =?utf-8?B?RXYvYWlBWjZMQWZzeitWSWN6NnVEYWZ5aU41RFNZc2JCRFE5bzZxdzhJMzc2?=
 =?utf-8?B?bHJqbWVBUzc4V1ZkV1NxWXRJQUlObGE2SlQvSDlpQkIzbjl5eVh5dVN0RThM?=
 =?utf-8?B?bUtiaE43eERVZnM4K1QwUVFDRm1RUXdRN016NHFOYkp5YytLZkNDcnA3NE9t?=
 =?utf-8?B?WWtoTHJpeDFuRGZpTzh1ZHJROFhnT3dhK1dDL09KbmhwYlVWVVlCNXdqQmZy?=
 =?utf-8?B?OWo3UE5oWnVOcUFwd1hiMHBUQzdoSndMbFkxWDF6RUNCYmRxaThFN3FXQ2Rq?=
 =?utf-8?B?YUN0MUZRbnFZMFRLRzltb2tiR0l2RUFHK0FjVVZockRJNlFWV3RidFkrVVB6?=
 =?utf-8?B?ei9TU3Q4ajlFazZ5RzJDN3Z1THd4TWRLOUpVWmRpaVFuN2NRbHFHTi84cnhD?=
 =?utf-8?B?cHhucXdqblk5eUpaUVIzR1A4T3k2VWhqMEhvYjJkTHVBK1JIUFp4eXpKamho?=
 =?utf-8?B?YnVGcVFKN0FlL1J3RjlaQStLYUZVTUhiRnVGN3BWeEJGTGRKNWYyMVVOZHRR?=
 =?utf-8?B?NnJsNVB6a1RtU1JPM3NPaUdBRStSR2h2TXNPR1NXcDJvdUptVzlPNUFJL2NU?=
 =?utf-8?B?R0Y3SmU2cEFHVFpFc01XYXVPYXhDUVRUZkJVY2lSVDR5S1FycmVNdnpnYzZq?=
 =?utf-8?B?aVZhMklZRStIUWVZQ2w0SkRsdVh4YzVveVpZNUMyMmY5U0hEd0F2YUwvS0dS?=
 =?utf-8?B?aEFxWHdUL0lxMHJaZXJnRXNOSnNhR2lNRGsyKzZaWEV6Y0tTRUdSanBxS0FJ?=
 =?utf-8?B?Y3ZYMnFxV1hUL3dnZ2JsaVhXekNsVG1RTDdNOWpLeVBCZGRPcW56bmNVY2xW?=
 =?utf-8?B?S1ZIaWg2SzBxZVFLWSt0MWQ5UVJEYUZtdTJDQTNlS3pRb1dySjdncGtoZHBa?=
 =?utf-8?B?V2FlUmk2aWtWMXUxRHoydkpiTUNzZWhmSTYza3ZMbEllZXpNTjdGOFFCQVNZ?=
 =?utf-8?B?K3pYbmxEWnoyZVNsUUhhcDR3aG43RTByREpGQ0ZUZkRVekptNDN4bldVUEQ5?=
 =?utf-8?B?ei93c0daVDVkNGFwVU9Ta1BFUzg3MWJCRkUrRE9nd0xkSnNjM2FoMEVLcHJO?=
 =?utf-8?B?ekFlMWVXZ3NlKzdNcUNKeDBzdW5waktRR1ozUU10ZmZ1Q2hXWjhRVXkrbmdK?=
 =?utf-8?B?dG5icUhEeE1FNzMvaFE5eGIzQmlMeUR0YUJRaEVVS2swditkQmY0U1pYVGF4?=
 =?utf-8?B?SDJ5NGl3UW5qTkc4OXVSNlNvblpoeFhUWGs1eitrKzVibVgyNitMVDVNaXFS?=
 =?utf-8?B?cnlDOGh4Qmc2WkV0OU1xSGsyRnh1WDVQQlYrYXpuSHlhUzBSQUpHVGhxcjNx?=
 =?utf-8?B?RGtyanB3M2s1eU5NdENvNnZOVzVDVjFIb1JTU3VVYjc3OVBJVTVOZGZKcXhr?=
 =?utf-8?B?Z0R2aGlQdU9tbFUybEIyZkJVejJURlliaEFPZmVIMEpydjhCa1UyOVUwekJT?=
 =?utf-8?B?SXJVUVBwZ0Uyc3JBWXlGRmZCcUsyQTlBa2J0UkZzRFlnZGlPeXpZcVdlTSt3?=
 =?utf-8?B?VlZRTVo5c294SlBYL05PUmQxZWl3eHdVS0ZqNStkT0RVQ0d6SjljRmRjaFFT?=
 =?utf-8?Q?Dmiqf/Vf6uKkRpAX35qXsEQfdxfELT5Ec4N3FG9WvlXx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5BAB440505B874D96FAB9F701C77C09@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54260b2a-f4ba-4821-10b2-08db5836ca00
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 07:00:54.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yejkJC0AVN0OxIeMmokjLb5KsgIMxeqH4sk6XeWEOxDmFKXMgOnpFsOw5i5AWTEPppkZwUInYHUhS/hYYSWd1gMLq9VWhGGAZ0lj6/1D75s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3162
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

DQoNCkxlIDE4LzA1LzIwMjMgw6AgMTM6MDAsIERtaXRyeSBBbnRpcG92IGEgw6ljcml0wqA6DQo+
IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGRtYW50aXBvdkB5
YW5kZXgucnUuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgIGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBBbiBhdHRl
bXB0IHRvIHBhc3MgdG9vIGxvbmcgbW9kdWxlIG5hbWUgdG8sIHNheSwgcm1tb2QsIG1heQ0KPiBj
YXVzZSBhbiBvdXQtb2YtYm91bmRzIG1lbW9yeSBhY2Nlc3MgKGFzIHJlcG90ZWQgYnkgVUJTYW4p
Og0KPiANCj4gJCBybW1vZCAkKGZvciBpIGluICQoc2VxIDAgNDIwMCk7IGRvIGVjaG8gLW5lIHg7
IGRvbmUpDQo+IGxpYmttb2QvbGlia21vZC1tb2R1bGUuYzoxODI4Ojg6IHJ1bnRpbWUgZXJyb3I6
IGluZGV4IDQxMDcgb3V0IG9mIGJvdW5kcyBmb3IgdHlwZSAnY2hhciBbNDA5Nl0nDQo+IA0KPiBU
aGlzIGlzIGJlY2F1c2UgJ3NucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgLi4uKScgbWF5IHJl
dHVybiB0aGUNCj4gdmFsdWUgd2hpY2ggZXhjZWVkcyAnc2l6ZW9mKHBhdGgpJyAod2hpY2ggaGFw
cGVucyB3aGVuIGFuIG91dHB1dA0KPiBnZXRzIHRydW5jYXRlZCkuIFRvIHBsYXkgaXQgc2FmZSwg
c3VjaCBhIHN1c3BpY2lvdXMgb3V0cHV0IGlzDQo+IGJldHRlciB0byBiZSByZWplY3RlZCBleHBs
aWNpdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5
YW5kZXgucnU+DQo+IC0tLQ0KPiAgIGxpYmttb2QvbGlia21vZC1tb2R1bGUuYyB8IDQgKysrKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9s
aWJrbW9kL2xpYmttb2QtbW9kdWxlLmMgYi9saWJrbW9kL2xpYmttb2QtbW9kdWxlLmMNCj4gaW5k
ZXggMWRhNjRiMy4uMDc0MDAxZSAxMDA2NDQNCj4gLS0tIGEvbGlia21vZC9saWJrbW9kLW1vZHVs
ZS5jDQo+ICsrKyBiL2xpYmttb2QvbGlia21vZC1tb2R1bGUuYw0KPiBAQCAtMTgxMCw2ICsxODEw
LDEwIEBAIEtNT0RfRVhQT1JUIGludCBrbW9kX21vZHVsZV9nZXRfaW5pdHN0YXRlKGNvbnN0IHN0
cnVjdCBrbW9kX21vZHVsZSAqbW9kKQ0KPiANCj4gICAgICAgICAgcGF0aGxlbiA9IHNucHJpbnRm
KHBhdGgsIHNpemVvZihwYXRoKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ii9zeXMvbW9kdWxlLyVzL2luaXRzdGF0ZSIsIG1vZC0+bmFtZSk7DQo+ICsgICAgICAgaWYgKHBh
dGhsZW4gPj0gKGludClzaXplb2YocGF0aCkpIHsNCj4gKyAgICAgICAgICAgICAgIC8qIFRvbyBs
b25nIHBhdGggd2FzIHRydW5jYXRlZCAqLw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQoNCldoeSBub3QgRU5BTUVUT09MT05HID8NCg0KDQo+ICsgICAgICAgfQ0KPiAgICAgICAg
ICBmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFl8T19DTE9FWEVDKTsNCj4gICAgICAgICAgaWYgKGZk
IDwgMCkgew0KPiAgICAgICAgICAgICAgICAgIGVyciA9IC1lcnJubzsNCj4gLS0NCj4gMi40MC4x
DQo+IA0K
