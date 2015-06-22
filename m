Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from 79.160.13.133.static.lyse.net ([79.160.13.133]:47844 "EHLO
	tanael.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754364AbbFVMPV (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 22 Jun 2015 08:15:21 -0400
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-modules@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] build: let sed use posix ERE instead of GNU extension
Date: Mon, 22 Jun 2015 14:09:17 +0200
Message-Id: <1434974957-2995-1-git-send-email-ncopa@alpinelinux.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Use POSIX Extended Regular Expression (ERE) instead of the GNU extension
\| in the install-exec-hook. This makes it create the symlink properly
with busybox sed built with musl libc. It will silently create a broken
symlink otherwise.
---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 6679deb..4978b26 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -107,7 +107,8 @@ install-exec-hook:
 	if test "$(libdir)" != "$(rootlibdir)"; then \
 		$(MKDIR_P) $(DESTDIR)$(rootlibdir) && \
 		so_img_name=$$(readlink $(DESTDIR)$(libdir)/libkmod.so) && \
-		so_img_rel_target_prefix=$$(echo $(libdir) | sed 's,\(^/\|\)[^/][^/]*,..,g') && \
+		so_img_rel_target_prefix=$$(echo $(libdir) | sed -E 's,(^/|)[^/][^/]*,..,g') && \
+
 		ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
 		mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
 	fi
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-modules" in
