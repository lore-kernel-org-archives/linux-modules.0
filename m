Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46993 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbCJPii (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Mar 2015 11:38:38 -0400
Received: by pabli10 with SMTP id li10so3106181pab.13
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2015 08:38:37 -0700 (PDT)
Received: from ubuntu (ppp121-44-1-212.lns20.syd4.internode.on.net. [121.44.1.212])
        by mx.google.com with ESMTPSA id z2sm1466250pde.94.2015.03.10.08.38.34
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Mar 2015 08:38:36 -0700 (PDT)
Date: Fri, 6 Mar 2015 08:05:47 +1100
From: Jeff Waugh <jdub@bethesignal.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] build: generate libkmod.pc during autoconf
Message-ID: <20150305210547.GA24297@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The pkgconfig file is generated at make-time, leading to absolute /usr/include
& /usr/lib search paths. The patch lets autoconf handle pkgconfig file subst,
like other packages do. (Patch from OpenWrt's contributed packages project.)

Signed-off-by: Nicolas Thill <nico@openwrt.org>
Signed-off-by: Jeff Waugh <jdub@bethesignal.org>
---
 Makefile.am  | 3 ---
 configure.ac | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index caf18b6..32aea73 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -36,9 +36,6 @@ SED_PROCESS = \
 	-e 's,@zlib_LIBS\@,${zlib_LIBS},g' \
 	< $< > $@ || rm $@
 
-%.pc: %.pc.in Makefile
-	$(SED_PROCESS)
-
 LIBKMOD_CURRENT=4
 LIBKMOD_REVISION=10
 LIBKMOD_AGE=2
diff --git a/configure.ac b/configure.ac
index be597b4..8500cad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,6 +250,7 @@ AC_SUBST([OUR_LDFLAGS], $with_ldflags)
 AC_CONFIG_FILES([
 	Makefile
 	man/Makefile
+	libkmod/libkmod.pc
 	libkmod/docs/Makefile
 	libkmod/docs/version.xml
 ])
-- 
1.9.1

