Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57608 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbaDDLS5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 07:18:57 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 01E4CACDA
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 11:18:56 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH v3 3/3] testsuite: Warn if sysconfdir is not /etc
Date: Fri,  4 Apr 2014 13:18:50 +0200
Message-Id: <1396610330-16034-4-git-send-email-mmarek@suse.cz>
In-Reply-To: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
References: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 Makefile.am | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index e65fdfb..199588c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -213,7 +213,14 @@ TESTSUITE_OVERRIDE_LIBS = testsuite/uname.la testsuite/path.la \
 TESTSUITE_OVERRIDE_LIBS_LDFLAGS = avoid-version -module -shared -export-dynamic \
 				  -rpath /nowhere -ldl
 
-check-am: rootfs
+check-sysconfdir:
+	$(AM_V_at)if test "$(sysconfdir)" != "/etc" -a "$(sysconfdir)" != "/etc/"; then \
+		echo "warning: Some tests will fail without --sysconfdir=/etc" >&2; \
+	fi
+.PHONY: check-sysconfdir
+
+check-am: rootfs check-sysconfdir
+
 
 check_LTLIBRARIES = $(TESTSUITE_OVERRIDE_LIBS)
 
-- 
1.8.4.5

