Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D025B082
	for <linux-modules@vger.kernel.org>; Thu, 27 Aug 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789494; cv=pass; b=Ay44qJHefkpQeL4/f7I3J5tkh0SXCBg2ku3zxj7pVuPQuSyrtGsjhiJ78PEL8+MdCsFkjubMferBY3xv9kNrzmV20pnd5cjbAQsBgepYBoE2BPN/J0btaOixpMQKGsLKkZiaEpsr27wFgRkESHeHUXZaabj27teH+L1d7PFKtm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789494; c=relaxed/simple;
	bh=U0ZVJdy2xlpPXTTE9DVaFvSQYGlWfk/i2EZPp5O3aR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qymk75/hEEUvRSSZKFPx/DhzGxu1QgqDBiBqHe3hCuZ4tR0U9+IO5EggmDShtuAGj8gxXyTVSCoRj/uquypncUj7O43alGKE1vI/2eSLvaSZg73Cz/LlxdnMLBMMGG7gkrbaqkqA08a1ozoigLp4SH97lZ3E20EqTXJojyHzuNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ4RaDox; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ4RaDox"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10ed63c0so62631cf.1
        for <linux-modules@vger.kernel.org>; Wed, 26 Aug 2026 17:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787789492; cv=none;
        d=google.com; s=arc-20260327;
        b=JgHBD/39WnCc4yB/eHRnqoymhfT7Q7MYb3sv/lvaSF88mRpkOZNLlHCS/aBZr0GJle
         GpFEInXOxmzkoS3nQXPpoPt7gJA80CfgO6dpDjDif4OFvj6eTHiO7WgyDysiDKZPtf74
         mA0QIvlzyNdzNxIFQBRDFkt5Yd9o/lBRtfKOXK+h/GvzBfcVbT23vccXH160ozj6NabE
         Sh59pxo1XcBYoofdbLeGxM2xovjb4hfiILlASpil1b0dVsmadnay/2Fmc7Mp1QhtHq9Z
         775TdN8fBCYBLsfSD9qMAacdSkOt3KCz6zSv3mEQIWRdBIWVSCxPGZkev+PDk1Gioi6P
         GuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        fh=FKX1kMNID6xCD5s7PzMRTnFrmNpSwbveRnIZwQ3otLc=;
        b=enj8ZWapWKIQbMmp4pBviyPQ6pGzIoFav7nHkGm/eXr0F77i+YzFhMC5xnN7KbUtOf
         Iqv8tL1COxieyALxCCuEEavpMPbZa2bpM8cG+oXJVyDUF4EwRHFLcZ7JJLULII/nfOfi
         H6rXpZLjecxIRzEl98h2q0CW19SIbfhljiRKQ6ELFi9W5MUof+OXeqs+xvweKhu5kLRS
         nTbES/zx7zl7YthvaS5rX/uxKVUxnXSJkj/aIltssiA6oJ+SPJCu/UWLjJXBuzLid+6O
         ZEnNP3AGB99WTnsb3jYAbGKPtvEJQGN4rSIo14ntVTN7e3rfnMUDo8t6wnAmcG4bcI6I
         7iGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787789492; x=1788394292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        b=DQ4RaDoxwPXoleY2/DBK5nA5egrX5/rVO6rCLgHpgLh7OQpjXL1R1BPPMKMSefrtg3
         VZAI3oRnBNh+K45mJN3dzORZ6ac8QCknlVyB0wcX0IMGC0L2MnIbzlmKKPKvD0/phVvK
         +cq5saE9yqb6gzglLrOlrO6zfn+EgzavCDGkhNB2GRbnp0HYz5CCjclJiX3QTIKTLJ5o
         xoBQR7Kve3l5QX39NQhf1chGNzc1o4qEJV7OlRp930P77qHt91by4bn95+soYrmb0pgg
         /oC/vmBsWkCzr5T3nuliA3iI4+Enqy+h+p/7J9In04Uyq3c13ckCmyPBCbiKXb4xBdYq
         ogHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789492; x=1788394292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        b=eivx1StZE7svyS72yl1GZrgCJUbD7UPxgxTyHyD9HH/vRp5Tr1eyw36sH1EtlID9KD
         Z1IHKEOBr9KV0+jHo1L1Gnp4d4teZSG9sr7UIv8sntmE//He9kiwD3vPuqI8UGlT61fP
         ip8D+LbHkdeWYRvdlvH8Nu16NL2zNdl81+0CDAw8+saODsqyC8Vac05wf0KFYu72DSAq
         vGAktqK2A1zNB72sTb7hGr6GOhQCR6ZKS4cUe2Q+z+iIvR1JTbHmoXBN+VFydM1uZ1C/
         nCxjaFD+jrh49BMBXFMMQy4y0R6KrrNvGdbB+bGsmCVt8V5BnrpIzJHLEtmJ3v1ST6KE
         4M8g==
