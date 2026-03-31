Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76D450918
	for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994024; cv=pass; b=r9LzgSHucu+lWozRXDtfqfZ67GyS5GY9rTw3Xh3bvpRML81gS9MFPO9KbA99k/FSsY+RnMpJkNFBO/swKDCwOr+h+h0fxX/97ow2wnXo/f/IX4a6vokXpJ7EQKTTCYLIKYNXSkLUfz32sLup/dW3ao5/Zm/iyXC/b3pY/ufBpGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994024; c=relaxed/simple;
	bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1HK1ocw8YprzrAS/YWLtfrbJlyebYSxgAQgM5L0sQ0e8d3+cLlzrzebQColfNrfLH5E/NIoZLjc2KgJ3GY9KPtBg3iIyPGsk7lTJXJeeQquaqBqDkUaBRB6u2dPiNmIfVQxNPwsAo4NoQK/xDNQ/poqjjHF7uSnhV4dTskSg9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI+ZU316; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI+ZU316"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c16286c496so102211eec.0
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 14:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994023; cv=none;
        d=google.com; s=arc-20240605;
        b=Hm3jcFU3woG6P2zV7CPCZn80To7JswW34qU5VBI3lgMtZ25rzo85MdkbytKw9EHSp3
         81mxVJEqOoHdshVdMgrblSf4JIaa05aUGOmHl666rO/e6iaBJKjli6yFqaRy41RKeYki
         93Dxsxm8QZwULDZi7XTQRB8MJWPllUIwSIbEGr/55UpsozObBQRFlwOJZNmo1lphNfsn
         KOx6kIGilnJquXdl1cVOyssikmSnByyxtRZm0SLXUEe9aeMEG47t5muRr7V03p0qLi1S
         XVfZQTUbPwjiujyI2bCyIPXwBZWWgRDEpCyUtVi3zMc7Zp3/baD8horGO/D184chrMG3
         lxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        fh=DYQaUFZf+bU7XFr4kfj2gjVNLpCXSAJ3nwN0kuaVbBA=;
        b=fy+fKGlLgJjDqoXW94MRfTTqs0sTGqvxV4fFgp2g4iAI4TQ5NWJxwynxC/m1EN+3kv
         NbFZs0B3pbB/+V9oBZtGQuSxHUkFqOVMVg/vL1ti+BJZL+DKPKuZboEXcLQBKe8pi951
         NdaZAmPm8PGWm5tbImkA4wtxFobdTkZ71ynQTz4WuDe6PdNMNkHBUF2lawHXvU3GqWYp
         RarG1G4PFVbnXjJ3JlRO1MrVm0oclhX4gq2s711ArpwZSIojpmFUp/LVlGJvBYHuUycY
         2IUb5OrOFIdBXdGvIrnODDedzQ0HRaVBavQ/LyNsFtOhLLmB9TY8iix6qWCm7AABD3/S
         tl9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994023; x=1775598823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        b=hI+ZU316rzrg7e7Aifygasa404WPmfjmKJN0XKVyVRATCGwnsGXkM/URl7vqLwObXD
         q2x8nMzVT9xaJYJRr3NucWs0ZjcXhIx3d+UMKamrzxfc990kUClNRKDaObTG3NX0rb6b
         RFfMu9Y21lR9nTm0WZkhAIPY8bGqf9neHxUe+tepxvVzWHhYYz5HBoJmT5VWOzOFB9PU
         1SScrw32lJwxRYfmn+6bvZQ3uTGC37p2tgNQSdyhJ3V6hyT8W5P78mZl3gOFx3S0AxOk
         00dcimD5ozJd2QpbZzCPcW9wWLuaripl+vhtzovrK860zA4z0EIcogXjJRhHuZMlvg/B
         hfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994023; x=1775598823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/ArxbDOSErJ7EhodougJMCKbAuLfhBhgl8KvGgp1Vg=;
        b=RzHAUcrkHiibOyFsrkn0cYejPRR8dZroYzng9YnuKv0SpInYEJSO2LneWAAEf2c0I1
         TyH7/Z/qM4FtUtgZUU61vY8s2dijfySKW4Vv6/M9HADBaOMMTs3sNEkc5vp+QpL6XdcB
         PgHDf6dX4XT8qrF1R/Zw5P5OOOZ2iPqRkRrITUda/yNrCo7wBFHA2ukY1aH3Ac31c/7W
         lkZEV3fz3xhwskT5FW+sX5sC0t4FK7CqZ3zAEXFDsbX0SOapwJnNfqi01BnJ03v5Yxs7
         66kFcUjsrcc1gzf/vnxcn3aLdwim8Y0D1kAQubCFGRDQ0xN4h+Nkp4tAv6ihnGSCj9MY
         D64g==
