Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795653751;
	b=odi0N8UYA8PSqtIsncCHqssCtMW8czMsiKPEISoFtfZ69sgd4Ke9I7ayThoxEXQ5IdV+
	 d7QAtuULyMtlyHInXehQPtgZYx3o32CrXPPoUsyMKE1mZU1hPDOjIAV/qqQkCX+sqyotP
	 +YvWBKV/PQMGQ+DWdwPAdn4amgOXCOBgsbo3ZJm43+KwkHc667+ESZtAUSGaCbysByUmx
	 eNPSPUOVUMb83U5jhvSakMjjamErWy+CXXEQ15LRII/8GEKUbijki3sDcbgvgNLt+6oFL
	 2381omyfVwXcTezN+ovZ4x9RAV4Odo1m7Xfun4kAYkGEUXsyhWrm0Vb032huJkCpprw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
	b=WXeYZwQ3Sn4HvlX7NqwlohqiKdBRpLyJPxc3VEtl24HIxRgJy/e2X1+b054IHL0umbl5
	 pfZQPI9VxoKW8FVH6rPsuCrHTcvNogeUo8QxapA2k7mfeHPCliYhPtpzwvcMGLtBCyQKl
	 A7U4DC2PEnKT3jmCm1Ask/SIzkUQNQsAwewHzZl0/WugfYFUMh0U0iMCQmQIyjPwJN0hn
	 yxT99rUEr/7BwcLbiAWLRP56NXC5C9RT5idgna0n06UWsHzZyeEjZQ0RbWm2hJ68ndCAn
	 fHutxwwfW0DjhYyRTP+4ioSWZALgVrZ2VI8SbvHvFutQHACHtWdp1kBHxHafBn6QxUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE7606A32A
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 00:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6AE7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LpN49+az
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so109261066b.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795653749; cv=none;
        d=google.com; s=arc-20260327;
        b=M45A9ZBkOqYQ++d2P2FwWxdp1XBWm7eyjvMK6C9MdACUislCfiFQSQ5OhSwKmUKgvm
         e9ukJF4sbEE9oVII4Sz85MTAX3tUgFbEoNhr86EhPypPqdj33s0izCNeTzPCqGFcn+iM
         RlCzNnNnBtVa2tHw1JVb5ywohfkcsau+M7Wizn5bTgi894Bp7BpgWtCvyoPzNpBuDa0g
         a3APqSGCEkgOkpCNsPhRzaSifDMCt0EmiwMDMKEuCgdiKpnxYygDkajJiqSj6QpgyOKW
         Iyn8lgCiZUvBh/D5llkP6s3GrHHam/q2LEOh/I/pybxHj7Nl4uQASEEZqd5wxcfkicun
         HyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        fh=1I96IkGpBqqck9iRtJlwZLO0ejayhRAylMspb/WP92Q=;
        b=ibpgRIWjIzK+CUZioXXQrjg6vegKJYxajXViTqCG8976BPD2yuMtSSpouyCteBQAbq
         ISr77ef78P3Man5m7QaV2lS+SZB4d0LoJnzvXNbTvRA+SyJb+bqAdGccCqzBHDCvcaLx
         bESdwwkiteCUgZv05mQYHHa7/6Nuqv40EcG7nzVFlR1h4LU4Ac8yHA211dBAoaVnB5nB
         FJBBIgH4kiDx0/9AQ1thZcm71cVcMnn4bxteTk3d0mUgB9h+wUKgM6+BZx5VPpfZwn+6
         tm0nWYC8/ncR8ceaAh0K1HoqBF+Ul+ILH5UIHVVd2obfXYoOGZYHvGMc03fWZ74dqznQ
         cAzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795653749; x=1796258549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=LpN49+azCIrNLot1wWdZkbi4Wt9+5r7MX19ZP740YGH95NjHPkEZ3J8iTn5nZs2aU0
         YtfDizzXcozDLpMOLK52IGL19BDPPkZBwwaARaxU027w//2VU6VirePpo9PC6B6/Gvyf
         w2GVoXFxRvXbXsOKb1KJ+C3LWAAUbXNTn5yq/DRtNMB33KVLBN+E7CMg2n3o0WEACasU
         2Rm6jn9HoFPOXbo7vWifWbukhD/T5j5US9xUFhxajKYt4rvNrF1rO1KNwomR3ZLuXZ6w
         QUOmuxgTXoYSvlHBVpUm9Y0LfNn1TpJbekKTAn/WwvKBAhjn4jwfG9HFJEBd61cyDiFr
         AG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795653749; x=1796258549;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZhRPRVq+8pg+E1wbTr8QWwirSLbboBqk1ZBZKkJ4bPE=;
        b=qr2XYa8P8MXBVgWB1d9LGyRRIDF2n4IZpcf/ruVf9Dv5wjMvBE09hB61wbaVvE/QRj
         QcE/K2JiAxfVtJWxiMDGNBIa3cVp9hKzP0YejicOFjknJ2sJ+jzErSnhnwJDb+ORujKE
         QBOBzY9HsdX68LthBVmhRLxX/8e2ZY5RB4TNZYPUc4JTuLLYOqbN4JilqeKfDscsrg3i
         +Sr7S+Xy/Yem8Jmq1fw4LLnQ7nrmvHR+mcO/K7DJKu2oGCvGTQ7tlW7+lnVNOUxG9r3I
         Q2+BpTZgmAQOn5ugxlGakbK0/FkxveH2nCGIaL964afCPWtJbevpG8hpcBYM4e1wwl3K
         58kw==
