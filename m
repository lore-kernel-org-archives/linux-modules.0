Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB57C4332F
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhL1VbC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237499AbhL1Va6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=YDqmAwU5z/9lgU27tGjWHNNNDJBuZcPzZlpy9w74y2l1gZXlAWjQFkS3eamxUCvcTMkiUk
        QHliu97bzrFGTtMgjo2NjfuXVySCv6hiOwjf68RcTLrP+uK64Nn0ZRaD0u2AyAGhStcQjd
        hq+Bl6qriR6vJDF1zPMPf4ljRv3gESw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-neah5H4VPde827qxPf9Btw-1; Tue, 28 Dec 2021 16:30:56 -0500
X-MC-Unique: neah5H4VPde827qxPf9Btw-1
Received: by mail-wm1-f69.google.com with SMTP id f202-20020a1c1fd3000000b00344f1cae317so3679279wmf.0
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1lOBRpMAGkWz55gR1tG3JnxjneKMph16mPglikuVp0=;
        b=G8C9vAJ1vEEaspL+5af0blNVYHOFSSEE5IM2z0pabTH4GKIeVXh1Mr+qlPwiQAyKEi
         wNuAzkOJ1FrHf64q7eondIhSsVURH6kqQU6KTF1q3O/p0vClm6ioEhSvT6T8TPIO7jBW
         uJohkJ7y3tvQW/yKQ7BMgTUHYUym3ITDRFhvo1LMcc6QNM2/Vl4oSUoMSf0TK1gfYa06
         dnNyAaCugtejJdIuL3yr+StlZGo6KfO2+5Nhz1ehgqtpqf5H3aye9UN+HWUMivDU2LYM
         L7cFuXK/+lbWBKijGwYk/vachRhjcZC9fVrl9E+La8DfeLtscZ4pPkVEj5yyuVbmSsis
         0mPg==
X-Gm-Message-State: AOAM531r21FeKtkzvd+HJ0TIwU91U9hjR7kl1IebOBR/tbpZPP0tPBIA
        c+bgO24VU79hNOcL55nZT2W7vJjPEmvgcGDSnP4i/Lf0HF7+QlYa4211Nnji9a21OL0bNqGX1lM
        62qGgID12cFZtUvmaA0eSohaZ
X-Received: by 2002:a5d:6702:: with SMTP id o2mr17958889wru.292.1640727054499;
        Tue, 28 Dec 2021 13:30:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWLuWvxuln1/E5kemLw46EPZ4rHzmIPkxuxDJpLp6+pGF82G0D/3i7IICNC7t5ofzUBwTU2A==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr17958880wru.292.1640727054375;
        Tue, 28 Dec 2021 13:30:54 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k9sm18612597wro.80.2021.12.28.13.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:54 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 12/12] module: Move kdb_modules list out of core code
Date:   Tue, 28 Dec 2021 21:30:41 +0000
Message-Id: <20211228213041.1356334-13-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
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

