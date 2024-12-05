Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43622B8A2;
	Thu,  5 Dec 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428002; cv=none; b=HdgZt/k/ke/KgmoV5OboSOCogsg24tZBx86qKEb9oRpr9BLpmsXWEttLwuXb5JaBdu+fYX3BqTqIA2YZCeAbNzkzbR90y2Okze9dVDxK3zhliup3huW0FB3JCAGUvJ6hMq/BG/JlTPZkW9eMV/PMyMRgRQY6UW5oeHiUbxjB2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428002; c=relaxed/simple;
	bh=+a76SSSyXo/Z4P5dmmrzicA4u00ZpV3dbYc40THbTmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X40SbjqgnAIPiPMm5zDj3qZ/QVfzDBZpGomPY5t5D+BPgcmSUmxrnocLrOhwRAGggstXCJvr5rYRVF0XkTtIWSjApUBDwsZu0QyRnkE7M4K1mxq9IHgm1gQs55fKLhxhnkqwTHO9J5wXncGxNv2urIJLS5qxhLb+zmb6IzVtDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y44dX6p4Yz9svg;
	Thu,  5 Dec 2024 20:46:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAf4glO79EIQ; Thu,  5 Dec 2024 20:46:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y44dT5kV4z9svk;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B52DE8B763;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Ox0P3sLaevPw; Thu,  5 Dec 2024 20:46:21 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 44CD28B770;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1 3/3] module: pre-test setting ro_after_init data read-only
Date: Thu,  5 Dec 2024 20:46:17 +0100
Message-ID: <84c4caf2fbb71fa1699ee24d5b6df548d7f3bb08.1733427536.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733427536.git.christophe.leroy@csgroup.eu>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733427977; l=2430; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=+a76SSSyXo/Z4P5dmmrzicA4u00ZpV3dbYc40THbTmM=; b=EUWw73At6FPbHZpOKK8cpi+ddGAVKTmAOhVh3Lnrz05hNjyyy9LkMf8TWyBFKZHwZKoYqO3qX EYQLNVthm0ECcsJczhvY3ZYtcds0BdzIz+9mS14OBVvwYasfJnmgLQX
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To be on the safe side, try to set ro_after_init data section readonly
at the same time as rodata. If it fails it will likely fail again
later so let's cancel module loading while we still can do it.
If it doesn't fail, put it back to read-write, continue module loading
and cross fingers so that it still works after module init.

In practice, if it worked once it will work twice:
- On some architecture like powerpc it works on some memory areas and
works on others. If you apply it several times to the same area, either
it always works or it always fails
- On some architecture like ARM, that may apply splitting big pages
into smaller ones, that is what can fails, but once it successed the
pages will remain split so there's no reason to fail on pass two if it
worked on pass one.

Then it should in principle never fail so add a WARN_ON_ONCE() to get
a big fat warning in case it happens anyway. For systems that sets
panic-on-warn, such systems usely care about security and don't want
vulnerable systems, so an implied panic is worth it in that case.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v1: Expanded the commit message based on feedback from RFC series
---
 kernel/module/main.c       | 2 +-
 kernel/module/strict_rwx.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5f922e563fc3..634a4a2aaf8c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2674,7 +2674,7 @@ static noinline int do_init_module(struct module *mod)
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
-	if (ret)
+	if (WARN_ON_ONCE(ret))
 		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
 			"ro_after_init data might still be writable\n",
 			mod->name, ret);
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 74834ba15615..1434c48c52ab 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -61,7 +61,10 @@ int module_enable_rodata_ro(const struct module *mod)
 	if (ret)
 		return ret;
 
-	return 0;
+	ret = module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
+	if (ret)
+		return ret;
+	return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_rw);
 }
 
 int module_enable_rodata_ro_after_init(const struct module *mod)
-- 
2.47.0

