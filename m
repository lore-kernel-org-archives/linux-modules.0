Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:43009 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbcBLSht (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:37:49 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:07:47 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ming Lei <ming.lei@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	=?UTF-8?q?Vojt=C4=9Bch=20Pavl=C3=ADk?= <vojtech@suse.cz>,
	Kyle McMartin <kyle@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 01/19] firmware: simplify dev_*() print messages for generic helpers
Date: Fri, 12 Feb 2016 13:29:13 -0500
Message-Id: <1455301771-7703-2-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

Simplify a few of the *generic* shared dev_warn() and dev_dbg()
print messages for three reasons:

0) Historically firmware_class code was added to help
   get device driver firmware binaries but these days
   request_firmware*() helpers are being repurposed for
   general *system data* needed by the kernel.

1) This will also help generalize shared code as much as possible
   later in the future in consideration for a new extensible firmware
   API which will enable to separate usermode helper code out as much
   as possible.

2) Kees Cook pointed out the the prints already have the device
   associated as dev_*() helpers are used, that should help identify
   the user and case in which the helpers are used. That should provide
   enough context and simplifies the messages further.

v4: generalize debug/warn messages even further as suggested by
    Kees Cook.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ming Lei <ming.lei@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Vojtěch Pavlík <vojtech@suse.cz>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_class.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index b9250e5..ce88355 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -353,15 +353,15 @@ static int fw_get_filesystem_firmware(struct device *device,
 		rc = fw_read_file_contents(file, buf);
 		fput(file);
 		if (rc)
-			dev_warn(device, "firmware, attempted to load %s, but failed with error %d\n",
-				path, rc);
+			dev_warn(device, "loading %s failed with error %d\n",
+				 path, rc);
 		else
 			break;
 	}
 	__putname(path);
 
 	if (!rc) {
-		dev_dbg(device, "firmware: direct-loading firmware %s\n",
+		dev_dbg(device, "direct-loading %s\n",
 			buf->fw_id);
 		mutex_lock(&fw_lock);
 		set_bit(FW_STATUS_DONE, &buf->status);
@@ -1051,7 +1051,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	if (fw_get_builtin_firmware(firmware, name)) {
-		dev_dbg(device, "firmware: using built-in firmware %s\n", name);
+		dev_dbg(device, "using built-in %s\n", name);
 		return 0; /* assigned */
 	}
 
-- 
2.1.0

