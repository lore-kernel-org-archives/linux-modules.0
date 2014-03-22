Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smtp03.stone-is.org ([87.238.162.6]:49143 "EHLO
	smtpgw.stone-is.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaCVMzb (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sat, 22 Mar 2014 08:55:31 -0400
Received: from localhost (unknown [127.0.0.1])
	by smtpgw.stone-is.be (Postfix) with ESMTP id C54C8334BD7
	for <linux-modules@vger.kernel.org>; Sat, 22 Mar 2014 12:26:34 +0000 (UTC)
Received: from smtpgw.stone-is.be ([127.0.0.1])
	by localhost (smtpgw.stone-is.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAXKCg6Hvj-n for <linux-modules@vger.kernel.org>;
	Sat, 22 Mar 2014 13:26:33 +0100 (CET)
Received: from vz19.stone-is.net (vz19.stone-is.net [87.238.162.57])
	by smtpgw.stone-is.be (Postfix) with ESMTP id 1C613334BF5
	for <linux-modules@vger.kernel.org>; Sat, 22 Mar 2014 13:26:32 +0100 (CET)
Received: from [192.168.1.117] (178-119-65-67.access.telenet.be [178.119.65.67])
	by vz19.stone-is.net (Postfix) with ESMTPSA id B5EF0891FD
	for <linux-modules@vger.kernel.org>; Sat, 22 Mar 2014 13:26:32 +0100 (CET)
Message-ID: <532D8178.1030201@acm.org>
Date: Sat, 22 Mar 2014 13:26:32 +0100
From: Bart Van Assche <bvanassche@acm.org>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
Subject: [PATCH] Fix a test in the configure script
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Avoid that the configure script prints the following error message:
./configure: line 14049: xyes: command not found

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 54a52ea..7ef151e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,7 +112,7 @@ AC_ARG_ENABLE([manpages],
         AS_HELP_STRING([--disable-manpages], [disable manpages @<:@default=enabled@:>@]),
 	[], enable_manpages=yes)
 AM_CONDITIONAL([BUILD_MANPAGES], [test "x$enable_manpages" = "xyes"])
-AS_IF(["x$enable_manpages" != "xno"], ["have_manpages=yes"])
+AS_IF([test "x$enable_manpages" != "xno"], ["have_manpages=yes"])
 
 AC_ARG_ENABLE([logging],
 	AS_HELP_STRING([--disable-logging], [disable system logging @<:@default=enabled@:>@]),
-- 
1.8.4.5

