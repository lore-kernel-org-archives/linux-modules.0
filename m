Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABF2FFDCA
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185739; cv=none; b=EHlMs28SpllMWZt2xmXXSFwzvrPXnF65n1flkuJnrd969538rrEjgdeTWzM/svULbHveXj6phHDoMj3MOyALGGEt/IKJVBjPps8Rk8QYeOehtVHJsB/C1hf4wpZxyihvieZCCz3RKxH4mah1cmuCBb8XA5jBiccy8x498vcQ0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185739; c=relaxed/simple;
	bh=WNxr3Y478HaUvvOY7yu1AY9rWgAohKW4ZXJZUfFcjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Otz/nvzb7eo0ibOFysMQKOJDD+pLuDgNEwHm8QL1FFAh8lb+zrS7JeSVBGGJgsJE0ZyStfUH1DKrVIWN32Y/jZ5zAbDbvsvWE4q8MmeSWpidrkrAg3ArGPRedUdeWfuyslEOXUYW5B/Yg64NNKcnpEhXPkfemeX6/PV96ebNPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BYHOVqXl; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BYHOVqXl"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso6743705e9.2
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758185735; x=1758790535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6a6TQpp80XXGcBU+bKMB1CzLltuk6SJRC4r4LXS2v9s=;
        b=BYHOVqXlorajPYACurLTTjw0mdMAolZ0rK4nWWAnqKgpDQx1i2yC9It0wk9Qakjf7z
         sBdpn3iBjPNqLGnLUE/Rz7q7flO9wT8+K0iLY8YY3BAZG1pOvnu/aB1w0xGT+TDJLzT3
         3rsBkDo44UlIdE+A1JT4abg+XkGw8Wuvj8B96UUlYqN6H64MFN1/GpzxCnyPj5u5n0Hm
         XgLMhW3dQTZzfsSyUE14bqu7x/KbvpXH4XbpiO6bnl/JRjkd9XLjVq4K+cV83u/jFT4+
         30Qk7cLyJKWv7HvqH1Hzzbv655NxKEBQw2cArHBRidDzSJzwmBHVmiFtfykHI6JEhym7
         sqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185735; x=1758790535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a6TQpp80XXGcBU+bKMB1CzLltuk6SJRC4r4LXS2v9s=;
        b=D+ZbA9/oub4924mpOBfr05xHJOW7GGEzaVhCFxTGVNoyjZx8vqEPCqTW9APNVQYZk1
         P/SYyz4eyRtHFGgE5IYG3gi5cnLZEEbnudYAYyI75XSfF7xZ2ozOrlyuumr9CDbP3AT0
         +qhmwS8cHUdH7Ze4RrUF6iQymIil0aazSCAZOZfWNvsWzZldkYoaaXh6GjXxmdamVnq/
         3F7HF6O0JpvQxrpzevPSFI+URKWJXqmxN9dJe1j7SKCYbgkbOXXZze5N8V2bGqDRAdAq
         zdpu8vlDcu4M3hKavtA+9HOPFZyb8sioG2RjcEaPt3HKr+0rUig7DaTNiFtPex63ANu0
         XoGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrv+wEnRlUkNPE1UFGxqyluf5queFn+Adjc6UDikjypR3YLPdFt8IZXtSxV0bRC7Gr//3eHWFwGbPLMrIa@vger.kernel.org
X-Gm-Message-State: AOJu0YzICz2YxyNqK3xtTUYEC9Nl2d14gw0GEtVLPGx/jWHHZQvatXct
	JfLvnA6O9UQbSzhJgq462ppLxrT24qnMw+I5lcuHsYFfFnUYZbowmU4E/5jMNwSce0o=
X-Gm-Gg: ASbGnctQAP7bFJsFVKEtpp8MiCDr3U8mgof9ty+U3zdt03JpM+MAf7o5uN1FAeBEhja
	JOLALo5glODbpVcjU4V1mMfMdZEvjCn9mGWWZ8jnFDSPFeBYGeRNoi1iZCC79hg+fysgj0CrEuG
	cnK5q0SlikYmzvaw63s2FBcvmQr80aCZIBIqvGNKBY6oScFAfWqOGL9wS20JrSXmE1kE6AYlkwc
	y2IvHqZ08U/aEPOLiYBQSrSNE+ArqQNCJVCnoDZe7knmnbyXOhyOiZG1fWu4Kwqni0i1KkI9xnG
	PSJhqfXn7TV4XXpN5ft/ubRP7hRuPo41qQ7M9y1CPWCRAySaNLX+mFZzoo6SCBPskPCJo5QI4Ec
	MTY7jJEO5zm1dEMucWoVgNNbmaXet8dH6fzLv4B6UjFlZq6EdfLTmLzP+GO9oKjo6cIc5A2NIfU
	CI
X-Google-Smtp-Source: AGHT+IEr3pSlbIwZBTU4lmZg8JaukpBp1IxTHn0w6EIIJUcC0kVSEXiOskJAPxCFgH4N0cfANxL1gA==
X-Received: by 2002:a05:600c:198f:b0:45c:b6b1:29a7 with SMTP id 5b1f17b1804b1-4620348f564mr64104055e9.16.1758185734904;
        Thu, 18 Sep 2025 01:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122a8fsm71491355e9.7.2025.09.18.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:55:34 -0700 (PDT)
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
Subject: [PATCH v2 0/1] module: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Thu, 18 Sep 2025 10:55:24 +0200
Message-ID: <20250918085525.122429-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.
        Because of that, system_wq has been renamed in system_percpu_wq.

		The actual code doesn't benefit from a per-cpu wq, so instead of
		the per-cpu wq, system_dfl_wq has been used.


Thanks!

---
Changes in v2:
- system_wq replaced by system_dfl_wq, the new unbound wq


Marco Crivellari (1):
  module: replace use of system_wq with system_dfl_wq

 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0

