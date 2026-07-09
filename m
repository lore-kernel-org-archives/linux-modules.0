Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B23387362
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615860; cv=none; b=idqH1rYb7YtDfvLjQ5BbhLE+5Qs5Vc+GPUl1u686eXQxp4Xn4lVb1Wi5HATIVDvNa5PcjfSyqYwVPzGL32L9nxyiPBeKFO29HTd0Y2cRPrGQ+f0vJRAWFeJucxaJDhyO7B1BSS3wZDT4RQ5NGjGdWl1QubOTFeVaZCI87+vFZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615860; c=relaxed/simple;
	bh=rIvuJUmEfQ9TSXHyQEHOLxEZCeOmAuqu1poeI7oXvYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aV/n720osj+FlxUU8lAp0SycGPoiKNOoZ+hBJg0vFmneNCgoJLgF/z0cRRISIOLAkMO6Gr970beoNmYKdehIZJ1nB1EQNezrRtxe9Rkn/udcc6e9ahtNFMQ3OPyITu2KVX3KxHXJNRtLs39Sqxus/NSSaJJu0PsIgLg71O6ddQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDzVYMjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDzVYMjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07321F000E9;
	Thu,  9 Jul 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783615858;
	bh=H3MTLv6dJzIVwVScUnYd4Mxsc4JnTsd8lbwmVHckRBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDzVYMjBpQTVhhbH2wZ0twub6winOOqKkH8CeHdyduqNu9vTLQVqLRaNmdDc63tcI
	 9mUUXiXLg/FFJGUyoGWftNNxkCMI0Rp6U/n+hkzNmZc9woHl11P7CbPAu3KlSjWeJb
	 1XFydUbGxbxBe2i2/RFtT6rcwsL8+AHQYXxJIz1zy9UmpECv4QvkZK7DfrN43eHqPE
	 Wm1mgpwwY0gCX+VKj/7yCvemmFVTMj9+Q2gsiTlDxcuF2lCgs4IYIZ8sLnMtUAPljF
	 W5ygSefzZtza3pax1sH8nJ7d674Ga4lGyuetTISupMGVy0yFVw/xZCN41esBhaMUTu
	 0WJl4AGJkXhsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] kallsyms: add KUnit tests for lineinfo feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260709163833.3851179-5-sashal@kernel.org>
References: <20260709163833.3851179-1-sashal@kernel.org>
 <20260709163833.3851179-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:50:58 +0000
Message-Id: <20260709165058.A07321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unchecked NULL pointer dereference when allocating test symbol b=
uffer.
--

--- Patch [4]: [PATCH v7 4/4] kallsyms: add KUnit tests for lineinfo featur=
e ---
commit aa7a75a3dcd2a5f7456eb96f884496c36509f6d7
Author: Sasha Levin <sashal@kernel.org>

    kallsyms: add KUnit tests for lineinfo feature

This commit adds a KUnit test module to verify that the kallsyms lineinfo
feature produces correct annotations in stack traces. It also exports
sprint_backtrace() and sprint_backtrace_build_id() so the test module can
exercise the backtrace APIs.

> diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
> new file mode 100644
> index 0000000000000..dad1522a44f5a
> --- /dev/null
> +++ b/lib/tests/lineinfo_kunit.c
[ ... ]
> +static char *alloc_sym_buf(struct kunit *test)
> +{
> +	return kunit_kzalloc(test, KSYM_SYMBOL_LEN, GFP_KERNEL);
> +}
[ ... ]
> +static void test_normal_function(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_normal);
> +
> +	skip_without_module_lineinfo(test);
> +
> +	sprint_with_lineinfo(buf, addr);

[Severity: Medium]
Will this crash the kernel if kunit_kzalloc() fails and returns NULL?

If memory allocation fails under pressure, alloc_sym_buf() returns NULL. The
callers like test_normal_function() pass this buffer unchecked into
sprint_with_lineinfo(), which eventually passes it to kallsyms_lookup_build=
id()
as the namebuf parameter.

Looking at kallsyms_lookup_buildid() in kernel/kallsyms.c, the buffer is
dereferenced immediately:

kernel/kallsyms.c:kallsyms_lookup_buildid() {
    ...
    namebuf[0] =3D 0;
    ...
}

Should alloc_sym_buf() use KUNIT_ASSERT_NOT_NULL(test, buf) to gracefully f=
ail
the test instead of causing a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709163833.3851=
179-1-sashal@kernel.org?part=3D4
