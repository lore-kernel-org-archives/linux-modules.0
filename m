Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971491;
	b=LtWJZUewrbelWLgVg1DfXUmaPyINFAqo/Drp1QWzl3ee2d+8dclcAeQdVRD7TrPBKVrw
	 p0pLF9etx7TcbJgJcUqNS9bDAjsw3EgHvWFBZaiQLsNgMZRf6v010SFvHQv9b/mSYwrNS
	 pw1txiuvv+v9OEHis1syiVI6Ruv27gnH4GhISVPsWUNC6nSgBd3T8PpCyUKWLlJiHAaVi
	 e36tZWEMxe8DbGiTa2MGDA8tw8EajHXlNf24AjIuF7J7Q4VGxivArUl2HoPrqdX/3NuT3
	 Cs8A/frjClPjI91C2teP+3p7F4jX9Kx9N3FuD3pHUNaFz45xY938ZlWpWwqG0gdv+Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oZ/o78iDJrOgBtFoSeJLE1fpD/YVKmvlNgI/gW8G1vM=;
	b=V6ywz5mgl5GGgjJ+1+yNHDdFm+iAQR2FOHYDGBT/VIg61bbsqqL2e49NvSohhldWC2gZ
	 gNXbkxg5vkM/25XRaL6+VGPkl0iIMIF8GcNqoy1M0Iefj2GdrcNhLADIEFSqzkXt8h87F
	 vobBTRuAl6zWB/rI2zRnNlxQ8zCTREUuI98XmcxsO99j6+Oag20wGa62v4ghEYZ9uXFaI
	 EoUCzWQ9vgk4JO+tLBjkQL6CdOSIIAm6uLypjRItSEisf3gM0yl+y3xCOd/0Wr2rYt4JL
	 LTcQVXnGvaHJvrMUaAGnRxRubHc7EQS6J9HhWnuYGUgHJwT/fBAFYnnb3iXa2COjFKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P69NRBzy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4B606D80A;
	Fri,  6 Nov 2026 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P69NRBzy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3E21F008A5;
	Fri,  6 Nov 2026 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971490;
	bh=oZ/o78iDJrOgBtFoSeJLE1fpD/YVKmvlNgI/gW8G1vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P69NRBzyAac2mfKyvtOTigQ168HJqMhvBPWlQAYG5sXzzVNIb+9Gw3CVy68QGZr84
	 ihUCnVMftJsD/hYk+XAT6qS/axMjGjkBkSdrV786AkXfMVwPG48P5KHYHgsflvT7PZ
	 ANWO48SeRUBFN97cCj+XuA17YwXoTyxmT2rvrOf+rw8s1LrsUklJDyWjnz1BnSUWC7
	 GDfZT9fu/U9LRXLFzSZ4D6PgvxkkU3Si3gxaILA+pUD+fUHt4oxL63v1mEXHeZyUzH
	 UXoYFAFLP+6oR5UPpzFCeckvWkUQLAw8nSQW8htGmyT0Poed+J0A+o6mAFwDHxzkyn
	 Xoa9wnqc0BjCQ==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Juergen Gross <jgross@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
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
Subject: [PATCH v11 4/4] kallsyms: add KUnit tests for lineinfo feature
Date: Fri,  6 Nov 2026 08:24:32 -0500
Message-ID: <20261106132432.248387-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106132432.248387-1-sashal@kernel.org>
References: <20261106132432.248387-1-sashal@kernel.org>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test module (CONFIG_LINEINFO_KUNIT_TEST) that verifies the
kallsyms lineinfo feature produces correct source file:line annotations
in stack traces.

Export sprint_backtrace() and sprint_backtrace_build_id() with
EXPORT_SYMBOL_IF_KUNIT() so the test module can exercise the backtrace
APIs.

test_cross_file_inline() pins the row-selection rule: a header helper
is inlined into a caller in another file, and some address inside that
caller has to resolve to the header.  Picking any row but the last at a
given address reports the call site instead, which no test that only
looks at its own file can notice.

The test module is built from two objects.  A single-object module cannot
distinguish relocated per-compile-unit DWARF references from unrelocated
ones -- its only compile unit sits at offset 0, which is what an
unrelocated reference reads -- so test_second_object_lineinfo() resolves a
target in the second object to cover the general case.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kallsyms.c                 |    4 +
 lib/Kconfig.debug                 |   10 +
 lib/tests/Makefile                |    4 +
 lib/tests/lineinfo_kunit.c        | 1087 +++++++++++++++++++++++++++++
 lib/tests/lineinfo_kunit.h        |   22 +
 lib/tests/lineinfo_kunit_second.c |   21 +
 6 files changed, 1148 insertions(+)
 create mode 100644 lib/tests/lineinfo_kunit.c
 create mode 100644 lib/tests/lineinfo_kunit.h
 create mode 100644 lib/tests/lineinfo_kunit_second.c

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 395297e27af53..a33b5fd619e65 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -32,6 +32,8 @@
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
 
