Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC35C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiLSUrO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiLSUqk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:40 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874312AE7
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so7208047ilt.0
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHzej/1PRqREjwzL8yy+/gC2rwJnW9I5Nh9PS4uQu5Q=;
        b=qF7j3UMvzJCUsQLLBjLgzSlmOXfqeEaNvw3PLXzeRWDcyY3bD8OOA38EQdGqqCZrSa
         iZncq8o51eeujFRZtBj6GVXss1cKEXggq6R/z5mdQ5oGh7e4OTlkwSEut6Vgt5ailuuP
         Ed8N28NG0EMmlAF45ESity6Pkkw741SVRjm2mDeGj1255GePszv1dQ+FkisGc7bA9Zi+
         PxalhtbeDVQuKtLNXx40YFKl4kZTz7hZ9GB7/D2GRe8u5St+PZ3YIZZ29RK+RgepiQRB
         Zd9kHw0ZtKBVgwDl7AT/HspdSRo1e7RQggsVmuqHRJipm5Guv5SA6HoxE4OVIO2cVfY1
         Ztbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHzej/1PRqREjwzL8yy+/gC2rwJnW9I5Nh9PS4uQu5Q=;
        b=WWpZgq3RBVe/5oF8naGNwFlb5PXqeaNcJzZB6BWBDiDUonDdCiwmx27BOWPbWasR/J
         8ZE1QG5S2UHDf4kXWRULOn030SnnMwQiscWubVxNAsKvBryqG/dd2Im8DJlCv1elQL8o
         cxs/YnQ6jBYjGuujry1jVZE0YHyYdguZudkQ2C0kH0/3O1l6s5GlKICSVnD5ML+pw0gJ
         dp/Lq9obc/i6iqjlID23yuni9h2Exp9UzEiAipqe7ivgBZtGS4W/ckwtOD60EaBjSSef
         jF1VBBp9YzTjUvkfCxl1exeG4PJzSTpTJSb1qP1eY/ahecAI2X1zK5IY2vIJiWaQTk8F
         j5yA==
X-Gm-Message-State: ANoB5pmc6M2A2FpHLfZL2LPXHaWoR19jW0AJu+mrmSMgd47kKa6XfJ1y
        fv6ElDwVWv/mH/n0BsH5DHler0ofxZSp/IrIpYjFeD7ebGRLpyVi7Ne8r3X2fN3LwHLhR9A5enP
        /8X+xU5hj5Rv43nvHkcaytqkMPf+ETNteAYg+JQWnrZ+vENzqBFD3r1Np0vIgyx+B8NbxLqQNik
        Ub9dI=
X-Google-Smtp-Source: AA0mqf6P0aFwhaiO/Hq5T9Jzwbu4P/V1ES2mCZhd8CSbA9Dg3bOw2kpuFSOzPqyC1YM4SB2aGePgn2HQQq3dYk8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a92:cd83:0:b0:300:56a5:ae19 with SMTP id
 r3-20020a92cd83000000b0030056a5ae19mr43568707ilb.72.1671482789512; Mon, 19
 Dec 2022 12:46:29 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:15 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-8-allenwebb@google.com>
Subject: [PATCH v9 07/10] modpost: Add -b option for emitting built-in aliases
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This adds an unimplemented command line flag for writing the built-in
aliases to a file.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/modpost.c | 23 +++++++++++++++++++++--
 scripts/mod/modpost.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..e38d6b2ceea4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2165,6 +2165,19 @@ static void write_if_changed(struct buffer *b, const char *fname)
 	write_buf(b, fname);
 }
 
+/* Write the builtin aliases to the specified file. */
+static void write_builtin(const char *fname)
+{
+	struct buffer buf = { };
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list)
+		buf_write(&buf, mod->modalias_buf.p, mod->modalias_buf.pos);
+
+	write_if_changed(&buf, fname);
+	free(buf.p);
+}
+
 static void write_vmlinux_export_c_file(struct module *mod)
 {
 	struct buffer buf = { };
@@ -2321,13 +2334,16 @@ int main(int argc, char **argv)
 {
 	struct module *mod;
 	char *missing_namespace_deps = NULL;
-	char *dump_write = NULL, *files_source = NULL;
+	char *builtin_write = NULL, *dump_write = NULL, *files_source = NULL;
 	int opt;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:ei:mnT:o:awENd:")) != -1) {
 		switch (opt) {
+		case 'b':
+			builtin_write = optarg;
+			break;
 		case 'e':
 			external_module = true;
 			break;
@@ -2390,6 +2406,9 @@ int main(int argc, char **argv)
 			write_mod_c_file(mod);
 	}
 
+	if (builtin_write)
+		write_builtin(builtin_write);
+
 	if (missing_namespace_deps)
 		write_namespace_deps_files(missing_namespace_deps);
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 34fe5fc0b02c..c55a6aeb46bf 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -123,6 +123,7 @@ struct module {
 	bool has_init;
 	bool has_cleanup;
 	struct buffer dev_table_buf;
+	struct buffer modalias_buf;
 	char	     srcversion[25];
 	// Missing namespace dependencies
 	struct list_head missing_namespaces;
-- 
2.37.3

