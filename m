Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7F28E37
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116501; cv=none; b=as93orTPRPks2XbBQ/oA76VzpiRVYbYSaTBL7L43tgSh7TZY/GI/zc0K4/XbH4LMR1OJYlKCslUPT3kqpvEYugmbhDPYS3kMmktKkpYvBluWGkXi05dy1pXFyprVA3eVSCF9fh5ZnSza+elszNfaD5nQyid0X3m3aSztkE0TM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116501; c=relaxed/simple;
	bh=Wr0aEzQeW1dijVE5GfbbS5a6pf9XdZhae/d6e2b2VLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o6wyLqfZJo/huNs6xr93z9uBmmlwQHYhP/U5Wt+olqNueZcfDN7n3o/iUCzWWw+SE8fpvnjEJetNzkanoQoFH7p1ZYsjgoXszzgq4ix7v+zQgbAaVZ+Vh08idB5mQKkanwCdo0VOSwbS0b85wP/O8o5OlkIxxAmaxpEMGpvtPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkiM2kQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkiM2kQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32992C32789;
	Tue, 11 Jun 2024 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116501;
	bh=Wr0aEzQeW1dijVE5GfbbS5a6pf9XdZhae/d6e2b2VLk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dkiM2kQQwmhJga7B8yW0b+wplmUOMS2l+2wm+Ft8Av7d8mEKRa1PJiGkPNIV9mhOb
	 QufH3i886OT2qKuBKbMKTmwIDF4+8YM+uD9/sg/oA97/AeGbxOqokliWgrMlgUJL7s
	 V6+cDCPPSjl9cMddDRejSIvO2G6LfG4Lb6KG+1m+wovnmeWgGRrs3z5D41IqnCuKW1
	 snuz2vw8+1qINr8EEcv/DDTbX3DO2NwOh8bVGf38ctCDEQzJl44A61LOpu50seA7WQ
	 WbuNRbr1hZW19qPh2YC3/9QC9i7aQG4oR5eOiJxKdyZJmT94p9+EvHFfwDEkaK0FjA
	 72/4FZpm7VgLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22162C27C75;
	Tue, 11 Jun 2024 14:35:01 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 15:34:56 +0100
Subject: [PATCH kmod] .mailmap: Forward to my personal email
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-mailmap-v1-1-69ce7f7ffbe6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJBgaGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0ND3dzEzJzcxALdFEtLQ9NkI3ODlFRLJaDqgqLUtMwKsEnRsbW1AHO
 HZBhZAAAA
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718116499; l=637;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=tP92u435afiqHpYb37PUHPdJHFdDZzRRYbNdk2K9+HI=;
 b=4k7eUFnEF+XuReppNLw5CVpDMuYJheEycH/rLQPeaJieCNf1Q9Ud0E6PTS6+EYirtNYTrhs8A
 78XVud30N8dCC72PJrjCXMeasAueyshMHe6GG43NXg4P1kIP6Bjb6/y
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

My Collabora email is bouncing, so forward to my personal Gmail.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Hello everyone, just a trivial one-liner to reduce annoyance due to
bouncing emails.
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000..7a9ca51
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1 @@
+Emil Velikov <emil.l.velikov@gmail.com> <emil.velikov@collabora.com>

---
base-commit: 8837461494761d58be579641f20cc043274adddf
change-id: 20240611-mailmap-d9915c270de9

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


