Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3642D8796
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762210; cv=none; b=jpWuTBW0s4AITecMAOJK4dnekjSfJG57B2kzua2XgexLhj7usu1DDhYWiALenkbhuuSXX1RAw8A/H83bCfLP2FYNpYOUD6EGfHyJA5XdZoi35pxLWIL1HFZyV1isHP16ZairDnM+VSUyuz++nhEOTYrMrhBTzE5S+FGe8CQctdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762210; c=relaxed/simple;
	bh=iofJ836+YzEQs/Tw/w+NzYdOjwVMo/HxstvPWWekF3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prxjWWWIKPqJ/Csad5jBtx0pSlfCrFo6UC0j31yO0zLsliV8Cs70I+oo9smM0x9Jrd3fSudxsD9ZnD5rmwFvn66p96s6m9CXWCHKXDs2pLP4BcW4wUnG2dU7jrSHGdos5LXwyV9QoPrBGjJ6j58rCVFUkiZsy5b+luwzQywJ5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uMGh0f2W; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uMGh0f2W"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iofJ836+YzEQs/Tw/w+NzYdOjwVMo/HxstvPWWekF3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788762203; v=1; x=1789367003;
 b=uMGh0f2WjRvi+7c2dm1ojLoFPMoNsWa0niJcQQ221Rc2Ks7CDXfRVybC1DYCGuLpdHi4s6cK
 UkHtvMvXW2MbNjK02W0gfumZVnzkoSxCM3qevpirEo7EwSwzAJZa8sS807GU5mBmv2f8dabwgqs
 6GckXZOlbCcKDq5Df4cQfF3Y=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed2dd9e98d084ace;
	Mon, 07 Sep 2026 06:23:23 +0000
X-Mizu-Trace-ID: ed2dd9e98d084ace
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v8 0/4] alloc_tag and module codetag section fixes
Date: Mon,  7 Sep 2026 14:24:09 +0800
Message-Id: <20260907062414.106873-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I ran into an overflow problem in the module tag area. With profiling
toggled off, the overflow check in reserve_module_tags() did not
run, a module could load with more tags than the page flags can
address, and re-enabling profiling then silently corrupted
/proc/allocinfo. On overflow the fix shuts profiling down, releases
the reservation and returns -EAGAIN, and the codetag section lands
as regular module data in the same load, so the module loads without
profiling.

Review of the earlier series by Sashiko turned up two more problems.

One is a race. layout_sections() and move_module() both asked
codetag_needs_module_section() where a codetag section goes, and
mem_profiling_support can change between the two calls, for instance
when another module load overflows the tag index and shuts profiling
down. move_module() then copied the codetag section to offset 0 of
its regular destination and clobbered the first section placed in
that region.

v7 reworks where codetag sections are allocated, on a prototype by
Petr Pavlu [1]. The allocation runs before layout_sections() and the
placement is decided in one step, so nothing re-asks the question
and the race is gone. The retry is gone too, on -EAGAIN the section
is laid out as regular module data right in the same load.

[1] https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/

Following review feedback from Petr and Suren the series is now
split into four patches.

Patch 1 moves release_module_tags() above reserve_module_tags(),
since the failure paths now have to call it.

Patch 2 introduces SH_ENTSIZE_STANDALONE to mark sections with a
separate allocation, per the ELF spec SHF_ALLOC means a section
occupies memory during execution, and the percpu section does, only
outside the regular module layout. It was previously excluded from
the layout by clearing its SHF_ALLOC, overloading the flag with a
loader-internal meaning. The mark lives in sh_entsize now,
find_sec(".data..percpu") gives stable results again and
apply_relocations() goes back to testing only SHF_ALLOC. The
section becomes visible under /sys/module/*/sections/, reporting
the boot CPU instance of the per-cpu area, and the interface is
documented in the ABI docs.

Patch 3 moves the codetag allocation out of move_module() in front
of layout_sections(). On overflow reserve_module_tags() shuts
profiling down, releases the reservation and returns -EAGAIN, and
the section is laid out as regular module data, so the module loads
without profiling instead of failing. Any other error fails the
load. The release and the fallback belong together, without the
release rmmod hits the stale entry and panics.

Patch 4, split out per Suren's suggestion, releases the reservation
when vm_module_tags_populate() fails, so that path stops leaking on
its own.

Tested on an x86_64 virtual machine:

Booted without sysctl.vm.mem_profiling=1,compressed:
# cat /proc/allocinfo is fine

Booted with sysctl.vm.mem_profiling=1,compressed:
# cat /proc/allocinfo is fine
# insmod overflow_tag.ko
# dmesg
  With module overflow_tag there are too many tags to fit in 13 page
  flag bits. Memory allocation profiling is disabled!
# rmmod overflow_tag
The module loads without profiling and unloads cleanly.

Changes in v8:
- zero the separately allocated codetag memory for an SHT_NOBITS
  section, the tag area pages are not zeroed on allocation (Sashiko)
- .data..percpu is exported under /sys/module/*/sections/ with the
  boot CPU instance of the per-cpu area, and the interface is
  documented in the ABI docs (Petr Pavlu)
