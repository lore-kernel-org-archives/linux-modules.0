Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676736AB5A;
	Thu, 21 May 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379092; cv=none; b=B1oCVD6uxrrG/i93B4o/M/d4qEzC35BGB2fhw7gBEnWf0TT2ILkKjYA3k9BwjSJnQeHiZjSvNCC+RgcSixAv8AzZYPI6wf2W4eAjdp/+I0pccjRM99dYp+5n41R8vRcMGCMKKLWcwhloM5TZl/5oZzqY2/47JnmRpsWW2cyAGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379092; c=relaxed/simple;
	bh=Ld+DGrzkTuQen17g1tuF/0CHgbVjnxCe56GF9uyobho=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TGuZjBkSsBXIujrwoojnfAeAVJvdhVIPnuztkPGI5xqMmIDK1C4exjOTmHuLxZ/BG/8t3QON289D4DrrTI5nvyM8RDD4a/FLvjTEERLiTzL0VfKjUjcyGyHl9icsirxey5RfZTcQZigeo+QJQdN1qstqT2DmsVMNqLclBGnX3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xM7DFqLm; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xM7DFqLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779379077;
	bh=ytrHI1NAcV1X0TRAEuLH3Qut13RJxS0IznS6P86zRXI=;
	h=From:To:Cc:Subject:Date;
	b=xM7DFqLmbgXusspiE15/iu4WLkTuAtjgspMk8uXOHMcXzq6MNIehssc8CLzNKNDit
	 I0/4zgFuYjpEumI8Msw5tD9hEmtTeYuEKzEnfmS763hsrMTg5fJmRl1lWq2rCHXKSk
	 WztukGKxISYnf6I5khx7j3a7ZzkHcQp7RIqaOQ54=
Received: from LAPTOP-JJ91J38E.localdomain ([222.125.130.99])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id E77A8EE9; Thu, 21 May 2026 23:57:55 +0800
X-QQ-mid: xmsmtpt1779379075thg884qg7
Message-ID: <tencent_69DC6E2A5B77E4D567CA4F552DD3A835590A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznY8aeuYkUt7jNUdYLELDhEQzJByuH55MeT06gyCHyxpTBwJI07h
	 oovc7YTCwnTGVXFHFMPQnXLRkizYoRXiP+2Hj13D4ltmYMrenZHnx0fX1rcUH8bldNoNvrh345Kl
	 du4Kl0PShCb2KYoSE/eqN+OuKu2UnRqLW11GZy1bz50/YdxZcZ08bWk+nf9xLo1JcqhOXDbozwqk
	 pGdnLXN+Idbf4houwfcF9HUPrhMg812nfTO4i9Iqdcz5nCV4gJfh3GGnHiPiK9y395J+4MlMQY80
	 qOtEOposP2PfeItTi1gOp6ou9u66J8YTvSHEE5Q3fMOvoQJRVCeLf4Izf6vlIg3Dkg7y5sbhB03c
	 92hlDtvVmBGd/bOiNXEsCk71B86xQdGYQSfXDGa+/PBFa6Gkh6FprIf6iaGJyKL/SPZVRjL9TUQq
	 1aDR38MgumR8V2QPF/M/Sdwv7OeiYiQmBRyT5Uwop6LFoW1U9IDfmGO4U6qbl3RF7SRLUnXZRpmz
	 H6uGnQS7nCWvThtmainSJYa4ztGH0wEddPViB4WZvRzIoYORgRetV+OZdh0nFmZyFapcKJgc++ft
	 u5oALwm+TRG3Aor9RYrIpKbvz/NChCyQ87+1cjTCmF03s+6ExkdY/wMn1LvXkTDMKPHmTJZB0BmL
	 KRNcUlwFlUnwdkHViLgDxP6RCqnkGw7Pl6wiFSczAMW4VAVi57AJWcenlOrjp5M1Z6cIBJaSIBby
	 dHuCQB//5SebKcdIc+GUcJ9TTxObknDrqj9N3+vIwmcruOmmId4Z4uIfv0qIXNph5397o1dtJQVz
	 jRBU+zLPkVczuG+T0Mes11eISEgNTIiMkZzJezWZP3QUn9cbDSUYByLfjryHXV3iAlnXNAHe4Twg
	 L6UdbNFcmGcY2MWJO9IqWKZJJfYb1ouzdUh7wUbmRsAMw2fd3UBVf7ZK2eq1QG7fPbfF6I48NuJ4
	 5oFymP1kXnYP9d2WmBV7xClFpuhu9kt9X66tZpL9IuHqKtcyfVzooRCBFLepJmwkINFnLWxEUW03
	 dZPltvt86UaQFp+oZyKqs8bUVoUaRJ2oKaX00004IP+dG0kWpnr4yKLTupFkurz/DkUSFA7bYApq
	 qukXRm
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Egg12138 <egg12138@foxmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Egg12138 <egg12138@foxmail.com>
Subject: [PATCH] ARM: module.lds: fix unwind metadata for merged .text sections
Date: Thu, 21 May 2026 23:57:53 +0800
X-OQ-MSGID: <20260521155753.882044-1-egg12138@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
sections associated with .text.*, into the
stable output names expected by the existing ARM module unwind code.

Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
Signed-off-by: Egg12138 <egg12138@foxmail.com>
---
 arch/arm/include/asm/module.lds.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/module.lds.h b/arch/arm/include/asm/module.lds.h
index 0e7cb4e314b4..dc9adf8fa50e 100644
--- a/arch/arm/include/asm/module.lds.h
+++ b/arch/arm/include/asm/module.lds.h
@@ -1,4 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef CONFIG_ARCH_WANTS_MODULES_TEXT_SECTIONS
+SECTIONS {
+	.ARM.extab		0 : { *(.ARM.extab .ARM.extab.text .ARM.extab.text.[0-9a-zA-Z_]*) }
+	.ARM.exidx		0 : { *(.ARM.exidx .ARM.exidx.text .ARM.exidx.text.[0-9a-zA-Z_]*) }
+}
+#endif
+
 #ifdef CONFIG_ARM_MODULE_PLTS
 SECTIONS {
 	.plt : { BYTE(0) }
-- 
2.43.0

