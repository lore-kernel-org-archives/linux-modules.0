Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5BC3E8C5
	for <linux-modules@archiver.kernel.org>; Sun, 29 Nov 2020 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ABF20738
	for <linux-modules@archiver.kernel.org>; Sun, 29 Nov 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsjWovAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2QtO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 29 Nov 2020 11:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbgK2QtO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 29 Nov 2020 11:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606668468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7jjJ1AHwBKXNEmiRRaw0Cp3aUEEI2PWUr8JPXLueeI=;
        b=BsjWovAJTX+KsgOB5odGaHmQMb1Jf1MQMk0fWffclxjjmobm+79dosOJccNFhYJDGSS4G8
        4nl95EN9lXn1oT7MTyyxrfwCgoIHqZ2Hvxks41Tv5XiqHKabxJqo6O+S1+tlqIzbap0PDr
        zB0UhRNyODsm5NS/i57Nvg9y/PoeNjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-gTkq62nKOVWNF4cGzzJZ_w-1; Sun, 29 Nov 2020 11:47:45 -0500
X-MC-Unique: gTkq62nKOVWNF4cGzzJZ_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D27DC802B49;
        Sun, 29 Nov 2020 16:47:44 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-95.ams2.redhat.com [10.36.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E445D9D2;
        Sun, 29 Nov 2020 16:47:43 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 2/3] depmod: output_builtin_alias_bin: free idx on error path
Date:   Sun, 29 Nov 2020 18:47:36 +0200
Message-Id: <20201129164737.135866-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
References: <20201129164737.135866-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

idx is allocated in the beginning but it's not freed if there is
a failure after the allocation.

Change the error path: return immediately if idx allocation fails
and then free it in both success and error path at the end.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 875e31480818..2c03dfe7dc28 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2412,10 +2412,8 @@ static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 		return 0;
 
 	idx = index_create();
-	if (idx == NULL) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (idx == NULL)
+		return -ENOMEM;
 
 	ret = kmod_module_get_builtin(depmod->ctx, &builtin);
 	if (ret < 0) {
@@ -2458,13 +2456,12 @@ static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 
 	if (count)
 		index_write(idx, out);
-
-	index_destroy(idx);
-
 fail:
 	if (builtin)
 		kmod_module_unref_list(builtin);
 
+	index_destroy(idx);
+
 	return ret;
 }
 
-- 
2.29.2

