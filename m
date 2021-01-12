Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A096FC43381
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6604F21919
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jan 2021 16:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405691AbhALQC7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:02:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:46574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405624AbhALQC7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 12 Jan 2021 11:02:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A972AC24;
        Tue, 12 Jan 2021 16:02:18 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        =?UTF-8?q?Marcus=20R=C3=BCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>
Subject: [PATCH] modprobe.d: load from /usr/lib.
Date:   Tue, 12 Jan 2021 17:02:11 +0100
Message-Id: <20210112160211.5614-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

There is an ongoing effort to limit use of files outside of /usr (or
$prefix on general). Currently all modprobe.d paths are hardcoded to
outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.

Cc: Marcus Rückert <mrueckert@suse.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Dominique Leuenberger <dimstar@opensuse.org>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Makefile.am        | 1 +
 libkmod/libkmod.c  | 1 +
 man/modprobe.d.xml | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index b29e943a4d29..702a665f0334 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,7 @@ AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-I$(top_srcdir) \
 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
+	-DPREFIX=\""$(prefix)"\" \
 	${zlib_CFLAGS}
 
 AM_CFLAGS = $(OUR_CFLAGS)
diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 43423d63a889..9399c6c902f8 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -65,6 +65,7 @@ static const char *default_config_paths[] = {
 	SYSCONFDIR "/modprobe.d",
 	"/run/modprobe.d",
 	"/lib/modprobe.d",
+	PREFIX "/lib/modprobe.d",
 	NULL
 };
 
diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 211af8488abb..ae5a83986a52 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -40,6 +40,7 @@
   </refnamediv>
 
   <refsynopsisdiv>
+    <para><filename>/usr/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/lib/modprobe.d/*.conf</filename></para>
     <para><filename>/etc/modprobe.d/*.conf</filename></para>
     <para><filename>/run/modprobe.d/*.conf</filename></para>
-- 
2.26.2

