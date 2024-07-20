Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428D12EBE3
	for <linux-modules@vger.kernel.org>; Sat, 20 Jul 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721489961; cv=none; b=Yc9tAiZpFbg8T2687dUa1mX8Do3qCNBYkufM1rtnbdk6UK0tlZgHbZ9LXoa1QG7jzMXNCHXtmYEiYJktULFXQyIqAbQPrS6CtGJmsH46d0tVFNxpKNtrUPDa8iG21foDI7qNfVsXFvU6cPFaPAsQbvXvTLuKofVC7CUew/Cj+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721489961; c=relaxed/simple;
	bh=3CR0/615tdzMRN7ZXX4BbYucptmSfYWdd5Cc/UntFY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8gy42BzGQQh52AQ2rlFpOCnuq8DNDjiLWb0gthLZ2jmK3Q/WaY1AtYMxerFeHZl/fqQLs3IiwKfY7bVGghFZbS3vZlhJglf6Bz5v/PWDSqNFLeEp1sbnEJzGtkffwHc0Fn9vp6f1uBv1R2E/wi4nNlfQSSgtYWKwVT94lfLNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC3TP2Gp; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC3TP2Gp"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1051360so30237911fa.0
        for <linux-modules@vger.kernel.org>; Sat, 20 Jul 2024 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721489958; x=1722094758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzziXSqcRPmMCW7uHlNfMRmqfCic8DWhizL4MeF2M28=;
        b=GC3TP2GpfULV04pvdxBnRMhXukfIHtznIPfL+VLixpAo1xVqKUd/tQhr9HoBj8K5Dn
         8Y+cbWYKr8rTz03tGtDdDNL8MqghLGMVi+f5IRRqsQaLEq0ealNmerRrFojgrOLUb56F
         ZnmKp+0Sh7/7YG2yLzEq/QNkWjhH4jjS5e6WucXzOqubzQMaJwDs6Es8uLUzxB1DB0tX
         WhBpr9fHny/JPXbY4y+rdwosRxG/O6fW4R88muXNuYvuGgF0ZfimgQkEMRN19oq2hDVc
         I8IhGCcz+b1Ee7HhoYJvAM20/fRKXexdHGpqyutI8BsH9TrdpcUsrBXQLDAiWBE1U5zo
         +Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721489958; x=1722094758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzziXSqcRPmMCW7uHlNfMRmqfCic8DWhizL4MeF2M28=;
        b=b1HjGPYceTqBG1FTPrhAlvXaPi4Ka49QfbitfTPO20ELW/dy8gVToNMG3P1Z5LAJFL
         YgJWWZV68u9oMcmyppcl0a2AW3LueA6AcAfEekfOskAsH3iSJc5BO1GQ0PZT9ssigkRI
         thsLvLnhY+SgnVUpyfkPupnizOBfeAkjqDToPvVYmLqiOYr++uNGBuGz5GcCExjOlv3R
         fmmQGalOlpzeclTEuIVEYtBfvg9wttaPBOlGVeQi7hUdkOPkkql2jg7XhBlyKL9gKqA7
         MyIkO6Gb7kFouTaee175+q+u0Fa5yKy3MU+RMXHQPAu6X1yZWLRtJFhwBlVWpP9AMA19
         GbnA==
X-Gm-Message-State: AOJu0YwKv9xKjafrEyHtfbMjmgUOiRltMTxMwKbKgGnm72bl7s980Tnu
	HbeCHQ6u4vIhbfMKPYscpPX8RxU5KRWBeUM07oqxX92LekmP3kJK/e8Yv6NNJjWH98dkNm4CUZ3
	w0MCQ0MEfWZ8YMOAxkSiGvVbPLaM=
X-Google-Smtp-Source: AGHT+IGyUxt49NiOHTtY7n+N4cXGzhwmoD2wBiohyDaHC5UB+XP8NWFR4qiaQAHAiYSqFPaZPGz6CKW+n+Ayungbbk4=
X-Received: by 2002:a2e:8e91:0:b0:2ee:7d3c:66f with SMTP id
 38308e7fff4ca-2ef16840e26mr17704041fa.34.1721489957483; Sat, 20 Jul 2024
 08:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719221249.376162-1-lucas.de.marchi@gmail.com>
In-Reply-To: <20240719221249.376162-1-lucas.de.marchi@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sat, 20 Jul 2024 16:39:05 +0100
Message-ID: <CACvgo52Gh269GHA29Mu7Sq2TWhLNqNJj5weBF8k_ZANfD3=4ug@mail.gmail.com>
Subject: Re: [PATCH kmod] Use SPDX header for license
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jul 2024 at 23:13, Lucas De Marchi <lucas.de.marchi@gmail.com> w=
rote:
>
> Drop the lengthy license from each file and just use SPDX like most
> projects nowadays.
>

Massive +1 for the idea, I should go and update some of my other projects.

> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
> ---

<snip>

> --- a/libkmod/libkmod-config.c
> +++ b/libkmod/libkmod-config.c
> @@ -1,21 +1,7 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
>  /*
> - * libkmod - interface to kernel module operations
> - *
> - * Copyright (C) 2011-2013  ProFUSION embedded systems
> - * Copyright (C) 2013  Intel Corporation. All rights reserved.
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Puc License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + * Copyright =C2=A9 2011-2013 ProFUSION embedded systems
> + * Copyright =C2=A9 2013-2024 Intel Corporation
>   */
>

The commit is few somewhat unrelated things. Since dealing with
legalese is rarely fun, perhaps we can err on the verbose side and
split things?
Namely:
 - replaces license verbiage with SPDX one-liner
 - updates Intel copyright statement - would it make sense to your
@intel email as author here?
 - (C) -> =C2=A9 update the ProFUSION copyright statement - LF's LFC191 [1]
and SPDX [2] lists these as analogous to "Copyright" alone
 - drops the libkmod description one-liners

Four commits might be an overkill - license vs rest should be good IMHO.

Btw you can also use SPDX-FileCopyrightText [3].

HTH
-Emil

[1] https://training.linuxfoundation.org/training/open-source-licensing-bas=
ics-for-software-developers/
[2] https://spdx.github.io/spdx-spec/v2.3/license-matching-guidelines-and-t=
emplates/#b102-guideline
[3] https://spdx.github.io/spdx-spec/v2.3/file-tags/
