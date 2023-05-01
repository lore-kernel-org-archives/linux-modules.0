Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0311AC7EE26
	for <linux-modules@archiver.kernel.org>; Mon,  1 May 2023 16:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjEAQ7q (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 1 May 2023 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjEAQ6o (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 1 May 2023 12:58:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2030DD
        for <linux-modules@vger.kernel.org>; Mon,  1 May 2023 09:56:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso4868001276.0
        for <linux-modules@vger.kernel.org>; Mon, 01 May 2023 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=5JJhV76m95/YBoZ/xZu42cKOJXhgJORCHh7GQ1vgchybA9Jz2W8JB87J32lzEHqVAD
         5MpwShEQTLsgetTJKB81Ya9oYfauOk73A+wkcp3YnAqkuYR2uGLglMtljDk1oXUFeXUF
         eg/dqf1WTTeod1mNhPnzcjxqEJmrvwX1WQABkeXqhDWaPCFp/KOIQdT6Kd/lNmNqK8uA
         jO52yQ6iu7pCgMF+oglZnvEtlqmI75FROfYcJYL0lGgLhZXRGGNj8gM5KHULwpV7DXj0
         IQGmZzm/JuCCa0BNo8vc+UrvY2fi7yQcbqUa8T0x4PnakvTfaxlxsiA9vMtpl/EDSZYr
         7ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=bZG1zN/s5qneV1I8wcNdXw9I2F4Vk7rtBwH+8w5z7harBVazOPTKWw8gsfgPHhKjLJ
         QUZ0ZuZ+JHNpU1pZpjKmr1RcJMq1Z/uyqfc71d3U9KO5XQxMpTO0pZqihWVxdOox3K94
         pD7JEsdjrL7U2C6p5ITu5BjW7qKP0G3RpnLtDjrg4/BjI0Yqo3iwv68lYv4Z4WaFqcNH
         ifunz0mNfgxma6UZUwo3Rv4MusT5/gsCtww51TnmTnENAW4NlYqp0w35pCR5xLdXmhsz
         PWmX2HD9Vbg0tapOy/X018xTB3ktB3G47fRGy6Ke0OZgCEtlmNoTmKwDRdqAc/4cdPyc
         zZ9Q==
X-Gm-Message-State: AC+VfDwAo6cpkpHK93inZ3hu/WXX0gWnrsBGwF385IgeRevt0GEYDMKr
        pL5JC3JoRpg45HJyVVCdey0meZ0rFbc=
X-Google-Smtp-Source: ACHHUZ7AZgI8CesVN/W1kPgcDGVmfHbMCJ0zKZ8nFHzmTASKNb7LK9gLjq8w5luIVN/1afaizYlyRnGrI6c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:5d1:0:b0:b9d:52cf:4a6b with SMTP id
 200-20020a2505d1000000b00b9d52cf4a6bmr4308920ybf.1.1682960156135; Mon, 01 May
 2023 09:55:56 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:31 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-22-surenb@google.com>
Subject: [PATCH 21/40] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
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

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index eaf054ec276c..55ba797f8881 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -96,7 +96,16 @@ unsigned long page_ext_size;
 static unsigned long total_usage;
 struct page_ext *lookup_page_ext(const struct page *page);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.40.1.495.gc816e09b53d-goog

