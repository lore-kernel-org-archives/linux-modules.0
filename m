Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2F345749
	for <linux-modules@vger.kernel.org>; Tue, 23 Dec 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517852; cv=none; b=goRNKL8jANLsYcZwh4IXBvm9/LSmwg/gIsmJoN6mE38Wq5buugYgZFjJ0YR98TA9iLK4PHfraSWpSL6vOlkPxpZFSFMbZMLFgR6RVSLxRvysYwrGzOLRWdCAl/m0J8FMT+hFlS4QR7ofMEQ5xwZu2kRkdOMMWqjZQRohQqpyIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517852; c=relaxed/simple;
	bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKYEPj8KsBclkLkOUCFJdYT3/X7GjnW5JWKM0k4ih5XCD4t67S2WCDPg3HRliq4t2D+6nXutmuQ24v0FRFomAK/xcB8F6Yjo4TxxYpnHRasVXNFO3ccSYhECVYurl9BdMk5uUsq+iNMiESbErLAUIS0YG4wstl8KAs4XMUTCQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMHhWAoH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMHhWAoH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so52087935e9.1
        for <linux-modules@vger.kernel.org>; Tue, 23 Dec 2025 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766517849; x=1767122649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
        b=dMHhWAoHEY8bLj6yKeFcAj4oWEcBhr84c9A8UsaxRDoAvt7gIx6PEpM9CcGD6Xw7V+
         nSuyEivDT9ro8v4KncN4H7t+fnNEF2KIazbF+XnQ50BO/gzXm1bP1kRQXYt4Lbg39Dk8
         ziISx2RCJdFhgwwwiG3ToK3g1Gk+aE8ph4y3pWTZabLqbwqkh1W7xmNjVIq6/Jn3IAXE
         a6rFkvt2x0B1+YYsgn3KEOSB5MAILSVWx5J9QGIuPmG3EOHwojKBTRixlbaBoAf/Hg6O
         Ll/OoMlaIlfkIdEu0PzoxZ8z1Qwxbvn11mGbIpDsu56h15TuGi/OMGa4anxWikxoa2OE
         kLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517849; x=1767122649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
        b=wDU7UXl4dZuiPd4mttxG/Fy3RXDEsRQ5HwnyjJtcEvT7wIYYxZ4pCQD+W61yBx479+
         9CZFi43BEiiau588FG0wlR4tMnJolQYKSnRyQwyAQzydsI0aIcVqz/QVWnCH5KtyNxVU
         oiMxyAbokyJ5VB2yw1/FCRPFd71ktNR5qGjg2fade3yjj5qjyX9yN5BWbLeHWTVzwetw
         EEPusDk7l6yLjU6fk54MszaCh4Rs2ArnWXfTLXv0QwdnwhjllEhiT/JeD6yRE3s2niBk
         y+6bO664Nw/+aoOzD9Rrkj+PnpE3yCrViQzC7eqpsXcQ/D3AUUsTP8SN2/wRy/jpxLOw
         a85A==
X-Forwarded-Encrypted: i=1; AJvYcCUVz44tOXEElbkqT1EzqFguX+I6wBvmU9p8i/OS6mtvQ2tfadICmbg0ACHE2S/Dh1odVwlUjhtMcieK1AT9@vger.kernel.org
X-Gm-Message-State: AOJu0YzGw80I6pu5AYodur54WZytRrDMenZBEUCgkYhtKdmQWD9AcQTv
	0RZNfgkxrc31X7s7Pr5uw+rufYSodCegMdwLWAj9R/H/D5URb0i+MZDpFlR4e9FkjghzcjgIKDe
	9H+5DieaL7yEMikG7dDW70SAf3bp1Pcc=
X-Gm-Gg: AY/fxX56He0L11nnFcQjXxguBzyMgZyZabT99UjnEUd/HCLOj2gLtjKOIeveIlSWfP2
	djoSpy6T1wlOqWLuM3XDgxUHoJjHhpoBQ2dzC4mXpq/pl/vIScs8FCo6EDGHVihkgpVBL+4u6bM
	u+duRC8iPiGk9Bp9bzXaFPu4nPwLMjpiwDqBAUnJ/k7RUuURAUGs55eNqeBGQDisJQCmz0+i0fL
	bhTqGOGJLSASG2jKWhDsAppYeiu8mVzRs7HhiLA4wznj5VSB9o29ijBhinDCWqh4wz0izdH
X-Google-Smtp-Source: AGHT+IEA8N0l7f37xu5fuodrmydJdjU8BPqUpk7joEMKf2v+HTz+VBQEMv8K8hO4h1IbRN6r+aIM0AZTsebwkuXeaXM=
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id
 5b1f17b1804b1-47d1957f7cfmr167023245e9.20.1766517848747; Tue, 23 Dec 2025
 11:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com>
 <47165c76-d856-4c5d-bf2d-6d5a7fe08d43@linux.dev>
In-Reply-To: <47165c76-d856-4c5d-bf2d-6d5a7fe08d43@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 09:23:57 -1000
X-Gm-Features: AQt7F2paAUP67eAz86aT4EZ2zxYpVE22u8U7q7vZXo758q6RP0KM0jYtAiwhChs
Message-ID: <CAADnVQJAmb8NFWFCgpBUO9wT3NTzTJAd2gH1cs3rpLxAK1WNrQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: crypto: replace -EEXIST with -EBUSY
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Lucas De Marchi <demarchi@kernel.org>, bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 8:55=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 20/12/2025 03:48, Daniel Gomez wrote:
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > The -EEXIST error code is reserved by the module loading infrastructure
> > to indicate that a module is already loaded. When a module's init
> > function returns -EEXIST, userspace tools like kmod interpret this as
> > "module already loaded" and treat the operation as successful, returnin=
g
> > 0 to the user even though the module initialization actually failed.
> >
> > This follows the precedent set by commit 54416fd76770 ("netfilter:
> > conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> > issue in nf_conntrack_helper_register().
> >
> > This affects bpf_crypto_skcipher module. While the configuration
> > required to build it as a module is unlikely in practice, it is
> > technically possible, so fix it for correctness.
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> > The error code -EEXIST is reserved by the kernel module loader to
> > indicate that a module with the same name is already loaded. When a
> > module's init function returns -EEXIST, kmod interprets this as "module
> > already loaded" and reports success instead of failure [1].
> >
> > The kernel module loader will include a safety net that provides -EEXIS=
T
> > to -EBUSY with a warning [2], and a documentation patch has been sent t=
o
> > prevent future occurrences [3].
> >
> > These affected code paths were identified using a static analysis tool
> > [4] that traces -EEXIST returns to module_init(). The tool was develope=
d
> > with AI assistance and all findings were manually validated.
> >
> > Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
> > Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41=
af01f@intel.com/ [2]
> > Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modu=
les-docs-v1-0-361569aa782a@samsung.com/ [3]
> > Link: https://gitlab.com/-/snippets/4913469 [4]
>
> Even though I'm not quite sure that we should care once the core
> module loader can adjust the error, the change looks ok to me:
>
> Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Applied to bpf-next.
