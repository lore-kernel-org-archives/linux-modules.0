Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44084 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbcDEAcm (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 4 Apr 2016 20:32:42 -0400
Date: Tue, 5 Apr 2016 01:32:38 +0100
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-modules@vger.kernel.org
Cc: 820010@bugs.debian.org
Message-ID: <20160405003237.GK21187@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
In-Reply-To: <20160405001611.GJ21187@decadent.org.uk>
Subject: [PATCH v2] libkmod: Add support for detached module signatures
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Debian will not sign modules during the kernel package build, as this
conflicts with the goal of reproducible builds.  Instead, we will
generate detached signatures offline and include them in a second
package.

We could attach the signatures when building this second package or at
installation time, but that leads to duplication of all modules,
either in the archive or on users' systems.

To avoid this, add support to libkmod for concatenating modules with
detached signatures (files with the '.sig' extension) at load time.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
v2: Fix syntax error in the xz case

Missed this because I didn't realise the Debian package disables gzip
and xz support.

Ben.

 libkmod/libkmod-file.c | 110 +++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 103 insertions(+), 7 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 5eeba6a912a2..cb1da3c9e2ae 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -52,6 +52,7 @@ struct kmod_file {
 	gzFile gzf;
 #endif
 	int fd;
+	int sig_fd;
 	bool direct;
 	off_t size;
 	void *memory;
@@ -60,6 +61,37 @@ struct kmod_file {
 	struct kmod_elf *elf;
 };
=20
+static int append_detached_sig(struct kmod_file *file, size_t buf_size)
+{
+	struct stat st;
+	ssize_t read_size;
+
+	if (file->sig_fd < 0)
+		return 0;
+
+	if (fstat(file->sig_fd, &st) < 0)
+		return -errno;
+
+	/* Grow the buffer if necessary */
+	if ((size_t)st.st_size > buf_size - file->size) {
+		void *tmp =3D realloc(file->memory, file->size + st.st_size);
+		if (tmp =3D=3D NULL)
+			return -errno;
+		file->memory =3D tmp;
+	}
+
+	read_size =3D read(file->sig_fd, (char *)file->memory + file->size,
+			 st.st_size);
+	if (read_size < 0)
+		return -errno;
+	if (read_size !=3D st.st_size)
+		return -EINVAL;
+
+	file->size +=3D read_size;
+
+	return 0;
+}
+
 #ifdef ENABLE_XZ
 static void xz_uncompress_belch(struct kmod_file *file, lzma_ret ret)
 {
@@ -144,6 +176,7 @@ static int load_xz(struct kmod_file *file)
 {
 	lzma_stream strm =3D LZMA_STREAM_INIT;
 	lzma_ret lzret;
+	size_t buf_size;
 	int ret;
=20
 	lzret =3D lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
@@ -155,7 +188,14 @@ static int load_xz(struct kmod_file *file)
 		return -EINVAL;
 	}
 	ret =3D xz_uncompress(&strm, file);
+	buf_size =3D file->size + strm.avail_out;
 	lzma_end(&strm);
+
+	if (!ret) {
+		ret =3D append_detached_sig(file, buf_size);
+		if (ret)
+			free(file->memory);
+	}
 	return ret;
 }
=20
@@ -214,6 +254,11 @@ static int load_zlib(struct kmod_file *file)
=20
 	file->memory =3D p;
 	file->size =3D did;
+
+	err =3D append_detached_sig(file, total);
+	if (err)
+		goto error;
+
 	p =3D NULL;
 	return 0;
=20
@@ -254,18 +299,50 @@ static int load_reg(struct kmod_file *file)
 	if (fstat(file->fd, &st) < 0)
 		return -errno;
=20
-	file->size =3D st.st_size;
-	file->memory =3D mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
-			    file->fd, 0);
-	if (file->memory =3D=3D MAP_FAILED)
-		return -errno;
-	file->direct =3D true;
+	if (file->sig_fd < 0) {
+		file->size =3D st.st_size;
+		file->memory =3D mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
+				    file->fd, 0);
+		if (file->memory =3D=3D MAP_FAILED)
+			return -errno;
+		file->direct =3D true;
+	} else {
+		size_t plain_size =3D st.st_size, sig_size;
+		_cleanup_free_ unsigned char *p =3D NULL;
+		ssize_t ret;
+
+		if (fstat(file->sig_fd, &st) < 0)
+			return -errno;
+		sig_size =3D st.st_size;
+
+		p =3D malloc(plain_size + sig_size);
+		if (!p)
+			return -errno;
+
+		ret =3D read(file->fd, p, plain_size);
+		if (ret < 0)
+			return -errno;
+		if ((size_t)ret !=3D plain_size)
+			return -EINVAL;
+		file->memory =3D p;
+		file->size =3D plain_size;
+
+		ret =3D append_detached_sig(file, plain_size + sig_size);
+		if (ret)
+			return ret;
+
+		p =3D NULL;
+	}
+
 	return 0;
 }