X-Forwarded-Encrypted: i=1; AJvYcCUKqpFXrGGnvBLkFyCxniNolUCJc9eDrLIHpXBqCoQa0s6tCjWS3sO/WX4YLlaph2aoTJ9evuUZ/ne6inx4@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtuCN+KVZSUBlHZeu90YGHlQ09a8ZD1FoJ2m9HOzW431pufbX
	gsQ4YH3VKTY7VQalVfULj2ePsCJMzoGzRK1+G9SA16KlI8sl/V+cCaXDQgHlii40eIJVmu13DWZ
	PkDND0ceY9au7Lyyv0UHsweM0TJO2l2s=
X-Gm-Gg: ATEYQzzMeLDjI294b7yok6hpWhHylTxZdHnbWhGyHzx5VsI30bEEDmyuX5zlyJlYGfQ
	wIdp1k5s4+pBz/7HTTg+sep8gu8xYsDe8DYsOwrPYfbNZvOSNmBb/zfAL4omZuPAzIZml0HZkGp
	GHJ339tGeYVMpb5bi3OW2TB2oCJufpjmdCwVDOUOqI9AK42ZoD7CDvSZg1BOWyGK7YE3BTk4/N6
	bBWeAoNJ2JxDe0tUtzfdB49Bb3Pjq+69A+M2jmo/4ChTXwvGFFRTpwaww4UkLI8sljYEmG1DSAH
	cyYnvrFurf9XHaWmKVyZP7AlavMWEV+P+pwYe1gwU5KfNJOGGkQn8cH4fbKQZQEHvUlZAfjI/NX
	mBEaPqXIVSX35BL00pA9xTlVsXAyknjYc1A==
X-Received: by 2002:a05:7300:1491:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2c932cbf06emr281953eec.5.1774994022517; Tue, 31 Mar 2026
 14:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <DHH9VRFULJST.383BKVSWUTZ3E@garyguo.net>
 <CANiq72=wsdJf1_qwAADhmKA2i7y9U+3WOm+9utE2rv52_eqnpQ@mail.gmail.com> <DHHANEJI7LQ0.3PGBQH34QK0DJ@garyguo.net>
In-Reply-To: <DHHANEJI7LQ0.3PGBQH34QK0DJ@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 23:53:28 +0200
X-Gm-Features: AQROBzC47UfLtt9SgfAHiHNm4GsMBgtssH0puTNrVE3JRvF8RcuXvNsGPOJ1MSY
Message-ID: <CANiq72=8d03wo3_28Q91DpHs=LF8D5N3pmuZtAsr8gLuco5hKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:43=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I mean the lint is kinda useful, and I don't want to disable it just beca=
use
> it doesn't exist in older versions of rustc.

Yeah, personally I like the inlined way, i.e. I use it myself, so I
don't mind enabling it everywhere if people is happy that it only
applies to some cases.

Another consideration is that the issue linked mentions that they
don't want to mix inline and not (for field access cases), so that
could be annoying for some, which is why they moved it back.

Either way sounds fine for me.

Anyway, if we enable it, I should apply the other suggestion too, put
the Cc: stable@ on them, and switch to `-W` here and remove the Cc:
stable@.

Thanks for taking a look!

Cheers,
Miguel
