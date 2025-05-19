Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF58286D65
	for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673881; cv=none; b=t0qPB5W/ymxCfN6+0WmbPDM955D/ydqebEtN7Z5SO/lQ4rHgAHgqT+cVi5R23CoSwBZHskT7KJI/Avyw1SP0n+J1wJUrUTK7lgU/79dy6x4dfv0ZHO9HFa+xd1amc6uRfVu+KR8hjzcaTg016gCYIQ+CkwkziLOoKOtErKtQiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673881; c=relaxed/simple;
	bh=r6ISo7Bdezx8pW//FQkvGipbBI+YOE9Pca37dhR9eqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCoDmGzz2XSKLHtmR0MVY25TTbthfQ/UVyz/j3RiqgkMc0rGvnXCSYh2sLLJf8q2GNnmLBNFDKEQhuuwTsQaJw84WmbV6tt9UbnJjasNFPB8KsD8LsP71KcZhoKzWgc83VLRjHgRu5i5lTKe6WvjpORFnywLpvCDbPJ2Leamj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBADrWpS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBADrWpS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47e9fea29easo814021cf.1
        for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747673879; x=1748278679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H//Q2/k0U/bxWK4hAN7S8ohOo4uWoLiyXOyReNaLkpY=;
        b=yBADrWpSkMakpA+QNSQV3VE8wE8Ss8KOGzhbO8KCgZ0t+c1uD7M0XiyiV1XOygEuqf
         BpejeApKtmrinEmw9ZFMdNh84rP2cFJaB0Yda2dLMcdewJn22QS1GyCqXLXR5TctKZI4
         ikPkSAEksQXWPnhBGn6fQq1oXAI8S+1Qj2DafIxkESDJp/Fx8+tUj8PGThRZhroiA5fb
         nuaLKXCC4PnkEwWd8y0QIV5/Z3Xvn5LEOEtqy9YIeFuhQR788OOAe5c2fjhAJPUTHSp3
         J0P+V1aUPOMFWjN/2DKPi5mK40YxCK+t+rDCBB11XGRtevnH7Z78U/yFhd0rkhZt3tv9
         dDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747673879; x=1748278679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H//Q2/k0U/bxWK4hAN7S8ohOo4uWoLiyXOyReNaLkpY=;
        b=T2oMpCWa59wBgsYPx7d0fGaHEQZUxGihZynvLJvKWoHCXQ12c+vlapbuGo7kTiIKYf
         y8VYc71A8VOTJ8Q7bVHYVCVC9QYx2Ab4pUhy6J+RIRBsjYg9AlbYlrq6YRszv+Gt+uHS
         0+15js2lwdFKbiyclRfiAXGtBfAhPpfLR+7BB1lBJ9926cU2MKmv5aSRPG43/IfT11mu
         tp9zyC4i2NQlOEFFfpUKfGY8WvPtqho6sNQX73dlKaTmYR0laMStbOBY54AxL9fuDxTV
         mO3ReVDsrpC+pc5yon+wiCQr28Yh9xa8l/NdOAu3brUmTrV8gEHTF+kYP/6ZpBKgKj0h
         20sw==
X-Forwarded-Encrypted: i=1; AJvYcCXcByxWdsIo4TPjOq0y6H4EGYInvj/Q9WxL8DYHYYkGpARIGfjmeWuR5rF3VUH0FfNPG/wLamzmRbJhaDga@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqwdfhBhuVOR51p2EduZmYaf6BSBHOGIoka+bcY8a/cUUdGj5
	PdPwc4dVooFvxsa01moKwlIliO9z2PaJ4w44G0o08BUf62F3cnBUUj2N2CK+DbgR2VTBMDNle/X
	3nMbzqzmnUAgo4Qndu2YMnG2tL0N9UVug/xDAFrpi
X-Gm-Gg: ASbGncsJSMhu8ibokfRHapnk/b6FPc1Q0FD2rePjBkxJmEtmNrct/vHfyndHOA6kkBZ
	BKePh1qop3+CSl6Vi1oTstDTfW+4qQLQaoyloQ/3K6uBvnyQdDoXCtFpQVZwc9xJtvQMocNik1t
	NLk+NFNH99gM972HoqWJTh/Me4L0E4mTE=
X-Google-Smtp-Source: AGHT+IF8sFbhe1lBDyTtsq0AmZROP9KAhFo8XpiyLcElzavRh5qezB1QIrU79vI/a0W4h9IpzLoXJpJHPNtU9wzb24I=
X-Received: by 2002:ac8:5f83:0:b0:47d:4e8a:97ef with SMTP id
 d75a77b69052e-495ff5d8949mr7638091cf.1.1747673878410; Mon, 19 May 2025
 09:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518101212.19930-1-00107082@163.com> <20250519163823.7540-1-00107082@163.com>
 <CAJuCfpFzhroY2hm9o0sWF=NUOuyWjUhnnyFLoPYw-sR8MFEptA@mail.gmail.com>
In-Reply-To: <CAJuCfpFzhroY2hm9o0sWF=NUOuyWjUhnnyFLoPYw-sR8MFEptA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 May 2025 09:57:47 -0700
X-Gm-Features: AX0GCFsPUvxyPNAFYs_469fMSBr3-hVnPuM1Rcdz3o8wVxBiXnQnHLsCgYWQ-vY
Message-ID: <CAJuCfpEHvSS+UUeRpk1Mr8D+cAii_DiXTJsE5EALMRC6nUmiAg@mail.gmail.com>
Subject: Re: [PATCH v2] module: release codetag section when module load fails
To: Andrew Morton <akpm@linux-foundation.org>
Cc: petr.pavlu@suse.com, mcgrof@kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:46=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, May 19, 2025 at 9:38=E2=80=AFAM David Wang <00107082@163.com> wro=
te:
> >
> > When module load fails after memory for codetag section is ready,
> > codetag section memory will not be properly released. This
> > causes memory leak, and if next module load happens to get the
> > same module address, codetag may pick the uninitialized section
> > when manipulating tags during module unload, and leads to
> > "unable to handle page fault" BUG.
> >

Fixes: 0db6f8d7820a ("alloc_tag: load module tags into separate
contiguous memory")

> > Closes: https://lore.kernel.org/all/20250516131246.6244-1-00107082@163.=
com/
> > Signed-off-by: David Wang <00107082@163.com>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Sending to Andrew for adding into the mm tree.
>
> > ---
> >  kernel/module/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index a2859dc3eea6..5c6ab20240a6 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2829,6 +2829,7 @@ static void module_deallocate(struct module *mod,=
 struct load_info *info)
> >  {
> >         percpu_modfree(mod);
> >         module_arch_freeing_init(mod);
> > +       codetag_free_module_sections(mod);
> >
> >         free_mod_mem(mod);
> >  }
> > --
> > 2.39.2
> >
