Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BD3BA232
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667987; cv=none; b=EKzZlGgssog4Pd3MuNdRjX3BNTL9IBcyab8Y9n0Fw4kY1XenVMaeUERkUxT740lQbvQ1bYjM5SghbVhAXHx9WOZJn7TaocWCijiAgh/AvHRryfOeqPwprYP1UbEmLQD1C/qEJTUayTN9izx3El5sUhB62jvXJ1/XTB7J/aKt4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667987; c=relaxed/simple;
	bh=z7yl/7H4KLs2sTyXJ8mN4FKx403n3FZpRAuLtZD5dTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+9PTCAAAINwND6HVxeNVVfzc5EFVfkTIjKgGlIqWIuplPQlros+jREWo4k+GhNXVULzYNu4b8wwjGpm0QXM1dczXt1D9kR54983k/x4ZLtlIEi3S4+oN1H4ROFAxErCMOwpnl3amqLI4jrDr9jKxANMWxPGlcHisrQV9BeBewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIl/RWhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIl/RWhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4EF1F00A3D;
	Tue, 21 Jul 2026 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667986;
	bh=DhLTvedfAw078ovG22MxG6+ksJbgQhKaxYo8deRr/uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIl/RWhH/aRX3PCBIFNtdnittZE0AUDtnImQ9F+mwgaBhqjPhhAc54otqRZeWfNs/
	 btpkcGTPaQQT7uaqs7oSg0K1GrZignyPYnnGcaZAf0XVhBwOlpSG4C+PYFtUfuCRPM
	 d7uCw08QD2l9zV2IxsiiL0jQWZQc//8APCx1mokb+8nkij6nBJjbG01JNmPdt+Jxmw
	 lpsMqHAUBu4rCvNX2+MWzhf1vpyA5my5a29UohwNLK+JDIQn2AehJleeejYxNMZ0+Y
	 ElVfcqsfM3Oh+dXAwTlqHdz0ayCl9HAlQlYsObDH1MroLP/u3KqgYQ1F4J5G6CnZWj
	 Vmi+PT75Q9b+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/29] selftests/dyndbg: Add kselftest script to
 verify dynamic-debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dd-maint-2-v7-2-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-2-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:06:25 +0000
Message-Id: <20260721210625.CC4EF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The script uses predictable temporary file names in `/tmp` based o=
n the process ID, introducing a Time-of-Check to Time-of-Use (TOCTOU) symli=
nk vulnerability.
- [Medium] The golden record MD5 hashing of dynamic debug control diffs inc=
ludes source code line numbers, strictly coupling the test to file topology=
 and causing spurious failures on unrelated code changes.
- [Medium] The framework uses exact MD5 hashes of dmesg slices, leading to =
severe flakiness when concurrent kernel activity occurs.
- [Medium] The script unconditionally skips all tests on monolithic kernels=
 due to an overly broad initial `lsmod` check.
- [Medium] The dmesg log parsing does not account for `CONFIG_PRINTK_CALLER=
=3Dy`, causing MD5 hashes to change on every test run due to PID inclusion.
--

--- Patch [2]: [PATCH v7 02/29] selftests/dyndbg: Add kselftest script to v=
erify dynamic-debug ---
commit acdd3977962a0d4f508ca6d6378e26344aaef61d
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Add kselftest script to verify dynamic-debug

Add a kselftest script to attempt full validation of dynamic-debug
behavior. The script tests query grammar as documented, responses to
bad input, and proper/expected effects on both the control-file
display of current state, and on pr_debug logging behavior.

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/too=
ls/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 0000000000000..1dafeaabc9768
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,799 @@
[ ... ]
> [ -e /proc/dynamic_debug/control ] || {
>     echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=3Dy ${NC}"
>     exit $ksft_skip # nothing to test here, no good reason to fail.
> }
>=20
> lsmod >/dev/null 2>&1 || {
>     echo -e "${RED}: lsmod requires /proc/modules ${NC}"
>     exit $ksft_skip # maybe later we can do more
> }

[Severity: Medium]
Does this early exit prevent the script from running the builtin tests
on a monolithic kernel?

Since the builtin_tests are explicitly designed to validate dynamic_debug
behavior on built-in code without requiring module support, it seems like
skipping the entire script here disables valid testing on kernels compiled
without CONFIG_MODULES=3Dy.

