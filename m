Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:39575 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbcBLScP (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:32:15 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:02:13 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 16/19] ima: support for kexec image and initramfs
Date: Fri, 12 Feb 2016 13:29:28 -0500
Message-Id: <1455301771-7703-17-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Add IMA policy support for measuring/appraising the kexec image and
initramfs. Two new IMA policy identifiers KEXEC_KERNEL_CHECK and
KEXEC_INITRAMFS_CHECK are defined.

Example policy rules:
measure func=KEXEC_KERNEL_CHECK
appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig
measure func=KEXEC_INITRAMFS_CHECK
appraise func=KEXEC_INITRAMFS_CHECK appraise_type=imasig

Moving the enumeration to the vfs layer simplified the patches, allowing
the IMA changes, for the most part, to be separated from the other
changes.  Unfortunately, passing either a kernel_read_file_id or a
ima_hooks enumeration within IMA is messy.

Option 1: duplicate kernel_read_file enumeration in ima_hooks

enum kernel_read_file_id {
	...
        READING_KEXEC_IMAGE,
        READING_KEXEC_INITRAMFS,
        READING_MAX_ID

enum ima_hooks {
	...
	KEXEC_KERNEL_CHECK
	KEXEC_INITRAMFS_CHECK

Option 2: define ima_hooks as extension of kernel_read_file
eg: enum ima_hooks {
        FILE_CHECK = READING_MAX_ID,
        MMAP_CHECK,

In order to pass both kernel_read_file_id and ima_hooks values, we
would need to specify a struct containing a union.

struct caller_id {
        union {
                enum ima_hooks func_id;
                enum kernel_read_file_id read_id;
        };
};

Option 3: incorportate the ima_hooks enumeration into kernel_read_file_id,
perhaps changing the enumeration name.

For now, duplicate the new READING_KEXEC_IMAGE/INITRAMFS in the ima_hooks.

Changelog v4:
- replaced switch statement with a kernel_read_file_id to an ima_hooks
id mapping array - Dmitry
- renamed ima_hook tokens KEXEC_CHECK and INITRAMFS_CHECK to
KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK respectively - Dave Young

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Petko Manolov <petkan@mip-labs.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Dave Young <dyoung@redhat.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 security/integrity/ima/ima.h         |  2 ++
 security/integrity/ima/ima_main.c    | 15 +++++++++------
 security/integrity/ima/ima_policy.c  | 15 ++++++++++++++-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 0a378a8..bb0f9a1 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -27,6 +27,7 @@ Description:
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
+				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a5d2592..bd97e0d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -147,6 +147,8 @@ enum ima_hooks {
 	POST_SETATTR,
 	MODULE_CHECK,
 	FIRMWARE_CHECK,
+	KEXEC_KERNEL_CHECK,
+	KEXEC_INITRAMFS_CHECK,
 	MAX_CHECK
 };
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f6039f5..4d0bdf1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -339,6 +339,13 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
+static int read_idmap[READING_MAX_ID] = {
+	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_MODULE] = MODULE_CHECK,
+	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
+	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
+};
+
 /**
  * ima_post_read_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
@@ -355,7 +362,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
-	enum ima_hooks func = FILE_CHECK;
+	enum ima_hooks func;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -373,11 +380,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (read_id == READING_FIRMWARE)
-		func = FIRMWARE_CHECK;
-	else if (read_id == READING_MODULE)
-		func = MODULE_CHECK;
-
+	func = read_idmap[read_id] ?: FILE_CHECK;
 	return process_measurement(file, buf, size, MAY_READ, func, 0);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7571ce8..5ccd3f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -612,6 +612,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = MMAP_CHECK;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
 				entry->func = BPRM_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_KERNEL_CHECK") ==
+				 0)
+				entry->func = KEXEC_KERNEL_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
+				 == 0)
+				entry->func = KEXEC_INITRAMFS_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -855,7 +861,8 @@ static char *mask_tokens[] = {
 
 enum {
 	func_file = 0, func_mmap, func_bprm,
-	func_module, func_firmware, func_post
+	func_module, func_firmware, func_post,
+	func_kexec_kernel, func_kexec_initramfs
 };
 
 static char *func_tokens[] = {
@@ -929,6 +936,12 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 	case POST_SETATTR:
 		seq_printf(m, pt(Opt_func), ft(func_post));
 		break;
+	case KEXEC_KERNEL_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_kexec_kernel));
+		break;
+	case KEXEC_INITRAMFS_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
+		break;
 	default:
 		snprintf(tbuf, sizeof(tbuf), "%d", func);
 		seq_printf(m, pt(Opt_func), tbuf);
-- 
2.1.0

