Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D543D4EE
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609162; cv=pass; b=sjPbEyvoveTmQvqgLdE7eNQMftFSFokdxo6qZKWrlwHVZjZKTqfbL3GBp30/dVtiCxI5eGyRNFzUAeKlRkGXghsGa00TNJ9xz964hIs8EIprZryT0MRvqAp1ctpzvmXE/e9J+iHcbk3+RYVa/YvoG21baY4pO//TOLsKX34K4y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609162; c=relaxed/simple;
	bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z943N3QTyd0axtMj/2oFKKXVqPpKHeM/ByBwoLMx1WlhiHhvbN4jadzV5NLI4J9znahE+Gc1xDcnQzWuGowMm4HsCDhF13hq89EawOOu6VAXR3Neg90GLGE+E175hykYhg7a7feBjGuiyZOHc1ad6Py9vZw4NQ8DaY6jNnQWYTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiKXJg03; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiKXJg03"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso271705a91.1
        for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786609160; cv=none;
        d=google.com; s=arc-20260327;
        b=JViSnJbJmAJdMLdeJNeVbmq2JsdMcKgmwPBX+84U+AgevVCmIUBTztNvyEnWkgbapG
         gvacDKviD+MXkmKMNmXm12aR5SpY1iJJEvJxMgduCMjlmaRdkyzYToZXvUhgNgG9JD/v
         7/07mNG39KPZ2zOuZxV3FW0niiJ/CA4VhIe9hYxtLx6HSvczHUsXaRAYvPfTIBhJRzpj
         f3Mvx52K25H32ayoKHf3dK1ZT9Me1ZYwoR1nmVU/EueYNc5gEQjJgDFqSQUZKEhjvfqH
         7xJLwBAvXCE1edNa+FPj+Yn5URSWyJQBmOyF9wx2elrvSZXSlYwJ792/aM4U1aMcwPTJ
         +rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        fh=OHKrZql5eA586R9155JMMhucC+2kUyd+ULUlVqD68ZM=;
        b=DOkqqio9+Z/ovT7xG/Kesmq1yK/FdF2rhQjHSSmWbMX8uL0AZeIyIMgFDfnF13vcRa
         NGdptX5kfWmWVuInJH/LI82mRao58LuOSL1+jgy40piGohsp6c/Lcm/M9O4Fb/hcL4kL
         2cMmAD/iEWy936U7o8/k/JZ00bxhz3slJYn7+nOp5NN2dytuXyLvnCKPFz/4VDYw0/md
         9RVU/ojB/7QxtPn2YeATubTmcp2zbj++vdFdvHboS8pB0i1KGr9BNDmFHZXtrA2C0RH1
         HP/O8EIgjpuR5xPTwtgwf/w/Cth3fSjrufFycLej6UTwQcEdNYBAGa9fdNW5ioL8afcc
         Ietg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786609160; x=1787213960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=jiKXJg03ISCWp4I5Y7ccPMu321Ea6AemOZfQWlLgVESV0Vh7f3GfggkE0tt+xWkPpi
         3ACJjmUZFwOHd4xdX45veGxbDPNmBHmWplhxbEmy/YKTVnkRGV5Zm9dXtlcLWuYbBACn
         M3WXqdZUW47hmbmp3YHhFoRMGh3/FL8SbUiZfcchHI4i43vXfNupNOt0MQTPWpD74ajA
         JptqLcLrvVjxvvALg1i53eNw8PTMq7AS0IgAzYWk1XBV0I7Hygmf7Me67r8NWsjqbyY8
         7GNl2JTiQ+PfCLX7//mzkJspyqK6oK7NOLXJfN5pSltReyQsGmRqKK9Er43gYXiqaEdn
         Bp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609160; x=1787213960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=PtvkB7kfER0uQTBtKqsWfOLuQaSgSoNhLdS7LxbNhqvxDZT+CB0TKT5y6IlRI98oA1
         x2HJ7MLa5/njkuJ0oPIpvrrmTuqfjN6i7qKrhdcDC5kIGOy62kszJiLcDuY+QyFfEWJ/
         4mi1H4KfvQhQRTkSxlPQxBR6pp1sXXj/0KlufKSZHeHGH1sAnUeSewdi7A/odWw4aMiK
         hSwnvgAXmjMhDGmESf6jdAhEd+H3kdsEAI5KHnuQiuaSLl9jrqqRlidom7mLcZGVLePR
         bcbCMT24byTXijrcDaO1NbeRYFHhrgaYpW6oDcRKz3tD4uFMz+JlRJ8SpfBQW4frMOZk
         k0ug==
X-Forwarded-Encrypted: i=1; AHgh+RqXz8gKT7xgcDPk2DPCH6GinP4yfpJsQmpQwAGJQp/+aeJKxyNoD4efg2joTUneobYdHpAwglROmSRf/XmV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bjeEujLS+98fDxr0nU9nMlT4+n1IGles6elM8OV2jZnUtJql
	xpEdl72x/igrXRkUZ/Y1d6m22iR5PqIB+orXo7Qb9D/0iDxjAwrJ6726XPzb18QcUlLnuK/FZRP
	rgzwllB4h5AXlAC5QC1OXdxgCfcWpD8w=
X-Gm-Gg: AR+sD10GHaFQuFxELxzs2KpW/OlFHAfrHbkndNHobVd8VgeO+alT1I+d+Z2O8ZqvtxG
	BxjWRYNdo9XvS+QliI5wiXUJqYIdDYhA8/ICbMQgoWxJA9EYAZWtiW7Up02gsbEitbUFVhYUKwd
	oeKrwkozJds57UmWUrPgPz93GDXkD/L6rYS3oJMBSqZsWnl0q5DLSigZjBsJrCp84biVoXmVlFk
	Mifc9qFAbPtMNXkx11mydQlR8V97CbzNJNvpEAWBuy1eFxMj7LI2pPK3Rr9MnlZ1HTdTVnn/i7+
	LjEfDlssy37cB5PNCO5mFXYthnTTY7ifjxydxYuzW9yoLMZHYOQeDEblOMmKEYyryrXPxTvzvY4
	N0uX0n+zsTLjrnTBLCleXg7a7giUxFxgMJ/fwF0qjk7Vjxl1Zhyvj9Zb08Lwgsd9U7ies8QY=
X-Received: by 2002:a17:90b:5807:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3931e2aa828mr3336244a91.3.1786609159836; Thu, 13 Aug 2026
 01:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
In-Reply-To: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 10:19:07 +0200
X-Gm-Features: AUfX_mwh5p3w0RKVhg92eH8jsf5k7VluJKRFIvAAaH6tiIul7a7G8q8L9_4Mlig
Message-ID: <CANiq72mcFp-MODPkNGPcufxb0YhPDO_eN8J-ZFVzkd2-W6VK6A@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:15=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Thanks for applying the series and catching the stray Acked-by.
> It was a v5 series-tag, from before the MAINTAINERS patch existed,
> so no need to re-add it. I'll be more careful with tags in future
> submissions.

Thanks for confirming! :)

Cheers,
Miguel
