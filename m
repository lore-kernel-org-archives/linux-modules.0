Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4651991AA
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.94.204.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712125; cv=none; b=u3k2r8imBIeIUTY2pzFcWQEConoGFK+VuO3ylR6PsUXebG2fdXxi+rBnNGZKhO1MIvVQxAAooT/XGWr22LaQAwHitOqVcOGUBMeevMAIhvvOXozs7fH0AtQOkyrfwlNWuamnMrDqp4sFn/SfodMObN4mJy6wINcg7P5CwLg4if8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712125; c=relaxed/simple;
	bh=DWzfI0VDHFKLwc7RyiZTo/jEdNRw5QJQPeoL5YBIrY4=;
	h=Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From; b=kRWR7Aln1+Bo+auJCLiK0s5JcYM70G+bUWbYY8e5GBm2B0EOjWDwoaSeaJSN6YgLQVmFZkSesRVljIOfdE6+2HqSmfAtodDdc1cf6GoNKV2i8oy65yNmKRHxKVXHGW4Ol+ds/OzJUbIiobla1joBmQ92svcqJREZhlT7drROAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Linux.IT; spf=fail smtp.mailfrom=Linux.IT; dkim=pass (1024-bit key) header.d=linux.it header.i=@linux.it header.b=qq9A6TsD; arc=none smtp.client-ip=85.94.204.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Linux.IT
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=Linux.IT
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.it header.i=@linux.it header.b="qq9A6TsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1723711739; h=date : to : subject
 : message-id : mime-version : content-type : from : from;
 bh=DWzfI0VDHFKLwc7RyiZTo/jEdNRw5QJQPeoL5YBIrY4=;
 b=qq9A6TsDkNriDnAWbhPoUaF8P98+HZrxbN7NEz3syn75kC1bQ3Ztg6hyLBKN4frRPn9ck
 /xjV7WAjl1yWP1ij5TjjAAIONg4R45+6aFN+DxFEi5w4IZKL+rpdHxKiftfKrHx+9IZadkY
 DXmJ7RZ1xyGB9CVxWfPIFyiiuZcSK18=
Received: by attila.bofh.it (Postfix, from userid 10)
	id C3A6217C1483; Thu, 15 Aug 2024 10:48:59 +0200 (CEST)
Received: by bongo.bofh.it (Postfix, from userid 1000)
	id 6AAA15258AC; Thu, 15 Aug 2024 10:48:55 +0200 (CEST)
Date: Thu, 15 Aug 2024 10:48:55 +0200
To: linux-modules@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: the prebuilt mod-weakdep.o is missing
Message-ID: <Zr3A96SfR21UjdL1@bongo.bofh.it>
Mail-Followup-To: linux-modules@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IW67H2joSuFiJ1di"
Content-Disposition: inline
From: Marco d'Itri <md@Linux.IT>


--IW67H2joSuFiJ1di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So building kmod 33 with --disable-test-modules fails.

I build the Debian package with --disable-test-modules because the=20
kernel source tree is not installed by default on the build daemons.

--=20
ciao,
Marco

--IW67H2joSuFiJ1di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQnKUXNg20437dCfobLPsM64d7XgQUCZr3A9wAKCRDLPsM64d7X
gXhAAP42Cbn88DBobs+jptmBjdD98YTPFgEeBvFrglkbTmNb7QEAoQWZjVcNEmh2
dt7r4+uD3jPK0aYfF5Bvc+t0Ulq/kAc=
=8kwj
-----END PGP SIGNATURE-----

--IW67H2joSuFiJ1di--
