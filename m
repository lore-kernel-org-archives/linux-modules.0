Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A53515D5
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 04:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785990131; cv=none; b=RiAcUVg/v7FzZCCbi1k+I8/5IW8Cd7mvXPDhCdbKKL+p3bDffOs91Bg9YoTxfxHX6SjFcYWXjnW69cMcWPgWSZcdfLGAANs1GqdhbS6ZJ5s5snbOc00GHaDW8IFHBdvVa2s5VpOtPIJ2bmglbKKgHWbT1owmTJNYggnsITPvBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785990131; c=relaxed/simple;
	bh=Ow5Xs3EpWzHvNnuTKZ8FXdWQBf9J3pmr5UhcJ6gJaPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvDN1+UTcbHMkC95QayaC27ZtYNLmffOmVtd3nXrK7LnyxbuBAkuwPmSnD2SNZt1R4pA7xYtow6qk71w7uUwj2amUV/uX9+02GAW+XNY7/zVi/gbBETimq94crpUsMgh8Rm3U8LLEyQWTSAntbu842HDGPX7C49iEhn9ppbosUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lasoo9VK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lasoo9VK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC531F000E9;
	Thu,  6 Aug 2026 04:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785990130;
	bh=86R/37CwWBYkyYBcd5X+taka84gctscb5NVK/3ASQv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lasoo9VKYPHITn8pH3BPa6ohStPa6lp8mqVRMrdOvd3k+oNVMCtW+Hx12X5snuLRd
	 ZSZxzzJNTdcx3GLB4kxTx33T+6yvsbRJLmbralmGS7pEgHU/cIbzEVcPnov0i+9Xvs
	 Q713kfyx203d95t0OWb4yGpnqbLRq3IQZrand5/qxFs/vxdD0O4cERUUMWj6P2VhiF
	 zw57we7LyZ3FHNz/6b0vsupldrUZkUSrk5pokuOWVh9qrI180rWmSBQp26nuYviokx
	 fjZxHzd2aF1+5IvTlicyNZITeQVROmuovqJXvUV7hv1ILf5W3F6doTaziLeFh1xRc6
	 R1zXx931HYX3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ARM: unwind: modules: Fix the mismatch between
 .ARM.exidx* and .text
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xie Yuanbin" <xieyuanbin1@huawei.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260806041001.143888-1-xieyuanbin1@huawei.com>
References: <20260806041001.143888-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 04:22:09 +0000
Message-Id: <20260806042210.3CC531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the wildcard pattern `[0-9a-z-A-Z_]*` introduces an uninten=
ded literal hyphen and diverges from the `.text` pattern syntax.
--

--- Patch [1]: [PATCH] ARM: unwind: modules: Fix the mismatch between .ARM.=
exidx* and .text ---
commit 77bfa32ad8c348a1008e578b132ff69e6108ddd2
Author: Xie Yuanbin <xieyuanbin1@huawei.com>

ARM: unwind: modules: Fix the mismatch between .ARM.exidx* and .text

This commit modifies the module linker script for ARM to merge
.ARM.extab.text.* and .ARM.exidx.text.* sections. It addresses a stack
unwinding failure caused by newer compilers splitting sections.

> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index d0f2004289576..0ccf0c205d005 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -39,6 +39,10 @@ SECTIONS {
>  	.text			0 : {
>  		*(.text .text.[0-9a-zA-Z_]*)
>  	}
> +#if defined(CONFIG_ARM) && defined(CONFIG_ARM_UNWIND)
> +	.ARM.extab : {*(.ARM.extab .ARM.extab.text.[0-9a-z-A-Z_]*) }
> +	.ARM.exidx : {*(.ARM.exidx .ARM.exidx.text.[0-9a-z-A-Z_]*) }

[Severity: Low]
This isn't a bug, but there appears to be an extra hyphen in the wildcard
pattern between z and A. Could this be corrected to match the [0-9a-zA-Z_]*
pattern used in the .text section just above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806041001.1438=
88-1-xieyuanbin1@huawei.com?part=3D1
