Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCFC83F15
	for <linux-modules@archiver.kernel.org>; Wed, 30 Aug 2023 18:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbjH3S47 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbjH3P6j (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 30 Aug 2023 11:58:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28027193
        for <linux-modules@vger.kernel.org>; Wed, 30 Aug 2023 08:58:35 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBCA53F660
        for <linux-modules@vger.kernel.org>; Wed, 30 Aug 2023 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693411113;
        bh=kNl44J2ZpGtCg94K9UACjS58K5Vqnr8rgjyDZbU7cks=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AdC/2E0roNN+6OR32B4t1a77YI+T7dEdLwaY/YtJjHsNbRCbwutgfydNyWwx9cMw7
         C3cgn9uh/JWB4VV13s9VPu7lRgviWTAWjQO0KA/9J8XajPZThsun28T0UJ3QhSBAoI
         LYr1M4tau/mqI6EEvnBdHqhwKfHujnW8H+T7Sa93AKfBQdvKdiwo1sc/+Z9niINfVQ
         SA5d7WIaruF3U87h86NM9NsJ8O9fSnkbbA75BhguS6EluLju72GdT4AZiy5FV3KBDz
         +fCTPjjT1/jQtvS1umb9+ClJGuQ5upKH7LWuOVvJK85uhim6VF4HnJjlfgBJkILCKU
         qZ93ba0tMWtuw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso4552648a12.1
        for <linux-modules@vger.kernel.org>; Wed, 30 Aug 2023 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411113; x=1694015913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNl44J2ZpGtCg94K9UACjS58K5Vqnr8rgjyDZbU7cks=;
        b=WEZG73b5Rk3tlEe6gK6gTQNlLzjX7ZIodmWCmiTmk0QGAgEhT7TOnjyHhc+kVV7D79
         ohUQezhW6h2Gaswyyc99EuyinibR+zLgYMLW0vI9rz3P8T5rsWug6uK/13X+PU9BqVHS
         cJjg5jsgbeOVHz9F4gT9L3VmnB2tQnEHm71j2bKHVkT2wey98sOK+e15V4sni2LxRxJn
         p3CxbNpv8/2NIO2OlJGywQxg6DGKyR2vIoVbADWzRHX4cM2cLkBnZWGd/RXua4In4963
         qtouV2ItD90SqwePWJdW1e1Zynh+5yTQxVwDCKUcnVuhdsmdd9Y0EMTEl+vtt0OKgrav
         XiGw==
X-Gm-Message-State: AOJu0YxwP2JtumrFjqNfW8ghk7BpE6ONvQKQNCHHXMZd/osLlxLOcXtq
        IGj/0eKmWrD/ycvrczYG2sLeENfGIRivpHAfEQ8jbnzFvQHsROgH4TmrrXv2utxQDajOzRGPj0r
        ECpTrY/3N01sw4rXAWgkOI8Hah+Fr/Qc61tjyemc+nkc=
X-Received: by 2002:aa7:db54:0:b0:523:b225:701a with SMTP id n20-20020aa7db54000000b00523b225701amr2358939edt.11.1693411113072;
        Wed, 30 Aug 2023 08:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsdD7OzcrsdeyrB/2Brhvlhgug8gC90+0ErPZscEzGSa0PRuYEokx7nmqzcPnfwSlgGRmjuA==
X-Received: by 2002:aa7:db54:0:b0:523:b225:701a with SMTP id n20-20020aa7db54000000b00523b225701amr2358915edt.11.1693411112729;
        Wed, 30 Aug 2023 08:58:32 -0700 (PDT)
Received: from localhost.localdomain (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm6906970edr.78.2023.08.30.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:58:32 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module/decompress: use vmalloc() for gzip decompression workspace
Date:   Wed, 30 Aug 2023 17:58:20 +0200
Message-Id: <20230830155820.138178-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Use a similar approach as commit a419beac4a07 ("module/decompress: use
vmalloc() for zstd decompression workspace") and replace kmalloc() with
vmalloc() also for the gzip module decompression workspace.

In this case the workspace is represented by struct inflate_workspace
that can be fairly large for kmalloc() and it can potentially lead to
allocation errors on certain systems:

$ pahole inflate_workspace
struct inflate_workspace {
	struct inflate_state       inflate_state;        /*     0  9544 */
	/* --- cacheline 149 boundary (9536 bytes) was 8 bytes ago --- */
	unsigned char              working_window[32768]; /*  9544 32768 */

	/* size: 42312, cachelines: 662, members: 2 */
	/* last cacheline: 8 bytes */
};

Considering that there is no need to use continuous physical memory,
simply switch to vmalloc() to provide a more reliable in-kernel module
decompression.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/module/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 87440f714c0c..4156d59be440 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+	s.workspace = vmalloc(zlib_inflate_workspacesize());
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	kfree(s.workspace);
+	vfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
-- 
2.40.1

