Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78517837E
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097667; cv=none; b=M6nJ39wG6CtJm278BtQh+z/BVeREKySDHYEjMKxGcwcNBKqUHv4c7RKhPt5KPvwpJbQ+tZh7xzC9fN/idIzCk++yreNbp5nnWu4Pk/stskHYau9e7Ee7CkRVUfnWge8mMuaqsKxQFcw5k5QfJb4NUojeWhICT4qHhQtX8PrN9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097667; c=relaxed/simple;
	bh=gSvkZI3IncnWbzsTgrGzJofm3vKL0GCAwmBypP/24dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=ey9KXBinrMFKaYkOlg1cbY5GXrLssozD9bPvI+u38NF4uanugURwa986wVERmw8BriK/4zj4tnEMvX4NRyipUlfO2dm72BBiHy9K6ufEAP3bFiLlzovCAImPBgAMikFaUOGn+1kGFTxh4RLufukW4YVDE0pYsi/BPkxOYiYOmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZetbkFls; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZetbkFls"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240819200057euoutp011b13d4037f63edf628494978d7adba1f~tOa9Wjabt2519625196euoutp01a
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 20:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240819200057euoutp011b13d4037f63edf628494978d7adba1f~tOa9Wjabt2519625196euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724097657;
	bh=gSvkZI3IncnWbzsTgrGzJofm3vKL0GCAwmBypP/24dM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZetbkFlszR6DmpN2IFtLgRFZJ6dGi0kCVIJo2pvYmZ4EGKFKSAlwjkC+MfQXBnIWz
	 N8S1l6/xq7v1vWN5X9b6tJNYCRy52NDHj2SbgAjaMJNAWEHbo58pnvcnJ9LNCNv4YO
	 bV+GHcCoWIjIqQvZPp2FaSt39UhdOyYu6K58iTxQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240819200057eucas1p1ecacca02a5a1a6191e5aa8f19d87dd40~tOa9BuCPA1673316733eucas1p11;
	Mon, 19 Aug 2024 20:00:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 87.9F.09875.974A3C66; Mon, 19
	Aug 2024 21:00:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240819200056eucas1p1589eddef05f72d97836f1d5be889048b~tOa8DxcWR2858728587eucas1p1R;
	Mon, 19 Aug 2024 20:00:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240819200056eusmtrp1b01f747bf7816a8aee8d2c3a3437ce00~tOa8DM1b82392423924eusmtrp1q;
	Mon, 19 Aug 2024 20:00:56 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-bd-66c3a4792255
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.29.08810.874A3C66; Mon, 19
	Aug 2024 21:00:56 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240819200055eusmtip15773a0eecd38e763fd4153630a7df717~tOa72_IoM1646816468eusmtip1V;
	Mon, 19 Aug 2024 20:00:55 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 19 Aug 2024 21:00:55 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 19 Aug
	2024 21:00:55 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Sami Tolvanen <samitolvanen@google.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Kris Van Hees <kris.van.hees@oracle.com>,
	Andreas Hindborg <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
