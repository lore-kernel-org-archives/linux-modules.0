Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:54885 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbcARPZg (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 18 Jan 2016 10:25:36 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 20:46:15 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [RFC PATCH v2 11/11] ima: require signed IMA policy
Date: Mon, 18 Jan 2016 10:11:26 -0500
Message-Id: <1453129886-20192-12-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Require the IMA policy to be signed when additional rules can be added.

Changelog v2:
- add union name "hooks" to fix sparse warning
v1:
- initialize the policy flag
- include IMA_APPRAISE_POLICY in the policy flag

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7a63760..327e691 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -133,6 +133,10 @@ static struct ima_rule_entry default_appraise_rules[] = {
 	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
+#ifdef CONFIG_IMA_WRITE_POLICY
+	{.action = APPRAISE, .hooks.policy_id = POLICY_CHECK,
+	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
 #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
 	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .flags = IMA_FOWNER},
 #else
@@ -414,9 +418,12 @@ void __init ima_init_policy(void)
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
+		if (default_appraise_rules[i].hooks.policy_id == POLICY_CHECK)
+			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 
 	ima_rules = &ima_default_rules;
+	ima_update_policy_flag();
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
-- 
2.1.0

