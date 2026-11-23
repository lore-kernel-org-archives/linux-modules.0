Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457561;
	b=lFHEO2+mN7tuMSkzHPGooIW6Z7lD/D+YWTzcOZM+ZjECPj1EcXd3xazJZnMxXDBtk5iy
	 ZYgzB5g25MAU80RQdKivmwhpHCW3gMQEoOGOqFUmTB5fetuWFRwOcgqkDo9j2Uvv30JMM
	 TT62qAvb4WRc4+j65Y+ABHLD8a8cei93eTs8RJEFTOxc99qGvU7hpGkqWG8bpN4/5zbWF
	 eeiTEXtwmynUfFyYep2/6uUzlSF4v9hB9qdRZ2TZffvG0Fu2gp7KY3bIoW/RvQ1jyMysj
	 bRYOjch4zQHwaJblnfEPvY0EqyqgpQiQjDodZVUX19BVv8CUaLqWuSgkrYNyZQyo1tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
	b=UPNTw7GsPqWiW02yxNPApn80GHPVrhx36dqkQvkAhQjcmzDpmG3ZVzAMn5j7H2dipgAR
	 r51qHW40H2teEj/ryNw1FXvcXMsBpLXcwwZW7lTKyJL4FWn8Or7It52FNmr6Cqf+EWqWn
	 +DRQSf8nkvVkEBFnRBk5ncKDr3TgvW+e5fI+OsDFNgDFLP/22gxYEpjKftb1wVndPnzLR
	 OIhfVh1VL87SfR0qbrpavlnZUTMs43PmKnbwhaPfXCMSTuKNPED5bx5VoYm1QzZdxwcDc
	 RPB7J75ko9mvuBMf5SGQNcVu8dnclaXY03zmz9bVal67r6EjKEd04kH/hGQ1BZ65A4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvLZA2pc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F9606A321
	for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 18:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvLZA2pc
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b2d14968c9so34159657b3.0
        for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 10:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457559; cv=none;
        d=google.com; s=arc-20260327;
        b=YbbFOadt2fFXh+OKaZken7WLKBM9vhYtr74Y1RLDPMH+Vn0x3iJOe/MGMpame7zHHS
         CM0xrqeh1muAJ454y2qHEQ+fr1Is5LSGRYOPxJXXyiarpU8jrYLzKYXkEoRgro4p79Ey
         WjS6q6AL3LoxzCiQNGwaNK936/8KiaeGG4EUuZ7Th+b7oVatjyn30rKU0IXLP1gSuV0u
         6mtPLIvVQ+VFXHSt7LHSQs8Ye9lK8sYYoRWIFugaWux5hbzk42xlNSoPprXa/YghDZQI
         dm902SaQtwOQaBZiHYz/ealzL97x7VvgRQBelds1l9EFUCbpA7gABIquGYQ0sHDgvrgR
         UDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        fh=pSyxXGOzHClcX6IOiOK9vjnC/BbP4Vt9cl6gCICQItg=;
        b=d2yR19f9MJtahlqbsSpEoHEVp58fMj7iBw21tNB7BYjSA+VE5TKr9HgNFwmCdof4tN
         Om7AzVUFqEQtc5OajcxPxWD+3g7jFY55qwzHvYh+hCANec9ZnG7ZSVV0NaWOwhCl4mza
         H9AAXCzvTAewB8RiAGT63Wa9gMrO93IsqMzD0IvQc/423iZMj8SQqqUyTCeyRkv12HBO
         eg4dKLHRKWEzcmreQL3WwX4YeeyluLRHE+nYKh6eSkhQ6IUaxsmnVLJWVVZmyzecr19e
         m8wQB3Y9Adig7mi9A9oFFSGIwrxzZzQ30i9ifxbSjNxbDrYY4JQ7c55DaycB46bBexWW
         G4CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457559; x=1796062359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        b=ZvLZA2pcD9FH9HECe7LfubP1g4r7DtXRTfLw+a0fSCVHRJ58hcWDYhSRacl6iWIhx1
         vem+3JyEz4vOLSZ+IkUJHfzXgIjCFVthSNx3d4mzu9P79SfAolAw4Jt4yzHmEPZftFFs
         rR44xHk1UdKlXpN4nsj8cuw28Pu4f7r8OoDysRubVnO2x1wYTvw4Cv7a++edFCAgU7xv
         FwyOp8/bmeVoA8845IWW+N0pphOdNNyL2IUTX1caZ67sYL7dqc3DVPzzaQ1OhL8UsU0T
         ppHemCUM2GWad10r+4RYwS/DZlVBqx2dNyPjbDasXB+7Kxeyd98kKRzbZqgwtR86cUL7
         YuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457559; x=1796062359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        b=qdAsR1yVx45j0d7utZtUaZRcD3IPi/f66Bmk2eUv8sZzAXwhFsO0LLJZhx0PrXO4AV
         Xws7NyA54aneytrFu7BzEEbM6J6F0SqGhr9utBXs7yBzf7H+QD+s/e6SjHBgw2wMtjk/
         3ULGoNzGVy+FjWUtXhF1mJYl9A7pRrI11g8EjBSfrt2zvIMMTMI3l/0WNevE0x0sbjPC
         Hu5BBmKwL6hgox2hg4GRSFHVqJYsTIg8YiltY1UZgkJ8ew1iGdvOkdzQoHi/qeqFamZN
         hsGP5Yi3x+kuAsCW32KH/PXR7HL2EXsvyi52dlyf9KPLek6tom7OevD1IXEIwr/t8+u1
         8J0w==
