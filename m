Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFB3A4F3B
	for <linux-modules@vger.kernel.org>; Tue,  7 Apr 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579257; cv=pass; b=Q8i1sLjhwrVneRbiLwirLE7Cu44j9q+bs7Os5A60l0OfU6WhpVTfw678EOqu0P/t9UvJI8mfDNqvbMp6ITSkiDrA4pBWvFG8fyfaUaMqk5/phLvauaF9uKHYXYsoC8OCGTGi9Y19Bdd87LjtAisRUYAUxbdkzA3mAJptWxwTSRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579257; c=relaxed/simple;
	bh=jjliaUW/bCmoGseWy4e9nHUvSFUIgSqJlttWlRrdXbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/pGB09O91t7BD9ovzWL1khbe7DTlIx2ZWSWTc5wDvGgyvsgUaOk1gsbnM5BV0ICKo8250Agw9TefaYXFWSLGSMQjV79NpMeChHHuYbNWWsYGv/PtEGQVNIA7N+o57he0ROZyBCUgdJjCXdIAqRvyr/OLTNZ34eMyEp2O4qSZjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8T3qkV/; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8T3qkV/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488879dcbc3so293565e9.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Apr 2026 09:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775579254; cv=none;
        d=google.com; s=arc-20240605;
        b=RuYTD6RvF9X0cXp2Shfxuz9DkuQRmoPkNXeVIILN4uaWvinCqx7ce5xIwc/1b5Wo6C
         PIbg5YnCugzDTBoXC4qB9y/7ruQpzd/Y538faGVDU0Gs0RvRvgQqXWyCBu7MKyqiGCNY
         U8tONc2fMbEnRu38559enniEWxCxNBCvg8mhy0P4EmvAzSA1BARnjsy5t0RSBRxzUp9x
         3wjkdtxDLBlCtJ3/yaeY28Ny8Uav4B6pWnIlBVdHmJ0ZuzC3AwFAEYUoaurlRmzYnSOt
         saiVP+9NlE9U/NyGjUxd9X4j6xrD2MkmJNg8GB1GN8QAPmdHNshEXyHDrHEaOIt+og9K
         h6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGtNlqpJcxcfn9EsC+uRndBkewaQ7VxazH34/2e0wAM=;
        fh=gwrMuXg/FSwJR2aTPJ9PPRyEfjCUU/vZLbMThzFmPGI=;
        b=OcNihY7o4Ug9FpYsxqwYP3s3c1toG/BpQpg+hwPy4jL7wQXP6Wg7adGo7gxDO8gL4L
         bS6Lf1kEhWBZ943PYP2SjI2Q0aEDS0ffML71AMBPL8Zyt67i/YZwdagaRSCOpockuqKZ
         EOzFa3XEETEfEZt0plQYJkCj5Rm6/mvmswCxvBWLciYoxaKY3ngln3Vb9V44FFg8Trz0
         3CFt1MTWDqf+DACIdDxTvzDKXtO5n/kh955Qyj2YX0GRZqSzldAWVLU+kT8Cy7AdSbGI
         CX+2ZtbHLKAzTzEkH0HkUU5g0Cq9xTrbuLECb6f9udVoXVrdwo5qi6TswFHD9DOwp7km
         b5Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775579254; x=1776184054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGtNlqpJcxcfn9EsC+uRndBkewaQ7VxazH34/2e0wAM=;
        b=R8T3qkV/jAdbK3xqxxIYJ3G2WsRfDQF/OSysORgYcuQTu2hXrPCm5rTI/ijEv8DEIR
         csIM5zu77hVz0ZCfy/xF3/Jmefj1eiYpnQi8KCofjoSFt3P2nGDnZf+o51aNlgiS8/uF
         WonJR5QVrBn8vWA0rpaDKJnCrXavwMq7m29Q0LKY8RaUG+mU0/pG+4K0KG8LCCfYBRsD
         H327sNGVQAb9IwKY7johXlHTB4J+XQdBKTI6q6vn0mMeg+VQWAGrEoEDOG70EzPcvP9P
         vniTzXLDibMyecxpz+anoxl2Vvf/p4BzdMsBF7T4f9EGBymLa2eP8v8bF5Is4am9vfZy
         tXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579254; x=1776184054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGtNlqpJcxcfn9EsC+uRndBkewaQ7VxazH34/2e0wAM=;
        b=NMKewI52BMQVTIADHMqgD6gPJCrI/BmnzwCWVNIvqzGiE0d9ecKBTOBUMTfGJDySJq
         rZP68TpVoUJfpenrkRSc/yGi5oMfa5GbzmaNP9R8SpvJrX+eWl3eNiL5OD6NTA7cYFzR
         yZdeQ4pGflu/jhn+TsWqmXaCmONrk2L3aAubE2A3dNSfPgGjH6BFmeiIdiwjIcR2WCBI
         yN3rc+dHZ82ln4bjWNWPS4nBXVrDRaPDbNS4EFkgG6pI+zNn9Eb5omMm21IdmodiwFqT
         mS3q+T0W8OQ9e0e40yVTQ937olbRh+Eh4jTR9T4vkXuxbwPpIDO2cZsCdKI3nqhRj2hM
         hpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvJLjPUZuGSnsG+zCuMbIvHnarGjU9ZmcZGg3ksZ+JlXo8jXV/5eXxtIHczmmjawA9kLGPwluvIGKh/EsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeUGr2dMs6WQxkrMvzrNkIz/kPLjnC5bSOxDa+SIcAujJJ9DJ
	Eh0BOTNQ+OEQVFNTWR/gxozLWbAy+tPdSQUVsMINn2X9mRzzfr5WVUN8iOosx41OsPgNsK3MxOO
	uVkedjVUwFSrApXqS4xbpDCOeho+Gkrht7y/Smp+J
