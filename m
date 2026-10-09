Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18C4CCDCA;
	Fri,  9 Oct 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552711; cv=none; b=AK/I9YxLJlFW5W/wEX2NvrERyIZ5ur/yovoVcvMB+nheN/vceO+nXANJ30v9bQ7+5IYhj7ymjaJ6tfGHj+stCk66O2oerJWRcotJJ715K0pGDSuP1BRs5VTKCtNegU8Ah0g9Fqq/g/zr+2cdzqqao2xo0MhufB5n6ySupNW+h2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552711; c=relaxed/simple;
	bh=BdiJOYdLzKCHYvSvFbBWDvMEF+sjWSrcNKa5ko8H9c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8nGp497unXq/iUMccb9ujcOAmwZEnKqlPcLNwWRt/3vn0nwHvs4kd9MBO4gmH3s5tWX6xN5VXeHCpkIM9X9dGLhXFkxsUg4427tja5shbVB3wKge8inOqZ5StLU7zL/p6jDsG8u+DuHRt4iIf/2kGWR2Nhrvnte57vBK31Vono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NQBL1sAZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NQBL1sAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=39
	EabSGtVupsqYhL3Iw65lJvIT9W9JCD3Z4Wyg9CYhc=; b=NQBL1sAZCCYNRACZCk
	Qmwhhc635QgBTQCE8sDYsmwK5C5BHmg2DTuaWEFsh2d5M2B3Gir/ytaICA4CkXOI
	XJCU3WVR1U/EuhDxEDKO7hC67e/HzttvaG35MVIkb8QklqzquH3RsW5BtHzSVq2o
	FeTsWlRHHNuOMhnJEVm6IsqiI=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHtUSs7MhqF2KoDg--.49875S2;
	Fri, 09 Oct 2026 21:31:26 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH module v1] module: Fix uninitialized count read of unloaded taint tracking record
Date: Fri,  9 Oct 2026 21:31:22 +0800
Message-ID: <20261009133122.40664-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHtUSs7MhqF2KoDg--.49875S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw17tF43Ar4rGr45Kw1rJFb_yoW8Zw43pr
	W5JrW8Xrs8ArZ7Aa18Z3WUWry5G3y5AF4YgF98Gas3XrnFqrsF9ayFqF1Y9a4F9ryj93W5
	tF4I9w13GFyDXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsZ2hUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+w4zF2rI7K70mwAA3e

try_add_tainted_module() allocates the tracking record without zeroing
it and initializes the fields in this order:

	mod_taint = kmalloc_obj(*mod_taint);
	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
	mod_taint->taints = mod->taints;
	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
	mod_taint->count = 1;

The record is published by list_add_rcu() before the count field is
written.  The readers, unloaded_tainted_modules_seq_show() (debugfs,
under rcu_read_lock()) and print_unloaded_tainted_modules() (panic
path, under guard(rcu)), traverse the list under RCU and read
mod_taint->count.  module_mutex, which the writer holds, does not
exclude RCU readers.

A reader that observes the new node between the list_add_rcu() and
the count store reads an uninitialized u64 left over from previous
slab use.  This is a data race and leaks kernel heap residue through
the debugfs file and the panic message.

The race window is two adjacent instructions; it is reachable when a
tainted module is unloaded (rmmod) concurrently with a read of
/sys/kernel/debug/module/unloaded_tainted, or with the module list
printout of an oops on another CPU.

Fix this by initializing count before the record is published.

Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 kernel/module/tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 9033ff54c4e2..9e8902600c32 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -38,8 +38,8 @@ int try_add_tainted_module(struct module *mod)
 		return -ENOMEM;
 	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
 	mod_taint->taints = mod->taints;
-	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
 	mod_taint->count = 1;
+	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
 out:
 	return 0;
 }
-- 
2.43.0

