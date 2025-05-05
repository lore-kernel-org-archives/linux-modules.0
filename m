Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2E1624C5
	for <linux-modules@vger.kernel.org>; Mon,  5 May 2025 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472595; cv=none; b=jyWz1/lWzxUjfx1izASxGU6WIONktAk5Q2r1c6i65EdgN7xQys1XHk2wVISw49noigq8i2Snr27bMJYr7MsL0oq4vqG9M2NBW04KhT/7m1aIFb1oajr+Jcc0sx4HAqUOapwpxv9vMuZfJCjnATFPBg+H9X+Lt7mM9oVSwD0NZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472595; c=relaxed/simple;
	bh=HVlKQTkpmc1YncJ2iiXAkylrcADV9GXDzdyqB/r3UEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPO6LavAUqaT3hvMFPzM96vO+owRSaV0Aj1Zgd1cVuaA1t1LtI0OHXcgy0kcOjnWI6j/kfrJ+TYa5EQ5dJhEyxc7vrKNJ+hCTWmHVbBQavWFeAkuXkcFZz6V9FEV7L7JUbtFN+ATE/WNJpkOZu+3FxCakRLputAXLvFkZP/1OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMt22awz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMt22awz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso1978a12.1
        for <linux-modules@vger.kernel.org>; Mon, 05 May 2025 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746472592; x=1747077392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UqmbbEpCvFVQT8fRSD8VX2Mt6JubvT+2Yu+nTuNU8c=;
        b=FMt22awzqLfxMFVC0kd1XsqjMvjSHAfbat3moOB9zAG1aelJuQz2VBpoh0iOuzfaZm
         giiUvD8mBc+SZvlvHhwcEkDwiW4j0xR/Br/OSmQ/B1f2Jb62GqhO3mircSmy3TGedfGX
         Nc56wszQuu6rsHnZ1+lzg2F8mBHcIiUyjmdU/nOAcSr76C+Oe/UnF+OHv9sg/OinEUdo
         uKtCYHfWAojfmOkoSt/RMkb85r2C2GTFt3CBfFiHKPlA+UvLonmVGo9u59lD1FyJy+fT
         vwwVGOnppEsEyuUMz4jFBe1QM4zSMA0KeryPuzuWMmicgAfkeOeD6mn9iFSWe7+kCFsT
         mrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472592; x=1747077392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UqmbbEpCvFVQT8fRSD8VX2Mt6JubvT+2Yu+nTuNU8c=;
        b=UkGx6BeDsrcknDwefYuUqavtOHAaz+UfcNtZgRbvwH+MqvhFnG7vv5fGjKFfjUUulM
         S97prdflcRTVaYZFXOHXufGKZzqZDMdYC7UyDN3gp7eqyZB2GsnQk7HGmnh+eJdGykBY
         DUf4TXbkb7mD0lAqbynAetO+vjzYXyR36SMbcsAxcbbOiDpcgtrP5AnvRGw2wfmEB8mF
         fWz24ty6JjmbghrGXeXboYQ4cNyreb1ZNduqMHtumayJQT229vze5a3j7wxfgbcJuKtm
         G8jnsaQJi/pt55M6+d0YvVz9onQp/xW5cLqI16JTy8uP4PemzJpH0pMgJTgGIwTzm9Jg
         bx9g==
X-Forwarded-Encrypted: i=1; AJvYcCXMiYKaRXP8XXs+ZZppphVJBtLmN/iikvtYHLiZVPDdyVPcMF4mupxUNXzQ6n8lwChlWD+YQ7DV5Sbozktd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dWjzdtXBqVpoh0FLqk+AV6xKRM/HRvWpqynpwrmNynZq+eNE
	FRUps0MkR6nbDp23SyGHaxXdQrR5X+mz/OGEUhe2Zct/v2V8YJOOn4l7/hdjn78rxCxUvfecU13
	NST4ApvuhI47BJIGIolfIEa0uKCe9iDudv7u8
X-Gm-Gg: ASbGnctBE5jIrJZrXaqMutufKuntfFalztKG5TSjdjkvh7rZAYykb0A9YRCCoBk4K4o
	iuCl4SzY+9AKX/FWUJKx6nxYckSKjchx8D38rn5Kbky5Uzy1xm41tPaLoRuMHo/z1QVu3xA3IJy
	vKQ1EzwT7+4Y+LkQMh+eI=
X-Google-Smtp-Source: AGHT+IHmEndQB6Tu83bwh7OyDMnJ3xUrTl1zQK3v8JOE6AWXBWphQCyFZRFldhee0Ein2K66Hf2nzymTQKHcwAOhqb8=
X-Received: by 2002:a05:6402:1a29:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5fb72db5ff0mr461a12.3.1746472591505; Mon, 05 May 2025 12:16:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430214049.2658716-6-samitolvanen@google.com>
 <20250430214049.2658716-9-samitolvanen@google.com> <5b0fd8c8-8466-437a-95de-581075f8faf5@suse.com>
In-Reply-To: <5b0fd8c8-8466-437a-95de-581075f8faf5@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 5 May 2025 12:15:54 -0700
X-Gm-Features: ATxdqUEpzHMDOd2NBhfWi5EWsSiYjrdwE4P-bz0XIe34l-giW6gjF4PygfxhK6M
Message-ID: <CABCJKuc+mXoWZsQRwCMB=8R8WM_bnC-pfEpkdyQPqVnyQ7Kc-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] gendwarfksyms: Add a kABI rule to override type strings
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Mon, May 5, 2025 at 5:17=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 4/30/25 23:40, Sami Tolvanen wrote:
> > +static void type_parse(const char *name, const char *str,
> > +                    struct type_expansion *type)
> > +{
> > +     char *fragment;
> > +     size_t start =3D 0;
> > +     size_t end;
> > +     size_t pos;
> > +
> > +     if (!*str)
> > +             error("empty type string override for '%s'", name);
> > +
> > +     type_expansion_init(type);
> > +
> > +     for (pos =3D 1; str[pos]; ++pos) {
> > +             bool empty;
> > +             char marker =3D ' ';
> > +
> > +             if (!is_type_prefix(&str[pos - 1]))
> > +                     continue;
[...]
>
> I'd find this mini-parser more straightforward, if its main loop started =
at
> pos=3D0 and looked ahead, instead of starting at pos=3D1 and looking behi=
nd.

True, I'll send v2 with this changed. Thanks for taking a look!

Sami
