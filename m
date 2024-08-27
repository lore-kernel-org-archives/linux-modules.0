Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F671C3F2E
	for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777132; cv=none; b=N3YXJDVUW3jKKexszz9FVchVyUO8Bl/sopJ0rtiFCdqrJ8lvvKk/pdgha36u2KZG3zsMzlhoIxg/WrC+BEblcMQHCiv458E5DJC+yRghFxLgEHqBrHtnVm+LqEpmtd6mjm9gTv5ncbjv/xdGJ6PHA2QEH9U6o1z77XeEKaf2bmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777132; c=relaxed/simple;
	bh=13N9rWiQqinjqu5t0FpuSFOBXGf77nou/F+efdv0gD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUAfoMYSEo6tn5h1AlN7z8YXhKa4nHXXAAY/LyaGhMLYfAFrpiWLxN0qF7KitO6vB309CysSwHBAsHVsRbjYx7cZ0PtS/XaMWlP43IvdNxrIkOuqV6VjPl5JNFcprV9A0E3begq6E/cyORdWIyds8Z42p4QIfUHEfkt+8Db6pO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RY7eEK/p; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RY7eEK/p"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fee2bfd28so1711cf.1
        for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724777130; x=1725381930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg+baRcLpnI1aQ9hlrSp/2fH28bJtbk1x405VvbEiCQ=;
        b=RY7eEK/pvNkcY/cFL21Qknc+7wcnBa6HbZkqzwy7+P1UfVB8nkzOetBoD5J8WgRv7L
         tFmmpD+0HEjP3sF9OOXJwBau+MJ+IsnT20s5IUXtg0+40y7ZQ4RMRHg++cE6DZD0v5mA
         L3eTryIKWPN+V0Pw2SNuqw+q0nRw6frsmP4fuKkmnkF1zuI2r4VAXr8g0X/GsIZEsaPd
         1nLDwEg0dVCUn1qe4pLMra7q2SdBDqrl4UWtBmgXLD4Z3LSpLjZ4cqvJh6/VaQaGyNBR
         xYBw/VMQHy5gDNQKhmw7vWOtDJElogiL5MizUTu6+oZwv46sv4PwsqwXYud56y8oVqh5
         k0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777130; x=1725381930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg+baRcLpnI1aQ9hlrSp/2fH28bJtbk1x405VvbEiCQ=;
        b=OriMSiQLvj1Pf85R1QtT8y4CWiUdanLC8osCJCkV734cqiyABcuR3KSA81z7GZzVbT
         IsArdz56OCzcrO7NpY/pXGiK1mQj5sbvYWl8IVGgFJyCmxCMi27PY9t9ZFhnBBvwYXpp
         +7kO9s7mscBe1dzNGF74zPpZklGBnkUOdsSKZNabqAGTfZ4Q8z8TmbUc98YIUKbck2P7
         j/o2WAx8UyJ+WxXsZfSg9MEnwDKwFgI5ch8YudviEfB4MiBBXlCcJCxTph8HPeSTw0zO
         AuE1KUn3sj5dxAWRwjQ1j6dTCcQG/ae2tl+RiXoMCV+vhqc7bwjJgFbFKEdgEoqRx1eh
         Ur0A==
X-Forwarded-Encrypted: i=1; AJvYcCVpRhsR3eVDxrQOc5xeeG0g5Yi4uhHF43UgxTupVL8mWwUpf2A+jqT0d00gHFE/ORTwmVxcsUW3QGrbThDI@vger.kernel.org
X-Gm-Message-State: AOJu0YymojTQTj7wYf/8CLJ4n3htQXT/7ozIZknn1k+aVG1GtB62xcZd
	WlDudroD3F9LZz1OjdDMcl5DhKtrv/d9OOmHJN2j5OUJGssyNfcorEIWpXJYdQa+vect+Nj9H3o
	D9818Y30kOQ0Nte9KKAYWK5hkkt1udVgCO8Yf
X-Google-Smtp-Source: AGHT+IESmvxfPWyz8OU6lrsb3/WdN97UClbBtMAbPPLrSZVeS26g2TfKlQrHovYGaH2tJhJuXW9A22yAePy9L6g0reM=
X-Received: by 2002:a05:622a:298f:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-4566168780fmr4067251cf.10.1724777129419; Tue, 27 Aug 2024
 09:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-22-samitolvanen@google.com> <2024081603-punctual-hamlet-152e@gregkh>
In-Reply-To: <2024081603-punctual-hamlet-152e@gregkh>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 27 Aug 2024 09:44:52 -0700
Message-ID: <CABCJKufF4xpwGkYu_H-1AH8cEAg2K4umrM07DY_X2j9qORQj=Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] tools: Add gendwarfksyms
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Aug 16, 2024 at 12:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 15, 2024 at 05:39:05PM +0000, Sami Tolvanen wrote:
> > --- /dev/null
> > +++ b/scripts/gendwarfksyms/dwarf.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Sorry, but I have to ask, do you _REALLY_ mean "or later" here and in
> other places in this series?  If so, great, but I want to be sure, as I
> know:
>
> > + * Copyright (C) 2024 Google LLC
>
> Has some issues with the types of licenses that marking will cover.

Thanks for bringing this up. The license is inherited from the
genksyms code that's included in this series, but I'll consult with
our licensing folks and adjust this in v3 for the other parts if
needed.

Sami
