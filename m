Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C29CC4332F
	for <linux-modules@archiver.kernel.org>; Sat, 17 Dec 2022 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLQQxf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 17 Dec 2022 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLQQxe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 17 Dec 2022 11:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C02FAF1
        for <linux-modules@vger.kernel.org>; Sat, 17 Dec 2022 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671295961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VtiAFXUoxPGVWbrfrF2d0QiTT9pcM+3AnAGNlWeoaSw=;
        b=RWEq8K5LAePHcSQP1OtEtAdWrQOo527HrnSF3oxKcVGNy/MkfdwioxUWpv1NGpg6MSzCc8
        jsdXk04F68CE5NnyoxUaeU/EA0dvDZuYQmISUzBBA3M4O/GgTuu5SnhuZugRV6GcU8coko
        nF9dIlldQubiT4+++XGTl/lfnD4UAUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-L_OKN2wJMPycZbZxOl4drA-1; Sat, 17 Dec 2022 11:52:37 -0500
X-MC-Unique: L_OKN2wJMPycZbZxOl4drA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7CB88F46A;
        Sat, 17 Dec 2022 16:52:37 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E62F14171C5;
        Sat, 17 Dec 2022 16:52:36 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kmod: configure.ac: In _Noreturn check, include <stdlib.h>
 for exit
Date:   Sat, 17 Dec 2022 17:52:34 +0100
Message-ID: <877cyq6kh9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Otherwise, an implicit functiona declaration is used, causing
a C99 compatibility issue.

Signed-off-by: Florian Weimer <fweimer@redhat.com>

---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6989e93..12e0518 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,7 +68,8 @@ AC_COMPILE_IFELSE(
 
 AC_MSG_CHECKING([whether _Noreturn is supported])
 AC_COMPILE_IFELSE(
-	[AC_LANG_SOURCE([[_Noreturn int foo(void) { exit(0); }]])],
+	[AC_LANG_SOURCE([[#include <stdlib.h>
+	_Noreturn int foo(void) { exit(0); }]])],
         [AC_DEFINE([HAVE_NORETURN], [1], [Define if _Noreturn is available])
 	 AC_MSG_RESULT([yes])],
 	[AC_MSG_RESULT([no])])

base-commit: 6c5f2f13689e6a4668f87171752d7818bed4b602

