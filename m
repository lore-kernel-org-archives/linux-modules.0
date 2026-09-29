Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440E3B19B6
	for <linux-modules@vger.kernel.org>; Tue, 29 Sep 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669976; cv=none; b=N4CdjXF1Bvq/JRH9LG2pytJaJNIa756OUha+d2rCHhpAeJ90uqtVxFX2KTdrthl6ItnbIEC24l5efgcBq2Bq7XVkce4XfA8SvgDIV3jXHwoajSox4Yp6866WsSGFXzkwUFLXe37kbeOKLj2hxZugpCOXB2pdvjut8E4h+0GyC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669976; c=relaxed/simple;
	bh=k6FOq8X8FbjxI404guB6fTZveypsixaCcmX0PMkNLA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i0QLukIyvcCEaTgRPhHYK4EhYQv7gtzRJJJu/jTQxje/LCS7RVRkLi7nvRrzJv6i6bBqa7Zy7Vi0cM5/1qDTxE4hw7u7kv6OExjoLle0TSYlvUMnzy1MIrb1DSsjy9S5lHYOCEO6Xr1KwfYg8l694dvW9wPvzJoIxHOhegPK/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4wwXDmF; arc=none smtp.client-ip=95.215.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4wwXDmF"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k6FOq8X8FbjxI404guB6fTZveypsixaCcmX0PMkNLA8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790669970; v=1; x=1791274770;
 b=o4wwXDmFMY11woSsszqjC8qE4ilBo2e+p7EmdYSzRWA6mpds+ehEy0/Oes9tyIBv3GHiQvyV
 OHmY9ZWBFWi6mfIK/4EH3tcCoI/2YrXPi4HnieW7f6IqryA3ecswwJ9gAZnECd3uKk/gniD/Ase
 qPBDep4z8QRjpzkZ2qutXM98=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 323ae503de3222bc;
	Tue, 29 Sep 2026 08:19:30 +0000
X-Mizu-Trace-ID: 323ae503de3222bc
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	=Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v11 0/7] alloc_tag and module codetag section fixes
Date: Tue, 29 Sep 2026 16:20:07 +0800
Message-Id: <20260929082014.160587-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With profiling toggled off, the overflow check in
reserve_module_tags() did not run, a module could load with more
tags than the page flags can address, and re-enabling profiling
then silently corrupted /proc/allocinfo. On overflow the fix shuts
profiling down, releases the reservation and returns -EAGAIN, and
the codetag section lands as regular module data in the same load,
so the module loads without profiling.

Review of the earlier series by Sashiko turned up more problems.

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

Patch 1 moves release_module_tags() above reserve_module_tags(),
since the failure paths now have to call it.

Patch 2 is new. __vmap_pages_range_noflush() and friends leave the
PTEs they installed when they fail, and the callers do not agree on
who cleans them up. Per the discussion with Suren and Ulad [2] each
mapping function now undoes its own partial work, the __GFP_NOFAIL
retry loop in __vmalloc_area_node() and pci_remap_iospace() stop
tripping over the leftovers of a previous attempt, and
vm_module_tags_populate() no longer needs its own undo, patch 3
drops it.

[2] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/

Patch 3 cleans up the populate failure path: the reservation is
released and module_tags.size rolled back, so a concurrent load
which already passed needs_section_mem() does not skip populate for
the freed gap. The PTEs a failed vmap_pages_range() left behind are
undone by patch 2 now. It carries both Fixes tags so it backports
wherever patch 5 goes, which uses its prev_size.

