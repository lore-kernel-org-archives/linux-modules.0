Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC160482EB
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080527; cv=none; b=M8qKv9codp9ib7kn06MHyArFvFvpr5dyAGaxoW1bQFodWnw5mxtkWtYhqJGn+pcgXu3XT9td1YymgKL/Oc7fbRr1mOXvTdV9qCrDjb/HU9bRkobKt9XQZp22ADC7+rNA7qzB1kkqNvluo68F95WfPww8nCMgIyPe+G24A1ttmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080527; c=relaxed/simple;
	bh=t2m2UTGlNGu6xeqjU1O/0aU57NO63lg0H45rqPmK8m4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/rzY4SS04YcXf1av71lRANxREH8JmljiF2ohvKIryweoSmCo6AvYp2/QP3AzUpox1RLf6+BNGxtGARZokVh/nVqfI2qS0P2DLR1CCnfY9eP1E4uqCVQdUUXjZpuv32YLBLBjWzZVA0J0OkzH7ZRnaxAwUquD7b+KQ1qakTP5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hEEHp39r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEEHp39r"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b8f13f2965so23236957b3.1
        for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080523; x=1724685323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI06ovdfCz8cO9NK2nQDa04h5rjz0kRy+tQsOrEFgfI=;
        b=hEEHp39rxoanO1EMe5XLXPpYLTnEGZx0LryAIjp6rv0g9EYXSsmigWyQw+DA68/l8V
         ZAzVQdxwCSQb5uje/7TCGqJnqdHPz2opNQZtg1ij5EbzWbRT5g2SysVHZ6V0e2b3kG9b
         +0VoT85ZPJdGhly5kaY7uv3+oQ8z1k7yqp3VVi+sMmqcEVJFUgT0EEZ01vnXlDvcG/dD
         GaVINIUU9NSlkP4BWhj65pG7Ezi/g4y8T5/NDLVuNrHs4bsxi1EcQim8ZQeNxk7832N9
         1vd0uth5wR/Wd5rnDyuJWC9tbx2Iesv0A1Bajd1cGTcI/cjEFqtFxt63d+S0tD/J623S
         wywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080523; x=1724685323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI06ovdfCz8cO9NK2nQDa04h5rjz0kRy+tQsOrEFgfI=;
        b=Dtb0rTwPRe6r75V1IdWruIgfNMyFilS7eywoLEhy24vVKJM6hcvloNVdCX38WugzAH
         Y9Btq5azqJHgDHsCIfmR7w5T1kjXWVvlEMKP38iM7zmWAAJERJf2h/0renXf6s/iupGw
         kNsRuFDAVo7yAun0jW7whta6PBEIy6VJHtdiTGKjytHk+SijWlY6rQcZHwFBLn8nQLd/
         eS+12qsdlZ/zBocpdD/MEqDVrn9T9Vy3c9l8i3u7a3Fa38+qDh2JJoiv2YJTMX2deVkh
         FB14VUkblGigNtLgftEqex9t176oPKLSAvl+zQAjkR5w+C3iK8e6ta9KbZAe9k7oWf9r
         rD5A==
X-Forwarded-Encrypted: i=1; AJvYcCVDUMIjxKkNVMH8dPAf3URXFoJtLYGhoTGbrT24ZA2DIEcJJ53GD+QJNukSqN0EaC73umq5kMoOAUM0YtKpvQMvtRkHQA8gHQyl2zb/IQ==
X-Gm-Message-State: AOJu0YycGlWn93Jytos+T548yT4tXwkGEY+CZSS6IavTpmyUV4eIZVzN
	f76MKm6ZHN0xvcbTlOPG9u2qr1oEYpit7VGBpvi8BJt8a4AbGvX0JO4l/Kz91prQdsgA/mDECuq
	vMg==
X-Google-Smtp-Source: AGHT+IG/BKrJXqYP6cRYhE+Lu+8cVFetj3uIJoL3u5FtbKpk/WoSJ/pAYSGnYrr9RqZE8k4lDy0dOBXbaE4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5aea:cf26:50f4:76db])
 (user=surenb job=sendgmr) by 2002:a05:690c:c04:b0:6b2:6cd4:7f9a with SMTP id
 00721157ae682-6b26cd48046mr5942197b3.8.1724080522969; Mon, 19 Aug 2024
 08:15:22 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:15:10 -0700
