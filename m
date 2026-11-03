Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704530;
	b=3qGulSMgBd1PpKan8WvkH/Z81Obx2Jir70DGBlMkeW0euRUr05gjPlAGq7qCKPHxCKEc
	 m1/CnPPVd8PRmgSMblmO5ImbNAl7IyZBWOMxUJwW8XQRZcl5n5rcIzl8KFTwU1YpQ//Tr
	 xuWVWCMhY7dtQuYvN+M28kO/HIsY9mXJtr7PSs0N0z8Xeaj3Fmy1PtRpryYTD230c8w38
	 rKWsMhWV3AteH/7IRNfeJJLygbcrkG1lrFiN5fLZhieymsCeXVKeecEBPe1q5XBb+gfDO
	 PuVxkI4j3DQWuSwe2rVNMLpVfIZnn9jAtfCtQpJhnXQOzCmP+VrllY2ARnyH8QiVSNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nnP+EqYBk6lYiUKwenpEHCdDCJhLnMC1MO+64rkVOHo=;
	b=g7w+AeKC3eQdVKYOtrjNpjJC+Rr88qRZfWSRrQ7KKE4HP4SF2uXGl+f8kuSKlkDZMiX7
	 AKLwT/Orl8Eg6Q4JTCQtAVvCVKHFlKR2S7Y5TDKC1jym8WYgccYrFR00IsYaBZCUo0RaQ
	 8WbC7unA/cydBe+bd3rir+iTyvdyrZplcyW15SFCFO8p1TrvkHNL5or+BwcEaq4Rj6nGF
	 LFDhCdmK9AHGPyObHKcp/902m1MIq7TDncyA7oGVRLPHEvx9mUbeCriX4Id3rzneoqbhn
	 QvmSouhWTNp9jqfpN/HboWo1JuyEpeHHD3EihUZWXVZalTi3CVcjEznDM9UOaRq2MJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYryrmHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90A606B13C;
	Tue,  3 Nov 2026 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYryrmHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8123D1F0093A;
	Tue,  3 Nov 2026 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704529;
	bh=nnP+EqYBk6lYiUKwenpEHCdDCJhLnMC1MO+64rkVOHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYryrmHK7Qu36kCLEvVc4oulo5dqWCJQUhvsy0Xi15KoVlO5aLmvQCh7eewg0vhi+
	 oMk8jWCpcXtXx9xmyy2qp6b2oYBJC1EBkqPMG1yvsxaRTumUPToPwgKpMG+BcMQpuf
	 TiaI8gMK8uVRIypCyZ7liiNHmlxMLnn7cdWpqHOQUhoScT9aiRGdf6nMpdIZosOw53
	 19Ca0x/tJuGiuNiW2TMjA4Z9DpM4kgi9b4U+4yub2lTSACwTvIAW4j7Dv4oveGG5+h
	 IrZ4urdULMtlAA2QQv5EygpbIAr55hRffAn0mjgTmDxaJYWQLCPI2Vp7imUdJGr33M
	 kIvGIoUw0sbsA==
Message-ID: <sashiko-outbox-195133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] kallsyms: add KUnit tests for lineinfo feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Richard Weinberger" <richard@nod.at>, "Juergen
 Gross" <jgross@suse.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Greg KH" <gregkh@linuxfoundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Kees
 Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>, "Vlastimil Babka" <vbabka@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Randy Dunlap" <rdunlap@infradead.org>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, "Vivian Wang" <wangruikang@iscas.ac.cn>, "Zhen
 Lei" <thunder.leizhen@huawei.com>, "Sami Tolvanen" <samitolvanen@google.com>, linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20261102111455.919102-5-sashal@kernel.org>
References: <20261102111455.919102-1-sashal@kernel.org>
 <20261102111455.919102-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:15:28 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] kallsyms: identical bodies in lineinfo_kunit targets allow IPA-I=
CF folding
- [Low] kallsyms: unreachable failure path in test_assembly_no_lineinfo()
- [Low] kallsyms: missing has_lineinfo() assertion in test_many_lines_mid_f=
unction()
- [Low] kallsyms: inaccurate lineinfo comments in sprint_with_lineinfo() an=
d test
- [Low] kallsyms: test_static_function() duplicates test_short_function()
--

commit fbb509d58818b09aeb1b086d5f710841ca770e58
Author: Sasha Levin <sashal@kernel.org>

kallsyms: add KUnit tests for lineinfo feature

This commit adds a KUnit test module (CONFIG_LINEINFO_KUNIT_TEST) to verify
kallsyms source file and line annotations in stack traces, and exports
sprint_backtrace() and sprint_backtrace_build_id() for KUnit testing.

> diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
> new file mode 100644
> index 0000000000000..066f342bd78ae
> --- /dev/null
> +++ b/lib/tests/lineinfo_kunit.c
> @@ -0,0 +1,1110 @@
[ ... ]
> +/*
> + * Format a symbol with lineinfo annotation.  Lineinfo is appended only
> + * via the sprint_backtrace*() entry points (kernel/kallsyms.c only adds
> + * the "(file:line)" suffix in stack-trace context =E2=80=94 sprint_symb=
ol() is
> + * used by %ps and many existing format strings tack literal "()" after
> + * %ps, where the annotation would render as "foo (file:line)()").
> + *
> + * sprint_backtrace() subtracts 1 from the address to handle tail-call
> + * return-address corrections; pass @addr + 1 to recover the original.
> + */
> +static int sprint_with_lineinfo(char *buf, unsigned long addr)
> +{
> +	return sprint_backtrace(buf, addr + 1);
> +}

[Severity: Low]
Is the comment above sprint_with_lineinfo() still accurate?

In kernel/kallsyms.c, sprint_symbol() and sprint_symbol_build_id() also pass
add_lineinfo =3D 1 (backing %pS and %pSb), while sprint_symbol_no_offset() =
backs
lowercase %ps and passes add_lineinfo =3D 0.  Later in this file,
test_sprint_symbol_format() and test_pS_format() also assert that
sprint_symbol() and %pS include lineinfo.

[ ... ]
> +static noinline int lineinfo_target_with_arg(int x)
> +{
> +	barrier();
> +	return x + 1;
> +}
[ ... ]
> +static noinline int lineinfo_cross_file_caller(int x)
> +{
> +	return lineinfo_header_helper(x);
> +}

[Severity: Medium]
Can GCC's identical-code folding (IPA-ICF) merge lineinfo_cross_file_caller=
()
into lineinfo_target_with_arg() and cause test_cross_file_inline() to fail?

Unlike the 0-argument target functions which return distinct constants (42,=
 1,
99, 10), lineinfo_target_with_arg(), lineinfo_header_helper() in
lib/tests/lineinfo_kunit.h (inlined into lineinfo_cross_file_caller()), and
lineinfo_target_second_file() in lib/tests/lineinfo_kunit_second.c all share
the exact same signature and body:

	barrier();
	return x + 1;

After __always_inline expansion of lineinfo_header_helper() into
lineinfo_cross_file_caller(), lineinfo_target_with_arg() and
lineinfo_cross_file_caller() are two static noinline functions in the same
translation unit with identical GIMPLE bodies.  When built with GCC at -O2 =
or
-Os without -fno-optimize-sibling-calls (for example when
CONFIG_FRAME_POINTER=3Dn), -fipa-icf-functions merges
lineinfo_cross_file_caller() into lineinfo_target_with_arg() and replaces
lineinfo_cross_file_caller() with a tail-call thunk whose DWARF .debug_line
entry only references lib/tests/lineinfo_kunit.c.

When that happens, test_cross_file_inline() finds no address in
lineinfo_cross_file_caller() resolving to lineinfo_kunit.h and fails.  Would
giving each function a distinct return expression (such as x + 1, x + 2,
x + 3) or marking them __noipa prevent the compiler from folding them?

[ ... ]
> +static void test_static_function(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_short);
> +
> +	skip_without_module_lineinfo(test);
> +
> +	sprint_with_lineinfo(buf, addr);
> +	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
> +			      "No lineinfo in: %s", buf);
> +}
[ ... ]
> +static void test_short_function(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_short);
> +
> +	skip_without_module_lineinfo(test);
> +
> +	sprint_with_lineinfo(buf, addr);
> +	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
> +			      "No lineinfo for short function in: %s", buf);
> +}

[Severity: Low]
Does test_static_function() duplicate test_short_function()?  Both functions
resolve target_addr(lineinfo_target_short) with sprint_with_lineinfo(buf, a=
ddr)
and check has_lineinfo(buf), and all of the local target functions in
lib/tests/lineinfo_kunit.c are already static.

[ ... ]
> +static void test_symbol_start_addr(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_normal);
> +
> +	skip_without_module_lineinfo(test);
> +
> +	/*
> +	 * sprint_backtrace() subtracts 1 from the input and reports offset
> +	 * relative to the (decremented) address, so an exact "+0x0/" can't
> +	 * be expected here.  Verify the symbol resolves and carries lineinfo.
> +	 */
> +	sprint_with_lineinfo(buf, addr);
> +	KUNIT_EXPECT_TRUE_MSG(test,
> +			      strnstr(buf, "lineinfo_target_normal",
> +				      KSYM_SYMBOL_LEN) !=3D NULL,
> +			      "Didn't resolve to expected function: %s", buf);
> +	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
> +			      "No lineinfo at function start: %s", buf);
> +}

