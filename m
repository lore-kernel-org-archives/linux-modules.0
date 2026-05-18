Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3639A04F
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140891; cv=pass; b=JbNaMd8Gz2uj6TSpqeMFWECCrVIRO53Smlv0eyN3wwhh9a9KF2+Z9Y1BC9gUOucTpht/RoaxpZduSelkbW1rGK5WKZhSfO66pLQ4zgCKMjBSkV4P8DMxH6RJJE6ibB8lRonL7ruUAtNcR2F+fZRWd8syAWxR5U/D0XDLDPQtcFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140891; c=relaxed/simple;
	bh=vcGpyDCkEPxmJOtAnIlLle7uN/b+kQjTwRY8mtkvH4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InEEt7uYkNQ4FPpznL7fa/T1GEHFcK43h1/8EGqC1BwHpyE86V31vk07EGBC4h8UaLdDRiKz8APfN4U/od3Tf+korGFWvg17xNx32wPYeQR1Pnjb+cxl0mS4WsvrIzBrlV3QR6185avuYq6Mk8Zm2DoG+oQJ+nCTsOOW+/8u+qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwepeFb/; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwepeFb/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso25a12.1
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 14:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779140889; cv=none;
        d=google.com; s=arc-20240605;
        b=IHDZcS2bys4AojBPYsoHJPZE0qch30Ru+1WY72+BXTgrquUY89PT2DxTym1CtPFM6R
         lvQrBo1pXFAdsfxTbrJ75uGu5xqf1IZR54R30mgggWHCJMgoFFRT7eOzwPF16QT96xtE
         usm0Qfjd/wYtF/xZIsbkMYOBeE+BRtJVQ8Zy1Cnz40hQzqgvg68sL8ukPQsc05eTPfsz
         AAQTP5Ff/PySmowOXr45k+1t3g9qjNgBFv3MrGG2L6HAvRQBkCkF9q90OrwkGQiBeXGE
         KCfmje/DAvsBwhWy6rS2QlKzxX+YPhkYR6mX1aSG5mCXRkJMwIxngOac2/cCd/FfLF2Y
         K8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQHQeR0oNt4z+Pnc26f6DTS/8lDA4aUuHFzgnNxCjlo=;
        fh=6V5PBiYXjX1tfhg3/7glsCeziMiZhDBs74VQIfY5MRo=;
        b=cO73ubDUEHpMZRa0O4gcaOIJ3ZWCcmYT0ac0zhqHm8LroTmf9pP4CwQdF3+yADEm9O
         CmsQq+8YVusk9EzGg8ypsQj82D2CYRw6vxXsjsFJscbv3XzchU3KN3rVA+De7y837Gpi
         KK4a2BGynGWY9uHhJOWoQ55Zzmxb9DJBfhG4+Fvbhxxwjn5SWtS4Qp75lE9RnRO9l09e
         K7EF5w8VbC/f3br0TqbFy74vg++j94SDWZpV7ksE4pQJFzZSdhsr/AguZXnZux8YJn+Z
         r8MITgJiGAwEvrunt5uAVmdnoV9DSzOI5fC8CuVxmRzXXYzyifMO5DFhpb8RRhjOkKBC
         q6aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779140889; x=1779745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQHQeR0oNt4z+Pnc26f6DTS/8lDA4aUuHFzgnNxCjlo=;
        b=CwepeFb/+txQ2cGdlaVzW5Q7JNEjPbwR8nC8FDHx5vbGRYLbgnV5fI/5LwVHOLaYbb
         cLhxGbDlUOGJv9uR6PT+aJ7mPFh1Cmtxp6IbYyhoB59Z4IG4PZAto+iu6/VSpQaWd4Me
         q6/a6mKAdNc8t1dyu+fkn6dFqJZEp6z5SNAdHgRWGjGn1s0gMye8XIBXP19OIKUL95ph
         dY9q2RPZz9uJ70Rj8RItnywUAUkBKZj+L6g0RIA6YzD5wGot5jDxVVxbthInfJDz1KKu
         bD0ScoMMaMVVgrc/cw247LFG+98AS/Tpy0R9HIbozBST5n9+Tc1z/NOjuLpZNrYgawdy
         e6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779140889; x=1779745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQHQeR0oNt4z+Pnc26f6DTS/8lDA4aUuHFzgnNxCjlo=;
        b=PWsRuInEqeOtFxeo8ySU8DJFRKyw+Mb7tosdCFaIRQahk1c/xqjnFsO1R6mHyPtIrX
         RRd7JTi811uBJaFLrGMv4hfL4i3fB8vUTB7ebcqAhNd8LrN6x2VcRlrI/yzpnOZvq0r/
         DRqx2/K+ehyivzvT9tksCuqsyS1nFa+Vah5amkt4yLmKC/55r7YvbT0ZweTRwhQrO1ny
         jQDx1eeRNrLt9EpvDnMeojYk60cpdWCVqLI5aSaA1pZ8egdxafZwrTM5kf81Rmz7TMj0
         28wQDbPrF7DSRqDB34IlG/cANJDvZOQLxe43wIgr8H3iGP+KD3xANDJLV8n3QivkCcpI
         g0MA==
