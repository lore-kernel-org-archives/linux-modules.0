Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEB193;
	Thu,  5 Dec 2024 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430007; cv=none; b=L+JUh+0u+6XYIDccNFoYkNX5RdvSu44tFR1DTfHP5yN/YdhOG/pBYPcYMjzPBb8pAaeRfNr3Ky7d8lNq2T6xTzig/KlUGNDM8fuksTX7hghX2VwjG+UhDBe782uhdOsAx246fn58bm42xwC2cqbs4IXWCYeD52Q96HpfABl+gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430007; c=relaxed/simple;
	bh=0Ik/La6fiJDqxdpFhmvedz7JJ8k3PvlU6Zx+R4WTeCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx/4dlBoixKnwoYoHJbw4Y8xK+EFisGVpOd2CypzaWFl84lFNsCrkNHUTMNtdgkioqJxLP94i5qU6EFNT9PIT3i0D8xOVZQJ/wk7XpOy8EpxmrZOu5SxNVqB7dldCFT6yar2igzwkJ26wRV5G3kxQoidzFYyOr6+Dw36+ljaSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y44dS3jgSz9svh;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qM-r5_4StcUP; Thu,  5 Dec 2024 20:46:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y44dS2vPsz9svg;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 521E28B76E;
	Thu,  5 Dec 2024 20:46:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ks_Zn0v5uQ99; Thu,  5 Dec 2024 20:46:20 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CED018B763;
	Thu,  5 Dec 2024 20:46:19 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1 0/3] module: Don't fail module loading when setting ro_after_init section RO failed
Date: Thu,  5 Dec 2024 20:46:14 +0100
Message-ID: <cover.1733427536.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733427977; l=1050; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=0Ik/La6fiJDqxdpFhmvedz7JJ8k3PvlU6Zx+R4WTeCY=; b=l+Nsh5GmVR70t5fKC5sB3+TP2+wyRBT3HI4Q4eqKwH4kdyuTblSRbAP7wNyKVBngQkZNpDZ0A 5jjTRsDliPfCobJZnZgegjsNVCk0Tm5gMpTWd6SIhkBdMsxhQFgTL4B
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series reworks module loading to avoid leaving the module in a
stale state when protecting ro_after_init section fails.

Once module init has succeded it is too late to cancel loading.
If setting ro_after_init data section to read-only fails, all we can
do is to inform the user through a warning. This is what patch 2 does.

Then patch 3 tries to go a bit further by testing the ability to write
protect ro-after-init section prior to initialising the module.

Changes between RFC and v1:
- Patch 2: Fixed comment from Petr about __func__
- Patch 3: Expanded the commit message based on feedback from RFC series

Christophe Leroy (3):
  module: Split module_enable_rodata_ro()
  module: Don't fail module loading when setting ro_after_init section
    RO failed
  module: pre-test setting ro_after_init data read-only

 kernel/module/internal.h   |  3 ++-
 kernel/module/main.c       | 13 +++++++------
 kernel/module/strict_rwx.c | 16 ++++++++++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.47.0

