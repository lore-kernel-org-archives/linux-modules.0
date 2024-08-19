Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AF159565
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110904; cv=none; b=R527FWevNmI+lzP9qgGq9flaWN8n9JeD6511JgQ18HZnc1cu8/Oz5yhbd34gPXIl9oiLkbsNI3fE3YlqJGhp51KItYK8pexRvcAuq4RXKIaZLbcn9Wmh2juVfjvYzL1maB57RqfqE8T6p38BtKu5mq81Oi2T0sAeZyc3YoEeNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110904; c=relaxed/simple;
	bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOwzRhND8TCrPbse06K1qu/2n5U0mYUhptqiFlS3jz2DvSDybtdzDfejE9xZ4svhCHPv29Fu92Z6MOnK+lrxIqTxdLmF5LdV7TqS8jwXUaRGgDdNAhwxdU0LzmMaqpsnzj2eGBkfBWH+6h2yFy3h4Yw4C8MjQaSbNNBt8gMhDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ac2Ojsv+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac2Ojsv+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso1691a12.1
        for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724110901; x=1724715701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
        b=Ac2Ojsv+hT/DVDertFOoZEdRExcr/WaXAMQbTdz93ijpmy43bOKyv3uOZtKHPIZzr5
         uB0cl7HeJG1v2KgAvPxqdqg+cOkf6Za8ohHy1BbTMGfVL4F4qKYrqalzlymfs31szu/H
         G+jTa0ZhrTGYk/pJ2i3OQeoOMzAlAMU9AJ7RwTuWGzPGKRt6EwndtRrArxrWBdX9hCsk
         CkTv9DNovdTNrSvD4uE4RoTt2CTZOMemhGH3vk4tjLgh0n8AqT8a032uJn0BBuym71Mz
         YG/fd2jTeHD+leGzaIQRXVJi9/+T7azt5CaPxn2Yg01BDTT8ddE82iwbLOBsq1C4Hwq+
         9LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110901; x=1724715701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyJ7DwTEeQRwF2J9itqF7qF9lyR7ouza0PHAuQm+FtY=;
        b=KSkspkaORQX/cL/5oO378DahsO2P1dDykmUiNW2E9iy0QYs7UE0NK9pGwSp+l8dbdC
         WzwlN2gI6at6uAyOD1gI51KkRMLX8rEWpWsVeSIGV5YYUXqouIW83F9UM/QuzPEGrHJF
         JlAStbI6Dopua9EWvFTU7nRETuRuQX1XBIt7RYvc+rMw6buhFByNWa/tb20PsvjDx+ZJ
         Er45zLmNqHlv4daKY+NWcwkzOtOwaUDMDmv/lLfvBCJOBQ825dWtPmJG2vS7aEnKtlvX
         N9xSzf9UWDHX/CSazaBOS5ONww/D8hhobE72S8g2BQAKsxY8SJGDPBTluNsyDil7fGef
         ftTg==
X-Forwarded-Encrypted: i=1; AJvYcCVxgYJ0I2S1OXznof+WS0qUl5ooWN7UFdlMleQFqLCBTEFWiDXlG4qFsqfzM0LgbMp7LazUsPQOg5ikzbVkZKnimKe5fhv8fTHttrEHUw==
X-Gm-Message-State: AOJu0YxnamGYdhBLLerg/9mS1sRN52yYz6iquxPuDOu3zZibfDjJ9vwT
	d8hWEkLldc6dMWVehP+qnOtANd18ckiq2klMTq2glAlGEXI6smoOyxE7onKpJ2PKoXd9MOGlhxW
	RnHEQunISErjBYEnQsg8zw7AqgXdznVx92ZJh
X-Google-Smtp-Source: AGHT+IEFf0La4uREmgZmbe880Nnbs8CZTxbPC4ox9daCMh8bMB0DPDlb/vwxR0dv4G47Vf1sgvElegvu9c36SV8SoxM=
X-Received: by 2002:a05:6402:3546:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bf0c262b15mr42504a12.4.1724110900976; Mon, 19 Aug 2024
 16:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com> <20240806212106.617164-15-mmaurer@google.com>
 <87le0w2hop.fsf@mail.lhotse>
In-Reply-To: <87le0w2hop.fsf@mail.lhotse>
From: Matthew Maurer <mmaurer@google.com>
Date: Mon, 19 Aug 2024 16:41:29 -0700
Message-ID: <CAGSQo02r3NhWnpBF--5nB2RJ=1Hh97VshtiZmasDfknnL+UjmA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] modules: Support extended MODVERSIONS info
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 4:04=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Matthew Maurer <mmaurer@google.com> writes:
> > Adds a new format for MODVERSIONS which stores each field in a separate
> > ELF section. This initially adds support for variable length names, but
> > could later be used to add additional fields to MODVERSIONS in a
> > backwards compatible way if needed. Any new fields will be ignored by
> > old user tooling, unlike the current format where user tooling cannot
> > tolerate adjustments to the format (for example making the name field
> > longer).
> >
> > Since PPC munges its version records to strip leading dots, we reproduc=
e
> > the munging for the new format.
>
> AFAICS the existing code only strips a single leading dot, not all
> leading dots?

You appear to be correct, I'll update that in the next version, but
want to wait for more feedback on the rest of the patchset before
sending up another full series.

>
> cheers
