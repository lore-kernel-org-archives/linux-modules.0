Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F01EF099
	for <linux-modules@vger.kernel.org>; Wed, 12 Mar 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821715; cv=none; b=tYBjXExzSekM4zrr+7qY4YXKMwQT6k/B+FuSLIj6id79yvkqwVOWH5vuJgtai2+LC/3XOOKYOhaoCb+6f1vCq7XqEzlNoYQVM3TeqLjEDmxCbG4b2R1CWbJiV416MFNqvYotNqvW6ULr5P//FUFVBlrW0uB4GoBjV9rVSaOwLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821715; c=relaxed/simple;
	bh=KO5+hLhzIN8kvpj0M8Cwc3VnNOjAqYesBx0JGoOsFa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNoHR7YBhrHi8wGJV5lzK9VKd42dyUKtXdz2Nsrels0a2rPs3ulemlruAiriTnVJwGcpHRqaN2BgFyhYcjx7hwBaSc9uGf8ztf4hX1sAlZa6QyDBzgE2rvmN3Yj6LB9tXrpxsY0C6qcXz5vOdAlexi96qtK7WUy87Ah55Bgr+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbE9NeWK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbE9NeWK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so2303a12.1
        for <linux-modules@vger.kernel.org>; Wed, 12 Mar 2025 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741821710; x=1742426510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+b6fdIPax+pzIkRD3BnHujwRfnqX8wKkJzQB9q9UFM=;
        b=kbE9NeWKT5WsN9wxzUrMeg2ANgKc9VmzVsyXKl/uWLof8AE9txxjc/bJYn6f+EHi/C
         y1XCGM+eYGQfHuM4YXjEqwep7hkkbxpijCR2QyVLrZODPOXrs9z7tM6KdYqGMBEBJX8K
         9O/i35g+bDqzRAgpi59jshEFn2VIu596Fn0oN0O0+XO1O7ruKSjmJ1QtpUeI7x1B4b7E
         YsO0kc1AAQDmvgTFbVVgZm70R6gptpgAZUuO4RhSt5cjNCaOjMAEMHCT7aYbfybo68Zc
         3URz2btxd8bqK8hTh9NrWVxTHvNteI+eU1CNFCSZLSddxU/a5xNcZD23KzyujzGoqonl
         /aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821710; x=1742426510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+b6fdIPax+pzIkRD3BnHujwRfnqX8wKkJzQB9q9UFM=;
        b=ehX8Bx8445iMczluQkLod0m0fW/cOASc9gJzK/8grK5BIZmNw2EH+R0PajcrwdzdAL
         fWmvTOZzAkMc/lUb3l/CbUZ+ThWqGvgL8qZLdwp+zcXfeRtKVpPN5hdQnlQktAadf67l
         OVMKr2Y2T4zs56qJYW7EfxfR/GtwLA+CP6OHS7cJ+6JhXKrPID+pHcXZTxvt6K1xNy0m
         ZC4y72ahgU7g7iH0L2urFHYebA6VmtnTnU5MK6sCkAj55oh18+iedhuHcOIUg9D950cz
         ql2DjBAnYTeLtROAst8vfdBOVFj6BO0j5J87cCjKtF+lsCqySpLG9aMgPv+ww8tA4c7L
         DzYA==
X-Forwarded-Encrypted: i=1; AJvYcCULU9GIwEY9M4UZpT1QBLGJ/L8/vphx9AbtQVISJlmCk6vwrDjxSsQU0Ohlsvv6sVMDulf/Z77RMnSWoiKN@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrzYQnY+1BTnAoXdFSObWamwcD385fW8jeor8hDGgcl9ILpJt
	hiRVmbl7BncPa0U6esn62NSUqKY1aFGL44z5ozkgaTLyc1FvP3aPhWqXAco+F6VqO45apiFuuNh
	KCStBp6V9rbP6roudZqyFbl6TvT3lVuYstySp
