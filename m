Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91823D7CE
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574661; cv=none; b=l1YnR2Z/JBmEcGgx7i3LRqoJp86uaraaomwtfzRrivNnnHgK6zuRVNEWGqI1ysLrF8EOwvjYEFbwEnBa/ft3BhtvLEWKWCxdlme4Zt1y8rslBF31pF2fZQdnO29FNr8F9Fk/hsd+4SbnhglJ4DCEK4csyWUzCnC8AXp/GNvSWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574661; c=relaxed/simple;
	bh=cO1PJs5Hqxhy/M98m+zUxMJMnTWtXWiqkqLvzKCdndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cg9BQGafRvvuaGQaH4OZIwEIeZA1q6qPOWpftz/IG89P7vwR4p7zO2T4O6o8tTiRAXxfQ/8Jwq/pPrCRf4O79ewhW80eXldEHoq8HdjQPR885hBPw0hqbm2cNi3bNuSQAP1l2fEJLzMnLc/rK1McAYEFFw1n2D8TYEXBZfYH0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXzxSyHL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXzxSyHL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso200810b3a.2
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 20:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762574659; x=1763179459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO1PJs5Hqxhy/M98m+zUxMJMnTWtXWiqkqLvzKCdndE=;
        b=lXzxSyHLUJLzTzvCPJmM82Q/+729AEO76oVuSgh7ygZBJy5peupyoFqxolD6BcmRhh
         I5mAxmVLMXdMoNZCTP8KFhJRr0oRGm2P10EaWuHJrLPgc1/vhsCOpT+wJFAkGh9JtDx8
         XiXRRakkkvXcTqhVDNUCRZK0p4PLAf0KUAdg/rPTU/UWL9Fas3OOwhJDHZy/SCLrJY73
         uPpr6kqS2LPXEMSyejI0pV9XfO23ufIPZD45QJSzYpiAz/SzhgU7vZUwVmZFiO1WlSEJ
         +Y1fgeIWDee1phqhpSsFNlx7Gid4yPqaEiIh1zSD6M9qw1VQ5v2K0z3NAiFpYbUDs626
         yeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762574659; x=1763179459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cO1PJs5Hqxhy/M98m+zUxMJMnTWtXWiqkqLvzKCdndE=;
        b=tHELQYBNzLZs4JaPx7GhIqgPCiRlWdFkg8syJU1g73IPxF7WYwBgY+mFl9jFxYM1cs
         dvptKJagEM+S8Et15h9Xj0L8+gOWIfceMqkznGwo+4vlY29vwNhIgF4gZ2HjhMqlWn/C
         agm61QWjzToleENFwkV+KJdrQFheKbQAyv/apiOUrSj8dzD3IWyeMq337tAurCfJAD6A
         vdWBOzNhPf2HDiB7R6hHfsDvBZ/Yx6N+UTcUHsNEQYRdxfn44A78OZV3fKRIUBe+8JG/
         nqkw93LmEvfO+tAObMvScMs5wXaclXGetWmCSqFf5J7xoufHQfw3Xu867XsNZuHhE5+k
         qcQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJhFMx9R5YCYdGbeNWQuy8Mhb8Zk07G3m7ZbJQgLmQI6pPEFt3nEAP4e7Q7/Gg3ChVRXSCY06IAoKtS0oG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/x06O7AGDFoyfIDcb1csNnogeVx2ZcZKTTjctoWc1XFVN0GZ
	XKfLo9nMet2PMR2aExrxhF92QCzUzle10/TgwtCCwN8w0feWx/Ol3MBCMJ9bhRDrPqk06UlG9zt
	EUoi0DtvCA2DjTofW/ft40uA1Cg1PZ6g=
X-Gm-Gg: ASbGncuAnYQwyGGhVNDZzxmHVxTuns/q5XCEIHsnSUuZODWOJ1MPsvjUK4fsB7RAj4T
	yuZP6mjR6ep/XsysAjw62YAKzb1NdaBKKzPK+fl5Z5zAxgl3H1zi/nKrlkwxWCSQU8vPcFmJ5Qd
	XIMKi4CViFmLMnX6KTF86TeEu0LPV6EEaouD7iI3o8XWh1Ny3C03EE5sseNLdnQ4DBbrIjcgwjH
	2bLaG9QsQJvc9awWeqQ1bWjww37vDaCpJTLk5X8t0UyBffwPPapMMrrbaRUNxRwk+QUXaLKjwbw
	qjJ4CEJ/gGCURSxpkYrZ9UTiCVooSw6hzYCx5UM4vmYlRJZcU7m0JeD5MQENgUFdU9NvYwPav44
	pF4Y=
X-Google-Smtp-Source: AGHT+IHtsf35gyHQQ+P8KqDNivFkhr5pO5E4GRAujTawzDWGcDwzDptdRMlZayKqSlaa1m/AhQ+SjfvPJ/4wS4YO3Xw=
X-Received: by 2002:a17:902:f0c4:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-297e5649721mr6082085ad.4.1762574659105; Fri, 07 Nov 2025
 20:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
 <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com>
 <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com>
 <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com> <CANiq72ncHgjjJ_c2fdTgOO9LxmmotRS8S6pwyckLmPJG_4GPNg@mail.gmail.com>
In-Reply-To: <CANiq72ncHgjjJ_c2fdTgOO9LxmmotRS8S6pwyckLmPJG_4GPNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 05:04:06 +0100
X-Gm-Features: AWmQ_bn6skCdJtWEfzrc7-WSBc4N1Ycv25g4TWlNvHlubVb6S7pwG8zKBllg60w
Message-ID: <CANiq72kcRsTWPhQVJ18P6RUxL=+c1Z8BJkyK_kRR8EBmmH+cWg@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:51=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> What do you mean?

Do you mean in some cases? i.e. like with `CLIPPY=3D1`?

Cheers,
Miguel
