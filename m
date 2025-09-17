Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D352BE648;
	Wed, 17 Sep 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118311; cv=none; b=OUUQBXpuDkfbkD3s8flDvjum9gmfOkLETsFkllDK2pFYOchTeTKNhkP9UcR8DUruXm156r8coInAp/GarBVA9MmxneFXwA7/UQNCbNv+mEdtgovvTwrCG+oIM+mXVuHZ/4T+A3HymOBBESDupqRMLYGdroYK5N0NQNWwe7hNiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118311; c=relaxed/simple;
	bh=rM4KQ3PkxhYr9FbhyaE5pBKuVvJZZAXxL7KkT6K2uPo=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ira+5JHWhUQcjtx6DIM8jQh63+qSkw1UMo2Y/oQahKGEp+ZtXUhtHXhCUVNDKkoFTedHpFWi3n110eclJGYPbUnwUClLdTcaue7LbKAF8M4FrLuR1uW5UImHjMmn9iI3G4+7nq+RGRj/eA1GgSx+olbRNriguUNeIrMFTglq5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Smggclrq; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Smggclrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1758118281;
	bh=rM4KQ3PkxhYr9FbhyaE5pBKuVvJZZAXxL7KkT6K2uPo=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Smggclrq/NtA5Cx0MxxW+GNweFUxjv1RYKFJzeiZDTvN/8BS/I1PNFgoESS/z57SK
	 oKetg0UpCTquk56p6vkaAVa9g+OEJ+OLhGeU4v/dGAxPnjycGC8rRxZdxRpSYJFEca
	 Emv1vCeAHm4OSx4yY9fMGJaAK0weJ/EcnN0bXP64=
EX-QQ-RecipientCnt: 20
X-QQ-GoodBg: 1
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00420020000000F0
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-FEAT: haFBrozbn+y1w6iRDNE+jsz5WmkBWUHROWGtM7u1qAI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Bhcfj9TQaSmi2QK6UgxAhYAV4w31aPKffPMRkVHOBVLOcc7DfcOQQKtcL4GCPbP5iWAiPpfgO1S8DayM7EHLlw==
X-QQ-STYLE: 
X-QQ-mid: lv3gz7a-7t1758118183t7e572d69
From: "=?utf-8?B?Q3J5b2xpdGlh?=" <cryolitia@uniontech.com>
To: "=?utf-8?B?RHJhZ2FuIFNpbWlj?=" <dsimic@manjaro.org>
Cc: "=?utf-8?B?SmFyb3NsYXYgS3lzZWxh?=" <perex@perex.cz>, "=?utf-8?B?VGFrYXNoaSBJd2Fp?=" <tiwai@suse.com>, "=?utf-8?B?Sm9uYXRoYW4gQ29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?THVpcyBDaGFtYmVybGFpbg==?=" <mcgrof@kernel.org>, "=?utf-8?B?UGV0clBhdmx1?=" <petr.pavlu@suse.com>, "=?utf-8?B?RGFuaWVsIEdvbWV6?=" <da.gomez@kernel.org>, "=?utf-8?B?U2FtaVRvbHZhbmVu?=" <samitolvanen@google.com>, "=?utf-8?B?bGludXgtc291bmQ=?=" <linux-sound@vger.kernel.org>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?TWluZ2NvbmcgQmFp?=" <jeffbai@aosc.io>, "=?utf-8?B?S2V4eSBCaXNjdWl0?=" <kexybiscuit@aosc.io>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?5Yav5Zut?=" <fengyuan@uniontech.com>, "=?utf-8?B?5a6J5Zu956uL?=" <anguoli@uniontech.com>, "=?utf-8?B?a2VybmVs?=" <kernel@uniontech.com>, "=?utf-8?B?bGludXgtbW9kdWxlcw==?=" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 17 Sep 2025 22:09:43 +0800
X-Priority: 3
Message-ID: <tencent_3064F5D903EC827F710A50E1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
	<20250917-sound-v3-4-92ebe9472a0a@uniontech.com>
	<0999abc5390bbfcb21e15bd140510540@manjaro.org>
