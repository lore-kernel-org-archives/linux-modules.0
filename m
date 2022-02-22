Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C2C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Feb 2022 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiBVLUy (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiBVLUy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 06:20:54 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90057.outbound.protection.outlook.com [40.107.9.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B90CEA2D
        for <linux-modules@vger.kernel.org>; Tue, 22 Feb 2022 03:20:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvApeH3LoCJJjAp6pVgoH1FsdecZZNWXzOtS92cEInYSNMe0G9O31N32mV0WKtsdF/+EyutBzsQEzjVyGsETvqFAPK7kNBgC2gq63GChSeKVinu503NzBWB9yUDMfh4+PT/EZtTKGkDObO3D/UAkH2T+99ZAaGSaBa6V0LFLa+V9B+jvH3qlnYPkv0shIhtmZD8Hb9c0gz2Vjs8Lf6itxAsv06D6DZoUBRAK/g/ydDTfbv1sDDToxV0oUM1xfSKWsFpUQVG9ZFuHIS+MJu2gPGeTiKOW5HoqNjatt2VjNngj8ghpfxKNAkolef2v8Mn5JEfOB3jgfGKNJX7kIMliHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udm+taKYeTJWYNtptbBlMO+I5ogMidznzDoBqKccSrg=;
 b=Qu0GtgN6+V6zcukYNPPDhS6YPpstnrLcsq1nK2Iwo6Yo+jrTILFlwzHz8Kgj31KJaTe7UDM8ha43lHEtucYjQxdCApe2axgkNYV+6h3LV/I4rlEAM+oQwp23yt55WIYNz40CnYDmTTrFUNu6K1xmSEkPHSuLYiLwmDTYoE6YHkxwmlrrqr8fPOg2bthytyL6g+Z+EFHPTtfqrco4u4OMsnkWs1le+zZhqk8S0gnPY+Bu9rbQAN/sq6s+EuZJbnNxepWcGrHRUehJKpD6zteW9TbbruJvrOboMFnr6B//nF1P8md2eE7fgN46qaFP5hxtSRIGPHJ0fQzFCxiKES1gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 11:20:26 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 11:20:26 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 01/13] module: Move all into module/
Thread-Topic: [PATCH v6 01/13] module: Move all into module/
Thread-Index: AQHYJQ4Iyc5hoYSPF0yTCd/J8nGTMKyd/2MAgAFwz4CAAAITAA==
Date:   Tue, 22 Feb 2022 11:20:26 +0000
Message-ID: <de3fc3fa-bb74-67f9-fb39-81d2307757c6@csgroup.eu>
References: <20220218212511.887059-1-atomlin@redhat.com>
 <20220218212511.887059-2-atomlin@redhat.com>
 <fc315ebf-1ddf-13a8-7fc4-c5310e5785d4@csgroup.eu>
 <CANfR36jccn4nHTSNOHbCz5mjaQ6r-uJONBt3taTgeX_XTEeWFw@mail.gmail.com>
In-Reply-To: <CANfR36jccn4nHTSNOHbCz5mjaQ6r-uJONBt3taTgeX_XTEeWFw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc841bb-be11-4cd9-c9c4-08d9f5f55360
x-ms-traffictypediagnostic: PR1P264MB2264:EE_
x-microsoft-antispam-prvs: <PR1P264MB2264A87E2D38DC3E3EADA571ED3B9@PR1P264MB2264.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5D/Iv61z2hdqD6uoBWFPU7pmod/Q1WEAcHfMyCqmc3t8uL2fBZb//B0XslzngYUYn1s7bp+dkLeNnT2NuxXXSDUTL6+mOASfWV/am9wUVEYnUk8koH/H8lBKaB1w0L+fdSmxsqOyW/JFsIrBV2F+LfiEsFO5oFzfnr/ekxwDfrO2dmmoBXNB9n749jmxSMVXpcvBoy7uCyhX8YwDaMrvelIhWbL8gIIHfkLW0dNkA5RBh8bvSWYA037LxKEUMOxeoo03PUrr/ANzYHn6sc3zPH0q65UUYjkl7lWmt8iPO+a3/wU5VHF3xS/rDwbH2c4X5xm8vJEAXRsQunApY2coZgTn8n4xN/jHLD7jM/sbAYbCeHSjBaqNbFxo5vhna4GAW66H3lGDoAkpPOQXbMtDXeemf7MKA4keAeCCwLqmjzgvldM6I4jRkyznnBYOm+FizUt+1gXzkHzMDj+CgRP35Zin6B/ATkWB7N4D/W2rce74YasMHcJ058q5ztQWYYUi2dO3focaRGRk0/+YpP/L7Ivd+v1RgEIPI2SBtDAWP48yphMO+dMx7YBdB+urN+4BhCcOjbkHC/iZ20D/MM+utDkh6ES0QYewqQiubh7v22LrIjjR1Me7AajfkhJ7QHFBWsp8vq3XWyi5x8qyvf6U0ttR7JrZy9WKLD+AsIR0w60fiBVEu01RuYLipLWRgxYBkW4u3dZxIVap3gDbZErPJjuucTKXXET0ekbIa18hSwTjh6+Fm/lQGpqTpt5a+rYqfFHMx/Uvm+IxzsrwcKJCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(86362001)(186003)(26005)(38100700002)(2906002)(122000001)(38070700005)(31686004)(71200400001)(44832011)(66574015)(8676002)(91956017)(66446008)(66476007)(66556008)(6486002)(66946007)(316002)(6916009)(508600001)(4326008)(64756008)(76116006)(31696002)(8936002)(6512007)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3g0S29pWFVRNk5mc2hPaUxqdVVKRGlDRnVheXNoY2dmc0lXT2paQUlOSWJN?=
 =?utf-8?B?K1RLcXpIL3k5K0NDQjRLN1JmelhXNXJnd1VlU0QwS1FQaWdxbUxPREdINGdu?=
 =?utf-8?B?cStyQlNSWVd0MU9saGJhSXhNQWRPbkNVdkhLWEc1dTk2VS9mb2ZuZ3ZZR1Bp?=
 =?utf-8?B?Y05qc20yZ2Zjd1ZDU2N3VFQ2angyaGhKeFQwbjhjRWs4cE50Zy9IY2NURmt0?=
 =?utf-8?B?VWRoL1NQTWJtZzJ1S3V6b1dtRm16dVRrNTY3Nkw3Y2dBRExiNkZwOVl1Tm1K?=
 =?utf-8?B?Nzh0M2F4MEVNWW40OWVSS0tGZENQL3ZrOHVkTm8wNklYckxHRUlOcllobHFl?=
 =?utf-8?B?cXdNRzhTQVNqclFRL2xEZ1h5cHFHck1QS25jbU5KQjZ2RHBkRkJMUHpZUkJY?=
 =?utf-8?B?L2VjN0RhU1RERHliWEs3ankwUGlsTW8zSkF1RkpjUC82L0xWc25OUnBGb2FM?=
 =?utf-8?B?alNzVHp5RlNhU0ExTVM5NGx2Y2pNTEhWQjdXTlZ1c0psa1p2OUlONFVQRW5L?=
 =?utf-8?B?LzQ1TVRyYnNvYjk5c3pzN21wbUEzOXFsNURNSXRXakovdzJDY3JnZ0dmNGVF?=
 =?utf-8?B?cXRQaTNFWkJqcHRvQTRVNklZS3FjenhVMDBzVGdnaWFJR2JidGJ2d2ZNS3hF?=
 =?utf-8?B?M0J0S0RxUXBVMVRlUzdtY3ZuNHRIWDJaR29UcVlqaEMvMGpzdU5QNXlwcVNB?=
 =?utf-8?B?V0dmYW9HbkxVWnFvWEVjQ2VGakRYeWc1S1l0MGtSQkNYWXVvdWRiL3RLZDZj?=
 =?utf-8?B?SXNWUnJHZG12NVY4aktNTGJWbzVxbC9qcTQyODJiakdkdkU4RENzUjhxU05I?=
 =?utf-8?B?TFpmMjh0SWxEK1FqUzlUdXg4NE8vKytWNkp2dDg0MG9xZXpnMVRVR2lCQVJD?=
 =?utf-8?B?Y0VhNHFqa1V6cWZ4NXFma0FBZnNTenFBRFZvSCtEb1ZxZHhrYXZYaEtwODhZ?=
 =?utf-8?B?RUVKcllwaG5HWFN6NmN2RDFicndMU0piN0dOREl3OTZENWhUaUszVG5DaGRs?=
 =?utf-8?B?dVhLVVdjV2lIUWVFKytxa2RLSVhyblE3ZlJVK3B1ZWoxSEs2L3BPaWNsL1Q5?=
 =?utf-8?B?UXppekt0UjFoajNQZFZpSXlHV3pwNnBPWkhoRFZMOUlydWk5SzI2NGpidzlh?=
 =?utf-8?B?TEt3Mzk4QXR2Z0pMVEtsODYvYVRub0R0c1JUdmNvU2JGcytWOG54VGRTM09X?=
 =?utf-8?B?S1NuVnJ5dkFEOW5EMzJTZ3BwRldpM1p1TlF6NEJGcDdSbzQxVldrTEZIaXpQ?=
 =?utf-8?B?ckpia0ZPc0NWem1GRkFqSWF1dS9ZU0xHWnRtZHlaTnAwdnBEVWxReWJ6U0hK?=
 =?utf-8?B?WXF2TUZDc3dJYjdLbVF6RVZ0QmVteVhFZGtxa05qdHoybVZrMnhvOEkyY0U3?=
 =?utf-8?B?Qkd0dWFFUHl3SmhSR1hJMkRBRTJINjdob2ZGZjh2OHc2eHpnME40anJ6NWUw?=
 =?utf-8?B?L2FBOVQrcWIwTnErVTRJL25TbVowYXg0b1F1aC94RDkyY01zWTZLVTNFcklT?=
 =?utf-8?B?YW1ZZkVjT0RVQnNwWmN5T0dacDRzcFpZaHprSzZpaEtRWXp3UmlhRzY3NnJZ?=
 =?utf-8?B?cWJmYms0cFA0Uk5qSmJ2aTE2SmV6Q0RGR1dtY2NoQlhnUzZLOTk3UzVITjBT?=
 =?utf-8?B?SlRNTHV5T2thVm90QU9TaXZvYzBDVEtjcThCMXdsSHRhM0hWRnNBcisyN3JT?=
 =?utf-8?B?aWFCN2tPK1pDNlpneGpqWjhQL1M0YWtqazVEK2VEVU1sVUR2RE0rMmRVT25N?=
 =?utf-8?B?NXI0NWpkTzJnODlIN1I1RkxLMGpsN0dKaFJPRm9Bd2VsVEg4RkhycHJWL24r?=
 =?utf-8?B?aFNkb2VIa1pHU3R6Tmw3bStGVUN2b2tRTkZNUGxyLzVqcmdsY2UyeWx1Q3U4?=
 =?utf-8?B?NGpVYi83RFp0UGpibGhIUHRaSTFaWUJQUjJpd3AzYWFVT1U2M0V2R1ZBeVN0?=
 =?utf-8?B?UjlXK1VBVUV4ZW1Da24xWHJIRTNTZk1UMlVJUTUva2k2VmZ3RHYxV09IM1Ew?=
 =?utf-8?B?WGRjMVkyMWZHbXFCSEtrTUVLaElodjQwbWtQOTNnaVZpZzRyNTNSdGhkNWo2?=
 =?utf-8?B?QTF4aWh2UVp0aVJxVE9nN2hjQmtzY283Zlk2S3R3TnUzK2t1czJMSUZHZTlR?=
 =?utf-8?B?a3YxeUpjWWVBOWJ1eE4xVmJVZDQvQUhmbmJJVmMvQjNaakN2V3BTRHZFK0Mr?=
 =?utf-8?B?a2tRS1ZWdk1URkVsNm1TNHFWM25HcktvNlpRVEpscE1ZK3NnZnpLRjJOZ3Vy?=
 =?utf-8?Q?xMRiYPoq3JnAFInOva5HHeGGg7++kvH4Ao7XD4FjYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DD0B8D83C041B4198F7DBB3C1CC9521@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc841bb-be11-4cd9-c9c4-08d9f5f55360
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 11:20:26.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01hpM+JwSrQCo51JvV+YCHtsAE1U6W9YbhPzxgNJlG8pDRPvod2jMPpV8FZyU0Mzm2ksIzHGFn7q56NUmfrPUu62dthpAXB0vhC1Mszlg54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2264
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

DQoNCkxlIDIyLzAyLzIwMjIgw6AgMTI6MTMsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBNb24gMjAyMi0wMi0yMSAxMzoxMyArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL01ha2VmaWxlIGIva2VybmVsL01ha2VmaWxlDQo+Pj4gaW5k
ZXggNTZmNGVlOTdmMzI4Li4zYTYzODA5NzVjNTcgMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsL01h
a2VmaWxlDQo+Pj4gKysrIGIva2VybmVsL01ha2VmaWxlDQo+Pg0KPj4gVGhpcyBmaWxlIGFsc28g
Y29udGFpbnM6DQo+Pg0KPj4gS0NPVl9JTlNUUlVNRU5UX21vZHVsZS5vIDo9IG4NCj4+DQo+PiBJ
dCBuZWVkcyB0byBmb2xsb3cgdGhyb3VnaCBpbnRvIGtlcm5lbC9tb2R1bGUvTWFrZWZpbGUsIHdp
dGggYSBjb3B5IG9mDQo+PiB0aGUgY29tbWVudC4gQW5kIHRoZW4gaXQgbmVlZHMgdG8gYmUgdGFr
ZW4gY2FyZSBvZiB3aGlsZSBkaXNtYW50bGluZyBtYWluLmMNCj4gDQo+IENocmlzdG9waGUsDQo+
IA0KPiBJIGRvIG5vdCBzZWUgd2h5IHRoaXMgaXMgbmVjZXNzYXJ5Lg0KPiANCj4gDQoNCkkgZG9u
J3Qga25vdy4NCg0KVGhlIGNvbW1lbnQgc2F5czoNCg0KIyBUaGVzZSBhcmUgY2FsbGVkIGZyb20g
c2F2ZV9zdGFja190cmFjZSgpIG9uIHNsdWIgZGVidWcgcGF0aCwNCiMgYW5kIHByb2R1Y2UgaW5z
YW5lIGFtb3VudHMgb2YgdW5pbnRlcmVzdGluZyBjb3ZlcmFnZS4NCg0KVGhpcyB3YXMgYnJvdWdo
dCBieSBjb21taXQgNWM5YTg3NTBhNjQwICgia2VybmVsOiBhZGQga2NvdiBjb2RlIGNvdmVyYWdl
IikNCg0KU2luY2UgdGhlbiwgc29tZSBhcmNoaXRlY3R1cmVzIGRvbid0IGhhdmUgc2F2ZV9zdGFj
a190cmFjZSgpIGFueW1vcmUgYXMgDQp0aGV5IHdlcmUgY29udmVydGVkIHRvIGdlbmVyaWMgQVJD
SF9TVEFDS1dBTEsuDQpJdCB3YXMgZG9uZSBvbiBwb3dlcnBjIGJ5IGNvbW1pdCBhMWNkZWYwNGYy
MmQgKCJwb3dlcnBjOiBDb252ZXJ0IA0Kc3RhY2t0cmFjZSB0byBnZW5lcmljIEFSQ0hfU1RBQ0tX
QUxLIikNCg0KV2hhdGV2ZXIgeW91IGRlY2lkZSB0byBkbywgeW91IGNhbid0IGxlYXZlIHRoaXMg
aW4ga2VybmVsL01ha2VmaWxlIGFzIA0KbW9kdWxlLm8gaXMgZ29uZS4NCg0KQ2hyaXN0b3BoZQ==
