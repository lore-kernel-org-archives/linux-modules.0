Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF8315E5AB
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900916; cv=none; b=X5ZNi6zjSRvjf4XyG3XGjpNaUC9Hl1GrvRuimXNuSuHFZMLkSr/pwcR3MSfMS4nXdc/beOpOmQ65nECKq7LZFqzZGfhQlZJXvOuee3oiZYWhoyq6kkb2VBT6DMJ85XbzzkL+HF3KcNfyUrk4k6DGRxkaWJcbcnM1lGneJHGga0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900916; c=relaxed/simple;
	bh=SsVdAxnLd8/c6siasL80E0Zr0avk5roWCp4Y0hkZ6JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LThV89KzUU3H/hUkw/mR1UySAtxDE/irDChvWotL84R/iBsN1FqflanMEzEZ4ppxcipp48p0OhphcMa0TUvcB78YOWYHePbR4sjv+CLnSNw9zs5px4tuaXHTA6uVH6KQkWs8Fhjz895apzT9K4kRKliU/NIDXubB+02fLjVBnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVVY44q/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVVY44q/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68c66c6a234so13219816d6.2
        for <linux-modules@vger.kernel.org>; Fri, 02 Feb 2024 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900912; x=1707505712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OVD03l+5bsTYy3QGv2QhBG7WeXOQTmhSNf+MuHTpcM=;
        b=QVVY44q/gr5dTJEjjPTSit41lvV3BwSJXE0gSVE6cNqj5+c/UVzRhIPlQ2miRXmwP1
         lFBGTG3mVYJn+uGAGFi6tAiS4WZn8WOaWtTFN0RpW8oVgHehZpRIUmydOV5ifFB5uXG9
         iNEFYb4MYi3uvrLvyGCERTQFsjeNyiHCx8N9veyToXMJMfK94WIi5VL0HWITlK10+K0f
         H2GX6ZKFH+OD3I6xAbgKdsBBIXG9JtEcg/NPXZDSKx/7EbrQhp+qf4n7XrIVQpFJxmgQ
         gwWpTQ7+w3wP8QqQl+6W4vwp2cnnFPcQSoJefg1hg7Qt0Am24Y1IBPFYNWDY4HSiPbSV
         5g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900912; x=1707505712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OVD03l+5bsTYy3QGv2QhBG7WeXOQTmhSNf+MuHTpcM=;
        b=gQ3th6dNKLCQ5QbyKIN631Lln0leIbHwQGm9KIXm9Ct4zCN6fck7SuDBrdTyidwZq8
         6rfGA1G6jqsg1HyvT/t1Kb0eyUHlKLJgMZgDOYUR0oeJOvRU9GJWv1Odd38r+TDKxd8D
         DPOY+EnaRM5x8XrOdyxnlvn/cSMsDTDvEzR0kahvALMpxgcdQxl63QXv8SEIk8dh4SL/
         NbOXr9yPYAsvwq+k5uGlUBILCjf2VKCOxZ/rqo6epOYMz8MU6MQAoil1UDEMi6NP4fEh
         TijKnBRqSCo18ZybtdU+zoW+W1VXRxN5wD5XCoQCp31AJ2RSpv5eMKkmTpMiKXedEDC6
         MmGw==
X-Gm-Message-State: AOJu0YyQuzxxAvQvrAgqlm9nz/CdUV5QzVwE8soLJgCo9Pbi7gp9cI4N
	MNWar2NZjExiT84m0lNwH4sSqFu1Tz7gccC5YK4NZbxKPRoVpNooF3tc8izD
X-Google-Smtp-Source: AGHT+IFJ2hj84CUkU3c0tnlqhR0d5CKjlT2PLHwPl6psQshF+0EjnzfHO4rKkYLAsNLJT27F0Bgk8w==
X-Received: by 2002:a05:6214:f67:b0:68c:75e8:b8cb with SMTP id iy7-20020a0562140f6700b0068c75e8b8cbmr11007525qvb.29.1706900912162;
        Fri, 02 Feb 2024 11:08:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyJG6lnnOfhzUGPcmSAclFSTX9oZcSgpGdZ+neqgf6SffoBSnGxzIMr3ViEtvcgYv038Km9z3VNpBJAcjGrP4iDCRC8R1oRvg=
Received: from ldmartin-desk2.lan ([192.55.54.51])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a15a400b0078408de98e6sm903011qkk.72.2024.02.02.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:31 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/4] Drop python bindings
Date: Fri,  2 Feb 2024 13:08:20 -0600
Message-ID: <20240202190823.418148-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Python bindings are not well maintained. Currently it's just broken when
trying to build with cython 3.0.8:

	make --no-print-directory all-recursive
	Making all in .
	  CYTHON  libkmod/python/kmod/kmod.c

	Error compiling Cython file:
	------------------------------------------------------------
	...
	# details.
	#
	# You should have received a copy of the GNU Lesser General Public License
	# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.

	cimport _libkmod_h
		^

