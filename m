Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382BDC77B75
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 07:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjESHGW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 03:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESHGV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 03:06:21 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2055.outbound.protection.outlook.com [40.107.9.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29BE73
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 00:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCwGvOyLUMaMz9z+oLNUgRYhW2c3ZgQ6fj6URmJTWJ+QPSYIEzEwsxIk1pE6jcivF/qiA97WsfwGi4ulo3OzJkaiVwU7Oq9m4LMyIObOjCv+o72i/QyeAnEEvu2ooYAZmzUAI/bHZqev+bGQzrMOFWKlfWP60AsP4pwaGS5AnqKs70Af4gZdUJ6epgv3buhCfxVrj+iz6vUdI+hlJn4BreMm8uZBiS2DULyJMFH9rY/iUiUg40COQoIPFIpnuznNhGR+mOP2Xhxk39djPcik8SwSkw5hHYDN2N/UEEZRzg+UM/JQrhJugWmwt3Z6oF8QZPP21JWaNJX+d4MCF1uIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKP2YqDic9cwfWHqByGD9vqsciMehXWgydC+afzZFGM=;
 b=DmpxskCRQKQklwEeF+UoqTvpRvcpyB77yqPbbCMqoaRygUJjmlW9YVNEHwJeo5Qn85Fw05BOP4TKV7aTyVmEPhQ4krtEUye8GQ6ok6i/aGnyxF1FJNE4Nq//aUEai8gBUzyoQL7GVHerH7M5vwOOOEeWWc0UGVfKKkoKEdqwXmvA34GCw9ycYSTgUUFjUWqNFLN4IIEesJB/swqJ78zVs0zggzXmV+nq4+HoY1UazNZqM4fbWkAmo4IhciD13435yr56gdQdhkX5ETVSA5Be6FcPJzFBkYf6leKI01oiFqYfwOgeOzph4vBXhpbq8sJELpj8HjNGWe6G6lrRTmYamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKP2YqDic9cwfWHqByGD9vqsciMehXWgydC+afzZFGM=;
 b=M3oGqpsGOqxjUTlTj4V/fkYdeLoYF/NGwsursjQ1uirNOacRHn0UXFwaiep79RsWLmPcFN425KpYPfxR4IXihXxVSxPDoh/ScMvtTzXcla7pHBMAbxvNHgpfdkcYZT19yZesO6zSlby91Z1VKvzHK8IfBmybusSxo+f88twmp05bAbadGMM8lVdsCch3yOW/NRk2mo4Dp2bhlSU8BGMOvyJiuWV1jKs2yLzEyLTr/lxDUMLCTAdauIWUiNHJJ9TuITb2u5Sk1cpSImj7QIbzcsrT5pmbtqVWr7T9u/WxI5vy9hiR59rkcUz+5z1sqoYZGxUaIyLEBEUHf4g1Yhpy1A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:06:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 07:06:17 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section
 found
Thread-Topic: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section
 found
Thread-Index: AQHZiU0FFJ0hV2DsBEe7l1fjNeaOOK9hKnMAgAADFICAAACugA==
Date:   Fri, 19 May 2023 07:06:17 +0000
Message-ID: <367517d8-5c71-c6e7-b929-2f3a2651de44@csgroup.eu>
References: <20230518054730.11237-1-dmantipov@yandex.ru>
 <3422a991-55ff-785b-f659-29bf65823a61@csgroup.eu>
 <882bbaa6-34a4-9921-6603-596834e085d6@yandex.ru>
In-Reply-To: <882bbaa6-34a4-9921-6603-596834e085d6@yandex.ru>
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
x-ms-office365-filtering-correlation-id: 40f5075a-3d63-4b65-d8f0-08db58378ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXl9hIWybnyj+WdFcKlxmdWHKK/Ro52HxcC9HN7B2NH61NWcvwE/j2Nf/CYEjtskQHxmKoPR3npCUmdUvdxm04vYkYkuWuxEUDd+PZzFdaZ6SjpaJyFuYXCFB8NiMAyHKPBIMMPtTmSl+gE1ua8fR90iFyybVgsj3bJIjWqmBrjVtweru1FHptqPNyPmI4bOCowzRYdBUCLDwiahVyyoi9LvQOmYgokEO+BGxFeN1ZUZWi/FXfdV8sr950pk2jJJfrVCWOyJcq9WVdlEgagK1YPCKHBsQvxEyANrfPx88cRtiGY+e91B+kVV89XtCYX56jTz0m6eBeGlKmy1UlA8ktIfemfMMZN85J9ubVell7ho3or+1hA4bHy4FiHGcjR+A21hKbuiWB5d68C8eUnpK8ojcAhaSZleEtsoedSomxdjDIm4/H73tcX7D7cicIzD/SoMSdqii3XO845NABkDASUieHeN1XDiBrkGQUFozGJh7yV6MeK1yHllDkhOIHRhgRKVFk9xilYYjoGYk+HcjnudYg/e94zvLpPdO/0SZSG+6oZGFtrNe6OkdyRwHHfvNXoKt1LKRmvQJJ0qdnWP4R+byeb61wAUHLwdSTxa1FZzu89iTGAofnYUm4IP+LlxO59PbXBl6Hi5lAMlEKFOk8aC7pD4Js3V+jwfNEg28fW8aDPT77xFKw6dvTtJUpqf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199021)(91956017)(71200400001)(76116006)(31696002)(86362001)(53546011)(64756008)(2906002)(4744005)(6506007)(6512007)(38070700005)(6916009)(66946007)(186003)(66446008)(66556008)(66476007)(478600001)(36756003)(6486002)(122000001)(38100700002)(2616005)(41300700001)(31686004)(44832011)(5660300002)(83380400001)(8676002)(8936002)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHVHd0tXa2tmaWo0YVNIUEk5Sm5BL29ScndCeEtEaEU2SzdKMFZ5Z0RpYlJj?=
 =?utf-8?B?TkZia1d3akh5WVZYeG9ydW9ZZGtNVjBDbnpYWC9uaGEzWUl0K1NGLzV2eFVS?=
 =?utf-8?B?VkRaZ2hoc20wMzRIY3BSRkxtUGdhYkFzMFV4Sk5yL2psSURnRUY3WUFya09y?=
 =?utf-8?B?MUsvNUcvYmd1Q0xUd2E0QlY2U0lzb0k0R1Q1ekFwOVBVOE9nRk1MNkdxYVlC?=
 =?utf-8?B?ckxhdlNuUis1ZVZmenBOZm1SSFlHZW4wU0NDWURmYi9ESjF0dlV0dzhEakg0?=
 =?utf-8?B?dFM5cmlJQTlTeWRvVVcvR20rYlhVanVETXVOSjlSS2JsSzM1TXl4MVUrMFJ0?=
 =?utf-8?B?VTJ2K1JGVk5RRkZtd0lQbmFaSC9HSEw0MG5jUjlWOVFabzFxU1o0NUdEYlBm?=
 =?utf-8?B?VGtyRnJVS0tXdVJaSkh4a2o4Mlh5NkUzR2U3Ky9DcFdlK1JtanFIWDZyT2Zx?=
 =?utf-8?B?RHBaaEdwMFl6RHkvVmQwU0xscXBqR2JtQzF3Z1kvWEsvaExJa2tobWRHYUcr?=
 =?utf-8?B?Y2EwcXBZYW9SQ3cxZzQ4YS9vYy91ZUVoaHBGWVRkeUorSTZvS2hLMldUTXVD?=
 =?utf-8?B?eEdHMGRKTEt3cGJpSXBvMSthS2IxeGNKVTFnMGl4alZtaXJZRjRRc0FFZHlB?=
 =?utf-8?B?STlFbHUrMTFYcStGN2ZSMTZCVk9pTzNYVFlyVTc5Q2s1SnJVQjJYdVoxc1lR?=
 =?utf-8?B?ZUtkYndXa1hPdlFGTTZzTGY3ODVmTzF4SldVZmEwWDBFK0xSRk5PVXlqUThV?=
 =?utf-8?B?Zy9XUTU4UGJ1enczRUc0S0FNS2o0RW5Wa1dXcjRYbUhRaUFVcXRxTVJRRkpK?=
 =?utf-8?B?N1dVY24rZ1REanllSG5lamxmcnFHbFZFaXRYaXo2d3NqT2VRL1IxQStXVGFB?=
 =?utf-8?B?N01HdGtLcWpnMzRZNElyRUhYM2Yra3BUeHgrK25FMDJJT0o1Q2F5bmh1dnJi?=
 =?utf-8?B?aU9TSmc0MVkwbmNTL09xT1RpNUxMeTRNL2twUVVOOHZGZlU3S3NCcDJaN2JN?=
 =?utf-8?B?M2NmK29EaDQ5emk2c3NxVnQ5ck1LVUlwdUNGMStob3dMdGlpNlJJRTQ3SGdj?=
 =?utf-8?B?OWgrbWwzcWpCbTRPNlgwdExEN3l3QVpnNmprb0VRY0t5dkRHRDFoaDZoc1lm?=
 =?utf-8?B?UXh6UlFYMDBLZ0FNUlltcTVQZU9oUGNDcHIwTGNiTitVUGVLR1hGQWllZjY2?=
 =?utf-8?B?Qmw4T21sdDlNTlhzVGVCemNKVjZSQ242WU9nck1EcHRUblgweXpLL05nVHFR?=
 =?utf-8?B?TllsU3RuWVRQSC91a0Z0SUk5YVV6QnNEWlBOZjNpeDZYdGVvR2dnTFk1MVFS?=
 =?utf-8?B?SE5nTmhiTUlOMVFCbTh0cnNOV2ZzbENaOGZvMVg3MTd6ZDBWVEp4Tld4TXk0?=
 =?utf-8?B?dUN2UHVrQjEyOWFHa2ljSitybDI4MGhuVTNQeThHUVF4bzlsQURMLzcrdWEy?=
 =?utf-8?B?NjluWU1jcU4wOEI3RFNJZ0QwdC9pZ0dBZldhVnJvMFI2Nzk1TUgrNlc1ZXdn?=
 =?utf-8?B?bmxWQXIrVTgwZUkrZTErL2JNeXQ4ZmFVb3YwUjRaSXNqcFpUeDhyTk1nakl4?=
 =?utf-8?B?ZHEranRyTS9PTkxqOXlWZ0dPTHRTMXNVRFBLc2Rqek13VUtzSzU3ejM5cGdU?=
 =?utf-8?B?V2ZKaExQd1V3U1phNm9UREFHMS9WRUJWNmhEbjBVbkpYMXp2eU1IV1ZtSk4z?=
 =?utf-8?B?NzJuK2t1QUxLeUxTNGMwNWQ4dUJVcFAydk5EU1NmQnVrUzczaU9mWVJOakVm?=
 =?utf-8?B?a0Y1WFU3TDEvclpxY3FrNlFXMktmZE1OME1VRENlT1V0RCtra3Q2VXZtSlpt?=
 =?utf-8?B?eWNtWjNTa0w4Q1AweXJYT2lJUFl5WnBablFreWhYRnhvSW04aGVCNzE5andJ?=
 =?utf-8?B?Y0FBdmg4elcrbXR3RW1XRlUzbW5NVURVemdtMmJ4Z3ArQkpxRklHcTgzUmI4?=
 =?utf-8?B?T1crOE81clp0YkF2QmFLbkNiZlR6dlUzZmRFUS9QS1NDcWZUaFUzcG8rVEpN?=
 =?utf-8?B?K2h3UHlpNGtqZWxxeTA4QUNPV1h2V0g4dzg1M05YWG80THVSeTZyQlR1SERn?=
 =?utf-8?B?czhYMHEzeTF6bW5OVWZSL25LcExCbGxIb1liVG1jMUhCeDQydnJVK1pCK2FN?=
 =?utf-8?B?ZXBwZXBYV2dOU2lha0s0d094OXJJYkxVSG5leFVSNnBtVjdydGgyaTZUb2JI?=
 =?utf-8?Q?q6TxQIBmkmpSQEVEkv3wnMQ7heF/UJVK+mNsjV8TTcm9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F603A627A9D1AE44BE531C9C6E656975@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f5075a-3d63-4b65-d8f0-08db58378ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 07:06:17.7396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vzd8kBZnduEQY7JcG11SrEJ4Z/kW8nFQo5WhwtPRNYbWGwt7MwTGr8Z7HYGpSPGi7QIr9o8my73hHmJlditPxqDsE+Z9I7tLIBoAq/DGT/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3162
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

