Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC40284693;
	Mon, 13 Jul 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945985; cv=none; b=fNJeGghueyjZjrYaP25QEksLTm+qKb/F6h9vzZySr4oFmRjn7UqQ9UykTJo1T7EYZaHejXk9Am3wYCyFOcGyghwXZ+yjRgguy11dfXgoyXlKStY4zN3pxVSxdfPtesiFdIyfX94fWYeFUMtLYfNxZz/hoFNgtfvxhdnfAwdv/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945985; c=relaxed/simple;
	bh=u2B1y5AG8z+QeVX67OnFbZ6v9dnXY5cf7Tcft3d6/T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQezMkipA4DPzyAf+vvhJcErQitky/BpREDhWxS/jyhhUWzYpAM80rvmrbRGsebKzZ5FpCh64YTdb2TzLmaTpF4rM2XTL0jpT/oSwMbf14uUSnKpJz4u60wIb4mFJK1P+pWNU1j0/Ml6sqUHlP/st1GQovgvtOTKE3Wupv8Zb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahCNqYYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahCNqYYD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 26FBA1F000E9;
	Mon, 13 Jul 2026 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783945982;
	bh=JY/FqE4KfpeLdqxO5SEnfQ2rmTvCTJVxh/VnIGWxr/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ahCNqYYDQj184C28Zp/IyYSl35JjGtJE8jU2IaoFnHs9upAuK3YcRubnOtbKW9gb9
	 FIJatEDK0N6SjwcalzktMcqj0N1xURA+/Gi323fO892q/2zJ1ouBQZtUJWft2V4mO2
	 0ayQxdCCNJMbI8n0ahV+NxjDu9KwNgrlpaR1kC3nSEnTqZfm2hBaYlI7X1kAKF5zDc
	 0rJ07YBhMkw7hUXLejdregDztba4ntRyzAu4GhXUQlYK7RTMwZMPIy6ZISmYSfmuG4
	 j41LN/Ow+S22jIareAY33T/FCRg9oMYBQTRMEUIGHwk9+gszJuKXShqoKZE5uAr/eK
	 Av2DMz410n5Hw==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Nicolas Schier <nsc@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Use --force-group-allocation when linking modules
Date: Mon, 13 Jul 2026 14:32:48 +0200
Message-ID: <178394595379.708416.8197126658182660959.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612133139.1919042-1-petr.pavlu@suse.com>
References: <20260612133139.1919042-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jun 2026 15:31:37 +0200, Petr Pavlu wrote:
> Specific code, such as outlined KASAN checks, may be placed in
> COMDAT-deduplicated sections. When linking modules as relocatable files,
> the linker by default preserves such groups, potentially leaving multiple
> copies in the resulting modules and unnecessary group metadata.
> 
> Use --force-group-allocation to have the linker resolve the COMDAT groups
> and place their members as regular sections. The option is available from
> ld.bfd 2.29 and ld.lld 19.1.0.
> 
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[1/1] kbuild: Use --force-group-allocation when linking modules
      https://git.kernel.org/kbuild/c/54747629

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers). Patches applied to the
kbuild-next-unstable branch are accepted pending wider testing in
linux-next and any post-commit review; they will generally be moved
to the kbuild-next branch in about a week if no issues are found.

Best regards,
-- 
Nicolas

