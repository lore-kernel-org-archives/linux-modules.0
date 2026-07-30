Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452123EDE57
	for <linux-modules@vger.kernel.org>; Thu, 30 Jul 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402713; cv=none; b=GaY15Ot4lIqF8nhN0FQsOUgkImyQjZwgQ9+lbhoBN2oCMtL3FSGRwin/nOUSUy2C/v1dgNM1evrFUFAUnO+brsGn2DroIxftAxP1iD5730G3XXSu06kW1oryn4mpSlW0R0QZfScp9ZeAJEoiknhVStsdKaXURgk4j4+1HRSX4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402713; c=relaxed/simple;
	bh=k8MrRN1zHzHirQ+riz3nZa56KdQtvZYEXwt1G83rtDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dE/6+cLWZolfJP3CBpKPAbZuP0gdWr+6tm5m6cUw1q/lxEezaXX+JuliXcG1XqwMz55ZGkrdet5zzckSK0D6zoBDK60PV1JOhKGoen6GuZYnnlZ9vPtPs023yA7MIq/ftqjrjvqtnozIiXY9QbMarficy2/0wPlJvmn5mckusEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ija4nvhU; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ija4nvhU"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495495ad5ddso12197575e9.3
        for <linux-modules@vger.kernel.org>; Thu, 30 Jul 2026 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785402709; x=1786007509; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzY0lsTJjXWVanRyLSlFEy2hFBQ+8J2ffhaSCqEExvg=;
        b=Ija4nvhUGD3duWELd8PduG2kaTNeX7BTY+MRSDaapsffIMUENv4VWXYlHZ/TAbGb65
         bZETqWwIVOjPf3pRYi3hH2+Gvt29y/iIGOwrouInStAZgCMkSeY6Zp1o0At07x9dwz/A
         71Pwvcm4Bb2j7LxhmohYvJPvRjgZKNjvhFtwX6vPeoeU36rJKbnUTtdy8OzuyiaB/NIe
         jctxoWbjc2pFnH4ywh+tZRsarcw50rgCsEz3fsIvqfx6T0S2ytGBxv4+48sl9fUm5ZMl
         59+Fw/F6TEouAsz1GEDs0WKEqAlgd3MLPhmV18Q1moe+QO+QBlqy9QYTgmX7CSVzRm7W
         SbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402709; x=1786007509;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzY0lsTJjXWVanRyLSlFEy2hFBQ+8J2ffhaSCqEExvg=;
        b=WZPYAXYqT/zhBo8bcxwIUKfALmNPVUW8yqFH0EGdgP4+gdrFpTsKKwUALpT41EfRhD
         NX8Ti45L9g7Ner8JXlYBB03MNGRzA9GM1Xgfm5W+sJxG//4DrgFYt7TtibDH6omgBIQu
         gXAmorj9s0fm6AH0oDtENh9Jd6/iTuVRNQdHcvbM1vpf4RZ5BS7WEvk6pnQ1B62TTrwq
         t7kMm4cCzwZHMWL3LjnJRyYev9U5nnZmK6NMg2YUxEg7LB0qyT9hI/GtnGNxaRvJc0PP
         EGpSkHmw4AX0I9M32oXGY9QYw2/bkLty16Vt4PGTqVJR89JgUy/u41CMUGqkdeqY4V5l
         Qg1A==
X-Forwarded-Encrypted: i=1; AHgh+RqgPyNTacuWbYLwXxg4ZKhzQD9pJSkOFR4YfIYnq/qotPKXQaXg7oAEnBfR8Uch/ve1ACtP4c5BbJl6xoS+@vger.kernel.org
X-Gm-Message-State: AOJu0YztoyUt5/iZUME42pvCRyZ4s1+7rse1R7oYwb3IiLIU7B5eMhqL
	NtwoWCBDcOyXWzCOptDsNRdM6cvilEnzm+ql/F11ls+lZV36AIn/ZN9qtqJddkWw9WJo+RCxjWn
	AZRotPrzBda8OjwgIMA==
X-Received: from wmbhn27.prod.google.com ([2002:a05:600c:a39b:b0:495:5edc:795b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1505:b0:495:4df2:b8c1 with SMTP id 5b1f17b1804b1-49800ebbf5dmr13261205e9.35.1785402709283;
 Thu, 30 Jul 2026 02:11:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:11:47 +0000
In-Reply-To: <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com> <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com>
Message-ID: <amsVU-1o_zNOIOts@google.com>
Subject: Re: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Lyude Paul <lyude@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 29, 2026 at 11:05:55PM +0900, Alexandre Courbot wrote:
> On Wed Jul 22, 2026 at 6:16 PM JST, Alice Ryhl wrote:
> > +    where
> > +        B: lock::Backend,
> > +        F: FnOnce() -> Result<T, E>,
> > +    {
> > +        if let Some(value) = self.as_ref() {
> > +            return Ok(value);
> > +        }
> > +
> > +        let mut to_insert = f()?;
> 
> This means that `f` can run more than once for a given `SetOnce`, which
> can lead to problems depending on `f`'s' side-effects.
> 
> In the GEM shmem case, we would create a second `SGTableMap`, and since
> `SGTableMap` assumes it is the sole owner, the last instance to drop
> would create a use-after-free.
> 
> Now this sounds more like a problem with `SGTableMap`, but if we cannot
> avoid calling `f` at least twice then I think it would help if this was
> documented.

Hmm ... this is the behavior I want in Binder. Actually creating the
value is an allocation, but my lock is a spinlock so I cannot invoke f()
under the lock. This means that each caller will make their own
allocation, and then we throw away any extras if there are concurrent
callers.

If GEM shmem wants f() invoked under the lock, then that's just a
different operation than the one Binder wants.

Do you think we should add both?

Alice