=20
 static void unload_reg(struct kmod_file *file)
 {
-	munmap(file->memory, file->size);
+	if (file->direct)
+		munmap(file->memory, file->size);
+	else
+		free(file->memory);
 }
=20
 static const struct file_ops reg_ops =3D {
@@ -285,6 +362,7 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx =
*ctx,
 						const char *filename)
 {
 	struct kmod_file *file =3D calloc(1, sizeof(struct kmod_file));
+	char *sig_filename =3D NULL;
 	const struct comp_type *itr;
 	size_t magic_size_max =3D 0;
 	int err;
@@ -292,12 +370,25 @@ struct kmod_file *kmod_file_open(const struct kmod_ct=
x *ctx,
 	if (file =3D=3D NULL)
 		return NULL;
=20
+	file->sig_fd =3D -1;
+
 	file->fd =3D open(filename, O_RDONLY|O_CLOEXEC);
 	if (file->fd < 0) {
 		err =3D -errno;
 		goto error;
 	}
=20
+	/* Try to open a detached signature.  If it's missing, that's OK. */
+	if (asprintf(&sig_filename, "%s.sig", filename) < 0) {
+		err =3D -errno;
+		goto error;
+	}
+	file->sig_fd =3D open(sig_filename, O_RDONLY|O_CLOEXEC);
+	if (file->sig_fd < 0 && errno !=3D ENOENT) {
+		err =3D -errno;
+		goto error;
+	}
+
 	for (itr =3D comp_types; itr->ops.load !=3D NULL; itr++) {
 		if (magic_size_max < itr->magic_size)
 			magic_size_max =3D itr->magic_size;
@@ -336,7 +427,10 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx=
 *ctx,
 	err =3D file->ops->load(file);
 	file->ctx =3D ctx;
 error:
+	free(sig_filename);
 	if (err < 0) {
+		if (file->sig_fd >=3D 0)
+			close(file->sig_fd);
 		if (file->fd >=3D 0)
 			close(file->fd);
 		free(file);
@@ -373,6 +467,8 @@ void kmod_file_unref(struct kmod_file *file)
 		kmod_elf_unref(file->elf);
=20
 	file->ops->unload(file);
+	if (file->sig_fd >=3D 0)
+		close(file->sig_fd);
 	if (file->fd >=3D 0)
 		close(file->fd);
 	free(file);

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVwMHpee/yOyVhhEJAQobug/9FlAGQxJB7kvgXQhaOsOvhDL63BIc5okM
/uC8/Z68A6zlCpvUvYljclHhiGzZaCnOKVjI2u6XkFzkS5/RVnrfCcezlCTiHTI5
Q57Fgzy/lqm7flETTLnfh/go7iHFWLkI29GCS6SbEFAF0xBw93Tk52lC8XR74sEa
vqtPC1VGDGZirt75QTd7DLc8QqjW52klqAhcrNQUt46yd1iG3pxrnla55GwZLkqO
6etU7ZJ6IB3KJSczgU4BhBSl5yPpApw4zZ+v34xL+EraloGQoccmVZ8gmr2kDOkG
mGt07NcVxCQr5wPem//NaWi7icejn/nINB4j9G9AB39NpUo7YCvoztghSTVACB1P
WGwvN6dRF7/6xbjgs+DOPHDXWi59dM/0vN5vxGhz9KaqmKxZCgZ4QvdLgSnzJmuZ
+DwxTUZe46V6/XGQ8Wndn1Qspy3An4OwDPutZL9csG+1d7m3MXhoBb68NwThyzZB
g+gV4sgmlZGobAaI01+fY1viCaZwuTJZKR0xwztfYi2pHoPihymFgsrXOv3vmwan
ElpB9fTor37tSaAxaqgTKmFWszy00sfatMvyidgNHC8oG1nnhO2CGb/puOWuy/gK
OUeAb8P2qH2Ye/5JVlAbXB2IGin6li6iV0QXQ3qQco8FVhEKWYNMmtSuhX6FMjpQ
qfwwURPzPv0=
=7LxB
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
