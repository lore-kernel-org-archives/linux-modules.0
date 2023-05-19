Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810FC7EE2C
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 06:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjESGw4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjESGw4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 02:52:56 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2055.outbound.protection.outlook.com [40.107.12.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CA1E5C
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 23:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0y7euNXEZ8pGwnoREgKB4LjxCSeD0w159XCv3NrIbV6H8TyGcO7nG8CJQj3r81VgWtiwvmr6FgOyAYaVifd7GMAPALFoebY1RKPfzqptEJ6Vydf/2mq69p1RJWF1hj39w3ibt/PqtwWDWfukpeSTn8s10TDcMm3Vb+vAW0IgOMmCS8YxS4KgsM0lOgDuY8pPy2IY7ZTt1s0yVHpo3Dxsa0ZfkGg49+qw0ABgvLZ60c8xsLiksl1HnooiuZl4P78LpLL+8Gu1G/uImcqaHNATQp+Gy5WSBnnK9h6bl/FlmBlg8NEahOMoitlyiydXmNe5KMybqShSTZjhYNXF5Pjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOF9nNumtvdPq7UNhO8P71dG3j8Evzp0LMMfRjy9xT4=;
 b=e7msrSMHCaTJKgz6KcmNhi05W0l0QhXfCeyhIW8sRI96S6yLcz9EqgiMYCsDWV7SPTUTJDm966PnYAjwJuZHq2bfG7QbPJEaa6GrNtYk1r+kAPVMwu4sBApfsiL5GeQzpyzAcnwLpCBUKljB+1QVfoW4BjzxEKKrGSFS+5cMhBwQZK1QHE2dEByIXjWJyPa+LhIrnKR7CUj0UWUkydHmfLbkIDRWH3x3G0fnxxZEXg/kZPyoiwqsEqL1G3v45tPut7Q4XZOXc7Sey/EbZ00dSG3R1J4ebZgaVRK512s7MrV94+Ga82Tg5rBV+mYV1LnKA00N5sRbt06jG0QHnJyg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOF9nNumtvdPq7UNhO8P71dG3j8Evzp0LMMfRjy9xT4=;
 b=bACNW768eO8buks1N83SVvT11O6xQDkoC6sLKfP76+u0K2i1HtIzvXMoLuwUSJcauMWnNLB+aZu6G7dn53lPLEwMQ48BZ0iu2ECp6MhXEXS50CzDsXs9nRvOg9Y9rXMu5aoz/1GVtS4KhlTWZOeYr0bSbr6Cke2MCbJem31IStUBpGiR+ih/XQ3Lqtu8oQcJGkkiq6xAYLkF5tRLtJ5BGiuu0UtGrO1rkxJx5qYQ+xvBclK3LAu6ucJCzU24KDqHHyhqas2dokeidrKJPky2ta4XOxtNx8ae73Dw8PWydCXpDrsig7EmxZym7oV6qZbSmzQ1VIZyJ2LjJ9jM4/ssDw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2370.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:52:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:52:51 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section
 found
Thread-Topic: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section
 found
Thread-Index: AQHZiU0FFJ0hV2DsBEe7l1fjNeaOOK9hKnMA
Date:   Fri, 19 May 2023 06:52:51 +0000
Message-ID: <3422a991-55ff-785b-f659-29bf65823a61@csgroup.eu>
References: <20230518054730.11237-1-dmantipov@yandex.ru>
In-Reply-To: <20230518054730.11237-1-dmantipov@yandex.ru>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2370:EE_
x-ms-office365-filtering-correlation-id: 8af7dd25-1634-4638-a268-08db5835aa32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LBUFoIM1Wge9Jkec6VEW96sEBckHGSMsEGST5+xb34tGFhJf4x9ORM1KcAXKvR2nTgg8X3QmaT8BACS7/WZG4b8u9nLFTOkKlrWmSrvK0WdzAJt4hB0DuNod69qFy5YrOzcdNdnj7uH61bivQ+xrfe3dO1E2Nlx1wI+YB8TVLVoP0UKkSMFaZH2l33Sk8SoHI5rEL/tgny0F7GScrqU6qjAwpbPtJUoXthcLO7S7hTw1L0JZRzSyVV/o/3DY5nGhxaQqmlDszZR8stICWLDnUDsUp1aiMoTXNfGwLoW/obnfDFRjGZE15Ng/oUj2lfAQxHpsn7+/MYo+hOvYYpM2stgPuayQfVPTCqoSDotyawKZgFXtRLMkVaqjEzsh2qwtrUyZ1Nfe/o+aZ5y7a+GJxmnj6T8RMwH0bocX/N9g1b4W3F4heckDeVMt+NFNayOHL1f7rWLpENoxQ8o7vU0w5B1j3xje+TzDuDn8nua5wA2ODuZYlxTWoHii2CKdLC/3uwdpIyJ5zHHynijlf8MmRZnX9IliTDQOdCFzlizm3kGUboAzyhqg2jK/zh0Srr0vaniUfx7+5nfM4BzEygrOq6yDd3i7DKylEkpUpls4/ICGM0R8y0+AbH46HNTNYEGaGIDKAtvZYYdzMU4TVmJGkLIKk5UGCTNbMwAymUioTQQajQmNbsd94vWEY0g2jdv0Wj9o0cfG6333JwXJkuwCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(451199021)(86362001)(31696002)(38070700005)(36756003)(478600001)(91956017)(110136005)(316002)(966005)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(71200400001)(6486002)(8936002)(8676002)(5660300002)(2906002)(44832011)(38100700002)(122000001)(41300700001)(2616005)(186003)(6506007)(6512007)(83380400001)(66574015)(31686004)(23180200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFlScmowWjNmSjFkTjZQS3ZsYnVZb3lreU4zN3NQTkdQRUdFbXhzUnZUcXdT?=
 =?utf-8?B?TEFvUlE5bkQya3BUVVhSaWt3clNVK0RzRUh6SDBpUERsTXZ4OXpMb1hhUVNU?=
 =?utf-8?B?dm1haW5JRUROUE1pbnZwSjBIZTk5MlFnR3FJeEZIdmlMVXk0L2JDRVRsTkRr?=
 =?utf-8?B?cjJpUDVvMTZxdjlZc04wY2Vma2h5dUgzMWw4VzZmVDhnUTc5L2d5Um1rdm1Y?=
 =?utf-8?B?eEZNMDZSTGdLcWNiWFc2dlFoKy9pSVRwRzhBTVpCTjMvUGd1U3YvbkdlK1pJ?=
 =?utf-8?B?Y1lyM3VnYWJOZVZMTDBRQnovZGxoTElKanVMOTRHSzUzUFJjemFPQ0lVeTFj?=
 =?utf-8?B?Q2NSdWcxRFovcG5ndHh3dDl3cExwcVM3R0ZHMlF0S3JESUFPV3pXTENtNWt4?=
 =?utf-8?B?eitqZUgvUk8rWUJ1Mk42bk1JenlGZUIvL0k3SitFbWVERE9UcURUS1BhV2tI?=
 =?utf-8?B?UC9iWS9oMVBMNVQ5bngrNlNONnRXTUVpT0JPZGlSWjFqOCszejN4Wis5YjhL?=
 =?utf-8?B?Q3JwTTc0akl1QktsU3BYcDhvN3dyMXF3d2N2aHlDZDd0djFhQ0ZnV1VMYUdD?=
 =?utf-8?B?dTFuOHVkdHJwVnBFQi9RWU1GTm4xZmp4dGhCcGhtWituK3lmVUJVd2d4QXNj?=
 =?utf-8?B?MHhCTS9RUWZwTmQxSEpwajFIN3U0YVpoTVRuc3lXdTQ1MUo5WHRXWHA1T3Ax?=
 =?utf-8?B?UGpnTVh5NDZsUEh6bnp2MVJ5OUE2cGhaYVlCekFxeC9ZVnFsWDNubTg3QmJa?=
 =?utf-8?B?dnVRanExL1VjYWU5cWZPQ01BM2dQTm1wMm5PNzNOc1dOeEpIU2RId0FaSyt2?=
 =?utf-8?B?em1LL3Jid3BxVk1lTG55QUJST1Bzc1VtQThnYXRUOW95UGNGTnZlUitqeFpO?=
 =?utf-8?B?K1k3cjl6ZTYyaGJxZ21GN3ZFQmZUYjY0Z2RaLzhNVDJYcXUwT0pmL24zUmFK?=
 =?utf-8?B?KzNmQ1l2aUZtT1M4ZXI4RkR0K2x3WjgvN21nT0NlTE5hamZ4dVowZ3ZHeUxJ?=
 =?utf-8?B?ZmJheHNpOUdYNGFqZjIzSFhkR1UvcGxXdit3c0o5ckk0UkFkOUZrY1hvNjFq?=
 =?utf-8?B?NzJsYUNpK1hncnhxUXhhRms1WWYwR0grWk5kV3pjVjR0K1Nka1ROV0N1S3dD?=
 =?utf-8?B?d1FDRVBVRlRsT3NSZnMvQVNKUWMrSzczTENjZm9qYTNwT3ExMjdYS1hFRk1E?=
 =?utf-8?B?dWE4Wi9xU3I5MTZpTVJHSC9GSHZVZG1pQnFDM29qQkNTbVhWNmxHZWNrczEz?=
 =?utf-8?B?QXpYU3ZLWnZSQVkwMXNEVmdmeUxlK3d1U3huL2J1eCsrUDVSMHR1T3EwMkMy?=
 =?utf-8?B?dkNwaDduaVk0RVRrcDFIZWo3Tlo0NVB3akU2UG85VzY5cjNLNDlLUkRUM25s?=
 =?utf-8?B?K2gwcGs2LzNkRTIrV1pNU3oyZ1JlZ1ViMUhpaHVmdnVzMllBNGt5WUdURVpW?=
 =?utf-8?B?UXdRNyt6VHR4aWVWMmdwUjV3ajVHcFJFR3hQK3ZzWUhQOUVNUTRHYjdqRHZJ?=
 =?utf-8?B?azR4RGJPcEx3ZFcrZHFUazQrLzNLWTZGQmh4NjhvYk1hY1EyV3Btc0ppeGh5?=
 =?utf-8?B?SDRDZFVJdUlnVzllQ29kQnh3WUxTa1RrUTNTbEhSWjhTTytRaW9uaDRSUDI1?=
 =?utf-8?B?UkJnbENpbjBMN3FSbThuTndzeGU0ZysxUlF5OS8ycS9SWWxvMHNHWmc2Mzcw?=
 =?utf-8?B?eEhwcjRQdTJzYUtURkRidkYvSXFlZFpIbUhPdU51UXB3c3lIMjZWR0thZXVv?=
 =?utf-8?B?eG5DL2RZbGdlYk9vWlYrQnl4aTJDdXdqaWxSVTNUTENKaGl1LytJcEhBMGNL?=
 =?utf-8?B?M3NEZTlkdU1yeTFZOXgwWEhhekk2bFQ2RXc2QXFvRHNqNk1LYmxYRU9ld0lH?=
 =?utf-8?B?b1haSk5CS0Y5ckI1azB5REZJc2U3ZU5qMUFYTTRPWUt5dmxVWFhVVERWREpN?=
 =?utf-8?B?VGxhSCtVWkMybzQ2YXp6Y0dWYmtESElqcWM1b25JdDZtMU9OMHNnbmxWME8z?=
 =?utf-8?B?ZENia0JpVEZVMlBUM1lWZFh4V21rWmM0N0s4QTNVRlkwcWIyajZUcGxFTEFp?=
 =?utf-8?B?SDVLSmtsV2pPMkhIWFlpTS9rTTlRVlRBeXRMZC9uQWtId2tualliSGY2a2dG?=
 =?utf-8?B?VlRTOFVoaE5lY1hvcnkwSncycFNRUXlEUzlNL2diRWwxVmxIVUR3RHNuUzFV?=
 =?utf-8?Q?ET/GA7t7SLGoGHbQ4C6XYPvbOxl00Fyil8EfatuYh1rJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C7A52E62615EC49B91AECFF002215D2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7dd25-1634-4638-a268-08db5835aa32
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:52:51.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94FlLf9Msty4xxeDEXIKZHySYKKLMP+dgodG3kl+mTdC7gInxcZZYNukY80oLf4djCl6UMrFBNOiXIxMMc1wB6LVezBWrjZ6fj1Mf4crwB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2370
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

DQoNCkxlIDE4LzA1LzIwMjMgw6AgMDc6NDcsIERtaXRyeSBBbnRpcG92IGEgw6ljcml0wqA6DQo+
IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGRtYW50aXBvdkB5
YW5kZXgucnUuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgIGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBXaGVuIHRo
ZSBtb2R1bGUgaXMgZGVmaW5pdGVseSBwcmVzZW50IGJ1dCBDT05GSUdfTU9EVkVSU0lPTlMgaXMN
Cj4gZGlzYWJsZWQsIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZSBtYXkgYmUgc29tZXdoYXQg
Y29uZnVzaW5nOg0KPiANCj4gbW9kcHJvYmUgLS1kdW1wLW1vZHZlcnNpb25zIC9wYXRoL3RvL21v
ZHVsZS5rby54eg0KPiBtb2Rwcm9iZTogRkFUQUw6IGNvdWxkIG5vdCBnZXQgbW9kdmVyc2lvbnMg
b2YgL3BhdGgvdG8vbW9kdWxlL2tvLnh6OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+IA0K
PiBDaG9vc2luZyBhbW9uZyB0aGUgY29udmVuaWVudCBlcnJubyB2YWx1ZXMsIEkgd291bGQgc3Vn
Z2VzdCB0byB1c2UgRU5PREFUQQ0KPiB3aGVuIHRoZSBtb2R1bGUgbGFja3MgYSBwYXJ0aWN1bGFy
IEVMRiBzZWN0aW9uIChhbmQgdmVybWFnaWMgYXMgd2VsbCkuDQoNCkZpbmUsIGJ1dCBjYW4geW91
IHNob3cgdGhlIHRleHQgbWVzc2FnZSBtb2Rwcm9iZSBwcm92aWRlcyB3aXRoIHlvdXIgDQpjaGFu
Z2UsIHNvIHRoYXQgd2UgY2FuIHNlZSBpZiB0aGUgY2hhbmdlIHByb3ZpZGVzIGEgc29tZXdoYXQg
YmV0dGVyIGxlc3MgDQpjb25mdXNpbmcgbWVzc2FnZSA/DQoNCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+DQo+IC0tLQ0KPiAgIGxpYmtt
b2QvbGlia21vZC1lbGYuYyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWJrbW9kL2xpYmtt
b2QtZWxmLmMgYi9saWJrbW9kL2xpYmttb2QtZWxmLmMNCj4gaW5kZXggZWY0YThhMy4uZmIyZTNk
OSAxMDA2NDQNCj4gLS0tIGEvbGlia21vZC9saWJrbW9kLWVsZi5jDQo+ICsrKyBiL2xpYmttb2Qv
bGlia21vZC1lbGYuYw0KPiBAQCAtMzkyLDcgKzM5Miw3IEBAIHN0YXRpYyBpbnQgZWxmX2ZpbmRf
c2VjdGlvbihjb25zdCBzdHJ1Y3Qga21vZF9lbGYgKmVsZiwgY29uc3QgY2hhciAqc2VjdGlvbikN
Cj4gICAgICAgICAgICAgICAgICByZXR1cm4gaTsNCj4gICAgICAgICAgfQ0KPiANCj4gLSAgICAg
ICByZXR1cm4gLUVOT0VOVDsNCj4gKyAgICAgICByZXR1cm4gLUVOT0RBVEE7DQo+ICAgfQ0KPiAN
Cj4gICBpbnQga21vZF9lbGZfZ2V0X3NlY3Rpb24oY29uc3Qgc3RydWN0IGttb2RfZWxmICplbGYs
IGNvbnN0IGNoYXIgKnNlY3Rpb24sIGNvbnN0IHZvaWQgKipidWYsIHVpbnQ2NF90ICpidWZfc2l6
ZSkNCj4gQEAgLTQyMiw3ICs0MjIsNyBAQCBpbnQga21vZF9lbGZfZ2V0X3NlY3Rpb24oY29uc3Qg
c3RydWN0IGttb2RfZWxmICplbGYsIGNvbnN0IGNoYXIgKnNlY3Rpb24sIGNvbnN0DQo+ICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgcmV0dXJu
IC1FTk9FTlQ7DQo+ICsgICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KPiAgIH0NCj4gDQo+ICAgLyog
YXJyYXkgd2lsbCBiZSBhbGxvY2F0ZWQgd2l0aCBzdHJpbmdzIGluIGEgc2luZ2xlIG1hbGxvYywg
anVzdCBmcmVlICphcnJheSAqLw0KPiBAQCAtNjUzLDcgKzY1Myw3IEBAIGludCBrbW9kX2VsZl9z
dHJpcF92ZXJtYWdpYyhzdHJ1Y3Qga21vZF9lbGYgKmVsZikNCj4gICAgICAgICAgfQ0KPiANCj4g
ICAgICAgICAgRUxGREJHKGVsZiwgIm5vIHZlcm1hZ2ljIGZvdW5kIGluIC5tb2RpbmZvXG4iKTsN
Cj4gLSAgICAgICByZXR1cm4gLUVOT0VOVDsNCj4gKyAgICAgICByZXR1cm4gLUVOT0RBVEE7DQo+
ICAgfQ0KPiANCj4gDQo+IC0tDQo+IDIuNDAuMQ0KPiANCg==
