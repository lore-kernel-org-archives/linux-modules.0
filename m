Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:35563 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3EKECT (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sat, 11 May 2013 00:02:19 -0400
Received: by mail-ve0-f171.google.com with SMTP id m1so1271285ves.16
        for <linux-modules@vger.kernel.org>; Fri, 10 May 2013 21:02:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
References: <1367506032-17290-1-git-send-email-jlu@pengutronix.de>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Sat, 11 May 2013 01:01:58 -0300
Message-ID: <CAMOw1v45AKf_M86LQS=T6cLM6dijvSOvFN1KFK-J6kc-14GTug@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Avoid calling syscall() with -1
To: Jan Luebbe <jlu@pengutronix.de>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Chengwei Yang <chengwei.yang@intel.com>
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

I changed my mind, reverted my change and applied yours instead
because we would have to do the same check inside testsuite, which is
currently failing for who doesn't have __NR_finit_module defined.


Thanks
Lucas De Marchi
