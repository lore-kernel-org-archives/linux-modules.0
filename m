Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78096C77B7A
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 06:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjESG7A (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjESG67 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 02:58:59 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2044.outbound.protection.outlook.com [40.107.9.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF6E64
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 23:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K43XDsPckGyKvBeTYDVvrdwjPhwWl9z7y3bY63m9PQUPWpyB4DhtDFxgrV51FAqGjhgsS5QIlDCZL/J8U17I9sgJk8Rd4NmVJQGsDBYno2Ayt1gtCSyfOkco7a/s9SJeYZwbn6Yg3cLaaORbigd2PiIGrHAUyLGplq1X0dqfEicCcsitjgN5ZC37MYsQ4j4Pn2EnmvhV+lxOLwAcmASPGU0pEAEQOhalZWujiQSyfCaxesjpIorYYm+FaQ/Jia6T/k11v5WYUrhnWxXAzlBGUevLFZSYPtd/UxnZs2hK3VJ+Ku0/Yp/2CUb2WyCfClyEJX2LAb/dBPtyvc9gogxPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY8rHGfc2txbOL0rzsx/gzZtsOog4CnX3FCh3s77KMo=;
 b=bPhM7llGtM4Wkn71gIW4XtDNnrUdF9N9tI57y9vw72RoX08GUp5Zfp1hqi0pyI30Cz8TkWkGwjEk+QappXMfgsG/xQUg3xKPfEz+odl0Cj2cr5iCXjkBKOaddDd92ZiKLzfOiFWq55D6x9aj5VD/eCGZI/a09zSzzPwLmlUJxiZQM5vXTygP+U5fYwkzmLJYWrQot7gtNjcoV8HIz//igPv+VnWFfP1J2H5fL1SSt4RYeO9NiTvG1BQr9ESPZF99RZKBsfhMonHBS8K5aVXgmNHmwr3Fc9ZzlKjEA9jQ70ttyJ8yN574c3UZCVTE4Q0rr8j8K1ga3AdSZG1hJEyr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY8rHGfc2txbOL0rzsx/gzZtsOog4CnX3FCh3s77KMo=;
 b=nI0AV43KxaHfLFVJJn6rmXAPDeCGCyy5MDdVUMeKmqfqet+ZD3gQdzZU+H/5P7gt2JIC5s6zA1VvsUNFv+dGtTE32Mlbo3D+w435zzdfmzyuMhL1mCLfWJ5a/dAku50Tspp22L3wZRhTZ7n2l1qZfU5NIIKFdWNeUDFroUw5ZrDaCHItIZXgu7ho6ai6gfGQG8x7N31/Mmkc3O7wDzuWh36MYkKTsA6dy2aPPtqep4qpgaPnTGyiau0+W5qCVZuzflynfn+bbXuBj1uyh5Y8hoxwLgSWBLllPT75oqew3LXOn+wR95+E7TkWK8xb/BZytwTopIlVSYD9HLtpUDNfiQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2336.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:58:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:58:51 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] shared: fix warning reported by UBSan
Thread-Topic: [PATCH] shared: fix warning reported by UBSan
Thread-Index: AQHZiWk05N2CVT8IQEW/hpoSx3An3K9hK+gA
Date:   Fri, 19 May 2023 06:58:51 +0000
Message-ID: <926001fd-34bb-83ee-be77-ccbded164615@csgroup.eu>
References: <20230518091419.53038-1-dmantipov@yandex.ru>
In-Reply-To: <20230518091419.53038-1-dmantipov@yandex.ru>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2336:EE_
x-ms-office365-filtering-correlation-id: 6ff372e7-3b56-4607-7049-08db58368083
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUlaA+nvbPKcmbuZjS5gwpncvqO13EDOYlrZY8Ds0djwNFJu41eoXyG19XCMztT/putJtktqY7WjoH+26JatM0J4/2yB7S5wMy07jgJGmezN9JfPROe/Zj9VkSUpI4/r0rp17/BcFtcKu1ZjRNsJtSrQ5dGoa6SVxOEf1p6QbthSyAFBTUgwlGEGUy4BU+FHlfAVdpiiP7y7+WT5XlgFUIEX0FOj/XvWa2RA73Nx+ZNZyvCoGQgv31+a1ijB3YM4dn3IQIaHuGs86L+l9WYjufKKrtAUTmqJ9VbHgR8qqAs6LLJIx8f3WWeO3gAhD7/fF/BvMpdGbJm6EBtbqqPuLAUNnijMeDwjtH6tcrvPU5+QaWokJ0h8DVxXNn6Bhzcbbs2Hb84v8Ip/fKWtAPVyBmu/KDyKQbb9mStS9kip3wa1Vic5qxdB/QHtg2ibGHk9d8PhwJP7/w6miaHnYNkXsywGkxXo4IxvK+rc9iXrWt2qmpWOg7lcQHgZSk9MKR7/+Rjwe9gjr6cgeJO/klgpFOO2z/RwR++NBgzyKjl/Gukyh/s/R/1ebs18DzN45u8b3nyoU99tkl9GcQWqtM5Yy5v88Y4oJjg/MsvkpLPpbjRdLeNS2efakEatDM8E4x9jFJ0CHUQbTM09f7yi3qorCY/STevxTM+UfX+dQfOQwGcNFZIVYTe2Ak/zUJHcrGDTR5mgAQrq6/5qGTYI2Zow/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(396003)(366004)(136003)(346002)(451199021)(966005)(44832011)(8936002)(5660300002)(8676002)(86362001)(36756003)(186003)(83380400001)(2616005)(38070700005)(66574015)(38100700002)(122000001)(2906002)(31696002)(6506007)(6512007)(71200400001)(316002)(110136005)(478600001)(76116006)(66946007)(91956017)(66556008)(31686004)(66446008)(66476007)(64756008)(6486002)(41300700001)(23180200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk1jOEpPQVhkU2J6WlA1d3RINHV0RHVodWNCcVNqUWIwVzFUVWlGbVBwL081?=
 =?utf-8?B?bjdCbUNNVk1QcElsRDVUNWpPdmhiaE9lNHk1WmdKVXd4T2k1VytsaXdwMmt2?=
 =?utf-8?B?eXJZM2l2Z09mbGRhcEZDYUdURHR0Smt0RFBSU2JqOEZpWC9HQ1Jya1JsTDRP?=
 =?utf-8?B?QWtDbXI1VGNpeWVJaGtLeU1NdGxUanRoRlNHUms4T0V3a1JlZ01aTVpiLyth?=
 =?utf-8?B?dVY5THV3N2hjWmc2ZFFFRWVxNUxwSS9RS2lnQmhxUUg1eFFQd2xZTHdDZzUv?=
 =?utf-8?B?V09WY3pQaFp6dGZnWmMweDBvcXZwdUZhd01JRUtsa1VIOTVJMlowLzFORkFH?=
 =?utf-8?B?SFVPQ1BhY0lhd2EyVmFNOFA2RGZjR2Z5MkJ4UGJMczQwSWVEeXhSdGtSSWVj?=
 =?utf-8?B?VzEzdlJqZWdwT3VXQW93OUt1NS9Pc0JSaXE3aFVDdFVweFRBL0JFaUR4U3JZ?=
 =?utf-8?B?OEZiNnM4N09HMm85Vmx3Qm9uZG9obDZVRzZKZ0Q3YlF3ektzTzF0ZVFkakNZ?=
 =?utf-8?B?V08ybWFwR2NDc1lOREE0SVNtTHJoWE5yTWlNb1dsNXpQOFV6SE53T0Q2Q2lC?=
 =?utf-8?B?QkZ1YllVdlNjTlZjbGhPSnYvMHAxWHN2QklYUmh6TjFHV1RrMjRBa2l5VC9L?=
 =?utf-8?B?SjM0RVM0ckMwOGtQV0tQQVdkU3RlQW5wNkh5WVBIbXRvcnZmazB6QmJMN3Bt?=
 =?utf-8?B?OHpFVElZZmFsVXVNck1BUndFMGhGUUtYLzNoMXpMNUFDUE9uMm9ld0JzWlVV?=
 =?utf-8?B?WWF1RG5hSlR1WVNlenpxZUIyQmxwODB2dXI5SlF3cnFhU3hEUkkwUGdMa2xn?=
 =?utf-8?B?VDA4R0FJeHJMNGkvR3VjU3N4YWVnVjYzNHJJR0VoNnBwVDRnR09LR0MwNEpH?=
 =?utf-8?B?b1FORFVFeWpnSldyU3k2Q3JHM1FwNnRPNUE0UlVlY3pXL3VwZkx5QkN6SjVv?=
 =?utf-8?B?bzVFcHdjOFp6aDFZcURIVDg1T3JKNEh3RytvQm9ud3BYWTdmZ3FTVTl5dEZu?=
 =?utf-8?B?YkhGWFdISEJvSXRaUEtsWE5YR3JKaEZuSSsxaERpczduMENPRUs0eGFYTFpO?=
 =?utf-8?B?blh0NFltU050VXVMbDRZRGU4SS94VzZ3QTJUWHdnVTYzZjNvZnpqNWtrdWdN?=
 =?utf-8?B?YkNHRCs2MjZ2TmZCaU92QjNkV1NtT1FjbEhlZy9xbWYrZi9HRGVmc2w1bzUz?=
 =?utf-8?B?SEZuanBTdjZNb0tEbVRxQkRSRk9LbEtkbmZXZHdvR293ZjFHMTdSWVpoRmFM?=
 =?utf-8?B?ai8wNzZiOG1uNFNvcWM2d3kzbFBrQWRmeFZBbWlKbmppR09EOXlPUEtvb1A0?=
 =?utf-8?B?ZmREVTlkd0hjbEZZUGNLYVh1QVBmdTdmS01WYWZUZkorOHlJMzlTZjFxMGlJ?=
 =?utf-8?B?c3g4TE1vNmNlQXArQUs3NEQwcXZkNXJwbzBFUkk1SVVFU3ZIRm8rWDR4Sk9G?=
 =?utf-8?B?ZjNGc09tbkxXL1F5aEQ1bDg4VHQ5bk1JQkhHbW5IOE9MUVVzNVV0QzBqeGx4?=
 =?utf-8?B?R0x6T0J0em56Z0JyUkZOUWtrRTBFTUNReHZzRXdFRFU4NEdKZTVBNldMb3Bo?=
 =?utf-8?B?YW1BVjJ4Ukk5QTBqZGN0RHo2clV4S0JpeXovY1ZsOGZicXllbFdLdGtHRUxX?=
 =?utf-8?B?RU0zQWdhbDlwaVFMb3ZsOXlYVG1Gano5Y3RVa2JRS2U3OXN0Qm81R0g2U1dv?=
 =?utf-8?B?TFlWWWErbGZJWWdGR09hZ3AyZzJOYWlmVklOaHY5V2JnQ2lxOVRVaS9POGE4?=
 =?utf-8?B?ZXI0WHJWeTA0S1F0N0wwUGdoTlVGRmZobDlyVWFOb3Vjb0haemQ4T1ArZFlV?=
 =?utf-8?B?R1IrWFlIS2JrNVVUZW5KV0pWVWhINTM4aDRadXVyaGdDNjh6OURMT0RZSHhj?=
 =?utf-8?B?SlE0M2xUQlErQW0zM1dKOVV5WjJ0czVZc0k4ems3S3ZJL0FnWmpZK21RNGZu?=
 =?utf-8?B?N1A3dEx6Tkdna3JSMVhqYVFkMWNFNmlNN2srSklQWm04eDJyajVNbmk1OU91?=
 =?utf-8?B?OXhZbEhPOC9DYVQwMWsyUU1TdVlsRTBMRHRGcG82czdYUGI4QTNOdWE5cTFo?=
 =?utf-8?B?S3BNODB0K0NZWEl0S21BK2VMZURlRXlmTlpwZkFReUE5VUNmZHYzSGR1cGFV?=
 =?utf-8?B?VUhjZXZIN0lod21rT3NidDlYaGxGOEdxa1MrVjlvaUFUcmZNc3AzT0I0Vmhk?=
 =?utf-8?Q?EyvtSXeol1MtS7TX8pDtK8vRLthxYkhZC81T6wN98fOO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <814D58D0F46F3647BDFDCC0EE36B9825@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff372e7-3b56-4607-7049-08db58368083
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:58:51.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvFpjmfTyssXS9FomQoNjLkHmUpUDNUXWp+VJvpiqarzbVOAl90S4GONRcnORz6ZvAyPs8c6OBo+5QZ3IK309rU+0LgocYR+IGze5qAlRmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2336
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

DQoNCkxlIDE4LzA1LzIwMjMgw6AgMTE6MTQsIERtaXRyeSBBbnRpcG92IGEgw6ljcml0wqA6DQo+
IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGRtYW50aXBvdkB5
YW5kZXgucnUuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgIGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBGaXggdGhl
IGZvbGxvd2luZyB3YXJuaW5nIHJlcG9ydGVkIGJ5IFVCU2FuIChhcyBvZiBnY2MtMTMuMS4xKToN
Cj4gDQo+IHNoYXJlZC9oYXNoLmM6MjQ0OjM1OiBydW50aW1lIGVycm9yOiBudWxsIHBvaW50ZXIg
cGFzc2VkIGFzDQo+IGFyZ3VtZW50IDIsIHdoaWNoIGlzIGRlY2xhcmVkIHRvIG5ldmVyIGJlIG51
bGwNCj4gDQo+IGkuZS4gYXZvaWQgcGFzc2luZyB7TlVMTCwgMH0gYXJyYXkgdG8gYnNlYXJjaCgp
Lg0KDQpUaGUgYWJvdmUgc2hvdWxkIGJlIHRoZSBzdWJqZWN0IG9mIHRoZSBwYXRjaC4NCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+DQo+
IC0tLQ0KPiAgIHNoYXJlZC9oYXNoLmMgfCAxMiArKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3NoYXJlZC9oYXNoLmMgYi9zaGFyZWQvaGFzaC5jDQo+IGluZGV4IDdmZTNmODAuLjBlMDljOTkg
MTAwNjQ0DQo+IC0tLSBhL3NoYXJlZC9oYXNoLmMNCj4gKysrIGIvc2hhcmVkL2hhc2guYw0KPiBA
QCAtMjQxLDEyICsyNDEsMTIgQEAgdm9pZCAqaGFzaF9maW5kKGNvbnN0IHN0cnVjdCBoYXNoICpo
YXNoLCBjb25zdCBjaGFyICprZXkpDQo+ICAgICAgICAgICAgICAgICAgLmtleSA9IGtleSwNCj4g
ICAgICAgICAgICAgICAgICAudmFsdWUgPSBOVUxMDQo+ICAgICAgICAgIH07DQo+IC0gICAgICAg
Y29uc3Qgc3RydWN0IGhhc2hfZW50cnkgKmVudHJ5ID0gYnNlYXJjaCgNCj4gLSAgICAgICAgICAg
ICAgICZzZSwgYnVja2V0LT5lbnRyaWVzLCBidWNrZXQtPnVzZWQsDQo+IC0gICAgICAgICAgICAg
ICBzaXplb2Yoc3RydWN0IGhhc2hfZW50cnkpLCBoYXNoX2VudHJ5X2NtcCk7DQo+IC0gICAgICAg
aWYgKGVudHJ5ID09IE5VTEwpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gLSAg
ICAgICByZXR1cm4gKHZvaWQgKillbnRyeS0+dmFsdWU7DQo+ICsgICAgICAgY29uc3Qgc3RydWN0
IGhhc2hfZW50cnkgKmVudHJ5ID0NCj4gKyAgICAgICAgICAgICAgIChidWNrZXQtPmVudHJpZXMg
Pw0KPiArICAgICAgICAgICAgICAgIGJzZWFyY2goJnNlLCBidWNrZXQtPmVudHJpZXMsIGJ1Y2tl
dC0+dXNlZCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgaGFzaF9l
bnRyeSksIGhhc2hfZW50cnlfY21wKSA6DQo+ICsgICAgICAgICAgICAgICAgTlVMTCk7DQoNClRv
byBjb21wbGljYXRlZCwgbm90IGVhc3kgdG8gcmVhZC4NCg0KPiArICAgICAgIHJldHVybiBlbnRy
eSA/ICh2b2lkICopZW50cnktPnZhbHVlIDogTlVMTDsNCg0KUHJldmlvdXMgZm9ybSB3YXMgbW9y
ZSByZWFkYWJsZS4NCg0KPiAgIH0NCj4gDQo+ICAgaW50IGhhc2hfZGVsKHN0cnVjdCBoYXNoICpo
YXNoLCBjb25zdCBjaGFyICprZXkpDQo+IC0tDQo+IDIuNDAuMQ0KPiANCg==
