Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7F13B780
	for <linux-modules@vger.kernel.org>; Wed,  4 Sep 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483120; cv=none; b=La1VG4Dvt+kOjZyS3Vn/J4d+G1gVFEEKDhbtrmEIdl2utSLjjHtqzvNql/8VUFqPyWR1FKKEydBoW8Tz7Z1Deb5lS9QVv3g6hVWfi29HzlU2d5aOX37gNUXA/nmSlkoDIZB70GzThVFdqP0B9gpwUMK9Yy8xr1vGYOzUkbU5xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483120; c=relaxed/simple;
	bh=VEu8lwhgjRv28++UfFlI7Q85Fll0aPf4HEKrWKfuyIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHUdxTu1qx2LMH5so+KZYUvN4HZUvrrRTMjB2LXQ7MkAgE7DaZnatTr9N25LUJkam03LyYzCmnmMmX+ZP2hSBy9dqub5iziDvzXX0sgWq1o6plk7bxO+HAg7hpcRedJDbhd4wTHVTBrsSAPCywvTToU9rE/GTrPvmWBu/I+Ng2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugRN2aDI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugRN2aDI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4567deb9f9dso22781cf.1
        for <linux-modules@vger.kernel.org>; Wed, 04 Sep 2024 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725483118; x=1726087918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHG7bQnsGZf2B0kptsJNBpltOovSM7V6WQ5dy2HJTmw=;
        b=ugRN2aDI7E+J2Uu5vVg6GyivqnrccH4jBK7hFNCvIJCou0NguMywd/xMsmrIT+5tRm
         CLBc0hPYynzKTWqJff74+ldbzD44q+8i84y7TALTFYSp80nP289T7zCOjGlEGkExuLif
         PxLeIPei4BDNiisp9qYmaGzVNW/bkUdmEWu4HAuxLGg3di7xHYm376eZN76FrJZCxj8Q
         RaM8Th3Z1Nuu7OzpzD+AdRM0viEzkDpJ748ndLg8x/KPkbvH2MAtZJXME7lJfwnteSMh
         iGBkOjhoNTYenD1ArgvVxDFPOo2siSMVTkAN2PkzunYqMvRu4JkUsDEzcpjVpwCW21jr
         6i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483118; x=1726087918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHG7bQnsGZf2B0kptsJNBpltOovSM7V6WQ5dy2HJTmw=;
        b=kC4b/h8zCsZ39yKX63DwjfjQbxf8O7Wwp8rr8F9kyOMKZe0nuu9ybyNuj1bbhu3+EE
         BxfunyUgcJb5btHxtrTlcl4cRS2BD3FQitShocwUwMUMQuh5xlbzXOfo7eu8J6/kfNJD
         vAGv9ZFR/abl6wyPJqUWqRsTmtXSm3MDZAtxJ8i2hWDnC567J2Ub87X5RozCi41qhe9N
         aLBBkCUemF1nBsHH88VnlE5oBRVQXahRPBQoBk0CUSORf2pVhITBCBhZXUgZc2+mmc7J
         VkjEx8sZOvEjbRcj0fiOGKtUB/PKVYg+Ez3Y1ILzWEo/XaxYAZFy2T8aWZBfTS4+Q/Ly
         nzcg==
X-Forwarded-Encrypted: i=1; AJvYcCUs/ERDccmoDxnluNeqjAFX9o0ddy4TRgccrDATtLRuUfuG+dJvVprjS6IH+hcvDaSSBZpreSQlFc6JPT72@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzRnR1Jn7ipEbu36cuZoMatmGRfO2vQmfHUrDDlQDr4AjXDdn
	3ZQnhLgt4grO26tW78SwQ9sXNPG03tC02wEbRGLsqwGK/B390P2u/36eacIWdo9ezO54cH0he0S
	ahQS3+ZoQZtAyyEWpaXhbgJJlA30Si+6XbSsX
X-Google-Smtp-Source: AGHT+IEPmGqrm6+korttValUScEVXntGBxadK6A54rTJrxJ0IKgJZvo9hatZFvSKLsYoMlB9sNpfgYUET/vFucdBRiQ=
X-Received: by 2002:ac8:57cc:0:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-45801deb0fbmr961551cf.4.1725483117896; Wed, 04 Sep 2024
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-23-samitolvanen@google.com> <CAK7LNAR4BEpehbYtQP3fw1Gt60EmSpzTEj8BijWKNCAi41fyPA@mail.gmail.com>
In-Reply-To: <CAK7LNAR4BEpehbYtQP3fw1Gt60EmSpzTEj8BijWKNCAi41fyPA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Sep 2024 20:51:21 +0000
Message-ID: <CABCJKuf140CSbNm_9D1NGeMuRnZiGytnV8fawnwsWwhvGpYpLg@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] gendwarfksyms: Add symbol list handling
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 11:00=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> >  /*
> > - * Symbol processing
> > + * Exported symbol processing
> >   */
> >  static int process_subprogram(struct state *state, Dwarf_Die *die)
> >  {
>
>
> I also tend to regard this kind comment line change as a noise.
>
>
>
> I think you can squash 02/19 into 01/19 because
> this tool does not do anything useful at this point.

Yes, that makes sense. I'll squash these in v3.

Sami
