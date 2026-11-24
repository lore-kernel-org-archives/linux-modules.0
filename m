Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522843;
	b=Xawv+dWvO8FxrzNXyVNIC09eDwgtPWczDiaUCvyVD2OFJ4Uop2OD1uGDfgNAodd0+YDc
	 r8T0U1wABd+c/W5vrN5a2DNNDtOxwYwjOutIfyNnP+mnS3dbzTQQWMX0eZDCD7D4grKvI
	 k3iL/w6FKLnx43AvlNuiCCA5k8j89k6cww+SkbEVfZ+KxtSx1M01jdfJqLjpO54rWNY0i
	 X2DN7ZN2Mk/Dskbg9oyGBFhA4UCADTzEWlABffE+8Ui0ekHVPT+qiR7P1frQ/dJ17R6Y6
	 bIU+r5v7FphwYMKO3+xgAHn6efViIW4vIhtBl7C00lMk3nZ91z2yP534IoY1U9GDY8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522843;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TOvkccWLrbkt3/6cNWf85zXZCkGGobeJKSXarwlP3QY=;
	b=mbyx9v9D04Qc0bL0I5NNwWo0JPiMdH11a5skiTbJqzzE5Zh1YP8A5sIu1uwPOffRWVt1
	 vu3SQI7XxjXKe1+yy3ycNSdIZphl5Mw19K6MTSSMPu4Ybed3c4E0GuIcncaBHT12fY0Ke
	 RkUsga93Gtf1wGRM+l8mTVddE/WKjHHqui1R1COIMr03JqYyx2qtJysDJu7Y3DDwHanrT
	 2jrC1W3Oo7hTdHHMxa7LgIBDvHiVZdDdXCTki0E1/QzPkpPE7gnJD/CQjQqNcJ0bqIdZQ
	 ky5k3AZKazsFQl6RoGeZngh4aPQw8nSReqXRDx7LuUgAlcj0vRokatdqYuy2F4A94PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feNxUdfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7812606A31E;
	Tue, 24 Nov 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feNxUdfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED81F000D1;
	Tue, 24 Nov 2026 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522843;
	bh=TOvkccWLrbkt3/6cNWf85zXZCkGGobeJKSXarwlP3QY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=feNxUdfGzDzyyhTBc3Dx+m/UhJZidJXh/zP1f/k3dFAR8tdcoW4atwx7/0RwQHi2V
	 4y4ZqU/mM+xDxAMkX2d8DnH9NZG2zNNNuV2WXRHuorPiPgav6jqv/1EkyH3txhDxXP
	 xbq0rneSK0sSmq983QnmHMz8+Ph9gljP5+yFDVfT+h90v9jqr0farwUfGVJyKc8Nlm
	 Xefxo9MmrpVkyVJZAaIzPt3eP4/aWrAcWCr8AI14f68T/ZfZCOYDQ5QoCsCF6n7Y7j
	 jYr3bsZtAfcsyzWL4cvVcDTL76H6TyQBJOO/UepPASyvthAiS7RteT/KWWErKufABK
	 uTGd9cwzUI51A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:12 +0000
Subject: [PATCH v6 2/7] kbuild: implement and use depcheck to check
 dependency timestamps
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-build-speedup-v6-2-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
Cc: ljs@kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18658; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8OsDcD4kaNQOGvWTdiv78L2P5u4nkjQ9CuUXhSt4HCQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/6Z6Af8j1c0rNwv+NhZ87TzzYDbF/OmF0pv+1Yed
 0soY8qejlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEyE5SXDf9ffb/1uek/hyxEU
 r/WJfCFvfduoVli9ffXCvIy57m8v/WVkOF1W/m3+J4F/NelNHbtTJvcEeql571hgXpV6xf3qXBc
 /JgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Each object's .cmd file lists its header dependencies, which often
consists of over a thousand dependencies.

When little has changed in the tree, this is what make spends most of its
time doing, spending over a second, single-threaded when parsing larger
directory trees.

