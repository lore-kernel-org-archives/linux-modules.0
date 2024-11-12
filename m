Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1572123DB;
	Tue, 12 Nov 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409688; cv=none; b=GwZPi2VJvzx/Ckwg4LAHt5ij9fM5arq2kTSeKElZnBOilHtFMY57+sJCZ/mQHf9o8V0XpiljI8fum1MBQ5ejv8iVyNuKiExhC3gpqW0ws9O3ERGF7Yh7iD2yvnX4MBqSeWhBxGUNACo1gh1ls+Z1Crn8FZb8jzSa7sgJ+X5L5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409688; c=relaxed/simple;
	bh=2M20ipULjGXwpO41eLIE/8fjstdMBqeuXYmngo/mBpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLMoOMsqTx7B+Aa2G5k84TG1qefL4LqRFTBe/gsirv5orvGdUE9ibKY2e/WeLgtZ26ZBTk8XzMdx8BeQdU7nYX46o7yQUBY7aJ+LjT01hqpQkqWwR+Ou9zFo50EJpJsap2lVfg/nQGDnDd4SPhov3ayimTeNueSfl/r+767cL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XnkD4409fz9sST;
	Tue, 12 Nov 2024 12:08:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S77qXnTSMVfQ; Tue, 12 Nov 2024 12:08:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XnkD431Zcz9sS8;
	Tue, 12 Nov 2024 12:08:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 56E9D8B764;
	Tue, 12 Nov 2024 12:08:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id reLFDPbyYRx0; Tue, 12 Nov 2024 12:08:04 +0100 (CET)
Received: from [192.168.233.62] (unknown [192.168.233.62])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBE5A8B763;
	Tue, 12 Nov 2024 12:08:03 +0100 (CET)
Message-ID: <a5622f46-5eb9-4c62-8a01-6f4bb0e3b701@csgroup.eu>
Date: Tue, 12 Nov 2024 12:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <CGME20241109103554eucas1p1548e0da57cccb9546a88402f1f5c94be@eucas1p1.samsung.com>
 <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
 <D5HZV4A6SC9A.25U3Q0WUVDJHZ@samsung.com>
 <b74f0845-4916-47eb-945b-eb91ae05fc91@csgroup.eu>
 <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <D5K3PNXEIKYK.11GZ8BMY02OA4@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkxlIDEyLzExLzIwMjQgw6AgMTA6NDMsIERhbmllbCBHb21leiBhIMOpY3JpdMKgOg0K
