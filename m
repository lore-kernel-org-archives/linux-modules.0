Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457311;
	b=IbO7dCltg/ycq4fIEbB7uZ+vU58s/ayK+3uIx14n+FJzrP6pXVpK9wnuJehdUOYQS1ZV
	 kNrD/wR/jWpHzXuGwUAtbHUcyjlJ8mPZVBF0LIvRajmsrVYlI8AfiYTsye1kJXutgQzOq
	 j5Y+KdWDxiNVGTUqs6jGPyAMeFvGfbEJ4EZRDYPQvk5UlreDwb5rKjuz39u4S3ZYUzIHj
	 niYIzryQMDv9GvwbMxZQIVl4jZe5sIzdj2FfC0QqfjohcEOfh+bjfLbgFWWmyPaLZK5eM
	 6rNDfkg1MdS4mM5Ix0jXI9J9eTjwOrsxDxIgiN74OrXxQ11eMSPVcNOkp3Bk1Fhpb8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
	b=a3zgs6lEJN4bA54Z/pduZ7urKreg21Koz28T4vFCQdZHlFheR0++e21283B7e1yDE8tI
	 jhoPfMgal2zYw7IBV3H1KXjok0e0UGLnRzgG5ZIEsw4lePdHK7lH2DnFBu/u9XGXlLxA+
	 1bbEOES9I1vKx3HOPzc49t/d9rHeliRISHvwub98cuA7KSIipBzEeToinYmf+PVWdipg4
	 HFhL3sBclfUMvO0hoAJoOzIuf6OjOd5vVgQRu3jcDBn/JdwtBmKrLfh2RN64elFx9Vodd
	 7RHaSXbdoR5GAehxzZTeoX7SoaCnc0AxGEE1hfVkdXEYtlDXWrpy/L/x5tfUTBp35iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=un+KrnTE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2831606A32D
	for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2831606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=un+KrnTE
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4cc793704so25156187b3.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 10:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457310; cv=none;
        d=google.com; s=arc-20260327;
        b=lihorzHbG+Kaxp9J1W8zCx4CrnsL8X708qEXHmpqKFVqwMtQpTpJlaKtyHj/1Ez4EZ
         POLY24x2+D1O8JQIZciNpvBmmW3ThDQ3oRVmW7Mh73CDOxVNF21EZVL/xWc3/g6Z+3PO
         WFI2JLzNJb5fhySOuPhXaXpJ9yn69H3BhmOZ4vltzWeNrP/p4hoi32bRItAovjZa8Mlz
         OBMvMrtH8KP0sdiK8pSWy5fZkdSOjOlTWCmbIZuGiJkWWpQw1p87bouuLVnoAgaKQAlk
         I5fRs9zuKXZzj3l8vxp7GYEISNDW2VZ2/xyQGY/yscd02apl9kpkCrz36OOBooxGlmiY
         5nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        fh=VD9UWAH9gaTlaoEgQwj4ZKo11fqK11nOSbUg8zII5ZI=;
        b=I9QnVXrELJ4LN9cEdqiP19sKmCk79CMAg4QrkSAWWvTRHAd5c34beJLzOICRamPnJO
         Cy8jE5cXsyFes27DS0qJ9GmRMwDoZCS4iZIpwNR3zywo4KvFivbu41sgPR5LKrB3qoFx
         A1Jqcdg3JqO7nGvUoNeXE3j6CuifUBUdi2Eo4FubQ7okQ0Retq/dkEZRabDukPRFuNY8
         fefy3GysCVN3fWAA1EpZ/fxQNnD5cevuhvz/JTQqwRCwl3ts8Hqdr5zVUga0/tCH4esw
         RzidRBUbmId3LuI7CB76eGHNtPVDrq7USLXH9aITGv+gol2Ww0VqTexHsDOXPaQ3CfX5
         m5YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457310; x=1796062110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        b=un+KrnTE20u4uKJ0y9QdxzvTq2vJ/RVHg5bge5mrgE5548sFECDdSkyp0EL9VmSZlE
         ojWp0lHAYTFrWPbdWm+ukpizQSfFUNJE2pLjjPiSR2EwdTiUsBdv7r1OXfpv5fDc+h9h
         t0wb5aS+5Yfsd6uGZ5jJNPB1iYDBq1ZE6CRQDQlFSyDWC/FJlmp7NaiiLj/ws0nzX8+H
         foqngf+GfhcT5MNWiCeZeR1y8CQPqT4jdFTVQTSCHd8eao23yVGwHidUWyjXFk/2Fsqs
         Y8kH8TsE2c+4Pz3MFmFD1+DWT5xTAqe+lGK8KNtcd1P2w+OwsMZ/maOBMR+e5b/rr6SP
         ZK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457310; x=1796062110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8coD+XWZF+6IAMbbF9oMOg2qovtZBuAGzKp+jSJ0jtY=;
        b=rPkoFjRupb4wzXmt2CeLZQNJP8MaqjpLmwhyHtjNy3vzwfBiavRDnGXXUBQJnLyVMh
         8IddIldPeaj9zYlBloWEVkMTRScOTj0C8HhxikOoBIBW+peednza5TybXWtJQlYws27f
         eP8dO8GqPJsS1wzNvm6FywuKj6zGz5wZqlX4r2BgNfvsfEeQNz8hO13fuYq/z2l+Z7Dq
         xy/UFYRD1Rru7G2rxW3Im4kNJ+M3+UJbU2UDRnU1bcGA3XSKQXOBiJJkImKBjasKJ8GH
         w72J/rE9agu9KcpidK2gnY6d50fMkL+sOFuz6asbVkQpZ+X9WqZ4fMenDijL9PCugt9Q
         izHQ==
