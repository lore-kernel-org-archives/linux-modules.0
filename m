Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609296;
	b=p4zQ4wIr6q5UFl3+dWo6TnX5veJ2sj++Hdqojkru4PjV1fAs7uAfwSucSv2snnpXLM7r
	 BBS0q3ZEaP+k7uZl04IEyLHr9dIuMdMQOjIUnOu5Bf7Y0nPUMtoKpLrESo6ktAocO84Ev
	 L+4Z2rWCWQAKoQFV/p0KY4D7f12QxD2nZSaQJQXS3KMpI5wOKsmOsoXZziOJNXOPKJ9qP
	 C3iDLQODKXg4IhT3WJCl5iyErbuIQQqlMvFpQviUyaHxi9dj8QImqu2MXT2nLdgBcIScc
	 2tWTZIsDg/XbHf4c7M1so+HYwFXK4ZgyzXVuzWcEKeyDpUTGPDLvoWUOnNlrp91AL4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609296;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ECP0Hr2YPPo04+mIQnKQlI/qFYl0ttFaMFao7UE2s+E=;
	b=UnMyyXXs/XIx24uOzlK0nEnJTyHbbIktbDDPxwdYsg3fuRFOmJ1uGTa7J9pJ+6C8sejw
	 HfAKjlJ84XY0RWMFsXYBy9U/YtvDghG5c9Jk7XoCFRCj0Y3t1VVgz2SZPnP/+PucPf5KC
	 /cs4Km2xTdh1M3/33Wx/JUhs5TyYc0KSMJH08v/BgB0rd9KEHrcdh6mwqSmBD/mXL0cYC
	 vLClECquJgGBjAweDDe6uDKwe7r6Bz1LHFkH+Wd/GOsnrEsqyZDv+tjsoQirUX7lKe4bc
	 duRtvVotCq+mnd/2WdGH+AqdTP6mOeBYt/x8vD23SYPGiFlwZLVq3poxjkqPC5x/PSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0u4BjY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230C606A31E;
	Wed, 25 Nov 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0u4BjY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E7C1F000CF;
	Wed, 25 Nov 2026 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609296;
	bh=ECP0Hr2YPPo04+mIQnKQlI/qFYl0ttFaMFao7UE2s+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q0u4BjY+MLBlUyKnxq3MaEi5HHV6puJQwBe+F75zH2AhVCtLHg57DBF5MkciXzuAo
	 izn/XlOTXaSZisSpKdAYNlzzp91jb6zOxOdwi2lS+PLBXhZcYgDHVY8eqn32XWae66
	 vKlQMOvoceJncwSmaEGSOgg+q6aY0yE8A7+1xZbVsEjEKileSh64GEvhn46YpwaosA
	 COUsW9RM3eVeD4GguWtWoZwN0VvaGzrYawmZtYytWpM3wAy3bzbddCJF3VYgnpLxtd
	 3rGFFn/OG3W7ZtfCRWN0/G3lO4gMq3kFitHFm7NzJ92Mm+EJhg3uQ8ptjXZUqFj6au
	 7Of5nrcvoRhRQ==
Message-ID: <sashiko-outbox-233360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] kbuild: implement and use depcheck to check
 dependency timestamps
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Nicolas Schier" <n.schier@fritz.com>, "Kees
 Cook" <kees@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org
In-Reply-To: <20261124-build-speedup-v6-2-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
 <20261124-build-speedup-v6-2-141a4f861c67@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:21:34 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] kbuild: missing ./ prefix normalization in target_of() and
  is_target()
- [Low] kbuild: silent read error in process() and EOF bug in
  deps_are_fresh()
--

commit 14f510d57242e0f215e4f785b8ee900180510d65
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

kbuild: implement and use depcheck to check dependency timestamps

This commit adds the scripts/basic/depcheck host tool to check dependency
timestamps from .cmd files in C and emit a condensed .depcheck.mk fragment
for up-to-date targets.

> diff --git a/scripts/basic/depcheck.c b/scripts/basic/depcheck.c
> new file mode 100644
> index 0000000000000..454a38fb05779
> --- /dev/null
> +++ b/scripts/basic/depcheck.c
> @@ -0,0 +1,492 @@

[ ... ]

