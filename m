Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3684D07;
	Mon, 13 May 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641869; cv=none; b=eJH27GMfOWxmgbl3ZLp7nGIhmCeZAzY0WPWOOsoAi9bVm3lg4dS7dUp/vxMrI2XXWRdAwpQEgpDMISq4bChCPE6Q52rmyR6GRNDDPGSPEULp5q2nn16pf8dcxFoHTU42GLLljGWabJJz1stFv4edFD7YVDzbYBng4I7JPYArG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641869; c=relaxed/simple;
	bh=hQfcbOiJ/AYUeUOi4w81BbwdO7aOw9T215Ro5XK324c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER9BD4vKbr2ZbZGc8cuk0L9iARTqGetLgVMpgbrhkvYsGzNdElmVYZKP6tfAlNa/W09Om5eA1ks9/4bWZSL9+r90wXpDmeqGxS82V0BmPYCmJNhorjPr3w2eDjcmmmjEmI5BywJzT8TG7+n6mdNQFmKna/uK1IQv/CRARV9psuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTLky4xU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTLky4xU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B2C113CC;
	Mon, 13 May 2024 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641868;
	bh=hQfcbOiJ/AYUeUOi4w81BbwdO7aOw9T215Ro5XK324c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RTLky4xUOtE02A+ob5CMhhN0i0825yAulZK8x22vH+G4k2FSpKLuY3wShDF94RO5p
	 FytRsn0sIuGWt9XMN5qrFXy5zmNEz26ldTz09shWJVQarUrJtctdXWjY5qTat059aD
	 OBhNMcoeutnYZhDYeu+foiGBj5uqvAMMHWFdRyp+NnT9qYDRrJ2SCOovXXbN7xTlCG
	 aFcQV0h9vfdHOtrjarLbtCpjqp3230KBjwHcxHr9Jlkz06LKVTb+zwyIiRdzeEZuwm
	 phLuKZA7eJAU5Ifo1HKUAgH/9VCWIRtWRwzgLcCbkh4psc7kSlRPK7KvVz/qZHudl/
	 3egTHrz3VOPSg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e564cad1f1so39920811fa.0;
        Mon, 13 May 2024 16:11:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOIK38xyiPT1D7amHlK8ZkzzvylIgA5JWr/fxwVW+l1YbjVKwt9Pg8kzFtZsCmF3S7mb2fV90QWDN19NaGP5LILmgasx9sr1F8U5THa60Rfgqlz9N7EgKPsdfs5XH+WXTumWRXoYAo2JHBxA==
X-Gm-Message-State: AOJu0YxzFyiyMj1YjtwTGaStIzMmYBkm+DkfBui036enzWLa3tdpl5Gr
	/1h5kr+D+yR3xOZLRChzbkUVCqpTR4AMEmZ2vyZ+W5zcSCmpaHHcvoI8TnY9NbbMtHjmIrkpWLj
	1eU0LwPTK9/rAmRHdTsYWn/uBD8k=
X-Google-Smtp-Source: AGHT+IFr1b2jSVXtqMOvohFbgAWT3eKNmF6sprJC5IH9sPfmFtqcoUuaeyqsIfuX8DZilAsIW3XNhgkYobn21WK5IRg=
X-Received: by 2002:a2e:7219:0:b0:2d8:6606:9e61 with SMTP id
 38308e7fff4ca-2e5203a1e5emr70320741fa.48.1715641867234; Mon, 13 May 2024
 16:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417053530.30995-1-wangyao@lemote.com> <Zj_0KU2cInEUbsW3@bombadil.infradead.org>
In-Reply-To: <Zj_0KU2cInEUbsW3@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 14 May 2024 08:10:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCxO9rysrJyZo1uVQ+83YJJc5KFqY65+_3vWwSa80xtQ@mail.gmail.com>
Message-ID: <CAK7LNARCxO9rysrJyZo1uVQ+83YJJc5KFqY65+_3vWwSa80xtQ@mail.gmail.com>
Subject: Re: [PATCH] modules: Drop the .export_symbol section from the final modules
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: wangyao@lemote.com, ainux.wang@gmail.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 7:42=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Wed, Apr 17, 2024 at 01:35:30PM +0800, wangyao@lemote.com wrote:
> > From: Wang Yao <wangyao@lemote.com>
> >
> > Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> > forget drop the .export_symbol section from the final modules.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
>
> Masahiro, commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> modpost") was your change, wanna address / take it through your
> tree? It makes sense to me though.


Yes, applied now.

Thanks for the reminder.





>
>   Luis
>
> > ---
> >  scripts/module.lds.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index bf5bcf2836d8..89ff01a22634 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -13,6 +13,7 @@ SECTIONS {
> >       /DISCARD/ : {
> >               *(.discard)
> >               *(.discard.*)
> > +             *(.export_symbol)
> >       }
> >
> >       __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> > --
> > 2.27.0
> >



--=20
Best Regards
Masahiro Yamada
