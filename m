Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E7C43387
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E9E21871
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 20:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuDVtlZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfADU6a (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:58:30 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55337 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADU6a (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 15:58:30 -0500
Received: by mail-wm1-f46.google.com with SMTP id y139so2216541wmc.5
        for <linux-modules@vger.kernel.org>; Fri, 04 Jan 2019 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXxNAMuiuSWONlO/+11YSGYAorHCyMykq7MM7a3HSXo=;
        b=KuDVtlZiOgBeIHI1j8Y1PlCoeuPlOPyQZmIdTS4Bif0C/y5rb5SADy46ikAxUtZ0xW
         ch7I/FHsdmpi1lgB+AUXHCrtViRnFonVNFtiZek/TBiAdohg4ss6YTaPQX0PSWKYE1Ql
         t9lbWVsWEnASvn/xqtXUgUD8yR+wTPUVVRlQ7VoEWIKoRP1axU44Bw8skfoiOjAGALgR
         5l+pen/dGOwFGXDk8u0eqXS9upQ93e7/YmMQxtBKqfIGLdZ+VmcjPH/+CvGsiZhRruqu
         0nw7WTwtWzyqtIzq6fggImlhPmqmS7ffyts5TFmNSyn0+xQmzmWyPabRwnAztxEi4eeE
         4AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXxNAMuiuSWONlO/+11YSGYAorHCyMykq7MM7a3HSXo=;
        b=qNbSzyH6Q+BIg5BRZv5G4Jb1fCnISrHXwHxi/pAq5xF4uW2+mjrcNW0N4HY7frjW/g
         TmX302Zf9FBrufrGW7BB4JiMe1AZFNJ5s8X7EGaC4ZDsrt64TWZZOZ7wt/matUs8wooP
         Xcnja4jQ6LQZxnPExHc/ujFxxTufuX45LSXTVrn46hu7/3Qojr3v6FVNi0XcwJIXnOfW
         aVLoW4uQHdg50czGd8mff9lRl55+fZhzLasW743nzfPHzI5n3yEYo8Ypa2gqaXhxSPGk
         4zG2tfBLc1rNHeRW4wtovZRbm2C+Lp/3eq6lEMe9LcvDtnOPGVBrcODG2Prmu6r5MdBo
         UFOw==
X-Gm-Message-State: AJcUuke+Qo7OeWU9oqvsy9eyHeqozO04PylC9kGAXA2JOCU6w2gskNg7
        EEHKnAsnmSQq9porhHYvQjZPzy+QpVThby3RzOE=
X-Google-Smtp-Source: ALg8bN6nGkNcXs0Bs391Rwu6dDrOq41eE/BBSRgJ/+xCHxxjL8alwQr77xpKZ/EWyGyq3UCwGgQHd0fkXfVZhsKttOs=
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr2248139wmg.132.1546635508516;
 Fri, 04 Jan 2019 12:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20190103210746.20048-1-lucas.demarchi@intel.com> <xuny1s5sjtb0.fsf@redhat.com>
In-Reply-To: <xuny1s5sjtb0.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 4 Jan 2019 12:58:16 -0800
Message-ID: <CAKi4VALP-JEGX7_W3pxcvxrY7YM=OokRrZihrb8+4+3hE6+T4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] testsuite: split out function to compare outputs exactly
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 4, 2019 at 8:28 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Lucas!
>
> Just in case, ACK.

pushed, thanks.

Lucas De Marchi

>
> >>>>> On Thu,  3 Jan 2019 13:07:44 -0800, Lucas De Marchi  wrote:
>
>  > Move functionality to compare the exact output to a separate function
>  > and allocate one buffer per output/match pair. This will allow us to
>  > extend this to allow other types of comparisons. Since now we are using
>  > heap-allocated buffer, keep the buffer allocation to the caller, so we
>  > don't have to allocate and free it on every invocation. It also avoids
>  > the different comparison functions to have to deal with it.
>  > ---
>  >  testsuite/testsuite.c | 124 ++++++++++++++++++++++++------------------
>  >  1 file changed, 70 insertions(+), 54 deletions(-)
>
>  > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
>  > index 8512b56..508bbd3 100644
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
>  > +    int r, rmatch, done = 0;
>  > +
>  > +    r = read(fd, buf->buf, sizeof(buf->buf) - 1);
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
