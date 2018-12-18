Return-Path: <SRS0=Oby8=O3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF676C43387
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70B217D9
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 10:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLRK0T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:26:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbeLRK0S (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Dec 2018 05:26:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80EF9B06F;
        Tue, 18 Dec 2018 10:26:16 +0000 (UTC)
Date:   Tue, 18 Dec 2018 11:26:14 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] depmod: prevent module dependency files
 corruption due to parallel invocation.
Message-ID: <20181218112614.07242b2e@naga>
In-Reply-To: <xunyd0pzl49t.fsf@redhat.com>
References: <cover.1544476531.git.msuchanek@suse.de>
        <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
        <CAKi4VA+VqSrmA1ZO4zAkumPZACupq=n7803N==7r+Uw9jtnnMg@mail.gmail.com>
        <20181217230743.61ff1738@naga>
        <xunyd0pzl49t.fsf@redhat.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 18 Dec 2018 08:47:58 +0200
Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:

> Hi, Michal!
> 
> >>>>> On Mon, 17 Dec 2018 23:07:43 +0100, Michal Suchánek  wrote:  
> 
>  > On Mon, 17 Dec 2018 10:10:37 -0800
>  > Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:  
> 
>  >> On Mon, Dec 10, 2018 at 2:03 PM Michal Suchanek <msuchanek@suse.de> wrote:  
>  >> >
>  >> > Depmod does not use unique filename for temporary files. There is no
>  >> > guarantee the user does not attempt to run mutiple depmod processes in
>  >> > parallel. If that happens a temporary file might be created by
>  >> > depmod(1st), truncated by depmod(2nd), and renamed to final name by
>  >> > depmod(1st) resulting in corrupted file seen by user.
>  >> >
>  >> > Due to missing mkstempat() this is more complex than it should be.
>  >> > Adding PID and timestamp to the filename should be reasonably reliable.
>  >> > Adding O_EXCL as mkstemp does fails creating the file rather than
>  >> > corrupting existing file.
>  >> >
>  >> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>  >> > ---
>  >> >  tools/depmod.c | 12 +++++++++---
>  >> >  1 file changed, 9 insertions(+), 3 deletions(-)
>  >> >
>  >> > diff --git a/tools/depmod.c b/tools/depmod.c
>  >> > index 18c0d61b2db3..3b6d16e76160 100644
>  >> > --- a/tools/depmod.c
>  >> > +++ b/tools/depmod.c
>  >> > @@ -29,6 +29,7 @@
>  >> >  #include <string.h>
>  >> >  #include <unistd.h>
>  >> >  #include <sys/stat.h>
>  >> > +#include <sys/time.h>
>  >> >  #include <sys/utsname.h>
>  >> >
>  >> >  #include <shared/array.h>
>  >> > @@ -2398,6 +2399,9 @@ static int depmod_output(struct depmod *depmod, FILE *out)
>  >> >         };
>  >> >         const char *dname = depmod->cfg->dirname;
>  >> >         int dfd, err = 0;
>  >> > +       struct timeval tv;
>  >> > +
>  >> > +       gettimeofday(&tv, NULL);
>  >> >
>  >> >         if (out != NULL)
>  >> >                 dfd = -1;
>  >> > @@ -2412,15 +2416,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
>  >> >
>  >> >         for (itr = depfiles; itr->name != NULL; itr++) {
>  >> >                 FILE *fp = out;
>  >> > -               char tmp[NAME_MAX] = "";
>  >> > +               char tmp[NAME_MAX + 1] = "";
>  >> >                 int r, ferr;
>  >> >
>  >> >                 if (fp == NULL) {
>  >> > -                       int flags = O_CREAT | O_TRUNC | O_WRONLY;
>  >> > +                       int flags = O_CREAT | O_TRUNC | O_WRONLY | O_EXCL;
>  >> >                         int mode = 0644;
>  >> >                         int fd;
>  >> >
>  >> > -                       snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
>  >> > +                       snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
>  >> > +                                       tv.tv_usec, tv.tv_sec);
>  >> > +                       tmp[NAME_MAX] = 0;    
>  >> 
>  >> why? snprintf is guaranteed to nul-terminate the string.
>  >>   
>  > AFAIK it is guaranteed to not write after end of buffer. It is
>  > not guaranteed to terminate the string. To guarantee
>  > terminated string you need large enough buffer or a nul after
>  > the buffer. Or asprintf.  
> 
> Actually, it is. VS strncpy(). May be it is not so clear from the
> man page:
> 
> ```
> The functions snprintf() and vsnprintf() write at most size
> bytes (including the terminating null byte ('\0')) to str.
> ```
> 

Yes, that's it. The POSIX page is much clearer:

>> The  snprintf() function shall be equivalent to sprintf(), with the
>> addition of the n argument which states the size of the buffer referred
>> to by s.  If n is zero, nothing shall be written and s may be a null
>> pointer. Otherwise, output  bytes  beyond  the n‐1st  shall  be
>> discarded  instead  of being written to the array, and a null byte is
>> written at the end of the bytes actually written into the array.

Thanks

Michal
