Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197F154C0D;
	Sat,  9 Nov 2024 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148554; cv=none; b=WqXMBTcEb/rLS2JVm9ZewMKSk7OsyhMOBlBxj6aH7C627tAHDA0URrroDVgG7n4zC9/55KB4ECthOlfF9fLSQa606C9qPvrLiTb19lXualdeaO9LgdMGSdefIDXKqroD2o7Rp9cOOXla+N36QHuAUgviw0/vMCm48CAfgNSFL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148554; c=relaxed/simple;
	bh=3RCZrcxbVk116xCD7F1o7CSTHwR93C3nC4/XjarUaFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL+j22kvkLmzlRD36uQSdrToETExo4r+IyS5Dgr091ad45UYX0LTZF9K+SM2u8bcMhjvIi/Qn2Ezuo+SzMaCbL/OI2E7NfUm+ef4B5Aa3lxm3dYU6j4I88Qa6ZX8nsZ1XECVO+9ONhjYNMI3qhVP+IjoJkI7q7HaAsr9rOvl0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XlsfF0BFhz9sSR;
	Sat,  9 Nov 2024 11:35:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t7KqNFX0DRXu; Sat,  9 Nov 2024 11:35:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XlsfC1tlhz9sSK;
	Sat,  9 Nov 2024 11:35:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 30B538B764;
	Sat,  9 Nov 2024 11:35:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DaEZiiZcoRNw; Sat,  9 Nov 2024 11:35:47 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.57])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AC90B8B765;
	Sat,  9 Nov 2024 11:35:46 +0100 (CET)
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
Subject: [RFC PATCH 2/3] module: Don't fail module loading when setting ro_after_init section RO failed
Date: Sat,  9 Nov 2024 11:35:36 +0100
Message-ID: <164e5f22f8ab59d1d516e3c992efdd9f83ab4819.1731148254.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731148536; l=1312; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=3RCZrcxbVk116xCD7F1o7CSTHwR93C3nC4/XjarUaFk=; b=CBznfeRNltA2yb8Bahk2GTwJQHnBn6SjdjB6sFHq3Gb1iTFkpLtIaRyrWhUZYWitpivNzaUp/ t0O+UJ5yD9NCCT+hhwmRqkI+CJg7q4mLwnXalOD2DM8i0baOCONQ97k
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Once module init has succeded it is too late to cancel loading.
If setting ro_after_init data section to read-only fails, all we
can do is to inform the user through a warning.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com/
Fixes: d1909c022173 ("module: Don't ignore errors from set_memory_XX()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2de4ad7af335..1bf4b0db291b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2583,7 +2583,9 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
 	if (ret)
-		goto fail_mutex_unlock;
+		pr_warn("%s: %s() returned %d, ro_after_init data might still be writable\n",
+			mod->name, __func__, ret);
+
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2622,8 +2624,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_mutex_unlock:
-	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
-- 
2.44.0

