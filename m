Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574836;
	b=0hxsjdAWl2B4AxUB1uIWOkTkQbDjM0Cwz5C3mU16w5SWj24p5M0Nf0+pWw5SHOLVdXcq
	 EGy5Vo7RPGQ9ziKv0TAPHx1cLPEb4Uhvm/sl+Z3ACmnbTKNWl+0IpeeVCAsjFvtiC0uBi
	 ccltii3sAkS5GNfW507uQdGiZCFt3PDGvegpF+UrMnDwsdgKv+1uIzZmzB2zsOn93oWu3
	 wYn4MBjSRBj3LF9gP7bsw38lDI+zy+RedPAY6RXBfmaK+qrncS0x+c4ToqeFvZfQnlw1L
	 VYX3cMAA2opE4idYpw+eD41eiblNu7/jlqEU+LXWCaNi0ntPuCG50zMs8NlNP70s+Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3WktpqJ5RyI3CKZt5Qq1knYJO00EeIPHV/UWKkNJ8JI=;
	b=tRSGT2YoqQk9Dzl37NWCFlCVeBeO8h8OlRxb78m5WsObhgOPldbdrJS9RSl2uOTTyRBd
	 P64+KT0UDIQGT3aztqDDGBCtGgAjuEcw0DLgxHi0wxjpnrjR9cQ8L3AEgtC0YfDhJF8Tv
	 6fzFmUkgN+w1EL3YskIqQhBX4HNWe4QwUvzObTZFdfnHOrXHcIBQn3ZltrFgcgCn9a86y
	 r10R/37aa+VEQL/Pxk0R388snj5SzFsFvpem26D4bIII4EWTWmm56hB03fa9kY2LfyRUn
	 Sm2RpbASzsNPfDd4Ua6tJ5e4B8MK4VTy7ACbvoV/j0dj8KzNWv6uOdZrqtUQwhVy4Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YBDDcs8p;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518B606A32C
	for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 09:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3518B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YBDDcs8p
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c5358fc28so474080f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792574834; x=1793179634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WktpqJ5RyI3CKZt5Qq1knYJO00EeIPHV/UWKkNJ8JI=;
        b=YBDDcs8pasSEaUlXkEiiTM2d6cgU0ncsqBskrHkxT+cjpIoXdGlzToAp5m92NFDAuY
         Ab+9q4LBs6wrr7qdgHw7yxx5NoX9pf1IHGzP/Ka0AoPQw1J2mbGx27T2Nh7ibtfC9Dme
         1IA2dItfwSiFEOh7mD0/N2x/4evjwkOoh2Jp6QXn7yHEc3dmmQT3LL11XXqqMsAvU6zC
         gaOYkjO0hJTC+sA9zzZVbV0PD3BibJQUq11PcXynGLji2/jEdSHcUfD9Ur8nRL0wiguF
         qLO9JtBIK+8tjvJx2K1I1De5NKwiRind8gCHaqnYA0y5zhuDRDsMV/PSJ/KPU9IgvT0R
         h/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574834; x=1793179634;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WktpqJ5RyI3CKZt5Qq1knYJO00EeIPHV/UWKkNJ8JI=;
        b=Ps6jgimxKlA3LpnGE/OY962bu8ofZkS+GgUMi4XzuW0swylP6b96mfjf4VuH3HIYB6
         ytX0U13688n8ZGyz8gp7345Xo8KjdPS704sRwWdIGBFk0OUjMo+VgOMZXduol+OwmtWD
         Db0exJbV5PQSfMhiaGc/fLSgaPx8v/AXur5M5Oir8D2Ce4sAdopkMlq0NsAzk5xkcGxj
         zfs51Er3wDPjHNzPhZ3LBEiSRCuPZyJNHNt9b7mjIs0ZGK9FwAKkIL4spjTe7fg8cdlj
         ZShN77lZX1AqTQRMQUxSrzMKC3Fa+yhAg4u7AV/8myIKpK/M6AZn7eVkkXAPujXeTRer
         vwsA==
