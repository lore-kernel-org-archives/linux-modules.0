Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00709A933
	for <linux-modules@vger.kernel.org>; Tue, 17 Dec 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734395373; cv=none; b=SnusSzxY0XVhjI5ZOsbiUz/VRvl7oFFcJldceKo59xg/n0GubfwxyPHdPaKb1ISk4XYWLZO/p7+27O/1Nzg7O3547lKL8AEp6XWOZgSzgQfWIkZw3tq1qGB+QapiW0Oxxu9OuzMonVQ6zYVN7qdGtHzDun1sA0qLre1oIYKFMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734395373; c=relaxed/simple;
	bh=EcMHthg8w1+nS6G5Zs4+7mc0M0kkZqrbK9TwcDBa+AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLt5C1FfBgYtlSbD9Uq7Ru5wIJgwXX7YNtRsOXs827GJmp7iZ4EMezBHMnfRMkk2WKV4XE4jlGqjqMeF1VSgYnt9jo2hricHrFPS4zY7HWCHoMpQzNvMfR5ghIRCHDRC5XiYBA4kWyCu4RWncjEZP5SUuQiEXf+4CUxhTBmIwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mN5EcNW9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mN5EcNW9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso4339a12.0
        for <linux-modules@vger.kernel.org>; Mon, 16 Dec 2024 16:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734395370; x=1735000170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcMHthg8w1+nS6G5Zs4+7mc0M0kkZqrbK9TwcDBa+AQ=;
        b=mN5EcNW99p0a/m15MLCy5FgbzR73l83cvVDY3nylpKt0BVLymchG1XSdFYwt9t1Vve
         THoJ9JjfazCJdHEAe0vcXCvOcRzdBy++hcTPwL7b3v5DA/phnxi3+4Pb4AmpywvjofCn
         NfiL4PXGfESvLpCcyGnc20f4G81c7bfM3KfHdlokpu/HMSRQkn3dYQR/Af/saEvHu4lh
         FaoWYpc+/fnqYZ7Icu1Nm4eMl6NWE8Z/SpvWEwhloiBlDDbgeg2AiHqQZzmLQX9lTSXj
         3uDA5k5HA9ab0HlTbNbSCPDdt5x7VoncrmaS3+3OvwhiyIxxbRmCrBMzA/hppgw20lmk
         7uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734395370; x=1735000170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcMHthg8w1+nS6G5Zs4+7mc0M0kkZqrbK9TwcDBa+AQ=;
        b=nMhk2cj/U6mnfvWgYT0OzI2HgcaezhddcMwi3cqa5qFcl2NHFbMt4ErOSVXVBnEoTg
         qbK836g3bbNarbt18vbcHEzMfZ2+VFXLmhwS4nT2bEZfTuk9+mhyT9S6EArOi8lZLJmm
         LHi9CYzGo+HIAcv06fATNX6Bgf8CwQCOjibLee6jcdrctaaENavKJVyKsedmajl6+kcM
         y8tOr4jpsZ1UuI07xTlIZAvyxX5A0JOyE+3aYUX7fKodgZAIYvwT+GjXB8f05Dpaloc5
         xM3Y6WvZOlY3nKB63iAdjNKHokURtCB1+FCihD/V6de39gS1XFtfbSLtP/t5ffFqdFKN
         flXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU+vhGNhh+4ZaSGV1khtghV5Jn/MZlQHdF1nj/YgJ+vGO98wMz9Di7n+eiENSa2LdqGasPwyMIxiwg+vtG@vger.kernel.org
X-Gm-Message-State: AOJu0YzH09vJthLOUV5dyrxqLFcG29uWs6wFuB992r9FtnkOIC+7vJKm
	F2WUwVJY7VvOwO9NF1GpbJVKFBAVcum0HISED8NLxS3rbnmXmbz0QbsUzB4yrazKvVeh+wn3H7N
	CyGPZe4qqHCBbC3UIVz3MX7EOzpKAhCMDIJH8
X-Gm-Gg: ASbGncuT7iv9a87Jey4QiSElwSqKAHU8Xep+KVLe7+M4T/2HTu/CpdHzJFHTOhEhLSq
	kQloW31g9UpEPcb4WWlGLJNwFLhz85ORtbmU=
X-Google-Smtp-Source: AGHT+IGJ2vMJeNxhiowuw33Qt/H3cjobYWBekImH6tWUBKuxTu+odWdOFkVa8jp2BkFSKsaw+CS/TQ1/n07AUP5JKDM=
X-Received: by 2002:aa7:d3d2:0:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d7d638f84dmr41885a12.0.1734395370189; Mon, 16 Dec 2024
 16:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-38-samitolvanen@google.com> <CAK7LNAS7Pi9=Hcm7Kr=Ju4fMWK4taXEPLOqYombSLqGQ3ehR+w@mail.gmail.com>
In-Reply-To: <CAK7LNAS7Pi9=Hcm7Kr=Ju4fMWK4taXEPLOqYombSLqGQ3ehR+w@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 16 Dec 2024 16:28:53 -0800
X-Gm-Features: AbW1kvaGgMMEILJN5boY_yIqECmEZxfHxS0KrWFUsA14957v4WM1ex3EXvwLDI0
Message-ID: <CABCJKudLD15R1YoR37NcKGZPqdwrwBVLcoCiH1m-HDZYUt+Gfw@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] Documentation/kbuild: Add DWARF module versioning
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 14, 2024 at 3:34=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Nov 22, 2024 at 5:43=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > +When a symbol pointer is found in DWARF, gendwarfksyms can use its
> > +type for calculating symbol versions even if the symbol is defined
> > +elsewhere. The name of the symbol pointer is expected to start with
> > +`__gendwarfksyms_ptr_`, followed by the name of the exported symbol.
>
> I am interested in this sentence.
>
> __GENDWARFKSYMS_EXPORT() is primarily introduced to handle
> EXPORT_SYMBOL() in *.S files.
> In fact, .discard.gendwarfksyms is always output for EXPORT_SYMBOL()
> from *.c files.
>
> Can we make it faster by processing only symbol references in the
> .dscard.gendwarfksyms section, and skipping all other sections entirely?

I don't think we can, because the DWARF type information is still all
in the same .debug_info section no matter where we place the actual
symbol references. Also, locating exported symbols from the debugging
information is already pretty quick, the slow part is actually
recursing through the types, which would still be the same amount of
work even if we had separate debugging information only for
.discard.gendwarfksyms.

> > +4.3. Adding structure members
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +Perhaps the most common ABI compatible changeis adding a member to a
>
> changeis -> change is

Thanks, I'll fix this.

Sami
