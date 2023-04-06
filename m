Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64BC7618D
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjDFTBc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjDFTBX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:23 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8922735
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:04 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id q17-20020a056e020c3100b003245df8be9fso26453034ilg.14
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPtoJrKBH3N2nk7pm0WBiOte1w3zyXs+2rCz5/qKsmI=;
        b=X+v0xVsX9ePu+gtwgv1xggQ+b9AWSfR2kutza91lJ4sEaRsWLI9aUai/oOu71s6gex
         085PISyP11GQiy5TpHe2KqUiiMys2wj6F3LZKs5fY+J3Euxw/MW+oV/FzVW5akzVCEWr
         Qu5KuDjMRCJLNQE2PQELcL1qsl5c3UE5cppY4EeC0WUbfohnh8Rb91QCTO2vr1Jum8eD
         IL/nYTUBqV+289xqR3EbtbZO4r6o2gkaZ9oSaqJyrcQ7KjYOFHXumoiW5Zkfb4k1DmEx
         p7lyo49HTkd6WcC1RTXvZKvH4Mp3QBWwR7HpWyThE8NkxJ8/AodWw2njEC2lbvvSLDEg
         XUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPtoJrKBH3N2nk7pm0WBiOte1w3zyXs+2rCz5/qKsmI=;
        b=GF5BsIHjcKiAVgBFvzv3b1XLsfMhT5H2M1QrGktdWZR374ZiP+6Ap+UpTPqHchqECr
         UB5hKqbPFeveMZu9+H/KLYwtkX4GdF9nlT2GWvyNOlI7R5QRKugh/inA7ClKu2x5/NjE
         /5iBnUSpjuqA7czJ17Q1zhgVKj/U1WJBIrfhX66CVwFssagqP5zuWBfAUnDN39YwolGs
         brVke5fww6lao2xQNPSlrWOvcDCCtWXJwXuu6cVl3wFeo4pfHESIIbdZxkgDvN2rMfa/
         ORzqWlGQmi+88JjDEOvV/NEr4ivUl9XJPaYgdPks4X66YVYlBlGyeqLxTMJJoI8xOd48
         1d6A==
X-Gm-Message-State: AAQBX9f0SX6Hu79c5sL7/l0QIcDv6duk9M0rj+itB8H3/Y1ZFCaSuH+1
        FQ+k42MYqQmfuM8vI0cH8i2EDT/R7a+AGQfqGIOgIZMEQyycQQ0yt7FIc2yViHj3pUKFhyRI7TC
        +zA71nDZwY3yU5aKihnmoNLP1CZPEwrO0cRsYkPHCfE3h4h7KAaVI303tSbMEmXybbn1B6F1juH
        1dmko=
X-Google-Smtp-Source: AKy350b3ywgYGOuNRaHCfri+YC25Y0XY6ETeOx4MfHOdbQbf18wi5MjpLqXr6pg04A8qD1H12AIVIIUEY6rzGOQ=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:85ae:0:b0:3ec:dc1f:12dd with SMTP id
 d43-20020a0285ae000000b003ecdc1f12ddmr6262286jai.6.1680807663728; Thu, 06 Apr
 2023 12:01:03 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:25 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-7-allenwebb@google.com>
Subject: [PATCH v10 06/11] modpost: Add -b option for emitting built-in aliases
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This adds a command line option for writing the match-id based built-in
aliases to a file. A future patch extends file2alias.c to support this
command.

The -b option accepts the output path as a parameter and requires
vmlinuz.o to be one of the input files for the aliases to be found.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/modpost.c | 30 ++++++++++++++++++++++++++++--
 scripts/mod/modpost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index efff8078e395..2e452aec0fc6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2173,6 +2173,19 @@ static void write_if_changed(struct buffer *b, const char *fname)
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
@@ -2329,13 +2342,23 @@ int main(int argc, char **argv)
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
+			/*
+			 * Writes the match-id based built-in module aliases to
+			 * the specified path.
+			 *
+			 * vmlinuz.o needs to be one of the input files for the
+			 * aliases to be found.
+			 */
+			builtin_write = optarg;
+			break;
 		case 'e':
 			external_module = true;
 			break;
@@ -2398,6 +2421,9 @@ int main(int argc, char **argv)
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
2.39.2

