Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB14035BC
	for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364624; cv=pass; b=cG6zvW831vn6YctLwxZl9gkL091v2ki9uP2m9O1E2MoAv+412ZcBCKkL3urCqf8Uw3QFTZz+o5KEw8gbg10zsgwzDYBj4sAhaB2B04gi8k0nmVKo5u16rQao8yWxcB5LUJx0hKK+PsNvQ1exB3NMNE4DOBXQb0hB0UutIv9jecg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364624; c=relaxed/simple;
	bh=pGbN+jWmTUnUhmVdSv4PjGYUGPR4AJuGRrmDZfe9TOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N81PoRE/pWtRx0qkUjyrH3QRZqnD8YnKfgJn6gikZnSlogF9f3X42U96lljJ3spGDJQfGtSemOE0UB+M6noQjc+BTar/NDESUQ1HUMbTTU4n4Z82rYoK1i6tknmNDqpwZdRqCFt2GS/fF5R+HuSkAFAFcz8nr5ssXT7OQIoSqPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siUVWbSY; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siUVWbSY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b4d734678so1400708f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 08:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364622; cv=none;
        d=google.com; s=arc-20240605;
        b=VZ0PKoXPBlgVwc29DcgAnvBOol6+d+VFYO+MZYwkARJsVTj7x9m0iOCydVih+Al4oN
         fDBpp5YBTsrzU4AZUzJrX62dcG+59krimMWshMSXut69Yl9DvoW1tuBczjmWdOKon1pq
         o3XXt1YvJuGVCtgjMtCtzPqqki6Fl48pX/j9agUGSws4U1AqNsRFfbYnSdzXm707PNHJ
         P+hCJABqT/jvpeCYjS819McPfWi6qNILmEAkrZoK7aPVbxlBuG/Ms1ZOWFbWYjkk6LuT
         hLmQDV04tx04d2Hj+vBVOgFQYS63NehWnU0ZcQEvOt7tOfSpmxB0pyLnWSoyqvpKDhOB
         HKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        fh=JkVEuNQQE7dn63KhR2bqd+b9fhscLOGVQpyzkam5108=;
        b=HF319jokU3BZfBprMsbAxsUjKVMypmOd9+qsmqzj/z2PYtqNgHvIBDfvH9zwD3UWq4
         EdJOxkMaT22x6Be1DXF9e9+NN9rPU0cmx/Vh1HWMPc4tDyc+HMdJIKd88xtphESWfzEM
         ZntD+TNGhXlBRt3BqpNaGSoUsQ1DE/nbQgDbIBHDNpkfBETrbD+6s987PAU2hQynWur6
         jbuxZG83aQ+VhRPPHUVMW36iIQlI5scpaZiQn6nJip21bSoBao54g7ClyrIM6g+AyQz+
         hek5ebj7+DXmshUPMi9flGZe/QNngyiSrnp59bpNFvZDBnMgA+NUSymHfXl8EJGCJqVW
         7z1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364622; x=1774969422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        b=siUVWbSYsavvuxYNjP/noYbF2sxVqbJG6PaAsB9okjKvG4Aw9y6LDOLp5hiqMfM5ke
         tD7QxgOChmurznz/jclKWPLualaCjOt5+yIbyBsTzQrH8ogjBbxzmJa5C8IqbKDGzY+0
         N+rxbhTOA+aJX1jJnKSgnOpsxYDj//mNeWklMxXUWL2ohm/SMETvB9MkMIxLq+Ea+jwX
         zv6TnqozUCoU6aT8Fks/btbFo1BwM1nnYq8JI50vzsGEvC3hFeDGsq6VNFp/iYvbmVmf
         bS/6Yx1EwlafiRevKRIo34SPtKeyi5qBkiydVySWmV8KG+ynX0l7s0PnX6AY63fMduCQ
         mUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364622; x=1774969422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pygaIxmYy8vrcTultPBr5yJtweQmbJOPxaBB0Dq1tM=;
        b=hIgig1Kjotb2RaArPooVeIopfA+sFGE+7zQFR8iaLtLPsCtvbm4+PfCcs1a2Q67UWr
         xU/YUFEWIHMUpGwtAGujDJEv6EKcY8INPRDtBA0yxes1bB/+8NEN+lt27v38UBonequE
         NHru7B48uVOqd0hFdLXtw5QDhmNymiPheqQdv4SZK6zYBe5CstblspXC/z85+QeznTJC
         GShs9HqcuBQDDJNkxL4aF6WxWv6uDl+2g4YpHjGZvb+6cY1DxbxD+d+hQ+Q5shNnxDGU
         I0+IgIo1oCASxhNZBFFC5QRD77CFBQBGBGknHPeA7hYYYtq7vsucM4lZ9SPcSMoQ/wvj
         BTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2SWH/MzEeh4p7HmnxChX1qXFbQ4Nf/RI6i/H1DQ+BeJxVYU3mNrKC4nkzD8+8o1a9nv7EGfWGdhG+rPAV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3vJzt4wg/bA15OAZPJmE5foRa3RVCI60Qy4Ypi0gJUBJt4IB
	r2umjl1AxtFUm0BhnfU1QbkcL+GsFL4A7ru3nvrpaDDs/zp/poegnQdVW/eHT4c0K3vmTPzuzEG
	hb41isjeohu8tvpiTKSn3gOWA5iAYUQQ=