Nothing really touched those bindings for 10 years already.
I postponed the removal since they were at least building, but that just
changed. So let's drop it and allow any interested people to give it
a better life outside of libkmod.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .travis.yml                        |   1 -
 Makefile.am                        |  72 +------------
 README.md                          |   3 +-
 autogen.sh                         |   1 -
 configure.ac                       |  20 ----
 libkmod/python/.gitignore          |   6 --
 libkmod/python/README              |  23 -----
 libkmod/python/kmod/__init__.py    |  24 -----
 libkmod/python/kmod/_libkmod_h.pxd | 113 ---------------------
 libkmod/python/kmod/_util.pxd      |  20 ----
 libkmod/python/kmod/_util.pyx      |  28 -----
 libkmod/python/kmod/error.py       |  18 ----
 libkmod/python/kmod/kmod.pxd       |  22 ----
 libkmod/python/kmod/kmod.pyx       | 125 -----------------------
 libkmod/python/kmod/list.pxd       |  25 -----
 libkmod/python/kmod/list.pyx       |  45 --------
 libkmod/python/kmod/module.pxd     |  24 -----
 libkmod/python/kmod/module.pyx     | 158 -----------------------------
 libkmod/python/kmod/version.py.in  |  17 ----
 testsuite/mkosi/mkosi.build        |   2 +-
 20 files changed, 4 insertions(+), 743 deletions(-)
 delete mode 100644 libkmod/python/.gitignore
 delete mode 100644 libkmod/python/README
 delete mode 100644 libkmod/python/kmod/__init__.py
 delete mode 100644 libkmod/python/kmod/_libkmod_h.pxd
 delete mode 100644 libkmod/python/kmod/_util.pxd
 delete mode 100644 libkmod/python/kmod/_util.pyx
 delete mode 100644 libkmod/python/kmod/error.py
 delete mode 100644 libkmod/python/kmod/kmod.pxd
 delete mode 100644 libkmod/python/kmod/kmod.pyx
 delete mode 100644 libkmod/python/kmod/list.pxd
 delete mode 100644 libkmod/python/kmod/list.pyx
 delete mode 100644 libkmod/python/kmod/module.pxd
 delete mode 100644 libkmod/python/kmod/module.pyx
 delete mode 100644 libkmod/python/kmod/version.py.in

diff --git a/.travis.yml b/.travis.yml
index 2adb3c6..64dd6cd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -18,7 +18,6 @@ before_install:
   - sudo apt-get install -qq linux-headers-generic
 
 before_script:
-  - unset PYTHON_CFLAGS # hack to broken travis setup
   - export KDIR="$(find  /lib/modules/* -maxdepth  1 -name build | sort -n --reverse | head -1)"
 
 script:
diff --git a/Makefile.am b/Makefile.am
index 4062d81..59dcaaf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -144,74 +144,6 @@ ${noinst_SCRIPTS}: tools/kmod
 		$(LN_S) $(notdir $<) $@)
 endif
 
