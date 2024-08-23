Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0618594C
	for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433869; cv=none; b=eQSsE0bT9vzozlB+STsdc9fN6adRs343BC8lbekjqH3oPnTJ63SZRv2a7ehDScnByad+qhorz6a/JR+GcA6d2uod/TFw0u685LKCjy+D4wOCOtthCXj3iZt77e8ou390FP70BrDNjRR6KWIzztK7FCq2Ad7bGk5xCNa/tNl88H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433869; c=relaxed/simple;
	bh=hlpyCsii63CCZanLxKd9QdiB9opQud7SMka1/NIVYOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbGdQT8wKM0teeRuaqSKJ7tT8FIZ3gOZVq7RjQLR3xdY+khUM3tbNvY6jxGibczHIC2MuKMU3n5uThPk9peVkKDa2bAdxbjHtUFE970rOZ63pMpTIvfoQ1O7TvIs6fzseNYmDguKPWxt5rX5flC9QpF4VKKMsZWLkHpF2kx1tQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pgqvsnv2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pgqvsnv2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fee2bfd28so13321cf.1
        for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724433866; x=1725038666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Jk8OKtpUXmY5SARUdzYD1Ba6FDSGinZzury3zL2zI=;
        b=Pgqvsnv2KcbjsgIB+2gRlIZDDtuMB6FxkxM8ZH68dfrLIZa5C5nFG5vbSS2OBUwkvV
         tGkaKNC+Hwf78sbWQ20hFpuxfoJMu4u+2pYVJ+EGEGjpoWWZC8YhCeExdIsVT1G08EMb
         Am+FrY1YwtH1+um28FsdsWHNAofHNbpracH80aOvPuRA/p41D1rvkqwMu2NJaiU/qwvN
         OYTgPOhLLvTRuuWFRabm6Sp//ZSZ3UsMQ2KcFNjjv8n5FX1BEfY/0z8UNquKe9mTBL68
         WO7Z07P2BZZyqqvSX9kj2VhLAnSsLRj3B+ijoYV01YgSU+McY+kcuoGNOXjdYbcZyC7K
         VtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433866; x=1725038666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4Jk8OKtpUXmY5SARUdzYD1Ba6FDSGinZzury3zL2zI=;
        b=LIDkjJ3bz5U4ODPKa/zA/C59olO8T12AWvxSMNCv20dUEpK2FTRcUfsuXly46bQ0N/
         DhQCFeXIBO6AKmbZwrBGqMRSDxy9yWAM6spXe8Bh0/G7lhe1iO/8wPjUWC4tG5TAmZc9
         UUp4u/0jySNSY3kl8Nb+RTIj0XVlAL8hhIz4xx7awGh6FMNC8Pzcujv1PUR5/gBbIN1E
         usVJkQP0aZ6sH+ElzBu/NP/A7XPqH4AC/lVrVRrpMCvGZNZ6Cq26KXwPibyx68s2YPgn
         ZvvFG0jXnIzTvdMEmWdSfkELUJQK6r0RhgHupI9YWZXlUWlWR7UxEscxopRWocA5hAq+
         DNww==
X-Forwarded-Encrypted: i=1; AJvYcCXsBGALpyoQpVK18CjOCSeTuP4YHS5ko5g6pb/QbLYfdE26M1ieLGBHIjteE+xFRz0HGGgyBQjstG0Urvsu@vger.kernel.org
X-Gm-Message-State: AOJu0YwNc4y1JOUZnLLi3L2qqif9kk0yN6DF44wDJxBq+YL5+FXR4o0f
	rj4gFlQIZuTkfeGuF28oYIgJzKndDXvKC+fqp2K8dc1qx536wxhuP6dyyM7bM5RoI5bnVeFKai3
	JFS4ZQ2XkxHYXQ504RBRV9K1LmIOVh9OQfrBV
