Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF51AA1F4;
	Wed, 14 Oct 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945417; cv=none; b=OZjc9yfKnUnA98StNUI9XjbvZnEtM8l7uqLGyIuh+cLZeocG4e+8zycnNCuvps3SqFBmYLPP2otzKFlyESq+9hxFdUMd6xfN6TwdQfDaRfp2yNYX+U97mTn+h0mvoQWWX0viuFLr3xNzSqJI8rnpaJfQgwSWw+Vi9ZD0ZKQxArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945417; c=relaxed/simple;
	bh=v2WW2S+zGC0PcWGKTOKQ5LZe1JAiFeDQ4b2nAXdC4Dk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=adSS7XbQvhfwRgS4KG7hIG8vbG+ei/OWV2f/wPTnD5xJcGcUvHBn5Xhqsn1zZ1j7gG0cZmkqhamn1ICE6ZI6RWSYFmlVkgHUy36Ekpa51bh/aUvmyGqgtiXGXUOk76qeed1K9W/FjFrrZ7HzXrNKHI61nnx0P/ZdBBf8HWLNPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYIENPkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYIENPkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7C1F00893;
	Wed, 14 Oct 2026 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945415;
	bh=WY4xhORG1iGiMkgZO+2fclzPuh36JIZZLK8hPc+lEV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYIENPkq2Umuxpg8ZAYC5lec3SOt1St5eARcv5U7ASIvYVmkscnfJrkWndo7tVZYl
	 mUWiGuih6GNbnBPR1vsva/CT7nhjL8tJplK2F8rXxWWxw9kCSzVT6qKA7HLW48XlWe
	 VSMW/cEt3j1/nFiDEtoL5Q4vdBtR7NJxrsSrW0hyPXn4+PI88jJpIWfbRh9y1MXDAZ
	 Wsm3s4YfWG0/7ZqB/n75FbOh57PqUDh0XShA1xxYFRASOysYZfXBDdcfYnxrkkwdKB
	 SUhrCujkzUZCD9qO2AEmzvJLyeTYYPotZIEfjETFHWUTzlnzKINgXX5+9Hy63rlZK1
	 +1WCaGbxrYR8Q==
Message-ID: <sashiko-outbox-170708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/40] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
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
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-1-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:36:53 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: test flakiness from unfiltered dmesg temporal slicing
- [Medium] selftests: test failure coupled to unrelated kernel/params.c pr_=
debug churn
--

commit 56bb89808ed29ee403a2b674106329de27cb9b06
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

This commit introduces a dynamic-debug selftest script and a reusable helper
library for baseline-change-verify testing. It uses spatial control-file
slicing and temporal syslog slicing to verify valid syntax, error handling,
and basic queries against the built-in kernel/params.c file.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> new file mode 100755
> index 0000000000000..c1475c7555429
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

[ ... ]

> +function FT_basic_queries {
> +    v_echo "${GREEN}# BASIC_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP - test requires dynamic_debug built into kernel"
> +	return
> +    fi
> +    local f=3D'kernel/params.c'
> +    ddcmd =3D_ # zero everything
> +
> +    ddcmd "file $f +mf" "$f"

[Severity: Medium]
By strictly validating the exact state of kernel/params.c and hashing the
normalized text, won't this test break if an unrelated upstream commit
legitimately adds or removes a pr_debug() in kernel/params.c? Does this
inadvertently couple the selftest to unrelated core kernel changes?

> +    ddcmd "file $f +l"  "$f"
> +    ddcmd "file $f -m"  "$f"
> +    ddcmd "file $f =3D_"  "$f"

[ ... ]

> diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validation=
.sh b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
> new file mode 100644
> index 0000000000000..8c6e91f5d9c27
> --- /dev/null
> +++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh

[ ... ]

> +function verify_dmesg_slice {
> +    # Slices dmesg, computes its hash, and verifies it against the datab=
ase.
> +    # $1 - unique test key (e.g. normal_513)
> +    # $2 - optional start marker (defaults to ${APP}_START_${label})
> +    # $3 - optional end marker (defaults to ${APP}_END_${label})
> +
> +    local label=3D"$1"
> +    local app=3D"${APP:-DYNDBG}"
> +    local start_marker=3D"${2:-${app}_START_${label}_$$}"
> +    local end_marker=3D"${3:-${app}_END_${label}_$$}"
> +
> +    # 1. Capture the log slice (exactly once!)
> +    local log_slice=3D$(dmesg | sed -n "/$start_marker/,/$end_marker/p" =
| \
> +	grep -E -v "$start_marker|$end_marker" | \
> +        sed -E -e 's/^(\[[^]]*\][[:space:]]*)+//' )

[Severity: Medium]
Since verify_dmesg_slice captures all kernel logs between test markers and
hashes the entire block without filtering for test-specific messages, could
concurrent unrelated kernel subsystems (like networking or RCU) emit printk
logs that alter the MD5 hash and cause false positive test failures?

> +
> +    # 2. Compute its fingerprint
> +    local fingerprint=3D$(echo "$log_slice" | tr -d '\r' | md5sum | cut =
-d' ' -f1)
> +
> +    # 3. Verify
> +    verify_fingerprint "$label" "$fingerprint" "Dmesg Log" "$log_slice"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D1
