Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332717A5BE
	for <linux-modules@vger.kernel.org>; Wed,  4 Sep 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482909; cv=none; b=NooHEMMj7Te0bm48IJ2jFQUnzEfWt1gj5PV9MZaoH77ijQwqyxUISP39T5WxrEdiKekxl8gYg5W7RBzHHf6XiglXDdfMtULJLRgzgrkjWKbZUJ7eRvR+WnXdU6I+pNeoS1LV//MMGNOQlxXf11aG4AkVEzwiAKFK0S2IVZgFCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482909; c=relaxed/simple;
	bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXULAeos2M4SoKBEWc8dJdC+8+/DIEQfmFyfiaYl2GNvGrM3jEQusF6u2DDNEUr4RV+rY3ff2YpYaPzWZEhFx1nqYrjNMKmWr+7oYozHMxHc9/0CMON73+wYaSyQEVeH0RRZ5IV4l0LmcDiiaxqZCg357kWzC+7GHnHasS5Xlec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+FVqOBN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+FVqOBN"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567fe32141so28041cf.0
        for <linux-modules@vger.kernel.org>; Wed, 04 Sep 2024 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482907; x=1726087707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
        b=C+FVqOBNOxx7XkHDFlPxba1pKcW+FPVRZ1XczH35o1arUNEmTAt/yA961yMdFV7FX7
         Ih97totuYdKbOWzaiqikj9hjUTjY0yobopDRhO7BEeZMZGxaJXK+Yq0qubLNbunnmLJv
         BNY90s19C8iY8Q2/IoE31XCC6/xDgtysogXItJjFiwYeODdC66eom57HndQcTo/28Vnj
         8wCCy8noCcTbNNmfRb9bvPfcqggRN4gwiJfeOy6LOYJu9ZwIm+mnyw9QAtkDiyqzh/CF
         L9+aWnpQl8x/AfiUXyp+KqQ+CQqAFn/o+/oOWXE+5v4zenSLepeaSyK+jx3lzml/MCdt
         83Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482907; x=1726087707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
        b=aYw+QZuePINgpbKVwXWyA2ZN7H4bdEJ0A/6vAaIi5sULbLnwxw0Q6z7cEFhjb8WsZM
         cvAJFHA9pRaFKy2OBZEY7FTarZPJbIvRVmVzS4E9JvulFDF9HOtAh3NHhbb2LLI1u0i9
         ybF7vDkz5vOt2i5gEljyEL7lpJ0d7VKH6GIsvbweGgT0qGixEpbiRBQHzSoxMy3fIdTV
         7fKyBMZ+Q1W1qpQGGoVSUMPA78R3FTpC4UmufbnHu3Zky9KTzhAu5ZYhP3aLbmPLEMCl
         9p+H1nk/PrUDFXngAS7zJkeDkpe6qJLjftNoHbDQUgZZ15DCrmjKCF5LMn/hwp85oWCx
         HJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pgJlU00DgPYLxVwjTXjP1kW0VCMzffZibJ2C5Id7DdBWjvH3XtPUoaPzQiCrKJsXwwkijRy30Sr7I45n@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOAHP50mRz/nUsFBwP4AchRK2iJKk3rYZEgvxHIJfMZxokTUc
	Aor/0XfDMFddO0yf5Ts/ncy8Yd3Wbgt0tk9k4Ylbc7LMb3qy4FSTr3wIYSMsdLJbbGNqiVV7R4n
	MqRu+rH1estwCRB+qo5f13irhyC7TVbdmH7Da
X-Google-Smtp-Source: AGHT+IH29w72UxfNOmF+cOkn6nGTKhQJqTJySHQ6AISmMgpemfPBBYnt6mkLOYyAZK7vuhZ4wOocZ3LTTemcXVPpeUk=
X-Received: by 2002:a05:622a:64e:b0:453:581f:f29e with SMTP id
 d75a77b69052e-45801f21252mr1019391cf.24.1725482906905; Wed, 04 Sep 2024
 13:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-39-samitolvanen@google.com> <CAK7LNAQ4Qy-Z7Z2ads7JNRs+aTP5BrRTqCZgmm51e+_6mU3sYg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ4Qy-Z7Z2ads7JNRs+aTP5BrRTqCZgmm51e+_6mU3sYg@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Sep 2024 20:47:48 +0000
Message-ID: <CABCJKuccRnMAn4VUWjD4=2NXOR1a=wpHp-iNNUTv_Eh4e8155A@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] x86/asm-prototypes: Include <asm/ptrace.h>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Sun, Sep 1, 2024 at 10:51=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > <asm/ftrace.h> refers to struct pt_regs, make sure it's visible.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
>
> Then, why don't you include <asm/ptrace.h>
> from arch/x86/include/asm/ftrace.h
> instead of from arch/x86/include/asm/asm-prototypes.h
>
>
> And, this patch can get in independently.
>
> You should send it as a standalone patch
> to the x86 ML.

Sure, that works too. I'll send a separate patch for this.

Sami