Patch 4 introduces SH_ENTSIZE_STANDALONE to mark sections with a
separate allocation. The percpu section was previously excluded
from the layout by clearing its SHF_ALLOC, which per the ELF spec
says the section occupies memory during execution, and percpu does,
only outside the regular module layout. The mark lives in sh_entsize
now, find_sec(".data..percpu") gives stable results again and
apply_relocations() goes back to testing only SHF_ALLOC. The
section would show up under /sys/module/*/sections/, but it has one
instance per CPU and no single address, and the entry never
existed, so add_sect_attrs() and add_notes_attrs() skip it.

Patch 5 moves the codetag allocation out of move_module() in front
of layout_sections(), so the placement is decided in one step and
the race is gone. On overflow profiling is shut down, the
reservation released, module_tags.size rolled back and -EAGAIN
returned, the section is laid out as regular module data and the
module loads without profiling instead of failing. Any other error
fails the load. The release and the fallback belong together,
without the release rmmod hits the stale entry and panics.

Patch 6 skips the percpu counter allocation when profiling is off.
After the shutdown modules load their codetag section as regular
data, load_module() still allocated counters for every tag and
release_module_tags() cannot find them on unload, so they leaked
(Suggested by Suren).

Patch 7 fixes the /proc/allocinfo lifecycle. shutdown_mem_profiling()
runs under mod_lock, and the synchronous remove_proc_entry()
deadlocks with a reader taking mod_lock for read in
allocinfo_start(), so the removal goes to a workqueue. The file is
created at the end of alloc_tag_init(), a leftover file after a
failed init would panic its readers (Found by Sashiko). When
proc_create() itself fails the codetag type and the module tags
memory are released with the new codetag_unregister_type(), and the
lockless alloc_tag_cttype reader in alloc_tag_top_users() is
guarded with RCU.

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

Also ran continuous LTP stress for a few days, nothing abnormal
so far.

Changes in v11:
- new patch 2 makes the vmap functions undo their partial mappings
  on failure, per the discussion with Suren and Ulad [2]; patch 3
  drops its own vmap undo accordingly
- patch 7 is renamed to "fix the /proc/allocinfo lifecycle", it now
  also unwinds the codetag type with the new codetag_unregister_type()
  when proc_create() fails and guards the lockless alloc_tag_cttype
  reader in alloc_tag_top_users() with RCU
- collected Reviewed-by tags from Suren Baghdasaryan (patches 4, 5)

Changes in v10:
- fold in the two alloc_tag fixes from
  https://lore.kernel.org/all/20260817062726.106511-1-hao.ge@linux.dev/
  as patches 5 and 6, they replace the versions in the mm tree and
  fix the percpu leak Sashiko keeps flagging
  https://lore.kernel.org/all/20260908094736.2B1A61F00A3A@smtp.kernel.org/
- create /proc/allocinfo at the end of alloc_tag_init(), a
  leftover file after a failed init would panic its readers
  (Found by Sashiko)
- count note sections with sect_visible() in add_notes_attrs() too,
  the count has to match the fill loop

Changes in v9:
- do not export .data..percpu under /sys/module/*/sections/ (Petr
  Pavlu).
- move the populate failure cleanup in front of the rework, v8 patch
  4 is patch 2 now. It declares prev_size itself, which the overflow
  path of the rework also uses, so it carries both Fixes tags and the
  two patches backport together

Changes in v8:
- roll back module_tags.size when the reservation is released, so a
  concurrent load which already passed needs_section_mem() does not
  skip populate for the freed gap (Sashiko)
- unmap the PTEs a failed vmap_pages_range() installed, a retry to
  populate the same range would BUG on them
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
v8: https://lore.kernel.org/all/20260907062414.106873-1-hao.ge@linux.dev/
v9: https://lore.kernel.org/all/20260908092412.115953-1-hao.ge@linux.dev/
v10: https://lore.kernel.org/all/20260915070001.113559-1-hao.ge@linux.dev/

Hao Ge (7):
  alloc_tag: move release_module_tags() above reserve_module_tags()
  mm/vmalloc: undo partial mappings inside the mapping functions
  alloc_tag: clean up the populate failure path
  module: introduce SH_ENTSIZE_STANDALONE for separately allocated
    sections
  module: allocate codetag sections before the regular module layout
  alloc_tag: skip percpu counter allocation when profiling is disabled
  alloc_tag: fix the /proc/allocinfo lifecycle

 include/linux/alloc_tag.h |   2 +-
 include/linux/codetag.h   |   2 +
 include/linux/module.h    |   2 +
 kernel/module/internal.h  |   8 ++
 kernel/module/kallsyms.c  |  13 +---
 kernel/module/main.c      | 133 ++++++++++++++++---------------
 kernel/module/sysfs.c     |  17 +++-
 lib/codetag.c             |  36 ++++++++-
 mm/alloc_tag.c            | 160 ++++++++++++++++++++++----------------
 mm/kmsan/shadow.c         |   4 +
 mm/show_mem.c             |   2 +-
 mm/vmalloc.c              |  31 +++++++-
 12 files changed, 263 insertions(+), 147 deletions(-)

-- 
2.25.1

