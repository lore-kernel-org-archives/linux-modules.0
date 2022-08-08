Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A3C00140
	for <linux-modules@archiver.kernel.org>; Mon,  8 Aug 2022 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbiHHNog (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiHHNoc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 8 Aug 2022 09:44:32 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107ABF62
        for <linux-modules@vger.kernel.org>; Mon,  8 Aug 2022 06:44:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=ZIqvjc5NoMxfRa+Oc6uGdcqx1OSySZAYVvE2Yfga4gY=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1659965198; v=1; x=1660397198;
 b=qFhmUNgm9PZSUev/6lFCivnnFMSFHtk0lE87Vt8noToPtDaoFut/MT6xKwTup3mySm00c867
 KqkmXvWHfV1rOQ8teGWNqNQHVItiSB34x408ZMRHri6rOLYLq23uHZ5yAhWutolOVZyZtI7Baha
 iRGdTaWBpzHw18BvPoxT6vso0FIT572tlHC+xhMegs1sXheB5SamMKDgfxHIvjzL1as9dyM+ZBv
 Fo5BuQgAFeUw9bD2wpwPrCWZ7FjFF4cD1hwRMlFL/yHUwxJdLPxTiJZB0JiqoB5pXMwzP1eOxIG
 PoDj3Vd6Co+zOzzTW1JfBXE3nDz5cFG7gzL489jvfKJWZo/0g30QmA7cVXzudmpz9EZIzy9eJwb
 UhEYXFZsCNZbb00q4+rNe5HqlJziXamhQ1Z+8dbr2eVtCOdEzT8bE4uuRoGrk9DVxDVLDQP9bxk
 hRM+U2x9G2pbnEeK6hQ8UpNPR0tH3aBdq7uaLeJto9Jds7gRUNmXg7Ljy2etYjifFIb1aQOuSMJ
 2r+eYtaT4O0DUREZC4RUPWD7T0dg41LWKC6+4ISwkQB2+PMaCFIYRZCw8xc+iY8nJ1dEx8eEHzf
 nUS2d4fTuRuQZtDF22vn5AOy93/yCpzACZe009yUW96Uo/Udg8Jj9Ap2Cm+3pkbsWZWrC2zkYSb
 HhCG+3icoZI=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 27b26a2c; Mon, 08 Aug
 2022 09:26:38 -0400
MIME-Version: 1.0
Date:   Mon, 08 Aug 2022 09:26:38 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
In-Reply-To: <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk>
 <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
Message-ID: <38a9853e59db8946999316ce3a6b4621@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I have real hardware for all these arches in my collection.  I use it 
for testing the latest kernel and toolchains on as many of the 
less-popular arches as possible, exactly to find issues like this one :)

Specifically we support all of these in Gentoo.  To double-check this 
wasn't a config issue, I asked another user who also runs sparc to try 
building 5.19 with his config (not copying mine), and he observed the 
same problem.  You can reach us in #gentoo-sparc on Libera.

As for testing, I make all this hardware available on an as-needed 
basis.  So if you can't or don't want to fiddle with qemu, just let me 
know (email or IRC, same username on Libera), and I will get you direct 
access to my hardware.  Thanks!!

-------- Original Message --------
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups 
(modpost, LTO, MODULE_REL_CRCS, export.h)
Date: 2022-08-08 01:54
 From: Masahiro Yamada <masahiroy@kernel.org>
To: matoro <matoro_mailinglist_kernel@matoro.tk>

Hi Matoro,

Thanks for the report.


I have qemu-system-sparc installed on my Ubuntu machine,
so I think I will be able to test it on sparc, at least.

How did you test these 4 architectures (sparc, alpha, riscv, ia64)?
QEMU?

Thanks




