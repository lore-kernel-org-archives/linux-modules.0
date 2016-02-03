Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:38010 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966066AbcBCTH6 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:07:58 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:07:56 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 06/22] firmware: fold successful fw read early
Date: Wed,  3 Feb 2016 14:06:14 -0500
Message-Id: <1454526390-19792-7-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

We'll be folding in some more checks on fw_read_file_contents(),
this will make the success case easier to follow.

Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index fb64814..c658cec 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -361,20 +361,18 @@ static int fw_get_filesystem_firmware(struct device *device,
 			continue;
 		rc = fw_read_file_contents(file, buf);
 		fput(file);
-		if (rc)
+		if (rc == 0) {
+			dev_dbg(device, "direct-loading %s\n",
+				buf->fw_id);
+			fw_finish_direct_load(device, buf);
+			goto out;
+		} else
 			dev_warn(device, "loading %s failed with error %d\n",
 				 path, rc);
-		else
-			break;
 	}
+out:
 	__putname(path);
 
-	if (!rc) {
-		dev_dbg(device, "direct-loading %s\n",
-			buf->fw_id);
-		fw_finish_direct_load(device, buf);
-	}
-
 	return rc;
 }
 
-- 
2.1.0