X-Forwarded-Encrypted: i=1; AKwUvBwI+UrHyPQ0FVL7L3B2Kh6E7/AI4moM8459kHc4XPdBoesNz7b50bdrbDXLC/vZC+6cFrrYFdyo7eUG0MxF@vger.kernel.org
X-Gm-Message-State: AFq9FYJNffTm45aFY/lNk49CX6ViYfhcDLqqtslO5a6yVQvNjaqvg71k
	o/qufvFoh6102DdA5y8n3UARMW9YH3+FYQ4EBoFSmsp2ytyxkZzwQt32tw8XJt3IkdM=
X-Gm-Gg: AYBFou14Hh6SJ6bHLNwo8KVCfGbgBPargBHMvBNvjAqSihpEfkIO9TVsngRrt9CjF50
	gw+OKVccXMo2TJeLfHt9qCQvZGvmzVUMYnw4lfVOn8GZjwqc6+IeG2S/s58evZeKhkdqeup0lZA
	TWKMv69wzQUwc5BAR0+Yhiub7/SCYu1vLd35NesTDBtgdopWIUtlOWBH80MCMvU077BDEeMWljJ
	hZXClFv9L9E4y7NclRe09+GBS8ZkoyeEG4TLZ+I5KgFskYt6TVSNZIdCrGofkEj5JYiJYQp+OdS
	8CWKXXyng1l5/5MkPfqoBNYjn3dwFDzLxXlLf21hLmCxCoCI/TI3F4NugwmuRKIj8nJUJKgIiPn
	TE39D3ZFf9Wf9H50i8mTKY+Bk47+jJFS2A/ai+kwsCKf7VzRd3Wvq+E+cTWppHU/fFS33LXZ7oc
	lWiRqF/uSvFmoNz4RagbnB00Jsx5uoGjgMW6J45gXBozBekjM2gmgUEm3VZFJvI7188Fp8Lc1r3
	WyZMmdijyO1ukfPyaqqbmqQt81C8GoVylANfOr+Kc/Xp8JW7gV4IrnV10s7MSPTbIbnnCrMCsCw
	wjfv0c8D14GPC1lL
X-Received: by 2002:a05:6000:400e:b0:48e:b62:d134 with SMTP id ffacd0b85a97d-48e2642cde6mr3031305f8f.6.1792574834481;
        Wed, 21 Oct 2026 02:27:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25b04883sm4370211f8f.0.2026.10.21.02.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:27:14 -0700 (PDT)
Message-ID: <0736f8a2-4f02-486a-9552-dfec74032fad@suse.com>
Date: Wed, 21 Oct 2026 11:27:13 +0200
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: exports: emit ___EXPORT_SYMBOL without C
 declarations
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20261019151243.1595858-1-gprocida@google.com>
 <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/20/26 9:22 PM, Miguel Ojeda wrote:
> On Mon, Oct 19, 2026 at 5:13 PM Giuliano Procida <gprocida@google.com> wrote:
>>
>> This change defines `EXPORT_SYMBOL_RUST_GPL(sym)` using
>> `___EXPORT_SYMBOL` directly:
>>
>>         asm(__stringify(___EXPORT_SYMBOL(sym, "GPL", "")))
>>
>> matching the `__ASSEMBLY__` path in `include/linux/export.h`.
> 
> Hmm... It says it matches the `__ASSEMBLY__` path, but it matches the
> `#else` path, no?
> 
> Cc'ing the `RUST` entry and modules too.
> 
> In addition, I wonder if we should avoid hardcoding the particular
> form of that `asm(...` and instead expose it from the C header. That
> way we avoid repetition and getting it out-of-sync -- that was part of
> the original reasoning.

It should be also ok to move EXPORT_SYMBOL_RUST_GPL() directly into
include/linux/export.h.

-- Petr