X-Google-Smtp-Source: AGHT+IF1MJZKSS5KiL5OUVj9UrHhgKvH3Nv8eQHNU+DBTHPuRp7TFVZzROXfEEHtpuETvRKEgEs0JEF6XE2R6Yavjco=
X-Received: by 2002:a05:622a:1443:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-45509e77b0emr3216311cf.9.1724433865508; Fri, 23 Aug 2024
 10:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821040700.1919317-1-kris.van.hees@oracle.com>
 <20240822181942.2626536-1-kris.van.hees@oracle.com> <20240822181942.2626536-3-kris.van.hees@oracle.com>
 <20240823165329.GA3911831@google.com> <ZsjBfjAuC5t/2Cex@oracle.com>
In-Reply-To: <ZsjBfjAuC5t/2Cex@oracle.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 23 Aug 2024 10:23:46 -0700
Message-ID: <CABCJKucamgTpEhU5E=dL3tNc84yzwzFh7uNW-arhN-qDm-3nMw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] kbuild: generate offset range data for builtin modules
To: Kris Van Hees <kris.van.hees@oracle.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Nick Alcock <nick.alcock@oracle.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:06=E2=80=AFAM Kris Van Hees <kris.van.hees@oracl=
e.com> wrote:
>
> On Fri, Aug 23, 2024 at 04:53:29PM +0000, Sami Tolvanen wrote:
> > Hi Kris,
> >
> > On Thu, Aug 22, 2024 at 02:19:39PM -0400, Kris Van Hees wrote:
> > > diff --git a/scripts/generate_builtin_ranges.awk b/scripts/generate_b=
uiltin_ranges.awk
> > > new file mode 100755
> > > index 000000000000..68df05fd3036
> > > --- /dev/null
> > > +++ b/scripts/generate_builtin_ranges.awk
> > > @@ -0,0 +1,505 @@
> > > +#!/usr/bin/gawk -f
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# generate_builtin_ranges.awk: Generate address range data for built=
in modules
> > > +# Written by Kris Van Hees <kris.van.hees@oracle.com>
> > > +#
> > > +# Usage: generate_builtin_ranges.awk modules.builtin vmlinux.map \
> > > +#          vmlinux.o.map > modules.builtin.ranges
> > > +#
> > > +
> > > +# Return the module name(s) (if any) associated with the given objec=
t.
> > > +#
> > > +# If we have seen this object before, return information from the ca=
che.
> > > +# Otherwise, retrieve it from the corresponding .cmd file.
> > > +#
> > > +function get_module_info(fn, mod, obj, s) {
> > > +   if (fn in omod)
> > > +           return omod[fn];
> > > +
> > > +   if (match(fn, /\/[^/]+$/) =3D=3D 0)
> > > +           return "";
> > > +
> > > +   obj =3D fn;
> > > +   mod =3D "";
> > > +   fn =3D substr(fn, 1, RSTART) "." substr(fn, RSTART + 1) ".cmd";
> > > +   if (getline s <fn =3D=3D 1) {
> > > +           if (match(s, /DKBUILD_MODFILE=3D['"]+[^'"]+/) > 0) {
> > > +                   mod =3D substr(s, RSTART + 16, RLENGTH - 16);
> > > +                   gsub(/['"]/, "", mod);
> > > +           }
> > > +   }
> >
> > This doesn't work with built-in Rust modules because there's no
> > -DKBUILD_MODFILE flag passed to the compiler. The .cmd files do have
> > RUST_MODFILE set though, so presumably you could match that too?
>
> Thanks for looking at the patch series.  I'll look into this.
>
> Is there a reason why Rust modules are using RUST_MODFILE rather than als=
o
> using KBUILD_MODFILE as the macro to pass information about what module(s=
)
> the object belongs to?

I assume they wanted to avoid conflicts between Rust-specific
environment variables and existing Kbuild variables. Note that
KBUILD_MODFILE is also double quoted for the C preprocessor, which
isn't needed for Rust. Miguel, do you remember if there's another
reason for the different variable name?

Sami