In-Reply-To: <0999abc5390bbfcb21e15bd140510540@manjaro.org>
X-QQ-ReplyHash: 2225085134
X-BIZMAIL-ID: 15805261366488725622
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 17 Sep 2025 22:09:48 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: NENUB7MpVQfJ93CEdpX6ez1dws86+xgtBEckcIaBvAgupFamReWYswWZ
	E37x3dX0oE1yU/NEL1D5wrYBQif+GLbo1AY2NSKBji26oK+JeeO+dRZb+B17xjIoY+vVkVh
	ZMFT2Tbw2d5EkmyLK1LvphdnGlA8+5H3jngWcBvEEF9pYOEduHnN3yGxxRWbeFfro0zd+NG
	aHWiUJImrrV32QOc90nSgsHOavF8zzhv8qQETqwlhzO+202Uw8S14tIttJn45rcB5CkRuOA
	Uy2AyA/7zj66+J5y49tWs+WGIVGIWRMtM0hSOvwW2Ye6NOCnkXf/iWn9CaMkdGjMm8RV/st
	5hXImMLeNhb1keT+cK7FPVYlyQwGcoJDaABgCy29sb6LyySMzH/6nPwgExUWdHUv9xzj7qJ
	zRh1ds/r6B+kZyBr761OQTjRcgMWE3CMXL7sjMQPnT1KLnKIaA85YgXZZmQLfiqzKwOXd0h
	kyRV5iapHRUkjcTGcj0l5Vh/fo0JfRkwQTklUC1U+zB8rBl9fqwSosTciakf4pGeNWO3BUu
	VJWONkLq5VXwH1GrshutfyTAoUa/HH1B7xZoKRgN+5JkW1fM4D4FEVGZ85uZDj2ghlJfgRq
	Ip85xzTHxJtmiTBWyS0ibcgSgnpWC8cVdHPoo5yysTQgKM85AfD8ABblcr6uhhmQnVoFzM9
	h63jmP7SuDq2nuuytytdkVD4ySK6eFU89BeyB/fZBsYNod0i4FsJdcgtQ4YiHkV5bLt0eRD
	m0uEKv0whaufwUpXFS0aNnKM50A6pSAu0yXgsPnC7huX+g3v/PYXcadP0m8BGOzil6YH6e9
	v5mYt2DBMU7VVHeNxeOG/h7D25wu2Mu8MlfcAiuTm6V+ebe4A54IkEFgMqs6Tm40IzUOCzR
	AhsmAi1hOfd2AqHmgH1dQMT9xf75ryX5vB+KJEHYg0oqrbbT2PUStN7SMf2KPlKRbn9/9fc
	xhQVHiD93L2wEjnuPTV7ZS/AZok1LJ8D6wlQmI1L/m0MxcwPm2Rt4/b9MF0mEX1wWYSmG++
	SsAxhv44syPB4ZihVi5yjDE0eDMPn6M1jvIh4HXgZZ4AR4vsuv1QLaGoLsjV8rn+DuKyuZ0
	Pk/T9L5pL3n
X-QQ-RECHKSPAM: 0

PiBIZWxsbyBDcnlvbGl0aWEsDQo+IA0KPiBPbiAyMDI1LTA5LTE3IDE0OjQ2LCBDcnlvbGl0
aWEgUHVrTmdhZSB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+PiBGcm9tOiBDcnlvbGl0aWEgUHVr
TmdhZSA8Y3J5b2xpdGlhQHVuaW9udGVjaC5jb20+DQo+PiANCj4+IEp1c3QgYnJpZWZseSBk
ZXNjcmliZWQgYWJvdXQgdGhlIG5ldyBvcHRpb24uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IENyeW9saXRpYSBQdWtOZ2FlIDxjcnlvbGl0aWFAdW5pb250ZWNoLmNvbT4gDQoNCj4gSXNu
J3QgdGhlIHBhdGNoIHN1YmplY3QgYSBiaXQgd3JvbmcsIGFuZCBzaG91bGQgY29udGFpbg0K
PiAiZGV2aWNlIHF1aXJrX2ZsYWdzIiBpbnN0ZWFkIG9mICJkZXZpY2VfZGV2aWNlX3F1aXJr
X2ZsYWdzIj8NCg0KU29ycnkgZm9yIHRoYXQsIEkgZm9yZ2V0IHRvIHJlLXdyaXRlIHRoZSBj
b21taXQgbWVzc2FnZS4NClRoeCBmb3IgcG9pbnRpbmcgb3V0Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpDcnlvbGl0aWEgUHVrTmdhZQ==

