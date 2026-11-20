Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203320;
	b=moac7Yp8ntZmLfai9HgwmAj94le67B/0ld/ZUhfbcOwdP8llpK8ogPgqKU18Z29xlo7+
	 zAUTO/h7GFcvBw/UIRFQUY5tvTqvedQZOGTkQ4XScqH7ZVU66gx/itSc+iqgoUYvNYFXk
	 16ME47L5ia+mlvo8H+NI2cfctbMG+BXNfY/mPYOYYuDFanewF3ekU1NaWZu/BVN7Rx+lJ
	 h2Edyb2TiEK2mzBSGz7oUpZpLJAAmXn8r7x08D98OZZnSY2JWGcd+fUTl9xr3h1nK75hs
	 7bvOpUYAjJDOqydshSveyYBmAuMB/ZKhBUgAGSCinBSpOL4AxLkmrGwmpTaxuC/3IqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
	b=wxioWkFgSOfc5p3W0toaIkBKCX8U2ML3oite6IzPGLewCzDnn/ikbTftNHYvAWXVzKmr
	 R6wl7hVmHiHYt8RwkrpqztHJC6FXLhZ1I/F2nOcQU3wPa9HiZN+6inu3IkCJWxHcxfVI7
	 XN//rv4mMfeSAoY1tiMJ6G8LzZ8zQLwnaDKq+BWUxYo/0Kg9t7Cc6rNazKHWSSz8plOy6
	 ClWoHa3xOao8lw+sDxzCtLmQaTvOrGAd19fjpIH1pRzIQtpbUujzcqstkn7pqG9kpu7Ev
	 rLXYWaGNWCfTLyrTumTr4WtfyYXHk22bAmtCa1Zik+P2z4A2+8PMtNgTiVm33fgaM2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2F606A6FE
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 19:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F2F606A6FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40e30c26a4so512397266b.0
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 11:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795203317; cv=none;
        d=google.com; s=arc-20260327;
        b=XQBMQiKn/ffNJoD6EC/SnzUekVcRFn7CFRpc4Oh/Cx/TaJB0XYE0RZq3+xdRnFASZC
         Z2GxcsFaWvxC750M1wtUx/FY+DnM1R3HwbMRP3r6u1em1jeD5WumGruDJb8qRs6ntq5x
         QTbaKSwiVzrC2hS3CLGPpZR487J3OzFRE31vxbg9evGzyLD8FHnR3J+34TlR9gj805jI
         Mwa9YXqffUNKsaAtZONyICJBSu/7sGYRTtd6ht9CSoNXcdtEMLeo4mSpLNQub5HPXjLc
         DZ4wAqmd2yokBLjY05xPA/Cl4BSVLsrOfO54JylPfRZHA11HY8/FKvR2Jh6S0xW0n2xM
         VDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        fh=x53NKBOkaS0FLUY5KcC+Xb+JVi1rhKyfcD6MJkPs800=;
        b=CqhjnDFek5eRPiO98vNTte2xnx3XvlTHqJ5yLS06Dc+Jc6uTrdbZyaNpZVDyzp4WOV
         oX9n3nZpF5bBxTMmKnUwfUPXsGqv5LuOEBETUwMjjg5tARkg9eM0dQjWuCHtP6UFRw/K
         yLUfJ2iBnylLWhJ+dlhB8riqGwnEgf5xMnVxYxSbuJxueHNMY0X+Miax1v3jsxVt6dz0
         +zSXRNC3jOuf/GlrsE8ZQTqtQXtoxfNtLfG9h19uN6fbKRiLD55KVUQc/Cel2Rw8nD71
         kDmgDm6Q27WZ+S/lacdlKPk6LKBgej96joIZ5y0nEGLc12e/P78SAH0CYuiLbHH272al
         2RfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795203317; x=1795808117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=mEayzNdI3RbBXowLZsBRN9QL9E85SiUM+2Zma239sU2Kh5ksSQzTSY0ziLpiHV59CM
         7SYo/SGHf9f/BuaQcw7L2iv8PrZbptbwejj5saAaosdugF+c/B6mu2N2VcFs3P0J30Xs
         iJONriwUSnCKSsvV3YNuTBiMdGh2ko87iKPSXKaspCKEn8Eg4sIKq9PASEMF25S3rqL+
         ikrtvub/lopTx+V9oIV7ULiuNbYeJREQZANEFrs6J/Ra/Ji6BEJHH9f6CAD3wgAgK2ZV
         tPPXZ4d3w3MMsU/kZaH+NVG54K7lHkycb/em4YaaXq8r36ZApv2ERWimswbtCLQ2nAOA
         NkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203317; x=1795808117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=jzTOBiWp5Vmg/Gg0yI22eSo1lDaSaWar3qT7cD6HZKBeIyKJXNpUgRDTiH2F2dOZ6O
         uEAc8gdZvAGvpYPP+FLWTD6wWK8SXi+qEAJk8C5BS1lD4TH5uyVYSqeykxkVAcBIOW56
         tFr7DAUNSh0NtMftwdfLlRclntgRVCmIWDAPQ9qzQ0+GPYChV79fK6YR8avtmdID4FA6
         cniJMHX6qlS9PebbU/i5FJZ0o1qvlhX368DpzpjbpoDg7qNy1K7cgR1jc9Gx9EDlF7HO
         xIWaGaDI/p1tyTYxGNU8JtP0q8S8uTqaNj2NciyAg4WbsuS0EtmI6zYjK4ay27GDaJVJ
         92HA==
