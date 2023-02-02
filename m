Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D90C05027
	for <linux-modules@archiver.kernel.org>; Thu,  2 Feb 2023 13:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBBNs4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjBBNsn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Feb 2023 08:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0E8F27B
        for <linux-modules@vger.kernel.org>; Thu,  2 Feb 2023 05:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675345663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gUF3HpY/q4yhbJZLh1X6sV3/WjUyr6VAgXHCmpsp8gI=;
        b=LoUQlsJCLwBrKBg33v7g4m0ESHdxUl9rnXUCMKQUJV8mGKkE2R0o1kTthi7JoMC2GpqWs1
        D0QN4AvSG0gn8xHCmcbdaxI5vTOyz2vG3xp0n0N9/QWlPtr6+/Jcrjdl64tu+Y0cLscpO7
        uW7v8dJqhpAPF1eV3E98xz92/Z9dV9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-J0SoSKsMN5GSQoJfBkkAVw-1; Thu, 02 Feb 2023 08:47:39 -0500
X-MC-Unique: J0SoSKsMN5GSQoJfBkkAVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6185185A5A3;
        Thu,  2 Feb 2023 13:47:39 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 718A6404BEC0;
        Thu,  2 Feb 2023 13:47:38 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH] man/rmmod: explain why modprobe -r is more useful
Date:   Thu,  2 Feb 2023 15:47:36 +0200
Message-Id: <20230202134736.405778-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Improve user experience by explaining the option so the user may
not search explanations in other manpages (modprobe).

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 man/rmmod.xml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man/rmmod.xml b/man/rmmod.xml
index e7c7e5f9e7dc..67bcbedd972b 100644
--- a/man/rmmod.xml
+++ b/man/rmmod.xml
@@ -52,7 +52,8 @@
       want to use
       <citerefentry>
         <refentrytitle>modprobe</refentrytitle><manvolnum>8</manvolnum>
-      </citerefentry> with the <option>-r</option> option instead.
+      </citerefentry> with the <option>-r</option> option instead
+      since it removes unused dependent modules as well.
     </para>
   </refsect1>
 
-- 
2.39.1

