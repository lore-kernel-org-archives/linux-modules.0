Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347042C50E
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007504; cv=none; b=t4fygJ1L3K9zGLxdVn9beF79iPVaGXjkkxnpLfhB5XUIEaAkSTRE1rgVP6tZCLjUW5XGZ3TqDWC6o/aDogb40HYFf2ZyoiLcEwZY+C78da866BIZkoix391asNU6zB2dZoKrrg6OVmFgHf94H6C5B3K1xFvVu0RIQ4obt0NDtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007504; c=relaxed/simple;
	bh=8QZMv6e8VZWNSTLr+L7myB6tWqGtrtUDOO5QTM4uNAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrI+jliE8TYx7uNocxYlVHNREr6otCAcKP1kLgbfJ9IWk5RXUf4vWpSH1T1hQH70ygD0c3zArR2tXxj+qNwL5dgGbKsijBOFQgr4Sswfy+WwHM7VMGnbQWP/eQX5cTnslK9yCCt3T0TKxCFg3AIaLpAhl9x89Xk5gmMbZ1I2RdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dlQUf9Qv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dlQUf9Qv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15422585e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007500; x=1786612300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a05UMz3w4bXA+1T0LMtqVZav3+vL6BphXj7PWM3R9OM=;
        b=dlQUf9QvktP2lXiJDddwFHp/haTf2Oc1BI6vDnYU6MIpREJeO1AaWaJpzMSYKEyd6m
         5YytYUlTY48NOFqm8LsubJqmYvoLwnNPKjcQcSR06a/+YBAaUqW8uqv/b7XJnOksocIo
         EbjH14pyFSNtLQMnSpEVk/pYu0ank/cN2rmfUL7gl+6Cf7a43CSh+tE/jXwwYg7TMS7V
         TpM4zuQyjve4TYYn57t8BDmYAItFUzAXJ3SVv+JW4bqB2srEmU2D3OSEneOvcyQKEAMV
         nhoeNpagODSwTGK0qGcir7Y7355xnrmKNKTtltFTUN+DsfxN3Gs2WkELU86C+rw+d4Sn
         ePJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007500; x=1786612300;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a05UMz3w4bXA+1T0LMtqVZav3+vL6BphXj7PWM3R9OM=;
        b=TfXek0S2ON2gk2dy9YscvBJdFZcLIYM7UHVTogk+nU0UU+gM+PFjFf3f+6oU557/4T
         6uZ3Q1BahWWg6xxgEYSEcTYuwCRWePfh0G10Tw/6Lcy8+dlqIw+Qj6rdNf0sdjKrhZKX
         /fUZ2MlaWv4C5NQe1SArIhkNo9CE4Or0PR06ca0pZX7Nauh81bO9d5UFidbCprZfgWcS
         X3olSyuyw+/Gs44bnTkX596HKlg3LIvUrmwSOJeFdaCLqJAdgzbLtIs9Rmsb0aZ2Gs3x
         eZ72F4HD8MWjpSmEqo43QqLmkMBCEqdUIkChYbPw/YD3Frqc77DTSmAsnrJRHRPf3kYF
         yXBg==
X-Forwarded-Encrypted: i=1; AHgh+RpdtgEHw5U3uwK9C7UqqNQ3aAqvDXbqBEl/r3cMWWGczK808CM1ZKUEDT7Q5DUnm6PMF3e7pHI5Lajs1na0@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgPXxHJ6S8d2zx4LK+mtC8i0rsC66wlIfCTH/QeiaOxRHCWex
	RcZSR9GU29sHiiWHrE/Z3c5f6An1lTin5Gq3NzptDofIwBCs8TdOh9DoLiVFdif9zyI=
X-Gm-Gg: AR+sD12EXV/JM38rSZgJyWpzdh9MjVGUkIIx7CasXagz2y58Le7Xl7BcNGq4N2iKF4W
	CtzlP2ThOx20qxrVX2xZjwUvHWapU6f87wehD39wAMAZf5Skz1qAh+wPk0kMLyRfKDToLu73hS+
	fSSoM+mXZJ2iZCugRvvA0iWL8vZtcPexa9au4raamX3smWZsCk5vVyNVZvsDtrA7FgmAM6cwLzS
	pcpKZmL8AaNyfUMx+kzEvlMxb5ec5V90vo18nvT1FzTCvoQ/KVIyjByl8zPKxe3M9Ifp7oiLH96
	0hzxnrLiQipedTimrDWNjPiOtIXstSY6mMMjnuYWns1GAzJLMyAQSjWJDUWgkP23t8x4BQ98KOT
	7zBZa3z71+Qynt6QKoqeK6bRfDNusOzzOstPxGpkOqmi6U3ZJcurOVeytQuAmIcpF2yppAJTOkL
	i1oc0wxWYc//ZaUk8Y8LGytnW13eEwJNFvcIsyYvqxIDDk7dugogBuacxq
X-Received: by 2002:a05:600c:c8c:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4994e79dc76mr151198445e9.5.1786007500018;
        Thu, 06 Aug 2026 02:11:40 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:39 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] module/dups: Clean up includes
Date: Thu,  6 Aug 2026 11:10:20 +0200
Message-ID: <20260806-module-stats-rcu-v3-6-2b0331106f00@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
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
index fa3a4e623543..c9be9df6a65d 100644
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
2.55.0
