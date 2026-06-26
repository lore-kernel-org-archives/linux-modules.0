Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF43E51E8;
	Fri, 26 Jun 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462093; cv=none; b=BNfa+LlDcMi/bcY+7I5sXysOnuh0UUMop3XSLDeOVYnAk65ayPu78Cj4KgymZ49dOlHbrM2gPLTqe4mW9a+BF4ON8xiH3W+KOnUZLgrAf49oQKWIpMwnEENvwF8aZHSQLueYKKj8YFVZkDDQvZiG4CaePbY/nICtY7bRaFhA9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462093; c=relaxed/simple;
	bh=gNxpcs0uG+JvF6akOrV+mxdU3LnU33qyvaBz69GV/mE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nWKggx95SeV+j99IVQc5tAtrmrfxu9LItTvxaZy0D5XwotvzFlZBCKr2Zt/l5BYhh493zw45DO9a6NF4SXBdsWh9DGczV3xIRVh3KpuIOsDGZh1DgGJsAGx1HQqe2q5pFR3Jh2+eOwjk0u8zjVsRICuPYkaklrcnUKqvjXa7iW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWge7yFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWge7yFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AFA1F000E9;
	Fri, 26 Jun 2026 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462092;
	bh=pRZU8ZxtOY0lRSxM6BMlawMDkS+1j8/GDNqwfO8SsKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JWge7yFEcbX5HwC56y6lJf82j8Qk7JIMft0JYjUFwoHLpfWA1I/XbHyXRsjxqH6fe
	 iiTgFW97grIaqYBEx5xGC8Qb5IbWkTAqcb1DWY/TU5mctuDGkrBuEx/2n3stAx16QL
	 mjeKr/CBa3E82xT0SrvsZCLzntztblL6BM8FP8OJGMWziXGpW+UgSKCXitpYcVO7mJ
	 oaiNsiDDD8n180AH0CE37p+mIYqquF392JM6XCpfT9C4VdlcPpeY+1vOfDzbBE+p4f
	 RyyKGEkTgnQdrkh09X+lFxp1hMLp+yGd0p8pNyA1wkj0gSctO4CT27ILMbDDCydUxA
	 fzjBJEGL89sSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938F739389E8;
	Fri, 26 Jun 2026 08:21:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] module: force sh_addr=0 for arch-specific sections
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207923.3816447.7091870447864059948.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:19 +0000
References: <20260327080023.861105-1-petr.pavlu@suse.com>
In-Reply-To: <20260327080023.861105-1-petr.pavlu@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, geert@linux-m68k.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 samitolvanen@google.com, alex@ghiti.fr, mcgrof@kernel.org,
 da.gomez@kernel.org, atomlin@atomlin.com, joe.lawrence@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Sami Tolvanen <samitolvanen@google.com>:

On Fri, 27 Mar 2026 08:58:59 +0100 you wrote:
> When linking modules with 'ld.bfd -r', sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in the
> resulting .ko files. Relocatable objects are expected to have sh_addr=0 for
> all sections. Non-zero addresses are confusing in this context, typically
> worse compressible, and may cause tools to misbehave [1].
> 
> Joe Lawrence previously addressed the same issue in the main
> scripts/module.lds.S file [2] and we discussed that the same fix should be
> also applied to architecture-specific module sections. This series
> implements these changes.
> 
> [...]

Here is the summary with links:
  - [1/4] module, arm: force sh_addr=0 for arch-specific sections
    https://git.kernel.org/riscv/c/ffe1545ce8a0
  - [2/4] module, arm64: force sh_addr=0 for arch-specific sections
    https://git.kernel.org/riscv/c/c5553deb577f
  - [3/4] module, m68k: force sh_addr=0 for arch-specific sections
    https://git.kernel.org/riscv/c/9cb4d4dc8227
  - [4/4] module, riscv: force sh_addr=0 for arch-specific sections
    https://git.kernel.org/riscv/c/04e17ca3f77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


