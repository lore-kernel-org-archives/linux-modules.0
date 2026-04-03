Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8C3A9D93
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221650; cv=pass; b=dTl/auYx0CDb0Sd5lVMopwkyFhKAT/Inw1ptsqrevQtTQOhmaYkQ3Yi+S5hvZwwvtdrnN1yKPIRhQIUeNAWlLsMCuHulozsDK+bZB6P6xVVymnqyTFONQlFKumEl5jCNtSTv4u/eLejqZ4mbCGk7jguYfCxBxwphsn6Lsg2Hdyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221650; c=relaxed/simple;
	bh=+uZaDMP/AozcYqTZf/oaFF3EszPbfJb/aEebqbPHujU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF91kgTXau3V8mnz4+x+iMn+If2vqQ5tysw5ojoF5Wsed8dx93MHhbEAHJNAC0LXbprS6R7tUsauAWbi5ejjLlzUOyFI7j4CyJ3zYu7ferJZ14a6nuXBKVYlZVh+MCn8NbVTBsz7CqeyzidJqyTFq1Wu5Nltm1PRFMwJdtgIJLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBA7C0LY; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBA7C0LY"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c645e399ffso65197eec.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 06:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775221646; cv=none;
        d=google.com; s=arc-20240605;
        b=El1gIqrD0Vu2luehVbDIUrJAV7OI80TaJj3cFNWRgVKLaJ1NV9B6pznU+SQTFhWs4s
         uZXiPizSNqK4HOUxqtc7KbFH494NIZGIROam1r0mzga+RiXll1ihtHXT/1Mf3tv1L6kG
         MPemsKhEU341k6NWlkfZRmM6TPa9KeggteczX3iaSIlGHB2W3qdP6pSKh1sAhPd5FcbX
         0q+EJklr9rbZhRCSNX9PVgJwBfUDFkIfZ+H5X2IULt6rUShoMYIE2VFSJ8gkV205F+lw
         dM9qkQBIqjDYES8ucU0/Zq170MK6eeThW8nXyq1IeVvBfz49TGMmOt0qkAwsySMMf3kw
         W97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        fh=pI5VxoCk63Cd/132HuxVMWXxluOKAK91vTHA1j1E90A=;
        b=ivA9ZMoJniqwD4yHMTwVBI+dKrd8KJs6eiZmkcShp/e4DrOTbQfFsvGV8dY9IBIBA+
         0ivDsaorUTH32wlZcETBcx3CHNLqSWoXta7QgysWKCW1XmHOxYIKWb6jIncnXLSxa1b8
         MYbGn4VMiSDQjsvEfFFTLeLJusA1lmTdnCPAnUZJjK00mSWOjk/f/sbypBB8hoBc3Auh
         KjwkNNGClKeRTTJaK/8KTVHX9fk9dGGWe5BWADnbK1OdaeQk2hBu3MAkssVjhJabyq9c
         ta+PqnuPkaDgft8vak3h247nVRXwuzbJyER5CH/812mHpqvylofo0QTwq+YKKn/X1MVN
         q0og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221646; x=1775826446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        b=ZBA7C0LYezdbT1eDixqh2nwBPi6Y/sO93F7TCx7DyANmm6gIDgbFFxef+JZijrv975
         tduR58jh/u2ErihNLY/8s8OYU6/ZS1qhZpd8bmVLN/XbQxAHNCJuNZRIUIklqojelYHi
         vS9Fg5Axg+GG3RAVC+mIeO7hWo/YSw4e3LV8savuLGj5CFn0Jnjwgqz6IcoDyMMbdq1I
         1nsLQt+VePCtm/wEcXJHvN9yTpOol7iPLAgmvSeh2rEg2CHOxCqH2pVrPJlCkimfCj2i
         TWe5j561urXIGJJT/jppo89HR6EQcRqD41zUbjkkZCNjMneOy3Q2I0euYG3eBbXyF8vq
         QoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221646; x=1775826446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LexMMltL/kK/wLwnO1jphEmsYhPwoj9kNcnexg4bI8=;
        b=Fomq3yZbrWrqBFOi2cB5wFtn7EOvjFVgMPtGgYweKNyxt8+eg9SOD9172Lp/6BS0FT
         Gge+OB6KvC68c+EgF7orJ8Ot2Ed2qEe6J6vKI6gbakN3m86+mN7naOLhhQ8qR/IYzV5l
         JeIiUDM6sCGlSqkD/VzLpNnyqZHV5xZ92dhBimXP7hcoehZqQaaaHiPJwh/FMeHYE03U
         3JK5gSs1YqAPChQYXisdbIq/CmAk6LuwKq5hRaiVDLJ0UR55E66IPqJ888BET07W45NR
         eDTWVZ4NchgrhG2QrVaSj8zBXYAJg+1s0fun2879ttWdhWmkkI5XnrXfjhPPeVCuFW02
         7A5w==
