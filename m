Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B8C4743E
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF4611BD
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHGb1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhFHGb0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Jun 2021 02:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623133773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUHgXtBVWMDND65bHtO8ldmkfcpw//egRFGJ3wBCtsw=;
        b=R3Bh1edxKIQYLMU9wN/oKOAmwh/GesS4DsXHUo27exQhIsAaUgzDa/EbIwrpFeadOwV2BP
        c/9asizPaN9FyBIVU9dqE/Zql/X/GKcgG5SaFIenAT8+c5BRX9khmT3KRcSriQWyLd0jeC
        5hHZND1DV2lND92cKorzbVsxB9WLIs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-RHf4KZzAOguiS5xhCB2FWg-1; Tue, 08 Jun 2021 02:29:28 -0400
X-MC-Unique: RHf4KZzAOguiS5xhCB2FWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 803AF1854E26;
        Tue,  8 Jun 2021 06:29:27 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 400CC5D6D3;
        Tue,  8 Jun 2021 06:29:26 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH 1/2] libkmod-module: check "new_from_name" return value in get_builtin
Date:   Tue,  8 Jun 2021 09:29:22 +0300
Message-Id: <20210608062923.94017-1-ykaliuta@redhat.com>
In-Reply-To: <20210608062859.93959-1-ykaliuta@redhat.com>
References: <20210608062859.93959-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

kmod_module_new_from_name() may fail and return error value. It is
handled properly across the code, but in this particular place the
check is missing.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index b6320cc87e80..6e0ff1a99604 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2912,7 +2912,10 @@ int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list)
 			goto fail;
 		}
 
-		kmod_module_new_from_name(ctx, modname, &mod);
+		err = kmod_module_new_from_name(ctx, modname, &mod);
+		if (err < 0)
+			goto fail;
+
 		kmod_module_set_builtin(mod, true);
 
 		*list = kmod_list_append(*list, mod);
-- 
2.31.1