-# ------------------------------------------------------------------------------
-# PYTHON BINDINGS
-# ------------------------------------------------------------------------------
-
-CYTHON_FLAGS_VERBOSE_ =
-CYTHON_FLAGS_VERBOSE_0 =
-CYTHON_FLAGS_VERBOSE_1 = -v
-CYTHON_FLAGS = $(CYTHON_FLAGS_VERBOSE_$(V))
-AM_V_CYTHON = $(am__v_CYTHON_$(V))
-am__v_CYTHON_ = $(am__v_CYTHON_$(AM_DEFAULT_VERBOSITY))
-am__v_CYTHON_0 = @echo "  CYTHON " $@;
-
-.pyx.c:
-	$(AM_V_CYTHON)$(CYTHON) -o $@ $<
-
-# Remove some warnings for generated code
-PYTHON_NOWARN = -Wno-redundant-decls -Wno-shadow -Wno-strict-aliasing
-
-CPYTHON_MODULE_CFLAGS = \
-	$(AM_CFLAGS) -DCPYTHON_COMPILING_IN_PYPY=0 \
-	$(PYTHON_NOWARN) $(PYTHON_CFLAGS) \
-	-fvisibility=default
-# Filter -Wl,--no-undefined to fix build with python 3.8
-comma = ,
-CPYTHON_MODULE_LDFLAGS = $(subst -Wl$(comma)--no-undefined,,$(AM_LDFLAGS))
-CPYTHON_MODULE_LDFLAGS += -module -avoid-version -shared
-
-if BUILD_PYTHON
-pkgpyexec_LTLIBRARIES = \
-	libkmod/python/kmod/kmod.la \
-	libkmod/python/kmod/list.la \
-	libkmod/python/kmod/module.la \
-	libkmod/python/kmod/_util.la
-
-libkmod_python_kmod_kmod_la_SOURCES = libkmod/python/kmod/kmod.c
-libkmod_python_kmod_kmod_la_CFLAGS = $(CPYTHON_MODULE_CFLAGS)
-libkmod_python_kmod_kmod_la_LDFLAGS = $(CPYTHON_MODULE_LDFLAGS)
-libkmod_python_kmod_kmod_la_LIBADD = $(PYTHON_LIBS) libkmod/libkmod.la
-
-libkmod_python_kmod_list_la_SOURCES = libkmod/python/kmod/list.c
-libkmod_python_kmod_list_la_CFLAGS = $(CPYTHON_MODULE_CFLAGS)
-libkmod_python_kmod_list_la_LDFLAGS = $(CPYTHON_MODULE_LDFLAGS)
-libkmod_python_kmod_list_la_LIBADD = $(PYTHON_LIBS) libkmod/libkmod.la
-
-libkmod_python_kmod_module_la_SOURCES = libkmod/python/kmod/module.c
-libkmod_python_kmod_module_la_CFLAGS = $(CPYTHON_MODULE_CFLAGS)
-libkmod_python_kmod_module_la_LDFLAGS = $(CPYTHON_MODULE_LDFLAGS)
-libkmod_python_kmod_module_la_LIBADD = $(PYTHON_LIBS) libkmod/libkmod.la
-
-libkmod_python_kmod__util_la_SOURCES = libkmod/python/kmod/_util.c
-libkmod_python_kmod__util_la_CFLAGS = $(CPYTHON_MODULE_CFLAGS)
-libkmod_python_kmod__util_la_LDFLAGS = $(CPYTHON_MODULE_LDFLAGS)
-libkmod_python_kmod__util_la_LIBADD = $(PYTHON_LIBS) libkmod/libkmod.la
-
-BUILT_FILES += \
-	$(libkmod_python_kmod_kmod_la_SOURCES) \
-	$(libkmod_python_kmod_list_la_SOURCES) \
-	$(libkmod_python_kmod_module_la_SOURCES) \
-	$(libkmod_python_kmod__util_la_SOURCES)
-
-dist_pkgpyexec_PYTHON = \
-	libkmod/python/kmod/error.py \
-	libkmod/python/kmod/__init__.py \
-	libkmod/python/kmod/version.py
-
-BUILT_FILES += libkmod/python/kmod/version.py
-
-endif
 # ------------------------------------------------------------------------------
 # TESTSUITE
 # ------------------------------------------------------------------------------
@@ -391,7 +323,7 @@ testsuite-distclean:
 DISTCLEAN_LOCAL_HOOKS += testsuite-distclean
 EXTRA_DIST += testsuite/rootfs-pristine
 
-DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --enable-python --sysconfdir=/etc \
+DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --sysconfdir=/etc \
 	--with-zlib --with-zstd --with-openssl \
 	--with-bashcompletiondir=$$dc_install_base/$(bashcompletiondir)
 
@@ -445,7 +377,7 @@ endif
 
 kmod-coverity-%.tar.xz:
 	rm -rf $< cov-int
-	./autogen.sh c --disable-python --disable-manpages
+	./autogen.sh c --disable-manpages
 	make clean
 	cov-build --dir cov-int make -j 4
 	tar caf $@ cov-int
diff --git a/README.md b/README.md
index 590c8a8..9b22bd7 100644
--- a/README.md
+++ b/README.md
@@ -67,8 +67,7 @@ Hacking
 =======
 
 Run 'autogen.sh' script before configure. If you want to accept the recommended
-flags, you just need to run 'autogen.sh c'. Note that the recommended
-flags require cython be installed to compile successfully.
+flags, you just need to run 'autogen.sh c'.
 
 Make sure to read the CODING-STYLE file and the other READMEs: libkmod/README
 and testsuite/README.
diff --git a/autogen.sh b/autogen.sh
index 2616247..a7a6022 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -33,7 +33,6 @@ cd $oldpwd
 
 hackargs="\
 --enable-debug \
---enable-python \
 --with-zstd \
 --with-xz \
 --with-zlib \
diff --git a/configure.ac b/configure.ac
index de01e08..372819d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -214,24 +214,6 @@ AS_IF([test "x$enable_debug" = "xyes"], [
 	AC_DEFINE(ENABLE_DEBUG, [1], [Debug messages.])
 ])
 
