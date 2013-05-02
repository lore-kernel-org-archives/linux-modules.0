Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:44430 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759006Ab3EBQVa (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 May 2013 12:21:30 -0400
Received: by mail-vc0-f177.google.com with SMTP id ha12so643523vcb.8
        for <linux-modules@vger.kernel.org>; Thu, 02 May 2013 09:21:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
References: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 2 May 2013 13:21:08 -0300
Message-ID: <CAMOw1v64418ddfM4v3OW7sEYGq+d7FKmHUsizAsDbNRQnSy10w@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Avoid calling syscall() with -1
To: Jan Luebbe <jlu@pengutronix.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Jan,

On Thu, May 2, 2013 at 11:47 AM, Jan Luebbe <jlu@pengutronix.de> wrote:
> At least in qemu 1.4.1 for vexpress/arm-cortexa9, this resulted in an
> illegal instruction error. Solve that by returning an error when
> __NR_finit_module is -1.
> ---
>  libkmod/missing.h |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/libkmod/missing.h b/libkmod/missing.h
> index edb88b9..ac24a35 100644
> --- a/libkmod/missing.h
> +++ b/libkmod/missing.h
> @@ -20,8 +20,15 @@
>  #endif
>
>  #ifndef HAVE_FINIT_MODULE
> +#include <errno.h>
> +
>  static inline int finit_module(int fd, const char *uargs, int flags)
>  {
> -       return syscall(__NR_finit_module, fd, uargs, flags);
> +       if (__NR_finit_module == -1) {
> +               errno = ENOSYS;
> +               return -1;
> +       } else {
> +               return syscall(__NR_finit_module, fd, uargs, flags);
> +       }
>  }
>  #endif
> --

Indeed. But I had already a patch for that, just waiting the bug
reporter to test it:

http://bugs.funtoo.org/browse/FL-534

And the patch:
http://bugs.funtoo.org/secure/attachment/11098/dont-call-libc.diff

I prefer doing it at compile time rather than runtime.

Lucas De Marchi