X-Forwarded-Encrypted: i=1; AL+hErE4u6hM3x14r+Q5BXQuDZuzWaR7z4bK2nBrV3wYKq2Ef6BA7uDutTSMoYDouhQsvmVDwjH4BfR951lPR+Y6@vger.kernel.org
X-Gm-Message-State: APuU4Z/Aat090ZtLkis06MyzQ85v+ov9AOAME8xnTCe5zrZpz7T6Sl6P
	UPOX8TseEXL3nzeoCSS8ySrwBlUYxqrWjAGE72/pLBEztdUkKkHps9j03H/7zRzLdOdQbzlOlM9
	RKPUFwKUbMwEN834b+kstPCn5WD5i8rg=
X-Gm-Gg: AZFdTZfsPYnRCCYSKyXXQSIQn72rVZ8ZCsoC0bd8Bs9g6No3uI1bjLBZLOj3mhatx2O
	WceQ3wiNm3siEuDq/6H263+yOZFJmbUturWSqedXMOKq1vha8WEFHALLB4DyOpzdMddEQtJW6pF
	hRlDzf5fQ5jTUSmLQ9LeS0wkMW58H1oRQ0rINfNvPzo2kDBoldzevpuVvGoB2MY+Cch7SIXE3S0
	QPW6EFw8WWMChkxm7GZ1Di3In5MDf8T3PtsdOcb11nbaLld1sMw36wU+rT/fOJvAVvbdWXRM6p0
	XwbmgS5rK4GvJ9rTN52XkfXHisIJ2cNQSE2KLjgRIkNCaorkQJR2NtevuDKw+OuBzukmzE9rodC
	iUFwhppma0KeYyiPD1KusGyVi03/ibnumKZRWceEqtZzddFyzELYygkSUQ20BERsOLxTCh0aEGE
	KTZLKlDRYyrj3K/iyeHd/3HKXbhMhHVtN2pYR6
X-Received: by 2002:a05:690c:c96:b0:8b3:4b5d:b26c with SMTP id
 00721157ae682-8b520435e51mr43853877b3.13.1795457559039; Mon, 23 Nov 2026
 10:12:39 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
 <20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com> <20261122115458.1da4b8e9@pumpkin>
In-Reply-To: <20261122115458.1da4b8e9@pumpkin>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:12:12 -0700
X-Gm-Features: Aa3M54p7oziKjc6uiBqsKJw-wMOKZwA0vwboFiGz1_X4unEm3KI8bOmikp-yLOk
Message-ID: <CAJfuBxyxu6FgcX-0yr3QaYOyDH0VZwvtaSU7HpqBU7_AV8qCVg@mail.gmail.com>
Subject: Re: [PATCH 2/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
To: David Laight <david.laight.linux@gmail.com>
Cc: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 4:55=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 21 Nov 2026 15:49:20 -0700
> Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:
>
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > These macros are unused, no point in carrying them any more.
> >
> > NB: these macros were just moved to bounded_sections.lds.h, from
> > vmlinux.lds.h, which is the known entity, and therefore more
> > meaningful in the 1-line summary, so thats what I used as the topic.
>
> Maybe remove them first?
>

yea, I'll do that.
thanks

> David
>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  include/asm-generic/bounded_sections.lds.h | 15 ---------------
> >  1 file changed, 15 deletions(-)
> >
> > diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-g=
eneric/bounded_sections.lds.h
> > index 8c29293ca7fb..268cdc34389b 100644
> > --- a/include/asm-generic/bounded_sections.lds.h
> > +++ b/include/asm-generic/bounded_sections.lds.h
> > @@ -18,19 +18,4 @@
> >
> >  #define BOUNDED_SECTION(_sec)         BOUNDED_SECTION_BY(_sec, _sec)
> >
> > -#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HD=
R_) \
> > -     _HDR_##_label_  =3D .;                                           =
 \
> > -     KEEP(*(.gnu.linkonce.##_sec_))                                  \
> > -     BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > -
> > -#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _H=
DR_) \
> > -     _label_##_HDR_ =3D .;                                            =
 \
> > -     KEEP(*(.gnu.linkonce.##_sec_))                                  \
> > -     BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > -
> > -#define HEADERED_SECTION_BY(_sec_, _label_)                          \
> > -     HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> > -
> > -#define HEADERED_SECTION(_sec)        HEADERED_SECTION_BY(_sec, _sec)
> > -
> >  #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
> >
>
