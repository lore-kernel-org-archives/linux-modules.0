Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F70459AF9;
	Sun, 11 Oct 2026 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791729819; cv=none; b=B5LkP1OM83XH6F+7aZzLxHy3HORTsHWCwqcyoDZFmKqpJu+ZwGvqJFmNR2+afNJ3Q/OoJskVTxXeUUQ0piphgK9PGzZ00MsHUsZ8D9eUL7IN8BtpaTgwQy/Sm6I/P6pOwwz5Jbbuv0VIKzzt+XMRL3oFTh3hAOc4dr9RYqywQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791729819; c=relaxed/simple;
	bh=FWhS1GSbio4NmB9mGUNLM0ZeY2dHVo2pwRnkMJ0VTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtkNmYGv3IFA41COAPefIjI4O6Xowo5sauRCZOHD81M0+B+tiaQNe/diCBLn/9XAG46/LdZAB83B4f8Pluqt7tF9NUvgvwWm2g6itwdFQvvQDVpYbIGrckukkd7aYgkhow/7qXiiMFAdcH9IQjdsq2gItk+aQG0v/IFtgTQTiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tRnQVSnk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tRnQVSnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791729815;
	bh=FWhS1GSbio4NmB9mGUNLM0ZeY2dHVo2pwRnkMJ0VTUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRnQVSnk7FVLxK7jtlFVL7ogFoBS5QsNFfqcelpy4fLLjaoJRIcd2aSAQtc/uCnfA
	 lfErRvuSm1vsOfzKJVyM/D9lwrA23RfHHmfscdTlaI7RtOvpacS9lmOpb42A0vZKsd
	 wnrzvkqHY3CVOvEVdQBqXezYUXg7ltd7jNNSwRWM=
Date: Sun, 11 Oct 2026 16:43:34 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Gary Guo <gary@garyguo.net>
Cc: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] rust: print: use CStr for __LOG_PREFIX
Message-ID: <db1c04a5-a1e6-41a7-b2ac-f992cd45d640@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-1-832e4039b71f@weissschuh.net>
 <DM211N6KK6LP.2KC9V4ATVEAP6@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM211N6KK6LP.2KC9V4ATVEAP6@garyguo.net>

On 2026-10-11 14:01:45+0100, Gary Guo wrote:
> On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Weißschuh wrote:
> > The users of __LOG_PREFIX require that it is 0-terminated.
> > Currently this requirement is only encoded in safety comments.
> >
> > Switch to CStr which can guarantee this invariant through the type
> > system.
> >
> > As __LOG_PREFIX and Module::NAME are now identical, reuse the former to
> > implement the latter.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> See
> https://lore.kernel.org/rust-for-linux/20260728-printk-v1-2-855606634d70@garyguo.net/.

Thanks. I'll use that instead.

> Best,
> Gary
> 
> > ---
> >  rust/kernel/lib.rs          |  4 ++--
> >  rust/kernel/print.rs        | 11 ++++-------
> >  rust/macros/module.rs       |  4 ++--
> >  scripts/rustdoc_test_gen.rs |  4 ++--
> >  4 files changed, 10 insertions(+), 13 deletions(-)
> 