X-Gm-Gg: ASbGncsKoamBBWkgEl5vMLpYd55cDWjfdrTfyZxZDaqeTbvfQGPVctmoeWzw2Ul2hDv
	RVUmkfa5TlM6thXZY5Er1m7ash5IUsvu5LNPBXWxLk/XKhZ5UbkO7tK2lcvP1c+0iuM/mr3cTKu
	pGlnn+2X6iLLA1vGiepWiTUx4=
X-Google-Smtp-Source: AGHT+IH79vozYd4/WLqPX8Goq+GK4FfkzqzmlxJ3W5zNK+xmu62XVxLg5WSlxN4V7nHHFtpmI1I1d+oCy92duCht4Zg=
X-Received: by 2002:aa7:c144:0:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5e80ca2adc2mr28084a12.2.1741821710118; Wed, 12 Mar 2025
 16:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306131430.7016-1-petr.pavlu@suse.com> <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu> <20250307001256.GA2276503@google.com>
 <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
In-Reply-To: <3ad23825-d249-4108-b5c3-693e359fd12e@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 12 Mar 2025 16:21:13 -0700
X-Gm-Features: AQ5f1Jrul7dK96zz3eAp-8XZZFpc7URZPt6V3a2TFr60XJn20E8S6oxTA8N0_kU
Message-ID: <CABCJKudevAT5PK09Gu_j_m-oaULumwXab4EkPdv=ZdSu6-PpJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain <mcgrof@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Wed, Mar 12, 2025 at 5:05=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 3/7/25 01:12, Sami Tolvanen wrote:
> > On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
> >> Le 06/03/2025 =C3=A0 14:13, Petr Pavlu a =C3=A9crit :
> >>> Section .static_call_sites holds data structures that need to be sort=
ed and
> >>> processed only at module load time. This initial processing happens i=
n
> >>> static_call_add_module(), which is invoked as a callback to the
> >>> MODULE_STATE_COMING notification from prepare_coming_module().
> >>>
> >>> The section is never modified afterwards. Make it therefore read-only=
 after
> >>> module initialization to avoid any (non-)accidental modifications.
> >>
> >> Maybe this suggestion is stupid, I didn't investigate the feasability =
but:
> >> why don't we group everything that is ro_after_init in a single sectio=
n just
> >> like we do in vmlinux ? That would avoid having to add every new possi=
ble
> >> section in the C code.
> >>
> >> Like we have in asm-generic/vmlinux.lds.h:
> >>
> >> #define RO_AFTER_INIT_DATA                                           \
> >>      . =3D ALIGN(8);                                                  =
 \
> >>      __start_ro_after_init =3D .;                                     =
 \
> >>      *(.data..ro_after_init)                                         \
> >>      JUMP_TABLE_DATA                                                 \
> >>      STATIC_CALL_DATA                                                \
> >>      __end_ro_after_init =3D .;
> >
> > I like this idea. Grouping the sections in the module linker script
> > feels cleaner than having an array of section names in the code. To be
> > fair, I think this code predates v5.10, where scripts/module.lds.S was
> > first added.
>
> I agree in principle. I like that the information about ro_after_init
> sections for vmlinux and modules would be in the same source form, in
> linker scripts. This could eventually allow us to share the definition
> of ro_after_init sections between vmlinux and modules.
>
> The problem is however how to find the location of the __jump_table and
> static_call_sites data. In vmlinux, as a final binary, they are
> annotated with start and end symbols. In modules, as relocatable files,
> the approach is to rely on them being separate sections, see function
> find_module_sections().
>
> I could add start+end symbols for __jump_table and static_call_sites
> data in scripts/module.lds.S and use them by the module loader, but this
> would create an inconsistency in how various data is looked up.

That's a fair point. Perhaps it makes sense to keep these sections
separate for consistency, and look into cleaning this up later if
needed.

> Another problem is that I can't find a way to tell the linker to add thes=
e
> symbols only if the specific data is actually present.

You can use the preprocessor to add the symbols only if the relevant
kernel config is present, similarly to how STATIC_CALL_DATA is defined
in include/asm-generic/vmlinux.lds.h.

In any case, the code looks correct to me. For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