Thread-Topic: [PATCH] rust: add `module_params` macro
Thread-Index: AQHa8nKA4EKZfTziuk68Oz0OSltPQw==
Date: Mon, 19 Aug 2024 20:00:54 +0000
Message-ID: <fykedpdp6alypdxhu5allvujrvosfvvsuxuolkxxmb72ipdcg5@7rkt2kbjviqv>
In-Reply-To: <CABCJKud=dfBKaCSqW2NbDCiN=EX0hGxkZ7H+dCd5mK_9NbwBVw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <99F359183AA223468A70F4A9087C9ED7@scsc.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7qVSw6nGXx8zGKx8tBBdovzX/8y
	W1zeNYfNomH2d1aLGxOeMlrcnP6G3eLNtvdsFivnL2e0WP/sMLPF0hVvWR24PHbOusvusWBT
	qcemVZ1sHhu3TWX0+Pj0FovH501yAWxRXDYpqTmZZalF+nYJXBk/fz5nLXgkUjHlIm8D4xyR
	LkZODgkBE4n+A+9Zuhi5OIQEVjBK9Pz8zQ7hfGGU2HlnIROE85lRoqWlnwmm5cGHLVAtyxkl
	nj+8xA5X1fRrCVTmDKNEZ+8kZghnJaPE+RVnmEH62QQ0Jfad3MQOYosIaEvcvNoHFmcWeMcs
	ce+oMogtDLTjz7w9jF2MHEA1phIvr2tAlOtJbNveyQJiswioSnw6cgfM5hXwldjdPoENxOYU
	CJRY+vkLWJxRQFbi0cpf7BDjxSVuPZkP9YKgxKLZe5ghbDGJf7seskHYOhJnrz9hhLANJLYu
	3ccCYStLnLvwjRXkHGag89fv0ocYaSnx9M59JghbUWJK90N2iHMEJU7OfALV+o5T4vdXqFUu
	EsdmHYeKC0u8Or6FfQKjziwk181C2DALyYZZSDbMQrJhASPrKkbx1NLi3PTUYqO81HK94sTc
	4tK8dL3k/NxNjMAUdvrf8S87GJe/+qh3iJGJg/EQowQHs5IIb/fLg2lCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTEGuwucP7mHuvXjRbNeioiOrFJ6V
	bbgstILLtXBr9zpx3mLjzwIts58r3S2Ymr/olXXb68m7rKY/PXGnNfRMmnh0zkzJfV12yZe/
	l14smslca5Z+aVWN1p44nZV/TXaFfnPYe8iU6bh1jPQvh6XPG0VUlO5/DOU6HeJxcOeKP/qP
	Hq3/tUh21UKz3y6Si61vvM01K4gJen5U+/6d65Lyx+2vtXVczqrbc+hOacyfHU3Hg+R3XTog
	k6YStOb8JfN5f9mNL59SkJdf+miS5tFjblZPBWI/dCbnbZIUlpLmu//7ZbJchMl/pvl5Ihfe
	TLbJ3HJ65lV2ced3gcKpE7+6PgsNvs2z/tL9lBwmm5qLBc1KLMUZiYZazEXFiQD3++x20AMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsVy+t/xu7oVSw6nGezpZbNYeeggu8X5r3+Z
	LS7vmsNm0TD7O6vFjQlPGS1uTn/DbvFm23ugkvnLGS3WPzvMbLF0xVtWBy6PnbPusnss2FTq
	sWlVJ5vHxm1TGT0+Pr3F4vF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXms
	lZGpkr6dTUpqTmZZapG+XYJexs+fz1kLHolUTLnI28A4R6SLkZNDQsBE4sGHLSxdjFwcQgJL
	GSUmNj9mhUjISGz8chXKFpb4c62LDaLoI6PE8ouvGCGcM4wSn95dgWpfyShx7OYDFpAWNgFN
	iX0nN7GD2CIC2hI3r/Yxg9jMAu+YJe4dVQaxhYF2/5m3B2gSB1CNqcTL6xoQ5XoS27Z3go1h
	EVCV+HTkDpjNK+Arsbt9AtQVc5gkzix+BnYep0CgxNLPX8CKGAVkJR6t/MUOsUtc4taT+UwQ
	LwhILNlznhnCFpV4+fgf1Gs6EmevP2GEsA0kti7dxwJhK0ucu/CNFeQ2ZqBf1u/ShxhpKfH0
	zn0mCFtRYkr3Q3aI2wQlTs58wjKBUWYWks2zELpnIemehaR7FpLuBYysqxhFUkuLc9Nziw31
	ihNzi0vz0vWS83M3MQIT1LZjPzfvYJz36qPeIUYmDsZDjBIczEoivN0vD6YJ8aYkVlalFuXH
	F5XmpBYfYjQFBt1EZinR5HxgiswriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgt
	gulj4uCUamBasbaRSX67pe1khtOP3pzt9GCYn6KQccDNfZrilrvP58n2nmp+52Q2s9bi1mWZ
	xNuLml6/jjAVWH7bq2HP3Jk8jnzq+5OclXT/tj65mzUzQIQhyOD+T7vWk97nFpeXbJfs1//c
	Gnp2qp+ph7/pc6NnNuIzVktket5g/aBgqF0ZlF9t8K3A82X+lcURMs5Hlj7P+fCk33RB8YGC
	t7MdHvdNO5s47bjhrCO/q0QXKf18Gm45+ciLdZe2BO9/tSY47HtleY9TmrqsVWqRnevpGe/2
	/742vXjaB/bpMxuqf4o8TTzy/Jtdh4Jw5eRAh640zm1PD/3cGbpK4r4FT8W+UwVTbqcuSizo
	mhT1rq/rSOxZJZbijERDLeai4kQAJo9WV9kDAAA=
