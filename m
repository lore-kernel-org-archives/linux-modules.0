Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B0223336;
	Sat,  9 May 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292083; cv=none; b=oAAcAi4BOlezoqPSXU3Aw8UMw6gCbSZpa2GzUnrXqxIMt4w0o+nLEsdSlmkt+YP6h99t4SZG/6tbHF1ix3h2FyWgOwpGPqYE/G17s5M9BXrG+f71WMmHs1qKSWRGcKE50GMueHykl0yC5ydMI1aYagyCPB0J6riuKICAVsyMGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292083; c=relaxed/simple;
	bh=jt6lryaGKyOvWm0q033qIcf+/Metp4GbE7ZbSxbQy8I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o03awHOSYlDdjjieKr7tICfdJM2OGQkBIoL99QKO0TghZ9KUmLw0xfWfY3g0gNiCH5TACWfV7rVIwEEzTVvCUsE7vmMeBueu82PEe4NfSTLhbi1X20w5sQwcjuzNpop3IQyJSoqw0i913F3HqW69s6tgqcI3HsEPPUkMIo9EvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nbdZsafx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nbdZsafx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E55CC2BCB0;
	Sat,  9 May 2026 02:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778292082;
	bh=jt6lryaGKyOvWm0q033qIcf+/Metp4GbE7ZbSxbQy8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbdZsafxWobZ798ggoFLWJwW3n9yi3509s1rTfwbwdteYs4FOOOMV5wcoQFmLZgUx
	 QFuum1JF8VljwelNW6vdVddJtvzeY9l8GTKgRyqhivrgvaQZ8XUMxO0C0Y9l25tbKL
	 k9zXBUjeHqFFudRCZZBqDoKj4Ig/0BzsHPMPN810=
Date: Fri, 8 May 2026 19:01:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>
Subject: Re: [PATCH 00/17] dynamic-debug cleanups refactors maintenance
Message-Id: <20260508190121.3461706b01f6079bbacdd167@linux-foundation.org>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 14:45:06 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:

> This series is nearly all maintenance: it refactors/splits functions,
> tightens an internal callchain, drops linked-listing where an
> array,length is already available, reduces verbose=3 logging for
> usability, and reorganizes several structs for better organization.
> 
> Getting these into linux-next for integration testing would clear the
> deck for fixing Dynamic-debug classmaps, which is needed to restore
> the un-BROKEN status of DRM_USE_DYNAMIC_DEBUG.
> 
> Theyre on master at v7.1-rc2
> 
> The "modules" intersection is on the re-composing of struct
> ddebug_info, which is a member in struct module, and maps a module's
> __dyndbg* elf sections.
> 
> The user visible change to /proc/dynamic_debug/control is s/class
> unknown/class:_UNKNOWN_/, which is a more visible/greppable indication
> of incomplete class definitions.

Wait.  We can't make userspace-visible changes?

> Coder visible change is to drop the enum ddebug_class_map_type's
> unused vals - namely: DD_CLASS_TYPE_DISJOINT_NAMES
> & DD_CLASS_TYPE_LEVEL_NAMES
> 
> These allowed more symbolic named inputs:
>   echo +DRM_UT_CORE > /sys/module/drm/parameters/debug
> 
> But theyre unused 3 years later, and probably not worth keeping.
> With a removal commit in the log, its easy enough to restore them later.
> 
> ...
> 
>  MAINTAINERS                                        |   1 +
>  include/linux/dynamic_debug.h                      | 106 ++---
>  kernel/module/main.c                               |  12 +-
>  lib/dynamic_debug.c                                | 504 ++++++++++-----------
>  lib/test_dynamic_debug.c                           |  28 +-
>  tools/testing/selftests/Makefile                   |   1 +
>  tools/testing/selftests/dynamic_debug/Makefile     |   9 +
>  tools/testing/selftests/dynamic_debug/config       |   7 +
>  .../selftests/dynamic_debug/dyndbg_selftest.sh     | 257 +++++++++++
>  9 files changed, 582 insertions(+), 343 deletions(-)

No Documentation/ updates?
