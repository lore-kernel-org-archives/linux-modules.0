Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47A135A7C
	for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039058; cv=none; b=oKPcubXbaowaONPqDW9WQz4OHb0yHqEDZG1CquqcWeJGML9hGqSfHyGSOAHiJqr/DQ4opHua7oTbpxz6KP/qZl/4VV9ifjJ81adKNucM17dgah03aszpFiL8UqZOsCpCEzL7AaOq68xqXI9/Ce7Z8RIZECu5irhNh4SACL0FbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039058; c=relaxed/simple;
	bh=H5FMq26r5gKxhbJi5oj8J3ekKHRYJKOHnNGIH4x7NWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JME+4eYndR1j6gKvM1t55Ah57azHKnM6NmzC528OdG2YZS9FDmMk3edb6+W6hAYKG5q4jtYskN37JRHvqA4mVkUZaUGsFtRzWlJ+8IoCrAyOB6p9kgNXMdnjPcVN/pwgSbo37BOek937W3ySrHWC1AeIo8ne39w+E+mT2Ia4ERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KY4oPKzi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KY4oPKzi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2163996276.2
        for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039054; x=1711643854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7qlg8CrJrpGAZLx2tB5/z68XAeLcOjL+jbqSm1NrE=;
        b=KY4oPKziE3ocIh8vV/qPMJ5CW1xF5u+hUTiszf19Y/W1u6rwJAljC7RJhNIo1Wkcbt
         XWVmAGNpy9JF4KK6xgaKqwKMwHzIqWzg6yhPzpQx2+PkOtYvNHKAnLRvqp42p2UUbALg
         Tg8pJp7eeUWiVjwG3pHyOWhQ9hHInEi4Cj1dB2tJXvNOOkE0xylvpzDZ6911h2in62Tq
         yqhQPylmo4IVTVDoMO+/BQrsYcfZrrVQM51vzF9LwdZSwuBKKrPic/osJoHn99pje8z9
         Z953B24pSurrw9bBRHZFVLkYxUSBGYSm3lAjYFaJvNKyo/O+gICBet6KSOirQkLVbpzk
         2P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039054; x=1711643854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7qlg8CrJrpGAZLx2tB5/z68XAeLcOjL+jbqSm1NrE=;
        b=disAQ1ep8JxCLvu1hQyT/YvJYITnln579FBLQlAYu0/3mG76738IqFinvH/EEf/xuL
         V5vrRc7CVnCRGlqnma9pMLsts9Zcj8quWXwIyFsQDAFkorr4h0frY1/8hRxx/6iC3cGa
         UEWHQCESIA6oYz+FxNbvwXR25CRFHdF59qjXpRwG6exyyMFJejP96pst45W91AI4kbI8
         M+GrxDVbdTq6q7wxmUuEPYMTmcMo7hY9QSOdWyPD7KirUDX3QHjzuavNkd5m7jtLrS5H
         kgDNDFnQf1Us1mNxVZvzfLy2BsHl2Hrm1paUD604+Rp08y4QF0LBycBj6esDBIcDd1B8
         26Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW6nIzb/O05oCRghggoueuQATl6Jw260uw3+AbLL+KzGAV9ohGo6wCmXhr+9SWYhSo1reluoun7yfB3FvDkBEEeHNqTdCydy8Ex/wz/KQ==
X-Gm-Message-State: AOJu0Yz15DMcnIDXtAI1+Pb2QYTTNIUAV0tUyHqBXvym8h3YPbWZVFsi
	8ozC6+7NV59fL+6Fup3bbSUEfIhl3yPTdh6uxrtmTHTtCEDsINzL3cVAHfRdUixUzlQblbz/wal
	nUw==
X-Google-Smtp-Source: AGHT+IFS8l6862ma7ZQ5nEeHVOl9wKPYzuGCINkU9A5+oHuouEfxTwfUntJ3DBz0B7w6WbE929F2a5bqsSQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:2681:b0:dcb:bc80:8333 with SMTP id
 dx1-20020a056902268100b00dcbbc808333mr5470245ybb.13.1711039053606; Thu, 21
 Mar 2024 09:37:33 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:33 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-12-surenb@google.com>