X-Forwarded-Encrypted: i=1; AL+hErGR9rKZQTGW8XZM/2CoJknIvBfDJxfJtaXytxk2vdhKpLB4vBJNunp+vfG7f/QnLdZdjKFiU3ecpjKi3ny1@vger.kernel.org
X-Gm-Message-State: APuU4Z8tFAmwnDvrr8aBOch/uGqJGOfVqcrBi0xFMXMzU3Xtf5nxLbLr
	mVkgiLwIdDnNReLaESy5i82wsbrk5MZEhIr1r6VHuWwJUPneLSNguaBj0AZZmX65cd0i1C6s/cQ
	1lH6aI6ypiLA+xwGSy5GK0jvi02uaeX+AiBjBKV22
X-Gm-Gg: AZFdTZdfOaSF5grehVuZhBJ/k8cWVwUnN/t4VSLKZP6YGFoyY4c33lXJ4VuxLAeGcrb
	NZG85oe3Uk42Iu/s3JxxyTQMBb0FeXpzfGMgcHAM6iQiPyydEiVceTkYv2cOFCOodg9t9PPvCuo
	WH11w1PJT1xG6h8fDnTOJ5LJIm1oIPuF5f/odD/l2/EnTUJW9kTotOFYOifRoGSFgZWb0gYY4ek
	eGlNoKG0hYXZFwmUw7sEz0gbxarsbYAN7aBRRpzzDf6Y91MozZ3v/oJDpw+k4QcOi+uEpgzkCXc
	gQTRZHbSEfn+PXmFJPAXkSpR9qd0QdnYbGBzTu/irKeCFvf7rv1FsB/s4jD+8QAbiTBlj7pk3LK
	s35ANGtCZOgYjjubWJM9nZ85MD77K5NRTZELY49mtQEzD0G4CgYlbxdL7VD4lwoVrWbhwSwCKCD
	huKHZgvp2yvFwb
X-Received: by 2002:a17:907:da1:b0:c50:5275:fb97 with SMTP id
 a640c23a62f3a-c513acb5e2emr1626085466b.47.1795653748662; Wed, 25 Nov 2026
 16:42:28 -0800 (PST)
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
 <20261113221248.3535369-13-wusamuel@google.com> <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
In-Reply-To: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:42:17 -0800
X-Gm-Features: Aa3M54rYVczs2SqMo55_UQYl-QiaJqAFTx0CS_STMdfssfUbqw_TSopd5IfB7RE
Message-ID: <CAG2KctrMMo0j9Mnbg8fdNsSc-eQaaaW51dO4mqwVNn3hfSdx_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
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

[...]
> > + */
> > +int module_kallsyms_find_name(unsigned int *symnum,
> > +                           const struct kallsyms_name_query *q,
> > +                           unsigned long *value, char *name,
> > +                           char *module_name)
>
> Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
> with similar names. Adding module_kallsyms_find_name() adds more to the
> confusion, being similar to module_kallsyms_lookup_name() and
> find_kallsyms_symbol_value().
>
> I suggest calling it module_kallsyms_query_name() to match the
> kallsyms_name_query parameter and to express that this is a structured
> query, as opposed to a simple by-name lookup. It might be a good idea to
> similarly stick to "query" instead of "find" in kernel/kallsyms.c.
>
> Otherwise, this looks ok to me from the modules perspective. Feel free
> to add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
>
> --
> Thanks,
> Petr

Sounds good, will apply s/find/query/ in v4. Thanks for the review Petr!
