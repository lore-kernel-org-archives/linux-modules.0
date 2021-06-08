Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC5C47082
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4ADA611BD
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHGbZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhFHGbZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Jun 2021 02:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623133772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0llFSsTx/qD5gM+s8gBBU01BKIGllkirAksdScauCw=;
        b=P8HDzGNdT/f6jgFZKmItujU/3290r/zqoO88ajJXUvBxhyRXNHVKEYwqBivIAnJduUDF2a
        Oph4nyumSE6i8Sp5tIKomVpGIWYt/v1hECMk1J67oS8fOV7MJQIPd6xdwyS5aYk5mIbBcG
        KN23b47Ktl6Q2UHZeD3x2csrYbzD7mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-ombDERraMSOUPDvp0jMIMg-1; Tue, 08 Jun 2021 02:29:30 -0400
X-MC-Unique: ombDERraMSOUPDvp0jMIMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0131854E2A;
        Tue,  8 Jun 2021 06:29:29 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEBA15D6D3;
        Tue,  8 Jun 2021 06:29:27 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH 2/2] libkmod-builtin: consider final NIL in name length check
Date:   Tue,  8 Jun 2021 09:29:23 +0300
Message-Id: <20210608062923.94017-2-ykaliuta@redhat.com>
In-Reply-To: <20210608062923.94017-1-ykaliuta@redhat.com>
References: <20210608062859.93959-1-ykaliuta@redhat.com>
 <20210608062923.94017-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

There is potential buffer overrun in kmod_builtin_iter_get_modname()
for the name of length PATH_MAX. The required buffer size is
PATH_MAX, so `modname[len] = '\0'` with len == PATH_MAX will write
right beyond the buffer.

Check the length against PATH_MAX - 1.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 libkmod/libkmod-builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index a002cb5ee2c6..3d4d77ab29b3 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -246,7 +246,7 @@ bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
 
 	len = dot - line;
 
-	if (len >= PATH_MAX) {
+	if (len >= PATH_MAX - 1) {
 		sv_errno = ENAMETOOLONG;
 		goto fail;
 	}
-- 
2.31.1