- keep a comment in apply_relocations() on how .data..percpu is
  relocated (Petr Pavlu)
- replace the "Based-on-a-patch-by:" tag with an in-body
  attribution and a numbered Link: (Andrew Morton)

Changes in v7:
- split the rework following review feedback (Petr Pavlu, Suren
  Baghdasaryan)
- new patch 2 marks separately allocated sections with
  SH_ENTSIZE_STANDALONE instead of clearing SHF_ALLOC
  (suggested by Petr Pavlu)
- split the populate failure release into its own patch (suggested
  by Suren Baghdasaryan)

Changes in v6:
- rework on Petr's prototype and allocate codetag sections before
  layout_sections(), the retry and its state resets are gone
- fix the layout_sections()/move_module() race (Found by Sashiko)
- release the reservation on populate failure as well (Found by
  Sashiko)
- only -EAGAIN keeps the fallback, other errors fail the load

Changes in v5:
- add Fixes: and Cc: stable to patch 1/2 as well, since 2/2 does not
  compile without it (Andrew Morton)
- restore frob-adjusted mem[type].size on retry instead of zeroing,
  as s390 and parisc add GOT/PLT space there in
  module_frob_arch_sections() (Reported by Sashiko)
- drop the load_module() mem_profiling_support check; the percpu
  counter leak is pre-existing and orthogonal to this fix

Changes in v4:
- add a new patch (1/2) to move release_module_tags() above
  reserve_module_tags(); the overflow fix is 2/2
- release the reservation on the -EAGAIN path
- return -EAGAIN instead of -ENOMEM so the module can still load
  without profiling (Suren)
- reset sh_addr, mem[type].size and sym/str SHF_ALLOC before retry
- skip percpu counters in load_module() when profiling is off

Changes in v3:
- use pr_warn_once() instead of pr_warn()
- return -ENOMEM instead of -ENOSPC (Suren)
- expand the commit message to describe the /proc/allocinfo impact
  (Andrew)

Changes in v2:
- return an error after shutdown_mem_profiling() to skip
  vm_module_tags_populate()

v1: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
v2: https://lore.kernel.org/all/20260804122038.190270-1-hao.ge@linux.dev/
v3: https://lore.kernel.org/all/20260805090633.141001-1-hao.ge@linux.dev/
v4: https://lore.kernel.org/all/20260810093955.153015-1-hao.ge@linux.dev/
v5: https://lore.kernel.org/all/20260812054105.102637-1-hao.ge@linux.dev/
v6: https://lore.kernel.org/all/20260831072104.120197-1-hao.ge@linux.dev/
v7: https://lore.kernel.org/all/20260902081802.146145-1-hao.ge@linux.dev/


Hao Ge (4):
  alloc_tag: move release_module_tags() above reserve_module_tags()
  module: introduce SH_ENTSIZE_STANDALONE for separately allocated
    sections
  module: allocate codetag sections before the regular module layout
  alloc_tag: release the reservation when populate fails

 Documentation/ABI/testing/sysfs-module |   8 ++
 include/linux/module.h                 |   2 +
 kernel/module/internal.h               |   8 ++
 kernel/module/kallsyms.c               |  13 +--
 kernel/module/main.c                   | 138 ++++++++++++++-----------
 mm/alloc_tag.c                         | 101 +++++++++---------
 6 files changed, 149 insertions(+), 121 deletions(-)

-- 
2.25.1

