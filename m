Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2037.outbound.protection.outlook.com [40.92.103.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAD2907;
	Sat, 15 Jun 2024 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718427073; cv=fail; b=ZG9wX2kPduKoJD/J6Vqu1CnQN0RjhPOpZ3jbhV2Vvja79f4Jl1hyc7uKuRz0Bnf467euIcovPMOV9gI2qsT5L+rdmr6ihBi14hNi4teAVOGePigJktrrmFKkPXU7s8mr4LYC0Q0eT7Pe947xEfu77vqdDwCH4NPnyHcD0UTw5dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718427073; c=relaxed/simple;
	bh=cxK4nfhKTqx84RGhMCgqzzXZq3JmUUIK7+cey9f6jAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCUK0QTrA/HXGgmyMUDwd/X+kxBar915tp9yeMkOfCgeebKrA3EWW5iJM7gwDk4n8A641AVJBY0FyBbGXutwCu+EpFNfZvi93z8vjnU6mh9EsoeCM1pDLVzy5ucNG5cEkW/9FXbTHcWl8VY71ZPihoVnmXOnzsoKydCZGX1vDmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=DJPkkZMQ; arc=fail smtp.client-ip=40.92.103.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="DJPkkZMQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX1NOH1SYd4xpgOQDJgaeWauSh9ydK/SpuWk7Wr/hhw5BILUbH/usLOVNtSFUIEOEnAenSSWTIMPp+68DzEuYo5QxmMiy04j4GM04DtcF4HIkeHxYgnr8IBJ+lt9/fqDkSRS7FW/+rd++GrynLQZ/t9nzxEvAvf1hQjj5SZUJGMWsSy51tR6dudXHEsEeo8geLpYDa2G9rFZT0yOXBq/KmXhvn0tgOaRgtoBDu2ledFswE2suemGhvVSF46JYZqyvvHlV9e4SlCkqiokGWLkihhZuYdMgTtm6E6q6sH9MZO0W2NGViPfzlEX4muTHQPVbp1/b4JhY9HthNOnaTYfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxK4nfhKTqx84RGhMCgqzzXZq3JmUUIK7+cey9f6jAQ=;
 b=bKQw/7ImKFIi7XEzZurl1+k7kCldlu4qktkHnfVDV2IzrEHr/YstoDwzXj6XZUfFnJ7IjdnYinCQD9X6OitydA7OTGgfBlCAMr7GXNANAU7EMTZ36Hi4vOS9JFFUZDavQ0iGxAbBxJuYenZmrwVpoJjvdiinqZcsydlNakSkCjoPx4OQh5DPounHR46bPy3IL3HNPYocd8mjyX1Jn3fwax3OyufyzUrfgS+VRPm/uuCvKPG5L5f7Z7WTdELZobP9mGfSUcUdK6/X93C3b6fqJiUUEiA7T9j4iyO+Et7KfpDuekWW/xw+dLWRngEbX4du8A8/jTrFL1GIEro8KlPvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxK4nfhKTqx84RGhMCgqzzXZq3JmUUIK7+cey9f6jAQ=;
 b=DJPkkZMQCe2lLux+WZ2T7mXDxi+tolVfg/i3d73qbY65TQBFAqwOTaCeVSRkPAtQH3hozvI1f9R2Pk2I4sEzabNZ8RTyx02Do4CuglRQYj9CetTDh509v5C9oJBCWWLx4xxRkUyKXZQgesPzV9GEC7ZA5hNPmpuRyxlft+TExUN4GdRoLbqjIaKqVYCO2pG/HvQu68OYsJruHqv/wqqgBF1tzEkqSsTtsJ2bU+yKkU3TS3in/VJG5EXS08av0fBvAZLgT4ALOWxEgWhV/D/8w55nSnOoHxjGUsXyccGm0q9ogYVF4RjPNJrWmWslXGjgbs0jWpPPa+4yum4ZeBbgNg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB0399.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.27; Sat, 15 Jun 2024 04:51:07 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7677.026; Sat, 15 Jun 2024
 04:51:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: "mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Thread-Topic: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Thread-Index: AQHat92/O7UUpgMSCkmL1ayN4UTeWLHHpwsAgACofew=
Date: Sat, 15 Jun 2024 04:51:06 +0000
Message-ID:
 <MA0P287MB0217A9BE2B1FAFF20027EC23B8C32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <2eybrtgvcbrvd63sckzpsldhnolnqve4v7xyqpfoq2uvvskdcv@rpu7vlrbdclk>
In-Reply-To: <2eybrtgvcbrvd63sckzpsldhnolnqve4v7xyqpfoq2uvvskdcv@rpu7vlrbdclk>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [cQI5cKoeccyrgs32u2ahBvX/T5ZNhFdE32xuNOtw7F1RwGHnGVl6EdU05znzG97aKMNpC5SWWh8=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB0399:EE_
x-ms-office365-filtering-correlation-id: bd676399-da4e-4c4b-1fa0-08dc8cf6c4ba
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|440099025|3412199022|102099029;
x-microsoft-antispam-message-info:
 hhAanDfk7ouswd1rWTALhaggWRfDbom17RFxBhO9zRA2uP1daWyaWThM0FzasJAHk98G6CB0g0hknsNgNdWrbZZ0cPX0D0fKlUgi/8shjVeYYdAsIG1kPIPxMcpmWTuXu8DnAqBbekHfywyIPMPrFiIRwysO112YcIVh0xIZUknnScgdCr0Qkn3aAXkpzj+eAyuz/AjJwmfEQf5uczaDgOeg8QWOfQC80qC9nyVQuT6nWzDWjkk9/y9sEu0yAoTg1KJZE9i1I8d2SzSRd6UOuWJB1zlZH+da+3CucJnyAe8SZoDUj28nwikM+nf3t8tobePr073wSrGadf7B/VftlhA9CtG/7QuLHgwdCjmQyq/MwI93jP4+QS8RZhKd9iZ8wfBQR/q7j1wb1yTYVgW82WXIqe0ujYoOjR6fWAObbs9srcvwvOVh16YQcQLmz6GkGPmhLGvRj+OtKzjdJQH6efJeD4M8TdyOncGsF1VWt0tFT938M3seFaw0fw4rXcAX2mk5c8Fv+uCg6W5gBdpvtK6W8JNTDBolBs539PjOF4xFpCaxaaVEJS5kgwFcBYrW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MU9NbG1jRkVMWk5pSjVrTzZYL3F4a3FxVUszNE96QlptSU9BNStMTnFFOG8v?=
 =?utf-8?B?d1VENiszdmMxcHdsRkdkdE5sNEthNzI5dHA5RE43L002Uy9ZdTkySFZ4WmRo?=
 =?utf-8?B?Q09vbkwyYVhRZ2oxdUJXb2lOeEQ3by93ZWxJVGM0UVF6Tzd4T2xXTXh5QVRR?=
 =?utf-8?B?ZnNQbWNLckoyQTNCZG0wRm41R3RFbGQ5K05ldDZkNTg1QVVqdTVyOGVIQkl1?=
 =?utf-8?B?YUhLWWdicFkwb0lmTVBIbTVqQU5CUUFCUlE1UHNQWmFMVnd0UUxrbDFtaFk0?=
 =?utf-8?B?bFlIMS8yNlhTMTZRTDV4NUQ2YXcwNFZjMnoyU3A5MVJDb3R5THg3dm5ZMmRo?=
 =?utf-8?B?S3BWK1kzenhhd28rdVdjL1o5L2J2ajJKZTZOLzhFa2cwdHZ0YXRtTUw0OW1h?=
 =?utf-8?B?cFlJVHdIOTh6SGd3OXo2OUk2VkdoOUUxR0VrUmNpQUV6a1l1Qmp2dnc1dTNq?=
 =?utf-8?B?N25KcE9YcVkrS1lMaDFCNW1xVTB1NWV1S3ZDZm0yZy94ZFhqVGpadkhtWDc5?=
 =?utf-8?B?UDgwY0tHd2ovWHo4WWZxdTJKNWREbDJzSi81aVQ3ekdhZ0U2YmpTSXFSYitO?=
 =?utf-8?B?UHd6cjJSUHNNVmYrT2gzRXNCbVFlaEhKeGlEc21CaS8ySHFFaDdwK0ZlSEUr?=
 =?utf-8?B?RkFidi9wZ1d2TE54a0Q1R3ZpWkE0OG44cTZza01iMDRYMS9oOVhZK3hkaCtJ?=
 =?utf-8?B?eUFrZElEWlhXU2FPczFEZlhuZ3ZNcXMyMjhCSVh5dGlFZHZiNWpvaVZNTnZT?=
 =?utf-8?B?WTJNNEt1NDdabWcyc09vWWdVeU1sc1Q0NVV6UkNIVzlWbktiRTQ1VUhyeG9z?=
 =?utf-8?B?RUFEa0Z3U3EzL1JzSWZMTzJGWjd5SjNKSFJZTjJ2WEE0UkQwK1VVeTNKcitL?=
 =?utf-8?B?R1p6YUlmT3l5QTR6UFQ2STkzelUzd3B0dXp3V296b3lOREZRc0RBS3JpN2hJ?=
 =?utf-8?B?NW5PamdzVXppZWphUXBiK21HelpEU2QxbFRUZElKTU96MGl2aFNkM0FZdVF2?=
 =?utf-8?B?NmtmQzhjNDVCaDRnZ3BDRkhkdSttVWlwL3VlcjVEQS9BeWpqNW9kM1FDdkI0?=
 =?utf-8?B?K3U3Wk01SVNHT0tSR2lHMERaWmdFNDQ2RDZlVUpLekRyejJDRGJ3UHFHL0tR?=
 =?utf-8?B?dU9TOUV3OUp3aTZHUE1QOTlEMW1PM2I5T3J5cUtJRGlkZlZDWjhLRW1sRStt?=
 =?utf-8?B?dmhhQ3pGVEY2d0pIWitoZDZPb2FEWTZJdnQyU2hUTWdPL09EQjFoeHJQZThK?=
 =?utf-8?B?MVJyY1E4OFRHekkxSmtzM2tpMUg2TXhYbVZqd1BZU3pxSUY1YXorc1dMQmZT?=
 =?utf-8?B?Qmw5M1h1VU5vbVBJNjJVZmV1cXVNTkgzcEYwVEh5TjNrMEFzVlA2WVhPaFVi?=
 =?utf-8?B?bXhqb3FZSDZpMlRXUXIxNDdaQ3hnWExuSkk5R1FmMXR6ZTVsYnBkdFNmY2JJ?=
 =?utf-8?B?cnRXSUpOYjBqZGQ2S3RMTkx2a0dQM0JEbVZpZXlvZktJOGZUa1hWNjVBY3dK?=
 =?utf-8?B?aEY0eU9IUG43WVJ0QVczWE8rSDFSTXVTM0NNall1TTB2Vmg1Q0hJdFVDNi8w?=
 =?utf-8?B?bUlQdXBPcDFIMndTZSsxWW5PbFUyd2paWldyMDZseFIzQStiU09qQVBRc0Zr?=
 =?utf-8?B?cThJR0V3WXl1RW00S0dtTktuai96Yy8wTlZVMkpqbVFlbU5vMXg0N2ZGUnJ3?=
 =?utf-8?B?aFZqdkhTdlRhZGp0aHEyREZML21ub05zMWpzMTVmcWkvSHdJV3V6aUJqNXdk?=
 =?utf-8?Q?eBZs1qyGksP5jlI05c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd676399-da4e-4c4b-1fa0-08dc8cf6c4ba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 04:51:06.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0399

VGhhbmtzIGZvciB0aGUgcmVwbHkgTHVjYXMuIEl0IG1ha2VzIHNlbnNlIG5vdyENCg0KPiBPbiAx
NSBKdW4gMjAyNCwgYXQgMTI6MTjigK9BTSwgTHVjYXMgRGUgTWFyY2hpIDxsdWNhcy5kZW1hcmNo
aUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBKdW4gMDYsIDIwMjQgYXQgMDY6
NDk6NTlBTSBHTVQsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gSGkNCj4+IA0KPj4gSSBhbSBBZGl0
eWEgR2FyZy4gSSBvZnRlbiByZXF1aXJlIHVzaW5nIG91dCBvZiB0cmVlIGRyaXZlcnMgdG8gc3Vw
cG9ydCB2YXJpb3VzIGhhcmR3YXJlcyBvbiBMaW51eC4gU29tZXRpbWVzIHRoZSBwcm92aWRlciBk
b2Vzbid0IHdyaXRlIGdvb2QgZHJpdmVycywgYW5kIG9mdGVuIHRoZXkgaGF2ZSB0byBiZSBmb3Jj
ZSB1bmxvYWRlZC4gSXQncyBhIGNvbW1vbiB0aGluZyBpbiBwcm9wcmlldGFyeSBkcml2ZXJzLiBJ
IGtub3cgdGhlIGF1dGhvciBvZiB0aGUgZHJpdmVyIHNob3VsZCB0YWtlIG5vdGUgb2YgdGhlIGlz
c3VlcywgYnV0IHN0aWxsIHRoZSBmb3JjZSB1bmxvYWRpbmcgb2YgdGhlIG1vZHVsZXMgZG9lcyBj
b21lIGluIGhhbmR5IG1hbnkgdGltZXMuDQo+PiANCj4+IFVuZm9ydHVuYXRlbHkgaWYgQ09ORklH
X01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IGVuYWJsZWQgaW4geW91ciBrZXJuZWwsIHdoaWNo
IG1vc3QgcHJvYmFibHkgaXMgbm90IGVuYWJsZWQgaWYgeW91IGFyZSB1c2luZyBhIERpc3RyaWJ1
dGlvbiBwcmUgY29tcGlsZWQga2VybmVsLCB5b3UgaGF2ZSB0byByZWNvbXBpbGUgdGhlIHdob2xl
IGtlcm5lbCBhZ2Fpbi4NCj4gDQo+IENPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEIG9ubHkgZXZl
ciBtYWtlcyBzZW5zZSBvbiBhIGRldmVsb3Blcg0KPiBlbnZpcm9ubWVudCBsb2FkaW5nL3VubG9h
ZGluZyBtdWx0aXBsZSB0aW1lcyBoaXMgb3duIC5rbyBtb2R1bGUuIFRoZW4NCj4gdGhlIGRldmVs
b3BlciBrbm93cyBiZXR0ZXIgdGhlIHN0YXRlIG9mIHRoZSBkcml2ZXIgYW5kIGh3IHRvIGp1ZGdl
IGlmDQo+IGl0J3Mgc2FmZSB0byBpZ25vcmUga3JlZnMuDQo+IA0KPj4gDQo+PiBJIHdhbnQgd29u
ZGVyaW5nIGlmIGluc3RlYWQgb2YgYSBrZXJuZWwgY29uZmlnIG9wdGlvbiwgd2UgY291bGQgdXNl
IGEga2VybmVsIHBhcmFtZXRlciB0byBlbmFibGUvZGlzYWJsZSB0aGlzIGZlYXR1cmUsIEkgYmVs
aWV2ZSBpdCBzaG91bGQgYWN0IGFzIGEgYmV0dGVyIGFsdGVybmF0aXZlLiBBZnRlciBhbGwgdGhl
cmUgbXVzdCBiZSBwZW9wbGUgbGlrZSBtZSB3aG8gYXJlIGZvcmNlZCB0byByZWNvbXBpbGUgdGhl
IHdob2xlIGxpbnV4IGtlcm5lbCBqdXN0IGZvciB0aGUgc2FrZSBvZiBnZXR0aW5nIGEgZnVuY3Rp
b25hbGl0eS4NCj4gDQo+IEp1c3QgYWxsb3dpbmcgaXQgbGlrZSB0aGlzIGlzIG5vdCBhIGdvb2Qg
dGhpbmcuIFlvdSBtYXkgaGF2ZSBhIGFsbCBraW5kDQo+IG9mIGlzc3VlcyB3aXRoIHVzZSBhZnRl
ciBmcmVlLCBkYW5nbGluZyBwb2ludGVycyBldGMuICBUaGF0IHdvdWxkIGp1c3QNCj4gbWFrZSBs
aWZlIGhhcmRlciBmb3IgcGVvcGxlIG5vdCBpbnZvbHZlZCB3aXRoIHByb3ByaWV0YXJ5IG1vZHVs
ZXMuDQo+IA0KPiANCj4+IEkgaG9wZSBmb3IgYSByZXBseSBhbmQgc3VnZ2VzdGlvbnMNCj4gDQo+
IEnCtGQgYXNrIHRoZW0gdG8gdXBzdHJlYW0gdGhlaXIgZHJpdmVyIGFuZCBzdGFydCBzZW5kaW5n
IHRoZSBpc3N1ZXMgdG8NCj4gdGhlaXIgc2lkZS4NCj4gDQo+IEx1Y2FzIERlIE1hcmNoaQ0KPiAN
Cj4+IA0KPj4gUmVnYXJkcw0KPj4gQWRpdHlhDQo=