[ ... ]
diff --git a/tools/testing/selftests/dynamic_debug/syslog_hash_validation.s=
h b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
index 0000000000000..c6d60495d7baa
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/syslog_hash_validation.sh
@@ -0,0 +1,384 @@
[ ... ]
> # Default APP to DYNDBG if not already set
> APP=3D"${APP:-DYNDBG}"
> APP_LOWER=3D$(echo "$APP" | tr '[:upper:]' '[:lower:]')
>=20
> # Global files for tracking seen, unregistered, and drifted hashes
> SEEN_HASHES_FILE=3D"/tmp/${APP_LOWER}_seen_hashes_$$"
> UNREG_HASHES_FILE=3D"/tmp/${APP_LOWER}_unreg_hashes_$$"
> DRIFT_HASHES_FILE=3D"/tmp/${APP_LOWER}_drift_hashes_$$"

[Severity: High]
Are these predictable file paths in the world-writable /tmp directory
vulnerable to a symlink attack?

If a malicious local user creates a symlink matching this PID pattern
right before the script writes to it, could it allow the script to
overwrite sensitive files, since it blindly appends to these paths later
on?

Using mktemp might be a safer approach here to prevent Time-of-Check
to Time-of-Use exploits.

[ ... ]
> function verify_dmesg_slice {
>     # Slices dmesg, computes its hash, and verifies it against the databa=
se.
>     # $1 - unique test key (e.g. normal_513)
>     # $2 - optional start marker (defaults to ${APP}_START_${label})
>     # $3 - optional end marker (defaults to ${APP}_END_${label})
>=20
>     local label=3D"$1"
>     local app=3D"${APP:-DYNDBG}"
>     local start_marker=3D"${2:-${app}_START_${label}_$$}"
>     local end_marker=3D"${3:-${app}_END_${label}_$$}"
>     local extra_args=3D"dmesg"
>=20
>     # 1. Capture the log slice (exactly once!)
>     local log_slice=3D$(dmesg | sed -n "/$start_marker/,/$end_marker/p" |=
 \
> 	grep -E -v "$start_marker|$end_marker" | \
>         sed -e 's/^\[[^]]*\] //' )

[Severity: Medium]
Does this regex correctly handle kernels configured with
CONFIG_PRINTK_CALLER=3Dy?

When printk caller info is enabled, a second bracket group containing the
thread ID is present in the dmesg output. Since the PID changes per run,
will the resulting MD5 hash constantly mismatch because the second bracket
was not stripped before hashing?

[Severity: Medium]
Can background kernel activity disrupt the MD5 hashes calculated from
this slice?

If unrelated subsystem prints (like networking, RCU, or USB) occur between
the log_start and log_stop markers, they will be captured here and alter
the exact hash. Should there be a way to filter the dmesg slice to only
include dyndbg-related lines to prevent test flakiness in noisy
environments?

[ ... ]
> function verify_after_change {
>     # Verifies the transition between the stored 'before' state and the c=
urrent state
>     # $1 - optional unique test key (resolved via stack if empty)
[ ... ]
>     # 1. Capture the 'after' state (exactly once!)
>     local after_slice=3D$(slice_by_grep "$BEFORE_CAPTURE_PATTERN" "$BEFOR=
E_CAPTURE_FILE")
>=20
>     # 2. Generate the unified diff, stripped of volatile diff headers AND=
 hunk line-numbers
>     local transition_diff=3D$(diff -u <(echo "$BEFORE_CAPTURE_SLICE") <(e=
cho "$after_slice") | \
>         tail -n +3 | \
>         sed -E 's/^@@ -[0-9]+.* \+[0-9]+.* @@/@@/g')
>=20
>     # 3. Compute its fingerprint
>     local fingerprint=3D$(echo "$transition_diff" | tr -d '\r' | md5sum |=
 cut -d' ' -f1)

[Severity: Medium]
Does the generated transition_diff still include source code line numbers
from the control file?

The sed command strips the chunk headers, but the body text from
/proc/dynamic_debug/control inherently outputs the format filename:lineno.
If unrelated upstream commits add or remove lines in tested files like
kernel/params.c, won't this cause the tests to spuriously fail because
the hashed line numbers drifted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D2
