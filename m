Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:61407 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab3EBT4W (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 May 2013 15:56:22 -0400
Received: by mail-ve0-f174.google.com with SMTP id pb11so909149veb.33
        for <linux-modules@vger.kernel.org>; Thu, 02 May 2013 12:56:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130502194119.GA18636@pengutronix.de>
References: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
 <CAMOw1v64418ddfM4v3OW7sEYGq+d7FKmHUsizAsDbNRQnSy10w@mail.gmail.com> <20130502194119.GA18636@pengutronix.de>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 2 May 2013 16:56:01 -0300
Message-ID: <CAMOw1v4HCOVKcRmi=-5CML4Gv8OrW1j8hAdfmD_UNUS-5aTzFQ@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Avoid calling syscall() with -1
To: Jan Luebbe <jlu@pengutronix.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Jan,

On Thu, May 2, 2013 at 4:41 PM, Jan Luebbe <jlu@pengutronix.de> wrote:
> On Thu, May 02, 2013 at 01:21:08PM -0300, Lucas De Marchi wrote:
>> Indeed. But I had already a patch for that, just waiting the bug
>> reporter to test it:
>>
>> http://bugs.funtoo.org/browse/FL-534
>>
>> And the patch:
>> http://bugs.funtoo.org/secure/attachment/11098/dont-call-libc.diff
>
> In that patch, the new #ifndef is never used, as __NR_finit_module is
> defined a few lines up.
>
> This one looks better, but failes to compile:
> http://bugs.funtoo.org/secure/attachment/11099/0001-missing-Don-t-call-syscall-with-syscallno-1.patch
> libkmod/missing.h:27:17: error: '__NR_finit_module' undeclared (first use in this function)
>
> I've changed your patch a little (put the real call into the #else branch).
> With this version, I don't see the problem any more.
>
> ----
>
> From: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Date: Thu, 2 May 2013 13:22:57 -0300
> Subject: [PATCH] missing: Don't call syscall() with syscallno == -1
>
> Reported-by: Jean-Francis Roy <jeanfrancis@funtoo.org>
> Reported-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  libkmod/missing.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libkmod/missing.h b/libkmod/missing.h
> index edb88b9..b31af84 100644
> --- a/libkmod/missing.h
> +++ b/libkmod/missing.h
> @@ -1,5 +1,6 @@
>  #pragma once
>
> +#include <errno.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
>
> @@ -15,13 +16,14 @@
>  # define MODULE_INIT_IGNORE_VERMAGIC 2
>  #endif
>
> -#ifndef __NR_finit_module
> -# define __NR_finit_module -1
> -#endif
> -
>  #ifndef HAVE_FINIT_MODULE
>  static inline int finit_module(int fd, const char *uargs, int flags)
>  {
> +#ifndef __NR_finit_module
> +       errno = ENOSYS;
> +       return -1;
> +#else
>         return syscall(__NR_finit_module, fd, uargs, flags);
> +#endif
>  }
>  #endif
>
> --

Thanks very much. Patch has been applied

Lucas De Marchi
