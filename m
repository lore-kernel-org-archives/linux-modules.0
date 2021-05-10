Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6CC433B4
	for <linux-modules@archiver.kernel.org>; Mon, 10 May 2021 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765CD6143C
	for <linux-modules@archiver.kernel.org>; Mon, 10 May 2021 13:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhEJN6m (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 May 2021 09:58:42 -0400
Received: from smtp1.axis.com ([195.60.68.17]:58150 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244030AbhEJN4Q (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 May 2021 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1620654911;
  x=1652190911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hb/jG4wMf/NFRV39KIwQuQQckANI6MG45Zb4o8cj90I=;
  b=hpD/iKFPEDsmmG5kmBCddDu4tbwQhdWa866UkP2VA3kMMC3yT+IU+kCv
   1wzh9wfUmlMfKoyyOuGsy18868cAptQrvDEH0I7AzLdRTMREjECWeytpS
   SSSmzYcbqZ0/6G4JzshBijbSrt/wIWB+sAScG8A/h01pPBeZyXstIZXzn
   nMj0hcl1THhOQL9KGMDeLY14NIyjEMTKYhjxV2+gSJg0SJuxZM+6iq4Vo
   lw9BZhab64o6NbS5NFd99cfvbW62272EgNlI9GsL4LbJ98Z0Ci5t847tI
   nG2iTX5U7L7yfju8nVRewCELmsU0+6oXxoWTX2Xx8u7Ndh4m6nVBrErp9
   g==;
From:   Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     linux-modules <linux-modules@vger.kernel.org>,
        Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] libkmod: Always search modules.builtin if no alias has
 been found
Thread-Topic: [PATCH] libkmod: Always search modules.builtin if no alias has
 been found
Thread-Index: AQHXQUFwKKiiPtblmUSr5sgh7GpCxarai8OAgAIzxsA=
Date:   Mon, 10 May 2021 13:55:09 +0000
Message-ID: <91eb2b9fbd854cb0a3436fb4fcb7ceb1@XBOX03.axis.com>
References: <20210504235836.24246-1-pkj@axis.com>
 <CAKi4VAJLS7_9T3kUcxqphASF+3FegXeDmaDebsEFEaejU0BS0w@mail.gmail.com>
In-Reply-To: <CAKi4VAJLS7_9T3kUcxqphASF+3FegXeDmaDebsEFEaejU0BS0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBEZSBNYXJjaGkgPGx1
Y2FzLmRlLm1hcmNoaUBnbWFpbC5jb20+DQo+IFNlbnQ6IGRlbiA5IG1haiAyMDIxIDA3OjU1DQo+
IFRvOiBQZXRlciBLamVsbGVyc3RlZHQgPHBldGVyLmtqZWxsZXJzdGVkdEBheGlzLmNvbT4NCj4g
Q2M6IGxpbnV4LW1vZHVsZXMgPGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnPjsgUGV0ZXIg
S2plbGxlcnN0ZWR0DQo+IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGxpYmttb2Q6IEFsd2F5cyBzZWFyY2ggbW9kdWxlcy5idWlsdGluIGlmIG5v
IGFsaWFzDQo+IGhhcyBiZWVuIGZvdW5kDQo+IA0KPiBPbiBUdWUsIE1heSA0LCAyMDIxIGF0IDU6
MTcgUE0gUGV0ZXIgS2plbGxlcnN0ZWR0IDxwa2pAYXhpcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
Q29tbWl0IDg5NDQzMjIwZSBicm9rZSB0aGUgbG9va3VwIGZvciBidWlsdGluIG1vZHVsZXMuIG1v
ZHVsZXMuYnVpbHRpbg0KPiA+IHdhcyBubyBsb25nZXIgc2VhcmNoZWQgaWYga21vZF9sb29rdXBf
YWxpYXNfZnJvbV9rZXJuZWxfYnVpbHRpbl9maWxlKCkNCj4gPiByZXR1cm5lZCAwLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRA
YXhpcy5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBJIGRvIG5vdCBrbm93IGlmIHRoaXMgaXMgdGhl
IGNvcnJlY3QgdGhpbmcgdG8gZG8sIG9yIGlmIHRoZSBjb21taXQNCj4gPiBtZXNzYWdlIG1ha2Vz
IGFueSBzZW5zZS4gSG93ZXZlciwgaXQgc29sdmVzIHRoZSBwcm9ibGVtIHdlIHdlcmUgc2VlaW5n
Lg0KPiA+IFdlIHVzZSBmdXNlLCB3aGljaCBpbnN0YWxscyAvZXRjL21vZHVsZXMtbG9hZC5kL2Z1
c2UuY29uZiB0byBsb2FkIHRoZQ0KPiA+IGZ1c2Uga2VybmVsIG1vZHVsZS4gSG93ZXZlciwgd2Ug
aGF2ZSBmdXNlIGJ1aWx0LWluLiBOb3JtYWxseSwgdGhlDQo+ID4gZm9sbG93aW5nIGNhbiBiZSBz
ZWVuIGluIHRoZSBsb2c6DQo+ID4NCj4gPiAgIHN5c3RlbWQtbW9kdWxlcy1sb2FkWzE5Ml06IE1v
ZHVsZSAnZnVzZScgaXMgYnVpbHQgaW4NCj4gPg0KPiA+IGJ1dCBhZnRlciBjb21taXQgODk0NDMy
MjBlLCB3ZSBpbnN0ZWFkIGdvdDoNCj4gPg0KPiA+ICAgc3lzdGVtZC1tb2R1bGVzLWxvYWRbMTkz
XTogRmFpbGVkIHRvIGZpbmQgbW9kdWxlICdmdXNlJw0KPiA+DQo+ID4gLy9QZXRlcg0KPiA+DQo+
ID4gIGxpYmttb2QvbGlia21vZC1tb2R1bGUuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbGli
a21vZC9saWJrbW9kLW1vZHVsZS5jIGIvbGlia21vZC9saWJrbW9kLW1vZHVsZS5jDQo+ID4gaW5k
ZXggNzZhNmRjMy4uNjcyMDkzMCAxMDA2NDQNCj4gPiAtLS0gYS9saWJrbW9kL2xpYmttb2QtbW9k
dWxlLmMNCj4gPiArKysgYi9saWJrbW9kL2xpYmttb2QtbW9kdWxlLmMNCj4gPiBAQCAtNTc3LDcg
KzU3Nyw3IEBAIEtNT0RfRVhQT1JUIGludCBrbW9kX21vZHVsZV9uZXdfZnJvbV9sb29rdXAoc3Ry
dWN0IGttb2RfY3R4ICpjdHgsDQo+ID4NCj4gPiAgICAgICAgIERCRyhjdHgsICJsb29rdXAgbW9k
dWxlcy5idWlsdGluLm1vZGluZm8gJXNcbiIsIGFsaWFzKTsNCj4gPiAgICAgICAgIGVyciA9IGtt
b2RfbG9va3VwX2FsaWFzX2Zyb21fa2VybmVsX2J1aWx0aW5fZmlsZShjdHgsIGFsaWFzLCBsaXN0
KTsNCj4gPiAtICAgICAgIGlmIChlcnIgPT0gLUVOT1NZUykgew0KPiA+ICsgICAgICAgaWYgKGVy
ciA9PSAwIHx8IGVyciA9PSAtRU5PU1lTKSB7DQo+IA0KPiBTbyBpbiB5b3VyIGNhc2UgeW91IGRv
IGhhdmUgbW9kdWxlcy5idWlsdGluLm1vZGluZm8sIGJ1dCBmdXNlIGRvZXNuJ3QNCj4gc2hvdyB1
cCB0aGVyZS4gT24gdGhlIG90aGVyIGhhbmQgaXQgaXMgbGlzdGVkIGluIG1vZHVsZXMuYnVpbHRp
bi4NCj4gRG9lcyBtb2R1bGVzLmJ1aWx0aW4uaW5mbyBjb250YWluIGFueXRoaW5nIG9yIGlzIGl0
IGFuIGVtcHR5IGZpbGU/DQoNCldlIGhhdmUgbmVpdGhlciBtb2R1bGVzLmJ1aWx0aW4ubW9kaW5m
byBub3IgbW9kdWxlcy5idWlsdGluLmluZm8uDQpBIGxpdHRsZSBnb29nbGluZyB0dXJuZWQgb3V0
IHRoYXQgbW9kdWxlcy5idWlsdGluLm1vZGluZm8gc2VlbXMgdG8gaGF2ZSANCmJlZW4gaW50cm9k
dWNlZCBpbiA1LjIsIGJ1dCB0aGlzIHByb2R1Y3QgdXNlcyBhIDQuMTkgYmFzZWQga2VybmVsLg0K
DQo+IEl0IHNlZW1zIHRvIG1lIHNvbWV0aGluZyBlbHNlIGlzIGJyb2tlbjogIGFsbCBtb2R1bGVz
IGluDQo+IG1vZHVsZXMuYnVpbHRpbiBzaG91bGQgYmUgaW4gbW9kdWxlcy5idWlsdGluLm1vZGlu
Zm8gYXMgd2VsbC4gV2hhdCBpcw0KPiB0aGUgcmVzdWx0IG9mIHRoZSBmb2xsb3dpbmcgY29tbWFu
ZHM/DQo+IA0KPiBncmVwIGZ1c2UgL2xpYi9tb2R1bGVzLyQodW5hbWUgLXIpL21vZHVsZXMuYnVp
bHRpbg0KDQprZXJuZWwvZnMvZnVzZS9mdXNlLmtvDQoNCj4gZ3JlcCBmdXNlIC9saWIvbW9kdWxl
cy8kKHVuYW1lIC1yKS9tb2R1bGVzLmJ1aWx0aW4ubW9kaW5mbw0KDQpncmVwOiAvbGliL21vZHVs
ZXMvNC4xOS4xMTAtYXhpczgvbW9kdWxlcy5idWlsdGluLm1vZGluZm86IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkNCg0KVGhpcyBpcyBhbiBlbWJlZGRlZCBwcm9kdWN0IGJ1aWx0IHdpdGggb3Vy
IG93biBkaXN0cmlidXRpb24gYmFzZWQgb24gDQpQb2t5IEdhdGVzZ2FydGggZnJvbSB0aGUgWW9j
dG8gUHJvamVjdC4gVGhlIHJvb3RmcyBpcyByZWFkLW9ubHksIGluY2x1ZGluZyANCi9saWIvbW9k
dWxlcywgc28gYW55IGNvbnRlc3QgdGhlcmUgaXMgY3JlYXRlZCB3aGVuIHRoZSBmaXJtd2FyZSBp
bWFnZSBpcyANCmJ1aWx0Lg0KDQo+IHRoYW5rcw0KPiBMdWNhcyBEZSBNYXJjaGkNCj4gDQo+ID4g
ICAgICAgICAgICAgICAgIC8qIE9wdGlvbmFsIGluZGV4IG1pc3NpbmcsIHRyeSB0aGUgb2xkIG9u
ZSAqLw0KPiA+ICAgICAgICAgICAgICAgICBEQkcoY3R4LCAibG9va3VwIG1vZHVsZXMuYnVpbHRp
biAlc1xuIiwgYWxpYXMpOw0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSBrbW9kX2xvb2t1cF9h
bGlhc19mcm9tX2J1aWx0aW5fZmlsZShjdHgsIGFsaWFzLCBsaXN0KTsNCg0KLy9QZXRlcg0KDQo=
