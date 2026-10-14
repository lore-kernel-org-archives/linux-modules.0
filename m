Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4B1AA1F4;
	Wed, 14 Oct 2026 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945425; cv=none; b=AMWw/BcNgye6XhkJ0kexIB7BHM4diO3/xkz2SNqE2sjxyLYnE92VjMYRO8Vw3eIiX4xRqjjIrU2Q5btYBWTSx6QR970h0nj3/kUUdLjdkCIioJKTQVx5M09G9W+KH6DMWNhjTiGZZ1LwY5SYBzqdw6pOi9BM5/pU5BWj4I85/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945425; c=relaxed/simple;
	bh=ALvt1xHOtMcI1HndOPwxrWPc8lzPThUtnk2buTMc2wU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UzwoGoraOTFIWJ7BcYHHgHWOz1bkbXa9k0pJ5FQI6UG2Ovv7PDiFv6N04s2/olPe6BpC37WNFijVKEIJkGsnEy0CCW44+2vdVCu4zUE7jfTc0bdWfl5L735oO+4YQH5nEBvHhpQlplyozKTFLReb/Wd0qed8jSY0tJQHOSHQJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9gP/woH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9gP/woH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6F71F000FF;
	Wed, 14 Oct 2026 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945424;
	bh=qvXUCGz/HJTAYiOJIcwOHti2jnT5T+d//JhOF/D+Pso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N9gP/woHuYkHkTk+j13TZBPk8Y9/2GCT30K5MJcI3cl6oiavPIqkilCY117VCrKEg
	 9rv/G0uKFBm2HXv09wWYgDDY7OGN+497gjrk/ot1EISun/1bi6RGInUSZzsQCzaI/b
	 ga783A4BIjdNLLoZUsdG6pgQZpFd4Nz7GqYz/rP+oRtsfH1KA5lfnJq220inm18QtL
	 Ze89skgsfIhfEGgPg+RhHQ5xUqXdOZxyuWCvHZmEZwwiaHX5D1gJPx/g/F/LGwY07I
	 Id21NxmfSwR+ro+/TyIiDR7sxGGGzfRWCxPtAc13iHG3Mo3sbvACXElDdAR33lHHuc
	 Jy5v/AdqjRiZQ==
Message-ID: <sashiko-outbox-170731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 32/40] docs/dyndbg: add classmap info to howto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>, "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>, "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, "Louis
 Chauvet" <louis.chauvet@bootlin.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:37:02 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] docs/dyndbg: incorrect signature for DYNAMIC_DEBUG_CLASSMAP_PARAM
- [Low] docs/dyndbg: commit message count mismatch for API macros
--

commit 28be193f6b722396acbf0216c1b36e74ba099d0b
Author: Jim Cromie <jim.cromie@gmail.com>

docs/dyndbg: add classmap info to howto

Describes the dynamic debug classmaps API and macro usage in the howto
documentation.

> Describe the 3 API macros providing dynamic_debug's classmaps
>=20
> DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
> DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
> DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
> DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

[Severity: Low]
This isn't a bug, but the commit message states it will describe 3 API macr=
os
while actually listing and describing 4 of them. Should this count be updat=
ed
to match the list?

> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index a8962ab22aaf0..f5b1470a4b881 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
[ ... ]
> +Dynamic Debug Classmap API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this maps
> +classnames (a list of strings) onto class-ids consecutively, starting
> +at _base.
> +
> +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> +call this to refer to the var _DEFINEd elsewhere (and exported).
> +
> +DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
> +maps/exposes bits 0..N as class-names.

[Severity: Low]
Does DYNAMIC_DEBUG_CLASSMAP_PARAM only take one argument here?

The kernel macro defined in include/linux/dynamic_debug.h requires three
arguments: _name, _var, and _flags. Could this discrepancy mislead develope=
rs
attempting to use the API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D32