PiBPbiBNb24gTm92IDExLCAyMDI0IGF0IDc6NTMgUE0gQ0VULCBDaHJpc3RvcGhlIExlcm95
IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAwOS8xMS8yMDI0IMOgIDIzOjE3LCBEYW5pZWwgR29t
ZXogYSDDqWNyaXTCoDoNCj4+PiBPbiBTYXQgTm92IDksIDIwMjQgYXQgMTE6MzUgQU0gQ0VU
LCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+PiBPbmNlIG1vZHVsZSBpbml0IGhhcyBz
dWNjZWRlZCBpdCBpcyB0b28gbGF0ZSB0byBjYW5jZWwgbG9hZGluZy4NCj4+Pj4gSWYgc2V0
dGluZyByb19hZnRlcl9pbml0IGRhdGEgc2VjdGlvbiB0byByZWFkLW9ubHkgZmFpbHMsIGFs
bCB3ZQ0KPj4+PiBjYW4gZG8gaXMgdG8gaW5mb3JtIHRoZSB1c2VyIHRocm91Z2ggYSB3YXJu
aW5nLg0KPj4+Pg0KPj4+PiBSZXBvcnRlZC1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+DQo+Pj4+IENsb3NlczogaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcHJvdGVjdDIuZmlyZWV5
ZS5jb20lMkZ2MSUyRnVybCUzRmslM0RkM2RlYjI4NC1iMmEzNWFjMy1kM2RmMzljYi03NGZl
NDg1ZmZmMzAtMjg4Mzc1ZDdkOTFlNGFkOSUyNnElM0QxJTI2ZSUzRDcwMTA2NmNhLTYzNGQt
NDUyNS1hNzdkLTFhNDQ0NTFmODk3YSUyNnUlM0RodHRwcyUyNTNBJTI1MkYlMjUyRmV1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tJTI1MkYlMjUzRnVybCUyNTNEaHR0
cHMlMjUyNTNBJTI1MjUyRiUyNTI1MkZsb3JlLmtlcm5lbC5vcmclMjUyNTJGYWxsJTI1MjUy
RjIwMjMwOTE1MDgyMTI2LjQxODc5MTMtMS1ydWFuamluamllJTI1MjU0MGh1YXdlaS5jb20l
MjUyNTJGJTI1MjZkYXRhJTI1M0QwNSUyNTI1N0MwMiUyNTI1N0NjaHJpc3RvcGhlLmxlcm95
JTI1MjU0MGNzZ3JvdXAuZXUlMjUyNTdDMjZiNWNhNzM2M2U1NDIxMDQzOWIwOGRkMDEwYzQ4
NjUlMjUyNTdDOGI4N2FmN2Q4NjQ3NGRjNzhkZjQ1ZjY5YTIwMTFiYjUlMjUyNTdDMCUyNTI1
N0MwJTI1MjU3QzYzODY2Nzg3NDQ1NzIwMDM3MyUyNTI1N0NVbmtub3duJTI1MjU3Q1RXRnBi
R1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxB
aU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTI1MjUzRCUyNTI1M0Ql
MjUyNTdDMCUyNTI1N0MlMjUyNTdDJTI1MjU3QyUyNTI2c2RhdGElMjUzRFplSiUyNTI1MkYz
JTI1MjUyQjJOeCUyNTI1MkZCZiUyNTI1MkZXTEZFa2h4S2xEaFprOExOa3owZnMlMjUyNTJG
ZzJ4TWNPalklMjUyNTNEJTI1MjZyZXNlcnZlZCUyNTNEMCZkYXRhPTA1JTdDMDIlN0NjaHJp
c3RvcGhlLmxlcm95JTQwY3Nncm91cC5ldSU3Q2M4NmFkYmQ3YmFkMjRiMTA0MmJkMDhkZDAy
ZmU3YzhlJTdDOGI4N2FmN2Q4NjQ3NGRjNzhkZjQ1ZjY5YTIwMTFiYjUlN0MwJTdDMCU3QzYz
ODY3MDAxNDI1OTgyMjYyMiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhj
R2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpv
aVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9R3B4cng0MDFm
UmRDR2FoR2NJNkd0SnAlMkJxTFRac25OcXhzRG96NFRBZlU4JTNEJnJlc2VydmVkPTANCj4+
Pj4gRml4ZXM6IGQxOTA5YzAyMjE3MyAoIm1vZHVsZTogRG9uJ3QgaWdub3JlIGVycm9ycyBm
cm9tIHNldF9tZW1vcnlfWFgoKSIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUg
TGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4+Pj4gLS0tDQo+Pj4+ICAg
IGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgNiArKystLS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2VybmVsL21vZHVsZS9tYWluLmMNCj4+
Pj4gaW5kZXggMmRlNGFkN2FmMzM1Li4xYmY0YjBkYjI5MWIgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+Pj4+ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5j
DQo+Pj4+IEBAIC0yNTgzLDcgKzI1ODMsOSBAQCBzdGF0aWMgbm9pbmxpbmUgaW50IGRvX2lu
aXRfbW9kdWxlKHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4+Pj4gICAgI2VuZGlmDQo+Pj4+ICAg
IAlyZXQgPSBtb2R1bGVfZW5hYmxlX3JvZGF0YV9yb19hZnRlcl9pbml0KG1vZCk7DQo+Pj4+
ICAgIAlpZiAocmV0KQ0KPj4+PiAtCQlnb3RvIGZhaWxfbXV0ZXhfdW5sb2NrOw0KPj4+PiAr
CQlwcl93YXJuKCIlczogJXMoKSByZXR1cm5lZCAlZCwgcm9fYWZ0ZXJfaW5pdCBkYXRhIG1p
Z2h0IHN0aWxsIGJlIHdyaXRhYmxlXG4iLA0KPj4+PiArCQkJbW9kLT5uYW1lLCBfX2Z1bmNf
XywgcmV0KTsNCj4+Pj4gKw0KPj4+PiAgICAJbW9kX3RyZWVfcmVtb3ZlX2luaXQobW9kKTsN
Cj4+Pj4gICAgCW1vZHVsZV9hcmNoX2ZyZWVpbmdfaW5pdChtb2QpOw0KPj4+PiAgICAJZm9y
X2NsYXNzX21vZF9tZW1fdHlwZSh0eXBlLCBpbml0KSB7DQo+Pj4+IEBAIC0yNjIyLDggKzI2
MjQsNiBAQCBzdGF0aWMgbm9pbmxpbmUgaW50IGRvX2luaXRfbW9kdWxlKHN0cnVjdCBtb2R1
bGUgKm1vZCkNCj4+Pj4gICAgDQo+Pj4+ICAgIAlyZXR1cm4gMDsNCj4+Pg0KPj4+IEkgdGhp
bmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBwcm9wYWdhdGUgdGhlIGVycm9yLiBCdXQgdGhh
dCB3b3VsZA0KPj4+IHJlcXVpcmUgY2hhbmdpbmcgbW9kcHJvYmUuYy4gV2hhdCBraW5kIG9m
IGVycm9yIGNhbiB3ZSBleHBlY3Qgd2hlbiB0aGlzDQo+Pj4gaGFwcGVucz8NCj4+DQo+PiBB
RkFJSywgb24gcG93ZXJwYyBpdCBmYWlscyB3aXRoIEVJTlZBTCB3aGVuDQo+PiAtIFRoZSBh
cmVhIGlzIGEgdm1hbGxvYyBvciBtb2R1bGUgYXJlYSBhbmQgaXMgYSBodWdlcGFnZSBhcmVh
DQo+PiAtIFRoZSBhcmVhIGlzIG5vdCB2bWFsbG9jIG9yIGlvIHJlZ2lzdGVyIGFuZCBNTVUg
aXMgbm90IHBvd2VycGMgcmFkaXggTU1VDQo+Pg0KPj4gT3RoZXJ3aXNlIGl0IHByb3BhZ2F0
ZXMgdGhlIGVycm9yIGZyb20gYXBwbHlfdG9fZXhpc3RpbmdfcGFnZV9yYW5nZSgpLg0KPj4g
SUlVQyBpdCB3aWxsIHJldHVybiBFSU5WQUwgd2hlbiBpdCBoaXRzIGEgbGVhZiBQVEUgaW4g
dXBwZXIgZGlyZWN0b3JpZXMuDQo+IA0KPiBMb29raW5nIGF0IHRoYXQgcGF0aCBJIHNlZSB3
ZSBjYW4gYWxzbyBmYWlsIGF0IF9fYXBwbHlfdG9fcGFnZV9yYW5nZSgpDQo+IC0+IGFwcGx5
X3RvX3A0ZF9yYW5nZSgpIGFuZCByZXR1cm4gd2l0aCAtRU5PTUVNLg0KDQpUaGUgLUVOT01F
TSBpcyB3aGVuICdjcmVhdGUnIGlzIHRydWUsIHVzdWFsbHkgd2hlbiB0aGVyZSBpcyBub3Qg
ZW5vdWdoIA0KbWVtb3J5IGF2YWlsYWJsZSB0byBjcmVhdGUgYSBwYWdlIHRhYmxlIC4uLiBp
biB0aGF0IGNhc2UgSSBndWVzcyB5b3UgDQpoYXZlIG11Y2ggbW9yZSBwcm9ibGVtcyB0byBo
YXBwZW4gLi4uDQoNCnNldF9tZW1vcnlfcm8oKSBvbiBwb3dlcnBjIGNhbGxzIGFwcGx5X3Rv
X2V4aXN0aW5nX3BhZ2VfcmFuZ2UoKSB3aGljaCANCmltcGxpZXMgJ2NyZWF0ZScgaXMgZmFs
c2UuDQoNCkNocmlzdG9waGUNCg==
