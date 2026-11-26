Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653870;
	b=0zjN7XKtXbRJ8c51zJ1lEAL39VH0Ft3FQIuzyxmD1g1D2B7dKVJOcrLzD1oNZLk//XxK
	 GJU9eMV5EYjjaZytQzDuw/VuxTkSM5QBRFjjCj3SiT2CK+0uzlu75NTvpPgKvGDnW5JmS
	 RG8pfcTLIs6JOxlJnOsJeT8nnzZ/lbA+mIn5Sy3xMgbJEA945NCfYIxqxq8srVpI3m0Tc
	 RLKaFcLSY/YVCbBmmVCoYz13c8YV6oxIOUHey9tAySqPb0krvS54dNEt47XW8JEamulaS
	 UQya18YLC6uJg22IXmcZ6Ek515X0wvVOMk6ni1NshZtF++VJdiOZ28sdqks04GaqUzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
	b=gU5lp/fhchDNdeB+4imiZX2/uk7wRyUltdTm0oUzDDEQR9F4El1B9ROtbsL+jkI64phk
	 gXC5fBAttIYDqzRbIMiN5xh5PnjlDuV1jlrZYW/5UVaSFW9oXJtbHXPnif0InivjkXM0b
	 j5HfYVvhQztdPItKuPt+BshR8TG7LGCZZKhABsvVt3QAzRPCKP3yTYbLawV4tlwGRsnF0
	 vMBSCesMj7dhMtYnRo0d9Ni0GcBjKXRjjM8oe8ThQ4AEBf1BaNMXT0tIj2ubrBvf7RuLs
	 v7w+o3Ca5ae3dK5xQBfRfSlQAiDf7cGWn5/v/Y03giS/dQatdyppvi4kW21Uly1l67g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E82606A31E
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 00:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TFVWM1nN
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50aaad19fbso710160366b.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653869; cv=none;
        d=google.com; s=arc-20260327;
        b=crLbwIRD9TddlkYrUiIfpQOXmcFUi7tqHqM2opsDHL1WussiLwDFo66iiU3vgCn5qD
         CzgG9R9suBBm84FZq0A+/rkv1L1TNsoIMHLD7019OomF50kmmqzmiAglM0riTSAlZDbK
         GTtjY1yqRBdrA8Kyef+8Lak0R9srnnHdT+w4jxQQA73hKasFe2RZKdfOTdfSZSuAv32U
         c6NJNOzY/ZT6n6PA5Lz8ZPpv6Sr3D/SRb/mmIDHZtyd+XazFz28+4t/zE0cUezmxnm9o
         Vzm3qEXM7lIzcuTuzrN3djleALYWoOplVPaT1NheldP3JiZl5/Q+zX76+JoiX44OczTY
         Nz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        fh=ExoX5t9esrm8jccfgChlLbR7FMD948kvTY0TGPqer7A=;
        b=Og18BNcSe+RnJEl9PRVqipab2GwF7aNzMlxdF755gSPbZP7BLhemZHP0JuMQIf3xE3
         1MyXWGwyR74TmLN/HqSL0ptUF+IrehRoD5aJ8nwNG82vTFU4kUXXY/U0YHqpeVLaeeBo
         JDIMq8VfWW0561K3lv8wnILewtuDz0/AwYGytkXfmTHFKpgamA+vQemtPv6q06kg/DuL
         WdsoSC7RHRXMFIZoBuwVcGUi+EEg/jVLTB1ou9dL1fOAcsVL+LwkGj+r+f4KW5wpytnK
         n1vSwHGxFMJjxtjgENw2bXIBb0lnGpy4kIx3tsn9V+FC+GSc7pxQk8wCjP2VPiataZ65
         DJdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653869; x=1796258669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=TFVWM1nNu5gApS+aRUNGAO2b47beOviKXKAUtZcibEAeTqBUzqYaxbl/Ez5VQvaHiJ
         TXrTwu8x0jRe4t5Qky6cuxp9+qXTOVpIHPYaRTuFvweUNvzRuyVro3GhlyImE69z5l6h
         8+10BUgXaVnSQdQJL56ogVd0eoghwHYtJzCo3zCbsQwT+vD3SGCXtB3FiXNUreuGXelJ
         f7VR1BO5S+hnTUr9vyAHKXMc2Z8rg1qIpqzDfb7vnBqg8zVirP17bCZUWs0HZkfhTJwL
         aGZZfKvpUl1Z4/v5oLfuk517qMaRDnLShKckyF1bvlHNxOJLhAHLt0pu9I70jGnqlzcF
         ZJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653869; x=1796258669;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iVFnQD3imnTlv+9jxnHkNU96izoDIFXplUev078ijIQ=;
        b=0WUrAooKKXIj0wiczSpq+eHHx9GCHMIBLz4eoOwiVXfvsm0ws6lI86X7SuwdkubBUS
         3BOc6sfonCIKrehZuHp1OjuCZ+hMldflz3TTTy52ONnMkWob4Br+JASDMkHbwPyCcG5A
         RpeeO+JEIich388GkTDKhBkCoQ9pYwckB2trqMBMcjJs9UaEyMhlur/CvgR7ltx4O19a
         R/GkmZBcPCMS3MIP2jE0EEFdJlOOIOfWZ8SyvQ3leIdoy12w8H2JrlQqoePbMPo2fwc2
         0c7R+waav731PtI/ZB6W9o7/FY7m0Tkv38q4AT6983zsA8NaR51P2LX6BnvEx7B2mPTs
         tUxw==
