Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BB1D2F51
	for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785880; cv=none; b=kZ4XYYUykOV7sjsY1L0p3L3ST/t+7e0FQXL1zV7gAvFvz7cwcfQfFutvbhNsReoG962llwHeKDgma2xbZyBtzggsMFV9vUS2iRgDK/rWmn+YdJDHyTwzFXrYXj9SlYXfm5xQ8HCpQGUpVVM/UsQdgKr840seNdGnGt4B0PfQpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785880; c=relaxed/simple;
	bh=xNzO7qOTTQGEuyADmXVfFcDNzsBtnhXqp36UzvFFVE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up89ymdp2ceW3TO+uq9gbQN0oUIfiYqNbyOmEOY7ap5cr+Nr0i7at7SG7Tlg1znSoVHMj4c+HpLz8Ha6EFXEBbL0GJ+4Wq4NJB/XJhRL1HZZ9J8rM5MwZDPRBnYkNjhIGVD21rgN1SLVlnYVoaSLj9jwB2qpsAPwENmWnrVQqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=p7gFyxcz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="p7gFyxcz"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6b3afc6cd01so53734317b3.1
        for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724785877; x=1725390677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNzO7qOTTQGEuyADmXVfFcDNzsBtnhXqp36UzvFFVE0=;
        b=p7gFyxczx+7zdP7P/+Rh7k8h/euUbWV/c6+j94luI2EhyrKbsbIVMNQoNP194VOLBm
         Udh1t2zSHqe/O6UDjd+umMikLrT9CcZrnDEiUtotjtKuh3mtwc5afrvY2x3hQ4mYUyzE
         OE+dL4j4q8pDXdXc1rTMGDR/BMn8MGk0iVlTFfDy+4aVAd1F85zP7oxwkP1wZJqknf2L
         W2t1+udeA15Hs07xj1K9NTMYP1eveTJu1iEq5p8dKr+JYJLlFe9LlT4DEQsapdskM2UH
         xKn8GVO13IVL7Bm1FaACmftOfKgslhKXW2fWYMpENaGRJXh8MIcB8YJEmrGgtv252H1d
         pvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785877; x=1725390677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNzO7qOTTQGEuyADmXVfFcDNzsBtnhXqp36UzvFFVE0=;
        b=jMpBxwFsDd4iD/eHXI2+foilSFGFrXlCLMLX4HL/jEK0TroOczSvDIrxsg1eLLM+gp
         D4Pvy82RYYWZY7eFHsJ08NIJu4uuxBIRbRVW4zX9fSX3uW9bAdYXhiJh27BFSjQfp4Lc
         5yxswhtL2Xcv6tCkyOFP+OC8JxU8RCd2H8qLqP0O4pLn6Uz3uRZt41XtFtpojnp3YC8C
         F6oWaZ2P9TPaczvz0QNnSqO3zM3ZBg8n/vCaYjkpbeO7lJmUu43bCzLvYFOT3kB+xCP7
         xJsUW3tnFEgwc5bfsDuyN7WFhGmRsKL5M/zkeTy190H0fe24w/Qj+aa5VWWnkFJWJG6r
         Cdxg==
X-Forwarded-Encrypted: i=1; AJvYcCVKNVvd8FLmgXHiiioKNG3qF1R2lO5TvTqJvrjRG/RuRR2HRmEyReVBbhA7AdGr41ASJMDPwIxQ+NDAzqbX@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3fXsKSb7mCboPvZQXnE7t4PufkGTILCz5NjC6HZDQsIZTlxd
	Qvh3JyQyzUh0zz+4rID0E90crOCWVSmahLii9Q36vdPEWMtHMXOubqKQaLcA2FH8i/seMkggf0n
	QTv1/nIMglxTYoCzpAojVOTGJXbWrlcanJtE6iQ==
X-Google-Smtp-Source: AGHT+IFvAuIzn1nxkt/URa8Wh42r+pnypqpU85+ebAjYMRQV9X8DnUpctjW9fn8HkMEtDjJXr7rc4KN16ZG+0YDepro=
X-Received: by 2002:a05:690c:6a89:b0:622:c892:6ae7 with SMTP id
 00721157ae682-6d129dbf29emr2279337b3.12.1724785877378; Tue, 27 Aug 2024
 12:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sF1o4x-=wPdy6c520-sCX_+sA=158MMP9c0SByKvwXfw@mail.gmail.com>
 <875xrmxdzg.fsf@metaspace.dk>
In-Reply-To: <875xrmxdzg.fsf@metaspace.dk>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 27 Aug 2024 15:11:05 -0400
Message-ID: <CALNs47vwhV-DRzPbvE22vefaROmjj_5SCLuyQrfKvy=Q4Ou9WQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add `module_params` macro
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:00=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
>
> "Trevor Gross" <tmgross@umich.edu> writes:
>
> > On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace=
.dk> wrote:
> >>
> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >>
> >> This patch includes changes required for Rust kernel modules to utiliz=
e
> >> module parameters. This code implements read only support for integer
> >> types without `sysfs` support.
> >
> > Also, I think the subject line needs an update ("rust: add
> > `module_params` macro")
>
> Well, it is still what it does. Plus few support types. You think it is
> not descriptive enough?

Maybe it should just say 'Add parameter support to the `module!`
macro'? The text `module_params` doesn't seem to appear in the patch,
I was looking for something like `module_params!`.

- Trevor

> BR Andreas
