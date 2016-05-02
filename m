Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57982 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcEBOjI (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 2 May 2016 10:39:08 -0400
From: hector.oron@gmail.com
To: linux-modules@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A9ctor=20Or=C3=B3n=20Mart=C3=ADnez?=
	<hector.oron@gmail.com>
Subject: [PATCH] kmod: compiling with old sed version (!ERE support)
Date: Mon,  2 May 2016 16:38:24 +0200
Message-Id: <1462199904-797-1-git-send-email-hector.oron@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Héctor Orón Martínez <hector.oron@gmail.com>

  Makefile.am uses `sed -E', which it is found on BSD sed; however a
  replacement on GNU sed would be `sed -r'. Both intend to use extended
  regular expressions (ERE). However I have a system that does not support
  those, in benefit for portability could you consider replacing ERE by BRE.

Signed-off-by: Héctor Orón Martínez <hector.oron@gmail.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2d9f2cf..8813475 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -107,7 +107,7 @@ install-exec-hook:
 	if test "$(libdir)" != "$(rootlibdir)"; then \
 		$(MKDIR_P) $(DESTDIR)$(rootlibdir) && \
 		so_img_name=$$(readlink $(DESTDIR)$(libdir)/libkmod.so) && \
-		so_img_rel_target_prefix=$$(echo $(libdir) | sed -E 's,(^/|)[^/][^/]*,..,g') && \
+		so_img_rel_target_prefix=$$(echo $(libdir) | sed 's,\(^/\|\)[^/][^/]*,..,g') && \
 		ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
 		mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
 	fi
-- 
2.8.0.rc3