DQoNCkxlIDE5LzA1LzIwMjMgw6AgMDk6MDMsIERtaXRyeSBBbnRpcG92IGEgw6ljcml0wqA6DQo+
IE9uIDUvMTkvMjMgMDk6NTIsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+IA0KPj4gRmluZSwg
YnV0IGNhbiB5b3Ugc2hvdyB0aGUgdGV4dCBtZXNzYWdlIG1vZHByb2JlIHByb3ZpZGVzIHdpdGgg
eW91cg0KPj4gY2hhbmdlLCBzbyB0aGF0IHdlIGNhbiBzZWUgaWYgdGhlIGNoYW5nZSBwcm92aWRl
cyBhIHNvbWV3aGF0IGJldHRlciBsZXNzDQo+PiBjb25mdXNpbmcgbWVzc2FnZSA/DQo+IA0KPiBT
dXJlLCBub3cgaXQgaXMgZXhwZWN0ZWQgdG8gYmU6DQo+IA0KPiAkIG1vZHByb2JlIC0tZHVtcC1t
b2R2ZXJzaW9ucyANCj4gL2xpYi9tb2R1bGVzLzYuMi4xNS0zMDAuZmMzOC54ODZfNjQvZXh0cmEv
Y3J5c3RhbGhkL2NyeXN0YWxoZC5rby54eg0KPiBtb2Rwcm9iZTogRkFUQUw6IGNvdWxkIG5vdCBn
ZXQgbW9kdmVyc2lvbnMgb2YgDQo+IC9saWIvbW9kdWxlcy82LjIuMTUtMzAwLmZjMzgueDg2XzY0
L2V4dHJhL2NyeXN0YWxoZC9jcnlzdGFsaGQua28ueHo6IE5vIA0KPiBkYXRhIGF2YWlsYWJsZQ0K
PiANCj4gSSdtIG5vdCBpbnNpc3Rpbmcgb24gLUVOT0RBVEEsIGJ1dCBJTU8gLUVOT0VOVCBpcyBu
b3Qgc3VpdGFibGUgaW4gdGhpcyANCj4gY2FzZSBhdCBhbGwuDQo+IA0KDQpJJ20gZmluZSB3aXRo
IHRoYXQsIGp1c3Qgd2FudGVkIGtub3cgd2hhdCB0aGUgbWVzc2FnZSBpcyBub3cuDQoNCkNhbiB5
b3UgaGFkIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgPw0KDQpXaXRoIHRo
YXQgYWRkZWQ6DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxl
cm95QGNzZ3JvdXAuZXU+DQo=
