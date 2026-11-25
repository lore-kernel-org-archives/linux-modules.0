Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638304;
	b=YzoAzf3uxBctkjoad3mh2D6VsPQBHCdDvSjVcPn8I0hTaWmvKzdUnNXIyp/huh5s7XQW
	 Zvqfk38HnYie3hOSbem+bf9kVa/P+dFOPPTW+1OKdUr3T4QjaQH8PSNsYl9rFUYKbFnfa
	 1tQhQ4XIyUvDVTskJytYAC09AsBHlVRmIz0wKA7vf3+iVPz8A/iV6tdII6B5+yBxS2BSx
	 bSwA+QDkhhEaNzahEBg6R+pV2kKjIgs3/fXG8vsqGol9uhu+1sNuUeEWoxJNVIQC0mh3z
	 diCc6O/6NE+QPjJdW4OdexQbGjnPR8KKOgetZUrMnprOfzaBvDOd6T5MrDsMh6LMALg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
	b=qMpD7CFAV577ViP/xN3d6iLpNnRZKNEmBmUaltifSfcFJFEeOyXr7ID+OJiX9n6NVEBZ
	 YbhvBhAUyy1kkWK9dSnr3NFQ25+V6wicxFMXQJnhBG2+hYlETcq65xYoytyLoSWqSr+Ru
	 OU2iTYX+9VoFFtfWo9923YqAVSwy/wJSca45bQzs+UgHfSHdQ0aXnz0Oi6wWks1aj3y0a
	 XRdxdndGqo8VwPottntjIl+dseZ4sD6M2aqASytUofVicABSFctP529vBy5oHc+TS5kAE
	 wPler97pU0RGdUJhYZHgLErca3HheQeE9z6fwQqfKwajneQ+esolJwEK/5SoRr9Ly8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF1606A337
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 20:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BDF1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxpVsnDh
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so61115085e9.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 12:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638303; cv=none;
        d=google.com; s=arc-20260327;
        b=P9OHNeVFCpyhlJwzLcNN1PeNrwMiE1xuUdLtk05m/OLFEwxowHQitP5GjtPZy7ltDN
         0pI1lZf3+n2NlWl9bmSK6fT7JeXsudyOA/B/E+0shb9W1AArZANo+LePKX067oTSmr4M
         +2ok78LL10PDA4QzoespwT7ZxLn7H5praDfDcECbsrDfRmg3bHxnEk0aGS2LdlU8mp44
         H4mT6poDq1FqXMVxmeqxNXb6FjO/zFKho+I03wC1aEeDhrGUxGSuyAOdoxiEDawLZDk6
         9RoJy/Qa0H5nRbAGoVrPA3pfqMpuwxYOC1JUk6fW2XIocoiI5o3XYa50LtI3MMDjZGSP
         k5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        fh=bMgn65d0zoYaD22aAZuT2NjVE9eRtgcJU1MDSYQMCQg=;
        b=P6FyPALjp6Zxj+adKBopE3CHjyqJiUNAwwNxInUmVrqbpib1SZ2qMeSdnNv9VfWvHR
         4rw3WQEErUPbK+1WGMI1m1A6RRopvDb33J57CQCHSOQbgaW1qwQRtCZwWNtamOXn/t00
         xuMqIOErpJnfxEmRT5SLYucGUDmmCQX+MCCc2yentSsTa/91aDFcD9ah1cyPnwUsIlyE
         GyYqtIMLTmggUMCygZVjcORRf4VqCxxH+MfG9Kf09op8m+H8S/F4+pFR5P29XN7/JCk8
         GkcuACFUiPz7AUSFVNSLVxURCNM2KacTrYvMr4db26WVux32MJkp3YfTNG/ufUEfhqUZ
         FMzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638303; x=1796243103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=qxpVsnDhKpASGf9nC11h7i3rrzbhgE1Ei3PO9P37aCNXYSI78K7dE3d/HkpdwHszrk
         LY2ewZzhpWyuiXGJ9Y/kVXRgwoqcZjc+AjjGTm6sKWOe26uegothRZycWdOMEmeKaehQ
         rcee0VmCBD9LHFqBMRGKRgu5+yxn/QVPc8+S1f0ZhA8k/QuPVe7lO4kH9kZ7PLYaSPsZ
         UOhEiycW2Hi29WbdqTe9JB7fMqfgVwt5DLrziudwFU1jlESg26yCSYwEh1zt9b/mn3Al
         7ZA2LJwSY/mdKqaAvIEdHaHjwDhtcY5fLQiXuVbUxvNBi+V1wIvq+poIXwdOZVw4io/Q
         3/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638303; x=1796243103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WX1/mD88zGp/ZEzi3ka3HzLWQtdQebUwdPjAokn9YIU=;
        b=ELT4JlmAaSmk+AZuGHQqgToxotZKZ93//uZuB/k0umiQQwTBYD+DotvEtrGEMbMPY0
         2wKG+kfXYJ0PnDyLF85/zj4YpGHA+PO3FfpFQOBxx73AigV74bShWS8dCEDAkFPMZGdE
         8WffR1ymSaLyRc5myzSraTTIect9nn+mcE27lO5Qo77Yy9EFsVYmSK3Vz12xBPGcb8fl
         CxEO54hvgtDStv08Z+cvFWSdPdV3jFlUGIr7zBzCPP/WbdV0I8CGEOLI2AoJ+t36dEy4
         94HggOvQCprwxAft4gFkALPZb+vwkr5MJsKX5Kym/fRGlyOdTgcSq1Y0gnruexznilZs
         mSkg==
