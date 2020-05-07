Return-Path: <SRS0=HOZ3=6V=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C3FC38A24
	for <linux-modules@archiver.kernel.org>; Thu,  7 May 2020 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B361A2075E
	for <linux-modules@archiver.kernel.org>; Thu,  7 May 2020 07:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgEGHKb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 May 2020 03:10:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43428 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgEGHKa (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 May 2020 03:10:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Txpfxm8_1588835417;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Txpfxm8_1588835417)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 May 2020 15:10:24 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Caspar Zhang <caspar@linux.alibaba.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-modules@vger.kernel.org
Subject: [PATCH v2] libkmod: introduce kmod_module_uniq_options() to improve the reliability of loading module
Date:   Thu,  7 May 2020 15:10:14 +0800
Message-Id: <20200507071014.68136-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

As in commit 2045cdfa1b40 ("netfilter: nf_conntrack: Fix possible possible crash on module loading"),
Loading the nf_conntrack module with doubled hashsize parameter, i.e.
	  modprobe nf_conntrack hashsize=12345 hashsize=12345
causes NULL-ptr deref.

If 'hashsize' specified twice, the nf_conntrack_set_hashsize() function
will be called also twice.

In addition, we may also construct the doubled hashsize parameter scenario by using the following configuration:

$ cat /etc/modprobe.d/firewalld-sysctls.conf
install nf_conntrack /usr/sbin/modprobe --ignore-install nf_conntrack $CMDLINE_OPTS && /usr/sbin/sysctl --quiet --pattern 'net[.]netfilter[.]nf_conntrack.*' --system

$ cat /etc/modprobe.d/nf_conntrack.conf
options nf_conntrack hashsize=187600

$ sudo modprobe nf_conntrack -v
install /usr/sbin/modprobe --ignore-install nf_conntrack $CMDLINE_OPTS && /usr/sbin/sysctl --quiet --pattern 'net[.]netfilter[.]nf_conntrack.*' --system hashsize=187500
insmod /path/to/nf_conntrack.ko hashsize=187500 hashsize=187500

Passing multiple repeated parameters to the kernel may trigger kernel bugs
and affect the performance of loading kernel modules.

We introduce the nf_conntrack_set_hashsize() and hope to solve this problem.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Topi Miettinen <toiwoton@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: linux-modules@vger.kernel.org
---
v2:
- parameters can have spaces.
- reduce memory usage.

 libkmod/libkmod-module.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 libkmod/libkmod.h        |   1 +
 tools/insmod.c           |   7 +++
 3 files changed, 129 insertions(+)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 76a6dc3..a86c8c7 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1076,6 +1076,121 @@ static char *module_options_concat(const char *opt, const char *xopt)
 	return r;
 }
 
+/*
+ * Inspired by the next_arg() in kernel code.
+ * You can use " around spaces, but can't escape ".
+ */
+static unsigned int next_opt_index(const char *args)
+{
+	unsigned int i;
+	int in_quote = 0;
+
+	if (*args == '"')
+		in_quote = 1;
+
+	for (i = 0; args[i]; i++) {
+		if (isspace(args[i]) && !in_quote)
+			break;
+		if (args[i] == '"')
+			in_quote = !in_quote;
+	}
+
+	return i;
+}
+
+static unsigned int cnt_module_options(const char *args)
+{
+	unsigned int nr = 0;
+	unsigned int i = 0;
+
+	while (args[i]) {
+		nr++;
+		i += next_opt_index(args + i);
+		while (isspace(args[i]))
+			i++;
+	}
+	return nr;
+}
+
+struct module_option {
+	unsigned short begin;
+	unsigned short end;
+};
+
+static void parse_module_options(const char *args, unsigned int nr_opts,
+				 struct module_option *opts)
+{
+	unsigned int nr;
+	unsigned int i;
+
+	for (nr = 0, i = 0; nr < nr_opts; nr++) {
+		opts[nr].begin = i;
+		i += next_opt_index(args + i);
+		opts[nr].end = i;
+
+		while (isspace(args[i]))
+			i++;
+	}
+}
+
+static bool is_options_equal(const char *args, struct module_option *left,
+			     struct module_option *right)
+{
+	unsigned int left_len, right_len;
+
+	left_len = left->end - left->begin;
+	right_len = right->end - right->begin;
+	if (left_len != right_len)
+		return false;
+
+	return !memcmp(args+left->begin, args+right->begin, left_len);
+}
+
+KMOD_EXPORT int kmod_module_uniq_options(char **args)
+{
+	struct module_option *opts;
+	unsigned int nr_opts, i, j, k, delta;
+
+	if (!args || !*args)
+		return 0;
+
+	nr_opts = cnt_module_options(*args);
+	opts = calloc(nr_opts, sizeof(struct module_option));
+	if (!opts)
+		return -ENOMEM;
+	parse_module_options(*args, nr_opts, opts);
+
+	for (i = 0; i < nr_opts; i++) {
+		for (j = i+1; j < nr_opts; j++) {
+			if (is_options_equal(*args, &opts[i], &opts[j])) {
+				if (j + 1 < nr_opts)  {
+					memmove(*args + opts[j].begin,
+						*args + opts[j+1].begin,
+						opts[nr_opts-1].end - opts[j+1].begin);
+
+					delta = opts[j+1].begin - opts[j].begin;
+					for (k = j+1; k < nr_opts; k++) {
+						opts[k].begin -= delta;
+						opts[k].end -= delta;
+					}
+
+					memmove(&opts[j], &opts[j+1],
+						(nr_opts-j-1) * sizeof(struct module_option));
+				}
+				nr_opts--;
+				j--;
+			}
+		}
+	}
+
+	if (nr_opts > 0)
+		if ((*args)[opts[nr_opts-1].end])
+			(*args)[opts[nr_opts-1].end] = '\0';
+
+	free(opts);
+	return 0;
+}
+
 static int __kmod_module_get_probe_list(struct kmod_module *mod,
 						bool required,
 						bool ignorecmd,
@@ -1322,6 +1437,12 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
 		options = module_options_concat(moptions,
 					m == mod ? extra_options : NULL);
 
+		err = kmod_module_uniq_options(&options);
+		if (err < 0) {
+			free(options);
+			return err;
+		}
+
 		if (cmd != NULL && !m->ignorecmd) {
 			if (print_action != NULL)
 				print_action(m, true, options ?: "");
diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
index 3cab2e5..774e52a 100644
--- a/libkmod/libkmod.h
+++ b/libkmod/libkmod.h
@@ -186,6 +186,7 @@ int kmod_module_probe_insert_module(struct kmod_module *mod,
 const char *kmod_module_get_name(const struct kmod_module *mod);
 const char *kmod_module_get_path(const struct kmod_module *mod);
 const char *kmod_module_get_options(const struct kmod_module *mod);
+int kmod_module_uniq_options(char **opts);
 const char *kmod_module_get_install_commands(const struct kmod_module *mod);
 const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
 struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
diff --git a/tools/insmod.c b/tools/insmod.c
index c422971..2dc0c22 100644
--- a/tools/insmod.c
+++ b/tools/insmod.c
@@ -132,6 +132,13 @@ static int do_insmod(int argc, char *argv[])
 		opts[optslen] = '\0';
 	}
 
+	err = kmod_module_uniq_options(&opts);
+	if (err < 0) {
+		ERR("kmod_module_uniq_options() failed!\n");
+		free(opts);
+		return err;
+	}
+
 	ctx = kmod_new(NULL, &null_config);
 	if (!ctx) {
 		ERR("kmod_new() failed!\n");
-- 
1.8.3.1

