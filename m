Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532220;
	b=gZnDJqhUt16jvIyBgUrG9+8dtod+IFlmBmkYLXwyF+p/EiScZW3HVhZTl51wOZ/+0j2Z
	 BQnQLFfS1mTnS4gAuOaa/Ce/sVX8SLidCmoOl277pyjwbMRqIIhVJlLTdWgDChLgtvqEw
	 q4WSVP2O+4q10PyKlVatyCmmWYB4i/xA7Sz0fePv3SDjqGafmSSkjRcnR95QJlZymZHBd
	 GAh9lVJTLmFT7+YB4NEEDcW/fORfdBEOsTML4Y4Dwpoz3bsPf8Yk/5snbMHKrr+ThnOvl
	 pj5lAb8jjnqUmHvmwyy2ynBKsvDRVWMEkijiO4Ibu2CHW4A3/N79UocF4hWyZDWlzRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532220;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DniO7GTUvw7bqTyFUYAZgt74jqpmOaAIKPkBtG5q2Gk=;
	b=KXuVmH7vf6SeonReslLLvNHG7t1ACs5bbzkWZAiR9WUr2t4RXME3TpZo3KFzYmt3dieN
	 HN+tTULB81qp3EIU7WVBy5rMbvRvkLzQWB71eddazBsX+IC6bBfrK3k7oZ5LNUGmDmb9M
	 FXA2axKDZukYb5iCUmZs1I9AAUhgrt15DYiBSImQLsCV71ZU3pfCheeNFdMwrvxwjjyQW
	 r/7FGQGX5YKLzJlEaoS3hrD1n6oIOFACAx5KgNTidBrJeHVQwbjbBFMOJBFdxuQd5T6Kj
	 7g+koEybe4snDvS866KMJTQMBp1CW0hwTTGZiUNpkniRHRLTeDcvLi5s3IjqSyBlpag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=IKuIkBXf;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F295606A31A;
	Tue, 20 Oct 2026 21:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F295606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=IKuIkBXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792532217;
	bh=PyZDwwkl589eMcugJzYk5y9RrjeAtVDA2rA8OJ4cCWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKuIkBXfYbTxMiG93vM1wcRM3MaxqlK22grQXBNdYTbTlJMjoj9HuH2Gw4EIilORU
	 BAPCqnsTj5dJg3ozea2Z0O5yuIgrdkkj4f4clQDyhDUJKTxEeiI5K8ELoOGorn+l8k
	 WTwxjqyekY0t4jB0Jyl2rLTb3az1y84bQlgmcyuY=
Date: Tue, 20 Oct 2026 23:36:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Zhi Wang <zhiw@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
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
Message-ID: <ffe50a28-72d7-4b88-b7db-b7a590aacbc4@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>
 <310ae622-20e8-42ac-b501-4315c4cd4d14@t-8ch.de>
 <20261020212542.2e3331c4@inno-dell>
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
In-Reply-To: <20261020212542.2e3331c4@inno-dell>

On 2026-10-20 21:25:42+0300, Zhi Wang wrote:
> On Tue, 20 Oct 2026 19:30:33 +0200
> Thomas Weißschuh <linux@weissschuh.net> wrote:
> 
> > +To: Zhi Wang
> > 
> 
> Thanks Alex for bridge the threads together!
> 
> Hey Thomas,
> 
> Thanks for the comparison! As a user of this feature, I'm happy to
> combine the two series and see this making progress.
> 
> The Bounded types, bitfield tests, and module_path!() fallback look
> like useful additions. One clarification: with CONFIG_JUMP_LABEL, our
> disabled path already has no FFI call. static_branch_unlikely!() is
> sufficient for our initially disabled callsites, including enabling
> them at runtime.

Ack. Although adding jump label support as a later step would make the
patches smaller and easier to review.

> For the combined series, I'd like to retain these behaviors:
> 
> - Debug logging is independent of debug_assertions, starts disabled,
>   and is controlled through dynamic debug. IMHO, fewer distro kernels
>   are compiled with CONFIG_RUST_DEBUG_ASSERTIONS=y nowadays. (At least,
>   Arch and Fedora are compiled with N)

Ack. It would still be useful to also support default-enabled callsites,
like the C version does. What about '--cfg DEBUG'?

> - Disabled pr_debug!()/dev_dbg!() calls do not evaluate their
>   arguments. IMHO, it seems the current dev_dbg!() in your patch
>   evaluates the params before checking the switch on/off. (pr_debug()!
>   looks fine though)

As far as I understand, fmt!() itself does not yet evaluate the
expressions passed as arguments. It only typechecks and
creates the precompiled Arguments<'_> structure. The parameters' Display
traits are only executed when the Arguments<'_> is written somewhere.
IMO the typechecking should be done even if the code is going to be
compiled out. Similar to no_printk() on the C side.

> - The dynamic-debug prefix flags remain supported. (I use the C version
>   of dynamic debug to support e.g. +m, +l and _t)

Absolutely, this is a bug in my v1. It is fixed in v2.

> Could you share your pending encapsulation/Opaque and static-branch
> wip patches? We can then work out how they fit together, incorporate
> Alice's review feedback, and preserve attribution for Andrew's work.

Here:

https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/log/?h=b4/rust-dyndbg

> Thanks,
> Zhi.
> 
> > Hi Alexandre,
> > 
> > On 2026-10-20 22:14:12+0900, Alexandre Courbot wrote:
> > > On Sun Oct 11, 2026 at 9:52 PM JST, Thomas Weißschuh wrote:  
> > > > Add the Rust infrastructure to integrate with the dynamic debug
> > > > infrastructure.
> > > >
> > > > Static keys are not used for now, as the full bindings are missing
> > > > for those. A follow-up series will add that.
> > > > Also custom classes are not supported yet, but could be added on
> > > > top.
> > > >
> > > > Patches 1-4: Generic Rust preparation patches.
> > > > Patches 5-7: C dynamic debug preparation patches.
> > > > Patches 8: Rust Dynamic debug infrastructure.
> > > > Patches 9-11: Rust Dynamic debug enablement.  
> > > 
> > > Were you aware of this series [1]?  
> > 
> > I was was told about the original work from Andrew back at Kangrejos.
> > However I was unable to find it on LKML and it was not clear how far
> > along that series has come along. The posting of Zhi's v3 only
> > happened after I started on my variant, and I did not see it until
> > you mentioned it. So my development is completely independent from
> > Andrew's and Zhi's.
> > 
> > > There seems to be quite a bit of overlap.  
> > 
> > Indeed. I see pros for both serieses:
> > 
> > Mine:
> > * No FFI in the fastpath.
> > * No need for RUST_MODNAME.
> > * Use of Bounded.
> > * Tests for the flag encoding.
> > * modname!() as function name.
> >   (As discussed with Benno and Gary and LPC)
> > * Better encapsulation of 'struct Descriptor' (partially not yet
> > posted)
> > * Use of Opaque<> to wrap bindings::_ddebug (not yet posted).
> > * Use of !cv() (not yet posted).
> > 
> > Andrew/Zhi:
> > * Better docs.
> > * Static branch support.
> >   * static_branch_likely!() support is missing however.
> >   * I also have follow-up patches to enable static_branch_likely!().
> > * host doctest support.
> > 
> > I am perfectly fine with merging both serieses.
> > 
> > 
> > Thomas
> > 
> > > [1]
> > > https://lore.kernel.org/all/20261001145940.1077801-1-zhiw@nvidia.com/
> > >  
> 
