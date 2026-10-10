Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01B3195FE;
	Sat, 10 Oct 2026 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619474; cv=none; b=jySFDHqoKHWnslStx6P7WsPOqX+dkZ/13hCwS3jTDQbOpFQ5yOQUf8K8uHM2HGUaf3hePQ2cUq4TBOXQ54xxV7Rez7xVUFQlu5P4w3xjRQ5cpeADGjuSJzsGbz88XhDu2Wmzbs7YbLymlPXw8T5MGqsSfToe/TzhDF+VKDk/rN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619474; c=relaxed/simple;
	bh=FOCnO8A2EDjQBoj+wu1pSmCIH57OkwFfDi0QKGtaBWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8HoTy5CJ4NPeKxqD458yOaPTkLReKWxyk9fFv50iVYoVoV8/R46GUTpiZHSWU/LYEQfGxTIZ536g7AfqE3SuCHVSgSf9q28puhX+wPEMhimJ9ZpNqMrldPhU3sJJ4mnW+r/cCzFeul9WePGaJD1M87CdznNPZZHWaVOkPiQ1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GFrL7Oix; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GFrL7Oix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kb
	o772QCvVvwyXS3sX1OmHqoYdmeSvUBrSBmlEGOwEY=; b=GFrL7OixgNhhz4/p8Y
	D7B5S065c0gKE6i/U++F2db9QFdBAmoWHi2MweBx5VnBUIzhIogB+HE55FvAvagF
	UmM0oPM8YRYJ7E9tNzEDV3wca3gWcOAxliz2RXdp5TaM8JMBeHLA+HyZ4OlkUvX/
	+77rCEER8TLnHE6GfjIEdqh8Y=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Arpu8clq9V6LDg--.26020S2;
	Sat, 10 Oct 2026 16:03:58 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH module v2] module: Fix uninitialized count read of unloaded taint tracking record
Date: Sat, 10 Oct 2026 16:03:56 +0800
Message-ID: <20261010080356.6596-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Arpu8clq9V6LDg--.26020S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw17tF43Ar4rGr45Kw1rJFb_yoW8Kry7pr
	W5JrWDXrs8ArZ7Aay8Z3W5W345JrW5AF4YgF98Ga4fZrnFqFsFkaySqF1Y9a4F9ryY93WU
	tF4I9w13GFyDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc0eXUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC4A6kiGrJ8W6epwAA3H

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

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

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

