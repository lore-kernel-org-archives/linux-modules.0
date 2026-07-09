Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9E39B498
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615897; cv=none; b=Blm4YDNbw7WKBzH/svDa3gPD8x9o3jkvAyZuW8+rPVwHsHCajzTc260iS45OI43xNMSqUWF9dMYuhTRCyZCDPY+oHT93T7x+yqylLMalFqfsn9l+N2URZO9CMCjflEgURCjtFBwDqUMeum5kIROQXbfRda4UwxuOFTwH8mvUMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615897; c=relaxed/simple;
	bh=OScaHPxIM8hMgUo54WzNF8whpc7/QoFK4oWo8Colw6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YCeGMnSwJLdm1iuXt/Z0ZiGRKqS282KRRyyiw+43BR736ODRhP+BgNAcBo8pjTwVanjNSQV9cdbW9oeXCFN+5MyO07w/j6dH3/rWpGyDk3Q9IXdOTkWbBgrCJQZekjnj0RJJl492CHZlXOosSnDBHKyVnwTpW719zU24u0O4uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBAzbC03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBAzbC03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB3B1F000E9;
	Thu,  9 Jul 2026 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783615896;
	bh=7z3oF8DuYA+SU6IDQ4itg08kwSlqJ11d7QrtfXcVTf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBAzbC03MwM7eGgwwJ4sLls6QwAXeB1l4kC8LIDGPC02kNDLMOEpQ2Q+T5grTo32+
	 miugHNnNCwlZqk39uFBFsL6KKS5totw0/Yv2Y9v0IfssEIXGjd3RZ/THTfgiVUrqBV
	 SyBewwMB5vWvRdZnhLm31YS+rkat9kBYAVMSJVAijzN6CitnYKcjUIDh/bTO1aCpcZ
	 JDoqNFOkKjRJnAtACMQbBbXky+bxgprg2qX1k5znYiaU0tWrjUPOyWlDei9cvR0f18
	 zN4hqeZ5CroCqZgoDk8NmetN5dzXBUTOvbokf/ZLaHj1ncGnY7MzpDULY5aBBG8r/A
	 OrWUxVddOzZ4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] kallsyms: embed source file:line info in kernel
 stack traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260709163833.3851179-2-sashal@kernel.org>
References: <20260709163833.3851179-1-sashal@kernel.org>
 <20260709163833.3851179-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:51:35 +0000
Message-Id: <20260709165136.0BB3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Use of `snprintf` without checking for truncation leaks uninitiali=
zed kernel memory via trace buffers.
- [Medium] The host tool `scripts/gen_lineinfo` will enter an infinite loop=
 during the kernel build if the number of unique source files exceeds 8,192.
- [Medium] Deduplication logic drops valid lineinfo entries with different =
offsets, breaking symbol boundary checks.
- [Low] The symbol `lineinfo_filenames_size` is missing from the kallsyms i=
gnore list, exposing it while hiding its siblings.
--

--- Patch [1]: [PATCH v7 1/4] kallsyms: embed source file:line info in kern=
el stack traces ---
commit ca3ea968a16862e3d8b4586ef0bfc722a4a2f652
Author: Sasha Levin <sashal@kernel.org>

kallsyms: embed source file:line info in kernel stack traces

