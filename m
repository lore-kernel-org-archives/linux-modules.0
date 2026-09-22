Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2F442FAA
	for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082571; cv=none; b=onuU+LWT2MSGWUEmkJ/xnEnt/mBbjHXj3LPu4YZ+OgwNPdqocnq+DrOcrbvUR//zhj3WVx08MEaqLdub/+a+Y0qZqEM4YVlz6Fgfc1PpKgUYdzdOOximyBa7hs1DeCVdphYKrwi6c1Sz3mUAkhlQg4xlkdYAwWyEn1d4guMmS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082571; c=relaxed/simple;
	bh=mxFdb9DhEoxvID3PHdOx9RZd/MFmjB45cayVkb6tYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+PAR2J0oWMchiocOFUzimOJK5I3J4pfOtvfZag3QBGVEsid7pydeX7XEBe7IDy1gVu2oTvSdvaNpprIMnIa9RBs7n2Gk91Sj2PqHi0uCe3j7ZXF2yz+CD0tCA5r42fC3T8H+jWj5CD5d69HHN1+crCqs9E2mVPJrN11HYjFyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OU04iyCd; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OU04iyCd"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so2264654f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 22 Sep 2026 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790082567; x=1790687367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBWc941sAI+gZg6+h/vlg5P6+DffOCdBEo9RcnEXIgA=;
        b=OU04iyCdTmkWFMqsQkGmrxQ8WcGVBaD9s7WVxz6maxmhJL9HJAfE1ohlYhbWT3+q3M
         QvdCUalDsRevwVP6y/qFKh8bDxJwvB74qSZEnZKPRUrQ5InUR+aAYT+y3Pfv39F5pIs+
         tXKzIwQn+vbZpdDO7xjJXu2zJkl7cyCPOBBrokJeeByyV2JNZbRHrUIFriNJvKVr8fHH
         v5yDMdt4YwOCe7+G7Zjyw95PhH2ov6KLsMsMMj87bqrb9cC9+G7p5kWPoMX8978Hqgcr
         US2icvp/1ZK7h1vsF/lNrQEF/wpYrOV7iVr2M3sUIg5xerflIPaUfU8cTJjTs8wCXOXU
         vC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082567; x=1790687367;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBWc941sAI+gZg6+h/vlg5P6+DffOCdBEo9RcnEXIgA=;
        b=YoBZavyEh1KTxf/4D2aRzu3PZLjyqya9scTheVKuRlTtpeRKl+EWCyPr+rw7uDDSi+
         PcDI2wMQZEpcZ4wUk7f5crERu9y0hwpXX9EGp9VHx6NC20aa6ucF0AXpANO5NdHOcbwc
         4drv4jN+UiiGQqpKz9nRsfyP1X53IxLKhYn9uUBzKP+HQhdtGSjnTW29jwhtWfUyrzhj
         TU9ixchhC6CU9TiSJa5PScyjSc8+FhvqCVDRAlRh4pfedD6IbkId5YhRVdTMGbTP0e8f
         +FmguVDP4lexw4/srkwZC6rsKjaLdPWiri8ub1Vzi8sav5hzoS+w0fTz0rk/+HCSbBYL
         7TSA==
X-Forwarded-Encrypted: i=1; AKwUvBz24JMot2QevO3c4+Or7I7GnvNJEiKz0u+GScH8plRRCxDxVsdiHru4+NJCTRKDQfsuS/lYcz5KZxhGhCYS@vger.kernel.org
X-Gm-Message-State: AFuF++kCu61UifresPh/TI8j+XyIfkCjhbZwHAuwAEl84fHghBpGoGrG
	c4EqIitP48NEohahzMnRCN93Tizdv0D3X1Wund7gC/hHhsxjZ9QAg6gr8WfZDSMyCPEZmOrmKSu
	Z/jpnqdd8BQ==
X-Gm-Gg: AYBFou327krhGYLM+rGeHzZ583OaxJ+DuQinYQhKzjrRNqo9P4mKNerNSK81NmLFCsE
	TCKN7ky/DTmBNouSJG1l4LL9hnpcWv3vSg3TCIKb4ej7fSILFOHX6jXv9QqFw0B9yoQRng+9z1u
	8jgUJm+6psKmzeljPr+hdOIK+NeJL3PrG9cAFU23N4cQ5hnJI3GRsMVc8dewafmfLf7ir4jUwiI
	SQgNQlfiI1UeCynOEuw57wBM0W7Nf5Sz38o/QeE34zypgHu6w81SwNt37c6f/7HvEdq5ReDpCvU
	4hitN2gNJ2F8f2QUrq69xcBoK0UBY4VXij+B9I6FcNtHa5vBfEU/QRldtdnOScO9isDdxNhXEqZ
	KzyvsUR+37Dpx9BG6AGrSiLyB0+s6QpEyVhb6Sflqua0WRtdTmlGYk1+cEp9pm+znrC8tjhsihT
	fuGZXX4xhXYqbYu6ho88GrqDjl/gBzUjbkX4UTy8rW71sQ5ugsxLphCK4/PnyXyMAoiX0R+NjE4
	9AlDf1z1WFDmvczxNuZxzwG6GIjB/OVMzHOoTRD7o13b4G2+/41TAVqYna66M3cFw9NBok=
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fc5721b9dmr210051475e9.10.1790082566983;
        Tue, 22 Sep 2026 06:09:26 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab3070asm25001075e9.4.2026.09.22.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:09:26 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-modules@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Add stubs.c for CONFIG_MODULES=n module_put_and_kthread_exit()
