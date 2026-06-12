Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF353E44F6
	for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271612; cv=none; b=mnSyp7RubU1ONXyldkSY1FC4ebHjhZnMGpAJXb6WFeAl620WGiQTdSECoZE18MWW7oL/tnmKSwe1RB1tF3qFIbtVJt0+tiIwzT/Cn+NCTcZDZU0UxD1jpzwbeQC+7PvittB56098yasq8MJ0XKN2BRV8uFaK/NiY67aGJpk0OP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271612; c=relaxed/simple;
	bh=UIrRs12LL5CTfXbD3P6IRPSSbzDrVy25AnHR4B+OqKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fS2tcd3neltUgEiCidknE8UjkGO7mOabfTaBOpfMIvn3ZjFFwIF3MOsyvYHdoMj4vcGjSbvyjmcTpd70Dep8lJgckdC8YVF5kJB8uuuNngZb4OIAGwkTTh5tCZT/ubBTpMzIMb3yitNTGL6itjKHzAs3WHI4XGuFYNDsZuRd4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MhsQTMl6; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MhsQTMl6"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso12475415e9.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781271609; x=1781876409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6JTTjVI9OwnAGFeLH1RdNCyLRQOtyUh+DQZ+OgYrh8=;
        b=MhsQTMl6oRGILjrom3+VEKzAF8IxxQzvXLa5yRZ7ljZUM0CI2ojAZmagh98eY63vFN
         PMEncSJFDkppvy2whvBuUYISLPRTPoK0CDBMgGBejwsYbSBaf3J0c4WWGGKWdj7gb43U
         Ie9Q1GGoYIoR5UmKz4YJg0WVotO3lPbV/IS4Fngguob4mkQqM3E/Ozn6kMsJZkUrn/ci
         tlfqd1LhEotNCAl/2mzATTyeEaf8wmmBNuuXeIeIcGmJW0x0qrDaaoki/DUiXpnbcstC
         Gfzl8jKXBCgH5ajHoYAjeAPJwXl07rPR3CAX0sJc1NsqshE5Au1Xf5PIeAKMJj/4MxmJ
         DE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271609; x=1781876409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6JTTjVI9OwnAGFeLH1RdNCyLRQOtyUh+DQZ+OgYrh8=;
        b=BGd5zcBKYijn5e7pEH9DhtbGqMUsFDC0bCZ1ABzDraBYCAn9rnFa6y8pQRppQeVSo2
         f3RtWpdypCtiCYhspeeO6KP1DR+N1wwi7WnTYb8rcFgYBBayqUp+ipabqCJjt028gXX6
         waaxlLXgf27BNZEnC4U2wGhUFTqX7Gvs95KvAX41JrRHJ07k27BKZ0qvxEsjvkletPnj
         G/MDFEXMR7QxyavUxgLAXt/csck0juCfCoRzIQ16utO2y9lhUeVoMnEc/FY9LG9jgDTC
         Cim7FTGtKTB4DluoWGsdYEC8yqoaqzkXKECi0necKw9lCK1Jq3iJTEmyIYA70N3etCtA
         WN4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+m+WEWUSTVBitxqkS+fROLDcZgeWbkT5GQJuhQg+iVfRTQZnF4mNdk/nAKqNNBAjdSwKRxn2mTLWDh/Dqr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gH+vlUdIgQfLfXAs2FP3iqWWs31zNT9EG18aCP4SjuEKkqq6
	WJqjyg0aNbo6bAF/U0dGwJhQMWwyKnrdMcLzHmRJPLGVN3K49ntQ9JmsyhznEiKjiJk=
X-Gm-Gg: Acq92OHR7CVhYbK+H6ZQ4dgAzSfC7MSNWxYC/V28LjSfUaTRr7aE7DQ+tqYwePFBiSR
	ZMfknZz+O/7nRPr2bnE2avBvOQjHbaQyau7gQRUZrK7Zo2/4H+I/ZQoclQtQEAug2r2CEHCxHR3
	OS0FjJLUtNON1BVEGjTOXM9DhDrLlVLKbNnVtSmKxg0wUVsLUQUxYy7khcIiYa0OD1zOl/x60Jw
	vmKB3ITcB4JoBJOrcXMsZ35q137l8Md/6p3uhHeLCThFlIXEWZl34xezHRiXg014gBDb6OFHnRl
	2n5C05UKat2/rnLjibbeR1U/PLlTCAT8MXScGjyDXaseCmOhDscGuhV/66CuXE+vd6bm+FEMUT8
	fvP7P0Pr6NVDcg5J4vYvTQNKhw72Zzc01zUI0m2MCTNE8iBZimIbP5cvKuh/1ikMUXZo4hKBRFF
	/+on+rI2EvI47UpXY7BSTLljg3jjaqN8vg
X-Received: by 2002:a05:600c:2d84:b0:490:c2a3:1781 with SMTP id 5b1f17b1804b1-490ec50a93dmr24906465e9.34.1781271608716;
        Fri, 12 Jun 2026 06:40:08 -0700 (PDT)
Received: from zovi (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm44016335e9.2.2026.06.12.06.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:40:08 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove unused DISCARD_EH_FRAME definition from module.lds.S
Date: Fri, 12 Jun 2026 15:38:28 +0200
Message-ID: <20260612133920.1919352-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linker script scripts/module.lds.S contains an unused DISCARD_EH_FRAME
definition introduced by commit 68c76ad4a957 ("arm64: unwind: add
asynchronous unwind tables to kernel and modules").

As shown in an earlier version of that patch [1], DISCARD_EH_FRAME was
meant to be used by SANITIZER_DISCARDS in the same file, as follows:

-# define SANITIZER_DISCARDS	*(.eh_frame)
+# define SANITIZER_DISCARDS	DISCARD_EH_FRAME

However, in the meantime, SANITIZER_DISCARDS was removed entirely from
module.lds.S by commit 89245600941e ("cfi: Switch to -fsanitize=kcfi").
Eventually, the mentioned commit 68c76ad4a957 only added the new
DISCARD_EH_FRAME definition to this file without actually using it.

The file include/asm-generic/vmlinux.lds.h contains a similar
DISCARD_EH_FRAME definition for vmlinux to discard .eh_frame sections that
may be present when CONFIG_GCOV_KERNEL, CONFIG_KASAN_GENERIC or
CONFIG_KCSAN is enabled. Testing these options on arm64 with LLVM 19.1 did
not show any unexpected .eh_frame sections in modules.

Remove the unused DISCARD_EH_FRAME definition from scripts/module.lds.S.

Link: https://lore.kernel.org/linux-arm-kernel/20220701152724.3343599-2-ardb@kernel.org/ [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/module.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b62683061d79..d0f200428957 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,11 +3,6 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
-#ifdef CONFIG_UNWIND_TABLES
-#define DISCARD_EH_FRAME
-#else
-#define DISCARD_EH_FRAME	*(.eh_frame)
-#endif
 
 #include <asm-generic/codetag.lds.h>
 

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.54.0

