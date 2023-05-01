Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBDEC77B61
	for <linux-modules@archiver.kernel.org>; Mon,  1 May 2023 17:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjEARAL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 1 May 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjEAQ7j (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 1 May 2023 12:59:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE435AE
        for <linux-modules@vger.kernel.org>; Mon,  1 May 2023 09:56:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso4837248276.1
        for <linux-modules@vger.kernel.org>; Mon, 01 May 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=Db2dTvDWbMM6MtFyLXOOyG+p1K651ww8uL+kJDohPMMG6EWYrhfJFGluhHEW0wqXl5
         UKPrByNQ1Z4QXnisfDyfKX7dbeY+3mxaMGuFVRBjDUr3JiqQISt6WeUr2I6JPah8BGyR
         FjdvJFEuIXgNlkkoVLLQxMPMSKPuyrjPesVcRR9te3ugJsI7tT+EXrko3AZ8ov2CcY8R
         JR28aghvPN6+RkIPURXyrGkWco+xEzOLoyotOADRZq9o/XJ68RcgnDEgHpMVXMMei422
         +DGh+VKx3LXxPBgO4eeggvJc6/61DcK7Fvg52O8gRCKPK/nk5YYM+Q4LDqT5D1RFb4LF
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=A5co0oszv7sV0GjjwBYAGzxRl3J0MGpwGxqhXsoQfqiVoVM7+QG3hGYJ6FqcUD/lpc
         LXRRnauWgaKV8liNZiye8ArvrPNNcwYYu1b56U81ja3mbrliUFa+85BGfJTKg2T3t+mn
         nDI73SKwyZRtq613Q9Z4n9mXeeTWt06Ndx7DvPvNuFim3neFRhuemh+aYDyp1spvy8G1
         rbjl6eCO/WiEzoJua+RwD+Uudzu7mxP1ph99AVpaQRN3urCnVfE6bp6VUGfvqAR8Y8Lh
         PrXso1/EIbuhyzPonL3PUshiVHCrKJUGAk6ALMp4WjATpN5dyxT8UtGPrhIOjXOAYZGc
         4lnA==
X-Gm-Message-State: AC+VfDxbQ0yxURIZax++B9rfLjnM1fjjQubWUVlRjLMSWHTjc0luCB4j
        BniGcGroR6keD7LO3imL88O7z2oNQc4=
X-Google-Smtp-Source: ACHHUZ40g7B5Nzrue3Inkynn2rCW8wBzh6gvt9xgi1/WmwP7LCTtOXWTAuDa8Mc648etXigh7Ci0w5kPSCE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:c0ca:0:b0:b9a:7cd6:ba7a with SMTP id
 c193-20020a25c0ca000000b00b9a7cd6ba7amr5449586ybf.12.1682960167516; Mon, 01
 May 2023 09:56:07 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:36 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-27-surenb@google.com>
Subject: [PATCH 26/40] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8f57fd086f69..9dd57b3384a1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1781,7 +1781,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	return kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.40.1.495.gc816e09b53d-goog

