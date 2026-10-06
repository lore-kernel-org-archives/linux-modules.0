Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A836F908;
	Tue,  6 Oct 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325112; cv=none; b=iuXjV6bWIyL/epFkr6WwxZjckGWOn+cgcPhKc5gFnmYb5WWXw93WTnwuIZnefzGnbUHLg2i5LX3YjyjMZ403xJ8aDb5dCcPPITt0It0d+mREc3r0t+uHltKH2mUUR04QfRXvajsBKSF6CD175XWRQz7tu4/MDuBRyG6gH27d90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325112; c=relaxed/simple;
	bh=4a2f0Q6XSzawwAhdB0SXoCS+iLVGBAyTHhrXtzZaQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBHajyIycpEMOdq7qKuZBiPIh2i+UlHSlhZBNbjD0O7pAa2O0UAIP3oqwaRnQ2ZIIfV0tj1cu5+Sz2khejC90OMqGq+AY9ZJYy4kUuGzQGNiiQgO6S9g5XY54Ei+HKlinTFFoimyVH8twVf8vDzm9+xKNiSRXonSQIw4YAQ/BqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rqJsZowm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rqJsZowm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B707143D;
	Tue,  6 Oct 2026 15:18:25 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 667E83F66F;
	Tue,  6 Oct 2026 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791325108; bh=4a2f0Q6XSzawwAhdB0SXoCS+iLVGBAyTHhrXtzZaQN0=;
	h=From:To:Cc:Subject:Date:From;
	b=rqJsZowmqULJ0Yg2n+F3lEUplKMEHuksjD4Gk++TXT2dGUmhHsX1izVG4s7Q+QWkK
	 iGo/HKv5ETgpP36E3/6Yo696SEiz/tH0h2cBGY0373nwuknhRXWP2euUGowGvouyN1
	 3jKGLpsOZUC4FH8z+MIhXyJk/3TtbUsASMpPo5fI=
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
Subject: [RFC 0/3]  kbuild: modules: Fixup arm64 BTI relocations
Date: Tue,  6 Oct 2026 17:18:12 -0500
Message-ID: <20261006221815.2823252-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The kernel module loader, the arm64 ABI, GCC/Clang, and the static
linkers operate with slightly different assumptions about which
functions require BTI landing pads.

A static function called only directly does not normally need a BTI
landing pad, so compilers omit it. A static linker producing an ET_REL
module treats R_AARCH64_CALL26 as a direct branch and leaves the
relocation for the module loader or later link pass. It does not know
the final distance between sections or whether the loader will later
require an indirect branch fixup.

This matters when a caller and callee are placed in different sections,
for example by __init. The arm64 module loader may replace such a
CALL26 relocation with a fixup containing an indirect branch, making an
otherwise direct only function a BTI target. Ftrace makes this more
likely because its entry NOP can replace a PAC instruction that would
otherwise be a valid BTI landing pad.

A linker could conservatively add veneers to affected cross section
calls, but that would require knowledge of arm64 module loader fixup
semantics and is not part of the generic relocatable link contract.

Lets fix this by handling the module specific transformation during
the kernel build. Scan cross section calls and, when the target lacks
a BTI compatible landing pad, place a veneer in the target section,
redirect the relocation to the veneer, and branch directly from the
veneer to the original function entry.

Jeremy Linton (3):
  kbuild: modules: Add arm64 BTI fixup utility
  kbuild: modules: Build and trigger BTI scanner for arm64
  arm64: bti: Drop compiler specific BTI checks

 arch/arm64/Kconfig         |   6 -
 scripts/Makefile           |   3 +
 scripts/Makefile.modfinal  |  12 +-
 scripts/module-bti-check.c | 665 +++++++++++++++++++++++++++++++++++++
 4 files changed, 679 insertions(+), 7 deletions(-)
 create mode 100644 scripts/module-bti-check.c

-- 
2.55.0

