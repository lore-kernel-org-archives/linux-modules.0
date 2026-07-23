Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FED3F23B5
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795214; cv=none; b=gtPCuUjqJzXC1tXuQ4U1mIvt85GnOo9wNS6ZhzwVLKJTP9oJsjNmWglYaOGf6E5TXr9RKCIX+0pXa0qFJJW+v1iirSLyhXspX0Y/2N305Q+0Lq5NE0LqmH910UzS4og1XHqgDJ280JQ+a3/XEvTujt3MA9bDao1mEWyAcbcQqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795214; c=relaxed/simple;
	bh=IgiwPhZRnCmibJAtp5gN92zy47gDauD1GBlPirNJdlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNUy7PhwGfvSkKDr9xDm2mpNXrBfT/st1l9zfrSMriRpNscBOCWwScUsPx6gPAy+YhnNrtug++kHkl7Msnb5/XM1Q0TCLSJTOMvM0z02iJrtKE9psYpcyzjNR4fHcM8tJOkPb6jNqltbKd+w5yJ3TKQJ3fDLxDnKlrJJGaTNlcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JdlypoLI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JdlypoLI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956242332dso3356775e9.2
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795205; x=1785400005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUb/Fmtm5YHhP1LhLkb3EnQ0f20iq+ZT2Qlt/e1gqvQ=;
        b=JdlypoLI/UrpB1pSB6RxGkJgYfJNCbQncXnslppynrmhia+uxqmml2HuKkvy0qf0Xj
         afmj9ozsnS1IdFUPRS00dKTS/q8Bp5lEGMdGwkbuqOYhT0CNCcEpIXWccaAWlGGGx7T6
         +I7Bpn3XjvdPIkXSIKPuck1C9vNRkFfPX2j2ibSoqKnTT7tXMntVIgcoc6q6TR2l+AlT
         heYoZSb3iAGa4z1+OWZyNIppBYWmarPLo0TXS3yJklLPGfMKMhJqAuiaLp7ljRRL0wSw
         Vq19BTWv+j3AWDGGQwtBSttoL3qCFE8BPv+Fbn1VJW3hi1CzsJAxnaRN7YgWoOAlkrrQ
         w1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795205; x=1785400005;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUb/Fmtm5YHhP1LhLkb3EnQ0f20iq+ZT2Qlt/e1gqvQ=;
        b=Gjq+QFzNZxgbjTeIcf+wKu8/wjsRgFMrh5C7PuKPCJuMLw8szcG27x8IOCZt3zvbkm
         k7QlI3UNGmQ1PuvgKQ01RSxiVTXT9CFs302cFCzEf1aLX7HAHxNNWuTPdzBX0/xz/Rj1
         /9jMA7nZ2TVe8PZPxRi2CS0ceF4DOL6SaUv0SJD5GSkRTEopCYjlERFqvPRNhlkRWxAK
         RQMwULSBF4MFKYYehjptVRQm0k8FaHggqDJEv7VgrZ+C89fnTBU+0p3wEsD4CmS3AOEO
         euva0RNHBp5wTgd3Gu3I6crw0Pe2ABE9/f8WhTK7nuPkp+JKxbc1NlT8TNTKoGAbmDDF
         qkaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5MmWXonKEsZaXrsJyQuQOMOXfCgQTqworFs0uwRnisjP/lqdfZVirprI0MfYQpGG/9LgoXaHX7oEjxAH4@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4R2FUo5tNrqeswQ5JCMHAKqlc2cIu+tDHgguaUpLsgmC0SBq
	7l6q0PH1kaMvThJqNU5o1TQ5dUyiA+U9lurC6YhEbGiak/ucVlBZafjk3NZnf+IXsYI=
X-Gm-Gg: AR+sD11+/TxTTNTQTCzf16vDByJn+wqG/q9tC5pKF5dsdch2mTvIkl+Qi6psdyTphqa
	3cJ2sQwLoH5Q4sAsCijc0CV9A9OqYltSs4rpBbuu0701W7Ybpx7/eIzgHhKXa0PZM5lY5bgMipo
	oFqoTzcABiMKcu/Uq/445zWSouKc181o9V8uH83IpUMkC6+qwAdENRRIjaWdT9Ih2ssopGRipUe
	PWwCjt8bcyr4eeU1yG63rqaKO7OnG6AE/WE/iFbVrbIxINyD4hyAdVGmRaDT9GtYtuWVUUm6z/X
	LTXFpSW8N4khhtuJ9NcJI3eyq5dgSvYHnwUaGXtAYWDgbSeh6dUJ7exC87Vq5B5r51RqRtp4bmo
	MgWHuKo0R4kx08J+7KL98VU0k7yzG6tRHUvB1w35Qps0ZWUKvC5OILMS8OYSjV4Jf6P39SzHzXg
	==
X-Received: by 2002:a05:600c:6a96:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-49573cd03f0mr14489445e9.13.1784795204743;
        Thu, 23 Jul 2026 01:26:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:44 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] module/dups: Clean up includes
Date: Thu, 23 Jul 2026 10:25:56 +0200
Message-ID: <20260723-module-stats-rcu-v2-6-bd582261fae3@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kernel/module/dups.c file relies on the following definitions and
associated functions:

* module_param() -> linux/moduleparam.h,
* DEFINE_MUTEX() -> linux/mutex.h,
* LIST_HEAD(), list_for_each_entry(), ... -> linux/list.h,
* refcount_t, refcount_inc(), ... -> linux/refcount.h,
* MODULE_NAME_LEN -> linux/module.h,
* completion, complete_all(), ... -> linux/completion.h,
* delayed_work, work_struct, ... -> linux/workqueue.h,
* lockdep_assert_held() -> linux/lockdep.h,
* strcmp(), memcpy() -> linux/string.h,
* container_of() -> linux/container_of.h,
* DEFINE_FREE(), __free(), scoped_guard() -> linux/cleanup.h,
* kzalloc_obj(), kfree() -> linux/slab.h,
* pr_debug(), pr_warn() -> linux/printk.h,
* WARN() -> linux/bug.h,
* TASK_KILLABLE -> linux/sched.h,
* HZ -> linux/param.h.

Update the file's include list accordingly.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 80e1638ac34a..872db6159b48 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -7,30 +7,22 @@
 
 #define pr_fmt(fmt)     "module: " fmt
 
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/param.h>
+#include <linux/printk.h>
+#include <linux/refcount.h>
 #include <linux/sched.h>
-#include <linux/sched/task.h>
-#include <linux/binfmts.h>
-#include <linux/syscalls.h>
-#include <linux/unistd.h>
-#include <linux/kmod.h>
 #include <linux/slab.h>
-#include <linux/completion.h>
-#include <linux/cred.h>
-#include <linux/file.h>
+#include <linux/string.h>
 #include <linux/workqueue.h>
-#include <linux/security.h>
-#include <linux/mount.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/resource.h>
-#include <linux/notifier.h>
-#include <linux/suspend.h>
-#include <linux/rwsem.h>
-#include <linux/ptrace.h>
-#include <linux/async.h>
-#include <linux/uaccess.h>
-#include <linux/refcount.h>
 
 #include "internal.h"
 

-- 
2.54.0
