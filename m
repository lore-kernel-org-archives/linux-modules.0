Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF361822CC
	for <linux-modules@vger.kernel.org>; Wed, 17 Jul 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237208; cv=none; b=q/725FLH0sp4DZ5FnZrNrikD0fcsTP8NfuCS0dZIaYBelKUhvkmDD9sCHcJWILWJTpXU699z9+6F5Q94Ua/amMF5VvH/FExJlKkPRjYQfbqASIK744dtEiN//mIYEyGpw0oKn4EjlQF4QRHZlQi+DYpXUy2lh79dBAcrbVLZ6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237208; c=relaxed/simple;
	bh=W56iHzbC1RyGjt+jrBphiqgZsaQ61XulDqDHX7MO+y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KuAIYB4ZR5GNIQJMl7FYpyVgwOtszBWVFNqSP90PB5jE/vcbU0PZW6d5TcqM2TSBzZgRD126p3WDyy5WrY0og+Tb/Q+Waou8xGySYoi55wyFjS0Cm7IXBsFUwANuQDhlc0RIUMETBkw3X/9TK/Sm9+s34VOYXegWmzjxqfSZxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8yTs69m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8yTs69m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19A0AC2BD10;
	Wed, 17 Jul 2024 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721237208;
	bh=W56iHzbC1RyGjt+jrBphiqgZsaQ61XulDqDHX7MO+y0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=K8yTs69magsSr0DhvhszivheYJbj77HVzJq3vEmnRofVeuhtv+fbniMVraYfVTmOY
	 Ir3vH8CqHPnvaKBN0GB6Aqk6P8zDVbXYF61BvR5YfIZbRwGnv7PhcYlSl3iYr4A/C+
	 eiqgelnmOInqHBlwczQ4CYUnVKCZiQ0DngiuSoiqfd/EjV342lrmesklT2kDcwN+73
	 R6hjxlrkjOvXilgFpoSt2Rje3DSQ489U1eU1LueKZpxt+RffcHNlQGIDste3F3j7cg
	 4qwtEw792PQZk8DZpLkwPSf4Dj4DGfQie2uqQkgwbttyjhIippkvqoTA+BiUAF3Yh5
	 2n+3B+ewLMh+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E655C3DA62;
	Wed, 17 Jul 2024 17:26:48 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 17 Jul 2024 18:26:45 +0100
Subject: [PATCH kmod] kmod: remove .alias config files for modprobe.d
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-rm-alias-v1-1-58874caf343a@gmail.com>
X-B4-Tracking: v=1; b=H4sIANT+l2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwML3aJc3cSczMRiXSMLCwND4zQLMxNTMyWg8oKi1LTMCrBR0bG1tQD
 XdGtoWgAAAA==
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721237206; l=1741;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=Gsv85/xQy8/nNNOgyhIvZ2Q6IxoNKQXq5wJxYihYbJA=;
 b=YWSsLvS2T0+cHnj8pSrWDmqPWICL4+EP3HJBG3pD69ws+jwtDZua0GvaSttJB9TQnPkwqDJN0
 FvWcCpspCteCdZ1VmOjaJF7dtFJPzDBnlPW0xuJQf42DNYYU5HXsJ5L
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The use of .alias (alongside .conf) was added for compatibility with the
original module-init-tools project and has been living in kmod ever
since.

In practise, all the linux distributions that I can see are using .conf
files alone, as instructed by modprobe.d(5) and the only instance of an
.alias file is the modules.alias as shipped in the kernel.

The latter is already handled by other parts of the kmod project, so
let's enforce what our documentation says.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
As suggested in https://lore.kernel.org/linux-modules/q6dutb2b5ztkuwjkq7a7ddnsbfneoq66bafaaxwppelepflcc5@us5n2ll5syja/T/#m84a542f8d4e2f4d31b2a7ee82aaf3d0bcf211aec

I have tested this on my Arch box, alongside a normal make
check/distcheck and it's working as expected. Other distributions have
not been tested, although I don't anticipate any to be using .alias
configuration files.

The section in the README will be removed shortly via unrelated patch.
---
 libkmod/libkmod-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index a571b6b..fb28ed9 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -940,8 +940,7 @@ static bool conf_files_filter_out(struct kmod_ctx *ctx, DIR *d,
 	if (fn[0] == '.')
 		return true;
 
-	if (len < 6 || (!streq(&fn[len - 5], ".conf")
-				&& !streq(&fn[len - 6], ".alias")))
+	if (len < 6 || !streq(&fn[len - 5], ".conf"))
 		return true;
 
 	fstatat(dirfd(d), fn, &st, 0);

---
base-commit: fa715f8c8b78a09f47701ce1cf46e9b67a49b8d0
change-id: 20240708-rm-alias-288013f86456

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


