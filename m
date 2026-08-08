Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3D37E5F2;
	Sat,  8 Aug 2026 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160251; cv=none; b=ca87hbKNB0YtlkPudgiNMV+Q1zXuNZ/nkiDDi7AZjVp0jnnb95CbNfjMoUIh1Jn75VEorPwY+Ujn9N+9MPOZRZ+/QTp8qFaNWWdxpryQfBMnNdPKP/OWfIcshtT1us5Zvb6KujZy957XQKfzz1vqyGvJEpHAQPaw9eoMGzWV5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160251; c=relaxed/simple;
	bh=q2+3PEsVGykUk+VYan1dQHG+8UvSsW+khdw/nOQKUfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyOEb2gklM6jOGqnrmDyWOt/9Dedx1tCA6X2kaYCa2mHvM0t7N5udMBKdQIWxS3I+MANcbgfmAqbCHZnHcF048Prgk5noaa/msN8kUhXJ/jbBjBDTVhdnn3xModIPcQJC74QGVFCdiWPG5r5zUl8uQgOnUbsWGWzH1iZ8h1Y1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxbZtwpHZqq3kLAA--.13370S3;
	Sat, 08 Aug 2026 11:37:20 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxq8RspHZqMe8nAA--.32075S2;
	Sat, 08 Aug 2026 11:37:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] module/kallsyms: Filter out local mapping symbols during module load
Date: Sat,  8 Aug 2026 11:37:15 +0800
Message-ID: <20260808033715.13117-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxq8RspHZqMe8nAA--.32075S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyDXry8Xr13GF1xZFWftFc_yoW5AFWUpr
	4qkws5Xr48Xr15Ka1kuw4qgFyUGrWkW3yagFsxK34fAFn5XFyY9ayxtF1a9w47Arn2kFyI
	yayvv3Waka4UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

The compiler toolchains generate internal local labels on certain
architectures (such as LoongArch) for optimizations and relocations.

While these local labels are filtered out during runtime lookups in
find_kallsyms_symbol(), they still leak into the permanent symbol
tables of loaded modules, because layout_symtab() and add_kallsyms()
do not check for the mapping symbols during layout generation.

Consequently, tracing tools like bpftrace resolve identical addresses
into confusing local labels instead of actual clear C function names.

Fix this by adding is_mapping_symbol() checks directly into the symbol
tracking loops of layout_symtab() and add_kallsyms(). This prevents the
mapping symbols from entering the module's memory symbol arrays at load
time.

Reproduce steps:

1. Set up a LoongArch VM with "-accel kvm":

   $ sudo qemu-system-loongarch64 -serial stdio \
     -machine virt -cpu la464 -smp 4 -m 4G \
     -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd \
     -nodefaults -no-reboot -nographic -accel kvm

2. Use bpftrace to capture kstack when vCPU is scheduled out:

   $ cat trace_sched.bt
   kprobe:kvm:kvm_sched_out
   {
           if (pid == $1) {
                   print(kstack());
           }
   }

   $ sudo bpftrace trace_sched.bt `pgrep -o qemu-system`

Test results:

1. Before this patch (Confusing stack with local labels):

        kvm_sched_out+0
        __schedule+1584
        schedule+48
        .LVL3767+36
        .LVL3801+8
        .LVL285+12
        .LVL425+44
        .LVL1419+20
        kvm_exc_entry+260

2. After this patch (Accurate stack with function names):

        kvm_sched_out+0
        __schedule+1584
        schedule+48
        kvm_vcpu_block+112
        kvm_vcpu_halt+104
        kvm_emu_idle+284
        kvm_handle_gspr+1316
        kvm_handle_exit+456
        kvm_exc_entry+260

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
Based on the latest modules-next branch of
https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

 kernel/module/kallsyms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f23126d804b2..61dd5c014a59 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -130,6 +130,9 @@ void layout_symtab(struct module *mod, struct load_info *info)
 
 	/* Compute total space required for the core symbols' strtab. */
 	for (ndst = i = 0; i < nsrc; i++) {
+		if (is_mapping_symbol(&info->strtab[src[i].st_name]))
+			continue;
+
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
@@ -198,6 +201,10 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	src = kallsyms->symtab;
 	for (ndst = i = 0; i < kallsyms->num_symtab; i++) {
 		kallsyms->typetab[i] = elf_type(src + i, info);
+
+		if (is_mapping_symbol(&kallsyms->strtab[src[i].st_name]))
+			continue;
+
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
-- 
2.42.0

