Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F5E37188B;
	Wed, 12 Aug 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505296; cv=none; b=Kq/COR5sDHyRwPpJPQpkSw00C8T/Q/7dAG1DT4A8ilHe7njWFUl6TY5NT2aMVCK60phYpUxcXJ5AHQ9zg1479+4ed9RXNAbYCYc3F2az0nz7L0W7Z15Ov4yMwAw+bymcWTHWzKk+zXvjBiwqxE5hBj/jEyCGlV5uJkYJW8Z5D2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505296; c=relaxed/simple;
	bh=8n4JAjZF+t8lMEAK3YulchVhkKwuyqy7dA1J4+dqKj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWWnO3WmUQV5VbdON/cZm2f2Bu8dax2HipcjQqHZ1urD2CdVIHU8L5oLCkdY0G7HASdwjo0mL3OlLZt+LLEwINzt4rGebtgWFJ1tt4339DSKaq6EgG2cJitYD8xZS+q4wOo/9GPuJXOqNtGaPAN5gZgpH3oO1OKKNBSaKjSv2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxztJK6HtqPGwAAA--.1277S3;
	Wed, 12 Aug 2026 11:28:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9J6HtqfoUBAA--.10453S3;
	Wed, 12 Aug 2026 11:28:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] module/kallsyms: Rename is_mapping_symbol() to is_local_mapping_symbol()
Date: Wed, 12 Aug 2026 11:28:05 +0800
Message-ID: <20260812032807.15034-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260812032807.15034-1-yangtiezhu@loongson.cn>
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs9J6HtqfoUBAA--.10453S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW7Kw4DurW8uw18Cw18tFc_yoW5GrW8pr
	98Cw48CFWjyr1q9ayxCan2vry5Ww4vgw40kr98Cr97CFnIq3Z2q392kF15u34UXr4UJF48
	WrsxZryfC3W7ArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==

The helper function is_mapping_symbol() historically checks for both
local labels prefixed with ".L" or "L0" and mapping symbols prefixed
with "$".

Rename it to is_local_mapping_symbol() to better reflect this actual
behavior and scope, preventing conceptual confusion.

No functional change.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/module_symbol.h | 4 ++--
 kernel/module/kallsyms.c      | 2 +-
 scripts/faddr2line            | 2 +-
 scripts/mod/modpost.h         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 574609aced99..ca76ed5cb489 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -7,8 +7,8 @@ enum ksym_flags {
 	KSYM_FLAG_GPL_ONLY	= 1 << 0,
 };
 
-/* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline bool is_mapping_symbol(const char *str)
+/* This ignores the intensely annoying "local or mapping symbols" found in ELF files. */
+static inline bool is_local_mapping_symbol(const char *str)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f23126d804b2..a595f8cd29b2 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -294,7 +294,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		    is_local_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..bda4ea20e39e 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -243,7 +243,7 @@ __faddr2line() {
 			local cur_sym_elf_size=${fields[2]}
 			local cur_sym_name=${fields[7]:-}
 
-			# is_mapping_symbol(cur_sym_name)
+			# is_local_mapping_symbol(cur_sym_name)
 			if [[ ${cur_sym_name} =~ ^(\.L|L0|\$) ]]; then
 				continue
 			fi
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2aecb8f25c87..4173fff2788a 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -198,7 +198,7 @@ static inline bool is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return false;
-	return !is_mapping_symbol(name);
+	return !is_local_mapping_symbol(name);
 }
 
 /* symsearch.c */
-- 
2.42.0

