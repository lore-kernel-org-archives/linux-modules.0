Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444DFC43387
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1561021473
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeLQWHq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:07:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbeLQWHq (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 17:07:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCCA0B018;
        Mon, 17 Dec 2018 22:07:44 +0000 (UTC)
Date:   Mon, 17 Dec 2018 23:07:43 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] depmod: prevent module dependency files
 corruption due to parallel invocation.
Message-ID: <20181217230743.61ff1738@naga>
In-Reply-To: <CAKi4VA+VqSrmA1ZO4zAkumPZACupq=n7803N==7r+Uw9jtnnMg@mail.gmail.com>
References: <cover.1544476531.git.msuchanek@suse.de>
        <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
        <CAKi4VA+VqSrmA1ZO4zAkumPZACupq=n7803N==7r+Uw9jtnnMg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, 17 Dec 2018 10:10:37 -0800
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Mon, Dec 10, 2018 at 2:03 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Depmod does not use unique filename for temporary files. There is no
> > guarantee the user does not attempt to run mutiple depmod processes in
> > parallel. If that happens a temporary file might be created by
> > depmod(1st), truncated by depmod(2nd), and renamed to final name by
> > depmod(1st) resulting in corrupted file seen by user.
> >
> > Due to missing mkstempat() this is more complex than it should be.
> > Adding PID and timestamp to the filename should be reasonably reliable.
> > Adding O_EXCL as mkstemp does fails creating the file rather than
> > corrupting existing file.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  tools/depmod.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/depmod.c b/tools/depmod.c
> > index 18c0d61b2db3..3b6d16e76160 100644
> > --- a/tools/depmod.c
> > +++ b/tools/depmod.c
> > @@ -29,6 +29,7 @@
> >  #include <string.h>
> >  #include <unistd.h>
> >  #include <sys/stat.h>
> > +#include <sys/time.h>
> >  #include <sys/utsname.h>
> >
> >  #include <shared/array.h>
> > @@ -2398,6 +2399,9 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> >         };
> >         const char *dname = depmod->cfg->dirname;
> >         int dfd, err = 0;
> > +       struct timeval tv;
> > +
> > +       gettimeofday(&tv, NULL);
> >
> >         if (out != NULL)
> >                 dfd = -1;
> > @@ -2412,15 +2416,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
> >
> >         for (itr = depfiles; itr->name != NULL; itr++) {
> >                 FILE *fp = out;
> > -               char tmp[NAME_MAX] = "";
> > +               char tmp[NAME_MAX + 1] = "";
> >                 int r, ferr;
> >
> >                 if (fp == NULL) {
> > -                       int flags = O_CREAT | O_TRUNC | O_WRONLY;
> > +                       int flags = O_CREAT | O_TRUNC | O_WRONLY | O_EXCL;
> >                         int mode = 0644;
> >                         int fd;
> >
> > -                       snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
> > +                       snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
> > +                                       tv.tv_usec, tv.tv_sec);
> > +                       tmp[NAME_MAX] = 0;  
> 
> why? snprintf is guaranteed to nul-terminate the string.
> 
AFAIK it is guaranteed to not write after end of buffer. It is not
guaranteed to terminate the string. To guarantee terminated string you
need large enough buffer or a nul after the buffer. Or asprintf.

Thanks

Michal