In-Reply-To: <20240819151512.2363698-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819151512.2363698-5-surenb@google.com>
Subject: [PATCH 4/5] alloc_tag: make page allocation tag reference size configurable
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
page allocation tag references. When the size is configured to be
less than a direct pointer, the tags are searched using an index
stored as the tag reference.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 10 +++++-
 include/linux/codetag.h     |  3 ++
 include/linux/pgalloc_tag.h | 69 +++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug           | 11 ++++++
 lib/alloc_tag.c             | 50 ++++++++++++++++++++++++++-
 lib/codetag.c               |  4 +--
 mm/mm_init.c                |  1 +
 7 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 21e3098220e3..b5cf24517333 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,8 +30,16 @@ struct alloc_tag {
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
+struct alloc_tag_kernel_section {
+	struct alloc_tag *first_tag;
+	unsigned long count;
+};
+
 struct alloc_tag_module_section {
-	unsigned long start_addr;
+	union {
+		unsigned long start_addr;
+		struct alloc_tag *first_tag;
+	};
 	unsigned long end_addr;
 	/* used size */
 	unsigned long size;
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index c4a3dd60205e..dafc59838d87 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -13,6 +13,9 @@ struct codetag_module;
 struct seq_buf;
 struct module;
 
+#define CODETAG_SECTION_START_PREFIX	"__start_"
+#define CODETAG_SECTION_STOP_PREFIX	"__stop_"
+
 /*
  * An instance of this structure is created in a special ELF section at every
  * code location being tagged.  At runtime, the special section is treated as
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index c76b629d0206..80b8801cb90b 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -9,7 +9,18 @@
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+#if !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32
+#define PGALLOC_TAG_DIRECT_REF
 typedef union codetag_ref	pgalloc_tag_ref;
+#else /* !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32 */
+#if CONFIG_PGALLOC_TAG_REF_BITS > 16
+typedef u32	pgalloc_tag_ref;
+#else
+typedef u16	pgalloc_tag_ref;
+#endif
+#endif /* !defined(CONFIG_PGALLOC_TAG_REF_BITS) || CONFIG_PGALLOC_TAG_REF_BITS > 32 */
+
+#ifdef PGALLOC_TAG_DIRECT_REF
 
 static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 {
@@ -20,6 +31,63 @@ static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
 {
 	pgref->ct = ref->ct;
 }
+
+static inline void alloc_tag_sec_init(void) {}
+
+#else /* PGALLOC_TAG_DIRECT_REF */
+
+extern struct alloc_tag_kernel_section kernel_tags;
+extern struct alloc_tag_module_section module_tags;
+
+#define CODETAG_ID_NULL		0
+#define CODETAG_ID_EMPTY	1
+#define CODETAG_ID_FIRST	2
+
+static inline void read_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	pgalloc_tag_ref idx = *pgref;
+
+	switch (idx) {
+	case (CODETAG_ID_NULL):
+		ref->ct = NULL;
+		break;
+	case (CODETAG_ID_EMPTY):
+		set_codetag_empty(ref);
+		break;
+	default:
+		idx -= CODETAG_ID_FIRST;
+		ref->ct = idx < kernel_tags.count ?
+			&kernel_tags.first_tag[idx].ct :
+			&module_tags.first_tag[idx - kernel_tags.count].ct;
+	}
+}
+
+static inline void write_pgref(pgalloc_tag_ref *pgref, union codetag_ref *ref)
+{
+	struct alloc_tag *tag;
+
+	if (!ref->ct) {
+		*pgref = CODETAG_ID_NULL;
+		return;
+	}
+
+	if (is_codetag_empty(ref)) {
+		*pgref = CODETAG_ID_EMPTY;
+		return;
+	}
+
+	tag = ct_to_alloc_tag(ref->ct);
+	if (tag >= kernel_tags.first_tag && tag < kernel_tags.first_tag + kernel_tags.count) {
+		*pgref = CODETAG_ID_FIRST + (tag - kernel_tags.first_tag);
+		return;
+	}
+
+	*pgref = CODETAG_ID_FIRST + kernel_tags.count + (tag - module_tags.first_tag);
+}
+
+void __init alloc_tag_sec_init(void);
+
+#endif /* PGALLOC_TAG_DIRECT_REF */
 #include <linux/page_ext.h>
 
 extern struct page_ext_operations page_alloc_tagging_ops;
@@ -197,6 +265,7 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
 static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
+static inline void alloc_tag_sec_init(void) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..253f9c2028da 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1000,6 +1000,17 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config PGALLOC_TAG_REF_BITS
+	int "Number of bits for page allocation tag reference (10-64)"
+	range 10 64
+	default "64"
+	depends on MEM_ALLOC_PROFILING
+	help
+	  Number of bits used to encode a page allocation tag reference.
+
+	  Smaller number results in less memory overhead but limits the number of
+	  allocations which can be tagged (including allocations from modules).
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index a1d80d2ef512..d0da206d539e 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -3,6 +3,7 @@
 #include <linux/execmem.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
 #include <linux/pgalloc_tag.h>
@@ -11,13 +12,14 @@
 #include <linux/seq_file.h>
 
 static struct codetag_type *alloc_tag_cttype;
-static struct alloc_tag_module_section module_tags;
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
 /* A dummy object used to indicate an unloaded module */
 static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
 static struct module prepend_mod;
 
+struct alloc_tag_module_section module_tags;
+
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 EXPORT_SYMBOL(_shared_alloc_tag);
 
@@ -157,6 +159,33 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
+#ifndef PGALLOC_TAG_DIRECT_REF
+
+#define SECTION_START(NAME)	(CODETAG_SECTION_START_PREFIX NAME)
+#define SECTION_STOP(NAME)	(CODETAG_SECTION_STOP_PREFIX NAME)
+
+struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
+
+void __init alloc_tag_sec_init(void)
+{
+	struct alloc_tag *last_codetag;
+
+	kernel_tags.first_tag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_START(ALLOC_TAG_SECTION_NAME));
+	last_codetag = (struct alloc_tag *)kallsyms_lookup_name(
+					SECTION_STOP(ALLOC_TAG_SECTION_NAME));
+	kernel_tags.count = last_codetag - kernel_tags.first_tag;
+}
+
+static inline unsigned long alloc_tag_align(unsigned long val)
+{
+	if (val % sizeof(struct alloc_tag) == 0)
+		return val;
+	return ((val / sizeof(struct alloc_tag)) + 1) * sizeof(struct alloc_tag);
+}
+
+#endif /* PGALLOC_TAG_DIRECT_REF */
+
 static bool needs_section_mem(struct module *mod, unsigned long size)
 {
 	return size >= sizeof(struct alloc_tag);
@@ -214,6 +243,21 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (!align)
 		align = 1;
 
+#ifndef PGALLOC_TAG_DIRECT_REF
+	/*
+	 * If alloc_tag size is not a multiple of required alignment tag
+	 * indexing does not work.
+	 */
+	if (!IS_ALIGNED(sizeof(struct alloc_tag), align)) {
+		pr_err("%s: alignment %lu is incompatible with allocation tag indexing (CONFIG_PGALLOC_TAG_REF_BITS)",
+			mod->name, align);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Ensure prepend consumes multiple of alloc_tag-sized blocks */
+	if (prepend)
+		prepend = alloc_tag_align(prepend);
+#endif /* PGALLOC_TAG_DIRECT_REF */
 	rcu_read_lock();
 repeat:
 	/* Try finding exact size and hope the start is aligned */
@@ -462,6 +506,10 @@ static int __init alloc_tag_init(void)
 		return -ENOMEM;
 
 	module_tags.end_addr = module_tags.start_addr + module_tags_mem_sz;
+#ifndef PGALLOC_TAG_DIRECT_REF
+	/* Ensure the base is alloc_tag aligned */
+	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
+#endif
 	mt_set_in_rcu(&mod_area_mt);
 	alloc_tag_cttype = codetag_register_type(&desc);
 	if (IS_ERR(alloc_tag_cttype)) {
diff --git a/lib/codetag.c b/lib/codetag.c
index d602a81bdc03..53585518a103 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -151,8 +151,8 @@ static struct codetag_range get_section_range(struct module *mod,
 					      const char *section)
 {
 	return (struct codetag_range) {
-		get_symbol(mod, "__start_", section),
-		get_symbol(mod, "__stop_", section),
+		get_symbol(mod, CODETAG_SECTION_START_PREFIX, section),
+		get_symbol(mod, CODETAG_SECTION_STOP_PREFIX, section),
 	};
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..231a95782455 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2650,6 +2650,7 @@ void __init mm_core_init(void)
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
+	alloc_tag_sec_init();
 	mem_init();
 	kmem_cache_init();
 	/*
-- 
2.46.0.184.g6999bdac58-goog