X-Forwarded-Encrypted: i=1; AL+hErHIVlL0vIygRb+ftXnzowpTkPPWN2LpZEN2aTcD0UcastYyIddBWkFKlv/zSp87DFdsVU/LufrV7oK3L04s@vger.kernel.org
X-Gm-Message-State: APuU4Z/lS2udPCqIP0dc7B8doi67o+I5DVctl3oPHDd0UUfG28LqIrhL
	TYUhAcBs8g4Mzv72XSnnovth/skiZeT79ct2pOWrLSibOBW8wX7dTgz3jE5qvKUoNuo7H9Ca1ER
	LKGVz5ious7Isnf2LjgI/3gSLbzB2Xgz2OH+ArcWH
X-Gm-Gg: AZFdTZdL3nzcV7pMJ28156dShVuagl3MmuDQ849wE2SUAh9lcj/F/KhXRk+pWmNYvdr
	/Y8eLJR6UpkUJHZEAIPgzCnLbYweQGjCDu8IHw7pu7TNX5EJi2w8suihoyfnWWwHMpQtDrZLSHL
	UROZefe0OeYZ9TSZoxI78TYD2BVQO2nxa5VvkwUwgHV7wn7P/yB0tV+qPX4I+oJ7HIqceh61s9g
	2ppmYreQzIc2SxywFDqP9lHvVdPX1nJ5XYFLbjIo5N04tHTMWxEFnJvUEe5V2wANOTjZXfVpuYf
	AE09g0CY2lzkg/FtE1J7ygawi71g/4hSokxX25/hyQgCtdL/xnbYgNYQbcXLy9rXteD+MmbtXoF
	tt3yyiNFPgxeJFWmgNJ3vv7bAm7QyH/VfBdb6CUHOGbxcdIRM/dAC48djaG/LW5tZJEhd
X-Received: by 2002:a17:907:60ce:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c51317e322amr590730366b.6.1795203316417; Fri, 20 Nov 2026
 11:35:16 -0800 (PST)
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
 <20261113221248.3535369-12-wusamuel@google.com> <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
In-Reply-To: <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 20 Nov 2026 11:35:05 -0800
X-Gm-Features: Aa3M54pZ23SffgU83N8qfNlS7foyPp12zk6Rc2qBKf5ucMmFiR6202xmw20UsI0
Message-ID: <CAG2Kctri9R6b-_OiKcsabdBmLdeWGVY_zmpqqFgDHLKKCDDezA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
To: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Fri, Nov 20, 2026 at 2:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Nov 13, 2026 at 02:12:46PM -0800, Samuel Wu wrote:
> > +'f'   10-11  linux/fs.h                                               =
 conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>
> Those are PAGEMAP_SCAN (16) and PROCMAP_QUERY (17) which are already
> in the tree. The two ioctls this series adds are 48 and 49, i.e.,
> 'f' 30-31, and they aren't registered here at all. Please add them as
> well.

Patch 1/9 here only backfills the existing PAGEMAP_SCAN (16) and
PROCMAP_QUERY (17) entries. 'f' 30-31 for 48 and 49 are respectively
in patches 3/9 and 4/9, where their functionalities are added.

Patch 1/9 is standalone, so it can be picked up independently (or I
can resend it separately).

Thanks!
Sam
