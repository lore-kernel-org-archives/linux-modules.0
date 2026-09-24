Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E542D746;
	Thu, 24 Sep 2026 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282205; cv=none; b=HE1j46EZdnJJvNKmLxg0h0gmUZueSfV8c2CQgU6Ag+Y/Y1kIP5YjNvGRdSHcIkKKT8ksUB70p7PZG42sYYSOjYDZKGRoB+Es8B9ckEZURqy6Y2KtzqrxNWUEzlOSwIgxAqH8DVB7YQ81I9uk0W/fuEEje5fZWIXb4NDhAb5MiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282205; c=relaxed/simple;
	bh=oQ/14GPTrChnfT4++jF5s3SdHkpdcIG4XD6YdC81Ltk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBV5dTAbaKdZVz+AHYiHt7pktCb27jf1KCbU2hHukdu0pREX8NWTO9JsyZmduNEFzJr9xryDE0blPyi9TQ0wfkvSCcLlyWsbmR4g8xaeBiBWPGLC21wLH+zetIqRLrrIKuy8e4DKPPpSjXhMkBPPQU4rWj/8jYfaX3GdQnHTF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XytdA4iD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XytdA4iD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26901F000FF;
	Thu, 24 Sep 2026 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790282200;
	bh=dIOLARr1d9hXxeNQvXpWRmH1lYfFthB2RDeZ4OCZT4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XytdA4iDZvNN4QiVf5tVZbDOKbCzmcp5D7O0hDDQbFke8477mtkXHMB7ZuOBbQaxx
	 rkn8aClgeZJx/Lwq7LENUeUGYhSRzuE+SlaZtx+4Foj+9gcCdmDZBbKuaWLoAl8k7W
	 Qk1RQK4ol6BJZFrnmyZLi9QFiqpEniM+rm8eFr+Iue9top0TgeLxpKI9d89/aIiN+N
	 b+825DSDYMWbG1LdhIfUrDH6SEECG3MG2+DFYxJsU4Geu3MZTcugAi9jCgDv+Snptg
	 yaJxEwDdxhQi69Y8xDNGji5JVczHLnzTBJLIlH6kzh1ZQKUpuohN4YQDJnfthMFNjk
	 WcXb8gBUgwNbw==
Date: Thu, 24 Sep 2026 21:36:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: linux-next: build failure in the last build
Message-ID: <d930924e-17ff-4b3d-82a0-7220abfd121e@sirena.org.uk>
References: <arVxd8GejREjgvPt@sirena.org.uk>
 <qascvrv6wprgcnd5rtc2n63ryq23exbzfcshmejmk4tapmrbnc@rxce2vktppvs>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0JWrN5Yj7wTJJBEM"
Content-Disposition: inline
In-Reply-To: <qascvrv6wprgcnd5rtc2n63ryq23exbzfcshmejmk4tapmrbnc@rxce2vktppvs>
X-Cookie: Oh, so there you are!


--0JWrN5Yj7wTJJBEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 04:28:07PM -0400, Aaron Tomlin wrote:
> On Thu, Sep 24, 2026 at 07:52:39PM +0100, Mark Brown wrote:

> > ld: can not size stub section: file truncated
> > `$d' referenced in section `__patchable_function_entries' of kernel/khe=
aders.o: defined in discarded section `.discard.addressable' of kernel/khea=
ders.o
> > `$d' referenced in section `.init_array' of kernel/kheaders.o: defined =
in discarded section `.discard.addressable' of kernel/kheaders.o
> > `$d' referenced in section `.initcall.modnames' of kernel/kheaders.o: d=
efined in discarded section `.note.gnu.property' of kernel/kheaders.o

> > I have reverted that commit and 1ca4515ee4e01 (module: rename
> > module_blacklist to module_denylist) which collided with it. =20

> At first glance, this appears to be caused by a corrupted/truncated
> kernel/kheaders.o on the build runner rather than an issue in the patch
> itself, no? Could you try a clean rebuild of arm64 allyesconfig with the
> commits re-applied? It should build cleanly.

This was a completely clean build, I only do one of the allyesconfigs a
day and the builds are done in tmpfs with the machine powered off
between -next runs.  My first guess would be that you have overflowed
some size limit in something.

--0JWrN5Yj7wTJJBEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1idQACgkQJNaLcl1U
h9DBPQf/atjHRXsv0kKSliy/Sozsr9Lv/Kcfeb3/zqs9q9hGR7X/sr7FzVUUJ22C
Xw2i+LcDBfEA4JTS2Rlt51xdcPHX/9KWQbnZE6ZIbs6cpgmk4OE+tzmrEmrXuPsP
THHAiXaaEzstFu4Ay67fkWTL0FWcwGJeW2f3tP13y+gt1URSoTHmCpBhb6/SNcXL
PN+aGpSaNsOOxEklmmfly6J1H8b11kJVsBVclIirfdbzvfzYslLirqqLEZpmw1Sa
1i0TWS75rUV08qTLwGnIcQtaBV/5pfVru6Aw+CTk0TcIdLkIEqn2xgyd0ABQgwMp
pHXItLrifiMSW1c2zyzPw+Jusap2Hw==
=PnK4
-----END PGP SIGNATURE-----

--0JWrN5Yj7wTJJBEM--
