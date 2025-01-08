Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6714B95A;
	Wed,  8 Jan 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327109; cv=none; b=cvwWORH5GMt9L9Ck1Z9YoPwoUQsvRypqw43agDrSp40CF86+c1tY/26fq/Zm3yGbY5TyT+PVNUYfP6w/ctIRqpWlYI7mE70ZNCVV+4/gxb6ZmQvZgWanTsNghpJmnNMY9GGlPeH6do+ZOZh2XFAfNDUuAquBu0LFZ4ARpz3QB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327109; c=relaxed/simple;
	bh=kwfNMejAdMo5HrQqhxS078PhwTh0n+3I/nDs5yDiY00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5G2srDlRDKT3BMCBYmT+BKAdhBUsIGte+2tyu660eGlSZ+FdvPpO89ipzIilSflaUJNWKfNhHHoUVDz3/4J7qk6W5Uv7SE8o0fTENoDpSq2MtPgmwZYqA2wHy/L2IKIDjHf6RcecZLthQJzT6aRApezS5mjkJ+q0t8R97EOanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2W33BsJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DcD6OLcc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2W33BsJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DcD6OLcc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LNuLH55aligHmXIA5M9Xm1sUCkIpJgG2Sby21sss9c=;
	b=w2W33BsJUJS/dCSdcvJHW+/2sBOtxSWq/QqSYTx41k78wencKdIeqxG2vPyVmjkTEfoNmd
	EL8ta+6uKvFeStVZLLBOW3NFkOoL5EQypb2CrWRR8VDndeD2QVeiYwRYorevMruH37Pk6b
	SSvKcawcUlg0SvPUza9u5pqCjqtmvoFoHO/cL21tiCKUohEUFz0K99teZXikHUs7MFu4rM
	wCMdBMsSbfhg3Oa1u1asLcIvBB33mVoVkLvHovSHzK/8pW9otDifzKBL1+n2zoXts77e2s
	SxMt8TE7QNNidwJCNtj7E36/88dyEBsmB9FNpvyXCX1Ysx+f8YDgT6KIlpsMAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LNuLH55aligHmXIA5M9Xm1sUCkIpJgG2Sby21sss9c=;
	b=DcD6OLccuaUeC4M6HErFfL0Ob42odcxrTLtX4wAuh1fPCdPFXg05skamATK/B5k2fRd0Mh
	2TCGwB35MVP0a5Cg==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 00/28] module: Use RCU instead of RCU-sched.
Date: Wed,  8 Jan 2025 10:04:29 +0100
Message-ID: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

This is an updated version of the initial post after PeterZ made me
aware that there are users outside of the module directory.
The goal is replace the mix auf rcu_read_lock(), rcu_read_lock_sched()
and preempt_disable() with just rcu_read_lock().

I've split it into smaller chunks which can be applied/ reviewed
independently.

v2=E2=80=A6v3: https://lore.kernel.org/all/20241220174731.514432-1-bigeasy@=
linutronix.de/
  - Converted cfi to use RCU.
  - Use scoped_guard() in LoongArch's ftrace code after Steven suggested
    it.

v1=E2=80=A6v2: https://lore.kernel.org/all/20241205215102.hRywUW2A@linutron=
ix.de/
  - Split into smaller patches.
  - Converted all users.

Sebastian Andrzej Siewior (28):
  module: Extend the preempt disabled section in
    dereference_symbol_descriptor().
  module: Begin to move from RCU-sched to RCU.
  module: Use proper RCU assignment in add_kallsyms().
  module: Use RCU in find_kallsyms_symbol().
  module: Use RCU in module_get_kallsym().
  module: Use RCU in find_module_all().
  module: Use RCU in __find_kallsyms_symbol_value().
  module: Use RCU in module_kallsyms_on_each_symbol().
  module: Remove module_assert_mutex_or_preempt() from
    try_add_tainted_module().
  module: Use RCU in find_symbol().
  module: Use RCU in __is_module_percpu_address().
  module: Allow __module_address() to be called from RCU section.
  module: Use RCU in search_module_extables().
  module: Use RCU in all users of __module_address().
  module: Use RCU in all users of __module_text_address().
  ARM: module: Use RCU in all users of __module_text_address().
  arm64: module: Use RCU in all users of __module_text_address().
  LoongArch/orc: Use RCU in all users of __module_address().
  LoongArch: ftrace: Use RCU in all users of __module_text_address().
  powerpc/ftrace: Use RCU in all users of __module_text_address().
  cfi: Use RCU while invoking __module_address().
  x86: Use RCU in all users of __module_address().
  jump_label: Use RCU in all users of __module_address().
  jump_label: Use RCU in all users of __module_text_address().
  bpf: Use RCU in all users of __module_text_address().
  kprobes: Use RCU in all users of __module_text_address().
  static_call: Use RCU in all users of __module_text_address().
  bug: Use RCU instead RCU-sched to protect module_bug_list.

 arch/arm/kernel/module-plts.c            |   4 +-
 arch/arm64/kernel/ftrace.c               |   7 +-
 arch/loongarch/kernel/ftrace_dyn.c       |   9 +-
 arch/loongarch/kernel/unwind_orc.c       |   4 +-
 arch/powerpc/kernel/trace/ftrace.c       |   6 +-
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   6 +-
 arch/x86/kernel/callthunks.c             |   3 +-
 arch/x86/kernel/unwind_orc.c             |   4 +-
 include/linux/kallsyms.h                 |   3 +-
 include/linux/module.h                   |   2 +-
 kernel/cfi.c                             |   5 +-
 kernel/jump_label.c                      |  31 ++++---
 kernel/kprobes.c                         |   4 +-
 kernel/livepatch/core.c                  |   4 +-
 kernel/module/internal.h                 |  11 ---
 kernel/module/kallsyms.c                 |  73 ++++++----------
 kernel/module/main.c                     | 103 ++++++++---------------
 kernel/module/tracking.c                 |   2 -
 kernel/module/tree_lookup.c              |   8 +-
 kernel/module/version.c                  |  14 +--
 kernel/static_call_inline.c              |  13 ++-
 kernel/trace/bpf_trace.c                 |  19 ++---
 kernel/trace/trace_kprobe.c              |   9 +-
 lib/bug.c                                |  22 ++---
 24 files changed, 136 insertions(+), 230 deletions(-)

Sebastian
