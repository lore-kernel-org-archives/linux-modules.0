Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33054 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbcBDVPE (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 16:15:04 -0500
Received: by mail-pa0-f45.google.com with SMTP id cy9so21687063pac.0
        for <linux-modules@vger.kernel.org>; Thu, 04 Feb 2016 13:15:03 -0800 (PST)
Date: Thu, 4 Feb 2016 13:15:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v3.1] firmware: clean up filesystem load exit path
Message-ID: <20160204211501.GA14755@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This makes the error and success paths more readable while trying to
load firmware from the filesystem.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"
---
 drivers/base/firmware_class.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 62e052b50aa9..484afbd783f8 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -352,19 +352,17 @@ static int fw_get_filesystem_firmware(struct device *device,
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
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
