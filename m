Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629336;
	b=0YvsPeY4kP/t1daR5MkXo11C3bOy0KOrd+l+2zyAJ+JlVwCowA917UZBACPKPNYSUVdF
	 K4Y98rpYcXom6d01aqEskNsC1xW7rqKpek6nfSBoSs9nwYhepgYIigsqFYpNbulit5kQJ
	 cnQGMHW/++gTb1zBdZFsqUiu9EykQhfFGg5UmMwuPG9WdVuo6b6sq+cOZCdWWlalbYRLW
	 NwXUXBbkdEz4FLA04aV7wsVc8EAIM5LAH3DpKKZaWjA8zKuH6JEU/MnEf6YmhwRyfUPeq
	 /jHjM1615iH2ip2zSFQ+y6uUk15zW2mfJeAeqB0V8VNdOLPu6nCBezy78Fldy7qTrgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629336;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=45G5FKYAm90nC2vUcbo/zkLyGhVdA6IvWN0opRQkGRs=;
	b=1/IbueLff8x0QJnVJ2fFNXbJX9z+xK5R4nW3QFBy//3NyglbqyGqvcDH+djmazhxEQE6
	 bxK/3sMVPj/KOuRpEJUoxidg8iPRRiNZD0BO1y8ErLhXOWRVqV/tRzY9MGdTlmuiDANR1
	 /whkYK/dz0jPqyMuO8fw6O2fGe5uN4I4ycUlTO/4yOB5QsNrOj1X4u0eX9Nc1+q5jgSNT
	 pHOkuRRmsdTHsPrMBcfl1mds5Yni/8aWIqKaUKyfdpGfRhMwhkCzhg1bCMZsFHnJ+Fvty
	 5Cqek0OAs4/laG64F4DWlqfv6PrmmbafQ/VYYe4rZDa/UVXOCvChQBX+a9qkAyO0LIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uhd3kpc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E8606A323
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uhd3kpc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973871F000D4;
	Wed, 25 Nov 2026 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629335;
	bh=45G5FKYAm90nC2vUcbo/zkLyGhVdA6IvWN0opRQkGRs=;
	h=Date:From:To:Cc:Subject;
	b=Uhd3kpc2uIBoPDAIv74gGEjeYxZx89RBD5Fg2WhIprocgckg/JkjraZLcVEorw7Tm
	 whgvAVZLtw/ZxGz4JRHq+GLjRrCFJ8MetHsJ/GjQU9+8M7U0CT3JMhCDHybAFOD2PV
	 Y8uqC1lQc/MW2DkLCieE7KE1R77BGsH8DhEcn+ltlNV81zHY+vmCCnozjHYQoi/jSr
	 wCrH8to2w/BdvXrK7svo/B6XQEXh7gUa6JCHtwuP/Dw7yLDBPbNkkwhIM8eqP/GLBZ
	 PVI24f5F3s0qujFZ9f9fzhgB5c+EN6sYhetNWLZDYzrzkmvT5YjYLLR3QgPnVsfBdo
	 UcSp+xCFTBdFw==
Date: Wed, 25 Nov 2026 18:55:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Alejandro Colomar <alx@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org
Subject: [PATCH] module/kallsyms: Add missing const
Message-ID: <20c798e8dd466896b3302b1de8b838b037d0b22d.1795629256.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ke7rco3dau73eqdd"
Content-Disposition: inline


--ke7rco3dau73eqdd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Alejandro Colomar <alx@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org
Subject: [PATCH] module/kallsyms: Add missing const
Message-ID: <20c798e8dd466896b3302b1de8b838b037d0b22d.1795629256.git.alx@kernel.org>
MIME-Version: 1.0

This pointer is derived from other const pointers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

This was found when changing some <linux/string.h> APIs to preserve the
const qualifier in the return type.


Have a lovely night!
Alex

 kernel/module/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1ff8ce857d92..65537faeb2df 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -425,7 +425,7 @@ static unsigned long __find_kallsyms_symbol_value(struc=
t module *mod, const char
 static unsigned long __module_kallsyms_lookup_name(const char *name)
 {
 	struct module *mod;
-	char *colon;
+	const char *colon;
=20
 	colon =3D strnchr(name, MODULE_NAME_LEN, ':');
 	if (colon) {
--=20
2.55.0


--ke7rco3dau73eqdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHIRMACgkQ64mZXMKQ
wqkP9w//ROW/GrwDNkhlv9rJX1RtJrUJXCpl1V0A4bN36rrtraJQPr7jLkm1gkWI
6nGiL7Ix91mefOJvOXJPij+l/Kr5hoG6KaqYNWnchFitJBGIV6F/d9ufAuHpEv3j
1E4QES1HSZju65ebSJ89hQVkgaNiXvqOg+jg0QtMlikwMMtejn0V338WGw6ZSh+/
1Nci8zyTUx35vFGwjuwfBrlhq5zXIm0qjz7gXkD4xWwKECsNT3hcoBnU0Yk2Kv9U
AhFCTEVv0Ve/HFt/DZWRHw27hZzo30j7I/Q09KhJ2WbTA+cGn5NobApZLwuT6QGh
ikic4AQ6zSCw87y3KkVjqC/owGRWFzlav6ITOg29bJOr/m+5SIy3qP0unMHE05sj
5GpNa1RMdBy6pJ3NuvknH6fhBsD9JcTEa+Kne40O/+S/ALXWWevPyg2a10yfsHy7
af8xqLb8goOThJzcEMTWwMoYbrT+RtdvlmH2VEmD+u60KBi2fVvDaUdYF7YCjpyl
Ds4NDmVrKLvVB136PPH7ccOZIR1E/asLTUx+BU+UFwrTOr9nPlcdfdQrEP9kzCGi
JD2j22IMdQldWF2YfSTxejfcT0SyN2R1yxLd2tAvbCVzFv27s/h4k1btcFJzgvBF
Xf0lI+wmU5gSFO/owCeBh4fbGdHbDcuocJW1fO/WAhbb7AHBufs=
=6BS9
-----END PGP SIGNATURE-----

--ke7rco3dau73eqdd--
