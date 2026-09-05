Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775332F764
	for <linux-modules@vger.kernel.org>; Sat,  5 Sep 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632346; cv=none; b=W20EH06pa/QVqfEtE2oBguI13TQJKqVXwqEubenHdYmYEWLh0VuUXRFguaFK1qqA7JTVvgt/o8QI/HVUI0etjkNLFegp1gXSsmmkqERX8somZnV7L9v31/6WaRUJN9uWSBC7HSEsTtARIx+B7IM/A0rlKcdFWfebq5xBDvPFmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632346; c=relaxed/simple;
	bh=th0YCJoawGOqD4jLYodVasjYEnqBIj90apGGK3+2kIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYTaGLiujXynm4vBqC4unKgLCX16CD6k+jSga7rxgTtLmdnkeWXbNFffE6ZaoL9motaISzsaJut4wbHBlMSlxUblgCEx6dDhtR60V4SOWlrYJj50K1a+ApK5HSx7F0M3Kd3LRpCq2OFUoZco6J0jWvBSpl7d9n/g8ki4SCQHAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv7gvk2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv7gvk2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758761F00A3A;
	Sat,  5 Sep 2026 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788632344;
	bh=GZnoa/Ltua/puirNwSlJjC0WN0HUAibpbFRq6VDz2GY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jv7gvk2tzOd/viTpG0auNWyGoV0MYIOscK9RcgllmzveM6gOzNTDApAquoZOdsObS
	 MdDVY2kE5IEGXeyeFeQFT9AdEmI3/ZTefBzp18cw3PLaFKUJF7HjORN0iS209yr5DV
	 DrWWlJGd8HHh29CxnEXo1Njdi5wsnzGDCZzNbjbDscFur3d4QveI8Z/6G4Jy5fm6Yh
	 EBPR4+SSteAAW74GTfPNnOp/ZXv7FYVKPmXZWLfSV2fs0OuHH1Oi5IJSi6HpEj4MB9
	 hoWtjIgaXxuj83js9wShJgQ16jVoBp3cppM3qiSXcD3THxozQjEGA9DQ/WkD5G4Tbl
	 KmOD8EVhBRbyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/43] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-4-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-4-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:19:03 +0000
Message-Id: <20260905181904.758761F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undocumented behavior change: CONFIG_DRM_USE_DYNAMIC_DEBUG defau=
lt changed from 'n' to 'y'
--

commit 953ce8d396d765b26b3da8e90da715679595b8c2
Author: Jim Cromie <jim.cromie@gmail.com>

drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as unBROKEN

This commit removes the BROKEN dependency on CONFIG_DRM_USE_DYNAMIC_DEBUG,
allowing the configuration to be enabled for testing dynamic-debug-enabled
DRM drivers.

> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1f4c98cbf0906..2f05bab1a7965 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -1,7 +1,6 @@
>  config DRM_USE_DYNAMIC_DEBUG
>  	bool "use dynamic debug to implement drm.debug"
> -	default n
> -	depends on BROKEN
> +	default y

[Severity: Medium]
The commit message mentions removing the BROKEN mark to allow enabling the
config, but it does not mention changing the default behavior to 'y'.

Since enabling this option introduces substantial .data overhead (~56 bytes
per callsite, resulting in hundreds of kilobytes of memory overhead for lar=
ge
drivers like amdgpu), could changing the default to 'y' cause unintended
memory footprint regressions for any default kernel build with DRM and
DYNAMIC_DEBUG enabled?

Should this remain 'default n' so that developers can opt-in, or should the
justification for 'default y' be added to the commit message?

>  	depends on DRM
>  	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>  	depends on JUMP_LABEL

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D4
