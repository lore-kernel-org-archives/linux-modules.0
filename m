Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73786128364
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544471; cv=none; b=Vi93xtRsnchReU56QpDBaAUAdUCmBW2ulREX1zE9lM/gAK2wMVyMVe9mL+utL3ijZSvPmntqkAx2QPs4NtIt/0il4frVSjSdfSUsKMAxK4LBqTqaURpuyrBuKNKstr4pfP5V8xj4Uoq7ySOXA/QaGxnfMbaPJRxUVGQR0X6nmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544471; c=relaxed/simple;
	bh=Z0uieU1Hw2qDymgn+R30jj728IuRbiBIVd6A3QTsoEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGiV5Z9fNBhDJ40rAqqePGWcCH2lSP/fxDrKspjFESOmloWQjMB3V62evOWRnLMKdzeVo1bRvTTu6qUl6GH2/zyqFWDxbxrMMKOU3ZD4GW6XF0344kUfAhlbsT6eZVCVccoychcbyrgZiPuBqDzNkLSxpBNPbhGTKV8CDGrwOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byge+aaK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byge+aaK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607cd6c11d7so104093427b3.0
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544467; x=1709149267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=byge+aaKKirc/1HtrNjKyqcEh1JvgEDAfzILDPbokj0bGNmdMzHMyliJoEP6JRJ+qk
         bhGiYyCwGhDZTEOKGxj+ABhC9mVdMWWHv6GtmMuN7ybSvKpU8Mc2FfbA9zcdorlH0cUO
         /L6GVNl9T1n0I9asPP9NvNY5yWPUtwerWFneQlK/tLXWQ0Uj0Y7AxBagPMg6rZywoPSr
         DjvV3RRrSoPKkW9TkKqtxhnHY/39vU560lNYeMS9SS340Xh+dtqnHhO3nGEnyfghptt7
         l4vhmHvMk3ulYJQO++e6PAVqPtel0Zx0cTfWBxhcj+Ilqp8YAQYPCxDi8/df4KQ+bWLa
         +R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544467; x=1709149267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=bPx3ErVCglIlJvwOBYFh0saMPsJkW/yxySLxuEChWMsR3XTUQzapxd2xCboaRqJEN5
         T96LOKiTjK8pznSh6kwxJSeWYHbtztGU9Mg97r+bji0sLeqgT/Lhw87rb9YpnYf580ez
         idhFh8jDWoBp+N41XAjL0Ha4h0CvglU65CYMyfY521dzitHEErQ18bR7c7p5Lql2U+7P
         fZeiT2FJ8gaOd9yJFQPxdRuVstuHcnShtuage1Y8iGcVWH8I1mH6zXyzmdLHhVgTq9fk
         GEIG0fmDNJR3TMSs2i2rAQu82p0c77ZtBX/oRmWHD3wyZYMc2Lcxt3+t1bLutCh6N2o5
         PTZg==
X-Forwarded-Encrypted: i=1; AJvYcCXM6hWO0GCjUGq8D6SF1W2hxJrc5400fp+MUQQKpglovnIhEky3jo4bFtc8TEj/l3EFLOZagfN7CDaW6cVN9SeRvV8MAyNtXti7j+heiw==
X-Gm-Message-State: AOJu0YwC8yYv2ebFu6NVFCmpinQwJUP1Lr96Yu/JthbOgdzSjYxG7Rkg
	chuEz0vVzAXDc9E/1QtT4DZx3WRyzEkMcOTGRQsG0yveqg+6PISLCOMAazeyPAst+YWq0qLkWUN
	/4Q==
X-Google-Smtp-Source: AGHT+IEg8J3/Tgw3rQ0HmvocmCN1KEaF26PclNShE/JXdkinKLyGnMcr7oBUIgKaZkEgV9b6wmo43w0h+Rc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:4c2:b0:dcc:4785:b51e with SMTP id
 v2-20020a05690204c200b00dcc4785b51emr10314ybs.12.1708544467498; Wed, 21 Feb
 2024 11:41:07 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:18 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-6-surenb@google.com>
Subject: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f37c60709..08d8246399c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
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
2.44.0.rc0.258.g7320e95886-goog

