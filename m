Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64038735D;
	Wed, 12 Aug 2026 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505299; cv=none; b=nwEbtZXVF4QCwTXU0r/S6Zl6QYsdzrAMpjjOjZoJ3jW54Os2mDbtnQmzV0pcPp6vBI1w3gvi06RdsZe6JPHjfl3e2umf8Rti4HydK1TK+Wxv1xGNI/su7TvTyHjfKunPpEsGpswjvO/akG4ItQ+XIRVHDRdO2OGijj+ri3E2RDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505299; c=relaxed/simple;
	bh=fOwf4iaXbLgJyxWcHSfYOqpF7fYK180Cfwpuzr/Uojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8GSfcuvl1jqv0+4Hj2wETJRABE0uiBh8HaM1kNiRWcMdUIGwUx6CWbDBav0zNKLz7UFA9Yrlb4NhLUqnajBgZ+2uZFHu2MTnPkKxT9Rhcwm8KfMBAy/tLR6mFXP+B8lyKjIiHCkYFCf92j2iZvUzwIcZqHFoR7xIBXqWDwfoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9NN6HtqRGwAAA--.1376S3;
	Wed, 12 Aug 2026 11:28:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9J6HtqfoUBAA--.10453S4;
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
Subject: [PATCH v3 2/3] module/kallsyms: Refactor current symbol filtering into is_kept_symbol()
Date: Wed, 12 Aug 2026 11:28:06 +0800
Message-ID: <20260812032807.15034-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs9J6HtqfoUBAA--.10453S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFykZF4UZrWDAr4fJw4kXwc_yoW5Kr1Upr
	45C395JrW8Jr4Uuw4xArWY9ay3G34kW3yYg3W3GFWfArn8XFyrX3Wftw1F9FZ3Zr9rWa4r
	tF929Fy3J3W8AFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Currently, the loops in layout_symtab() and add_kallsyms() duplicate the
exact same checks (i == 0 || is_livepatch_module() || is_core_symbol())
to determine whether a symbol should be preserved in the module's core
symbol table.

Rename is_core_symbol() to is_kept_symbol() and move the entire checking
logic inside it, including the special handlers for the first symbol and
livepatch modules.

No functional change.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/module/kallsyms.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index a595f8cd29b2..ff8d904afe56 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -75,23 +75,26 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 	return '?';
 }
 
-static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
-			   unsigned int shnum, unsigned int pcpundx)
+static bool is_kept_symbol(struct module *mod, const struct load_info *info,
+			   unsigned int symnum, const Elf_Sym *src)
 {
 	const Elf_Shdr *sec;
 	enum mod_mem_type type;
 
+	if (symnum == 0 || is_livepatch_module(mod))
+		return true;
+
 	if (src->st_shndx == SHN_UNDEF ||
-	    src->st_shndx >= shnum ||
+	    src->st_shndx >= info->hdr->e_shnum ||
 	    !src->st_name)
 		return false;
 
 #ifdef CONFIG_KALLSYMS_ALL
-	if (src->st_shndx == pcpundx)
+	if (src->st_shndx == info->index.pcpu)
 		return true;
 #endif
 
-	sec = sechdrs + src->st_shndx;
+	sec = info->sechdrs + src->st_shndx;
 	type = sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 	if (!(sec->sh_flags & SHF_ALLOC)
 #ifndef CONFIG_KALLSYMS_ALL
@@ -130,12 +133,11 @@ void layout_symtab(struct module *mod, struct load_info *info)
 
 	/* Compute total space required for the core symbols' strtab. */
 	for (ndst = i = 0; i < nsrc; i++) {
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
-			ndst++;
-		}
+		if (!is_kept_symbol(mod, info, i, src + i))
+			continue;
+
+		strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
+		ndst++;
 	}
 
 	/* Append room for core symbols at end of core part. */
@@ -197,23 +199,21 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	strtab_size = info->core_typeoffs - info->stroffs;
 	src = kallsyms->symtab;
 	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
+		ssize_t ret;
+
 		kallsyms->typetab[i] = elf_type(src + i, info);
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			ssize_t ret;
-
-			mod->core_kallsyms.typetab[ndst] =
-				kallsyms->typetab[i];
-			dst[ndst] = src[i];
-			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			ret = strscpy(s, &kallsyms->strtab[src[i].st_name],
-				      strtab_size);
-			if (ret < 0)
-				break;
-			s += ret + 1;
-			strtab_size -= ret + 1;
-		}
+
+		if (!is_kept_symbol(mod, info, i, src + i))
+			continue;
+
+		mod->core_kallsyms.typetab[ndst] = kallsyms->typetab[i];
+		dst[ndst] = src[i];
+		dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
+		ret = strscpy(s, &kallsyms->strtab[src[i].st_name], strtab_size);
+		if (ret < 0)
+			break;
+		s += ret + 1;
+		strtab_size -= ret + 1;
 	}
 
 	/* Set up to point into init section. */
-- 
2.42.0

