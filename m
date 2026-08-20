Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD391446068
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230224; cv=none; b=SwCevHL6XKXxj7088FH7uTIYad/qc2JYZOlVILsHxRPn0Lz2U+RweOTrMFYpjDPcVrrdIF/pcHdnE9ynkox3iyZsaw53EFl6Qd/3XrnjAXgNMgqj/o3VHcBeQf4OjmnTK17+XAYmLBAbN0XyuU46eaI7aduOHmElcC3EHnEnp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230224; c=relaxed/simple;
	bh=y49LuqZmJHftFq0bCPSvkqgoowolkttaDwtwWEG4BAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id90sTSPmj2k4G+FSOU3Fw3zd26BqoVjF5rf219fzfXoXqfoU7T165Pr2feaGifEWLRAdmbBf3GM/ZNK1/iCDb+kcxM9askeWuMi+2MUL5LvwFdp1rZKxXanRquz/hB2sDW9k0wOhFoE4T/SQrjB5EU5HEUGZqg/jMYR+Tx6uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxdvAE+IZqXx0DAA--.9375S3;
	Thu, 20 Aug 2026 20:50:12 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c0A+IZqX_QLAA--.6716S4;
	Thu, 20 Aug 2026 20:50:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v4 2/3] module/kallsyms: Refactor current symbol filtering into is_core_symbol()
Date: Thu, 20 Aug 2026 20:50:06 +0800
Message-ID: <20260820125007.22943-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx2c0A+IZqX_QLAA--.6716S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF17Wr1kGryDZryxJFWDtrc_yoW5KFyUpr
	45C395GrW8JF48uws7ArWY9ay3G34kW3yYg3W7GFWfAr1DXa4rXw1ft3WF9FZ3Zr9Fga4x
	tF929F9xt3W8JrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

Currently, the loops in layout_symtab() and add_kallsyms() duplicate the
exact same checks (i == 0 || is_livepatch_module() || is_core_symbol())
to determine whether a symbol should be preserved in the module's core
symbol table.

Move the entire checking logic inside is_core_symbol(), including the
special handlers for the first symbol and livepatch modules.

No functional changes.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/kallsyms.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index a52942fd0e07..d75c9f60d360 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -75,23 +75,26 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 	return '?';
 }
 
-static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
-			   unsigned int shnum, unsigned int pcpundx)
+static bool is_core_symbol(struct module *mod, const struct load_info *info,
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
+		if (!is_core_symbol(mod, info, i, src + i))
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
+		if (!is_core_symbol(mod, info, i, src + i))
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

