Return-Path: <SRS0=Ntlk=NT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B0C32789
	for <linux-modules@archiver.kernel.org>; Thu,  8 Nov 2018 11:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766FF20892
	for <linux-modules@archiver.kernel.org>; Thu,  8 Nov 2018 11:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766FF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKHVbs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:31:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeKHVbs (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Nov 2018 16:31:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56B343078AA3;
        Thu,  8 Nov 2018 11:56:39 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.36.118.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B29860920;
        Thu,  8 Nov 2018 11:56:38 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] modprobe: add --show-exports
Date:   Thu,  8 Nov 2018 13:56:37 +0200
Message-Id: <20181108115637.27597-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 08 Nov 2018 11:56:39 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

modprobe has --show-modversions switch, which dumps symbols with
their modversion crcs from the __versions sections.

At the moment the section contains information for the dependency
symbols only, while exported symbols add to symtab entries with
__crc_ prefix (the format may differ, see 1e48901166ef libkmod-elf:
resolve CRC if module is built with MODULE_REL_CRCS).

The patch makes it to show exported symbols as well.

It refactors the --show-modversions code to avoid duplications.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/modprobe.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index 43605ccaf0f0..97da4e6986ce 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -76,6 +76,8 @@ static const struct option cmdopts[] = {
 	{"show-config", no_argument, 0, 'c'},
 	{"show-modversions", no_argument, 0, 4},
 	{"dump-modversions", no_argument, 0, 4},
+	{"show-exports", no_argument, 0, 6},
+	{"dump-exports", no_argument, 0, 6},
 
 	{"dry-run", no_argument, 0, 'n'},
 	{"show", no_argument, 0, 'n'},
@@ -124,6 +126,8 @@ static void help(void)
 		"\t-c, --show-config           Same as --showconfig\n"
 		"\t    --show-modversions      Dump module symbol version and exit\n"
 		"\t    --dump-modversions      Same as --show-modversions\n"
+		"\t    --show-exports          Dump module exported symbol versions and exit\n"
+		"\t    --dump-exports          Same as --show-exports\n"
 		"\n"
 		"General Options:\n"
 		"\t-n, --dry-run               Do not execute operations, just print out\n"
@@ -204,7 +208,9 @@ static int show_config(struct kmod_ctx *ctx)
 	return 0;
 }
 
-static int show_modversions(struct kmod_ctx *ctx, const char *filename)
+static int show_versions(struct kmod_ctx *ctx,
+			 int (*get_versions_f)(const struct kmod_module *, struct kmod_list **),
+			 const char *filename)
 {
 	struct kmod_list *l, *list = NULL;
 	struct kmod_module *mod;
@@ -214,7 +220,7 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
 		return err;
 	}
 
-	err = kmod_module_get_versions(mod, &list);
+	err = get_versions_f(mod, &list);
 	if (err < 0) {
 		LOG("could not get modversions of %s: %s\n",
 			filename, strerror(-err));
@@ -232,6 +238,16 @@ static int show_modversions(struct kmod_ctx *ctx, const char *filename)
 	return 0;
 }
 
+static int show_modversions(struct kmod_ctx *ctx, const char *filename)
+{
+	return show_versions(ctx, kmod_module_get_versions, filename);
+}
+
+static int show_exports(struct kmod_ctx *ctx, const char *filename)
+{
+	return show_versions(ctx, kmod_module_get_symbols, filename);
+}
+
 static int command_do(struct kmod_module *module, const char *type,
 				const char *command, const char *cmdline_opts)
 {
@@ -727,6 +743,7 @@ static int do_modprobe(int argc, char **orig_argv)
 	int do_remove = 0;
 	int do_show_config = 0;
 	int do_show_modversions = 0;
+	int do_show_exports = 0;
 	int err;
 
 	argv = prepend_options_from_env(&argc, orig_argv);
@@ -783,6 +800,9 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 4:
 			do_show_modversions = 1;
 			break;
+		case 6:
+			do_show_exports = 1;
+			break;
 		case 'n':
 			dry_run = 1;
 			break;
@@ -886,6 +906,8 @@ static int do_modprobe(int argc, char **orig_argv)
 		err = show_config(ctx);
 	else if (do_show_modversions)
 		err = show_modversions(ctx, args[0]);
+	else if (do_show_exports)
+		err = show_exports(ctx, args[0]);
 	else if (do_remove)
 		err = rmmod_all(ctx, args, nargs);
 	else if (use_all)
-- 
2.19.1

