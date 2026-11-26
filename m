Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654102;
	b=27h7XXZPzXp/2YQ0xc6FssrbOaEh5s7GRXQYBwV6Y2t/UO4nnF/BX5oukXYdFZ3zsKl+
	 sFGB9io3gSyXgSnZJJbkBNUpW6xwAF+eR+wdlCG1bjeQZ/mmSHIFEvUwA6sqTrCxaD7MZ
	 Y87VE5ZW1VyTrga9AmFzQh0edlWnh0otohXr+6hqiUDM8JjMwxFeSmjeEbX9Ud70K046j
	 LmnnrPDF0sBPCZGt2W+bBQdskqol2VmBU/DhUjQBX5fn6OeBdvFFopCC8FB7zDO6dfBKm
	 f1hm5i6psMePMhBg210oMawsFyOgELgxZmd50kFDLszvoAzkdAphoEPaReUJ7nLbt6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
	b=gyZ6kF3xAhg28ChRwc7V2pAvAj2GrIlhMJbQTqat9Nbuh+vW7i21j+qKw8KDE09V0h9J
	 7ONpe2oCwP/nZ87ueO7HoFQLHRAVc/s3OLLZBhrjtbhkZXbHsNxgLkLEoU/G2RpKVgtoJ
	 R2tFFEVdDtCJOG7fgC1lRtliryb8Z59HEZCQNeYZNlfeQaHhaF+ygUzc/6PEu0Js6hDQg
	 gBx9yVWvwvjQNfiSGvAg2pzrwIIvmX4blxGYnhoCUqx7hxhOU0IuuyUyLUflbdb+qqkYI
	 851fzU102K4BqYV6ZWH3VPtOM52rdBBXVGSxGsIts4H+vN3XZhH8Pp4lZJPwM+FWbeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C64606A31E
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 00:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1075211666b.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654101; cv=none;
        d=google.com; s=arc-20260327;
        b=MPmw/mMnctkNziivRlQ9MMWkTKf87GRaR37LEs3MFi6j+wLNc/xnjRBroT+INiEHbj
         Fjak1sVl3j197dRWd9iDidAIn6wgEuw5EOVPjCkhDIESGJqPBlNHW6vfQq6bMWORxi9L
         uIlqIeWBdPjT/F2Qg33kT98mBcr9eEbQgpG/hyHqzYoaTgvBAVMqy437urm9E8vif6Uh
         XHM5SqRoX+2H7wBtPhL0wFdBthDbBPg7s2KIG4bZjU5S9weG4KOMyP+KTEpFAqGchCrH
         AtyYmaIrmp+yEMQgQSk+t53raJRsaOIlnPKp0oxLVFBTWtr+FLPaPlNGHbqAZHjf/BTU
         4jmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        fh=cmANg5mNebXWASdM1yg0Alomhg3ebAlp7oZy23aFeMo=;
        b=V2bmyJo4FR+8233Ig2vU7NjxHIF4EeNUr7ncvXwuB34njRSnpzgL1rNx+mNz8JzVqe
         ZntB9FM2IRy5NjdQbc1+tBc2pLmuQrHBJxT90bmP2YOj1O1UkjI1mqYeUoGBKIn7f2Ij
         vSXH5E6LdeNRZHKHyPwgdZj6SzfT9CcOtNTitrq3txofWyng0Yjs6cqGVWdF3PpJWVIY
         JKk0pkULoEluwWTdlDhzoOexuP//z5tivY0UZ/r7pTdQQ15/tHzF9u8u4ZXA9UYxiy1u
         YhrszZ7dtg78iX5IfL8sAIJt1418pi7ek+JcyTIdrpek5Vpi7OJ7L4zfw4N33LsTBA1E
         Tqmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654101; x=1796258901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=QWMZ80CzZfH6yoH4sucNVvHTrwf1PIcC+Bp2zpQDOXhvTaLR5/Hb6aclEYP0GJ5EbO
         tJUXzbHm5a1lhC/Ax05U+ZOxJaUnTui2Rk4msdPfixijvZGIv/STMD8sdmvdk0JLoPML
         TqbI7e+F27OvNQ1L2QOdn33Qfg3eLkeqAwD6ryOf7vQH0q2dc2f1o0EKha9CE2cwglDJ
         7Sd/maZlmbFd2u6vfPe4Bc4+mGU0kS7nC1KhuBzJ0BY73ENkc4VuiMfat2qIpNB6JRsB
         QZjOMEBbuY0eBgGxKWFhpFa0ZVGml7Ayw5gVKKOPjRvn3VcvJm969BGQaiZe0I0XPK79
         1ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654101; x=1796258901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=GLYkn7IDRZYEgHbcpYx+xnDHd/SNTqyN+05Pk+M8LyvBHAgwwHRpBei97Zzf0Muc6D
         WvZe62afk6hXUjdEaTTlGY0pLxWqHBjlvTdCUJleCw1s/c95wBzJCOSAcRKkriKOghMr
         cQhUTe6iwLZ+0W1UBlPRLHScy0mCsM5X7AimZkw4KKjedcPv6bYa1MeS+UNDtNnc72WE
         XwBdyjCVYi2dvRLo17CDn/e6C1Cpv+sjXIJ/6OCR4QcR/kyCsW+X4xot3VYUh68FEKa/
         iC7De99ehB/ylp3cc/MlT1HtbdHl5QskZrf4f0Li+DpVrJf3VbKr8VRoujHAjcmb/xdE
         QI+Q==