Date: Tue, 22 Sep 2026 15:08:17 +0200
Message-ID: <20260922-module-stubs-v1-1-abe465a24879@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260918-module-stubs-dccefe41dace
Content-Transfer-Encoding: 8bit

Module-related stubs for CONFIG_MODULES=n can normally live in
linux/module.h. This works well when the stub does nothing or simply
returns a constant. However, some non-module implementations may be more
expensive, either because they have a real implementation or because they
require additional dependencies to be pulled into linux/module.h. This
header appears in roughly 15k #include directives across the kernel, so it
should avoid bringing in unnecessary definitions.

Specifically, linux/module.h defines module_put_and_kthread_exit() as an
alias for kthread_exit() when CONFIG_MODULES=n. That in turn requires
linux/kthread.h, even though linux/module.h otherwise has no need for it.
Note that linux/module.h currently doesn't include linux/kthread.h and
requires its users to pick it up through other paths, which is itself not
quite right.

Introduce kernel/module/stubs.c to hold such stubs, built only for
CONFIG_MODULES=n. This mirrors kernel/time/posix-stubs.c, which is used for
CONFIG_POSIX_TIMERS=n.

Define module_put_and_kthread_exit() in both CONFIG_MODULES configurations
to call __module_put_and_kthread_exit() and add a CONFIG_MODULES=n
implementation of that function to kernel/module/stubs.c. Since
__module_put_and_kthread_exit() is now implemented even when
CONFIG_MODULES=n, remove the corresponding '#ifdef CONFIG_MODULES' from the
noreturn_deny BPF list.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
kernel/module/stubs.c should also be used for add_taint_module() [1] in the
future.

[1] https://lore.kernel.org/linux-modules/a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com/
---
 include/linux/module.h |  9 +++------
 kernel/Makefile        |  2 +-
 kernel/bpf/verifier.c  |  2 --
 kernel/module/Makefile |  4 ++++
 kernel/module/main.c   |  1 +
 kernel/module/stubs.c  | 11 +++++++++++
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..4c7bd7f9f889 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -658,10 +658,6 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
 /* Search for module by name: must be in a RCU critical section. */
 struct module *find_module(const char *name);
 
-extern void __noreturn __module_put_and_kthread_exit(struct module *mod,
-			long code);
-#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
-
 #ifdef CONFIG_MODULE_UNLOAD
 int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
@@ -850,8 +846,6 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-#define module_put_and_kthread_exit(code) kthread_exit(code)
-
 static inline void print_modules(void)
 {
 }
@@ -879,6 +873,9 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+void __noreturn __module_put_and_kthread_exit(struct module *mod, long code);
+#define module_put_and_kthread_exit(code) __module_put_and_kthread_exit(THIS_MODULE, code)
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..08a94594975d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -58,7 +58,7 @@ obj-y += liveupdate/
 obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
-obj-$(CONFIG_MODULES) += module/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..be70f10e4968 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20417,9 +20417,7 @@ BTF_ID(func, __ia32_sys_exit_group)
 BTF_ID(func, __kunit_abort)
 BTF_ID(func, kunit_try_catch_throw)
 #endif
-#ifdef CONFIG_MODULES
 BTF_ID(func, __module_put_and_kthread_exit)
-#endif
 #ifdef CONFIG_X86_64
 BTF_ID(func, __x64_sys_exit)
 BTF_ID(func, __x64_sys_exit_group)
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 50ffcc413b54..72fd2972eacf 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,6 +7,7 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_main.o := n
 
+ifeq ($(CONFIG_MODULES),y)
 obj-y += main.o
 obj-y += strict_rwx.o
 obj-y += kmod.o
@@ -23,3 +24,6 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+else
+obj-y += stubs.o
+endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..a8bf803afa81 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -60,6 +60,7 @@
 #include <linux/codetag.h>
 #include <linux/debugfs.h>
 #include <linux/execmem.h>
+#include <linux/kthread.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
 
diff --git a/kernel/module/stubs.c b/kernel/module/stubs.c
new file mode 100644
index 000000000000..81e66c02260c
--- /dev/null
+++ b/kernel/module/stubs.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include "internal.h"
+
+void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
+{
+	kthread_exit(code);
+}
+EXPORT_SYMBOL(__module_put_and_kthread_exit);

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260918-module-stubs-dccefe41dace