-AC_ARG_ENABLE([python],
-	AS_HELP_STRING([--enable-python], [enable Python libkmod bindings @<:@default=disabled@:>@]),
-	[], [enable_python=no])
-AS_IF([test "x$enable_python" = "xyes"], [
-	AM_PATH_PYTHON(,,[:])
-	AC_PATH_PROG([CYTHON], [cython], [:])
-
-	PKG_CHECK_MODULES([PYTHON], [python-${PYTHON_VERSION}],
-			  [have_python=yes],
-			  [PKG_CHECK_MODULES([PYTHON], [python],
-					     [have_python=yes],
-					     [have_python=no])])
-
-	AS_IF([test "x$have_python" = xno],
-	      [AC_MSG_ERROR([*** python support requested but libraries not found])])
-])
-AM_CONDITIONAL([BUILD_PYTHON], [test "x$enable_python" = "xyes"])
-
 AC_ARG_ENABLE([coverage],
 	AS_HELP_STRING([--enable-coverage], [enable test coverage @<:@default=disabled@:>@]),
 	[], [enable_coverage=no])
@@ -330,7 +312,6 @@ AC_CONFIG_FILES([
 	libkmod/docs/Makefile
 	libkmod/docs/version.xml
 	libkmod/libkmod.pc
-	libkmod/python/kmod/version.py
 	tools/kmod.pc
 ])
 