X-Forwarded-Encrypted: i=1; AL+hErH6qOnyzw/T7Qa/VtVel5qPzCSSS29elADwkloxUfcK8fDaSKpeSBpIauzJsZx3kXn7Ug+JF2vRL12MfxKg@vger.kernel.org
X-Gm-Message-State: APuU4Z/HNxaZctqMUy/tHCw6mQL4924TsRX8QIcon3K+Bt6/V/dGiii7
	BQV+fMe29jd70s1P7Jg6rgKPbyrXV5TE+ZCANiOE3gGCC1d9/YO4gZh8bfE3vfgZsQV/G4SXF5Y
	8NOoKN5JwVV7+EznIiHKEBFfKGW3WhMYcCC7OsVN8
X-Gm-Gg: AZFdTZc3/1COJnAvIe+RgB3jCDrvSeBTmaouuN7VakCI30cG/zYDUyS0XNmNJBRVP2X
	WwRVbzvnMMOFxczozWCq1adoEmlraDo/gQqS210p8Z5iyrfWWHsIGZJUFbgbTjMAlCsnXFsMB4w
	lnMdgvM1/1SxpOP3l6QRft7/KAiUsODD138saFwsYcSywYyR9Wm7JHl74FQh0w72O3yTH8E0lSK
	0WVf9jDYX8Vuu1h/yOysWhY/EFHDwWL6Gz55EPjw+7LVTb6su3SoN/5DVPEKKmO0N9X/jP4x6yL
	437Y9t6lCKWElLjdy//XBC9B2bwWFJhTElq/kNUid8SeKBWnCi4df2wKLbWVnWWpxMSTqcEFPzb
	OeTL9dy63DpmPPn86SCNvS0De/Ygh2cExl95wPwQHnvJ4x++NEPrE+qTeZLYaxKX0abk=
X-Received: by 2002:a17:906:6412:b0:c51:24eb:e5ed with SMTP id
 a640c23a62f3a-c513aabb094mr1147878466b.42.1795653868573; Wed, 25 Nov 2026
 16:44:28 -0800 (PST)
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
 <20261113221248.3535369-13-wusamuel@google.com> <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:44:16 -0800
X-Gm-Features: Aa3M54p3EatRpTsPAm_mcmxJ6hPDpQs1114Xl7F84nCmfTvZhGsQScuZoJFkxmI
Message-ID: <CAG2Kctr+6-EESkYn+Dspg0FxTOMFRoj8269UZaNNDFNf3d+bHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
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

> > --- a/include/linux/kallsyms.h
> > +++ b/include/linux/kallsyms.h
> > @@ -24,6 +24,13 @@
> >  struct cred;
> >  struct module;
> >
> > +/* Exact or prefix name query, optionally in one module. */
> > +struct kallsyms_name_query {
> > +       const char *name;
> > +       size_t cmp_len;         /* bytes to compare; includes NUL if exact */
> > +       const char *modname;    /* NULL matches any module */
>
> will "vmlinux" match just vmlinux? or how can one express "I only need
> symbols from vmlinux image" with this?

At the ioctl layer (patch 3/9), passing "vmlinux" in query_module
restricts the search to vmlinux without calling
module_kallsyms_query_name(). I will clarify the comments in both
patches in v4.
