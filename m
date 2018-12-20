Return-Path: <SRS0=e041=O5=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50698C43387
	for <linux-modules@archiver.kernel.org>; Thu, 20 Dec 2018 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E88121773
	for <linux-modules@archiver.kernel.org>; Thu, 20 Dec 2018 10:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbeLTKih (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbeLTKih (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 20 Dec 2018 05:38:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC11613AA0;
        Thu, 20 Dec 2018 10:38:36 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-136.ams2.redhat.com [10.36.117.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9DD4103BAB8;
        Thu, 20 Dec 2018 10:38:35 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/3] testsuite: split out function to compare outputs exactly
References: <20181219000229.10793-1-lucas.demarchi@intel.com>
Date:   Thu, 20 Dec 2018 12:38:35 +0200
In-Reply-To: <20181219000229.10793-1-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Tue, 18 Dec 2018 16:02:27 -0800")
Message-ID: <xuny36qslbys.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 10:38:36 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 18 Dec 2018 16:02:27 -0800, Lucas De Marchi  wrote:

 > Move functionality to compare the exact output to a separate function
 > and allocate one buffer per output/match pair. This will allow us to
 > extend this to allow other types of comparisons.
 > ---
 >  testsuite/testsuite.c | 124 ++++++++++++++++++++++++------------------
 >  1 file changed, 70 insertions(+), 54 deletions(-)

 > diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
 > index 8512b56..550c711 100644
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

Not so clear (either from description) without the next patch,
why the buffers are not local for the function.

 > +	int r, rmatch, done = 0;
 > +
 > +	r = read(fd, buf, sizeof(buf->buf) - 1);

                     buf->buf?

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