X-CMS-MailID: 20240819200056eucas1p1589eddef05f72d97836f1d5be889048b
X-Msg-Generator: CA
X-RootMTR: 20240819200056eucas1p1589eddef05f72d97836f1d5be889048b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240819200056eucas1p1589eddef05f72d97836f1d5be889048b
References: <20240705111455.142790-1-nmi@metaspace.dk>
	<ZoxdRjpy2hRndqmc@bombadil.infradead.org>
	<CANiq72=VU+PHfkiq8HokfeCEKvQoeBiUaB76XbW6s3f2zYmEtA@mail.gmail.com>
	<ZplNxxXS3RLULeI6@bombadil.infradead.org>
	<CABCJKud=dfBKaCSqW2NbDCiN=EX0hGxkZ7H+dCd5mK_9NbwBVw@mail.gmail.com>
	<CGME20240819200056eucas1p1589eddef05f72d97836f1d5be889048b@eucas1p1.samsung.com>

T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgMDU6MDQ6MjVQTSBHTVQsIFNhbWkgVG9sdmFuZW4gd3Jv
dGU6DQo+IEhpIEx1aXMsDQo+IA0KPiBPbiBUaHUsIEp1bCAxOCwgMjAyNCBhdCA1OjE14oCvUE0g
THVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24g
VHVlLCBKdWwgMDksIDIwMjQgYXQgMTI6MDg6MTZQTSArMDIwMCwgTWlndWVsIE9qZWRhIHdyb3Rl
Og0KPiA+ID4gT24gTW9uLCBKdWwgOCwgMjAyNCBhdCAxMTo0MuKAr1BNIEx1aXMgQ2hhbWJlcmxh
aW4gPG1jZ3JvZkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIHJhdGlv
bmFsZSBoZXJlIGlzIHRoYXQgYSBydXN0IGJpbmRpbmcgbWVhbnMgY29tbWl0bWVudCB0aGVuIGFs
c28NCj4gPiA+ID4gZnJvbSBmcmVzaCBibG9vZCB0byBoZWxwIGNvLW1haW50YWluIHJldmlldyBD
IC8gUnVzdCBmb3IgZXhpc2luZyBjb2RlDQo+ID4gPiA+IHdoZW4gdGhlcmUgaXMgd2lsbCAvIGRl
c2lyZSB0byBjb2xsYWJvcmF0ZSBmcm9tIGFuIGV4aXN0aW5nIEMgbWFpbnRhaW5lci4NCj4gPiA+
ID4NCj4gPiA+ID4gSSByZWFsaXplIHRoaXMgbWF5IGJlIGEgbG90IHRvIGFzaywgYnV0IEkgdGhp
bmsgdGhpcyBpcyBvbmUgb2YgdGhlDQo+ID4gPiA+IHJlc3BvbnNpYmxlIHdheXMgdG8gYXNrIHRv
IHNjYWxlIGhlcmUuDQo+ID4gPg0KPiA+ID4gQnV0LCB5ZXMsIEkgdGhpbmsgUnVzdCBpcyBhIGdy
ZWF0IG9wcG9ydHVuaXR5IHRvIGdldCBuZXcNCj4gPiA+IGNvLW1haW50YWluZXJzLCBhcyB3ZWxs
IGFzIGdldHRpbmcgbmV3IGRldmVsb3BlcnMgaW52b2x2ZWQgd2l0aCBrZXJuZWwNCj4gPiA+IG1h
aW50ZW5hbmNlIGluIGdlbmVyYWwsIHdoaWNoIGNvdWxkIGhlbHAgd2l0aCBvdGhlciBpc3N1ZXMg
dG9vLg0KPiA+DQo+ID4gR3JlYXQgd2VsbCB0aGVuIG15IHByZWZlcmVuY2UgaXMgdG8gbm90IGhh
dmUgUnVzdCBiaW5kaW5ncyBmb3IgbW9kdWxlcw0KPiA+IHVubGVzcyB0aGUgUnVzdCBjb21tdW5p
dHkgY2FuIGNvbW1pdCB0byBub3Qgb25seSBhIGNvLW1haW50aWFuZXIgZm9yDQo+ID4gYm90aCBD
IEFuZCBSdXN0IGJ1dCBhbHNvIGNvbW1pdCB0byBub3QgZGl0Y2hpbmcgdGhlIHJvbGU7IGlmIGEg
Qy9SdXN0DQo+ID4gY28tbWFpbnRhaW5lciBnZXRzIGhpdHMgYnkgYSBidXMgdGhlIFJ1c3QgY29t
bXVuaXR5IHdvdWxkIHN0cml2ZSB0bw0KPiA+IGxvb2sgZm9yIHNvbWVvbmUgZWxzZSB0byBzdGVw
IGluLiBUaGlzIHdvdWxkIHByb2FjdGl2ZWx5IGhlbHAgd2l0aA0KPiA+IHVwc3RyZWFtIHJlc3Bv
bnNpYmlsaXRpZXMgdW5kZXJzdG9vZCBieSBjb21wYW5pZXMgd2hvIGhpcmUgZGV2ZWxvcGVycw0K
PiA+IGluIHRoaXMgY29udGV4dC4gSXQgaXMgd2h5IEkgYnJvdWdodCB1cCBBbmRyZWFzJ3Mgd29y
aywgSSBhbHJlYWR5IGtub3cNCj4gPiBoZSBoYXMgYSBsb3Qgb2Ygd29yayB0byBkbyBhbmQgcmVz
cG9uc2liaWxpdGllcy4gSWYgbm90IEFuZHJlYXMsIHdobyBlbHNlDQo+ID4gY2FuIHN0ZXAgdXAg
dG8gaGVscCB3aXRoIHRoaXMsIFNhbWk/DQo+IA0KPiBJIGFncmVlLCBoYXZpbmcgYSBjby1tYWlu
dGFpbmVyIGZyb20gdGhlIFJ1c3QgY29tbXVuaXR5IHNvdW5kcyBsaWtlIGENCj4gZ29vZCBpZGVh
LiBJdCB3b3VsZCBiZSBncmVhdCBpZiBzb21lb25lIGFjdHVhbGx5IHdvcmtpbmcgb24gdGhlDQo+
IGJpbmRpbmdzIGNvdWxkIHN0ZXAgdXAsIGJ1dCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIgdm9sdW50
ZWVycywgSSBjYW4NCj4gY2VydGFpbmx5IGhlbHAgd2l0aCB0aGlzLg0KDQpJIHJlY2VudGx5IHN0
YXJ0ZWQgbGVhcm5pbmcgUnVzdCwgYW5kIGFzIEkgY29udGludWUgd2l0aCB0aGF0LCBJ4oCZbSBh
bHNvDQppbnRlcmVzdGVkIGluIGpvaW5pbmcgYW5kIHZvbHVudGVlcmluZy4NCg0KPiANCj4gU2Ft
aQ==
