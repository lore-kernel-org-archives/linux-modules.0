Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DE3839B2;
	Tue,  6 Oct 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325113; cv=none; b=dQHMfnXhQhKcdeFLYjnOZNaQmMMC8333eGNRx/nD5qJ65gAJJmib39HDP3gRaVavdpfY8DQlOiW2imP0fWucS6/RurJZ5H04Nfd+G4vHJZPqVTsizb3U43RFDXbCLwWhsC63M9/JU3lBoj+HqxJ3F12/3V9Mu9Rh63JhQIK2O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325113; c=relaxed/simple;
	bh=OGA3idTNXhZROHziMCaC6ZlubDmLelD8Mc7M9kbqDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoMG5wo5oBbhcy15FA7Ep2ehnofcr/LC7mcTBrl5tnKJO2ZMR3VV9/PbW/sV5u0rcHtVp8y76utbppbltp0lsESQBiWLNTVkBK59GmT/nJ95q7g27/O+Z4cJiCSP/COCGtRhty/yG8FHejPJSiCsywwKXdysRL6YBcZbuWPOn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dVWdqd+J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dVWdqd+J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809C6169E;
	Tue,  6 Oct 2026 15:18:27 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 541623FA32;
	Tue,  6 Oct 2026 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791325110; bh=OGA3idTNXhZROHziMCaC6ZlubDmLelD8Mc7M9kbqDt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVWdqd+JrjtoiHS5XWYJdUrIgfbv6H6qN0ElbsqXdILe//sCfyoNyBbZ/RBZ3GUmU
	 LaHhKDcIw3WiKB5petIKo8w0GOl5jd8OlUSvQZNY14yyX4q1obDqNrmPqeOb9YvgL6
	 f28r1Rk3s/oG7jJJ/3BrOizaj7aSOB8ez0vpv0oI=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org,
	broonie@kernel.org,
	jpoimboe@kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ndesaulniers@google.com,
	mark.rutland@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	ardb@kernel.org,
	Emanuele.Rocca@arm.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 3/3] arm64: bti: Drop compiler specific BTI checks
Date: Tue,  6 Oct 2026 17:18:15 -0500
Message-ID: <20261006221815.2823252-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261006221815.2823252-1-jeremy.linton@arm.com>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Now that modules with missing BTI landing pads have veneers explicitly
added, the need for compiler revision specific checks can be dropped.
The link pass will correct the specific cases that both clang and gcc
now generate.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cab741a695f5..aea4c34a18bc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2196,12 +2196,6 @@ config ARM64_BTI_KERNEL
 	depends on ARM64_BTI
 	depends on ARM64_PTR_AUTH_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
-	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
-	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106671
-	depends on !CC_IS_GCC
-	# https://github.com/llvm/llvm-project/issues/215547
-	depends on !CC_IS_CLANG || CLANG_VERSION < 210000
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_ARGS)
 	help
 	  Build the kernel with Branch Target Identification annotations
-- 
2.55.0