X-Forwarded-Encrypted: i=1; AJvYcCUco1Lrx5hFro/GkQshz1547hRN281qC5jBQSpSGSfsEF2RdeQGJs+jO5TVmPB4u6qHlBC/emX5VoC+DLIt@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOfn7Nee3mlDcJrylq8cj0PBRxwZytei5nTcWYWn6c0Ih72Q2
	Lx5lFCMEeK1hUt7mVAjFBWdOiccTofYLc0iQxRDBSpIpHgfZKzM2zIMkX2Iq33PLqDdr67SgLub
	TLT78Aa/AIMlt9/004E1N5mNBRqewlAs=
X-Gm-Gg: AeBDies8k7JbhDwzI3j+AyWeGbHhKBUMNCDWEQdt10wUOqZdYdS4a3Clwn2g0f2oS6N
	/5o74sCvhhIPhMlVpZst+3lNtPjbVUPs6AChw5yZjRR4z4MIFpkOcOspHxCSCWhNhP+EeNxJkPt
	WjjRbHxA42DcgOd3f2hsTjXCYuJ3zt3EMDBooorErsmOegps/Ylqkj9a+scB5n5QpOLzOgUluIP
	/ewMS8V+ikpiHi1HiMhN41PSG43c+9ol81sjW4huZLWj8s0PuMGyGlib49RwWHvn+6xNOduXDKv
	q5G5Q1teHiP6jExiBca+yJt2oXCUFHd1CSwgzoSwXW9oGHrH9/y8MmA/TZmHIZbzR3/NeLe/rjb
	RiBgVysyDeuu5YTB3syNVhiM=
X-Received: by 2002:a05:7301:6093:b0:2c0:c55c:156f with SMTP id
 5a478bee46e88-2cbfbc82969mr602584eec.4.1775221646195; Fri, 03 Apr 2026
 06:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nqv30SOiCia8LE6XbKEURNCa9qwwcszsQ0a8FRxR0Msg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 15:07:12 +0200
X-Gm-Features: AQROBzAi7I-5aiPFC3vwoZZjn0KQTGSqr8-BroXwKxkn5hps7t8T0SwwfFMqiV4
Message-ID: <CANiq72mKuQgK_R=xs6270nwYigzCvJiFJ1PcOB+WT3OdXO7E0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:25=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Seeing this patch a bit late but in clippy 1.85.0 there is
> `#[clippy::format_args]` which would permit us to make the lint work
> with our custom macros.

+1, that may be good to consider, especially with the bump -- added
and backlinked in:

  https://github.com/Rust-for-Linux/linux/issues/349

Maybe an issue would be good to create too.

It is good to see Clippy adding more attributes, because I requested a
similar one for other lints involving macros in that list, e.g.

  https://github.com/rust-lang/rust-clippy/issues/11303

So hopefully we will eventually get those too.

Thanks!

Cheers,
Miguel
