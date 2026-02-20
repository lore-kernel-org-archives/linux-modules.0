Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA5337102;
	Fri, 20 Feb 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602960; cv=none; b=LdkW4XeqAJ+qMHU+OgfkOL260PfFEtSde7E13VaPrS2k1VezDS4cOsf8nhDXcXRTX6qpMfzMUjJeGMuVRk7Q2Ye21JJwaKEYk/imSRncauS81qRKm//KiB1r5iYXQPQHaOrmgg0/+TWdO9sPNzLQ1HwdiXpaT3gF1LBEpYlHl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602960; c=relaxed/simple;
	bh=tbaFXMmdsdtWNfsu8k99wrOzw2etnoXuDjcaveO84To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzPPBKOrZ5QJ0TNMn9P9rWQOamfY3uzhLCZLMq5ypDKsS4tFaN99J9dhqh2LezOZG3pd+/Dh+AAmwelfLxQbnHnJqpwsyPDmbeFnsTHL1vHfWwYq/9faVMvdSBN/NgF2dg3GlXIiLx3ZAQJVNP0UlLsxfE+tIw+ziJLXRUi28eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAkpODJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAkpODJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC08FC116D0;
	Fri, 20 Feb 2026 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771602959;
	bh=tbaFXMmdsdtWNfsu8k99wrOzw2etnoXuDjcaveO84To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAkpODJdaeTa37Xxtjwu+nAFruAj+QJ/Cq4NUb5qeNFfOIQwlfqZxix0bOH/Hw05/
	 1+1S3mhoTUPfusN73dAQwXCX16UDh3A8rd2vSYusFK4bvJdGJ5Q2FflHzKVZ3Hlaon
	 5pkR/Bi/fAx7fHfMDnR8zR0fkMQqtG3sjW2JvBQ9Glj1h1nkWIPE3VqhLKLAnnUuJV
	 b+i7vtpowJKFGnoa57dtoHSqOeW+nUQfa0wRAcBVvXbvWUmlOwp2Hn/Cy0PinLN59C
	 Tb/oeGHrKqtYirN9JabCyPn472Nl5GXJLByq5yCy9xVz7k1M3IrJNY6q47MCxTaj7j
	 YPAwjWhaaYqrQ==
Date: Fri, 20 Feb 2026 16:55:54 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix the modversions and signing submenus
Message-ID: <aZhQTaJaRQQfcfyH@macos>
References: <20260205143720.423026-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205143720.423026-1-petr.pavlu@suse.com>

On 2026-02-05 15:37, Petr Pavlu wrote:
> The module Kconfig file contains a set of options related to "Module
> versioning support" (depends on MODVERSIONS) and "Module signature
> verification" (depends on MODULE_SIG). The Kconfig tool automatically
> creates submenus when an entry for a symbol is followed by consecutive
> items that all depend on the symbol. However, this functionality doesn't
> work for the mentioned module options. The MODVERSIONS options are
> interleaved with ASM_MODVERSIONS, which has no 'depends on MODVERSIONS' but
> instead uses 'default HAVE_ASM_MODVERSIONS && MODVERSIONS'. Similarly, the
> MODULE_SIG options are interleaved by a comment warning not to forget
> signing modules with scripts/sign-file, which uses the condition 'depends
> on MODULE_SIG_FORCE && !MODULE_SIG_ALL'.
> 
> The result is that the options are confusingly shown when using
> a menuconfig tool, as follows:
> 
>  [*]   Module versioning support
>          Module versioning implementation (genksyms (from source code))  --->
>  [ ]   Extended Module Versioning Support
>  [*]   Basic Module Versioning Support
>  [*]   Source checksum for all modules
>  [*]   Module signature verification
>  [ ]     Require modules to be validly signed
>  [ ]     Automatically sign all modules
>        Hash algorithm to sign modules (SHA-256)  --->
> 
> Fix the issue by using if/endif to group related options together in
> kernel/module/Kconfig, similarly to how the MODULE_DEBUG options are
> already grouped. Note that the signing-related options depend on
> 'MODULE_SIG || IMA_APPRAISE_MODSIG', with the exception of
> MODULE_SIG_FORCE, which is valid only for MODULE_SIG and is therefore kept
> separately. For consistency, do the same for the MODULE_COMPRESS entries.
> The options are then properly placed into submenus, as follows:
> 
>  [*]   Module versioning support
>          Module versioning implementation (genksyms (from source code))  --->
>  [ ]     Extended Module Versioning Support
>  [*]     Basic Module Versioning Support
>  [*]   Source checksum for all modules
>  [*]   Module signature verification
>  [ ]     Require modules to be validly signed
>  [ ]     Automatically sign all modules
>          Hash algorithm to sign modules (SHA-256)  --->
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

