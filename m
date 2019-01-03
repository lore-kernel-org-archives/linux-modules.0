Return-Path: <SRS0=NEaN=PL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E2C43387
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73304217F5
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 20:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clltzIOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfACUuf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:50:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36174 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfACUue (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Jan 2019 15:50:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so34780084wrp.3
        for <linux-modules@vger.kernel.org>; Thu, 03 Jan 2019 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uhby9OZjVhLK2TnCv9fKRvGgosXJTaA964oNwUWAoVQ=;
        b=clltzIOTpsp7K9KlLWntzNvZ4xJ7KEgP7pqxOb4tyqWc+3txXvNAtTsbaTl2Wn0vK4
         Gxa01k+GLRQZzjbr73wKAiX/F8cXVPe64Zy96cVgcXYx9QwY4nYn0YQok0ZiTyILWZb6
         P3sMgPJINRJu14zkWY8GwiXMYS+e3jDiuurgt6sc2PDOFWU7HcJR8/XBGR75MuGPeS85
         lFFWdwhRIiIKGpOW5uCZAnn6Xfjm9EZtvjWB2FdpomAD8s5K2NzzQrtn+JYgaQWU+kOy
         aX6kmXpSEwAF4MLEaSCGdDKK/JP+BvcwYE2vbYSz2RGLloHOcQqNK4DS4V0Jtz8aJqp4
         gwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uhby9OZjVhLK2TnCv9fKRvGgosXJTaA964oNwUWAoVQ=;
        b=GqxX6Mo5aJKBlF4vspOz1kWRDLmO0s9Zrzwwvle2/N4tnhWadAfHCc9kEZeFI/8quC
         ayIf6o7vmNeVMlDzfJc5SE2Nk0wjT6TYrnjwrLLP5bYN4acIUN4WciamauTLfy+69ZNA
         QG/qaQgp2099U7U9Rp4Ejsq14Fm0G3oqM/JpCS8sK6isUE5b6FlQGV19+8LSi2Gdg7Qr
         vGbHPtlGeyzWnUpNQJlR3SA4jZmdLTUF1R+Nbcc87AQfP9/fflJYbyZwG4eX6SzH7fJU
         6eqwahWOxpvCS4T41NfDHWisI3ElOH1TJouPa6kRGKif6bEdhc11ioKMbS0mWPlt6zFC
         fx0w==
X-Gm-Message-State: AJcUukeQ1AaravBvbFQLgB5bpem8ZLG1W1J8L28f1fmyQSFMTPdHeMMY
        H97d9OLCOR0w9sXPv63HEfPa3qZO+KMCCpx7WBg=
X-Google-Smtp-Source: ALg8bN5IH169P7Ikq4sJxGgGX5Ijq3NT0fTogjlg7JRiToolMUwmInPQzG+/zjl3SD4Bn6vFg9vjUT2t338cDefiyuU=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr43041877wrn.264.1546548630282;
 Thu, 03 Jan 2019 12:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20181219000229.10793-1-lucas.demarchi@intel.com>
 <20181219000229.10793-2-lucas.demarchi@intel.com> <xunytvj8jx52.fsf@redhat.com>
In-Reply-To: <xunytvj8jx52.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 3 Jan 2019 12:50:18 -0800
Message-ID: <CAKi4VALMR6oF4VjTT61aiJmkFrbnZHjSwUP=JvnN7Ppkjw17bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] testsuite: add support for testing output against regex
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Dec 20, 2018 at 7:01 AM Yauheni Kaliuta
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
>
> [...]
>
>  >  struct buffer {
>  >      char buf[BUFSZ];
>  > +    unsigned int head;
>  >  };
>
> [...]
>
> I'm wondering, since you are now keeping some context, would it
> make sence to group all of it in one place?
>
> Something like:
>
> diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
> index db36324cfda3..e8b26d6bf60f 100644
> --- a/testsuite/testsuite.c
> +++ b/testsuite/testsuite.c
> @@ -273,32 +273,165 @@ static inline int test_run_child(const struct test *t, int fdout[2],
>                 return test_run_spawned(t);
>  }
>
> -static int check_activity(int fd, bool activity,  const char *path,
> -                         const char *stream)
> +#define BUFSZ 4096
> +
> +enum fd_cmp_type {
> +       FD_CMP_MONITOR,
> +       FD_CMP_OUT,
> +       FD_CMP_ERR,
> +       FD_CMP_MAX = FD_CMP_ERR,
> +};
> +
> +struct fd_cmp {
> +       enum fd_cmp_type type;
> +       int fd;
> +       int fd_match;
> +       bool activity;
> +       const char *path;
> +       const char *prefix;
> +       const char *stream_name;

maybe prefix and stream_name are redundant?

> +       char buf[BUFSZ];
> +       char buf_match[BUFSZ];
> +       unsigned int head;
> +       unsigned int head_match;
> +};