This commit adds a configuration option to embed a compact address-to-line
lookup table in the kernel image. It generates this table at build time from
DWARF debug information using a host tool. Stack traces can then directly
print source file and line number information without external tools.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858afd..d3fcf282c33cd 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> @@ -467,13 +467,77 @@ static int append_buildid(char *buffer,   const cha=
r *modname,
> =20
>  #endif /* CONFIG_STACKTRACE_BUILD_ID */
> =20
> +bool kallsyms_lookup_lineinfo(unsigned long addr, unsigned long sym_star=
t,
> +			      const char **file, unsigned int *line)
> +{
[ ... ]
> +	if (low =3D=3D 0)
> +		return false;
> +	low--;
> +
> +	if (lineinfo_addrs[low] < min_offset)
> +		return false;

[Severity: Medium]
Will this boundary check unintentionally reject valid entries for functions
that start on the same source line (e.g. via macro instantiation)?

When deduplicate() in scripts/gen_lineinfo.c processes entries, it drops the
second function's entry because it shares the same file and line. When
querying the second function, kallsyms_lookup_lineinfo() finds the first
function's entry but rejects it here since its offset is earlier than the
second function's sym_start.

> +
> +	file_id =3D lineinfo_file_ids[low];

[ ... ]

> @@ -497,6 +562,23 @@ static int __sprint_symbol(char *buffer, unsigned lo=
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
> +		if (kallsyms_lookup_lineinfo(address, sym_start,
> +					     &li_file, &li_line))
> +			len +=3D snprintf(buffer + len, KSYM_SYMBOL_LEN - len,
> +					" (%s:%u)", li_file, li_line);

[Severity: High]
Does this unconditionally add snprintf()'s return value to the string lengt=
h?

If the formatted string is truncated, snprintf() returns the length it
would have written. This makes len larger than the actual bytes written to
the buffer.

Can this cause callers (like fetch_store_sym() in the trace framework) to
expose uninitialized kernel memory to userspace by copying the unwritten
portion of the buffer?

> +	}
> +
>  	return len;
>  }

> diff --git a/scripts/gen_lineinfo.c b/scripts/gen_lineinfo.c
> new file mode 100644
> index 0000000000000..699e760178f09
> --- /dev/null
> +++ b/scripts/gen_lineinfo.c

[ ... ]

> +static unsigned int find_or_add_file(const char *name)
> +{
> +	unsigned int h =3D hash_str(name);
> +
> +	/* Open-addressing lookup with linear probing */
> +	while (file_hash[h].name) {
> +		if (!strcmp(file_hash[h].name, name))
> +			return file_hash[h].id;
> +		h =3D (h + 1) & (FILE_HASH_SIZE - 1);
> +	}

[Severity: Medium]
Will this open-addressing lookup loop indefinitely if the hash table is ful=
ly
saturated?

If a kernel configuration (like allyesconfig) includes 8192 or more unique
source files, the static FILE_HASH_SIZE array becomes completely full.
Any subsequent file lookup will probe all slots without finding a NULL entry
and loop infinitely.

> +
> +	if (num_files >=3D 65535) {

[ ... ]

> +static void deduplicate(void)
> +{
> +	unsigned int i, j;
> +
> +	if (num_entries < 2)
> +		return;
> +
> +	/* Sort by offset, then file_id, then line for stability */
> +	qsort(entries, num_entries, sizeof(*entries), compare_entries);
> +
> +	/*
> +	 * Remove duplicate entries:
> +	 * - Same offset: keep first (deterministic from stable sort keys)
> +	 * - Same file:line as previous kept entry: redundant for binary
> +	 *   search -- any address between them resolves to the earlier one
> +	 */
> +	j =3D 0;
> +	for (i =3D 1; i < num_entries; i++) {
> +		if (entries[i].offset =3D=3D entries[j].offset)
> +			continue;
> +		if (entries[i].file_id =3D=3D entries[j].file_id &&
> +		    entries[i].line =3D=3D entries[j].line)
> +			continue;

[Severity: Medium]
Does this logic erroneously drop valid lineinfo entries that share the same
file and line but have different address offsets?

As mentioned in kallsyms_lookup_lineinfo(), dropping these entries causes
the lookup to fail its symbol boundary check and reject the previous entry.

> +		j++;
> +		if (j !=3D i)
> +			entries[j] =3D entries[i];
> +	}
> +	num_entries =3D j + 1;
> +}

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 37d5c095ad22a..42662c4fbc6c9 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -78,6 +78,17 @@ static char *sym_name(const struct sym_entry *s)
> =20
>  static bool is_ignored_symbol(const char *name, char type)
>  {
> +	/* Ignore lineinfo symbols for kallsyms pass stability */
> +	static const char * const lineinfo_syms[] =3D {
> +		"lineinfo_addrs",
> +		"lineinfo_file_ids",
> +		"lineinfo_file_offsets",
> +		"lineinfo_filenames",
> +		"lineinfo_lines",
> +		"lineinfo_num_entries",
> +		"lineinfo_num_files",
> +	};

[Severity: Low]
Is lineinfo_filenames_size intentionally omitted from this ignore list?

Missing this symbol causes it to be exposed in /proc/kallsyms while hiding
its siblings.

> +
>  	if (type =3D=3D 'u' || type =3D=3D 'n')
>  		return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709163833.3851=
179-1-sashal@kernel.org?part=3D1
