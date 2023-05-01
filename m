Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03659C7EE25
	for <linux-modules@archiver.kernel.org>; Mon,  1 May 2023 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjEAQzi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 1 May 2023 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjEAQza (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 1 May 2023 12:55:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED89173F
        for <linux-modules@vger.kernel.org>; Mon,  1 May 2023 09:55:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559e55b8766so38359167b3.1
        for <linux-modules@vger.kernel.org>; Mon, 01 May 2023 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960114; x=1685552114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGdFaZ9yLSvpkzL04e/VHNU0a1vWusSmGZaxEHf2wm8=;
        b=kNURb9oRoWKMv7g0yo2L8rW1EcO17+d5GcAx/UcGQY6Nq04eWDbD4SbdCNOLXgOYzq
         iIefzjvXI4Snk9VN4a44AHM12D0iuNdtL0q3JhvnQXzZtf429k8SdHQyNq1DhIH3u3D/
         vgRvJtIdIGprvSKRamhSV8bn0NWTicrhYnvBvcVO6D5qUdO+wBWr5u0wD0Nu7LbQQb+M
         IIs2pzxiZlPELIg9+H7fv7z/PKPu/SB3zB+CWnrv1/57UJqzRl/3C3lgPuiSCXQkCpOG
         4JQ2sAFEorBhte2EmAzube4SlGlrch2L/NYmCg7/2eMQe55a1P+zlu78IrB4haHDMTMn
         h3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960114; x=1685552114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGdFaZ9yLSvpkzL04e/VHNU0a1vWusSmGZaxEHf2wm8=;
        b=bQKqVZ+6NRgM7qSq7oLfBUm5mGlOuIde40D2r5i6Czrgrd/W6xIW8q+2WJ4HWvkw//
         A8KLoCrK2LK3mmYLmcSnQbSslme+c+bk/JJMW7QSkhcabXE9Z2hehGtHUUK4dzNxxIju
         d/71YvPTtFTEu68vc1DDNLJh2mj+A/BK88WoyaCX9EWd1K0mDBK6tzO7zuaImC51Ra+V
         CbQZ9D99UT2UYhxFNZaGp/am1RdmFZK7yZJiHsWbIZ7AcCQnQnyRSI1JhTvkpUGCu9QW
         eianc3QOiIC6A82nnv6WTQz8OSgrqmrnRWT+aUZ1/4bV14IYlQsWENgop1horyXTusPg
         yZXg==
X-Gm-Message-State: AC+VfDyNAFG0kY/eARFPpxvvkotHkhdXhtqR9i2CIqWM+DK+Rjg5CmXO
        mFLNq1V3fOYHRFSh6O3RgenRjPM6LL4=
X-Google-Smtp-Source: ACHHUZ54ReoLXFk1oTaYjmLVtkkNt2jRchxoRiCx8rxY23YjrphJueyeWWbM6qC2nW3CU7hKMZM9JkpwZiA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a05:690c:723:b0:54f:68a1:b406 with SMTP id
 bt3-20020a05690c072300b0054f68a1b406mr8285886ywb.2.1682960114403; Mon, 01 May
 2023 09:55:14 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:13 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-4-surenb@google.com>
Subject: [PATCH 03/40] fs: Convert alloc_inode_sb() to a macro
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
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..4905ce14db0b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2699,11 +2699,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.40.1.495.gc816e09b53d-goog

