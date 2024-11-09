Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD04EB38;
	Sat,  9 Nov 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148559; cv=none; b=NdsEGVSK2C5U5GO45Az8dWNtX+YnYakDBfZFDSbjJjFK3Crs/IEeAiKTJ3i/xrmRcrnNipwMC3gW1RuIggXqLPvv+KteURjUdm9SZaRs5CkyOMwy3L8gvSmwsECpbaNVACeFbJglBu7CiBS7M9rOAIh/oQbxZ/mB2DJ8n2uwQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148559; c=relaxed/simple;
	bh=+0JA3VREL+CP75q52bwUhSocLz0H9J80XdmFDi/uuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHqYF3oGzHHPfB2hraWqes/FU6bGjkPrYFXWhUias+7JyEMyddZcuEIagq+PETkZQaOOXjywP4NDSG57z281Qo+CYANB10C0Dr6BHjHKuzSln+LXyK+FCQWgLeoLpSmp8IEma1Eno8T0w1IJlGNUrGds+M84KhmpCoyXpBzc1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlsfG4FvVz9sSK;
	Sat,  9 Nov 2024 11:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmPlaWsk7gR4; Sat,  9 Nov 2024 11:35:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlsfC5CByz9sSN;
	Sat,  9 Nov 2024 11:35:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A0E958B764;
	Sat,  9 Nov 2024 11:35:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qn5FBAAisxfx; Sat,  9 Nov 2024 11:35:47 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.57])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3202A8B766;
	Sat,  9 Nov 2024 11:35:47 +0100 (CET)
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
Subject: [RFC PATCH 3/3] module: pre-test setting ro_after_init data read-only
Date: Sat,  9 Nov 2024 11:35:37 +0100
Message-ID: <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731148536; l=1703; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=+0JA3VREL+CP75q52bwUhSocLz0H9J80XdmFDi/uuF8=; b=rA59hj9bUGX0f12Cvp96RyTYI3g4ko1UQG50/59qdgEAWjDifJH3wf0QdI6jQrbbEt45+GTk9 IuVbBTm+60CCw29mxZviRiHVSWDKw0IwTiLlOywwwfVZGFP+TbW0wLe
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To be on the safe side, try to set ro_after_init data section readonly
at the same time as rodata. If it fails it will likely fail again
later so let's cancel module loading while we still can do it.
If it doesn't fail, put it back to read-only, continue module loading
and cross fingers so that it still works after module init. Then it
should in principle never fail so add a WARN_ON_ONCE() to get a big
fat warning in case it happens anyway.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/main.c       | 2 +-
 kernel/module/strict_rwx.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1bf4b0db291b..b603c9647e73 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2582,7 +2582,7 @@ static noinline int do_init_module(struct module *mod)
 	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
-	if (ret)
+	if (WARN_ON_ONCE(ret))
 		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
 			mod->name, __func__, ret);
 
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index f68c59974ae2..329afd43f06b 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -58,7 +58,10 @@ int module_enable_rodata_ro(const struct module *mod)
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
2.44.0

