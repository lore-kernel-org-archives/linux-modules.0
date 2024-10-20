Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E7EAF6;
	Sun, 20 Oct 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729445302; cv=none; b=KC+HSyhkPGu1g+eloNLQFYQPtek5JP5mR7zF0TBtLB6qMkOnDT3H6GHO76Zw3zPoHcQrbe06aJd/Odfmqj52/RBJaHMPAjhSByWLRydFaUJxygubyd5MfCbbxfotjDfX7AqHWdEXHxrSc1OIcL08lJyECA3TQ1PkZ+vmempeZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729445302; c=relaxed/simple;
	bh=YMxtJ+tEYbzwb2WO37t/lB+wTVMicOsjBgBCeMXj41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUxsKLaRgNPMObCLRyVpudJpidd6/YaZ9JWdCkxcUff6PTwFrT27KqQNvqAUwsqLK87ULN8U1bmv93ug1Gbkk2PwzU7osmPatjrAFAXf1x65IF03hmCV8gznomlx6tk5PCWfj7a+cMLuYGX091egkqe4QePIcYVfvOKJyqcCeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM/SFsbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM/SFsbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377C2C4CEC6;
	Sun, 20 Oct 2024 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729445302;
	bh=YMxtJ+tEYbzwb2WO37t/lB+wTVMicOsjBgBCeMXj41Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CM/SFsbxK0S5GIfM7y9UmvGwDH/YnbdcekQp95GgKDEsoSwhWJrRNVSQp5ygK/G9u
	 35QsXe/uIHpOEodrRTQDtnGnU618L2n9rW7ZuvCiZO353JEb3m9v6/I5MpvCIePUBM
	 0pFYshd3NzZY3duqb1p0xt7MRbbZaKm1ozLA2gUKxn3X5/U0um2tK1a3ByOpiZGd3c
	 vilW6RMz2w4KTne5xBd4w8qLMGBg1KHdhxlZbuV8wW9jKQ1V9Bvsld6WHSyyUR3FYS
	 HadMQ38C1PE96Uy6TBdgem4vGOPjLSoaMAjLaGaaRDbeIj0cNTJmcAu0DL2L96p1E9
	 Doz+g8Mp+2raQ==
Date: Sun, 20 Oct 2024 10:28:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] next: use new shared modules tree
Message-ID: <ZxU9tMF7SPNfPYok@bombadil.infradead.org>
References: <20241019212100.940549-1-mcgrof@kernel.org>
 <20241020215949.41324ccf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241020215949.41324ccf@canb.auug.org.au>

On Sun, Oct 20, 2024 at 09:59:49PM +1100, Stephen Rothwell wrote:
> Hi,
>=20
> On Sat, 19 Oct 2024 14:21:00 -0700 Luis Chamberlain <mcgrof@kernel.org> w=
rote:
> >
> > Use the new shared modules tree as we have more than one
> > modules maintainer now.
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git
> >=20
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  Next/Trees | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Next/Trees b/Next/Trees
> > index 38812059087c..585cddaf8746 100644
> > --- a/Next/Trees
> > +++ b/Next/Trees
> > @@ -252,7 +252,7 @@ regmap		git	git://git.kernel.org/pub/scm/linux/kern=
el/git/broonie/regmap.git#for
> >  sound		git	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.g=
it#for-next
> >  ieee1394	git	https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/=
linux1394.git#for-next
> >  sound-asoc	git	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/s=
ound.git#for-next
> > -modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linu=
x.git#modules-next
> > +modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/modules/lin=
ux.git#modules-next
> >  input		git	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.gi=
t#next
> >  block		git	git://git.kernel.dk/linux-block.git#for-next
> >  device-mapper	git	git://git.kernel.org/pub/scm/linux/kernel/git/device=
-mapper/linux-dm.git#for-next
>=20
> Done
>=20
> Currently only you, Luis, are listed as a contact.  Should I add anyone e=
lse?

Yes please add: petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@sams=
ung.com

  Luis
