Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646283644DB
	for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275153; cv=pass; b=BXYze+0u8XlvQ29FmA/9h0WtNWsjHifcHuOrYeTv7eb25ZxRR2mVSAKGkh/wUQOSNcrutP8obmJKGLfDn4qulxun80XOmmsrN6Q2fLP3LbVt3eDQVj0bNn4jZyNnyXiN84oPgcYSAxXXV7ZvX0B9Pxnk6Udzv0kPPhgzmZe2+ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275153; c=relaxed/simple;
	bh=ouj7/XxF+rM/cqEOn/Xx8H8wm6495TcijVSF+fy6VoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPxy2ASTzPSMMiqH/8EJqugsFqMaFi/lf+4sL7XoLxo7ulLJNfJKbgFaLoB8fERKUOrBYObn3nE3Ts5NTaae3stGjvpfGO1n9YJnRGKvNlnBdIBNiUWiqeiUkS9Z6HL/cjioZdNL+vcnE33BSs/aG130pGvqoRFJ7aCbVfXdDko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tR/Ev165; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR/Ev165"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf2911f93cso83865ad.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 07:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781275152; cv=none;
        d=google.com; s=arc-20240605;
        b=KHdFzYVEhxigeXpgbJwus6ch/gNPgGFcHgrpL0dRfgveoOvxhti1pD5MXmTuJ6RaNy
         Uu1y0OiKEGJH5lWm2FJVAN8Vb6r+yS3yUvlH+HQr9RTlSjzM/KDt51kTRZylBJH+eIws
         XXMmOZVg4ljUcaK8lBsqmQy81JoYLv9w8e4tol0pC+3vQfZikcLUL9v6aFF5ExihnRcX
         aXIM4c25d2XkFJY1OMG3jQ6IiaAnQ/NvF9qgiJGXj6VYKQNdx8tQOibsV528uJ/6ZEr4
         ntrVW2WkaBsZfwzcgkwaoky0cMexX0NiDvugTHjKjSzaKLSwKe9sqxA9VYPcB6+mUuKL
         +1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pPD0U5NZ4eXf//hJDc4itwhE90Vj8iebVbR8OA3Plrs=;
        fh=uiL5h139wipJpheQTLYxUZ66chz5tJKk4mX/QtDOFe4=;
        b=IF+puqu/ThgDqeuQ/QaiJivMykYEVE+r6ddug1TjK5AVdSJvvpLByy0VLXhqyAcaoU
         nDFLhYTkv3mqoteoAQtISHTFACCcWmXaAruRCKsmBHc3GVs7fBVujUNM+UV5khtmibYD
         nK5WL5GtvmmS7mzcJD550kTrSRe9hYgS+LotKyU69m8FXq61n8fgHJmlB7ABRcMMwKXa
         7i3RI5Bw92QMSaHJckf8VZSb88QL7ETo3oKoAtPcntifaYudxbcg+uz66YU4SMf6M641
         kjUDSELQ9yhmkYHlBxynyVkbIF/kCSogiDBNuOrrFGR74JWXKSpaWshCAOA1K/opvJSu
         ZivQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781275152; x=1781879952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPD0U5NZ4eXf//hJDc4itwhE90Vj8iebVbR8OA3Plrs=;
        b=tR/Ev165JhC48vvb/HKrpwxPMFfu1RP1N3p/dZ+LT6er0sOqiiJdJtp+7AxAPZQ2+0
         YuMyOcQ6V/LPbZitmO4wukRQbATcWNepSyQGgeMCCL2mGfz40Z9wdfgL34Okov4mRyT3
         k2r6cNf5xUTVJIVCH2ZRVFm+1TOI6ylWPzfHpCYGcI98/mpBym/gsPWjKRU9/y/y4AAm
         KDeFsvr0kdMsgdlZ/bQOTwxErAAy7SKNP9GbGtcEqDP7pGXCxnXOne+yWGTNIWyoxjXA
         O0e0Q79I4k6DzOmmi6Av0cku9XEeQyGtatBbYgKe1hMbjD7kqlKPVi/eHfNJ3ymICUAQ
         V8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275152; x=1781879952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPD0U5NZ4eXf//hJDc4itwhE90Vj8iebVbR8OA3Plrs=;
        b=T6KPOlgCZKBLAuuremGpwC3x56wWR4dXivjURsGhlBx2CJ1O9p2o2pIjg3KvwzjNRH
         82rj3s1PMDBkXE6VCLbBWG1vhmJp+9Uphw6zrXS3q/5T3ovEwfbc2lwT4LRZyA4QoiA/
         y/P8uz+j6OzZTlqf2p6YJUmNJfaeNp+Pw/hwfA5Q7uwXIPpmYSvbWZi3rHXWtHiJb7uW
         /QNLWd4egysC/lwpfKXy+zpMoL1TyG2l4e8jBgiGYPIAGaWVktpKr5PD4WE9BT4F/6ng
         jLT/zjcy+LVx0HMVCE+xdGyuWfhL4LfPC9MZtz7F5+V+yiEh/1fAKzGFx4uGiMtjF4RW
         4w7w==
