Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3490FC636D6
	for <linux-modules@archiver.kernel.org>; Mon,  6 Feb 2023 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBFOH6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBFOHi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Feb 2023 09:07:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309AD2B2BB
        for <linux-modules@vger.kernel.org>; Mon,  6 Feb 2023 06:05:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so8744579wmo.5
        for <linux-modules@vger.kernel.org>; Mon, 06 Feb 2023 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5LBPPC6VJqJRGNnqIbBmTwVGauwH0wWFkN7euAdafw=;
        b=kY9Ard9iCQYfY5vM4vOfLX45sOo4rw1lsmEh0K/m/h9nWYLpatCPvWcs5gi2Shk7ty
         B20yJUYjAr6vQZAah2ouvmezGNGN0DniHOqyWR1l1Xe/Yl/5Jsd9dUP/D6SqmAZQy7pC
         FaHUIv2U0XNnX3fseCRMqPTsrYmuFDpYDBhxp9/MxKIts0kltR4sqQ4B9X93/Q/HdHkd
         br+EqLJ3AX1t8I3yf2JK7fX4uKChlrYaskiu8XGVkoiS4Xe5JWSxG4uqQ8PfDGjDwPJn
         x/k0EpJFn5OS7T8fgCJvp+bjCJ1z57aJTqxoYKVzX0C0Wjs/PaxtD7VHlvfwshsuHm+Y
         EBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5LBPPC6VJqJRGNnqIbBmTwVGauwH0wWFkN7euAdafw=;
        b=v0pKuBD0ANLfen+G1mPycLissOCEusq0Gib/2CXJqUAqK2Dd4Dgb0yhnrWDi39xTbY
         YN8efB8hmjNDBwzbbOtGbZisnvKkC5lXaaSzgMnnkSEznrFXOWPLPQuB7Hl1wce7eEeA
         R6KnFEyMlUI9/IZQEI74ddkTNff2oFxO06fU522ZpMSO4pjorv4BD3SeqrYOMwOPbAsd
         lH+/4vJUlI91OHgJtSHXypvI929MLOrQf8IMb4P1BMUpubj66KbgeJpoFaceNgQcocif
         g6neB1RH2ZmGlYacwt4D5LSSh2BR5U0ZyJblcrweqQjxNCXCy8A29j2eBUQIyXYmfUmg
         1XTA==
X-Gm-Message-State: AO0yUKWhZAA2r25Vw2VdvgvIl1wzfCGyttzT/z2SF8whPK15jGqhdfc+
        Wek3HQ1eV7S7w4erxE9elNgzV007KH4=
X-Google-Smtp-Source: AK7set+HVty+N9H/R+myPq4+Ae5oXSa4x8SI8kjZnCW8DrtkLLAW/lix7+E+/+CIUPcfwlGe2zBxxw==
X-Received: by 2002:a05:600c:4f83:b0:3e0:11a:3849 with SMTP id n3-20020a05600c4f8300b003e0011a3849mr1346856wmq.39.1675692292947;
        Mon, 06 Feb 2023 06:04:52 -0800 (PST)
Received: from localhost ([2a00:5f00:102:0:9503:21c4:e16b:65c3])
        by smtp.gmail.com with UTF8SMTPSA id n10-20020a05600c4f8a00b003e0010a9f67sm3647969wmq.44.2023.02.06.06.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:04:52 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 2/4] testsuite: add function declarations for __xstat family
Date:   Mon,  6 Feb 2023 14:04:47 +0000
Message-Id: <20230206140449.574631-3-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206140449.574631-1-emil.l.velikov@gmail.com>
References: <20230206140449.574631-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

As the inline comment says - the declarations have been dropped with
glibc 2.32.9000, as a result the build throws a set of lovely warnings.

Inspired by umockdev, which bears the same license as this project.
https://github.com/martinpitt/umockdev/commit/f1b416400479d861deffb4c5a40422dcdf190e85

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 testsuite/path.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testsuite/path.c b/testsuite/path.c
index c1ae498..5a291b1 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -163,8 +163,15 @@ TS_EXPORT int open ## suffix (const char *path, int flags, ...)	\
 	return _fn(p, flags);					\
 }
 
-/* wrapper template for __xstat family */
+/*
+ * wrapper template for __xstat family
+ * This family got deprecated/dropped in glibc 2.32.9000, but we still need
+ * to keep it for a while for programs that were built against previous versions
+ */
 #define WRAP_VERSTAT(prefix, suffix)			    \
+TS_EXPORT int prefix ## stat ## suffix (int ver,	    \
+			      const char *path,		    \
+	                      struct stat ## suffix *st);   \
 TS_EXPORT int prefix ## stat ## suffix (int ver,	    \
 			      const char *path,		    \
 	                      struct stat ## suffix *st)    \
-- 
2.39.1

