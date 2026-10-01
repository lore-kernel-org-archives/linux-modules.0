Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27F3D45F7
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892450; cv=pass; b=qW99BbOcYF6G9LLQuOLE0Rt8H61mAk+m9Cx60JZL6Ta7M5z6ER+gw/Qn11NwiZYULX/q/yV/ikhMyh7W/HIB3awIXEdNtDZbXYRquCjVouv2a2H2iOCAxkE18ihIfdiA+MwGn2gHjdfgLm514h5NHOz0qtqXdzzJXejuyHtyQkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892450; c=relaxed/simple;
	bh=zULUM4vXtsJXc9bEkL4iYDnVXVGXKvg3SjDao3r51pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPRY0zKz6ktvxEmQUBvnKw31GE1aiNFy61yRJ+UZA6kM45XXwNpPPfKU4KY/HXO3fzDPkcnKJegexBVeA3Zv+92Spd6xtP8X2I7DKfVr6BmHdLLje8zvXpMrcPXmMJLV/pT5Z9yYnYlkZ4+ZfFc40kW8H83GwT8Ae4K3R2oKZMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZmJuyx+; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZmJuyx+"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6756a6320f6so3153911d50.2
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 15:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892447; cv=none;
        d=google.com; s=arc-20260327;
        b=iWa9VU8Rwb21Nz8tFLLYpBmTVRnKoi0C8fZeICLiW8uvnSLJjDD+dDd71df9QWV5M7
         E878uS6OjFbrF+mcL71t25s4cOYcjtAvTyiOlAbWnvy1ztvzyMAyh2lVFx26NVEBHNEK
         ZGHu4XLK2OnQg3bhSSiGk5TLARR4mrc08mQxdMuLv5FGhn2VMvlh+cULgIj+6nA3U4Mf
         jJe78ApqVlR8wNOysEyXMiJaGCtT29AHe2NECzVpLYfcx3TtlcAE9PtHoxBAYH3Wuwkq
         bfQlY2YDWUPgOOTVpTv54my42qpsYDwMFnXF/QhZhnf210Zo7xblGBtC1/z1X9jJD5qA
         AK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
        fh=gan6lr5L+Kj5Ja4uk2JFnY4rosmJrP7ooYeeh+7z3VU=;
        b=G6lUfds73LL2gw3BJjaK6oc1p7r0NTOJlukRlnWvJO64uriv0a6aDSD9BOh4bcaU4T
         wxxgDnUp/5lZdHFdscyG/zxKqiW3WC7cjL7y+f7mYSMmS4e/MwZlUE7hfIPAb3C3mDmz
         7iCbJXperULyhy5e62lT6HaHkAjxx/6j4SZGiMBM+ELKfGfTkKzy5CguZH5fG2j3mfDR
         /3rJHrvKGadvmKeATUdpQVo4gyEDAT3r2HfB/2nZtg6eDwuz4LbcH05DKVTdJsZwl23n
         Ry41jm2r1vGvBnTehh6hGjkW6rdx87dPrhDlAAtp1VwZvQCu+29U1PNHZ0Fru9IQnACm
         AmYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790892447; x=1791497247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
        b=GZmJuyx+IWDTQewGC2Qlysrxlm+bDgv72UE1ODJLEAdmbiUq+4NRqO5+9Lgp8XcWf2
         pKvwpUt4n4lY4V6cib4BzZbc/urm40zcBR9elG7CjJR1XFXUulooxkuv+9nabMu5rTpl
         g8+3Sa3D+HtElQtLjbrPmwiC5k+Qvp89EukBf3miNYH93j48abG7p8Mt5sFDF9xbLrIq
         wWz92TgqGF9N243/2cDvF8xOV913msZ8vozSQqLhHWoeGgtE2ZOB6EcV4Lxhk6PbDpOt
         Dbb5M+WsEgUmwo6IB4Bdi5fjwU7qB110OxOeJHEVhAIdd5iERKP23y5D7k7H0pEIuyRf
         UsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790892447; x=1791497247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
        b=1PWr7xBtQmEyfDBclbTL1agNnZ4CxlDqVazVWHDUZSX7AtwvoHj2m8mHFjtLS3w/h8
         9V3Llgf3s8vY2X2B9fgVC8+xh877EflsBivxbm2qYYl8NXt88ozC359WtFSSCPl+HvPw
         0fXMa/SmVeSH6GEb/+OYPieXsicE7SiXRBGevQiuV9CUVvE8ss5F2rkCMsQhjiIsh+vj
         E4WL4gfrsf/Y6C2UlTZCZPc1k7vWgm5bhIDlOrh5KWMzRWZDWNiYGFDooSrEYWU31wdb
         5tWSUe17MvGseAbrWrNX3eVy5r0nxqBpxm9klspg9GStvLC8yUeQ/1XwYhS/CCbB4Cjo
         K6lQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0rfhCjuHVhjaROo/Ym85wiYd5wYZoKdcxvP67ypt7VoGT1x6wGgzDUg+uzFAfSWewkZeSjONwrcqR2/FT@vger.kernel.org
