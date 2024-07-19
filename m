Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D414658F
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405563; cv=none; b=Zyajzs4/kuiSKpl646CxkpfpKHMHyiabnQF9U1bOYIic32cX8ranJ2zhcAQXtyWeIzRMQVsoUtmeUYrutuMMaozJrj/Xa60AhtI0vWkgJDJc1ibtGx/OADWeuQ1XFWO++aqZOgKvpo04tnssjV34BdzQDrWmxYoaF65RCy5DyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405563; c=relaxed/simple;
	bh=4Z1X0/NEpWF7dEXQ5UagP9W5av05YVLekK0PgcbiTvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBcN0JBcY/ry4soxDd1+OXA8BOXacHSLABEIzGSbsmc20coIC8gLW3NKAu3oKhNDLV8bkh6kf5BEUH505O99iWzCT7e9A29yjW+8z+2kTz86l+TEPEpGsn+w77HlEZs92O7CHNM4hnOXMkW+rIjp86aycn7HS5Dczz4Wg14aOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg8o2a8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg8o2a8F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B34C4AF0A;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721405563;
	bh=4Z1X0/NEpWF7dEXQ5UagP9W5av05YVLekK0PgcbiTvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gg8o2a8FRdJfs4uTrExg1/8JF4npYYLhrpS5w5MjrNZmX5wnNOd0RLH5U38Asdcjy
	 mJVfAVl4Ev2a/MIIwitU93nFgriNHxTYjcm6215XgYirfGUkcp0a918Maw6SimSAUH
	 1i6agAmmjWoy8jFp0H9eWNVuVVzR0Hl1NqSEMlyGJHxFIkGiEN5aoKxaCOQbVm6Bm8
	 UKK/vWf9A8hp4AOCWXjpRMySFXMLJh/HUBzJXpy1gj8urTgsw3yawKEQZGKfHJrFbb
	 5pzru3TCuAyRSUo6OB+visIyW0W7vdt4A0E+P0eXRpx0KYEW7k0KBrvVSF/FT60PFm
	 B/lVoOj5QXOSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25674C3DA7E;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 19 Jul 2024 17:12:42 +0100
Subject: [PATCH kmod 2/3] libkmod: correctly tag
 kmod_module_new_from_name_lookup
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-abi-fixes-v1-2-1e6d99a2846b@gmail.com>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
In-Reply-To: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Marco d'Itri <md@linux.it>, Eugene Syromiatnikov <esyr@redhat.com>, 
 Josh Boyer <jwboyer@fedoraproject.org>, 
 Yauheni Kaliuta <ykaliuta@fedoraproject.org>, 
 Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405562; l=1620;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=M4YnV9+hVYcdsO1S8HqSahF+HvXqm0LQJKAHn27gLdo=;
 b=CWvNKRHtB3FB1a1Ns3kXWRUkuOZzV8crymOuKk7taaxD9SKalrBrpN117Ll3tDdj1Npu7nlHX
 xauKNpyRmAqBrY/24bMrQr1xhG4LTH27jif7eKi4X9Ir+c4dQQ9ery5
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

From: Emil Velikov <emil.l.velikov@gmail.com>

The symbol was introduced with v30, yet was erroneously added in the v5
section. Move it to the correct place.

In theory this might cause an issue - severity depends on how the
runtime linker is setup. From a harmless warning (on stderr/stdout) to
failure to load the library.

In practise this shouldn't be a problem, since there are seemingly no
external users of the API.

Fixes: 9becaae ("libkmod: Add lookup from module name")
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
I'm fairly confident this commit won't cause an issue, although auditing
the whole internet is not possible in practise. In my search I checked
through Google, Github and all Arch packages using libkmod, namely:

 - dracut
 - igt-gpu-tools
 - libblockdev
 - ndctl
 - open-scsi
 - pciutils
 - stress-ng
 - systemd

Another option is to make the symbol as internal, since it's used solely
by modinfo which static links libkmod.

...we could also leave things as-is.
---
 libkmod/libkmod.sym | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
index 0d6d338..e71f488 100644
--- a/libkmod/libkmod.sym
+++ b/libkmod/libkmod.sym
@@ -31,7 +31,6 @@ global:
 	kmod_module_new_from_name;
 	kmod_module_new_from_path;
 	kmod_module_new_from_lookup;
-	kmod_module_new_from_name_lookup;
 	kmod_module_new_from_loaded;
 	kmod_module_ref;
 	kmod_module_unref;
@@ -94,3 +93,8 @@ LIBKMOD_22 {
 global:
 	kmod_get_dirname;
 } LIBKMOD_6;
+
+LIBKMOD_30 {
+global:
+	kmod_module_new_from_name_lookup;
+} LIBKMOD_22;

-- 
2.45.2