> +static void add_target(const char *path)
> +{
> +	struct target *target =3D xmalloc(sizeof(*target) + strlen(path) + 1);
> +
> +	strcpy(target->path, path);
> +	hash_add(target_table, &target->hnode, hash_str(path));
> +}
> +
> +static bool is_target(const char *path)
> +{
> +	const unsigned int key =3D hash_str(path);
> +	struct target *target;
> +
> +	hash_for_each_possible(target_table, target, hnode, key) {
> +		if (!strcmp(target->path, path))
> +			return true;
> +	}
> +
> +	return false;
> +}

[ ... ]

> +/* Is the path contained in line older than the target? */
> +static bool dep_is_fresh(struct line line, const struct timespec *target)
> +{
> +	char path[PATH_MAX];
> +	const struct dep *dep;
> +	bool optional;
> +
> +	line_strip_continuation(&line);
> +	line_trim(&line);
> +	if (!line.len)
> +		return false;
> +
> +	optional =3D line_unwrap_wildcard(&line);
> +	if (!line.len || !unescape_path(&line, path, sizeof(path)))
> +		return false;
> +
> +	/* A target can get 'remade' so its timestamp is meaningless. */
> +	if (is_target(path))
> +		return false;

[Severity: Medium]
Can is_target() miss matching a dependency against target_table when one
of the paths has a leading "./" prefix and the other does not?

When $(obj) is ".", scripts/Makefile.build does not prefix $(targets) with
"./", but $(dir $(f)) in cmd-files expands to "./", so target_of() inserts
"./<name>" into target_table while the compiler and fixdep record "<name>"
in deps_<target>.  Conversely, when $(obj) is a subdirectory, target_of()
stores "<subdir>/<name>", whereas rules passing -I$(objtree)/$(obj) (with
objtree :=3D .) cause the compiler to emit "./<subdir>/<name>" into the .cmd
file.

In both cases strcmp() in is_target() returns false.  If a generated
header in the same directory already exists on disk from a previous build
and its own prerequisites change, depcheck stats the stale file before
make remakes it, treats the dependent object as fresh, and strips its
dependency block from .depcheck.mk, so make misses rebuilding the object.
Stripping leading "./" prefixes before hashing and comparing paths in
add_target() and is_target() would avoid the mismatch.

> +
> +	dep =3D lookup_dep(path);
> +	if (!dep->exists)
> +		return optional;
> +
> +	return !newer(&dep->mtime, target);
> +}
> +
> +/*
> + * Parse a dependency list which consists of one file per line and deter=
mine if
> + * all dependencies are 'fresh', i.e. older than the target.
> + */
> +static bool deps_are_fresh(const char *pos, const char *end,
> +			   const struct timespec *target)
> +{
> +	struct line line;
> +
> +	while (next_line(&pos, end, &line)) {
> +		if (line_is_blank(&line))
> +			return true;
> +		if (!dep_is_fresh(line, target))
> +			return false;
> +		if (!line_is_continued(&line))
> +			return true;
> +	}
> +
> +	return true;
> +}

[ ... ]

> +static char *read_file(const char *path, size_t *len)
> +{
> +	FILE *file =3D fopen(path, "r");
> +	struct stat st;
> +	char *buf;
> +	size_t nr_read =3D 0;
> +
> +	if (!file)
> +		return NULL;
> +	if (fstat(fileno(file), &st)) {
> +		fclose(file);
> +		return NULL;
> +	}
> +
> +	buf =3D xmalloc(st.st_size + 1);
> +	while (nr_read < (size_t)st.st_size) {
> +		const size_t chunk =3D fread(buf + nr_read, 1, st.st_size - nr_read, f=
ile);
> +
> +		if (!chunk)
> +			break;
> +		nr_read +=3D chunk;
> +	}
> +	fclose(file);
> +
> +	buf[nr_read] =3D '\0';
> +	*len =3D nr_read;
> +	return buf;
> +}

[ ... ]

> +static void process(FILE *out, const char *cmd_path)
> +{
> +	size_t len, deps_off;
> +	char *buf;
> +
> +	buf =3D read_file(cmd_path, &len);
> +	if (!buf)
> +		return;

[Severity: Low]
If reading a .cmd file fails or hits an I/O error, does process() silently
omit that target from .depcheck.mk instead of failing depcheck so
Makefile.build falls back to including $(cmd-files)?  read_file() also
does not check ferror(file) when fread() stops early, and if a .cmd file
is truncated right after a line continuation (" \"), deps_are_fresh() hits
EOF in next_line() and returns true, stripping the incomplete dependency
list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-build-spee=
dup-v6-0-141a4f861c67@kernel.org?part=3D2
