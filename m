Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34337A48A;
	Tue,  7 Apr 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592207; cv=none; b=tluKww2ivSAik5YNcISWvblCfRmISxUyktx5SKi2gsxAHQnV/ovbpR7QAXW4PxSgITxyXDUJWKpwoPeIo6dFuFTtTlEQ/q+sVhJ799Y6F+/jIW5H6BWjtHS4QHlD3ZLI66fKY5lw458Ch0ORJsyHs6r5d5jR4ZEFbEd4yZYzOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592207; c=relaxed/simple;
	bh=dX+IFVLlXfck89rDGdXkCKgp6oNg4jgwbXNdGQsDUtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNLwsOibbaWJ7sAuYR0UDxErYkVVb9F9vL2Ox+hjZwuwQtexQzraFc+Y+POyq5CL4qkH4g860JdzY15TBBOp9Esb70iWU/C/60h6YKbrIdq2jfwwy2xMiFcLQ6JY0iW+lOeAgZgCTda63g+RuLhfwGYbe5Bkm28yzik+/0WYrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=O4nbmIfk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="O4nbmIfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775592201; x=1776197001; i=deller@gmx.de;
	bh=YjiN1/G1em0DYAbfcc8nw0XeTa1Y/E9qufKUhwoGijQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O4nbmIfky/0Nb0JAuZc5X5tgZgSXR+NX+JbM7zYhfqAISCpEYRH0meXO6aAg0GG+
	 lHFsbeXrT5+2hhlOL3/4UijbEEyRlx33O9ABrCiaeit5KCgRfGEdjmiG0hXEyMTUL
	 4UJTEPjT8xX9ziuDM67+PWK/BthfXdCNdrnTHHwrs6Thn5w8Fv/wDCdTRqVEdTH95
	 KmCyIfBGDfkPwpBnLlRvVadgdNWhgwvnw1zoIY2p/FPTFzW5Kj56EeDHu9nMNqQ5c
	 taQ3HwKn6UinFrJxws4oX8+Wqw7iZXAYEMA84g/ZofCzXt9fPE8Oe8aTbnZu38EYZ
	 Qcs1T5RIqFzcXs1GvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1wC8Rt3h61-000hWx; Tue, 07
 Apr 2026 22:03:21 +0200
Message-ID: <78072b59-ccae-4c48-b5fa-74e0d7953375@gmx.de>
Date: Tue, 7 Apr 2026 22:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module.lds.S: Fix modules on 32-bit parisc architecture
To: Sami Tolvanen <samitolvanen@google.com>, Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
References: <adFuw1E4iVyiXLf_@p100>
 <CABCJKucmXyTUxE6fApftqLOTwOgOLu166Gd_K-JeBqAZenou1A@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CABCJKucmXyTUxE6fApftqLOTwOgOLu166Gd_K-JeBqAZenou1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FuK21fqBcSQTCtmK2cRisng/0Q2ORtwlx0+t0ZVxmJm42eGtO4E
 DmhU7091axZds3GNKSL5UfJMCn4Iy0VHYt8Cjr9tD4D/ZZpJfJWXbl3sWoKeOquBUgmbbYG
 1EGVqRlUHMqd1358BAm4hf+XHcwZlC8xUrT273GfZTYEVLhRhDG9nnPCD4ZXCl6CCPgY3L2
 JRnEOmjuqlrYnXMKTLoTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zGiPa0VK/mY=;5NXrL3SXNWYrOQ+yrylBO5T1zVy
 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

On 4/7/26 18:26, Sami Tolvanen wrote:
> Hi Helge,
>=20
> On Sat, Apr 4, 2026 at 1:04=E2=80=AFPM Helge Deller <deller@kernel.org> =
wrote:
>>
>> On the 32-bit parisc architecture, we always used the
>> -ffunction-sections compiler option to tell the compiler to put the
>> functions into seperate text sections. This is necessary, otherwise
>> "big" kernel modules like ext4 or ipv6 fail to load because some
>> branches won't be able to reach their stubs.
>>
>> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and rela=
ted
>> macros") broke this for parisc because all text sections will get
>> unconditionally merged now.
>>
>> Fix the issue by avoiding the text section merge for 32-bit parisc whil=
e still
>> allowing it for all other architectures.
>>
>> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and rela=
ted macros")
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>> Cc: stable@vger.kernel.org # v6.19+
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
>> index 054ef99e8288..41e13e9cbb9d 100644
>> --- a/scripts/module.lds.S
>> +++ b/scripts/module.lds.S
>> @@ -41,9 +41,11 @@ SECTIONS {
>>          __kcfi_traps            : { KEEP(*(.kcfi_traps)) }
>>   #endif
>>
>> +#if !defined(CONFIG_PARISC) || defined(CONFIG_64BIT)
>=20
> Instead of adding parisc-specific policies to the main module linker
> script, could we add a separate config flag for this and have parisc
> select that in its own Kconfig for !64BIT? Perhaps something like
> ARCH_WANTS_MODULE_TEXT_SECTIONS?

Yes, good idea!
I will send a v2 patch.

Helge