X-Forwarded-Encrypted: i=1; AFNElJ9BSN4zNPnK4IKPJTsv+I1UR5qkXPUlwPbfa6QhWzh227uoR+ntip267Y9lh7VX3Jy+mbQ2JaEmMCTT0mAV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0k3YnbyQY84nnZq1C+aE08F+0IGEMwq3lyiX2uBSX4Tf/yCPX
	EMpIJVWYmfcqW1P48vZ/+WAbKS0J2qDBfXBMsOWFauZ6excC4uUfQ013mv3wLLHOXE1b3OSPswb
	yxeyoJ7UYUHqfjg9K9tV8PqGCp8VLOWw0U37obk6m
X-Gm-Gg: Acq92OEfnToA3T/CdFBx1YUZwPz7KdgozhikEtUM52tO/2tEacib8ov+GYiF+ljIROQ
	r7iqvUhSHjekg0hbkiXsZZwrj68yW13egGxY/YoDh1t2BNs+KY3avTlod+Q2TgMjKDY3iY5T0QF
	y7wZAWU9K8q+tPusJfXjkeWjt0ceNIN7ooIM0EisTeziIb7sVUmLhGOXjTHHpbqlSycqAww6KCb
	i1/4gquyN/NII+yYBraYgkhXpZVLNFf142sq0UUFuLGnsJGB9qGzaGKshRvEkGfE64sSnA8+ICv
	tELBQo+R4dJFykG6fjx0MfXLT78xHiJEslwWmhXc
X-Received: by 2002:a17:903:238b:b0:2c1:4a67:5f31 with SMTP id
 d9443c01a7336-2c405c8b703mr1596605ad.9.1781275151261; Fri, 12 Jun 2026
 07:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133139.1919042-1-petr.pavlu@suse.com>
In-Reply-To: <20260612133139.1919042-1-petr.pavlu@suse.com>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 12 Jun 2026 07:38:58 -0700
X-Gm-Features: AVVi8Cc9-HjgSxhb69tvudsXLdOhYLKLMYT9ddnMNb-ycz4VaCGBguQJI8Ay6yk
Message-ID: <CAMn1gO79nDnUXuTR6LJ61kGJ8zH5gvV5st5-OjjqxD4cOxds0A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Use --force-group-allocation when linking modules
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, linux-kbuild@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:31=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> Specific code, such as outlined KASAN checks, may be placed in
> COMDAT-deduplicated sections. When linking modules as relocatable files,
> the linker by default preserves such groups, potentially leaving multiple
> copies in the resulting modules and unnecessary group metadata.
>
> Use --force-group-allocation to have the linker resolve the COMDAT groups
> and place their members as regular sections. The option is available from
> ld.bfd 2.29 and ld.lld 19.1.0.
>
> Remove the workaround in arch/arm64/include/asm/module.lds.h that was add=
ed
> for the same problem but limited to CONFIG_KASAN_SW_TAGS and .text.hot.
> Note that this code currently has no effect anyway because all .text.hot
> sections are placed in the .text output section by scripts/module.lds.S,
> since commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros").
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Peter Collingbourne <pcc@google.com>

> ---
>  Makefile                            |  6 ++++++
>  arch/arm64/include/asm/module.lds.h | 13 -------------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e156e2696efe..1729af0690b3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1189,6 +1189,12 @@ KBUILD_RUSTFLAGS +=3D $(KRUSTFLAGS)
>  KBUILD_LDFLAGS_MODULE +=3D --build-id=3Dsha1
>  LDFLAGS_vmlinux +=3D --build-id=3Dsha1
>
> +# Specific code, such as outlined KASAN checks, may be placed in
> +# COMDAT-deduplicated sections. Use --force-group-allocation to resolve =
these
> +# groups when linking modules. The option is available from ld.bfd 2.29 =
and
> +# ld.lld 19.1.0.
> +KBUILD_LDFLAGS_MODULE +=3D $(call ld-option,--force-group-allocation)
> +
>  KBUILD_LDFLAGS +=3D -z noexecstack
>  ifeq ($(CONFIG_LD_IS_BFD),y)
>  KBUILD_LDFLAGS +=3D $(call ld-option,--no-warn-rwx-segments)
> diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm=
/module.lds.h
> index fb944b46846d..792a0820757a 100644
> --- a/arch/arm64/include/asm/module.lds.h
> +++ b/arch/arm64/include/asm/module.lds.h
> @@ -4,19 +4,6 @@ SECTIONS {
>         .text.ftrace_trampoline 0 : { BYTE(0) }
>         .init.text.ftrace_trampoline 0 : { BYTE(0) }
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> -       /*
> -        * Outlined checks go into comdat-deduplicated sections named .te=
xt.hot.
> -        * Because they are in comdats they are not combined by the linke=
r and
> -        * we otherwise end up with multiple sections with the same .text=
.hot
> -        * name in the .ko file. The kernel module loader warns if it see=
s
> -        * multiple sections with the same name so we use this sections
> -        * directive to force them into a single section and silence the
> -        * warning.
> -        */
> -       .text.hot : { *(.text.hot) }
> -#endif
> -
>  #ifdef CONFIG_UNWIND_TABLES
>         /*
>          * Currently, we only use unwind info at module load time, so we =
can
>
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> --
> 2.54.0
>
