Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3601FB1;
	Sun, 21 Jun 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782033881; cv=none; b=sPZArFHTINnIHSZUAIbiBpiqhGMiSAaeqdZxxTRFOsogw08AsHsSsygfiis3yfsKiiHWD4WbSn0nTV+bnN6z48d4mXn5FyLNifuTlCZDXaY6ax1b2AGGCn5DcfOLIK2pDME0Bi20OitHTaYH8nYW7pTn/gYQEYqYsASiuVnSpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782033881; c=relaxed/simple;
	bh=v2tM3DiGb2IOSN/GEuMVCwJrzWhMuA1pi6P5MJ0Spq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARC3ZmbaV+AOd/wX1JP3Rz1dOAtzbYnY4Z7uPmyawCybJ7z4iWNxDXZGZK/NHw6O8InT3pQoGEGKcUo0Cy30N8onKUbCZAgap0HGLL4zlZ/UiV8flxTxpDKGibnA9NmmWI0a3lZugLGINNIrAAlKHWCjNmZ3Fghem/FGqqAgVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=lR1ZyEXt; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="lR1ZyEXt"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4324d7652;
	Sun, 21 Jun 2026 17:19:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: mcgrof@kernel.org
Cc: petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH] module: annotate failed-module stats list traversal
Date: Sun, 21 Jun 2026 17:19:05 +0800
Message-Id: <20260621091905.3555074-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee97a434f03a1kunm5970f65011c425
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTR1KVh5OSk9MHUlJSksYQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=lR1ZyEXtT2aGJDJMhYlnIcnAreUb1AfPppiUo9IJr9u4ZEc7do+kaoJ4lYIuaxlr/u6yWR60nyGuYa1nmc6sLiuE02G1awqo2JlPacDBDoNo40rc+6QPs9TWle2cdu2g4aFbnwTla7Gc7OjuKeOAjcIZ5zA66EoHEfHCgxg9feE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=vH/FPjRiOjSC3aqZ1dHTDnuT/XrYbYtPcR0KJ0CoXPY=;
	h=date:mime-version:subject:message-id:from;

read_file_mod_stats() dumps dup_failed_modules while holding
module_mutex, but the loop uses list_for_each_entry_rcu() without
telling lockdep about that non-RCU protection.

The same list is already traversed in try_add_failed_module() with
lockdep_is_held(&module_mutex) as the RCU-list lockdep condition. Use
the same condition for the debugfs stats dump so CONFIG_PROVE_RCU_LIST
can see the documented protection.

This was found by our static analysis tool and then manually reviewed
against the current tree. The dynamic triage evidence is a
target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
to documenting the existing protection contract.

This is a lockdep annotation cleanup. It does not change the list
lifetime or serialization rules.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 kernel/module/stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index 3ba0e98b3c91..79c227a72a21 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -382,7 +382,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	mutex_lock(&module_mutex);
 
 
-	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
+	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
+				lockdep_is_held(&module_mutex)) {
 		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
 			goto out_unlock;
 		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,
-- 
2.34.1