+#include <kunit/visibility.h>
+
 #include "kallsyms_internal.h"
 
 /*
@@ -661,6 +663,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
 {
 	return __sprint_symbol(buffer, address, -1, 1, 0, 1);
 }
+EXPORT_SYMBOL_IF_KUNIT(sprint_backtrace);
 
 /**
  * sprint_backtrace_build_id - Look up a backtrace symbol and return it in a text buffer
@@ -681,6 +684,7 @@ int sprint_backtrace_build_id(char *buffer, unsigned long address)
 {
 	return __sprint_symbol(buffer, address, -1, 1, 1, 1);
 }
+EXPORT_SYMBOL_IF_KUNIT(sprint_backtrace_build_id);
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a6..8759182dbd9ea 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3126,6 +3126,16 @@ config LONGEST_SYM_KUNIT_TEST
 
 	  If unsure, say N.
 
+config LINEINFO_KUNIT_TEST
+	tristate "KUnit tests for kallsyms lineinfo" if !KUNIT_ALL_TESTS
+	depends on KUNIT && KALLSYMS_LINEINFO
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the kallsyms source line info feature.
+	  Verifies that stack traces include correct (file.c:line) annotations.
+
+	  If unsure, say N.
+
 config HW_BREAKPOINT_KUNIT_TEST
 	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 	depends on HAVE_HW_BREAKPOINT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b91fa..39c3742054708 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -39,6 +39,10 @@ obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
 
+CFLAGS_lineinfo_kunit.o += $(call cc-option,-fno-inline-functions-called-once)
+obj-$(CONFIG_LINEINFO_KUNIT_TEST) += lineinfo_kunit_test.o
+lineinfo_kunit_test-y := lineinfo_kunit.o lineinfo_kunit_second.o
+
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) += min_heap_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
diff --git a/lib/tests/lineinfo_kunit.c b/lib/tests/lineinfo_kunit.c
new file mode 100644
index 0000000000000..fc1b97ffb5251
--- /dev/null
+++ b/lib/tests/lineinfo_kunit.c
@@ -0,0 +1,1087 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for kallsyms lineinfo (CONFIG_KALLSYMS_LINEINFO).
+ *
+ * Copyright (c) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * Verifies that sprint_symbol() and related APIs append correct
+ * " (file.c:NNN)" annotations to kernel symbol lookups.
+ *
+ * Build with: CONFIG_LINEINFO_KUNIT_TEST=m (or =y)
+ * Run with:   ./tools/testing/kunit/kunit.py run lineinfo
+ */
+
+#include <kunit/test.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <asm/sections.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/mod_lineinfo.h>
+
+#include "lineinfo_kunit.h"
+
+/* --------------- helpers --------------- */
+
+static char *alloc_sym_buf(struct kunit *test)
+{
+	char *buf = kunit_kzalloc(test, KSYM_SYMBOL_LEN, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	return buf;
+}
+
+/*
+ * Function-pointer casts yield the descriptor address on architectures
+ * with function descriptors (e.g. ppc64 ELFv1, parisc64); resolve to the
+ * code address the lineinfo tables actually cover.
+ */
+static unsigned long target_addr(const void *fn)
+{
+	return (unsigned long)dereference_function_descriptor((void *)fn);
+}
+
+/*
+ * When the test is built as a module but CONFIG_KALLSYMS_LINEINFO_MODULES
+ * is disabled, the test module's own functions have no lineinfo tables, so
+ * every test that expects annotations on local targets must skip rather
+ * than fail.
+ */
+static void skip_without_module_lineinfo(struct kunit *test)
+{
+	if (IS_MODULE(CONFIG_LINEINFO_KUNIT_TEST) &&
+	    !IS_ENABLED(CONFIG_KALLSYMS_LINEINFO_MODULES))
+		kunit_skip(test,
+			   "KALLSYMS_LINEINFO_MODULES disabled; test module has no lineinfo");
+}
+
+/*
+ * Format a symbol the way a stack trace prints it.  Every variant that
+ * prints an offset appends the " (file:line)" annotation: sprint_symbol()
+ * behind %pS, sprint_symbol_build_id() behind %pSb and sprint_backtrace()
+ * behind %pB.  Only sprint_symbol_no_offset(), behind %ps, leaves it off.
+ *
+ * sprint_backtrace() subtracts 1 from the address to handle tail-call
+ * return-address corrections; pass @addr + 1 to recover the original.
+ */
+static int sprint_with_lineinfo(char *buf, unsigned long addr)
+{
+	return sprint_backtrace(buf, addr + 1);
+}
+
+/*
+ * Whether two sprint_*() results name the same symbol.  Compared on the
+ * output rather than against a spelled-out name, since the PowerPC ELFv1
+ * ABI gives code symbols a leading dot.
+ */
+static bool same_symbol(const char *a, const char *b)
+{
+	size_t len = strcspn(a, "+");
+
+	return len == strcspn(b, "+") && !strncmp(a, b, len);
+}
+
+/*
+ * Return true if @buf contains a lineinfo annotation matching
+ * the pattern " (<path>:<digits>)".
+ *
+ * The path may be a full path like "lib/tests/lineinfo_kunit.c" or
+ * a shortened form from module lineinfo (e.g., just a directory name).
+ */
+static bool has_lineinfo(const char *buf)
+{
+	const char *p, *colon, *end;
+
+	p = strstr(buf, " (");
+	if (!p)
+		return false;
+	p += 2; /* skip " (" */
+
+	colon = strchr(p, ':');
+	if (!colon || colon == p)
+		return false;
+
+	/* After colon: one or more digits then ')' */
+	end = colon + 1;
+	if (*end < '0' || *end > '9')
+		return false;
+	while (*end >= '0' && *end <= '9')
+		end++;
+	return *end == ')';
+}
+
+/*
+ * Extract line number from a lineinfo annotation.
+ * Returns 0 if not found.
+ */
+static unsigned int extract_line(const char *buf)
+{
+	const char *p, *colon;
+	unsigned int line = 0;
+
+	p = strstr(buf, " (");
+	if (!p)
+		return 0;
+
+	colon = strchr(p + 2, ':');
+	if (!colon)
+		return 0;
+
+	colon++;
+	while (*colon >= '0' && *colon <= '9') {
+		line = line * 10 + (*colon - '0');
+		colon++;
+	}
+	return line;
+}
+
+/*
+ * Check if the lineinfo annotation contains the given filename substring.
+ */
+static bool lineinfo_contains_file(const char *buf, const char *name)
+{
+	const char *p, *colon;
+
+	p = strstr(buf, " (");
+	if (!p)
+		return false;
+
+	colon = strchr(p + 2, ':');
+	if (!colon)
+		return false;
+
+	/* Search for @name between '(' and ':' */
+	return strnstr(p + 1, name, colon - p - 1) != NULL;
+}
+
+/* --------------- target functions --------------- */
+
+static noinline int lineinfo_target_normal(void)
+{
+	barrier();
+	return 42;
+}
+
+static noinline int lineinfo_target_short(void)
+{
+	barrier();
+	return 1;
+}
+
+static noinline int lineinfo_target_with_arg(int x)
+{
+	barrier();
+	return x + 1;
+}
+
+static noinline int lineinfo_target_many_lines(void)
+{
+	/*
+	 * volatile forces a load/store per statement so the function keeps
+	 * one line-table row per source line (and a body large enough for
+	 * mid-function lookups) at any optimization level; without it the
+	 * compiler folds the arithmetic to a single constant.
+	 */
+	volatile int a = 0;
+
+	barrier();
+	a += 1;
+	a += 2;
+	a += 3;
+	a += 4;
+	a += 5;
+	a += 6;
+	a += 7;
+	a += 8;
+	a += 9;
+	a += 10;
+	barrier();
+	return a;
+}
+
+static __always_inline int lineinfo_inline_helper(void)
+{
+	return 99;
+}
+
+static noinline int lineinfo_inline_caller(void)
+{
+	barrier();
+	return lineinfo_inline_helper();
+}
+
+static noinline int lineinfo_cross_file_caller(int x)
+{
+	return lineinfo_header_helper(x);
+}
+
+/* 10-deep call chain */
+static noinline int lineinfo_chain_10(void) { barrier(); return 10; }
+static noinline int lineinfo_chain_9(void)  { barrier(); return lineinfo_chain_10(); }
+static noinline int lineinfo_chain_8(void)  { barrier(); return lineinfo_chain_9(); }
+static noinline int lineinfo_chain_7(void)  { barrier(); return lineinfo_chain_8(); }
+static noinline int lineinfo_chain_6(void)  { barrier(); return lineinfo_chain_7(); }
+static noinline int lineinfo_chain_5(void)  { barrier(); return lineinfo_chain_6(); }
+static noinline int lineinfo_chain_4(void)  { barrier(); return lineinfo_chain_5(); }
+static noinline int lineinfo_chain_3(void)  { barrier(); return lineinfo_chain_4(); }
+static noinline int lineinfo_chain_2(void)  { barrier(); return lineinfo_chain_3(); }
+static noinline int lineinfo_chain_1(void)  { barrier(); return lineinfo_chain_2(); }
+
+/* --------------- Group A: Basic lineinfo presence --------------- */
+
+static void test_normal_function(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf, "lineinfo_kunit.c"),
+			      "Wrong file in: %s", buf);
+}
+
+static void test_noinline_function(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_with_arg);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in: %s", buf);
+}
+
+static void test_inline_function(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_inline_caller);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo for inline caller in: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf, "lineinfo_kunit.c"),
+			      "Wrong file in: %s", buf);
+}
+
+/*
+ * The inlined body has to win over the call site.  Several line-program
+ * rows share the address where an inlined call begins, and all but the
+ * last cover zero bytes; picking any other row reports the caller's file,
+ * which is what addr2line would not do.
+ */
+static void test_cross_file_inline(struct kunit *test)
+{
+	char *first = alloc_sym_buf(test);
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_cross_file_caller);
+	bool found = false;
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(first, addr);
+
+	/*
+	 * Walk the function while the symbol still resolves to it, rather
+	 * than asking kallsyms for its size: kallsyms_lookup_size_offset()
+	 * is not exported to modules.
+	 */
+	for (unsigned long i = 0; i < 4096; i++) {
+		sprint_with_lineinfo(buf, addr + i);
+		if (!same_symbol(buf, first))
+			break;
+		if (lineinfo_contains_file(buf, "lineinfo_kunit.h")) {
+			found = true;
+			break;
+		}
+	}
+
+	KUNIT_EXPECT_TRUE_MSG(test, found,
+			      "no address in lineinfo_cross_file_caller resolves to the inlined body's header");
+}
+
+static void test_short_function(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_short);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo for short function in: %s", buf);
+}
+
+static void test_many_lines_function(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_many_lines);
+	unsigned int line;
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in: %s", buf);
+	line = extract_line(buf);
+	KUNIT_EXPECT_GT_MSG(test, line, (unsigned int)0,
+			    "Line number should be > 0 in: %s", buf);
+}
+
+/* --------------- Group B: Deep call chain --------------- */
+
+typedef int (*chain_fn_t)(void);
+
+static void test_deep_call_chain(struct kunit *test)
+{
+	static const chain_fn_t chain_fns[] = {
+		lineinfo_chain_1,  lineinfo_chain_2,
+		lineinfo_chain_3,  lineinfo_chain_4,
+		lineinfo_chain_5,  lineinfo_chain_6,
+		lineinfo_chain_7,  lineinfo_chain_8,
+		lineinfo_chain_9,  lineinfo_chain_10,
+	};
+	char *buf = alloc_sym_buf(test);
+	int i, found = 0;
+
+	skip_without_module_lineinfo(test);
+
+	/* Call chain to prevent dead-code elimination */
+	KUNIT_ASSERT_EQ(test, lineinfo_chain_1(), 10);
+
+	for (i = 0; i < ARRAY_SIZE(chain_fns); i++) {
+		unsigned long addr = target_addr(chain_fns[i]);
+
+		sprint_with_lineinfo(buf, addr);
+		if (has_lineinfo(buf))
+			found++;
+	}
+
+	/*
+	 * Not every tiny function gets DWARF line info (compiler may
+	 * omit it for very small stubs), but at least some should.
+	 */
+	KUNIT_EXPECT_GT_MSG(test, found, 0,
+			    "None of the 10 chain functions had lineinfo");
+}
+
+/* --------------- Group C: sprint_symbol API variants --------------- */
+
+static void test_sprint_symbol_format(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	sprint_symbol(buf, addr);
+
+	/* Should contain +0x and /0x for offset/size */
+	KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(buf, "+0x"),
+				  "Missing offset in: %s", buf);
+	KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(buf, "/0x"),
+				  "Missing size in: %s", buf);
+	/*
+	 * Only sprint_symbol_no_offset(), which backs lowercase %ps, stays
+	 * bare; see test_sprint_symbol_no_offset().
+	 */
+	skip_without_module_lineinfo(test);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "Missing lineinfo in sprint_symbol output: %s",
+			      buf);
+}
+
+static void test_sprint_backtrace(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	/* sprint_backtrace subtracts 1 internally to handle tail calls */
+	sprint_backtrace(buf, addr + 1);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in backtrace: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf, "lineinfo_kunit.c"),
+			      "Wrong file in backtrace: %s", buf);
+}
+
+static void test_sprint_backtrace_build_id(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_backtrace_build_id(buf, addr + 1);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in backtrace_build_id: %s", buf);
+}
+
+static void test_sprint_symbol_no_offset(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	sprint_symbol_no_offset(buf, addr);
+	/* No "+0x" in output */
+	KUNIT_EXPECT_NULL_MSG(test, strstr(buf, "+0x"),
+			      "Unexpected offset in no_offset: %s", buf);
+	/*
+	 * The one variant that stays bare: it backs lowercase %ps, which
+	 * callers suffix with a literal "()".
+	 */
+	KUNIT_EXPECT_FALSE_MSG(test, has_lineinfo(buf),
+			       "Unexpected lineinfo in no_offset: %s", buf);
+}
+
+/* --------------- Group D: printk format specifiers --------------- */
+
+static void test_pS_format(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	void *addr = lineinfo_target_normal;
+
+	skip_without_module_lineinfo(test);
+
+	snprintf(buf, KSYM_SYMBOL_LEN, "%pS", addr);
+	/*
+	 * %pS uses sprint_symbol(), which annotates: the generic
+	 * stack_trace_print() prints every frame with %pS.
+	 */
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "Missing lineinfo in %%pS: %s", buf);
+}
+
+static void test_pBb_format(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	/*
+	 * %pBb uses sprint_backtrace_build_id which subtracts 1 from the
+	 * address, so pass addr+1 to resolve back to the function.
+	 */
+	void *addr = (void *)(target_addr(lineinfo_target_normal) + 1);
+
+	skip_without_module_lineinfo(test);
+
+	snprintf(buf, KSYM_SYMBOL_LEN, "%pBb", addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in %%pBb: %s", buf);
+}
+
+static void test_pSR_format(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	void *addr = lineinfo_target_normal;
+
+	skip_without_module_lineinfo(test);
+
+	snprintf(buf, KSYM_SYMBOL_LEN, "%pSR", addr);
+	/* %pSR is a sprint_symbol() variant; same rationale as %pS. */
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "Missing lineinfo in %%pSR: %s", buf);
+}
+
+/* --------------- Group E: Address edge cases --------------- */
+
+static void test_symbol_start_addr(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	/*
+	 * sprint_with_lineinfo() passes the start plus one, which
+	 * sprint_backtrace() looks up as the start itself but prints as
+	 * "+0x1/".  Verify the symbol resolves and carries lineinfo.
+	 */
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      strnstr(buf, "lineinfo_target_normal",
+				      KSYM_SYMBOL_LEN) != NULL,
+			      "Didn't resolve to expected function: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo at function start: %s", buf);
+}
+
+static void test_symbol_nonzero_offset(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	/*
+	 * sprint_backtrace subtracts 1 internally.
+	 * Passing addr+2 resolves to addr+1 which is inside the function
+	 * at a non-zero offset.
+	 */
+	sprint_backtrace(buf, addr + 2);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      strnstr(buf, "lineinfo_target_normal",
+				      KSYM_SYMBOL_LEN) != NULL,
+			      "Didn't resolve to expected function: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo at non-zero offset: %s", buf);
+}
+
+static void test_unknown_address(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+
+	sprint_symbol(buf, 1UL);
+	/* Should be "0x1" with no lineinfo */
+	KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(buf, "0x1"),
+				  "Expected hex address for bogus addr: %s", buf);
+	KUNIT_EXPECT_FALSE_MSG(test, has_lineinfo(buf),
+			       "Unexpected lineinfo for bogus addr: %s", buf);
+}
+
+static void test_kernel_function_lineinfo(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(sprint_symbol);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo for sprint_symbol: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf, "kallsyms.c"),
+			      "Expected kallsyms.c in: %s", buf);
+}
+
+static void test_init_text_no_stale_lineinfo(struct kunit *test)
+{
+#if IS_BUILTIN(CONFIG_LINEINFO_KUNIT_TEST)
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = (unsigned long)_sinittext + 16;
+
+	/*
+	 * The table stops at _etext, so a lookup past it must not inherit
+	 * the last covered entry.  Not every layout puts .init.text there:
+	 * UML links it inside [_text, _etext), where an annotation is the
+	 * correct answer and proves nothing about the cap.
+	 */
+	if (addr >= (unsigned long)_text && addr < (unsigned long)_etext)
+		kunit_skip(test, "init text is inside [_text, _etext) in this layout");
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_FALSE_MSG(test, has_lineinfo(buf),
+			       "Stale lineinfo for init-text address: %s", buf);
+#else
+	kunit_skip(test, "_sinittext not accessible from modules");
+#endif
+}
+
+/* --------------- Group F: Module path --------------- */
+
+static void test_second_object_lineinfo(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_second_file);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo in: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf,
+						     "lineinfo_kunit_second.c"),
+			      "Wrong file in: %s", buf);
+}
+
+static void test_module_function_lineinfo(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	if (!IS_MODULE(CONFIG_LINEINFO_KUNIT_TEST)) {
+		kunit_skip(test, "Test only meaningful when built as module");
+		return;
+	}
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_EXPECT_NOT_NULL_MSG(test,
+				  strstr(buf, "[lineinfo_kunit"),
+				  "Missing module name in: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "No lineinfo for module function: %s", buf);
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_contains_file(buf, "lineinfo_kunit.c"),
+			      "Wrong file for module function: %s", buf);
+}
+
+/* --------------- Group G: Stress --------------- */
+
+struct lineinfo_stress_data {
+	unsigned long addr;
+	atomic_t failures;
+};
+
+static void lineinfo_stress_fn(void *info)
+{
+	struct lineinfo_stress_data *data = info;
+	char buf[KSYM_SYMBOL_LEN];
+	int i;
+
+	for (i = 0; i < 100; i++) {
+		sprint_with_lineinfo(buf, data->addr);
+		if (!has_lineinfo(buf))
+			atomic_inc(&data->failures);
+	}
+}
+
+static void test_concurrent_sprint_symbol(struct kunit *test)
+{
+	struct lineinfo_stress_data data;
+
+	skip_without_module_lineinfo(test);
+
+	data.addr = target_addr(lineinfo_target_normal);
+	atomic_set(&data.failures, 0);
+
+	on_each_cpu(lineinfo_stress_fn, &data, 1);
+
+	KUNIT_EXPECT_EQ_MSG(test, atomic_read(&data.failures), 0,
+			    "Concurrent lineinfo failures detected");
+}
+
+static void test_rapid_sprint_symbol(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+	int i, failures = 0;
+
+	skip_without_module_lineinfo(test);
+
+	for (i = 0; i < 1000; i++) {
+		sprint_with_lineinfo(buf, addr);
+		if (!has_lineinfo(buf))
+			failures++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
+			    "Rapid sprint_symbol failures: %d/1000", failures);
+}
+
+/* --------------- Group H: Safety and plausibility --------------- */
+
+static void test_line_number_plausible(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+	unsigned int line;
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_ASSERT_TRUE(test, has_lineinfo(buf));
+
+	line = extract_line(buf);
+	KUNIT_EXPECT_GT_MSG(test, line, (unsigned int)0,
+			    "Line number should be > 0");
+	KUNIT_EXPECT_LT_MSG(test, line, (unsigned int)10000,
+			    "Line number %u implausibly large for this file",
+			    line);
+}
+
+static void test_buffer_no_overflow(struct kunit *test)
+{
+	const size_t canary_size = 16;
+	char *buf;
+	int i;
+
+	buf = kunit_kzalloc(test, KSYM_SYMBOL_LEN + canary_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	/* Fill canary area past KSYM_SYMBOL_LEN with 0xAA */
+	memset(buf + KSYM_SYMBOL_LEN, 0xAA, canary_size);
+
+	sprint_with_lineinfo(buf, target_addr(lineinfo_target_normal));
+
+	/* Verify canary bytes are untouched */
+	for (i = 0; i < canary_size; i++) {
+		KUNIT_EXPECT_EQ_MSG(test,
+				    (unsigned char)buf[KSYM_SYMBOL_LEN + i],
+				    (unsigned char)0xAA,
+				    "Buffer overflow at offset %d past KSYM_SYMBOL_LEN",
+				    i);
+	}
+}
+
+static void test_dump_stack_no_crash(struct kunit *test)
+{
+	/* Just verify dump_stack() completes without panic */
+	dump_stack();
+	KUNIT_SUCCEED(test);
+}
+
+static void test_sprint_symbol_build_id(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+
+	skip_without_module_lineinfo(test);
+
+	sprint_symbol_build_id(buf, addr);
+	/*
+	 * Annotated: this backs %pSb, which is how arm64's
+	 * dump_backtrace_entry() prints every frame.
+	 */
+	KUNIT_EXPECT_TRUE_MSG(test, has_lineinfo(buf),
+			      "Missing lineinfo in sprint_symbol_build_id: %s",
+			      buf);
+}
+
+static void test_sleb128_edge_cases(struct kunit *test)
+{
+	u32 pos;
+	int32_t result;
+
+	/* Value 0: single byte 0x00 */
+	{
+		static const u8 data[] = { 0x00 };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)0);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value -1: single byte 0x7F */
+	{
+		static const u8 data[] = { 0x7f };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)-1);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value 1: single byte 0x01 */
+	{
+		static const u8 data[] = { 0x01 };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)1);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value -64: single byte 0x40 */
+	{
+		static const u8 data[] = { 0x40 };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)-64);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value 63: single byte 0x3F */
+	{
+		static const u8 data[] = { 0x3f };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)63);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value -128: two bytes 0x80 0x7F */
+	{
+		static const u8 data[] = { 0x80, 0x7f };
+
+		pos = 0;
+		result = lineinfo_read_sleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)-128);
+		KUNIT_EXPECT_EQ(test, pos, (u32)2);
+	}
+
+	/* Value INT32_MIN: five bytes, high bits land at shift 28 */
+	{
+		static const u8 data[] = { 0x80, 0x80, 0x80, 0x80, 0x78 };
+		const u8 *p = data;
+
+		/* Defeat constant folding so the runtime decoder runs. */
+		OPTIMIZER_HIDE_VAR(p);
+		pos = 0;
+		result = lineinfo_read_sleb128(p, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)INT_MIN);
+		KUNIT_EXPECT_EQ(test, pos, (u32)5);
+	}
+
+	/* Value INT32_MAX: five bytes */
+	{
+		static const u8 data[] = { 0xff, 0xff, 0xff, 0xff, 0x07 };
+		const u8 *p = data;
+
+		OPTIMIZER_HIDE_VAR(p);
+		pos = 0;
+		result = lineinfo_read_sleb128(p, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (int32_t)INT_MAX);
+		KUNIT_EXPECT_EQ(test, pos, (u32)5);
+	}
+}
+
+static void test_uleb128_edge_cases(struct kunit *test)
+{
+	u32 pos, result;
+
+	/* Value 0: single byte 0x00 */
+	{
+		static const u8 data[] = { 0x00 };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (u32)0);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value 127: single byte 0x7F */
+	{
+		static const u8 data[] = { 0x7F };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (u32)127);
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+
+	/* Value 128: two bytes 0x80 0x01 */
+	{
+		static const u8 data[] = { 0x80, 0x01 };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (u32)128);
+		KUNIT_EXPECT_EQ(test, pos, (u32)2);
+	}
+
+	/* Max u32 0xFFFFFFFF: 5 bytes */
+	{
+		static const u8 data[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0x0F };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, sizeof(data));
+		KUNIT_EXPECT_EQ(test, result, (u32)0xFFFFFFFF);
+		KUNIT_EXPECT_EQ(test, pos, (u32)5);
+	}
+
+	/* Truncated input: pos >= end returns 0 */
+	{
+		static const u8 data[] = { 0x80 };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, 0);
+		KUNIT_EXPECT_EQ_MSG(test, result, (u32)0,
+				    "Expected 0 for empty input");
+	}
+
+	/* Truncated mid-varint: continuation byte but end reached */
+	{
+		static const u8 data[] = { 0x80 };
+
+		pos = 0;
+		result = lineinfo_read_uleb128(data, &pos, 1);
+		KUNIT_EXPECT_EQ_MSG(test, result, (u32)0,
+				    "Expected 0 for truncated varint");
+		KUNIT_EXPECT_EQ(test, pos, (u32)1);
+	}
+}
+
+/*
+ * The symbol-boundary guard must reject an entry belonging to a preceding
+ * symbol, but must still accept one that sits exactly on the symbol start.
+ *
+ * gen_lineinfo used to collapse the second of two entries sharing a
+ * file:line, which left functions whose first entry was collapsed with
+ * nothing at or above their own start -- so this rejected them and the
+ * frame printed unannotated.  The generator now keeps (or synthesizes) an
+ * entry at every symbol start; this pins down the contract it relies on.
+ */
+static void test_lineinfo_search_min_offset(struct kunit *test)
+{
+	/*
+	 * One block, two entries with identical file:line at offsets 0 and
+	 * 0x40 -- exactly the pair deduplicate() used to collapse.
+	 * Entry 0 is uleb(file_id), uleb(line); the rest are
+	 * uleb(addr_delta), sleb(file_delta), sleb(line_delta).
+	 */
+	static const u8 data[] = { 0x00, 0x0a, 0x40, 0x00, 0x00 };
+	static const u32 blk_addrs[] = { 0 };
+	static const u32 blk_offsets[] = { 0 };
+	static const u32 file_offsets[] = { 0 };
+	static const char filenames[] = "test.c";
+	const struct lineinfo_table tbl = {
+		.blk_addrs	= blk_addrs,
+		.blk_offsets	= blk_offsets,
+		.data		= data,
+		.data_size	= sizeof(data),
+		.file_offsets	= file_offsets,
+		.filenames	= filenames,
+		.num_entries	= 2,
+		.num_blocks	= 1,
+		.num_files	= 1,
+		.filenames_size	= sizeof(filenames),
+	};
+	const char *file;
+	unsigned int line;
+
+	/* Symbol starts at 0x40 and owns the entry there: must resolve. */
+	file = NULL;
+	line = 0;
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      lineinfo_search(&tbl, 0x50, 0x40, &file, &line),
+			      "entry exactly at the symbol start was rejected");
+	KUNIT_EXPECT_STREQ(test, file, "test.c");
+	KUNIT_EXPECT_EQ(test, line, 10u);
+
+	/* No min_offset bound: same answer. */
+	file = NULL;
+	line = 0;
+	KUNIT_EXPECT_TRUE(test,
+			  lineinfo_search(&tbl, 0x50, 0, &file, &line));
+	KUNIT_EXPECT_EQ(test, line, 10u);
+
+	/*
+	 * Symbol starts at 0x60, above every entry: the 0x40 entry belongs
+	 * to a preceding symbol and must not leak into this one.
+	 */
+	KUNIT_EXPECT_FALSE_MSG(test,
+			       lineinfo_search(&tbl, 0x70, 0x60, &file, &line),
+			       "entry below the symbol start was accepted");
+}
+
+static void test_line_number_accuracy(struct kunit *test)
+{
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_normal);
+	unsigned int line;
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(buf, addr);
+	KUNIT_ASSERT_TRUE(test, has_lineinfo(buf));
+
+	line = extract_line(buf);
+
+	/*
+	 * lineinfo_target_normal is defined around line 103-107.
+	 * Allow wide range: KASAN instrumentation and module lineinfo
+	 * address mapping can shift the reported line significantly.
+	 */
+	KUNIT_EXPECT_GE_MSG(test, line, (unsigned int)50,
+			    "Line %u too low for lineinfo_target_normal", line);
+	KUNIT_EXPECT_LE_MSG(test, line, (unsigned int)300,
+			    "Line %u too high for lineinfo_target_normal", line);
+}
+
+static void test_many_lines_mid_function(struct kunit *test)
+{
+	char *first = alloc_sym_buf(test);
+	char *buf = alloc_sym_buf(test);
+	unsigned long addr = target_addr(lineinfo_target_many_lines);
+	unsigned int line = 0;
+
+	skip_without_module_lineinfo(test);
+
+	sprint_with_lineinfo(first, addr);
+	KUNIT_ASSERT_TRUE(test, has_lineinfo(first));
+
+	/*
+	 * Find an annotated address from 8 bytes in (past the prologue)
+	 * onwards.  A fixed offset is not enough: instrumentation such as
+	 * KCOV or KCSAN can leave stretches that DWARF attributes to line 0,
+	 * which correctly print no annotation.  Hide the base from the
+	 * compiler so this does not become a static mid-function relocation
+	 * (sym+8), which objtool flags as a relocation to !ENDBR with
+	 * CONFIG_X86_KERNEL_IBT.
+	 */
+	OPTIMIZER_HIDE_VAR(addr);
+	for (unsigned long i = 8; i < 4096; i++) {
+		sprint_with_lineinfo(buf, addr + i);
+		if (!same_symbol(buf, first))
+			break;
+		if (has_lineinfo(buf)) {
+			line = extract_line(buf);
+			break;
+		}
+	}
+
+	KUNIT_ASSERT_GT_MSG(test, line, (unsigned int)0,
+			    "No annotated address after: %s", first);
+	KUNIT_EXPECT_GE_MSG(test, line, (unsigned int)50,
+			    "Line %u too low for mid-function", line);
+	KUNIT_EXPECT_LE_MSG(test, line, (unsigned int)700,
+			    "Line %u too high for mid-function", line);
+}
+
+/* --------------- Suite registration --------------- */
+
+static struct kunit_case lineinfo_test_cases[] = {
+	/* Group A: Basic lineinfo presence */
+	KUNIT_CASE(test_normal_function),
+	KUNIT_CASE(test_noinline_function),
+	KUNIT_CASE(test_inline_function),
+	KUNIT_CASE(test_cross_file_inline),
+	KUNIT_CASE(test_short_function),
+	KUNIT_CASE(test_many_lines_function),
+	/* Group B: Deep call chain */
+	KUNIT_CASE(test_deep_call_chain),
+	/* Group C: sprint_symbol API variants */
+	KUNIT_CASE(test_sprint_symbol_format),
+	KUNIT_CASE(test_sprint_backtrace),
+	KUNIT_CASE(test_sprint_backtrace_build_id),
+	KUNIT_CASE(test_sprint_symbol_no_offset),
+	/* Group D: printk format specifiers */
+	KUNIT_CASE(test_pS_format),
+	KUNIT_CASE(test_pBb_format),
+	KUNIT_CASE(test_pSR_format),
+	/* Group E: Address edge cases */
+	KUNIT_CASE(test_symbol_start_addr),
+	KUNIT_CASE(test_symbol_nonzero_offset),
+	KUNIT_CASE(test_unknown_address),
+	KUNIT_CASE(test_kernel_function_lineinfo),
+	KUNIT_CASE(test_init_text_no_stale_lineinfo),
+	/* Group F: Module path */
+	KUNIT_CASE(test_module_function_lineinfo),
+	KUNIT_CASE(test_second_object_lineinfo),
+	/* Group G: Stress */
+	KUNIT_CASE_SLOW(test_concurrent_sprint_symbol),
+	KUNIT_CASE_SLOW(test_rapid_sprint_symbol),
+	/* Group H: Safety and plausibility */
+	KUNIT_CASE(test_line_number_plausible),
+	KUNIT_CASE(test_buffer_no_overflow),
+	KUNIT_CASE(test_dump_stack_no_crash),
+	KUNIT_CASE(test_sprint_symbol_build_id),
+	/* Group I: Encoding/decoding and accuracy */
+	KUNIT_CASE(test_sleb128_edge_cases),
+	KUNIT_CASE(test_uleb128_edge_cases),
+	KUNIT_CASE(test_lineinfo_search_min_offset),
+	KUNIT_CASE(test_line_number_accuracy),
+	KUNIT_CASE(test_many_lines_mid_function),
+	{}
+};
+
+static struct kunit_suite lineinfo_test_suite = {
+	.name = "lineinfo",
+	.test_cases = lineinfo_test_cases,
+};
+kunit_test_suites(&lineinfo_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for kallsyms lineinfo");
+MODULE_AUTHOR("Sasha Levin");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/lib/tests/lineinfo_kunit.h b/lib/tests/lineinfo_kunit.h
new file mode 100644
index 0000000000000..ba436073855c2
--- /dev/null
+++ b/lib/tests/lineinfo_kunit.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LIB_TESTS_LINEINFO_KUNIT_H
+#define _LIB_TESTS_LINEINFO_KUNIT_H
+
+#include <linux/compiler.h>
+
+int lineinfo_target_second_file(int x);
+
+/*
+ * Inlined into lineinfo_cross_file_caller() in lineinfo_kunit.c, so the
+ * addresses it covers must resolve to this header rather than to the
+ * caller's file.  __always_inline because the test object is built with
+ * -fno-inline-functions-called-once.  The call gives the inlined body an
+ * instruction of its own: an arm64 build can fold "x + 1" into the
+ * caller's return sequence and leave no address attributed to this file.
+ */
+static __always_inline int lineinfo_header_helper(int x)
+{
+	return lineinfo_target_second_file(x) + 1;
+}
+
+#endif /* _LIB_TESTS_LINEINFO_KUNIT_H */
diff --git a/lib/tests/lineinfo_kunit_second.c b/lib/tests/lineinfo_kunit_second.c
new file mode 100644
index 0000000000000..1151de15c1daf
--- /dev/null
+++ b/lib/tests/lineinfo_kunit_second.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Second translation unit of the lineinfo KUnit test module.
+ *
+ * Copyright (c) 2026 Sasha Levin <sashal@kernel.org>
+ *
+ * A module built from one object file cannot tell whether per-compile-unit
+ * DWARF references were relocated: its only compile unit sits at offset 0,
+ * which is exactly what an unrelocated reference reads.  Keeping a target
+ * function in a second object makes the test cover the general case.
+ */
+
+#include <linux/compiler.h>
+
+#include "lineinfo_kunit.h"
+
+noinline int lineinfo_target_second_file(int x)
+{
+	barrier();
+	return x + 1;
+}
-- 
2.53.0

