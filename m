Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84253405F7;
	Thu,  1 Oct 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885997; cv=none; b=Tf0dUtBWRERvydYf+y7ohsfVuFvaPTNNE5iU0XWdtu+YlewwVRGRX/gO/JVWiFUE8r0BP8qMCfIEC6xgmrQLSZOdMJIby6frWpIP0J9a9AYfCsXk86gTUrFCZDc/fW9o8VU+HJ7lAN3wA7TdVvGabedu4W7xqIHIgcY0Rs87YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885997; c=relaxed/simple;
	bh=7kGlAtxlDwvmiMrNPynxA+8SM/rja6Od+YSxIr+hMiY=;
	h=Subject:To:Cc:From:Date:Message-Id; b=oipSEoOG3b3LJAh+V5Rt32ClmSPkSaQm2BGBz7YXcclzZh1UedD8vSjQHNgV5maEARyjDcZrorX24y59lTXs+ECANM1/0i+W8BWJkW7QQzfAIy2eITAKrzBqXnzVgY7l0ThVIDriSQ8QkYd8xyPb64KifcFDzDneu+iaQaBDBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdQWVUSf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdQWVUSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790885995; x=1822421995;
  h=subject:to:cc:from:date:message-id;
  bh=7kGlAtxlDwvmiMrNPynxA+8SM/rja6Od+YSxIr+hMiY=;
  b=gdQWVUSf6f4kmR/OjM8zDzOdB5l5bPPzMBOYNrhe9PxdyDXL31pj90DB
   LE3oLn6scLVOyvBq6Y1X41ewYj5FKVpmwj7Jl6Xgp0jmysGxabN1l37qp
   bwpUx+9G1VYrfgLr89rr/+5apMzQOWsFYEvBj0tvcJiu6hdtEnPaKriDH
   MvlSxg7D69My3c6jnCENHTI8Kg125ihtkt41Gd3a//8AirlXOcaxnFu+5
   CD+Ay6GnIR7PoA/e99+vCxH+XiqniROtrERZ9soeXa/dmT2D6iEKIeRY6
   bmSX3iFh4C2vURJY8EKeC5iKmQl2EMbJxqovwZoVEW7Q9LO6ocLbNpkPY
   g==;
X-CSE-ConnectionGUID: g08RiSnVSi+94NdVY96N3A==
X-CSE-MsgGUID: QDLMv//oQdi4s+/XPXYrSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="79213699"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="79213699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:19:53 -0700
X-CSE-ConnectionGUID: Z5WIDkyRSCW09jKumH2hwA==
X-CSE-MsgGUID: f/VkIIDrQz2ub9lPmGuNUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="304026150"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa001.fm.intel.com with ESMTP; 01 Oct 2026 13:19:53 -0700
Subject: [RFC][PATCH] x86/mm: Disconnect RWX module checking from execmem
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, Borislav Petkov <bp@alien8.de>, Daniel Gomez <da.gomez@kernel.org>, Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport (Microsoft) <rppt@kernel.org>, Peter Zijlstra (Intel) <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 01 Oct 2026 13:19:52 -0700
Message-Id: <20261001201952.ACC7B6D6@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Frédéric reported:

	x86/mm: Checked W+X mappings: FAILED, 7 W+X pages found.

errors on a build with modules disabled. There are some build
dependencies in play:

 * ARCH_HAS_EXECMEM_ROX depends on STRICT_MODULE_RWX
 * STRICT_MODULE_RWX depends on MODULES
 * execmem_restore_rox() is a stub without ARCH_HAS_EXECMEM_ROX=y

execmem_restore_rox() is what the x86 "ITS" code uses to zap its
W+X mappings during early boot. The error message comes from
CONFIG_DEBUG_WX which is independent from any of the other options.

But the nutty part is that there is any connection at all between
ARCH_HAS_EXECMEM_ROX and STRICT_MODULE_RWX.

Restore a functional execmem_restore_rox() to all 64-bit builds by
eliminating the STRICT_MODULE_RWX dependency.

Then, turn our attention to execmem. 47410d839fcd "x86/Kconfig: only
enable ROX cache...") was trying to make module memory access more
permissive unless STRICT_MODULE_RWX is in play. For execmem, never
consider module memory to be ROX except under STRICT_MODULE_RWX.

This seems to fix Frédéric's issue, but I'm a bit worried that it
has other implications in the execmem code. For instance, the
module_enable_text_rox() loop is now rather weird mem->is_rox is
now directly dependent on STRICT_MODULE_RWX.

Mike, do you see anything bad happening on the execmem side if we
do this?

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>
Reported-by: Frederic MARIE-JOSEPH <fredericmariejoseph@gmail.com>
Link: https://lore.kernel.org/all/20261001-x86-fault-spurious-rw-v1-1-7fe1189b5efd@imperva.com/
Fixes: a82b26451de1 ("x86/its: explicitly manage permissions for ITS pages")
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
---

 b/arch/x86/Kconfig     |    2 +-
 b/kernel/module/main.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/x86/Kconfig~x86-STRICT_MODULE_RWX arch/x86/Kconfig
--- a/arch/x86/Kconfig~x86-STRICT_MODULE_RWX	2026-10-01 07:11:50.443595828 -0700
+++ b/arch/x86/Kconfig	2026-10-01 07:11:50.454595751 -0700
@@ -85,7 +85,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
+	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff -puN kernel/module/main.c~x86-STRICT_MODULE_RWX kernel/module/main.c
--- a/kernel/module/main.c~x86-STRICT_MODULE_RWX	2026-10-01 07:11:50.449595786 -0700
+++ b/kernel/module/main.c	2026-10-01 09:47:20.842360625 -0700
@@ -1355,7 +1355,8 @@ static int module_memory_alloc(struct mo
 	if (!ptr)
 		return -ENOMEM;
 
-	mod->mem[type].is_rox = execmem_is_rox(execmem_type);
+	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		mod->mem[type].is_rox = execmem_is_rox(execmem_type);
 
 	/*
 	 * The pointer to these blocks of memory are stored on the module
_