X-Forwarded-Encrypted: i=1; AHgh+RqjlUKtWRwzjyGTA3EQ1PE9HRLtg07TJV6PtzITB7G6U58hKBhhWPv6kMvRU7mubIZrIj3OSTqPOuJRJs8t@vger.kernel.org
X-Gm-Message-State: AFuF++mTdlMYLhkW765KZRxvSMM2EdDvkxph1rKzi0gl0rgs2S1RANNK
	Xlfvm3dGGXlp3AmVBahzRlILM2BlmZPa3PmGf0F+jaeH6kn6R4GIuB/Xi/4PQd/XPUqoDjvUIlw
	VbxsGKLsmNHbOasEJZIJUNuqg1komOaGtnm+axhZE
X-Gm-Gg: AR+sD10okmOy7uD/UMlYfTyyHpnZPgQW9R+1j8HGyjf3x+SrY6KoTyY/+qb3seb0Cq9
	+vEa/owE09IfvbBNUKEGZljFva4VEcBcZyQI1I6SHKclcGViWPThNPbgKaIZIDI4VVo+jw9UTei
	zsaTcHKdPFwLTZpz4VKCOIg012EkgNz04Cof8KE20Hp28V/Y2CSjuXbltUPflmMLpuij7Lr0pJt
	ZUDEU/xsz1/0Oap/PJ5SI9p8t/FTZa+uSdPeTy8PY+Jn6dtulvl1cKGwUWIGqEiHFWyrbMh9lBz
	wmYU69R3YXTS226VhqgQtV+bpEkJbLM6kyWFlMXKavs=
X-Received: by 2002:a05:622a:155:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-52fa36b4dedmr7284201cf.14.1787789491416; Wed, 26 Aug 2026
 17:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824014736.35026-1-hao.ge@linux.dev> <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
In-Reply-To: <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Aug 2026 17:11:19 -0700
X-Gm-Features: AcwNN1VDomkisfTnAtHt4KtA-jTwfLuIMQLzObQetyS450qtuGh4E69anVaRXCw
Message-ID: <CAJuCfpEzkuYBY2dBtUrR0pquajr_2LV3N=Ti6xTZB6MqhqAx8g@mail.gmail.com>
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:24=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/24/26 3:47 AM, Hao Ge wrote:
> > If codetag_load_module() fails, err is never set and load_module()
> > returns 0 after the module has been torn down.
> >
> > Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as m=
odule load failures")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  kernel/module/main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..afb810f0154c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, co=
nst char __user *uargs,
> >                       goto sysfs_cleanup;
> >       }
> >
> > -     if (codetag_load_module(mod))
> > +     err =3D codetag_load_module(mod);
> > +     if (err)
> >               goto sysfs_cleanup;
> >
> >       /* Get rid of temporary copy. */
>
> This looks ok to me but there appears another bug related to this code
> that would be good to fix at the same time. If the module is
> a livepatch, the preceding call to copy_module_elf() allocates
> mod->klp_info. However, if codetag_load_module() fails, the code doesn't
> free it.

Ah, I see. Nice catch!

>
> I think we want something like this (not tested):

Yep, that looks like the right fix to me. Thanks!

>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..c1b34dc1e89a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> -       if (codetag_load_module(mod))
> -               goto sysfs_cleanup;
> +       err =3D codetag_load_module(mod);
> +       if (err)
> +               goto livepatch_cleanup;
>
>         /* Get rid of temporary copy. */
>         free_copy(info, flags);
> @@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>
>         return do_init_module(mod);
>
> + livepatch_cleanup:
> +       if (is_livepatch_module(mod))
> +               free_module_elf(mod);
>   sysfs_cleanup:
>         mod_sysfs_teardown(mod);
>   coming_cleanup:
>
> --
> Thanks,
> Petr
