Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753452AbdKFV4P (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Nov 2017 16:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CFF382106
        for <linux-modules@vger.kernel.org>; Mon,  6 Nov 2017 21:56:15 +0000 (UTC)
Date: Mon, 6 Nov 2017 22:57:03 +0100
From: Eugene Syromiatnikov <esyr@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH] libkmod: fix uninitialized variable usage warnings
Message-ID: <20171106215703.GA24781@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

There are two places where _cleanup_free_ variables are not initialised
by the time function exits that have been caught by gcc:

	In file included from libkmod/libkmod.c:35:0:
	libkmod/libkmod.c: In function 'kmod_lookup_alias_is_builtin':
	./shared/util.h:73:13: warning: 'line' may be used uninitialized in this function [-Wmaybe-uninitialized]
		 free(*(void**) p);
		     ^
	libkmod/libkmod.c:551:23: note: 'line' was declared here
	  _cleanup_free_ char *line;
			       ^
	In file included from libkmod/libkmod-module.c:42:0:
	libkmod/libkmod-module.c: In function 'kmod_module_probe_insert_module':
	./shared/util.h:73:13: warning: 'cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]
		 free(*(void**) p);
		     ^
	libkmod/libkmod-module.c:996:23: note: 'cmd' was declared here
	  _cleanup_free_ char *cmd;
                       ^

This patch initializes them to NULL so free become no-op in these cases.
---
 libkmod/libkmod-module.c | 2 +-
 libkmod/libkmod.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 0a3ef11..6f23c1a 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -995,7 +995,7 @@ static int module_do_install_commands(struct kmod_module *mod,
 {
 	const char *command = kmod_module_get_install_commands(mod);
 	char *p;
-	_cleanup_free_ char *cmd;
+	_cleanup_free_ char *cmd = NULL;
 	int err;
 	size_t cmdlen, options_len, varlen;
 
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 69fe431..964772d 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -556,7 +556,7 @@ finish:
 
 bool kmod_lookup_alias_is_builtin(struct kmod_ctx *ctx, const char *name)
 {
-	_cleanup_free_ char *line;
+	_cleanup_free_ char *line = NULL;
 
 	line = lookup_builtin_file(ctx, name);
 
-- 
2.1.4

