Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49418 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965981AbcBCTHl (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Feb 2016 14:07:41 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 4 Feb 2016 05:07:39 +1000
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
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 02/22] ima: refactor ima_policy_show() to display "ima_hooks" rules
Date: Wed,  3 Feb 2016 14:06:10 -0500
Message-Id: <1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Define and call a function to display the "ima_hooks" rules.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 63 +++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0e18cc..43b6425 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -903,6 +903,40 @@ void ima_policy_stop(struct seq_file *m, void *v)
 #define mt(token)	mask_tokens[token]
 #define ft(token)	func_tokens[token]
 
+/*
+ * policy_func_show - display the ima_hooks policy rule
+ */
+static void policy_func_show(struct seq_file *m, enum ima_hooks func)
+{
+	char tbuf[64] = {0,};
+
+	switch (func) {
+	case FILE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_file));
+		break;
+	case MMAP_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_mmap));
+		break;
+	case BPRM_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_bprm));
+		break;
+	case MODULE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_module));
+		break;
+	case FIRMWARE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_firmware));
+		break;
+	case POST_SETATTR:
+		seq_printf(m, pt(Opt_func), ft(func_post));
+		break;
+	default:
+		snprintf(tbuf, sizeof(tbuf), "%d", func);
+		seq_printf(m, pt(Opt_func), tbuf);
+		break;
+	}
+	seq_puts(m, " ");
+}
+
 int ima_policy_show(struct seq_file *m, void *v)
 {
 	struct ima_rule_entry *entry = v;
@@ -924,33 +958,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 
 	seq_puts(m, " ");
 
-	if (entry->flags & IMA_FUNC) {
-		switch (entry->func) {
-		case FILE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_file));
-			break;
-		case MMAP_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_mmap));
-			break;
-		case BPRM_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_bprm));
-			break;
-		case MODULE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_module));
-			break;
-		case FIRMWARE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_firmware));
-			break;
-		case POST_SETATTR:
-			seq_printf(m, pt(Opt_func), ft(func_post));
-			break;
-		default:
-			snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
-			seq_printf(m, pt(Opt_func), tbuf);
-			break;
-		}
-		seq_puts(m, " ");
-	}
+	if (entry->flags & IMA_FUNC)
+		policy_func_show(m, entry->func);
 
 	if (entry->flags & IMA_MASK) {
 		if (entry->mask & MAY_EXEC)
-- 
2.1.0

