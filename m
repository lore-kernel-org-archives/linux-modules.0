Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2]:36169 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcBLSha (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:37:30 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:07:27 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 02/19] firmware: move completing fw into a helper
Date: Fri, 12 Feb 2016 13:29:14 -0500
Message-Id: <1455301771-7703-3-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

This will be re-used later through a new extensible interface.

Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_class.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index ce88355..7bc4ad0 100644
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

