Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F213AA26
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446212; cv=none; b=rMYOoicBB8dWM6OC98SjkAvSX3p/hrUBTuVQZT6jpG1Cej2Vg78eW3KInMHXMaZHBVJR+m8CQ1gvErVf47Q3nJwnaB0ltwd0AM96lh/ouYdOb7272HAsuQH96rfj0ZVC3nAPxKH6Gc8p0P38ePSbgrIqpeaHi3PU9ud9CoPbUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446212; c=relaxed/simple;
	bh=Ci8+frHbpsqa/LfLtqKUASl0oLPRCznx4EzNDMZHahw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaJ4pzIqLWLil5nKUt9bD4XdaYS6hqqX8ESQKYRUZipeTvk3Hiraselgh9Jj+miFYiOpg/a6+nlgQYSLeGPx0ymS5iZJZhvX0FyFqCol1RyMrED3jE6NbY/L6ItWIE0mpuFr28ZeBillF62JY0tNhmyWntSVLUV7eCz9UJ7PrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvLe8dvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvLe8dvX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C42C4AF0E;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446212;
	bh=Ci8+frHbpsqa/LfLtqKUASl0oLPRCznx4EzNDMZHahw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MvLe8dvXSk7y9voqMT6mR4rq6ZE2SuEFrIoeCY7WB2av23kZy7f0+fgaiKGzHB/Dm
	 dfHSdFmJkjbjy53lEQ2lcq+Jc9ziqz7CbYTJFIikN8kCASVv6bnCzAh9RjreHiSEFz
	 lntRUJL8ivkmmPSvppeS1ehGKT5ej5pkZgABRloS6PZt7cCs9VUoDMtQV/Sy1MhhIO
	 e4a97pMDYNVhuq2nof5kQyN9qUjHVijYrCWltzJYnlz6bOeSg+k5eMeGbRypPUtDz9
	 ThBM42dVaZi40pDosXdGV+z2v568d2iAHy2PoMMpGJEtP+19p5lRzbVTMvdmQ14oY2
	 uHQzHaYhhQdpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E05C3DA46;
	Mon,  8 Jul 2024 13:43:32 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 08 Jul 2024 14:43:14 +0100
Subject: [PATCH kmod v2 06/17] man: stop removing DISTCONFDIR lines
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-man-v2-6-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720446209; l=1116;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=D6xvHTo+v2kzK3NQz14BeM4H1z9+URlZ49VIK5g1yzg=;
 b=3YKV4A8Pb2O2BSmoRphpo1m2hilUytQEshPtJmlpzL+3aMlzvtHjtn3HpxKkOXQC7hJttiZQe
 8z4YOhiRq3MC5zkInTuzwD1AB2vH4GADIy05tC8NEHTUttzOVE6mTDQ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

Presently when DISTCONFDIR is identical to /lib we remove the whole
line, since the man pages already have an /lib instance.

At the same time, there are in-text DISTCONFDIR entries, and removing
the whole line outright breaks the documentation.

Drop the removal line - worst case scenario we get a duplicate entry in
the synopsis.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 man/Makefile.am | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index 77a0035..39a0015 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -14,11 +14,8 @@ EXTRA_DIST = $(MAN5:%.5=%.5.scd) $(MAN8:%.8=%.8.scd)
 CLEANFILES = $(filter-out $(MAN_STUB), $(dist_man_MANS))
 
 define generate_manpage
-	$(AM_V_SCDOC)if [ '$(distconfdir)' != '/lib' ] ; then \
-		sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' $< ; \
-	else \
-		sed -e '/@DISTCONFDIR@/d' $< ; \
-	fi | \
+	$(AM_V_SCDOC)cat $< | \
+	sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' | \
 	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
 	$(SCDOC) > $@
 endef

-- 
2.45.2


