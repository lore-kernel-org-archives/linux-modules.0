Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79A306764
	for <linux-modules@vger.kernel.org>; Sat,  1 Aug 2026 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595555; cv=none; b=SXIlhAPVS9gnsc1oQHdWZ7TiTL178xO4EhVjk+3PxzFNHYQqX4It3L91Ce3Xj7N7Qn+xDsiKLvbfEz9ZENaD//F6w+6+yXQQVPJMm+kycPSE3WM8S48DxE9Su8O5nKUo/mQVAc4UbGzF62Lbx5wb8maWjJtExq3wWlt+PIIkQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595555; c=relaxed/simple;
	bh=jLWjjMI5rougOsUuvQAD4JnqTyuwA33U7FBslxbxMM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kr92tfcJetVkbddP3l1MpuiaeIXCeLY3Jq7Vo42eTnBNBJjZu2ZE6SA3DsY/zJ4tx8ICm7L6FF7b8lkTgakNTspCX/tFTYmicNJhRWhSd/89CIveV7XwFzXociJaYhFAeblPpzSMAT44jdZAIfVCpZtpA3V4qMEPWVySIiqPG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=behEUfpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="behEUfpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817111F00AC4;
	Sat,  1 Aug 2026 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785595553;
	bh=O8wT6C1K0YtAPoxi+8vvmm6Y4ece++XS/hytI4HrEX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=behEUfpv3s/0FQpz4jI4zAhfWyzvnvKCIGFYNHrtNCZBdFIuw4DrW4/nyDSBstTTu
	 2a6dUhKkuovSN5M/LX17sO9YRmHfnMs/hFA+yi4Wl8Ysr0ba8WGKQRjBZ+cxPM6Zsa
	 NVUWE6MIuyOq5+NXj6BrOKGVwjCehMxQVg0az7r1Zd9zwLN/G8tPIhsDBq5SsaicJH
	 3KWwU53rfHpzwRItDoy8QqmWsykfTPfO99M7EiXi2Q5XjS9u1C3rz+IvMJH6RiMvFB
	 JMo1/UU+DZgJGVHyN1D+pBObEp8IOtZTaQpK3vLINaBLE+kETys+712X/mLfTq09ZE
	 jrvTjUTf6ih/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] kallsyms: add KUnit tests for lineinfo feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260801143219.3975824-5-sashal@kernel.org>
References: <20260801143219.3975824-1-sashal@kernel.org>
 <20260801143219.3975824-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 14:45:53 +0000
Message-Id: <20260801144553.817111F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The KUnit test `test_sprint_symbol_format` unconditionally fails=
 because it mistakenly expects `+0x` for a zero offset.

Pre-existing issues:
- [High] kallsyms_lookup_buildid() can return negative error codes like -E2=
BIG, leading to a stack buffer underflow in __sprint_symbol().
--

--- Patch [4]: [PATCH v8 4/4] kallsyms: add KUnit tests for lineinfo featur=
e ---
commit 337c29ff08b7b23d898a00240203617a93c2c906
Author: Sasha Levin <sashal@kernel.org>

kallsyms: add KUnit tests for lineinfo feature

Add a KUnit test module (CONFIG_LINEINFO_KUNIT_TEST) that verifies the
kallsyms lineinfo feature produces correct source file:line annotations
in stack traces.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index b5eff2ba8e5d7..b0475f1e7f791 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[Severity: High]
This is a pre-existing issue, but could this lead to a stack buffer underfl=
ow?

In kernel/kallsyms.c:__sprint_symbol():

    len =3D kallsyms_lookup_buildid(address, &size, &offset, &modname, &bui=
ldid,
                                   buffer);
    if (!len)
        return sprintf(buffer, "0x%lx", address - symbol_offset);
   =20
    ...
    if (add_offset)
        len +=3D sprintf(buffer + len, "+%#lx/%#lx", offset, size);

If a loadable module or BPF program contains a symbol name that exceeds
KSYM_NAME_LEN, functions like module_address_lookup() return -E2BIG (-7).
This negative value propagates up through kallsyms_lookup_buildid() and
bypasses the 'if (!len)' check.

Would 'buffer + len' then point before the allocated buffer, causing an
out-of-bounds write during the subsequent sprintf?

[ ... ]

> diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
> new file mode 100644
> index 0000000000000..2e66e8ebb3124
> --- /dev/null
> +++ b/lib/tests/lineinfo_kunit.c
> @@ -0,0 +1,1040 @@
[ ... ]
> +static void test_sprint_symbol_format(struct kunit *test)
> +{
> +	char *buf =3D alloc_sym_buf(test);
> +	unsigned long addr =3D target_addr(lineinfo_target_normal);
> +
> +	sprint_symbol(buf, addr);
> +
> +	/* Should contain +0x and /0x for offset/size */
> +	KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(buf, "+0x"),
> +				  "Missing offset in: %s", buf);

[Severity: Medium]
Will this assertion fail unconditionally due to standard C formatting rules?

Since test_sprint_symbol_format() passes the exact start address of
lineinfo_target_normal, the resulting offset is 0.

When __sprint_symbol() formats a zero offset using '+%#lx/%#lx', the '%#lx'
specifier omits the '0x' prefix for a zero value, resulting in '+0/' instead
of '+0x0/'.

Does this cause strstr(buf, "+0x") to always return NULL and break the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801143219.3975=
824-1-sashal@kernel.org?part=3D4
