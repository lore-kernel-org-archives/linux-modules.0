Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C152F3C39
	for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854665; cv=none; b=WGmAwHysy576q3dnEHl56BUwhS+lj+DHfPAQB1xQGpOB2eVEbMPHYmey+MFMvaNtntBXZdLfLiOrbzy59SGTXjXAuZNZ8F/0Gx0TvkgoLFRi8yo1ZriZpaG4KanRM26KPPmLvxA0pl/ewCM2Gjxm3vhsuyHpIwRhzvL70d69uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854665; c=relaxed/simple;
	bh=PxMjrQfLGCNPCPfcG+3vDmiZS4Gy+k6Hbmk68mQZykg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJ+DbIj+KaKTppvhLB/yVDF27tFxzAQr20XKINP5NMIJ8nDBmrVKobpaH9L0oFKY+lw1rO08Tz1B8qrhvXKOqQ7x5y8xU5iWE13DOkafjjANQb1S04aa+9f+5gJDDDPBqsVEpRwIUENX87vIqxMuJY/jRfRx9r37cFu20+3Fnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VKJH3jyn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VKJH3jyn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so883881f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 11 Nov 2025 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762854660; x=1763459460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COk/1h5aEbbVr2g94DPcBm4hMzvak0kI6Rv1sekEHQg=;
        b=VKJH3jynHExwz7NhLWH/gUYB6qgW4gFUGbwK3k0BR24ucb1WXLS9SkkBdnuHVNJDBu
         lSow5G1x+NQo540tS2Vq5NdwfkmtIPzQ61cAApRZM6Mooh944Jfgy91GuLrmHrCJ3gkW
         aiJ7liS2Cuigntb1QsXiBt0CMZIARMhLPIaTSK+mtqmWlGfI5UnDPlDRNLqZQQ0bAi1I
         pxMgBhLpuHUH3vlwFVbW6YF/RSv7aBqy2QwKuAFdMRAVvYe/3anu+LVxbA3eR2sGDjQA
         ohj2tO8YdTJj98hX7JkoB+JVTnYTVTt/jEcfATdCA8bm4jo1mNsgIOBlkl3QItaXEmX+
         sTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854660; x=1763459460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COk/1h5aEbbVr2g94DPcBm4hMzvak0kI6Rv1sekEHQg=;
        b=kX4m2WV+R6oBUWZ+GdbUtIXCRqr7ximXcUtItuM1OrgnCLcl3BTEmpk+QytGeNyeIb
         gkCmbT9Ib7afn26+QAyg8nNPP4bLNibf93oVqYdVtKd58x8AaBqOHrpN5QD9UGIMvoLS
         GNacY7l/HNeaPqtszt6we/haxxn/hPAZagRxl4cNMva/nlXLNpf/LxqwKuvsg4coF8K5
         q28EGRXssYaixFNUMR1pfB/ACPC6kSl982Xhn+UgjjeJDPawQWeorR3dEBcEPcHIU3/T
         hUZjFgP449inTLNySd7wt2XAJ/K8g14KIz6rMq+UnRPdSIHpU3U5rKHIOkq8KWijQNU8
         NPlg==
X-Forwarded-Encrypted: i=1; AJvYcCWt0UOyCbHSGq6B4HTpL/pY8UTnhYJ87NoWWuPx+y5heO/moohMhY68Xi9Qxw+j2gtkv56FHChnok51Hvpz@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyRAHSgdL/Ct+BrKs1zALk2YikhLQ2OgreUqCM+QAMYjsdinC
	nH28OXz4I7Y1SF7oLufMPp2+1Ct8jqqrayqy9FvgBity8exnToySl3GPOdqhIHWBmyA=
X-Gm-Gg: ASbGncv9vcPxd5xmihM+q40Qgw/1SUabBksKzMH1rUV5TVPd3D+JntgJHuB6CpeNjK0
	PEsLvWlt6hSXazgV+TysIkUdPUBVQbvGnofib7R6Rj382lupXweED49S4UH3RuFtAQVCCcRxlR7
	OhIIoxxglNVG2o9vgLnP3jF3iNzqvwr+wVZi5JrzX2pNe7swObzdhNTKav81gL0b8uzm07Q9r95
	MAgVnP6+JT3OYJD2XaNgxz7Giu+dFFjqRZFeL7n//jzKZ1F5Tz9h2i+QUfFw8pR7wF+9Wfjmjnd
	fjArQ470LD1hlqmMCh57LgvKBwratA8XGw6A0Vpj/wMrIaxUxxI+xFKfjZvjEU+K2b7omhQ0Emj
	HmKTX3BrzjToV8zsEzeYuYai4Rc3ecWyJXGj3F0GVMgsUQRTwy73VI+zCp+h6F4BQpGhowKhkTu
	7+tGMoK8oKxkIlMzyStsnetkOx
X-Google-Smtp-Source: AGHT+IEGGihhO34PtW58vPvnGz96BDqop1knHZcnwdzlKCuwCgN24yrgoK5E5PupaYVgZy5LodYAqg==
X-Received: by 2002:a5d:5d81:0:b0:429:c711:22d8 with SMTP id ffacd0b85a97d-42b2dc1eb5dmr10445085f8f.15.1762854659576;
        Tue, 11 Nov 2025 01:50:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm27136013f8f.30.2025.11.11.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:50:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3] module: replace use of system_wq with system_dfl_wq
Date: Tue, 11 Nov 2025 10:50:49 +0100
Message-ID: <20251111095049.67658-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq, the new unbound workqueue, because the
users do not benefit from a per-cpu workqueue.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v3:
- rebased on 6.18-rc5
- commit log improved

Changes in v2:
- a per-cpu wq is not needed: replace system_wq with system_dfl_wq
---
 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index bd2149fbe117..0b633f2edda6 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
 	 * let this linger forever as this is just a boot optimization for
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * There is no rush. But we also don't want to hold the
 	 * caller up forever or introduce any boot delays.
 	 */
-	queue_work(system_wq, &kmod_req->complete_work);
+	queue_work(system_dfl_wq, &kmod_req->complete_work);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);
-- 
2.51.1

