Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BCA3C1094
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613641; cv=none; b=IpUfz4wFe6COqysxqinQv1MwB5blCUitJtJaFfTsfbsNWle4sGO+pZj8Rnd/EfnXcR2MKsgpI0oqMUGoHBaE7H/6fza/99L8Dm0LR+4M+lwHskw0l7fxoArdzKMrXHa6WRYJHR2hplQwplsWMLqRTL5ybXvu+dtCO3xbHuBD/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613641; c=relaxed/simple;
	bh=jNvhERYY3D7nKb/kjhXp0MERCjoO21xs9MSBXRaSNT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LBEVj4ht90qKuZ9Qjgy+ZnwSjnuAZRrAq0N2+UwBdSBkhKjJkz9bRKlM1Qw1iDevuMGF7whDg8KvoKWktlw9rHS3h8C9oOEucNEY6NjdV35LjR/aSS2Gi+8rWopjwSsG8jaDkHTYQ61G1Kex//S8YppkrzW3A3Mml6+3isyUz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IQBImNWf; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IQBImNWf"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jNvhERYY3D7nKb/kjhXp0MERCjoO21xs9MSBXRaSNT4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613637; v=1; x=1787218437;
 b=IQBImNWfFr6ozuuVC2ZVgZzs39gEF6LO5Pa1yKmx0U5xflvPbRiUUhbHwRxvc5M6xpbBgztM
 5wUNWYEBqtHQofMPfJWx7PheiAtro/za6ktpgOlfYajbEDIABM9xzQURdCdPZG8gVBUhfwDiILq
 ad7r9XQXZZBDSkxiZROm2B/E=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id a0f3be38e7db4446;
	Thu, 13 Aug 2026 09:33:57 +0000
X-Migadu-Flow: FLOW_OUT
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
Subject: [RFC PATCH 0/3] alloc_tag: fix races and a leak around shutdown_mem_profiling()
Date: Thu, 13 Aug 2026 17:34:18 +0800
Message-Id: <20260813093421.135230-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three fixes for races and a leak in how allocation profiling meets the
module loader, reported by sashiko.

  1. percpu counter leak on modules loaded after profiling is disabled.
  2. layout/move TOCTOU that can silently overwrite module memory when
     profiling disabled between layout_sections() and move_module().
     Additionally, the retry logic here depends on [1].
  3. AB-BA deadlock between module load and /proc/allocinfo readers.

Patch 1 adds CODETAG_MODULE_EXCLUDED so profiling-disabled modules are
dropped from the tag list instead of half-registered, and frees the
section reservation unconditionally on unload. Patch 2 makes
layout_sections() the sole authority for codetag placement. Patch 3
defers remove_proc_entry() to a workqueue.

Feedback and suggestions are warmly welcomed; I would greatly appreciate
any input.

Remaining sashiko-reported bugs will be fixed in follow-up patches.

[1]: https://lore.kernel.org/all/20260812054105.102637-3-hao.ge@linux.dev/

Hao Ge (3):
  alloc_tag: skip percpu counter allocation when profiling is disabled
  module: move codetag section placement decision to layout_sections()
  alloc_tag: remove /proc/allocinfo outside of mod_lock

 include/linux/codetag.h |  4 ++++
 include/linux/module.h  | 11 +++++++++++
 kernel/module/main.c    | 17 ++++++-----------
 lib/codetag.c           |  8 +++++---
 mm/alloc_tag.c          | 25 ++++++++++++++++++++++---
 5 files changed, 48 insertions(+), 17 deletions(-)

-- 
2.25.1

