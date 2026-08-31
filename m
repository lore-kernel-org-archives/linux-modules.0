Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D63C455F
	for <linux-modules@vger.kernel.org>; Mon, 31 Aug 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160831; cv=none; b=obfAZgzXcDJ+L6nPnuQNGEwcSSWLcE3T+fyHMl99uM2hw48eJBrGGK3I1y2Pg4BcJkQA+5Ip8iHtj6PGsviIKAUlMblIb0gTqqMEUP3pMYqPXdRoRY/EE1eQaUIbvlWc5s3oFs6GyCo7IsngIe4bbBRmV0xZiD2hF3dj0cfe4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160831; c=relaxed/simple;
	bh=4GoxWCfkfkA1qVExNzXFVAHedHhniK9X4/GsP5Em1EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J3QB6+ZunZcLbpInNTGZALmEuCyE6Np7/H9j37DQdjM7SxxyEemkhrWT3VtLBhUW432V3mH1VW6/5lUoynbet8gEdBcF67RpVydvjMf17L7cXwU9BaQ49Y3CRIUQZ0bNfbknsRQNfmKShX9Q+9OPl/uoGB+S4GiWFrQHrZCC0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdyUrGC7; arc=none smtp.client-ip=95.215.58.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdyUrGC7"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4GoxWCfkfkA1qVExNzXFVAHedHhniK9X4/GsP5Em1EE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788160825; v=1; x=1788765625;
 b=KdyUrGC7sEY3TvAOaWyKJCU1WQHBe+5hAT8shzxJDsDxiZlYuXWQLajZ+YteswLlKpPaBssA
 4vZMiXvhebZ1iLaI9/X1X5MMKqXiWu+97o8fEMRAPfF0pFmQ7AJh087D5cGNLPvJUvuSwVpxSpa
 TEnBCW+W+dRUOBHaTFvKXshM=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 609db7b0453cb9d2;
	Mon, 31 Aug 2026 07:20:24 +0000
X-Mizu-Trace-ID: 609db7b0453cb9d2
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [RFC PATCH v6 0/2] module: allocate codetag sections before the regular module layout
Date: Mon, 31 Aug 2026 15:21:02 +0800
Message-Id: <20260831072104.120197-1-hao.ge@linux.dev>
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
/proc/allocinfo. After discussion with Suren and Andrew the fix went
for a graceful approach: on overflow shut profiling down, release the
reservation and return -EAGAIN, and retry the load with profiling
disabled, so the codetag section lands as regular module data and
the module loads without profiling.

Review of that series by Sashiko turned up two more problems.

One is a race. layout_sections() and move_module() both asked
codetag_needs_module_section() where a codetag section goes, and
mem_profiling_support can change between the two calls, for instance
when another module load overflows the tag index and shuts profiling
down. move_module() then copies the codetag section to offset 0 of
its regular destination and clobbers the first section placed in
that region.

The other is a maple tree entry leak. The failure paths of
reserve_module_tags() return with the reservation still stored, and
a failed load never unloads the module, so nothing releases it.

v6 fixes both by reworking where codetag sections are allocated, on
a prototype by Petr Pavlu [1]. The allocation now runs before
layout_sections() and the placement is decided in one step, so
nothing re-asks the question and the race is gone. The retry is gone
too, on -EAGAIN the section is laid out as regular module data right
in the same load, and both failure paths release the reservation.

[1] https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/

Sending this as an RFC since 2/2 is a rework of Petr's prototype and
the approach changed quite a bit from v5, feedback on the direction
would be welcome.

Patch 1 moves release_module_tags() above reserve_module_tags(),
since the overflow path now has to call it and the helper sits below
it.

Patch 2 moves the codetag allocation out of move_module() in front
of layout_sections(). On overflow reserve_module_tags() shuts
profiling down, releases the reservation and returns -EAGAIN, and
the section is laid out as regular module data, so the module loads
without profiling instead of failing. Any other error fails the
load.

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

Changes in v6:
- rework 2/2 on Petr's prototype and allocate codetag sections
  before layout_sections(), the retry and its state resets are gone
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

Hao Ge (2):
  alloc_tag: move release_module_tags() above reserve_module_tags()
  module: allocate codetag sections before the regular module layout

 include/linux/module.h   |   2 +
 kernel/module/internal.h |   4 ++
 kernel/module/main.c     | 120 ++++++++++++++++++++-------------------
 mm/alloc_tag.c           | 101 ++++++++++++++++----------------
 4 files changed, 121 insertions(+), 106 deletions(-)

-- 
2.25.1