X-Forwarded-Encrypted: i=1; AL+hErEXrhXXEBgeSVxOaGl/y579JOia9+SMIKamTLvyz2TCKXHAkwlzn4EEPxsS/LDPxJNVLjbMFFOyFPpJvzZ3@vger.kernel.org
X-Gm-Message-State: APuU4Z8kpgmIxL7K68u33mIPXRKGo8O8odnir9sXIVYUOHtrP2lsqsfT
	SL76qsl7JjSB3rQDeGk7pPG1rUwGMIjDNJHUsepRMmgOSfYZIgHde0x4oZ7z1re55sAfn5ZZhWd
	pZWWene5V8D3UpakUDXjewOHMZ2h9KlA=
X-Gm-Gg: AZFdTZdOtYqG0hCBokiOTq2ytyyKex6jbIEU8RhKCJWGhzdL+14/EVaHa+dUcd3SHKd
	oBjgK4GJGETCt7y9aWNE1sDjh6XXsZGbUhwWRKE6SI3qST7l0t88R+prKz4/aG5/0bKCJe9GM7t
	GPO2+UwM/UbgYk2gkrG5CDGnaNUUarCHNU3pltdI45akmCNZ/3hi2Gg7ABgFLAS1PbNX3CFcz+Y
	gjvpMdgPFLCSi6O6qEUlPJZv7obOZ9nMzeR7wxiY57UjbJyTp/D5a4dC/6w1iJzl8gHMMLhCc8y
	E1QqvevOxrUHHoF6aFJgHJrU7DPJoijZfpLvg+bkCPHnCx8kq113qv3HMIyamYqiqlNIpi4NtQd
	OE8oi7tNThm1ec/u+AMV0IpBRpCUgrLa0QIzjI/tVzklphoPCoYUbIf9wBGu/+joVNWIbzxOX5H
	HxAPwxDoUD7aAGcEu4PyIpSMp01f2t8hL7nlE3
X-Received: by 2002:a05:690c:b82:b0:8b3:2e4f:6c06 with SMTP id
 00721157ae682-8b5204e6874mr37616707b3.47.1795457309817; Mon, 23 Nov 2026
 10:08:29 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com> <20261122120212.0dda7532@pumpkin>
In-Reply-To: <20261122120212.0dda7532@pumpkin>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:08:03 -0700
X-Gm-Features: Aa3M54pFgWYfRjmoVibaUGYDePfbu6x3lqh-lBTVnXaC_Y8BSI8GNkbK8nNeqyU
Message-ID: <CAJfuBxzcGz0Z36NNAWKoJi5KObKm3Y=Vb2gCQ6TFsoaQPjJsjA@mail.gmail.com>
Subject: Re: [PATCH 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
To: David Laight <david.laight.linux@gmail.com>
Cc: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 5:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 21 Nov 2026 15:49:18 -0700
> Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:
>
> > This series fixes a latent i386 section-alignment bug, by adding
> > explicit alignments into the BOUNDED_SECTION_* linker script macros.
> > The misalignment appears once __dyndbg_classes is split in 2, and the
> > 1st section has just 1 entry; the 2nd section implicitly gets ALIGN(4).
>
> Would everything work if all these sections got an ALIGN(8)?
> It would simplify everything and only cost a few bytes of memory
> that no one is really going to notice.
>

I tried that 1st, iirc the ORC_UNWIND table in particular
did not like it - the size and placement checks are quite strict,
and I didnt want to fiddle with changing the rules.



> (Apart from BTF which seems to be page aligned.)
>
> David
>
> >
> > 1. Refactor BOUNDED_SECTION_* (and HEADERED_SECTION_*) macros from
> >    vmlinux.lds.h into include/asm-generic/bounded_sections.lds.h for
> >    reuse.
> >
> > 2. Drop the unused HEADERED_SECTION* macros from bounded_sections.lds.h=
.
> >
> > 3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
> >    variants for non-8-byte tables like ORC_UNWIND_TABLE,
> >    EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing an i386
> >    NULL deref in dynamic_debug_init() caused by 28-byte
> >    __dyndbg_classes misaligning the following __dyndbg section.
> >
> > 4. Remove now-redundant outer `. =3D ALIGN(8);` directives preceding
> >    BOUNDED_SECTION* uses in vmlinux.lds.h.
> >
> > 5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for
> >    vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) fo=
r
> >    scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules
> >    under CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy.
> >
> > 6. fix checkpatch to skip macro-rules checks on any *.lds.h, in 3
> >    places where only vmlinux.lds.h is currently skipped.
> >
> > NB: most of this patchset was split out of larger series fixing
> > dyndbg-classmaps.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > Jim Cromie (6):
> >       vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sec=
tions.lds.h
> >       vmlinux.lds.h: drop unused HEADERED_SECTION* macros
> >       vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
> >       vmlinux.lds.h: remove redundant ALIGN(8) directives
> >       dyndbg.lds.S: fix lost dyndbg sections in modules
> >       checkpatch.pl: generalize linker script macro exceptions
> >
> >  MAINTAINERS                                |  1 +
> >  include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
> >  include/asm-generic/dyndbg.lds.h           | 18 ++++++++
> >  include/asm-generic/vmlinux.lds.h          | 68 ++++++----------------=
--------
> >  scripts/checkpatch.pl                      |  6 +--
> >  scripts/module.lds.S                       |  2 +
> >  6 files changed, 69 insertions(+), 58 deletions(-)
> > ---
> > base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> > change-id: 20261121-vmlinux-lds-b59410146885
> >
> > Best regards,
>
