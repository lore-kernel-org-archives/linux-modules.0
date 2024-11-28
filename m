Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD938B;
	Thu, 28 Nov 2024 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762142; cv=none; b=ZygB3F/rNeHrgyvIg/Ag8V5n0c8kRaOCaZ1ntNo2uv1l7551GAxKZc/nUpuiTSTUnTb+fJRkAs+aQ8W46CTh6D03tm+wkpA0vykHswsWKa8jqgyZSeabgDp46UuN6jhUhK9W9T8Ci5cJp1Oec3asyJso3ij/VBYKfJq4An+7PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762142; c=relaxed/simple;
	bh=jJ2y3vCLtFLQCosfBaBQ23Jyli+WiQf7FlPX60S9HDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph7nOta1VoaRwLkcrBujlsOfd1LIgB3xIB19zFveuf9P/LfwI/Rl5tk3PS5tMZ8DWpPDjL2mhQdyWybkgLArZMFsmDrYrfqYsl1adnmWe5e6fyxblRyU9FQWDMMlsSNRm7mhUZbmxT4Eh4jpn2ChjqSlhio0qk4n8AaXlwz+MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hALBE1kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hALBE1kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA1C4CED2;
	Thu, 28 Nov 2024 02:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732762141;
	bh=jJ2y3vCLtFLQCosfBaBQ23Jyli+WiQf7FlPX60S9HDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hALBE1klLJPZBOV6RxmHT+9osu3H3/aez66vhx4B6hRGM3su8P06Y4KoMNE8H2iCf
	 BFSkcMY3AfIquWRdgNomsJWd2+o8gV64FZ4Z/UflxiaNI4Y5Hw79agF1p4VErpd4z0
	 ufCEQX0Qmka0zd4LzPJG9MCay5tUhZTeB4jBlb05tf2ebnAbGgYAUe2kqJ/TBMZL+V
	 BUfLHYv7gfjqU44FJN5rSF04XP/HRDhWiZl8i8xSTlcjn4XsfCTk0wXSOBKwWC2lrp
	 XyjkI74UVksqx+hU3IPBf9CrV6PdBiqlkoetdhLUEI40xhAp5TpcjRmep+AqUeiLl0
	 9zl3xUwIl0ufw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dd668c5easo423603e87.1;
        Wed, 27 Nov 2024 18:49:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX13nMeEBX0fYZfSNbIjpFkxrIn9ggDrArccw20f+dtaFPDjdzaXpuPyELngDPV37QZ3EiMo7dZRcHVF6lI3g==@vger.kernel.org, AJvYcCXtQI/ibfcSYVJDSYZBU5EoeXlB7Ns96Qmmvys+MifbEV8Dcb9h1yoh4I2yVgJZ5FSHkGZVm+B+i7yVm1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDa+6SkqusDwhLXxEESFj09PYyhBrCEcB/G+UI3Tv2ZZxCBcLA
	1KPsMHjtTzB+/QzFngSqhqTJIe3WgwvTpX0SoOO0pvyuD84d7bRzpojv3mW5dZlusm+ayEjZrpk
	VO3ReO7l+MHp28qKf+GeXkO+0NjA=
X-Google-Smtp-Source: AGHT+IFkxvmqPjHU33u25P8S6FFTgUr3u6w9XWoqzYocX/qYmOJ/jQipLr4QnKiAIFq7KStyJBa+c5YtB4lO+kqq+VE=
X-Received: by 2002:a05:6512:230d:b0:53d:f5e9:ec4b with SMTP id
 2adb3069b0e04-53df5e9ed27mr279265e87.0.1732762140603; Wed, 27 Nov 2024
 18:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0ZxiLw9hauUynTS@bombadil.infradead.org> <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
 <Z0eeuCyUGcKgsc5h@bombadil.infradead.org> <Z0eqiayuv1w4a_dc@bombadil.infradead.org>
 <CAHk-=wj+imfGvW73XoYn60bAMzRtPfXFqwFTUqBoEq4=u5_oUg@mail.gmail.com>
 <CAK7LNAQyhxPZfpK3hVPtYvCYjad4pTUim5jVsEsuXqefY8KhWQ@mail.gmail.com> <Z0fXshsZI8J0NhQo@bombadil.infradead.org>
In-Reply-To: <Z0fXshsZI8J0NhQo@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 28 Nov 2024 11:48:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1ahFWeChwBjgPs9Y3AGieVznFoPdbVkWP9rrW0T5-Dw@mail.gmail.com>
Message-ID: <CAK7LNAQ1ahFWeChwBjgPs9Y3AGieVznFoPdbVkWP9rrW0T5-Dw@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, samitolvanen@google.com, 
	petr.pavlu@suse.com, da.gomez@samsung.com, linux-modules@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, mmaurer@google.com, 
	arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 11:38=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Thu, Nov 28, 2024 at 11:09:43AM +0900, Masahiro Yamada wrote:
> > diff --git a/lib/tests/module/Makefile b/lib/tests/module/Makefile
> > index af5c27b996cb..8cfc4ae600a9 100644
> > --- a/lib/tests/module/Makefile
> > +++ b/lib/tests/module/Makefile
> > @@ -3,13 +3,12 @@ obj-$(CONFIG_TEST_KALLSYMS_B) +=3D test_kallsyms_b.o
> >  obj-$(CONFIG_TEST_KALLSYMS_C) +=3D test_kallsyms_c.o
> >  obj-$(CONFIG_TEST_KALLSYMS_D) +=3D test_kallsyms_d.o
> >
> > -$(obj)/%.c: FORCE
> > -       @$(kecho) "  GEN     $@"
> > -       $(Q)$(srctree)/lib/tests/module/gen_test_kallsyms.sh $@\
> > -               $(CONFIG_TEST_KALLSYMS_NUMSYMS) \
> > -               $(CONFIG_TEST_KALLSYMS_SCALE_FACTOR)
> > +quiet_cmd_gen_test_kallsyms =3D GEN     $@
> > +      cmd_gen_test_kallsyms =3D $< $@ \
> > +       $(CONFIG_TEST_KALLSYMS_NUMSYMS) \
> > +       $(CONFIG_TEST_KALLSYMS_SCALE_FACTOR)
> >
> > -clean-files +=3D test_kallsyms_a.c
> > -clean-files +=3D test_kallsyms_b.c
> > -clean-files +=3D test_kallsyms_c.c
> > -clean-files +=3D test_kallsyms_d.c
> > +$(obj)/%.c: $(src)/gen_test_kallsyms.sh FORCE
>
> Thanks! We can also just replace the FORCE with $(KCONFIG_CONFIG), no?


Nope. Absolutely.

If you change any unrelated CONFIG option,
(e.g. CONFIG_DRIVER_FOO), the timestamp of .config
is updated, then lib/tests/module/test_kallsyms_*.c
are rebuilt for non good reason.







--
Best Regards
Masahiro Yamada
