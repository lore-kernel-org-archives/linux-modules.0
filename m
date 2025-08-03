Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983D1552FA
	for <linux-modules@vger.kernel.org>; Sun,  3 Aug 2025 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754257111; cv=none; b=OUXRqH8JUKPYHAle7ZH24ii0OaxD3i96OjrVUCRZbWPaTjG/WK2rEzS2YMlK/n77CLIvXViJA14VRCNOEbI1alctm6wy2F01aLXB0OnZvvWk0qqwdwAcu/wvixkvtJSmtP+0LHXZcz/Jrnu4kaa/ZGTLlGB3LLB5zSwRc4AkbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754257111; c=relaxed/simple;
	bh=v0US7hNDRX895O84Qbligoc8eEIkz8N3QYQnRbFG8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYn5kdLFnFOp3o6ZnaVbnFgkiYW0GjL6slUbXK21cTKrPIAcOj35RSJeH9f0e1YkJWkXIUC2MDBp09YQN4Ur2FBqR5vUeNvXqu5vDXc93jHh5IMY4c4+GnCwWyTwEnIxXyvPZY3JFLjlucWTqqJf7h5hWEtiuA3CeHefCg07kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SCC6ged4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SCC6ged4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso4563834a12.0
        for <linux-modules@vger.kernel.org>; Sun, 03 Aug 2025 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754257107; x=1754861907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ii6avcing3YyvuFewaWdQlHHWwHPQIDp1iGw8TuzCow=;
        b=SCC6ged4cedSh1gz/v4/oHm7mT6soasz+6+lJy4D7bo5UEKIrTYrVFVSX3ictD2v0n
         5fTqWniUQ7xJ+8f5sOF8z/iTO2B5JqYUGd2jDRf+ymLQ6F6PpDbaTZ8gcA7I8/KPclHw
         dPVMhr38MXSdxBEEJ3p4PmDyRy+vg+ZplUzpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754257107; x=1754861907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii6avcing3YyvuFewaWdQlHHWwHPQIDp1iGw8TuzCow=;
        b=Hn5JMYGcR+SqkOAk2cx7HlrLTp1hk9+RH6RBfcb/dNMoJWvJj9wm2/W8miWfYooLXp
         681guejRpOOjTjGvgpM8lQfdS7LgB7tblWCmYjvtBp0/JnqlufMLUrjOaktkhfz6o+fr
         VAywNwPH9RXPEkkk/9Ssm2df99aW+9+RUKoHqmxe4FlHeNdhABZQzyzV/5sL0tSNz7zp
         yrCONeL6sfhoKlSpUe1TY2N5+X3tYCxqxVnCEoV6Q2Oz44iYErUU2ejH9U+U1fYEk8hZ
         v1Meq4R5hepwaQkaYt7gTNxKiESgUvg1HdPOo0AuxEE5RDPBtIhJ9ca3AOf/nKDnTSky
         3+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUs8mhtMiStMnbeOUDWZu9BsZIS6tL7VR1zt7U2CJS7uHOK11oQZKzExRxykWkYTZcwdX+lXR/wcQvqQ9EU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iWkRTd201oTN6L5m3vzYdjls7SWwg4hqEIvRR98/X776fILE
	I4fpfNgXjNqkU8TpqeNf6fMHOw5SueMfLeqHt543PIgYAUdLmsCC5u8MPVp3JTH8tvfzIUDktsq
	HxyLWQp8=
X-Gm-Gg: ASbGncuGvmdiFYjnqrcYDc629Xt9uovY26fdJUmiKV2JRzITXXwDsO0UYWC6ZGgQsia
	wHR3jp0YF//6Wn/9yTqXg2cGFR9HMqtYfORCI2rIWjJpF9QcnwEjwWLUhvvYUSIj6GdveagYlcF
	ug0akGI8/Cq1ab9d7FSmAlWZ76bXvCY/mIFeRzWBjJqKIkUAAdtx90OKj6xOeNkc/k0by/TPBBb
	AiEiTA30EvBgltMXnXGX3o7u56CkfKRBx22mwnTOcJW0zIaXVWJc1pCNpIqNu3Eyz5on2hodDTq
	mrf1xrF4/tmqcyu4r1/ecC2iLsKGaL3POH79tatxdJpwxMnlm+ih7JUxoAgUnEd+9ZjcAGeZ2gw
	hHvbsRnAYlRe5DSaa7AdB6xhOabNgQIv2JuQG6/1iP+Z3pDScFuyUhGQCSLBGWe8JeFBJXEo+
