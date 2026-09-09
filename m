Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FA492E54
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916350; cv=none; b=Vs5tShlTYbh+leUZ33LelY40TtVl1mGPnzFRqBHxPJOqT2AI3N2hznxSqyWkJ2fNrrvs6YRcF7eWhKb82D3m9dnnw8AdkicOv30a3TXFhePtrdDMYgzU+BgFIs+CmXULk+GdY7kKPYnZBw7eeaAhPqrYQkQKr/zzqzRNG2hqWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916350; c=relaxed/simple;
	bh=fPAIWdNfUptpDMugCun9p/s1Ke79bRSJUJ4AQgs1rIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t0uzPi3UlqdESOyoOPtyCZPxNLC7pi7nYbs7fAG0dUUAgu2KNwW5G+rEFTdghNsb3Uy4HMkdLz7TdaVIqo57Xrz9RTse75wFMM9ol8aOcrC5dATCpg0ktbIiC5KUtuiR59qDKlVfznaY5c7JmrYdpQAO3hF9EeJoiqZH8409EQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2qWd7wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2qWd7wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA161F00A3A;
	Wed,  9 Sep 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916348;
	bh=JtVv2WvqnkzCo0JC1QdcbXMg2fg9dSp4FL8HOnMVuw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2qWd7wmfl+uxFnSTkKDaZL1jI1OXDysIZmxDpQ/4Bi5luBLn9njMSJSYSA2p1d3M
	 TBteTrRwtRINAjGNXewbGXd8J2JL+7Z8ahI2mzbbQZ524C7xBVdveQYtrbCJHS/B+0
	 045ZG3V1jHURJibVXYFWKwbLKxLqvqosIxZA7EjB258gl5ZEXj0dhpsiYzPgubf6KH
	 4dtl7DurosNU8tYyNitcBstdLOQcTJQQ2qyJvmXhXKzvqICLq02Xy0ITuw5Ozi1ZJv
	 ShjTWPonjeJx6V9XYiJIya1MB0ZXC7JAByvmzJvlKUJe1xEUWwCzmYu/Jeal+nlUeI
	 RVhUBxl4tO3ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 39/39] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-39-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-39-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:12:27 +0000
Message-Id: <20260909011228.5BA161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The fallback stub for _dynamic_func_call_cls silently compiles out=
 subsystem debug logs (like DRM) in production kernels when DEBUG is not de=
fined.
--

commit 4c2d1161afbd83349da0d51c36ebb02bc49b083c
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add DEBUG-biased fallback stubs for _dynamic_func_call_cls

When the dynamic debug core is enabled but global dynamic debug is disabled,
subsystems can face build failures due to undefined _dynamic_func_call_cls
macros. This commit adds stub definitions that mirror enabled behavior to f=
ix
the implicit declarations. When DEBUG is not defined, it uses an if (0)
statement to compile out the call while maintaining compile-time checking.

Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@int=
el.com/

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 064df695b3a4c..a04e8aeca0004 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -541,6 +541,23 @@ void ddebug_increment_call_count(void);
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
>  #define DECLARE_DYNDBG_CLASSMAP(...)
> =20
> +#if defined(DEBUG)
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { func(NULL, ##__VA_ARGS__); } while (0)
> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { func(__VA_ARGS__); } while (0)
> +#else
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)

[Severity: High]
Does this unintentionally cause a regression by compiling out subsystem deb=
ug
logs in production kernels when DEBUG is not defined?

For example, DRM wraps its debug functions using this macro in
include/drm/drm_print.h:

#define drm_dev_dbg(dev, cat, fmt, ...) \
	_dynamic_func_call_cls(cat, fmt, __drm_dev_dbg, \
			       dev, cat, fmt, ##__VA_ARGS__)

With the if (0) condition, __drm_dev_dbg() is never executed. Could this
bypass subsystem-specific runtime parameter checks like drm.debug and
silently disable runtime debug logging capabilities for these subsystems?

> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { if (0) func(__VA_ARGS__); } while (0)
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D39
