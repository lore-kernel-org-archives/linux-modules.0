Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C91446055
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230228; cv=none; b=MNvHOxDtk40S/XcXN0TC7FbMTBpl3fNUdgV6XBMNlnJ5yQbkg0KszfQUHajz+EaDFGsD0zv1/n5N6vEwwu9EVqkgUPXRGR2YuXr9zuiAHF8FzXDazI8nFABGHJOWVmdd2Qup1wcfVaew8CeW9zXIm7rF/P4YreDBHI0Iq4QKFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230228; c=relaxed/simple;
	bh=s/P8N8XO1Npuz7G5tU+wXMQIAUd1ur0fz66U0dNDxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS1o/hQGrqZtxqiyyXdNEOf7e+qkZWuNNqYINuyOzzizIrk/kh7zpefjfpL1DnJeKVhomGW/nIswPABPlzCt4DCg9Vfw1G3z93yifz0JmG0bZ8V/ZLN96bnQ/9RtcxlHr2ksfKwO1H5fN5mUliYGJliL+sUReloNKcXwrrvVYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxOvAF+IZqaB0DAA--.9474S3;
	Thu, 20 Aug 2026 20:50:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c0A+IZqX_QLAA--.6716S5;
	Thu, 20 Aug 2026 20:50:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v4 3/3] module/kallsyms: Ignore local labels and mapping symbols during module load
Date: Thu, 20 Aug 2026 20:50:07 +0800
Message-ID: <20260820125007.22943-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx2c0A+IZqX_QLAA--.6716S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW7Ary5Kw4rZF1xAF48Xwc_yoW8WrykpF
	45Cw45WrW8ZF1kua1DAr4F9ry5G3yDXr4Sgan8K34xArn8t3WrZr13tw1Y9r47Zr43KFy8
	XFs2v39Ivas8ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

The compiler toolchains may generate local labels and mapping symbols on
certain architectures like LoongArch for optimizations and relocations.

While these local labels and mapping symbols are already ignored during
runtime lookups via find_kallsyms_symbol(), they still leak into kallsyms
for loaded modules because layout_symtab() and add_kallsyms() don't ignore
them during load time.

Consequently, tracing tools like bpftrace (which do not perform internal
filtering, unlike perf) resolve identical addresses into confusing local
labels instead of actual clear C function names.

Fix this by integrating the is_ignored_kernel_symbol() check directly into
is_core_symbol(). This ensures these unneeded symbols are stripped during
module load time, keeping /proc/kallsyms clean and resulting in accurate
call stacks.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index d75c9f60d360..1ff8ce857d92 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -89,6 +89,9 @@ static bool is_core_symbol(struct module *mod, const struct load_info *info,
 	    !src->st_name)
 		return false;
 
+	if (is_ignored_kernel_symbol(&info->strtab[src->st_name]))
+		return false;
+
 #ifdef CONFIG_KALLSYMS_ALL
 	if (src->st_shndx == info->index.pcpu)
 		return true;
-- 
2.42.0

