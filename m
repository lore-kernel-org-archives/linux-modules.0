Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="ao58zSRF"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA3C0
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1701791717;
	bh=oH9HcEz06pE1YDpakXuFl0/U/9LMPB8uZ/ovRfW7Z3o=;
	h=Date:From:To:Subject:From;
	b=ao58zSRFijlnDlTUAFAL257MWdZEhP2No83bSA/Xs4fyIhOndsg4qb9wqz1mEITOr
	 gMkLkxd2nYN9vfXx+0/fZdq1j0f+zg28ifB72/bs8r30LHLobaMUp83MQ1cy4Ndolf
	 BmtnD0XMMjk7iMQLD1hb0YStEQherY+TIL8jslmaBctzW/oh6BsW2T/Zn5b4IHT/TE
	 ePq3a6sURGJYLV7IhZxZDh+DdDW6WR1JqORBlsiJjMQCwczLCqG7VHh25D/4pxL+Oq
	 k/4DjQ5etwQ+GFPTlfPYSPekXFNRRLzvLIwi2GtQcu/W8QzIU8aQac55YLpbUz5xEq
	 tGO2cadvU3/Zg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6229F129CE
	for <linux-modules@vger.kernel.org>; Tue,  5 Dec 2023 16:55:17 +0100 (CET)
Date: Tue, 5 Dec 2023 16:55:17 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: linux-modules@vger.kernel.org
Subject: [PATCH kmod 1/3] Add kmod_new_flags() variant of kmod_new(), with
 abiver 32
Message-ID: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35niqvkpz32klja6"
Content-Disposition: inline
User-Agent: NeoMutt/20231103


--35niqvkpz32klja6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

kmod_new() is just kmod_new_flags(..., 0)

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Series based on the kmod-31 tarball.

 libkmod/libkmod-config.c | 3 ++-
 libkmod/libkmod.c        | 6 ++++++
 libkmod/libkmod.h        | 3 +++
 libkmod/libkmod.sym      | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index e83621b..e24dab1 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -881,7 +881,8 @@ static int conf_files_list(struct kmod_ctx *ctx, struct=
 kmod_list **list,
 }
=20
 int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
-					const char * const *config_paths)
+					const char * const *config_paths,
+					enum kmod_new_flags options)
 {
 	struct kmod_config *config;
 	struct kmod_list *list =3D NULL;
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 1b8773c..279b35d 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -286,6 +286,12 @@ static enum kmod_file_compression_type get_kernel_comp=
ression(struct kmod_ctx *c
  */
 KMOD_EXPORT struct kmod_ctx *kmod_new(const char *dirname,
 					const char * const *config_paths)
+{
+	return kmod_new_flags(dirname, config_paths, 0);
+}
+KMOD_EXPORT struct kmod_ctx *kmod_new_flags(const char *dirname,
+					const char * const *config_paths,
+					enum kmod_new_flags options)
 {
 	const char *env;
 	struct kmod_ctx *ctx;
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 7251aa7..72cd7a2 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -30,6 +30,8 @@
 extern "C" {
 #endif
=20
+enum kmod_new_flags {};
+
 /*
  * kmod_ctx
  *
@@ -38,6 +40,7 @@ extern "C" {
  */
 struct kmod_ctx;
 struct kmod_ctx *kmod_new(const char *dirname, const char * const *config_=
paths);
+struct kmod_ctx *kmod_new_flags(const char *dirname, const char * const *c=
onfig_paths, enum kmod_new_flags options);
 struct kmod_ctx *kmod_ref(struct kmod_ctx *ctx);
 struct kmod_ctx *kmod_unref(struct kmod_ctx *ctx);
 void kmod_set_log_fn(struct kmod_ctx *ctx,
diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 0c04fda..bd602ca 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -92,3 +92,8 @@ LIBKMOD_22 {
 global:
 	kmod_get_dirname;
 } LIBKMOD_6;
+
+LIBKMOD_32 {
+global:
+	kmod_new_flags;
+} LIBKMOD_22;
--=20
2.39.2


--35niqvkpz32klja6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVvR+QACgkQvP0LAY0m
WPE2kA//W8ebloOcuqfktXyvyAzi3PmMxPZihD8RkjI1tSo6YiFLSHNa7HeKEBjv
Ml8p1nbkumLJIKZR5S8X+1XuzlNNCfUetizVHb2/LGr9dxKtjLUD9TpRQLnmxYX2
tC4LtYDyyqWRC7ThclEUZzEtXtru/6PpBRMIaeNPHyNeSxKXE7o+pJ0Iy63HR1yj
6LtnOFPsG3YF23twcHT/qI+M0rkSFuWsx6afuPL1DfnXOL8pfDIDoBsWYHOwblN4
weAdVX16Tnf4Zn7QvrgnO2Tftuc5CfUi9oAtI0HOn3if3/ewVzcbE+0KBn9zrVI7
LKBDFXaC+/SZDNEW7yxG7+n6afbbwY9nwYUAM22kfe4A09H+3ecIKyywa2qLo12y
UKbQK+iL0dMcHvxp3MN9QlFLwbgUe/y7LeFsfLK0fu1qnvhgELD7zpXGSKGqjPfc
rzNWWmWsrHyXNHsQdzF9czSBW7QGwb1h85upnxpUyUsWWdts23ItGnAM9Ibn+as/
zKNL+Btkne35XTgHgTa03/9R2ijwEYqHaZlelsaYprQqsR4z9wg+y2YkYTPjeZe/
2KajHGLYJ5F+fMG6VQJjYm7tzOV+CTrwDWXmdzWi3zVCAW0CZ0IVb8KJSOHwVeWH
HdLYkwU2W/FNg5sr2EgeOlcBC5xHckSYlxKBupBz2KRyByxLR/k=
=t7Ib
-----END PGP SIGNATURE-----

--35niqvkpz32klja6--
