Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA65C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04DF6100C
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbhERPF4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344161AbhERPF4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 May 2021 11:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621350277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCNsQt9Bi1O9TNnmHk6AD9Txq6lRQnp/tsT6IZcTY14=;
        b=Xp4YhTnf1xJ7ovZWe5D3sGvzr9CCkC2nZJ89tJM+N8bzj51F7ggwtztUAR2DcNPqUYZTjZ
        hBJJT6Tq75IeJPrtXhoEC1ffp611CUTehk/6NWtoaaN1RXVb+0tOsNIHYzBjtVDMTExGMQ
        Zm23wu1UBKt3Y51X7JJ3BbLhcdcTLxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-76gKUOxVPVaxceFaEfZueQ-1; Tue, 18 May 2021 11:04:35 -0400
X-MC-Unique: 76gKUOxVPVaxceFaEfZueQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C25107ACF2;
        Tue, 18 May 2021 15:04:34 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-114-37.phx2.redhat.com [10.3.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1BAD10074E0;
        Tue, 18 May 2021 15:04:32 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        Reuben Varghese <rvarghes@redhat.com>
Subject: [PATCH v2 3/3] Continue temporary support for Blacklist command
Date:   Tue, 18 May 2021 08:03:19 -0700
Message-Id: <20210518150319.60941-4-rvarghes@redhat.com>
In-Reply-To: <20210518150319.60941-1-rvarghes@redhat.com>
References: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
 <20210518150319.60941-1-rvarghes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Since refactoring blacklist to blocklist without notice will surely
result in a lot of broken systems, temporary support for the blacklist
command is added.

Signed-off-by: Reuben Varghese <rvarghes@redhat.com>
---
 libkmod/libkmod-config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index ec148c6..a4435ca 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -476,7 +476,8 @@ static void kcmdline_parse_result(struct kmod_config *config, char *modname,
 
 	DBG(config->ctx, "%s %s\n", modname, param);
 
-	if (streq(modname, "modprobe") && !strncmp(param, "blocklist=", 10)) {
+	if (streq(modname, "modprobe") && (!strncmp(param, "blocklist=", 10) ||
+					   !strncmp(param, "blacklist=", 10))) {
 		for (;;) {
 			char *t = strsep(&value, ",");
 			if (t == NULL)
@@ -662,7 +663,7 @@ static int kmod_config_parse(struct kmod_config *config, int fd,
 				goto syntax_error;
 
 			kmod_config_add_alias(config, alias, modname);
-		} else if (streq(cmd, "blocklist")) {
+		} else if (streq(cmd, "blacklist") || streq(cmd, "blocklist")) {
 			char *modname = strtok_r(NULL, "\t ", &saveptr);
 
 			if (underscores(modname) < 0)
-- 
2.27.0

