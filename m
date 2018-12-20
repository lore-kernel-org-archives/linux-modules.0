Return-Path: <SRS0=e041=O5=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8359C43387
	for <linux-modules@archiver.kernel.org>; Thu, 20 Dec 2018 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F98E21773
	for <linux-modules@archiver.kernel.org>; Thu, 20 Dec 2018 10:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeLTKlp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLTKlp (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 20 Dec 2018 05:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A14B3C2CEB;
        Thu, 20 Dec 2018 10:41:45 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-136.ams2.redhat.com [10.36.117.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6900D6FEC0;
        Thu, 20 Dec 2018 10:41:44 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/3] testsuite: add support for testing output against regex
References: <20181219000229.10793-1-lucas.demarchi@intel.com>
        <20181219000229.10793-2-lucas.demarchi@intel.com>
Date:   Thu, 20 Dec 2018 12:41:43 +0200
In-Reply-To: <20181219000229.10793-2-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Tue, 18 Dec 2018 16:02:28 -0800")
Message-ID: <xunyy38kjx94.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 10:41:45 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 18 Dec 2018 16:02:28 -0800, Lucas De Marchi  wrote:

 > Allow to test outputs when they don't match exactly, but should follow
 > some regex patterns. This can be used when the info we are printing is
 > randomized or depends on kernel configuration.
 > ---
 >  testsuite/testsuite.c | 104 +++++++++++++++++++++++++++++++++++++++++-
 >  testsuite/testsuite.h |   6 +++
 >  2 files changed, 108 insertions(+), 2 deletions(-)

 > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
 > index 550c711..db36324 100644
 > --- a/testsuite/testsuite.c
 > +++ b/testsuite/testsuite.c
 > @@ -20,6 +20,7 @@
 >  #include <fcntl.h>
 >  #include <getopt.h>
 >  #include <limits.h>
 > +#include <regex.h>
 >  #include <stdarg.h>
 >  #include <stdio.h>
 >  #include <stdlib.h>
 > @@ -293,8 +294,98 @@ static int check_activity(int fd, bool activity,  const char *path,
 >  #define BUFSZ 4096
 >  struct buffer {
 >  	char buf[BUFSZ];
 > +	unsigned int head;
 >  };
 
 > +
 > +static bool cmpbuf_regex_one(const char *pattern, const char *s)
 > +{
 > +	_cleanup_(regfree) regex_t re = { };
 > +
 > +	return !regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) &&
 > +	       !regexec(&re, s, 0, NULL, 0);
 > +}
 > +
 > +/*
 > + * read fd and fd_match, checking the first matches the regex of the second,
 > + * line by line
 > + */
 > +static bool cmpbuf_regex(const struct test *t, const char *prefix,
 > +			 int fd, int fd_match, struct buffer *buf,
 > +			 struct buffer *buf_match)
 > +{
 > +	char *p, *p_match;
 > +	int done = 0, done_match = 0, r;
 > +
 > +	r = read(fd, buf->buf + buf->head, sizeof(buf->buf) - buf->head - 1);

Why do you need -1 if you are replacing existing '\n' and using
mem* functions with explicit size?


 > +	if (r <= 0)
 > +		return true;
 > +
 > +	buf->head += r;
 > +
 > +	/*
 > +	 * Process as many lines as read from fd and that fits in the buffer -
 > +	 * it's assumed that we we get N lines from fd, we should be able to
                          ^^^^^^^^^ extra "we"?

 > +	 * get the same amount from fd_match
 > +	 */
 > +	for (;;) {
 > +		p = memchr(buf->buf + done, '\n', buf->head - done);
 > +		if (!p)
 > +			break;
 > +		*p = 0;

Would '\0' be better to emphasize the string end?

 > +
 > +		p_match = memchr(buf_match->buf + done_match, '\n',
 > +				 buf_match->head - done_match);
 > +		if (!p_match) {
 > +			/* pump more data from file */
 > +			r = read(fd_match, buf_match->buf + buf_match->head,
 > +				 sizeof(buf_match->buf) - buf_match->head - 1);
 > +			if (r <= 0) {
 > +				ERR("could not read match fd %d\n", fd_match);
 > +				return false;
 > +			}
 > +			buf_match->head += r;
 > +			p_match = memchr(buf_match->buf + done_match, '\n',
 > +					 buf_match->head - done_match);
 > +			if (!p_match) {
 > +				ERR("could not find match line from fd %d\n", fd_match);
 > +				return false;
 > +			}
 > +		}
 > +		*p_match = 0;

ditto.

 > +
 > +		if (!cmpbuf_regex_one(buf_match->buf + done_match, buf->buf + done)) {
 > +			ERR("Output does not match pattern on %s:\n", prefix);
 > +			ERR("pattern: %s\n", buf_match->buf + done_match);
 > +			ERR("output : %s\n", buf->buf + done);
 > +			return false;
 > +		}
 > +
 > +		done = p - buf->buf + 1;
 > +		done_match = p_match - buf_match->buf + 1;
 > +	}
 > +
 > +	/*
 > +	 * Prepare for the next call: anything we processed we remove from the
 > +	 * buffer by memmoving the remaining bytes up to the beginning
 > +	 */
 > +
 > +	if (done) {
 > +		if (buf->head - done)
 > +			memmove(buf->buf, buf->buf + done, buf->head - done);
 > +		buf->head -= done;
 > +	}
 > +
 > +	if (done_match) {
 > +		if (buf_match->head - done_match)
 > +			memmove(buf_match->buf, buf_match->buf + done_match,
 > +				buf_match->head - done_match);
 > +		buf_match->head -= done_match;
 > +	}
 > +
 > +	return true;
 > +}
 > +
 >  /* read fd and fd_match, checking they match exactly */
 >  static bool cmpbuf_exact(const struct test *t, const char *prefix,
 >  			 int fd, int fd_match, struct buffer *buf,
 > @@ -428,6 +519,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 
 >  		for (i = 0;  i < fdcount; i++) {
 >  			int fd = *(int *)ev[i].data.ptr;
 > +			bool ret;
 
 >  			if (ev[i].events & EPOLLIN) {
 >  				int fd_match;
 > @@ -452,9 +544,17 @@ static bool test_run_parent_check_outputs(const struct test *t,
 
 >  				buf_match = buf + 1;
 
 > -				if (!cmpbuf_exact(t, prefix,  fd, fd_match,
 > -						  buf, buf_match))
 > +				if (t->output.regex)
 > +					ret = cmpbuf_regex(t, prefix, fd, fd_match,
 > +							   buf, buf_match);
 > +				else
 > +					ret = cmpbuf_exact(t, prefix,  fd, fd_match,
 > +							   buf, buf_match);
 > +
 > +				if (!ret) {
 > +					err = -1;
 >  					goto out;
 > +				}
 >  			} else if (ev[i].events & EPOLLHUP) {
 >  				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
 >  					ERR("could not remove fd %d from epoll: %m\n", fd);
 > diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
 > index 2b31483..7ed96bf 100644
 > --- a/testsuite/testsuite.h
 > +++ b/testsuite/testsuite.h
 > @@ -88,6 +88,12 @@ struct test {
 >  		/* File with correct stderr */
 >  		const char *err;
 
 > +		/*
 > +		 * whether to treat the correct files as regex to the real
 > +		 * output
 > +		 */
 > +		bool regex;
 > +
 >  		/*
 >  		 * Vector with pair of files
 >  		 * key = correct file
 > -- 
 > 2.20.0


-- 
WBR,
Yauheni Kaliuta
