Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D9205AC6;
	Mon, 16 Dec 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369920; cv=none; b=iFbmhBeq55VhvJJgW3e5bsCYrALJBFx2WaFFH1L5GWn9Xsown11Iqu2iPrmj4gZU13Kbd/5CHvkvjw+a1wLxG7ghcwr5FPM5GDRdoZflwU/In4SIMSXQS2P6hcV4XGFyFZkyuw8gJ6NcWTxMgq1o1qnLBj0nOJM6ia+/eRSHnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369920; c=relaxed/simple;
	bh=JMuY/G0fdEjczfIjku1CPpiokstOqby013XJSroMCn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ipcrA05PYl3+8L3ps/v1Xk+5+1xVnooXpZM6tHR+ARloYSRDaJr1lKmp/s3FEWdpCY6Fc0aDTS+PVIn8pP/zyx8ISlCICKnmrdfQasSZA5fUq08uqCFOVIP5MmhS6UE6CFJ2zwR0AIQLtKOX6NSeU2BvNRRhwTVqznIowGTdJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uBrjNCFT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uBrjNCFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734369915;
	bh=JMuY/G0fdEjczfIjku1CPpiokstOqby013XJSroMCn0=;
	h=From:Subject:Date:To:Cc:From;
	b=uBrjNCFTxJt8lQg5p95MMxD2LdFaOd/TVt5L6eFueX0HMbBPTZrva5q8PZ1MonXDV
	 D5QsbEX4hCrXFErj4phxK/YI9o3R+NSnE4bR6vADIFixLBS+WFy28ys7gn7/j1iW2I
	 zoxt7Rdub9vln7mCM5AbltEyWvuSZzkpb1k9PCsw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] module: Constify 'struct module_attribute'
Date: Mon, 16 Dec 2024 18:25:07 +0100
Message-Id: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHRiYGcC/x3MQQqAIBBA0avErBsokaKuEi0kxxooDceiiO6et
 HyL/x8QikwCffFApJOFg8+oywKmxfiZkG02qErpWlUa5RYnOAUvCU1KEbdgj5WwU61x1DZkjYZ
 c75EcX/95GN/3A0/OVQ1pAAAA
X-Change-ID: 20241204-sysfs-const-attr-module-927afe76eda4
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734369915; l=912;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JMuY/G0fdEjczfIjku1CPpiokstOqby013XJSroMCn0=;
 b=bKGYvzz66XRfASDzNffmlEDLNhE1uJpYrG1KbsM1RhenlkbHXwLd0UYXUfmhrTQc6m341G/AT
 EN6cek9sYHrB3pj64nZ4nbQRIiSES/Oypl3vixRwgxo1iBoRnEyz9l4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These structs are never modified, move them to read-only memory.
This makes the API clearer and also prepares for the constification of
'struct attribute' itself.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      params: Prepare for 'const struct module_attribute *'
      module: Handle 'struct module_version_attribute' as const
      module: Constify 'struct module_attribute'

 include/linux/module.h   | 10 +++++-----
 kernel/module/internal.h |  4 ++--
 kernel/module/main.c     | 40 ++++++++++++++++++++--------------------
 kernel/module/sysfs.c    |  4 ++--
 kernel/params.c          | 22 +++++++++++-----------
 5 files changed, 40 insertions(+), 40 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241204-sysfs-const-attr-module-927afe76eda4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