X-Forwarded-Encrypted: i=1; AL+hErEJl2AxNe4mimr8XIBAzZPtROAwxYjuN2EtMy/pgdCGuer+uE2EHA2xapBBzPJvV71jXLyPr57zgmpSLR0f@vger.kernel.org
X-Gm-Message-State: APuU4Z8B/8dOCC7OlAXCn0AG5v92GHvAMAxyiuZ/nF7FNtdpodhex+Nb
	V9u86DYbShZ0+MjyyHRD7Yobe8L/uMGWXiFkYb0tvv2B2sXbBFULqpHm3Mbdtfd+Hi1ME+Xyd1W
	6w/Jt9Tu6gz55rDwmipMyYvNx8cogm2F4nYI5BhxL
X-Gm-Gg: AZFdTZd0WpHAZ2TWzNRiYu2RfNR76e9iczV2+WD0xoBJKnfd5s/nQLj5iTFfsMKRmd8
	ss2qnPBF6A6w+ydIu5FFacMJxxZxmAC+uRws1kWW1sTo1HYzfDfcRW3oEpM+7BR9Pbi49pihaPO
	MdgjPqaA7y4aGytymNFgnA5g0nD+CqvqY9JNaISpwK0yWf6jJFn7ptHTFXtmqUWCzguNicr/K9c
	70u/VRKP/ZnV1mTQ2vcM+K4QWpFEtQXTEKeIomN18diwADCywis1LmG83c15YI9Q7AtDLLgstEr
	SYOMKFLF6n75ltEajR2yMT8dcVEwaZIYb94y7JjwzP7z4kWpoVUOJAxldY42yvYGPOHpjYJVmej
	CDdWEr00YpH3fQA4rQaSxJzlACr1i9MgGEm+quRwgX8oNZPYsqxIwkAuo/Z4QwGy1mHI=
X-Received: by 2002:a05:6402:1d4f:b0:6b7:f106:3419 with SMTP id
 4fb4d7f45d1cf-6ba37ed40e7mr16523342a12.43.1795654100281; Wed, 25 Nov 2026
 16:48:20 -0800 (PST)
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
 <20261113221248.3535369-14-wusamuel@google.com> <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
In-Reply-To: <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:48:08 -0800
X-Gm-Features: Aa3M54pWdHazBU-AqLK5TiYQKtZxCNreXkIezAAKXNEVmmWGCBCO_8U3jzAUf4c
Message-ID: <CAG2Kctp-XoiK-Ej3eHWnYyijydej6Bw5sLKNNi-S+xEGDB+mGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find a symbol by exact name, or by prefix with KALLSYMS_QUERY_NAME_PREFIX,
> > + * in the entries of /proc/kallsyms, except undefined module symbols. vmlinux
> > + * matches come first. A module_filter of "vmlinux" selects the core kernel.
> > + *
> > + * Each call returns one match and sets pos to its position, even on
> > + * -ENAMETOOLONG. Start with pos 0 and use pos + 1 for the next match, until
> > + * -ENOENT. Use pos only with the same query. Matches can be skipped or
> > + * repeated if symbols change between calls.
> > + */
> > +struct kallsyms_query_by_name {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_name) */
> > +       __u64 query_flags;      /* in - enum kallsyms_query_flags */
> > +       __u64 query_name;       /* in - user ptr to name or prefix */
> > +       __u64 module_filter;    /* in - user ptr to loaded module name, or 0 */
>
> similar to the comment on the previous patch, how does the user
> express that it only wants to search vmlinux image and not consult
> module?
>
> and naming nit: query_module to be consistent with "query_name"?

Passing "vmlinux" selects only the core kernel (noted in the block
comment above, missing inline). Will rename to query_module and note
"vmlinux" inline.

>
> > +       __u64 pos;              /* in/out - start position / match position */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> I'd name it "sym_size" for consistency with "sym" naming, and the
> comment/doc here is unambiguous about what that is (struct size, not
> the symbol's recorded size). seems fine as far as UX goes
>
Ack, will switch to sym_len
>
> other than nits, this API looks great
>
> [...]
>
> > +/* On -ENAMETOOLONG, *ksym is still copied, to return the required sizes. */
> > +static int kallsyms_copy_sym_to_user(u64 usym, u64 usym_size,
> > +                                    struct kallsyms_query_sym *ksym,
> > +                                    const struct kallsyms_sym_match *m)
> > +{
> > +       size_t copy_sz = min_t(size_t, usym_size, sizeof(*ksym));
> > +       bool too_long = false;
> > +       int err;
> > +
> > +       ksym->sym_addr = m->addr;
> > +       ksym->sym_size = m->size;
> > +       err = kallsyms_copy_str_to_user(ksym->sym_name, &ksym->sym_name_len,
> > +                                       m->name);
> > +       if (err == -EFAULT)
> > +               return -EFAULT;
> > +       too_long |= (err == -ENAMETOOLONG);
>
> nit: if (err == -ENAMETOOLONG) too_long = true; is just as short
>
> but also you are eating any other error, maybe write it so that
> original err is preserved as is, not special-casing ENAMETOOLONG? if
> you get EFAULT later, original error still takes precedence

Sounds good- I'll simplify this to preserve the first error via
something like `ret = ret ?: err` without any special handling for
ENAMETOOLONG.

[...]
