Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E22253A1
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513260; cv=none; b=a2c5eSHFSJRlL5WnSSD1+U/hZ6qWpaJxrxRFfHlV9VudRkwUOIpe1x+BkOs7biRrCCTozkikdIQ5RJGHh1bC4BAW79VPp8Vbhfepyeg42CxxSsdFgXiUVAShsIyXK3aLajQOvRupXUvaNVNavFu0YkvEXkB5wUPy4DIYOiRvpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513260; c=relaxed/simple;
	bh=fSfD7lk/8EGGpmraRb4osxC6XMQsZA99FFJiZWRt+jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qm4b/CsdDszQ4w5eTqGJXFlFk//l3RandvcKIBnLR30V6x0hzjMISGQm4aUcwCb8t40h+54ItjX1D4gRA+Gvr9s/axrVx8inik3P3xT8uGBuFBgpnH8isFZEo80yXNB9nO3ZTr+YuBrFdNWd1OZNxaJMulBCaI4drwsm4/Ni070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5pWdTs6; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5pWdTs6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgUVbxAMqq9eyDnj3cSJELw1GrjSzVkJC09UC840utI=;
	b=I5pWdTs6iR44KCPchZFhbtaRPzzGzUHmQ//szAGW4Se8CL4a2SKesOe+A7bcEfGxIPpkB1
	0r1Clyvu8DuLDvuA0qO63HmxVfA5FtapuDd8Uod6UMd0p8Hmw+Lp8thxh4EpZpEllPNgZp
	h+4EntL4Ely3UAj0m0O0CEb0RIcYBCY=
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v5 0/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Wed, 12 Aug 2026 13:41:03 +0800
Message-Id: <20260812054105.102637-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v3 was a single patch. After discussion with Suren and Andrew we went
for a more graceful approach: rather than failing the module load on
overflow, let it load without profiling. Once profiling is disabled,
codetag_needs_module_section() returns false, so on retry the codetag
section is placed as regular module data.

A new patch (1/2) is added to move release_module_tags() above
reserve_module_tags(), since the overflow path now has to call it and
the helper sits below it.

release_module_tags() is what module unload calls to drop a module's
reservation from the maple tree. By the time reserve_module_tags()
detects the overflow it has already stored that reservation, and the
-EAGAIN return skips vm_module_tags_populate(), so the backing pages
never get mapped. If reserve_module_tags() returns without calling
release_module_tags(), the stale entry keeps pointing at that unmapped
range; when the module is later unloaded, release_module_tags() walks
it and panics.

Tested on an x86_64 virtual machine:

# insmod overflow_tag.ko
# dmesg
  With module overflow_tag there are too many tags to fit in 13 page
  flag bits. Memory allocation profiling is disabled!
# rmmod overflow_tag
The module loads without profiling.

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

Hao Ge (2):
  alloc_tag: move release_module_tags() above reserve_module_tags()
  alloc_tag: fix undetected compressed tag overflow when profiling is
    disabled

 kernel/module/main.c |  25 ++++++++++-
 mm/alloc_tag.c       | 100 ++++++++++++++++++++++---------------------
 2 files changed, 74 insertions(+), 51 deletions(-)

--
2.25.1
