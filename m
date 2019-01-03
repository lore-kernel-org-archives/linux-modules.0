Return-Path: <SRS0=NEaN=PL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AEDC43387
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD7621479
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXmq33d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfACUlg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:41:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfACUlf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Jan 2019 15:41:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so30351700wmj.1
        for <linux-modules@vger.kernel.org>; Thu, 03 Jan 2019 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jT7y9MQV64dzq3CT3VGEGHQVo1FPp7ILt0fGfMfo9J8=;
        b=sXmq33d4YsJadeCaA/Kxx/wC+QZdsyF0Ovguj0TWqiPAmZxta2+gJUQkJl8Ir7dEoL
         jlDFAhAAxNC8+tujwwsEY/BzI++nZWQnsEYgrpfj7m8aZSmNlDcHpoGMPGccLW5Ac0yw
         FAJO0PMsb4vL45/m0nTku2KlGjXhVjODB1l5zexypME+oT4/QwlTsI/bF60objE3jTy2
         Zqc3pFlgt8c+KSTV5zduLPhqPHTqm9gfkyvCysH6xa1+89oknQuS+eElDbUmFmD8KMrh
         LqdgCRkDyHrNAjz7w9ddfswWBa+pHef/0af1fU8iQCh2mFH4EVqfZaPFdwqgeDJ+Fce6
         x91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jT7y9MQV64dzq3CT3VGEGHQVo1FPp7ILt0fGfMfo9J8=;
        b=VrOT/Xo2RsU7nulqd9oaJMSMVeizSpvpzBrnwfmv2A0ecdVSNB8P3PEeCAsNHZxJ9a
         ywk3BBr2TRRf6h/fv18c+Jl9m1fgyDSQouKa7m7ekV1rIm8aToHQr+bnvLrYNx61EeKs
         GNKJlArqOrv50XGbIQrMEsMMfdITyeXkwpq5/tac4tT6juEt7XCTEOFSsxJjIsPnwPx5
         Zym+C8ye2uGWW1++ZxH8diwCFiJlVgbUDUva0Gq9ZdIN+Lvy3Qikn/6BsgZOEuEURTcv
         6cXjPMIG0Wv+EsCkpBmlduBXUNyL/47FiDOtUcfY8FpWiHl5zWNGxCzM4XGccKgEnfUZ
         uepA==
X-Gm-Message-State: AJcUukevZB+BOa4c7OmHMPhmbnXcff7ykQwcN6ZxYdRZ9TFZTmXoio8U
        MOI+jPSfjmwAuxJcCa/Y4ZnBgtX6s0TgzukFrs0=
X-Google-Smtp-Source: AFSGD/U6EX6A+rZ1+xQS3NjKx/grvf+nXuYZQotljv60mnxXZs3ecM82r84v6oa/uytn8isO+lYYTBr9mldECIx59bA=
X-Received: by 2002:a1c:5545:: with SMTP id j66mr40037070wmb.15.1546548093071;
 Thu, 03 Jan 2019 12:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20181219000229.10793-1-lucas.demarchi@intel.com>
 <20181219000229.10793-2-lucas.demarchi@intel.com> <xunyy38kjx94.fsf@redhat.com>
