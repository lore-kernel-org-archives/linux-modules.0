Return-Path: <ikelos@gentoo.org>
Message-ID: <5490BFD6.2000504@gentoo.org>
Date: Tue, 16 Dec 2014 23:27:18 +0000
From: Mike Auty <ikelos@gentoo.org>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] build: Do not force diagnostics-color flag
References: <54810109.7030409@gentoo.org> <CAKi4VAL1C00z-pO8ODcvDD-=CfPjgpM1SMg53HsDJ6QTWQFgDQ@mail.gmail.com>
In-Reply-To: <CAKi4VAL1C00z-pO8ODcvDD-=CfPjgpM1SMg53HsDJ6QTWQFgDQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040504090808030703060000"
List-ID: <linux-modules.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040504090808030703060000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hiya,

On 16/12/14 20:46, Lucas De Marchi wrote:
> Do we really need to specify the colors ourselves? Systemd's
> commit seems to only export any value in the variable to get the
> default ones.

No, but if the data isn't important anyway, I figured we might as well
load it with the default value as something useful for anyone that
happens to read the line.  Submitting what was in the systemd patch
seemed embarrassing, but if you think it's more confusing then I'm
happy to include some bogus text of your choosing.

> I'm fine with this approach for compatibility with gcc < 4.9, but
> the patch is corrupted by your mail client. Could you send it with
> git-send-email or attach it.

Sorry about the mail client!  Attached as requested...

Mike  5:)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlSQv9YACgkQu7rWomwgFXqZ8wCgqoHf5FBMg5Q+4puOD97uoRBa
EqMAnjQOnTvmIUy8GELFPP8OT+LhtW5S
=sFB/
-----END PGP SIGNATURE-----

--------------040504090808030703060000
Content-Type: text/x-patch;
 name="0001-build-Do-not-force-diagnostics-color-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-build-Do-not-force-diagnostics-color-flag.patch"

>From f14018096ea11757ac783089837d75ef25ac5191 Mon Sep 17 00:00:00 2001
From: Mike Auty <ikelos@gentoo.org>
Date: Fri, 5 Dec 2014 00:49:13 +0000
Subject: [PATCH] build: Do not force diagnostics-color flag

The -fdiagnostics-color flag is only available on GCC >= 4.9, for
older versions this could raise an error in certain circumstances
(such as when using ccache).  Instead, since -fdiagnostic-color=auto
by default  in gcc-4.9, simply set the required environment variable
to the default one if it's undefined.

Based mostly on the systemd commit f44541bc by Michal Schmidt.
---
 Makefile.am  | 3 +++
 configure.ac | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index ea5cbac..51825f0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -11,6 +11,9 @@ BUILT_FILES =
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
 AM_MAKEFLAGS = --no-print-directory
 
+GCC_COLORS ?= 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
+export GCC_COLORS
+
 AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir)/libkmod \
diff --git a/configure.ac b/configure.ac
index 2709f08..f28bfed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -201,7 +201,6 @@ CC_CHECK_FLAGS_APPEND(with_cflags, [CFLAGS], [\
 		       -Wuninitialized \
 		       -fno-common \
 		       -fdiagnostics-show-option \
-		       -fdiagnostics-color=auto \
 		       -fvisibility=hidden \
 		       -ffunction-sections \
 		       -fdata-sections])
-- 
2.2.0


--------------040504090808030703060000
Content-Type: application/pgp-signature;
 name="0001-build-Do-not-force-diagnostics-color-flag.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-build-Do-not-force-diagnostics-color-flag.patch.sig"

iEYEABECAAYFAlSQv9YACgkQu7rWomwgFXrwZQCcCmz7lXadKexRQlmg/M7Rdzl5UQUAoIlr
/fFTLah4FPqj9arcItDmZ0yH
--------------040504090808030703060000--
