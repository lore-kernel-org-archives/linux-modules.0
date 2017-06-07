Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36429 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdFGGSV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 7 Jun 2017 02:18:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so592758pfd.3
        for <linux-modules@vger.kernel.org>; Tue, 06 Jun 2017 23:18:21 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux-modules@vger.kernel.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH kmod] util: fix non-static assert_cc use
Date: Wed,  7 Jun 2017 15:48:11 +0930
Message-Id: <20170607061811.4016-1-joel@jms.id.au>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

In commit a6ede6c7ad46 (util: fix warning of equal values on logical OR)
the runtime check for EAGAIN and EWOULDBLOCK being equal was converted
into an assert.

For the case where the compiler supports _Static_assert, this is can be
called staticly. However the fallback for older compilers uses a
non-static test that needs to be called from a function context.

Move the assert into the functions that used to have the runtime check.
The test does not add any runtime overhead, so it is fine to duplicate
it.

Tested with and without HAVE_STATIC_ASSERT defined using GCC 6.3.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 shared/util.c              | 4 ++--
 testsuite/test-testsuite.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/shared/util.c b/shared/util.c
index 9de080aabb18..c402953b4699 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -49,8 +49,6 @@ static const struct kmod_ext {
 	{ }
 };
 
-assert_cc(EAGAIN == EWOULDBLOCK);
-
 /* string handling functions and memory allocations                         */
 /* ************************************************************************ */
 
@@ -200,6 +198,7 @@ ssize_t read_str_safe(int fd, char *buf, size_t buflen)
 {
 	size_t todo = buflen - 1;
 	size_t done = 0;
+	assert_cc(EAGAIN == EWOULDBLOCK);
 
 	do {
 		ssize_t r = read(fd, buf + done, todo);
@@ -225,6 +224,7 @@ ssize_t write_str_safe(int fd, const char *buf, size_t buflen)
 {
 	size_t todo = buflen;
 	size_t done = 0;
+	assert_cc(EAGAIN == EWOULDBLOCK);
 
 	do {
 		ssize_t r = write(fd, buf + done, todo);
diff --git a/testsuite/test-testsuite.c b/testsuite/test-testsuite.c
index 56e73609f204..5bafc6551a23 100644
--- a/testsuite/test-testsuite.c
+++ b/testsuite/test-testsuite.c
@@ -88,6 +88,7 @@ static int testsuite_rootfs_open(const struct test *t)
 {
 	char buf[100];
 	int fd, done;
+	assert_cc(EAGAIN == EWOULDBLOCK);
 
 	fd = open("/lib/modules/a", O_RDONLY);
 	if (fd < 0)
-- 
2.11.0

