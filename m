Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDEBC77B76
	for <linux-modules@archiver.kernel.org>; Mon, 17 Apr 2023 23:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDQXKw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Apr 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQXKw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Apr 2023 19:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D43A92
        for <linux-modules@vger.kernel.org>; Mon, 17 Apr 2023 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681773007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9KwBP9Man5SYvHcbBmo3b28W9QLZLArX7nGl4kEM31Y=;
        b=cJslu2vF2dI5PcXkcEUkzr4K9nKBDLCrZZpcFrSBbRz34dVXFZRLZSFuzczPqvTJhDnj3s
        6SyguJ9Hc2f1nf8cjsqeIOFhAA5OywlIxATmJ8UPTT9+T7Fi9zwJRy8WBJFdANUqQ9bbYW
        eq3gZ4Ybzz33P4cchm+PNnvr2epmZ9w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-12bwmtiJP3iApxnrwo1Hlw-1; Mon, 17 Apr 2023 19:10:03 -0400
X-MC-Unique: 12bwmtiJP3iApxnrwo1Hlw-1
Received: by mail-qt1-f198.google.com with SMTP id e8-20020a05622a110800b003e4e915a164so14629062qty.4
        for <linux-modules@vger.kernel.org>; Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681773003; x=1684365003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KwBP9Man5SYvHcbBmo3b28W9QLZLArX7nGl4kEM31Y=;
        b=URO5ob6HD2e2+C1/5CefZPQljxfNcJm7gMFdHtbfGY8K6psj8SP+ABlwJR65F/W84Y
         uEdRPa7rSQ7E0AFFFRwQy/tvls7V1H43K/cdZXek5yA0zms7T7BF/qa9erW/l51LnOnd
         1jH4UqeVNlsqfNy7Xs15w9sp7YcRWqj39OUPjret2Dw9oXQGVVHXHiUmGQIKDffVmU+W
         oetLJJ0HyWgRLXo2IckBOvAXwEk7nGuZTMk8ectzQjP3RsZpp+wq/EtRAcUhsdgc2wqW
         Wmj5Qo3or4LLk9+YgJp85bJK9Vk5tmvw6Vvg/wrWcpt4dBx5ZSm4G8s3UzWicC9FwFh8
         pT9g==
X-Gm-Message-State: AAQBX9fblOHuE5jwJkH4H3+aG+140SY5EvR0hw7gRYMTxW1kZg2J49Vu
        1QHWlwY04W+U+VNZnyp0tMlQSeuWLx7tf/buwl6I/T76w3qTF5IEpSPrjasIC0vye/CWU3DUOES
        /WIBhaqd01hDaeqXfYr5v6Dmz1Q==
X-Received: by 2002:a05:6214:202d:b0:5c8:403a:22f8 with SMTP id 13-20020a056214202d00b005c8403a22f8mr20199715qvf.5.1681773003527;
        Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350bd/2/c5QbKCswcHJPCu2Ivyl4odfLfeqheGCnBG0dmlgXXCyJCkdUwofowvXv/jLIeXWkPpw==
X-Received: by 2002:a05:6214:202d:b0:5c8:403a:22f8 with SMTP id 13-20020a056214202d00b005c8403a22f8mr20199697qvf.5.1681773003276;
        Mon, 17 Apr 2023 16:10:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b6-20020a0cbf46000000b005ef465ad69bsm3337943qvj.23.2023.04.17.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 16:10:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mcgrof@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] module: remove use of uninitialized variable len
Date:   Mon, 17 Apr 2023 19:09:57 -0400
Message-Id: <20230417230957.3221615-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

clang build reports
kernel/module/stats.c:307:34: error: variable
  'len' is uninitialized when used here [-Werror,-Wuninitialized]
        len = scnprintf(buf + 0, size - len,
                                        ^~~
At the start of this sequence, neither the '+ 0', nor the '- len' are needed.
So remove them and fix using 'len' uninitalized.

Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/module/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index d9b9bccf4256..f0619170bd3d 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -304,7 +304,7 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 		return -ENOMEM;
 
 	/* The beginning of our debug preamble */
-	len = scnprintf(buf + 0, size - len, "%25s\t%u\n", "Mods ever loaded", live_mod_count);
+	len = scnprintf(buf, size, "%25s\t%u\n", "Mods ever loaded", live_mod_count);
 
 	len += scnprintf(buf + len, size - len, "%25s\t%u\n", "Mods failed on kread", fkreads);
 
-- 
2.27.0

