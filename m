Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A013D279
	for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639894; cv=none; b=jOxUdHMnbSF73k5XIRwP7bQPsmWG8Be5gegGPuRPP6/XZAY96OOQGYlhu4GRJTbDVBO9K/jMhQNv2HNHsiIbWeXwbpDybzSuoZY4WJf9OmWZqggrf95+UT+lMP8s2ag36T/t9QDFClXZeudyjOE57ED7m0dSs2TTl6owR5kP/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639894; c=relaxed/simple;
	bh=7lgQsH8NX8mDnCc0P10zr6M+O+s+xUlql7l2lUJ4JoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXkiKK0EQSjJFDVACExfvTyNb5XJ/xkaDDHr5Csv5KLyUWIs39wXNUgMB/FbMl8mdLrEU7RD4JLm5xGINhe8lAhnzQapoz4+GhjVKEKlMO+78LmBzE4kD+btS/W513HjBcQe5miCo5AwGyjm3yUBbJNXBlEqH4xMsJOc8rKY3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2ovsR7T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2ovsR7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734639892; x=1766175892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7lgQsH8NX8mDnCc0P10zr6M+O+s+xUlql7l2lUJ4JoI=;
  b=U2ovsR7Tntn8q7XkY9e0mtvoIy7R1ARdTL+4GyURprA4XXGuuNUZf2sr
   I4kpKfzGRI62oG9M8EcE3mXvmaUbe30hL3AZQX7AVvzv8wIQbFdjX4KCN
   gL8qwejFowWqJJuFcNGOIIbzG+EFQ0nr/5ece9RNIJcnu+0fMQabVt3vV
   Zq0xcQuhrlksxbHH3ENSt14XgtFuoV1L0IfF7ckhR784q9hJCbhUoVidw
   3jlK5/Tc4cgvVyEbntxsYFs42ayMfWD3s1yUD9SfY+rsrYnHGuk3D+mzh
   iIpFSfhmMDWsnzn92c3mo+uqdCUV0oB1lC12/coPzCTcHJsAxsWnPvrQJ
   A==;
X-CSE-ConnectionGUID: sy4O+yj9RtyJxPmbkg8W3g==
X-CSE-MsgGUID: ryaiiqkKSqeEqATjuRptzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35393082"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35393082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 12:24:51 -0800
X-CSE-ConnectionGUID: OKXSwb2MSx2w0zi8JgH16A==
X-CSE-MsgGUID: KN7MAmkoQLCyqPGXbsmpVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98784695"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO ldmartin-desk2) ([10.125.108.82])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 12:24:45 -0800
Date: Thu, 19 Dec 2024 14:20:45 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: igt-dev@lists.freedesktop.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH i-g-t 2/2] lib/igt_kmod: Do not explicitly unload intel
 mei driver
Message-ID: <pkxihhlzuxpbhkl4woyz5fkri7nmrw7unqtbqwjb2ekeziweru@qwiwezhgwi4j>
References: <20241218233830.2444510-1-daniele.ceraolospurio@intel.com>
 <20241218233830.2444510-2-daniele.ceraolospurio@intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241218233830.2444510-2-daniele.ceraolospurio@intel.com>

On Wed, Dec 18, 2024 at 03:38:30PM -0800, Daniele Ceraolo Spurio wrote:
>The mei driver is a child of i915 on discrete, but not on integrated.
>This means we want to unplug it before removing i915 in the former case
>but not in the latter. Therefore, instead of manually unloading the mei
>driver, we can unbind i915 and leave it to the kernel to unplug all the
>dependencies. This also means that we don't need to explicitly disable
>the vtcon anymore.
>
>The other 2 dependencies are left untouched:
>- intel_ips uses symbol_get, so the automatic dependency detection won't
>  unload it.

and it shouldn't - that's a hack and from the linux-modules perspective
we'd like to drop symbol_get() users. Btw, symbol_get/symbol_put only
guarantees the module can't be removed (since there's code in the kernel
that can still call into them). It doesn't mean the hardware can't go
away (hotplugged or unbound from the driver). The module should be
prepared for that. At the very least, it should handle errors from the
function and release the symbols, but it's probably a candidate for a
component driver.

>- the hotunplug test mentions that the sound driver can throw errors on
>  i915 unbind, so we need to keep the explicit unload.
>
>Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>

the bigger hammer is blocked on audio driver not getting the refcount
right: https://patchwork.freedesktop.org/series/141532/

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi

>---
> lib/igt_kmod.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
>diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
>index a8b0339b9..fa9541d72 100644
>--- a/lib/igt_kmod.c
>+++ b/lib/igt_kmod.c
>@@ -620,16 +620,9 @@ int __igt_intel_driver_unload(char **who, const char *driver)
> 	const char *aux[] = {
> 		/* gen5: ips uses symbol_get() so only a soft module dependency */
> 		"intel_ips",
>-		/* mei_gsc uses an i915 aux dev and the other mei mods depend on it */
>-		"mei_pxp",
>-		"mei_hdcp",
>-		"mei_gsc",
> 		NULL,
> 	};
>
>-	/* unbind vt */
>-	bind_fbcon(false);
>-
> 	ret = igt_audio_driver_unload(who);
> 	if (ret)
> 		return ret;
>@@ -648,6 +641,8 @@ int __igt_intel_driver_unload(char **who, const char *driver)
> 	}
>
> 	if (igt_kmod_is_loaded(driver)) {
>+		igt_kmod_unbind(driver);
>+
> 		ret = igt_kmod_unload(driver);
> 		if (ret) {
> 			if (who)
>-- 
>2.43.0
>
