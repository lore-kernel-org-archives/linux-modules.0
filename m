Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CD1C433B4
	for <linux-modules@archiver.kernel.org>; Mon,  3 May 2021 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE586611C2
	for <linux-modules@archiver.kernel.org>; Mon,  3 May 2021 10:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhECKz3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 May 2021 06:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233269AbhECKz1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 May 2021 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620039274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpHwOorPVOQEgoP9pPEURGkgUYHqRyC5N/MgIxtiqJ4=;
        b=Bc+duMtl+rXNCLpVfwloGETWxpAaUx8CBxynhqVEAWhWYKxP6850xromwCGtE5reOlCXpU
        O/OwNEsvhsQxVzUBFocW2wTvccrY0br4khfff+BSTTo1x6d43FDBzq0muZSu+tSlSf/uAg
        Amo9j1Jy6fZXiS0h2vnjEWbI4Z9TTLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-2l2H5YpCMXuaWHY3nFntYg-1; Mon, 03 May 2021 06:54:33 -0400
X-MC-Unique: 2l2H5YpCMXuaWHY3nFntYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32CBF6118F;
        Mon,  3 May 2021 10:54:32 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-112-56.phx2.redhat.com [10.3.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC9B5C230;
        Mon,  3 May 2021 10:54:31 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        Reuben Varghese <rvarghes@redhat.com>
Subject: [PATCH 2/2] Continue temporary support for Blacklist command with warnings
Date:   Mon,  3 May 2021 03:53:47 -0700
Message-Id: <20210503105347.979635-3-rvarghes@redhat.com>
In-Reply-To: <20210503105347.979635-1-rvarghes@redhat.com>
References: <20210503105347.979635-1-rvarghes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Since refactoring blacklist to blocklist without notice will surely
result in a lot of broken systems, temporary support with a warning
that the blacklist command is being deprecated and has been refactored
to blocklist is added.

Signed-off-by: Reuben Varghese <rvarghes@redhat.com>
---
 libkmod/libkmod-config.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index c2ce4cc..084947d 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -476,7 +476,11 @@ static void kcmdline_parse_result(struct kmod_config *config, char *modname,
 
 	DBG(config->ctx, "%s %s\n", modname, param);
 
-	if (streq(modname, "modprobe") && !strncmp(param, "blocklist=", 10)) {
+	if (streq(modname, "modprobe") && (!strncmp(param, "blocklist=", 10) ||
+					   !strncmp(param, "blacklist=", 10))) {
+		if (!strncmp(param, "blacklist=", 10)) {
+			DBG(config->ctx, "Warning: Blacklist command is now deprecated and has been refactored to blocklist\n");
+		}
 		for (;;) {
 			char *t = strsep(&value, ",");
 			if (t == NULL)
@@ -662,9 +666,13 @@ static int kmod_config_parse(struct kmod_config *config, int fd,
 				goto syntax_error;
 
 			kmod_config_add_alias(config, alias, modname);
-		} else if (streq(cmd, "blocklist")) {
+		} else if (streq(cmd, "blacklist") || streq(cmd, "blocklist")) {
 			char *modname = strtok_r(NULL, "\t ", &saveptr);
 
+			if (streq(cmd, "blacklist"))
+				DBG(config->ctx,
+				    "Blacklist command is now deprecated and has been refactored to blocklist. Please edit your config file to reflect this change\n");
+
 			if (underscores(modname) < 0)
 				goto syntax_error;
 
-- 
2.27.0