It looks like a nice abstraction to be done on top. Would you mind
sending it as a patch on top of this series?


thanks,
Lucas De Marchi

> +
> +static int fd_cmp_check_activity(struct fd_cmp *fd_cmp)
>  {
>         struct stat st;
>
>         /* not monitoring or monitoring and it has activity */
> -       if (fd < 0 || activity)
> +       if (fd_cmp == NULL || fd_cmp->fd < 0 || fd_cmp->activity)
>                 return 0;
>
>         /* monitoring, there was no activity and size matches */
> -       if (stat(path, &st) == 0 && st.st_size == 0)
> +       if (stat(fd_cmp->path, &st) == 0 && st.st_size == 0)
>                 return 0;
>
> -       ERR("Expecting output on %s, but test didn't produce any\n", stream);
> +       ERR("Expecting output on %s, but test didn't produce any\n",
> +           fd_cmp->stream_name);
>
>         return -1;
>  }
>
> -#define BUFSZ 4096
> -struct buffer {
> -       char buf[BUFSZ];
> -       unsigned int head;
> -};
> +static bool fd_cmp_is_active(struct fd_cmp *fd_cmp)
> +{
> +       return fd_cmp->fd != -1;
> +}
> +
> +static int fd_cmp_open_monitor(struct fd_cmp *fd_cmp, int fd, int fd_ep)
> +{
> +       struct epoll_event ep = {};
> +
> +       ep.events = EPOLLHUP;
> +       ep.data.ptr = fd_cmp;
> +       if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fd, &ep) < 0) {
> +               ERR("could not add monitor fd to epoll: %m\n");
> +               return -errno;
> +       }
> +
> +       return 0;
> +}
> +
> +static int fd_cmp_open_std(struct fd_cmp *fd_cmp,
> +                          const char *fn, int fd, int fd_ep)
> +{
> +       struct epoll_event ep = {};
> +       int fd_match;
> +
> +       fd_match = open(fn, O_RDONLY);
> +       if (fd_match < 0) {
> +               ERR("could not open %s for read: %m\n", fn);
> +               return -errno;
> +       }
> +       ep.events = EPOLLIN;
> +       ep.data.ptr = fd_cmp;
> +       if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fd, &ep) < 0) {
> +               ERR("could not add fd to epoll: %m\n");
> +               close(fd_match);
> +               return -errno;
> +       }
> +
> +       return fd_match;
> +}
> +
> +/* opens output file AND adds descriptor to epoll */
> +static int fd_cmp_open(struct fd_cmp **fd_cmp_out,
> +                      enum fd_cmp_type type, const char *fn, int fd,
> +                      int fd_ep)
> +{
> +       int err = 0;
> +       struct fd_cmp *fd_cmp;
> +
> +       fd_cmp = calloc(1, sizeof(*fd_cmp));
> +       if (fd_cmp == NULL) {
> +               ERR("could not allocate fd_cmp\n");
> +               return -ENOMEM;
> +       }
> +
> +       switch (type) {
> +       case FD_CMP_MONITOR:
> +               err = fd_cmp_open_monitor(fd_cmp, fd, fd_ep);
> +               break;
> +       case FD_CMP_OUT:
> +               fd_cmp->prefix = "STDOUT";
> +               fd_cmp->stream_name = "stdout";
> +               err = fd_cmp_open_std(fd_cmp, fn, fd, fd_ep);
> +               break;
> +       case FD_CMP_ERR:
> +               fd_cmp->prefix = "STDERR";
> +               fd_cmp->stream_name = "stderr";
> +               err = fd_cmp_open_std(fd_cmp, fn, fd, fd_ep);
> +               break;
> +       default:
> +               ERR("unknown fd type %d\n", type);
> +               err = -1;
> +       }
>
> +       if (err < 0) {
> +               free(fd_cmp);
> +               return err;
> +       }
> +
> +       fd_cmp->fd_match = err;
> +       fd_cmp->fd = fd;
> +       fd_cmp->type = type;
> +       fd_cmp->path = fn;
> +
> +       *fd_cmp_out = fd_cmp;
> +       return 0;
> +}
> +
> +static int fd_cmp_check_ev_in(struct fd_cmp *fd_cmp)
> +{
> +       if (fd_cmp->type == FD_CMP_MONITOR) {
> +               ERR("Unexpected activity on monitor pipe\n");
> +               return -EINVAL;
> +       }
> +       fd_cmp->activity = true;
> +
> +       return 0;
> +}
> +
> +static void fd_cmp_delete_ep(struct fd_cmp *fd_cmp, int fd_ep)
> +{
> +       if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd_cmp->fd, NULL) < 0) {
> +               ERR("could not remove fd %d from epoll: %m\n", fd_cmp->fd);
> +       }
> +       fd_cmp->fd = -1;
> +}
> +
> +static void fd_cmp_close(struct fd_cmp *fd_cmp)
> +{
> +       if (fd_cmp == NULL)
> +               return;
> +
> +       if (fd_cmp->fd >= 0)
> +               close(fd_cmp->fd);
> +       free(fd_cmp);
> +}
>
> -static bool cmpbuf_regex_one(const char *pattern, const char *s)
> +static bool fd_cmp_regex_one(const char *pattern, const char *s)
>  {
>         _cleanup_(regfree) regex_t re = { };
>
> @@ -310,18 +443,17 @@ static bool cmpbuf_regex_one(const char *pattern, const char *s)
>   * read fd and fd_match, checking the first matches the regex of the second,
>   * line by line
>   */
> -static bool cmpbuf_regex(const struct test *t, const char *prefix,
> -                        int fd, int fd_match, struct buffer *buf,
> -                        struct buffer *buf_match)
> +static bool fd_cmp_regex(struct fd_cmp *fd_cmp, const struct test *t)
>  {
>         char *p, *p_match;
>         int done = 0, done_match = 0, r;
>
> -       r = read(fd, buf->buf + buf->head, sizeof(buf->buf) - buf->head - 1);
> +       r = read(fd_cmp->fd, fd_cmp->buf + fd_cmp->head,
> +                sizeof(fd_cmp->buf) - fd_cmp->head - 1);
>         if (r <= 0)
>                 return true;
>
> -       buf->head += r;
> +       fd_cmp->head += r;
>
>         /*
>          * Process as many lines as read from fd and that fits in the buffer -
> @@ -329,40 +461,40 @@ static bool cmpbuf_regex(const struct test *t, const char *prefix,
>          * get the same amount from fd_match
>          */
>         for (;;) {
> -               p = memchr(buf->buf + done, '\n', buf->head - done);
> +               p = memchr(fd_cmp->buf + done, '\n', fd_cmp->head - done);
>                 if (!p)
>                         break;
>                 *p = 0;
>
> -               p_match = memchr(buf_match->buf + done_match, '\n',
> -                                buf_match->head - done_match);
> +               p_match = memchr(fd_cmp->buf_match + done_match, '\n',
> +                                fd_cmp->head_match - done_match);
>                 if (!p_match) {
>                         /* pump more data from file */
> -                       r = read(fd_match, buf_match->buf + buf_match->head,
> -                                sizeof(buf_match->buf) - buf_match->head - 1);
> +                       r = read(fd_cmp->fd_match, fd_cmp->buf_match + fd_cmp->head_match,
> +                                sizeof(fd_cmp->buf_match) - fd_cmp->head_match - 1);
>                         if (r <= 0) {
> -                               ERR("could not read match fd %d\n", fd_match);
> +                               ERR("could not read match fd %d\n", fd_cmp->fd_match);
>                                 return false;
>                         }
> -                       buf_match->head += r;
> -                       p_match = memchr(buf_match->buf + done_match, '\n',
> -                                        buf_match->head - done_match);
> +                       fd_cmp->head_match += r;
> +                       p_match = memchr(fd_cmp->buf_match + done_match, '\n',
> +                                        fd_cmp->head_match - done_match);
>                         if (!p_match) {
> -                               ERR("could not find match line from fd %d\n", fd_match);
> +                               ERR("could not find match line from fd %d\n", fd_cmp->fd_match);
>                                 return false;
>                         }
>                 }
>                 *p_match = 0;
>
> -               if (!cmpbuf_regex_one(buf_match->buf + done_match, buf->buf + done)) {
> -                       ERR("Output does not match pattern on %s:\n", prefix);
> -                       ERR("pattern: %s\n", buf_match->buf + done_match);
> -                       ERR("output : %s\n", buf->buf + done);
> +               if (!fd_cmp_regex_one(fd_cmp->buf_match + done_match, fd_cmp->buf + done)) {
> +                       ERR("Output does not match pattern on %s:\n", fd_cmp->prefix);
> +                       ERR("pattern: %s\n", fd_cmp->buf_match + done_match);
> +                       ERR("output : %s\n", fd_cmp->buf + done);
>                         return false;
>                 }
>
> -               done = p - buf->buf + 1;
> -               done_match = p_match - buf_match->buf + 1;
> +               done = p - fd_cmp->buf + 1;
> +               done_match = p_match - fd_cmp->buf_match + 1;
>         }
>
>         /*
> @@ -371,59 +503,57 @@ static bool cmpbuf_regex(const struct test *t, const char *prefix,
>          */
>
>         if (done) {
> -               if (buf->head - done)
> -                       memmove(buf->buf, buf->buf + done, buf->head - done);
> -               buf->head -= done;
> +               if (fd_cmp->head - done)
> +                       memmove(fd_cmp->buf, fd_cmp->buf + done, fd_cmp->head - done);
> +               fd_cmp->head -= done;
>         }
>
>         if (done_match) {
> -               if (buf_match->head - done_match)
> -                       memmove(buf_match->buf, buf_match->buf + done_match,
> -                               buf_match->head - done_match);
> -               buf_match->head -= done_match;
> +               if (fd_cmp->head_match - done_match)
> +                       memmove(fd_cmp->buf_match, fd_cmp->buf_match + done_match,
> +                               fd_cmp->head_match - done_match);
> +               fd_cmp->head_match -= done_match;
>         }
>
>         return true;
>  }
>
>  /* read fd and fd_match, checking they match exactly */
> -static bool cmpbuf_exact(const struct test *t, const char *prefix,
> -                        int fd, int fd_match, struct buffer *buf,
> -                        struct buffer *buf_match)
> +static bool fd_cmp_exact(struct fd_cmp *fd_cmp, const struct test *t)
>  {
>         int r, rmatch, done = 0;
>
> -       r = read(fd, buf, sizeof(buf->buf) - 1);
> +       r = read(fd_cmp->fd, fd_cmp->buf, sizeof(fd_cmp->buf) - 1);
>         if (r <= 0)
>                 /* try again later */
>                 return true;
>
>         /* read as much data from fd_match as we read from fd */
>         for (;;) {
> -               rmatch = read(fd_match, buf_match->buf + done, r - done);
> +               rmatch = read(fd_cmp->fd_match, fd_cmp->buf_match + done, r - done);
>                 if (rmatch == 0)
>                         break;
>
>                 if (rmatch < 0) {
>                         if (errno == EINTR)
>                                 continue;
> -                       ERR("could not read match fd %d\n", fd_match);
> +                       ERR("could not read match fd %d\n", fd_cmp->fd_match);
>                         return false;
>                 }
>
>                 done += rmatch;
>         }
>
> -       buf->buf[r] = '\0';
> -       buf_match->buf[r] = '\0';
> +       fd_cmp->buf[r] = '\0';
> +       fd_cmp->buf_match[r] = '\0';
>
>         if (t->print_outputs)
> -               printf("%s: %s\n", prefix, buf->buf);
> +               printf("%s: %s\n", fd_cmp->prefix, fd_cmp->buf);
>
> -       if (!streq(buf->buf, buf_match->buf)) {
> -               ERR("Outputs do not match on %s:\n", prefix);
> -               ERR("correct:\n%s\n", buf_match->buf);
> -               ERR("wrong:\n%s\n", buf->buf);
> +       if (!streq(fd_cmp->buf, fd_cmp->buf_match)) {
> +               ERR("Outputs do not match on %s:\n", fd_cmp->prefix);
> +               ERR("correct:\n%s\n", fd_cmp->buf_match);
> +               ERR("wrong:\n%s\n", fd_cmp->buf);
>                 return false;
>         }
>
> @@ -434,11 +564,12 @@ static bool test_run_parent_check_outputs(const struct test *t,
>                                           int fdout, int fderr, int fdmonitor,
>                                           pid_t child)
>  {
> -       struct epoll_event ep_outpipe, ep_errpipe, ep_monitor;
> -       int err, fd_ep, fd_matchout = -1, fd_matcherr = -1;
> -       bool fd_activityout = false, fd_activityerr = false;
> +       int err, fd_ep;
>         unsigned long long end_usec, start_usec;
> -       _cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
> +       struct fd_cmp *fd_cmp_out = NULL;
> +       struct fd_cmp *fd_cmp_err = NULL;
> +       struct fd_cmp *fd_cmp_monitor = NULL;
> +       int n_fd = 0;
>
>         fd_ep = epoll_create1(EPOLL_CLOEXEC);
>         if (fd_ep < 0) {
> @@ -447,59 +578,30 @@ static bool test_run_parent_check_outputs(const struct test *t,
>         }
>
>         if (t->output.out != NULL) {
> -               fd_matchout = open(t->output.out, O_RDONLY);
> -               if (fd_matchout < 0) {
> -                       err = -errno;
> -                       ERR("could not open %s for read: %m\n",
> -                                                       t->output.out);
> -                       goto out;
> -               }
> -               memset(&ep_outpipe, 0, sizeof(struct epoll_event));
> -               ep_outpipe.events = EPOLLIN;
> -               ep_outpipe.data.ptr = &fdout;
> -               if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fdout, &ep_outpipe) < 0) {
> -                       err = -errno;
> -                       ERR("could not add fd to epoll: %m\n");
> +               err = fd_cmp_open(&fd_cmp_out,
> +                                 FD_CMP_OUT, t->output.out, fdout, fd_ep);
> +               if (err < 0)
>                         goto out;
> -               }
> -               buf_out = calloc(2, sizeof(*buf_out));
> -       } else
> -               fdout = -1;
> +               n_fd++;
> +       }
>
>         if (t->output.err != NULL) {
> -               fd_matcherr = open(t->output.err, O_RDONLY);
> -               if (fd_matcherr < 0) {
> -                       err = -errno;
> -                       ERR("could not open %s for read: %m\n",
> -                                       t->output.err);
> +               err = fd_cmp_open(&fd_cmp_err,
> +                                 FD_CMP_ERR, t->output.err, fderr, fd_ep);
> +               if (err < 0)
>                         goto out;
> +               n_fd++;
> +       }
>
> -               }
> -               memset(&ep_errpipe, 0, sizeof(struct epoll_event));
> -               ep_errpipe.events = EPOLLIN;
> -               ep_errpipe.data.ptr = &fderr;
> -               if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fderr, &ep_errpipe) < 0) {
> -                       err = -errno;
> -                       ERR("could not add fd to epoll: %m\n");
> -                       goto out;
> -               }
> -               buf_err = calloc(2, sizeof(*buf_err));
> -       } else
> -               fderr = -1;
> -
> -       memset(&ep_monitor, 0, sizeof(struct epoll_event));
> -       ep_monitor.events = EPOLLHUP;
> -       ep_monitor.data.ptr = &fdmonitor;
> -       if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fdmonitor, &ep_monitor) < 0) {
> -               err = -errno;
> -               ERR("could not add monitor fd to epoll: %m\n");
> +       err = fd_cmp_open(&fd_cmp_monitor, FD_CMP_MONITOR, NULL, fdmonitor, fd_ep);
> +       if (err < 0)
>                 goto out;
> -       }
> +       n_fd++;
>
>         start_usec = now_usec();
>         end_usec = start_usec + TEST_TIMEOUT_USEC;
>
> -       for (err = 0; fdmonitor >= 0 || fdout >= 0 || fderr >= 0;) {
> +       for (err = 0; n_fd > 0;) {
>                 int fdcount, i, timeout;
>                 struct epoll_event ev[4];
>                 unsigned long long curr_usec = now_usec();
> @@ -518,68 +620,45 @@ static bool test_run_parent_check_outputs(const struct test *t,
>                 }
>
>                 for (i = 0;  i < fdcount; i++) {
> -                       int fd = *(int *)ev[i].data.ptr;
> +                       struct fd_cmp *fd_cmp = ev[i].data.ptr;
>                         bool ret;
>
>                         if (ev[i].events & EPOLLIN) {
> -                               int fd_match;
> -                               struct buffer *buf, *buf_match;
> -                               const char *prefix;
> -
> -                               if (fd == fdout) {
> -                                       fd_match = fd_matchout;
> -                                       buf = buf_out;
> -                                       fd_activityout = true;
> -                                       prefix = "STDOUT";
> -                               } else if (fd == fderr) {
> -                                       fd_match = fd_matcherr;
> -                                       buf = buf_err;
> -                                       fd_activityerr = true;
> -                                       prefix = "STDERR";
> -                               } else {
> -                                       ERR("Unexpected activity on monitor pipe\n");
> -                                       err = -EINVAL;
> +                               err = fd_cmp_check_ev_in(fd_cmp);
> +                               if (err < 0)
>                                         goto out;
> -                               }
> -
> -                               buf_match = buf + 1;
>
>                                 if (t->output.regex)
> -                                       ret = cmpbuf_regex(t, prefix, fd, fd_match,
> -                                                          buf, buf_match);
> +                                       ret = fd_cmp_regex(fd_cmp, t);
>                                 else
> -                                       ret = cmpbuf_exact(t, prefix,  fd, fd_match,
> -                                                          buf, buf_match);
> +                                       ret = fd_cmp_exact(fd_cmp, t);
>
>                                 if (!ret) {
>                                         err = -1;
>                                         goto out;
>                                 }
>                         } else if (ev[i].events & EPOLLHUP) {
> -                               if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
> -                                       ERR("could not remove fd %d from epoll: %m\n", fd);
> -                               }
> -                               *(int *)ev[i].data.ptr = -1;
> +                               fd_cmp_delete_ep(fd_cmp, fd_ep);
> +                               n_fd--;
>                         }
>                 }
>         }
>
> -       err = check_activity(fd_matchout, fd_activityout, t->output.out, "stdout");
> -       err |= check_activity(fd_matcherr, fd_activityerr, t->output.err, "stderr");
> +       err = fd_cmp_check_activity(fd_cmp_out);
> +       err |= fd_cmp_check_activity(fd_cmp_err);
>
> -       if (err == 0 && fdmonitor >= 0) {
> +       if (err == 0 && fd_cmp_is_active(fd_cmp_monitor)) {
>                 err = -EINVAL;
>                 ERR("Test '%s' timed out, killing %d\n", t->name, child);
>                 kill(child, SIGKILL);
>         }
>
>  out:
> -       if (fd_matchout >= 0)
> -               close(fd_matchout);
> -       if (fd_matcherr >= 0)
> -               close(fd_matcherr);
> -       if (fd_ep >= 0)
> -               close(fd_ep);
> +       fd_cmp_close(fd_cmp_out);
> +       fd_cmp_close(fd_cmp_err);
> +       fd_cmp_close(fd_cmp_monitor);
> +       close(fd_ep);
> +
>         return err == 0;
>  }
>
>
>
>
> --
> WBR,
> Yauheni Kaliuta



-- 
Lucas De Marchi
