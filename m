Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A83C43612
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379C21872
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfADVlc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfADVl2 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 16:41:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F90EC057F33;
        Fri,  4 Jan 2019 21:41:27 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 419F819C7C;
        Fri,  4 Jan 2019 21:41:26 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod 2/2] testsuite: factor out fd related parameters to a structure
Date:   Fri,  4 Jan 2019 23:41:34 +0200
Message-Id: <20190104214134.23971-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
References: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 04 Jan 2019 21:41:27 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is a more abstract implementation of "file descriptor
comparation". With the current implementation the code is full of
conditions based on the descriptor type. It makes sense to
initialize the parameters once based on the descriptor type.

stdout and stderr are handled in almost the same way, but for
monitor descriptor branch, based on the type check is necessary in
some cases.

Since epoll's context now contains pointers to the structures, so no
direct manipulations there.

Most of the patch is just replacing direct buffer manipulations with
the structures' ones.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 testsuite/testsuite.c | 357 +++++++++++++++++++++++++-----------------
 1 file changed, 214 insertions(+), 143 deletions(-)

diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 81b54ad1a48d..e46f3d8b215a 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -273,32 +273,162 @@ static inline int test_run_child(const struct test *t, int fdout[2],
 		return test_run_spawned(t);
 }
 
-static int check_activity(int fd, bool activity,  const char *path,
-			  const char *stream)
+#define BUFSZ 4096
+
+enum fd_cmp_type {
+	FD_CMP_MONITOR,
+	FD_CMP_OUT,
+	FD_CMP_ERR,
+	FD_CMP_MAX = FD_CMP_ERR,
+};
+
+struct fd_cmp {
+	enum fd_cmp_type type;
+	int fd;
+	int fd_match;
+	bool activity;
+	const char *path;
+	const char *name;
+	char buf[BUFSZ];
+	char buf_match[BUFSZ];
+	unsigned int head;
+	unsigned int head_match;
+};
+
+static int fd_cmp_check_activity(struct fd_cmp *fd_cmp)
 {
 	struct stat st;
 
 	/* not monitoring or monitoring and it has activity */
-	if (fd < 0 || activity)
+	if (fd_cmp == NULL || fd_cmp->fd < 0 || fd_cmp->activity)
 		return 0;
 
 	/* monitoring, there was no activity and size matches */
-	if (stat(path, &st) == 0 && st.st_size == 0)
+	if (stat(fd_cmp->path, &st) == 0 && st.st_size == 0)
 		return 0;
 
-	ERR("Expecting output on %s, but test didn't produce any\n", stream);
+	ERR("Expecting output on %s, but test didn't produce any\n",
+	    fd_cmp->name);
 
 	return -1;
 }
 