On Sat, Aug 6, 2022 at 8:39 AM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
> 
> Hi Masahiro, I'm sorry to raise this after release but this seems to be
> broken on SOME architectures.  So far I have tested:
> 
> Affected - sparc, alpha
> Unaffected - riscv, ia64
> 
> The affected systems are unable to load modules, similar to the
> previously reported issue.  All module loading fails with "disagrees
> about version of symbol module_layout".
> 
> Bisect blames 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b, but this does
> not revert cleanly.  Presumably CONFIG_MODVERSIONS=n would fix, but 
> this
> is a pretty core feature.
> 
> Unlike the issue Sedat reported, this is on a GNU toolchain, no clang
> involved.
> 
> Here are the configs I am using (with make olddefconfig on upgrade to
> 5.19):
> 
> Broken - sparc - https://dpaste.com/5A8F2JD6U
> Broken - alpha - https://dpaste.com/FYKK23L9X
> Working - riscv - https://dpaste.com/HV6Y4V6NT
> Working - ia64 - https://dpaste.com/HDLDNEAK4
> 
> Please let me know if there's anything I can do to help track down this
> regression.
> 
> 
> -------- Original Message --------
> Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups
> (modpost, LTO, MODULE_REL_CRCS, export.h)
> Date: 2022-05-13 08:20
>  From: Masahiro Yamada <masahiroy@kernel.org>
> To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
> 
> On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org>
> wrote:
> >
> >
> > This is the third batch of cleanups in this development cycle.
> >
> 
> 
> This series is available at
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>   lto-cleanup-v6
> 
> 
> >
> > Changes in v6:
> >   - Fix false-positive warnings when CONFIG_TRIM_UNUSED_KSYMS=y
> >
> > Changes in v5:
> >   - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by
> > Nathan)
> >   - Clean up arch/m68k/include/asm/export.h (Nick)
> >   - Keep gen_symversions (and will be removed by a later patch)
> >   - Add more comments in the script
> >
> > Changes in v4:
> >   - Rename .vmlinux-symver.c to .vmlinux.export.c
> >     because I notice this approach is useful for further cleanups,
> >     not only for modversioning but also for overall EXPORT_SYMBOL.
> >   - New patch
> >   - New.
> >     Resent of my previous submission.
> >
> > https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
> >   - New
> >     Resent of my previous submission
> >
> > https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
> >
> > Changes in v3:
> >   - New patch
> >
> > Changes in v2:
> >   - Simplify the implementation (parse .cmd files after ELF)
> >   - New patch
> >  - replace the chain of $(if ...) with $(and )
> >   - New patch
> >   - New patch
> >
> > Masahiro Yamada (10):
> >   modpost: extract symbol versions from *.cmd files
> >   kbuild: link symbol CRCs at final link, removing
> >     CONFIG_MODULE_REL_CRCS
> >   kbuild: stop merging *.symversions
> >   genksyms: adjust the output format to modpost
> >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> >   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
> >   kbuild: make built-in.a rule robust against too long argument error
> >   kbuild: make *.mod rule robust against too long argument error
> >   kbuild: add cmd_and_savecmd macro
> >   kbuild: rebuild multi-object modules when objtool is updated
> >
> >  arch/m68k/include/asm/Kbuild    |   1 +
> >  arch/m68k/include/asm/export.h  |   2 -
> >  arch/powerpc/Kconfig            |   1 -
> >  arch/s390/Kconfig               |   1 -
> >  arch/um/Kconfig                 |   1 -
> >  include/asm-generic/export.h    |  22 ++-
> >  include/linux/export-internal.h |  16 +++
> >  include/linux/export.h          |  30 ++--
> >  init/Kconfig                    |   4 -
> >  kernel/module.c                 |  10 +-
> >  scripts/Kbuild.include          |  10 +-
> >  scripts/Makefile.build          | 134 ++++++------------
> >  scripts/Makefile.lib            |   7 -
> >  scripts/Makefile.modfinal       |   5 +-
> >  scripts/Makefile.modpost        |   9 +-
> >  scripts/check-local-export      |  64 +++++++++
> >  scripts/genksyms/genksyms.c     |  18 +--
> >  scripts/link-vmlinux.sh         |  33 ++---
> >  scripts/mod/modpost.c           | 236 +++++++++++++++++++++-----------
> >  19 files changed, 320 insertions(+), 284 deletions(-)
> >  delete mode 100644 arch/m68k/include/asm/export.h
> >  create mode 100644 include/linux/export-internal.h
> >  create mode 100755 scripts/check-local-export
> >
> > --
> > 2.32.0
> >
> 