In-Reply-To: <xunyy38kjx94.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 3 Jan 2019 12:41:21 -0800
Message-ID: <CAKi4VAJ3MrSqESw0NkNxvQBoHzmMoYfjq9LQAvk9VFon0L3S4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] testsuite: add support for testing output against regex
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
> >>>>> On Tue, 18 Dec 2018 16:02:28 -0800, Lucas De Marchi  wrote:
>
>  > Allow to test outputs when they don't match exactly, but should follow
>  > some regex patterns. This can be used when the info we are printing is
>  > randomized or depends on kernel configuration.
>  > ---
>  >  testsuite/testsuite.c | 104 +++++++++++++++++++++++++++++++++++++++++-
>  >  testsuite/testsuite.h |   6 +++
>  >  2 files changed, 108 insertions(+), 2 deletions(-)
>
>  > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
>  > index 550c711..db36324 100644
>  > --- a/testsuite/testsuite.c
>  > +++ b/testsuite/testsuite.c
>  > @@ -20,6 +20,7 @@
>  >  #include <fcntl.h>
>  >  #include <getopt.h>
>  >  #include <limits.h>
>  > +#include <regex.h>
>  >  #include <stdarg.h>
>  >  #include <stdio.h>
>  >  #include <stdlib.h>
>  > @@ -293,8 +294,98 @@ static int check_activity(int fd, bool activity,  const char *path,
>  >  #define BUFSZ 4096
>  >  struct buffer {
>  >      char buf[BUFSZ];
>  > +    unsigned int head;
>  >  };
>
>  > +
>  > +static bool cmpbuf_regex_one(const char *pattern, const char *s)
>  > +{
>  > +    _cleanup_(regfree) regex_t re = { };
>  > +
>  > +    return !regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) &&
>  > +           !regexec(&re, s, 0, NULL, 0);
>  > +}
>  > +
>  > +/*
>  > + * read fd and fd_match, checking the first matches the regex of the second,
>  > + * line by line
>  > + */
>  > +static bool cmpbuf_regex(const struct test *t, const char *prefix,
>  > +                     int fd, int fd_match, struct buffer *buf,
>  > +                     struct buffer *buf_match)
>  > +{
>  > +    char *p, *p_match;
>  > +    int done = 0, done_match = 0, r;
>  > +
>  > +    r = read(fd, buf->buf + buf->head, sizeof(buf->buf) - buf->head - 1);
>
> Why do you need -1 if you are replacing existing '\n' and using
> mem* functions with explicit size?

so buf + head never points outside of the buffer and so avoid a
segfault. It could be rather replace by sanity checks on top of the
function though. I'm changing that.


>
>
>  > +    if (r <= 0)
>  > +            return true;
>  > +
>  > +    buf->head += r;
>  > +
>  > +    /*
>  > +     * Process as many lines as read from fd and that fits in the buffer -
>  > +     * it's assumed that we we get N lines from fd, we should be able to
>                           ^^^^^^^^^ extra "we"?

fixed
>
>  > +     * get the same amount from fd_match
>  > +     */
>  > +    for (;;) {
>  > +            p = memchr(buf->buf + done, '\n', buf->head - done);
>  > +            if (!p)
>  > +                    break;
>  > +            *p = 0;
>
> Would '\0' be better to emphasize the string end?

I use them interchangeably... no preference. I'll change it here though.

>
>  > +
>  > +            p_match = memchr(buf_match->buf + done_match, '\n',
>  > +                             buf_match->head - done_match);
>  > +            if (!p_match) {
>  > +                    /* pump more data from file */
>  > +                    r = read(fd_match, buf_match->buf + buf_match->head,
>  > +                             sizeof(buf_match->buf) - buf_match->head - 1);
>  > +                    if (r <= 0) {
>  > +                            ERR("could not read match fd %d\n", fd_match);
>  > +                            return false;
>  > +                    }
>  > +                    buf_match->head += r;
>  > +                    p_match = memchr(buf_match->buf + done_match, '\n',
>  > +                                     buf_match->head - done_match);
>  > +                    if (!p_match) {
>  > +                            ERR("could not find match line from fd %d\n", fd_match);
>  > +                            return false;
>  > +                    }
>  > +            }
>  > +            *p_match = 0;
>
> ditto.

fixed

Thanks,
Lucas De Marchi

>
>  > +
>  > +            if (!cmpbuf_regex_one(buf_match->buf + done_match, buf->buf + done)) {
>  > +                    ERR("Output does not match pattern on %s:\n", prefix);
>  > +                    ERR("pattern: %s\n", buf_match->buf + done_match);
>  > +                    ERR("output : %s\n", buf->buf + done);
>  > +                    return false;
>  > +            }
>  > +
>  > +            done = p - buf->buf + 1;
>  > +            done_match = p_match - buf_match->buf + 1;
>  > +    }
>  > +
>  > +    /*
>  > +     * Prepare for the next call: anything we processed we remove from the
>  > +     * buffer by memmoving the remaining bytes up to the beginning
>  > +     */
>  > +
>  > +    if (done) {
>  > +            if (buf->head - done)
>  > +                    memmove(buf->buf, buf->buf + done, buf->head - done);
>  > +            buf->head -= done;
>  > +    }
>  > +
>  > +    if (done_match) {
>  > +            if (buf_match->head - done_match)
>  > +                    memmove(buf_match->buf, buf_match->buf + done_match,
>  > +                            buf_match->head - done_match);
>  > +            buf_match->head -= done_match;
>  > +    }
>  > +
>  > +    return true;
>  > +}
>  > +
>  >  /* read fd and fd_match, checking they match exactly */
>  >  static bool cmpbuf_exact(const struct test *t, const char *prefix,
>  >                       int fd, int fd_match, struct buffer *buf,
>  > @@ -428,6 +519,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
>
>  >              for (i = 0;  i < fdcount; i++) {
>  >                      int fd = *(int *)ev[i].data.ptr;
>  > +                    bool ret;
>
>  >                      if (ev[i].events & EPOLLIN) {
>  >                              int fd_match;
>  > @@ -452,9 +544,17 @@ static bool test_run_parent_check_outputs(const struct test *t,
>
>  >                              buf_match = buf + 1;
>
>  > -                            if (!cmpbuf_exact(t, prefix,  fd, fd_match,
>  > -                                              buf, buf_match))
>  > +                            if (t->output.regex)
>  > +                                    ret = cmpbuf_regex(t, prefix, fd, fd_match,
>  > +                                                       buf, buf_match);
>  > +                            else
>  > +                                    ret = cmpbuf_exact(t, prefix,  fd, fd_match,
>  > +                                                       buf, buf_match);
>  > +
>  > +                            if (!ret) {
>  > +                                    err = -1;
>  >                                      goto out;
>  > +                            }
>  >                      } else if (ev[i].events & EPOLLHUP) {
>  >                              if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
>  >                                      ERR("could not remove fd %d from epoll: %m\n", fd);
>  > diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
>  > index 2b31483..7ed96bf 100644
>  > --- a/testsuite/testsuite.h
>  > +++ b/testsuite/testsuite.h
>  > @@ -88,6 +88,12 @@ struct test {
>  >              /* File with correct stderr */
>  >              const char *err;
>
>  > +            /*
>  > +             * whether to treat the correct files as regex to the real
>  > +             * output
>  > +             */
>  > +            bool regex;
>  > +
>  >              /*
>  >               * Vector with pair of files
>  >               * key = correct file
>  > --
>  > 2.20.0
>
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
