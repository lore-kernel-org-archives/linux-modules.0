Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBA1A76CC
	for <linux-modules@vger.kernel.org>; Mon, 25 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527310; cv=none; b=rJ065kz7O5/A8+ujH/aOxpcQHHunxyJPKWuOOF+A1mh4VkCTlqiBfsF5u05yDxIpoczgtVum9vBraqX3rfO3YBN82SQpaFy0MasoH9rbtAYRG0XsLC83t4BdWx09xe7qLftGVu6qPW7ynecw+vAFN8r/pEFsjAXgFfqSkrlFxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527310; c=relaxed/simple;
	bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDeI9Lhcjom8sQrhST0yL6lT0XcOmlgOQPxdI5V8TdFMrPbypgNmOuhDrJWXzQgtJYcBiPWbN3mML4vKuIiIVNdgZN+Cw9xTfkiLrVhn6gAvYFV6tl2CjQCHhBldOVEe0MSf9VZoC17CzgqPzWyOV5Jvoo/WcpkkQSWHDe3J44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LC1WsC7v; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LC1WsC7v"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so8389a12.0
        for <linux-modules@vger.kernel.org>; Mon, 25 Nov 2024 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527307; x=1733132107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
        b=LC1WsC7vumtgFuP6Cv9Yu8t1TMXoT6wbw7rxEaaVq1teHsOm9l3az9HUMRmSSAdcec
         yGGQYM9bs7ELHgZjkSenvYVkcgsujwFxZaAaQgSG9lBayHhlLlNeppF2JGZt4cejK3nG
         Jw5aCvZlATCCXiBaxqR6b5PgzxAvesl8zL1hFKrlb6Fo6Ct7D02KGPLvdRxF8lgbRpDo
         C8/JN1PSpOH/1DnolDcNNCiGqYWJ1hsYWQ/nF7AvTTeTfsMfQmB/Uc6ijDsKuzoHD0HI
         YdWH2XAvRWL7n7nA0mqzMwvL1F9/Al2BL10ifZC4zoJZlSSavarFEB1prweZYn16pu3u
         gcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527307; x=1733132107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaT2gMZATI1cr2w+kBtCP6nseVsxavYfNusYFbNNQeg=;
        b=qFPloLRehUkodpXwF3thbDHvFTiuNOjWIDPdbRCkXxlTMntJ/j3A5vlan3paZ/boOI
         5Wf7efiLDtojkr9uV7A+oMvZtzLt5bU9qSEkmgN6dWMu7fD0IPqBSmVDFpGTYh4fa98m
         MMcmMhM42LFs63pjsDvd2cZCc1g42SD++TazHwWIs4tHPfg/mgn4fpmywQqTEjBaSp5m
         GClUWLFBd3JgY6aAUE2AQ06G52UT9HmgLUB84nCCPJO9jXbc1RcN3hAbVpsvNcd29xX3
         KOzenAM9U/n1YnajICLQ/ToxUgBuoEwLgdhGCnseJAEOJT+krSHyBzH0a/eWIxTMaxKU
         l7+w==
X-Forwarded-Encrypted: i=1; AJvYcCU//FLYL1hyRrhyWSTwJM0BAGXUJFuU2z2tkazQIUVXnJmVl+a+WsZ/jTE2ITOT9HogVpx87ibb3HwWOknJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WMsqWJc02CmZY1pCxpwpq1Ba7zZi/O7Om8QVjCAS7xwzUmIf
	M+SJ5egzWGmBfzhRKmSLOG1aHPVwudFle0YVHaLqCDIbsmtghv5FU2mu2iX6ZlC8W+kkA3xFe5x
	u4ocqrpAL4tih4ZrsLyhXJcu94SbpNUS8Z1j1
X-Gm-Gg: ASbGnctpf1ZzICxqjOUHTe8FUFIoxiXAmPCnSqe1wFQ9QrE3o06sg+5unhANFe2Edaz
	cQHU7EVhCWcF1QDp60Zm77VJqMkUcKg1Z
X-Google-Smtp-Source: AGHT+IGTmrlfZpaacQIL7m1sVBbpke3zA30uDeHjmOTDx5UHOJssl129/RankrUjb/fulgjiVDxdQ2FhiBHkvVnjtVM=
X-Received: by 2002:aa7:ce09:0:b0:5d0:3ddd:c773 with SMTP id
 4fb4d7f45d1cf-5d03dddc84bmr69002a12.4.1732527307223; Mon, 25 Nov 2024
 01:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <CA+icZUX-gf8624z8u+h-W8KeddCruYDng-4vTggNGwC61NzfNA@mail.gmail.com> <CA+icZUWSKygQJNiODzdauNiHz2Di-2eSGGmd-fgBrFpdyh_HgA@mail.gmail.com>
In-Reply-To: <CA+icZUWSKygQJNiODzdauNiHz2Di-2eSGGmd-fgBrFpdyh_HgA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 25 Nov 2024 11:34:30 +0200
Message-ID: <CABCJKudwpKX1_j46Tp6=eAJ0JU2zWE15+c8OFq9LMAnSqwesOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 23, 2024 at 1:23=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> > BTW, I am testing with the latest kmod-git and pahole-git.
> >
> > I will give this a try when Linux v6.12.1 is released.
> >
>
> I have a prolonged build-time of +22,75 per cent.
> Compared gendwarfksyms-v5 + Linux-v6.12.0 VS. gendwarfksyms-v6 + Linux-v6=
.12.1
>
> Is this a known issue?

In my tests, compared to a genksyms defconfig build with debugging
information, v5 was slightly faster, and v6 was 5.6% slower. This is
because the expansion limits were dropped in this version to ensure
version stability when exports are removed. See the explanation here:

https://lore.kernel.org/linux-modules/20241120215454.GA3512979@google.com/

I did profile this quickly and most of the time seems to be spent in
libdw looking up attributes. We might be able to speed this up by
limiting the number of attributes we look up depending on the DIE
type, but I haven't had time to look into it yet. I'll take a closer
look when I'm back from my vacation in about three weeks.

Sami
