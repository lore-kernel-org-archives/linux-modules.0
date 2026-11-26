Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654191;
	b=0gTe6xTzEgXa4O+gxfOHrxoRxs3oPiKi6Kc9API0y1hpbg0m55GA/A2MhdJC6Or8y0Pf
	 F86kwvtqpe7w+H/2Fn9NA/NDDiSTBD//3LdW3g05cBRahcyIXuqkbE6h1ERKUHZjWoGc1
	 8ZY0J/VkMcGAB3nBOTpDKi8yIBJ4gc9ZA8Ioz/kelci4TNVgMnsw5J06c8lJuCWgwygVb
	 zpD2nsJfZVrkALDbqRqUmZ7lZzpCJQ7p84sfOVUZZ1w5SdAU5vWP4gU7xBwc7OTjvO6w8
	 M1Kq6sHmwV5pN3n/HVJfz5f7qnBzWGUNoYlCbaMkTohEAVWO6ky4ZzBtxCfdypUi+Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
	b=3P7yKVQZMz748tpxrgRmM85Wf0BCWOjXu20ZfYSIpuelCHT0hnN5OFyVPKLfc1PKgK1p
	 w+J2K32Nlt6WZvCzrDpn14ttENkVNniKlhO2h2nhgkjSft/fzhtGMvxh7EGFAfvSakLF+
	 BJ6qBCwk9OxfSugzh/vwPuXL/CXkNh2VIN5xAi8FSSqOxtFL/03Zl4ukFJp8gZ7ANprfB
	 V7Ta2CUD8iY3yyNwYyWjL+0pxkXhW6YqC1c3rVOShjOGAU818GjaRKAHxa0Z8m9J+v+/F
	 b7q2PKg4VerUZSEpXdB3CCW6ocXEKsmIaAAzbQhVj4OPPaI3sTx8XjdvIrpe4qNoetA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED9606A326
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 00:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EED9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TD3ha0rn
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a574bffso106805466b.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654190; cv=none;
        d=google.com; s=arc-20260327;
        b=DMmtndgrn7xUbxejFeFk4yJmSVPXwRCfrUYPU+cqUkeHObF09i3z6qSsSYQMXojXB9
         BVsYuWsA2STSr3H+s1aBMKkItMfVKT2gcapRLce7eLjwpu4w4ShAHDHfh1MBwqOA3pss
         77P6lgXjgCUTIBHZCqM8Wm80f6smbyDvQY2NfVSL6ZOzf1yjtqIqLrVrdrFZXW3KC4yL
         /wrblpvO6ou8KeIQNiSkwyLMiSSDQ/e/c6UDR3JkZsj/KQ/C9IqaRO6XGugrR+gy+cDA
         /1x46gooIAq6kc7BqcSYhUib6xkuDfUa8jFWbw5jti3uFJWzDOsZPAiyd2kUhTIlwAem
         Wttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        fh=rr5twWRsq364I+Om55AeZ2Qd231AXCMAObJWFi5JTQM=;
        b=kjIjMC1s3FVZmNeJV7IJw90+HcWFiRQqE1YFkBedp9+xPhnsCWHRjbuD11IxWsBJcW
         INsB7eSn8elv3pLohiLqexkaRM/uaK5q5j3orZv+9gUejsJnnf2cRo+aC/lUyzUOVT0P
         MDEbdsR7LOa+TJkjB0kZ56PSrOht3RwFRgtzh3h636x18xz53Bix0fVlRHuPr7FftBkt
         aYdEkJXNQal2lgAfdrDTS4mcclTXGUyGk93yjDEVkBb34L0iaKGTxwnnpbJwX/nllfuv
         guXGDwKm4b9VMKyehtRwmJ7Uj6KwP9nJgl5iwfAScyYMJJuKwn86nfGOWsHmV1r6hFBf
         ZYRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654190; x=1796258990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=TD3ha0rnSCMzB6EDdCanCIo2aztnTVsAWrsh8HrG5Y/aRrFlN2ndLBXw880f1YHLZ/
         QSfxPbJeIna1/g4lWyiIQwpwJD12i4G3TGAPhErD+7VvOdvbXoNFUGW/sZDUdcKc+k/U
         fLW/extCpKtDduL/D3vHzyoVyDpb/98nn+tR+abZco9jsGFWEFngZqgt6TnMkhRshp4B
         KnHYS7XEZFGjKsHdNaQA1fEyq68/xePBost3IMRVEVegEsUL5tFkIeCHeASNeG2SkZb3
         JP9uGCT2U7VP0g68JLBP9wLuAWo5qxzvzbWaRKXYpp5AAo+d01ZiPGTRjL3TT/PoWk+S
         RpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654190; x=1796258990;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3xdrz/ADvfzRdkROHvxiyJcnHZIhgxNZVfYGWmlfhc=;
        b=I1N+UfUU6/3dRuJM5Wc+HfD7LzFunPPMbkHokxNzGRSUL16Ezh1O2sE2eRgBgPI4mB
         skUJiaeTCMs1KtjqMnJVym1ptMXHJ8HvbQ0GPBtzNLj04vlLEn8LbAe3NJIybb8wbWZ2
         qjzfbooJdjRJLLVe8qBD6rXl8U2IEToz+EWvYRZ5FrmsXVtzz0bKY6v1zDF2tK4CS2s7
         VujSaabkw1EjiowssmDTEpnNW1ic+xJ0iEeSgI7vZ+6va1vo5kNLneRiyKYYHurGqSy+
         Bk/HsQDFJO1oMNHwr4HWLSQ8SYNpVvkvYr31LuHQZosdYHYNhZozLUlUNH3BuoKTfXoO
         xmwQ==
