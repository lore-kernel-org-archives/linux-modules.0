Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A612CA6
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405563; cv=none; b=LE5FsfD97EUNlxnI6G11LPCEr81B0xE15y+C4B5FHBL3tjRqweQMFDiCqBApy0uO9im/ulSnjMMEO8plNWWUB1yVEDjXYO+Muc5gP06HR+3cbgYJ+ssQ4cknQLs2Z7flM0FBhbf93s4A/JzaM52t57WSUtygZtLlfDKAnrOXay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405563; c=relaxed/simple;
	bh=hwFpOOZXNjN4VymfHrn632VSPvfq4GkUSetMM4BUh1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfidqHPT3KFZNtMMJkV6h5Vbl2LRDF+LEil7yT0VGBEjVO2uo/uqY0J+k++1tY9VmOcdV8bnG9+RtSHk8B0SysdLs+JhX819l+Uvn8XEau4uAbWgw0f4rJAd5aOskD9izq4DR60R28fzHbBPjYpsXRZrR7Ox9DhRwtzSPXgOfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCnKX5fo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCnKX5fo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B8F2C4AF09;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721405563;
	bh=hwFpOOZXNjN4VymfHrn632VSPvfq4GkUSetMM4BUh1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZCnKX5foctJJ7lf60Ay6EBHZ801zaPxZ1FuO+kPMLURU5b1sxW72BcYx1+kVO7Zls
	 ox9iTkD/Ul7oxi7BnRWatpZS292/VZEMSEBUp9iNIiVGJF+iaC+260wdrC/wYYkUJp
	 csNPEddy0Zb7YQJKvNOgrhyyq62829guIKZuomv624CUjTM3cpnpVbhow5wtXQoder
	 xcP/gJKgg4BkMw0WUKXr5Wu2N3xpwvFlCXhT+SEotBnIAsQlt98XU2Vh0nR+oPN8qJ
	 eH+RRvJIzzcpeMxpTpz1RDVY53k40XnKAEUwFPuRdLfjoFh3g2aBTGSd2GrSZGDwt+
	 fONxxmHpshEow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFAC3DA59;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 19 Jul 2024 17:12:41 +0100
Subject: [PATCH kmod 1/3] libkmod: document
 KMOD_INDEX_MODULES_BUILTIN_ALIAS in kmod_dump_index()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-abi-fixes-v1-1-1e6d99a2846b@gmail.com>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
In-Reply-To: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Marco d'Itri <md@linux.it>, Eugene Syromiatnikov <esyr@redhat.com>, 
 Josh Boyer <jwboyer@fedoraproject.org>, 
 Yauheni Kaliuta <ykaliuta@fedoraproject.org>, 
 Alexey Gladkov <gladkov.alexey@gmail.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405562; l=1746;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=8AhtTXAyZZ10eWdz87tQwKwm866stviAIl/eVpSKW9U=;
 b=DB495+JOHzWaoxN3xLGaBrchoWkB1mvIa7tfARaIdUPZBMCoX/bHAf3YOHOrohst9OfbFmlf0
 vgvXqYM92ryCI05jNUfGdBx6VF21rSpkzkeKlZzk5bbbfGyK665WZTc
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The extra enum was introduced a few years ago, although the (only)
function using it did not have it's documentation updated.

The commit itself has caused an ABI break with kmod v27, since the
KMOD_INDEX_MODULES_BUILTIN value has changed.

A search through Google, Github and Arch packages have shown one user of
kmod_dump_index() - the only API that uses the enum.

In that case and all others, no projects referencing the changed enum
were found. Although since recent and/or supported distros use kmod v27
or later we've decided to only update the documentation.

Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
Fixes: b866b21 ("Lookup aliases in the modules.builtin.modinfo")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
The project itself being https://github.com/falconindy/modtree which
hasn't been updated in 12 years.

The following distros/versions ship kmod v26 or older, where bunch of
them are no longer supported.

 - RHEL 8 + community variants Alma/Amazon/CentOS/Rocky/Scientific
 - Alpine Linux 3.11
 - Debian 10 + derivatives
 - Ubuntu 18.04
---
 libkmod/libkmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 213b424..fecb8e7 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -971,6 +971,7 @@ KMOD_EXPORT void kmod_unload_resources(struct kmod_ctx *ctx)
  * KMOD_INDEX_MODULES_DEP: index of module dependencies;
  * KMOD_INDEX_MODULES_ALIAS: index of module aliases;
  * KMOD_INDEX_MODULES_SYMBOL: index of symbol aliases;
+ * KMOD_INDEX_MODULES_BUILTIN_ALIAS: index of builtin module aliases.
  * KMOD_INDEX_MODULES_BUILTIN: index of builtin module.
  * @fd: file descriptor to dump index to
  *

-- 
2.45.2


