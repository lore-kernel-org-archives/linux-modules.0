Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98B41440E;
	Wed,  7 Oct 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360603; cv=none; b=n97Db1z/PjZe/2HM3HOU+RFfyhz8A1AYdHpmPVUlyZHJUdGvFdhaSdwkKM4CXU1Vh467Ss+KukYeLsuaGXlQJKZ/7ZwhkFG2o+atSWtIUATrFg5C0RRCrZKgbf6PLj7ENVEXZAxLend68RTVBJjtfNlts1J3JSWIW8PJj2RJe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360603; c=relaxed/simple;
	bh=XkR9yeNdMSFEwvPlpk4SbHA8XMyXCGDkACApJUQd+iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INGejbs/jSyeALv/wI8vJ5rs82xNgNmDDIgOFQE9vl4yXAj9gCCORH7p3+wzTg3ERn2dFWowml42zk4JteP3ZErI6JOiZa2Gb5jHJazqtpIHspV7Amco2/ZMO+0D41C+LBAehkJiu7jWMhO3U/Wun/2Zhdq2bTmvCY5cak+oYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eG5BO9Fl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eG5BO9Fl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAFD1477;
	Wed,  7 Oct 2026 01:09:45 -0700 (PDT)
Received: from NH27D9T0LF (unknown [10.57.10.243])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613683F86F;
	Wed,  7 Oct 2026 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791360588; bh=XkR9yeNdMSFEwvPlpk4SbHA8XMyXCGDkACApJUQd+iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eG5BO9Flg7nSzjbWy5bqmKFKgAHlOCOJlq2tABAMJWVnr/aRSBRa28JtcMNCyyeqW
	 L+w+oytM08OB3NUR7Q0vZuiCxVworucaLfx7Gl44JfOHnZsKOe6OQAPHyFm0cmebfY
	 whZMe1g0GAvtVEubvL+paqu6vV/2PJFTlSlZdG60=
Date: Wed, 7 Oct 2026 10:09:37 +0200
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, broonie@kernel.org,
	jpoimboe@kernel.org, nathan@kernel.org, nsc@kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, atomlin@atomlin.com,
	ndesaulniers@google.com, mark.rutland@arm.com, will@kernel.org,
	catalin.marinas@arm.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3]  kbuild: modules: Fixup arm64 BTI relocations
Message-ID: <asX-QZPtpUG5UdBU@NH27D9T0LF>
References: <20261006221815.2823252-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006221815.2823252-1-jeremy.linton@arm.com>

On 2026-10-06 05:18, Jeremy Linton wrote:
> The kernel module loader, the arm64 ABI, GCC/Clang, and the static
> linkers operate with slightly different assumptions about which
> functions require BTI landing pads.
> 
> A static function called only directly does not normally need a BTI
> landing pad, so compilers omit it. A static linker producing an ET_REL
> module treats R_AARCH64_CALL26 as a direct branch and leaves the
> relocation for the module loader or later link pass. It does not know
> the final distance between sections or whether the loader will later
> require an indirect branch fixup.
> 
> This matters when a caller and callee are placed in different sections,
> for example by __init. The arm64 module loader may replace such a
> CALL26 relocation with a fixup containing an indirect branch, making an
> otherwise direct only function a BTI target. Ftrace makes this more
> likely because its entry NOP can replace a PAC instruction that would
> otherwise be a valid BTI landing pad.
> 
> A linker could conservatively add veneers to affected cross section
> calls, but that would require knowledge of arm64 module loader fixup
> semantics and is not part of the generic relocatable link contract.
> 
> Lets fix this by handling the module specific transformation during
> the kernel build. Scan cross section calls and, when the target lacks
> a BTI compatible landing pad, place a veneer in the target section,
> redirect the relocation to the veneer, and branch directly from the
> veneer to the original function entry.
> 
> Jeremy Linton (3):
>   kbuild: modules: Add arm64 BTI fixup utility
>   kbuild: modules: Build and trigger BTI scanner for arm64
>   arm64: bti: Drop compiler specific BTI checks

Tested as follows on BTI-capable hardware:

- Built a kernel with these patches and CONFIG_ARM64_BTI_KERNEL=y
- Verified that a test kernel module can successfully branch indirectly
  to a valid 'bti c' landing pad
- The same test kernel module triggers an Oops - BTI if branching
  indirectly to a nop

  Internal error: Oops - BTI: 0000000036000002 [#1]  SMP
  Modules linked in: bti_probe(OE+) binfmt_misc nls_iso8859_1 aes_ce_blk [...]
  
  [...]
  
  pc : bti_bad+0x1c/0x28 [bti_probe]
  lr : bti_bad+0x14/0x28 [bti_probe]
  sp : ffff800083933a40
  x29: ffff800083933a40 x28: 000000000000000c x27: 0000000000000000
  x26: 0000000000000000 x25: ffff800083933c90 x24: ffffaaa7c52c7058
  x23: ffffaaa7567d1040 x22: 0000000000000000 x21: 0000000000000000
  x20: ffff0000d11cd100 x19: 0000000000000001 x18: ffff800083795058
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  x14: ffffffffffffffff x13: 7465677261742049 x12: 54422064696c6176
  x11: 6e6920676e697265 x10: 0000000000000000 x9 : 0000000000000000
  x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffaaa7567cf044
  Call trace:
   bti_bad+0x1c/0x28 [bti_probe] (P)
   bti_probe_init+0x78/0xff8 [bti_probe]

No Oops was hit, as expected, booting the kernel with arm64.nobti.
Other than that, the system works fine under regular workloads.

Tested-By: Emanuele Rocca <emanuele.rocca@arm.com>
