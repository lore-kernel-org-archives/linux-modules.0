Return-Path: <SRS0=NEaN=PL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29640C43387
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AB4208E3
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPCP+seg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfACUKM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:10:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfACUKM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Jan 2019 15:10:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so31349905wmd.2
        for <linux-modules@vger.kernel.org>; Thu, 03 Jan 2019 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9F2awArGxx2cfUUWVABhWXVi0SgUbE3pIYCpjC+8FU=;
        b=WPCP+seg90ZMMdTuVQaacsjufP3pVV+/2fBOBNoxppGpKOWeNvj1mQjdRBEeOs94Rr
         1Tqu6S2tYtMfhXUvhFLryOOVgwLY5LwuTJ7Mb8z/m9Ne8jufp/vYSLaytInfy7pGbi4k
         NSUl6NEsG9IdafznCwDwWyKZVuP2DsfpW2ReDBLXOafN7Yf96Dige0Neiw8GXffJIx7l
         KCDTHRJ98Sc97ukbqtJR/E0kI5i5VOH2XVoVyoZhlJpRCBlGloIxgTrOWQjCpC9RRSH3
         MO8hyyZoIqV8OAQkwDc9yPOizWtoR6ny9yicUo1OjY3vQibD388mRW2GfD4sQ09SQV4s
         vOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9F2awArGxx2cfUUWVABhWXVi0SgUbE3pIYCpjC+8FU=;
        b=rPg3Bp9GMHBrlbPicjC3TQEDZN0tSnSwwUvScd3hOr2Fk4KUZTWN9UDs+MGASBlC5c
         kYg1ETee5BTDd39rrFk3WxS4OxaB6DQpBidZmgwDZj3WsVxy0p2Re1ywmzma0OThejZj
         X3xn5Z0ogyJBbmeg/tQiwOpYlYjAGUvxcz8S/vqtDlFJWywYZdbaM2iYkfN1M03e6Sck
         aN14l5TR60rvqUWIATeUXxjUGCPUQ4UGcEWoEiOuWigiO+XTS2wnghhJyHKir5//UQG9
         kt5o0Eg1j+nJdDAMo2FhSh0T0Z0Od12oAysCW4kh6BHUnr6AChxCMeMjghiswpfeLtyC
         suUA==
X-Gm-Message-State: AA+aEWZIiXmr/RmarP3F99WvSoxWhVMpowW6izqM0cuencDngYIaJA+G
        2xLIQnaMzPU4hdC/4CKjwfBHOQo7re07yB+YKtaM/A==
X-Google-Smtp-Source: ALg8bN76xJvQnDvf7iP6fW5yOeIX/Sg9J1hHYeTenW6iV999aPBgYKIbAC3FXRYZW7ZwQ4rgUMMC7V9Uhmza0w+xJa8=
X-Received: by 2002:a1c:6442:: with SMTP id y63mr37478807wmb.143.1546546209340;
 Thu, 03 Jan 2019 12:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20181219000229.10793-1-lucas.demarchi@intel.com> <xuny36qslbys.fsf@redhat.com>
