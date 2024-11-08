Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4371BD9E2;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082348; cv=none; b=ZH+2y5XIMyB8XS2cb7iEiob13yVwGjXWLDmSR+MuR4FK6Qvxb8CAOhhsYSKI4EoiS6PjzFvhJmMW4An20pe5nzueIH1RnB48VA3gupwx7wkgsDl0xmJ/ZVUc4oVI9cpAu7RmAfCsgpWpVzIE4jeP8u4q2C4p/6H2rgCa87MO7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082348; c=relaxed/simple;
	bh=CQbNWypqAhFi6ysGW+rHEwMrXdX3yqR7EtZZD9S67hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WR+px5hOzitJyaK7oAJM8MUKXnOIh+iVSL2pDQywZmuO7A0xgdi2VmEs7T2YsiaBWJ1679/22Uw9w2KJg8JJhTvPiOhntgpA+Hpq5a2bck1iB1uweyjoWIwCAMFM7jEQoGCpAYcfk91WKbBaRwtxHztHfbF6T5y2z43DdsxWezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8kxxNC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8kxxNC+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4F62C4CED0;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731082347;
	bh=CQbNWypqAhFi6ysGW+rHEwMrXdX3yqR7EtZZD9S67hI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d8kxxNC+xuswV9NDqxMbTnpDTO4sWZJRovYv4NkPVCqoV646okpwKcq9A764g1C+/
	 c48zTV4C3eh1SWjhvjGHkDxmy2Tgow8uZf21gzQWyX+1YDw7Q2FqNtx9rndmpz8zmf
	 t5A9MGQjEvZ+Qt5LgqNT5ctMUEObrof03Qq1NexlcvCVSyAx9h/oXN6UZy747nlO+z
	 f3R9pFqbD4g8ABfbshJPCqk2d4OI6pL5M3hBuN2iIbXHIW0Bj3BfnR1oDDPWy2oGT7
	 XL3lA9mKBkSBxHyf0FhtrFFzCD/aa1G/B8BwGs0pOUYx3oQ0xe5W8772CkOEyW/8fl
	 9UJon/Zz/3asA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5690D5C0FB;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Fri, 08 Nov 2024 17:12:13 +0100
Subject: [PATCH RFC v3 1/4] module: remove module_deallocate() unused param
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-modules-ro_after_init-v3-1-6dd041b588a5@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731082346; l=1219;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=A6gqpizSENgaBLBO0Z0bdDnIpaPO10y9Bcdf+FyWroA=;
 b=O7Dbg4205CdfeJlhE+bW3nIQfANZpxsZmBln1qQ0yCbBltIyVE72FQIb3iTKVLmaOI5GiLv7+
 LS+p0Qm1bY/BylXOXe0q0fXAS4yRgFxaHr7jyllw5j3BFa0KEBBIMha
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

The module_deallocate() function no longer requires the struct load_info
parameter as of commit 48fd11880b5ef04270be8a87d9a9a9ee2fdae338 ("module:
Fix performance regression on modules with large symbol tables"). This
commit removes the now-unused parameter.

No functional changes.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..e0b2a8d9e324 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2767,7 +2767,7 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 }
 
 /* mod is no longer valid after this! */
-static void module_deallocate(struct module *mod, struct load_info *info)
+static void module_deallocate(struct module *mod)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
@@ -3417,7 +3417,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				       mod->mem[type].size);
 	}
 
-	module_deallocate(mod, info);
+	module_deallocate(mod);
  free_copy:
 	/*
 	 * The info->len is always set. We distinguish between

-- 
2.39.2