X-Google-Smtp-Source: AGHT+IEx1bj3ajW3e4ksbAC7is3R9MT5CsCRA/oxIGejfGhfOH2mUKaKy5lV9oJxaYqW2/WjpQ377w==
X-Received: by 2002:a17:906:f59f:b0:ae3:c5b3:3810 with SMTP id a640c23a62f3a-af94000c089mr623658766b.13.1754257107474;
        Sun, 03 Aug 2025 14:38:27 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a243728sm632658266b.138.2025.08.03.14.38.26
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 14:38:26 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso4839532a12.1
        for <linux-modules@vger.kernel.org>; Sun, 03 Aug 2025 14:38:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8uKenFgyoqY+qygD/KzxF21zlloE0kmEdMsE8q6ww6ASxiu8kHVIURedKvD9whDuwXyWntftPDn4OeNN/@vger.kernel.org
X-Received: by 2002:aa7:d045:0:b0:615:539b:7ade with SMTP id
 4fb4d7f45d1cf-615e715bf2cmr4825471a12.20.1754257106181; Sun, 03 Aug 2025
 14:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803131809.4890-1-da.gomez@kernel.org>
In-Reply-To: <20250803131809.4890-1-da.gomez@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Aug 2025 14:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbY2xZpj6c-vWG0qeiDVpGa6SLA8DqqAHP2S0mu3b_pA@mail.gmail.com>
X-Gm-Features: Ac12FXzcOEfC3UC0vHGCKY61V0ncIS09ZdbQ_3DkQm0xwwbNPazHgNkkQrf0VPg
Message-ID: <CAHk-=whbY2xZpj6c-vWG0qeiDVpGa6SLA8DqqAHP2S0mu3b_pA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.17-rc1
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 06:18, Daniel Gomez <da.gomez@kernel.org> wrote:
>
> Note that this had a conflict with sysctl changes [1] but should be fixed now as I
> rebased on top.

Christ people.

Read the documentation and *years* of me sending out emails about what
maintainers should do. Conflicts are *not* a reason to rebase.

See

   Documentation/maintainer/rebasing-and-merging.rst

and read it. Read it twice. Then read it again until you really *UNDERSTAND* it.

I deal with conflicts all the time, and that was a particularly
_trivial_ one. I'd *much* rather see a conflict and know that "yeah,
we had people working in the same area this time around" than have it
hidden by a rebase that also invalidates all the testing it got
pre-rebase.

And yes, that "invalidates all the testing" is not just some
theoretical thing. We've literally had situations where tested code
became "oops, now it doesn't work because we rebased it on top of a
tree that had different assumptions".

Is that common? No. But it's just one - of many - reasons not to
rebase, and "it had a conflict" is *NOT* a big enough reason to then
think that rebasing is better.

So "it has a conflict" is real information about the development
process, and shouldn't be hidden.

Yes, there are conflicts that are *so* painful that rebasing things is
worth it. This was not it.

And this rebase was particularly bad. You did *everything* wrong. Not
only was there not a good reason for it, you picked a starting point
that is KNOWN BUGGY AND BOOTS TO A BLACK SCREEN ON MY MACHINE. So now
your new work is basically built on top of something known broken, and
as a result, all *your*  commits are known broken too, even if that
breakage isn't due to those commits themselves.

So your rebased state is all built on a base of sand, instead of
something good and stable. And if somebody ends up having to bisect
this because of something it introduces (or even just happens to
bisect into this area for some *unrelated* reason), you picking that
random - and bad - base means that now that bisection is potentially
much more painful than it needed to be.

And yes, this is also talked about in the documentation:

  "If you must reparent a repository, do not pick some random kernel commit
   as the new base.  The kernel is often in a relatively unstable state
   between release points; basing development on one of those points
   increases the chances of running into surprising bugs.  When a patch
   series must move to a new base, pick a stable point (such as one of
   the -rc releases) to move to"

I've pulled this, because I'm flying out tomorrow, and it otherwise
looks fairly simple and straightforward.

But dammit. DO NOT MINDLESSLY REBASE YOUR TREES!

               Linus
