Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49473 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966054AbcBCTHx (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:07:53 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:07:52 +1000
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
Subject: [PATCH v3 05/22] firmware: move completing fw into a helper
Date: Wed,  3 Feb 2016 14:06:13 -0500
Message-Id: <1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

This will be re-used later through a new extensible interface.

Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 3358f5d..fb64814 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -322,6 +322,15 @@ fail:
 	return rc;
 }
 
+static void fw_finish_direct_load(struct device *device,
+				  struct firmware_buf *buf)
+{
+	mutex_lock(&fw_lock);
+	set_bit(FW_STATUS_DONE, &buf->status);
+	complete_all(&buf->completion);
+	mutex_unlock(&fw_lock);
+}
+
 static int fw_get_filesystem_firmware(struct device *device,
 				       struct firmware_buf *buf)
 {
@@ -363,10 +372,7 @@ static int fw_get_filesystem_firmware(struct device *device,
 	if (!rc) {
 		dev_dbg(device, "direct-loading %s\n",
 			buf->fw_id);
-		mutex_lock(&fw_lock);
-		set_bit(FW_STATUS_DONE, &buf->status);
-		complete_all(&buf->completion);
-		mutex_unlock(&fw_lock);
+		fw_finish_direct_load(device, buf);
 	}
 
 	return rc;
-- 
2.1.0