It performs considerably more work that is actually necessary to get the
job done.

This can be done faster in C, so implement scripts/basic/depcheck to do so.

It does as little work as possible, reading the .cmd files from a
directory's targets and running stat on each dependency only a single time.

It generates a fragment holding only the saved command line for a target
whose dependencies all exist and are older than it, and the entire .cmd
file for any other.

A dependency that is also a target of the same directory (e.g. header
generated by an if_changed rule) may get remade later in the same make run,
so do not treat a target as fresh.

That way, Makefile.build simply includes the fragment and the amount of
work make has to do is significantly reduced when there is not much work to
do.

If the operation fails, kbuild falls back to using .cmd files.

Multiple make instances can concurrently run Makefile.build for the same
directory at once (e.g. 'make rustdoc rusttest' both entering rust/), so
depcheck writes its fragment to a uniquely named temporary file before
renaming into place atomically.

depcheck is built by the same rule as fixdep, which runs fixdep on its
output, so it is ordered after it.

As a result, whichever fragment an instance then includes is complete, and
one made for a different set of targets, at worst, invokes a target rebuild
once.

The result is exactly the same as before.

For drivers/gpu/drm/amd/amdgpu in an allmodconfig tree the fragment is a
fifth of the size of the .cmd files, make reads it in 10ms instead of
380ms, and the instance goes from 2.2s to 0.4s.

Whole build, 128-thread Threadripper 9980X, best of N runs:

                                         before   after     delta
                                         -------------------------------
  x86 defconfig, no-op make, gcc            1.1s    0.78s    -0.30s (-28%)
  x86 defconfig, no-op make, clang          1.3s    0.94s    -0.34s (-27%)
  x86 allmodconfig, no-op make, gcc        14.5s    12.9s     -1.6s (-11%)
  x86 allmodconfig, no-op make, clang      15.5s    14.2s     -1.3s (-9%)
  x86 allmodconfig, touch mm/vma.c, gcc    34.3s    33.9s    -0.33s (-1%)
  x86 allmodconfig, touch mm/vma.c, clang  33.2s    32.2s    -0.98s (-3%)

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 Makefile                             |   1 +
 scripts/Makefile.build               |  15 +-
 scripts/basic/.gitignore             |   1 +
 scripts/basic/Makefile               |   5 +-
 scripts/basic/depcheck.c             | 492 +++++++++++++++++++++++++++++++++++
 scripts/package/install-extmod-build |   2 +-
 6 files changed, 513 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index f895752d4b05..809ae80d5d70 100644
--- a/Makefile
+++ b/Makefile
@@ -2252,6 +2252,7 @@ clean: $(clean-dirs)
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
+		-o -name '.depcheck.mk*' \
 		-o -name '*.ko.*' -o -name '*.o.thinlto.bc' \
 		-o -name '*.dtb' -o -name '*.dtbo' \
 		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index bbe9555c47a8..7b652f169a8f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -613,7 +613,20 @@ $(obj)/: $(if $(KBUILD_BUILTIN), $(targets-for-builtin)) \
 
 existing-targets := $(wildcard $(sort $(targets)))
 
--include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+cmd-files := $(wildcard $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd))
+
+# depcheck checks timestamps first and outputs only saved command lines of
+# up-to-date targets, falling back to .cmd files if it fails. A directory
+# whose targets all lie elsewhere may not exist in the output tree.
+depcheck := $(wildcard $(objtree)/scripts/basic/depcheck)
+
+ifneq ($(and $(depcheck),$(cmd-files),$(wildcard $(obj))),)
+ifeq ($(shell $(depcheck) $(obj)/.depcheck.mk $(cmd-files) && echo ok),ok)
+cmd-files := $(obj)/.depcheck.mk
+endif
+endif
+
+-include $(cmd-files)
 
 # Create directories for object files if they do not exist
 obj-dirs := $(sort $(patsubst %/,%, $(dir $(targets))))
diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
index 07c195f605a1..761ee14f9477 100644
--- a/scripts/basic/.gitignore
+++ b/scripts/basic/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/depcheck
 /fixdep
 /randstruct.seed
diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
index fb8e2c38fbc7..f301f794dbb1 100644
--- a/scripts/basic/Makefile
+++ b/scripts/basic/Makefile
@@ -2,7 +2,10 @@
 #
 # fixdep: used to generate dependency information during build process
 
-hostprogs-always-y	+= fixdep
+hostprogs-always-y	+= fixdep depcheck
+
+# Both are built by the same rule, which runs fixdep on its own output.
+$(obj)/depcheck: | $(obj)/fixdep
 
 # randstruct: the seed is needed before building the gcc-plugin or
 # before running a Clang kernel build.
diff --git a/scripts/basic/depcheck.c b/scripts/basic/depcheck.c
new file mode 100644
index 000000000000..454a38fb0577
--- /dev/null
+++ b/scripts/basic/depcheck.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * depcheck - check the dependency timestamps of a directory's targets so that
+ * make reads only what it needs from their .cmd files.
+ *
+ * fixdep writes a .cmd file as:
+ *
+ *	savedcmd_dir/foo.o := <command line>
+ *
+ *	source_dir/foo.o := dir/foo.c
+ *
+ *	deps_dir/foo.o := \
+ *	  include/linux/bar.h \
+ *	    $(wildcard include/config/BAZ) \
+ *
+ *	dir/foo.o: $(deps_dir/foo.o)
+ *
+ *	$(deps_dir/foo.o):
+ *
+ * and kbuild may append rules of its own after that, such as one making the
+ * target depend on objtool.
+ *
+ * For a target that exists and is newer than every dependency listed, make can
+ * have nothing to do with the list, so it is left out and only what precedes
+ * and follows it is passed on; for anything else the .cmd file is passed on in
+ * full.
+ *
+ * Usage: depcheck <output> <.cmd files...>
+ *
+ * The output is a makefile fragment to include in place of the .cmd files; a
+ * non-zero exit status means the caller should include those instead.
+ */
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <hash.h>
+#include <hashtable.h>
+#include <xalloc.h>
+
+/* What fixdep writes, see above. */
+#define DEPS_PREFIX		"deps_"
+#define DEPS_RULE_PREFIX	"$(" DEPS_PREFIX
+#define RULE_SUFFIX		":"
+#define LINE_CONTINUATION	" \\"
+#define WILDCARD_OPEN		"$(wildcard "
+#define WILDCARD_CLOSE		")"
+#define CMD_SUFFIX		".cmd"
+
+/* A line of a .cmd file, without its newline. */
+struct line {
+	const char *text;
+	size_t len;
+};
+
+static bool is_blank(char chr)
+{
+	return chr == ' ' || chr == '\t';
+}
+
+static bool str_ends_with(const char *str, const char *suffix)
+{
+	const size_t len = strlen(str), suffix_len = strlen(suffix);
+
+	return len >= suffix_len && !strcmp(str + len - suffix_len, suffix);
+}
+
+static bool line_starts_with(const struct line *line, const char *prefix)
+{
+	const size_t len = strlen(prefix);
+
+	return line->len >= len && !memcmp(line->text, prefix, len);
+}
+
+static bool line_ends_with(const struct line *line, const char *suffix)
+{
+	const size_t len = strlen(suffix);
+
+	return line->len >= len &&
+	       !memcmp(line->text + line->len - len, suffix, len);
+}
+
+static bool line_is_blank(const struct line *line)
+{
+	size_t i;
+
+	for (i = 0; i < line->len; i++)
+		if (!is_blank(line->text[i]))
+			return false;
+
+	return true;
+}
+
+/* Whether the line ends in " \", continuing the list on the next line. */
+static bool line_is_continued(const struct line *line)
+{
+	return line_ends_with(line, LINE_CONTINUATION);
+}
+
+static void line_strip_continuation(struct line *line)
+{
+	if (line_is_continued(line))
+		line->len -= strlen(LINE_CONTINUATION);
+}
+
+static void line_trim(struct line *line)
+{
+	while (line->len && is_blank(line->text[0])) {
+		line->text++;
+		line->len--;
+	}
+	while (line->len && is_blank(line->text[line->len - 1]))
+		line->len--;
+}
+
+/* Take the next line out of [*pos, end); false once there are none left. */
+static bool next_line(const char **pos, const char *end, struct line *line)
+{
+	const char *newline;
+
+	if (*pos >= end)
+		return false;
+
+	newline = memchr(*pos, '\n', end - *pos);
+	line->text = *pos;
+	line->len = (newline ? newline : end) - *pos;
+	*pos = newline ? newline + 1 : end;
+
+	return true;
+}
+
+/* Describes a dependency file. */
+struct dep {
+	struct hlist_node hnode;
+	struct timespec mtime;
+	bool exists;
+	char path[];
+};
+
+static HASHTABLE_DEFINE(dep_table, 1U << 16);
+
+/* The targets of this run's .cmd files: anything make may remake this time. */
+struct target {
+	struct hlist_node hnode;
+	char path[];
+};
+
+static HASHTABLE_DEFINE(target_table, 1U << 12);
+
+static void add_target(const char *path)
+{
+	struct target *target = xmalloc(sizeof(*target) + strlen(path) + 1);
+
+	strcpy(target->path, path);
+	hash_add(target_table, &target->hnode, hash_str(path));
+}
+
+static bool is_target(const char *path)
+{
+	const unsigned int key = hash_str(path);
+	struct target *target;
+
+	hash_for_each_possible(target_table, target, hnode, key) {
+		if (!strcmp(target->path, path))
+			return true;
+	}
+
+	return false;
+}
+
+static const struct dep *lookup_dep(const char *path)
+{
+	const unsigned int key = hash_str(path);
+	struct dep *dep;
+	struct stat st;
+
+	hash_for_each_possible(dep_table, dep, hnode, key) {
+		if (!strcmp(dep->path, path))
+			return dep;
+	}
+
+	dep = xcalloc(1, sizeof(*dep) + strlen(path) + 1);
+	strcpy(dep->path, path);
+	dep->exists = !stat(path, &st);
+	if (dep->exists)
+		dep->mtime = st.st_mtim;
+	hash_add(dep_table, &dep->hnode, key);
+
+	return dep;
+}
+
+/* Strictly newer, as make compares timestamps. */
+static bool newer(const struct timespec *time_a, const struct timespec *time_b)
+{
+	if (time_a->tv_sec != time_b->tv_sec)
+		return time_a->tv_sec > time_b->tv_sec;
+
+	return time_a->tv_nsec > time_b->tv_nsec;
+}
+
+/*
+ * $(wildcard include/config/FOO) is a prerequisite only while FOO is set:
+ * unwrap it and say that it is optional.
+ */
+static bool line_unwrap_wildcard(struct line *line)
+{
+	if (!line_starts_with(line, WILDCARD_OPEN) ||
+	    !line_ends_with(line, WILDCARD_CLOSE))
+		return false;
+
+	line->text += strlen(WILDCARD_OPEN);
+	line->len -= strlen(WILDCARD_OPEN) + strlen(WILDCARD_CLOSE);
+
+	return true;
+}
+
+/* fixdep doubles '$' and escapes '#' in a path: undo that into path[]. */
+static bool unescape_path(const struct line *line, char *path, size_t size)
+{
+	size_t i, out_len = 0;
+
+	if (line->len >= size)
+		return false;
+
+	for (i = 0; i < line->len; i++) {
+		const char chr = line->text[i];
+		const char next_chr = i + 1 < line->len ? line->text[i + 1] : '\0';
+
+		if ((chr == '$' && next_chr == '$') || (chr == '\\' && next_chr == '#'))
+			i++;
+		path[out_len++] = line->text[i];
+	}
+	path[out_len] = '\0';
+
+	return true;
+}
+
+/* Is the path contained in line older than the target? */
+static bool dep_is_fresh(struct line line, const struct timespec *target)
+{
+	char path[PATH_MAX];
+	const struct dep *dep;
+	bool optional;
+
+	line_strip_continuation(&line);
+	line_trim(&line);
+	if (!line.len)
+		return false;
+
+	optional = line_unwrap_wildcard(&line);
+	if (!line.len || !unescape_path(&line, path, sizeof(path)))
+		return false;
+
+	/* A target can get 'remade' so its timestamp is meaningless. */
+	if (is_target(path))
+		return false;
+
+	dep = lookup_dep(path);
+	if (!dep->exists)
+		return optional;
+
+	return !newer(&dep->mtime, target);
+}
+
+/*
+ * Parse a dependency list which consists of one file per line and determine if
+ * all dependencies are 'fresh', i.e. older than the target.
+ */
+static bool deps_are_fresh(const char *pos, const char *end,
+			   const struct timespec *target)
+{
+	struct line line;
+
+	while (next_line(&pos, end, &line)) {
+		if (line_is_blank(&line))
+			return true;
+		if (!dep_is_fresh(line, target))
+			return false;
+		if (!line_is_continued(&line))
+			return true;
+	}
+
+	return true;
+}
+
+/*
+ * Find the "deps_" line in the input.
+ *
+ * On success returns true and *deps_off is set to its offset and *list is set
+ * to the list's own lines start or NULL if the line is not continued.
+ *
+ * Otherwise returns false if the prefix cannot be found.
+ */
+static bool find_deps(const char *buf, size_t len, size_t *deps_off,
+		      const char **list)
+{
+	const char *pos = buf, *end = buf + len;
+	struct line line;
+
+	while (next_line(&pos, end, &line)) {
+		if (!line_starts_with(&line, DEPS_PREFIX))
+			continue;
+
+		*deps_off = line.text - buf;
+		*list = line_is_continued(&line) ? pos : NULL;
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Is this the target of a .cmd file, i.e. 'dir/.name.cmd names dir/name.'?
+ */
+static bool target_of(const char *cmd_path, char *target, size_t size)
+{
+	const char *slash = strrchr(cmd_path, '/');
+	const char *base = slash ? slash + 1 : cmd_path;
+	const size_t dir_len = base - cmd_path;
+	const size_t affix_len = strlen(".") + strlen(CMD_SUFFIX);
+	const size_t base_len = strlen(base);
+
+	if (base[0] != '.' || !str_ends_with(base, CMD_SUFFIX) ||
+	    base_len <= affix_len)
+		return false;
+
+	return snprintf(target, size, "%.*s%.*s", (int)dir_len, cmd_path,
+			(int)(base_len - affix_len), base + 1) < (int)size;
+}
+
+/*
+ * Does the .cmd file's target exists and is it newer than everything in its
+ * dependency list?
+ *
+ * Returns true if so and sets *deps_off to the start of the list, otherwise
+ * returns false.
+ */
+static bool target_is_fresh(const char *cmd_path, const char *buf, size_t len,
+			    size_t *deps_off)
+{
+	char target[PATH_MAX];
+	struct stat st;
+	const char *list;
+
+	if (!target_of(cmd_path, target, sizeof(target)) || stat(target, &st))
+		return false;
+	if (!find_deps(buf, len, deps_off, &list))
+		return false;
+	if (!list)
+		return true;
+
+	return deps_are_fresh(list, buf + len, &st.st_mtim);
+}
+
+static char *read_file(const char *path, size_t *len)
+{
+	FILE *file = fopen(path, "r");
+	struct stat st;
+	char *buf;
+	size_t nr_read = 0;
+
+	if (!file)
+		return NULL;
+	if (fstat(fileno(file), &st)) {
+		fclose(file);
+		return NULL;
+	}
+
+	buf = xmalloc(st.st_size + 1);
+	while (nr_read < (size_t)st.st_size) {
+		const size_t chunk = fread(buf + nr_read, 1, st.st_size - nr_read, file);
+
+		if (!chunk)
+			break;
+		nr_read += chunk;
+	}
+	fclose(file);
+
+	buf[nr_read] = '\0';
+	*len = nr_read;
+	return buf;
+}
+
+/*
+ * Find the end of the dependency block: the offset just past its closing
+ * "$(deps_x):" line. Anything after that was appended by kbuild and is not for
+ * us to judge. Returns len if the line cannot be found.
+ */
+static size_t deps_block_end(const char *buf, size_t len, size_t deps_off)
+{
+	const char *pos = buf + deps_off, *end = buf + len;
+	struct line line;
+
+	while (next_line(&pos, end, &line)) {
+		if (line_starts_with(&line, DEPS_RULE_PREFIX) &&
+		    line_ends_with(&line, RULE_SUFFIX))
+			return pos - buf;
+	}
+
+	return len;
+}
+
+/* The target is fresh: pass on everything but the dependency block. */
+static void write_without_deps(FILE *out, const char *buf, size_t len,
+			       size_t deps_off)
+{
+	const size_t tail_off = deps_block_end(buf, len, deps_off);
+
+	fwrite(buf, 1, deps_off, out);
+	fputc('\n', out);
+	fwrite(buf + tail_off, 1, len - tail_off, out);
+}
+
+/*
+ * Generate a fragment for make from one .cmd file - without the dependency
+ * block if the target is fresh, otherwise all of it.
+ */
+static void process(FILE *out, const char *cmd_path)
+{
+	size_t len, deps_off;
+	char *buf;
+
+	buf = read_file(cmd_path, &len);
+	if (!buf)
+		return;
+
+	if (target_is_fresh(cmd_path, buf, len, &deps_off))
+		write_without_deps(out, buf, len, deps_off);
+	else
+		fwrite(buf, 1, len, out);
+
+	free(buf);
+}
+
+int main(int argc, char **argv)
+{
+	char tmp_path[PATH_MAX];
+	FILE *out;
+	int fd, i;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <output> <.cmd files...>\n", argv[0]);
+		return 1;
+	}
+
+	/*
+	 * Concurrent make instances can process the same directory at once so
+	 * use distinct temporary files and rename into place atomically.
+	 */
+	if (snprintf(tmp_path, sizeof(tmp_path), "%s.XXXXXX", argv[1]) >=
+	    (int)sizeof(tmp_path)) {
+		fprintf(stderr, "%s: path too long\n", argv[1]);
+		return 1;
+	}
+
+	fd = mkstemp(tmp_path);
+	if (fd < 0) {
+		perror(argv[1]);
+		return 1;
+	}
+	out = fdopen(fd, "w");
+	if (!out) {
+		perror(argv[1]);
+		close(fd);
+		unlink(tmp_path);
+		return 1;
+	}
+
+	for (i = 2; i < argc; i++) {
+		char target[PATH_MAX];
+
+		if (target_of(argv[i], target, sizeof(target)))
+			add_target(target);
+	}
+
+	for (i = 2; i < argc; i++)
+		process(out, argv[i]);
+
+	/* Write errors are latched in the stream, so one check at the end covers them all. */
+	if (ferror(out) || fclose(out) || rename(tmp_path, argv[1])) {
+		perror(argv[1]);
+		unlink(tmp_path);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index f12e1ffe409e..f33bd3f270c5 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -72,4 +72,4 @@ if [ "${CC}" != "${HOSTCC}" ]; then
 	rm -f "${destdir}/scripts/Kbuild"
 fi
 
-find "${destdir}" \( -name '.*.cmd' -o -name '*.o' \) -delete
+find "${destdir}" \( -name '.*.cmd' -o -name '.depcheck.mk*' -o -name '*.o' \) -delete

-- 
2.56.1