X-Forwarded-Encrypted: i=1; AL+hErG/9yuiAGCEeZjtFK1zatVndAeQp2EnHcH+WrCmvJztPk58Gk8PWcJDOQlmHatWTzlpiI0uyrgEHxc1qySN@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rt8AZl2t8ERCtXSyFn+x1cb/INdDSt/aCYn0r6QoMI6EKgeXN
	1lwytiRrPVMeyKLMko7g05gxUJcIDkGf+/gogtVv6Ga1HRz6vKmPG72SAgHpGCygiCF/XfITojm
	Sxgb1/6UDw24V/NqD9/dqqJqUFrabsok=
X-Gm-Gg: AZFdTZdLy3e9XeO2yS0lroY1y4qemo2R2uqhJmt12uDA3FQo1If0aChdtPJAfkmDQvk
	bPIsPcEm6/RRE3pSZTf3GJprlfxbNqWMrbisD3orq7qutFDZWFF/OzXQ6nAm5aqJ+aVlwjZuqDu
	NKEYdlUO64XJflq3+D16mt5Mk8SI6UNtYst5Fnp3CfRzyKfdRPlHifShyNrpdsjNYkBomK1LA05
	g/+F2vjN7D5pD8lfHaIp9hoSt2kSPAGL8SoEj2GQdpSTGq13Ha5zOwsTRRYdZBmrihGqbg6BxGh
	ix8fkO59C2yCzQlKlcu/KWxkXavwfY/LHoeoMC1K60Bi6jrAV2FxjGedY+MJUhyXO41v3M9fQO/
	0YdFcKPvoOUAzV60k9YoMAW307Ueq5rqOjTQ2HcAMaecbM+7oBSbImercflCuzw6LrnqUpTNeWG
	2CjeIEfsvY0JiHkZsoFA==
X-Received: by 2002:a05:600c:4ec9:b0:4bb:6a5a:782d with SMTP id
 5b1f17b1804b1-4bb88925fcdmr394635895e9.17.1795638302754; Wed, 25 Nov 2026
 12:25:02 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com> <20261113221248.3535369-13-wusamuel@google.com>
In-Reply-To: <20261113221248.3535369-13-wusamuel@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:24:51 -0800
X-Gm-Features: Aa3M54paGFwRi6x8xvkBaed95VaPlmoDIEKWnad49yMfBgn6GjtOde1UijdiQkw
Message-ID: <CAEf4Bzb6LQmHHkvB8WBezU6YRtggycRvvA3L03mQHDr3WQM6mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Samuel Wu <wusamuel@google.com>
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
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> symbol name or prefix across module symbols in one pass.
> module_get_kallsym() walks the module list from the head and runs an
> export bsearch() for every symbol index.
>
> Add module_kallsyms_find_name(), and put the shared query struct in
> linux/kallsyms.h, so we have a more efficient linear walk.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  include/linux/kallsyms.h |  7 +++++
>  include/linux/module.h   | 13 +++++++++
>  kernel/module/kallsyms.c | 57 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index d5dd54c53ace..d31f2f436159 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -24,6 +24,13 @@
>  struct cred;
>  struct module;
>
> +/* Exact or prefix name query, optionally in one module. */
> +struct kallsyms_name_query {
> +       const char *name;
> +       size_t cmp_len;         /* bytes to compare; includes NUL if exac=
t */
> +       const char *modname;    /* NULL matches any module */

will "vmlinux" match just vmlinux? or how can one express "I only need
symbols from vmlinux image" with this?

> +};
> +
>  static inline int is_kernel_text(unsigned long addr)
>  {
>         if (__is_kernel_text(addr))

[...]
