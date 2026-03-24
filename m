Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B239BFE2
	for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368259; cv=pass; b=j7cY8gQdv0nXNemf5aTn9O/yc0zyM9x+arcrsDBEFCg8bjmzTG7o70QcHjKVHowomMrCA3ItJYkr7BTcJJJzZ7/omINUxM/WWzkpp29SvlCQx/heTRLhLUy7lgoFA7QXjggnoGxX7S2pI8B2a7fHNsT8cxiL8LjpV82JOPDRlXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368259; c=relaxed/simple;
	bh=Bap2I2Iwx1j90rJe9QRr9BlObCdTslZ+pvyg11P5Bkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTKnicdn/maOY9LfjN5XBoZWk2cayJ2xSUFZqnx9kcdeSubm1qdZI+TVmlJ1/skr8ZKakdv7IOb4vN3palo19rqvoQyoP5JZSXSL5UCnXCpazXxV7FsAWB1+cq5K3huIkDQsasbhTslWuVVlBVCFFv4P6Tw5ZXjZeRQA7u8xDeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qh6tn7NE; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh6tn7NE"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97c44417ffso451851866b.2
        for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 09:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368256; cv=none;
        d=google.com; s=arc-20240605;
        b=bbwXlj84j0KPt+Gj7mWfNUb6qrotLLy5t2MLT0nfuq+teGJWLnCDVnQMHT3pkb0iMV
         WkkMMHL1ES1mbOv7rDdiep0bydKcsJYzqPcoudRAzaDLERwX3c7Bk3B+U6wBWFQVzQ5/
         t+AZE/ltD6EYmI0X0VkK7UKVkK97RSnG1F0B4f+IeymZqYLGIrp27hclORcZ8ZotVjvy
         Zg9mIHpr1gT11Jf7SMwj/mt/jR+Ra760gun3KismCOcbdL8l56oMyCvxYRMJPJVs6vz/
         DBO+T823RvNAVNaT+WrxiWjwuAIPtZ0d1uGVzehmRcgYeSF9pinTM64k5K8fo4YTDeri
         Ob8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        fh=kHutu4HgBz4IFo+z5d+xK1LsrVZtVGXlzKYMg1Q7oeg=;
        b=Fknyd+4TfuBxsExyp3U4O/lQtkhCmbnz7CaWKEYAfWLFi6mkWg5fsUQPR7zR0TYai1
         DNhfhXfnWqSK1zX9NXw/8aMEm7GBRUvGzPi/4sJjVYzM1Lb9yfbXm9BnGzyKMcj7Rt08
         BYfl/wTpYS3D9QxM/pel2z2yGPp9HUqxQag5vqpjIXstxL8Zpnk5mTYBEqUwGnCV3mBv
         ChMhioKgehKaQsbRqhltKnatvPat51uWynxZxIwV+3oQH8jZXP2OYU+oKI8QzZnTL10g
         HHGoAlwheF/Hy3lq861N5NaHdnOZ+R1euNAzd4FEfse5hQrROPHN2du7195f7xpgMmQw
         Fp5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368256; x=1774973056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        b=qh6tn7NEE62HHX3lMpBe7k2khmCW7U35AtqhMprApltPlBRt9IlTWtAF584ZGtnAf/
         Rdh/SWyughatgMoucsZtjvMqa3P0la0SKGbrWMU8Z0Bf2/FGFkPPP7oLX2k4OdesqcPa
         k9k2eid1bA6w6ZouXsQd8pHUDafnTZh1tsFgaKzsXg1ZrvZ/j7c20MG3gacpDE37rIJ4
         3SWsPTR7SvHbb8DoFVhh3pSq+IrFw4VrLGJS2tlJgubFQ5R3JQS9ozUfD6ep76AFTJLC
         CbGHW2Rogx5U00e38UbbQjFENm60+9lpMFL1qLJT/nDcVxNzfczk9zreYGRLKQnKThpX
         RBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368256; x=1774973056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        b=rRZX26JWrvecUQ9efqTcK1rbX6dcQ3EUgLyLtuhJAwbN3FSKysuI8FDKiyYvNblLCk
         0yhczI8pdVZMLuSLKWobtYjxMM2JCsv26MH0DU58096LppjUH2ijzH5gQo57mKSvgVzk
         Z+3aud3aWQbxHmjgPP08jDHYpp4DDCZfxJfv78Jz6R7vrRyRyEVJq8dl81Rk1fffeAw3
         XCoVMin2Hu0MnMvYm0/Keoa/MMf+oLdUeID8DfYvXhh1a5XnSwneagSLxKZSF32cZuwg
         q9UmZETOb3kHtdoD1k51v4nOBrwVm89ZA8fg3UPJpwrfnnNHMCf7Bf4j9+XRhRi43S5M
         9dvA==
