Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CBAC43387
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DAD218CD
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 16:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfADQMK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:12:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfADQMJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 11:12:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67727C7051;
        Fri,  4 Jan 2019 16:12:09 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B6960BE8;
        Fri,  4 Jan 2019 16:12:08 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/3] testsuite: split out function to compare outputs exactly
References: <20190103210746.20048-1-lucas.demarchi@intel.com>
Date:   Fri, 04 Jan 2019 18:12:19 +0200
In-Reply-To: <20190103210746.20048-1-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Thu, 3 Jan 2019 13:07:44 -0800")
Message-ID: <xuny1s5sjtb0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 04 Jan 2019 16:12:09 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

Just in case, ACK.

>>>>> On Thu,  3 Jan 2019 13:07:44 -0800, Lucas De Marchi  wrote:

 > Move functionality to compare the exact output to a separate function
 > and allocate one buffer per output/match pair. This will allow us to
 > extend this to allow other types of comparisons. Since now we are using
 > heap-allocated buffer, keep the buffer allocation to the caller, so we
 > don't have to allocate and free it on every invocation. It also avoids
 > the different comparison functions to have to deal with it.
 > ---
 >  testsuite/testsuite.c | 124 ++++++++++++++++++++++++------------------
 >  1 file changed, 70 insertions(+), 54 deletions(-)

 > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
 > index 8512b56..508bbd3 100644
 > --- a/testsuite/testsuite.c
 > +++ b/testsuite/testsuite.c
 > @@ -290,13 +290,64 @@ static int check_activity(int fd, bool activity,  const char *path,
 >  	return -1;
 >  }
 
 > -static inline bool test_run_parent_check_outputs(const struct test *t,
 > -			int fdout, int fderr, int fdmonitor, pid_t child)
 > +#define BUFSZ 4096
 > +struct buffer {
 > +	char buf[BUFSZ];
 > +};
 > +
 > +/* read fd and fd_match, checking they match exactly */
 > +static bool cmpbuf_exact(const struct test *t, const char *prefix,
 > +			 int fd, int fd_match, struct buffer *buf,
 > +			 struct buffer *buf_match)
 > +{
 > +	int r, rmatch, done = 0;
 > +
 > +	r = read(fd, buf->buf, sizeof(buf->buf) - 1);
 > +	if (r <= 0)
 > +		/* try again later */
 > +		return true;
 > +
 > +	/* read as much data from fd_match as we read from fd */
 > +	for (;;) {
 > +		rmatch = read(fd_match, buf_match->buf + done, r - done);
 > +		if (rmatch == 0)
 > +			break;
 > +
 > +		if (rmatch < 0) {
 > +			if (errno == EINTR)
 > +				continue;
 > +			ERR("could not read match fd %d\n", fd_match);
 > +			return false;
 > +		}
 > +
 > +		done += rmatch;
 > +	}
 > +
 > +	buf->buf[r] = '\0';
 > +	buf_match->buf[r] = '\0';
 > +
 > +	if (t->print_outputs)
 > +		printf("%s: %s\n", prefix, buf->buf);
 > +
 > +	if (!streq(buf->buf, buf_match->buf)) {
 > +		ERR("Outputs do not match on %s:\n", prefix);
 > +		ERR("correct:\n%s\n", buf_match->buf);
 > +		ERR("wrong:\n%s\n", buf->buf);
 > +		return false;
 > +	}
 > +
 > +	return true;
 > +}
 > +
 > +static bool test_run_parent_check_outputs(const struct test *t,
 > +					  int fdout, int fderr, int fdmonitor,
 > +					  pid_t child)
 >  {
 >  	struct epoll_event ep_outpipe, ep_errpipe, ep_monitor;
 >  	int err, fd_ep, fd_matchout = -1, fd_matcherr = -1;
 >  	bool fd_activityout = false, fd_activityerr = false;
 >  	unsigned long long end_usec, start_usec;
 > +	_cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
 
 >  	fd_ep = epoll_create1(EPOLL_CLOEXEC);
 >  	if (fd_ep < 0) {
 > @@ -320,6 +371,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 >  			ERR("could not add fd to epoll: %m\n");
 >  			goto out;
 >  		}
 > +		buf_out = calloc(2, sizeof(*buf_out));
 >  	} else
 >  		fdout = -1;
 
 > @@ -340,6 +392,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 >  			ERR("could not add fd to epoll: %m\n");
 >  			goto out;
 >  		}
 > +		buf_err = calloc(2, sizeof(*buf_err));
 >  	} else
 >  		fderr = -1;
 
 > @@ -374,76 +427,39 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 >  		}
 
 >  		for (i = 0;  i < fdcount; i++) {
 > -			int *fd = ev[i].data.ptr;
 > +			int fd = *(int *)ev[i].data.ptr;
 
 >  			if (ev[i].events & EPOLLIN) {
 > -				ssize_t r, done = 0;
 > -				char buf[4096];
 > -				char bufmatch[4096];
 >  				int fd_match;
 > +				struct buffer *buf, *buf_match;
 > +				const char *prefix;
 
 > -				/*
 > -				 * compare the output from child with the one
 > -				 * saved as correct
 > -				 */
 > -
 > -				r = read(*fd, buf, sizeof(buf) - 1);
 > -				if (r <= 0)
 > -					continue;
 > -
 > -				if (*fd == fdout) {
 > +				if (fd == fdout) {
 >  					fd_match = fd_matchout;
 > +					buf = buf_out;
 >  					fd_activityout = true;
 > -				} else if (*fd == fderr) {
 > +					prefix = "STDOUT";
 > +				} else if (fd == fderr) {
 >  					fd_match = fd_matcherr;
 > +					buf = buf_err;
 >  					fd_activityerr = true;
 > +					prefix = "STDERR";
 >  				} else {
 >  					ERR("Unexpected activity on monitor pipe\n");
 >  					err = -EINVAL;
 >  					goto out;
 >  				}
 
 > -				for (;;) {
 > -					int rmatch = read(fd_match,
 > -						bufmatch + done, r - done);
 > -					if (rmatch == 0)
 > -						break;
 > -
 > -					if (rmatch < 0) {
 > -						if (errno == EINTR)
 > -							continue;
 > -						err = -errno;
 > -						ERR("could not read match fd %d\n",
 > -								fd_match);
 > -						goto out;
 > -					}
 > -
 > -					done += rmatch;
 > -				}
 > +				buf_match = buf + 1;
 
 > -				buf[r] = '\0';
 > -				bufmatch[r] = '\0';
 > -
 > -				if (t->print_outputs)
 > -					printf("%s: %s\n",
 > -					       fd_match == fd_matchout ? "STDOUT:" : "STDERR:",
 > -					       buf);
 > -
 > -				if (!streq(buf, bufmatch)) {
 > -					ERR("Outputs do not match on %s:\n",
 > -						fd_match == fd_matchout ? "STDOUT" : "STDERR");
 > -					ERR("correct:\n%s\n", bufmatch);
 > -					ERR("wrong:\n%s\n", buf);
 > -					err = -1;
 > +				if (!cmpbuf_exact(t, prefix,  fd, fd_match,
 > +						  buf, buf_match))
 >  					goto out;
 > -				}
 >  			} else if (ev[i].events & EPOLLHUP) {
 > -				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL,
 > -							*fd, NULL) < 0) {
 > -					ERR("could not remove fd %d from epoll: %m\n",
 > -									*fd);
 > +				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
 > +					ERR("could not remove fd %d from epoll: %m\n", fd);
 >  				}
 > -				*fd = -1;
 > +				*(int *)ev[i].data.ptr = -1;
 >  			}
 >  		}
 >  	}
 > -- 
 > 2.20.0


-- 
WBR,
Yauheni Kaliuta