[Severity: Low]
In test_symbol_start_addr(), is the comment about how sprint_backtrace()
computes the offset accurate?

In __sprint_symbol(), symbol_offset (-1) is added to address for the lookup
and then subtracted back from offset:

	address +=3D symbol_offset;
	len =3D kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildi=
d,
				       buffer);
	...
	sym_start =3D address - offset;
	offset -=3D symbol_offset;

Because sprint_with_lineinfo() passes addr + 1 to sprint_backtrace(),
__sprint_symbol() looks up addr (offset 0) and then adjusts offset to +0x1/
(the undecremented input offset), whereas calling sprint_symbol(buf, addr)
directly would report +0x0/ with lineinfo.

[ ... ]
> +static void test_assembly_no_lineinfo(struct kunit *test)
> +{
> +#if IS_BUILTIN(CONFIG_LINEINFO_KUNIT_TEST)
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D (unsigned long)_text;
> +
> +	sprint_with_lineinfo(buf, addr);
> +	/*
> +	 * _text is typically an asm entry point with no DWARF line info.
> +	 * If it has lineinfo, it's a C-based entry =E2=80=94 skip in that case.
> +	 */
> +	if (has_lineinfo(buf))
> +		kunit_skip(test, "_text has lineinfo (C entry?): %s", buf);
> +
> +	KUNIT_EXPECT_FALSE_MSG(test, has_lineinfo(buf),
> +			       "Unexpected lineinfo for asm symbol: %s", buf);
> +#else
> +	kunit_skip(test, "_text not accessible from modules");
> +#endif
> +}

[Severity: Low]
Can the KUNIT_EXPECT_FALSE_MSG(test, has_lineinfo(buf), ...) assertion in
test_assembly_no_lineinfo() ever fail?

If has_lineinfo(buf) is true, the preceding if (has_lineinfo(buf)) check ca=
lls
kunit_skip(), which aborts the test via kunit_try_catch_throw(), so
has_lineinfo(buf) is always false when KUNIT_EXPECT_FALSE_MSG() is reached.
Also, since CONFIG_KALLSYMS_LINEINFO depends on CONFIG_DEBUG_INFO (which pa=
sses
-g in KBUILD_AFLAGS), assembler .S entry points at _text normally have DWARF
line info as well, causing this test to always skip.

[ ... ]
> +static void test_many_lines_mid_function(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_many_lines);
> +	unsigned int line;
> +	unsigned long mid_addr;
> +
> +	skip_without_module_lineinfo(test);
> +
> +	/* Get function size from sprint_with_lineinfo output */
> +	sprint_with_lineinfo(buf, addr);
> +	KUNIT_ASSERT_TRUE(test, has_lineinfo(buf));
> +
> +	/*
> +	 * Try an address 8 bytes into the function (past prologue).  Hide
> +	 * the base from the compiler so this does not become a static
> +	 * mid-function relocation (sym+8), which objtool flags as a
> +	 * relocation to !ENDBR with CONFIG_X86_KERNEL_IBT.
> +	 */
> +	OPTIMIZER_HIDE_VAR(addr);
> +	mid_addr =3D addr + 8;
> +	sprint_with_lineinfo(buf, mid_addr);
> +
> +	/*
> +	 * Should still resolve to lineinfo_target_many_lines.
> +	 * Lineinfo should be present with a plausible line number.
> +	 */
> +	KUNIT_EXPECT_TRUE_MSG(test,
> +			      strnstr(buf, "lineinfo_target_many_lines",
> +				      KSYM_SYMBOL_LEN) !=3D NULL,
> +			      "Mid-function addr resolved to wrong symbol: %s",
> +			      buf);
> +	if (has_lineinfo(buf)) {
> +		line =3D extract_line(buf);
> +		KUNIT_EXPECT_GE_MSG(test, line, (unsigned int)50,
> +				    "Line %u too low for mid-function", line);
> +		KUNIT_EXPECT_LE_MSG(test, line, (unsigned int)700,
> +				    "Line %u too high for mid-function", line);
> +	}
> +}

[Severity: Low]
In test_many_lines_mid_function(), if sprint_with_lineinfo(buf, mid_addr) f=
ails
to produce lineinfo, won't the test silently pass because the line-number
checks are guarded by if (has_lineinfo(buf)) instead of asserting
KUNIT_ASSERT_TRUE(test, has_lineinfo(buf))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111455.9191=
02-1-sashal@kernel.org?part=3D4
