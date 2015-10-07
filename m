Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36045 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbbJGPhd (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 7 Oct 2015 11:37:33 -0400
Received: by lbcao8 with SMTP id ao8so16266516lbc.3
        for <linux-modules@vger.kernel.org>; Wed, 07 Oct 2015 08:37:32 -0700 (PDT)
Received: from sulka.jollamobile.com ([194.157.27.2])
        by smtp.gmail.com with ESMTPSA id j9sm6332553lbs.40.2015.10.07.08.37.30
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Oct 2015 08:37:30 -0700 (PDT)
From: philippedeswert@gmail.com
To: linux-modules@vger.kernel.org
Subject: [PATCH] insmod: do support -f
Date: Wed,  7 Oct 2015 18:36:58 +0300
Message-Id: <1444232218-22150-1-git-send-email-philippedeswert@gmail.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Philippe De Swert <philippe.deswert@jollamobile.com>

The -f switch is accepted by insmod, but silently ignored. This
causes the user to wonder why things don't work. As insmod is
most often used with "evil" modules, -f is almost default and
thus needs to work.

Signed-off-by: Philippe De Swert <philippe.deswert@jollamobile.com>
---
 tools/insmod.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/insmod.c b/tools/insmod.c
index 8e72e11..045fd2c 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -71,6 +71,7 @@ static int do_insmod(int argc, char *argv[])
 	size_t optslen = 0;
 	int i, err;
 	const char *null_config = NULL;
+	unsigned int flags = 0;
 
 	for (;;) {
 		int c, idx = 0;
@@ -81,7 +82,8 @@ static int do_insmod(int argc, char *argv[])
 		case 'p':
 		case 's':
 		case 'f':
-			/* ignored, for compatibility only */
+			flags |= KMOD_PROBE_FORCE_MODVERSION;
+			flags |= KMOD_PROBE_FORCE_VERMAGIC;
 			break;
 		case 'h':
 			help();
@@ -142,7 +144,7 @@ static int do_insmod(int argc, char *argv[])
 		goto end;
 	}
 
-	err = kmod_module_insert_module(mod, 0, opts);
+	err = kmod_module_insert_module(mod, flags, opts);
 	if (err < 0) {
 		ERR("could not insert module %s: %s\n", filename,
 		    mod_strerror(-err));
-- 
2.1.4

