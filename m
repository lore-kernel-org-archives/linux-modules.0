Return-Path: <SRS0=RSe8=YS=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37210CA9EA0
	for <linux-modules@archiver.kernel.org>; Fri, 25 Oct 2019 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C221D81
	for <linux-modules@archiver.kernel.org>; Fri, 25 Oct 2019 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfJYWHZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:07:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:60548 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYWHZ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 25 Oct 2019 18:07:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="350147166"
Received: from ldmartin-desk1.jf.intel.com ([10.7.200.70])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 15:07:24 -0700
Date:   Fri, 25 Oct 2019 15:07:22 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-modules@vger.kernel.org,
        Victor Stinner <victor.stinner@gmail.com>
Subject: Re: [PATCH kmod] Do not check for undefined symbols when building
 the Python modules
Message-ID: <20191025220722.l7xe3lnrikcownvm@ldmartin-desk1.jf.intel.com>
References: <20191024174710.9441-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191024174710.9441-1-thomas.petazzoni@bootlin.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20180716
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 24, 2019 at 07:47:10PM +0200, Thomas Petazzoni wrote:
>kmod's configure.ac uses the -Wl,--no-undefined linker flag to verify
>at link time that all symbols of shared libraries are available, and
>that there are no undefined symbols.
>
>This make perfect sense for regular shared libraries. However, for
>Python extensions, which will be dlopen()ed inside the Python
>interpreter, it makes less sense.
>
>Since Python 3.8, there is a change in python-config script and
>Python's pkg-config file: it no longer links Python extensions with
>the libpython library. See
>https://docs.python.org/dev/whatsnew/3.8.html#debug-build-uses-the-same-abi-as-release-build
>which states:
>
>  On the other hand, pkg-config python3.8 --libs no longer contains
>  -lpython3.8. C extensions must not be linked to libpython (except on
>  Android and Cygwin, whose cases are handled by the script); this
>  change is backward incompatible on purpose. (Contributed by Victor
>  Stinner in bpo-36721.)
>
>So, when linking the kmod Python extensions, it currently fails with
>numerous unresolved symbols, that were previously provided by
>libpython:
>
>/home/test/autobuild/run/instance-3/output-1/host/opt/ext-toolchain/bin/../lib/gcc/powerpc64-buildroot-linux-gnu/7.4.0/../../../../powerpc64-buildroot-linux-gnu/bin/ld: libkmod/python/kmod/.libs/list_la-list.o: in function `__Pyx_PyObject_GetAttrStr':
>list.c:(.text.__Pyx_PyObject_GetAttrStr+0x48): undefined reference to `PyObject_GetAttr'
>/home/test/autobuild/run/instance-3/output-1/host/opt/ext-toolchain/bin/../lib/gcc/powerpc64-buildroot-linux-gnu/7.4.0/../../../../powerpc64-buildroot-linux-gnu/bin/ld: libkmod/python/kmod/.libs/list_la-list.o: in function `__pyx_tp_dealloc_4kmod_4list_ModListItem':
>list.c:(.text.__pyx_tp_dealloc_4kmod_4list_ModListItem+0x78): undefined reference to `PyObject_CallFinalizerFromDealloc'
>/home/test/autobuild/run/instance-3/output-1/host/opt/ext-toolchain/bin/../lib/gcc/powerpc64-buildroot-linux-gnu/7.4.0/../../../../powerpc64-buildroot-linux-gnu/bin/ld: libkmod/python/kmod/.libs/list_la-list.o: in function `__pyx_tp_dealloc_4kmod_4list_ModList':
>list.c:(.text.__pyx_tp_dealloc_4kmod_4list_ModList+0x30): undefined reference to `PyErr_Fetch'
>
>[Complete log at http://autobuild.buildroot.net/results/79a/79a5a0398723e8cfea0d0aa3dec5f7649aee4c63/build-end.log]
>
>Linking with libpython is no longer recommended: those symbols should
>remain unresolved in the Python extensions, as they wil be properly
>resolved when the Python extension gets loaded into the Python
>interpreter.
>
>Since we want to keep -Wl,--no-undefined globally in kmod, we leave
>the configure.ac file unchanged, and instead, specifically in the
>LDFLAGS used to build the Python extensions, we override
>-Wl,--no-undefined with -Wl,-z,undefs. Ideally, -Wl,--no-undefined is
>the same as -Wl,-z,defs, and the effect of these options can be
>canceled on the linker command line by a following -Wl,-z,undefs (see
>the ld man page for details).
>
>Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>Cc: Victor Stinner <victor.stinner@gmail.com>

applied, thanks

Lucas De Marchi

>---
> Makefile.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Makefile.am b/Makefile.am
>index c5c2f06..8e9c90d 100644
>--- a/Makefile.am
>+++ b/Makefile.am
>@@ -173,7 +173,7 @@ CPYTHON_MODULE_CFLAGS = \
> 	$(AM_CFLAGS) -DCPYTHON_COMPILING_IN_PYPY=0 \
> 	$(PYTHON_NOWARN) $(PYTHON_CFLAGS) \
> 	-fvisibility=default
>-CPYTHON_MODULE_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version -shared
>+CPYTHON_MODULE_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version -shared -Wl,-z,undefs
>
> if BUILD_PYTHON
> pkgpyexec_LTLIBRARIES = \
>-- 
>2.21.0
>
