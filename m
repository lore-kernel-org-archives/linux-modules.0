Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47C342CAE
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957164; cv=none; b=eCuFd2dqI+cPiHAM5/F/kV2dPdJb3z2OAJ9MBGdc3zFBFCrvoficRfiAaCpFt8nd6qf5JFbu0p0olSzE0D6liF+UxqdPYkg4N/4VIXGmNaPmXqS29Ltc3CFcPJDLuqIh7nOpwmpgj9O6S3HhSHtf6YZKfbSJzvewC2sejDsaUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957164; c=relaxed/simple;
	bh=/OtVIm0Tic2jaMDmVwxI6p1VsRr2RMHqItaakWV63oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNXy4aWSlblKOfaLf/Gw7hfl2eYboOvTCnkXmL3m7bj5xg6JI39/i5gtLUZlM8vD9MXYdCKQTDhjAm/GadwDdv9JiXpnYSxdRf+kR4QjDlu+AgHBpPcIBjmmUcEDqR6JAsqToh1NnGkz1G1eDDAYgqx8xXyFXyJgQttIxKa2NMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYm9IiCh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYm9IiCh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-786d1658793so22032467b3.1
        for <linux-modules@vger.kernel.org>; Fri, 05 Dec 2025 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957160; x=1765561960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIMsjwiJg4RqJtb77Sd/3hjNTplhvG97vleKrEOTwfY=;
        b=NYm9IiChSv/tk8xyCZC6OCWSX0mOSamUGFmH0vPGGG8++Zpa3B3zL7LNdB5HrLISNP
         lTTFhr9MRVubJdymuqV1atpRDTQVAb8KmdkQJ+VvrP2x2hbqVcIw6uG3FWY2hX1rHR/L
         eGqqSGeDn2+aHdhK0zQkfsTX42ZzZ5d/yYLoU2MDku96CVvgu/n1FHIVrvb/a2Ai2aPo
         zuYzuwFpHwlJRmAyl7AqVrlqyoprUCveJCkS+p79IubOnqOytKONdD/F9LL4onX4O4D4
         Ol9rYgKTDQeoSMv9Lgrwfvk0Yd8vw1KhOSgBgiBTVWf7WoaP0EaC+cp/YkXq5cXO5kU1
         Bqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957160; x=1765561960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIMsjwiJg4RqJtb77Sd/3hjNTplhvG97vleKrEOTwfY=;
        b=u5/zcJoXcVuG9MBowTyQrA5zQ1SvaiLWuCoVCiqL6KNBzIMBQDBm7twsyvlE8xKS4H
         t3TAAAdOJ0XZQPrMQxQPFfgST0IrqMJyuLIOIP6owWcWwJOrZXUJzf2Z7qzYf1o+LmNr
         /ACWsdeJwN4eEwx+kGpIAWwwC20rAUbGVAtbu1oLGyjS84T984+oVgpcJPHXPQdtNCrS
         iJPWTHoARn2y8XZdcMuMbAZ5ySKNRX70wqntY4TFVAVeALNFzAZD86c3cb0XduhbhJcd
         4g9P1P7ndiqBiI1+em5og2e4JrD1MEsI2K53rQryq911NPFgJOHA58MsoNdsj/p3qVOl
         znhA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Jbx2akipGh4FqZnG/RxWkoixindWYUlW7xn78sdpls5oz0dTpj5ukSHMF3lnRryw5l4dFF+Z1OKa8jIU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GkGqcPS/AnJ3yHeG4bK81WuE0yCffW+/lEIn8LurHQj4Xj6r
	8jUBpVx3+ju1HBt+idKeiK+36gkjaql/T7lKue9cWkx5za6bRY6s4uBU
X-Gm-Gg: ASbGncsKL1NV9NelpxlaOsZuupI6D7QeGswdGhAYdrNpXb6Nc5ISrnw24DgPuThwHey
	Y/TqrUCUqS/gFVD4mIICJcyyBwjScYjnyFZ1cpdroSLufEIYt6Ck6D3wPWDCxY8HZfWmaxKyuaD
	eRMoM8H1Sc/BhnHinUqI8Y61cgGZqeOrVVL3REN5sBx8bLKuKy+AiUlU1s5/Dsf1JUlFiXwXtzO
	rYvtUznNDFFGdRX6anQoNUk88csjzyig3rzMx4LKJp3J4o0DdGy+qdJHGzGy1aVn4tCqEKzfLoO
	9J869q0CAXeW8b3qgXVVQuiaqa5EE3MG6Dx/BoGowcvqj+0f9FsA0GgR6La7jL0uqmLZccYDkqu
	7E1GnxJL/xoaLRXxA/QJu0/wyTD+sIvjehxL3kuP611ZAqeGhlzXioWhvnE+cXk+f92PVfUgK4j
	4idYxQ6Q==
X-Google-Smtp-Source: AGHT+IEj0tKsgnYq0A9mSlKiTaWZ9dj9I4yKU0s/KO7Y2wAesrkqKoyujesKH3ZFEOTbGXg0vUaC6A==
X-Received: by 2002:a05:690c:6f83:b0:788:e74:b267 with SMTP id 00721157ae682-78c1893c4e9mr110130367b3.65.1764957159703;
        Fri, 05 Dec 2025 09:52:39 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm2042888d50.16.2025.12.05.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:39 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 1/4] kernel.h: drop STACK_MAGIC macro
Date: Fri,  5 Dec 2025 12:52:32 -0500
Message-ID: <20251205175237.242022-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205175237.242022-1-yury.norov@gmail.com>
References: <20251205175237.242022-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macro was introduced in 1994, v1.0.4, for stacks protection. Since
that, people found better ways to protect stacks, and now the macro is
only used by i915 selftests. Move it to a local header and drop from
the kernel.h.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c | 1 +
 drivers/gpu/drm/i915/i915_selftest.h               | 2 ++
 include/linux/kernel.h                             | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 87ceb0f374b6..600333ae6c8c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -3,6 +3,7 @@
  * Copyright © 2020 Intel Corporation
  */
 
+#include "i915_selftest.h"
 #include "intel_engine_pm.h"
 #include "selftests/igt_flush_test.h"
 
diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index bdf3e22c0a34..72922028f4ba 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -26,6 +26,8 @@
 
 #include <linux/types.h>
 
+#define STACK_MAGIC	0xdeadbeef
+
 struct pci_dev;
 struct drm_i915_private;
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..61d63c57bc2d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define STACK_MAGIC	0xdeadbeef
-
 struct completion;
 struct user;
 
-- 
2.43.0

