Return-Path: <SRS0=NEaN=PL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24476C43387
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8F921479
	for <linux-modules@archiver.kernel.org>; Thu,  3 Jan 2019 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfACVND (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:13:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:12133 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfACVND (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Jan 2019 16:13:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 13:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="123078592"
Received: from ldmartin-desk.jf.intel.com ([10.24.10.83])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2019 13:08:02 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH v2 2/3] testsuite: add support for testing output against regex
Date:   Thu,  3 Jan 2019 13:07:45 -0800
Message-Id: <20190103210746.20048-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190103210746.20048-1-lucas.demarchi@intel.com>
References: <20190103210746.20048-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Allow to test outputs when they don't match exactly, but should follow
some regex patterns. This can be used when the info we are printing is
randomized or depends on kernel configuration.
---
 testsuite/testsuite.c | 115 +++++++++++++++++++++++++++++++++++++++++-
 testsuite/testsuite.h |   6 +++
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 508bbd3..1f0caaf 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -20,6 +20,7 @@
 #include <fcntl.h>
 #include <getopt.h>
 #include <limits.h>
+#include <regex.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -293,8 +294,109 @@ static int check_activity(int fd, bool activity,  const char *path,
 #define BUFSZ 4096
 struct buffer {
 	char buf[BUFSZ];
+	unsigned int head;
 };
 
+
+static bool cmpbuf_regex_one(const char *pattern, const char *s)
+{
+	_cleanup_(regfree) regex_t re = { };
+
+	return !regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) &&
+	       !regexec(&re, s, 0, NULL, 0);
+}
+
+/*
+ * read fd and fd_match, checking the first matches the regex of the second,
+ * line by line
+ */
+static bool cmpbuf_regex(const struct test *t, const char *prefix,
+			 int fd, int fd_match, struct buffer *buf,
+			 struct buffer *buf_match)
+{
+	char *p, *p_match;
+	int done = 0, done_match = 0, r;
+
+	if (buf->head >= sizeof(buf->buf)) {
+		ERR("Read %zu bytes without a newline\n", sizeof(buf->buf));
+		ERR("output: %.*s", (int)sizeof(buf->buf), buf->buf);
+		return false;
+	}
+
+	r = read(fd, buf->buf + buf->head, sizeof(buf->buf) - buf->head);
+	if (r <= 0)
+		return true;
+
+	buf->head += r;
+
+	/*
+	 * Process as many lines as read from fd and that fits in the buffer -
+	 * it's assumed that if we get N lines from fd, we should be able to
+	 * get the same amount from fd_match
+	 */
+	for (;;) {
+		p = memchr(buf->buf + done, '\n', buf->head - done);
+		if (!p)
+			break;
+		*p = '\0';
+
+		p_match = memchr(buf_match->buf + done_match, '\n',
+				 buf_match->head - done_match);
+		if (!p_match) {
+			if (buf_match->head >= sizeof(buf_match->buf)) {
+				ERR("Read %zu bytes without a match\n", sizeof(buf_match->buf));
+				ERR("output: %.*s", (int)sizeof(buf_match->buf), buf_match->buf);
+				return false;
+			}
+
+			/* pump more data from file */
+			r = read(fd_match, buf_match->buf + buf_match->head,
+				 sizeof(buf_match->buf) - buf_match->head);
+			if (r <= 0) {
+				ERR("could not read match fd %d\n", fd_match);
+				return false;
+			}
+			buf_match->head += r;
+			p_match = memchr(buf_match->buf + done_match, '\n',
+					 buf_match->head - done_match);
+			if (!p_match) {
+				ERR("could not find match line from fd %d\n", fd_match);
+				return false;
+			}
+		}
+		*p_match = '\0';
+
+		if (!cmpbuf_regex_one(buf_match->buf + done_match, buf->buf + done)) {
+			ERR("Output does not match pattern on %s:\n", prefix);
+			ERR("pattern: %s\n", buf_match->buf + done_match);
+			ERR("output : %s\n", buf->buf + done);
+			return false;
+		}
+
+		done = p - buf->buf + 1;
+		done_match = p_match - buf_match->buf + 1;
+	}
+
+	/*
+	 * Prepare for the next call: anything we processed we remove from the
+	 * buffer by memmoving the remaining bytes up to the beginning
+	 */
+	if (done) {
+		if (buf->head - done)
+			memmove(buf->buf, buf->buf + done, buf->head - done);
+		buf->head -= done;
+	}
+
+	if (done_match) {
+		if (buf_match->head - done_match)
+			memmove(buf_match->buf, buf_match->buf + done_match,
+				buf_match->head - done_match);
+		buf_match->head -= done_match;
+	}
+
+	return true;
+}
+
 /* read fd and fd_match, checking they match exactly */
 static bool cmpbuf_exact(const struct test *t, const char *prefix,
 			 int fd, int fd_match, struct buffer *buf,
@@ -428,6 +530,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 
 		for (i = 0;  i < fdcount; i++) {
 			int fd = *(int *)ev[i].data.ptr;
+			bool ret;
 
 			if (ev[i].events & EPOLLIN) {
 				int fd_match;
@@ -452,9 +555,17 @@ static bool test_run_parent_check_outputs(const struct test *t,
 
 				buf_match = buf + 1;
 
-				if (!cmpbuf_exact(t, prefix,  fd, fd_match,
-						  buf, buf_match))
+				if (t->output.regex)
+					ret = cmpbuf_regex(t, prefix, fd, fd_match,
+							   buf, buf_match);
+				else
+					ret = cmpbuf_exact(t, prefix,  fd, fd_match,
+							   buf, buf_match);
+
+				if (!ret) {
+					err = -1;
 					goto out;
+				}
 			} else if (ev[i].events & EPOLLHUP) {
 				if (epoll_ctl(fd_ep, EPOLL_CTL_DEL, fd, NULL) < 0) {
 					ERR("could not remove fd %d from epoll: %m\n", fd);
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 2b31483..7ed96bf 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -88,6 +88,12 @@ struct test {
 		/* File with correct stderr */
 		const char *err;
 
+		/*
+		 * whether to treat the correct files as regex to the real
+		 * output
+		 */
+		bool regex;
+
 		/*
 		 * Vector with pair of files
 		 * key = correct file
-- 
2.20.0

