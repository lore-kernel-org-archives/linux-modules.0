Return-Path: <SRS0=Oby8=O3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F99C43387
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 06:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F662214C6
	for <linux-modules@archiver.kernel.org>; Tue, 18 Dec 2018 06:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLRGsA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:48:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRGr7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Dec 2018 01:47:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FB3D58E49;
        Tue, 18 Dec 2018 06:47:59 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-41.ams2.redhat.com [10.36.116.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9473F5C8A7;
        Tue, 18 Dec 2018 06:47:58 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] depmod: prevent module dependency files corruption due to parallel invocation.
References: <cover.1544476531.git.msuchanek@suse.de>
        <636a25c106ac3da29803025248a237e9d23f4e9d.1544476531.git.msuchanek@suse.de>
        <CAKi4VA+VqSrmA1ZO4zAkumPZACupq=n7803N==7r+Uw9jtnnMg@mail.gmail.com>
        <20181217230743.61ff1738@naga>
Date:   Tue, 18 Dec 2018 08:47:58 +0200
In-Reply-To: <20181217230743.61ff1738@naga> ("Michal \=\?utf-8\?Q\?Such\=C3\=A1n\?\=
 \=\?utf-8\?Q\?ek\=22's\?\= message of
        "Mon, 17 Dec 2018 23:07:43 +0100")
Message-ID: <xunyd0pzl49t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Dec 2018 06:47:59 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Michal!

>>>>> On Mon, 17 Dec 2018 23:07:43 +0100, Michal Suchánek  wrote:

 > On Mon, 17 Dec 2018 10:10:37 -0800
 > Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

 >> On Mon, Dec 10, 2018 at 2:03 PM Michal Suchanek <msuchanek@suse.de> wrote:
 >> >
 >> > Depmod does not use unique filename for temporary files. There is no
 >> > guarantee the user does not attempt to run mutiple depmod processes in
 >> > parallel. If that happens a temporary file might be created by
 >> > depmod(1st), truncated by depmod(2nd), and renamed to final name by
 >> > depmod(1st) resulting in corrupted file seen by user.
 >> >
 >> > Due to missing mkstempat() this is more complex than it should be.
 >> > Adding PID and timestamp to the filename should be reasonably reliable.
 >> > Adding O_EXCL as mkstemp does fails creating the file rather than
 >> > corrupting existing file.
 >> >
 >> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
 >> > ---
 >> >  tools/depmod.c | 12 +++++++++---
 >> >  1 file changed, 9 insertions(+), 3 deletions(-)
 >> >
 >> > diff --git a/tools/depmod.c b/tools/depmod.c
 >> > index 18c0d61b2db3..3b6d16e76160 100644
 >> > --- a/tools/depmod.c
 >> > +++ b/tools/depmod.c
 >> > @@ -29,6 +29,7 @@
 >> >  #include <string.h>
 >> >  #include <unistd.h>
 >> >  #include <sys/stat.h>
 >> > +#include <sys/time.h>
 >> >  #include <sys/utsname.h>
 >> >
 >> >  #include <shared/array.h>
 >> > @@ -2398,6 +2399,9 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 >> >         };
 >> >         const char *dname = depmod->cfg->dirname;
 >> >         int dfd, err = 0;
 >> > +       struct timeval tv;
 >> > +
 >> > +       gettimeofday(&tv, NULL);
 >> >
 >> >         if (out != NULL)
 >> >                 dfd = -1;
 >> > @@ -2412,15 +2416,17 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 >> >
 >> >         for (itr = depfiles; itr->name != NULL; itr++) {
 >> >                 FILE *fp = out;
 >> > -               char tmp[NAME_MAX] = "";
 >> > +               char tmp[NAME_MAX + 1] = "";
 >> >                 int r, ferr;
 >> >
 >> >                 if (fp == NULL) {
 >> > -                       int flags = O_CREAT | O_TRUNC | O_WRONLY;
 >> > +                       int flags = O_CREAT | O_TRUNC | O_WRONLY | O_EXCL;
 >> >                         int mode = 0644;
 >> >                         int fd;
 >> >
 >> > -                       snprintf(tmp, sizeof(tmp), "%s.tmp", itr->name);
 >> > +                       snprintf(tmp, sizeof(tmp), "%s.%i.%li.%li", itr->name, getpid(),
 >> > +                                       tv.tv_usec, tv.tv_sec);
 >> > +                       tmp[NAME_MAX] = 0;  
 >> 
 >> why? snprintf is guaranteed to nul-terminate the string.
 >> 
 > AFAIK it is guaranteed to not write after end of buffer. It is
 > not guaranteed to terminate the string. To guarantee
 > terminated string you need large enough buffer or a nul after
 > the buffer. Or asprintf.

Actually, it is. VS strncpy(). May be it is not so clear from the
man page:

```
The functions snprintf() and vsnprintf() write at most size
bytes (including the terminating null byte ('\0')) to str.
```

-- 
WBR,
Yauheni Kaliuta
