Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6]:45015 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcBLSiZ (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 13:38:25 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 00:08:21 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v4 18/19] ima: measure and appraise the IMA policy itself
Date: Fri, 12 Feb 2016 13:29:30 -0500
Message-Id: <1455301771-7703-19-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Add support for measuring and appraising the IMA policy itself.

Changelog v4:
- use braces on both if/else branches, even if single line on one of the
branches - Dmitry
- Use the id mapping - Dmitry

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Petko Manolov <petkan@mip-labs.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_fs.c     | 12 ++++++++++--
 security/integrity/ima/ima_main.c   |  1 +
 security/integrity/ima/ima_policy.c | 11 ++++++++++-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index bd97e0d..5d0f611 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -149,6 +149,7 @@ enum ima_hooks {
 	FIRMWARE_CHECK,
 	KEXEC_KERNEL_CHECK,
 	KEXEC_INITRAMFS_CHECK,
+	POLICY_CHECK,
 	MAX_CHECK
 };
 
@@ -191,6 +192,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_LOG	0x04
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
+#define IMA_APPRAISE_POLICY	0x20
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 57989a4..9f8cb10 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -323,10 +323,18 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	if (result < 0)
 		goto out_free;
 
-	if (data[0] == '/')
+	if (data[0] == '/') {
 		result = ima_read_policy(data);
-	else 
+	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
+		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
+		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				    "policy_update", "signed policy required",
+				    1, 0);
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			result = -EACCES;
+	} else {
 		result = ima_parse_add_rule(data);
+	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
 	kfree(data);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4d0bdf1..b14c1c1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -344,6 +344,7 @@ static int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
+	[READING_POLICY] = POLICY_CHECK
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5ccd3f5..77a9fee 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -114,6 +114,7 @@ static struct ima_rule_entry default_measurement_rules[] = {
 	 .uid = GLOBAL_ROOT_UID, .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] = {
@@ -618,6 +619,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
 				 == 0)
 				entry->func = KEXEC_INITRAMFS_CHECK;
+			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
+				entry->func = POLICY_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -776,6 +779,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		temp_ima_appraise |= IMA_APPRAISE_MODULES;
 	else if (entry->func == FIRMWARE_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
+	else if (entry->func == POLICY_CHECK)
+		temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
@@ -862,7 +867,8 @@ static char *mask_tokens[] = {
 enum {
 	func_file = 0, func_mmap, func_bprm,
 	func_module, func_firmware, func_post,
-	func_kexec_kernel, func_kexec_initramfs
+	func_kexec_kernel, func_kexec_initramfs,
+	func_policy
 };
 
 static char *func_tokens[] = {
@@ -942,6 +948,9 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 	case KEXEC_INITRAMFS_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
 		break;
+	case POLICY_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_policy));
+		break;
 	default:
 		snprintf(tbuf, sizeof(tbuf), "%d", func);
 		seq_printf(m, pt(Opt_func), tbuf);
-- 
2.1.0

