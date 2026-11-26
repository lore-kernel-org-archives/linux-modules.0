Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795713687;
	b=c+g/w/3pnrf/SDSbot50uX1oal2tTM5GG98WRD/FGv9/wfN6MRFxSuadm3cPxNcU8b9V
	 XnRYYcefynq6pCAVFFJq0mVNrncTbpUK4tKBIHL2qr97TJZeIH/qQj6eksnTnSrlRRbMb
	 bvf6dmhwFFK6/zieta/hU1FCdSoLf16XGBRsCcCXG5gOZh1J/xyUMDCxTwKFGwDE2RVmx
	 NooY0LaU10ZKwQ7R752vT5xLEM5YMYz5sltpzTIo7chV+KFONLSs9KlJgSwmts8cuopgv
	 mq3Ys6EW9tfapCMSD23zsi4Xossxt/u4WiAQxFtBIprm2IP6X4xuw5rstnv3XRq3aeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
	b=p7nv60kfY/GU1gBBK+f1kl/Y5EsyLDJ7ExEfycFbzeF+rVAuHNNpntXapPEUvfo5XH+G
	 /NNWmyEAFXuc6Y/rzqJKPV9eRSXYJBf1y2HQ8i1bUbw7QnZfXFRwh/K8wMkRfH5bn3MJZ
	 fqQsTY9BoFatd4JmTZaI6ZCCAkerowmPbBCnyhfLgb48T/9HgyvuasAgA85cRP6NHBsHY
	 Q/WecZ4qT5ckUWaqDkN3ef0BxhQy0eGh8AlqW1Poc8j0Ja2UONudP6vRasCy/wiLVEWLB
	 KBJlbTp1jinIZdwaus0jEO6tZL02JGaT99zU5kqIR8QC6K4d+oM0Jm2jGD5BPKbuz0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh;
	arc=fail smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D61606A329
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D61606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1205186766b.3
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 09:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795713686; cv=none;
        d=google.com; s=arc-20260327;
        b=sBLxpWH+X0QS9W/78GzUEIUC1XEF3yfXNYkD/NqBf/Ec8g1AiD2lec7TPukBS2mBAQ
         7x1j5WmCOvdgQdQ8JUJxOwX+/5K+efGZyhWmGnXCsCOqn5zVlBYhtwIx7jeZueaNXw7P
         rQuAQpYPEbgfbFG5MpAPb5OUlD7E7JjS8hzlE13fepC6GpbJrrr7NkxZQCcjlGMh0u+P
         AHLRNygWcA5Z8Ze5ILpTtDllAhjkWfR8THccNdqZ+I+W+QYP9NTNojfeofPkLBtYABih
         vJnvEW8f9h0UfuDajPUBjAsGt5/5Welr+6ORTzkvgIKk02axSyhPiMVvBpwy83sC6Zj0
         18cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        fh=mLqlWcP42kcjV+C5gXZDsaBk1yb2g6LpmcsU3JBc5TM=;
        b=HDK+eJx6AyovjwThRvTtN8iBzPYCMcCywce5k+hcFViCJg8zR4PZWNhj9Q2E420y+h
         gRdf+CAXl7Kwa6xecYooIyg4HhhbqpoVGkvvLqIvObA0HKReFHBvG3e4O3KzSI+MbyGM
         gxfXco/U1BpZLk5VkTHvHhvjCP9nM9kDX/Zd/OgMJLtTQ9rYoLtaUS842WgI2bhLdDnE
         tGHk/WcR00Qhxs9vdVkSk9HtSR+SpBnQqaM+7W6/Tj7pZmha94N36gJxNSfvh+Bhh6Mo
         XITkvrbzqI7f8+iHPVb2as0QLzG8zjFSlutZ7PyBNZhHdOhyQ8e23ipK4tV7s3f8nmtB
         El0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795713686; x=1796318486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=eAUyELChNxN03tFWhGSn40N0o3gjWO71tl5Ghcmskz8b4PGVkssqVMVbtcP1ufdgYD
         siuET0E8+b/8ouzgAVqs2MIlCaW9vlronDx+CN5r4hENRnHoThYegScR0BXwbEXaFWVv
         vbCqNQk7tkQOJoCj6JvZkgF6A2MrU7JYcLhNOXZ1Xe1EpXiHSTAa8An0988zX+AY8Pep
         2FxXxxd9Yyf1K1seELTv3Pu/d0l8SVkab2alnZfc1y6/i2PE4nJZz1OmTUDwKwoKvPhp
         1ls0QPxv3w/sWpsW686NeXrfa9MjQEe1y8xx6d3P6ciusGwK3AyEX4jEpfF4Bn9DZiMX
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713686; x=1796318486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=c4Ea2GjCg6VN0wNlfgJggUVUfBvHLnfaoe6VBPiZEx/it7qj4CoavUIhjvHWmQZq8I
         w6SKZiP5Bv1L6vOSwK686QqMHKhtTRYITKS9Q033/smboecIpn/QueLa1JXZEDqzUqFW
         sPqMp+eII8bI3HNg3qEp33+XN0toFUjmJEcxR2fLJm7xN8pr3Vr1OMTGSGv7AUaoWH5m
         CkHM4qNGvtYYE0Leut57URIzX49cVzmmIdeuIzyydmafSqFLbt9adp9aq5F0sbDYlBbS
         2qDAFsvc3uDqVu68VoYXkqItEYYRr3sqn/pHje0O28rVGqovWCB3zrM4F0WFRv77GjkN
         1d7Q==
