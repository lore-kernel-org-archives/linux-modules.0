Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FE331A63;
	Wed, 14 Oct 2026 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945421; cv=none; b=CC/wLAL7PyPp+kHqlsMmt4BPZ0MyuvIcL9w6wIZ4INnf7OMklZ2s/d3cmPVsXAEPesDzt6YNnhjbCK5nGMMqVZRJ2cQ4f8856vqGEcPRmC+4QkDxW/2vbc5ZIrIOprtcsUypebCbbLiVUUMMb+8+4UNOxw5+3XrHi1nANDmGa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945421; c=relaxed/simple;
	bh=c3P8Mm6gMhwiXtvfZcrutHrto1Y7xz0C4IZjE8250RE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Lw5p36heEK9mPOpoJSXxOUSekgSKCC3m7livGLteV9J+un9Zdv1/lar3KjFW5pkmaY44U5CfJGPAYkKuhCrU7DCOVRb3k32WkwHcBZ52MDNHQZ/gkGX10soNV/kGSvBnN1oyLpsT2b10bXosHukF6mOrFFWMep5P8BM5MvnG5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzrhRiMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzrhRiMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE521F00893;
	Wed, 14 Oct 2026 02:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945420;
	bh=AqjIfY996XPsKnsihvP7EBq+bmu8uA6D3MTZ98dlotQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzrhRiMzH+3NgUnpEl+6+H0Is4bbTksHyhzYlRDPkD7wTzHU3E6Ot3UUuB5OqXAun
	 /+wyGy7QWGvI51BFT/BX10k/uuqf15X517WudZaDUbWP4lbA2uOpFfWqYEc7NJDN3D
	 pTuDX6LeBbgAxJMjvH4ogLsMIbtdB/+q5mmtazOwTRwNYPB2lyyDG2zzsL3YQrU/wu
	 Oi3e+/dKflRlF73IU3Nz2VXK4fhB3HpChgrsP8Hg7cXeUgjmuP/RoEHqHJ4xmy/Q86
	 Gclh4Mn2P2Dw5ikwQDWGwUpT5Z51RgTxzVpMsVBWXAo7cr6Y0/g72r2mMReWKgvxhJ
	 DFEdhTXtmrs6A==
Message-ID: <sashiko-outbox-170722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 23/40] selftests/dyndbg: Enable
 FT_classmap_inheritance
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
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-23-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-23-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:36:57 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: regex flaw silently excludes submodule from test asse=
rtions
--

commit d0e8e8cb940b9b06248942fb57c7a41c66ad8636
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Enable FT_classmap_inheritance

Exercise classmap state inheritance between supermod and submod, verifying
that class settings and controlling parameter states propagate from parent
classmap definitions to dependent class users upon module load and during
runtime reconfiguration.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index c279c795867b6..d759243a4cbe7 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> @@ -291,6 +292,78 @@ function FT_basic_queries {
>      ddcmd "file $f =3D_" "$f"
>  }
> =20
> +function FT_classmap_inheritance {
[ ... ]
> +    # Real-time mathematical proof that load-time (modprobe) parameter p=
arsing
> +    # and runtime (sysfs write) parameter configurations are perfectly e=
quivalent!
> +    local hash_modprobe=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug*=
\]')

[Severity: Medium]
Does this regex fail to match the sub-module as intended?

Looking at FT_classmap_inheritance(), it calls slice_and_hash_ddctrl() which
uses grep to filter output. In POSIX Basic Regular Expressions (BRE), the *
quantifier matches zero or more occurrences of the preceding character (g).

This means the regex matches [test_dynamic_debug] but demands that the
bracket ] immediately follows the g's. It completely fails to match
[test_dynamic_debug_submod], silently excluding the sub-module from the
load-time test assertions.

> +
> +    # Fresh load with default parameters, then configure them dynamicall=
y at runtime
> +    ifrmmod test_dynamic_debug_submod
> +    ifrmmod test_dynamic_debug
> +    my_modprobe test_dynamic_debug
> +    my_modprobe test_dynamic_debug_submod
> +    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
> +    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
> +
> +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug*\]')

[Severity: Medium]
Similar to the issue above, does this regex fail to capture the runtime
state of the sub-module?

This allows the equivalence check between hash_modprobe and hash_sysfs
to pass without actually verifying the sub-module inheritance behavior.

> +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> +        echo -e "${RED}: Load-time vs runtime parameter equivalence chec=
k failed!${NC}"
> +        exit $ksft_fail

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D23
