Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1832931C0
	for <linux-modules@vger.kernel.org>; Wed,  9 Sep 2026 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916070; cv=none; b=RSeRJK4T85hhSILHZYkyqRfEe+0j/e8DltUZSBiBRLeq4yeo/1uRtWy+twHkyGRmgH2OoH5p2CihImtCIGBWTyJamIEMSQIYfyKs0QqTPpOUWIxZZUmyOlu/I/epsniY20+EE+jMl71SeFBzKQ2JnEuE7S+47Z+UsqaIfcMT408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916070; c=relaxed/simple;
	bh=PbW6JJQAx/8sq8Ngo/d/2vyCHiCgJ2e9HGLMONHrgPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gb3p9JIsr+SaxBHHYXNUDEfDVfeTF5nycmVF4sKhfdR8xxen3Naa+gghYZz0iObdEFFmMui+LpUG2VlHuipTTsLOb54OWp1ymNFVCZ+AF6/0STtRheJfUEm5lIcjJSIFyCLD+Q7u3Tb7YBRs0YnvWsMYAc9vVDIJOGDAXg7A7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEuQcFjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEuQcFjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F51F00A3A;
	Wed,  9 Sep 2026 01:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788916068;
	bh=PbW6JJQAx/8sq8Ngo/d/2vyCHiCgJ2e9HGLMONHrgPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mEuQcFjO4ZP+IDmOBpYBGbbaK+PFiWx6cOwjXoRhGkHjwQEmS+v0MawVaHq38Q5G/
	 IBSNKYAmADPYqWNooXq/WGOLMpXDcTWvhpKXASF83Nul4BC3/sXHMdXZZscs/fGzc3
	 z0cYC1+bFt6dTslab3z1EM+GhYXRQfkXMjkEnVqDE8oPLI4Qz9KJ2eEPEd8Ip3zuZM
	 uTLyDVgk5hwGVYyFE7KUTG6fL1v2glLUfTry9PIa30wNXPp22naiqL4cbxBK5TEaHU
	 58T9Y3cEaCGipYEc419ExkJouBg7Jfef0J35B1xD1HxeMKAM2R0Y4nT3n8oNGBRIXs
	 vBZraU22ABssQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 27/39] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-27-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-27-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:07:48 +0000
Message-Id: <20260909010748.A83F51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message regarding the test macro `DD_MACRO_ARGCH=
ECK`.
--

commit f1639b2e981e61be970216e485857e63c7d27ba2
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: check DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time

This commit adds compile-time checks for dynamic debug classmap macros to
prevent simple misuses. It validates base ranges, array sizes, and map type=
s,
issuing obvious errors during compilation if violated.

> Several bad examples are ifdef DDD_MACRO_ARGCHECK qualified in
> test_dynamic_debug_submod.c and will fail compilation if enabled.

[Severity: Low]
This isn't a bug, but is there a typo in the commit message here?

The code in lib/test_dynamic_debug.c actually checks for DD_MACRO_ARGCHECK
instead of DDD_MACRO_ARGCHECK.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D27
