Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D6C77B73
	for <linux-modules@archiver.kernel.org>; Mon,  1 May 2023 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjEAQ4P (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 1 May 2023 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjEAQzd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 1 May 2023 12:55:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A739D1BDC
        for <linux-modules@vger.kernel.org>; Mon,  1 May 2023 09:55:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e02410034so1197219a91.0
        for <linux-modules@vger.kernel.org>; Mon, 01 May 2023 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960119; x=1685552119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Am8x4T/C3ER6nwTMzq8wqC7nUn5OpA8nmjjdL2Y+IyA=;
        b=WPj8roryRwAmmVOt/f6DiF72YfWfvTwfrhdft0wjazxPvIpRZjMIBwQEDTYgaFjL40
         EYH/Obl5jlfmohNQjk6ksHyCvogtUr2FLXSqo8imf9pH+Av5pbwlM01Z0VPnzvuHFHvS
         sJJApW1h4nytu2oRGIJAzX1ILNXit4lP55uwJk+oNrWKlXyEZFC9xWXVli4TIY3SK85U
         B99AfIcgd6WX1rUTcNtVjahhym0hUSbpRJ8MlMIviR2dEnrK9LO4e6TK4pMF6ElbNOxK
         BqCNggeEEuUJjuE4WJ/nJF98lgK/t0MR2oB5re4JYDKTxZxL1IcsVMbdtZa5WL37TB8E
         NhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960119; x=1685552119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Am8x4T/C3ER6nwTMzq8wqC7nUn5OpA8nmjjdL2Y+IyA=;
        b=l2GhaguebjAzJK2pIeCefjoD1s0kjH2hlioEjq6SBlFci6kiUO7DxW07MgqhPNvZpf
         3Jirlz0RoechGB1xi/iZZ2el8LoJLnJx7eYBhfscgwllhjcJMEE85NHS9HsKtqHKhqdl
         aM2YGeyDatciQUIXhP8WJ2y4E/AeQjJ9akyG24/T88g8Dgdeb9dXqX34+tDo1IwoMnNz
         hZyAWB81odOMH5yRDsG594HpnJ1+Q+NXVM674I8lvKCK0ALwQf3wNXsolKprCvxm6C+v
         f4cNnlktTb5/nd8Acr5/aXWZsOAyPIyALGd7Csay7xWv8oplPDNap4D6R1mBBU4GgSdz
         4NLQ==
X-Gm-Message-State: AC+VfDymNTHaRbVFcGMjqJLBUHTMCeXYuItodge4wm9NksT0PS8zlEII
        PgW37zg5d/b62T16Rp3gMgdPPHKYOOA=
X-Google-Smtp-Source: ACHHUZ4HYpYlqwon9ul71ywYVvGlfL5GDzgkEgI+UaCs1iOfSF39OpEKQuit70zO4oA3hBY7TJW8YvGVQSU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:24a:b0:24d:e504:69ed with SMTP id
 t10-20020a17090a024a00b0024de50469edmr1685228pje.3.1682960119293; Mon, 01 May
 2023 09:55:19 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:15 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-6-surenb@google.com>
Subject: [PATCH 05/40] prandom: Remove unused include
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Kent Overstreet <kent.overstreet@linux.dev>

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.40.1.495.gc816e09b53d-goog

