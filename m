Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4340757A
	for <linux-modules@vger.kernel.org>; Mon, 15 Jun 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538924; cv=none; b=FZ3I0gaMU/rceShz4eMdnsgTyZMQ5MbayccpYvX8Io2bKQqHN/2Yn9poptoTH/gSzyRHjS8veTRA6evl/NmwqwFCwnDsb/ZWYztP+459dl4fb2GaKGEXt+RSTy2HjmV5qg97B3YoZp9DITkkyVNiLvIXkyul1q/c0jAI8MM3X84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538924; c=relaxed/simple;
	bh=3+dxrHg1ZJR1tusn3ojkvN/GyoLVlx3fWUZmki2H6ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XCmfYe07JLXYt8YVAfsGVUzWIBBIRl0MtV7ky3cQs7H7pyNVxn89LFlMgojq2TBNSNfKnxlAIjH9Rd88HNtkD9vyxjLijA2cK3z6VH6qwTxw/qf0lbJ8tbhd701PV7hs5PSVdvcJZ9EsKjDm8XvbKE4ghx+7QhFSkPfcZ9ImPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7FeIFHT; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7FeIFHT"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30762d67a64so4969938eec.0
        for <linux-modules@vger.kernel.org>; Mon, 15 Jun 2026 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781538922; x=1782143722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67Hzt7ozQfU5utqZfz4c7CGkXUWKHlB1RFb46NyLcaw=;
        b=N7FeIFHTLtF7bjOulITfA1yDwJxS+opFz3EF9I5dOyUZWvWovw47wZ7qovwdglDD/f
         twzAll5SkKYiofMyIYomZIgVtUXwT1pigFVPOjTVy19PhGxo4mPSC9dO1N1y0957jZ4B
         +fjqw/lE4pXCi3FgpTCoMRO/rDRKOUSwlHK0yho38Y3CGyZkY/i58mVOBOfj3ffCD+2V
         l9TNo4oUD9XRTY+qEykFQKXLBkbSSjVKizlIseph9Go6WApGhMWI31zqGWw7XAbLKwPX
         BwanOlgvLguX9tos9BQH99vKaGGAYUBH0FO67Li8IaWNB7sWnJpqnCwYACis+1JFJx/6
         fj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538922; x=1782143722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67Hzt7ozQfU5utqZfz4c7CGkXUWKHlB1RFb46NyLcaw=;
        b=G168W1y0zux4Xu7NvDmPimPWZeUjR8XKdbSwZ0CJPHyBW8P/4rZmvp83WPXp+hyBxC
         GgVzin6Bn2k4AcvQ3jY5mtZJydw3qRx3EBMyy9tW1/ofzp6jeiyneMJbHjyWtuUpV0iB
         L4TzZrCrbeFduuZRec24cipL1pUc+81w0Ig0KTTh83kroNovU2NAYO1coB59C0COV4Kd
         k2xi4zP/qNkmDXYuUIwSAo09MJyUVOqfrjMWib4Yh2wFW3LuHlry1Lk0nAvuEUIRg+Wp
         KnFeeJ/JiKCJ7jeTDxvijXh2QQjKqn3CSJjsZI5+CLMVzPaIvvAkCVHIRuW1E0xlpUr1
         lD6w==
X-Forwarded-Encrypted: i=1; AFNElJ9tQl+Rmg8PYTbEWiZefU6nDsMb7XNYwt1CbAvI6kwOLMFzP43WaH+o/3isveKPzNyXB+4ugvGqEZp3uQvd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9sUA7Ab4f0oNdcHJra+KW3CTtlbiE1l7kXNgYofJENF5dGTi
	ZBt+kxP/jQPnMNWErXUsQC8PRTLyLiLCES1PcklJr+6WGWTnLlh66pqX5M4j5wDunK9pmhAySjt
	dGmFgwdHSGrpAaY3121rX49vek7NUzA==
X-Received: from dybgv28.prod.google.com ([2002:a05:7301:231c:b0:30a:e5d4:1786])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:aca5:b0:304:dfb2:2274 with SMTP id 5a478bee46e88-30820098ebemr8273948eec.28.1781538921903;
 Mon, 15 Jun 2026 08:55:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:55:17 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=samitolvanen@google.com;
 h=from:subject; bh=3+dxrHg1ZJR1tusn3ojkvN/GyoLVlx3fWUZmki2H6ro=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDFkGCmnr3N8b1f73Co76uppTJXrfr2XGLtL26zMCz4idm
 X43LyG+o5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEzEZyPDP8upWQ9FRN5citRY
 LZu989NpBll3vWidZ7NK+kK3emS9cGL4Ky1YMn2L3YryzjMTRfxast/WLinVer1+7wHlp/p+TLb vOQE=
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615155518.3644770-2-samitolvanen@google.com>
Subject: [GIT PULL] Modules changes for v7.2-rc1
From: Sami Tolvanen <samitolvanen@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Andrii Kuchmenko <capyenglishlite@gmail.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Kenny Glowner <sisyphuscode0311@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.2-rc1

for you to fetch changes up to 36d6b929bb0c7cc1cc742d9b5805537d3b651094:

  rust: module_param: add missing newline to pr_warn_once (2026-06-04 16:42:34 +0000)

----------------------------------------------------------------
Modules changes for v7.2-rc1

- Add a missing return value check for module_extend_max_pages()
  to prevent a kernel oops on memory allocation failure.

- Force sh_addr to 0 for architecture-specific module sections on
  arm, arm64, m68k, and riscv. This prevents non-zero section
  addresses when linking modules with ld.bfd -r, which may cause
  tools to misbehave and result in worse compressibility.

- Replace pr_warn! with pr_warn_once! for set_param null pointer
  warnings in Rust abstractions, now that the _once variant is
  available.

Note that as part of our maintainer rotation, Petr Pavlu will be
taking over module subsystem pull requests for the next six months.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

----------------------------------------------------------------
Andreas Hindborg (1):
      rust: module_param: use `pr_warn_once!` for null pointer warning

Andrii Kuchmenko (1):
      module: decompress: check return value of module_extend_max_pages()

Kenny Glowner (1):
      rust: module_param: add missing newline to pr_warn_once

Petr Pavlu (4):
      module, arm: force sh_addr=0 for arch-specific sections
      module, arm64: force sh_addr=0 for arch-specific sections
      module, m68k: force sh_addr=0 for arch-specific sections
      module, riscv: force sh_addr=0 for arch-specific sections

 arch/arm/include/asm/module.lds.h   | 4 ++--
 arch/arm64/include/asm/module.lds.h | 4 ++--
 arch/m68k/include/asm/module.lds.h  | 2 +-
 arch/riscv/include/asm/module.lds.h | 6 +++---
 kernel/module/decompress.c          | 2 ++
 rust/kernel/module_param.rs         | 3 +--
 6 files changed, 11 insertions(+), 10 deletions(-)
