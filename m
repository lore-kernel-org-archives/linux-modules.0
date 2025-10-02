Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75A2417C5
	for <linux-modules@vger.kernel.org>; Thu,  2 Oct 2025 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422781; cv=none; b=snLwMD5R//l7rmqcmnSdAkJpziRNyDaZj3eGAjecBOWIHrWw2e0p5m1ymrRkHApEAI3OSyaLvg7jIyERoxJlBVp049kaCijBlUsIXg9YsSKlFNS0TGo680NOURLjIX7TCWY5kHIpSuq6PX0EvC8QxBdKJbcmCrBIokhugvaNzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422781; c=relaxed/simple;
	bh=OIoBlJxedue7cFPlUKgJeYCeNnkdgr5da1l3r1pk0X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gArazA39JDUsGxgIQHDdanOuLnZQ9hmgIYhh6xYCsM4vLYGqotKado24hZjySlZdBDeWTI1BYVmWExsYQC6mQRn6fjd+jg00ld3dtMdl++axU4uplYuIAYEZdmOcT+xF2kM9MvllZXepOuwnVSNCfaCILMZYYWt7f8hOCIfV7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO1gW2/Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO1gW2/Q"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78127433a32so1005449b3a.1
        for <linux-modules@vger.kernel.org>; Thu, 02 Oct 2025 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422779; x=1760027579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez0M0Aj20Z7dwYg47mICpmFbEQoKpvWZN0OyB0vWYIM=;
        b=PO1gW2/QcNJqwjmmpREOuE1Fs2PFiUc4xFqTylCB689RaXpp2m7ZOAWnsFg/u4eD8a
         85MAc02dw35SIe4qcCz04F9WAl/hVpJz32xqabB/0vqP6mvhZHo5JUsnC3bRUu0aYjYC
         SdB+agy5dYSvhXs2vVgSspC6UnBUJjWqc64YKDKJQ8wtuQaT+EWAavOvhRzugFHBDq2p
         zcQFWjkTaPfyRJ8xA+fOltL0+WYkqkAv6K5JQ4SMD63JVZvVcmozYIHO6ON0czf4ZVWR
         p34AeScaJHXl/yJVlKjzM4EicVjkdPxY98LmMY41y9jL4xMj0eGJD8HaoZ08IYiEEqKC
         uDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422779; x=1760027579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez0M0Aj20Z7dwYg47mICpmFbEQoKpvWZN0OyB0vWYIM=;
        b=stKFji7Y/xPnSH7s3g01hBbL4huec9woDWPLFhDh8+MnhoQIHjBhqhEj2Tt7+bdXOn
         Hg/E7e7EBTllMOvmogBdlORPNWUGfiBI/DJR42IzjiQOAJ/D3AsB6d2H8JyA+uhhXzEA
         Owuv9VHrMWLcL3gXWJGRK9RT4K3o2s/AN2cz+Mk/Esnj/S9Oed8c/pSnxK4Of6EDe/O0
         TUFacL1bXxAsLx9D0cUlwlUh9aWVKy/Nh70VNnOkqeOuQjBIGvU2NhMZhCgJG9GIEvLN
         97qM0mNFf4zDjGsR9RTcpejNYWw2tsHGv741NiTnWrwQpT+ieK/C7/qS59CHrTxKkcKX
         e84Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfVS5Gw4nUqlrCj5Vfb+ouzg3q/adqZMH3/ePyQ5UOM3fn2RBvnuUTbPiLvMd3hOD/5KpyWwDZzZxuLGgR@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOjweLa83mvasuT1ljRchl19b9LMmuRlX1oWOVOrYSE/+eWya
	k1jVZfmYxJzGYiXLK8WnbWm4CgKE+LNdqSVEAtL/u/YBk4+R+v/9JH5/GfgbPouu+SVg3bzH6xP
	cWdnGYIDg3xJjO4Qf86A9N8KWcqdgJr8=
