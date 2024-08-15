Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720D1420DD
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754036; cv=none; b=G6KXvRnamYo0sSjjWAJy9HlomX+o1HDvp27sALbJ8zCZnd8adKN3QxCM9EnfVOqkKK5IhukxC/Uex3kLglcqFzjcGKwWkVsYqduiSvoGLeUniJSR4+znwEd+b3lxSjA2hZ+plBsdvE4OvXPw8pVjrOIubwjOw+zAxdrZlck+Z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754036; c=relaxed/simple;
	bh=SR+HJls7rN8EZRV4DdYxnxKWzOEinOl5EQrLPe0+yRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxEOWsHkIz+0Kvr5uSVPPlgDXfyIf9Qi8qgXN6NpzLfI1KCP5jIltfR8isuxCtkqgFgqRupapznFOWbn+Koa8m/cUf6YOSqYp/Ev3hKTmVISGKg2CySndJa9YB40NgKG8uPur8I61VyqBJjItutBrdtVajm7Mysdes2VIViUbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBWTX8bf; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBWTX8bf"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-493d7455231so479816137.0
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723754034; x=1724358834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUB5DtqEXasUqeTn5ggBGYiSPHH9LQLM5I6fa/JbtdA=;
        b=vBWTX8bfVNwCAXzVCaJZ0CtOCATQMCbLjd5BmgDof51ZSLy2q/iJbYwkT0FnoX6a/o
         BtKd3Fxk0OrNAQcNIA7Fna0xUXnsd8Bpsil9+yt3fSi7z31A9tzEBD8XOxWfOVugH3/V
         BYZlZxCP3mAUwZWY2BnXDnsXG1jJ6+KdSiex8yU0yPqs3DQWiQNQbDCwq4NVKBuwj5hR
         bSdPktJ870ns9ss5pDa87z9KSMOLMu7MsUS0JgHu7ahmZ1SxVfqfjbkW3hPihJRYp3Tf
         ZZUJ+iCZkh7EZA+viThthqlHacztHrCPIWVq66w/+56df5/v+Bnlxeqysm1ENDwguY1g
         tN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754034; x=1724358834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUB5DtqEXasUqeTn5ggBGYiSPHH9LQLM5I6fa/JbtdA=;
        b=VRL7d5u60THRpvn23TTVplY3oQJn6RbFT4cxM1SI+GP9XKHiYZBuxxrLrwbFwk7S8q
         6FtmpqL28FRR5sj7RIG5CUCxE0XFz05vdm6VZX0bWe99CJzxwBVeitaRaMy+OZD+FPHZ
         KAQWcBkH0FcODTTAcwX/IWVOBFtcmjrFWv+rpmGe4iSx0EP5/jA8kAmtRQvFIe3gSpu9
         5kCNWJx/A04bQoxyFRWvz61zdDjdJaLczcDDfpnRKjNxylthX8oUrfKfAu1sNiUaBwRS
         q9pTvS5CzEBwD4NK/IYyrQ26dWO/WX+3mk2I43mn0Cp+mB+TZi7vRVZ4FLebf4MYQJm+
         45sg==
X-Forwarded-Encrypted: i=1; AJvYcCXJGAkBhOvPzJR8PnXPRqQYNUz8CURL9yQ6pOXTBH58uiVGh4sVvkypB2+FRgy6fsMQlPgDEdzQahNha9r5bwsP9jNywbad7PY0faen6g==
X-Gm-Message-State: AOJu0YyhcMCj4T55H6qqZGp+eL+6u1d461qyY6HWGwPbEEQV7lMQ0WtZ
	GKHo17NwaKENHo5jRf4K+mrYrUMjlIMSP/mN6qVNbov+yDzrqU7+NZFhOq4qGFS5lHxN7Tw3yaD
	Ytr+qdH3PQx33gBXPSpbF5RWBoA1xQOSFgNve
X-Google-Smtp-Source: AGHT+IGfmuESjcg91WnDqUqkDtn8UIkv+97xiwN4+ScLJKsVEkWIs/4dVOABxE4IIaU7W5co17m4OAQqJ19lGvWOC8s=
X-Received: by 2002:a05:6102:41aa:b0:493:d41a:1185 with SMTP id
 ada2fe7eead31-497798dc938mr1347334137.17.1723754033614; Thu, 15 Aug 2024
 13:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com> <20240806212106.617164-15-mmaurer@google.com>
In-Reply-To: <20240806212106.617164-15-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 15 Aug 2024 20:33:15 +0000
Message-ID: <CABCJKufJK0WO92wnW09VTLqZk0ODxhuKQG=HbKE-va0urJU1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] modules: Support extended MODVERSIONS info
To: Matthew Maurer <mmaurer@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Tue, Aug 6, 2024 at 9:25=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
wrote:
>
[...]
> +void modversion_ext_start(const struct load_info *info,
> +                         struct modversion_info_ext *start)
> +{
> +       unsigned int crc_idx =3D info->index.vers_ext_crc;
> +       unsigned int name_idx =3D info->index.vers_ext_name;
> +       Elf_Shdr *sechdrs =3D info->sechdrs;
> +
> +       /*
> +        * Both of these fields are needed for this to be useful
> +        * Any future fields should be initialized to NULL if absent.
> +        */
> +       if ((crc_idx =3D=3D 0) || (name_idx =3D=3D 0))

nit: The extra parentheses are not necessary.

> +               start->remaining =3D 0;
> +
> +       start->crc =3D (const s32 *)sechdrs[crc_idx].sh_addr;
> +       start->name =3D (const char *)sechdrs[name_idx].sh_addr;
> +       start->remaining =3D sechdrs[crc_idx].sh_size / sizeof(*start->cr=
c);
> +}

Is this missing an else condition or a return? Why set
start->remaining to zero and then proceed to assign a possibly invalid
value to it anyway?

Sami
