Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33431 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759180AbbKTVXy (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 20 Nov 2015 16:23:54 -0500
Received: by wmec201 with SMTP id c201so89430872wme.0
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2015 13:23:53 -0800 (PST)
Received: from Lou.local (glo44-3-82-233-50-4.fbx.proxad.net. [82.233.50.4])
        by smtp.gmail.com with ESMTPSA id t194sm1247271wmt.11.2015.11.20.13.23.52
        for <linux-modules@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Nov 2015 13:23:53 -0800 (PST)
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH] insmod: fix wron fallthrough of -f
Date: Fri, 20 Nov 2015 22:23:14 +0100
Message-Id: <1448054594-1748-1-git-send-email-Marc-Antoine@Perennou.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 tools/insmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/insmod.c b/tools/insmod.c
index 045fd2c..c422971 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -81,6 +81,8 @@ static int do_insmod(int argc, char *argv[])
 		switch (c) {
 		case 'p':
 		case 's':
+			/* ignored, for compatibility only */
+			break;
 		case 'f':
 			flags |= KMOD_PROBE_FORCE_MODVERSION;
 			flags |= KMOD_PROBE_FORCE_VERMAGIC;
-- 
2.6.3

