Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91913BBCB
	for <linux-modules@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118305; cv=none; b=YRv6iyGb34jgNxLNtQA+44UfaVD3Afd4B8haQAePRokrFSe0G/LPsGcZLh92jwAdto5iTlQu8EU+OMVFYZVnDBDmzSHookrIwM8kS+aQoEnb3B8vbUQCZHsF+32219Wp7nmk0OMJ5mazHIP1BbJ/SGr0rOuvURdGqFPXZ3zjVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118305; c=relaxed/simple;
	bh=pRTuhdXO+c0vUaBzqr2xVHOPmvijxDkZRc5De8MtHfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkh7wT8mxNl/lxhBwV1WMR/WE78XjXcAMUuESJyeSQfuDSVERqW1mn7jPrnoKIoDbbEKHVgQ7p9QgPGQbvJwIYupS7SMzMKR2DD6qfGqg2H/Kq6SU6Sx6yH7QHnY6YSBTb8nzv3OXdCtg+AZgdxQ1uJM7knm9gwN1yBK1fKVd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5J0lDvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5J0lDvA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A65FBC4AF61;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118304;
	bh=pRTuhdXO+c0vUaBzqr2xVHOPmvijxDkZRc5De8MtHfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L5J0lDvApUugxAq0IjfDhpjDSTt7rFnFo0XUbFqTf0F2GSMPq2ESmj2bvZ+U3YOJb
	 W7YChlGmnuZcM//UFgB2XhPC6z1fRENCNYlcWHpNqT0H+HSNYwKaQF9wX+NNLo8rYX
	 gI3jXTa+KYOSfzwgZ6++gyloz7gwyEzOSZJWa5S9QBWz7DcLMV/LyD2WHHh2no3ekD
	 J6Z+X6woGzdEkudG1eQVKpvGopzT952ArbPQLVoGxllHRodugr8vCAtz/dwW9dAGnv
	 bbkFR2lPBF6F2R55xU6uviIvyCWdVBJs/b6RZ0aWl0bD+Yx6PHVRFlIguBEVeAXtFg
	 yUpO0SGCItUEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A060BC27C79;
	Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 11 Jun 2024 16:05:10 +0100
Subject: [PATCH kmod 10/20] man: stop removing DISTCONFDIR lines
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-man-v1-10-bd6864d49639@gmail.com>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
In-Reply-To: <20240611-man-v1-0-bd6864d49639@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718118301; l=1089;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=MRlljoUHYBNK6Z6N5RhRZTe/uBXRrwuRR7bbc0V2Tww=;
 b=jDYIVtlDROU2qm86wbM3x7+bMQdV8LcSZLozo7IibTiM6EI0bqgBydT9umRPZIfjkZiZnSjUf
 06rDjaipQJ5DztjhbfYZqKEAaMxSnObwvWEN3yiLG20oFRTm0bc1VP0
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
index 0285fdd..25135e9 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -14,11 +14,8 @@ EXTRA_DIST = $(MAN5:%.5=%.5.scd) $(MAN8:%.8=%.8.scd)
 CLEANFILES = $(dist_man_MANS)
 
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
2.45.0


