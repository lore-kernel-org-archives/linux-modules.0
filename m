Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5123AD;
	Sat, 11 May 2024 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715389432; cv=none; b=kM9G1W2958ITmHU5nCUxH2BL3ItFpS9pDM4YfBSVv3310X1SBx+zgW/sjOi+1CzCcdGzz/Iap9IJ/qRHcaMylcsKBmPvNKzLQwPvoqMzy2sJjLxh42hWFbvsWxQJ8Xm1QbvKH/QlI5Vl7X7nwOyOiT58Hg7A62WJA9QXYJuZhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715389432; c=relaxed/simple;
	bh=BAKWID6FQw+TKSNOVcRT31Kx46DteShlfiHfrR1Uxlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bHtzKEEB9IyE26MqWcGfxmVd1MNBSkL+DTGJa94t3W1l0jTUMHIab9VWZHwYJDmwISYsT1cJkNVL3GUAtgUdsfRaMYn6Pv0T8+7Djr3YCWC17rBud9FKcNqqgO/fa/6/Uiv4W8z0FQHBhwdD8Ll+rHyD5XWV+OB3qRa1PTsB6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1ffVGM/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1ffVGM/"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62036051972so28841117b3.1;
        Fri, 10 May 2024 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715389430; x=1715994230; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj98wxf0dD5kCrnZWVbsQZX8fcdXwS4YPSyIBoOfL6w=;
        b=k1ffVGM/ezNdsHxyavYJAiSYwb56ZeHxyvaoee1KaYfnmD/8QczQ/UNbnHquPouRx5
         i+hiEQCUipZ8mik4ilIVBAUDR4zEnhdmfTOdINUFgf36TX7VQ+4h3jjHWeYh57+2+mx/
         qSdv2eJIiAMSosjIG/aCF1bxWa61kBU6gSWidzH4uKIChX2efbwub3SwE4wK7vI1wx8x
         Ye4w/mO4qWhb6IGWVX/xeRdJCKmg5rCZo13gmLiGaTtCUCqp6LCLMa/3It3ZnaDuCr08
         e5ogt5gwUUUUdzsVkO50aIUA3ynbQMivN3CwjKFkV1FNDnUobaOqk9OCBQ3ohvMhxKBJ
         KPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715389430; x=1715994230;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj98wxf0dD5kCrnZWVbsQZX8fcdXwS4YPSyIBoOfL6w=;
        b=GCZbjqZGTAYUQPenmhvjOFsL5x8q4Fsk4FU194IwqT2+wiXWLWOUBqkWz/1G2Dy4j/
         TRJXH2K+z+1MRlQ87KRj2sq09ICOPKcLH4JBaZivMqOGNoJn6E6lg4HYahiL805oWLBQ
         bUHdl7OnG0E0ZesHF3MEoAke/ZWFYaJx20r/hgNVirFVfTCIlx7tnI8w2PYT1K5LeE49
         xwOYbHhjDU9seC0dXfFnRLnXP02pRx8ejlXgcqROR27kQszp+BMcH5XTF7roi3Uowqbp
         nUXprztlQS3wNjsuUaCNSa3kjoaPLDSzaadBiN/rAkjePc+UnEgryD4sIk7H/8LGkwkC
         5+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXsEhus9UWPtLJnao9BPyCb+rPEGLQqeSYYBIWjJ7ttwsW0r4qS5NUrNZK/bRFPWRnlPCfBNlQBGmCSA0HFRriqqT8Q7zmaAFQwrU+l/oGMQvVYT7MnDRJUETLvUTqtm22sKLljBTa+zs9UCA==
X-Gm-Message-State: AOJu0YzRZlxYA2XjVtvy9u4wBk3lwxsyLtlU78/ryt/jNKrmdTfTuCfe
	yfi93ybgktjWuL1zKGJoeJEzOBZ3CLVm7d1mPjd6z+m81JwzinTHllx5YpvTADTHINaPyg4jttz
	srtE5OIPPhmWYXfvxaGsi8VCBlBAgrTCI
X-Google-Smtp-Source: AGHT+IFrRlIJgsNQPjpz5iPCOo9FFgUCkCpCnoPvmUdAW9+Dp/oJoRjAqVVAJ1SUxAV75ie71dR+M8fBTVxv1DRp9Po=
X-Received: by 2002:a0d:d44d:0:b0:61a:cb67:9d0d with SMTP id
 00721157ae682-622affdc8a1mr45068817b3.22.1715389430469; Fri, 10 May 2024
 18:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417053530.30995-1-wangyao@lemote.com> <CAPWE4_yuDpLG7bLywEq7xQwB6+NVCUP0AwE+VgOZ-3hHpRVyUQ@mail.gmail.com>
In-Reply-To: <CAPWE4_yuDpLG7bLywEq7xQwB6+NVCUP0AwE+VgOZ-3hHpRVyUQ@mail.gmail.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Sat, 11 May 2024 09:03:14 +0800
Message-ID: <CAPWE4_zzNniXzw-SV4V=mzEZ54CLkFaRSw8KwE6SQ4fDvssaPQ@mail.gmail.com>
Subject: Re: [PATCH] modules: Drop the .export_symbol section from the final modules
To: mcgrof@kernel.org, masahiroy@kernel.org, Wang Yao <wangyao@lemote.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, everyone:

Could someone help to review this patch?

Best regards,
 Ainux Wang.


Ainux Wang <ainux.wang@gmail.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=BA=8C 13:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi, everyone:
>
> Could someone review this patch?
>
> Best regards,
> Ainux Wang.
>
> <wangyao@lemote.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8817=E6=97=A5=E5=91=A8=
=E4=B8=89 13:35=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > From: Wang Yao <wangyao@lemote.com>
> >
> > Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> > forget drop the .export_symbol section from the final modules.
> >
> > Signed-off-by: Wang Yao <wangyao@lemote.com>
> > ---
> >  scripts/module.lds.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index bf5bcf2836d8..89ff01a22634 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -13,6 +13,7 @@ SECTIONS {
> >         /DISCARD/ : {
> >                 *(.discard)
> >                 *(.discard.*)
> > +               *(.export_symbol)
> >         }
> >
> >         __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> > --
> > 2.27.0
> >
