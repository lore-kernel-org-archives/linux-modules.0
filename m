Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:33117 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbcBLSaq (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:30:46 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:00:43 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 03/19] firmware: clean up filesystem load exit path
Date: Fri, 12 Feb 2016 13:29:15 -0500
Message-Id: <1455301771-7703-4-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

This makes the error and success paths more readable while trying to
load firmware from the filesystem.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: David Howells <dhowells@redhat.com>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 7bc4ad0..c743a2f 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -361,19 +361,17 @@ static int fw_get_filesystem_firmware(struct device *device,
 			continue;
 		rc = fw_read_file_contents(file, buf);
 		fput(file);
-		if (rc)
+		if (rc) {
 			dev_warn(device, "loading %s failed with error %d\n",
 				 path, rc);
-		else
-			break;
-	}
-	__putname(path);
-
-	if (!rc) {
+			continue;
+		}
 		dev_dbg(device, "direct-loading %s\n",
 			buf->fw_id);
 		fw_finish_direct_load(device, buf);
+		break;
 	}
+	__putname(path);
 
 	return rc;
 }
-- 
2.1.0

