Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9563B05AD
	for <linux-modules@vger.kernel.org>; Mon, 10 Aug 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354782; cv=none; b=RrbA4lKnYaluZtE4S1/EQ8uIga9ibVv/RX77H01wDvTdE/rFuJNqmqjOTzist7XJs8Bsk6lC3akSNhpy1T2Ihudg/aJrbxOc0GNI4cw8ARC5zappN0Pav7Pq2/RWO8iNNN5NZ/WXOuz3Vj9+XHGLcyn0i7t7IMLVaAvudPaCOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354782; c=relaxed/simple;
	bh=UIktgvsGULxryLMUxmq1Oes31GkwUNqAwQdlsQG+ahw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QT3mLXoYA8bUXgbjzUUe8dguogmDnvLpk30f1yncO7RcEiNxt04NA94Iqk+POkq6rPkO0oUm8hBad21N3IN2oWGHq+fyIxaSkMvzYSJbkXfJiuyaIjMEJAQ+zBYN7DOdw5178orJWcoVsnB9ti2hBhU9Cd5CHzlhMt/ujZbPBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/LHeJ+F; arc=none smtp.client-ip=95.215.58.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/LHeJ+F"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UIktgvsGULxryLMUxmq1Oes31GkwUNqAwQdlsQG+ahw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786354778; v=1; x=1786959578;
 b=v/LHeJ+FAcVLjiBlrRxpk9Zjf7fecqpX2/ZyQ1gVvYUJZF/tZRbWiPHmtEAFG4Gl3Ws30Z5b
 ivQmKPZxTtYo8Hy+albAC5x1ibfoVY9sZGHywNE+QI6vOdyqEpu9LIZUglycLuKtyS4pLnp6+ds
 C+YsLVjMVb6ZpQFvy22idnFs=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by mta10.migadu.com with ESMTPS id fd542074912682a9;
	Mon, 10 Aug 2026 09:39:37 +0000
Authentication-Results: mta10.migadu.com;
	none
X-Migadu-Scanner: mta10.migadu.com
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
Subject: [PATCH v4 0/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Mon, 10 Aug 2026 17:39:53 +0800
Message-Id: <20260810093955.153015-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Hao Ge (2):
  alloc_tag: move release_module_tags() above reserve_module_tags()
  alloc_tag: fix undetected compressed tag overflow when profiling is
    disabled

 kernel/module/main.c |  17 ++++++++-
 mm/alloc_tag.c       | 103 +++++++++++++++++++++++++++------------------------
 2 files changed, 69 insertions(+), 51 deletions(-)

-- 
2.25.1
