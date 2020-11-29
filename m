Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF0C64E8A
	for <linux-modules@archiver.kernel.org>; Sun, 29 Nov 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CD20738
	for <linux-modules@archiver.kernel.org>; Sun, 29 Nov 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c49Nl4a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgK2QtQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 29 Nov 2020 11:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbgK2QtP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 29 Nov 2020 11:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606668469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oipVqmKoJWodF1KvUjlY5GRHtnx3/hhLh7rCmoK6Vvw=;
        b=c49Nl4a7liPZONGvCQa1BtkhlhhjcmvDM+0o0BUCzZAdOX4zZrRzNCvn3wLWJESm3K8ZTL
        sbKmpY18+WBY/RrDKabhDdGFbLN+0to/hH8uQR1cYKDWRXVNT6F7NJESpn+CgaZcejz1k3
        E8H7Y0YgdaMWj2AwrD2gINl4CWpu6Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-78tYFD0dMS28vI0U5JBpuA-1; Sun, 29 Nov 2020 11:47:47 -0500
X-MC-Unique: 78tYFD0dMS28vI0U5JBpuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4896E1E7EC;
        Sun, 29 Nov 2020 16:47:46 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-95.ams2.redhat.com [10.36.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DAE35D9D2;
        Sun, 29 Nov 2020 16:47:45 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 3/3] libkmod: kmod_log_null: qualify ctx argument as const
Date:   Sun, 29 Nov 2020 18:47:37 +0200
Message-Id: <20201129164737.135866-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
References: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

kmod_log_null() does not change ctx (does nothing).

Fix warnings

In file included from libkmod/libkmod-index.c:33:
libkmod/libkmod-index.c: In function ‘index_mm_open’:
libkmod/libkmod-index.c:757:6: warning: passing argument 1 of ‘kmod_log_null’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  757 |  DBG(ctx, "file=%s\n", filename);

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index b22ac2a5f89e..398af9ce756a 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -11,7 +11,7 @@
 #include "libkmod.h"
 
 static _always_inline_ _printf_format_(2, 3) void
-	kmod_log_null(struct kmod_ctx *ctx, const char *format, ...) {}
+	kmod_log_null(const struct kmod_ctx *ctx, const char *format, ...) {}
 
 #define kmod_log_cond(ctx, prio, arg...) \
 	do { \
-- 
2.29.2

