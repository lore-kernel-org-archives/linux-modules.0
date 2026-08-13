Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389527F017
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613660; cv=none; b=nwnLquUW15SuHS/DRV2ugq99/Fv7VUS56FHwgkwOIfKXL8A4sPnYlQl2YVK9EDF2ybQVRMAr3E6pEys3j6wMcCrQ8UxFrJiYQi7lj9wcfh+bV/Ib4+rUMbvK0QkoCSUy9zRVttGz6LH5lByPmS1qiguqEfIo5r8Cr+itE8p0S0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613660; c=relaxed/simple;
	bh=hPN6+ldNa92yVfg5JXt1vgfrSMYfaiItc5ke6iFo9is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiKgoiwhIxd/brzQ0NTWGjBpEH9khRaNryF0pukpC6uWb3jsumpzh8gfpPyZwp/ME4Qr17wBS5SIxCaudgrhrd13/h6LpEMACPoLjxORUOnNJsX11mMOtNakA/8vrCED02R1xBewP6tvT6i2RKXbRXCvrbdFsDeMyt/uydS5Low=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ve/BuX7Y; arc=none smtp.client-ip=91.218.175.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ve/BuX7Y"
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hPN6+ldNa92yVfg5JXt1vgfrSMYfaiItc5ke6iFo9is=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613655; v=1; x=1787218455;
 b=Ve/BuX7YWVqBo/ABZYgyXwpdHXANW8oh1K46WtEot5WlWwmlYaJrvYjXQhvPqtcxqNv57CDf
 J3fVIefYJeNAyVzqJeKfPvoOncCJ+do2gCvzPN3p5/YS+zYWDfd1LnSSeOla5eG+PQtsyl95qRp
 iuKV9mdSoApubKNnmXlRU5JM=
X-Envelope-To: linux-modules@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by smtp.migadu.com with ESMTPS id 20da645f262052b9;
	Thu, 13 Aug 2026 09:34:15 +0000
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
Subject: [RFC PATCH 3/3] alloc_tag: remove /proc/allocinfo outside of mod_lock
Date: Thu, 13 Aug 2026 17:34:21 +0800
Message-Id: <20260813093421.135230-4-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093421.135230-1-hao.ge@linux.dev>
References: <20260813093421.135230-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

shutdown_mem_profiling() calls remove_proc_entry() from
reserve_module_tags(), which runs under mod_lock held for write.
remove_proc_entry() waits for readers, and a reader takes mod_lock for
read in allocinfo_start():

  CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
  ----------------                   ----------------------------
  reserve_module_tags()
    down_write(&mod_lock)  [held]
                                     use_pde()            [in_use++]
                                     allocinfo_start()
                                       down_read(&mod_lock)  <- blocks
    shutdown_mem_profiling()
      remove_proc_entry()
        wait for in_use == 0         <- blocks

Move remove_proc_entry() to a workqueue.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 7481180dadd2..b80f5a151f28 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -591,6 +591,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 	put_page_tag_ref(handle_new);
 }
 
+static void remove_allocinfo_file(struct work_struct *work)
+{
+	remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
+}
+
+static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
+
 static void shutdown_mem_profiling(bool remove_file)
 {
 	if (mem_alloc_profiling_enabled())
@@ -600,7 +607,7 @@ static void shutdown_mem_profiling(bool remove_file)
 		return;
 
 	if (remove_file)
-		remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
+		schedule_work(&remove_allocinfo_work);
 	mem_profiling_support = false;
 }
 
-- 
2.25.1