X-Gm-Gg: ATEYQzyBriccpGdn3RakPuXQM8qo78L6wWzlelxFfI/tXeJ+CBKbnDWVfJ2loJ0xtrQ
	X6h3vhqQJfBxgacUMUj6Gwf4egPcUzUGM3z3IcfUdEd+7J+MWS+S8nef6AX178Du+dCPwUNplcE
	IDwnkidWpp6KhJ5C7VrIS9DRSbRcIt3FWu3Nnt/luo7SK+xNR3P/vsXFGx6gOpMEkfPDLVwaPzN
	qw2PjHsRoMx6zDQwBzJsFBh5q1VF21hb5VvloprwzAhF4x5iiGWtQCN0U/2vjc0TBJ3d/c7gktA
	qs/0C4tEmyzO1/lIpRt8gc8+WWCBotEjN5DBw6CxcXrOJxvIVksWhoTgTohf1ngka6j0OdibX7r
	ANadz+L3rbJRDRBGyQK+1It24DQ==
X-Received: by 2002:a05:6000:420e:b0:43b:5231:e94a with SMTP id
 ffacd0b85a97d-43b6426580dmr25272373f8f.30.1774364621590; Tue, 24 Mar 2026
 08:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-2-sashal@kernel.org>
In-Reply-To: <20260323164858.1939248-2-sashal@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:03:30 -0700
X-Gm-Features: AQROBzBtYHLNynVUYaVr0FFPgK1a9gR9szjQmqF2fXdYPXYOTswB5hwZbCigrcE
Message-ID: <CAADnVQJjJwRtUQNZAhLoXF7DYprhU97xJReZg9izV7n3f7=uJQ@mail.gmail.com>
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

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Embed DWARF-derived function parameter name and type information in the
> kernel image so that oops and WARN dumps display the crashing function's
> register-passed arguments with their names, types, and values.
>
> A new build-time tool (scripts/gen_paraminfo.c) parses DW_TAG_subprogram
> and DW_TAG_formal_parameter entries from DWARF .debug_info, extracting
> parameter names and human-readable type strings. The resulting tables are
> stored in .rodata using the same two-phase link approach as lineinfo.
>
> At runtime, kallsyms_show_paraminfo() performs a binary search on the
> paraminfo tables, maps parameters to x86-64 calling convention registers
> (RDI, RSI, RDX, RCX, R8, R9), and prints each parameter's name, type,
> and value from pt_regs. If a parameter value matches the page fault
> address (CR2), it is highlighted with "<-- fault address".
>
> Integration at show_regs() means this works for both oops and WARN()
> automatically, since both paths provide full pt_regs at the exception
> point.
>
> Example output:
>
>   Function parameters (ext4_readdir):
>     file     (struct file *)         =3D 0xffff888123456000
>     ctx      (struct dir_context *)  =3D 0x0000000000001234  <-- fault ad=
dress
>
> Gated behind CONFIG_KALLSYMS_PARAMINFO (depends on CONFIG_KALLSYMS_LINEIN=
FO).
> Adds approximately 1-2 MB to the kernel image for ~58K functions.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Nack.

You asked claude to reinvent pahole and BTF and it did it
completely missing years of fine tuning that pahole does.
dwarf cannot be trusted as-is. pahole converts it carefully
by analyzing optimized out arguments and dropping signatures
from BTF that are not accurate. This work is still ongoing.
For example see this set:
https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.de=
v/
pahole isn't perfect, but what you attempted to do here
is just broken.
