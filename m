Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbIKUz7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Sep 2015 16:55:59 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH 2/4] modprobe: Add appropriate error message when path is missing
Date: Fri, 11 Sep 2015 13:55:54 -0700
Message-Id: <1442004956-3868-3-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


Currently, modprobe fails with no output by default if the
search paths it tries are missing:

$ modprobe -S notakernel dm-crypt
$
$ modprobe -S notakernel lkjjweiojo
$

This is fairly cryptic and not at all obvious there is a problem
unless the error code is checked or verbose flags are used.
Add a message to give a better idea that something went wrong.
---
 tools/modprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 3ba8f52..b50a385 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -489,8 +489,11 @@ static int insmod(struct kmod_ctx *ctx, const char *alias,
 						const char *options) = NULL;
 
 	err = kmod_module_new_from_lookup(ctx, alias, &list);
-	if (err < 0)
+	if (err < 0) {
+		ERR("Could not generate list of modules from context\n");
+		ERR("(Is your version correct)?)\n");
 		return err;
+	}
 
 	if (list == NULL) {
 		LOG("Module %s not found.\n", alias);
-- 
2.4.3

