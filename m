Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A56D13B5A9;
	Mon, 19 May 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672237; cv=none; b=JTmu2ptFwCrnZFpO14his/5HT/OD/L1uVzcG2Y4N4S6LrVvNRMVVy2m8ODnRmr3lrAL1CUy3ZdCIsYWzS4ESeHqGNFlCt6NuIqNt7iyaCB4kD+07q9qUglcx7bBIYNW+50LPjD7CctNsNRsA8Wqzm/y90Sod7KNaMrQCgqH2f7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672237; c=relaxed/simple;
	bh=2Af1XbfqiXmdqDTBK/s5PrxMtPCjQZrdKyRpyxcOonQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EJK8nCjAE/kunj0mCWYXSaQKyfZLDVZe90I0SgCwITTFfZrvogqk0xpci/902XZMfQTuKSvUDjqb0XiSeC+9Zv3J+a9C83Cs/D8tMHaiLWX+olx62zbh7PhR48Xiab05lu9rhnZxRYql6r15MYYM8kvcXulyygeUkRT2HnJLKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=g7Os8QVe reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="g7Os8QVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sAzTA48n/eYJNSrWoAOWU7Sy/2yJF9yIhP5DF6ozIVs=; b=g
	7Os8QVe16OpkcKGj3G9+lkyzfYy9mCTJCWpnG49oJqGNPqHnAOBLCP3WhleF2Vdm
	71D+CD/AtvCELOVxY1a7I/75qFvPGNEci5xUEMJ2FJt0L7UeOLlYkl0wq+OGjsxm
	rOu+kVDJkuHSPVrANXQYPFXIGgfIyy9tEcUh5A1jAY=
Received: from 00107082$163.com ( [111.35.189.95] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Tue, 20 May 2025 00:30:00 +0800
 (CST)
Date: Tue, 20 May 2025 00:30:00 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: release codetag section when module load fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpEeo2qKcyan9BnYGvEaYeso24wQT1eX-CxnBkjbEuY7sg@mail.gmail.com>
References: <20250518101212.19930-1-00107082@163.com>
 <CAJuCfpEeo2qKcyan9BnYGvEaYeso24wQT1eX-CxnBkjbEuY7sg@mail.gmail.com>
X-NTES-SC: AL_Qu2fBfqcvUor5iidY+kXn0oTju85XMCzuv8j3YJeN500siTO0zsPZm9tA0XZ986TCwWhoAiWXQFt5/h2VrZ9YIlMxtpkHqIAt5CIvGGC0YnG
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3e1bf257.c0a6.196e961769d.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgD3X0OJXCto4hIIAA--.48605W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqA1SqmgrVgYIBwABsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDUtMjAgMDA6MDM6MTYsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBTdW4sIE1heSAxOCwgMjAyNSBhdCAzOjEy4oCvQU0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IFdoZW4gbW9kdWxlIGxvYWQgZmFp
bGVkIGFmdGVyIG1lbW9yeSBmb3IgY29kZXRhZyBzZWN0aW9ucyByZWFkeSwKPgo+bml0OiBzL3Jl
YWR5L2lzIHJlYWR5Cj4KPj4gY29kZXRhZyBzZWN0aW9uIG1lbW9yeSB3YXMgbm90IHByb3Blcmx5
IHJlbGVhc2VkLiBUaGlzCj4+IGNhdXNlcyBtZW1vcnkgbGVhaywgYW5kIGlmIG5leHQgbW9kdWxl
IGxvYWQgaGFwcGVucyB0byBnb3QgdGhlCj4KPm5pdDogcy9oYXBwZW5zIHRvIGdvdC9oYXBwZW5z
IHRvIGdldAo+CgpUaGFua3MsIEkgd2lsbCBzZW5kIG5ldyB2ZXJzaW9uLgo+Cj4+IHNhbWUgbW9k
dWxlIGFkZHJlc3MsIGNvZGV0YWcgbWF5IHBpY2sgdGhlIHVuaW5pdGlhbGl6ZWQgc2VjdGlvbgo+
PiB3aGVuIG1hbmlwdWxhdGluZyB0YWdzIGR1cmluZyBtb2R1bGUgdW5sb2FkLCBhbmQgbGVhZCB0
bwo+PiAidW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IiBCVUcuCj4+Cj4+IENsb3NlczogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNTE2MTMxMjQ2LjYyNDQtMS0wMDEwNzA4MkAx
NjMuY29tLwo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPgo+
Cj5BY2tlZC1ieTogU3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KPgo+PiAt
LS0KPj4gIGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgMSArCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2Vy
bmVsL21vZHVsZS9tYWluLmMKPj4gaW5kZXggYTI4NTlkYzNlZWE2Li41YzZhYjIwMjQwYTYgMTAw
NjQ0Cj4+IC0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jCj4+ICsrKyBiL2tlcm5lbC9tb2R1bGUv
bWFpbi5jCj4+IEBAIC0yODI5LDYgKzI4MjksNyBAQCBzdGF0aWMgdm9pZCBtb2R1bGVfZGVhbGxv
Y2F0ZShzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBsb2FkX2luZm8gKmluZm8pCj4+ICB7Cj4+
ICAgICAgICAgcGVyY3B1X21vZGZyZWUobW9kKTsKPj4gICAgICAgICBtb2R1bGVfYXJjaF9mcmVl
aW5nX2luaXQobW9kKTsKPj4gKyAgICAgICBjb2RldGFnX2ZyZWVfbW9kdWxlX3NlY3Rpb25zKG1v
ZCk7Cj4+Cj4+ICAgICAgICAgZnJlZV9tb2RfbWVtKG1vZCk7Cj4+ICB9Cj4+IC0tCj4+IDIuMzku
Mgo+Pgo=
