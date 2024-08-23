Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9718EFE0
	for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440663; cv=none; b=eZoBCfOnlMEXcL9qplJ/LPBks86X80fCmcJElk1QdFI1riDUoJmIr5uizDQffkDN3vI8n7Rj5gufihEyURIzyauvj8ZM67khpnH6acfYw46V1MonxykCUmEZs31lrBNBDtTDAW3QU/uWuhIh1XY7hod4x/MQd8GUaR36uyF5anE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440663; c=relaxed/simple;
	bh=JIaW/apNWCzAmV/n0G/RjvJeXSQThNu/IWRYC/nMlBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjdmlFf4csEf31jOU6EoLhwqu3PbGnoZVLoPDY608+wWPstKn9slhTsyY8LmDFg8LGaCT9uZLmy+dZb+5PsgwWNEtQ6qhKMvFI+WIIZYXZoBjLbUGvd2P7MpzyrON75XX3weh5bP/4z5Q9PTx1CA7IbcZdQA9vL1LW8FZDTSDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQjFtDUY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQjFtDUY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4518d9fa2f4so52471cf.0
        for <linux-modules@vger.kernel.org>; Fri, 23 Aug 2024 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724440661; x=1725045461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK1Wvsdu8rfQ7lMKZWs3qCjFTpM3O30wRJ41e4mXEQM=;
        b=nQjFtDUYePQmYnE9EQJwWAQiHgusjrHR7wzqtda3MIHccSeQSWS/pM/mAuvbwrSEon
         kQk5hJQNheGOF9eavi8D0shnYnrqKUTWe54HFLyjzo0A7R8WWFT6HOcec0hqJ5hTI8Te
         +aZnp8HOB6SPgQotqWrW6Vyn2E/mTCWnqdktR+bkTYysQV5LSlAZtdg01Od20tSEOuEG
         WkvL2LbZ2yPT55q+MpFC/FgcnML37II0zSjgiX2bJGeS7G5oek4cmUKxb4Lw0wrhjNOm
         L0OaDHq64eYS7NuFHAnd07dzM9ONAdvli4LYP/QaEDHm3+TPRxCBd/5uWckpRX99lsr+
         ejUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440661; x=1725045461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK1Wvsdu8rfQ7lMKZWs3qCjFTpM3O30wRJ41e4mXEQM=;
        b=xLEnDnMqT8dLTBiitxqUHm+ou5CSMII9WSACav6G9J4qrTQWdDEcWzxXiaJN/RlRAO
         NOAyjm//pH3CXIWPmDScdmeTSFJNDPWuFNe9aZjpetCNBJwuUE8GmDk6dVwpC7NKD16A
         2HholglHjmK4n5sY6ecJnOfGY2s0KNK+j3Ovugo7WW53R6MagEAu2n1tjDfgEihpXGwK
         fcJCjHUJ4KpMQCmkezjWyqt7k0k5fZfFlk22oZMvwg+cbcYzS0F+a/AiX+jdUkvhLkE4
         pvLXaifgPFZCZ0GBQyCFrLpNaEIYTyvni6RYGv/1S7sZzT2FFKSJXDk5HeBajFfH+xRa
         hMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg2hFv2nPZLkPD8pZdi0FVgPqcwO5GkMFvwYm+ueMskuHYJ1A/dLCwYjsTruVWmuOvqdL/1JENpIzgFKK+@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUauFq85CdTnDVf9irstGD/cCD+QaeD6IenN+7FlFbQtf5yWO
	vX8XMA7vLP/wkrr2eCh3glbKspgMPhe7psiTAUKQ/PiyvdDqlX2aNEW/XzE/jRonZgAm9ix+l7x
	HdeX96xdcNSym8vDKdlRafmz9lOH6rWJu/hZ+
X-Google-Smtp-Source: AGHT+IF5LomZc7hzqJKmq6FHV/NPspoQklrwD6w75B8q4/YSMNHk+tcBlzWN1zsXKbub6U63GbI50CTIDeaWmmKUtbY=
X-Received: by 2002:a05:622a:30a:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-456420b7fa6mr478581cf.18.1724440660708; Fri, 23 Aug 2024
 12:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-37-samitolvanen@google.com>
 <20240819193851.GA4809@google.com> <a76f9422-4001-416a-a31b-37ab7dcb17f4@proton.me>
 <CABCJKudAF0=29js8SDcYY5r6kM7RBveTrZH9RyECNGqkcqy=nw@mail.gmail.com>
 <CAGSQo01kCUd64nB7C7Ssy1N=UBpOP3bORsRDcHJ1k2CqkbKsfQ@mail.gmail.com>
 <c6c1e84a-40f3-41a5-a732-f1cf06521691@proton.me> <2024082229-elevation-emporium-8118@gregkh>
 <bc2e02d7-d4a7-4f0f-852c-e26ad6a8688f@proton.me> <2024082257-refrain-subsector-b6c4@gregkh>
 <77e8e20c-8ca1-4df7-a4d7-ed77454f1754@proton.me> <2024082356-stowing-endowment-555b@gregkh>
In-Reply-To: <2024082356-stowing-endowment-555b@gregkh>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 23 Aug 2024 19:17:01 +0000
Message-ID: <CABCJKud--imREq8E6uuk4XwatLsKC7ikmyoLKJStqr3Azz0Hdw@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Matthew Maurer <mmaurer@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 22, 2024 at 12:00:15PM +0000, Benno Lossin wrote:
> > > Here's one example in the android tree where 4 64bit fields are reser=
ved
> > > for future abi changes:
> > >     https://android.googlesource.com/kernel/common/+/refs/heads/andro=
id12-5.10/include/linux/fs.h#421
> > >
> > > And here's a different place where a field is being used with many
> > > remaining for future use:
> > >     https://android.googlesource.com/kernel/common/+/refs/heads/andro=
id12-5.10/include/linux/sched.h#1379
> > >
> > > And also, we want/need lots of other space reservation at times, look=
 at
> > > how "Others" can get access to reserved areas in structures that need=
 to
> > > be done in an abi-safe way:
> > >     https://android.googlesource.com/kernel/common/+/refs/heads/andro=
id12-5.10/include/linux/sched.h#1375
> >
> > Let me correct myself, it's only possible to replace one `KAbiReserved`
> > by one new field. You can have as many fields of type `KAbiReserved` as
> > you want. The thing that you can't do is replace a single `KAbiReserved=
`
> > field by multiple (well you can, but then you have to change the sites
> > that use it).
>
> That's odd/foolish, why would that be the case?  Isn't that exactly what
> a union is for?  How are you going to know ahead of time what size types
> to save space for?

I believe Benno is referring to the lack of anonymous structures in
Rust. While you can replace a reserved field with a struct that
contains multiple smaller fields, you can't access the fields
transparently from the parent struct like you can in C:

    struct s { struct { u32 a; u32 b; }; };
    struct s s;
    s.a =3D 0;
    ...

It looks like nightly Rust does have some level of support for unnamed
fields in unions, but the implementation is not yet complete:

https://play.rust-lang.org/?version=3Dnightly&mode=3Ddebug&edition=3D2021&g=
ist=3D4f268d308fe6aa7a47566c7080c6e604

Benno, Matt, are you familiar with this feature?

Sami
