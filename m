Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAE13F435
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405563; cv=none; b=h4piNFHmLnwuNof7TmJafCgdhdBrRXkWNrfBwowgTAgjjLlx1kpN2605sBoxVziREGAOF91qXt95spLlS9KV6aHoOBh+OGXYMzM/yE/MYhUF8IIsntzZB9RBjAiu5b9V4ecnVz4S23v76Su68Y9FrzcJ23UzvFVaj5ofhv8602A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405563; c=relaxed/simple;
	bh=eV3qb5B+I1nDNQOkwqUHc7RO6Qbz3kjLk+d5HXT++yg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ta36JuWhWxB1tl7mPNYbUWbUH3eXzYCtwTQ2KQLWwUWpUXt4eSe/ZtoWRG8dTotqh5udSuf/Js3N/E+Rp+d12zO6ibgYGJTLvFPULZqkzhRaCrtFg56AJlgUfUhpwsXewPC3NAnXh21TLDE7SGjTiixDr2kQhPyOEIhVFtZK1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZK4kDTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZK4kDTC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C860C32782;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721405563;
	bh=eV3qb5B+I1nDNQOkwqUHc7RO6Qbz3kjLk+d5HXT++yg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SZK4kDTCh8rx75i0t7FvB2ZNZ8HFfA9VyrTYQdtIBqWfkj3dJoXyOIi/qn3BclzL9
	 v9IG/eogctp3KB17OCk+HQEgnAuHUy0Sz8uVbDyYz1aHzo3pEgODXS6ap2uRiqTbzo
	 M8UCRKwRJDquhNS2beWogmyEbKPGySjz6Tam/SupIr2rIM8vTxxltVly+7lqliwzNS
	 4q/0rZoC5Hnduq1+0R/gVdHbFLvkGsh1EjGhsHiTcJS4Z/Qnxd6Gnk6j6zwmSUn9/E
	 pHprgOCOzvBjSkz22zEqlhn1BfIyTHRGUqh/5hn1KOwpluB9gBnPlY1D/O+ju6hWn6
	 Ys2VmAVDL62Wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06682C3DA5D;
	Fri, 19 Jul 2024 16:12:43 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH kmod 0/3] libkmod: misc ABI changes
Date: Fri, 19 Jul 2024 17:12:40 +0100
Message-Id: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiQmmYC/x3KQQqAIBBA0avIrBtQCYa6SrQwG2s2FgoRiHdva
 Pn4v0HlIlxhNg0KP1Llygo3GIhnyAej7Grw1o+WHGHYBJO8XJEskQspbuwm0P8u/Afdl7X3D+K
 l1KpbAAAA
To: linux-modules@vger.kernel.org
Cc: Marco d'Itri <md@linux.it>, Eugene Syromiatnikov <esyr@redhat.com>, 
 Josh Boyer <jwboyer@fedoraproject.org>, 
 Yauheni Kaliuta <ykaliuta@fedoraproject.org>, 
 Alexey Gladkov <gladkov.alexey@gmail.com>, 
 Emil Velikov <emil.l.velikov@gmail.com>, 
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405562; l=1640;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=eV3qb5B+I1nDNQOkwqUHc7RO6Qbz3kjLk+d5HXT++yg=;
 b=PcWb4wLN548NuD7u1acnOtM+vH3kD+FNTQilSOgqp1eVc1t82LZd+2NFjBL4IjTx1MRGE2gem
 kDCe4SrrPAhAGti36MLLUVZAm45cjZzgeR/afLbXItBd3diq5kzBToI
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received: by B4 Relay for emil.l.velikov@gmail.com/20230301 with
 auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: emil.l.velikov@gmail.com

Hello all,

Recently I've noticed that new API was added into the incorrect section
of the version script. Thus the resulting library had incorrectly tagged
symbol(s) in the exports list.

As result I went ahead and checked for other ABI issues and I've noticed
that v26 and v27 have some changes in enum kmod_index. Although on
inspection neither of these should have caused issues in reality:

 - v26 changes the _KMOD_INDEX_PAD from signed to unsigned, all other
   enum values are identical
 - v27 adds new enum, effectively changing the final (non-pad) enum
   value. My search has found zero users of change and new enums, and
   single (abandoned) user of the kmod_dump_index() API (which uses the
   enum in the first place)

The respective commits have additional details and reasoning.

Personally I would recommend picking patch 2 across all distros and
patch 3, if your distro is shipping kmod version from git.

Cc-ing Debian, Fedora and RedHat maintainers - team, please forward this
to any fellow maintainers I may have missed.

Thanks in advance,

To: linux-modules@vger.kernel.org

---
Emil Velikov (3):
      libkmod: document KMOD_INDEX_MODULES_BUILTIN_ALIAS in kmod_dump_index()
      libkmod: correctly tag kmod_module_new_from_name_lookup
      libkmod: move new weak API to separate section

 libkmod/libkmod.c   |  1 +
 libkmod/libkmod.sym | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: fa715f8c8b78a09f47701ce1cf46e9b67a49b8d0
change-id: 20240717-abi-fixes-70771afcbe19

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


