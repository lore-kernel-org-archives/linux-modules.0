Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517443;
	b=xes8IANxlfQrqeDdziPr7Cd+1EhVmxFl/ksSj0OGlGM57SO5s1VDMLIQO9OGEeLCw/6u
	 EjYXVPgRoU315XwauTd/vfWCh/LIFJfo/wYCT7dtz4AJ2avGv8uVSt/FdwtN+O/8afenf
	 3JRZtWpIXF3zNL7ZsL3ovu7uT0xoHcnsf/MwIjkUjNe9RZcMTRu9mXpgOgTGu6LhJTO1S
	 bL1zuBQQa04FW0Ddt9ZtYrDvQuifbSvynfDP5grsjomiKoHMvNdxZ4zZ7vnPhU6hO1ZT4
	 L+Akc2Z/E6rgmU1I9teXl1IWJso6qp/WoFUq/iZTQdPkbQw13tLcqT2+uQUZCDDQVBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517443;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=z5AlF7LiBXPBxNa4lF4jQkP/Wv9l3nvO062M0dUFJKg=;
	b=DVL9FnQsVelOjEjq4ofnZATmfonTRiNqhwpWzPzxcQyAp5YEVpd5yQyejk0okFAH9py5
	 DCnI02GFWhXfmdW7NLTI30GjksEwbTTAcUEtFH2yHTRcWjcUwaEm9vYkUC4apRQ3g6Xh9
	 AKYLanfcQxqjFSikczjW6Wi/mWhBaQ4O66Agx74Kt0uxa+Fqt1jewRCeUJ33odnTwmJ8A
	 G05Tl//5a5cLjUeMhPpMh+vOyXKM2+pDWMeEe8Oa1uIIDBY5UpYdM5wh0hwN6ypezwZKO
	 S6kEYotKkUxyW/0wXVdBdw5QY3RPHu9fV1NK79GNaqUNVzYmDCIG8Wu8X0nS7cnLZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=DDcz2SF3;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DC606A327;
	Tue, 20 Oct 2026 17:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906DC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=DDcz2SF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792517433;
	bh=YBN74gM+n3rXaBd6av6nSy3uIjapT/id0/lw64X2cNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDcz2SF3/O8ZlyLdqMI+6TM47YwkNOcchrVx3hVOGvUQWwqmd6cdQnxHRkhqDhXEu
	 i8R4laY5iMMAUBPQRh9FuA/tUv86VGpCWNuIG9ZZ95y0OG0sfrxqfkgxv3R0ohEsAU
	 EAwxSqsWUct5ZWO1fEWXiBVFxtg5lQ3HtRdhpzlc=
Date: Tue, 20 Oct 2026 19:30:33 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexandre Courbot <acourbot@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC 00/11] rust: add support for dynamic debug
Message-ID: <310ae622-20e8-42ac-b501-4315c4cd4d14@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>

+To: Zhi Wang

Hi Alexandre,

On 2026-10-20 22:14:12+0900, Alexandre Courbot wrote:
> On Sun Oct 11, 2026 at 9:52 PM JST, Thomas Weißschuh wrote:
> > Add the Rust infrastructure to integrate with the dynamic debug
> > infrastructure.
> >
> > Static keys are not used for now, as the full bindings are missing
> > for those. A follow-up series will add that.
> > Also custom classes are not supported yet, but could be added on top.
> >
> > Patches 1-4: Generic Rust preparation patches.
> > Patches 5-7: C dynamic debug preparation patches.
> > Patches 8: Rust Dynamic debug infrastructure.
> > Patches 9-11: Rust Dynamic debug enablement.
> 
> Were you aware of this series [1]?

I was was told about the original work from Andrew back at Kangrejos.
However I was unable to find it on LKML and it was not clear how far
along that series has come along. The posting of Zhi's v3 only happened
after I started on my variant, and I did not see it until you mentioned
it. So my development is completely independent from Andrew's and Zhi's.

> There seems to be quite a bit of overlap.

Indeed. I see pros for both serieses:

Mine:
* No FFI in the fastpath.
* No need for RUST_MODNAME.
* Use of Bounded.
* Tests for the flag encoding.
* modname!() as function name.
  (As discussed with Benno and Gary and LPC)
* Better encapsulation of 'struct Descriptor' (partially not yet posted)
* Use of Opaque<> to wrap bindings::_ddebug (not yet posted).
* Use of !cv() (not yet posted).

Andrew/Zhi:
* Better docs.
* Static branch support.
  * static_branch_likely!() support is missing however.
  * I also have follow-up patches to enable static_branch_likely!().
* host doctest support.

I am perfectly fine with merging both serieses.


Thomas

> [1] https://lore.kernel.org/all/20261001145940.1077801-1-zhiw@nvidia.com/
