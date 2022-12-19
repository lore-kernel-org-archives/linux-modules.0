Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E079C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiLSTTS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiLSTTH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:07 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36811A33
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:06 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso7059855ila.7
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1QcpBS4B8OCRMlI6Nk9ugzJN1lhkA3oxgxR2mhdmU8=;
        b=aZSbLaOZ+GBeKFR5sV7mPGP78KGpvjTZ3MVNmDTTr3vK2vxqlTxaSwFQJjSYRriUaB
         hBXx8NVlBOEdWV0XBakPDChmJfeYXq/KDIQtSrKNqPloEIfLgX2nHAG7k6X+lB1tnjYM
         0mFrrmAZ7Mmm3N+9dFxfanyG1qvWdmzDesSLvdrE11LszZWtyNsUREiJyWszo93d8/8s
         HkCNzmvjGCBnKWb9Mx+udAyuhWBHsxVW94Qy+oRRLOnen7JvimnimXhXLv1EQ45OwmKM
         bKoLNuibpikmWKZ2I7QHTSn0jSdnhlhqur/sdZeXpjlm3604hHGT//rcrgKdKoByq94H
         dY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1QcpBS4B8OCRMlI6Nk9ugzJN1lhkA3oxgxR2mhdmU8=;
        b=XCLLDwm8CnPukA+N007qh8doH9Toe3J7Q5ogVgWdL9ayMjJ/4M3lrWxcKPpzUh5sJN
         MGh9VRgw1esibEpn80XdwII2VGE8OJ9q5Hf4RR3nmzPoDoXd9C79KpaBwWuCKCNFf8v2
         kXhGWlHtR41MXWSDZx6QRrPMxaO5IY10geNIHQpAxU9vGini7u7TExzIDfdqKQP4eXzo
         ofM5cKea9um0NnuzkGfqBh7g0hgqJ2wD+CqffcA7A+LinQtLuqjm37aEVowVhPAoiK4D
         Tfmdq5AC1fOCbKRWdTPtIHLy2L7E3v/CBdeG6/sb5CKidPciVank1dOxRqskfsoQPqEb
         oIuA==
X-Gm-Message-State: ANoB5pnKeC7BF9N01GxPpH8iA14HCl/Jp9l7T8MaxuMDLln0QZ/FqGYu
        1Xt6AOIaEllK+pq3htw15LIWsseHkobaN81KjV3+pwJLyY/VJiWmOK4333CQgQje9Ub7uor2068
        nlJO0e/eF13gY5vfozLgYpCZ6F78CSFi3ko2TslsZxx1j4x9JZaHMkwhsJPS8X0IGSG2lLyB2Rw
        WwkmA=
X-Google-Smtp-Source: AA0mqf76MaacOi4aEpvJ1Isi5klDCra6Jw1gbQxSu25hAbLCWIci9uOG76PMh89gkoiPFeNvKRhu/nk8686ayas=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:c6a5:0:b0:38a:7bae:6a60 with SMTP id
 o5-20020a02c6a5000000b0038a7bae6a60mr5324846jan.37.1671477546412; Mon, 19 Dec
 2022 11:19:06 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:53 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-8-allenwebb@google.com>
Subject: [PATCH v8 7/9] modpost: Add -b option for emitting built-in aliases
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
index 2c80da0220c32..e38d6b2ceea40 100644
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

