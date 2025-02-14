Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849F227BA3;
	Fri, 14 Feb 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522744; cv=none; b=Y6thfMcrOSDJBNw9mbkr6mKuGg+q1AdPaGUu6qN/IwfX4cjU6wp7sGzY/AHxm+KARWZTJWl3RbVCB54D7Icwj9cKCJtQxw6xezehdngX7B1wWBj5sDNnnceoPOoFms81CEumeUVUSME2LXIcigEamMK9nIZhwpfrmSftEsqpY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522744; c=relaxed/simple;
	bh=Jfc7H7jl7D+i12XJhv+Pu+5TzsvZiCzzGUULroEicnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fS5nZGOKME0kX8tQvsNq3CjgEhNrxsPR7hcX+ukYym0Ihz7bUszmAXOj79E6gCJEBgvnebejK+ss/DX02GwRSwauR4+dimx4w0NuzgzAmBE4HHXnqvAi9lOO07WiyO9fM0ithXXm1XKy5+AXfZ+FNMifoRDzgWhC9sJ/i2pryaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG9i7WlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG9i7WlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF82FC4CEE2;
	Fri, 14 Feb 2025 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522744;
	bh=Jfc7H7jl7D+i12XJhv+Pu+5TzsvZiCzzGUULroEicnM=;
	h=From:To:Cc:Subject:Date:From;
	b=WG9i7WlSjlGwi045U6qpWsp5mcx9fWTW1aW/EP293XnC2Z+VaU2q6Vb4JJbuN9/Nb
	 i9nZNvC2uMe6EgD6yarHr8XXEC82rokrRHsqG/bjtadI3cK+9t/uA3FOPjz8uU9taB
	 LSGZ9Prft1mwhgSDMZ3bl9y+rzcxVp3K6yPWfmNc5Myqe1GvUja6BIHNt38ffNYw6u
	 d7vCiGE+iH4b4IXHoG10TPCeXrs3jhKmzhIk9563oF10Z+8q2uhmImaHgH0aCrlV5T
	 g5nvT3N/qAb5NyInyqKWwOamTOvIPDiPIJQpFBsJC1We2ESTSKriU12t80wWh2O4Ct
	 ZWd7411qBTzlQ==
From: Mike Rapoport <rppt@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Mike Rapoport <rppt@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] module: don't annotate ROX memory as kmemleak_not_leak()
Date: Fri, 14 Feb 2025 10:45:31 +0200
Message-ID: <20250214084531.3299390-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The ROX memory allocations are part of a larger vmalloc allocation and
annotating them with kmemleak_not_leak() confuses kmemleak.

Skip kmemleak_not_leak() annotations for the ROX areas.

Fixes: c287c0723329 ("module: switch to execmem API for remapping as RW and restoring ROX")
Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

Peter, can you take it via tip tree?
Or you prefer for Luis to pick this up?

 kernel/module/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 974821d6e85a..3dbe23098433 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1250,7 +1250,8 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 * *do* eventually get freed, but let's just keep things simple
 	 * and avoid *any* false positives.
 	 */
-	kmemleak_not_leak(ptr);
+	if (!mod->mem[type].is_rox)
+		kmemleak_not_leak(ptr);
 
 	memset(ptr, 0, size);
 	mod->mem[type].base = ptr;
-- 
2.47.2

