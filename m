Return-Path: <SRS0=c/4a=O4=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CEC43612
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E92218AD
	for <linux-modules@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLSADJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:03:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:8278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbeLSADJ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Dec 2018 19:03:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 16:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="284784589"
Received: from ldmartin-desk.jf.intel.com ([10.7.200.65])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2018 16:03:05 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 1/3] testsuite: split out function to compare outputs exactly
Date:   Tue, 18 Dec 2018 16:02:27 -0800
Message-Id: <20181219000229.10793-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Move functionality to compare the exact output to a separate function
and allocate one buffer per output/match pair. This will allow us to
extend this to allow other types of comparisons.
---
 testsuite/testsuite.c | 124 ++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 54 deletions(-)

diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 8512b56..550c711 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -290,13 +290,64 @@ static int check_activity(int fd, bool activity,  const char *path,
 	return -1;
 }
 
-static inline bool test_run_parent_check_outputs(const struct test *t,
-			int fdout, int fderr, int fdmonitor, pid_t child)
+#define BUFSZ 4096
+struct buffer {
+	char buf[BUFSZ];
+};
+
+/* read fd and fd_match, checking they match exactly */
+static bool cmpbuf_exact(const struct test *t, const char *prefix,
+			 int fd, int fd_match, struct buffer *buf,
+			 struct buffer *buf_match)
+{
+	int r, rmatch, done = 0;
+
+	r = read(fd, buf, sizeof(buf->buf) - 1);
+	if (r <= 0)
+		/* try again later */
+		return true;
+
+	/* read as much data from fd_match as we read from fd */
+	for (;;) {
+		rmatch = read(fd_match, buf_match->buf + done, r - done);
+		if (rmatch == 0)
+			break;
+
+		if (rmatch < 0) {
+			if (errno == EINTR)
+				continue;
+			ERR("could not read match fd %d\n", fd_match);
+			return false;
+		}
+
+		done += rmatch;
+	}
+
+	buf->buf[r] = '\0';
+	buf_match->buf[r] = '\0';
+
+	if (t->print_outputs)
+		printf("%s: %s\n", prefix, buf->buf);
+
+	if (!streq(buf->buf, buf_match->buf)) {
+		ERR("Outputs do not match on %s:\n", prefix);
+		ERR("correct:\n%s\n", buf_match->buf);
+		ERR("wrong:\n%s\n", buf->buf);
+		return false;
+	}
+
+	return true;
+}
+
+static bool test_run_parent_check_outputs(const struct test *t,
+					  int fdout, int fderr, int fdmonitor,
+					  pid_t child)
 {
 	struct epoll_event ep_outpipe, ep_errpipe, ep_monitor;
 	int err, fd_ep, fd_matchout = -1, fd_matcherr = -1;
 	bool fd_activityout = false, fd_activityerr = false;
 	unsigned long long end_usec, start_usec;
+	_cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
 
 	fd_ep = epoll_create1(EPOLL_CLOEXEC);
 	if (fd_ep < 0) {
@@ -320,6 +371,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 			ERR("could not add fd to epoll: %m\n");
 			goto out;
 		}
+		buf_out = calloc(2, sizeof(*buf_out));
 	} else
 		fdout = -1;
 
@@ -340,6 +392,7 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 			ERR("could not add fd to epoll: %m\n");
 			goto out;
 		}
+		buf_err = calloc(2, sizeof(*buf_err));
 	} else
 		fderr = -1;
 
@@ -374,76 +427,39 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 		}
 
 		for (i = 0;  i < fdcount; i++) {
-			int *fd = ev[i].data.ptr;
+			int fd = *(int *)ev[i].data.ptr;
 
 			if (ev[i].events & EPOLLIN) {
-				ssize_t r, done = 0;
-				char buf[4096];
-				char bufmatch[4096];
 				int fd_match;
+				struct buffer *buf, *buf_match;
+				const char *prefix;
 
-				/*
-				 * compare the output from child with the one
-				 * saved as correct
-				 */
-
-				r = read(*fd, buf, sizeof(buf) - 1);
-				if (r <= 0)
-					continue;
-
-				if (*fd == fdout) {
+				if (fd == fdout) {
 					fd_match = fd_matchout;
+					buf = buf_out;
 					fd_activityout = true;
-				} else if (*fd == fderr) {
+					prefix = "STDOUT";
+				} else if (fd == fderr) {
 					fd_match = fd_matcherr;
+					buf = buf_err;
 					fd_activityerr = true;
+					prefix = "STDERR";
 				} else {
 					ERR("Unexpected activity on monitor pipe\n");
 					err = -EINVAL;
 					goto out;
 				}
 
-				for (;;) {
-					int rmatch = read(fd_match,
-						bufmatch + done, r - done);
-					if (rmatch == 0)
-						break;
-
-					if (rmatch < 0) {
-						if (errno == EINTR)
-							continue;
-						err = -errno;
-						ERR("could not read match fd %d\n",
-								fd_match);
-						goto out;
-					}
-
-					done += rmatch;
-				}
+				buf_match = buf + 1;
 
-				buf[r] = '\0';
-				bufmatch[r] = '\0';
-
-				if (t->print_outputs)
-					printf("%s: %s\n",
-					       fd_match == fd_matchout ? "STDOUT:" : "STDERR:",
-					       buf);
-
-				if (!streq(buf, bufmatch)) {
-					ERR("Outputs do not match on %s:\n",
-						fd_match == fd_matchout ? "STDOUT" : "STDERR");
-					ERR("correct:\n%s\n", bufmatch);
-					ERR("wrong:\n%s\n", buf);
-					err = -1;
+				if (!cmpbuf_exact(t, prefix,  fd, fd_match,
+						  buf, buf_match))
 					goto out;
-				}
 			} else if (ev[i].events & EPOLLHUP) {
-				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL,
-							*fd, NULL) < 0) {
-					ERR("could not remove fd %d from epoll: %m\n",
-									*fd);
+				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
+					ERR("could not remove fd %d from epoll: %m\n", fd);
 				}
-				*fd = -1;
+				*(int *)ev[i].data.ptr = -1;
 			}
 		}
 	}
-- 
2.20.0

