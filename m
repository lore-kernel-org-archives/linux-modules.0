Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BBC43387
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE92218D3
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfADVlf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:41:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfADVl0 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 16:41:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB73B63800;
        Fri,  4 Jan 2019 21:41:25 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A62B19C7C;
        Fri,  4 Jan 2019 21:41:24 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod 1/2] testsuite: track number of descriptors instead of their state
Date:   Fri,  4 Jan 2019 23:41:33 +0200
Message-Id: <20190104214134.23971-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
References: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 04 Jan 2019 21:41:25 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

use the number of tracked descriptors to determine the end of the
loop.

This is a preparation for more abstract descriptor comparation
implementation where checking of the descriptor state may be more
expensive than just checking of the local variables.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 testsuite/testsuite.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 1f0caafcccca..81b54ad1a48d 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -450,6 +450,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 	bool fd_activityout = false, fd_activityerr = false;
 	unsigned long long end_usec, start_usec;
 	_cleanup_free_ struct buffer *buf_out = NULL, *buf_err = NULL;
+	int n_fd = 0;
 
 	fd_ep = epoll_create1(EPOLL_CLOEXEC);
 	if (fd_ep < 0) {
@@ -474,6 +475,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 			goto out;
 		}
 		buf_out = calloc(2, sizeof(*buf_out));
+		n_fd++;
 	} else
 		fdout = -1;
 
@@ -495,6 +497,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 			goto out;
 		}
 		buf_err = calloc(2, sizeof(*buf_err));
+		n_fd++;
 	} else
 		fderr = -1;
 
@@ -506,11 +509,12 @@ static bool test_run_parent_check_outputs(const struct test *t,
 		ERR("could not add monitor fd to epoll: %m\n");
 		goto out;
 	}
+	n_fd++;
 
 	start_usec = now_usec();
 	end_usec = start_usec + TEST_TIMEOUT_USEC;
 
-	for (err = 0; fdmonitor >= 0 || fdout >= 0 || fderr >= 0;) {
+	for (err = 0; n_fd > 0;) {
 		int fdcount, i, timeout;
 		struct epoll_event ev[4];
 		unsigned long long curr_usec = now_usec();
@@ -571,6 +575,7 @@ static bool test_run_parent_check_outputs(const struct test *t,
 					ERR("could not remove fd %d from epoll: %m\n", fd);
 				}
 				*(int *)ev[i].data.ptr = -1;
+				n_fd--;
 			}
 		}
 	}
-- 
2.20.0

