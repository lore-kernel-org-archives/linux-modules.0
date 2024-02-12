Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1903DB81
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=lQWUtN9j6hJxqSctlqq3Yrn6GW6qlDKpO3g6UvT0BdwQxMWjOL7P1Pt7uD7vPDVQ2M2N648XjmAqjahb6gYNPO1s8VTCQVr3aXU84uc9VJcyeDT3e912chg88rK2vKdqc9NyiyXrkEy2Qcn6TukjPxAHbzNk7xHUR6AypNZq4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=asgG9/cLMuHUP3quTuOb+BojWCY1bbHQeraYWuEvABA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eih7hOg88ClBqmFdi1VT3NkfgZRBs7ZLcm+txIxHuOQ+T2w050wul6qY/E6Qx+SOaNdjwMv6lguFCPJM2Ooechn9NDjUmWSEGNUZ+/UUh4h//FWsH/Wny5soSIf3cw8dFGr4TEuXI9I9Kkn5e8MBa3kbFxbUCOLt8CkiBz1XDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnsmPjyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnsmPjyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3DB4C43330;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758585;
	bh=asgG9/cLMuHUP3quTuOb+BojWCY1bbHQeraYWuEvABA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qnsmPjyJ6aGXY4u6pC5MLqFzQ54RhcUFI7E/l8nzXMHbPtQubCruwqXyGsZSEdMup
	 JVqO8mLKPbJKNGvEl8b7ElYo72FopGlaNYE8wLnKcMl9epbNzbeebWSaTD0hQcgWAe
	 bqzhPqWHWXMyAz8vRIn5mWB5hk9ugTzujIG8F6ueN/s+lEotZisaCoeRWUlrAmZ1VL
	 tBPqCkznUTFguqXEcdbdfFAOTpZ2rFOqj5+3F2zTU2cNx1+qdD80eAh4jVRKfP52/z
	 oaQELd1nIGaz1S9yYOxggvJuhZTGcvJaQ1GrjTcWW1Pcy8WdquGuHJP5xKKjv1vmp/
	 WgbmdAyWCEVyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C9C48BC1;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:05 +0000
Subject: [PATCH kmod 04/13] libkmod: clear file->memory if map fails
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-4-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1017;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=al1dK4HvZ5PCQ4yUkG1+INHPpcQTPWCE4hwkvTyh6Uo=;
 b=udM3cpyiH3c1vGygmQo+2yfr1L4mDfY1Mk21tp8R9fjbY+vbbiIiyIEcm4a9Qyb1F1arhZeVJ
 iJyCq1c1NUWDn02kEphWkyNyJMaR8ADvcEs+5rDieWgJtc6GnVrAwrZ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

On mmap failure file->memory is set to -1, which we'll happily pass down
to munmap later on.

More importantly, since we do a NULL check in kmod_file_load_contents()
we will exit the function without (re)attempting the load again.

Since we ignore the return code for the load function(s), one can end up
calling kmod_elf_get_memory() and feed that -1 into init_module.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index abd4723..b408aed 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -392,8 +392,10 @@ static int load_reg(struct kmod_file *file)
 	file->size = st.st_size;
 	file->memory = mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
 			    file->fd, 0);
-	if (file->memory == MAP_FAILED)
+	if (file->memory == MAP_FAILED) {
+		file->memory = NULL;
 		return -errno;
+	}
 
 	return 0;
 }

-- 
2.43.0

