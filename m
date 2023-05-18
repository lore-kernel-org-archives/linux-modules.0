Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4BC77B7D
	for <linux-modules@archiver.kernel.org>; Thu, 18 May 2023 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjERLAT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 18 May 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjERLAS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 18 May 2023 07:00:18 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED7E8
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 04:00:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:f15:0:640:e80a:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id C943646CF0
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 14:00:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 10bwRhODV8c0-77Rc9JEx;
        Thu, 18 May 2023 14:00:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684407613;
        bh=Xg/apLxqiG9xx2/odjvlIOiF7vzm+LJEvjO5SDM4d9A=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=WjOPhb4KTdhnJb5q7lWVbO+cQULUoCcnqyLHHQogeYZva9lC7Y6SZsUY5WQeh6aT6
         hDaksrtY+0234PsZgNSZmsAWeiX7DekKGyh9EMOcILidwCLtNsg3TCokAntISEVydA
         jLnky1Zgk1Kr4KZUpiPebuAMMjvsfvelPfWz9u3c=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] libkmod: fix possible out-of-bounds memory access
Date:   Thu, 18 May 2023 14:00:00 +0300
Message-Id: <20230518110000.62061-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

An attempt to pass too long module name to, say, rmmod, may
cause an out-of-bounds memory access (as repoted by UBSan):

$ rmmod $(for i in $(seq 0 4200); do echo -ne x; done)
libkmod/libkmod-module.c:1828:8: runtime error: index 4107 out of bounds for type 'char [4096]'

This is because 'snprintf(path, sizeof(path), ...)' may return the
value which exceeds 'sizeof(path)' (which happens when an output
gets truncated). To play it safe, such a suspicious output is
better to be rejected explicitly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 libkmod/libkmod-module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1da64b3..074001e 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1810,6 +1810,10 @@ KMOD_EXPORT int kmod_module_get_initstate(const struct kmod_module *mod)
 
 	pathlen = snprintf(path, sizeof(path),
 				"/sys/module/%s/initstate", mod->name);
+	if (pathlen >= (int)sizeof(path)) {
+		/* Too long path was truncated */
+		return -EINVAL;
+	}
 	fd = open(path, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
 		err = -errno;
-- 
2.40.1