X-Gm-Gg: AeBDietVRKdXqQYQb2xGeP8xiU5KkRTxVPuyJgCaSOUQy3/GOTBfcLDmlz4e7R4vJmT
	fb5xebBoPdy8s13uSwP5cMjpu0s1wELGIgEO9k1CXial28crwr/cThzMz8CSuLmOBqELDvbXcUx
	Jm7e7wT1ymh7obcsKbGoBDPOzkuEpUrZeQUfyPni7JBqfeBg23oItsp0iPF5Kl3XjDiHDqDW3+K
	I4Po/TyhNfM44RZmXGPPmiNIlSxBL5+z4ExR+HrBFxzKYJSfnvNslozLaiNBnVLe2AXjgJfgkhT
	Mwdi
X-Received: by 2002:a05:600c:3108:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48899eda575mr4184305e9.0.1775579253471; Tue, 07 Apr 2026
 09:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adFuw1E4iVyiXLf_@p100>
In-Reply-To: <adFuw1E4iVyiXLf_@p100>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 7 Apr 2026 09:26:57 -0700
X-Gm-Features: AQROBzABvcI_2GGYiVYCekmkhftWI3XYcqIECaEq7sar_6AXldhe60V3vvobbpE
Message-ID: <CABCJKucmXyTUxE6fApftqLOTwOgOLu166Gd_K-JeBqAZenou1A@mail.gmail.com>
Subject: Re: [PATCH] module.lds.S: Fix modules on 32-bit parisc architecture
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helge,

On Sat, Apr 4, 2026 at 1:04=E2=80=AFPM Helge Deller <deller@kernel.org> wro=
te:
>
> On the 32-bit parisc architecture, we always used the
> -ffunction-sections compiler option to tell the compiler to put the
> functions into seperate text sections. This is necessary, otherwise
> "big" kernel modules like ext4 or ipv6 fail to load because some
> branches won't be able to reach their stubs.
>
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and relate=
d
> macros") broke this for parisc because all text sections will get
> unconditionally merged now.
>
> Fix the issue by avoiding the text section merge for 32-bit parisc while =
still
> allowing it for all other architectures.
>
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and relate=
d macros")
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 054ef99e8288..41e13e9cbb9d 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -41,9 +41,11 @@ SECTIONS {
>         __kcfi_traps            : { KEEP(*(.kcfi_traps)) }
>  #endif
>
> +#if !defined(CONFIG_PARISC) || defined(CONFIG_64BIT)

Instead of adding parisc-specific policies to the main module linker
script, could we add a separate config flag for this and have parisc
select that in its own Kconfig for !64BIT? Perhaps something like
ARCH_WANTS_MODULE_TEXT_SECTIONS?

Sami
