Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936A387569;
	Wed, 12 Aug 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505301; cv=none; b=kDozK0DLODcWcuLTRGGpxsnL0eZnLo8E/BMZuC4b/WYRCVJ/dImpY+9Hd9hn+geN7g71He9vH+rQ9gWe7pGDgN7oisu2ajLRztDOdBwVFTDJB74HB6uTt/QJrFRqPfmB9n8u74truaY2mY0SEZmQvDKyzWNeg1hiItY1W2Jz3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505301; c=relaxed/simple;
	bh=BSAt31KS5ThObbnb9aQj86DJ+YuEIQHjUeIkmYfjQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixiHF5d340BjHoDTzvqt4xx6GRDnnuTkj8587m2NewPVaMCE4KRGeM7p4IYEA3YCIwIJN+EdVlPQ/AO1yH+AstGVbS6mpK2jBLzoE3VhhXMKZ1wkK6Adh0MPIJWMX23tsebxKZPf3fbB6HMVraX8PApxlOqKY9KHHZrhvwf2i/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxKvBP6HtqSmwAAA--.1350S3;
	Wed, 12 Aug 2026 11:28:15 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs9J6HtqfoUBAA--.10453S5;
	Wed, 12 Aug 2026 11:28:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] module/kallsyms: Filter out local and mapping symbols during module load
Date: Wed, 12 Aug 2026 11:28:07 +0800
Message-ID: <20260812032807.15034-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs9J6HtqfoUBAA--.10453S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4xWw48uFWrWFW8ZF47GFX_yoW8XF18pF
	45Cw45GrW8Jr4v9a1DJ3yI9ry5Ga4DWr4akan0k34fAFn8X3W0vr43Kw1Y93y2vr4rGry0
	qan2vayaya4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

The compiler toolchains generate local and mapping symbols on certain
architectures like LoongArch for optimizations and relocations.

While the symbols are already filtered out during runtime lookups via
find_kallsyms_symbol(), they still leak into /proc/kallsyms for loaded
modules because layout_symtab() and add_kallsyms() do not filter them
during load time.

Consequently, tracing tools like bpftrace (which do not perform internal
filtering, unlike perf) resolve identical addresses into confusing local
labels instead of actual clear C function names.

Fix this by integrating the is_local_mapping_symbol() check directly into
the newly introduced is_kept_symbol() helper. This ensures these unneeded
symbols are stripped during module load time, keeping /proc/kallsyms clean
and resulting in accurate call stacks.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/module/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ff8d904afe56..cc2a68956e43 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -89,6 +89,9 @@ static bool is_kept_symbol(struct module *mod, const struct load_info *info,
 	    !src->st_name)
 		return false;
 
+	if (is_local_mapping_symbol(&info->strtab[src->st_name]))
+		return false;
+
 #ifdef CONFIG_KALLSYMS_ALL
 	if (src->st_shndx == info->index.pcpu)
 		return true;
-- 
2.42.0

