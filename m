Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E6C77B73
	for <linux-modules@archiver.kernel.org>; Mon,  1 May 2023 17:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjEARCd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 1 May 2023 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjEARAu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 1 May 2023 13:00:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CE3C34
        for <linux-modules@vger.kernel.org>; Mon,  1 May 2023 09:56:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso5007859276.1
        for <linux-modules@vger.kernel.org>; Mon, 01 May 2023 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960181; x=1685552181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jY4Why07vSNVPpYg+gbjry+wnVwWuxvaUCerSTimV/s=;
        b=Aq78soAaAyMief+cDBMeso8QgziJr1UcaoZbGj9scpfWVuA1jJXbc7+tVVMa5n+pXD
         zJNNMs5P7WUHVBw683ECTpg5npVx6QBf0bUN7DdPu6j/C+MRzKsa8URcyNS8bC7atQCY
         9SigXecTat+KM4eyT+hIxO14+/p9qQaXDCEC1rzj2GobJRxENTqWjSQsycHoHxjax/gY
         eWPPPBE6ZeI91QsbK/YSznn2yYLzHfxgEG9YEj/uwkJeJF6xe27cleLqDewTpXr/rX+O
         cI/7bSXViuC98rFsCexDBf6uZdpJdij1JBRms+fpyJvFKEAl56eecSWlzCcPWSAQrlLn
         rFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960181; x=1685552181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY4Why07vSNVPpYg+gbjry+wnVwWuxvaUCerSTimV/s=;
        b=F1Br0v3PDwlZbxB5nT3jSCcnYaoMuh3FLHCxYstlXdC0tW7fGpgAwhF6sSjyNytq/5
         warnUY5Dctq7WS/9laH7ci9/ckQgxg3272iX5mSofzNsTjTgIuoF17hrWAB1sQHrFo0q
         i60LBTgAEVg7UcZYntwAgXPIz9tkxviCHl389OQBl5s7WVN65yvTwjfYgiMb9OG8Ik/W
         o2VEIB/A+P/ADzkZz+LZ2iWijswOvIqY5gYGlSY3Nr2f9DZQpgTp2XxDp5oxE5Pgpdpo
         4DF2rYbxBEt9p9woYntODVrbN9s3ekZc2Eqd1UkCesz0Yw5MyAQmsH1eBr9E4UL+wX0t
         IffA==
X-Gm-Message-State: AC+VfDykSHljMBaBYu3js8XCZsr8GBkZBHmAa2nIjiYG8i04n7sKm8Ap
        2jGEfy6XZvTrJIFgdDgh0IMt8vW8AIU=
X-Google-Smtp-Source: ACHHUZ6jXSxE+6iq2YUjl7qVMHUxfSxuowqD06Cn0jpzZX6iMdKT0+DoukFEFTwwgTX/LkDeTP78a66LQOo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:24c4:0:b0:997:c919:4484 with SMTP id
 k187-20020a2524c4000000b00997c9194484mr5789976ybk.6.1682960180824; Mon, 01
 May 2023 09:56:20 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:42 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-33-surenb@google.com>
Subject: [PATCH 32/40] arm64: Fix circular header dependency
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

Replace linux/percpu.h include with asm/percpu.h to avoid circular
dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/include/asm/spectre.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index db7b371b367c..31823d9715ab 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -13,8 +13,8 @@
 #define __BP_HARDEN_HYP_VECS_SZ	((BP_HARDEN_EL2_SLOTS - 1) * SZ_2K)
 
 #ifndef __ASSEMBLY__
-
-#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <asm/percpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
-- 
2.40.1.495.gc816e09b53d-goog