@@ -358,7 +339,6 @@ AC_MSG_RESULT([
 
 	experimental features:  ${enable_experimental}
 	tools:			${enable_tools}
-	python bindings:	${enable_python}
 	logging:		${enable_logging}
 	compression:		zstd=${with_zstd}  xz=${with_xz}  zlib=${with_zlib}
 	debug:			${enable_debug}
diff --git a/libkmod/python/.gitignore b/libkmod/python/.gitignore
deleted file mode 100644
index 69af451..0000000
--- a/libkmod/python/.gitignore
+++ /dev/null
@@ -1,6 +0,0 @@
-__pycache__
-dist
-*.c
-*.pyc
-*.so
-kmod/version.py
diff --git a/libkmod/python/README b/libkmod/python/README
deleted file mode 100644
index 75c2636..0000000
--- a/libkmod/python/README
+++ /dev/null
@@ -1,23 +0,0 @@
-python-kmod
-===========
-
-Python bindings for kmod/libkmod
-
-python-kmod is a Python wrapper module for libkmod, exposing common
-module operations: listing installed modules, modprobe, and rmmod.
-It is at:
-
-Example (python invoked as root)
---------------------------------
-
-::
-
-  >>> import kmod
-  >>> km = kmod.Kmod()
-  >>> [(m.name, m.size) for m in km.loaded()]
-  [(u'nfs', 407706),
-   (u'nfs_acl', 12741)
-   ...
-   (u'virtio_blk', 17549)]
-  >>> km.modprobe("btrfs")
-  >>> km.rmmod("btrfs")
diff --git a/libkmod/python/kmod/__init__.py b/libkmod/python/kmod/__init__.py
deleted file mode 100644
index 0d79787..0000000
--- a/libkmod/python/kmod/__init__.py
+++ /dev/null
@@ -1,24 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-"Libkmod -- Python interface to kmod API."
-
-from .version import __version__
-try:
-    from .kmod import Kmod
-except ImportError:
-    # this is a non-Linux platform
-    pass
diff --git a/libkmod/python/kmod/_libkmod_h.pxd b/libkmod/python/kmod/_libkmod_h.pxd
deleted file mode 100644
index 7191953..0000000
--- a/libkmod/python/kmod/_libkmod_h.pxd
+++ /dev/null
@@ -1,113 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport libc.stdint as _stdint
-
-
-cdef extern from *:
-    ctypedef char* const_char_ptr 'const char *'
-    ctypedef char* const_char_const_ptr 'const char const *'
-    ctypedef void* const_void_ptr 'const void *'
-
-
-cdef extern from 'stdbool.h':
-    ctypedef struct bool:
-        pass
-
-
-cdef extern from 'libkmod/libkmod.h':
-    # library user context - reads the config and system
-    # environment, user variables, allows custom logging
-    cdef struct kmod_ctx:
-        pass
-
-    kmod_ctx *kmod_new(
-        const_char_ptr dirname, const_char_const_ptr config_paths)
-    kmod_ctx *kmod_ref(kmod_ctx *ctx)
-    kmod_ctx *kmod_unref(kmod_ctx *ctx)
-
-    # Management of libkmod's resources
-    int kmod_load_resources(kmod_ctx *ctx)
-    void kmod_unload_resources(kmod_ctx *ctx)
-
-    # access to kmod generated lists
-    cdef struct kmod_list:
-        pass
-    ctypedef kmod_list* const_kmod_list_ptr 'const struct kmod_list *'
-    kmod_list *kmod_list_next(
-        const_kmod_list_ptr list, const_kmod_list_ptr curr)
-    kmod_list *kmod_list_prev(
-        const_kmod_list_ptr list, const_kmod_list_ptr curr)
-    kmod_list *kmod_list_last(const_kmod_list_ptr list)
-
-    # Operate on kernel modules
-    cdef struct kmod_module:
-        pass
-    ctypedef kmod_module* const_kmod_module_ptr 'const struct kmod_module *'
-    int kmod_module_new_from_name(
-        kmod_ctx *ctx, const_char_ptr name, kmod_module **mod)
-    int kmod_module_new_from_lookup(
-        kmod_ctx *ctx, const_char_ptr given_alias, kmod_list **list)
-    int kmod_module_new_from_loaded(kmod_ctx *ctx, kmod_list **list)
-
-    kmod_module *kmod_module_ref(kmod_module *mod)
-    kmod_module *kmod_module_unref(kmod_module *mod)
-    int kmod_module_unref_list(kmod_list *list)
-    kmod_module *kmod_module_get_module(kmod_list *entry)
-
-    # Flags to kmod_module_probe_insert_module
-    # codes below can be used in return value, too
-    enum: KMOD_PROBE_APPLY_BLACKLIST
-
-    #ctypedef int (*install_callback_t)(
-    #    kmod_module *m, const_char_ptr cmdline, const_void_ptr data)
-    #ctypedef void (*print_action_callback_t)(
-    #    kmod_module *m, bool install, const_char_ptr options)
-
-    int kmod_module_remove_module(
-        kmod_module *mod, unsigned int flags)
-    int kmod_module_insert_module(
-        kmod_module *mod, unsigned int flags, const_char_ptr options)
-    int kmod_module_probe_insert_module(
-        kmod_module *mod, unsigned int flags, const_char_ptr extra_options,
-        int (*run_install)(
-            kmod_module *m, const_char_ptr cmdline, void *data),
-        const_void_ptr data,
-        void (*print_action)(
-            kmod_module *m, bool install, const_char_ptr options),
-        )
-
-    const_char_ptr kmod_module_get_name(const_kmod_module_ptr mod)
-    const_char_ptr kmod_module_get_path(const_kmod_module_ptr mod)
-    const_char_ptr kmod_module_get_options(const_kmod_module_ptr mod)
-    const_char_ptr kmod_module_get_install_commands(const_kmod_module_ptr mod)
-    const_char_ptr kmod_module_get_remove_commands(const_kmod_module_ptr mod)
-
-    # Information regarding "live information" from module's state, as
-    # returned by kernel
-    int kmod_module_get_refcnt(const_kmod_module_ptr mod)
-    long kmod_module_get_size(const_kmod_module_ptr mod)
-
-    # Information retrieved from ELF headers and section
-    int kmod_module_get_info(const_kmod_module_ptr mod, kmod_list **list)
-    const_char_ptr kmod_module_info_get_key(const_kmod_list_ptr entry)
-    const_char_ptr kmod_module_info_get_value(const_kmod_list_ptr entry)
-    void kmod_module_info_free_list(kmod_list *list)
-
-    int kmod_module_get_versions(const_kmod_module_ptr mod, kmod_list **list)
-    const_char_ptr kmod_module_version_get_symbol(const_kmod_list_ptr entry)
-    _stdint.uint64_t kmod_module_version_get_crc(const_kmod_list_ptr entry)
-    void kmod_module_versions_free_list(kmod_list *list)
diff --git a/libkmod/python/kmod/_util.pxd b/libkmod/python/kmod/_util.pxd
deleted file mode 100644
index 80cbb28..0000000
--- a/libkmod/python/kmod/_util.pxd
+++ /dev/null
@@ -1,20 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport _libkmod_h
-
-
-cdef object char_ptr_to_str(_libkmod_h.const_char_ptr bytes)
diff --git a/libkmod/python/kmod/_util.pyx b/libkmod/python/kmod/_util.pyx
deleted file mode 100644
index 39eec3a..0000000
--- a/libkmod/python/kmod/_util.pyx
+++ /dev/null
@@ -1,28 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-import sys as _sys
-
-cimport _libkmod_h
-
-
-cdef object char_ptr_to_str(_libkmod_h.const_char_ptr char_ptr):
-    if char_ptr is NULL:
-        return None
-    if _sys.version_info >= (3,):  # Python 3
-        return str(char_ptr, 'ascii')
-    # Python 2
-    return unicode(char_ptr, 'ascii')
diff --git a/libkmod/python/kmod/error.py b/libkmod/python/kmod/error.py
deleted file mode 100644
index 123f4ce..0000000
--- a/libkmod/python/kmod/error.py
+++ /dev/null
@@ -1,18 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-class KmodError (Exception):
-    pass
diff --git a/libkmod/python/kmod/kmod.pxd b/libkmod/python/kmod/kmod.pxd
deleted file mode 100644
index 7805d71..0000000
--- a/libkmod/python/kmod/kmod.pxd
+++ /dev/null
@@ -1,22 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport _libkmod_h
-
-
-cdef class Kmod (object):
-    cdef _libkmod_h.kmod_ctx *_kmod_ctx
-    cdef object mod_dir
diff --git a/libkmod/python/kmod/kmod.pyx b/libkmod/python/kmod/kmod.pyx
deleted file mode 100644
index 3e73a1c..0000000
--- a/libkmod/python/kmod/kmod.pyx
+++ /dev/null
@@ -1,125 +0,0 @@
-# Copyright (C) 2012 Red Hat, Inc.
-#                    W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-"Define the Kmod class"
-
-cimport cython as _cython
-cimport _libkmod_h
-from error import KmodError as _KmodError
-cimport module as _module
-import module as _module
-cimport list as _list
-import list as _list
-
-
-cdef class Kmod (object):
-    "Wrap a struct kmod_ctx* item"
-    def __cinit__(self):
-        self._kmod_ctx = NULL
-        self.mod_dir = None
-
-    def __dealloc__(self):
-        self._cleanup()
-
-    def __init__(self, mod_dir=None):
-        self.set_mod_dir(mod_dir=mod_dir)
-
-    def set_mod_dir(self, mod_dir=None):
-        self.mod_dir = mod_dir
-        self._setup()
-
-    def _setup(self):
-        cdef char *mod_dir = NULL
-        self._cleanup()
-        if self.mod_dir:
-            mod_dir = self.mod_dir
-        self._kmod_ctx = _libkmod_h.kmod_new(mod_dir, NULL);
-        if self._kmod_ctx is NULL:
-            raise _KmodError('Could not initialize')
-        _libkmod_h.kmod_load_resources(self._kmod_ctx)
-
-    def _cleanup(self):
-        if self._kmod_ctx is not NULL:
-            _libkmod_h.kmod_unload_resources(self._kmod_ctx);
-            self._kmod_ctx = NULL
-
-    def loaded(self):
-        "iterate through currently loaded modules"
-        cdef _list.ModList ml = _list.ModList()
-        cdef _list.ModListItem mli
-        err = _libkmod_h.kmod_module_new_from_loaded(self._kmod_ctx, &ml.list)
-        if err < 0:
-            raise _KmodError('Could not get loaded modules')
-        for item in ml:
-            mli = <_list.ModListItem> item
-            mod = _module.Module()
-            mod.from_mod_list_item(item)
-            yield mod
-
-    def lookup(self, alias_name, flags=_libkmod_h.KMOD_PROBE_APPLY_BLACKLIST):
-        "iterate through modules matching `alias_name`"
-        cdef _list.ModList ml = _list.ModList()
-        cdef _list.ModListItem mli
-        if hasattr(alias_name, 'encode'):
-            alias_name = alias_name.encode('ascii')
-        err = _libkmod_h.kmod_module_new_from_lookup(
-            self._kmod_ctx, alias_name, &ml.list)
-        if err < 0:
-            raise _KmodError('Could not modprobe')
-        for item in ml:
-            mli = <_list.ModListItem> item
-            mod = _module.Module()
-            mod.from_mod_list_item(item)
-            yield mod
-
-    @_cython.always_allow_keywords(True)
-    def module_from_name(self, name):
-        cdef _module.Module mod = _module.Module()
-        if hasattr(name, 'encode'):
-            name = name.encode('ascii')
-        err = _libkmod_h.kmod_module_new_from_name(
-            self._kmod_ctx, name, &mod.module)
-        if err < 0:
-            raise _KmodError('Could not get module')
-        return mod
-
-    def list(self):
-        "iterate through currently loaded modules and sizes"
-        for mod in self.loaded():
-            yield (mod.name, mod.size)
-
-    def modprobe(self, name, quiet=False, *args, **kwargs):
-        """
-        Load a module (or alias) and all modules on which it depends.
-        The 'quiet' option defaults to False; set to True to mimic the behavior
-        of the '--quiet' commandline option.
-        """
-        mods = list(self.lookup(alias_name=name))
-
-        if not mods and not quiet:
-            raise _KmodError('Could not modprobe %s' % name)
-
-        for mod in mods:
-            mod.insert(*args, **kwargs)
-
-    def rmmod(self, module_name, *args, **kwargs):
-       """
-       remove module from current tree
-       e.g. km.rmmod("thinkpad_acpi")
-       """
-       mod = self.module_from_name(name=module_name)
-       mod.remove(*args, **kwargs)
diff --git a/libkmod/python/kmod/list.pxd b/libkmod/python/kmod/list.pxd
deleted file mode 100644
index 8e5b388..0000000
--- a/libkmod/python/kmod/list.pxd
+++ /dev/null
@@ -1,25 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport _libkmod_h
-
-
-cdef class ModListItem (object):
-    cdef _libkmod_h.kmod_list *list
-
-
-cdef class ModList (ModListItem):
-    cdef _libkmod_h.kmod_list *_next
diff --git a/libkmod/python/kmod/list.pyx b/libkmod/python/kmod/list.pyx
deleted file mode 100644
index ef0e0d4..0000000
--- a/libkmod/python/kmod/list.pyx
+++ /dev/null
@@ -1,45 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport _libkmod_h
-
-
-cdef class ModListItem (object):
-    "Wrap a struct kmod_list* list item"
-    def __cinit__(self):
-        self.list = NULL
-
-
-cdef class ModList (ModListItem):
-    "Wrap a struct kmod_list* list with iteration"
-    def __cinit__(self):
-        self._next = NULL
-
-    def __dealloc__(self):
-        if self.list is not NULL:
-            _libkmod_h.kmod_module_unref_list(self.list)
-
-    def __iter__(self):
-        self._next = self.list
-        return self
-
-    def __next__(self):
-        if self._next is NULL:
-            raise StopIteration()
-        mli = ModListItem()
-        mli.list = self._next
-        self._next = _libkmod_h.kmod_list_next(self.list, self._next)
-        return mli
diff --git a/libkmod/python/kmod/module.pxd b/libkmod/python/kmod/module.pxd
deleted file mode 100644
index c7d7da4..0000000
--- a/libkmod/python/kmod/module.pxd
+++ /dev/null
@@ -1,24 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-cimport _libkmod_h
-cimport list as _list
-
-
-cdef class Module (object):
-    cdef _libkmod_h.kmod_module *module
-
-    cpdef from_mod_list_item(self, _list.ModListItem item)
diff --git a/libkmod/python/kmod/module.pyx b/libkmod/python/kmod/module.pyx
deleted file mode 100644
index 42aa92e..0000000
--- a/libkmod/python/kmod/module.pyx
+++ /dev/null
@@ -1,158 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-import collections as _collections
-
-cimport libc.errno as _errno
-
-cimport _libkmod_h
-from error import KmodError as _KmodError
-cimport list as _list
-import list as _list
-cimport _util
-import _util
-
-
-cdef class Module (object):
-    "Wrap a struct kmod_module* item"
-    def __cinit__(self):
-        self.module = NULL
-
-    def __dealloc__(self):
-        self._cleanup()
-
-    def _cleanup(self):
-        if self.module is not NULL:
-            _libkmod_h.kmod_module_unref(self.module)
-            self.module = NULL
-
-    cpdef from_mod_list_item(self, _list.ModListItem item):
-        self._cleanup()
-        self.module = _libkmod_h.kmod_module_get_module(item.list)
-
-    def _name_get(self):
-        return _util.char_ptr_to_str(
-            _libkmod_h.kmod_module_get_name(self.module))
-    name = property(fget=_name_get)
-
-    def _path_get(self):
-        return _util.char_ptr_to_str(
-            _libkmod_h.kmod_module_get_path(self.module))
-    path = property(fget=_path_get)
-
-    def _options_get(self):
-        return _util.char_ptr_to_str(
-            _libkmod_h.kmod_module_get_options(self.module))
-    options = property(fget=_options_get)
-
-    def _install_commands_get(self):
-        return _util.char_ptr_to_str(
-            _libkmod_h.kmod_module_get_install_commands(self.module))
-    install_commands = property(fget=_install_commands_get)
-
-    def _remove_commands_get(self):
-        return _util.char_ptr_to_str(
-            _libkmod_h.kmod_module_get_remove_commands(self.module))
-    remove_commands = property(fget=_remove_commands_get)
-
-    def _refcnt_get(self):
-        return _libkmod_h.kmod_module_get_refcnt(self.module)
-    refcnt = property(fget=_refcnt_get)
-
-    def _size_get(self):
-        return _libkmod_h.kmod_module_get_size(self.module)
-    size = property(fget=_size_get)
-
-    def _info_get(self):
-        cdef _list.ModList ml = _list.ModList()
-        cdef _list.ModListItem mli
-        err = _libkmod_h.kmod_module_get_info(self.module, &ml.list)
-        if err < 0:
-            raise _KmodError('Could not get info')
-        info = _collections.OrderedDict()
-        try:
-            for item in ml:
-                mli = <_list.ModListItem> item
-                key = _util.char_ptr_to_str(
-                    _libkmod_h.kmod_module_info_get_key(mli.list))
-                value = _util.char_ptr_to_str(
-                    _libkmod_h.kmod_module_info_get_value(mli.list))
-                info[key] = value
-        finally:
-            _libkmod_h.kmod_module_info_free_list(ml.list)
-            ml.list = NULL
-        return info
-    info = property(fget=_info_get)
-
-    def _versions_get(self):
-        cdef _list.ModList ml = _list.ModList()
-        cdef _list.ModListItem mli
-        err = _libkmod_h.kmod_module_get_versions(self.module, &ml.list)
-        if err < 0:
-            raise _KmodError('Could not get versions')
-        try:
-            for item in ml:
-                mli = <_list.ModListItem> item
-                symbol = _util.char_ptr_to_str(
-                    _libkmod_h.kmod_module_version_get_symbol(mli.list))
-                crc = _libkmod_h.kmod_module_version_get_crc(mli.list)
-                yield {'symbol': symbol, 'crc': crc}
-        finally:
-            _libkmod_h.kmod_module_versions_free_list(ml.list)
-            ml.list = NULL
-    versions = property(fget=_versions_get)
-
-    def insert(self, flags=0, extra_options=None, install_callback=None,
-               data=None, print_action_callback=None):
-        """
-        insert module to current tree. 
-        e.g.
-        km = kmod.Kmod()
-        tp = km.module_from_name("thinkpad_acpi")
-        tp.insert(extra_options='fan_control=1')
-        """
-        cdef char *opt = NULL
-        #cdef _libkmod_h.install_callback_t install = NULL
-        cdef int (*install)(
-            _libkmod_h.kmod_module *, _libkmod_h.const_char_ptr, void *)
-        install = NULL
-        cdef void *d = NULL
-        #cdef _libkmod_h.print_action_callback_t print_action = NULL
-        cdef void (*print_action)(
-            _libkmod_h.kmod_module *, _libkmod_h.bool,
-            _libkmod_h.const_char_ptr)
-        print_action = NULL
-        if extra_options:
-            opt = extra_options
-        # TODO: convert callbacks and data from Python object to C types
-        err = _libkmod_h.kmod_module_probe_insert_module(
-            self.module, flags, opt, install, d, print_action)
-        if err == -_errno.EEXIST:
-            raise _KmodError('Module already loaded')
-        elif err < 0:
-            raise _KmodError('Could not load module')
-
-    def remove(self, flags=0):
-        """
-        remove module from current tree
-        e.g.
-        km = kmod.Kmod()
-        tp = km.module_from_name("thinkpad_acpi")
-        tp.remove()
-        """
-        err = _libkmod_h.kmod_module_remove_module(self.module, flags)
-        if err < 0:
-            raise _KmodError('Could not remove module')
diff --git a/libkmod/python/kmod/version.py.in b/libkmod/python/kmod/version.py.in
deleted file mode 100644
index 4daa94d..0000000
--- a/libkmod/python/kmod/version.py.in
+++ /dev/null
@@ -1,17 +0,0 @@
-# Copyright (C) 2012 W. Trevor King <wking@tremily.us>
-#
-# This file is part of python-kmod.
-#
-# python-kmod is free software: you can redistribute it and/or modify it under
-# the terms of the GNU Lesser General Public License version 2.1 as published
-# by the Free Software Foundation.
-#
-# python-kmod is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
-# details.
-#
-# You should have received a copy of the GNU Lesser General Public License
-# along with python-kmod.  If not, see <http://www.gnu.org/licenses/>.
-
-__version__ = '@VERSION@'
diff --git a/testsuite/mkosi/mkosi.build b/testsuite/mkosi/mkosi.build
index c0ba549..53fc797 100755
--- a/testsuite/mkosi/mkosi.build
+++ b/testsuite/mkosi/mkosi.build
@@ -32,7 +32,7 @@ cd build
 kdir=$(find_kdir)
 IFS=/ read _ _ _ kver _ <<<"$kdir"
 
-../autogen.sh c --disable-python
+../autogen.sh c
 make -j
 make check KDIR="$kdir" KVER="$kver"
 make install
-- 
2.43.0

