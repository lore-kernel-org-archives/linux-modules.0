Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="qjtHBDnj"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2892D3
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1701791722;
	bh=y2v9m4Gb+hGL9frbSGaWeV/RxhbFLyoAK8ncAevPAx8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=qjtHBDnjwez4ckKIr+HzFpbzVszBJpdPg4RwsRnfyRLXaUX75XUv9+FwAwWQeDOIX
	 MnI8rkXq1xWkK8Vql7gYPhi9xB+wW6oIBHZpiVQC8Qg7pPxeXcKnzZ70QQOqjHVl8E
	 ON0PJ0eDgZEteayuzjbJ1xfHlPKtVCd0IfAyxrOmTIAFImYiUzPtlPPH25Hh7LPmko
	 obaVMkCV65ZwkT10KApbIarBBGhFlS1smEGiqmX5X/EeOhehXWpYJQQ5fopKU2tRME
	 sCesPzEdF7eNEQWlBWklI/PbMTle2gRYWnOO7qcHxZbCaKBUuIRjdB2wH3sFi66nJy
	 YHdk6slwpzANg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 98CE812D96
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 16:55:22 +0100 (CET)
Date: Tue, 5 Dec 2023 16:55:22 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: linux-modules@vger.kernel.org
Subject: [PATCH kmod 2/3] Add KMOD_NEW_IGNORE_CMDLINE
Message-ID: <b666b75fa732407e7e390ba27ebacaf663e93f7d.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4qfwilojtgwxgqn"
Content-Disposition: inline
In-Reply-To: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103


--h4qfwilojtgwxgqn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This can be passed to kmod_new_flags() to disable loading configuration
=66rom /proc/cmdline

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 libkmod/libkmod-config.c   | 3 ++-
 libkmod/libkmod-internal.h | 2 +-
 libkmod/libkmod.c          | 2 +-
 libkmod/libkmod.h          | 4 +++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index e24dab1..600d666 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -949,7 +949,8 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_c=
onfig **p_config,
 		free(cf);
 	}
=20
-	kmod_config_parse_kcmdline(config);
+	if (!(options & KMOD_NEW_IGNORE_CMDLINE))
+		kmod_config_parse_kcmdline(config);
=20
 	return 0;
=20
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 26a7e28..1d0bd92 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -132,7 +132,7 @@ struct kmod_config {
 	struct kmod_list *paths;
 };
=20
-int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **config, con=
st char * const *config_paths) __attribute__((nonnull(1, 2,3)));
+int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **config, con=
st char * const *config_paths, enum kmod_new_flags options) __attribute__((=
nonnull(1, 2,3)));
 void kmod_config_free(struct kmod_config *config) __attribute__((nonnull(1=
)));
 const char *kmod_blacklist_get_modname(const struct kmod_list *l) __attrib=
ute__((nonnull(1)));
 const char *kmod_alias_get_name(const struct kmod_list *l) __attribute__((=
nonnull(1)));
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 279b35d..126a66c 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -317,7 +317,7 @@ KMOD_EXPORT struct kmod_ctx *kmod_new_flags(const char =
*dirname,
=20
 	if (config_paths =3D=3D NULL)
 		config_paths =3D default_config_paths;
-	err =3D kmod_config_new(ctx, &ctx->config, config_paths);
+	err =3D kmod_config_new(ctx, &ctx->config, config_paths, options);
 	if (err < 0) {
 		ERR(ctx, "could not create config\n");
 		goto fail;
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 72cd7a2..29637dd 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -30,7 +30,9 @@
 extern "C" {
 #endif
=20
-enum kmod_new_flags {};
+enum kmod_new_flags {
+	KMOD_NEW_IGNORE_CMDLINE =3D 0x00001,
+};
=20
 /*
  * kmod_ctx
--=20
2.39.2


--h4qfwilojtgwxgqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVvR+oACgkQvP0LAY0m
WPFtUhAAnjoIm7JyhYZGenr7DNkVrFIR9rQmAI071eCa4JRP+Mac1E5VSJu/I2IJ
joIkJWJRUHl6Bke63sZpg8AYAB9qYDkpRj3HVMgduj3MI6sDFlZaHz4Ms008osBZ
jdKMFPia8eUZZHjJlHsAPzxLEWorXh43qOnKy8MKylYliRc5M+2LjoWG8QLmbfJN
uvOy2wCRKVE4OATX4s/I9KCRB9VPxlMmpoD93otdnYZSY3s/IjJAzvY2uY1p+JtG
woOzZQF0ter6/BjEkZpLVw0qufMmjdZujkgRE+IBnNLkpaoKcDmt4DIHlDvxWvKL
/uIJ4UGIvA/PoXTRkjffF/S2TVxUsk7et6NlobkWtg+/GiWnOEeq0q6jwXaYZlJS
OoBTr/KIWOZ52ntG6zRQ+dTgBO4FYj1v+5JfRuUvxW0HFVeaOquYTSs/aweYjrJw
hd1m7RIBin1euRv4lJbMpZay3B1E9ZLoLLk5bO3vFA06FnydMoI3gp2P14bGPHbe
BjswDDlkcHesAQdBGY3VUPRxyiulpBuyHGBkfqx+j8RruJFULm35q83EsMVdTNne
XqMgNwxpmOHrJDe+H7Uvw02OE6i1gC1cM4Ww9zRV7sTY2FfDesCmXOpKUZ9MR/Qw
dVu4zK7KttGTUAL039UpYDlsNh020Xvs9hRlyx0He4Q73CE4Gkc=
=ICTw
-----END PGP SIGNATURE-----

--h4qfwilojtgwxgqn--
