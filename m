Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4255376A13;
	Fri, 29 May 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073247; cv=none; b=MQvsFsM6oWHTw+1BWJAb1f5tmh4sUe93Wy3kpLLSVdJKKdgur2isHOcgwstu+wRPAESNfM1EspI6UtD8ADu1oXoisRAxZc1zN2DWpZfQj1gUMYYyQ2BjEZSyUfgPrreDZMHHOMlc4ZcAvElQ4/BFqsipgrD+/lHxRo8YBO/BWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073247; c=relaxed/simple;
	bh=qEVchMN8v0+wSJWDNDy3B7C/easzG8SyBuV68bz4C90=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RA4ygFeCAmVlnP3Phr0F4yrsNYsX0k0VaR35lKS2xJwwV37bycjxl/KgluLvjU0UBRg9ysTtiIvWTZljR2pgF5ocA8SfcBcK4j3xaOzWHlLC7qfDTrdH8MrIDgjSKjge1Y08It8XpDU9ZjL2WNzNIJg7oxsCNyYUBrh17dUJNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=R9XI+hpA; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="R9XI+hpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780073240;
	bh=JVvGpZVbgfNh7wolCwvE0ghD3nqiaYT40C2yK739Pw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9XI+hpA7VQRt8YfW2NlbI+bwtYErbwAFIfb6gIKY3ReW/RXAyg5TLYoIbW0Iwenx
	 RSze0tZQM0f4/CoSd8OooMXhZgB+77lOSouebFQdWI0ydJHbq/yozjU5CndTEv+Iv4
	 3Dvin/PXUYk9jwIJeJZ0V+GJT5/PJZ2YdCl3pi/M=
Received: from LAPTOP-JJ91J38E.localdomain ([222.125.130.99])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id BD230674; Sat, 30 May 2026 00:47:18 +0800
X-QQ-mid: xmsmtpt1780073238t8ug9n6mv
Message-ID: <tencent_D9CDCA221D0AF5EDF260559734464D39B708@qq.com>
X-QQ-XMAILINFO: OedO1VJQO5LrvC24y5F2mOvinXoZ6aK1mrP8eIF0xMqf/sBGynbGIw8+ZegpHj
	 uXr2Ys3xkdz7wl83b1+4sFIKieCFkvtedA7hUChnKo41DRXmVccT0hrB0R6kZiSdbeTVaOAmgfRg
	 CHjoI/j1/3ikZT83M3mFOZqagrd1M5tQUvwWeqiMZYZpFNBXb8XcjeJzW7YVv9M012Ko3sQaP8+f
	 JLAX4dICv+vH5aY8xsICdHMEszd2iGxHHUC3tduxtWw0RGAhHwC7iy/Kpo3HKac0Rl037Khd2VMM
	 tsVnBGdn0dlZvZ3yhmlS0UR1vFlAVHiS1k2S25+VDgV1B4ZZQKEo2eeM/TxZIsAVW+HNfe01PIYn
	 FUJJnl5zPIVUDUQSK89JLpQ/MSuyUlGoPMjrcPo/0EerMzwkHNXO1agAM6saJ+k9R7oMlMgwzdKr
	 Ah3ku4c1Wt7XTelUfvXQLmbh8y5Ag+OpRsOhqiiXu5ndpF5MjoOlryLSE7rNDaoRXazxNKPfacU8
	 xCCi/Oqh7DE5Wc5dp04q3CdqAQgELSMQsMImh9gALZddJ2NGDC3FwL6CKpPYKzfDEY3Jh83dCEGj
	 /t7BJ5mYYiJvfFvsz2t3up4xvcLnoWkjqcGpCtV151RMI3yPYbd8aJcZ9/YkAQIkLGkGJMpUMv/+
	 VvxIYEWO0+ApKSSmUrXjleZDWL2acRaKS+upcGMQBuwvKaFAoBrsq965bMx/fSD2815zCJhLLsHv
	 KxTglrgdDANI0HTHJdIG4i2aSYnZl0wovuii+QxYkyQh1/Ajj4rNs2JzcF2kwQQW3HxHqkWiwacF
	 RZNULx6NWN8RfoboH3HEfgwCgwiRsPdLGk0zW8fOZf1YbPMpCK937juALTzDjqwONy2uKnq2ibts
	 /rDckhZhriedMySeRHLwWLlGzqxrFWwqeQW6FLG/eLkr77taCrkZy00YnIelBfL2rnbqYWGKjSmc
	 sGZe1xlg4o9vGGSJue4ljYOycAoRRPTzLOVf0OeCORAqnSRg5A/8MVFMvYIR+T9Y0d8QzZVUSAVH
	 mqFQiLUxforjkPscpERfCXAOJNybFquJhdj7Sj9hWde88zhTfg+FwPQ05tpWi2pOLxAiVH9atli5
	 dLYny+Bcj6qI/GDUIYaBK+Iu5rf3uwmB91nSdl
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Egg12138 <egg12138@foxmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiao Junzhe <egg12138@foxmail.com>
Subject: [PATCH v2] ARM: module.lds: fix unwind metadata for merged .text sections
Date: Sat, 30 May 2026 00:46:08 +0800
X-OQ-MSGID: <20260529164608.1870192-1-egg12138@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_69DC6E2A5B77E4D567CA4F552DD3A835590A@qq.com>
References: <tencent_69DC6E2A5B77E4D567CA4F552DD3A835590A@qq.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiao Junzhe <egg12138@foxmail.com>

Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN,
and related macros") made scripts/module.lds.S merge module input
.text.* sections into the output .text section.

On ARM, the paired unwind input sections keep their original names.  A
module can therefore contain .ARM.exidx.text.unlikely with sh_link
pointing at .text, while .text.unlikely no longer exists.

This is a valid ELF relationship, but ARM module_finalize() does not use
sh_link when registering module unwind tables.  It derives the target
text section from the exidx section name instead:

  .ARM.exidx.text.unlikely -> .text.unlikely

The lookup fails and the unwind table is not registered for the actual
.text range.  This can make module stack unwinding fail with:

  unwind: Index not found

Keep the ARM module unwind output names in sync with the text sections
that scripts/module.lds.S now produces.  Coalesce the .ARM.exidx/.ARM.extab
section associated with .text.*, into the
stable output names expected by the existing ARM module unwind code.

Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
Signed-off-by: Xiao Junzhe <egg12138@foxmail.com>
---
Changes in v2:
  - Quote ARM unwind input section patterns and split them across separate
    linker-script entries to avoid checkpatch false positives on wildcard
    syntax.
  - No functional change: the script still folds .ARM.extab.text.* and
    .ARM.exidx.text.* into the stable .ARM.extab/.ARM.exidx output sections.

 arch/arm/include/asm/module.lds.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/module.lds.h
index 0e7cb4e314b4..19ceb8cf235f 100644
--- a/arch/arm/include/asm/module.lds.h
+++ b/arch/arm/include/asm/module.lds.h
@@ -1,4 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef CONFIG_ARM_UNWIND
+SECTIONS {
+	.ARM.extab		0 : {
+		*(.ARM.extab)
+		* (".ARM.extab.text")
+		* (".ARM.extab.text.[0-9a-zA-Z_]*")
+	}
+	.ARM.exidx		0 : {
+		*(.ARM.exidx)
+		* (".ARM.exidx.text")
+		* (".ARM.exidx.text.[0-9a-zA-Z_]*")
+	}
+}
+#endif
+
 #ifdef CONFIG_ARM_MODULE_PLTS
 SECTIONS {
 	.plt : { BYTE(0) }
-- 
2.43.0

