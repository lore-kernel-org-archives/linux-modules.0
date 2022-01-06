Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40095C433FE
	for <linux-modules@archiver.kernel.org>; Thu,  6 Jan 2022 23:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiAFXnv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343578AbiAFXnh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=A6M+HOLwnuwkj2SRIXZgEkD4a1o4htB4XXh6yB7RUjgcv6SC7QbbqJXnyUft3cnjAuLKTz
        ap3B8EV6bX6hEuD4gwclck62kxq8w4UhsPozHx0q0hOyc0NrauV2F7eTEHJzMa3bMju6Wy
        qornxwflcGvXt5rDADR8nfRa2t5FEgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-T-xifXzuOFa1An6DFGXusA-1; Thu, 06 Jan 2022 18:43:35 -0500
X-MC-Unique: T-xifXzuOFa1An6DFGXusA-1
Received: by mail-wm1-f71.google.com with SMTP id az9-20020a05600c600900b0034692565ca8so2690422wmb.9
        for <linux-modules@vger.kernel.org>; Thu, 06 Jan 2022 15:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=hm/2MpzeI6fYZNYjmuXlzkCI6nJYrN52A+myxgTXmRxAqF36KfbMYdzuPQ3hYgGKp8
         wv2pgFH8YlDE4v8NjsrocO5rRDcJ1RJFMU5SJTm9H0ME+/l12rVVUg15mpUYVfPf5+GV
         eblhU1rCt7K2H2iR6smBIsBQNJqKebsE7PhktYWYFVH2i+9uh//pZNzW4ZePGy8oNfrp
         vnRgeb4ifa7A8OLnvzfAQ/BM1twlzoQBsWmdgjiMHQNcSswRTXRiCLAuLYHpoTIxIpk6
         w09qtb1xJ2gntbJotXWNtDRkbhVvk/C5o5hpDXJfJ+ZyuEGGi2bXuU8VgNgMK8JpSsnh
         tfyQ==
X-Gm-Message-State: AOAM532U6jLW/PtP+RX9Dxv+Niwql8EX/qMkmRv6siAWugRF8XWdEBTI
        PA0uT3HaLl6IwtQdCoI+llSaDrwkXJqMGF6iZDVkg4wS8oKSqa8JxXTm7OETFtGJHyv8nV9BaXy
        5enrJNyRIjd2GC+OVjOZOmv1v
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr8934055wma.50.1641512613951;
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm34Qkm/iu5cTZq8D+bvs0YhUr+bS4xpiu0coZNklUOksu0Ub+seGzIiaUugWtOgo0PTEvuQ==
X-Received: by 2002:a1c:3b86:: with SMTP id i128mr8934043wma.50.1641512613780;
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b16sm3289165wmq.41.2022.01.06.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:33 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 12/13] module: Move kdb_modules list out of core code
Date:   Thu,  6 Jan 2022 23:43:18 +0000
Message-Id: <20220106234319.2067842-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

No functional change.

This patch migrates kdb_modules list to core kdb code
since the list of added/or loaded modules is no longer
private.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/debug/kdb/kdb_main.c | 5 +++++
 kernel/module/main.c        | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index d8ee5647b732..ef61fb65671a 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -60,6 +60,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
 int kdb_grep_leading;
 int kdb_grep_trailing;
 
+#ifdef CONFIG_MODULES
+extern struct list_head modules;
+struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
+#endif /* CONFIG_MODULES */
+
 /*
  * Kernel debugger state flags
  */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 354fb2697188..09012246907a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -95,10 +95,6 @@ static void mod_update_bounds(struct module *mod)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
 }
 
-#ifdef CONFIG_KGDB_KDB
-struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
-#endif /* CONFIG_KGDB_KDB */
-
 static void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
-- 
2.31.1