X-Forwarded-Encrypted: i=1; AFNElJ+xPeBWcREM5/JzI8UpLn9PWroMN70O698vxkXc1wyl8z8aJDxfxdnaNrMUGkfVaE4cCKqe+IxUONWPeCs/@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLoUqwsfeujnH4duRXaFPxi2kqXk194+DAtJ8lIgZLcWHrtKA
	5UJ3ptVfPzrq7r5vrWFvIIrJzKva7pb22W1Bu/a7XyXPhjODPczgagLmhByibAHWWV0NLnUbffl
	mm+UdH99kpNIcqSgiiOUBuMZeGDk8aMikbwAEpqAS
X-Gm-Gg: Acq92OEZBg9dTFs9AhewiUGFxSx3nAo4RBkDPDN8yRIy7b8F2M5+j7Wttx/J5W7T7rF
	Cl6+LFko6AENAYTgGX5/6ka+oPFE6o+tKlx3LlD6dx11NGF4Mi/hnnhVunngzBxrBga1JpK77HJ
	iicTdW+apzmIn9RG3t2uqqxLqxUwuT/bzfFpthYXnm7fYykmznMi6ZN9dygUo+ahUZO1c4OKsIr
	EXT0Gcs/qpM12UC+fKDm0p02y3aNihb8ZUGTwO4CN7IoiaIFUQfE6sqRv8xt9E72vK/bIkCmGrg
	ACecOIsFyLma0JE=
X-Received: by 2002:a05:6402:4c9:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-684985e96ebmr100033a12.1.1779140888421; Mon, 18 May 2026
 14:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org> <CANiq72kgM+ugZsRda=xfd=So1UteKVh=tSBxZAq5ETwk2zUOwA@mail.gmail.com>
In-Reply-To: <CANiq72kgM+ugZsRda=xfd=So1UteKVh=tSBxZAq5ETwk2zUOwA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 18 May 2026 14:47:31 -0700
X-Gm-Features: AVHnY4II1hsAU7qnXJS0r6nvoIjs7jvrlB6zhTIpOAt3YFaFZ3d8WtccpA8EpJ0
Message-ID: <CABCJKufx_oCp5c1wESomYBw_ogRsamYRPbu0xbYEZz3sW2SkLw@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer warning
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Mon, May 18, 2026 at 10:43=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Apr 27, 2026 at 10:13=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >
> > Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now =
that
> > the macro is available.
> >
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> This seems to be:
>
>   https://lore.kernel.org/rust-for-linux/20260226120848.82891-3-adarshdas=
950@gmail.com/
>
> Another one was also sent a few moments ago:
>
>   https://lore.kernel.org/rust-for-linux/20260518134107.4114-1-cppcoffee@=
gmail.com/
>
> Is modules going to pick the original one? Otherwise, I am happy to do so=
.

Yes, this is on my list for v7.2.

Sami
