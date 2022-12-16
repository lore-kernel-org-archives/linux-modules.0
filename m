Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D287DC3DA6E
	for <linux-modules@archiver.kernel.org>; Fri, 16 Dec 2022 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLPWRh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLPWRZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Dec 2022 17:17:25 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1E2A97F
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:24 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id g3-20020a056e021a2300b00305e3da9585so2449640ile.16
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+RvplB5wkPH74MUb1wifMfzO8M5nZWLX+/SXGO5TdI=;
        b=q0b1jj9NvHbp3f43Na/217O79cCxnY5MMJB+tmd2m4a9KAMjYiB8BlpdORdqG+ungW
         8rKFadTJM54bK/kumgRMVr1Yguw7JF71Hv3soXH7RaMR95ECsBNUxxq3e1WOSa+u2OI1
         1Y6ix2z7qAGh4XvWq0HnpSOSARb3/Zy5jlbl3nwZp6nIH3KtoMlRZXkF8EBLJGK7iYWk
         6niD7L0/pqfwMKn3UasRrTUGL8l+xEQJlvmdC1bwnoLHzUAGDpruXScii9m9DKrMoHDk
         /aWSB5puTi6SOEntsCfF2g/caz7oOkEyWLgRdcovsvqwpdvh1ZMq8KbdiMvYVh3WCVC5
         RcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+RvplB5wkPH74MUb1wifMfzO8M5nZWLX+/SXGO5TdI=;
        b=Z0ELc+sFkDycJoZNx+tapWNcEwA/ixJw3TqrUTR4Ll77P1ivwNQprfyLsIfF4VGFNW
         q0TyD5iWK37vx5pnCO5niyiJZAPtwAgSVEJsdx232HfDbUy78uILLQYAMWTSJ1Q/N4PH
         3f/LuUQDZUHAwmNNweYtiQvjc2aLV+HUbEMU+oDuBTb+yQyQ/R+ye6ZMvJoFwSnD4RuD
         TepDiX3kgLmjcD9tchC7NMWEDei2NYksfeY41etkg31q+d2hZEb4imtpKldGOyqXL0Va
         V+BJJbcqsL/QY/lMe2NFZ4boNrCtpa1p77TPQmxYcd5oF4W5Q6CAaWmM3hl5uhr+cWLO
         uq6Q==
X-Gm-Message-State: AFqh2kr0xLTUhtKB3AQOWMA+75gJ0AbLj7Y/yEkbOJ4Y8u32fjBCMqmk
        2z5/RzZXiTPmpmWsnyfjqHoxUzpiaLw/dHjEx5gSSeEHoEqFh59NrCdLY2NKAnhXpNPFhHdJzgw
        zb+8CQK6WE6YSd7hVgOep5V4m8O+QtgBODBqj+kIcMAgiOW+IxF3wSeLfIG4Ba5+1/RbZ1JJ3tP
        jk0Ys=
X-Google-Smtp-Source: AMrXdXu/b3LbN3BaGO2amr3yvcbAu+UGbScQX6evGCe9lTPh9LFkZJroFCZzUk59lwh7ey7DgjWZfjQ4rBqCa6A=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:4415:0:b0:6e6:279:2e74 with SMTP id
 r21-20020a6b4415000000b006e602792e74mr235776ioa.10.1671229043653; Fri, 16 Dec
 2022 14:17:23 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:17:01 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216221703.294683-4-allenwebb@google.com>
Subject: [PATCH v7 3/5] modpost: Add -b option for emitting built-in aliases
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
index 2c80da0220c32..845f157d69ebc 100644
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
+	list_for_each_entry(mod, &modules, list) {
+		buf_write(&buf, mod->modalias_buf.p, mod->modalias_buf.pos);
+	}
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
index 34fe5fc0b02cb..c55a6aeb46bfd 100644
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

