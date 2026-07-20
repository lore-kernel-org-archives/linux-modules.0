Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC283D7D72
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549811; cv=none; b=IXk9bZ4UAVLH7LuHZjWwB9IA28WS9le9yXtTEvEsyn6yPHzevPV4Z3PurdkGKl18XhDuiseo/p0V+P6/FhLoU8pThEWUNvLw0NEequKlAI19UGClOlHb7nzk1G7eFY38RpFLevesBpzJFYecSackHnh9YGx9miShyZ4xnoTd//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549811; c=relaxed/simple;
	bh=ZXEpkDFwL/rwUncoDs+qBTzK5HHyoQoZwmumdWwaDWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT6ttLW2Mu1beiZuGGE81VDkP5r7+pdE/9pelsqDDBXEhaUkRw/pdPVp9vuGxT7PbiPNEZZDfSBBErRjgyDqJS/nBpWI1UIzgRNMUiucxAyBZ5nc1xRPMA2Hv1bhVM6H4BchOMP4lqq8Q67mOEwL/1Xp9y2uF6viwRufFWd0aQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MbKJID2t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MbKJID2t"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47640541585so5034520f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549804; x=1785154604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7C+l5bQ28x2ipnVvxZPG22FlExKRkr9Lej+PmmTvr4=;
        b=MbKJID2t6kp6fMk1nfH1mKZhbmDfLKhUEb6GG86Jbf90QrJmKXWN3N6jNxMqo9YTFU
         voeYawsMc0TQuUDJq1XJjuLPQt9uMoBAGdA5hqA0C33CdWY0PYyER9EvWEdoXZRhxBdE
         KnCjKlS4sUAQfvsQIpkLyHrc95++wqhzrtn285V9C+ANh7BLsh8nixQlN3ldPtMbYc8k
         rkMd7zaGcow9U4t0nRcgy7IYCBpi2gz8bDHRtiJ43X2pNOCs0ArWSeLnicIOsq574HWf
         nRuVzik/G2jZLd3Mr2cOD+UBxWnv+OpOz+UF6E+uHMNguoZZ+02TJP4WDGvWqjMMxDEy
         1j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549804; x=1785154604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E7C+l5bQ28x2ipnVvxZPG22FlExKRkr9Lej+PmmTvr4=;
        b=mTNx4wQ16eUUM+TngxLJa7JHC8kwGJezFocR3/p12CBUZIhxi5Tf+qUyUl/ocZzUvS
         MyasFD8TG69ocslnVbhG/tLYcAyc3Dta3UtfoXCeI+hA9K1tGoM0csMGZCjZuOVxJhYC
         K2OHiw/xFhq8K3ybOToGjFyMU88cq/aOEniJtCOTGLTB/d9Zvv6+HPQ0338wUP16dbhS
         Uj/YTa3Q9MfMozCGg8/dr6xyAGNRaRMeZhSNK4sPJwN4YqhJ1FJccZAmKD4afUAbH6r2
         pUdKDrEc4JWNl7z8qTZc7ZlHeE9ixofAtIRruHjq1o9wmWJ2hTCXXyKial688ufJzPiC
         FOMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxEp3rx5HoZWKHUeGkkQnvH0OjwgxP3DP6lktxZzHn3i+1y2Zw0JEIXgCk57aA81o/4WRRJEZKePe3XC0U@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/YuxshLsO3UOsewhPn6u6GmIXlJnPrwx0JfF+J9XpHEDyJY/
	a1L3zbP4h9tbJSKZTBT6JF0vYTp32I71AmEtKJdIq2t/ijvl/hm9A547RdbJuUv2mJXPu7WRa7s
	+m4z+108=
X-Gm-Gg: AR+sD12TxpdWdIf7DFa4HXYciENandR+1YHAjKdbettZVAj/5r/6BwPefK9Ox+YifAK
	d5mlYTMWbMwVtRMoNy21v2nzmHC8txHOLK6dmx5yBrOrL6epZ0Wbeel+MTapws26oSdSGaoV9QM
	AS0MDZnTCVtEsYRy9guCcCsN1RudnR4dfJD0z4wA0frP2ofG0IyjHMZboNXBOEkvcXlqk5Q552K
	rgZ5PhkZBrA1OJciiJoD0D6nZdSkLHXpOYoNQ9XMbG/Egmpy/I5Rt8acfZjdsx2l6H+Yo1z1ucn
	X5yykt/KTH1lB1Ul+c9Av3I/Tvb3IUcEVYdNf9judZ4Tzm1NKMoeijgYcBDm2QFIc9NIlGJ4c44
	oCW70rrDHsVz1HeoaZU2KANiA3cw6P9QWxaLTcvx1wJdKZVgf0LGn/5kVlnMwzKC8hssulwzO2w
	==
X-Received: by 2002:a05:6000:2907:b0:470:a7d8:75f5 with SMTP id ffacd0b85a97d-47f6233d406mr15982775f8f.42.1784549804129;
        Mon, 20 Jul 2026 05:16:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:16:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] module/dups: Clean up includes
Date: Mon, 20 Jul 2026 14:15:30 +0200
Message-ID: <20260720121621.750661-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720121621.750661-1-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
* scoped_guard() -> linux/cleanup.h,
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
index 43cec4cec4fd..76faa662f14d 100644
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

