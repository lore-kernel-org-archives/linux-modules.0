Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18722E419;
	Thu,  5 Dec 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427997; cv=none; b=hwLNhyTZ468ra9id95g1flcLpiSnIJ38GsS8qJT04mPCcswAW4TGCdSP75EmN1eeRjizr6jYZ3S4JMR91EJTDE3bKTipUc6KejLX4TYhYo6ldIik/eBjISqAm7lftfxYteJ+vBQghy72gVnyOMOrRggn9r3EZ4boKy5J1wYaTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427997; c=relaxed/simple;
	bh=8q2j6oY2j7jBVhN9HdnphDr7Cw59vtHJ7ZgyENJ4vY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy7NYko6ZhjiEs5qpsXziuePLJFcl4tqRQ7gCXyrGH9jBpxYGPMFU33BzRHmtY4cnivP3P6uLZzmp8uQ6p7OI4TJwg/dYvyG7CL7o7x7xemX8W7W6vUFhA45mdgeHxnFHi9pdl2niJtRHrYnr0Kt/tEbWx4o7B0ozpez3RRsSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y44dV75Kzz9svl;
	Thu,  5 Dec 2024 20:46:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODfdm_7cbVPI; Thu,  5 Dec 2024 20:46:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y44dT2SbZz9svg;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4363C8B76E;
	Thu,  5 Dec 2024 20:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oX7KGUuo9kQt; Thu,  5 Dec 2024 20:46:21 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C98EA8B763;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
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
Subject: [PATCH v1 2/3] module: Don't fail module loading when setting ro_after_init section RO failed
Date: Thu,  5 Dec 2024 20:46:16 +0100
Message-ID: <d6c81f38da76092de8aacc8c93c4c65cb0fe48b8.1733427536.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733427536.git.christophe.leroy@csgroup.eu>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733427977; l=1393; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=8q2j6oY2j7jBVhN9HdnphDr7Cw59vtHJ7ZgyENJ4vY8=; b=UEZ+N40ZDpO5GVZVXdCUO5lkkuhyK1548+DIf0nFX4s0jTmwRJ8aLNCoeGDi6LaePdf/ylwVC iMFKHYAxRk+CEnR0tmf/MLAu8OWvklLq2qovuiENuo7URtgxEsuDtbD
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
v1: Fixed comment from Petr about __func__
---
 kernel/module/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 39fe5d81b6a8..5f922e563fc3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2675,7 +2675,10 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	ret = module_enable_rodata_ro_after_init(mod);
 	if (ret)
-		goto fail_mutex_unlock;
+		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
+			"ro_after_init data might still be writable\n",
+			mod->name, ret);
+
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {
@@ -2714,8 +2717,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_mutex_unlock:
-	mutex_unlock(&module_mutex);
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
-- 
2.47.0