-#define BUFSZ 4096
-struct buffer {
-	char buf[BUFSZ];
-	unsigned int head;
-};
+static bool fd_cmp_is_active(struct fd_cmp *fd_cmp)
+{
+	return fd_cmp->fd != -1;
+}
+
+static int fd_cmp_open_monitor(struct fd_cmp *fd_cmp, int fd, int fd_ep)
+{
+	struct epoll_event ep = {};
+
+	ep.events = EPOLLHUP;
+	ep.data.ptr = fd_cmp;
+	if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fd, &ep) < 0) {
+		ERR("could not add monitor fd to epoll: %m\n");
+		return -errno;
+	}
+
+	return 0;
+}
+
+static int fd_cmp_open_std(struct fd_cmp *fd_cmp,
+			   const char *fn, int fd, int fd_ep)
+{
+	struct epoll_event ep = {};
+	int fd_match;
+
+	fd_match = open(fn, O_RDONLY);
+	if (fd_match < 0) {
+		ERR("could not open %s for read: %m\n", fn);
+		return -errno;
+	}
+	ep.events = EPOLLIN;
+	ep.data.ptr = fd_cmp;
+	if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fd, &ep) < 0) {
+		ERR("could not add fd to epoll: %m\n");
+		close(fd_match);
+		return -errno;
+	}
+
+	return fd_match;
+}
+
+/* opens output file AND adds descriptor to epoll */
+static int fd_cmp_open(struct fd_cmp **fd_cmp_out,
+		       enum fd_cmp_type type, const char *fn, int fd,
+		       int fd_ep)
+{
+	int err = 0;
+	struct fd_cmp *fd_cmp;
+
+	fd_cmp = calloc(1, sizeof(*fd_cmp));
+	if (fd_cmp == NULL) {
+		ERR("could not allocate fd_cmp\n");
+		return -ENOMEM;
+	}
+
+	switch (type) {
+	case FD_CMP_MONITOR:
+		err = fd_cmp_open_monitor(fd_cmp, fd, fd_ep);
+		break;
+	case FD_CMP_OUT:
+		fd_cmp->name = "STDOUT";
+		err = fd_cmp_open_std(fd_cmp, fn, fd, fd_ep);
+		break;
+	case FD_CMP_ERR:
+		fd_cmp->name = "STDERR";
+		err = fd_cmp_open_std(fd_cmp, fn, fd, fd_ep);
+		break;
+	default:
+		ERR("unknown fd type %d\n", type);
+		err = -1;
+	}
+
+	if (err < 0) {
+		free(fd_cmp);
+		return err;
+	}
+
+	fd_cmp->fd_match = err;
+	fd_cmp->fd = fd;
+	fd_cmp->type = type;
+	fd_cmp->path = fn;
+
+	*fd_cmp_out = fd_cmp;
+	return 0;
+}
+
+static int fd_cmp_check_ev_in(struct fd_cmp *fd_cmp)
+{
+	if (fd_cmp->type == FD_CMP_MONITOR) {
+		ERR("Unexpected activity on monitor pipe\n");
+		return -EINVAL;
+	}
+	fd_cmp->activity = true;
+
+	return 0;
+}
+
+static void fd_cmp_delete_ep(struct fd_cmp *fd_cmp, int fd_ep)
+{
+	if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd_cmp->fd, NULL) < 0) {
+		ERR("could not remove fd %d from epoll: %m\n", fd_cmp->fd);
+	}
+	fd_cmp->fd = -1;
+}
 
