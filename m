Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF43DDAF5
	for <linux-modules@vger.kernel.org>; Mon,  6 Jul 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349050; cv=none; b=dcBcnvMIJ0mjuAsKqXFPkqRdcueba6J8MubRiKslYubs0M7r/aDfyoMhjFJ+onR63yw1WHSMja70Ae5fVXiZWXDlxuiS1dW+I5r4BsLjV8/V+xJFRpDRtWUZwMcmaSxu5hBSUYSeh4u8LiK2hRgRadvUf9+Q49E/YCvSMrd9Y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349050; c=relaxed/simple;
	bh=ANLZuj+fXhYW1H7LyMcP0xphJzNpw86FNg2Iz0h6oQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nrfadtNEpfGu8JOgopzOXHp7oVlqQPRZw8gyLedfTxm1OogE/ilO8wCjZTLpTVNPqRgI38FDgTxwsNNxpi2VhsFgI0W4us69/YsndUI/rySaF5ztgX0zs6zlAvDjXgw8lmfH1lv8iI/IevZ8OiWAaLxZQ1g4Qwf3bNDosdOyibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXu8797D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXu8797D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CB41F000E9;
	Mon,  6 Jul 2026 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349049;
	bh=tV6R+bM26XwsPK+3MBedFDJRWv2HRxbRVF2MrfF90Dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXu8797DxIvn5m5jN/jUr01atStOi2XjQnffLmQRAAEhy/JKvWqBcEfLBDifY/dkO
	 QOY/p2CaNW6vR+7Oxuk5dqoC+WF4GBTt22ySGJDD8OYUH2YC6g895E/VjZkPeUKVaa
	 t9kQD7jDb6RQR8jyKB/eL3M87ZTp6xpAeGMlFPIhNjrzdAL8gcHgD9iOWxsO76jiLh
	 6AaoF/HMtBCQE7OAKVFEdzeD9fgCcI0K32oBk0VgIK4gKoZcWGt+wmaowif5WIB5Se
	 /DksvSvQhpLZ6tW3mK1ma81c3sY4cD3NeUcLa+wNqGWhBr1isb3KX3LTwSvwZ8pU8E
	 kvECJ3Kn8GDmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] kallsyms: embed source file:line info in kernel
 stack traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260706142914.2398993-2-sashal@kernel.org>
References: <20260706142914.2398993-1-sashal@kernel.org>
 <20260706142914.2398993-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:44:07 +0000
Message-Id: <20260706144408.E6CB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Assembly routines and other un-annotated symbols will be falsely=
 annotated with the file and line number of the preceding C function becaus=
e the binary search does not restrict lookups to the boundaries of the reso=
lved symbol.
- [Low] Unchecked `strdup` return value causes a segmentation fault on memo=
ry allocation failure in the `gen_lineinfo` host tool.
--

commit 8ad0e66e84394fea4bf24efbedda7eb50bbe8269
Author: Sasha Levin <sashal@kernel.org>

kallsyms: embed source file:line info in kernel stack traces

This commit adds CONFIG_KALLSYMS_LINEINFO to embed an address-to-line
lookup table in the kernel image. A new host tool extracts DWARF data
at build time, allowing stack traces to directly include source file and
line number information.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858afd..1e3f527b13988 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -497,6 +544,23 @@ static int __sprint_symbol(char *buffer, unsigned lo=
ng address,
>  		len +=3D sprintf(buffer + len, "]");
>  	}
> =20
> +	/*
> +	 * Append "(file:line)" only for stack-backtrace consumers.  Plain
> +	 * sprint_symbol() backs %ps, and many existing format strings tack
> +	 * literal "()" after %ps to indicate a function call ("foo()
> +	 * replaced with bar()"); appending lineinfo there would produce a
> +	 * confusing "foo (file:line)()".
> +	 */
> +	if (add_lineinfo && IS_ENABLED(CONFIG_KALLSYMS_LINEINFO) && !modname) {
> +		const char *li_file;
> +		unsigned int li_line;
> +
> +		if (kallsyms_lookup_lineinfo(address,
> +					     &li_file, &li_line))

[Severity: Medium]
Will this falsely annotate assembly routines or un-annotated symbols with
the file and line number of the preceding C function?

The caller has access to the resolved symbol's size and offset but fails to
pass this bounding information to kallsyms_lookup_lineinfo(). The binary
search in kallsyms_lookup_lineinfo() does not restrict lookups to the
boundaries of the resolved symbol, finding the closest preceding entry.

Since gen_lineinfo explicitly ignores DW_LNE_end_sequence markers, could
this regression cause the search to bleed across symbol boundaries?

> +			len +=3D snprintf(buffer + len, KSYM_SYMBOL_LEN - len,
> +					" (%s:%u)", li_file, li_line);
> +	}
> +
>  	return len;
>  }

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> new file mode 100644
> index 0000000000000..699e760178f09
> --- /dev/null
> +++ b/scripts/gen_lineinfo.c
> @@ -0,0 +1,557 @@
[ ... ]
> +	if (num_files >=3D files_capacity) {
> +		files_capacity =3D files_capacity ? files_capacity * 2 : 4096;
> +		files =3D realloc(files, files_capacity * sizeof(*files));
> +		if (!files) {
> +			fprintf(stderr, "out of memory\n");
> +			exit(1);
> +		}
> +	}
> +	files[num_files].name =3D strdup(name);

[Severity: Low]
Does this code handle memory allocation failures?=20

strdup() can return NULL on failure, which would be assigned directly to the
files array here and could cause a segmentation fault when later dereferenc=
ed
via strlen().

> +	files[num_files].id =3D num_files;
> +
> +	/* Insert into hash table (points to files[] entry) */
> +	file_hash[h].name =3D files[num_files].name;
> +	file_hash[h].id =3D num_files;
> +
> +	num_files++;
> +	return num_files - 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706142914.2398=
993-1-sashal@kernel.org?part=3D1
