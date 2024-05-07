Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1E6A8DB;
	Tue,  7 May 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058970; cv=none; b=F2en9R5fwoP1FevybSKhaXrpLJajtq71oQz2ZxsLjAoWfNuh9D6+Zn48pH5wKoyFx8/5amQcJccZGmef6JjgJmZKfyHfTKhj/7pprKDEx8R6gjwExtjDUJHdDXvEqkfxORxR3Jjph42J/5ioPf7iboxwxRhZPBm3UaCjytYzVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058970; c=relaxed/simple;
	bh=i9DHeWX7KXecasXvAhYHrRVaJGI4UAUdfJll+Nk8yww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctUEsEa7GElkNlt1npSQRNvBjU94pE0TIaIGqPqR6+k0tGq5p6oI2UQ0Ob+gLYlSl3gMJQugADQEMTJGOyV32GJly7eqLnVA0zsaU8HvjfKSWlmn8QsIrjg9yQx6C5qAs1/vUaI7mYQbz7bcDFeLyrfTymwQD0+N8Gk6thbXR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRu0NbWK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRu0NbWK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62036051972so30094297b3.1;
        Mon, 06 May 2024 22:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715058968; x=1715663768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRRN/6JR9vsHlrdWS5YE9S6ooRxHV3XoqORdpSSw4eU=;
        b=SRu0NbWKF5FKvYi8NHOALyopQ3mzhXGZ77ANmfB5DRsmJtVgUOLMhFxw8WIOYwiWna
         DydkFTUUmjtdtaoVIK1+P43Wg6ZTQB9gj/GLpvacxl+EWxB9iVw2s9nXhAG+Vh+O+y2l
         kw2th2xq8v8UUC8rGJRdSUkP2D5P+K8Jzj5z78yJMRLf7yJyzeQ5B38e5jZYx1ChRJBU
         IE3jpFvBxv9R4nfUCu53Pvd3fGs8x7mekH00PAeTkhL/bPGkdRu6EW60iwNQDADDHKY7
         5xPG1OzgL5OAVQXmEJM7iKif5t0NLRWedPFbxTIis8oYmLA5k26faeoK+j2sbGpFBebc
         R2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715058968; x=1715663768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRRN/6JR9vsHlrdWS5YE9S6ooRxHV3XoqORdpSSw4eU=;
        b=UIWDxM8qJn63V2DD7wicB26RYhrzaNs0Y95zLOYb+4fpI+x6lw/BqZsfawN2kqEGJp
         6PwpRCzyoLSHm++h5Wko1kInNwOviRP+IawVHxkpMUR+HX2cNHCcfFxoparotpTEU6jO
         CFHypeTWXE2yobtyJUnUSgdbPozN39H/ZljrLOML1eqf4gw/5oN9nMd+LTqM98CaMhBB
         tF57M422L4+ArdYv7yL/XFDy9ujyntuRN0hAF/rO8U3MdJrDRKgKk9gWwAZyluHkDeMo
         ucb9Ky4r4xQIqMTb7f7o0ALJl323cb1RQ5eScmezJ2JnYPFqWIN5mgklqMLWyNHRTiAU
         4fXA==
X-Forwarded-Encrypted: i=1; AJvYcCXGJA1T0unrf90Qr7q1tn/vJWQLUwFfu0UknP6A1KCoPwaMzD6qVGCGaTHwZA1JbsUKljLweJ1PNOqbnSbd8+zqIpwj9oXq5tzYrytYYg==
X-Gm-Message-State: AOJu0YykKb/4qRzRgj4Hgmb+R0HNxSJ0UcTIiwiyvM2B41VJJRyovTpw
	pJSHdnR13Ye8n91QU660rzH890R755/STBrva1s1n1NnjGDpo7rNiRVWZOjCSYx95dT+IQ7o3KO
	gqEEd2FsS16VhMFVAD6PRMUWh2UfczA==
X-Google-Smtp-Source: AGHT+IF1IsOQnyYpiHXGGnDEQACnR+86vly8yM9hSdUsAu3azUm9HfKfMGNWGUCFN0JG/kiZpL4sldEk/1epYvTM/jc=
X-Received: by 2002:a0d:eb48:0:b0:61e:a62:d8fc with SMTP id
 u69-20020a0deb48000000b0061e0a62d8fcmr11878695ywe.20.1715058967513; Mon, 06
 May 2024 22:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417053530.30995-1-wangyao@lemote.com>
In-Reply-To: <20240417053530.30995-1-wangyao@lemote.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Tue, 7 May 2024 13:15:31 +0800
Message-ID: <CAPWE4_yuDpLG7bLywEq7xQwB6+NVCUP0AwE+VgOZ-3hHpRVyUQ@mail.gmail.com>
Subject: Re: [PATCH] modules: Drop the .export_symbol section from the final modules
To: mcgrof@kernel.org, masahiroy@kernel.org, Wang Yao <wangyao@lemote.com>, 
	linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, everyone:

Could someone review this patch?

Best regards,
Ainux Wang.

<wangyao@lemote.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8817=E6=97=A5=E5=91=A8=
=E4=B8=89 13:35=E5=86=99=E9=81=93=EF=BC=9A

>
> From: Wang Yao <wangyao@lemote.com>
>
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> forget drop the .export_symbol section from the final modules.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  scripts/module.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index bf5bcf2836d8..89ff01a22634 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -13,6 +13,7 @@ SECTIONS {
>         /DISCARD/ : {
>                 *(.discard)
>                 *(.discard.*)
> +               *(.export_symbol)
>         }
>
>         __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> --
> 2.27.0
>
