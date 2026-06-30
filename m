Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7862E7F2C;
	Tue, 30 Jun 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784483; cv=none; b=km48/275MlivAHnIq+lj5nmFObNQOTZOZM4q1DTSzpCXWkDQ1pvKHBOHMuv7xKpnNMAus4kPN6DvEELE4F71gTb1mqiiCw70QewPwm3HjYZm+gWL43lhdYC/ujG6TNw3Z8V9U78/865vJtOAHxPUEMFgWN8frNkYX5tGX8xa6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784483; c=relaxed/simple;
	bh=bn1LHd3OHhBk6/yvIpNvhrFt/UF7RlbjeVCHu7MJ0Fs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=I9qdXhaIpZPLPyODhY3p3/BxpIAd8zswMK85YdOgsS+sir4drK392Jw5Pp33LGcPyg1jig5Z1wX+HVjS6O5zaQ2bN0/oZ4rdxaKP9Ei9675yvt/oDlXpUvfcA/5CzxSPvfNBHxchCbhv+YoQ9W9rjiWAak+z2qu+y+pmu13Avao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PelMRxBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PelMRxBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE21F000E9;
	Tue, 30 Jun 2026 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782784482;
	bh=0P7LDjhqWjIbgOLzCEZQr2Bj9BM7s9iDecmTLikIjF4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PelMRxBinaeKwK2rdKTqnmS20mRH6eqBM84foSu3gkZ5/33w4IDI77u8i+7+g3V/D
	 jm28xXjv/RwJgy2+J25YisEBnr9QGfJ/a7wJ7EaKPKjiyp35m2HV54h7vVsjdOzlZq
	 yiE860Z3u5KyJN8cx4UXlU4WaqV6xzB52Wn7O88/qFqbcnzfZ2jktt0XX7Fo3G696t
	 UhF1QWrEspNJCjTV4Eftpo/YESYuDEwPLE92HiRv6aXiJ8MenLJJhkwnccFcNWm3ab
	 ++jgrG/kXVN9Jl9uWaSyr0BQ1jbJ2cOSa7paGKvoE4M3bQYX1EWZ9ICezEiBV9786T
	 KiVOzfG129X/A==
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kbuild: Use --force-group-allocation when linking
 modules
From: Nathan Chancellor <nathan@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Collingbourne <pcc@google.com>, 
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612133139.1919042-1-petr.pavlu@suse.com>
References: <20260612133139.1919042-1-petr.pavlu@suse.com>
Date: Mon, 29 Jun 2026 18:54:32 -0700
Message-Id: <178278447248.3414597.4179963162938722029.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=646; i=nathan@kernel.org;
 h=from:subject:message-id; bh=bn1LHd3OHhBk6/yvIpNvhrFt/UF7RlbjeVCHu7MJ0Fs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnOivc2SgQrKE9U764zNLx9iHdi0uHFbodu3+P5vclsn
 2DkfWGXjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRUwGMDAtNCifmRh+b9ThJ
 sFvJ6/Kq2kXCd7cyJu1i3bpisvicaUkMfzje8c8PzvBZ/XhfydatPlqrNwZ8FGVJnxumt77vZ/P
 JPD4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Fri, 12 Jun 2026 15:31:37 +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