+static void fd_cmp_close(struct fd_cmp *fd_cmp)
+{
+	if (fd_cmp == NULL)
+		return;
 
-static bool cmpbuf_regex_one(const char *pattern, const char *s)
+	if (fd_cmp->fd >= 0)
+		close(fd_cmp->fd);
+	free(fd_cmp);
+}
+
+static bool fd_cmp_regex_one(const char *pattern, const char *s)
 {
 	_cleanup_(regfree) regex_t re = { };
 
@@ -310,24 +440,23 @@ static bool cmpbuf_regex_one(const char *pattern, const char *s)
  * read fd and fd_match, checking the first matches the regex of the second,
  * line by line
  */
-static bool cmpbuf_regex(const struct test *t, const char *prefix,
-			 int fd, int fd_match, struct buffer *buf,
-			 struct buffer *buf_match)
+static bool fd_cmp_regex(struct fd_cmp *fd_cmp, const struct test *t)
 {
 	char *p, *p_match;
 	int done = 0, done_match = 0, r;
 
-	if (buf->head >= sizeof(buf->buf)) {
-		ERR("Read %zu bytes without a newline\n", sizeof(buf->buf));
-		ERR("output: %.*s", (int)sizeof(buf->buf), buf->buf);
+	if (fd_cmp->head >= sizeof(fd_cmp->buf)) {
+		ERR("Read %zu bytes without a newline\n", sizeof(fd_cmp->buf));
+		ERR("output: %.*s", (int)sizeof(fd_cmp->buf), fd_cmp->buf);
 		return false;
 	}
 
-	r = read(fd, buf->buf + buf->head, sizeof(buf->buf) - buf->head);
+	r = read(fd_cmp->fd, fd_cmp->buf + fd_cmp->head,
+		 sizeof(fd_cmp->buf) - fd_cmp->head);
 	if (r <= 0)
 		return true;
 
-	buf->head += r;
+	fd_cmp->head += r;
 
 	/*
 	 * Process as many lines as read from fd and that fits in the buffer -
@@ -335,46 +464,46 @@ static bool cmpbuf_regex(const struct test *t, const char *prefix,
 	 * get the same amount from fd_match
 	 */
 	for (;;) {
-		p = memchr(buf->buf + done, '\n', buf->head - done);
+		p = memchr(fd_cmp->buf + done, '\n', fd_cmp->head - done);
 		if (!p)
 			break;
 		*p = '\0';
 
-		p_match = memchr(buf_match->buf + done_match, '\n',
-				 buf_match->head - done_match);
+		p_match = memchr(fd_cmp->buf_match + done_match, '\n',
+				 fd_cmp->head_match - done_match);
 		if (!p_match) {
-			if (buf_match->head >= sizeof(buf_match->buf)) {
-				ERR("Read %zu bytes without a match\n", sizeof(buf_match->buf));
-				ERR("output: %.*s", (int)sizeof(buf_match->buf), buf_match->buf);
+			if (fd_cmp->head_match >= sizeof(fd_cmp->buf_match)) {
+				ERR("Read %zu bytes without a match\n", sizeof(fd_cmp->buf_match));
+				ERR("output: %.*s", (int)sizeof(fd_cmp->buf_match), fd_cmp->buf_match);
 				return false;
 			}
 
 			/* pump more data from file */
-			r = read(fd_match, buf_match->buf + buf_match->head,
-				 sizeof(buf_match->buf) - buf_match->head);
+			r = read(fd_cmp->fd_match, fd_cmp->buf_match + fd_cmp->head_match,
+				 sizeof(fd_cmp->buf_match) - fd_cmp->head_match);
 			if (r <= 0) {
-				ERR("could not read match fd %d\n", fd_match);
+				ERR("could not read match fd %d\n", fd_cmp->fd_match);
 				return false;
 			}
-			buf_match->head += r;
-			p_match = memchr(buf_match->buf + done_match, '\n',
-					 buf_match->head - done_match);
+			fd_cmp->head_match += r;
+			p_match = memchr(fd_cmp->buf_match + done_match, '\n',
+					 fd_cmp->head_match - done_match);
 			if (!p_match) {
-				ERR("could not find match line from fd %d\n", fd_match);
+				ERR("could not find match line from fd %d\n", fd_cmp->fd_match);
 				return false;
 			}
 		}
 		*p_match = '\0';
 
-		if (!cmpbuf_regex_one(buf_match->buf + done_match, buf->buf + done)) {
-			ERR("Output does not match pattern on %s:\n", prefix);
-			ERR("pattern: %s\n", buf_match->buf + done_match);
-			ERR("output : %s\n", buf->buf + done);
+		if (!fd_cmp_regex_one(fd_cmp->buf_match + done_match, fd_cmp->buf + done)) {
+			ERR("Output does not match pattern on %s:\n", fd_cmp->name);
+			ERR("pattern: %s\n", fd_cmp->buf_match + done_match);
+			ERR("output : %s\n", fd_cmp->buf + done);
 			return false;
 		}
 
-		done = p - buf->buf + 1;
-		done_match = p_match - buf_match->buf + 1;
+		done = p - fd_cmp->buf + 1;
+		done_match = p_match - fd_cmp->buf_match + 1;
 	}
 
 	/*
@@ -382,59 +511,57 @@ static bool cmpbuf_regex(const struct test *t, const char *prefix,
 	 * buffer by memmoving the remaining bytes up to the beginning
 	 */
 	if (done) {
-		if (buf->head - done)
-			memmove(buf->buf, buf->buf + done, buf->head - done);
-		buf->head -= done;
+		if (fd_cmp->head - done)
+			memmove(fd_cmp->buf, fd_cmp->buf + done, fd_cmp->head - done);
+		fd_cmp->head -= done;
 	}
 
 	if (done_match) {
-		if (buf_match->head - done_match)
-			memmove(buf_match->buf, buf_match->buf + done_match,
-				buf_match->head - done_match);
-		buf_match->head -= done_match;
+		if (fd_cmp->head_match - done_match)
+			memmove(fd_cmp->buf_match, fd_cmp->buf_match + done_match,
+				fd_cmp->head_match - done_match);
+		fd_cmp->head_match -= done_match;
 	}
 
 	return true;
 }
 
 /* read fd and fd_match, checking they match exactly */
-static bool cmpbuf_exact(const struct test *t, const char *prefix,
-			 int fd, int fd_match, struct buffer *buf,
-			 struct buffer *buf_match)
+static bool fd_cmp_exact(struct fd_cmp *fd_cmp, const struct test *t)
 {
 	int r, rmatch, done = 0;
 
-	r = read(fd, buf->buf, sizeof(buf->buf) - 1);
+	r = read(fd_cmp->fd, fd_cmp->buf, sizeof(fd_cmp->buf) - 1);
 	if (r <= 0)
 		/* try again later */
 		return true;
 
 	/* read as much data from fd_match as we read from fd */
 	for (;;) {
-		rmatch = read(fd_match, buf_match->buf + done, r - done);
+		rmatch = read(fd_cmp->fd_match, fd_cmp->buf_match + done, r - done);
 		if (rmatch == 0)
 			break;
 
 		if (rmatch < 0) {
 			if (errno == EINTR)
 				continue;
-			ERR("could not read match fd %d\n", fd_match);
+			ERR("could not read match fd %d\n", fd_cmp->fd_match);
 			return false;
 		}
 
 		done += rmatch;
 	}
 
-	buf->buf[r] = '\0';
-	buf_match->buf[r] = '\0';
+	fd_cmp->buf[r] = '\0';
+	fd_cmp->buf_match[r] = '\0';
 
 	if (t->print_outputs)
-		printf("%s: %s\n", prefix, buf->buf);
+		printf("%s: %s\n", fd_cmp->name, fd_cmp->buf);
 
-	if (!streq(buf->buf, buf_match->buf)) {
-		ERR("Outputs do not match on %s:\n", prefix);
-		ERR("correct:\n%s\n", buf_match->buf);
-		ERR("wrong:\n%s\n", buf->buf);
+	if (!streq(fd_cmp->buf, fd_cmp->buf_match)) {
+		ERR("Outputs do not match on %s:\n", fd_cmp->name);
+		ERR("correct:\n%s\n", fd_cmp->buf_match);
+		ERR("wrong:\n%s\n", fd_cmp->buf);
 		return false;
 	}
 
@@ -445,11 +572,11 @@ static bool test_run_parent_check_outputs(const struct test *t,
 					  int fdout, int fderr, int fdmonitor,
 					  pid_t child)
 {
-	struct epoll_event ep_outpipe, ep_errpipe, ep_monitor;
-	int err, fd_ep, fd_matchout = -1, fd_matcherr = -1;
-	bool fd_activityout = false, fd_activityerr = false;
+	int err, fd_ep;
 	unsigned long long end_usec, start_usec;
-	_cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
+	struct fd_cmp *fd_cmp_out = NULL;
+	struct fd_cmp *fd_cmp_err = NULL;
+	struct fd_cmp *fd_cmp_monitor = NULL;
 	int n_fd = 0;
 
 	fd_ep = epoll_create1(EPOLL_CLOEXEC);
@@ -459,56 +586,24 @@ static bool test_run_parent_check_outputs(const struct test *t,
 	}
 
 	if (t->output.out != NULL) {
-		fd_matchout = open(t->output.out, O_RDONLY);
-		if (fd_matchout < 0) {
-			err = -errno;
-			ERR("could not open %s for read: %m\n",
-							t->output.out);
+		err = fd_cmp_open(&fd_cmp_out,
+				  FD_CMP_OUT, t->output.out, fdout, fd_ep);
+		if (err < 0)
 			goto out;
-		}
-		memset(&ep_outpipe, 0, sizeof(struct epoll_event));
-		ep_outpipe.events = EPOLLIN;
-		ep_outpipe.data.ptr = &fdout;
-		if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fdout, &ep_outpipe) < 0) {
-			err = -errno;
-			ERR("could not add fd to epoll: %m\n");
-			goto out;
-		}
-		buf_out = calloc(2, sizeof(*buf_out));
 		n_fd++;
-	} else
-		fdout = -1;
+	}
 
 	if (t->output.err != NULL) {
-		fd_matcherr = open(t->output.err, O_RDONLY);
-		if (fd_matcherr < 0) {
-			err = -errno;
-			ERR("could not open %s for read: %m\n",
-					t->output.err);
-			goto out;
-
-		}
-		memset(&ep_errpipe, 0, sizeof(struct epoll_event));
-		ep_errpipe.events = EPOLLIN;
-		ep_errpipe.data.ptr = &fderr;
-		if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fderr, &ep_errpipe) < 0) {
-			err = -errno;
-			ERR("could not add fd to epoll: %m\n");
+		err = fd_cmp_open(&fd_cmp_err,
+				  FD_CMP_ERR, t->output.err, fderr, fd_ep);
+		if (err < 0)
 			goto out;
-		}
-		buf_err = calloc(2, sizeof(*buf_err));
 		n_fd++;
-	} else
-		fderr = -1;
-
-	memset(&ep_monitor, 0, sizeof(struct epoll_event));
-	ep_monitor.events = EPOLLHUP;
-	ep_monitor.data.ptr = &fdmonitor;
-	if (epoll_ctl(fd_ep, EPOLL_CTL_ADD, fdmonitor, &ep_monitor) < 0) {
-		err = -errno;
-		ERR("could not add monitor fd to epoll: %m\n");
-		goto out;
 	}
+
+	err = fd_cmp_open(&fd_cmp_monitor, FD_CMP_MONITOR, NULL, fdmonitor, fd_ep);
+	if (err < 0)
+		goto out;
 	n_fd++;
 
 	start_usec = now_usec();
@@ -533,69 +628,45 @@ static bool test_run_parent_check_outputs(const struct test *t,
 		}
 
 		for (i = 0;  i < fdcount; i++) {
-			int fd = *(int *)ev[i].data.ptr;
+			struct fd_cmp *fd_cmp = ev[i].data.ptr;
 			bool ret;
 
 			if (ev[i].events & EPOLLIN) {
-				int fd_match;
-				struct buffer *buf, *buf_match;
-				const char *prefix;
-
-				if (fd == fdout) {
-					fd_match = fd_matchout;
-					buf = buf_out;
-					fd_activityout = true;
-					prefix = "STDOUT";
-				} else if (fd == fderr) {
-					fd_match = fd_matcherr;
-					buf = buf_err;
-					fd_activityerr = true;
-					prefix = "STDERR";
-				} else {
-					ERR("Unexpected activity on monitor pipe\n");
-					err = -EINVAL;
+				err = fd_cmp_check_ev_in(fd_cmp);
+				if (err < 0)
 					goto out;
-				}
-
-				buf_match = buf + 1;
 
 				if (t->output.regex)
-					ret = cmpbuf_regex(t, prefix, fd, fd_match,
-							   buf, buf_match);
+					ret = fd_cmp_regex(fd_cmp, t);
 				else
-					ret = cmpbuf_exact(t, prefix,  fd, fd_match,
-							   buf, buf_match);
+					ret = fd_cmp_exact(fd_cmp, t);
 
 				if (!ret) {
 					err = -1;
 					goto out;
 				}
 			} else if (ev[i].events & EPOLLHUP) {
-				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
-					ERR("could not remove fd %d from epoll: %m\n", fd);
-				}
-				*(int *)ev[i].data.ptr = -1;
+				fd_cmp_delete_ep(fd_cmp, fd_ep);
 				n_fd--;
 			}
 		}
 	}
 
-	err = check_activity(fd_matchout, fd_activityout, t->output.out, "stdout");
-	err |= check_activity(fd_matcherr, fd_activityerr, t->output.err, "stderr");
+	err = fd_cmp_check_activity(fd_cmp_out);
+	err |= fd_cmp_check_activity(fd_cmp_err);
 
-	if (err == 0 && fdmonitor >= 0) {
+	if (err == 0 && fd_cmp_is_active(fd_cmp_monitor)) {
 		err = -EINVAL;
 		ERR("Test '%s' timed out, killing %d\n", t->name, child);
 		kill(child, SIGKILL);
 	}
 
 out:
-	if (fd_matchout >= 0)
-		close(fd_matchout);
-	if (fd_matcherr >= 0)
-		close(fd_matcherr);
-	if (fd_ep >= 0)
-		close(fd_ep);
+	fd_cmp_close(fd_cmp_out);
+	fd_cmp_close(fd_cmp_err);
+	fd_cmp_close(fd_cmp_monitor);
+	close(fd_ep);
+
 	return err == 0;
 }
 
-- 
2.20.0

