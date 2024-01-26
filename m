Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF01BDF8
	for <linux-modules@vger.kernel.org>; Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280230; cv=none; b=gZ+iL0ez5Gw+j8vpTk2D1BwSl7fen2GnI5dIq6adc8lpX+HNxj7RBGa2u3YMycAFjcm9pwdFKPvqK++bfP1jKlo/iS9vUybnZOZsDCIF41OWC8/dm8J7J89ftCh1C27uj3dLnlMLTo8Zj+BqiO+8c5RXrIXTcbiXz5bbUG5Mgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280230; c=relaxed/simple;
	bh=iP3YAJTUyB2rRlKlTQsMxA8BAo5WcM+lG3V0XkqEfVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qh1m45A7B+btFdYYR/m2Jdkmshg8oscdzACl65hc1CLy2gAGD+IYDPCzzaBz+8I5A5nq/SmMKJueWP/J71cgjDE4LI4uPf2t6oVnItLyq8KoIpVWCVwojwaw7rliyEtV53AhXt+YzInNaZngjeCSWhheIvdxkrcdwBm2hpB06C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXgJKuKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXgJKuKU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3BADC43142;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706280229;
	bh=iP3YAJTUyB2rRlKlTQsMxA8BAo5WcM+lG3V0XkqEfVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WXgJKuKUohWN61hUV7jSFiAbJSjNH54GxM+OfzK0IXOavLU87e/l9B2tUHgFxsXK7
	 BdrfulUpvsc3YstrjCl9oWppcUJ+b7OLSnJw29n+bY6sZjOWCK8qmDhgcd3Dn5rcn5
	 AI2Fcc1/8Q3+WALHzX4Cy8mfOGcZdeuKQpvFmhvaBXsV8Ncb9rB26wiyw/91fBs6ky
	 St7b4V5s8otVlpfo9fToPCQNTxuKKIARfJpGqPD18PvnDFd16GZAjcJXjCxyRZV29M
	 VZgKnM4eBkQNI0iu1bUF3gf03yj4X2EfgBeXNx17R0aSGXrx4vJV6QLsSf8dvbT7Uo
	 mow6IJvEQc1zA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2FEC48286;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 26 Jan 2024 14:43:51 +0000
Subject: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-master-v1-2-6257d039a30a@gmail.com>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
In-Reply-To: <20240126-master-v1-0-6257d039a30a@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706280230; l=1402;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=N6QdxuIRatl9gn+qNQ/NgGZ033RgojWqbfTqQeySBZI=;
 b=9YYI/y3zGT94hO2jfDdxyFiWlQf//iiBC1y14zCRLRWd7eog/qpW5Y17kwKa1E9AHWtMUKkuE
 cCHRtFNsLCHCu2nmC0o96Dms78VVujln/I5K8fjnUxfIhd5oDcd7Wr/
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Currently we create symlinks like modprobe (pointing to kmod), during
the normal `make` build. Although those were never installed.

Add a few lines in the install-exec-hook, to ensure they're present at
`make install` time. Thus one can actually use those without additional
changes. As an added bonus, distributions can drop the similar hunk from
their packaging.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Out of curiosity: are there any plans about releasing v32? I'm
interested in the recent /usr/lib/modules (module_directory) patches.

Thanks o/
---
 Makefile.am | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 4062d81..a22d1b1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -111,9 +111,19 @@ install-exec-hook:
 		ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
 		mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
 	fi
+if BUILD_TOOLS
+	for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
+		$(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
+	done
+endif
 
 uninstall-hook:
 	rm -f $(DESTDIR)$(rootlibdir)/libkmod.so*
+if BUILD_TOOLS
+	for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
+		rm -f $(DESTDIR)$(bindir)/$$tool; \
+	done
+endif
 
 if BUILD_TOOLS
 bin_PROGRAMS = tools/kmod

-- 
2.43.0

