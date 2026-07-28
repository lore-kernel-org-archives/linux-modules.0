Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD837472760;
	Tue, 28 Jul 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266562; cv=none; b=JZPZHUt4KvKdXYNqtW/jUEBvNeepwwUDY4MZeINXNFRcx0a0vfvWqb+A5il/1tULKJo4UWGYrin9kqzMj/2VcYSSIfMjtgFwbmNRJ7dKDJqOaTKx5x7mW9FI8BCIdHHmAI4oVSY6/P67f9dLu7bK2hyLuihevPzwGT14zcGTyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266562; c=relaxed/simple;
	bh=RAybM5FwJCEXR6lQQGedKuEkTpFAt+pqpKOXqQeptXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA3z/sGt6yGkqMUK/m5dMKbekHMHriLDBrZjMWz1VEuwCnLc+6J9c2biQ+xqTgfY6LtUvv7Oo8oGueuPV4E9KDPI2+WqgCrFCVH8dQxjwD9LQIYPQDClUWlayE0cE5kl1Feg3pVDwrsTKuIeO2yFlRiCNV/KnRqyXC8aCSv1vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJDjusYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJDjusYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3EC1F000E9;
	Tue, 28 Jul 2026 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785266559;
	bh=Sg7X61+HXElaIBwpC5DPgqG06SdxhEtH8T/5QF3gGBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJDjusYWkQMn2jsrf3H5zsXY+niEzuNpEN0xhA2ntLi3CPQmzP0lDfPSONKYYJQZM
	 j06TuAZgDKWQfIlTBmPtOwwGgZf6OAjeILlkP4GDfVszyRqZRbqUKFU/GMRvJsRSFt
	 38G5xk1FgQ2hd985eoJPV50itBz3wh3pkOCZQwMivrcyS4I6/3CII3eV9vnb4IZphj
	 3vrTcKqbhKmUcIZDnbGqQ2oxLquRD/y+dawcg44PGzdbzFdlFtIybwrp0gktbq4QGD
	 kzp7HFf07zAB2sZzm0YTiVpDoL00dCZeOqPgOjyzWcJ9U6BcHaYj4G02SohIGnzevn
	 OkCREhvB00Nug==
From: Sasha Levin <sashal@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Juergen Gross <jgross@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Vlastimil Babka <vbabka@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/4] kallsyms: embed source file:line info in kernel stack traces
Date: Tue, 28 Jul 2026 15:22:33 -0400
Message-ID: <20260728192234.443651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e063df8e-3396-4ce9-9e66-27681af17fbc@suse.com>
References: <20260709163833.3851179-1-sashal@kernel.org> <20260709163833.3851179-2-sashal@kernel.org> <e063df8e-3396-4ce9-9e66-27681af17fbc@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 01:53:36PM +0200, Petr Pavlu wrote:
>I'm unable to reproduce these numbers. Could it be that the "stripped"
>vmlinux here still includes debug information?

Yup! the figure was taken from an unstripped vmlinux, so it was really
reporting DWARF size. Will fix, and state the recipe inline so it's
reproducible. Your numbers reproduce here exactly:

  no lineinfo:          51.1 MiB
  lineinfo, before 3/4: 69.1 MiB  (+18.0 MiB / +35.3%)
  lineinfo, after 3/4:  59.1 MiB  ( +8.0 MiB / +15.7%)

>Nit: It might be worth explicitly mentioning libelf as a dependency [...]
>libelf and libdw are available on Arch in libelf, not elfutils.
>[...]
>Nit: Without more context, elfutils could be understood to mean the eu-*
>utilities [...]
>Nit: Again, I suggest mentioning both libelf and libdw for clarity.

Will fix.

>Nit: raw_offset can be declared as `unsigned long` [...] Similarly here,
>raw_min can be declared as `unsigned long`.

Will fix.

>The fallback output printed by echo includes -lz. Is this library really
>required by gen_lineinfo?

No. Will drop it.

>Does gen_lineinfo need to define own hash map [...] Could it be replaced by
>the shared functionality in scripts/include/hashtable.h and hash.h?

Will fix.

>Programs under the scripts/ directory normally use xmalloc() [...]
>The return value of strdup() should be checked for NULL.

Will fix.

>Nit: This can be simplified [...]
>Nit: scripts/include/array_size.h provides ARRAY_SIZE().
>These two lines are unnecessary as the same code is repeated below.

Will fix.

>I think using well-known top-level directories in the kernel tree [...] is
>rather fragile. [...] An alternative approach would be to pass $srctree and
>$objtree to gen_lineinfo

Agreed, will do it that way. Reading them with getenv() rather than -D:
kbuild already exports objtree, srctree and srcroot, and kconfig reads them
the same way, so no Makefile change is needed. Each gets registered both as
spelled and as realpath() so a symlinked tree matches either form, longest
match wins.

On your two caveats: realpath() is applied only to the roots, never to a
DWARF path, since generated sources need not exist when gen_lineinfo runs --
DWARF paths get purely lexical normalization. And srcroot is what covers M=
external modules, whose sources are under neither srctree nor objtree.

I'll keep kernel_dirs[] as a last-resort fallback rather than deleting it,
so an object built outside all three roots degrades as it does today instead
of dropping to a bare basename.

Worth noting the rework is not just cosmetic: 1136 of 4450 filenames here
carried a "./" prefix from DWARF directory entries (addr2line shows it too),
which normalization removes, folding the file count to 4354.

>I think using ELF_C_READ_MMAP is normally preferred. Even better, this
>could use ELF_C_READ_MMAP_PRIVATE to avoid opening modules as read-write

Will fix.

>The program has inconsistent error handling.

Will fix.

>This output clutters the build log [...] It should probably be hidden
>behind a --verbose option and printed only when KBUILD_VERBOSE=1.

Will fix.

Separately, working through your review turned up two bugs, both of which
v8 will fix with regression coverage:

- Module lineinfo blobs are malformed. emit_section_table() emits the .Lhdr
  label before its .balign 4, so table_offset (.Lhdr - .Lroot) points into
  the padding and the kernel reads the header 1-3 bytes early.

- The symbol-boundary check added in v7 over-corrected. Functions whose only
  line row deduplicate() had collapsed, or that never had a row at their own
  first byte, stopped resolving: 5017 here, including 1542 .cold fragments,
  all __probestub_*, and the __ia32_sys_* compat wrappers. v6 printed these
  correctly.

Thanks for the thorough review.

-- 
Thanks,
Sasha