X-Gm-Message-State: AFq9FYJVBg9hZDTo9YlhTfSPe88QDgjewvWM1pscgv3AVxUfG6aQqIGq
	u0PGx8bvlS6sVi4hPWDz7bXJkGHgauCleGVqMvaZoXjlxIZV/2qJzWhshQmQQug1NxM6gtpFPex
	QU1sh2P139Jnbh+9LSE1smWzpud3aJdo=
X-Gm-Gg: AYBFou0TAqRzCJNut4Ijm0F6DhTbLlYuNDDDK6QpGoOKOgUvb3nRVWf57PHZhpGXjMH
	8l3HUsgGQMG8+ULctvwQquqK9Dcv3JvGvny+j7K3AZeBwkpsis7B6HwcBcWJk0e/j8NhnDqbLdE
	g1LcByJjXiwveNTnR3dbdI+wZmgvnJhEXWMK9TvnRWDgJEJ3I6a7dKAaH7Ovd7VJzXNMnPtYIwN
	TRjcqUk7SR2bcM0PmihBojOpo9mNjWMV8AOucL2NV8kYcR6xz3fgsma1nBjoW/HifGLc5dz8oGK
	l7nvmqSq1ZqbBKCF6zxhcP2GWQvZpKcZCUONLXiIQr8P0sR5AF7xr9uFA97ySmnGn/b5Vd8Qem6
	mKQ8/tUoJvZ7O+UWexnKpgj1KtaCF2AaHEbxrDF5NGbc6
X-Received: by 2002:a05:690e:24a:b0:671:506a:9fb5 with SMTP id
 956f58d0204a3-677abfbae92mr332349d50.35.1790892447614; Thu, 01 Oct 2026
 15:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-31-9b6c217fdf2f@gmail.com> <20260923224722.F199F1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224722.F199F1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:07:00 -0600
X-Gm-Features: AclHuK-0SkBh2JCEKbGxlnSItQq61tpkSYiR0faSf0oEXk0XEt53T5FhJ13xWCE
Message-ID: <CAJfuBxxDFgqVQt7CvKU5-G_i67a6zBr_Xi_h+jkjbrYVVYq-Aw@mail.gmail.com>
Subject: Re: [PATCH v11 31/38] dyndbg: split multi-query strings with @
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: UAPI break for boot parameters containing unquoted @
> --
>
> commit a948e5ac96c252adcbc1059b7607e6fa7aab2b9d
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: split multi-query strings with @
>
> This commit adds '@' to the existing ';' and '\n' separators for dynamic =
debug
> queries. This provides a more shell-friendly delimiter, reducing the need=
 for
> quoting and escaping.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 6482fd28def46..636a88994a774 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -622,6 +622,30 @@ static int ddebug_exec_query(char *query_string, c=
onst char *modname)
> >       return nfound;
> >  }
> >
> > +/*
> > + * Split multi-query string on delimiters (@, ;, \n), ignoring delimit=
ers
> > + * that appear inside single or double quoted strings.
> > + */
> > +static char *ddebug_find_delimiter(char *str, const char *delims)
> > +{
> > +     bool in_quote =3D false;
> > +     char quote_char =3D 0;
> > +
> > +     for (; *str; str++) {
> > +             if (*str =3D=3D '"' || *str =3D=3D '\'') {
> > +                     if (!in_quote) {
> > +                             in_quote =3D true;
> > +                             quote_char =3D *str;
> > +                     } else if (*str =3D=3D quote_char) {
> > +                             in_quote =3D false;
> > +                     }
> > +             } else if (!in_quote && strchr(delims, *str)) {
>
> [Severity: Medium]
> Does this cause a regression for boot parameters with an unquoted '@' sym=
bol?
>
> When a user provides a kernel parameter like dyndbg=3D"format i2c@1000 +p=
",
> parse_args() strips the outer double-quotes before passing the unquoted
> string down.
>
> Once ddebug_exec_queries() passes the string to ddebug_find_delimiter(), =
it
> will prematurely split the string at the '@' because in_quote is false,
> producing invalid queries like 'format i2c' and '1000 +p', both of which
> fail to parse.
>
> Could this break existing boot parameters or modprobe configurations that
> rely on the '@' symbol in format strings (e.g., matching device tree node=
s)?
>

0. next_arg() in kernel/params.c strips only the outermost pair of
   quotes enclosing the parameter value. It leaves inner single quotes
   or escaped quotes completely intact.

1. ddebug_find_delimiter() was written specifically to track both single
   and double quotes (' and "). A boot argument containing '@' in a
   format string protects it by passing inner single quotes:
     dyndbg=3D"format 'i2c@1000' +p"

2. Previously, dynamic debug split multi-queries on ";\n" using
   strpbrk(), which had zero quote awareness and split on ';' even when
   enclosed in quotes. ddebug_find_delimiter() is strictly more robust
   than the baseline parser by preserving quoted delimiters while giving
   users an unescaped '@' alternative to shell-sensitive ';'.



> > +                     return str;
> > +             }
> > +     }
> > +     return NULL;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D31
