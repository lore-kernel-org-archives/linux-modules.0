Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2514374A
	for <linux-modules@vger.kernel.org>; Wed,  6 Mar 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749503; cv=none; b=SHxamvIFpUZB/tR+GmWz7Jtj3Rq+dw63PEqRLfEdTk4L7gvDRbUiUY+Q4HQ+UHhojqseYFv1T+gJ8vhKt+lBMg/IeQuKd84+nNxImP7t2Q+9stpysQM5ISJ7eMXvt7A4AV7sICxZ7P60gLQR6r7AWSwWs38jRC2eOZFR6YGKWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749503; c=relaxed/simple;
	bh=R2DVckge80A2ruR232rDSrP7/GV74FogObtaXjKjFt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRoR3+zJUktHutP6+WWPtYSiH5ixgfLeaijC7oJIo/MBSNiKyEGevhzFsdRQNIActGn0hw8YwqRU7YnO9Gq2i4cLxeqbJ3HSswvIUG/hMMp8L+LtTMYMkRh6UuSk9pdLrXfO7Y1zZmP0+2brA/VracZ224x6lQ0Yd6rH3SSE8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6Csgq/G; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6Csgq/G"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60904453110so151197b3.2
        for <linux-modules@vger.kernel.org>; Wed, 06 Mar 2024 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749500; x=1710354300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=z6Csgq/GpdiAe/2EPMOGSkC2HPAWpdm6wsmaT0tXTRd1oqJ1m+W2JXkygqBzBcF8WM
         WtLuFAkHn6wjeSqx+vHHHzX9YJus/kVLjMfFZ5uMGWDRAG8BlsbKVphRki6kXGTA7b/2
         Jn4G11pkF0ohN30bWz/KRrLyu4oeU329e/8QN9wuANcX5Q8seA4QvANEnVL7KR072tcp
         o2uNxsBhwPM6ACBSZ8Vb7AIhQl8h83raKw/3BfZRGDloTI394CE91N5fWgiUW7xSUkBw
         EbOj0f4H0BUf7T5MM73iceYQEPqAhCchgBVSM8oX/gDAFmtMKJ/F6IwqHjU1jJ+09erO
         R5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749500; x=1710354300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rH9mI3mTJcaBoi8NvQC9FpkTZd7d5upxL04jrJdHuE=;
        b=D8lepODq5UN3nL0GqeJvWj+j68u5jiNxWWSIxu6aXqGZOisAOn0ytwclasILlv7QPH
         8Ebq4r0OZ1ZZYzPN9/9kJzF1pK3dRGmXRYGDrMVdLamJepmTXrvP+roPP3RcsWEgVNgz
         0zY0PdvffdEWkdHIXSSKJMVMj+l/NCA2RT/nHu5G2fg+K/LoVqqwNfQGBn79iIyO/HOJ
         0fZAAeYJSd3mx/ddJGzSUb6b+ksbTklOyu7o+JGbp2f5SF7VvIYDCLnaq7V/KgoD3gZT
         pjagmme8n+IY29W+1qDlUqgHARJFht96cBIHEZyeibPDbZ23PIic/bG+dKy1XB+lkqMm
         QzBA==
X-Forwarded-Encrypted: i=1; AJvYcCVPJLV8WicOtbS5w6IE72x6KFLBKgcAHmiuCBAwFzHZZP+I5bPtZeIauKaawYsYA4ExRXkmGU9H25/PxqwKFwQ4lcBOxRUtDUQAUCXBXQ==
X-Gm-Message-State: AOJu0Yx2PmHhzusLCeYkBCyKGOCGAYsjaVTQIZ06gnd9Wn28Upyup0Xi
	mLWXiNLzEgQvC6SBfj0wIPi/vwwtolhVQeGL98lvtk0zkp1RgJrb3Gdvqqr1e1VtrED11IysxRD
	11g==
X-Google-Smtp-Source: AGHT+IHxR0olBWteUpSeEtMuXDZWp8I1meqV0Icf5ps5DXZSQPpSTLoMw3+arJQFndTmnzLC9JieP9mTFwI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP id
 cj5-20020a056902188500b00dc6207ee8b1mr3919663ybb.2.1709749499865; Wed, 06 Mar
 2024 10:24:59 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:05 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-8-surenb@google.com>
Subject: [PATCH v5 07/37] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp_types.h | 11 +++++++++++
 mm/slub.c                 |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/mm/slub.c b/mm/slub.c
index 6ab9f8f38ac5..2ba5d7b2711d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1899,6 +1899,8 @@ static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.278.ge034bb2e1d-goog

