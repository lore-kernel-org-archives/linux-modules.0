Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33284 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdFCPDw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 3 Jun 2017 11:03:52 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: linux-modules@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH kmod] shared/util.c: assert_cc() can only be used inside functions
Date: Sat,  3 Jun 2017 17:03:22 +0200
Message-Id: <1496502202-9832-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

shared/macro.h has two versions of assert_cc, one that uses gcc
_Static_assert(), which requires recent enough gcc versions, and one
that uses a fake array to trigger a build error. The latter can only
work inside functions, so assert_cc() should only be used inside
functions.

Fixes the following build failure when building kmod with old gcc
versions such as gcc 4.3.x:

shared/util.c:52: error: expected identifier or '(' before 'do'
shared/util.c:52: error: expected identifier or '(' before 'while'

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 shared/util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/shared/util.c b/shared/util.c
index 9de080a..fd2028d 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -49,8 +49,6 @@ static const struct kmod_ext {
 	{ }
 };
 
-assert_cc(EAGAIN == EWOULDBLOCK);
-
 /* string handling functions and memory allocations                         */
 /* ************************************************************************ */
 
@@ -201,6 +199,8 @@ ssize_t read_str_safe(int fd, char *buf, size_t buflen)
 	size_t todo = buflen - 1;
 	size_t done = 0;
 
+	assert_cc(EAGAIN == EWOULDBLOCK);
+
 	do {
 		ssize_t r = read(fd, buf + done, todo);
 
@@ -226,6 +226,8 @@ ssize_t write_str_safe(int fd, const char *buf, size_t buflen)
 	size_t todo = buflen;
 	size_t done = 0;
 
+	assert_cc(EAGAIN == EWOULDBLOCK);
+
 	do {
 		ssize_t r = write(fd, buf + done, todo);
 
-- 
2.7.4

