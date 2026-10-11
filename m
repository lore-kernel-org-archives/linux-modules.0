Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEF4562BC;
	Sun, 11 Oct 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730089; cv=none; b=ayLU94QElAlOXhpYz5xkThXJMfaNRzL4dDezkrYfFpx4iz1px7qwE9LAQquX81XR4+145B3E2fmceZDQM+Gx4XFuXTfcYFota0Hsask+ChefbEfZOP3Wagw/3s3wA1qGmKD4/1c01opobgGXR/e3w8eb3cnJDPymqX+p92dvwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730089; c=relaxed/simple;
	bh=lnvLyxKhj1jwkZTWcTFY3mbBH+k0hgs+EquO1VEk4uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9yOaYC+F8O6BcOAkqrbZFy5emuc3cMr+zthmogCoh7dKcoIQP252X6R1b2lR219CaTNLdRnBXVe9KAibbFwPCI878eDNtAyQf7ScbEWjpzg6D0kybNF3sGuoSS6XLEsOPZSySawNDGN9+TGaRCs3I2nDu+pLFrqTUxiPALCLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=k4Q9nKVW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="k4Q9nKVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791730086;
	bh=lnvLyxKhj1jwkZTWcTFY3mbBH+k0hgs+EquO1VEk4uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4Q9nKVWti3xhhB0DF+bOSqF2RuUvpWZJRHKt7HVwJCoKz6375Kvg5JPo2eumYK8J
	 SMfJJaC4rQmPB5MPrAunGbwE70pRpGP0zemxxz67bslapby36c1/OC7d9rJIyRq5JI
	 dvhrrkCqJrResDpa9uQgUibI8HZahQJPVNBLgDDU=
Date: Sun, 11 Oct 2026 16:48:06 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
Subject: Re: [PATCH RFC 04/11] samples: rust_print: add debug messages
Message-ID: <bd10f4a9-b3de-4a68-9459-1ccd50ef0083@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-4-832e4039b71f@weissschuh.net>
 <CANiq72nN-X6pZJ8NhUOyLtXNPJWgh7oA7-kU9KaVnvjv-u1gOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nN-X6pZJ8NhUOyLtXNPJWgh7oA7-kU9KaVnvjv-u1gOA@mail.gmail.com>

On 2026-10-11 15:53:26+0200, Miguel Ojeda wrote:
> On Sun, Oct 11, 2026 at 2:53 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > To make sure they are actually printed, enable debug assertions.
> 
> Hmm... why do we want to make sure of that? i.e. users can configure
> the debug assertions, and the sample may show them if they are
> enabled, just like any other code, no?

Fair enough, I'll drop this bit.

(...)


Thomas
