Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9E4D599
	for <linux-modules@vger.kernel.org>; Fri,  5 Sep 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062900; cv=none; b=TPMtgABYh1bXhgU2wFmH/me5LOZJCBtzJU4A/n5K/1Oc3UcIOybVRE99zE5U50RmixASJVwzmc1YQJHcLv3QUhG7Xx4AJ6NrDeBJoly2fa7z3KLua1FRNl4zGgt1VtcEA5CuNDpUe6HYYmGyrL6dXJQ22i/y763IGRzkMMuopa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062900; c=relaxed/simple;
	bh=cGyyDSG1GzWNwkeurPjy/l1c8vZXE3XFpILM2E7gBEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsjjbfPnZP8aIsE9Tz7ZBUnP8cP0cs+MtzXNbmy+2Rx+nQk/FpfxjdvrFh5HHRn230CvZCZg/cuHrenyNmWhNRfNhCybYnNj8pQ01D+xmh77sRM4cZASGyd3+QbRJufelxfg3uWf6/vKRHzOkv58adR0UDmUsm6DbVzROBgpWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YcLGgeB+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YcLGgeB+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1521816f8f.0
        for <linux-modules@vger.kernel.org>; Fri, 05 Sep 2025 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062897; x=1757667697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdo2Z9PPqCjTVCvgZS5NCikYkA2Y9cRnWFdljkD//bY=;
        b=YcLGgeB+LK8/VDhkngd7FC19//u2/Bd1DXLAvi8O6DCn5jtgDWH+P9nC1Ut3IRxARi
         u0lSqDlElnDBz3ldkQOKBjG/cDSY5zSFCPpbQ5aJZfvLYerJ7aLpHGFjRm91bCOBA1e9
         llA+tZSI1Ybito76t4kJU8O6fSXILS6CyF3HO7ceNzXW85nv+HiwxO7Adobqw9vzSaox
         bRvKylwsVbw0uHEX5Aqb7QZV0yh+q0o8YcrPXEEdCzMg8bEePYydaLn5zLt+FSwJVVDG
         1UzrVF6CAyynPYh4xihmWlbdnSAImsAVYhk2sGp2oko5fByBTEqI5H4G/UuYEaKPvNH2
         FSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062897; x=1757667697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tdo2Z9PPqCjTVCvgZS5NCikYkA2Y9cRnWFdljkD//bY=;
        b=nxHR78dFkqt7kpK/Y4pmeQbGPCHIA7Ha5JfTylNtCcu7I3eXh/jl+ITg4fVZybjsuG
         9XQ3gR0VDChTdzq/xg9S5POiIpKw0AlneYatKxpq6fVjrFiVk99cjGozgK9vWsSAcpDL
         FaOP9ppbrJ4x/pEUdivVTvsj21Qrfd6dLsA/Rze9Spq4VCUA1zjD/EZrngp+8npdRjTI
         RVjJ6PiyiGZFQXtctIzFky4rzwJvDNrxAhpsNo1a1pWS54mn4GexyjSM2QXKHA7t2yau
         GvpqZ05LigZhZZ37IcRKSVOQSSeijViWOxdtjw81l4lXE6TN8xHwNpc+E4GmJjfusFOB
         B/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJXr7NLnKfB1TyRMNrDw3PBxdplqgm6kvwQlGICm503akjhez1kSh667pyOs8vxuioF/thT+DF2ZxT0ToR@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrUY117N6RVZp1IPuH3Mg3wnlY5shIpfvoHvcEMD3kkBRaKwT
	0cSTWY6IXXOOcUAIVEYYX+Uf+myZuYaOvAVQrNmbby87oCAdpM4UOnjmosqoj3r7+g4=
X-Gm-Gg: ASbGnctSy0Wsvg8SUvrs8yPNZgytEmHzEYx2rfzADG2EQBY9y2sR25vvVabetzy6v0D
	vY0y2EhQKwlEmwEyL1unc0lHsYJsB0qC3pICLHPyCnRAiz67z/7yqLXaZZ9W7ObN57viWqGY/Wp
	kKqnxCjckLl7F5lZjCAdhaXd1dMFSQ5nQZCfJT6M+2LDzjHbAv1cV9LgWCtwZUOJk87y1rYOGHY
	lxLx1VwT/HSEfB5+S7ZUzg3ruCZlLgagyYzVcUxSpJXHZZKlFImomh3fzDDlFYeiJJWQv2IOS1m
	Jg3OBGaTiSoVzZBQT0AV6yRC7xI5ohtHY16Kftq8OIpF+5xNwuvW7MTV1cFNlaMFk6M39e6z/yT
	HXpZQ7ICjfWV+AgIsOoxrhJXvPg2Q+ZqpiTt5AGlBMqcaRFgeE5aLZPWCaMIHCYH6v2qw
X-Google-Smtp-Source: AGHT+IEc9h0FxhkpZcl/AMrfhXqYv1I2pVgJ05WXKNDDkBLrVOQ/9HdmiTsCnnABL5cAu4xJ2l0udw==
X-Received: by 2002:adf:b1d6:0:b0:3de:293c:9398 with SMTP id ffacd0b85a97d-3de296a5f4emr5572984f8f.53.1757062896633;
        Fri, 05 Sep 2025 02:01:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm1317713f8f.57.2025.09.05.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:01:36 -0700 (PDT)
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
Subject: [PATCH 0/1] module: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:01:29 +0200
Message-ID: <20250905090130.101724-1-marco.crivellari@suse.com>
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

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  module: replace use of system_wq with system_percpu_wq

 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0

