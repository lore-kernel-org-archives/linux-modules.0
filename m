Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427E481FB5
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111694; cv=none; b=liiaU4QedAHN6Jvn0MzAHIezUJo2HPkex58EdlZXu3YhjlwVtKKU78nCiiU7T8GpFoMhlQRq0g3lTtVtTd7iaHd++Hs1jMOw1pqtCC/4TmdyVL/ocq7FWwIEmdxhneBeCbSXIjzvG41LPXQnVt6byDL1xHTtlZNWftn57iph8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111694; c=relaxed/simple;
	bh=0GMy557X2yIPxBvMxVdGjzD8em/l/TBASpj6hxhrv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sG+3jz4zAl9XVw8hVqqeA6WABMmnQoe3275+sFS7zwV4k7OCzehzJscxMk9cZBL0tGMQcc+b4HoQ070DjpIYUxrnORaerwR3df53ju+9pFl1BX/wWscB20inu+C31UN5skYPlmJAvUF025lS5j6wmVcJMloobobHWQfHh59mcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQt8fH/+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQt8fH/+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso968779a91.3
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111691; x=1779716491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ1AlD1AM21fm4X96F6F2/fw1jm8rVL0VNrv0bCYenQ=;
        b=OQt8fH/+sG0QcNDMPZMk0OAxRTbC97PmpYXNaoSCSq3B3RY2PzXPBcuy9AR0WYl4lL
         Wbf+ta2fK/+BV+Wxgx5fgYFVl6QqzMpBMC6poICpnIKrxRlSoyYh6LZE4Frj2biIFwqJ
         2MzN+nlgi7Mtffn3rqZOqDNxtAoCrLX2J4E2g7yogzrgc9H+vNEhMsQAKlxSBGItdel+
         eRjcrTqXaFqJASzrc48+1+KZgcA2U1yaQnLVt4XRIPY0Nh4+0gQ9OIHvRr1OYiWaOM1S
         mWNtxh6mHuPZ0FnfzBN7eZneGGlJKB+mmLZ75VmvuUyKApUaI5F6oTARa6MRHcJXFv1/
         43Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111691; x=1779716491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ1AlD1AM21fm4X96F6F2/fw1jm8rVL0VNrv0bCYenQ=;
        b=dzaUNQfBz77AUxeUFxoiiOZLzpcF7I+1Z71Szsy1NlEJOTGgX7XlItl5eIY1/Moroy
         hw0o9B0a7SkLc+dHGEWSrF62Y/G3R5110voFJMBWyiFU8OJQKLCyNaDPjumTeTEHIMLk
         qgUIffBFjHNYExYp/osiglutRuzPq5Ax9rcZR+yvkjV2CigkHQiD1gCsATuwQuRENf3e
         X9+yKlcbHpFA7cSmTovgTUafYIS4xJUCIcKNhYs6qW6bIlfSh7etga1vUyND7sAOmdA2
         n50mWjSIpV7kWRZg1pkoN2QKJx6arf+97wzotDHGCPl8MrFXgIEG08jMr22rtc5xCO6U
         I0ug==
X-Forwarded-Encrypted: i=1; AFNElJ/5o6oiK1LCvKVmAHZNVfNni+5T877Cp9xPZSXtmDcQfdjXOsDvuGmXApwCZzVfJoW6Q3wSZLZh8BEINpl2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0W3kDwXuM9ijYuT5ptKQZ/xIoC4Lt3QJkd7vgdIcCSTE+jh3
	DK+EJ4Q0G5IKvvnBMvKovyt7rYuP8NeWAR6VdfFpOs2p5x2+iaZN04Yc
X-Gm-Gg: Acq92OGHTcltxd2RFLSXdOiggmzooztzydedBJQGsbR0e2joqlYexMtSSPyVqly4vvl
	PhIRE5EglPE75KOC9Eqfufka3iNHUjUr+u1NIQIhazmP6R8iQip+rJ8K4fV74aYVmwQi08fQ4LW
	ITszLHLyHLmf3pz1uqjboP97HEpUpY7+nOz+NElDg4ZQ7GLBU3E5u4r8SXWlJYvwt6OXL/zIcLv
	iMErVARck4lDVhsAouKwqtlX/ygcO25/C6lsEp8BFAqbY0njAkHADwKRKbUsQZSrkRkKEVgk4Zt
	aXC9rWw3zKRWyTUvFAuVFArYnMpB8Ra3STdAmWegjlu/vADWtNZRjstPFIQC7AlTMdFakWUEnba
	V3u39YD266Nc7u3zHHnF7rAmgW+yULRbGOFw1fGtXC6bhqFkCL8x/dETxVupmnqQbuclBFZTxqh
	TTuXQT58nWm88tdFI4rsRAc982eBr+VFNuF5ZIUMAb+BMEQ2riMg==
X-Received: by 2002:a17:90b:38c6:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-36951b860a0mr15275923a91.21.1779111690695;
        Mon, 18 May 2026 06:41:30 -0700 (PDT)
Received: from localhost.localdomain ([117.30.62.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424b2sm10934575a91.3.2026.05.18.06.41.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 06:41:30 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] rust: kernel: module_param: replace pr_warn with pr_warn_once
Date: Mon, 18 May 2026 21:41:07 +0800
Message-ID: <20260518134107.4114-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pr_warn!() with pr_warn_once!() in module_param::set_param() to
avoid flooding the kernel log when a null pointer is repeatedly passed.

The original code had a TODO comment noting that pr_warn_once should be
used once available. Since pr_warn_once!() is now available, switch to it
and update the comment accordingly.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 rust/kernel/module_param.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875..fedb709fa 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -62,8 +62,8 @@ pub trait ModuleParam: Sized + Copy {
     // NOTE: If we start supporting arguments without values, val _is_ allowed
     // to be null here.
     if val.is_null() {
-        // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        // `pr_warn_once` is already available, use it.
+        crate::pr_warn_once!("Null pointer passed to `module_param::set_param`");
         return EINVAL.to_errno();
     }
 
-- 
2.34.1