In-Reply-To: <xuny36qslbys.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 3 Jan 2019 12:09:57 -0800
Message-ID: <CAKi4VALMbE563DVSfwpsrBiBuAMessk3SWgOCKYvQmARKXc=mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] testsuite: split out function to compare outputs exactly
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 20, 2018 at 7:00 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Lucas!
>
> >>>>> On Tue, 18 Dec 2018 16:02:27 -0800, Lucas De Marchi  wrote:
>
>  > Move functionality to compare the exact output to a separate function
>  > and allocate one buffer per output/match pair. This will allow us to
>  > extend this to allow other types of comparisons.
>  > ---
>  >  testsuite/testsuite.c | 124 ++++++++++++++++++++++++------------------
>  >  1 file changed, 70 insertions(+), 54 deletions(-)
>
>  > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
>  > index 8512b56..550c711 100644
>  > --- a/testsuite/testsuite.c
>  > +++ b/testsuite/testsuite.c
>  > @@ -290,13 +290,64 @@ static int check_activity(int fd, bool activity,  const char *path,
>  >      return -1;
>  >  }
>
>  > -static inline bool test_run_parent_check_outputs(const struct test *t,
>  > -                    int fdout, int fderr, int fdmonitor, pid_t child)
>  > +#define BUFSZ 4096
>  > +struct buffer {
>  > +    char buf[BUFSZ];
>  > +};
>  > +
>  > +/* read fd and fd_match, checking they match exactly */
>  > +static bool cmpbuf_exact(const struct test *t, const char *prefix,
>  > +                     int fd, int fd_match, struct buffer *buf,
>  > +                     struct buffer *buf_match)
>  > +{
>
> Not so clear (either from description) without the next patch,
> why the buffers are not local for the function.

I will amend the commit message. Besides needing it for the regex,
which is in the next patches, it's also much more efficient to
allocate the buffer once and reuse it for multiple calls to the
comparison function than allocate and free on every invocation.


>
>  > +    int r, rmatch, done = 0;
>  > +
>  > +    r = read(fd, buf, sizeof(buf->buf) - 1);
>
>                      buf->buf?

thanks, fixed.


Lucas De Marchi

>
>  > +    if (r <= 0)
>  > +            /* try again later */
>  > +            return true;
>  > +
>  > +    /* read as much data from fd_match as we read from fd */
>  > +    for (;;) {
>  > +            rmatch = read(fd_match, buf_match->buf + done, r - done);
>  > +            if (rmatch == 0)
>  > +                    break;
>  > +
>  > +            if (rmatch < 0) {
>  > +                    if (errno == EINTR)
>  > +                            continue;
>  > +                    ERR("could not read match fd %d\n", fd_match);
>  > +                    return false;
>  > +            }
>  > +
>  > +            done += rmatch;
>  > +    }
>  > +
>  > +    buf->buf[r] = '\0';
>  > +    buf_match->buf[r] = '\0';
>  > +
>  > +    if (t->print_outputs)
>  > +            printf("%s: %s\n", prefix, buf->buf);
>  > +
>  > +    if (!streq(buf->buf, buf_match->buf)) {
>  > +            ERR("Outputs do not match on %s:\n", prefix);
>  > +            ERR("correct:\n%s\n", buf_match->buf);
>  > +            ERR("wrong:\n%s\n", buf->buf);
>  > +            return false;
>  > +    }
>  > +
>  > +    return true;
>  > +}
>  > +
>  > +static bool test_run_parent_check_outputs(const struct test *t,
>  > +                                      int fdout, int fderr, int fdmonitor,
>  > +                                      pid_t child)
>  >  {
>  >      struct epoll_event ep_outpipe, ep_errpipe, ep_monitor;
>  >      int err, fd_ep, fd_matchout = -1, fd_matcherr = -1;
>  >      bool fd_activityout = false, fd_activityerr = false;
>  >      unsigned long long end_usec, start_usec;
>  > +    _cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
>
>  >      fd_ep = epoll_create1(EPOLL_CLOEXEC);
>  >      if (fd_ep < 0) {
>  > @@ -320,6 +371,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
>  >                      ERR("could not add fd to epoll: %m\n");
>  >                      goto out;
>  >              }
>  > +            buf_out = calloc(2, sizeof(*buf_out));
>  >      } else
>  >              fdout = -1;
>
>  > @@ -340,6 +392,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
>  >                      ERR("could not add fd to epoll: %m\n");
>  >                      goto out;
>  >              }
>  > +            buf_err = calloc(2, sizeof(*buf_err));
>  >      } else
>  >              fderr = -1;
>
>  > @@ -374,76 +427,39 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
>  >              }
>
>  >              for (i = 0;  i < fdcount; i++) {
>  > -                    int *fd = ev[i].data.ptr;
>  > +                    int fd = *(int *)ev[i].data.ptr;
>
>  >                      if (ev[i].events & EPOLLIN) {
>  > -                            ssize_t r, done = 0;
>  > -                            char buf[4096];
>  > -                            char bufmatch[4096];
>  >                              int fd_match;
>  > +                            struct buffer *buf, *buf_match;
>  > +                            const char *prefix;
>
>  > -                            /*
>  > -                             * compare the output from child with the one
>  > -                             * saved as correct
>  > -                             */
>  > -
>  > -                            r = read(*fd, buf, sizeof(buf) - 1);
>  > -                            if (r <= 0)
>  > -                                    continue;
>  > -
>  > -                            if (*fd == fdout) {
>  > +                            if (fd == fdout) {
>  >                                      fd_match = fd_matchout;
>  > +                                    buf = buf_out;
>  >                                      fd_activityout = true;
>  > -                            } else if (*fd == fderr) {
>  > +                                    prefix = "STDOUT";
>  > +                            } else if (fd == fderr) {
>  >                                      fd_match = fd_matcherr;
>  > +                                    buf = buf_err;
>  >                                      fd_activityerr = true;
>  > +                                    prefix = "STDERR";
>  >                              } else {
>  >                                      ERR("Unexpected activity on monitor pipe\n");
>  >                                      err = -EINVAL;
>  >                                      goto out;
>  >                              }
>
>  > -                            for (;;) {
>  > -                                    int rmatch = read(fd_match,
>  > -                                            bufmatch + done, r - done);
>  > -                                    if (rmatch == 0)
>  > -                                            break;
>  > -
>  > -                                    if (rmatch < 0) {
>  > -                                            if (errno == EINTR)
>  > -                                                    continue;
>  > -                                            err = -errno;
>  > -                                            ERR("could not read match fd %d\n",
>  > -                                                            fd_match);
>  > -                                            goto out;
>  > -                                    }
>  > -
>  > -                                    done += rmatch;
>  > -                            }
>  > +                            buf_match = buf + 1;
>
>  > -                            buf[r] = '\0';
>  > -                            bufmatch[r] = '\0';
>  > -
>  > -                            if (t->print_outputs)
>  > -                                    printf("%s: %s\n",
>  > -                                           fd_match == fd_matchout ? "STDOUT:" : "STDERR:",
>  > -                                           buf);
>  > -
>  > -                            if (!streq(buf, bufmatch)) {
>  > -                                    ERR("Outputs do not match on %s:\n",
>  > -                                            fd_match == fd_matchout ? "STDOUT" : "STDERR");
>  > -                                    ERR("correct:\n%s\n", bufmatch);
>  > -                                    ERR("wrong:\n%s\n", buf);
>  > -                                    err = -1;
>  > +                            if (!cmpbuf_exact(t, prefix,  fd, fd_match,
>  > +                                              buf, buf_match))
>  >                                      goto out;
>  > -                            }
>  >                      } else if (ev[i].events & EPOLLHUP) {
>  > -                            if (epoll_ctl(fd_ep, EPOLL_CTL_DEL,
>  > -                                                    *fd, NULL) < 0) {
>  > -                                    ERR("could not remove fd %d from epoll: %m\n",
>  > -                                                                    *fd);
>  > +                            if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
>  > +                                    ERR("could not remove fd %d from epoll: %m\n", fd);
>  >                              }
>  > -                            *fd = -1;
>  > +                            *(int *)ev[i].data.ptr = -1;
>  >                      }
>  >              }
>  >      }
>  > --
>  > 2.20.0
>
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
