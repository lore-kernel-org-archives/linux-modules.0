Return-Path: <SRS0=f3mb=T2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28153C282E3
	for <linux-modules@archiver.kernel.org>; Sun, 26 May 2019 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83BD2085A
	for <linux-modules@archiver.kernel.org>; Sun, 26 May 2019 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HpZSmkBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfEZJZX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 26 May 2019 05:25:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41665 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfEZJZX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 26 May 2019 05:25:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so9993959wrn.8
        for <linux-modules@vger.kernel.org>; Sun, 26 May 2019 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MaesAHV7XbucgNbiX6OEnJaTvbcp9LTAjcsWKT9apy8=;
        b=HpZSmkBG5yyJgVVoofGsSRQfmey+l43gl9PUqNRclL6w8CVkPCcFOuqsSlc91v9JIc
         Yz/ILGMJiB+Br8Mufv1bWwHiCA607k2r5A9o16WZNXzi1NXZmukoZrE4amEZMKDBvNo3
         BHhzv05eJWB++qV43IXe8CDAa0pBPaWHIi+OBaU71FqooX+XxzutFyD330Z9aqXuck1y
         jMmHW9PspEA25HW15U16nSp8UpLyRYyB0IVStjhBZF0v/OyK+n6NbGFnLK4J3kUQIuv+
         V5GMOoObewmbq+MObJoNxACGmkNYRstcCXJMVQ4JkmnzJxaw/8lyGcwnXLlWl5BKhLLH
         J6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MaesAHV7XbucgNbiX6OEnJaTvbcp9LTAjcsWKT9apy8=;
        b=QjqK8FHEZWa4HiA6zhW8oBzZ+OFFn1U50M3+PS+WQLPn4bEUJYP4jYv+CZfhQR4HW1
         1hsRb7BuzLqFJLnum5QHtubO4TjbOKFsZW0Y2xnyCZiGQ6d5yU5YFI2k/3+9NyWHzWOd
         AwyUiS/JK1yg3K8g6j1U8ETs8R6mtDTCQ4fOUot9QqyNUY5v9zrQ0I8GeHX3AUmBBbZI
         IbI+vD6NDodQBzz4zdyaIpO/R7/zw0r33W5eM/xra0Glx9AXF+CmosNs4ekQYhozjOnA
         xJ347ghIbKJnkRtKD/PRFjM8jPCaafNS+UOb9rgM+bW2Kzz6bAQpzXa3aQ+z4p0cIPxY
         saHA==
X-Gm-Message-State: APjAAAUc1J8ypp3aLRxflAoK29SZhU3xNXCu9yF2ufW1up5N9t8rEssB
        gap3yA4wru5f4SXMWgpBnEf46ILG8yA=
X-Google-Smtp-Source: APXvYqyXhB9Fp4BreffTcI4MFuMN8qCp3lquVgXTuMHyrWCrJ3Vn6T79xNKuEO2OCeBzSZMPGKIpgA==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr4891186wrw.0.1558862721287;
        Sun, 26 May 2019 02:25:21 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 88sm22042444wrc.33.2019.05.26.02.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 02:25:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [kmod][PATCH] module: fix error path in kmod_module_probe_insert_module()
Date:   Sun, 26 May 2019 11:25:12 +0200
Message-Id: <20190526092512.993-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The documentation says that kmod_module_probe_insert_module() will
return >0 if "stopped by a reason given in @flags" but it returns a
negative value if KMOD_PROBE_FAIL_ON_LOADED flag is passed and the
relevant module is already loaded. Fix the error path by using a
positive error value where required.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 libkmod/libkmod-module.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index bffe715..a3afaba 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -1253,7 +1253,7 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
 	if (!(flags & KMOD_PROBE_IGNORE_LOADED)
 					&& module_is_inkernel(mod)) {
 		if (flags & KMOD_PROBE_FAIL_ON_LOADED)
-			return -EEXIST;
+			return EEXIST;
 		else
 			return 0;
 	}
@@ -1304,7 +1304,7 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
 						&& module_is_inkernel(m)) {
 			DBG(mod->ctx, "Ignoring module '%s': already loaded\n",
 								m->name);
-			err = -EEXIST;
+			err = EEXIST;
 			goto finish_module;
 		}
 
@@ -1340,14 +1340,14 @@ finish_module:
 		 * been loaded between the check and the moment we try to
 		 * insert it.
 		 */
-		if (err == -EEXIST && m == mod &&
+		if (err == EEXIST && m == mod &&
 				(flags & KMOD_PROBE_FAIL_ON_LOADED))
 			break;
 
 		/*
 		 * Ignore errors from softdeps
 		 */
-		if (err == -EEXIST || !m->required)
+		if (err == EEXIST || !m->required)
 			err = 0;
 
 		else if (err < 0)
-- 
2.21.0

