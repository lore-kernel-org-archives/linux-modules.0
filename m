Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CC4457D7
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230223; cv=none; b=eS5k3K3tYM0nJ5HJ7aWzweFEOcfQ8AiUyYTpMDh9en/0LrvQD3PdmhuHcg5cg3mb1gaguOnrKm3FB2SJoxoKNf6BXQxTHoN66iztiT5XfylXNTw5msFq1uY1mMt5ofmMaBKmgouI5L8WnmkTOtRUix31bALVytFT7FuBOp7Rmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230223; c=relaxed/simple;
	bh=IOabAEWjqaeY6j9kg3frtzHOhg7NAQAwhlq+4NmQc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krHOY2qpjg5AoMymjVJeJC8vc5WHpFUE4yO1hVJZh08xnsnxs8TmNoHunEwmGOJhzWmjd6fnV9S01srlLoptMbf1PHAgHUJultNgt7aXS9eMhidGQozR967n7rO+FM+GAI0J32DokUoK3RgDGuRVZnBC1d9RJWECr0f3kBu3J/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxLtME+IZqWx0DAA--.9219S3;
	Thu, 20 Aug 2026 20:50:12 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c0A+IZqX_QLAA--.6716S3;
	Thu, 20 Aug 2026 20:50:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v4 1/3] module/kallsyms: Rename is_mapping_symbol() to is_ignored_kernel_symbol()
Date: Thu, 20 Aug 2026 20:50:05 +0800
Message-ID: <20260820125007.22943-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260820125007.22943-1-yangtiezhu@loongson.cn>
References: <20260820125007.22943-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx2c0A+IZqX_QLAA--.6716S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFWxuw43Jw45XF45CF4UGFX_yoW5Krykpw
	s8Ca18XFWUAryjgas7Gw4v9ry5Ww4vqr4FkryayrykCFnIq3WvqrZ2kF15uw4UXr4UKF4I
	vrsrZrWSka4fArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc038UUUUU

The helper function is_mapping_symbol() historically checks for both
local labels prefixed with ".L" or "L0" and mapping symbols prefixed
with "$".

Rename it to is_ignored_kernel_symbol() to better reflect this actual
behavior and scope, preventing conceptual confusion.

While at it, update the related non-module files, no functional changes.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/module_symbol.h | 7 +++++--
 kernel/module/kallsyms.c      | 2 +-
 scripts/faddr2line            | 2 +-
 scripts/mod/modpost.h         | 2 +-
 tools/perf/util/symbol.h      | 4 +---
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 574609aced99..698d3db2b37e 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -7,8 +7,11 @@ enum ksym_flags {
 	KSYM_FLAG_GPL_ONLY	= 1 << 0,
 };
 
-/* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline bool is_mapping_symbol(const char *str)
+/*
+ * Ignore local labels (.L*, L0*) and mapping symbols ($*). These symbols are
+ * not useful for the kernel, for example, they should not appear in kallsyms.
+ */
+static inline bool is_ignored_kernel_symbol(const char *str)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f23126d804b2..a52942fd0e07 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -294,7 +294,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		    is_ignored_kernel_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..3aca197d513f 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -243,7 +243,7 @@ __faddr2line() {
 			local cur_sym_elf_size=${fields[2]}
 			local cur_sym_name=${fields[7]:-}
 
-			# is_mapping_symbol(cur_sym_name)
+			# is_ignored_kernel_symbol(cur_sym_name)
 			if [[ ${cur_sym_name} =~ ^(\.L|L0|\$) ]]; then
 				continue
 			fi
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2aecb8f25c87..d9c21d479dd8 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -198,7 +198,7 @@ static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return false;
-	return !is_mapping_symbol(name);
+	return !is_ignored_kernel_symbol(name);
 }
 
 /* symsearch.c */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a71525335703..8b0780046938 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -31,9 +31,7 @@ struct build_id;
 struct perf_env;
 
 /*
- * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() logic.
- * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
- * x86 local symbol prefixes (.L* and L0*).
+ * Ignore local labels and mapping symbols, matching kernel is_ignored_kernel_symbol() logic.
  * Only use this for kernel symbols (kallsyms, ksymbol events, kernel ELF DSOs).
  */
 static inline bool is_ignored_kernel_symbol(const char *str)
-- 
2.42.0