X-Gm-Gg: ASbGncsn3iCibJc1P5JMn9U5/pRF/aPEz/qhYQAp5Lwi7/VbkzNPqTrfhkbJa4ofoAY
	dDJudqwZvnjQ/rM5HkXzdW2z8gqmIwAzRlew3+lQ4L2jXCAN81F3E3O7FYHM0Dpz07W2oF8ti5o
	FRSn1pemtyJ6IVM1638+mS+wXMnu0VKUCdhJvs/rVaCJP8QDwd3yraeuOtRaN0Z7pSBuMz34JhT
	mpH2UAY7yleN8i4ZhUz4dBYtdRu9CQ=
X-Google-Smtp-Source: AGHT+IFVsf/3b43N6f3rUJuCPERQjlfs8pncdypMufpmJyxOVCyX+x3BzNvd8mkPszvC3qfUZz/q6xzLBY+xfR/Fp+k=
X-Received: by 2002:a17:90b:4d84:b0:330:4a1d:223c with SMTP id
 98e67ed59e1d1-339a6e955e2mr9907319a91.15.1759422779326; Thu, 02 Oct 2025
 09:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755535876.git.legion@kernel.org> <b2d50fde039a0a7e2d1a9db6bae8b83cd4ec4856.1755535876.git.legion@kernel.org>
In-Reply-To: <b2d50fde039a0a7e2d1a9db6bae8b83cd4ec4856.1755535876.git.legion@kernel.org>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:37:54 -0400
X-Gm-Features: AS18NWADnzGOdqIhXZpmfGAb3A3etsheN66_8WKH_yIi4ZMCgXiLE7dTSzZXFFQ
Message-ID: <CALC8CXeYuUEQBdwNirQ28P6ociMGatgKiO4hBdaahp9T_Qfgdg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] kbuild: vmlinux.unstripped should always depend on .vmlinux.export.o
To: Alexey Gladkov <legion@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexey Gladkov.
RUSSSSKKIIEEEEEEE
(Rus)

On Mon, Aug 18, 2025 at 1:00=E2=80=AFPM Alexey Gladkov <legion@kernel.org> =
wrote:
>
> Since .vmlinux.export.c is used to add generated by modpost modaliases
> for builtin modules the .vmlinux.export.o is no longer optional and
> should always be created. The generation of this file is not dependent
> on CONFIG_MODULES.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  scripts/Makefile.vmlinux | 9 ++-------
>  scripts/link-vmlinux.sh  | 5 +----
>  2 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index fcc188d26ead1..dbbe3bf0cf234 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -53,11 +53,6 @@ endif
>  # vmlinux.unstripped
>  # ----------------------------------------------------------------------=
-----
>
> -ifdef CONFIG_MODULES
> -targets +=3D .vmlinux.export.o
> -vmlinux.unstripped: .vmlinux.export.o
> -endif
> -
>  ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
>  vmlinux.unstripped: arch/$(SRCARCH)/tools/vmlinux.arch.o
>
> @@ -72,8 +67,8 @@ cmd_link_vmlinux =3D                                   =
                 \
>         $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";       \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
> -targets +=3D vmlinux.unstripped
> -vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORC=
E
> +targets +=3D vmlinux.unstripped .vmlinux.export.o
> +vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o =
$(KBUILD_LDS) FORCE
>         +$(call if_changed_dep,link_vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF
>  vmlinux.unstripped: $(RESOLVE_BTFIDS)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 51367c2bfc21e..433849ff7529e 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -73,10 +73,7 @@ vmlinux_link()
>                 objs=3D"${objs} .builtin-dtbs.o"
>         fi
>
> -       if is_enabled CONFIG_MODULES; then
> -               objs=3D"${objs} .vmlinux.export.o"
> -       fi
> -
> +       objs=3D"${objs} .vmlinux.export.o"
>         objs=3D"${objs} init/version-timestamp.o"
>
>         if [ "${SRCARCH}" =3D "um" ]; then
> --
> 2.50.1
>
>