X-Forwarded-Encrypted: i=1; AL+hErFmEoEhGKkzu9nRwQR7B9m66kH2vdbZuBiv4F/b54OYqK/pAeHwAjuTO+HduQmaU4R20pN8uAtuUN8U17vH@vger.kernel.org
X-Gm-Message-State: APuU4Z9fCThYaYR/FgqXL6hrMrHq+iLKcJ1UV8WH5fRtywyyO2QtjBmS
	l823p0m+ixQHHGvD7YZ73KlDO+Fi16ZYF1xqO/M6AYz4AlTywPmCI0p6G93384CLjOtCkCqj1dE
	/bpUegKPz679u2POevD9JQmn2mYWmAiDG8asmznOt
X-Gm-Gg: AZFdTZc2Ryh5d7Q5yWbWAjCwMtH/r9We1q5owocz/xSR9G7POad4ftZWbs/DeuHSLT+
	VI2zCMzGNaqe3lVMKGFinEtX6TkJ/iUPq/yMmYjGS7cUX7+ZL0C+iOwsq7F+REJHO22uoqP87F8
	XJMNu+RPmQPMQPjvGhpNkJd8AMqFFFljy+J5uOExt0RCOVgdU6rqHmijEssKL/41CR3n5HTNBbu
	9uduyT5UlMLn0+m6qagUrYikrCL28utoVSX/5ur+2vu/o5H+EHJDY4PnB4d8EBRPNBEN6C+KXhp
	rV5pvOYTtgMtj/+VeU3bNrK+RWQJ/wrje4vIOcFosCxAXxjw+m/TkeJDCDuQflnCK5AqgHTMtQb
	f/e5CyzE4kgEt9TDT3Djda6PTEKClgVCFmEiSlfdjzFX2bCh32NgTeEIvKaoNsizj0/4=
X-Received: by 2002:a17:907:e11a:b0:c3f:98d4:dfe2 with SMTP id
 a640c23a62f3a-c513aac21bemr1112327466b.18.1795654189395; Wed, 25 Nov 2026
 16:49:49 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-15-wusamuel@google.com> <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbdGw4=yWxFqdFuz1U7RBSFqh7baJX=SpBNJJqnaW5P_Q@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:49:38 -0800
X-Gm-Features: Aa3M54ol7ULgIQ7PyJ4MZUA4jeAQllgic7NBQxD7ZgZ6wx9FC8B6-VKox80ApLQ
Message-ID: <CAG2Kctr9Bg+4uz+cKWw79S6qFRPtW_PRDt0rFY73F6WpauXG9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] kallsyms: Add KALLSYMS_QUERY_BY_ADDR
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find the /proc/kallsyms entry that covers query_addr, or return -ENOENT.
> > + * ftrace trampolines and kprobe pages are not resolved yet.
> > + */
> > +struct kallsyms_query_by_addr {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_addr) */
> > +       __u64 query_flags;      /* in - must be 0 */
> > +       __u64 query_addr;       /* in - kernel address */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> nit: same as in previous patch, I'd keep "sym_size". But hey,
> "sym_len" is even better and follow same naming as with sym's
> name/module, no?

Ack
[...]

> > +       return kallsyms_copy_sym_to_user(karg.sym, karg.sym_struct_size, &ksym,
> > +                                        &m);
>
> nit: if it fits under 100 characters, please try to keep code in
> single-line form as much as possible

Ack
[...]
