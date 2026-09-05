Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551D35C1B1
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632827; cv=none; b=UFQwmD+S6S36VYvhGCFJ5vDpSXF6NcD8A4X1W2Qv+BmsEjQamoU4qFttliADSCTCw9BTOlvUYglLj28ZHi7PCBs2ad3CYazaoopsr2G2ATgCgwNFCxppef+lv8xdnYXl26LeYknyq4ij1aNM5fn0VHVPq8iq4IRroTWbGps7ALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632827; c=relaxed/simple;
	bh=dSF96km7jvNbBrddgbatwMEV01Duf+aoOYYVUfUXffA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=btKXXyrt9pWPZQdp30JMIMBsi0lYhR5cjBrA39mYqcqnTUkxbFSUuMdLsexakQTrZO0DsHggBidAKiGEG9/FiR+jVXpG2BTRHNnq96H97YUpEqG51hSyxCm0gX4bbersvgaYqfN1LM+niKtwyekVjCEAq/+sz6BIzCdyolHZG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIptMPBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIptMPBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920821F00A3A;
	Sat,  5 Sep 2026 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632825;
	bh=sNAQArPK/b0xD8FVI/8U2AULUNqLjnY1C+G0uHb8F30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIptMPBkRjSf4QCLSMgdsWoQxfA7IGvF3cjMB+ExZLVcdBlv5hIp+TICfqqc02AQl
	 T1Q1AwriGKgAPkAKivXeQQm67l/WxrMWtfNoDqdXvJRPgdi9SkuKiN7SAtqXFGyQZ4
	 5ZjgAEMxjy79yDsnPZjjRUiMK9rDQiysTTE3bMJTp/0Wri28GBoQzAQhCW2ZzP1uNx
	 XPZG/U+cNDcevxnylhS6gqRNvE/ltLFxMRJNLLZF1J3bR6eTf5/NqL0QdL5UTkDwwV
	 6IpPnApvWNtvlrE6EdGiT0sUkvkzhjvHSDdz0H52qxQi7ewft+lU4H3lTQnxxSQTGx
	 QTJ1sFwrSe23g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 30/43] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-30-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-30-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:27:05 +0000
Message-Id: <20260905182705.920821F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compile-time check incorrectly rejects valid class ID 62 due to an =
off-by-one error in the upper bound assertion.
--

commit eff2fbed05187c69eca3bc170f67e07db2c41b8d
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: check DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time

This commit adds the __DYNAMIC_DEBUG_CLASSMAP_CHECK macro to implement
compile-time argument checks for dynamic debug classmaps. These assertions
validate bounds for the base offset, class names length, and map types to
prevent simple misuses.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 17fc3a29d97b8..471b9891bd83b 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -197,6 +197,19 @@ struct ddebug_class_param {
>   * __pr_debug_cls(22, "no such class"); compiles but is not reachable
>   */
> =20
> +#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)		\
> +	static_assert(((_base) >=3D 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
> +		      "_base must be in 0..62");			\
> +	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,				\
> +		      "classnames array size must be > 0");		\
> +	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <=3D 32,			\
> +		      "classnames array size must be <=3D 32");		\
> +	static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLAS=
S_DFLT, \
> +		      "_base + classnames.length must be <=3D 62");	\

[Severity: Low]
Does this logic introduce an off-by-one error that inadvertently rejects
valid class maps?

The first static assertion correctly allows a base up to 62 by verifying
it is less than _DPRINTK_CLASS_DFLT.=20

However, if a class map is defined with a single class at a base of 62, the
sum of the base and array size evaluates to 63. Since this check strictly
enforces that the sum must be less than _DPRINTK_CLASS_DFLT (meaning <=3D 6=
2),=20
it would fail compilation.

Should this assertion allow the sum to be equal to _DPRINTK_CLASS_DFLT=20
to permit a single class definition at the highest allowed base?

> +	static_assert(((_mapty) >=3D DD_CLASS_TYPE_DISJOINT_BITS) &&	\
> +		      ((_mapty) <=3D DD_CLASS_TYPE_LEVEL_NUM),		\
> +		      "unknown class_map_type")
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D30
