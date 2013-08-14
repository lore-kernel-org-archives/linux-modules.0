Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:42173 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab3HNBIq (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 13 Aug 2013 21:08:46 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so560826qcq.1
        for <linux-modules@vger.kernel.org>; Tue, 13 Aug 2013 18:08:46 -0700 (PDT)
Received: from localhost.localdomain ([201.53.216.53])
        by mx.google.com with ESMTPSA id y1sm46172692qaj.2.2013.08.13.18.08.44
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 18:08:45 -0700 (PDT)
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-modules@vger.kernel.org
Subject: [PATCH 2/2] libkmod: Fix getting param with no value from kcmdline
Date: Tue, 13 Aug 2013 22:09:04 -0300
Message-Id: <1376442544-13651-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1376442544-13651-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1376442544-13651-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 libkmod/libkmod-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index cb4cf61..24978c1 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -518,7 +518,7 @@ static void kmod_config_free_softdep(struct kmod_config *config,
 static void kcmdline_parse_result(struct kmod_config *config, char *modname,
 						char *param, char *value)
 {
-	if (modname == NULL || param == NULL || value == NULL)
+	if (modname == NULL || param == NULL)
 		return;
 
 	DBG(config->ctx, "%s %s\n", modname, param);
-- 
1.8.3.4