X-Forwarded-Encrypted: i=1; AL+hErGdaJlBtyXYq6IgCrZX4Xw8SUqofznvvmzDFPJ34ZhmbQOGIPMA4mM1V/Rvuinfyj/Lsz/Rd6XDPcxC4sUL@vger.kernel.org
X-Gm-Message-State: APuU4Z95twzDL6e/jO7t1j2HeGGs2Q4NMOmABgygjFm973qZfRSULzdZ
	Ph9X6ZT0bz+Jibl7d+jrA6JPGa4vri+2BWO0/vXVToqDuCGLiZEuePRZ+hpabMM+uRrKJVAy338
	dLWqXGz7wEMn48PkWZaCBgOQBUa0TI6B6E2FXnZK7
X-Gm-Gg: AZFdTZcTqumF6vhRfvKlbdFmaSCNru33fnSrIQktQrxhyfd/K1gT01bdHN4meu6Lq23
	qs0HsnSm5DPeY7AUqILPH2pT4Tg7brfb+Vqf/e2A/6Yb9DS5iaOFCZd2qmHi8WW+q/N3Je8xzEi
	mRzjzzOBHkC8MOYdayDsI+V/QmOQDRPY3oV8kB8p1dXY6yC4opYoY+BX8lnwxdZXWpYDmRbTixD
	6U/pEhMKchwScH29bD26FPeSaFFkX0p/cXqx/vJlAyx25k4DGGzKdSOgDY3vSppxZB4afW8p0x9
	9+LS1RXYyLLbrbQK2NY3J3yhXCmZJeEl9rxQr8jQhdlYYXNQGmXI0/zn4zQ3A80261AV9/FA5QM
	bdKcWwIvLFQJjIjnVz9aPi3+RhpB6REt+yXDVmXxlUA0k1UWH9FQwuvBjor6UQaFMcfI5Jw==
X-Received: by 2002:a17:907:9612:b0:c2e:2baa:a642 with SMTP id
 a640c23a62f3a-c513a8845femr1932673766b.30.1795713685324; Thu, 26 Nov 2026
 09:21:25 -0800 (PST)
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
 <20261113221248.3535369-14-wusamuel@google.com> <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
In-Reply-To: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 26 Nov 2026 09:21:13 -0800
X-Gm-Features: Aa3M54rqUPDLnBBM9ls6-9-k9q7s0wsA5-hr6KgHVGGraAEFEEYG4syBhxuXwjw
Message-ID: <CAG2Kctq7Mb=pb-SFU88eRA1cp2Qt_HJ0nADY5fET7Es-_CcCOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Thu, Nov 26, 2026 at 2:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 11/13/26 11:12 PM, Samuel Wu wrote:
> > To find a few kernel symbols, users such as libbpf parse all of
> > /proc/kallsyms, which is several MB and text based.
> >
> > Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name o=
r
> > by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> > and optionally in a single module with module_filter, or all modules by
> > default. Each call returns one match and its position; pos + 1 continue=
s
> > the search, until -ENOENT. The output returns the address, the size, an=
d
> > optional name and module buffers. A buffer that is too small gives
> > -ENAMETOOLONG and the required size.
>
> The kallsyms data in the kernel can change between two
> KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
> Should the mechanism provide a way to detect such changes, likely by
> tracking and exposing some kind of generation number, or is it
> unnecessary?
>
> --
> Thanks,
> Petr

I'd like to keep scope of this series simpler, and I feel it's
unnecessary for now because:
- today's multiple read() of /proc/kallsyms have the same race
- vmlinux symbols are immutable (I imagine most queries come here)
- ioctl is size versioned, so a generation number can be added in
future as needed

I've documented the non-atomic behavior in the UAPI comments, so users
should know what to expect.

Thanks!
Sam