Subject: [PATCH v6 11/37] lib: code tagging module support
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for code tagging from dynamically loaded modules.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/codetag.h | 12 +++++++++
 kernel/module/main.c    |  4 +++
 lib/codetag.c           | 58 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 7734269cdb63..c44f5b83f24d 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -33,6 +33,10 @@ union codetag_ref {
 struct codetag_type_desc {
 	const char *section;
 	size_t tag_size;
+	void (*module_load)(struct codetag_type *cttype,
+			    struct codetag_module *cmod);
+	void (*module_unload)(struct codetag_type *cttype,
+			      struct codetag_module *cmod);
 };
 
 struct codetag_iterator {
@@ -65,4 +69,12 @@ void codetag_to_text(struct seq_buf *out, struct codetag *ct);
 struct codetag_type *
 codetag_register_type(const struct codetag_type_desc *desc);
 
+#if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
+void codetag_load_module(struct module *mod);
+void codetag_unload_module(struct module *mod);
+#else
+static inline void codetag_load_module(struct module *mod) {}
+static inline void codetag_unload_module(struct module *mod) {}
+#endif
+
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1e8a7a9d6c1..ffa6b3e9cb43 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -56,6 +56,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <linux/cfi.h>
+#include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
@@ -1242,6 +1243,7 @@ static void free_module(struct module *mod)
 {
 	trace_module_free(mod);
 
+	codetag_unload_module(mod);
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -2995,6 +2997,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
+	codetag_load_module(mod);
+
 	/* Done! */
 	trace_module_load(mod);
 
diff --git a/lib/codetag.c b/lib/codetag.c
index 8b5b89ad508d..54d2828eba25 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -124,15 +124,20 @@ static void *get_symbol(struct module *mod, const char *prefix, const char *name
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
 	const char *buf;
+	void *ret;
 
 	seq_buf_printf(&sb, "%s%s", prefix, name);
 	if (seq_buf_has_overflowed(&sb))
 		return NULL;
 
 	buf = seq_buf_str(&sb);
-	return mod ?
+	preempt_disable();
+	ret = mod ?
 		(void *)find_kallsyms_symbol_value(mod, buf) :
 		(void *)kallsyms_lookup_name(buf);
+	preempt_enable();
+
+	return ret;
 }
 
 static struct codetag_range get_section_range(struct module *mod,
@@ -173,8 +178,11 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 
 	down_write(&cttype->mod_lock);
 	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
-	if (err >= 0)
+	if (err >= 0) {
 		cttype->count += range_size(cttype, &range);
+		if (cttype->desc.module_load)
+			cttype->desc.module_load(cttype, cmod);
+	}
 	up_write(&cttype->mod_lock);
 
 	if (err < 0) {
@@ -185,6 +193,52 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	return 0;
 }
 
+void codetag_load_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link)
+		codetag_module_init(cttype, mod);
+	mutex_unlock(&codetag_lock);
+}
+
+void codetag_unload_module(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	if (!mod)
+		return;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		struct codetag_module *found = NULL;
+		struct codetag_module *cmod;
+		unsigned long mod_id, tmp;
+
+		down_write(&cttype->mod_lock);
+		idr_for_each_entry_ul(&cttype->mod_idr, cmod, tmp, mod_id) {
+			if (cmod->mod && cmod->mod == mod) {
+				found = cmod;
+				break;
+			}
+		}
+		if (found) {
+			if (cttype->desc.module_unload)
+				cttype->desc.module_unload(cttype, cmod);
+
+			cttype->count -= range_size(cttype, &cmod->range);
+			idr_remove(&cttype->mod_idr, mod_id);
+			kfree(cmod);
+		}
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
+
 #else /* CONFIG_MODULES */
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod) { return 0; }
 #endif /* CONFIG_MODULES */
-- 
2.44.0.291.gc1ea87d7ee-goog