X-Forwarded-Encrypted: i=1; AJvYcCVGpcouoSYdWqOX/bXJOEjB0u3RmJKLDA0s9llB0DOupDas6ZNnQftseqKjLrRVAZodUJq2wPlbo5XbtxlT@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbYlK33R6IFkB8G2cJQYJsNHzyPt+xLxBwrOAlDnAXXu73oQY
	DwXCTjTwfTzvmRno1VmLCyd5h0Ce+eb/rYmJT3XrVYkqw0DSc1P+rWd7+ggp0c6sNXNJXxFdDC5
	6aHNrBs7zJLsEyYbaD+xHA5DWLwSiiUc=
X-Gm-Gg: ATEYQzwdBPY8QTEMrABPuyHGjp41iuBsHHARaJ4spAlNc1nCXxJNKfIBAGWqa1X6NHd
	1sk+KET1g6DsDRnbOa9c59kV4/XqHOtywR2c6fvo/YkgjB6xnRkABAIC6hRwZY2Tov/wBUe5Asn
	Rp61dEmy4TC7aoMIHn2JJRmmrxuYxsuqZL9mX4Agj8wpY0DbJyk/Bf76N0dmancwPTw9dogXTIB
	M1HR1seGDZoWfTbdx8C9U2cyxW4HspUTs5Sp0tXr2CiOl9qQStB0pv7c7hytMWssQthOIDs977e
	SDwMWU5ddGSjiiUxzqjKUPj8UwZQfkmEQZ56bYp+FQvxlZ6b24OpdLLqHoF9RAq7ZAUl4aUuMVx
	jDF2YXrWKwBCxDitk3yjc40dmOA==
X-Received: by 2002:a17:907:a807:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b982f0bd41bmr1118661566b.10.1774368255441; Tue, 24 Mar 2026
 09:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-2-sashal@kernel.org>
 <CAADnVQJjJwRtUQNZAhLoXF7DYprhU97xJReZg9izV7n3f7=uJQ@mail.gmail.com> <acK1M_CvbYCtq7im@laps>
In-Reply-To: <acK1M_CvbYCtq7im@laps>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:04:03 -0700
X-Gm-Features: AaiRm50g5sRljE-pOlu1qkME3uHtiXscwZS9bY6E1gCFONCc9DBnMt7wYDgAtI4
Message-ID: <CAADnVQLr5Sx+vG6D4Jxm8r2vPxu7ygFz60LGwmqfkc=VB0-Miw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: show function parameter info in oops/WARN dumps
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Juergen Gross <jgross@suse.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:00=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Tue, Mar 24, 2026 at 08:03:30AM -0700, Alexei Starovoitov wrote:
> >On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> =
wrote:
> >>
> >> Embed DWARF-derived function parameter name and type information in th=
e
> >> kernel image so that oops and WARN dumps display the crashing function=
's
> >> register-passed arguments with their names, types, and values.
> >>
> >> A new build-time tool (scripts/gen_paraminfo.c) parses DW_TAG_subprogr=
am
> >> and DW_TAG_formal_parameter entries from DWARF .debug_info, extracting
> >> parameter names and human-readable type strings. The resulting tables =
are
> >> stored in .rodata using the same two-phase link approach as lineinfo.
> >>
> >> At runtime, kallsyms_show_paraminfo() performs a binary search on the
> >> paraminfo tables, maps parameters to x86-64 calling convention registe=
rs
> >> (RDI, RSI, RDX, RCX, R8, R9), and prints each parameter's name, type,
> >> and value from pt_regs. If a parameter value matches the page fault
> >> address (CR2), it is highlighted with "<-- fault address".
> >>
> >> Integration at show_regs() means this works for both oops and WARN()
> >> automatically, since both paths provide full pt_regs at the exception
> >> point.
> >>
> >> Example output:
> >>
> >>   Function parameters (ext4_readdir):
> >>     file     (struct file *)         =3D 0xffff888123456000
> >>     ctx      (struct dir_context *)  =3D 0x0000000000001234  <-- fault=
 address
> >>
> >> Gated behind CONFIG_KALLSYMS_PARAMINFO (depends on CONFIG_KALLSYMS_LIN=
EINFO).
> >> Adds approximately 1-2 MB to the kernel image for ~58K functions.
> >>
> >> Assisted-by: Claude:claude-opus-4-6
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >Nack.
> >
> >You asked claude to reinvent pahole and BTF and it did it
> >completely missing years of fine tuning that pahole does.
>
> Let's keep this on the technical side please.
>
> >dwarf cannot be trusted as-is. pahole converts it carefully
> >by analyzing optimized out arguments and dropping signatures
>
> Fair point about pahole and optimized-out args. The problem is that BTF d=
epends
> on BPF_SYSCALL, and the environments I care about can't enable either.

This is trivially fixable without reinventing pahole.
