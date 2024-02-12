Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE73E464
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758586; cv=none; b=FvXonnS8JGcOrZe+XGGW85ZSANRZiVKNUgo/6STAvqz1uqBqHAit0/3UuCOx95z2QnqQUx3VsiejQXNDfkzSRa5mffhdm9TOekIV3IjGxk3S3oSkvzn0akhgsJ3ZmeKRaOZFV6Z3ZJD3Ao/bT/4bcti16i7AI6vMPtXTRTgVDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758586; c=relaxed/simple;
	bh=i0w/N1kme4K9ELI3ZZ4I7KCak551RKEE1CoF9dzzTt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZYfhIRmGrLZZ3P7PuCcRPYCesS++OCRC4UhkRy0EcXaT5p1VnFqg6AghKiOhnbQHNNOECYbPOkKb+3sIBXd/yTdKeyuAKNTS3rXdP59oyWKLIbn9bfdTxMS6X6A1gdNqjDzTa2vXlyXVd1xnbgQSqFW35PhLRvstAQh4uhLePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1aiJ519; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1aiJ519"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01F45C43142;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707758586;
	bh=i0w/N1kme4K9ELI3ZZ4I7KCak551RKEE1CoF9dzzTt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g1aiJ519NoF/mmoVzXYN9jmb27OcbMuMxznmPZtax0pHbyUlKZzX1FJ4SXqNATlJT
	 CY8qSonxFCBboxsVBHSSR+GsilMJOu1WnhJNlvBhksDHGHzS3MsAmg5EJ0ZS0TxTkw
	 CbGhQ3NBvLxTfMi34TzewcVQg4l6tlr5hrMDyaktW6dcC5mrUXcQx/CorkxBFsoYIZ
	 5DDAl5mZh0khuFn7H4+DdhxKtQO4vvOaPpEdmjSV+c5d+/5jicNQWhLS+lb74R9uCr
	 egUSZC3+ZYw1ea2Gn8mo1RiYm7Ec0fFRe64UAOP+0LBvbcSpuqD5Z5SQcvm7X9r0cb
	 FCGluY4Dc1jYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0676C48297;
	Mon, 12 Feb 2024 17:23:05 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 17:23:08 +0000
Subject: [PATCH kmod 07/13] libkmod: move kmod_file_load_contents as
 applicable
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-decompression-fixes-v1-7-06f92ad07985@gmail.com>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707758583; l=1207;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=P4udCeYuUMpIW9quBl7lfm1aEgAkNyDIYoV/mJWVVoQ=;
 b=XUvBbmBX6Y/ENcaTa6JI/AV0aVBXrs82P2iIirqcUF16Q16DVaep0Re0Pim1fUzwgHxOfQ13h
 dAf8Fk4IExsD8UDr6zHqJeZkOx4q5GMWc92FaveloIW6hZwzv6pKROH
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

When dealing with an elf, we don't know or care about loading the file.
The kmod_elf subsystem/API will deal with the required parts itself.

Which in this case, already calls kmod_file_load_contents() as
applicable.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 libkmod/libkmod-module.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 1e43482..d309948 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -903,10 +903,6 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
 	off_t size;
 	int err;
 
-	err = kmod_file_load_contents(mod->file);
-	if (err)
-		return err;
-
 	if (flags & (KMOD_INSERT_FORCE_VERMAGIC | KMOD_INSERT_FORCE_MODVERSION)) {
 		elf = kmod_file_get_elf(mod->file);
 		if (elf == NULL) {
@@ -928,6 +924,10 @@ static int do_init_module(struct kmod_module *mod, unsigned int flags,
 
 		mem = kmod_elf_get_memory(elf);
 	} else {
+		err = kmod_file_load_contents(mod->file);
+		if (err)
+			return err;
+
 		mem = kmod_file_get_contents(mod->file);
 	}
 	size = kmod_file_get_size(mod->file);

-- 
2.43.0

