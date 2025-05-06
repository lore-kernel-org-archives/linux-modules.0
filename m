Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E08265606
	for <linux-modules@vger.kernel.org>; Tue,  6 May 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522284; cv=none; b=Pdy+XWZ5gu1K28rp9VWmmpZucDuD64Gnerd5eYACY1cJRTcKS1wcDv7/BUNEsBXJukRNe4ZFMRL1vtXoac39SeB+LtD33oVTIIlefcXhyc8MmmnOlCOuyL67WgSILenlyQXTwxUI1rhHGrJNZT9UPaPlIenhAYqRBZY860Q5iZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522284; c=relaxed/simple;
	bh=zplIZDClt/oDvQt+VX9oxdqDzXOTjh065Vyto2PWUMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvtYEJyieBMRu3FW/9pCdbXr6cDDPWCUagHrt7v4cA8TDh7OxyjRLFgx0O3E52kHBXrVKxah62AUjLrX8r61Sdk7puqaxW3ly0YIc8+htw0vsHoeidcOoneAyJPZmNXuxNj+4pCRGddrlYQ4JI52mpVJZ6THxHoQxF8ySntD+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWXVjT44; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWXVjT44"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912a0439afso1515671f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 06 May 2025 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746522281; x=1747127081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5jSM0Mw112x9yT1bwLIWs6RgX4XTv762zGBPx0kiRc=;
        b=FWXVjT44DXE5k/we1wEEt7sgJLyrTkZLHBh7ksjKQaCvA/WKiUhxt9XKJ+V7P+jcQH
         OVoDLy+zH8gE/reWBMxK4CrarCXi4BbdwGjE6PsX5ZU2FjFsbH93LgTERuvGRqLWXicP
         f6yaUzrfxEG8JrN67ujxgvqcrheox38iv+7cxS9Tp7ukfM6bzGOP6rr5mKrG6A+D8Dlk
         My7Xxm5+Vz0WoZwVxCxEZkl8LfVSKHnOcb3VUsNmNXThBNK0my830DzmK9nPvg5vLtyn
         YtzHVy09p86K/x2jah8HXt4/JK20jssSYARYL0JqZODJVhnhl5REVYz7KaCA+ZQuVdtg
         udlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746522281; x=1747127081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5jSM0Mw112x9yT1bwLIWs6RgX4XTv762zGBPx0kiRc=;
        b=dwxy8ofVN2lNKxQFxUPs/5pM7vCcdwz21sGzAvG34BlAXS5yHIhIp3BlT54kxPT5nj
         8Nb3yUB+AvlA/aeRud7mfo0u+U868A6EMw41dwuAlbglozKKlxrQxjHLlgsJOFAuk3Ex
         VTHm+L3jtVjYEp6ttBbcXAbHALbu01PA3K+gN2RJgCqAlc1B1jpF7CuIZtyVHa2GxjGH
         Bz67MPnrSaCJn+KzkbXqQG0FOgFb05PmXBGXjbeDxQnPWb+WqlS1YYqQfhfuo6b3uaXV
         OwgxzEuQQyRgjXGhEo2wWlVPuNh/7U2CB64EGmUkhC81czgP+ZECxJ5+klLHtqGiOV4W
         hdNw==
X-Forwarded-Encrypted: i=1; AJvYcCWr8ZoE6HbFrclM8TkGQ/bkoN01FGlDLfIQ6VY1sCS3agpB3zHEzpJ2dq0C1RWqSsWdU89MYpJDtbsWlP++@vger.kernel.org
X-Gm-Message-State: AOJu0YyGd1Qp4wpGFFYQ4RRMXg+e5dmpsFmPaMDyalE/Dee+jIpY2SjA
	4FHCiHh97FPfchTfkboCBDxklRYy6EM9jkuyN+55R2i6NpvZUiFUb06OW3g0md94VqVeGE342Kx
	0h/BuVsKhr4Sj+w==
X-Google-Smtp-Source: AGHT+IEwc008DIjIQQmGrUFg5u+PpfGLKjFm4m3GYeWDBHRyDcFWy4+2lh4YOz+u1AorrP0PE1ytj85FjprTXE4=
X-Received: from wrbfa7.prod.google.com ([2002:a05:6000:2587:b0:39a:bdcb:1ed9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2506:b0:3a0:b203:450f with SMTP id ffacd0b85a97d-3a0b2034714mr566902f8f.22.1746522281087;
 Tue, 06 May 2025 02:04:41 -0700 (PDT)
Date: Tue, 6 May 2025 09:04:37 +0000
In-Reply-To: <878qnbxtyi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502-module-params-v3-v11-0-6096875a2b78@kernel.org>
 <20250502-module-params-v3-v11-2-6096875a2b78@kernel.org> <WroEJHY8a-y8vbSQkUvGJJs7yTQGKMsHJqmWFYGkz5bZ_PsiE8GAozjSaNpWjWina1XanjVNpV0Av3woiaUtJg==@protonmail.internalid>
 <aBTMMHWNXS7wK7zS@google.com> <878qnbxtyi.fsf@kernel.org>
Message-ID: <aBnQpWJeiRKIMJ5D@google.com>
Subject: Re: [PATCH v11 2/3] rust: add parameter support to the `module!` macro
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, May 05, 2025 at 11:55:33AM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Fri, May 02, 2025 at 02:16:35PM +0200, Andreas Hindborg wrote:
> > It would be a use-after-free to
> > access it during module teardown. For example, what if I access this
> > static during its own destructor? Or during the destructor of another
> > module parameter?
> 
> Yes, that is a problem.
> 
> We can get around it for now by just not calling `free` for now. We only
> support simple types that do not need drop. I think we would have to
> seal the `ModuleParam` trait for this.
> 
> For a proper solution, we could
>  - Require a token to read the parameter.
>  - Synchronize on a module private field and return an option from the
>    parameter getter. This would require module exit to run before param
>    free. I think this is the case, but I did not check.
>  - Use a `Revocable` and revoke the parameter in `free`.
> 
> Any other ideas or comments on the outlined solutions?

I think the simplest you can do right now is

trait ModuleParam: Copy

so that it can't contain any non-trivial values. That way you don't need
Drop either.

Long term, I think we need a way to detect whether it's safe to access
module globals. The exact same problem applies to the existing global
for the module itself - except it's worse there because we can't access
that one during init either.

Alice
