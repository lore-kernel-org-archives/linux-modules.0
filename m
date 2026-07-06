Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B137E304
	for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349113; cv=none; b=V383L20xjP1r8OJeEVSMdeoXZf014270KuJQaVKAMnDiYxrL14ef0c/E25PQt+7cmax3qnJpLxd8ykTfm9FZz8k+jydEEdOylQs1Wx+VZOTaC+MYAMFj6bqS3npdxiDpuJdTMxtesOX9jOSTlN5uzch18XSyeFLk1vSMLDr05aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349113; c=relaxed/simple;
	bh=lGKOMpI+67y0zW9faltoeJx6OkIMxHlKs5bLULK0s00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2jYh7c8OXaCs5YrxrphUiBTv4p7vjmCjhq1E4GzEHfdAK+yvhy2RuYU1NfVv5eqC95jHgbSvnM0eYWwQzGp74vNrQc6dLwgBE+xE8POujq5puTXORUAwzComMcYgQ3fWGFslRUEJjTE5sLvLfdubvTGzuFAQSq5HuQe9LBI8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiQTBDO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiQTBDO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C0F1F000E9;
	Mon,  6 Jul 2026 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349112;
	bh=sLTn4JdUNkMWRlZo5if60Ihuv+4MvFRO9kkegxT5Sbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiQTBDO1SlWQ5MhRVeh7dbkwebi7vWyYXiX7nWfZ6UMOXFqq8H4ABBpfEjKZCiZhm
	 mW4TnFtRGRf7zfBcoEJozfCEJFusxPEXkzCjoczCcoXp8bjlOF2FQHw+kgvdayOApe
	 aAoGRPRbw8hO0ly/jKae5U6cGG0v2OF0lsJgPg6jfvkqkXSuLrKXnPBD7HlSNj4BBB
	 vCB4+EjuK/FSbZdOK11cC+qKn4n9MKHjR7GnnVXV6d8J1uukfZ1Gkc1+J7io/admJz
	 agUVTH1LPaCA6kVYkFDBmkTHIL6X04mkkcNtA+tRCLom16iGjVfXhEe4lPgyarzDeQ
	 37MZZ7ukFmlCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] kallsyms: add KUnit tests for lineinfo feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260706142914.2398993-5-sashal@kernel.org>
References: <20260706142914.2398993-1-sashal@kernel.org>
 <20260706142914.2398993-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:45:11 +0000
Message-Id: <20260706144512.28C0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Test failures on architectures using function descriptors
- [Medium] Silently failing tests due to missing Kconfig dependency for mod=
ule lineinfo
- [Medium] Test flakiness due to incorrect assumption about compiler optimi=
zation and function size
- [Medium] Missing NULL pointer check for test buffer allocation leading to=
 potential kernel panic
--

commit 799168a56f108698328a395b2e257d42cad0b5d4
Author: Sasha Levin <sashal@kernel.org>

kallsyms: add KUnit tests for lineinfo feature
   =20
Add a KUnit test module (CONFIG_LINEINFO_KUNIT_TEST) that verifies the
kallsyms lineinfo feature produces correct source file:line annotations
in stack traces.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294a..257b5ca442f32 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
[ ... ]
> @@ -3092,6 +3092,16 @@ config LONGEST_SYM_KUNIT_TEST
> =20
>  	  If unsure, say N.
> =20
> +config LINEINFO_KUNIT_TEST
> +	tristate "KUnit tests for kallsyms lineinfo" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && KALLSYMS_LINEINFO

[Severity: Medium]
If this test is built as a loadable module and CONFIG_KALLSYMS_LINEINFO_MOD=
ULES
is disabled, will the module lineinfo tests fail at runtime? Should this Kc=
onfig
also depend on KALLSYMS_LINEINFO_MODULES when built as a module, or should =
the
test suite gracefully skip module-specific tests if that configuration is n=
ot
enabled?

> diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
> new file mode 100644
> index 0000000000000..285d798cb6a3c
> --- /dev/null
> +++ b/lib/tests/lineinfo_kunit.c
[ ... ]
> +static char *alloc_sym_buf(struct kunit *test)
> +{
> +	return kunit_kzalloc(test, KSYM_SYMBOL_LEN, GFP_KERNEL);
> +}

[Severity: Medium]
Can kunit_kzalloc() return NULL here and cause a kernel panic when callers
unconditionally pass the buffer to sprint_with_lineinfo()? Would it be bett=
er
to add a KUNIT_ASSERT_NOT_NULL() check here or validate the return value in
the callers?

[ ... ]
> +static noinline int lineinfo_target_many_lines(void)
> +{
> +	int a =3D 0;
> +
> +	barrier();
> +	a +=3D 1;
> +	a +=3D 2;
[ ... ]
> +	a +=3D 10;
> +	barrier();
> +	return a;
> +}

[Severity: Medium]
Is it possible that standard compiler optimizations will fold the arithmetic
in this function away, causing it to compile to fewer than 8 bytes?

If that happens, wouldn't the test_many_lines_mid_function() test below fail
because it adds 8 bytes to the start address and ends up looking outside the
function bounds? Should WRITE_ONCE() or inline assembly be used here to
prevent the arithmetic from being optimized out?

[ ... ]
> +static void test_normal_function(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D (unsigned long)lineinfo_target_normal;

[Severity: Medium]
On architectures that use function descriptors (like PowerPC ELFv1 or ia64),
will casting lineinfo_target_normal directly to unsigned long yield a data
descriptor address instead of the instruction pointer?

Could this cause sprint_backtrace() to fail to resolve the symbol, breaking
the tests unconditionally on those architectures? Does this require using
dereference_symbol_descriptor() to get the actual instruction pointer?

[ ... ]
> +static void test_pBb_format(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	/*
> +	 * %pBb uses sprint_backtrace_build_id which subtracts 1 from the
> +	 * address, so pass addr+1 to resolve back to the function.
> +	 */
> +	void *addr =3D (void *)((unsigned long)lineinfo_target_normal + 1);

[Severity: Medium]
Similarly, adding 1 to a function descriptor pointer instead of an instruct=
ion
pointer creates a corrupt address. Will this cause snprintf() with %pBb to
fail to format the backtrace correctly on architectures using function
descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706142914.2398=
993-1-sashal@kernel.org?part=3D4
