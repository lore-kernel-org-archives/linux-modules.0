Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E181BF53
	for <linux-modules@vger.kernel.org>; Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280230; cv=none; b=NTeh0p0vsiHDHr/Ja5zxJVPr/+nsExG1bZFFL8zQtswxVKjPPG8NT9a1tCSO3OmT+/W+FpMk6YqB+J8KGzjg0KYlRDT6k8LVYeHBFvMzTdSOI18iW0uEW3lFVwTbEhgfqN3uKdyr/Ac2yi2mkYnBfvi2EQU8Ed2KsyLDa4Q56OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280230; c=relaxed/simple;
	bh=5CQ82m4EJToERg+iBBjvGV5URcWOmtQDjUeQjnjX2Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuKgIdzfFrqlGqADrSyX6P6rMHcSfiRGk+aVYjCeYFpbvpmXWh+WVj3blgUo7ZyVkH898wypAqNGDgDDOsvan2LZAoHgNe1AuXPP4WtIsGao8rjxsgfDQdwLP29Qgat6CO1hsCIb30g3C1GmNY+l043xPV72TzeLy67xLw+e/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmXVe83j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmXVe83j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9C87C4166A;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706280229;
	bh=5CQ82m4EJToERg+iBBjvGV5URcWOmtQDjUeQjnjX2Vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fmXVe83jjtoHIJSYvlekR9cKHIMZVWpeE3rV9u90I8uTsxw2ZYTtR9HjNIRsFodUZ
	 imMpos+PLKJFrHC1GkPRSYjQI/HzPPx/MVpvfeGq7j7V36Ab6JmvsRrA6c1gDQNYiJ
	 ZXCCqIkc8+ShcSfqij7XZitHwBd0zN4k8xRhdVsY7G+g4WGclDuNUXxZA5RJETBJ9q
	 T1ZnCwQl55RHpjq/ASr3kBzvzI5MwGKEjOylFUTj1jWNd15ul9hWKl68fWQ/0ssU4j
	 UApvZOtm7/xXfniHIew63ieHRJFA3BGYas2u/USxI+kXuHeK7czVO1A5L4D075TroR
	 0io77Um4vuLSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9195FC47422;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 26 Jan 2024 14:43:50 +0000
Subject: [PATCH 1/2] configure: tweak the module_directory help string
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-master-v1-1-6257d039a30a@gmail.com>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
In-Reply-To: <20240126-master-v1-0-6257d039a30a@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706280230; l=981;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=odADJmMZHmCPpeUZVqD+kpI2Vt0oc+W3kHqA6aS9tIY=;
 b=AUcT2Of6cwHxxOx17QvN93TZCuSf+he/xRj0n3Qx5IYkq00JgFeKhRlmtOLzPoUJPxcu5rohS
 dBY/mzpSSSzBka4yGK8799Q4nadMspw9Hz+DIByk1zSvHYeY4xLcM3x
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Drop the somewhat misleading ${prefix}/lib/modules and explicitly
mention what's the default.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index de01e08..ab0b303 100644
--- a/configure.ac
+++ b/configure.ac
@@ -93,7 +93,7 @@ AC_SUBST([rootlibdir], [$with_rootlibdir])
 
 # Ideally this would be $prefix/lib/modules but default to /lib/modules for compatibility with earlier versions
 AC_ARG_WITH([module_directory],
-        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules - typically '/lib/modules' or '${prefix}/lib/modules']),
+        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules @<:@default=/lib/modules@:>@]),
         [], [with_module_directory=/lib/modules])
 AC_SUBST([module_directory], [$with_module_directory])
 

-- 
2.43.0

