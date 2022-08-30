Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D6ECAAD4
	for <linux-modules@archiver.kernel.org>; Tue, 30 Aug 2022 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiH3VwG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiH3VvS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 Aug 2022 17:51:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB32A1A04A
        for <linux-modules@vger.kernel.org>; Tue, 30 Aug 2022 14:50:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a259e8c000000b006958480b858so717438ybq.12
        for <linux-modules@vger.kernel.org>; Tue, 30 Aug 2022 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=gY+PdoFf3bNnEB0W9Vd0woPoFdt9hhtegjhiPtTj+AE=;
        b=pP4c3oP+YdesowZgNPs4eE1Xp1hWxAr9Ov2IDGBfglQ7uK9BWLrmzhDJ/utRpkPDJK
         tLMoERW1+3/smlLhO5G46VfqVywVDMABKHAv9jnhzz9ZshpBvX9ODCL7lsQaaZS0MLOk
         moKmQwwsOGjNod+M4t/tjA/+LNyP1VXOc5752+/a3Um/WwaPBzNEpe5l2cE7BDo787CF
         /PWmu6igP2xWBoiVtEHlimVT5AWdWMQxPlHvsqYO1szpGDqcGUPThIrLg/hGXqOCKmhM
         XRoOlsQx66oUshjUnxZWYY0qi/lYffvprIXZMUGryr7KjlXRCtsueZ1FZIWTKefulhTk
         stEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=gY+PdoFf3bNnEB0W9Vd0woPoFdt9hhtegjhiPtTj+AE=;
        b=P4bo1hLwFtttpTuA6VdChbOFt4X64ld+4lp9M8jJ/GXJKzrpMrfU8NeMfroY+gmkyF
         w2BrLL628irFCiM8PhoKRwFK2xKXyf2TlAq2RNQbhPh56sBcsASD+HGLzF6c6WFb3tlS
         ZEit8QFtUnrPiUQt+t4tQFwYHXoOEgDv/ly0h3JLbm7T6FR335bvNBdtzYLHJM1Do6pF
         OzOrU1Iz/dKV1am2pMItT5+LQBHtxCqu2rUeBlWHQ+1O3YJn1cDg+ubc8dsDs+nbCc4k
         LSQwLAlTYux5de/rBMe5u/apLi8mMUBkANitj0G2BF1y0FfWMT00p7/HqEA5RnZCk1LB
         IQrQ==
X-Gm-Message-State: ACgBeo175GuVdCanJSyOUkr90GhP2bDYmottJAiQiaMXJayuFVSy/j92
        0qWZ0isK20yCRGi/WrCCKhaua17eNsQ=
X-Google-Smtp-Source: AA6agR7WLdIMrAR0FWfuROzkHWzqEUxzLPyMUzXzjD/46yfJpgch8NK3VM+VyOZeNwYsSnGIQ5TrqCRxJvQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:ba91:0:b0:683:ebc2:7114 with SMTP id
 s17-20020a25ba91000000b00683ebc27114mr13866830ybg.319.1661896200808; Tue, 30
 Aug 2022 14:50:00 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:49:03 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-15-surenb@google.com>
Subject: [RFC PATCH 14/30] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memcontrol.c | 2 ++
 mm/slab.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3f407ef2f3f1..dabb451dc364 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2809,6 +2809,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
diff --git a/mm/slab.h b/mm/slab.h
index c767ce3f0fe2..d93b22b8bbe2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -475,6 +475,12 @@ static inline void prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags,
 	if (is_kmem_only_obj_ext())
 		return;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab))
 		WARN(alloc_slab_obj_exts(slab, s, flags, false),
-- 
2.37.2.672.g94769d06f0-goog

