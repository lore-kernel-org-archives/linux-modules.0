Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9086250;
	Fri,  8 Nov 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082348; cv=none; b=h0OyNUNT/QUyT4RJQ/rb3xc29WWcq8fOt38fsgWslkfcCYAxFs02vBmLZK10qJoIoPQHqZevRmnpHZTq39Y1LYoF4DMpTVxoZbjdclt1GIJZ9sAuOE8hAN8IbUlSuuXMLoZiBleSPUfHcmXVZRk5sz1FTOF3OsNW8q3zGLW+vEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082348; c=relaxed/simple;
	bh=1d5ON2PggbcA+/anVU20HTNwni2NHoWKO08BLOoL/G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi6W1HzqkiTzQiAQ4tpm6fghjsJBRjX45gz8BoD7GneRfYa8c7SqOBJ4TSQvKbsUPFJbpI6uly94YhDZCEGsUH0W2J5CopP2e1q4cy7o0zQxQJa3DhhJq/sdYD551jfqsjt9u5GS/lpdtQ9PJ0tla4JR8Jw75/zpHLfu6sQkRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAQQTFdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAQQTFdN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E756AC4CECF;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731082348;
	bh=1d5ON2PggbcA+/anVU20HTNwni2NHoWKO08BLOoL/G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MAQQTFdNdtlVaHezPwwSZe+0ExgcyrBWlWmPkSx/oMSJx2tuC2JpulT/fukEY9Wy+
	 L4E3w8FHjDuVILB4wjH5UpcrIhEAjY477n9MWrCq3/9ctGBFPC0wYzU5znOzPWszXd
	 GcHwHyU/o5P9u97AOn/ID+VJ728KH8Cp5eKGUC+rK+e9mRpvvevaoqkDKaQY9xbblF
	 0c5YbWfCdSh7wQ+2EyC5yKII4eHN2VKG00s4NghROFscOXCIGEO7wCYUSvu0tyC/cq
	 hPTiio3soePhTexz6OSOj/AmoSh7DQ+TxMY1tXOSy1BNW+IcaeiL6ANbQvTFVAlQNw
	 wt4jCuM1Mp2Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC5D5C0FF;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Fri, 08 Nov 2024 17:12:14 +0100
Subject: [PATCH RFC v3 2/4] module: avoid double ref drop on ro_after_init
 failure
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-modules-ro_after_init-v3-2-6dd041b588a5@samsung.com>
References: <20241108-modules-ro_after_init-v3-0-6dd041b588a5@samsung.com>
In-Reply-To: <20241108-modules-ro_after_init-v3-0-6dd041b588a5@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, 
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731082346; l=1137;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=9DltLcORsUZtMTYEZ5ybIyns3a3KM2mPjN1YlLgDFI0=;
 b=QZs431yGGNbH/0/7tBF4itYMit6iYIAJECiADp0Xq/FSZbSS3fyf+8N8yLOlqCVaakbY8YlG3
 nr9/IXGgCWmCuTJXB82rd7r27cxS+jDRSl+P4zu79plf5pt/OAoUKsO
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

Ensure the module reference is only dropped once in case we fail at
MOD_RO_AFTER_INIT case.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e0b2a8d9e324..35a50ded64a6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2941,8 +2941,6 @@ static noinline int do_init_module(struct module *mod)
 	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
 			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
 	mutex_lock(&module_mutex);
-	/* Drop initial reference. */
-	module_put(mod);
 	trim_init_extable(mod);
 #ifdef CONFIG_KALLSYMS
 	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
@@ -2951,6 +2949,8 @@ static noinline int do_init_module(struct module *mod)
 	ret = module_enable_rodata_ro(mod, true);
 	if (ret)
 		goto fail_mutex_unlock;
+	/* Drop initial reference. */
+	module_put(mod);
 	mod_tree_remove_init(mod);
 	module_arch_freeing_init(mod);
 	for_class_mod_mem_type(type, init) {

-- 
2.39.2


